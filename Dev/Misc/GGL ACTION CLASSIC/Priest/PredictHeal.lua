local A                             = Action
local GetToggle                        = A.GetToggle
local TeamCache                        = A.TeamCache
local Unit                             = A.Unit 
local strOnlyBuilder                = A.strOnlyBuilder
local GetCurrentGCD                    = A.GetCurrentGCD
local HealComm                         = LibStub("LibHealComm-4.0", true)

local TeamCacheFriendly                = TeamCache.Friendly
local GetSpellBonusHealing            = _G.GetSpellBonusHealing
local UnitGUID                        = _G.UnitGUID

local PR                             = A[A.PlayerClass]
local GetHealingTypeByName            = {
    [PR.PrayerofHealing:Info()]        = {"CAST",         "PrayerofHealing"    },
    [PR.LesserHeal:Info()]            = {"CAST",         "LesserHeal"        },
    [PR.Heal:Info()]                = {"CAST",         "Heal"                },
    [PR.GreaterHeal:Info()]            = {"CAST",         "GreaterHeal"        },
    [PR.FlashHeal:Info()]            = {"CAST",         "FlashHeal"            },
    [PR.Renew:Info()]                = {"HOT",         "Renew"                },
    [PR.PowerWordShield:Info()]        = {"HOT",        "PoWS"                }, -- always max rank 
    [PR.HolyNova:Info()]            = {"INSTANT",    "HolyNova"            }, -- always max rank 
}

function A:PredictHeal(unitID, VARIATION, unitGUID)     
    -- @return boolean, number 
    -- Returns true/false, amount of predicted healing up
    local Info                        = GetHealingTypeByName[self:Info()]    
    if not Info then 
        return false, 0 
    end 
    
    local variation                 = VARIATION or 1  
    local category                     = Info[1]
    local spellName                    = Info[2]
    
    -- [[ MANUAL ]] 
    local custom                    
    if spellName ~= "HolyNova" and spellName ~= "PoWS" then 
        custom                         = GetToggle(2, strOnlyBuilder(spellName, self.isRank))    
    else 
        custom                         = GetToggle(2, spellName)
    end 
    
    if custom and custom < 100 then 
        local percent                 = Unit(unitID):HealthPercent()
        return percent <= custom, percent
    end 
    
    -- [[ AUTO ]] 
    local health                    = Unit(unitID):Health()
    local health_max                = Unit(unitID):HealthMax()
    
    -- Switch mode to percentage if real health broken 
    if health <= 0 or health_max <= 0 then 
        local p_health_max             = Unit("player"):HealthMax()
        
        health                        = Unit(unitID):HealthPercent() * p_health_max / 100
        health_max                     = p_health_max
    end 
    
    local health_deficit            = health_max - health
    -- unitID is full health 
    if health_deficit <= 0 then
        -- ByPass HOT 
        if category == "HOT" and Unit("player"):CombatTime() == 0 and Unit(unitID):IsTank() then 
            return true, 0 
        end 
        return false, 0 
    end 
    
    local description                 = self:GetSpellDescription()
    
    local amount                     
    if category == "CAST" then 
        amount                        = ((description[1] + description[2]) / 2) + GetSpellBonusHealing()
    else
        amount                         = description[1] + (spellName ~= "PoWS" and GetSpellBonusHealing() or 0)
    end 
    
    -- HealComm: Modificators of healing 
    local mod_heal, pmod_heal        = 1, 1
    if HealComm then 
        mod_heal                     = HealComm:GetHealModifier(unitGUID or UnitGUID(unitID))
        pmod_heal                     = HealComm:GetPlayerHealingMod(unitGUID or UnitGUID(unitID))
    end 
    
    local cast                        = (category == "CAST" and self:GetSpellCastTime() + GetCurrentGCD()) or (category == "HOT" and description[2] + GetCurrentGCD()) or 0 
    local pre_heal                    = (category == "INSTANT" and 0) or Unit(unitID):GetIncomingHeals(cast, unitGUID)        
    local hps                        = TeamCacheFriendly.Type ~= "raid" and 0 or Unit(unitID):GetHEAL() 
    local dmg                        = Unit(unitID):GetDMG()
    local total                     = (((amount * variation) + (cast * hps)) * pmod_heal * mod_heal) + pre_heal - (cast * dmg) -- pre_heal is already modified by HealComm
    
    -- ByPass HOT category, it will first check by dificit health or if health is enough then predict by damage incoming with healing compare
    if category == "HOT" then 
        return health_deficit >= total or cast * dmg > (((amount * variation) + (cast * hps)) * pmod_heal * mod_heal) + pre_heal, total  -- pre_heal is already modified by HealComm
    else 
        return health_deficit >= total, total 
    end 
end

