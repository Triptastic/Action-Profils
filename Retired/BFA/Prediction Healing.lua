-------------------------------
-- Resto Shaman PredictHeal --
-------------------------------
local TMW 									    = TMW
local CNDT									    = TMW.CNDT
local Env 								     	= CNDT.Env
local A     									= Action
local Listener									= Action.Listener
local Create									= Action.Create
local GetToggle									= Action.GetToggle
local SetToggle									= Action.SetToggle
local GetGCD									= Action.GetGCD
local GetCurrentGCD								= Action.GetCurrentGCD
local GetPing									= Action.GetPing
local ShouldStop								= Action.ShouldStop
local BurstIsON									= Action.BurstIsON
local AuraIsValid								= Action.AuraIsValid
local InterruptIsValid							= Action.InterruptIsValid
local FrameHasSpell								= Action.FrameHasSpell
local IsSpellInRange                            = A.IsSpellInRange
local Azerite									= LibStub("AzeriteTraits")
local Utils										= Action.Utils
local TeamCache									= Action.TeamCache
local EnemyTeam									= Action.EnemyTeam
local FriendlyTeam								= Action.FriendlyTeam
local LoC										= Action.LossOfControl
local Player									= Action.Player 
local MultiUnits								= Action.MultiUnits
local UnitCooldown								= Action.UnitCooldown
local Unit										= Action.Unit 
local IsUnitEnemy								= Action.IsUnitEnemy
local IsUnitFriendly							= Action.IsUnitFriendly
local HealingEngine                             = Action.HealingEngine
local ActiveUnitPlates							= MultiUnits:GetActiveUnitPlates()
local _G, setmetatable							= _G, setmetatable
local IsIndoors, UnitIsUnit                     = IsIndoors, UnitIsUnit
local TR                                        = Action.TasteRotation
local pairs                                     = pairs
local Pet                                       = LibStub("PetLibrary")
local next, pairs, type, print                  = next, pairs, type, print
local wipe                                      = wipe 
local math_floor                                = math.floor
local math_ceil                                 = math.ceil
local tinsert                                   = table.insert 
local _G, setmetatable                          = _G, setmetatable
local select, unpack, table, pairs              = select, unpack, table, pairs 
local CombatLogGetCurrentEventInfo              = _G.CombatLogGetCurrentEventInfo
local UnitGUID, UnitIsUnit, UnitDamage, UnitAttackSpeed, UnitAttackPower = UnitGUID, UnitIsUnit, UnitDamage, UnitAttackSpeed, UnitAttackPower

function A:PredictHeal(SPELLID, UNIT, VARIATION)    
    -- Exception penalty for low level units / friendly boss
    local UnitLvL = Unit(UNIT):GetLevel()
    if UnitLvL > 0 and UnitLvL < Unit("player"):GetLevel() - 10 then
        return true, 0
    end     
    
    -- Header
    local variation = (VARIATION and (VARIATION / 100)) or 1        
    local total, mastery = 0, 1
	local deephealing = 0
	local UnitHP = Unit(UNIT):HealthPercent() / 100 or 0
    local DMG, HPS = Unit(UNIT):GetDMG(), Unit(UNIT):GetHEAL()      
    local DifficultHP = Unit(UNIT):HealthMax() - Unit(UNIT):Health() 
    
    -- Shaman Mastery Calculate Deep Healing
    if Unit("player"):HasSpec(264) then
        local bonus = GetMasteryEffect()        
		mastery = bonus / 100
		deephealing = (1 + mastery * (1 - UnitHP))
    end
    
    -- Healing Surge
    if SPELLID == "HealingSurge" then        
        local pre_heal = UnitGetIncomingHeals(UNIT) or 0
        local cast = Unit("player"):CastTime(8004) + A.GetCurrentGCD()
        local HealingSurge = A.GetSpellDescription(8004)[1] * deephealing * variation
        total = HealingSurge + pre_heal + (HPS * cast) -- - (DMG*cast)           
    end 
 
    -- Healing Wave
    if SPELLID == "HealingWave" then        
        local pre_heal = UnitGetIncomingHeals(UNIT) or 0
        local cast = Unit("player"):CastTime(77472) + A.GetCurrentGCD()
        local HealingWave = A.GetSpellDescription(77472)[1] * deephealing * variation
        total = HealingWave + pre_heal + (HPS * cast) -- - (DMG*cast)           
    end
 
    -- Riptide 
    if SPELLID == "Riptide" then    
	    local pre_heal = UnitGetIncomingHeals(UNIT) or 0
        total = A.GetSpellDescription(61295)[2] * deephealing * variation
		local Riptide = A.GetSpellDescription(61295)
            
        total = (Riptide[1] * variation * deephealing) + (Riptide[2] * variation * 1.7) + pre_heal
    end 
	
    -- UnleashLife
    if SPELLID == "UnleashLife" then    
        total = A.GetSpellDescription(73685)[1] * deephealing * variation
    end 

    -- HealingStreamTotem
    if NAME == "HealingStreamTotem" then
        if Unit("player"):CombatTime() == 0 then
            total = 0
        else
            local pre_heal = Unit(UNIT):GetIncomingHeals() or 0
            local HealingStreamTotem = A.GetSpellDescription(5394)
            
            total = (HealingStreamTotem[1] * variation * deephealing) + (HealingStreamTotem[2] * variation * 1.7) + pre_heal -- + (HPS*12) - (DMG*12)
        end
    end    
	
	-- HealingTideTotem
    if NAME == "HealingTideTotem" then
        if Unit("player"):CombatTime() == 0 then
            total = 0
        else
            local pre_heal = Unit(UNIT):GetIncomingHeals() or 0
            local HealingTideTotem = A.GetSpellDescription(108280)
            
            total = (HealingTideTotem[1] * variation * deephealing) + (HealingTideTotem[2] * variation * 1.7) + pre_heal -- + (HPS*12) - (DMG*12)
        end
    end 
	
    -- EarthShield	
    if SPELLID == "EarthShield" then  
        if (Unit("player"):CombatTime() == 0 or Unit(UNIT):GetRealTimeDMG() == 0) and
        A.Zone ~= "arena" then -- exception, for arena always pre buff
            total = 88888888888888
        elseif Unit("player"):CombatTime() == 0 and A.Zone == "arena" then
            total = 0
        else
            local pre_heal = Unit(UNIT):GetIncomingHeals() or 0        
            local EarthShield = A.GetSpellDescription(974)[1] * deephealing * variation
            total = EarthShield + pre_heal + (HPS*5) -- - (DMG*5)         
        end 
    end
        
    -- Racials
    if SPELLID == "GiftofNaaru" then
        local pre_heal = Unit(UNIT):GetIncomingHeals() or 0
        total = UnitHealthMax("player") * 0.2 * variation + (HPS*5) + pre_heal - (DMG*5)
    end 
    
    return DifficultHP >= total, total
end

