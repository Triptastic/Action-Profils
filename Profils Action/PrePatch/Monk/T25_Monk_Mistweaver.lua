local TMW                                     = TMW 

local Action                                 = Action
local TeamCache                                = Action.TeamCache
local EnemyTeam                                = Action.EnemyTeam
local FriendlyTeam                            = Action.FriendlyTeam
local HealingEngine                            = Action.HealingEngine
local LoC                                     = Action.LossOfControl
local Player                                = Action.Player 
local MultiUnits                            = Action.MultiUnits
local UnitCooldown                            = Action.UnitCooldown
local Unit                                    = Action.Unit 
--local Pet                                     = LibStub("PetLibrary")
--local Azerite                                 = LibStub("AzeriteTraits")

local setmetatable                            = setmetatable


Action[ACTION_CONST_MONK_MISTWEAVER] = {
    -- Racial
    ArcaneTorrent                             = Action.Create({ Type = "Spell", ID = 50613     }),
    BloodFury                                 = Action.Create({ Type = "Spell", ID = 20572      }),
    Fireblood                                   = Action.Create({ Type = "Spell", ID = 265221     }),
    AncestralCall                              = Action.Create({ Type = "Spell", ID = 274738     }),
    Berserking                                = Action.Create({ Type = "Spell", ID = 26297    }),
    ArcanePulse                                  = Action.Create({ Type = "Spell", ID = 260364    }),
    QuakingPalm                                  = Action.Create({ Type = "Spell", ID = 107079     }),
    Haymaker                                  = Action.Create({ Type = "Spell", ID = 287712     }), 
    WarStomp                                  = Action.Create({ Type = "Spell", ID = 20549     }),
    BullRush                                  = Action.Create({ Type = "Spell", ID = 255654     }),    
    GiftofNaaru                               = Action.Create({ Type = "Spell", ID = 59544    }),
    Shadowmeld                                  = Action.Create({ Type = "Spell", ID = 58984    }), -- usable in Action Core 
    Stoneform                                  = Action.Create({ Type = "Spell", ID = 20594    }), 
    WilloftheForsaken                          = Action.Create({ Type = "Spell", ID = 7744        }), -- not usable in APL but user can Queue it    
    EscapeArtist                              = Action.Create({ Type = "Spell", ID = 20589    }), -- not usable in APL but user can Queue it
    EveryManforHimself                          = Action.Create({ Type = "Spell", ID = 59752    }), -- not usable in APL but user can Queue it
    -- CrownControl    
    Paralysis                                = Action.Create({ Type = "Spell", ID = 115078    }),
    ParalysisAntiFake                        = Action.Create({ Type = "Spell", ID = 115078, Desc = "[2] Kick", QueueForbidden = true    }),
    LegSweep                                  = Action.Create({ Type = "Spell", ID = 119381    }),
    LegSweepGreen                              = Action.Create({ Type = "SpellSingleColor", ID = 119381, Color = "GREEN", Desc = "[1] CC", QueueForbidden = true }),
    GrappleWeapon                            = Action.Create({ Type = "Spell", ID = 233759, isTalent = true     }),    -- PvP Talent
    SongofChiJi                                = Action.Create({ Type = "Spell", ID = 198898, isTalent = true     }), -- Talent (not usable in APL but user can Queue it)
    RingofPeace                                = Action.Create({ Type = "Spell", ID = 116844, isTalent = true     }), -- Talent (not usable in APL but user can Queue it)
    -- Suppotive    
    Resuscitate                                  = Action.Create({ Type = "Spell", ID = 115178, QueueForbidden = true    }), 
    Reawaken                                  = Action.Create({ Type = "Spell", ID = 212051, QueueForbidden = true    }),
    Provoke                                      = Action.Create({ Type = "Spell", ID = 115546, Desc = "[6] PvP Pets Taunt", QueueForbidden = true    }),
    Detox                                      = Action.Create({ Type = "Spell", ID = 115450    }),
    TigersLust                                     = Action.Create({ Type = "Spell", ID = 116841, isTalent = true    }), -- Talent 
    -- Self Defensives
    FortifyingBrew                            = Action.Create({ Type = "Spell", ID = 243435    }),
    HealingElixir                              = Action.Create({ Type = "Spell", ID = 122281, isTalent = true     }), -- Talent 
    DiffuseMagic                            = Action.Create({ Type = "Spell", ID = 122783, isTalent = true     }), -- Talent 
    DampenHarm                                = Action.Create({ Type = "Spell", ID = 122278, isTalent = true     }), -- Talent 
    -- Burst
    InvokeChiJitheRedCrane                    = Action.Create({ Type = "Spell", ID = 198664, isTalent = true    }), -- Talent AoE heal
    Revival                                    = Action.Create({ Type = "Spell", ID = 115310    }), -- AoE heal 
    LifeCocoon                                = Action.Create({ Type = "Spell", ID = 116849    }),        
    -- Rotation hps      
    ThunderFocusTea                            = Action.Create({ Type = "Spell", ID = 116680    }), -- Small healing tweaker (no gcd)
    RenewingMist                            = Action.Create({ Type = "Spell", ID = 115151    }), 
    EssenceFont                                = Action.Create({ Type = "Spell", ID = 191837    }), 
    Vivify                                      = Action.Create({ Type = "Spell", ID = 116670    }),
    EnvelopingMist                            = Action.Create({ Type = "Spell", ID = 124682    }),    
    SoothingMist                            = Action.Create({ Type = "Spell", ID = 115175    }),
    SummonJadeSerpentStatue                    = Action.Create({ Type = "Spell", ID = 115313, isTalent = true    }), -- Talent
    ChiBurst                                  = Action.Create({ Type = "Spell", ID = 123986, isTalent = true     }), -- Talent 
    ChiWave                                   = Action.Create({ Type = "Spell", ID = 115098, isTalent = true     }),    -- Talent
    ManaTea                                    = Action.Create({ Type = "Spell", ID = 197908, isTalent = true     }),    -- Talent
    RefreshingJadeWind                        = Action.Create({ Type = "Spell", ID = 196725, isTalent = true     }),    -- Talent
    HealingSphere                            = Action.Create({ Type = "Spell", ID = 205234, isTalent = true     }),    -- PvP Talent
    SurgingMist                                = Action.Create({ Type = "Spell", ID = 227344, isTalent = true     }),    -- PvP Talent
    ZenFocusTea                                = Action.Create({ Type = "Spell", ID = 209584, isTalent = true     }),    -- PvP Talent
    -- Rotation dps
    TigerPalm                                = Action.Create({ Type = "Spell", ID = 100780    }), 
    BlackoutKick                            = Action.Create({ Type = "Spell", ID = 100784    }),
    CracklingJadeLightning                      = Action.Create({ Type = "Spell", ID = 117952     }),    
    RisingSunKick                            = Action.Create({ Type = "Spell", ID = 107428     }),    
    SpinningCraneKick                        = Action.Create({ Type = "Spell", ID = 101546     }),    
    WayoftheCrane                            = Action.Create({ Type = "Spell", ID = 216113, isTalent = true     }), -- PvP Talent 
    -- Movememnt    
    Roll                                    = Action.Create({ Type = "Spell", ID = 109132    }),
    ChiTorpedo                                = Action.Create({ Type = "Spell", ID = 115008, isTalent = true    }), -- Talent 
    TranscendenceTransfer                    = Action.Create({ Type = "Spell", ID = 119996    }), -- not usable in APL but user can Queue it
    -- Items
    PotionofReconstitution                     = Action.Create({ Type = "Potion", ID = 168502     }),     
    CoastalManaPotion                        = Action.Create({ Type = "Potion", ID = 152495     }),    
    -- Hidden 
    TigerTailSweep                            = Action.Create({ Type = "Spell", ID = 264348,     isTalent = true, Hidden = true }), -- 4/1 Talent +2y increased range of LegSweep    
    RisingMist                                = Action.Create({ Type = "Spell", ID = 274909,     isTalent = true, Hidden = true }), -- 7/3 Talent "Fistweaving Rotation by damage healing"
    SpiritoftheCrane                        = Action.Create({ Type = "Spell", ID = 210802,     isTalent = true, Hidden = true }), -- 3/2 Talent "Mana regen by BlackoutKick"
    Innervate                                = Action.Create({ Type = "Spell", ID = 29166,     Hidden = true }), -- Buff condition for Mana Tea and Mana Saving
    TeachingsoftheMonastery                    = Action.Create({ Type = "Spell", ID = 202090,     Hidden = true }), -- Buff condition for Blackout Kick
}

Action:CreateEssencesFor(ACTION_CONST_MONK_MISTWEAVER)
local A = setmetatable(Action[ACTION_CONST_MONK_MISTWEAVER], { __index = Action })

local Temp                                     = {
    TotalAndPhys                            = {"TotalImun", "DamagePhysImun"},
    TotalAndPhysKick                        = {"TotalImun", "DamagePhysImun", "KickImun"},
    TotalAndPhysAndCC                        = {"TotalImun", "DamagePhysImun", "CCTotalImun"},
    TotalAndPhysAndStun                     = {"TotalImun", "DamagePhysImun", "StunImun"},
    TotalAndPhysAndCCAndStun                 = {"TotalImun", "DamagePhysImun", "CCTotalImun", "StunImun"},
    TotalAndMag                                = {"TotalImun", "DamageMagicImun"},
}

local GetTotemInfo, IsMouseButtonDown, UnitIsUnit = 
GetTotemInfo, IsMouseButtonDown, UnitIsUnit

local function IsSchoolFree()
    return LoC:IsMissed("SILENCE") and LoC:Get("SCHOOL_INTERRUPT", "NATURE") == 0
end 

-- [1] CC AntiFake Rotation
local function AntiFakeStun(unit) 
    return 
    A.IsUnitEnemy(unit) and  
    Unit(unit):GetRange() <= 5 + (A.TigerTailSweep:IsSpellLearned() and 2 or 0) and 
    Unit(unit):IsControlAble("stun", 0) and 
    A.LegSweepGreen:AbsentImun(unit, Temp.TotalAndPhysAndCCAndStun, true)          
end 
A[1] = function(icon)    
    if     A.LegSweepGreen:IsReady(nil, nil, nil, true) and 
    (
        AntiFakeStun("mouseover") or 
        AntiFakeStun("target") or 
        AntiFakeStun("targettarget") or 
        (
            not A.IsUnitEnemy("mouseover") and 
            not A.IsUnitEnemy("target") and             
            not A.IsUnitEnemy("targettarget") and            
            (
                (A.IsInPvP and EnemyTeam():PlayersInRange(1, 5 + (A.TigerTailSweep:IsSpellLearned() and 2 or 0))) or 
                (not A.IsInPvP and MultiUnits:GetByRange(5 + (A.TigerTailSweep:IsSpellLearned() and 2 or 0), 1) >= 1)
            )
        )
    )
    then 
        return A.LegSweepGreen:Show(icon)         
    end                                                                     
end

-- [2] Kick AntiFake Rotation
A[2] = function(icon)        
    local unit
    if A.IsUnitEnemy("mouseover") then 
        unit = "mouseover"
    elseif A.IsUnitEnemy("target") then 
        unit = "target"
    elseif A.IsUnitEnemy("targettarget") then 
        unit = "targettarget"
    end 
    
    if unit then         
        local total, sleft, _, _, _, notKickAble = Unit(unit):CastTime()
        if sleft > 0 then                                     
            if A.ParalysisAntiFake:IsReady(unit, nil, nil, isSoothingMistCasting) and A.ParalysisAntiFake:AbsentImun(unit, Temp.TotalAndPhysAndCC, true) and Unit(unit):IsControlAble("incapacitate", 0) then
                return A.ParalysisAntiFake:Show(icon)                  
            end 
            
            -- Racials 
            if A.QuakingPalm:IsRacialReadyP(unit, nil, nil, true) then 
                return A.QuakingPalm:Show(icon)
            end 
            
            if A.Haymaker:IsRacialReadyP(unit, nil, nil, true) then 
                return A.Haymaker:Show(icon)
            end 
            
            if A.WarStomp:IsRacialReadyP(unit, nil, nil, true) then 
                return A.WarStomp:Show(icon)
            end 
            
            if A.BullRush:IsRacialReadyP(unit, nil, nil, true) then 
                return A.BullRush:Show(icon)
            end                         
        end 
    end                                                                                 
end

-----------------------------------------
--                 ROTATION  
-----------------------------------------
--[[
local function ChiJi()
    -- InvokeChiJitheRedCrane
    for i = 1, MAX_TOTEMS do 
        local have, name, start, duration = GetTotemInfo(i)
        if duration and duration == 25 then 
            return duration - (TMW.time - start)
        end 
    end 
    return 0
end
]]
-- If some one will find better way how to check range let me know
-- I know here is a way like by 'focus' statue but conception of this profile what user will have in 'focus' something else instead of trash it by statue 
-- Not really accurate if player will walking like circle around statue or will decide move forward and then backward 
local JadeSerpentStatue = {
    Total = 0,         -- summary yards moved since used statue
    Start = 0,         -- timestamp moving started 
    StartSpeed = 0, -- in % to reduce / increase range by slowly / faster moving 
}
function JadeSerpentStatue.GetDuration()
    -- SummonJadeSerpentStatue
    for i = 1, MAX_TOTEMS do 
        local have, name, start, duration = GetTotemInfo(i)
        if duration and duration >= 900 then 
            return duration - (TMW.time - start)
        end 
    end 
    return 0
end
JadeSerpentStatue.GetDuration = A.MakeFunctionCachedStatic(JadeSerpentStatue.GetDuration)

function JadeSerpentStatue.GetRange()    
    -- @return number (yards)
    -- Formula:
    -- 40y = 6 sec          =>     6.65y/1sec = 100%    
    if JadeSerpentStatue.GetDuration() > 0 then         
        local moving_current = 0
        -- If still moving 
        if JadeSerpentStatue.Start > 0 then 
            -- Time moving * moving speed = yards moving 
            moving_current = (TMW.time - JadeSerpentStatue.Start) * (JadeSerpentStatue.StartSpeed * 6.65 / 100)            
        end 
        
        return JadeSerpentStatue.Total + moving_current 
    end 
    return math.huge
end 

function JadeSerpentStatue.Reset()
    if Unit("player"):CombatTime() == 0 then 
        JadeSerpentStatue.Total = 0 
        JadeSerpentStatue.Start = 0
        JadeSerpentStatue.StartSpeed = 0
    end 
end 

A.Listener:Add("MONK_MW_STATUERANGE", "UNIT_SPELLCAST_SUCCEEDED", function(...)
        local source, _, spellID = ...
        if A.IamHealer and (source == "player" or source == "pet") and (spellID == A.SummonJadeSerpentStatue.ID or A.GetSpellInfo(spellID) == A.SummonJadeSerpentStatue:Info()) and JadeSerpentStatue.GetDuration() > 0 then 
            JadeSerpentStatue.StartSpeed = Unit("player"):GetCurrentSpeed()
            JadeSerpentStatue.Total = 0        
            
            if JadeSerpentStatue.StartSpeed > 0 then             
                JadeSerpentStatue.Start = TMW.time 
            else 
                JadeSerpentStatue.Start = 0
            end 
        end 
end)

-- I added this because channling of CracklingJadeLightning triggers PLAYER_STARTED_MOVING and PLAYER_STOPPED_MOVING for unknown reason why 
local MovingSkipByChannel = false 
A.Listener:Add("MONK_MW_CHANNELING", "UNIT_SPELLCAST_CHANNEL_START", function(...) 
        if A.IamHealer then 
            local unitID, spellID = ...
            if unitID == "player" and A.CracklingJadeLightning.ID == spellID then 
                MovingSkipByChannel = true 
            end 
        end 
end)

A.Listener:Add("MONK_MW_CHANNELING", "UNIT_SPELLCAST_CHANNEL_STOP", function(...) 
        if A.IamHealer then 
            local unitID, spellID = ...
            if unitID == "player" and A.CracklingJadeLightning.ID == spellID then 
                MovingSkipByChannel = false 
            end 
        end 
end)

A.Listener:Add("MONK_MW_STATUERANGE", "PLAYER_STARTED_MOVING", function(...)
        if A.IamHealer and not MovingSkipByChannel then 
            JadeSerpentStatue.StartSpeed = Unit("player"):GetMaxSpeed()
            
            if JadeSerpentStatue.GetDuration() > 0 then 
                JadeSerpentStatue.Start = TMW.time
            else 
                JadeSerpentStatue.Start = 0
            end 
        end 
end)

A.Listener:Add("MONK_MW_STATUERANGE", "PLAYER_STOPPED_MOVING", function()
        if A.IamHealer and not MovingSkipByChannel then 
            if JadeSerpentStatue.GetDuration() > 0 then 
                local move_done = 0
                if JadeSerpentStatue.Start > 0 then 
                    move_done = (TMW.time - JadeSerpentStatue.Start) * (JadeSerpentStatue.StartSpeed * 6.65 / 100)    
                end 
                JadeSerpentStatue.Total = JadeSerpentStatue.Total + move_done
            end 
            JadeSerpentStatue.Start = 0         
        end 
end)

A.Listener:Add("MONK_MW_STATUERANGE", "PLAYER_ENTERING_WORLD",             JadeSerpentStatue.Reset)
A.Listener:Add("MONK_MW_STATUERANGE", "ACTIVE_TALENT_GROUP_CHANGED",     JadeSerpentStatue.Reset)
A.Listener:Add("MONK_MW_STATUERANGE", "PLAYER_TALENT_UPDATE",             JadeSerpentStatue.Reset)
A.Listener:Add("MONK_MW_STATUERANGE", "PLAYER_SPECIALIZATION_CHANGED",     JadeSerpentStatue.Reset)

local function IsEnoughHPS(unit)
    return Unit("player"):GetHPS() > Unit(unit):GetDMG()
end 

local function IsSaveManaPhase()
    if not A.IsInPvP and A.GetToggle(2, "ManaManagement") and Unit("player"):HasBuffs(A.Innervate.ID) == 0 then 
        for i = 1, MAX_BOSS_FRAMES do 
            if Unit("boss" .. i):IsExists() and not Unit("boss" .. i):IsDead() and Unit("player"):PowerPercent() < Unit("boss" .. i):HealthPercent() then 
                return true 
            end 
        end 
    end 
    return Unit("player"):PowerPercent() < 20 
end 
IsSaveManaPhase = A.MakeFunctionCachedStatic(IsSaveManaPhase)

-- Cached parts 
-- PvP: Balance Solar Interrupt 
UnitCooldown:Register("arena", 78675, 60) 
-- PvP: Mage Counterspell
UnitCooldown:Register("arena", 2139, 24)
local function CanZenFocusTea(mode, isSoothingMistCasting)
    if A.IsInPvP and A.ZenFocusTea:IsReady(nil, nil, nil, isSoothingMistCasting) and Unit("player"):HasBuffs(A.ZenFocusTea.ID, true) == 0 then 
        -- If melee is around (doesn't tracking their kick but anyway)
        if not mode and EnemyTeam("DAMAGER_MELEE"):GetUnitID(15) ~= "none" then 
            return true 
        end 
        
        -- Catch Balance Interrupt if enemy in burst or while rooted
        if UnitCooldown:GetCooldown("arena", 78675) == 0 then 
            local UnitBalance = EnemyTeam("DAMAGER_RANGE"):GetUnitID(40, 102)         
            if UnitBalance ~= "none" and Unit(UnitBalance):InCC() == 0 and Unit("player"):HasBuffs("Reflect") == 0 then
                -- If rooted 
                if mode == "CATCH" and LoC:Get("ROOT") > 0 then 
                    return true   
                end 
                -- If bursting 
                if not mode and (EnemyTeam("DAMAGER"):GetBuffs("DamageBuffs", 40) > 0 or FriendlyTeam():GetTTD(1, 8)) then 
                    return true 
                end 
            end 
        end 
        
        -- Catch Mage Interrupt if enemy in burst or through Blink / Shrimmer 
        if not mode and UnitCooldown:GetCooldown("arena", 2139) == 0 then 
            local UnitMage = EnemyTeam("DAMAGER_RANGE"):GetUnitID(60, {62, 63, 64})
            if UnitMage ~= "none" and Unit(UnitMage):InCC() == 0 and Unit("player"):HasBuffs("Reflect") == 0 then
                -- If Blink / Shrimmer  
                if Unit(UnitMage):GetRange() > 40 and Unit(UnitMage):GetBlinkOrShrimmer() <= 1.5 then 
                    return true   
                end 
                -- If bursting 
                if EnemyTeam("DAMAGER"):GetBuffs("DamageBuffs", 40) > 0 or FriendlyTeam():GetTTD(1, 8) then 
                    return true 
                end 
            end 
        end 
    end 
    return false 
end 
CanZenFocusTea = A.MakeFunctionCachedDynamic(CanZenFocusTea)

local function SelfDefensives()
    if Unit("player"):CombatTime() == 0 then 
        return 
    end 
    
    if CanZenFocusTea("CATCH", true) then 
        return A.ZenFocusTea
    end 
    
    local HealingElixir = A.GetToggle(2, "HealingElixir")
    if     HealingElixir >= 0 and A.HealingElixir:IsReady("player", nil, nil, true) and IsSchoolFree() and
    (
        (     -- Auto 
            HealingElixir >= 85 and 
            (
                Unit("player"):HealthPercent() <= 50 or
                (                        
                    Unit("player"):HealthPercent() < 70 and 
                    A.HealingElixir:GetSpellChargesFrac() > 1.1
                )
            )
        ) or 
        (    -- Custom
            HealingElixir < 85 and 
            Unit("player"):HealthPercent() <= HealingElixir
        )
    ) 
    then 
        return A.HealingElixir
    end 
    
    local DampenHarm = A.GetToggle(2, "DampenHarm")
    if     DampenHarm >= 0 and A.DampenHarm:IsReady("player", nil, nil, true) and
    (
        (     -- Auto 
            DampenHarm >= 100 and 
            (
                -- HP lose per sec >= 20
                Unit("player"):GetDMG() * 100 / Unit("player"):HealthMax() >= 20 or 
                Unit("player"):GetRealTimeDMG() >= Unit("player"):HealthMax() * 0.25 or 
                -- TTD 
                Unit("player"):TimeToDieX(25) < 3 or 
                (
                    A.IsInPvP and 
                    (
                        Unit("player"):UseDeff() or 
                        (
                            Unit("player", 5):HasFlags() and 
                            Unit("player"):GetRealTimeDMG() > 0 and 
                            Unit("player"):IsFocused() 
                        )
                    )
                )
            ) and 
            Unit("player"):HasBuffs("DeffBuffs", true) == 0
        ) or 
        (    -- Custom
            DampenHarm < 100 and 
            Unit("player"):HealthPercent() <= DampenHarm
        )
    ) 
    then 
        return A.DampenHarm
    end 
    
    local DiffuseMagic = A.GetToggle(2, "DiffuseMagic")
    if     DiffuseMagic >= 0 and A.DiffuseMagic:IsReady("player", nil, nil, true) and
    (
        (     -- Auto 
            DiffuseMagic >= 100 and 
            Unit("player"):TimeToDieMagicX(35) < 4 and 
            -- Magic Damage still appear
            Unit("player"):GetRealTimeDMG(4) > 0 and 
            Unit("player"):HasBuffs("DeffBuffsMagic") == 0
        ) or 
        (    -- Custom
            DiffuseMagic < 100 and 
            Unit("player"):HealthPercent() <= DiffuseMagic
        )
    ) 
    then 
        return A.DiffuseMagic
    end 
    
    local FortifyingBrew = A.GetToggle(2, "FortifyingBrew")
    if     FortifyingBrew >= 0 and A.FortifyingBrew:IsReady("player", nil, nil, true) and 
    (
        (     -- Auto 
            FortifyingBrew >= 100 and 
            (
                (
                    not A.IsInPvP and 
                    Unit("player"):HealthPercent() < 40 and 
                    Unit("player"):TimeToDieX(20) < 6 
                ) or 
                (
                    A.IsInPvP and 
                    (
                        Unit("player"):UseDeff() or 
                        (
                            Unit("player", 5):HasFlags() and 
                            Unit("player"):GetRealTimeDMG() > 0 and 
                            Unit("player"):IsFocused(nil, true)                                 
                        )
                    )
                )
            ) and 
            Unit("player"):HasBuffs("DeffBuffs", true) == 0
        ) or 
        (    -- Custom
            FortifyingBrew < 100 and 
            Unit("player"):HealthPercent() <= FortifyingBrew
        )
    ) 
    then 
        return A.FortifyingBrew
    end 
    
    -- Stoneform on deffensive
    local Stoneform = A.GetToggle(2, "Stoneform")
    if     Stoneform >= 0 and A.Stoneform:IsRacialReadyP("player", nil, nil, true) and 
    (
        (     -- Auto 
            Stoneform >= 100 and 
            (
                (
                    not A.IsInPvP and                         
                    Unit("player"):TimeToDieX(65) < 3 
                ) or 
                (
                    A.IsInPvP and 
                    (
                        Unit("player"):UseDeff() or 
                        (
                            Unit("player", 5):HasFlags() and 
                            Unit("player"):GetRealTimeDMG() > 0 and 
                            Unit("player"):IsFocused(nil, true)                                 
                        )
                    )
                )
            ) 
        ) or 
        (    -- Custom
            Stoneform < 100 and 
            Unit("player"):HealthPercent() <= Stoneform
        )
    ) 
    then 
        return A.Stoneform
    end     
    
    -- Stoneform on self dispel (only PvE)
    if A.Stoneform:AutoRacial("player", true, nil, true) and not A.IsInPvP and A.AuraIsValid("player", "UseDispel", "Dispel") then 
        return A.Stoneform
    end 
end 

local function Interrupts(unit, isSoothingMistCasting)
    local useKick, useCC, useRacial = A.InterruptIsValid(unit, "TargetMouseover")
    
    if useCC and A.Paralysis:IsReady(unit, nil, nil, isSoothingMistCasting) and A.Paralysis:AbsentImun(unit, Temp.TotalAndPhysAndCC, true) and Unit(unit):IsControlAble("incapacitate", 0) then 
        return A.Paralysis              
    end             
    
    if useRacial and A.QuakingPalm:AutoRacial(unit, nil, nil, isSoothingMistCasting) then 
        return A.QuakingPalm
    end 
    
    if useRacial and A.Haymaker:AutoRacial(unit, nil, nil, isSoothingMistCasting) then 
        return A.Haymaker
    end 
    
    if useRacial and A.WarStomp:AutoRacial(unit, nil, nil, isSoothingMistCasting) then 
        return A.WarStomp
    end 
    
    if useRacial and A.BullRush:AutoRacial(unit, nil, nil, isSoothingMistCasting) then 
        return A.BullRush
    end      
    
    if useCC and A.LegSweep:IsReady(unit, true, nil, isSoothingMistCasting) and Unit(unit):GetRange() <= 5 + (A.TigerTailSweep:IsSpellLearned() and 2 or 0) and Unit(unit):IsCastingRemains() > A.GetCurrentGCD() + 0.1 and A.LegSweep:AbsentImun(unit, Temp.TotalAndPhysAndCCAndStun, true) and Unit(unit):IsControlAble("stun", 0) then
        return A.LegSweep     
    end 
end 
Interrupts = A.MakeFunctionCachedDynamic(Interrupts)

local function CanRevival(isSoothingMistCasting)
    if A.Revival:IsReady(unit, true, nil, isSoothingMistCasting) and IsSchoolFree() then 
        local RevivalHP = A.GetToggle(2, "Revival")
        local RevivalUnits = A.GetToggle(2, "RevivalUnits") 
        local totalMembers = HealingEngine.GetMembersAll()
        -- Auto Counter
        if RevivalUnits > 40 then 
            RevivalUnits = HealingEngine.GetMinimumUnits(1)
            -- Reduce size in raid by 20%
            if RevivalUnits > 5 then 
                RevivalUnits = RevivalUnits - (#totalMembers * 0.2)
            end 
            -- If user typed counter higher than max available members 
        elseif RevivalUnits >= TeamCache.Friendly.Size then 
            RevivalUnits = TeamCache.Friendly.Size
        end 
        
        if RevivalUnits < 3 and not A.IsInPvP then 
            return false 
        end 
        
        local counter = 0 
        for i = 1, #totalMembers do 
            -- Auto HP 
            if RevivalHP >= 100 and A.Revival:PredictHeal("Revival", totalMembers[i].Unit, 400) then 
                counter = counter + 1
            end 
            
            -- Custom HP 
            if RevivalHP < 100 and totalMembers[i].HP <= RevivalHP then 
                counter = counter + 1
            end 
            
            if counter >= RevivalUnits then 
                return true 
            end 
        end 
    end 
    return false 
end 
CanRevival = A.MakeFunctionCachedStatic(CanRevival)

local function CanInvokeChiJitheRedCrane(isSoothingMistCasting)
    if A.InvokeChiJitheRedCrane:IsReady(unit, true, nil, isSoothingMistCasting) and IsSchoolFree() then 
        local InvokeChiJitheRedCraneHP = A.GetToggle(2, "InvokeChiJitheRedCrane")
        local InvokeChiJitheRedCraneUnits = A.GetToggle(2, "InvokeChiJitheRedCraneUnits") 
        local totalMembers = HealingEngine.GetMembersAll()
        -- Auto Counter
        if InvokeChiJitheRedCraneUnits > 40 then 
            InvokeChiJitheRedCraneUnits = HealingEngine.GetMinimumUnits(1)
            -- Reduce size in raid by 35%
            if InvokeChiJitheRedCraneUnits > 5 then 
                InvokeChiJitheRedCraneUnits = InvokeChiJitheRedCraneUnits - (#totalMembers * 0.35)
            end 
            -- If user typed counter higher than max available members 
        elseif InvokeChiJitheRedCraneUnits >= TeamCache.Friendly.Size then 
            InvokeChiJitheRedCraneUnits = TeamCache.Friendly.Size
        end 
        
        if InvokeChiJitheRedCraneUnits < 3 and not A.IsInPvP then 
            return false 
        end 
        
        local counter = 0 
        for i = 1, #totalMembers do 
            -- Auto HP 
            if InvokeChiJitheRedCraneHP >= 100 and A.InvokeChiJitheRedCrane:PredictHeal("InvokeChiJitheRedCrane", totalMembers[i].Unit, 1500) then 
                counter = counter + 1
            end 
            
            -- Custom HP 
            if InvokeChiJitheRedCraneHP < 100 and totalMembers[i].HP <= InvokeChiJitheRedCraneHP then 
                counter = counter + 1
            end 
            
            if counter >= InvokeChiJitheRedCraneUnits then 
                return true 
            end 
        end 
    end 
    return false 
end 
CanInvokeChiJitheRedCrane = A.MakeFunctionCachedStatic(CanInvokeChiJitheRedCrane)

local function CanEssenceFont(isSoothingMistCasting)
    if A.EssenceFont:IsReady(unit, true, nil, isSoothingMistCasting) and IsSchoolFree() then 
        local EssenceFontHP = A.GetToggle(2, "EssenceFont")
        local EssenceFontUnits = A.GetToggle(2, "EssenceFontUnits") 
        local totalMembers = HealingEngine.GetMembersAll()
        -- Auto Counter
        if EssenceFontUnits > 6 then 
            EssenceFontUnits = HealingEngine.GetMinimumUnits(IsSaveManaPhase() and 0 or 1, 6)
        end
        
        if EssenceFontUnits < 3 and not A.IsInPvP then 
            return false 
        end 
        
        local counter = 0 
        for i = 1, #totalMembers do 
            if Unit(totalMembers[i].Unit):GetRange() <= 30 then 
                -- Auto HP 
                if EssenceFontHP >= 100 and A.EssenceFont:PredictHeal("EssenceFont", totalMembers[i].Unit) then 
                    counter = counter + 1
                end 
                
                -- Custom HP 
                if EssenceFontHP < 100 and totalMembers[i].HP <= EssenceFontHP then 
                    counter = counter + 1
                end 
                
                if counter >= EssenceFontUnits then 
                    return true 
                end 
            end 
        end 
    end 
    return false 
end 
CanEssenceFont = A.MakeFunctionCachedStatic(CanEssenceFont)

local function CanRefreshingJadeWind(isSoothingMistCasting)
    if A.RefreshingJadeWind:IsReady(unit, true, nil, isSoothingMistCasting) and IsSchoolFree() then 
        local totalMembers = HealingEngine.GetMembersAll()
        local RefreshingJadeWindUnits = HealingEngine.GetMinimumUnits(2, 4)
        
        if RefreshingJadeWindUnits < 2 and not A.IsInPvP then 
            return false 
        end 
        
        local counter = 0 
        for i = 1, #totalMembers do 
            if Unit(totalMembers[i].Unit):GetRange() <= 10 then 
                if A.RefreshingJadeWind:PredictHeal("RefreshingJadeWind", totalMembers[i].Unit) then 
                    counter = counter + 1
                end 
                
                if counter >= RefreshingJadeWindUnits then 
                    return true 
                end 
            end 
        end 
    end 
    return false 
end
CanRefreshingJadeWind = A.MakeFunctionCachedStatic(CanRefreshingJadeWind)

local function CanChiWave(isSoothingMistCasting)
    if A.ChiWave:IsReady(unit, true, nil, isSoothingMistCasting) and IsSchoolFree() then 
        local totalMembers = HealingEngine.GetMembersAll()
        local ChiWaveUnits = HealingEngine.GetMinimumUnits(2, 4)
        
        if ChiWaveUnits < 2 and not A.IsInPvP then 
            return false 
        end 
        
        local counter = 0 
        for i = 1, #totalMembers do 
            if Unit(totalMembers[i].Unit):GetRange() <= 25 then 
                if A.ChiWave:PredictHeal("ChiWave", totalMembers[i].Unit) then 
                    counter = counter + 1
                end 
                
                if counter >= ChiWaveUnits then 
                    return true 
                end 
            end 
        end 
    end 
    return false 
end 
CanChiWave = A.MakeFunctionCachedStatic(CanChiWave)

local function CanChiBurst(isSoothingMistCasting)
    if not Player:IsMoving() and A.ChiBurst:IsReady(unit, true, nil, isSoothingMistCasting) and IsSchoolFree() then 
        local totalMembers = HealingEngine.GetMembersAll()
        local ChiBurstUnits = HealingEngine.GetMinimumUnits(2, 4)
        
        if ChiBurstUnits < 2 and not A.IsInPvP then 
            return false 
        end 
        
        local counter = 0 
        for i = 1, #totalMembers do 
            if Unit(totalMembers[i].Unit):GetRange() <= 40 then 
                if A.ChiBurst:PredictHeal("ChiBurst", totalMembers[i].Unit) then 
                    counter = counter + 1
                end 
                
                if counter >= ChiBurstUnits then 
                    return true 
                end 
            end 
        end 
    end 
    return false 
end 
CanChiBurst = A.MakeFunctionCachedStatic(CanChiBurst)

local StopCast = false 
-- [3] Single Rotation
A[3] = function(icon, isMulti)
    local unit                     = "player"
    local isMoving                 = Player:IsMoving()
    local isSoothingMistCasting = Unit(unit):IsCastingRemains(A.SoothingMist.ID) > 0
    local inMelee                 = false
    
    local function DamageRotation(unit)
        inMelee = A.TigerPalm:IsInRange(unit)
        
        -- Purge
        if A.ArcaneTorrent:AutoRacial(unit, nil, nil, isSoothingMistCasting) then 
            return A.ArcaneTorrent:Show(icon)
        end             
        
        -- Interrupts
        local Interrupt = Interrupts(unit, isSoothingMistCasting)
        if Interrupt then 
            return Interrupt:Show(icon)
        end         
        
        -- PvP CrownControl 
        if A.GrappleWeaponIsReady(unit, false, isSoothingMistCasting) then 
            return A.GrappleWeapon:Show(icon)
        end 
        
        -- PvP CrownControl (Enemy Healer)
        if A.IsInPvP then 
            local EnemyHealerUnitID = EnemyTeam("HEALER"):GetUnitID(5 + (A.TigerTailSweep:IsSpellLearned() and 2 or 0))
            
            if EnemyHealerUnitID ~= "none" and A.LegSweep:IsReady(EnemyHealerUnitID, true, nil, isSoothingMistCasting) and A.LegSweep:AbsentImun(EnemyHealerUnitID, Temp.TotalAndPhysAndCCAndStun, true) and Unit(EnemyHealerUnitID):IsControlAble("stun", 0) and Unit(EnemyHealerUnitID):InCC() <= A.GetCurrentGCD() then
                return A.LegSweep:Show(icon)     
            end 
        end 
        
        -- Bursting 
        if A.BurstIsON(unit) and inMelee and A.AbsentImun(nil, unit, Temp.TotalAndPhys) then 
            if A.WayoftheCrane:IsReady(unit, true, nil, isSoothingMistCasting) then 
                return A.WayoftheCrane:Show(icon)
            end 
            
            if Unit(unit):HealthPercent() <= A.GetToggle(2, "RacialBurstDamaging") then 
                if A.BloodFury:AutoRacial(unit, nil, nil, isSoothingMistCasting) then 
                    return A.BloodFury:Show(icon)
                end 
                
                if A.Fireblood:AutoRacial(unit, nil, nil, isSoothingMistCasting) then 
                    return A.Fireblood:Show(icon)
                end 
                
                if A.AncestralCall:AutoRacial(unit, nil, nil, isSoothingMistCasting) then 
                    return A.AncestralCall:Show(icon)
                end 
                
                if A.Berserking:AutoRacial(unit, nil, nil, isSoothingMistCasting) then 
                    return A.Berserking:Show(icon)
                end 
            end 
        end
        
        -- Trinkets 
        if inMelee and A.AbsentImun(nil, unit, Temp.TotalAndPhys) and Unit(unit):HealthPercent() <= A.GetToggle(2, "TrinketBurstDamaging") then 
            if A.Trinket1:IsReady(unit, nil, nil, isSoothingMistCasting) and A.Trinket1:GetItemCategory() ~= "DEFF" then 
                return A.Trinket1:Show(icon)
            end 
            
            if A.Trinket2:IsReady(unit, nil, nil, isSoothingMistCasting) and A.Trinket2:GetItemCategory() ~= "DEFF" then 
                return A.Trinket2:Show(icon)
            end     
        end     
        
        -- Rotation 
        if A.RisingSunKick:IsReady(unit, nil, nil, isSoothingMistCasting) and A.RisingSunKick:AbsentImun(unit, Temp.TotalAndPhys) then 
            if A.RisingMist:IsSpellLearned() and A.ThunderFocusTea:IsReady("player", true, nil, isSoothingMistCasting) and Unit("player"):HasBuffs(A.ThunderFocusTea.ID, true) == 0 then
                return A.ThunderFocusTea:Show(icon)
            end 
            return A.RisingSunKick:Show(icon)
        end 
        
        if A.BlackoutKick:IsReady(unit, nil, nil, isSoothingMistCasting) and A.BlackoutKick:AbsentImun(unit, Temp.TotalAndPhys) and Unit("player"):HasBuffsStacks(A.TeachingsoftheMonastery.ID, true) >= 3 then 
            return A.BlackoutKick:Show(icon)
        end 
        
        if A.SpiritoftheCrane:IsSpellLearned() and A.TigerPalm:IsReady(unit, nil, nil, isSoothingMistCasting) and A.TigerPalm:AbsentImun(unit, Temp.TotalAndPhys) and Unit("player"):HasBuffsStacks(A.TeachingsoftheMonastery.ID, true) < 3 then 
            return A.TigerPalm:Show(icon)
        end 
        
        if     not isMoving and Unit("player"):CombatTime() > 2 and (isMulti or A.GetToggle(2, "AoE")) and A.ChiBurst:IsReady(unit, true, nil, isSoothingMistCasting) and A.ChiBurst:AbsentImun(unit, Temp.TotalAndMag) and IsSchoolFree() and Unit(unit):GetRange() <= 40 and 
        (
            not A.IsInPvP or 
            not EnemyTeam("HEALER"):IsBreakAble(40)                
        )
        then 
            return A.ChiBurst:Show(icon)
        end 
        
        if     (isMulti or A.GetToggle(2, "AoE")) and A.ChiWave:IsReady(unit, true, nil, isSoothingMistCasting) and A.ChiWave:AbsentImun(unit) and IsSchoolFree() and Unit(unit):GetRange() <= 25 and MultiUnits:GetByRange(25, 3) >= 3 and
        (
            not A.IsInPvP or 
            not EnemyTeam("HEALER"):IsBreakAble(25)                
        )
        then 
            return A.ChiWave:Show(icon)
        end 
        
        if A.RisingMist:IsSpellLearned() and A.TigerPalm:IsReady(unit, nil, nil, isSoothingMistCasting) and A.TigerPalm:AbsentImun(unit, Temp.TotalAndPhys) then 
            return A.TigerPalm:Show(icon)
        end 
        
        -- Azerite Essence 
        if A.ConcentratedFlame:AutoHeartOfAzeroth(unit, isSoothingMistCasting) then 
            return A.ConcentratedFlame:Show(icon)
        end 
        
        if     (isMulti or A.GetToggle(2, "AoE")) and A.RippleinSpace:AutoHeartOfAzeroth(unit, isSoothingMistCasting) and A.RippleinSpace:AbsentImun(unit, Temp.TotalAndMag) and MultiUnits:GetByRange(25, 3) >= 3 and 
        (
            not A.IsInPvP or 
            not EnemyTeam("HEALER"):IsBreakAble(25)    
        ) 
        then 
            return A.RippleinSpace:Show(icon)
        end 
        
        -- Continue Rotation 
        if (isMulti or A.GetToggle(2, "AoE")) and A.ArcanePulse:AutoRacial(unit, true, nil, isSoothingMistCasting) then 
            return A.ArcanePulse:Show(icon)
        end 
        
        if     (isMulti or A.GetToggle(2, "AoE")) and A.SpinningCraneKick:IsReady(unit, true, nil, isSoothingMistCasting) and A.SpinningCraneKick:AbsentImun(unit, Temp.TotalAndMag) and MultiUnits:GetByRange(8, 3) >= 3 and 
        (
            not A.IsInPvP or 
            not EnemyTeam("HEALER"):IsBreakAble(8)                
        )
        then 
            return A.SpinningCraneKick:Show(icon)
        end 
        
        if A.TigerPalm:IsReady(unit, nil, nil, isSoothingMistCasting) and A.TigerPalm:AbsentImun(unit, Temp.TotalAndPhys) then 
            return A.TigerPalm:Show(icon)
        end 
        
        if not isMoving and (not inMelee or (A.IsInPvP and Unit(unit):HasBuffs("DamagePhysImun") > 0)) and A.CracklingJadeLightning:IsReady(unit, nil, nil, isSoothingMistCasting) and A.CracklingJadeLightning:AbsentImun(unit, Temp.TotalAndMag) and IsSchoolFree() then 
            return A.CracklingJadeLightning:Show(icon)
        end             
    end 
    
    local function HealingRotation(unit)
        local isAffectedBySoothingMist = Unit(unit):HasBuffs(A.SoothingMist.ID, true) > 0 and isSoothingMistCasting
        
        -- Stopcasting 
        if A.GetToggle(1, "StopCast") and isSoothingMistCasting and ((A.GetToggle(2, "SoothingMistStopCast")[1] and not isAffectedBySoothingMist) or (A.GetToggle(2, "SoothingMistStopCast")[2] and isAffectedBySoothingMist and Unit(unit):HealthPercent() >= 100 and IsEnoughHPS(unit))) then 
            StopCast = true -- passing to A[6]
            return             
        end         
        
        -- Purge
        if A.ArcaneTorrent:AutoRacial(unit, nil, nil, isSoothingMistCasting) then 
            return A.ArcaneTorrent:Show(icon)
        end     
        
        -- Out of combat / Precombat
        if Unit("player"):CombatTime() == 0 then 
            if A.Reawaken:IsReady(unit, true, nil, isSoothingMistCasting) and Unit(unit):InGroup() and Unit(unit):IsDead() and Unit(unit):IsPlayer() and Unit(unit):GetRange() <= 100 and not isMoving and IsSchoolFree() then 
                return A.Reawaken:Show(icon)
            end 
            
            if A.Resuscitate:IsReady(unit, nil, nil, isSoothingMistCasting) and Unit(unit):IsDead() and Unit(unit):IsPlayer() and not isMoving and IsSchoolFree() then 
                return A.Resuscitate:Show(icon)
            end 
            
            if A.SummonJadeSerpentStatue:IsReady(unit, true, nil, isSoothingMistCasting) and JadeSerpentStatue.GetRange() > 40 and Player:IsStayingTime() > 2.5 and IsSchoolFree() then 
                return A.SummonJadeSerpentStatue:Show(icon)
            end 
            
            local Pull = A.BossMods_Pulling()  
            if Pull > 0 then 
                -- Timing
                local extra_time = A.GetCurrentGCD() + 0.1
                local RenewingMist, EnvelopingMist, ChiBurst, TigersLust
                if A.RenewingMist:IsReady(unit, nil, nil, true) and A.RenewingMist:AbsentImun(unit) and IsSchoolFree() and Unit(unit):HasBuffs(A.RenewingMist.ID, true) == 0 then 
                    RenewingMist = true 
                    extra_time = extra_time + A.GetGCD()
                end 
                
                if A.EnvelopingMist:IsReady(unit, nil, nil, true) and A.EnvelopingMist:AbsentImun(unit) and not isMoving and IsSchoolFree() then 
                    EnvelopingMist = true 
                    extra_time = extra_time + Unit("player"):CastTime(A.EnvelopingMist.ID)
                end 
                
                if (isMulti or A.GetToggle(2, "AoE")) and A.ChiBurst:IsReady(unit, true, nil, true) and not isMoving and IsSchoolFree() then 
                    ChiBurst = true 
                    extra_time = extra_time + Unit("player"):CastTime(A.ChiBurst.ID)
                end 
                
                if A.TigersLust:IsReady(unit, true, nil, true) and A.TigersLust:AbsentImun(unit) and IsSchoolFree() then
                    TigersLust = true
                    extra_time = extra_time + A.GetGCD()
                end 
                
                -- Pull Rotation
                if RenewingMist and Pull <= extra_time then 
                    if A.ThunderFocusTea:IsReady(unit, true, nil, true) and Unit("player"):HasBuffs(A.ThunderFocusTea.ID, true) == 0 then
                        return A.ThunderFocusTea:Show(icon)
                    end 
                    if not A.ShouldStop() then 
                        return A.RenewingMist:Show(icon)
                    end 
                end 
                
                if EnvelopingMist and not A.ShouldStop() and Pull <= extra_time then 
                    return A.EnvelopingMist:Show(icon)
                end 
                
                if ChiBurst and not A.ShouldStop() and Pull <= extra_time then 
                    return A.ChiBurst:Show(icon)
                end 
                
                if TigersLust and not A.ShouldStop() and Pull <= extra_time then 
                    return A.TigersLust:Show(icon)
                end 
                
                return 
            end 
            
            if A.HealingSphere:IsReady(unit, true, nil, true) and IsSchoolFree() and (not A.GetToggle(2, "MouseButtonsCheck") or (not IsMouseButtonDown("LeftButton") and not IsMouseButtonDown("RightButton"))) then 
                return A.HealingSphere:Show(icon)
            end 
        end 
        
        -- Interrupts (@targettarget)
        if unit == "target" and A.IsUnitEnemy("targettarget") then 
            local Interrupt = Interrupts("targettarget", isSoothingMistCasting)
            if Interrupt then 
                return Interrupt:Show(icon)
            end 
        end    
        
        -- Bursting 
        if A.BurstIsON(unit) then 
            -- Multi (for [4])
            if isMulti then 
                if CanRevival(isSoothingMistCasting) then 
                    if A.OverchargeMana:AutoHeartOfAzeroth(unit, isSoothingMistCasting) and not IsEnoughHPS(unit) and Unit("player"):PowerPercent() > 20 then 
                        return A.OverchargeMana:Show(icon)
                    end 
                    
                    return A.Revival:Show(icon)
                end 
                
                if CanInvokeChiJitheRedCrane(isSoothingMistCasting) then 
                    if A.OverchargeMana:AutoHeartOfAzeroth(unit, isSoothingMistCasting) and not IsEnoughHPS(unit) and Unit("player"):PowerPercent() > 20 then 
                        return A.OverchargeMana:Show(icon)
                    end 
                    
                    return A.InvokeChiJitheRedCrane:Show(icon)
                end 
                
                -- Azerite Essence
                if A.LifeBindersInvocation:AutoHeartOfAzeroth(unit, isSoothingMistCasting) then 
                    return A.LifeBindersInvocation:Show(icon)
                end             
            end 
            
            -- Single 
            if A.LifeCocoon:IsReady(unit, nil, nil, isSoothingMistCasting) and A.LifeCocoon:AbsentImun(unit) and IsSchoolFree() then 
                local LifeCocoon = A.GetToggle(2, "LifeCocoon")
                
                -- Auto 
                if     LifeCocoon >= 100 and not IsEnoughHPS(unit) and Unit(unit):HasBuffs("DeffBuffs") == 0 and (
                    (Unit(unit):TimeToDieX(20) < 3 and Unit(unit):HealthPercent() < 60) or 
                    (A.IsInPvP and Unit(unit):HealthPercent() < 80 and (Unit(unit):HasDeBuffs("DamageDeBuffs") > 5 or Unit(unit):IsExecuted()))
                ) 
                then 
                    return A.LifeCocoon:Show(icon)
                end 
                
                -- Custom 
                if LifeCocoon < 100 and Unit(unit):HealthPercent() <= LifeCocoon then 
                    return A.LifeCocoon:Show(icon)
                end 
            end                         
            
            -- Azerite Essence
            if A.Standstill:AutoHeartOfAzeroth(unit, isSoothingMistCasting) then 
                return A.Standstill:Show(icon)
            end 
            
            -- Racial 
            local RacialBurstHealing = A.GetToggle(2, "RacialBurstHealing")            
            if  Unit(unit):InRange() and A.AbsentImun(nil, unit) and 
            (
                -- Auto
                (RacialBurstHealing >= 100 and not IsEnoughHPS(unit) and (Unit(unit):TimeToDieX(45) < 5 or (A.IsInPvP and Unit(unit):UseBurst()))) or 
                -- Custom            
                (RacialBurstHealing < 100 and Unit(unit):HealthPercent() <= RacialBurstHealing)
            )
            then 
                if A.BloodFury:AutoRacial(unit, nil, nil, isSoothingMistCasting) then 
                    return A.BloodFury:Show(icon)
                end 
                
                if A.Fireblood:AutoRacial(unit, nil, nil, isSoothingMistCasting) then 
                    return A.Fireblood:Show(icon)
                end 
                
                if A.AncestralCall:AutoRacial(unit, nil, nil, isSoothingMistCasting) then 
                    return A.AncestralCall:Show(icon)
                end 
                
                if A.Berserking:AutoRacial(unit, nil, nil, isSoothingMistCasting) then 
                    return A.Berserking:Show(icon)
                end             
            end 
            
            -- AoE
            if not isMulti and A.GetToggle(2, "AoE") then 
                if CanRevival(isSoothingMistCasting) then 
                    if A.OverchargeMana:AutoHeartOfAzeroth(unit, isSoothingMistCasting) and not IsEnoughHPS(unit) and Unit("player"):PowerPercent() > 20 then 
                        return A.OverchargeMana:Show(icon)
                    end 
                    
                    return A.Revival:Show(icon)
                end 
                
                if CanInvokeChiJitheRedCrane(isSoothingMistCasting) then 
                    if A.OverchargeMana:AutoHeartOfAzeroth(unit, isSoothingMistCasting) and not IsEnoughHPS(unit) and Unit("player"):PowerPercent() > 20 then 
                        return A.OverchargeMana:Show(icon)
                    end 
                    
                    return A.InvokeChiJitheRedCrane:Show(icon)
                end 
                
                -- Azerite Essence
                if A.LifeBindersInvocation:AutoHeartOfAzeroth(unit, isSoothingMistCasting) then 
                    return A.LifeBindersInvocation:Show(icon)
                end                                 
            end 
        end 
        
        -- PvP CrownControl (@targettarget)
        if unit == "target" and A.IsUnitEnemy("targettarget") and A.GrappleWeaponIsReady("targettarget", false, isSoothingMistCasting) then 
            return A.GrappleWeapon:Show(icon)
        end 
        
        -- PvP CrownControl (Enemy Healer)
        if A.IsInPvP and A.LegSweep:IsReady(nil, nil, nil, isSoothingMistCasting) then 
            local EnemyHealerUnitID = EnemyTeam("HEALER"):GetUnitID(5 + (A.TigerTailSweep:IsSpellLearned() and 2 or 0))
            
            if EnemyHealerUnitID ~= "none" and A.LegSweep:AbsentImun(EnemyHealerUnitID, Temp.TotalAndPhysAndCCAndStun, true) and Unit(EnemyHealerUnitID):IsControlAble("stun", 0) and Unit(EnemyHealerUnitID):InCC() <= A.GetCurrentGCD() then
                return A.LegSweep:Show(icon)     
            end 
        end 
        
        -- Racial 
        if A.GiftofNaaru:AutoRacial(unit, nil, nil, isSoothingMistCasting) and Unit(unit):HealthPercent() <= A.GetToggle(2, "RacialBurstHealing") then 
            return A.GiftofNaaru:Show(icon)
        end 
        
        -- Trinkets         
        if A.AbsentImun(nil, unit) and Unit(unit):HealthPercent() <= A.GetToggle(2, "TrinketBurstHealing") and Unit(unit):InRange() then 
            if A.Trinket1:IsReady(unit, nil, nil, isSoothingMistCasting) and A.Trinket1:GetItemCategory() ~= "DPS" then 
                return A.Trinket1:Show(icon)
            end 
            
            if A.Trinket2:IsReady(unit, nil, nil, isSoothingMistCasting) and A.Trinket2:GetItemCategory() ~= "DPS" then 
                return A.Trinket2:Show(icon)
            end     
        end     
        
        -- Rotation         
        if A.Detox:IsReady(unit, nil, nil, isSoothingMistCasting) and A.Detox:AbsentImun(unit) and IsSchoolFree() and A.AuraIsValid(unit, "UseDispel", "Dispel") and Unit(unit):TimeToDie() > 5 then 
            return A.Detox:Show(icon)
        end 
        
        if A.TigersLust:IsReady(unit, nil, nil, isSoothingMistCasting) and A.TigersLust:AbsentImun(unit) and IsSchoolFree() and Unit(unit):TimeToDie() > 6 then 
            if Unit(unit):HasDeBuffs("Rooted") > 1.5 then 
                return A.TigersLust:Show(icon)
            end 
            
            local cUnitSpeed = Unit(unit):GetCurrentSpeed()
            if cUnitSpeed > 0 and cUnitSpeed < 64 and (UnitIsUnit(unit, "player") or Unit(unit):IsMelee()) then 
                return A.TigersLust:Show(icon)
            end 
        end 
        
        if A.Detox:IsReady(unit, nil, nil, isSoothingMistCasting) and A.Detox:AbsentImun(unit) and IsSchoolFree() and A.AuraIsValid(unit, "UseDispel", "MagicMovement") and Unit(unit):TimeToDie() > 12 then 
            return A.Detox:Show(icon)
        end 
        
        if (isMulti or A.GetToggle(2, "AoE")) then 
            if A.VitalityConduit:AutoHeartOfAzeroth(unit, isSoothingMistCasting) then 
                return A.VitalityConduit:Show(icon)
            end
            
            if CanEssenceFont(isSoothingMistCasting) then 
                if CanZenFocusTea(nil, isSoothingMistCasting) then 
                    return A.ZenFocusTea:Show(icon)
                end 
                
                if A.OverchargeMana:AutoHeartOfAzeroth(unit, isSoothingMistCasting) and (not IsEnoughHPS(unit) or HealingEngine.GetIncomingDMGAVG() > HealingEngine.GetIncomingHPSAVG() + 10) then 
                    return A.OverchargeMana:Show(icon)
                end 
                
                return A.EssenceFont:Show(icon)
            end 
        end 
        
        -- Multi (for [4])
        if isMulti then 
            if CanRefreshingJadeWind(isSoothingMistCasting) then
                return A.RefreshingJadeWind:Show(icon)
            end 
            if CanChiWave(isSoothingMistCasting) then 
                return A.ChiWave:Show(icon)
            end 
            if CanChiBurst(isSoothingMistCasting) then 
                return A.ChiBurst:Show(icon)
            end 
        end
        
        -- Super Emergency 
        local Emergency = Unit(unit):TimeToDieX(25) < 4 and Unit(unit):HealthPercent() <= 60
        if not isSoothingMistCasting and Emergency and A.SoothingMist:IsReady(unit) and Unit(unit):DeBuffCyclone() == 0 and IsSchoolFree() and Unit(unit):HealthPercent() <= A.GetToggle(2, "SoothingMistHP") then 
            if A.SummonJadeSerpentStatue:IsReady(unit, true, nil, true) and JadeSerpentStatue.GetRange() > 40 and Unit(unit):TimeToDie() > 3 then 
                return A.SummonJadeSerpentStatue:Show(icon)
            end     
            if not isMoving then
                if CanZenFocusTea(nil, isSoothingMistCasting) then 
                    return A.ZenFocusTea:Show(icon)
                end 
                return A.SoothingMist:Show(icon)
            end
        end 
        
        if isSoothingMistCasting and not isMoving and Emergency and A.EnvelopingMist:IsReady(unit, nil, nil, isSoothingMistCasting) and A.EnvelopingMist:AbsentImun(unit) and IsSchoolFree() and Unit("player"):IsCastingRemains(A.EnvelopingMist.ID) == 0 and Unit(unit):HasBuffs(A.EnvelopingMist.ID, true) == 0 and A.EnvelopingMist:PredictHeal("EnvelopingMist", unit) then 
            if A.ThunderFocusTea:IsReady(unit, true, nil, isSoothingMistCasting) and Unit("player"):HasBuffs(A.ThunderFocusTea.ID, true) == 0 then
                return A.ThunderFocusTea:Show(icon)
            end 
            if CanZenFocusTea(nil, isSoothingMistCasting) then 
                return A.ZenFocusTea:Show(icon)
            end             
            return A.EnvelopingMist:Show(icon)
        end 
        
        if isSoothingMistCasting and not isMoving and Emergency and A.SurgingMist:IsReady(unit, nil, nil, isSoothingMistCasting) and A.SurgingMist:AbsentImun(unit) and IsSchoolFree() and A.SurgingMist:PredictHeal("SurgingMist", unit) then 
            if CanZenFocusTea(nil, isSoothingMistCasting) then 
                return A.ZenFocusTea:Show(icon)
            end             
            return A.SurgingMist:Show(icon)
        end 
        
        if isSoothingMistCasting and not isMoving and Emergency and A.Vivify:IsReady(unit, nil, nil, isSoothingMistCasting) and A.Vivify:AbsentImun(unit) and IsSchoolFree() and A.Vivify:PredictHeal("Vivify", unit) then 
            if IsSaveManaPhase() and A.ThunderFocusTea:IsReady(unit, true, nil, isSoothingMistCasting) and Unit("player"):HasBuffs(A.ThunderFocusTea.ID, true) == 0 then
                return A.ThunderFocusTea:Show(icon)
            end 
            if CanZenFocusTea(nil, isSoothingMistCasting) then 
                return A.ZenFocusTea:Show(icon)
            end 
            return A.Vivify:Show(icon)
        end     
        
        -- Continue Rotation         
        if A.RenewingMist:IsReady(unit, nil, nil, isSoothingMistCasting) and A.RenewingMist:AbsentImun(unit) and IsSchoolFree() and Unit(unit):HasBuffs(A.RenewingMist.ID, true) <= A.GetCurrentGCD() and (isMulti or A.RenewingMist:PredictHeal("RenewingMist", unit)) then 
            if A.ThunderFocusTea:IsReady(unit, true, nil, isSoothingMistCasting) and Unit("player"):HasBuffs(A.ThunderFocusTea.ID, true) == 0 then
                return A.ThunderFocusTea:Show(icon)
            end     
            
            return A.RenewingMist:Show(icon)
        end                 
        
        if not isMulti and A.GetToggle(2, "AoE") then 
            if CanRefreshingJadeWind(isSoothingMistCasting) then
                return A.RefreshingJadeWind:Show(icon)
            end 
            if CanChiWave(isSoothingMistCasting) then 
                return A.ChiWave:Show(icon)
            end 
            if CanChiBurst(isSoothingMistCasting) then 
                return A.ChiBurst:Show(icon)
            end 
        end             
        
        -- Fistweaving Rotation (@targettarget)
        if unit == "target" and A.IsUnitEnemy("targettarget") then
            inMelee = A.TigerPalm:IsInRange("targettarget")
            
            if not isMulti and A.RisingMist:IsSpellLearned() and A.RenewingMist:IsReady(unit, nil, nil, isSoothingMistCasting) and A.RenewingMist:AbsentImun(unit) and IsSchoolFree() and Unit(unit):HasBuffs(A.RenewingMist.ID, true) <= A.GetCurrentGCD() then 
                if A.ThunderFocusTea:IsReady("player", true, nil, isSoothingMistCasting) and Unit("player"):HasBuffs(A.ThunderFocusTea.ID, true) == 0 then
                    return A.ThunderFocusTea:Show(icon)
                end     
                
                return A.RenewingMist:Show(icon)
            end             
            
            if A.RisingMist:IsSpellLearned() and A.RisingSunKick:IsReady("targettarget", nil, nil, isSoothingMistCasting) and A.RisingSunKick:AbsentImun("targettarget", Temp.TotalAndPhys) then 
                if A.ThunderFocusTea:IsReady("player", true, nil, isSoothingMistCasting) and Unit("player"):HasBuffs(A.ThunderFocusTea.ID, true) == 0 then
                    return A.ThunderFocusTea:Show(icon)
                end 
                return A.RisingSunKick:Show(icon)
            end               
            
            if A.SpiritoftheCrane:IsSpellLearned() and A.BlackoutKick:IsReady("targettarget", nil, nil, isSoothingMistCasting) and A.BlackoutKick:AbsentImun("targettarget", Temp.TotalAndPhys) and Unit("player"):HasBuffsStacks(A.TeachingsoftheMonastery.ID, true) >= 3 then 
                return A.BlackoutKick:Show(icon)
            end 
            
            if A.SpiritoftheCrane:IsSpellLearned() and A.TigerPalm:IsReady("targettarget", nil, nil, isSoothingMistCasting) and A.TigerPalm:AbsentImun("targettarget", Temp.TotalAndPhys) and Unit("player"):HasBuffsStacks(A.TeachingsoftheMonastery.ID, true) < 3 then 
                return A.TigerPalm:Show(icon)
            end             
        end 
        
        if Unit("player"):CombatTime() > 0 and A.ManaTea:IsReady("player", true, nil, isSoothingMistCasting) and IsSchoolFree() and Unit("player"):HasBuffs(A.Innervate.ID) == 0 and (HealingEngine.GetTimeToFullHealth() > 12 or HealingEngine.GetIncomingDMGAVG() > 30) then 
            return A.ManaTea:Show(icon)
        end 
        
        -- Azerite Essences 
        if Unit("player"):CombatTime() > 0 and A.MemoryofLucidDreams:AutoHeartOfAzeroth(unit, isSoothingMistCasting) and Unit("player"):PowerPercent() < 85 and (not A.ManaTea:IsSpellLearned() or Unit("player"):HasBuffs(A.ManaTea.ID, true) == 0) then 
            return A.MemoryofLucidDreams:Show(icon)
        end         
        
        if Unit("player"):CombatTime() > 0 and A.WorldveinResonance:AutoHeartOfAzeroth(unit, isSoothingMistCasting) and Player:IsStayingTime() > 2 then 
            return A.WorldveinResonance:Show(icon)
        end        
        
        -- Misc 
        local Mana = A.GetToggle(2, "ManaPotion") 
        if Unit("player"):CombatTime() > 0 and Mana > 0 and Unit("player"):PowerPercent() <= Mana then 
            if A.PotionofReconstitution:IsReady("player", true, nil, isSoothingMistCasting) and not isMoving and Player:IsStayingTime() > 1.5 then 
                if A.MemoryofLucidDreams:AutoHeartOfAzeroth("player", isSoothingMistCasting) then 
                    return A.MemoryofLucidDreams:Show(icon)
                end 
                
                return A.PotionofReconstitution:Show(icon)                
            end 
            
            if A.CoastalManaPotion:IsReady("player", true, nil, isSoothingMistCasting) then 
                return A.CoastalManaPotion:Show(icon)
            end 
        end 
        
        -- Azerite Essences 
        if A.ConcentratedFlame:AutoHeartOfAzeroth(unit, isSoothingMistCasting) then 
            return A.ConcentratedFlame:Show(icon)
        end 
        
        if A.Refreshment:AutoHeartOfAzeroth(unit, isSoothingMistCasting) then 
            return A.Refreshment:Show(icon)
        end 
        
        -- Normal Rotation 
        local SoothingMistHP = A.GetToggle(2, "SoothingMistHP")
        if     not isSoothingMistCasting and A.SoothingMist:IsReady(unit) and Unit(unit):DeBuffCyclone() == 0 and IsSchoolFree() and 
        ( 
            (
                SoothingMistHP < 100 and 
                Unit(unit):HealthPercent() <= SoothingMistHP  
            ) or 
            (
                SoothingMistHP >= 100 and 
                A.Vivify:PredictHeal("Vivify", unit, 200)
            )
        )
        then
            local SoothingMistWorkMode = A.GetToggle(2, "SoothingMistWorkMode")
            if     SoothingMistWorkMode == "Always" or 
            (
                (SoothingMistWorkMode == "Auto" or SoothingMistWorkMode == "Tanking Units") and 
                (Unit(unit):IsTank() or Unit(unit):IsTanking("targettarget"))
            ) or 
            (
                (SoothingMistWorkMode == "Auto" or SoothingMistWorkMode == "Mostly Inc. Damage") and 
                HealingEngine.IsMostlyIncDMG(unit)
            ) or 
            (
                (SoothingMistWorkMode == "Auto" or SoothingMistWorkMode == "HPS < Inc. Damage") and 
                not IsEnoughHPS(unit)
            )
            then 
                if A.SummonJadeSerpentStatue:IsReady() and JadeSerpentStatue.GetRange() > 40 then 
                    return A.SummonJadeSerpentStatue:Show(icon)
                end     
                
                if not isMoving then
                    if CanZenFocusTea(nil, isSoothingMistCasting) then 
                        return A.ZenFocusTea:Show(icon)
                    end 
                    
                    return A.SoothingMist:Show(icon)
                end 
            end
        end 
        
        if not isMoving and A.EnvelopingMist:IsReady(unit, nil, nil, isSoothingMistCasting) and A.EnvelopingMist:AbsentImun(unit) and IsSchoolFree() and Unit("player"):IsCastingRemains(A.EnvelopingMist.ID) == 0 and Unit(unit):HasBuffs(A.EnvelopingMist.ID, true) == 0 and A.EnvelopingMist:PredictHeal("EnvelopingMist", unit, 300) then 
            if A.ThunderFocusTea:IsReady(unit, true, nil, isSoothingMistCasting) and Unit("player"):HasBuffs(A.ThunderFocusTea.ID, true) == 0 then
                return A.ThunderFocusTea:Show(icon)
            end 
            if CanZenFocusTea(nil, isSoothingMistCasting) then 
                return A.ZenFocusTea:Show(icon)
            end             
            return A.EnvelopingMist:Show(icon)
        end 
        
        if not isMoving and A.SurgingMist:IsReady(unit, nil, nil, isSoothingMistCasting) and A.SurgingMist:AbsentImun(unit) and IsSchoolFree() and A.SurgingMist:PredictHeal("SurgingMist", unit) then 
            if CanZenFocusTea(nil, isSoothingMistCasting) then 
                return A.ZenFocusTea:Show(icon)
            end             
            return A.SurgingMist:Show(icon)
        end 
        
        if not isMoving and A.Vivify:IsReady(unit, nil, nil, isSoothingMistCasting) and A.Vivify:AbsentImun(unit) and IsSchoolFree() and A.Vivify:PredictHeal("Vivify", unit) then 
            if IsSaveManaPhase() and A.ThunderFocusTea:IsReady(unit, true, nil, isSoothingMistCasting) and Unit("player"):HasBuffs(A.ThunderFocusTea.ID, true) == 0 then
                return A.ThunderFocusTea:Show(icon)
            end 
            if CanZenFocusTea(nil, isSoothingMistCasting) then 
                return A.ZenFocusTea:Show(icon)
            end 
            return A.Vivify:Show(icon)
        end                 
        
        -- Damage Rotation 
        if unit == "target" and A.IsUnitEnemy("targettarget") then 
            local CanMakeDamage = DamageRotation("targettarget")
            if CanMakeDamage then 
                return true 
            end 
        end 
        
        -- Totally nothing to do 
        if not isMulti and A.RenewingMist:IsReady(unit, nil, nil, isSoothingMistCasting) and A.RenewingMist:AbsentImun(unit) and IsSchoolFree() and Unit(unit):HasBuffs(A.RenewingMist.ID, true) <= A.GetCurrentGCD() then 
            if Unit("player"):CombatTime() > 0 and A.ThunderFocusTea:IsReady(unit, true, nil, isSoothingMistCasting) and Unit("player"):HasBuffs(A.ThunderFocusTea.ID, true) == 0 then
                return A.ThunderFocusTea:Show(icon)
            end 
            return A.RenewingMist:Show(icon)            
        end         
    end 
    
    -- Defensive
    local SelfDefensive = SelfDefensives(isSoothingMistCasting)
    if SelfDefensive then 
        return SelfDefensive:Show(icon)
    end 
    
    -- Mouseover 
    if A.IsUnitEnemy("mouseover") then 
        unit = "mouseover"
        
        if DamageRotation(unit) then 
            return true 
        end 
    end 
    
    if A.IsUnitFriendly("mouseover") then 
        unit = "mouseover"    
        
        if HealingRotation(unit) then 
            return true 
        end             
    end 
    
    -- Target / TargetTarget     
    if A.IsUnitEnemy("target") then 
        unit = "target"
        
        if DamageRotation(unit) then 
            return true 
        end 
    end 
    
    if A.IsUnitFriendly("target") then 
        unit = "target"
        
        if HealingRotation(unit) then 
            return true 
        end 
    end 
    
    -- Misc 
    if A.IsInPvP and A.HealingSphere:IsReady() and IsSchoolFree() and (not A.GetToggle(2, "MouseButtonsCheck") or (not IsMouseButtonDown("LeftButton") and not IsMouseButtonDown("RightButton"))) then 
        return A.HealingSphere:Show(icon)
    end     
    
    if A.Zone == "arena" and Unit("player"):CombatTime() == 0 and not Player:IsMounted() and A.SpinningCraneKick:IsReady() and (isMulti or A.GetToggle(2, "AoE")) and EnemyTeam():HasInvisibleUnits() and not EnemyTeam("HEALER"):IsBreakAble(8) then 
        return A.SpinningCraneKick:Show(icon)         
    end 
    
    -- Movement
    -- If not moving or moving lower than 2.5 sec 
    if Player:IsMovingTime() < 2.5 then 
        return 
    end 
    
    if not A.ChiTorpedo:IsSpellLearned() and A.Roll:IsReady() and (unit == "player" or not Unit(unit):IsExists()) and IsIndoors() and Unit("player"):CombatTime() == 0 then 
        return A.Roll:Show(icon)
    end 
    
    if A.ChiTorpedo:IsReady() and (unit == "player" or not Unit(unit):IsExists()) and IsIndoors() and Unit("player"):CombatTime() == 0 then 
        return A.ChiTorpedo:Show(icon)
    end     
end 

-- [4] AoE Rotation
A[4] = function(icon)
    return A[3](icon, true)
end 

-- [5] Trinket Rotation
-- No specialization trinket actions 

-- Passive 
local function FreezingTrapUsedByEnemy()
    if     UnitCooldown:GetCooldown("arena", ACTION_CONST_SPELLID_FREEZING_TRAP) > UnitCooldown:GetMaxDuration("arena", ACTION_CONST_SPELLID_FREEZING_TRAP) - 2 and 
    UnitCooldown:IsSpellInFly("arena", ACTION_CONST_SPELLID_FREEZING_TRAP) and 
    Unit("plauer"):GetDR("incapacitate") > 0 
    then 
        local Caster = UnitCooldown:GetUnitID("arena", ACTION_CONST_SPELLID_FREEZING_TRAP)
        if Caster and Unit(Caster):GetRange() <= 40 then 
            return true 
        end 
    end 
end 

local function ArenaRotation(unit)
    if A.IsInPvP and not Player:IsStealthed() and not Player:IsMounted() then             
        local isSoothingMistCasting = Unit("player"):IsCastingRemains(A.SoothingMist.ID) > 0
        
        -- Note: "arena1" is just identification of meta 6
        if unit == "arena1" and (Unit("playr"):GetDMG() == 0 or not Unit("player"):IsFocused("DAMAGER")) then                 
            -- PvP Pet Taunt        
            if A.Provoke:IsReady(nil, nil, nil, isSoothingMistCasting) and EnemyTeam():IsTauntPetAble(A.Provoke.ID) then 
                -- Freezing Trap 
                if FreezingTrapUsedByEnemy() then 
                    return A.Provoke
                end 
                
                -- Casting BreakAble CC
                if EnemyTeam():IsCastingBreakAble(0.5) then 
                    return A.Provoke 
                end 
                
                -- Try avoid something totally random at opener (like sap / blind)
                if Unit("player"):CombatTime() <= 5 and (Unit("player"):CombatTime() > 0 or Unit("target"):CombatTime() > 0 or MultiUnits:GetByRangeInCombat(nil, 1) >= 1) then 
                    return A.Provoke 
                end             
            end 
            
            -- if Provoke used then don't overleap attempts to control avoid 
            if Unit("player"):GetSpellLastCast(A.Provoke.ID) > 2 then                              
                -- PvP Roll 
                if not A.ChiTorpedo:IsSpellLearned() and A.Roll:IsReady(nil, nil, nil, isSoothingMistCasting) and FreezingTrapUsedByEnemy() then 
                    return A.Roll
                end 
                
                -- PvP ChiTorpedo 
                if A.ChiTorpedo:IsReady(nil, nil, nil, isSoothingMistCasting) and FreezingTrapUsedByEnemy() then 
                    return A.ChiTorpedo
                end 
            end 
        end 
        
        -- PvP Disarm 
        if A.GrappleWeaponIsReady(unit, false, isSoothingMistCasting) and not Unit(unit):InLOS() then
            return A.GrappleWeapon
        end         
    end 
end 

local function PartyRotation(unit)
    local isSoothingMistCasting = Unit("player"):IsCastingRemains(A.SoothingMist.ID) > 0
    
    -- Tiger Lust
    if A.TigersLust:IsReady(unit, nil, nil, isSoothingMistCasting) and A.TigersLust:AbsentImun(unit) and IsSchoolFree() and not Unit("player", 5):HasFlags() and (Unit(unit):IsMelee() or Unit(unit):IsFocused(nil, true) or Unit(unit):HasBuffs("DamageBuffs") > 0) and not Unit(unit):InLOS() then 
        if Unit(unit):HasDeBuffs("Rooted") > A.GetGCD() then 
            return A.TigersLust
        end 
        
        local cMoving = Unit(unit):GetCurrentSpeed()
        if cMoving > 0 and cMoving < 64 then -- 64 because unit can moving backward 
            return A.TigersLust
        end 
    end 
    
    -- Detox 
    if A.Detox:IsReady(unit, nil, nil, isSoothingMistCasting) and A.Detox:AbsentImun(unit) and IsSchoolFree() and A.AuraIsValid(unit, "UseDispel", "Dispel") and not Unit(unit):InLOS() then                         
        return A.Detox
    end     
end 

A[6] = function(icon)    
    if StopCast and Unit("player"):IsCastingRemains(A.SoothingMist.ID) > 0 then 
        return A:Show(icon, ACTION_CONST_STOPCAST)
    end 
    
    StopCast = false 
    
    local Arena = ArenaRotation("arena1")
    if Arena then 
        return Arena:Show(icon)
    end 
end

A[7] = function(icon)
    local Party = PartyRotation("party1") 
    if Party then 
        return Party:Show(icon)
    end 
    
    local Arena = ArenaRotation("arena2")
    if Arena then 
        return Arena:Show(icon)
    end 
end

A[8] = function(icon)
    local Party = PartyRotation("party2") 
    if Party then 
        return Party:Show(icon)
    end     
    
    local Arena = ArenaRotation("arena3")
    if Arena then 
        return Arena:Show(icon)
    end 
end

