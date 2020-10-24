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

Action[ACTION_CONST_ROGUE_ASSASSINATION] = {
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
    MarkedForDeath                         = Create({ Type = "Spell", ID = 137619 }),
    ApplyPoison                            = Create({ Type = "Spell", ID =  }),
    Exsanguinate                           = Create({ Type = "Spell", ID = 200806 }),
    Vendetta                               = Create({ Type = "Spell", ID = 79140 }),
    VendettaDebuff                         = Create({ Type = "Spell", ID = 79140 }),
    ToxicBladeDebuff                       = Create({ Type = "Spell", ID = 245389 }),
    RuptureDebuff                          = Create({ Type = "Spell", ID = 1943 }),
    Subterfuge                             = Create({ Type = "Spell", ID = 108208 }),
    ShroudedSuffocation                    = Create({ Type = "Spell", ID =  }),
    GarroteDebuff                          = Create({ Type = "Spell", ID = 703 }),
    Vanish                                 = Create({ Type = "Spell", ID = 1856 }),
    Nightstalker                           = Create({ Type = "Spell", ID = 14062 }),
    DeeperStratagem                        = Create({ Type = "Spell", ID = 193531 }),
    ToxicBlade                             = Create({ Type = "Spell", ID = 245388 }),
    VisionofPerfection                     = Create({ Type = "Spell", ID =  }),
    PoolResource                           = Create({ Type = "Spell", ID = 9999000010 }),
    Garrote                                = Create({ Type = "Spell", ID = 703 }),
    MasterAssassin                         = Create({ Type = "Spell", ID =  }),
    Shadowmeld                             = Create({ Type = "Spell", ID = 58984 }),
    BloodFury                              = Create({ Type = "Spell", ID = 20572 }),
    Berserking                             = Create({ Type = "Spell", ID = 26297 }),
    Fireblood                              = Create({ Type = "Spell", ID = 265221 }),
    AncestralCall                          = Create({ Type = "Spell", ID = 274738 }),
    Envenom                                = Create({ Type = "Spell", ID = 32645 }),
    FanofKnives                            = Create({ Type = "Spell", ID = 51723 }),
    EchoingBlades                          = Create({ Type = "Spell", ID =  }),
    HiddenBladesBuff                       = Create({ Type = "Spell", ID =  }),
    DoubleDose                             = Create({ Type = "Spell", ID =  }),
    DeadlyPoisonDotDebuff                  = Create({ Type = "Spell", ID = 177918 }),
    Blindside                              = Create({ Type = "Spell", ID =  }),
    BlindsideBuff                          = Create({ Type = "Spell", ID =  }),
    VenomRush                              = Create({ Type = "Spell", ID = 152152 }),
    Mutilate                               = Create({ Type = "Spell", ID = 1329 }),
    ScentofBlood                           = Create({ Type = "Spell", ID =  }),
    Rupture                                = Create({ Type = "Spell", ID = 1943 }),
    CrimsonTempest                         = Create({ Type = "Spell", ID = 121411 }),
    CrimsonTempestBuff                     = Create({ Type = "Spell", ID = 121411 }),
    TwisttheKnife                          = Create({ Type = "Spell", ID =  }),
    EnvenomBuff                            = Create({ Type = "Spell", ID = 32645 }),
    CyclingVariable                        = Create({ Type = "Spell", ID =  }),
    BreathoftheDying                       = Create({ Type = "Spell", ID =  }),
    ReapingFlames                          = Create({ Type = "Spell", ID =  }),
    SubterfugeBuff                         = Create({ Type = "Spell", ID = 108208 }),
    ArcaneTorrent                          = Create({ Type = "Spell", ID = 50613 }),
    ArcanePulse                            = Create({ Type = "Spell", ID =  }),
    LightsJudgment                         = Create({ Type = "Spell", ID = 255647 }),
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
A:CreateCovenantsFor(ACTION_CONST_ROGUE_ASSASSINATION)  -- where PLAYERSPEC is Constance (example: ACTION_CONST_MONK_BM)
local A = setmetatable(Action[ACTION_CONST_ROGUE_ASSASSINATION], { __index = Action })


------------------------------------------
---------------- VARIABLES ---------------
------------------------------------------
local VarVendettaSubterfugeCondition = 0;
local VarVendettaNightstalkerCondition = 0;
local VarVendettaFontCondition = 0;
local VarSsVanishCondition = 0;
local VarEnergyRegenCombined = 0;
local VarSingleUnit(unit) = 0;
local VarUseFiller = 0;
local VarSkipCycleGarrote = 0;
local VarSkipCycleRupture = 0;
local VarSkipRupture = 0;
local VarReapingDelay = 0;

A.Listener:Add("ROTATION_VARS", "PLAYER_REGEN_ENABLED", function()
  VarVendettaSubterfugeCondition = 0
  VarVendettaNightstalkerCondition = 0
  VarVendettaFontCondition = 0
  VarSsVanishCondition = 0
  VarEnergyRegenCombined = 0
  VarSingleUnit(unit) = 0
  VarUseFiller = 0
  VarSkipCycleGarrote = 0
  VarSkipCycleRupture = 0
  VarSkipRupture = 0
  VarReapingDelay = 0
end)



local function num(val)
    if val then return 1 else return 0 end
end

local function bool(val)
    return val ~= 0
end

------------------------------------------
------ ASSASSINATION PRE APL SETUP -------
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

local function InRange(unit)
	-- @return boolean 
	return A.Mutilate:IsInRange(unit)
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

---------------------------------------------------
-------------- ASSASSINATION PREAPL ---------------
---------------------------------------------------
local BleedTickTime, ExsanguinatedBleedTickTime = 2 / Player:SpellHaste(), 1 / Player:SpellHaste();
local Stealth;
local ComboPoints, ComboPointsDeficit, Energy_Regen_Combined, PoisonedBleeds;
local PriorityRotation;

---------------------------------------------------
---------- ASSASSINATION SPECIFICS ----------------
---------------------------------------------------

-- Rupture TickTime 
-- [1943] = {2000, false}
local function RuptureTickTime()
    return 2
end

-- Garrote TickTime 
-- [703] = {2000, false}
local function GarroteTickTime()
    local BaseTickTime = 2
    local Hasted = false
    if Hasted then
        return BaseTickTime * Player:SpellHaste() 
    end
    return BaseTickTime
end

-- Master Assassin Remains Check
local MasterAssassinBuff, NominalDuration = 256735, 3;
local function MasterAssassinRemains()
    if Unit("player"):HasBuffs(MasterAssassinBuff, true) < 0 then
        return A.GetCurrentGCD() + NominalDuration;
    else
        return Unit("player"):HasBuffs(MasterAssassinBuff, true);
    end
end

-- Poisoned
function Poisoned (unit)
    return (Unit(unit):HasDeBuffs(A.DeadlyPoisonDebuff.ID, true) or Unit(unit):HasDeBuffs(A.WoundPoisonDebuff.ID, true)) and true or false;
end

-- Bleeds
function Bleeds (unit)
    return (Unit(unit):HasDeBuffs(A.Garrote.ID, true) > 0 and 1 or 0) + (Unit(unit):HasDeBuffs(A.Rupture.ID, true) > 0 and 1 or 0)
    + (Unit(unit):HasDeBuffs(A.CrimsonTempest.ID, true) > 0 and 1 or 0) + (Unit(unit):HasDeBuffs(A.InternalBleeding.ID, true) > 0 and 1 or 0);
end

-- Poisoned + Bleeds  
local PoisonedBleedsCount = 0;
function PoisonedBleeds ()
    PoisonedBleedsCount = 0;
    local AppliedGarrote = MultiUnits:GetByRangeAppliedDoTs(40, 5, A.Garrote.ID) -- Garrote count
    local AppliedInternalBleeding = MultiUnits:GetByRangeAppliedDoTs(40, 5, A.InternalBleeding.ID) -- InternalBleeding count
    local AppliedRupture = MultiUnits:GetByRangeAppliedDoTs(40, 5, A.Rupture.ID) -- Rupture count
    
    PoisonedBleedsCount = AppliedGarrote + AppliedInternalBleeding + AppliedRupture
    
    if Unit("target"):IsDummy() then
        PoisonedBleedsCount = 1 * MultiUnits:GetByRange(10)
    end
    
    return PoisonedBleedsCount;
end

---------------------------------------------------
------- SIMC CUSTOM FUNCTION / EXPRESSION ---------
---------------------------------------------------

-- cp_max_spend
local function CPMaxSpend()
    -- Should work for all 3 specs since they have same Deeper Stratagem Spell ID.
    return A.DeeperStratagem:IsSpellLearned() and 6 or 5;
end

-- "cp_spend"
local function CPSpend()
    return mathmin(Player:ComboPoints(), CPMaxSpend());
end

local function NighstalkerMultiplier ()
    return A.Nightstalker:IsSpellLearned() and Player:IsStealthed() and 1.5 or 1;
end
local function SubterfugeGarroteMultiplier ()
    return A.Subterfuge:IsSpellLearned() and Player:IsStealthed() and 2 or 1;
end

A.RegisterPMultiplier( -- Garrote dot and action
    A.Garrote.ID,    -- Garrote action
    A.GarroteDebuff.ID,  -- GarroteDebuff dot
    {function ()
            return (A.Nightstalker:IsSpellLearned() and Player:IsStealthed() and 1.5) or (A.Subterfuge:IsSpellLearned() and Player:IsStealthed() and 2) or 1
    end}
)

A.RegisterPMultiplier( -- Rupture dot and action
    A.Rupture.ID,    -- Rupture action
    A.RuptureDebuff.ID,  -- RuptureDebuff dot
    {function ()
            return A.Nightstalker:IsSpellLearned() and Player:IsStealthed() and 1.5 or 1
    end}
    
)


--[[
-- Spells Damage
A.Envenom:RegisterDamage(
-- Envenom DMG Formula:
--    AP * CP * Env_APCoef * Aura_M * ToxicB_M * DS_M * Mastery_M * Versa_M
function ()
    return
        -- Attack Power
        Player:AttackPower() *
        -- Combo Points
        CPSpend() *
        -- Envenom AP Coef
        0.16 *
        -- Aura Multiplier (SpellID: 137037)
        1.27 *
        -- Toxic Blade Multiplier
        (A.ToxicBlade:IsSpellLearned() and 1.3 or 1) *
        -- Deeper Stratagem Multiplier
        (A.DeeperStratagem:IsSpellLearned() and 1.05 or 1) *
        -- Mastery Finisher Multiplier
        (1 + Player:MasteryPct()/100) *
        -- Versatility Damage Multiplier
        (1 + Player:VersatilityDmgPct()/100);
    end
);
A.Mutilate:RegisterDamage(
    function ()
        return
            -- Attack Power (MH Factor + OH Factor)
            Player:AttackPower() *
            -- Mutilate Coefficient
            0.35 *
            -- Aura Multiplier (SpellID: 137037)
            1.27 *
            -- Versatility Damage Multiplier
            (1 + Player:VersatilityDmgPct()/100);
    end
);
]]--
-- Stealth
function Stealth(Stealth, Setting)
    if Action.GetToggle(2, "StealthOOC") and Stealth:IsReady("player") and not Player:IsStealthed() then
        return Stealth:Show(icon)
    end
    return false;
end

---------------------------------------------------
------------------- DEFENSIVES --------------------
---------------------------------------------------

-- Crimson Vial
function CrimsonVial(CrimsonVial)
    if A.CrimsonVial:IsReady(unit) and Unit("player"):HealthPercent() <= Action.GetToggle(2, "CrimsonVialHP") then
        return A.CrimsonVial:Show(icon)
    end
    return false;
end

-- Feint
function Feint(Feint)
    if A.Feint:IsReady(unit) and not Unit("player"):HasBuffs(A.Feint.ID, true) and Unit("player"):HealthPercent() <= Action.GetToggle(2, "FeintHP") then
        return A.Feint:Show(icon)
    end
end

-- SelfDefensives
local function SelfDefensives(unit)
    local HPLoosePerSecond = Unit("player"):GetDMG() * 100 / Unit("player"):HealthMax()
    
    if Unit("player"):CombatTime() == 0 then 
        return 
    end 
    
    -- Emergency Evade
    local Evade = Action.GetToggle(2, "EvadeHP")
    if     Evade >= 0 and A.Evade:IsReady("player") and 
    (
        (   -- Auto 
            Evade >= 100 and 
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
            Evade < 100 and 
            Unit("player"):HealthPercent() <= Evade
        )
    ) 
    then 
        return A.Evade
    end  
    
    -- Emergency Feint
    local Feint = Action.GetToggle(2, "FeintHP")
    if     Feint >= 0 and A.Feint:IsReady("player") and 
    (
        (   -- Auto 
            Feint >= 100 and 
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
            Feint < 100 and 
            Unit("player"):HealthPercent() <= Feint
        )
    ) 
    then 
        return A.Feint
    end          
    
    -- Emergency CrimsonVial
    local CrimsonVial = Action.GetToggle(2, "CrimsonVialHP")
    if     CrimsonVial >= 0 and A.CrimsonVial:IsReady("player") and 
    (
        (   -- Auto 
            CrimsonVial >= 100 and 
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
            CrimsonVial < 100 and 
            Unit("player"):HealthPercent() <= CrimsonVial
        )
    ) 
    then 
        return A.CrimsonVial
    end          
    
    -- Emergency Cloak of Shadow
    local CloakofShadow = Action.GetToggle(2, "CloakofShadowHP")
    if     CloakofShadow >= 0 and A.CloakofShadow:IsReady("player") and 
    (
        (   -- Auto 
            CloakofShadow >= 100 and 
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
            CloakofShadow < 100 and 
            Unit("player"):HealthPercent() <= CloakofShadow
        )
    ) 
    then 
        return A.CloakofShadow
    end 
    
    -- Emergency Vanish
    local Vanish = Action.GetToggle(2, "VanishDefensive")
    if     Vanish >= 0 and A.Vanish:IsReady("player") and 
    (
        (   -- Auto 
            Vanish >= 100 and 
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
            Vanish < 100 and 
            Unit("player"):HealthPercent() <= Vanish
        )
    ) 
    then 
        return A.Vanish
    end  
    
    -- HealingPotion
    local AbyssalHealingPotion = A.GetToggle(2, "AbyssalHealingPotionHP")
    if     AbyssalHealingPotion >= 0 and A.AbyssalHealingPotion:IsReady("player") and 
    (
        (     -- Auto 
            AbyssalHealingPotion >= 100 and 
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
            AbyssalHealingPotion < 100 and 
            Unit("player"):HealthPercent() <= AbyssalHealingPotion
        )
    ) 
    then 
        return A.AbyssalHealingPotion
    end 
    
end 
SelfDefensives = A.MakeFunctionCachedDynamic(SelfDefensives)

local function RefreshPoisons()
    local choice = Action.GetToggle(2, "PoisonToUse")
    -- Crippling Poison
    if A.CripplingPoison:IsReady("player") and (Unit("player"):HasBuffs(A.CripplingPoison.ID, true) <= 10 or Unit("player"):HasBuffs(A.CripplingPoison.ID, true) == 0) and A.LastPlayerCastName ~= A.CripplingPoison:Info() and not Unit("player"):IsCasting() then
        return A.CripplingPoison
    end    
    -- Wound Poison
    if choice == "Wound Poison" then 
        if A.WoundPoison:IsReady("player") and (Unit("player"):HasBuffs(A.WoundPoison.ID, true) <= 10 or Unit("player"):HasBuffs(A.WoundPoison.ID, true) == 0) and A.LastPlayerCastName ~= A.WoundPoison:Info() and not Unit("player"):IsCasting() then 
            return A.WoundPoison
        end
        -- Deadly Poison
    elseif choice == "Deadly Poison" then
        if A.DeadlyPoison:IsReady("player") and (Unit("player"):HasBuffs(A.DeadlyPoison.ID, true) <= 10 or Unit("player"):HasBuffs(A.DeadlyPoison.ID, true) == 0) and A.LastPlayerCastName ~= A.DeadlyPoison:Info() and not Unit("player"):IsCasting() then 
            return A.DeadlyPoison
        end
    elseif choice == "Auto" then
        -- Auto
        if Action.IsInPvP and A.WoundPoison:IsReady("player") and (Unit("player"):HasBuffs(A.WoundPoison.ID, true) <= 10 or Unit("player"):HasBuffs(A.WoundPoison.ID, true) == 0) and A.LastPlayerCastName ~= A.WoundPoison:Info() and not Unit("player"):IsCasting() then         
            return A.WoundPoison
        else
            if A.DeadlyPoison:IsReady("player") and (Unit("player"):HasBuffs(A.DeadlyPoison.ID, true) <= 10 or Unit("player"):HasBuffs(A.DeadlyPoison.ID, true) == 0) and not Action.IsInPvP and A.LastPlayerCastName ~= A.DeadlyPoison:Info() and not Unit("player"):IsCasting() then
                return A.DeadlyPoison
            end
        end
    else
        return
    end    
end
RefreshPoisons = A.MakeFunctionCachedDynamic(RefreshPoisons)

-- Non GCD spell check
local function countInterruptGCD(unit)
    if not A.Kick:IsReadyByPassCastGCD(unit) or not A.Kick:AbsentImun(unit, Temp.TotalAndMagKick) then
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
        if useKick and A.Kick:IsReady(unit) and A.Kick:AbsentImun(unit, Temp.TotalAndMagKick, true) then 
            -- Notification                    
            Action.SendNotification("Kick on : " .. UnitName(unit), A.Kick.ID)
            return A.Kick
        end 
    
        if useCC and A.Gouge:IsReady(unit) and A.Gouge:AbsentImun(unit, Temp.TotalAndCC, true) and Unit(unit):IsControlAble("stun") then 
            -- Notification                    
            Action.SendNotification("Gouge on : " .. UnitName(unit), A.Gouge.ID)
            return A.Gouge              
        end          
    
        if useCC and Player:IsStealthed() and A.CheapShot:IsReady(unit) and A.CheapShot:AbsentImun(unit, Temp.TotalAndCC, true) and Unit(unit):IsControlAble("stun") then 
            -- Notification                    
            Action.SendNotification("CheapShot on : " .. UnitName(unit), A.CheapShot.ID)
            return A.CheapShot              
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


local function Interrupts(unit)
    local useKick, useCC, useRacial = A.InterruptIsValid(unit, "TargetMouseover")    
    
    if useKick and A.Kick:IsReady(unit) and A.Kick:AbsentImun(unit, Temp.TotalAndMagKick, true) and Unit(unit):CanInterrupt(true, nil, 25, 70) then 
        -- Notification                    
        Action.SendNotification("Kick on : " .. UnitName(unit), A.Kick.ID)
        return A.Kick
    end 
    
    if useCC and A.Gouge:IsReady(unit) and A.Gouge:AbsentImun(unit, Temp.TotalAndCC, true) and Unit(unit):IsControlAble("stun") then 
        -- Notification                    
        Action.SendNotification("Gouge on : " .. UnitName(unit), A.Gouge.ID)
        return A.Gouge              
    end          
    
    if useCC and Player:IsStealthed() and A.CheapShot:IsReady(unit) and A.CheapShot:AbsentImun(unit, Temp.TotalAndCC, true) and Unit(unit):IsControlAble("stun") then 
        -- Notification                    
        Action.SendNotification("CheapShot on : " .. UnitName(unit), A.CheapShot.ID)
        return A.CheapShot              
    end
    
    if useRacial and A.QuakingPalm:AutoRacial(unit) then 
        -- Notification                    
        Action.SendNotification("QuakingPalm on : " .. UnitName(unit), A.QuakingPalm.ID)
        return A.QuakingPalm
    end 
    
    if useRacial and A.Haymaker:AutoRacial(unit) then 
        -- Notification                    
        Action.SendNotification("Haymaker on : " .. UnitName(unit), A.Haymaker.ID)
        return A.Haymaker
    end 
    
    if useRacial and A.WarStomp:AutoRacial(unit) then 
        -- Notification                    
        Action.SendNotification("WarStomp on : " .. UnitName(unit), A.WarStomp.ID)
        return A.WarStomp
    end 
    
    if useRacial and A.BullRush:AutoRacial(unit) then 
        -- Notification                    
        Action.SendNotification("BullRush on : " .. UnitName(unit), A.BullRush.ID)
        return A.BullRush
    end      
end 
Interrupts = A.MakeFunctionCachedDynamic(Interrupts)



-------------------------------
---- CUSTOM ROGUE FCT ---------
-------------------------------
-- TODO: Register/Unregister Events on SpecChange
Action.BleedTable = {
    Assassination = {
        Garrote = {},
        Rupture = {},
		CrimsonTempest = {}
    },
    --Subtlety = {
    --  Nightblade = {},
    --}
}

local BleedGUID

--- Exsanguinated Handler
-- Exsanguinate Expression
local BleedDuration, BleedExpires;
local function Exsanguinated(unit, SpellName)
    BleedGUID = UnitGUID(unit)
    if BleedGUID then
        if SpellName == "Garrote" then
            if Action.BleedTable.Assassination.Garrote[BleedGUID] then
                return Action.BleedTable.Assassination.Garrote[BleedGUID][3];
            end
        elseif SpellName == "Rupture" then
            if Action.BleedTable.Assassination.Rupture[BleedGUID] then
                return Action.BleedTable.Assassination.Rupture[BleedGUID][3];
            end
        elseif SpellName == "CrimsonTempest" then
            if Action.BleedTable.Assassination.CrimsonTempest[BleedGUID] then
                return Action.BleedTable.Assassination.CrimsonTempest[BleedGUID][3];
            end
        end
    end
    return false
end

-- Exsanguinate OnCast Listener
Action:RegisterForSelfCombatEvent(function (...)
        DestGUID, _, _, _, SpellID = select(8, ...)
        
        -- Exsanguinate
        if SpellID == 200806 then
            for Key, _ in pairs(Action.BleedTable.Assassination) do
                for Key2, _ in pairs(Action.BleedTable.Assassination[Key]) do
                    if Key2 == DestGUID then
                        -- Change the Exsanguinate info to true
                        Action.BleedTable.Assassination[Key][Key2][3] = true
                    end
                end
            end
        end
    end
    , "SPELL_CAST_SUCCESS"
);

-- Bleed infos
local function GetBleedInfos (GUID, SpellID)
    -- Core API is not used since we don't want cached informations
    for i = 1, 40 do
        local auraInfo = {UnitAura(GUID, i, "HARMFUL|PLAYER")}
        if auraInfo[10] == SpellID then
            return auraInfo[5]
        end
    end
    return nil
end

-- Bleed OnApply/OnRefresh Listener
Action:RegisterForSelfCombatEvent(
    function (...)
        DestGUID, _, _, _, SpellID = select(8, ...)
        
        --- Record the Bleed Target and its Infos
        -- Garrote
        if SpellID == 703 then
            BleedDuration, BleedExpires = GetBleedInfos(DestGUID, SpellID);
            Action.BleedTable.Assassination.Garrote[DestGUID] = {BleedDuration, BleedExpires, false}
            -- Rupture
        elseif SpellID == 1943 then
            BleedDuration, BleedExpires = GetBleedInfos(DestGUID, SpellID);
            Action.BleedTable.Assassination.Rupture[DestGUID] = {BleedDuration, BleedExpires, false}
        end
    end
    , "SPELL_AURA_APPLIED"
    , "SPELL_AURA_REFRESH"
);

-- Bleed OnRemove Listener
Action:RegisterForSelfCombatEvent(function (...)
        DestGUID, _, _, _, SpellID = select(8, ...)
        
        -- Removes the Unit from Garrote Table
        if SpellID == 703 then
            if Action.BleedTable.Assassination.Garrote[DestGUID] then
                Action.BleedTable.Assassination.Garrote[DestGUID] = nil
            end
            -- Removes the Unit from Rupture Table
        elseif SpellID == 1943 then
            if Action.BleedTable.Assassination.Rupture[DestGUID] then
                Action.BleedTable.Assassination.Rupture[DestGUID] = nil
            end
        end
    end
    , "SPELL_AURA_REMOVED"
);

-- Bleed OnUnitDeath Listener
Action:RegisterForCombatEvent(function (...)
        DestGUID = select(8, ...)
        
        -- Removes the Unit from Garrote Table
        if Action.BleedTable.Assassination.Garrote[DestGUID] then
            Action.BleedTable.Assassination.Garrote[DestGUID] = nil
        end
        -- Removes the Unit from Rupture Table
        if Action.BleedTable.Assassination.Rupture[DestGUID] then
            Action.BleedTable.Assassination.Rupture[DestGUID] = nil
        end
    end
    , "UNIT_DIED"
    , "UNIT_DESTROYED"
);


-- Return the lowest Unit TTD value
-- Used as snipping function 
local function LowestTTD()
    local lowTTD = 0
    for activeunits in pairs(ActiveUnitPlates) do
        if (lowTTD == 0 or Unit(activeunits):TimeToDie() < lowTTD) then
            lowTTD = Unit(activeunits):TimeToDie()
        end
    end
    return lowTTD
end

-- Marked for Death Sniping
-- Will try to get best unit to apply Marked for Death considering time to die to get cooldown reset
local BestUnit, BestUnitTTD;
local function MfDSniping(unit)
    local unit = "target"
    
    if A.MarkedforDeath:IsReady(unit) and A.MarkedforDeath:IsSpellLearned() then
        -- Get Units up to 30y for MfD.        
        BestUnit, BestUnitTTD = nil, 60;
        local unit = "target"
        local MOunit = "mouseover"
        local MOTTD = Unit("mouseover"):GetRange() <= 30 and Unit("mouseover"):TimeToDie() or 11111;
        local TTD = Unit(unit):TimeToDie()
        
        for CycleUnit in pairs(ActiveUnitPlates) do
            
            -- Note: Increased the SimC condition by 50% since we are slower.
            -- TEST - REMOVED 50% lowered value on Action
            if not Unit(CycleUnit):IsMfdBlacklisted() and TTD < Player:ComboPointsDeficit() * 1 and TTD < BestUnitTTD then
                if MOTTD - TTD > 1 then
                    BestUnit, BestUnitTTD = Unit(CycleUnit), TTD;
                else
                    BestUnit, BestUnitTTD = MouseOver, MOTTD;
                end
            end
        end
        if BestUnit and BestUnit:InfoGUID() ~= Unit(CycleUnit):InfoGUID() then
            return A:Show(icon, ACTION_CONST_AUTOTARGET)
        end
    end
end

-- Fake SSBuffed (wonky without Subterfuge but why would you, eh?)
local function SSBuffed()
    return A.ShroudedSuffocation:GetAzeriteRank() > 0
end

-- non_SSBuffed_targets
local function NonSSBuffedTargets()
    local count = 0;
    
    local MissingGarrote = MultiUnits:GetByRangeMissedDoTs(10, 5, A.Garrote.ID)   
    
    count = MissingGarrote
    
    return count;
end

-- SSBuffed_targets_above_pandemic
local function SSBuffedTargetsAbovePandemic()
    local count = 0;
    local GarroteToRefresh = MultiUnits:GetByRangeDoTsToRefresh(10, 5, A.Garrote.ID, 5.4)
    local AppliedGarrote = MultiUnits:GetByRangeAppliedDoTs(10, 5, A.Garrote.ID) -- Garrote count
    
    count = AppliedGarrote - GarroteToRefresh
    
    return count;
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

-- ExpectedCombatLength
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

local function EvaluateTargetIfFilterMarkedForDeath35(unit)
  return Unit(unit):TimeToDie()
end

local function EvaluateTargetIfMarkedForDeath40(unit)
  return (MultiUnits:GetByRangeInCombat(40, 5, 10) > 1) and (Unit(unit):TimeToDie() < Player:ComboPointsDeficit() * 1.5 or Player:ComboPointsDeficit() >= CPMaxSpend())
end


local function EvaluateCycleFanofKnives308(unit)
    return (not Unit(unit):HasDeBuffs(A.DeadlyPoisonDotDebuff.ID, true)) and (VarUseFiller and MultiUnits:GetByRangeInCombat(10, 5, 10) >= 3)
end

local function EvaluateCycleMutilate329(unit)
    return (not Unit(unit):HasDeBuffs(A.DeadlyPoisonDotDebuff.ID, true)) and (VarUseFiller and MultiUnits:GetByRangeInCombat(10, 5, 10) == 2)
end

local function EvaluateCycleGarrote448(unit)
  return not VarSkipCycleGarrote and Unit(unit) ~= self.target and Unit(unit):HasDeBuffsRefreshable(A.GarroteDebuff.ID, true) and Player:ComboPointsDeficit() >= 1 + 3 * num((A.ShroudedSuffocation:GetAzeriteRank() > 0 and A.Vanish:GetCooldown() == 0)) and (A.PMultiplier(unit, A.GarroteDebuff.ID) <= 1 or Unit(unit):HasDeBuffs(A.GarroteDebuff.ID, true) <= A.GarroteDebuff.ID, true:TickTime() and MultiUnits:GetByRangeInCombat(10, 5, 10) >= 3 + A.ShroudedSuffocation:GetAzeriteRank() > 0) and (not A.Exsanguinated(Unit(unit), "Garrote") or Unit(unit):HasDeBuffs(A.GarroteDebuff.ID, true) <= A.GarroteDebuff.ID, true:TickTime() * 2 and MultiUnits:GetByRangeInCombat(10, 5, 10) >= 3 + A.ShroudedSuffocation:GetAzeriteRank() > 0) and not ss_buffed and (Unit(unit):TimeToDie() - Unit(unit):HasDeBuffs(A.GarroteDebuff.ID, true)) > 12 and (MasterAssassinRemains == 0 or not Unit(unit):HasDeBuffs(A.GarroteDebuff.ID, true) and A.ShroudedSuffocation:GetAzeriteRank() > 0)
end

local function EvaluateTargetIfFilterCrimsonTempest514(unit)
  return Unit("player"):HasBuffs(A.CrimsonTempestBuff.ID, true)
end

local function EvaluateTargetIfCrimsonTempest551(unit)
  return MultiUnits:GetByRangeInCombat(40, 5, 10) > 3 and Unit("player"):HasBuffs(A.CrimsonTempestBuff.ID, true) < 2 + num((MultiUnits:GetByRangeInCombat(40, 5, 10) >= 5)) and Player:ComboPoints() >= 4
end


local function EvaluateCycleRupture614(unit)
  return not VarSkipCycleRupture and not VarSkipRupture and Unit(unit) ~= self.target and Player:ComboPoints() >= 4 and Unit(unit):HasDeBuffsRefreshable(A.RuptureDebuff.ID, true) and (A.PMultiplier(unit, A.RuptureDebuff.ID) <= 1 or Unit(unit):HasDeBuffs(A.RuptureDebuff.ID, true) <= A.RuptureDebuff.ID, true:TickTime() and MultiUnits:GetByRangeInCombat(10, 5, 10) >= 3 + A.ShroudedSuffocation:GetAzeriteRank() > 0) and (not A.Exsanguinated(Unit(unit), "Rupture") or Unit(unit):HasDeBuffs(A.RuptureDebuff.ID, true) <= A.RuptureDebuff.ID, true:TickTime() * 2 and MultiUnits:GetByRangeInCombat(10, 5, 10) >= 3 + A.ShroudedSuffocation:GetAzeriteRank() > 0) and Unit(unit):TimeToDie() - Unit(unit):HasDeBuffs(A.RuptureDebuff.ID, true) > 4 + num((PoisonedBleeds() > 2)) * 6
end

local function EvaluateTargetIfFilterCrimsonTempest670(unit)
  return Unit("player"):HasBuffs(A.CrimsonTempestBuff.ID, true)
end

local function EvaluateTargetIfCrimsonTempest707(unit)
  return MultiUnits:GetByRangeInCombat(40, 5, 10) > 1 and MultiUnits:GetByRangeInCombat(40, 5, 10) < 4 and Unit("player"):HasBuffs(A.CrimsonTempestBuff.ID, true) < 2 and Player:ComboPoints() >= 4
end


local function EvaluateCycleReapingFlames826(unit)
    return Unit(unit):TimeToDie() < 1.5 or ((Unit(unit):HealthPercent() > 80 or Unit(unit):HealthPercent() <= 20) and (MultiUnits:GetByRangeInCombat(40, 5, 10) == 1 or VarReapingDelay > 29)) or (target.time_to_pct_20 > 30 and (MultiUnits:GetByRangeInCombat(40, 5, 10) == 1 or VarReapingDelay > 44))
end

local function EvaluateTargetIfFilterGarrote870(unit)
  return Unit(unit):HasDeBuffs(A.GarroteDebuff.ID, true)
end

local function EvaluateTargetIfGarrote905(unit)
  return A.Subterfuge:IsSpellLearned() and (Unit(unit):HasDeBuffs(A.GarroteDebuff.ID, true) < 12 or A.PMultiplier(unit, A.GarroteDebuff.ID) <= 1) and Unit(unit):TimeToDie() - Unit(unit):HasDeBuffs(A.GarroteDebuff.ID, true) > 2
end


local function EvaluateTargetIfFilterGarrote923(unit)
  return Unit(unit):HasDeBuffs(A.GarroteDebuff.ID, true)
end

local function EvaluateTargetIfGarrote964(unit)
  return A.Subterfuge:IsSpellLearned() and A.ShroudedSuffocation:GetAzeriteRank() > 0 and (MultiUnits:GetByRangeInCombat(40, 5, 10) > 1 or not A.Exsanguinate:IsSpellLearned()) and Unit(unit):TimeToDie() > Unit(unit):HasDeBuffs(A.GarroteDebuff.ID, true) and (Unit(unit):HasDeBuffs(A.GarroteDebuff.ID, true) < 18 or not ss_buffed)
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
            -- augmentation
            -- food
            -- snapshot_stats
            -- potion
            if A.PotionofSpectralAgility:IsReady(unit) and Potion then
                return A.PotionofSpectralAgility:Show(icon)
            end
            
            -- marked_for_death,precombat_seconds=5,if=raid_event.adds.in>15
            if A.MarkedForDeath:IsReady(unit) and (IncomingAddsIn > 15) then
                return A.MarkedForDeath:Show(icon)
            end
            
            -- apply_poison
            if A.ApplyPoison:IsReady(unit) then
                return A.ApplyPoison:Show(icon)
            end
            
            -- stealth
            if A.Stealth:IsReady(unit) then
                return A.Stealth:Show(icon)
            end
            
            -- use_item,name=azsharas_font_of_power
            if A.AzsharasFontofPower:IsReady(unit) then
                return A.AzsharasFontofPower:Show(icon)
            end
            
            -- guardian_of_azeroth,if=talent.exsanguinate.enabled
            if A.GuardianofAzeroth:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and (A.Exsanguinate:IsSpellLearned()) then
                return A.GuardianofAzeroth:Show(icon)
            end
            
        end
        
        --Cds
        local function Cds(unit)
        
            -- use_item,name=azsharas_font_of_power,if=!stealthed.all&master_assassin_remains=0&(cooldown.vendetta.remains<?(cooldown.toxic_blade.remains*equipped.ashvanes_razor_coral))<10+10*equipped.ashvanes_razor_coral&!debuff.vendetta.up&!debuff.toxic_blade.up
            if A.AzsharasFontofPower:IsReady(unit) and (not Unit("player"):IsStealthed(true, true) and MasterAssassinRemains == 0 and num((A.Vendetta:GetCooldown() < ?{})) < 10 + 10 * num(A.AshvanesRazorCoral:IsExists()) and not Unit(unit):HasDeBuffs(A.VendettaDebuff.ID, true) and not Unit(unit):HasDeBuffs(A.ToxicBladeDebuff.ID, true)) then
                return A.AzsharasFontofPower:Show(icon)
            end
            
            -- call_action_list,name=essences,if=!stealthed.all&dot.rupture.ticking&master_assassin_remains=0
            if (not Unit("player"):IsStealthed(true, true) and Unit(unit):HasDeBuffs(A.RuptureDebuff.ID, true) and MasterAssassinRemains == 0) then
                if Essences(unit) then
                    return true
                end
            end
            
            -- marked_for_death,target_if=min:target.time_to_die,if=raid_event.adds.up&(target.time_to_die<combo_points.deficit*1.5|combo_points.deficit>=cp_max_spend)
            if A.MarkedForDeath:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.MarkedForDeath, 40, "min", EvaluateTargetIfFilterMarkedForDeath35, EvaluateTargetIfMarkedForDeath40) then 
                    return A.MarkedForDeath:Show(icon) 
                end
            end
            -- marked_for_death,if=raid_event.adds.in>30-raid_event.adds.duration&combo_points.deficit>=cp_max_spend
            if A.MarkedForDeath:IsReady(unit) and (IncomingAddsIn > 30 - raid_event.adds.duration and Player:ComboPointsDeficit() >= CPMaxSpend()) then
                return A.MarkedForDeath:Show(icon)
            end
            
            -- variable,name=vendetta_subterfuge_condition,value=!talent.subterfuge.enabled|!azerite.shrouded_suffocation.enabled|dot.garrote.pmultiplier>1&(spell_targets.fan_of_knives<6|!cooldown.vanish.up)
            VarVendettaSubterfugeCondition = num(not A.Subterfuge:IsSpellLearned() or not A.ShroudedSuffocation:GetAzeriteRank() > 0 or A.PMultiplier(unit, A.GarroteDebuff.ID) > 1 and (MultiUnits:GetByRangeInCombat(10, 5, 10) < 6 or not A.Vanish:GetCooldown() == 0))
            
            -- variable,name=vendetta_nightstalker_condition,value=!talent.nightstalker.enabled|!talent.exsanguinate.enabled|cooldown.exsanguinate.remains<5-2*talent.deeper_stratagem.enabled
            VarVendettaNightstalkerCondition = num(not A.Nightstalker:IsSpellLearned() or not A.Exsanguinate:IsSpellLearned() or A.Exsanguinate:GetCooldown() < 5 - 2 * num(A.DeeperStratagem:IsSpellLearned()))
            
            -- variable,name=variable,name=vendetta_font_condition,value=!equipped.azsharas_font_of_power|azerite.shrouded_suffocation.enabled|debuff.razor_coral_debuff.down|trinket.ashvanes_razor_coral.cooldown.remains<10&(cooldown.toxic_blade.remains<1|debuff.toxic_blade.up)
            VarVendettaFontCondition = num(not A.AzsharasFontofPower:IsExists() or A.ShroudedSuffocation:GetAzeriteRank() > 0 or Unit(unit):HasDeBuffsDown(A.RazorCoralDebuff.ID, true) or trinket.ashvanes_razor_coral.cooldown.remains < 10 and (A.ToxicBlade:GetCooldown() < 1 or Unit(unit):HasDeBuffs(A.ToxicBladeDebuff.ID, true)))
            
            -- vendetta,if=!stealthed.rogue&((dot.rupture.ticking&!debuff.vendetta.up&variable.vendetta_subterfuge_condition&variable.vendetta_nightstalker_condition&variable.vendetta_font_condition)|fight_remains<=20)
            if A.Vendetta:IsReady(unit) and (not Unit("player"):IsStealthed(true, false) and ((Unit(unit):HasDeBuffs(A.RuptureDebuff.ID, true) and not Unit(unit):HasDeBuffs(A.VendettaDebuff.ID, true) and VarVendettaSubterfugeCondition and VarVendettaNightstalkerCondition and VarVendettaFontCondition) or fight_remains <= 20)) then
                return A.Vendetta:Show(icon)
            end
            
            -- vanish,if=talent.exsanguinate.enabled&talent.nightstalker.enabled&combo_points>=cp_max_spend&cooldown.exsanguinate.remains<1
            if A.Vanish:IsReady(unit) and (A.Exsanguinate:IsSpellLearned() and A.Nightstalker:IsSpellLearned() and Player:ComboPoints() >= CPMaxSpend() and A.Exsanguinate:GetCooldown() < 1) then
                return A.Vanish:Show(icon)
            end
            
            -- vanish,if=talent.nightstalker.enabled&!talent.exsanguinate.enabled&combo_points>=cp_max_spend&(debuff.vendetta.up|essence.vision_of_perfection.enabled)
            if A.Vanish:IsReady(unit) and (A.Nightstalker:IsSpellLearned() and not A.Exsanguinate:IsSpellLearned() and Player:ComboPoints() >= CPMaxSpend() and (Unit(unit):HasDeBuffs(A.VendettaDebuff.ID, true) or A.VisionofPerfection:IsSpellLearned())) then
                return A.Vanish:Show(icon)
            end
            
            -- variable,name=ss_vanish_condition,value=azerite.shrouded_suffocation.enabled&(non_ss_buffed_targets>=1|spell_targets.fan_of_knives=3)&(ss_buffed_targets_above_pandemic=0|spell_targets.fan_of_knives>=6)
            VarSsVanishCondition = num(A.ShroudedSuffocation:GetAzeriteRank() > 0 and (non_ss_buffed_targets >= 1 or MultiUnits:GetByRangeInCombat(10, 5, 10) == 3) and (ss_buffed_targets_above_pandemic == 0 or MultiUnits:GetByRangeInCombat(10, 5, 10) >= 6))
            
            -- pool_resource,for_next=1,extra_amount=45
            -- vanish,if=talent.subterfuge.enabled&!stealthed.rogue&cooldown.garrote.up&(variable.ss_vanish_condition|!azerite.shrouded_suffocation.enabled&(dot.garrote.refreshable|debuff.vendetta.up&dot.garrote.pmultiplier<=1))&combo_points.deficit>=((1+2*azerite.shrouded_suffocation.enabled)*spell_targets.fan_of_knives)>?4&raid_event.adds.in>12
            if A.Vanish:IsReady(unit) and (A.Subterfuge:IsSpellLearned() and not Unit("player"):IsStealthed(true, false) and A.Garrote:GetCooldown() == 0 and (VarSsVanishCondition or not A.ShroudedSuffocation:GetAzeriteRank() > 0 and (Unit(unit):HasDeBuffsRefreshable(A.GarroteDebuff.ID, true) or Unit(unit):HasDeBuffs(A.VendettaDebuff.ID, true) and A.PMultiplier(unit, A.GarroteDebuff.ID) <= 1)) and Player:ComboPointsDeficit() >= num(((1 + 2 * A.ShroudedSuffocation:GetAzeriteRank() > 0) * MultiUnits:GetByRangeInCombat(10, 5, 10)) > ?4) and IncomingAddsIn > 12) then
                if A.Vanish:IsUsablePPool(45) then
                    return A.Vanish:Show(icon)
                else
                    return A.PoolResource:Show(icon)
                end
            end
            
            -- vanish,if=talent.master_assassin.enabled&!stealthed.all&master_assassin_remains<=0&!dot.rupture.refreshable&dot.garrote.remains>3&(debuff.vendetta.up&(!talent.toxic_blade.enabled|debuff.toxic_blade.up)&(!essence.blood_of_the_enemy.major|debuff.blood_of_the_enemy.up)|essence.vision_of_perfection.enabled)
            if A.Vanish:IsReady(unit) and (A.MasterAssassin:IsSpellLearned() and not Unit("player"):IsStealthed(true, true) and MasterAssassinRemains <= 0 and not Unit(unit):HasDeBuffsRefreshable(A.RuptureDebuff.ID, true) and Unit(unit):HasDeBuffs(A.GarroteDebuff.ID, true) > 3 and (Unit(unit):HasDeBuffs(A.VendettaDebuff.ID, true) and (not A.ToxicBlade:IsSpellLearned() or Unit(unit):HasDeBuffs(A.ToxicBladeDebuff.ID, true)) and (not Azerite:EssenceHasMajor(A.BloodoftheEnemy.ID) or Unit(unit):HasDeBuffs(A.BloodoftheEnemyDebuff.ID, true)) or A.VisionofPerfection:IsSpellLearned())) then
                return A.Vanish:Show(icon)
            end
            
            -- shadowmeld,if=!stealthed.all&azerite.shrouded_suffocation.enabled&dot.garrote.refreshable&dot.garrote.pmultiplier<=1&combo_points.deficit>=1
            if A.Shadowmeld:AutoRacial(unit) and Racial and A.BurstIsON(unit) and (not Unit("player"):IsStealthed(true, true) and A.ShroudedSuffocation:GetAzeriteRank() > 0 and Unit(unit):HasDeBuffsRefreshable(A.GarroteDebuff.ID, true) and A.PMultiplier(unit, A.GarroteDebuff.ID) <= 1 and Player:ComboPointsDeficit() >= 1) then
                return A.Shadowmeld:Show(icon)
            end
            
            -- exsanguinate,if=!stealthed.rogue&(!dot.garrote.refreshable&dot.rupture.remains>4+4*cp_max_spend|dot.rupture.remains*0.5>target.time_to_die)&target.time_to_die>4
            if A.Exsanguinate:IsReady(unit) and (not Unit("player"):IsStealthed(true, false) and (not Unit(unit):HasDeBuffsRefreshable(A.GarroteDebuff.ID, true) and Unit(unit):HasDeBuffs(A.RuptureDebuff.ID, true) > 4 + 4 * CPMaxSpend() or Unit(unit):HasDeBuffs(A.RuptureDebuff.ID, true) * 0.5 > Unit(unit):TimeToDie()) and Unit(unit):TimeToDie() > 4) then
                return A.Exsanguinate:Show(icon)
            end
            
            -- toxic_blade,if=dot.rupture.ticking&(!equipped.azsharas_font_of_power|cooldown.vendetta.remains>10)
            if A.ToxicBlade:IsReady(unit) and (Unit(unit):HasDeBuffs(A.RuptureDebuff.ID, true) and (not A.AzsharasFontofPower:IsExists() or A.Vendetta:GetCooldown() > 10)) then
                return A.ToxicBlade:Show(icon)
            end
            
            -- potion,if=buff.bloodlust.react|debuff.vendetta.up
            if A.PotionofSpectralAgility:IsReady(unit) and Potion and (Unit("player"):HasHeroism() or Unit(unit):HasDeBuffs(A.VendettaDebuff.ID, true)) then
                return A.PotionofSpectralAgility:Show(icon)
            end
            
            -- blood_fury,if=debuff.vendetta.up
            if A.BloodFury:AutoRacial(unit) and Racial and A.BurstIsON(unit) and (Unit(unit):HasDeBuffs(A.VendettaDebuff.ID, true)) then
                return A.BloodFury:Show(icon)
            end
            
            -- berserking,if=debuff.vendetta.up
            if A.Berserking:AutoRacial(unit) and Racial and A.BurstIsON(unit) and (Unit(unit):HasDeBuffs(A.VendettaDebuff.ID, true)) then
                return A.Berserking:Show(icon)
            end
            
            -- fireblood,if=debuff.vendetta.up
            if A.Fireblood:AutoRacial(unit) and Racial and A.BurstIsON(unit) and (Unit(unit):HasDeBuffs(A.VendettaDebuff.ID, true)) then
                return A.Fireblood:Show(icon)
            end
            
            -- ancestral_call,if=debuff.vendetta.up
            if A.AncestralCall:AutoRacial(unit) and Racial and A.BurstIsON(unit) and (Unit(unit):HasDeBuffs(A.VendettaDebuff.ID, true)) then
                return A.AncestralCall:Show(icon)
            end
            
            -- use_item,name=galecallers_boon,if=(debuff.vendetta.up|(!talent.exsanguinate.enabled&cooldown.vendetta.remains>45|talent.exsanguinate.enabled&(cooldown.exsanguinate.remains<6|cooldown.exsanguinate.remains>20&fight_remains>65)))&!exsanguinated.rupture
            if A.GalecallersBoon:IsReady(unit) and ((Unit(unit):HasDeBuffs(A.VendettaDebuff.ID, true) or (not A.Exsanguinate:IsSpellLearned() and A.Vendetta:GetCooldown() > 45 or A.Exsanguinate:IsSpellLearned() and (A.Exsanguinate:GetCooldown() < 6 or A.Exsanguinate:GetCooldown() > 20 and fight_remains > 65))) and not A.Exsanguinated(Unit(unit), "UseItem")) then
                return A.GalecallersBoon:Show(icon)
            end
            
            -- use_item,name=ashvanes_razor_coral,if=debuff.razor_coral_debuff.down|fight_remains<20
            if A.AshvanesRazorCoral:IsReady(unit) and (Unit(unit):HasDeBuffsDown(A.RazorCoralDebuff.ID, true) or fight_remains < 20) then
                return A.AshvanesRazorCoral:Show(icon)
            end
            
            -- use_item,name=ashvanes_razor_coral,if=(!talent.exsanguinate.enabled|!talent.subterfuge.enabled)&debuff.vendetta.remains>10-4*equipped.azsharas_font_of_power
            if A.AshvanesRazorCoral:IsReady(unit) and ((not A.Exsanguinate:IsSpellLearned() or not A.Subterfuge:IsSpellLearned()) and Unit(unit):HasDeBuffs(A.VendettaDebuff.ID, true) > 10 - 4 * num(A.AzsharasFontofPower:IsExists())) then
                return A.AshvanesRazorCoral:Show(icon)
            end
            
            -- use_item,name=ashvanes_razor_coral,if=(talent.exsanguinate.enabled&talent.subterfuge.enabled)&debuff.vendetta.up&(exsanguinated.garrote|azerite.shrouded_suffocation.enabled&dot.garrote.pmultiplier>1)
            if A.AshvanesRazorCoral:IsReady(unit) and ((A.Exsanguinate:IsSpellLearned() and A.Subterfuge:IsSpellLearned()) and Unit(unit):HasDeBuffs(A.VendettaDebuff.ID, true) and (A.Exsanguinated(Unit(unit), "UseItem") or A.ShroudedSuffocation:GetAzeriteRank() > 0 and A.PMultiplier(unit, A.GarroteDebuff.ID) > 1)) then
                return A.AshvanesRazorCoral:Show(icon)
            end
            
            -- use_item,effect_name=cyclotronic_blast,if=master_assassin_remains=0&!debuff.vendetta.up&!debuff.toxic_blade.up&buff.memory_of_lucid_dreams.down&energy<80&dot.rupture.remains>4
            if A.CyclotronicBlast:IsReady(unit) and (MasterAssassinRemains == 0 and not Unit(unit):HasDeBuffs(A.VendettaDebuff.ID, true) and not Unit(unit):HasDeBuffs(A.ToxicBladeDebuff.ID, true) and Unit("player"):HasBuffsDown(A.MemoryofLucidDreamsBuff.ID, true) and Player:EnergyPredicted() < 80 and Unit(unit):HasDeBuffs(A.RuptureDebuff.ID, true) > 4) then
                return A.CyclotronicBlast:Show(icon)
            end
            
            -- use_item,name=lurkers_insidious_gift,if=debuff.vendetta.up
            if A.LurkersInsidiousGift:IsReady(unit) and (Unit(unit):HasDeBuffs(A.VendettaDebuff.ID, true)) then
                return A.LurkersInsidiousGift:Show(icon)
            end
            
            -- use_item,name=lustrous_golden_plumage,if=debuff.vendetta.up
            if A.LustrousGoldenPlumage:IsReady(unit) and (Unit(unit):HasDeBuffs(A.VendettaDebuff.ID, true)) then
                return A.LustrousGoldenPlumage:Show(icon)
            end
            
            -- use_item,effect_name=gladiators_medallion,if=debuff.vendetta.up
            if A.GladiatorsMedallion:IsReady(unit) and (Unit(unit):HasDeBuffs(A.VendettaDebuff.ID, true)) then
                return A.GladiatorsMedallion:Show(icon)
            end
            
            -- use_item,effect_name=gladiators_badge,if=debuff.vendetta.up
            if A.GladiatorsBadge:IsReady(unit) and (Unit(unit):HasDeBuffs(A.VendettaDebuff.ID, true)) then
                return A.GladiatorsBadge:Show(icon)
            end
            
            -- use_items
        end
        
        --Direct
        local function Direct(unit)
        
            -- envenom,if=combo_points>=4+talent.deeper_stratagem.enabled&(debuff.vendetta.up|debuff.toxic_blade.up|energy.deficit<=25+variable.energy_regen_combined|!variable.single_target)&(!talent.exsanguinate.enabled|!debuff.vendetta.up|cooldown.exsanguinate.remains>2)
            if A.Envenom:IsReady(unit) and (Player:ComboPoints() >= 4 + num(A.DeeperStratagem:IsSpellLearned()) and (Unit(unit):HasDeBuffs(A.VendettaDebuff.ID, true) or Unit(unit):HasDeBuffs(A.ToxicBladeDebuff.ID, true) or Player:EnergyDeficitPredicted() <= 25 + VarEnergyRegenCombined or not VarSingleUnit(unit)) and (not A.Exsanguinate:IsSpellLearned() or not Unit(unit):HasDeBuffs(A.VendettaDebuff.ID, true) or A.Exsanguinate:GetCooldown() > 2)) then
                return A.Envenom:Show(icon)
            end
            
            -- variable,name=use_filler,value=combo_points.deficit>1|energy.deficit<=25+variable.energy_regen_combined|!variable.single_target
            VarUseFiller = num(Player:ComboPointsDeficit() > 1 or Player:EnergyDeficitPredicted() <= 25 + VarEnergyRegenCombined or not VarSingleUnit(unit))
            
            -- fan_of_knives,if=variable.use_filler&azerite.echoing_blades.enabled&spell_targets.fan_of_knives>=2+(debuff.vendetta.up*(1+(azerite.echoing_blades.rank=1)))
            if A.FanofKnives:IsReady(unit) and (VarUseFiller and A.EchoingBlades:GetAzeriteRank() > 0 and MultiUnits:GetByRangeInCombat(10, 5, 10) >= 2 + (num(Unit(unit):HasDeBuffs(A.VendettaDebuff.ID, true)) * (1 + num((A.EchoingBlades:GetAzeriteRank() == 1))))) then
                return A.FanofKnives:Show(icon)
            end
            
            -- fan_of_knives,if=variable.use_filler&(buff.hidden_blades.stack>=19|(!priority_rotation&spell_targets.fan_of_knives>=4+(azerite.double_dose.rank>2)+stealthed.rogue))
            if A.FanofKnives:IsReady(unit) and (VarUseFiller and (Unit("player"):HasBuffsStacks(A.HiddenBladesBuff.ID, true) >= 19 or (not priority_rotation and MultiUnits:GetByRangeInCombat(10, 5, 10) >= 4 + num((A.DoubleDose:GetAzeriteRank() > 2)) + num(Unit("player"):IsStealthed(true, false))))) then
                return A.FanofKnives:Show(icon)
            end
            
            -- fan_of_knives,target_if=!dot.deadly_poison_dot.ticking,if=variable.use_filler&spell_targets.fan_of_knives>=3
            if A.FanofKnives:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.FanofKnives, 10, "min", EvaluateCycleFanofKnives308) then
                    return A.FanofKnives:Show(icon) 
                end
            end
            -- blindside,if=variable.use_filler&(buff.blindside.up|!talent.venom_rush.enabled&!azerite.double_dose.enabled)
            if A.Blindside:IsReady(unit) and (VarUseFiller and (Unit("player"):HasBuffs(A.BlindsideBuff.ID, true) or not A.VenomRush:IsSpellLearned() and not A.DoubleDose:GetAzeriteRank() > 0)) then
                return A.Blindside:Show(icon)
            end
            
            -- mutilate,target_if=!dot.deadly_poison_dot.ticking,if=variable.use_filler&spell_targets.fan_of_knives=2
            if A.Mutilate:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.Mutilate, 40, "min", EvaluateCycleMutilate329) then
                    return A.Mutilate:Show(icon) 
                end
            end
            -- mutilate,if=variable.use_filler
            if A.Mutilate:IsReady(unit) and (VarUseFiller) then
                return A.Mutilate:Show(icon)
            end
            
        end
        
        --Dot
        local function Dot(unit)
        
            -- variable,name=skip_cycle_garrote,value=priority_rotation&spell_targets.fan_of_knives>3&(dot.garrote.remains<cooldown.garrote.duration|poisoned_bleeds>5)
            VarSkipCycleGarrote = num(priority_rotation and MultiUnits:GetByRangeInCombat(10, 5, 10) > 3 and (Unit(unit):HasDeBuffs(A.GarroteDebuff.ID, true) < A.Garrote:BaseDuration() or PoisonedBleeds() > 5))
            
            -- variable,name=skip_cycle_rupture,value=priority_rotation&spell_targets.fan_of_knives>3&(debuff.toxic_blade.up|(poisoned_bleeds>5&!azerite.scent_of_blood.enabled))
            VarSkipCycleRupture = num(priority_rotation and MultiUnits:GetByRangeInCombat(10, 5, 10) > 3 and (Unit(unit):HasDeBuffs(A.ToxicBladeDebuff.ID, true) or (PoisonedBleeds() > 5 and not A.ScentofBlood:GetAzeriteRank() > 0)))
            
            -- variable,name=skip_rupture,value=debuff.vendetta.up&(debuff.toxic_blade.up|master_assassin_remains>0)&dot.rupture.remains>2
            VarSkipRupture = num(Unit(unit):HasDeBuffs(A.VendettaDebuff.ID, true) and (Unit(unit):HasDeBuffs(A.ToxicBladeDebuff.ID, true) or MasterAssassinRemains > 0) and Unit(unit):HasDeBuffs(A.RuptureDebuff.ID, true) > 2)
            
            -- garrote,if=talent.exsanguinate.enabled&!exsanguinated.garrote&dot.garrote.pmultiplier<=1&cooldown.exsanguinate.remains<2&spell_targets.fan_of_knives=1&raid_event.adds.in>6&dot.garrote.remains*0.5<target.time_to_die
            if A.Garrote:IsReady(unit) and (A.Exsanguinate:IsSpellLearned() and not A.Exsanguinated(Unit(unit), "Garrote") and A.PMultiplier(unit, A.GarroteDebuff.ID) <= 1 and A.Exsanguinate:GetCooldown() < 2 and MultiUnits:GetByRangeInCombat(10, 5, 10) == 1 and IncomingAddsIn > 6 and Unit(unit):HasDeBuffs(A.GarroteDebuff.ID, true) * 0.5 < Unit(unit):TimeToDie()) then
                return A.Garrote:Show(icon)
            end
            
            -- rupture,if=talent.exsanguinate.enabled&!dot.garrote.refreshable&(combo_points>=cp_max_spend&cooldown.exsanguinate.remains<1&dot.rupture.remains*0.5<target.time_to_die)
            if A.Rupture:IsReady(unit) and (A.Exsanguinate:IsSpellLearned() and not Unit(unit):HasDeBuffsRefreshable(A.GarroteDebuff.ID, true) and (Player:ComboPoints() >= CPMaxSpend() and A.Exsanguinate:GetCooldown() < 1 and Unit(unit):HasDeBuffs(A.RuptureDebuff.ID, true) * 0.5 < Unit(unit):TimeToDie())) then
                return A.Rupture:Show(icon)
            end
            
            -- pool_resource,for_next=1
            -- garrote,if=refreshable&combo_points.deficit>=1+3*(azerite.shrouded_suffocation.enabled&cooldown.vanish.up)&(pmultiplier<=1|remains<=tick_time&spell_targets.fan_of_knives>=3+azerite.shrouded_suffocation.enabled)&(!exsanguinated|remains<=tick_time*2&spell_targets.fan_of_knives>=3+azerite.shrouded_suffocation.enabled)&!ss_buffed&(target.time_to_die-remains)>4&(master_assassin_remains=0|!ticking&azerite.shrouded_suffocation.enabled)
            if A.Garrote:IsReady(unit) and (Unit(unit):HasDeBuffsRefreshable(A.GarroteDebuff.ID, true) and Player:ComboPointsDeficit() >= 1 + 3 * num((A.ShroudedSuffocation:GetAzeriteRank() > 0 and A.Vanish:GetCooldown() == 0)) and (A.PMultiplier(unit, A.GarroteDebuff.ID) <= 1 or Unit(unit):HasDeBuffs(A.GarroteDebuff.ID, true) <= A.GarroteDebuff.ID, true:TickTime() and MultiUnits:GetByRangeInCombat(10, 5, 10) >= 3 + A.ShroudedSuffocation:GetAzeriteRank() > 0) and (not A.Exsanguinated(Unit(unit), "Garrote") or Unit(unit):HasDeBuffs(A.GarroteDebuff.ID, true) <= A.GarroteDebuff.ID, true:TickTime() * 2 and MultiUnits:GetByRangeInCombat(10, 5, 10) >= 3 + A.ShroudedSuffocation:GetAzeriteRank() > 0) and not ss_buffed and (Unit(unit):TimeToDie() - Unit(unit):HasDeBuffs(A.GarroteDebuff.ID, true)) > 4 and (MasterAssassinRemains == 0 or not Unit(unit):HasDeBuffs(A.GarroteDebuff.ID, true) and A.ShroudedSuffocation:GetAzeriteRank() > 0)) then
                if A.Garrote:IsUsablePPool() then
                    return A.Garrote:Show(icon)
                else
                    return A.PoolResource:Show(icon)
                end
            end
            
            -- pool_resource,for_next=1
            -- garrote,cycle_targets=1,if=!variable.skip_cycle_garrote&target!=self.target&refreshable&combo_points.deficit>=1+3*(azerite.shrouded_suffocation.enabled&cooldown.vanish.up)&(pmultiplier<=1|remains<=tick_time&spell_targets.fan_of_knives>=3+azerite.shrouded_suffocation.enabled)&(!exsanguinated|remains<=tick_time*2&spell_targets.fan_of_knives>=3+azerite.shrouded_suffocation.enabled)&!ss_buffed&(target.time_to_die-remains)>12&(master_assassin_remains=0|!ticking&azerite.shrouded_suffocation.enabled)
            if A.Garrote:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.Garrote, 40, "min", EvaluateCycleGarrote448) then
                    return A.Garrote:Show(icon) 
                end
            end
            -- crimson_tempest,target_if=min:remains,if=spell_targets>3&remains<2+(spell_targets>=5)&combo_points>=4
            if A.CrimsonTempest:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.CrimsonTempest, 40, "min", EvaluateTargetIfFilterCrimsonTempest514, EvaluateTargetIfCrimsonTempest551) then 
                    return A.CrimsonTempest:Show(icon) 
                end
            end
            -- rupture,if=!variable.skip_rupture&(combo_points>=4&refreshable|!ticking&(time>10|combo_points>=2))&(pmultiplier<=1|remains<=tick_time&spell_targets.fan_of_knives>=3+azerite.shrouded_suffocation.enabled)&(!exsanguinated|remains<=tick_time*2&spell_targets.fan_of_knives>=3+azerite.shrouded_suffocation.enabled)&target.time_to_die-remains>4
            if A.Rupture:IsReady(unit) and (not VarSkipRupture and (Player:ComboPoints() >= 4 and Unit(unit):HasDeBuffsRefreshable(A.RuptureDebuff.ID, true) or not Unit(unit):HasDeBuffs(A.RuptureDebuff.ID, true) and (Unit("player"):CombatTime() > 10 or Player:ComboPoints() >= 2)) and (A.PMultiplier(unit, A.RuptureDebuff.ID) <= 1 or Unit(unit):HasDeBuffs(A.RuptureDebuff.ID, true) <= A.RuptureDebuff.ID, true:TickTime() and MultiUnits:GetByRangeInCombat(10, 5, 10) >= 3 + A.ShroudedSuffocation:GetAzeriteRank() > 0) and (not A.Exsanguinated(Unit(unit), "Rupture") or Unit(unit):HasDeBuffs(A.RuptureDebuff.ID, true) <= A.RuptureDebuff.ID, true:TickTime() * 2 and MultiUnits:GetByRangeInCombat(10, 5, 10) >= 3 + A.ShroudedSuffocation:GetAzeriteRank() > 0) and Unit(unit):TimeToDie() - Unit(unit):HasDeBuffs(A.RuptureDebuff.ID, true) > 4) then
                return A.Rupture:Show(icon)
            end
            
            -- rupture,cycle_targets=1,if=!variable.skip_cycle_rupture&!variable.skip_rupture&target!=self.target&combo_points>=4&refreshable&(pmultiplier<=1|remains<=tick_time&spell_targets.fan_of_knives>=3+azerite.shrouded_suffocation.enabled)&(!exsanguinated|remains<=tick_time*2&spell_targets.fan_of_knives>=3+azerite.shrouded_suffocation.enabled)&target.time_to_die-remains>4+(poisoned_bleeds>2)*6
            if A.Rupture:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.Rupture, 5, "min", EvaluateCycleRupture614) then
                    return A.Rupture:Show(icon) 
                end
            end
            -- crimson_tempest,target_if=min:remains,if=spell_targets>1&spell_targets<4&remains<2&combo_points>=4
            if A.CrimsonTempest:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.CrimsonTempest, 40, "min", EvaluateTargetIfFilterCrimsonTempest670, EvaluateTargetIfCrimsonTempest707) then 
                    return A.CrimsonTempest:Show(icon) 
                end
            end
            -- crimson_tempest,if=spell_targets=1&combo_points>=(cp_max_spend-1)&refreshable&!exsanguinated&!debuff.toxic_blade.up&master_assassin_remains=0&!azerite.twist_the_knife.enabled&target.time_to_die-remains>4
            if A.CrimsonTempest:IsReady(unit) and (MultiUnits:GetByRangeInCombat(40, 5, 10) == 1 and Player:ComboPoints() >= (CPMaxSpend() - 1) and Unit("player"):HasBuffsRefreshable(A.CrimsonTempestBuff.ID, true) and not A.Exsanguinated(Unit(unit), "CrimsonTempest") and not Unit(unit):HasDeBuffs(A.ToxicBladeDebuff.ID, true) and MasterAssassinRemains == 0 and not A.TwisttheKnife:GetAzeriteRank() > 0 and Unit(unit):TimeToDie() - Unit("player"):HasBuffs(A.CrimsonTempestBuff.ID, true) > 4) then
                return A.CrimsonTempest:Show(icon)
            end
            
            -- crimson_tempest,if=spell_targets>(7-buff.envenom.up)&combo_points>=4+talent.deeper_stratagem.enabled&!debuff.vendetta.up&!debuff.toxic_blade.up&!azerite.twist_the_knife.enabled&energy.deficit<=25+variable.energy_regen_combined
            if A.CrimsonTempest:IsReady(unit) and (MultiUnits:GetByRangeInCombat(40, 5, 10) > (7 - num(Unit("player"):HasBuffs(A.EnvenomBuff.ID, true))) and Player:ComboPoints() >= 4 + num(A.DeeperStratagem:IsSpellLearned()) and not Unit(unit):HasDeBuffs(A.VendettaDebuff.ID, true) and not Unit(unit):HasDeBuffs(A.ToxicBladeDebuff.ID, true) and not A.TwisttheKnife:GetAzeriteRank() > 0 and Player:EnergyDeficitPredicted() <= 25 + VarEnergyRegenCombined) then
                return A.CrimsonTempest:Show(icon)
            end
            
        end
        
        --Essences
        local function Essences(unit)
        
            -- concentrated_flame,if=energy.time_to_max>1&!debuff.vendetta.up&(!dot.concentrated_flame_burn.ticking&!action.concentrated_flame.in_flight|full_recharge_time<gcd.max)
            if A.ConcentratedFlame:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and (Player:EnergyTimeToMaxPredicted() > 1 and not Unit(unit):HasDeBuffs(A.VendettaDebuff.ID, true) and (not Unit(unit):HasDeBuffs(A.ConcentratedFlameBurnDebuff.ID, true) and not A.ConcentratedFlame:IsSpellInFlight() or A.ConcentratedFlame:GetSpellChargesFullRechargeTime() < GetGCD())) then
                return A.ConcentratedFlame:Show(icon)
            end
            
            -- blood_of_the_enemy,if=debuff.vendetta.up&(exsanguinated.garrote|debuff.toxic_blade.up&combo_points.deficit<=1|debuff.vendetta.remains<=10)|fight_remains<=10
            if A.BloodoftheEnemy:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and (Unit(unit):HasDeBuffs(A.VendettaDebuff.ID, true) and (A.Exsanguinated(Unit(unit), "BloodoftheEnemy") or Unit(unit):HasDeBuffs(A.ToxicBladeDebuff.ID, true) and Player:ComboPointsDeficit() <= 1 or Unit(unit):HasDeBuffs(A.VendettaDebuff.ID, true) <= 10) or fight_remains <= 10) then
                return A.BloodoftheEnemy:Show(icon)
            end
            
            -- guardian_of_azeroth,if=cooldown.vendetta.remains<3|debuff.vendetta.up|fight_remains<30
            if A.GuardianofAzeroth:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and (A.Vendetta:GetCooldown() < 3 or Unit(unit):HasDeBuffs(A.VendettaDebuff.ID, true) or fight_remains < 30) then
                return A.GuardianofAzeroth:Show(icon)
            end
            
            -- guardian_of_azeroth,if=floor((fight_remains-30)%cooldown)>floor((fight_remains-30-cooldown.vendetta.remains)%cooldown)
            if A.GuardianofAzeroth:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and (math.floor ((fight_remains - 30) / cooldown) > math.floor ((fight_remains - 30 - A.Vendetta:GetCooldown()) / cooldown)) then
                return A.GuardianofAzeroth:Show(icon)
            end
            
            -- focused_azerite_beam,if=spell_targets.fan_of_knives>=2|raid_event.adds.in>60&energy<70|fight_remains<10
            if A.FocusedAzeriteBeam:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and (MultiUnits:GetByRangeInCombat(10, 5, 10) >= 2 or IncomingAddsIn > 60 and Player:EnergyPredicted() < 70 or fight_remains < 10) then
                return A.FocusedAzeriteBeam:Show(icon)
            end
            
            -- purifying_blast,if=spell_targets.fan_of_knives>=2|raid_event.adds.in>60|fight_remains<10
            if A.PurifyingBlast:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and (MultiUnits:GetByRangeInCombat(10, 5, 10) >= 2 or IncomingAddsIn > 60 or fight_remains < 10) then
                return A.PurifyingBlast:Show(icon)
            end
            
            -- the_unbound_force,if=buff.reckless_force.up|buff.reckless_force_counter.stack<10
            if A.TheUnboundForce:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and (Unit("player"):HasBuffs(A.RecklessForceBuff.ID, true) or Unit("player"):HasBuffsStacks(A.RecklessForceCounterBuff.ID, true) < 10) then
                return A.TheUnboundForce:Show(icon)
            end
            
            -- ripple_in_space
            if A.RippleInSpace:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth then
                return A.RippleInSpace:Show(icon)
            end
            
            -- worldvein_resonance
            if A.WorldveinResonance:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth then
                return A.WorldveinResonance:Show(icon)
            end
            
            -- memory_of_lucid_dreams,if=energy<50&!cooldown.vendetta.up
            if A.MemoryofLucidDreams:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and (Player:EnergyPredicted() < 50 and not A.Vendetta:GetCooldown() == 0) then
                return A.MemoryofLucidDreams:Show(icon)
            end
            
            -- variable,name=reaping_delay,value=target.time_to_die
            VarReapingDelay = Unit(unit):TimeToDie()
            
            -- cycling_variable,name=reaping_delay,op=min,if=essence.breath_of_the_dying.major,value=target.time_to_die
            if A.CyclingVariable:IsReady(unit) and (Azerite:EssenceHasMajor(A.BreathoftheDying.ID)) then
                return A.CyclingVariable:Show(icon) = math.min(return A.CyclingVariable:Show(icon), Unit(unit):TimeToDie())
            end
            
            -- reaping_flames,target_if=target.time_to_die<1.5|((target.health.pct>80|target.health.pct<=20)&(active_enemies=1|variable.reaping_delay>29))|(target.time_to_pct_20>30&(active_enemies=1|variable.reaping_delay>44))
            if A.ReapingFlames:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.ReapingFlames, 40, "min", EvaluateCycleReapingFlames826) then
                    return A.ReapingFlames:Show(icon) 
                end
            end
        end
        
        --Stealthed
        local function Stealthed(unit)
        
            -- rupture,if=talent.nightstalker.enabled&combo_points>=4&target.time_to_die-remains>6
            if A.Rupture:IsReady(unit) and (A.Nightstalker:IsSpellLearned() and Player:ComboPoints() >= 4 and Unit(unit):TimeToDie() - Unit(unit):HasDeBuffs(A.RuptureDebuff.ID, true) > 6) then
                return A.Rupture:Show(icon)
            end
            
            -- pool_resource,for_next=1
            -- garrote,if=azerite.shrouded_suffocation.enabled&buff.subterfuge.up&buff.subterfuge.remains<1.3&!ss_buffed
            if A.Garrote:IsReady(unit) and (A.ShroudedSuffocation:GetAzeriteRank() > 0 and Unit("player"):HasBuffs(A.SubterfugeBuff.ID, true) and Unit("player"):HasBuffs(A.SubterfugeBuff.ID, true) < 1.3 and not ss_buffed) then
                if A.Garrote:IsUsablePPool() then
                    return A.Garrote:Show(icon)
                else
                    return A.PoolResource:Show(icon)
                end
            end
            
            -- pool_resource,for_next=1
            -- garrote,target_if=min:remains,if=talent.subterfuge.enabled&(remains<12|pmultiplier<=1)&target.time_to_die-remains>2
            if A.Garrote:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.Garrote, 40, "min", EvaluateTargetIfFilterGarrote870, EvaluateTargetIfGarrote905) then 
                    return A.Garrote:Show(icon) 
                end
            end
            -- rupture,if=talent.subterfuge.enabled&azerite.shrouded_suffocation.enabled&!dot.rupture.ticking&variable.single_target
            if A.Rupture:IsReady(unit) and (A.Subterfuge:IsSpellLearned() and A.ShroudedSuffocation:GetAzeriteRank() > 0 and not Unit(unit):HasDeBuffs(A.RuptureDebuff.ID, true) and VarSingleUnit(unit)) then
                return A.Rupture:Show(icon)
            end
            
            -- pool_resource,for_next=1
            -- garrote,target_if=min:remains,if=talent.subterfuge.enabled&azerite.shrouded_suffocation.enabled&(active_enemies>1|!talent.exsanguinate.enabled)&target.time_to_die>remains&(remains<18|!ss_buffed)
            if A.Garrote:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.Garrote, 40, "min", EvaluateTargetIfFilterGarrote923, EvaluateTargetIfGarrote964) then 
                    return A.Garrote:Show(icon) 
                end
            end
            -- pool_resource,for_next=1
            -- garrote,if=talent.subterfuge.enabled&talent.exsanguinate.enabled&active_enemies=1&buff.subterfuge.remains<1.3
            if A.Garrote:IsReady(unit) and (A.Subterfuge:IsSpellLearned() and A.Exsanguinate:IsSpellLearned() and MultiUnits:GetByRangeInCombat(40, 5, 10) == 1 and Unit("player"):HasBuffs(A.SubterfugeBuff.ID, true) < 1.3) then
                if A.Garrote:IsUsablePPool() then
                    return A.Garrote:Show(icon)
                else
                    return A.PoolResource:Show(icon)
                end
            end
            
        end
        
        
        -- call precombat
        if Precombat(unit) and not inCombat and Unit(unit):IsExists() and unit ~= "mouseover" then 
            return true
        end

        -- In Combat
        if inCombat and Unit(unit):IsExists() then

                    -- stealth
            if A.Stealth:IsReady(unit) then
                return A.Stealth:Show(icon)
            end
            
            -- variable,name=energy_regen_combined,value=energy.regen+poisoned_bleeds*7%(2*spell_haste)
            VarEnergyRegenCombined = Player:EnergyRegen() + PoisonedBleeds() * 7 / (2 * Player:SpellHaste())
            
            -- variable,name=single_target,value=spell_targets.fan_of_knives<2
            VarSingleUnit(unit) = num(MultiUnits:GetByRangeInCombat(10, 5, 10) < 2)
            
            -- call_action_list,name=stealthed,if=stealthed.rogue
            if (Unit("player"):IsStealthed(true, false)) then
                if Stealthed(unit) then
                    return true
                end
            end
            
            -- call_action_list,name=cds,if=(!talent.master_assassin.enabled|dot.garrote.ticking)
            if ((not A.MasterAssassin:IsSpellLearned() or Unit(unit):HasDeBuffs(A.GarroteDebuff.ID, true))) then
                if Cds(unit) then
                    return true
                end
            end
            
            -- call_action_list,name=dot
            if Dot(unit) then
                return true
            end
            
            -- call_action_list,name=direct
            if Direct(unit) then
                return true
            end
            
            -- arcane_torrent,if=energy.deficit>=15+variable.energy_regen_combined
            if A.ArcaneTorrent:AutoRacial(unit) and Racial and A.BurstIsON(unit) and (Player:EnergyDeficitPredicted() >= 15 + VarEnergyRegenCombined) then
                return A.ArcaneTorrent:Show(icon)
            end
            
            -- arcane_pulse
            if A.ArcanePulse:AutoRacial(unit) and Racial then
                return A.ArcanePulse:Show(icon)
            end
            
            -- lights_judgment
            if A.LightsJudgment:IsReady(unit) and A.BurstIsON(unit) then
                return A.LightsJudgment:Show(icon)
            end
            
            -- bag_of_tricks
            if A.BagofTricks:IsReady(unit) then
                return A.BagofTricks:Show(icon)
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

