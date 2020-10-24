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

Action[ACTION_CONST_SHAMAN_ELEMENTAL] = {
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
    TotemMastery                           = Create({ Type = "Spell", ID = 210643 }),
    StormkeeperBuff                        = Create({ Type = "Spell", ID = 191634 }),
    Stormkeeper                            = Create({ Type = "Spell", ID = 191634 }),
    ElementalBlast                         = Create({ Type = "Spell", ID = 117014 }),
    LavaBurst                              = Create({ Type = "Spell", ID = 51505 }),
    FlameShock                             = Create({ Type = "Spell", ID = 188389 }),
    FlameShockDebuff                       = Create({ Type = "Spell", ID = 188389 }),
    StormElemental                         = Create({ Type = "Spell", ID = 192249 }),
    FireElemental                          = Create({ Type = "Spell", ID = 198067 }),
    WindGustBuff                           = Create({ Type = "Spell", ID = 263806 }),
    Ascendance                             = Create({ Type = "Spell", ID = 114050 }),
    Icefury                                = Create({ Type = "Spell", ID = 210714 }),
    IcefuryBuff                            = Create({ Type = "Spell", ID = 210714 }),
    LiquidMagmaTotem                       = Create({ Type = "Spell", ID = 192222 }),
    Earthquake                             = Create({ Type = "Spell", ID = 61882 }),
    MasteroftheElements                    = Create({ Type = "Spell", ID = 16166 }),
    MasteroftheElementsBuff                = Create({ Type = "Spell", ID = 260734 }),
    PrimalElementalist                     = Create({ Type = "Spell", ID =  }),
    ChainLightning                         = Create({ Type = "Spell", ID = 188443 }),
    LavaSurgeBuff                          = Create({ Type = "Spell", ID = 77762 }),
    AscendanceBuff                         = Create({ Type = "Spell", ID = 114050 }),
    FrostShock                             = Create({ Type = "Spell", ID = 196840 }),
    LavaBeam                               = Create({ Type = "Spell", ID = 114074 }),
    IgneousPotential                       = Create({ Type = "Spell", ID = 279829 }),
    SurgeofPowerBuff                       = Create({ Type = "Spell", ID = 285514 }),
    NaturalHarmony                         = Create({ Type = "Spell", ID = 278697 }),
    SurgeofPower                           = Create({ Type = "Spell", ID = 262303 }),
    LightningBolt                          = Create({ Type = "Spell", ID = 188196 }),
    LavaShock                              = Create({ Type = "Spell", ID = 273448 }),
    LavaShockBuff                          = Create({ Type = "Spell", ID = 273453 }),
    EarthShock                             = Create({ Type = "Spell", ID = 8042 }),
    CalltheThunder                         = Create({ Type = "Spell", ID = 260897 }),
    EchooftheElementals                    = Create({ Type = "Spell", ID = 275381 }),
    EchooftheElements                      = Create({ Type = "Spell", ID = 108283 }),
    ReapingFlames                          = Create({ Type = "Spell", ID =  }),
    ResonanceTotemBuff                     = Create({ Type = "Spell", ID = 202192 }),
    TectonicThunder                        = Create({ Type = "Spell", ID = 286949 }),
    LightningLasso                         = Create({ Type = "Spell", ID =  }),
    TectonicThunderBuff                    = Create({ Type = "Spell", ID = 286949 }),
    WindShear                              = Create({ Type = "Spell", ID = 57994 }),
    UnlimitedPower                         = Create({ Type = "Spell", ID =  }),
    BloodFury                              = Create({ Type = "Spell", ID = 20572 }),
    Berserking                             = Create({ Type = "Spell", ID = 26297 }),
    Fireblood                              = Create({ Type = "Spell", ID = 265221 }),
    AncestralCall                          = Create({ Type = "Spell", ID = 274738 }),
    BagofTricks                            = Create({ Type = "Spell", ID =  })
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

-- To create covenant use next code:
A:CreateCovenantsFor(ACTION_CONST_SHAMAN_ELEMENTAL)  -- where PLAYERSPEC is Constance (example: ACTION_CONST_MONK_BM)
local A = setmetatable(Action[ACTION_CONST_SHAMAN_ELEMENTAL], { __index = Action })





local function num(val)
    if val then return 1 else return 0 end
end

local function bool(val)
    return val ~= 0
end

------------------------------------------
-------- ELEMENTAL PRE APL SETUP ---------
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

-- API - Tracker
-- Initialize Tracker 
Pet:AddTrackers(ACTION_CONST_SHAMAN_ENCHANCEMENT, { -- this template table is the same with what has this library already built-in, just for example
    [77942] = {
        name = "Primal Storm Elemental",
        duration = 30,
    },
})

-- Function to check for Infernal duration
local function PrimalStormElementalTime()
    return Pet:GetRemainDuration(77942) or 0
end 

local function StormElementalIsActive()
    if PrimalStormElementalTime() > 0 then
        return true
    else
        return false
    end
end

local function ResonanceTotemTime()
    for index = 1, 4 do
        local _, totemName, startTime, duration = GetTotemInfo(index)
        if totemName == A.TotemMastery:Info() then
            return (floor(startTime + duration - TMW.time + 0.5)) or 0
        end
    end
    return 0
end

local function FutureMaelstromPower()
    local castName, castStartTime, castEndTime, notInterruptable, spellID, isChannel = Unit("player"):IsCasting()
    local castLeft, _, _, _, notKickAble = Unit("player"):IsCastingRemains()
    local MaelstromPower = Player:Maelstrom()
    local overloadChance = Player:MasteryPct() / 100
    local factor = 1 + 0.75 * overloadChance
    local resonance = 0
    
    if Unit("player"):CombatTime() > 0 then
        if A.TotemMastery:IsReady("player") then
            resonance = castLeft
        end
        if not castLeft then
            return MaelstromPower
        else
            if spellID == A.LightningBolt.ID then
                return MaelstromPower + 8 + resonance
            elseif spellID == A.LavaBurst.ID then
                return MaelstromPower + 10 + resonance
            elseif spellID == A.ChainLightning.ID then
                local enemiesHit = min(MultiUnits:GetActiveEnemies(), 3)
                return MaelstromPower + 4 * enemiesHit * factor + resonance
            elseif spellID == A.Icefury.ID then
                return MaelstromPower + 25 * factor + resonance
            else
                return MaelstromPower
            end
        end
    end
end

local function HandleAncestralGuidance()
    local choice = Action.GetToggle(2, "AncestralGuidanceSelection")
    
    if choice == "In Raid" then
        if IsInRaid() then
            return true
        else
            return false
        end
    elseif choice == "In Dungeon" then 
        if IsInGroup() then
            return true
        else
            return false
        end
    elseif choice == "In PvP" then     
        if A.IsInPvP then 
            return true
        else
            return false
        end        
    elseif choice == "Everywhere" then 
        return true
    else
        return false
    end
    --print(choice)
end

-- Multidot Handler UI --
local function HandleMultidots()
    local choice = Action.GetToggle(2, "AutoDotSelection")
    
    if choice == "In Raid" then
        if IsInRaid() then
            return true
        else
            return false
        end
    elseif choice == "In Dungeon" then 
        if IsInGroup() then
            return true
        else
            return false
        end
    elseif choice == "In PvP" then     
        if A.IsInPvP then 
            return true
        else
            return false
        end        
    elseif choice == "Everywhere" then 
        return true
    else
        return false
    end
    --print(choice)
end

-- Stormkeeper Handler UI --
local function HandleStormkeeper()
    local choice = A.GetToggle(2, "StormkeeperMode")
    --print(choice) 
    local unit = "target"
    -- CDs ON
    if choice[1] then 
        -- also checks AoE
        if choice[2] then
            return (A.BurstIsON(unit) and MultiUnits:GetActiveEnemies() > 2 and A.GetToggle(2, "AoE")) or false
        else
            return (A.BurstIsON(unit)) or false
        end
        -- AoE Only
    elseif choice[2] then
        -- also checks CDs
        if choice[1] then
            return (A.BurstIsON(unit) and MultiUnits:GetActiveEnemies() > 2 and A.GetToggle(2, "AoE")) or false
        else
            return (MultiUnits:GetActiveEnemies() > 2 and A.GetToggle(2, "AoE")) or false
        end
        -- Everytime
    elseif choice[3] then
        return A.Stormkeeper:IsReady(unit) or false
    else
        return false
    end
    
end

-- FlameShockTTD
local function HandleFlameShockTTD()
    local FlameShock = A.GetToggle(2, "FlameShockTTD")
    if     FlameShock >= 0 and 
    (
        (     -- Auto 
            FlameShock >= 100 and 
            (
                -- TTD > 15
                Unit("target"):TimeToDie() > 15
            ) 
        ) or 
        (    -- Custom
            FlameShock < 100 and 
            Unit("target"):HealthPercent() > FlameShock
        )
    ) 
    then 
        return true
    end
end

local function ExpectedCombatLength()
    local BossTTD = 0
    if not A.IsInPvP then 
        for i = 1, MAX_BOSS_FRAMES do 
            if Unit("boss" .. i):IsExists() and not Unit("boss" .. i):IsDead() then 
                BossTTD = Unit("boss" .. i):TimeToDie()
            end 
        end 
    end 
    return BossTTD
end 
ExpectedCombatLength = A.MakeFunctionCachedStatic(ExpectedCombatLength)

local function SelfDefensives()
    if Unit("player"):CombatTime() == 0 then 
        return 
    end 
    
    local unit
    if A.IsUnitEnemy("mouseover") then 
        unit = "mouseover"
    elseif A.IsUnitEnemy("target") then 
        unit = "target"
    end      
    
    -- EarthShieldHP
    local EarthShield = A.GetToggle(2, "EarthShieldHP")
    if     EarthShield >= 0 and A.EarthShield:IsReady("player") and  
    (
        (     -- Auto 
            EarthShield >= 100 and 
            (
                Unit("player"):HasBuffsStacks(A.EarthShield.ID, true) <= 3 
                or A.IsInPvP and Unit("player"):HasBuffsStacks(A.EarthShield.ID, true) <= 2
            ) 
        ) or 
        (    -- Custom
            EarthShield < 100 and 
            Unit("player"):HasBuffs(A.EarthShield.ID, true) <= 5 and 
            Unit("player"):HealthPercent() <= EarthShield
        )
    ) 
    then 
        return A.EarthShield
    end
    
    -- HealingSurgeHP
    local HealingSurge = A.GetToggle(2, "HealingSurgeHP")
    if     HealingSurge >= 0 and A.HealingSurge:IsReady("player") and 
    (
        (     -- Auto 
            HealingSurge >= 100 and 
            (
                -- HP lose per sec >= 40
                Unit("player"):GetDMG() * 100 / Unit("player"):HealthMax() >= 40 or 
                Unit("player"):GetRealTimeDMG() >= Unit("player"):HealthMax() * 0.40 or 
                -- TTD 
                Unit("player"):TimeToDieX(25) < 5 or 
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
            HealingSurge < 100 and 
            Unit("player"):HealthPercent() <= HealingSurge
        )
    ) 
    then 
        return A.HealingSurge
    end
    
    -- Abyssal Healing Potion
    local AbyssalHealingPotion = A.GetToggle(2, "AbyssalHealingPotionHP")
    if     AbyssalHealingPotion >= 0 and A.AbyssalHealingPotion:IsReady("player") and 
    (
        (     -- Auto 
            AbyssalHealingPotion >= 100 and 
            (
                -- HP lose per sec >= 25
                Unit("player"):GetDMG() * 100 / Unit("player"):HealthMax() >= 25 or 
                Unit("player"):GetRealTimeDMG() >= Unit("player"):HealthMax() * 0.25 or 
                -- TTD 
                Unit("player"):TimeToDieX(25) < 5 or 
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
            AbyssalHealingPotion < 100 and 
            Unit("player"):HealthPercent() <= AbyssalHealingPotion
        )
    ) 
    then 
        return A.AbyssalHealingPotion
    end  
    
    -- AstralShift
    local AstralShift = A.GetToggle(2, "AstralShiftHP")
    if     AstralShift >= 0 and A.AstralShift:IsReady("player") and 
    (
        (     -- Auto 
            AstralShift >= 100 and 
            (
                -- HP lose per sec >= 20
                Unit("player"):GetDMG() * 100 / Unit("player"):HealthMax() >= 20 or 
                Unit("player"):GetRealTimeDMG() >= Unit("player"):HealthMax() * 0.20 or 
                -- TTD 
                Unit("player"):TimeToDieX(25) < 5 or 
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
            AstralShift < 100 and 
            Unit("player"):HealthPercent() <= AstralShift
        )
    ) 
    then 
        return A.AstralShift
    end     
    -- Stoneform on self dispel (only PvE)
    if A.Stoneform:IsRacialReady("player", true) and not A.IsInPvP and A.AuraIsValid("player", "UseDispel", "Dispel") then 
        return A.Stoneform
    end 
end 
SelfDefensives = A.MakeFunctionCachedStatic(SelfDefensives)

-- Non GCD spell check
local function countInterruptGCD(unit)
    if not A.WindShear:IsReadyByPassCastGCD(unit) or not A.WindShear:AbsentImun(unit, Temp.TotalAndMagKick) then
	    return true
	end
end

-- Interrupts spells
local function Interrupts(unit)
    if A.GetToggle(2, "TasteInterruptList") and (IsInRaid() or A.InstanceInfo.KeyStone > 1) then
	    useKick, useCC, useRacial, notInterruptable, castRemainsTime, castDoneTime = Action.InterruptIsValid(unit, "TasteBFAContent", true, countInterruptGCD(unit))
	else
        useKick, useCC, useRacial, notInterruptable, castRemainsTime, castDoneTime = Action.InterruptIsValid(unit, nil, nil, countInterruptGCD(unit))
    end
        
	if castRemainsTime >= A.GetLatency() then
	    -- WindShear
        if useKick and A.WindShear:IsReady(unit) then 
	        -- Notification					
            Action.SendNotification("Wind Shear interrupting on " .. unit, A.WindShear.ID)
            return A.WindShear
        end 
	
        -- CapacitorTotem
        if useCC and Action.GetToggle(2, "UseCapacitorTotem") and A.WindShear:GetCooldown() > 0 and A.CapacitorTotem:IsReady(player) then 
			-- Notification					
            Action.SendNotification("Capacitor Totem interrupting", A.CapacitorTotem.ID)
            return A.CapacitorTotem
        end  
    
        -- Hex	
        if useCC and A.Hex:IsReady(unit) and A.Hex:AbsentImun(unit, Temp.TotalAndCC, true) and Unit(unit):IsControlAble("incapacitate", 0) then 
	        -- Notification					
            Action.SendNotification("Hex interrupting", A.Hex.ID)
            return A.Hex              
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

local function EvaluateCycleFlameShock39(unit)
    return Unit(unit):HasDeBuffsRefreshable(A.FlameShockDebuff.ID, true) and (MultiUnits:GetByRangeInCombat(40, 5, 10) < (5 - num(not A.TotemMastery:IsSpellLearned())) or not A.StormElemental:IsSpellLearned() and (A.FireElemental:GetCooldown() > (A.StormElemental:BaseDuration() - 30 + 14 * Player:SpellHaste()) or A.FireElemental:GetCooldown() < (24 - 14 * Player:SpellHaste()))) and (not A.StormElemental:IsSpellLearned() or A.StormElemental:GetCooldown() < (A.StormElemental:BaseDuration() - 30) or MultiUnits:GetByRangeInCombat(40, 5, 10) == 3 and Unit("player"):HasBuffsStacks(A.WindGustBuff.ID, true) < 14)
end

local function EvaluateCycleFlameShock156(unit)
    return Unit(unit):HasDeBuffsRefreshable(A.FlameShockDebuff.ID, true)
end

local function EvaluateCycleFlameShock171(unit)
    return (not Unit(unit):HasDeBuffs(A.FlameShockDebuff.ID, true) or Unit(unit):HasDeBuffs(A.FlameShockDebuff.ID, true) <= GetGCD() or A.Ascendance:IsSpellLearned() and Unit(unit):HasDeBuffs(A.FlameShockDebuff.ID, true) < (A.Ascendance:GetCooldown() + A.AscendanceBuff.ID, true:BaseDuration()) and A.Ascendance:GetCooldown() < 4 and (not A.StormElemental:IsSpellLearned() or A.StormElemental:IsSpellLearned() and A.StormElemental:GetCooldown() < 120)) and (Unit("player"):HasBuffsStacks(A.WindGustBuff.ID, true) < 14 or A.IgneousPotential:GetAzeriteRank() >= 2 or Unit("player"):HasBuffs(A.LavaSurgeBuff.ID, true) or not Unit("player"):HasHeroism) and not Unit("player"):HasBuffs(A.SurgeofPowerBuff.ID, true)
end

local function EvaluateCycleFlameShock406(unit)
    return Unit(unit):HasDeBuffsRefreshable(A.FlameShockDebuff.ID, true) and MultiUnits:GetByRangeInCombat(40, 5, 10) > 1 and Unit("player"):HasBuffs(A.SurgeofPowerBuff.ID, true)
end

local function EvaluateCycleFlameShock557(unit)
    return Unit(unit):HasDeBuffsRefreshable(A.FlameShockDebuff.ID, true) and not Unit("player"):HasBuffs(A.SurgeofPowerBuff.ID, true)
end

local function EvaluateCycleFlameShock603(unit)
    return Unit(unit):HasDeBuffsRefreshable(A.FlameShockDebuff.ID, true)
end

local function EvaluateCycleFlameShock620(unit)
    return (not Unit(unit):HasDeBuffs(A.FlameShockDebuff.ID, true) or Unit(unit):HasDeBuffs(A.FlameShockDebuff.ID, true) <= GetGCD() or A.Ascendance:IsSpellLearned() and Unit(unit):HasDeBuffs(A.FlameShockDebuff.ID, true) < (A.Ascendance:GetCooldown() + A.AscendanceBuff.ID, true:BaseDuration()) and A.Ascendance:GetCooldown() < 4 and (not A.StormElemental:IsSpellLearned() or A.StormElemental:IsSpellLearned() and A.StormElemental:GetCooldown() < 120)) and (Unit("player"):HasBuffsStacks(A.WindGustBuff.ID, true) < 14 or A.IgneousPotential:GetAzeriteRank() >= 2 or Unit("player"):HasBuffs(A.LavaSurgeBuff.ID, true) or not Unit("player"):HasHeroism) and not Unit("player"):HasBuffs(A.SurgeofPowerBuff.ID, true)
end

local function EvaluateCycleFlameShock887(unit)
    return Unit(unit):HasDeBuffsRefreshable(A.FlameShockDebuff.ID, true) and MultiUnits:GetByRangeInCombat(40, 5, 10) > 1 and Unit("player"):HasBuffs(A.SurgeofPowerBuff.ID, true)
end

local function EvaluateCycleFlameShock1038(unit)
    return Unit(unit):HasDeBuffsRefreshable(A.FlameShockDebuff.ID, true) and not Unit("player"):HasBuffs(A.SurgeofPowerBuff.ID, true)
end

local function EvaluateCycleFlameShock1090(unit)
    return Unit(unit):HasDeBuffsRefreshable(A.FlameShockDebuff.ID, true)
end

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
            -- totem_mastery
            if A.TotemMastery:IsReady(unit) then
                return A.TotemMastery:Show(icon)
            end
            
            -- earth_elemental,if=!talent.primal_elementalist.enabled
            -- use_item,name=azsharas_font_of_power
            if A.AzsharasFontofPower:IsReady(unit) then
                return A.AzsharasFontofPower:Show(icon)
            end
            
            -- stormkeeper,if=talent.stormkeeper.enabled&(raid_event.adds.count<3|raid_event.adds.in>50)
            if A.Stormkeeper:IsReady(unit) and Unit("player"):HasBuffsDown(A.StormkeeperBuff.ID, true) and (A.Stormkeeper:IsSpellLearned() and ((MultiUnits:GetByRangeInCombat(40, 5, 10) - 1) < 3 or IncomingAddsIn > 50)) then
                return A.Stormkeeper:Show(icon)
            end
            
            -- potion
            if A.PotionofSpectralIntellect:IsReady(unit) and Potion then
                return A.PotionofSpectralIntellect:Show(icon)
            end
            
            -- elemental_blast,if=talent.elemental_blast.enabled
            if A.ElementalBlast:IsReady(unit) and (A.ElementalBlast:IsSpellLearned()) then
                return A.ElementalBlast:Show(icon)
            end
            
            -- lava_burst,if=!talent.elemental_blast.enabled
            if A.LavaBurst:IsReady(unit) and (not A.ElementalBlast:IsSpellLearned()) then
                return A.LavaBurst:Show(icon)
            end
            
        end
        
        --Aoe
        local function Aoe(unit)
        
            -- stormkeeper,if=talent.stormkeeper.enabled
            if A.Stormkeeper:IsReady(unit) and (A.Stormkeeper:IsSpellLearned()) then
                return A.Stormkeeper:Show(icon)
            end
            
            -- flame_shock,target_if=refreshable&(spell_targets.chain_lightning<(5-!talent.totem_mastery.enabled)|!talent.storm_elemental.enabled&(cooldown.fire_elemental.remains>(cooldown.storm_elemental.duration-30+14*spell_haste)|cooldown.fire_elemental.remains<(24-14*spell_haste)))&(!talent.storm_elemental.enabled|cooldown.storm_elemental.remains<(cooldown.storm_elemental.duration-30)|spell_targets.chain_lightning=3&buff.wind_gust.stack<14)
            if A.FlameShock:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.FlameShock, 40, "min", EvaluateCycleFlameShock39) then
                    return A.FlameShock:Show(icon) 
                end
            end
            -- ascendance,if=talent.ascendance.enabled&(talent.storm_elemental.enabled&cooldown.storm_elemental.remains<(cooldown.storm_elemental.duration-30)&cooldown.storm_elemental.remains>15|!talent.storm_elemental.enabled)&(!talent.icefury.enabled|!buff.icefury.up&!cooldown.icefury.up)
            if A.Ascendance:IsReady(unit) and A.BurstIsON(unit) and (A.Ascendance:IsSpellLearned() and (A.StormElemental:IsSpellLearned() and A.StormElemental:GetCooldown() < (A.StormElemental:BaseDuration() - 30) and A.StormElemental:GetCooldown() > 15 or not A.StormElemental:IsSpellLearned()) and (not A.Icefury:IsSpellLearned() or not Unit("player"):HasBuffs(A.IcefuryBuff.ID, true) and not A.Icefury:GetCooldown() == 0)) then
                return A.Ascendance:Show(icon)
            end
            
            -- liquid_magma_totem,if=talent.liquid_magma_totem.enabled
            if A.LiquidMagmaTotem:IsReady(unit) and (A.LiquidMagmaTotem:IsSpellLearned()) then
                return A.LiquidMagmaTotem:Show(icon)
            end
            
            -- earthquake,if=!talent.master_of_the_elements.enabled|buff.stormkeeper.up|maelstrom>=(100-4*spell_targets.chain_lightning)|buff.master_of_the_elements.up|spell_targets.chain_lightning>3
            if A.Earthquake:IsReady(unit) and (not A.MasteroftheElements:IsSpellLearned() or Unit("player"):HasBuffs(A.StormkeeperBuff.ID, true) or Player:Maelstrom() >= (100 - 4 * MultiUnits:GetByRangeInCombat(40, 5, 10)) or Unit("player"):HasBuffs(A.MasteroftheElementsBuff.ID, true) or MultiUnits:GetByRangeInCombat(40, 5, 10) > 3) then
                return A.Earthquake:Show(icon)
            end
            
            -- blood_of_the_enemy,if=!talent.primal_elementalist.enabled|!talent.storm_elemental.enabled
            if A.BloodoftheEnemy:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and (not A.PrimalElementalist:IsSpellLearned() or not A.StormElemental:IsSpellLearned()) then
                return A.BloodoftheEnemy:Show(icon)
            end
            
            -- chain_lightning,if=buff.stormkeeper.remains<3*gcd*buff.stormkeeper.stack
            if A.ChainLightning:IsReady(unit) and (Unit("player"):HasBuffs(A.StormkeeperBuff.ID, true) < 3 * GetGCD() * Unit("player"):HasBuffsStacks(A.StormkeeperBuff.ID, true)) then
                return A.ChainLightning:Show(icon)
            end
            
            -- lava_burst,if=buff.lava_surge.up&spell_targets.chain_lightning<4&(!talent.storm_elemental.enabled|cooldown.storm_elemental.remains<(cooldown.storm_elemental.duration-30))&dot.flame_shock.ticking
            if A.LavaBurst:IsReady(unit) and (Unit("player"):HasBuffs(A.LavaSurgeBuff.ID, true) and MultiUnits:GetByRangeInCombat(40, 5, 10) < 4 and (not A.StormElemental:IsSpellLearned() or A.StormElemental:GetCooldown() < (A.StormElemental:BaseDuration() - 30)) and Unit(unit):HasDeBuffs(A.FlameShockDebuff.ID, true)) then
                return A.LavaBurst:Show(icon)
            end
            
            -- icefury,if=spell_targets.chain_lightning<4&!buff.ascendance.up
            if A.Icefury:IsReady(unit) and (MultiUnits:GetByRangeInCombat(40, 5, 10) < 4 and not Unit("player"):HasBuffs(A.AscendanceBuff.ID, true)) then
                return A.Icefury:Show(icon)
            end
            
            -- frost_shock,if=spell_targets.chain_lightning<4&buff.icefury.up&!buff.ascendance.up
            if A.FrostShock:IsReady(unit) and (MultiUnits:GetByRangeInCombat(40, 5, 10) < 4 and Unit("player"):HasBuffs(A.IcefuryBuff.ID, true) and not Unit("player"):HasBuffs(A.AscendanceBuff.ID, true)) then
                return A.FrostShock:Show(icon)
            end
            
            -- elemental_blast,if=talent.elemental_blast.enabled&spell_targets.chain_lightning<4&(!talent.storm_elemental.enabled|cooldown.storm_elemental.remains<(cooldown.storm_elemental.duration-30))
            if A.ElementalBlast:IsReady(unit) and (A.ElementalBlast:IsSpellLearned() and MultiUnits:GetByRangeInCombat(40, 5, 10) < 4 and (not A.StormElemental:IsSpellLearned() or A.StormElemental:GetCooldown() < (A.StormElemental:BaseDuration() - 30))) then
                return A.ElementalBlast:Show(icon)
            end
            
            -- lava_beam,if=talent.ascendance.enabled
            if A.LavaBeam:IsReady(unit) and (A.Ascendance:IsSpellLearned()) then
                return A.LavaBeam:Show(icon)
            end
            
            -- chain_lightning
            if A.ChainLightning:IsReady(unit) then
                return A.ChainLightning:Show(icon)
            end
            
            -- lava_burst,moving=1,if=talent.ascendance.enabled
            if A.LavaBurst:IsReady(unit) and isMoving and (A.Ascendance:IsSpellLearned()) then
                return A.LavaBurst:Show(icon)
            end
            
            -- flame_shock,moving=1,target_if=refreshable
            if A.FlameShock:IsReady(unit) and isMoving then
                if Action.Utils.CastTargetIf(A.FlameShock, 40, "min", EvaluateCycleFlameShock156) then
                    return A.FlameShock:Show(icon) 
                end
            end
            -- frost_shock,moving=1
            if A.FrostShock:IsReady(unit) and isMoving then
                return A.FrostShock:Show(icon)
            end
            
        end
        
        --Funnel
        local function Funnel(unit)
        
            -- flame_shock,target_if=(!ticking|dot.flame_shock.remains<=gcd|talent.ascendance.enabled&dot.flame_shock.remains<(cooldown.ascendance.remains+buff.ascendance.duration)&cooldown.ascendance.remains<4&(!talent.storm_elemental.enabled|talent.storm_elemental.enabled&cooldown.storm_elemental.remains<120))&(buff.wind_gust.stack<14|azerite.igneous_potential.rank>=2|buff.lava_surge.up|!buff.bloodlust.up)&!buff.surge_of_power.up
            if A.FlameShock:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.FlameShock, 40, "min", EvaluateCycleFlameShock171) then
                    return A.FlameShock:Show(icon) 
                end
            end
            -- blood_of_the_enemy,if=!talent.ascendance.enabled&(!talent.storm_elemental.enabled|!talent.primal_elementalist.enabled)|talent.ascendance.enabled&(time>=60|buff.bloodlust.up)&cooldown.lava_burst.remains>0&(cooldown.storm_elemental.remains<(cooldown.storm_elemental.duration-30)|!talent.storm_elemental.enabled)&(!talent.icefury.enabled|!buff.icefury.up&!cooldown.icefury.up)
            if A.BloodoftheEnemy:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and (not A.Ascendance:IsSpellLearned() and (not A.StormElemental:IsSpellLearned() or not A.PrimalElementalist:IsSpellLearned()) or A.Ascendance:IsSpellLearned() and (Unit("player"):CombatTime() >= 60 or Unit("player"):HasHeroism) and A.LavaBurst:GetCooldown() > 0 and (A.StormElemental:GetCooldown() < (A.StormElemental:BaseDuration() - 30) or not A.StormElemental:IsSpellLearned()) and (not A.Icefury:IsSpellLearned() or not Unit("player"):HasBuffs(A.IcefuryBuff.ID, true) and not A.Icefury:GetCooldown() == 0)) then
                return A.BloodoftheEnemy:Show(icon)
            end
            
            -- ascendance,if=talent.ascendance.enabled&(time>=60|buff.bloodlust.up)&cooldown.lava_burst.remains>0&(cooldown.storm_elemental.remains<(cooldown.storm_elemental.duration-30)|!talent.storm_elemental.enabled)&(!talent.icefury.enabled|!buff.icefury.up&!cooldown.icefury.up)
            if A.Ascendance:IsReady(unit) and A.BurstIsON(unit) and (A.Ascendance:IsSpellLearned() and (Unit("player"):CombatTime() >= 60 or Unit("player"):HasHeroism) and A.LavaBurst:GetCooldown() > 0 and (A.StormElemental:GetCooldown() < (A.StormElemental:BaseDuration() - 30) or not A.StormElemental:IsSpellLearned()) and (not A.Icefury:IsSpellLearned() or not Unit("player"):HasBuffs(A.IcefuryBuff.ID, true) and not A.Icefury:GetCooldown() == 0)) then
                return A.Ascendance:Show(icon)
            end
            
            -- elemental_blast,if=talent.elemental_blast.enabled&(talent.master_of_the_elements.enabled&buff.master_of_the_elements.up&maelstrom<60|!talent.master_of_the_elements.enabled)&(!(cooldown.storm_elemental.remains>(cooldown.storm_elemental.duration-30)&talent.storm_elemental.enabled)|azerite.natural_harmony.rank=3&buff.wind_gust.stack<14)
            if A.ElementalBlast:IsReady(unit) and (A.ElementalBlast:IsSpellLearned() and (A.MasteroftheElements:IsSpellLearned() and Unit("player"):HasBuffs(A.MasteroftheElementsBuff.ID, true) and Player:Maelstrom() < 60 or not A.MasteroftheElements:IsSpellLearned()) and (not (A.StormElemental:GetCooldown() > (A.StormElemental:BaseDuration() - 30) and A.StormElemental:IsSpellLearned()) or A.NaturalHarmony:GetAzeriteRank() == 3 and Unit("player"):HasBuffsStacks(A.WindGustBuff.ID, true) < 14)) then
                return A.ElementalBlast:Show(icon)
            end
            
            -- stormkeeper,if=talent.stormkeeper.enabled&(raid_event.adds.count<3|raid_event.adds.in>50)&(!talent.surge_of_power.enabled|buff.surge_of_power.up|maelstrom>=44)
            if A.Stormkeeper:IsReady(unit) and (A.Stormkeeper:IsSpellLearned() and ((MultiUnits:GetByRangeInCombat(40, 5, 10) - 1) < 3 or IncomingAddsIn > 50) and (not A.SurgeofPower:IsSpellLearned() or Unit("player"):HasBuffs(A.SurgeofPowerBuff.ID, true) or Player:Maelstrom() >= 44)) then
                return A.Stormkeeper:Show(icon)
            end
            
            -- liquid_magma_totem,if=talent.liquid_magma_totem.enabled&(raid_event.adds.count<3|raid_event.adds.in>50)
            if A.LiquidMagmaTotem:IsReady(unit) and (A.LiquidMagmaTotem:IsSpellLearned() and ((MultiUnits:GetByRangeInCombat(40, 5, 10) - 1) < 3 or IncomingAddsIn > 50)) then
                return A.LiquidMagmaTotem:Show(icon)
            end
            
            -- lightning_bolt,if=buff.stormkeeper.up&spell_targets.chain_lightning<6&(azerite.lava_shock.rank*buff.lava_shock.stack)<36&(buff.master_of_the_elements.up&!talent.surge_of_power.enabled|buff.surge_of_power.up)
            if A.LightningBolt:IsReady(unit) and (Unit("player"):HasBuffs(A.StormkeeperBuff.ID, true) and MultiUnits:GetByRangeInCombat(40, 5, 10) < 6 and (A.LavaShock:GetAzeriteRank() * Unit("player"):HasBuffsStacks(A.LavaShockBuff.ID, true)) < 36 and (Unit("player"):HasBuffs(A.MasteroftheElementsBuff.ID, true) and not A.SurgeofPower:IsSpellLearned() or Unit("player"):HasBuffs(A.SurgeofPowerBuff.ID, true))) then
                return A.LightningBolt:Show(icon)
            end
            
            -- earth_shock,if=!buff.surge_of_power.up&talent.master_of_the_elements.enabled&(buff.master_of_the_elements.up|cooldown.lava_burst.remains>0&maelstrom>=92+30*talent.call_the_thunder.enabled|(azerite.lava_shock.rank*buff.lava_shock.stack<36)&buff.stormkeeper.up&cooldown.lava_burst.remains<=gcd)
            if A.EarthShock:IsReady(unit) and (not Unit("player"):HasBuffs(A.SurgeofPowerBuff.ID, true) and A.MasteroftheElements:IsSpellLearned() and (Unit("player"):HasBuffs(A.MasteroftheElementsBuff.ID, true) or A.LavaBurst:GetCooldown() > 0 and Player:Maelstrom() >= 92 + 30 * num(A.CalltheThunder:IsSpellLearned()) or (A.LavaShock:GetAzeriteRank() * Unit("player"):HasBuffsStacks(A.LavaShockBuff.ID, true) < 36) and Unit("player"):HasBuffs(A.StormkeeperBuff.ID, true) and A.LavaBurst:GetCooldown() <= GetGCD())) then
                return A.EarthShock:Show(icon)
            end
            
            -- earth_shock,if=!talent.master_of_the_elements.enabled&!(azerite.igneous_potential.rank>2&buff.ascendance.up)&(buff.stormkeeper.up|maelstrom>=90+30*talent.call_the_thunder.enabled|!(cooldown.storm_elemental.remains>(cooldown.storm_elemental.duration-30)&talent.storm_elemental.enabled)&expected_combat_length-time-cooldown.storm_elemental.remains-cooldown.storm_elemental.duration*floor((expected_combat_length-time-cooldown.storm_elemental.remains)%cooldown.storm_elemental.duration)>=30*(1+(azerite.echo_of_the_elementals.rank>=2)))
            if A.EarthShock:IsReady(unit) and (not A.MasteroftheElements:IsSpellLearned() and not (A.IgneousPotential:GetAzeriteRank() > 2 and Unit("player"):HasBuffs(A.AscendanceBuff.ID, true)) and (Unit("player"):HasBuffs(A.StormkeeperBuff.ID, true) or Player:Maelstrom() >= 90 + 30 * num(A.CalltheThunder:IsSpellLearned()) or not (A.StormElemental:GetCooldown() > (A.StormElemental:BaseDuration() - 30) and A.StormElemental:IsSpellLearned()) and expected_combat_length - Unit("player"):CombatTime() - A.StormElemental:GetCooldown() - A.StormElemental:BaseDuration() * math.floor ((expected_combat_length - Unit("player"):CombatTime() - A.StormElemental:GetCooldown()) / A.StormElemental:BaseDuration()) >= 30 * (1 + num((A.EchooftheElementals:GetAzeriteRank() >= 2))))) then
                return A.EarthShock:Show(icon)
            end
            
            -- earth_shock,if=talent.surge_of_power.enabled&!buff.surge_of_power.up&cooldown.lava_burst.remains<=gcd&(!talent.storm_elemental.enabled&!(cooldown.fire_elemental.remains>(cooldown.storm_elemental.duration-30))|talent.storm_elemental.enabled&!(cooldown.storm_elemental.remains>(cooldown.storm_elemental.duration-30)))
            if A.EarthShock:IsReady(unit) and (A.SurgeofPower:IsSpellLearned() and not Unit("player"):HasBuffs(A.SurgeofPowerBuff.ID, true) and A.LavaBurst:GetCooldown() <= GetGCD() and (not A.StormElemental:IsSpellLearned() and not (A.FireElemental:GetCooldown() > (A.StormElemental:BaseDuration() - 30)) or A.StormElemental:IsSpellLearned() and not (A.StormElemental:GetCooldown() > (A.StormElemental:BaseDuration() - 30)))) then
                return A.EarthShock:Show(icon)
            end
            
            -- lightning_bolt,if=cooldown.storm_elemental.remains>(cooldown.storm_elemental.duration-30)&talent.storm_elemental.enabled&(azerite.igneous_potential.rank<2|!buff.lava_surge.up&buff.bloodlust.up)
            if A.LightningBolt:IsReady(unit) and (A.StormElemental:GetCooldown() > (A.StormElemental:BaseDuration() - 30) and A.StormElemental:IsSpellLearned() and (A.IgneousPotential:GetAzeriteRank() < 2 or not Unit("player"):HasBuffs(A.LavaSurgeBuff.ID, true) and Unit("player"):HasHeroism)) then
                return A.LightningBolt:Show(icon)
            end
            
            -- lightning_bolt,if=(buff.stormkeeper.remains<1.1*gcd*buff.stormkeeper.stack|buff.stormkeeper.up&buff.master_of_the_elements.up)
            if A.LightningBolt:IsReady(unit) and ((Unit("player"):HasBuffs(A.StormkeeperBuff.ID, true) < 1.1 * GetGCD() * Unit("player"):HasBuffsStacks(A.StormkeeperBuff.ID, true) or Unit("player"):HasBuffs(A.StormkeeperBuff.ID, true) and Unit("player"):HasBuffs(A.MasteroftheElementsBuff.ID, true))) then
                return A.LightningBolt:Show(icon)
            end
            
            -- frost_shock,if=talent.icefury.enabled&talent.master_of_the_elements.enabled&buff.icefury.up&buff.master_of_the_elements.up
            if A.FrostShock:IsReady(unit) and (A.Icefury:IsSpellLearned() and A.MasteroftheElements:IsSpellLearned() and Unit("player"):HasBuffs(A.IcefuryBuff.ID, true) and Unit("player"):HasBuffs(A.MasteroftheElementsBuff.ID, true)) then
                return A.FrostShock:Show(icon)
            end
            
            -- lava_burst,if=buff.ascendance.up
            if A.LavaBurst:IsReady(unit) and (Unit("player"):HasBuffs(A.AscendanceBuff.ID, true)) then
                return A.LavaBurst:Show(icon)
            end
            
            -- flame_shock,target_if=refreshable&active_enemies>1&buff.surge_of_power.up
            if A.FlameShock:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.FlameShock, 40, "min", EvaluateCycleFlameShock406) then
                    return A.FlameShock:Show(icon) 
                end
            end
            -- lava_burst,if=talent.storm_elemental.enabled&cooldown_react&buff.surge_of_power.up&(expected_combat_length-time-cooldown.storm_elemental.remains-(cooldown.storm_elemental.duration-30)*floor((expected_combat_length-time-cooldown.storm_elemental.remains)%(cooldown.storm_elemental.duration-30))<30*(1+(azerite.echo_of_the_elementals.rank>=2))|(1.16*(expected_combat_length-time)-cooldown.storm_elemental.remains-cooldown.storm_elemental.duration*floor((1.16*(expected_combat_length-time)-cooldown.storm_elemental.remains)%cooldown.storm_elemental.duration))<(expected_combat_length-time-cooldown.storm_elemental.remains-cooldown.storm_elemental.duration*floor((expected_combat_length-time-cooldown.storm_elemental.remains)%cooldown.storm_elemental.duration)))
            if A.LavaBurst:IsReady(unit) and (A.StormElemental:IsSpellLearned() and A.LavaBurst:GetCooldown() == 0 and Unit("player"):HasBuffs(A.SurgeofPowerBuff.ID, true) and (expected_combat_length - Unit("player"):CombatTime() - A.StormElemental:GetCooldown() - (A.StormElemental:BaseDuration() - 30) * math.floor ((expected_combat_length - Unit("player"):CombatTime() - A.StormElemental:GetCooldown()) / (A.StormElemental:BaseDuration() - 30)) < 30 * (1 + num((A.EchooftheElementals:GetAzeriteRank() >= 2))) or (1.16 * (expected_combat_length - Unit("player"):CombatTime()) - A.StormElemental:GetCooldown() - A.StormElemental:BaseDuration() * math.floor ((1.16 * (expected_combat_length - Unit("player"):CombatTime()) - A.StormElemental:GetCooldown()) / A.StormElemental:BaseDuration())) < (expected_combat_length - Unit("player"):CombatTime() - A.StormElemental:GetCooldown() - A.StormElemental:BaseDuration() * math.floor ((expected_combat_length - Unit("player"):CombatTime() - A.StormElemental:GetCooldown()) / A.StormElemental:BaseDuration())))) then
                return A.LavaBurst:Show(icon)
            end
            
            -- lava_burst,if=!talent.storm_elemental.enabled&cooldown_react&buff.surge_of_power.up&(expected_combat_length-time-cooldown.fire_elemental.remains-cooldown.fire_elemental.duration*floor((expected_combat_length-time-cooldown.fire_elemental.remains)%cooldown.fire_elemental.duration)<30*(1+(azerite.echo_of_the_elementals.rank>=2))|(1.16*(expected_combat_length-time)-cooldown.fire_elemental.remains-cooldown.fire_elemental.duration*floor((1.16*(expected_combat_length-time)-cooldown.fire_elemental.remains)%cooldown.fire_elemental.duration))<(expected_combat_length-time-cooldown.fire_elemental.remains-cooldown.fire_elemental.duration*floor((expected_combat_length-time-cooldown.fire_elemental.remains)%cooldown.fire_elemental.duration)))
            if A.LavaBurst:IsReady(unit) and (not A.StormElemental:IsSpellLearned() and A.LavaBurst:GetCooldown() == 0 and Unit("player"):HasBuffs(A.SurgeofPowerBuff.ID, true) and (expected_combat_length - Unit("player"):CombatTime() - A.FireElemental:GetCooldown() - A.FireElemental:BaseDuration() * math.floor ((expected_combat_length - Unit("player"):CombatTime() - A.FireElemental:GetCooldown()) / A.FireElemental:BaseDuration()) < 30 * (1 + num((A.EchooftheElementals:GetAzeriteRank() >= 2))) or (1.16 * (expected_combat_length - Unit("player"):CombatTime()) - A.FireElemental:GetCooldown() - A.FireElemental:BaseDuration() * math.floor ((1.16 * (expected_combat_length - Unit("player"):CombatTime()) - A.FireElemental:GetCooldown()) / A.FireElemental:BaseDuration())) < (expected_combat_length - Unit("player"):CombatTime() - A.FireElemental:GetCooldown() - A.FireElemental:BaseDuration() * math.floor ((expected_combat_length - Unit("player"):CombatTime() - A.FireElemental:GetCooldown()) / A.FireElemental:BaseDuration())))) then
                return A.LavaBurst:Show(icon)
            end
            
            -- lightning_bolt,if=buff.surge_of_power.up
            if A.LightningBolt:IsReady(unit) and (Unit("player"):HasBuffs(A.SurgeofPowerBuff.ID, true)) then
                return A.LightningBolt:Show(icon)
            end
            
            -- lava_burst,if=cooldown_react&!talent.master_of_the_elements.enabled
            if A.LavaBurst:IsReady(unit) and (A.LavaBurst:GetCooldown() == 0 and not A.MasteroftheElements:IsSpellLearned()) then
                return A.LavaBurst:Show(icon)
            end
            
            -- icefury,if=talent.icefury.enabled&!(maelstrom>75&cooldown.lava_burst.remains<=0)&(!talent.storm_elemental.enabled|cooldown.storm_elemental.remains<cooldown.storm_elemental.duration)
            if A.Icefury:IsReady(unit) and (A.Icefury:IsSpellLearned() and not (Player:Maelstrom() > 75 and A.LavaBurst:GetCooldown() <= 0) and (not A.StormElemental:IsSpellLearned() or A.StormElemental:GetCooldown() < A.StormElemental:BaseDuration())) then
                return A.Icefury:Show(icon)
            end
            
            -- lava_burst,if=cooldown_react&charges>talent.echo_of_the_elements.enabled
            if A.LavaBurst:IsReady(unit) and (A.LavaBurst:GetCooldown() == 0 and A.LavaBurst:GetSpellCharges() > num(A.EchooftheElements:IsSpellLearned())) then
                return A.LavaBurst:Show(icon)
            end
            
            -- frost_shock,if=talent.icefury.enabled&buff.icefury.up&buff.icefury.remains<1.1*gcd*buff.icefury.stack
            if A.FrostShock:IsReady(unit) and (A.Icefury:IsSpellLearned() and Unit("player"):HasBuffs(A.IcefuryBuff.ID, true) and Unit("player"):HasBuffs(A.IcefuryBuff.ID, true) < 1.1 * GetGCD() * Unit("player"):HasBuffsStacks(A.IcefuryBuff.ID, true)) then
                return A.FrostShock:Show(icon)
            end
            
            -- lava_burst,if=cooldown_react
            if A.LavaBurst:IsReady(unit) and (A.LavaBurst:GetCooldown() == 0) then
                return A.LavaBurst:Show(icon)
            end
            
            -- concentrated_flame
            if A.ConcentratedFlame:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth then
                return A.ConcentratedFlame:Show(icon)
            end
            
            -- reaping_flames
            if A.ReapingFlames:IsReady(unit) then
                return A.ReapingFlames:Show(icon)
            end
            
            -- flame_shock,target_if=refreshable&!buff.surge_of_power.up
            if A.FlameShock:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.FlameShock, 40, "min", EvaluateCycleFlameShock557) then
                    return A.FlameShock:Show(icon) 
                end
            end
            -- totem_mastery,if=talent.totem_mastery.enabled&(buff.resonance_totem.remains<6|(buff.resonance_totem.remains<(buff.ascendance.duration+cooldown.ascendance.remains)&cooldown.ascendance.remains<15))
            if A.TotemMastery:IsReady(unit) and (A.TotemMastery:IsSpellLearned() and (Unit("player"):HasBuffs(A.ResonanceTotemBuff.ID, true) < 6 or (Unit("player"):HasBuffs(A.ResonanceTotemBuff.ID, true) < (A.AscendanceBuff.ID, true:BaseDuration() + A.Ascendance:GetCooldown()) and A.Ascendance:GetCooldown() < 15))) then
                return A.TotemMastery:Show(icon)
            end
            
            -- frost_shock,if=talent.icefury.enabled&buff.icefury.up&(buff.icefury.remains<gcd*4*buff.icefury.stack|buff.stormkeeper.up|!talent.master_of_the_elements.enabled)
            if A.FrostShock:IsReady(unit) and (A.Icefury:IsSpellLearned() and Unit("player"):HasBuffs(A.IcefuryBuff.ID, true) and (Unit("player"):HasBuffs(A.IcefuryBuff.ID, true) < GetGCD() * 4 * Unit("player"):HasBuffsStacks(A.IcefuryBuff.ID, true) or Unit("player"):HasBuffs(A.StormkeeperBuff.ID, true) or not A.MasteroftheElements:IsSpellLearned())) then
                return A.FrostShock:Show(icon)
            end
            
            -- earth_elemental,if=!talent.primal_elementalist.enabled|talent.primal_elementalist.enabled&(cooldown.fire_elemental.remains<(cooldown.fire_elemental.duration-30)&!talent.storm_elemental.enabled|cooldown.storm_elemental.remains<(cooldown.storm_elemental.duration-30)&talent.storm_elemental.enabled)
            -- lightning_bolt
            if A.LightningBolt:IsReady(unit) then
                return A.LightningBolt:Show(icon)
            end
            
            -- flame_shock,moving=1,target_if=refreshable
            if A.FlameShock:IsReady(unit) and isMoving then
                if Action.Utils.CastTargetIf(A.FlameShock, 40, "min", EvaluateCycleFlameShock603) then
                    return A.FlameShock:Show(icon) 
                end
            end
            -- flame_shock,moving=1,if=movement.distance>6
            if A.FlameShock:IsReady(unit) and isMoving and (Unit(unit):GetRange() > 6) then
                return A.FlameShock:Show(icon)
            end
            
            -- frost_shock,moving=1
            if A.FrostShock:IsReady(unit) and isMoving then
                return A.FrostShock:Show(icon)
            end
            
        end
        
        --SingleUnit(unit)
        local function SingleUnit(unit)(unit)
        
            -- flame_shock,target_if=(!ticking|dot.flame_shock.remains<=gcd|talent.ascendance.enabled&dot.flame_shock.remains<(cooldown.ascendance.remains+buff.ascendance.duration)&cooldown.ascendance.remains<4&(!talent.storm_elemental.enabled|talent.storm_elemental.enabled&cooldown.storm_elemental.remains<120))&(buff.wind_gust.stack<14|azerite.igneous_potential.rank>=2|buff.lava_surge.up|!buff.bloodlust.up)&!buff.surge_of_power.up
            if A.FlameShock:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.FlameShock, 40, "min", EvaluateCycleFlameShock620) then
                    return A.FlameShock:Show(icon) 
                end
            end
            -- blood_of_the_enemy,if=!talent.ascendance.enabled&!talent.storm_elemental.enabled|talent.ascendance.enabled&(time>=60|buff.bloodlust.up)&cooldown.lava_burst.remains>0&(cooldown.storm_elemental.remains<(cooldown.storm_elemental.duration-30)|!talent.storm_elemental.enabled)&(!talent.icefury.enabled|!buff.icefury.up&!cooldown.icefury.up)
            if A.BloodoftheEnemy:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and (not A.Ascendance:IsSpellLearned() and not A.StormElemental:IsSpellLearned() or A.Ascendance:IsSpellLearned() and (Unit("player"):CombatTime() >= 60 or Unit("player"):HasHeroism) and A.LavaBurst:GetCooldown() > 0 and (A.StormElemental:GetCooldown() < (A.StormElemental:BaseDuration() - 30) or not A.StormElemental:IsSpellLearned()) and (not A.Icefury:IsSpellLearned() or not Unit("player"):HasBuffs(A.IcefuryBuff.ID, true) and not A.Icefury:GetCooldown() == 0)) then
                return A.BloodoftheEnemy:Show(icon)
            end
            
            -- ascendance,if=talent.ascendance.enabled&(time>=60|buff.bloodlust.up)&cooldown.lava_burst.remains>0&(cooldown.storm_elemental.remains<(cooldown.storm_elemental.duration-30)|!talent.storm_elemental.enabled)&(!talent.icefury.enabled|!buff.icefury.up&!cooldown.icefury.up)
            if A.Ascendance:IsReady(unit) and A.BurstIsON(unit) and (A.Ascendance:IsSpellLearned() and (Unit("player"):CombatTime() >= 60 or Unit("player"):HasHeroism) and A.LavaBurst:GetCooldown() > 0 and (A.StormElemental:GetCooldown() < (A.StormElemental:BaseDuration() - 30) or not A.StormElemental:IsSpellLearned()) and (not A.Icefury:IsSpellLearned() or not Unit("player"):HasBuffs(A.IcefuryBuff.ID, true) and not A.Icefury:GetCooldown() == 0)) then
                return A.Ascendance:Show(icon)
            end
            
            -- elemental_blast,if=talent.elemental_blast.enabled&(talent.master_of_the_elements.enabled&(buff.master_of_the_elements.up&maelstrom<60|!buff.master_of_the_elements.up)|!talent.master_of_the_elements.enabled)&(!(cooldown.storm_elemental.remains>(cooldown.storm_elemental.duration-30)&talent.storm_elemental.enabled)|azerite.natural_harmony.rank=3&buff.wind_gust.stack<14)
            if A.ElementalBlast:IsReady(unit) and (A.ElementalBlast:IsSpellLearned() and (A.MasteroftheElements:IsSpellLearned() and (Unit("player"):HasBuffs(A.MasteroftheElementsBuff.ID, true) and Player:Maelstrom() < 60 or not Unit("player"):HasBuffs(A.MasteroftheElementsBuff.ID, true)) or not A.MasteroftheElements:IsSpellLearned()) and (not (A.StormElemental:GetCooldown() > (A.StormElemental:BaseDuration() - 30) and A.StormElemental:IsSpellLearned()) or A.NaturalHarmony:GetAzeriteRank() == 3 and Unit("player"):HasBuffsStacks(A.WindGustBuff.ID, true) < 14)) then
                return A.ElementalBlast:Show(icon)
            end
            
            -- stormkeeper,if=talent.stormkeeper.enabled&(raid_event.adds.count<3|raid_event.adds.in>50)&(!talent.surge_of_power.enabled|buff.surge_of_power.up|maelstrom>=44)
            if A.Stormkeeper:IsReady(unit) and (A.Stormkeeper:IsSpellLearned() and ((MultiUnits:GetByRangeInCombat(40, 5, 10) - 1) < 3 or IncomingAddsIn > 50) and (not A.SurgeofPower:IsSpellLearned() or Unit("player"):HasBuffs(A.SurgeofPowerBuff.ID, true) or Player:Maelstrom() >= 44)) then
                return A.Stormkeeper:Show(icon)
            end
            
            -- liquid_magma_totem,if=talent.liquid_magma_totem.enabled&(raid_event.adds.count<3|raid_event.adds.in>50)
            if A.LiquidMagmaTotem:IsReady(unit) and (A.LiquidMagmaTotem:IsSpellLearned() and ((MultiUnits:GetByRangeInCombat(40, 5, 10) - 1) < 3 or IncomingAddsIn > 50)) then
                return A.LiquidMagmaTotem:Show(icon)
            end
            
            -- lightning_bolt,if=buff.stormkeeper.up&spell_targets.chain_lightning<2&(azerite.lava_shock.rank*buff.lava_shock.stack)<26&(buff.master_of_the_elements.up&!talent.surge_of_power.enabled|buff.surge_of_power.up)
            if A.LightningBolt:IsReady(unit) and (Unit("player"):HasBuffs(A.StormkeeperBuff.ID, true) and MultiUnits:GetByRangeInCombat(40, 5, 10) < 2 and (A.LavaShock:GetAzeriteRank() * Unit("player"):HasBuffsStacks(A.LavaShockBuff.ID, true)) < 26 and (Unit("player"):HasBuffs(A.MasteroftheElementsBuff.ID, true) and not A.SurgeofPower:IsSpellLearned() or Unit("player"):HasBuffs(A.SurgeofPowerBuff.ID, true))) then
                return A.LightningBolt:Show(icon)
            end
            
            -- earthquake,if=(spell_targets.chain_lightning>1|azerite.tectonic_thunder.rank>=3&!talent.surge_of_power.enabled&azerite.lava_shock.rank<1)&azerite.lava_shock.rank*buff.lava_shock.stack<(36+3*azerite.tectonic_thunder.rank*spell_targets.chain_lightning)&(!talent.surge_of_power.enabled|!dot.flame_shock.refreshable|cooldown.storm_elemental.remains>(cooldown.storm_elemental.duration-30))&(!talent.master_of_the_elements.enabled|buff.master_of_the_elements.up|cooldown.lava_burst.remains>0&maelstrom>=92+30*talent.call_the_thunder.enabled)
            if A.Earthquake:IsReady(unit) and ((MultiUnits:GetByRangeInCombat(40, 5, 10) > 1 or A.TectonicThunder:GetAzeriteRank() >= 3 and not A.SurgeofPower:IsSpellLearned() and A.LavaShock:GetAzeriteRank() < 1) and A.LavaShock:GetAzeriteRank() * Unit("player"):HasBuffsStacks(A.LavaShockBuff.ID, true) < (36 + 3 * A.TectonicThunder:GetAzeriteRank() * MultiUnits:GetByRangeInCombat(40, 5, 10)) and (not A.SurgeofPower:IsSpellLearned() or not Unit(unit):HasDeBuffsRefreshable(A.FlameShockDebuff.ID, true) or A.StormElemental:GetCooldown() > (A.StormElemental:BaseDuration() - 30)) and (not A.MasteroftheElements:IsSpellLearned() or Unit("player"):HasBuffs(A.MasteroftheElementsBuff.ID, true) or A.LavaBurst:GetCooldown() > 0 and Player:Maelstrom() >= 92 + 30 * num(A.CalltheThunder:IsSpellLearned()))) then
                return A.Earthquake:Show(icon)
            end
            
            -- earth_shock,if=!buff.surge_of_power.up&talent.master_of_the_elements.enabled&(buff.master_of_the_elements.up|cooldown.lava_burst.remains>0&maelstrom>=92+30*talent.call_the_thunder.enabled|spell_targets.chain_lightning<2&(azerite.lava_shock.rank*buff.lava_shock.stack<26)&buff.stormkeeper.up&cooldown.lava_burst.remains<=gcd)
            if A.EarthShock:IsReady(unit) and (not Unit("player"):HasBuffs(A.SurgeofPowerBuff.ID, true) and A.MasteroftheElements:IsSpellLearned() and (Unit("player"):HasBuffs(A.MasteroftheElementsBuff.ID, true) or A.LavaBurst:GetCooldown() > 0 and Player:Maelstrom() >= 92 + 30 * num(A.CalltheThunder:IsSpellLearned()) or MultiUnits:GetByRangeInCombat(40, 5, 10) < 2 and (A.LavaShock:GetAzeriteRank() * Unit("player"):HasBuffsStacks(A.LavaShockBuff.ID, true) < 26) and Unit("player"):HasBuffs(A.StormkeeperBuff.ID, true) and A.LavaBurst:GetCooldown() <= GetGCD())) then
                return A.EarthShock:Show(icon)
            end
            
            -- earth_shock,if=!talent.master_of_the_elements.enabled&!(azerite.igneous_potential.rank>2&buff.ascendance.up)&(buff.stormkeeper.up|maelstrom>=90+30*talent.call_the_thunder.enabled|!(cooldown.storm_elemental.remains>cooldown.storm_elemental.duration&talent.storm_elemental.enabled)&expected_combat_length-time-cooldown.storm_elemental.remains-cooldown.storm_elemental.duration*floor((expected_combat_length-time-cooldown.storm_elemental.remains)%cooldown.storm_elemental.duration)>=30*(1+(azerite.echo_of_the_elementals.rank>=2)))
            if A.EarthShock:IsReady(unit) and (not A.MasteroftheElements:IsSpellLearned() and not (A.IgneousPotential:GetAzeriteRank() > 2 and Unit("player"):HasBuffs(A.AscendanceBuff.ID, true)) and (Unit("player"):HasBuffs(A.StormkeeperBuff.ID, true) or Player:Maelstrom() >= 90 + 30 * num(A.CalltheThunder:IsSpellLearned()) or not (A.StormElemental:GetCooldown() > A.StormElemental:BaseDuration() and A.StormElemental:IsSpellLearned()) and expected_combat_length - Unit("player"):CombatTime() - A.StormElemental:GetCooldown() - A.StormElemental:BaseDuration() * math.floor ((expected_combat_length - Unit("player"):CombatTime() - A.StormElemental:GetCooldown()) / A.StormElemental:BaseDuration()) >= 30 * (1 + num((A.EchooftheElementals:GetAzeriteRank() >= 2))))) then
                return A.EarthShock:Show(icon)
            end
            
            -- earth_shock,if=talent.surge_of_power.enabled&!buff.surge_of_power.up&cooldown.lava_burst.remains<=gcd&(!talent.storm_elemental.enabled&!(cooldown.fire_elemental.remains>(cooldown.fire_elemental.duration-30))|talent.storm_elemental.enabled&!(cooldown.storm_elemental.remains>(cooldown.storm_elemental.duration-30)))
            if A.EarthShock:IsReady(unit) and (A.SurgeofPower:IsSpellLearned() and not Unit("player"):HasBuffs(A.SurgeofPowerBuff.ID, true) and A.LavaBurst:GetCooldown() <= GetGCD() and (not A.StormElemental:IsSpellLearned() and not (A.FireElemental:GetCooldown() > (A.FireElemental:BaseDuration() - 30)) or A.StormElemental:IsSpellLearned() and not (A.StormElemental:GetCooldown() > (A.StormElemental:BaseDuration() - 30)))) then
                return A.EarthShock:Show(icon)
            end
            
            -- lightning_lasso
            if A.LightningLasso:IsReady(unit) then
                return A.LightningLasso:Show(icon)
            end
            
            -- lightning_bolt,if=cooldown.storm_elemental.remains>(cooldown.storm_elemental.duration-30)&talent.storm_elemental.enabled&(azerite.igneous_potential.rank<2|!buff.lava_surge.up&buff.bloodlust.up)
            if A.LightningBolt:IsReady(unit) and (A.StormElemental:GetCooldown() > (A.StormElemental:BaseDuration() - 30) and A.StormElemental:IsSpellLearned() and (A.IgneousPotential:GetAzeriteRank() < 2 or not Unit("player"):HasBuffs(A.LavaSurgeBuff.ID, true) and Unit("player"):HasHeroism)) then
                return A.LightningBolt:Show(icon)
            end
            
            -- lightning_bolt,if=(buff.stormkeeper.remains<1.1*gcd*buff.stormkeeper.stack|buff.stormkeeper.up&buff.master_of_the_elements.up)
            if A.LightningBolt:IsReady(unit) and ((Unit("player"):HasBuffs(A.StormkeeperBuff.ID, true) < 1.1 * GetGCD() * Unit("player"):HasBuffsStacks(A.StormkeeperBuff.ID, true) or Unit("player"):HasBuffs(A.StormkeeperBuff.ID, true) and Unit("player"):HasBuffs(A.MasteroftheElementsBuff.ID, true))) then
                return A.LightningBolt:Show(icon)
            end
            
            -- frost_shock,if=talent.icefury.enabled&talent.master_of_the_elements.enabled&buff.icefury.up&buff.master_of_the_elements.up
            if A.FrostShock:IsReady(unit) and (A.Icefury:IsSpellLearned() and A.MasteroftheElements:IsSpellLearned() and Unit("player"):HasBuffs(A.IcefuryBuff.ID, true) and Unit("player"):HasBuffs(A.MasteroftheElementsBuff.ID, true)) then
                return A.FrostShock:Show(icon)
            end
            
            -- lava_burst,if=buff.ascendance.up
            if A.LavaBurst:IsReady(unit) and (Unit("player"):HasBuffs(A.AscendanceBuff.ID, true)) then
                return A.LavaBurst:Show(icon)
            end
            
            -- flame_shock,target_if=refreshable&active_enemies>1&buff.surge_of_power.up
            if A.FlameShock:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.FlameShock, 40, "min", EvaluateCycleFlameShock887) then
                    return A.FlameShock:Show(icon) 
                end
            end
            -- lava_burst,if=talent.storm_elemental.enabled&cooldown_react&buff.surge_of_power.up&(expected_combat_length-time-cooldown.storm_elemental.remains-cooldown.storm_elemental.duration*floor((expected_combat_length-time-cooldown.storm_elemental.remains)%cooldown.storm_elemental.duration)<30*(1+(azerite.echo_of_the_elementals.rank>=2))|(1.16*(expected_combat_length-time)-cooldown.storm_elemental.remains-cooldown.storm_elemental.duration*floor((1.16*(expected_combat_length-time)-cooldown.storm_elemental.remains)%cooldown.storm_elemental.duration))<(expected_combat_length-time-cooldown.storm_elemental.remains-cooldown.storm_elemental.duration*floor((expected_combat_length-time-cooldown.storm_elemental.remains)%cooldown.storm_elemental.duration)))
            if A.LavaBurst:IsReady(unit) and (A.StormElemental:IsSpellLearned() and A.LavaBurst:GetCooldown() == 0 and Unit("player"):HasBuffs(A.SurgeofPowerBuff.ID, true) and (expected_combat_length - Unit("player"):CombatTime() - A.StormElemental:GetCooldown() - A.StormElemental:BaseDuration() * math.floor ((expected_combat_length - Unit("player"):CombatTime() - A.StormElemental:GetCooldown()) / A.StormElemental:BaseDuration()) < 30 * (1 + num((A.EchooftheElementals:GetAzeriteRank() >= 2))) or (1.16 * (expected_combat_length - Unit("player"):CombatTime()) - A.StormElemental:GetCooldown() - A.StormElemental:BaseDuration() * math.floor ((1.16 * (expected_combat_length - Unit("player"):CombatTime()) - A.StormElemental:GetCooldown()) / A.StormElemental:BaseDuration())) < (expected_combat_length - Unit("player"):CombatTime() - A.StormElemental:GetCooldown() - A.StormElemental:BaseDuration() * math.floor ((expected_combat_length - Unit("player"):CombatTime() - A.StormElemental:GetCooldown()) / A.StormElemental:BaseDuration())))) then
                return A.LavaBurst:Show(icon)
            end
            
            -- lava_burst,if=!talent.storm_elemental.enabled&cooldown_react&buff.surge_of_power.up&(expected_combat_length-time-cooldown.fire_elemental.remains-cooldown.fire_elemental.duration*floor((expected_combat_length-time-cooldown.fire_elemental.remains)%cooldown.fire_elemental.duration)<30*(1+(azerite.echo_of_the_elementals.rank>=2))|(1.16*(expected_combat_length-time)-cooldown.fire_elemental.remains-cooldown.fire_elemental.duration*floor((1.16*(expected_combat_length-time)-cooldown.fire_elemental.remains)%cooldown.fire_elemental.duration))<(expected_combat_length-time-cooldown.fire_elemental.remains-cooldown.fire_elemental.duration*floor((expected_combat_length-time-cooldown.fire_elemental.remains)%cooldown.fire_elemental.duration)))
            if A.LavaBurst:IsReady(unit) and (not A.StormElemental:IsSpellLearned() and A.LavaBurst:GetCooldown() == 0 and Unit("player"):HasBuffs(A.SurgeofPowerBuff.ID, true) and (expected_combat_length - Unit("player"):CombatTime() - A.FireElemental:GetCooldown() - A.FireElemental:BaseDuration() * math.floor ((expected_combat_length - Unit("player"):CombatTime() - A.FireElemental:GetCooldown()) / A.FireElemental:BaseDuration()) < 30 * (1 + num((A.EchooftheElementals:GetAzeriteRank() >= 2))) or (1.16 * (expected_combat_length - Unit("player"):CombatTime()) - A.FireElemental:GetCooldown() - A.FireElemental:BaseDuration() * math.floor ((1.16 * (expected_combat_length - Unit("player"):CombatTime()) - A.FireElemental:GetCooldown()) / A.FireElemental:BaseDuration())) < (expected_combat_length - Unit("player"):CombatTime() - A.FireElemental:GetCooldown() - A.FireElemental:BaseDuration() * math.floor ((expected_combat_length - Unit("player"):CombatTime() - A.FireElemental:GetCooldown()) / A.FireElemental:BaseDuration())))) then
                return A.LavaBurst:Show(icon)
            end
            
            -- lightning_bolt,if=buff.surge_of_power.up
            if A.LightningBolt:IsReady(unit) and (Unit("player"):HasBuffs(A.SurgeofPowerBuff.ID, true)) then
                return A.LightningBolt:Show(icon)
            end
            
            -- lava_burst,if=cooldown_react&!talent.master_of_the_elements.enabled
            if A.LavaBurst:IsReady(unit) and (A.LavaBurst:GetCooldown() == 0 and not A.MasteroftheElements:IsSpellLearned()) then
                return A.LavaBurst:Show(icon)
            end
            
            -- icefury,if=talent.icefury.enabled&!(maelstrom>75&cooldown.lava_burst.remains<=0)&(!talent.storm_elemental.enabled|cooldown.storm_elemental.remains<cooldown.storm_elemental.duration-30)
            if A.Icefury:IsReady(unit) and (A.Icefury:IsSpellLearned() and not (Player:Maelstrom() > 75 and A.LavaBurst:GetCooldown() <= 0) and (not A.StormElemental:IsSpellLearned() or A.StormElemental:GetCooldown() < A.StormElemental:BaseDuration() - 30)) then
                return A.Icefury:Show(icon)
            end
            
            -- lava_burst,if=cooldown_react&charges>talent.echo_of_the_elements.enabled
            if A.LavaBurst:IsReady(unit) and (A.LavaBurst:GetCooldown() == 0 and A.LavaBurst:GetSpellCharges() > num(A.EchooftheElements:IsSpellLearned())) then
                return A.LavaBurst:Show(icon)
            end
            
            -- frost_shock,if=talent.icefury.enabled&buff.icefury.up&buff.icefury.remains<1.1*gcd*buff.icefury.stack
            if A.FrostShock:IsReady(unit) and (A.Icefury:IsSpellLearned() and Unit("player"):HasBuffs(A.IcefuryBuff.ID, true) and Unit("player"):HasBuffs(A.IcefuryBuff.ID, true) < 1.1 * GetGCD() * Unit("player"):HasBuffsStacks(A.IcefuryBuff.ID, true)) then
                return A.FrostShock:Show(icon)
            end
            
            -- lava_burst,if=cooldown_react
            if A.LavaBurst:IsReady(unit) and (A.LavaBurst:GetCooldown() == 0) then
                return A.LavaBurst:Show(icon)
            end
            
            -- concentrated_flame
            if A.ConcentratedFlame:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth then
                return A.ConcentratedFlame:Show(icon)
            end
            
            -- reaping_flames
            if A.ReapingFlames:IsReady(unit) then
                return A.ReapingFlames:Show(icon)
            end
            
            -- flame_shock,target_if=refreshable&!buff.surge_of_power.up
            if A.FlameShock:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.FlameShock, 40, "min", EvaluateCycleFlameShock1038) then
                    return A.FlameShock:Show(icon) 
                end
            end
            -- totem_mastery,if=talent.totem_mastery.enabled&(buff.resonance_totem.remains<6|(buff.resonance_totem.remains<(buff.ascendance.duration+cooldown.ascendance.remains)&cooldown.ascendance.remains<15))
            if A.TotemMastery:IsReady(unit) and (A.TotemMastery:IsSpellLearned() and (Unit("player"):HasBuffs(A.ResonanceTotemBuff.ID, true) < 6 or (Unit("player"):HasBuffs(A.ResonanceTotemBuff.ID, true) < (A.AscendanceBuff.ID, true:BaseDuration() + A.Ascendance:GetCooldown()) and A.Ascendance:GetCooldown() < 15))) then
                return A.TotemMastery:Show(icon)
            end
            
            -- frost_shock,if=talent.icefury.enabled&buff.icefury.up&(buff.icefury.remains<gcd*4*buff.icefury.stack|buff.stormkeeper.up|!talent.master_of_the_elements.enabled)
            if A.FrostShock:IsReady(unit) and (A.Icefury:IsSpellLearned() and Unit("player"):HasBuffs(A.IcefuryBuff.ID, true) and (Unit("player"):HasBuffs(A.IcefuryBuff.ID, true) < GetGCD() * 4 * Unit("player"):HasBuffsStacks(A.IcefuryBuff.ID, true) or Unit("player"):HasBuffs(A.StormkeeperBuff.ID, true) or not A.MasteroftheElements:IsSpellLearned())) then
                return A.FrostShock:Show(icon)
            end
            
            -- earth_elemental,if=!talent.primal_elementalist.enabled|talent.primal_elementalist.enabled&(cooldown.fire_elemental.remains<(cooldown.fire_elemental.duration-30)&!talent.storm_elemental.enabled|cooldown.storm_elemental.remains<(cooldown.storm_elemental.duration-30)&talent.storm_elemental.enabled)
            -- chain_lightning,if=buff.tectonic_thunder.up&!buff.stormkeeper.up&spell_targets.chain_lightning>1
            if A.ChainLightning:IsReady(unit) and (Unit("player"):HasBuffs(A.TectonicThunderBuff.ID, true) and not Unit("player"):HasBuffs(A.StormkeeperBuff.ID, true) and MultiUnits:GetByRangeInCombat(40, 5, 10) > 1) then
                return A.ChainLightning:Show(icon)
            end
            
            -- lightning_bolt
            if A.LightningBolt:IsReady(unit) then
                return A.LightningBolt:Show(icon)
            end
            
            -- flame_shock,moving=1,target_if=refreshable
            if A.FlameShock:IsReady(unit) and isMoving then
                if Action.Utils.CastTargetIf(A.FlameShock, 40, "min", EvaluateCycleFlameShock1090) then
                    return A.FlameShock:Show(icon) 
                end
            end
            -- flame_shock,moving=1,if=movement.distance>6
            if A.FlameShock:IsReady(unit) and isMoving and (Unit(unit):GetRange() > 6) then
                return A.FlameShock:Show(icon)
            end
            
            -- frost_shock,moving=1
            if A.FrostShock:IsReady(unit) and isMoving then
                return A.FrostShock:Show(icon)
            end
            
        end
        
        
        -- call precombat
        if Precombat(unit) and not inCombat and Unit(unit):IsExists() and unit ~= "mouseover" then 
            return true
        end

        -- In Combat
        if inCombat and Unit(unit):IsExists() then

                    -- potion,if=expected_combat_length-time<60|cooldown.guardian_of_azeroth.remains<30
            if A.PotionofSpectralIntellect:IsReady(unit) and Potion and (expected_combat_length - Unit("player"):CombatTime() < 60 or A.GuardianofAzeroth:GetCooldown() < 30) then
                return A.PotionofSpectralIntellect:Show(icon)
            end
            
            -- wind_shear
            if A.WindShear:IsReady(unit) and Action.GetToggle.InterruptEnabled then
                return A.WindShear:Show(icon)
            end
            
            -- flame_shock,if=!ticking&spell_targets.chainlightning<4&(cooldown.storm_elemental.remains<cooldown.storm_elemental.duration-30|buff.wind_gust.stack<14)
            if A.FlameShock:IsReady(unit) and (not Unit(unit):HasDeBuffs(A.FlameShockDebuff.ID, true) and MultiUnits:GetByRangeInCombat(5, 5, 10) < 4 and (A.StormElemental:GetCooldown() < A.StormElemental:BaseDuration() - 30 or Unit("player"):HasBuffsStacks(A.WindGustBuff.ID, true) < 14)) then
                return A.FlameShock:Show(icon)
            end
            
            -- totem_mastery,if=talent.totem_mastery.enabled&buff.resonance_totem.remains<2
            if A.TotemMastery:IsReady(unit) and (A.TotemMastery:IsSpellLearned() and Unit("player"):HasBuffs(A.ResonanceTotemBuff.ID, true) < 2) then
                return A.TotemMastery:Show(icon)
            end
            
            -- use_items
            -- guardian_of_azeroth,if=dot.flame_shock.ticking&(!talent.storm_elemental.enabled&(cooldown.fire_elemental.duration-30<cooldown.fire_elemental.remains|expected_combat_length-time>190|expected_combat_length-time<32|!(cooldown.fire_elemental.remains+30<expected_combat_length-time)|cooldown.fire_elemental.remains<2)|talent.storm_elemental.enabled&(cooldown.storm_elemental.duration-30<cooldown.storm_elemental.remains|expected_combat_length-time>190|expected_combat_length-time<35|!(cooldown.storm_elemental.remains+30<expected_combat_length-time)|cooldown.storm_elemental.remains<2))
            if A.GuardianofAzeroth:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and (Unit(unit):HasDeBuffs(A.FlameShockDebuff.ID, true) and (not A.StormElemental:IsSpellLearned() and (A.FireElemental:BaseDuration() - 30 < A.FireElemental:GetCooldown() or expected_combat_length - Unit("player"):CombatTime() > 190 or expected_combat_length - Unit("player"):CombatTime() < 32 or not (A.FireElemental:GetCooldown() + 30 < expected_combat_length - Unit("player"):CombatTime()) or A.FireElemental:GetCooldown() < 2) or A.StormElemental:IsSpellLearned() and (A.StormElemental:BaseDuration() - 30 < A.StormElemental:GetCooldown() or expected_combat_length - Unit("player"):CombatTime() > 190 or expected_combat_length - Unit("player"):CombatTime() < 35 or not (A.StormElemental:GetCooldown() + 30 < expected_combat_length - Unit("player"):CombatTime()) or A.StormElemental:GetCooldown() < 2))) then
                return A.GuardianofAzeroth:Show(icon)
            end
            
            -- fire_elemental,if=!talent.storm_elemental.enabled&(!essence.condensed_lifeforce.major|cooldown.guardian_of_azeroth.remains>150|expected_combat_length-time<30|expected_combat_length-time<60|expected_combat_length-time>155|!(cooldown.guardian_of_azeroth.remains+30<expected_combat_length-time))
            if A.FireElemental:IsReady(unit) and A.BurstIsON(unit) and (not A.StormElemental:IsSpellLearned() and (not Azerite:EssenceHasMajor(A.CondensedLifeforce.ID) or A.GuardianofAzeroth:GetCooldown() > 150 or expected_combat_length - Unit("player"):CombatTime() < 30 or expected_combat_length - Unit("player"):CombatTime() < 60 or expected_combat_length - Unit("player"):CombatTime() > 155 or not (A.GuardianofAzeroth:GetCooldown() + 30 < expected_combat_length - Unit("player"):CombatTime()))) then
                return A.FireElemental:Show(icon)
            end
            
            -- focused_azerite_beam
            if A.FocusedAzeriteBeam:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth then
                return A.FocusedAzeriteBeam:Show(icon)
            end
            
            -- purifying_blast
            if A.PurifyingBlast:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth then
                return A.PurifyingBlast:Show(icon)
            end
            
            -- the_unbound_force
            if A.TheUnboundForce:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth then
                return A.TheUnboundForce:Show(icon)
            end
            
            -- memory_of_lucid_dreams
            if A.MemoryofLucidDreams:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth then
                return A.MemoryofLucidDreams:Show(icon)
            end
            
            -- ripple_in_space
            if A.RippleInSpace:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth then
                return A.RippleInSpace:Show(icon)
            end
            
            -- worldvein_resonance,if=(talent.unlimited_power.enabled|buff.stormkeeper.up|talent.ascendance.enabled&((talent.storm_elemental.enabled&cooldown.storm_elemental.remains<(cooldown.storm_elemental.duration-30)&cooldown.storm_elemental.remains>15|!talent.storm_elemental.enabled)&(!talent.icefury.enabled|!buff.icefury.up&!cooldown.icefury.up))|!cooldown.ascendance.up)
            if A.WorldveinResonance:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and ((A.UnlimitedPower:IsSpellLearned() or Unit("player"):HasBuffs(A.StormkeeperBuff.ID, true) or A.Ascendance:IsSpellLearned() and ((A.StormElemental:IsSpellLearned() and A.StormElemental:GetCooldown() < (A.StormElemental:BaseDuration() - 30) and A.StormElemental:GetCooldown() > 15 or not A.StormElemental:IsSpellLearned()) and (not A.Icefury:IsSpellLearned() or not Unit("player"):HasBuffs(A.IcefuryBuff.ID, true) and not A.Icefury:GetCooldown() == 0)) or not A.Ascendance:GetCooldown() == 0)) then
                return A.WorldveinResonance:Show(icon)
            end
            
            -- blood_of_the_enemy,if=talent.storm_elemental.enabled&pet.primal_storm_elemental.active
            if A.BloodoftheEnemy:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and (A.StormElemental:IsSpellLearned() and pet.primal_storm_elemental.active) then
                return A.BloodoftheEnemy:Show(icon)
            end
            
            -- storm_elemental,if=talent.storm_elemental.enabled&(!cooldown.stormkeeper.up|!talent.stormkeeper.enabled)&(!talent.icefury.enabled|!buff.icefury.up&!cooldown.icefury.up)&(!talent.ascendance.enabled|!buff.ascendance.up|expected_combat_length-time<32)&(!essence.condensed_lifeforce.major|cooldown.guardian_of_azeroth.remains>150|expected_combat_length-time<30|expected_combat_length-time<60|expected_combat_length-time>155|!(cooldown.guardian_of_azeroth.remains+30<expected_combat_length-time))
            if A.StormElemental:IsReady(unit) and A.BurstIsON(unit) and (A.StormElemental:IsSpellLearned() and (not A.Stormkeeper:GetCooldown() == 0 or not A.Stormkeeper:IsSpellLearned()) and (not A.Icefury:IsSpellLearned() or not Unit("player"):HasBuffs(A.IcefuryBuff.ID, true) and not A.Icefury:GetCooldown() == 0) and (not A.Ascendance:IsSpellLearned() or not Unit("player"):HasBuffs(A.AscendanceBuff.ID, true) or expected_combat_length - Unit("player"):CombatTime() < 32) and (not Azerite:EssenceHasMajor(A.CondensedLifeforce.ID) or A.GuardianofAzeroth:GetCooldown() > 150 or expected_combat_length - Unit("player"):CombatTime() < 30 or expected_combat_length - Unit("player"):CombatTime() < 60 or expected_combat_length - Unit("player"):CombatTime() > 155 or not (A.GuardianofAzeroth:GetCooldown() + 30 < expected_combat_length - Unit("player"):CombatTime()))) then
                return A.StormElemental:Show(icon)
            end
            
            -- blood_fury,if=!talent.ascendance.enabled|buff.ascendance.up|cooldown.ascendance.remains>50
            if A.BloodFury:AutoRacial(unit) and Racial and A.BurstIsON(unit) and (not A.Ascendance:IsSpellLearned() or Unit("player"):HasBuffs(A.AscendanceBuff.ID, true) or A.Ascendance:GetCooldown() > 50) then
                return A.BloodFury:Show(icon)
            end
            
            -- berserking,if=!talent.ascendance.enabled|buff.ascendance.up
            if A.Berserking:AutoRacial(unit) and Racial and A.BurstIsON(unit) and (not A.Ascendance:IsSpellLearned() or Unit("player"):HasBuffs(A.AscendanceBuff.ID, true)) then
                return A.Berserking:Show(icon)
            end
            
            -- fireblood,if=!talent.ascendance.enabled|buff.ascendance.up|cooldown.ascendance.remains>50
            if A.Fireblood:AutoRacial(unit) and Racial and A.BurstIsON(unit) and (not A.Ascendance:IsSpellLearned() or Unit("player"):HasBuffs(A.AscendanceBuff.ID, true) or A.Ascendance:GetCooldown() > 50) then
                return A.Fireblood:Show(icon)
            end
            
            -- ancestral_call,if=!talent.ascendance.enabled|buff.ascendance.up|cooldown.ascendance.remains>50
            if A.AncestralCall:AutoRacial(unit) and Racial and A.BurstIsON(unit) and (not A.Ascendance:IsSpellLearned() or Unit("player"):HasBuffs(A.AscendanceBuff.ID, true) or A.Ascendance:GetCooldown() > 50) then
                return A.AncestralCall:Show(icon)
            end
            
            -- bag_of_tricks,if=!talent.ascendance.enabled|!buff.ascendance.up
            if A.BagofTricks:IsReady(unit) and (not A.Ascendance:IsSpellLearned() or not Unit("player"):HasBuffs(A.AscendanceBuff.ID, true)) then
                return A.BagofTricks:Show(icon)
            end
            
            -- run_action_list,name=aoe,if=active_enemies>2&(spell_targets.chain_lightning>2|spell_targets.lava_beam>2)
            if (MultiUnits:GetByRangeInCombat(40, 5, 10) > 2 and (MultiUnits:GetByRangeInCombat(40, 5, 10) > 2 or MultiUnits:GetByRangeInCombat(5, 5, 10) > 2)) then
                return Aoe(unit);
            end
            
            -- run_action_list,name=funnel,if=active_enemies>=2&(spell_targets.chain_lightning<2|spell_targets.lava_beam<2)
            if (MultiUnits:GetByRangeInCombat(40, 5, 10) >= 2 and (MultiUnits:GetByRangeInCombat(40, 5, 10) < 2 or MultiUnits:GetByRangeInCombat(5, 5, 10) < 2)) then
                return Funnel(unit);
            end
            
            -- run_action_list,name=single_target,if=active_enemies<=2
            if (MultiUnits:GetByRangeInCombat(40, 5, 10) <= 2) then
                return SingleUnitunit(unit);
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

