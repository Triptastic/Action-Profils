local TMW = TMW
local CNDT = TMW.CNDT
local Env = CNDT.Env

function Env.PredictHeal(SPELLID, UNIT, VARIATION)    
    -- Exception penalty for low level units / friendly boss
    local UnitLvL = Env.UNITLevel(UNIT)
    if UnitLvL > 0 and UnitLvL < Env.UNITLevel("player") - 10 then
        return true, 0
    end     
    
    -- Header
    local variation = (VARIATION and (VARIATION / 100)) or 1        
    local total, mastery = 0, 1
    local DMG, HPS = incdmg(UNIT), getHEAL(UNIT)      
    local DifficultHP = UnitHealthMax(UNIT) - UnitHealth(UNIT) 
    
    -- Holy Paladin Mastery Calculate
    if Env.UNITSpec("player", 65) then
        local c_range, m_range = Env.UNITRange(UNIT), 40
        local bonus = GetMasteryEffect()
        if Env.Buffs("player", 214202, "player") > 0 then
            m_range = 60
        end
        
        mastery = (bonus - ( bonus / m_range * c_range )) / 100 + 1
    end
    
    -- Spells
    if SPELLID == "FlashOfLight" then        
        local pre_heal = UnitGetIncomingHeals(UNIT) or 0
        local cast = Env.CastTime(19750) + Env.CurrentTimeGCD()
        local FlashLight = Env.GetDescription(19750)[1] * mastery * variation
        total = FlashLight + pre_heal + (HPS*cast) -- - (DMG*cast)           
    end 
    
    -- Holy
    if SPELLID == "HolyShock" then    
        total = Env.GetDescription(20473)[1] * mastery * variation
    end 
    
    if SPELLID == "LightofDawn" then               
        total = Env.GetDescription(85222)[1] * mastery * variation        
    end 
    
    if SPELLID == "LightofMartyr" then               
        total = Env.GetDescription(183998)[1] * mastery * variation       
    end 
    
    if SPELLID == "HolyPrism" then               
        total = Env.GetDescription(114165)[1] * mastery * variation       
    end 
    
    if SPELLID == "HolyPrismAoE" then               
        total = Env.GetDescription(114165)[3] * mastery * variation       
    end 
    
    if SPELLID == "HolyLight" then          
        local pre_heal = UnitGetIncomingHeals(UNIT) or 0
        local cast = Env.CastTime(82326) + Env.CurrentTimeGCD()
        local HolyLight = Env.GetDescription(82326)[1] * mastery * variation
        total = HolyLight + pre_heal + (HPS*cast) - (DMG*cast) 
    end 
    
    if SPELLID == "HammerofLight" then  
        local pre_heal = UnitGetIncomingHeals(UNIT) or 0        
        local HammerofLight = Env.GetDescription(114158)[2] / 2 * mastery * 14 * variation
        total = HammerofLight + pre_heal + (HPS*14) - (DMG*14)         
    end 
    
    if SPELLID == "BestowFaith" then  
        if (CombatTime("player") == 0 or getRealTimeDMG(UNIT) == 0) and
        Env.Zone ~= "arena" then -- exception, for arena always pre buff
            total = 88888888888888
        elseif CombatTime("player") == 0 and Env.Zone == "arena" then
            total = 0
        else
            local pre_heal = UnitGetIncomingHeals(UNIT) or 0        
            local BestowFaith = Env.GetDescription(223306)[1] * mastery * variation
            total = BestowFaith + pre_heal + (HPS*5) -- - (DMG*5)         
        end 
    end
    
    -- Protection
    if SPELLID == "LightOfProtector" then 
        local bonus_heal = (200 - (200 / UnitHealthMax(UNIT) * UnitHealth(UNIT))) / 100 + 1
        local LightOfProtector = 0
        if Env.TalentLearn(213652) then
            LightOfProtector = Env.GetDescription(213652)[1] * bonus_heal * variation
        else
            LightOfProtector = Env.GetDescription(184092)[1] * bonus_heal * variation
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

