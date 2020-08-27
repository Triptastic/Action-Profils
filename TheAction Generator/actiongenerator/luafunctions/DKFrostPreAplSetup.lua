------------------------------------------
--------- FROST PRE APL SETUP ------------
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

local MetaQueue                             = {
    [3]                                        = {
        player                                = {UnitID = "player",         Silence = true, Auto = true, Value = true, Priority = 1},
        mouseover                             = {UnitID = "mouseover",     Silence = true, Auto = true, Value = true, Priority = 1},
        target                                 = {UnitID = "target",         Silence = true, Auto = true, Value = true, Priority = 1},
    },
    [6]                                        = {
        player                                 = {UnitID = "player",         Silence = true, Auto = true, Value = true, Priority = 1, MetaSlot = 6},
        target                                 = {UnitID = "arena1",         Silence = true, Auto = true, Value = true, Priority = 1, MetaSlot = 6},
    },
    [7]                                        = {
        player                                 = {UnitID = "player",         Silence = true, Auto = true, Value = true, Priority = 1, MetaSlot = 7},
        target                                 = {UnitID = "arena2",         Silence = true, Auto = true, Value = true, Priority = 1, MetaSlot = 7},
    },
    [8]                                        = {
        player                                 = {UnitID = "player",         Silence = true, Auto = true, Value = true, Priority = 1, MetaSlot = 8},
        target                                 = {UnitID = "arena3",         Silence = true, Auto = true, Value = true, Priority = 1, MetaSlot = 8},
    },
    Cancel                                     = {Silence = true},
}

local IsIndoors, UnitIsUnit = IsIndoors, UnitIsUnit

local function IsSchoolFree()
	return LoC:IsMissed("SILENCE") and LoC:Get("SCHOOL_INTERRUPT", "SHADOW") == 0
end 

local function InMelee(unit)
	-- @return boolean 
	return A.FrostStrike:IsInRange(unit)
end 

-- @return boolean  
-- @parameters count, range are mandatory, others parameters optionals
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
			if InMelee(unit) then 
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

-- ExpectedCombatLength
local function ExpectedCombatLength()
    local BossTTD = 0
    if not A.IsInPvP then 
        for i = 1, MAX_BOSS_FRAMES do 
            if Unit("boss" .. i):IsExists() and not Unit("boss" .. i):IsDead() then 
                BossTTD = Unit("boss" .. i):TimeToDie()
            end 
        end 
    end 
    return BossTTD
end 
ExpectedCombatLength = A.MakeFunctionCachedStatic(ExpectedCombatLength)

-------------------------------------------
-- [[ QUEUE GENERATOR ]] 
-------------------------------------------
local function GenerateBreathofSindragosa(meta, obj, skipObj, unit)
    -- Usage: @number meta, @table obj, @number castLeft or @string unit, @boolean skipObj will not queue itself Breath of Sindragosa if true 
    -- Sorts queue priority for specified meta to build enough runic power for successfully Breath of Sindragosa 
	
	--local BoSPoolSequenceMacro = A.GetToggle(2, "BoSPoolSequenceMacro")
	
    if not A.IsQueueRunningAuto() then                
        local BoSEnemies      = A.GetToggle(2, "BoSEnemies")                             -- not static
        local BoSPoolTime     = A.GetToggle(2, "BoSPoolTime")                                                     -- not static
        local BoSMinPower     = A.GetToggle(2, "BoSMinPower")                                                 -- not static
        
        local myRunicPower        = Player:RunicPower()        
        local needRunicPower      = obj:GetSpellPowerCostCache()                                                                      
        
        -- Do nothing if not enough Runic Power generate
        local canBreathofSindragosa = BoSMinPower > 0 and A.BreathofSindragosa:IsReadyP("player") and myRunicPower >= BoSMinPower
        
		if A.BreathofSindragosa:GetCooldown() > 0 then
		    return false
		end
		
        -- General 
        if not skipObj and canBreathofSindragosa and A.EmpowerRuneWeapon:GetCooldown() > 0 and A.PillarofFrost:GetCooldown() > 0 then 
            local target = unit == "mouseover" and MetaQueue[3].mouseover or MetaQueue[meta].target
           -- obj:SetQueue(target)                                     -- #4
			obj:SetQueue(MetaQueue[meta].player)                     -- #4
        end 
		
        -- Empower Rune Weapon
        if canBreathofSindragosa and A.EmpowerRuneWeapon:GetCooldown() == 0 then 
            A.EmpowerRuneWeapon:SetQueue(MetaQueue[meta].player)             -- #3
        end 
		
        -- Pilar of Frost
        if canBreathofSindragosa and A.PillarofFrost:GetCooldown() == 0 and (A.EmpowerRuneWeapon:GetCooldown() > 110 or A.LastPlayerCastName == A.EmpowerRuneWeapon:Info()) then 
            A.PillarofFrost:SetQueue(MetaQueue[meta].player)             -- #2
        end 	
		
		-- Obliterate
        if not canBreathofSindragosa and Player:Rune() >= 2 then 
		    local target = unit == "mouseover" and MetaQueue[3].mouseover or MetaQueue[meta].target
            A.Obliterate:SetQueue(target)             -- #1
        end 
		
        -- howling_blast,if=buff.rime.up
        if not canBreathofSindragosa and Player:Rune() < 2 and Unit(player):HasBuffs(A.RimeBuff.ID, true) > 0 then
            A.HowlingBlast:SetQueue(target)             -- #1
        end	
		
		-- Custom pool time user
		if not canBreathofSindragosa and A.BreathofSindragosa:GetCooldown() <= BoSPoolTime then
		    return true
		end	
        
    end 
end 

-- Guardian of Azeroth active
-- @return true if guardian is active
local function GuardianofAzerothIsActive() 
    return Pet:GetRemainDuration(152396) > 0 and true or false
end	

-- Guardian of Azeroth time
-- @return remaining time duration in seconds
local function GuardianofAzerothRemains() 
    return Pet:GetRemainDuration(152396)
end	

local function DeathStrikeHeal()
    return Unit(player):HealthPercent() < Action.GetToggle(2, "UseDeathStrikeHP")
end


-- SelfDefensives
local function SelfDefensives()
    local HPLoosePerSecond = Unit(player):GetDMG() * 100 / Unit(player):HealthMax()
		
    if Unit(player):CombatTime() == 0 then 
        return 
    end 

    -- Icebound Fortitude
    local IceboundFortitude = Action.GetToggle(2, "IceboundFortitudeHP")
    if     IceboundFortitude >= 0 and A.IceboundFortitude:IsReady(player) and 
    (
        (   -- Auto 
            IceboundFortitude >= 100 and 
            (
                -- HP lose per sec >= 20
                Unit(player):GetDMG() * 100 / Unit(player):HealthMax() >= 20 or 
                Unit(player):GetRealTimeDMG() >= Unit(player):HealthMax() * 0.20 or 
                -- TTD 
                Unit(player):TimeToDieX(25) < 5 or
				-- Player stunned
                LoC:Get("STUN") > 0	or			
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
		
    -- Emergency AntiMagicShell
        local AntiMagicShell = Action.GetToggle(2, "AntiMagicShellHP")
        if     AntiMagicShell >= 0 and A.AntiMagicShell:IsReady(player) and 
        (
            (   -- Auto 
                AntiMagicShell >= 100 and 
                (
                    -- HP lose per sec >= 10
                    Unit(player):GetDMG() * 100 / Unit(player):HealthMax() >= 10 or 
                    Unit(player):GetRealTimeDMG() >= Unit(player):HealthMax() * 0.10 or 
                    -- TTD Magic
                    Unit(player):TimeToDieMagicX(50) < 5 or 
					
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
        local DeathPact = Action.GetToggle(2, "DeathPactHP")
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

	    -- HealingPotion
    local AbyssalHealingPotion = A.GetToggle(2, "AbyssalHealingPotionHP")
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