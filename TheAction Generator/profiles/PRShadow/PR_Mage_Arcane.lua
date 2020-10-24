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
    SiphonStorm                            = Create({ Type = "Spell", ID =  }),
    Necrolord                              = Create({ Type = "Spell", ID =  }),
    NightFae                               = Create({ Type = "Spell", ID =  }),
    DisciplinaryCommand                    = Create({ Type = "Spell", ID =  }),
    ArcaneProdigy                          = Create({ Type = "Spell", ID =  }),
    VisionofPerfection                     = Create({ Type = "Spell", ID =  }),
    GrislyIcicle                           = Create({ Type = "Spell", ID =  }),
    ArcaneFamiliarBuff                     = Create({ Type = "Spell", ID = 210126 }),
    ArcaneFamiliar                         = Create({ Type = "Spell", ID = 205022 }),
    ArcaneIntellectBuff                    = Create({ Type = "Spell", ID = 1459 }),
    ArcaneIntellect                        = Create({ Type = "Spell", ID = 1459 }),
    ConjureManaGem                         = Create({ Type = "Spell", ID =  }),
    MirrorImage                            = Create({ Type = "Spell", ID = 55342 }),
    Frostbolt                              = Create({ Type = "Spell", ID =  }),
    Evocation                              = Create({ Type = "Spell", ID = 12051 }),
    TouchoftheMagi                         = Create({ Type = "Spell", ID =  }),
    ArcanePower                            = Create({ Type = "Spell", ID = 12042 }),
    RuneofPower                            = Create({ Type = "Spell", ID = 116011 }),
    RuneofPowerBuff                        = Create({ Type = "Spell", ID = 116014 }),
    ArcaneBarrage                          = Create({ Type = "Spell", ID = 44425 }),
    ArcanePowerBuff                        = Create({ Type = "Spell", ID = 12042 }),
    ArcaneMissiles                         = Create({ Type = "Spell", ID = 5143 }),
    ArcaneChargeBuff                       = Create({ Type = "Spell", ID = 36032 }),
    ArcaneOrb                              = Create({ Type = "Spell", ID = 153626 }),
    TouchoftheMagiDebuff                   = Create({ Type = "Spell", ID =  }),
    ArcaneBlast                            = Create({ Type = "Spell", ID = 30451 }),
    BuffDisciplinaryCommand                = Create({ Type = "Spell", ID =  }),
    DisciplinaryCommandFrostBuff           = Create({ Type = "Spell", ID =  }),
    FireBlast                              = Create({ Type = "Spell", ID =  }),
    DisciplinaryCommandFireBuff            = Create({ Type = "Spell", ID =  }),
    FrostNova                              = Create({ Type = "Spell", ID =  }),
    MirrorsofTorment                       = Create({ Type = "Spell", ID =  }),
    RadiantSpark                           = Create({ Type = "Spell", ID =  }),
    Deathborne                             = Create({ Type = "Spell", ID =  }),
    PresenceofMind                         = Create({ Type = "Spell", ID = 205025 }),
    DeathborneBuff                         = Create({ Type = "Spell", ID =  }),
    PresenceofMindBuff                     = Create({ Type = "Spell", ID = 205025 }),
    Resonance                              = Create({ Type = "Spell", ID = 205028 }),
    Supernova                              = Create({ Type = "Spell", ID = 157980 }),
    NetherTempest                          = Create({ Type = "Spell", ID = 114923 }),
    NetherTempestDebuff                    = Create({ Type = "Spell", ID = 114923 }),
    ShiftingPower                          = Create({ Type = "Spell", ID =  }),
    ClearcastingBuff                       = Create({ Type = "Spell", ID = 263725 }),
    ArcaneInfinity                         = Create({ Type = "Spell", ID =  }),
    Amplification                          = Create({ Type = "Spell", ID = 236628 }),
    ArcaneExplosion                        = Create({ Type = "Spell", ID = 1449 }),
    Enlightened                            = Create({ Type = "Spell", ID =  }),
    Kyrian                                 = Create({ Type = "Spell", ID =  }),
    ReapingFlames                          = Create({ Type = "Spell", ID =  }),
    BlinkAny                               = Create({ Type = "Spell", ID =  }),
    CancelAction                           = Create({ Type = "Spell", ID =  }),
    FieldofBlossoms                        = Create({ Type = "Spell", ID =  }),
    RadiantSparkDebuff                     = Create({ Type = "Spell", ID =  }),
    RadiantSparkVulnerabilityDebuff        = Create({ Type = "Spell", ID =  }),
    ArcaneEcho                             = Create({ Type = "Spell", ID =  }),
    RuleofThreesBuff                       = Create({ Type = "Spell", ID = 264774 }),
    StrictSequence                         = Create({ Type = "Spell", ID =  }),
    ExpandedPotentialBuff                  = Create({ Type = "Spell", ID =  }),
    UseManaGem                             = Create({ Type = "Spell", ID =  }),
    LightsJudgment                         = Create({ Type = "Spell", ID = 255647 }),
    BagofTricks                            = Create({ Type = "Spell", ID =  }),
    Berserking                             = Create({ Type = "Spell", ID = 26297 }),
    BloodFury                              = Create({ Type = "Spell", ID = 20572 }),
    Fireblood                              = Create({ Type = "Spell", ID = 265221 }),
    AncestralCall                          = Create({ Type = "Spell", ID = 274738 })
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
A:CreateCovenantsFor(ACTION_CONST_MAGE_ARCANE)  -- where PLAYERSPEC is Constance (example: ACTION_CONST_MONK_BM)
local A = setmetatable(Action[ACTION_CONST_MAGE_ARCANE], { __index = Action })


------------------------------------------
---------------- VARIABLES ---------------
------------------------------------------
local VarPrepullEvo = 0;
local VarHaveOpened = 0;
local VarFinalBurn = 0;
local VarRsMaxDelay = 5;
local VarApMaxDelay = 10;
local VarRopMaxDelay = 20;
local VarTotmMaxDelay = 5;
local VarBarrageManaPct = 70;
local VarApMinimumManaPct = 30;
local VarTotmMaxCharges = 2;
local VarAoeTotmMaxCharges = 2;
local VarAmSpam = 0;

A.Listener:Add("ROTATION_VARS", "PLAYER_REGEN_ENABLED", function()
  VarPrepullEvo = 0
  VarHaveOpened = 0
  VarFinalBurn = 0
  VarRsMaxDelay = 5
  VarApMaxDelay = 10
  VarRopMaxDelay = 20
  VarTotmMaxDelay = 5
  VarBarrageManaPct = 70
  VarApMinimumManaPct = 30
  VarTotmMaxCharges = 2
  VarAoeTotmMaxCharges = 2
  VarAmSpam = 0
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
        
            -- variable,name=prepull_evo,op=reset,default=0
            VarPrepullEvo = 0
            
            -- variable,name=prepull_evo,op=set,value=1,if=variable.prepull_evo=0&runeforge.siphon_storm.equipped&active_enemies>2
            if (VarPrepullEvo == 0 and runeforge.siphon_storm.equipped and MultiUnits:GetByRangeInCombat(40, 5, 10) > 2) then
                VarPrepullEvo = 1
            end
            
            -- variable,name=prepull_evo,op=set,value=1,if=variable.prepull_evo=0&runeforge.siphon_storm.equipped&covenant.necrolord.enabled&active_enemies>1
            if (VarPrepullEvo == 0 and runeforge.siphon_storm.equipped and A.Necrolord:IsCovenantLearned() and MultiUnits:GetByRangeInCombat(40, 5, 10) > 1) then
                VarPrepullEvo = 1
            end
            
            -- variable,name=prepull_evo,op=set,value=1,if=variable.prepull_evo=0&runeforge.siphon_storm.equipped&covenant.night_fae.enabled
            if (VarPrepullEvo == 0 and runeforge.siphon_storm.equipped and A.NightFae:IsCovenantLearned()) then
                VarPrepullEvo = 1
            end
            
            -- variable,name=have_opened,op=reset,default=0
            VarHaveOpened = 0
            
            -- variable,name=have_opened,op=set,value=1,if=variable.have_opened=0&active_enemies>2
            if (VarHaveOpened == 0 and MultiUnits:GetByRangeInCombat(40, 5, 10) > 2) then
                VarHaveOpened = 1
            end
            
            -- variable,name=have_opened,op=set,value=1,if=variable.have_opened=0&variable.prepull_evo=1
            if (VarHaveOpened == 0 and VarPrepullEvo == 1) then
                VarHaveOpened = 1
            end
            
            -- variable,name=final_burn,op=set,value=0
            VarFinalBurn = 0
            
            -- variable,name=rs_max_delay,op=reset,default=5
            VarRsMaxDelay = 5
            
            -- variable,name=ap_max_delay,op=reset,default=10
            VarApMaxDelay = 10
            
            -- variable,name=rop_max_delay,op=reset,default=20
            VarRopMaxDelay = 20
            
            -- variable,name=totm_max_delay,op=reset,default=5
            VarTotmMaxDelay = 5
            
            -- variable,name=totm_max_delay,op=set,value=3,if=variable.totm_max_delay=5&runeforge.disciplinary_command.equipped
            if (VarTotmMaxDelay == 5 and runeforge.disciplinary_command.equipped) then
                VarTotmMaxDelay = 3
            end
            
            -- variable,name=totm_max_delay,op=set,value=15,if=variable.totm_max_delay=5&covenant.night_fae.enabled
            if (VarTotmMaxDelay == 5 and A.NightFae:IsCovenantLearned()) then
                VarTotmMaxDelay = 15
            end
            
            -- variable,name=totm_max_delay,op=set,value=15,if=variable.totm_max_delay=5&conduit.arcane_prodigy.enabled&active_enemies<3
            if (VarTotmMaxDelay == 5 and A.ArcaneProdigy:IsConduitLearned() and MultiUnits:GetByRangeInCombat(40, 5, 10) < 3) then
                VarTotmMaxDelay = 15
            end
            
            -- variable,name=totm_max_delay,op=set,value=30,if=variable.totm_max_delay=5&essence.vision_of_perfection.minor
            if (VarTotmMaxDelay == 5 and Azerite:EssenceHasMinor(A.VisionofPerfection.ID)) then
                VarTotmMaxDelay = 30
            end
            
            -- variable,name=barrage_mana_pct,op=reset,default=70
            VarBarrageManaPct = 70
            
            -- variable,name=barrage_mana_pct,op=set,value=40,if=variable.barrage_mana_pct=70&covenant.night_fae.enabled
            if (VarBarrageManaPct == 70 and A.NightFae:IsCovenantLearned()) then
                VarBarrageManaPct = 40
            end
            
            -- variable,name=ap_minimum_mana_pct,op=reset,default=30
            VarApMinimumManaPct = 30
            
            -- variable,name=ap_minimum_mana_pct,op=set,value=50,if=variable.ap_minimum_mana_pct=30&runeforge.disciplinary_command.equipped
            if (VarApMinimumManaPct == 30 and runeforge.disciplinary_command.equipped) then
                VarApMinimumManaPct = 50
            end
            
            -- variable,name=ap_minimum_mana_pct,op=set,value=50,if=variable.ap_minimum_mana_pct=30&runeforge.grisly_icicle.equipped
            if (VarApMinimumManaPct == 30 and runeforge.grisly_icicle.equipped) then
                VarApMinimumManaPct = 50
            end
            
            -- variable,name=totm_max_charges,op=reset,default=2
            VarTotmMaxCharges = 2
            
            -- variable,name=aoe_totm_max_charges,op=reset,default=2
            VarAoeTotmMaxCharges = 2
            
            -- variable,name=am_spam,op=reset,default=0
            VarAmSpam = 0
            
            -- flask
            -- food
            -- augmentation
            -- arcane_familiar
            if A.ArcaneFamiliar:IsReady(unit) and Unit("player"):HasBuffsDown(A.ArcaneFamiliarBuff.ID, true) then
                return A.ArcaneFamiliar:Show(icon)
            end
            
            -- arcane_intellect
            if A.ArcaneIntellect:IsReady(unit) and Unit("player"):HasBuffsDown(A.ArcaneIntellectBuff.ID, true, true) then
                return A.ArcaneIntellect:Show(icon)
            end
            
            -- conjure_mana_gem
            if A.ConjureManaGem:IsReady(unit) then
                return A.ConjureManaGem:Show(icon)
            end
            
            -- snapshot_stats
            -- mirror_image
            if A.MirrorImage:IsReady(unit) and A.BurstIsON(unit) then
                return A.MirrorImage:Show(icon)
            end
            
            -- frostbolt,if=variable.prepull_evo<=0
            if A.Frostbolt:IsReady(unit) and (VarPrepullEvo <= 0) then
                return A.Frostbolt:Show(icon)
            end
            
            -- evocation,if=variable.prepull_evo>0
            if A.Evocation:IsReady(unit) and (VarPrepullEvo > 0) then
                return A.Evocation:Show(icon)
            end
            
        end
        
        --AmSpam
        local function AmSpam(unit)
        
            -- touch_of_the_magi,if=(cooldown.arcane_power.remains=0|cooldown.rune_of_power.remains<=gcd)&buff.rune_of_power.down
            if A.TouchoftheMagi:IsReady(unit) and ((A.ArcanePower:GetCooldown() == 0 or A.RuneofPower:GetCooldown() <= GetGCD()) and Unit("player"):HasBuffsDown(A.RuneofPowerBuff.ID, true)) then
                return A.TouchoftheMagi:Show(icon)
            end
            
            -- arcane_power,if=buff.rune_of_power.down
            if A.ArcanePower:IsReady(unit) and A.BurstIsON(unit) and (Unit("player"):HasBuffsDown(A.RuneofPowerBuff.ID, true)) then
                return A.ArcanePower:Show(icon)
            end
            
            -- rune_of_power,if=buff.rune_of_power.down
            if A.RuneofPower:IsReady(unit) and (Unit("player"):HasBuffsDown(A.RuneofPowerBuff.ID, true)) then
                return A.RuneofPower:Show(icon)
            end
            
            -- arcane_barrage,if=buff.arcane_power.up&buff.arcane_power.remains<=action.arcane_missiles.execute_time&buff.arcane_charge.stack=buff.arcane_charge.max_stack
            if A.ArcaneBarrage:IsReady(unit) and (Unit("player"):HasBuffs(A.ArcanePowerBuff.ID, true) and Unit("player"):HasBuffs(A.ArcanePowerBuff.ID, true) <= A.ArcaneMissiles:GetSpellCastTime() and Unit("player"):ArcaneChargesP == Unit("player"):ArcaneChargesMax) then
                return A.ArcaneBarrage:Show(icon)
            end
            
            -- arcane_orb,if=buff.arcane_charge.stack<buff.arcane_charge.max_stack&buff.rune_of_power.down&buff.arcane_power.down&debuff.touch_of_the_magi.down
            if A.ArcaneOrb:IsReady(unit) and (Unit("player"):ArcaneChargesP < Unit("player"):ArcaneChargesMax and Unit("player"):HasBuffsDown(A.RuneofPowerBuff.ID, true) and Unit("player"):HasBuffsDown(A.ArcanePowerBuff.ID, true) and Unit(unit):HasDeBuffsDown(A.TouchoftheMagiDebuff.ID, true)) then
                return A.ArcaneOrb:Show(icon)
            end
            
            -- arcane_barrage,if=buff.rune_of_power.down&buff.arcane_power.down&debuff.touch_of_the_magi.down&buff.arcane_charge.stack=buff.arcane_charge.max_stack
            if A.ArcaneBarrage:IsReady(unit) and (Unit("player"):HasBuffsDown(A.RuneofPowerBuff.ID, true) and Unit("player"):HasBuffsDown(A.ArcanePowerBuff.ID, true) and Unit(unit):HasDeBuffsDown(A.TouchoftheMagiDebuff.ID, true) and Unit("player"):ArcaneChargesP == Unit("player"):ArcaneChargesMax) then
                return A.ArcaneBarrage:Show(icon)
            end
            
            -- arcane_missiles,chain=1
            if A.ArcaneMissiles:IsReady(unit) then
                return A.ArcaneMissiles:Show(icon)
            end
            
            -- evocation,interrupt_if=mana.pct>=85,interrupt_immediate=1
            if A.Evocation:IsReady(unit) then
                return A.Evocation:Show(icon)
            end
            
            -- arcane_orb,if=buff.arcane_charge.stack<buff.arcane_charge.max_stack
            if A.ArcaneOrb:IsReady(unit) and (Unit("player"):ArcaneChargesP < Unit("player"):ArcaneChargesMax) then
                return A.ArcaneOrb:Show(icon)
            end
            
            -- arcane_barrage
            if A.ArcaneBarrage:IsReady(unit) then
                return A.ArcaneBarrage:Show(icon)
            end
            
            -- arcane_blast
            if A.ArcaneBlast:IsReady(unit) then
                return A.ArcaneBlast:Show(icon)
            end
            
        end
        
        --Aoe
        local function Aoe(unit)
        
            -- frostbolt,if=runeforge.disciplinary_command.equipped&cooldown.buff_disciplinary_command.ready&buff.disciplinary_command_frost.down&(buff.arcane_power.down&buff.rune_of_power.down&debuff.touch_of_the_magi.down)&cooldown.touch_of_the_magi.remains=0&(buff.arcane_charge.stack<=variable.aoe_totm_max_charges&((talent.rune_of_power.enabled&cooldown.rune_of_power.remains<=gcd&cooldown.arcane_power.remains>variable.totm_max_delay)|(!talent.rune_of_power.enabled&cooldown.arcane_power.remains>variable.totm_max_delay)|cooldown.arcane_power.remains<=gcd))
            if A.Frostbolt:IsReady(unit) and (runeforge.disciplinary_command.equipped and A.BuffDisciplinaryCommand.ID, true:GetCooldown() == 0 and Unit("player"):HasBuffsDown(A.DisciplinaryCommandFrostBuff.ID, true) and (Unit("player"):HasBuffsDown(A.ArcanePowerBuff.ID, true) and Unit("player"):HasBuffsDown(A.RuneofPowerBuff.ID, true) and Unit(unit):HasDeBuffsDown(A.TouchoftheMagiDebuff.ID, true)) and A.TouchoftheMagi:GetCooldown() == 0 and (Unit("player"):ArcaneChargesP <= VarAoeTotmMaxCharges and ((A.RuneofPower:IsSpellLearned() and A.RuneofPower:GetCooldown() <= GetGCD() and A.ArcanePower:GetCooldown() > VarTotmMaxDelay) or (not A.RuneofPower:IsSpellLearned() and A.ArcanePower:GetCooldown() > VarTotmMaxDelay) or A.ArcanePower:GetCooldown() <= GetGCD()))) then
                return A.Frostbolt:Show(icon)
            end
            
            -- fire_blast,if=(runeforge.disciplinary_command.equipped&cooldown.buff_disciplinary_command.ready&buff.disciplinary_command_fire.down&prev_gcd.1.frostbolt)|(runeforge.disciplinary_command.equipped&time=0)
            if A.FireBlast:IsReady(unit) and ((runeforge.disciplinary_command.equipped and A.BuffDisciplinaryCommand.ID, true:GetCooldown() == 0 and Unit("player"):HasBuffsDown(A.DisciplinaryCommandFireBuff.ID, true) and Player:PrevGCD(1, A.Frostbolt)) or (runeforge.disciplinary_command.equipped and Unit("player"):CombatTime() == 0)) then
                return A.FireBlast:Show(icon)
            end
            
            -- frost_nova,if=runeforge.grisly_icicle.equipped&cooldown.arcane_power.remains>30&cooldown.touch_of_the_magi.remains=0&(buff.arcane_charge.stack<=variable.aoe_totm_max_charges&((talent.rune_of_power.enabled&cooldown.rune_of_power.remains<=gcd&cooldown.arcane_power.remains>variable.totm_max_delay)|(!talent.rune_of_power.enabled&cooldown.arcane_power.remains>variable.totm_max_delay)|cooldown.arcane_power.remains<=gcd))
            if A.FrostNova:IsReady(unit) and (runeforge.grisly_icicle.equipped and A.ArcanePower:GetCooldown() > 30 and A.TouchoftheMagi:GetCooldown() == 0 and (Unit("player"):ArcaneChargesP <= VarAoeTotmMaxCharges and ((A.RuneofPower:IsSpellLearned() and A.RuneofPower:GetCooldown() <= GetGCD() and A.ArcanePower:GetCooldown() > VarTotmMaxDelay) or (not A.RuneofPower:IsSpellLearned() and A.ArcanePower:GetCooldown() > VarTotmMaxDelay) or A.ArcanePower:GetCooldown() <= GetGCD()))) then
                return A.FrostNova:Show(icon)
            end
            
            -- frost_nova,if=runeforge.grisly_icicle.equipped&cooldown.arcane_power.remains=0&(((cooldown.touch_of_the_magi.remains>variable.ap_max_delay&buff.arcane_charge.stack=buff.arcane_charge.max_stack)|(cooldown.touch_of_the_magi.remains=0&buff.arcane_charge.stack<=variable.aoe_totm_max_charges))&buff.rune_of_power.down)
            if A.FrostNova:IsReady(unit) and (runeforge.grisly_icicle.equipped and A.ArcanePower:GetCooldown() == 0 and (((A.TouchoftheMagi:GetCooldown() > VarApMaxDelay and Unit("player"):ArcaneChargesP == Unit("player"):ArcaneChargesMax) or (A.TouchoftheMagi:GetCooldown() == 0 and Unit("player"):ArcaneChargesP <= VarAoeTotmMaxCharges)) and Unit("player"):HasBuffsDown(A.RuneofPowerBuff.ID, true))) then
                return A.FrostNova:Show(icon)
            end
            
            -- touch_of_the_magi,if=runeforge.siphon_storm.equipped&prev_gcd.1.evocation
            if A.TouchoftheMagi:IsReady(unit) and (runeforge.siphon_storm.equipped and Player:PrevGCD(1, A.Evocation)) then
                return A.TouchoftheMagi:Show(icon)
            end
            
            -- arcane_power,if=runeforge.siphon_storm.equipped&(prev_gcd.1.evocation|prev_gcd.1.touch_of_the_magi)
            if A.ArcanePower:IsReady(unit) and A.BurstIsON(unit) and (runeforge.siphon_storm.equipped and (Player:PrevGCD(1, A.Evocation) or Player:PrevGCD(1, A.TouchoftheMagi))) then
                return A.ArcanePower:Show(icon)
            end
            
            -- evocation,if=time>30&runeforge.siphon_storm.equipped&buff.arcane_charge.stack<=variable.aoe_totm_max_charges&cooldown.touch_of_the_magi.remains=0&cooldown.arcane_power.remains<=gcd
            if A.Evocation:IsReady(unit) and (Unit("player"):CombatTime() > 30 and runeforge.siphon_storm.equipped and Unit("player"):ArcaneChargesP <= VarAoeTotmMaxCharges and A.TouchoftheMagi:GetCooldown() == 0 and A.ArcanePower:GetCooldown() <= GetGCD()) then
                return A.Evocation:Show(icon)
            end
            
            -- evocation,if=time>30&runeforge.siphon_storm.equipped&cooldown.arcane_power.remains=0&(((cooldown.touch_of_the_magi.remains>variable.ap_max_delay&buff.arcane_charge.stack=buff.arcane_charge.max_stack)|(cooldown.touch_of_the_magi.remains=0&buff.arcane_charge.stack<=variable.aoe_totm_max_charges))&buff.rune_of_power.down),interrupt_if=buff.siphon_storm.stack=buff.siphon_storm.max_stack,interrupt_immediate=1
            if A.Evocation:IsReady(unit) and (Unit("player"):CombatTime() > 30 and runeforge.siphon_storm.equipped and A.ArcanePower:GetCooldown() == 0 and (((A.TouchoftheMagi:GetCooldown() > VarApMaxDelay and Unit("player"):ArcaneChargesP == Unit("player"):ArcaneChargesMax) or (A.TouchoftheMagi:GetCooldown() == 0 and Unit("player"):ArcaneChargesP <= VarAoeTotmMaxCharges)) and Unit("player"):HasBuffsDown(A.RuneofPowerBuff.ID, true))) then
                return A.Evocation:Show(icon)
            end
            
            -- mirrors_of_torment,if=(cooldown.arcane_power.remains>45|cooldown.arcane_power.remains<=3)&cooldown.touch_of_the_magi.remains=0&(buff.arcane_charge.stack<=variable.aoe_totm_max_charges&((talent.rune_of_power.enabled&cooldown.rune_of_power.remains<=gcd&cooldown.arcane_power.remains>5)|(!talent.rune_of_power.enabled&cooldown.arcane_power.remains>5)|cooldown.arcane_power.remains<=gcd))
            if A.MirrorsofTorment:IsReady(unit) and ((A.ArcanePower:GetCooldown() > 45 or A.ArcanePower:GetCooldown() <= 3) and A.TouchoftheMagi:GetCooldown() == 0 and (Unit("player"):ArcaneChargesP <= VarAoeTotmMaxCharges and ((A.RuneofPower:IsSpellLearned() and A.RuneofPower:GetCooldown() <= GetGCD() and A.ArcanePower:GetCooldown() > 5) or (not A.RuneofPower:IsSpellLearned() and A.ArcanePower:GetCooldown() > 5) or A.ArcanePower:GetCooldown() <= GetGCD()))) then
                return A.MirrorsofTorment:Show(icon)
            end
            
            -- radiant_spark,if=cooldown.touch_of_the_magi.remains>variable.rs_max_delay&cooldown.arcane_power.remains>variable.rs_max_delay&(talent.rune_of_power.enabled&cooldown.rune_of_power.remains<=gcd|talent.rune_of_power.enabled&cooldown.rune_of_power.remains>variable.rs_max_delay|!talent.rune_of_power.enabled)&buff.arcane_charge.stack<=variable.aoe_totm_max_charges&debuff.touch_of_the_magi.down
            if A.RadiantSpark:IsReady(unit) and (A.TouchoftheMagi:GetCooldown() > VarRsMaxDelay and A.ArcanePower:GetCooldown() > VarRsMaxDelay and (A.RuneofPower:IsSpellLearned() and A.RuneofPower:GetCooldown() <= GetGCD() or A.RuneofPower:IsSpellLearned() and A.RuneofPower:GetCooldown() > VarRsMaxDelay or not A.RuneofPower:IsSpellLearned()) and Unit("player"):ArcaneChargesP <= VarAoeTotmMaxCharges and Unit(unit):HasDeBuffsDown(A.TouchoftheMagiDebuff.ID, true)) then
                return A.RadiantSpark:Show(icon)
            end
            
            -- radiant_spark,if=cooldown.touch_of_the_magi.remains=0&(buff.arcane_charge.stack<=variable.aoe_totm_max_charges&((talent.rune_of_power.enabled&cooldown.rune_of_power.remains<=gcd&cooldown.arcane_power.remains>variable.totm_max_delay)|(!talent.rune_of_power.enabled&cooldown.arcane_power.remains>variable.totm_max_delay)|cooldown.arcane_power.remains<=gcd))
            if A.RadiantSpark:IsReady(unit) and (A.TouchoftheMagi:GetCooldown() == 0 and (Unit("player"):ArcaneChargesP <= VarAoeTotmMaxCharges and ((A.RuneofPower:IsSpellLearned() and A.RuneofPower:GetCooldown() <= GetGCD() and A.ArcanePower:GetCooldown() > VarTotmMaxDelay) or (not A.RuneofPower:IsSpellLearned() and A.ArcanePower:GetCooldown() > VarTotmMaxDelay) or A.ArcanePower:GetCooldown() <= GetGCD()))) then
                return A.RadiantSpark:Show(icon)
            end
            
            -- radiant_spark,if=cooldown.arcane_power.remains=0&(((cooldown.touch_of_the_magi.remains>variable.ap_max_delay&buff.arcane_charge.stack=buff.arcane_charge.max_stack)|(cooldown.touch_of_the_magi.remains=0&buff.arcane_charge.stack<=variable.aoe_totm_max_charges))&buff.rune_of_power.down)
            if A.RadiantSpark:IsReady(unit) and (A.ArcanePower:GetCooldown() == 0 and (((A.TouchoftheMagi:GetCooldown() > VarApMaxDelay and Unit("player"):ArcaneChargesP == Unit("player"):ArcaneChargesMax) or (A.TouchoftheMagi:GetCooldown() == 0 and Unit("player"):ArcaneChargesP <= VarAoeTotmMaxCharges)) and Unit("player"):HasBuffsDown(A.RuneofPowerBuff.ID, true))) then
                return A.RadiantSpark:Show(icon)
            end
            
            -- deathborne,if=cooldown.arcane_power.remains=0&(((cooldown.touch_of_the_magi.remains>variable.ap_max_delay&buff.arcane_charge.stack=buff.arcane_charge.max_stack)|(cooldown.touch_of_the_magi.remains=0&buff.arcane_charge.stack<=variable.aoe_totm_max_charges))&buff.rune_of_power.down)
            if A.Deathborne:IsReady(unit) and (A.ArcanePower:GetCooldown() == 0 and (((A.TouchoftheMagi:GetCooldown() > VarApMaxDelay and Unit("player"):ArcaneChargesP == Unit("player"):ArcaneChargesMax) or (A.TouchoftheMagi:GetCooldown() == 0 and Unit("player"):ArcaneChargesP <= VarAoeTotmMaxCharges)) and Unit("player"):HasBuffsDown(A.RuneofPowerBuff.ID, true))) then
                return A.Deathborne:Show(icon)
            end
            
            -- touch_of_the_magi,if=buff.arcane_charge.stack<=variable.aoe_totm_max_charges&((talent.rune_of_power.enabled&cooldown.rune_of_power.remains<=gcd&cooldown.arcane_power.remains>variable.totm_max_delay)|(!talent.rune_of_power.enabled&cooldown.arcane_power.remains>variable.totm_max_delay)|cooldown.arcane_power.remains<=gcd)
            if A.TouchoftheMagi:IsReady(unit) and (Unit("player"):ArcaneChargesP <= VarAoeTotmMaxCharges and ((A.RuneofPower:IsSpellLearned() and A.RuneofPower:GetCooldown() <= GetGCD() and A.ArcanePower:GetCooldown() > VarTotmMaxDelay) or (not A.RuneofPower:IsSpellLearned() and A.ArcanePower:GetCooldown() > VarTotmMaxDelay) or A.ArcanePower:GetCooldown() <= GetGCD())) then
                return A.TouchoftheMagi:Show(icon)
            end
            
            -- arcane_power,if=((cooldown.touch_of_the_magi.remains>variable.ap_max_delay&buff.arcane_charge.stack=buff.arcane_charge.max_stack)|(cooldown.touch_of_the_magi.remains=0&buff.arcane_charge.stack<=variable.aoe_totm_max_charges))&buff.rune_of_power.down
            if A.ArcanePower:IsReady(unit) and A.BurstIsON(unit) and (((A.TouchoftheMagi:GetCooldown() > VarApMaxDelay and Unit("player"):ArcaneChargesP == Unit("player"):ArcaneChargesMax) or (A.TouchoftheMagi:GetCooldown() == 0 and Unit("player"):ArcaneChargesP <= VarAoeTotmMaxCharges)) and Unit("player"):HasBuffsDown(A.RuneofPowerBuff.ID, true)) then
                return A.ArcanePower:Show(icon)
            end
            
            -- rune_of_power,if=buff.rune_of_power.down&((cooldown.touch_of_the_magi.remains>20&buff.arcane_charge.stack=buff.arcane_charge.max_stack)|(cooldown.touch_of_the_magi.remains=0&buff.arcane_charge.stack<=variable.aoe_totm_max_charges))&(cooldown.arcane_power.remains>15|debuff.touch_of_the_magi.up)
            if A.RuneofPower:IsReady(unit) and (Unit("player"):HasBuffsDown(A.RuneofPowerBuff.ID, true) and ((A.TouchoftheMagi:GetCooldown() > 20 and Unit("player"):ArcaneChargesP == Unit("player"):ArcaneChargesMax) or (A.TouchoftheMagi:GetCooldown() == 0 and Unit("player"):ArcaneChargesP <= VarAoeTotmMaxCharges)) and (A.ArcanePower:GetCooldown() > 15 or Unit(unit):HasDeBuffs(A.TouchoftheMagiDebuff.ID, true))) then
                return A.RuneofPower:Show(icon)
            end
            
            -- presence_of_mind,if=buff.deathborne.up&debuff.touch_of_the_magi.up&debuff.touch_of_the_magi.remains<=buff.presence_of_mind.max_stack*action.arcane_blast.execute_time
            if A.PresenceofMind:IsReady(unit) and A.BurstIsON(unit) and (Unit("player"):HasBuffs(A.DeathborneBuff.ID, true) and Unit(unit):HasDeBuffs(A.TouchoftheMagiDebuff.ID, true) and Unit(unit):HasDeBuffs(A.TouchoftheMagiDebuff.ID, true) <= PresenceOfMindMax * A.ArcaneBlast:GetSpellCastTime()) then
                return A.PresenceofMind:Show(icon)
            end
            
            -- arcane_blast,if=buff.deathborne.up&((talent.resonance.enabled&active_enemies<4)|active_enemies<5)
            if A.ArcaneBlast:IsReady(unit) and (Unit("player"):HasBuffs(A.DeathborneBuff.ID, true) and ((A.Resonance:IsSpellLearned() and MultiUnits:GetByRangeInCombat(40, 5, 10) < 4) or MultiUnits:GetByRangeInCombat(40, 5, 10) < 5)) then
                return A.ArcaneBlast:Show(icon)
            end
            
            -- supernova
            if A.Supernova:IsReady(unit) then
                return A.Supernova:Show(icon)
            end
            
            -- arcane_orb,if=buff.arcane_charge.stack=0
            if A.ArcaneOrb:IsReady(unit) and (Unit("player"):ArcaneChargesP == 0) then
                return A.ArcaneOrb:Show(icon)
            end
            
            -- nether_tempest,if=(refreshable|!ticking)&buff.arcane_charge.stack=buff.arcane_charge.max_stack
            if A.NetherTempest:IsReady(unit) and ((Unit(unit):HasDeBuffsRefreshable(A.NetherTempestDebuff.ID, true) or not Unit(unit):HasDeBuffs(A.NetherTempestDebuff.ID, true)) and Unit("player"):ArcaneChargesP == Unit("player"):ArcaneChargesMax) then
                return A.NetherTempest:Show(icon)
            end
            
            -- shifting_power,if=buff.arcane_power.down&buff.rune_of_power.down&debuff.touch_of_the_magi.down&cooldown.arcane_power.remains>0&cooldown.touch_of_the_magi.remains>0&(!talent.rune_of_power.enabled|(talent.rune_of_power.enabled&cooldown.rune_of_power.remains>0))
            if A.ShiftingPower:IsReady(unit) and (Unit("player"):HasBuffsDown(A.ArcanePowerBuff.ID, true) and Unit("player"):HasBuffsDown(A.RuneofPowerBuff.ID, true) and Unit(unit):HasDeBuffsDown(A.TouchoftheMagiDebuff.ID, true) and A.ArcanePower:GetCooldown() > 0 and A.TouchoftheMagi:GetCooldown() > 0 and (not A.RuneofPower:IsSpellLearned() or (A.RuneofPower:IsSpellLearned() and A.RuneofPower:GetCooldown() > 0))) then
                return A.ShiftingPower:Show(icon)
            end
            
            -- arcane_missiles,if=buff.clearcasting.react&runeforge.arcane_infinity.equipped&talent.amplification.enabled&active_enemies<9
            if A.ArcaneMissiles:IsReady(unit) and (Unit("player"):HasBuffsStacks(A.ClearcastingBuff.ID, true) and runeforge.arcane_infinity.equipped and A.Amplification:IsSpellLearned() and MultiUnits:GetByRangeInCombat(40, 5, 10) < 9) then
                return A.ArcaneMissiles:Show(icon)
            end
            
            -- arcane_missiles,if=buff.clearcasting.react&runeforge.arcane_infinity.equipped&active_enemies<6
            if A.ArcaneMissiles:IsReady(unit) and (Unit("player"):HasBuffsStacks(A.ClearcastingBuff.ID, true) and runeforge.arcane_infinity.equipped and MultiUnits:GetByRangeInCombat(40, 5, 10) < 6) then
                return A.ArcaneMissiles:Show(icon)
            end
            
            -- arcane_explosion,if=buff.arcane_charge.stack<buff.arcane_charge.max_stack
            if A.ArcaneExplosion:IsReady(unit) and (Unit("player"):ArcaneChargesP < Unit("player"):ArcaneChargesMax) then
                return A.ArcaneExplosion:Show(icon)
            end
            
            -- arcane_explosion,if=buff.arcane_charge.stack=buff.arcane_charge.max_stack&prev_gcd.1.arcane_barrage
            if A.ArcaneExplosion:IsReady(unit) and (Unit("player"):ArcaneChargesP == Unit("player"):ArcaneChargesMax and Player:PrevGCD(1, A.ArcaneBarrage)) then
                return A.ArcaneExplosion:Show(icon)
            end
            
            -- arcane_barrage,if=buff.arcane_charge.stack=buff.arcane_charge.max_stack
            if A.ArcaneBarrage:IsReady(unit) and (Unit("player"):ArcaneChargesP == Unit("player"):ArcaneChargesMax) then
                return A.ArcaneBarrage:Show(icon)
            end
            
            -- evocation,interrupt_if=mana.pct>=85,interrupt_immediate=1
            if A.Evocation:IsReady(unit) then
                return A.Evocation:Show(icon)
            end
            
        end
        
        --Cooldowns
        local function Cooldowns(unit)
        
            -- frost_nova,if=runeforge.grisly_icicle.equipped&cooldown.arcane_power.remains>30&cooldown.touch_of_the_magi.remains=0&(buff.arcane_charge.stack<=variable.totm_max_charges&((talent.rune_of_power.enabled&cooldown.rune_of_power.remains<=gcd&cooldown.arcane_power.remains>variable.totm_max_delay)|(!talent.rune_of_power.enabled&cooldown.arcane_power.remains>variable.totm_max_delay)|cooldown.arcane_power.remains<=gcd))
            if A.FrostNova:IsReady(unit) and (runeforge.grisly_icicle.equipped and A.ArcanePower:GetCooldown() > 30 and A.TouchoftheMagi:GetCooldown() == 0 and (Unit("player"):ArcaneChargesP <= VarTotmMaxCharges and ((A.RuneofPower:IsSpellLearned() and A.RuneofPower:GetCooldown() <= GetGCD() and A.ArcanePower:GetCooldown() > VarTotmMaxDelay) or (not A.RuneofPower:IsSpellLearned() and A.ArcanePower:GetCooldown() > VarTotmMaxDelay) or A.ArcanePower:GetCooldown() <= GetGCD()))) then
                return A.FrostNova:Show(icon)
            end
            
            -- frost_nova,if=runeforge.grisly_icicle.equipped&cooldown.arcane_power.remains=0&(!talent.enlightened.enabled|(talent.enlightened.enabled&mana.pct>=70))&((cooldown.touch_of_the_magi.remains>10&buff.arcane_charge.stack=buff.arcane_charge.max_stack)|(cooldown.touch_of_the_magi.remains=0&buff.arcane_charge.stack=0))&buff.rune_of_power.down&mana.pct>=variable.ap_minimum_mana_pct
            if A.FrostNova:IsReady(unit) and (runeforge.grisly_icicle.equipped and A.ArcanePower:GetCooldown() == 0 and (not A.Enlightened:IsSpellLearned() or (A.Enlightened:IsSpellLearned() and Player:ManaPercentageP() >= 70)) and ((A.TouchoftheMagi:GetCooldown() > 10 and Unit("player"):ArcaneChargesP == Unit("player"):ArcaneChargesMax) or (A.TouchoftheMagi:GetCooldown() == 0 and Unit("player"):ArcaneChargesP == 0)) and Unit("player"):HasBuffsDown(A.RuneofPowerBuff.ID, true) and Player:ManaPercentageP() >= VarApMinimumManaPct) then
                return A.FrostNova:Show(icon)
            end
            
            -- frostbolt,if=runeforge.disciplinary_command.equipped&cooldown.buff_disciplinary_command.ready&buff.disciplinary_command_frost.down&(buff.arcane_power.down&buff.rune_of_power.down&debuff.touch_of_the_magi.down)&cooldown.touch_of_the_magi.remains=0&(buff.arcane_charge.stack<=variable.totm_max_charges&((talent.rune_of_power.enabled&cooldown.rune_of_power.remains<=gcd&cooldown.arcane_power.remains>variable.totm_max_delay)|(!talent.rune_of_power.enabled&cooldown.arcane_power.remains>variable.totm_max_delay)|cooldown.arcane_power.remains<=gcd))
            if A.Frostbolt:IsReady(unit) and (runeforge.disciplinary_command.equipped and A.BuffDisciplinaryCommand.ID, true:GetCooldown() == 0 and Unit("player"):HasBuffsDown(A.DisciplinaryCommandFrostBuff.ID, true) and (Unit("player"):HasBuffsDown(A.ArcanePowerBuff.ID, true) and Unit("player"):HasBuffsDown(A.RuneofPowerBuff.ID, true) and Unit(unit):HasDeBuffsDown(A.TouchoftheMagiDebuff.ID, true)) and A.TouchoftheMagi:GetCooldown() == 0 and (Unit("player"):ArcaneChargesP <= VarTotmMaxCharges and ((A.RuneofPower:IsSpellLearned() and A.RuneofPower:GetCooldown() <= GetGCD() and A.ArcanePower:GetCooldown() > VarTotmMaxDelay) or (not A.RuneofPower:IsSpellLearned() and A.ArcanePower:GetCooldown() > VarTotmMaxDelay) or A.ArcanePower:GetCooldown() <= GetGCD()))) then
                return A.Frostbolt:Show(icon)
            end
            
            -- fire_blast,if=runeforge.disciplinary_command.equipped&cooldown.buff_disciplinary_command.ready&buff.disciplinary_command_fire.down&prev_gcd.1.frostbolt
            if A.FireBlast:IsReady(unit) and (runeforge.disciplinary_command.equipped and A.BuffDisciplinaryCommand.ID, true:GetCooldown() == 0 and Unit("player"):HasBuffsDown(A.DisciplinaryCommandFireBuff.ID, true) and Player:PrevGCD(1, A.Frostbolt)) then
                return A.FireBlast:Show(icon)
            end
            
            -- mirrors_of_torment,if=cooldown.touch_of_the_magi.remains=0&buff.arcane_charge.stack<=variable.totm_max_charges&cooldown.arcane_power.remains<=gcd
            if A.MirrorsofTorment:IsReady(unit) and (A.TouchoftheMagi:GetCooldown() == 0 and Unit("player"):ArcaneChargesP <= VarTotmMaxCharges and A.ArcanePower:GetCooldown() <= GetGCD()) then
                return A.MirrorsofTorment:Show(icon)
            end
            
            -- mirrors_of_torment,if=cooldown.arcane_power.remains=0&(!talent.enlightened.enabled|(talent.enlightened.enabled&mana.pct>=70))&((cooldown.touch_of_the_magi.remains>variable.ap_max_delay&buff.arcane_charge.stack=buff.arcane_charge.max_stack)|(cooldown.touch_of_the_magi.remains=0&buff.arcane_charge.stack=0))&buff.rune_of_power.down&mana.pct>=variable.ap_minimum_mana_pct
            if A.MirrorsofTorment:IsReady(unit) and (A.ArcanePower:GetCooldown() == 0 and (not A.Enlightened:IsSpellLearned() or (A.Enlightened:IsSpellLearned() and Player:ManaPercentageP() >= 70)) and ((A.TouchoftheMagi:GetCooldown() > VarApMaxDelay and Unit("player"):ArcaneChargesP == Unit("player"):ArcaneChargesMax) or (A.TouchoftheMagi:GetCooldown() == 0 and Unit("player"):ArcaneChargesP == 0)) and Unit("player"):HasBuffsDown(A.RuneofPowerBuff.ID, true) and Player:ManaPercentageP() >= VarApMinimumManaPct) then
                return A.MirrorsofTorment:Show(icon)
            end
            
            -- deathborne,if=cooldown.touch_of_the_magi.remains=0&buff.arcane_charge.stack<=variable.totm_max_charges&cooldown.arcane_power.remains<=gcd
            if A.Deathborne:IsReady(unit) and (A.TouchoftheMagi:GetCooldown() == 0 and Unit("player"):ArcaneChargesP <= VarTotmMaxCharges and A.ArcanePower:GetCooldown() <= GetGCD()) then
                return A.Deathborne:Show(icon)
            end
            
            -- deathborne,if=cooldown.arcane_power.remains=0&(!talent.enlightened.enabled|(talent.enlightened.enabled&mana.pct>=70))&((cooldown.touch_of_the_magi.remains>10&buff.arcane_charge.stack=buff.arcane_charge.max_stack)|(cooldown.touch_of_the_magi.remains=0&buff.arcane_charge.stack=0))&buff.rune_of_power.down&mana.pct>=variable.ap_minimum_mana_pct
            if A.Deathborne:IsReady(unit) and (A.ArcanePower:GetCooldown() == 0 and (not A.Enlightened:IsSpellLearned() or (A.Enlightened:IsSpellLearned() and Player:ManaPercentageP() >= 70)) and ((A.TouchoftheMagi:GetCooldown() > 10 and Unit("player"):ArcaneChargesP == Unit("player"):ArcaneChargesMax) or (A.TouchoftheMagi:GetCooldown() == 0 and Unit("player"):ArcaneChargesP == 0)) and Unit("player"):HasBuffsDown(A.RuneofPowerBuff.ID, true) and Player:ManaPercentageP() >= VarApMinimumManaPct) then
                return A.Deathborne:Show(icon)
            end
            
            -- radiant_spark,if=cooldown.touch_of_the_magi.remains>variable.rs_max_delay&cooldown.arcane_power.remains>variable.rs_max_delay&(talent.rune_of_power.enabled&cooldown.rune_of_power.remains<=gcd|talent.rune_of_power.enabled&cooldown.rune_of_power.remains>variable.rs_max_delay|!talent.rune_of_power.enabled)&buff.arcane_charge.stack>2&debuff.touch_of_the_magi.down
            if A.RadiantSpark:IsReady(unit) and (A.TouchoftheMagi:GetCooldown() > VarRsMaxDelay and A.ArcanePower:GetCooldown() > VarRsMaxDelay and (A.RuneofPower:IsSpellLearned() and A.RuneofPower:GetCooldown() <= GetGCD() or A.RuneofPower:IsSpellLearned() and A.RuneofPower:GetCooldown() > VarRsMaxDelay or not A.RuneofPower:IsSpellLearned()) and Unit("player"):ArcaneChargesP > 2 and Unit(unit):HasDeBuffsDown(A.TouchoftheMagiDebuff.ID, true)) then
                return A.RadiantSpark:Show(icon)
            end
            
            -- radiant_spark,if=cooldown.touch_of_the_magi.remains=0&buff.arcane_charge.stack<=variable.totm_max_charges&cooldown.arcane_power.remains<=gcd
            if A.RadiantSpark:IsReady(unit) and (A.TouchoftheMagi:GetCooldown() == 0 and Unit("player"):ArcaneChargesP <= VarTotmMaxCharges and A.ArcanePower:GetCooldown() <= GetGCD()) then
                return A.RadiantSpark:Show(icon)
            end
            
            -- radiant_spark,if=cooldown.arcane_power.remains=0&((!talent.enlightened.enabled|(talent.enlightened.enabled&mana.pct>=70))&((cooldown.touch_of_the_magi.remains>variable.ap_max_delay&buff.arcane_charge.stack=buff.arcane_charge.max_stack)|(cooldown.touch_of_the_magi.remains=0&buff.arcane_charge.stack=0))&buff.rune_of_power.down&mana.pct>=variable.ap_minimum_mana_pct)
            if A.RadiantSpark:IsReady(unit) and (A.ArcanePower:GetCooldown() == 0 and ((not A.Enlightened:IsSpellLearned() or (A.Enlightened:IsSpellLearned() and Player:ManaPercentageP() >= 70)) and ((A.TouchoftheMagi:GetCooldown() > VarApMaxDelay and Unit("player"):ArcaneChargesP == Unit("player"):ArcaneChargesMax) or (A.TouchoftheMagi:GetCooldown() == 0 and Unit("player"):ArcaneChargesP == 0)) and Unit("player"):HasBuffsDown(A.RuneofPowerBuff.ID, true) and Player:ManaPercentageP() >= VarApMinimumManaPct)) then
                return A.RadiantSpark:Show(icon)
            end
            
            -- touch_of_the_magi,if=cooldown.arcane_power.remains<50&essence.vision_of_perfection.minor
            if A.TouchoftheMagi:IsReady(unit) and (A.ArcanePower:GetCooldown() < 50 and Azerite:EssenceHasMinor(A.VisionofPerfection.ID)) then
                return A.TouchoftheMagi:Show(icon)
            end
            
            -- touch_of_the_magi,if=buff.arcane_charge.stack<=variable.totm_max_charges&talent.rune_of_power.enabled&cooldown.rune_of_power.remains<=gcd&cooldown.arcane_power.remains>variable.totm_max_delay&covenant.kyrian.enabled&cooldown.radiant_spark.remains<=8
            if A.TouchoftheMagi:IsReady(unit) and (Unit("player"):ArcaneChargesP <= VarTotmMaxCharges and A.RuneofPower:IsSpellLearned() and A.RuneofPower:GetCooldown() <= GetGCD() and A.ArcanePower:GetCooldown() > VarTotmMaxDelay and A.Kyrian:IsCovenantLearned() and A.RadiantSpark:GetCooldown() <= 8) then
                return A.TouchoftheMagi:Show(icon)
            end
            
            -- touch_of_the_magi,if=buff.arcane_charge.stack<=variable.totm_max_charges&talent.rune_of_power.enabled&cooldown.rune_of_power.remains<=gcd&cooldown.arcane_power.remains>variable.totm_max_delay&!covenant.kyrian.enabled
            if A.TouchoftheMagi:IsReady(unit) and (Unit("player"):ArcaneChargesP <= VarTotmMaxCharges and A.RuneofPower:IsSpellLearned() and A.RuneofPower:GetCooldown() <= GetGCD() and A.ArcanePower:GetCooldown() > VarTotmMaxDelay and not A.Kyrian:IsCovenantLearned()) then
                return A.TouchoftheMagi:Show(icon)
            end
            
            -- touch_of_the_magi,if=buff.arcane_charge.stack<=variable.totm_max_charges&!talent.rune_of_power.enabled&cooldown.arcane_power.remains>variable.totm_max_delay
            if A.TouchoftheMagi:IsReady(unit) and (Unit("player"):ArcaneChargesP <= VarTotmMaxCharges and not A.RuneofPower:IsSpellLearned() and A.ArcanePower:GetCooldown() > VarTotmMaxDelay) then
                return A.TouchoftheMagi:Show(icon)
            end
            
            -- touch_of_the_magi,if=buff.arcane_charge.stack<=variable.totm_max_charges&cooldown.arcane_power.remains<=gcd
            if A.TouchoftheMagi:IsReady(unit) and (Unit("player"):ArcaneChargesP <= VarTotmMaxCharges and A.ArcanePower:GetCooldown() <= GetGCD()) then
                return A.TouchoftheMagi:Show(icon)
            end
            
            -- arcane_power,if=(!talent.enlightened.enabled|(talent.enlightened.enabled&mana.pct>=70))&cooldown.touch_of_the_magi.remains>variable.ap_max_delay&buff.arcane_charge.stack=buff.arcane_charge.max_stack&buff.rune_of_power.down&mana.pct>=variable.ap_minimum_mana_pct
            if A.ArcanePower:IsReady(unit) and A.BurstIsON(unit) and ((not A.Enlightened:IsSpellLearned() or (A.Enlightened:IsSpellLearned() and Player:ManaPercentageP() >= 70)) and A.TouchoftheMagi:GetCooldown() > VarApMaxDelay and Unit("player"):ArcaneChargesP == Unit("player"):ArcaneChargesMax and Unit("player"):HasBuffsDown(A.RuneofPowerBuff.ID, true) and Player:ManaPercentageP() >= VarApMinimumManaPct) then
                return A.ArcanePower:Show(icon)
            end
            
            -- rune_of_power,if=buff.rune_of_power.down&cooldown.touch_of_the_magi.remains>variable.rop_max_delay&buff.arcane_charge.stack=buff.arcane_charge.max_stack&(cooldown.arcane_power.remains>15|debuff.touch_of_the_magi.up)
            if A.RuneofPower:IsReady(unit) and (Unit("player"):HasBuffsDown(A.RuneofPowerBuff.ID, true) and A.TouchoftheMagi:GetCooldown() > VarRopMaxDelay and Unit("player"):ArcaneChargesP == Unit("player"):ArcaneChargesMax and (A.ArcanePower:GetCooldown() > 15 or Unit(unit):HasDeBuffs(A.TouchoftheMagiDebuff.ID, true))) then
                return A.RuneofPower:Show(icon)
            end
            
            -- presence_of_mind,if=buff.arcane_charge.stack=0&covenant.kyrian.enabled
            if A.PresenceofMind:IsReady(unit) and A.BurstIsON(unit) and (Unit("player"):ArcaneChargesP == 0 and A.Kyrian:IsCovenantLearned()) then
                return A.PresenceofMind:Show(icon)
            end
            
            -- presence_of_mind,if=debuff.touch_of_the_magi.up&!covenant.kyrian.enabled
            if A.PresenceofMind:IsReady(unit) and A.BurstIsON(unit) and (Unit(unit):HasDeBuffs(A.TouchoftheMagiDebuff.ID, true) and not A.Kyrian:IsCovenantLearned()) then
                return A.PresenceofMind:Show(icon)
            end
            
        end
        
        --Essences
        local function Essences(unit)
        
            -- blood_of_the_enemy,if=cooldown.touch_of_the_magi.remains=0&buff.arcane_charge.stack<=variable.totm_max_charges&cooldown.arcane_power.remains<=gcd|fight_remains<cooldown.arcane_power.remains
            if A.BloodoftheEnemy:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and (A.TouchoftheMagi:GetCooldown() == 0 and Unit("player"):ArcaneChargesP <= VarTotmMaxCharges and A.ArcanePower:GetCooldown() <= GetGCD() or fight_remains < A.ArcanePower:GetCooldown()) then
                return A.BloodoftheEnemy:Show(icon)
            end
            
            -- blood_of_the_enemy,if=cooldown.arcane_power.remains=0&(!talent.enlightened.enabled|(talent.enlightened.enabled&mana.pct>=70|variable.am_spam=1))&((cooldown.touch_of_the_magi.remains>variable.ap_max_delay&(buff.arcane_charge.stack=buff.arcane_charge.max_stack|variable.am_spam=1))|(cooldown.touch_of_the_magi.remains=0&buff.arcane_charge.stack=0))&buff.rune_of_power.down&mana.pct>=variable.ap_minimum_mana_pct
            if A.BloodoftheEnemy:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and (A.ArcanePower:GetCooldown() == 0 and (not A.Enlightened:IsSpellLearned() or (A.Enlightened:IsSpellLearned() and Player:ManaPercentageP() >= 70 or VarAmSpam == 1)) and ((A.TouchoftheMagi:GetCooldown() > VarApMaxDelay and (Unit("player"):ArcaneChargesP == Unit("player"):ArcaneChargesMax or VarAmSpam == 1)) or (A.TouchoftheMagi:GetCooldown() == 0 and Unit("player"):ArcaneChargesP == 0)) and Unit("player"):HasBuffsDown(A.RuneofPowerBuff.ID, true) and Player:ManaPercentageP() >= VarApMinimumManaPct) then
                return A.BloodoftheEnemy:Show(icon)
            end
            
            -- worldvein_resonance,if=cooldown.arcane_power.remains>=50&cooldown.touch_of_the_magi.remains<=gcd&buff.arcane_charge.stack<=variable.totm_max_charges&talent.rune_of_power.enabled&cooldown.rune_of_power.remains<=gcd&cooldown.arcane_power.remains>variable.totm_max_delay
            if A.WorldveinResonance:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and (A.ArcanePower:GetCooldown() >= 50 and A.TouchoftheMagi:GetCooldown() <= GetGCD() and Unit("player"):ArcaneChargesP <= VarTotmMaxCharges and A.RuneofPower:IsSpellLearned() and A.RuneofPower:GetCooldown() <= GetGCD() and A.ArcanePower:GetCooldown() > VarTotmMaxDelay) then
                return A.WorldveinResonance:Show(icon)
            end
            
            -- worldvein_resonance,if=cooldown.touch_of_the_magi.remains=0&buff.arcane_charge.stack<=variable.totm_max_charges&cooldown.arcane_power.remains<=gcd|fight_remains<cooldown.arcane_power.remains
            if A.WorldveinResonance:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and (A.TouchoftheMagi:GetCooldown() == 0 and Unit("player"):ArcaneChargesP <= VarTotmMaxCharges and A.ArcanePower:GetCooldown() <= GetGCD() or fight_remains < A.ArcanePower:GetCooldown()) then
                return A.WorldveinResonance:Show(icon)
            end
            
            -- worldvein_resonance,if=cooldown.arcane_power.remains=0&(!talent.enlightened.enabled|(talent.enlightened.enabled&mana.pct>=70|variable.am_spam=1))&((cooldown.touch_of_the_magi.remains>variable.ap_max_delay&(buff.arcane_charge.stack=buff.arcane_charge.max_stack|variable.am_spam=1))|(cooldown.touch_of_the_magi.remains=0&buff.arcane_charge.stack=0))&buff.rune_of_power.down&mana.pct>=variable.ap_minimum_mana_pct
            if A.WorldveinResonance:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and (A.ArcanePower:GetCooldown() == 0 and (not A.Enlightened:IsSpellLearned() or (A.Enlightened:IsSpellLearned() and Player:ManaPercentageP() >= 70 or VarAmSpam == 1)) and ((A.TouchoftheMagi:GetCooldown() > VarApMaxDelay and (Unit("player"):ArcaneChargesP == Unit("player"):ArcaneChargesMax or VarAmSpam == 1)) or (A.TouchoftheMagi:GetCooldown() == 0 and Unit("player"):ArcaneChargesP == 0)) and Unit("player"):HasBuffsDown(A.RuneofPowerBuff.ID, true) and Player:ManaPercentageP() >= VarApMinimumManaPct) then
                return A.WorldveinResonance:Show(icon)
            end
            
            -- guardian_of_azeroth,if=cooldown.touch_of_the_magi.remains=0&buff.arcane_charge.stack<=variable.totm_max_charges&cooldown.arcane_power.remains<=gcd|fight_remains<cooldown.arcane_power.remains
            if A.GuardianofAzeroth:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and (A.TouchoftheMagi:GetCooldown() == 0 and Unit("player"):ArcaneChargesP <= VarTotmMaxCharges and A.ArcanePower:GetCooldown() <= GetGCD() or fight_remains < A.ArcanePower:GetCooldown()) then
                return A.GuardianofAzeroth:Show(icon)
            end
            
            -- guardian_of_azeroth,if=cooldown.arcane_power.remains=0&(!talent.enlightened.enabled|(talent.enlightened.enabled&mana.pct>=70|variable.am_spam=1))&((cooldown.touch_of_the_magi.remains>variable.ap_max_delay&(buff.arcane_charge.stack=buff.arcane_charge.max_stack|variable.am_spam=1))|(cooldown.touch_of_the_magi.remains=0&buff.arcane_charge.stack=0))&buff.rune_of_power.down&mana.pct>=variable.ap_minimum_mana_pct
            if A.GuardianofAzeroth:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and (A.ArcanePower:GetCooldown() == 0 and (not A.Enlightened:IsSpellLearned() or (A.Enlightened:IsSpellLearned() and Player:ManaPercentageP() >= 70 or VarAmSpam == 1)) and ((A.TouchoftheMagi:GetCooldown() > VarApMaxDelay and (Unit("player"):ArcaneChargesP == Unit("player"):ArcaneChargesMax or VarAmSpam == 1)) or (A.TouchoftheMagi:GetCooldown() == 0 and Unit("player"):ArcaneChargesP == 0)) and Unit("player"):HasBuffsDown(A.RuneofPowerBuff.ID, true) and Player:ManaPercentageP() >= VarApMinimumManaPct) then
                return A.GuardianofAzeroth:Show(icon)
            end
            
            -- concentrated_flame,line_cd=6,if=buff.arcane_power.down&buff.rune_of_power.down&debuff.touch_of_the_magi.down&mana.time_to_max>=execute_time
            if A.ConcentratedFlame:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and (Unit("player"):HasBuffsDown(A.ArcanePowerBuff.ID, true) and Unit("player"):HasBuffsDown(A.RuneofPowerBuff.ID, true) and Unit(unit):HasDeBuffsDown(A.TouchoftheMagiDebuff.ID, true) and Player:ManaTimeToMaxPredicted() >= A.ConcentratedFlame:GetSpellCastTime()) then
                return A.ConcentratedFlame:Show(icon)
            end
            
            -- reaping_flames,if=buff.arcane_power.down&buff.rune_of_power.down&debuff.touch_of_the_magi.down&mana.time_to_max>=execute_time
            if A.ReapingFlames:IsReady(unit) and (Unit("player"):HasBuffsDown(A.ArcanePowerBuff.ID, true) and Unit("player"):HasBuffsDown(A.RuneofPowerBuff.ID, true) and Unit(unit):HasDeBuffsDown(A.TouchoftheMagiDebuff.ID, true) and Player:ManaTimeToMaxPredicted() >= A.ReapingFlames:GetSpellCastTime()) then
                return A.ReapingFlames:Show(icon)
            end
            
            -- focused_azerite_beam,if=buff.arcane_power.down&buff.rune_of_power.down&debuff.touch_of_the_magi.down
            if A.FocusedAzeriteBeam:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and (Unit("player"):HasBuffsDown(A.ArcanePowerBuff.ID, true) and Unit("player"):HasBuffsDown(A.RuneofPowerBuff.ID, true) and Unit(unit):HasDeBuffsDown(A.TouchoftheMagiDebuff.ID, true)) then
                return A.FocusedAzeriteBeam:Show(icon)
            end
            
            -- purifying_blast,if=buff.arcane_power.down&buff.rune_of_power.down&debuff.touch_of_the_magi.down
            if A.PurifyingBlast:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and (Unit("player"):HasBuffsDown(A.ArcanePowerBuff.ID, true) and Unit("player"):HasBuffsDown(A.RuneofPowerBuff.ID, true) and Unit(unit):HasDeBuffsDown(A.TouchoftheMagiDebuff.ID, true)) then
                return A.PurifyingBlast:Show(icon)
            end
            
            -- ripple_in_space,if=buff.arcane_power.down&buff.rune_of_power.down&debuff.touch_of_the_magi.down
            if A.RippleInSpace:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and (Unit("player"):HasBuffsDown(A.ArcanePowerBuff.ID, true) and Unit("player"):HasBuffsDown(A.RuneofPowerBuff.ID, true) and Unit(unit):HasDeBuffsDown(A.TouchoftheMagiDebuff.ID, true)) then
                return A.RippleInSpace:Show(icon)
            end
            
            -- the_unbound_force,if=buff.arcane_power.down&buff.rune_of_power.down&debuff.touch_of_the_magi.down
            if A.TheUnboundForce:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and (Unit("player"):HasBuffsDown(A.ArcanePowerBuff.ID, true) and Unit("player"):HasBuffsDown(A.RuneofPowerBuff.ID, true) and Unit(unit):HasDeBuffsDown(A.TouchoftheMagiDebuff.ID, true)) then
                return A.TheUnboundForce:Show(icon)
            end
            
            -- memory_of_lucid_dreams,if=buff.arcane_power.down&buff.rune_of_power.down&debuff.touch_of_the_magi.down
            if A.MemoryofLucidDreams:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and (Unit("player"):HasBuffsDown(A.ArcanePowerBuff.ID, true) and Unit("player"):HasBuffsDown(A.RuneofPowerBuff.ID, true) and Unit(unit):HasDeBuffsDown(A.TouchoftheMagiDebuff.ID, true)) then
                return A.MemoryofLucidDreams:Show(icon)
            end
            
        end
        
        --FinalBurn
        local function FinalBurn(unit)
        
            -- arcane_missiles,if=buff.clearcasting.react,chain=1
            if A.ArcaneMissiles:IsReady(unit) and (Unit("player"):HasBuffsStacks(A.ClearcastingBuff.ID, true)) then
                return A.ArcaneMissiles:Show(icon)
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
            
            -- arcane_missiles,if=movement.distance<10
            if A.ArcaneMissiles:IsReady(unit) and (Unit(unit):GetRange() < 10) then
                return A.ArcaneMissiles:Show(icon)
            end
            
            -- arcane_orb
            if A.ArcaneOrb:IsReady(unit) then
                return A.ArcaneOrb:Show(icon)
            end
            
            -- fire_blast
            if A.FireBlast:IsReady(unit) then
                return A.FireBlast:Show(icon)
            end
            
        end
        
        --Opener
        local function Opener(unit)
        
            -- variable,name=have_opened,op=set,value=1,if=prev_gcd.1.evocation
            if (Player:PrevGCD(1, A.Evocation)) then
                VarHaveOpened = 1
            end
            
            -- fire_blast,if=runeforge.disciplinary_command.equipped&buff.disciplinary_command_frost.up
            if A.FireBlast:IsReady(unit) and (runeforge.disciplinary_command.equipped and Unit("player"):HasBuffs(A.DisciplinaryCommandFrostBuff.ID, true)) then
                return A.FireBlast:Show(icon)
            end
            
            -- frost_nova,if=runeforge.grisly_icicle.equipped&mana.pct>95
            if A.FrostNova:IsReady(unit) and (runeforge.grisly_icicle.equipped and Player:ManaPercentageP() > 95) then
                return A.FrostNova:Show(icon)
            end
            
            -- mirrors_of_torment
            if A.MirrorsofTorment:IsReady(unit) then
                return A.MirrorsofTorment:Show(icon)
            end
            
            -- deathborne
            if A.Deathborne:IsReady(unit) then
                return A.Deathborne:Show(icon)
            end
            
            -- radiant_spark,if=mana.pct>40
            if A.RadiantSpark:IsReady(unit) and (Player:ManaPercentageP() > 40) then
                return A.RadiantSpark:Show(icon)
            end
            
            -- cancel_action,if=action.shifting_power.channeling&gcd.remains=0
            if A.CancelAction:IsReady(unit) and (action.shifting_power.channeling and GetCurrentGCD() == 0) then
                return A.CancelAction:Show(icon)
            end
            
            -- shifting_power,if=soulbind.field_of_blossoms.enabled
            if A.ShiftingPower:IsReady(unit) and (A.FieldofBlossoms:IsSoulbindLearned()) then
                return A.ShiftingPower:Show(icon)
            end
            
            -- touch_of_the_magi
            if A.TouchoftheMagi:IsReady(unit) then
                return A.TouchoftheMagi:Show(icon)
            end
            
            -- arcane_power
            if A.ArcanePower:IsReady(unit) and A.BurstIsON(unit) then
                return A.ArcanePower:Show(icon)
            end
            
            -- rune_of_power,if=buff.rune_of_power.down
            if A.RuneofPower:IsReady(unit) and (Unit("player"):HasBuffsDown(A.RuneofPowerBuff.ID, true)) then
                return A.RuneofPower:Show(icon)
            end
            
            -- presence_of_mind
            if A.PresenceofMind:IsReady(unit) and A.BurstIsON(unit) then
                return A.PresenceofMind:Show(icon)
            end
            
            -- arcane_blast,if=dot.radiant_spark.remains>5|debuff.radiant_spark_vulnerability.stack>0
            if A.ArcaneBlast:IsReady(unit) and (Unit(unit):HasDeBuffs(A.RadiantSparkDebuff.ID, true) > 5 or Unit(unit):HasDeBuffsStacks(A.RadiantSparkVulnerabilityDebuff.ID, true) > 0) then
                return A.ArcaneBlast:Show(icon)
            end
            
            -- arcane_blast,if=buff.presence_of_mind.up&debuff.touch_of_the_magi.up&debuff.touch_of_the_magi.remains<=action.arcane_blast.execute_time
            if A.ArcaneBlast:IsReady(unit) and (Unit("player"):HasBuffs(A.PresenceofMindBuff.ID, true) and Unit(unit):HasDeBuffs(A.TouchoftheMagiDebuff.ID, true) and Unit(unit):HasDeBuffs(A.TouchoftheMagiDebuff.ID, true) <= A.ArcaneBlast:GetSpellCastTime()) then
                return A.ArcaneBlast:Show(icon)
            end
            
            -- arcane_barrage,if=buff.arcane_power.up&buff.arcane_power.remains<=gcd&buff.arcane_charge.stack=buff.arcane_charge.max_stack
            if A.ArcaneBarrage:IsReady(unit) and (Unit("player"):HasBuffs(A.ArcanePowerBuff.ID, true) and Unit("player"):HasBuffs(A.ArcanePowerBuff.ID, true) <= GetGCD() and Unit("player"):ArcaneChargesP == Unit("player"):ArcaneChargesMax) then
                return A.ArcaneBarrage:Show(icon)
            end
            
            -- arcane_missiles,if=debuff.touch_of_the_magi.up&talent.arcane_echo.enabled&buff.deathborne.down&debuff.touch_of_the_magi.remains>action.arcane_missiles.execute_time,chain=1
            if A.ArcaneMissiles:IsReady(unit) and (Unit(unit):HasDeBuffs(A.TouchoftheMagiDebuff.ID, true) and A.ArcaneEcho:IsSpellLearned() and Unit("player"):HasBuffsDown(A.DeathborneBuff.ID, true) and Unit(unit):HasDeBuffs(A.TouchoftheMagiDebuff.ID, true) > A.ArcaneMissiles:GetSpellCastTime()) then
                return A.ArcaneMissiles:Show(icon)
            end
            
            -- arcane_missiles,if=buff.clearcasting.react,chain=1
            if A.ArcaneMissiles:IsReady(unit) and (Unit("player"):HasBuffsStacks(A.ClearcastingBuff.ID, true)) then
                return A.ArcaneMissiles:Show(icon)
            end
            
            -- arcane_orb,if=buff.arcane_charge.stack<=variable.totm_max_charges&(cooldown.arcane_power.remains>10|active_enemies<=2)
            if A.ArcaneOrb:IsReady(unit) and (Unit("player"):ArcaneChargesP <= VarTotmMaxCharges and (A.ArcanePower:GetCooldown() > 10 or MultiUnits:GetByRangeInCombat(40, 5, 10) <= 2)) then
                return A.ArcaneOrb:Show(icon)
            end
            
            -- arcane_blast,if=buff.rune_of_power.up|mana.pct>15
            if A.ArcaneBlast:IsReady(unit) and (Unit("player"):HasBuffs(A.RuneofPowerBuff.ID, true) or Player:ManaPercentageP() > 15) then
                return A.ArcaneBlast:Show(icon)
            end
            
            -- evocation,if=buff.rune_of_power.down,interrupt_if=mana.pct>=85,interrupt_immediate=1
            if A.Evocation:IsReady(unit) and (Unit("player"):HasBuffsDown(A.RuneofPowerBuff.ID, true)) then
                return A.Evocation:Show(icon)
            end
            
            -- arcane_barrage
            if A.ArcaneBarrage:IsReady(unit) then
                return A.ArcaneBarrage:Show(icon)
            end
            
        end
        
        --Rotation
        local function Rotation(unit)
        
            -- variable,name=final_burn,op=set,value=1,if=buff.arcane_charge.stack=buff.arcane_charge.max_stack&!buff.rule_of_threes.up&fight_remains<=((mana%action.arcane_blast.cost)*action.arcane_blast.execute_time)
            if (Unit("player"):ArcaneChargesP == Unit("player"):ArcaneChargesMax and not Unit("player"):HasBuffs(A.RuleofThreesBuff.ID, true) and fight_remains <= ((Player:Mana() / A.ArcaneBlast:GetSpellPowerCostCache()) * A.ArcaneBlast:GetSpellCastTime())) then
                VarFinalBurn = 1
            end
            
            -- arcane_barrage,if=cooldown.touch_of_the_magi.remains=0&(buff.arcane_charge.stack>variable.totm_max_charges&talent.rune_of_power.enabled&cooldown.rune_of_power.remains<=gcd&cooldown.arcane_power.remains>variable.totm_max_delay&covenant.kyrian.enabled&cooldown.radiant_spark.remains<=8)
            if A.ArcaneBarrage:IsReady(unit) and (A.TouchoftheMagi:GetCooldown() == 0 and (Unit("player"):ArcaneChargesP > VarTotmMaxCharges and A.RuneofPower:IsSpellLearned() and A.RuneofPower:GetCooldown() <= GetGCD() and A.ArcanePower:GetCooldown() > VarTotmMaxDelay and A.Kyrian:IsCovenantLearned() and A.RadiantSpark:GetCooldown() <= 8)) then
                return A.ArcaneBarrage:Show(icon)
            end
            
            -- arcane_barrage,if=cooldown.touch_of_the_magi.remains=0&(buff.arcane_charge.stack>variable.totm_max_charges&talent.rune_of_power.enabled&cooldown.rune_of_power.remains<=gcd&cooldown.arcane_power.remains>variable.totm_max_delay&!covenant.kyrian.enabled)
            if A.ArcaneBarrage:IsReady(unit) and (A.TouchoftheMagi:GetCooldown() == 0 and (Unit("player"):ArcaneChargesP > VarTotmMaxCharges and A.RuneofPower:IsSpellLearned() and A.RuneofPower:GetCooldown() <= GetGCD() and A.ArcanePower:GetCooldown() > VarTotmMaxDelay and not A.Kyrian:IsCovenantLearned())) then
                return A.ArcaneBarrage:Show(icon)
            end
            
            -- arcane_barrage,if=cooldown.touch_of_the_magi.remains=0&(buff.arcane_charge.stack>variable.totm_max_charges&!talent.rune_of_power.enabled&cooldown.arcane_power.remains>variable.totm_max_delay)
            if A.ArcaneBarrage:IsReady(unit) and (A.TouchoftheMagi:GetCooldown() == 0 and (Unit("player"):ArcaneChargesP > VarTotmMaxCharges and not A.RuneofPower:IsSpellLearned() and A.ArcanePower:GetCooldown() > VarTotmMaxDelay)) then
                return A.ArcaneBarrage:Show(icon)
            end
            
            -- arcane_barrage,if=cooldown.touch_of_the_magi.remains=0&(buff.arcane_charge.stack>variable.totm_max_charges&cooldown.arcane_power.remains<=gcd)
            if A.ArcaneBarrage:IsReady(unit) and (A.TouchoftheMagi:GetCooldown() == 0 and (Unit("player"):ArcaneChargesP > VarTotmMaxCharges and A.ArcanePower:GetCooldown() <= GetGCD())) then
                return A.ArcaneBarrage:Show(icon)
            end
            
            -- strict_sequence,if=debuff.radiant_spark_vulnerability.stack=debuff.radiant_spark_vulnerability.max_stack&buff.arcane_power.down&buff.rune_of_power.down,name=last_spark_stack:arcane_blast:arcane_barrage
            if A.StrictSequence:IsReady(unit) and (Unit(unit):HasDeBuffsStacks(A.RadiantSparkVulnerabilityDebuff.ID, true) == debuff.radiant_spark_vulnerability.max_stack and Unit("player"):HasBuffsDown(A.ArcanePowerBuff.ID, true) and Unit("player"):HasBuffsDown(A.RuneofPowerBuff.ID, true)) then
                return A.StrictSequence:Show(icon)
            end
            
            -- arcane_barrage,if=debuff.radiant_spark_vulnerability.stack=debuff.radiant_spark_vulnerability.max_stack&(buff.arcane_power.down|buff.arcane_power.remains<=gcd)&(buff.rune_of_power.down|buff.rune_of_power.remains<=gcd)
            if A.ArcaneBarrage:IsReady(unit) and (Unit(unit):HasDeBuffsStacks(A.RadiantSparkVulnerabilityDebuff.ID, true) == debuff.radiant_spark_vulnerability.max_stack and (Unit("player"):HasBuffsDown(A.ArcanePowerBuff.ID, true) or Unit("player"):HasBuffs(A.ArcanePowerBuff.ID, true) <= GetGCD()) and (Unit("player"):HasBuffsDown(A.RuneofPowerBuff.ID, true) or Unit("player"):HasBuffs(A.RuneofPowerBuff.ID, true) <= GetGCD())) then
                return A.ArcaneBarrage:Show(icon)
            end
            
            -- arcane_blast,if=dot.radiant_spark.remains>5|debuff.radiant_spark_vulnerability.stack>0
            if A.ArcaneBlast:IsReady(unit) and (Unit(unit):HasDeBuffs(A.RadiantSparkDebuff.ID, true) > 5 or Unit(unit):HasDeBuffsStacks(A.RadiantSparkVulnerabilityDebuff.ID, true) > 0) then
                return A.ArcaneBlast:Show(icon)
            end
            
            -- arcane_blast,if=buff.presence_of_mind.up&debuff.touch_of_the_magi.up&debuff.touch_of_the_magi.remains<=action.arcane_blast.execute_time
            if A.ArcaneBlast:IsReady(unit) and (Unit("player"):HasBuffs(A.PresenceofMindBuff.ID, true) and Unit(unit):HasDeBuffs(A.TouchoftheMagiDebuff.ID, true) and Unit(unit):HasDeBuffs(A.TouchoftheMagiDebuff.ID, true) <= A.ArcaneBlast:GetSpellCastTime()) then
                return A.ArcaneBlast:Show(icon)
            end
            
            -- arcane_missiles,if=debuff.touch_of_the_magi.up&talent.arcane_echo.enabled&buff.deathborne.down&(debuff.touch_of_the_magi.remains>action.arcane_missiles.execute_time|cooldown.presence_of_mind.remains>0|covenant.kyrian.enabled),chain=1
            if A.ArcaneMissiles:IsReady(unit) and (Unit(unit):HasDeBuffs(A.TouchoftheMagiDebuff.ID, true) and A.ArcaneEcho:IsSpellLearned() and Unit("player"):HasBuffsDown(A.DeathborneBuff.ID, true) and (Unit(unit):HasDeBuffs(A.TouchoftheMagiDebuff.ID, true) > A.ArcaneMissiles:GetSpellCastTime() or A.PresenceofMind:GetCooldown() > 0 or A.Kyrian:IsCovenantLearned())) then
                return A.ArcaneMissiles:Show(icon)
            end
            
            -- arcane_missiles,if=buff.clearcasting.react&buff.expanded_potential.up
            if A.ArcaneMissiles:IsReady(unit) and (Unit("player"):HasBuffsStacks(A.ClearcastingBuff.ID, true) and Unit("player"):HasBuffs(A.ExpandedPotentialBuff.ID, true)) then
                return A.ArcaneMissiles:Show(icon)
            end
            
            -- arcane_missiles,if=buff.clearcasting.react&(buff.arcane_power.up|buff.rune_of_power.up|debuff.touch_of_the_magi.remains>action.arcane_missiles.execute_time),chain=1
            if A.ArcaneMissiles:IsReady(unit) and (Unit("player"):HasBuffsStacks(A.ClearcastingBuff.ID, true) and (Unit("player"):HasBuffs(A.ArcanePowerBuff.ID, true) or Unit("player"):HasBuffs(A.RuneofPowerBuff.ID, true) or Unit(unit):HasDeBuffs(A.TouchoftheMagiDebuff.ID, true) > A.ArcaneMissiles:GetSpellCastTime())) then
                return A.ArcaneMissiles:Show(icon)
            end
            
            -- arcane_missiles,if=buff.clearcasting.react&buff.clearcasting.stack=buff.clearcasting.max_stack,chain=1
            if A.ArcaneMissiles:IsReady(unit) and (Unit("player"):HasBuffsStacks(A.ClearcastingBuff.ID, true) and Unit("player"):HasBuffsStacks(A.ClearcastingBuff.ID, true) == buff.clearcasting.max_stack) then
                return A.ArcaneMissiles:Show(icon)
            end
            
            -- arcane_missiles,if=buff.clearcasting.react&buff.clearcasting.remains<=((buff.clearcasting.stack*action.arcane_missiles.execute_time)+gcd),chain=1
            if A.ArcaneMissiles:IsReady(unit) and (Unit("player"):HasBuffsStacks(A.ClearcastingBuff.ID, true) and Unit("player"):HasBuffs(A.ClearcastingBuff.ID, true) <= ((Unit("player"):HasBuffsStacks(A.ClearcastingBuff.ID, true) * A.ArcaneMissiles:GetSpellCastTime()) + GetGCD())) then
                return A.ArcaneMissiles:Show(icon)
            end
            
            -- nether_tempest,if=(refreshable|!ticking)&buff.arcane_charge.stack=buff.arcane_charge.max_stack&buff.arcane_power.down&debuff.touch_of_the_magi.down
            if A.NetherTempest:IsReady(unit) and ((Unit(unit):HasDeBuffsRefreshable(A.NetherTempestDebuff.ID, true) or not Unit(unit):HasDeBuffs(A.NetherTempestDebuff.ID, true)) and Unit("player"):ArcaneChargesP == Unit("player"):ArcaneChargesMax and Unit("player"):HasBuffsDown(A.ArcanePowerBuff.ID, true) and Unit(unit):HasDeBuffsDown(A.TouchoftheMagiDebuff.ID, true)) then
                return A.NetherTempest:Show(icon)
            end
            
            -- arcane_orb,if=buff.arcane_charge.stack<=variable.totm_max_charges
            if A.ArcaneOrb:IsReady(unit) and (Unit("player"):ArcaneChargesP <= VarTotmMaxCharges) then
                return A.ArcaneOrb:Show(icon)
            end
            
            -- supernova,if=mana.pct<=95&buff.arcane_power.down&buff.rune_of_power.down&debuff.touch_of_the_magi.down
            if A.Supernova:IsReady(unit) and (Player:ManaPercentageP() <= 95 and Unit("player"):HasBuffsDown(A.ArcanePowerBuff.ID, true) and Unit("player"):HasBuffsDown(A.RuneofPowerBuff.ID, true) and Unit(unit):HasDeBuffsDown(A.TouchoftheMagiDebuff.ID, true)) then
                return A.Supernova:Show(icon)
            end
            
            -- shifting_power,if=buff.arcane_power.down&buff.rune_of_power.down&debuff.touch_of_the_magi.down&cooldown.evocation.remains>0&cooldown.arcane_power.remains>0&cooldown.touch_of_the_magi.remains>0&(!talent.rune_of_power.enabled|(talent.rune_of_power.enabled&cooldown.rune_of_power.remains>0))
            if A.ShiftingPower:IsReady(unit) and (Unit("player"):HasBuffsDown(A.ArcanePowerBuff.ID, true) and Unit("player"):HasBuffsDown(A.RuneofPowerBuff.ID, true) and Unit(unit):HasDeBuffsDown(A.TouchoftheMagiDebuff.ID, true) and A.Evocation:GetCooldown() > 0 and A.ArcanePower:GetCooldown() > 0 and A.TouchoftheMagi:GetCooldown() > 0 and (not A.RuneofPower:IsSpellLearned() or (A.RuneofPower:IsSpellLearned() and A.RuneofPower:GetCooldown() > 0))) then
                return A.ShiftingPower:Show(icon)
            end
            
            -- arcane_blast,if=buff.rule_of_threes.up&buff.arcane_charge.stack>3
            if A.ArcaneBlast:IsReady(unit) and (Unit("player"):HasBuffs(A.RuleofThreesBuff.ID, true) and Unit("player"):ArcaneChargesP > 3) then
                return A.ArcaneBlast:Show(icon)
            end
            
            -- arcane_barrage,if=mana.pct<variable.barrage_mana_pct&cooldown.evocation.remains>0&buff.arcane_power.down&buff.arcane_charge.stack=buff.arcane_charge.max_stack&essence.vision_of_perfection.minor
            if A.ArcaneBarrage:IsReady(unit) and (Player:ManaPercentageP() < VarBarrageManaPct and A.Evocation:GetCooldown() > 0 and Unit("player"):HasBuffsDown(A.ArcanePowerBuff.ID, true) and Unit("player"):ArcaneChargesP == Unit("player"):ArcaneChargesMax and Azerite:EssenceHasMinor(A.VisionofPerfection.ID)) then
                return A.ArcaneBarrage:Show(icon)
            end
            
            -- arcane_barrage,if=cooldown.touch_of_the_magi.remains=0&(cooldown.rune_of_power.remains=0|cooldown.arcane_power.remains=0)&buff.arcane_charge.stack=buff.arcane_charge.max_stack
            if A.ArcaneBarrage:IsReady(unit) and (A.TouchoftheMagi:GetCooldown() == 0 and (A.RuneofPower:GetCooldown() == 0 or A.ArcanePower:GetCooldown() == 0) and Unit("player"):ArcaneChargesP == Unit("player"):ArcaneChargesMax) then
                return A.ArcaneBarrage:Show(icon)
            end
            
            -- arcane_barrage,if=mana.pct<=variable.barrage_mana_pct&buff.arcane_power.down&buff.rune_of_power.down&debuff.touch_of_the_magi.down&buff.arcane_charge.stack=buff.arcane_charge.max_stack&cooldown.evocation.remains>0
            if A.ArcaneBarrage:IsReady(unit) and (Player:ManaPercentageP() <= VarBarrageManaPct and Unit("player"):HasBuffsDown(A.ArcanePowerBuff.ID, true) and Unit("player"):HasBuffsDown(A.RuneofPowerBuff.ID, true) and Unit(unit):HasDeBuffsDown(A.TouchoftheMagiDebuff.ID, true) and Unit("player"):ArcaneChargesP == Unit("player"):ArcaneChargesMax and A.Evocation:GetCooldown() > 0) then
                return A.ArcaneBarrage:Show(icon)
            end
            
            -- arcane_barrage,if=buff.arcane_power.down&buff.rune_of_power.down&debuff.touch_of_the_magi.down&buff.arcane_charge.stack=buff.arcane_charge.max_stack&talent.arcane_orb.enabled&cooldown.arcane_orb.remains<=gcd&mana.pct<=90&cooldown.evocation.remains>0
            if A.ArcaneBarrage:IsReady(unit) and (Unit("player"):HasBuffsDown(A.ArcanePowerBuff.ID, true) and Unit("player"):HasBuffsDown(A.RuneofPowerBuff.ID, true) and Unit(unit):HasDeBuffsDown(A.TouchoftheMagiDebuff.ID, true) and Unit("player"):ArcaneChargesP == Unit("player"):ArcaneChargesMax and A.ArcaneOrb:IsSpellLearned() and A.ArcaneOrb:GetCooldown() <= GetGCD() and Player:ManaPercentageP() <= 90 and A.Evocation:GetCooldown() > 0) then
                return A.ArcaneBarrage:Show(icon)
            end
            
            -- arcane_barrage,if=buff.arcane_power.up&buff.arcane_power.remains<=gcd&buff.arcane_charge.stack=buff.arcane_charge.max_stack
            if A.ArcaneBarrage:IsReady(unit) and (Unit("player"):HasBuffs(A.ArcanePowerBuff.ID, true) and Unit("player"):HasBuffs(A.ArcanePowerBuff.ID, true) <= GetGCD() and Unit("player"):ArcaneChargesP == Unit("player"):ArcaneChargesMax) then
                return A.ArcaneBarrage:Show(icon)
            end
            
            -- arcane_barrage,if=buff.rune_of_power.up&buff.rune_of_power.remains<=gcd&buff.arcane_charge.stack=buff.arcane_charge.max_stack
            if A.ArcaneBarrage:IsReady(unit) and (Unit("player"):HasBuffs(A.RuneofPowerBuff.ID, true) and Unit("player"):HasBuffs(A.RuneofPowerBuff.ID, true) <= GetGCD() and Unit("player"):ArcaneChargesP == Unit("player"):ArcaneChargesMax) then
                return A.ArcaneBarrage:Show(icon)
            end
            
            -- arcane_barrage,if=buff.arcane_power.down&buff.rune_of_power.down&debuff.touch_of_the_magi.up&debuff.touch_of_the_magi.remains<=gcd&buff.arcane_charge.stack=buff.arcane_charge.max_stack
            if A.ArcaneBarrage:IsReady(unit) and (Unit("player"):HasBuffsDown(A.ArcanePowerBuff.ID, true) and Unit("player"):HasBuffsDown(A.RuneofPowerBuff.ID, true) and Unit(unit):HasDeBuffs(A.TouchoftheMagiDebuff.ID, true) and Unit(unit):HasDeBuffs(A.TouchoftheMagiDebuff.ID, true) <= GetGCD() and Unit("player"):ArcaneChargesP == Unit("player"):ArcaneChargesMax) then
                return A.ArcaneBarrage:Show(icon)
            end
            
            -- arcane_blast
            if A.ArcaneBlast:IsReady(unit) then
                return A.ArcaneBlast:Show(icon)
            end
            
            -- evocation,interrupt_if=mana.pct>=85,interrupt_immediate=1
            if A.Evocation:IsReady(unit) then
                return A.Evocation:Show(icon)
            end
            
            -- arcane_barrage
            if A.ArcaneBarrage:IsReady(unit) then
                return A.ArcaneBarrage:Show(icon)
            end
            
        end
        
        --SharedCds
        local function SharedCds(unit)
        
            -- use_mana_gem,if=(talent.enlightened.enabled&mana.pct<=80&mana.pct>=65)|(!talent.enlightened.enabled&mana.pct<=85)
            if A.UseManaGem:IsReady(unit) and ((A.Enlightened:IsSpellLearned() and Player:ManaPercentageP() <= 80 and Player:ManaPercentageP() >= 65) or (not A.Enlightened:IsSpellLearned() and Player:ManaPercentageP() <= 85)) then
                return A.UseManaGem:Show(icon)
            end
            
            -- use_items,if=buff.arcane_power.up
            -- potion,if=buff.arcane_power.up
            if A.PotionofSpectralIntellect:IsReady(unit) and Potion and (Unit("player"):HasBuffs(A.ArcanePowerBuff.ID, true)) then
                return A.PotionofSpectralIntellect:Show(icon)
            end
            
            -- time_warp,if=runeforge.temporal_warp.equipped&buff.exhaustion.up
            -- lights_judgment,if=buff.arcane_power.down&buff.rune_of_power.down&debuff.touch_of_the_magi.down
            if A.LightsJudgment:IsReady(unit) and A.BurstIsON(unit) and (Unit("player"):HasBuffsDown(A.ArcanePowerBuff.ID, true) and Unit("player"):HasBuffsDown(A.RuneofPowerBuff.ID, true) and Unit(unit):HasDeBuffsDown(A.TouchoftheMagiDebuff.ID, true)) then
                return A.LightsJudgment:Show(icon)
            end
            
            -- bag_of_tricks,if=buff.arcane_power.down&buff.rune_of_power.down&debuff.touch_of_the_magi.down
            if A.BagofTricks:IsReady(unit) and (Unit("player"):HasBuffsDown(A.ArcanePowerBuff.ID, true) and Unit("player"):HasBuffsDown(A.RuneofPowerBuff.ID, true) and Unit(unit):HasDeBuffsDown(A.TouchoftheMagiDebuff.ID, true)) then
                return A.BagofTricks:Show(icon)
            end
            
            -- berserking,if=buff.arcane_power.up
            if A.Berserking:AutoRacial(unit) and Racial and A.BurstIsON(unit) and (Unit("player"):HasBuffs(A.ArcanePowerBuff.ID, true)) then
                return A.Berserking:Show(icon)
            end
            
            -- blood_fury,if=buff.arcane_power.up
            if A.BloodFury:AutoRacial(unit) and Racial and A.BurstIsON(unit) and (Unit("player"):HasBuffs(A.ArcanePowerBuff.ID, true)) then
                return A.BloodFury:Show(icon)
            end
            
            -- fireblood,if=buff.arcane_power.up
            if A.Fireblood:AutoRacial(unit) and Racial and A.BurstIsON(unit) and (Unit("player"):HasBuffs(A.ArcanePowerBuff.ID, true)) then
                return A.Fireblood:Show(icon)
            end
            
            -- ancestral_call,if=buff.arcane_power.up
            if A.AncestralCall:AutoRacial(unit) and Racial and A.BurstIsON(unit) and (Unit("player"):HasBuffs(A.ArcanePowerBuff.ID, true)) then
                return A.AncestralCall:Show(icon)
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

                    -- counterspell,if=target.debuff.casting.react
            -- call_action_list,name=shared_cds
            if SharedCds(unit) then
                return true
            end
            
            -- call_action_list,name=essences
            if Essences(unit) then
                return true
            end
            
            -- call_action_list,name=aoe,if=active_enemies>2
            if (MultiUnits:GetByRangeInCombat(40, 5, 10) > 2) then
                if Aoe(unit) then
                    return true
                end
            end
            
            -- call_action_list,name=opener,if=variable.have_opened<=0
            if (VarHaveOpened <= 0) then
                if Opener(unit) then
                    return true
                end
            end
            
            -- call_action_list,name=am_spam,if=variable.am_spam=1
            if (VarAmSpam == 1) then
                if AmSpam(unit) then
                    return true
                end
            end
            
            -- call_action_list,name=cooldowns
            if Cooldowns(unit) then
                return true
            end
            
            -- call_action_list,name=rotation,if=variable.final_burn=0
            if (VarFinalBurn == 0) then
                if Rotation(unit) then
                    return true
                end
            end
            
            -- call_action_list,name=final_burn,if=variable.final_burn=1
            if (VarFinalBurn == 1) then
                if FinalBurn(unit) then
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

