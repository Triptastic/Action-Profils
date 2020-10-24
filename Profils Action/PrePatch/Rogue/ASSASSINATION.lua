-------------------------------
-- Taste TMW Action Rotation --
-------------------------------
local _G, setmetatable							= _G, setmetatable
local TMW                                       = TMW
local CNDT                                      = TMW.CNDT
local Env                                       = CNDT.Env
local A                         			    = _G.Action
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
local select, math                              = select, math
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
    ArcaneTorrent                        = Action.Create({ Type = "Spell", ID = 50613     }),
    BloodFury                            = Action.Create({ Type = "Spell", ID = 20572      }),
    Fireblood                            = Action.Create({ Type = "Spell", ID = 265221     }),
    AncestralCall                        = Action.Create({ Type = "Spell", ID = 274738     }),
    Berserking                           = Action.Create({ Type = "Spell", ID = 26297    }),
    ArcanePulse                          = Action.Create({ Type = "Spell", ID = 260364    }),
    QuakingPalm                          = Action.Create({ Type = "Spell", ID = 107079     }),
    Haymaker                             = Action.Create({ Type = "Spell", ID = 287712     }), 
    BullRush                             = Action.Create({ Type = "Spell", ID = 255654     }),    
    WarStomp                             = Action.Create({ Type = "Spell", ID = 20549     }),
    GiftofNaaru                          = Action.Create({ Type = "Spell", ID = 59544    }),
    Shadowmeld                           = Action.Create({ Type = "Spell", ID = 58984    }), -- usable in Action Core 
    Stoneform                            = Action.Create({ Type = "Spell", ID = 20594    }), 
    BagofTricks                            = Action.Create({ Type = "Spell", ID = 312411    }),
    WilloftheForsaken                    = Action.Create({ Type = "Spell", ID = 7744        }), -- not usable in APL but user can Queue it    
    EscapeArtist                         = Action.Create({ Type = "Spell", ID = 20589    }), -- not usable in APL but user can Queue it
    EveryManforHimself                   = Action.Create({ Type = "Spell", ID = 59752    }), -- not usable in APL but user can Queue it
    PetKick                              = Action.Create({ Type = "Spell", ID = 47482, Color = "RED", Desc = "RED" }),  
    LightsJudgment                        = Action.Create({ Type = "Spell", ID = 255647     }),
    -- Generics Spells
    Envenom                                = Action.Create({ Type = "Spell", ID = 32645     }),
    FanofKnives                            = Action.Create({ Type = "Spell", ID = 51723     }),
    Garrote                                = Action.Create({ Type = "Spell", ID = 703     }),
    KidneyShot                             = Action.Create({ Type = "Spell", ID = 408     }),
    Mutilate                               = Action.Create({ Type = "Spell", ID = 1329     }),
    PoisonedKnife                          = Action.Create({ Type = "Spell", ID = 185565     }),
    Rupture                                = Action.Create({ Type = "Spell", ID = 1943     }),
    Stealth                                = Action.Create({ Type = "Spell", ID = 1784     }),
    Stealth2                               = Action.Create({ Type = "Spell", ID = 115191     }), -- w/ Subterfuge Talent
    Vanish                                 = Action.Create({ Type = "Spell", ID = 1856     }),
    Vendetta                               = Action.Create({ Type = "Spell", ID = 79140     }),
    -- Talents
    Blindside                              = Action.Create({ Type = "Spell", ID = 111240     }),
    CrimsonTempest                         = Action.Create({ Type = "Spell", ID = 121411     }),
    DeeperStratagem                        = Action.Create({ Type = "Spell", ID = 193531     }),
    Exsanguinate                           = Action.Create({ Type = "Spell", ID = 200806     }),
    InternalBleeding                       = Action.Create({ Type = "Spell", ID = 154953     }),
    MarkedForDeath                         = Action.Create({ Type = "Spell", ID = 137619     }),
    MasterAssassin                         = Action.Create({ Type = "Spell", ID = 255989     }),
    Nightstalker                           = Action.Create({ Type = "Spell", ID = 14062     }),
    Subterfuge                             = Action.Create({ Type = "Spell", ID = 108208     }),
    ToxicBlade                             = Action.Create({ Type = "Spell", ID = 245388     }),
    VenomRush                              = Action.Create({ Type = "Spell", ID = 152152     }),
    Dismantle                              = Action.Create({ Type = "Spell", ID = 207777     }), -- PvP Talent
    -- Azerite Traits
    DoubleDose                             = Action.Create({ Type = "Spell", ID = 273007     }),
    EchoingBlades                          = Action.Create({ Type = "Spell", ID = 287649     }),
    ShroudedSuffocation                    = Action.Create({ Type = "Spell", ID = 278666     }),
    ScentOfBlood                           = Action.Create({ Type = "Spell", ID = 277679     }),
    RecklessForceCounter                   = Action.Create({ Type = "Spell", ID = 302917     }),
    ConcentratedFlameBurn                  = Action.Create({ Type = "Spell", ID = 295368     }),
    -- Defensive
    CrimsonVial                            = Action.Create({ Type = "Spell", ID = 185311     }),
    Feint                                  = Action.Create({ Type = "Spell", ID = 1966     }),
    CloakofShadow                          = Action.Create({ Type = "Spell", ID = 31224     }),
    Evade                                  = Action.Create({ Type = "Spell", ID = 5277     }),
    -- Utilities
    KidneyShot                             = Action.Create({ Type = "Spell", ID = 408       }),
    Gouge                                  = Action.Create({ Type = "Spell", ID = 1776       }),
    Blind                                  = Action.Create({ Type = "Spell", ID = 2094     }),
    Kick                                   = Action.Create({ Type = "Spell", ID = 1766     }),
    Sprint                                 = Action.Create({ Type = "Spell", ID = 2983       }),
    CheapShot                              = Action.Create({ Type = "Spell", ID = 1833       }),
    ShadowStep                             = Action.Create({ Type = "Spell", ID = 36554       }),
    TricksoftheTrade                       = Action.Create({ Type = "Spell", ID = 57934       }),
    -- PvP
    Sap                                    = Action.Create({ Type = "Spell", ID = 6770       }),
    Shiv                                   = Action.Create({ Type = "Spell", ID = 248744       }),
    SmokeBomb                              = Action.Create({ Type = "Spell", ID = 212182       }),
    DFA                                    = Action.Create({ Type = "Spell", ID = 269513       }),
    Neuro                                  = Action.Create({ Type = "Spell", ID = 206328       }),    
    -- Poisons
    CripplingPoison                        = Action.Create({ Type = "Spell", ID = 3408     }),
    DeadlyPoison                           = Action.Create({ Type = "Spell", ID = 2823     }),
    WoundPoison                            = Action.Create({ Type = "Spell", ID = 8679     }),
    -- Misc
    TheDreadlordsDeceit                    = Action.Create({ Type = "Spell", ID = 208693     }),
    IronWire                               = Action.Create({ Type = "Spell", ID = 196861, Hidden = true     }),    
    --PoolEnergy                             = Action.Create({ Type = "Spell", ID = 9999000010   }),
    PoolResource                             = Action.Create({ Type = "Spell", ID = 209274, Hidden = true     }),    
    -- Buffs
    VigorTrinketBuff                       = Action.Create({ Type = "Spell", ID = 287916, Hidden = true     }),
    LifebloodBuff                          = Action.Create({ Type = "Spell", ID = 295137, Hidden = true     }),
    HiddenBladesBuff                       = Action.Create({ Type = "Spell", ID = 270070, Hidden = true     }),
    BlindsideBuff                          = Action.Create({ Type = "Spell", ID = 121153 , Hidden = true     }),
    VanishBuff                             = Action.Create({ Type = "Spell", ID = 11327 , Hidden = true     }),
    RecklessForceBuff                      = Action.Create({ Type = "Spell", ID = 302932 , Hidden = true     }),
    SubterfugeBuff                         = Action.Create({ Type = "Spell", ID = 115192 , Hidden = true     }),
    -- Debuffs 
    GarroteDebuff                          = Action.Create({ Type = "Spell", ID = 703, Hidden = true     }),
    RuptureDebuff                          = Action.Create({ Type = "Spell", ID = 1943, Hidden = true     }),
    RazorCoralDebuff                       = Action.Create({ Type = "Spell", ID = 303568, Hidden = true     }),
    WoundPoisonDebuff                      = Action.Create({ Type = "Spell", ID = 8680, Hidden = true     }),
    DeadlyPoisonDebuff                     = Action.Create({ Type = "Spell", ID = 2818 , Hidden = true     }),
    BloodoftheEnemyDebuff                  = Action.Create({ Type = "Spell", ID = 297108 , Hidden = true     }),
    ToxicBladeDebuff                       = Action.Create({ Type = "Spell", ID = 245389, Hidden = true     }),
    -- Potions
    PotionofUnbridledFury                  = Action.Create({ Type = "Potion", ID = 169299, QueueForbidden = true }), 
    BattlePotionOfAgility                  = Action.Create({ Type = "Potion", ID = 163223, QueueForbidden = true }),  
    SuperiorPotionofUnbridledFury          = Action.Create({ Type = "Potion", ID = 168489, QueueForbidden = true }), 
	SuperiorSteelskinPotion                = Action.Create({ Type = "Potion", ID = 168501, QueueForbidden = true }), 
	AbyssalHealingPotion                   = Action.Create({ Type = "Potion", ID = 169451, QueueForbidden = true }),     
	PotionofFocusedResolve                 = Action.Create({ Type = "Potion", ID = 168506 }),
	SuperiorBattlePotionofStrength         = Action.Create({ Type = "Potion", ID = 168500 }),
	PotionofEmpoweredProximity             = Action.Create({ Type = "Potion", ID = 168529 }),
    -- Trinkets
    AzsharasFontofPower                    = Action.Create({ Type = "Trinket", ID = 169314 }),
    PocketsizedComputationDevice           = Action.Create({ Type = "Trinket", ID = 167555 }),
    RotcrustedVoodooDoll                   = Action.Create({ Type = "Trinket", ID = 159624 }),
    ShiverVenomRelic                       = Action.Create({ Type = "Trinket", ID = 168905 }),
    AquipotentNautilus                     = Action.Create({ Type = "Trinket", ID = 169305 }),
    TidestormCodex                         = Action.Create({ Type = "Trinket", ID = 165576 }),
    VialofStorms                           = Action.Create({ Type = "Trinket", ID = 158224 }),
    GalecallersBoon                        = Action.Create({ Type = "Trinket", ID = 159614 }),
    InvocationOfYulon                      = Action.Create({ Type = "Trinket", ID = 165568 }),
    LustrousGoldenPlumage                  = Action.Create({ Type = "Trinket", ID = 159617 }),
    LurkersInsidiousGift                   = Action.Create({ Type = "Trinket", ID = 167866 }),
    VigorTrinket                           = Action.Create({ Type = "Trinket", ID = 165572 }),
    AshvanesRazorCoral                     = Action.Create({ Type = "Trinket", ID = 169311 }),
    MalformedHeraldsLegwraps               = Action.Create({ Type = "Trinket", ID = 167835 }),
    HyperthreadWristwraps                  = Action.Create({ Type = "Trinket", ID = 168989 }),
    NotoriousAspirantsBadge                = Action.Create({ Type = "Trinket", ID = 167528 }),
    NotoriousGladiatorsBadge               = Action.Create({ Type = "Trinket", ID = 167380 }),
    SinisterGladiatorsBadge                = Action.Create({ Type = "Trinket", ID = 165058 }),
    SinisterAspirantsBadge                 = Action.Create({ Type = "Trinket", ID = 165223 }),
    DreadGladiatorsBadge                   = Action.Create({ Type = "Trinket", ID = 161902 }),
    DreadAspirantsBadge                    = Action.Create({ Type = "Trinket", ID = 162966 }),
    DreadCombatantsInsignia                = Action.Create({ Type = "Trinket", ID = 161676 }),
    NotoriousAspirantsMedallion            = Action.Create({ Type = "Trinket", ID = 167525 }),
    NotoriousGladiatorsMedallion           = Action.Create({ Type = "Trinket", ID = 167377 }),
    SinisterGladiatorsMedallion            = Action.Create({ Type = "Trinket", ID = 165055 }),
    SinisterAspirantsMedallion             = Action.Create({ Type = "Trinket", ID = 165220 }),
    DreadGladiatorsMedallion               = Action.Create({ Type = "Trinket", ID = 161674 }),
    DreadAspirantsMedallion                = Action.Create({ Type = "Trinket", ID = 162897 }),
    DreadCombatantsMedallion               = Action.Create({ Type = "Trinket", ID = 161811 }),
    IgnitionMagesFuse                      = Action.Create({ Type = "Trinket", ID = 159615 }),
    TzanesBarkspines                       = Action.Create({ Type = "Trinket", ID = 161411 }),
    AzurethosSingedPlumage                = Action.Create({ Type = "Trinket", ID = 161377 }),
    AncientKnotofWisdomAlliance            = Action.Create({ Type = "Trinket", ID = 161417 }),
    AncientKnotofWisdomHorde               = Action.Create({ Type = "Trinket", ID = 166793 }),
    ShockbitersFang                        = Action.Create({ Type = "Trinket", ID = 169318 }),
    NeuralSynapseEnhancer                  = Action.Create({ Type = "Trinket", ID = 168973 }),
    BalefireBranch                         = Action.Create({ Type = "Trinket", ID = 159630 }),
	GrongsPrimalRage                       = Action.Create({ Type = "Trinket", ID = 165574 }),
	BygoneBeeAlmanac                       = Action.Create({ Type = "Trinket", ID = 163936 }),
	RampingAmplitudeGigavoltEngine         = Action.Create({ Type = "Trinket", ID = 165580 }),
	VisionofDemise                         = Action.Create({ Type = "Trinket", ID = 169307 }),
	JesHowler                              = Action.Create({ Type = "Trinket", ID = 159627 }),
	GalecallersBeak                        = Action.Create({ Type = "Trinket", ID = 161379 }),
    DribblingInkpod                        = Action.Create({ Type = "Trinket", ID = 169319 }),
    RazdunksBigRedButton                   = Action.Create({ Type = "Trinket", ID = 159611 }),
    MerekthasFang                          = Action.Create({ Type = "Trinket", ID = 158367 }),
    CorruptedGladiatorsMedallion           = Action.Create({ Type = "Trinket", ID = 172666 }), -- PvP Trinket 8.3	
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
    RecklessForceBuff                      = Action.Create({ Type = "Spell", ID = 302932, Hidden = true     }), 
    TwisttheKnife                          = Action.Create({ Type = "Spell", ID = 273488, Hidden = true     }),  
};

-- To create essences use next code:
Action:CreateEssencesFor(ACTION_CONST_ROGUE_ASSASSINATION)  -- where PLAYERSPEC is Constance (example: ACTION_CONST_MONK_BM)
local A = setmetatable(Action[ACTION_CONST_ROGUE_ASSASSINATION], { __index = Action })


------------------------------------------
---------------- VARIABLES ---------------
------------------------------------------
local VarVendettaSubterfugeCondition = false;
local VarVendettaNightstalkerCondition = false;
local VarVendettaFontCondition = false;
local VarSsVanishCondition = false;
local VarEnergyRegenCombined = 0;
local VarSingleUnit = false;
local VarUseFiller = false;
local VarSkipCycleGarrote = false;
local VarSkipCycleRupture = false;
local VarSkipRupture = false;
local VarReapingDelay = 0;

A.Listener:Add("ROTATION_VARS", "PLAYER_REGEN_ENABLED", function()
  VarVendettaSubterfugeCondition = false
  VarVendettaNightstalkerCondition = false
  VarVendettaFontCondition = false
  VarSsVanishCondition = false
  VarEnergyRegenCombined = 0
  VarSingleUnit = false
  VarUseFiller = false
  VarSkipCycleGarrote = false
  VarSkipCycleRupture = false
  VarSkipRupture = false
  VarReapingDelay = 0
end)

local player = "player"

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

local IsIndoors, UnitIsUnit, UnitName = IsIndoors, UnitIsUnit, UnitName

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
                -- HP lose per sec >= 5
                Unit("player"):GetDMG() * 100 / Unit("player"):HealthMax() >= 5 or 
                Unit("player"):GetRealTimeDMG() >= Unit("player"):HealthMax() * 0.05 or 
                -- TTD 
                Unit("player"):TimeToDieX(25) < 5 or 
				Unit("player"):HealthPercent() < 70 and Unit("player"):IsFocused() or
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
        if useKick and A.Kick:IsReady(unit) and A.Kick:AbsentImun(unit, Temp.TotalAndPhysKick, true) then 
            -- Notification                    
            Action.SendNotification("Kick on : " .. UnitName(unit), A.Kick.ID)
            return A.Kick
        end 
    
        if useCC and A.Gouge:IsReady(unit) and A.Gouge:AbsentImun(unit, Temp.TotalAndCC, true) then 
            -- Notification                    
            Action.SendNotification("Gouge on : " .. UnitName(unit), A.Gouge.ID)
            return A.Gouge              
        end          
    
        if useCC and Player:IsStealthed() and A.CheapShot:IsReady(unit) and A.CheapShot:AbsentImun(unit, Temp.TotalAndCC, true) then 
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
    local Pull = A.BossMods:GetPullTimer()	
    local DBM = Action.GetToggle(1, "BossMods")
    local HeartOfAzeroth = Action.GetToggle(1, "HeartOfAzeroth")
    local Racial = Action.GetToggle(1, "Racial")
    local Potion = Action.GetToggle(1, "Potion")
	local priority_rotation = Action.GetToggle(2, "UsePriorityRotation") 
    local RuptureTickTime = RuptureTickTime()
    local GarroteTickTime = GarroteTickTime()
    local MasterAssassinRemains = MasterAssassinRemains()
    local ss_buffed_targets_above_pandemic = SSBuffedTargetsAbovePandemic()
    local non_ss_buffed_targets = NonSSBuffedTargets()
    local ss_buffed = SSBuffed()
	local fight_remains = ExpectedCombatLength()
	local IncomingAddsIn = 9999
    -- Spell ID Changes check
    local Stealth = A.Subterfuge:IsSpellLearned() and A.Stealth2 or A.Stealth; -- w/ or w/o Subterfuge Talent
    local RuptureThreshold = (4 + Player:ComboPoints() * 4) * 0.3;
    --local RuptureDMGThreshold = A.Envenom:Damage() * Action.GetToggle(2, "EnvenomDMGOffset"); -- Used to check if Rupture is worth to be casted since it's a finisher.
    --local GarroteDMGThreshold = A.Mutilate:Damage() * Action.GetToggle(2, "MutilateDMGOffset"); -- Used as TTD Not Valid fallback since it's a generator.
    -- Multidots var
    local MultiDotDistance = A.GetToggle(2, "MultiDotDistance")
    local MissingRupture = MultiUnits:GetByRangeMissedDoTs(MultiDotDistance, 5, A.RuptureDebuff.ID) --MultiDots(40, A.FlameShockDebuff, 15, 4) --MultiUnits:GetByRangeMissedDoTs(40, 10, 188389)  MultiUnits:GetByRangeMissedDoTs(range, stop, dots, ttd)
    local MissingGarrote = MultiUnits:GetByRangeMissedDoTs(MultiDotDistance, 5, A.GarroteDebuff.ID) --MultiDots(40, A.FlameShockDebuff, 15, 4) --MultiUnits:GetByRangeMissedDoTs(40, 10, 188389)  MultiUnits:GetByRangeMissedDoTs(range, stop, dots, ttd)
    local MissingCrimsonTempest = MultiUnits:GetByRangeMissedDoTs(MultiDotDistance, 5, A.CrimsonTempest.ID)
    local ActivesRupture = MultiUnits:GetByRangeAppliedDoTs(MultiDotDistance, 5, A.RuptureDebuff.ID) --MultiDots(40, A.FlameShockDebuff, 15, 4) --MultiUnits:GetByRangeMissedDoTs(40, 10, 188389)  MultiUnits:GetByRangeMissedDoTs(range, stop, dots, ttd)
    local ActivesGarrote = MultiUnits:GetByRangeAppliedDoTs(MultiDotDistance, 5, A.GarroteDebuff.ID) 
    local CanMultidot = HandleMultidots()    
    -- Trinkets vars
    local Trinket1IsAllowed, Trinket2IsAllowed = TR:TrinketIsAllowed()
    
    -- FocusedAzeriteBeam protection channel
    local secondsLeft, percentLeft, spellID, spellName, notInterruptable, isChannel = Unit("player"):IsCastingRemains()
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
	
    ------------------------------------------------------
    ---------------- ENEMY UNIT ROTATION -----------------
    ------------------------------------------------------
    local function EnemyRotation(unit)

        --Precombat
        if not inCombat and Unit(unit):IsExists() and unit ~= "mouseover" then
        
            -- Sap out of combat
            if A.Sap:IsReady(unit) and Player:IsStealthed() and Unit(unit):CombatTime() == 0 then
                if Unit(unit):HasDeBuffs(A.Sap.ID, true) == 0 and Unit(unit):IsControlAble("incapacitate", 75) then 
                    -- Notification                    
                    Action.SendNotification("Out of combat Sap on : " .. UnitName(unit), A.Sap.ID)
                    return A.Sap:Show(icon)
                else 
                    if Unit(unit):HasDeBuffs(A.Sap.ID, true) > 0 and Unit(unit):HasDeBuffs(A.Sap.ID, true) <= 1 and Unit(unit):IsControlAble("incapacitate", 25) then
                        -- Notification                    
                        Action.SendNotification("Refreshing Sap on : " .. UnitName(unit), A.Sap.ID)
                        return A.Sap:Show(icon)
                    end
                end
            end    
                
            -- use_item,name=azsharas_font_of_power
            if A.AzsharasFontofPower:IsReady("player") 
			and 
			(
			    Pull > 0 and Pull <= 7 
				or 
				not Action.GetToggle(1, "BossMods")
			) 
			then
                return A.AzsharasFontofPower:Show(icon)
            end
            
            -- marked_for_death,precombat_seconds=5,if=raid_event.adds.in>15
            if A.MarkedForDeath:IsReady(unit) and 
			(
			    Pull > 0 and Pull <= 5 
				or 
				not Action.GetToggle(1, "BossMods")
			) 
			then
                return A.MarkedForDeath:Show(icon)
            end
                        
            -- potion
            if A.PotionofUnbridledFury:IsReady(unit) and 
			(
			    Pull > 0 and Pull <= 2 
				or 
				not Action.GetToggle(1, "BossMods")
			) 
			then
                return A.PotionofUnbridledFury:Show(icon)
            end
			
            -- guardian_of_azeroth,if=talent.exsanguinate.enabled
            if A.GuardianofAzeroth:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and (A.Exsanguinate:IsSpellLearned()) and 
			(
			    Pull > 0 and Pull <= 1.8 
				or 
				not Action.GetToggle(1, "BossMods")
			) 
			then
                return A.GuardianofAzeroth:Show(icon)
            end
			
			-- Garrote opener
			if A.Garrote:IsReady(unit) and Unit("player"):HasDeBuffs(A.Garrote.ID, true) == 0 and 
			(Pull > 0 and Pull <= 5 or not A.GetToggle(1, "BossMods")) 
			and
			(
			    (Unit(unit):HasDeBuffs(A.Sap.ID, true) > 0 and Unit(unit):GetDR("incapacitate") < 50 ) 
			    or
			    Unit(unit):HasDeBuffs(A.Sap.ID, true) == 0
			)
			and
			(
			    Player:IsStealthed() 
			    or 
			    Unit("player"):HasBuffs(A.VanishBuff.ID, true) > 0 
			    or 
			    A.LastPlayerCastName == A.Vanish:Info()
			) 
			then            
			    return A.Garrote:Show(icon)            
			end  
			
        end

        -- variable,name=energy_regen_combined,value=energy.regen+poisoned_bleeds*7%(2*spell_haste)
        VarEnergyRegenCombined = Player:EnergyRegen() + PoisonedBleeds() * 7 / (2 * Player:SpellHaste())
            
        -- variable,name=single_target,value=spell_targets.fan_of_knives<2
        VarSingleUnit = GetByRange(2, 10, false, true)
            
        --Stealthed
        -- call_action_list,name=stealthed,if=stealthed.rogue
        if Player:IsStealthed() then
        
            -- rupture,if=talent.nightstalker.enabled&combo_points>=4&target.time_to_die-remains>6
            if A.Rupture:IsReady(unit) and (A.Nightstalker:IsSpellLearned() and Player:ComboPoints() >= 4 and Unit(unit):TimeToDie() - Unit(unit):HasDeBuffs(A.RuptureDebuff.ID, true) > 6) then
                return A.Rupture:Show(icon)
            end
            
            -- pool_resource,for_next=1
            -- garrote,if=azerite.shrouded_suffocation.enabled&buff.subterfuge.up&buff.subterfuge.remains<1.3&!ss_buffed
            if A.Garrote:IsReady(unit) and not A.LastPlayerCastName == A.Garrote:Info() and 
			(
			    A.ShroudedSuffocation:GetAzeriteRank() > 0 and 
				Unit("player"):HasBuffs(A.SubterfugeBuff.ID, true) > 0 and 
				Unit("player"):HasBuffs(A.SubterfugeBuff.ID, true) < 1.3 and 
				not ss_buffed
			)
			then
                if A.Garrote:IsUsablePPool() then
                    return A.Garrote:Show(icon)
                else
                    return A.PoolResource:Show(icon)
                end
            end
            
            -- pool_resource,for_next=1
            -- garrote,target_if=min:remains,if=talent.subterfuge.enabled&(remains<12|pmultiplier<=1)&target.time_to_die-remains>2
            if A.Garrote:IsReady(unit) and not A.LastPlayerCastName == A.Garrote:Info() and
                Unit(unit):HasDeBuffs(A.GarroteDebuff.ID, true) > 0 and  
				A.Subterfuge:IsSpellLearned() and 
				(
				    Unit(unit):HasDeBuffs(A.GarroteDebuff.ID, true) < 12 
					or
					A.PMultiplier(unit, A.GarroteDebuff.ID) <= 1
				)
				and 
				Unit(unit):TimeToDie() - Unit(unit):HasDeBuffs(A.GarroteDebuff.ID, true) > 2
			then 
                return A.Garrote:Show(icon)            
            end
			
            -- rupture,if=talent.subterfuge.enabled&azerite.shrouded_suffocation.enabled&!dot.rupture.ticking&variable.single_target
            if A.Rupture:IsReady(unit) and (A.Subterfuge:IsSpellLearned() and A.ShroudedSuffocation:GetAzeriteRank() > 0 and Unit(unit):HasDeBuffs(A.RuptureDebuff.ID, true) == 0 and VarSingleUnit) then
                return A.Rupture:Show(icon)
            end
            
            -- pool_resource,for_next=1
            -- garrote,target_if=min:remains,if=talent.subterfuge.enabled&azerite.shrouded_suffocation.enabled&(active_enemies>1|!talent.exsanguinate.enabled)&target.time_to_die>remains&(remains<18|!ss_buffed)
            if A.Garrote:IsReady(unit) and not A.LastPlayerCastName == A.Garrote:Info() and
                Unit(unit):HasDeBuffs(A.GarroteDebuff.ID, true) > 0 and 
				A.Subterfuge:IsSpellLearned() and 
				A.ShroudedSuffocation:GetAzeriteRank() > 0 and 
				(
				    GetByRange(1, 40, true) 
					or 
					not A.Exsanguinate:IsSpellLearned()
				)
				and 
				Unit(unit):TimeToDie() > Unit(unit):HasDeBuffs(A.GarroteDebuff.ID, true) and 
				(
				    Unit(unit):HasDeBuffs(A.GarroteDebuff.ID, true) < 18 
					or 
					not ss_buffed
				)
			then 
                return A.Garrote:Show(icon) 
            end
			
            -- pool_resource,for_next=1
            -- garrote,if=talent.subterfuge.enabled&talent.exsanguinate.enabled&active_enemies=1&buff.subterfuge.remains<1.3
            if A.Garrote:IsReady(unit) and not A.LastPlayerCastName == A.Garrote:Info() and 
			(
			    A.Subterfuge:IsSpellLearned() and 
				A.Exsanguinate:IsSpellLearned() and 
				MultiUnits:GetByRange(10) == 1 and 
				Unit("player"):HasBuffs(A.SubterfugeBuff.ID, true) < 1.3
			)
			then
                if A.Garrote:IsUsablePPool(45) then
                    return A.Garrote:Show(icon)
                else
                    return A.PoolResource:Show(icon)
                end
            end
            
        end
            
        -- BURST
        -- call_action_list,name=cds,if=(!talent.master_assassin.enabled|dot.garrote.ticking)
        if (not A.MasterAssassin:IsSpellLearned() or Unit(unit):HasDeBuffs(A.GarroteDebuff.ID, true) > 0) and inCombat then
        
            -- use_item,name=azsharas_font_of_power,if=!stealthed.all&master_assassin_remains=0&(cooldown.vendetta.remains<?(cooldown.toxic_blade.remains*equipped.ashvanes_razor_coral))<10+10*equipped.ashvanes_razor_coral&!debuff.vendetta.up&!debuff.toxic_blade.up
            if A.AzsharasFontofPower:IsReady("player") and 
			not Player:IsStealthed() and MasterAssassinRemains == 0 and 
			A.Vendetta:GetCooldown() < A.Vendetta:GetCooldown() < 10 and 
			Unit(unit):HasDeBuffs(A.Vendetta.ID, true) == 0 and 
			Unit(unit):HasDeBuffs(A.ToxicBladeDebuff.ID, true) == 0 
			then
                return A.AzsharasFontofPower:Show(icon)
            end
            
            -- call_action_list,name=essences,if=!stealthed.all&dot.rupture.ticking&master_assassin_remains=0
            if not Player:IsStealthed() and Unit(unit):HasDeBuffs(A.RuptureDebuff.ID, true) > 0 and MasterAssassinRemains == 0 then
			
                -- concentrated_flame,if=energy.time_to_max>1&!debuff.vendetta.up&(!dot.concentrated_flame_burn.ticking&!action.concentrated_flame.in_flight|full_recharge_time<gcd.max)
                if A.ConcentratedFlame:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and (Player:EnergyTimeToMaxPredicted() > 1 and Unit(unit):HasDeBuffs(A.Vendetta.ID, true) == 0 and (Unit(unit):HasDeBuffs(A.ConcentratedFlameBurn.ID, true) == 0 and not A.ConcentratedFlame:IsSpellInFlight() or A.ConcentratedFlame:GetSpellChargesFullRechargeTime() < GetGCD())) then
                    return A.ConcentratedFlame:Show(icon)
                end
            
                -- blood_of_the_enemy,if=debuff.vendetta.up&(exsanguinated.garrote|debuff.toxic_blade.up&combo_points.deficit<=1|debuff.vendetta.remains<=10)|IsInRaid() and fight_remains<=10
                if A.BloodoftheEnemy:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and 
				(
				    Unit(unit):HasDeBuffs(A.Vendetta.ID, true) > 0 and 
					(
					    Exsanguinated(unit, "Garrote") 
						or 
						Unit(unit):HasDeBuffs(A.ToxicBladeDebuff.ID, true) > 0 and Player:ComboPointsDeficit() <= 1 
						or
						Unit(unit):HasDeBuffs(A.Vendetta.ID, true) > 0
					)
					--or (IsInRaid() and fight_remains <= 10)
				)
				then
                    return A.BloodoftheEnemy:Show(icon)
                end
            
                -- guardian_of_azeroth,if=cooldown.vendetta.remains<3|debuff.vendetta.up|IsInRaid() and fight_remains<30
                if A.GuardianofAzeroth:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and 
				(
				    A.Vendetta:GetCooldown() < 3
					or 
					Unit(unit):HasDeBuffs(A.Vendetta.ID, true) > 0 
					or 
					IsInRaid() and fight_remains < 30
				)
				then
                    return A.GuardianofAzeroth:Show(icon)
                end
            
                -- guardian_of_azeroth,if=floor((IsInRaid() and fight_remains-30)%cooldown)>floor((IsInRaid() and fight_remains-30-cooldown.vendetta.remains)%cooldown)
                if A.GuardianofAzeroth:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and IsInRaid() and
				(
				    math.floor((IsInRaid() and fight_remains - 30) / A.GuardianofAzeroth:GetCooldown()) > math.floor ((IsInRaid() and fight_remains - 30 - A.Vendetta:GetCooldown()) / A.GuardianofAzeroth:GetCooldown())
				)
				then
                    return A.GuardianofAzeroth:Show(icon)
                end
            
                -- focused_azerite_beam,if=spell_targets.fan_of_knives>=2|raid_event.adds.in>60&energy<70|IsInRaid() and fight_remains<10
                if A.FocusedAzeriteBeam:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and (GetByRange(2, 10) or IsInRaid() and fight_remains < 10) then
                    return A.FocusedAzeriteBeam:Show(icon)
                end
            
                -- purifying_blast,if=spell_targets.fan_of_knives>=2|raid_event.adds.in>60|IsInRaid() and fight_remains<10
                if A.PurifyingBlast:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and (GetByRange(2, 10) or IsInRaid() and fight_remains < 10) then
                    return A.PurifyingBlast:Show(icon)
                end
            
                -- the_unbound_force,if=buff.reckless_force.up|buff.reckless_force_counter.stack<10
                if A.TheUnboundForce:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and (Unit("player"):HasBuffs(A.RecklessForceBuff.ID, true) > 0 or Unit("player"):HasBuffsStacks(A.RecklessForceCounter.ID, true) < 10) then
                    return A.TheUnboundForce:Show(icon)
                end
            
                -- ripple_in_space
                if A.RippleinSpace:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth then
                    return A.RippleinSpace:Show(icon)
                end
            
                -- worldvein_resonance
                if A.WorldveinResonance:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth then
                    return A.WorldveinResonance:Show(icon)
                end
            
                -- memory_of_lucid_dreams,if=energy<50&!cooldown.vendetta.up
                if A.MemoryofLucidDreams:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and (Player:EnergyPredicted() < 50 and not A.Vendetta:GetCooldown() == 0) then
                    return A.MemoryofLucidDreams:Show(icon)
                end
				
                -- cycling_variable,name=reaping_delay,op=min,if=essence.breath_of_the_dying.major,value=target.time_to_die
                VarReapingDelay = LowestTTD()
			
                -- reaping_flames,target_if=target.time_to_die<1.5|((target.health.pct>80|target.health.pct<=20)&(active_enemies=1|variable.reaping_delay>29))|(Unit(unit):TimeToDieX(20)>30&(active_enemies=1|variable.reaping_delay>44))
                if A.ReapingFlames:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and
				(
                    Unit(unit):TimeToDie() < 1.5 
				    or 
				    ((Unit(unit):HealthPercent() > 80 or Unit(unit):HealthPercent() <= 20) and (MultiUnits:GetByRange(10) == 1 or VarReapingDelay > 29)) 
				    or 
				    (Unit(unit):TimeToDieX(20) > 30 and (MultiUnits:GetByRange(10) == 1 or VarReapingDelay > 44))
				)
				then
                    return A.ReapingFlames:Show(icon) 
                end
				
            end
            
			
            -- Kidney Shot on enemies with burst damage buff or if our friend healer is cc
            if A.IsInPvP and A.KidneyShot:IsReady(unit) and CanCast and inMelee and Player:ComboPoints() >= 4 and Unit(unit):IsControlAble("stun", 25) and Unit(unit):HasBuffs("DamageBuffs") > 0 then
                -- Notification                    
                Action.SendNotification("Defensive Kidney Shot on : " .. UnitName(unit), A.KidneyShot.ID)
                return A.KidneyShot:Show(icon)
            end    
            
            -- 'Full' Kidney Shot
            if A.IsInPvP and A.KidneyShot:IsReady(unit) and CanCast and Unit(unit):HealthPercent() <= 70 and Player:ComboPoints() >= 4 and A.KidneyShot:AbsentImun(unit, {"TotalImun", "DamagePhysImun", "CCTotalImun"}, true) and Unit(unit):IsControlAble("stun", 0) then 
                -- Notification                    
                Action.SendNotification("Offensive Kidney Shot on : " .. UnitName(unit), A.KidneyShot.ID)
				return A.KidneyShot:Show(icon)              
            end
            
            -- Neuro
            if A.IsInPvP and A.Neuro:IsSpellLearned() and CanCast and A.Neuro:IsReady(unit) and inMelee and Unit(unit):HealthPercent() <= 75 and not Player:IsStealthed() then
                return A.Neuro:Show(icon)
            end
            
            -- Shiv
            if A.IsInPvP and A.Shiv:IsSpellLearned() and CanCast and A.Shiv:IsReady(unit) and inMelee and Unit(unit):HealthPercent() <= 50 and Action.AbsentImun(unit, "DamagePhysImun", true) and A.Shiv:IsReady(unit) and not Unit(unit):InCC()  then
                return A.Shiv:Show(icon)
            end
            
            -- Death From Above
            if A.IsInPvP and A.DFA:IsSpellLearned() and CanCast and A.DFA:IsReady(unit) and Unit(unit):HealthPercent() <= 70 and Player:ComboPoints() >= 5 and Unit(unit):GetRange() <= 15 and Action.AbsentImun(unit, "DamagePhysImun", true) then
                return A.DFA:Show(icon)
            end        
            
            -- Mouseover KidneyShot on enemy trying to leave with less than 30% HP
            if unit == "mouseover" and CanCast and Player:ComboPoints() >= 4 and Unit(unit):HealthPercent() <= 30 and (A.IsInPvP or (not Unit(unit):IsBoss() and Unit(unit):IsMovingOut())) and A.KidneyShot:IsReady(unit) and A.KidneyShot:AbsentImun(unit, {"TotalImun", "DamagePhysImun", "Freedom", "CCTotalImun"}, true) and Unit(unit):GetMaxSpeed() >= 100 and Unit(unit):HasDeBuffs("Slowed") == 0 and not Unit(unit):IsTotem() then 
                Action.SendNotification("Mouseover Kidney Shot on escaping unit", A.KidneyShot.ID)
				return A.KidneyShot:Show(icon)
            end 
			
			
            -- marked_for_death,target_if=min:target.time_to_die,if=raid_event.adds.up&(target.time_to_die<combo_points.deficit*1.5|combo_points.deficit>=cp_max_spend)
            if A.MarkedForDeath:IsReady(unit) then
                if Unit(unit):TimeToDie() > A.GetGCD() and (Unit(unit):TimeToDie() < Player:ComboPointsDeficit() * 1.5 or Player:ComboPointsDeficit() >= CPMaxSpend())
                then 
                    return A.MarkedForDeath:Show(icon) 
                end
            end
			
            -- marked_for_death,if=raid_event.adds.in>30-raid_event.adds.duration&combo_points.deficit>=cp_max_spend
         --   if A.MarkedForDeath:IsReady(unit) and (IncomingAddsIn > 30 - raid_event.adds.duration and Player:ComboPointsDeficit() >= CPMaxSpend()) then
         --       return A.MarkedForDeath:Show(icon)
         --   end
            
            -- variable,name=vendetta_subterfuge_condition,value=!talent.subterfuge.enabled|!azerite.shrouded_suffocation.enabled|dot.garrote.pmultiplier>1&(spell_targets.fan_of_knives<6|!cooldown.vanish.up)
            VarVendettaSubterfugeCondition = (
			                                    not A.Subterfuge:IsSpellLearned() 
			                                    or A.ShroudedSuffocation:GetAzeriteRank() == 0 
											    or A.PMultiplier(unit, A.GarroteDebuff.ID) > 1 and 
												(
												    GetByRange(6, 10, false, true) 
											        or 
													A.Vanish:GetCooldown() > 0
												)
											  )
           
            -- variable,name=vendetta_nightstalker_condition,value=!talent.nightstalker.enabled|!talent.exsanguinate.enabled|cooldown.exsanguinate.remains<5-2*talent.deeper_stratagem.enabled
            VarVendettaNightstalkerCondition = (not A.Nightstalker:IsSpellLearned() or not A.Exsanguinate:IsSpellLearned() or A.Exsanguinate:GetCooldown() < 5 - 2 * num(A.DeeperStratagem:IsSpellLearned()))
            
            -- variable,name=variable,name=vendetta_font_condition,value=!equipped.azsharas_font_of_power|azerite.shrouded_suffocation.enabled|debuff.razor_coral_debuff.down|trinket.ashvanes_razor_coral.cooldown.remains<10&(cooldown.toxic_blade.remains<1|debuff.toxic_blade.up)
            VarVendettaFontCondition = (not A.AzsharasFontofPower:IsExists() or A.ShroudedSuffocation:GetAzeriteRank() > 0 or Unit(unit):HasDeBuffsDown(A.RazorCoralDebuff.ID, true) or A.AshvanesRazorCoral:GetCooldown() < 10 and (A.ToxicBlade:GetCooldown() < 1 or Unit(unit):HasDeBuffs(A.ToxicBladeDebuff.ID, true)))
            
            -- vendetta,if=!stealthed.rogue&dot.rupture.ticking&!debuff.vendetta.up&variable.vendetta_subterfuge_condition&variable.vendetta_nightstalker_condition&variable.vendetta_font_condition
            if A.Vendetta:IsReady(unit) and A.BurstIsON(unit) and 
			(
			    not Player:IsStealthed() and 
				Unit(unit):HasDeBuffs(A.RuptureDebuff.ID, true) > 0  
				--Unit(unit):HasDeBuffs(A.Vendetta.ID, true) == 0 and 
				--VarVendettaSubterfugeCondition and 
				--VarVendettaNightstalkerCondition and 
				--VarVendettaFontCondition
			)
			then
			    Action.SendNotification("Bursting", A.Vendetta.ID)
                return A.Vendetta:Show(icon)
            end
            
            -- vanish,if=talent.exsanguinate.enabled&talent.nightstalker.enabled&combo_points>=cp_max_spend&cooldown.exsanguinate.remains<1
            if A.Vanish:IsReady(unit) and 
			(
			    A.Exsanguinate:IsSpellLearned() and 
				A.Nightstalker:IsSpellLearned() and 
				Player:ComboPoints() >= CPMaxSpend() and 
				A.Exsanguinate:GetCooldown() < 1) 
			then
                Action.SendNotification("Offensive", A.Vanish.ID)
				return A.Vanish:Show(icon)
            end
            
            -- vanish,if=talent.nightstalker.enabled&!talent.exsanguinate.enabled&combo_points>=cp_max_spend&(debuff.vendetta.up|essence.vision_of_perfection.enabled)
            if A.Vanish:IsReady(unit) and 
			(
			    A.Nightstalker:IsSpellLearned() and 
				not A.Exsanguinate:IsSpellLearned() and 
				Player:ComboPoints() >= CPMaxSpend() and 
				(
				    Unit(unit):HasDeBuffs(A.Vendetta.ID, true) > 0
					or 
					A.VisionofPerfection:IsSpellLearned()
				)
			)
			then
			    Action.SendNotification("Offensive", A.Vanish.ID)
                return A.Vanish:Show(icon)
            end
            
            -- variable,name=ss_vanish_condition,value=azerite.shrouded_suffocation.enabled&(non_ss_buffed_targets>=1|spell_targets.fan_of_knives=3)&(ss_buffed_targets_above_pandemic=0|spell_targets.fan_of_knives>=6)
            VarSsVanishCondition = (A.ShroudedSuffocation:GetAzeriteRank() > 0 and (non_ss_buffed_targets >= 1 or MultiUnits:GetByRange(10) == 3) and (ss_buffed_targets_above_pandemic == 0 or GetByRange(6, 10)))
            
            -- pool_resource,for_next=1,extra_amount=45
            -- vanish,if=talent.subterfuge.enabled&!stealthed.rogue&cooldown.garrote.up&(variable.ss_vanish_condition|!azerite.shrouded_suffocation.enabled&(dot.garrote.refreshable|debuff.vendetta.up&dot.garrote.pmultiplier<=1))&combo_points.deficit>=((1+2*azerite.shrouded_suffocation.enabled)*spell_targets.fan_of_knives)>?4&raid_event.adds.in>12
            if A.Vanish:IsReady(unit) and 
			A.Subterfuge:IsSpellLearned() and 
			not Player:IsStealthed() and 
			A.Garrote:GetCooldown() == 0 and 
			(
			    VarSsVanishCondition 
				or 
				A.ShroudedSuffocation:GetAzeriteRank() == 0 and 
				(
				    Unit(unit):HasDeBuffsRefreshable(A.GarroteDebuff.ID, true) 
					or
					Unit(unit):HasDeBuffs(A.Vendetta.ID, true) and A.PMultiplier(unit, A.GarroteDebuff.ID) <= 1
				)
			)
			and Player:ComboPointsDeficit() >= num((1 + 2 * A.ShroudedSuffocation:GetAzeriteRank()) * MultiUnits:GetByRange(10))
			then
                if A.Vanish:IsUsablePPool(45) then
				    Action.SendNotification("Offensive", A.Vanish.ID)
                    return A.Vanish:Show(icon)
                else
                    return A.PoolResource:Show(icon)
                end
            end
            
            -- vanish,if=talent.master_assassin.enabled&!stealthed.all&master_assassin_remains<=0&!dot.rupture.refreshable&dot.garrote.remains>3&(debuff.vendetta.up&(!talent.toxic_blade.enabled|debuff.toxic_blade.up)&(!essence.blood_of_the_enemy.major|debuff.blood_of_the_enemy.up)|essence.vision_of_perfection.enabled)
            if A.Vanish:IsReady(unit) and (A.MasterAssassin:IsSpellLearned() and not Player:IsStealthed() and MasterAssassinRemains <= 0 and not Unit(unit):HasDeBuffsRefreshable(A.RuptureDebuff.ID, true) and Unit(unit):HasDeBuffs(A.GarroteDebuff.ID, true) > 3 and (Unit(unit):HasDeBuffs(A.Vendetta.ID, true) and (not A.ToxicBlade:IsSpellLearned() or Unit(unit):HasDeBuffs(A.ToxicBladeDebuff.ID, true)) and (not Azerite:EssenceHasMajor(A.BloodoftheEnemy.ID) or Unit(unit):HasDeBuffs(A.BloodoftheEnemyDebuff.ID, true)) or A.VisionofPerfection:IsSpellLearned())) then
                Action.SendNotification("Offensive", A.Vanish.ID)
				return A.Vanish:Show(icon)
            end
            
            -- shadowmeld,if=!stealthed.all&azerite.shrouded_suffocation.enabled&dot.garrote.refreshable&dot.garrote.pmultiplier<=1&combo_points.deficit>=1
            if A.Shadowmeld:AutoRacial(unit) and Racial and A.BurstIsON(unit) and (not Player:IsStealthed() and A.ShroudedSuffocation:GetAzeriteRank() > 0 and Unit(unit):HasDeBuffsRefreshable(A.GarroteDebuff.ID, true) and A.PMultiplier(unit, A.GarroteDebuff.ID) <= 1 and Player:ComboPointsDeficit() >= 1) then
                return A.Shadowmeld:Show(icon)
            end
            
            -- exsanguinate,if=!stealthed.rogue&(!dot.garrote.refreshable&dot.rupture.remains>4+4*cp_max_spend|dot.rupture.remains*0.5>target.time_to_die)&target.time_to_die>4
            if A.Exsanguinate:IsReady(unit) and (not Player:IsStealthed() and (Unit(unit):HasDeBuffs(A.GarroteDebuff.ID, true) > 4 and Unit(unit):HasDeBuffs(A.RuptureDebuff.ID, true) > 4 + 4 * CPMaxSpend() or Unit(unit):HasDeBuffs(A.RuptureDebuff.ID, true) * 0.5 > Unit(unit):TimeToDie()) and Unit(unit):TimeToDie() > 4) then
                Action.SendNotification("Burst", A.Exsanguinate.ID)
				return A.Exsanguinate:Show(icon)
            end
            
            -- toxic_blade,if=dot.rupture.ticking&(!equipped.azsharas_font_of_power|cooldown.vendetta.remains>10)
			if A.ToxicBlade:IsSpellLearned() and Player:ComboPoints() >= 4 + num(A.DeeperStratagem:IsSpellLearned()) and (A.Vendetta:GetCooldown() > 0 or not A.BurstIsON(unit)) then
                if Unit(unit):HasDeBuffs(A.RuptureDebuff.ID, true) > 5 and 
			    Player:EnergyPredicted() <= 70 and 
		    	A.ToxicBlade:GetCooldown() < 4 and
                A.ToxicBlade:GetCooldown() > 0            		
			    then
                    return A.PoolResource:Show(icon)
                else
                    if A.ToxicBlade:IsReady(unit) then
					    if A.ToxicBlade:IsUsablePPool(50) then                -- offset 50 + Initial cost 20 To get the 70
                            return A.ToxicBlade:Show(icon)
                        else
                            return A.PoolResource:Show(icon)    
                        end							
                    end
                end
			end
            
            -- potion,if=buff.bloodlust.react|debuff.vendetta.up
            if A.PotionofUnbridledFury:IsReady(unit) and Potion and (Unit("player"):HasHeroism() or Unit(unit):HasDeBuffs(A.Vendetta.ID, true)) then
                return A.PotionofUnbridledFury:Show(icon)
            end
            
            -- blood_fury,if=debuff.vendetta.up
            if A.BloodFury:AutoRacial(unit) and Racial and A.BurstIsON(unit) and Unit(unit):HasDeBuffs(A.Vendetta.ID, true) > 0 then
                return A.BloodFury:Show(icon)
            end
            
            -- berserking,if=debuff.vendetta.up
            if A.Berserking:AutoRacial(unit) and Racial and A.BurstIsON(unit) and Unit(unit):HasDeBuffs(A.Vendetta.ID, true) > 0 then
                return A.Berserking:Show(icon)
            end
            
            -- fireblood,if=debuff.vendetta.up
            if A.Fireblood:AutoRacial(unit) and Racial and A.BurstIsON(unit) and Unit(unit):HasDeBuffs(A.Vendetta.ID, true) > 0 then
                return A.Fireblood:Show(icon)
            end
            
            -- ancestral_call,if=debuff.vendetta.up
            if A.AncestralCall:AutoRacial(unit) and Racial and A.BurstIsON(unit) and Unit(unit):HasDeBuffs(A.Vendetta.ID, true) > 0 then
                return A.AncestralCall:Show(icon)
            end
            
            -- use_item,name=galecallers_boon,if=(debuff.vendetta.up|(!talent.exsanguinate.enabled&cooldown.vendetta.remains>45|talent.exsanguinate.enabled&(cooldown.exsanguinate.remains<6|cooldown.exsanguinate.remains>20&IsInRaid() and fight_remains>65)))&!exsanguinated.rupture
            if A.GalecallersBoon:IsReady(unit) and ((Unit(unit):HasDeBuffs(A.Vendetta.ID, true) or (not A.Exsanguinate:IsSpellLearned() and A.Vendetta:GetCooldown() > 45 or A.Exsanguinate:IsSpellLearned() and (A.Exsanguinate:GetCooldown() < 6 or A.Exsanguinate:GetCooldown() > 20 and IsInRaid() and fight_remains > 65))) and not Exsanguinated(unit, "Rupture")) then
                return A.GalecallersBoon:Show(icon)
            end
            
            -- use_item,name=ashvanes_razor_coral,if=debuff.razor_coral_debuff.down|IsInRaid() and fight_remains<20
            if A.AshvanesRazorCoral:IsReady(unit) and (Unit(unit):HasDeBuffs(A.RazorCoralDebuff.ID, true) == 0 or (IsInRaid() and IsInRaid() and fight_remains < 20)) then
                return A.AshvanesRazorCoral:Show(icon)
            end
            
            -- use_item,name=ashvanes_razor_coral,if=(!talent.exsanguinate.enabled|!talent.subterfuge.enabled)&debuff.vendetta.remains>10-4*equipped.azsharas_font_of_power
            if A.AshvanesRazorCoral:IsReady(unit) and 
			(
			    (
				    not A.Exsanguinate:IsSpellLearned() 
					or 
					not A.Subterfuge:IsSpellLearned()
				)
				and Unit(unit):HasDeBuffs(A.Vendetta.ID, true) > 10 - 4 * num(A.AzsharasFontofPower:IsExists())
			)
			then
                return A.AshvanesRazorCoral:Show(icon)
            end
            
            -- use_item,name=ashvanes_razor_coral,if=(talent.exsanguinate.enabled&talent.subterfuge.enabled)&debuff.vendetta.up&(exsanguinated.garrote|azerite.shrouded_suffocation.enabled&dot.garrote.pmultiplier>1)
            if A.AshvanesRazorCoral:IsReady(unit) and 
			(
			    (A.Exsanguinate:IsSpellLearned() and A.Subterfuge:IsSpellLearned()) and 
				Unit(unit):HasDeBuffs(A.Vendetta.ID, true) > 0 and 
				(
				    Exsanguinated(unit, "Garrote") 
					or 
					A.ShroudedSuffocation:GetAzeriteRank() > 0 and A.PMultiplier(unit, A.GarroteDebuff.ID) > 1
				)
			)
			then
                return A.AshvanesRazorCoral:Show(icon)
            end
            
            -- use_item,effect_name=cyclotronic_blast,if=master_assassin_remains=0&!debuff.vendetta.up&!debuff.toxic_blade.up&buff.memory_of_lucid_dreams.down&energy<80&dot.rupture.remains>4
            if A.CyclotronicBlast:IsReady(unit) and (MasterAssassinRemains == 0 and Unit(unit):HasDeBuffs(A.Vendetta.ID, true) == 0 and Unit(unit):HasDeBuffs(A.ToxicBladeDebuff.ID, true) == 0 and Unit("player"):HasBuffsDown(A.MemoryofLucidDreamsBuff.ID, true) and Player:EnergyPredicted() < 80 and Unit(unit):HasDeBuffs(A.RuptureDebuff.ID, true) > 4) then
                return A.CyclotronicBlast:Show(icon)
            end
            
            -- use_item,name=lurkers_insidious_gift,if=debuff.vendetta.up
            if A.LurkersInsidiousGift:IsReady(unit) and Unit(unit):HasDeBuffs(A.Vendetta.ID, true) > 0 then
                return A.LurkersInsidiousGift:Show(icon)
            end
            
            -- use_item,name=lustrous_golden_plumage,if=debuff.vendetta.up
            if A.LustrousGoldenPlumage:IsReady(unit) and Unit(unit):HasDeBuffs(A.Vendetta.ID, true) > 0 then
                return A.LustrousGoldenPlumage:Show(icon)
            end
            
			-- use_item,effect_name=gladiators_medallion,if=debuff.vendetta.up
            if A.CorruptedGladiatorsMedallion:IsReady("player") and 
			(
			    Unit(unit):HasDeBuffs(A.Vendetta.ID, true) > 0 and 
				(
					Unit(unit):TimeToDie() < 30 
					or 
					A.IsInPvP and Unit(unit):TimeToDie() < 5
				)
			)
			then
                return A.CorruptedGladiatorsMedallion:Show(icon)
            end           
        end
            
        -- call_action_list,name=dot
        if inCombat and Unit(unit):IsExists() then
		
            -- variable,name=skip_cycle_garrote,value=priority_rotation&spell_targets.fan_of_knives>3&(dot.garrote.remains<cooldown.garrote.duration|poisoned_bleeds>5)
            VarSkipCycleGarrote = (priority_rotation and GetByRange(3, 10, true) and (Unit(unit):HasDeBuffs(A.GarroteDebuff.ID, true) < A.Garrote:BaseDuration() or PoisonedBleeds() > 5))
            
            -- variable,name=skip_cycle_rupture,value=priority_rotation&spell_targets.fan_of_knives>3&(debuff.toxic_blade.up|(poisoned_bleeds>5&!azerite.scent_of_blood.enabled))
            VarSkipCycleRupture = (priority_rotation and GetByRange(3, 10, true) and (Unit(unit):HasDeBuffs(A.ToxicBladeDebuff.ID, true) or (PoisonedBleeds() > 5 and A.ScentofBlood:GetAzeriteRank() == 0)))
            
            -- variable,name=skip_rupture,value=debuff.vendetta.up&(debuff.toxic_blade.up|master_assassin_remains>0)&dot.rupture.remains>2
            VarSkipRupture = (Unit(unit):HasDeBuffs(A.Vendetta.ID, true) and (Unit(unit):HasDeBuffs(A.ToxicBladeDebuff.ID, true) or MasterAssassinRemains > 0) and Unit(unit):HasDeBuffs(A.RuptureDebuff.ID, true) > 2)
 
            -- garrote,refreshable
            if A.Garrote:IsReady(unit) and 
			Unit(unit):TimeToDie() > 2 and 
			Unit(unit):HasDeBuffs(A.GarroteDebuff.ID, true) == 0			 
			then
                return A.Garrote:Show(icon)
            end
 
            -- garrote,if=talent.exsanguinate.enabled&!exsanguinated.garrote&dot.garrote.pmultiplier<=1&cooldown.exsanguinate.remains<2&spell_targets.fan_of_knives=1&raid_event.adds.in>6&dot.garrote.remains*0.5<target.time_to_die
            if A.Garrote:IsReady(unit) and 
			(
			    A.Exsanguinate:IsSpellLearned() and 
				not Exsanguinated(unit, "Garrote") and 
				A.PMultiplier(unit, A.GarroteDebuff.ID) <= 1 and 
				A.Exsanguinate:GetCooldown() < 2 and 
				MultiUnits:GetByRange(10) == 1 and 
				--IncomingAddsIn > 6 and 
				Unit(unit):HasDeBuffs(A.GarroteDebuff.ID, true) * 0.5 < Unit(unit):TimeToDie()
			) 
			then
                return A.Garrote:Show(icon)
            end
            
            -- rupture,if=talent.exsanguinate.enabled&!dot.garrote.refreshable&(combo_points>=cp_max_spend&cooldown.exsanguinate.remains<1&dot.rupture.remains*0.5<target.time_to_die)
            if A.Rupture:IsReady(unit) and (A.Exsanguinate:IsSpellLearned() and not Unit(unit):HasDeBuffsRefreshable(A.GarroteDebuff.ID, true) and (Player:ComboPoints() >= CPMaxSpend() and A.Exsanguinate:GetCooldown() < 1 and Unit(unit):HasDeBuffs(A.RuptureDebuff.ID, true) * 0.5 < Unit(unit):TimeToDie())) then
                return A.Rupture:Show(icon)
            end

            -- Auto Multidot
            if Unit(unit):TimeToDie() > 10  
            and Action.GetToggle(2, "AoE") and Action.GetToggle(2, "AutoDot") and not A.IsInPvP and CanMultidot
            and 
			(
                MissingRupture >= 1 and ActivesRupture <= 4 and Unit(unit):HasDeBuffs(A.Rupture.ID, true) > 0 and Unit(unit):HasDeBuffs(A.Garrote.ID, true) > 0 
                or
                A.Subterfuge:IsSpellLearned() and A.IronWire:IsSpellLearned() and Unit("player"):HasBuffs(A.SubterfugeBuff.ID, true) > 0 and A.GetToggle(2, "IWSubterfuge")
                and MissingGarrote >= 1 and Unit(unit):HasDeBuffs(A.Garrote.ID, true) > 0
            ) 
            and (Unit(unit):HasDeBuffs(A.Vendetta.ID, true) == 0 ) and MultiUnits:GetByRange(5) > 1 and MultiUnits:GetByRange(5) < 6
            then
                return A:Show(icon, ACTION_CONST_AUTOTARGET)
            end
            
            -- pool_resource,for_next=1
            -- garrote,if=refreshable&combo_points.deficit>=1+3*(azerite.shrouded_suffocation.enabled&cooldown.vanish.up)&(pmultiplier<=1|remains<=tick_time&spell_targets.fan_of_knives>=3+azerite.shrouded_suffocation.enabled)&(!exsanguinated|remains<=tick_time*2&spell_targets.fan_of_knives>=3+azerite.shrouded_suffocation.enabled)&!ss_buffed&(target.time_to_die-remains)>4&(master_assassin_remains=0|!ticking&azerite.shrouded_suffocation.enabled)
            if A.Garrote:IsReady(unit) and not A.LastPlayerCastName == A.Garrote:Info() and 
			(
			    Unit(unit):HasDeBuffs(A.GarroteDebuff.ID, true) < A.GetGCD() + 0.1 and 
				Player:ComboPointsDeficit() >= 1 + 3 * num((A.ShroudedSuffocation:GetAzeriteRank() > 0 and A.Vanish:GetCooldown() == 0)) and 
				(
				    A.PMultiplier(unit, A.GarroteDebuff.ID) <= 1 
					or 
					Unit(unit):HasDeBuffs(A.GarroteDebuff.ID, true) <= GarroteTickTime() and GetByRange(3 + num(A.ShroudedSuffocation:GetAzeriteRank() > 0), 40)
				)
				and 
				(
				    not Exsanguinated(unit, "Garrote") 
					or 
					Unit(unit):HasDeBuffs(A.GarroteDebuff.ID, true) <= GarroteTickTime() * 2 and GetByRange(3 + num(A.ShroudedSuffocation:GetAzeriteRank() > 0), 40)
				)
				and not ss_buffed and (Unit(unit):TimeToDie() - Unit(unit):HasDeBuffs(A.GarroteDebuff.ID, true)) > 4 and (MasterAssassinRemains == 0 or not Unit(unit):HasDeBuffs(A.GarroteDebuff.ID, true) and A.ShroudedSuffocation:GetAzeriteRank() > 0)) then
                if A.Garrote:IsUsablePPool(45) then
                    return A.Garrote:Show(icon)
                else
                    return A.PoolResource:Show(icon)
                end
            end
            
            -- pool_resource,for_next=1
            -- garrote,cycle_targets=1,if=!variable.skip_cycle_garrote&target!=self.target&refreshable&combo_points.deficit>=1+3*(azerite.shrouded_suffocation.enabled&cooldown.vanish.up)&(pmultiplier<=1|remains<=tick_time&spell_targets.fan_of_knives>=3+azerite.shrouded_suffocation.enabled)&(!exsanguinated|remains<=tick_time*2&spell_targets.fan_of_knives>=3+azerite.shrouded_suffocation.enabled)&!ss_buffed&(target.time_to_die-remains)>12&(master_assassin_remains=0|!ticking&azerite.shrouded_suffocation.enabled)
            if A.Garrote:IsReady(unit) and not A.LastPlayerCastName == A.Garrote:Info() and
                not VarSkipCycleGarrote and 
				unit ~= "target" and 
				Unit(unit):HasDeBuffsRefreshable(A.GarroteDebuff.ID, true) and 
				Player:ComboPointsDeficit() >= 1 + 3 * num((A.ShroudedSuffocation:GetAzeriteRank() > 0 and
				A.Vanish:GetCooldown() == 0)) and 
				(
				    A.PMultiplier(unit, A.GarroteDebuff.ID) <= 1 
					or 
					Unit(unit):HasDeBuffs(A.GarroteDebuff.ID, true) <= GarroteTickTime() and GetByRange(3, 40) + A.ShroudedSuffocation:GetAzeriteRank() > 0
				) and 
				(
				    not Exsanguinated(unit, "Garrote") 
					or 
					Unit(unit):HasDeBuffs(A.GarroteDebuff.ID, true) <= GarroteTickTime() * 2 and GetByRange(3, 40) + A.ShroudedSuffocation:GetAzeriteRank() > 0
				) and 
				not ss_buffed and 
				(Unit(unit):TimeToDie() - Unit(unit):HasDeBuffs(A.GarroteDebuff.ID, true)) > 12 and 
				(MasterAssassinRemains == 0 or not Unit(unit):HasDeBuffs(A.GarroteDebuff.ID, true) and A.ShroudedSuffocation:GetAzeriteRank() > 0)
            then
                return A.Garrote:Show(icon) 
            end
			
            -- crimson_tempest,target_if=min:remains,if=spell_targets>3&remains<2+(spell_targets>=5)&combo_points>=4
            if A.CrimsonTempest:IsReady(player) and
            GetByRange(3, 10, true) and 
			Unit(unit):HasDeBuffs(A.CrimsonTempest.ID, true) < 2 + num(GetByRange(5, 10)) and 
			Player:ComboPoints() >= 4
			then 
                return A.CrimsonTempest:Show(icon)                 
            end
			
            -- rupture,if=!variable.skip_rupture&(combo_points>=4&refreshable|!ticking&(time>10|combo_points>=2))&(pmultiplier<=1|remains<=tick_time&spell_targets.fan_of_knives>=3+azerite.shrouded_suffocation.enabled)&(!exsanguinated|remains<=tick_time*2&spell_targets.fan_of_knives>=3+azerite.shrouded_suffocation.enabled)&target.time_to_die-remains>4
            if A.Rupture:IsReady(unit) and 
			(
			    not VarSkipRupture and 
				(
				    Player:ComboPoints() >= 4 and Unit(unit):HasDeBuffsRefreshable(A.RuptureDebuff.ID, true) 
					or 
					Unit(unit):HasDeBuffs(A.RuptureDebuff.ID, true) == 0 and 
					(
					    Unit("player"):CombatTime() > 10 
						or 
						Player:ComboPoints() >= 2
					)
				) and 
				(
				    A.PMultiplier(unit, A.RuptureDebuff.ID) <= 1 
					or 
					Unit(unit):HasDeBuffs(A.RuptureDebuff.ID, true) <= 2 and GetByRange(3 + num(A.ShroudedSuffocation:GetAzeriteRank() > 0), 40) 
				) and 
				(
				    not Exsanguinated(unit, "Rupture") 
					or 
					Unit(unit):HasDeBuffs(A.RuptureDebuff.ID, true) <= 4 and GetByRange(3 + num(A.ShroudedSuffocation:GetAzeriteRank() > 0), 40) 
				) and Unit(unit):TimeToDie() - Unit(unit):HasDeBuffs(A.RuptureDebuff.ID, true) > 4) 
			then
                return A.Rupture:Show(icon)
            end
            
            -- rupture,cycle_targets=1,if=!variable.skip_cycle_rupture&!variable.skip_rupture&target!=self.target&combo_points>=4&refreshable&(pmultiplier<=1|remains<=tick_time&spell_targets.fan_of_knives>=3+azerite.shrouded_suffocation.enabled)&(!exsanguinated|remains<=tick_time*2&spell_targets.fan_of_knives>=3+azerite.shrouded_suffocation.enabled)&target.time_to_die-remains>4+(poisoned_bleeds>2)*6
            if A.Rupture:IsReady(unit) and
			not VarSkipCycleRupture and 
			not VarSkipRupture and 
			unit ~= "target" and 
			Player:ComboPoints() >= 4 and 
			Unit(unit):HasDeBuffsRefreshable(A.RuptureDebuff.ID, true) and 
			(
			    A.PMultiplier(unit, A.RuptureDebuff.ID) <= 1
				or 
				Unit(unit):HasDeBuffs(A.RuptureDebuff.ID, true) <= 2 and GetByRange(3, 40) + A.ShroudedSuffocation:GetAzeriteRank() > 0
			) and 
			(
			    not Exsanguinated(unit, "Rupture") 
				or
				Unit(unit):HasDeBuffs(A.RuptureDebuff.ID, true) <= 4 and GetByRange(3, 40) + A.ShroudedSuffocation:GetAzeriteRank() > 0
			) and 
			Unit(unit):TimeToDie() - Unit(unit):HasDeBuffs(A.RuptureDebuff.ID, true) > 4 + num((PoisonedBleeds() > 2)) * 6
            then
                return A.Rupture:Show(icon) 
                
            end
			
            -- crimson_tempest,target_if=min:remains,if=spell_targets>1&spell_targets<4&remains<2&combo_points>=4
            if A.CrimsonTempest:IsReady(player) and
            GetByRange(1, 40, true) and 
			GetByRange(4, 10, false, true) and 
			Unit(unit):HasDeBuffs(A.CrimsonTempest.ID, true) < 2 and 
			Player:ComboPoints() >= 4 
			then 
                return A.CrimsonTempest:Show(icon) 
            end
			
            -- crimson_tempest,if=spell_targets=1&combo_points>=(cp_max_spend-1)&refreshable&!exsanguinated&!debuff.toxic_blade.up&master_assassin_remains=0&!azerite.twist_the_knife.enabled&target.time_to_die-remains>4
            if A.CrimsonTempest:IsReady(player) and 
			(
			    --MultiUnits:GetByRange(10) == 1 and 
				Player:ComboPoints() >= (CPMaxSpend() - 1) and 
				Unit(unit):HasDeBuffs(A.CrimsonTempest.ID, true) < A.GetGCD() + 0.1 and 
				not Exsanguinated(unit, "CrimsonTempest") and 
				Unit(unit):HasDeBuffs(A.ToxicBladeDebuff.ID, true) == 0 and 
				MasterAssassinRemains == 0 and 
				A.TwisttheKnife:GetAzeriteRank() == 0 and
				Unit(unit):TimeToDie() - Unit(unit):HasDeBuffs(A.CrimsonTempest.ID, true) > 4) 
			then
                return A.CrimsonTempest:Show(icon)
            end
            
            -- crimson_tempest,if=spell_targets>(7-buff.envenom.up)&combo_points>=4+talent.deeper_stratagem.enabled&!debuff.vendetta.up&!debuff.toxic_blade.up&!azerite.twist_the_knife.enabled&energy.deficit<=25+variable.energy_regen_combined
            if A.CrimsonTempest:IsReady(player) and (GetByRange(7 - num(Unit("player"):HasBuffs(A.Envenom.ID, true) > 0), 10, true) and Player:ComboPoints() >= 4 + num(A.DeeperStratagem:IsSpellLearned()) and Unit(unit):HasDeBuffs(A.Vendetta.ID, true) == 0 and Unit(unit):HasDeBuffs(A.ToxicBladeDebuff.ID, true) == 0 and A.TwisttheKnife:GetAzeriteRank() == 0 and Player:EnergyDeficitPredicted() <= 25 + VarEnergyRegenCombined) then
                return A.CrimsonTempest:Show(icon)
            end
        end
            
        -- call_action_list,name=direct
        if inCombat and Unit(unit):IsExists() then
            
			-- envenom,if=combo_points>=4+talent.deeper_stratagem.enabled&(debuff.vendetta.up|debuff.toxic_blade.up|energy.deficit<=25+variable.energy_regen_combined|!variable.single_target)&(!talent.exsanguinate.enabled|!debuff.vendetta.up|cooldown.exsanguinate.remains>2)	
			if A.Envenom:IsReady(unit) and 
			(
			    Player:ComboPoints() >= 4 + num(A.DeeperStratagem:IsSpellLearned()) and 
				(
				    Unit(unit):HasDeBuffs(A.Vendetta.ID, true) > 0 
					or 
					Unit(unit):HasDeBuffs(A.ToxicBladeDebuff.ID, true) > 0
					or 
					Player:EnergyDeficitPredicted() <= 25 + VarEnergyRegenCombined 
					or 
					not VarSingleUnit
				)
				and 
				(
				    not A.Exsanguinate:IsSpellLearned() 
					or 
					Unit(unit):HasDeBuffs(A.Vendetta.ID, true) == 0 
					or 
					A.Exsanguinate:GetCooldown() > 2
				)
				and
				(
				    not A.ToxicBlade:IsSpellLearned() 
					or 
					A.ToxicBlade:GetCooldown() > 3
				)
			)
			then
                return A.Envenom:Show(icon)
            --else
            --    return A.PoolResource:Show(icon)
            end
            
            -- variable,name=use_filler,value=combo_points.deficit>1|energy.deficit<=25+variable.energy_regen_combined|!variable.single_target
            VarUseFiller = (Player:ComboPointsDeficit() > 1 or Player:EnergyDeficitPredicted() <= 25 + VarEnergyRegenCombined or not VarSingleUnit)
            
            -- fan_of_knives,if=variable.use_filler&azerite.echoing_blades.enabled&spell_targets.fan_of_knives>=2+(debuff.vendetta.up*(1+(azerite.echoing_blades.rank=1)))
            if A.FanofKnives:IsReady("player") and VarUseFiller and A.EchoingBlades:GetAzeriteRank() > 0 and GetByRange(2 + num(Unit(unit):HasDeBuffs(A.Vendetta.ID, true) > 0) * 1 + num(A.EchoingBlades:GetAzeriteRank() == 1), 10) then
                return A.FanofKnives:Show(icon)
            end
            
            -- fan_of_knives,if=variable.use_filler&(buff.hidden_blades.stack>=19|(!priority_rotation&spell_targets.fan_of_knives>=4+(azerite.double_dose.rank>2)+stealthed.rogue))
            if A.FanofKnives:IsReady("player") and 
			(
			    VarUseFiller and 
				(
				    Unit("player"):HasBuffsStacks(A.HiddenBladesBuff.ID, true) >= 19 
					or 
					(not priority_rotation and GetByRange(4 + num((A.DoubleDose:GetAzeriteRank() > 2)) + num(Player:IsStealthed()), 10) )
				)
			)
			then
                return A.FanofKnives:Show(icon)
            end
            
            -- fan_of_knives,target_if=!dot.deadly_poison_dot.ticking,if=variable.use_filler&spell_targets.fan_of_knives>=3
            if A.FanofKnives:IsReady("player") and
			Unit(unit):HasDeBuffs(A.DeadlyPoison.ID, true) == 0 and 
			(
			    VarUseFiller and 
				GetByRange(3, 40)
			)
			then
                return A.FanofKnives:Show(icon)                 
            end
			
            -- blindside,if=variable.use_filler&(buff.blindside.up|!talent.venom_rush.enabled&!azerite.double_dose.enabled)
            if A.Blindside:IsReady(unit) and (VarUseFiller and (Unit("player"):HasBuffs(A.BlindsideBuff.ID, true) > 0 or not A.VenomRush:IsSpellLearned() and A.DoubleDose:GetAzeriteRank() == 0)) then
                return A.Blindside:Show(icon)
            end
            
            -- mutilate,target_if=!dot.deadly_poison_dot.ticking,if=variable.use_filler&spell_targets.fan_of_knives=2
            if A.Mutilate:IsReady(unit) and
            Unit(unit):HasDeBuffs(A.DeadlyPoison.ID, true) == 0 and 
			(
			    VarUseFiller and 
				MultiUnits:GetByRange(10) == 2
			)
			then
                return A.Mutilate:Show(icon) 
            end
			
            -- mutilate,if=variable.use_filler
            if A.Mutilate:IsReady(unit) and VarUseFiller then
                return A.Mutilate:Show(icon)
            end
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
        if A.LightsJudgment:AutoRacial(unit) and A.BurstIsON(unit) then
            return A.LightsJudgment:Show(icon)
        end
            
        -- bag_of_tricks
        if A.BagofTricks:AutoRacial(unit) then
            return A.BagofTricks:Show(icon)
        end        

    end

    -- End on EnemyRotation()

    -- RefreshPoisons
    local RefreshPoisons = RefreshPoisons()
    if RefreshPoisons then 
        -- Notification                    
        Action.SendNotification("Auto refreshing poisons", A.CripplingPoison.ID)
        return RefreshPoisons:Show(icon)
    end 
    
    -- Stealth out of combat
    local CurrentStealth = A.Subterfuge:IsSpellLearned() and A.Stealth2 or A.Stealth -- w/ or w/o Subterfuge Talent        
    if not inCombat and Unit("player"):HasBuffs(A.VanishBuff.ID, true) == 0 and Action.GetToggle(2, "StealthOOC") and not Unit("player"):HasFlags() and CurrentStealth:IsReady("player") and Unit("player"):HasBuffs(CurrentStealth.ID, true) == 0 then
        -- Notification                    
        Action.SendNotification("Auto Stealthing", A.Stealth.ID)
        return CurrentStealth:Show(icon)
    end 

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
    if (unit == "party1" and not A.GetToggle(2, "PartyUnits")[1]) or (unit == "party2" and not A.GetToggle(2, "PartyUnits")[2]) then 
        return false 
    end
end 

A[6] = function(icon)
    return ArenaRotation(icon, "arena1")
end

A[7] = function(icon)
   -- local Party = PartyRotation("party1") 
    if Party then 
        return Party:Show(icon)
    end 
    return ArenaRotation(icon, "arena2")
end

A[8] = function(icon)
   -- local Party = PartyRotation("party2") 
    if Party then 
        return Party:Show(icon)
    end     
    return ArenaRotation(icon, "arena3")
end

