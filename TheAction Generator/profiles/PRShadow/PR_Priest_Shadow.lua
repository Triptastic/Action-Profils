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

Action[ACTION_CONST_PRIEST_SHADOW] = {
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
    ShadowformBuff                         = Create({ Type = "Spell", ID = 232698 }),
    Shadowform                             = Create({ Type = "Spell", ID = 232698 }),
    VampiricTouchDebuff                    = Create({ Type = "Spell", ID = 34914 }),
    VampiricTouch                          = Create({ Type = "Spell", ID = 34914 }),
    Silence                                = Create({ Type = "Spell", ID = 15487 }),
    SearingNightmare                       = Create({ Type = "Spell", ID =  }),
    ShadowWordPainDebuff                   = Create({ Type = "Spell", ID = 589 }),
    MindBlast                              = Create({ Type = "Spell", ID = 8092 }),
    ReapingFlames                          = Create({ Type = "Spell", ID =  }),
    VoidEruption                           = Create({ Type = "Spell", ID = 228260 }),
    ShadowWordPain                         = Create({ Type = "Spell", ID = 589 }),
    FaeGuardiansBuff                       = Create({ Type = "Spell", ID =  }),
    WrathfulFaerieDebuff                   = Create({ Type = "Spell", ID =  }),
    MindSear                               = Create({ Type = "Spell", ID = 48045 }),
    Mindbender                             = Create({ Type = "Spell", ID = 200174 }),
    Damnation                              = Create({ Type = "Spell", ID =  }),
    VoidBolt                               = Create({ Type = "Spell", ID = 205448 }),
    HungeringVoid                          = Create({ Type = "Spell", ID =  }),
    DevouringPlague                        = Create({ Type = "Spell", ID =  }),
    ShadowWordDeath                        = Create({ Type = "Spell", ID = 32379 }),
    SurrenderToMadness                     = Create({ Type = "Spell", ID = 193223 }),
    VoidformBuff                           = Create({ Type = "Spell", ID = 194249 }),
    VoidTorrent                            = Create({ Type = "Spell", ID = 263165 }),
    TwistofFate                            = Create({ Type = "Spell", ID = 109142 }),
    ShadowCrash                            = Create({ Type = "Spell", ID = 205385 }),
    ShadowCrashDeBuffDebuff                = Create({ Type = "Spell", ID =  }),
    DarkThoughtsBuff                       = Create({ Type = "Spell", ID =  }),
    MindFlay                               = Create({ Type = "Spell", ID = 15407 }),
    Misery                                 = Create({ Type = "Spell", ID = 238558 }),
    UnfurlingDarknessBuff                  = Create({ Type = "Spell", ID =  }),
    PsychicLink                            = Create({ Type = "Spell", ID =  }),
    DevouringPlagueDebuff                  = Create({ Type = "Spell", ID =  }),
    PowerInfusion                          = Create({ Type = "Spell", ID =  })
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
Action:CreateEssencesFor(ACTION_CONST_PRIEST_SHADOW)  -- where PLAYERSPEC is Constance (example: ACTION_CONST_MONK_BM)
local A = setmetatable(Action[ACTION_CONST_PRIEST_SHADOW], { __index = Action })


------------------------------------------
---------------- VARIABLES ---------------
------------------------------------------
local VarMindSearCutoff = 0;
local VarSearingNightmareCutoff = 0;
local VarPiOrVfSyncCondition = 0;
local VarAllDotsUp = 0;
local VarDotsUp = 0;

A.Listener:Add("ROTATION_VARS", "PLAYER_REGEN_ENABLED", function()
  VarMindSearCutoff = 0
  VarSearingNightmareCutoff = 0
  VarPiOrVfSyncCondition = 0
  VarAllDotsUp = 0
  VarDotsUp = 0
end)



local function num(val)
    if val then return 1 else return 0 end
end

local function bool(val)
    return val ~= 0
end

------------------------------------------
---------- SHADOW PRE APL SETUP ----------
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
	VampiricTouchDelay                      = 0,
}

local IsIndoors, UnitIsUnit = IsIndoors, UnitIsUnit

local function IsSchoolFree()
	return LoC:IsMissed("SILENCE") and LoC:Get("SCHOOL_INTERRUPT", "SHADOW") == 0
end 

local function InRange(unit)
	-- @return boolean 
	return A.VampiricTouch:IsInRange(unit)
end 
InRange = A.MakeFunctionCachedDynamic(InRange)

local function GetByRange(count, range, isStrictlySuperior, isStrictlyInferior, isStrictlyEqual, isCheckEqual, isCheckCombat)
	-- @return boolean 
	local c = 0 
	
	if isStrictlySuperior == nil then
	    isStrictlySuperior = false
	end

	if isStrictlyInferior == nil then
	    isStrictlyInferior = false
	end	
	
	if isStrictlyEqual == nil then
	    isStrictlyEqual = false
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
			if isStrictlySuperior and not isStrictlyInferior and not isStrictlyEqual then
			    if c > count then
				    return true
				end
			end
			
			-- Strictly inferior <
			if isStrictlyInferior and not isStrictlySuperior and not isStrictlyEqual then
			    if c < count then
			        return true
				end
			end
			
			-- Strictly equal ==
			if not isStrictlyInferior and not isStrictlySuperior and isStrictlyEqual then
			    if c == count then
			        return true
				end
			end	
			
			-- Classic >=
			if not isStrictlyInferior and not isStrictlySuperior and not isStrictlyEqual then
			    if c >= count then 
				    return true 
			    end 
			end
		end 
		
	end
	
end  
GetByRange = A.MakeFunctionCachedDynamic(GetByRange)

-- InsanityThreshold
local function InsanityThreshold()
	return A.LegacyOfTheVoid:IsSpellLearned() and 60 or 90
end

-- ExecuteRange
local function ExecuteRange()
	return 20
end

-- Non GCD spell check
local function countInterruptGCD(unit)
    if not A.Silence:IsReadyByPassCastGCD(unit) or not A.Silence:AbsentImun(unit, Temp.TotalAndMagKick) then
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
	    -- Silence
        if useKick and A.Silence:IsReady(unit) and A.Silence:AbsentImun(unit, Temp.TotalAndMagKick, true) then 
   	        -- Notification					
            Action.SendNotification("Silence interrupting...", A.Silence.ID)
	    	return A.Silence
        end 
    
	    -- Fear Disarm
        if useCC and A.PsychicHorror:IsReady(unit) and A.PsychicHorror:AbsentImun(unit, Temp.TotalAndMagKick, true) and Unit(unit):IsControlAble("stun", 0) then 
   	        -- Notification					
            Action.SendNotification("Psychic Horror interrupting...", A.PsychicHorror.ID)
            return A.PsychicHorror              
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

-- Defensives
local function SelfDefensives()
    if Unit(player):CombatTime() == 0 then  
        return 
    end
    
    local VampiricEmbrace = A.GetToggle(2, "VampiricEmbrace")
    if    VampiricEmbrace >= 0 and A.VampiricEmbrace:IsReady(player) and 
    (
        (     -- Auto 
            VampiricEmbrace >= 100 and 
            (
                (
                    not A.IsInPvP and 
                    Unit(player):HealthPercent() < 80 and 
                    Unit(player):TimeToDieX(20) < 8 
                ) or 
                (
                    A.IsInPvP and 
                    (
                        Unit(player):UseDeff() or 
                        (
                            Unit(player, 5):HasFlags() and 
                            Unit(player):GetRealTimeDMG() > 0 and 
                            Unit(player):IsFocused(nil, true)                                 
                        )
                    )
                )
            ) and 
            Unit(player):HasBuffs("DeffBuffs") == 0
        ) or 
        (    -- Custom
            VampiricEmbrace < 100 and 
            Unit(player):HealthPercent() <= VampiricEmbrace
        )
    ) 
    then 
        return A.VampiricEmbrace
    end 
end 
SelfDefensives = A.MakeFunctionCachedStatic(SelfDefensives)

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

-- Insanity Drain 
local function InsanityDrain()
    return (Unit(player):HasBuffs(A.VoidformBuff.ID, true) > 0) and (math.ceil(5 + Unit(player):HasBuffsStacks(A.VoidformBuff.ID, true) * 0.68)) or 0
end

local function EvaluateCycleSilence24(unit)
    return runeforge.sephuzs_proclamation.equipped and (target.is_add or Unit(unit):IsCasting)
end

local function EvaluateCycleSearingNightmare34(unit)
    return (VarSearingNightmareCutoff and not VarPiOrVfSyncCondition) or (Unit(unit):HasDeBuffsRefreshable(A.ShadowWordPainDebuff.ID, true) and MultiUnits:GetByRangeInCombat(40, 5, 10) > 1)
end

local function EvaluateCycleSearingNightmare47(unit)
    return A.SearingNightmare:IsSpellLearned() and Unit(unit):HasDeBuffsRefreshable(A.ShadowWordPainDebuff.ID, true) and MultiUnits:GetByRangeInCombat(40, 5, 10) > 2
end

local function EvaluateCycleMindSear96(unit)
    return A.SearingNightmare:IsSpellLearned() and MultiUnits:GetByRangeInCombat(40, 5, 10) > (VarMindSearCutoff + 1) and not Unit(unit):HasDeBuffs(A.ShadowWordPainDebuff.ID, true) and not A.Mindbender:GetCooldown() == 0
end

local function EvaluateCycleDamnation111(unit)
    return not VarAllDotsUp
end

local function EvaluateCycleDevouringPlague124(unit)
    return (refreshable or Player:Insanity() > 75) and not VarPiOrVfSyncCondition and (not A.SearingNightmare:IsSpellLearned() or (A.SearingNightmare:IsSpellLearned() and not VarSearingNightmareCutoff))
end

local function EvaluateCycleShadowWordDeath145(unit)
    return (Unit(unit):HealthPercent() < 20 and MultiUnits:GetByRangeInCombat(40, 5, 10) < 4) or (pet.fiend.active and runeforge.shadowflame_prism.equipped)
end

local function EvaluateCycleSurrenderToMadness152(unit)
    return Unit(unit):TimeToDie() < 25 and Unit("player"):HasBuffsDown(A.VoidformBuff.ID, true)
end

local function EvaluateCycleVoidTorrent171(unit)
    return VarDotsUp and Unit(unit):TimeToDie() > 4 and Unit("player"):HasBuffsDown(A.VoidformBuff.ID, true) and MultiUnits:GetByRangeInCombat(40, 5, 10) < (5 + (6 * num(A.TwistofFate:IsSpellLearned())))
end

local function EvaluateCycleMindSear204(unit)
    return MultiUnits:GetByRangeInCombat(40, 5, 10) > VarMindSearCutoff and Unit("player"):HasBuffs(A.DarkThoughtsBuff.ID, true)
end

local function EvaluateCycleVampiricTouch229(unit)
    return Unit(unit):HasDeBuffsRefreshable(A.VampiricTouchDebuff.ID, true) and Unit(unit):TimeToDie() > 6 or (A.Misery:IsSpellLearned() and Unit(unit):HasDeBuffsRefreshable(A.ShadowWordPainDebuff.ID, true)) or Unit("player"):HasBuffs(A.UnfurlingDarknessBuff.ID, true)
end

local function EvaluateCycleShadowWordPain260(unit)
    return Unit(unit):HasDeBuffsRefreshable(A.ShadowWordPainDebuff.ID, true) and Unit(unit):TimeToDie() > 4 and not A.Misery:IsSpellLearned() and not (A.SearingNightmare:IsSpellLearned() and MultiUnits:GetByRangeInCombat(40, 5, 10) > (VarMindSearCutoff + 1)) and (not A.PsychicLink:IsSpellLearned() or (A.PsychicLink:IsSpellLearned() and MultiUnits:GetByRangeInCombat(40, 5, 10) <= 2))
end

local function EvaluateCycleMindSear283(unit)
    return MultiUnits:GetByRangeInCombat(40, 5, 10) > VarMindSearCutoff
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
            -- potion
            if A.PotionofSpectralIntellect:IsReady(unit) and Potion then
                return A.PotionofSpectralIntellect:Show(icon)
            end
            
            -- shadowform,if=!buff.shadowform.up
            if A.Shadowform:IsReady(unit) and Unit("player"):HasBuffsDown(A.ShadowformBuff.ID, true) and (not Unit("player"):HasBuffs(A.ShadowformBuff.ID, true)) then
                return A.Shadowform:Show(icon)
            end
            
            -- use_item,name=azsharas_font_of_power
            if A.AzsharasFontofPower:IsReady(unit) then
                return A.AzsharasFontofPower:Show(icon)
            end
            
            -- variable,name=mind_sear_cutoff,op=set,value=1
            VarMindSearCutoff = 1
            
            -- vampiric_touch
            if A.VampiricTouch:IsReady(unit) and Unit("player"):HasDebuffsDown(A.VampiricTouchDebuff.ID, true) and inCombat and Unit(unit):IsExists() and unit ~= "mouseover" then
                return A.VampiricTouch:Show(icon)
            end
            
        end
        
        --Cds
        local function Cds(unit)
        
            -- silence,target_if=runeforge.sephuzs_proclamation.equipped&(target.is_add|target.debuff.casting.react)
            if A.Silence:IsReady(unit) and Action.GetToggle.InterruptEnabled then
                if Action.Utils.CastTargetIf(A.Silence, 40, "min", EvaluateCycleSilence24) then
                    return A.Silence:Show(icon) 
                end
            end
            -- call_action_list,name=essences
            if Essences(unit) then
                return true
            end
            
            -- use_items
        end
        
        --Cwc
        local function Cwc(unit)
        
            -- searing_nightmare,use_while_casting=1,target_if=(variable.searing_nightmare_cutoff&!variable.pi_or_vf_sync_condition)|(dot.shadow_word_pain.refreshable&spell_targets.mind_sear>1)
            if A.SearingNightmare:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.SearingNightmare, 40, "min", EvaluateCycleSearingNightmare34) then
                    return A.SearingNightmare:Show(icon) 
                end
            end
            -- searing_nightmare,use_while_casting=1,target_if=talent.searing_nightmare.enabled&dot.shadow_word_pain.refreshable&spell_targets.mind_sear>2
            if A.SearingNightmare:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.SearingNightmare, 40, "min", EvaluateCycleSearingNightmare47) then
                    return A.SearingNightmare:Show(icon) 
                end
            end
            -- mind_blast,only_cwc=1
            if A.MindBlast:IsReady(unit) then
                return A.MindBlast:Show(icon)
            end
            
        end
        
        --Essences
        local function Essences(unit)
        
            -- memory_of_lucid_dreams
            if A.MemoryofLucidDreams:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth then
                return A.MemoryofLucidDreams:Show(icon)
            end
            
            -- blood_of_the_enemy
            if A.BloodoftheEnemy:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth then
                return A.BloodoftheEnemy:Show(icon)
            end
            
            -- guardian_of_azeroth
            if A.GuardianofAzeroth:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth then
                return A.GuardianofAzeroth:Show(icon)
            end
            
            -- focused_azerite_beam,if=spell_targets.mind_sear>=2|raid_event.adds.in>60
            if A.FocusedAzeriteBeam:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and (MultiUnits:GetByRangeInCombat(40, 5, 10) >= 2 or IncomingAddsIn > 60) then
                return A.FocusedAzeriteBeam:Show(icon)
            end
            
            -- purifying_blast,if=spell_targets.mind_sear>=2|raid_event.adds.in>60
            if A.PurifyingBlast:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and (MultiUnits:GetByRangeInCombat(40, 5, 10) >= 2 or IncomingAddsIn > 60) then
                return A.PurifyingBlast:Show(icon)
            end
            
            -- concentrated_flame,line_cd=6,if=time<=10|full_recharge_time<gcd|target.time_to_die<5
            if A.ConcentratedFlame:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and (Unit("player"):CombatTime() <= 10 or A.ConcentratedFlame:GetSpellChargesFullRechargeTime() < GetGCD() or Unit(unit):TimeToDie() < 5) then
                return A.ConcentratedFlame:Show(icon)
            end
            
            -- ripple_in_space
            if A.RippleInSpace:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth then
                return A.RippleInSpace:Show(icon)
            end
            
            -- reaping_flames
            if A.ReapingFlames:IsReady(unit) then
                return A.ReapingFlames:Show(icon)
            end
            
            -- worldvein_resonance
            if A.WorldveinResonance:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth then
                return A.WorldveinResonance:Show(icon)
            end
            
            -- the_unbound_force
            if A.TheUnboundForce:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth then
                return A.TheUnboundForce:Show(icon)
            end
            
        end
        
        --Main
        local function Main(unit)
        
            -- void_eruption,if=variable.pi_or_vf_sync_condition&insanity>=40
            if A.VoidEruption:IsReady(unit) and (VarPiOrVfSyncCondition and Player:Insanity() >= 40) then
                return A.VoidEruption:Show(icon)
            end
            
            -- shadow_word_pain,if=buff.fae_guardians.up&!debuff.wrathful_faerie.up
            if A.ShadowWordPain:IsReady(unit) and (Unit("player"):HasBuffs(A.FaeGuardiansBuff.ID, true) and not Unit(unit):HasDeBuffs(A.WrathfulFaerieDebuff.ID, true)) then
                return A.ShadowWordPain:Show(icon)
            end
            
            -- call_action_list,name=cds
            if Cds(unit) then
                return true
            end
            
            -- mind_sear,target_if=talent.searing_nightmare.enabled&spell_targets.mind_sear>(variable.mind_sear_cutoff+1)&!dot.shadow_word_pain.ticking&!cooldown.mindbender.up
            if A.MindSear:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.MindSear, 40, "min", EvaluateCycleMindSear96) then
                    return A.MindSear:Show(icon) 
                end
            end
            -- damnation,target_if=!variable.all_dots_up
            if A.Damnation:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.Damnation, 40, "min", EvaluateCycleDamnation111) then
                    return A.Damnation:Show(icon) 
                end
            end
            -- void_bolt,if=insanity<=85&((talent.hungering_void.enabled&spell_targets.mind_sear<5)|spell_targets.mind_sear=1)
            if A.VoidBolt:IsReady(unit) and (Player:Insanity() <= 85 and ((A.HungeringVoid:IsSpellLearned() and MultiUnits:GetByRangeInCombat(40, 5, 10) < 5) or MultiUnits:GetByRangeInCombat(40, 5, 10) == 1)) then
                return A.VoidBolt:Show(icon)
            end
            
            -- devouring_plague,target_if=(refreshable|insanity>75)&!variable.pi_or_vf_sync_condition&(!talent.searing_nightmare.enabled|(talent.searing_nightmare.enabled&!variable.searing_nightmare_cutoff))
            if A.DevouringPlague:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.DevouringPlague, 40, "min", EvaluateCycleDevouringPlague124) then
                    return A.DevouringPlague:Show(icon) 
                end
            end
            -- void_bolt,if=spell_targets.mind_sear<(4+conduit.dissonant_echoes.enabled)&insanity<=85
            if A.VoidBolt:IsReady(unit) and (MultiUnits:GetByRangeInCombat(40, 5, 10) < (4 + conduit.dissonant_echoes.enabled) and Player:Insanity() <= 85) then
                return A.VoidBolt:Show(icon)
            end
            
            -- shadow_word_death,target_if=(target.health.pct<20&spell_targets.mind_sear<4)|(pet.fiend.active&runeforge.shadowflame_prism.equipped)
            if A.ShadowWordDeath:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.ShadowWordDeath, 40, "min", EvaluateCycleShadowWordDeath145) then
                    return A.ShadowWordDeath:Show(icon) 
                end
            end
            -- surrender_to_madness,target_if=target.time_to_die<25&buff.voidform.down
            if A.SurrenderToMadness:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.SurrenderToMadness, 40, "min", EvaluateCycleSurrenderToMadness152) then
                    return A.SurrenderToMadness:Show(icon) 
                end
            end
            -- mindbender,if=dot.vampiric_touch.ticking&((talent.searing_nightmare.enabled&spell_targets.mind_sear>(variable.mind_sear_cutoff+1))|dot.shadow_word_pain.ticking)
            if A.Mindbender:IsReady(unit) and (Unit(unit):HasDeBuffs(A.VampiricTouchDebuff.ID, true) and ((A.SearingNightmare:IsSpellLearned() and MultiUnits:GetByRangeInCombat(40, 5, 10) > (VarMindSearCutoff + 1)) or Unit(unit):HasDeBuffs(A.ShadowWordPainDebuff.ID, true))) then
                return A.Mindbender:Show(icon)
            end
            
            -- void_torrent,target_if=variable.dots_up&target.time_to_die>4&buff.voidform.down&spell_targets.mind_sear<(5+(6*talent.twist_of_fate.enabled))
            if A.VoidTorrent:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.VoidTorrent, 40, "min", EvaluateCycleVoidTorrent171) then
                    return A.VoidTorrent:Show(icon) 
                end
            end
            -- shadow_word_death,if=runeforge.painbreaker_psalm.equipped&variable.dots_up&target.time_to_pct_20>(cooldown.shadow_word_death.duration+gcd)
            if A.ShadowWordDeath:IsReady(unit) and (runeforge.painbreaker_psalm.equipped and VarDotsUp and target.time_to_pct_20 > (A.ShadowWordDeath:BaseDuration() + GetGCD())) then
                return A.ShadowWordDeath:Show(icon)
            end
            
            -- shadow_crash,if=spell_targets.shadow_crash=1&(cooldown.shadow_crash.charges=3|debuff.shadow_crash_debuff.up|action.shadow_crash.in_flight|target.time_to_die<cooldown.shadow_crash.full_recharge_time)&raid_event.adds.in>30
            if A.ShadowCrash:IsReady(unit) and (MultiUnits:GetByRangeInCombat(40, 5, 10) == 1 and (A.ShadowCrash:GetSpellCharges() == 3 or Unit(unit):HasDeBuffs(A.ShadowCrashDebuff.ID, true) or A.ShadowCrash:IsSpellInFlight() or Unit(unit):TimeToDie() < A.ShadowCrash:FullRechargeTimeP()) and IncomingAddsIn > 30) then
                return A.ShadowCrash:Show(icon)
            end
            
            -- shadow_crash,if=raid_event.adds.in>30&spell_targets.shadow_crash>1
            if A.ShadowCrash:IsReady(unit) and (IncomingAddsIn > 30 and MultiUnits:GetByRangeInCombat(40, 5, 10) > 1) then
                return A.ShadowCrash:Show(icon)
            end
            
            -- mind_sear,target_if=spell_targets.mind_sear>variable.mind_sear_cutoff&buff.dark_thoughts.up,chain=1,interrupt_immediate=1,interrupt_if=ticks>=2
            if A.MindSear:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.MindSear, 40, "min", EvaluateCycleMindSear204) then
                    return A.MindSear:Show(icon) 
                end
            end
            -- mind_flay,if=buff.dark_thoughts.up&variable.dots_up,chain=1,interrupt_immediate=1,interrupt_if=ticks>=2&cooldown.void_bolt.up
            if A.MindFlay:IsReady(unit) and (Unit("player"):HasBuffs(A.DarkThoughtsBuff.ID, true) and VarDotsUp) then
                return A.MindFlay:Show(icon)
            end
            
            -- mind_blast,if=variable.dots_up&raid_event.movement.in>cast_time+0.5&spell_targets.mind_sear<4
            if A.MindBlast:IsReady(unit) and (VarDotsUp and IncomingAddsIn > A.MindBlast:GetSpellCastTime() + 0.5 and MultiUnits:GetByRangeInCombat(40, 5, 10) < 4) then
                return A.MindBlast:Show(icon)
            end
            
            -- vampiric_touch,target_if=refreshable&target.time_to_die>6|(talent.misery.enabled&dot.shadow_word_pain.refreshable)|buff.unfurling_darkness.up
            if A.VampiricTouch:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.VampiricTouch, 40, "min", EvaluateCycleVampiricTouch229) then
                    return A.VampiricTouch:Show(icon) 
                end
            end
            -- shadow_word_pain,if=refreshable&target.time_to_die>4&!talent.misery.enabled&talent.psychic_link.enabled&spell_targets.mind_sear>2
            if A.ShadowWordPain:IsReady(unit) and (Unit(unit):HasDeBuffsRefreshable(A.ShadowWordPainDebuff.ID, true) and Unit(unit):TimeToDie() > 4 and not A.Misery:IsSpellLearned() and A.PsychicLink:IsSpellLearned() and MultiUnits:GetByRangeInCombat(40, 5, 10) > 2) then
                return A.ShadowWordPain:Show(icon)
            end
            
            -- shadow_word_pain,target_if=refreshable&target.time_to_die>4&!talent.misery.enabled&!(talent.searing_nightmare.enabled&spell_targets.mind_sear>(variable.mind_sear_cutoff+1))&(!talent.psychic_link.enabled|(talent.psychic_link.enabled&spell_targets.mind_sear<=2))
            if A.ShadowWordPain:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.ShadowWordPain, 40, "min", EvaluateCycleShadowWordPain260) then
                    return A.ShadowWordPain:Show(icon) 
                end
            end
            -- mind_sear,target_if=spell_targets.mind_sear>variable.mind_sear_cutoff,chain=1,interrupt_immediate=1,interrupt_if=ticks>=2
            if A.MindSear:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.MindSear, 40, "min", EvaluateCycleMindSear283) then
                    return A.MindSear:Show(icon) 
                end
            end
            -- mind_flay,chain=1,interrupt_immediate=1,interrupt_if=ticks>=2&cooldown.void_bolt.up
            if A.MindFlay:IsReady(unit) then
                return A.MindFlay:Show(icon)
            end
            
            -- shadow_word_death
            if A.ShadowWordDeath:IsReady(unit) then
                return A.ShadowWordDeath:Show(icon)
            end
            
            -- shadow_word_pain
            if A.ShadowWordPain:IsReady(unit) then
                return A.ShadowWordPain:Show(icon)
            end
            
        end
        
        
        -- call precombat
        if Precombat(unit) and not inCombat and Unit(unit):IsExists() and unit ~= "mouseover" then 
            return true
        end

        -- In Combat
        if inCombat and Unit(unit):IsExists() then

                    -- potion,if=buff.bloodlust.react|target.time_to_die<=80|target.health.pct<35
            if A.PotionofSpectralIntellect:IsReady(unit) and Potion and (Unit("player"):HasHeroism() or Unit(unit):TimeToDie() <= 80 or Unit(unit):HealthPercent() < 35) then
                return A.PotionofSpectralIntellect:Show(icon)
            end
            
            -- variable,name=dots_up,op=set,value=dot.shadow_word_pain.ticking&dot.vampiric_touch.ticking
            VarDotsUp = num(Unit(unit):HasDeBuffs(A.ShadowWordPainDebuff.ID, true) and Unit(unit):HasDeBuffs(A.VampiricTouchDebuff.ID, true))
            
            -- variable,name=all_dots_up,op=set,value=dot.shadow_word_pain.ticking&dot.vampiric_touch.ticking&dot.devouring_plague.ticking
            VarAllDotsUp = num(Unit(unit):HasDeBuffs(A.ShadowWordPainDebuff.ID, true) and Unit(unit):HasDeBuffs(A.VampiricTouchDebuff.ID, true) and Unit(unit):HasDeBuffs(A.DevouringPlagueDebuff.ID, true))
            
            -- variable,name=searing_nightmare_cutoff,op=set,value=spell_targets.mind_sear>3
            VarSearingNightmareCutoff = num(MultiUnits:GetByRangeInCombat(40, 5, 10) > 3)
            
            -- variable,name=pi_or_vf_sync_condition,op=set,value=(priest.self_power_infusion|runeforge.twins_of_the_sun_priestess.equipped)&level>=58&cooldown.power_infusion.up|(level<58|!priest.self_power_infusion&!runeforge.twins_of_the_sun_priestess.equipped)&cooldown.void_eruption.up
            VarPiOrVfSyncCondition = num((priest.self_power_infusion or runeforge.twins_of_the_sun_priestess.equipped) and Unit("player"):level >= 58 and A.PowerInfusion:GetCooldown() == 0 or (Unit("player"):level < 58 or not priest.self_power_infusion and not runeforge.twins_of_the_sun_priestess.equipped) and A.VoidEruption:GetCooldown() == 0)
            
            -- call_action_list,name=cwc
            if Cwc(unit) then
                return true
            end
            
            -- run_action_list,name=main
            return Main(unit);
            
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

