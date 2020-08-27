-------------------------------
-- Taste TMW Action Rotation --
-------------------------------
local Action                                    = Action
local Listener                                    = Action.Listener
local Create                                    = Action.Create
local GetToggle                                    = Action.GetToggle
local SetToggle                                    = Action.SetToggle
local GetGCD                                    = Action.GetGCD
local GetCurrentGCD                                = Action.GetCurrentGCD
local GetPing                                    = Action.GetPing
local ShouldStop                                = Action.ShouldStop
local BurstIsON                                    = Action.BurstIsON
local AuraIsValid                                = Action.AuraIsValid
local InterruptIsValid                            = Action.InterruptIsValid
local FrameHasSpell                                = Action.FrameHasSpell
local Azerite                                    = LibStub("AzeriteTraits")
local Utils                                        = Action.Utils
local TeamCache                                    = Action.TeamCache
local EnemyTeam                                    = Action.EnemyTeam
local FriendlyTeam                                = Action.FriendlyTeam
local LoC                                        = Action.LossOfControl
local Player                                    = Action.Player 
local MultiUnits                                = Action.MultiUnits
local UnitCooldown                                = Action.UnitCooldown
local Unit                                        = Action.Unit 
local IsUnitEnemy                                = Action.IsUnitEnemy
local IsUnitFriendly                            = Action.IsUnitFriendly
local ActiveUnitPlates                            = MultiUnits:GetActiveUnitPlates()
local _G, setmetatable                            = _G, setmetatable
local IsIndoors, UnitIsUnit                     = IsIndoors, UnitIsUnit
local TR                                        = Action.TasteRotation
local pairs                                     = pairs
local Pet                                       = LibStub("PetLibrary")

--- ============================ CONTENT ===========================
--- ======= APL LOCALS =======
-- luacheck: max_line_length 9999

-- Spells
Action[ACTION_CONST_WARRIOR_ARMS] = {
    -- Racial
    ArcaneTorrent                          = Action.Create({ Type = "Spell", ID = 50613     }),
    BloodFury                              = Action.Create({ Type = "Spell", ID = 20572      }),
    Fireblood                              = Action.Create({ Type = "Spell", ID = 265221     }),
    AncestralCall                          = Action.Create({ Type = "Spell", ID = 274738     }),
    Berserking                             = Action.Create({ Type = "Spell", ID = 26297    }),
    ArcanePulse                            = Action.Create({ Type = "Spell", ID = 260364    }),
    QuakingPalm                            = Action.Create({ Type = "Spell", ID = 107079     }),
    Haymaker                               = Action.Create({ Type = "Spell", ID = 287712     }), 
    WarStomp                               = Action.Create({ Type = "Spell", ID = 20549     }),
    BullRush                               = Action.Create({ Type = "Spell", ID = 255654     }),  
    GiftofNaaru                            = Action.Create({ Type = "Spell", ID = 59544    }),
    Shadowmeld                             = Action.Create({ Type = "Spell", ID = 58984    }), -- usable in Action Core 
    Stoneform                              = Action.Create({ Type = "Spell", ID = 20594    }), 
    WilloftheForsaken                      = Action.Create({ Type = "Spell", ID = 7744        }), -- not usable in APL but user can Queue it   
    EscapeArtist                           = Action.Create({ Type = "Spell", ID = 20589    }), -- not usable in APL but user can Queue it
    EveryManforHimself                     = Action.Create({ Type = "Spell", ID = 59752    }), -- not usable in APL but user can Queue it
    BagofTricks                            = Action.Create({ Type = "Spell", ID = 312411    }),
    -- Generics
    Skullsplitter                          = Action.Create({ Type = "Spell", ID = 260643 }),
    DeadlyCalmBuff                         = Action.Create({ Type = "Spell", ID = 262228 }),
    Ravager                                = Action.Create({ Type = "Spell", ID = 152277 }),
    ColossusSmash                          = Action.Create({ Type = "Spell", ID = 167105 }),
    Warbreaker                             = Action.Create({ Type = "Spell", ID = 262161 }),
    DeadlyCalm                             = Action.Create({ Type = "Spell", ID = 262228 }),
    Bladestorm                             = Action.Create({ Type = "Spell", ID = 227847 }),
    TestofMightBuff                        = Action.Create({ Type = "Spell", ID = 275540 }),
    Cleave                                 = Action.Create({ Type = "Spell", ID = 845 }),
    Slam                                   = Action.Create({ Type = "Spell", ID = 1464 }),
    CrushingAssaultBuff                    = Action.Create({ Type = "Spell", ID = 278826 }),
    MortalStrike                           = Action.Create({ Type = "Spell", ID = 12294 }),
    OverpowerBuff                          = Action.Create({ Type = "Spell", ID = 7384 }),
    Dreadnaught                            = Action.Create({ Type = "Spell", ID = 262150 }),
    ExecutionersPrecisionBuff              = Action.Create({ Type = "Spell", ID = 242188 }),
    Overpower                              = Action.Create({ Type = "Spell", ID = 7384 }),
    ColossusSmashDebuff                    = Action.Create({ Type = "Spell", ID = 208086 }),
    SweepingStrikesBuff                    = Action.Create({ Type = "Spell", ID = 260708 }),
    TestofMight                            = Action.Create({ Type = "Spell", ID = 275529 }),
    DeepWoundsDebuff                       = Action.Create({ Type = "Spell", ID = 262115 }),
    SuddenDeathBuff                        = Action.Create({ Type = "Spell", ID = 52437 }),
    StoneHeartBuff                         = Action.Create({ Type = "Spell", ID = 225947 }),
    SweepingStrikes                        = Action.Create({ Type = "Spell", ID = 260708 }),
    Whirlwind                              = Action.Create({ Type = "Spell", ID = 1680 }),
    FervorofBattle                         = Action.Create({ Type = "Spell", ID = 202316 }),
    Rend                                   = Action.Create({ Type = "Spell", ID = 772 }),
    RendDebuff                             = Action.Create({ Type = "Spell", ID = 772 }),
    AngerManagement                        = Action.Create({ Type = "Spell", ID = 152278 }),
    SeismicWave                            = Action.Create({ Type = "Spell", ID = 277639 }),
    Charge                                 = Action.Create({ Type = "Spell", ID = 100 }),
    BloodFury                              = Action.Create({ Type = "Spell", ID = 20572 }),
    Berserking                             = Action.Create({ Type = "Spell", ID = 26297 }),
    ArcaneTorrent                          = Action.Create({ Type = "Spell", ID = 50613 }),
    LightsJudgment                         = Action.Create({ Type = "Spell", ID = 255647 }),
    Fireblood                              = Action.Create({ Type = "Spell", ID = 265221 }),
    AncestralCall                          = Action.Create({ Type = "Spell", ID = 274738 }),
    Avatar                                 = Action.Create({ Type = "Spell", ID = 107574 }),
    Massacre                               = Action.Create({ Type = "Spell", ID = 281001 }),
    ExecuteDefault                         = Action.Create({ Type = "Spell", ID = 163201 }),
    ExecuteMassacre                        = Action.Create({ Type = "Spell", ID = 281000 }),
    IntimidatingShout                      = Action.Create({ Type = "Spell", ID = 5246, Hidden = true     }),
    Pummel                                   = Action.Create({ Type = "Spell", ID = 6552    }),
    BattleShout                            = Action.Create({ Type = "Spell", ID = 6673         }),
    HeroicLeap                             = Action.Create({ Type = "Spell", ID = 6544      }),
    -- Self Defensive
    EnragedRegeneration                    = Action.Create({ Type = "Spell", ID = 184364         }),
    BerserkerRage                          = Action.Create({ Type = "Spell", ID = 18499         }),
    VictoryRush                               = Action.Create({ Type = "Spell", ID = 34428         }),
    ImpendingVictory                       = Action.Create({ Type = "Spell", ID = 202168         }),
    RallyingCry                               = Action.Create({ Type = "Spell", ID = 97462         }),
    DiebytheSword                        = Action.Create({ Type = "Spell", ID = 118038}),
    -- CrownControl
    Stormbolt                              = Action.Create({ Type = "Spell", ID = 107570    }),
    StormboltGreen                         = Action.Create({ Type = "SpellSingleColor", ID = 107570, Color = "GREEN", Desc = "[1] CC", QueueForbidden = true    }),
    Pummel                                   = Action.Create({ Type = "Spell", ID = 6552    }),
    PummelGreen                               = Action.Create({ Type = "SpellSingleColor", ID = 6552, Color = "GREEN", Desc = "[2] Kick", QueueForbidden = true    }),   
    IntimidatingShout                   = Action.Create({ Type = "Spell", ID = 5246    }),
    Hamstring                            = Action.Create({ Type = "Spell", ID = 1715    }),
    Taunt                                = Action.Create({ Type = "Spell", ID = 355, Desc = "[6] PvP Pets Taunt", QueueForbidden = true}),
    -- Potions
    PotionofUnbridledFury                  = Action.Create({ Type = "Potion", ID = 169299, QueueForbidden = true }), 
    BattlePotionofAgility                  = Action.Create({ Type = "Potion", ID = 163223, QueueForbidden = true }),
    SuperiorPotionofUnbridledFury          = Action.Create({ Type = "Potion", ID = 168489, QueueForbidden = true }), 
    PotionTest                             = Action.Create({ Type = "Potion", ID = 142117, QueueForbidden = true }), 
    -- Trinkets
    GenericTrinket1                        = Action.Create({ Type = "Trinket", ID = 114616, QueueForbidden = true }),
    GenericTrinket2                        = Action.Create({ Type = "Trinket", ID = 114081, QueueForbidden = true }),
    TrinketTest                            = Action.Create({ Type = "Trinket", ID = 122530, QueueForbidden = true }),
    TrinketTest2                           = Action.Create({ Type = "Trinket", ID = 159611, QueueForbidden = true }), 
    AzsharasFontofPower                    = Action.Create({ Type = "Trinket", ID = 169314, QueueForbidden = true }),
    PocketsizedComputationDevice           = Action.Create({ Type = "Trinket", ID = 167555, QueueForbidden = true }),
    RotcrustedVoodooDoll                   = Action.Create({ Type = "Trinket", ID = 159624, QueueForbidden = true }),
    ShiverVenomRelic                       = Action.Create({ Type = "Trinket", ID = 168905, QueueForbidden = true }),
    AquipotentNautilus                     = Action.Create({ Type = "Trinket", ID = 169305, QueueForbidden = true }),
    TidestormCodex                         = Action.Create({ Type = "Trinket", ID = 165576, QueueForbidden = true }),
    VialofStorms                           = Action.Create({ Type = "Trinket", ID = 158224, QueueForbidden = true }),
    GalecallersBoon                        = Action.Create({ Type = "Trinket", ID = 159614, QueueForbidden = true }),
    InvocationOfYulon                      = Action.Create({ Type = "Trinket", ID = 165568, QueueForbidden = true }),
    LustrousGoldenPlumage                  = Action.Create({ Type = "Trinket", ID = 159617, QueueForbidden = true }),
    ComputationDevice                      = Action.Create({ Type = "Trinket", ID = 167555, QueueForbidden = true }),
    VigorTrinket                           = Action.Create({ Type = "Trinket", ID = 165572, QueueForbidden = true }),
    FontOfPower                            = Action.Create({ Type = "Trinket", ID = 169314, QueueForbidden = true }),
    RazorCoral                             = Action.Create({ Type = "Trinket", ID = 169311, QueueForbidden = true }),
    AshvanesRazorCoral                     = Action.Create({ Type = "Trinket", ID = 169311, QueueForbidden = true }),
    -- Misc
    Channeling                             = Action.Create({ Type = "Spell", ID = 209274, Hidden = true     }),    -- Show an icon during channeling
    TargetEnemy                            = Action.Create({ Type = "Spell", ID = 44603, Hidden = true     }),    -- Change Target (Tab button)
    StopCast                               = Action.Create({ Type = "Spell", ID = 61721, Hidden = true     }),        -- spell_magic_polymorphrabbit
    CyclotronicBlast                       = Action.Create({ Type = "Spell", ID = 293491, Hidden = true}),
    ConcentratedFlameBurn                  = Action.Create({ Type = "Spell", ID = 295368, Hidden = true}),
    RazorCoralDebuff                       = Action.Create({ Type = "Spell", ID = 303568, Hidden = true     }),
    ConductiveInkDebuff                    = Action.Create({ Type = "Spell", ID = 302565, Hidden = true     }),
    -- Hidden Heart of Azeroth
    -- added all 3 ranks ids in case used by rotation
    VisionofPerfectionMinor                = Action.Create({ Type = "Spell", ID = 296320, Hidden = true}),
    VisionofPerfectionMinor2               = Action.Create({ Type = "Spell", ID = 299367, Hidden = true}),
    VisionofPerfectionMinor3               = Action.Create({ Type = "Spell", ID = 299369, Hidden = true}),
    UnleashHeartOfAzeroth                  = Action.Create({ Type = "Spell", ID = 280431, Hidden = true}),
    RecklessForceBuff                      = Action.Create({ Type = "Spell", ID = 302932, Hidden = true     }),    
    DummyTest                              = Action.Create({ Type = "Spell", ID = 159999, Hidden = true     }), -- Dummy stop dps icon       
};

-- To create essences use next code:
Action:CreateEssencesFor(ACTION_CONST_WARRIOR_ARMS)  -- where PLAYERSPEC is Constance (example: ACTION_CONST_MONK_BM)
local A = setmetatable(Action[ACTION_CONST_WARRIOR_ARMS], { __index = Action })

local function num(val)
    if val then return 1 else return 0 end
end

local function bool(val)
    return val ~= 0
end
local player = "player"
------------------------------------------
-------------- COMMON PREAPL -------------
------------------------------------------
local Temp = {
    TotalAndPhys                            = {"TotalImun", "DamagePhysImun"},
    TotalAndCC                              = {"TotalImun", "CCTotalImun"},
    TotalAndPhysKick                        = {"TotalImun", "DamagePhysImun", "KickImun"},
    TotalAndPhysAndCC                       = {"TotalImun", "DamagePhysImun", "CCTotalImun"},
    TotalAndPhysAndStun                     = {"TotalImun", "DamagePhysImun", "StunImun"},
    TotalAndPhysAndCCAndStun                = {"TotalImun", "DamagePhysImun", "CCTotalImun", "StunImun"},
    TotalAndMag                             = {"TotalImun", "DamageMagicImun"},
    TotalAndMagKick                         = {"TotalImun", "DamageMagicImun", "KickImun"},
    DisablePhys                             = {"TotalImun", "DamagePhysImun", "Freedom", "CCTotalImun"},
    DisableMag                              = {"TotalImun", "DamageMagicImun", "Freedom", "CCTotalImun"},
}

local IsIndoors, UnitIsUnit = IsIndoors, UnitIsUnit

local function IsSchoolFree()
    return LoC:IsMissed("SILENCE") and LoC:Get("SCHOOL_INTERRUPT", "SHADOW") == 0
end 

local function InMelee(unit)
    -- @return boolean 
    return A.MortalStrike:IsInRange(unit)
end 
InMelee = A.MakeFunctionCachedDynamic(InMelee)

local function InRange(unit)
    -- @return boolean 
    return A.MortalStrike:IsInRange(unit)
end 
InRange = A.MakeFunctionCachedDynamic(InRange)

local function GetByRange(count, range, isStrictlySuperior, isStrictlyInferior, isCheckEqual, isCheckCombat)
    -- @return boolean 
    local c = 0 
    
    if isStrictlySuperior == nil then
        isStrictlySuperior = false
    end
    
    if isStrictlyInferior == nil then
        isStrictlyInferior = false
    end    
    
    for unit in pairs(ActiveUnitPlates) do 
        if (not isCheckEqual or not UnitIsUnit("target", unit)) and (not isCheckCombat or Unit(unit):CombatTime() > 0) then 
            if InRange(unit) then 
                c = c + 1
            elseif range then 
                local r = Unit(unit):GetRange()
                if r > 0 and r <= range then 
                    c = c + 1
                end 
            end 
            -- Strictly superior than >
            if isStrictlySuperior and not isStrictlyInferior then
                if c > count then
                    return true
                end
            end
            
            -- Stryctly inferior <
            if isStrictlyInferior and not isStrictlySuperior then
                if c < count then
                    return true
                end
            end
            
            -- Classic >=
            if not isStrictlyInferior and not isStrictlySuperior then
                if c >= count then 
                    return true 
                end 
            end
        end 
        
    end
    
end  
GetByRange = A.MakeFunctionCachedDynamic(GetByRange)

local function UpdateExecuteID()
    Execute = A.Massacre:IsSpellLearned() and A.ExecuteMassacre or A.ExecuteDefault
end

-- [1] CC AntiFake Rotation
local function AntiFakeStun(unit) 
    return 
    A.IsUnitEnemy(unit) and  
    Unit(unit):GetRange() <= 20 and 
    (
        (A.IsInPvP and Unit(unit):IsControlAble("stun", 0)) 
        or
        not A.IsInPvP        
    ) 
    and A.StormboltGreen:AbsentImun(unit, Temp.TotalAndPhysAndCCAndStun, true)          
end 
A[1] = function(icon)    
    if    A.StormboltGreen:IsReady(nil, nil, nil, true) and 
    (
        AntiFakeStun("mouseover") or 
        AntiFakeStun("target") or 
        (
            not A.IsUnitEnemy("mouseover") and 
            not A.IsUnitEnemy("target")
        )
    )
    then 
        return A.StormboltGreen:Show(icon)         
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
            -- Pummel        
            if not notKickAble and A.PummelGreen:IsReady(unit, nil, nil, true) and A.PummelGreen:AbsentImun(unit, Temp.TotalAndPhysKick, true) then
                return A.PummelGreen:Show(icon)                                                  
            end 
            
            -- Stormbolt
            if A.Stormbolt:IsReady(unit, nil, nil, true) and A.Stormbolt:AbsentImun(unit, Temp.TotalAndPhysAndStun, true) and Unit(unit):IsControlAble("stun", 0) then
                return A.Stormbolt:Show(icon)                  
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

local function SelfDefensives()
    local HPLoosePerSecond = Unit("player"):GetDMG() * 100 / Unit("player"):HealthMax()
    if Unit(player):CombatTime() == 0 then 
        return 
    end 
    
    -- Rallying Cry
    local RallyingCry = A.GetToggle(2, "RallyingCry")
    if     RallyingCry >= 0 and A.RallyingCry:IsReady(player) and 
    (
        (     -- Auto 
            RallyingCry >= 100 and 
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
                            Unit("player", 5):HasFlags() and 
                            Unit(player):GetRealTimeDMG() > 0 and 
                            Unit(player):IsFocused() 
                        )
                    )
                )
            ) and 
            Unit(player):HasBuffs("DeffBuffs", true) == 0
        ) 
        or 
        (    -- Custom
            RallyingCry < 100 and 
            Unit(player):HealthPercent() <= RallyingCry
        )
    ) 
    then 
        return A.RallyingCry
    end  
    
end 
SelfDefensives = A.MakeFunctionCachedStatic(SelfDefensives)

local function Interrupts(unit)
    local useKick, useCC, useRacial = A.InterruptIsValid(unit, "TargetMouseover")    
    
    -- Pummel
    if useKick and A.Pummel:IsReady(unit) and A.Pummel:AbsentImun(unit, Temp.TotalAndPhysKick, true) and Unit(unit):CanInterrupt(true, nil, MinInterrupt, MaxInterrupt) then 
        return A.Pummel
    end 
    
    -- Stormbolt
    if useCC and A.Stormbolt:IsReady(unit) and A.Stormbolt:AbsentImun(unit, Temp.TotalAndPhysAndCC, true) and Unit(unit):CanInterrupt(true, nil, MinInterrupt, MaxInterrupt) and Unit(unit):IsControlAble("stun", 0) then
        return A.Stormbolt              
    end  
    
    -- IntimidatingShout
    if useCC and A.IntimidatingShout:IsReady(unit) and A.IntimidatingShout:AbsentImun(unit, Temp.TotalAndPhysAndCC, true) and Unit(unit):CanInterrupt(true, nil, MinInterrupt, MaxInterrupt) and Unit(unit):IsControlAble("fear", 0) then 
        return A.IntimidatingShout              
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
end 
Interrupts = A.MakeFunctionCachedDynamic(Interrupts)


--- ======= ACTION LISTS =======
-- [3] Single Rotation
A[3] = function(icon, isMulti)
    --------------------
    --- ROTATION VAR ---
    --------------------
    local isMoving = A.Player:IsMoving()
    local isMovingFor = A.Player:IsMovingTime()
    local inCombat = Unit(player):CombatTime() > 0
    local combatTime = Unit(player):CombatTime()
    local ShouldStop = Action.ShouldStop()
    local Pull = Action.BossMods_Pulling()
    local DBM = GetToggle(1 ,"DBM")
    local Potion = GetToggle(1, "Potion")
    local Racial = GetToggle(1, "Racial")
    local HeartOfAzeroth = GetToggle(1, "HeartOfAzeroth")
    -- Trinkets vars
    local Trinket1IsAllowed, Trinket2IsAllowed = TR:TrinketIsAllowed()
    local TrinketsAoE = GetToggle(2, "TrinketsAoE")
    local TrinketsMinTTD = GetToggle(2, "TrinketsMinTTD")
    local TrinketsUnitsRange = GetToggle(2, "TrinketsUnitsRange")
    local TrinketsMinUnits = GetToggle(2, "TrinketsMinUnits")
    local BloodoftheEnemySyncAoE = GetToggle(2, "BloodoftheEnemySyncAoE")
    local BloodoftheEnemyAoETTD = GetToggle(2, "BloodoftheEnemyAoETTD")
    local BloodoftheEnemyUnits = GetToggle(2, "BloodoftheEnemyUnits")
    local MinAoETargets = GetToggle(2, "MinAoETargets")
    local MaxAoERange = GetToggle(2, "MaxAoERange")
    local MinInterrupt = GetToggle(2, "MinInterrupt")
    local MaxInterrupt = GetToggle(2, "MaxInterrupt")
    local UseCharge = GetToggle(2, "UseCharge")
    local ChargeTime = GetToggle(2, "ChargeTime")
    local UseHeroicLeap = GetToggle(2, "UseHeroicLeap") 
    local HeroicLeapTime = GetToggle(2, "HeroicLeapTime")
    local profileStop = false
    local CanCast = true
    -- FocusedAzeriteBeam protection channel
    local secondsLeft, percentLeft, spellID, spellName, notInterruptable, isChannel = Unit(player):IsCastingRemains()
    -- @return:
    -- [1] Currect Casting Left Time (seconds) (@number)
    -- [2] Current Casting Left Time (percent) (@number)
    -- [3] spellID (@number)
    -- [4] spellName (@string)
    -- [5] notInterruptable (@boolean, false is able to be interrupted)
    -- [6] isChannel (@boolean)
    if percentLeft > 0.01 and spellName == A.FocusedAzeriteBeam:Info() then 
        CanCast = false
    else
        CanCast = true
    end    
    
    if not CanCast then
        return A.PoolResource:Show(icon)
    end
    
    
    ------------------------------------
    ---------- DUMMY DPS TEST ----------
    ------------------------------------
    local DummyTime = GetToggle(2, "DummyTime")
    if DummyTime > 0 then
        local unit = "target"
        local endtimer = 0
        
        if Unit(unit):IsExists() and Unit(unit):IsDummy() then
            if Unit(player):CombatTime() >= (DummyTime * 60) then
                StopAttack()
                endtimer = TMW.time
                --ClearTarget() -- Protected ? 
                -- Notification                    
                Action.SendNotification(DummyTime .. " Minutes Dummy Test Concluded - Profile Stopped", A.DummyTest.ID)            
                
                if endtimer < TMW.time + 5 then
                    profileStop = true
                    --return A.DummyTest:Show(icon)
                end
            end
        end
    end    
    -- Mounted
    if Player:IsMounted() then
        profileStop = true
    end
    
    ------------------------------------------------------
    ---------------- ENEMY UNIT ROTATION -----------------
    ------------------------------------------------------
    local function EnemyRotation(unit)
        
        -- BattleShout
        if A.BattleShout:IsReady(player) and A.BattleShout:GetSpellTimeSinceLastCast() >= 60 and Unit(player):HasBuffs(A.BattleShout.ID, true) == 0 then
            return A.BattleShout:Show(icon)
        end
        
        -- Init current Execute ID        
        UpdateExecuteID()
        
        --Precombat
        if combatTime == 0 and Unit(unit):IsExists() and unit ~= "mouseover" then
            -- flask
            -- food
            -- augmentation
            -- snapshot_stats
            
            -- use_item,name=azsharas_font_of_power
            if A.AzsharasFontofPower:IsReady(player) then
                A.AzsharasFontofPower:Show(icon)
            end
            
            -- worldvein_resonance
            if A.WorldveinResonance:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") then
                return A.WorldveinResonance:Show(icon)
            end
            
            -- memory_of_lucid_dreams
            if A.MemoryofLucidDreams:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") then
                return A.MemoryofLucidDreams:Show(icon)
            end
            
            -- guardian_of_azeroth
            if A.GuardianofAzeroth:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") then
                return A.GuardianofAzeroth:Show(icon)
            end
            
            -- potion
            if A.PotionofUnbridledFury:IsReady(unit) and Action.GetToggle(1, "Potion") then
                return A.PotionofUnbridledFury:Show(icon)
            end
            
            -- charge
            if A.Charge:IsReady(unit) and UseCharge then
                return A.Charge:Show(icon)
            end    
            
        end             
        
        -- In Combat
        if inCombat and Unit(unit):IsExists() then        
            -- auto_attack
            -- charge
            if A.Charge:IsReady(unit) and UseCharge and isMovingFor > ChargeTime then
                return A.Charge:Show(icon)
            end
            
            -- Smart Stormbolt            
            if SmartStormbolt then
                local Stormbolt_Nameplates = MultiUnits:GetActiveUnitPlates()
                if Stormbolt_Nameplates then                                         
                    for Stormbolt_UnitID in pairs(Stormbolt_Nameplates) do                            
                        for k, v in pairs(TR.Lists.Storm_Spells_List) do
                            if (TR.Lists.Storm_Unit_List[select(6, Unit(Stormbolt_UnitID):InfoGUID())] ~= nil or UnitCastingInfo(Stormbolt_UnitID) == GetSpellInfo(v) or UnitChannelInfo(Stormbolt_UnitID) == GetSpellInfo(v)) and Unit(Stormbolt_UnitID):GetRange() <= 20 then                           
                                if A.Stormbolt:IsSpellLearned() and A.Stormbolt:IsReadyByPassCastGCD("player") then
                                    return A.Stormbolt:Show(icon)
                                end
                            end
                        end    
                    end 
                end                        
            end      
            
            -- Interrupt
            local Interrupt = Interrupts(unit)
            if Interrupt then 
                return Interrupt:Show(icon)
            end
            
            -- run_action_list,name=movement,if=movement.distance>5
            if Unit(unit):GetRange() > 5 then
                -- heroic_leap
                if A.HeroicLeap:IsReady(unit) and UseHeroicLeap and isMovingFor > HeroicLeapTime then
                    return A.HeroicLeap:Show(icon)
                end
            end
            
            -- BattleShout
            if A.BattleShout:IsReady(player) and A.BattleShout:GetSpellTimeSinceLastCast() >= 60 and Unit(player):HasBuffs(A.BattleShout.ID, true) == 0 and not A.LastPlayerCastName == A.BattleShout:Info() then
                return A.BattleShout:Show(icon)
            end    
            
            -- Cooldowns
            if unit ~= "mouseover" and A.BurstIsON(unit) then 
                -- potion,if=target.health.pct<21&buff.memory_of_lucid_dreams.up|!essence.memory_of_lucid_dreams.major
                if A.PotionofUnbridledFury:IsReady(unit) and Action.GetToggle(1, "Potion") and (Unit(unit):HealthPercent() < 21 and Unit("player"):HasBuffs(A.MemoryofLucidDreams.ID, true) > 0 or not Azerite:EssenceHasMajor(A.MemoryofLucidDreams.ID)) then
                    return A.PotionofUnbridledFury:Show(icon)
                end
                
                -- blood_fury,if=buff.memory_of_lucid_dreams.remains<5|(!essence.memory_of_lucid_dreams.major&debuff.colossus_smash.up)
                if A.BloodFury:AutoRacial(unit) and Action.GetToggle(1, "Racial") and A.BurstIsON(unit) and (Unit("player"):HasBuffs(A.MemoryofLucidDreams.ID, true) < 5 or (not Azerite:EssenceHasMajor(A.MemoryofLucidDreams.ID) and Unit(unit):HasDeBuffs(A.ColossusSmashDebuff.ID, true) > 0)) then
                    return A.BloodFury:Show(icon)
                end
                
                -- berserking,if=buff.memory_of_lucid_dreams.up|(!essence.memory_of_lucid_dreams.major&debuff.colossus_smash.up)
                if A.Berserking:AutoRacial(unit) and Action.GetToggle(1, "Racial") and A.BurstIsON(unit) and (Unit("player"):HasBuffs(A.MemoryofLucidDreams.ID, true) > 0 or (not Azerite:EssenceHasMajor(A.MemoryofLucidDreams.ID) and Unit(unit):HasDeBuffs(A.ColossusSmashDebuff.ID, true) > 0)) then
                    return A.Berserking:Show(icon)
                end
                
                -- arcane_torrent,if=cooldown.mortal_strike.remains>1.5&buff.memory_of_lucid_dreams.down&rage<50
                if A.ArcaneTorrent:AutoRacial(unit) and Action.GetToggle(1, "Racial") and A.BurstIsON(unit) and (A.MortalStrike:GetCooldown() > 1.5 and Unit("player"):HasBuffs(A.MemoryofLucidDreams.ID, true) == 0 and Player:Rage() < 50) then
                    return A.ArcaneTorrent:Show(icon)
                end
                
                -- lights_judgment,if=debuff.colossus_smash.down&buff.memory_of_lucid_dreams.down&cooldown.mortal_strike.remains
                if A.LightsJudgment:IsReady(unit) and A.BurstIsON(unit) and (Unit(unit):HasDeBuffs(A.ColossusSmashDebuff.ID, true) == 0 and Unit("player"):HasBuffs(A.MemoryofLucidDreams.ID, true) == 0 and A.MortalStrike:GetCooldown() > 0) then
                    return A.LightsJudgment:Show(icon)
                end
                
                -- fireblood,if=buff.memory_of_lucid_dreams.remains<5|(!essence.memory_of_lucid_dreams.major&debuff.colossus_smash.up)
                if A.Fireblood:AutoRacial(unit) and Action.GetToggle(1, "Racial") and A.BurstIsON(unit) and (Unit("player"):HasBuffs(A.MemoryofLucidDreams.ID, true) < 5 or (not Azerite:EssenceHasMajor(A.MemoryofLucidDreams.ID) and Unit(unit):HasDeBuffs(A.ColossusSmashDebuff.ID, true) > 0)) then
                    return A.Fireblood:Show(icon)
                end
                
                -- ancestral_call,if=buff.memory_of_lucid_dreams.remains<5|(!essence.memory_of_lucid_dreams.major&debuff.colossus_smash.up)
                if A.AncestralCall:AutoRacial(unit) and Action.GetToggle(1, "Racial") and A.BurstIsON(unit) and (Unit("player"):HasBuffs(A.MemoryofLucidDreams.ID, true) < 5 or (not Azerite:EssenceHasMajor(A.MemoryofLucidDreams.ID) and Unit(unit):HasDeBuffs(A.ColossusSmashDebuff.ID, true) > 0)) then
                    return A.AncestralCall:Show(icon)
                end
                
                -- bag_of_tricks,if=debuff.colossus_smash.down&buff.memory_of_lucid_dreams.down&cooldown.mortal_strike.remains
                if A.BagofTricks:AutoRacial(unit) and (Unit(unit):HasDeBuffs(A.ColossusSmashDebuff.ID, true) == 0 and Unit("player"):HasBuffs(A.MemoryofLucidDreams.ID, true) == 0 and A.MortalStrike:GetCooldown() > 0) then
                    return A.BagofTricks:Show(icon)
                end
                
                -- use_item,name=ashvanes_razor_coral,if=!debuff.razor_coral_debuff.up|(target.health.pct<20.1&buff.memory_of_lucid_dreams.up&cooldown.memory_of_lucid_dreams.remains<117)|(target.health.pct<30.1&debuff.conductive_ink_debuff.up&!essence.memory_of_lucid_dreams.major)|(!debuff.conductive_ink_debuff.up&!essence.memory_of_lucid_dreams.major&debuff.colossus_smash.up)|target.time_to_die<30
                if A.AshvanesRazorCoral:IsReady(unit) and 
                (
                    Unit(unit):HasDeBuffs(A.RazorCoralDebuff.ID, true) == 0
                    or
                    (
                        Unit(unit):HealthPercent() < 20.1 and Unit("player"):HasBuffs(A.MemoryofLucidDreams.ID, true) and A.MemoryofLucidDreams:GetCooldown() < 117
                    ) 
                    or
                    (
                        Unit(unit):HealthPercent() < 30.1 and Unit(unit):HasDeBuffs(A.ConductiveInkDebuff.ID, true) > 0 and not Azerite:EssenceHasMajor(A.MemoryofLucidDreams.ID)
                    ) 
                    or
                    (
                        Unit(unit):HasDeBuffs(A.ConductiveInkDebuff.ID, true) == 0 and not Azerite:EssenceHasMajor(A.MemoryofLucidDreams.ID) and Unit(unit):HasDeBuffs(A.ColossusSmashDebuff.ID, true) > 0
                    )
                    or Unit(unit):TimeToDie() < 30
                )
                then
                    return A.AshvanesRazorCoral:Show(icon)
                end
                
                -- avatar,if=cooldown.colossus_smash.remains<8|(talent.warbreaker.enabled&cooldown.warbreaker.remains<8)
                if A.Avatar:IsReady(unit) and A.BurstIsON(unit) and (A.ColossusSmash:GetCooldown() < 8 or (A.Warbreaker:IsSpellLearned() and A.Warbreaker:GetCooldown() < 8)) then
                    return A.Avatar:Show(icon)
                end
                
                -- blood_of_the_enemy,if=buff.test_of_might.up|(debuff.colossus_smash.up&!azerite.test_of_might.enabled)
                if A.BloodoftheEnemy:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") and (Unit("player"):HasBuffs(A.TestofMightBuff.ID, true) > 0 or (Unit(unit):HasDeBuffs(A.ColossusSmashDebuff.ID, true) > 0 and A.TestofMight:GetAzeriteRank() == 0)) then
                    return A.BloodoftheEnemy:Show(icon)
                end
                
                -- purifying_blast,if=!debuff.colossus_smash.up&!buff.test_of_might.up
                if A.PurifyingBlast:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") and (Unit(unit):HasDeBuffs(A.ColossusSmashDebuff.ID, true) == 0 and Unit("player"):HasBuffs(A.TestofMightBuff.ID, true) == 0) then
                    return A.PurifyingBlast:Show(icon)
                end
                
                -- ripple_in_space,if=!debuff.colossus_smash.up&!buff.test_of_might.up
                if A.RippleinSpace:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") and (Unit(unit):HasDeBuffs(A.ColossusSmashDebuff.ID, true) == 0 and Unit("player"):HasBuffs(A.TestofMightBuff.ID, true) == 0) then
                    return A.RippleinSpace:Show(icon)
                end
                
                -- worldvein_resonance,if=!debuff.colossus_smash.up&!buff.test_of_might.up
                if A.WorldveinResonance:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") and (Unit(unit):HasDeBuffs(A.ColossusSmashDebuff.ID, true) == 0 and Unit("player"):HasBuffs(A.TestofMightBuff.ID, true) == 0) then
                    return A.WorldveinResonance:Show(icon)
                end
                
                -- focused_azerite_beam,if=!debuff.colossus_smash.up&!buff.test_of_might.up
                if A.FocusedAzeriteBeam:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") and (Unit(unit):HasDeBuffs(A.ColossusSmashDebuff.ID, true) == 0 and Unit("player"):HasBuffs(A.TestofMightBuff.ID, true) == 0) then
                    return A.FocusedAzeriteBeam:Show(icon)
                end
                
                -- reaping_flames,if=!debuff.colossus_smash.up&!buff.test_of_might.up
                if A.ReapingFlames:AutoHeartOfAzerothP(unit, true) and (Unit(unit):HasDeBuffs(A.ColossusSmashDebuff.ID, true) == 0 and Unit("player"):HasBuffs(A.TestofMightBuff.ID, true) == 0) then
                    return A.ReapingFlames:Show(icon)
                end
                
                -- concentrated_flame,if=!debuff.colossus_smash.up&!buff.test_of_might.up&dot.concentrated_flame_burn.remains=0
                if A.ConcentratedFlame:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") and 
                (
                    Unit(unit):HasDeBuffs(A.ColossusSmashDebuff.ID, true) == 0 
                    and
                    Unit("player"):HasBuffs(A.TestofMightBuff.ID, true) == 0 
                    and
                    Unit(unit):HasDeBuffs(A.ConcentratedFlameBurnDebuff.ID, true) == 0
                )
                then
                    return A.ConcentratedFlame:Show(icon)
                end
                
                -- the_unbound_force,if=buff.reckless_force.up
                if A.TheUnboundForce:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") and (Unit("player"):HasBuffs(A.RecklessForceBuff.ID, true) > 0) then
                    return A.TheUnboundForce:Show(icon)
                end
                
                -- guardian_of_azeroth,if=cooldown.colossus_smash.remains<10
                if A.GuardianofAzeroth:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") and (A.ColossusSmash:GetCooldown() < 10) then
                    return A.GuardianofAzeroth:Show(icon)
                end
                
                -- memory_of_lucid_dreams,if=!talent.warbreaker.enabled&cooldown.colossus_smash.remains<gcd&(target.time_to_die>150|target.health.pct<20)
                if A.MemoryofLucidDreams:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") and (not A.Warbreaker:IsSpellLearned() and A.ColossusSmash:GetCooldown() < A.GetGCD() and (Unit(unit):TimeToDie() > 150 or Unit(unit):HealthPercent() < 20)) then
                    return A.MemoryofLucidDreams:Show(icon)
                end
                
                -- memory_of_lucid_dreams,if=talent.warbreaker.enabled&cooldown.warbreaker.remains<gcd&(target.time_to_die>150|target.health.pct<20)
                if A.MemoryofLucidDreams:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") and 
                (
                    A.Warbreaker:IsSpellLearned() and A.Warbreaker:GetCooldown() < A.GetGCD() and 
                    (
                        Unit(unit):TimeToDie() > 150 
                        or
                        Unit(unit):HealthPercent() < 20
                    )
                )
                then
                    return A.MemoryofLucidDreams:Show(icon)
                end
            end
            
            -- Non SIMC Custom Trinket1
            if A.Trinket1:IsReady(unit) and Trinket1IsAllowed and CanCast and    
            (
                TrinketsAoE and GetByRange(TrinketsMinUnits, TrinketsUnitsRange) and Player:AreaTTD(TrinketsUnitsRange) > TrinketsMinTTD
                or
                not TrinketAoE and Unit(unit):TimeToDie() >= TrinketsMinTTD                     
            )
            then 
                return A.Trinket1:Show(icon)
            end             
            
            -- Non SIMC Custom Trinket2
            if A.Trinket2:IsReady(unit) and Trinket2IsAllowed and CanCast and        
            (
                TrinketsAoE and GetByRange(TrinketsMinUnits, TrinketsUnitsRange) and Player:AreaTTD(TrinketsUnitsRange) > TrinketsMinTTD
                or
                not TrinketAoE and Unit(unit):TimeToDie() >= TrinketsMinTTD                     
            )
            then
                return A.Trinket2:Show(icon)     
            end
            
            -- run_action_list,name=single_target        
            if ((A.Massacre:IsSpellLearned() and Unit(unit):HealthPercent() >= 35) or Unit(unit):HealthPercent() >= 20) and GetByRange(2, 8, false, true) then
                
                -- rend, ST
                if A.Rend:IsReady(unit) and InMelee(unit) and (Unit(unit):HasDeBuffs(A.RendDebuff.ID, true) <= 4 and Unit(unit):HasDeBuffs(A.ColossusSmashDebuff.ID, true) == 0) then
                    return A.Rend:Show(icon)
                end
                
                -- skullsplitter, ST
                if A.Skullsplitter:IsSpellLearned() and InMelee(unit) and A.Skullsplitter:IsReady(unit) and 
                (Player:Rage() < 60 and Unit("player"):HasBuffs(A.DeadlyCalmBuff.ID, true) == 0 and Unit("player"):HasBuffs(A.MemoryofLucidDreams.ID, true) == 0)
                then
                    return A.Skullsplitter:Show(icon)
                end
                
                -- colossus_smash
                if A.ColossusSmash:IsReady(unit) and ((A.Avatar:IsSpellLearned() and not A.Avatar:IsReady(unit)) or Unit("player"):HasBuffs(A.Avatar.ID, true)) and InMelee(unit) then
                    return A.ColossusSmash:Show(icon)
                end
                
                -- ravager
                if A.Ravager:IsReady(player) and A.Ravager:IsSpellLearned() and A.BurstIsON(unit) and 
                A.DeadlyCalm:IsSpellLearned() and Unit("player"):HasBuffs(A.DeadlyCalmBuff.ID, true) == 0 and 
                (
                    (Unit(unit):HasDeBuffs(A.ColossusSmashDebuff.ID, true) > 0 and A.TestofMight:GetAzeriteRank() == 0) 
                    or 
                    Unit("player"):HasBuffs(A.TestofMightBuff.ID, true) > 0
                )
                then
                    return A.Ravager:Show(icon)
                end
                
                -- warbreaker
                if A.Warbreaker:IsReady(unit) and InMelee(unit) and 
                (
                    (A.Avatar:IsSpellLearned() and not A.Avatar:IsReady(unit)) 
                    or 
                    Unit("player"):HasBuffs(A.Avatar.ID, true) > 0
                )                  
                then
                    return A.Warbreaker:Show(icon)
                end
                
                -- deadly_calm
                if A.DeadlyCalm:IsSpellLearned() and InMelee(unit) and not A.Skullsplitter:IsReady(unit) and A.DeadlyCalm:IsReady(unit) and Player:Rage() < 30 then
                    return A.DeadlyCalm:Show(icon)
                end
                
                -- execute,if=buff.sudden_death.react
                if Execute:IsReady(unit) and InMelee(unit) and Unit("player"):HasBuffsStacks(A.SuddenDeathBuff.ID, true) > 0 then
                    return Execute:Show(icon)
                end
                
                -- overpower
                if A.Overpower:IsReady(unit) and InMelee(unit)
                then
                    return A.Overpower:Show(icon)
                end
                
                -- mortal_strike
                if A.MortalStrike:IsReady(unit) and InMelee(unit) then
                    return A.MortalStrike:Show(icon)
                end
                
                -- bladestorm
                if A.Bladestorm:IsReady(player) and InMelee(unit) and A.BurstIsON(unit) and 
                A.DeadlyCalm:IsSpellLearned() and Unit("player"):HasBuffs(A.DeadlyCalmBuff.ID, true) == 0 and 
                (
                    (Unit(unit):HasDeBuffs(A.ColossusSmashDebuff.ID, true) and A.TestofMight:GetAzeriteRank() == 0) 
                    or 
                    Unit("player"):HasBuffs(A.TestofMightBuff.ID, true) > 0
                )
                then
                    return A.Bladestorm:Show(icon)
                end
                
                -- whirlwind,if=talent.fervor_of_battle.enabled
                if A.Whirlwind:IsReady(unit) and InMelee(unit) and A.FervorofBattle:IsSpellLearned() and ((A.TestofMight:GetAzeriteRank() > 0 and (Player:Rage() > 60 or Unit(unit):HasDeBuffs(A.ColossusSmashDebuff.ID, true) or Unit("player"):HasBuffs(A.TestofMightBuff.ID, true))) or A.TestofMight:GetAzeriteRank() == 0)
                then
                    return A.Whirlwind:Show(icon)
                end
                
                -- slam,if=!talent.fervor_of_battle.enabled
                if A.Slam:IsReady(unit) and InMelee(unit) and not A.FervorofBattle:IsSpellLearned() and ((A.TestofMight:GetAzeriteRank() > 0 and (Player:Rage() > 60 or Unit(unit):HasDeBuffs(A.ColossusSmashDebuff.ID, true) or Unit("player"):HasBuffs(A.TestofMightBuff.ID, true))) or A.TestofMight:GetAzeriteRank() == 0)
                then
                    return A.Slam:Show(icon)
                end
            end        
            
            -- run_action_list,name=execute            
            if ((A.Massacre:IsSpellLearned() and Unit(unit):HealthPercent() < 35) or Unit(unit):HealthPercent() < 20) and GetByRange(2, 8, false, true) then
                
                -- skullsplitter, execute
                if A.Skullsplitter:IsReady(unit) and InMelee(unit) and (Player:Rage() < 60 and Unit("player"):HasBuffs(A.DeadlyCalmBuff.ID, true) == 0 and Unit("player"):HasBuffs(A.MemoryofLucidDreams.ID, true) == 0)
                then
                    return A.Skullsplitter:Show(icon)
                end
                
                -- colossus_smash, execute
                if A.ColossusSmash:IsReady(unit) and InMelee(unit) and ((A.Avatar:IsSpellLearned() and not A.Avatar:IsReady(unit)) or Unit("player"):HasBuffs(A.Avatar.ID, true)) then
                    return A.ColossusSmash:Show(icon)
                end
                
                -- warbreaker, execute
                if A.Warbreaker:IsReady(unit) and InMelee(unit) and ((A.Avatar:IsSpellLearned() and not A.Avatar:IsReady(unit)) or Unit("player"):HasBuffs(A.Avatar.ID, true)) then
                    return A.Warbreaker:Show(icon)
                end
                
                -- ravager, execute
                if A.Ravager:IsReady(player) and InMelee(unit) and A.Ravager:IsSpellLearned() and A.BurstIsON(unit) and Unit("player"):HasBuffs(A.DeadlyCalmBuff.ID, true) == 0 and 
                (
                    Player:Rage() < 30 
                    or 
                    (A.TestofMight:GetAzeriteRank() > 0 and Unit(unit):HasDeBuffs(A.ColossusSmashDebuff.ID, true) == 0)
                )
                then
                    return A.Ravager:Show(icon)
                end
                
                -- bladestorm, execute
                if A.Bladestorm:IsReady(player) and InMelee(unit) and A.BurstIsON(unit) and Unit("player"):HasBuffs(A.DeadlyCalmBuff.ID, true) == 0 and 
                (
                    Player:Rage() < 30 
                    or 
                    (A.TestofMight:GetAzeriteRank() > 0 and Unit(unit):HasDeBuffs(A.ColossusSmashDebuff.ID, true) == 0)
                )
                then
                    return A.Bladestorm:Show(icon)
                end
                
                -- deadly_calm
                if A.DeadlyCalm:IsSpellLearned() and InMelee(unit) and A.DeadlyCalm:IsReady(unit) and Unit(unit):HasDeBuffs(A.ColossusSmashDebuff.ID, true) > 0 then
                    return A.DeadlyCalm:Show(icon)
                end
                
                -- whirlwind,if=talent.fervor_of_battle.enabled
                if A.Whirlwind:IsReady(unit) and InMelee(unit) and A.FervorofBattle:IsSpellLearned() and Unit("player"):HasBuffs(A.CrushingAssaultBuff.ID, true) > 0
                then
                    return A.Whirlwind:Show(icon)
                end
                
                -- slam,if=buff.crushing_assault.up&buff.memory_of_lucid_dreams.down
                if A.Slam:IsReady(unit) and InMelee(unit) and not A.FervorofBattle:IsSpellLearned() and Unit("player"):HasBuffs(A.CrushingAssaultBuff.ID, true) > 0 then
                    return A.Slam:Show(icon)
                end
                
                -- mortal_strike,if=buff.overpower.stack=2&talent.dreadnaught.enabled|buff.executioners_precision.stack=2
                if A.MortalStrike:IsReady(unit) and InMelee(unit) and (Unit("player"):HasBuffsStacks(A.OverpowerBuff.ID, true) == 2 and A.Dreadnaught:IsSpellLearned())
                then
                    return A.MortalStrike:Show(icon)
                end

                -- overpower
                if A.Overpower:IsReady(unit) and InMelee(unit) then
                    return A.Overpower:Show(icon)
                end
                
                -- execute
                if Execute:IsReady(unit) and InMelee(unit) then
                    return Execute:Show(icon)
                end
            end
            
            -- run_action_list,name=AOE                        
            if GetByRange(2, 8) then
                
                -- sweeping_strikes
                if A.SweepingStrikes:IsReady(player) 
                then
                    return A.SweepingStrikes:Show(icon)
                end
                
                -- rend, AOE
                if A.Rend:IsReady(unit) and (Unit(unit):HasDeBuffs(A.RendDebuff.ID, true) <= 4 and (Unit("player"):HasBuffs(A.SweepingStrikesBuff.ID, true) > 0) and Unit(unit):HasDeBuffs(A.ColossusSmashDebuff.ID, true) == 0)
                then
                    return A.Rend:Show(icon)
                end
                
                -- skullsplitter, AOE
                if A.Skullsplitter:IsSpellLearned() and A.Skullsplitter:IsReady(unit) and Player:Rage() < 60 and Unit("player"):HasBuffs(A.MemoryofLucidDreams.ID, true) == 0 and (A.Ravager:GetCooldown() > 3 or A.Bladestorm:GetCooldown() > 3)
                then
                    return A.Skullsplitter:Show(icon)
                end
                
                -- deadly_calm, AOE
                if A.DeadlyCalm:IsReady(unit) and Player:Rage() < 30
                then
                    return A.DeadlyCalm:Show(icon)
                end
                
                -- colossus_smash, AOE
                if A.ColossusSmash:IsReady(unit) and (Unit("player"):HasBuffs(A.SweepingStrikesBuff.ID, true) > 0)
                then
                    return A.ColossusSmash:Show(icon)
                end
                
                -- warbreaker, AOE
                if A.Warbreaker:IsReady(unit)
                then
                    return A.Warbreaker:Show(icon)
                end
                
                -- ravager, AOE
                if A.Ravager:IsReady(player) and A.Ravager:IsSpellLearned() and
                (
                    Unit("player"):HasBuffs(A.DeadlyCalm.ID, true) == 0 and Unit("player"):HasBuffs(A.SweepingStrikes.ID, true) == 0
                    or 
                    (Unit(unit):HasDeBuffs(A.ColossusSmashDebuff.ID, true) > 3 and not (Unit(unit):HasDeBuffs(A.ColossusSmashDebuff.ID, true) > 0 and A.TestofMight:GetAzeriteRank() > 0))
                )
                then
                    return A.Ravager:Show(icon)
                end
                
                -- bladestorm, AOE
                if A.Bladestorm:IsReady(player) and
                (                
                    Unit("player"):HasBuffs(A.DeadlyCalm.ID, true) == 0 and Unit("player"):HasBuffs(A.SweepingStrikes.ID, true) == 0
                    or 
                    (Unit(unit):HasDeBuffs(A.ColossusSmashDebuff.ID, true) > 3 and not (Unit(unit):HasDeBuffs(A.ColossusSmashDebuff.ID, true) > 0 and A.TestofMight:GetAzeriteRank() > 0))
                )
                then
                    return A.Bladestorm:Show(icon)
                end
                
                -- cleave, AOE
                if A.Cleave:IsReady(player) then
                    return A.Cleave:Show(icon)
                end
                
                -- overpower, AOE
                if A.Overpower:IsReady(unit)
                then
                    return A.Overpower:Show(icon)
                end
                
                -- execute, AOE
                if Execute:IsReady(unit) and not GetByRange(5, 8) and (Unit("player"):HasBuffs(A.SweepingStrikesBuff.ID, true) > 0)
                then
                    return Execute:Show(icon)
                end
                
                -- mortal_strike, AOE
                if A.MortalStrike:IsReady(unit) and not GetByRange(5, 8) and (Unit("player"):HasBuffs(A.SweepingStrikesBuff.ID, true) > 0)
                then
                    return A.MortalStrike:Show(icon)
                end
                
                -- whirlwind, AOE
                if A.Whirlwind:IsReady(unit) and GetByRange(5, 8) then
                    return A.Whirlwind:Show(icon)
                end                            
            end    
            
            -- End on EnemyRotation()
        end
    end    
    
    -- Defensive
    local SelfDefensive = SelfDefensives()
    if SelfDefensive then 
        return SelfDefensive:Show(icon)
    end 
    
    -- Mouseover
    if A.IsUnitEnemy("mouseover") then
        unit = "mouseover"
        if EnemyRotation(unit) then 
            return true 
        end 
    end 
    
    -- Target  
    if A.IsUnitEnemy("target") then 
        unit = "target"
        if EnemyRotation(unit) then 
            return true
        end                         
    end
    
end  -- Finished 


-- [4] AoE Rotation
A[4] = function(icon)
    return A[3](icon, true)
end

-- [5] Trinket Rotation
-- No specialization trinket actions 
-- Passive 
--[[local function FreezingTrapUsedByEnemy()
if     UnitCooldown:GetCooldown("arena", 3355) > UnitCooldown:GetMaxDuration("arena", 3355) - 2 and
UnitCooldown:IsSpellInFly("arena", 3355) and 
Unit("player"):GetDR("incapacitate") >= 50 
then 
        local Caster = UnitCooldown:GetUnitID("arena", 3355)
        if Caster and Unit(Caster):GetRange() <= 40 then 
            return true 
        end 
    end 
end 
local function ArenaRotation(icon, unit)
    if A.IsInPvP and (A.Zone == "pvp" or A.Zone == "arena") and not Player:IsStealthed() and not Player:IsMounted() then
        -- Note: "arena1" is just identification of meta 6
        if unit == "arena1" and (Unit("player"):GetDMG() == 0 or not Unit("player"):IsFocused("DAMAGER")) then 
            -- Reflect Casting BreakAble CC
            if A.NetherWard:IsReady() and A.NetherWard:IsSpellLearned() and Action.ShouldReflect(EnemyTeam()) and EnemyTeam():IsCastingBreakAble(0.25) then 
                return A.NetherWard:Show(icon)
            end 
        end
    end 
end 
local function PartyRotation(unit)
    if (unit == "party1" and not A.GetToggle(2, "PartyUnits")[1]) or (unit == "party2" and not A.GetToggle(2, "PartyUnits")[2]) then 
        return false 
    end

      -- SingeMagic
    if A.SingeMagic:IsCastable() and A.SingeMagic:AbsentImun(unit, Temp.TotalAndMag) and IsSchoolFree() and Action.AuraIsValid(unit, "UseDispel", "Magic") and not Unit(unit):InLOS() then
        return A.SingeMagic:Show(icon)
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
end]]--

