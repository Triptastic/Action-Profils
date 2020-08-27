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
local Azerite									= LibStub("AzeriteTraits")
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
local next, pairs, type, print                  = next, pairs, type, print
local wipe                                      = wipe 
local math_floor                                = math.floor
local math_ceil                                 = math.ceil
local tinsert                                   = table.insert 
local TMW                                       = TMW
local _G, setmetatable                          = _G, setmetatable
local select, unpack, table, pairs              = select, unpack, table, pairs 
local CombatLogGetCurrentEventInfo              = _G.CombatLogGetCurrentEventInfo
local UnitGUID, UnitIsUnit, UnitDamage, UnitAttackSpeed, UnitAttackPower = UnitGUID, UnitIsUnit, UnitDamage, UnitAttackSpeed, UnitAttackPower

--- ============================ CONTENT ===========================
--- ======= APL LOCALS =======
-- luacheck: max_line_length 9999

-- Spells
Action[ACTION_CONST_DRUID_BALANCE] = {
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
    --BullRush                               = Action.Create({ Type = "Spell", ID = 255654     }),  
    GiftofNaaru                            = Action.Create({ Type = "Spell", ID = 59544    }),
    Shadowmeld                             = Action.Create({ Type = "Spell", ID = 58984    }), -- usable in Action Core 
    Stoneform                              = Action.Create({ Type = "Spell", ID = 20594    }), 
    WilloftheForsaken                      = Action.Create({ Type = "Spell", ID = 7744        }), -- not usable in APL but user can Queue it   
    EscapeArtist                           = Action.Create({ Type = "Spell", ID = 20589    }), -- not usable in APL but user can Queue it
    EveryManforHimself                     = Action.Create({ Type = "Spell", ID = 59752    }), -- not usable in APL but user can Queue it
    -- Generics
    StreakingStars                         = Action.Create({ Type = "Spell", ID = 272871 }),
    ArcanicPulsarBuff                      = Action.Create({ Type = "Spell", ID = 287790, Hidden = true }),
    ArcanicPulsar                          = Action.Create({ Type = "Spell", ID = 287773 }),
    StarlordBuff                           = Action.Create({ Type = "Spell", ID = 279709, Hidden = true }),
    Starlord                               = Action.Create({ Type = "Spell", ID = 202345 }),
    TwinMoons                              = Action.Create({ Type = "Spell", ID = 279620 }),
    MoonkinForm                            = Action.Create({ Type = "Spell", ID = 24858 }),
    SolarWrath                             = Action.Create({ Type = "Spell", ID = 190984 }),
    Starsurge                              = Action.Create({ Type = "Spell", ID = 78674 }),
    CelestialAlignmentBuff                 = Action.Create({ Type = "Spell", ID = 194223, Hidden = true }),
    IncarnationBuff                        = Action.Create({ Type = "Spell", ID = 102560, Hidden = true }),
    Berserking                             = Action.Create({ Type = "Spell", ID = 26297 }),
    MoonfireDebuff                         = Action.Create({ Type = "Spell", ID = 164812, Hidden = true }),
    SunfireDebuff                          = Action.Create({ Type = "Spell", ID = 164815, Hidden = true }),
    StellarFlare                           = Action.Create({ Type = "Spell", ID = 202347 }),
    StellarFlareDebuff                     = Action.Create({ Type = "Spell", ID = 202347, Hidden = true }),
    ShiverVenomDebuff                      = Action.Create({ Type = "Spell", ID = 301624, Hidden = true     }),	
    Thorns                                 = Action.Create({ Type = "Spell", ID = 467 }),
    WarriorofElune                         = Action.Create({ Type = "Spell", ID = 202425 }),
    Innervate                              = Action.Create({ Type = "Spell", ID = 29166 }),
    LivelySpirit                           = Action.Create({ Type = "Spell", ID = 279642 }),
    Incarnation                            = Action.Create({ Type = "Spell", ID = 102560 }),
    CelestialAlignment                     = Action.Create({ Type = "Spell", ID = 194223 }),
    ForceofNature                          = Action.Create({ Type = "Spell", ID = 205636 }),
    LivelySpiritBuff                       = Action.Create({ Type = "Spell", ID = 279646, Hidden = true }),
    FuryofElune                            = Action.Create({ Type = "Spell", ID = 202770 }),
    Starfall                               = Action.Create({ Type = "Spell", ID = 191034 }),
    LunarEmpowermentBuff                   = Action.Create({ Type = "Spell", ID = 164547, Hidden = true }),
    SolarEmpowermentBuff                   = Action.Create({ Type = "Spell", ID = 164545, Hidden = true }),
    Sunfire                                = Action.Create({ Type = "Spell", ID = 93402 }),
    Moonfire                               = Action.Create({ Type = "Spell", ID = 8921 }),
    NewMoon                                = Action.Create({ Type = "Spell", ID = 274281 }),
    HalfMoon                               = Action.Create({ Type = "Spell", ID = 274282 }),
    FullMoon                               = Action.Create({ Type = "Spell", ID = 274283 }),
    LunarStrike                            = Action.Create({ Type = "Spell", ID = 194153 }),
    WarriorofEluneBuff                     = Action.Create({ Type = "Spell", ID = 202425, Hidden = true }),
    Renewal                                = Action.Create({ Type = "Spell", ID = 108238     }),
    SolarBeam                              = Action.Create({ Type = "Spell", ID = 78675     }), 
    ShootingStars                          = Action.Create({ Type = "Spell", ID = 202342     }),
    NaturesBalance                         = Action.Create({ Type = "Spell", ID = 202430     }),	
	-- Utilities
	Typhoon                                = Action.Create({ Type = "Spell", ID = 132469   }),
	MightyBash                             = Action.Create({ Type = "Spell", ID = 5211   }),
	Soothe                                 = Action.Create({ Type = "Spell", ID = 2908   }),    
	EntanglingRoots                        = Action.Create({ Type = "Spell", ID = 339   }), 
	RemoveCorruption                       = Action.Create({ Type = "Spell", ID = 2782  }),
	Cyclone                                = Action.Create({ Type = "Spell", ID = 33786 }),
    -- Defensive
	Barkskin                               = Action.Create({ Type = "Spell", ID = 22812   }),	
	Swiftmend								= Action.Create({ Type = "Spell", ID = 18562}), -- Talent 3/3 -- Resto Affinity
	CancelStarlord                         = Action.Create({ Type = "Spell", ID = 208683, Hidden = true}), -- 208683 Gladiator medaillon remap
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
    MerekthasFang                          = Action.Create({ Type = "Trinket", ID = 158367 }),	
	GrongsPrimalRage                       = Action.Create({ Type = "Trinket", ID = 165574 }),
	BygoneBeeAlmanac                       = Action.Create({ Type = "Trinket", ID = 163936 }),
	RampingAmplitudeGigavoltEngine         = Action.Create({ Type = "Trinket", ID = 165580 }),
	VisionofDemise                         = Action.Create({ Type = "Trinket", ID = 169307 }),
	JesHowler                              = Action.Create({ Type = "Trinket", ID = 159627 }),
	GalecallersBeak                        = Action.Create({ Type = "Trinket", ID = 161379 }),
    DribblingInkpod                        = Action.Create({ Type = "Trinket", ID = 169319 }),
    RazdunksBigRedButton                   = Action.Create({ Type = "Trinket", ID = 159611 }),
    MerekthasFang                          = Action.Create({ Type = "Trinket", ID = 158367 }),
    KnotofAncientFuryAlliance              = Action.Create({ Type = "Trinket", ID = 161413 }),
    KnotofAncientFuryHorde                 = Action.Create({ Type = "Trinket", ID = 166795 }),
    FirstMatesSpyglass                     = Action.Create({ Type = "Trinket", ID = 158163 }),
    VialofAnimatedBlood                    = Action.Create({ Type = "Trinket", ID = 159625 }),
    -- Misc
    Channeling                             = Action.Create({ Type = "Spell", ID = 209274, Hidden = true     }),	-- Show an icon during channeling
    TargetEnemy                            = Action.Create({ Type = "Spell", ID = 44603, Hidden = true     }),	-- Change Target (Tab button)
    StopCast                               = Action.Create({ Type = "Spell", ID = 61721, Hidden = true     }),		-- spell_magic_polymorphrabbit
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
	DummyTest                              = Action.Create({ Type = "Spell", ID = 159999, Hidden = true     }), -- Dummy stop dps icon  
	PoolResource                           = Action.Create({ Type = "Spell", ID = 209274, Hidden = true     }),
};

-- To create essences use next code:
Action:CreateEssencesFor(ACTION_CONST_DRUID_BALANCE)  -- where PLAYERSPEC is Constance (example: ACTION_CONST_MONK_BM)
local A = setmetatable(Action[ACTION_CONST_DRUID_BALANCE], { __index = Action })


------------------------------------------
---------------- VARIABLES ---------------
------------------------------------------
local VarAzSs = 0;
local VarAzAp = 0;
local VarSfTargets = 0;

A.Listener:Add("ROTATION_VARS", "PLAYER_REGEN_ENABLED", function()
  VarAzSs = 0
  VarAzAp = 0
  VarSfTargets = 0
end)



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
	AttackTypes 							= {"TotalImun", "DamageMagicImun"},
	AuraForStun								= {"TotalImun", "DamagePhysImun", "CCTotalImun", "StunImun"},	
	AuraForCC								= {"TotalImun", "DamagePhysImun", "CCTotalImun"},
	AuraForOnlyCCAndStun					= {"CCTotalImun", "StunImun"},
	AuraForDisableMag						= {"TotalImun", "DamageMagicImun", "Freedom", "CCTotalImun"},
	AuraForInterrupt						= {"TotalImun", "DamagePhysImun", "KickImun"},
}

local IsIndoors, UnitIsUnit, UnitName = IsIndoors, UnitIsUnit, UnitName

local function IsSchoolFree()
	return LoC:IsMissed("SILENCE") and LoC:Get("SCHOOL_INTERRUPT", "SHADOW") == 0
end 

local function InRange(unit)
	-- @return boolean 
	return A.SolarWrath:IsInRange(unit)
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

local function FutureAstralPower()
    local AstralPower = Player:AstralPower()
    local castName, castStartTime, castEndTime, notInterruptable, spellID, isChannel = Unit(player):IsCasting()
        
    if not Unit(player):IsCasting() then
        return AstralPower
    else
        if spellID == A.NewMoon.ID then
            return AstralPower + 10
        elseif spellID == A.HalfMoon.ID then
            return AstralPower + 20
        elseif spellID == A.FullMoon.ID then
            return AstralPower + 40
        elseif spellID == A.StellarFlare.ID then
            return AstralPower + 8
        elseif spellID == A.SolarWrath.ID then
            return AstralPower + 8
        elseif spellID == A.LunarStrike.ID then
            return AstralPower + 12
        else
            return AstralPower
        end
    end
end

-- Return current CelestialAlignment or Incarnation
local function CaInc()
    return A.Incarnation:IsSpellLearned() and A.Incarnation or A.CelestialAlignment
end

-- Return current CelestialAlignment or Incarnation (with ID to work with buff checks)
local function CaIncID()
    return A.Incarnation:IsSpellLearned() and A.Incarnation.ID or A.CelestialAlignment.ID
end

local function AP_Check(spell)
  local APGen = 0
  local CurAP = Player:AstralPower()
  if spell == A.Sunfire or spell == A.Moonfire then 
    APGen = 3
  elseif spell == A.StellarFlare or spell == A.SolarWrath then
    APGen = 8
  elseif spell == A.Incarnation or spell == A.CelestialAlignment then
    APGen = 40
  elseif spell == A.ForceofNature then
    APGen = 20
  elseif spell == A.LunarStrike then
    APGen = 12
  end
  
  if A.ShootingStars:IsSpellLearned() then 
    APGen = APGen + 4
  end
  if A.NaturesBalance:IsSpellLearned() then
    APGen = APGen + 2
  end
  
  if CurAP + APGen < Player:AstralPowerMax() then
    return true
  else
    return false
  end
end

local function HandleMultidots()
    local choice = Action.GetToggle(2, "AutoDotSelection")
       
    if choice == "In Raid" then
		if IsInRaid() then
    		return true
		else
		    return false
		end
    elseif choice == "In Dungeon" then 
		if Player:InDungeon() then
    		return true
		else
		    return false
		end
	elseif choice == "In PvP" then 	
		if Player:InPvP() then 
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

local function IsSchoolNatureUP()
	return LoC:IsMissed("SILENCE") and LoC:Get("SCHOOL_INTERRUPT", "NATURE") == 0
end 

local function IsSchoolArcaneUP()
	return LoC:IsMissed("SILENCE") and LoC:Get("SCHOOL_INTERRUPT", "ARCANE") == 0
end 

local function EvaluateCycleCyclotronicBlast105(unit)
    return (Unit(unit):HasDeBuffs(A.MoonfireDebuff.ID, true) and Unit(unit):HasDeBuffs(A.SunfireDebuff.ID, true) and (not A.StellarFlare:IsSpellLearned() or Unit(unit):HasDeBuffs(A.StellarFlareDebuff.ID, true))) and (Unit(player):HasBuffs(CaIncID, true) == 0)
end

local function EvaluateCycleShiverVenomRelic122(unit)
    return (Unit(unit):HasDeBuffsStacks(A.ShiverVenomDebuff.ID, true) >= 5) and (Unit(player):HasBuffs(CaIncID, true) == 0 and not Unit(player):HasHeroism())
end

local function SelfDefensives()
	-- Renewal
	local Renewal = A.GetToggle(2, "RenewalHP")
    if A.Renewal:IsReady(player) and Unit(player):HealthPercent() <= Renewal then
        return A.Renewal:Show(icon)
    end			
	
    -- Barkskin	
	local Barkskin = A.GetToggle(2, "BarkskinHP")	
	if A.Barkskin:IsReady(player) and Unit(player):HealthPercent() <= Barkskin and Unit(player):CombatTime() > 0 then
		return A.Barkskin
	end
	
	-- Swiftmend
	local Swiftmend = A.GetToggle(2, "SwiftmendHP")	
	if A.Swiftmend:IsReady(player) and  Unit(player):HealthPercent() <= Swiftmend then
		return A.Swiftmend
	end
	
	-- HealingPotion
	local PotHeal = A.GetToggle(2, "AbyssalPot")
	if A.AbyssalHealingPotion:IsReady(player) and  Unit(player):HealthPercent() <= PotHeal and Unit(player):CombatTime() > 0 then
		return A.AbyssalHealingPotion
	end
	
end
SelfDefensives = A.MakeFunctionCachedStatic(SelfDefensives)

			
-- Non GCD spell check
local function countInterruptGCD(unit)
    if not A.SolarBeam:IsReadyByPassCastGCD(unit) or not A.SolarBeam:AbsentImun(unit, Temp.TotalAndMagKick) then
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
  	    -- SolarBeam
  	    if useKick and A.SolarBeam:IsReady() and A.SolarBeam:IsSpellLearned() then 
		    -- Notification					
            Action.SendNotification("Solar Beam on: " .. UnitName(unit), A.SolarBeam.ID) 
            return A.SolarBeam
        end         

        if useCC and A.MightyBash:IsReady(unit) and A.MightyBash:IsSpellLearned() and A.MightyBash:AbsentImun(unit, Temp.TotalAndPhysKick, true) then 
            -- Notification                    
            Action.SendNotification("Mighty Bash interrupting on " .. unit, A.MightyBash.ID)
            return A.MightyBash
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

local function IsInHumanForm()
    return Player:GetStance() == 0
end

local function IsInBearForm()
    return Player:GetStance() == 1
end

local function IsInCatForm()
    return Player:GetStance() == 2
end

local function IsInTravelForm()
    return Player:GetStance() == 3
end

local function IsInMoonkinForm()
    return Player:GetStance() == 4
end

--- ======= ACTION LISTS =======
-- [3] Single Rotation
A[3] = function(icon, isMulti)
    --------------------
    --- ROTATION VAR ---
    --------------------
    local isMoving = A.Player:IsMoving()
    local inCombat = Unit(player):CombatTime() > 0
    local ShouldStop = Action.ShouldStop()
    local Pull = Action.BossMods:GetPullTimer()
    local CaIncID = CaIncID()
	local CaInc = CaInc()
	local MultiDot = A.GetToggle(2, "MultiDot")
	local MultiDotDistance = A.GetToggle(2, "MultiDotDistance")	
    local MoonfireToRefresh = MultiUnits:GetByRangeDoTsToRefresh(MultiDotDistance, 2, A.Moonfire.ID, 5)
    local SunfireToRefresh = MultiUnits:GetByRangeDoTsToRefresh(MultiDotDistance, 2, A.Sunfire.ID, 5)
	local MissingSunfire = MultiUnits:GetByRangeMissedDoTs(MultiDotDistance, 5, A.Sunfire.ID, 3)
	local MissingMoonfire = MultiUnits:GetByRangeMissedDoTs(MultiDotDistance, 5, A.Moonfire.ID, 3)
    local StellarFlareRefresh = A.GetToggle(2, "StellarFlareRefresh")
	local MoonfireRefresh = A.GetToggle(2, "MoonfireRefresh") 
	local SunfireRefresh = A.GetToggle(2, "SunfireRefresh")
    local DBM = Action.GetToggle(1, "BossMods")
    local HeartOfAzeroth = Action.GetToggle(1, "HeartOfAzeroth")
    local Racial = Action.GetToggle(1, "Racial")
    local Potion = Action.GetToggle(1, "Potion")     
    local BloodoftheEnemySyncAoE = Action.GetToggle(2, "BloodoftheEnemySyncAoE")
    local BloodoftheEnemyAoETTD = Action.GetToggle(2, "BloodoftheEnemyAoETTD")
    local BloodoftheEnemyUnits = Action.GetToggle(2, "BloodoftheEnemyUnits")
    local FocusedAzeriteBeamTTD = GetToggle(2, "FocusedAzeriteBeamTTD")
    local FocusedAzeriteBeamUnits = GetToggle(2, "FocusedAzeriteBeamUnits")
    local UnbridledFuryAuto = GetToggle(2, "UnbridledFuryAuto")
    local UnbridledFuryTTD = GetToggle(2, "UnbridledFuryTTD")
    local UnbridledFuryWithBloodlust = GetToggle(2, "UnbridledFuryWithBloodlust")
    local UnbridledFuryHP = GetToggle(2, "UnbridledFuryHP")
    local UnbridledFuryWithExecute = GetToggle(2, "UnbridledFuryWithExecute")
    -- Trinkets vars
    local Trinket1IsAllowed, Trinket2IsAllowed = TR:TrinketIsAllowed()
    local TrinketsAoE = GetToggle(2, "TrinketsAoE")
	--local TrinketASAP = GetToggle(2, "TrinketASAP")
    local TrinketsMinTTD = GetToggle(2, "TrinketsMinTTD")
    local TrinketsUnitsRange = GetToggle(2, "TrinketsUnitsRange")
    local TrinketsMinUnits = GetToggle(2, "TrinketsMinUnits")    
    -- Azerite beam protection channel
    local CanCast = true
    local TotalCast, CurrentCastLeft, CurrentCastDone = Unit(player):CastTime()
    local _, castStartedTime, castEndTime = Unit(player):IsCasting()
    local secondsLeft, percentLeft, spellID, spellName, notInterruptable, isChannel = Unit(player):IsCastingRemains()
    -- Ensure all channel and cast are really safe
    -- Double protection with check on current casts and also timestamp of the cast
    if (spellID == A.FocusedAzeriteBeam.ID) then 
        if (CurrentCastLeft > 0 or secondsLeft > 0 or isChannel) then
            if TMW.time < castEndTime then            
                CanCast = false
            else
                CanCast = true
            end
        end
    end
    -- Showing icon PoolResource to make sure nothing else is read by GG
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
            -- use_item,name=azsharas_font_of_power
            if A.AzsharasFontofPower:IsReady(player) and not inCombat then
                return A.AzsharasFontofPower:Show(icon)
            end
            -- potion,dynamic_prepot=1
            if A.PotionofUnbridledFury:IsReady(unit) and not inCombat and Action.GetToggle(1, "Potion") 
			and ((Pull > 0.1 and Pull <= A.SolarWrath:GetSpellCastTime() + A.GetGCD()) or not Action.GetToggle(1, "BossMods"))
			then
                return A.PotionofUnbridledFury:Show(icon)
            end
            -- solar_wrath
            if A.SolarWrath:IsReady(unit) and not inCombat and Unit(unit):IsExists() and unit ~= "mouseover" and not Unit(unit):IsTotem() 
            and ((Pull > 0.1 and Pull <= A.SolarWrath:GetSpellCastTime()) or not Action.GetToggle(1, "BossMods"))			
			then
                return A.SolarWrath:Show(icon)
            end
            -- solar_wrath
            if A.SolarWrath:IsReady(unit) and not inCombat and Unit(unit):IsExists() and unit ~= "mouseover" and not Unit(unit):IsTotem()
            and ((Pull > 0.1 and Pull <= A.SolarWrath:GetSpellCastTime()) or not Action.GetToggle(1, "BossMods"))
			then
                return A.SolarWrath:Show(icon)
            end
            -- starsurge_with_talent_naturesbalance
            if A.Starsurge:IsReadyByPassCastGCD(unit) and not inCombat and A.NaturesBalance:IsSpellLearned()
			and ((Pull > 0.1 and Pull <= 0.5) or not Action.GetToggle(1, "BossMods"))
			then
                return A.Starsurge:Show(icon)
            end
        end
		
		-- Auto multidot
		local function Multidots(unit)
		    if Unit(unit):HasDeBuffs(A.Sunfire.ID, true) > 0 and MultiUnits:GetActiveEnemies() <= A.GetToggle(2, "MultiDotMaxUnits") and Unit(unit):HasDeBuffs(A.Moonfire.ID, true) > 0 and A.GetToggle(2, "AoE") and
		    (
			    (MissingSunfire >= 1 )
				or 
				(MissingMoonfire >= 1 )
			) 
			then
			    return A:Show(icon, ACTION_CONST_AUTOTARGET)
		    end		
		end
        
		-- Pandemic
		local function Pandemic(unit)
		    --sunfire
		    if A.Sunfire:IsReady(unit) then
			    if Unit(unit):HasDeBuffs(A.Sunfire.ID, true) <= SunfireRefresh and A.LastPlayerCastID ~= A.Sunfire.ID and A.Sunfire:AbsentImun(unit, Temp.TotalAndPhys) and Player:IsStance(4) and AP_Check(A.Sunfire)
				and (
				        VarAzSs == 0 or
				        (
				            Unit(player):HasBuffs(CaIncID, true) == 0 
				        ) 
				        or A.LastPlayerCastID ~= A.Sunfire.ID
					) 					
				and (
				        (Unit(player):HasBuffs(CaIncID, true) >= 7) or
		                (Unit(player):HasBuffs(CaIncID, true) == 0)
		            )
		        or  (
				        Unit(player):HasBuffsStacks(A.ArcanicPulsarBuff.ID, true) >= 7 and Unit(unit):HasDeBuffs(A.SunfireDebuff.ID, true) <= 10
					) 
				then
				    return A.Sunfire:Show(icon)
                end	
			end
			
		    --moonfire
		    if A.Moonfire:IsReady(unit) then
			    if Unit(unit):HasDeBuffs(A.Moonfire.ID, true) <= MoonfireRefresh and A.LastPlayerCastID ~= A.Moonfire.ID and A.Moonfire:AbsentImun(unit, Temp.TotalAndPhys) and Player:IsStance(4) and AP_Check(A.Moonfire)
				and (
				        VarAzSs == 0 or
				        (
				            Unit(player):HasBuffs(CaIncID, true) == 0 
				        ) 
				        or A.LastPlayerCastID ~= A.Moonfire.ID
					) 					
				and (
				        (Unit(player):HasBuffs(CaIncID, true) >= 7) or
		                (Unit(player):HasBuffs(CaIncID, true) == 0)
		            )
		        or  (
				        Unit(player):HasBuffsStacks(A.ArcanicPulsarBuff.ID, true) >= 7 and Unit(unit):HasDeBuffs(A.Moonfire.ID, true) <= 10
					) 
				then
				    return A.Moonfire:Show(icon)
                end	
			end
			
		    --stellar_flare
		    if A.StellarFlare:IsReady(unit) then
			    if Unit(unit):HasDeBuffs(A.StellarFlare.ID, true) <= StellarFlareRefresh and A.LastPlayerCastID ~= A.StellarFlare.ID and A.StellarFlare:AbsentImun(unit, Temp.TotalAndPhys) and Player:IsStance(4) and AP_Check(A.StellarFlare)
				and (
				        VarAzSs == 0 or
				        (
				            Unit(player):HasBuffs(CaIncID, true) == 0 
				        ) 
				        or A.LastPlayerCastID ~= A.StellarFlare.ID
					) 					
				and (
				        (Unit(player):HasBuffs(CaIncID, true) >= 7) or
		                (Unit(player):HasBuffs(CaIncID, true) == 0)
		            )
		        or  (
				        Unit(player):HasBuffsStacks(A.ArcanicPulsarBuff.ID, true) >= 7 and Unit(unit):HasDeBuffs(A.StellarFlare.ID, true) <= 10
					) 
				then
				    return A.StellarFlare:Show(icon)
                end	
			end

		end
		
		-- Burst
        local function Burst(unit)	
            
            -- Non SIMC Custom Trinket1
            if A.Trinket1:IsReady(unit) and Trinket1IsAllowed and    
            (
                (TrinketsAoE and GetByRange(TrinketsMinUnits, TrinketsUnitsRange) and Player:AreaTTD(TrinketsUnitsRange) > TrinketsMinTTD)
                or
                (not TrinketsAoE and Unit(unit):TimeToDie() >= TrinketsMinTTD) 		
            )
            then 
                  return A.Trinket1:Show(icon)
            end         
            
        
            -- Non SIMC Custom Trinket2
            if A.Trinket2:IsReady(unit) and Trinket2IsAllowed and        
            (
                (TrinketsAoE and GetByRange(TrinketsMinUnits, TrinketsUnitsRange) and Player:AreaTTD(TrinketsUnitsRange) > TrinketsMinTTD)
                or
                (not TrinketsAoE and Unit(unit):TimeToDie() >= TrinketsMinTTD)        			
            )
            then
                return A.Trinket2:Show(icon)     
            end  
			
			-- Berserking
			if A.Berserking:AutoRacial(unit) and (Unit(player):HasBuffs(A.CelestialAlignmentBuff.ID, true) > 0 or 
			A.Incarnation:IsSpellLearned() and Unit(player):HasBuffs(A.IncarnationBuff.ID, true) > 0) then
				return A.Berserking:Show(icon)
			end			
			
            -- Celestial Alignment & Incarnation
			if CaInc:IsReady(player) and (Unit(unit):HasDeBuffs(A.StellarFlareDebuff.ID, true) > 6 or not A.StellarFlare:IsSpellLearned()) and (Unit(player):HasBuffs(A.MemoryofLucidDreams.ID, true) > 0 
			or AP_Check(CaInc)) and Unit(player):HasBuffs(CaIncID, true) == 0 and Unit(unit):HasDeBuffs(A.SunfireDebuff.ID, true) > 5 and Unit(unit):HasDeBuffs(A.MoonfireDebuff.ID, true) > 6 
			then
	            if (not A.Starlord:IsSpellLearned() or Unit(player):HasBuffs(A.StarlordBuff.ID, true) > 0) 
				    and (Unit(player):HasBuffs(CaIncID, true) == 0 and (Unit(player):HasBuffs(A.MemoryofLucidDreams.ID, true) 
				    or ((A.MemoryofLucidDreams:GetCooldown() > 20 or not bool(A.MemoryofLucidDreams:IsSpellLearned())) and AP_Check(CaInc))) 
				    and (Unit(player):HasBuffs(A.MemoryofLucidDreams.ID, true) > 0 or AP_Check(CaInc))) 
				then
                    -- Notification					
                    Action.SendNotification("Activated burst phase", CaIncID)
			    	return CaInc:Show(icon)
				end				                
            end

			-- Pocketsized Computation Device
			if A.PocketsizedComputationDevice:IsReady(unit) and A.PocketsizedComputationDevice:AbsentImun(unit, "DamageMagicImun") and TrinketON and 
			((Unit(player):HasBuffs(A.CelestialAlignmentBuff.ID, true) == 0 or A.Incarnation:IsSpellLearned() and Unit(player):HasBuffs(A.IncarnationBuff.ID, true) == 0) and 
			Unit(unit):HasDeBuffs(A.Moonfire.ID, true) > 6 and Unit(unit):HasDeBuffs(A.Sunfire.ID, true) > 5 and
			(not A.StellarFlare:IsSpellLearned() or Unit(unit):HasDeBuffs(A.StellarFlare.ID, true) > 0)) 
			then
				return A.PocketsizedComputationDevice:Show(icon)
			end
		end
        
        -- call precombat
        if Precombat(unit) and not inCombat and Unit(unit):IsExists() and unit ~= "mouseover" then 
            return true
        end

        -- In Combat
        if inCombat and Unit(unit):IsExists() and IsInMoonkinForm() then
		    
			-- Rotation Vars
			-- variable,name=az_ss,value=azerite.streaking_stars.rank
            local VarAzSs = A.StreakingStars:GetAzeriteRank()				
            -- variable,name=az_ap,value=azerite.arcanic_pulsar.rank
            local VarAzAp = A.ArcanicPulsar:GetAzeriteRank()				
            -- variable,name=sf_targets,value=4
            local VarSfTargets = 4				
            -- variable,name=sf_targets,op=add,value=1,if=azerite.arcanic_pulsar.enabled
            if (A.ArcanicPulsar:GetAzeriteRank() > 0) then
                VarSfTargets = VarSfTargets + 1
            end			
            -- variable,name=sf_targets,op=add,value=1,if=talent.starlord.enabled
            if (A.Starlord:IsSpellLearned()) then
                VarSfTargets = VarSfTargets + 1
            end			
            -- variable,name=sf_targets,op=add,value=1,if=azerite.streaking_stars.rank>2&azerite.arcanic_pulsar.enabled
            if (A.StreakingStars:GetAzeriteRank() > 2 and A.ArcanicPulsar:GetAzeriteRank() > 0) then
                VarSfTargets = VarSfTargets + 1
            end			
            -- variable,name=sf_targets,op=sub,value=1,if=!talent.twin_moons.enabled
            if (not A.TwinMoons:IsSpellLearned()) then
                VarSfTargets = VarSfTargets - 1
            end
			
		    -- Interrupt Handler 	 	
  		    local unit = "target"   
            local Trinket1IsAllowed, Trinket2IsAllowed = TR.TrinketIsAllowed()
	        local castLeft, _, spellID, _, notKickAble = Unit(unit):IsCastingRemains()
		
		    -- Interrupt
   	        local Interrupt = Interrupts(unit)
  	        if Interrupt and inCombat then 
  	            return Interrupt:Show(icon)
  	        end			
			
			-- Soothe
			if unit ~= "targettarget" and A.Soothe:IsReady(unit, nil, nil, true) 
			and A.Soothe:AbsentImun(unit, Temp.AuraForOnlyCCAndStun) and A.AuraIsValid(unit, "UseExpelEnrage", "Enrage") 
			then 
			    -- Notification					
                Action.SendNotification("Soothe on: " .. UnitName(unit), A.Soothe.ID) 					
                return A.Soothe:Show(icon)
            end         
		
			-- Auto multidots
            if (isMulti or A.GetToggle(2, "AoE")) and HandleMultidots() then 
                if Multidots(unit) then 
				    return true
				end
			end		

			-- Burst
			if unit ~= "mouseover" and A.BurstIsON(unit) then
                if Burst(unit) then 
				    return true
				end
			end	

		    -- Starlord CancelBuff
		    if A.Starlord:IsSpellLearned() and Unit(player):HasBuffs(A.StarlordBuff.ID, true) <= 5 and Unit(player):HasBuffs(A.StarlordBuff.ID, true) > 0 and FutureAstralPower() >= 80 
			then
			    Player:CancelBuff(A.StarlordBuff:Info())
		    end
			
		    -- Spenders
			
			-- starfall
		    if A.Starfall:IsReady(unit, true) and IsSchoolArcaneUP() and A.Starfall:AbsentImun(unit, Temp.TotalAndPhys) and 
		    (
			    (
				    Unit(player):HasBuffsStacks(A.StarlordBuff.ID, true) < 3 
					or 
					Unit(player):HasBuffs(A.StarlordBuff.ID, true) >= 8
				)
				and (A.GetToggle(2, "AoE") and MultiUnits:GetActiveEnemies() >= VarSfTargets) and (Unit(unit):TimeToDie() + 1) * MultiUnits:GetActiveEnemies() > A.Starfall:GetSpellPowerCost() / 2.5
			)  
			then
			    return A.Starfall:Show(icon)
		    end
			
		    -- starsurge
		    if A.Starsurge:IsReadyByPassCastGCD(unit) and IsSchoolArcaneUP() and A.Starsurge:AbsentImun(unit, Temp.TotalAndPhys) and Player:IsStance(4) and
		    (
			    (
				    A.Starlord:IsSpellLearned() and 
					(
					    Unit(player):HasBuffsStacks(A.StarlordBuff.ID, true) < 3
						or 
						Unit(player):HasBuffs(A.StarlordBuff.ID, true) >= 5
					)
					or not A.Starlord:IsSpellLearned() and 
					(
					    Unit(player):HasBuffsStacks(A.ArcanicPulsarBuff.ID, true) < 8 
						or 
						(
						    Unit(player):HasBuffs(A.CelestialAlignmentBuff.ID, true) > 0 
							or 
		                    A.Incarnation:IsSpellLearned() and Unit(player):HasBuffs(A.IncarnationBuff.ID, true) > 0
						)
					)
				)
				and	
				(
				    A.GetToggle(2, "AoE") and MultiUnits:GetActiveEnemies() < VarSfTargets 
					or 
					not A.GetToggle(2, "AoE")
				)
				and Unit(player):HasBuffsStacks(A.LunarEmpowermentBuff.ID, true) + Unit(player):HasBuffsStacks(A.SolarEmpowermentBuff.ID, true) < 4 
				and Unit(player):HasBuffsStacks(A.SolarEmpowermentBuff.ID, true) < 3 and Unit(player):HasBuffsStacks(A.LunarEmpowermentBuff.ID, true) < 3 and 
				(
				    VarAzSs == 0 
					or 
		            (
				       Unit(player):HasBuffs(A.CelestialAlignmentBuff.ID, true) == 0 
					   or 
					   A.Incarnation:IsSpellLearned() and Unit(player):HasBuffs(A.IncarnationBuff.ID, true) == 0
					) 
					or 
					A.LastPlayerCastID ~= A.Starsurge.ID
				)
				or Unit(unit):TimeToDie() <= A.Starsurge:GetSpellCastTime() * FutureAstralPower() / 40 
				or not AP_Check(A.SolarWrath)
				or isMoving
			) 			 
			then
			    return A.Starsurge:Show(icon)
		    end			
							
			-- Pandemic
			if true then
                if Pandemic(unit) then 
				    return true
				end
			end

		    --Move
		    if A.Sunfire:IsReady(unit) and isMoving and Player:IsStance(4) and Unit(unit):HasDeBuffs(A.Sunfire.ID, true) < 2 and
		    (
			    VarAzSs == 0 
				or 
				(Unit(player):HasBuffs(CaIncID, true) == 0) 
				or 
		        A.LastPlayerCastID ~= A.Sunfire.ID
			)
			then
			    return A.Sunfire:Show(icon)
		    end
		
		    if A.Moonfire:IsReady(unit) and isMoving and Player:IsStance(4) and Unit(unit):HasDeBuffs(A.Moonfire.ID, true) < 2 and
		    (
			    VarAzSs == 0 
				or 
				(Unit(player):HasBuffs(CaIncID, true) == 0) 
				or 
		        A.LastPlayerCastID ~= A.Moonfire.ID
			)
			then
			    return A.Moonfire:Show(icon)
		    end

            -- potion
            if A.PotionofUnbridledFury:IsReady(unit) and Action.GetToggle(1, "Potion") and UnbridledFuryAuto
			and 
			(
				(UnbridledFuryWithBloodlust and Unit(player):HasHeroism())
				or
				(UnbridledFuryWithExecute and Unit(unit):HealthPercent() <= 30)
				or
				(
			        Unit(player):HasBuffs(A.CelestialAlignmentBuff.ID, true) > 13 
				    or 
   				    Unit(player):HasBuffs(A.IncarnationBuff.ID, true) > 16.5

				)
			) and Unit(unit):TimeToDie() > UnbridledFuryTTD
			then
 	            -- Notification					
                Action.SendNotification("Burst: Potion of Unbridled Fury", A.PotionofUnbridledFury.ID)	
                return A.PotionofUnbridledFury:Show(icon)
            end
			
            -- potion,if=buff.celestial_alignment.remains>13|buff.incarnation.remains>16.5
            if A.PotionofUnbridledFury:IsReady(unit) and Action.GetToggle(1, "Potion") and (Unit(player):HasBuffs(A.CelestialAlignmentBuff.ID, true) > 13 or Unit(player):HasBuffs(A.IncarnationBuff.ID, true) > 16.5) then
                return A.PotionofUnbridledFury:Show(icon)
            end
			
            -- berserking,if=buff.ca_inc.up
            if A.Berserking:AutoRacial(unit) and Action.GetToggle(1, "Racial") and A.BurstIsON(unit) and (Unit(player):HasBuffs(CaIncID, true)) then
                return A.Berserking:Show(icon)
            end
			
            -- use_item,name=azsharas_font_of_power,if=!buff.ca_inc.up,target_if=dot.moonfire.ticking&dot.sunfire.ticking&(!talent.stellar_flare.enabled|dot.stellar_flare.ticking)
            if A.AzsharasFontofPower:IsReady(player) then
                if (Unit(unit):HasDeBuffs(A.MoonfireDebuff.ID, true) and Unit(unit):HasDeBuffs(A.SunfireDebuff.ID, true) and (not A.StellarFlare:IsSpellLearned() or Unit(unit):HasDeBuffs(A.StellarFlareDebuff.ID, true))) then
    				if (Unit(player):HasBuffs(CaIncID, true) == 0) then
                        return A.AzsharasFontofPower:Show(icon) 
					end
                end
            end
			
            -- guardian_of_azeroth,if=(!talent.starlord.enabled|buff.starlord.up)&!buff.ca_inc.up,target_if=dot.moonfire.ticking&dot.sunfire.ticking&(!talent.stellar_flare.enabled|dot.stellar_flare.ticking)
            if A.GuardianofAzeroth:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") then
                if (Unit(unit):HasDeBuffs(A.MoonfireDebuff.ID, true) and Unit(unit):HasDeBuffs(A.SunfireDebuff.ID, true) and (not A.StellarFlare:IsSpellLearned() or Unit(unit):HasDeBuffs(A.StellarFlareDebuff.ID, true))) then
				    if ((not A.Starlord:IsSpellLearned() or Unit(player):HasBuffs(A.StarlordBuff.ID, true)) and Unit(player):HasBuffs(CaIncID, true) == 0) then
                        return A.GuardianofAzeroth:Show(icon) 
					end
                end
            end
			
            -- use_item,effect_name=cyclotronic_blast,if=!buff.ca_inc.up,target_if=dot.moonfire.ticking&dot.sunfire.ticking&(!talent.stellar_flare.enabled|dot.stellar_flare.ticking)
            if A.CyclotronicBlast:IsReady(unit) then
                if (Unit(unit):HasDeBuffs(A.MoonfireDebuff.ID, true) and Unit(unit):HasDeBuffs(A.SunfireDebuff.ID, true) and (not A.StellarFlare:IsSpellLearned() or Unit(unit):HasDeBuffs(A.StellarFlareDebuff.ID, true))) then
				    if (Unit(player):HasBuffs(CaIncID, true) == 0) then
                        return A.CyclotronicBlast:Show(icon) 
					end
                end
            end
			
            -- use_item,name=shiver_venom_relic,if=!buff.ca_inc.up&!buff.bloodlust.up,target_if=dot.shiver_venom.stack>=5
            if A.ShiverVenomRelic:IsReady(unit) and A.ShiverVenomRelic:AbsentImun(unit, Temp.TotalAndMag) then
                if (Unit(unit):HasDeBuffsStacks(A.ShiverVenomDebuff.ID, true) >= 5 
				or Unit(unit):TimeToDie() <= 5 and MultiUnits:GetActiveEnemies() >= 3 and Unit(unit):HasDeBuffsStacks(A.ShiverVenomDebuff.ID, true) >= 3) 
				and Unit(player):HasBuffs(CaIncID, true) == 0 then
                    return A.ShiverVenomRelic:Show(icon) 
                end
            end
				
	 		-- Non SIMC Custom Trinket1
	        if Action.GetToggle(1, "Trinkets")[1] and A.Trinket1:IsReady(unit) and Trinket1IsAllowed then	    
       	        if A.Trinket1:AbsentImun(unit, "DamageMagicImun")  then 
      	   	        return A.Trinket1:Show(icon)
   	            end 		
	        end	
			
		    -- Non SIMC Custom Trinket2
	        if Action.GetToggle(1, "Trinkets")[2] and A.Trinket2:IsReady(unit) and Trinket2IsAllowed then	    
       	        if A.Trinket2:AbsentImun(unit, "DamageMagicImun")  then 
      	   	        return A.Trinket2:Show(icon)
   	            end 	
	        end	
			
            -- blood_of_the_enemy,if=cooldown.ca_inc.remains>30
            if A.BloodoftheEnemy:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") and (CaInc:GetCooldown() > 30) then
                return A.BloodoftheEnemy:Show(icon)
            end
			
            -- memory_of_lucid_dreams,if=!buff.ca_inc.up&(astral_power<25|cooldown.ca_inc.remains>30),target_if=dot.sunfire.remains>10&dot.moonfire.remains>10&(!talent.stellar_flare.enabled|dot.stellar_flare.remains>10)
            if A.MemoryofLucidDreams:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") then
			    if Unit(unit):HasDeBuffs(A.SunfireDebuff.ID, true) > 10 then
			        if (not A.StellarFlare:IsSpellLearned() or Unit(unit):HasDeBuffs(A.StellarFlareDebuff.ID, true) > 10) and (Unit(player):HasBuffs(CaIncID, true) == 0 and (FutureAstralPower() < 25 or CaInc:GetCooldown() > 30)) then
                        return A.MemoryofLucidDreams:Show(icon) 
					end
                end
            end
			
            -- purifying_blast
            if A.PurifyingBlast:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") then
                return A.PurifyingBlast:Show(icon)
            end
			
            -- ripple_in_space
            if A.RippleinSpace:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") then
                return A.RippleinSpace:Show(icon)
            end
			
            -- concentrated_flame
            if A.ConcentratedFlame:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") then
                return A.ConcentratedFlame:Show(icon)
            end
			
            -- the_unbound_force,if=buff.reckless_force.up,target_if=dot.moonfire.ticking&dot.sunfire.ticking&(!talent.stellar_flare.enabled|dot.stellar_flare.ticking)
            if A.TheUnboundForce:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") then
			    if Unit(unit):HasDeBuffs(A.MoonfireDebuff.ID, true) > 0 then
				    if (not A.StellarFlare:IsSpellLearned() or Unit(unit):HasDeBuffs(A.StellarFlareDebuff.ID, true) > 0) and (Unit(player):HasBuffs(A.RecklessForceBuff.ID, true) > 0) then
                        return A.TheUnboundForce:Show(icon) 
					end
                end
            end
			
            -- worldvein_resonance
            if A.WorldveinResonance:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") then
                return A.WorldveinResonance:Show(icon)
            end

            -- focused_azerite_beam,if=spell_targets.blade_dance1>=2|raid_event.adds.in>60
            if A.FocusedAzeriteBeam:AutoHeartOfAzeroth(unit, true) and Unit(unit):TimeToDie() >= FocusedAzeriteBeamTTD and Unit(unit):HasDeBuffs(A.MoonfireDebuff.ID, true) > 0 and 
			(
			    (
				    VarAzSs == 0 
					or 
					Unit(player):HasBuffs(CaIncID, true) == 0
				)
			)
			and CanCast and UseHeartOfAzeroth and 
			(
			    GetByRange(FocusedAzeriteBeamUnits, 30) 
				or 
				Unit(unit):IsBoss()
			)			
            then
                 -- Notification                    
                Action.SendNotification("Stop moving!! Focused Azerite Beam", A.FocusedAzeriteBeam.ID)                 
                return A.FocusedAzeriteBeam:Show(icon)
            end 
			
            -- thorns
            if A.Thorns:IsReady(unit) then
                return A.Thorns:Show(icon)
            end
			
            -- warrior_of_elune
            if A.WarriorofElune:IsReady(unit) then
                return A.WarriorofElune:Show(icon)
            end
			
			-- fury_of_elune
		    if A.FuryofElune:IsReady(unit) and AP_Check(A.SolarWrath) and ((A.GetToggle(2, "AoE") and MultiUnits:GetActiveEnemies() >= 2) or Unit(unit):IsBoss()) then
			    return A.FuryofElune:Show(icon)
		    end
			
            -- innervate,if=azerite.lively_spirit.enabled&(cooldown.incarnation.remains<2|cooldown.celestial_alignment.remains<12)
            if A.Innervate:IsReady(unit) and (bool(A.LivelySpirit:GetAzeriteRank()) and (A.Incarnation:GetCooldown() < 2 or A.CelestialAlignment:GetCooldown() < 12)) then
                return A.Innervate:Show(icon)
            end
			
            -- force_of_nature,if=(variable.az_ss&!buff.ca_inc.up|!variable.az_ss&(buff.ca_inc.up|cooldown.ca_inc.remains>30))&ap_check
            if A.ForceofNature:IsReady(unit) and 
			(
			    (
				    VarAzSs > 0 and Unit(player):HasBuffs(CaIncID, true) == 0 
					or 
					VarAzSs == 0 and 
					(
					    Unit(player):HasBuffs(CaIncID, true) > 0 
						or 
						CaInc:GetCooldown() > 30
					)
				) 
			    and AP_Check(A.ForceofNature)
			) 
			then
                return A.ForceofNature:Show(icon)
            end	

            -- new_moon,if=ap_check
            if A.NewMoon:IsReady(unit) and AP_Check(A.NewMoon) then
                return A.NewMoon:Show(icon)
            end
			
            -- half_moon,if=ap_check
            if A.HalfMoon:IsReady(unit) and AP_Check(A.HalfMoon) then
                return A.HalfMoon:Show(icon)
            end
			
            -- full_moon,if=ap_check
            if A.FullMoon:IsReady(unit) and AP_Check(A.FullMoon) then
                return A.FullMoon:Show(icon)
            end
			
			
            -- lunar_strike,if=buff.solar_empowerment.stack<3&(ap_check|buff.lunar_empowerment.stack=3)&((buff.warrior_of_elune.up|buff.lunar_empowerment.up|spell_targets>=2&!buff.solar_empowerment.up)&(!variable.az_ss|!buff.ca_inc.up)|variable.az_ss&buff.ca_inc.up&prev.solar_wrath)
            if A.LunarStrike:IsReady(unit) and IsSchoolArcaneUP() and A.LunarStrike:AbsentImun(unit, Temp.TotalAndPhys) and 
			(
			    Unit(player):HasBuffsStacks(A.SolarEmpowermentBuff.ID, true) < 2 
			    and (AP_Check(A.LunarStrike) or Unit(player):HasBuffsStacks(A.LunarEmpowermentBuff.ID, true) == 3) and 
				(
			        (
					    Unit(player):HasBuffs(A.WarriorofEluneBuff.ID, true) > 0 
						or 
						Unit(player):HasBuffs(A.LunarEmpowermentBuff.ID, true) > 0
						or 
						MultiUnits:GetActiveEnemies() >= 2 and Unit(player):HasBuffs(A.SolarEmpowermentBuff.ID, true) == 0
					) 
					and 
					(
					    VarAzSs == 0 
						or 
						Unit(player):HasBuffs(CaIncID, true) == 0
					) 
					or 
					VarAzSs > 0 and Unit(player):HasBuffs(CaIncID, true) > 0 and A.LastPlayerCastID == A.SolarWrath.ID
				)
			) 
			then
                return A.LunarStrike:Show(icon)
            end
			
            -- solar_wrath,if=variable.az_ss<3|!buff.ca_inc.up|!prev.solar_wrath
            if A.SolarWrath:IsReady(unit) and A.SolarWrath:AbsentImun(unit, Temp.TotalAndPhys) and 
			    (
				    VarAzSs < 3 
					or 
					Unit(player):HasBuffs(CaIncID, true) == 0 
					or 
					A.LastPlayerCastID ~= A.SolarWrath.ID
				) 
			then
                return A.SolarWrath:Show(icon)
            end			
	
        end
    end

    -- End on EnemyRotation()
	
	-- Friendly Rotation mouseover
	local function FriendlyRotation(unit)
        -- Purge
        if A.ArcaneTorrent:IsRacialReady(unit) then 
            return A.ArcaneTorrent:Show(icon)
        end    
        
        -- Out of combat        
       -- if Unit(player):CombatTime() == 0 and A.Resurrection:IsReady(unit) and Unit(unit):IsDead() and Unit(unit):IsPlayer() and not isMoving and IsSchoolHolyUP() then 
        --    return A.Resurrection:Show(icon)
       -- end 
        
        -- Supportive
        if A.RemoveCorruption:IsReady(unit) and A.RemoveCorruption:AbsentImun(unit) and A.AuraIsValid(unit, "UseDispel", "Dispel") then 
            return A.RemoveCorruption:Show(icon)
        end 
    end
		
    -- moonkin_form
    if A.MoonkinForm:IsReady(player) and not IsInMoonkinForm() and A.GetToggle(2, "AutoMoonkinForm") then
        return A.MoonkinForm:Show(icon)
    end
	
    -- Defensive
    local SelfDefensive = SelfDefensives()
    if SelfDefensive then 
        return SelfDefensive:Show(icon)
    end 
    
    -- Mouseover     
    if A.IsUnitFriendly("mouseover") then 
        unit = "mouseover"    
        
        if FriendlyRotation(unit) then 
            return true 
        end             
    end 

    -- Mouseover
    if A.IsUnitEnemy("mouseover") then
        unit = "mouseover"
		
        if EnemyRotation(unit) then 
            return true 
        end 
    end 
	
	-- Mouseover     
    if A.IsUnitFriendly("mouseover") then 
        unit = "mouseover"    
        
        if FriendlyRotation(unit) then 
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
    Unit(player):GetDR("incapacitate") >= 50 
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
			
            -- Root enemy moving out
            if A.EntanglingRoots:IsReady() and EnemyTeam():IsMovingOut() then 
                return A.EntanglingRoots:Show(icon)
            end 
			
            -- Cyclone enemy healer moving out
            if A.Cyclone:IsReady() and A.Cyclone:IsSpellLearned() and A.EnemyTeam("HEALER"):IsMovingOut() then 
                return A.Cyclone:Show(icon)
            end 
        end
    end 
end 

local function PartyRotation(unit)
    --if (unit == "party1" and not A.GetToggle(2, "PartyUnits")[1]) or (unit == "party2" and not A.GetToggle(2, "PartyUnits")[2]) then 
    --    return false 
    --end

    -- Purge
    if A.ArcaneTorrent:IsRacialReady(unit) then 
        return A.ArcaneTorrent:Show(icon)
    end    
        
    -- Out of combat        
    -- if Unit(player):CombatTime() == 0 and A.Resurrection:IsReady(unit) and Unit(unit):IsDead() and Unit(unit):IsPlayer() and not isMoving and IsSchoolHolyUP() then 
    --    return A.Resurrection:Show(icon)
    -- end 
        
    -- Supportive
    if A.RemoveCorruption:IsReady(unit) and A.RemoveCorruption:AbsentImun(unit) and A.AuraIsValid(unit, "UseDispel", "Dispel") then 
        return A.RemoveCorruption:Show(icon)
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

