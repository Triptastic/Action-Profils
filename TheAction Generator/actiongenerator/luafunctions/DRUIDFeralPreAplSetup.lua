------------------------------------------
---------- FERAL PRE APL SETUP -----------
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
    return LoC:IsMissed("SILENCE") and LoC:Get("SCHOOL_INTERRUPT", "NATURE") == 0
end 

local function InMelee(unit)
    -- @return boolean 
    return A.Rake:IsInRange(unit)
end 

local function GetByRange(count, range, isCheckEqual, isCheckCombat)
    -- @return boolean 
    local c = 0 
    for unit in pairs(ActiveUnitPlates) do 
        if (not isCheckEqual or not UnitIsUnit(target, unit)) and (not isCheckCombat or Unit(unit):CombatTime() > 0) then 
            if InMelee(unit) then 
                c = c + 1
            elseif range then 
                local r = Unit(unit):GetRange()
                if r > 0 and r <= range then 
                    c = c + 1
                end 
            end 
            
            if c >= count then 
                return true 
            end 
        end 
    end
end 

-- Return the lowest Unit TTD value
-- Used as snipping function 
local function LowestTTD()
    local lowTTD = 0
    for activeunits in pairs(ActiveUnitPlates) do
        if (lowTTD == 0 or Unit(activeunits):TimeToDie() < lowTTD) then
            lowTTD = Unit(activeunits):TimeToDie()
        end
    end
    return lowTTD
end

local function SwipeBleedMult()
    return (Unit(unit):HasDeBuffs(A.RipDebuff.ID, true) > 0 or Unit(unit):HasDeBuffs(A.RakeDebuff.ID, true) > 0 or Unit(unit):HasDeBuffs(A.ThrashCatDebuff.ID, true) > 0) and 1.2 or 1
end

local function RakeBleedTick()
    return LastRakeAP * 0.15561 * (1 + Player:VersatilityDmgPct() / 100)
end

-- [1] CC AntiFake Rotation
local function AntiFakeStun(unit) 
    return A.IsUnitEnemy(unit)    
end 
A[1] = function(icon)    

	-- Cyclone
    if     A.AntiFakeCCFocusCyclone:IsReady(nil, nil, nil, true) and Unit("target"):GetRange() <= 20 and 
    (
        AntiFakeStun("mouseover") 
		or 
        AntiFakeStun("target") 
    )
    then 
        return A.AntiFakeCCFocusCyclone:Show(icon)         
    end 
	
	-- MightyBash
    if     A.MightyBashGreen:IsReady(nil, nil, nil, true) and Unit("target"):GetRange() <= 8 and 
    (
        AntiFakeStun("mouseover") 
		or 
        AntiFakeStun("target") 
    )
    then 
        return A.MightyBashGreen:Show(icon)         
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
            if not notKickAble and A.SkullBashGreen:IsReady(unit, nil, nil, true) and A.SkullBashGreen:AbsentImun(unit, Temp.TotalAndMag, true) then
                return A.SkullBashGreen:Show(icon)                                                  
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
    
    -- SurvivalInstincts
    local SurvivalInstincts = A.GetToggle(2, "SurvivalInstincts")
    if     SurvivalInstincts >= 0 and A.SurvivalInstincts:IsReady("player", nil, nil, true) and
    (
        (     -- Auto 
            SurvivalInstincts >= 100 and 
            (
                Unit(player):HealthPercent() <= 50 or
                (                        
                    Unit(player):HealthPercent() < 70 
                )
            )
        ) 
        or 
        (    -- Custom
            SurvivalInstincts < 100 and 
            Unit(player):HealthPercent() <= SurvivalInstincts
        )
    ) 
    then 
        return A.SurvivalInstincts
    end 
 
    -- Bear Form
 --[[   local BearForm = A.GetToggle(2, "BearForm")
    if     BearForm >= 0 and not IsInBearForm and A.BearForm:IsReady("player") and
    (
        (     -- Auto 
            BearForm >= 100 and Unit(player):HealthPercent() < 20 and
            (
			    EnemyTeam():IsReshiftAble() 
				or 
				(Unit(player):HasDeBuffs(78675) > 0 and Unit(player):HasDeBuffs("Rooted") > 0)
			)
        ) 
        or 
        (    -- Custom
            BearForm < 100 and 
            Unit(player):HealthPercent() <= BearForm
        )
    ) 
    then 
        return A.BearForm
    end
 ]]--
    -- Stoneform on self dispel (only PvE)
    if A.Stoneform:IsRacialReady(player, true) and not A.IsInPvP and A.AuraIsValid(player, "UseDispel", "Dispel") then 
        return A.Stoneform
    end 
end 
SelfDefensives = A.MakeFunctionCachedStatic(SelfDefensives)

-- Non GCD spell check
local function countInterruptGCD(unit)
    if not A.SkullBash:IsReadyByPassCastGCD(unit) or not A.SkullBash:AbsentImun(unit, Temp.TotalAndMagKick) then
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
        if useKick and A.SkullBash:IsReady(unit) and A.SkullBash:AbsentImun(unit, Temp.TotalAndPhysKick, true) then 
            -- Notification                    
            Action.SendNotification("Skull Bash interrupting on " .. unit, A.SkullBash.ID)
            return A.SkullBash
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

-- Stealth Handler UI --
local function HandleStealth()
    local choice = GetToggle(2, "AutoStealthOOC")
    local unit = "target"
    return     (
        (IsInRaid() and choice[1]) or 
        (IsInGroup() and choice[2]) or
        (A.IsInPvP and choice[3]) or
		(A.Prowl:IsReady() and choice[4])
    )
end

A.FerociousBiteMaxEnergy.CustomCost = {
    [3] = function ()
        if (Unit(player):HasBuffs(A.IncarnationBuff.ID, true) > 0 or Unit(player):HasBuffs(A.BerserkBuff.ID, true) > 0) then 
		    return 25
        else 
		    return 50
        end
    end
}

local function BalanceAffinity(unit)
	
	-- Sunfire
	if A.Sunfire:IsReady(unit) and Unit(unit):HasDeBuffs(A.SunfireDebuff.ID, true) < 4 then
        return A.Sunfire	
	end
		
	-- Moonfire	
	if A.Moonfire:IsReady(unit) and Unit(unit):HasDeBuffs(A.MoonfireDebuff.ID, true) < 4 then
        return A.Moonfire	
	end
		
	-- Solar Wrath
	if A.SolarWrath:IsReady(unit) and Unit(unit):HasDeBuffs(A.SunfireDebuff.ID, true) > 3 and Unit(unit):HasDeBuffs(A.MoonfireDebuff.ID, true) > 3 and 
    Unit(player):HasBuffs(A.SolarEmpowermentBuff.ID, true) > 0
	then
        return A.SolarWrath	
	end
		
	-- Lunar Strike
	if A.LunarStrike:IsReady(unit) and Unit(unit):HasDeBuffs(A.SunfireDebuff.ID, true) > 3 and Unit(unit):HasDeBuffs(A.MoonfireDebuff.ID, true) > 3 and
	Unit(player):HasBuffs(A.LunarEmpowermentBuff.ID, true) > 0
	then
        return A.LunarStrike
	end
		
	-- Starsurge
	if A.Starsurge:IsReady(unit) and (Unit(player):HasBuffs(A.LunarEmpowermentBuff.ID, true) == 0 or Unit(player):HasBuffs(A.SolarEmpowermentBuff.ID, true) == 0) then
        return A.Starsurge	
	end	
	
	-- Solar Wrath
	if A.SolarWrath:IsReady(unit) and Unit(unit):HasDeBuffs(A.SunfireDebuff.ID, true) > 3 and Unit(unit):HasDeBuffs(A.MoonfireDebuff.ID, true) > 3 and 
    Unit(player):HasBuffs(A.SolarEmpowermentBuff.ID, true) == 0 and Unit(player):HasBuffs(A.LunarEmpowermentBuff.ID, true) == 0 and A.Starsurge:GetCooldown() > 0
	then
        return A.SolarWrath	
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