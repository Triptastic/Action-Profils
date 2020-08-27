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
    WhispersoftheDamned                    = Create({ Type = "Spell", ID = 275722 }),
    SearingDialogue                        = Create({ Type = "Spell", ID = 272788 }),
    DeathThroes                            = Create({ Type = "Spell", ID = 278659 }),
    ThoughtHarvester                       = Create({ Type = "Spell", ID = 288340 }),
    SpitefulApparitions                    = Create({ Type = "Spell", ID = 277682 }),
    ShadowformBuff                         = Create({ Type = "Spell", ID = 232698 }),
    Shadowform                             = Create({ Type = "Spell", ID = 232698 }),
    MindBlast                              = Create({ Type = "Spell", ID = 8092 }),
    VampiricTouchDebuff                    = Create({ Type = "Spell", ID = 34914 }),
    VampiricTouch                          = Create({ Type = "Spell", ID = 34914 }),
    VoidformBuff                           = Create({ Type = "Spell", ID = 194249 }),
    ChorusofInsanityBuff                   = Create({ Type = "Spell", ID = 278661 }),
    ReapingFlames                          = Create({ Type = "Spell", ID =  }),
    ChorusofInsanity                       = Create({ Type = "Spell", ID = 278661 }),
    VoidEruption                           = Create({ Type = "Spell", ID = 228260 }),
    DarkAscension                          = Create({ Type = "Spell", ID = 280711 }),
    MindSear                               = Create({ Type = "Spell", ID = 48045 }),
    HarvestedThoughtsBuff                  = Create({ Type = "Spell", ID = 288343 }),
    VoidBolt                               = Create({ Type = "Spell", ID = 205448 }),
    ShadowWordDeath                        = Create({ Type = "Spell", ID = 32379 }),
    SurrenderToMadness                     = Create({ Type = "Spell", ID = 193223 }),
    DarkVoid                               = Create({ Type = "Spell", ID = 263346 }),
    ShadowWordPainDebuff                   = Create({ Type = "Spell", ID = 589 }),
    Mindbender                             = Create({ Type = "Spell", ID = 200174 }),
    ShadowCrash                            = Create({ Type = "Spell", ID = 205385 }),
    ShadowWordPain                         = Create({ Type = "Spell", ID = 589 }),
    Misery                                 = Create({ Type = "Spell", ID = 238558 }),
    VoidTorrent                            = Create({ Type = "Spell", ID = 263165 }),
    MindFlay                               = Create({ Type = "Spell", ID = 15407 }),
    ShadowWordVoid                         = Create({ Type = "Spell", ID = 205351 })
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
local VarMindBlastTargets = 0;
local VarSwpTraitRanksCheck = 0;
local VarVtTraitRanksCheck = 0;
local VarVtMisTraitRanksCheck = 0;
local VarVtMisSdCheck = 0;
local VarDotsUp = 0;

A.Listener:Add("ROTATION_VARS", "PLAYER_REGEN_ENABLED", function()
  VarMindBlastTargets = 0
  VarSwpTraitRanksCheck = 0
  VarVtTraitRanksCheck = 0
  VarVtMisTraitRanksCheck = 0
  VarVtMisSdCheck = 0
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

local function EvaluateCycleShadowWordDeath133(unit)
    return Unit(unit):TimeToDie() < 3 or Unit("player"):HasBuffsDown(A.VoidformBuff.ID, true)
end

local function EvaluateCycleMindBlast152(unit)
    return MultiUnits:GetByRangeInCombat(40, 5, 10) < VarMindBlastTargets
end

local function EvaluateCycleShadowWordPain163(unit)
    return (Unit(unit):HasDeBuffsRefreshable(A.ShadowWordPainDebuff.ID, true) and Unit(unit):TimeToDie() > ((num(true) - 1.2 + 3.3 * MultiUnits:GetByRangeInCombat(40, 5, 10)) * VarSwpTraitRanksCheck * (1 - 0.012 * A.SearingDialogue:GetAzeriteRank() * MultiUnits:GetByRangeInCombat(40, 5, 10)))) and (not A.Misery:IsSpellLearned())
end

local function EvaluateCycleVampiricTouch182(unit)
    return (Unit(unit):HasDeBuffsRefreshable(A.VampiricTouchDebuff.ID, true)) and (Unit(unit):TimeToDie() > ((1 + 3.3 * MultiUnits:GetByRangeInCombat(40, 5, 10)) * VarVtTraitRanksCheck * (1 + 0.10 * A.SearingDialogue:GetAzeriteRank() * MultiUnits:GetByRangeInCombat(40, 5, 10))))
end

local function EvaluateCycleVampiricTouch199(unit)
    return (Unit(unit):HasDeBuffsRefreshable(A.ShadowWordPainDebuff.ID, true)) and ((A.Misery:IsSpellLearned() and Unit(unit):TimeToDie() > ((1.0 + 2.0 * MultiUnits:GetByRangeInCombat(40, 5, 10)) * VarVtMisTraitRanksCheck * (VarVtMisSdCheck * MultiUnits:GetByRangeInCombat(40, 5, 10)))))
end

local function EvaluateCycleMindSear218(unit)
    return MultiUnits:GetByRangeInCombat(40, 5, 10) > 1
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
            
            -- variable,name=mind_blast_targets,op=set,value=floor((4.5+azerite.whispers_of_the_damned.rank)%(1+0.27*azerite.searing_dialogue.rank))
            VarMindBlastTargets = math.floor ((4.5 + A.WhispersoftheDamned:GetAzeriteRank()) / (1 + 0.27 * A.SearingDialogue:GetAzeriteRank()))
            
            -- variable,name=swp_trait_ranks_check,op=set,value=(1-0.07*azerite.death_throes.rank+0.2*azerite.thought_harvester.rank)*(1-0.09*azerite.thought_harvester.rank*azerite.searing_dialogue.rank)
            VarSwpTraitRanksCheck = (1 - 0.07 * A.DeathThroes:GetAzeriteRank() + 0.2 * A.ThoughtHarvester:GetAzeriteRank()) * (1 - 0.09 * A.ThoughtHarvester:GetAzeriteRank() * A.SearingDialogue:GetAzeriteRank())
            
            -- variable,name=vt_trait_ranks_check,op=set,value=(1-0.04*azerite.thought_harvester.rank-0.05*azerite.spiteful_apparitions.rank)
            VarVtTraitRanksCheck = (1 - 0.04 * A.ThoughtHarvester:GetAzeriteRank() - 0.05 * A.SpitefulApparitions:GetAzeriteRank())
            
            -- variable,name=vt_mis_trait_ranks_check,op=set,value=(1-0.07*azerite.death_throes.rank-0.03*azerite.thought_harvester.rank-0.055*azerite.spiteful_apparitions.rank)*(1-0.027*azerite.thought_harvester.rank*azerite.searing_dialogue.rank)
            VarVtMisTraitRanksCheck = (1 - 0.07 * A.DeathThroes:GetAzeriteRank() - 0.03 * A.ThoughtHarvester:GetAzeriteRank() - 0.055 * A.SpitefulApparitions:GetAzeriteRank()) * (1 - 0.027 * A.ThoughtHarvester:GetAzeriteRank() * A.SearingDialogue:GetAzeriteRank())
            
            -- variable,name=vt_mis_sd_check,op=set,value=1-0.014*azerite.searing_dialogue.rank
            VarVtMisSdCheck = 1 - 0.014 * A.SearingDialogue:GetAzeriteRank()
            
            -- shadowform,if=!buff.shadowform.up
            if A.Shadowform:IsReady(unit) and Unit("player"):HasBuffsDown(A.ShadowformBuff.ID, true) and (not Unit("player"):HasBuffs(A.ShadowformBuff.ID, true)) then
                return A.Shadowform:Show(icon)
            end
            
            -- use_item,name=azsharas_font_of_power
            if A.AzsharasFontofPower:IsReady(unit) then
                return A.AzsharasFontofPower:Show(icon)
            end
            
            -- mind_blast,if=spell_targets.mind_sear<2|azerite.thought_harvester.rank=0
            if A.MindBlast:IsReady(unit) and inCombat and Unit(unit):IsExists() and unit ~= "mouseover" and (MultiUnits:GetByRangeInCombat(40, 5, 10) < 2 or A.ThoughtHarvester:GetAzeriteRank() == 0) then
                return A.MindBlast:Show(icon)
            end
            
            -- vampiric_touch
            if A.VampiricTouch:IsReady(unit) and Unit("player"):HasDebuffsDown(A.VampiricTouchDebuff.ID, true) and inCombat and Unit(unit):IsExists() and unit ~= "mouseover" then
                return A.VampiricTouch:Show(icon)
            end
            
        end
        
        --Cds
        local function Cds(unit)
        
            -- memory_of_lucid_dreams,if=(buff.voidform.stack>20&insanity<=50)|(current_insanity_drain*((gcd.max*2)+action.mind_blast.cast_time))>insanity
            if A.MemoryofLucidDreams:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and ((Unit("player"):HasBuffsStacks(A.VoidformBuff.ID, true) > 20 and Player:Insanity() <= 50) or (current_insanity_drain * ((GetGCD() * 2) + A.MindBlast:GetSpellCastTime())) > Player:Insanity()) then
                return A.MemoryofLucidDreams:Show(icon)
            end
            
            -- blood_of_the_enemy
            if A.BloodoftheEnemy:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth then
                return A.BloodoftheEnemy:Show(icon)
            end
            
            -- guardian_of_azeroth,if=buff.voidform.stack>15
            if A.GuardianofAzeroth:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and (Unit("player"):HasBuffsStacks(A.VoidformBuff.ID, true) > 15) then
                return A.GuardianofAzeroth:Show(icon)
            end
            
            -- use_item,name=manifesto_of_madness,if=spell_targets.mind_sear>=2|raid_event.adds.in>60
            if A.ManifestoofMadness:IsReady(unit) and (MultiUnits:GetByRangeInCombat(40, 5, 10) >= 2 or IncomingAddsIn > 60) then
                return A.ManifestoofMadness:Show(icon)
            end
            
            -- focused_azerite_beam,if=spell_targets.mind_sear>=2|raid_event.adds.in>60
            if A.FocusedAzeriteBeam:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and (MultiUnits:GetByRangeInCombat(40, 5, 10) >= 2 or IncomingAddsIn > 60) then
                return A.FocusedAzeriteBeam:Show(icon)
            end
            
            -- purifying_blast,if=spell_targets.mind_sear>=2|raid_event.adds.in>60
            if A.PurifyingBlast:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and (MultiUnits:GetByRangeInCombat(40, 5, 10) >= 2 or IncomingAddsIn > 60) then
                return A.PurifyingBlast:Show(icon)
            end
            
            -- concentrated_flame,line_cd=6,if=time<=10|(buff.chorus_of_insanity.stack>=15&buff.voidform.up)|full_recharge_time<gcd|target.time_to_die<5
            if A.ConcentratedFlame:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and (Unit("player"):CombatTime() <= 10 or (Unit("player"):HasBuffsStacks(A.ChorusofInsanityBuff.ID, true) >= 15 and Unit("player"):HasBuffs(A.VoidformBuff.ID, true)) or A.ConcentratedFlame:GetSpellChargesFullRechargeTime() < GetGCD() or Unit(unit):TimeToDie() < 5) then
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
            
            -- call_action_list,name=crit_cds,if=(buff.voidform.up&buff.chorus_of_insanity.stack>20)|azerite.chorus_of_insanity.rank=0
            if ((Unit("player"):HasBuffs(A.VoidformBuff.ID, true) and Unit("player"):HasBuffsStacks(A.ChorusofInsanityBuff.ID, true) > 20) or A.ChorusofInsanity:GetAzeriteRank() == 0) then
                if CritCds(unit) then
                    return true
                end
            end
            
            -- use_items
        end
        
        --Cleave
        local function Cleave(unit)
        
            -- void_eruption
            if A.VoidEruption:IsReady(unit) then
                return A.VoidEruption:Show(icon)
            end
            
            -- dark_ascension,if=buff.voidform.down
            if A.DarkAscension:IsReady(unit) and (Unit("player"):HasBuffsDown(A.VoidformBuff.ID, true)) then
                return A.DarkAscension:Show(icon)
            end
            
            -- vampiric_touch,if=!ticking&azerite.thought_harvester.rank>=1
            if A.VampiricTouch:IsReady(unit) and (not Unit(unit):HasDeBuffs(A.VampiricTouchDebuff.ID, true) and A.ThoughtHarvester:GetAzeriteRank() >= 1) then
                return A.VampiricTouch:Show(icon)
            end
            
            -- mind_sear,if=buff.harvested_thoughts.up
            if A.MindSear:IsReady(unit) and (Unit("player"):HasBuffs(A.HarvestedThoughtsBuff.ID, true)) then
                return A.MindSear:Show(icon)
            end
            
            -- void_bolt
            if A.VoidBolt:IsReady(unit) then
                return A.VoidBolt:Show(icon)
            end
            
            -- call_action_list,name=cds
            if Cds(unit) then
                return true
            end
            
            -- shadow_word_death,target_if=target.time_to_die<3|buff.voidform.down
            if A.ShadowWordDeath:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.ShadowWordDeath, 40, "min", EvaluateCycleShadowWordDeath133) then
                    return A.ShadowWordDeath:Show(icon) 
                end
            end
            -- surrender_to_madness,if=buff.voidform.stack>10+(10*buff.bloodlust.up)
            if A.SurrenderToMadness:IsReady(unit) and (Unit("player"):HasBuffsStacks(A.VoidformBuff.ID, true) > 10 + (10 * num(Unit("player"):HasHeroism))) then
                return A.SurrenderToMadness:Show(icon)
            end
            
            -- dark_void,if=raid_event.adds.in>10&(dot.shadow_word_pain.refreshable|target.time_to_die>30)
            if A.DarkVoid:IsReady(unit) and (IncomingAddsIn > 10 and (Unit(unit):HasDeBuffsRefreshable(A.ShadowWordPainDebuff.ID, true) or Unit(unit):TimeToDie() > 30)) then
                return A.DarkVoid:Show(icon)
            end
            
            -- mindbender
            if A.Mindbender:IsReady(unit) then
                return A.Mindbender:Show(icon)
            end
            
            -- mind_blast,target_if=spell_targets.mind_sear<variable.mind_blast_targets
            if A.MindBlast:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.MindBlast, 40, "min", EvaluateCycleMindBlast152) then
                    return A.MindBlast:Show(icon) 
                end
            end
            -- shadow_crash,if=(raid_event.adds.in>5&raid_event.adds.duration<2)|raid_event.adds.duration>2
            if A.ShadowCrash:IsReady(unit) and ((IncomingAddsIn > 5 and raid_event.adds.duration < 2) or raid_event.adds.duration > 2) then
                return A.ShadowCrash:Show(icon)
            end
            
            -- shadow_word_pain,target_if=refreshable&target.time_to_die>((-1.2+3.3*spell_targets.mind_sear)*variable.swp_trait_ranks_check*(1-0.012*azerite.searing_dialogue.rank*spell_targets.mind_sear)),if=!talent.misery.enabled
            if A.ShadowWordPain:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.ShadowWordPain, 40, "min", EvaluateCycleShadowWordPain163) then
                    return A.ShadowWordPain:Show(icon) 
                end
            end
            -- vampiric_touch,target_if=refreshable,if=target.time_to_die>((1+3.3*spell_targets.mind_sear)*variable.vt_trait_ranks_check*(1+0.10*azerite.searing_dialogue.rank*spell_targets.mind_sear))
            if A.VampiricTouch:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.VampiricTouch, 40, "min", EvaluateCycleVampiricTouch182) then
                    return A.VampiricTouch:Show(icon) 
                end
            end
            -- vampiric_touch,target_if=dot.shadow_word_pain.refreshable,if=(talent.misery.enabled&target.time_to_die>((1.0+2.0*spell_targets.mind_sear)*variable.vt_mis_trait_ranks_check*(variable.vt_mis_sd_check*spell_targets.mind_sear)))
            if A.VampiricTouch:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.VampiricTouch, 40, "min", EvaluateCycleVampiricTouch199) then
                    return A.VampiricTouch:Show(icon) 
                end
            end
            -- void_torrent,if=buff.voidform.up
            if A.VoidTorrent:IsReady(unit) and (Unit("player"):HasBuffs(A.VoidformBuff.ID, true)) then
                return A.VoidTorrent:Show(icon)
            end
            
            -- mind_sear,target_if=spell_targets.mind_sear>1,chain=1,interrupt_immediate=1,interrupt_if=ticks>=2
            if A.MindSear:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.MindSear, 40, "min", EvaluateCycleMindSear218) then
                    return A.MindSear:Show(icon) 
                end
            end
            -- mind_flay,chain=1,interrupt_immediate=1,interrupt_if=ticks>=2&(cooldown.void_bolt.up|cooldown.mind_blast.up)
            if A.MindFlay:IsReady(unit) then
                return A.MindFlay:Show(icon)
            end
            
            -- shadow_word_pain
            if A.ShadowWordPain:IsReady(unit) then
                return A.ShadowWordPain:Show(icon)
            end
            
        end
        
        --CritCds
        local function CritCds(unit)
        
            -- use_item,name=azsharas_font_of_power
            if A.AzsharasFontofPower:IsReady(unit) then
                return A.AzsharasFontofPower:Show(icon)
            end
            
            -- use_item,effect_name=cyclotronic_blast
            if A.CyclotronicBlast:IsReady(unit) then
                return A.CyclotronicBlast:Show(icon)
            end
            
            -- the_unbound_force
            if A.TheUnboundForce:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth then
                return A.TheUnboundForce:Show(icon)
            end
            
        end
        
        --Single
        local function Single(unit)
        
            -- void_eruption
            if A.VoidEruption:IsReady(unit) then
                return A.VoidEruption:Show(icon)
            end
            
            -- dark_ascension,if=buff.voidform.down
            if A.DarkAscension:IsReady(unit) and (Unit("player"):HasBuffsDown(A.VoidformBuff.ID, true)) then
                return A.DarkAscension:Show(icon)
            end
            
            -- void_bolt
            if A.VoidBolt:IsReady(unit) then
                return A.VoidBolt:Show(icon)
            end
            
            -- call_action_list,name=cds
            if Cds(unit) then
                return true
            end
            
            -- mind_sear,if=buff.harvested_thoughts.up&cooldown.void_bolt.remains>=1.5&azerite.searing_dialogue.rank>=1
            if A.MindSear:IsReady(unit) and (Unit("player"):HasBuffs(A.HarvestedThoughtsBuff.ID, true) and A.VoidBolt:GetCooldown() >= 1.5 and A.SearingDialogue:GetAzeriteRank() >= 1) then
                return A.MindSear:Show(icon)
            end
            
            -- shadow_word_death,if=target.time_to_die<3|cooldown.shadow_word_death.charges=2|(cooldown.shadow_word_death.charges=1&cooldown.shadow_word_death.remains<gcd.max)
            if A.ShadowWordDeath:IsReady(unit) and (Unit(unit):TimeToDie() < 3 or A.ShadowWordDeath:GetSpellCharges() == 2 or (A.ShadowWordDeath:GetSpellCharges() == 1 and A.ShadowWordDeath:GetCooldown() < GetGCD())) then
                return A.ShadowWordDeath:Show(icon)
            end
            
            -- surrender_to_madness,if=buff.voidform.stack>10+(10*buff.bloodlust.up)
            if A.SurrenderToMadness:IsReady(unit) and (Unit("player"):HasBuffsStacks(A.VoidformBuff.ID, true) > 10 + (10 * num(Unit("player"):HasHeroism))) then
                return A.SurrenderToMadness:Show(icon)
            end
            
            -- dark_void,if=raid_event.adds.in>10
            if A.DarkVoid:IsReady(unit) and (IncomingAddsIn > 10) then
                return A.DarkVoid:Show(icon)
            end
            
            -- mindbender,if=talent.mindbender.enabled|(buff.voidform.stack>18|target.time_to_die<15)
            if A.Mindbender:IsReady(unit) and (A.Mindbender:IsSpellLearned() or (Unit("player"):HasBuffsStacks(A.VoidformBuff.ID, true) > 18 or Unit(unit):TimeToDie() < 15)) then
                return A.Mindbender:Show(icon)
            end
            
            -- shadow_word_death,if=!buff.voidform.up|(cooldown.shadow_word_death.charges=2&buff.voidform.stack<15)
            if A.ShadowWordDeath:IsReady(unit) and (not Unit("player"):HasBuffs(A.VoidformBuff.ID, true) or (A.ShadowWordDeath:GetSpellCharges() == 2 and Unit("player"):HasBuffsStacks(A.VoidformBuff.ID, true) < 15)) then
                return A.ShadowWordDeath:Show(icon)
            end
            
            -- shadow_crash,if=raid_event.adds.in>5&raid_event.adds.duration<20
            if A.ShadowCrash:IsReady(unit) and (IncomingAddsIn > 5 and raid_event.adds.duration < 20) then
                return A.ShadowCrash:Show(icon)
            end
            
            -- mind_blast,if=variable.dots_up&((raid_event.movement.in>cast_time+0.5&raid_event.movement.in<4)|!talent.shadow_word_void.enabled|buff.voidform.down|buff.voidform.stack>14&(insanity<70|charges_fractional>1.33)|buff.voidform.stack<=14&(insanity<60|charges_fractional>1.33))
            if A.MindBlast:IsReady(unit) and (VarDotsUp and ((IncomingAddsIn > A.MindBlast:GetSpellCastTime() + 0.5 and IncomingAddsIn < 4) or not A.ShadowWordVoid:IsSpellLearned() or Unit("player"):HasBuffsDown(A.VoidformBuff.ID, true) or Unit("player"):HasBuffsStacks(A.VoidformBuff.ID, true) > 14 and (Player:Insanity() < 70 or A.MindBlast:GetSpellChargesFrac() > 1.33) or Unit("player"):HasBuffsStacks(A.VoidformBuff.ID, true) <= 14 and (Player:Insanity() < 60 or A.MindBlast:GetSpellChargesFrac() > 1.33))) then
                return A.MindBlast:Show(icon)
            end
            
            -- void_torrent,if=dot.shadow_word_pain.remains>4&dot.vampiric_touch.remains>4&buff.voidform.up
            if A.VoidTorrent:IsReady(unit) and (Unit(unit):HasDeBuffs(A.ShadowWordPainDebuff.ID, true) > 4 and Unit(unit):HasDeBuffs(A.VampiricTouchDebuff.ID, true) > 4 and Unit("player"):HasBuffs(A.VoidformBuff.ID, true)) then
                return A.VoidTorrent:Show(icon)
            end
            
            -- shadow_word_pain,if=refreshable&target.time_to_die>4&!talent.misery.enabled&!talent.dark_void.enabled
            if A.ShadowWordPain:IsReady(unit) and (Unit(unit):HasDeBuffsRefreshable(A.ShadowWordPainDebuff.ID, true) and Unit(unit):TimeToDie() > 4 and not A.Misery:IsSpellLearned() and not A.DarkVoid:IsSpellLearned()) then
                return A.ShadowWordPain:Show(icon)
            end
            
            -- vampiric_touch,if=refreshable&target.time_to_die>6|(talent.misery.enabled&dot.shadow_word_pain.refreshable)
            if A.VampiricTouch:IsReady(unit) and (Unit(unit):HasDeBuffsRefreshable(A.VampiricTouchDebuff.ID, true) and Unit(unit):TimeToDie() > 6 or (A.Misery:IsSpellLearned() and Unit(unit):HasDeBuffsRefreshable(A.ShadowWordPainDebuff.ID, true))) then
                return A.VampiricTouch:Show(icon)
            end
            
            -- mind_flay,chain=1,interrupt_immediate=1,interrupt_if=ticks>=2&(cooldown.void_bolt.up|cooldown.mind_blast.up)
            if A.MindFlay:IsReady(unit) then
                return A.MindFlay:Show(icon)
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
            
            -- run_action_list,name=cleave,if=active_enemies>1
            if (MultiUnits:GetByRangeInCombat(40, 5, 10) > 1) then
                return Cleave(unit);
            end
            
            -- run_action_list,name=single,if=active_enemies=1
            if (MultiUnits:GetByRangeInCombat(40, 5, 10) == 1) then
                return Single(unit);
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

