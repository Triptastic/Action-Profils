------------------------------------------
----------- FIRE PRE APL SETUP -----------
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
	return A.Fireball:IsInRange(unit)
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

---A.PhoenixFlames:RegisterInFlight();
--A.Pyroblast:RegisterInFlight(A.CombustionBuff);
--A.Fireball:RegisterInFlight(A.CombustionBuff);

local function FirestarterActiveStatus(unit)
    return (A.Firestarter:IsSpellLearned() and (Unit(unit):HealthPercent() > 90)) and true or false
end

local function FirestarterActiveRemains(unit)
    return ((A.Firestarter:IsSpellLearned() and Unit(unit):HealthPercent() > 90 and Unit(unit):TimeToDieX(90)) or 0)
end

local function HeatingUpBuffActive()
    return Unit(player):HasBuffs(A.HeatingUpBuff.ID, true) > 0 and A.FireBlast:GetSpellTimeSinceLastCast() > 1
end