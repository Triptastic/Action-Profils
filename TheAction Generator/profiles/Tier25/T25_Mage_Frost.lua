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

Action[ACTION_CONST_MAGE_FROST] = {
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
    SummonWaterElemental                   = Create({ Type = "Spell", ID = 31687 }),
    MirrorImage                            = Create({ Type = "Spell", ID = 55342 }),
    Frostbolt                              = Create({ Type = "Spell", ID = 116 }),
    FrozenOrb                              = Create({ Type = "Spell", ID = 84714 }),
    Blizzard                               = Create({ Type = "Spell", ID = 190356 }),
    CometStorm                             = Create({ Type = "Spell", ID = 153595 }),
    IceNova                                = Create({ Type = "Spell", ID = 157997 }),
    Flurry                                 = Create({ Type = "Spell", ID = 44614 }),
    Ebonbolt                               = Create({ Type = "Spell", ID = 257537 }),
    BrainFreezeBuff                        = Create({ Type = "Spell", ID = 190446 }),
    IciclesBuff                            = Create({ Type = "Spell", ID = 205473 }),
    GlacialSpike                           = Create({ Type = "Spell", ID = 199786 }),
    IceLance                               = Create({ Type = "Spell", ID = 30455 }),
    FingersofFrostBuff                     = Create({ Type = "Spell", ID = 44544 }),
    RayofFrost                             = Create({ Type = "Spell", ID = 205021 }),
    ConeofCold                             = Create({ Type = "Spell", ID = 120 }),
    IcyVeinsBuff                           = Create({ Type = "Spell", ID = 12472 }),
    RuneofPowerBuff                        = Create({ Type = "Spell", ID = 116014 }),
    IcyVeins                               = Create({ Type = "Spell", ID = 12472 }),
    RuneofPower                            = Create({ Type = "Spell", ID = 116011 }),
    BloodFury                              = Create({ Type = "Spell", ID = 20572 }),
    Berserking                             = Create({ Type = "Spell", ID = 26297 }),
    LightsJudgment                         = Create({ Type = "Spell", ID = 255647 }),
    Fireblood                              = Create({ Type = "Spell", ID = 265221 }),
    AncestralCall                          = Create({ Type = "Spell", ID = 274738 }),
    BagofTricks                            = Create({ Type = "Spell", ID =  }),
    BloodoftheEnemyBuff                    = Create({ Type = "Spell", ID = 297108 }),
    ReapingFlames                          = Create({ Type = "Spell", ID =  }),
    BlinkAny                               = Create({ Type = "Spell", ID =  }),
    IceFloes                               = Create({ Type = "Spell", ID = 108839 }),
    IceFloesBuff                           = Create({ Type = "Spell", ID = 108839 }),
    WintersChillDebuff                     = Create({ Type = "Spell", ID = 228358 }),
    SplittingIce                           = Create({ Type = "Spell", ID = 56377 }),
    GlacialSpikeBuff                       = Create({ Type = "Spell", ID = 199844 }),
    IncantersFlow                          = Create({ Type = "Spell", ID =  }),
    FreezingRain                           = Create({ Type = "Spell", ID = 240555 })
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
Action:CreateEssencesFor(ACTION_CONST_MAGE_FROST)  -- where PLAYERSPEC is Constance (example: ACTION_CONST_MONK_BM)
local A = setmetatable(Action[ACTION_CONST_MAGE_FROST], { __index = Action })


------------------------------------------
---------------- VARIABLES ---------------
------------------------------------------
local VarIlIfGaming = 0;

A.Listener:Add("ROTATION_VARS", "PLAYER_REGEN_ENABLED", function()
  VarIlIfGaming = 0
end)



local function num(val)
    if val then return 1 else return 0 end
end

local function bool(val)
    return val ~= 0
end

------------------------------------------
---------- FROST PRE APL SETUP -----------
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
	return A.Frostbolt:IsInRange(unit)
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


local FrozenOrbFirstHit = true
local FrozenOrbHitTime = 0

Action:RegisterForSelfCombatEvent(function(...)
    local spellID = select(12, ...)
    if spellID == 84721 and FrozenOrbFirstHit then
        FrozenOrbFirstHit = false
        FrozenOrbHitTime = TMW.time
        C_Timer.After(10, function()
            FrozenOrbFirstHit = true
            FrozenOrbHitTime = 0
        end)
    end
end, "SPELL_DAMAGE")

function Player:FrozenOrbGroundAoeRemains()
    return math.max(Action.OffsetRemains(FrozenOrbHitTime - (TMW.time - 10), "Auto"), 0)
end

local brain_freeze_active = false

Action:RegisterForSelfCombatEvent(function(...)
    local spellID = select(12, ...)
    if spellID == A.Flurry.ID then
        brain_freeze_active =   Unit("player"):HasBuffs(A.BrainFreezeBuff.ID, true) > 0
                            --or  Spell.TR.Frost.BrainFreezeBuff:TimeSinceLastRemovedOnPlayer() < 0.1
    end
end, "SPELL_CAST_SUCCESS")

function Player:BrainFreezeActive()
    if self:CastRemains(A.Flurry.ID) > 0 then
        return false
    else
        return brain_freeze_active
    end
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
            
            -- variable,name=il_if_gaming,default=0,op=reset
            VarIlIfGaming = 0
            
            -- summon_water_elemental
            if A.SummonWaterElemental:IsReady(unit) then
                return A.SummonWaterElemental:Show(icon)
            end
            
            -- snapshot_stats
            -- use_item,name=azsharas_font_of_power
            if A.AzsharasFontofPower:IsReady(unit) then
                return A.AzsharasFontofPower:Show(icon)
            end
            
            -- mirror_image
            if A.MirrorImage:IsReady(unit) and A.BurstIsON(unit) then
                return A.MirrorImage:Show(icon)
            end
            
            -- potion
            if A.PotionofSpectralIntellect:IsReady(unit) and Potion then
                return A.PotionofSpectralIntellect:Show(icon)
            end
            
            -- frostbolt
            if A.Frostbolt:IsReady(unit) and inCombat and Unit(unit):IsExists() and unit ~= "mouseover" then
                return A.Frostbolt:Show(icon)
            end
            
        end
        
        --Aoe
        local function Aoe(unit)
        
            -- frozen_orb
            if A.FrozenOrb:IsReady(unit) then
                return A.FrozenOrb:Show(icon)
            end
            
            -- blizzard
            if A.Blizzard:IsReady(unit) then
                return A.Blizzard:Show(icon)
            end
            
            -- call_action_list,name=essences
            if Essences(unit) then
                return true
            end
            
            -- comet_storm
            if A.CometStorm:IsReady(unit) then
                return A.CometStorm:Show(icon)
            end
            
            -- ice_nova
            if A.IceNova:IsReady(unit) then
                return A.IceNova:Show(icon)
            end
            
            -- flurry,if=prev_gcd.1.ebonbolt|buff.brain_freeze.react&(prev_gcd.1.frostbolt&(buff.icicles.stack<4|!talent.glacial_spike.enabled)|prev_gcd.1.glacial_spike)
            if A.Flurry:IsReady(unit) and (Player:PrevGCD(1, A.Ebonbolt) or Unit("player"):HasBuffsStacks(A.BrainFreezeBuff.ID, true) and (Player:PrevGCD(1, A.Frostbolt) and (Unit("player"):HasBuffsStacks(A.IciclesBuff.ID, true) < 4 or not A.GlacialSpike:IsSpellLearned()) or Player:PrevGCD(1, A.GlacialSpike))) then
                return A.Flurry:Show(icon)
            end
            
            -- ice_lance,if=buff.fingers_of_frost.react
            if A.IceLance:IsReady(unit) and (Unit("player"):HasBuffsStacks(A.FingersofFrostBuff.ID, true)) then
                return A.IceLance:Show(icon)
            end
            
            -- ray_of_frost
            if A.RayofFrost:IsReady(unit) then
                return A.RayofFrost:Show(icon)
            end
            
            -- ebonbolt
            if A.Ebonbolt:IsReady(unit) then
                return A.Ebonbolt:Show(icon)
            end
            
            -- glacial_spike
            if A.GlacialSpike:IsReady(unit) then
                return A.GlacialSpike:Show(icon)
            end
            
            -- cone_of_cold
            if A.ConeofCold:IsReady(unit) then
                return A.ConeofCold:Show(icon)
            end
            
            -- use_item,name=tidestorm_codex,if=buff.icy_veins.down&buff.rune_of_power.down
            if A.TidestormCodex:IsReady(unit) and (Unit("player"):HasBuffsDown(A.IcyVeinsBuff.ID, true) and Unit("player"):HasBuffsDown(A.RuneofPowerBuff.ID, true)) then
                return A.TidestormCodex:Show(icon)
            end
            
            -- use_item,effect_name=cyclotronic_blast,if=buff.icy_veins.down&buff.rune_of_power.down
            if A.CyclotronicBlast:IsReady(unit) and (Unit("player"):HasBuffsDown(A.IcyVeinsBuff.ID, true) and Unit("player"):HasBuffsDown(A.RuneofPowerBuff.ID, true)) then
                return A.CyclotronicBlast:Show(icon)
            end
            
            -- frostbolt
            if A.Frostbolt:IsReady(unit) then
                return A.Frostbolt:Show(icon)
            end
            
            -- call_action_list,name=movement
            if Movement(unit) then
                return true
            end
            
            -- ice_lance
            if A.IceLance:IsReady(unit) then
                return A.IceLance:Show(icon)
            end
            
        end
        
        --Cooldowns
        local function Cooldowns(unit)
        
            -- guardian_of_azeroth
            if A.GuardianofAzeroth:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth then
                return A.GuardianofAzeroth:Show(icon)
            end
            
            -- icy_veins
            if A.IcyVeins:IsReady(unit) and A.BurstIsON(unit) then
                return A.IcyVeins:Show(icon)
            end
            
            -- mirror_image
            if A.MirrorImage:IsReady(unit) and A.BurstIsON(unit) then
                return A.MirrorImage:Show(icon)
            end
            
            -- rune_of_power,if=buff.rune_of_power.down&(prev_gcd.1.frozen_orb|target.time_to_die>10+cast_time&target.time_to_die<20)
            if A.RuneofPower:IsReady(unit) and (Unit("player"):HasBuffsDown(A.RuneofPowerBuff.ID, true) and (Player:PrevGCD(1, A.FrozenOrb) or Unit(unit):TimeToDie() > 10 + A.RuneofPower:GetSpellCastTime() and Unit(unit):TimeToDie() < 20)) then
                return A.RuneofPower:Show(icon)
            end
            
            -- call_action_list,name=talent_rop,if=talent.rune_of_power.enabled&active_enemies=1&cooldown.rune_of_power.full_recharge_time<cooldown.frozen_orb.remains
            if (A.RuneofPower:IsSpellLearned() and MultiUnits:GetByRangeInCombat(40, 5, 10) == 1 and A.RuneofPower:FullRechargeTimeP() < A.FrozenOrb:GetCooldown()) then
                if TalentRop(unit) then
                    return true
                end
            end
            
            -- potion,if=prev_gcd.1.icy_veins|target.time_to_die<30
            if A.PotionofSpectralIntellect:IsReady(unit) and Potion and (Player:PrevGCD(1, A.IcyVeins) or Unit(unit):TimeToDie() < 30) then
                return A.PotionofSpectralIntellect:Show(icon)
            end
            
            -- use_item,name=balefire_branch,if=!talent.glacial_spike.enabled|buff.brain_freeze.react&prev_gcd.1.glacial_spike
            if A.BalefireBranch:IsReady(unit) and (not A.GlacialSpike:IsSpellLearned() or Unit("player"):HasBuffsStacks(A.BrainFreezeBuff.ID, true) and Player:PrevGCD(1, A.GlacialSpike)) then
                return A.BalefireBranch:Show(icon)
            end
            
            -- use_items
            -- blood_fury
            if A.BloodFury:AutoRacial(unit) and Racial and A.BurstIsON(unit) then
                return A.BloodFury:Show(icon)
            end
            
            -- berserking
            if A.Berserking:AutoRacial(unit) and Racial and A.BurstIsON(unit) then
                return A.Berserking:Show(icon)
            end
            
            -- lights_judgment
            if A.LightsJudgment:IsReady(unit) and A.BurstIsON(unit) then
                return A.LightsJudgment:Show(icon)
            end
            
            -- fireblood
            if A.Fireblood:AutoRacial(unit) and Racial and A.BurstIsON(unit) then
                return A.Fireblood:Show(icon)
            end
            
            -- ancestral_call
            if A.AncestralCall:AutoRacial(unit) and Racial and A.BurstIsON(unit) then
                return A.AncestralCall:Show(icon)
            end
            
            -- bag_of_tricks
            if A.BagofTricks:IsReady(unit) then
                return A.BagofTricks:Show(icon)
            end
            
        end
        
        --Essences
        local function Essences(unit)
        
            -- focused_azerite_beam,if=buff.rune_of_power.down|active_enemies>3
            if A.FocusedAzeriteBeam:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and (Unit("player"):HasBuffsDown(A.RuneofPowerBuff.ID, true) or MultiUnits:GetByRangeInCombat(40, 5, 10) > 3) then
                return A.FocusedAzeriteBeam:Show(icon)
            end
            
            -- memory_of_lucid_dreams,if=active_enemies<5&(buff.icicles.stack<=1|!talent.glacial_spike.enabled)&cooldown.frozen_orb.remains>10
            if A.MemoryofLucidDreams:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and (MultiUnits:GetByRangeInCombat(40, 5, 10) < 5 and (Unit("player"):HasBuffsStacks(A.IciclesBuff.ID, true) <= 1 or not A.GlacialSpike:IsSpellLearned()) and A.FrozenOrb:GetCooldown() > 10) then
                return A.MemoryofLucidDreams:Show(icon)
            end
            
            -- blood_of_the_enemy,if=(talent.glacial_spike.enabled&buff.icicles.stack=5&(buff.brain_freeze.react|prev_gcd.1.ebonbolt))|((active_enemies>3|!talent.glacial_spike.enabled)&(prev_gcd.1.frozen_orb|ground_aoe.frozen_orb.remains>5))
            if A.BloodoftheEnemy:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and ((A.GlacialSpike:IsSpellLearned() and Unit("player"):HasBuffsStacks(A.IciclesBuff.ID, true) == 5 and (Unit("player"):HasBuffsStacks(A.BrainFreezeBuff.ID, true) or Player:PrevGCD(1, A.Ebonbolt))) or ((MultiUnits:GetByRangeInCombat(40, 5, 10) > 3 or not A.GlacialSpike:IsSpellLearned()) and (Player:PrevGCD(1, A.FrozenOrb) or Player:FrozenOrbGroundAoeRemains() > 5))) then
                return A.BloodoftheEnemy:Show(icon)
            end
            
            -- purifying_blast,if=buff.rune_of_power.down|active_enemies>3
            if A.PurifyingBlast:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and (Unit("player"):HasBuffsDown(A.RuneofPowerBuff.ID, true) or MultiUnits:GetByRangeInCombat(40, 5, 10) > 3) then
                return A.PurifyingBlast:Show(icon)
            end
            
            -- ripple_in_space,if=buff.rune_of_power.down|active_enemies>3
            if A.RippleInSpace:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and (Unit("player"):HasBuffsDown(A.RuneofPowerBuff.ID, true) or MultiUnits:GetByRangeInCombat(40, 5, 10) > 3) then
                return A.RippleInSpace:Show(icon)
            end
            
            -- concentrated_flame,line_cd=6,if=buff.rune_of_power.down
            if A.ConcentratedFlame:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and (Unit("player"):HasBuffsDown(A.RuneofPowerBuff.ID, true)) then
                return A.ConcentratedFlame:Show(icon)
            end
            
            -- reaping_flames,if=buff.rune_of_power.down
            if A.ReapingFlames:IsReady(unit) and (Unit("player"):HasBuffsDown(A.RuneofPowerBuff.ID, true)) then
                return A.ReapingFlames:Show(icon)
            end
            
            -- the_unbound_force,if=buff.reckless_force.up
            if A.TheUnboundForce:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and (Unit("player"):HasBuffs(A.RecklessForceBuff.ID, true)) then
                return A.TheUnboundForce:Show(icon)
            end
            
            -- worldvein_resonance,if=buff.rune_of_power.down|active_enemies>3
            if A.WorldveinResonance:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and (Unit("player"):HasBuffsDown(A.RuneofPowerBuff.ID, true) or MultiUnits:GetByRangeInCombat(40, 5, 10) > 3) then
                return A.WorldveinResonance:Show(icon)
            end
            
        end
        
        --Movement
        local function Movement(unit)
        
            -- blink_any,if=movement.distance>10
            if A.BlinkAny:IsReady(unit) and (Unit(unit):GetRange() > 10) then
                return A.BlinkAny:Show(icon)
            end
            
            -- ice_floes,if=buff.ice_floes.down
            if A.IceFloes:IsReady(unit) and (Unit("player"):HasBuffsDown(A.IceFloesBuff.ID, true)) then
                return A.IceFloes:Show(icon)
            end
            
        end
        
        --Single
        local function Single(unit)
        
            -- ice_nova,if=cooldown.ice_nova.ready&debuff.winters_chill.up
            if A.IceNova:IsReady(unit) and (A.IceNova:GetCooldown() == 0 and Unit(unit):HasDeBuffs(A.WintersChillDebuff.ID, true)) then
                return A.IceNova:Show(icon)
            end
            
            -- flurry,if=talent.ebonbolt.enabled&prev_gcd.1.ebonbolt&buff.brain_freeze.react
            if A.Flurry:IsReady(unit) and (A.Ebonbolt:IsSpellLearned() and Player:PrevGCD(1, A.Ebonbolt) and Unit("player"):HasBuffsStacks(A.BrainFreezeBuff.ID, true)) then
                return A.Flurry:Show(icon)
            end
            
            -- flurry,if=prev_gcd.1.glacial_spike&buff.brain_freeze.react
            if A.Flurry:IsReady(unit) and (Player:PrevGCD(1, A.GlacialSpike) and Unit("player"):HasBuffsStacks(A.BrainFreezeBuff.ID, true)) then
                return A.Flurry:Show(icon)
            end
            
            -- call_action_list,name=essences
            if Essences(unit) then
                return true
            end
            
            -- frozen_orb
            if A.FrozenOrb:IsReady(unit) then
                return A.FrozenOrb:Show(icon)
            end
            
            -- blizzard,if=active_enemies>2|active_enemies>1&!talent.splitting_ice.enabled
            if A.Blizzard:IsReady(unit) and (MultiUnits:GetByRangeInCombat(35, 5, 10) > 2 or MultiUnits:GetByRangeInCombat(35, 5, 10) > 1 and not A.SplittingIce:IsSpellLearned()) then
                return A.Blizzard:Show(icon)
            end
            
            -- comet_storm
            if A.CometStorm:IsReady(unit) then
                return A.CometStorm:Show(icon)
            end
            
            -- ebonbolt,if=buff.icicles.stack=5&!buff.brain_freeze.react
            if A.Ebonbolt:IsReady(unit) and (Unit("player"):HasBuffsStacks(A.IciclesBuff.ID, true) == 5 and not Unit("player"):HasBuffsStacks(A.BrainFreezeBuff.ID, true)) then
                return A.Ebonbolt:Show(icon)
            end
            
            -- ice_lance,if=variable.il_if_gaming&buff.brain_freeze.react&(buff.fingers_of_frost.react|prev_gcd.1.flurry)&(buff.icicles.max_stack-buff.icicles.stack)*action.frostbolt.execute_time+action.glacial_spike.cast_time+action.glacial_spike.travel_time<incanters_flow_time_to.5.any&buff.memory_of_lucid_dreams.down
            if A.IceLance:IsReady(unit) and (VarIlIfGaming and Unit("player"):HasBuffsStacks(A.BrainFreezeBuff.ID, true) and (Unit("player"):HasBuffsStacks(A.FingersofFrostBuff.ID, true) or Player:PrevGCD(1, A.Flurry)) and (buff.icicles.max_stack - Unit("player"):HasBuffsStacks(A.IciclesBuff.ID, true)) * A.Frostbolt:GetSpellCastTime() + A.GlacialSpike:GetSpellCastTime() + A.GlacialSpike:TravelTime() < incanters_flow_time_to.5.any and Unit("player"):HasBuffsDown(A.MemoryofLucidDreamsBuff.ID, true)) then
                return A.IceLance:Show(icon)
            end
            
            -- glacial_spike,if=buff.brain_freeze.react|prev_gcd.1.ebonbolt|talent.incanters_flow.enabled&cast_time+travel_time>incanters_flow_time_to.5.up&cast_time+travel_time<incanters_flow_time_to.4.down
            if A.GlacialSpike:IsReady(unit) and (Unit("player"):HasBuffsStacks(A.BrainFreezeBuff.ID, true) or Player:PrevGCD(1, A.Ebonbolt) or A.IncantersFlow:IsSpellLearned() and A.GlacialSpike:GetSpellCastTime() + A.GlacialSpike:TravelTime() > incanters_flow_time_to.5.up and A.GlacialSpike:GetSpellCastTime() + A.GlacialSpike:TravelTime() < incanters_flow_time_to.4.down) then
                return A.GlacialSpike:Show(icon)
            end
            
            -- ice_nova
            if A.IceNova:IsReady(unit) then
                return A.IceNova:Show(icon)
            end
            
            -- use_item,name=tidestorm_codex,if=buff.icy_veins.down&buff.rune_of_power.down
            if A.TidestormCodex:IsReady(unit) and (Unit("player"):HasBuffsDown(A.IcyVeinsBuff.ID, true) and Unit("player"):HasBuffsDown(A.RuneofPowerBuff.ID, true)) then
                return A.TidestormCodex:Show(icon)
            end
            
            -- use_item,effect_name=cyclotronic_blast,if=buff.icy_veins.down&buff.rune_of_power.down
            if A.CyclotronicBlast:IsReady(unit) and (Unit("player"):HasBuffsDown(A.IcyVeinsBuff.ID, true) and Unit("player"):HasBuffsDown(A.RuneofPowerBuff.ID, true)) then
                return A.CyclotronicBlast:Show(icon)
            end
            
            -- frostbolt
            if A.Frostbolt:IsReady(unit) then
                return A.Frostbolt:Show(icon)
            end
            
            -- call_action_list,name=movement
            if Movement(unit) then
                return true
            end
            
            -- ice_lance
            if A.IceLance:IsReady(unit) then
                return A.IceLance:Show(icon)
            end
            
        end
        
        --TalentRop
        local function TalentRop(unit)
        
            -- rune_of_power,if=buff.rune_of_power.down&talent.glacial_spike.enabled&buff.icicles.stack=5&(buff.brain_freeze.react|talent.ebonbolt.enabled&cooldown.ebonbolt.remains<cast_time)
            if A.RuneofPower:IsReady(unit) and (Unit("player"):HasBuffsDown(A.RuneofPowerBuff.ID, true) and A.GlacialSpike:IsSpellLearned() and Unit("player"):HasBuffsStacks(A.IciclesBuff.ID, true) == 5 and (Unit("player"):HasBuffsStacks(A.BrainFreezeBuff.ID, true) or A.Ebonbolt:IsSpellLearned() and A.Ebonbolt:GetCooldown() < A.RuneofPower:GetSpellCastTime())) then
                return A.RuneofPower:Show(icon)
            end
            
            -- rune_of_power,if=buff.rune_of_power.down&!talent.glacial_spike.enabled&(talent.ebonbolt.enabled&cooldown.ebonbolt.remains<cast_time|talent.comet_storm.enabled&cooldown.comet_storm.remains<cast_time|talent.ray_of_frost.enabled&cooldown.ray_of_frost.remains<cast_time|charges_fractional>1.9)
            if A.RuneofPower:IsReady(unit) and (Unit("player"):HasBuffsDown(A.RuneofPowerBuff.ID, true) and not A.GlacialSpike:IsSpellLearned() and (A.Ebonbolt:IsSpellLearned() and A.Ebonbolt:GetCooldown() < A.RuneofPower:GetSpellCastTime() or A.CometStorm:IsSpellLearned() and A.CometStorm:GetCooldown() < A.RuneofPower:GetSpellCastTime() or A.RayofFrost:IsSpellLearned() and A.RayofFrost:GetCooldown() < A.RuneofPower:GetSpellCastTime() or A.RuneofPower:GetSpellChargesFrac() > 1.9)) then
                return A.RuneofPower:Show(icon)
            end
            
        end
        
-- call precombat
if not Player:AffectingCombat() and (not Player:IsCasting() or Player:IsCasting(S.WaterElemental)) then
  if Precombat(unit) then
    return true
end
end

        -- In Combat
        if inCombat and Unit(unit):IsExists() then

                    -- counterspell
            -- call_action_list,name=cooldowns
            if A.BurstIsON(unit) then
                if Cooldowns(unit) then
                    return true
                end
            end
            
            -- call_action_list,name=aoe,if=active_enemies>3&talent.freezing_rain.enabled|active_enemies>4
            if (MultiUnits:GetByRangeInCombat(40, 5, 10) > 3 and A.FreezingRain:IsSpellLearned() or MultiUnits:GetByRangeInCombat(40, 5, 10) > 4) then
                if Aoe(unit) then
                    return true
                end
            end
            
            -- call_action_list,name=single
            if Single(unit) then
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

