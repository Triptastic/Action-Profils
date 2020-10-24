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

Action[ACTION_CONST_DRUID_BALANCE] = {
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
    MoonkinForm                            = Create({ Type = "Spell", ID = 24858 }),
    Wrath                                  = Create({ Type = "Spell", ID =  }),
    Starfire                               = Create({ Type = "Spell", ID =  }),
    IncarnationBuff                        = Create({ Type = "Spell", ID = 102560 }),
    Incarnation                            = Create({ Type = "Spell", ID = 102560 }),
    Starfall                               = Create({ Type = "Spell", ID = 191034 }),
    StarfallBuff                           = Create({ Type = "Spell", ID =  }),
    TimewornDreambinderBuff                = Create({ Type = "Spell", ID =  }),
    FuryofEluneDebuff                      = Create({ Type = "Spell", ID =  }),
    Starsurge                              = Create({ Type = "Spell", ID = 78674 }),
    Sunfire                                = Create({ Type = "Spell", ID = 93402 }),
    SunfireDebuff                          = Create({ Type = "Spell", ID = 164815 }),
    AdaptiveSwarm                          = Create({ Type = "Spell", ID =  }),
    AdaptiveSwarmDamage                    = Create({ Type = "Spell", ID =  }),
    AdaptiveSwarmDamageDebuff              = Create({ Type = "Spell", ID =  }),
    Moonfire                               = Create({ Type = "Spell", ID = 8921 }),
    MoonfireDebuff                         = Create({ Type = "Spell", ID = 164812 }),
    CaInc                                  = Create({ Type = "Spell", ID =  }),
    SouloftheForest                        = Create({ Type = "Spell", ID = 114107 }),
    TwinMoons                              = Create({ Type = "Spell", ID = 279620 }),
    KindredEmpowermentEnergizeBuff         = Create({ Type = "Spell", ID =  }),
    ForceofNature                          = Create({ Type = "Spell", ID = 205636 }),
    RavenousFrenzy                         = Create({ Type = "Spell", ID =  }),
    CaIncBuff                              = Create({ Type = "Spell", ID =  }),
    CelestialAlignment                     = Create({ Type = "Spell", ID = 194223 }),
    SolsticeBuff                           = Create({ Type = "Spell", ID =  }),
    ConvoketheSpirits                      = Create({ Type = "Spell", ID =  }),
    KindredSpirits                         = Create({ Type = "Spell", ID =  }),
    PrimordialArcanicPulsarBuff            = Create({ Type = "Spell", ID =  }),
    StellarFlare                           = Create({ Type = "Spell", ID = 202347 }),
    StellarFlareDebuff                     = Create({ Type = "Spell", ID = 202347 }),
    FuryofElune                            = Create({ Type = "Spell", ID = 202770 }),
    OnethsPerceptionBuff                   = Create({ Type = "Spell", ID =  }),
    OnethsClearVisionBuff                  = Create({ Type = "Spell", ID =  }),
    RavenousFrenzyBuff                     = Create({ Type = "Spell", ID =  }),
    NewMoon                                = Create({ Type = "Spell", ID = 274281 }),
    HalfMoon                               = Create({ Type = "Spell", ID = 274282 }),
    FullMoon                               = Create({ Type = "Spell", ID = 274283 }),
    WarriorofElune                         = Create({ Type = "Spell", ID = 202425 }),
    StarsurgeEmpowermentBuff               = Create({ Type = "Spell", ID =  }),
    BalanceofAllThingsNatureBuff           = Create({ Type = "Spell", ID =  }),
    BalanceofAllThingsArcaneBuff           = Create({ Type = "Spell", ID =  }),
    StarlordBuff                           = Create({ Type = "Spell", ID = 279709 }),
    EmpowerBond                            = Create({ Type = "Spell", ID =  }),
    AdaptiveSwarmHealDebuff                = Create({ Type = "Spell", ID =  }),
    EclipseSolarBuff                       = Create({ Type = "Spell", ID =  }),
    EclipseLunarBuff                       = Create({ Type = "Spell", ID =  }),
    WarriorofEluneBuff                     = Create({ Type = "Spell", ID = 202425 }),
    StreakingStars                         = Create({ Type = "Spell", ID = 272871 }),
    Starlord                               = Create({ Type = "Spell", ID = 202345 }),
    DawningSun                             = Create({ Type = "Spell", ID =  }),
    DawningSunBuff                         = Create({ Type = "Spell", ID =  }),
    StellarDrift                           = Create({ Type = "Spell", ID = 202354 }),
    Berserking                             = Create({ Type = "Spell", ID = 26297 }),
    HeartEssence                           = Create({ Type = "Spell", ID = 298554 })
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
Action:CreateEssencesFor(ACTION_CONST_DRUID_BALANCE)  -- where PLAYERSPEC is Constance (example: ACTION_CONST_MONK_BM)
local A = setmetatable(Action[ACTION_CONST_DRUID_BALANCE], { __index = Action })


------------------------------------------
---------------- VARIABLES ---------------
------------------------------------------
local VarConvokeDesync = 0;
local VarStarfallWontFallOff = 0;
local VarConvokeCondition = 0;
local VarStarfireInSolar = 0;
local VarIsCleave = 0;
local VarCritnotup = 0;
local VarIsAoe = 0;
local VarAsppersec = 0;
local VarSafeToUseSpell = 0;
local VarSaveForCaInc = 0;
local VarPrevStarsurge = 0;
local VarPrevWrath = 0;
local VarPrevStarfire = 0;

A.Listener:Add("ROTATION_VARS", "PLAYER_REGEN_ENABLED", function()
  VarConvokeDesync = 0
  VarStarfallWontFallOff = 0
  VarConvokeCondition = 0
  VarStarfireInSolar = 0
  VarIsCleave = 0
  VarCritnotup = 0
  VarIsAoe = 0
  VarAsppersec = 0
  VarSafeToUseSpell = 0
  VarSaveForCaInc = 0
  VarPrevStarsurge = 0
  VarPrevWrath = 0
  VarPrevStarfire = 0
end)



local function num(val)
    if val then return 1 else return 0 end
end

local function bool(val)
    return val ~= 0
end

------------------------------------------
--------- BALANCE PRE APL SETUP ----------
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
	AttackTypes 							= {"TotalImun", "DamageMagicImun"},
	AuraForStun								= {"TotalImun", "DamagePhysImun", "CCTotalImun", "StunImun"},	
	AuraForCC								= {"TotalImun", "DamagePhysImun", "CCTotalImun"},
	AuraForOnlyCCAndStun					= {"CCTotalImun", "StunImun"},
	AuraForDisableMag						= {"TotalImun", "DamageMagicImun", "Freedom", "CCTotalImun"},
	AuraForInterrupt						= {"TotalImun", "DamagePhysImun", "KickImun"},
}

local IsIndoors, UnitIsUnit = IsIndoors, UnitIsUnit

local function IsSchoolFree()
	return LoC:IsMissed("SILENCE") and LoC:Get("SCHOOL_INTERRUPT", "SHADOW") == 0
end 

local function InRange(unit)
	-- @return boolean 
	return A.SolarWrath:IsInRange(unit)
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

local function FutureAstralPower()
    local AstralPower = Player:AstralPower()
    local castName, castStartTime, castEndTime, notInterruptable, spellID, isChannel = Unit(player):IsCasting()
        
    if not Unit(player):IsCasting() then
        return AstralPower
    else
        if spellID == A.NewMoon.ID then
            return AstralPower + 10
        elseif spellID == A.HalfMoon.ID then
            return AstralPower + 20
        elseif spellID == A.FullMoon.ID then
            return AstralPower + 40
        elseif spellID == A.StellarFlare.ID then
            return AstralPower + 8
        elseif spellID == A.SolarWrath.ID then
            return AstralPower + 8
        elseif spellID == A.LunarStrike.ID then
            return AstralPower + 12
        else
            return AstralPower
        end
    end
end

-- Return current CelestialAlignment or Incarnation
local function CaInc()
    return A.Incarnation:IsSpellLearned() and A.Incarnation or A.CelestialAlignment
end

-- Return current CelestialAlignment or Incarnation (with ID to work with buff checks)
local function CaIncID()
    return A.Incarnation:IsSpellLearned() and A.Incarnation.ID or A.CelestialAlignment.ID
end

local function AP_Check(spell)
  local APGen = 0
  local CurAP = Player:AstralPower()
  if spell == A.Sunfire or spell == A.Moonfire then 
    APGen = 3
  elseif spell == A.StellarFlare or spell == A.SolarWrath then
    APGen = 8
  elseif spell == A.Incarnation or spell == A.CelestialAlignment then
    APGen = 40
  elseif spell == A.ForceofNature then
    APGen = 20
  elseif spell == A.LunarStrike then
    APGen = 12
  end
  
  if A.ShootingStars:IsSpellLearned() then 
    APGen = APGen + 4
  end
  if A.NaturesBalance:IsSpellLearned() then
    APGen = APGen + 2
  end
  
  if CurAP + APGen < Player:AstralPowerMax() then
    return true
  else
    return false
  end
end

local function HandleMultidots()
    local choice = Action.GetToggle(2, "AutoDotSelection")
       
    if choice == "In Raid" then
		if IsInRaid() then
    		return true
		else
		    return false
		end
    elseif choice == "In Dungeon" then 
		if Player:InDungeon() then
    		return true
		else
		    return false
		end
	elseif choice == "In PvP" then 	
		if Player:InPvP() then 
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

local function IsSchoolNatureUP()
	return LoC:IsMissed("SILENCE") and LoC:Get("SCHOOL_INTERRUPT", "NATURE") == 0
end 

local function IsSchoolArcaneUP()
	return LoC:IsMissed("SILENCE") and LoC:Get("SCHOOL_INTERRUPT", "ARCANE") == 0
end 

local function EvaluateCycleCyclotronicBlast105(unit)
    return (Unit(unit):HasDeBuffs(A.MoonfireDebuff.ID, true) and Unit(unit):HasDeBuffs(A.SunfireDebuff.ID, true) and (not A.StellarFlare:IsSpellLearned() or Unit(unit):HasDeBuffs(A.StellarFlareDebuff.ID, true))) and (Unit(player):HasBuffs(CaIncID, true) == 0)
end

local function EvaluateCycleShiverVenomRelic122(unit)
    return (Unit(unit):HasDeBuffsStacks(A.ShiverVenomDebuff.ID, true) >= 5) and (Unit(player):HasBuffs(CaIncID, true) == 0 and not Unit(player):HasHeroism())
end

local function SelfDefensives()
	-- Renewal
	local Renewal = A.GetToggle(2, "RenewalHP")
    if A.Renewal:IsReady(player) and Unit(player):HealthPercent() <= Renewal then
        return A.Renewal:Show(icon)
    end			
	
    -- Barkskin	
	local Barkskin = A.GetToggle(2, "BarkskinHP")	
	if A.Barkskin:IsReady(player) and Unit(player):HealthPercent() <= Barkskin and Unit(player):CombatTime() > 0 then
		return A.Barkskin
	end
	
	-- Swiftmend
	local Swiftmend = A.GetToggle(2, "SwiftmendHP")	
	if A.Swiftmend:IsReady(player) and  Unit(player):HealthPercent() <= Swiftmend then
		return A.Swiftmend
	end
	
	-- HealingPotion
	local PotHeal = A.GetToggle(2, "AbyssalPot")
	if A.AbyssalHealingPotion:IsReady(player) and  Unit(player):HealthPercent() <= PotHeal and Unit(player):CombatTime() > 0 then
		return A.AbyssalHealingPotion
	end
	
end
SelfDefensives = A.MakeFunctionCachedStatic(SelfDefensives)

			
-- Non GCD spell check
local function countInterruptGCD(unit)
    if not A.SolarBeam:IsReadyByPassCastGCD(unit) or not A.SolarBeam:AbsentImun(unit, Temp.TotalAndMagKick) then
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
  	    -- SolarBeam
  	    if useKick and A.SolarBeam:IsReady() and A.SolarBeam:IsSpellLearned() then 
		    -- Notification					
            Action.SendNotification("Solar Beam on: " .. UnitName(unit), A.SolarBeam.ID) 
            return A.SolarBeam
        end         

        if useCC and A.MightyBash:IsReady(unit) and A.MightyBash:IsSpellLearned() and A.MightyBash:AbsentImun(unit, Temp.TotalAndPhysKick, true) then 
            -- Notification                    
            Action.SendNotification("Mighty Bash interrupting on " .. unit, A.MightyBash.ID)
            return A.MightyBash
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

local function IsInHumanForm()
    return Player:GetStance() == 0
end

local function IsInBearForm()
    return Player:GetStance() == 1
end

local function IsInCatForm()
    return Player:GetStance() == 2
end

local function IsInTravelForm()
    return Player:GetStance() == 3
end

local function IsInMoonkinForm()
    return Player:GetStance() == 4
end

local function EvaluateCycleSunfire1234(unit)
    return (Unit(unit):HasDeBuffsRefreshable(A.SunfireDebuff.ID, true) and Unit(unit):TimeToDie() > 12) and ((Unit("player"):HasBuffs(A.CaIncBuff.ID, true) > 5 and (Unit("player"):HasBuffs(A.RavenousFrenzyBuff.ID, true) > 5 or not Unit("player"):HasBuffs(A.RavenousFrenzyBuff.ID, true)) or not Unit("player"):HasBuffs(A.CaIncBuff.ID, true) or FutureAstralPower < 30) and (not Unit("player"):HasBuffs(A.KindredEmpowermentEnergizeBuff.ID, true) or FutureAstralPower < 30) and ap_check)
end

local function EvaluateCycleStellarFlare1257(unit)
    return (Unit(unit):HasDeBuffsRefreshable(A.StellarFlareDebuff.ID, true) and Unit(unit):TimeToDie() > 16) and ((Unit("player"):HasBuffs(A.CaIncBuff.ID, true) > 5 and (Unit("player"):HasBuffs(A.RavenousFrenzyBuff.ID, true) > 5 or not Unit("player"):HasBuffs(A.RavenousFrenzyBuff.ID, true)) or not Unit("player"):HasBuffs(A.CaIncBuff.ID, true) or FutureAstralPower < 30) and (not Unit("player"):HasBuffs(A.KindredEmpowermentEnergizeBuff.ID, true) or FutureAstralPower < 30) and ap_check)
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
            -- moonkin_form
            if A.MoonkinForm:IsReady(unit) then
                return A.MoonkinForm:Show(icon)
            end
            
            -- wrath
            if A.Wrath:IsReady(unit) then
                return A.Wrath:Show(icon)
            end
            
            -- wrath
            if A.Wrath:IsReady(unit) then
                return A.Wrath:Show(icon)
            end
            
            -- starfire
            if A.Starfire:IsReady(unit) then
                return A.Starfire:Show(icon)
            end
            
            -- variable,name=convoke_desync,value=floor((interpolated_fight_remains-20)%120)>floor((interpolated_fight_remains-25-(10*talent.incarnation.enabled)-(4*conduit.precise_alignment.enabled))%180)
            VarConvokeDesync = num(math.floor ((interpolated_fight_remains - 20) / 120) > math.floor ((interpolated_fight_remains - 25 - (10 * num(A.Incarnation:IsSpellLearned())) - (4 * conduit.precise_alignment.enabled)) / 180))
            
        end
        
        --Aoe
        local function Aoe(unit)
        
            -- starfall,if=buff.starfall.refreshable&(!runeforge.lycaras_fleeting_glimpse.equipped|time%%45>buff.starfall.remains+2)
            if A.Starfall:IsReady(unit) and (Unit("player"):HasBuffsRefreshable(A.StarfallBuff.ID, true) and (not runeforge.lycaras_fleeting_glimpse.equipped or Unit("player"):CombatTime() / num(true) / 45 > Unit("player"):HasBuffs(A.StarfallBuff.ID, true) + 2)) then
                return A.Starfall:Show(icon)
            end
            
            -- variable,name=starfall_wont_fall_off,value=astral_power>80-(10*buff.timeworn_dreambinder.stack)-(buff.starfall.remains*3%spell_haste)-(dot.fury_of_elune.remains*5)&buff.starfall.up
            VarStarfallWontFallOff = num(FutureAstralPower > 80 - (10 * Unit("player"):HasBuffsStacks(A.TimewornDreambinderBuff.ID, true)) - (Unit("player"):HasBuffs(A.StarfallBuff.ID, true) * 3 / Player:SpellHaste()) - (Unit(unit):HasDeBuffs(A.FuryofEluneDebuff.ID, true) * 5) and Unit("player"):HasBuffs(A.StarfallBuff.ID, true))
            
            -- starsurge,if=(buff.timeworn_dreambinder.remains<gcd.max+0.1|buff.timeworn_dreambinder.remains<action.starfire.execute_time+0.1&(eclipse.in_lunar|eclipse.solar_next|eclipse.any_next))&variable.starfall_wont_fall_off&buff.timeworn_dreambinder.up
            if A.Starsurge:IsReady(unit) and ((Unit("player"):HasBuffs(A.TimewornDreambinderBuff.ID, true) < GetGCD() + 0.1 or Unit("player"):HasBuffs(A.TimewornDreambinderBuff.ID, true) < A.Starfire:GetSpellCastTime() + 0.1 and (eclipse.in_lunar or eclipse.solar_next or eclipse.any_next)) and VarStarfallWontFallOff and Unit("player"):HasBuffs(A.TimewornDreambinderBuff.ID, true)) then
                return A.Starsurge:Show(icon)
            end
            
            -- sunfire,target_if=refreshable&target.time_to_die>14-spell_targets+remains,if=ap_check&eclipse.in_any
            if A.Sunfire:IsReady(unit) then
                if (Unit(unit):HasDeBuffsRefreshable(A.SunfireDebuff.ID, true) and Unit(unit):TimeToDie() > 14 - MultiUnits:GetByRangeInCombat(40, 5, 10) + Unit(unit):HasDeBuffs(A.SunfireDebuff.ID, true)) and (ap_check and eclipse.in_any) then
                    return A.Sunfire:Show(icon) 
                end
            end
            -- adaptive_swarm,target_if=!ticking&!action.adaptive_swarm_damage.in_flight|dot.adaptive_swarm_damage.stack<3&dot.adaptive_swarm_damage.remains<3
            if A.AdaptiveSwarm:IsReady(unit) then
                if not ticking and not A.AdaptiveSwarmDamage:IsSpellInFlight() or Unit(unit):HasDeBuffsStacks(A.AdaptiveSwarmDamageDebuff.ID, true) < 3 and Unit(unit):HasDeBuffs(A.AdaptiveSwarmDamageDebuff.ID, true) < 3 then
                    return A.AdaptiveSwarm:Show(icon) 
                end
            end
            -- moonfire,target_if=refreshable&target.time_to_die>(14+(spell_targets.starfire*1.5))%spell_targets+remains,if=(cooldown.ca_inc.ready|spell_targets.starfire<3|(eclipse.in_solar|eclipse.in_both|eclipse.in_lunar&!talent.soul_of_the_forest.enabled)&(spell_targets.starfire<10*(1+talent.twin_moons.enabled))&astral_power>50-buff.starfall.remains*6)&!buff.kindred_empowerment_energize.up&ap_check
            if A.Moonfire:IsReady(unit) then
                if (Unit(unit):HasDeBuffsRefreshable(A.MoonfireDebuff.ID, true) and Unit(unit):TimeToDie() > (14 + (MultiUnits:GetByRangeInCombat(5, 5, 10) * 1.5)) / MultiUnits:GetByRangeInCombat(40, 5, 10) + Unit(unit):HasDeBuffs(A.MoonfireDebuff.ID, true)) and ((A.CaInc:GetCooldown() == 0 or MultiUnits:GetByRangeInCombat(5, 5, 10) < 3 or (eclipse.in_solar or eclipse.in_both or eclipse.in_lunar and not A.SouloftheForest:IsSpellLearned()) and (MultiUnits:GetByRangeInCombat(5, 5, 10) < 10 * (1 + num(A.TwinMoons:IsSpellLearned()))) and FutureAstralPower > 50 - Unit("player"):HasBuffs(A.StarfallBuff.ID, true) * 6) and not Unit("player"):HasBuffs(A.KindredEmpowermentEnergizeBuff.ID, true) and ap_check) then
                    return A.Moonfire:Show(icon) 
                end
            end
            -- force_of_nature,if=ap_check
            if A.ForceofNature:IsReady(unit) and (ap_check) then
                return A.ForceofNature:Show(icon)
            end
            
            -- ravenous_frenzy,if=buff.ca_inc.up
            if A.RavenousFrenzy:IsReady(unit) and (Unit("player"):HasBuffs(A.CaIncBuff.ID, true)) then
                return A.RavenousFrenzy:Show(icon)
            end
            
            -- celestial_alignment,if=(buff.starfall.up|astral_power>50)&!buff.solstice.up&!buff.ca_inc.up&(interpolated_fight_remains<cooldown.convoke_the_spirits.remains+7|interpolated_fight_remains%%180<22|cooldown.convoke_the_spirits.up|!covenant.night_fae)
            if A.CelestialAlignment:IsReady(unit) and ((Unit("player"):HasBuffs(A.StarfallBuff.ID, true) or FutureAstralPower > 50) and not Unit("player"):HasBuffs(A.SolsticeBuff.ID, true) and not Unit("player"):HasBuffs(A.CaIncBuff.ID, true) and (interpolated_fight_remains < A.ConvoketheSpirits:GetCooldown() + 7 or interpolated_fight_remains / num(true) / 180 < 22 or A.ConvoketheSpirits:GetCooldown() == 0 or not covenant.night_fae)) then
                return A.CelestialAlignment:Show(icon)
            end
            
            -- incarnation,if=(buff.starfall.up|astral_power>50)&!buff.solstice.up&!buff.ca_inc.up&(interpolated_fight_remains<cooldown.convoke_the_spirits.remains+7|interpolated_fight_remains%%180<32|cooldown.convoke_the_spirits.up|!covenant.night_fae)
            if A.Incarnation:IsReady(unit) and ((Unit("player"):HasBuffs(A.StarfallBuff.ID, true) or FutureAstralPower > 50) and not Unit("player"):HasBuffs(A.SolsticeBuff.ID, true) and not Unit("player"):HasBuffs(A.CaIncBuff.ID, true) and (interpolated_fight_remains < A.ConvoketheSpirits:GetCooldown() + 7 or interpolated_fight_remains / num(true) / 180 < 32 or A.ConvoketheSpirits:GetCooldown() == 0 or not covenant.night_fae)) then
                return A.Incarnation:Show(icon)
            end
            
            -- kindred_spirits,if=interpolated_fight_remains<15|(buff.primordial_arcanic_pulsar.value<250|buff.primordial_arcanic_pulsar.value>=250)&buff.starfall.up&cooldown.ca_inc.remains>50
            if A.KindredSpirits:IsReady(unit) and (interpolated_fight_remains < 15 or (buff.primordial_arcanic_pulsar.value < 250 or buff.primordial_arcanic_pulsar.value >= 250) and Unit("player"):HasBuffs(A.StarfallBuff.ID, true) and A.CaInc:GetCooldown() > 50) then
                return A.KindredSpirits:Show(icon)
            end
            
            -- stellar_flare,target_if=refreshable&time_to_die>15,if=spell_targets.starfire<4&ap_check&(buff.ca_inc.remains>10|!buff.ca_inc.up)
            if A.StellarFlare:IsReady(unit) then
                if (Unit(unit):HasDeBuffsRefreshable(A.StellarFlareDebuff.ID, true) and Unit(unit):TimeToDie() > 15) and (MultiUnits:GetByRangeInCombat(5, 5, 10) < 4 and ap_check and (Unit("player"):HasBuffs(A.CaIncBuff.ID, true) > 10 or not Unit("player"):HasBuffs(A.CaIncBuff.ID, true))) then
                    return A.StellarFlare:Show(icon) 
                end
            end
            -- variable,name=convoke_condition,value=buff.primordial_arcanic_pulsar.value<250-astral_power&(cooldown.ca_inc.remains+10>interpolated_fight_remains|cooldown.ca_inc.remains+30<interpolated_fight_remains&interpolated_fight_remains>130|buff.ca_inc.remains>7)&eclipse.in_any|interpolated_fight_remains%%120<15
            VarConvokeCondition = num(buff.primordial_arcanic_pulsar.value < 250 - FutureAstralPower and (A.CaInc:GetCooldown() + 10 > interpolated_fight_remains or A.CaInc:GetCooldown() + 30 < interpolated_fight_remains and interpolated_fight_remains > 130 or Unit("player"):HasBuffs(A.CaIncBuff.ID, true) > 7) and eclipse.in_any or interpolated_fight_remains / num(true) / 120 < 15)
            
            -- convoke_the_spirits,if=variable.convoke_condition&astral_power<50
            if A.ConvoketheSpirits:IsReady(unit) and (VarConvokeCondition and FutureAstralPower < 50) then
                return A.ConvoketheSpirits:Show(icon)
            end
            
            -- fury_of_elune,if=eclipse.in_any&ap_check&buff.primordial_arcanic_pulsar.value<250&(dot.adaptive_swarm_damage.ticking|!covenant.necrolord|spell_targets>2)
            if A.FuryofElune:IsReady(unit) and (eclipse.in_any and ap_check and buff.primordial_arcanic_pulsar.value < 250 and (Unit(unit):HasDeBuffs(A.AdaptiveSwarmDamageDebuff.ID, true) or not covenant.necrolord or MultiUnits:GetByRangeInCombat(40, 5, 10) > 2)) then
                return A.FuryofElune:Show(icon)
            end
            
            -- starfall,if=buff.oneths_perception.up&(buff.starfall.refreshable|astral_power>90)
            if A.Starfall:IsReady(unit) and (Unit("player"):HasBuffs(A.OnethsPerceptionBuff.ID, true) and (Unit("player"):HasBuffsRefreshable(A.StarfallBuff.ID, true) or FutureAstralPower > 90)) then
                return A.Starfall:Show(icon)
            end
            
            -- starfall,if=covenant.night_fae&variable.convoke_condition&cooldown.convoke_the_spirits.remains<gcd.max*ceil(astral_power%50)&buff.starfall.refreshable
            if A.Starfall:IsReady(unit) and (covenant.night_fae and VarConvokeCondition and A.ConvoketheSpirits:GetCooldown() < GetGCD() * math.ceil (FutureAstralPower / 50) and Unit("player"):HasBuffsRefreshable(A.StarfallBuff.ID, true)) then
                return A.Starfall:Show(icon)
            end
            
            -- starsurge,if=covenant.night_fae&variable.convoke_condition&cooldown.convoke_the_spirits.remains<gcd.max*ceil(astral_power%30)&buff.starfall.up
            if A.Starsurge:IsReady(unit) and (covenant.night_fae and VarConvokeCondition and A.ConvoketheSpirits:GetCooldown() < GetGCD() * math.ceil (FutureAstralPower / 30) and Unit("player"):HasBuffs(A.StarfallBuff.ID, true)) then
                return A.Starsurge:Show(icon)
            end
            
            -- starsurge,if=buff.oneths_clear_vision.up|!starfire.ap_check|(buff.ca_inc.remains<5&buff.ca_inc.up|(buff.ravenous_frenzy.remains<gcd.max*ceil(astral_power%30)&buff.ravenous_frenzy.up))&variable.starfall_wont_fall_off&spell_targets.starfall<3
            if A.Starsurge:IsReady(unit) and (Unit("player"):HasBuffs(A.OnethsClearVisionBuff.ID, true) or not starfire.ap_check or (Unit("player"):HasBuffs(A.CaIncBuff.ID, true) < 5 and Unit("player"):HasBuffs(A.CaIncBuff.ID, true) or (Unit("player"):HasBuffs(A.RavenousFrenzyBuff.ID, true) < GetGCD() * math.ceil (FutureAstralPower / 30) and Unit("player"):HasBuffs(A.RavenousFrenzyBuff.ID, true))) and VarStarfallWontFallOff and MultiUnits:GetByRangeInCombat(40, 5, 10) < 3) then
                return A.Starsurge:Show(icon)
            end
            
            -- new_moon,if=(eclipse.in_any&cooldown.ca_inc.remains>50|(charges=2&recharge_time<5)|charges=3)&ap_check
            if A.NewMoon:IsReady(unit) and ((eclipse.in_any and A.CaInc:GetCooldown() > 50 or (A.NewMoon:GetSpellCharges() == 2 and A.NewMoon:RechargeP() < 5) or A.NewMoon:GetSpellCharges() == 3) and ap_check) then
                return A.NewMoon:Show(icon)
            end
            
            -- half_moon,if=(eclipse.in_any&cooldown.ca_inc.remains>50|(charges=2&recharge_time<5)|charges=3)&ap_check
            if A.HalfMoon:IsReady(unit) and ((eclipse.in_any and A.CaInc:GetCooldown() > 50 or (A.HalfMoon:GetSpellCharges() == 2 and A.HalfMoon:RechargeP() < 5) or A.HalfMoon:GetSpellCharges() == 3) and ap_check) then
                return A.HalfMoon:Show(icon)
            end
            
            -- full_moon,if=(eclipse.in_any&cooldown.ca_inc.remains>50|(charges=2&recharge_time<5)|charges=3)&ap_check
            if A.FullMoon:IsReady(unit) and ((eclipse.in_any and A.CaInc:GetCooldown() > 50 or (A.FullMoon:GetSpellCharges() == 2 and A.FullMoon:RechargeP() < 5) or A.FullMoon:GetSpellCharges() == 3) and ap_check) then
                return A.FullMoon:Show(icon)
            end
            
            -- warrior_of_elune
            if A.WarriorofElune:IsReady(unit) then
                return A.WarriorofElune:Show(icon)
            end
            
            -- variable,name=starfire_in_solar,value=spell_targets.starfire>8+floor(mastery_value%20)+floor(buff.starsurge_empowerment.stack%4)
            VarStarfireInSolar = num(MultiUnits:GetByRangeInCombat(5, 5, 10) > 8 + math.floor (mastery_value / 20) + math.floor (Unit("player"):HasBuffsStacks(A.StarsurgeEmpowermentBuff.ID, true) / 4))
            
            -- wrath,if=eclipse.lunar_next|eclipse.any_next&variable.is_cleave|eclipse.in_solar&!variable.starfire_in_solar|buff.ca_inc.remains<action.starfire.execute_time&!variable.is_cleave&buff.ca_inc.remains<execute_time&buff.ca_inc.up|buff.ravenous_frenzy.up&spell_haste>0.6|!variable.is_cleave&buff.ca_inc.remains>execute_time
            if A.Wrath:IsReady(unit) and (eclipse.lunar_next or eclipse.any_next and VarIsCleave or eclipse.in_solar and not VarStarfireInSolar or Unit("player"):HasBuffs(A.CaIncBuff.ID, true) < A.Starfire:GetSpellCastTime() and not VarIsCleave and Unit("player"):HasBuffs(A.CaIncBuff.ID, true) < A.Wrath:GetSpellCastTime() and Unit("player"):HasBuffs(A.CaIncBuff.ID, true) or Unit("player"):HasBuffs(A.RavenousFrenzyBuff.ID, true) and Player:SpellHaste() > 0.6 or not VarIsCleave and Unit("player"):HasBuffs(A.CaIncBuff.ID, true) > A.Wrath:GetSpellCastTime()) then
                return A.Wrath:Show(icon)
            end
            
            -- starfire
            if A.Starfire:IsReady(unit) then
                return A.Starfire:Show(icon)
            end
            
            -- run_action_list,name=fallthru
            return Fallthru(unit);
            
        end
        
        --Boat
        local function Boat(unit)
        
            -- ravenous_frenzy,if=buff.ca_inc.up
            if A.RavenousFrenzy:IsReady(unit) and (Unit("player"):HasBuffs(A.CaIncBuff.ID, true)) then
                return A.RavenousFrenzy:Show(icon)
            end
            
            -- variable,name=critnotup,value=!buff.balance_of_all_things_nature.up&!buff.balance_of_all_things_arcane.up
            VarCritnotup = num(not Unit("player"):HasBuffs(A.BalanceofAllThingsNatureBuff.ID, true) and not Unit("player"):HasBuffs(A.BalanceofAllThingsArcaneBuff.ID, true))
            
            -- cancel_buff,name=starlord,if=(buff.balance_of_all_things_nature.remains>4.5|buff.balance_of_all_things_arcane.remains>4.5)&astral_power>=90&(cooldown.ca_inc.remains>7|(cooldown.empower_bond.remains>7&!buff.kindred_empowerment_energize.up&covenant.kyrian))
            if ((Unit("player"):HasBuffs(A.BalanceofAllThingsNatureBuff.ID, true) > 4.5 or Unit("player"):HasBuffs(A.BalanceofAllThingsArcaneBuff.ID, true) > 4.5) and FutureAstralPower >= 90 and (A.CaInc:GetCooldown() > 7 or (A.EmpowerBond:GetCooldown() > 7 and not Unit("player"):HasBuffs(A.KindredEmpowermentEnergizeBuff.ID, true) and covenant.kyrian))) then
                Player:CancelBuff(A.StarlordBuff:Info())
            end
            
            -- starsurge,if=!variable.critnotup&((!cooldown.convoke_the_spirits.up|!variable.convoke_condition|!covenant.night_fae)&(covenant.night_fae|(cooldown.ca_inc.remains>7|(cooldown.empower_bond.remains>7&!buff.kindred_empowerment_energize.up&covenant.kyrian))))|(cooldown.convoke_the_spirits.up&cooldown.ca_inc.ready&covenant.night_fae)
            if A.Starsurge:IsReady(unit) and (not VarCritnotup and ((not A.ConvoketheSpirits:GetCooldown() == 0 or not VarConvokeCondition or not covenant.night_fae) and (covenant.night_fae or (A.CaInc:GetCooldown() > 7 or (A.EmpowerBond:GetCooldown() > 7 and not Unit("player"):HasBuffs(A.KindredEmpowermentEnergizeBuff.ID, true) and covenant.kyrian)))) or (A.ConvoketheSpirits:GetCooldown() == 0 and A.CaInc:GetCooldown() == 0 and covenant.night_fae)) then
                return A.Starsurge:Show(icon)
            end
            
            -- adaptive_swarm,target_if=!dot.adaptive_swarm_damage.ticking&!action.adaptive_swarm_damage.in_flight&(!dot.adaptive_swarm_heal.ticking|dot.adaptive_swarm_heal.remains>5)|dot.adaptive_swarm_damage.stack<3&dot.adaptive_swarm_damage.remains<3&dot.adaptive_swarm_damage.ticking
            if A.AdaptiveSwarm:IsReady(unit) then
                if not Unit(unit):HasDeBuffs(A.AdaptiveSwarmDamageDebuff.ID, true) and not A.AdaptiveSwarmDamage:IsSpellInFlight() and (not Unit(unit):HasDeBuffs(A.AdaptiveSwarmHealDebuff.ID, true) or Unit(unit):HasDeBuffs(A.AdaptiveSwarmHealDebuff.ID, true) > 5) or Unit(unit):HasDeBuffsStacks(A.AdaptiveSwarmDamageDebuff.ID, true) < 3 and Unit(unit):HasDeBuffs(A.AdaptiveSwarmDamageDebuff.ID, true) < 3 and Unit(unit):HasDeBuffs(A.AdaptiveSwarmDamageDebuff.ID, true) then
                    return A.AdaptiveSwarm:Show(icon) 
                end
            end
            -- sunfire,target_if=refreshable&target.time_to_die>16,if=ap_check&(variable.critnotup|(astral_power<30&!buff.ca_inc.up)|cooldown.ca_inc.ready)
            if A.Sunfire:IsReady(unit) then
                if (Unit(unit):HasDeBuffsRefreshable(A.SunfireDebuff.ID, true) and Unit(unit):TimeToDie() > 16) and (ap_check and (VarCritnotup or (FutureAstralPower < 30 and not Unit("player"):HasBuffs(A.CaIncBuff.ID, true)) or A.CaInc:GetCooldown() == 0)) then
                    return A.Sunfire:Show(icon) 
                end
            end
            -- moonfire,target_if=refreshable&target.time_to_die>13.5,if=ap_check&(variable.critnotup|(astral_power<30&!buff.ca_inc.up)|cooldown.ca_inc.ready)&!buff.kindred_empowerment_energize.up
            if A.Moonfire:IsReady(unit) then
                if (Unit(unit):HasDeBuffsRefreshable(A.MoonfireDebuff.ID, true) and Unit(unit):TimeToDie() > 13.5) and (ap_check and (VarCritnotup or (FutureAstralPower < 30 and not Unit("player"):HasBuffs(A.CaIncBuff.ID, true)) or A.CaInc:GetCooldown() == 0) and not Unit("player"):HasBuffs(A.KindredEmpowermentEnergizeBuff.ID, true)) then
                    return A.Moonfire:Show(icon) 
                end
            end
            -- stellar_flare,target_if=refreshable&target.time_to_die>16+remains,if=ap_check&(variable.critnotup|astral_power<30|cooldown.ca_inc.ready)
            if A.StellarFlare:IsReady(unit) then
                if (Unit(unit):HasDeBuffsRefreshable(A.StellarFlareDebuff.ID, true) and Unit(unit):TimeToDie() > 16 + Unit(unit):HasDeBuffs(A.StellarFlareDebuff.ID, true)) and (ap_check and (VarCritnotup or FutureAstralPower < 30 or A.CaInc:GetCooldown() == 0)) then
                    return A.StellarFlare:Show(icon) 
                end
            end
            -- force_of_nature,if=ap_check
            if A.ForceofNature:IsReady(unit) and (ap_check) then
                return A.ForceofNature:Show(icon)
            end
            
            -- fury_of_elune,if=(eclipse.in_any|eclipse.solar_in_1|eclipse.lunar_in_1)&(!covenant.night_fae|(astral_power<95&(variable.critnotup|astral_power<30|variable.is_aoe)&(variable.convoke_desync&!cooldown.convoke_the_spirits.up|!variable.convoke_desync&!cooldown.ca_inc.up)))&(cooldown.ca_inc.remains>30|astral_power>90&cooldown.ca_inc.up&(cooldown.empower_bond.remains<action.starfire.execute_time|!covenant.kyrian)|interpolated_fight_remains<10)&(dot.adaptive_swarm_damage.remains>4|!covenant.necrolord)
            if A.FuryofElune:IsReady(unit) and ((eclipse.in_any or eclipse.solar_in_1 or eclipse.lunar_in_1) and (not covenant.night_fae or (FutureAstralPower < 95 and (VarCritnotup or FutureAstralPower < 30 or VarIsAoe) and (VarConvokeDesync and not A.ConvoketheSpirits:GetCooldown() == 0 or not VarConvokeDesync and not A.CaInc:GetCooldown() == 0))) and (A.CaInc:GetCooldown() > 30 or FutureAstralPower > 90 and A.CaInc:GetCooldown() == 0 and (A.EmpowerBond:GetCooldown() < A.Starfire:GetSpellCastTime() or not covenant.kyrian) or interpolated_fight_remains < 10) and (Unit(unit):HasDeBuffs(A.AdaptiveSwarmDamageDebuff.ID, true) > 4 or not covenant.necrolord)) then
                return A.FuryofElune:Show(icon)
            end
            
            -- kindred_spirits,if=(eclipse.lunar_next|eclipse.solar_next|eclipse.any_next|buff.balance_of_all_things_nature.remains>4.5|buff.balance_of_all_things_arcane.remains>4.5|astral_power>90&cooldown.ca_inc.ready)&(cooldown.ca_inc.remains>30|cooldown.ca_inc.ready)|interpolated_fight_remains<10
            if A.KindredSpirits:IsReady(unit) and ((eclipse.lunar_next or eclipse.solar_next or eclipse.any_next or Unit("player"):HasBuffs(A.BalanceofAllThingsNatureBuff.ID, true) > 4.5 or Unit("player"):HasBuffs(A.BalanceofAllThingsArcaneBuff.ID, true) > 4.5 or FutureAstralPower > 90 and A.CaInc:GetCooldown() == 0) and (A.CaInc:GetCooldown() > 30 or A.CaInc:GetCooldown() == 0) or interpolated_fight_remains < 10) then
                return A.KindredSpirits:Show(icon)
            end
            
            -- celestial_alignment,if=(astral_power>90&(buff.kindred_empowerment_energize.up|!covenant.kyrian)|covenant.night_fae|buff.bloodlust.up&buff.bloodlust.remains<20+(4*conduit.precise_alignment.enabled))&(!covenant.night_fae|cooldown.convoke_the_spirits.up|interpolated_fight_remains<cooldown.convoke_the_spirits.remains+6|interpolated_fight_remains%%180<20+(4*conduit.precise_alignment.enabled))
            if A.CelestialAlignment:IsReady(unit) and ((FutureAstralPower > 90 and (Unit("player"):HasBuffs(A.KindredEmpowermentEnergizeBuff.ID, true) or not covenant.kyrian) or covenant.night_fae or Unit("player"):HasHeroism and num(Unit("player"):HasHeroism) < 20 + (4 * conduit.precise_alignment.enabled)) and (not covenant.night_fae or A.ConvoketheSpirits:GetCooldown() == 0 or interpolated_fight_remains < A.ConvoketheSpirits:GetCooldown() + 6 or interpolated_fight_remains / num(true) / 180 < 20 + (4 * conduit.precise_alignment.enabled))) then
                return A.CelestialAlignment:Show(icon)
            end
            
            -- incarnation,if=(astral_power>90&(buff.kindred_empowerment_energize.up|!covenant.kyrian)|covenant.night_fae|buff.bloodlust.up&buff.bloodlust.remains<30+(4*conduit.precise_alignment.enabled))&(!covenant.night_fae|cooldown.convoke_the_spirits.up|variable.convoke_desync&interpolated_fight_remains>180+20+(4*conduit.precise_alignment.enabled)|interpolated_fight_remains<cooldown.convoke_the_spirits.remains+6|interpolated_fight_remains<30+(4*conduit.precise_alignment.enabled))
            if A.Incarnation:IsReady(unit) and ((FutureAstralPower > 90 and (Unit("player"):HasBuffs(A.KindredEmpowermentEnergizeBuff.ID, true) or not covenant.kyrian) or covenant.night_fae or Unit("player"):HasHeroism and num(Unit("player"):HasHeroism) < 30 + (4 * conduit.precise_alignment.enabled)) and (not covenant.night_fae or A.ConvoketheSpirits:GetCooldown() == 0 or VarConvokeDesync and interpolated_fight_remains > 180 + 20 + (4 * conduit.precise_alignment.enabled) or interpolated_fight_remains < A.ConvoketheSpirits:GetCooldown() + 6 or interpolated_fight_remains < 30 + (4 * conduit.precise_alignment.enabled))) then
                return A.Incarnation:Show(icon)
            end
            
            -- convoke_the_spirits,if=(variable.convoke_desync&interpolated_fight_remains>130|buff.ca_inc.up)&(buff.balance_of_all_things_nature.stack_value>30|buff.balance_of_all_things_arcane.stack_value>30)|interpolated_fight_remains<10
            if A.ConvoketheSpirits:IsReady(unit) and ((VarConvokeDesync and interpolated_fight_remains > 130 or Unit("player"):HasBuffs(A.CaIncBuff.ID, true)) and (buff.balance_of_all_things_nature.stack_value > 30 or buff.balance_of_all_things_arcane.stack_value > 30) or interpolated_fight_remains < 10) then
                return A.ConvoketheSpirits:Show(icon)
            end
            
            -- starsurge,if=covenant.night_fae&(variable.convoke_desync|cooldown.ca_inc.remains<10)&astral_power>50&cooldown.convoke_the_spirits.remains<10
            if A.Starsurge:IsReady(unit) and (covenant.night_fae and (VarConvokeDesync or A.CaInc:GetCooldown() < 10) and FutureAstralPower > 50 and A.ConvoketheSpirits:GetCooldown() < 10) then
                return A.Starsurge:Show(icon)
            end
            
            -- variable,name=aspPerSec,value=eclipse.in_lunar*8%action.starfire.execute_time+!eclipse.in_lunar*6%action.wrath.execute_time+0.2%spell_haste
            VarAsppersec = eclipse.in_lunar * 8 / A.Starfire:GetSpellCastTime() + num(not eclipse.in_lunar) * 6 / A.Wrath:GetSpellCastTime() + 0.2 / Player:SpellHaste()
            
            -- starsurge,if=(interpolated_fight_remains<4|(buff.ravenous_frenzy.remains<gcd.max*ceil(astral_power%30)&buff.ravenous_frenzy.up))|(astral_power+variable.aspPerSec*buff.eclipse_solar.remains+dot.fury_of_elune.ticks_remain*2.5>120|astral_power+variable.aspPerSec*buff.eclipse_lunar.remains+dot.fury_of_elune.ticks_remain*2.5>120)&eclipse.in_any&((!cooldown.ca_inc.up|covenant.kyrian&!cooldown.empower_bond.up)|covenant.night_fae)&(!covenant.venthyr|!buff.ca_inc.up|astral_power>90)|buff.ca_inc.remains>8&!buff.ravenous_frenzy.up
            if A.Starsurge:IsReady(unit) and ((interpolated_fight_remains < 4 or (Unit("player"):HasBuffs(A.RavenousFrenzyBuff.ID, true) < GetGCD() * math.ceil (FutureAstralPower / 30) and Unit("player"):HasBuffs(A.RavenousFrenzyBuff.ID, true))) or (FutureAstralPower + VarAsppersec * Unit("player"):HasBuffs(A.EclipseSolarBuff.ID, true) + Unit(unit):DeBuffTicksRemainP(A.FuryofEluneDebuff.ID, true) * 2.5 > 120 or FutureAstralPower + VarAsppersec * Unit("player"):HasBuffs(A.EclipseLunarBuff.ID, true) + Unit(unit):DeBuffTicksRemainP(A.FuryofEluneDebuff.ID, true) * 2.5 > 120) and eclipse.in_any and ((not A.CaInc:GetCooldown() == 0 or covenant.kyrian and not A.EmpowerBond:GetCooldown() == 0) or covenant.night_fae) and (not covenant.venthyr or not Unit("player"):HasBuffs(A.CaIncBuff.ID, true) or FutureAstralPower > 90) or Unit("player"):HasBuffs(A.CaIncBuff.ID, true) > 8 and not Unit("player"):HasBuffs(A.RavenousFrenzyBuff.ID, true)) then
                return A.Starsurge:Show(icon)
            end
            
            -- new_moon,if=(buff.eclipse_lunar.up|(charges=2&recharge_time<5)|charges=3)&ap_check
            if A.NewMoon:IsReady(unit) and ((Unit("player"):HasBuffs(A.EclipseLunarBuff.ID, true) or (A.NewMoon:GetSpellCharges() == 2 and A.NewMoon:RechargeP() < 5) or A.NewMoon:GetSpellCharges() == 3) and ap_check) then
                return A.NewMoon:Show(icon)
            end
            
            -- half_moon,if=(buff.eclipse_lunar.up|(charges=2&recharge_time<5)|charges=3)&ap_check
            if A.HalfMoon:IsReady(unit) and ((Unit("player"):HasBuffs(A.EclipseLunarBuff.ID, true) or (A.HalfMoon:GetSpellCharges() == 2 and A.HalfMoon:RechargeP() < 5) or A.HalfMoon:GetSpellCharges() == 3) and ap_check) then
                return A.HalfMoon:Show(icon)
            end
            
            -- full_moon,if=(buff.eclipse_lunar.up|(charges=2&recharge_time<5)|charges=3)&ap_check
            if A.FullMoon:IsReady(unit) and ((Unit("player"):HasBuffs(A.EclipseLunarBuff.ID, true) or (A.FullMoon:GetSpellCharges() == 2 and A.FullMoon:RechargeP() < 5) or A.FullMoon:GetSpellCharges() == 3) and ap_check) then
                return A.FullMoon:Show(icon)
            end
            
            -- warrior_of_elune
            if A.WarriorofElune:IsReady(unit) then
                return A.WarriorofElune:Show(icon)
            end
            
            -- starfire,if=eclipse.in_lunar|eclipse.solar_next|eclipse.any_next|buff.warrior_of_elune.up&eclipse.in_lunar|(buff.ca_inc.remains<action.wrath.execute_time&buff.ca_inc.up)
            if A.Starfire:IsReady(unit) and (eclipse.in_lunar or eclipse.solar_next or eclipse.any_next or Unit("player"):HasBuffs(A.WarriorofEluneBuff.ID, true) and eclipse.in_lunar or (Unit("player"):HasBuffs(A.CaIncBuff.ID, true) < A.Wrath:GetSpellCastTime() and Unit("player"):HasBuffs(A.CaIncBuff.ID, true))) then
                return A.Starfire:Show(icon)
            end
            
            -- wrath
            if A.Wrath:IsReady(unit) then
                return A.Wrath:Show(icon)
            end
            
            -- run_action_list,name=fallthru
            return Fallthru(unit);
            
        end
        
        --Dreambinder
        local function Dreambinder(unit)
        
            -- variable,name=safe_to_use_spell,value=(buff.timeworn_dreambinder.remains>gcd.max+0.1&(eclipse.in_both|eclipse.in_solar|eclipse.lunar_next)|buff.timeworn_dreambinder.remains>action.starfire.execute_time+0.1&(eclipse.in_lunar|eclipse.solar_next|eclipse.any_next))|!buff.timeworn_dreambinder.up
            VarSafeToUseSpell = num((Unit("player"):HasBuffs(A.TimewornDreambinderBuff.ID, true) > GetGCD() + 0.1 and (eclipse.in_both or eclipse.in_solar or eclipse.lunar_next) or Unit("player"):HasBuffs(A.TimewornDreambinderBuff.ID, true) > A.Starfire:GetSpellCastTime() + 0.1 and (eclipse.in_lunar or eclipse.solar_next or eclipse.any_next)) or not Unit("player"):HasBuffs(A.TimewornDreambinderBuff.ID, true))
            
            -- starsurge,if=(!variable.safe_to_use_spell|(buff.ravenous_frenzy.remains<gcd.max*ceil(astral_power%30)&buff.ravenous_frenzy.up))|astral_power>90
            if A.Starsurge:IsReady(unit) and ((not VarSafeToUseSpell or (Unit("player"):HasBuffs(A.RavenousFrenzyBuff.ID, true) < GetGCD() * math.ceil (FutureAstralPower / 30) and Unit("player"):HasBuffs(A.RavenousFrenzyBuff.ID, true))) or FutureAstralPower > 90) then
                return A.Starsurge:Show(icon)
            end
            
            -- adaptive_swarm,target_if=!dot.adaptive_swarm_damage.ticking&!action.adaptive_swarm_damage.in_flight&(!dot.adaptive_swarm_heal.ticking|dot.adaptive_swarm_heal.remains>5)|dot.adaptive_swarm_damage.stack<3&dot.adaptive_swarm_damage.remains<3&dot.adaptive_swarm_damage.ticking
            if A.AdaptiveSwarm:IsReady(unit) then
                if not Unit(unit):HasDeBuffs(A.AdaptiveSwarmDamageDebuff.ID, true) and not A.AdaptiveSwarmDamage:IsSpellInFlight() and (not Unit(unit):HasDeBuffs(A.AdaptiveSwarmHealDebuff.ID, true) or Unit(unit):HasDeBuffs(A.AdaptiveSwarmHealDebuff.ID, true) > 5) or Unit(unit):HasDeBuffsStacks(A.AdaptiveSwarmDamageDebuff.ID, true) < 3 and Unit(unit):HasDeBuffs(A.AdaptiveSwarmDamageDebuff.ID, true) < 3 and Unit(unit):HasDeBuffs(A.AdaptiveSwarmDamageDebuff.ID, true) then
                    return A.AdaptiveSwarm:Show(icon) 
                end
            end
            -- moonfire,target_if=refreshable&target.time_to_die>12,if=(buff.ca_inc.remains>5&(buff.ravenous_frenzy.remains>5|!buff.ravenous_frenzy.up)|!buff.ca_inc.up|astral_power<30)&(!buff.kindred_empowerment_energize.up|astral_power<30)&ap_check
            if A.Moonfire:IsReady(unit) then
                if (Unit(unit):HasDeBuffsRefreshable(A.MoonfireDebuff.ID, true) and Unit(unit):TimeToDie() > 12) and ((Unit("player"):HasBuffs(A.CaIncBuff.ID, true) > 5 and (Unit("player"):HasBuffs(A.RavenousFrenzyBuff.ID, true) > 5 or not Unit("player"):HasBuffs(A.RavenousFrenzyBuff.ID, true)) or not Unit("player"):HasBuffs(A.CaIncBuff.ID, true) or FutureAstralPower < 30) and (not Unit("player"):HasBuffs(A.KindredEmpowermentEnergizeBuff.ID, true) or FutureAstralPower < 30) and ap_check) then
                    return A.Moonfire:Show(icon) 
                end
            end
            -- sunfire,target_if=refreshable&target.time_to_die>12,if=(buff.ca_inc.remains>5&(buff.ravenous_frenzy.remains>5|!buff.ravenous_frenzy.up)|!buff.ca_inc.up|astral_power<30)&(!buff.kindred_empowerment_energize.up|astral_power<30)&ap_check
            if A.Sunfire:IsReady(unit) then
                if (Unit(unit):HasDeBuffsRefreshable(A.SunfireDebuff.ID, true) and Unit(unit):TimeToDie() > 12) and ((Unit("player"):HasBuffs(A.CaIncBuff.ID, true) > 5 and (Unit("player"):HasBuffs(A.RavenousFrenzyBuff.ID, true) > 5 or not Unit("player"):HasBuffs(A.RavenousFrenzyBuff.ID, true)) or not Unit("player"):HasBuffs(A.CaIncBuff.ID, true) or FutureAstralPower < 30) and (not Unit("player"):HasBuffs(A.KindredEmpowermentEnergizeBuff.ID, true) or FutureAstralPower < 30) and ap_check) then
                    return A.Sunfire:Show(icon) 
                end
            end
            -- stellar_flare,target_if=refreshable&target.time_to_die>16,if=(buff.ca_inc.remains>5&(buff.ravenous_frenzy.remains>5|!buff.ravenous_frenzy.up)|!buff.ca_inc.up|astral_power<30)&(!buff.kindred_empowerment_energize.up|astral_power<30)&ap_check
            if A.StellarFlare:IsReady(unit) then
                if (Unit(unit):HasDeBuffsRefreshable(A.StellarFlareDebuff.ID, true) and Unit(unit):TimeToDie() > 16) and ((Unit("player"):HasBuffs(A.CaIncBuff.ID, true) > 5 and (Unit("player"):HasBuffs(A.RavenousFrenzyBuff.ID, true) > 5 or not Unit("player"):HasBuffs(A.RavenousFrenzyBuff.ID, true)) or not Unit("player"):HasBuffs(A.CaIncBuff.ID, true) or FutureAstralPower < 30) and (not Unit("player"):HasBuffs(A.KindredEmpowermentEnergizeBuff.ID, true) or FutureAstralPower < 30) and ap_check) then
                    return A.StellarFlare:Show(icon) 
                end
            end
            -- force_of_nature,if=ap_check
            if A.ForceofNature:IsReady(unit) and (ap_check) then
                return A.ForceofNature:Show(icon)
            end
            
            -- ravenous_frenzy,if=buff.ca_inc.up
            if A.RavenousFrenzy:IsReady(unit) and (Unit("player"):HasBuffs(A.CaIncBuff.ID, true)) then
                return A.RavenousFrenzy:Show(icon)
            end
            
            -- kindred_spirits,if=((buff.eclipse_solar.remains>10|buff.eclipse_lunar.remains>10)&cooldown.ca_inc.remains>30)|cooldown.ca_inc.ready
            if A.KindredSpirits:IsReady(unit) and (((Unit("player"):HasBuffs(A.EclipseSolarBuff.ID, true) > 10 or Unit("player"):HasBuffs(A.EclipseLunarBuff.ID, true) > 10) and A.CaInc:GetCooldown() > 30) or A.CaInc:GetCooldown() == 0) then
                return A.KindredSpirits:Show(icon)
            end
            
            -- celestial_alignment,if=(buff.kindred_empowerment_energize.up|!covenant.kyrian)|covenant.night_fae|variable.is_aoe|buff.bloodlust.up&buff.bloodlust.remains<20+(4*conduit.precise_alignment.enabled)&!buff.ca_inc.up&(interpolated_fight_remains<cooldown.convoke_the_spirits.remains+7|interpolated_fight_remains<22|interpolated_fight_remains%%180<22|cooldown.convoke_the_spirits.up|!covenant.night_fae)
            if A.CelestialAlignment:IsReady(unit) and ((Unit("player"):HasBuffs(A.KindredEmpowermentEnergizeBuff.ID, true) or not covenant.kyrian) or covenant.night_fae or VarIsAoe or Unit("player"):HasHeroism and num(Unit("player"):HasHeroism) < 20 + (4 * conduit.precise_alignment.enabled) and not Unit("player"):HasBuffs(A.CaIncBuff.ID, true) and (interpolated_fight_remains < A.ConvoketheSpirits:GetCooldown() + 7 or interpolated_fight_remains < 22 or interpolated_fight_remains / num(true) / 180 < 22 or A.ConvoketheSpirits:GetCooldown() == 0 or not covenant.night_fae)) then
                return A.CelestialAlignment:Show(icon)
            end
            
            -- incarnation,if=(buff.kindred_empowerment_energize.up|!covenant.kyrian)|covenant.night_fae|variable.is_aoe|buff.bloodlust.up&buff.bloodlust.remains<30+(4*conduit.precise_alignment.enabled)&!buff.ca_inc.up&(interpolated_fight_remains<cooldown.convoke_the_spirits.remains+7|interpolated_fight_remains<32|interpolated_fight_remains%%180<32|cooldown.convoke_the_spirits.up|!covenant.night_fae)
            if A.Incarnation:IsReady(unit) and ((Unit("player"):HasBuffs(A.KindredEmpowermentEnergizeBuff.ID, true) or not covenant.kyrian) or covenant.night_fae or VarIsAoe or Unit("player"):HasHeroism and num(Unit("player"):HasHeroism) < 30 + (4 * conduit.precise_alignment.enabled) and not Unit("player"):HasBuffs(A.CaIncBuff.ID, true) and (interpolated_fight_remains < A.ConvoketheSpirits:GetCooldown() + 7 or interpolated_fight_remains < 32 or interpolated_fight_remains / num(true) / 180 < 32 or A.ConvoketheSpirits:GetCooldown() == 0 or not covenant.night_fae)) then
                return A.Incarnation:Show(icon)
            end
            
            -- variable,name=convoke_condition,value=covenant.night_fae&(buff.primordial_arcanic_pulsar.value<240&(cooldown.ca_inc.remains+10>interpolated_fight_remains|cooldown.ca_inc.remains+30<interpolated_fight_remains&interpolated_fight_remains>130|buff.ca_inc.remains>7)&buff.eclipse_solar.remains>10|interpolated_fight_remains%%120<15)
            VarConvokeCondition = num(covenant.night_fae and (buff.primordial_arcanic_pulsar.value < 240 and (A.CaInc:GetCooldown() + 10 > interpolated_fight_remains or A.CaInc:GetCooldown() + 30 < interpolated_fight_remains and interpolated_fight_remains > 130 or Unit("player"):HasBuffs(A.CaIncBuff.ID, true) > 7) and Unit("player"):HasBuffs(A.EclipseSolarBuff.ID, true) > 10 or interpolated_fight_remains / num(true) / 120 < 15))
            
            -- variable,name=save_for_ca_inc,value=(!cooldown.ca_inc.ready|!variable.convoke_condition&covenant.night_fae)
            VarSaveForCaInc = num((not A.CaInc:GetCooldown() == 0 or not VarConvokeCondition and covenant.night_fae))
            
            -- convoke_the_spirits,if=variable.convoke_condition&astral_power<40
            if A.ConvoketheSpirits:IsReady(unit) and (VarConvokeCondition and FutureAstralPower < 40) then
                return A.ConvoketheSpirits:Show(icon)
            end
            
            -- fury_of_elune,if=eclipse.in_any&ap_check&(dot.adaptive_swarm_damage.ticking|!covenant.necrolord)&variable.save_for_ca_inc
            if A.FuryofElune:IsReady(unit) and (eclipse.in_any and ap_check and (Unit(unit):HasDeBuffs(A.AdaptiveSwarmDamageDebuff.ID, true) or not covenant.necrolord) and VarSaveForCaInc) then
                return A.FuryofElune:Show(icon)
            end
            
            -- starsurge,if=covenant.night_fae&variable.convoke_condition&astral_power>=40&cooldown.convoke_the_spirits.remains<gcd.max*ceil(astral_power%30)
            if A.Starsurge:IsReady(unit) and (covenant.night_fae and VarConvokeCondition and FutureAstralPower >= 40 and A.ConvoketheSpirits:GetCooldown() < GetGCD() * math.ceil (FutureAstralPower / 30)) then
                return A.Starsurge:Show(icon)
            end
            
            -- new_moon,if=(buff.eclipse_lunar.up|(charges=2&recharge_time<5)|charges=3)&ap_check&variable.save_for_ca_inc
            if A.NewMoon:IsReady(unit) and ((Unit("player"):HasBuffs(A.EclipseLunarBuff.ID, true) or (A.NewMoon:GetSpellCharges() == 2 and A.NewMoon:RechargeP() < 5) or A.NewMoon:GetSpellCharges() == 3) and ap_check and VarSaveForCaInc) then
                return A.NewMoon:Show(icon)
            end
            
            -- half_moon,if=(buff.eclipse_lunar.up&!covenant.kyrian|(buff.kindred_empowerment_energize.up&covenant.kyrian)|(charges=2&recharge_time<5)|charges=3|buff.ca_inc.up)&ap_check&variable.save_for_ca_inc
            if A.HalfMoon:IsReady(unit) and ((Unit("player"):HasBuffs(A.EclipseLunarBuff.ID, true) and not covenant.kyrian or (Unit("player"):HasBuffs(A.KindredEmpowermentEnergizeBuff.ID, true) and covenant.kyrian) or (A.HalfMoon:GetSpellCharges() == 2 and A.HalfMoon:RechargeP() < 5) or A.HalfMoon:GetSpellCharges() == 3 or Unit("player"):HasBuffs(A.CaIncBuff.ID, true)) and ap_check and VarSaveForCaInc) then
                return A.HalfMoon:Show(icon)
            end
            
            -- full_moon,if=(buff.eclipse_lunar.up&!covenant.kyrian|(buff.kindred_empowerment_energize.up&covenant.kyrian)|(charges=2&recharge_time<5)|charges=3|buff.ca_inc.up)&ap_check&variable.save_for_ca_inc
            if A.FullMoon:IsReady(unit) and ((Unit("player"):HasBuffs(A.EclipseLunarBuff.ID, true) and not covenant.kyrian or (Unit("player"):HasBuffs(A.KindredEmpowermentEnergizeBuff.ID, true) and covenant.kyrian) or (A.FullMoon:GetSpellCharges() == 2 and A.FullMoon:RechargeP() < 5) or A.FullMoon:GetSpellCharges() == 3 or Unit("player"):HasBuffs(A.CaIncBuff.ID, true)) and ap_check and VarSaveForCaInc) then
                return A.FullMoon:Show(icon)
            end
            
            -- warrior_of_elune
            if A.WarriorofElune:IsReady(unit) then
                return A.WarriorofElune:Show(icon)
            end
            
            -- starfire,if=eclipse.in_lunar|eclipse.solar_next|eclipse.any_next|buff.warrior_of_elune.up&buff.eclipse_lunar.up|(buff.ca_inc.remains<action.wrath.execute_time&buff.ca_inc.up)
            if A.Starfire:IsReady(unit) and (eclipse.in_lunar or eclipse.solar_next or eclipse.any_next or Unit("player"):HasBuffs(A.WarriorofEluneBuff.ID, true) and Unit("player"):HasBuffs(A.EclipseLunarBuff.ID, true) or (Unit("player"):HasBuffs(A.CaIncBuff.ID, true) < A.Wrath:GetSpellCastTime() and Unit("player"):HasBuffs(A.CaIncBuff.ID, true))) then
                return A.Starfire:Show(icon)
            end
            
            -- wrath
            if A.Wrath:IsReady(unit) then
                return A.Wrath:Show(icon)
            end
            
            -- run_action_list,name=fallthru
            return Fallthru(unit);
            
        end
        
        --Fallthru
        local function Fallthru(unit)
        
            -- starsurge,if=!runeforge.balance_of_all_things.equipped
            if A.Starsurge:IsReady(unit) and (not runeforge.balance_of_all_things.equipped) then
                return A.Starsurge:Show(icon)
            end
            
            -- sunfire,target_if=dot.moonfire.remains>remains
            if A.Sunfire:IsReady(unit) then
                if Unit(unit):HasDeBuffs(A.MoonfireDebuff.ID, true) > Unit(unit):HasDeBuffs(A.SunfireDebuff.ID, true) then
                    return A.Sunfire:Show(icon) 
                end
            end
            -- moonfire
            if A.Moonfire:IsReady(unit) then
                return A.Moonfire:Show(icon)
            end
            
        end
        
        --PrepatchSt
        local function PrepatchSt(unit)
        
            -- moonfire,target_if=refreshable&target.time_to_die>12,if=(buff.ca_inc.remains>5|!buff.ca_inc.up|astral_power<30)&ap_check
            if A.Moonfire:IsReady(unit) then
                if (Unit(unit):HasDeBuffsRefreshable(A.MoonfireDebuff.ID, true) and Unit(unit):TimeToDie() > 12) and ((Unit("player"):HasBuffs(A.CaIncBuff.ID, true) > 5 or not Unit("player"):HasBuffs(A.CaIncBuff.ID, true) or FutureAstralPower < 30) and ap_check) then
                    return A.Moonfire:Show(icon) 
                end
            end
            -- sunfire,target_if=refreshable&target.time_to_die>12,if=(buff.ca_inc.remains>5|!buff.ca_inc.up|astral_power<30)&ap_check
            if A.Sunfire:IsReady(unit) then
                if (Unit(unit):HasDeBuffsRefreshable(A.SunfireDebuff.ID, true) and Unit(unit):TimeToDie() > 12) and ((Unit("player"):HasBuffs(A.CaIncBuff.ID, true) > 5 or not Unit("player"):HasBuffs(A.CaIncBuff.ID, true) or FutureAstralPower < 30) and ap_check) then
                    return A.Sunfire:Show(icon) 
                end
            end
            -- stellar_flare,target_if=refreshable&target.time_to_die>16,if=(buff.ca_inc.remains>5|!buff.ca_inc.up|astral_power<30)&ap_check
            if A.StellarFlare:IsReady(unit) then
                if (Unit(unit):HasDeBuffsRefreshable(A.StellarFlareDebuff.ID, true) and Unit(unit):TimeToDie() > 16) and ((Unit("player"):HasBuffs(A.CaIncBuff.ID, true) > 5 or not Unit("player"):HasBuffs(A.CaIncBuff.ID, true) or FutureAstralPower < 30) and ap_check) then
                    return A.StellarFlare:Show(icon) 
                end
            end
            -- force_of_nature,if=ap_check
            if A.ForceofNature:IsReady(unit) and (ap_check) then
                return A.ForceofNature:Show(icon)
            end
            
            -- celestial_alignment,if=(astral_power>90|buff.bloodlust.up&buff.bloodlust.remains<26)&!buff.ca_inc.up
            if A.CelestialAlignment:IsReady(unit) and ((FutureAstralPower > 90 or Unit("player"):HasHeroism and num(Unit("player"):HasHeroism) < 26) and not Unit("player"):HasBuffs(A.CaIncBuff.ID, true)) then
                return A.CelestialAlignment:Show(icon)
            end
            
            -- incarnation,if=(astral_power>90|buff.bloodlust.up&buff.bloodlust.remains<36)&!buff.ca_inc.up
            if A.Incarnation:IsReady(unit) and ((FutureAstralPower > 90 or Unit("player"):HasHeroism and num(Unit("player"):HasHeroism) < 36) and not Unit("player"):HasBuffs(A.CaIncBuff.ID, true)) then
                return A.Incarnation:Show(icon)
            end
            
            -- variable,name=save_for_ca_inc,value=!cooldown.ca_inc.ready
            VarSaveForCaInc = num(not A.CaInc:GetCooldown() == 0)
            
            -- fury_of_elune,if=eclipse.in_any&ap_check&variable.save_for_ca_inc
            if A.FuryofElune:IsReady(unit) and (eclipse.in_any and ap_check and VarSaveForCaInc) then
                return A.FuryofElune:Show(icon)
            end
            
            -- cancel_buff,name=starlord,if=buff.starlord.remains<6&(buff.eclipse_solar.up|buff.eclipse_lunar.up)&astral_power>90
            if (Unit("player"):HasBuffs(A.StarlordBuff.ID, true) < 6 and (Unit("player"):HasBuffs(A.EclipseSolarBuff.ID, true) or Unit("player"):HasBuffs(A.EclipseLunarBuff.ID, true)) and FutureAstralPower > 90) then
                Player:CancelBuff(A.StarlordBuff:Info())
            end
            
            -- starsurge,if=(!azerite.streaking_stars.rank|buff.ca_inc.remains<execute_time|!variable.prev_starsurge)&(buff.ca_inc.up|astral_power>90&eclipse.in_any)
            if A.Starsurge:IsReady(unit) and ((not A.StreakingStars:GetAzeriteRank() or Unit("player"):HasBuffs(A.CaIncBuff.ID, true) < A.Starsurge:GetSpellCastTime() or not VarPrevStarsurge) and (Unit("player"):HasBuffs(A.CaIncBuff.ID, true) or FutureAstralPower > 90 and eclipse.in_any)) then
                return A.Starsurge:Show(icon)
            end
            
            -- starsurge,if=(!azerite.streaking_stars.rank|buff.ca_inc.remains<execute_time|!variable.prev_starsurge)&talent.starlord.enabled&(buff.starlord.up|astral_power>90)&buff.starlord.stack<3&(buff.eclipse_solar.up|buff.eclipse_lunar.up)&cooldown.ca_inc.remains>7
            if A.Starsurge:IsReady(unit) and ((not A.StreakingStars:GetAzeriteRank() or Unit("player"):HasBuffs(A.CaIncBuff.ID, true) < A.Starsurge:GetSpellCastTime() or not VarPrevStarsurge) and A.Starlord:IsSpellLearned() and (Unit("player"):HasBuffs(A.StarlordBuff.ID, true) or FutureAstralPower > 90) and Unit("player"):HasBuffsStacks(A.StarlordBuff.ID, true) < 3 and (Unit("player"):HasBuffs(A.EclipseSolarBuff.ID, true) or Unit("player"):HasBuffs(A.EclipseLunarBuff.ID, true)) and A.CaInc:GetCooldown() > 7) then
                return A.Starsurge:Show(icon)
            end
            
            -- starsurge,if=(!azerite.streaking_stars.rank|buff.ca_inc.remains<execute_time|!variable.prev_starsurge)&buff.eclipse_solar.remains>7&eclipse.in_solar&!talent.starlord.enabled&cooldown.ca_inc.remains>7
            if A.Starsurge:IsReady(unit) and ((not A.StreakingStars:GetAzeriteRank() or Unit("player"):HasBuffs(A.CaIncBuff.ID, true) < A.Starsurge:GetSpellCastTime() or not VarPrevStarsurge) and Unit("player"):HasBuffs(A.EclipseSolarBuff.ID, true) > 7 and eclipse.in_solar and not A.Starlord:IsSpellLearned() and A.CaInc:GetCooldown() > 7) then
                return A.Starsurge:Show(icon)
            end
            
            -- new_moon,if=(buff.eclipse_lunar.up|(charges=2&recharge_time<5)|charges=3)&ap_check&variable.save_for_ca_inc
            if A.NewMoon:IsReady(unit) and ((Unit("player"):HasBuffs(A.EclipseLunarBuff.ID, true) or (A.NewMoon:GetSpellCharges() == 2 and A.NewMoon:RechargeP() < 5) or A.NewMoon:GetSpellCharges() == 3) and ap_check and VarSaveForCaInc) then
                return A.NewMoon:Show(icon)
            end
            
            -- half_moon,if=(buff.eclipse_lunar.up|(charges=2&recharge_time<5)|charges=3|buff.ca_inc.up)&ap_check&variable.save_for_ca_inc
            if A.HalfMoon:IsReady(unit) and ((Unit("player"):HasBuffs(A.EclipseLunarBuff.ID, true) or (A.HalfMoon:GetSpellCharges() == 2 and A.HalfMoon:RechargeP() < 5) or A.HalfMoon:GetSpellCharges() == 3 or Unit("player"):HasBuffs(A.CaIncBuff.ID, true)) and ap_check and VarSaveForCaInc) then
                return A.HalfMoon:Show(icon)
            end
            
            -- full_moon,if=(buff.eclipse_lunar.up|(charges=2&recharge_time<5)|charges=3|buff.ca_inc.up)&ap_check&variable.save_for_ca_inc
            if A.FullMoon:IsReady(unit) and ((Unit("player"):HasBuffs(A.EclipseLunarBuff.ID, true) or (A.FullMoon:GetSpellCharges() == 2 and A.FullMoon:RechargeP() < 5) or A.FullMoon:GetSpellCharges() == 3 or Unit("player"):HasBuffs(A.CaIncBuff.ID, true)) and ap_check and VarSaveForCaInc) then
                return A.FullMoon:Show(icon)
            end
            
            -- warrior_of_elune
            if A.WarriorofElune:IsReady(unit) then
                return A.WarriorofElune:Show(icon)
            end
            
            -- starfire,if=(azerite.streaking_stars.rank&buff.ca_inc.remains>execute_time&variable.prev_wrath)|(!azerite.streaking_stars.rank|buff.ca_inc.remains<execute_time|!variable.prev_starfire)&(eclipse.in_lunar|eclipse.solar_next|eclipse.any_next|buff.warrior_of_elune.up&buff.eclipse_lunar.up|(buff.ca_inc.remains<action.wrath.execute_time&buff.ca_inc.up))|(azerite.dawning_sun.rank>2&buff.eclipse_solar.remains>5&!buff.dawning_sun.remains>action.wrath.execute_time)
            if A.Starfire:IsReady(unit) and ((A.StreakingStars:GetAzeriteRank() and Unit("player"):HasBuffs(A.CaIncBuff.ID, true) > A.Starfire:GetSpellCastTime() and VarPrevWrath) or (not A.StreakingStars:GetAzeriteRank() or Unit("player"):HasBuffs(A.CaIncBuff.ID, true) < A.Starfire:GetSpellCastTime() or not VarPrevStarfire) and (eclipse.in_lunar or eclipse.solar_next or eclipse.any_next or Unit("player"):HasBuffs(A.WarriorofEluneBuff.ID, true) and Unit("player"):HasBuffs(A.EclipseLunarBuff.ID, true) or (Unit("player"):HasBuffs(A.CaIncBuff.ID, true) < A.Wrath:GetSpellCastTime() and Unit("player"):HasBuffs(A.CaIncBuff.ID, true))) or (A.DawningSun:GetAzeriteRank() > 2 and Unit("player"):HasBuffs(A.EclipseSolarBuff.ID, true) > 5 and num(not Unit("player"):HasBuffs(A.DawningSunBuff.ID, true)) > A.Wrath:GetSpellCastTime())) then
                return A.Starfire:Show(icon)
            end
            
            -- wrath
            if A.Wrath:IsReady(unit) then
                return A.Wrath:Show(icon)
            end
            
            -- run_action_list,name=fallthru
            return Fallthru(unit);
            
        end
        
        --St
        local function St(unit)
        
            -- adaptive_swarm,target_if=!dot.adaptive_swarm_damage.ticking&!action.adaptive_swarm_damage.in_flight&(!dot.adaptive_swarm_heal.ticking|dot.adaptive_swarm_heal.remains>5)|dot.adaptive_swarm_damage.stack<3&dot.adaptive_swarm_damage.remains<3&dot.adaptive_swarm_damage.ticking
            if A.AdaptiveSwarm:IsReady(unit) then
                if not Unit(unit):HasDeBuffs(A.AdaptiveSwarmDamageDebuff.ID, true) and not A.AdaptiveSwarmDamage:IsSpellInFlight() and (not Unit(unit):HasDeBuffs(A.AdaptiveSwarmHealDebuff.ID, true) or Unit(unit):HasDeBuffs(A.AdaptiveSwarmHealDebuff.ID, true) > 5) or Unit(unit):HasDeBuffsStacks(A.AdaptiveSwarmDamageDebuff.ID, true) < 3 and Unit(unit):HasDeBuffs(A.AdaptiveSwarmDamageDebuff.ID, true) < 3 and Unit(unit):HasDeBuffs(A.AdaptiveSwarmDamageDebuff.ID, true) then
                    return A.AdaptiveSwarm:Show(icon) 
                end
            end
            -- moonfire,target_if=refreshable&target.time_to_die>12,if=(buff.ca_inc.remains>5&(buff.ravenous_frenzy.remains>5|!buff.ravenous_frenzy.up)|!buff.ca_inc.up|astral_power<30)&(!buff.kindred_empowerment_energize.up|astral_power<30)&ap_check
            if A.Moonfire:IsReady(unit) then
                if (Unit(unit):HasDeBuffsRefreshable(A.MoonfireDebuff.ID, true) and Unit(unit):TimeToDie() > 12) and ((Unit("player"):HasBuffs(A.CaIncBuff.ID, true) > 5 and (Unit("player"):HasBuffs(A.RavenousFrenzyBuff.ID, true) > 5 or not Unit("player"):HasBuffs(A.RavenousFrenzyBuff.ID, true)) or not Unit("player"):HasBuffs(A.CaIncBuff.ID, true) or FutureAstralPower < 30) and (not Unit("player"):HasBuffs(A.KindredEmpowermentEnergizeBuff.ID, true) or FutureAstralPower < 30) and ap_check) then
                    return A.Moonfire:Show(icon) 
                end
            end
            -- sunfire,target_if=refreshable&target.time_to_die>12,if=(buff.ca_inc.remains>5&(buff.ravenous_frenzy.remains>5|!buff.ravenous_frenzy.up)|!buff.ca_inc.up|astral_power<30)&(!buff.kindred_empowerment_energize.up|astral_power<30)&ap_check
            if A.Sunfire:IsReady(unit) then
                if (Unit(unit):HasDeBuffsRefreshable(A.SunfireDebuff.ID, true) and Unit(unit):TimeToDie() > 12) and ((Unit("player"):HasBuffs(A.CaIncBuff.ID, true) > 5 and (Unit("player"):HasBuffs(A.RavenousFrenzyBuff.ID, true) > 5 or not Unit("player"):HasBuffs(A.RavenousFrenzyBuff.ID, true)) or not Unit("player"):HasBuffs(A.CaIncBuff.ID, true) or FutureAstralPower < 30) and (not Unit("player"):HasBuffs(A.KindredEmpowermentEnergizeBuff.ID, true) or FutureAstralPower < 30) and ap_check) then
                    return A.Sunfire:Show(icon) 
                end
            end
            -- stellar_flare,target_if=refreshable&target.time_to_die>16,if=(buff.ca_inc.remains>5&(buff.ravenous_frenzy.remains>5|!buff.ravenous_frenzy.up)|!buff.ca_inc.up|astral_power<30)&(!buff.kindred_empowerment_energize.up|astral_power<30)&ap_check
            if A.StellarFlare:IsReady(unit) then
                if (Unit(unit):HasDeBuffsRefreshable(A.StellarFlareDebuff.ID, true) and Unit(unit):TimeToDie() > 16) and ((Unit("player"):HasBuffs(A.CaIncBuff.ID, true) > 5 and (Unit("player"):HasBuffs(A.RavenousFrenzyBuff.ID, true) > 5 or not Unit("player"):HasBuffs(A.RavenousFrenzyBuff.ID, true)) or not Unit("player"):HasBuffs(A.CaIncBuff.ID, true) or FutureAstralPower < 30) and (not Unit("player"):HasBuffs(A.KindredEmpowermentEnergizeBuff.ID, true) or FutureAstralPower < 30) and ap_check) then
                    return A.StellarFlare:Show(icon) 
                end
            end
            -- force_of_nature,if=ap_check
            if A.ForceofNature:IsReady(unit) and (ap_check) then
                return A.ForceofNature:Show(icon)
            end
            
            -- ravenous_frenzy,if=buff.ca_inc.up
            if A.RavenousFrenzy:IsReady(unit) and (Unit("player"):HasBuffs(A.CaIncBuff.ID, true)) then
                return A.RavenousFrenzy:Show(icon)
            end
            
            -- kindred_spirits,if=((buff.eclipse_solar.remains>10|buff.eclipse_lunar.remains>10)&cooldown.ca_inc.remains>30&(buff.primordial_arcanic_pulsar.value<240|!runeforge.primordial_arcanic_pulsar.equipped))|buff.primordial_arcanic_pulsar.value>=270|cooldown.ca_inc.ready&(astral_power>90|variable.is_aoe)
            if A.KindredSpirits:IsReady(unit) and (((Unit("player"):HasBuffs(A.EclipseSolarBuff.ID, true) > 10 or Unit("player"):HasBuffs(A.EclipseLunarBuff.ID, true) > 10) and A.CaInc:GetCooldown() > 30 and (buff.primordial_arcanic_pulsar.value < 240 or not runeforge.primordial_arcanic_pulsar.equipped)) or buff.primordial_arcanic_pulsar.value >= 270 or A.CaInc:GetCooldown() == 0 and (FutureAstralPower > 90 or VarIsAoe)) then
                return A.KindredSpirits:Show(icon)
            end
            
            -- celestial_alignment,if=(astral_power>90&(buff.kindred_empowerment_energize.up|!covenant.kyrian)|covenant.night_fae|variable.is_aoe|buff.bloodlust.up&buff.bloodlust.remains<20+((9*runeforge.primordial_arcanic_pulsar.equipped)+(4*conduit.precise_alignment.enabled)))&!buff.ca_inc.up&(interpolated_fight_remains<cooldown.convoke_the_spirits.remains+7|interpolated_fight_remains<22+(9*(buff.primordial_arcanic_pulsar.value>100))|interpolated_fight_remains%%180<22|cooldown.convoke_the_spirits.up|!covenant.night_fae)
            if A.CelestialAlignment:IsReady(unit) and ((FutureAstralPower > 90 and (Unit("player"):HasBuffs(A.KindredEmpowermentEnergizeBuff.ID, true) or not covenant.kyrian) or covenant.night_fae or VarIsAoe or Unit("player"):HasHeroism and num(Unit("player"):HasHeroism) < 20 + ((9 * runeforge.primordial_arcanic_pulsar.equipped) + (4 * conduit.precise_alignment.enabled))) and not Unit("player"):HasBuffs(A.CaIncBuff.ID, true) and (interpolated_fight_remains < A.ConvoketheSpirits:GetCooldown() + 7 or interpolated_fight_remains < 22 + (9 * num((buff.primordial_arcanic_pulsar.value > 100))) or interpolated_fight_remains / num(true) / 180 < 22 or A.ConvoketheSpirits:GetCooldown() == 0 or not covenant.night_fae)) then
                return A.CelestialAlignment:Show(icon)
            end
            
            -- incarnation,if=(astral_power>90&(buff.kindred_empowerment_energize.up|!covenant.kyrian)|covenant.night_fae|variable.is_aoe|buff.bloodlust.up&buff.bloodlust.remains<30+((9*runeforge.primordial_arcanic_pulsar.equipped)+(4*conduit.precise_alignment.enabled)))&!buff.ca_inc.up&(interpolated_fight_remains<cooldown.convoke_the_spirits.remains+7|interpolated_fight_remains<32+(9*(buff.primordial_arcanic_pulsar.value>100))|interpolated_fight_remains%%180<32|cooldown.convoke_the_spirits.up|!covenant.night_fae)
            if A.Incarnation:IsReady(unit) and ((FutureAstralPower > 90 and (Unit("player"):HasBuffs(A.KindredEmpowermentEnergizeBuff.ID, true) or not covenant.kyrian) or covenant.night_fae or VarIsAoe or Unit("player"):HasHeroism and num(Unit("player"):HasHeroism) < 30 + ((9 * runeforge.primordial_arcanic_pulsar.equipped) + (4 * conduit.precise_alignment.enabled))) and not Unit("player"):HasBuffs(A.CaIncBuff.ID, true) and (interpolated_fight_remains < A.ConvoketheSpirits:GetCooldown() + 7 or interpolated_fight_remains < 32 + (9 * num((buff.primordial_arcanic_pulsar.value > 100))) or interpolated_fight_remains / num(true) / 180 < 32 or A.ConvoketheSpirits:GetCooldown() == 0 or not covenant.night_fae)) then
                return A.Incarnation:Show(icon)
            end
            
            -- variable,name=convoke_condition,value=covenant.night_fae&(buff.primordial_arcanic_pulsar.value<240&(cooldown.ca_inc.remains+10>interpolated_fight_remains|cooldown.ca_inc.remains+30<interpolated_fight_remains&interpolated_fight_remains>130|buff.ca_inc.remains>7)&buff.eclipse_solar.remains>10|interpolated_fight_remains%%120<15)
            VarConvokeCondition = num(covenant.night_fae and (buff.primordial_arcanic_pulsar.value < 240 and (A.CaInc:GetCooldown() + 10 > interpolated_fight_remains or A.CaInc:GetCooldown() + 30 < interpolated_fight_remains and interpolated_fight_remains > 130 or Unit("player"):HasBuffs(A.CaIncBuff.ID, true) > 7) and Unit("player"):HasBuffs(A.EclipseSolarBuff.ID, true) > 10 or interpolated_fight_remains / num(true) / 120 < 15))
            
            -- variable,name=save_for_ca_inc,value=(!cooldown.ca_inc.ready|!variable.convoke_condition&covenant.night_fae)
            VarSaveForCaInc = num((not A.CaInc:GetCooldown() == 0 or not VarConvokeCondition and covenant.night_fae))
            
            -- convoke_the_spirits,if=variable.convoke_condition&astral_power<30
            if A.ConvoketheSpirits:IsReady(unit) and (VarConvokeCondition and FutureAstralPower < 30) then
                return A.ConvoketheSpirits:Show(icon)
            end
            
            -- fury_of_elune,if=eclipse.in_any&ap_check&buff.primordial_arcanic_pulsar.value<240&(dot.adaptive_swarm_damage.ticking|!covenant.necrolord)&variable.save_for_ca_inc
            if A.FuryofElune:IsReady(unit) and (eclipse.in_any and ap_check and buff.primordial_arcanic_pulsar.value < 240 and (Unit(unit):HasDeBuffs(A.AdaptiveSwarmDamageDebuff.ID, true) or not covenant.necrolord) and VarSaveForCaInc) then
                return A.FuryofElune:Show(icon)
            end
            
            -- starfall,if=buff.oneths_perception.up&buff.starfall.refreshable
            if A.Starfall:IsReady(unit) and (Unit("player"):HasBuffs(A.OnethsPerceptionBuff.ID, true) and Unit("player"):HasBuffsRefreshable(A.StarfallBuff.ID, true)) then
                return A.Starfall:Show(icon)
            end
            
            -- cancel_buff,name=starlord,if=buff.starlord.remains<5&(buff.eclipse_solar.remains>5|buff.eclipse_lunar.remains>5)&astral_power>90
            if (Unit("player"):HasBuffs(A.StarlordBuff.ID, true) < 5 and (Unit("player"):HasBuffs(A.EclipseSolarBuff.ID, true) > 5 or Unit("player"):HasBuffs(A.EclipseLunarBuff.ID, true) > 5) and FutureAstralPower > 90) then
                Player:CancelBuff(A.StarlordBuff:Info())
            end
            
            -- starsurge,if=covenant.night_fae&variable.convoke_condition&cooldown.convoke_the_spirits.remains<gcd.max*ceil(astral_power%30)
            if A.Starsurge:IsReady(unit) and (covenant.night_fae and VarConvokeCondition and A.ConvoketheSpirits:GetCooldown() < GetGCD() * math.ceil (FutureAstralPower / 30)) then
                return A.Starsurge:Show(icon)
            end
            
            -- starfall,if=talent.stellar_drift.enabled&!talent.starlord.enabled&buff.starfall.refreshable&(buff.eclipse_lunar.remains>6&eclipse.in_lunar&buff.primordial_arcanic_pulsar.value<250|buff.primordial_arcanic_pulsar.value>=250&astral_power>90|dot.adaptive_swarm_damage.remains>8|action.adaptive_swarm_damage.in_flight)&!cooldown.ca_inc.ready
            if A.Starfall:IsReady(unit) and (A.StellarDrift:IsSpellLearned() and not A.Starlord:IsSpellLearned() and Unit("player"):HasBuffsRefreshable(A.StarfallBuff.ID, true) and (Unit("player"):HasBuffs(A.EclipseLunarBuff.ID, true) > 6 and eclipse.in_lunar and buff.primordial_arcanic_pulsar.value < 250 or buff.primordial_arcanic_pulsar.value >= 250 and FutureAstralPower > 90 or Unit(unit):HasDeBuffs(A.AdaptiveSwarmDamageDebuff.ID, true) > 8 or A.AdaptiveSwarmDamage:IsSpellInFlight()) and not A.CaInc:GetCooldown() == 0) then
                return A.Starfall:Show(icon)
            end
            
            -- starsurge,if=buff.oneths_clear_vision.up|buff.kindred_empowerment_energize.up|buff.ca_inc.up&(buff.ravenous_frenzy.remains<gcd.max*ceil(astral_power%30)&buff.ravenous_frenzy.up|!buff.ravenous_frenzy.up&!cooldown.ravenous_frenzy.ready|!covenant.venthyr)|astral_power>90&eclipse.in_any
            if A.Starsurge:IsReady(unit) and (Unit("player"):HasBuffs(A.OnethsClearVisionBuff.ID, true) or Unit("player"):HasBuffs(A.KindredEmpowermentEnergizeBuff.ID, true) or Unit("player"):HasBuffs(A.CaIncBuff.ID, true) and (Unit("player"):HasBuffs(A.RavenousFrenzyBuff.ID, true) < GetGCD() * math.ceil (FutureAstralPower / 30) and Unit("player"):HasBuffs(A.RavenousFrenzyBuff.ID, true) or not Unit("player"):HasBuffs(A.RavenousFrenzyBuff.ID, true) and not A.RavenousFrenzy:GetCooldown() == 0 or not covenant.venthyr) or FutureAstralPower > 90 and eclipse.in_any) then
                return A.Starsurge:Show(icon)
            end
            
            -- starsurge,if=talent.starlord.enabled&(buff.starlord.up|astral_power>90)&buff.starlord.stack<3&(buff.eclipse_solar.up|buff.eclipse_lunar.up)&buff.primordial_arcanic_pulsar.value<270&(cooldown.ca_inc.remains>10|!variable.convoke_condition&covenant.night_fae)
            if A.Starsurge:IsReady(unit) and (A.Starlord:IsSpellLearned() and (Unit("player"):HasBuffs(A.StarlordBuff.ID, true) or FutureAstralPower > 90) and Unit("player"):HasBuffsStacks(A.StarlordBuff.ID, true) < 3 and (Unit("player"):HasBuffs(A.EclipseSolarBuff.ID, true) or Unit("player"):HasBuffs(A.EclipseLunarBuff.ID, true)) and buff.primordial_arcanic_pulsar.value < 270 and (A.CaInc:GetCooldown() > 10 or not VarConvokeCondition and covenant.night_fae)) then
                return A.Starsurge:Show(icon)
            end
            
            -- starsurge,if=(buff.primordial_arcanic_pulsar.value<270|buff.primordial_arcanic_pulsar.value<250&talent.stellar_drift.enabled)&buff.eclipse_solar.remains>7&eclipse.in_solar&!buff.oneths_perception.up&!talent.starlord.enabled&cooldown.ca_inc.remains>7&(cooldown.kindred_spirits.remains>7|!covenant.kyrian)
            if A.Starsurge:IsReady(unit) and ((buff.primordial_arcanic_pulsar.value < 270 or buff.primordial_arcanic_pulsar.value < 250 and A.StellarDrift:IsSpellLearned()) and Unit("player"):HasBuffs(A.EclipseSolarBuff.ID, true) > 7 and eclipse.in_solar and not Unit("player"):HasBuffs(A.OnethsPerceptionBuff.ID, true) and not A.Starlord:IsSpellLearned() and A.CaInc:GetCooldown() > 7 and (A.KindredSpirits:GetCooldown() > 7 or not covenant.kyrian)) then
                return A.Starsurge:Show(icon)
            end
            
            -- new_moon,if=(buff.eclipse_lunar.up|(charges=2&recharge_time<5)|charges=3)&ap_check&variable.save_for_ca_inc
            if A.NewMoon:IsReady(unit) and ((Unit("player"):HasBuffs(A.EclipseLunarBuff.ID, true) or (A.NewMoon:GetSpellCharges() == 2 and A.NewMoon:RechargeP() < 5) or A.NewMoon:GetSpellCharges() == 3) and ap_check and VarSaveForCaInc) then
                return A.NewMoon:Show(icon)
            end
            
            -- half_moon,if=(buff.eclipse_lunar.up&!covenant.kyrian|(buff.kindred_empowerment_energize.up&covenant.kyrian)|(charges=2&recharge_time<5)|charges=3|buff.ca_inc.up)&ap_check&variable.save_for_ca_inc
            if A.HalfMoon:IsReady(unit) and ((Unit("player"):HasBuffs(A.EclipseLunarBuff.ID, true) and not covenant.kyrian or (Unit("player"):HasBuffs(A.KindredEmpowermentEnergizeBuff.ID, true) and covenant.kyrian) or (A.HalfMoon:GetSpellCharges() == 2 and A.HalfMoon:RechargeP() < 5) or A.HalfMoon:GetSpellCharges() == 3 or Unit("player"):HasBuffs(A.CaIncBuff.ID, true)) and ap_check and VarSaveForCaInc) then
                return A.HalfMoon:Show(icon)
            end
            
            -- full_moon,if=(buff.eclipse_lunar.up&!covenant.kyrian|(buff.kindred_empowerment_energize.up&covenant.kyrian)|(charges=2&recharge_time<5)|charges=3|buff.ca_inc.up)&ap_check&variable.save_for_ca_inc
            if A.FullMoon:IsReady(unit) and ((Unit("player"):HasBuffs(A.EclipseLunarBuff.ID, true) and not covenant.kyrian or (Unit("player"):HasBuffs(A.KindredEmpowermentEnergizeBuff.ID, true) and covenant.kyrian) or (A.FullMoon:GetSpellCharges() == 2 and A.FullMoon:RechargeP() < 5) or A.FullMoon:GetSpellCharges() == 3 or Unit("player"):HasBuffs(A.CaIncBuff.ID, true)) and ap_check and VarSaveForCaInc) then
                return A.FullMoon:Show(icon)
            end
            
            -- warrior_of_elune
            if A.WarriorofElune:IsReady(unit) then
                return A.WarriorofElune:Show(icon)
            end
            
            -- starfire,if=eclipse.in_lunar|eclipse.solar_next|eclipse.any_next|buff.warrior_of_elune.up&buff.eclipse_lunar.up|(buff.ca_inc.remains<action.wrath.execute_time&buff.ca_inc.up)
            if A.Starfire:IsReady(unit) and (eclipse.in_lunar or eclipse.solar_next or eclipse.any_next or Unit("player"):HasBuffs(A.WarriorofEluneBuff.ID, true) and Unit("player"):HasBuffs(A.EclipseLunarBuff.ID, true) or (Unit("player"):HasBuffs(A.CaIncBuff.ID, true) < A.Wrath:GetSpellCastTime() and Unit("player"):HasBuffs(A.CaIncBuff.ID, true))) then
                return A.Starfire:Show(icon)
            end
            
            -- wrath
            if A.Wrath:IsReady(unit) then
                return A.Wrath:Show(icon)
            end
            
            -- run_action_list,name=fallthru
            return Fallthru(unit);
            
        end
        
        
        -- call precombat
        if Precombat(unit) and not inCombat and Unit(unit):IsExists() and unit ~= "mouseover" then 
            return true
        end

        -- In Combat
        if inCombat and Unit(unit):IsExists() then

            -- variable,name=is_aoe,value=spell_targets.starfall>1&(!talent.starlord.enabled|talent.stellar_drift.enabled)|spell_targets.starfall>2
            VarIsAoe = num(MultiUnits:GetByRangeInCombat(40, 5, 10) > 1 and (not A.Starlord:IsSpellLearned() or A.StellarDrift:IsSpellLearned()) or MultiUnits:GetByRangeInCombat(40, 5, 10) > 2)
            
            -- variable,name=is_cleave,value=spell_targets.starfire>1
            VarIsCleave = num(MultiUnits:GetByRangeInCombat(5, 5, 10) > 1)
            
            -- berserking,if=(!covenant.night_fae|!cooldown.convoke_the_spirits.up)&buff.ca_inc.up
            if A.Berserking:AutoRacial(unit) and Racial and A.BurstIsON(unit) and ((not covenant.night_fae or not A.ConvoketheSpirits:GetCooldown() == 0) and Unit("player"):HasBuffs(A.CaIncBuff.ID, true)) then
                return A.Berserking:Show(icon)
            end
            
            -- potion,if=buff.ca_inc.up
            if A.PotionofSpectralIntellect:IsReady(unit) and Potion and (Unit("player"):HasBuffs(A.CaIncBuff.ID, true)) then
                return A.PotionofSpectralIntellect:Show(icon)
            end
            
            -- use_items
            -- heart_essence,if=level=50
            if A.HeartEssence:IsReady(unit) and (Unit("player"):level == 50) then
                return A.HeartEssence:Show(icon)
            end
            
            -- run_action_list,name=aoe,if=variable.is_aoe
            if (VarIsAoe) then
                return Aoe(unit);
            end
            
            -- run_action_list,name=dreambinder,if=runeforge.timeworn_dreambinder.equipped
            if (runeforge.timeworn_dreambinder.equipped) then
                return Dreambinder(unit);
            end
            
            -- run_action_list,name=boat,if=runeforge.balance_of_all_things.equipped
            if (runeforge.balance_of_all_things.equipped) then
                return Boat(unit);
            end
            
            -- run_action_list,name=st,if=level>50
            if (Unit("player"):level > 50) then
                return St(unit);
            end
            
            -- variable,name=prev_wrath,value=prev.wrath
            VarPrevWrath = prev.wrath
            
            -- variable,name=prev_starfire,value=prev.starfire
            VarPrevStarfire = prev.starfire
            
            -- variable,name=prev_starsurge,value=prev.starsurge
            VarPrevStarsurge = prev.starsurge
            
            -- run_action_list,name=prepatch_st
            return PrepatchSt(unit);
            
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

