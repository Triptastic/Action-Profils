local Action                                 = Action
local Listener                                 = Action.Listener
local Create                                 = Action.Create
local GetToggle                                = Action.GetToggle
local GetGCD                                = Action.GetGCD
local GetCurrentGCD                            = Action.GetCurrentGCD
local ShouldStop                            = Action.ShouldStop
local BurstIsON                                = Action.BurstIsON
local AuraIsValid                            = Action.AuraIsValid
local InterruptIsValid                        = Action.InterruptIsValid
local BossMods_Pulling                        = Action.BossMods_Pulling
local FrameHasSpell                            = Action.FrameHasSpell

local Utils                                    = Action.Utils
local TeamCache                                = Action.TeamCache
local EnemyTeam                                = Action.EnemyTeam
local FriendlyTeam                            = Action.FriendlyTeam
local LoC                                     = Action.LossOfControl
local Player                                = Action.Player 
local MultiUnits                            = Action.MultiUnits
local UnitCooldown                            = Action.UnitCooldown
local Unit                                    = Action.Unit 
local IsUnitEnemy                            = Action.IsUnitEnemy
local IsUnitFriendly                        = Action.IsUnitFriendly

local _G, setmetatable                        = _G, setmetatable
local ACTION_CONST_AUTOTARGET                = _G.ACTION_CONST_AUTOTARGET
local ACTION_CONST_MONK_WINDWALKER            = _G.ACTION_CONST_MONK_WINDWALKER
local ACTION_CONST_SPELLID_FREEZING_TRAP    = _G.ACTION_CONST_SPELLID_FREEZING_TRAP

local IsIndoors, UnitIsUnit = 
IsIndoors, UnitIsUnit

Action[ACTION_CONST_MONK_WINDWALKER] = {
    -- Racial
    ArcaneTorrent                             = Create({ Type = "Spell", ID = 50613     }),
    BloodFury                                 = Create({ Type = "Spell", ID = 20572      }),
    Fireblood                                   = Create({ Type = "Spell", ID = 265221     }),
    AncestralCall                              = Create({ Type = "Spell", ID = 274738     }),
    Berserking                                = Create({ Type = "Spell", ID = 26297    }),
    ArcanePulse                                  = Create({ Type = "Spell", ID = 260364    }),
    QuakingPalm                                  = Create({ Type = "Spell", ID = 107079     }),
    Haymaker                                  = Create({ Type = "Spell", ID = 287712     }), 
    WarStomp                                  = Create({ Type = "Spell", ID = 20549     }),
    BullRush                                  = Create({ Type = "Spell", ID = 255654     }),    
    GiftofNaaru                               = Create({ Type = "Spell", ID = 59544    }),
    Shadowmeld                                  = Create({ Type = "Spell", ID = 58984    }), -- usable in Action Core 
    Stoneform                                  = Create({ Type = "Spell", ID = 20594    }), 
    WilloftheForsaken                          = Create({ Type = "Spell", ID = 7744    }), -- not usable in APL but user can Queue it    
    EscapeArtist                              = Create({ Type = "Spell", ID = 20589    }), -- not usable in APL but user can Queue it
    EveryManforHimself                          = Create({ Type = "Spell", ID = 59752    }), -- not usable in APL but user can Queue it
    -- CrownControl    
    Paralysis                                = Create({ Type = "Spell", ID = 115078    }),
    ParalysisAntiFake                        = Create({ Type = "Spell", ID = 115078, Desc = "[2] Kick", QueueForbidden = true                                }),
    LegSweep                                  = Create({ Type = "Spell", ID = 119381    }),
    LegSweepGreen                              = Create({ Type = "SpellSingleColor", ID = 119381, Color = "GREEN", Desc = "[1] CC", QueueForbidden = true         }),
    SpearHandStrike                              = Create({ Type = "Spell", ID = 116705    }),
    SpearHandStrikeGreen                    = Create({ Type = "SpellSingleColor", ID = 116705, Color = "GREEN", Desc = "[2] Kick", QueueForbidden = true     }),
    GrappleWeapon                            = Create({ Type = "Spell", ID = 233759, isTalent = true         }),    -- PvP Talent
    RingofPeace                                = Create({ Type = "Spell", ID = 116844, isTalent = true         }), -- Talent (not usable in APL but user can Queue it)
    -- Suppotive    
    Resuscitate                                  = Create({ Type = "Spell", ID = 115178, QueueForbidden = true    }), 
    Provoke                                      = Create({ Type = "Spell", ID = 115546, Desc = "[6] PvP Pets Taunt", QueueForbidden = true                        }),
    Vivify                                      = Create({ Type = "Spell", ID = 116670    }),
    Detox                                      = Create({ Type = "Spell", ID = 218164    }),
    TigersLust                                     = Create({ Type = "Spell", ID = 116841, isTalent = true            }), -- Talent 
    ReverseHarm                                     = Create({ Type = "Spell", ID = 287771, isTalent = true            }), -- PvP Talent 
    -- Self Defensives
    FortifyingBrew                            = Create({ Type = "Spell", ID = 201318, isTalent = true            }), -- PvP Talent
    DiffuseMagic                            = Create({ Type = "Spell", ID = 122783, isTalent = true         }), -- Talent 
    DampenHarm                                = Create({ Type = "Spell", ID = 122278, isTalent = true         }), -- Talent 
    TouchofKarma                            = Create({ Type = "Spell", ID = 122470     }), 
    -- Burst
    StormEarthAndFire                        = Create({ Type = "Spell", ID = 137639    }), 
    StormEarthAndFireFixate                    = Create({ Type = "Spell", ID = 221771    }), -- while StormEarthAndFire buff
    TouchofDeath                            = Create({ Type = "Spell", ID = 115080    }), 
    EnergizingElixir                        = Create({ Type = "Spell", ID = 115288, isTalent = true    }), -- Talent
    InvokeXuentheWhiteTiger                    = Create({ Type = "Spell", ID = 123904, isTalent = true    }), -- Talent
    Serenity                                = Create({ Type = "Spell", ID = 152173, isTalent = true    }), -- Talent (replace StormEarthAndFire)
    -- Rotation       
    FistoftheWhiteTiger                        = Create({ Type = "Spell", ID = 261947, isTalent = true    }), -- Talent
    ChiBurst                                  = Create({ Type = "Spell", ID = 123986, isTalent = true }), -- Talent 
    ChiWave                                   = Create({ Type = "Spell", ID = 115098, isTalent = true }),    -- Talent
    RushingJadeWind                            = Create({ Type = "Spell", ID = 116847, isTalent = true }),    -- Talent
    WhirlingDragonPunch                        = Create({ Type = "Spell", ID = 152175, isTalent = true }),    -- Talent
    TigereyeBrew                            = Create({ Type = "Spell", ID = 247483, isTalent = true }),    -- PvP Talent
    ReverseHarmOpener                        = Create({ Type = "Spell", ID = 287771, Desc = "Opener vs invis (arena)", isTalent = true    }), -- PvP Talent 
    Disable                                    = Create({ Type = "Spell", ID = 116095    }), 
    TigerPalm                                = Create({ Type = "Spell", ID = 100780    }), 
    FistsofFury                                = Create({ Type = "Spell", ID = 113656    }), 
    BlackoutKick                            = Create({ Type = "Spell", ID = 100784    }),
    CracklingJadeLightning                      = Create({ Type = "Spell", ID = 117952     }),    
    RisingSunKick                            = Create({ Type = "Spell", ID = 107428     }),    
    SpinningCraneKick                        = Create({ Type = "Spell", ID = 101546     }),    
    -- Movememnt    
    FlyingSerpentKick                        = Create({ Type = "Spell", ID = 101545    }),
    FlyingSerpentKickJump                    = Create({ Type = "Spell", ID = 115057     }), -- Action ID of FlyingSerpentKick
    Roll                                    = Create({ Type = "Spell", ID = 109132    }),
    ChiTorpedo                                = Create({ Type = "Spell", ID = 115008, isTalent = true    }), -- Talent 
    TranscendenceTransfer                    = Create({ Type = "Spell", ID = 119996    }), -- not usable in APL but user can Queue it
    -- Items
    PotionofUnbridledFury                     = Create({ Type = "Potion",  ID = 169299 }), 
    DribblingInkpod                            = Create({ Type = "Trinket", ID = 169319 }),
    PocketsizedComputationDevice            = Create({ Type = "Trinket", ID = 167555 }),
    AshvanesRazorCoral                        = Create({ Type = "Trinket", ID = 169311 }),    
    -- Hidden 
    TigerTailSweep                            = Create({ Type = "Spell", ID = 264348, Hidden = true, isTalent = true }), -- 4/1 Talent +2y increased range of LegSweep    
    RidetheWind                                = Create({ Type = "Spell", ID = 201372, Hidden = true, isTalent = true }), -- PvP Talent freedom by FlyingSerpentKick
    HitCombo                                = Create({ Type = "Spell", ID = 196741, Hidden = true }), -- Simcraft
    BlackoutKickBuff                        = Create({ Type = "Spell", ID = 116768, Hidden = true }), -- Simcraft
    DanceOfChijiBuff                        = Create({ Type = "Spell", ID = 286587, Hidden = true }), -- Simcraft
    MarkoftheCraneDebuff                    = Create({ Type = "Spell", ID = 228287, Hidden = true }), -- Simcraft
    OpenPalmStrikes                          = Create({ Type = "Spell", ID = 279918, Hidden = true }), -- Simcraft Azerite
    GloryoftheDawn                            = Create({ Type = "Spell", ID = 288634, Hidden = true }), -- Simcraft Azerite
    SwiftRoundhouse                            = Create({ Type = "Spell", ID = 277669, Hidden = true }), -- Simcraft Azerite
    SwiftRoundhouseBuff                        = Create({ Type = "Spell", ID = 278710, Hidden = true }), -- Simcraft Azerite
    RazorCoralDebuff                        = Create({ Type = "Spell", ID = 303568, Hidden = true }), -- Simcraft 
}

Action:CreateEssencesFor(ACTION_CONST_MONK_WINDWALKER)
local A = setmetatable(Action[ACTION_CONST_MONK_WINDWALKER], { __index = Action })

local player                                 = "player"
local PartyUnits
local Temp                                     = {
    TotalAndPhys                            = {"TotalImun", "DamagePhysImun"},
    TotalAndPhysKick                        = {"TotalImun", "DamagePhysImun", "KickImun"},
    TotalAndPhysAndCC                        = {"TotalImun", "DamagePhysImun", "CCTotalImun"},
    TotalAndPhysAndStun                     = {"TotalImun", "DamagePhysImun", "StunImun"},
    TotalAndPhysAndCCAndStun                 = {"TotalImun", "DamagePhysImun", "CCTotalImun", "StunImun"},
    TotalAndMag                                = {"TotalImun", "DamageMagicImun"},
    DisablePhys                                = {"TotalImun", "DamagePhysImun", "Freedom", "CCTotalImun"},
    DisableMag                                = {"TotalImun", "DamageMagicImun", "Freedom", "CCTotalImun"},
    SerenityBuffs                            = {A.StormEarthAndFire.ID, A.Serenity.ID},
    IsSlotTrinketBlocked                    = {
        [A.AshvanesRazorCoral.ID]            = true,
        [A.PocketsizedComputationDevice.ID] = true,
        [A.DribblingInkpod.ID]                = true, 
    },
}

local function IsSchoolFree()
    return LoC:IsMissed("SILENCE") and LoC:Get("SCHOOL_INTERRUPT", "NATURE") == 0
end 

-- [1] CC AntiFake Rotation
local function AntiFakeStun(unit) 
    return 
    IsUnitEnemy(unit) and  
    Unit(unit):GetRange() <= 5 + (A.TigerTailSweep:IsSpellLearned() and 2 or 0) and 
    Unit(unit):IsControlAble("stun", 0) and 
    A.LegSweepGreen:AbsentImun(unit, Temp.TotalAndPhysAndCCAndStun, true)          
end 
A[1] = function(icon)    
    if     A.LegSweepGreen:IsReady(nil, nil, nil, true) and 
    (
        AntiFakeStun("mouseover") or 
        AntiFakeStun("target") or 
        (
            not IsUnitEnemy("mouseover") and 
            not IsUnitEnemy("target") and                     
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
    if IsUnitEnemy("mouseover") then 
        unit = "mouseover"
    elseif IsUnitEnemy("target") then 
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
local function SelfDefensives()
    if Unit(player):CombatTime() == 0 then 
        return 
    end 
    
    local TouchofKarma = GetToggle(2, "TouchofKarma")
    if TouchofKarma >= 0 then 
        local unit
        if IsUnitEnemy("mouseover") then 
            unit = "mouseover"
        elseif IsUnitEnemy("target") then 
            unit = "target"
        end     
        
        if unit and A.TouchofKarma:IsReady(unit) and A.TouchofKarma:AbsentImun(unit, Temp.TotalAndPhys, true) then 
            if     (
                -- Auto 
                (
                    TouchofKarma >= 100 and 
                    (
                        Unit(player):TimeToDieX(30) < 2.5 or 
                        (
                            A.IsInPvP and 
                            Unit(player):HealthPercent() < 70 and 
                            Unit(player):IsFocused(nil, true) 
                        )
                    )
                ) or 
                -- Custom 
                (
                    TouchofKarma < 100 and 
                    Unit(player):HealthPercent() < TouchofKarma
                )
            ) and 
            (
                Unit(player):HasBuffs("DeffBuffs", true) == 0 or 
                Unit(player):HealthPercent() < 20
            )
            then 
                return A.TouchofKarma
            end 
        end 
    end 
    
    local DampenHarm = GetToggle(2, "DampenHarm")
    if     DampenHarm >= 0 and A.DampenHarm:IsReady(player) and 
    (
        (     -- Auto 
            DampenHarm >= 100 and 
            (
                -- HP lose per sec >= 20
                Unit(player):GetDMG() * 100 / Unit(player):HealthMax() >= 20 or 
                Unit(player):GetRealTimeDMG() >= Unit(player):HealthMax() * 0.20 or 
                -- TTD 
                Unit(player):TimeToDieX(25) < 5 or 
                (
                    A.IsInPvP and 
                    (
                        Unit(player):UseDeff() or 
                        (
                            Unit(player, 5):HasFlags() and 
                            Unit(player):GetRealTimeDMG() > 0 and 
                            Unit(player):IsFocused() 
                        )
                    )
                )
            ) and 
            Unit(player):HasBuffs("DeffBuffs", true) == 0
        ) or 
        (    -- Custom
            DampenHarm < 100 and 
            Unit(player):HealthPercent() <= DampenHarm
        )
    ) 
    then 
        return A.DampenHarm
    end     
    
    local DiffuseMagic = GetToggle(2, "DiffuseMagic")
    if     DiffuseMagic >= 0 and A.DiffuseMagic:IsReady(player) and 
    (
        (     -- Auto 
            DiffuseMagic >= 100 and 
            Unit(player):TimeToDieMagicX(35) < 5 and 
            -- Magic Damage still appear
            Unit(player):GetRealTimeDMG(4) > 0 and 
            Unit(player):HasBuffs("DeffBuffsMagic") == 0
        ) or 
        (    -- Custom
            DiffuseMagic < 100 and 
            Unit(player):HealthPercent() <= DiffuseMagic
        )
    ) 
    then 
        return A.DiffuseMagic
    end 
    
    local FortifyingBrew = GetToggle(2, "FortifyingBrew")
    if     FortifyingBrew >= 0 and A.FortifyingBrew:IsReady(player) and 
    (
        (     -- Auto 
            FortifyingBrew >= 100 and 
            (
                (
                    not A.IsInPvP and 
                    Unit(player):HealthPercent() < 40 and 
                    Unit(player):TimeToDieX(20) < 6 
                ) or 
                (
                    A.IsInPvP and 
                    (
                        Unit(player):UseDeff() or 
                        (
                            Unit(player, 5):HasFlags() and 
                            Unit(player):GetRealTimeDMG() > 0 and 
                            Unit(player):IsFocused(nil, true)                                 
                        )
                    )
                )
            ) and 
            Unit(player):HasBuffs("DeffBuffs") == 0
        ) or 
        (    -- Custom
            FortifyingBrew < 100 and 
            Unit(player):HealthPercent() <= FortifyingBrew
        )
    ) 
    then 
        return A.FortifyingBrew
    end 
    
    -- Stoneform on deffensive
    local Stoneform = GetToggle(2, "Stoneform")
    if     Stoneform >= 0 and A.Stoneform:IsRacialReadyP(player) and 
    (
        (     -- Auto 
            Stoneform >= 100 and 
            (
                (
                    not A.IsInPvP and                         
                    Unit(player):TimeToDieX(65) < 3 
                ) or 
                (
                    A.IsInPvP and 
                    (
                        Unit(player):UseDeff() or 
                        (
                            Unit(player, 5):HasFlags() and 
                            Unit(player):GetRealTimeDMG() > 0 and 
                            Unit(player):IsFocused()                                 
                        )
                    )
                )
            ) 
        ) or 
        (    -- Custom
            Stoneform < 100 and 
            Unit(player):HealthPercent() <= Stoneform
        )
    ) 
    then 
        return A.Stoneform
    end     
    
    -- Stoneform on self dispel (only PvE)
    if A.Stoneform:IsRacialReady(player, true) and not A.IsInPvP and AuraIsValid(player, "UseDispel", "Dispel") then 
        return A.Stoneform
    end 
end 
SelfDefensives = A.MakeFunctionCachedStatic(SelfDefensives)

local function Interrupts(unit)
    local useKick, useCC, useRacial = InterruptIsValid(unit, "TargetMouseover")    
    
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
    
    if useCC and A.LegSweep:IsReady(unit, true) and Unit(unit):GetRange() <= 5 + (A.TigerTailSweep:IsSpellLearned() and 2 or 0) and Unit(unit):IsCastingRemains() > GetCurrentGCD() + 0.1 and A.LegSweep:AbsentImun(unit, Temp.TotalAndPhysAndCCAndStun, true) and Unit(unit):IsControlAble("stun", 0) then
        return A.LegSweep     
    end 
end 
Interrupts = A.MakeFunctionCachedDynamic(Interrupts)

local function GetAttackType()
    if A.TigereyeBrew:IsSpellLearned() and Unit(player):HasBuffs(A.TigereyeBrew.ID, true, true) > 0 then 
        return Temp.TotalAndMag
    end  
    return Temp.TotalAndPhys
end 

local function GetAttackTypeForDisable()
    if A.TigereyeBrew:IsSpellLearned() and Unit(player):HasBuffs(A.TigereyeBrew.ID, true, true) > 0 then 
        return Temp.DisableMag
    end  
    return Temp.DisablePhys
end 

local useStormEarthAndFireFixate = false
local function PLAYER_TARGET_CHANGED()
    if Unit(player):HasSpec(ACTION_CONST_MONK_WINDWALKER) and not useStormEarthAndFireFixate and not A.Serenity:IsSpellLearned() and A.StormEarthAndFireFixate:IsReady("target") and IsUnitEnemy("target") then
        useStormEarthAndFireFixate = true 
    end 
end 
Listener:Add("MONK_WW_FIXATE", "PLAYER_TARGET_CHANGED", PLAYER_TARGET_CHANGED)

local function UNIT_SPELLCAST_SUCCEEDED(...)
    local source, _, spellID = ...
    if (source == player or source == "pet") and useStormEarthAndFireFixate and Unit(player):HasSpec(ACTION_CONST_MONK_WINDWALKER) and (spellID == A.StormEarthAndFireFixate.ID or Unit(player):HasBuffs(A.StormEarthAndFire.ID, true) == 0) then 
        useStormEarthAndFireFixate = false
    end 
end 
Listener:Add("MONK_WW_FIXATE", "UNIT_SPELLCAST_SUCCEEDED", UNIT_SPELLCAST_SUCCEEDED)

local function EvaluateTargetIfFilterMarkoftheCrane(TargetUnit)
    return Unit(TargetUnit):HasDeBuffs(A.MarkoftheCraneDebuff.ID) 
end

local function EvaluateTargetIfRisingSunKick(TargetUnit)
    return Unit(player):HasBuffs(A.StormEarthAndFire.ID) > 0 or A.WhirlingDragonPunch:GetCooldown() < 4
end

local function EvaluateTargetIfRisingSunKick2(TargetUnit)
    return Player:ChiDeficit() < 2
end

local function EvaluateTargetIfBlackoutKick(TargetUnit)
    return A.LastPlayerCastID ~= A.BlackoutKick.ID and (A.FistsofFury:GetCooldown() > 4 or Player:Chi() >= 4 or (Player:Chi() == 2 and A.LastPlayerCastID == A.TigerPalm.ID))
end

local function EvaluateTargetIfTigerPalm(TargetUnit)
    return A.LastPlayerCastID ~= A.TigerPalm.ID and Player:ChiDeficit() >= 2
end

-- [3] Single Rotation
A[3] = function(icon, isMulti)
    local unit = player
    local isMoving = Player:IsMoving()
    local inMelee = false
    
    local function EnemyRotation(unit)
        -- Variables
        inMelee = A.TigerPalm:IsInRange(unit)
        
        -- Misc 
        if     A.FlyingSerpentKickJump:IsReady(unit, true) and A.FlyingSerpentKick:GetSpellTimeSinceLastCast() <= 1.5 and isMoving and A.FlyingSerpentKickJump:GetSpellTimeSinceLastCast() > 0 and (Unit(unit):GetRange() <= 8 or ((isMulti or GetToggle(2, "AoE")) and MultiUnits:GetByRange(8, 1) >= 1)) and 
        (
            not A.IsInPvP or 
            not EnemyTeam("HEALER"):IsBreakAble(8) 
        )
        then 
            return A.FlyingSerpentKickJump:Show(icon)
        end 
        
        if unit ~= "mouseover" and useStormEarthAndFireFixate and A.StormEarthAndFireFixate:IsReady(unit) and IsSchoolFree() and not A.Serenity:IsSpellLearned() and Unit(player):HasBuffs(A.StormEarthAndFire.ID, true) > 0 then 
            return A.StormEarthAndFireFixate:Show(icon)
        end 
        
        -- Simcraft
        -- Rskless --
        local function Rskless()
            -- whirling_dragon_punch
            if     (isMulti or GetToggle(2, "AoE") or MultiUnits:GetByRange(8, 2) < 2) and A.WhirlingDragonPunch:IsReady(unit, true) and A.WhirlingDragonPunch:AbsentImun(unit, GetAttackType()) and Unit(unit):GetRange() <= 8 and not Unit(unit):IsTotem() and 
            (
                not A.IsInPvP or
                not EnemyTeam("HEALER"):IsBreakAble(8)
            )
            then 
                return A.WhirlingDragonPunch:Show(icon)
            end              
            
            -- fists_of_fury
            if    (isMulti or GetToggle(2, "AoE") or MultiUnits:GetByRange(8, 2) < 2) and A.FistsofFury:IsReady(unit, true) and A.FistsofFury:AbsentImun(unit, GetAttackType()) and LoC:IsMissed("DISARM") and Unit(unit):GetRange() <= 8 and not Unit(unit):IsTotem() and 
            (
                not A.IsInPvP or
                not EnemyTeam("HEALER"):IsBreakAble(8)
            )
            then 
                return A.FistsofFury:Show(icon)
            end 
            
            -- rising_sun_kick,target_if=min:debuff.mark_of_the_crane.remains,if=buff.storm_earth_and_fire.up|cooldown.whirling_dragon_punch.remains<4
            if A.RisingSunKick:IsReady(unit) and A.RisingSunKick:AbsentImun(unit, GetAttackType()) and Utils.CastTargetIf(A.RisingSunKick, 8, "min", EvaluateTargetIfFilterMarkoftheCrane, EvaluateTargetIfRisingSunKick) then 
                return A.RisingSunKick:Show(icon)
            end 
            
            -- rushing_jade_wind,if=buff.rushing_jade_wind.down&active_enemies>1
            if     (isMulti or GetToggle(2, "AoE")) and MultiUnits:GetByRange(8, 2) >= 2 and A.RushingJadeWind:IsReady(unit, true) and A.RushingJadeWind:AbsentImun(unit, Temp.TotalAndMag) and IsSchoolFree() and Unit(player):HasBuffs(A.RushingJadeWind.ID, true) == 0 and not Unit(unit):IsTotem() and
            (
                not A.IsInPvP or 
                not EnemyTeam("HEALER"):IsBreakAble(8) 
            )
            then
                return A.RushingJadeWind:Show(icon)
            end 
            
            -- reverse_harm,if=chi.max-chi>=2
            if A.ReverseHarm:IsReady(unit, true) and MultiUnits:GetByRange(5, 1) >= 1 and A.ReverseHarm:AbsentImun(unit, Temp.TotalAndMag) and IsSchoolFree() and not EnemyTeam("HEALER"):IsBreakAble(5) and Player:ChiDeficit() >= 2 and not Unit(unit):IsTotem() then
                local ReverseHarm = GetToggle(2, "ReverseHarm")
                if (ReverseHarm >= 100 and Unit(player):HealthPercent() <= 92) or (ReverseHarm < 100 and Unit(player):HealthPercent() <= ReverseHarm) then
                    return A.ReverseHarm:Show(icon)
                end 
            end 
            
            -- fist_of_the_white_tiger,if=chi<=2
            --
            ---- I commented this because no point of this since we already have condition for same thing above
            --if    (isMulti or GetToggle(2, "AoE") or MultiUnits:GetByRange(8, 2) < 2) and A.FistsofFury:IsReady(unit, true) and A.FistsofFury:AbsentImun(unit, GetAttackType()) and LoC:IsMissed("DISARM") and Unit(unit):GetRange() <= 8 and not Unit(unit):IsTotem() and Player:Chi() <= 2 and 
            --    (
            --        not A.IsInPvP or
            --        not EnemyTeam("HEALER"):IsBreakAble(8)
            --    )
            --then 
            --    return A.FistsofFury:Show(icon)
            --end 
            --
            
            -- energizing_elixir,if=chi<=3&energy<50
            if A.EnergizingElixir:IsReady(player) and A.EnergizingElixir:AbsentImun(unit, GetAttackType()) and Player:Chi() <= 3 and Player:Energy() < 50 and not Unit(unit):IsTotem() then 
                return A.EnergizingElixir:Show(icon)
            end
            
            -- spinning_crane_kick,if=!prev_gcd.1.spinning_crane_kick&buff.dance_of_chiji.up
            if     (isMulti or GetToggle(2, "AoE") or MultiUnits:GetByRange(8, 2) < 2) and A.SpinningCraneKick:IsReady(unit, true) and A.SpinningCraneKick:AbsentImun(unit, GetAttackType()) and Unit(unit):GetRange() <= 8 and A.LastPlayerCastID ~= A.SpinningCraneKick.ID and Unit(player):HasBuffs(A.DanceOfChijiBuff.ID, true) > 0 and not Unit(unit):IsTotem() and
            (
                not A.IsInPvP or 
                not EnemyTeam("HEALER"):IsBreakAble(8) 
            )
            then 
                return A.SpinningCraneKick:Show(icon)
            end 
            
            -- blackout_kick,target_if=min:debuff.mark_of_the_crane.remains,if=!prev_gcd.1.blackout_kick&(cooldown.fists_of_fury.remains>4|chi>=4|(chi=2&prev_gcd.1.tiger_palm))
            if A.BlackoutKick:IsReady(unit) and A.BlackoutKick:AbsentImun(unit, GetAttackType()) and Utils.CastTargetIf(A.BlackoutKick, 8, "min", EvaluateTargetIfFilterMarkoftheCrane, EvaluateTargetIfBlackoutKick) then 
                return A.BlackoutKick:Show(icon)
            end 
            
            -- chi_wave
            if     (isMulti or GetToggle(2, "AoE") or MultiUnits:GetByRange(25, 2) < 2) and A.ChiWave:IsReady(unit, true) and IsSchoolFree() and Unit(unit):GetRange() <= 25 and not Unit(unit):IsTotem() and             
            (
                not A.IsInPvP or 
                not EnemyTeam("HEALER"):IsBreakAble(25) 
            )
            then 
                return A.ChiWave:Show(icon)
            end 
            
            -- chi_burst,if=chi.max-chi>=1&active_enemies=1|chi.max-chi>=2
            if     (isMulti or GetToggle(2, "AoE") or MultiUnits:GetByRange(40, 2) < 2) and A.ChiBurst:IsReady(unit, true) and not isMoving and IsSchoolFree() and Unit(unit):GetRange() <= 40 and ((Player:ChiDeficit() >= 1 and MultiUnits:GetByRange(8, 2) < 2) or Player:ChiDeficit() >= 2) and not Unit(unit):IsTotem() and                      
            (
                not A.IsInPvP or 
                not EnemyTeam("HEALER"):IsBreakAble(40) 
            )
            then 
                return A.ChiBurst:Show(icon)
            end     
            
            -- flying_serpent_kick,if=prev_gcd.1.blackout_kick&chi>3&buff.swift_roundhouse.stack<2,interrupt=1        
            if  A.FlyingSerpentKick:IsReady(unit, true) and A.FlyingSerpentKick:AbsentImun(unit, GetAttackType()) and             
            (
                not A.IsInPvP or 
                not EnemyTeam("HEALER"):IsBreakAble(25) 
            ) and 
            (
                A.RidetheWind:IsSpellLearned() or
                LoC:IsMissed("ROOT")
            )
            then 
                if A.LastPlayerCastID == A.BlackoutKick.ID and Player:Chi() > 3 then 
                    return A.FlyingSerpentKick:Show(icon)
                end 
                
                if A.RidetheWind:IsSpellLearned() and not LoC:IsMissed("ROOT") then 
                    return A.FlyingSerpentKick:Show(icon)
                end 
            end 
            
            -- rising_sun_kick,target_if=min:debuff.mark_of_the_crane.remains,if=chi.max-chi<2
            if A.RisingSunKick:IsReady(unit) and A.RisingSunKick:AbsentImun(unit, GetAttackType()) and Utils.CastTargetIf(A.RisingSunKick, 8, "min", EvaluateTargetIfFilterMarkoftheCrane, EvaluateTargetIfRisingSunKick2) then 
                return A.RisingSunKick:Show(icon)
            end 
            
            -- tiger_palm,target_if=min:debuff.mark_of_the_crane.remains,if=!prev_gcd.1.tiger_palm&chi.max-chi>=2
            if A.TigerPalm:IsReady(unit) and A.TigerPalm:AbsentImun(unit, GetAttackType()) and Utils.CastTargetIf(A.TigerPalm, 8, "min", EvaluateTargetIfFilterMarkoftheCrane, EvaluateTargetIfTigerPalm) then
                return A.TigerPalm:Show(icon)
            end 
            
            -- rising_sun_kick,target_if=min:debuff.mark_of_the_crane.remains
            if A.RisingSunKick:IsReady(unit) and A.RisingSunKick:AbsentImun(unit, GetAttackType()) and Utils.CastTargetIf(A.RisingSunKick, 8, "min", EvaluateTargetIfFilterMarkoftheCrane) then 
                return A.RisingSunKick:Show(icon)
            end 
        end 
        
        -- Serenity --
        local function Serenity()
            -- actions.serenity=rising_sun_kick,target_if=min:debuff.mark_of_the_crane.remains,if=active_enemies<3|prev_gcd.1.spinning_crane_kick
            if A.RisingSunKick:IsReady(unit) and A.RisingSunKick:AbsentImun(unit, GetAttackType()) and (not GetToggle(2, "AoE") or MultiUnits:GetByRange(5, 3) < 3 or A.LastPlayerCastID == A.SpinningCraneKick.ID) then 
                return A.RisingSunKick:Show(icon)
            end 
            
            -- actions.serenity+=/fists_of_fury,if=(buff.bloodlust.up&prev_gcd.1.rising_sun_kick&!azerite.swift_roundhouse.enabled)|buff.serenity.remains<1|(active_enemies>1&active_enemies<5)
            if A.FistsofFury:IsReady(unit, true) and A.FistsofFury:AbsentImun(unit, GetAttackType()) and LoC:IsMissed("DISARM") and Unit(unit):GetRange() <= 8 and ((Unit(player):HasBuffs("BurstHaste") > 0 and A.LastPlayerCastID == A.RisingSunKick.ID and A.SwiftRoundhouse:GetAzeriteRank() == 0) or Unit(player):HasBuffs(A.Serenity.ID, true) < 1 or (not GetToggle(2, "AoE") or MultiUnits:GetByRange(8, 5) < 5)) then
                return A.FistsofFury:Show(icon)
            end 
            
            -- actions.serenity+=/spinning_crane_kick,if=!prev_gcd.1.spinning_crane_kick&(active_enemies>=3|(active_enemies=2&prev_gcd.1.blackout_kick))
            if GetToggle(2, "AoE") and A.SpinningCraneKick:IsReady(unit, true) and A.SpinningCraneKick:AbsentImun(unit, GetAttackType()) and Unit(unit):GetRange() <= 8 and (A.LastPlayerCastID ~= A.SpinningCraneKick.ID and (MultiUnits:GetByRange(8, 3) >= 3 or (MultiUnits:GetByRange(8, 3) >= 2 and A.LastPlayerCastID == A.BlackoutKick.ID))) then 
                return A.SpinningCraneKick:Show(icon)
            end 
            
            -- actions.serenity+=/blackout_kick,target_if=min:debuff.mark_of_the_crane.remains
            if A.BlackoutKick:IsReady(unit) and A.BlackoutKick:AbsentImun(unit, GetAttackType()) then 
                return A.BlackoutKick:Show(icon)
            end 
        end        
        
        -- ToD -- 
        local function ToD()
            if A.TouchofDeath:IsReady(unit) and A.TouchofDeath:AbsentImun(unit, GetAttackType()) then 
                local PSCDEquipped = Utils.PSCDEquipped()
                -- touch_of_death,if=equipped.cyclotronic_blast&target.time_to_die>9&cooldown.cyclotronic_blast.remains<=2
                if PSCDEquipped and Unit(unit):TimeToDie() > 9 and A.PocketsizedComputationDevice:GetCooldown() <= 2 then 
                    return A.TouchofDeath:Show(icon)
                end 
                
                -- touch_of_death,if=!equipped.cyclotronic_blast&equipped.dribbling_inkpod&target.time_to_die>9&(target.time_to_pct_30.remains>=130|target.time_to_pct_30.remains<8)
                if not PSCDEquipped and A.DribblingInkpod:GetEquipped() and Unit(unit):TimeToDie() > 9 and (Unit(unit):TimeToDieX(30) >= 130 or Unit(unit):TimeToDieX(30) < 8) then 
                    return A.TouchofDeath:Show(icon)
                end 
                
                -- touch_of_death,if=!equipped.cyclotronic_blast&!equipped.dribbling_inkpod&target.time_to_die>9
                if not PSCDEquipped and not A.DribblingInkpod:GetEquipped() and Unit(unit):TimeToDie() > 9 then 
                    return A.TouchofDeath:Show(icon)
                end 
            end 
        end 
        
        -- Out of combat or Pull
        if unit ~= "mouseover" and Unit(player):CombatTime() == 0 then             
            local Pull = BossMods_Pulling()  
            
            -- Timing
            local extra_time = GetCurrentGCD() + 0.1
            local RippleinSpace, RushingJadeWind, ChiWave, ChiBurst
            
            -- Rushing Jade Wind
            if     Pull > 0 and (isMulti or GetToggle(2, "AoE")) and A.RushingJadeWind:IsReady(unit, true, nil, true) and A.RushingJadeWind:AbsentImun(unit, Temp.TotalAndMag) and IsSchoolFree() and 
            (
                not A.IsInPvP or 
                (
                    Unit(unit):GetRange() <= 10 and -- 10 because we can moving IN so pre use it 
                    not EnemyTeam("HEALER"):IsBreakAble(12) -- 12 fair enough
                )
            )
            then 
                RushingJadeWind = true 
                extra_time = extra_time + GetGCD()
            end 
            
            -- actions.precombat+=/chi_wave
            if     Pull > 0 and (isMulti or GetToggle(2, "AoE")) and A.ChiWave:IsReady(unit, true, nil, true) and IsSchoolFree() and 
            (
                not A.IsInPvP or 
                (
                    Unit(unit):GetRange() <= 25 and
                    not EnemyTeam("HEALER"):IsBreakAble(25) 
                )
            )
            then 
                ChiWave = true 
                extra_time = extra_time + GetGCD()
            end 
            
            -- actions.precombat+=/chi_burst,if=(!talent.serenity.enabled|!talent.fist_of_the_white_tiger.enabled)
            if     Pull > 0 and (isMulti or GetToggle(2, "AoE")) and A.ChiBurst:IsReady(unit, true, nil, true) and not isMoving and IsSchoolFree() and (not A.Serenity:IsSpellLearned() or not A.FistoftheWhiteTiger:IsSpellLearned()) and                  
            (
                not A.IsInPvP or 
                (
                    Unit(unit):GetRange() <= 40 and
                    not EnemyTeam("HEALER"):IsBreakAble(40) 
                )
            )
            then 
                ChiBurst = true 
                extra_time = extra_time + A.ChiBurst:GetSpellCastTime()
            end 
            
            -- Azerite Essence
            if     A.RippleinSpace:AutoHeartOfAzeroth(unit, true) and Unit(unit):GetRange() <= 25 and 
            (
                not A.IsInPvP or 
                not EnemyTeam("HEALER"):IsBreakAble(25) 
            )
            then 
                RippleinSpace = true 
                extra_time = extra_time + GetGCD() 
            end 
            
            -- Pull Rotation
            if A.PotionofUnbridledFury:IsReady(unit) and LoC:IsMissed("DISARM") and Pull <= 3 then 
                return A.PotionofUnbridledFury:Show(icon)
            end     
            
            if RushingJadeWind and not ShouldStop() and Pull <= extra_time then 
                return A.RushingJadeWind:Show(icon)
            end
            
            if ChiWave and not ShouldStop() and Pull <= extra_time then 
                return A.ChiWave:Show(icon)
            end 
            
            if ChiBurst and not ShouldStop() and Pull <= extra_time then 
                return A.ChiBurst:Show(icon)
            end 
            
            if RippleinSpace and not ShouldStop() and Pull <= extra_time then 
                return A.RippleinSpace:Show(icon)
            end 
            
            if Pull > 0 then 
                return 
            end 
        end                              
        
        -- Purge
        if A.ArcaneTorrent:AutoRacial(unit) then 
            return A.ArcaneTorrent:Show(icon)
        end             
        
        -- Interrupts
        local Interrupt = Interrupts(unit)
        if Interrupt then 
            return Interrupt:Show(icon)
        end         
        
        -- PvP CrownControl 
        -- Grapple Weapon
        if A.GrappleWeaponIsReady(unit) then 
            return A.GrappleWeapon:Show(icon)
        end 
        
        -- PvP CrownControl (Enemy Healer) 
        -- Leg Sweep / Paralysis
        if A.IsInPvP then 
            local EnemyHealerUnitID = EnemyTeam("HEALER"):GetUnitID(5 + (A.TigerTailSweep:IsSpellLearned() and 2 or 0))
            
            -- Leg Sweep
            -- Note: Stun nearest healer if in range without CC and stun DR
            if EnemyHealerUnitID ~= "none" and not UnitIsUnit(unit, EnemyHealerUnitID) and A.LegSweep:IsReady(EnemyHealerUnitID, true) and A.LegSweep:AbsentImun(EnemyHealerUnitID, Temp.TotalAndPhysAndCCAndStun, true) and Unit(EnemyHealerUnitID):IsControlAble("stun", 50) and Unit(EnemyHealerUnitID):InCC() <= GetCurrentGCD() then
                return A.LegSweep:Show(icon)     
            end 
            
            -- Paralysis
            -- Note: Stop running primary target
            if not inMelee and Unit(unit):IsHealer() and A.Paralysis:IsReady(unit) and A.Paralysis:AbsentImun(EnemyHealerUnitID, Temp.TotalAndPhysAndCC, true) and Unit(unit):IsControlAble("incapacitate", 0) and Unit(unit):HasBuffs("Speed") > 0 and Unit(unit):InCC() <= GetCurrentGCD() then
                return A.Paralysis:Show(icon)     
            end              
        end 
        
        -- Disable (slow)
        if unit ~= "mouseover" and (A.IsInPvP or (not Unit(unit):IsBoss() and Unit(unit):IsMovingOut())) and A.Disable:IsReady(unit) and A.Disable:AbsentImun(unit, GetAttackTypeForDisable(), true) and Unit(unit):GetMaxSpeed() >= 100 and Unit(unit):HasDeBuffs("Slowed") == 0 and not Unit(unit):IsTotem() then 
            return A.Disable:Show(icon)
        end 
        
        -- PvP Switch our attack type to Magic type if unit got physic imun or if we reached cap
        if unit ~= "mouseover" and inMelee and A.TigereyeBrew:IsReady(player) and Unit(player):HasBuffs(A.TigereyeBrew.ID, true, true) == 0 and (A.TigereyeBrew:GetCount() >= 10 or (not A.TigereyeBrew:AbsentImun(unit, "DamagePhysImun", true) and A.TigereyeBrew:GetCount() >= 3)) then 
            return A.TigereyeBrew:Show(icon)
        end
        
        -- PvP Reverse Harm (opener)        
        if A.Zone == "arena" and Unit(player):CombatTime() > 0 and Unit(player):CombatTime() <= 5 and A.ReverseHarmOpener:IsReady(unit, true) and A.ReverseHarmOpener:AbsentImun(unit, Temp.TotalAndMag) and IsSchoolFree() and MultiUnits:GetByRange(5, 1) >= 1 and not EnemyTeam("HEALER"):IsBreakAble(5) and EnemyTeam():HasInvisibleUnits() and not Unit(unit):IsTotem() and Unit(player):HealthPercent() <= 99 then
            return A.ReverseHarmOpener:Show(icon)         
        end 
        
        -- actions+=/call_action_list,name=serenity,if=buff.serenity.up
        if unit ~= "mouseover" and A.Serenity:IsSpellLearned() and Unit(player):HasBuffs(A.Serenity.ID, true) > 0 and Serenity() then 
            return true 
        end 
        
        -- reverse_harm,if=(energy.time_to_max<1|(talent.serenity.enabled&cooldown.serenity.remains<2))&chi.max-chi>=2
        if A.ReverseHarm:IsReady(unit, true) and MultiUnits:GetByRange(5, 1) >= 1 and A.ReverseHarm:AbsentImun(unit, Temp.TotalAndMag) and IsSchoolFree() and not EnemyTeam("HEALER"):IsBreakAble(5) and not Unit(unit):IsTotem() and (Player:EnergyTimeToMaxPredicted() < 1 or (A.Serenity:IsSpellLearned() and A.Serenity:GetCooldown() < 2)) and Player:ChiDeficit() >= 2 then
            local ReverseHarm = GetToggle(2, "ReverseHarm")
            if (ReverseHarm >= 100 and Unit(player):HealthPercent() <= 92) or (ReverseHarm < 100 and Unit(player):HealthPercent() <= ReverseHarm) then
                return A.ReverseHarm:Show(icon)
            end 
        end         
        
        -- Bursting #1
        if unit ~= "mouseover" and BurstIsON(unit) and inMelee and A.AbsentImun(nil, unit, GetAttackType()) then 
            -- potion,if=buff.serenity.up|buff.storm_earth_and_fire.up|(!talent.serenity.enabled&trinket.proc.agility.react)|buff.bloodlust.react|target.time_to_die<=60
            if A.PotionofUnbridledFury:IsReady(unit) and (Unit(player):HasBuffs(Temp.SerenityBuffs, true) > 0 or Unit(player):HasBuffs("BurstHaste") > 0 or Unit(unit):TimeToDie() <= 60) then 
                return A.PotionofUnbridledFury:Show(icon)
            end 
            
            -- fist_of_the_white_tiger,if=(energy.time_to_max<1|(talent.serenity.enabled&cooldown.serenity.remains<2)|(energy.time_to_max<4&cooldown.fists_of_fury.remains<1.5))&chi.max-chi>=3
            if A.FistoftheWhiteTiger:IsReady(unit, true) and (Player:EnergyTimeToMaxPredicted() < 1 or (A.Serenity:IsSpellLearned() and A.Serenity:GetCooldown() < 2) or (Player:EnergyTimeToMaxPredicted() < 4 and A.FistsofFury:GetCooldown() < 1.5)) and Player:ChiDeficit() >= 3 then 
                return A.FistoftheWhiteTiger:Show(icon)
            end     
        end 
        
        -- tiger_palm,target_if=min:debuff.mark_of_the_crane.remains,if=(energy.time_to_max<1|(talent.serenity.enabled&cooldown.serenity.remains<2)|(energy.time_to_max<4&cooldown.fists_of_fury.remains<1.5))&chi.max-chi>=2&!prev_gcd.1.tiger_palm
        if unit ~= "mouseover" and A.TigerPalm:IsReady(unit) and A.TigerPalm:AbsentImun(unit, GetAttackType()) and ((Player:EnergyTimeToMaxPredicted() < 1 or (A.Serenity:IsSpellLearned() and A.Serenity:GetCooldown() < 2) or (Player:EnergyTimeToMaxPredicted() < 4 and A.FistsofFury:GetCooldown() < 1.5)) and Player:ChiDeficit() >= 2 and A.LastPlayerCastID ~= A.TigerPalm.ID) then
            return A.TigerPalm:Show(icon)
        end 
        
        -- Bursting #2
        if unit ~= "mouseover" and BurstIsON(unit) then             
            -- Simcraft 
            -- Cooldowns --
            -- actions.cd=invoke_xuen_the_white_tiger
            if A.InvokeXuentheWhiteTiger:IsReady(unit) and A.InvokeXuentheWhiteTiger:AbsentImun(unit, Temp.TotalAndMag) and IsSchoolFree() then 
                return A.InvokeXuentheWhiteTiger:Show(icon)
            end 
            
            if inMelee and A.AbsentImun(nil, unit, GetAttackType()) then 
                -- Racials 
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
                
                -- Trinkets
                if A.Trinket1:IsReady(unit) and A.Trinket1:GetItemCategory() ~= "DEFF" and A.Trinket1:AbsentImun(unit, "DamageMagicImun") and not Temp.IsSlotTrinketBlocked[A.Trinket1.ID] then 
                    return A.Trinket1:Show(icon)
                end 
                
                if A.Trinket2:IsReady(unit) and A.Trinket2:GetItemCategory() ~= "DEFF" and A.Trinket2:AbsentImun(unit, "DamageMagicImun") and not Temp.IsSlotTrinketBlocked[A.Trinket2.ID] then 
                    return A.Trinket2:Show(icon)
                end         
                
                -- use_item,name=pocketsized_computation_device,if=dot.touch_of_death.remains
                if Utils.CyclotronicBlastReady() and A.PocketsizedComputationDevice:IsReady(unit, true) and Unit(unit):HasDeBuffs(A.TouchofDeath.ID, true) > 0 then
                    return A.PocketsizedComputationDevice:Show(icon)
                end
                
                -- use_item,name=ashvanes_razor_coral,if=((equipped.cyclotronic_blast&cooldown.cyclotronic_blast.remains>=20)|!equipped.cyclotronic_blast)&(debuff.razor_coral_debuff.down|(!equipped.dribbling_inkpod|target.time_to_pct_30.remains<8)&buff.storm_earth_and_fire.remains>13|target.time_to_die<21)
                if A.AshvanesRazorCoral:IsReady(unit, true) and (((A.PocketsizedComputationDevice:GetEquipped() and A.PocketsizedComputationDevice:GetCooldown() >= 20) or not A.PocketsizedComputationDevice:GetEquipped()) and (Unit(unit):HasDeBuffs(A.RazorCoralDebuff.ID, true) == 0 or (not A.DribblingInkpod:GetEquipped() or Unit(unit):TimeToDieX(30) < 8) and Unit(player):HasBuffs(A.StormEarthAndFire.ID, true) > 13 or Unit(unit):TimeToDie() < 21)) then 
                    return A.AshvanesRazorCoral:Show(icon)
                end 
            end 
            
            -- actions.cd+=/arcane_torrent,if=chi.max-chi>=1&energy.time_to_max>=0.5
            if A.ArcaneTorrent:IsRacialReady(unit) and Player:ChiDeficit() >= 1 and Player:EnergyTimeToMaxPredicted() > 0.5 then
                return A.ArcaneTorrent:Show(icon)
            end 
            
            -- actions.cd+=/touch_of_death,if=target.time_to_die>9
            --if A.TouchofDeath:IsReady(unit) and A.TouchofDeath:AbsentImun(unit, GetAttackType()) and Unit(unit):TimeToDie() > 9 then 
            --    return A.TouchofDeath:Show(icon)
            --end 
            
            -- call_action_list,name=tod
            if ToD() then 
                return true 
            end 
            
            -- actions.cd+=/storm_earth_and_fire,if=cooldown.storm_earth_and_fire.charges=2|(cooldown.fists_of_fury.remains<=9&chi>=3&cooldown.whirling_dragon_punch.remains<=14&cooldown.touch_of_death.remains>=90)|target.time_to_die<=15|dot.touch_of_death.remains
            if not A.Serenity:IsSpellLearned() and inMelee and A.StormEarthAndFire:IsReady(unit, true) and A.StormEarthAndFire:AbsentImun(unit, GetAttackType()) and IsSchoolFree() and Unit(player):HasBuffs(A.StormEarthAndFire.ID, true) == 0 and (A.StormEarthAndFire:GetSpellCharges() >= 2 or (A.FistsofFury:GetCooldown() <= 9 and Player:Chi() >= 3 and A.WhirlingDragonPunch:GetCooldown() <= 14 and A.TouchofDeath:GetCooldown() >= 90) or Unit(unit):TimeToDie() <= 15 or Unit(unit):HasDeBuffs(A.TouchofDeath.ID, true) > 0) then 
                return A.StormEarthAndFire:Show(icon)
            end 
            
            -- actions.cd+=/serenity,if=cooldown.rising_sun_kick.remains<=2|target.time_to_die<=12
            if inMelee and A.Serenity:IsReady(unit, true) and A.Serenity:AbsentImun(unit, GetAttackType()) and Unit(player):HasBuffs(A.Serenity.ID, true) == 0 and (A.RisingSunKick:GetCooldown() <= 2 or Unit(unit):TimeToDie() <= 12) then
                return A.Serenity:Show(icon)
            end 
            
            -- call_action_list,name=essences
            if (isMulti or GetToggle(2, "AoE")) and A.BloodoftheEnemy:AutoHeartOfAzeroth(unit) then                                 
                return A.BloodoftheEnemy:Show(icon)                                                 
            end 
            
            if A.FocusedAzeriteBeam:AutoHeartOfAzeroth(unit) then 
                return A.FocusedAzeriteBeam:Show(icon)
            end 
            
            if A.GuardianofAzeroth:AutoHeartOfAzeroth(unit) then 
                return A.GuardianofAzeroth:Show(icon)
            end 
            
            if A.MemoryofLucidDreams:AutoHeartOfAzeroth(unit) and Player:Energy() < 40 and Unit(player):HasBuffs(Temp.SerenityBuffs, true) > 0 then 
                return A.MemoryofLucidDreams:Show(icon)
            end
            
            if A.WorldveinResonance:AutoHeartOfAzeroth(unit) then 
                return A.WorldveinResonance:Show(icon)
            end 
        end
        
        -- call_action_list,name=rskless,if=active_enemies<3&azerite.open_palm_strikes.enabled&!azerite.glory_of_the_dawn.enabled
        if A.OpenPalmStrikes:GetAzeriteRank() > 0 and A.GloryoftheDawn:GetAzeriteRank() > 0 and MultiUnits:GetByRange(8, 3) < 3 and Rskless() then 
            return true 
        end 
        
        if A.ConcentratedFlame:AutoHeartOfAzeroth(unit) then 
            return A.ConcentratedFlame:Show(icon)
        end 
        
        if A.RippleinSpace:AutoHeartOfAzeroth(unit) and Unit(unit):GetRange() <= 25 then 
            return A.RippleinSpace:Show(icon)
        end 
        
        if (isMulti or GetToggle(2, "AoE")) and A.PurifyingBlast:AutoHeartOfAzeroth(unit) then 
            return A.PurifyingBlast:Show(icon)
        end 
        
        if unit ~= "mouseover" and A.TheUnboundForce:AutoHeartOfAzeroth(unit) then 
            return A.TheUnboundForce:Show(icon)
        end 
        
        -- AoE 
        if unit ~= "mouseover" and (isMulti or (GetToggle(2, "AoE") and MultiUnits:GetByRange(8, 3) >= 3)) and not Unit(unit):IsTotem() then 
            -- Arcane Pulse
            if A.ArcanePulse:AutoRacial(unit) then 
                return A.ArcanePulse:Show(icon)
            end             
            
            -- actions.aoe=rising_sun_kick,target_if=min:debuff.mark_of_the_crane.remains,if=(talent.whirling_dragon_punch.enabled&cooldown.whirling_dragon_punch.remains<5)&cooldown.fists_of_fury.remains>3
            if A.RisingSunKick:IsReady(unit) and A.RisingSunKick:AbsentImun(unit, GetAttackType()) and A.WhirlingDragonPunch:IsSpellLearned() and A.WhirlingDragonPunch:GetCooldown() < 5 and A.FistsofFury:GetCooldown() > 3 then 
                return A.RisingSunKick:Show(icon)
            end 
            
            -- actions.aoe=whirling_dragon_punch
            if     A.WhirlingDragonPunch:IsReady(unit, true) and A.WhirlingDragonPunch:AbsentImun(unit, GetAttackType()) and 
            (
                not A.IsInPvP or
                not EnemyTeam("HEALER"):IsBreakAble(8)
            )
            then 
                return A.WhirlingDragonPunch:Show(icon)
            end 
            
            -- actions.aoe+=/energizing_elixir,if=!prev_gcd.1.tiger_palm&chi<=1&energy<50
            if A.EnergizingElixir:IsReady(player) and A.EnergizingElixir:AbsentImun(unit, GetAttackType()) and A.LastPlayerCastID ~= A.TigerPalm.ID and Player:Chi() <= 1 and Player:EnergyPredicted() < 50 then 
                return A.EnergizingElixir:Show(icon)
            end 
            
            -- actions.aoe+=/fists_of_fury,if=energy.time_to_max>3
            if    A.FistsofFury:IsReady(unit, true) and A.FistsofFury:AbsentImun(unit, GetAttackType()) and LoC:IsMissed("DISARM") and Unit(unit):GetRange() <= 8 and Player:EnergyTimeToMaxPredicted() > 3 and 
            (
                not A.IsInPvP or
                not EnemyTeam("HEALER"):IsBreakAble(8)
            )
            then 
                return A.FistsofFury:Show(icon)
            end 
            
            -- actions.aoe+=/rushing_jade_wind,if=buff.rushing_jade_wind.down
            if     A.RushingJadeWind:IsReady(unit, true) and A.RushingJadeWind:AbsentImun(unit, Temp.TotalAndMag) and IsSchoolFree() and Unit(unit):GetRange() <= 8 and Unit(player):HasBuffs(A.RushingJadeWind.ID, true) == 0 and
            (
                not A.IsInPvP or 
                not EnemyTeam("HEALER"):IsBreakAble(8) 
            )
            then
                return A.RushingJadeWind:Show(icon)
            end 
            
            -- actions.aoe+=/spinning_crane_kick,if=!prev_gcd.1.spinning_crane_kick&((chi>3|cooldown.fists_of_fury.remains>6)&(chi>=5|cooldown.fists_of_fury.remains>2)|energy.time_to_max<=3)
            if     A.SpinningCraneKick:IsReady(unit, true) and A.SpinningCraneKick:AbsentImun(unit, GetAttackType()) and Unit(unit):GetRange() <= 8 and (A.LastPlayerCastID ~= A.SpinningCraneKick.ID and (((Player:Chi() > 3 or A.FistsofFury:GetCooldown() > 6) and (Player:Chi() >= 5 or A.FistsofFury:GetCooldown() > 2)) or Player:EnergyTimeToMaxPredicted() <= 3)) and
            (
                not A.IsInPvP or 
                not EnemyTeam("HEALER"):IsBreakAble(8) 
            )
            then 
                return A.SpinningCraneKick:Show(icon)
            end 
            
            -- actions.aoe+=/reverse_harm,if=chi.max-chi>=2
            if A.ReverseHarm:IsReady(unit, true) and MultiUnits:GetByRange(5, 1) >= 1 and A.ReverseHarm:AbsentImun(unit, Temp.TotalAndMag) and IsSchoolFree() and not EnemyTeam("HEALER"):IsBreakAble(5) and Player:ChiDeficit() >= 2 then
                local ReverseHarm = GetToggle(2, "ReverseHarm")
                if (ReverseHarm >= 100 and Unit(player):HealthPercent() <= 92) or (ReverseHarm < 100 and Unit(player):HealthPercent() <= ReverseHarm) then
                    return A.ReverseHarm:Show(icon)
                end 
            end 
            
            -- actions.aoe+=/chi_burst,if=chi<=3
            if     A.ChiBurst:IsReady(unit, true) and not isMoving and IsSchoolFree() and Player:ChiDeficit() <= 3 and Unit(unit):GetRange() <= 40 and                 
            (
                not A.IsInPvP or 
                not EnemyTeam("HEALER"):IsBreakAble(40) 
            )
            then 
                return A.ChiBurst:Show(icon)
            end 
            
            -- actions.aoe+=/fist_of_the_white_tiger,if=chi.max-chi>=3
            if A.FistoftheWhiteTiger:IsReady(unit) and A.FistoftheWhiteTiger:AbsentImun(unit, GetAttackType()) and Player:ChiDeficit() >= 3 then 
                return A.FistoftheWhiteTiger:Show(icon)
            end 
            
            -- actions.aoe+=/tiger_palm,target_if=min:debuff.mark_of_the_crane.remains,if=chi.max-chi>=2&(!talent.hit_combo.enabled|!prev_gcd.1.tiger_palm)
            if A.TigerPalm:IsReady(unit) and A.TigerPalm:AbsentImun(unit, GetAttackType()) and Player:ChiDeficit() >= 2 and (not A.HitCombo:IsSpellLearned() or A.LastPlayerCastID ~= A.TigerPalm.ID) then
                return A.TigerPalm:Show(icon)
            end 
            
            -- actions.st+=/chi_wave
            if     A.ChiWave:IsReady(unit, true) and IsSchoolFree() and Unit(unit):GetRange() <= 25 and                 
            (
                not A.IsInPvP or 
                not EnemyTeam("HEALER"):IsBreakAble(25) 
            )
            then 
                return A.ChiWave:Show(icon)
            end 
            
            -- actions.aoe+=/flying_serpent_kick,if=buff.bok_proc.down,interrupt=1
            if     A.FlyingSerpentKick:IsReady(unit, true) and A.FlyingSerpentKick:AbsentImun(unit, GetAttackType()) and Unit(player):HasBuffs(A.BlackoutKickBuff.ID, true) == 0 and             
            (
                not A.IsInPvP or 
                not EnemyTeam("HEALER"):IsBreakAble(25) 
            )
            then 
                return A.FlyingSerpentKick:Show(icon)
            end 
            
            -- actions.aoe+=/blackout_kick,target_if=min:debuff.mark_of_the_crane.remains,if=!prev_gcd.1.blackout_kick&(buff.bok_proc.up|(talent.hit_combo.enabled&prev_gcd.1.tiger_palm&chi<4))
            if A.BlackoutKick:IsReady(unit) and A.BlackoutKick:AbsentImun(unit, GetAttackType()) and (A.LastPlayerCastID ~= A.BlackoutKick.ID and (Unit(player):HasBuffs(A.BlackoutKickBuff.ID, true) > 0 or (A.HitCombo:IsSpellLearned() and A.LastPlayerCastID == A.TigerPalm.ID and Player:Chi() < 4))) then 
                return A.BlackoutKick:Show(icon)
            end 
        end 
        
        -- Custom 
        if unit == "mouseover" and not Unit(unit):IsTotem() then 
            -- actions.mouseover+=/whirling_dragon_punch
            if     (GetToggle(2, "AoE") or MultiUnits:GetByRange(8, 2) < 2) and A.WhirlingDragonPunch:IsReady(unit, true) and A.WhirlingDragonPunch:AbsentImun(unit, GetAttackType()) and Unit(unit):GetRange() <= 8 and
            (
                not A.IsInPvP or
                not EnemyTeam("HEALER"):IsBreakAble(8)
            )
            then 
                return A.WhirlingDragonPunch:Show(icon)
            end 
            
            -- actions.mouseover+=/spinning_crane_kick,if=!prev_gcd.1.spinning_crane_kick&buff.dance_of_chiji.up
            if     (GetToggle(2, "AoE") or MultiUnits:GetByRange(8, 2) < 2) and A.SpinningCraneKick:IsReady(unit, true) and A.SpinningCraneKick:AbsentImun(unit, GetAttackType()) and Unit(unit):GetRange() <= 8 and A.LastPlayerCastID ~= A.SpinningCraneKick.ID and Unit(player):HasBuffs(A.DanceOfChijiBuff.ID, true) > 0 and
            (
                not A.IsInPvP or 
                not EnemyTeam("HEALER"):IsBreakAble(8) 
            )
            then 
                return A.SpinningCraneKick:Show(icon)
            end 
            
            -- actions.mouseover+=/rushing_jade_wind,if=buff.rushing_jade_wind.down&active_enemies>1
            if     GetToggle(2, "AoE") and MultiUnits:GetByRange(8, 2) >= 2 and A.RushingJadeWind:IsReady(unit, true) and A.RushingJadeWind:AbsentImun(unit, Temp.TotalAndMag) and IsSchoolFree() and Unit(unit):GetRange() <= 8 and Unit(player):HasBuffs(A.RushingJadeWind.ID, true) == 0 and
            (
                not A.IsInPvP or 
                not EnemyTeam("HEALER"):IsBreakAble(8) 
            )
            then
                return A.RushingJadeWind:Show(icon)
            end 
            
            -- actions.mouseover+=/chi_wave
            if     (GetToggle(2, "AoE") or MultiUnits:GetByRange(25, 2) < 2) and A.ChiWave:IsReady(unit, true) and IsSchoolFree() and Unit(unit):GetRange() <= 25 and                 
            (
                not A.IsInPvP or 
                not EnemyTeam("HEALER"):IsBreakAble(25) 
            )
            then 
                return A.ChiWave:Show(icon)
            end 
            
            -- actions.mouseover+=/chi_burst,if=chi.max-chi>=1&active_enemies=1|chi.max-chi>=2
            if     (GetToggle(2, "AoE") or MultiUnits:GetByRange(40, 2) < 2) and A.ChiBurst:IsReady(unit, true) and not isMoving and IsSchoolFree() and Unit(unit):GetRange() <= 40 and ((Player:ChiDeficit() >= 1 and MultiUnits:GetByRange(8, 2) < 2) or Player:ChiDeficit() >= 2) and                   
            (
                not A.IsInPvP or 
                not EnemyTeam("HEALER"):IsBreakAble(40) 
            )
            then 
                return A.ChiBurst:Show(icon)
            end 
        end 
        
        -- Single 
        if unit ~= "mouseover" then 
            -- Arcane Pulse
            if A.ArcanePulse:AutoRacial(unit) then 
                return A.ArcanePulse:Show(icon)
            end                         
            
            -- actions.st+=/whirling_dragon_punch
            if     (GetToggle(2, "AoE") or MultiUnits:GetByRange(8, 2) < 2) and A.WhirlingDragonPunch:IsReady(unit, true) and A.WhirlingDragonPunch:AbsentImun(unit, GetAttackType()) and Unit(unit):GetRange() <= 8 and not Unit(unit):IsTotem() and 
            (
                not A.IsInPvP or
                not EnemyTeam("HEALER"):IsBreakAble(8)
            )
            then 
                return A.WhirlingDragonPunch:Show(icon)
            end         
            
            -- actions.st+=/rising_sun_kick,target_if=min:debuff.mark_of_the_crane.remains,if=chi>=5
            if A.RisingSunKick:IsReady(unit) and A.RisingSunKick:AbsentImun(unit, GetAttackType()) and Player:Chi() >= 5 then 
                return A.RisingSunKick:Show(icon)
            end 
            
            -- actions.st+=/fists_of_fury,if=energy.time_to_max>3
            if    (GetToggle(2, "AoE") or MultiUnits:GetByRange(8, 2) < 2) and A.FistsofFury:IsReady(unit, true) and A.FistsofFury:AbsentImun(unit, GetAttackType()) and LoC:IsMissed("DISARM") and Unit(unit):GetRange() <= 8 and Player:EnergyTimeToMaxPredicted() > 3 and not Unit(unit):IsTotem() and 
            (
                not A.IsInPvP or
                not EnemyTeam("HEALER"):IsBreakAble(8)
            )
            then 
                return A.FistsofFury:Show(icon)
            end 
            
            -- actions.st+=/rising_sun_kick,target_if=min:debuff.mark_of_the_crane.remains
            if A.RisingSunKick:IsReady(unit) and A.RisingSunKick:AbsentImun(unit, GetAttackType()) then 
                return A.RisingSunKick:Show(icon)
            end 
            
            -- actions.st+=/rushing_jade_wind,if=buff.rushing_jade_wind.down&active_enemies>1
            if     GetToggle(2, "AoE") and MultiUnits:GetByRange(8, 2) >= 2 and A.RushingJadeWind:IsReady(unit, true) and A.RushingJadeWind:AbsentImun(unit, Temp.TotalAndMag) and IsSchoolFree() and Unit(unit):GetRange() <= 8 and Unit(player):HasBuffs(A.RushingJadeWind.ID, true) == 0 and not Unit(unit):IsTotem() and
            (
                not A.IsInPvP or 
                not EnemyTeam("HEALER"):IsBreakAble(8) 
            )
            then
                return A.RushingJadeWind:Show(icon)
            end 
            
            -- actions.st+=/reverse_harm,if=chi.max-chi>=2
            if A.ReverseHarm:IsReady(unit, true) and Unit(unit):GetRange() <= 5 and A.ReverseHarm:AbsentImun(unit, Temp.TotalAndMag) and IsSchoolFree() and not EnemyTeam("HEALER"):IsBreakAble(5) and Player:ChiDeficit() >= 2 and not Unit(unit):IsTotem() then
                local ReverseHarm = GetToggle(2, "ReverseHarm")
                if (ReverseHarm >= 100 and Unit(player):HealthPercent() <= 92) or (ReverseHarm < 100 and Unit(player):HealthPercent() <= ReverseHarm) then
                    return A.ReverseHarm:Show(icon)
                end 
            end 
            
            -- actions.st+=/fist_of_the_white_tiger,if=chi<=2
            if A.FistoftheWhiteTiger:IsReady(unit) and A.FistoftheWhiteTiger:AbsentImun(unit, GetAttackType()) and Player:Chi() <= 2 then 
                return A.FistoftheWhiteTiger:Show(icon)
            end
            
            -- actions.st+=/energizing_elixir,if=chi<=3&energy<50
            if A.EnergizingElixir:IsReady(player) and A.EnergizingElixir:AbsentImun(unit, GetAttackType()) and Player:Chi() <= 3 and Player:EnergyPredicted() < 50 and not Unit(unit):IsTotem() then 
                return A.EnergizingElixir:Show(icon)
            end
            
            -- actions.st+=/spinning_crane_kick,if=!prev_gcd.1.spinning_crane_kick&buff.dance_of_chiji.up
            if     (GetToggle(2, "AoE") or MultiUnits:GetByRange(8, 2) < 2) and A.SpinningCraneKick:IsReady(unit, true) and A.SpinningCraneKick:AbsentImun(unit, GetAttackType()) and Unit(unit):GetRange() <= 8 and A.LastPlayerCastID ~= A.SpinningCraneKick.ID and Unit(player):HasBuffs(A.DanceOfChijiBuff.ID, true) > 0 and not Unit(unit):IsTotem() and
            (
                not A.IsInPvP or 
                not EnemyTeam("HEALER"):IsBreakAble(8) 
            )
            then 
                return A.SpinningCraneKick:Show(icon)
            end 
            
            -- actions.st+=/blackout_kick,target_if=min:debuff.mark_of_the_crane.remains,if=!prev_gcd.1.blackout_kick&(cooldown.rising_sun_kick.remains>3|chi>=3)&(cooldown.fists_of_fury.remains>4|chi>=4|(chi=2&prev_gcd.1.tiger_palm)|(azerite.swift_roundhouse.rank>=2&active_enemies=1))&buff.swift_roundhouse.stack<2
            if A.BlackoutKick:IsReady(unit) and A.BlackoutKick:AbsentImun(unit, GetAttackType()) and (A.LastPlayerCastID ~= A.BlackoutKick.ID and (A.RisingSunKick:GetCooldown() > 3 or Player:Chi() >= 3) and (A.FistsofFury:GetCooldown() > 4 or Player:Chi() >= 4 or (Player:Chi() == 2 and A.LastPlayerCastID == A.TigerPalm.ID) or (A.SwiftRoundhouse:GetAzeriteRank() >= 2 and MultiUnits:GetByRange(5, 2) < 2)) and Unit(player):HasBuffs(A.SwiftRoundhouseBuff.ID, true) < 2) then 
                return A.BlackoutKick:Show(icon)
            end 
            
            -- actions.st+=/chi_wave
            if     (GetToggle(2, "AoE") or MultiUnits:GetByRange(25, 2) < 2) and A.ChiWave:IsReady(unit, true) and IsSchoolFree() and Unit(unit):GetRange() <= 25 and not Unit(unit):IsTotem() and             
            (
                not A.IsInPvP or 
                not EnemyTeam("HEALER"):IsBreakAble(25) 
            )
            then 
                return A.ChiWave:Show(icon)
            end 
            
            -- actions.st+=/chi_burst,if=chi.max-chi>=1&active_enemies=1|chi.max-chi>=2
            if     (GetToggle(2, "AoE") or MultiUnits:GetByRange(40, 2) < 2) and A.ChiBurst:IsReady(unit, true) and not isMoving and IsSchoolFree() and Unit(unit):GetRange() <= 40 and ((Player:ChiDeficit() >= 1 and MultiUnits:GetByRange(8, 2) < 2) or Player:ChiDeficit() >= 2) and not Unit(unit):IsTotem() and                      
            (
                not A.IsInPvP or 
                not EnemyTeam("HEALER"):IsBreakAble(40) 
            )
            then 
                return A.ChiBurst:Show(icon)
            end 
            
            -- actions.st+=/tiger_palm,target_if=min:debuff.mark_of_the_crane.remains,if=!prev_gcd.1.tiger_palm&chi.max-chi>=2&(buff.rushing_jade_wind.down|energy>56)
            if A.TigerPalm:IsReady(unit) and A.TigerPalm:AbsentImun(unit, GetAttackType()) and A.LastPlayerCastID ~= A.TigerPalm.ID and Player:ChiDeficit() >= 2 and (Unit(player):HasBuffs(A.RushingJadeWind.ID, true) == 0 or Player:EnergyPredicted() > 56) then
                return A.TigerPalm:Show(icon)
            end 
            
            -- actions.st+=/flying_serpent_kick,if=prev_gcd.1.blackout_kick&chi>3&buff.swift_roundhouse.stack<2,interrupt=1        
            if  A.FlyingSerpentKick:IsReady(unit, true) and A.FlyingSerpentKick:AbsentImun(unit, GetAttackType()) and             
            (
                not A.IsInPvP or 
                not EnemyTeam("HEALER"):IsBreakAble(25) 
            ) and 
            (
                A.RidetheWind:IsSpellLearned() or
                LoC:IsMissed("ROOT")
            )
            then 
                if A.LastPlayerCastID == A.BlackoutKick.ID and Player:Chi() > 3 and Unit(player):HasBuffsStacks(A.SwiftRoundhouse.ID, true) < 2 then 
                    return A.FlyingSerpentKick:Show(icon)
                end 
                
                if A.RidetheWind:IsSpellLearned() and not LoC:IsMissed("ROOT") then 
                    return A.FlyingSerpentKick:Show(icon)
                end 
            end 
        end 
        
        -- Misc - Supportive 
        if A.TigersLust:IsReady(player) and IsSchoolFree() then 
            if Unit(player):HasDeBuffs("Rooted") > 0.5 then 
                return A.TigersLust:Show(icon)
            end 
            
            local cUnitSpeed = Unit(player):GetCurrentSpeed()
            if cUnitSpeed > 0 and cUnitSpeed < 64 then 
                return A.TigersLust:Show(icon)
            end 
        end 
        
        if A.Detox:IsReady(player) and IsSchoolFree() and AuraIsValid(player, "UseDispel", "Dispel") then 
            return A.Detox:Show(icon)
        end         
        
        if A.GiftofNaaru:AutoRacial(player) then 
            return A.GiftofNaaru:Show(icon)
        end 
        
        -- Misc - Range         
        if not isMoving and not inMelee and A.CracklingJadeLightning:IsReady(unit) and A.CracklingJadeLightning:AbsentImun(unit, Temp.TotalAndMag) and Unit(unit):GetRange() > 25 then 
            return A.CracklingJadeLightning:Show(icon)
        end 
        
        if unit ~= "mouseover" and not inMelee and Player:IsMovingTime() > 2 and not Player:IsMounted() then         
            if not A.ChiTorpedo:IsSpellLearned() and A.Roll:IsReady(unit, true) and Unit(unit):GetRange() >= 15 then 
                return A.Roll:Show(icon)
            end 
            
            if A.ChiTorpedo:IsReady(unit, true) and Unit(unit):GetRange() >= 20 then 
                return A.ChiTorpedo:Show(icon)
            end 
        end
    end 
    
    local function FriendlyRotation(unit)
        -- Purge
        if A.ArcaneTorrent:AutoRacial(unit) then 
            return A.ArcaneTorrent:Show(icon)
        end     
        
        -- Out of combat        
        if Unit(player):CombatTime() == 0 and A.Resuscitate:IsReady(unit) and Unit(unit):IsDead() and Unit(unit):IsPlayer() and not isMoving and IsSchoolFree() then 
            return A.Resuscitate:Show(icon)
        end 
        
        -- Supportive
        if A.Detox:IsReady(unit) and A.Detox:AbsentImun(unit) and IsSchoolFree() and AuraIsValid(unit, "UseDispel", "Dispel") then 
            return A.Detox:Show(icon)
        end 
        
        if A.TigersLust:IsReady(unit) and A.TigersLust:AbsentImun(unit) and IsSchoolFree() then 
            if Unit(unit):HasDeBuffs("Rooted") > 1.5 then 
                return A.TigersLust:Show(icon)
            end 
            
            local cUnitSpeed = Unit(unit):GetCurrentSpeed()
            if cUnitSpeed > 0 and cUnitSpeed < 64 then 
                return A.TigersLust:Show(icon)
            end 
        end         
        
        -- AoE (ChiBurst / ChiWave)
        if isMulti then 
            if  not isMoving and A.ChiBurst:IsReady(unit, true) and A.ChiBurst:AbsentImun(unit) and IsSchoolFree() and Unit(unit):GetRange() <= 40 and A.ChiBurst:PredictHeal("ChiBurst", unit) and 
            (
                not A.IsInPvP or 
                not EnemyTeam("HEALER"):IsBreakAble(40)                
            )
            then 
                return A.ChiBurst:Show(icon)
            end 
            
            if     A.ChiWave:IsReady(unit, true) and A.ChiWave:AbsentImun(unit) and IsSchoolFree() and Unit(unit):GetRange() <= 25 and A.ChiWave:PredictHeal("ChiWave", unit) and
            (
                not A.IsInPvP or 
                not EnemyTeam("HEALER"):IsBreakAble(25)                
            )
            then 
                return A.ChiWave:Show(icon)
            end 
        end
        
        -- PvP: Reverse Harm
        if A.ReverseHarm:IsReady(unit) and A.ReverseHarm:AbsentImun(unit) and IsSchoolFree() and not EnemyTeam("HEALER"):IsBreakAble(15) then
            local ReverseHarm = GetToggle(2, "ReverseHarm")
            if (ReverseHarm >= 100 and Unit(unit):HealthPercent() < 92) or (ReverseHarm < 100 and Unit(unit):HealthPercent() < ReverseHarm) then 
                return A.ReverseHarm:Show(icon)
            end 
        end 
        
        -- Vivify
        if not isMoving and A.Vivify:IsReady(unit) and A.Vivify:AbsentImun(unit) and IsSchoolFree() and (UnitIsUnit(unit, player) or A.Vivify:PredictHeal("Vivify", unit)) then 
            return A.Vivify:Show(icon)
        end     
        
        -- Racial 
        if A.GiftofNaaru:AutoRacial(unit) then 
            return A.GiftofNaaru:Show(icon)
        end         
        
        -- Azerite Essences 
        if A.ConcentratedFlame:AutoHeartOfAzeroth(unit) then 
            return A.ConcentratedFlame:Show(icon)
        end         
        
        -- AoE (ChiBurst / ChiWave)
        if GetToggle(2, "AoE") then 
            if     not isMoving and A.ChiBurst:IsReady(unit, true) and A.ChiBurst:AbsentImun(unit) and IsSchoolFree() and Unit(unit):GetRange() <= 40 and A.ChiBurst:PredictHeal("ChiBurst", unit) and 
            (
                not A.IsInPvP or 
                not EnemyTeam("HEALER"):IsBreakAble(40)                
            )
            then 
                return A.ChiBurst:Show(icon)
            end 
            
            if     A.ChiWave:IsReady(unit, true) and A.ChiWave:AbsentImun(unit) and IsSchoolFree() and Unit(unit):GetRange() <= 25 and A.ChiWave:PredictHeal("ChiWave", unit) and
            (
                not A.IsInPvP or 
                not EnemyTeam("HEALER"):IsBreakAble(25)                
            )
            then 
                return A.ChiWave:Show(icon)
            end 
        end        
    end 
    
    -- Defensive
    local SelfDefensive = SelfDefensives()
    if SelfDefensive then 
        return SelfDefensive:Show(icon)
    end
    
    -- Trinkets (Defensive)
    if Unit(player):CombatTime() > 0 and Unit(player):HealthPercent() <= GetToggle(2, "TrinketDefensive") then 
        if A.Trinket1:IsReady(player) and A.Trinket1:GetItemCategory() ~= "DPS" and not Temp.IsSlotTrinketBlocked[A.Trinket1.ID] then 
            return A.Trinket1:Show(icon)
        end 
        
        if A.Trinket2:IsReady(player) and A.Trinket2:GetItemCategory() ~= "DPS" and not Temp.IsSlotTrinketBlocked[A.Trinket2.ID] then 
            return A.Trinket2:Show(icon)
        end             
    end 
    
    -- Mouseover 
    if IsUnitFriendly("mouseover") then 
        unit = "mouseover"    
        
        if FriendlyRotation(unit) then 
            return true 
        end             
    end 
    
    if IsUnitEnemy("mouseover") then 
        unit = "mouseover"
        
        if EnemyRotation(unit) then 
            return true 
        end 
    end 
    
    -- Target         
    if IsUnitFriendly("target") then 
        unit = "target"
        
        if FriendlyRotation(unit) then 
            return true 
        end 
    end 
    
    if IsUnitEnemy("target") then 
        unit = "target"
        
        if EnemyRotation(unit) then 
            return true 
        end 
    end 
    
    -- Misc         
    if A.Zone == "arena" and Unit(player):CombatTime() == 0 and not Player:IsMounted() and A.SpinningCraneKick:IsReady() and (isMulti or GetToggle(2, "AoE")) and EnemyTeam():HasInvisibleUnits() and not EnemyTeam("HEALER"):IsBreakAble(8) then 
        return A.SpinningCraneKick:Show(icon)         
    end 
    
    -- Movement
    -- If not moving or moving lower than 2.5 sec 
    if Player:IsMovingTime() < 2.5 then 
        return 
    end 
    
    if not A.ChiTorpedo:IsSpellLearned() and A.Roll:IsReady(unit, true) and (unit == player or not Unit(unit):IsExists()) and IsIndoors() and Unit(player):CombatTime() == 0 then 
        return A.Roll:Show(icon)
    end 
    
    if A.ChiTorpedo:IsReady(unit, true) and (unit == player or not Unit(unit):IsExists()) and IsIndoors() and Unit(player):CombatTime() == 0 then 
        return A.ChiTorpedo:Show(icon)
    end     
end 

-- [4] AoE Rotation
A[4] = function(icon)
    return A[3](icon, true)
end 

-- [5] Trinket Rotation
-- No specialization trinket actions 
A[5] = nil 

-- Passive 
local function FreezingTrapUsedByEnemy()
    if     UnitCooldown:GetCooldown("arena", ACTION_CONST_SPELLID_FREEZING_TRAP) > UnitCooldown:GetMaxDuration("arena", ACTION_CONST_SPELLID_FREEZING_TRAP) - 2 and 
    UnitCooldown:IsSpellInFly("arena", ACTION_CONST_SPELLID_FREEZING_TRAP) and 
    Unit(player):GetDR("incapacitate") >= 50 
    then 
        local Caster = UnitCooldown:GetUnitID("arena", ACTION_CONST_SPELLID_FREEZING_TRAP)
        if Caster and Unit(Caster):GetRange() <= 40 then 
            return true 
        end 
    end 
end 

local function ArenaRotation(icon, unit)
    if A.IsInPvP and (A.Zone == "pvp" or A.Zone == "arena") and not Player:IsStealthed() and not Player:IsMounted() then             
        -- Note: "arena1" is just identification of meta 6
        if unit == "arena1" and (Unit(player):GetDMG() == 0 or not Unit(player):IsFocused("DAMAGER")) then                 
            -- PvP Pet Taunt        
            if A.Provoke:IsReady() and EnemyTeam():IsTauntPetAble(A.Provoke.ID) then 
                -- Freezing Trap 
                if FreezingTrapUsedByEnemy() then 
                    return A.Provoke:Show(icon)
                end 
                
                -- Casting BreakAble CC
                if EnemyTeam():IsCastingBreakAble(0.25) then 
                    return A.Provoke:Show(icon)
                end 
                
                -- Try avoid something totally random at opener (like sap / blind)
                if Unit(player):CombatTime() <= 5 and (Unit(player):CombatTime() > 0 or Unit("target"):CombatTime() > 0 or MultiUnits:GetByRangeInCombat(40, 1) >= 1) then 
                    return A.Provoke:Show(icon) 
                end 
                
                -- Roots if not available freedom 
                if LoC:Get("ROOT") > 0 and not A.TigersLust:IsReadyP(player) and (not A.RidetheWind:IsSpellLearned() or not A.FlyingSerpentKick:IsReadyP("target", true)) then 
                    return A.Provoke:Show(icon) 
                end 
            end 
        end 
        
        if A.GrappleWeaponIsReady(unit) and not Unit(unit):InLOS() then
            return A.GrappleWeapon:Show(icon)
        end         
        
        if A.IsInPvP and GetToggle(1, "AutoTarget") and IsUnitEnemy("target") and not A.AbsentImun(nil, "target", GetAttackType()) and MultiUnits:GetByRangeInCombat(12, 2) >= 2 and not FrameHasSpell(TellMeWhen_Group1_Icon3, A.TigereyeBrew.ID) then 
            return A:Show(icon, ACTION_CONST_AUTOTARGET)
        end         
    end 
end 

local function PartyRotation(unit)
    if not PartyUnits then 
        PartyUnits = GetToggle(2, "PartyUnits")
    end 
    
    if (unit == "party1" and not PartyUnits[1]) or (unit == "party2" and not PartyUnits[2]) then 
        return false 
    end 
    
    -- Detox 
    if A.Detox:IsReady(unit) and A.Detox:AbsentImun(unit) and IsSchoolFree() and AuraIsValid(unit, "UseDispel", "Dispel") and not Unit(unit):InLOS() then                         
        return A.Detox
    end         
    
    -- Tiger Lust
    if A.TigersLust:IsReady(unit) and A.TigersLust:AbsentImun(unit) and IsSchoolFree() and not Unit(player, 5):HasFlags() and (Unit(unit):IsFocused(nil, true) or (Unit(unit):IsMelee() and Unit(unit):HasBuffs("DamageBuffs") > 0)) and not Unit(unit):InLOS() then 
        if Unit(unit):HasDeBuffs("Rooted") > GetGCD() then 
            return A.TigersLust
        end 
        
        local cMoving = Unit(unit):GetCurrentSpeed()
        if cMoving > 0 and cMoving < 64 then -- 64 because unit can moving backward 
            return A.TigersLust
        end 
    end 
    
    -- PvP: Reverse Harm
    if     A.ReverseHarm:IsReady(unit) and A.ReverseHarm:AbsentImun(unit) and IsSchoolFree() and not Unit(unit):InLOS() and not EnemyTeam("HEALER"):IsBreakAble(15) and 
    (
        (
            unit == "party1" and (Unit("party2"):HealthPercent() >= Unit("party1"):HealthPercent() or not Unit("party2"):IsExists() or Unit("party2"):InLOS() or not A.ReverseHarm:AbsentImun("party2") or not A.ReverseHarm:IsInRange("party2"))
        ) or 
        (
            unit == "party2" and (Unit("party1"):HealthPercent() >= Unit("party2"):HealthPercent() or not Unit("party1"):IsExists() or Unit("party1"):InLOS() or not A.ReverseHarm:AbsentImun("party1") or not A.ReverseHarm:IsInRange("party1"))
        )
    )
    then
        local ReverseHarm = GetToggle(2, "ReverseHarm")
        if (ReverseHarm >= 100 and Unit(unit):HealthPercent() < 92) or (ReverseHarm < 100 and Unit(unit):HealthPercent() < ReverseHarm) then
            return A.ReverseHarm
        end 
    end 
end 

A[6] = function(icon)    
    return ArenaRotation(icon, "arena1")
end

A[7] = function(icon)
    local Party = PartyRotation("party1") 
    if Party then 
        return Party:Show(icon)
    end 
    
    return ArenaRotation(icon, "arena2")
end

A[8] = function(icon)
    local Party = PartyRotation("party2") 
    if Party then 
        return Party:Show(icon)
    end     
    
    return ArenaRotation(icon, "arena3")
end

