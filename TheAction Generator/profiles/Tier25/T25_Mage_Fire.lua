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

Action[ACTION_CONST_MAGE_FIRE] = {
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
    ArcaneIntellectBuff                    = Create({ Type = "Spell", ID = 1459 }),
    ArcaneIntellect                        = Create({ Type = "Spell", ID = 1459 }),
    Firestarter                            = Create({ Type = "Spell", ID = 205026 }),
    FlamePatch                             = Create({ Type = "Spell", ID = 205037 }),
    MirrorImage                            = Create({ Type = "Spell", ID = 55342 }),
    Pyroblast                              = Create({ Type = "Spell", ID = 11366 }),
    LivingBomb                             = Create({ Type = "Spell", ID = 44457 }),
    CombustionBuff                         = Create({ Type = "Spell", ID = 190319 }),
    Meteor                                 = Create({ Type = "Spell", ID = 153561 }),
    RuneofPowerBuff                        = Create({ Type = "Spell", ID = 116014 }),
    RuneofPower                            = Create({ Type = "Spell", ID = 116011 }),
    DragonsBreath                          = Create({ Type = "Spell", ID = 31661 }),
    AlexstraszasFury                       = Create({ Type = "Spell", ID = 235870 }),
    HotStreakBuff                          = Create({ Type = "Spell", ID = 48108 }),
    FireBlast                              = Create({ Type = "Spell", ID = 108853 }),
    LightsJudgment                         = Create({ Type = "Spell", ID = 255647 }),
    BagofTricks                            = Create({ Type = "Spell", ID =  }),
    BlasterMasterBuff                      = Create({ Type = "Spell", ID = 274598 }),
    BlasterMaster                          = Create({ Type = "Spell", ID = 274596 }),
    FlameOn                                = Create({ Type = "Spell", ID = 205029 }),
    HyperthreadWristwraps300142            = Create({ Type = "Spell", ID =  }),
    Scorch                                 = Create({ Type = "Spell", ID = 2948 }),
    HeatingUpBuff                          = Create({ Type = "Spell", ID = 48107 }),
    Fireball                               = Create({ Type = "Spell", ID = 133 }),
    Combustion                             = Create({ Type = "Spell", ID = 190319 }),
    BloodFury                              = Create({ Type = "Spell", ID = 20572 }),
    Berserking                             = Create({ Type = "Spell", ID = 26297 }),
    Fireblood                              = Create({ Type = "Spell", ID = 265221 }),
    AncestralCall                          = Create({ Type = "Spell", ID = 274738 }),
    Flamestrike                            = Create({ Type = "Spell", ID = 2120 }),
    PyroclasmBuff                          = Create({ Type = "Spell", ID = 269651 }),
    PhoenixFlames                          = Create({ Type = "Spell", ID = 257541 }),
    SearingTouch                           = Create({ Type = "Spell", ID = 269644 }),
    ManifestoofMadnessChapterOneBuff       = Create({ Type = "Spell", ID =  }),
    Kindling                               = Create({ Type = "Spell", ID = 155148 }),
    WorldveinResonanceBuff                 = Create({ Type = "Spell", ID =  }),
    ReapingFlames                          = Create({ Type = "Spell", ID =  }),
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
Action:CreateEssencesFor(ACTION_CONST_MAGE_FIRE)  -- where PLAYERSPEC is Constance (example: ACTION_CONST_MONK_BM)
local A = setmetatable(Action[ACTION_CONST_MAGE_FIRE], { __index = Action })


------------------------------------------
---------------- VARIABLES ---------------
------------------------------------------
local VarDisableCombustion = 0;
local VarCombustionOnUse = 0;
local VarFontDoubleOnUse = 0;
local VarFontofPowerPrecombatChannel = 0;
local VarOnUseCutoff = 0;
local VarHoldCombustionThreshold = 20;
local VarHotStreakFlamestrike = 0;
local VarHardCastFlamestrike = 0;
local VarDelayFlamestrike = 25;
local VarKindlingReduction = 0.2;
local VarTimeToCombustion = 0;
local VarPhoenixPooling = 0;
local VarFireBlastPooling = 0;

A.Listener:Add("ROTATION_VARS", "PLAYER_REGEN_ENABLED", function()
  VarDisableCombustion = 0
  VarCombustionOnUse = 0
  VarFontDoubleOnUse = 0
  VarFontofPowerPrecombatChannel = 0
  VarOnUseCutoff = 0
  VarHoldCombustionThreshold = 20
  VarHotStreakFlamestrike = 0
  VarHardCastFlamestrike = 0
  VarDelayFlamestrike = 25
  VarKindlingReduction = 0.2
  VarTimeToCombustion = 0
  VarPhoenixPooling = 0
  VarFireBlastPooling = 0
end)



local function num(val)
    if val then return 1 else return 0 end
end

local function bool(val)
    return val ~= 0
end

------------------------------------------
----------- FIRE PRE APL SETUP -----------
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
            -- arcane_intellect
            if A.ArcaneIntellect:IsReady(unit) and Unit("player"):HasBuffsDown(A.ArcaneIntellectBuff.ID, true, true) then
                return A.ArcaneIntellect:Show(icon)
            end
            
            -- variable,name=disable_combustion,op=reset
            VarDisableCombustion = 0
            
            -- variable,name=combustion_on_use,op=set,value=equipped.manifesto_of_madness|equipped.gladiators_badge|equipped.gladiators_medallion|equipped.ignition_mages_fuse|equipped.tzanes_barkspines|equipped.azurethos_singed_plumage|equipped.ancient_knot_of_wisdom|equipped.shockbiters_fang|equipped.neural_synapse_enhancer|equipped.balefire_branch
            VarCombustionOnUse = num(A.ManifestoofMadness:IsExists() or A.GladiatorsBadge:IsExists() or A.GladiatorsMedallion:IsExists() or A.IgnitionMagesFuse:IsExists() or A.TzanesBarkspines:IsExists() or A.AzurethosSingedPlumage:IsExists() or A.AncientKnotofWisdom:IsExists() or A.ShockbitersFang:IsExists() or A.NeuralSynapseEnhancer:IsExists() or A.BalefireBranch:IsExists())
            
            -- variable,name=font_double_on_use,op=set,value=equipped.azsharas_font_of_power&variable.combustion_on_use
            VarFontDoubleOnUse = num(A.AzsharasFontofPower:IsExists() and VarCombustionOnUse)
            
            -- variable,name=font_of_power_precombat_channel,op=set,value=18,if=variable.font_double_on_use&!talent.firestarter.enabled&variable.font_of_power_precombat_channel=0
            if (VarFontDoubleOnUse and not A.Firestarter:IsSpellLearned() and VarFontofPowerPrecombatChannel == 0) then
                VarFontofPowerPrecombatChannel = 18
            end
            
            -- variable,name=on_use_cutoff,op=set,value=20*variable.combustion_on_use&!variable.font_double_on_use+40*variable.font_double_on_use+25*equipped.azsharas_font_of_power&!variable.font_double_on_use+8*equipped.manifesto_of_madness&!variable.font_double_on_use
            VarOnUseCutoff = num(20 * VarCombustionOnUse and num(not VarFontDoubleOnUse) + 40 * VarFontDoubleOnUse + 25 * num(A.AzsharasFontofPower:IsExists()) and num(not VarFontDoubleOnUse) + 8 * num(A.ManifestoofMadness:IsExists()) and not VarFontDoubleOnUse)
            
            -- variable,name=hold_combustion_threshold,op=reset,default=20
            VarHoldCombustionThreshold = 20
            
            -- variable,name=hot_streak_flamestrike,op=set,if=variable.hot_streak_flamestrike=0,value=2*talent.flame_patch.enabled+99*!talent.flame_patch.enabled
            if (VarHotStreakFlamestrike == 0) then
                VarHotStreakFlamestrike = 2 * num(A.FlamePatch:IsSpellLearned()) + 99 * num(not A.FlamePatch:IsSpellLearned())
            end
            
            -- variable,name=hard_cast_flamestrike,op=set,if=variable.hard_cast_flamestrike=0,value=3*talent.flame_patch.enabled+99*!talent.flame_patch.enabled
            if (VarHardCastFlamestrike == 0) then
                VarHardCastFlamestrike = 3 * num(A.FlamePatch:IsSpellLearned()) + 99 * num(not A.FlamePatch:IsSpellLearned())
            end
            
            -- variable,name=delay_flamestrike,default=25,op=reset
            VarDelayFlamestrike = 25
            
            -- variable,name=kindling_reduction,default=0.2,op=reset
            VarKindlingReduction = 0.2
            
            -- snapshot_stats
            -- use_item,name=azsharas_font_of_power,if=!variable.disable_combustion
            if A.AzsharasFontofPower:IsReady(unit) and (not VarDisableCombustion) then
                return A.AzsharasFontofPower:Show(icon)
            end
            
            -- mirror_image
            if A.MirrorImage:IsReady(unit) then
                return A.MirrorImage:Show(icon)
            end
            
            -- potion
            if A.PotionofSpectralIntellect:IsReady(unit) and Potion then
                return A.PotionofSpectralIntellect:Show(icon)
            end
            
            -- pyroblast
            if A.Pyroblast:IsReady(unit) and inCombat and Unit(unit):IsExists() and unit ~= "mouseover" then
                return A.Pyroblast:Show(icon)
            end
            
        end
        
        --ActiveTalents
        local function ActiveTalents(unit)
        
            -- living_bomb,if=active_enemies>1&buff.combustion.down&(variable.time_to_combustion>cooldown.living_bomb.duration|variable.time_to_combustion<=0|variable.disable_combustion)
            if A.LivingBomb:IsReady(unit) and (MultiUnits:GetByRangeInCombat(40, 5, 10) > 1 and Unit("player"):HasBuffsDown(A.CombustionBuff.ID, true) and (VarTimeToCombustion > A.LivingBomb:BaseDuration() or VarTimeToCombustion <= 0 or VarDisableCombustion)) then
                return A.LivingBomb:Show(icon)
            end
            
            -- meteor,if=!variable.disable_combustion&variable.time_to_combustion<=0|(buff.rune_of_power.up|cooldown.rune_of_power.remains>target.time_to_die&action.rune_of_power.charges<1|!talent.rune_of_power.enabled)&(cooldown.meteor.duration<variable.time_to_combustion|target.time_to_die<variable.time_to_combustion|variable.disable_combustion)
            if A.Meteor:IsReady(unit) and (not VarDisableCombustion and VarTimeToCombustion <= 0 or (Unit("player"):HasBuffs(A.RuneofPowerBuff.ID, true) or A.RuneofPower:GetCooldown() > Unit(unit):TimeToDie() and A.RuneofPower:GetSpellCharges() < 1 or not A.RuneofPower:IsSpellLearned()) and (A.Meteor:BaseDuration() < VarTimeToCombustion or Unit(unit):TimeToDie() < VarTimeToCombustion or VarDisableCombustion)) then
                return A.Meteor:Show(icon)
            end
            
            -- dragons_breath,if=talent.alexstraszas_fury.enabled&(buff.combustion.down&!buff.hot_streak.react|buff.combustion.up&action.fire_blast.charges<action.fire_blast.max_charges&!buff.hot_streak.react)
            if A.DragonsBreath:IsReady(unit) and (A.AlexstraszasFury:IsSpellLearned() and (Unit("player"):HasBuffsDown(A.CombustionBuff.ID, true) and not Unit("player"):HasBuffsStacks(A.HotStreakBuff.ID, true) or Unit("player"):HasBuffs(A.CombustionBuff.ID, true) and A.FireBlast:GetSpellCharges() < A.FireBlast:GetSpellChargesMax() and not Unit("player"):HasBuffsStacks(A.HotStreakBuff.ID, true))) then
                return A.DragonsBreath:Show(icon)
            end
            
        end
        
        --CombustionPhase
        local function CombustionPhase(unit)
        
            -- lights_judgment,if=buff.combustion.down
            if A.LightsJudgment:IsReady(unit) and A.BurstIsON(unit) and (Unit("player"):HasBuffsDown(A.CombustionBuff.ID, true)) then
                return A.LightsJudgment:Show(icon)
            end
            
            -- bag_of_tricks,if=buff.combustion.down
            if A.BagofTricks:IsReady(unit) and (Unit("player"):HasBuffsDown(A.CombustionBuff.ID, true)) then
                return A.BagofTricks:Show(icon)
            end
            
            -- living_bomb,if=active_enemies>1&buff.combustion.down
            if A.LivingBomb:IsReady(unit) and (MultiUnits:GetByRangeInCombat(40, 5, 10) > 1 and Unit("player"):HasBuffsDown(A.CombustionBuff.ID, true)) then
                return A.LivingBomb:Show(icon)
            end
            
            -- blood_of_the_enemy
            if A.BloodoftheEnemy:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth then
                return A.BloodoftheEnemy:Show(icon)
            end
            
            -- memory_of_lucid_dreams
            if A.MemoryofLucidDreams:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth then
                return A.MemoryofLucidDreams:Show(icon)
            end
            
            -- worldvein_resonance
            if A.WorldveinResonance:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth then
                return A.WorldveinResonance:Show(icon)
            end
            
            -- fire_blast,use_off_gcd=1,use_while_casting=1,if=charges>=1&((action.fire_blast.charges_fractional+(buff.combustion.remains-buff.blaster_master.duration)%cooldown.fire_blast.duration-(buff.combustion.remains)%(buff.blaster_master.duration-0.5))>=0|!azerite.blaster_master.enabled|!talent.flame_on.enabled|buff.combustion.remains<=buff.blaster_master.duration|buff.blaster_master.remains<0.5|equipped.hyperthread_wristwraps&cooldown.hyperthread_wristwraps_300142.remains<5)&buff.combustion.up&(!action.scorch.executing&!action.pyroblast.in_flight&buff.heating_up.up|action.scorch.executing&buff.hot_streak.down&(buff.heating_up.down|azerite.blaster_master.enabled)|azerite.blaster_master.enabled&talent.flame_on.enabled&action.pyroblast.in_flight&buff.heating_up.down&buff.hot_streak.down)
            if A.FireBlast:IsReady(unit) and (A.FireBlast:GetSpellCharges() >= 1 and ((A.FireBlast:GetSpellChargesFrac() + (Unit("player"):HasBuffs(A.CombustionBuff.ID, true) - A.BlasterMasterBuff.ID, true:BaseDuration()) / A.FireBlast:BaseDuration() - (Unit("player"):HasBuffs(A.CombustionBuff.ID, true)) / (A.BlasterMasterBuff.ID, true:BaseDuration() - 0.5)) >= 0 or not A.BlasterMaster:GetAzeriteRank() > 0 or not A.FlameOn:IsSpellLearned() or Unit("player"):HasBuffs(A.CombustionBuff.ID, true) <= A.BlasterMasterBuff.ID, true:BaseDuration() or Unit("player"):HasBuffs(A.BlasterMasterBuff.ID, true) < 0.5 or A.HyperthreadWristwraps:IsExists() and A.HyperthreadWristwraps300142:GetCooldown() < 5) and Unit("player"):HasBuffs(A.CombustionBuff.ID, true) and (not action.scorch.executing and not A.Pyroblast:IsSpellInFlight() and Unit("player"):HasBuffs(A.HeatingUpBuff.ID, true) or action.scorch.executing and Unit("player"):HasBuffsDown(A.HotStreakBuff.ID, true) and (Unit("player"):HasBuffsDown(A.HeatingUpBuff.ID, true) or A.BlasterMaster:GetAzeriteRank() > 0) or A.BlasterMaster:GetAzeriteRank() > 0 and A.FlameOn:IsSpellLearned() and A.Pyroblast:IsSpellInFlight() and Unit("player"):HasBuffsDown(A.HeatingUpBuff.ID, true) and Unit("player"):HasBuffsDown(A.HotStreakBuff.ID, true))) then
                return A.FireBlast:Show(icon)
            end
            
            -- rune_of_power,if=buff.rune_of_power.down&buff.combustion.down
            if A.RuneofPower:IsReady(unit) and (Unit("player"):HasBuffsDown(A.RuneofPowerBuff.ID, true) and Unit("player"):HasBuffsDown(A.CombustionBuff.ID, true)) then
                return A.RuneofPower:Show(icon)
            end
            
            -- fire_blast,use_while_casting=1,if=azerite.blaster_master.enabled&(essence.memory_of_lucid_dreams.major|!essence.memory_of_lucid_dreams.minor)&talent.meteor.enabled&talent.flame_on.enabled&buff.blaster_master.down&(talent.rune_of_power.enabled&action.rune_of_power.executing&action.rune_of_power.execute_remains<0.6|(variable.time_to_combustion<=0|buff.combustion.up)&!talent.rune_of_power.enabled&!action.pyroblast.in_flight&!action.fireball.in_flight)
            if A.FireBlast:IsReady(unit) and (A.BlasterMaster:GetAzeriteRank() > 0 and (Azerite:EssenceHasMajor(A.MemoryofLucidDreams.ID) or not Azerite:EssenceHasMinor(A.MemoryofLucidDreams.ID)) and A.Meteor:IsSpellLearned() and A.FlameOn:IsSpellLearned() and Unit("player"):HasBuffsDown(A.BlasterMasterBuff.ID, true) and (A.RuneofPower:IsSpellLearned() and action.rune_of_power.executing and action.rune_of_power.execute_remains < 0.6 or (VarTimeToCombustion <= 0 or Unit("player"):HasBuffs(A.CombustionBuff.ID, true)) and not A.RuneofPower:IsSpellLearned() and not A.Pyroblast:IsSpellInFlight() and not A.Fireball:IsSpellInFlight())) then
                return A.FireBlast:Show(icon)
            end
            
            -- call_action_list,name=active_talents
            if ActiveTalents(unit) then
                return true
            end
            
            -- combustion,use_off_gcd=1,use_while_casting=1,if=((action.meteor.in_flight&action.meteor.in_flight_remains<=0.5)|!talent.meteor.enabled&(essence.memory_of_lucid_dreams.major|buff.hot_streak.react|action.scorch.executing&action.scorch.execute_remains<0.5|action.pyroblast.executing&action.pyroblast.execute_remains<0.5))&(buff.rune_of_power.up|!talent.rune_of_power.enabled)
            if A.Combustion:IsReady(unit) and A.BurstIsON(unit) and (((A.Meteor:IsSpellInFlight() and action.meteor.in_flight_remains <= 0.5) or not A.Meteor:IsSpellLearned() and (Azerite:EssenceHasMajor(A.MemoryofLucidDreams.ID) or Unit("player"):HasBuffsStacks(A.HotStreakBuff.ID, true) or action.scorch.executing and action.scorch.execute_remains < 0.5 or action.pyroblast.executing and action.pyroblast.execute_remains < 0.5)) and (Unit("player"):HasBuffs(A.RuneofPowerBuff.ID, true) or not A.RuneofPower:IsSpellLearned())) then
                return A.Combustion:Show(icon)
            end
            
            -- potion
            if A.PotionofSpectralIntellect:IsReady(unit) and Potion then
                return A.PotionofSpectralIntellect:Show(icon)
            end
            
            -- blood_fury
            if A.BloodFury:AutoRacial(unit) and Racial and A.BurstIsON(unit) then
                return A.BloodFury:Show(icon)
            end
            
            -- berserking
            if A.Berserking:AutoRacial(unit) and Racial and A.BurstIsON(unit) then
                return A.Berserking:Show(icon)
            end
            
            -- fireblood
            if A.Fireblood:AutoRacial(unit) and Racial and A.BurstIsON(unit) then
                return A.Fireblood:Show(icon)
            end
            
            -- ancestral_call
            if A.AncestralCall:AutoRacial(unit) and Racial and A.BurstIsON(unit) then
                return A.AncestralCall:Show(icon)
            end
            
            -- flamestrike,if=((talent.flame_patch.enabled&active_enemies>2)|active_enemies>6)&buff.hot_streak.react&!azerite.blaster_master.enabled
            if A.Flamestrike:IsReady(unit) and (((A.FlamePatch:IsSpellLearned() and MultiUnits:GetByRangeInCombat(40, 5, 10) > 2) or MultiUnits:GetByRangeInCombat(40, 5, 10) > 6) and Unit("player"):HasBuffsStacks(A.HotStreakBuff.ID, true) and not A.BlasterMaster:GetAzeriteRank() > 0) then
                return A.Flamestrike:Show(icon)
            end
            
            -- pyroblast,if=buff.pyroclasm.react&buff.combustion.remains>cast_time
            if A.Pyroblast:IsReady(unit) and (Unit("player"):HasBuffsStacks(A.PyroclasmBuff.ID, true) and Unit("player"):HasBuffs(A.CombustionBuff.ID, true) > A.Pyroblast:GetSpellCastTime()) then
                return A.Pyroblast:Show(icon)
            end
            
            -- pyroblast,if=buff.hot_streak.react
            if A.Pyroblast:IsReady(unit) and (Unit("player"):HasBuffsStacks(A.HotStreakBuff.ID, true)) then
                return A.Pyroblast:Show(icon)
            end
            
            -- pyroblast,if=prev_gcd.1.scorch&buff.heating_up.up
            if A.Pyroblast:IsReady(unit) and (Player:PrevGCD(1, A.Scorch) and Unit("player"):HasBuffs(A.HeatingUpBuff.ID, true)) then
                return A.Pyroblast:Show(icon)
            end
            
            -- phoenix_flames
            if A.PhoenixFlames:IsReady(unit) then
                return A.PhoenixFlames:Show(icon)
            end
            
            -- scorch,if=buff.combustion.remains>cast_time&buff.combustion.up|buff.combustion.down&cooldown.combustion.remains<cast_time
            if A.Scorch:IsReady(unit) and (Unit("player"):HasBuffs(A.CombustionBuff.ID, true) > A.Scorch:GetSpellCastTime() and Unit("player"):HasBuffs(A.CombustionBuff.ID, true) or Unit("player"):HasBuffsDown(A.CombustionBuff.ID, true) and A.Combustion:GetCooldown() < A.Scorch:GetSpellCastTime()) then
                return A.Scorch:Show(icon)
            end
            
            -- living_bomb,if=buff.combustion.remains<gcd.max&active_enemies>1
            if A.LivingBomb:IsReady(unit) and (Unit("player"):HasBuffs(A.CombustionBuff.ID, true) < GetGCD() and MultiUnits:GetByRangeInCombat(40, 5, 10) > 1) then
                return A.LivingBomb:Show(icon)
            end
            
            -- dragons_breath,if=buff.combustion.remains<gcd.max&buff.combustion.up
            if A.DragonsBreath:IsReady(unit) and (Unit("player"):HasBuffs(A.CombustionBuff.ID, true) < GetGCD() and Unit("player"):HasBuffs(A.CombustionBuff.ID, true)) then
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
            if A.HyperthreadWristwraps:IsReady(unit) and (Unit("player"):HasBuffs(A.CombustionBuff.ID, true) and A.FireBlast:GetSpellCharges() == 0 and A.FireBlast:RechargeP() > GetGCD()) then
                return A.HyperthreadWristwraps:Show(icon)
            end
            
            -- use_item,name=manifesto_of_madness
            if A.ManifestoofMadness:IsReady(unit) then
                return A.ManifestoofMadness:Show(icon)
            end
            
            -- cancel_buff,use_off_gcd=1,name=manifesto_of_madness_chapter_one,if=buff.combustion.up|action.meteor.in_flight&action.meteor.in_flight_remains<=0.5
            if (Unit("player"):HasBuffs(A.CombustionBuff.ID, true) or A.Meteor:IsSpellInFlight() and action.meteor.in_flight_remains <= 0.5) then
                Player:CancelBuff(A.ManifestoofMadnessChapterOneBuff:Info())
            end
            
            -- use_item,use_off_gcd=1,name=azurethos_singed_plumage,if=buff.combustion.up|action.meteor.in_flight&action.meteor.in_flight_remains<=0.5
            if A.AzurethosSingedPlumage:IsReady(unit) and (Unit("player"):HasBuffs(A.CombustionBuff.ID, true) or A.Meteor:IsSpellInFlight() and action.meteor.in_flight_remains <= 0.5) then
                return A.AzurethosSingedPlumage:Show(icon)
            end
            
            -- use_item,use_off_gcd=1,effect_name=gladiators_badge,if=buff.combustion.up|action.meteor.in_flight&action.meteor.in_flight_remains<=0.5
            if A.GladiatorsBadge:IsReady(unit) and (Unit("player"):HasBuffs(A.CombustionBuff.ID, true) or A.Meteor:IsSpellInFlight() and action.meteor.in_flight_remains <= 0.5) then
                return A.GladiatorsBadge:Show(icon)
            end
            
            -- use_item,use_off_gcd=1,effect_name=gladiators_medallion,if=buff.combustion.up|action.meteor.in_flight&action.meteor.in_flight_remains<=0.5
            if A.GladiatorsMedallion:IsReady(unit) and (Unit("player"):HasBuffs(A.CombustionBuff.ID, true) or A.Meteor:IsSpellInFlight() and action.meteor.in_flight_remains <= 0.5) then
                return A.GladiatorsMedallion:Show(icon)
            end
            
            -- use_item,use_off_gcd=1,name=balefire_branch,if=buff.combustion.up|action.meteor.in_flight&action.meteor.in_flight_remains<=0.5
            if A.BalefireBranch:IsReady(unit) and (Unit("player"):HasBuffs(A.CombustionBuff.ID, true) or A.Meteor:IsSpellInFlight() and action.meteor.in_flight_remains <= 0.5) then
                return A.BalefireBranch:Show(icon)
            end
            
            -- use_item,use_off_gcd=1,name=shockbiters_fang,if=buff.combustion.up|action.meteor.in_flight&action.meteor.in_flight_remains<=0.5
            if A.ShockbitersFang:IsReady(unit) and (Unit("player"):HasBuffs(A.CombustionBuff.ID, true) or A.Meteor:IsSpellInFlight() and action.meteor.in_flight_remains <= 0.5) then
                return A.ShockbitersFang:Show(icon)
            end
            
            -- use_item,use_off_gcd=1,name=tzanes_barkspines,if=buff.combustion.up|action.meteor.in_flight&action.meteor.in_flight_remains<=0.5
            if A.TzanesBarkspines:IsReady(unit) and (Unit("player"):HasBuffs(A.CombustionBuff.ID, true) or A.Meteor:IsSpellInFlight() and action.meteor.in_flight_remains <= 0.5) then
                return A.TzanesBarkspines:Show(icon)
            end
            
            -- use_item,use_off_gcd=1,name=ancient_knot_of_wisdom,if=buff.combustion.up|action.meteor.in_flight&action.meteor.in_flight_remains<=0.5
            if A.AncientKnotofWisdom:IsReady(unit) and (Unit("player"):HasBuffs(A.CombustionBuff.ID, true) or A.Meteor:IsSpellInFlight() and action.meteor.in_flight_remains <= 0.5) then
                return A.AncientKnotofWisdom:Show(icon)
            end
            
            -- use_item,use_off_gcd=1,name=neural_synapse_enhancer,if=buff.combustion.up|action.meteor.in_flight&action.meteor.in_flight_remains<=0.5
            if A.NeuralSynapseEnhancer:IsReady(unit) and (Unit("player"):HasBuffs(A.CombustionBuff.ID, true) or A.Meteor:IsSpellInFlight() and action.meteor.in_flight_remains <= 0.5) then
                return A.NeuralSynapseEnhancer:Show(icon)
            end
            
            -- use_item,use_off_gcd=1,name=malformed_heralds_legwraps,if=buff.combustion.up|action.meteor.in_flight&action.meteor.in_flight_remains<=0.5
            if A.MalformedHeraldsLegwraps:IsReady(unit) and (Unit("player"):HasBuffs(A.CombustionBuff.ID, true) or A.Meteor:IsSpellInFlight() and action.meteor.in_flight_remains <= 0.5) then
                return A.MalformedHeraldsLegwraps:Show(icon)
            end
            
        end
        
        --ItemsHighPriority
        local function ItemsHighPriority(unit)
        
            -- call_action_list,name=items_combustion,if=!variable.disable_combustion&variable.time_to_combustion<=0
            if (not VarDisableCombustion and VarTimeToCombustion <= 0) then
                if ItemsCombustion(unit) then
                    return true
                end
            end
            
            -- use_items
            -- use_item,name=manifesto_of_madness,if=!equipped.azsharas_font_of_power&variable.time_to_combustion<8
            if A.ManifestoofMadness:IsReady(unit) and (not A.AzsharasFontofPower:IsExists() and VarTimeToCombustion < 8) then
                return A.ManifestoofMadness:Show(icon)
            end
            
            -- use_item,name=azsharas_font_of_power,if=variable.time_to_combustion<=5+15*variable.font_double_on_use&variable.time_to_combustion>0&!variable.disable_combustion
            if A.AzsharasFontofPower:IsReady(unit) and (VarTimeToCombustion <= 5 + 15 * VarFontDoubleOnUse and VarTimeToCombustion > 0 and not VarDisableCombustion) then
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
            if A.ForbiddenObsidianClaw:IsReady(unit) and (VarTimeToCombustion > VarOnUseCutoff or VarDisableCombustion) then
                return A.ForbiddenObsidianClaw:Show(icon)
            end
            
            -- use_item,effect_name=harmonic_dematerializer
            if A.HarmonicDematerializer:IsReady(unit) then
                return A.HarmonicDematerializer:Show(icon)
            end
            
            -- use_item,name=malformed_heralds_legwraps,if=variable.time_to_combustion>=55&buff.combustion.down&variable.time_to_combustion>variable.on_use_cutoff|variable.disable_combustion
            if A.MalformedHeraldsLegwraps:IsReady(unit) and (VarTimeToCombustion >= 55 and Unit("player"):HasBuffsDown(A.CombustionBuff.ID, true) and VarTimeToCombustion > VarOnUseCutoff or VarDisableCombustion) then
                return A.MalformedHeraldsLegwraps:Show(icon)
            end
            
            -- use_item,name=ancient_knot_of_wisdom,if=variable.time_to_combustion>=55&buff.combustion.down&variable.time_to_combustion>variable.on_use_cutoff|variable.disable_combustion
            if A.AncientKnotofWisdom:IsReady(unit) and (VarTimeToCombustion >= 55 and Unit("player"):HasBuffsDown(A.CombustionBuff.ID, true) and VarTimeToCombustion > VarOnUseCutoff or VarDisableCombustion) then
                return A.AncientKnotofWisdom:Show(icon)
            end
            
            -- use_item,name=neural_synapse_enhancer,if=variable.time_to_combustion>=45&buff.combustion.down&variable.time_to_combustion>variable.on_use_cutoff|variable.disable_combustion
            if A.NeuralSynapseEnhancer:IsReady(unit) and (VarTimeToCombustion >= 45 and Unit("player"):HasBuffsDown(A.CombustionBuff.ID, true) and VarTimeToCombustion > VarOnUseCutoff or VarDisableCombustion) then
                return A.NeuralSynapseEnhancer:Show(icon)
            end
            
        end
        
        --ItemsLowPriority
        local function ItemsLowPriority(unit)
        
            -- use_item,name=tidestorm_codex,if=variable.time_to_combustion>variable.on_use_cutoff|variable.disable_combustion
            if A.TidestormCodex:IsReady(unit) and (VarTimeToCombustion > VarOnUseCutoff or VarDisableCombustion) then
                return A.TidestormCodex:Show(icon)
            end
            
            -- use_item,effect_name=cyclotronic_blast,if=variable.time_to_combustion>variable.on_use_cutoff|variable.disable_combustion
            if A.CyclotronicBlast:IsReady(unit) and (VarTimeToCombustion > VarOnUseCutoff or VarDisableCombustion) then
                return A.CyclotronicBlast:Show(icon)
            end
            
        end
        
        --RopPhase
        local function RopPhase(unit)
        
            -- flamestrike,if=(active_enemies>=variable.hot_streak_flamestrike&(time-buff.combustion.last_expire>variable.delay_flamestrike|variable.disable_combustion))&buff.hot_streak.react
            if A.Flamestrike:IsReady(unit) and ((MultiUnits:GetByRangeInCombat(40, 5, 10) >= VarHotStreakFlamestrike and (Unit("player"):CombatTime() - buff.combustion.last_expire > VarDelayFlamestrike or VarDisableCombustion)) and Unit("player"):HasBuffsStacks(A.HotStreakBuff.ID, true)) then
                return A.Flamestrike:Show(icon)
            end
            
            -- pyroblast,if=buff.hot_streak.react
            if A.Pyroblast:IsReady(unit) and (Unit("player"):HasBuffsStacks(A.HotStreakBuff.ID, true)) then
                return A.Pyroblast:Show(icon)
            end
            
            -- fire_blast,use_off_gcd=1,use_while_casting=1,if=!(active_enemies>=variable.hard_cast_flamestrike&(time-buff.combustion.last_expire>variable.delay_flamestrike|variable.disable_combustion))&!firestarter.active&(!buff.heating_up.react&!buff.hot_streak.react&!prev_off_gcd.fire_blast&(action.fire_blast.charges>=2|(action.phoenix_flames.charges>=1&talent.phoenix_flames.enabled)|(talent.alexstraszas_fury.enabled&cooldown.dragons_breath.ready)|(talent.searing_touch.enabled&target.health.pct<=30|spell_crit>=1)))
            if A.FireBlast:IsReady(unit) and (not (MultiUnits:GetByRangeInCombat(40, 5, 10) >= VarHardCastFlamestrike and (Unit("player"):CombatTime() - buff.combustion.last_expire > VarDelayFlamestrike or VarDisableCombustion)) and not S.Firestarter:ActiveStatus() and (not Unit("player"):HasBuffsStacks(A.HeatingUpBuff.ID, true) and not Unit("player"):HasBuffsStacks(A.HotStreakBuff.ID, true) and not Unit("player"):PrevOffGCDP(1, A.FireBlast) and (A.FireBlast:GetSpellCharges() >= 2 or (A.PhoenixFlames:GetSpellCharges() >= 1 and A.PhoenixFlames:IsSpellLearned()) or (A.AlexstraszasFury:IsSpellLearned() and A.DragonsBreath:GetCooldown() == 0) or (A.SearingTouch:IsSpellLearned() and Unit(unit):HealthPercent() <= 30 or spell_crit >= 1)))) then
                return A.FireBlast:Show(icon)
            end
            
            -- call_action_list,name=active_talents
            if ActiveTalents(unit) then
                return true
            end
            
            -- pyroblast,if=buff.pyroclasm.react&cast_time<buff.pyroclasm.remains&buff.rune_of_power.remains>cast_time
            if A.Pyroblast:IsReady(unit) and (Unit("player"):HasBuffsStacks(A.PyroclasmBuff.ID, true) and A.Pyroblast:GetSpellCastTime() < Unit("player"):HasBuffs(A.PyroclasmBuff.ID, true) and Unit("player"):HasBuffs(A.RuneofPowerBuff.ID, true) > A.Pyroblast:GetSpellCastTime()) then
                return A.Pyroblast:Show(icon)
            end
            
            -- fire_blast,use_off_gcd=1,use_while_casting=1,if=!(active_enemies>=variable.hard_cast_flamestrike&(time-buff.combustion.last_expire>variable.delay_flamestrike|variable.disable_combustion))&!firestarter.active&(buff.heating_up.react&spell_crit<1&(target.health.pct>=30|!talent.searing_touch.enabled))
            if A.FireBlast:IsReady(unit) and (not (MultiUnits:GetByRangeInCombat(40, 5, 10) >= VarHardCastFlamestrike and (Unit("player"):CombatTime() - buff.combustion.last_expire > VarDelayFlamestrike or VarDisableCombustion)) and not S.Firestarter:ActiveStatus() and (Unit("player"):HasBuffsStacks(A.HeatingUpBuff.ID, true) and spell_crit < 1 and (Unit(unit):HealthPercent() >= 30 or not A.SearingTouch:IsSpellLearned()))) then
                return A.FireBlast:Show(icon)
            end
            
            -- fire_blast,use_off_gcd=1,use_while_casting=1,if=!(active_enemies>=variable.hard_cast_flamestrike&(time-buff.combustion.last_expire>variable.delay_flamestrike|variable.disable_combustion))&!firestarter.active&(talent.searing_touch.enabled&target.health.pct<=30|spell_crit>=1)&(buff.heating_up.react&!action.scorch.executing|!buff.heating_up.react&!buff.hot_streak.react)
            if A.FireBlast:IsReady(unit) and (not (MultiUnits:GetByRangeInCombat(40, 5, 10) >= VarHardCastFlamestrike and (Unit("player"):CombatTime() - buff.combustion.last_expire > VarDelayFlamestrike or VarDisableCombustion)) and not S.Firestarter:ActiveStatus() and (A.SearingTouch:IsSpellLearned() and Unit(unit):HealthPercent() <= 30 or spell_crit >= 1) and (Unit("player"):HasBuffsStacks(A.HeatingUpBuff.ID, true) and not action.scorch.executing or not Unit("player"):HasBuffsStacks(A.HeatingUpBuff.ID, true) and not Unit("player"):HasBuffsStacks(A.HotStreakBuff.ID, true))) then
                return A.FireBlast:Show(icon)
            end
            
            -- pyroblast,if=prev_gcd.1.scorch&buff.heating_up.up&(talent.searing_touch.enabled&target.health.pct<=30|spell_crit>=1)&!(active_enemies>=variable.hot_streak_flamestrike&(time-buff.combustion.last_expire>variable.delay_flamestrike|variable.disable_combustion))
            if A.Pyroblast:IsReady(unit) and (Player:PrevGCD(1, A.Scorch) and Unit("player"):HasBuffs(A.HeatingUpBuff.ID, true) and (A.SearingTouch:IsSpellLearned() and Unit(unit):HealthPercent() <= 30 or spell_crit >= 1) and not (MultiUnits:GetByRangeInCombat(40, 5, 10) >= VarHotStreakFlamestrike and (Unit("player"):CombatTime() - buff.combustion.last_expire > VarDelayFlamestrike or VarDisableCombustion))) then
                return A.Pyroblast:Show(icon)
            end
            
            -- phoenix_flames,if=!prev_gcd.1.phoenix_flames&buff.heating_up.react
            if A.PhoenixFlames:IsReady(unit) and (not Player:PrevGCD(1, A.PhoenixFlames) and Unit("player"):HasBuffsStacks(A.HeatingUpBuff.ID, true)) then
                return A.PhoenixFlames:Show(icon)
            end
            
            -- scorch,if=target.health.pct<=30&talent.searing_touch.enabled|spell_crit>=1
            if A.Scorch:IsReady(unit) and (Unit(unit):HealthPercent() <= 30 and A.SearingTouch:IsSpellLearned() or spell_crit >= 1) then
                return A.Scorch:Show(icon)
            end
            
            -- dragons_breath,if=active_enemies>2
            if A.DragonsBreath:IsReady(unit) and (MultiUnits:GetByRangeInCombat(40, 5, 10) > 2) then
                return A.DragonsBreath:Show(icon)
            end
            
            -- flamestrike,if=(active_enemies>=variable.hard_cast_flamestrike&(time-buff.combustion.last_expire>variable.delay_flamestrike|variable.disable_combustion))
            if A.Flamestrike:IsReady(unit) and ((MultiUnits:GetByRangeInCombat(40, 5, 10) >= VarHardCastFlamestrike and (Unit("player"):CombatTime() - buff.combustion.last_expire > VarDelayFlamestrike or VarDisableCombustion))) then
                return A.Flamestrike:Show(icon)
            end
            
            -- fireball
            if A.Fireball:IsReady(unit) then
                return A.Fireball:Show(icon)
            end
            
        end
        
        --StandardRotation
        local function StandardRotation(unit)
        
            -- flamestrike,if=(active_enemies>=variable.hot_streak_flamestrike&(time-buff.combustion.last_expire>variable.delay_flamestrike|variable.disable_combustion))&buff.hot_streak.react
            if A.Flamestrike:IsReady(unit) and ((MultiUnits:GetByRangeInCombat(40, 5, 10) >= VarHotStreakFlamestrike and (Unit("player"):CombatTime() - buff.combustion.last_expire > VarDelayFlamestrike or VarDisableCombustion)) and Unit("player"):HasBuffsStacks(A.HotStreakBuff.ID, true)) then
                return A.Flamestrike:Show(icon)
            end
            
            -- pyroblast,if=buff.hot_streak.react&buff.hot_streak.remains<action.fireball.execute_time
            if A.Pyroblast:IsReady(unit) and (Unit("player"):HasBuffsStacks(A.HotStreakBuff.ID, true) and Unit("player"):HasBuffs(A.HotStreakBuff.ID, true) < A.Fireball:GetSpellCastTime()) then
                return A.Pyroblast:Show(icon)
            end
            
            -- pyroblast,if=buff.hot_streak.react&(prev_gcd.1.fireball|firestarter.active|action.pyroblast.in_flight)
            if A.Pyroblast:IsReady(unit) and (Unit("player"):HasBuffsStacks(A.HotStreakBuff.ID, true) and (Player:PrevGCD(1, A.Fireball) or S.Firestarter:ActiveStatus() or A.Pyroblast:IsSpellInFlight())) then
                return A.Pyroblast:Show(icon)
            end
            
            -- phoenix_flames,if=charges>=3&active_enemies>2&!variable.phoenix_pooling
            if A.PhoenixFlames:IsReady(unit) and (A.PhoenixFlames:GetSpellCharges() >= 3 and MultiUnits:GetByRangeInCombat(40, 5, 10) > 2 and not VarPhoenixPooling) then
                return A.PhoenixFlames:Show(icon)
            end
            
            -- pyroblast,if=buff.hot_streak.react&(target.health.pct<=30&talent.searing_touch.enabled|spell_crit>=1)
            if A.Pyroblast:IsReady(unit) and (Unit("player"):HasBuffsStacks(A.HotStreakBuff.ID, true) and (Unit(unit):HealthPercent() <= 30 and A.SearingTouch:IsSpellLearned() or spell_crit >= 1)) then
                return A.Pyroblast:Show(icon)
            end
            
            -- pyroblast,if=buff.pyroclasm.react&cast_time<buff.pyroclasm.remains
            if A.Pyroblast:IsReady(unit) and (Unit("player"):HasBuffsStacks(A.PyroclasmBuff.ID, true) and A.Pyroblast:GetSpellCastTime() < Unit("player"):HasBuffs(A.PyroclasmBuff.ID, true)) then
                return A.Pyroblast:Show(icon)
            end
            
            -- fire_blast,use_off_gcd=1,use_while_casting=1,if=(buff.rune_of_power.down&!firestarter.active)&!variable.fire_blast_pooling&(((action.fireball.executing|action.pyroblast.executing)&buff.heating_up.react)|((talent.searing_touch.enabled&target.health.pct<=30|spell_crit>=1)&(buff.heating_up.react&!action.scorch.executing|!buff.hot_streak.react&!buff.heating_up.react&action.scorch.executing&!action.pyroblast.in_flight&!action.fireball.in_flight)))
            if A.FireBlast:IsReady(unit) and ((Unit("player"):HasBuffsDown(A.RuneofPowerBuff.ID, true) and not S.Firestarter:ActiveStatus()) and not VarFireBlastPooling and (((action.fireball.executing or action.pyroblast.executing) and Unit("player"):HasBuffsStacks(A.HeatingUpBuff.ID, true)) or ((A.SearingTouch:IsSpellLearned() and Unit(unit):HealthPercent() <= 30 or spell_crit >= 1) and (Unit("player"):HasBuffsStacks(A.HeatingUpBuff.ID, true) and not action.scorch.executing or not Unit("player"):HasBuffsStacks(A.HotStreakBuff.ID, true) and not Unit("player"):HasBuffsStacks(A.HeatingUpBuff.ID, true) and action.scorch.executing and not A.Pyroblast:IsSpellInFlight() and not A.Fireball:IsSpellInFlight())))) then
                return A.FireBlast:Show(icon)
            end
            
            -- pyroblast,if=prev_gcd.1.scorch&buff.heating_up.up&(talent.searing_touch.enabled&target.health.pct<=30|spell_crit>=1)&!(active_enemies>=variable.hot_streak_flamestrike&(time-buff.combustion.last_expire>variable.delay_flamestrike|variable.disable_combustion))
            if A.Pyroblast:IsReady(unit) and (Player:PrevGCD(1, A.Scorch) and Unit("player"):HasBuffs(A.HeatingUpBuff.ID, true) and (A.SearingTouch:IsSpellLearned() and Unit(unit):HealthPercent() <= 30 or spell_crit >= 1) and not (MultiUnits:GetByRangeInCombat(40, 5, 10) >= VarHotStreakFlamestrike and (Unit("player"):CombatTime() - buff.combustion.last_expire > VarDelayFlamestrike or VarDisableCombustion))) then
                return A.Pyroblast:Show(icon)
            end
            
            -- phoenix_flames,if=(buff.heating_up.react|(!buff.hot_streak.react&(action.fire_blast.charges>0|talent.searing_touch.enabled&target.health.pct<=30|spell_crit>=1)))&!variable.phoenix_pooling
            if A.PhoenixFlames:IsReady(unit) and ((Unit("player"):HasBuffsStacks(A.HeatingUpBuff.ID, true) or (not Unit("player"):HasBuffsStacks(A.HotStreakBuff.ID, true) and (A.FireBlast:GetSpellCharges() > 0 or A.SearingTouch:IsSpellLearned() and Unit(unit):HealthPercent() <= 30 or spell_crit >= 1))) and not VarPhoenixPooling) then
                return A.PhoenixFlames:Show(icon)
            end
            
            -- call_action_list,name=active_talents
            if ActiveTalents(unit) then
                return true
            end
            
            -- dragons_breath,if=active_enemies>1
            if A.DragonsBreath:IsReady(unit) and (MultiUnits:GetByRangeInCombat(40, 5, 10) > 1) then
                return A.DragonsBreath:Show(icon)
            end
            
            -- call_action_list,name=items_low_priority
            if ItemsLowPriority(unit) then
                return true
            end
            
            -- scorch,if=target.health.pct<=30&talent.searing_touch.enabled|spell_crit>=1
            if A.Scorch:IsReady(unit) and (Unit(unit):HealthPercent() <= 30 and A.SearingTouch:IsSpellLearned() or spell_crit >= 1) then
                return A.Scorch:Show(icon)
            end
            
            -- flamestrike,if=active_enemies>=variable.hard_cast_flamestrike&(time-buff.combustion.last_expire>variable.delay_flamestrike|variable.disable_combustion)
            if A.Flamestrike:IsReady(unit) and (MultiUnits:GetByRangeInCombat(40, 5, 10) >= VarHardCastFlamestrike and (Unit("player"):CombatTime() - buff.combustion.last_expire > VarDelayFlamestrike or VarDisableCombustion)) then
                return A.Flamestrike:Show(icon)
            end
            
            -- fireball
            if A.Fireball:IsReady(unit) then
                return A.Fireball:Show(icon)
            end
            
            -- scorch
            if A.Scorch:IsReady(unit) then
                return A.Scorch:Show(icon)
            end
            
        end
        
-- call precombat
if not Player:AffectingCombat() and not Player:IsCasting() then
  if Precombat(unit) then
    return true
end
end

        -- In Combat
        if inCombat and Unit(unit):IsExists() then

                    -- counterspell
            -- variable,name=time_to_combustion,op=set,value=talent.firestarter.enabled*firestarter.remains+(cooldown.combustion.remains*(1-variable.kindling_reduction*talent.kindling.enabled)-action.rune_of_power.execute_time*talent.rune_of_power.enabled)*!cooldown.combustion.ready*buff.combustion.down
            VarTimeToCombustion = num(A.Firestarter:IsSpellLearned()) * S.Firestarter:ActiveRemains() + (A.Combustion:GetCooldown() * (1 - VarKindlingReduction * num(A.Kindling:IsSpellLearned())) - A.RuneofPower:GetSpellCastTime() * num(A.RuneofPower:IsSpellLearned())) * num(not A.Combustion:GetCooldown() == 0) * Unit("player"):HasBuffsDown(A.CombustionBuff.ID, true)
            
            -- variable,name=time_to_combustion,op=max,value=cooldown.memory_of_lucid_dreams.remains,if=essence.memory_of_lucid_dreams.major&buff.memory_of_lucid_dreams.down&cooldown.memory_of_lucid_dreams.remains-variable.time_to_combustion<=variable.hold_combustion_threshold
            if (Azerite:EssenceHasMajor(A.MemoryofLucidDreams.ID) and Unit("player"):HasBuffsDown(A.MemoryofLucidDreamsBuff.ID, true) and A.MemoryofLucidDreams:GetCooldown() - VarTimeToCombustion <= VarHoldCombustionThreshold) then
                VarTimeToCombustion = math.max(VarTimeToCombustion, A.MemoryofLucidDreams:GetCooldown())
            end
            
            -- variable,name=time_to_combustion,op=max,value=cooldown.worldvein_resonance.remains,if=essence.worldvein_resonance.major&buff.worldvein_resonance.down&cooldown.worldvein_resonance.remains-variable.time_to_combustion<=variable.hold_combustion_threshold
            if (Azerite:EssenceHasMajor(A.WorldveinResonance.ID) and Unit("player"):HasBuffsDown(A.WorldveinResonanceBuff.ID, true) and A.WorldveinResonance:GetCooldown() - VarTimeToCombustion <= VarHoldCombustionThreshold) then
                VarTimeToCombustion = math.max(VarTimeToCombustion, A.WorldveinResonance:GetCooldown())
            end
            
            -- call_action_list,name=items_high_priority
            if ItemsHighPriority(unit) then
                return true
            end
            
            -- mirror_image,if=buff.combustion.down
            if A.MirrorImage:IsReady(unit) and (Unit("player"):HasBuffsDown(A.CombustionBuff.ID, true)) then
                return A.MirrorImage:Show(icon)
            end
            
            -- guardian_of_azeroth,if=(variable.time_to_combustion<10|target.time_to_die<variable.time_to_combustion)&!variable.disable_combustion
            if A.GuardianofAzeroth:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and ((VarTimeToCombustion < 10 or Unit(unit):TimeToDie() < VarTimeToCombustion) and not VarDisableCombustion) then
                return A.GuardianofAzeroth:Show(icon)
            end
            
            -- concentrated_flame
            if A.ConcentratedFlame:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth then
                return A.ConcentratedFlame:Show(icon)
            end
            
            -- reaping_flames
            if A.ReapingFlames:IsReady(unit) then
                return A.ReapingFlames:Show(icon)
            end
            
            -- focused_azerite_beam
            if A.FocusedAzeriteBeam:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth then
                return A.FocusedAzeriteBeam:Show(icon)
            end
            
            -- purifying_blast
            if A.PurifyingBlast:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth then
                return A.PurifyingBlast:Show(icon)
            end
            
            -- ripple_in_space
            if A.RippleInSpace:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth then
                return A.RippleInSpace:Show(icon)
            end
            
            -- the_unbound_force
            if A.TheUnboundForce:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth then
                return A.TheUnboundForce:Show(icon)
            end
            
            -- rune_of_power,if=buff.rune_of_power.down&(buff.combustion.down&(variable.time_to_combustion>full_recharge_time|variable.time_to_combustion>target.time_to_die)|variable.disable_combustion)
            if A.RuneofPower:IsReady(unit) and (Unit("player"):HasBuffsDown(A.RuneofPowerBuff.ID, true) and (Unit("player"):HasBuffsDown(A.CombustionBuff.ID, true) and (VarTimeToCombustion > A.RuneofPower:GetSpellChargesFullRechargeTime() or VarTimeToCombustion > Unit(unit):TimeToDie()) or VarDisableCombustion)) then
                return A.RuneofPower:Show(icon)
            end
            
            -- call_action_list,name=combustion_phase,if=!variable.disable_combustion&variable.time_to_combustion<=0
            if A.BurstIsON(unit) and (not VarDisableCombustion and VarTimeToCombustion <= 0) then
                if CombustionPhase(unit) then
                    return true
                end
            end
            
            -- fire_blast,use_off_gcd=1,use_while_casting=1,if=(essence.memory_of_lucid_dreams.major|essence.memory_of_lucid_dreams.minor&azerite.blaster_master.enabled)&charges=max_charges&!buff.hot_streak.react&!(buff.heating_up.react&(buff.combustion.up&(action.fireball.in_flight|action.pyroblast.in_flight|action.scorch.executing)|target.health.pct<=30&action.scorch.executing))&!(!buff.heating_up.react&!buff.hot_streak.react&buff.combustion.down&(action.fireball.in_flight|action.pyroblast.in_flight))
            if A.FireBlast:IsReady(unit) and ((Azerite:EssenceHasMajor(A.MemoryofLucidDreams.ID) or Azerite:EssenceHasMinor(A.MemoryofLucidDreams.ID) and A.BlasterMaster:GetAzeriteRank() > 0) and A.FireBlast:GetSpellCharges() == A.FireBlast:GetSpellChargesMax() and not Unit("player"):HasBuffsStacks(A.HotStreakBuff.ID, true) and not (Unit("player"):HasBuffsStacks(A.HeatingUpBuff.ID, true) and (Unit("player"):HasBuffs(A.CombustionBuff.ID, true) and (A.Fireball:IsSpellInFlight() or A.Pyroblast:IsSpellInFlight() or action.scorch.executing) or Unit(unit):HealthPercent() <= 30 and action.scorch.executing)) and not (not Unit("player"):HasBuffsStacks(A.HeatingUpBuff.ID, true) and not Unit("player"):HasBuffsStacks(A.HotStreakBuff.ID, true) and Unit("player"):HasBuffsDown(A.CombustionBuff.ID, true) and (A.Fireball:IsSpellInFlight() or A.Pyroblast:IsSpellInFlight()))) then
                return A.FireBlast:Show(icon)
            end
            
            -- call_action_list,name=rop_phase,if=buff.rune_of_power.up&(variable.time_to_combustion>0|variable.disable_combustion)
            if (Unit("player"):HasBuffs(A.RuneofPowerBuff.ID, true) and (VarTimeToCombustion > 0 or VarDisableCombustion)) then
                if RopPhase(unit) then
                    return true
                end
            end
            
            -- variable,name=fire_blast_pooling,value=talent.rune_of_power.enabled&cooldown.rune_of_power.remains<cooldown.fire_blast.full_recharge_time&(variable.time_to_combustion>action.rune_of_power.full_recharge_time|variable.disable_combustion)&(cooldown.rune_of_power.remains<target.time_to_die|action.rune_of_power.charges>0)|!variable.disable_combustion&variable.time_to_combustion<action.fire_blast.full_recharge_time&variable.time_to_combustion<target.time_to_die
            VarFireBlastPooling = num(A.RuneofPower:IsSpellLearned() and A.RuneofPower:GetCooldown() < A.FireBlast:FullRechargeTimeP() and (VarTimeToCombustion > A.RuneofPower:GetSpellChargesFullRechargeTime() or VarDisableCombustion) and (A.RuneofPower:GetCooldown() < Unit(unit):TimeToDie() or A.RuneofPower:GetSpellCharges() > 0) or not VarDisableCombustion and VarTimeToCombustion < A.FireBlast:GetSpellChargesFullRechargeTime() and VarTimeToCombustion < Unit(unit):TimeToDie())
            
            -- variable,name=phoenix_pooling,value=talent.rune_of_power.enabled&cooldown.rune_of_power.remains<cooldown.phoenix_flames.full_recharge_time&(variable.time_to_combustion>action.rune_of_power.full_recharge_time|variable.disable_combustion)&(cooldown.rune_of_power.remains<target.time_to_die|action.rune_of_power.charges>0)|!variable.disable_combustion&variable.time_to_combustion<action.phoenix_flames.full_recharge_time&variable.time_to_combustion<target.time_to_die
            VarPhoenixPooling = num(A.RuneofPower:IsSpellLearned() and A.RuneofPower:GetCooldown() < A.PhoenixFlames:FullRechargeTimeP() and (VarTimeToCombustion > A.RuneofPower:GetSpellChargesFullRechargeTime() or VarDisableCombustion) and (A.RuneofPower:GetCooldown() < Unit(unit):TimeToDie() or A.RuneofPower:GetSpellCharges() > 0) or not VarDisableCombustion and VarTimeToCombustion < A.PhoenixFlames:GetSpellChargesFullRechargeTime() and VarTimeToCombustion < Unit(unit):TimeToDie())
            
            -- fire_blast,use_off_gcd=1,use_while_casting=1,if=(!variable.fire_blast_pooling|buff.rune_of_power.up)&(variable.time_to_combustion>0|variable.disable_combustion)&(active_enemies>=variable.hard_cast_flamestrike&(time-buff.combustion.last_expire>variable.delay_flamestrike|variable.disable_combustion))&!firestarter.active&buff.hot_streak.down&(!azerite.blaster_master.enabled|buff.blaster_master.remains<0.5)
            if A.FireBlast:IsReady(unit) and ((not VarFireBlastPooling or Unit("player"):HasBuffs(A.RuneofPowerBuff.ID, true)) and (VarTimeToCombustion > 0 or VarDisableCombustion) and (MultiUnits:GetByRangeInCombat(40, 5, 10) >= VarHardCastFlamestrike and (Unit("player"):CombatTime() - buff.combustion.last_expire > VarDelayFlamestrike or VarDisableCombustion)) and not S.Firestarter:ActiveStatus() and Unit("player"):HasBuffsDown(A.HotStreakBuff.ID, true) and (not A.BlasterMaster:GetAzeriteRank() > 0 or Unit("player"):HasBuffs(A.BlasterMasterBuff.ID, true) < 0.5)) then
                return A.FireBlast:Show(icon)
            end
            
            -- fire_blast,use_off_gcd=1,use_while_casting=1,if=firestarter.active&charges>=1&(!variable.fire_blast_pooling|buff.rune_of_power.up)&(!azerite.blaster_master.enabled|buff.blaster_master.remains<0.5)&(!action.fireball.executing&!action.pyroblast.in_flight&buff.heating_up.up|action.fireball.executing&buff.hot_streak.down|action.pyroblast.in_flight&buff.heating_up.down&buff.hot_streak.down)
            if A.FireBlast:IsReady(unit) and (S.Firestarter:ActiveStatus() and A.FireBlast:GetSpellCharges() >= 1 and (not VarFireBlastPooling or Unit("player"):HasBuffs(A.RuneofPowerBuff.ID, true)) and (not A.BlasterMaster:GetAzeriteRank() > 0 or Unit("player"):HasBuffs(A.BlasterMasterBuff.ID, true) < 0.5) and (not action.fireball.executing and not A.Pyroblast:IsSpellInFlight() and Unit("player"):HasBuffs(A.HeatingUpBuff.ID, true) or action.fireball.executing and Unit("player"):HasBuffsDown(A.HotStreakBuff.ID, true) or A.Pyroblast:IsSpellInFlight() and Unit("player"):HasBuffsDown(A.HeatingUpBuff.ID, true) and Unit("player"):HasBuffsDown(A.HotStreakBuff.ID, true))) then
                return A.FireBlast:Show(icon)
            end
            
            -- call_action_list,name=standard_rotation,if=variable.time_to_combustion>0|variable.disable_combustion
            if (VarTimeToCombustion > 0 or VarDisableCombustion) then
                if StandardRotation(unit) then
                    return true
                end
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

