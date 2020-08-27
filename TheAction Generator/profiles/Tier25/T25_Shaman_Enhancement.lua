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

Action[ACTION_CONST_SHAMAN_ENHANCEMENT] = {
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
    LightningShield                        = Create({ Type = "Spell", ID = 192106 }),
    CrashLightning                         = Create({ Type = "Spell", ID = 187874 }),
    CrashLightningBuff                     = Create({ Type = "Spell", ID = 187874 }),
    Rockbiter                              = Create({ Type = "Spell", ID = 193786 }),
    Landslide                              = Create({ Type = "Spell", ID = 197992 }),
    LandslideBuff                          = Create({ Type = "Spell", ID = 202004 }),
    Windstrike                             = Create({ Type = "Spell", ID = 115356 }),
    Berserking                             = Create({ Type = "Spell", ID = 26297 }),
    BloodFury                              = Create({ Type = "Spell", ID = 20572 }),
    Fireblood                              = Create({ Type = "Spell", ID = 265221 }),
    AncestralCall                          = Create({ Type = "Spell", ID = 274738 }),
    AscendanceBuff                         = Create({ Type = "Spell", ID = 114051 }),
    Ascendance                             = Create({ Type = "Spell", ID = 114051 }),
    FeralSpirit                            = Create({ Type = "Spell", ID = 51533 }),
    BloodoftheEnemyBuff                    = Create({ Type = "Spell", ID = 297108 }),
    Strike                                 = Create({ Type = "Spell", ID =  }),
    MoltenWeaponBuff                       = Create({ Type = "Spell", ID =  }),
    CracklingSurgeBuff                     = Create({ Type = "Spell", ID =  }),
    IcyEdgeBuff                            = Create({ Type = "Spell", ID =  }),
    EarthenSpikeDebuff                     = Create({ Type = "Spell", ID = 188089 }),
    EarthenSpike                           = Create({ Type = "Spell", ID = 188089 }),
    Stormstrike                            = Create({ Type = "Spell", ID = 17364 }),
    LightningConduit                       = Create({ Type = "Spell", ID = 275388 }),
    LightningConduitDebuff                 = Create({ Type = "Spell", ID = 275391 }),
    StormbringerBuff                       = Create({ Type = "Spell", ID = 201845 }),
    GatheringStormsBuff                    = Create({ Type = "Spell", ID = 198300 }),
    LightningBolt                          = Create({ Type = "Spell", ID = 187837 }),
    Overcharge                             = Create({ Type = "Spell", ID = 210727 }),
    Sundering                              = Create({ Type = "Spell", ID = 197214 }),
    Thundercharge                          = Create({ Type = "Spell", ID =  }),
    ReapingFlames                          = Create({ Type = "Spell", ID =  }),
    BagofTricks                            = Create({ Type = "Spell", ID =  }),
    ForcefulWinds                          = Create({ Type = "Spell", ID = 262647 }),
    Flametongue                            = Create({ Type = "Spell", ID = 193796 }),
    SearingAssault                         = Create({ Type = "Spell", ID = 192087 }),
    LavaLash                               = Create({ Type = "Spell", ID = 60103 }),
    PrimalPrimer                           = Create({ Type = "Spell", ID = 272992 }),
    HotHand                                = Create({ Type = "Spell", ID = 201900 }),
    HotHandBuff                            = Create({ Type = "Spell", ID = 215785 }),
    StrengthofEarthBuff                    = Create({ Type = "Spell", ID = 273465 }),
    CrashingStorm                          = Create({ Type = "Spell", ID = 192246 }),
    Frostbrand                             = Create({ Type = "Spell", ID = 196834 }),
    Hailstorm                              = Create({ Type = "Spell", ID = 210853 }),
    FrostbrandBuff                         = Create({ Type = "Spell", ID = 196834 }),
    PrimalPrimerDebuff                     = Create({ Type = "Spell", ID = 273006 }),
    FlametongueBuff                        = Create({ Type = "Spell", ID = 194084 }),
    FuryofAir                              = Create({ Type = "Spell", ID = 197211 }),
    FuryofAirBuff                          = Create({ Type = "Spell", ID = 197211 }),
    TotemMastery                           = Create({ Type = "Spell", ID = 262395 }),
    ResonanceTotemBuff                     = Create({ Type = "Spell", ID = 262419 }),
    SunderingDebuff                        = Create({ Type = "Spell", ID = 197214 }),
    SeethingRageBuff                       = Create({ Type = "Spell", ID =  }),
    NaturalHarmony                         = Create({ Type = "Spell", ID = 278697 }),
    NaturalHarmonyFrostBuff                = Create({ Type = "Spell", ID = 279029 }),
    NaturalHarmonyFireBuff                 = Create({ Type = "Spell", ID = 279028 }),
    NaturalHarmonyNatureBuff               = Create({ Type = "Spell", ID = 279033 }),
    WindShear                              = Create({ Type = "Spell", ID = 57994 }),
    Boulderfist                            = Create({ Type = "Spell", ID = 246035 }),
    StrengthofEarth                        = Create({ Type = "Spell", ID = 273461 })
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
Action:CreateEssencesFor(ACTION_CONST_SHAMAN_ENHANCEMENT)  -- where PLAYERSPEC is Constance (example: ACTION_CONST_MONK_BM)
local A = setmetatable(Action[ACTION_CONST_SHAMAN_ENHANCEMENT], { __index = Action })


------------------------------------------
---------------- VARIABLES ---------------
------------------------------------------
local VarFurycheckCl = 0;
local VarCooldownSync = 0;
local VarFurycheckEs = 0;
local VarFurycheckSs = 0;
local VarFurycheckLb = 0;
local VarOcpoolSs = 0;
local VarOcpoolCl = 0;
local VarOcpoolLl = 0;
local VarFurycheckLl = 0;
local VarFurycheckFb = 0;
local VarClpoolLl = 0;
local VarClpoolSs = 0;
local VarFreezerburnEnabled = 0;
local VarOcpool = 0;
local VarOcpoolFb = 0;
local VarRockslideEnabled = 0;

A.Listener:Add("ROTATION_VARS", "PLAYER_REGEN_ENABLED", function()
  VarFurycheckCl = 0
  VarCooldownSync = 0
  VarFurycheckEs = 0
  VarFurycheckSs = 0
  VarFurycheckLb = 0
  VarOcpoolSs = 0
  VarOcpoolCl = 0
  VarOcpoolLl = 0
  VarFurycheckLl = 0
  VarFurycheckFb = 0
  VarClpoolLl = 0
  VarClpoolSs = 0
  VarFreezerburnEnabled = 0
  VarOcpool = 0
  VarOcpoolFb = 0
  VarRockslideEnabled = 0
end)



local function num(val)
    if val then return 1 else return 0 end
end

local function bool(val)
    return val ~= 0
end

------------------------------------------
------- ENHANCEMENT PRE APL SETUP --------
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
local player = "player"

local function IsSchoolFree()
	return LoC:IsMissed("SILENCE") and LoC:Get("SCHOOL_INTERRUPT", "SHADOW") == 0
end 

local function InRange(unit)
	-- @return boolean 
	return A.LavaLash:IsInRange(unit)
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

-- API - Tracker
-- Initialize Tracker 
Pet:AddTrackers(ACTION_CONST_SHAMAN_ENCHANCEMENT, { -- this template table is the same with what has this library already built-in, just for example
    [29264] = {
        name = "Spirit Wolves",
        duration = 15,
    },
})

-- Function to check for Infernal duration
local function SpiritWolvesTime()
    return Pet:GetRemainDuration(29264) or 0
end 
SpiritWolvesTime = A.MakeFunctionCachedStatic(SpiritWolvesTime)

local function ResonanceTotemTime()
    for index = 1, 4 do
        local _, totemName, startTime, duration = GetTotemInfo(index)
        if totemName == A.TotemMastery:Info() then
            return (floor(startTime + duration - TMW.time + 0.5)) or 0
        end
    end
    return 0
end
ResonanceTotemTime = A.MakeFunctionCachedStatic(ResonanceTotemTime)

-- [1] CC AntiFake Rotation
local function AntiFakeStun(unit) 
    return 
    A.IsUnitEnemy(unit) and  
    Unit(unit):GetRange() <= 20 and 
    Unit(unit):IsControlAble("incapacitate", 0) and 
    A.HexGreen:AbsentImun(unit, Temp.TotalAndPhysAndCCAndStun, true)          
end 
A[1] = function(icon)    
    if	A.HexGreen:IsReady(nil, nil, nil, true) and 
    (
        AntiFakeStun("mouseover") or 
        AntiFakeStun("target") or 
        (
            not A.IsUnitEnemy("mouseover") and 
            not A.IsUnitEnemy("target")
        )
    )
    then 
        return A.HexGreen:Show(icon)         
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
            -- Pummel		
            if not notKickAble and A.WindShearGreen:IsReady(unit, nil, nil, true) and A.WindShearGreen:AbsentImun(unit, Temp.TotalAndPhysKick, true) then
                return A.WindShearGreen:Show(icon)                                                  
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
    if not A.WindShear:IsReadyByPassCastGCD(unit) or not A.WindShear:AbsentImun(unit, Temp.TotalAndMagKick) then
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
	    -- WindShear
        if useKick and A.WindShear:IsReady(unit) then 
	        -- Notification					
            Action.SendNotification("Wind Shear interrupting on " .. unit, A.WindShear.ID)
            return A.WindShear
        end 
	
        -- CapacitorTotem
        if useCC and Action.GetToggle(2, "UseCapacitorTotem") and A.WindShear:GetCooldown() > 0 and A.CapacitorTotem:IsReady(player) then 
			-- Notification					
            Action.SendNotification("Capacitor Totem interrupting", A.CapacitorTotem.ID)
            return A.CapacitorTotem
        end  
    
        -- Hex	
        if useCC and A.Hex:IsReady(unit) and A.Hex:AbsentImun(unit, Temp.TotalAndCC, true) and Unit(unit):IsControlAble("incapacitate", 0) then 
	        -- Notification					
            Action.SendNotification("Hex interrupting", A.Hex.ID)
            return A.Hex              
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
    
    -- EarthShieldHP
    local EarthShield = Action.GetToggle(2, "EarthShieldHP")
    if     EarthShield >= 0 and A.EarthShield:IsReady(player) and  
    (
        (     -- Auto 
            EarthShield >= 100 and 
            (
                Unit(player):HasBuffsStacks(A.EarthShield.ID, true) <= 3 
                or A.IsInPvP and Unit(player):HasBuffsStacks(A.EarthShield.ID, true) <= 2
            ) 
        ) or 
        (    -- Custom
            EarthShield < 100 and 
            Unit(player):HasBuffs(A.EarthShield.ID, true) <= 5 and 
            Unit(player):HealthPercent() <= EarthShield
        )
    ) 
    then 
        return A.EarthShield
    end
    
    -- HealingSurgeHP
    local HealingSurge = Action.GetToggle(2, "HealingSurgeHP")
    if     HealingSurge >= 0 and A.HealingSurge:IsReady(player) and Player:Maelstrom() > 20 and Unit("player"):CombatTime() > 2  and
    (
        (     -- Auto 
            HealingSurge >= 100 and 
            (
                -- HP lose per sec >= 10
                Unit(player):GetDMG() * 100 / Unit(player):HealthMax() >= 10 or 
                Unit(player):GetRealTimeDMG() >= Unit(player):HealthMax() * 0.10 or 
                -- TTD 
                Unit(player):TimeToDieX(25) < 5 or 
                (
                    A.IsInPvP and 
                    (
                        Unit(player):UseDeff() or 
                        (
                            Unit(player, 5):HasFlags() and 
                            Unit(player):GetRealTimeDMG() > 0 and 
                            Unit(player):IsFocused() 
                        )
                    )
                )
            ) and 
            Unit(player):HasBuffs("DeffBuffs", true) == 0
        ) or 
        (    -- Custom
            HealingSurge < 100 and 
            Unit(player):HealthPercent() <= HealingSurge
        )
    ) 
    then 
        return A.HealingSurge
    end
    
    -- Abyssal Healing Potion
    local AbyssalHealingPotion = Action.GetToggle(2, "AbyssalHealingPotionHP")
    if     AbyssalHealingPotion >= 0 and A.AbyssalHealingPotion:IsReady(player) and 
    (
        (     -- Auto 
            AbyssalHealingPotion >= 100 and 
            (
                -- HP lose per sec >= 25
                Unit(player):GetDMG() * 100 / Unit(player):HealthMax() >= 25 or 
                Unit(player):GetRealTimeDMG() >= Unit(player):HealthMax() * 0.25 or 
                -- TTD 
                Unit(player):TimeToDieX(25) < 5 or 
                (
                    A.IsInPvP and 
                    (
                        Unit(player):UseDeff() or 
                        (
                            Unit(player, 5):HasFlags() and 
                            Unit(player):GetRealTimeDMG() > 0 and 
                            Unit(player):IsFocused() 
                        )
                    )
                )
            ) and 
            Unit(player):HasBuffs("DeffBuffs", true) == 0
        ) or 
        (    -- Custom
            AbyssalHealingPotion < 100 and 
            Unit(player):HealthPercent() <= AbyssalHealingPotion
        )
    ) 
    then 
        return A.AbyssalHealingPotion
    end  
    
    -- AstralShift
    local AstralShift = Action.GetToggle(2, "AstralShiftHP")
    if     AstralShift >= 0 and A.AstralShift:IsReady(player) and 
    (
        (     -- Auto 
            AstralShift >= 100 and 
            (
                -- HP lose per sec >= 20
                Unit(player):GetDMG() * 100 / Unit(player):HealthMax() >= 20 or 
                Unit(player):GetRealTimeDMG() >= Unit(player):HealthMax() * 0.20 or 
                -- TTD 
                Unit(player):TimeToDieX(25) < 5 or 
                (
                    A.IsInPvP and 
                    (
                        Unit(player):UseDeff() or 
                        (
                            Unit(player, 5):HasFlags() and 
                            Unit(player):GetRealTimeDMG() > 0 and 
                            Unit(player):IsFocused() 
                        )
                    )
                )
            ) and 
            Unit(player):HasBuffs("DeffBuffs", true) == 0
        ) or 
        (    -- Custom
            AstralShift < 100 and 
            Unit(player):HealthPercent() <= AstralShift
        )
    ) 
    then 
        return A.AstralShift
    end     
    -- Stoneform on self dispel (only PvE)
    if A.Stoneform:IsRacialReady(player, true) and not A.IsInPvP and A.AuraIsValid(player, "UseDispel", "Dispel") then 
        return A.Stoneform
    end 
end 
SelfDefensives = A.MakeFunctionCachedStatic(SelfDefensives)

local function EvaluateCycleStormstrike127(unit)
  return MultiUnits:GetByRangeInCombat(40, 5, 10) > 1 and A.LightningConduit:GetAzeriteRank() > 0 and not Unit(unit):HasDeBuffs(A.LightningConduitDebuff.ID, true) and VarFurycheckSs
end

local function EvaluateTargetIfFilterLavaLash285(unit)
  return Unit(unit):HasDeBuffsStacks(A.PrimalPrimerDebuff.ID, true)
end

local function EvaluateTargetIfLavaLash300(unit)
  return A.PrimalPrimer:GetAzeriteRank() >= 2 and Unit(unit):HasDeBuffsStacks(A.PrimalPrimerDebuff.ID, true) == 10 and VarFurycheckLl and VarClpoolLl
end


local function EvaluateCycleStormstrike311(unit)
  return MultiUnits:GetByRangeInCombat(40, 5, 10) > 1 and A.LightningConduit:GetAzeriteRank() > 0 and not Unit(unit):HasDeBuffs(A.LightningConduitDebuff.ID, true) and VarFurycheckSs
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
            if A.PotionofSpectralAgility:IsReady(unit) and Potion then
                return A.PotionofSpectralAgility:Show(icon)
            end
            
            -- lightning_shield
            if A.LightningShield:IsReady(unit) then
                return A.LightningShield:Show(icon)
            end
            
            -- use_item,name=azsharas_font_of_power
            if A.AzsharasFontofPower:IsReady(unit) then
                return A.AzsharasFontofPower:Show(icon)
            end
            
        end
        
        --Asc
        local function Asc(unit)
        
            -- crash_lightning,if=!buff.crash_lightning.up&active_enemies>1&variable.furyCheck_CL
            if A.CrashLightning:IsReady(unit) and (not Unit("player"):HasBuffs(A.CrashLightningBuff.ID, true) and MultiUnits:GetByRangeInCombat(8, 5, 10) > 1 and VarFurycheckCl) then
                return A.CrashLightning:Show(icon)
            end
            
            -- rockbiter,if=talent.landslide.enabled&!buff.landslide.up&charges_fractional>1.7
            if A.Rockbiter:IsReady(unit) and (A.Landslide:IsSpellLearned() and not Unit("player"):HasBuffs(A.LandslideBuff.ID, true) and A.Rockbiter:GetSpellChargesFrac() > 1.7) then
                return A.Rockbiter:Show(icon)
            end
            
            -- windstrike
            if A.Windstrike:IsReady(unit) then
                return A.Windstrike:Show(icon)
            end
            
        end
        
        --Cds
        local function Cds(unit)
        
            -- bloodlust,if=azerite.ancestral_resonance.enabled
            -- worldvein_resonance
            if A.WorldveinResonance:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth then
                return A.WorldveinResonance:Show(icon)
            end
            
            -- berserking,if=variable.cooldown_sync
            if A.Berserking:AutoRacial(unit) and Racial and A.BurstIsON(unit) and (VarCooldownSync) then
                return A.Berserking:Show(icon)
            end
            
            -- use_item,name=azsharas_font_of_power
            if A.AzsharasFontofPower:IsReady(unit) then
                return A.AzsharasFontofPower:Show(icon)
            end
            
            -- blood_fury,if=variable.cooldown_sync
            if A.BloodFury:AutoRacial(unit) and Racial and A.BurstIsON(unit) and (VarCooldownSync) then
                return A.BloodFury:Show(icon)
            end
            
            -- fireblood,if=variable.cooldown_sync
            if A.Fireblood:AutoRacial(unit) and Racial and A.BurstIsON(unit) and (VarCooldownSync) then
                return A.Fireblood:Show(icon)
            end
            
            -- ancestral_call,if=variable.cooldown_sync
            if A.AncestralCall:AutoRacial(unit) and Racial and A.BurstIsON(unit) and (VarCooldownSync) then
                return A.AncestralCall:Show(icon)
            end
            
            -- potion,if=buff.ascendance.up|!talent.ascendance.enabled&feral_spirit.remains>5|target.time_to_die<=60
            if A.PotionofSpectralAgility:IsReady(unit) and Potion and (Unit("player"):HasBuffs(A.AscendanceBuff.ID, true) or not A.Ascendance:IsSpellLearned() and feral_spirit.remains > 5 or Unit(unit):TimeToDie() <= 60) then
                return A.PotionofSpectralAgility:Show(icon)
            end
            
            -- guardian_of_azeroth
            if A.GuardianofAzeroth:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth then
                return A.GuardianofAzeroth:Show(icon)
            end
            
            -- feral_spirit
            if A.FeralSpirit:IsReady(unit) then
                return A.FeralSpirit:Show(icon)
            end
            
            -- blood_of_the_enemy,if=raid_event.adds.in>90|active_enemies>1
            if A.BloodoftheEnemy:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and (IncomingAddsIn > 90 or MultiUnits:GetByRangeInCombat(40, 5, 10) > 1) then
                return A.BloodoftheEnemy:Show(icon)
            end
            
            -- ascendance,if=cooldown.strike.remains>0
            if A.Ascendance:IsReady(unit) and (A.Strike:GetCooldown() > 0) then
                return A.Ascendance:Show(icon)
            end
            
            -- use_item,name=ashvanes_razor_coral,if=debuff.razor_coral_debuff.down|(target.time_to_die<20&debuff.razor_coral_debuff.stack>2)
            if A.AshvanesRazorCoral:IsReady(unit) and (Unit(unit):HasDeBuffsDown(A.RazorCoralDebuff.ID, true) or (Unit(unit):TimeToDie() < 20 and Unit(unit):HasDeBuffsStacks(A.RazorCoralDebuff.ID, true) > 2)) then
                return A.AshvanesRazorCoral:Show(icon)
            end
            
            -- use_item,name=ashvanes_razor_coral,if=debuff.razor_coral_debuff.stack>2&debuff.conductive_ink_debuff.down&(buff.ascendance.remains>10|buff.molten_weapon.remains>10|buff.crackling_surge.remains>10|buff.icy_edge.remains>10|debuff.earthen_spike.remains>6)
            if A.AshvanesRazorCoral:IsReady(unit) and (Unit(unit):HasDeBuffsStacks(A.RazorCoralDebuff.ID, true) > 2 and Unit(unit):HasDeBuffsDown(A.ConductiveInkDebuff.ID, true) and (Unit("player"):HasBuffs(A.AscendanceBuff.ID, true) > 10 or Unit("player"):HasBuffs(A.MoltenWeaponBuff.ID, true) > 10 or Unit("player"):HasBuffs(A.CracklingSurgeBuff.ID, true) > 10 or Unit("player"):HasBuffs(A.IcyEdgeBuff.ID, true) > 10 or Unit(unit):HasDeBuffs(A.EarthenSpikeDebuff.ID, true) > 6)) then
                return A.AshvanesRazorCoral:Show(icon)
            end
            
            -- use_item,name=ashvanes_razor_coral,if=(debuff.conductive_ink_debuff.up|buff.ascendance.remains>10|buff.molten_weapon.remains>10|buff.crackling_surge.remains>10|buff.icy_edge.remains>10|debuff.earthen_spike.remains>6)&target.health.pct<31
            if A.AshvanesRazorCoral:IsReady(unit) and ((Unit(unit):HasDeBuffs(A.ConductiveInkDebuff.ID, true) or Unit("player"):HasBuffs(A.AscendanceBuff.ID, true) > 10 or Unit("player"):HasBuffs(A.MoltenWeaponBuff.ID, true) > 10 or Unit("player"):HasBuffs(A.CracklingSurgeBuff.ID, true) > 10 or Unit("player"):HasBuffs(A.IcyEdgeBuff.ID, true) > 10 or Unit(unit):HasDeBuffs(A.EarthenSpikeDebuff.ID, true) > 6) and Unit(unit):HealthPercent() < 31) then
                return A.AshvanesRazorCoral:Show(icon)
            end
            
            -- use_items
            -- earth_elemental
        end
        
        --DefaultCore
        local function DefaultCore(unit)
        
            -- earthen_spike,if=variable.furyCheck_ES
            if A.EarthenSpike:IsReady(unit) and (VarFurycheckEs) then
                return A.EarthenSpike:Show(icon)
            end
            
            -- stormstrike,cycle_targets=1,if=active_enemies>1&azerite.lightning_conduit.enabled&!debuff.lightning_conduit.up&variable.furyCheck_SS
            if A.Stormstrike:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.Stormstrike, 40, "min", EvaluateCycleStormstrike127) then
                    return A.Stormstrike:Show(icon) 
                end
            end
            -- stormstrike,if=buff.stormbringer.up|(active_enemies>1&buff.gathering_storms.up&variable.furyCheck_SS)
            if A.Stormstrike:IsReady(unit) and (Unit("player"):HasBuffs(A.StormbringerBuff.ID, true) or (MultiUnits:GetByRangeInCombat(40, 5, 10) > 1 and Unit("player"):HasBuffs(A.GatheringStormsBuff.ID, true) and VarFurycheckSs)) then
                return A.Stormstrike:Show(icon)
            end
            
            -- crash_lightning,if=active_enemies>=3&variable.furyCheck_CL
            if A.CrashLightning:IsReady(unit) and (MultiUnits:GetByRangeInCombat(8, 5, 10) >= 3 and VarFurycheckCl) then
                return A.CrashLightning:Show(icon)
            end
            
            -- lightning_bolt,if=talent.overcharge.enabled&active_enemies=1&variable.furyCheck_LB&maelstrom>=40
            if A.LightningBolt:IsReady(unit) and (A.Overcharge:IsSpellLearned() and MultiUnits:GetByRangeInCombat(40, 5, 10) == 1 and VarFurycheckLb and Player:Maelstrom() >= 40) then
                return A.LightningBolt:Show(icon)
            end
            
            -- stormstrike,if=variable.OCPool_SS&variable.furyCheck_SS
            if A.Stormstrike:IsReady(unit) and (VarOcpoolSs and VarFurycheckSs) then
                return A.Stormstrike:Show(icon)
            end
            
        end
        
        --Filler
        local function Filler(unit)
        
            -- sundering,if=raid_event.adds.in>40
            if A.Sundering:IsReady(unit) and (IncomingAddsIn > 40) then
                return A.Sundering:Show(icon)
            end
            
            -- focused_azerite_beam,if=raid_event.adds.in>90&!buff.ascendance.up&!buff.molten_weapon.up&!buff.icy_edge.up&!buff.crackling_surge.up&!debuff.earthen_spike.up
            if A.FocusedAzeriteBeam:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and (IncomingAddsIn > 90 and not Unit("player"):HasBuffs(A.AscendanceBuff.ID, true) and not Unit("player"):HasBuffs(A.MoltenWeaponBuff.ID, true) and not Unit("player"):HasBuffs(A.IcyEdgeBuff.ID, true) and not Unit("player"):HasBuffs(A.CracklingSurgeBuff.ID, true) and not Unit(unit):HasDeBuffs(A.EarthenSpikeDebuff.ID, true)) then
                return A.FocusedAzeriteBeam:Show(icon)
            end
            
            -- purifying_blast,if=raid_event.adds.in>60
            if A.PurifyingBlast:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and (IncomingAddsIn > 60) then
                return A.PurifyingBlast:Show(icon)
            end
            
            -- ripple_in_space,if=raid_event.adds.in>60
            if A.RippleInSpace:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and (IncomingAddsIn > 60) then
                return A.RippleInSpace:Show(icon)
            end
            
            -- thundercharge
            if A.Thundercharge:IsReady(unit) then
                return A.Thundercharge:Show(icon)
            end
            
            -- concentrated_flame
            if A.ConcentratedFlame:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth then
                return A.ConcentratedFlame:Show(icon)
            end
            
            -- reaping_flames
            if A.ReapingFlames:IsReady(unit) then
                return A.ReapingFlames:Show(icon)
            end
            
            -- bag_of_tricks
            if A.BagofTricks:IsReady(unit) then
                return A.BagofTricks:Show(icon)
            end
            
            -- crash_lightning,if=talent.forceful_winds.enabled&active_enemies>1&variable.furyCheck_CL
            if A.CrashLightning:IsReady(unit) and (A.ForcefulWinds:IsSpellLearned() and MultiUnits:GetByRangeInCombat(8, 5, 10) > 1 and VarFurycheckCl) then
                return A.CrashLightning:Show(icon)
            end
            
            -- flametongue,if=talent.searing_assault.enabled
            if A.Flametongue:IsReady(unit) and (A.SearingAssault:IsSpellLearned()) then
                return A.Flametongue:Show(icon)
            end
            
            -- lava_lash,if=!azerite.primal_primer.enabled&talent.hot_hand.enabled&buff.hot_hand.react
            if A.LavaLash:IsReady(unit) and (not A.PrimalPrimer:GetAzeriteRank() > 0 and A.HotHand:IsSpellLearned() and Unit("player"):HasBuffsStacks(A.HotHandBuff.ID, true)) then
                return A.LavaLash:Show(icon)
            end
            
            -- crash_lightning,if=active_enemies>1&variable.furyCheck_CL
            if A.CrashLightning:IsReady(unit) and (MultiUnits:GetByRangeInCombat(8, 5, 10) > 1 and VarFurycheckCl) then
                return A.CrashLightning:Show(icon)
            end
            
            -- rockbiter,if=maelstrom<70&!buff.strength_of_earth.up
            if A.Rockbiter:IsReady(unit) and (Player:Maelstrom() < 70 and not Unit("player"):HasBuffs(A.StrengthofEarthBuff.ID, true)) then
                return A.Rockbiter:Show(icon)
            end
            
            -- crash_lightning,if=(talent.crashing_storm.enabled|talent.forceful_winds.enabled)&variable.OCPool_CL
            if A.CrashLightning:IsReady(unit) and ((A.CrashingStorm:IsSpellLearned() or A.ForcefulWinds:IsSpellLearned()) and VarOcpoolCl) then
                return A.CrashLightning:Show(icon)
            end
            
            -- lava_lash,if=variable.OCPool_LL&variable.furyCheck_LL
            if A.LavaLash:IsReady(unit) and (VarOcpoolLl and VarFurycheckLl) then
                return A.LavaLash:Show(icon)
            end
            
            -- memory_of_lucid_dreams
            if A.MemoryofLucidDreams:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth then
                return A.MemoryofLucidDreams:Show(icon)
            end
            
            -- rockbiter
            if A.Rockbiter:IsReady(unit) then
                return A.Rockbiter:Show(icon)
            end
            
            -- frostbrand,if=talent.hailstorm.enabled&buff.frostbrand.remains<4.8+gcd&variable.furyCheck_FB
            if A.Frostbrand:IsReady(unit) and (A.Hailstorm:IsSpellLearned() and Unit("player"):HasBuffs(A.FrostbrandBuff.ID, true) < 4.8 + GetGCD() and VarFurycheckFb) then
                return A.Frostbrand:Show(icon)
            end
            
            -- flametongue
            if A.Flametongue:IsReady(unit) then
                return A.Flametongue:Show(icon)
            end
            
        end
        
        --FreezerburnCore
        local function FreezerburnCore(unit)
        
            -- lava_lash,target_if=max:debuff.primal_primer.stack,if=azerite.primal_primer.rank>=2&debuff.primal_primer.stack=10&variable.furyCheck_LL&variable.CLPool_LL
            if A.LavaLash:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.LavaLash, 40, "max", EvaluateTargetIfFilterLavaLash285, EvaluateTargetIfLavaLash300) then 
                    return A.LavaLash:Show(icon) 
                end
            end
            -- earthen_spike,if=variable.furyCheck_ES
            if A.EarthenSpike:IsReady(unit) and (VarFurycheckEs) then
                return A.EarthenSpike:Show(icon)
            end
            
            -- stormstrike,cycle_targets=1,if=active_enemies>1&azerite.lightning_conduit.enabled&!debuff.lightning_conduit.up&variable.furyCheck_SS
            if A.Stormstrike:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.Stormstrike, 40, "min", EvaluateCycleStormstrike311) then
                    return A.Stormstrike:Show(icon) 
                end
            end
            -- stormstrike,if=buff.stormbringer.up|(active_enemies>1&buff.gathering_storms.up&variable.furyCheck_SS)
            if A.Stormstrike:IsReady(unit) and (Unit("player"):HasBuffs(A.StormbringerBuff.ID, true) or (MultiUnits:GetByRangeInCombat(40, 5, 10) > 1 and Unit("player"):HasBuffs(A.GatheringStormsBuff.ID, true) and VarFurycheckSs)) then
                return A.Stormstrike:Show(icon)
            end
            
            -- crash_lightning,if=active_enemies>=3&variable.furyCheck_CL
            if A.CrashLightning:IsReady(unit) and (MultiUnits:GetByRangeInCombat(8, 5, 10) >= 3 and VarFurycheckCl) then
                return A.CrashLightning:Show(icon)
            end
            
            -- lightning_bolt,if=talent.overcharge.enabled&active_enemies=1&variable.furyCheck_LB&maelstrom>=40
            if A.LightningBolt:IsReady(unit) and (A.Overcharge:IsSpellLearned() and MultiUnits:GetByRangeInCombat(40, 5, 10) == 1 and VarFurycheckLb and Player:Maelstrom() >= 40) then
                return A.LightningBolt:Show(icon)
            end
            
            -- lava_lash,if=azerite.primal_primer.rank>=2&debuff.primal_primer.stack>7&variable.furyCheck_LL&variable.CLPool_LL
            if A.LavaLash:IsReady(unit) and (A.PrimalPrimer:GetAzeriteRank() >= 2 and Unit(unit):HasDeBuffsStacks(A.PrimalPrimerDebuff.ID, true) > 7 and VarFurycheckLl and VarClpoolLl) then
                return A.LavaLash:Show(icon)
            end
            
            -- stormstrike,if=variable.OCPool_SS&variable.furyCheck_SS&variable.CLPool_SS
            if A.Stormstrike:IsReady(unit) and (VarOcpoolSs and VarFurycheckSs and VarClpoolSs) then
                return A.Stormstrike:Show(icon)
            end
            
            -- lava_lash,if=debuff.primal_primer.stack=10&variable.furyCheck_LL
            if A.LavaLash:IsReady(unit) and (Unit(unit):HasDeBuffsStacks(A.PrimalPrimerDebuff.ID, true) == 10 and VarFurycheckLl) then
                return A.LavaLash:Show(icon)
            end
            
        end
        
        --Maintenance
        local function Maintenance(unit)
        
            -- flametongue,if=!buff.flametongue.up
            if A.Flametongue:IsReady(unit) and (not Unit("player"):HasBuffs(A.FlametongueBuff.ID, true)) then
                return A.Flametongue:Show(icon)
            end
            
            -- frostbrand,if=talent.hailstorm.enabled&!buff.frostbrand.up&variable.furyCheck_FB
            if A.Frostbrand:IsReady(unit) and (A.Hailstorm:IsSpellLearned() and not Unit("player"):HasBuffs(A.FrostbrandBuff.ID, true) and VarFurycheckFb) then
                return A.Frostbrand:Show(icon)
            end
            
        end
        
        --Opener
        local function Opener(unit)
        
            -- rockbiter,if=maelstrom<15&time<gcd
            if A.Rockbiter:IsReady(unit) and (Player:Maelstrom() < 15 and Unit("player"):CombatTime() < GetGCD()) then
                return A.Rockbiter:Show(icon)
            end
            
        end
        
        --Priority
        local function Priority(unit)
        
            -- crash_lightning,if=active_enemies>=(8-(talent.forceful_winds.enabled*3))&variable.freezerburn_enabled&variable.furyCheck_CL
            if A.CrashLightning:IsReady(unit) and (MultiUnits:GetByRangeInCombat(8, 5, 10) >= (8 - (num(A.ForcefulWinds:IsSpellLearned()) * 3)) and VarFreezerburnEnabled and VarFurycheckCl) then
                return A.CrashLightning:Show(icon)
            end
            
            -- the_unbound_force,if=buff.reckless_force.up|time<5
            if A.TheUnboundForce:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and (Unit("player"):HasBuffs(A.RecklessForceBuff.ID, true) or Unit("player"):CombatTime() < 5) then
                return A.TheUnboundForce:Show(icon)
            end
            
            -- lava_lash,if=azerite.primal_primer.rank>=2&debuff.primal_primer.stack=10&active_enemies=1&variable.freezerburn_enabled&variable.furyCheck_LL
            if A.LavaLash:IsReady(unit) and (A.PrimalPrimer:GetAzeriteRank() >= 2 and Unit(unit):HasDeBuffsStacks(A.PrimalPrimerDebuff.ID, true) == 10 and MultiUnits:GetByRangeInCombat(40, 5, 10) == 1 and VarFreezerburnEnabled and VarFurycheckLl) then
                return A.LavaLash:Show(icon)
            end
            
            -- crash_lightning,if=!buff.crash_lightning.up&active_enemies>1&variable.furyCheck_CL
            if A.CrashLightning:IsReady(unit) and (not Unit("player"):HasBuffs(A.CrashLightningBuff.ID, true) and MultiUnits:GetByRangeInCombat(8, 5, 10) > 1 and VarFurycheckCl) then
                return A.CrashLightning:Show(icon)
            end
            
            -- fury_of_air,if=!buff.fury_of_air.up&maelstrom>=20&spell_targets.fury_of_air_damage>=(1+variable.freezerburn_enabled)
            if A.FuryofAir:IsReady(unit) and (not Unit("player"):HasBuffs(A.FuryofAirBuff.ID, true) and Player:Maelstrom() >= 20 and MultiUnits:GetByRangeInCombat(5, 5, 10) >= (1 + VarFreezerburnEnabled)) then
                return A.FuryofAir:Show(icon)
            end
            
            -- fury_of_air,if=buff.fury_of_air.up&&spell_targets.fury_of_air_damage<(1+variable.freezerburn_enabled)
            if A.FuryofAir:IsReady(unit) and (Unit("player"):HasBuffs(A.FuryofAirBuff.ID, true) and true and MultiUnits:GetByRangeInCombat(5, 5, 10) < (1 + VarFreezerburnEnabled)) then
                return A.FuryofAir:Show(icon)
            end
            
            -- totem_mastery,if=buff.resonance_totem.remains<=2*gcd
            if A.TotemMastery:IsReady(unit) and (Unit("player"):HasBuffs(A.ResonanceTotemBuff.ID, true) <= 2 * GetGCD()) then
                return A.TotemMastery:Show(icon)
            end
            
            -- sundering,if=active_enemies>=3&(!essence.blood_of_the_enemy.major|(essence.blood_of_the_enemy.major&(buff.seething_rage.up|cooldown.blood_of_the_enemy.remains>40)))
            if A.Sundering:IsReady(unit) and (MultiUnits:GetByRangeInCombat(8, 5, 10) >= 3 and (not Azerite:EssenceHasMajor(A.BloodoftheEnemy.ID) or (Azerite:EssenceHasMajor(A.BloodoftheEnemy.ID) and (Unit("player"):HasBuffs(A.SeethingRageBuff.ID, true) or A.BloodoftheEnemy:GetCooldown() > 40)))) then
                return A.Sundering:Show(icon)
            end
            
            -- focused_azerite_beam,if=active_enemies>1
            if A.FocusedAzeriteBeam:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and (MultiUnits:GetByRangeInCombat(40, 5, 10) > 1) then
                return A.FocusedAzeriteBeam:Show(icon)
            end
            
            -- purifying_blast,if=active_enemies>1
            if A.PurifyingBlast:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and (MultiUnits:GetByRangeInCombat(40, 5, 10) > 1) then
                return A.PurifyingBlast:Show(icon)
            end
            
            -- ripple_in_space,if=active_enemies>1
            if A.RippleInSpace:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and (MultiUnits:GetByRangeInCombat(40, 5, 10) > 1) then
                return A.RippleInSpace:Show(icon)
            end
            
            -- rockbiter,if=talent.landslide.enabled&!buff.landslide.up&charges_fractional>1.7
            if A.Rockbiter:IsReady(unit) and (A.Landslide:IsSpellLearned() and not Unit("player"):HasBuffs(A.LandslideBuff.ID, true) and A.Rockbiter:GetSpellChargesFrac() > 1.7) then
                return A.Rockbiter:Show(icon)
            end
            
            -- frostbrand,if=(azerite.natural_harmony.enabled&buff.natural_harmony_frost.remains<=2*gcd)&talent.hailstorm.enabled&variable.furyCheck_FB
            if A.Frostbrand:IsReady(unit) and ((A.NaturalHarmony:GetAzeriteRank() > 0 and Unit("player"):HasBuffs(A.NaturalHarmonyFrostBuff.ID, true) <= 2 * GetGCD()) and A.Hailstorm:IsSpellLearned() and VarFurycheckFb) then
                return A.Frostbrand:Show(icon)
            end
            
            -- flametongue,if=(azerite.natural_harmony.enabled&buff.natural_harmony_fire.remains<=2*gcd)
            if A.Flametongue:IsReady(unit) and ((A.NaturalHarmony:GetAzeriteRank() > 0 and Unit("player"):HasBuffs(A.NaturalHarmonyFireBuff.ID, true) <= 2 * GetGCD())) then
                return A.Flametongue:Show(icon)
            end
            
            -- rockbiter,if=(azerite.natural_harmony.enabled&buff.natural_harmony_nature.remains<=2*gcd)&maelstrom<70
            if A.Rockbiter:IsReady(unit) and ((A.NaturalHarmony:GetAzeriteRank() > 0 and Unit("player"):HasBuffs(A.NaturalHarmonyNatureBuff.ID, true) <= 2 * GetGCD()) and Player:Maelstrom() < 70) then
                return A.Rockbiter:Show(icon)
            end
            
        end
        
        
        -- call precombat
        if Precombat(unit) and not inCombat and Unit(unit):IsExists() and unit ~= "mouseover" then 
            return true
        end

        -- In Combat
        if inCombat and Unit(unit):IsExists() then

                    -- wind_shear
            if A.WindShear:IsReady(unit) and Action.GetToggle.InterruptEnabled then
                return A.WindShear:Show(icon)
            end
            
            -- variable,name=cooldown_sync,value=(talent.ascendance.enabled&(buff.ascendance.up|cooldown.ascendance.remains>50))|(!talent.ascendance.enabled&(feral_spirit.remains>5|cooldown.feral_spirit.remains>50))
            VarCooldownSync = num((A.Ascendance:IsSpellLearned() and (Unit("player"):HasBuffs(A.AscendanceBuff.ID, true) or A.Ascendance:GetCooldown() > 50)) or (not A.Ascendance:IsSpellLearned() and (feral_spirit.remains > 5 or A.FeralSpirit:GetCooldown() > 50)))
            
            -- variable,name=furyCheck_SS,value=maelstrom>=(talent.fury_of_air.enabled*(6+action.stormstrike.cost))
            VarFurycheckSs = num(Player:Maelstrom() >= (num(A.FuryofAir:IsSpellLearned()) * (6 + A.Stormstrike:GetSpellPowerCostCache())))
            
            -- variable,name=furyCheck_LL,value=maelstrom>=(talent.fury_of_air.enabled*(6+action.lava_lash.cost))
            VarFurycheckLl = num(Player:Maelstrom() >= (num(A.FuryofAir:IsSpellLearned()) * (6 + A.LavaLash:GetSpellPowerCostCache())))
            
            -- variable,name=furyCheck_CL,value=maelstrom>=(talent.fury_of_air.enabled*(6+action.crash_lightning.cost))
            VarFurycheckCl = num(Player:Maelstrom() >= (num(A.FuryofAir:IsSpellLearned()) * (6 + A.CrashLightning:GetSpellPowerCostCache())))
            
            -- variable,name=furyCheck_FB,value=maelstrom>=(talent.fury_of_air.enabled*(6+action.frostbrand.cost))
            VarFurycheckFb = num(Player:Maelstrom() >= (num(A.FuryofAir:IsSpellLearned()) * (6 + A.Frostbrand:GetSpellPowerCostCache())))
            
            -- variable,name=furyCheck_ES,value=maelstrom>=(talent.fury_of_air.enabled*(6+action.earthen_spike.cost))
            VarFurycheckEs = num(Player:Maelstrom() >= (num(A.FuryofAir:IsSpellLearned()) * (6 + A.EarthenSpike:GetSpellPowerCostCache())))
            
            -- variable,name=furyCheck_LB,value=maelstrom>=(talent.fury_of_air.enabled*(6+40))
            VarFurycheckLb = num(Player:Maelstrom() >= (num(A.FuryofAir:IsSpellLearned()) * (6 + 40)))
            
            -- variable,name=OCPool,value=(active_enemies>1|(cooldown.lightning_bolt.remains>=2*gcd))
            VarOcpool = num((MultiUnits:GetByRangeInCombat(40, 5, 10) > 1 or (A.LightningBolt:GetCooldown() >= 2 * GetGCD())))
            
            -- variable,name=OCPool_SS,value=(variable.OCPool|maelstrom>=(talent.overcharge.enabled*(40+action.stormstrike.cost)))
            VarOcpoolSs = num((VarOcpool or Player:Maelstrom() >= (num(A.Overcharge:IsSpellLearned()) * (40 + A.Stormstrike:GetSpellPowerCostCache()))))
            
            -- variable,name=OCPool_LL,value=(variable.OCPool|maelstrom>=(talent.overcharge.enabled*(40+action.lava_lash.cost)))
            VarOcpoolLl = num((VarOcpool or Player:Maelstrom() >= (num(A.Overcharge:IsSpellLearned()) * (40 + A.LavaLash:GetSpellPowerCostCache()))))
            
            -- variable,name=OCPool_CL,value=(variable.OCPool|maelstrom>=(talent.overcharge.enabled*(40+action.crash_lightning.cost)))
            VarOcpoolCl = num((VarOcpool or Player:Maelstrom() >= (num(A.Overcharge:IsSpellLearned()) * (40 + A.CrashLightning:GetSpellPowerCostCache()))))
            
            -- variable,name=OCPool_FB,value=(variable.OCPool|maelstrom>=(talent.overcharge.enabled*(40+action.frostbrand.cost)))
            VarOcpoolFb = num((VarOcpool or Player:Maelstrom() >= (num(A.Overcharge:IsSpellLearned()) * (40 + A.Frostbrand:GetSpellPowerCostCache()))))
            
            -- variable,name=CLPool_LL,value=active_enemies=1|maelstrom>=(action.crash_lightning.cost+action.lava_lash.cost)
            VarClpoolLl = num(MultiUnits:GetByRangeInCombat(40, 5, 10) == 1 or Player:Maelstrom() >= (A.CrashLightning:GetSpellPowerCostCache() + A.LavaLash:GetSpellPowerCostCache()))
            
            -- variable,name=CLPool_SS,value=active_enemies=1|maelstrom>=(action.crash_lightning.cost+action.stormstrike.cost)
            VarClpoolSs = num(MultiUnits:GetByRangeInCombat(40, 5, 10) == 1 or Player:Maelstrom() >= (A.CrashLightning:GetSpellPowerCostCache() + A.Stormstrike:GetSpellPowerCostCache()))
            
            -- variable,name=freezerburn_enabled,value=(talent.hot_hand.enabled&talent.hailstorm.enabled&azerite.primal_primer.enabled)
            VarFreezerburnEnabled = num((A.HotHand:IsSpellLearned() and A.Hailstorm:IsSpellLearned() and A.PrimalPrimer:GetAzeriteRank() > 0))
            
            -- variable,name=rockslide_enabled,value=(!variable.freezerburn_enabled&(talent.boulderfist.enabled&talent.landslide.enabled&azerite.strength_of_earth.enabled))
            VarRockslideEnabled = num((not VarFreezerburnEnabled and (A.Boulderfist:IsSpellLearned() and A.Landslide:IsSpellLearned() and A.StrengthofEarth:GetAzeriteRank() > 0)))
            
            -- auto_attack
            -- call_action_list,name=opener
            if Opener(unit) then
                return true
            end
            
            -- call_action_list,name=asc,if=buff.ascendance.up
            if (Unit("player"):HasBuffs(A.AscendanceBuff.ID, true)) then
                if Asc(unit) then
                    return true
                end
            end
            
            -- call_action_list,name=priority
            if Priority(unit) then
                return true
            end
            
            -- call_action_list,name=maintenance,if=active_enemies<3
            if (MultiUnits:GetByRangeInCombat(40, 5, 10) < 3) then
                if Maintenance(unit) then
                    return true
                end
            end
            
            -- call_action_list,name=cds
            if Cds(unit) then
                return true
            end
            
            -- call_action_list,name=freezerburn_core,if=variable.freezerburn_enabled
            if (VarFreezerburnEnabled) then
                if FreezerburnCore(unit) then
                    return true
                end
            end
            
            -- call_action_list,name=default_core,if=!variable.freezerburn_enabled
            if (not VarFreezerburnEnabled) then
                if DefaultCore(unit) then
                    return true
                end
            end
            
            -- call_action_list,name=maintenance,if=active_enemies>=3
            if (MultiUnits:GetByRangeInCombat(40, 5, 10) >= 3) then
                if Maintenance(unit) then
                    return true
                end
            end
            
            -- call_action_list,name=filler
            if Filler(unit) then
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

