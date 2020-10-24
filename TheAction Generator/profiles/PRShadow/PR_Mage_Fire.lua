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
    FlamePatch                             = Create({ Type = "Spell", ID = 205037 }),
    ShiftingPower                          = Create({ Type = "Spell", ID =  }),
    NightFae                               = Create({ Type = "Spell", ID =  }),
    Firestarter                            = Create({ Type = "Spell", ID = 205026 }),
    MirrorImage                            = Create({ Type = "Spell", ID = 55342 }),
    Pyroblast                              = Create({ Type = "Spell", ID = 11366 }),
    LivingBomb                             = Create({ Type = "Spell", ID = 44457 }),
    CombustionBuff                         = Create({ Type = "Spell", ID = 190319 }),
    Meteor                                 = Create({ Type = "Spell", ID = 153561 }),
    RuneofPower                            = Create({ Type = "Spell", ID = 116011 }),
    RuneofPowerBuff                        = Create({ Type = "Spell", ID = 116014 }),
    DragonsBreath                          = Create({ Type = "Spell", ID = 31661 }),
    AlexstraszasFury                       = Create({ Type = "Spell", ID = 235870 }),
    HotStreakBuff                          = Create({ Type = "Spell", ID = 48108 }),
    LightsJudgment                         = Create({ Type = "Spell", ID = 255647 }),
    Combustion                             = Create({ Type = "Spell", ID = 190319 }),
    SunKingsBlessingReadyBuff              = Create({ Type = "Spell", ID =  }),
    SunKingsBlessingBuff                   = Create({ Type = "Spell", ID =  }),
    BagofTricks                            = Create({ Type = "Spell", ID =  }),
    MirrorsofTorment                       = Create({ Type = "Spell", ID =  }),
    FireBlast                              = Create({ Type = "Spell", ID = 108853 }),
    BlasterMaster                          = Create({ Type = "Spell", ID = 274596 }),
    BlasterMasterBuff                      = Create({ Type = "Spell", ID = 274598 }),
    FlameOn                                = Create({ Type = "Spell", ID = 205029 }),
    HyperthreadWristwraps300142            = Create({ Type = "Spell", ID =  }),
    Scorch                                 = Create({ Type = "Spell", ID = 2948 }),
    HeatingUpBuff                          = Create({ Type = "Spell", ID = 48107 }),
    IgniteDebuff                           = Create({ Type = "Spell", ID =  }),
    PhoenixFlames                          = Create({ Type = "Spell", ID = 257541 }),
    InfernalCascade                        = Create({ Type = "Spell", ID =  }),
    InfernalCascadeBuff                    = Create({ Type = "Spell", ID =  }),
    FirestormBuff                          = Create({ Type = "Spell", ID =  }),
    ArcaneExplosion                        = Create({ Type = "Spell", ID =  }),
    DisciplinaryCommand                    = Create({ Type = "Spell", ID =  }),
    DisciplinaryCommandBuff                = Create({ Type = "Spell", ID =  }),
    DisciplinaryCommandArcaneBuff          = Create({ Type = "Spell", ID =  }),
    BuffDisciplinaryCommand                = Create({ Type = "Spell", ID =  }),
    Frostbolt                              = Create({ Type = "Spell", ID =  }),
    DisciplinaryCommandFrostBuff           = Create({ Type = "Spell", ID =  }),
    Fireball                               = Create({ Type = "Spell", ID = 133 }),
    BloodFury                              = Create({ Type = "Spell", ID = 20572 }),
    Berserking                             = Create({ Type = "Spell", ID = 26297 }),
    Fireblood                              = Create({ Type = "Spell", ID = 265221 }),
    AncestralCall                          = Create({ Type = "Spell", ID = 274738 }),
    Flamestrike                            = Create({ Type = "Spell", ID = 2120 }),
    PyroclasmBuff                          = Create({ Type = "Spell", ID = 269651 }),
    Pyroclasm                              = Create({ Type = "Spell", ID =  }),
    FlameAccretion                         = Create({ Type = "Spell", ID =  }),
    SearingTouch                           = Create({ Type = "Spell", ID = 269644 }),
    AlexstraszasFuryBuff                   = Create({ Type = "Spell", ID =  }),
    SunKingsBlessing                       = Create({ Type = "Spell", ID =  }),
    FromtheAshes                           = Create({ Type = "Spell", ID =  }),
    Kindling                               = Create({ Type = "Spell", ID = 155148 }),
    CyclingVariable                        = Create({ Type = "Spell", ID =  }),
    RadiantSpark                           = Create({ Type = "Spell", ID =  }),
    Deathborne                             = Create({ Type = "Spell", ID =  }),
    RadiantSparkVulnerabilityDebuff        = Create({ Type = "Spell", ID =  }),
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

-- To create covenant use next code:
A:CreateCovenantsFor(ACTION_CONST_MAGE_FIRE)  -- where PLAYERSPEC is Constance (example: ACTION_CONST_MONK_BM)
local A = setmetatable(Action[ACTION_CONST_MAGE_FIRE], { __index = Action })


------------------------------------------
---------------- VARIABLES ---------------
------------------------------------------
local VarDisableCombustion = 0;
local VarHotStreakFlamestrike = 0;
local VarHardCastFlamestrike = 0;
local VarCombustionFlamestrike = 0;
local VarArcaneExplosion = 0;
local VarArcaneExplosionMana = 40;
local VarDelayFlamestrike = 0;
local VarKindlingReduction = 0.2;
local VarShiftingPowerReduction = 0;
local VarCombustionOnUse = 0;
local VarFontDoubleOnUse = 0;
local VarFontofPowerPrecombatChannel = 0;
local VarTimeToCombustion = 0;
local VarExtendedCombustionRemains = 0;
local VarPhoenixPooling = 0;
local VarFireBlastPooling = 0;

A.Listener:Add("ROTATION_VARS", "PLAYER_REGEN_ENABLED", function()
  VarDisableCombustion = 0
  VarHotStreakFlamestrike = 0
  VarHardCastFlamestrike = 0
  VarCombustionFlamestrike = 0
  VarArcaneExplosion = 0
  VarArcaneExplosionMana = 40
  VarDelayFlamestrike = 0
  VarKindlingReduction = 0.2
  VarShiftingPowerReduction = 0
  VarCombustionOnUse = 0
  VarFontDoubleOnUse = 0
  VarFontofPowerPrecombatChannel = 0
  VarTimeToCombustion = 0
  VarExtendedCombustionRemains = 0
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
            
            -- variable,name=hot_streak_flamestrike,op=set,if=variable.hot_streak_flamestrike=0,value=2*talent.flame_patch.enabled+3*!talent.flame_patch.enabled
            if (VarHotStreakFlamestrike == 0) then
                VarHotStreakFlamestrike = 2 * num(A.FlamePatch:IsSpellLearned()) + 3 * num(not A.FlamePatch:IsSpellLearned())
            end
            
            -- variable,name=hard_cast_flamestrike,op=set,if=variable.hard_cast_flamestrike=0,value=2*talent.flame_patch.enabled+3*!talent.flame_patch.enabled
            if (VarHardCastFlamestrike == 0) then
                VarHardCastFlamestrike = 2 * num(A.FlamePatch:IsSpellLearned()) + 3 * num(not A.FlamePatch:IsSpellLearned())
            end
            
            -- variable,name=combustion_flamestrike,op=set,if=variable.combustion_flamestrike=0,value=3*talent.flame_patch.enabled+6*!talent.flame_patch.enabled
            if (VarCombustionFlamestrike == 0) then
                VarCombustionFlamestrike = 3 * num(A.FlamePatch:IsSpellLearned()) + 6 * num(not A.FlamePatch:IsSpellLearned())
            end
            
            -- variable,name=arcane_explosion,op=set,if=variable.arcane_explosion=0,value=99*talent.flame_patch.enabled+2*!talent.flame_patch.enabled
            if (VarArcaneExplosion == 0) then
                VarArcaneExplosion = 99 * num(A.FlamePatch:IsSpellLearned()) + 2 * num(not A.FlamePatch:IsSpellLearned())
            end
            
            -- variable,name=arcane_explosion_mana,default=40,op=reset
            VarArcaneExplosionMana = 40
            
            -- variable,name=delay_flamestrike,default=0,op=reset
            VarDelayFlamestrike = 0
            
            -- variable,name=kindling_reduction,default=0.2,op=reset
            VarKindlingReduction = 0.2
            
            -- variable,name=shifting_power_reduction,op=set,value=action.shifting_power.cast_time%action.shifting_power.tick_time*3,if=covenant.night_fae.enabled
            if (A.NightFae:IsCovenantLearned()) then
                VarShiftingPowerReduction = A.ShiftingPower:GetSpellCastTime() / action.shifting_power.tick_time * 3
            end
            
            -- variable,name=combustion_on_use,op=set,value=equipped.manifesto_of_madness|equipped.gladiators_badge|equipped.gladiators_medallion|equipped.ignition_mages_fuse|equipped.tzanes_barkspines|equipped.azurethos_singed_plumage|equipped.ancient_knot_of_wisdom|equipped.shockbiters_fang|equipped.neural_synapse_enhancer|equipped.balefire_branch
            VarCombustionOnUse = num(A.ManifestoofMadness:IsExists() or A.GladiatorsBadge:IsExists() or A.GladiatorsMedallion:IsExists() or A.IgnitionMagesFuse:IsExists() or A.TzanesBarkspines:IsExists() or A.AzurethosSingedPlumage:IsExists() or A.AncientKnotofWisdom:IsExists() or A.ShockbitersFang:IsExists() or A.NeuralSynapseEnhancer:IsExists() or A.BalefireBranch:IsExists())
            
            -- variable,name=font_double_on_use,op=set,value=equipped.azsharas_font_of_power&variable.combustion_on_use
            VarFontDoubleOnUse = num(A.AzsharasFontofPower:IsExists() and VarCombustionOnUse)
            
            -- variable,name=font_of_power_precombat_channel,op=set,value=18,if=variable.font_double_on_use&!talent.firestarter.enabled&variable.font_of_power_precombat_channel=0
            if (VarFontDoubleOnUse and not A.Firestarter:IsSpellLearned() and VarFontofPowerPrecombatChannel == 0) then
                VarFontofPowerPrecombatChannel = 18
            end
            
            -- snapshot_stats
            -- use_item,name=azsharas_font_of_power,if=!variable.disable_combustion
            if A.AzsharasFontofPower:IsReady(unit) and (not VarDisableCombustion) then
                return A.AzsharasFontofPower:Show(icon)
            end
            
            -- mirror_image
            if A.MirrorImage:IsReady(unit) then
                return A.MirrorImage:Show(icon)
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
            
            -- meteor,if=!variable.disable_combustion&variable.time_to_combustion<=0|(cooldown.meteor.duration<variable.time_to_combustion&!talent.rune_of_power.enabled)|talent.rune_of_power.enabled&buff.rune_of_power.up&variable.time_to_combustion>action.meteor.cooldown|fight_remains<variable.time_to_combustion|variable.disable_combustion
            if A.Meteor:IsReady(unit) and (not VarDisableCombustion and VarTimeToCombustion <= 0 or (A.Meteor:BaseDuration() < VarTimeToCombustion and not A.RuneofPower:IsSpellLearned()) or A.RuneofPower:IsSpellLearned() and Unit("player"):HasBuffs(A.RuneofPowerBuff.ID, true) and VarTimeToCombustion > action.meteor.cooldown or fight_remains < VarTimeToCombustion or VarDisableCombustion) then
                return A.Meteor:Show(icon)
            end
            
            -- dragons_breath,if=talent.alexstraszas_fury.enabled&(buff.combustion.down&!buff.hot_streak.react)
            if A.DragonsBreath:IsReady(unit) and (A.AlexstraszasFury:IsSpellLearned() and (Unit("player"):HasBuffsDown(A.CombustionBuff.ID, true) and not Unit("player"):HasBuffsStacks(A.HotStreakBuff.ID, true))) then
                return A.DragonsBreath:Show(icon)
            end
            
        end
        
        --CombustionPhase
        local function CombustionPhase(unit)
        
            -- lights_judgment,if=buff.combustion.down
            if A.LightsJudgment:IsReady(unit) and A.BurstIsON(unit) and (Unit("player"):HasBuffsDown(A.CombustionBuff.ID, true)) then
                return A.LightsJudgment:Show(icon)
            end
            
            -- variable,name=extended_combustion_remains,op=set,value=buff.combustion.remains+buff.combustion.duration*(cooldown.combustion.remains<buff.combustion.remains)
            VarExtendedCombustionRemains = Unit("player"):HasBuffs(A.CombustionBuff.ID, true) + A.CombustionBuff.ID, true:BaseDuration() * num((A.Combustion:GetCooldown() < Unit("player"):HasBuffs(A.CombustionBuff.ID, true)))
            
            -- variable,name=extended_combustion_remains,op=add,value=dbc.effect.828420.base_value,if=buff.sun_kings_blessing_ready.up|variable.extended_combustion_remains>1.5*gcd.max*(buff.sun_kings_blessing.max_stack-buff.sun_kings_blessing.stack)
            if (Unit("player"):HasBuffs(A.SunKingsBlessingReadyBuff.ID, true) or VarExtendedCombustionRemains > 1.5 * GetGCD() * (buff.sun_kings_blessing.max_stack - Unit("player"):HasBuffsStacks(A.SunKingsBlessingBuff.ID, true))) then
                VarExtendedCombustionRemains = VarExtendedCombustionRemains + dbc.effect.828420.base_value
            end
            
            -- bag_of_tricks,if=buff.combustion.down
            if A.BagofTricks:IsReady(unit) and (Unit("player"):HasBuffsDown(A.CombustionBuff.ID, true)) then
                return A.BagofTricks:Show(icon)
            end
            
            -- living_bomb,if=active_enemies>1&buff.combustion.down
            if A.LivingBomb:IsReady(unit) and (MultiUnits:GetByRangeInCombat(40, 5, 10) > 1 and Unit("player"):HasBuffsDown(A.CombustionBuff.ID, true)) then
                return A.LivingBomb:Show(icon)
            end
            
            -- mirrors_of_torment,if=buff.combustion.down&buff.rune_of_power.down
            if A.MirrorsofTorment:IsReady(unit) and (Unit("player"):HasBuffsDown(A.CombustionBuff.ID, true) and Unit("player"):HasBuffsDown(A.RuneofPowerBuff.ID, true)) then
                return A.MirrorsofTorment:Show(icon)
            end
            
            -- use_item,name=hyperthread_wristwraps,if=buff.combustion.up&action.fire_blast.charges=0&action.fire_blast.recharge_time>gcd.max
            if A.HyperthreadWristwraps:IsReady(unit) and (Unit("player"):HasBuffs(A.CombustionBuff.ID, true) and A.FireBlast:GetSpellCharges() == 0 and A.FireBlast:RechargeP() > GetGCD()) then
                return A.HyperthreadWristwraps:Show(icon)
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
            
            -- fire_blast,use_off_gcd=1,use_while_casting=1,if=azerite.blaster_master.enabled&charges>=1&((action.fire_blast.charges_fractional+(buff.combustion.remains-buff.blaster_master.duration)%cooldown.fire_blast.duration-(buff.combustion.remains)%(buff.blaster_master.duration-0.5))>=0|!azerite.blaster_master.enabled|!talent.flame_on.enabled|buff.combustion.remains<=buff.blaster_master.duration|buff.blaster_master.remains<0.5|equipped.hyperthread_wristwraps&cooldown.hyperthread_wristwraps_300142.remains<5)&buff.combustion.up&(!action.scorch.executing&!action.pyroblast.in_flight&buff.heating_up.up|action.scorch.executing&buff.hot_streak.down&(buff.heating_up.down|azerite.blaster_master.enabled)|azerite.blaster_master.enabled&talent.flame_on.enabled&action.pyroblast.in_flight&buff.heating_up.down&buff.hot_streak.down)
            if A.FireBlast:IsReady(unit) and (A.BlasterMaster:GetAzeriteRank() > 0 and A.FireBlast:GetSpellCharges() >= 1 and ((A.FireBlast:GetSpellChargesFrac() + (Unit("player"):HasBuffs(A.CombustionBuff.ID, true) - A.BlasterMasterBuff.ID, true:BaseDuration()) / A.FireBlast:BaseDuration() - (Unit("player"):HasBuffs(A.CombustionBuff.ID, true)) / (A.BlasterMasterBuff.ID, true:BaseDuration() - 0.5)) >= 0 or not A.BlasterMaster:GetAzeriteRank() > 0 or not A.FlameOn:IsSpellLearned() or Unit("player"):HasBuffs(A.CombustionBuff.ID, true) <= A.BlasterMasterBuff.ID, true:BaseDuration() or Unit("player"):HasBuffs(A.BlasterMasterBuff.ID, true) < 0.5 or A.HyperthreadWristwraps:IsExists() and A.HyperthreadWristwraps300142:GetCooldown() < 5) and Unit("player"):HasBuffs(A.CombustionBuff.ID, true) and (not action.scorch.executing and not A.Pyroblast:IsSpellInFlight() and Unit("player"):HasBuffs(A.HeatingUpBuff.ID, true) or action.scorch.executing and Unit("player"):HasBuffsDown(A.HotStreakBuff.ID, true) and (Unit("player"):HasBuffsDown(A.HeatingUpBuff.ID, true) or A.BlasterMaster:GetAzeriteRank() > 0) or A.BlasterMaster:GetAzeriteRank() > 0 and A.FlameOn:IsSpellLearned() and A.Pyroblast:IsSpellInFlight() and Unit("player"):HasBuffsDown(A.HeatingUpBuff.ID, true) and Unit("player"):HasBuffsDown(A.HotStreakBuff.ID, true))) then
                return A.FireBlast:Show(icon)
            end
            
            -- fire_blast,use_off_gcd=1,use_while_casting=1,if=!azerite.blaster_master.enabled&(active_enemies<=active_dot.ignite|!cooldown.phoenix_flames.ready)&conduit.infernal_cascade.enabled&charges>=1&((action.fire_blast.charges_fractional+(variable.extended_combustion_remains-buff.infernal_cascade.duration)%cooldown.fire_blast.duration-variable.extended_combustion_remains%(buff.infernal_cascade.duration-0.5))>=0|variable.extended_combustion_remains<=buff.infernal_cascade.duration|buff.infernal_cascade.remains<0.5)&buff.combustion.up&!buff.firestorm.react&!buff.hot_streak.react&hot_streak_spells_in_flight+buff.heating_up.react<2
            if A.FireBlast:IsReady(unit) and (not A.BlasterMaster:GetAzeriteRank() > 0 and (MultiUnits:GetByRangeInCombat(40, 5, 10) <= A.IgniteDebuff.ID, true:ActiveDot or not A.PhoenixFlames:GetCooldown() == 0) and A.InfernalCascade:IsConduitLearned() and A.FireBlast:GetSpellCharges() >= 1 and ((A.FireBlast:GetSpellChargesFrac() + (VarExtendedCombustionRemains - A.InfernalCascadeBuff.ID, true:BaseDuration()) / A.FireBlast:BaseDuration() - VarExtendedCombustionRemains / (A.InfernalCascadeBuff.ID, true:BaseDuration() - 0.5)) >= 0 or VarExtendedCombustionRemains <= A.InfernalCascadeBuff.ID, true:BaseDuration() or Unit("player"):HasBuffs(A.InfernalCascadeBuff.ID, true) < 0.5) and Unit("player"):HasBuffs(A.CombustionBuff.ID, true) and not Unit("player"):HasBuffsStacks(A.FirestormBuff.ID, true) and not Unit("player"):HasBuffsStacks(A.HotStreakBuff.ID, true) and hot_streak_spells_in_flight + Unit("player"):HasBuffsStacks(A.HeatingUpBuff.ID, true) < 2) then
                return A.FireBlast:Show(icon)
            end
            
            -- fire_blast,use_off_gcd=1,use_while_casting=1,if=!azerite.blaster_master.enabled&(active_enemies<=active_dot.ignite|!cooldown.phoenix_flames.ready)&!conduit.infernal_cascade.enabled&charges>=1&buff.combustion.up&!buff.firestorm.react&!buff.hot_streak.react&hot_streak_spells_in_flight+buff.heating_up.react<2
            if A.FireBlast:IsReady(unit) and (not A.BlasterMaster:GetAzeriteRank() > 0 and (MultiUnits:GetByRangeInCombat(40, 5, 10) <= A.IgniteDebuff.ID, true:ActiveDot or not A.PhoenixFlames:GetCooldown() == 0) and not A.InfernalCascade:IsConduitLearned() and A.FireBlast:GetSpellCharges() >= 1 and Unit("player"):HasBuffs(A.CombustionBuff.ID, true) and not Unit("player"):HasBuffsStacks(A.FirestormBuff.ID, true) and not Unit("player"):HasBuffsStacks(A.HotStreakBuff.ID, true) and hot_streak_spells_in_flight + Unit("player"):HasBuffsStacks(A.HeatingUpBuff.ID, true) < 2) then
                return A.FireBlast:Show(icon)
            end
            
            -- counterspell,if=runeforge.disciplinary_command.equipped&buff.disciplinary_command.down&buff.disciplinary_command_arcane.down&cooldown.buff_disciplinary_command.ready
            -- arcane_explosion,if=runeforge.disciplinary_command.equipped&buff.disciplinary_command.down&buff.disciplinary_command_arcane.down&cooldown.buff_disciplinary_command.ready
            if A.ArcaneExplosion:IsReady(unit) and (runeforge.disciplinary_command.equipped and Unit("player"):HasBuffsDown(A.DisciplinaryCommandBuff.ID, true) and Unit("player"):HasBuffsDown(A.DisciplinaryCommandArcaneBuff.ID, true) and A.BuffDisciplinaryCommand.ID, true:GetCooldown() == 0) then
                return A.ArcaneExplosion:Show(icon)
            end
            
            -- frostbolt,if=runeforge.disciplinary_command.equipped&buff.disciplinary_command.down&buff.disciplinary_command_frost.down
            if A.Frostbolt:IsReady(unit) and (runeforge.disciplinary_command.equipped and Unit("player"):HasBuffsDown(A.DisciplinaryCommandBuff.ID, true) and Unit("player"):HasBuffsDown(A.DisciplinaryCommandFrostBuff.ID, true)) then
                return A.Frostbolt:Show(icon)
            end
            
            -- call_action_list,name=active_talents
            if ActiveTalents(unit) then
                return true
            end
            
            -- combustion,use_off_gcd=1,use_while_casting=1,if=buff.combustion.down&(runeforge.disciplinary_command.equipped=buff.disciplinary_command.up)&(action.meteor.in_flight&action.meteor.in_flight_remains<=0.5|action.scorch.executing&action.scorch.execute_remains<0.5|action.fireball.executing&action.fireball.execute_remains<0.5|action.pyroblast.executing&action.pyroblast.execute_remains<0.5)
            if A.Combustion:IsReady(unit) and A.BurstIsON(unit) and (Unit("player"):HasBuffsDown(A.CombustionBuff.ID, true) and (runeforge.disciplinary_command.equipped == num(Unit("player"):HasBuffs(A.DisciplinaryCommandBuff.ID, true))) and (A.Meteor:IsSpellInFlight() and action.meteor.in_flight_remains <= 0.5 or action.scorch.executing and action.scorch.execute_remains < 0.5 or action.fireball.executing and action.fireball.execute_remains < 0.5 or action.pyroblast.executing and action.pyroblast.execute_remains < 0.5)) then
                return A.Combustion:Show(icon)
            end
            
            -- potion,if=buff.combustion.last_expire<=action.combustion.last_used
            if A.PotionofSpectralIntellect:IsReady(unit) and Potion and (buff.combustion.last_expire <= action.combustion.last_used) then
                return A.PotionofSpectralIntellect:Show(icon)
            end
            
            -- blood_fury,if=buff.combustion.last_expire<=action.combustion.last_used
            if A.BloodFury:AutoRacial(unit) and Racial and A.BurstIsON(unit) and (buff.combustion.last_expire <= action.combustion.last_used) then
                return A.BloodFury:Show(icon)
            end
            
            -- berserking,if=buff.combustion.last_expire<=action.combustion.last_used
            if A.Berserking:AutoRacial(unit) and Racial and A.BurstIsON(unit) and (buff.combustion.last_expire <= action.combustion.last_used) then
                return A.Berserking:Show(icon)
            end
            
            -- fireblood,if=buff.combustion.last_expire<=action.combustion.last_used
            if A.Fireblood:AutoRacial(unit) and Racial and A.BurstIsON(unit) and (buff.combustion.last_expire <= action.combustion.last_used) then
                return A.Fireblood:Show(icon)
            end
            
            -- ancestral_call,if=buff.combustion.last_expire<=action.combustion.last_used
            if A.AncestralCall:AutoRacial(unit) and Racial and A.BurstIsON(unit) and (buff.combustion.last_expire <= action.combustion.last_used) then
                return A.AncestralCall:Show(icon)
            end
            
            -- use_items,if=buff.combustion.last_expire<=action.combustion.last_used
            -- time_warp,if=runeforge.temporal_warp.equipped&buff.combustion.last_expire<=action.combustion.last_used&buff.exhaustion.up
            -- flamestrike,if=(buff.hot_streak.react|buff.firestorm.react)&active_enemies>=variable.combustion_flamestrike
            if A.Flamestrike:IsReady(unit) and ((Unit("player"):HasBuffsStacks(A.HotStreakBuff.ID, true) or Unit("player"):HasBuffsStacks(A.FirestormBuff.ID, true)) and MultiUnits:GetByRangeInCombat(40, 5, 10) >= VarCombustionFlamestrike) then
                return A.Flamestrike:Show(icon)
            end
            
            -- pyroblast,if=buff.sun_kings_blessing_ready.up&buff.sun_kings_blessing_ready.remains>cast_time
            if A.Pyroblast:IsReady(unit) and (Unit("player"):HasBuffs(A.SunKingsBlessingReadyBuff.ID, true) and Unit("player"):HasBuffs(A.SunKingsBlessingReadyBuff.ID, true) > A.Pyroblast:GetSpellCastTime()) then
                return A.Pyroblast:Show(icon)
            end
            
            -- pyroblast,if=buff.firestorm.react
            if A.Pyroblast:IsReady(unit) and (Unit("player"):HasBuffsStacks(A.FirestormBuff.ID, true)) then
                return A.Pyroblast:Show(icon)
            end
            
            -- pyroblast,if=buff.pyroclasm.react&buff.pyroclasm.remains>cast_time&(buff.combustion.remains>cast_time|buff.combustion.down)&active_enemies<variable.combustion_flamestrike
            if A.Pyroblast:IsReady(unit) and (Unit("player"):HasBuffsStacks(A.PyroclasmBuff.ID, true) and Unit("player"):HasBuffs(A.PyroclasmBuff.ID, true) > A.Pyroblast:GetSpellCastTime() and (Unit("player"):HasBuffs(A.CombustionBuff.ID, true) > A.Pyroblast:GetSpellCastTime() or Unit("player"):HasBuffsDown(A.CombustionBuff.ID, true)) and MultiUnits:GetByRangeInCombat(40, 5, 10) < VarCombustionFlamestrike) then
                return A.Pyroblast:Show(icon)
            end
            
            -- pyroblast,if=buff.hot_streak.react&buff.combustion.up
            if A.Pyroblast:IsReady(unit) and (Unit("player"):HasBuffsStacks(A.HotStreakBuff.ID, true) and Unit("player"):HasBuffs(A.CombustionBuff.ID, true)) then
                return A.Pyroblast:Show(icon)
            end
            
            -- pyroblast,if=prev_gcd.1.scorch&buff.heating_up.react&active_enemies<variable.combustion_flamestrike
            if A.Pyroblast:IsReady(unit) and (Player:PrevGCD(1, A.Scorch) and Unit("player"):HasBuffsStacks(A.HeatingUpBuff.ID, true) and MultiUnits:GetByRangeInCombat(40, 5, 10) < VarCombustionFlamestrike) then
                return A.Pyroblast:Show(icon)
            end
            
            -- phoenix_flames,if=buff.combustion.up&((action.fire_blast.charges<1&talent.pyroclasm.enabled&active_enemies=1)|!talent.pyroclasm.enabled|active_enemies>1)
            if A.PhoenixFlames:IsReady(unit) and (Unit("player"):HasBuffs(A.CombustionBuff.ID, true) and ((A.FireBlast:GetSpellCharges() < 1 and A.Pyroclasm:IsSpellLearned() and MultiUnits:GetByRangeInCombat(40, 5, 10) == 1) or not A.Pyroclasm:IsSpellLearned() or MultiUnits:GetByRangeInCombat(40, 5, 10) > 1)) then
                return A.PhoenixFlames:Show(icon)
            end
            
            -- fireball,if=buff.combustion.down&cooldown.combustion.remains<cast_time&!conduit.flame_accretion.enabled
            if A.Fireball:IsReady(unit) and (Unit("player"):HasBuffsDown(A.CombustionBuff.ID, true) and A.Combustion:GetCooldown() < A.Fireball:GetSpellCastTime() and not A.FlameAccretion:IsConduitLearned()) then
                return A.Fireball:Show(icon)
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
        
        --RopPhase
        local function RopPhase(unit)
        
            -- flamestrike,if=(active_enemies>=variable.hot_streak_flamestrike&(time-buff.combustion.last_expire>variable.delay_flamestrike|variable.disable_combustion))&(buff.hot_streak.react|buff.firestorm.react)
            if A.Flamestrike:IsReady(unit) and ((MultiUnits:GetByRangeInCombat(40, 5, 10) >= VarHotStreakFlamestrike and (Unit("player"):CombatTime() - buff.combustion.last_expire > VarDelayFlamestrike or VarDisableCombustion)) and (Unit("player"):HasBuffsStacks(A.HotStreakBuff.ID, true) or Unit("player"):HasBuffsStacks(A.FirestormBuff.ID, true))) then
                return A.Flamestrike:Show(icon)
            end
            
            -- pyroblast,if=buff.sun_kings_blessing_ready.up&buff.sun_kings_blessing_ready.remains>cast_time
            if A.Pyroblast:IsReady(unit) and (Unit("player"):HasBuffs(A.SunKingsBlessingReadyBuff.ID, true) and Unit("player"):HasBuffs(A.SunKingsBlessingReadyBuff.ID, true) > A.Pyroblast:GetSpellCastTime()) then
                return A.Pyroblast:Show(icon)
            end
            
            -- pyroblast,if=buff.firestorm.react
            if A.Pyroblast:IsReady(unit) and (Unit("player"):HasBuffsStacks(A.FirestormBuff.ID, true)) then
                return A.Pyroblast:Show(icon)
            end
            
            -- pyroblast,if=buff.hot_streak.react
            if A.Pyroblast:IsReady(unit) and (Unit("player"):HasBuffsStacks(A.HotStreakBuff.ID, true)) then
                return A.Pyroblast:Show(icon)
            end
            
            -- fire_blast,use_off_gcd=1,use_while_casting=1,if=buff.sun_kings_blessing_ready.down&!(active_enemies>=variable.hard_cast_flamestrike&(time-buff.combustion.last_expire>variable.delay_flamestrike|variable.disable_combustion))&!firestarter.active&(!buff.heating_up.react&!buff.hot_streak.react&!prev_off_gcd.fire_blast&(action.fire_blast.charges>=2|(talent.alexstraszas_fury.enabled&cooldown.dragons_breath.ready)|(talent.searing_touch.enabled&target.health.pct<=30)))
            if A.FireBlast:IsReady(unit) and (Unit("player"):HasBuffsDown(A.SunKingsBlessingReadyBuff.ID, true) and not (MultiUnits:GetByRangeInCombat(40, 5, 10) >= VarHardCastFlamestrike and (Unit("player"):CombatTime() - buff.combustion.last_expire > VarDelayFlamestrike or VarDisableCombustion)) and not S.Firestarter:ActiveStatus() and (not Unit("player"):HasBuffsStacks(A.HeatingUpBuff.ID, true) and not Unit("player"):HasBuffsStacks(A.HotStreakBuff.ID, true) and not Unit("player"):PrevOffGCDP(1, A.FireBlast) and (A.FireBlast:GetSpellCharges() >= 2 or (A.AlexstraszasFury:IsSpellLearned() and A.DragonsBreath:GetCooldown() == 0) or (A.SearingTouch:IsSpellLearned() and Unit(unit):HealthPercent() <= 30)))) then
                return A.FireBlast:Show(icon)
            end
            
            -- fire_blast,use_off_gcd=1,use_while_casting=1,if=!firestarter.active&(((action.fireball.executing|action.pyroblast.executing)&buff.heating_up.react)|(talent.searing_touch.enabled&target.health.pct<=30&(buff.heating_up.react&!action.scorch.executing|!buff.hot_streak.react&!buff.heating_up.react&action.scorch.executing&!hot_streak_spells_in_flight)))
            if A.FireBlast:IsReady(unit) and (not S.Firestarter:ActiveStatus() and (((action.fireball.executing or action.pyroblast.executing) and Unit("player"):HasBuffsStacks(A.HeatingUpBuff.ID, true)) or (A.SearingTouch:IsSpellLearned() and Unit(unit):HealthPercent() <= 30 and (Unit("player"):HasBuffsStacks(A.HeatingUpBuff.ID, true) and not action.scorch.executing or not Unit("player"):HasBuffsStacks(A.HotStreakBuff.ID, true) and not Unit("player"):HasBuffsStacks(A.HeatingUpBuff.ID, true) and action.scorch.executing and not hot_streak_spells_in_flight)))) then
                return A.FireBlast:Show(icon)
            end
            
            -- call_action_list,name=active_talents
            if ActiveTalents(unit) then
                return true
            end
            
            -- pyroblast,if=buff.pyroclasm.react&cast_time<buff.pyroclasm.remains&cast_time<buff.rune_of_power.remains&(buff.pyroclasm.react=buff.pyroclasm.max_stack|buff.pyroclasm.remains<cast_time+action.fireball.execute_time|buff.alexstraszas_fury.up|!runeforge.sun_kings_blessing.equipped)
            if A.Pyroblast:IsReady(unit) and (Unit("player"):HasBuffsStacks(A.PyroclasmBuff.ID, true) and A.Pyroblast:GetSpellCastTime() < Unit("player"):HasBuffs(A.PyroclasmBuff.ID, true) and A.Pyroblast:GetSpellCastTime() < Unit("player"):HasBuffs(A.RuneofPowerBuff.ID, true) and (Unit("player"):HasBuffsStacks(A.PyroclasmBuff.ID, true) == buff.pyroclasm.max_stack or Unit("player"):HasBuffs(A.PyroclasmBuff.ID, true) < A.Pyroblast:GetSpellCastTime() + A.Fireball:GetSpellCastTime() or Unit("player"):HasBuffs(A.AlexstraszasFuryBuff.ID, true) or not runeforge.sun_kings_blessing.equipped)) then
                return A.Pyroblast:Show(icon)
            end
            
            -- pyroblast,if=prev_gcd.1.scorch&buff.heating_up.react&talent.searing_touch.enabled&target.health.pct<=30&!(active_enemies>=variable.hot_streak_flamestrike&(time-buff.combustion.last_expire>variable.delay_flamestrike|variable.disable_combustion))
            if A.Pyroblast:IsReady(unit) and (Player:PrevGCD(1, A.Scorch) and Unit("player"):HasBuffsStacks(A.HeatingUpBuff.ID, true) and A.SearingTouch:IsSpellLearned() and Unit(unit):HealthPercent() <= 30 and not (MultiUnits:GetByRangeInCombat(40, 5, 10) >= VarHotStreakFlamestrike and (Unit("player"):CombatTime() - buff.combustion.last_expire > VarDelayFlamestrike or VarDisableCombustion))) then
                return A.Pyroblast:Show(icon)
            end
            
            -- phoenix_flames,if=!variable.phoenix_pooling&buff.heating_up.react&!buff.hot_streak.react&(active_dot.ignite<2|active_enemies>=variable.hard_cast_flamestrike|active_enemies>=variable.hot_streak_flamestrike)
            if A.PhoenixFlames:IsReady(unit) and (not VarPhoenixPooling and Unit("player"):HasBuffsStacks(A.HeatingUpBuff.ID, true) and not Unit("player"):HasBuffsStacks(A.HotStreakBuff.ID, true) and (A.IgniteDebuff.ID, true:ActiveDot < 2 or MultiUnits:GetByRangeInCombat(40, 5, 10) >= VarHardCastFlamestrike or MultiUnits:GetByRangeInCombat(40, 5, 10) >= VarHotStreakFlamestrike)) then
                return A.PhoenixFlames:Show(icon)
            end
            
            -- scorch,if=target.health.pct<=30&talent.searing_touch.enabled
            if A.Scorch:IsReady(unit) and (Unit(unit):HealthPercent() <= 30 and A.SearingTouch:IsSpellLearned()) then
                return A.Scorch:Show(icon)
            end
            
            -- dragons_breath,if=active_enemies>2
            if A.DragonsBreath:IsReady(unit) and (MultiUnits:GetByRangeInCombat(40, 5, 10) > 2) then
                return A.DragonsBreath:Show(icon)
            end
            
            -- arcane_explosion,if=active_enemies>=variable.arcane_explosion&mana.pct>=variable.arcane_explosion_mana
            if A.ArcaneExplosion:IsReady(unit) and (MultiUnits:GetByRangeInCombat(40, 5, 10) >= VarArcaneExplosion and Player:ManaPercentageP() >= VarArcaneExplosionMana) then
                return A.ArcaneExplosion:Show(icon)
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
        
            -- flamestrike,if=(active_enemies>=variable.hot_streak_flamestrike&(time-buff.combustion.last_expire>variable.delay_flamestrike|variable.disable_combustion))&(buff.hot_streak.react|buff.firestorm.react)
            if A.Flamestrike:IsReady(unit) and ((MultiUnits:GetByRangeInCombat(40, 5, 10) >= VarHotStreakFlamestrike and (Unit("player"):CombatTime() - buff.combustion.last_expire > VarDelayFlamestrike or VarDisableCombustion)) and (Unit("player"):HasBuffsStacks(A.HotStreakBuff.ID, true) or Unit("player"):HasBuffsStacks(A.FirestormBuff.ID, true))) then
                return A.Flamestrike:Show(icon)
            end
            
            -- pyroblast,if=buff.firestorm.react
            if A.Pyroblast:IsReady(unit) and (Unit("player"):HasBuffsStacks(A.FirestormBuff.ID, true)) then
                return A.Pyroblast:Show(icon)
            end
            
            -- pyroblast,if=buff.hot_streak.react&buff.hot_streak.remains<action.fireball.execute_time
            if A.Pyroblast:IsReady(unit) and (Unit("player"):HasBuffsStacks(A.HotStreakBuff.ID, true) and Unit("player"):HasBuffs(A.HotStreakBuff.ID, true) < A.Fireball:GetSpellCastTime()) then
                return A.Pyroblast:Show(icon)
            end
            
            -- pyroblast,if=buff.hot_streak.react&(prev_gcd.1.fireball|firestarter.active|action.pyroblast.in_flight)
            if A.Pyroblast:IsReady(unit) and (Unit("player"):HasBuffsStacks(A.HotStreakBuff.ID, true) and (Player:PrevGCD(1, A.Fireball) or S.Firestarter:ActiveStatus() or A.Pyroblast:IsSpellInFlight())) then
                return A.Pyroblast:Show(icon)
            end
            
            -- pyroblast,if=buff.sun_kings_blessing_ready.up&(cooldown.rune_of_power.remains+action.rune_of_power.execute_time+cast_time>buff.sun_kings_blessing_ready.remains|!talent.rune_of_power.enabled)&variable.time_to_combustion+cast_time>buff.sun_kings_blessing_ready.remains
            if A.Pyroblast:IsReady(unit) and (Unit("player"):HasBuffs(A.SunKingsBlessingReadyBuff.ID, true) and (A.RuneofPower:GetCooldown() + A.RuneofPower:GetSpellCastTime() + A.Pyroblast:GetSpellCastTime() > Unit("player"):HasBuffs(A.SunKingsBlessingReadyBuff.ID, true) or not A.RuneofPower:IsSpellLearned()) and VarTimeToCombustion + A.Pyroblast:GetSpellCastTime() > Unit("player"):HasBuffs(A.SunKingsBlessingReadyBuff.ID, true)) then
                return A.Pyroblast:Show(icon)
            end
            
            -- pyroblast,if=buff.hot_streak.react&target.health.pct<=30&talent.searing_touch.enabled
            if A.Pyroblast:IsReady(unit) and (Unit("player"):HasBuffsStacks(A.HotStreakBuff.ID, true) and Unit(unit):HealthPercent() <= 30 and A.SearingTouch:IsSpellLearned()) then
                return A.Pyroblast:Show(icon)
            end
            
            -- pyroblast,if=buff.pyroclasm.react&cast_time<buff.pyroclasm.remains&(buff.pyroclasm.react=buff.pyroclasm.max_stack|buff.pyroclasm.remains<cast_time+action.fireball.execute_time|buff.alexstraszas_fury.up|!runeforge.sun_kings_blessing.equipped)
            if A.Pyroblast:IsReady(unit) and (Unit("player"):HasBuffsStacks(A.PyroclasmBuff.ID, true) and A.Pyroblast:GetSpellCastTime() < Unit("player"):HasBuffs(A.PyroclasmBuff.ID, true) and (Unit("player"):HasBuffsStacks(A.PyroclasmBuff.ID, true) == buff.pyroclasm.max_stack or Unit("player"):HasBuffs(A.PyroclasmBuff.ID, true) < A.Pyroblast:GetSpellCastTime() + A.Fireball:GetSpellCastTime() or Unit("player"):HasBuffs(A.AlexstraszasFuryBuff.ID, true) or not runeforge.sun_kings_blessing.equipped)) then
                return A.Pyroblast:Show(icon)
            end
            
            -- fire_blast,use_off_gcd=1,use_while_casting=1,if=!firestarter.active&!variable.fire_blast_pooling&(((action.fireball.executing|action.pyroblast.executing)&buff.heating_up.react)|(talent.searing_touch.enabled&target.health.pct<=30&(buff.heating_up.react&!action.scorch.executing|!buff.hot_streak.react&!buff.heating_up.react&action.scorch.executing&!hot_streak_spells_in_flight)))
            if A.FireBlast:IsReady(unit) and (not S.Firestarter:ActiveStatus() and not VarFireBlastPooling and (((action.fireball.executing or action.pyroblast.executing) and Unit("player"):HasBuffsStacks(A.HeatingUpBuff.ID, true)) or (A.SearingTouch:IsSpellLearned() and Unit(unit):HealthPercent() <= 30 and (Unit("player"):HasBuffsStacks(A.HeatingUpBuff.ID, true) and not action.scorch.executing or not Unit("player"):HasBuffsStacks(A.HotStreakBuff.ID, true) and not Unit("player"):HasBuffsStacks(A.HeatingUpBuff.ID, true) and action.scorch.executing and not hot_streak_spells_in_flight)))) then
                return A.FireBlast:Show(icon)
            end
            
            -- pyroblast,if=prev_gcd.1.scorch&buff.heating_up.react&talent.searing_touch.enabled&target.health.pct<=30&!(active_enemies>=variable.hot_streak_flamestrike&(time-buff.combustion.last_expire>variable.delay_flamestrike|variable.disable_combustion))
            if A.Pyroblast:IsReady(unit) and (Player:PrevGCD(1, A.Scorch) and Unit("player"):HasBuffsStacks(A.HeatingUpBuff.ID, true) and A.SearingTouch:IsSpellLearned() and Unit(unit):HealthPercent() <= 30 and not (MultiUnits:GetByRangeInCombat(40, 5, 10) >= VarHotStreakFlamestrike and (Unit("player"):CombatTime() - buff.combustion.last_expire > VarDelayFlamestrike or VarDisableCombustion))) then
                return A.Pyroblast:Show(icon)
            end
            
            -- phoenix_flames,if=!variable.phoenix_pooling&(!talent.from_the_ashes.enabled|active_enemies>1)&(active_dot.ignite<2|active_enemies>=variable.hard_cast_flamestrike|active_enemies>=variable.hot_streak_flamestrike)
            if A.PhoenixFlames:IsReady(unit) and (not VarPhoenixPooling and (not A.FromtheAshes:IsSpellLearned() or MultiUnits:GetByRangeInCombat(40, 5, 10) > 1) and (A.IgniteDebuff.ID, true:ActiveDot < 2 or MultiUnits:GetByRangeInCombat(40, 5, 10) >= VarHardCastFlamestrike or MultiUnits:GetByRangeInCombat(40, 5, 10) >= VarHotStreakFlamestrike)) then
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
            
            -- scorch,if=target.health.pct<=30&talent.searing_touch.enabled
            if A.Scorch:IsReady(unit) and (Unit(unit):HealthPercent() <= 30 and A.SearingTouch:IsSpellLearned()) then
                return A.Scorch:Show(icon)
            end
            
            -- arcane_explosion,if=active_enemies>=variable.arcane_explosion&mana.pct>=variable.arcane_explosion_mana
            if A.ArcaneExplosion:IsReady(unit) and (MultiUnits:GetByRangeInCombat(40, 5, 10) >= VarArcaneExplosion and Player:ManaPercentageP() >= VarArcaneExplosionMana) then
                return A.ArcaneExplosion:Show(icon)
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

                    -- counterspell,if=!runeforge.disciplinary_command.equipped
            -- variable,name=time_to_combustion,op=set,value=talent.firestarter.enabled*firestarter.remains+(cooldown.combustion.remains*(1-variable.kindling_reduction*talent.kindling.enabled))*!cooldown.combustion.ready*buff.combustion.down
            VarTimeToCombustion = num(A.Firestarter:IsSpellLearned()) * S.Firestarter:ActiveRemains() + (A.Combustion:GetCooldown() * (1 - VarKindlingReduction * num(A.Kindling:IsSpellLearned()))) * num(not A.Combustion:GetCooldown() == 0) * Unit("player"):HasBuffsDown(A.CombustionBuff.ID, true)
            
            -- cycling_variable,name=ignite_min,op=min,value=dot.ignite.tick_dmg
            if A.CyclingVariable:IsReady(unit) then
                return A.CyclingVariable:Show(icon) = math.min(return A.CyclingVariable:Show(icon), dot.ignite.tick_dmg)
            end
            
            -- shifting_power,if=buff.combustion.down&buff.rune_of_power.down&cooldown.combustion.remains>0&(cooldown.rune_of_power.remains>0|!talent.rune_of_power.enabled)
            if A.ShiftingPower:IsReady(unit) and (Unit("player"):HasBuffsDown(A.CombustionBuff.ID, true) and Unit("player"):HasBuffsDown(A.RuneofPowerBuff.ID, true) and A.Combustion:GetCooldown() > 0 and (A.RuneofPower:GetCooldown() > 0 or not A.RuneofPower:IsSpellLearned())) then
                return A.ShiftingPower:Show(icon)
            end
            
            -- radiant_spark,if=(buff.combustion.down&buff.rune_of_power.down&(cooldown.combustion.remains<execute_time|cooldown.combustion.remains>cooldown.radiant_spark.duration))|(buff.rune_of_power.up&cooldown.combustion.remains>30)
            if A.RadiantSpark:IsReady(unit) and ((Unit("player"):HasBuffsDown(A.CombustionBuff.ID, true) and Unit("player"):HasBuffsDown(A.RuneofPowerBuff.ID, true) and (A.Combustion:GetCooldown() < A.RadiantSpark:GetSpellCastTime() or A.Combustion:GetCooldown() > A.RadiantSpark:BaseDuration())) or (Unit("player"):HasBuffs(A.RuneofPowerBuff.ID, true) and A.Combustion:GetCooldown() > 30)) then
                return A.RadiantSpark:Show(icon)
            end
            
            -- deathborne,if=buff.combustion.down&buff.rune_of_power.down&cooldown.combustion.remains<execute_time
            if A.Deathborne:IsReady(unit) and (Unit("player"):HasBuffsDown(A.CombustionBuff.ID, true) and Unit("player"):HasBuffsDown(A.RuneofPowerBuff.ID, true) and A.Combustion:GetCooldown() < A.Deathborne:GetSpellCastTime()) then
                return A.Deathborne:Show(icon)
            end
            
            -- mirror_image,if=buff.combustion.down&debuff.radiant_spark_vulnerability.down
            if A.MirrorImage:IsReady(unit) and (Unit("player"):HasBuffsDown(A.CombustionBuff.ID, true) and Unit(unit):HasDeBuffsDown(A.RadiantSparkVulnerabilityDebuff.ID, true)) then
                return A.MirrorImage:Show(icon)
            end
            
            -- use_item,name=azsharas_font_of_power,if=variable.time_to_combustion<=5+15*variable.font_double_on_use&variable.time_to_combustion>0&!variable.disable_combustion
            if A.AzsharasFontofPower:IsReady(unit) and (VarTimeToCombustion <= 5 + 15 * VarFontDoubleOnUse and VarTimeToCombustion > 0 and not VarDisableCombustion) then
                return A.AzsharasFontofPower:Show(icon)
            end
            
            -- guardian_of_azeroth,if=(variable.time_to_combustion<10|fight_remains<variable.time_to_combustion)&!variable.disable_combustion
            if A.GuardianofAzeroth:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and ((VarTimeToCombustion < 10 or fight_remains < VarTimeToCombustion) and not VarDisableCombustion) then
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
            
            -- counterspell,if=runeforge.disciplinary_command.equipped&cooldown.buff_disciplinary_command.ready&buff.disciplinary_command_arcane.down&cooldown.combustion.remains>30&!buff.disciplinary_command.up
            -- arcane_explosion,if=runeforge.disciplinary_command.equipped&cooldown.buff_disciplinary_command.ready&buff.disciplinary_command_arcane.down&cooldown.combustion.remains>30&!buff.disciplinary_command.up
            if A.ArcaneExplosion:IsReady(unit) and (runeforge.disciplinary_command.equipped and A.BuffDisciplinaryCommand.ID, true:GetCooldown() == 0 and Unit("player"):HasBuffsDown(A.DisciplinaryCommandArcaneBuff.ID, true) and A.Combustion:GetCooldown() > 30 and not Unit("player"):HasBuffs(A.DisciplinaryCommandBuff.ID, true)) then
                return A.ArcaneExplosion:Show(icon)
            end
            
            -- frostbolt,if=runeforge.disciplinary_command.equipped&cooldown.buff_disciplinary_command.ready&buff.disciplinary_command_frost.down&cooldown.combustion.remains>30&!buff.disciplinary_command.up
            if A.Frostbolt:IsReady(unit) and (runeforge.disciplinary_command.equipped and A.BuffDisciplinaryCommand.ID, true:GetCooldown() == 0 and Unit("player"):HasBuffsDown(A.DisciplinaryCommandFrostBuff.ID, true) and A.Combustion:GetCooldown() > 30 and not Unit("player"):HasBuffs(A.DisciplinaryCommandBuff.ID, true)) then
                return A.Frostbolt:Show(icon)
            end
            
            -- rune_of_power,if=buff.rune_of_power.down&(variable.time_to_combustion>buff.rune_of_power.duration&variable.time_to_combustion>action.fire_blast.full_recharge_time|variable.time_to_combustion>fight_remains|variable.disable_combustion)
            if A.RuneofPower:IsReady(unit) and (Unit("player"):HasBuffsDown(A.RuneofPowerBuff.ID, true) and (VarTimeToCombustion > A.RuneofPowerBuff.ID, true:BaseDuration() and VarTimeToCombustion > A.FireBlast:GetSpellChargesFullRechargeTime() or VarTimeToCombustion > fight_remains or VarDisableCombustion)) then
                return A.RuneofPower:Show(icon)
            end
            
            -- call_action_list,name=combustion_phase,if=!variable.disable_combustion&variable.time_to_combustion<=0
            if A.BurstIsON(unit) and (not VarDisableCombustion and VarTimeToCombustion <= 0) then
                if CombustionPhase(unit) then
                    return true
                end
            end
            
            -- variable,name=fire_blast_pooling,value=!variable.disable_combustion&variable.time_to_combustion<action.fire_blast.full_recharge_time-variable.shifting_power_reduction*(cooldown.shifting_power.remains<variable.time_to_combustion)&variable.time_to_combustion<fight_remains|runeforge.sun_kings_blessing.equipped&action.fire_blast.charges_fractional<action.fire_blast.max_charges-0.5&(cooldown.shifting_power.remains>15|!covenant.night_fae.enabled)
            VarFireBlastPooling = num(not VarDisableCombustion and VarTimeToCombustion < A.FireBlast:GetSpellChargesFullRechargeTime() - VarShiftingPowerReduction * num((A.ShiftingPower:GetCooldown() < VarTimeToCombustion)) and VarTimeToCombustion < fight_remains or runeforge.sun_kings_blessing.equipped and A.FireBlast:GetSpellChargesFrac() < A.FireBlast:GetSpellChargesMax() - 0.5 and (A.ShiftingPower:GetCooldown() > 15 or not A.NightFae:IsCovenantLearned()))
            
            -- call_action_list,name=rop_phase,if=buff.rune_of_power.up&(variable.time_to_combustion>0|variable.disable_combustion)
            if (Unit("player"):HasBuffs(A.RuneofPowerBuff.ID, true) and (VarTimeToCombustion > 0 or VarDisableCombustion)) then
                if RopPhase(unit) then
                    return true
                end
            end
            
            -- variable,name=phoenix_pooling,value=!variable.disable_combustion&variable.time_to_combustion<action.phoenix_flames.full_recharge_time&variable.time_to_combustion<fight_remains|runeforge.sun_kings_blessing.equipped
            VarPhoenixPooling = num(not VarDisableCombustion and VarTimeToCombustion < A.PhoenixFlames:GetSpellChargesFullRechargeTime() and VarTimeToCombustion < fight_remains or runeforge.sun_kings_blessing.equipped)
            
            -- fire_blast,use_off_gcd=1,use_while_casting=1,if=!variable.fire_blast_pooling&(variable.time_to_combustion>0|variable.disable_combustion)&(active_enemies>=variable.hard_cast_flamestrike&(time-buff.combustion.last_expire>variable.delay_flamestrike|variable.disable_combustion))&!firestarter.active&!buff.hot_streak.react
            if A.FireBlast:IsReady(unit) and (not VarFireBlastPooling and (VarTimeToCombustion > 0 or VarDisableCombustion) and (MultiUnits:GetByRangeInCombat(40, 5, 10) >= VarHardCastFlamestrike and (Unit("player"):CombatTime() - buff.combustion.last_expire > VarDelayFlamestrike or VarDisableCombustion)) and not S.Firestarter:ActiveStatus() and not Unit("player"):HasBuffsStacks(A.HotStreakBuff.ID, true)) then
                return A.FireBlast:Show(icon)
            end
            
            -- fire_blast,use_off_gcd=1,use_while_casting=1,if=firestarter.active&charges>=1&!variable.fire_blast_pooling&(!action.fireball.executing&!action.pyroblast.in_flight&buff.heating_up.react|action.fireball.executing&!buff.hot_streak.react|action.pyroblast.in_flight&buff.heating_up.react&!buff.hot_streak.react)
            if A.FireBlast:IsReady(unit) and (S.Firestarter:ActiveStatus() and A.FireBlast:GetSpellCharges() >= 1 and not VarFireBlastPooling and (not action.fireball.executing and not A.Pyroblast:IsSpellInFlight() and Unit("player"):HasBuffsStacks(A.HeatingUpBuff.ID, true) or action.fireball.executing and not Unit("player"):HasBuffsStacks(A.HotStreakBuff.ID, true) or A.Pyroblast:IsSpellInFlight() and Unit("player"):HasBuffsStacks(A.HeatingUpBuff.ID, true) and not Unit("player"):HasBuffsStacks(A.HotStreakBuff.ID, true))) then
                return A.FireBlast:Show(icon)
            end
            
            -- call_action_list,name=standard_rotation,if=(variable.time_to_combustion>0|variable.disable_combustion)&buff.rune_of_power.down
            if ((VarTimeToCombustion > 0 or VarDisableCombustion) and Unit("player"):HasBuffsDown(A.RuneofPowerBuff.ID, true)) then
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

