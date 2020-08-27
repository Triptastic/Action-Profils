------------------------------------------
--------- UNHOLY PRE APL SETUP -----------
------------------------------------------

-- API - Pet Tracker 
Pet:AddTrackers(ACTION_CONST_DEATHKNIGHT_UNHOLY, { -- this template table is the same with what has this library already built-in, just for example
	[152396] = {
		name = "GuardianofAzeroth",
		duration = 30,
	},
	[26125] = {
		name = "RisenAlly",
		duration = 9999,
	},
	[24207] = {
		name = "ApocGhoul",
		duration = 15,
	},
	[27829] = {
		name = "Gargoyle",
		duration = 30,
	},
})

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

local IsIndoors, UnitIsUnit = IsIndoors, UnitIsUnit
local player = "player"

local function IsSchoolFree()
	return LoC:IsMissed("SILENCE") and LoC:Get("SCHOOL_INTERRUPT", "SHADOW") == 0
end 

local function InMelee(unit)
	-- @return boolean 
	return A.ScourgeStrike:IsInRange(unit)
end 

local function GetByRange(count, range, isCheckEqual, isCheckCombat)
	-- @return boolean 
	local c = 0 
	for unit in pairs(ActiveUnitPlates) do 
		if (not isCheckEqual or not UnitIsUnit("target", unit)) and (not isCheckCombat or Unit(unit):CombatTime() > 0) then 
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
GetByRange = A.MakeFunctionCachedDynamic(GetByRange)

local function GuardianofAzerothIsActive() 
    return Pet:GetRemainDuration(152396) > 0 and true or false
end	

local function DeathStrikeHeal()
    return (GetToggle(2, "SoloMode") and Unit(player):HealthPercent() < GetToggle(2, "UseDeathStrikeHP")) and true or false;
end

local function EvaluateCycleFesteringStrike42(unit)
    return Unit(unit):HasDeBuffsStacks(A.FesteringWoundDebuff.ID, true) <= 1 and A.DeathandDecay:GetCooldown() > 0
end

local function EvaluateCycleSoulReaper167(unit)
    return Unit(unit):TimeToDie() < 8 and Unit(unit):TimeToDie() > 4
end

local function EvaluateCycleOutbreak401(unit)
    return Unit(unit):HasDeBuffs(A.VirulentPlagueDebuff.ID, true) <= A.GetGCD()
end

-- SelfDefensives
local function SelfDefensives(unit)
    local HPLoosePerSecond = Unit(player):GetDMG() * 100 / Unit(player):HealthMax()
		
    if Unit(player):CombatTime() == 0 then 
        return 
    end 

    -- Icebound Fortitude
	
	local IceboundFortitudeAntiStun = GetToggle(2, "IceboundFortitudeAntiStun")
    local IceboundFortitude = GetToggle(2, "IceboundFortitudeHP")
    if     IceboundFortitude >= 0 and A.IceboundFortitude:IsReady(player) and 
    (
        (   -- Auto 
            IceboundFortitude >= 100 and 
            (
                -- HP lose per sec >= 20
                Unit(player):GetDMG() * 100 / Unit(player):HealthMax() >= 30 or 
                Unit(player):GetRealTimeDMG() >= Unit(player):HealthMax() * 0.30 or 
                -- TTD 
                Unit(player):TimeToDieX(25) < 2 or
				-- Player stunned
                LoC:Get("STUN") > 2 and IceboundFortitudeAntiStun or			
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
            IceboundFortitude < 100 and 
            Unit(player):HealthPercent() <= IceboundFortitude
        )
    ) 
    then 
        return A.IceboundFortitude
    end  
	
	    -- HealingPotion
    local AbyssalHealingPotion = GetToggle(2, "AbyssalHealingPotionHP")
    if     AbyssalHealingPotion >= 0 and A.AbyssalHealingPotion:IsReady(player) and 
    (
        (     -- Auto 
            AbyssalHealingPotion >= 100 and 
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
            AbyssalHealingPotion < 100 and 
            Unit(player):HealthPercent() <= AbyssalHealingPotion
        )
    ) 
    then 
        return A.AbyssalHealingPotion
    end 
		
    -- Emergency AntiMagicShell
        local AntiMagicShell = GetToggle(2, "AntiMagicShellHP")
        if     AntiMagicShell >= 0 and A.AntiMagicShell:IsReady(player) and 
        (
            (   -- Auto 
                AntiMagicShell >= 100 and 
                (
                    -- HP lose per sec >= 10
                    Unit(player):GetDMG() * 100 / Unit(player):HealthMax() >= 15 or 
                    Unit(player):GetRealTimeDMG() >= Unit(player):HealthMax() * 0.15 or 
                    -- TTD Magic
                    Unit(player):TimeToDieMagicX(30) < 3 or 
					
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
                AntiMagicShell < 100 and 
                Unit(player):HealthPercent() <= AntiMagicShell
            )
        ) 
        then 
            return A.AntiMagicShell
        end  		

        -- Emergency Death Pact
        local DeathPact = GetToggle(2, "DeathPactHP")
        if     DeathPact >= 0 and A.DeathPact:IsReady(player) and A.DeathPact:IsSpellLearned() and 
        (
            (   -- Auto 
                DeathPact >= 100 and 
                (
                    -- HP lose per sec >= 30
                    Unit(player):GetDMG() * 100 / Unit(player):HealthMax() >= 30 or 
                    Unit(player):GetRealTimeDMG() >= Unit(player):HealthMax() * 0.30 or 
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
                DeathPact < 100 and 
                Unit(player):HealthPercent() <= DeathPact
            )
        ) 
        then 
            return A.DeathPact
        end  		

end 
SelfDefensives = A.MakeFunctionCachedDynamic(SelfDefensives)

-- Non GCD spell check
local function countInterruptGCD(unit)
    if not A.MindFreeze:IsReadyByPassCastGCD(unit) or not A.MindFreeze:AbsentImun(unit, Temp.TotalAndMagKick) then
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
        -- MindFreeze
        if useKick and not notInterruptable and A.MindFreeze:IsReady(unit) then 
            return A.MindFreeze
        end
	
        -- DeathGrip
        if useCC and A.DeathGrip:IsReady(unit) and DeathGripInterrupt then 
            return A.DeathGrip
   	    end 
	
   	    -- Asphyxiate
   	    if useCC and A.Asphyxiate:IsSpellLearned() and A.Asphyxiate:IsReady(unit) then 
   	        return A.Asphyxiate
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