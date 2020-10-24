local unit                          = thisobj.Unit
local A 							= Action
local InstanceInfo					= A.InstanceInfo
local TeamCache						= A.TeamCache
local HealingEngine					= A.HealingEngine
local LoC							= A.LossOfControl
local MultiUnits					= A.MultiUnits
local Player						= A.Player
local Unit 							= A.Unit 
local EnemyTeam						= A.EnemyTeam
local FriendlyTeam					= A.FriendlyTeam
local GetSpellInfo					= A.GetSpellInfo
local IsSpellInRange				= A.IsSpellInRange
local GetAuraList					= A.GetAuraList
local GetPing						= A.GetPing
local GetGCD						= A.GetGCD
local GetCurrentGCD					= A.GetCurrentGCD
local SimulacrumSettings            = A.GetToggle(2, "SimulacrumSettings")

-- General
local DKBurstBuffs = {
    [252] = {207289}, -- Unholy
    [251] = {51271, 152279, 47568}, -- Frost
    [250] = {81256}, -- Blood
}

local function Gargoyle()
    local have, name, start, duration = GetTotemInfo(3)
    return duration and duration ~= 0 and (duration - (TMW.time - start)) or 0
end

local function MyBurstBuffs()
    return 
    (
        -- Unholy
        A.PlayerSpec == 252 and 
        (
            -- Unholy Frenzy
            not A.IsSpellLearned(207289) and        
            -- Gargoyle
            (
                not A.IsSpellLearned(49206) or 
                Gargoyle() > 0 
            )
        )
    ) or
    Unit("player"):HasBuffs(DKBurstBuffs[A.PlayerSpec], true) > 0 or    
    Unit("player"):HasBuffs("BurstHaste") > 0
end

-- Markers
A.Simulacrum_Mark = {}
function SetMarkSimulacrum(unit)
    if unit and UnitExists(unit) then 
        if A.Simulacrum_Mark[UnitGUID(unit)] then 
            A.Simulacrum_Mark[UnitGUID(unit)] = nil 
            print("[DK] Toggle Simulacrum UNMarked: " .. UnitName(unit))
        else 
            A.Simulacrum_Mark[UnitGUID(unit)] = true
            print("[DK] Toggle Simulacrum Marked: " .. UnitName(unit))            
        end 
    end
end
-- SetMarkSimulacrum("target") -- To Call from macro   

return
A.IsSpellInRange(77606, unit) and
-- Dark simulacrum
Unit(unit):HasDeBuffs(77606, true) == 0 and
(
    -- Exception Mass dispel
    select(2, CastTime(32375, unit)) > 0 or
    -- Just kick everything as latest available kick option
    SimulacrumSettings == "EVERYTHING" or
    -- Close channeling CC on friendly healer
    (        
        SimulacrumSettings == "CHAIN CC" and        
        FriendlyTeam("HEALER"):GetCC() > 0 and
        FriendlyTeam("HEALER"):GetCC() <= 1.5
    ) or
    -- Close CC if we trying burst target or someone dying
    (        
        SimulacrumSettings == "DEFF AGRESS" and
        (
            -- AGRESSIVE
            MyBurstBuffs() or
            Unit(unit):UseBurst()  or
            (
                Unit(unit):IsEnemy() and
                Unit(unit):IsPlayer() and
                (
                    Unit(unit):HealthPercent() < 60 or
                    Unit(unit):TimeToDie() < 6                    
                )
            ) or
            -- DEFFENSIVE
            (                
                FriendlyTeam("HEALER"):GetCC() == 0 and
                not Unit(unit):IsEnemy() and
                Unit(unit):IsPlayer() and
                Unit(unit):HealthPercent() <= 70 and
                (
                    Unit(unit):HasBuffs("DeffBuffs") > 5 or
                    Unit(unit):TimeToDie() <= 6 or
                    Unit(unit):HealthPercent() <= 65
                )
            ) or
            (
                FriendlyTeam("HEALER"):GetCC() == 0 and
                Unit("player"):UseDeff() 
            ) or            
            (
                FriendlyTeam("HEALER"):GetCC() > 0 and
                FriendlyTeam("HEALER"):GetCC() <= 1.6
            )
        )
    ) or
    -- Only use for specified unit
    (
        SimulacrumSettings == "MARKED" and
        Simulacrum_Mark[UnitGUID(unit)]    
    ) 
) and
Unit(unit):HasBuffs("TotalImun") == 0
Unit(unit):HasBuffs("DamageMagicImun") == 0
Unit(unit):HasBuffs("Reflect") == 0


