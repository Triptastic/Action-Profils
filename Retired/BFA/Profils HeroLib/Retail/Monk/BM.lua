local TMW                                     = TMW 
local Env                                    = TMW.CNDT.Env

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

Action[ACTION_CONST_MONK_BREWMASTER] = {
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
    SpearHandStrike                              = Action.Create({ Type = "Spell", ID = 116705    }),
    SpearHandStrikeGreen                    = Action.Create({ Type = "SpellSingleColor", ID = 116705, Color = "GREEN", Desc = "[2] Kick", QueueForbidden = true }),
    -- Suppotive    
    Resuscitate                                  = Action.Create({ Type = "Spell", ID = 115178, QueueForbidden = true }),
    Provoke                                      = Action.Create({ Type = "Spell", ID = 115546    }),    
    SummonBlackOxStatue                         = Action.Create({ Type = "Spell", ID = 115315, isTalent = true     }),
    ProvokeSummonBlackOxStatue                = Action.Create({ Type = "Spell", ID = 115546, Color = "PINK", Texture = 115315 }),
    Admonishment                             = Action.Create({ Type = "Spell", ID = 207025, isTalent = true    }),    -- PvP Talent Provoke 
    Detox                                      = Action.Create({ Type = "Spell", ID = 218164    }),
    TigersLust                                     = Action.Create({ Type = "Spell", ID = 116841, isTalent = true    }),
    Vivify                                      = Action.Create({ Type = "Spell", ID = 116670    }),
    -- Defensives    
    IronskinBrew                              = Action.Create({ Type = "Spell", ID = 115308     }), -- on simcraft it is Brews
    PurifyingBrew                            = Action.Create({ Type = "Spell", ID = 119582     }),
    HealingElixir                              = Action.Create({ Type = "Spell", ID = 122281, isTalent = true     }),
    ZenMeditation                              = Action.Create({ Type = "Spell", ID = 115176     }),
    Guard                                      = Action.Create({ Type = "Spell", ID = 115295, isTalent = true     }),    
    DampenHarm                                = Action.Create({ Type = "Spell", ID = 122278, isTalent = true     }),
    FortifyingBrew                            = Action.Create({ Type = "Spell", ID = 115203     }),            
    -- Rotation     
    BlackoutStrike                            = Action.Create({ Type = "Spell", ID = 205523     }),
    BlackOxBrew                               = Action.Create({ Type = "Spell", ID = 115399, isTalent = true     }),    
    BreathofFire                              = Action.Create({ Type = "Spell", ID = 115181     }),
    CracklingJadeLightning                      = Action.Create({ Type = "Spell", ID = 117952     }),
    ChiBurst                                  = Action.Create({ Type = "Spell", ID = 123986, isTalent = true     }),
    ChiWave                                   = Action.Create({ Type = "Spell", ID = 115098, isTalent = true     }),    
    ExpelHarm                                  = Action.Create({ Type = "Spell", ID = 115072     }),
    InvokeNiuzaotheBlackOx                    = Action.Create({ Type = "Spell", ID = 132578, isTalent = true     }),    
    KegSmash                                  = Action.Create({ Type = "Spell", ID = 121253     }),    
    RushingJadeWind                           = Action.Create({ Type = "Spell", ID = 116847, isTalent = true     }),    
    TigerPalm                                 = Action.Create({ Type = "Spell", ID = 100780     }),
    -- Auras 
    BreathofFireDotDebuff                    = Action.Create({ Type = "Spell", ID = 123725, Hidden = true }), 
    BlackoutComboBuff                       = Action.Create({ Type = "Spell", ID = 196736, Hidden = true }), 
    SpecialDelivery                           = Action.Create({ Type = "Spell", ID = 196730, isTalent = true, Hidden = true }),    
    LightBrewing                              = Action.Create({ Type = "Spell", ID = 196721, isTalent = true, Hidden = true }),
    -- Movememnt    
    Roll                                    = Action.Create({ Type = "Spell", ID = 109132    }),
    ChiTorpedo                                = Action.Create({ Type = "Spell", ID = 115008, isTalent = true    }),
    TranscendenceTransfer                    = Action.Create({ Type = "Spell", ID = 119996    }), -- not usable in APL but user can Queue it
    -- PvP
    DoubleBarrel                            = Action.Create({ Type = "Spell", ID = 202335, isTalent = true    }),
    MightyOxKick                            = Action.Create({ Type = "Spell", ID = 202370, isTalent = true    }),
    AvertHarm                                = Action.Create({ Type = "Spell", ID = 202162, isTalent = true    }),    
    CraftNimbleBrew                            = Action.Create({ Type = "Spell", ID = 213658, isTalent = true    }),
    NimbleBrew                                = Action.Create({ Type = "Item", ID = 137648, Color = "RED", QueueForbidden = true }),    
    -- Items
    BattlePotionOfAgility                     = Action.Create({ Type = "Potion", ID = 163223 }),    
    SuperiorBattlePotionOfAgility            = Action.Create({ Type = "Potion", ID = 168489 }),    
}

Action:CreateEssencesFor(ACTION_CONST_MONK_BREWMASTER)
local A = setmetatable(Action[ACTION_CONST_MONK_BREWMASTER], { __index = Action })

local Temp                                     = {
    TotalAndPhys                            = {"TotalImun", "DamagePhysImun"},
    TotalAndPhysKick                        = {"TotalImun", "DamagePhysImun", "KickImun"},
    TotalAndPhysAndCC                        = {"TotalImun", "DamagePhysImun", "CCTotalImun"},
    TotalAndPhysAndStun                     = {"TotalImun", "DamagePhysImun", "StunImun"},
    TotalAndPhysAndCCAndStun                 = {"TotalImun", "DamagePhysImun", "CCTotalImun", "StunImun"},
    TotalAndMag                                = {"TotalImun", "DamageMagicImun"},
}

local UnitStagger                             = UnitStagger
local GetTotemInfo, IsIndoors                 = GetTotemInfo, IsIndoors

local function IsSchoolFree()
    return LoC:IsMissed("SILENCE") and LoC:Get("SCHOOL_INTERRUPT", "NATURE") == 0
end 

-- [1] CC     AntiFake Rotation
A[1] = function(icon)    
    if     (
        A.IsUnitEnemy("target") and 
        A.LegSweepGreen:IsReady("target", true, nil, true) and 
        Unit("target"):GetRange() <= 5 and 
        Unit("target"):IsControlAble("stun", 0) and
        A.LegSweepGreen:AbsentImun("target", Temp.TotalAndPhysAndCCAndStun, true) 
    ) or 
    (
        A.IsUnitEnemy("mouseover") and 
        A.LegSweepGreen:IsReady("mouseover", true) and 
        Unit("mouseover"):GetRange() <= 5 and 
        Unit("mouseover"):IsControlAble("stun", 0) and
        A.LegSweepGreen:AbsentImun("mouseover", Temp.TotalAndPhysAndCCAndStun, true) 
    ) or
    (
        not A.IsUnitEnemy("target") and 
        not A.IsUnitEnemy("mouseover") and 
        A.LegSweepGreen:IsReady() and 
        (
            (A.IsInPvP and EnemyTeam():PlayersInRange(1, 5)) or 
            (not A.IsInPvP and MultiUnits:GetByRange(5, 1) >= 1)
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
    end 
    
    if unit then         
        local castLeft, _, _, _, notKickAble = Unit(unit):IsCastingRemains()
        if castLeft > 0 then             
            if not notKickAble and A.SpearHandStrikeGreen:IsReady(unit, nil, nil, true) and A.SpearHandStrikeGreen:AbsentImun(unit, Temp.TotalAndPhysKick, true) then
                return A.SpearHandStrikeGreen:Show(icon)                                                  
            end 
            
            if A.ParalysisAntiFake:IsReady(unit, nil, nil, true) and A.ParalysisAntiFake:AbsentImun(unit, Temp.TotalAndPhysAndCC, true) and Unit(unit):IsControlAble("incapacitate", 0) then
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
function Action.AutoPurify()
    -- Using by Dynamic bar also
    if A.IsInitialized and BrewmasterTools then 
        local lvl = BrewmasterTools.GetStaggerLevel()
        if (lvl > 1 and lvl < 3 and BrewmasterTools.GetStaggerProgress() > 80) or (lvl == 3 and BrewmasterTools.GetStaggerProgress() > 70) or (lvl == 4 and BrewmasterTools.GetStaggerProgress() > 50) or lvl > 4 then 
            return true, lvl
        end 
    end 
    return false, -1
end 

local function ShouldPurify()
    local Toggle = A.GetToggle(2, "ShouldPurify")
    local Purify, PurifyLVL = A.AutoPurify()
    return Purify and (Toggle == 0 or Toggle == PurifyLVL)
end 

local IronskinDuration = 7
local function SelfDeffensives()
    if Unit("player"):CombatTime() == 0 then 
        return 
    end 
    
    local BrewMaxCharge = 3 + (A.LightBrewing:IsSpellLearned() and 1 or 0)
    
    if     A.IronskinBrew:IsReady("player") and Unit("player"):HasBuffs(228563, true) == 0  
    and A.IronskinBrew:GetSpellChargesFrac() >= BrewMaxCharge - 0.1 - (Unit("player"):IsTanking("target", 8) and 1 + (Unit("player"):HasBuffs(A.IronskinBrew.ID, true) <= IronskinDuration * 0.5 and 0.5 or 0) or 0)
    and Unit("player"):HasBuffs(A.IronskinBrew.ID, true) <= IronskinDuration * 2 then 
        return A.IronskinBrew
    end 
    
    if A.PurifyingBrew:IsReady("player") and ShouldPurify() then 
        return A.PurifyingBrew
    end 
    
    if A.IronskinBrew:IsReady("player") and ShouldPurify() and Unit("player"):HasBuffs(228563, true) > 0 and Unit("player"):HasDeBuffs(243961) > 0 then -- T21 Antorus: Misery (Varimathras) 
        return A.IronskinBrew
    end 
    
    local HealingElixir = A.GetToggle(2, "HealingElixir")
    if     HealingElixir >= 0 and A.HealingElixir:IsReady("player") and IsSchoolFree() and
    (
        (     -- Auto 
            HealingElixir >= 85 and 
            (
                Unit("player"):HealthPercent() <= 20 or
                (                        
                    Unit("player"):HealthPercent() < 70 and 
                    A.HealingElixir:GetSpellChargesFrac() > 1.1
                ) or 
                (
                    Unit("player"):HealthPercent() < 40 and 
                    Unit("player"):IsTanking("target", 8)
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
    
    local ZenMeditation = A.GetToggle(2, "ZenMeditation")
    if     ZenMeditation >= 0 and A.ZenMeditation:IsReady("player") and Player:IsStayingTime() > 0.8 and IsSchoolFree() and 
    (
        (     -- Auto 
            ZenMeditation >= 100 and 
            (    -- Trying to catch kill strike by CLEU from latest hits
                Unit("player"):GetDMG() >= Unit("player"):Health() or 
                Unit("player"):GetRealTimeDMG() >= Unit("player"):Health() 
            )
        ) or 
        (    -- Custom
            -- Note: User should configure own cast bars through LUA in 'Actions' tab with own HP preset for advanced logic to catch boss's critical casting strikes
            ZenMeditation < 100 and 
            Unit("player"):HealthPercent() <= ZenMeditation
        )
    ) 
    then 
        return A.ZenMeditation
    end 
    
    if A.AvertHarm:IsReady("player") and Unit("player"):TimeToDie() > 15 and (FriendlyTeam(nil, 2):GetTTD(2, 18, 20) or FriendlyTeam(nil, 2):HealerIsFocused(true, true, 20)) then 
        return A.AvertHarm
    end 
    
    local Guard = A.GetToggle(2, "Guard") 
    if     Guard >= 0 and A.Guard:IsReady("player") and
    (
        (     -- Auto 
            Guard >= 100 and 
            UnitStagger("player") >= A.Guard:GetSpellDescription()[1]
        ) or 
        (    -- Custom
            Guard < 100 and 
            BrewmasterTools.GetStaggerPercent() >= Guard
        )
    ) 
    then 
        return A.Guard
    end 
    
    local DampenHarm = A.GetToggle(2, "DampenHarm")
    if     DampenHarm >= 0 and A.DampenHarm:IsReady("player") and Unit("player"):IsTanking("target", 8) and 
    (
        (     -- Auto 
            DampenHarm >= 100 and 
            (
                -- HP lose per sec >= 20
                Unit("player"):GetDMG() * 100 / Unit("player"):HealthMax() >= 20 or 
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
            DampenHarm < 100 and 
            Unit("player"):HealthPercent() <= DampenHarm
        )
    ) 
    then 
        return A.DampenHarm
    end 
    
    local FortifyingBrew = A.GetToggle(2, "FortifyingBrew")
    if     FortifyingBrew >= 0 and A.FortifyingBrew:IsReady("player") and Unit("player"):IsTanking("target", 8) and 
    (
        (     -- Auto 
            FortifyingBrew >= 100 and 
            (
                (
                    not A.IsInPvP and 
                    Unit("player"):HealthPercent() < 40 and 
                    Unit("player"):TimeToDieX(15) < 5 
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
    
    local Stoneform = A.GetToggle(2, "Stoneform")
    if     Stoneform >= 0 and A.Stoneform:IsRacialReadyP("player") and Unit("player"):IsTanking("target", 8) and 
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
    if A.Stoneform:AutoRacial("player") and not A.IsInPvP and A.AuraIsValid("player", "UseDispel", "Dispel") then 
        return A.Stoneform
    end 
    
    if A.AzerothsUndyingGift:AutoHeartOfAzeroth("player") then 
        return A.AzerothsUndyingGift
    end 
    
    if A.AegisoftheDeep:AutoHeartOfAzeroth("player") then 
        return A.AegisoftheDeep
    end 
    
    if A.EmpoweredNullBarrier:AutoHeartOfAzeroth("player") then 
        return A.EmpoweredNullBarrier
    end 
end 

local function BlackOxStatue()
    for i = 1, MAX_TOTEMS do 
        local have, name, start, duration = GetTotemInfo(i)
        if duration and duration == 900 then 
            return duration - (TMW.time - start)
        end 
    end 
    return 0
end

--[[
local function Niuzao()
    for i = 1, MAX_TOTEMS do 
        local have, name, start, duration = GetTotemInfo(i)
        if duration and duration == 45 then 
            return duration - (TMW.time - start)
        end 
    end 
    return 0
end
]]

local function ShouldTaunt(unit)
    if A.Zone ~= "none" then 
        if A.GetToggle(2, "AdditionalTaunt")[3] and BlackOxStatue() > 0 and A.ProvokeSummonBlackOxStatue:IsReady(unit, true) and (not A.IsInPvP or not A.Admonishment:IsSpellLearned()) and MultiUnits:GetByRangeTaunting(20, 2) >= 2 then
            return A.ProvokeSummonBlackOxStatue
        end 
        
        if A.Provoke:IsReady(unit) and (not A.IsInPvP or not A.Admonishment:IsSpellLearned() and not Unit(unit):IsPlayer() and not Unit(unit):IsTotem()) and Unit(unit):CombatTime() > 0 and not Unit(unit .. "target"):IsTank() then 
            return A.Provoke
        end         
    end 
    
    if A.Admonishment:IsReady(unit) and Unit(unit):IsPlayer() and Unit(unit):HasDeBuffs(206891) == 0 and A.Admonishment:AbsentImun(unit, Temp.TotalAndPhys) then 
        return A.Admonishment
    end     
end 

local function Interrupts(unit)
    local useKick, useCC, useRacial = A.InterruptIsValid(unit, "TargetMouseover")
    
    if useKick and A.SpearHandStrike:IsReady(unit) and A.SpearHandStrike:AbsentImun(unit, Temp.TotalAndPhysKick, true) and Unit(unit):CanInterrupt(true) then 
        return A.SpearHandStrike
    end 
    
    if useCC and A.Paralysis:IsReady(unit) and A.Paralysis:AbsentImun(unit, Temp.TotalAndPhysAndCC, true) and Unit(unit):IsControlAble("incapacitate", 0) then 
        return A.Paralysis                  
    end             
    
    if useRacial and A.QuakingPalm:AutoRacial(unit) then 
        return A.QuakingPalm
    end 
    
    if useRacial and A.Haymaker:AutoRacial(unit) then 
        return A.Haymaker
    end 
    
    if useRacial and A.WarStomp:AutoRacial(unit) then 
        return A.WarStomp
    end 
    
    if useRacial and A.BullRush:AutoRacial(unit) then 
        return A.BullRush
    end
    
    if useCC and A.LegSweep:IsReady(unit, true) and Unit(unit):GetRange() <= 5 and Unit(unit):IsCastingRemains() > A.GetCurrentGCD() + 0.1 and A.LegSweep:AbsentImun(unit, Temp.TotalAndPhysAndCCAndStun, true) and Unit(unit):IsControlAble("stun", 0) then
        return A.LegSweep     
    end     
end 

local function SharedMouseover()
    local unit = "mouseover"
    
    if A.ArcaneTorrent:AutoRacial(unit) then 
        return A.ArcaneTorrent
    end     
    
    if A.IsUnitFriendly("mouseover") then                 
        if Unit("player"):CombatTime() == 0 and Unit(unit):IsDead() and Unit("player"):GetCurrentSpeed() == 0 and A.Resuscitate:IsReady(unit) then 
            return A.Resuscitate
        end 
        
        if A.Detox:IsReady(unit) and A.Detox:AbsentImun(unit) and IsSchoolFree() and A.AuraIsValid(unit, "UseDispel", "Dispel") then 
            return A.Detox
        end 
        
        if A.TigersLust:IsReady(unit) and A.TigersLust:AbsentImun(unit) and IsSchoolFree() and Unit(unit):HasDeBuffs("Rooted") > A.GetGCD() then 
            return A.TigersLust
        end 
        
        if A.GiftofNaaru:AutoRacial(unit) then 
            return A.GiftofNaaru
        end 
        
        if A.Vivify:IsReady(unit) and A.Vivify:AbsentImun(unit) and IsSchoolFree() and Unit("player"):GetCurrentSpeed() == 0 and A.Vivify:PredictHeal("Vivify", unit) then 
            return A.Vivify
        end         
        
        if A.ConcentratedFlame:AutoHeartOfAzeroth(unit) then 
            return A.ConcentratedFlame
        end 
        
        if A.TigersLust:IsReady(unit) and A.TigersLust:AbsentImun(unit) and IsSchoolFree() then 
            local cMoving = Unit(unit):GetCurrentSpeed()
            if cMoving > 0 and cMoving <= 70 then 
                return A.TigersLust
            end 
        end 
        
        if A.GetToggle(2, "AoE") and A.ChiBurst:IsReady(unit, true) and A.ChiBurst:AbsentImun(unit) and IsSchoolFree() and Unit(unit):GetRange() <= 40 and Player:IsStaying() and A.ChiBurst:PredictHeal("ChiBurst", unit) and 
        (
            not A.IsInPvP or 
            not EnemyTeam("HEALER"):IsBreakAble(40)                
        )
        then 
            return A.ChiBurst
        end 
        
        if A.GetToggle(2, "AoE") and A.ChiWave:IsReady(unit, true) and A.ChiWave:AbsentImun(unit) and IsSchoolFree() and Unit(unit):GetRange() <= 25 and A.ChiWave:PredictHeal("ChiWave", unit) and
        (
            not A.IsInPvP or 
            not EnemyTeam("HEALER"):IsBreakAble(25)                
        )
        then 
            return A.ChiWave
        end 
    end 
    
    if A.IsUnitEnemy("mouseover") then 
        local Taunt = ShouldTaunt(unit)
        if Taunt then 
            return Taunt
        end 
        
        -- Interrupts 
        local Interrupt = Interrupts(unit)
        if Interrupt then 
            return Interrupt
        end 
        
        if A.ConcentratedFlame:AutoHeartOfAzeroth(unit) then 
            return A.ConcentratedFlame
        end 
        
        if     A.GetToggle(2, "AoE") and A.ChiBurst:IsReady(unit, true) and A.ChiBurst:AbsentImun(unit) and IsSchoolFree() and Unit(unit):GetRange() <= 40 and Player:IsStaying() and MultiUnits:GetByRange(40, 3) >= 3 and
        (
            not A.IsInPvP or 
            not EnemyTeam("HEALER"):IsBreakAble(40)                
        )
        then 
            return A.ChiBurst
        end         
        
        if     A.GetToggle(2, "AoE") and A.ChiWave:IsReady(unit, true) and A.ChiWave:AbsentImun(unit) and IsSchoolFree() and Unit(unit):GetRange() <= 25 and MultiUnits:GetByRange(25, 3) >= 3 and
        (
            not A.IsInPvP or 
            not EnemyTeam("HEALER"):IsBreakAble(25)                
        )
        then 
            return A.ChiWave
        end 
    end     
end 

-- [3] Single Rotation
A[3] = function(icon)
    local unit = "player"
    if Unit(unit):HasBuffs(A.ZenMeditation.ID, true) > 0 then 
        return 
    end 
    
    local Deffensive = SelfDeffensives()
    if Deffensive then 
        return Deffensive:Show(icon)
    end 
    
    -- Tiger Lust self if has flags on (R)BG
    if A.IsInPvP and A.TigersLust:IsReady("player") and IsSchoolFree() and Unit("player", 5):HasFlags() and not A.IsUnitFriendly("target") and not A.IsUnitFriendly("mouseover") then 
        if Unit("player"):HasDeBuffs("Rooted") > A.GetGCD() then 
            return A.TigersLust:Show(icon)
        end 
        
        local cMoving = Unit("player"):GetCurrentSpeed()
        if cMoving > 0 and (Unit("player"):CombatTime() == 0 and cMoving < 64 or Unit("player"):CombatTime() > 0 and cMoving <= 80) and not Player:IsFalling() then 
            return A.TigersLust:Show(icon)
        end 
    end 
    
    if Unit("player"):CombatTime() > 0 and (Unit("player"):HealthPercent() < 30 or Unit("player"):TimeToDie() < 5) then 
        if A.Trinket1:IsReady("player") and A.Trinket1:GetItemCategory() ~= "DPS" then 
            return A.Trinket1:Show(icon)
        end 
        
        if A.Trinket2:IsReady("player") and A.Trinket2:GetItemCategory() ~= "DPS" then 
            return A.Trinket2:Show(icon)
        end
    end     
    
    local Mouseover = SharedMouseover()
    if Mouseover then 
        return Mouseover:Show(icon)
    end 
    
    if Unit("player"):CombatTime() == 0 and A.CraftNimbleBrew:IsReady() and A.NimbleBrew:GetCount() < 2 and Unit("player"):GetCurrentSpeed() == 0 then 
        return A.CraftNimbleBrew:Show(icon)
    end 
    
    if A.ArcaneTorrent:AutoRacial("target") then 
        return A.ArcaneTorrent:Show(icon)
    end         
    
    if A.IsUnitFriendly("target") then 
        unit = "target"
        
        if Unit("player"):CombatTime() == 0 and Unit(unit):IsDead() and Unit("player"):GetCurrentSpeed() == 0 and A.Resuscitate:IsReady(unit) then 
            return A.Resuscitate:Show(icon)
        end 
        
        if A.Detox:IsReady(unit) and A.Detox:AbsentImun(unit) and IsSchoolFree() and A.AuraIsValid(unit, "UseDispel", "Dispel") then 
            return A.Detox:Show(icon)
        end 
        
        if A.TigersLust:IsReady(unit) and A.TigersLust:AbsentImun(unit) and IsSchoolFree() and Unit(unit):HasDeBuffs("Rooted") > A.GetGCD() then 
            return A.TigersLust:Show(icon)
        end 
        
        if A.GiftofNaaru:AutoRacial(unit) then 
            return A.GiftofNaaru:Show(icon)
        end 
        
        if A.Vivify:IsReady(unit) and A.Vivify:AbsentImun(unit) and IsSchoolFree() and Unit("player"):GetCurrentSpeed() == 0 and A.Vivify:PredictHeal("Vivify", unit) then 
            return A.Vivify:Show(icon)
        end         
        
        if A.ConcentratedFlame:AutoHeartOfAzeroth(unit) then 
            return A.ConcentratedFlame:Show(icon)
        end 
        
        if A.TigersLust:IsReady(unit) and A.TigersLust:AbsentImun(unit) and IsSchoolFree() then 
            local cMoving = Unit(unit):GetCurrentSpeed()
            if cMoving > 0 and cMoving < 64 then 
                return A.TigersLust:Show(icon)
            end 
        end 
        
        if     A.GetToggle(2, "AoE") and A.ChiBurst:IsReady(unit, true) and A.ChiBurst:AbsentImun(unit) and IsSchoolFree() and Unit(unit):GetRange() <= 40 and Player:IsStaying() and A.ChiBurst:PredictHeal("ChiBurst", unit) and 
        (
            not A.IsInPvP or 
            not EnemyTeam("HEALER"):IsBreakAble(40)                
        )
        then 
            return A.ChiBurst:Show(icon)
        end 
        
        if     A.GetToggle(2, "AoE") and A.ChiWave:IsReady(unit, true) and A.ChiWave:AbsentImun(unit) and IsSchoolFree() and Unit(unit):GetRange() <= 25 and A.ChiWave:PredictHeal("ChiWave", unit) and
        (
            not A.IsInPvP or 
            not EnemyTeam("HEALER"):IsBreakAble(25)                
        )
        then 
            return A.ChiWave:Show(icon)
        end 
    end 
    
    if A.IsUnitEnemy("target") then 
        unit = "target"
        local inMelee = A.TigerPalm:IsInRange(unit)
        
        -- Out of combat or Pull
        if Unit("player"):CombatTime() == 0 then         
            local Pull = A.BossMods_Pulling()
            if Pull < 2 and LoC:IsMissed("DISARM") then 
                if A.SuperiorBattlePotionOfAgility:IsReady(unit) then 
                    return A.SuperiorBattlePotionOfAgility:Show(icon)
                elseif A.BattlePotionOfAgility:IsReady(unit) then 
                    return A.BattlePotionOfAgility:Show(icon)
                end 
            end 
            
            if A.GetToggle(2, "AoE") and A.ChiBurst:IsReady(unit, true) and A.ChiBurst:AbsentImun(unit, Temp.TotalAndMag) and Unit(unit):GetRange() <= 40 and Player:IsStaying() and Pull < 2 then 
                return A.ChiBurst:Show(icon)
            end 
            
            if A.GetToggle(2, "AoE") and A.RushingJadeWind:IsReady(unit, true) and A.RushingJadeWind:AbsentImun(unit, Temp.TotalAndMag) and IsSchoolFree() and Unit(unit):GetRange() <= 40 and Pull < 3 and 
            (
                not A.IsInPvP or 
                (
                    Unit(unit):GetRange() <= 10 and -- 10 because we can moving IN so pre use it 
                    not EnemyTeam("HEALER"):IsBreakAble(12) -- 12 fair enough
                )
            )
            then 
                return A.RushingJadeWind:Show(icon)
            end
            
            if A.RippleinSpace:AutoHeartOfAzeroth(unit, true) and Unit(unit):GetRange() <= 25 and Pull < 2 then 
                return A.RippleinSpace:Show(icon)
            end 
            
            if Pull > 0 then 
                return 
            end 
        end 
        
        -- Taunting 
        if A.GetToggle(2, "AdditionalTaunt")[2] and A.SummonBlackOxStatue:IsReady(unit, true) and (not A.IsInPvP or not A.Admonishment:IsSpellLearned()) and MultiUnits:GetByRangeTaunting(20, 2) >= 2 then
            return A.SummonBlackOxStatue:Show(icon)
        end         
        
        local Taunt = ShouldTaunt(unit)
        if Taunt then 
            return Taunt:Show(icon)
        end         
        
        -- Interrupts
        local Interrupt = Interrupts(unit)
        if Interrupt then 
            return Interrupt:Show(icon)
        end         
        
        -- Burstings
        if A.BurstIsON(unit) and inMelee and A.AbsentImun(nil, unit, Temp.TotalAndPhys) and LoC:IsMissed("DISARM") then 
            if A.BloodFury:AutoRacial(unit) then 
                return A.BloodFury:Show(icon)
            end 
            
            if A.Fireblood:AutoRacial(unit) then 
                return A.Fireblood:Show(icon)
            end 
            
            if A.AncestralCall:AutoRacial(unit) then 
                return A.AncestralCall:Show(icon)
            end 
            
            if A.Berserking:AutoRacial(unit) then 
                return A.Berserking:Show(icon)
            end 
            
            if A.MemoryofLucidDreams:AutoHeartOfAzeroth(unit) then 
                return A.MemoryofLucidDreams:Show(icon)
            end 
            
            if A.Trinket1:IsReady(unit) and A.Trinket1:GetItemCategory() ~= "DEFF" and A.Trinket1:AbsentImun(unit, "DamageMagicImun") then 
                return A.Trinket1:Show(icon)
            end 
            
            if A.Trinket2:IsReady(unit) and A.Trinket2:GetItemCategory() ~= "DEFF" and A.Trinket2:AbsentImun(unit, "DamageMagicImun") then 
                return A.Trinket2:Show(icon)
            end                 
            
            if A.SuperiorBattlePotionOfAgility:IsReady(unit, true) then 
                return A.SuperiorBattlePotionOfAgility:Show(icon)
            end 
            
            if A.BattlePotionOfAgility:IsReady(unit, true) then 
                return A.BattlePotionOfAgility:Show(icon)
            end 
        end                 
        
        -- Additional Burst / Taunt
        if A.InvokeNiuzaotheBlackOx:IsReady(unit) and A.InvokeNiuzaotheBlackOx:AbsentImun(unit, Temp.TotalAndPhys) and IsSchoolFree() and (A.BurstIsON(unit) or A.GetToggle(2, "AdditionalTaunt")[1] and not Unit(unit):IsPlayer() and not Unit(unit):IsTotem() and Unit(unit):CombatTime() > 0 and not Unit(unit .. "target"):IsTank()) then 
            return A.InvokeNiuzaotheBlackOx:Show(icon)
        end 
        
        if A.WorldveinResonance:AutoHeartOfAzeroth(unit) then 
            return A.WorldveinResonance:Show(icon)
        end 
        
        -- PvP 
        if A.MightyOxKick:IsReady(unit) and A.MightyOxKick:AbsentImun(unit, Temp.TotalAndPhys) and Unit(unit):IsMovingOut() then 
            return A.MightyOxKick:Show(icon)
        end 
        
        if A.DoubleBarrel:IsReady(unit) and A.DoubleBarrel:AbsentImun(unit, Temp.TotalAndPhysAndStun) then 
            return A.DoubleBarrel:Show(icon)
        end 
        
        -- Custom APL
        if A.ConcentratedFlame:AutoHeartOfAzeroth(unit) then 
            return A.ConcentratedFlame:Show(icon)
        end 
        
        if A.GetToggle(2, "AoE") then 
            if A.AnimaofDeath:AutoHeartOfAzeroth(unit) then 
                return A.AnimaofDeath:Show(icon)
            end 
            
            if A.SuppressingPulse:AutoHeartOfAzeroth(unit) then 
                return A.SuppressingPulse:Show(icon)
            end         
            
            -- Arcane Pulse
            if A.ArcanePulse:AutoRacial(unit) then 
                return A.ArcanePulse:Show(icon)
            end         
        end
        
        -- Simcraft APL 
        if A.BlackOxBrew:IsReady("player") then             
            if A.IronskinBrew:GetSpellChargesFrac() <= 0.5 then 
                -- black_ox_brew,if=cooldown.brews.charges_fractional<=0.5
                return A.BlackOxBrew:Show(icon)
            else
                -- black_ox_brew,if=(energy+(energy.regen*cooldown.keg_smash.remains))<40&buff.blackout_combo.down&cooldown.keg_smash.up
                if Player:Energy() + (Player:EnergyRegen() * A.KegSmash:GetCooldown()) < 40 and Unit("player"):HasBuffs(A.BlackoutComboBuff.ID, true) == 0 and A.KegSmash:GetCooldown() > 0 then
                    -- dump current charges 
                    if A.IronskinBrew:GetSpellChargesFrac() >= 2 and BrewmasterTools.GetStaggerPercent() >= 1 then 
                        if A.IronskinBrew:GetSpellChargesFrac() >= 3 and A.IronskinBrew:IsReady("player") then 
                            return A.IronskinBrew:Show(icon)
                        end 
                        
                        if A.PurifyingBrew:IsReady("player") then 
                            return A.PurifyingBrew:Show(icon)
                        end
                    end 
                    
                    if A.IronskinBrew:GetSpellChargesFrac() >= 1 then 
                        if A.IronskinBrew:IsReady("player") then 
                            return A.IronskinBrew:Show(icon)
                        end 
                        
                        if A.PurifyingBrew:IsReady("player") and BrewmasterTools.GetStaggerPercent() >= 1 then 
                            return A.PurifyingBrew:Show(icon)
                        end
                    end 
                    
                    return A.BlackOxBrew:Show(icon)                                             
                end                 
            end 
        end 
        
        -- keg_smash,if=spell_targets>=2
        if  A.GetToggle(2, "AoE") and A.KegSmash:IsReady(unit) and A.KegSmash:AbsentImun(unit, Temp.TotalAndPhys) and MultiUnits:GetByRange(8, 2) >= 2 and 
        (
            not A.IsInPvP or 
            not EnemyTeam("HEALER"):IsBreakAble(8)
        ) 
        then 
            return A.KegSmash:Show(icon)
        end 
        
        -- tiger_palm
        if A.TigerPalm:IsReady(unit) and A.TigerPalm:AbsentImun(unit, Temp.TotalAndPhys) then 
            -- tiger_palm,if=talent.rushing_jade_wind.enabled&buff.blackout_combo.up&buff.rushing_jade_wind.up
            if A.RushingJadeWind:IsSpellLearned() and Unit("player"):HasBuffs(A.BlackoutComboBuff.ID, true) > 0 and Unit("player"):HasBuffs(A.RushingJadeWind.ID, true) > 0 then 
                return A.TigerPalm:Show(icon)
            end 
            
            -- tiger_palm,if=(talent.invoke_niuzao_the_black_ox.enabled|talent.special_delivery.enabled)&buff.blackout_combo.up
            if (A.InvokeNiuzaotheBlackOx:IsSpellLearned() or A.SpecialDelivery:IsSpellLearned()) and Unit("player"):HasBuffs(A.BlackoutComboBuff.ID, true) > 0 then 
                return A.TigerPalm:Show(icon)
            end     
        end 
        
        -- blackout_strike
        if A.BlackoutStrike:IsReady(unit) and A.BlackoutStrike:AbsentImun(unit, Temp.TotalAndPhys) and LoC:IsMissed("DISARM") then 
            return A.BlackoutStrike:Show(icon)
        end      
        
        -- keg_smash
        if     A.GetToggle(2, "AoE") and A.KegSmash:IsReady(unit) and A.KegSmash:AbsentImun(unit, Temp.TotalAndPhys) and 
        (
            not A.IsInPvP or 
            not EnemyTeam("HEALER"):IsBreakAble(8)
        ) 
        then 
            return A.KegSmash:Show(icon)
        end 
        
        -- rushing_jade_wind,if=buff.rushing_jade_wind.dow
        if     A.GetToggle(2, "AoE") and A.RushingJadeWind:IsReady(unit, true) and A.RushingJadeWind:AbsentImun(unit, Temp.TotalAndMag) and IsSchoolFree() and Unit(unit):GetRange() <= 8 and Unit("player"):HasBuffs(A.RushingJadeWind.ID, true) == 0 and 
        (
            not A.IsInPvP or 
            not EnemyTeam("HEALER"):IsBreakAble(8)                
        )
        then 
            return A.RushingJadeWind:Show(icon)
        end
        
        -- breath_of_fire,if=buff.blackout_combo.down&(buff.bloodlust.down|(buff.bloodlust.up&&dot.breath_of_fire_dot.refreshable))
        if     A.GetToggle(2, "AoE") and A.BreathofFire:IsReady(unit, true) and A.BreathofFire:AbsentImun(unit, Temp.TotalAndMag) and LoC:IsMissed("SILENCE") and Unit(unit):GetRange() <= 12 and (Unit("player"):HasBuffs(A.BlackoutComboBuff.ID, true) == 0 or (Unit("player"):HasBuffs("BurstHaste") == 0 or Unit(unit):PT(A.BreathofFireDotDebuff.ID, "debuff"))) and 
        (
            not A.IsInPvP or 
            not EnemyTeam("HEALER"):IsBreakAble(12)                
        )
        then 
            return A.BreathofFire:Show(icon)
        end 
        
        -- chi_burst
        if     A.GetToggle(2, "AoE") and A.ChiBurst:IsReady(unit, true) and A.ChiBurst:AbsentImun(unit, Temp.TotalAndMag) and IsSchoolFree() and Unit(unit):GetRange() <= 40 and Player:IsStaying() and 
        (
            not A.IsInPvP or 
            not EnemyTeam("HEALER"):IsBreakAble(40)                
        )
        then 
            return A.ChiBurst:Show(icon)
        end 
        
        -- chi_wave
        if     A.GetToggle(2, "AoE") and A.ChiWave:IsReady(unit, true) and A.ChiWave:AbsentImun(unit, Temp.TotalAndMag) and IsSchoolFree() and Unit(unit):GetRange() <= 25 and MultiUnits:GetByRange(25, 2) >= 2 and 
        (
            not A.IsInPvP or 
            not EnemyTeam("HEALER"):IsBreakAble(25)                
        )
        then 
            return A.ChiWave:Show(icon)
        end         
        
        -- Custom APL: Gift of Naaru
        if A.GiftofNaaru:AutoRacial("player") then 
            return A.GiftofNaaru:Show(icon)
        end     
        
        -- Custom APL: Expel Harm
        if Unit("player"):HealthPercent() < 80 and A.ExpelHarm:IsReady("player", true) and IsSchoolFree() then 
            local notOverHeal, Total = A.ExpelHarm:PredictHeal("ExpelHarm", "player")
            if notOverHeal and Total >= Unit("player"):HealthMax() * 0.1 then 
                return A.ExpelHarm:Show(icon)
            end 
        end         
        
        -- tiger_palm,if=!talent.blackout_combo.enabled&cooldown.keg_smash.remains>gcd&(energy+(energy.regen*(cooldown.keg_smash.remains+gcd)))>=65
        if A.TigerPalm:IsReady(unit) and A.TigerPalm:AbsentImun(unit, Temp.TotalAndMag) and (not A.BlackoutComboBuff:IsSpellLearned() and A.KegSmash:GetCooldown() > A.GetGCD() and (Player:Energy() + (Player:EnergyRegen() * (A.KegSmash:GetCooldown() + A.GetGCD()))) >= 65) then 
            return A.TigerPalm:Show(icon)
        end 
        
        -- arcane_torrent,if=energy<31
        if A.ArcaneTorrent:IsRacialReady(unit) and Player:Energy() < 31 then 
            return A.ArcaneTorrent:Show(icon)
        end 
        
        -- rushing_jade_wind
        if     A.GetToggle(2, "AoE") and A.RushingJadeWind:IsReady(unit, true) and A.RushingJadeWind:AbsentImun(unit, Temp.TotalAndMag) and IsSchoolFree() and MultiUnits:GetByRange(8, 2) >= 1 and 
        (
            not A.IsInPvP or 
            not EnemyTeam("HEALER"):IsBreakAble(8)                
        )
        then 
            return A.RushingJadeWind:Show(icon)
        end    
        
        -- Custom APL 
        -- Detox 
        if A.Detox:IsReady("player") and A.AuraIsValid("player", "UseDispel", "Dispel") and IsSchoolFree() then 
            return A.Detox:Show(icon)
        end 
        
        -- Tiger Lust
        if A.TigersLust:IsReady("player") and IsSchoolFree() then 
            if Unit("player"):HasDeBuffs("Rooted") > A.GetGCD() then 
                return A.TigersLust:Show(icon)
            end 
            
            local cMoving = Unit("player"):GetCurrentSpeed()
            if cMoving > 0 and (Unit("player"):CombatTime() == 0 and cMoving < 64 or Unit("player"):CombatTime() > 0 and cMoving <= 80) and not Player:IsFalling() then 
                return A.TigersLust:Show(icon)
            end 
        end                         
    end     
    
    -- Misc 
    if A.IsUnitEnemy("mouseover") and A.CracklingJadeLightning:IsReady("mouseover") and A.CracklingJadeLightning:AbsentImun("mouseover", Temp.TotalAndMag) and Player:IsStaying() and Unit("mouseover"):CombatTime() > 0 then
        return A.CracklingJadeLightning:Show(icon)
    end 
    
    if A.IsUnitEnemy("target") and Unit("target"):GetRange() > 8 and A.CracklingJadeLightning:IsReady("target") and A.CracklingJadeLightning:AbsentImun("target", Temp.TotalAndMag) and Player:IsStaying() then
        return A.CracklingJadeLightning:Show(icon)
    end 
    
    -- Movement
    if Player:IsMoving() and A.RippleinSpace:AutoHeartOfAzeroth("target") and Unit("target"):GetRange() > 15 and Unit("target"):GetRange() <= 25 then 
        return A.RippleinSpace:Show(icon)
    end 
    
    -- If not moving or moving lower than 2.5 sec 
    if Player:IsMovingTime() < 2.5 then 
        return 
    end 
    
    if not A.ChiTorpedo:IsSpellLearned() and A.Roll:IsReady(unit, true) and (Unit("target"):GetRange() > 15 or not Unit("target"):IsExists() and IsIndoors() and Unit("player"):CombatTime() == 0) then 
        return A.Roll:Show(icon)
    end 
    
    if A.ChiTorpedo:IsReady() and (Unit("target"):GetRange() > 25 or not Unit("target"):IsExists() and IsIndoors() and Unit("player"):CombatTime() == 0) then 
        return A.ChiTorpedo:Show(icon)
    end 
end

-- [5] Trinket Rotation
A[5] = function(icon)
    if A.IsInPvP then 
        if A.NimbleBrew:IsReady("player") and LoC:IsValid({"ROOT", "STUN", "FEAR", "HORROR"}, {"DISARM", "INCAPACITATE", "DISORIENT", "FREEZE", "SILENCE", "POSSESS", "SAP", "CYCLONE", "BANISH", "PACIFYSILENCE", "POLYMORPH", "SLEEP", "SHACKLE_UNDEAD"}) and A.NimbleBrew:GetCount() > 0 and A.NimbleBrew:GetItemCooldown() == 0 then 
            return A.NimbleBrew:Show(icon)             
        end 
        
        -- Niuzao's Essence (PvP talent) which removes slow effects 
        if A.IsSpellLearned(232876) and A.PurifyingBrew:IsReadyP("player") and LoC:IsMissed(A.LOC["Gnome"].Missed) then 
            local cSpeed = Unit("player"):GetCurrentSpeed()
            if cSpeed > 0 and cSpeed < 100 then 
                return A.PurifyingBrew:Show(icon)                 
            end 
        end 
    end                                                                 
end

-- [6] Passive 
A[6] = function(icon)
    if Unit("player"):HasBuffs(A.ZenMeditation.ID, true) > 0 or Player:IsMounted() then 
        return 
    end 
    
    if A.IsInPvP and A.GetToggle(1, "AutoTarget") and A.IsUnitEnemy("target") and not A.AbsentImun(nil, "target", Temp.TotalAndPhys) and MultiUnits:GetByRangeInCombat(8, 2) >= 2 then 
        A:Show(icon, ACTION_CONST_AUTOTARGET)             
        return true
    end 
end

local function PassiveRotation(unit)
    if Unit("player"):HasBuffs(A.ZenMeditation.ID, true) > 0 then 
        return 
    end     
    
    -- Detox 
    if A.Detox:IsReady(unit) and A.Detox:AbsentImun(unit) and IsSchoolFree() and A.AuraIsValid(unit, "UseDispel", "Dispel") and not Unit(unit):InLOS() then                         
        return A.Detox
    end 
    
    -- Tiger Lust
    if A.TigersLust:IsReady(unit) and A.TigersLust:AbsentImun(unit) and IsSchoolFree() and not Unit("player", 5):HasFlags() and (Unit(unit):IsMelee() or Unit(unit):IsFocused(nil, true)) and not Unit(unit):InLOS() then 
        if Unit(unit):HasDeBuffs("Rooted") > A.GetGCD() then 
            return A.TigersLust
        end 
        
        local cMoving = Unit(unit):GetCurrentSpeed()
        if cMoving > 0 and cMoving <= 70 then 
            return A.TigersLust
        end 
    end 
end 

A[7] = function(icon)
    local Passive = PassiveRotation("party1") 
    if Passive then 
        return Passive:Show(icon)
    end 
end

A[8] = function(icon)
    local Passive = PassiveRotation("party2") 
    if Passive then 
        return Passive:Show(icon)
    end                                                                     
end

