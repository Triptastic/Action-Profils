------------------------------------------
-------- PROTECTION PRE APL SETUP --------
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
	BigDeff                                 = {A.ShieldWall.ID},
}

local IsIndoors, UnitIsUnit = IsIndoors, UnitIsUnit
local player = "player"

local function IsSchoolFree()
	return LoC:IsMissed("SILENCE") and LoC:Get("SCHOOL_INTERRUPT", "SHADOW") == 0
end 

local function InRange(unit)
	-- @return boolean 
	return A.Devastate:IsInRange(unit)
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

local function isCurrentlyTanking()
    -- is player currently tanking any enemies within 16 yard radius
    local IsTanking = Unit(player):IsTankingAoE(16) or Unit(player):IsTanking("target", 16);
    return IsTanking;
end

local function shouldCastIp()
    if Unit(player):HasBuffs(A.IgnorePain.ID, true) > 0 then 
        local castIP = tonumber((GetSpellDescription(190456):match("%d+%S+%d"):gsub("%D","")))
        local IPCap = math.floor(castIP * 1.3);
        local currentIp = Unit(player):HasBuffs(A.IgnorePain.ID, true)

        -- Dont cast IP if we are currently at 50% of IP Cap remaining
        if currentIp  < (0.5 * IPCap) then
            return true
        else
            return false
        end
    else
        -- No IP buff currently
        return true
    end
end

local function offensiveShieldBlock()
    return not Action.GetToggle(2, "UseShieldBlockDefensively") and true or false
end

local function offensiveRage()
    return not Action.GetToggle(2, "UseRageDefensively") and true or false 
end

-- [1] CC AntiFake Rotation
local function AntiFakeStun(unit) 
    return 
    A.IsUnitEnemy(unit) and  
    Unit(unit):GetRange() <= 20 and 
    A.StormboltGreen:AbsentImun(unit, Temp.TotalAndPhysAndCCAndStun, true)          
end 
A[1] = function(icon)    
    if	A.StormboltGreen:IsReady(nil, nil, nil, true) and 
    (
        AntiFakeStun("mouseover") or 
        AntiFakeStun("target") or 
        (
            not A.IsUnitEnemy("mouseover") and 
            not A.IsUnitEnemy("target")
        )
    )
    then 
        return A.StormboltGreen:Show(icon)         
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
            if not notKickAble and A.PummelGreen:IsReady(unit, nil, nil, true) and A.PummelGreen:AbsentImun(unit, Temp.TotalAndPhysKick, true) then
                return A.PummelGreen:Show(icon)                                                  
            end 
            
			-- Stormbolt
            if A.Stormbolt:IsReady(unit, nil, nil, true) and A.Stormbolt:AbsentImun(unit, Temp.TotalAndPhysAndStun, true) and Unit(unit):IsControlAble("stun", 0) then
                return A.Stormbolt:Show(icon)                  
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

-- SelfDefensives
local function SelfDefensives()
    local HPLoosePerSecond = math.max((Unit(player):GetDMG() * 100 / Unit(player):HealthMax()) - (Unit(player):GetHEAL() * 100 / Unit(player):HealthMax()), 0)

	
    if Unit(player):CombatTime() == 0 then 
        return 
    end 
	
    -- memory_of_lucid_dreams
    if A.MemoryofLucidDreams:AutoHeartOfAzerothP(player, true) and Action.GetToggle(1, "HeartOfAzeroth") then 
	    local LucidDreamTTD = GetToggle(2, "LucidDreamTTD")	
	    local LucidDreamHP = GetToggle(2, "LucidDreamHP")
            
        if  (    
                ( LucidDreamHP      >= 0     or LucidDreamTTD                    >= 0                                        ) and 
                ( LucidDreamHP      <= 0     or Unit(player):HealthPercent()     <= LucidDreamHP                             ) and 
                ( LucidDreamTTD     <= 0     or Unit(player):TimeToDie()         <= LucidDreamTTD                            ) 
            )                 
        then                
            return A.MemoryofLucidDreams
        end 
    end
			
    -- ShieldBlock (any role, whenever have physical damage)
	local ShieldBlockHPLost = GetToggle(2, "ShieldBlockHPLost")
    if Player:Rage() >= A.ShieldBlock:GetSpellPowerCost() and HPLoosePerSecond >= ShieldBlockHPLost and A.ShieldBlock:IsReady(player) and Unit(player):HasBuffs(A.ShieldBlockBuff.ID, true) == 0 and Unit(player):HasBuffs(A.LastStandBuff.ID, true) == 0 and Unit(player):GetRealTimeDMG(3) > 0 then 
        return A.ShieldBlock
    end 
	
    -- LastStand
    if A.LastStand:IsReadyByPassCastGCD(player) and (not A.GetToggle(2, "LastStandIgnoreBigDeff") or Unit(player):HasBuffs(Temp.BigDeff) == 0) then 
        local LS_HP                 = A.GetToggle(2, "LastStandHP")
        local LS_TTD                = A.GetToggle(2, "LastStandTTD")
            
        if  (    
                ( LS_HP     >= 0     or LS_TTD                              >= 0                                        ) and 
                ( LS_HP     <= 0     or Unit(player):HealthPercent()     <= LS_HP                                    ) and 
                ( LS_TTD     <= 0     or Unit(player):TimeToDie()         <= LS_TTD                                      ) 
            ) 
		    or 
            (
                A.GetToggle(2, "LastStandCatchKillStrike") and 
                (
                    ( Unit(player):GetDMG()         >= Unit(player):Health() and Unit(player):HealthPercent() <= 20 ) or 
                    Unit(player):GetRealTimeDMG() >= Unit(player):Health() or 
                    Unit(player):TimeToDie()         <= A.GetGCD()
                )
            )                
        then                
            return A.LastStand
        end 
    end
		
		
    -- ShieldWall
    if A.ShieldWall:IsReadyByPassCastGCD(player) then 
        local SW_HP                 = A.GetToggle(2, "ShieldWallHP")
        local SW_TTD                = A.GetToggle(2, "ShieldWallTTD")
            
        if  (    
                ( SW_HP     >= 0     or SW_TTD                              >= 0                                        ) and 
                ( SW_HP     <= 0     or Unit(player):HealthPercent()     <= SW_HP                                    ) and 
                ( SW_TTD     <= 0     or Unit(player):TimeToDie()         <= SW_TTD      )  
            ) 
			or 
            (
                A.GetToggle(2, "ShieldWallCatchKillStrike") and 
                (
                    ( Unit(player):GetDMG()         >= Unit(player):Health() and Unit(player):HealthPercent() <= 20 ) or 
                    Unit(player):GetRealTimeDMG() >= Unit(player):Health() or 
                    Unit(player):TimeToDie()         <= A.GetGCD() + A.GetCurrentGCD()
                )
            )                
        then
            -- ShieldBlock
            if A.ShieldBlock:IsReadyByPassCastGCD(player) and Player:Rage() >= A.ShieldBlock:GetSpellPowerCostCache() and Unit(player):HasBuffs(A.ShieldBlockBuff.ID, true) == 0 and Unit(player):HasBuffs(A.LastStandBuff.ID, true) == 0 then  
                return A.ShieldBlock        -- #4
            end 
                
            -- ShieldWall
            return A.ShieldWall         -- #3                  
             
        end 
    end

    -- RallyingCry 
	local RallyingCry = A.GetToggle(2, "RallyingCryHP")
    if	RallyingCry >= 0 and A.RallyingCry:IsReady(player) and 
    (
        (     -- Auto 
            RallyingCry >= 100 and 
            (
                -- HP lose per sec >= 20
                Unit(player):GetDMG() * 100 / Unit(player):HealthMax() >= 10 or 
                Unit(player):GetRealTimeDMG() >= Unit(player):HealthMax() * 0.10 or 
                -- TTD 
                Unit(player):TimeToDieX(20) < 5 or 
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
        ) 
		or 
        (    -- Custom
            RallyingCry < 100 and 
            Unit(player):HealthPercent() <= RallyingCry
        )
    ) 
    then 
        return A.RallyingCry
    end  	
	
	-- HealingPotion
    local AbyssalHealingPotion = A.GetToggle(2, "AbyssalHealingPotionHP")
    if     AbyssalHealingPotion >= 0 and A.AbyssalHealingPotion:IsReady(player) and 
    (
        (     -- Auto 
            AbyssalHealingPotion >= 100 and 
            (
                -- HP lose per sec >= 20
                Unit(player):GetDMG() * 100 / Unit(player):HealthMax() >= 10 or 
                Unit(player):GetRealTimeDMG() >= Unit(player):HealthMax() * 0.10 or 
                -- TTD 
                Unit(player):TimeToDieX(20) < 5 or 
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
    if not A.Pummel:IsReadyByPassCastGCD(unit) or not A.Pummel:AbsentImun(unit, Temp.TotalAndMagKick) then
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
        -- Pummel
        if useKick and A.Pummel:IsReady(unit) and A.Pummel:AbsentImun(unit, Temp.TotalAndPhysKick, true)  then 
            return A.Pummel
        end 
		
        if useCC and A.Shockwave:IsReady(player) and GetByRange(2, 8, true, false) and A.Shockwave:AbsentImun(unit, Temp.TotalAndCC, true) and Unit(unit):IsControlAble("stun", 0) then 
	        -- Notification					
            Action.SendNotification("Shockwave interrupting...", A.Shockwave.ID)
            return A.Shockwave              
        end 
	
        -- Stormbolt
        if useCC and A.Stormbolt:IsReady(unit) and A.Stormbolt:AbsentImun(unit, Temp.TotalAndPhysAndCC, true) and Unit(unit):IsControlAble("stun", 0) then
            return A.Stormbolt              
        end  
    
        -- IntimidatingShout
        if useCC and A.IntimidatingShout:IsReady(unit) and A.IntimidatingShout:AbsentImun(unit, Temp.TotalAndPhysAndCC, true) and Unit(unit):IsControlAble("fear", 0) then 
            return A.IntimidatingShout              
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

local function EvaluateCycleAshvanesRazorCoral84(unit)
    return Unit(unit):HasDeBuffsStacks(A.RazorCoralDebuff.ID, true) == 0
end

local function ThunderClapRange()
    return A.CracklingThunder:IsSpellLearned() and 12 or 8
end