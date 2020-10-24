local TMW = TMW
local CNDT = TMW.CNDT
local Env = CNDT.Env
local A = Action
local Unit = A.Unit

local UnitHealthMax, UnitHealth, UnitGetIncomingHeals =
UnitHealthMax, UnitHealth, UnitGetIncomingHeals

local AtonementBuff = 0

function A:PredictHeal(SPELLID, UNIT, VARIATION, ENEMIES)   
    -- Exception penalty for low level units / friendly boss
    local UnitLvL = Unit(UNIT):GetLevel()
    if UnitLvL > 0 and UnitLvL < Unit("player"):GetLevel() - 10 then
        return true, 0
    end     
    
    -- Header
    local variation = (VARIATION and (VARIATION / 100)) or 1
    local enemies = ENEMIES or 0    
    
    local total = 0
    local DMG, HPS = Unit(UNIT):GetDMG(), Unit(UNIT):GetHEAL()     
    local DifficultHP = Unit(UNIT):HealthMax() - Unit(UNIT):Health() 
    
    -- Class things
    -- Discipline
    if Unit("player"):HasSpec(256) then 
        AtonementBuff = Unit(UNIT):HasBuffs(81749, "player", true)
        AtonementBuff = (AtonementBuff > A.GetGCD() + A.GetCurrentGCD() and AtonementBuff) or 0
    elseif AtonementBuff ~= 0 then 
        AtonementBuff = 0
    end 
    
    -- Spells
    if SPELLID == "PenanceHeal" then
        if Unit("player"):CombatTime() == 0 then
            local pre_heal = UnitGetIncomingHeals(UNIT) or 0            
            local Penance = A.GetSpellDescription(47540)[1] * variation
            total = Penance + pre_heal
        else
            local pre_heal = UnitGetIncomingHeals(UNIT) or 0
            local cast = Unit("player"):CastTime(47540) + A.GetCurrentGCD()
            local Penance = A.GetSpellDescription(47540)[1] * variation
            total = Penance + pre_heal + (HPS * cast) - (DMG * cast) 
        end        
    end 
    
    if SPELLID == "PenanceDMG" then
        local pre_heal = UnitGetIncomingHeals(UNIT) or 0
        local cast = Unit("player"):CastTime(47540) + A.GetCurrentGCD()
        local Penance = A.GetSpellDescription(47540)[1] * 0.55 * variation
        total = Penance + pre_heal + (HPS * cast) - (DMG * cast)                
    end 
    
    -- Power Word: Shield
    if SPELLID == "PW:S" then   
        if Unit("player"):CombatTime() == 0 then
            total = 0
        else
            local pre_heal = UnitGetIncomingHeals(UNIT) or 0        
            local PWS = A.GetSpellDescription(17)[1] * variation
            -- Should be without HE_Absorb toggle 
            total = PWS + pre_heal + getAbsorb(UNIT, 17) + (HPS * 15) - (DMG * 15)
        end 
    end 
    
    -- Power Word: Radiance
    if SPELLID == "PW:R" then  
        local pre_heal = UnitGetIncomingHeals(UNIT) or 0   
        local cast = Unit("player"):CastTime(194509) + A.GetCurrentGCD()
        local PWR = A.GetSpellDescription(194509)[1] * variation
        total = PWR + pre_heal + (HPS * cast) - (DMG * cast)                    
    end 
    
    if SPELLID == "ShadowMend" then  
        local pre_heal = UnitGetIncomingHeals(UNIT) or 0   
        local cast = Unit("player"):CastTime(186263) + A.GetCurrentGCD()
        local ShadowMend = A.GetSpellDescription(186263)[1] * variation
        total = ShadowMend + pre_heal + (HPS * cast) - (DMG * cast)               
    end 
    
    if SPELLID == "DivineStar" then               
        total = A.GetSpellDescription(110744)[1] * variation - (DMG * A.GetGCD())         
    end    
    
    if SPELLID == "Halo" then  
        if Unit("player"):CombatTime() == 0 then
            -- Exception to don't hit nearest mobs 
            if TR.PriestVars["AoE30"] and TR.PriestVars["AoE30"] > 0 then 
                total = 88888888888888
            else 
                local pre_heal = UnitGetIncomingHeals(UNIT) or 0                   
                local Halo = A.GetSpellDescription(120517)[1] * variation
                total = Halo + pre_heal
            end 
        else
            local pre_heal = UnitGetIncomingHeals(UNIT) or 0   
            local cast = Unit("player"):CastTime(120517) + A.GetCurrentGCD()
            local Halo = A.GetSpellDescription(120517)[1] 
            total = (Halo * variation) + pre_heal + ((AtonementBuff > cast and Halo * 0.55 * enemies) or 0) + (HPS * cast) -- - (DMG * cast)
        end 
    end 
    
    if SPELLID == "HolyNova" then   
        local HolyNova = A.GetSpellDescription(132157)        
        total = (HolyNova[2] * variation) + ((AtonementBuff > 0 and HolyNova[1] * 0.55 * enemies) or 0)           
    end 
    
    if SPELLID == "ShadowCovenant" then
        local ShadowCovenant = A.GetSpellDescription(204065)
        total = ShadowCovenant[1] * variation + ShadowCovenant[2]  
    end 
    
    -- Holy 
    -- Note about Mastery: Regarding overwrite previous effect by any next spell here is no reason to add that 
    -- Holy Word: Sanctify 
    if SPELLID == "HW:Sanctify" then       
        total = A.GetSpellDescription(34861)[1] * variation 
    end 
    
    -- Holy Word: Serenity 
    if SPELLID == "HW:Serenity" then       
        total = A.GetSpellDescription(2050)[1] * variation 
    end 
    
    -- Circle of Healing 
    if SPELLID == "CircleOfHealing" then       
        total = A.GetSpellDescription(204883)[1] * variation 
    end 
    
    -- Prayer Of Mending    
    if SPELLID == "PrayerOfMending" then   
        local pre_heal = UnitGetIncomingHeals(UNIT) or 0   
        local cast = Unit("player"):CastTime(120517) + A.GetCurrentGCD()
        total = A.GetSpellDescription(33076)[1] * variation + pre_heal + (HPS * cast) -- - (DMG * cast) 
    end 
    
    -- Prayer Of Mending HoT   
    if SPELLID == "PrayerOfMendingHoT" then   
        total = A.GetSpellDescription(33076)[1] * variation 
    end 
    
    -- Prayer of Healing
    if SPELLID == "PrayerOfHealing" then   
        local pre_heal = UnitGetIncomingHeals(UNIT) or 0   
        local cast = Unit("player"):CastTime(596) + A.GetCurrentGCD()
        total = A.GetSpellDescription(596)[1] * variation + pre_heal + (HPS * cast) -- - (DMG * cast) 
    end 
    
    -- Binding Heal
    if SPELLID == "BindingHeal" then   
        local pre_heal = UnitGetIncomingHeals(UNIT) or 0   
        local cast = Unit("player"):CastTime(32546) + A.GetCurrentGCD()
        total = A.GetSpellDescription(32546)[1] * variation + pre_heal + (HPS * cast) -- - (DMG * cast) 
    end 
    
    -- Renew 
    if SPELLID == "Renew" then   
        if Unit("player"):CombatTime() == 0 then 
            total = 0
        else 
            local pre_heal = UnitGetIncomingHeals(UNIT) or 0               
            total = A.GetSpellDescription(139)[2] * variation + pre_heal + (A.GetSpellDescription(139)[1] * 15) -- - (DMG * 15) 
        end 
    end 
    
    -- Flash Heal
    if SPELLID == "FlashHeal" then   
        local pre_heal = UnitGetIncomingHeals(UNIT) or 0   
        local cast = Unit("player"):CastTime(2061) + A.GetCurrentGCD()
        total = A.GetSpellDescription(2061)[1] * variation + pre_heal + (HPS * cast) -- - (DMG * cast) 
    end 
    
    -- Heal 
    if SPELLID == "Heal" then   
        local pre_heal = UnitGetIncomingHeals(UNIT) or 0   
        local cast = Unit("player"):CastTime(2060) + A.GetCurrentGCD()
        total = A.GetSpellDescription(2060)[1] * variation + pre_heal + (HPS * cast) -- - (DMG * cast) 
    end 
    
    -- Apotheosis
    if SPELLID == "Apotheosis" then   
        local pre_heal = UnitGetIncomingHeals(UNIT) or 0   
        local Serenity = A.GetSpellDescription(2050)[1] * variation 
        local Sancify = A.GetSpellDescription(34861)[1] * variation
        total = Serenity + Sancify + pre_heal + (HPS * (A.GetGCD() + A.GetCurrentGCD())) -- - (DMG * cast) 
    end 
    
    -- PvP: Greater Heal 
    if SPELLID == "GreaterHeal" then   
        local pre_heal = UnitGetIncomingHeals(UNIT) or 0  
        local cast = Unit("player"):CastTime(289666) + A.GetCurrentGCD()
        total = Unit(UNIT):HealthMax() * variation + pre_heal + (HPS * cast) - (DMG * cast) 
    end 
    
    -- All 
    -- These spells doesn't relative for increasing heal buffs  
    -- Racials
    if SPELLID == "GiftofNaaru" then
        local pre_heal = UnitGetIncomingHeals(UNIT) or 0
        total = Unit("player"):HealthMax() * 0.2 * variation + (HPS * 5) + pre_heal - (DMG * 5)
    end 
    
    return DifficultHP >= total, total 
end

