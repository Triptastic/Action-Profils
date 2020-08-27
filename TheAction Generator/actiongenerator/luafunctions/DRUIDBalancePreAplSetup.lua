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