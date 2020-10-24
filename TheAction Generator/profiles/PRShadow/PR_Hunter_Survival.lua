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

Action[ACTION_CONST_HUNTER_SURVIVAL] = {
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
    SummonPet                              = Create({ Type = "Spell", ID = 883 }),
    CoordinatedAssaultBuff                 = Create({ Type = "Spell", ID = 266779 }),
    CoordinatedAssault                     = Create({ Type = "Spell", ID = 266779 }),
    SteelTrapDebuff                        = Create({ Type = "Spell", ID = 162487 }),
    SteelTrap                              = Create({ Type = "Spell", ID = 162488 }),
    Harpoon                                = Create({ Type = "Spell", ID = 190925 }),
    KillShot                               = Create({ Type = "Spell", ID =  }),
    MongooseBite                           = Create({ Type = "Spell", ID = 259387 }),
    BlurofTalonsBuff                       = Create({ Type = "Spell", ID = 277969 }),
    RaptorStrike                           = Create({ Type = "Spell", ID = 186270 }),
    FlankingStrike                         = Create({ Type = "Spell", ID = 269751 }),
    KillCommand                            = Create({ Type = "Spell", ID = 259489 }),
    BloodseekerDebuff                      = Create({ Type = "Spell", ID = 259277 }),
    WildfireBomb                           = Create({ Type = "Spell", ID = 259495 }),
    WildfireBombDebuff                     = Create({ Type = "Spell", ID = 269747 }),
    MongooseFuryBuff                       = Create({ Type = "Spell", ID = 259388 }),
    SerpentSting                           = Create({ Type = "Spell", ID = 259491 }),
    SerpentStingDebuff                     = Create({ Type = "Spell", ID = 259491 }),
    AMurderofCrows                         = Create({ Type = "Spell", ID = 131894 }),
    TipoftheSpearBuff                      = Create({ Type = "Spell", ID = 260286 }),
    ShrapnelBombDebuff                     = Create({ Type = "Spell", ID = 270339 }),
    Chakrams                               = Create({ Type = "Spell", ID = 259391 }),
    BloodFury                              = Create({ Type = "Spell", ID = 20572 }),
    AncestralCall                          = Create({ Type = "Spell", ID = 274738 }),
    Fireblood                              = Create({ Type = "Spell", ID = 265221 }),
    LightsJudgment                         = Create({ Type = "Spell", ID = 255647 }),
    Berserking                             = Create({ Type = "Spell", ID = 26297 }),
    BerserkingBuff                         = Create({ Type = "Spell", ID = 26297 }),
    GuardianofAzerothBuff                  = Create({ Type = "Spell", ID =  }),
    BloodFuryBuff                          = Create({ Type = "Spell", ID = 20572 }),
    PotionofUnbridledFuryBuff              = Create({ Type = "Spell", ID =  }),
    AspectoftheEagle                       = Create({ Type = "Spell", ID = 186289 }),
    WorldveinResonanceBuff                 = Create({ Type = "Spell", ID =  }),
    BirdsofPrey                            = Create({ Type = "Spell", ID = 260331 }),
    WildfireInfusion                       = Create({ Type = "Spell", ID = 271014 }),
    BloodoftheEnemyBuff                    = Create({ Type = "Spell", ID = 297108 }),
    ReapingFlames                          = Create({ Type = "Spell", ID =  }),
    VipersVenomBuff                        = Create({ Type = "Spell", ID = 268552 }),
    BlurofTalons                           = Create({ Type = "Spell", ID = 277653 }),
    LatentPoisonDebuff                     = Create({ Type = "Spell", ID = 273286 }),
    Carve                                  = Create({ Type = "Spell", ID = 187708 }),
    HydrasBite                             = Create({ Type = "Spell", ID =  }),
    GuerrillaTactics                       = Create({ Type = "Spell", ID = 264332 }),
    Butchery                               = Create({ Type = "Spell", ID = 212436 }),
    TermsofEngagement                      = Create({ Type = "Spell", ID = 265895 }),
    LatentPoison                           = Create({ Type = "Spell", ID = 273283 }),
    WildernessSurvival                     = Create({ Type = "Spell", ID = 278532 }),
    VipersVenom                            = Create({ Type = "Spell", ID = 268501 }),
    AlphaPredator                          = Create({ Type = "Spell", ID = 269737 }),
    ArcaneTorrent                          = Create({ Type = "Spell", ID = 50613 }),
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
A:CreateCovenantsFor(ACTION_CONST_HUNTER_SURVIVAL)  -- where PLAYERSPEC is Constance (example: ACTION_CONST_MONK_BM)
local A = setmetatable(Action[ACTION_CONST_HUNTER_SURVIVAL], { __index = Action })


------------------------------------------
---------------- VARIABLES ---------------
------------------------------------------
local VarCarveCdr = 0;

A.Listener:Add("ROTATION_VARS", "PLAYER_REGEN_ENABLED", function()
  VarCarveCdr = 0
end)



local function num(val)
    if val then return 1 else return 0 end
end

local function bool(val)
    return val ~= 0
end

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

local IsIndoors, UnitIsUnit = IsIndoors, UnitIsUnit

local function IsSchoolFree()
	return LoC:IsMissed("SILENCE") and LoC:Get("SCHOOL_INTERRUPT", "SHADOW") == 0
end 

------------------------------------------
--------- SURVIVAL PRE APL SETUP ---------
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
	return LoC:IsMissed("SILENCE") and LoC:Get("SCHOOL_INTERRUPT", "NATURE") == 0
end 

local WildfireInfusions = {
  A.ShrapnelBomb,
  A.PheromoneBomb,
  A.VolatileBomb,
}

local function CurrentWildfireInfusion()
    if A.WildfireInfusion:IsSpellLearned() then
        for _, infusion in pairs(WildfireInfusions) do
            if infusion:IsSpellLearned() then 
			    return infusion 
			end
        end
    end
    return A.WildfireBomb
end

local function CurrentRaptorStrike()
     return A.RaptorStrikeEagle:IsSpellLearned() and A.RaptorStrikeEagle or A.RaptorStrike
end

local function CurrentMongooseBite()
    return A.MongooseBiteEagle:IsSpellLearned() and A.MongooseBiteEagle or A.MongooseBite
end

local function InRange(unit)
	-- @return boolean 
	return A.SerpentSting:IsInRange(unit)
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

-- TO USE AFTER NEXT ACTION UPDATE
local function InterruptsNEW(unit)
    local useKick, useCC, useRacial, notInterruptable, castRemainsTime, castDoneTime = Action.InterruptIsValid(unit, nil, nil, not A.CounterShot:IsReady(unit)) -- A.Kick non GCD spell
    
	if castDoneTime > 0 then
        -- CounterShot
        if useKick and not notInterruptable and A.CounterShot:IsReady(unit) then 
            return A.CounterShot:Show(icon)
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

local function EvaluateTargetIfFilterKillCommand57(unit)
  return Unit(unit):DebuffRemainsP(A.BloodseekerDebuff.ID, true)
end

local function EvaluateTargetIfKillCommand74(unit)
  return A.KillCommand:GetSpellChargesFullRechargeTime() < 1.5 * GetGCD() and Player:Focus() + Unit("player"):FocusCastRegen(A.KillCommand:GetSpellCastTime) < Player:FocusMax()
end


local function EvaluateTargetIfFilterKillCommand136(unit)
  return Unit(unit):DebuffRemainsP(A.BloodseekerDebuff.ID, true)
end

local function EvaluateTargetIfKillCommand155(unit)
  return Player:Focus() + Unit("player"):FocusCastRegen(A.KillCommand:GetSpellCastTime) < Player:FocusMax() and (Unit("player"):HasBuffsStacks(A.MongooseFuryBuff.ID, true) < 5 or Player:Focus() < A.MongooseBite:GetSpellPowerCostCache())
end


local function EvaluateTargetIfFilterKillCommand265(unit)
  return Unit(unit):DebuffRemainsP(A.BloodseekerDebuff.ID, true)
end

local function EvaluateTargetIfKillCommand282(unit)
  return A.KillCommand:GetSpellChargesFullRechargeTime() < 1.5 * GetGCD() and Player:Focus() + Unit("player"):FocusCastRegen(A.KillCommand:GetSpellCastTime) < Player:FocusMax() - 20
end


local function EvaluateTargetIfFilterKillCommand324(unit)
  return Unit(unit):DebuffRemainsP(A.BloodseekerDebuff.ID, true)
end

local function EvaluateTargetIfKillCommand343(unit)
  return Player:Focus() + Unit("player"):FocusCastRegen(A.KillCommand:GetSpellCastTime) < Player:FocusMax() and (Unit("player"):HasBuffsStacks(A.MongooseFuryBuff.ID, true) < 5 or Player:Focus() < A.MongooseBite:GetSpellPowerCostCache())
end


local function EvaluateCycleCarveCdr568(unit)
    return (MultiUnits:GetByRangeInCombat(8, 5, 10) < 5) and (MultiUnits:GetByRangeInCombat(8, 5, 10) < 5)
end

local function EvaluateTargetIfFilterMongooseBite602(unit)
  return Unit(unit):TimeToDie()
end

local function EvaluateTargetIfMongooseBite627(unit)
  return Unit(unit):HasDeBuffsStacks(A.LatentPoisonDebuff.ID, true) > num((MultiUnits:GetByRangeInCombat(8, 5, 10) or 9)) and Unit(unit):TimeToDie() < MultiUnits:GetByRangeInCombat(8, 5, 10) * GetGCD()
end


local function EvaluateTargetIfFilterMongooseBite683(unit)
  return Unit(unit):HasDeBuffsStacks(A.LatentPoisonDebuff.ID, true)
end

local function EvaluateTargetIfMongooseBite692(unit)
  return Unit(unit):HasDeBuffsStacks(A.LatentPoisonDebuff.ID, true) > 8
end


local function EvaluateTargetIfFilterKillCommand700(unit)
  return Unit(unit):DebuffRemainsP(A.BloodseekerDebuff.ID, true)
end

local function EvaluateTargetIfKillCommand713(unit)
  return Player:Focus() + Unit("player"):FocusCastRegen(A.KillCommand:GetSpellCastTime) < Player:FocusMax()
end


local function EvaluateTargetIfFilterSerpentSting751(unit)
  return Unit(unit):HasDeBuffs(A.SerpentStingDebuff.ID, true)
end

local function EvaluateTargetIfSerpentSting768(unit)
  return Unit("player"):HasBuffsStacks(A.VipersVenomBuff.ID, true)
end


local function EvaluateTargetIfFilterSerpentSting782(unit)
  return Unit(unit):HasDeBuffs(A.SerpentStingDebuff.ID, true)
end

local function EvaluateTargetIfSerpentSting813(unit)
  return Unit(unit):HasDeBuffsRefreshable(A.SerpentStingDebuff.ID, true) and Unit("player"):HasBuffsStacks(A.TipoftheSpearBuff.ID, true) < 3 and S.VolatileBomb:IsLearned() or Unit(unit):HasDeBuffsRefreshable(A.SerpentStingDebuff.ID, true) and A.LatentPoison:GetAzeriteRank() > 0
end


local function EvaluateTargetIfFilterMongooseBite819(unit)
  return Unit(unit):HasDeBuffsStacks(A.LatentPoisonDebuff.ID, true)
end

local function EvaluateTargetIfFilterRaptorStrike830(unit)
  return Unit(unit):HasDeBuffsStacks(A.LatentPoisonDebuff.ID, true)
end

local function EvaluateTargetIfFilterKillCommand875(unit)
  return Unit(unit):DebuffRemainsP(A.BloodseekerDebuff.ID, true)
end

local function EvaluateTargetIfKillCommand888(unit)
  return Player:Focus() + Unit("player"):FocusCastRegen(A.KillCommand:GetSpellCastTime) < Player:FocusMax()
end


local function EvaluateTargetIfFilterKillCommand1078(unit)
  return Unit(unit):DebuffRemainsP(A.BloodseekerDebuff.ID, true)
end

local function EvaluateTargetIfKillCommand1091(unit)
  return Player:Focus() + Unit("player"):FocusCastRegen(A.KillCommand:GetSpellCastTime) < Player:FocusMax() - Player:FocusRegen()
end

--- ======= ACTION LISTS =======
local function APL()
        local Precombat, Apst, Apwfi, Cds, Cleave, St, Wfi
  UpdateRanges()
  Everyone.AoEToggleEnemiesUpdate()
  S.WildfireBomb = CurrentWildfireInfusion()
  S.RaptorStrike = CurrentRaptorStrike()
  S.MongooseBite = CurrentMongooseBite()
        --Precombat
        local function Precombat(unit)
        
            -- flask
            -- augmentation
            -- food
            -- summon_pet
            if A.SummonPet:IsReady(unit) then
                return A.SummonPet:Show(icon)
            end
            
            -- snapshot_stats
            -- use_item,name=azsharas_font_of_power
            if A.AzsharasFontofPower:IsReady(unit) then
                return A.AzsharasFontofPower:Show(icon)
            end
            
            -- guardian_of_azeroth
            if A.GuardianofAzeroth:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth then
                return A.GuardianofAzeroth:Show(icon)
            end
            
            -- coordinated_assault
            if A.CoordinatedAssault:IsReady(unit) and Unit("player"):HasBuffsDown(A.CoordinatedAssaultBuff.ID, true) and A.BurstIsON(unit) then
                return A.CoordinatedAssault:Show(icon)
            end
            
            -- worldvein_resonance
            if A.WorldveinResonance:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth then
                return A.WorldveinResonance:Show(icon)
            end
            
            -- potion,dynamic_prepot=1
            if A.PotionofSpectralAgility:IsReady(unit) and Potion then
                return A.PotionofSpectralAgility:Show(icon)
            end
            
            -- steel_trap
            if A.SteelTrap:IsReady(unit) and Unit("player"):HasDebuffsDown(A.SteelTrapDebuff.ID, true) and inCombat and Unit(unit):IsExists() and unit ~= "mouseover" then
                return A.SteelTrap:Show(icon)
            end
            
            -- harpoon
            if A.Harpoon:IsReady(unit) and inCombat and Unit(unit):IsExists() and unit ~= "mouseover" then
                return A.Harpoon:Show(icon)
            end
            
        end
        
        --Apst
        local function Apst(unit)
        
            -- kill_shot
            if A.KillShot:IsReady(unit) then
                return A.KillShot:Show(icon)
            end
            
            -- mongoose_bite,if=buff.coordinated_assault.up&(buff.coordinated_assault.remains<1.5*gcd|buff.blur_of_talons.up&buff.blur_of_talons.remains<1.5*gcd)
            if A.MongooseBite:IsReady(unit) and (Unit("player"):HasBuffs(A.CoordinatedAssaultBuff.ID, true) and (Unit("player"):HasBuffs(A.CoordinatedAssaultBuff.ID, true) < 1.5 * GetGCD() or Unit("player"):HasBuffs(A.BlurofTalonsBuff.ID, true) and Unit("player"):HasBuffs(A.BlurofTalonsBuff.ID, true) < 1.5 * GetGCD())) then
                return A.MongooseBite:Show(icon)
            end
            
            -- raptor_strike,if=buff.coordinated_assault.up&(buff.coordinated_assault.remains<1.5*gcd|buff.blur_of_talons.up&buff.blur_of_talons.remains<1.5*gcd)
            if A.RaptorStrike:IsReady(unit) and (Unit("player"):HasBuffs(A.CoordinatedAssaultBuff.ID, true) and (Unit("player"):HasBuffs(A.CoordinatedAssaultBuff.ID, true) < 1.5 * GetGCD() or Unit("player"):HasBuffs(A.BlurofTalonsBuff.ID, true) and Unit("player"):HasBuffs(A.BlurofTalonsBuff.ID, true) < 1.5 * GetGCD())) then
                return A.RaptorStrike:Show(icon)
            end
            
            -- flanking_strike,if=focus+cast_regen<focus.max
            if A.FlankingStrike:IsReady(unit) and (Player:Focus() + Unit("player"):FocusCastRegen(A.FlankingStrike:GetSpellCastTime) < Player:FocusMax()) then
                return A.FlankingStrike:Show(icon)
            end
            
            -- kill_command,target_if=min:bloodseeker.remains,if=full_recharge_time<1.5*gcd&focus+cast_regen<focus.max
            if A.KillCommand:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.KillCommand, 8, "min", EvaluateTargetIfFilterKillCommand57, EvaluateTargetIfKillCommand74) then 
                    return A.KillCommand:Show(icon) 
                end
            end
            -- steel_trap,if=focus+cast_regen<focus.max
            if A.SteelTrap:IsReady(unit) and (Player:Focus() + Unit("player"):FocusCastRegen(A.SteelTrap:GetSpellCastTime) < Player:FocusMax()) then
                return A.SteelTrap:Show(icon)
            end
            
            -- wildfire_bomb,if=focus+cast_regen<focus.max&!ticking&!buff.memory_of_lucid_dreams.up&(full_recharge_time<1.5*gcd|!dot.wildfire_bomb.ticking&!buff.coordinated_assault.up|!dot.wildfire_bomb.ticking&buff.mongoose_fury.stack<1)|time_to_die<18&!dot.wildfire_bomb.ticking
            if A.WildfireBomb:IsReady(unit) and (Player:Focus() + Unit("player"):FocusCastRegen(A.WildfireBomb:GetSpellCastTime) < Player:FocusMax() and not Unit(unit):HasDeBuffs(A.WildfireBombDebuff.ID, true) and not Unit("player"):HasBuffs(A.MemoryofLucidDreamsBuff.ID, true) and (A.WildfireBomb:GetSpellChargesFullRechargeTime() < 1.5 * GetGCD() or not Unit(unit):HasDeBuffs(A.WildfireBombDebuff.ID, true) and not Unit("player"):HasBuffs(A.CoordinatedAssaultBuff.ID, true) or not Unit(unit):HasDeBuffs(A.WildfireBombDebuff.ID, true) and Unit("player"):HasBuffsStacks(A.MongooseFuryBuff.ID, true) < 1) or Unit(unit):TimeToDie() < 18 and not Unit(unit):HasDeBuffs(A.WildfireBombDebuff.ID, true)) then
                return A.WildfireBomb:Show(icon)
            end
            
            -- serpent_sting,if=!dot.serpent_sting.ticking&!buff.coordinated_assault.up
            if A.SerpentSting:IsReady(unit) and (not Unit(unit):HasDeBuffs(A.SerpentStingDebuff.ID, true) and not Unit("player"):HasBuffs(A.CoordinatedAssaultBuff.ID, true)) then
                return A.SerpentSting:Show(icon)
            end
            
            -- kill_command,target_if=min:bloodseeker.remains,if=focus+cast_regen<focus.max&(buff.mongoose_fury.stack<5|focus<action.mongoose_bite.cost)
            if A.KillCommand:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.KillCommand, 8, "min", EvaluateTargetIfFilterKillCommand136, EvaluateTargetIfKillCommand155) then 
                    return A.KillCommand:Show(icon) 
                end
            end
            -- serpent_sting,if=refreshable&!buff.coordinated_assault.up&buff.mongoose_fury.stack<5
            if A.SerpentSting:IsReady(unit) and (Unit(unit):HasDeBuffsRefreshable(A.SerpentStingDebuff.ID, true) and not Unit("player"):HasBuffs(A.CoordinatedAssaultBuff.ID, true) and Unit("player"):HasBuffsStacks(A.MongooseFuryBuff.ID, true) < 5) then
                return A.SerpentSting:Show(icon)
            end
            
            -- a_murder_of_crows,if=!buff.coordinated_assault.up
            if A.AMurderofCrows:IsReady(unit) and (not Unit("player"):HasBuffs(A.CoordinatedAssaultBuff.ID, true)) then
                return A.AMurderofCrows:Show(icon)
            end
            
            -- coordinated_assault,if=!buff.coordinated_assault.up
            if A.CoordinatedAssault:IsReady(unit) and A.BurstIsON(unit) and (not Unit("player"):HasBuffs(A.CoordinatedAssaultBuff.ID, true)) then
                return A.CoordinatedAssault:Show(icon)
            end
            
            -- mongoose_bite,if=buff.mongoose_fury.up|focus+cast_regen>focus.max-10|buff.coordinated_assault.up
            if A.MongooseBite:IsReady(unit) and (Unit("player"):HasBuffs(A.MongooseFuryBuff.ID, true) or Player:Focus() + Unit("player"):FocusCastRegen(A.MongooseBite:GetSpellCastTime) > Player:FocusMax() - 10 or Unit("player"):HasBuffs(A.CoordinatedAssaultBuff.ID, true)) then
                return A.MongooseBite:Show(icon)
            end
            
            -- raptor_strike
            if A.RaptorStrike:IsReady(unit) then
                return A.RaptorStrike:Show(icon)
            end
            
            -- wildfire_bomb,if=!ticking
            if A.WildfireBomb:IsReady(unit) and (not Unit(unit):HasDeBuffs(A.WildfireBombDebuff.ID, true)) then
                return A.WildfireBomb:Show(icon)
            end
            
        end
        
        --Apwfi
        local function Apwfi(unit)
        
            -- kill_shot
            if A.KillShot:IsReady(unit) then
                return A.KillShot:Show(icon)
            end
            
            -- mongoose_bite,if=buff.blur_of_talons.up&buff.blur_of_talons.remains<gcd
            if A.MongooseBite:IsReady(unit) and (Unit("player"):HasBuffs(A.BlurofTalonsBuff.ID, true) and Unit("player"):HasBuffs(A.BlurofTalonsBuff.ID, true) < GetGCD()) then
                return A.MongooseBite:Show(icon)
            end
            
            -- raptor_strike,if=buff.blur_of_talons.up&buff.blur_of_talons.remains<gcd
            if A.RaptorStrike:IsReady(unit) and (Unit("player"):HasBuffs(A.BlurofTalonsBuff.ID, true) and Unit("player"):HasBuffs(A.BlurofTalonsBuff.ID, true) < GetGCD()) then
                return A.RaptorStrike:Show(icon)
            end
            
            -- serpent_sting,if=!dot.serpent_sting.ticking
            if A.SerpentSting:IsReady(unit) and (not Unit(unit):HasDeBuffs(A.SerpentStingDebuff.ID, true)) then
                return A.SerpentSting:Show(icon)
            end
            
            -- a_murder_of_crows
            if A.AMurderofCrows:IsReady(unit) then
                return A.AMurderofCrows:Show(icon)
            end
            
            -- wildfire_bomb,if=full_recharge_time<1.5*gcd|focus+cast_regen<focus.max&(next_wi_bomb.volatile&dot.serpent_sting.ticking&dot.serpent_sting.refreshable|next_wi_bomb.pheromone&!buff.mongoose_fury.up&focus+cast_regen<focus.max-action.kill_command.cast_regen*3)
            if A.WildfireBomb:IsReady(unit) and (A.WildfireBomb:GetSpellChargesFullRechargeTime() < 1.5 * GetGCD() or Player:Focus() + Unit("player"):FocusCastRegen(A.WildfireBomb:GetSpellCastTime) < Player:FocusMax() and (S.VolatileBomb:IsLearned() and Unit(unit):HasDeBuffs(A.SerpentStingDebuff.ID, true) and Unit(unit):HasDeBuffsRefreshable(A.SerpentStingDebuff.ID, true) or S.PheromoneBomb:IsLearned() and not Unit("player"):HasBuffs(A.MongooseFuryBuff.ID, true) and Player:Focus() + Unit("player"):FocusCastRegen(A.WildfireBomb:GetSpellCastTime) < Player:FocusMax() - Unit("player"):FocusCastRegen(A.KillCommand:GetSpellCastTime) * 3)) then
                return A.WildfireBomb:Show(icon)
            end
            
            -- coordinated_assault
            if A.CoordinatedAssault:IsReady(unit) and A.BurstIsON(unit) then
                return A.CoordinatedAssault:Show(icon)
            end
            
            -- mongoose_bite,if=buff.mongoose_fury.remains&next_wi_bomb.pheromone
            if A.MongooseBite:IsReady(unit) and (Unit("player"):HasBuffs(A.MongooseFuryBuff.ID, true) and S.PheromoneBomb:IsLearned()) then
                return A.MongooseBite:Show(icon)
            end
            
            -- kill_command,target_if=min:bloodseeker.remains,if=full_recharge_time<1.5*gcd&focus+cast_regen<focus.max-20
            if A.KillCommand:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.KillCommand, 8, "min", EvaluateTargetIfFilterKillCommand265, EvaluateTargetIfKillCommand282) then 
                    return A.KillCommand:Show(icon) 
                end
            end
            -- steel_trap,if=focus+cast_regen<focus.max
            if A.SteelTrap:IsReady(unit) and (Player:Focus() + Unit("player"):FocusCastRegen(A.SteelTrap:GetSpellCastTime) < Player:FocusMax()) then
                return A.SteelTrap:Show(icon)
            end
            
            -- raptor_strike,if=buff.tip_of_the_spear.stack=3|dot.shrapnel_bomb.ticking
            if A.RaptorStrike:IsReady(unit) and (Unit("player"):HasBuffsStacks(A.TipoftheSpearBuff.ID, true) == 3 or Unit(unit):HasDeBuffs(A.ShrapnelBombDebuff.ID, true)) then
                return A.RaptorStrike:Show(icon)
            end
            
            -- mongoose_bite,if=dot.shrapnel_bomb.ticking
            if A.MongooseBite:IsReady(unit) and (Unit(unit):HasDeBuffs(A.ShrapnelBombDebuff.ID, true)) then
                return A.MongooseBite:Show(icon)
            end
            
            -- wildfire_bomb,if=next_wi_bomb.shrapnel&focus>30&dot.serpent_sting.remains>5*gcd
            if A.WildfireBomb:IsReady(unit) and (S.ShrapnelBomb:IsLearned() and Player:Focus() > 30 and Unit(unit):HasDeBuffs(A.SerpentStingDebuff.ID, true) > 5 * GetGCD()) then
                return A.WildfireBomb:Show(icon)
            end
            
            -- chakrams,if=!buff.mongoose_fury.remains
            if A.Chakrams:IsReady(unit) and (not Unit("player"):HasBuffs(A.MongooseFuryBuff.ID, true)) then
                return A.Chakrams:Show(icon)
            end
            
            -- serpent_sting,if=refreshable
            if A.SerpentSting:IsReady(unit) and (Unit(unit):HasDeBuffsRefreshable(A.SerpentStingDebuff.ID, true)) then
                return A.SerpentSting:Show(icon)
            end
            
            -- kill_command,target_if=min:bloodseeker.remains,if=focus+cast_regen<focus.max&(buff.mongoose_fury.stack<5|focus<action.mongoose_bite.cost)
            if A.KillCommand:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.KillCommand, 8, "min", EvaluateTargetIfFilterKillCommand324, EvaluateTargetIfKillCommand343) then 
                    return A.KillCommand:Show(icon) 
                end
            end
            -- raptor_strike
            if A.RaptorStrike:IsReady(unit) then
                return A.RaptorStrike:Show(icon)
            end
            
            -- mongoose_bite,if=buff.mongoose_fury.up|focus>40|dot.shrapnel_bomb.ticking
            if A.MongooseBite:IsReady(unit) and (Unit("player"):HasBuffs(A.MongooseFuryBuff.ID, true) or Player:Focus() > 40 or Unit(unit):HasDeBuffs(A.ShrapnelBombDebuff.ID, true)) then
                return A.MongooseBite:Show(icon)
            end
            
            -- wildfire_bomb,if=next_wi_bomb.volatile&dot.serpent_sting.ticking|next_wi_bomb.pheromone|next_wi_bomb.shrapnel&focus>50
            if A.WildfireBomb:IsReady(unit) and (S.VolatileBomb:IsLearned() and Unit(unit):HasDeBuffs(A.SerpentStingDebuff.ID, true) or S.PheromoneBomb:IsLearned() or S.ShrapnelBomb:IsLearned() and Player:Focus() > 50) then
                return A.WildfireBomb:Show(icon)
            end
            
        end
        
        --Cds
        local function Cds(unit)
        
            -- blood_fury,if=cooldown.coordinated_assault.remains>30
            if A.BloodFury:AutoRacial(unit) and Racial and A.BurstIsON(unit) and (A.CoordinatedAssault:GetCooldown() > 30) then
                return A.BloodFury:Show(icon)
            end
            
            -- ancestral_call,if=cooldown.coordinated_assault.remains>30
            if A.AncestralCall:AutoRacial(unit) and Racial and A.BurstIsON(unit) and (A.CoordinatedAssault:GetCooldown() > 30) then
                return A.AncestralCall:Show(icon)
            end
            
            -- fireblood,if=cooldown.coordinated_assault.remains>30
            if A.Fireblood:AutoRacial(unit) and Racial and A.BurstIsON(unit) and (A.CoordinatedAssault:GetCooldown() > 30) then
                return A.Fireblood:Show(icon)
            end
            
            -- lights_judgment
            if A.LightsJudgment:IsReady(unit) and A.BurstIsON(unit) then
                return A.LightsJudgment:Show(icon)
            end
            
            -- berserking,if=cooldown.coordinated_assault.remains>60|time_to_die<13
            if A.Berserking:AutoRacial(unit) and Racial and A.BurstIsON(unit) and (A.CoordinatedAssault:GetCooldown() > 60 or Unit(unit):TimeToDie() < 13) then
                return A.Berserking:Show(icon)
            end
            
            -- potion,if=buff.guardian_of_azeroth.up&(buff.berserking.up|buff.blood_fury.up|!race.troll)|(consumable.potion_of_unbridled_fury&target.time_to_die<61|target.time_to_die<26)|!essence.condensed_lifeforce.major&buff.coordinated_assault.up
            if A.PotionofSpectralAgility:IsReady(unit) and Potion and (Unit("player"):HasBuffs(A.GuardianofAzerothBuff.ID, true) and (Unit("player"):HasBuffs(A.BerserkingBuff.ID, true) or Unit("player"):HasBuffs(A.BloodFuryBuff.ID, true) or not Unit("player"):IsRace("Troll")) or (Unit(unit):HasBuffs(A.PotionofUnbridledFuryBuff.ID, true) and Unit(unit):TimeToDie() < 61 or Unit(unit):TimeToDie() < 26) or not Azerite:EssenceHasMajor(A.CondensedLifeforce.ID) and Unit("player"):HasBuffs(A.CoordinatedAssaultBuff.ID, true)) then
                return A.PotionofSpectralAgility:Show(icon)
            end
            
            -- aspect_of_the_eagle,if=target.distance>=6
            if A.AspectoftheEagle:IsReady(unit) and A.BurstIsON(unit) and (target.distance >= 6) then
                return A.AspectoftheEagle:Show(icon)
            end
            
            -- use_item,name=ashvanes_razor_coral,if=buff.memory_of_lucid_dreams.up&target.time_to_die<cooldown.memory_of_lucid_dreams.remains+15|buff.guardian_of_azeroth.stack=5&target.time_to_die<cooldown.guardian_of_azeroth.remains+20|debuff.razor_coral_debuff.down|target.time_to_die<21|buff.worldvein_resonance.remains&target.time_to_die<cooldown.worldvein_resonance.remains+18|!talent.birds_of_prey.enabled&target.time_to_die<cooldown.coordinated_assault.remains+20&buff.coordinated_assault.remains
            if A.AshvanesRazorCoral:IsReady(unit) and (Unit("player"):HasBuffs(A.MemoryofLucidDreamsBuff.ID, true) and Unit(unit):TimeToDie() < A.MemoryofLucidDreams:GetCooldown() + 15 or Unit("player"):HasBuffsStacks(A.GuardianofAzerothBuff.ID, true) == 5 and Unit(unit):TimeToDie() < A.GuardianofAzeroth:GetCooldown() + 20 or Unit(unit):HasDeBuffsDown(A.RazorCoralDebuff.ID, true) or Unit(unit):TimeToDie() < 21 or Unit("player"):HasBuffs(A.WorldveinResonanceBuff.ID, true) and Unit(unit):TimeToDie() < A.WorldveinResonance:GetCooldown() + 18 or not A.BirdsofPrey:IsSpellLearned() and Unit(unit):TimeToDie() < A.CoordinatedAssault:GetCooldown() + 20 and Unit("player"):HasBuffs(A.CoordinatedAssaultBuff.ID, true)) then
                return A.AshvanesRazorCoral:Show(icon)
            end
            
            -- use_item,name=galecallers_boon,if=cooldown.memory_of_lucid_dreams.remains|talent.wildfire_infusion.enabled&cooldown.coordinated_assault.remains|!essence.memory_of_lucid_dreams.major&cooldown.coordinated_assault.remains
            if A.GalecallersBoon:IsReady(unit) and (A.MemoryofLucidDreams:GetCooldown() or A.WildfireInfusion:IsSpellLearned() and A.CoordinatedAssault:GetCooldown() or not Azerite:EssenceHasMajor(A.MemoryofLucidDreams.ID) and A.CoordinatedAssault:GetCooldown()) then
                return A.GalecallersBoon:Show(icon)
            end
            
            -- use_item,name=azsharas_font_of_power
            if A.AzsharasFontofPower:IsReady(unit) then
                return A.AzsharasFontofPower:Show(icon)
            end
            
            -- focused_azerite_beam,if=raid_event.adds.in>90&focus<focus.max-25|(active_enemies>1&!talent.birds_of_prey.enabled|active_enemies>2)&(buff.blur_of_talons.up&buff.blur_of_talons.remains>3*gcd|!buff.blur_of_talons.up)
            if A.FocusedAzeriteBeam:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and (IncomingAddsIn > 90 and Player:Focus() < Player:FocusMax() - 25 or (MultiUnits:GetByRangeInCombat(8, 5, 10) > 1 and not A.BirdsofPrey:IsSpellLearned() or MultiUnits:GetByRangeInCombat(8, 5, 10) > 2) and (Unit("player"):HasBuffs(A.BlurofTalonsBuff.ID, true) and Unit("player"):HasBuffs(A.BlurofTalonsBuff.ID, true) > 3 * GetGCD() or not Unit("player"):HasBuffs(A.BlurofTalonsBuff.ID, true))) then
                return A.FocusedAzeriteBeam:Show(icon)
            end
            
            -- blood_of_the_enemy,if=((raid_event.adds.remains>90|!raid_event.adds.exists)|(active_enemies>1&!talent.birds_of_prey.enabled|active_enemies>2))&focus<focus.max
            if A.BloodoftheEnemy:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and (((0 > 90 or not (MultiUnits:GetByRangeInCombat(8, 5, 10) > 1)) or (MultiUnits:GetByRangeInCombat(8, 5, 10) > 1 and not A.BirdsofPrey:IsSpellLearned() or MultiUnits:GetByRangeInCombat(8, 5, 10) > 2)) and Player:Focus() < Player:FocusMax()) then
                return A.BloodoftheEnemy:Show(icon)
            end
            
            -- purifying_blast,if=((raid_event.adds.remains>60|!raid_event.adds.exists)|(active_enemies>1&!talent.birds_of_prey.enabled|active_enemies>2))&focus<focus.max
            if A.PurifyingBlast:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and (((0 > 60 or not (MultiUnits:GetByRangeInCombat(8, 5, 10) > 1)) or (MultiUnits:GetByRangeInCombat(8, 5, 10) > 1 and not A.BirdsofPrey:IsSpellLearned() or MultiUnits:GetByRangeInCombat(8, 5, 10) > 2)) and Player:Focus() < Player:FocusMax()) then
                return A.PurifyingBlast:Show(icon)
            end
            
            -- guardian_of_azeroth
            if A.GuardianofAzeroth:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth then
                return A.GuardianofAzeroth:Show(icon)
            end
            
            -- ripple_in_space
            if A.RippleInSpace:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth then
                return A.RippleInSpace:Show(icon)
            end
            
            -- concentrated_flame,if=full_recharge_time<1*gcd
            if A.ConcentratedFlame:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and (A.ConcentratedFlame:GetSpellChargesFullRechargeTime() < 1 * GetGCD()) then
                return A.ConcentratedFlame:Show(icon)
            end
            
            -- the_unbound_force,if=buff.reckless_force.up
            if A.TheUnboundForce:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and (Unit("player"):HasBuffs(A.RecklessForceBuff.ID, true)) then
                return A.TheUnboundForce:Show(icon)
            end
            
            -- worldvein_resonance
            if A.WorldveinResonance:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth then
                return A.WorldveinResonance:Show(icon)
            end
            
            -- reaping_flames,if=target.health.pct>80|target.health.pct<=20|target.time_to_pct_20>30
            if A.ReapingFlames:IsReady(unit) and (Unit(unit):HealthPercent() > 80 or Unit(unit):HealthPercent() <= 20 or target.time_to_pct_20 > 30) then
                return A.ReapingFlames:Show(icon)
            end
            
            -- serpent_sting,if=essence.memory_of_lucid_dreams.major&refreshable&buff.vipers_venom.up&!cooldown.memory_of_lucid_dreams.remains
            if A.SerpentSting:IsReady(unit) and (Azerite:EssenceHasMajor(A.MemoryofLucidDreams.ID) and Unit(unit):HasDeBuffsRefreshable(A.SerpentStingDebuff.ID, true) and Unit("player"):HasBuffs(A.VipersVenomBuff.ID, true) and not A.MemoryofLucidDreams:GetCooldown()) then
                return A.SerpentSting:Show(icon)
            end
            
            -- mongoose_bite,if=essence.memory_of_lucid_dreams.major&!cooldown.memory_of_lucid_dreams.remains
            if A.MongooseBite:IsReady(unit) and (Azerite:EssenceHasMajor(A.MemoryofLucidDreams.ID) and not A.MemoryofLucidDreams:GetCooldown()) then
                return A.MongooseBite:Show(icon)
            end
            
            -- wildfire_bomb,if=essence.memory_of_lucid_dreams.major&full_recharge_time<1.5*gcd&focus<action.mongoose_bite.cost&!cooldown.memory_of_lucid_dreams.remains
            if A.WildfireBomb:IsReady(unit) and (Azerite:EssenceHasMajor(A.MemoryofLucidDreams.ID) and A.WildfireBomb:GetSpellChargesFullRechargeTime() < 1.5 * GetGCD() and Player:Focus() < A.MongooseBite:GetSpellPowerCostCache() and not A.MemoryofLucidDreams:GetCooldown()) then
                return A.WildfireBomb:Show(icon)
            end
            
            -- memory_of_lucid_dreams,if=focus<action.mongoose_bite.cost&buff.coordinated_assault.up
            if A.MemoryofLucidDreams:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and (Player:Focus() < A.MongooseBite:GetSpellPowerCostCache() and Unit("player"):HasBuffs(A.CoordinatedAssaultBuff.ID, true)) then
                return A.MemoryofLucidDreams:Show(icon)
            end
            
        end
        
        --Cleave
        local function Cleave(unit)
        
            -- variable,name=carve_cdr,op=setif,value=active_enemies,value_else=5,condition=active_enemies<5
            if  then
                if Action.Utils.CastTargetIf(VarCarveCdr, 8, "min", EvaluateCycleCarveCdr568) then
                    return VarCarveCdr:Show(icon) 
                end
            end
            -- mongoose_bite,if=azerite.blur_of_talons.rank>0&(buff.coordinated_assault.up&(buff.coordinated_assault.remains<1.5*gcd|buff.blur_of_talons.up&buff.blur_of_talons.remains<1.5*gcd|buff.coordinated_assault.remains&!buff.blur_of_talons.remains))
            if A.MongooseBite:IsReady(unit) and (A.BlurofTalons:GetAzeriteRank() > 0 and (Unit("player"):HasBuffs(A.CoordinatedAssaultBuff.ID, true) and (Unit("player"):HasBuffs(A.CoordinatedAssaultBuff.ID, true) < 1.5 * GetGCD() or Unit("player"):HasBuffs(A.BlurofTalonsBuff.ID, true) and Unit("player"):HasBuffs(A.BlurofTalonsBuff.ID, true) < 1.5 * GetGCD() or Unit("player"):HasBuffs(A.CoordinatedAssaultBuff.ID, true) and not Unit("player"):HasBuffs(A.BlurofTalonsBuff.ID, true)))) then
                return A.MongooseBite:Show(icon)
            end
            
            -- mongoose_bite,target_if=min:time_to_die,if=debuff.latent_poison.stack>(active_enemies|9)&target.time_to_die<active_enemies*gcd
            if A.MongooseBite:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.MongooseBite, 8, "min", EvaluateTargetIfFilterMongooseBite602, EvaluateTargetIfMongooseBite627) then 
                    return A.MongooseBite:Show(icon) 
                end
            end
            -- a_murder_of_crows
            if A.AMurderofCrows:IsReady(unit) then
                return A.AMurderofCrows:Show(icon)
            end
            
            -- coordinated_assault
            if A.CoordinatedAssault:IsReady(unit) and A.BurstIsON(unit) then
                return A.CoordinatedAssault:Show(icon)
            end
            
            -- carve,if=dot.shrapnel_bomb.ticking&!talent.hydras_bite.enabled|dot.shrapnel_bomb.ticking&active_enemies>5
            if A.Carve:IsReady(unit) and (Unit(unit):HasDeBuffs(A.ShrapnelBombDebuff.ID, true) and not A.HydrasBite:IsSpellLearned() or Unit(unit):HasDeBuffs(A.ShrapnelBombDebuff.ID, true) and MultiUnits:GetByRangeInCombat(8, 5, 10) > 5) then
                return A.Carve:Show(icon)
            end
            
            -- wildfire_bomb,if=!talent.guerrilla_tactics.enabled|full_recharge_time<gcd|raid_event.adds.remains<6&raid_event.adds.exists
            if A.WildfireBomb:IsReady(unit) and (not A.GuerrillaTactics:IsSpellLearned() or A.WildfireBomb:GetSpellChargesFullRechargeTime() < GetGCD() or 0 < 6 and (MultiUnits:GetByRangeInCombat(8, 5, 10) > 1)) then
                return A.WildfireBomb:Show(icon)
            end
            
            -- butchery,if=charges_fractional>2.5|dot.shrapnel_bomb.ticking|cooldown.wildfire_bomb.remains>active_enemies-gcd|debuff.blood_of_the_enemy.remains|raid_event.adds.remains<5&raid_event.adds.exists
            if A.Butchery:IsReady(unit) and (A.Butchery:GetSpellChargesFrac() > 2.5 or Unit(unit):HasDeBuffs(A.ShrapnelBombDebuff.ID, true) or A.WildfireBomb:GetCooldown() > MultiUnits:GetByRangeInCombat(8, 5, 10) - GetGCD() or Unit(unit):HasDeBuffs(A.BloodoftheEnemyDebuff.ID, true) or 0 < 5 and (MultiUnits:GetByRangeInCombat(8, 5, 10) > 1)) then
                return A.Butchery:Show(icon)
            end
            
            -- mongoose_bite,target_if=max:debuff.latent_poison.stack,if=debuff.latent_poison.stack>8
            if A.MongooseBite:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.MongooseBite, 8, "max", EvaluateTargetIfFilterMongooseBite683, EvaluateTargetIfMongooseBite692) then 
                    return A.MongooseBite:Show(icon) 
                end
            end
            -- chakrams
            if A.Chakrams:IsReady(unit) then
                return A.Chakrams:Show(icon)
            end
            
            -- kill_command,target_if=min:bloodseeker.remains,if=focus+cast_regen<focus.max
            if A.KillCommand:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.KillCommand, 8, "min", EvaluateTargetIfFilterKillCommand700, EvaluateTargetIfKillCommand713) then 
                    return A.KillCommand:Show(icon) 
                end
            end
            -- harpoon,if=talent.terms_of_engagement.enabled
            if A.Harpoon:IsReady(unit) and (A.TermsofEngagement:IsSpellLearned()) then
                return A.Harpoon:Show(icon)
            end
            
            -- carve,if=talent.guerrilla_tactics.enabled
            if A.Carve:IsReady(unit) and (A.GuerrillaTactics:IsSpellLearned()) then
                return A.Carve:Show(icon)
            end
            
            -- butchery,if=cooldown.wildfire_bomb.remains>(active_enemies|5)
            if A.Butchery:IsReady(unit) and (A.WildfireBomb:GetCooldown() > num((MultiUnits:GetByRangeInCombat(8, 5, 10) or 5))) then
                return A.Butchery:Show(icon)
            end
            
            -- flanking_strike,if=focus+cast_regen<focus.max
            if A.FlankingStrike:IsReady(unit) and (Player:Focus() + Unit("player"):FocusCastRegen(A.FlankingStrike:GetSpellCastTime) < Player:FocusMax()) then
                return A.FlankingStrike:Show(icon)
            end
            
            -- wildfire_bomb,if=dot.wildfire_bomb.refreshable|talent.wildfire_infusion.enabled
            if A.WildfireBomb:IsReady(unit) and (Unit(unit):HasDeBuffsRefreshable(A.WildfireBombDebuff.ID, true) or A.WildfireInfusion:IsSpellLearned()) then
                return A.WildfireBomb:Show(icon)
            end
            
            -- serpent_sting,target_if=min:remains,if=buff.vipers_venom.react
            if A.SerpentSting:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.SerpentSting, 8, "min", EvaluateTargetIfFilterSerpentSting751, EvaluateTargetIfSerpentSting768) then 
                    return A.SerpentSting:Show(icon) 
                end
            end
            -- carve,if=cooldown.wildfire_bomb.remains>variable.carve_cdr%2
            if A.Carve:IsReady(unit) and (A.WildfireBomb:GetCooldown() > VarCarveCdr / 2) then
                return A.Carve:Show(icon)
            end
            
            -- steel_trap
            if A.SteelTrap:IsReady(unit) then
                return A.SteelTrap:Show(icon)
            end
            
            -- serpent_sting,target_if=min:remains,if=refreshable&buff.tip_of_the_spear.stack<3&next_wi_bomb.volatile|refreshable&azerite.latent_poison.rank>0
            if A.SerpentSting:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.SerpentSting, 8, "min", EvaluateTargetIfFilterSerpentSting782, EvaluateTargetIfSerpentSting813) then 
                    return A.SerpentSting:Show(icon) 
                end
            end
            -- mongoose_bite,target_if=max:debuff.latent_poison.stack
            if A.MongooseBite:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.MongooseBite, 8, "max", EvaluateTargetIfFilterMongooseBite819) then 
                    return A.MongooseBite:Show(icon) 
                end
            end
            -- raptor_strike,target_if=max:debuff.latent_poison.stack
            if A.RaptorStrike:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.RaptorStrike, 8, "max", EvaluateTargetIfFilterRaptorStrike830) then 
                    return A.RaptorStrike:Show(icon) 
                end
            end
        end
        
        --St
        local function St(unit)
        
            -- kill_shot
            if A.KillShot:IsReady(unit) then
                return A.KillShot:Show(icon)
            end
            
            -- harpoon,if=talent.terms_of_engagement.enabled
            if A.Harpoon:IsReady(unit) and (A.TermsofEngagement:IsSpellLearned()) then
                return A.Harpoon:Show(icon)
            end
            
            -- flanking_strike,if=focus+cast_regen<focus.max
            if A.FlankingStrike:IsReady(unit) and (Player:Focus() + Unit("player"):FocusCastRegen(A.FlankingStrike:GetSpellCastTime) < Player:FocusMax()) then
                return A.FlankingStrike:Show(icon)
            end
            
            -- raptor_strike,if=buff.coordinated_assault.up&(buff.coordinated_assault.remains<1.5*gcd|buff.blur_of_talons.up&buff.blur_of_talons.remains<1.5*gcd)
            if A.RaptorStrike:IsReady(unit) and (Unit("player"):HasBuffs(A.CoordinatedAssaultBuff.ID, true) and (Unit("player"):HasBuffs(A.CoordinatedAssaultBuff.ID, true) < 1.5 * GetGCD() or Unit("player"):HasBuffs(A.BlurofTalonsBuff.ID, true) and Unit("player"):HasBuffs(A.BlurofTalonsBuff.ID, true) < 1.5 * GetGCD())) then
                return A.RaptorStrike:Show(icon)
            end
            
            -- mongoose_bite,if=buff.coordinated_assault.up&(buff.coordinated_assault.remains<1.5*gcd|buff.blur_of_talons.up&buff.blur_of_talons.remains<1.5*gcd)
            if A.MongooseBite:IsReady(unit) and (Unit("player"):HasBuffs(A.CoordinatedAssaultBuff.ID, true) and (Unit("player"):HasBuffs(A.CoordinatedAssaultBuff.ID, true) < 1.5 * GetGCD() or Unit("player"):HasBuffs(A.BlurofTalonsBuff.ID, true) and Unit("player"):HasBuffs(A.BlurofTalonsBuff.ID, true) < 1.5 * GetGCD())) then
                return A.MongooseBite:Show(icon)
            end
            
            -- kill_command,target_if=min:bloodseeker.remains,if=focus+cast_regen<focus.max
            if A.KillCommand:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.KillCommand, 8, "min", EvaluateTargetIfFilterKillCommand875, EvaluateTargetIfKillCommand888) then 
                    return A.KillCommand:Show(icon) 
                end
            end
            -- serpent_sting,if=buff.vipers_venom.up&buff.vipers_venom.remains<1*gcd
            if A.SerpentSting:IsReady(unit) and (Unit("player"):HasBuffs(A.VipersVenomBuff.ID, true) and Unit("player"):HasBuffs(A.VipersVenomBuff.ID, true) < 1 * GetGCD()) then
                return A.SerpentSting:Show(icon)
            end
            
            -- steel_trap,if=focus+cast_regen<focus.max
            if A.SteelTrap:IsReady(unit) and (Player:Focus() + Unit("player"):FocusCastRegen(A.SteelTrap:GetSpellCastTime) < Player:FocusMax()) then
                return A.SteelTrap:Show(icon)
            end
            
            -- wildfire_bomb,if=focus+cast_regen<focus.max&refreshable&full_recharge_time<gcd&!buff.memory_of_lucid_dreams.up|focus+cast_regen<focus.max&(!dot.wildfire_bomb.ticking&(!buff.coordinated_assault.up|buff.mongoose_fury.stack<1|time_to_die<18|!dot.wildfire_bomb.ticking&azerite.wilderness_survival.rank>0))&!buff.memory_of_lucid_dreams.up
            if A.WildfireBomb:IsReady(unit) and (Player:Focus() + Unit("player"):FocusCastRegen(A.WildfireBomb:GetSpellCastTime) < Player:FocusMax() and Unit(unit):HasDeBuffsRefreshable(A.WildfireBombDebuff.ID, true) and A.WildfireBomb:GetSpellChargesFullRechargeTime() < GetGCD() and not Unit("player"):HasBuffs(A.MemoryofLucidDreamsBuff.ID, true) or Player:Focus() + Unit("player"):FocusCastRegen(A.WildfireBomb:GetSpellCastTime) < Player:FocusMax() and (not Unit(unit):HasDeBuffs(A.WildfireBombDebuff.ID, true) and (not Unit("player"):HasBuffs(A.CoordinatedAssaultBuff.ID, true) or Unit("player"):HasBuffsStacks(A.MongooseFuryBuff.ID, true) < 1 or Unit(unit):TimeToDie() < 18 or not Unit(unit):HasDeBuffs(A.WildfireBombDebuff.ID, true) and A.WildernessSurvival:GetAzeriteRank() > 0)) and not Unit("player"):HasBuffs(A.MemoryofLucidDreamsBuff.ID, true)) then
                return A.WildfireBomb:Show(icon)
            end
            
            -- serpent_sting,if=buff.vipers_venom.up&dot.serpent_sting.remains<4*gcd|dot.serpent_sting.refreshable&!buff.coordinated_assault.up
            if A.SerpentSting:IsReady(unit) and (Unit("player"):HasBuffs(A.VipersVenomBuff.ID, true) and Unit(unit):HasDeBuffs(A.SerpentStingDebuff.ID, true) < 4 * GetGCD() or Unit(unit):HasDeBuffsRefreshable(A.SerpentStingDebuff.ID, true) and not Unit("player"):HasBuffs(A.CoordinatedAssaultBuff.ID, true)) then
                return A.SerpentSting:Show(icon)
            end
            
            -- a_murder_of_crows,if=!buff.coordinated_assault.up
            if A.AMurderofCrows:IsReady(unit) and (not Unit("player"):HasBuffs(A.CoordinatedAssaultBuff.ID, true)) then
                return A.AMurderofCrows:Show(icon)
            end
            
            -- coordinated_assault,if=!buff.coordinated_assault.up
            if A.CoordinatedAssault:IsReady(unit) and A.BurstIsON(unit) and (not Unit("player"):HasBuffs(A.CoordinatedAssaultBuff.ID, true)) then
                return A.CoordinatedAssault:Show(icon)
            end
            
            -- mongoose_bite,if=buff.mongoose_fury.up|focus+cast_regen>focus.max-20&talent.vipers_venom.enabled|focus+cast_regen>focus.max-1&talent.terms_of_engagement.enabled|buff.coordinated_assault.up
            if A.MongooseBite:IsReady(unit) and (Unit("player"):HasBuffs(A.MongooseFuryBuff.ID, true) or Player:Focus() + Unit("player"):FocusCastRegen(A.MongooseBite:GetSpellCastTime) > Player:FocusMax() - 20 and A.VipersVenom:IsSpellLearned() or Player:Focus() + Unit("player"):FocusCastRegen(A.MongooseBite:GetSpellCastTime) > Player:FocusMax() - 1 and A.TermsofEngagement:IsSpellLearned() or Unit("player"):HasBuffs(A.CoordinatedAssaultBuff.ID, true)) then
                return A.MongooseBite:Show(icon)
            end
            
            -- raptor_strike
            if A.RaptorStrike:IsReady(unit) then
                return A.RaptorStrike:Show(icon)
            end
            
            -- wildfire_bomb,if=dot.wildfire_bomb.refreshable
            if A.WildfireBomb:IsReady(unit) and (Unit(unit):HasDeBuffsRefreshable(A.WildfireBombDebuff.ID, true)) then
                return A.WildfireBomb:Show(icon)
            end
            
            -- serpent_sting,if=buff.vipers_venom.up
            if A.SerpentSting:IsReady(unit) and (Unit("player"):HasBuffs(A.VipersVenomBuff.ID, true)) then
                return A.SerpentSting:Show(icon)
            end
            
        end
        
        --Wfi
        local function Wfi(unit)
        
            -- kill_shot
            if A.KillShot:IsReady(unit) then
                return A.KillShot:Show(icon)
            end
            
            -- harpoon,if=focus+cast_regen<focus.max&talent.terms_of_engagement.enabled
            if A.Harpoon:IsReady(unit) and (Player:Focus() + Unit("player"):FocusCastRegen(A.Harpoon:GetSpellCastTime) < Player:FocusMax() and A.TermsofEngagement:IsSpellLearned()) then
                return A.Harpoon:Show(icon)
            end
            
            -- mongoose_bite,if=buff.blur_of_talons.up&buff.blur_of_talons.remains<gcd
            if A.MongooseBite:IsReady(unit) and (Unit("player"):HasBuffs(A.BlurofTalonsBuff.ID, true) and Unit("player"):HasBuffs(A.BlurofTalonsBuff.ID, true) < GetGCD()) then
                return A.MongooseBite:Show(icon)
            end
            
            -- raptor_strike,if=buff.blur_of_talons.up&buff.blur_of_talons.remains<gcd
            if A.RaptorStrike:IsReady(unit) and (Unit("player"):HasBuffs(A.BlurofTalonsBuff.ID, true) and Unit("player"):HasBuffs(A.BlurofTalonsBuff.ID, true) < GetGCD()) then
                return A.RaptorStrike:Show(icon)
            end
            
            -- serpent_sting,if=buff.vipers_venom.up&buff.vipers_venom.remains<1.5*gcd|!dot.serpent_sting.ticking
            if A.SerpentSting:IsReady(unit) and (Unit("player"):HasBuffs(A.VipersVenomBuff.ID, true) and Unit("player"):HasBuffs(A.VipersVenomBuff.ID, true) < 1.5 * GetGCD() or not Unit(unit):HasDeBuffs(A.SerpentStingDebuff.ID, true)) then
                return A.SerpentSting:Show(icon)
            end
            
            -- wildfire_bomb,if=full_recharge_time<1.5*gcd&focus+cast_regen<focus.max|(next_wi_bomb.volatile&dot.serpent_sting.ticking&dot.serpent_sting.refreshable|next_wi_bomb.pheromone&!buff.mongoose_fury.up&focus+cast_regen<focus.max-action.kill_command.cast_regen*3)
            if A.WildfireBomb:IsReady(unit) and (A.WildfireBomb:GetSpellChargesFullRechargeTime() < 1.5 * GetGCD() and Player:Focus() + Unit("player"):FocusCastRegen(A.WildfireBomb:GetSpellCastTime) < Player:FocusMax() or (S.VolatileBomb:IsLearned() and Unit(unit):HasDeBuffs(A.SerpentStingDebuff.ID, true) and Unit(unit):HasDeBuffsRefreshable(A.SerpentStingDebuff.ID, true) or S.PheromoneBomb:IsLearned() and not Unit("player"):HasBuffs(A.MongooseFuryBuff.ID, true) and Player:Focus() + Unit("player"):FocusCastRegen(A.WildfireBomb:GetSpellCastTime) < Player:FocusMax() - Unit("player"):FocusCastRegen(A.KillCommand:GetSpellCastTime) * 3)) then
                return A.WildfireBomb:Show(icon)
            end
            
            -- kill_command,target_if=min:bloodseeker.remains,if=focus+cast_regen<focus.max-focus.regen
            if A.KillCommand:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.KillCommand, 8, "min", EvaluateTargetIfFilterKillCommand1078, EvaluateTargetIfKillCommand1091) then 
                    return A.KillCommand:Show(icon) 
                end
            end
            -- a_murder_of_crows
            if A.AMurderofCrows:IsReady(unit) then
                return A.AMurderofCrows:Show(icon)
            end
            
            -- steel_trap,if=focus+cast_regen<focus.max
            if A.SteelTrap:IsReady(unit) and (Player:Focus() + Unit("player"):FocusCastRegen(A.SteelTrap:GetSpellCastTime) < Player:FocusMax()) then
                return A.SteelTrap:Show(icon)
            end
            
            -- wildfire_bomb,if=full_recharge_time<1.5*gcd
            if A.WildfireBomb:IsReady(unit) and (A.WildfireBomb:GetSpellChargesFullRechargeTime() < 1.5 * GetGCD()) then
                return A.WildfireBomb:Show(icon)
            end
            
            -- coordinated_assault
            if A.CoordinatedAssault:IsReady(unit) and A.BurstIsON(unit) then
                return A.CoordinatedAssault:Show(icon)
            end
            
            -- serpent_sting,if=buff.vipers_venom.up&dot.serpent_sting.remains<4*gcd
            if A.SerpentSting:IsReady(unit) and (Unit("player"):HasBuffs(A.VipersVenomBuff.ID, true) and Unit(unit):HasDeBuffs(A.SerpentStingDebuff.ID, true) < 4 * GetGCD()) then
                return A.SerpentSting:Show(icon)
            end
            
            -- mongoose_bite,if=dot.shrapnel_bomb.ticking|buff.mongoose_fury.stack=5
            if A.MongooseBite:IsReady(unit) and (Unit(unit):HasDeBuffs(A.ShrapnelBombDebuff.ID, true) or Unit("player"):HasBuffsStacks(A.MongooseFuryBuff.ID, true) == 5) then
                return A.MongooseBite:Show(icon)
            end
            
            -- wildfire_bomb,if=next_wi_bomb.shrapnel&dot.serpent_sting.remains>5*gcd
            if A.WildfireBomb:IsReady(unit) and (S.ShrapnelBomb:IsLearned() and Unit(unit):HasDeBuffs(A.SerpentStingDebuff.ID, true) > 5 * GetGCD()) then
                return A.WildfireBomb:Show(icon)
            end
            
            -- serpent_sting,if=refreshable
            if A.SerpentSting:IsReady(unit) and (Unit(unit):HasDeBuffsRefreshable(A.SerpentStingDebuff.ID, true)) then
                return A.SerpentSting:Show(icon)
            end
            
            -- chakrams,if=!buff.mongoose_fury.remains
            if A.Chakrams:IsReady(unit) and (not Unit("player"):HasBuffs(A.MongooseFuryBuff.ID, true)) then
                return A.Chakrams:Show(icon)
            end
            
            -- mongoose_bite
            if A.MongooseBite:IsReady(unit) then
                return A.MongooseBite:Show(icon)
            end
            
            -- raptor_strike
            if A.RaptorStrike:IsReady(unit) then
                return A.RaptorStrike:Show(icon)
            end
            
            -- serpent_sting,if=buff.vipers_venom.up
            if A.SerpentSting:IsReady(unit) and (Unit("player"):HasBuffs(A.VipersVenomBuff.ID, true)) then
                return A.SerpentSting:Show(icon)
            end
            
            -- wildfire_bomb,if=next_wi_bomb.volatile&dot.serpent_sting.ticking|next_wi_bomb.pheromone|next_wi_bomb.shrapnel
            if A.WildfireBomb:IsReady(unit) and (S.VolatileBomb:IsLearned() and Unit(unit):HasDeBuffs(A.SerpentStingDebuff.ID, true) or S.PheromoneBomb:IsLearned() or S.ShrapnelBomb:IsLearned()) then
                return A.WildfireBomb:Show(icon)
            end
            
        end
        
  if Everyone.TargetIsValid() then
        
        -- call precombat
        if Precombat(unit) and not inCombat and Unit(unit):IsExists() and unit ~= "mouseover" then 
            return true
        end
            -- auto_attack
            -- use_items
            -- call_action_list,name=cds
            if Cds(unit) then
                return true
            end
            
            -- mongoose_bite,if=active_enemies=1&target.time_to_die<focus%(action.mongoose_bite.cost-cast_regen)*gcd
            if A.MongooseBite:IsReady(unit) and (MultiUnits:GetByRangeInCombat(8, 5, 10) == 1 and Unit(unit):TimeToDie() < Player:Focus() / (A.MongooseBite:GetSpellPowerCostCache() - Unit("player"):FocusCastRegen(A.MongooseBite:GetSpellCastTime)) * GetGCD()) then
                return A.MongooseBite:Show(icon)
            end
            
            -- call_action_list,name=apwfi,if=active_enemies<3&talent.chakrams.enabled&talent.alpha_predator.enabled
            if (MultiUnits:GetByRangeInCombat(8, 5, 10) < 3 and A.Chakrams:IsSpellLearned() and A.AlphaPredator:IsSpellLearned()) then
                if Apwfi(unit) then
                    return true
                end
            end
            
            -- call_action_list,name=wfi,if=active_enemies<3&talent.chakrams.enabled
            if (MultiUnits:GetByRangeInCombat(8, 5, 10) < 3 and A.Chakrams:IsSpellLearned()) then
                if Wfi(unit) then
                    return true
                end
            end
            
            -- call_action_list,name=st,if=active_enemies<3&!talent.alpha_predator.enabled&!talent.wildfire_infusion.enabled
            if (MultiUnits:GetByRangeInCombat(8, 5, 10) < 3 and not A.AlphaPredator:IsSpellLearned() and not A.WildfireInfusion:IsSpellLearned()) then
                if St(unit) then
                    return true
                end
            end
            
            -- call_action_list,name=apst,if=active_enemies<3&talent.alpha_predator.enabled&!talent.wildfire_infusion.enabled
            if (MultiUnits:GetByRangeInCombat(8, 5, 10) < 3 and A.AlphaPredator:IsSpellLearned() and not A.WildfireInfusion:IsSpellLearned()) then
                if Apst(unit) then
                    return true
                end
            end
            
            -- call_action_list,name=apwfi,if=active_enemies<3&talent.alpha_predator.enabled&talent.wildfire_infusion.enabled
            if (MultiUnits:GetByRangeInCombat(8, 5, 10) < 3 and A.AlphaPredator:IsSpellLearned() and A.WildfireInfusion:IsSpellLearned()) then
                if Apwfi(unit) then
                    return true
                end
            end
            
            -- call_action_list,name=wfi,if=active_enemies<3&!talent.alpha_predator.enabled&talent.wildfire_infusion.enabled
            if (MultiUnits:GetByRangeInCombat(8, 5, 10) < 3 and not A.AlphaPredator:IsSpellLearned() and A.WildfireInfusion:IsSpellLearned()) then
                if Wfi(unit) then
                    return true
                end
            end
            
            -- call_action_list,name=cleave,if=active_enemies>1&!talent.birds_of_prey.enabled|active_enemies>2
            if (MultiUnits:GetByRangeInCombat(8, 5, 10) > 1 and not A.BirdsofPrey:IsSpellLearned() or MultiUnits:GetByRangeInCombat(8, 5, 10) > 2) then
                if Cleave(unit) then
                    return true
                end
            end
            
            -- concentrated_flame
            if A.ConcentratedFlame:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth then
                return A.ConcentratedFlame:Show(icon)
            end
            
            -- arcane_torrent
            if A.ArcaneTorrent:AutoRacial(unit) and Racial and A.BurstIsON(unit) then
                return A.ArcaneTorrent:Show(icon)
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

