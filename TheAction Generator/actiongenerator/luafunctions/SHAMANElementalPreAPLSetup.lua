------------------------------------------
-------- ELEMENTAL PRE APL SETUP ---------
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

-- API - Tracker
-- Initialize Tracker 
Pet:AddTrackers(ACTION_CONST_SHAMAN_ENCHANCEMENT, { -- this template table is the same with what has this library already built-in, just for example
    [77942] = {
        name = "Primal Storm Elemental",
        duration = 30,
    },
})

-- Function to check for Infernal duration
local function PrimalStormElementalTime()
    return Pet:GetRemainDuration(77942) or 0
end 

local function StormElementalIsActive()
    if PrimalStormElementalTime() > 0 then
        return true
    else
        return false
    end
end

local function ResonanceTotemTime()
    for index = 1, 4 do
        local _, totemName, startTime, duration = GetTotemInfo(index)
        if totemName == A.TotemMastery:Info() then
            return (floor(startTime + duration - TMW.time + 0.5)) or 0
        end
    end
    return 0
end

local function FutureMaelstromPower()
    local castName, castStartTime, castEndTime, notInterruptable, spellID, isChannel = Unit("player"):IsCasting()
    local castLeft, _, _, _, notKickAble = Unit("player"):IsCastingRemains()
    local MaelstromPower = Player:Maelstrom()
    local overloadChance = Player:MasteryPct() / 100
    local factor = 1 + 0.75 * overloadChance
    local resonance = 0
    
    if Unit("player"):CombatTime() > 0 then
        if A.TotemMastery:IsReady("player") then
            resonance = castLeft
        end
        if not castLeft then
            return MaelstromPower
        else
            if spellID == A.LightningBolt.ID then
                return MaelstromPower + 8 + resonance
            elseif spellID == A.LavaBurst.ID then
                return MaelstromPower + 10 + resonance
            elseif spellID == A.ChainLightning.ID then
                local enemiesHit = min(MultiUnits:GetActiveEnemies(), 3)
                return MaelstromPower + 4 * enemiesHit * factor + resonance
            elseif spellID == A.Icefury.ID then
                return MaelstromPower + 25 * factor + resonance
            else
                return MaelstromPower
            end
        end
    end
end

local function HandleAncestralGuidance()
    local choice = Action.GetToggle(2, "AncestralGuidanceSelection")
    
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

-- Multidot Handler UI --
local function HandleMultidots()
    local choice = Action.GetToggle(2, "AutoDotSelection")
    
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

-- Stormkeeper Handler UI --
local function HandleStormkeeper()
    local choice = A.GetToggle(2, "StormkeeperMode")
    --print(choice) 
    local unit = "target"
    -- CDs ON
    if choice[1] then 
        -- also checks AoE
        if choice[2] then
            return (A.BurstIsON(unit) and MultiUnits:GetActiveEnemies() > 2 and A.GetToggle(2, "AoE")) or false
        else
            return (A.BurstIsON(unit)) or false
        end
        -- AoE Only
    elseif choice[2] then
        -- also checks CDs
        if choice[1] then
            return (A.BurstIsON(unit) and MultiUnits:GetActiveEnemies() > 2 and A.GetToggle(2, "AoE")) or false
        else
            return (MultiUnits:GetActiveEnemies() > 2 and A.GetToggle(2, "AoE")) or false
        end
        -- Everytime
    elseif choice[3] then
        return A.Stormkeeper:IsReady(unit) or false
    else
        return false
    end
    
end

-- FlameShockTTD
local function HandleFlameShockTTD()
    local FlameShock = A.GetToggle(2, "FlameShockTTD")
    if     FlameShock >= 0 and 
    (
        (     -- Auto 
            FlameShock >= 100 and 
            (
                -- TTD > 15
                Unit("target"):TimeToDie() > 15
            ) 
        ) or 
        (    -- Custom
            FlameShock < 100 and 
            Unit("target"):HealthPercent() > FlameShock
        )
    ) 
    then 
        return true
    end
end

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

local function SelfDefensives()
    if Unit("player"):CombatTime() == 0 then 
        return 
    end 
    
    local unit
    if A.IsUnitEnemy("mouseover") then 
        unit = "mouseover"
    elseif A.IsUnitEnemy("target") then 
        unit = "target"
    end      
    
    -- EarthShieldHP
    local EarthShield = A.GetToggle(2, "EarthShieldHP")
    if     EarthShield >= 0 and A.EarthShield:IsReady("player") and  
    (
        (     -- Auto 
            EarthShield >= 100 and 
            (
                Unit("player"):HasBuffsStacks(A.EarthShield.ID, true) <= 3 
                or A.IsInPvP and Unit("player"):HasBuffsStacks(A.EarthShield.ID, true) <= 2
            ) 
        ) or 
        (    -- Custom
            EarthShield < 100 and 
            Unit("player"):HasBuffs(A.EarthShield.ID, true) <= 5 and 
            Unit("player"):HealthPercent() <= EarthShield
        )
    ) 
    then 
        return A.EarthShield
    end
    
    -- HealingSurgeHP
    local HealingSurge = A.GetToggle(2, "HealingSurgeHP")
    if     HealingSurge >= 0 and A.HealingSurge:IsReady("player") and 
    (
        (     -- Auto 
            HealingSurge >= 100 and 
            (
                -- HP lose per sec >= 40
                Unit("player"):GetDMG() * 100 / Unit("player"):HealthMax() >= 40 or 
                Unit("player"):GetRealTimeDMG() >= Unit("player"):HealthMax() * 0.40 or 
                -- TTD 
                Unit("player"):TimeToDieX(25) < 5 or 
                (
                    A.IsInPvP and 
                    (
                        Unit("player"):UseDeff() or 
                        (
                            Unit("player", 5):HasFlags() and 
                            Unit("player"):GetRealTimeDMG() > 0 and 
                            Unit("player"):IsFocused() 
                        )
                    )
                )
            ) and 
            Unit("player"):HasBuffs("DeffBuffs", true) == 0
        ) or 
        (    -- Custom
            HealingSurge < 100 and 
            Unit("player"):HealthPercent() <= HealingSurge
        )
    ) 
    then 
        return A.HealingSurge
    end
    
    -- Abyssal Healing Potion
    local AbyssalHealingPotion = A.GetToggle(2, "AbyssalHealingPotionHP")
    if     AbyssalHealingPotion >= 0 and A.AbyssalHealingPotion:IsReady("player") and 
    (
        (     -- Auto 
            AbyssalHealingPotion >= 100 and 
            (
                -- HP lose per sec >= 25
                Unit("player"):GetDMG() * 100 / Unit("player"):HealthMax() >= 25 or 
                Unit("player"):GetRealTimeDMG() >= Unit("player"):HealthMax() * 0.25 or 
                -- TTD 
                Unit("player"):TimeToDieX(25) < 5 or 
                (
                    A.IsInPvP and 
                    (
                        Unit("player"):UseDeff() or 
                        (
                            Unit("player", 5):HasFlags() and 
                            Unit("player"):GetRealTimeDMG() > 0 and 
                            Unit("player"):IsFocused() 
                        )
                    )
                )
            ) and 
            Unit("player"):HasBuffs("DeffBuffs", true) == 0
        ) or 
        (    -- Custom
            AbyssalHealingPotion < 100 and 
            Unit("player"):HealthPercent() <= AbyssalHealingPotion
        )
    ) 
    then 
        return A.AbyssalHealingPotion
    end  
    
    -- AstralShift
    local AstralShift = A.GetToggle(2, "AstralShiftHP")
    if     AstralShift >= 0 and A.AstralShift:IsReady("player") and 
    (
        (     -- Auto 
            AstralShift >= 100 and 
            (
                -- HP lose per sec >= 20
                Unit("player"):GetDMG() * 100 / Unit("player"):HealthMax() >= 20 or 
                Unit("player"):GetRealTimeDMG() >= Unit("player"):HealthMax() * 0.20 or 
                -- TTD 
                Unit("player"):TimeToDieX(25) < 5 or 
                (
                    A.IsInPvP and 
                    (
                        Unit("player"):UseDeff() or 
                        (
                            Unit("player", 5):HasFlags() and 
                            Unit("player"):GetRealTimeDMG() > 0 and 
                            Unit("player"):IsFocused() 
                        )
                    )
                )
            ) and 
            Unit("player"):HasBuffs("DeffBuffs", true) == 0
        ) or 
        (    -- Custom
            AstralShift < 100 and 
            Unit("player"):HealthPercent() <= AstralShift
        )
    ) 
    then 
        return A.AstralShift
    end     
    -- Stoneform on self dispel (only PvE)
    if A.Stoneform:IsRacialReady("player", true) and not A.IsInPvP and A.AuraIsValid("player", "UseDispel", "Dispel") then 
        return A.Stoneform
    end 
end 
SelfDefensives = A.MakeFunctionCachedStatic(SelfDefensives)

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