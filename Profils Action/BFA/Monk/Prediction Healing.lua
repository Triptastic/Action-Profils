local TMW                             = TMW
local A                             = Action
local Unit                             = A.Unit 

local MW                             = A[ACTION_CONST_MONK_MISTWEAVER]

function A:PredictHeal(NAME, UNIT, VARIATION)   
    -- Exception penalty for low level units
    local UnitLvL = Unit(UNIT):GetLevel()
    if UnitLvL > 0 and UnitLvL < Unit("player"):GetLevel() - 10 then
        return true, 0
    end     
    
    -- Header
    local variation = (VARIATION and (VARIATION / 100)) or 1  
    local LifeCocoon_variation, LifeCocoon_duration = 1, 0
    local EnvelopingMist_variation, EnvelopingMist_duration = 1, 0
    if Unit("player"):HasSpec(ACTION_CONST_MONK_MISTWEAVER) then 
        -- +50% (only hots)
        LifeCocoon_duration = Unit(UNIT):HasBuffs(self.ID, true) 
        if LifeCocoon_duration > 0 then 
            LifeCocoon_variation = 1.5
        end         
        -- +30% 
        EnvelopingMist_duration = Unit(UNIT):HasBuffs(MW.EnvelopingMist.ID, true) 
        if EnvelopingMist_duration > 0 then 
            EnvelopingMist_variation = 1.3
        end 
    end 
    
    local total = 0
    local DMG = Unit(UNIT):GetDMG()
    local HPS = Unit(UNIT):GetHEAL()      
    local DifficultHP = Unit(UNIT):HealthDeficit()
    
    -- Spells
    -- Shared     
    if NAME == "Vivify" then   
        local description = self:GetSpellDescription()
        
        local RenewingMist = 0
        if Unit("player"):HasSpec(ACTION_CONST_MONK_MISTWEAVER) then 
            local isSoothingMistCasting = Unit(UNIT):HasBuffs(MW.SoothingMist.ID, true) > 0 and Unit("player"):IsCastingRemains(MW.SoothingMist.ID) > 0
            if Unit(UNIT):HasBuffs(MW.RenewingMist.ID, true) > 0 then 
                RenewingMist = description[2]
            end 
        end
        
        local pre_heal = (isSoothingMistCasting and 0) or Unit(UNIT):GetIncomingHeals()    
        local cast = (isSoothingMistCasting and 0) or (Unit("player"):CastTime(self.ID) + A.GetCurrentGCD())
        total = (description[1] + RenewingMist) * EnvelopingMist_variation * variation + pre_heal + (HPS * cast) - (DMG * cast) 
    end 
    
    if NAME == "ChiBurst" then 
        local pre_heal = Unit(UNIT):GetIncomingHeals()  
        local cast = Unit("player"):CastTime(self.ID) + A.GetCurrentGCD()
        total = self:GetSpellDescription()[1] * EnvelopingMist_variation * variation + pre_heal + (HPS * cast) - (DMG * cast)
    end 
    
    if NAME == "ChiWave" then 
        total = self:GetSpellDescription()[1] * EnvelopingMist_variation * variation 
    end 
    
    -- BrewMaster
    if NAME == "ExpelHarm" then        
        total = self:GetCount() * A.GetSpellDescription(124502)[1] * variation           
    end 
    
    -- Mistweaver 
    if NAME == "Revival" then 
        total = self:GetSpellDescription()[1] * EnvelopingMist_variation * variation
    end 
    
    if NAME == "InvokeChiJitheRedCrane" then 
        total = self:GetSpellDescription()[1] * EnvelopingMist_variation * variation
    end 
    
    if NAME == "EssenceFont" then 
        local pre_heal = Unit(UNIT):GetIncomingHeals()  or 0
        local description = self:GetSpellDescription()
        local cast_time = description[6] or 0
        local duration = description[4] or 0
        local tick = description[1] or 0
        local hot_tick = description[2] / duration
        local counter_ticks = math.ceil(cast_time / 0.9)
        local summary_hot_ticks = hot_tick * 0.9 * counter_ticks
        local cached_summary_hot_ticks = summary_hot_ticks
        if LifeCocoon_duration > 0 then 
            if LifeCocoon_duration >= cast_time then 
                LifeCocoon_duration = cast_time
            end 
            summary_hot_ticks = (cached_summary_hot_ticks / cast_time * (cast_time - LifeCocoon_duration)) + (cached_summary_hot_ticks / cast_time * LifeCocoon_variation * LifeCocoon_duration)
        end 
        if EnvelopingMist_duration > 0 then 
            if EnvelopingMist_duration >= cast_time then 
                EnvelopingMist_duration = cast_time
            end 
            summary_hot_ticks = summary_hot_ticks + ((cached_summary_hot_ticks / cast_time * (cast_time - EnvelopingMist_duration)) + (cached_summary_hot_ticks / cast_time * EnvelopingMist_variation * EnvelopingMist_duration) - summary_hot_ticks)
        end 
        -- While casting
        local summary = (tick * EnvelopingMist_variation * counter_ticks) + summary_hot_ticks
        -- After casting
        local remain_duration = duration - cast_time
        local summary_remain_hot = hot_tick * remain_duration 
        if LifeCocoon_duration - cast_time > 0 then 
            LifeCocoon_duration = LifeCocoon_duration - cast_time
            if LifeCocoon_duration >= remain_duration then 
                LifeCocoon_duration = remain_duration
            end 
            summary_remain_hot = (hot_tick * (remain_duration - LifeCocoon_duration)) + (hot_tick * LifeCocoon_variation * LifeCocoon_duration)
        end 
        if EnvelopingMist_duration - cast_time > 0 then 
            EnvelopingMist_duration = EnvelopingMist_duration - cast_time
            if EnvelopingMist_duration >= remain_duration then 
                EnvelopingMist_duration = remain_duration
            end 
            summary_remain_hot = summary_remain_hot + ((hot_tick * (remain_duration - EnvelopingMist_duration)) + (hot_tick * EnvelopingMist_variation * EnvelopingMist_duration) - summary_remain_hot)
        end         
        
        local cast = cast_time + A.GetCurrentGCD()
        total = (summary + summary_remain_hot) * variation + pre_heal + (HPS * cast) - (DMG * cast)     
    end 
    
    if NAME == "EnvelopingMist" then 
        local isSoothingMistCasting = Unit(UNIT):HasBuffs(MW.SoothingMist.ID, true) > 0 and Unit("player"):IsCastingRemains(MW.SoothingMist.ID) > 0
        local pre_heal = (isSoothingMistCasting and 0) or Unit(UNIT):GetIncomingHeals()  
        local cast = (isSoothingMistCasting and 0) or (Unit("player"):CastTime(self.ID) + A.GetCurrentGCD())
        local ThunderFocusTea_extraheal = 0
        if Unit("player"):HasBuffs(MW.ThunderFocusTea.ID, true) > 0 then 
            ThunderFocusTea_extraheal = MW.ThunderFocusTea:GetSpellDescription()[1]
        end 
        local description = self:GetSpellDescription()
        local summary = description[1]
        local duration = 6 -- description[2]
        if LifeCocoon_duration > 0 then 
            if LifeCocoon_duration >= duration then 
                LifeCocoon_duration = duration
            end 
            summary = (description[1] / duration * (duration - LifeCocoon_duration)) + (description[1] / duration * LifeCocoon_variation * LifeCocoon_duration)
        end 
        total = (summary + ThunderFocusTea_extraheal) * variation + pre_heal + (HPS * (cast + duration)) - (DMG * (cast + duration))
    end 
    
    if NAME == "SurgingMist" then 
        local isSoothingMistCasting = Unit(UNIT):HasBuffs(MW.SoothingMist.ID, true) > 0 and Unit("player"):IsCastingRemains(MW.SoothingMist.ID) > 0
        local pre_heal = (isSoothingMistCasting and 0) or Unit(UNIT):GetIncomingHeals() 
        local cast = (isSoothingMistCasting and 0) or (Unit("player"):CastTime(self.ID) + A.GetCurrentGCD())
        local multiplier = 1
        if Unit(UNIT):HasBuffs(self.ID, true) > cast then 
            local stacks = Unit(UNIT):HasBuffsStacks(self.ID, true)
            if stacks == 1 then 
                multiplier = 1.5
            elseif stacks >= 2 then 
                multiplier = 2
            end
        end 
        if EnvelopingMist_duration <= cast then 
            EnvelopingMist_variation = 1
        end 
        total = self:GetSpellDescription()[1] * multiplier * EnvelopingMist_variation * variation + pre_heal + (HPS * cast) - (DMG * cast) 
    end 
    
    if NAME == "RefreshingJadeWind" then 
        local description = self:GetSpellDescription()
        local duration = description[3]
        local pre_heal = Unit(UNIT):GetIncomingHeals()
        total = description[1] * EnvelopingMist_variation * variation + pre_heal + (HPS * duration) - (DMG * duration)
    end     
    
    if NAME == "RenewingMist" then 
        local description = self:GetSpellDescription()
        local duration = description[2]
        local summary = description[1]
        if LifeCocoon_duration > 0 then 
            if LifeCocoon_duration >= duration then 
                LifeCocoon_duration = duration
            end 
            summary = (description[1] / duration * (duration - LifeCocoon_duration)) + (description[1] / duration * LifeCocoon_variation * LifeCocoon_duration)
        end 
        if EnvelopingMist_duration > 0 then 
            if EnvelopingMist_duration >= duration then 
                EnvelopingMist_duration = duration
            end 
            summary = summary + ( (description[1] / duration * (duration - EnvelopingMist_duration)) + (description[1] / duration * EnvelopingMist_variation * EnvelopingMist_duration) - summary )
        end 
        total = summary * variation + (HPS * duration) - (DMG * duration)
    end 
    
    -- Not really neccessary to predict
    if NAME == "SoothingMist" then 
        local pre_heal = Unit(UNIT):GetIncomingHeals()           
        local description = self:GetSpellDescription()
        local duration = description[2]
        local summary = description[1]
        local cast = duration + A.GetCurrentGCD()
        if LifeCocoon_duration > 0 then 
            if LifeCocoon_duration >= duration then 
                LifeCocoon_duration = duration
            end 
            summary = (description[1] / duration * (duration - LifeCocoon_duration)) + (description[1] / duration * LifeCocoon_variation * LifeCocoon_duration)
        end 
        if EnvelopingMist_duration > 0 then 
            if EnvelopingMist_duration >= duration then 
                EnvelopingMist_duration = duration
            end 
            summary = summary + ( (description[1] / duration * (duration - EnvelopingMist_duration)) + (description[1] / duration * EnvelopingMist_variation * EnvelopingMist_duration) - summary )
        end 
        total = summary * variation + pre_heal + (HPS * cast) - (DMG * cast)    
    end 
    
    return DifficultHP >= total, total
end

