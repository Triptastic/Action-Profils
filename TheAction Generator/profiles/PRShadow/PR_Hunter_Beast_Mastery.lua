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

Action[ACTION_CONST_HUNTER_BEASTMASTERY] = {
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
    AspectoftheWildBuff                    = Create({ Type = "Spell", ID = 193530 }),
    AspectoftheWild                        = Create({ Type = "Spell", ID = 193530 }),
    PrimalInstinctsBuff                    = Create({ Type = "Spell", ID = 279810 }),
    PrimalInstincts                        = Create({ Type = "Spell", ID = 279806 }),
    EssenceoftheFocusingIris               = Create({ Type = "Spell", ID =  }),
    BestialWrathBuff                       = Create({ Type = "Spell", ID = 19574 }),
    BestialWrath                           = Create({ Type = "Spell", ID = 19574 }),
    AncestralCall                          = Create({ Type = "Spell", ID = 274738 }),
    Fireblood                              = Create({ Type = "Spell", ID = 265221 }),
    Berserking                             = Create({ Type = "Spell", ID = 26297 }),
    BerserkingBuff                         = Create({ Type = "Spell", ID = 26297 }),
    KillerInstinct                         = Create({ Type = "Spell", ID = 273887 }),
    BloodFury                              = Create({ Type = "Spell", ID = 20572 }),
    BloodFuryBuff                          = Create({ Type = "Spell", ID = 20572 }),
    LightsJudgment                         = Create({ Type = "Spell", ID = 255647 }),
    FrenzyBuff                             = Create({ Type = "Spell", ID = 272790 }),
    PotionofUnbridledFuryBuff              = Create({ Type = "Spell", ID =  }),
    UnbridledFuryBuff                      = Create({ Type = "Spell", ID =  }),
    VisionofPerfection                     = Create({ Type = "Spell", ID =  }),
    ReapingFlames                          = Create({ Type = "Spell", ID =  }),
    BarbedShot                             = Create({ Type = "Spell", ID = 217200 }),
    BarbedShotDebuff                       = Create({ Type = "Spell", ID =  }),
    ScentofBlood                           = Create({ Type = "Spell", ID = 193532 }),
    Multishot                              = Create({ Type = "Spell", ID = 2643 }),
    BeastCleaveBuff                        = Create({ Type = "Spell", ID = 118455, "pet" }),
    Stampede                               = Create({ Type = "Spell", ID = 201430 }),
    OneWiththePack                         = Create({ Type = "Spell", ID = 199528 }),
    ChimaeraShot                           = Create({ Type = "Spell", ID = 53209 }),
    AMurderofCrows                         = Create({ Type = "Spell", ID = 131894 }),
    Barrage                                = Create({ Type = "Spell", ID = 120360 }),
    KillCommand                            = Create({ Type = "Spell", ID = 34026 }),
    RapidReload                            = Create({ Type = "Spell", ID =  }),
    DireBeast                              = Create({ Type = "Spell", ID = 120679 }),
    CobraShot                              = Create({ Type = "Spell", ID = 193455 }),
    KillShot                               = Create({ Type = "Spell", ID =  }),
    Bloodshed                              = Create({ Type = "Spell", ID =  }),
    DanceofDeath                           = Create({ Type = "Spell", ID =  }),
    DanceofDeathBuff                       = Create({ Type = "Spell", ID =  }),
    BagofTricks                            = Create({ Type = "Spell", ID =  }),
    GuardianofAzerothBuff                  = Create({ Type = "Spell", ID =  }),
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
Action:CreateEssencesFor(ACTION_CONST_HUNTER_BEASTMASTERY)  -- where PLAYERSPEC is Constance (example: ACTION_CONST_MONK_BM)
local A = setmetatable(Action[ACTION_CONST_HUNTER_BEASTMASTERY], { __index = Action })





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
------- BEASTMASTERY PRE APL SETUP -------
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

-- Non GCD spell check
local function countInterruptGCD(unit)
    if not A.CounterShot:IsReadyByPassCastGCD(unit) or not A.CounterShot:AbsentImun(unit, Temp.TotalAndMagKick) then
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
        -- CounterShot
        if useKick and not notInterruptable and A.CounterShot:IsReady(unit) then 
            return A.CounterShot
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

local function EvaluateTargetIfFilterBarbedShot133(unit)
  return Unit(unit):HasDeBuffs(A.BarbedShotDebuff.ID, true)
end

local function EvaluateTargetIfBarbedShot148(unit)
  return Pet:HasBuffs(A.FrenzyBuff.ID, true) and Pet:HasBuffs(A.FrenzyBuff.ID, true) <= GetGCD() or A.BestialWrath:GetCooldown() < 12 + GetGCD() and A.ScentofBlood:IsSpellLearned()
end


local function EvaluateTargetIfFilterBarbedShot158(unit)
  return Unit(unit):HasDeBuffs(A.BarbedShotDebuff.ID, true)
end

local function EvaluateTargetIfBarbedShot171(unit)
  return A.BarbedShot:GetSpellChargesFullRechargeTime() < GetGCD() and A.BestialWrath:GetCooldown()
end


local function EvaluateTargetIfFilterBarbedShot211(unit)
  return Unit(unit):HasDeBuffs(A.BarbedShotDebuff.ID, true)
end

local function EvaluateTargetIfBarbedShot236(unit)
  return Pet:HasBuffsDown(A.FrenzyBuff.ID, true) and (A.BarbedShot:GetSpellChargesFrac() > 1.8 or Unit("player"):HasBuffs(A.BestialWrathBuff.ID, true)) or A.AspectoftheWild:GetCooldown() < A.FrenzyBuff.ID, true:BaseDuration() - GetGCD() and A.PrimalInstincts:GetAzeriteRank() > 0 or A.BarbedShot:GetSpellChargesFrac() > 1.4 or Unit(unit):TimeToDie() < 9
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
            -- summon_pet
            if A.SummonPet:IsReady(unit) then
                return A.SummonPet:Show(icon)
            end
            
            -- snapshot_stats
            -- use_item,name=azsharas_font_of_power
            if A.AzsharasFontofPower:IsReady(unit) then
                return A.AzsharasFontofPower:Show(icon)
            end
            
            -- worldvein_resonance
            if A.WorldveinResonance:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth then
                return A.WorldveinResonance:Show(icon)
            end
            
            -- guardian_of_azeroth
            if A.GuardianofAzeroth:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth then
                return A.GuardianofAzeroth:Show(icon)
            end
            
            -- memory_of_lucid_dreams
            if A.MemoryofLucidDreams:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth then
                return A.MemoryofLucidDreams:Show(icon)
            end
            
            -- use_item,effect_name=cyclotronic_blast,if=!raid_event.invulnerable.exists&(trinket.1.has_cooldown+trinket.2.has_cooldown<2|equipped.variable_intensity_gigavolt_oscillating_reactor)
            if A.CyclotronicBlast:IsReady(unit) and (not raid_event.invulnerable.exists and (trinket.1.has_cooldown + trinket.2.has_cooldown < 2 or A.VariableIntensityGigavoltOscillatingReactor:IsExists())) then
                return A.CyclotronicBlast:Show(icon)
            end
            
            -- focused_azerite_beam,if=!raid_event.invulnerable.exists
            if A.FocusedAzeriteBeam:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and (not raid_event.invulnerable.exists) then
                return A.FocusedAzeriteBeam:Show(icon)
            end
            
            -- aspect_of_the_wild,precast_time=1.3,if=!azerite.primal_instincts.enabled&!essence.essence_of_the_focusing_iris.major&(equipped.azsharas_font_of_power|!equipped.cyclotronic_blast)
            if A.AspectoftheWild:IsReady(unit) and Unit("player"):HasBuffsDown(A.AspectoftheWildBuff.ID, true) and (not A.PrimalInstincts:GetAzeriteRank() > 0 and not Azerite:EssenceHasMajor(A.EssenceoftheFocusingIris.ID) and (A.AzsharasFontofPower:IsExists() or not A.CyclotronicBlast:IsExists())) then
                return A.AspectoftheWild:Show(icon)
            end
            
            -- bestial_wrath,precast_time=1.5,if=azerite.primal_instincts.enabled&!essence.essence_of_the_focusing_iris.major&(equipped.azsharas_font_of_power|!equipped.cyclotronic_blast)
            if A.BestialWrath:IsReady(unit) and Unit("player"):HasBuffsDown(A.BestialWrathBuff.ID, true) and (A.PrimalInstincts:GetAzeriteRank() > 0 and not Azerite:EssenceHasMajor(A.EssenceoftheFocusingIris.ID) and (A.AzsharasFontofPower:IsExists() or not A.CyclotronicBlast:IsExists())) then
                return A.BestialWrath:Show(icon)
            end
            
            -- potion,dynamic_prepot=1
            if A.PotionofSpectralAgility:IsReady(unit) and Potion then
                return A.PotionofSpectralAgility:Show(icon)
            end
            
        end
        
        --Cds
        local function Cds(unit)
        
            -- ancestral_call,if=cooldown.bestial_wrath.remains>30
            if A.AncestralCall:AutoRacial(unit) and Racial and A.BurstIsON(unit) and (A.BestialWrath:GetCooldown() > 30) then
                return A.AncestralCall:Show(icon)
            end
            
            -- fireblood,if=cooldown.bestial_wrath.remains>30
            if A.Fireblood:AutoRacial(unit) and Racial and A.BurstIsON(unit) and (A.BestialWrath:GetCooldown() > 30) then
                return A.Fireblood:Show(icon)
            end
            
            -- berserking,if=buff.aspect_of_the_wild.up&(target.time_to_die>cooldown.berserking.duration+duration|(target.health.pct<35|!talent.killer_instinct.enabled))|target.time_to_die<13
            if A.Berserking:AutoRacial(unit) and Racial and A.BurstIsON(unit) and (Unit("player"):HasBuffs(A.AspectoftheWildBuff.ID, true) and (Unit(unit):TimeToDie() > A.Berserking:BaseDuration() + A.BerserkingBuff.ID, true:BaseDuration() or (Unit(unit):HealthPercent() < 35 or not A.KillerInstinct:IsSpellLearned())) or Unit(unit):TimeToDie() < 13) then
                return A.Berserking:Show(icon)
            end
            
            -- blood_fury,if=buff.aspect_of_the_wild.up&(target.time_to_die>cooldown.blood_fury.duration+duration|(target.health.pct<35|!talent.killer_instinct.enabled))|target.time_to_die<16
            if A.BloodFury:AutoRacial(unit) and Racial and A.BurstIsON(unit) and (Unit("player"):HasBuffs(A.AspectoftheWildBuff.ID, true) and (Unit(unit):TimeToDie() > A.BloodFury:BaseDuration() + A.BloodFuryBuff.ID, true:BaseDuration() or (Unit(unit):HealthPercent() < 35 or not A.KillerInstinct:IsSpellLearned())) or Unit(unit):TimeToDie() < 16) then
                return A.BloodFury:Show(icon)
            end
            
            -- lights_judgment,if=pet.main.buff.frenzy.up&pet.main.buff.frenzy.remains>gcd.max|!pet.main.buff.frenzy.up
            if A.LightsJudgment:IsReady(unit) and A.BurstIsON(unit) and (Pet:HasBuffs(A.FrenzyBuff.ID, true) and Pet:HasBuffs(A.FrenzyBuff.ID, true) > GetGCD() or not Pet:HasBuffs(A.FrenzyBuff.ID, true)) then
                return A.LightsJudgment:Show(icon)
            end
            
            -- potion,if=buff.bestial_wrath.up&buff.aspect_of_the_wild.up&target.health.pct<35|((consumable.potion_of_unbridled_fury|consumable.unbridled_fury)&target.time_to_die<61|target.time_to_die<26)
            if A.PotionofSpectralAgility:IsReady(unit) and Potion and (Unit("player"):HasBuffs(A.BestialWrathBuff.ID, true) and Unit("player"):HasBuffs(A.AspectoftheWildBuff.ID, true) and Unit(unit):HealthPercent() < 35 or ((Unit(unit):HasBuffs(A.PotionofUnbridledFuryBuff.ID, true) or Unit(unit):HasBuffs(A.UnbridledFuryBuff.ID, true)) and Unit(unit):TimeToDie() < 61 or Unit(unit):TimeToDie() < 26)) then
                return A.PotionofSpectralAgility:Show(icon)
            end
            
            -- worldvein_resonance,if=(prev_gcd.1.aspect_of_the_wild|cooldown.aspect_of_the_wild.remains<gcd|target.time_to_die<20)|!essence.vision_of_perfection.minor
            if A.WorldveinResonance:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and ((Player:PrevGCD(1, A.AspectoftheWild) or A.AspectoftheWild:GetCooldown() < GetGCD() or Unit(unit):TimeToDie() < 20) or not Azerite:EssenceHasMinor(A.VisionofPerfection.ID)) then
                return A.WorldveinResonance:Show(icon)
            end
            
            -- guardian_of_azeroth,if=cooldown.aspect_of_the_wild.remains<10|target.time_to_die>cooldown+duration|target.time_to_die<30
            if A.GuardianofAzeroth:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and (A.AspectoftheWild:GetCooldown() < 10 or Unit(unit):TimeToDie() > cooldown + duration or Unit(unit):TimeToDie() < 30) then
                return A.GuardianofAzeroth:Show(icon)
            end
            
            -- ripple_in_space
            if A.RippleInSpace:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth then
                return A.RippleInSpace:Show(icon)
            end
            
            -- memory_of_lucid_dreams
            if A.MemoryofLucidDreams:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth then
                return A.MemoryofLucidDreams:Show(icon)
            end
            
            -- reaping_flames,if=target.health.pct>80|target.health.pct<=20|target.time_to_pct_20>30
            if A.ReapingFlames:IsReady(unit) and (Unit(unit):HealthPercent() > 80 or Unit(unit):HealthPercent() <= 20 or target.time_to_pct_20 > 30) then
                return A.ReapingFlames:Show(icon)
            end
            
        end
        
        --Cleave
        local function Cleave(unit)
        
            -- barbed_shot,target_if=min:dot.barbed_shot.remains,if=pet.main.buff.frenzy.up&pet.main.buff.frenzy.remains<=gcd.max|cooldown.bestial_wrath.remains<12+gcd&talent.scent_of_blood.enabled
            if A.BarbedShot:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.BarbedShot, 40, "min", EvaluateTargetIfFilterBarbedShot133, EvaluateTargetIfBarbedShot148) then 
                    return A.BarbedShot:Show(icon) 
                end
            end
            -- multishot,if=gcd.max-pet.main.buff.beast_cleave.remains>0.25
            if A.Multishot:IsReady(unit) and (GetGCD() - Pet:HasBuffs(A.BeastCleaveBuff.ID, true) > 0.25) then
                return A.Multishot:Show(icon)
            end
            
            -- barbed_shot,target_if=min:dot.barbed_shot.remains,if=full_recharge_time<gcd.max&cooldown.bestial_wrath.remains
            if A.BarbedShot:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.BarbedShot, 40, "min", EvaluateTargetIfFilterBarbedShot158, EvaluateTargetIfBarbedShot171) then 
                    return A.BarbedShot:Show(icon) 
                end
            end
            -- aspect_of_the_wild
            if A.AspectoftheWild:IsReady(unit) then
                return A.AspectoftheWild:Show(icon)
            end
            
            -- stampede,if=buff.aspect_of_the_wild.up&buff.bestial_wrath.up|target.time_to_die<15
            if A.Stampede:IsReady(unit) and (Unit("player"):HasBuffs(A.AspectoftheWildBuff.ID, true) and Unit("player"):HasBuffs(A.BestialWrathBuff.ID, true) or Unit(unit):TimeToDie() < 15) then
                return A.Stampede:Show(icon)
            end
            
            -- bestial_wrath,if=talent.scent_of_blood.enabled|cooldown.aspect_of_the_wild.remains_guess>20|talent.one_with_the_pack.enabled|target.time_to_die<15
            if A.BestialWrath:IsReady(unit) and (A.ScentofBlood:IsSpellLearned() or cooldown.aspect_of_the_wild.remains_guess > 20 or A.OneWiththePack:IsSpellLearned() or Unit(unit):TimeToDie() < 15) then
                return A.BestialWrath:Show(icon)
            end
            
            -- chimaera_shot
            if A.ChimaeraShot:IsReady(unit) then
                return A.ChimaeraShot:Show(icon)
            end
            
            -- a_murder_of_crows
            if A.AMurderofCrows:IsReady(unit) then
                return A.AMurderofCrows:Show(icon)
            end
            
            -- barrage
            if A.Barrage:IsReady(unit) then
                return A.Barrage:Show(icon)
            end
            
            -- kill_command,if=active_enemies<4|!azerite.rapid_reload.enabled
            if A.KillCommand:IsReady(unit) and (MultiUnits:GetByRangeInCombat(40, 5, 10) < 4 or not A.RapidReload:GetAzeriteRank() > 0) then
                return A.KillCommand:Show(icon)
            end
            
            -- dire_beast
            if A.DireBeast:IsReady(unit) then
                return A.DireBeast:Show(icon)
            end
            
            -- barbed_shot,target_if=min:dot.barbed_shot.remains,if=pet.main.buff.frenzy.down&(charges_fractional>1.8|buff.bestial_wrath.up)|cooldown.aspect_of_the_wild.remains<pet.main.buff.frenzy.duration-gcd&azerite.primal_instincts.enabled|charges_fractional>1.4|target.time_to_die<9
            if A.BarbedShot:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.BarbedShot, 40, "min", EvaluateTargetIfFilterBarbedShot211, EvaluateTargetIfBarbedShot236) then 
                    return A.BarbedShot:Show(icon) 
                end
            end
            -- focused_azerite_beam
            if A.FocusedAzeriteBeam:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth then
                return A.FocusedAzeriteBeam:Show(icon)
            end
            
            -- purifying_blast
            if A.PurifyingBlast:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth then
                return A.PurifyingBlast:Show(icon)
            end
            
            -- concentrated_flame
            if A.ConcentratedFlame:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth then
                return A.ConcentratedFlame:Show(icon)
            end
            
            -- blood_of_the_enemy
            if A.BloodoftheEnemy:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth then
                return A.BloodoftheEnemy:Show(icon)
            end
            
            -- the_unbound_force,if=buff.reckless_force.up|buff.reckless_force_counter.stack<10
            if A.TheUnboundForce:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and (Unit("player"):HasBuffs(A.RecklessForceBuff.ID, true) or Unit("player"):HasBuffsStacks(A.RecklessForceCounterBuff.ID, true) < 10) then
                return A.TheUnboundForce:Show(icon)
            end
            
            -- multishot,if=azerite.rapid_reload.enabled&active_enemies>2
            if A.Multishot:IsReady(unit) and (A.RapidReload:GetAzeriteRank() > 0 and MultiUnits:GetByRangeInCombat(40, 5, 10) > 2) then
                return A.Multishot:Show(icon)
            end
            
            -- cobra_shot,if=cooldown.kill_command.remains>focus.time_to_max&(active_enemies<3|!azerite.rapid_reload.enabled)
            if A.CobraShot:IsReady(unit) and (A.KillCommand:GetCooldown() > Player:FocusTimeToMaxPredicted() and (MultiUnits:GetByRangeInCombat(40, 5, 10) < 3 or not A.RapidReload:GetAzeriteRank() > 0)) then
                return A.CobraShot:Show(icon)
            end
            
        end
        
        --St
        local function St(unit)
        
            -- kill_shot
            if A.KillShot:IsReady(unit) then
                return A.KillShot:Show(icon)
            end
            
            -- bloodshed
            if A.Bloodshed:IsReady(unit) then
                return A.Bloodshed:Show(icon)
            end
            
            -- barbed_shot,if=pet.main.buff.frenzy.up&pet.main.buff.frenzy.remains<gcd|cooldown.bestial_wrath.remains&(full_recharge_time<gcd|azerite.primal_instincts.enabled&cooldown.aspect_of_the_wild.remains<gcd)|cooldown.bestial_wrath.remains<12+gcd&talent.scent_of_blood.enabled
            if A.BarbedShot:IsReady(unit) and (Pet:HasBuffs(A.FrenzyBuff.ID, true) and Pet:HasBuffs(A.FrenzyBuff.ID, true) < GetGCD() or A.BestialWrath:GetCooldown() and (A.BarbedShot:GetSpellChargesFullRechargeTime() < GetGCD() or A.PrimalInstincts:GetAzeriteRank() > 0 and A.AspectoftheWild:GetCooldown() < GetGCD()) or A.BestialWrath:GetCooldown() < 12 + GetGCD() and A.ScentofBlood:IsSpellLearned()) then
                return A.BarbedShot:Show(icon)
            end
            
            -- concentrated_flame,if=focus+focus.regen*gcd<focus.max&buff.bestial_wrath.down&(!dot.concentrated_flame_burn.remains&!action.concentrated_flame.in_flight)|full_recharge_time<gcd|target.time_to_die<5
            if A.ConcentratedFlame:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and (Player:Focus() + Player:FocusRegen() * GetGCD() < Player:FocusMax() and Unit("player"):HasBuffsDown(A.BestialWrathBuff.ID, true) and (not Unit(unit):HasDeBuffs(A.ConcentratedFlameBurnDebuff.ID, true) and not A.ConcentratedFlame:IsSpellInFlight()) or A.ConcentratedFlame:GetSpellChargesFullRechargeTime() < GetGCD() or Unit(unit):TimeToDie() < 5) then
                return A.ConcentratedFlame:Show(icon)
            end
            
            -- aspect_of_the_wild,if=buff.aspect_of_the_wild.down&(cooldown.barbed_shot.charges<1|!azerite.primal_instincts.enabled)
            if A.AspectoftheWild:IsReady(unit) and (Unit("player"):HasBuffsDown(A.AspectoftheWildBuff.ID, true) and (A.BarbedShot:GetSpellCharges() < 1 or not A.PrimalInstincts:GetAzeriteRank() > 0)) then
                return A.AspectoftheWild:Show(icon)
            end
            
            -- stampede,if=buff.aspect_of_the_wild.up&buff.bestial_wrath.up|target.time_to_die<15
            if A.Stampede:IsReady(unit) and (Unit("player"):HasBuffs(A.AspectoftheWildBuff.ID, true) and Unit("player"):HasBuffs(A.BestialWrathBuff.ID, true) or Unit(unit):TimeToDie() < 15) then
                return A.Stampede:Show(icon)
            end
            
            -- a_murder_of_crows
            if A.AMurderofCrows:IsReady(unit) then
                return A.AMurderofCrows:Show(icon)
            end
            
            -- focused_azerite_beam,if=buff.bestial_wrath.down|target.time_to_die<5
            if A.FocusedAzeriteBeam:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and (Unit("player"):HasBuffsDown(A.BestialWrathBuff.ID, true) or Unit(unit):TimeToDie() < 5) then
                return A.FocusedAzeriteBeam:Show(icon)
            end
            
            -- the_unbound_force,if=buff.reckless_force.up|buff.reckless_force_counter.stack<10|target.time_to_die<5
            if A.TheUnboundForce:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and (Unit("player"):HasBuffs(A.RecklessForceBuff.ID, true) or Unit("player"):HasBuffsStacks(A.RecklessForceCounterBuff.ID, true) < 10 or Unit(unit):TimeToDie() < 5) then
                return A.TheUnboundForce:Show(icon)
            end
            
            -- bestial_wrath,if=talent.scent_of_blood.enabled|talent.one_with_the_pack.enabled&buff.bestial_wrath.remains<gcd|buff.bestial_wrath.down&cooldown.aspect_of_the_wild.remains>15|target.time_to_die<15+gcd
            if A.BestialWrath:IsReady(unit) and (A.ScentofBlood:IsSpellLearned() or A.OneWiththePack:IsSpellLearned() and Unit("player"):HasBuffs(A.BestialWrathBuff.ID, true) < GetGCD() or Unit("player"):HasBuffsDown(A.BestialWrathBuff.ID, true) and A.AspectoftheWild:GetCooldown() > 15 or Unit(unit):TimeToDie() < 15 + GetGCD()) then
                return A.BestialWrath:Show(icon)
            end
            
            -- barbed_shot,if=azerite.dance_of_death.rank>1&buff.dance_of_death.remains<gcd
            if A.BarbedShot:IsReady(unit) and (A.DanceofDeath:GetAzeriteRank() > 1 and Unit("player"):HasBuffs(A.DanceofDeathBuff.ID, true) < GetGCD()) then
                return A.BarbedShot:Show(icon)
            end
            
            -- blood_of_the_enemy,if=buff.aspect_of_the_wild.remains>10+gcd|target.time_to_die<10+gcd
            if A.BloodoftheEnemy:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and (Unit("player"):HasBuffs(A.AspectoftheWildBuff.ID, true) > 10 + GetGCD() or Unit(unit):TimeToDie() < 10 + GetGCD()) then
                return A.BloodoftheEnemy:Show(icon)
            end
            
            -- kill_command
            if A.KillCommand:IsReady(unit) then
                return A.KillCommand:Show(icon)
            end
            
            -- bag_of_tricks,if=buff.bestial_wrath.down|target.time_to_die<5
            if A.BagofTricks:IsReady(unit) and (Unit("player"):HasBuffsDown(A.BestialWrathBuff.ID, true) or Unit(unit):TimeToDie() < 5) then
                return A.BagofTricks:Show(icon)
            end
            
            -- chimaera_shot
            if A.ChimaeraShot:IsReady(unit) then
                return A.ChimaeraShot:Show(icon)
            end
            
            -- dire_beast
            if A.DireBeast:IsReady(unit) then
                return A.DireBeast:Show(icon)
            end
            
            -- barbed_shot,if=talent.one_with_the_pack.enabled&charges_fractional>1.5|charges_fractional>1.8|cooldown.aspect_of_the_wild.remains<pet.main.buff.frenzy.duration-gcd&azerite.primal_instincts.enabled|target.time_to_die<9
            if A.BarbedShot:IsReady(unit) and (A.OneWiththePack:IsSpellLearned() and A.BarbedShot:GetSpellChargesFrac() > 1.5 or A.BarbedShot:GetSpellChargesFrac() > 1.8 or A.AspectoftheWild:GetCooldown() < A.FrenzyBuff.ID, true:BaseDuration() - GetGCD() and A.PrimalInstincts:GetAzeriteRank() > 0 or Unit(unit):TimeToDie() < 9) then
                return A.BarbedShot:Show(icon)
            end
            
            -- purifying_blast,if=buff.bestial_wrath.down|target.time_to_die<8
            if A.PurifyingBlast:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and (Unit("player"):HasBuffsDown(A.BestialWrathBuff.ID, true) or Unit(unit):TimeToDie() < 8) then
                return A.PurifyingBlast:Show(icon)
            end
            
            -- barrage
            if A.Barrage:IsReady(unit) then
                return A.Barrage:Show(icon)
            end
            
            -- cobra_shot,if=(focus-cost+focus.regen*(cooldown.kill_command.remains-1)>action.kill_command.cost|cooldown.kill_command.remains>1+gcd&cooldown.bestial_wrath.remains_guess>focus.time_to_max|buff.memory_of_lucid_dreams.up)&cooldown.kill_command.remains>1|target.time_to_die<3
            if A.CobraShot:IsReady(unit) and ((Player:Focus() - A.CobraShot:GetSpellPowerCostCache() + Player:FocusRegen() * (A.KillCommand:GetCooldown() - 1) > A.KillCommand:GetSpellPowerCostCache() or A.KillCommand:GetCooldown() > 1 + GetGCD() and cooldown.bestial_wrath.remains_guess > Player:FocusTimeToMaxPredicted() or Unit("player"):HasBuffs(A.MemoryofLucidDreamsBuff.ID, true)) and A.KillCommand:GetCooldown() > 1 or Unit(unit):TimeToDie() < 3) then
                return A.CobraShot:Show(icon)
            end
            
            -- barbed_shot,if=pet.main.buff.frenzy.duration-gcd>full_recharge_time
            if A.BarbedShot:IsReady(unit) and (A.FrenzyBuff.ID, true:BaseDuration() - GetGCD() > A.BarbedShot:GetSpellChargesFullRechargeTime()) then
                return A.BarbedShot:Show(icon)
            end
            
        end
        
        
        -- call precombat
        if Precombat(unit) and not inCombat and Unit(unit):IsExists() and unit ~= "mouseover" then 
            return true
        end

        -- In Combat
        if inCombat and Unit(unit):IsExists() then

                    -- auto_shot
            -- use_items,if=prev_gcd.1.aspect_of_the_wild|target.time_to_die<20
            -- use_item,name=azsharas_font_of_power,if=cooldown.aspect_of_the_wild.remains_guess<15&target.time_to_die>10
            if A.AzsharasFontofPower:IsReady(unit) and (cooldown.aspect_of_the_wild.remains_guess < 15 and Unit(unit):TimeToDie() > 10) then
                return A.AzsharasFontofPower:Show(icon)
            end
            
            -- use_item,name=ashvanes_razor_coral,if=debuff.razor_coral_debuff.up&(!equipped.azsharas_font_of_power|trinket.azsharas_font_of_power.cooldown.remains>86|essence.blood_of_the_enemy.major)&(prev_gcd.1.aspect_of_the_wild|!equipped.cyclotronic_blast&buff.aspect_of_the_wild.remains>9)&(!essence.condensed_lifeforce.major|buff.guardian_of_azeroth.up)&(target.health.pct<35|!essence.condensed_lifeforce.major|!talent.killer_instinct.enabled)|(debuff.razor_coral_debuff.down|target.time_to_die<26)&target.time_to_die>(24*(cooldown.cyclotronic_blast.remains+4<target.time_to_die))
            if A.AshvanesRazorCoral:IsReady(unit) and (Unit(unit):HasDeBuffs(A.RazorCoralDebuff.ID, true) and (not A.AzsharasFontofPower:IsExists() or trinket.azsharas_font_of_power.cooldown.remains > 86 or Azerite:EssenceHasMajor(A.BloodoftheEnemy.ID)) and (Player:PrevGCD(1, A.AspectoftheWild) or not A.CyclotronicBlast:IsExists() and Unit("player"):HasBuffs(A.AspectoftheWildBuff.ID, true) > 9) and (not Azerite:EssenceHasMajor(A.CondensedLifeforce.ID) or Unit("player"):HasBuffs(A.GuardianofAzerothBuff.ID, true)) and (Unit(unit):HealthPercent() < 35 or not Azerite:EssenceHasMajor(A.CondensedLifeforce.ID) or not A.KillerInstinct:IsSpellLearned()) or (Unit(unit):HasDeBuffsDown(A.RazorCoralDebuff.ID, true) or Unit(unit):TimeToDie() < 26) and Unit(unit):TimeToDie() > (24 * num((A.CyclotronicBlast:GetCooldown() + 4 < Unit(unit):TimeToDie())))) then
                return A.AshvanesRazorCoral:Show(icon)
            end
            
            -- use_item,effect_name=cyclotronic_blast,if=buff.bestial_wrath.down|target.time_to_die<5
            if A.CyclotronicBlast:IsReady(unit) and (Unit("player"):HasBuffsDown(A.BestialWrathBuff.ID, true) or Unit(unit):TimeToDie() < 5) then
                return A.CyclotronicBlast:Show(icon)
            end
            
            -- call_action_list,name=cds
            if Cds(unit) then
                return true
            end
            
            -- call_action_list,name=st,if=active_enemies<2
            if (MultiUnits:GetByRangeInCombat(40, 5, 10) < 2) then
                if St(unit) then
                    return true
                end
            end
            
            -- call_action_list,name=cleave,if=active_enemies>1
            if (MultiUnits:GetByRangeInCombat(40, 5, 10) > 1) then
                if Cleave(unit) then
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

