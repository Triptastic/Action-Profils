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

Action[ACTION_CONST_ROGUE_SUBTLETY] = {
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
    ApplyPoison                            = Create({ Type = "Spell", ID =  }),
    StealthBuff                            = Create({ Type = "Spell", ID = 1784 }),
    MarkedForDeath                         = Create({ Type = "Spell", ID = 137619 }),
    SliceandDice                           = Create({ Type = "Spell", ID =  }),
    ShadowBladesBuff                       = Create({ Type = "Spell", ID = 121471 }),
    ShadowBlades                           = Create({ Type = "Spell", ID = 121471 }),
    Shiv                                   = Create({ Type = "Spell", ID =  }),
    Nightstalker                           = Create({ Type = "Spell", ID = 14062 }),
    ShurikenStorm                          = Create({ Type = "Spell", ID = 197835 }),
    Gloomblade                             = Create({ Type = "Spell", ID = 200758 }),
    Perforate                              = Create({ Type = "Spell", ID =  }),
    SerratedBoneSpike                      = Create({ Type = "Spell", ID =  }),
    Backstab                               = Create({ Type = "Spell", ID = 53 }),
    ShadowDance                            = Create({ Type = "Spell", ID = 185313 }),
    ShadowDanceBuff                        = Create({ Type = "Spell", ID = 185313 }),
    ShurikenTornadoBuff                    = Create({ Type = "Spell", ID =  }),
    SymbolsofDeath                         = Create({ Type = "Spell", ID = 212283 }),
    Flagellation                           = Create({ Type = "Spell", ID =  }),
    FlagellationCleanse                    = Create({ Type = "Spell", ID =  }),
    FlagellationDebuff                     = Create({ Type = "Spell", ID =  }),
    Vanish                                 = Create({ Type = "Spell", ID = 1856 }),
    SymbolsofDeathBuff                     = Create({ Type = "Spell", ID = 212283 }),
    DeathlyShadowsBuff                     = Create({ Type = "Spell", ID =  }),
    BreathoftheDying                       = Create({ Type = "Spell", ID =  }),
    ShurikenTornado                        = Create({ Type = "Spell", ID =  }),
    PoolResource                           = Create({ Type = "Spell", ID = 9999000010 }),
    SerratedBoneSpikeDotDebuff             = Create({ Type = "Spell", ID =  }),
    EnvelopingShadows                      = Create({ Type = "Spell", ID = 238104 }),
    ShadowFocus                            = Create({ Type = "Spell", ID = 108209 }),
    EchoingReprimand                       = Create({ Type = "Spell", ID =  }),
    Subterfuge                             = Create({ Type = "Spell", ID = 108208 }),
    BloodFury                              = Create({ Type = "Spell", ID = 20572 }),
    Berserking                             = Create({ Type = "Spell", ID = 26297 }),
    Fireblood                              = Create({ Type = "Spell", ID = 265221 }),
    AncestralCall                          = Create({ Type = "Spell", ID = 274738 }),
    CyclingVariable                        = Create({ Type = "Spell", ID =  }),
    ReapingFlames                          = Create({ Type = "Spell", ID =  }),
    SliceandDiceBuff                       = Create({ Type = "Spell", ID =  }),
    DarkShadow                             = Create({ Type = "Spell", ID = 245687 }),
    Rupture                                = Create({ Type = "Spell", ID =  }),
    SecretTechnique                        = Create({ Type = "Spell", ID =  }),
    Eviscerate                             = Create({ Type = "Spell", ID = 196819 }),
    Sepsis                                 = Create({ Type = "Spell", ID =  }),
    Shadowmeld                             = Create({ Type = "Spell", ID = 58984 }),
    FindWeaknessDebuff                     = Create({ Type = "Spell", ID =  }),
    Shadowstrike                           = Create({ Type = "Spell", ID = 185438 }),
    VanishBuff                             = Create({ Type = "Spell", ID = 1856 }),
    DeeperStratagem                        = Create({ Type = "Spell", ID = 193531 }),
    BladeIntheShadows                      = Create({ Type = "Spell", ID =  }),
    Weaponmaster                           = Create({ Type = "Spell", ID =  }),
    Inevitability                          = Create({ Type = "Spell", ID =  }),
    PremeditationBuff                      = Create({ Type = "Spell", ID =  }),
    TheRottenBuff                          = Create({ Type = "Spell", ID =  }),
    PerforatedVeinsBuff                    = Create({ Type = "Spell", ID =  }),
    Vigor                                  = Create({ Type = "Spell", ID = 14983 }),
    MasterofShadows                        = Create({ Type = "Spell", ID =  }),
    Alacrity                               = Create({ Type = "Spell", ID =  }),
    SepsisDebuff                           = Create({ Type = "Spell", ID =  }),
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

-- To create essences use next code:
Action:CreateEssencesFor(ACTION_CONST_ROGUE_SUBTLETY)  -- where PLAYERSPEC is Constance (example: ACTION_CONST_MONK_BM)
local A = setmetatable(Action[ACTION_CONST_ROGUE_SUBTLETY], { __index = Action })


------------------------------------------
---------------- VARIABLES ---------------
------------------------------------------
local VarSndCondition = 0;
local VarReapingDelay = 0;
local VarSkipRupture = 0;
local VarUsePriorityRotation = 0;
local VarShdThreshold = 0;
local VarShdComboPoints = 0;
local VarStealthThreshold = 0;

A.Listener:Add("ROTATION_VARS", "PLAYER_REGEN_ENABLED", function()
  VarSndCondition = 0
  VarReapingDelay = 0
  VarSkipRupture = 0
  VarUsePriorityRotation = 0
  VarShdThreshold = 0
  VarShdComboPoints = 0
  VarStealthThreshold = 0
end)



local function num(val)
    if val then return 1 else return 0 end
end

local function bool(val)
    return val ~= 0
end

------------------------------------------
--------- SUBTELY PRE APL SETUP ----------
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
	return A.Backstab:IsInRange(unit)
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

local function UsePriorityRotation()
    local UsePriorityRotation = A.GetToggle(2, "UsePriorityRotation")
	
    if GetByRange(2, 5, false, true) then
        return false
    end
	
    if UsePriorityRotation == "Always" then
        return true
    end
	
    if UsePriorityRotation == "On Bosses" and Unit("target"):IsBoss() then
        return true
    end
	
    -- Zul Mythic 8.1 Obsolete
   -- if Player:InstanceDifficulty() == 16 and Target:NPCID() == 138967 then
   --     return true
    --end
	
    return false
end

-- cp_max_spend
local function CPMaxSpend()
    -- Should work for all 3 specs since they have same Deeper Stratagem Spell ID.
    return A.DeeperStratagem:IsSpellLearned() and 6 or 5;
end

-- "cp_spend"
local function CPSpend()
    return mathmin(Player:ComboPoints(), CPMaxSpend());
end

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
    
        if useCC and Player:IsStealthed() and A.CheapShot:IsReady(unit) and A.CheapShot:AbsentImun(unit, Temp.TotalAndCC, true) and Unit(unit):IsControlAble("stun") and Unit(unit):HasDeBuffs("Stuned") < A.GetGCD() + 0.1 then 
            -- Notification                    
            Action.SendNotification("CheapShot on : " .. UnitName(unit), A.CheapShot.ID)
            return A.CheapShot              
        end

        if useCC and A.KidneyShot:IsReady(unit) and A.KidneyShot:AbsentImun(unit, Temp.TotalAndCC, true) and Unit(unit):IsControlAble("stun") and Unit(unit):HasDeBuffs("Stuned") < A.GetGCD() + 0.1 then 
            -- Notification                    
            Action.SendNotification("KidneyShot on : " .. UnitName(unit), A.KidneyShot.ID)
            return A.KidneyShot              
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

local function EvaluateCycleSerratedBoneSpike96(unit)
  return VarSndCondition and not Unit(unit):HasDeBuffs(A.SerratedBoneSpikeDotDebuff.ID, true) or fight_remains <= 5
end

local function EvaluateTargetIfFilterMarkedForDeath126(unit)
  return Unit(unit):TimeToDie()
end

local function EvaluateTargetIfMarkedForDeath131(unit)
  return (MultiUnits:GetByRangeInCombat(40, 5, 10) > 1) and (Unit(unit):TimeToDie() < Player:ComboPointsDeficit() or not Unit("player"):IsStealthed(true, true) and Player:ComboPointsDeficit() >= CPMaxSpend())
end


local function EvaluateCycleReapingFlames265(unit)
    return Unit(unit):TimeToDie() < 1.5 or ((Unit(unit):HealthPercent() > 80 or Unit(unit):HealthPercent() <= 20) and (MultiUnits:GetByRangeInCombat(40, 5, 10) == 1 or VarReapingDelay > 29)) or (target.time_to_pct_20 > 30 and (MultiUnits:GetByRangeInCombat(40, 5, 10) == 1 or VarReapingDelay > 44))
end

local function EvaluateCycleRupture318(unit)
  return not VarSkipRupture and not VarUsePriorityRotation and MultiUnits:GetByRangeInCombat(10, 5, 10) >= 2 and Unit(unit):TimeToDie() >= (5 + (2 * Player:ComboPoints())) and refreshable
end

local function EvaluateCycleShadowstrike427(unit)
  return Unit(unit):HasDeBuffs(A.FindWeaknessDebuff.ID, true) < 1 and MultiUnits:GetByRangeInCombat(10, 5, 10) <= 3 and Unit(unit):TimeToDie() - remains > 6
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
        
            -- apply_poison
            if A.ApplyPoison:IsReady(unit) then
                return A.ApplyPoison:Show(icon)
            end
            
            -- flask
            -- augmentation
            -- food
            -- snapshot_stats
            -- stealth
            if A.Stealth:IsReady(unit) and Unit("player"):HasBuffsDown(A.StealthBuff.ID, true) then
                return A.Stealth:Show(icon)
            end
            
            -- marked_for_death,precombat_seconds=15
            if A.MarkedForDeath:IsReady(unit) then
                return A.MarkedForDeath:Show(icon)
            end
            
            -- slice_and_dice,precombat_seconds=1
            if A.SliceandDice:IsReady(unit) then
                return A.SliceandDice:Show(icon)
            end
            
            -- shadow_blades,if=runeforge.mark_of_the_master_assassin.equipped
            if A.ShadowBlades:IsReady(unit) and Unit("player"):HasBuffsDown(A.ShadowBladesBuff.ID, true) and (runeforge.mark_of_the_master_assassin.equipped) then
                return A.ShadowBlades:Show(icon)
            end
            
            -- use_item,name=azsharas_font_of_power
            if A.AzsharasFontofPower:IsReady(unit) then
                return A.AzsharasFontofPower:Show(icon)
            end
            
        end
        
        --Build
        local function Build(unit)
        
            -- shiv,if=!talent.nightstalker.enabled&runeforge.tiny_toxic_blade.equipped
            if A.Shiv:IsReady(unit) and (not A.Nightstalker:IsSpellLearned() and runeforge.tiny_toxic_blade.equipped) then
                return A.Shiv:Show(icon)
            end
            
            -- shuriken_storm,if=spell_targets>=2+(talent.gloomblade.enabled&azerite.perforate.rank>=2&position_back)
            if A.ShurikenStorm:IsReady(unit) and (MultiUnits:GetByRangeInCombat(10, 5, 10) >= 2 + num((A.Gloomblade:IsSpellLearned() and A.Perforate:GetAzeriteRank() >= 2 and position_back))) then
                return A.ShurikenStorm:Show(icon)
            end
            
            -- serrated_bone_spike,if=cooldown.serrated_bone_spike.charges_fractional>=2.75
            if A.SerratedBoneSpike:IsReady(unit) and (A.SerratedBoneSpike:GetSpellChargesFrac() >= 2.75) then
                return A.SerratedBoneSpike:Show(icon)
            end
            
            -- gloomblade
            if A.Gloomblade:IsReady(unit) then
                return A.Gloomblade:Show(icon)
            end
            
            -- backstab
            if A.Backstab:IsReady(unit) then
                return A.Backstab:Show(icon)
            end
            
        end
        
        --Cds
        local function Cds(unit)
        
            -- shadow_dance,use_off_gcd=1,if=!buff.shadow_dance.up&buff.shuriken_tornado.up&buff.shuriken_tornado.remains<=3.5
            if A.ShadowDance:IsReady(unit) and (not Unit("player"):HasBuffs(A.ShadowDanceBuff.ID, true) and Unit("player"):HasBuffs(A.ShurikenTornadoBuff.ID, true) and Unit("player"):HasBuffs(A.ShurikenTornadoBuff.ID, true) <= 3.5) then
                return A.ShadowDance:Show(icon)
            end
            
            -- symbols_of_death,use_off_gcd=1,if=buff.shuriken_tornado.up&buff.shuriken_tornado.remains<=3.5
            if A.SymbolsofDeath:IsReady(unit) and (Unit("player"):HasBuffs(A.ShurikenTornadoBuff.ID, true) and Unit("player"):HasBuffs(A.ShurikenTornadoBuff.ID, true) <= 3.5) then
                return A.SymbolsofDeath:Show(icon)
            end
            
            -- flagellation,if=variable.snd_condition&!stealthed.mantle
            if A.Flagellation:IsReady(unit) and (VarSndCondition and not stealthed.mantle) then
                return A.Flagellation:Show(icon)
            end
            
            -- flagellation_cleanse,if=debuff.flagellation.remains<2|debuff.flagellation.stack>=40
            if A.FlagellationCleanse:IsReady(unit) and (Unit(unit):HasDeBuffs(A.FlagellationDebuff.ID, true) < 2 or Unit(unit):HasDeBuffsStacks(A.FlagellationDebuff.ID, true) >= 40) then
                return A.FlagellationCleanse:Show(icon)
            end
            
            -- vanish,if=(runeforge.mark_of_the_master_assassin.equipped&combo_points.deficit<=3|runeforge.deathly_shadows.equipped&combo_points<1)&buff.symbols_of_death.up&buff.shadow_dance.up&master_assassin_remains=0&buff.deathly_shadows.down
            if A.Vanish:IsReady(unit) and ((runeforge.mark_of_the_master_assassin.equipped and Player:ComboPointsDeficit() <= 3 or runeforge.deathly_shadows.equipped and Player:ComboPoints() < 1) and Unit("player"):HasBuffs(A.SymbolsofDeathBuff.ID, true) and Unit("player"):HasBuffs(A.ShadowDanceBuff.ID, true) and MasterAssassinRemains == 0 and Unit("player"):HasBuffsDown(A.DeathlyShadowsBuff.ID, true)) then
                return A.Vanish:Show(icon)
            end
            
            -- call_action_list,name=essences,if=!stealthed.all&variable.snd_condition|essence.breath_of_the_dying.major&time>=2
            if (not Unit("player"):IsStealthed(true, true) and VarSndCondition or Azerite:EssenceHasMajor(A.BreathoftheDying.ID) and Unit("player"):CombatTime() >= 2) then
                if Essences(unit) then
                    return true
                end
            end
            
            -- pool_resource,for_next=1,if=!talent.shadow_focus.enabled
            -- shuriken_tornado,if=energy>=60&variable.snd_condition&cooldown.symbols_of_death.up&cooldown.shadow_dance.charges>=1
            if A.ShurikenTornado:IsReady(unit) and (Player:EnergyPredicted() >= 60 and VarSndCondition and A.SymbolsofDeath:GetCooldown() == 0 and A.ShadowDance:GetSpellCharges() >= 1) then
                if A.ShurikenTornado:IsUsablePPool() then
                    return A.ShurikenTornado:Show(icon)
                else
                    return A.PoolResource:Show(icon)
                end
            end
            
            -- serrated_bone_spike,cycle_targets=1,if=variable.snd_condition&!dot.serrated_bone_spike_dot.ticking|fight_remains<=5
            if A.SerratedBoneSpike:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.SerratedBoneSpike, 40, "min", EvaluateCycleSerratedBoneSpike96) then
                    return A.SerratedBoneSpike:Show(icon) 
                end
            end
            -- symbols_of_death,if=variable.snd_condition&!cooldown.shadow_blades.up&(talent.enveloping_shadows.enabled|cooldown.shadow_dance.charges>=1)&(!talent.shuriken_tornado.enabled|talent.shadow_focus.enabled|cooldown.shuriken_tornado.remains>2)&(!essence.blood_of_the_enemy.major|cooldown.blood_of_the_enemy.remains>2)
            if A.SymbolsofDeath:IsReady(unit) and (VarSndCondition and not A.ShadowBlades:GetCooldown() == 0 and (A.EnvelopingShadows:IsSpellLearned() or A.ShadowDance:GetSpellCharges() >= 1) and (not A.ShurikenTornado:IsSpellLearned() or A.ShadowFocus:IsSpellLearned() or A.ShurikenTornado:GetCooldown() > 2) and (not Azerite:EssenceHasMajor(A.BloodoftheEnemy.ID) or A.BloodoftheEnemy:GetCooldown() > 2)) then
                return A.SymbolsofDeath:Show(icon)
            end
            
            -- marked_for_death,target_if=min:target.time_to_die,if=raid_event.adds.up&(target.time_to_die<combo_points.deficit|!stealthed.all&combo_points.deficit>=cp_max_spend)
            if A.MarkedForDeath:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.MarkedForDeath, 40, "min", EvaluateTargetIfFilterMarkedForDeath126, EvaluateTargetIfMarkedForDeath131) then 
                    return A.MarkedForDeath:Show(icon) 
                end
            end
            -- marked_for_death,if=raid_event.adds.in>30-raid_event.adds.duration&combo_points.deficit>=cp_max_spend
            if A.MarkedForDeath:IsReady(unit) and (IncomingAddsIn > 30 - raid_event.adds.duration and Player:ComboPointsDeficit() >= CPMaxSpend()) then
                return A.MarkedForDeath:Show(icon)
            end
            
            -- shadow_blades,if=variable.snd_condition&combo_points.deficit>=2
            if A.ShadowBlades:IsReady(unit) and (VarSndCondition and Player:ComboPointsDeficit() >= 2) then
                return A.ShadowBlades:Show(icon)
            end
            
            -- echoing_reprimand,if=variable.snd_condition&combo_points.deficit>=3&spell_targets.shuriken_storm<=4
            if A.EchoingReprimand:IsReady(unit) and (VarSndCondition and Player:ComboPointsDeficit() >= 3 and MultiUnits:GetByRangeInCombat(10, 5, 10) <= 4) then
                return A.EchoingReprimand:Show(icon)
            end
            
            -- shuriken_tornado,if=talent.shadow_focus.enabled&variable.snd_condition&buff.symbols_of_death.up
            if A.ShurikenTornado:IsReady(unit) and (A.ShadowFocus:IsSpellLearned() and VarSndCondition and Unit("player"):HasBuffs(A.SymbolsofDeathBuff.ID, true)) then
                return A.ShurikenTornado:Show(icon)
            end
            
            -- shadow_dance,if=!buff.shadow_dance.up&fight_remains<=8+talent.subterfuge.enabled
            if A.ShadowDance:IsReady(unit) and (not Unit("player"):HasBuffs(A.ShadowDanceBuff.ID, true) and fight_remains <= 8 + num(A.Subterfuge:IsSpellLearned())) then
                return A.ShadowDance:Show(icon)
            end
            
            -- potion,if=buff.bloodlust.react|buff.symbols_of_death.up&(buff.shadow_blades.up|cooldown.shadow_blades.remains<=10)
            if A.PotionofSpectralAgility:IsReady(unit) and Potion and (Unit("player"):HasHeroism() or Unit("player"):HasBuffs(A.SymbolsofDeathBuff.ID, true) and (Unit("player"):HasBuffs(A.ShadowBladesBuff.ID, true) or A.ShadowBlades:GetCooldown() <= 10)) then
                return A.PotionofSpectralAgility:Show(icon)
            end
            
            -- blood_fury,if=buff.symbols_of_death.up
            if A.BloodFury:AutoRacial(unit) and Racial and A.BurstIsON(unit) and (Unit("player"):HasBuffs(A.SymbolsofDeathBuff.ID, true)) then
                return A.BloodFury:Show(icon)
            end
            
            -- berserking,if=buff.symbols_of_death.up
            if A.Berserking:AutoRacial(unit) and Racial and A.BurstIsON(unit) and (Unit("player"):HasBuffs(A.SymbolsofDeathBuff.ID, true)) then
                return A.Berserking:Show(icon)
            end
            
            -- fireblood,if=buff.symbols_of_death.up
            if A.Fireblood:AutoRacial(unit) and Racial and A.BurstIsON(unit) and (Unit("player"):HasBuffs(A.SymbolsofDeathBuff.ID, true)) then
                return A.Fireblood:Show(icon)
            end
            
            -- ancestral_call,if=buff.symbols_of_death.up
            if A.AncestralCall:AutoRacial(unit) and Racial and A.BurstIsON(unit) and (Unit("player"):HasBuffs(A.SymbolsofDeathBuff.ID, true)) then
                return A.AncestralCall:Show(icon)
            end
            
            -- use_item,effect_name=cyclotronic_blast,if=!stealthed.all&variable.snd_condition&!buff.symbols_of_death.up&energy.deficit>=30
            if A.CyclotronicBlast:IsReady(unit) and (not Unit("player"):IsStealthed(true, true) and VarSndCondition and not Unit("player"):HasBuffs(A.SymbolsofDeathBuff.ID, true) and Player:EnergyDeficitPredicted() >= 30) then
                return A.CyclotronicBlast:Show(icon)
            end
            
            -- use_item,name=azsharas_font_of_power,if=!buff.shadow_dance.up&cooldown.symbols_of_death.remains<10
            if A.AzsharasFontofPower:IsReady(unit) and (not Unit("player"):HasBuffs(A.ShadowDanceBuff.ID, true) and A.SymbolsofDeath:GetCooldown() < 10) then
                return A.AzsharasFontofPower:Show(icon)
            end
            
            -- use_item,name=ashvanes_razor_coral,if=debuff.razor_coral_debuff.down|debuff.conductive_ink_debuff.up&target.health.pct<32&target.health.pct>=30|!debuff.conductive_ink_debuff.up&(debuff.razor_coral_debuff.stack>=25-10*debuff.blood_of_the_enemy.up|fight_remains<40)&buff.symbols_of_death.remains>8
            if A.AshvanesRazorCoral:IsReady(unit) and (Unit(unit):HasDeBuffsDown(A.RazorCoralDebuff.ID, true) or Unit(unit):HasDeBuffs(A.ConductiveInkDebuff.ID, true) and Unit(unit):HealthPercent() < 32 and Unit(unit):HealthPercent() >= 30 or not Unit(unit):HasDeBuffs(A.ConductiveInkDebuff.ID, true) and (Unit(unit):HasDeBuffsStacks(A.RazorCoralDebuff.ID, true) >= 25 - 10 * num(Unit(unit):HasDeBuffs(A.BloodoftheEnemyDebuff.ID, true)) or fight_remains < 40) and Unit("player"):HasBuffs(A.SymbolsofDeathBuff.ID, true) > 8) then
                return A.AshvanesRazorCoral:Show(icon)
            end
            
            -- use_item,name=mydas_talisman
            if A.MydasTalisman:IsReady(unit) then
                return A.MydasTalisman:Show(icon)
            end
            
            -- use_items,if=buff.symbols_of_death.up|fight_remains<20
        end
        
        --Essences
        local function Essences(unit)
        
            -- concentrated_flame,if=energy.time_to_max>1&!buff.symbols_of_death.up&(!dot.concentrated_flame_burn.ticking&!action.concentrated_flame.in_flight|full_recharge_time<gcd.max)
            if A.ConcentratedFlame:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and (Player:EnergyTimeToMaxPredicted() > 1 and not Unit("player"):HasBuffs(A.SymbolsofDeathBuff.ID, true) and (not Unit(unit):HasDeBuffs(A.ConcentratedFlameBurnDebuff.ID, true) and not A.ConcentratedFlame:IsSpellInFlight() or A.ConcentratedFlame:GetSpellChargesFullRechargeTime() < GetGCD())) then
                return A.ConcentratedFlame:Show(icon)
            end
            
            -- blood_of_the_enemy,if=!cooldown.shadow_blades.up&cooldown.symbols_of_death.up|fight_remains<=10
            if A.BloodoftheEnemy:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and (not A.ShadowBlades:GetCooldown() == 0 and A.SymbolsofDeath:GetCooldown() == 0 or fight_remains <= 10) then
                return A.BloodoftheEnemy:Show(icon)
            end
            
            -- guardian_of_azeroth
            if A.GuardianofAzeroth:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth then
                return A.GuardianofAzeroth:Show(icon)
            end
            
            -- focused_azerite_beam,if=(spell_targets.shuriken_storm>=2|raid_event.adds.in>60)&!cooldown.symbols_of_death.up&!buff.symbols_of_death.up&energy.deficit>=30
            if A.FocusedAzeriteBeam:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and ((MultiUnits:GetByRangeInCombat(10, 5, 10) >= 2 or IncomingAddsIn > 60) and not A.SymbolsofDeath:GetCooldown() == 0 and not Unit("player"):HasBuffs(A.SymbolsofDeathBuff.ID, true) and Player:EnergyDeficitPredicted() >= 30) then
                return A.FocusedAzeriteBeam:Show(icon)
            end
            
            -- purifying_blast,if=spell_targets.shuriken_storm>=2|raid_event.adds.in>60
            if A.PurifyingBlast:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and (MultiUnits:GetByRangeInCombat(10, 5, 10) >= 2 or IncomingAddsIn > 60) then
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
            
            -- worldvein_resonance,if=cooldown.symbols_of_death.remains<5|fight_remains<18
            if A.WorldveinResonance:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and (A.SymbolsofDeath:GetCooldown() < 5 or fight_remains < 18) then
                return A.WorldveinResonance:Show(icon)
            end
            
            -- memory_of_lucid_dreams,if=energy<40&buff.symbols_of_death.up
            if A.MemoryofLucidDreams:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and (Player:EnergyPredicted() < 40 and Unit("player"):HasBuffs(A.SymbolsofDeathBuff.ID, true)) then
                return A.MemoryofLucidDreams:Show(icon)
            end
            
            -- cycling_variable,name=reaping_delay,op=min,if=essence.breath_of_the_dying.major,value=target.time_to_die
            if A.CyclingVariable:IsReady(unit) and (Azerite:EssenceHasMajor(A.BreathoftheDying.ID)) then
                return A.CyclingVariable:Show(icon) = math.min(return A.CyclingVariable:Show(icon), Unit(unit):TimeToDie())
            end
            
            -- reaping_flames,target_if=target.time_to_die<1.5|((target.health.pct>80|target.health.pct<=20)&(active_enemies=1|variable.reaping_delay>29))|(target.time_to_pct_20>30&(active_enemies=1|variable.reaping_delay>44))
            if A.ReapingFlames:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.ReapingFlames, 40, "min", EvaluateCycleReapingFlames265) then
                    return A.ReapingFlames:Show(icon) 
                end
            end
        end
        
        --Finish
        local function Finish(unit)
        
            -- slice_and_dice,if=spell_targets.shuriken_storm<6&!buff.shadow_dance.up&buff.slice_and_dice.remains<fight_remains&buff.slice_and_dice.remains<(1+combo_points)*1.8
            if A.SliceandDice:IsReady(unit) and (MultiUnits:GetByRangeInCombat(10, 5, 10) < 6 and not Unit("player"):HasBuffs(A.ShadowDanceBuff.ID, true) and Unit("player"):HasBuffs(A.SliceandDiceBuff.ID, true) < fight_remains and Unit("player"):HasBuffs(A.SliceandDiceBuff.ID, true) < (1 + Player:ComboPoints()) * 1.8) then
                return A.SliceandDice:Show(icon)
            end
            
            -- variable,name=skip_rupture,value=master_assassin_remains>0|!talent.nightstalker.enabled&talent.dark_shadow.enabled&buff.shadow_dance.up|spell_targets.shuriken_storm>=6
            VarSkipRupture = num(MasterAssassinRemains > 0 or not A.Nightstalker:IsSpellLearned() and A.DarkShadow:IsSpellLearned() and Unit("player"):HasBuffs(A.ShadowDanceBuff.ID, true) or MultiUnits:GetByRangeInCombat(10, 5, 10) >= 6)
            
            -- rupture,if=!variable.skip_rupture&target.time_to_die-remains>6&refreshable
            if A.Rupture:IsReady(unit) and (not VarSkipRupture and Unit(unit):TimeToDie() - remains > 6 and refreshable) then
                return A.Rupture:Show(icon)
            end
            
            -- secret_technique
            if A.SecretTechnique:IsReady(unit) then
                return A.SecretTechnique:Show(icon)
            end
            
            -- rupture,cycle_targets=1,if=!variable.skip_rupture&!variable.use_priority_rotation&spell_targets.shuriken_storm>=2&target.time_to_die>=(5+(2*combo_points))&refreshable
            if A.Rupture:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.Rupture, 40, "min", EvaluateCycleRupture318) then
                    return A.Rupture:Show(icon) 
                end
            end
            -- rupture,if=!variable.skip_rupture&remains<cooldown.symbols_of_death.remains+10&cooldown.symbols_of_death.remains<=5&target.time_to_die-remains>cooldown.symbols_of_death.remains+5
            if A.Rupture:IsReady(unit) and (not VarSkipRupture and remains < A.SymbolsofDeath:GetCooldown() + 10 and A.SymbolsofDeath:GetCooldown() <= 5 and Unit(unit):TimeToDie() - remains > A.SymbolsofDeath:GetCooldown() + 5) then
                return A.Rupture:Show(icon)
            end
            
            -- eviscerate
            if A.Eviscerate:IsReady(unit) then
                return A.Eviscerate:Show(icon)
            end
            
        end
        
        --StealthCds
        local function StealthCds(unit)
        
            -- variable,name=shd_threshold,value=cooldown.shadow_dance.charges_fractional>=1.75
            VarShdThreshold = num(A.ShadowDance:GetSpellChargesFrac() >= 1.75)
            
            -- vanish,if=(!variable.shd_threshold|!talent.nightstalker.enabled&talent.dark_shadow.enabled)&combo_points.deficit>1&!runeforge.mark_of_the_master_assassin.equipped
            if A.Vanish:IsReady(unit) and ((not VarShdThreshold or not A.Nightstalker:IsSpellLearned() and A.DarkShadow:IsSpellLearned()) and Player:ComboPointsDeficit() > 1 and not runeforge.mark_of_the_master_assassin.equipped) then
                return A.Vanish:Show(icon)
            end
            
            -- sepsis
            if A.Sepsis:IsReady(unit) then
                return A.Sepsis:Show(icon)
            end
            
            -- pool_resource,for_next=1,extra_amount=40
            -- shadowmeld,if=energy>=40&energy.deficit>=10&!variable.shd_threshold&combo_points.deficit>1&debuff.find_weakness.remains<1
            if A.Shadowmeld:AutoRacial(unit) and Racial and A.BurstIsON(unit) and (Player:EnergyPredicted() >= 40 and Player:EnergyDeficitPredicted() >= 10 and not VarShdThreshold and Player:ComboPointsDeficit() > 1 and Unit(unit):HasDeBuffs(A.FindWeaknessDebuff.ID, true) < 1) then
                if A.Shadowmeld:IsUsablePPool(40) then
                    return A.Shadowmeld:Show(icon)
                else
                    return A.PoolResource:Show(icon)
                end
            end
            
            -- variable,name=shd_combo_points,value=combo_points.deficit>=4
            VarShdComboPoints = num(Player:ComboPointsDeficit() >= 4)
            
            -- variable,name=shd_combo_points,value=combo_points.deficit<=1,if=variable.use_priority_rotation
            if (VarUsePriorityRotation) then
                VarShdComboPoints = num(Player:ComboPointsDeficit() <= 1)
            end
            
            -- shadow_dance,if=variable.shd_combo_points&(variable.shd_threshold|buff.symbols_of_death.remains>=1.2|spell_targets.shuriken_storm>=4&cooldown.symbols_of_death.remains>10)
            if A.ShadowDance:IsReady(unit) and (VarShdComboPoints and (VarShdThreshold or Unit("player"):HasBuffs(A.SymbolsofDeathBuff.ID, true) >= 1.2 or MultiUnits:GetByRangeInCombat(10, 5, 10) >= 4 and A.SymbolsofDeath:GetCooldown() > 10)) then
                return A.ShadowDance:Show(icon)
            end
            
            -- shadow_dance,if=variable.shd_combo_points&fight_remains<cooldown.symbols_of_death.remains
            if A.ShadowDance:IsReady(unit) and (VarShdComboPoints and fight_remains < A.SymbolsofDeath:GetCooldown()) then
                return A.ShadowDance:Show(icon)
            end
            
        end
        
        --Stealthed
        local function Stealthed(unit)
        
            -- shadowstrike,if=(buff.stealth.up|buff.vanish.up)
            if A.Shadowstrike:IsReady(unit) and ((Unit("player"):HasBuffs(A.StealthBuff.ID, true) or Unit("player"):HasBuffs(A.VanishBuff.ID, true))) then
                return A.Shadowstrike:Show(icon)
            end
            
            -- call_action_list,name=finish,if=buff.shuriken_tornado.up&combo_points.deficit<=2
            if (Unit("player"):HasBuffs(A.ShurikenTornadoBuff.ID, true) and Player:ComboPointsDeficit() <= 2) then
                if Finish(unit) then
                    return true
                end
            end
            
            -- call_action_list,name=finish,if=spell_targets.shuriken_storm=4&combo_points>=4
            if (MultiUnits:GetByRangeInCombat(10, 5, 10) == 4 and Player:ComboPoints() >= 4) then
                if Finish(unit) then
                    return true
                end
            end
            
            -- call_action_list,name=finish,if=combo_points.deficit<=1-(talent.deeper_stratagem.enabled&buff.vanish.up)
            if (Player:ComboPointsDeficit() <= 1 - num((A.DeeperStratagem:IsSpellLearned() and Unit("player"):HasBuffs(A.VanishBuff.ID, true)))) then
                if Finish(unit) then
                    return true
                end
            end
            
            -- shiv,if=talent.nightstalker.enabled&runeforge.tiny_toxic_blade.equipped
            if A.Shiv:IsReady(unit) and (A.Nightstalker:IsSpellLearned() and runeforge.tiny_toxic_blade.equipped) then
                return A.Shiv:Show(icon)
            end
            
            -- shadowstrike,if=level<52&debuff.find_weakness.remains<1&target.time_to_die-remains>6
            if A.Shadowstrike:IsReady(unit) and (Unit("player"):level < 52 and Unit(unit):HasDeBuffs(A.FindWeaknessDebuff.ID, true) < 1 and Unit(unit):TimeToDie() - remains > 6) then
                return A.Shadowstrike:Show(icon)
            end
            
            -- shadowstrike,cycle_targets=1,if=debuff.find_weakness.remains<1&spell_targets.shuriken_storm<=3&target.time_to_die-remains>6
            if A.Shadowstrike:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.Shadowstrike, 40, "min", EvaluateCycleShadowstrike427) then
                    return A.Shadowstrike:Show(icon) 
                end
            end
            -- shadowstrike,if=!talent.deeper_stratagem.enabled&azerite.blade_in_the_shadows.rank=3&spell_targets.shuriken_storm=3
            if A.Shadowstrike:IsReady(unit) and (not A.DeeperStratagem:IsSpellLearned() and A.BladeIntheShadows:GetAzeriteRank() == 3 and MultiUnits:GetByRangeInCombat(10, 5, 10) == 3) then
                return A.Shadowstrike:Show(icon)
            end
            
            -- shadowstrike,if=variable.use_priority_rotation&(debuff.find_weakness.remains<1|talent.weaponmaster.enabled&spell_targets.shuriken_storm<=4|azerite.inevitability.enabled&buff.symbols_of_death.up&spell_targets.shuriken_storm<=3+azerite.blade_in_the_shadows.enabled)
            if A.Shadowstrike:IsReady(unit) and (VarUsePriorityRotation and (Unit(unit):HasDeBuffs(A.FindWeaknessDebuff.ID, true) < 1 or A.Weaponmaster:IsSpellLearned() and MultiUnits:GetByRangeInCombat(10, 5, 10) <= 4 or A.Inevitability:GetAzeriteRank() > 0 and Unit("player"):HasBuffs(A.SymbolsofDeathBuff.ID, true) and MultiUnits:GetByRangeInCombat(10, 5, 10) <= 3 + A.BladeIntheShadows:GetAzeriteRank() > 0)) then
                return A.Shadowstrike:Show(icon)
            end
            
            -- shuriken_storm,if=spell_targets>=3+(buff.premeditation.up|buff.the_rotten.up|runeforge.akaaris_soul_fragment.equipped&conduit.deeper_daggers.rank>=7)
            if A.ShurikenStorm:IsReady(unit) and (MultiUnits:GetByRangeInCombat(10, 5, 10) >= 3 + num((Unit("player"):HasBuffs(A.PremeditationBuff.ID, true) or Unit("player"):HasBuffs(A.TheRottenBuff.ID, true) or runeforge.akaaris_soul_fragment.equipped and conduit.deeper_daggers.rank >= 7))) then
                return A.ShurikenStorm:Show(icon)
            end
            
            -- shadowstrike,if=debuff.find_weakness.remains<=1|cooldown.symbols_of_death.remains<18&debuff.find_weakness.remains<cooldown.symbols_of_death.remains
            if A.Shadowstrike:IsReady(unit) and (Unit(unit):HasDeBuffs(A.FindWeaknessDebuff.ID, true) <= 1 or A.SymbolsofDeath:GetCooldown() < 18 and Unit(unit):HasDeBuffs(A.FindWeaknessDebuff.ID, true) < A.SymbolsofDeath:GetCooldown()) then
                return A.Shadowstrike:Show(icon)
            end
            
            -- pool_resource,for_next=1
            -- gloomblade,if=!runeforge.akaaris_soul_fragment.equipped&buff.perforated_veins.stack>=3&conduit.perforated_veins.rank>=13-(9*conduit.deeper_dagger.enabled+conduit.deeper_dagger.rank)
            if A.Gloomblade:IsReady(unit) and (not runeforge.akaaris_soul_fragment.equipped and Unit("player"):HasBuffsStacks(A.PerforatedVeinsBuff.ID, true) >= 3 and conduit.perforated_veins.rank >= 13 - (9 * conduit.deeper_dagger.enabled + conduit.deeper_dagger.rank)) then
                if A.Gloomblade:IsUsablePPool() then
                    return A.Gloomblade:Show(icon)
                else
                    return A.PoolResource:Show(icon)
                end
            end
            
            -- gloomblade,if=runeforge.akaaris_soul_fragment.equipped&buff.perforated_veins.stack>=3&(conduit.perforated_veins.rank+conduit.deeper_dagger.rank)>=16
            if A.Gloomblade:IsReady(unit) and (runeforge.akaaris_soul_fragment.equipped and Unit("player"):HasBuffsStacks(A.PerforatedVeinsBuff.ID, true) >= 3 and (conduit.perforated_veins.rank + conduit.deeper_dagger.rank) >= 16) then
                return A.Gloomblade:Show(icon)
            end
            
            -- shadowstrike
            if A.Shadowstrike:IsReady(unit) then
                return A.Shadowstrike:Show(icon)
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
            
            -- variable,name=snd_condition,value=buff.slice_and_dice.up|spell_targets.shuriken_storm>=6
            VarSndCondition = num(Unit("player"):HasBuffs(A.SliceandDiceBuff.ID, true) or MultiUnits:GetByRangeInCombat(10, 5, 10) >= 6)
            
            -- call_action_list,name=cds
            if Cds(unit) then
                return true
            end
            
            -- run_action_list,name=stealthed,if=stealthed.all
            if (Unit("player"):IsStealthed(true, true)) then
                return Stealthed(unit);
            end
            
            -- slice_and_dice,if=spell_targets.shuriken_storm<6&fight_remains>6&buff.slice_and_dice.remains<gcd.max&combo_points>=4-(time<10)*2
            if A.SliceandDice:IsReady(unit) and (MultiUnits:GetByRangeInCombat(10, 5, 10) < 6 and fight_remains > 6 and Unit("player"):HasBuffs(A.SliceandDiceBuff.ID, true) < GetGCD() and Player:ComboPoints() >= 4 - num((Unit("player"):CombatTime() < 10)) * 2) then
                return A.SliceandDice:Show(icon)
            end
            
            -- variable,name=use_priority_rotation,value=priority_rotation&spell_targets.shuriken_storm>=2
            VarUsePriorityRotation = num(priority_rotation and MultiUnits:GetByRangeInCombat(10, 5, 10) >= 2)
            
            -- call_action_list,name=stealth_cds,if=variable.use_priority_rotation
            if (VarUsePriorityRotation) then
                if StealthCds(unit) then
                    return true
                end
            end
            
            -- variable,name=stealth_threshold,value=25+talent.vigor.enabled*20+talent.master_of_shadows.enabled*20+talent.shadow_focus.enabled*25+talent.alacrity.enabled*20+25*(spell_targets.shuriken_storm>=4)
            VarStealthThreshold = 25 + num(A.Vigor:IsSpellLearned()) * 20 + num(A.MasterofShadows:IsSpellLearned()) * 20 + num(A.ShadowFocus:IsSpellLearned()) * 25 + num(A.Alacrity:IsSpellLearned()) * 20 + 25 * num((MultiUnits:GetByRangeInCombat(10, 5, 10) >= 4))
            
            -- call_action_list,name=stealth_cds,if=energy.deficit<=variable.stealth_threshold
            if (Player:EnergyDeficitPredicted() <= VarStealthThreshold) then
                if StealthCds(unit) then
                    return true
                end
            end
            
            -- call_action_list,name=finish,if=runeforge.deathly_shadows.equipped&dot.sepsis.ticking&dot.sepsis.remains<=2&combo_points>=2
            if (runeforge.deathly_shadows.equipped and Unit(unit):HasDeBuffs(A.SepsisDebuff.ID, true) and Unit(unit):HasDeBuffs(A.SepsisDebuff.ID, true) <= 2 and Player:ComboPoints() >= 2) then
                if Finish(unit) then
                    return true
                end
            end
            
            -- call_action_list,name=finish,if=combo_points=animacharged_cp
            if (Player:ComboPoints() == animacharged_cp) then
                if Finish(unit) then
                    return true
                end
            end
            
            -- call_action_list,name=finish,if=combo_points.deficit<=1|fight_remains<=1&combo_points>=3
            if (Player:ComboPointsDeficit() <= 1 or fight_remains <= 1 and Player:ComboPoints() >= 3) then
                if Finish(unit) then
                    return true
                end
            end
            
            -- call_action_list,name=finish,if=spell_targets.shuriken_storm=4&combo_points>=4
            if (MultiUnits:GetByRangeInCombat(10, 5, 10) == 4 and Player:ComboPoints() >= 4) then
                if Finish(unit) then
                    return true
                end
            end
            
            -- call_action_list,name=build,if=energy.deficit<=variable.stealth_threshold
            if (Player:EnergyDeficitPredicted() <= VarStealthThreshold) then
                if Build(unit) then
                    return true
                end
            end
            
            -- arcane_torrent,if=energy.deficit>=15+energy.regen
            if A.ArcaneTorrent:AutoRacial(unit) and Racial and A.BurstIsON(unit) and (Player:EnergyDeficitPredicted() >= 15 + Player:EnergyRegen()) then
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

