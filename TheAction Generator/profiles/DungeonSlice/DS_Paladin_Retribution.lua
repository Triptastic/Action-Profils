-------------------------------
-- Taste TMW Action Rotation --
-------------------------------
local TMW                                       = TMW
local CNDT                                      = TMW.CNDT
local Env                                       = CNDT.Env
local Action                                    = Action
local Listener                                  = Action.Listener
local Create                                    = Create
local GetToggle                                 = Action.GetToggle
local SetToggle                                 = Action.SetToggle
local GetGCD                                    = Action.GetGCD
local GetCurrentGCD                             = Action.GetCurrentGCD
local GetPing                                   = Action.GetPing
local ShouldStop                                = Action.ShouldStop
local BurstIsON                                 = Action.BurstIsON
local AuraIsValid                               = Action.AuraIsValid
local InterruptIsValid                          = Action.InterruptIsValid
local FrameHasSpell                             = Action.FrameHasSpell
local Azerite                                   = LibStub("AzeriteTraits")
local Utils                                     = Action.Utils
local TeamCache                                 = Action.TeamCache
local EnemyTeam                                 = Action.EnemyTeam
local FriendlyTeam                              = Action.FriendlyTeam
local LoC                                       = Action.LossOfControl
local Player                                    = Action.Player
local MultiUnits                                = Action.MultiUnits
local UnitCooldown                              = Action.UnitCooldown
local Unit                                      = Action.Unit
local IsUnitEnemy                               = Action.IsUnitEnemy
local IsUnitFriendly                            = Action.IsUnitFriendly
local HealingEngine                             = Action.HealingEngine
local ActiveUnitPlates                          = MultiUnits:GetActiveUnitPlates()
local TeamCacheFriendly                         = TeamCache.Friendly
local TeamCacheFriendlyIndexToPLAYERs           = TeamCacheFriendly.IndexToPLAYERs
local IsIndoors, UnitIsUnit                     = IsIndoors, UnitIsUnit
local TR                                        = Action.TasteRotation
local Pet                                       = LibStub("PetLibrary")
local next, pairs, type, print                  = next, pairs, type, print
local math_floor                                = math.floor
local math_ceil                                 = math.ceil
local tinsert                                   = table.insert
local select, unpack, table                     = select, unpack, table
local CombatLogGetCurrentEventInfo              = _G.CombatLogGetCurrentEventInfo
local UnitGUID, UnitIsUnit, UnitDamage, UnitAttackSpeed, UnitAttackPower = UnitGUID, UnitIsUnit, UnitDamage, UnitAttackSpeed, UnitAttackPower
local _G, setmetatable, select, math            = _G, setmetatable, select, math
local huge                                      = math.huge
local UIParent                                  = _G.UIParent
local CreateFrame                               = _G.CreateFrame
local wipe                                      = _G.wipe
local IsUsableSpell                             = IsUsableSpell
local UnitPowerType                             = UnitPowerType

--- ============================ CONTENT =========================== ---
--- ======================= SPELLS DECLARATION ===================== ---

Action[ACTION_CONST_PALADIN_RETRIBUTION] = {
    -- Racial
    ArcaneTorrent                          = Create({ Type = "Spell", ID = 50613     }),
    BloodFury                              = Create({ Type = "Spell", ID = 20572      }),
    Fireblood                              = Create({ Type = "Spell", ID = 265221     }),
    AncestralCall                          = Create({ Type = "Spell", ID = 274738     }),
    Berserking                             = Create({ Type = "Spell", ID = 26297    }),
    ArcanePulse                            = Create({ Type = "Spell", ID = 260364    }),
    QuakingPalm                            = Create({ Type = "Spell", ID = 107079     }),
    Haymaker                               = Create({ Type = "Spell", ID = 287712     }), 
    WarStomp                               = Create({ Type = "Spell", ID = 20549     }),
    BullRush                               = Create({ Type = "Spell", ID = 255654     }),  
    GiftofNaaru                            = Create({ Type = "Spell", ID = 59544    }),
    Shadowmeld                             = Create({ Type = "Spell", ID = 58984    }), -- usable in Action Core 
    Stoneform                              = Create({ Type = "Spell", ID = 20594    }), 
    WilloftheForsaken                      = Create({ Type = "Spell", ID = 7744        }), -- not usable in APL but user can Queue it   
    EscapeArtist                           = Create({ Type = "Spell", ID = 20589    }), -- not usable in APL but user can Queue it
    EveryManforHimself                     = Create({ Type = "Spell", ID = 59752    }), -- not usable in APL but user can Queue it
    -- Generics
    ArcaneTorrent                          = Create({ Type = "Spell", ID = 50613 }),
    WakeofAshes                            = Create({ Type = "Spell", ID = 255937 }),
    AvengingWrathBuff                      = Create({ Type = "Spell", ID = 31884 }),
    CrusadeBuff                            = Create({ Type = "Spell", ID = 231895 }),
    LightsJudgment                         = Create({ Type = "Spell", ID = 255647 }),
    Fireblood                              = Create({ Type = "Spell", ID = 265221 }),
    ShieldofVengeance                      = Create({ Type = "Spell", ID = 184662 }),
    SeethingRageBuff                       = Create({ Type = "Spell", ID =  }),
    Crusade                                = Create({ Type = "Spell", ID = 231895 }),
    AvengingWrath                          = Create({ Type = "Spell", ID = 31884 }),
    InquisitionBuff                        = Create({ Type = "Spell", ID = 84963 }),
    Inquisition                            = Create({ Type = "Spell", ID = 84963 }),
    BladeofJustice                         = Create({ Type = "Spell", ID = 184575 }),
    Judgment                               = Create({ Type = "Spell", ID = 20271 }),
    RighteousVerdict                       = Create({ Type = "Spell", ID = 267610 }),
    EmpyreanPowerBuff                      = Create({ Type = "Spell", ID = 286393 }),
    JudgmentDebuff                         = Create({ Type = "Spell", ID = 197277 }),
    DivinePurposeBuff                      = Create({ Type = "Spell", ID = 223819 }),
    AvengingWrathAutocritBuff              = Create({ Type = "Spell", ID =  }),
    ExecutionSentence                      = Create({ Type = "Spell", ID = 267798 }),
    DivineStorm                            = Create({ Type = "Spell", ID = 53385 }),
    TemplarsVerdict                        = Create({ Type = "Spell", ID = 85256 }),
    HammerofWrath                          = Create({ Type = "Spell", ID = 24275 }),
    Consecration                           = Create({ Type = "Spell", ID = 205228 }),
    CrusaderStrike                         = Create({ Type = "Spell", ID = 35395 }),
    ReapingFlames                          = Create({ Type = "Spell", ID =  }),
    Rebuke                                 = Create({ Type = "Spell", ID = 96231 })
    -- Trinkets
    TrinketTest                            = Create({ Type = "Trinket", ID = 122530, QueueForbidden = true }), 
    TrinketTest2                           = Create({ Type = "Trinket", ID = 159611, QueueForbidden = true }), 
    AzsharasFontofPower                    = Create({ Type = "Trinket", ID = 169314, QueueForbidden = true }), 
    PocketsizedComputationDevice           = Create({ Type = "Trinket", ID = 167555, QueueForbidden = true }), 
    RotcrustedVoodooDoll                   = Create({ Type = "Trinket", ID = 159624, QueueForbidden = true }), 
    ShiverVenomRelic                       = Create({ Type = "Trinket", ID = 168905, QueueForbidden = true }), 
    AquipotentNautilus                     = Create({ Type = "Trinket", ID = 169305, QueueForbidden = true }), 
    TidestormCodex                         = Create({ Type = "Trinket", ID = 165576, QueueForbidden = true }), 
    VialofStorms                           = Create({ Type = "Trinket", ID = 158224, QueueForbidden = true }), 
    -- Potions
    PotionofUnbridledFury                  = Create({ Type = "Potion", ID = 169299, QueueForbidden = true }), 
    BattlePotionOfAgility                  = Create({ Type = "Potion", ID = 163223, QueueForbidden = true }), 
    SuperiorBattlePotionOfAgility          = Create({ Type = "Potion", ID = 168489, QueueForbidden = true }), 
    PotionTest                             = Create({ Type = "Potion", ID = 142117, QueueForbidden = true }), 
    -- Trinkets
    GenericTrinket1                        = Create({ Type = "Trinket", ID = 114616, QueueForbidden = true }),
    GenericTrinket2                        = Create({ Type = "Trinket", ID = 114081, QueueForbidden = true }),
    TrinketTest                            = Create({ Type = "Trinket", ID = 122530, QueueForbidden = true }),
    TrinketTest2                           = Create({ Type = "Trinket", ID = 159611, QueueForbidden = true }), 
    AzsharasFontofPower                    = Create({ Type = "Trinket", ID = 169314, QueueForbidden = true }),
    PocketsizedComputationDevice           = Create({ Type = "Trinket", ID = 167555, QueueForbidden = true }),
    RotcrustedVoodooDoll                   = Create({ Type = "Trinket", ID = 159624, QueueForbidden = true }),
    ShiverVenomRelic                       = Create({ Type = "Trinket", ID = 168905, QueueForbidden = true }),
    AquipotentNautilus                     = Create({ Type = "Trinket", ID = 169305, QueueForbidden = true }),
    TidestormCodex                         = Create({ Type = "Trinket", ID = 165576, QueueForbidden = true }),
    VialofStorms                           = Create({ Type = "Trinket", ID = 158224, QueueForbidden = true }),
    GalecallersBoon                        = Create({ Type = "Trinket", ID = 159614, QueueForbidden = true }),
    InvocationOfYulon                      = Create({ Type = "Trinket", ID = 165568, QueueForbidden = true }),
    LustrousGoldenPlumage                  = Create({ Type = "Trinket", ID = 159617, QueueForbidden = true }),
    ComputationDevice                      = Create({ Type = "Trinket", ID = 167555, QueueForbidden = true }),
    VigorTrinket                           = Create({ Type = "Trinket", ID = 165572, QueueForbidden = true }),
    FontOfPower                            = Create({ Type = "Trinket", ID = 169314, QueueForbidden = true }),
    RazorCoral                             = Create({ Type = "Trinket", ID = 169311, QueueForbidden = true }),
    AshvanesRazorCoral                     = Create({ Type = "Trinket", ID = 169311, QueueForbidden = true }),
    -- Misc
    Channeling                             = Create({ Type = "Spell", ID = 209274, Hidden = true     }),	-- Show an icon during channeling
    TargetEnemy                            = Create({ Type = "Spell", ID = 44603, Hidden = true     }),	-- Change Target (Tab button)
    StopCast                               = Create({ Type = "Spell", ID = 61721, Hidden = true     }),		-- spell_magic_polymorphrabbit
    CyclotronicBlast                       = Create({ Type = "Spell", ID = 293491, Hidden = true}),
    ConcentratedFlameBurn                  = Create({ Type = "Spell", ID = 295368, Hidden = true}),
    RazorCoralDebuff                       = Create({ Type = "Spell", ID = 303568, Hidden = true     }),
    ConductiveInkDebuff                    = Create({ Type = "Spell", ID = 302565, Hidden = true     }),
};

-- To create essences use next code:
Action:CreateEssencesFor(ACTION_CONST_PALADIN_RETRIBUTION)  -- where PLAYERSPEC is Constance (example: ACTION_CONST_MONK_BM)
local A = setmetatable(Action[ACTION_CONST_PALADIN_RETRIBUTION], { __index = Action })


------------------------------------------
---------------- VARIABLES ---------------
------------------------------------------
local VarWingsPool = 0;
local VarDsCastable = 0;
local VarHow = 0;

A.Listener:Add("ROTATION_VARS", "PLAYER_REGEN_ENABLED", function()
  VarWingsPool = 0
  VarDsCastable = 0
  VarHow = 0
end)



local function num(val)
    if val then return 1 else return 0 end
end

local function bool(val)
    return val ~= 0
end

------------------------------------------
------- RETRIBUTION PRE APL SETUP --------
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

local function IsHolySchoolFree()
    return LoC:IsMissed("SILENCE") and LoC:Get("SCHOOL_INTERRUPT", "HOLY") == 0
end 

local function InRange(unit)
    -- @return boolean 
    return A.TemplarsVerdict:IsInRange(unit)
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

-- [1] CC AntiFake Rotation
local function AntiFakeStun(unit) 
    return 
    A.IsUnitEnemy(unit) and  
    Unit(unit):GetRange() <= 10 and 
    Unit(unit):IsControlAble("stun", 0) and 
    A.HammerofJusticeGreen:AbsentImun(unit, Temp.TotalAndPhysAndCCAndStun, true)          
end 
A[1] = function(icon)    
    if     A.HammerofJusticeGreen:IsReady(nil, nil, nil, true) and 
    (
        AntiFakeStun("mouseover") or 
        AntiFakeStun("target") or 
        (
            not A.IsUnitEnemy("mouseover") and 
            not A.IsUnitEnemy("target") and                     
            (
                (A.IsInPvP and EnemyTeam():PlayersInRange(1, 10)) or 
                (not A.IsInPvP and GetByRange(1, 10))
            )
        )
    )
    then 
        return A.HammerofJusticeGreen:Show(icon)         
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
            if not notKickAble and A.Rebuke:IsReady(unit, nil, nil, true) and A.Rebuke:AbsentImun(unit, Temp.TotalAndMag, true) then
                return A.Rebuke:Show(icon)                                                  
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
    if Unit(player):CombatTime() == 0 then 
        return 
    end 
    
    local unit
    if A.IsUnitEnemy("mouseover") then 
        unit = "mouseover"
    elseif A.IsUnitEnemy("target") then 
        unit = "target"
    end  
    
    -- DivineShield
    local DivineShield = A.GetToggle(2, "DivineShieldHP")
    if     DivineShield >= 0 and A.DivineShield:IsReady(player) and 
    (
        (     -- Auto 
            DivineShield >= 100 and 
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
            DivineShield < 100 and 
            Unit(player):HealthPercent() <= DivineShield
        )
    ) 
    then 
        -- Notification                    
        Action.SendNotification("[DEF] Divine Shield", A.DivineShield.ID)
        return A.DivineShield
    end
    
    -- Stoneform on self dispel (only PvE)
    if A.Stoneform:IsRacialReady(player, true) and not A.IsInPvP and A.AuraIsValid(player, "UseDispel", "Dispel") then 
        return A.Stoneform
    end 
end 
SelfDefensives = A.MakeFunctionCachedStatic(SelfDefensives)

-- Non GCD spell check
local function countInterruptGCD(unit)
    if not A.Rebuke:IsReadyByPassCastGCD(unit) or not A.Rebuke:AbsentImun(unit, Temp.TotalAndMagKick) then
        return true
    end
end

-- Interrupts spells
local function Interrupts(unit)
    if A.GetToggle(2, "TasteInterruptList") then
        useKick, useCC, useRacial, notInterruptable, castRemainsTime, castDoneTime = Action.InterruptIsValid(unit, "TasteBFAContent", true, countInterruptGCD(unit))
    else
        useKick, useCC, useRacial, notInterruptable, castRemainsTime, castDoneTime = Action.InterruptIsValid(unit, nil, nil, countInterruptGCD(unit))
    end   
    
    if castRemainsTime >= A.GetLatency() then
        if useKick and A.Rebuke:IsReady(unit) and A.Rebuke:AbsentImun(unit, Temp.TotalAndMagKick, true) then 
            -- Notification                    
            Action.SendNotification("Rebuke interrupting on Target ", A.Rebuke.ID)
            return A.Rebuke
        end 
        
        if useCC and A.HammerofJustice:IsReady(unit) and A.HammerofJustice:AbsentImun(unit, Temp.TotalAndCC, true) and Unit(unit):IsControlAble("stun", 0) then 
            -- Notification                    
            Action.SendNotification("HammerofJustice interrupting...", A.HammerofJustice.ID)
            return A.HammerofJustice              
        end    
        
        -- Asphyxiate
        if useCC and A.Asphyxiate:IsSpellLearned() and A.Asphyxiate:IsReady(unit) then 
            return A.Asphyxiate
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
    local DBM = Action.GetToggle(1, "DBM")
    local HeartOfAzeroth = Action.GetToggle(1, "HeartOfAzeroth")
    local Racial = Action.GetToggle(1, "Racial")
    local Potion = Action.GetToggle(1, "Potion")

    ------------------------------------------------------
    ---------------- ENEMY UNIT ROTATION -----------------
    ------------------------------------------------------
    local function EnemyRotation(unit)

        --Precombat
        local function Precombat(unit)
        
            -- flask
            -- food
            -- augmentation
            -- snapshot_stats
            -- potion
            if A.PotionofSpectralStrength:IsReady(unit) and Potion then
                return A.PotionofSpectralStrength:Show(icon)
            end
            
            -- use_item,name=azsharas_font_of_power
            if A.AzsharasFontofPower:IsReady(unit) then
                return A.AzsharasFontofPower:Show(icon)
            end
            
            -- arcane_torrent,if=!talent.wake_of_ashes.enabled
            if A.ArcaneTorrent:AutoRacial(unit) and Racial and A.BurstIsON(unit) and (not A.WakeofAshes:IsSpellLearned()) then
                return A.ArcaneTorrent:Show(icon)
            end
            
        end
        
        --Cooldowns
        local function Cooldowns(unit)
        
            -- potion,if=(cooldown.guardian_of_azeroth.remains>90|!essence.condensed_lifeforce.major)&(buff.bloodlust.react|buff.avenging_wrath.up&buff.avenging_wrath.remains>18|buff.crusade.up&buff.crusade.remains<25)
            if A.PotionofSpectralStrength:IsReady(unit) and Potion and ((A.GuardianofAzeroth:GetCooldown() > 90 or not Azerite:EssenceHasMajor(A.CondensedLifeforce.ID)) and (Unit("player"):HasHeroism() or Unit("player"):HasBuffs(A.AvengingWrathBuff.ID, true) and Unit("player"):HasBuffs(A.AvengingWrathBuff.ID, true) > 18 or Unit("player"):HasBuffs(A.CrusadeBuff.ID, true) and Unit("player"):HasBuffs(A.CrusadeBuff.ID, true) < 25)) then
                return A.PotionofSpectralStrength:Show(icon)
            end
            
            -- lights_judgment,if=spell_targets.lights_judgment>=2|(!raid_event.adds.exists|raid_event.adds.in>75)
            if A.LightsJudgment:IsReady(unit) and A.BurstIsON(unit) and (MultiUnits:GetByRangeInCombat(5, 5, 10) >= 2 or (not (MultiUnits:GetByRangeInCombat(40, 5, 10) > 1) or IncomingAddsIn > 75)) then
                return A.LightsJudgment:Show(icon)
            end
            
            -- fireblood,if=buff.avenging_wrath.up|buff.crusade.up&buff.crusade.stack=10
            if A.Fireblood:AutoRacial(unit) and Racial and A.BurstIsON(unit) and (Unit("player"):HasBuffs(A.AvengingWrathBuff.ID, true) or Unit("player"):HasBuffs(A.CrusadeBuff.ID, true) and Unit("player"):HasBuffsStacks(A.CrusadeBuff.ID, true) == 10) then
                return A.Fireblood:Show(icon)
            end
            
            -- shield_of_vengeance,if=buff.seething_rage.down&buff.memory_of_lucid_dreams.down
            if A.ShieldofVengeance:IsReady(unit) and (Unit("player"):HasBuffsDown(A.SeethingRageBuff.ID, true) and Unit("player"):HasBuffsDown(A.MemoryofLucidDreamsBuff.ID, true)) then
                return A.ShieldofVengeance:Show(icon)
            end
            
            -- use_item,name=ramping_amplitude_gigavolt_engine,if=(buff.avenging_wrath.up|buff.crusade.up)
            if A.RampingAmplitudeGigavoltEngine:IsReady(unit) and ((Unit("player"):HasBuffs(A.AvengingWrathBuff.ID, true) or Unit("player"):HasBuffs(A.CrusadeBuff.ID, true))) then
                return A.RampingAmplitudeGigavoltEngine:Show(icon)
            end
            
            -- the_unbound_force,if=time<=2|buff.reckless_force.up
            if A.TheUnboundForce:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and (Unit("player"):CombatTime() <= 2 or Unit("player"):HasBuffs(A.RecklessForceBuff.ID, true)) then
                return A.TheUnboundForce:Show(icon)
            end
            
            -- blood_of_the_enemy,if=buff.avenging_wrath.up|buff.crusade.up&buff.crusade.stack=10
            if A.BloodoftheEnemy:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and (Unit("player"):HasBuffs(A.AvengingWrathBuff.ID, true) or Unit("player"):HasBuffs(A.CrusadeBuff.ID, true) and Unit("player"):HasBuffsStacks(A.CrusadeBuff.ID, true) == 10) then
                return A.BloodoftheEnemy:Show(icon)
            end
            
            -- guardian_of_azeroth,if=!talent.crusade.enabled&(cooldown.avenging_wrath.remains<5&holy_power>=3&(buff.inquisition.up|!talent.inquisition.enabled)|cooldown.avenging_wrath.remains>=45)|(talent.crusade.enabled&cooldown.crusade.remains<gcd&holy_power>=4|holy_power>=3&time<10&talent.wake_of_ashes.enabled|cooldown.crusade.remains>=45)
            if A.GuardianofAzeroth:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and (not A.Crusade:IsSpellLearned() and (A.AvengingWrath:GetCooldown() < 5 and Player:HolyPower() >= 3 and (Unit("player"):HasBuffs(A.InquisitionBuff.ID, true) or not A.Inquisition:IsSpellLearned()) or A.AvengingWrath:GetCooldown() >= 45) or (A.Crusade:IsSpellLearned() and A.Crusade:GetCooldown() < GetGCD() and Player:HolyPower() >= 4 or Player:HolyPower() >= 3 and Unit("player"):CombatTime() < 10 and A.WakeofAshes:IsSpellLearned() or A.Crusade:GetCooldown() >= 45)) then
                return A.GuardianofAzeroth:Show(icon)
            end
            
            -- worldvein_resonance,if=cooldown.avenging_wrath.remains<gcd&holy_power>=3|talent.crusade.enabled&cooldown.crusade.remains<gcd&holy_power>=4|cooldown.avenging_wrath.remains>=45|cooldown.crusade.remains>=45
            if A.WorldveinResonance:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and (A.AvengingWrath:GetCooldown() < GetGCD() and Player:HolyPower() >= 3 or A.Crusade:IsSpellLearned() and A.Crusade:GetCooldown() < GetGCD() and Player:HolyPower() >= 4 or A.AvengingWrath:GetCooldown() >= 45 or A.Crusade:GetCooldown() >= 45) then
                return A.WorldveinResonance:Show(icon)
            end
            
            -- focused_azerite_beam,if=(!raid_event.adds.exists|raid_event.adds.in>30|spell_targets.divine_storm>=2)&!(buff.avenging_wrath.up|buff.crusade.up)&(cooldown.blade_of_justice.remains>gcd*3&cooldown.judgment.remains>gcd*3)
            if A.FocusedAzeriteBeam:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and ((not (MultiUnits:GetByRangeInCombat(40, 5, 10) > 1) or IncomingAddsIn > 30 or MultiUnits:GetByRangeInCombat(8, 5, 10) >= 2) and not (Unit("player"):HasBuffs(A.AvengingWrathBuff.ID, true) or Unit("player"):HasBuffs(A.CrusadeBuff.ID, true)) and (A.BladeofJustice:GetCooldown() > GetGCD() * 3 and A.Judgment:GetCooldown() > GetGCD() * 3)) then
                return A.FocusedAzeriteBeam:Show(icon)
            end
            
            -- memory_of_lucid_dreams,if=(buff.avenging_wrath.up|buff.crusade.up&buff.crusade.stack=10)&holy_power<=3
            if A.MemoryofLucidDreams:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and ((Unit("player"):HasBuffs(A.AvengingWrathBuff.ID, true) or Unit("player"):HasBuffs(A.CrusadeBuff.ID, true) and Unit("player"):HasBuffsStacks(A.CrusadeBuff.ID, true) == 10) and Player:HolyPower() <= 3) then
                return A.MemoryofLucidDreams:Show(icon)
            end
            
            -- purifying_blast,if=(!raid_event.adds.exists|raid_event.adds.in>30|spell_targets.divine_storm>=2)
            if A.PurifyingBlast:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and ((not (MultiUnits:GetByRangeInCombat(40, 5, 10) > 1) or IncomingAddsIn > 30 or MultiUnits:GetByRangeInCombat(8, 5, 10) >= 2)) then
                return A.PurifyingBlast:Show(icon)
            end
            
            -- use_item,effect_name=cyclotronic_blast,if=!(buff.avenging_wrath.up|buff.crusade.up)&(cooldown.blade_of_justice.remains>gcd*3&cooldown.judgment.remains>gcd*3)
            if A.CyclotronicBlast:IsReady(unit) and (not (Unit("player"):HasBuffs(A.AvengingWrathBuff.ID, true) or Unit("player"):HasBuffs(A.CrusadeBuff.ID, true)) and (A.BladeofJustice:GetCooldown() > GetGCD() * 3 and A.Judgment:GetCooldown() > GetGCD() * 3)) then
                return A.CyclotronicBlast:Show(icon)
            end
            
            -- avenging_wrath,if=(!talent.inquisition.enabled|buff.inquisition.up)&holy_power>=3
            if A.AvengingWrath:IsReady(unit) and A.BurstIsON(unit) and ((not A.Inquisition:IsSpellLearned() or Unit("player"):HasBuffs(A.InquisitionBuff.ID, true)) and Player:HolyPower() >= 3) then
                return A.AvengingWrath:Show(icon)
            end
            
            -- crusade,if=holy_power>=4|holy_power>=3&time<10&talent.wake_of_ashes.enabled
            if A.Crusade:IsReady(unit) and A.BurstIsON(unit) and (Player:HolyPower() >= 4 or Player:HolyPower() >= 3 and Unit("player"):CombatTime() < 10 and A.WakeofAshes:IsSpellLearned()) then
                return A.Crusade:Show(icon)
            end
            
        end
        
        --Finishers
        local function Finishers(unit)
        
            -- variable,name=wings_pool,value=!equipped.169314&(!talent.crusade.enabled&cooldown.avenging_wrath.remains>gcd*3|cooldown.crusade.remains>gcd*3)|equipped.169314&(!talent.crusade.enabled&cooldown.avenging_wrath.remains>gcd*6|cooldown.crusade.remains>gcd*6)
            VarWingsPool = num(not A.Item169314:IsExists() and (not A.Crusade:IsSpellLearned() and A.AvengingWrath:GetCooldown() > GetGCD() * 3 or A.Crusade:GetCooldown() > GetGCD() * 3) or A.Item169314:IsExists() and (not A.Crusade:IsSpellLearned() and A.AvengingWrath:GetCooldown() > GetGCD() * 6 or A.Crusade:GetCooldown() > GetGCD() * 6))
            
            -- variable,name=ds_castable,value=spell_targets.divine_storm>=2&!talent.righteous_verdict.enabled|spell_targets.divine_storm>=3&talent.righteous_verdict.enabled|buff.empyrean_power.up&debuff.judgment.down&buff.divine_purpose.down&buff.avenging_wrath_autocrit.down
            VarDsCastable = num(MultiUnits:GetByRangeInCombat(8, 5, 10) >= 2 and not A.RighteousVerdict:IsSpellLearned() or MultiUnits:GetByRangeInCombat(8, 5, 10) >= 3 and A.RighteousVerdict:IsSpellLearned() or Unit("player"):HasBuffs(A.EmpyreanPowerBuff.ID, true) and Unit(unit):HasDeBuffsDown(A.JudgmentDebuff.ID, true) and Unit("player"):HasBuffsDown(A.DivinePurposeBuff.ID, true) and Unit("player"):HasBuffsDown(A.AvengingWrathAutocritBuff.ID, true))
            
            -- inquisition,if=buff.avenging_wrath.down&(buff.inquisition.down|buff.inquisition.remains<8&holy_power>=3|talent.execution_sentence.enabled&cooldown.execution_sentence.remains<10&buff.inquisition.remains<15|cooldown.avenging_wrath.remains<15&buff.inquisition.remains<20&holy_power>=3)
            if A.Inquisition:IsReady(unit) and (Unit("player"):HasBuffsDown(A.AvengingWrathBuff.ID, true) and (Unit("player"):HasBuffsDown(A.InquisitionBuff.ID, true) or Unit("player"):HasBuffs(A.InquisitionBuff.ID, true) < 8 and Player:HolyPower() >= 3 or A.ExecutionSentence:IsSpellLearned() and A.ExecutionSentence:GetCooldown() < 10 and Unit("player"):HasBuffs(A.InquisitionBuff.ID, true) < 15 or A.AvengingWrath:GetCooldown() < 15 and Unit("player"):HasBuffs(A.InquisitionBuff.ID, true) < 20 and Player:HolyPower() >= 3)) then
                return A.Inquisition:Show(icon)
            end
            
            -- execution_sentence,if=spell_targets.divine_storm<=2&(!talent.crusade.enabled&cooldown.avenging_wrath.remains>10|talent.crusade.enabled&buff.crusade.down&cooldown.crusade.remains>10|buff.crusade.stack>=7)
            if A.ExecutionSentence:IsReady(unit) and (MultiUnits:GetByRangeInCombat(8, 5, 10) <= 2 and (not A.Crusade:IsSpellLearned() and A.AvengingWrath:GetCooldown() > 10 or A.Crusade:IsSpellLearned() and Unit("player"):HasBuffsDown(A.CrusadeBuff.ID, true) and A.Crusade:GetCooldown() > 10 or Unit("player"):HasBuffsStacks(A.CrusadeBuff.ID, true) >= 7)) then
                return A.ExecutionSentence:Show(icon)
            end
            
            -- divine_storm,if=variable.ds_castable&variable.wings_pool&((!talent.execution_sentence.enabled|(spell_targets.divine_storm>=2|cooldown.execution_sentence.remains>gcd*2))|(cooldown.avenging_wrath.remains>gcd*3&cooldown.avenging_wrath.remains<10|cooldown.crusade.remains>gcd*3&cooldown.crusade.remains<10|buff.crusade.up&buff.crusade.stack<10))
            if A.DivineStorm:IsReady(unit) and (VarDsCastable and VarWingsPool and ((not A.ExecutionSentence:IsSpellLearned() or (MultiUnits:GetByRangeInCombat(8, 5, 10) >= 2 or A.ExecutionSentence:GetCooldown() > GetGCD() * 2)) or (A.AvengingWrath:GetCooldown() > GetGCD() * 3 and A.AvengingWrath:GetCooldown() < 10 or A.Crusade:GetCooldown() > GetGCD() * 3 and A.Crusade:GetCooldown() < 10 or Unit("player"):HasBuffs(A.CrusadeBuff.ID, true) and Unit("player"):HasBuffsStacks(A.CrusadeBuff.ID, true) < 10))) then
                return A.DivineStorm:Show(icon)
            end
            
            -- templars_verdict,if=variable.wings_pool&(!talent.execution_sentence.enabled|cooldown.execution_sentence.remains>gcd*2|cooldown.avenging_wrath.remains>gcd*3&cooldown.avenging_wrath.remains<10|cooldown.crusade.remains>gcd*3&cooldown.crusade.remains<10|buff.crusade.up&buff.crusade.stack<10)
            if A.TemplarsVerdict:IsReady(unit) and (VarWingsPool and (not A.ExecutionSentence:IsSpellLearned() or A.ExecutionSentence:GetCooldown() > GetGCD() * 2 or A.AvengingWrath:GetCooldown() > GetGCD() * 3 and A.AvengingWrath:GetCooldown() < 10 or A.Crusade:GetCooldown() > GetGCD() * 3 and A.Crusade:GetCooldown() < 10 or Unit("player"):HasBuffs(A.CrusadeBuff.ID, true) and Unit("player"):HasBuffsStacks(A.CrusadeBuff.ID, true) < 10)) then
                return A.TemplarsVerdict:Show(icon)
            end
            
        end
        
        --Generators
        local function Generators(unit)
        
            -- variable,name=HoW,value=(!talent.hammer_of_wrath.enabled|target.health.pct>=20&!(buff.avenging_wrath.up|buff.crusade.up))
            VarHow = num((not A.HammerofWrath:IsSpellLearned() or Unit(unit):HealthPercent() >= 20 and not (Unit("player"):HasBuffs(A.AvengingWrathBuff.ID, true) or Unit("player"):HasBuffs(A.CrusadeBuff.ID, true))))
            
            -- call_action_list,name=finishers,if=holy_power>=5|buff.memory_of_lucid_dreams.up|buff.seething_rage.up|talent.inquisition.enabled&buff.inquisition.down&holy_power>=3
            if (Player:HolyPower() >= 5 or Unit("player"):HasBuffs(A.MemoryofLucidDreamsBuff.ID, true) or Unit("player"):HasBuffs(A.SeethingRageBuff.ID, true) or A.Inquisition:IsSpellLearned() and Unit("player"):HasBuffsDown(A.InquisitionBuff.ID, true) and Player:HolyPower() >= 3) then
                if Finishers(unit) then
                    return true
                end
            end
            
            -- wake_of_ashes,if=(!raid_event.adds.exists|raid_event.adds.in>15|spell_targets.wake_of_ashes>=2)&(holy_power<=0|holy_power=1&cooldown.blade_of_justice.remains>gcd)&(cooldown.avenging_wrath.remains>10|talent.crusade.enabled&cooldown.crusade.remains>10)
            if A.WakeofAshes:IsReady(unit) and ((not (MultiUnits:GetByRangeInCombat(40, 5, 10) > 1) or IncomingAddsIn > 15 or MultiUnits:GetByRangeInCombat(5, 5, 10) >= 2) and (Player:HolyPower() <= 0 or Player:HolyPower() == 1 and A.BladeofJustice:GetCooldown() > GetGCD()) and (A.AvengingWrath:GetCooldown() > 10 or A.Crusade:IsSpellLearned() and A.Crusade:GetCooldown() > 10)) then
                return A.WakeofAshes:Show(icon)
            end
            
            -- blade_of_justice,if=holy_power<=2|(holy_power=3&(cooldown.hammer_of_wrath.remains>gcd*2|variable.HoW))
            if A.BladeofJustice:IsReady(unit) and (Player:HolyPower() <= 2 or (Player:HolyPower() == 3 and (A.HammerofWrath:GetCooldown() > GetGCD() * 2 or VarHow))) then
                return A.BladeofJustice:Show(icon)
            end
            
            -- judgment,if=holy_power<=2|(holy_power<=4&(cooldown.blade_of_justice.remains>gcd*2|variable.HoW))
            if A.Judgment:IsReady(unit) and (Player:HolyPower() <= 2 or (Player:HolyPower() <= 4 and (A.BladeofJustice:GetCooldown() > GetGCD() * 2 or VarHow))) then
                return A.Judgment:Show(icon)
            end
            
            -- hammer_of_wrath,if=holy_power<=4
            if A.HammerofWrath:IsReady(unit) and (Player:HolyPower() <= 4) then
                return A.HammerofWrath:Show(icon)
            end
            
            -- consecration,if=holy_power<=2|holy_power<=3&cooldown.blade_of_justice.remains>gcd*2|holy_power=4&cooldown.blade_of_justice.remains>gcd*2&cooldown.judgment.remains>gcd*2
            if A.Consecration:IsReady(unit) and (Player:HolyPower() <= 2 or Player:HolyPower() <= 3 and A.BladeofJustice:GetCooldown() > GetGCD() * 2 or Player:HolyPower() == 4 and A.BladeofJustice:GetCooldown() > GetGCD() * 2 and A.Judgment:GetCooldown() > GetGCD() * 2) then
                return A.Consecration:Show(icon)
            end
            
            -- call_action_list,name=finishers,if=talent.hammer_of_wrath.enabled&target.health.pct<=20|buff.avenging_wrath.up|buff.crusade.up
            if (A.HammerofWrath:IsSpellLearned() and Unit(unit):HealthPercent() <= 20 or Unit("player"):HasBuffs(A.AvengingWrathBuff.ID, true) or Unit("player"):HasBuffs(A.CrusadeBuff.ID, true)) then
                if Finishers(unit) then
                    return true
                end
            end
            
            -- crusader_strike,if=cooldown.crusader_strike.charges_fractional>=1.75&(holy_power<=2|holy_power<=3&cooldown.blade_of_justice.remains>gcd*2|holy_power=4&cooldown.blade_of_justice.remains>gcd*2&cooldown.judgment.remains>gcd*2&cooldown.consecration.remains>gcd*2)
            if A.CrusaderStrike:IsReady(unit) and (A.CrusaderStrike:GetSpellChargesFrac() >= 1.75 and (Player:HolyPower() <= 2 or Player:HolyPower() <= 3 and A.BladeofJustice:GetCooldown() > GetGCD() * 2 or Player:HolyPower() == 4 and A.BladeofJustice:GetCooldown() > GetGCD() * 2 and A.Judgment:GetCooldown() > GetGCD() * 2 and A.Consecration:GetCooldown() > GetGCD() * 2)) then
                return A.CrusaderStrike:Show(icon)
            end
            
            -- call_action_list,name=finishers
            if Finishers(unit) then
                return true
            end
            
            -- concentrated_flame
            if A.ConcentratedFlame:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth then
                return A.ConcentratedFlame:Show(icon)
            end
            
            -- reaping_flames
            if A.ReapingFlames:IsReady(unit) then
                return A.ReapingFlames:Show(icon)
            end
            
            -- crusader_strike,if=holy_power<=4
            if A.CrusaderStrike:IsReady(unit) and (Player:HolyPower() <= 4) then
                return A.CrusaderStrike:Show(icon)
            end
            
            -- arcane_torrent,if=holy_power<=4
            if A.ArcaneTorrent:AutoRacial(unit) and Racial and A.BurstIsON(unit) and (Player:HolyPower() <= 4) then
                return A.ArcaneTorrent:Show(icon)
            end
            
        end
        
        
        -- call precombat
        if Precombat(unit) and not inCombat and Unit(unit):IsExists() and unit ~= "mouseover" then 
            return true
        end

        -- In Combat
        if inCombat and Unit(unit):IsExists() then

                    -- auto_attack
            -- rebuke
            if A.Rebuke:IsReady(unit) and Action.GetToggle.InterruptEnabled then
                return A.Rebuke:Show(icon)
            end
            
            -- call_action_list,name=cooldowns
            if A.BurstIsON(unit) then
                if Cooldowns(unit) then
                    return true
                end
            end
            
            -- call_action_list,name=generators
            if Generators(unit) then
                return true
            end
            
        end
    end

    -- End on EnemyRotation()

    -- Defensive
    --local SelfDefensive = SelfDefensives()
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
end
-- Finished

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
        if (unit == "arena1" or unit == "arena2" or unit == "arena3") then 
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

