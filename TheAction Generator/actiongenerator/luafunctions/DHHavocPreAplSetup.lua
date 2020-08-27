------------------------------------------
--------- HAVOC PRE APL SETUP ------------
------------------------------------------

local player                                    = "player"
local PartyUnits
local Temp                                        = {
    TotalAndPhys                                = {"TotalImun", "DamagePhysImun"},
    TotalAndPhysKick                            = {"TotalImun", "DamagePhysImun", "KickImun"},
    TotalAndPhysAndCC                            = {"TotalImun", "DamagePhysImun", "CCTotalImun"},
    TotalAndPhysAndStun                            = {"TotalImun", "DamagePhysImun", "StunImun"},
    TotalAndPhysAndCCAndStun                    = {"TotalImun", "DamagePhysImun", "CCTotalImun", "StunImun"},
    TotalAndMag                                    = {"TotalImun", "DamageMagicImun"},
    TotalAndMagKick                         = {"TotalImun", "DamageMagicImun", "KickImun"},
    DisablePhys                                    = {"TotalImun", "DamagePhysImun", "Freedom", "CCTotalImun"},
    DisableMag                                    = {"TotalImun", "DamageMagicImun", "Freedom", "CCTotalImun"},
}

local IsIndoors, UnitIsUnit = 
IsIndoors, UnitIsUnit    

local function InMelee(unit)
    -- @return boolean 
    return A.ChaosStrike:IsInRange(unit)
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

local function num(val)
    if val then return 1 else return 0 end
end

-- EyeBeam Handler UI --
local function HandleEyeBeam()
    local choice = A.GetToggle(2, "EyeBeamMode")
    --print(choice) 
    local unit = "target"
    -- CDs ON
    if choice[1] then 
        return BurstIsON(unit) or false 
        -- AoE Only
    elseif choice[2] then
        -- also checks CDs
        if choice[1] then
            return (BurstIsON(unit) and GetByRange(2, 8) and A.GetToggle(2, "AoE")) or false
        else
            return (GetByRange(2, 8) and A.GetToggle(2, "AoE")) or false
        end
        -- Everytime
    elseif choice[3] then
        return A.EyeBeam:IsReady(unit) or false
    else
        return false
    end        
end

-- FelRush handler
local function UseMoves()
    return Action.GetToggle(2, "UseMoves") --or S.FelRush:Charges() == 2  
end


-- [1] CC AntiFake Rotation
local function AntiFakeStun(unit) 
    return 
    Action.IsUnitEnemy(unit) and  
    Unit(unit):GetRange() <= 7 and 
    A.ChaosNovaGreen:AbsentImun(unit, Temp.TotalAndPhysAndCCAndStun, true)          
end 
A[1] = function(icon)    
    if     A.ChaosNovaGreen:IsReady(nil, nil, nil, true) and 
    (
        AntiFakeStun("mouseover") or 
        AntiFakeStun("target") or 
        (
            not Action.IsUnitEnemy("mouseover") and 
            not Action.IsUnitEnemy("target") and                     
            (
                (Action.IsInPvP and EnemyTeam():PlayersInRange(1, 5)) or 
                (not Action.IsInPvP and GetByRange(1, 5))
            )
        )
    )
    then 
        return A.ChaosNovaGreen:Show(icon)         
    end                                                                     
end

-- [2] Kick AntiFake Rotation
A[2] = function(icon)        
    local unit
    if Action.IsUnitEnemy("mouseover") then 
        unit = "mouseover"
    elseif Action.IsUnitEnemy("target") then 
        unit = "target"
    end 
    
    if unit then         
        local castLeft, _, _, _, notKickAble = Unit(unit):IsCastingRemains()
        if castLeft > 0 then             
            -- Disrupt
            if not notKickAble and A.DisruptGreen:IsReady(unit, nil, nil, true) and A.DisruptGreen:AbsentImun(unit, Temp.TotalAndPhysKick, true) then
                return A.DisruptGreen:Show(icon)                                                  
            end 
            
            -- Imprison
            if A.Imprison:IsReady(unit, nil, nil, true) and A.Imprison:AbsentImun(unit, Temp.TotalAndPhysAndCC, true) and Unit(unit):IsControlAble("incapacitate", 0) then
                return A.Imprison:Show(icon)                  
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

-- Multidot Handler UI --
local function HandleDarkness()
    local choice = Action.GetToggle(2, "DarknessMode")
    
    if choice == "In Raid" then
        if IsInRaid() then
            return true
        else
            return false
        end
    elseif choice == "In Dungeon" then 
        if IsInGroup() then
            return true
        else
            return false
        end
    elseif choice == "In PvP" then     
        if A.IsInPvP then 
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

-- Fel Blade UI --
local function HandleFelBlade()
    local choice = Action.GetToggle(2, "FelBladeMode")
    
    if choice == "AUTO" then
        -- Add protection for raid
        if not IsInRaid() then
            return true
            -- IF in Raid but in range of current target.
        elseif IsInRaid() and InMelee(unit) then
            return true
        else
            return false
        end
    elseif choice == "PVP" then 
        if A.IsInPvP then 
            return true
        end    
    else
        return false
    end
    
end

-- Auto Darkness Handler
local function CanDarkness()
    if A.Darkness:IsReady(player) then 
        -- Darkness
        local AutoDarkness = A.GetToggle(2, "AutoDarkness")
        local DarknessUnits = A.GetToggle(2, "DarknessUnits")
        local DarknessUnitsHP = A.GetToggle(2, "DarknessUnitsHP")    
        local DarknessUnitsTTD = A.GetToggle(2, "DarknessUnitsTTD")
        local totalMembers = HealingEngine.GetMembersAll()
		
        -- Auto Counter
        if DarknessUnits > 1 then 
            DarknessUnits = HealingEngine.GetMinimumUnits(1)
            -- Reduce size in raid by 20%
            if DarknessUnits > 5 then 
                DarknessUnits = DarknessUnits - (#totalMembers * 0.2)
            end 
            -- If user typed counter higher than max available members 
        elseif DarknessUnits >= TeamCache.Friendly.Size then 
            DarknessUnits = TeamCache.Friendly.Size
        end 
        
        if DarknessUnits < 3 and not A.IsInPvP then 
            return false 
        end 
        
        local counter = 0 
        for i = 1, #totalMembers do 
            -- Auto HP 
            if DarknessUnitsHP >= 100 and totalMembers[i].HP <= 30 then 
                counter = counter + 1
            end 
            
            -- Auto TTD 
            if DarknessUnitsTTD >= 100 and Unit(totalMembers[i].Unit):TimeToDie() <= 5 then 
                counter = counter + 1
            end 
            
            -- Custom HP 
            if DarknessUnitsHP < 100 and totalMembers[i].HP <= DarknessUnitsHP then 
                counter = counter + 1
            end
            
            -- Custom TTD 
            if DarknessUnitsTTD < 100 and Unit(totalMembers[i].Unit):TimeToDie() <= DarknessUnitsTTD then 
                counter = counter + 1
            end             
            
            if counter >= DarknessUnits then 
                return true 
            end 
        end 
    end 
    return false 
end 
CanDarkness = A.MakeFunctionCachedStatic(CanDarkness)

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
    
    -- Darkness
    if   AutoDarkness and HandleDarkness and CanDarkness() then 
        -- Notification                    
        Action.SendNotification("Defensive Darkness", A.Darkness.ID)
        return A.Darkness
    end
    
    -- Netherwalk
    local Netherwalk = A.GetToggle(2, "Netherwalk")
    if     Netherwalk >= 0 and A.Netherwalk:IsReady(player) and 
    (
        (     -- Auto 
            Netherwalk >= 100 and 
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
                            Unit("player", 5):HasFlags() and 
                            Unit(player):GetRealTimeDMG() > 0 and 
                            Unit(player):IsFocused() 
                        )
                    )
                )
            ) and 
            Unit(player):HasBuffs("DeffBuffs", true) == 0
        ) or 
        (    -- Custom
            Netherwalk < 100 and 
            Unit(player):HealthPercent() <= Netherwalk
        )
    ) 
    then 
        -- Notification                    
        Action.SendNotification("Defensive Netherwalk", A.Netherwalk.ID)
        return A.Netherwalk
    end
    
    -- Blur
    local Blur = A.GetToggle(2, "Blur")
    if     Blur >= 0 and A.Blur:IsReady(player) and 
    (
        (     -- Auto 
            Blur >= 100 and 
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
                            Unit("player", 5):HasFlags() and 
                            Unit(player):GetRealTimeDMG() > 0 and 
                            Unit(player):IsFocused() 
                        )
                    )
                )
            ) and 
            Unit(player):HasBuffs("DeffBuffs", true) == 0
        ) or 
        (    -- Custom
            Blur < 100 and 
            Unit(player):HealthPercent() <= Blur
        )
    ) 
    then 
        -- Notification                    
        Action.SendNotification("Defensive Blur", A.Blur.ID)
        return A.Blur
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
                            Unit("player", 5):HasFlags() and 
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
    
    -- Stoneform on self dispel (only PvE)
    if A.Stoneform:IsRacialReady("player", true) and not A.IsInPvP and A.AuraIsValid("player", "UseDispel", "Dispel") then 
        return A.Stoneform
    end 
    
    
end 
SelfDefensives = A.MakeFunctionCachedStatic(SelfDefensives)

-- Non GCD spell check
local function countInterruptGCD(unit)
    if not A.Disrupt:IsReadyByPassCastGCD(unit) or not A.Disrupt:AbsentImun(unit, Temp.TotalAndMagKick) then
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
        -- Disrupt
        if useKick and not notInterruptable and A.Disrupt:IsReady(unit) then 
            return A.Disrupt
        end

        -- Fel Eruption
        if useCC and A.FelEruption:IsSpellLearned() and A.FelEruption:IsReady(unit) and GetByRange(1, 20) and A.FelEruption:AbsentImun(unit, Temp.TotalAndPhysAndCCAndStun, true) and Unit(unit):IsControlAble("stun") then 
            -- Notification                    
            Action.SendNotification("CC : Fel Eruption", A.FelEruption.ID)
            return A.FelEruption              
        end 
    
        -- Chaos Nova    
        if useCC and A.ChaosNova:IsReady(unit) and GetByRange(2, 10) and A.ChaosNova:AbsentImun(unit, Temp.TotalAndPhysAndCCAndStun, true) and Unit(unit):IsControlAble("stun") then 
            -- Notification                    
            Action.SendNotification("CC : Chaos Nova", A.ChaosNova.ID)        
            return A.ChaosNova              
        end 
    
        -- Imprison    
        if useCC and A.Imprison:IsReady(unit) and A.GetToggle(2, "ImprisonAsInterrupt") then 
            -- Notification                    
            Action.SendNotification("CC : Imprison", A.Imprison.ID)        
            return A.Imprison              
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

local profileStop = false

local function ShouldDelayEyeBeam()
	local CurrentChannelTime = Action.GetSpellDescription(198013)[3]
		
    -- Check for M+ Quake Affix
    if Unit(player):HasDeBuffs(A.Quake.ID) > 0 and Unit(player):HasDeBuffs(A.Quake.ID) <= CurrentChannelTime + A.GetGCD() then
        return true
    end
end

local function ShouldDelayFelBarrage()
	local CurrentChannelTime = Action.GetSpellDescription(258925)[3]
		
    -- Check for M+ Quake Affix
    if Unit(player):HasDeBuffs(A.Quake.ID) > 0 and Unit(player):HasDeBuffs(A.Quake.ID) <= CurrentChannelTime + A.GetGCD() then
        return true
    end
end

local function ShouldDelayFocusedAzeriteBeam()
    local CurrentCastTime = Unit("player"):CastTime(295258)
	local CurrentChannelTime = Action.GetSpellDescription(295258)[2]
		
    -- Check for M+ Quake Affix
    if Unit(player):HasDeBuffs(A.Quake.ID) > 0 and Unit(player):HasDeBuffs(A.Quake.ID) <= CurrentCastTime + CurrentChannelTime + A.GetGCD() then
        return true
    end
end