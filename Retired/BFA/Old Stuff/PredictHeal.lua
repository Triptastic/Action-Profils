-------------------------------
-- Holy Paladin PredictHeal --
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
    local DMG, HPS = Unit(UNIT):GetDMG(), Unit(UNIT):GetHEAL()      
    local DifficultHP = Unit(UNIT):HealthMax() - Unit(UNIT):Health() 
    
    -- Holy Paladin Mastery Calculate
    if Unit("player"):HasSpec(65) then
        local c_range, m_range = Unit(UNIT):GetRange(), 40
        local bonus = GetMasteryEffect()
        if Unit("player"):HasBuffs(214202, "player", true) > 0 then
            m_range = 60
        end
        
        mastery = (bonus - ( bonus / m_range * c_range )) / 100 + 1
    end
    
    -- Spells
    if SPELLID == "FlashofLight" then        
        local pre_heal = UnitGetIncomingHeals(UNIT) or 0
        local cast = Unit("player"):CastTime(19750) + A.GetCurrentGCD()
        local FlashLight = A.GetSpellDescription(19750)[1] * mastery * variation
        total = FlashLight + pre_heal + (HPS * cast) -- - (DMG*cast)           
    end 
    
    -- Holy
    if SPELLID == "HolyShock" then    
        total = A.GetSpellDescription(20473)[1] * mastery * variation
    end 
    
    if SPELLID == "LightofDawn" then               
        total = A.GetSpellDescription(85222)[1] * mastery * variation        
    end 
    
    if SPELLID == "LightofMartyr" then               
        total = A.GetSpellDescription(183998)[1] * mastery * variation       
    end 
    
    if SPELLID == "HolyPrism" then               
        total = A.GetSpellDescription(114165)[1] * mastery * variation       
    end 
    
    if SPELLID == "HolyPrismAoE" then               
        total = A.GetSpellDescription(114165)[3] * mastery * variation       
    end 
    
    if SPELLID == "HolyLight" then          
        local pre_heal = UnitGetIncomingHeals(UNIT) or 0
        local cast = Unit("player"):CastTime(82326) + A.GetCurrentGCD()
        local HolyLight = A.GetSpellDescription(82326)[1] * mastery * variation
        total = HolyLight + pre_heal + (HPS*cast) - (DMG*cast) 
    end 
    
    if SPELLID == "HammerofLight" then  
        local pre_heal = UnitGetIncomingHeals(UNIT) or 0        
        local HammerofLight = A.GetSpellDescription(114158)[2] / 2 * mastery * 14 * variation
        total = HammerofLight + pre_heal + (HPS*14) - (DMG*14)         
    end 
    
    if SPELLID == "BestowFaith" then  
        if (Unit("player"):CombatTime() == 0 or Unit(UNIT):GetRealTimeDMG() == 0) and
        A.Zone ~= "arena" then -- exception, for arena always pre buff
            total = 88888888888888
        elseif Unit("player"):CombatTime() == 0 and A.Zone == "arena" then
            total = 0
        else
            local pre_heal = UnitGetIncomingHeals(UNIT) or 0        
            local BestowFaith = A.GetSpellDescription(223306)[1] * mastery * variation
            total = BestowFaith + pre_heal + (HPS*5) -- - (DMG*5)         
        end 
    end
    
    -- Protection
    if SPELLID == "LightOfProtector" then 
        local bonus_heal = (200 - (200 / Unit(UNIT):HealthMax() * Unit(UNIT):Health())) / 100 + 1
        local LightOfProtector = 0
        if A.IsSpellLearned(213652) then
            LightOfProtector = A.GetSpellDescription(213652)[1] * bonus_heal * variation
        else
            LightOfProtector = A.GetSpellDescription(184092)[1] * bonus_heal * variation
        end        
        total = LightOfProtector
    end 
    
    -- All 
    -- These spells doesn't relative for increasing heal buffs
    if SPELLID == "LayonHands" then
        total = UnitHealthMax("player")
    end 
    
    -- Racials
    if SPELLID == "GiftofNaaru" then
        local pre_heal = UnitGetIncomingHeals(UNIT) or 0
        total = UnitHealthMax("player") * 0.2 * variation + (HPS*5) + pre_heal - (DMG*5)
    end 
    
    return DifficultHP >= total, total
end

