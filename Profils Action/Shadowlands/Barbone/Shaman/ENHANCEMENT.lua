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
--local Azerite									= LibStub("AzeriteTraits")
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
Action[ACTION_CONST_SHAMAN_ENCHANCEMENT] = {
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
    CrashLightningBuff                     = Create({ Type = "Spell", ID = 187874 , Hidden = true     }),
    Rockbiter                              = Create({ Type = "Spell", ID = 193786 }),
    Landslide                              = Create({ Type = "Spell", ID = 197992 }),
    LandslideBuff                          = Create({ Type = "Spell", ID = 202004 , Hidden = true     }),
    Windstrike                             = Create({ Type = "Spell", ID = 115356 }),
    AscendanceBuff                         = Create({ Type = "Spell", ID = 114051 , Hidden = true     }),
    Ascendance                             = Create({ Type = "Spell", ID = 114051 }),
    FeralSpirit                            = Create({ Type = "Spell", ID = 51533  }),
    BloodoftheEnemyBuff                    = Create({ Type = "Spell", ID = 297108 , Hidden = true     }),
    MoltenWeaponBuff                       = Create({ Type = "Spell", ID = 224125 , Hidden = true     }),
    CracklingSurgeBuff                     = Create({ Type = "Spell", ID = 224127 , Hidden = true     }),
    IcyEdgeBuff                            = Create({ Type = "Spell", ID = 224126 , Hidden = true     }),
    EarthenSpikeDebuff                     = Create({ Type = "Spell", ID = 188089 , Hidden = true}),
    EarthenSpike                           = Create({ Type = "Spell", ID = 188089 }),
    Stormstrike                            = Create({ Type = "Spell", ID = 17364  }),
    LightningConduit                       = Create({ Type = "Spell", ID = 275388 }),
    LightningConduitDebuff                 = Create({ Type = "Spell", ID = 275391 , Hidden = true}),
    StormbringerBuff                       = Create({ Type = "Spell", ID = 201845 , Hidden = true     }),
    GatheringStormsBuff                    = Create({ Type = "Spell", ID = 198300 , Hidden = true     }),
    LightningBolt                          = Create({ Type = "Spell", ID = 187837 }),
    Overcharge                             = Create({ Type = "Spell", ID = 210727 }),
    Sundering                              = Create({ Type = "Spell", ID = 197214 }),
    Thundercharge                          = Create({ Type = "Spell", ID = 204366 }),
    BagofTricks                            = Create({ Type = "Spell", ID = 312411 }),
    ForcefulWinds                          = Create({ Type = "Spell", ID = 262647 }),
    Flametongue                            = Create({ Type = "Spell", ID = 193796 }),
    SearingAssault                         = Create({ Type = "Spell", ID = 192087 }),
    LavaLash                               = Create({ Type = "Spell", ID = 60103  }),
    PrimalPrimer                           = Create({ Type = "Spell", ID = 272992 }),
    HotHand                                = Create({ Type = "Spell", ID = 201900 }),
    HotHandBuff                            = Create({ Type = "Spell", ID = 215785 , Hidden = true     }),
    StrengthofEarthBuff                    = Create({ Type = "Spell", ID = 273465 , Hidden = true     }),
    CrashingStorm                          = Create({ Type = "Spell", ID = 192246 }),
    Frostbrand                             = Create({ Type = "Spell", ID = 196834 }),
    Hailstorm                              = Create({ Type = "Spell", ID = 210853 }),
    FrostbrandBuff                         = Create({ Type = "Spell", ID = 196834 , Hidden = true     }),
    PrimalPrimerDebuff                     = Create({ Type = "Spell", ID = 273006 , Hidden = true}),
    FlametongueBuff                        = Create({ Type = "Spell", ID = 194084 , Hidden = true     }),
    FuryofAir                              = Create({ Type = "Spell", ID = 197211 }),
    FuryofAirBuff                          = Create({ Type = "Spell", ID = 197211 , Hidden = true     }),
    TotemMastery                           = Create({ Type = "Spell", ID = 262395 }),
    ResonanceTotemBuff                     = Create({ Type = "Spell", ID = 262419 , Hidden = true     }),
    SunderingDebuff                        = Create({ Type = "Spell", ID = 197214 , Hidden = true}),
    SeethingRageBuff                       = Create({ Type = "Spell", ID = 297126 , Hidden = true     }),
    NaturalHarmony                         = Create({ Type = "Spell", ID = 278697 }),
    NaturalHarmonyFrostBuff                = Create({ Type = "Spell", ID = 279029 , Hidden = true     }),
    NaturalHarmonyFireBuff                 = Create({ Type = "Spell", ID = 279028 , Hidden = true     }),
    NaturalHarmonyNatureBuff               = Create({ Type = "Spell", ID = 279033 , Hidden = true     }),
    WindShear                              = Create({ Type = "Spell", ID = 57994 }),
	WindShearGreen			    		   = Create({ Type = "SpellSingleColor", ID = 57994, Color = "GREEN", Desc = "[2] Kick", QueueForbidden = true}),
    Hex                                    = Create({ Type = "Spell", ID = 51514 }),	
	HexGreen	   						   = Create({ Type = "SpellSingleColor", ID = 51514, Color = "GREEN", Desc = "[1] CC", QueueForbidden = true}),
    Boulderfist                            = Create({ Type = "Spell", ID = 246035 }),
    StrengthofEarth                        = Create({ Type = "Spell", ID = 273461 }),
	EarthElemental                         = Create({ Type = "Spell", ID = 198103 }), -- Earth Elemental manual queue
    -- Utilities
    BloodLust                              = Create({ Type = "Spell", ID = 204361     }),
    LightningLasso                         = Create({ Type = "Spell", ID = 305483     }),
    CapacitorTotem                         = Create({ Type = "Spell", ID = 192058     }),
    GroundingTotem                         = Create({ Type = "Spell", ID = 204336     }),
    TremorTotem                            = Create({ Type = "Spell", ID = 8143     }),
    CounterStrikeTotem                     = Create({ Type = "Spell", ID = 204331     }),
    SkyfuryTotem                           = Create({ Type = "Spell", ID = 204330     }),
    FeralLunge                             = Create({ Type = "Spell", ID = 196884     }),
    Purge                                  = Create({ Type = "Spell", ID = 370     }),
    GhostWolf                              = Create({ Type = "Spell", ID = 2645     }),
    EarthShield                            = Create({ Type = "Spell", ID = 974     }),
    HealingSurge                           = Create({ Type = "Spell", ID = 8004     }),
    CleanseSpirit                          = Create({ Type = "Spell", ID = 51886     }), -- PartyDispell
    GhostWolfBuff                          = Create({ Type = "Spell", ID = 2645, Hidden = true     }),
    Shamanism                              = Create({ Type = "Spell", ID = 193876, Hidden = true     }), 
    AstralShift                            = Create({ Type = "Spell", ID = 108271     }),  	
	-- Oils
	EmbalmersOil                           = Action.Create({ Type = "Spell", ID = 171286, QueueForbidden = true }), 
    ShadowcoreOil                          = Action.Create({ Type = "Spell", ID = 171285, QueueForbidden = true }),  
    -- Potions
	-- stats
    PotionofSpectralAgility                = Action.Create({ Type = "Potion", ID = 171270, QueueForbidden = true }), 
    PotionofSpectralIntellect              = Action.Create({ Type = "Potion", ID = 171273, QueueForbidden = true }), 
	PotionofSpectralStrength               = Action.Create({ Type = "Potion", ID = 171275, QueueForbidden = true }), 
	PotionofSpectralStamina                = Action.Create({ Type = "Potion", ID = 171274, QueueForbidden = true }), 
	-- heal
	SpiritualHealingPotion                 = Action.Create({ Type = "Potion", ID = 171267, QueueForbidden = true }), 
	SpiritualManaPotion                    = Action.Create({ Type = "Potion", ID = 171268, QueueForbidden = true }), 
	SpiritualRejuvenationPotion            = Action.Create({ Type = "Potion", ID = 171269, QueueForbidden = true }), 
	PotionofSpiritualClarity               = Action.Create({ Type = "Potion", ID = 171272, QueueForbidden = true }), 
	-- combat effects potions
	PotionofDeathlyFixation                = Action.Create({ Type = "Potion", ID = 171351, QueueForbidden = true }), 
    PotionofEmpoweredExorcisms             = Action.Create({ Type = "Potion", ID = 171352, QueueForbidden = true }),
	PotionofPhantomFire                    = Action.Create({ Type = "Potion", ID = 171349, QueueForbidden = true }),
	PotionofDivineAwakening                = Action.Create({ Type = "Potion", ID = 171350, QueueForbidden = true }),
	PotionofSacrificialAnima               = Action.Create({ Type = "Potion", ID = 176811, QueueForbidden = true }),
    -- utilities potions
	PotionofHardenedShadows                = Action.Create({ Type = "Potion", ID = 171271, QueueForbidden = true }),
    PotionofShadedSight                    = Action.Create({ Type = "Potion", ID = 171264, QueueForbidden = true }),
    PotionofSoulPurity                     = Action.Create({ Type = "Potion", ID = 171263, QueueForbidden = true }),
    PotionofSpecterSwiftness               = Action.Create({ Type = "Potion", ID = 171370, QueueForbidden = true }),
    PotionoftheHiddenSpirit                = Action.Create({ Type = "Potion", ID = 171266, QueueForbidden = true }),
    PotionofthePsychopompsSpeed            = Action.Create({ Type = "Potion", ID = 184090, QueueForbidden = true }),
    PotionofUnhinderedPassing              = Action.Create({ Type = "Potion", ID = 183823, QueueForbidden = true }),
    -- Nathria Trinkets
	SanguineVintage                        = Action.Create({ Type = "Trinket", ID = 184031 }),
	ManaboundMirror                        = Action.Create({ Type = "Trinket", ID = 184029 }),
	GluttonousSpike                        = Action.Create({ Type = "Trinket", ID = 184023 }),
	DreadfireVessel                        = Action.Create({ Type = "Trinket", ID = 184030 }),
	MemoryofPastSins                       = Action.Create({ Type = "Trinket", ID = 184025 }),
	ConsumptiveInfusion                    = Action.Create({ Type = "Trinket", ID = 184022 }),
	StoneLegionHeraldry                    = Action.Create({ Type = "Trinket", ID = 184027 }),
	BargastsLeash                          = Action.Create({ Type = "Trinket", ID = 184017 }),
	-- OP Dungeons Trinkets
	BloodSpatteredScale                    = Action.Create({ Type = "Trinket", ID = 179331 }),
	OverwhelmingPowerCrystal               = Action.Create({ Type = "Trinket", ID = 179342 }),
	SunbloodAmethyst                       = Action.Create({ Type = "Trinket", ID = 178826 }),
	PulsatingStoneheart                    = Action.Create({ Type = "Trinket", ID = 178825 }),
	BladedancersArmorKit                   = Action.Create({ Type = "Trinket", ID = 178862 }), 
    -- Misc
    Channeling                             = Create({ Type = "Spell", ID = 209274, Hidden = true     }),	-- Show an icon during channeling
    TargetEnemy                            = Create({ Type = "Spell", ID = 44603, Hidden = true     }),	-- Change Target (Tab button)
    StopCast                               = Create({ Type = "Spell", ID = 61721, Hidden = true     }),		-- spell_magic_polymorphrabbit 
    BlessingofProtection                   = Create({ Type = "Spell", ID = 1022, Hidden = true     }),	-- Used to check on offensive dispell 
    PoolResource                           = Create({ Type = "Spell", ID = 209274, Hidden = true     }),	
	DummyTest                              = Create({ Type = "Spell", ID = 159999, Hidden = true     }), -- Dummy stop dps icon
};

-- To create essences use next code:
--Action:CreateEssencesFor(ACTION_CONST_SHAMAN_ENCHANCEMENT)  -- where PLAYERSPEC is Constance (example: ACTION_CONST_MONK_BM)
local A = setmetatable(Action[ACTION_CONST_SHAMAN_ENCHANCEMENT], { __index = Action })


------------------------------------------
---------------- VARIABLES ---------------
------------------------------------------
local VarFurycheckCl = false
local VarCooldownSync = false
local VarFurycheckEs = false
local VarFurycheckSs = false
local VarFurycheckLb = false
local VarOcpoolSs = false
local VarOcpoolCl = false
local VarOcpoolLl = false
local VarFurycheckLl = false
local VarFurycheckFb = false
local VarClpoolLl = false
local VarClpoolSs = false
local VarFreezerburnEnabled = 0;
local VarOcpool = false
local VarOcpoolFb = false
local VarRockslideEnabled = false

A.Listener:Add("ROTATION_VARS", "PLAYER_REGEN_ENABLED", function()
  VarFurycheckCl = false
  VarCooldownSync = false
  VarFurycheckEs = false
  VarFurycheckSs = false
  VarFurycheckLb = false
  VarOcpoolSs = false
  VarOcpoolCl = false
  VarOcpoolLl = false
  VarFurycheckLl = false
  VarFurycheckFb = false
  VarClpoolLl = false
  VarClpoolSs = false
  VarFreezerburnEnabled = 0
  VarOcpool = false
  VarOcpoolFb = false
  VarRockslideEnabled = false
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

local IsIndoors, UnitIsUnit, UnitName = IsIndoors, UnitIsUnit, UnitName
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
            if not notKickAble and A.WindShearGreen:IsReady(unit, nil, nil, true) and A.WindShearGreen:AbsentImun(unit, Temp.TotalAndMag, true) then
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

--Maintenance
local function Maintenance(unit)
	local FlametongueRefresh = Action.GetToggle(2, "FlametongueRefresh")
	local FrostbrandRefresh = Action.GetToggle(2, "FrostbrandRefresh")
    -- flametongue,if=!buff.flametongue.up
    if A.Flametongue:IsReady(unit) and (Unit(player):HasBuffs(A.FlametongueBuff.ID, true) < FlametongueRefresh) then
        return A.Flametongue
    end
			
    -- frostbrand,if=talent.hailstorm.enabled&!buff.frostbrand.up&variable.furyCheck_FB
    if A.Frostbrand:IsReady(unit) and (A.Hailstorm:IsSpellLearned() and Unit(player):HasBuffs(A.FrostbrandBuff.ID, true) < FrostbrandRefresh and VarFurycheckFb) then
        return A.Frostbrand
    end		
end
Maintenance = A.MakeFunctionCachedDynamic(Maintenance)

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
	local CanCast = true
	local profileStop = false
    local SpiritWolvesTime = SpiritWolvesTime()
    local HeartOfAzeroth = Action.GetToggle(1, "HeartOfAzeroth")
    local Potion = Action.GetToggle(1, "Potion")	
	local Racial = Action.GetToggle(1, "Racial")
	local DBM = Action.GetToggle(1, "BossMods")

	
	-- FocusedAzeriteBeam protection channel
	local secondsLeft, percentLeft, spellID, spellName, notInterruptable, isChannel = Unit(player):IsCastingRemains()
		-- @return:
		-- [1] Currect Casting Left Time (seconds) (@number)
		-- [2] Current Casting Left Time (percent) (@number)
		-- [3] spellID (@number)
		-- [4] spellName (@string)
		-- [5] notInterruptable (@boolean, false is able to be interrupted)
		-- [6] isChannel (@boolean)
	if percentLeft > 0.01 and spellName == A.FocusedAzeriteBeam:Info() then 
	    CanCast = false
	else
	    CanCast = true
	end	
	
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
	-- Mounted
	if Player:IsMounted() then
	    profileStop = true
	end
	
    ------------------------------------------------------
    ---------------- ENEMY UNIT ROTATION -----------------
    ------------------------------------------------------
    local function EnemyRotation(unit)
	
		local FlametongueRefresh = Action.GetToggle(2, "FlametongueRefresh")
		local FrostbrandRefresh = Action.GetToggle(2, "FrostbrandRefresh")
		local GhostWolfTime = Action.GetToggle(2, "GhostWolfTime")
		local UseGhostWolf = Action.GetToggle(2, "UseGhostWolf")
		local CounterStrikeTotemHPlosepersec =  Action.GetToggle(2, "CounterStrikeTotemHPlosepersec")
		local CounterStrikeTotemTTD =  Action.GetToggle(2, "CounterStrikeTotemTTD")
		local FeralLungeHP = Action.GetToggle(2, "FeralLungeHP")
		local FeralLungeRange = Action.GetToggle(2, "FeralLungeRange")
		local SkyfuryTotemTTD = Action.GetToggle(2, "SkyfuryTotemTTD")
		local SkyfuryTotemHP = Action.GetToggle(2, "SkyfuryTotemHP")
		local TrinketsAoE = Action.GetToggle(2, "TrinketsAoE")
		local TrinketsMinTTD = Action.GetToggle(2, "TrinketsMinTTD")
		local TrinketsUnitsRange = Action.GetToggle(2, "TrinketsUnitsRange")
		local TrinketsMinUnits = Action.GetToggle(2, "TrinketsMinUnits")	
		local TotemMasteryRefresh = Action.GetToggle(2, "TotemMasteryRefresh")	
		local UseTotemMastery = Action.GetToggle(2, "UseTotemMastery")	
		local FocusedAzeriteBeamTTD = Action.GetToggle(2, "FocusedAzeriteBeamTTD")
		local FocusedAzeriteBeamUnits = Action.GetToggle(2, "FocusedAzeriteBeamUnits")	
		local CrashLightningUnits = Action.GetToggle(2, "CrashLightningUnits")	
		local CrashLightningAreaTTD = Action.GetToggle(2, "CrashLightningAreaTTD")
		local CrashLightningRange = Action.GetToggle(2, "CrashLightningRange")	
		local EarthElementalHP = Action.GetToggle(2, "EarthElementalHP")
		local EarthElementalRange = Action.GetToggle(2, "EarthElementalRange")
		local EarthElementalUnits = Action.GetToggle(2, "EarthElementalUnits")
		local UnbridledFuryAuto = Action.GetToggle(2, "UnbridledFuryAuto")
		local UnbridledFuryTTD = Action.GetToggle(2, "UnbridledFuryTTD")
		local UnbridledFuryWithBloodlust = Action.GetToggle(2, "UnbridledFuryWithBloodlust")
		local UnbridledFuryWithExecute = Action.GetToggle(2, "UnbridledFuryWithExecute")
		local UnbridledFuryHP = Action.GetToggle(2, "UnbridledFuryHP")
		local MinInterrupt = Action.GetToggle(2, "MinInterrupt")
		local MaxInterrupt = Action.GetToggle(2, "MaxInterrupt")
		local UseSyncCooldowns = Action.GetToggle(2, "UseSyncCooldowns")
		local TrinketOnlyBurst = Action.GetToggle(2, "TrinketOnlyBurst")
        -- variable,name=cooldown_sync,value=(talent.ascendance.enabled&(buff.ascendance.up|cooldown.ascendance.remains>50))|(!talent.ascendance.enabled&(SpiritWolvesTime>5|cooldown.SpiritWolvesTime>50))
        VarCooldownSync = (UseSyncCooldowns and 
		                    (
		                        (
							        A.Ascendance:IsSpellLearned() and 
									(
									    Unit(player):HasBuffs(A.AscendanceBuff.ID, true) > 0
									    or 
									    A.Ascendance:GetCooldown() > 50
									)
							    )
								or 
								(
								    not A.Ascendance:IsSpellLearned() and 
									(
									    SpiritWolvesTime > 5 
										or 
										A.FeralSpirit:GetCooldown() > 50
									)
								)
						    )
							or not UseSyncCooldowns)
							

        -- variable,name=furyCheck_SS,value=maelstrom>=(talent.fury_of_air.enabled*(6+action.stormstrike.cost))
        VarFurycheckSs = (Player:Maelstrom() >= (num(A.FuryofAir:IsSpellLearned()) * (6 + A.Stormstrike:GetSpellPowerCostCache())))
			
        -- variable,name=furyCheck_LL,value=maelstrom>=(talent.fury_of_air.enabled*(6+action.lava_lash.cost))
        VarFurycheckLl = (Player:Maelstrom() >= (num(A.FuryofAir:IsSpellLearned()) * (6 + A.LavaLash:GetSpellPowerCostCache())))
			
        -- variable,name=furyCheck_CL,value=maelstrom>=(talent.fury_of_air.enabled*(6+action.crash_lightning.cost))
        VarFurycheckCl = (Player:Maelstrom() >= (num(A.FuryofAir:IsSpellLearned()) * (6 + A.CrashLightning:GetSpellPowerCostCache())))
			
        -- variable,name=furyCheck_FB,value=maelstrom>=(talent.fury_of_air.enabled*(6+action.frostbrand.cost))
        VarFurycheckFb = (Player:Maelstrom() >= (num(A.FuryofAir:IsSpellLearned()) * (6 + A.Frostbrand:GetSpellPowerCostCache())))
			
        -- variable,name=furyCheck_ES,value=maelstrom>=(talent.fury_of_air.enabled*(6+action.earthen_spike.cost))
        VarFurycheckEs = (Player:Maelstrom() >= (num(A.FuryofAir:IsSpellLearned()) * (6 + A.EarthenSpike:GetSpellPowerCostCache())))         
			
        -- variable,name=furyCheck_LB,value=maelstrom>=(talent.fury_of_air.enabled*(6+40))
        VarFurycheckLb = (Player:Maelstrom() >= (num(A.FuryofAir:IsSpellLearned()) * (6 + 40))    )    
			
        -- variable,name=OCPool,value=(active_enemies>1|(cooldown.lightning_bolt.remains>=2*gcd))
        VarOcpool = (GetByRange(1, 10) or (A.LightningBolt:GetCooldown() >= 2 * A.GetGCD()))         
			
        -- variable,name=OCPool_SS,value=(variable.OCPool|maelstrom>=(talent.overcharge.enabled*(40+action.stormstrike.cost)))
        VarOcpoolSs = (VarOcpool or Player:Maelstrom() >= (num(A.Overcharge:IsSpellLearned()) * (40 + A.Stormstrike:GetSpellPowerCostCache())))          
			
        -- variable,name=OCPool_LL,value=(variable.OCPool|maelstrom>=(talent.overcharge.enabled*(40+action.lava_lash.cost)))
        VarOcpoolLl = (VarOcpool or Player:Maelstrom() >= (num(A.Overcharge:IsSpellLearned()) * (40 + A.LavaLash:GetSpellPowerCostCache())))     
			
        -- variable,name=OCPool_CL,value=(variable.OCPool|maelstrom>=(talent.overcharge.enabled*(40+action.crash_lightning.cost)))
        VarOcpoolCl = (VarOcpool or Player:Maelstrom() >= (num(A.Overcharge:IsSpellLearned()) * (40 + A.CrashLightning:GetSpellPowerCostCache())))        
			
        -- variable,name=OCPool_FB,value=(variable.OCPool|maelstrom>=(talent.overcharge.enabled*(40+action.frostbrand.cost)))
        VarOcpoolFb = (VarOcpool or Player:Maelstrom() >= (num(A.Overcharge:IsSpellLearned()) * (40 + A.Frostbrand:GetSpellPowerCostCache())))     
			
        -- variable,name=CLPool_LL,value=active_enemies=1|maelstrom>=(action.crash_lightning.cost+action.lava_lash.cost)
        VarClpoolLl = (MultiUnits:GetByRange(10) == 1 or Player:Maelstrom() >= (A.CrashLightning:GetSpellPowerCostCache() + A.LavaLash:GetSpellPowerCostCache()))      
			
        -- variable,name=CLPool_SS,value=active_enemies=1|maelstrom>=(action.crash_lightning.cost+action.stormstrike.cost)
        VarClpoolSs = (MultiUnits:GetByRange(10) == 1 or Player:Maelstrom() >= (A.CrashLightning:GetSpellPowerCostCache() + A.Stormstrike:GetSpellPowerCostCache()))     
			
        -- variable,name=freezerburn_enabled,value=(talent.hot_hand.enabled&talent.hailstorm.enabled&azerite.primal_primer.enabled)
        VarFreezerburnEnabled = num(A.HotHand:IsSpellLearned() and A.Hailstorm:IsSpellLearned() and A.PrimalPrimer:GetAzeriteRank() > 0)  
			
        -- variable,name=rockslide_enabled,value=(!variable.freezerburn_enabled&(talent.boulderfist.enabled&talent.landslide.enabled&azerite.strength_of_earth.enabled))
        VarRockslideEnabled = (not bool(VarFreezerburnEnabled) and A.Boulderfist:IsSpellLearned() and A.Landslide:IsSpellLearned() and A.StrengthofEarth:GetAzeriteRank() > 0)
      
			
        -- Trinkets var             
        local Trinket1IsAllowed, Trinket2IsAllowed = TR.TrinketIsAllowed()
            
    	-- Interrupt
        local Interrupt = Interrupts(unit)
        if Interrupt then 
            return Interrupt:Show(icon)
        end	
		
        -- lightning_shield
        if A.LightningShield:IsReady(unit) and Unit(player):HasBuffs(A.LightningShield.ID, true) == 0 then
            return A.LightningShield:Show(icon)
        end		
			
        -- Ghost Wolf
        if isMovingFor > Action.GetToggle(2, "GhostWolfTime") and Unit(unit):GetRange() > 8 and A.GhostWolf:IsReady(player) and Action.GetToggle(2, "UseGhostWolf") and Unit(player):HasBuffs(A.GhostWolfBuff.ID, true) == 0 then
            -- Notification                    
            Action.SendNotification("Out of range: auto Ghost Wolf", A.GhostWolf.ID)
            return A.GhostWolf:Show(icon)
        end
		
	   	-- CounterStrike Totem on Enemyburst
        if A.IsInPvP and inCombat and A.CounterStrikeTotem:IsReady(player) and A.CounterStrikeTotem:IsSpellLearned() and --Unit(player):IsFocused("DAMAGER") and 
		(
		    -- HP lose per sec >= 5
            Unit(player):GetDMG() * 100 / Unit(player):HealthMax() >= 5 or 
            Unit(player):GetRealTimeDMG() >= Unit(player):HealthMax() * 0.05 or 
            -- TTD 
            Unit(player):TimeToDieX(50) < 5 
		)
		then 
            return A.CounterStrikeTotem:Show(icon)
        end
	
        -- Grounding Totem Casting BreakAble CC
        if A.IsInPvP and inCombat and A.GroundingTotem:IsReady(player) and A.GroundingTotem:IsSpellLearned() and Action.ShouldReflect(unit) then 
            return A.GroundingTotem:Show(icon)
        end
			
        -- Purge
        -- Note: Toggles  ("UseDispel", "UsePurge", "UseExpelEnrage")
        -- Category ("Dispel", "MagicMovement", "PurgeFriendly", "PurgeHigh", "PurgeLow", "Enrage")
        if A.Purge:IsReady(unit) and inCombat and A.LastPlayerCastName ~= A.Purge:Info() and not ShouldStop and Action.AuraIsValid("target", "UsePurge", "PurgeHigh") 
		and Unit(unit):HasBuffs(A.BlessingofProtection.ID, true) == 0
		then
            return A.Purge:Show(icon)
        end 
			
        -- Purge
        -- Note: Toggles  ("UseDispel", "UsePurge", "UseExpelEnrage")
        -- Category ("Dispel", "MagicMovement", "PurgeFriendly", "PurgeHigh", "PurgeLow", "Enrage")
        if A.Purge:IsReady(unit) and inCombat and A.LastPlayerCastName ~= A.Purge:Info() and not ShouldStop and Action.AuraIsValid("target", "UsePurge", "PurgeLow") 
		and Unit(unit):HasBuffs(A.BlessingofProtection.ID, true) == 0
		then
            return A.Purge:Show(icon)
        end 
			
        -- Feral Lunge
        if (Unit(unit):GetRange() >= 8 and inCombat and Unit(unit):GetRange() <= 25 or Unit(unit):IsMovingOut()) and Unit(unit):HealthPercent() <= Action.GetToggle(2, "FeralLungeHP") and A.FeralLunge:IsReady(unit) and A.FeralLunge:IsSpellLearned() then
            -- Notification                    
            Action.SendNotification("Out of range: auto Feral Lunge", A.FeralLunge.ID)
            return A.FeralLunge:Show(icon)
        end
			
		-- Bloodlust Shamanism PvP
        if A.BloodLust:IsReady(player) and inCombat and A.BurstIsON(unit) and A.Shamanism:IsSpellLearned() then 
            return A.BloodLust:Show(icon)
        end 
			
		-- Skyfury Totem
        if A.IsInPvP and A.SkyfuryTotem:IsReady(player) and inCombat and (Unit(unit):HealthPercent() <= SkyfuryTotemHP or Unit(unit):TimeToDie() <= SkyfuryTotemTTD) and A.BurstIsON(unit) and A.SkyfuryTotem:IsSpellLearned() then 
            return A.SkyfuryTotem:Show(icon)
        end

		-- Tremor Totem on Friendly LOC
        if A.TremorTotem:IsReady(player) and inCombat and FriendlyTeam():GetDeBuffs("Fear") > 0 then 
            return A.TremorTotem:Show(icon)
        end
			
		-- CounterStrikeTotem on enemy burst 
        if A.IsInPvP and Unit(player):IsFocused() and inCombat and A.CounterStrikeTotem:IsReady(player) and A.CounterStrikeTotem:IsSpellLearned() and
		   (
		        -- HP lose per sec >= 30
                Unit(player):GetDMG() * 100 / Unit(player):HealthMax() >= CounterStrikeTotemHPlosepersec 
				or  
                Unit(player):GetRealTimeDMG() >= Unit(player):HealthMax() * (CounterStrikeTotemHPlosepersec / 100)
				or
				Unit(player):TimeToDie() <= CounterStrikeTotemTTD
			)
		then 
            return A.CounterStrikeTotem:Show(icon)
        end
		
	   	-- Non SIMC Custom Trinket1
	    if A.Trinket1:IsReady(unit) and ((TrinketOnlyBurst and A.BurstIsON(unit)) or (not TrinketOnlyBurst and not A.BurstIsON(unit))) and Trinket1IsAllowed and inCombat and CanCast and Unit(unit):GetRange() < 6 and    
		(
    		TrinketsAoE and GetByRange(TrinketsMinUnits, TrinketsUnitsRange) and Player:AreaTTD(TrinketsUnitsRange) > TrinketsMinTTD
			or
			not TrinketsAoE and Unit(unit):TimeToDie() >= TrinketsMinTTD 					
		)
		then 
      	    return A.Trinket1:Show(icon)
   	    end 		
	        	
		-- Non SIMC Custom Trinket2
	    if A.Trinket2:IsReady(unit) and ((TrinketOnlyBurst and A.BurstIsON(unit)) or (not TrinketOnlyBurst and not A.BurstIsON(unit))) and Trinket2IsAllowed and inCombat and CanCast and Unit(unit):GetRange() < 6 and	    
		(
    		TrinketsAoE and GetByRange(TrinketsMinUnits, TrinketsUnitsRange) and Player:AreaTTD(TrinketsUnitsRange) > TrinketsMinTTD
			or
			not TrinketsAoE and Unit(unit):TimeToDie() >= TrinketsMinTTD 					
		)
		then
      	   	return A.Trinket2:Show(icon) 	
	    end
				
        -- 0 TotemMastery
        if A.TotemMastery:IsReady(unit) and A.LastPlayerCastName ~= A.TotemMastery:Info() and ResonanceTotemTime() < TotemMasteryRefresh and A.TotemMastery:IsSpellLearned() then
            return A.TotemMastery:Show(icon)
        end			
        
		--Precombat
        if combatTime == 0 and not Unit(unit):IsDead() and Unit(unit):IsExists() and unit ~= "mouseover" then
            -- flask
            -- food
            -- augmentation
            -- snapshot_stats			
            -- totem_mastery
            if A.TotemMastery:IsReady(player) and A.LastPlayerCastName ~= A.TotemMastery:Info() and ResonanceTotemTime() < TotemMasteryRefresh 
			and ((Pull > 0.1 and Pull <= 9) or not DBM)
			then
                return A.TotemMastery:Show(icon)
            end
			
            -- lightning_shield
            if A.LightningShield:IsReady(unit) and Unit(player):HasBuffs(A.LightningShield.ID, true) == 0 
			and ((Pull > 0.1 and Pull <= 8) or not DBM)
			then
                return A.LightningShield:Show(icon)
            end
			
            -- use_item,name=azsharas_font_of_power
            if A.AzsharasFontofPower:IsReady(player) 
			and ((Pull > 0.1 and Pull <= 6) or not DBM)
			then
                return A.AzsharasFontofPower:Show(icon)
            end
			
            -- potion
            if A.PotionofUnbridledFury:IsReady(unit) and Potion 
			and ((Pull > 0.1 and Pull <= 2) or not DBM)
			then
                return A.PotionofUnbridledFury:Show(icon)
            end			
			
            -- Flametongue
            if A.Flametongue:IsReady(unit) 
			and ((Pull > 0.1 and Pull <= 1) or not DBM)
			then
                return A.Flametongue:Show(icon)
            end
			
            -- rockbiter
            if A.Rockbiter:IsReady(unit) 
			and ((Pull > 0.1 and Pull <= 1) or not DBM)
			then
                return A.Rockbiter:Show(icon)
            end
			
        end

        -- rockbiter,if=maelstrom<15&time<gcd
        if A.Rockbiter:IsReady(unit) and inCombat and not Unit(unit):IsDead() and (Player:Maelstrom() < 15 and Unit(player):CombatTime() < A.GetGCD()) then
            return A.Rockbiter:Show(icon)
        end
		
        -- crash_lightning,force aoe
        if A.CrashLightning:IsReady(player) and inCombat and not Unit(unit):IsDead() and GetByRange(CrashLightningUnits, CrashLightningRange) and Player:AreaTTD(CrashLightningRange) >= CrashLightningAreaTTD then
            return A.CrashLightning:Show(icon)
        end	
		
        --Asc
        if Unit(player):HasBuffs(A.AscendanceBuff.ID, true) > 0 and inCombat and not Unit(unit):IsDead() then
            -- crash_lightning,if=!buff.crash_lightning.up&active_enemies>1&variable.furyCheck_CL
            if A.CrashLightning:IsReady(player) and (Unit(player):HasBuffs(A.CrashLightningBuff.ID, true) == 0 and GetByRange(1, CrashLightningRange) and VarFurycheckCl) then
                return A.CrashLightning:Show(icon)
            end
			
            -- rockbiter,if=talent.landslide.enabled&!buff.landslide.up&charges_fractional>1.7
            if A.Rockbiter:IsReady(unit) and (A.Landslide:IsSpellLearned() and Unit(player):HasBuffs(A.LandslideBuff.ID, true) == 0 and A.Rockbiter:GetSpellChargesFrac() > 1.7) then
                return A.Rockbiter:Show(icon)
            end
			
            -- windstrike
            if A.Windstrike:IsReady(unit) then
                return A.Windstrike:Show(icon)
            end
			
        end

        -- stormstrike,cycle_targets=1,if=active_enemies>1&azerite.lightning_conduit.enabled&!debuff.lightning_conduit.up&variable.furyCheck_SS
        if A.Stormstrike:IsReadyByPassCastGCD(unit) and inCombat and not Unit(unit):IsDead() then
            return A.Stormstrike:Show(icon) 
        end

        -- lava_lash,if=debuff.primal_primer.stack=10&variable.furyCheck_LL
        if A.LavaLash:IsReadyByPassCastGCD(unit) and inCombat and not Unit(unit):IsDead() and 
		(
		    (not A.FuryofAir:IsSpellLearned() and Player:Maelstrom() >= 40) 
			or 
			(A.FuryofAir:IsSpellLearned() and Player:Maelstrom() >= 50)
		)
		then
            return A.LavaLash:Show(icon)
        end

        -- crash_lightning,if=active_enemies>=(8-(talent.forceful_winds.enabled*3))&variable.freezerburn_enabled&variable.furyCheck_CL
        if A.CrashLightning:IsReady(player) and inCombat and not Unit(unit):IsDead() and GetByRange(CrashLightningUnits, CrashLightningRange) and Player:AreaTTD(CrashLightningRange) >= CrashLightningAreaTTD and bool(VarFreezerburnEnabled) and VarFurycheckCl then
            return A.CrashLightning:Show(icon)
        end
			
        -- the_unbound_force,if=buff.reckless_force.up|time<5
        if A.TheUnboundForce:AutoHeartOfAzerothP(unit, true) and inCombat and not Unit(unit):IsDead() and HeartOfAzeroth and (Unit(player):HasBuffs(A.RecklessForceBuff.ID, true) > 0 or Unit(player):CombatTime() < 5) then
            return A.TheUnboundForce:Show(icon)
        end
			
        -- lava_lash,if=azerite.primal_primer.rank>=2&debuff.primal_primer.stack=10&active_enemies=1&variable.freezerburn_enabled&variable.furyCheck_LL
        if A.LavaLash:IsReadyByPassCastGCD(unit) and inCombat and not Unit(unit):IsDead() and 
		(
		   A.PrimalPrimer:GetAzeriteRank() >= 2 
			and 
			Unit(unit):HasDeBuffsStacks(A.PrimalPrimerDebuff.ID, true) == 10 
			and 
			MultiUnits:GetByRange(5) == 1
			and 
			bool(VarFreezerburnEnabled) and VarFurycheckLl
		) 
		then
            return A.LavaLash:Show(icon)
        end
			
        -- crash_lightning,if=!buff.crash_lightning.up&active_enemies>1&variable.furyCheck_CL
        if A.CrashLightning:IsReady(player) and inCombat and not Unit(unit):IsDead() and Unit(player):HasBuffs(A.CrashLightningBuff.ID, true) == 0 and GetByRange(2, CrashLightningRange) and VarFurycheckCl then
            return A.CrashLightning:Show(icon)
        end
			
        -- fury_of_air,if=!buff.fury_of_air.up&maelstrom>=20&spell_targets.fury_of_air_damage>=(1+variable.freezerburn_enabled)
        if A.FuryofAir:IsReady(player) and inCombat and not Unit(unit):IsDead() and Unit(player):HasBuffs(A.FuryofAirBuff.ID, true) == 0 and Player:Maelstrom() >= 20 and GetByRange((1 + VarFreezerburnEnabled), 8) 
		
		then
            return A.FuryofAir:Show(icon)
        end
		
        -- fury_of_air,if=buff.fury_of_air.up&&spell_targets.fury_of_air_damage<(1+variable.freezerburn_enabled)
        if A.FuryofAir:IsReady(player) and inCombat and not Unit(unit):IsDead() and Unit(player):HasBuffs(A.FuryofAirBuff.ID, true) > 0 and GetByRange((1 + VarFreezerburnEnabled), 8, false, true) then
            return A.FuryofAir:Show(icon)
        end
			
        -- totem_mastery,if=buff.resonance_totem.remains<=2*gcd
        if A.TotemMastery:IsReady(unit) and Unit(player):HasBuffs(A.ResonanceTotemBuff.ID, true) <= 2 * A.GetGCD() then
            return A.TotemMastery:Show(icon)
        end
			
        -- sundering,if=active_enemies>=3&(!essence.blood_of_the_enemy.major|(essence.blood_of_the_enemy.major&(buff.seething_rage.up|cooldown.blood_of_the_enemy.remains>40)))
        if A.Sundering:IsReady(unit) and inCombat and not Unit(unit):IsDead() and Unit(unit):GetRange() < 10 and 
		(
		    GetByRange(3, 10) and 
			(
			    not Azerite:EssenceHasMajor(A.BloodoftheEnemy.ID) 
				or 
				(
				    Azerite:EssenceHasMajor(A.BloodoftheEnemy.ID) and 
					(
					    Unit(player):HasBuffs(A.SeethingRageBuff.ID, true) > 0 
						or 
						A.BloodoftheEnemy:GetCooldown() > 40
					)
				)
			)
		)
		then
            return A.Sundering:Show(icon)
        end
			
        -- focused_azerite_beam,if=spell_targets.blade_dance1>=2|raid_event.adds.in>60
        if A.FocusedAzeriteBeam:AutoHeartOfAzeroth(unit, true) and inCombat and not Unit(unit):IsDead() and CanCast and BurstIsON(unit) and UseHeartOfAzeroth 
	    and (GetByRange(FocusedAzeriteBeamUnits, 20) or Unit(unit):IsBoss()) and Unit(unit):TimeToDie() >= FocusedAzeriteBeamTTD
		then
 	        -- Notification					
            Action.SendNotification("Stop moving!! Focused Azerite Beam", A.FocusedAzeriteBeam.ID)                 
			return A.FocusedAzeriteBeam:Show(icon)
        end
			
        -- purifying_blast,if=active_enemies>1
        if A.PurifyingBlast:AutoHeartOfAzerothP(unit, true) and inCombat and not Unit(unit):IsDead() and HeartOfAzeroth and GetByRange(1, 20) then
            return A.PurifyingBlast:Show(icon)
        end
		
		-- ripple_in_space,if=active_enemies>1
        if A.RippleinSpace:AutoHeartOfAzerothP(unit, true) and inCombat and not Unit(unit):IsDead() and HeartOfAzeroth and GetByRange(1, 20) then
            return A.RippleinSpace:Show(icon)
        end
			
        -- rockbiter,if=talent.landslide.enabled&!buff.landslide.up&charges_fractional>1.7
        if A.Rockbiter:IsReady(unit) and inCombat and not Unit(unit):IsDead() and (A.Landslide:IsSpellLearned() and Unit(player):HasBuffs(A.LandslideBuff.ID, true) == 0 and A.Rockbiter:GetSpellChargesFrac() > 1.7) then
            return A.Rockbiter:Show(icon)
        end
			
        -- frostbrand,if=(azerite.natural_harmony.enabled&buff.natural_harmony_frost.remains<=2*gcd)&talent.hailstorm.enabled&variable.furyCheck_FB
        if A.Frostbrand:IsReady(unit) and inCombat and not Unit(unit):IsDead() and ((A.NaturalHarmony:GetAzeriteRank() > 0 and Unit(player):HasBuffs(A.NaturalHarmonyFrostBuff.ID, true) <= 2 * A.GetGCD()) and A.Hailstorm:IsSpellLearned() and VarFurycheckFb) then
            return A.Frostbrand:Show(icon)
        end
			
        -- flametongue,if=(azerite.natural_harmony.enabled&buff.natural_harmony_fire.remains<=2*gcd)
        if A.Flametongue:IsReady(unit) and inCombat and not Unit(unit):IsDead() and ((A.NaturalHarmony:GetAzeriteRank() > 0 and Unit(player):HasBuffs(A.NaturalHarmonyFireBuff.ID, true) <= 2 * A.GetGCD())) then
            return A.Flametongue:Show(icon)
        end
			
        -- rockbiter,if=(azerite.natural_harmony.enabled&buff.natural_harmony_nature.remains<=2*gcd)&maelstrom<70
        if A.Rockbiter:IsReady(unit) and inCombat and not Unit(unit):IsDead() and ((A.NaturalHarmony:GetAzeriteRank() > 0 and Unit(player):HasBuffs(A.NaturalHarmonyNatureBuff.ID, true) <= 2 * A.GetGCD()) and Player:Maelstrom() < 70) then
            return A.Rockbiter:Show(icon)
        end
		
        -- call_action_list,name=maintenance,if=active_enemies<3
        if Maintenance(unit) and inCombat and not Unit(unit):IsDead() and (MultiUnits:GetByRange(10) < 3) then
            return Maintenance(unit):Show(icon)
        end
		
       --Cds
        if A.BurstIsON(unit) and inCombat and not Unit(unit):IsDead() and unit ~= "mouseover" then
            -- bloodlust,if=azerite.ancestral_resonance.enabled
            -- worldvein_resonance
            if A.WorldveinResonance:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth then
                return A.WorldveinResonance:Show(icon)
            end
			
            -- blood_of_the_enemy,if=raid_event.adds.in>90|active_enemies>1
            if A.BloodoftheEnemy:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth then
                return A.BloodoftheEnemy:Show(icon)
            end
			
            -- berserking,if=variable.cooldown_sync
            if A.Berserking:AutoRacial(unit) and Racial and not Unit(player):HasHeroism() and VarCooldownSync then
                return A.Berserking:Show(icon)
            end
			
            -- use_item,name=azsharas_font_of_power
            if A.AzsharasFontofPower:IsReady(player) then
                return A.AzsharasFontofPower:Show(icon)
            end
			
            -- blood_fury,if=variable.cooldown_sync
            if A.BloodFury:AutoRacial(unit) and Racial and A.BurstIsON(unit) and VarCooldownSync then
                return A.BloodFury:Show(icon)
            end
			
            -- fireblood,if=variable.cooldown_sync
            if A.Fireblood:AutoRacial(unit) and Racial and A.BurstIsON(unit) and VarCooldownSync then
                return A.Fireblood:Show(icon)
            end
			
            -- ancestral_call,if=variable.cooldown_sync
            if A.AncestralCall:AutoRacial(unit) and Racial and A.BurstIsON(unit) and VarCooldownSync then
                return A.AncestralCall:Show(icon)
            end

            -- potion,if=buff.metamorphosis.remains>25|target.time_to_die<60
            if A.PotionofUnbridledFury:IsReady(unit) and CanCast and Action.GetToggle(1, "Potion") and UnbridledFuryAuto
			and 
			(
			    ((Unit(player):HasBuffs(A.AscendanceBuff.ID, true) > 0 or not A.Ascendance:IsSpellLearned()) and UnbridledFuryWithSecondAscendance)
				or
				(UnbridledFuryWithBloodlust and Unit("player"):HasHeroism())
				or
				(UnbridledFuryWithExecute and Unit(unit):HealthPercent() <= 30)
			)
			and Unit(unit):TimeToDie() > UnbridledFuryTTD
			then
 	            -- Notification					
                Action.SendNotification("Burst: Potion of Unbridled Fury", A.PotionofUnbridledFury.ID)	
                return A.PotionofUnbridledFury:Show(icon)
            end
			
            -- guardian_of_azeroth
            if A.GuardianofAzeroth:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth then
                return A.GuardianofAzeroth:Show(icon)
            end
			
            -- feral_spirit
            if A.FeralSpirit:IsReady(unit) then
                return A.FeralSpirit:Show(icon)
            end
						
            -- ascendance,if=cooldown.strike.remains>0
            if A.Ascendance:IsReady(unit) and A.Ascendance:IsSpellLearned() then
                return A.Ascendance:Show(icon)
            end
			
            -- use_item,name=ashvanes_razor_coral,if=debuff.razor_coral_debuff.down|(target.time_to_die<20&debuff.razor_coral_debuff.stack>2)
            if A.AshvanesRazorCoral:IsReady(unit) and 
			(
			    Unit(unit):HasDeBuffs(A.RazorCoralDebuff.ID, true) == 0
				or 
				(Unit(unit):TimeToDie() < 20 and Unit(unit):HasDeBuffsStacks(A.RazorCoralDebuff.ID, true) > 2)
			)
			then
                return A.AshvanesRazorCoral:Show(icon)
            end
			
            -- use_item,name=ashvanes_razor_coral,if=debuff.razor_coral_debuff.stack>2&debuff.conductive_ink_debuff.down&(buff.ascendance.remains>10|buff.molten_weapon.remains>10|buff.crackling_surge.remains>10|buff.icy_edge.remains>10|debuff.earthen_spike.remains>6)
            if A.AshvanesRazorCoral:IsReady(unit) and 
			(
			    Unit(unit):HasDeBuffsStacks(A.RazorCoralDebuff.ID, true) > 2 and Unit(unit):HasDeBuffs(A.ConductiveInkDebuff.ID, true) == 0 and 
				(
				    Unit(player):HasBuffs(A.AscendanceBuff.ID, true) > 10 
					or
					Unit(player):HasBuffs(A.MoltenWeaponBuff.ID, true) > 10 
					or 
					Unit(player):HasBuffs(A.CracklingSurgeBuff.ID, true) > 10 
					or 
					Unit(player):HasBuffs(A.IcyEdgeBuff.ID, true) > 10 
					or 
					Unit(unit):HasDeBuffs(A.EarthenSpikeDebuff.ID, true) > 6
				)
			)
			then
                return A.AshvanesRazorCoral:Show(icon)
            end
			
            -- use_item,name=ashvanes_razor_coral,if=(debuff.conductive_ink_debuff.up|buff.ascendance.remains>10|buff.molten_weapon.remains>10|buff.crackling_surge.remains>10|buff.icy_edge.remains>10|debuff.earthen_spike.remains>6)&target.health.pct<31
            if A.AshvanesRazorCoral:IsReady(unit) and 
			(
			    (
				    Unit(unit):HasDeBuffs(A.ConductiveInkDebuff.ID, true) 
					or
					Unit(player):HasBuffs(A.AscendanceBuff.ID, true) > 10 
					or
					Unit(player):HasBuffs(A.MoltenWeaponBuff.ID, true) > 10 
					or
					Unit(player):HasBuffs(A.CracklingSurgeBuff.ID, true) > 10 
					or 
					Unit(player):HasBuffs(A.IcyEdgeBuff.ID, true) > 10 
					or 
					Unit(unit):HasDeBuffs(A.EarthenSpikeDebuff.ID, true) > 6
				)
				and Unit(unit):HealthPercent() < 31
			)
			then
                return A.AshvanesRazorCoral:Show(icon)
            end
			
            -- use_items
            -- earth_elemental
			if UseEarthElemental and Unit(player):HealthPercent() <= EarthElementalHP and GetByRange(EarthElementalUnits, EarthElementalRange) then
			    EarthElemental:Show(icon)
			end
        end
		
        --FreezerburnCore
        if bool(VarFreezerburnEnabled) and inCombat and not Unit(unit):IsDead() then
            -- lava_lash,target_if=max:debuff.primal_primer.stack,if=azerite.primal_primer.rank>=2&debuff.primal_primer.stack=10&variable.furyCheck_LL&variable.CLPool_LL
            if A.LavaLash:IsReadyByPassCastGCD(unit) then
                if Unit(unit):HasDeBuffsStacks(A.PrimalPrimerDebuff.ID, true) > 0 and A.PrimalPrimer:GetAzeriteRank() >= 2 and Unit(unit):HasDeBuffsStacks(A.PrimalPrimerDebuff.ID, true) == 10 and VarFurycheckLl and VarClpoolLl then 
                    return A.LavaLash:Show(icon) 
                end
            end
			
            -- earthen_spike,if=variable.furyCheck_ES
            if A.EarthenSpike:IsReady(unit) and (VarFurycheckEs) then
                return A.EarthenSpike:Show(icon)
            end
			
            -- stormstrike,cycle_targets=1,if=active_enemies>1&azerite.lightning_conduit.enabled&!debuff.lightning_conduit.up&variable.furyCheck_SS
            if A.Stormstrike:IsReadyByPassCastGCD(unit) then
                if GetByRange(2, 10) and A.LightningConduit:GetAzeriteRank() > 0 and Unit(unit):HasDeBuffs(A.LightningConduitDebuff.ID, true) == 0 and VarFurycheckSs then
                    return A.Stormstrike:Show(icon) 
                end
            end
			
            -- stormstrike,if=buff.stormbringer.up|(active_enemies>1&buff.gathering_storms.up&variable.furyCheck_SS)
            if A.Stormstrike:IsReadyByPassCastGCD(unit) and 
			(
			    Unit(player):HasBuffs(A.StormbringerBuff.ID, true) > 0 
				or 
				(GetByRange(1, 5) and Unit(player):HasBuffs(A.GatheringStormsBuff.ID, true) > 0 and VarFurycheckSs)
			)
			then
                return A.Stormstrike:Show(icon)
            end
			
            -- crash_lightning,if=active_enemies>=3&variable.furyCheck_CL
            if A.CrashLightning:IsReady(player) and GetByRange(3, CrashLightningRange) and VarFurycheckCl then
                return A.CrashLightning:Show(icon)
            end
			
            -- lightning_bolt,if=talent.overcharge.enabled&active_enemies=1&variable.furyCheck_LB&maelstrom>=40
            if A.LightningBolt:IsReady(unit) and (A.Overcharge:IsSpellLearned() and MultiUnits:GetByRange(40) == 1 and VarFurycheckLb and Player:Maelstrom() >= 40) then
                return A.LightningBolt:Show(icon)
            end
			
            -- lava_lash,if=azerite.primal_primer.rank>=2&debuff.primal_primer.stack>7&variable.furyCheck_LL&variable.CLPool_LL
            if A.LavaLash:IsReadyByPassCastGCD(unit) and (A.PrimalPrimer:GetAzeriteRank() >= 2 and Unit(unit):HasDeBuffsStacks(A.PrimalPrimerDebuff.ID, true) > 7 and VarFurycheckLl and VarClpoolLl) then
                return A.LavaLash:Show(icon)
            end
			
            -- stormstrike,if=variable.OCPool_SS&variable.furyCheck_SS&variable.CLPool_SS
            if A.Stormstrike:IsReadyByPassCastGCD(unit) and (VarOcpoolSs and VarFurycheckSs and VarClpoolSs) then
                return A.Stormstrike:Show(icon)
            end
			
            -- lava_lash,if=debuff.primal_primer.stack=10&variable.furyCheck_LL
            if A.LavaLash:IsReadyByPassCastGCD(unit) and (Unit(unit):HasDeBuffsStacks(A.PrimalPrimerDebuff.ID, true) == 10 and VarFurycheckLl) then
                return A.LavaLash:Show(icon)
            end
		
		--DefaultCore	
        else     
		
            -- earthen_spike,if=variable.furyCheck_ES
            if A.EarthenSpike:IsReady(unit) and (VarFurycheckEs) then
                return A.EarthenSpike:Show(icon)
            end
			
            -- stormstrike,cycle_targets=1,if=active_enemies>1&azerite.lightning_conduit.enabled&!debuff.lightning_conduit.up&variable.furyCheck_SS
            if A.Stormstrike:IsReadyByPassCastGCD(unit) then
                if GetByRange(2, 10) and A.LightningConduit:GetAzeriteRank() > 0 and Unit(unit):HasDeBuffs(A.LightningConduitDebuff.ID, true) == 0 and VarFurycheckSs then
                    return A.Stormstrike:Show(icon) 
                end
            end
			
            -- stormstrike,if=buff.stormbringer.up|(active_enemies>1&buff.gathering_storms.up&variable.furyCheck_SS)
            if A.Stormstrike:IsReadyByPassCastGCD(unit) and (Unit(player):HasBuffs(A.StormbringerBuff.ID, true) > 0 or (GetByRange(1, 5) and Unit(player):HasBuffs(A.GatheringStormsBuff.ID, true) > 0 and VarFurycheckSs)) then
                return A.Stormstrike:Show(icon)
            end
			
            -- crash_lightning,if=active_enemies>=3&variable.furyCheck_CL
            if A.CrashLightning:IsReady(player) and (GetByRange(3, CrashLightningRange) and VarFurycheckCl) then
                return A.CrashLightning:Show(icon)
            end
			
            -- lightning_bolt,if=talent.overcharge.enabled&active_enemies=1&variable.furyCheck_LB&maelstrom>=40
            if A.LightningBolt:IsReady(unit) and (A.Overcharge:IsSpellLearned() and MultiUnits:GetByRange(40) == 1 and VarFurycheckLb and Player:Maelstrom() >= 40) then
                return A.LightningBolt:Show(icon)
            end
			
            -- stormstrike,if=variable.OCPool_SS&variable.furyCheck_SS
            if A.Stormstrike:IsReadyByPassCastGCD(unit) and (VarOcpoolSs and VarFurycheckSs) then
                return A.Stormstrike:Show(icon)
            end
			
        end
		
        -- call_action_list,name=maintenance,if=active_enemies>=3
        if Maintenance(unit) and inCombat and not Unit(unit):IsDead() and (GetByRange(3, 10)) then
            return Maintenance(unit):Show(icon)
        end
		
        -- call_action_list,name=filler
        -- sundering,if=raid_event.adds.in>40
        if A.Sundering:IsReady(unit) and inCombat and not Unit(unit):IsDead() and Unit(unit):GetRange() < 10 then
            return A.Sundering:Show(icon)
        end
			
        -- focused_azerite_beam,if=raid_event.adds.in>90&!buff.ascendance.up&!buff.molten_weapon.up&!buff.icy_edge.up&!buff.crackling_surge.up&!debuff.earthen_spike.up
        if A.FocusedAzeriteBeam:AutoHeartOfAzeroth(unit, true) and inCombat and not Unit(unit):IsDead() and CanCast and BurstIsON(unit) and UseHeartOfAzeroth 
	    and (GetByRange(FocusedAzeriteBeamUnits, 20) or Unit(unit):IsBoss()) and Unit(unit):TimeToDie() >= FocusedAzeriteBeamTTD
		then
 	        -- Notification					
            Action.SendNotification("Stop moving!! Focused Azerite Beam", A.FocusedAzeriteBeam.ID)                 
			return A.FocusedAzeriteBeam:Show(icon)
        end
			
        -- purifying_blast,if=raid_event.adds.in>60
        if A.PurifyingBlast:AutoHeartOfAzerothP(unit, true) and inCombat and not Unit(unit):IsDead() and HeartOfAzeroth  then
            return A.PurifyingBlast:Show(icon)
        end
			
        -- ripple_in_space,if=raid_event.adds.in>60
        if A.RippleinSpace:AutoHeartOfAzerothP(unit, true) and inCombat and not Unit(unit):IsDead() and HeartOfAzeroth then
            return A.RippleinSpace:Show(icon)
        end
			
        -- thundercharge
        if A.Thundercharge:IsReady(unit) and inCombat and not Unit(unit):IsDead() then
            return A.Thundercharge:Show(icon)
        end
			
        -- concentrated_flame
        if A.ConcentratedFlame:AutoHeartOfAzerothP(unit, true) and inCombat and not Unit(unit):IsDead() and HeartOfAzeroth then
            return A.ConcentratedFlame:Show(icon)
        end
			
        -- reaping_flames
        if A.ReapingFlames:AutoHeartOfAzerothP(unit, true) and inCombat and not Unit(unit):IsDead() then
            return A.ReapingFlames:Show(icon)
        end
			
        -- bag_of_tricks
        if A.BagofTricks:AutoRacial(unit) and inCombat and not Unit(unit):IsDead() then
            return A.BagofTricks:Show(icon)
        end
			
        -- crash_lightning,if=talent.forceful_winds.enabled&active_enemies>1&variable.furyCheck_CL
        if A.CrashLightning:IsReady(player) and inCombat and not Unit(unit):IsDead() and (A.ForcefulWinds:IsSpellLearned() and GetByRange(1, CrashLightningRange) and VarFurycheckCl) then
            return A.CrashLightning:Show(icon)
        end
			
        -- flametongue,if=talent.searing_assault.enabled
        if A.Flametongue:IsReady(unit) and A.SearingAssault:IsSpellLearned() and inCombat and not Unit(unit):IsDead() then
            return A.Flametongue:Show(icon)
        end
			
        -- lava_lash,if=!azerite.primal_primer.enabled&talent.hot_hand.enabled&buff.hot_hand.react
        if A.LavaLash:IsReadyByPassCastGCD(unit) and inCombat and not Unit(unit):IsDead() and (A.PrimalPrimer:GetAzeriteRank() == 0 and A.HotHand:IsSpellLearned() and Unit(player):HasBuffsStacks(A.HotHandBuff.ID, true) > 0) then
            return A.LavaLash:Show(icon)
        end
			
        -- crash_lightning,if=active_enemies>1&variable.furyCheck_CL
        if A.CrashLightning:IsReady(player) and inCombat and not Unit(unit):IsDead() and (GetByRange(1, CrashLightningRange) and VarFurycheckCl) then
            return A.CrashLightning:Show(icon)
        end
			
        -- rockbiter,if=maelstrom<70&!buff.strength_of_earth.up
        if A.Rockbiter:IsReady(unit) and inCombat and not Unit(unit):IsDead() and (Player:Maelstrom() < 70 and Unit(player):HasBuffs(A.StrengthofEarthBuff.ID, true) == 0) then
            return A.Rockbiter:Show(icon)
        end
			
        -- crash_lightning,if=(talent.crashing_storm.enabled|talent.forceful_winds.enabled)&variable.OCPool_CL
        if A.CrashLightning:IsReady(player) and inCombat and not Unit(unit):IsDead() and Unit(unit):GetRange() < CrashLightningRange and ((A.CrashingStorm:IsSpellLearned() or A.ForcefulWinds:IsSpellLearned()) and VarOcpoolCl) then
            return A.CrashLightning:Show(icon)
        end
			
        -- lava_lash,if=variable.OCPool_LL&variable.furyCheck_LL
        if A.LavaLash:IsReadyByPassCastGCD(unit) and inCombat and not Unit(unit):IsDead() and (VarOcpoolLl and VarFurycheckLl) then
            return A.LavaLash:Show(icon)
        end
			
        -- memory_of_lucid_dreams
        if A.MemoryofLucidDreams:AutoHeartOfAzerothP(unit, true) and inCombat and not Unit(unit):IsDead() and HeartOfAzeroth then
            return A.MemoryofLucidDreams:Show(icon)
        end
			
        -- rockbiter
        if A.Rockbiter:IsReady(unit) and inCombat and not Unit(unit):IsDead() then
            return A.Rockbiter:Show(icon)
        end
			
        -- frostbrand,if=talent.hailstorm.enabled&buff.frostbrand.remains<4.8+gcd&variable.furyCheck_FB
        if A.Frostbrand:IsReady(unit) and inCombat and not Unit(unit):IsDead() and VarFurycheckFb and A.Hailstorm:IsSpellLearned() and Unit(player):HasBuffs(A.FrostbrandBuff.ID, true) <= FrostbrandRefresh  then
            return A.Frostbrand:Show(icon)
        end
		
        -- flametongue
        if A.Flametongue:IsReady(unit) and inCombat and not Unit(unit):IsDead() then
            return A.Flametongue:Show(icon)
        end
		
    end
    -- End on EnemyRotation()

    -- Defensive
    local SelfDefensive = SelfDefensives()
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

local function ArenaRotation(icon, unit)
    if A.IsInPvP and (A.Zone == "pvp" or A.Zone == "arena") and not Player:IsStealthed() and not Player:IsMounted() then
        -- Note: "arena1" is just identification of meta 6
        if (unit == "arena1" or unit == "arena2" or unit == "arena3") then  

            -- Hex	
            if useCC and A.Hex:IsReady(unit) and A.Hex:AbsentImun(unit, Temp.TotalAndCC, true) and Unit(unit):IsControlAble("incapacitate") then 
	            -- Notification					
                Action.SendNotification("Hex on " .. unit, A.Hex.ID)
                return A.Hex:Show(icon)              
            end
			
	    end
		
		-- Interrupt
        local Interrupt = Interrupts(unit)
        if Interrupt then 
            return Interrupt:Show(icon)
        end	
				
		-- CounterStrike Totem on Enemyburst
        if A.CounterStrikeTotem:IsReady(player) and Unit(player):IsFocused("DAMAGER") and Unit(player):GetDMG() > 2 and A.CounterStrikeTotem:IsSpellLearned() then 
            return A.CounterStrikeTotem:Show(icon)
        end
	
		-- Grounding Totem Casting BreakAble CC
        if A.GroundingTotem:IsReady(player) and A.GroundingTotem:IsSpellLearned() and Action.ShouldReflect(unit) and EnemyTeam():IsCastingBreakAble(0.25) then 
            return A.GroundingTotem:Show(icon)
        end
		
        -- Purge
        -- Note: Toggles  ("UseDispel", "UsePurge", "UseExpelEnrage")
        -- Category ("Dispel", "MagicMovement", "PurgeFriendly", "PurgeHigh", "PurgeLow", "Enrage")
        if A.Purge:IsReady(unit) and A.LastPlayerCastName ~= A.Purge:Info() and Action.AuraIsValid(unit, "UsePurge", "PurgeHigh") 
		and Unit(unit):HasBuffs(A.BlessingofProtection.ID, true) == 0
		then
            return A.Purge:Show(icon)
        end 
			
        -- Purge
        -- Note: Toggles  ("UseDispel", "UsePurge", "UseExpelEnrage")
        -- Category ("Dispel", "MagicMovement", "PurgeFriendly", "PurgeHigh", "PurgeLow", "Enrage")
        if A.Purge:IsReady(unit) and A.LastPlayerCastName ~= A.Purge:Info() and Action.AuraIsValid(unit, "UsePurge", "PurgeLow") 
		and Unit(unit):HasBuffs(A.BlessingofProtection.ID, true) == 0
		then
            return A.Purge:Show(icon)
        end         		
    end 
end 

local function PartyRotation(unit)
    if (unit == "party1" and not Action.GetToggle(2, "PartyUnits")[1]) or (unit == "party2" and not Action.GetToggle(2, "PartyUnits")[2]) then 
        return false 
    end

  	-- CleanseSpirit
    --if A.CleanseSpirit:IsReady(unit) and A.CleanseSpirit:AbsentImun(unit, Temp.TotalAndMag) and Action.AuraIsValid(unit, "UseDispel", "Magic") and not Unit(unit):InLOS() then
    --    return A.CleanseSpirit
    --end
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
end

