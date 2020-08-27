local TMW                             = TMW
local A                             = Action
local Unit                             = A.Unit 
local TeamCache                                = Action.TeamCache
local EnemyTeam                                = Action.EnemyTeam
local FriendlyTeam                            = Action.FriendlyTeam
local HealingEngine                            = Action.HealingEngine
local LoC                                     = Action.LossOfControl
local Player                                = Action.Player 
local MultiUnits                            = Action.MultiUnits
local UnitCooldown                            = Action.UnitCooldown
local RESTO                           = A[ACTION_CONST_DRUID_RESTORATION]

function A:PredictHeal(NAME, UNIT, VARIATION)   
    -- Exception penalty for low level units
    local UnitLvL = Unit(UNIT):GetLevel()
    if UnitLvL > 0 and UnitLvL < Unit("player"):GetLevel() - 10 then
        return true, 0
    end          
    
    -- Header
    local variation = (VARIATION and (VARIATION / 100)) or 1    
    
    local total = 0
    local DMG = Unit(UNIT):GetDMG()
    local HPS = Unit(UNIT):GetHEAL()      
    local DifficultHP = Unit(UNIT):HealthDeficit() 
    
    -- Frenzied Regeneration
    if NAME == "Frenzied Regeneration" then
        local pre_heal = Unit(UNIT):GetIncomingHeals() or 0
        local multifier = 1
        if Unit("player"):HasSpec(ACTION_CONST_DRUID_RESTORATION) and Unit(UNIT):HasBuffs(213680, true) > 0 then
            multifier = 1.2
        end
        total = (Unit(UNIT):HealthMax() * 0.24) * multifier + (HPS * 3) + pre_heal - (DMG * 3)
    end
    
	-- Swiftmend
    if NAME == "Swiftmend" then
        total = A.GetSpellDescription(18562)[1] * variation
    end
    
	-- Rejuvenation
    if NAME == "Rejuvenation" then       
        if Unit("player"):CombatTime() == 0 then
            total = 0
        else
            local pre_heal = Unit(UNIT):GetIncomingHeals() or 0
            local hot = 1
            if Unit("player"):HasSpec(ACTION_CONST_DRUID_RESTORATION) and -- Restor
            -- Talent Soul of Forest
            Unit(UNIT):HasBuffs(114108, true) > 0 then               
                hot = 2
            end
            total = A.GetSpellDescription(774)[1] * variation * hot + (HPS * 15) + pre_heal -- - (DMG*15)
        end
    end    
    
    if NAME == "Regrowth" then
	    --local Regrowth = 8936
        if Unit("player"):CombatTime() == 0 then
            total = 0
        else
            local pre_heal = Unit(UNIT):GetIncomingHeals() or 0
            local Regrowth = A.GetSpellDescription(8936)
            local crit, hot = 1, 1
            if Unit("player"):HasSpec(ACTION_CONST_DRUID_RESTORATION) and -- Balance
            not UnitIsUnit("player", UNIT) then
                crit = 2
            end
            if Unit("player"):HasSpec(ACTION_CONST_DRUID_RESTORATION) and -- Restor
            -- Talent Soul of Forest
            Unit(UNIT):HasBuffs(114108, true) > 0 then
                crit = 2
                hot = 2
            end
            
            total = (Regrowth[1] * variation * crit) + (Regrowth[2] * variation * hot) + pre_heal -- + (HPS*12) - (DMG*12)
        end
    end
    
    if NAME == "Lunar Beam" then
        if Unit("player"):CombatTime() == 0 then
            total = 0
        else
            local pre_heal = Unit(UNIT):GetIncomingHeals() or 0
            total = A.GetSpellDescription(204066)[1] * variation + (HPS * 8) + pre_heal - (DMG * 8)
        end
    end
    
    if NAME == "Wild Growth" then
	    --local WildGrowth = 48438
        if Unit("player"):CombatTime() == 0 then
            total = 0
        else
            local pre_heal = Unit(UNIT):GetIncomingHeals() or 0
            local WildGrowth = A.GetSpellDescription(48438)
            local hot = 1        
            if Unit("player"):HasSpec(ACTION_CONST_DRUID_RESTORATION) and -- Restor
            -- Talent Soul of Forest
			Unit(UNIT):HasBuffs(114108, true) > 0 then
                hot = 1.75
            end
            
            total = WildGrowth[1] * variation * hot + pre_heal + (HPS * 7) -- - (DMG*7)
        end
    end
    
    if NAME == "Lifebloom" then 
        if Unit("player"):CombatTime() == 0 then
            total = 0
        else
            local pre_heal = Unit(UNIT):GetIncomingHeals() or 0
            total = A.GetSpellDescription(33763)[1] * variation + pre_heal + (HPS * 15) -- - (DMG*15)
        end
    end
    
    if NAME == "Cenarion Ward" then 
        if (Unit("player"):CombatTime() == 0 or Unit(UNIT):GetRealTimeDMG() == 0) and
        select(2, IsInInstance()) == "arena" then -- exception, for arena always pre buff
            total = 88888888888888
        else
            local pre_heal = Unit(UNIT):GetIncomingHeals() or 0
            if Unit("player"):CombatTime() == 0 then
                total = 0
            else
                total = A.GetSpellDescription(102351)[1] * variation + (HPS * 8) + pre_heal -- - (DMG*8)
            end
            
        end
    end
    
    if NAME == "Tranquility" then 
        if Unit("player"):CombatTime() == 0 then
            total = 88888888888888 -- don't use out of combat
        else
            local pre_heal = Unit(UNIT):GetIncomingHeals() or 0
            local raid_hot = 1
            if IsInRaid() then
                raid_hot = 2
            end
            total = A.GetSpellDescription(740)[1] + (A.GetSpellDescription(740)[2] * 5 * raid_hot) + pre_heal + (HPS * 15.1) - (DMG * 15.1)
        end
    end    
    
    if NAME == "Efflorescence" then 
        local pre_heal = Unit(UNIT):GetIncomingHeals() or 0
        local flowers = 0
		--local Efflorescence = 207385
        --if Efflorescence:IsAvailable() then
        --    flowers = A.GetSpellDescription(207385)[1] * variation
        --end
        total = A.GetSpellDescription(145205)[1] / 1.8 * 30 + flowers + pre_heal -- + (HPS*30) - (DMG*30)
    end    
    
    if NAME == "Overgrowth" then 
        if Unit("player"):CombatTime() == 0 then
            total = 88888888888888 -- don't use out of combat
        else
            -- REFRESH ABLE: Wild growth and Lifebloom
            if Unit(UNIT):HasDeBuffs(48438) < 3 and Unit(UNIT):HasDeBuffs(48438) < 3 then 
                local SoulOfForest = Unit(UNIT):HasBuffs(114108, true) > 0
                local pre_heal = Unit(UNIT):GetIncomingHeals() or 0
                -- LifeBloom 15sec
                local LB = A.GetSpellDescription(33763)[1]
                total = A.GetSpellDescription(33763)[1]
                -- Wild Growth 7 sec
                local WG = A.GetSpellDescription(48438)[1]                  
                if SoulOfForest then                    
                    WG = WG * 1.75
                end
                -- Regrowth (hot) 12 sec
                local RG = A.GetSpellDescription(8936)[2]                
                if SoulOfForest then
                    RG = RG * 2
                end
                -- Rejuvenation 15 sec
                local RN = A.GetSpellDescription(774)[1]
                if SoulOfForest then
                    RN = RN * 2
                end
                -- Average heal dur: (15 + 15 + 12 + 7) / 4 = 12.25
                total = pre_heal + RG + WG + LB + RN + (HPS * 12.25) - (DMG * 12.25)
            else 
                total = 88888888888888 -- skip
            end
        end
    end
    
    -- 8.1 PvP
    if NAME == "Nourish" then
        if Unit("player"):CombatTime() == 0 then
            total = 0
        else
            local pre_heal = Unit(UNIT):GetIncomingHeals() or 0
            local Nourish = A.GetSpellDescription(289022) * variation
            local cast = Unit(unitID):CastTime(289022) + A.GetCurrentGCD() + 0.2
            local crit = 1
            if TimeToDie(UNIT) <= cast * 2.6 then
                total = 88888888888888 -- don't heal if we can lose unit
            else
                if 
                -- Rejuvenation
                Unit(UNIT):HasBuffs(774, true) >= cast and 
                -- Germination
                (
                    not RESTO.Germination:IsSpellLearned() or 
                    Unit(UNIT):HasBuffs(155777, true) >= cast
                ) and
                -- Lifebloom
				Unit(UNIT):HasBuffs(33763, true) > cast and
                -- Wild Growth
				Unit(UNIT):HasBuffs(48438, true) > cast and
                -- Regrowth
				Unit(UNIT):HasBuffs(8936, true) > cast
                then
                    crit = 2
                end
                
                total = (Nourish[1] * crit) + (HPS * cast) + pre_heal - (DMG * cast)
            end
        end
    end    
    
    return DifficultHP >= total, total
end

