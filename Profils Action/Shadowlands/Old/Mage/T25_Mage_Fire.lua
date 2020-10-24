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

--- ============================ CONTENT ===========================
--- ======= APL LOCALS =======
-- luacheck: max_line_length 9999

-- Spells
Action[ACTION_CONST_MAGE_FIRE] = {
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
    -- Generics
    ArcaneIntellectBuff                    = Action.Create({ Type = "Spell", ID = 1459, Hidden = true }),
    ArcaneIntellect                        = Action.Create({ Type = "Spell", ID = 1459 }),
    MirrorImage                            = Action.Create({ Type = "Spell", ID = 55342 }),
    Pyroblast                              = Action.Create({ Type = "Spell", ID = 11366 }),
    LivingBomb                             = Action.Create({ Type = "Spell", ID = 44457 }),
    CombustionBuff                         = Action.Create({ Type = "Spell", ID = 190319, Hidden = true }),
    Meteor                                 = Action.Create({ Type = "Spell", ID = 153561 }),
    RuneofPowerBuff                        = Action.Create({ Type = "Spell", ID = 116014, Hidden = true }),
    RuneofPower                            = Action.Create({ Type = "Spell", ID = 116011 }),
    Firestarter                            = Action.Create({ Type = "Spell", ID = 205026 }),
    LightsJudgment                         = Action.Create({ Type = "Spell", ID = 255647 }),
    BagofTricks                            = Action.Create({ Type = "Spell", ID = 312411    }),
    FireBlast                              = Action.Create({ Type = "Spell", ID = 108853 }),
    BlasterMasterBuff                      = Action.Create({ Type = "Spell", ID = 274598, Hidden = true }),
    BlasterMaster                          = Action.Create({ Type = "Spell", ID = 274596 }),
    FlameOn                                = Action.Create({ Type = "Spell", ID = 205029 }),
    HyperthreadWristwraps                  = Action.Create({ Type = "Spell", ID = 300142 }),
    Scorch                                 = Action.Create({ Type = "Spell", ID = 2948 }),
    HeatingUpBuff                          = Action.Create({ Type = "Spell", ID = 48107, Hidden = true }),
    HotStreakBuff                          = Action.Create({ Type = "Spell", ID = 48108, Hidden = true }),
    Fireball                               = Action.Create({ Type = "Spell", ID = 133 }),
    Combustion                             = Action.Create({ Type = "Spell", ID = 190319 }),
    BloodFury                              = Action.Create({ Type = "Spell", ID = 20572 }),
    Berserking                             = Action.Create({ Type = "Spell", ID = 26297 }),
    Fireblood                              = Action.Create({ Type = "Spell", ID = 265221 }),
    AncestralCall                          = Action.Create({ Type = "Spell", ID = 274738 }),
    Flamestrike                            = Action.Create({ Type = "Spell", ID = 2120 }),
    FlamePatch                             = Action.Create({ Type = "Spell", ID = 205037 }),
    PyroclasmBuff                          = Action.Create({ Type = "Spell", ID = 269651, Hidden = true }),
    PhoenixFlames                          = Action.Create({ Type = "Spell", ID = 257541 }),
    DragonsBreath                          = Action.Create({ Type = "Spell", ID = 31661 }),
    SearingTouch                           = Action.Create({ Type = "Spell", ID = 269644 }),
    --ManifestoofMadnessChapterOneBuff       = Action.Create({ Type = "Spell", ID =  }),
	Shimmer                                = Action.Create({ Type = "Spell", ID = 212653     }),
	Blink                                  = Action.Create({ Type = "Spell", ID = 1953     }),
    AlexstraszasFury                       = Action.Create({ Type = "Spell", ID = 235870 }),
    Kindling                               = Action.Create({ Type = "Spell", ID = 155148 }),
	CounterSpell                           = Action.Create({ Type = "Spell", ID = 2139     }),
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
    AzurethosSingedPlumage                 = Action.Create({ Type = "Trinket", ID = 161377 }),
    AncientKnotofWisdomAlliance            = Action.Create({ Type = "Trinket", ID = 161417 }),
    AncientKnotofWisdom                    = Action.Create({ Type = "Trinket", ID = 166793 }),
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
	ForbiddenObsidianClaw                  = Action.Create({ Type = "Trinket", ID = 173944 }),
    -- Misc
    Channeling                             = Action.Create({ Type = "Spell", ID = 209274, Hidden = true     }),	-- Show an icon during channeling
    TargetEnemy                            = Action.Create({ Type = "Spell", ID = 44603, Hidden = true     }),	-- Change Target (Tab button)
    StopCast                               = Action.Create({ Type = "Spell", ID = 61721, Hidden = true     }),		-- spell_magic_polymorphrabbit
    CyclotronicBlast                       = Action.Create({ Type = "Spell", ID = 293491, Hidden = true}),
    ConcentratedFlameBurn                  = Action.Create({ Type = "Spell", ID = 295368, Hidden = true}),
    RazorCoralDebuff                       = Action.Create({ Type = "Spell", ID = 303568, Hidden = true     }),
    ConductiveInkDebuff                    = Action.Create({ Type = "Spell", ID = 302565, Hidden = true     }),
	ManifestoofMadnessChapterOneBuff       = Action.Create({ Type = "Spell", ID = 313948, Hidden = true     }),
    -- Hidden Heart of Azeroth
    -- added all 3 ranks ids in case used by rotation
    VisionofPerfectionMinor                = Action.Create({ Type = "Spell", ID = 296320, Hidden = true}),
    VisionofPerfectionMinor2               = Action.Create({ Type = "Spell", ID = 299367, Hidden = true}),
    VisionofPerfectionMinor3               = Action.Create({ Type = "Spell", ID = 299369, Hidden = true}),
    UnleashHeartOfAzeroth                  = Action.Create({ Type = "Spell", ID = 280431, Hidden = true}), 
    RecklessForceBuff                      = Action.Create({ Type = "Spell", ID = 302932, Hidden = true     }),	 
	DummyTest                              = Action.Create({ Type = "Spell", ID = 159999, Hidden = true     }), -- Dummy stop dps icon 
	PoolResource                           = Action.Create({ Type = "Spell", ID = 209274, Hidden = true     }),
};

-- To create essences use next code:
Action:CreateEssencesFor(ACTION_CONST_MAGE_FIRE)  -- where PLAYERSPEC is Constance (example: ACTION_CONST_MONK_BM)
local A = setmetatable(Action[ACTION_CONST_MAGE_FIRE], { __index = Action })


------------------------------------------
---------------- VARIABLES ---------------
------------------------------------------

local function num(val)
  if val then return 1 else return 0 end
end

local function bool(val)
  return val ~= 0
end

-- Variables
local VarHoldCombustionThreshold = 0;
local VarHotStreakFlamestrike = 2 * num(A.FlamePatch:IsSpellLearned()) + 99 * num(not A.FlamePatch:IsSpellLearned());
local VarHardCastFlamestrike = 3 * num(A.FlamePatch:IsSpellLearned()) + 99 * num(not A.FlamePatch:IsSpellLearned());
local VarDelayFlamestrike = 0;
local VarFireBlastPooling = 0;
local VarPhoenixPooling = 0;
local VarCombustionOnUse = 0;
local VarFontDoubleOnUse = 0;
local VarFontPrecombatChannel = 0;
local VarTimeToCombusion = 0;
local VarKindlingReduction = 0;
local VarOnUseCutoff = 0;
local VarDisableCombustion = false
local VarCombustionRopCutoff = 0;
local VarFontofPowerPrecombatChannel = 0;
local VarTimeToCombustion = 0;

A.Listener:Add("ROTATION_VARS", "PLAYER_REGEN_ENABLED", function()
  VarHoldCombustionThreshold = 0
  VarHotStreakFlamestrike = 2 * num(A.FlamePatch:IsSpellLearned()) + 99 * num(not A.FlamePatch:IsSpellLearned())
  VarHardCastFlamestrike = 3 * num(A.FlamePatch:IsSpellLearned()) + 99 * num(not A.FlamePatch:IsSpellLearned())
  VarDelayFlamestrike = 0
  VarFireBlastPooling = 0
  VarPhoenixPooling = 0
  VarCombustionOnUse = 0
  VarFontDoubleOnUse = 0
  VarFontPrecombatChannel = 0
  VarTimeToCombusion = 0
  VarKindlingReduction = 0
  VarOnUseCutoff = 0
  VarDisableCombustion = false
  VarCombustionRopCutoff = 0;
  VarFontofPowerPrecombatChannel = 0;
  VarTimeToCombustion = 0;
end)

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

local function InRange(unit)
	-- @return boolean 
	return A.Fireball:IsInRange(unit)
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

-- Non GCD spell check
local function countInterruptGCD(unit)
    if not A.CounterSpell:IsReadyByPassCastGCD(unit) or not A.CounterSpell:AbsentImun(unit, Temp.TotalAndMagKick) then
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
        -- CounterSpell
        if useKick and not notInterruptable and A.CounterSpell:IsReady(unit) then 
            return A.CounterSpell
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

-- Variables
TR.IFST = {
    CurrStacks = 0,
    CurrStacksTime = 0,
    OldStacks = 0,
    OldStacksTime = 0,
    Direction = 0
}

A.Listener:Add("ROTATION_VARS", "PLAYER_REGEN_ENABLED", function()
    TR.IFST.CurrStacks = 0
    TR.IFST.CurrStacksTime = 0
    TR.IFST.OldStacks = 0
    TR.IFST.OldStacksTime = 0
    TR.IFST.Direction = 0
end)

local function IFTracker()
    local TickDiff = TR.IFST.CurrStacksTime - TR.IFST.OldStacksTime
    local CurrStacks = TR.IFST.CurrStacks
    local CurrStacksTime = TR.IFST.CurrStacksTime
    local OldStacks = TR.IFST.OldStacks
	
	if Unit(player):CombatTime() == 0 then 
	    return
	end
		
    if Unit(player):HasBuffs(A.IncantersFlowBuff.ID, true) > 0 then
        if (Unit(player):HasBuffsStacks(A.IncantersFlowBuff.ID, true) ~= CurrStacks or (Unit(player):HasBuffsStacks(A.IncantersFlowBuff.ID, true) == CurrStacks and TickDiff > 1)) then
            TR.IFST.OldStacks = CurrStacks
            TR.IFST.OldStacksTime = CurrStacksTime
        end		
        TR.IFST.CurrStacks = Unit(player):HasBuffsStacks(A.IncantersFlowBuff.ID, true)
        TR.IFST.CurrStacksTime = Unit(player):CombatTime()		
        if TR.IFST.CurrStacks > TR.IFST.OldStacks then
            if TR.IFST.CurrStacks == 5 then
                TR.IFST.Direction = 0
            else
                TR.IFST.Direction = 1
            end
        elseif TR.IFST.CurrStacks < TR.IFST.OldStacks then
            if TR.IFST.CurrStacks == 1 then
                TR.IFST.Direction = 0
            else
                TR.IFST.Direction = -1
            end
        else
            if TR.IFST.CurrStacks == 1 then
                TR.IFST.Direction = 1
            else
                TR.IFST.Direction = -1
            end
        end
    else
        TR.IFST.OldStacks = 0
        TR.IFST.OldStacksTime = 0
        TR.IFST.CurrStacks = 0
        TR.IFST.CurrStacksTime = 0
        TR.IFST.Direction = 0
    end
end

-- Implementation of IncantersFlow simc reference incanters_flow_time_to.COUNT.DIRECTION
-- @parameter: COUNT between "1 - 5" 
-- @parameter: DIRECTION "up", "down" or "any"
local function IFTimeToX(count, direction)
    local low
    local high
    local buff_position
    if TR.IFST.Direction == -1 or (TR.IFST.Direction == 0 and TR.IFST.CurrStacks == 0) then
      buff_position = 10 - TR.IFST.CurrStacks + 1
    else
      buff_position = TR.IFST.CurrStacks
    end
    if direction == "up" then
        low = count
        high = count
    elseif direction == "down" then
        low = 10 - count + 1
        high = 10 - count + 1
    else
        low = count
        high = 10 - count + 1
    end
    if low == buff_position or high == buff_position then
        return 0
    end
    local ticks_low = (10 + low - buff_position) % 10
    local ticks_high = (10 + high - buff_position) % 10
    return (TR.IFST.CurrStacksTime - TR.IFST.OldStacksTime) + math.min(ticks_low, ticks_high) - 1
end

---A.PhoenixFlames:RegisterInFlight();
--A.Pyroblast:RegisterInFlight(A.CombustionBuff);
--A.Fireball:RegisterInFlight(A.CombustionBuff);

local function FirestarterActiveStatus(unit)
    return (A.Firestarter:IsSpellLearned() and (Unit(unit):HealthPercent() > 90)) and true or false
end

local function FirestarterActiveRemains(unit)
    return ((A.Firestarter:IsSpellLearned() and Unit(unit):HealthPercent() > 90 and Unit(unit):TimeToDieX(90)) or 0)
end

local function HeatingUpBuffActive()
    return Unit(player):HasBuffs(A.HeatingUpBuff.ID, true) > 0 and A.FireBlast:GetSpellTimeSinceLastCast() > 1
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
    local Pull = Action.BossMods:GetPullTimer()
    -- Blink Handler
	local BlinkAny = A.Shimmer:IsSpellLearned() and A.Shimmer or A.Blink
	
    ------------------------------------------------------
    ---------------- ENEMY UNIT ROTATION -----------------
    ------------------------------------------------------
    local function EnemyRotation(unit)
	    -- variable,name=disable_combustion,op=reset
	    VarDisableCombustion = not A.BurstIsON(unit)

        -- variable,name=combustion_rop_cutoff,op=set,value=60
        if (true) then
            VarCombustionRopCutoff = 60
        end
			
        -- variable,name=combustion_on_use,op=set,value=equipped.manifesto_of_madness|equipped.gladiators_badge|equipped.gladiators_medallion|equipped.ignition_mages_fuse|equipped.tzanes_barkspines|equipped.azurethos_singed_plumage|equipped.ancient_knot_of_wisdom|equipped.shockbiters_fang|equipped.neural_synapse_enhancer|equipped.balefire_branch
        if (true) then
            VarCombustionOnUse = num(A.IgnitionMagesFuse:IsExists() or A.TzanesBarkspines:IsExists() or A.AzurethosSingedPlumage:IsExists() or A.AncientKnotofWisdom:IsExists() or A.ShockbitersFang:IsExists() or A.NeuralSynapseEnhancer:IsExists() or A.BalefireBranch:IsExists())
        end
			
        -- variable,name=font_double_on_use,op=set,value=equipped.azsharas_font_of_power&variable.combustion_on_use
        if (true) then
            VarFontDoubleOnUse = num(A.AzsharasFontofPower:IsExists() and bool(VarCombustionOnUse))
        end
			
        -- variable,name=font_of_power_precombat_channel,op=set,value=18,if=variable.font_double_on_use&variable.font_of_power_precombat_channel=0
        if (bool(VarFontDoubleOnUse) and VarFontofPowerPrecombatChannel == 0) then
            VarFontofPowerPrecombatChannel = 18
        end
			
        -- variable,name=on_use_cutoff,op=set,value=20*variable.combustion_on_use&!variable.font_double_on_use+40*variable.font_double_on_use+25*equipped.azsharas_font_of_power&!variable.font_double_on_use+8*equipped.manifesto_of_madness&!variable.font_double_on_use
        if (true) then
            VarOnUseCutoff = num(bool(20 * VarCombustionOnUse) and bool(num(not bool(VarFontDoubleOnUse)) + 40 * VarFontDoubleOnUse + 25 * num(A.AzsharasFontofPower:IsExists())) and bool(num(not bool(VarFontDoubleOnUse)) + 8) and not bool(VarFontDoubleOnUse))
        end
			
        -- variable,name=hold_combustion_threshold,op=reset,default=20
        if (true) then
            VarHoldCombustionThreshold = 20
        end
	
        -- variable,name=fire_blast_pooling,value=talent.rune_of_power.enabled&cooldown.rune_of_power.remains<cooldown.fire_blast.full_recharge_time&(variable.time_to_combustion>variable.combustion_rop_cutoff|variable.disable_combustion|firestarter.active)&(cooldown.rune_of_power.remains<target.time_to_die|action.rune_of_power.charges>0)|!variable.disable_combustion&variable.time_to_combustion<action.fire_blast.full_recharge_time+cooldown.fire_blast.duration*azerite.blaster_master.enabled&!firestarter.active&variable.time_to_combustion<target.time_to_die|talent.firestarter.enabled&firestarter.active&firestarter.remains<cooldown.fire_blast.full_recharge_time+cooldown.fire_blast.duration*azerite.blaster_master.enabled
        if (true) then
            VarFireBlastPooling = (A.RuneofPower:IsSpellLearned() and A.RuneofPower:GetCooldown() < A.FireBlast:GetSpellChargesFullRechargeTime() and (VarTimeToCombustion > VarCombustionRopCutoff or VarDisableCombustion or FirestarterActiveStatus(unit)) and (A.RuneofPower:GetCooldown() < Unit(unit):TimeToDie() or A.RuneofPower:GetSpellCharges() > 0) or not VarDisableCombustion and VarTimeToCombustion < A.FireBlast:GetSpellChargesFullRechargeTime() + A.FireBlast:BaseDuration() * A.BlasterMaster:GetAzeriteRank() and not FirestarterActiveStatus(unit) and VarTimeToCombustion < Unit(unit):TimeToDie() or A.Firestarter:IsSpellLearned() and FirestarterActiveStatus(unit) and FirestarterActiveRemains(unit) < A.FireBlast:GetSpellChargesFullRechargeTime() + A.FireBlast:BaseDuration() * A.BlasterMaster:GetAzeriteRank())
        end
			
   	    -- variable,name=phoenix_pooling,value=talent.rune_of_power.enabled&cooldown.rune_of_power.remains<cooldown.phoenix_flames.full_recharge_time&(variable.time_to_combustion>variable.combustion_rop_cutoff|variable.disable_combustion)&(cooldown.rune_of_power.remains<target.time_to_die|action.rune_of_power.charges>0)|!variable.disable_combustion&variable.time_to_combustion<action.phoenix_flames.full_recharge_time&variable.time_to_combustion<target.time_to_die
    	if (true) then
    		VarPhoenixPooling = num(A.RuneofPower:IsSpellLearned() and A.RuneofPower:GetCooldown() < A.PhoenixFlames:GetSpellChargesFullRechargeTime() and (VarTimeToCombustion > VarCombustionRopCutoff or VarDisableCombustion) and (A.RuneofPower:GetCooldown() < Unit(unit):TimeToDie() or A.RuneofPower:GetSpellCharges() > 0) or not VarDisableCombustion and VarTimeToCombustion < A.PhoenixFlames:GetSpellChargesFullRechargeTime() and VarTimeToCombustion < Unit(unit):TimeToDie())
    	end
		
		-- Interrupts
        local Interrupt = Interrupts(unit)
        if inCombat and Interrupt then 
            return Interrupt:Show(icon)
        end 
		
        --Precombat
        if combatTime == 0 and not Player:IsMounted() and Unit(unit):IsExists() and unit ~= "mouseover" then
            -- flask
            -- food
            -- augmentation
            -- arcane_intellect
            if A.ArcaneIntellect:IsReady(player) and Unit(player):HasBuffs(A.ArcaneIntellectBuff.ID, true) == 0 then
                return A.ArcaneIntellect:Show(icon)
            end
			
            -- snapshot_stats
            -- use_item,name=azsharas_font_of_power,if=!variable.disable_combustion
            if A.AzsharasFontofPower:IsReady(player) and (not VarDisableCombustion) 
			and ((Pull > 0.1 and Pull <= 5 + A.GetGCD()) or not Action.GetToggle(1, "BossMods"))
			then
                return A.AzsharasFontofPower:Show(icon)
            end
			
            -- mirror_image
            if A.MirrorImage:IsReady(player)
            and ((Pull > 0.1 and Pull <= 3 + A.GetGCD()) or not Action.GetToggle(1, "BossMods"))
			then
                return A.MirrorImage:Show(icon)
            end
			
            -- potion
            if A.PotionofUnbridledFury:IsReady(unit) and Action.GetToggle(1, "Potion") 
			and ((Pull > 0.1 and Pull <= 2 + A.GetGCD()) or not Action.GetToggle(1, "BossMods"))
			then
                return A.PotionofUnbridledFury:Show(icon)
            end
			
            -- pyroblast
            if A.Fireball:IsReady(unit)  
			and ((Pull > 0.1 and Pull <= A.Fireball:GetSpellCastTime() + A.GetGCD()) or not Action.GetToggle(1, "BossMods"))
			then
                return A.Fireball:Show(icon)
            end
			
        end
        
        --ActiveTalents
        local function ActiveTalents(unit)
		
            -- living_bomb,if=active_enemies>1&buff.combustion.down&(variable.time_to_combustion>cooldown.living_bomb.duration|variable.time_to_combustion<=0|variable.disable_combustion)
            if A.LivingBomb:IsReady(unit) and 
			(
			    MultiUnits:GetActiveEnemies() > 1 and Unit(player):HasBuffs(A.CombustionBuff.ID, true) == 0 and 
				(
				    VarTimeToCombustion > A.LivingBomb:BaseDuration()
				    or 
				    VarTimeToCombustion <= 0 
				    or
				    VarDisableCombustion
				)
			)
			then
                return A.LivingBomb:Show(icon)
            end
			
            -- meteor,if=buff.rune_of_power.up&(firestarter.remains>cooldown.meteor.duration|!firestarter.active)|cooldown.rune_of_power.remains>target.time_to_die&action.rune_of_power.charges<1|(cooldown.meteor.duration<variable.time_to_combustion|variable.time_to_combustion<=0|variable.disable_combustion)&!talent.rune_of_power.enabled&(cooldown.meteor.duration<firestarter.remains|!talent.firestarter.enabled|!firestarter.active)
            if A.Meteor:IsReady(player) and 
			(
			    Unit(player):HasBuffs(A.RuneofPowerBuff.ID, true) > 0 and 
				(
				    FirestarterActiveRemains(unit) > A.Meteor:BaseDuration() 
					or 
					not FirestarterActiveStatus(unit)
				)
				or 
				A.RuneofPower:GetCooldown() > Unit(unit):TimeToDie() and A.RuneofPower:GetSpellCharges() < 1 
				or 
				(
				    A.Meteor:BaseDuration() < VarTimeToCombustion 
					or
					VarTimeToCombustion <= 0
					or 
					VarDisableCombustion
				) 
				and not A.RuneofPower:IsSpellLearned() and 
				(
				    A.Meteor:BaseDuration() < FirestarterActiveRemains(unit) 
					or 
					not A.Firestarter:IsSpellLearned() 
					or 
					not FirestarterActiveStatus(unit)
				)
			) 
			then
                return A.Meteor:Show(icon)
            end
        end
        
        --CombustionPhase
        local function CombustionPhase(unit)
            -- lights_judgment,if=buff.combustion.down
            if A.LightsJudgment:IsReady(unit) and A.BurstIsON(unit) and (Unit(player):HasBuffs(A.CombustionBuff.ID, true) == 0) then
                return A.LightsJudgment:Show(icon)
            end
			
            -- bag_of_tricks,if=buff.combustion.down
            if A.BagofTricks:AutoRacial(unit) and (Unit(player):HasBuffs(A.CombustionBuff.ID, true) == 0) then
                return A.BagofTricks:Show(icon)
            end
			
            -- living_bomb,if=active_enemies>1&buff.combustion.down
            if A.LivingBomb:IsReady(unit) and (MultiUnits:GetActiveEnemies() > 1 and Unit(player):HasBuffs(A.CombustionBuff.ID, true) == 0) then
                return A.LivingBomb:Show(icon)
            end
			
            -- blood_of_the_enemy
            if A.BloodoftheEnemy:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") then
                return A.BloodoftheEnemy:Show(icon)
            end
			
            -- memory_of_lucid_dreams
            if A.MemoryofLucidDreams:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") then
                return A.MemoryofLucidDreams:Show(icon)
            end
			
            -- worldvein_resonance
            if A.WorldveinResonance:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") then
                return A.WorldveinResonance:Show(icon)
            end
			
            -- fire_blast,use_while_casting=1,use_off_gcd=1,if=charges>=1&((action.fire_blast.charges_fractional+(buff.combustion.remains-buff.blaster_master.duration)%cooldown.fire_blast.duration-(buff.combustion.remains)%(buff.blaster_master.duration-0.5))>=0|!azerite.blaster_master.enabled|!talent.flame_on.enabled|buff.combustion.remains<=buff.blaster_master.duration|buff.blaster_master.remains<0.5|equipped.hyperthread_wristwraps&cooldown.hyperthread_wristwraps_300142.remains<5)&buff.combustion.up&(!Player:IsCasting() == A.Scorch:Info()&!action.pyroblast.in_flight&buff.heating_up.up|Player:IsCasting() == A.Scorch:Info()&buff.hot_streak.down&(buff.heating_up.down|azerite.blaster_master.enabled)|azerite.blaster_master.enabled&talent.flame_on.enabled&action.pyroblast.in_flight&buff.heating_up.down&buff.hot_streak.down)
            if A.FireBlast:IsReadyByPassCastGCD(unit) and A.LastPlayerCastID ~= A.FireBlast.ID and 
			(
			    A.FireBlast:GetSpellCharges() >= 1 and 
				(
				    (A.FireBlast:GetSpellChargesFrac() + (Unit(player):HasBuffs(A.CombustionBuff.ID, true) - A.BlasterMasterBuff:BaseDuration()) / A.FireBlast:BaseDuration() - (Unit(player):HasBuffs(A.CombustionBuff.ID, true)) / (A.BlasterMasterBuff:BaseDuration() - 0.5)) >= 0 
					or
					A.BlasterMaster:GetAzeriteRank() == 0 
					or 
					not A.FlameOn:IsSpellLearned() 
					or 
					Unit(player):HasBuffs(A.CombustionBuff.ID, true) <= A.BlasterMasterBuff:BaseDuration() 
					or 
					Unit(player):HasBuffs(A.BlasterMasterBuff.ID, true) < 0.5 
					or 
					A.HyperthreadWristwraps:IsExists() and A.HyperthreadWristwraps:GetCooldown() < 5
				) 
				and Unit(player):HasBuffs(A.CombustionBuff.ID, true) > 0 and 
				(
				    not Player:IsCasting() == A.Scorch:Info() and not A.Pyroblast:IsSpellInFlight() and Unit(player):HasBuffs(A.HeatingUpBuff.ID, true) > 0 
					or 
					Player:IsCasting() == A.Scorch:Info() and Unit(player):HasBuffs(A.HotStreakBuff.ID, true) == 0 and 
					(
					    Unit(player):HasBuffs(A.HeatingUpBuff.ID, true) == 0 
					    or 
					    A.BlasterMaster:GetAzeriteRank() > 0
					)
					or 
					A.BlasterMaster:GetAzeriteRank() > 0 
					and A.FlameOn:IsSpellLearned() and A.Pyroblast:IsSpellInFlight() 
					and Unit(player):HasBuffs(A.HeatingUpBuff.ID, true) == 0 and Unit(player):HasBuffs(A.HotStreakBuff.ID, true) == 0
				)
			)
			then
                return A.FireBlast:Show(icon)
            end
			
            -- rune_of_power,if=buff.combustion.down
            if A.RuneofPower:IsReady(player) and (Unit(player):HasBuffs(A.CombustionBuff.ID, true) == 0) then
                return A.RuneofPower:Show(icon)
            end
			
            -- fire_blast,use_while_casting=1,if=azerite.blaster_master.enabled&(essence.memory_of_lucid_dreams.major|!essence.memory_of_lucid_dreams.minor)&talent.meteor.enabled&talent.flame_on.enabled&buff.blaster_master.down&(talent.rune_of_power.enabled&Player:IsCasting() == A.RuneofPower:Info()&Unit(player):IsCastingRemains(A.RuneofPower.ID)<0.6|(variable.time_to_combustion<=0|buff.combustion.up)&!talent.rune_of_power.enabled&!action.pyroblast.in_flight&!action.fireball.in_flight)
            if A.FireBlast:IsReadyByPassCastGCD(unit) and A.LastPlayerCastID ~= A.FireBlast.ID and 
			(
			    A.BlasterMaster:GetAzeriteRank() > 0 and 
				(
				    Azerite:EssenceHasMajor(A.MemoryofLucidDreams.ID) 
					or
					not Azerite:EssenceHasMinor(A.MemoryofLucidDreams.ID)
				)
				and A.Meteor:IsSpellLearned() and A.FlameOn:IsSpellLearned() and Unit(player):HasBuffs(A.BlasterMasterBuff.ID, true) == 0 and 
				(
				    A.RuneofPower:IsSpellLearned() and Player:IsCasting() == A.RuneofPower:Info() and Unit(player):IsCastingRemains(A.RuneofPower.ID) < 0.6 
					or
					(
					    VarTimeToCombustion <= 0 
						or 
						Unit(player):HasBuffs(A.CombustionBuff.ID, true) > 0
					)
					and not A.RuneofPower:IsSpellLearned() and not A.Pyroblast:IsSpellInFlight() and not A.Fireball:IsSpellInFlight()
				)
			)
			then
                return A.FireBlast:Show(icon)
            end
			
            -- call_action_list,name=active_talents
            if ActiveTalents(unit) then
                return true
            end
			
            -- combustion,use_off_gcd=1,use_while_casting=1,if=((action.meteor.in_flight&action.meteor.in_flight_remains<=0.5)|!talent.meteor.enabled)&(buff.rune_of_power.up|!talent.rune_of_power.enabled)
            if A.Combustion:IsReadyByPassCastGCD(player) and A.BurstIsON(unit) and 
			(
			    (
				    (A.Meteor:IsSpellInFlight() and A.LastPlayerCastName == A.Meteor:Info()) 
					or 
					not A.Meteor:IsSpellLearned()
				)
				and 
				(
				    Unit(player):HasBuffs(A.RuneofPowerBuff.ID, true) > 0
				    or 
				    not A.RuneofPower:IsSpellLearned()
				)
			)
			then
                return A.Combustion:Show(icon)
            end
			
            -- potion
            if A.PotionofUnbridledFury:IsReady(unit) and Action.GetToggle(1, "Potion") then
                return A.PotionofUnbridledFury:Show(icon)
            end
			
            -- blood_fury
            if A.BloodFury:AutoRacial(unit) and Action.GetToggle(1, "Racial") and A.BurstIsON(unit) then
                return A.BloodFury:Show(icon)
            end
			
            -- berserking
            if A.Berserking:AutoRacial(unit) and Action.GetToggle(1, "Racial") and A.BurstIsON(unit) then
                return A.Berserking:Show(icon)
            end
			
            -- fireblood
            if A.Fireblood:AutoRacial(unit) and Action.GetToggle(1, "Racial") and A.BurstIsON(unit) then
                return A.Fireblood:Show(icon)
            end
			
            -- ancestral_call
            if A.AncestralCall:AutoRacial(unit) and Action.GetToggle(1, "Racial") and A.BurstIsON(unit) then
                return A.AncestralCall:Show(icon)
            end
			
            -- flamestrike,if=((talent.flame_patch.enabled&active_enemies>2)|active_enemies>6)&buff.hot_streak.react&!azerite.blaster_master.enabled
            if A.Flamestrike:IsReady(player) and 
			(
			    (
				    (A.FlamePatch:IsSpellLearned() and MultiUnits:GetActiveEnemies() > 2) 
					or
					MultiUnits:GetActiveEnemies() > 6
				)
				and Unit(player):HasBuffs(A.HotStreakBuff.ID, true) > 0 and A.BlasterMaster:GetAzeriteRank() == 0
			)
			then
                return A.Flamestrike:Show(icon)
            end
			
            -- pyroblast,if=buff.pyroclasm.react&buff.combustion.remains>cast_time
            if A.Pyroblast:IsReady(unit) and 
			(
			    Unit(player):HasBuffs(A.PyroclasmBuff.ID, true) > 0 and Unit(player):HasBuffs(A.CombustionBuff.ID, true) > A.Pyroblast:GetSpellCastTime()
			)
			then
                return A.Pyroblast:Show(icon)
            end
			
            -- pyroblast,if=buff.hot_streak.react
            if A.Pyroblast:IsReady(unit) and Unit(player):HasBuffs(A.HotStreakBuff.ID, true) > 0 then
                return A.Pyroblast:Show(icon)
            end
			
            -- pyroblast,if=prev_gcd.1.scorch&buff.heating_up.up
          --  if A.Pyroblast:IsReady(unit) and Unit(player):HasBuffs(A.CombustionBuff.ID, true) > 0 and (A.LastPlayerCastName == A.Scorch:Info() and Unit(player):HasBuffs(A.HeatingUpBuff.ID, true) > 0) then
           --     return A.Pyroblast:Show(icon)
            --end
			
            -- phoenix_flames
            if A.PhoenixFlames:IsReady(unit) then
                return A.PhoenixFlames:Show(icon)
            end
			
            -- scorch,if=buff.combustion.remains>cast_time&buff.combustion.up|buff.combustion.down
            if A.Scorch:IsReady(unit) and 
			(
			    Unit(player):HasBuffs(A.CombustionBuff.ID, true) > A.Scorch:GetSpellCastTime() and Unit(player):HasBuffs(A.CombustionBuff.ID, true) > 0
				or 
				Unit(player):HasBuffs(A.CombustionBuff.ID, true) == 0 and isMoving
			)
			then
                return A.Scorch:Show(icon)
            end
			
            -- living_bomb,if=buff.combustion.remains<gcd.max&active_enemies>1
            if A.LivingBomb:IsReady(unit) and (Unit(player):HasBuffs(A.CombustionBuff.ID, true) < A.GetGCD() and MultiUnits:GetActiveEnemies() > 1) then
                return A.LivingBomb:Show(icon)
            end
			
            -- dragons_breath,if=buff.combustion.remains<gcd.max&buff.combustion.up
            if A.DragonsBreath:IsReady(unit) and Unit(unit):GetRange() <= 10 and (Unit(player):HasBuffs(A.CombustionBuff.ID, true) < A.GetGCD() and Unit(player):HasBuffs(A.CombustionBuff.ID, true) > 0) then
                return A.DragonsBreath:Show(icon)
            end
			
            -- scorch,if=target.health.pct<=30&talent.searing_touch.enabled
            if A.Scorch:IsReady(unit) and (Unit(unit):HealthPercent() <= 30 and A.SearingTouch:IsSpellLearned()) then
                return A.Scorch:Show(icon)
            end
			
        end
        
        --ItemsCombustion
        local function ItemsCombustion(unit)
		
            -- use_item,name=ignition_mages_fuse
            if A.IgnitionMagesFuse:IsReady(unit) then
                return A.IgnitionMagesFuse:Show(icon)
            end
			
            -- use_item,name=hyperthread_wristwraps,if=buff.combustion.up&action.fire_blast.charges=0&action.fire_blast.recharge_time>gcd.max
            if A.HyperthreadWristwraps:IsReady(player) and A.LastPlayerCastID == A.FireBlast.ID and 
			(
			    Unit(player):HasBuffs(A.CombustionBuff.ID, true) > 0 
				and A.FireBlast:GetSpellCharges() == 0 
				and A.FireBlast:GetSpellChargesFullRechargeTime() > A.GetGCD()
			)
			then
                return A.HyperthreadWristwraps:Show(icon)
            end
			
            -- use_item,name=manifesto_of_madness
          --  if A.ManifestoofMadness:IsReady(unit) then
          --      return A.ManifestoofMadness:Show(icon)
          --  end
			
            -- cancel_buff,use_off_gcd=1,name=manifesto_of_madness_chapter_one,if=buff.combustion.up|action.meteor.in_flight&action.meteor.in_flight_remains<=0.5
            if (Unit(player):HasBuffs(A.CombustionBuff.ID, true) > 0 or A.Meteor:IsSpellInFlight() and A.LastPlayerCastName == A.Meteor:Info()) then
                Player:CancelBuff(A.ManifestoofMadnessChapterOneBuff:Info())
            end
			
            -- use_item,use_off_gcd=1,name=azurethos_singed_plumage,if=buff.combustion.up|action.meteor.in_flight&action.meteor.in_flight_remains<=0.5
            if A.AzurethosSingedPlumage:IsReady(unit) and (Unit(player):HasBuffs(A.CombustionBuff.ID, true) > 0 or A.Meteor:IsSpellInFlight() and A.LastPlayerCastName == A.Meteor:Info()) then
                return A.AzurethosSingedPlumage:Show(icon)
            end
						
            -- use_item,use_off_gcd=1,effect_name=gladiators_medallion,if=buff.combustion.up|action.meteor.in_flight&action.meteor.in_flight_remains<=0.5
     --       if A.GladiatorsMedallion:IsReady(unit) and (Unit(player):HasBuffs(A.CombustionBuff.ID, true) or A.Meteor:IsSpellInFlight() and A.LastPlayerCastName == A.Meteor:Info()) then
      --         return A.GladiatorsMedallion:Show(icon)
       --     end
			
            -- use_item,use_off_gcd=1,name=balefire_branch,if=buff.combustion.up|action.meteor.in_flight&action.meteor.in_flight_remains<=0.5
            if A.BalefireBranch:IsReady(unit) and (Unit(player):HasBuffs(A.CombustionBuff.ID, true) > 0 or A.Meteor:IsSpellInFlight() and A.LastPlayerCastName == A.Meteor:Info()) then
                return A.BalefireBranch:Show(icon)
            end
			
            -- use_item,use_off_gcd=1,name=shockbiters_fang,if=buff.combustion.up|action.meteor.in_flight&action.meteor.in_flight_remains<=0.5
            if A.ShockbitersFang:IsReady(unit) and (Unit(player):HasBuffs(A.CombustionBuff.ID, true) > 0 or A.Meteor:IsSpellInFlight() and A.LastPlayerCastName == A.Meteor:Info()) then
                return A.ShockbitersFang:Show(icon)
            end
			
            -- use_item,use_off_gcd=1,name=tzanes_barkspines,if=buff.combustion.up|action.meteor.in_flight&action.meteor.in_flight_remains<=0.5
            if A.TzanesBarkspines:IsReady(unit) and (Unit(player):HasBuffs(A.CombustionBuff.ID, true) > 0 or A.Meteor:IsSpellInFlight() and A.LastPlayerCastName == A.Meteor:Info()) then
                return A.TzanesBarkspines:Show(icon)
            end
			
            -- use_item,use_off_gcd=1,name=ancient_knot_of_wisdom,if=buff.combustion.up|action.meteor.in_flight&action.meteor.in_flight_remains<=0.5
            if A.AncientKnotofWisdom:IsReady(unit) and (Unit(player):HasBuffs(A.CombustionBuff.ID, true) > 0 or A.Meteor:IsSpellInFlight() and A.LastPlayerCastName == A.Meteor:Info()) then
                return A.AncientKnotofWisdom:Show(icon)
            end
			
            -- use_item,use_off_gcd=1,name=neural_synapse_enhancer,if=buff.combustion.up|action.meteor.in_flight&action.meteor.in_flight_remains<=0.5
            if A.NeuralSynapseEnhancer:IsReady(unit) and (Unit(player):HasBuffs(A.CombustionBuff.ID, true) > 0 or A.Meteor:IsSpellInFlight() and A.LastPlayerCastName == A.Meteor:Info()) then
                return A.NeuralSynapseEnhancer:Show(icon)
            end
			
            -- use_item,use_off_gcd=1,name=malformed_heralds_legwraps,if=buff.combustion.up|action.meteor.in_flight&action.meteor.in_flight_remains<=0.5
            if A.MalformedHeraldsLegwraps:IsReady(unit) and (Unit(player):HasBuffs(A.CombustionBuff.ID, true) > 0 or A.Meteor:IsSpellInFlight() and A.LastPlayerCastName == A.Meteor:Info()) then
                return A.MalformedHeraldsLegwraps:Show(icon)
            end
			
        end
        
        --ItemsHighPriority
        local function ItemsHighPriority(unit)
		
            -- call_action_list,name=items_combustion,if=!variable.disable_combustion&(talent.rune_of_power.enabled&variable.time_to_combustion<=action.rune_of_power.cast_time|variable.time_to_combustion<=0)&!firestarter.active|buff.combustion.up
            if ItemsCombustion(unit) and 
			(
			    not VarDisableCombustion and 
				(
				    A.RuneofPower:IsSpellLearned() and VarTimeToCombustion <= A.RuneofPower:GetSpellCastTime() 
					or 
					VarTimeToCombustion <= 0
				) and 
				not FirestarterActiveStatus(unit) 
				or 
				Unit(player):HasBuffs(A.CombustionBuff.ID, true) > 0
			)
			then
                return true
            end
			
            -- use_items
            -- use_item,name=manifesto_of_madness,if=!equipped.azsharas_font_of_power&variable.time_to_combustion<8
          --  if A.ManifestoofMadness:IsReady(unit) and (not A.AzsharasFontofPower:IsExists() and VarTimeToCombustion < 8) then
          --      return A.ManifestoofMadness:Show(icon)
          --  end
			
            -- use_item,name=azsharas_font_of_power,if=variable.time_to_combustion<=5+15*variable.font_double_on_use&!variable.disable_combustion
            if A.AzsharasFontofPower:IsReady(player) and (VarTimeToCombustion <= 5 + 15 * VarFontDoubleOnUse and not VarDisableCombustion) then
                return A.AzsharasFontofPower:Show(icon)
            end
			
            -- use_item,name=rotcrusted_voodoo_doll,if=variable.time_to_combustion>variable.on_use_cutoff|variable.disable_combustion
            if A.RotcrustedVoodooDoll:IsReady(unit) and (VarTimeToCombustion > VarOnUseCutoff or VarDisableCombustion) then
                return A.RotcrustedVoodooDoll:Show(icon)
            end
			
            -- use_item,name=aquipotent_nautilus,if=variable.time_to_combustion>variable.on_use_cutoff|variable.disable_combustion
            if A.AquipotentNautilus:IsReady(unit) and (VarTimeToCombustion > VarOnUseCutoff or VarDisableCombustion) then
                return A.AquipotentNautilus:Show(icon)
            end
			
            -- use_item,name=shiver_venom_relic,if=variable.time_to_combustion>variable.on_use_cutoff|variable.disable_combustion
            if A.ShiverVenomRelic:IsReady(unit) and (VarTimeToCombustion > VarOnUseCutoff or VarDisableCombustion) then
                return A.ShiverVenomRelic:Show(icon)
            end
			
            -- use_item,name=forbidden_obsidian_claw,if=variable.time_to_combustion>variable.on_use_cutoff|variable.disable_combustion
         --   if A.ForbiddenObsidianClaw:IsReady(unit) and (VarTimeToCombustion > VarOnUseCutoff or VarDisableCombustion) then
          --      return A.ForbiddenObsidianClaw:Show(icon)
           -- end
			
            -- use_item,effect_name=harmonic_dematerializer
          --  if A.HarmonicDematerializer:IsReady(unit) then
          --      return A.HarmonicDematerializer:Show(icon)
           -- end
			
            -- use_item,name=malformed_heralds_legwraps,if=variable.time_to_combustion>=55&buff.combustion.down&variable.time_to_combustion>variable.on_use_cutoff|variable.disable_combustion
            if A.MalformedHeraldsLegwraps:IsReady(unit) and (VarTimeToCombustion >= 55 and Unit(player):HasBuffs(A.CombustionBuff.ID, true) == 0 and VarTimeToCombustion > VarOnUseCutoff or VarDisableCombustion) then
                return A.MalformedHeraldsLegwraps:Show(icon)
            end
			
            -- use_item,name=ancient_knot_of_wisdom,if=variable.time_to_combustion>=55&buff.combustion.down&variable.time_to_combustion>variable.on_use_cutoff|variable.disable_combustion
            if A.AncientKnotofWisdom:IsReady(unit) and (VarTimeToCombustion >= 55 and Unit(player):HasBuffs(A.CombustionBuff.ID, true) == 0 and VarTimeToCombustion > VarOnUseCutoff or VarDisableCombustion) then
                return A.AncientKnotofWisdom:Show(icon)
            end
			
            -- use_item,name=neural_synapse_enhancer,if=variable.time_to_combustion>=45&buff.combustion.down&variable.time_to_combustion>variable.on_use_cutoff|variable.disable_combustion
            if A.NeuralSynapseEnhancer:IsReady(unit) and (VarTimeToCombustion >= 45 and Unit(player):HasBuffs(A.CombustionBuff.ID, true) == 0 and VarTimeToCombustion > VarOnUseCutoff or VarDisableCombustion) then
                return A.NeuralSynapseEnhancer:Show(icon)
            end
        end
        
        --ItemsLowPriority
        local function ItemsLowPriority(unit)
		
            -- use_item,name=tidestorm_codex,if=variable.time_to_combustion>variable.on_use_cutoff|variable.disable_combustion|talent.firestarter.enabled&firestarter.remains>variable.on_use_cutoff
            if A.TidestormCodex:IsReady(unit) and (VarTimeToCombustion > VarOnUseCutoff or VarDisableCombustion or A.Firestarter:IsSpellLearned() and FirestarterActiveRemains(unit) > VarOnUseCutoff) then
                return A.TidestormCodex:Show(icon)
            end
			
            -- use_item,effect_name=cyclotronic_blast,if=variable.time_to_combustion>variable.on_use_cutoff|variable.disable_combustion|talent.firestarter.enabled&firestarter.remains>variable.on_use_cutoff
            if A.CyclotronicBlast:IsReady(unit) and (VarTimeToCombustion > VarOnUseCutoff or VarDisableCombustion or A.Firestarter:IsSpellLearned() and FirestarterActiveRemains(unit) > VarOnUseCutoff) then
                return A.CyclotronicBlast:Show(icon)
            end
			
        end
        
        --RopPhase
        local function RopPhase(unit)
		
            -- rune_of_power
            if A.RuneofPower:IsReady(player) then
                return A.RuneofPower:Show(icon)
            end
			
            -- flamestrike,if=(talent.flame_patch.enabled&active_enemies>1|active_enemies>4)&buff.hot_streak.react
            if A.Flamestrike:IsReady(player) and 
			(
			    (
				    A.FlamePatch:IsSpellLearned() and MultiUnits:GetActiveEnemies() > 1 
					or 
					MultiUnits:GetActiveEnemies() > 4
				)
				and Unit(player):HasBuffs(A.HotStreakBuff.ID, true) > 0
			)
			then
                return A.Flamestrike:Show(icon)
            end
			
            -- pyroblast,if=buff.hot_streak.react
            if A.Pyroblast:IsReady(unit) and Unit(player):HasBuffs(A.HotStreakBuff.ID, true) > 0 then
                return A.Pyroblast:Show(icon)
            end
			
            -- fire_blast,use_off_gcd=1,use_while_casting=1,if=!(talent.flame_patch.enabled&active_enemies>2|active_enemies>5)&(!firestarter.active&(variable.time_to_combustion>0|variable.disable_combustion))&(!buff.heating_up.react&!buff.hot_streak.react&!prev_off_gcd.fire_blast&(action.fire_blast.charges>=2|(action.phoenix_flames.charges>=1&talent.phoenix_flames.enabled)|(talent.alexstraszas_fury.enabled&cooldown.dragons_breath.ready)|(talent.searing_touch.enabled&target.health.pct<=30)))
            if A.FireBlast:IsReadyByPassCastGCD(unit) and 
			(
			    not (A.FlamePatch:IsSpellLearned() and MultiUnits:GetActiveEnemies() > 2 
				or 
				MultiUnits:GetActiveEnemies() > 5) and 
				(
				    not FirestarterActiveStatus(unit) and 
					(
					    VarTimeToCombustion > 0 
						or 
						VarDisableCombustion
					)
				)
				and 
				(
				    Unit(player):HasBuffs(A.HeatingUpBuff.ID, true) == 0 
					and Unit(player):HasBuffs(A.HotStreakBuff.ID, true) == 0 
					and not A.LastPlayerCastName == A.FireBlast:Info() and 
					(
					    A.FireBlast:GetSpellCharges() >= 2 
						or
						(A.PhoenixFlames:GetSpellCharges() >= 1 and A.PhoenixFlames:IsSpellLearned()) 
						or 
						(A.AlexstraszasFury:IsSpellLearned() and A.DragonsBreath:GetCooldown() == 0) 
						or 
						(A.SearingTouch:IsSpellLearned() and Unit(unit):HealthPercent() <= 30)
					)
				)
			)
			then
                return A.FireBlast:Show(icon)
            end
			
            -- call_action_list,name=active_talents
            if ActiveTalents(unit) then
                return true
            end
			
            -- pyroblast,if=buff.pyroclasm.react&cast_time<buff.pyroclasm.remains&buff.rune_of_power.remains>cast_time
            if A.Pyroblast:IsReady(unit) and 
			(
			    Unit(player):HasBuffs(A.PyroclasmBuff.ID, true) > 0
				and 
				A.Pyroblast:GetSpellCastTime() < Unit(player):HasBuffs(A.PyroclasmBuff.ID, true) 
				and 
				Unit(player):HasBuffs(A.RuneofPowerBuff.ID, true) > A.Pyroblast:GetSpellCastTime()
			)
			then
                return A.Pyroblast:Show(icon)
            end
			
            -- fire_blast,use_off_gcd=1,use_while_casting=1,if=!(talent.flame_patch.enabled&active_enemies>2|active_enemies>5)&(!firestarter.active&(variable.time_to_combustion>0|variable.disable_combustion))&(buff.heating_up.react&(target.health.pct>=30|!talent.searing_touch.enabled))
            if A.FireBlast:IsReadyByPassCastGCD(unit) and A.LastPlayerCastID ~= A.FireBlast.ID and 
			(
			    not (A.FlamePatch:IsSpellLearned() and MultiUnits:GetActiveEnemies() > 2 or MultiUnits:GetActiveEnemies() > 5) 
				and 
				(
				    not FirestarterActiveStatus(unit) and 
					(
					    VarTimeToCombustion > 0 
						or 
						VarDisableCombustion
					)
				)
				and 
				(
				    Unit(player):HasBuffs(A.HeatingUpBuff.ID, true) > 0 and 
					(
					    Unit(unit):HealthPercent() >= 30 
						or 
						not A.SearingTouch:IsSpellLearned()
					)
				)
			)
			then
                return A.FireBlast:Show(icon)
            end
			
            -- fire_blast,use_off_gcd=1,use_while_casting=1,if=!(talent.flame_patch.enabled&active_enemies>2|active_enemies>5)&(!firestarter.active&(variable.time_to_combustion>0|variable.disable_combustion))&talent.searing_touch.enabled&target.health.pct<=30&(buff.heating_up.react&!Player:IsCasting() == A.Scorch:Info()|!buff.heating_up.react&!buff.hot_streak.react)
            if A.FireBlast:IsReadyByPassCastGCD(unit) and A.LastPlayerCastID ~= A.FireBlast.ID and 
			(
			    not (A.FlamePatch:IsSpellLearned() and MultiUnits:GetActiveEnemies() > 2 
				or 
				MultiUnits:GetActiveEnemies() > 5) and 
				(
				    not FirestarterActiveStatus(unit) and 
					(
					    VarTimeToCombustion > 0 
						or 
						VarDisableCombustion
					)
				)
				and A.SearingTouch:IsSpellLearned() and Unit(unit):HealthPercent() <= 30 and 
				(
				    Unit(player):HasBuffs(A.HeatingUpBuff.ID, true) > 0 and not Player:IsCasting() == A.Scorch:Info() 
					or 
					Unit(player):HasBuffs(A.HeatingUpBuff.ID, true) == 0 and Unit(player):HasBuffs(A.HotStreakBuff.ID, true) == 0
				)
			)
			then
                return A.FireBlast:Show(icon)
            end
			
            -- pyroblast,if=prev_gcd.1.scorch&buff.heating_up.up&talent.searing_touch.enabled&target.health.pct<=30&(!talent.flame_patch.enabled|active_enemies=1)
            if A.Pyroblast:IsReady(unit) and 
			(
			    A.LastPlayerCastName == A.Scorch:Info() and Unit(player):HasBuffs(A.HeatingUpBuff.ID, true) > 0 and A.SearingTouch:IsSpellLearned() and Unit(unit):HealthPercent() <= 30 and 
				(
				    not A.FlamePatch:IsSpellLearned() 
					or 
					MultiUnits:GetActiveEnemies() == 1
				)
			)
			then
                return A.Pyroblast:Show(icon)
            end
			
            -- phoenix_flames,if=!prev_gcd.1.phoenix_flames&buff.heating_up.react
            if A.PhoenixFlames:IsReady(unit) and (not A.LastPlayerCastName == A.PhoenixFlames:Info() and Unit(player):HasBuffs(A.HeatingUpBuff.ID, true) > 0) then
                return A.PhoenixFlames:Show(icon)
            end
			
            -- scorch,if=target.health.pct<=30&talent.searing_touch.enabled
            if A.Scorch:IsReady(unit) and (Unit(unit):HealthPercent() <= 30 and A.SearingTouch:IsSpellLearned()) then
                return A.Scorch:Show(icon)
            end
			
            -- dragons_breath,if=active_enemies>2
            if A.DragonsBreath:IsReady(unit) and Unit(unit):GetRange() <= 10 and MultiUnits:GetActiveEnemies() > 2 then
                return A.DragonsBreath:Show(icon)
            end
			
            -- fire_blast,use_off_gcd=1,use_while_casting=1,if=(talent.flame_patch.enabled&active_enemies>2|active_enemies>5)&((variable.time_to_combustion>0|variable.disable_combustion)&!firestarter.active)&buff.hot_streak.down&(!azerite.blaster_master.enabled|buff.blaster_master.remains<0.5)
            if A.FireBlast:IsReadyByPassCastGCD(unit) and A.LastPlayerCastID ~= A.FireBlast.ID and 
			(
			    (
				    A.FlamePatch:IsSpellLearned() and MultiUnits:GetActiveEnemies() > 2 
					or 
					MultiUnits:GetActiveEnemies() > 5
				)
				and 
				(
				    (
					    VarTimeToCombustion > 0 
						or 
						VarDisableCombustion
					)
					and not FirestarterActiveStatus(unit)
				)
				and Unit(player):HasBuffs(A.HotStreakBuff.ID, true) == 0 and 
				(
				    A.BlasterMaster:GetAzeriteRank() == 0 
					or 
					Unit(player):HasBuffs(A.BlasterMasterBuff.ID, true) < 0.5
				)
			)
			then
                return A.FireBlast:Show(icon)
            end
			
            -- flamestrike,if=talent.flame_patch.enabled&active_enemies>2|active_enemies>5
            if A.Flamestrike:IsReady(player) and (A.FlamePatch:IsSpellLearned() and MultiUnits:GetActiveEnemies() > 2 or MultiUnits:GetActiveEnemies() > 5) then
                return A.Flamestrike:Show(icon)
            end
			
            -- fireball
            if A.Fireball:IsReady(unit) and not isMoving  then
                return A.Fireball:Show(icon)
            end
			
        end
        
        --StandardRotation
        local function StandardRotation(unit)
		
            -- flamestrike,if=((talent.flame_patch.enabled&active_enemies>1&!firestarter.active)|active_enemies>4)&buff.hot_streak.react
            if A.Flamestrike:IsReady(player) and 
			(
			    (
				    (A.FlamePatch:IsSpellLearned() and MultiUnits:GetActiveEnemies() > 1 and not FirestarterActiveStatus(unit))
					or 
					MultiUnits:GetActiveEnemies() > 4
				)
				and Unit(player):HasBuffs(A.HotStreakBuff.ID, true) > 0
			)
			then
                return A.Flamestrike:Show(icon)
            end
			
            -- pyroblast,if=buff.hot_streak.react&buff.hot_streak.remains<action.fireball.execute_time
            if A.Pyroblast:IsReady(unit) and 
			(
			    Unit(player):HasBuffs(A.HotStreakBuff.ID, true) > 0 and Unit(player):HasBuffs(A.HotStreakBuff.ID, true) < A.Fireball:GetSpellCastTime()
			)
			then
                return A.Pyroblast:Show(icon)
            end
			
            -- pyroblast,if=buff.hot_streak.react&(prev_gcd.1.fireball|firestarter.active|action.pyroblast.in_flight)
            if A.Pyroblast:IsReady(unit) and 
			(
			    Unit(player):HasBuffs(A.HotStreakBuff.ID, true) > 0 and 
				(
				    A.LastPlayerCastName == A.Fireball:Info() 
					or 
					FirestarterActiveStatus(unit) 
					or
					A.Pyroblast:IsSpellInFlight()
				)
			)
			then
                return A.Pyroblast:Show(icon)
            end
			
            -- phoenix_flames,if=charges>=3&active_enemies>2&!variable.phoenix_pooling
            if A.PhoenixFlames:IsReady(unit) and (A.PhoenixFlames:GetSpellCharges() >= 3 and MultiUnits:GetActiveEnemies() > 2 and not bool(VarPhoenixPooling)) then
                return A.PhoenixFlames:Show(icon)
            end
			
            -- pyroblast,if=buff.hot_streak.react&target.health.pct<=30&talent.searing_touch.enabled
            if A.Pyroblast:IsReady(unit) and (Unit(player):HasBuffs(A.HotStreakBuff.ID, true) > 0 and Unit(unit):HealthPercent() <= 30 and A.SearingTouch:IsSpellLearned()) 
			then
                return A.Pyroblast:Show(icon)
            end
			
            -- pyroblast,if=buff.pyroclasm.react&cast_time<buff.pyroclasm.remains
            if A.Pyroblast:IsReady(unit) and (Unit(player):HasBuffs(A.PyroclasmBuff.ID, true) > 0 and A.Pyroblast:GetSpellCastTime() < Unit(player):HasBuffs(A.PyroclasmBuff.ID, true)) 
			then
                return A.Pyroblast:Show(icon)
            end
			
            -- fire_blast,use_off_gcd=1,use_while_casting=1,if=((variable.time_to_combustion>0|variable.disable_combustion)&buff.rune_of_power.down&!firestarter.active)&!talent.kindling.enabled&!variable.fire_blast_pooling&(((Player:IsCasting() == A.Fireball:Info()|Player:IsCasting() == A.Pyroblast:Info())&(buff.heating_up.react))|(talent.searing_touch.enabled&target.health.pct<=30&(buff.heating_up.react&!Player:IsCasting() == A.Scorch:Info()|!buff.hot_streak.react&!buff.heating_up.react&Player:IsCasting() == A.Scorch:Info()&!action.pyroblast.in_flight&!action.fireball.in_flight)))
            if A.FireBlast:IsReadyByPassCastGCD(unit) and A.LastPlayerCastID ~= A.FireBlast.ID and 
			(
			    (
				    (
					    VarTimeToCombustion > 0 
						or 
						VarDisableCombustion
					)
					and Unit(player):HasBuffs(A.RuneofPowerBuff.ID, true) == 0 and not FirestarterActiveStatus(unit)
				)
				and not A.Kindling:IsSpellLearned() and not bool(VarFireBlastPooling) and 
				(
				    (
					    (
						    Player:IsCasting() == A.Fireball:Info() 
						    or 
						    Player:IsCasting() == A.Pyroblast:Info()
						)
						and Unit(player):HasBuffs(A.HeatingUpBuff.ID, true) > 0
					)
					or 
					(
					    A.SearingTouch:IsSpellLearned() and Unit(unit):HealthPercent() <= 30 and 
						(
						    Unit(player):HasBuffs(A.HeatingUpBuff.ID, true) > 0 and not Player:IsCasting() == A.Scorch:Info() 
							or 
							Unit(player):HasBuffs(A.HotStreakBuff.ID, true) == 0 and 
							Unit(player):HasBuffs(A.HeatingUpBuff.ID, true) == 0 and 
							Player:IsCasting() == A.Scorch:Info() and 
							not A.Pyroblast:IsSpellInFlight() and 
							not A.Fireball:IsSpellInFlight()
						)
					)
				)
			)
			then
                return A.FireBlast:Show(icon)
            end
			
            -- fire_blast,if=talent.kindling.enabled&buff.heating_up.react&!firestarter.active&(variable.time_to_combustion>full_recharge_time+2+talent.kindling.enabled|variable.disable_combustion|(!talent.rune_of_power.enabled|cooldown.rune_of_power.remains>target.time_to_die&action.rune_of_power.charges<1)&variable.time_to_combustion>target.time_to_die)
            if A.FireBlast:IsReadyByPassCastGCD(unit) and A.LastPlayerCastID ~= A.FireBlast.ID  and 
			(
			    A.Kindling:IsSpellLearned() and Unit(player):HasBuffs(A.HeatingUpBuff.ID, true) > 0 and not FirestarterActiveStatus(unit) and 
				(
				    VarTimeToCombustion > A.FireBlast:GetSpellChargesFullRechargeTime() + 2 + num(A.Kindling:IsSpellLearned()) 
					or 
					VarDisableCombustion 
					or 
					(
					    not A.RuneofPower:IsSpellLearned() 
						or 
						A.RuneofPower:GetCooldown() > Unit(unit):TimeToDie() and A.RuneofPower:GetSpellCharges() < 1
					)
					and VarTimeToCombustion > Unit(unit):TimeToDie()
				)
			)
			then
                return A.FireBlast:Show(icon)
            end
			
            -- pyroblast,if=prev_gcd.1.scorch&buff.heating_up.up&talent.searing_touch.enabled&target.health.pct<=30&((talent.flame_patch.enabled&active_enemies=1&!firestarter.active)|(active_enemies<4&!talent.flame_patch.enabled))
            if A.Pyroblast:IsReady(unit) and 
			(
			    A.LastPlayerCastName == A.Scorch:Info() and Unit(player):HasBuffs(A.HeatingUpBuff.ID, true) > 0 and A.SearingTouch:IsSpellLearned() and Unit(unit):HealthPercent() <= 30 and 
				(
				    (A.FlamePatch:IsSpellLearned() and MultiUnits:GetActiveEnemies() == 1 and not FirestarterActiveStatus(unit)) 
					or 
					(MultiUnits:GetActiveEnemies() < 4 and not A.FlamePatch:IsSpellLearned())
				)
			)
			then
                return A.Pyroblast:Show(icon)
            end
			
            -- phoenix_flames,if=(buff.heating_up.react|(!buff.hot_streak.react&(action.fire_blast.charges>0|talent.searing_touch.enabled&target.health.pct<=30)))&!variable.phoenix_pooling
            if A.PhoenixFlames:IsReady(unit) and 
			(
			    (
				    Unit(player):HasBuffs(A.HeatingUpBuff.ID, true) > 0 
				    or 
				    (
				        Unit(player):HasBuffs(A.HotStreakBuff.ID, true) == 0 and (A.FireBlast:GetSpellCharges() > 0 
				    	or 
					    A.SearingTouch:IsSpellLearned() and Unit(unit):HealthPercent() <= 30)
				    )
			    )
			    and not bool(VarPhoenixPooling)
			)
			then
                return A.PhoenixFlames:Show(icon)
            end
			
            -- call_action_list,name=active_talents
            if ActiveTalents(unit) then
                return true
            end
			
            -- dragons_breath,if=active_enemies>1
            if A.DragonsBreath:IsReady(unit) and Unit(unit):GetRange() <= 10 and MultiUnits:GetActiveEnemies() > 1 then
                return A.DragonsBreath:Show(icon)
            end
			
            -- call_action_list,name=items_low_priority
            if ItemsLowPriority(unit) then
                return true
            end
			
            -- scorch,if=target.health.pct<=30&talent.searing_touch.enabled
            if A.Scorch:IsReady(unit) and (Unit(unit):HealthPercent() <= 30 and A.SearingTouch:IsSpellLearned()) then
                return A.Scorch:Show(icon)
            end
			
            -- fire_blast,use_off_gcd=1,use_while_casting=1,if=!variable.fire_blast_pooling&(talent.flame_patch.enabled&active_enemies>2|active_enemies>9)&((variable.time_to_combustion>0|variable.disable_combustion)&!firestarter.active)&buff.hot_streak.down&(!azerite.blaster_master.enabled|buff.blaster_master.remains<0.5)
            if A.FireBlast:IsReadyByPassCastGCD(unit) and A.LastPlayerCastID ~= A.FireBlast.ID and 
			(
			    not bool(VarFireBlastPooling) and 
				(
				    A.FlamePatch:IsSpellLearned() and MultiUnits:GetActiveEnemies() > 2 
					or 
					MultiUnits:GetActiveEnemies() > 9
				)
				and 
				(
				    (
					    VarTimeToCombustion > 0 
						or 
						VarDisableCombustion
					)
					and not FirestarterActiveStatus(unit)
				)
				and Unit(player):HasBuffs(A.HotStreakBuff.ID, true) == 0 and 
				(
				    A.BlasterMaster:GetAzeriteRank() == 0 
					or 
					Unit(player):HasBuffs(A.BlasterMasterBuff.ID, true) < 0.5
				)
			)
			then
                return A.FireBlast:Show(icon)
            end
			
            -- flamestrike,if=talent.flame_patch.enabled&active_enemies>2|active_enemies>9
            if A.Flamestrike:IsReady(player) and (A.FlamePatch:IsSpellLearned() and MultiUnits:GetActiveEnemies() > 2 or MultiUnits:GetActiveEnemies() > 9) then
                return A.Flamestrike:Show(icon)
            end
			
            -- fireball
            if A.Fireball:IsReady(unit) and not isMoving then
                return A.Fireball:Show(icon)
            end
			
            -- scorch
            if A.Scorch:IsReady(unit) and isMoving then
                return A.Scorch:Show(icon)
            end
			
        end
        
        -- In Combat
        if inCombat and Unit(unit):IsExists() then

            -- #1 Custom Rop
			if A.RuneofPower:IsReady("player") and A.LastPlayerCastID == A.Fireball.ID and Unit("player"):CombatTime() <= 1.5 and A.BurstIsON(unit) then
				return A.RuneofPower:Show(icon)
			end
			
			-- #2 Custom FireBlast
			if A.FireBlast:IsReadyByPassCastGCD(unit) and Unit("player"):HasBuffs(A.RuneofPowerBuff.ID, true) > 0 and not A.LastPlayerCastID == A.FireBlast.ID and (A.LastPlayerCastID == A.RuneofPower.ID or A.RuneofPower:GetSpellTimeSinceLastCast() <= 2) then
                return A.FireBlast:Show(icon)
			end	
			
			-- #3 Custom Meteor
			if A.Meteor:IsReady("player") and A.Meteor:IsSpellLearned() and Unit("player"):HasBuffs(A.RuneofPowerBuff.ID, true) > 0 and A.LastPlayerCastID == A.FireBlast.ID then
			    return A.Meteor:Show(icon)
			end
			
			-- #4 Custom Combustion
			if A.Combustion:IsReady("player") and Unit("player"):HasBuffs(A.RuneofPowerBuff.ID, true) > 0 and A.LastPlayerCastID == A.Meteor.ID then
			    return A.Combustion:Show(icon)
			end
			
			-- counterspell
            -- variable,name=time_to_combustion,op=set,value=cooldown.combustion.remains
            if (true) then
                VarTimeToCombustion = A.Combustion:GetCooldown()
            end
			
            -- variable,name=time_to_combustion,op=max,value=cooldown.memory_of_lucid_dreams.remains,if=essence.memory_of_lucid_dreams.major&buff.memory_of_lucid_dreams.down&cooldown.memory_of_lucid_dreams.remains-cooldown.combustion.remains<=variable.hold_combustion_threshold
            if (Azerite:EssenceHasMajor(A.MemoryofLucidDreams.ID) and Unit(player):HasBuffs(A.MemoryofLucidDreams.ID, true) == 0 and A.MemoryofLucidDreams:GetCooldown() - A.Combustion:GetCooldown() <= VarHoldCombustionThreshold) then
                VarTimeToCombustion = math.max(VarTimeToCombustion, A.MemoryofLucidDreams:GetCooldown())
            end
			
            -- variable,name=time_to_combustion,op=max,value=cooldown.worldvein_resonance.remains,if=essence.worldvein_resonance.major&buff.worldvein_resonance.down&cooldown.worldvein_resonance.remains-cooldown.combustion.remains<=variable.hold_combustion_threshold
            if (bool(Azerite:EssenceHasMajor(A.WorldveinResonance.ID)) and Unit(player):HasBuffs(A.WorldveinResonance.ID, true) == 0 and A.WorldveinResonance:GetCooldown() - A.Combustion:GetCooldown() <= VarHoldCombustionThreshold) then
                VarTimeToCombustion = math.max(VarTimeToCombustion, A.WorldveinResonance:GetCooldown())
            end
			
            -- call_action_list,name=items_high_priority
            if ItemsHighPriority(unit) then
                return true
            end
			
            -- mirror_image,if=buff.combustion.down
            if A.MirrorImage:IsReady(player) and (Unit(player):HasBuffs(A.CombustionBuff.ID, true) == 0) then
                return A.MirrorImage:Show(icon)
            end
			
            -- guardian_of_azeroth,if=(variable.time_to_combustion<10|target.time_to_die<variable.time_to_combustion)&!variable.disable_combustion
            if A.GuardianofAzeroth:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") and ((VarTimeToCombustion < 10 or Unit(unit):TimeToDie() < VarTimeToCombustion) and not VarDisableCombustion) then
                return A.GuardianofAzeroth:Show(icon)
            end
			
            -- concentrated_flame
            if A.ConcentratedFlame:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") then
                return A.ConcentratedFlame:Show(icon)
            end
			
            -- reaping_flames
            if A.ReapingFlames:AutoHeartOfAzerothP(unit, true) then
                return A.ReapingFlames:Show(icon)
            end
			
            -- focused_azerite_beam
            if A.FocusedAzeriteBeam:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") then
                return A.FocusedAzeriteBeam:Show(icon)
            end
			
            -- purifying_blast
            if A.PurifyingBlast:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") then
                return A.PurifyingBlast:Show(icon)
            end
			
            -- ripple_in_space
            if A.RippleinSpace:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") then
                return A.RippleinSpace:Show(icon)
            end
			
            -- the_unbound_force
            if A.TheUnboundForce:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") then
                return A.TheUnboundForce:Show(icon)
            end
			
            -- rune_of_power,if=talent.firestarter.enabled&firestarter.remains>full_recharge_time|variable.time_to_combustion>variable.combustion_rop_cutoff&buff.combustion.down|target.time_to_die<variable.time_to_combustion&buff.combustion.down|variable.disable_combustion
            if A.RuneofPower:IsReady(player) and 
			(
			    A.Firestarter:IsSpellLearned() and FirestarterActiveRemains(unit) > A.RuneofPower:GetSpellChargesFullRechargeTime() 
				or 
				VarTimeToCombustion > VarCombustionRopCutoff and Unit(player):HasBuffs(A.CombustionBuff.ID, true) == 0 
				or 
				Unit(unit):TimeToDie() < VarTimeToCombustion and Unit(player):HasBuffs(A.CombustionBuff.ID, true) == 0 
				or 
				VarDisableCombustion
			)
			then
                return A.RuneofPower:Show(icon)
            end
			
            -- call_action_list,name=combustion_phase,if=!variable.disable_combustion&(talent.rune_of_power.enabled&variable.time_to_combustion<=action.rune_of_power.cast_time|variable.time_to_combustion<=0)&!firestarter.active|buff.combustion.up
            if CombustionPhase(unit) and A.BurstIsON(unit) and 
			(
			    --not VarDisableCombustion and 
				(
				    A.RuneofPower:IsSpellLearned() and VarTimeToCombustion <= A.RuneofPower:GetSpellCastTime() 
					or 
					VarTimeToCombustion <= 0
				)
				and not FirestarterActiveStatus(unit) 
				or 
				Unit(player):HasBuffs(A.CombustionBuff.ID, true) > 0
			)
			then
                return true
            end

            -- FireBlast
            if A.FireBlast:IsReadyByPassCastGCD(unit) and 
			Unit(player):HasBuffs(A.HotStreakBuff.ID, true) == 0 and 
			Unit(player):HasBuffs(A.HeatingUpBuff.ID, true) > 0 and 
			not A.LastPlayerCastID == A.FireBlast.ID and 
			Unit("player"):HasBuffs(A.CombustionBuff.ID, true) == 0	and		
			(
			    Player:CastRemains(A.Fireball.ID) >= A.GetLatency() --and Player:CastRemains(A.Fireball.ID) < A.GetGCD() + A.Fireball:TravelTime() + 0.1 
				or 
				Player:CastRemains(A.Scorch.ID) >= A.GetLatency() --and Player:CastRemains(A.Scorch.ID) < A.GetGCD() + 0.1
			)
			then
                return A.FireBlast:Show(icon)
            end 
			
			-- FireBlast fallback
			if A.FireBlast:IsReadyByPassCastGCD(unit) and A.LastPlayerCastID ~= A.FireBlast.ID and 
			(
				Unit(player):HasBuffs(A.CombustionBuff.ID, true) > 0 and
				(
				    Player:CastRemains(A.Scorch.ID) >= A.GetLatency() and Player:CastRemains(A.Scorch.ID) < A.GetGCD() + 0.1 and Unit(player):HasBuffs(A.HeatingUpBuff.ID, true) == 0
					or
					not Player:IsCasting() and Unit(player):HasBuffs(A.HeatingUpBuff.ID, true) > 0 and Unit(player):HasBuffs(A.HeatingUpBuff.ID, true) <= A.GetGCD() + A.GetLatency()
				)	
                or
                Player:IsCasting(A.Fireball.ID) and Unit(player):HasBuffs(A.HeatingUpBuff.ID, true) > 0	
                or
				(
                    Unit(player):HasBuffs(A.HeatingUpBuff.ID, true) > 0	and 
				    A.LastPlayerCastName == A.Pyroblast:Info() and 
				    A.Pyroblast:GetSpellTimeSinceLastCast() < A.GetGCD() + A.GetLatency() 
                )				
			)			
			then
                return A.FireBlast:Show(icon)
            end			
			
            -- fire_blast,use_while_casting=1,use_off_gcd=1,if=(essence.memory_of_lucid_dreams.major|essence.memory_of_lucid_dreams.minor&azerite.blaster_master.enabled)&charges=max_charges&!buff.hot_streak.react&!(buff.heating_up.react&(buff.combustion.up&(action.fireball.in_flight|action.pyroblast.in_flight|Player:IsCasting() == A.Scorch:Info())|target.health.pct<=30&Player:IsCasting() == A.Scorch:Info()))&!(!buff.heating_up.react&!buff.hot_streak.react&buff.combustion.down&(action.fireball.in_flight|action.pyroblast.in_flight))
            if A.FireBlast:IsReadyByPassCastGCD(unit) and A.LastPlayerCastID ~= A.FireBlast.ID and 
			(
			    (
				    Azerite:EssenceHasMajor(A.MemoryofLucidDreams.ID) 
					or
					Azerite:EssenceHasMinor(A.MemoryofLucidDreams.ID) and A.BlasterMaster:GetAzeriteRank() > 0
				)
				and A.FireBlast:GetSpellCharges() == A.FireBlast:GetSpellChargesMax() and Unit(player):HasBuffs(A.HotStreakBuff.ID, true) == 0 and not 
				(
				    Unit(player):HasBuffs(A.HeatingUpBuff.ID, true) > 0 and 
					(
					    Unit(player):HasBuffs(A.CombustionBuff.ID, true) > 0 and 
						(
						    A.Fireball:IsSpellInFlight() 
							or 
							A.Pyroblast:IsSpellInFlight() 
							or 
							Player:IsCasting() == A.Scorch:Info()
						)
						or Unit(unit):HealthPercent() <= 30 and Player:IsCasting() == A.Scorch:Info()
					)
				) and not 
				(
				    Unit(player):HasBuffs(A.HeatingUpBuff.ID, true) == 0 and Unit(player):HasBuffs(A.HotStreakBuff.ID, true) == 0 and Unit(player):HasBuffs(A.CombustionBuff.ID, true) == 0 and 
					(
					    A.Fireball:IsSpellInFlight() 
						or 
						A.Pyroblast:IsSpellInFlight()
					)
				)
			)
			then
                return A.FireBlast:Show(icon)
            end
			
            -- fire_blast,use_while_casting=1,use_off_gcd=1,if=firestarter.active&charges>=1&(!variable.fire_blast_pooling|buff.rune_of_power.up)&(!azerite.blaster_master.enabled|buff.blaster_master.remains<0.5)&(!Player:IsCasting() == A.Fireball:Info()&!action.pyroblast.in_flight&buff.heating_up.up|Player:IsCasting() == A.Fireball:Info()&buff.hot_streak.down|action.pyroblast.in_flight&buff.heating_up.down&buff.hot_streak.down)
            if A.FireBlast:IsReadyByPassCastGCD(unit) and A.LastPlayerCastID ~= A.FireBlast.ID and 
			(
			    FirestarterActiveStatus(unit) and A.FireBlast:GetSpellCharges() >= 1 and 
				(
				    not bool(VarFireBlastPooling) 
					or 
					Unit(player):HasBuffs(A.RuneofPowerBuff.ID, true) > 0
				)
				and 
				(
				    A.BlasterMaster:GetAzeriteRank() == 0 
					or 
					Unit(player):HasBuffs(A.BlasterMasterBuff.ID, true) < 0.5
				)
				and 
				(
				    not Player:IsCasting() == A.Fireball:Info() and not A.Pyroblast:IsSpellInFlight() and Unit(player):HasBuffs(A.HeatingUpBuff.ID, true) > 0 
					or 
					Player:IsCasting() == A.Fireball:Info() and Unit(player):HasBuffs(A.HotStreakBuff.ID, true) == 0 
					or 
					A.Pyroblast:IsSpellInFlight() and Unit(player):HasBuffs(A.HeatingUpBuff.ID, true) == 0 and Unit(player):HasBuffs(A.HotStreakBuff.ID, true) == 0
				)
			)
			then
                return A.FireBlast:Show(icon)
            end
			
            -- call_action_list,name=rop_phase,if=buff.rune_of_power.up&buff.combustion.down
            if RopPhase(unit) and (Unit(player):HasBuffs(A.RuneofPowerBuff.ID, true) > 0 and Unit(player):HasBuffs(A.CombustionBuff.ID, true) == 0) then
                return true
            end
						
            -- call_action_list,name=standard_rotation
            if StandardRotation(unit) then
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

