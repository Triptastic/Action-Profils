-------------------------------
-- Taste TMW Action Rotation --
-------------------------------
local _G, setmetatable							= _G, setmetatable
local A                         			    = _G.Action
local Listener									= Action.Listener
local Create									= Action.Create
local GetToggle									= Action.GetToggle
local SetToggle									= Action.SetToggle
local GetGCD									= Action.GetGCD
local GetCurrentGCD								= Action.GetCurrentGCD
local GetPing									= Action.GetPing
local ShouldStop								= Action.ShouldStop
local BurstIsON									= Action.BurstIsON
local AuraIsValid								= Action.AuraIsValid
local InterruptIsValid							= Action.InterruptIsValid
local FrameHasSpell								= Action.FrameHasSpell
--local Azerite									= LibStub("AzeriteTraits")
local Utils										= Action.Utils
local TeamCache									= Action.TeamCache
local EnemyTeam									= Action.EnemyTeam
local FriendlyTeam								= Action.FriendlyTeam
local LoC										= Action.LossOfControl
local Player									= Action.Player 
local MultiUnits								= Action.MultiUnits
local UnitCooldown								= Action.UnitCooldown
local Unit										= Action.Unit 
local IsUnitEnemy								= Action.IsUnitEnemy
local IsUnitFriendly							= Action.IsUnitFriendly
local ActiveUnitPlates							= MultiUnits:GetActiveUnitPlates()
local IsIndoors, UnitIsUnit                     = IsIndoors, UnitIsUnit
local TR                                        = Action.TasteRotation
local pairs                                     = pairs
local Pet                                       = LibStub("PetLibrary")

--- ============================ CONTENT ===========================
--- ======= APL LOCALS =======
-- luacheck: max_line_length 9999

-- Spells
Action[ACTION_CONST_SHAMAN_ELEMENTAL] = {
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
    BagofTricks                            = Action.Create({ Type = "Spell", ID = 312411    }),
    WilloftheForsaken                      = Action.Create({ Type = "Spell", ID = 7744        }), -- not usable in APL but user can Queue it   
    EscapeArtist                           = Action.Create({ Type = "Spell", ID = 20589    }), -- not usable in APL but user can Queue it
    EveryManforHimself                     = Action.Create({ Type = "Spell", ID = 59752    }), -- not usable in APL but user can Queue it
    -- Generics
    TotemMastery                           = Action.Create({ Type = "Spell", ID = 210643 }),
    AncestralGuidance                      = Action.Create({ Type = "Spell", ID = 108281 }),
    StormkeeperBuff                        = Action.Create({ Type = "Spell", ID = 191634, Hidden = true     }),
    Stormkeeper                            = Action.Create({ Type = "Spell", ID = 191634 }),
    FireElemental                          = Action.Create({ Type = "Spell", ID = 198067 }),
    StormElemental                         = Action.Create({ Type = "Spell", ID = 192249 }),
    ElementalBlast                         = Action.Create({ Type = "Spell", ID = 117014 }),
    LavaBurst                              = Action.Create({ Type = "Spell", ID = 51505 }),
    ChainLightning                         = Action.Create({ Type = "Spell", ID = 188443 }),
    FlameShock                             = Action.Create({ Type = "Spell", ID = 188389 }),
    FlameShockDebuff                       = Action.Create({ Type = "Spell", ID = 188389, Hidden = true }),
    WindGustBuff                           = Action.Create({ Type = "Spell", ID = 263806, Hidden = true     }),
    Ascendance                             = Action.Create({ Type = "Spell", ID = 114050 }),
    Icefury                                = Action.Create({ Type = "Spell", ID = 210714 }),
    IcefuryBuff                            = Action.Create({ Type = "Spell", ID = 210714, Hidden = true     }),
    LiquidMagmaTotem                       = Action.Create({ Type = "Spell", ID = 192222 }),
    Earthquake                             = Action.Create({ Type = "Spell", ID = 61882 }),
    MasteroftheElements                    = Action.Create({ Type = "Spell", ID = 16166 }),
    MasteroftheElementsBuff                = Action.Create({ Type = "Spell", ID = 260734 , Hidden = true     }),
    LavaSurgeBuff                          = Action.Create({ Type = "Spell", ID = 77762 , Hidden = true     }),
    AscendanceBuff                         = Action.Create({ Type = "Spell", ID = 114050 , Hidden = true     }),
    FrostShock                             = Action.Create({ Type = "Spell", ID = 196840 }),
    LavaBeam                               = Action.Create({ Type = "Spell", ID = 114074 }),
    IgneousPotential                       = Action.Create({ Type = "Spell", ID = 279829 }),
    SurgeofPowerBuff                       = Action.Create({ Type = "Spell", ID = 285514 , Hidden = true     }),
    NaturalHarmony                         = Action.Create({ Type = "Spell", ID = 278697 }),
    SurgeofPower                           = Action.Create({ Type = "Spell", ID = 262303 }),
    LightningBolt                          = Action.Create({ Type = "Spell", ID = 188196 }),
    LavaShock                              = Action.Create({ Type = "Spell", ID = 273448 }),
    LavaShockBuff                          = Action.Create({ Type = "Spell", ID = 273453 , Hidden = true     }),
    EarthShock                             = Action.Create({ Type = "Spell", ID = 8042 }),
    CalltheThunder                         = Action.Create({ Type = "Spell", ID = 260897 }),
    EchooftheElementals                    = Action.Create({ Type = "Spell", ID = 275381 }),
    EchooftheElements                      = Action.Create({ Type = "Spell", ID = 108283 }),
    ResonanceTotemBuff                     = Action.Create({ Type = "Spell", ID = 202192 , Hidden = true     }),
    TectonicThunder                        = Action.Create({ Type = "Spell", ID = 286949 }),
    TectonicThunderBuff                    = Action.Create({ Type = "Spell", ID = 286949 , Hidden = true     }),
	UnlimitedPower                         = Action.Create({ Type = "Spell", ID = 260895}),
    WindShear                              = Action.Create({ Type = "Spell", ID = 57994 }),
    BloodFury                              = Action.Create({ Type = "Spell", ID = 20572 }),
    Berserking                             = Action.Create({ Type = "Spell", ID = 26297 }),
    Fireblood                              = Action.Create({ Type = "Spell", ID = 265221 }),
    AncestralCall                          = Action.Create({ Type = "Spell", ID = 274738 }),
    EarthElemental                         = Action.Create({ Type = "Spell", ID = 198103 }), -- Earth Elemental manual queue
    -- Utilities
    LightningLasso                         = Action.Create({ Type = "Spell", ID = 305483     }),
    CapacitorTotem                         = Action.Create({ Type = "Spell", ID = 192058     }),
    Purge                                  = Action.Create({ Type = "Spell", ID = 370     }),
    GhostWolf                              = Action.Create({ Type = "Spell", ID = 2645     }),
    EarthShield                            = Action.Create({ Type = "Spell", ID = 974     }),
    HealingSurge                           = Action.Create({ Type = "Spell", ID = 8004     }),
    PrimalElementalist                     = Action.Create({ Type = "Spell", ID = 117013 , Hidden = true     }),
    GhostWolfBuff                          = Action.Create({ Type = "Spell", ID = 2645, Hidden = true     }),    
    -- Storm Elemental   
    EyeOfTheStorm                          = Action.Create({ Type = "Spell", ID = 157375 , Hidden = true     }), 
    CallLightning                          = Action.Create({ Type = "Spell", ID = 157348 , Hidden = true     }),
    -- Defensive
    AstralShift                            = Action.Create({ Type = "Spell", ID = 108271     }),    
    ShiverVenomDebuff                      = Action.Create({ Type = "Spell", ID = 301624, Hidden = true     }),
	CleanseSpirit                          = Action.Create({ Type = "Spell", ID = 51886     }), -- PartyDispell
	-- Oils
	EmbalmersOil                           = Action.Create({ Type = "Spell", ID = 171286, QueueForbidden = true }), 
    ShadowcoreOil                          = Action.Create({ Type = "Spell", ID = 171285, QueueForbidden = true }),  
    -- Potions
	-- stats
    PotionofSpectralAgility                = Action.Create({ Type = "Potion", ID = 171270, QueueForbidden = true }), 
    PotionofSpectralIntellect              = Action.Create({ Type = "Potion", ID = 171273, QueueForbidden = true }), 
	PotionofSpectralStrength               = Action.Create({ Type = "Potion", ID = 171275, QueueForbidden = true }), 
	PotionofSpectralStamina                = Action.Create({ Type = "Potion", ID = 171274, QueueForbidden = true }), 
	-- heal
	SpiritualHealingPotion                 = Action.Create({ Type = "Potion", ID = 171267, QueueForbidden = true }), 
	SpiritualManaPotion                    = Action.Create({ Type = "Potion", ID = 171268, QueueForbidden = true }), 
	SpiritualRejuvenationPotion            = Action.Create({ Type = "Potion", ID = 171269, QueueForbidden = true }), 
	PotionofSpiritualClarity               = Action.Create({ Type = "Potion", ID = 171272, QueueForbidden = true }), 
	-- combat effects potions
	PotionofDeathlyFixation                = Action.Create({ Type = "Potion", ID = 171351, QueueForbidden = true }), 
    PotionofEmpoweredExorcisms             = Action.Create({ Type = "Potion", ID = 171352, QueueForbidden = true }),
	PotionofPhantomFire                    = Action.Create({ Type = "Potion", ID = 171349, QueueForbidden = true }),
	PotionofDivineAwakening                = Action.Create({ Type = "Potion", ID = 171350, QueueForbidden = true }),
	PotionofSacrificialAnima               = Action.Create({ Type = "Potion", ID = 176811, QueueForbidden = true }),
    -- utilities potions
	PotionofHardenedShadows                = Action.Create({ Type = "Potion", ID = 171271, QueueForbidden = true }),
    PotionofShadedSight                    = Action.Create({ Type = "Potion", ID = 171264, QueueForbidden = true }),
    PotionofSoulPurity                     = Action.Create({ Type = "Potion", ID = 171263, QueueForbidden = true }),
    PotionofSpecterSwiftness               = Action.Create({ Type = "Potion", ID = 171370, QueueForbidden = true }),
    PotionoftheHiddenSpirit                = Action.Create({ Type = "Potion", ID = 171266, QueueForbidden = true }),
    PotionofthePsychopompsSpeed            = Action.Create({ Type = "Potion", ID = 184090, QueueForbidden = true }),
    PotionofUnhinderedPassing              = Action.Create({ Type = "Potion", ID = 183823, QueueForbidden = true }),
    -- Nathria Trinkets
	SanguineVintage                        = Action.Create({ Type = "Trinket", ID = 184031 }),
	ManaboundMirror                        = Action.Create({ Type = "Trinket", ID = 184029 }),
	GluttonousSpike                        = Action.Create({ Type = "Trinket", ID = 184023 }),
	DreadfireVessel                        = Action.Create({ Type = "Trinket", ID = 184030 }),
	MemoryofPastSins                       = Action.Create({ Type = "Trinket", ID = 184025 }),
	ConsumptiveInfusion                    = Action.Create({ Type = "Trinket", ID = 184022 }),
	StoneLegionHeraldry                    = Action.Create({ Type = "Trinket", ID = 184027 }),
	BargastsLeash                          = Action.Create({ Type = "Trinket", ID = 184017 }),
	-- OP Dungeons Trinkets
	BloodSpatteredScale                    = Action.Create({ Type = "Trinket", ID = 179331 }),
	OverwhelmingPowerCrystal               = Action.Create({ Type = "Trinket", ID = 179342 }),
	SunbloodAmethyst                       = Action.Create({ Type = "Trinket", ID = 178826 }),
	PulsatingStoneheart                    = Action.Create({ Type = "Trinket", ID = 178825 }),
	BladedancersArmorKit                   = Action.Create({ Type = "Trinket", ID = 178862 }), 
    -- Misc
    Channeling                             = Action.Create({ Type = "Spell", ID = 209274, Hidden = true     }),    -- Show an icon during channeling
    TargetEnemy                            = Action.Create({ Type = "Spell", ID = 44603, Hidden = true     }),    -- Change Target (Tab button)
    StopCast                               = Action.Create({ Type = "Spell", ID = 61721, Hidden = true     }),        -- spell_magic_polymorphrabbit  
};

-- To create essences use next code:
--Action:CreateEssencesFor(ACTION_CONST_SHAMAN_ELEMENTAL)  -- where PLAYERSPEC is Constance (example: ACTION_CONST_MONK_BM)
local A = setmetatable(Action[ACTION_CONST_SHAMAN_ELEMENTAL], { __index = Action })

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

local IsIndoors, UnitIsUnit, UnitName = IsIndoors, UnitIsUnit, UnitName

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

--- ======= ACTION LISTS =======
-- [3] Single Rotation
A[3] = function(icon, isMulti)
    --------------------
    --- ROTATION VAR ---
    --------------------
    local isMoving = Player:IsMoving()
    local inCombat = Unit("player"):CombatTime() > 0
    local ShouldStop = Action.ShouldStop()
    local Pull = Action.BossMods:GetPullTimer()
    local AppliedFlameShock = MultiUnits:GetByRangeAppliedDoTs(Action.GetToggle(2, "MultiDotDistance"), 5, 188389) --MultiDots(40, A.FlameShockDebuff, 15, 4) --MultiUnits:GetByRangeMissedDoTs(40, 10, 188389)  MultiUnits:GetByRangeMissedDoTs(range, stop, dots, ttd)
    local FlameShockToRefresh = MultiUnits:GetByRangeDoTsToRefresh(Action.GetToggle(2, "MultiDotDistance"), 5, 188389, 5)
    local MissingFlameShock = MultiUnits:GetByRangeMissedDoTs(Action.GetToggle(2, "MultiDotDistance"), 5, 188389) --MultiDots(40, A.FlameShockDebuff, 15, 4) --MultiUnits:GetByRangeMissedDoTs(40, 10, 188389)  MultiUnits:GetByRangeMissedDoTs(range, stop, dots, ttd)
    local CanMultidot = HandleMultidots()
    local expected_combat_length = ExpectedCombatLength()
    
    --print(ResonanceTotemTime())
    --print(Unit("player"):HasHeroism())
    ------------------------------------------------------
    ---------------- ENEMY UNIT ROTATION -----------------
    ------------------------------------------------------
    local function EnemyRotation(unit)

    	-- Interrupt
        local Interrupt = Interrupts(unit)
        if Interrupt then 
            return Interrupt:Show(icon)
        end	

        --Precombat
        local function Precombat(unit)
            -- flask
            -- food
            -- augmentation
            -- snapshot_stats
            -- totem_mastery
            if A.TotemMastery:IsReady("player") and A.LastPlayerCastName ~= A.TotemMastery:Info() and ResonanceTotemTime() < 6 then
                return A.TotemMastery:Show(icon)
            end
			
            -- earth_elemental,if=!talent.primal_elementalist.enabled
            -- stormkeeper,if=talent.stormkeeper.enabled&(raid_event.adds.count<3|raid_event.adds.in>50)
            if A.Stormkeeper:IsReady(unit) and not isMoving and Unit("player"):HasBuffsDown(A.StormkeeperBuff.ID, true) and A.Stormkeeper:IsSpellLearned() then
                if HandleStormkeeper() then 
                    return A.Stormkeeper:Show(icon)
                end
            end
			
            -- fire_elemental,if=!talent.storm_elemental.enabled
            if A.FireElemental:IsReady(unit) and A.BurstIsON(unit) and (not A.StormElemental:IsSpellLearned()) then
                return A.FireElemental:Show(icon)
            end
			
            -- storm_elemental,if=talent.storm_elemental.enabled
            --if A.StormElemental:IsReady(unit) and A.BurstIsON(unit) and (A.StormElemental:IsSpellLearned()) then
            --    return A.StormElemental:Show(icon)
            --end
			
            -- potion
            if A.PotionofUnbridledFury:IsReady(unit) and Action.GetToggle(1, "Potion") and
            ((Pull > 0.1 and Pull <= A.LavaBurst:GetSpellCastTime() + A.GetGCD()) or not Action.GetToggle(1, "BossMods")) then
                return A.PotionofUnbridledFury:Show(icon)
            end
			
            -- chain_lightning,if=spell_targets.chain_lightning>2
            if A.ChainLightning:IsReady(unit) and Action.GetToggle(1, "AoE") and (MultiUnits:GetByRange(40) > 1 or A.GetToggle(2, "ForceAoE")) and
            ((Pull > 0.1 and Pull <= A.ChainLightning:GetSpellCastTime()) or not Action.GetToggle(1, "BossMods")) then
                return A.ChainLightning:Show(icon)
            end 
			
            -- elemental_blast,if=talent.elemental_blast.enabled
            if A.ElementalBlast:IsReady(unit) and (A.ElementalBlast:IsSpellLearned()) and
            ((Pull > 0.1 and Pull <= A.ElementalBlast:GetSpellCastTime()) or not Action.GetToggle(1, "BossMods")) then
                return A.ElementalBlast:Show(icon)
            end
			
            -- lava_burst,if=!talent.elemental_blast.enabled&spell_targets.chain_lightning<3
            if A.LavaBurst:IsReady(unit) and (not A.ElementalBlast:IsSpellLearned()) and not A.GetToggle(2, "ForceAoE") and
            ((Pull > 0.1 and Pull <= A.LavaBurst:GetSpellCastTime()) or not Action.GetToggle(1, "BossMods")) then
                return A.LavaBurst:Show(icon)
            end
        end
        
        --Aoe
        local function Aoe(unit)
            -- stormkeeper,if=talent.stormkeeper.enabled
            if A.Stormkeeper:IsReady("player") and not isMoving and (A.Stormkeeper:IsSpellLearned()) then
                if HandleStormkeeper() then 
                    return A.Stormkeeper:Show(icon)
                end
            end
			
            -- 5 Eye of the Storm if Storm Elemental is up and we got Primal Elementalists
            if A.EyeOfTheStorm:IsReady(unit) and A.EyeOfTheStorm:GetCooldown() < 0.1 and A.PrimalElementalist:IsSpellLearned() and A.BurstIsON(unit) and Pet:IsActive(77942) and A.CallLightning:GetCooldown() > 0.1 then
                return A.EyeOfTheStorm:Show(icon)
            end
			
            -- ascendance,if=talent.ascendance.enabled&(time>=60|buff.bloodlust.up)&cooldown.lava_burst.remains>0&(cooldown.storm_elemental.remains<120|!talent.storm_elemental.enabled)&(!talent.icefury.enabled|!buff.icefury.up&!cooldown.icefury.up)
            if A.Ascendance:IsReady("player") and A.Ascendance:IsSpellLearned() and A.BurstIsON(unit) and 
			(
			    (Unit("player"):CombatTime() >= 60 or Unit("player"):HasHeroism()) 
				and 
				A.LavaBurst:GetCooldown() > 0 and (A.StormElemental:IsSpellLearned() and A.StormElemental:GetCooldown() < 120 or not A.StormElemental:IsSpellLearned()) 
				or 
				(not A.Icefury:IsSpellLearned() or not Unit("player"):HasBuffs(A.IcefuryBuff.ID, true) and not A.Icefury:GetCooldown() == 0) 
			)
			then 
                return A.Ascendance:Show(icon)
            end
            
            -- ascendance,if=talent.ascendance.enabled&(talent.storm_elemental.enabled&cooldown.storm_elemental.remains<120&cooldown.storm_elemental.remains>15|!talent.storm_elemental.enabled)&(!talent.icefury.enabled|!buff.icefury.up&!cooldown.icefury.up)
            --if A.Ascendance:IsReady("player") and A.BurstIsON(unit) and (A.Ascendance:IsSpellLearned() and (A.StormElemental:IsSpellLearned() and A.StormElemental:GetCooldown() < 120 and A.StormElemental:GetCooldown() > 15 or not A.StormElemental:IsSpellLearned()) and (not A.Icefury:IsSpellLearned() or not Unit("player"):HasBuffs(A.IcefuryBuff.ID, true) and not A.Icefury:GetCooldown() == 0)) then
            -- return A.Ascendance:Show(icon)
            --end
            
            -- liquid_magma_totem,if=talent.liquid_magma_totem.enabled
            if A.LiquidMagmaTotem:IsReady(unit) and (A.LiquidMagmaTotem:IsSpellLearned()) then
                return A.LiquidMagmaTotem:Show(icon)
            end
			
            -- earthquake,if=!talent.master_of_the_elements.enabled|buff.stormkeeper.up|maelstrom>=(100-4*spell_targets.chain_lightning)|buff.master_of_the_elements.up|spell_targets.chain_lightning>3
            if A.Earthquake:IsReady("player") and Player:Maelstrom() >= 60 then
                return A.Earthquake:Show(icon)
            end
			
            -- chain_lightning,if=buff.stormkeeper.remains<3*gcd*buff.stormkeeper.stack
            if A.ChainLightning:IsReady(unit) and MultiUnits:GetActiveEnemies() > 2 and (not isMoving or Unit("player"):HasBuffs(A.StormkeeperBuff.ID, true) > 1) and Player:Maelstrom() < 90 then
                return A.ChainLightning:Show(icon)
            end
			
            -- lava_burst,if=buff.lava_surge.up&spell_targets.chain_lightning<4&(!talent.storm_elemental.enabled|cooldown.storm_elemental.remains<120)&dot.flame_shock.ticking
            if A.LavaBurst:IsReady(unit) and not Pet:IsActive(77942) and (not isMoving or Unit("player"):HasBuffs(A.LavaSurgeBuff.ID, true) > 0) and Unit(unit):HasDeBuffs(A.FlameShockDebuff.ID, true) > 0 then
                return A.LavaBurst:Show(icon)
            end
			
            -- icefury,if=spell_targets.chain_lightning<4&!buff.ascendance.up
            if A.Icefury:IsReady(unit) and not isMoving and (MultiUnits:GetActiveEnemies() < 4 and Unit("player"):HasBuffs(A.AscendanceBuff.ID, true) == 0) then
                return A.Icefury:Show(icon)
            end
			
            -- frost_shock,if=spell_targets.chain_lightning<4&buff.icefury.up&!buff.ascendance.up
            if A.FrostShock:IsReady(unit) and (MultiUnits:GetActiveEnemies() < 4 and Unit("player"):HasBuffs(A.IcefuryBuff.ID, true) > 0 and Unit("player"):HasBuffs(A.AscendanceBuff.ID, true) == 0) then
                return A.FrostShock:Show(icon)
            end
			
            -- elemental_blast,if=talent.elemental_blast.enabled&spell_targets.chain_lightning<4&(!talent.storm_elemental.enabled|cooldown.storm_elemental.remains<120)
            if A.ElementalBlast:IsReady(unit) and not isMoving and (A.ElementalBlast:IsSpellLearned() and MultiUnits:GetActiveEnemies() < 4 and (not A.StormElemental:IsSpellLearned() or A.StormElemental:GetCooldown() < 120)) then
                return A.ElementalBlast:Show(icon)
            end
			
            -- lava_beam,if=talent.ascendance.enabled
            if A.LavaBeam:IsReady(unit) and (A.Ascendance:IsSpellLearned()) then
                return A.LavaBeam:Show(icon)
            end
			
            -- lava_burst,moving=1,if=talent.ascendance.enabled
            if A.LavaBurst:IsReady(unit) and not Pet:IsActive(77942) and isMoving and (A.Ascendance:IsSpellLearned()) then
                return A.LavaBurst:Show(icon)
            end
			
            -- flame_shock,moving=1,target_if=refreshable
            if A.FlameShock:IsReady(unit) and HandleFlameShockTTD() and isMoving then
                if (Unit(unit):HasDeBuffs(A.FlameShockDebuff.ID, true) == 0 or Unit(unit):HasDeBuffs(A.FlameShockDebuff.ID, true) <= 7) then
                    return A.FlameShock:Show(icon) 
                end
            end
			
            -- frost_shock,moving=1
            if A.FrostShock:IsReady(unit) and isMoving then
                return A.FrostShock:Show(icon)
            end
        end
        
        -- MasteroftheElements Build
        local function MOTE(unit)
		
            -- flame_shock,target_if=(!ticking|talent.storm_elemental.enabled&cooldown.storm_elemental.remains<2*gcd|dot.flame_shock.remains<=gcd|talent.ascendance.enabled&dot.flame_shock.remains<(cooldown.ascendance.remains+buff.ascendance.duration)&cooldown.ascendance.remains<4&(!talent.storm_elemental.enabled|talent.storm_elemental.enabled&cooldown.storm_elemental.remains<120))&(buff.wind_gust.stack<14|azerite.igneous_potential.rank>=2|buff.lava_surge.up|!buff.bloodlust.up)&!buff.surge_of_power.up
            if A.FlameShock:IsReady(unit) then
                if (Unit(unit):HasDeBuffs(A.FlameShockDebuff.ID, true) == 0 or A.StormElemental:IsSpellLearned() 
                    and A.StormElemental:GetCooldown() < 2 * A.GetGCD() or Unit(unit):HasDeBuffs(A.FlameShockDebuff.ID, true) <= 7 or A.Ascendance:IsSpellLearned() 
                    and Unit(unit):HasDeBuffs(A.FlameShockDebuff.ID, true) < (A.Ascendance:GetCooldown() + 15) and A.Ascendance:GetCooldown() < 4 
                    and (not A.StormElemental:IsSpellLearned() or A.StormElemental:IsSpellLearned() and A.StormElemental:GetCooldown() < 120)) 
                and (Unit("player"):HasBuffsStacks(A.WindGustBuff.ID, true) < 14 or A.IgneousPotential:GetAzeriteRank() >= 2 or Unit("player"):HasBuffs(A.LavaSurgeBuff.ID, true) > 0 
                    or not Unit("player"):HasHeroism()) and Unit("player"):HasBuffs(A.SurgeofPowerBuff.ID, true) == 0 
                then
                    if (Unit(unit):HasDeBuffs(A.FlameShockDebuff.ID, true) == 0 or Unit(unit):HasDeBuffs(A.FlameShockDebuff.ID, true) <= 7) then
                        return A.FlameShock:Show(icon) 
                    end
                end
            end
			
            -- ascendance,if=talent.ascendance.enabled&(time>=60|buff.bloodlust.up)&cooldown.lava_burst.remains>0&(cooldown.storm_elemental.remains<120|!talent.storm_elemental.enabled)&(!talent.icefury.enabled|!buff.icefury.up&!cooldown.icefury.up)
            if A.Ascendance:IsReady("player") and not ShouldStop and A.BurstIsON(unit) and A.Ascendance:IsSpellLearned() and 
			( 
                (Unit("player"):CombatTime() >= 60 or Unit("player"):HasHeroism()) and A.LavaBurst:GetCooldown() > 0 
                and (A.StormElemental:GetCooldown() < 120 or not A.StormElemental:IsSpellLearned()) and 
				(not A.Icefury:IsSpellLearned() or Unit("player"):HasBuffs(A.IcefuryBuff.ID, true) == 0 and A.Icefury:GetCooldown() > 0)
			) 
            then
                return A.Ascendance:Show(icon)
            end
			
            -- elemental_blast,if=talent.elemental_blast.enabled&(talent.master_of_the_elements.enabled&buff.master_of_the_elements.up&maelstrom<60|!talent.master_of_the_elements.enabled)&(!(cooldown.storm_elemental.remains>120&talent.storm_elemental.enabled)|azerite.natural_harmony.rank=3&buff.wind_gust.stack<14)
            if A.ElementalBlast:IsReady(unit) and not ShouldStop and (A.ElementalBlast:IsSpellLearned() and (A.MasteroftheElements:IsSpellLearned() and Unit("player"):HasBuffs(A.MasteroftheElementsBuff.ID, true) > 0 and Player:Maelstrom() < 60 or not A.MasteroftheElements:IsSpellLearned()) and (not (A.StormElemental:GetCooldown() > 120 and A.StormElemental:IsSpellLearned()) or A.NaturalHarmony:GetAzeriteRank() == 3 and Unit("player"):HasBuffsStacks(A.WindGustBuff.ID, true) < 14)) then
                return A.ElementalBlast:Show(icon)
            end
			
            -- stormkeeper,if=talent.stormkeeper.enabled&(raid_event.adds.count<3|raid_event.adds.in>50)&(!talent.surge_of_power.enabled|buff.surge_of_power.up|maelstrom>=44)
            if A.Stormkeeper:IsReady(unit) and not isMoving and not ShouldStop 
            and (A.Stormkeeper:IsSpellLearned() and ((MultiUnits:GetActiveEnemies() - 1) < 3) and (not A.SurgeofPower:IsSpellLearned() or Unit("player"):HasBuffs(A.SurgeofPowerBuff.ID, true) > 0 or Player:Maelstrom() >= 44)) then
                if HandleStormkeeper() then 
                    return A.Stormkeeper:Show(icon)
                end
            end
			
            -- liquid_magma_totem,if=talent.liquid_magma_totem.enabled&(raid_event.adds.count<3|raid_event.adds.in>50)
            if A.LiquidMagmaTotem:IsReady(unit) and not ShouldStop and A.LiquidMagmaTotem:IsSpellLearned() then
                return A.LiquidMagmaTotem:Show(icon)
            end
			
            -- lightning_bolt,if=buff.stormkeeper.up&spell_targets.chain_lightning<2&(azerite.lava_shock.rank*buff.lava_shock.stack)<26&(buff.master_of_the_elements.up&!talent.surge_of_power.enabled|buff.surge_of_power.up)
            --if A.LightningBolt:IsReady(unit) and not ShouldStop and Unit("player"):HasBuffs(A.StormkeeperBuff.ID, true) > 0 and FutureMaelstromPower() <= 90 then
            --    return A.LightningBolt:Show(icon)
            --end
			
            -- frost_shock,if=talent.icefury.enabled&buff.icefury.up&buff.icefury.remains<1.1*gcd*buff.icefury.stack
            if A.FrostShock:IsReady(unit) and not ShouldStop and (A.Icefury:IsSpellLearned() and Unit("player"):HasBuffs(A.IcefuryBuff.ID, true) > 0 and Unit("player"):HasBuffs(A.IcefuryBuff.ID, true) < 1.8 * A.GetGCD() * Unit("player"):HasBuffsStacks(A.IcefuryBuff.ID, true)) then
                return A.FrostShock:Show(icon)
            end
			
            -- earth_shock,if=!buff.surge_of_power.up&talent.master_of_the_elements.enabled&(buff.master_of_the_elements.up|cooldown.lava_burst.remains>0&maelstrom>=92+30*talent.call_the_thunder.enabled|spell_targets.chain_lightning<2&(azerite.lava_shock.rank*buff.lava_shock.stack<26)&buff.stormkeeper.up&cooldown.lava_burst.remains<=gcd)
            if A.EarthShock:IsReady(unit) and not ShouldStop and A.MasteroftheElements:IsSpellLearned() and ((Unit("player"):HasBuffs(A.MasteroftheElementsBuff.ID, true) > 0 and FutureMaelstromPower() >= 60) or FutureMaelstromPower() >= 90)  then
                return A.EarthShock:Show(icon)
            end
			
            -- earth_shock,if=!talent.master_of_the_elements.enabled&!(azerite.igneous_potential.rank>2&buff.ascendance.up)&(buff.stormkeeper.up|maelstrom>=90+30*talent.call_the_thunder.enabled|!(cooldown.storm_elemental.remains>120&talent.storm_elemental.enabled)&expected_combat_length-time-cooldown.storm_elemental.remains-150*floor((expected_combat_length-time-cooldown.storm_elemental.remains)%150)>=30*(1+(azerite.echo_of_the_elementals.rank>=2)))
            if A.EarthShock:IsReady(unit) and not ShouldStop and (not A.MasteroftheElements:IsSpellLearned() and not (A.IgneousPotential:GetAzeriteRank() > 2 and Unit("player"):HasBuffs(A.AscendanceBuff.ID, true) > 0) and (Unit("player"):HasBuffs(A.StormkeeperBuff.ID, true) > 0 or Player:Maelstrom() >= 90 + 30 * num(A.CalltheThunder:IsSpellLearned()) or not (A.StormElemental:GetCooldown() > 120 and A.StormElemental:IsSpellLearned()) and Unit(unit):TimeToDie() - A.StormElemental:GetCooldown() - 150 * math.floor ((Unit(unit):TimeToDie() - A.StormElemental:GetCooldown()) / 150) >= 30 * (1 + num((A.EchooftheElementals:GetAzeriteRank() >= 2))))) then
                return A.EarthShock:Show(icon)
            end
			
            -- earth_shock,if=talent.surge_of_power.enabled&!buff.surge_of_power.up&cooldown.lava_burst.remains<=gcd&(!talent.storm_elemental.enabled&!(cooldown.fire_elemental.remains>120)|talent.storm_elemental.enabled&!(cooldown.storm_elemental.remains>120))
            if A.EarthShock:IsReady(unit) and not ShouldStop and (A.SurgeofPower:IsSpellLearned() and Unit("player"):HasBuffs(A.SurgeofPowerBuff.ID, true) == 0 and A.LavaBurst:GetCooldown() <= A.GetGCD() and (not A.StormElemental:IsSpellLearned() and not (A.FireElemental:GetCooldown() > 120) or A.StormElemental:IsSpellLearned() and not (A.StormElemental:GetCooldown() > 120))) then
                return A.EarthShock:Show(icon)
            end
			
            -- frost_shock,if=talent.icefury.enabled&talent.master_of_the_elements.enabled&buff.icefury.up&buff.master_of_the_elements.up
            if A.FrostShock:IsReady(unit) and not ShouldStop and (A.Icefury:IsSpellLearned() and A.MasteroftheElements:IsSpellLearned() and Unit("player"):HasBuffs(A.IcefuryBuff.ID, true) > 0 and Unit("player"):HasBuffs(A.MasteroftheElementsBuff.ID, true) > 0) then
                return A.FrostShock:Show(icon)
            end
			
            -- lava_burst,if=buff.ascendance.up
            if A.LavaBurst:IsReady(unit) and not isMoving and Player:Maelstrom() < 90 and A.LastPlayerCastName ~= A.LavaBurst:Info() and not A.LavaBurst:IsSpellInFlight() and not ShouldStop and (Unit("player"):HasBuffs(A.AscendanceBuff.ID, true) > 0) then
                return A.LavaBurst:Show(icon)
            end
			
            -- lava_burst,if=talent.storm_elemental.enabled&cooldown_react&buff.surge_of_power.up&(expected_combat_length-time-cooldown.storm_elemental.remains-150*floor((expected_combat_length-time-cooldown.storm_elemental.remains)%150)<30*(1+(azerite.echo_of_the_elementals.rank>=2))|(1.16*(expected_combat_length-time)-cooldown.storm_elemental.remains-150*floor((1.16*(expected_combat_length-time)-cooldown.storm_elemental.remains)%150))<(expected_combat_length-time-cooldown.storm_elemental.remains-150*floor((expected_combat_length-time-cooldown.storm_elemental.remains)%150)))
            if A.LavaBurst:IsReady(unit) and not isMoving and Player:Maelstrom() < 90 and A.LastPlayerCastName ~= A.LavaBurst:Info() and not A.LavaBurst:IsSpellInFlight() and Unit("player"):HasBuffs(A.MasteroftheElementsBuff.ID, true) == 0 and not ShouldStop and (A.StormElemental:IsSpellLearned() and A.LavaBurst:GetCooldown() == 0 and Unit("player"):HasBuffs(A.SurgeofPowerBuff.ID, true) and (Unit(unit):TimeToDie() - A.StormElemental:GetCooldown() - 150 * math.floor ((Unit(unit):TimeToDie() - A.StormElemental:GetCooldown()) / 150) < 30 * (1 + num((A.EchooftheElementals:GetAzeriteRank() >= 2))) or (1.16 * Unit(unit):TimeToDie() - A.StormElemental:GetCooldown() - 150 * math.floor ((1.16 * Unit(unit):TimeToDie() - A.StormElemental:GetCooldown()) / 150)) < (Unit(unit):TimeToDie() - A.StormElemental:GetCooldown() - 150 * math.floor ((Unit(unit):TimeToDie() - A.StormElemental:GetCooldown()) / 150)))) then
                return A.LavaBurst:Show(icon)
            end
			
            -- lava_burst,if=!talent.storm_elemental.enabled&cooldown_react&buff.surge_of_power.up&(expected_combat_length-time-cooldown.fire_elemental.remains-150*floor((expected_combat_length-time-cooldown.fire_elemental.remains)%150)<30*(1+(azerite.echo_of_the_elementals.rank>=2))|(1.16*(expected_combat_length-time)-cooldown.fire_elemental.remains-150*floor((1.16*(expected_combat_length-time)-cooldown.fire_elemental.remains)%150))<(expected_combat_length-time-cooldown.fire_elemental.remains-150*floor((expected_combat_length-time-cooldown.fire_elemental.remains)%150)))
            if A.LavaBurst:IsReady(unit) and not isMoving and Player:Maelstrom() < 90 and A.LastPlayerCastName ~= A.LavaBurst:Info() and not A.LavaBurst:IsSpellInFlight() and Unit("player"):HasBuffs(A.MasteroftheElementsBuff.ID, true) == 0 and not ShouldStop and (not A.StormElemental:IsSpellLearned() and A.LavaBurst:GetCooldown() == 0 and Unit("player"):HasBuffs(A.SurgeofPowerBuff.ID, true) and (Unit(unit):TimeToDie() - A.FireElemental:GetCooldown() - 150 * math.floor ((Unit(unit):TimeToDie() - A.FireElemental:GetCooldown()) / 150) < 30 * (1 + num((A.EchooftheElementals:GetAzeriteRank() >= 2))) or (1.16 * Unit(unit):TimeToDie() - A.FireElemental:GetCooldown() - 150 * math.floor ((1.16 * Unit(unit):TimeToDie() - A.FireElemental:GetCooldown()) / 150)) < (Unit(unit):TimeToDie() - A.FireElemental:GetCooldown() - 150 * math.floor ((Unit(unit):TimeToDie() - A.FireElemental:GetCooldown()) / 150)))) then
                return A.LavaBurst:Show(icon)
            end
			
            -- lightning_bolt,if=buff.surge_of_power.up
          --  if A.LightningBolt:IsReady(unit) and not isMoving and not ShouldStop and (Unit("player"):HasBuffs(A.SurgeofPowerBuff.ID, true) > 0) and FutureMaelstromPower() <= 90 then
          --      return A.LightningBolt:Show(icon)
          --  end
			
            -- lava_burst,if=cooldown_react&!talent.master_of_the_elements.enabled
            if A.LavaBurst:IsReady(unit) and not isMoving and Player:Maelstrom() < 90 and A.LastPlayerCastName ~= A.LavaBurst:Info() and not A.LavaBurst:IsSpellInFlight() and not ShouldStop and (A.LavaBurst:GetCooldown() == 0 and not A.MasteroftheElements:IsSpellLearned()) then
                return A.LavaBurst:Show(icon)
            end
			
            -- icefury,if=talent.icefury.enabled&!(maelstrom>75&cooldown.lava_burst.remains<=0)&(!talent.storm_elemental.enabled|cooldown.storm_elemental.remains<120)
            if A.Icefury:IsReady(unit) and not isMoving and not ShouldStop and not Pet:IsActive(77942) and (A.Icefury:IsSpellLearned() and not (FutureMaelstromPower() > 75 and A.LavaBurst:GetCooldown() <= 0) and (not A.StormElemental:IsSpellLearned() or A.StormElemental:GetCooldown() < 120)) then
                return A.Icefury:Show(icon)
            end
			
            -- lava_burst,if=cooldown_react&charges>talent.echo_of_the_elements.enabled
            if A.LavaBurst:IsReady(unit) and not isMoving and Player:Maelstrom() < 90 and A.LastPlayerCastName ~= A.LavaBurst:Info() and not A.LavaBurst:IsSpellInFlight() and not ShouldStop and Unit("player"):HasBuffs(A.MasteroftheElementsBuff.ID, true) == 0 and (A.LavaBurst:GetCooldown() == 0 and A.LavaBurst:GetSpellCharges() > num(A.EchooftheElements:IsSpellLearned())) then
                return A.LavaBurst:Show(icon)
            end
            
            -- lava_burst,if=cooldown_react
            if A.LavaBurst:IsReady(unit) and not isMoving and Player:Maelstrom() < 90 and A.LastPlayerCastName ~= A.LavaBurst:Info() and not A.LavaBurst:IsSpellInFlight() and not ShouldStop and (A.LavaBurst:GetCooldown() == 0) and Unit("player"):HasBuffs(A.MasteroftheElementsBuff.ID, true) == 0 then
                return A.LavaBurst:Show(icon)
            end

            -- lightning_bolt,if=buff.stormkeeper.up&spell_targets.chain_lightning<2&(azerite.lava_shock.rank*buff.lava_shock.stack)<26&(buff.master_of_the_elements.up&!talent.surge_of_power.enabled|buff.surge_of_power.up)
            if A.LightningBolt:IsReady(unit) and not ShouldStop and Unit("player"):HasBuffs(A.StormkeeperBuff.ID, true) > 0 and FutureMaelstromPower() <= 90 then
                return A.LightningBolt:Show(icon)
            end
			
            -- flame_shock,target_if=refreshable&!buff.surge_of_power.up
            if A.FlameShock:IsReady(unit) and (Unit(unit):HasDeBuffs(A.FlameShockDebuff.ID, true) == 0 or Unit(unit):HasDeBuffs(A.FlameShockDebuff.ID, true) <= 7) and Unit("player"):HasBuffs(A.SurgeofPowerBuff) == 0 then
                return A.FlameShock:Show(icon)
            end
			
            -- totem_mastery,if=talent.totem_mastery.enabled&(buff.resonance_totem.remains<6|(buff.resonance_totem.remains<(buff.ascendance.duration+cooldown.ascendance.remains)&cooldown.ascendance.remains<15))
            if A.TotemMastery:IsReady(unit) and not ShouldStop and (A.TotemMastery:IsSpellLearned() and (ResonanceTotemTime() < 6 or (ResonanceTotemTime() < (15 + A.Ascendance:GetCooldown()) and A.Ascendance:GetCooldown() < 15))) then
                return A.TotemMastery:Show(icon)
            end
			
            -- Lavaburst while
            if A.LavaBurst:IsReady(unit) and not isMoving and not ShouldStop and FutureMaelstromPower() <= 90 then
                return A.LavaBurst:Show(icon)
            end	
			
            -- frost_shock,if=talent.icefury.enabled&buff.icefury.up&(buff.icefury.remains<gcd*4*buff.icefury.stack|buff.stormkeeper.up|!talent.master_of_the_elements.enabled)
            if A.FrostShock:IsReady(unit) and not ShouldStop and (A.Icefury:IsSpellLearned() and Unit("player"):HasBuffs(A.IcefuryBuff.ID, true) > 0 and (Unit("player"):HasBuffs(A.IcefuryBuff.ID, true) < A.GetGCD() * 4 * Unit("player"):HasBuffsStacks(A.IcefuryBuff.ID, true) or Unit("player"):HasBuffs(A.StormkeeperBuff.ID, true) > 0 or not A.MasteroftheElements:IsSpellLearned())) then
                return A.FrostShock:Show(icon)
            end
			
            -- chain_lightning,if=buff.tectonic_thunder.up&!buff.stormkeeper.up&spell_targets.chain_lightning>1
            if A.ChainLightning:IsReady(unit) and A.GetToggle(2, "AoE") and not ShouldStop and (Unit("player"):HasBuffs(A.TectonicThunderBuff.ID, true) > 0 and Unit("player"):HasBuffs(A.StormkeeperBuff.ID, true) == 0 and MultiUnits:GetActiveEnemies() > 1) then
                return A.ChainLightning:Show(icon)
            end
			
            -- lightning_bolt
            if A.LightningBolt:IsReady(unit) and not isMoving and not ShouldStop and FutureMaelstromPower() <= 90 then
                return A.LightningBolt:Show(icon)
            end
			
            -- flame_shock,moving=1,target_if=refreshable
            if A.FlameShock:IsReady(unit) and not ShouldStop and (Unit(unit):HasDeBuffs(A.FlameShockDebuff.ID, true) == 0 or Unit(unit):HasDeBuffs(A.FlameShockDebuff.ID, true) <= 7) and isMoving then
                return A.FlameShock:Show(icon)
            end
			
            -- flame_shock,moving=1,if=movement.distance>6
            if A.FlameShock:IsReady(unit) and (Unit(unit):HasDeBuffs(A.FlameShockDebuff.ID, true) == 0 or Unit(unit):HasDeBuffs(A.FlameShockDebuff.ID, true) <= 7) and not ShouldStop and isMoving then
                return A.FlameShock:Show(icon)
            end
			
            -- 14 Lavaburst while moving
            if A.LavaBurst:IsReady(unit) and isMoving and Player:Maelstrom() < 90 and A.LastPlayerCastName ~= A.LavaBurst:Info() and Unit(unit):HasDeBuffs(A.FlameShockDebuff.ID, true) >= A.LavaBurst:GetSpellCastTime() and Unit("player"):HasBuffs(A.LavaSurgeBuff.ID, true) > 0 and FutureMaelstromPower() <= 90 then
                return A.LavaBurst:Show(icon)
            end   
			
            -- 15 lightning_bolt while moving w buff sk
            if A.LightningBolt:IsReady(unit) and isMoving and Unit("player"):HasBuffs(A.StormkeeperBuff.ID, true) > 0 then
                return A.LightningBolt:Show(icon)
            end  
			
            -- 16 frost_shock  ,moving
            if A.FrostShock:IsReady(unit) and isMoving and Unit("player"):HasBuffs(A.StormkeeperBuff.ID, true) == 0 then
                return A.FrostShock:Show(icon)
            end  
			
            -- frost_shock,moving=1
            if A.FrostShock:IsReady(unit) and not ShouldStop and isMoving then
                return A.FrostShock:Show(icon)
            end
        end
        
        -- Single Target
        local function CustomST(unit)
            
            -- 0 TotemMastery
            if A.TotemMastery:IsReady(unit) and A.LastPlayerCastName ~= A.TotemMastery:Info() and ResonanceTotemTime() < 6 and A.TotemMastery:IsSpellLearned() then
                return A.TotemMastery:Show(icon)
            end
			
            -- 1 FLame shock
            if A.FlameShock:IsReady(unit) and HandleFlameShockTTD() and (Unit(unit):HasDeBuffs(A.FlameShockDebuff.ID, true) == 0 or Unit(unit):HasDeBuffs(A.FlameShockDebuff.ID, true) <= 7) then 
                return A.FlameShock:Show(icon)
            end   
			
            -- 2 Stormkeeper
            if A.Stormkeeper:IsReady(unit) and not isMoving and A.Stormkeeper:IsSpellLearned() then 
                if HandleStormkeeper() then 
                    return A.Stormkeeper:Show(icon)
                end
            end        
            -- 3 Fire Elemental
            if A.FireElemental:IsReady(unit) and A.BurstIsON(unit) and (not A.StormElemental:IsSpellLearned()) then
                return A.FireElemental:Show(icon)
            end
            
            -- 3 Earth_elemental,if=!talent.primal_elementalist.enabled|talent.primal_elementalist.enabled&(cooldown.fire_elemental.remains<120&!talent.storm_elemental.enabled|cooldown.storm_elemental.remains<120&talent.storm_elemental.enabled)
            if A.EarthElemental:IsReady(unit) and  A.BurstIsON(unit) and (A.FireElemental:GetCooldown() < 120 and not A.StormElemental:IsSpellLearned() or A.FireElemental:GetCooldown() < 120 and A.StormElemental:IsSpellLearned()) then
                return A.EarthElemental:Show(icon)
            end   
			
            -- 3 Storm Elemental
            if A.StormElemental:IsReady(unit) and A.BurstIsON(unit) then
                return A.StormElemental:Show(icon)
            end
			
            -- 4 Icefury
            if A.Icefury:IsReady(unit) and not isMoving and not Pet:IsActive(77942) and A.Icefury:IsSpellLearned() and Unit("player"):HasBuffs(A.StormkeeperBuff.ID, true) == 0 then
                return A.Icefury:Show(icon)
            end 
			
            -- 5 Eye of the Storm if Storm Elemental is up and we got Primal Elementalists
            if A.EyeOfTheStorm:GetCooldown() < 0.1 and A.PrimalElementalist:IsSpellLearned() and A.BurstIsON(unit) and Pet:IsActive(77942) and A.CallLightning:GetCooldown() > 1 then
                return A.EyeOfTheStorm:Show(icon)
            end
            
            -- 9 Liquid Magma Totem
            if A.LiquidMagmaTotem:IsReady(unit) and A.LiquidMagmaTotem:IsSpellLearned() then
                return A.LiquidMagmaTotem:Show(icon)
            end
			
            -- 10 Elemental Blast
            if A.ElementalBlast:IsReady(unit) and A.ElementalBlast:IsSpellLearned() then
                return A.ElementalBlast:Show(icon)
            end
			
            -- 11 Ascendance
            if A.Ascendance:IsReady("player") and A.BurstIsON(unit) and A.Ascendance:IsSpellLearned() then
                return A.Ascendance:Show(icon)
            end   
			
            -- 13 EarthShock
            if A.EarthShock:IsReady(unit) and Player:Maelstrom() >= 60 then 
                return A.EarthShock:Show(icon)
            end
			
            -- 18 lava_burst
            if A.LavaBurst:IsReady(unit) and not Pet:IsActive(77942) 
            and (not isMoving or Unit("player"):HasBuffs(A.SurgeofPowerBuff.ID, true) > 0) 
            and Unit(unit):HasDeBuffs(A.FlameShockDebuff.ID, true) >= A.LavaBurst:GetSpellCastTime() and Player:Maelstrom() <= 90 and Unit("player"):HasBuffs(A.StormkeeperBuff.ID, true) == 0 
            then
                return A.LavaBurst:Show(icon)
            end
			
            -- 17 frost_shock
            if A.FrostShock:IsReady(unit) and A.Icefury:IsSpellLearned() and Unit("player"):HasBuffs(A.IcefuryBuff.ID, true) > 0 and not Unit("player"):HasBuffs(A.LavaSurgeBuff.ID, true) then
                return A.FrostShock:Show(icon)
            end    
			
            -- 15 lightning_bolt
            if A.LightningBolt:IsReady(unit) and Unit("player"):HasBuffs(A.StormkeeperBuff.ID, true) > 0 then
                return A.LightningBolt:Show(icon)
            end
			
            -- 14 Lavaburst while moving
            if A.LavaBurst:IsReady(unit) and not Pet:IsActive(77942) and Unit(unit):HasDeBuffs(A.FlameShockDebuff.ID, true) >= A.LavaBurst:GetSpellCastTime() and Unit("player"):HasBuffs(A.LavaSurgeBuff.ID, true) > 0 and Player:Maelstrom() <= 90 then
                return A.LavaBurst:Show(icon)
            end  
			
            -- 15 lightning_bolt while moving w buff sk
            if A.LightningBolt:IsReady(unit) and isMoving  and Unit("player"):HasBuffs(A.StormkeeperBuff.ID, true) > 0 then
                return A.LightningBolt:Show(icon)
            end   
			
            -- 16 frost_shock  ,moving
            if A.FrostShock:IsReady(unit) and isMoving and Unit("player"):HasBuffs(A.StormkeeperBuff.ID, true) == 0 then
                return A.FrostShock:Show(icon)
            end   
			
            -- 12 Lavaburst        
            if A.LavaBurst:IsReady(unit) and not Pet:IsActive(77942) and Unit(unit):HasDeBuffs(A.FlameShockDebuff.ID, true) >= A.LavaBurst:GetSpellCastTime() and Unit("player"):HasBuffs(A.LavaSurgeBuff.ID, true) == 0 and Unit("player"):HasBuffs(A.IcefuryBuff.ID, true) == 0 and Player:Maelstrom() <= 80 then
                return A.LavaBurst:Show(icon)
            end    
			
            -- 15 lightning_bolt while moving w buff sk
            if A.LightningBolt:IsReady(unit) then
                return A.LightningBolt:Show(icon)
            end            
        end
        
        
        -- call precombat
        if not inCombat and Unit(unit):IsExists() then 
            local ShouldReturn = Precombat(unit); if ShouldReturn then return ShouldReturn; end
        end
        
        -- Ghost Wolf
        if Unit(unit):GetRange() > 40 and A.GhostWolf:IsReady("player") and Unit("player"):HasBuffs(A.GhostWolfBuff.ID, true) == 0 and Action.GetToggle(2, "UseGhostWolf") then
            -- Notification                    
            Action.SendNotification("Out of range, auto Ghost Wolf", A.GhostWolf.ID)
            return A.GhostWolf:Show(icon)
        end
        
        -- In Combat
        if inCombat and Unit(unit):IsExists() then
            
            -- Interrupt Handler          
            local unit = "target"
            local useKick, useCC, useRacial = Action.InterruptIsValid(unit, "TargetMouseover")    
            local Trinket1IsAllowed, Trinket2IsAllowed = TR.TrinketIsAllowed()
            
            -- WindShear
            if useKick and A.WindShear:IsReady(unit) and not ShouldStop then 
                if Unit(unit):CanInterrupt(true, nil, 25, 70) then
                    return A.WindShear:Show(icon)
                end 
            end    
			
            -- CapacitorTotem
            if useCC and Action.GetToggle(2, "UseCapacitorTotem") and A.WindShear:GetCooldown() > 0 and A.CapacitorTotem:IsReady(unit) and not ShouldStop then 
                if Unit(unit):CanInterrupt(true, nil, 25, 70) then
                    return A.CapacitorTotem:Show(icon)
                end 
            end   
			
            -- Purge
            -- Note: Toggles  ("UseDispel", "UsePurge", "UseExpelEnrage")
            -- Category ("Dispel", "MagicMovement", "PurgeFriendly", "PurgeHigh", "PurgeLow", "Enrage")
            if A.Purge:IsReady(unit) and not ShouldStop and Action.AuraIsValid("target", "UsePurge", "PurgeHigh") then
                return A.Purge:Show(icon)
            end 
			
            -- potion,if=expected_combat_length-time<30|cooldown.fire_elemental.remains>120|cooldown.storm_elemental.remains>120
            if A.PotionofUnbridledFury:IsReady(unit) and Action.GetToggle(1, "Potion") and (expected_combat_length - Unit("player"):CombatTime() < 30 or A.FireElemental:GetCooldown() > 120 or A.StormElemental:GetCooldown() > 120) then
                return A.PotionofUnbridledFury:Show(icon)
            end
			
            -- totem_mastery,if=talent.totem_mastery.enabled&buff.resonance_totem.remains<2
            if A.TotemMastery:IsReady("player") and A.LastPlayerCastName ~= A.TotemMastery:Info() and (A.TotemMastery:IsSpellLearned() and ResonanceTotemTime() < 2) then
                return A.TotemMastery:Show(icon)
            end
			
            -- use_items
            -- fire_elemental,if=!talent.storm_elemental.enabled
            if A.FireElemental:IsReady(unit) and A.BurstIsON(unit) and (not A.StormElemental:IsSpellLearned()) then
                return A.FireElemental:Show(icon)
            end
            
            --earth_elemental,if=!talent.primal_elementalist.enabled|talent.primal_elementalist.enabled&(cooldown.fire_elemental.remains<120&!talent.storm_elemental.enabled|cooldown.storm_elemental.remains<120&talent.storm_elemental.enabled)
            if A.EarthElemental:IsReady(unit) and A.BurstIsON(unit) and (A.FireElemental:GetCooldown() < 120 and not A.StormElemental:IsSpellLearned() or A.FireElemental:GetCooldown() < 120 and A.StormElemental:IsSpellLearned()) then
                return A.EarthElemental:Show(icon)
            end            
            
            -- storm_elemental,if=talent.storm_elemental.enabled&(!talent.icefury.enabled|!buff.icefury.up&!cooldown.icefury.up)&(!talent.ascendance.enabled|!cooldown.ascendance.up)
            if A.StormElemental:IsReady(unit) and A.BurstIsON(unit) and (A.StormElemental:IsSpellLearned() and (not A.Icefury:IsSpellLearned() or Unit("player"):HasBuffs(A.IcefuryBuff.ID, true) == 0 and A.Icefury:GetCooldown() > 0) and (not A.Ascendance:IsSpellLearned() or A.Ascendance:GetCooldown() > 0)) then
                -- Notification                    
                Action.SendNotification("Storm Elemental burst", A.StormElemental.ID)
                return A.StormElemental:Show(icon)
            end
			
            -- use_item,name=shiver_venom_relic,if=cooldown.summon_darkglare.remains>=25&(cooldown.deathbolt.remains|!talent.deathbolt.enabled)
            if A.BurstIsON(unit) and A.ShiverVenomRelic:AbsentImun(unit, Temp.TotalAndMag) 
            and Unit(unit):HasDeBuffsStacks(A.ShiverVenomDebuff.ID, true) >= 5 
            and A.ShiverVenomRelic:IsReady(unit) 
            then
                return A.ShiverVenomRelic:Show(icon)
            end   
			
            -- Trinket 1
            if A.BurstIsON(unit) and A.Trinket1:IsReady(unit) and Trinket1IsAllowed and A.Trinket1:AbsentImun(unit, "DamageMagicImun")  then 
                return A.Trinket1:Show(icon)
            end 
			
            -- Trinket 2            
            if A.BurstIsON(unit) and A.Trinket2:IsReady(unit) and Trinket2IsAllowed and A.Trinket2:AbsentImun(unit, "DamageMagicImun")  then                 
				return A.Trinket2:Show(icon)
            end 
			
            -- concentrated_flame
            if A.ConcentratedFlame:AutoHeartOfAzeroth(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") then
                return A.ConcentratedFlame:Show(icon)
            end
			
			-- reaping_flames
            if A.ReapingFlames:AutoHeartOfAzeroth(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") then
                return A.ReapingFlames:Show(icon)
            end
			
			-- moment_of_glory
            if A.MomentofGlory:AutoHeartOfAzeroth(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") then
                return A.MomentofGlory:Show(icon)
            end

			-- ReplicaofKnowledge
            if A.ReplicaofKnowledge:AutoHeartOfAzeroth(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") then
                return A.ReplicaofKnowledge:Show(icon)
            end	
			
            -- blood_of_the_enemy
            if A.BloodoftheEnemy:AutoHeartOfAzeroth(unit, true) and A.BurstIsON(unit) and Action.GetToggle(1, "HeartOfAzeroth") then
                return A.BloodoftheEnemy:Show(icon)
            end
			
            -- guardian_of_azeroth
            if A.GuardianofAzeroth:AutoHeartOfAzeroth(unit, true) and A.BurstIsON(unit) and Action.GetToggle(1, "HeartOfAzeroth") then
                return A.GuardianofAzeroth:Show(icon)
            end
			
            -- focused_azerite_beam
            if A.FocusedAzeriteBeam:AutoHeartOfAzeroth(unit, true) and A.BurstIsON(unit) and Action.GetToggle(1, "HeartOfAzeroth") then
                return A.FocusedAzeriteBeam:Show(icon)
            end
			
            -- purifying_blast
            if A.PurifyingBlast:AutoHeartOfAzeroth(unit, true) and A.BurstIsON(unit) and Action.GetToggle(1, "HeartOfAzeroth") then
                return A.PurifyingBlast:Show(icon)
            end
            -- the_unbound_force
            if A.TheUnboundForce:AutoHeartOfAzeroth(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") then
                return A.TheUnboundForce:Show(icon)
            end
			
            -- memory_of_lucid_dreams
            if A.MemoryofLucidDreams:AutoHeartOfAzeroth(unit, true) and A.BurstIsON(unit) and Action.GetToggle(1, "HeartOfAzeroth") then
                return A.MemoryofLucidDreams:Show(icon)
            end
			
            -- ripple_in_space
            if A.RippleinSpace:AutoHeartOfAzeroth(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") 
			and ((A.UnlimitedPower:IsSpellLearned() or Unit("player"):HasBuffs(A.StormkeeperBuff.ID, true) > 0 or A.Ascendance:IsSpellLearned() and ((A.StormElemental:IsSpellLearned() and A.StormElemental:GetCooldown() < 120) and A.StormElemental:GetCooldown() > 15 or not A.StormElemental:IsSpellLearned()) and (not A.Icefury:IsSpellLearned() or Unit("player"):HasBuffs(A.IcefuryBuff.ID, true) and A.Icefury:GetCooldown() == 0)) or A.Ascendance:GetCooldown() > 0)
			then
                return A.RippleinSpace:Show(icon)
            end
			
            -- worldvein_resonance
            if A.WorldveinResonance:AutoHeartOfAzeroth(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") then
                return A.WorldveinResonance:Show(icon)
            end
			
            -- blood_fury,if=!talent.ascendance.enabled|buff.ascendance.up|cooldown.ascendance.remains>50
            if A.BloodFury:AutoRacial(unit) and Action.GetToggle(1, "Racial") and A.BurstIsON(unit) and (not A.Ascendance:IsSpellLearned() or Unit("player"):HasBuffs(A.AscendanceBuff.ID, true) > 0 or A.Ascendance:GetCooldown() > 50) then
                return A.BloodFury:Show(icon)
            end
			
            -- berserking,if=!talent.ascendance.enabled|buff.ascendance.up
            if A.Berserking:AutoRacial(unit) and not Unit("player"):HasHeroism() and Action.GetToggle(1, "Racial") and A.BurstIsON(unit) and (not A.Ascendance:IsSpellLearned() or Unit("player"):HasBuffs(A.AscendanceBuff.ID, true) > 0) then
                return A.Berserking:Show(icon)
            end
			
            -- fireblood,if=!talent.ascendance.enabled|buff.ascendance.up|cooldown.ascendance.remains>50
            if A.Fireblood:AutoRacial(unit) and Action.GetToggle(1, "Racial") and A.BurstIsON(unit) and (not A.Ascendance:IsSpellLearned() or Unit("player"):HasBuffs(A.AscendanceBuff.ID, true) > 0 or A.Ascendance:GetCooldown() > 50) then
                return A.Fireblood:Show(icon)
            end
			
            -- ancestral_call,if=!talent.ascendance.enabled|buff.ascendance.up|cooldown.ascendance.remains>50
            if A.AncestralCall:AutoRacial(unit) and Action.GetToggle(1, "Racial") and A.BurstIsON(unit) and (not A.Ascendance:IsSpellLearned() or Unit("player"):HasBuffs(A.AscendanceBuff.ID, true) > 0 or A.Ascendance:GetCooldown() > 50) then
                return A.AncestralCall:Show(icon)
            end
			
            -- bag_of_tricks,if=!talent.ascendance.enabled|!buff.ascendance.up
            if A.BagofTricks:AutoRacial(unit) and Action.GetToggle(1, "Racial") and A.BurstIsON(unit) and (not A.Ascendance:IsSpellLearned() or Unit("player"):HasBuffs(A.AscendanceBuff.ID, true) == 0) then
                return A.BagofTricks:Show(icon)
            end           
			
            -- Auto Multidot
            if Unit(unit):TimeToDie() >= 10  
            and Action.GetToggle(2, "AutoDot") and CanMultidot
            and (
                MissingFlameShock >= 1 and Unit(unit):HasDeBuffs(A.FlameShock.ID, true) > 0 
                
            ) 
            and (Unit("player"):HasBuffs(A.LavaSurgeBuff.ID, true) == 0 ) and (Unit("player"):HasBuffs(A.IcefuryBuff.ID, true) == 0 )
            and MultiUnits:GetByRange(Action.GetToggle(2, "MultiDotDistance"), 5, 10) <= 2 
            then
                return A:Show(icon, ACTION_CONST_AUTOTARGET)
            end    
            
            -- Aoe Prediction Notification
            local castName, castStartTime, castEndTime, notInterruptable, spellID, isChannel = Unit("player"):IsCasting()
            if FutureMaelstromPower() >= 60 and spellID == A.ChainLightning.ID and A.GetToggle(2, "AoE") then
                -- Notification                    
                Action.SendNotification("Earthquake soon! Get your mouse ready", A.Earthquake.ID)
            end
            -- run_action_list,name=aoe,if=active_enemies>2&(spell_targets.chain_lightning>2|spell_targets.lava_beam>2)
            if Aoe(unit) and (MultiUnits:GetActiveEnemies() > 2 and Action.GetToggle(2, "AoE")) then
                return true
            end
            -- run_action_list,name=single_target
            if MOTE(unit) and A.MasteroftheElements:IsSpellLearned() and (MultiUnits:GetActiveEnemies() < 3 or not Action.GetToggle(2, "AoE")) then
                return true
            end
            -- run_action_list,name=single_target
            if CustomST(unit) and not A.MasteroftheElements:IsSpellLearned() and (MultiUnits:GetActiveEnemies() < 3 or not Action.GetToggle(2, "AoE"))  then
                return true
            end
        end
    end
    
    -- End on EnemyRotation()
    
    -- Mouseover DPS Rotation
    -- Only handling mouseover multidots and dots refreshable
    local function MouseoverRotation(unit)
        
        -- Variables
        inRange = A.ChainLightning:IsInRange(unit)
        
        -- Note: Toggles  ("UseDispel", "UsePurge", "UseExpelEnrage")
        -- Category ("Dispel", "MagicMovement", "PurgeFriendly", "PurgeHigh", "PurgeLow", "Enrage")
        -- Purge
        if A.Purge:IsReady(unit) and Action.GetToggle(2, "mouseover") and not ShouldStop and Action.AuraIsValid(unit, "UsePurge", "PurgeHigh") then
            return A.Purge:Show(icon)
        end    
        
        -- WindShear
        if useKick and A.WindShear:IsReady(unit) and not ShouldStop then 
            if Unit(unit):CanInterrupt(true, nil, 25, 70) then
                return A.WindShear:Show(icon)
            end 
        end         
        
        -- FlameShock
        if A.FlameShock:IsReady(unit) and Action.GetToggle(2, "mouseover") and MultiUnits:GetActiveEnemies() <= 3 and not ShouldStop and (Unit(unit):HasDeBuffs(A.FlameShockDebuff.ID, true) <= 7 or Unit(unit):HasDeBuffs(A.FlameShockDebuff.ID, true) == 0) and not Unit("player"):GetSpellLastCast(A.FlameShock.ID, true) and Unit(unit):TimeToDie() >= 15 then
            return A.FlameShock:Show(icon)
        end            
        
    end
    
    -- FriendlyTeam Rotation
    -- Only handling mouseover multidots and dots refreshable
    local function FriendlyRotation()
        -- AncestralGuidance
        local AncestralGuidance = A.GetToggle(2, "AncestralGuidanceHP")
        if HandleAncestralGuidance() and
        AncestralGuidance >= 0 and A.AncestralGuidance:IsReadyByPassCastGCD(player) and 
        (
            (    -- Auto 
                AncestralGuidance >= 100 and 
                (
                    A.HealingEngine.GetIncomingDMGAVG() >= 35
                )
            ) or 
            (    -- Custom
                AncestralGuidance < 100 and 
                -- HP lose per sec >= 40
                A.HealingEngine.GetIncomingDMGAVG() >= AncestralGuidance
            )
        ) 
        then 
            return A.AncestralGuidance
        end    
    end
    
    -- Friendly Rotation
    if FriendlyRotation() then
        return true
    end
    
    -- Defensive
    local SelfDefensive = SelfDefensives()
    if SelfDefensive then 
        return SelfDefensive:Show(icon)
    end 
    
    -- Mouseover
    if A.IsUnitEnemy("mouseover") then
        unit = "mouseover"
        if MouseoverRotation(unit) then 
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
local function FreezingTrapUsedByEnemy()
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
			-- Interrupt
   		    local Interrupt = Interrupts(unit)
  		    if Interrupt then 
  		        return Interrupt:Show(icon)
  		    end	
        end
    end 
end 
local function PartyRotation(unit)
    if (unit == "party1" and not Action.GetToggle(2, "PartyUnits")[1]) or (unit == "party2" and not Action.GetToggle(2, "PartyUnits")[2]) then 
        return false 
    end

  	-- CleanseSpirit
    if A.CleanseSpirit:IsReady(unit) and A.CleanseSpirit:AbsentImun(unit, Temp.TotalAndMag) and Action.AuraIsValid(unit, "UseDispel", "Magic") and not Unit(unit):InLOS() then
        return A.CleanseSpirit
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