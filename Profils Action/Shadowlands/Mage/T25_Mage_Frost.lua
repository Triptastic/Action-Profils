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
Action[ACTION_CONST_MAGE_FROST] = {
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
    SummonWaterElemental                   = Action.Create({ Type = "Spell", ID = 31687 }),
    MirrorImage                            = Action.Create({ Type = "Spell", ID = 55342 }),
    Frostbolt                              = Action.Create({ Type = "Spell", ID = 116 }),
    FrozenOrb                              = Action.Create({ Type = "Spell", ID = 84714 }),
    Blizzard                               = Action.Create({ Type = "Spell", ID = 190356 }),
    CometStorm                             = Action.Create({ Type = "Spell", ID = 153595 }),
    IceNova                                = Action.Create({ Type = "Spell", ID = 157997 }),
    Flurry                                 = Action.Create({ Type = "Spell", ID = 44614 }),
    Ebonbolt                               = Action.Create({ Type = "Spell", ID = 257537 }),
    BrainFreezeBuff                        = Action.Create({ Type = "Spell", ID = 190446, Hidden = true }),
    IciclesBuff                            = Action.Create({ Type = "Spell", ID = 205473, Hidden = true }),
    GlacialSpike                           = Action.Create({ Type = "Spell", ID = 199786 }),
    IceLance                               = Action.Create({ Type = "Spell", ID = 30455 }),
    FingersofFrostBuff                     = Action.Create({ Type = "Spell", ID = 44544, Hidden = true }),
    RayofFrost                             = Action.Create({ Type = "Spell", ID = 205021 }),
    ConeofCold                             = Action.Create({ Type = "Spell", ID = 120 }),
    IcyVeinsBuff                           = Action.Create({ Type = "Spell", ID = 12472, Hidden = true }),
    RuneofPowerBuff                        = Action.Create({ Type = "Spell", ID = 116014, Hidden = true }),
    IcyVeins                               = Action.Create({ Type = "Spell", ID = 12472 }),
    RuneofPower                            = Action.Create({ Type = "Spell", ID = 116011 }),
    BloodFury                              = Action.Create({ Type = "Spell", ID = 20572 }),
    Berserking                             = Action.Create({ Type = "Spell", ID = 26297 }),
    LightsJudgment                         = Action.Create({ Type = "Spell", ID = 255647 }),
    Fireblood                              = Action.Create({ Type = "Spell", ID = 265221 }),
    AncestralCall                          = Action.Create({ Type = "Spell", ID = 274738 }),
    BagofTricks                            = Action.Create({ Type = "Spell", ID = 312411    }),
    BloodoftheEnemyBuff                    = Action.Create({ Type = "Spell", ID = 297108, Hidden = true }),
    IceFloes                               = Action.Create({ Type = "Spell", ID = 108839 }),
    IceFloesBuff                           = Action.Create({ Type = "Spell", ID = 108839, Hidden = true }),
    WintersChillDebuff                     = Action.Create({ Type = "Spell", ID = 228358, Hidden = true }),
    SplittingIce                           = Action.Create({ Type = "Spell", ID = 56377 }),
    GlacialSpikeBuff                       = Action.Create({ Type = "Spell", ID = 199844, Hidden = true }),
    IncantersFlow                          = Action.Create({ Type = "Spell", ID = 1463     }),
    FreezingRain                           = Action.Create({ Type = "Spell", ID = 240555 }),
	Shimmer                                = Action.Create({ Type = "Spell", ID = 212653     }),
	Blink                                  = Action.Create({ Type = "Spell", ID = 1953     }),
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
    UnleashHeartOfAzeroth                  = Action.Create({ Type = "Spell", ID = 280431, Hidden = true}),
    RecklessForceBuff                      = Action.Create({ Type = "Spell", ID = 302932, Hidden = true     }),	 
	DummyTest                              = Action.Create({ Type = "Spell", ID = 159999, Hidden = true     }), -- Dummy stop dps icon 
	PoolResource                           = Action.Create({ Type = "Spell", ID = 209274, Hidden = true     }),
	IncantersFlowBuff                      = Action.Create({ Type = "Spell", ID = 116267, Hidden = true     }),
};

-- To create essences use next code:
Action:CreateEssencesFor(ACTION_CONST_MAGE_FROST)  -- where PLAYERSPEC is Constance (example: ACTION_CONST_MONK_BM)
local A = setmetatable(Action[ACTION_CONST_MAGE_FROST], { __index = Action })

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
}

local IsIndoors, UnitIsUnit, UnitName = IsIndoors, UnitIsUnit, UnitName

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

--Essences
local function Essences(unit)
		
    -- focused_azerite_beam,if=buff.rune_of_power.down|active_enemies>3
    if A.FocusedAzeriteBeam:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") and (Unit(player):HasBuffs(A.RuneofPowerBuff.ID, true) == 0 or GetByRange(3, 40, true, false)) then
        return A.FocusedAzeriteBeam
    end
			
    -- memory_of_lucid_dreams,if=active_enemies<5&(buff.icicles.stack<=1|!talent.glacial_spike.enabled)&cooldown.frozen_orb.remains>10
    if A.MemoryofLucidDreams:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") and (GetByRange(5, 40, false, true) and (Unit(player):HasBuffsStacks(A.IciclesBuff.ID, true) <= 1 or not A.GlacialSpike:IsSpellLearned()) and A.FrozenOrb:GetCooldown() > 10) then
        return A.MemoryofLucidDreams
    end
			
    -- blood_of_the_enemy,if=(talent.glacial_spike.enabled&buff.icicles.stack=5&(buff.brain_freeze.react|prev_gcd.1.ebonbolt))|((active_enemies>3|!talent.glacial_spike.enabled)&(prev_gcd.1.frozen_orb|ground_aoe.frozen_orb.remains>5))
    if A.BloodoftheEnemy:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") and ((A.GlacialSpike:IsSpellLearned() and Unit(player):HasBuffsStacks(A.IciclesBuff.ID, true) == 5 and (Unit(player):HasBuffs(A.BrainFreezeBuff.ID, true) > 0 or A.LastPlayerCastName == A.Ebonbolt:Info())) or ((GetByRange(3, 40, true, false) or not A.GlacialSpike:IsSpellLearned()) and (A.LastPlayerCastName == A.FrozenOrb:Info() or Player:FrozenOrbGroundAoeRemains() > 5))) then
        return A.BloodoftheEnemy
    end
			
    -- purifying_blast,if=buff.rune_of_power.down|active_enemies>3
    if A.PurifyingBlast:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") and (Unit(player):HasBuffs(A.RuneofPowerBuff.ID, true) == 0 or GetByRange(3, 40, true, false) ) then
        return A.PurifyingBlast
    end
			
    -- ripple_in_space,if=buff.rune_of_power.down|active_enemies>3
    if A.RippleinSpace:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") and (Unit(player):HasBuffs(A.RuneofPowerBuff.ID, true) == 0 or GetByRange(3, 40, true, false)) then
        return A.RippleinSpace
    end
			
    -- concentrated_flame,line_cd=6,if=buff.rune_of_power.down
    if A.ConcentratedFlame:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") and (Unit(player):HasBuffs(A.RuneofPowerBuff.ID, true) == 0) then
        return A.ConcentratedFlame
    end
			
    -- reaping_flames,if=buff.rune_of_power.down
    if A.ReapingFlames:AutoHeartOfAzerothP(unit, true) and (Unit(player):HasBuffs(A.RuneofPowerBuff.ID, true) == 0) then
        return A.ReapingFlames
    end
			
    -- the_unbound_force,if=buff.reckless_force.up
    if A.TheUnboundForce:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") and (Unit(player):HasBuffs(A.RecklessForceBuff.ID, true) > 0) then
        return A.TheUnboundForce
    end
			
    -- worldvein_resonance,if=buff.rune_of_power.down|active_enemies>3
    if A.WorldveinResonance:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") and (Unit(player):HasBuffs(A.RuneofPowerBuff.ID, true) == 0 or GetByRange(3, 40, true, false)) then
        return A.WorldveinResonance
    end
end
Essences = A.MakeFunctionCachedDynamic(Essences)

--TalentRop
local function TalentRop(unit)
		
    -- rune_of_power,if=talent.glacial_spike.enabled&buff.icicles.stack=5&(buff.brain_freeze.react|talent.ebonbolt.enabled&cooldown.ebonbolt.remains<cast_time)
    if A.RuneofPower:IsReady(player) and 
	(
	    A.GlacialSpike:IsSpellLearned() and Unit(player):HasBuffsStacks(A.IciclesBuff.ID, true) == 5 and 
		(
		     Unit(player):HasBuffs(A.BrainFreezeBuff.ID, true) > 0
			 or 
			 A.Ebonbolt:IsSpellLearned() and A.Ebonbolt:GetCooldown() < A.RuneofPower:GetSpellCastTime()
	    )
	)
	then
        return A.RuneofPower
    end
			
    -- rune_of_power,if=!talent.glacial_spike.enabled&(talent.ebonbolt.enabled&cooldown.ebonbolt.remains<cast_time|talent.comet_storm.enabled&cooldown.comet_storm.remains<cast_time|talent.ray_of_frost.enabled&cooldown.ray_of_frost.remains<cast_time|charges_fractional>1.9)
    if A.RuneofPower:IsReady(player) and 
	(
	    not A.GlacialSpike:IsSpellLearned() and 
		(
		     A.Ebonbolt:IsSpellLearned() and A.Ebonbolt:GetCooldown() < A.RuneofPower:GetSpellCastTime() 
			 or 
			 A.CometStorm:IsSpellLearned() and A.CometStorm:GetCooldown() < A.RuneofPower:GetSpellCastTime() 
			 or 
			 A.RayofFrost:IsSpellLearned() and A.RayofFrost:GetCooldown() < A.RuneofPower:GetSpellCastTime() 
			 or 
			 A.RuneofPower:GetSpellChargesFrac() > 1.9
		)
	)
	then
        return A.RuneofPower
    end			
end
TalentRop = A.MakeFunctionCachedDynamic(TalentRop)

                
--Movement
local function Movement(unit)
	local BlinkAny = A.Shimmer:IsSpellLearned() and A.Shimmer or A.Blink	
    -- blink_any,if=movement.distance>10
    if BlinkAny:IsReady(unit) and (Unit(unit):GetRange() > 10) then
        return BlinkAny
    end
			
    -- ice_floes,if=buff.ice_floes.down
    if A.IceFloes:IsReady(unit) and (Unit(player):HasBuffs(A.IceFloesBuff.ID, true) == 0) then
        return A.IceFloes
    end
			
end
Movement = A.MakeFunctionCachedDynamic(Movement)

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
 	local profileStop = false
	local DBM = Action.GetToggle(1, "BossMods")
	local HeartOfAzeroth = Action.GetToggle(1, "HeartOfAzeroth")
	local Racial = Action.GetToggle(1, "Racial")
	local Potion = Action.GetToggle(1, "Potion")
	local UnbridledFuryAuto = GetToggle(2, "UnbridledFuryAuto")
	local UnbridledFuryTTD = GetToggle(2, "UnbridledFuryTTD")
	local UnbridledFuryWithBloodlust = GetToggle(2, "UnbridledFuryWithBloodlust")
	local UnbridledFuryHP = GetToggle(2, "UnbridledFuryHP")
	local UnbridledFuryWithExecute = GetToggle(2, "UnbridledFuryWithExecute")
	local FocusedAzeriteBeamTTD = GetToggle(2, "FocusedAzeriteBeamTTD")
	local FocusedAzeriteBeamUnits = GetToggle(2, "FocusedAzeriteBeamUnits")   
	-- Blink Handler
	local BlinkAny = A.Shimmer:IsSpellLearned() and A.Shimmer or A.Blink
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

		-- Interrupts
        local Interrupt = Interrupts(unit)
        if inCombat and Interrupt then 
            return Interrupt:Show(icon)
        end 

        --Precombat
        if combatTime == 0 and not profileStop and Unit(unit):IsExists() and unit ~= "mouseover" then
            -- flask
            -- food
            -- augmentation
            -- arcane_intellect
            if A.ArcaneIntellect:IsReady(unit) and Unit(player):HasBuffsDown(A.ArcaneIntellectBuff.ID, true, true) then
                return A.ArcaneIntellect:Show(icon)
            end
			
            -- summon_water_elemental
            if A.SummonWaterElemental:IsReady(unit) then
                return A.SummonWaterElemental:Show(icon)
            end
			
            -- snapshot_stats
            -- use_item,name=azsharas_font_of_power
            if A.AzsharasFontofPower:IsReady(player) then
                return A.AzsharasFontofPower:Show(icon)
            end
			
            -- mirror_image
            if A.MirrorImage:IsReady(unit) and A.BurstIsON(unit) then
                return A.MirrorImage:Show(icon)
            end
			
            -- potion
            if A.PotionofUnbridledFury:IsReady(unit) and Action.GetToggle(1, "Potion") then
                return A.PotionofUnbridledFury:Show(icon)
            end
			
            -- frostbolt
            if A.Frostbolt:IsReady(unit) and inCombat and Unit(unit):IsExists() and unit ~= "mouseover" and not Unit(unit):IsTotem() then
                return A.Frostbolt:Show(icon)
            end
			
        end
       
		-- Burst Phase
		if BurstIsON(unit) and unit ~= "mouseover" and inCombat and not profileStop and CanCast then
		
            -- guardian_of_azeroth
            if A.GuardianofAzeroth:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") then
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
			
            -- rune_of_power,if=prev_gcd.1.frozen_orb|target.time_to_die>10+cast_time&target.time_to_die<20
            if A.RuneofPower:IsReady(player) and 
			(
			    A.LastPlayerCastName == A.FrozenOrb:Info() 
				or 
				Unit(unit):TimeToDie() > 10 + A.RuneofPower:GetSpellCastTime() and Unit(unit):TimeToDie() < 20
			)
			then
                return A.RuneofPower:Show(icon)
            end
			
            -- call_action_list,name=talent_rop,if=talent.rune_of_power.enabled&active_enemies=1&cooldown.rune_of_power.full_recharge_time<cooldown.frozen_orb.remains
            if TalentRop(unit) and (A.RuneofPower:IsSpellLearned() and GetByRange(2, 40, false, true) and A.RuneofPower:GetSpellChargesFullRechargeTime() < A.FrozenOrb:GetCooldown()) then
                return TalentRop(unit):Show(icon)
            end
			
            -- potion,if=prev_gcd.1.icy_veins|target.time_to_die<30
            if A.PotionofUnbridledFury:IsReady(unit) and Action.GetToggle(1, "Potion") and (A.LastPlayerCastName == A.IcyVeins:Info() or Unit(unit):TimeToDie() < 30) then
                return A.PotionofUnbridledFury:Show(icon)
            end
			
            -- use_item,name=balefire_branch,if=!talent.glacial_spike.enabled|buff.brain_freeze.react&prev_gcd.1.glacial_spike
            if A.BalefireBranch:IsReady(player) and (not A.GlacialSpike:IsSpellLearned() or Unit(player):HasBuffs(A.BrainFreezeBuff.ID, true) > 0 and A.LastPlayerCastName == A.GlacialSpike:Info()) then
                return A.BalefireBranch:Show(icon)
            end
			
            -- use_items
            -- blood_fury
            if A.BloodFury:AutoRacial(unit) and Action.GetToggle(1, "Racial") and A.BurstIsON(unit) then
                return A.BloodFury:Show(icon)
            end
			
            -- berserking
            if A.Berserking:AutoRacial(unit) and Action.GetToggle(1, "Racial") and A.BurstIsON(unit) then
                return A.Berserking:Show(icon)
            end
			
            -- lights_judgment
            if A.LightsJudgment:IsReady(unit) and A.BurstIsON(unit) then
                return A.LightsJudgment:Show(icon)
            end
			
            -- fireblood
            if A.Fireblood:AutoRacial(unit) and Action.GetToggle(1, "Racial") and A.BurstIsON(unit) then
                return A.Fireblood:Show(icon)
            end
			
            -- ancestral_call
            if A.AncestralCall:AutoRacial(unit) and Action.GetToggle(1, "Racial") and A.BurstIsON(unit) then
                return A.AncestralCall:Show(icon)
            end
			
            -- bag_of_tricks
            if A.BagofTricks:AutoRacial(unit) then
                return A.BagofTricks:Show(icon)
            end
			
        end

        --Aoe
        if inCombat and (GetByRange(40, 3, true, false) and A.FreezingRain:IsSpellLearned() or GetByRange(40, 4, true, false)) then
		
            -- frozen_orb
            if A.FrozenOrb:IsReady(player) then
                return A.FrozenOrb:Show(icon)
            end
			
            -- blizzard
            if A.Blizzard:IsReady(player) then
                return A.Blizzard:Show(icon)
            end
			
            -- call_action_list,name=essences
            if Essences(unit) then
                return Essences(unit):Show(icon)
            end
			
            -- comet_storm
            if A.CometStorm:IsReady(unit) then
                return A.CometStorm:Show(icon)
            end
			
            -- ice_nova
            if A.IceNova:IsReady(player) then
                return A.IceNova:Show(icon)
            end
			
            -- flurry,if=prev_gcd.1.ebonbolt|buff.brain_freeze.react&(prev_gcd.1.frostbolt&(buff.icicles.stack<4|!talent.glacial_spike.enabled)|prev_gcd.1.glacial_spike)
            if A.Flurry:IsReadyByPassCastGCD(unit) and 
			(
			    A.LastPlayerCastName == A.Ebonbolt:Info()
				or 
				Unit(player):HasBuffs(A.BrainFreezeBuff.ID, true) > 0 and 
				(
				    A.LastPlayerCastName == A.Frostbolt:Info() and 
					(
					    Unit(player):HasBuffsStacks(A.IciclesBuff.ID, true) < 4 
				        or 
				        not A.GlacialSpike:IsSpellLearned()
					) 
				    or 
				    A.LastPlayerCastName == A.GlacialSpike:Info()
				)
			)
			then
                return A.Flurry:Show(icon)
            end
			
            -- ice_lance,if=buff.fingers_of_frost.react
            if A.IceLance:IsReadyByPassCastGCD(unit) and Unit(player):HasBuffs(A.FingersofFrostBuff.ID, true) > 0 then
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
            if A.ConeofCold:IsReady(player) then
                return A.ConeofCold:Show(icon)
            end
			
            -- use_item,name=tidestorm_codex,if=buff.icy_veins.down&buff.rune_of_power.down
            if A.TidestormCodex:IsReady(unit) and (Unit(player):HasBuffs(A.IcyVeinsBuff.ID, true) == 0 and Unit(player):HasBuffs(A.RuneofPowerBuff.ID, true) == 0) then
                return A.TidestormCodex:Show(icon)
            end
			
            -- use_item,effect_name=cyclotronic_blast,if=buff.icy_veins.down&buff.rune_of_power.down
            if A.CyclotronicBlast:IsReady(unit) and (Unit(player):HasBuffs(A.IcyVeinsBuff.ID, true) == 0 and Unit(player):HasBuffs(A.RuneofPowerBuff.ID, true) == 0) then
                return A.CyclotronicBlast:Show(icon)
            end
			
            -- frostbolt
            if A.Frostbolt:IsReady(unit) then
                return A.Frostbolt:Show(icon)
            end
			
            -- call_action_list,name=movement
            if Movement(unit) then
                return Movement(unit):Show(icon)
            end
			
            -- ice_lance
            if A.IceLance:IsReadyByPassCastGCD(unit) then
                return A.IceLance:Show(icon)
            end
			
        end
	
        -- ice_nova,if=cooldown.ice_nova.ready&debuff.winters_chill.up
        if A.IceNova:IsReady(player) and (A.IceNova:GetCooldown() == 0 and Unit(unit):HasDeBuffs(A.WintersChillDebuff.ID, true) > 0) then
            return A.IceNova:Show(icon)
        end
			
        -- flurry,if=talent.ebonbolt.enabled&prev_gcd.1.ebonbolt&buff.brain_freeze.react
        if A.Flurry:IsReadyByPassCastGCD(unit) and 
		(
		    A.Ebonbolt:IsSpellLearned() and A.LastPlayerCastName == A.Ebonbolt:Info() and Unit(player):HasBuffs(A.BrainFreezeBuff.ID, true) > 0
			or 
			Unit(player):HasBuffs(A.BrainFreezeBuff.ID, true) > 0 and Unit(player):HasBuffsStacks(A.FingersofFrostBuff.ID, true) < 2
		)
		then
            return A.Flurry:Show(icon)
        end
	
        -- flurry,if=prev_gcd.1.glacial_spike&buff.brain_freeze.react
        if A.Flurry:IsReadyByPassCastGCD(unit) and (A.LastPlayerCastName == A.GlacialSpike:Info() and Unit(player):HasBuffs(A.BrainFreezeBuff.ID, true) > 0) then
            return A.Flurry:Show(icon)
        end
			
        -- call_action_list,name=essences
        if Essences(unit) then
            return Essences(unit):Show(icon)
        end
			
        -- frozen_orb
        if A.FrozenOrb:IsReady(player) then
            return A.FrozenOrb:Show(icon)
        end
			
        -- blizzard,if=active_enemies>2|active_enemies>1&!talent.splitting_ice.enabled
        if A.Blizzard:IsReady(player) and (GetByRange(2, 35, true, false) or GetByRange(1, 35, true, false) and not A.SplittingIce:IsSpellLearned()) then
            return A.Blizzard:Show(icon)
        end
			
        -- comet_storm
        if A.CometStorm:IsReady(unit) then
            return A.CometStorm:Show(icon)
        end
			
        -- ebonbolt,if=buff.icicles.stack=5&!buff.brain_freeze.react
        if A.Ebonbolt:IsReady(unit) and (Unit(player):HasBuffsStacks(A.IciclesBuff.ID, true) == 5 and Unit(player):HasBuffs(A.BrainFreezeBuff.ID, true) == 0) then
            return A.Ebonbolt:Show(icon)
        end

        -- ice_lance,if=buff.brain_freeze.react&(buff.fingers_of_frost.react|prev_gcd.1.flurry)&(buff.icicles.max_stack-buff.icicles.stack)*action.frostbolt.execute_time+action.glacial_spike.cast_time+action.glacial_spike.travel_time<incanters_flow_time_to.5.any
        if A.IceLance:IsReadyByPassCastGCD(unit) and 
		(
		    Unit(player):HasBuffs(A.BrainFreezeBuff.ID, true) > 0 and 
			(
			    Unit(player):HasBuffs(A.FingersofFrostBuff.ID, true) > 0
				or 
				A.LastPlayerCastName == A.Flurry:Info()
		    ) 
			and (5 - Unit(player):HasBuffs(A.IciclesBuff.ID, true)) * A.Frostbolt:GetSpellCastTime() + A.GlacialSpike:GetSpellCastTime() + A.GlacialSpike:TravelTime() < IFTimeToX(5, "any")
		)
		then
            return A.IceLance:Show(icon)
        end			
		
		-- glacial_spike,if=buff.brain_freeze.react|prev_gcd.1.ebonbolt|talent.incanters_flow.enabled&cast_time+travel_time>incanters_flow_time_to.5.up&cast_time+travel_time<incanters_flow_time_to.4.down
	    if A.GlacialSpike:IsReady(unit) and 
	    (
	       Unit(player):HasBuffs(A.BrainFreezeBuff.ID, true) > 0 
		   or  
		   A.LastPlayerCastName == A.Ebonbolt:Info() 
		   or 
		   A.IncantersFlow:IsSpellLearned() and A.GlacialSpike:GetSpellCastTime() + A.GlacialSpike:TravelTime() > IFTimeToX(5, "up") and A.GlacialSpike:GetSpellCastTime() and A.GlacialSpike:TravelTime() < IFTimeToX(4, "down")
		)
		then
            return A.GlacialSpike:Show(icon)
        end
	   
        -- ice_nova
        if A.IceNova:IsReady(player) then
            return A.IceNova:Show(icon)
        end
			
        -- use_item,name=tidestorm_codex,if=buff.icy_veins.down&buff.rune_of_power.down
        if A.TidestormCodex:IsReady(unit) and (Unit(player):HasBuffs(A.IcyVeinsBuff.ID, true) == 0 and Unit(player):HasBuffs(A.RuneofPowerBuff.ID, true) == 0) then
            return A.TidestormCodex:Show(icon)
        end
			
        -- use_item,effect_name=cyclotronic_blast,if=buff.icy_veins.down&buff.rune_of_power.down
        if A.CyclotronicBlast:IsReady(unit) and (Unit(player):HasBuffs(A.IcyVeinsBuff.ID, true) == 0 and Unit(player):HasBuffs(A.RuneofPowerBuff.ID, true) == 0) then
            return A.CyclotronicBlast:Show(icon)
        end
		
        -- Manual addition of Ice Lance with FoF proc if not using Glacial Spike
        if A.IceLance:IsReadyByPassCastGCD(unit) and 
		(
		    (not A.GlacialSpike:IsSpellLearned() and Unit(player):HasBuffs(A.FingersofFrostBuff.ID, true) > 0) 
			or 
			A.LastPlayerCastName == A.Flurry:Info()
			or
			Unit(player):HasBuffsStacks(A.FingersofFrostBuff.ID, true) >= 2
		)
		then
            return A.IceLance:Show(icon)
        end	
	
        -- frostbolt
        if A.Frostbolt:IsReady(unit) then
            return A.Frostbolt:Show(icon)
        end	
		
        -- call_action_list,name=movement
        if Movement(unit) then
            return Movement(unit):Show(icon)
        end
			
        -- ice_lance
     --   if A.IceLance:IsReady(unit) then
    --       return A.IceLance:Show(icon)
     --   end
			
		
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

