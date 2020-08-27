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

Action[ACTION_CONST_MAGE_ARCANE] = {
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
    ArcaneFamiliarBuff                     = Create({ Type = "Spell", ID = 210126 }),
    ArcaneFamiliar                         = Create({ Type = "Spell", ID = 205022 }),
    Equipoise                              = Create({ Type = "Spell", ID = 286027 }),
    ArcaneBlast                            = Create({ Type = "Spell", ID = 30451 }),
    Evocation                              = Create({ Type = "Spell", ID = 12051 }),
    ChargedUp                              = Create({ Type = "Spell", ID = 205032 }),
    ArcaneChargeBuff                       = Create({ Type = "Spell", ID = 36032 }),
    NetherTempest                          = Create({ Type = "Spell", ID = 114923 }),
    NetherTempestDebuff                    = Create({ Type = "Spell", ID = 114923 }),
    RuneofPowerBuff                        = Create({ Type = "Spell", ID = 116014 }),
    ArcanePowerBuff                        = Create({ Type = "Spell", ID = 12042 }),
    RuleofThreesBuff                       = Create({ Type = "Spell", ID = 264774 }),
    Overpowered                            = Create({ Type = "Spell", ID = 155147 }),
    LightsJudgment                         = Create({ Type = "Spell", ID = 255647 }),
    BagofTricks                            = Create({ Type = "Spell", ID =  }),
    RuneofPower                            = Create({ Type = "Spell", ID = 116011 }),
    ArcanePower                            = Create({ Type = "Spell", ID = 12042 }),
    Berserking                             = Create({ Type = "Spell", ID = 26297 }),
    BloodFury                              = Create({ Type = "Spell", ID = 20572 }),
    Fireblood                              = Create({ Type = "Spell", ID = 265221 }),
    AncestralCall                          = Create({ Type = "Spell", ID = 274738 }),
    PresenceofMind                         = Create({ Type = "Spell", ID = 205025 }),
    PresenceofMindBuff                     = Create({ Type = "Spell", ID = 205025 }),
    BerserkingBuff                         = Create({ Type = "Spell", ID = 26297 }),
    BloodFuryBuff                          = Create({ Type = "Spell", ID = 20572 }),
    GuardianofAzerothBuff                  = Create({ Type = "Spell", ID =  }),
    ArcaneOrb                              = Create({ Type = "Spell", ID = 153626 }),
    Resonance                              = Create({ Type = "Spell", ID = 205028 }),
    ArcaneBarrage                          = Create({ Type = "Spell", ID = 44425 }),
    ArcaneExplosion                        = Create({ Type = "Spell", ID = 1449 }),
    ArcaneMissiles                         = Create({ Type = "Spell", ID = 5143 }),
    ClearcastingBuff                       = Create({ Type = "Spell", ID = 263725 }),
    Amplification                          = Create({ Type = "Spell", ID = 236628 }),
    ArcanePummeling                        = Create({ Type = "Spell", ID = 270669 }),
    Supernova                              = Create({ Type = "Spell", ID = 157980 }),
    BloodoftheEnemyBuff                    = Create({ Type = "Spell", ID = 297108 }),
    ReapingFlames                          = Create({ Type = "Spell", ID =  }),
    BlinkAny                               = Create({ Type = "Spell", ID =  })
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
Action:CreateEssencesFor(ACTION_CONST_MAGE_ARCANE)  -- where PLAYERSPEC is Constance (example: ACTION_CONST_MONK_BM)
local A = setmetatable(Action[ACTION_CONST_MAGE_ARCANE], { __index = Action })


------------------------------------------
---------------- VARIABLES ---------------
------------------------------------------
local VarConserveMana = 0;
local VarFontDoubleOnUse = 0;
local VarFontofPowerPrecombatChannel = 0;
local VarTotalBurns = 0;
local VarAverageBurnLength = 0;

A.Listener:Add("ROTATION_VARS", "PLAYER_REGEN_ENABLED", function()
  VarConserveMana = 0
  VarFontDoubleOnUse = 0
  VarFontofPowerPrecombatChannel = 0
  VarTotalBurns = 0
  VarAverageBurnLength = 0
end)



local function num(val)
    if val then return 1 else return 0 end
end

local function bool(val)
    return val ~= 0
end

------------------------------------------
--------- ARCANE PRE APL SETUP -----------
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
	return LoC:IsMissed("SILENCE") and LoC:Get("SCHOOL_INTERRUPT", "ARCANE") == 0
end 

local function InRange(unit)
	-- @return boolean 
	return A.ArcaneBlast:IsInRange(unit)
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


-- [1] CC AntiFake Rotation (FOCUS)
A[1] = function(icon)    
    local unit = "focus"
    local totalPoly = Unit("player"):CastTime(118) + GetCurrentGCD()
	local totalRoF = Unit("player"):CastTime(113724) + GetCurrentGCD()
	
    if A.PolymorphGreen:IsReady(nil, nil, nil, true) and 
    (
        IsUnitEnemy("focus") and
        A.Polymorph:IsInRange("focus") and
        -- Bear Form, Cat Form, Moonkin Form, Travel Form
        Unit("focus"):HasBuffs({5487, 768, 24858, 783}, true) == 0 and
        Unit(unit):HasBuffs("TotalImun") <= totalPoly and
        Unit(unit):HasBuffs("CCMagicImun") <= totalPoly and
        Unit(unit):HasBuffs("Reflect") <= totalPoly
    )
    then 
        return A.PolymorphGreen:Show(icon)         
    end     

    if A.RingofFrost:IsReady(nil, nil, nil, true) and 
    (
        IsUnitEnemy("focus") and
        A.RingofFrost:IsSpellLearned() and 
        A.Polymorph:IsInRange("focus") and
        (    
            -- Bear Form, Cat Form, Moonkin Form, Travel Form
            Unit("focus"):HasBuffs({5487, 768, 24858, 783}, true) > 0 or
            Unit(unit):HasBuffs("Reflect") > 0
        ) and
        Unit(unit):HasBuffs("TotalImun") <= totalRoF and
        Unit(unit):HasBuffs("CCMagicImun") <= totalRoF
    )
    then 
        return A.RingofFrost:Show(icon)         
    end   
	
end

-- [2] Kick AntiFake Rotation
A[2] = function(icon)        
    local unit
    if A.IsUnitEnemy("mouseover") then 
        unit = "mouseover"
    elseif A.IsUnitEnemy("target") then 
        unit = "target"
    end 
    
    if unit then         
        local castLeft, _, _, _, notKickAble = Unit(unit):IsCastingRemains()
        if castLeft > 0 then             
            if not notKickAble and A.CounterSpell:IsReady(unit, nil, nil, true) and A.CounterSpell:AbsentImun(unit, Temp.TotalAndMag, true) then
                return A.CounterSpell:Show(icon)                                                  
            end 
            
            -- Racials 
            if A.QuakingPalm:IsRacialReadyP(unit, nil, nil, true) then 
                return A.QuakingPalm:Show(icon)
            end 
            
            if A.Haymaker:IsRacialReadyP(unit, nil, nil, true) then 
                return A.Haymaker:Show(icon)
            end 
            
            if A.WarStomp:IsRacialReadyP(unit, nil, nil, true) then 
                return A.WarStomp:Show(icon)
            end 
            
            if A.BullRush:IsRacialReadyP(unit, nil, nil, true) then 
                return A.BullRush:Show(icon)
            end                         
        end 
    end                                                                                 
end

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

local function SelfDefensives()
    if Unit(player):CombatTime() == 0 then 
        return 
    end 
    
    local unit
    if A.IsUnitEnemy("mouseover") then 
        unit = "mouseover"
    elseif A.IsUnitEnemy("target") then 
        unit = "target"
    end  
		
    -- TemporalShield
    if A.TemporalShield:IsReady(player) and 
    Unit(player):CombatTime() > 0 and
    A.TemporalShield:IsSpellLearned() and
    Unit(player):HasBuffs(198111, true)==0 and
    (
        (                
            FriendlyTeam("HEALER"):GetCC() > 0 and
            Unit(player):IsFocused() and
            Unit(player):Health() <= Unit(player):Health()*0.7 and
            Unit(player):TimeToDie()<13        
        ) or    
        Unit(player):UseDeff()
    )
    then 
        return A.TemporalShield
    end 
   
    -- Stoneform on self dispel (only PvE)
    if A.Stoneform:IsRacialReady(player, true) and not A.IsInPvP and A.AuraIsValid(player, "UseDispel", "Dispel") then 
        return A.Stoneform
    end 		
end 
SelfDefensives = A.MakeFunctionCachedDynamic(SelfDefensives)


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

Player.ArcaneBurnPhase = {}
local BurnPhase = Player.ArcaneBurnPhase

function BurnPhase:Reset()
    self.state = false
    self.last_start = TMW.time
    self.last_stop = TMW.time
end
BurnPhase:Reset()

function BurnPhase:Start()
    if Unit("player"):CombatTime() > 0 then
        self.state = true
        self.last_start = TMW.time
    end
end

function BurnPhase:Stop()
    self.state = false
    self.last_stop = TMW.time
end

function BurnPhase:On()
    return self.state or 
	(
	    Unit("player"):CombatTime() == 0 and 
	    (
		    (
			    A.ArcanePower:GetCooldown() == 0 and A.Evocation:GetCooldown() <= VarAverageBurnLength and 
				(
				    Player:ArcaneChargesP() == Player:ArcaneChargesMax() 
					or 
					(A.ChargedUp:IsSpellLearned() and A.ChargedUp:GetCooldown() == 0)
				)
			)
		)
	)	
end

function BurnPhase:Duration()
    return self.state and (TMW.time - self.last_start) or 0
end

A.Listener:Add("ROTATION_VARS", "PLAYER_REGEN_DISABLED", function()
    BurnPhase:Reset()
end)

local function PresenceOfMindMax()
    return 2
end

local function ArcaneMissilesProcMax()
    return 3
end

function Player:ArcaneChargesP()
    return math.min(self:ArcaneCharges() + num(Unit("player"):IsCasting(A.ArcaneBlast)), 4)
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
            
            -- arcane_familiar
            if A.ArcaneFamiliar:IsReady(unit) and Unit("player"):HasBuffsDown(A.ArcaneFamiliarBuff.ID, true) then
                return A.ArcaneFamiliar:Show(icon)
            end
            
            -- variable,name=conserve_mana,op=set,value=60+20*azerite.equipoise.enabled
            VarConserveMana = 60 + 20 * A.Equipoise:GetAzeriteRank() > 0
            
            -- variable,name=font_double_on_use,op=set,value=equipped.azsharas_font_of_power&(equipped.manifesto_of_madness|equipped.gladiators_badge|equipped.gladiators_medallion|equipped.ignition_mages_fuse|equipped.tzanes_barkspines|equipped.azurethos_singed_plumage|equipped.ancient_knot_of_wisdom|equipped.shockbiters_fang|equipped.neural_synapse_enhancer|equipped.balefire_branch)
            VarFontDoubleOnUse = num(A.AzsharasFontofPower:IsExists() and (A.ManifestoofMadness:IsExists() or A.GladiatorsBadge:IsExists() or A.GladiatorsMedallion:IsExists() or A.IgnitionMagesFuse:IsExists() or A.TzanesBarkspines:IsExists() or A.AzurethosSingedPlumage:IsExists() or A.AncientKnotofWisdom:IsExists() or A.ShockbitersFang:IsExists() or A.NeuralSynapseEnhancer:IsExists() or A.BalefireBranch:IsExists()))
            
            -- variable,name=font_of_power_precombat_channel,op=set,value=12,if=variable.font_double_on_use&variable.font_of_power_precombat_channel=0
            if (VarFontDoubleOnUse and VarFontofPowerPrecombatChannel == 0) then
                VarFontofPowerPrecombatChannel = 12
            end
            
            -- snapshot_stats
            -- use_item,name=azsharas_font_of_power
            if A.AzsharasFontofPower:IsReady(unit) then
                return A.AzsharasFontofPower:Show(icon)
            end
            
            -- potion
            if A.PotionofSpectralIntellect:IsReady(unit) and Potion then
                return A.PotionofSpectralIntellect:Show(icon)
            end
            
            -- arcane_blast
            if A.ArcaneBlast:IsReady(unit) then
                return A.ArcaneBlast:Show(icon)
            end
            
        end
        
        --Burn
        local function Burn(unit)
        
            -- variable,name=total_burns,op=add,value=1,if=!burn_phase
            if (not BurnPhase:On()) then
                VarTotalBurns = VarTotalBurns + 1
            end
            
            -- start_burn_phase,if=!burn_phase
            if (not BurnPhase:On()) then
                BurnPhase:Start
            end
            
            -- stop_burn_phase,if=burn_phase&prev_gcd.1.evocation&target.time_to_die>variable.average_burn_length&burn_phase_duration>0
            if (BurnPhase:On() and Player:PrevGCD(1, A.Evocation) and Unit(unit):TimeToDie() > VarAverageBurnLength and BurnPhase:Duration() > 0) then
                BurnPhase:Stop
            end
            
            -- charged_up,if=buff.arcane_charge.stack<=1
            if A.ChargedUp:IsReady(unit) and (Unit("player"):ArcaneChargesP <= 1) then
                return A.ChargedUp:Show(icon)
            end
            
            -- nether_tempest,if=(refreshable|!ticking)&buff.arcane_charge.stack=buff.arcane_charge.max_stack&buff.rune_of_power.down&buff.arcane_power.down
            if A.NetherTempest:IsReady(unit) and ((Unit(unit):HasDeBuffsRefreshable(A.NetherTempestDebuff.ID, true) or not Unit(unit):HasDeBuffs(A.NetherTempestDebuff.ID, true)) and Unit("player"):ArcaneChargesP == Unit("player"):ArcaneChargesMax and Unit("player"):HasBuffsDown(A.RuneofPowerBuff.ID, true) and Unit("player"):HasBuffsDown(A.ArcanePowerBuff.ID, true)) then
                return A.NetherTempest:Show(icon)
            end
            
            -- arcane_blast,if=buff.rule_of_threes.up&talent.overpowered.enabled&active_enemies<3
            if A.ArcaneBlast:IsReady(unit) and (Unit("player"):HasBuffs(A.RuleofThreesBuff.ID, true) and A.Overpowered:IsSpellLearned() and MultiUnits:GetByRangeInCombat(40, 5, 10) < 3) then
                return A.ArcaneBlast:Show(icon)
            end
            
            -- lights_judgment,if=buff.arcane_power.down
            if A.LightsJudgment:IsReady(unit) and A.BurstIsON(unit) and (Unit("player"):HasBuffsDown(A.ArcanePowerBuff.ID, true)) then
                return A.LightsJudgment:Show(icon)
            end
            
            -- bag_of_tricks,if=buff.arcane_power.down
            if A.BagofTricks:IsReady(unit) and (Unit("player"):HasBuffsDown(A.ArcanePowerBuff.ID, true)) then
                return A.BagofTricks:Show(icon)
            end
            
            -- rune_of_power,if=buff.rune_of_power.down&!buff.arcane_power.up&(mana.pct>=50|cooldown.arcane_power.remains=0)&(buff.arcane_charge.stack=buff.arcane_charge.max_stack)
            if A.RuneofPower:IsReady(unit) and (Unit("player"):HasBuffsDown(A.RuneofPowerBuff.ID, true) and not Unit("player"):HasBuffs(A.ArcanePowerBuff.ID, true) and (Player:ManaPercentageP() >= 50 or A.ArcanePower:GetCooldown() == 0) and (Unit("player"):ArcaneChargesP == Unit("player"):ArcaneChargesMax)) then
                return A.RuneofPower:Show(icon)
            end
            
            -- berserking
            if A.Berserking:AutoRacial(unit) and Racial and A.BurstIsON(unit) then
                return A.Berserking:Show(icon)
            end
            
            -- arcane_power
            if A.ArcanePower:IsReady(unit) and A.BurstIsON(unit) then
                return A.ArcanePower:Show(icon)
            end
            
            -- use_items,if=buff.arcane_power.up|target.time_to_die<cooldown.arcane_power.remains
            -- blood_fury
            if A.BloodFury:AutoRacial(unit) and Racial and A.BurstIsON(unit) then
                return A.BloodFury:Show(icon)
            end
            
            -- fireblood
            if A.Fireblood:AutoRacial(unit) and Racial and A.BurstIsON(unit) then
                return A.Fireblood:Show(icon)
            end
            
            -- ancestral_call
            if A.AncestralCall:AutoRacial(unit) and Racial and A.BurstIsON(unit) then
                return A.AncestralCall:Show(icon)
            end
            
            -- presence_of_mind,if=(talent.rune_of_power.enabled&buff.rune_of_power.remains<=buff.presence_of_mind.max_stack*action.arcane_blast.execute_time)|buff.arcane_power.remains<=buff.presence_of_mind.max_stack*action.arcane_blast.execute_time
            if A.PresenceofMind:IsReady(unit) and A.BurstIsON(unit) and ((A.RuneofPower:IsSpellLearned() and Unit("player"):HasBuffs(A.RuneofPowerBuff.ID, true) <= PresenceOfMindMax * A.ArcaneBlast:GetSpellCastTime()) or Unit("player"):HasBuffs(A.ArcanePowerBuff.ID, true) <= PresenceOfMindMax * A.ArcaneBlast:GetSpellCastTime()) then
                return A.PresenceofMind:Show(icon)
            end
            
            -- potion,if=buff.arcane_power.up&((!essence.condensed_lifeforce.major|essence.condensed_lifeforce.rank<2)&(buff.berserking.up|buff.blood_fury.up|!(race.troll|race.orc))|buff.guardian_of_azeroth.up)|target.time_to_die<cooldown.arcane_power.remains
            if A.PotionofSpectralIntellect:IsReady(unit) and Potion and (Unit("player"):HasBuffs(A.ArcanePowerBuff.ID, true) and ((not Azerite:EssenceHasMajor(A.CondensedLifeforce.ID) or A.CondensedLifeforce:GetAzeriteRank() < 2) and (Unit("player"):HasBuffs(A.BerserkingBuff.ID, true) or Unit("player"):HasBuffs(A.BloodFuryBuff.ID, true) or not (Unit("player"):IsRace("Troll") or Unit("player"):IsRace("Orc"))) or Unit("player"):HasBuffs(A.GuardianofAzerothBuff.ID, true)) or Unit(unit):TimeToDie() < A.ArcanePower:GetCooldown()) then
                return A.PotionofSpectralIntellect:Show(icon)
            end
            
            -- arcane_orb,if=buff.arcane_charge.stack=0|(active_enemies<3|(active_enemies<2&talent.resonance.enabled))
            if A.ArcaneOrb:IsReady(unit) and (Unit("player"):ArcaneChargesP == 0 or (MultiUnits:GetByRangeInCombat(40, 5, 10) < 3 or (MultiUnits:GetByRangeInCombat(40, 5, 10) < 2 and A.Resonance:IsSpellLearned()))) then
                return A.ArcaneOrb:Show(icon)
            end
            
            -- arcane_barrage,if=active_enemies>=3&(buff.arcane_charge.stack=buff.arcane_charge.max_stack)
            if A.ArcaneBarrage:IsReady(unit) and (MultiUnits:GetByRangeInCombat(40, 5, 10) >= 3 and (Unit("player"):ArcaneChargesP == Unit("player"):ArcaneChargesMax)) then
                return A.ArcaneBarrage:Show(icon)
            end
            
            -- arcane_explosion,if=active_enemies>=3
            if A.ArcaneExplosion:IsReady(unit) and (MultiUnits:GetByRangeInCombat(10, 5, 10) >= 3) then
                return A.ArcaneExplosion:Show(icon)
            end
            
            -- arcane_missiles,if=buff.clearcasting.react&active_enemies<3&(talent.amplification.enabled|(!talent.overpowered.enabled&azerite.arcane_pummeling.rank>=2)|buff.arcane_power.down),chain=1
            if A.ArcaneMissiles:IsReady(unit) and (Unit("player"):HasBuffsStacks(A.ClearcastingBuff.ID, true) and MultiUnits:GetByRangeInCombat(40, 5, 10) < 3 and (A.Amplification:IsSpellLearned() or (not A.Overpowered:IsSpellLearned() and A.ArcanePummeling:GetAzeriteRank() >= 2) or Unit("player"):HasBuffsDown(A.ArcanePowerBuff.ID, true))) then
                return A.ArcaneMissiles:Show(icon)
            end
            
            -- arcane_blast,if=active_enemies<3
            if A.ArcaneBlast:IsReady(unit) and (MultiUnits:GetByRangeInCombat(40, 5, 10) < 3) then
                return A.ArcaneBlast:Show(icon)
            end
            
            -- variable,name=average_burn_length,op=set,value=(variable.average_burn_length*variable.total_burns-variable.average_burn_length+(burn_phase_duration))%variable.total_burns
            VarAverageBurnLength = (VarAverageBurnLength * VarTotalBurns - VarAverageBurnLength + (BurnPhase:Duration())) / VarTotalBurns
            
            -- evocation,interrupt_if=mana.pct>=85,interrupt_immediate=1
            if A.Evocation:IsReady(unit) then
                return A.Evocation:Show(icon)
            end
            
            -- arcane_barrage
            if A.ArcaneBarrage:IsReady(unit) then
                return A.ArcaneBarrage:Show(icon)
            end
            
        end
        
        --Conserve
        local function Conserve(unit)
        
            -- charged_up,if=buff.arcane_charge.stack=0
            if A.ChargedUp:IsReady(unit) and (Unit("player"):ArcaneChargesP == 0) then
                return A.ChargedUp:Show(icon)
            end
            
            -- nether_tempest,if=(refreshable|!ticking)&buff.arcane_charge.stack=buff.arcane_charge.max_stack&buff.rune_of_power.down&buff.arcane_power.down
            if A.NetherTempest:IsReady(unit) and ((Unit(unit):HasDeBuffsRefreshable(A.NetherTempestDebuff.ID, true) or not Unit(unit):HasDeBuffs(A.NetherTempestDebuff.ID, true)) and Unit("player"):ArcaneChargesP == Unit("player"):ArcaneChargesMax and Unit("player"):HasBuffsDown(A.RuneofPowerBuff.ID, true) and Unit("player"):HasBuffsDown(A.ArcanePowerBuff.ID, true)) then
                return A.NetherTempest:Show(icon)
            end
            
            -- arcane_orb,if=buff.arcane_charge.stack<=2&(cooldown.arcane_power.remains>10|active_enemies<=2)
            if A.ArcaneOrb:IsReady(unit) and (Unit("player"):ArcaneChargesP <= 2 and (A.ArcanePower:GetCooldown() > 10 or MultiUnits:GetByRangeInCombat(40, 5, 10) <= 2)) then
                return A.ArcaneOrb:Show(icon)
            end
            
            -- arcane_blast,if=buff.rule_of_threes.up&buff.arcane_charge.stack>3
            if A.ArcaneBlast:IsReady(unit) and (Unit("player"):HasBuffs(A.RuleofThreesBuff.ID, true) and Unit("player"):ArcaneChargesP > 3) then
                return A.ArcaneBlast:Show(icon)
            end
            
            -- use_item,name=tidestorm_codex,if=buff.rune_of_power.down&!buff.arcane_power.react&cooldown.arcane_power.remains>20
            if A.TidestormCodex:IsReady(unit) and (Unit("player"):HasBuffsDown(A.RuneofPowerBuff.ID, true) and not Unit("player"):HasBuffsStacks(A.ArcanePowerBuff.ID, true) and A.ArcanePower:GetCooldown() > 20) then
                return A.TidestormCodex:Show(icon)
            end
            
            -- use_item,effect_name=cyclotronic_blast,if=buff.rune_of_power.down&!buff.arcane_power.react&cooldown.arcane_power.remains>20
            if A.CyclotronicBlast:IsReady(unit) and (Unit("player"):HasBuffsDown(A.RuneofPowerBuff.ID, true) and not Unit("player"):HasBuffsStacks(A.ArcanePowerBuff.ID, true) and A.ArcanePower:GetCooldown() > 20) then
                return A.CyclotronicBlast:Show(icon)
            end
            
            -- rune_of_power,if=buff.rune_of_power.down&buff.arcane_charge.stack=buff.arcane_charge.max_stack&(full_recharge_time<=execute_time|full_recharge_time<=cooldown.arcane_power.remains|target.time_to_die<=cooldown.arcane_power.remains)
            if A.RuneofPower:IsReady(unit) and (Unit("player"):HasBuffsDown(A.RuneofPowerBuff.ID, true) and Unit("player"):ArcaneChargesP == Unit("player"):ArcaneChargesMax and (A.RuneofPower:GetSpellChargesFullRechargeTime() <= A.RuneofPower:GetSpellCastTime() or A.RuneofPower:GetSpellChargesFullRechargeTime() <= A.ArcanePower:GetCooldown() or Unit(unit):TimeToDie() <= A.ArcanePower:GetCooldown())) then
                return A.RuneofPower:Show(icon)
            end
            
            -- arcane_missiles,if=mana.pct<=95&buff.clearcasting.react&active_enemies<3,chain=1
            if A.ArcaneMissiles:IsReady(unit) and (Player:ManaPercentageP() <= 95 and Unit("player"):HasBuffsStacks(A.ClearcastingBuff.ID, true) and MultiUnits:GetByRangeInCombat(40, 5, 10) < 3) then
                return A.ArcaneMissiles:Show(icon)
            end
            
            -- arcane_barrage,if=((buff.arcane_charge.stack=buff.arcane_charge.max_stack)&((mana.pct<=variable.conserve_mana)|(talent.rune_of_power.enabled&cooldown.arcane_power.remains>cooldown.rune_of_power.full_recharge_time&mana.pct<=variable.conserve_mana+25))|(talent.arcane_orb.enabled&cooldown.arcane_orb.remains<=gcd&cooldown.arcane_power.remains>10))|mana.pct<=(variable.conserve_mana-10)
            if A.ArcaneBarrage:IsReady(unit) and (((Unit("player"):ArcaneChargesP == Unit("player"):ArcaneChargesMax) and ((Player:ManaPercentageP() <= VarConserveMana) or (A.RuneofPower:IsSpellLearned() and A.ArcanePower:GetCooldown() > A.RuneofPower:FullRechargeTimeP() and Player:ManaPercentageP() <= VarConserveMana + 25)) or (A.ArcaneOrb:IsSpellLearned() and A.ArcaneOrb:GetCooldown() <= GetGCD() and A.ArcanePower:GetCooldown() > 10)) or Player:ManaPercentageP() <= (VarConserveMana - 10)) then
                return A.ArcaneBarrage:Show(icon)
            end
            
            -- supernova,if=mana.pct<=95
            if A.Supernova:IsReady(unit) and (Player:ManaPercentageP() <= 95) then
                return A.Supernova:Show(icon)
            end
            
            -- arcane_explosion,if=active_enemies>=3&(mana.pct>=variable.conserve_mana|buff.arcane_charge.stack=3)
            if A.ArcaneExplosion:IsReady(unit) and (MultiUnits:GetByRangeInCombat(10, 5, 10) >= 3 and (Player:ManaPercentageP() >= VarConserveMana or Unit("player"):ArcaneChargesP == 3)) then
                return A.ArcaneExplosion:Show(icon)
            end
            
            -- arcane_blast
            if A.ArcaneBlast:IsReady(unit) then
                return A.ArcaneBlast:Show(icon)
            end
            
            -- arcane_barrage
            if A.ArcaneBarrage:IsReady(unit) then
                return A.ArcaneBarrage:Show(icon)
            end
            
        end
        
        --Essences
        local function Essences(unit)
        
            -- blood_of_the_enemy,if=burn_phase&buff.arcane_power.down&buff.rune_of_power.down&buff.arcane_charge.stack=buff.arcane_charge.max_stack|time_to_die<cooldown.arcane_power.remains
            if A.BloodoftheEnemy:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and (BurnPhase:On() and Unit("player"):HasBuffsDown(A.ArcanePowerBuff.ID, true) and Unit("player"):HasBuffsDown(A.RuneofPowerBuff.ID, true) and Unit("player"):ArcaneChargesP == Unit("player"):ArcaneChargesMax or Unit(unit):TimeToDie() < A.ArcanePower:GetCooldown()) then
                return A.BloodoftheEnemy:Show(icon)
            end
            
            -- concentrated_flame,line_cd=6,if=buff.rune_of_power.down&buff.arcane_power.down&(!burn_phase|time_to_die<cooldown.arcane_power.remains)&mana.time_to_max>=execute_time
            if A.ConcentratedFlame:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and (Unit("player"):HasBuffsDown(A.RuneofPowerBuff.ID, true) and Unit("player"):HasBuffsDown(A.ArcanePowerBuff.ID, true) and (not BurnPhase:On() or Unit(unit):TimeToDie() < A.ArcanePower:GetCooldown()) and Player:ManaTimeToMaxPredicted() >= A.ConcentratedFlame:GetSpellCastTime()) then
                return A.ConcentratedFlame:Show(icon)
            end
            
            -- reaping_flames,if=buff.rune_of_power.down&buff.arcane_power.down&(!burn_phase|time_to_die<cooldown.arcane_power.remains)&mana.time_to_max>=execute_time
            if A.ReapingFlames:IsReady(unit) and (Unit("player"):HasBuffsDown(A.RuneofPowerBuff.ID, true) and Unit("player"):HasBuffsDown(A.ArcanePowerBuff.ID, true) and (not BurnPhase:On() or Unit(unit):TimeToDie() < A.ArcanePower:GetCooldown()) and Player:ManaTimeToMaxPredicted() >= A.ReapingFlames:GetSpellCastTime()) then
                return A.ReapingFlames:Show(icon)
            end
            
            -- focused_azerite_beam,if=buff.rune_of_power.down&buff.arcane_power.down
            if A.FocusedAzeriteBeam:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and (Unit("player"):HasBuffsDown(A.RuneofPowerBuff.ID, true) and Unit("player"):HasBuffsDown(A.ArcanePowerBuff.ID, true)) then
                return A.FocusedAzeriteBeam:Show(icon)
            end
            
            -- guardian_of_azeroth,if=buff.rune_of_power.down&buff.arcane_power.down
            if A.GuardianofAzeroth:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and (Unit("player"):HasBuffsDown(A.RuneofPowerBuff.ID, true) and Unit("player"):HasBuffsDown(A.ArcanePowerBuff.ID, true)) then
                return A.GuardianofAzeroth:Show(icon)
            end
            
            -- purifying_blast,if=buff.rune_of_power.down&buff.arcane_power.down
            if A.PurifyingBlast:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and (Unit("player"):HasBuffsDown(A.RuneofPowerBuff.ID, true) and Unit("player"):HasBuffsDown(A.ArcanePowerBuff.ID, true)) then
                return A.PurifyingBlast:Show(icon)
            end
            
            -- ripple_in_space,if=buff.rune_of_power.down&buff.arcane_power.down
            if A.RippleInSpace:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and (Unit("player"):HasBuffsDown(A.RuneofPowerBuff.ID, true) and Unit("player"):HasBuffsDown(A.ArcanePowerBuff.ID, true)) then
                return A.RippleInSpace:Show(icon)
            end
            
            -- the_unbound_force,if=buff.rune_of_power.down&buff.arcane_power.down
            if A.TheUnboundForce:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and (Unit("player"):HasBuffsDown(A.RuneofPowerBuff.ID, true) and Unit("player"):HasBuffsDown(A.ArcanePowerBuff.ID, true)) then
                return A.TheUnboundForce:Show(icon)
            end
            
            -- memory_of_lucid_dreams,if=!burn_phase&buff.arcane_power.down&cooldown.arcane_power.remains&buff.arcane_charge.stack=buff.arcane_charge.max_stack&(!talent.rune_of_power.enabled|action.rune_of_power.charges)|time_to_die<cooldown.arcane_power.remains
            if A.MemoryofLucidDreams:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and (not BurnPhase:On() and Unit("player"):HasBuffsDown(A.ArcanePowerBuff.ID, true) and A.ArcanePower:GetCooldown() and Unit("player"):ArcaneChargesP == Unit("player"):ArcaneChargesMax and (not A.RuneofPower:IsSpellLearned() or A.RuneofPower:GetSpellCharges()) or Unit(unit):TimeToDie() < A.ArcanePower:GetCooldown()) then
                return A.MemoryofLucidDreams:Show(icon)
            end
            
            -- worldvein_resonance,if=burn_phase&buff.arcane_power.down&buff.rune_of_power.down&buff.arcane_charge.stack=buff.arcane_charge.max_stack|time_to_die<cooldown.arcane_power.remains
            if A.WorldveinResonance:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and (BurnPhase:On() and Unit("player"):HasBuffsDown(A.ArcanePowerBuff.ID, true) and Unit("player"):HasBuffsDown(A.RuneofPowerBuff.ID, true) and Unit("player"):ArcaneChargesP == Unit("player"):ArcaneChargesMax or Unit(unit):TimeToDie() < A.ArcanePower:GetCooldown()) then
                return A.WorldveinResonance:Show(icon)
            end
            
        end
        
        --Movement
        local function Movement(unit)
        
            -- blink_any,if=movement.distance>=10
            if A.BlinkAny:IsReady(unit) and (Unit(unit):GetRange() >= 10) then
                return A.BlinkAny:Show(icon)
            end
            
            -- presence_of_mind
            if A.PresenceofMind:IsReady(unit) and A.BurstIsON(unit) then
                return A.PresenceofMind:Show(icon)
            end
            
            -- arcane_missiles
            if A.ArcaneMissiles:IsReady(unit) then
                return A.ArcaneMissiles:Show(icon)
            end
            
            -- arcane_orb
            if A.ArcaneOrb:IsReady(unit) then
                return A.ArcaneOrb:Show(icon)
            end
            
            -- supernova
            if A.Supernova:IsReady(unit) then
                return A.Supernova:Show(icon)
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
            -- call_action_list,name=essences
            if Essences(unit) then
                return true
            end
            
            -- use_item,name=azsharas_font_of_power,if=buff.rune_of_power.down&buff.arcane_power.down&(cooldown.arcane_power.remains<=4+10*variable.font_double_on_use&cooldown.evocation.remains<=variable.average_burn_length+4+10*variable.font_double_on_use|time_to_die<cooldown.arcane_power.remains)
            if A.AzsharasFontofPower:IsReady(unit) and (Unit("player"):HasBuffsDown(A.RuneofPowerBuff.ID, true) and Unit("player"):HasBuffsDown(A.ArcanePowerBuff.ID, true) and (A.ArcanePower:GetCooldown() <= 4 + 10 * VarFontDoubleOnUse and A.Evocation:GetCooldown() <= VarAverageBurnLength + 4 + 10 * VarFontDoubleOnUse or Unit(unit):TimeToDie() < A.ArcanePower:GetCooldown())) then
                return A.AzsharasFontofPower:Show(icon)
            end
            
            -- call_action_list,name=burn,if=burn_phase|target.time_to_die<variable.average_burn_length
            if A.BurstIsON(unit) and (BurnPhase:On() or Unit(unit):TimeToDie() < VarAverageBurnLength) then
                if Burn(unit) then
                    return true
                end
            end
            
            -- call_action_list,name=burn,if=(cooldown.arcane_power.remains=0&cooldown.evocation.remains<=variable.average_burn_length&(buff.arcane_charge.stack=buff.arcane_charge.max_stack|(talent.charged_up.enabled&cooldown.charged_up.remains=0&buff.arcane_charge.stack<=1)))
            if A.BurstIsON(unit) and ((A.ArcanePower:GetCooldown() == 0 and A.Evocation:GetCooldown() <= VarAverageBurnLength and (Unit("player"):ArcaneChargesP == Unit("player"):ArcaneChargesMax or (A.ChargedUp:IsSpellLearned() and A.ChargedUp:GetCooldown() == 0 and Unit("player"):ArcaneChargesP <= 1)))) then
                if Burn(unit) then
                    return true
                end
            end
            
            -- call_action_list,name=conserve,if=!burn_phase
            if (not BurnPhase:On()) then
                if Conserve(unit) then
                    return true
                end
            end
            
            -- call_action_list,name=movement
            if Movement(unit) then
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

