local _G, math, error				= _G, math, error
local math_ceil						= math.ceil
local math_max						= math.max

local TMW 							= _G.TMW

local A 							= _G.Action
local CONST 						= A.Const
local HealingEngine					= Action.HealingEngine
local Unit 							= A.Unit 
local GetCurrentGCD					= A.GetCurrentGCD
local GetSpellDescription			= A.GetSpellDescription
local GetToggle						= A.GetToggle
local GetLatency					= A.GetLatency

local HealingEngineIsManaSave		= HealingEngine.IsManaSave

local RESTO 						= A[CONST.DRUID_RESTORATION]

local UnitIsUnit					= _G.UnitIsUnit


function A:PredictHeal(unitID, variation)  
	-- @usage obj:PredictHeal(unitID[, variation]) 
	-- @return boolean, number 
	-- Returns:
	-- [1] true if action can be used
	-- [2] total amount of predicted missed health 
	-- Any healing spell can be applied     
	if Unit(unitID):IsPenalty() then
        return true, 0
    end     
	
	local PO = GetToggle(8, "PredictOptions")
	-- PO[1] incHeal
	-- PO[2] incDMG
	-- PO[3] threat -- not usable in prediction
	-- PO[4] HoTs
	-- PO[5] absorbPossitive
	-- PO[6] absorbNegative
	local defaultVariation, isManaSave
	local variation = variation or 1
	if A.IamHealer and HealingEngineIsManaSave(unitID) then 
		isManaSave = true 
		defaultVariation = variation
		variation = math_max(variation - 1 + GetToggle(8, "ManaManagementPredictVariation"), 1)		
	end 
    
    -- Frenzied Regeneration
    if self.predictName == "FrenziedRegeneration" then
		local desc = self:GetSpellDescription()
		local castTime = self:GetSpellCastTime()
		
		-- Add current GCD to pre-pare 
		if castTime > 0 then 
			castTime = castTime + GetCurrentGCD()
		end 
		
		local incHeal, incDMG, HoTs, absorbPossitive, absorbNegative = 0, 0, 0, 0, 0
		if PO[1] and castTime > 0 then 
			incHeal = Unit(unitID):GetIncomingHeals()
		end 
		
		if PO[2] and castTime > 0 then 
			incDMG = Unit(unitID):GetDMG() * castTime
		end 
		
		if PO[4] and castTime > 0 then -- 4 here!
			HoTs = Unit(unitID):GetHEAL() * castTime
		end 
		
		if PO[5] then 
			absorbPossitive = Unit(unitID):GetAbsorb()
			-- Better don't touch it, not tested anyway
			if absorbPossitive >= Unit(unitID):HealthDeficit() then 
				absorbPossitive = 0
			end 
		end 
		
		if PO[6] then 
			absorbNegative = Unit(unitID):GetTotalHealAbsorbs()
		end 
		
		-- Guardian of Elune modifier
        local extraHealModifier = 1
        if Unit("player"):HasSpec(ACTION_CONST_DRUID_RESTORATION) and Unit("player"):HasBuffs(213680, true) > 0 then
            extraHealModifier = 1.2
        end		
		
		local withoutOptions = desc[1] * extraHealModifier * variation
		local total = withoutOptions + incHeal - incDMG + HoTs + absorbPossitive - absorbNegative
		
		return Unit(unitID):HealthDeficit() >= total, total
 
    end
    
	-- Swiftmend
    if self.predictName == "Swiftmend" then
        --total = A.GetSpellDescription(18562)[1] * variation
		local desc = self:GetSpellDescription()
		local castTime = self:GetSpellCastTime()
		
		-- Add current GCD to pre-pare 
		if castTime > 0 then 
			castTime = castTime + GetCurrentGCD()
		end 
		
		local incHeal, incDMG, HoTs, absorbPossitive, absorbNegative = 0, 0, 0, 0, 0
		if PO[1] and castTime > 0 then 
			incHeal = Unit(unitID):GetIncomingHeals()
		end 
		
		if PO[2] and castTime > 0 then 
			incDMG = Unit(unitID):GetDMG() * castTime
		end 
		
		if PO[4] and castTime > 0 then -- 4 here!
			HoTs = Unit(unitID):GetHEAL() * castTime
		end 
		
		if PO[5] then 
			absorbPossitive = Unit(unitID):GetAbsorb()
			-- Better don't touch it, not tested anyway
			if absorbPossitive >= Unit(unitID):HealthDeficit() then 
				absorbPossitive = 0
			end 
		end 
		
		if PO[6] then 
			absorbNegative = Unit(unitID):GetTotalHealAbsorbs()
		end 
						
		local withoutOptions = desc[1] * variation
		local total = withoutOptions + incHeal - incDMG + HoTs + absorbPossitive - absorbNegative
		
		return Unit(unitID):HealthDeficit() >= total, total
    end
    
	-- Rejuvenation
    if self.predictName == "Rejuvenation" then      

		local desc = self:GetSpellDescription()
		local castTime = self:GetSpellCastTime()
		
		-- Add current GCD to pre-pare 
		if castTime > 0 then 
			castTime = castTime + GetCurrentGCD()
		end 
		
		local incHeal, incDMG, HoTs, absorbPossitive, absorbNegative = 0, 0, 0, 0, 0
		if PO[1] and castTime > 0 then 
			incHeal = Unit(unitID):GetIncomingHeals()
		end 
		
		if PO[2] and castTime > 0 then 
			incDMG = Unit(unitID):GetDMG() * castTime
		end 
		
		if PO[4] and castTime > 0 then -- 4 here!
			HoTs = Unit(unitID):GetHEAL() * castTime
		end 
		
		if PO[5] then 
			absorbPossitive = Unit(unitID):GetAbsorb()
			-- Better don't touch it, not tested anyway
			if absorbPossitive >= Unit(unitID):HealthDeficit() then 
				absorbPossitive = 0
			end 
		end 
		
		if PO[6] then 
			absorbNegative = Unit(unitID):GetTotalHealAbsorbs()
		end 
		
        local extraHealModifier = 1
        if Unit("player"):HasSpec(ACTION_CONST_DRUID_RESTORATION) and -- Restor
        -- Talent Soul of Forest
        Unit("player"):HasBuffs(114108, true) > 0 
		then               
            extraHealModifier = 2
        end
			
		local withoutOptions = desc[1] * extraHealModifier * variation
		local total = withoutOptions + incHeal - incDMG + HoTs + absorbPossitive - absorbNegative
		
		return Unit(unitID):HealthDeficit() >= total, total

    end    
    
    if self.predictName == "Regrowth" then
	
		local desc = self:GetSpellDescription()
		local castTime = self:GetSpellCastTime()
		
		-- Add current GCD to pre-pare 
		if castTime > 0 then 
			castTime = castTime + GetCurrentGCD()
		end 
		
		local incHeal, incDMG, HoTs, absorbPossitive, absorbNegative = 0, 0, 0, 0, 0
		if PO[1] and castTime > 0 then 
			incHeal = Unit(unitID):GetIncomingHeals()
		end 
		
		if PO[2] and castTime > 0 then 
			incDMG = Unit(unitID):GetDMG() * castTime
		end 
		
		if PO[4] and castTime > 0 then -- 4 here!
			HoTs = Unit(unitID):GetHEAL() * castTime
		end 
		
		if PO[5] then 
			absorbPossitive = Unit(unitID):GetAbsorb()
			-- Better don't touch it, not tested anyway
			if absorbPossitive >= Unit(unitID):HealthDeficit() then 
				absorbPossitive = 0
			end 
		end 
		
		if PO[6] then 
			absorbNegative = Unit(unitID):GetTotalHealAbsorbs()
		end 

        local extraCritModifier, extraHotModifier = 1, 1
		if Unit("player"):HasSpec(ACTION_CONST_DRUID_RESTORATION) and -- Balance
		not UnitIsUnit("player", unitID) then
			extraCritModifier = 2
		end
		if Unit("player"):HasSpec(ACTION_CONST_DRUID_RESTORATION) and -- Restor
		-- Talent Soul of Forest
		Unit(unitID):HasBuffs(114108, true) > 0 then
			extraCritModifier = 2
			extraHotModifier = 2
		end
	
		local withoutOptions = (desc[1] * variation * extraCritModifier) + (desc[2] * variation * extraHotModifier)
		local total = withoutOptions + incHeal - incDMG + HoTs + absorbPossitive - absorbNegative
		
		return Unit(unitID):HealthDeficit() >= total, total

    end
    
    if self.predictName == "LunarBeam" then
		local desc = self:GetSpellDescription()
		local castTime = self:GetSpellCastTime()
		
		-- Add current GCD to pre-pare 
		if castTime > 0 then 
			castTime = castTime + GetCurrentGCD()
		end 
		
		local incHeal, incDMG, HoTs, absorbPossitive, absorbNegative = 0, 0, 0, 0, 0
		if PO[1] and castTime > 0 then 
			incHeal = Unit(unitID):GetIncomingHeals()
		end 
		
		if PO[2] and castTime > 0 then 
			incDMG = Unit(unitID):GetDMG() * castTime
		end 
		
		if PO[4] and castTime > 0 then -- 4 here!
			HoTs = Unit(unitID):GetHEAL() * castTime
		end 
		
		if PO[5] then 
			absorbPossitive = Unit(unitID):GetAbsorb()
			-- Better don't touch it, not tested anyway
			if absorbPossitive >= Unit(unitID):HealthDeficit() then 
				absorbPossitive = 0
			end 
		end 
		
		if PO[6] then 
			absorbNegative = Unit(unitID):GetTotalHealAbsorbs()
		end 
		
		local withoutOptions = desc[1] * variation
		local total = withoutOptions + incHeal - incDMG + HoTs + absorbPossitive - absorbNegative
		
		return Unit(unitID):HealthDeficit() >= total, total
	
    end
    
    if self.predictName == "WildGrowth" then
	
		local desc = self:GetSpellDescription()
		local castTime = self:GetSpellCastTime()
		
		-- Add current GCD to pre-pare 
		if castTime > 0 then 
			castTime = castTime + GetCurrentGCD()
		end 
		
		local incHeal, incDMG, HoTs, absorbPossitive, absorbNegative = 0, 0, 0, 0, 0
		if PO[1] and castTime > 0 then 
			incHeal = Unit(unitID):GetIncomingHeals()
		end 
		
		if PO[2] and castTime > 0 then 
			incDMG = Unit(unitID):GetDMG() * castTime
		end 
		
		if PO[4] and castTime > 0 then -- 4 here!
			HoTs = Unit(unitID):GetHEAL() * castTime
		end 
		
		if PO[5] then 
			absorbPossitive = Unit(unitID):GetAbsorb()
			-- Better don't touch it, not tested anyway
			if absorbPossitive >= Unit(unitID):HealthDeficit() then 
				absorbPossitive = 0
			end 
		end 
		
		if PO[6] then 
			absorbNegative = Unit(unitID):GetTotalHealAbsorbs()
		end 
		
        local extraHealModifier = 1
        if Unit("player"):HasSpec(ACTION_CONST_DRUID_RESTORATION) and -- Restor
        -- Talent Soul of Forest
        Unit("player"):HasBuffs(114108, true) > 0 then
            extraHealModifier = 1.75
        end
			
		local withoutOptions = desc[1] * extraHealModifier * variation
		local total = withoutOptions + incHeal - incDMG + HoTs + absorbPossitive - absorbNegative
		
		return Unit(unitID):HealthDeficit() >= total, total
		
    end
    
    if self.predictName == "Lifebloom" then 
	
		local desc = self:GetSpellDescription()
		local castTime = self:GetSpellCastTime()
		
		-- Add current GCD to pre-pare 
		if castTime > 0 then 
			castTime = castTime + GetCurrentGCD()
		end 
		
		local incHeal, incDMG, HoTs, absorbPossitive, absorbNegative = 0, 0, 0, 0, 0
		if PO[1] and castTime > 0 then 
			incHeal = Unit(unitID):GetIncomingHeals()
		end 
		
		if PO[2] and castTime > 0 then 
			incDMG = Unit(unitID):GetDMG() * castTime
		end 
		
		if PO[4] and castTime > 0 then -- 4 here!
			HoTs = Unit(unitID):GetHEAL() * castTime
		end 
		
		if PO[5] then 
			absorbPossitive = Unit(unitID):GetAbsorb()
			-- Better don't touch it, not tested anyway
			if absorbPossitive >= Unit(unitID):HealthDeficit() then 
				absorbPossitive = 0
			end 
		end 
		
		if PO[6] then 
			absorbNegative = Unit(unitID):GetTotalHealAbsorbs()
		end 
			
		local withoutOptions = desc[1] * variation
		local total = withoutOptions + incHeal - incDMG + HoTs + absorbPossitive - absorbNegative
		
		return Unit(unitID):HealthDeficit() >= total, total
		
    end
    
    if self.predictName == "CenarionWard" then 
		local desc = self:GetSpellDescription()
		local castTime = self:GetSpellCastTime()
		
		-- Add current GCD to pre-pare 
		if castTime > 0 then 
			castTime = castTime + GetCurrentGCD()
		end 
		
		local incHeal, incDMG, HoTs, absorbPossitive, absorbNegative = 0, 0, 0, 0, 0
		if PO[1] and castTime > 0 then 
			incHeal = Unit(unitID):GetIncomingHeals()
		end 
		
		if PO[2] and castTime > 0 then 
			incDMG = Unit(unitID):GetDMG() * castTime
		end 
		
		if PO[4] and castTime > 0 then -- 4 here!
			HoTs = Unit(unitID):GetHEAL() * castTime
		end 
		
		if PO[5] then 
			absorbPossitive = Unit(unitID):GetAbsorb()
			-- Better don't touch it, not tested anyway
			if absorbPossitive >= Unit(unitID):HealthDeficit() then 
				absorbPossitive = 0
			end 
		end 
		
		if PO[6] then 
			absorbNegative = Unit(unitID):GetTotalHealAbsorbs()
		end 
			
		local withoutOptions = desc[1] * variation
		local total = withoutOptions + incHeal - incDMG + HoTs + absorbPossitive - absorbNegative
		
		return Unit(unitID):HealthDeficit() >= total, total
    end
    
    if self.predictName == "Tranquility" then 
	
		local desc = self:GetSpellDescription()
		local castTime = self:GetSpellCastTime()
		
		-- Add current GCD to pre-pare 
		if castTime > 0 then 
			castTime = castTime + GetCurrentGCD()
		end 
		
		local incHeal, incDMG, HoTs, absorbPossitive, absorbNegative = 0, 0, 0, 0, 0
		if PO[1] and castTime > 0 then 
			incHeal = Unit(unitID):GetIncomingHeals()
		end 
		
		if PO[2] and castTime > 0 then 
			incDMG = Unit(unitID):GetDMG() * castTime
		end 
		
		if PO[4] and castTime > 0 then -- 4 here!
			HoTs = Unit(unitID):GetHEAL() * castTime
		end 
		
		if PO[5] then 
			absorbPossitive = Unit(unitID):GetAbsorb()
			-- Better don't touch it, not tested anyway
			if absorbPossitive >= Unit(unitID):HealthDeficit() then 
				absorbPossitive = 0
			end 
		end 
		
		if PO[6] then 
			absorbNegative = Unit(unitID):GetTotalHealAbsorbs()
		end 
		
		-- Raid zone modifier
        local extraHealModifier = 1
        if IsInRaid() then
            extraHealModifier = 2
        end
		
		local withoutOptions = desc[1] + (desc[2] * 5 * extraHealModifier) --+ pre_heal + (HPS * 15.1) - (DMG * 15.1)
		local total = withoutOptions + incHeal - incDMG + HoTs + absorbPossitive - absorbNegative
		
		return Unit(unitID):HealthDeficit() >= total, total

    end    
    
    if self.predictName == "Efflorescence" then 
	
		local desc = self:GetSpellDescription()
		local castTime = self:GetSpellCastTime()
		
		-- Add current GCD to pre-pare 
		if castTime > 0 then 
			castTime = castTime + GetCurrentGCD()
		end 
		
		local incHeal, incDMG, HoTs, absorbPossitive, absorbNegative = 0, 0, 0, 0, 0
		if PO[1] and castTime > 0 then 
			incHeal = Unit(unitID):GetIncomingHeals()
		end 
		
		if PO[2] and castTime > 0 then 
			incDMG = Unit(unitID):GetDMG() * castTime
		end 
		
		if PO[4] and castTime > 0 then -- 4 here!
			HoTs = Unit(unitID):GetHEAL() * castTime
		end 
		
		if PO[5] then 
			absorbPossitive = Unit(unitID):GetAbsorb()
			-- Better don't touch it, not tested anyway
			if absorbPossitive >= Unit(unitID):HealthDeficit() then 
				absorbPossitive = 0
			end 
		end 
		
		if PO[6] then 
			absorbNegative = Unit(unitID):GetTotalHealAbsorbs()
		end 
		
		local withoutOptions = (desc[1] / 1.8 * 30) * variation
		local total = withoutOptions + incHeal - incDMG + HoTs + absorbPossitive - absorbNegative
		
		return Unit(unitID):HealthDeficit() >= total, total

    end    
    
    if self.predictName == "Overgrowth" then 
	
		local desc = self:GetSpellDescription()
		local castTime = self:GetSpellCastTime()
		
		-- Add current GCD to pre-pare 
		if castTime > 0 then 
			castTime = castTime + GetCurrentGCD()
		end 
		
		local incHeal, incDMG, HoTs, absorbPossitive, absorbNegative = 0, 0, 0, 0, 0
		if PO[1] and castTime > 0 then 
			incHeal = Unit(unitID):GetIncomingHeals()
		end 
		
		if PO[2] and castTime > 0 then 
			incDMG = Unit(unitID):GetDMG() * castTime
		end 
		
		if PO[4] and castTime > 0 then -- 4 here!
			HoTs = Unit(unitID):GetHEAL() * castTime
		end 
		
		if PO[5] then 
			absorbPossitive = Unit(unitID):GetAbsorb()
			-- Better don't touch it, not tested anyway
			if absorbPossitive >= Unit(unitID):HealthDeficit() then 
				absorbPossitive = 0
			end 
		end 
		
		if PO[6] then 
			absorbNegative = Unit(unitID):GetTotalHealAbsorbs()
		end

		local total = 0
		
        -- REFRESH ABLE: Wild growth and Lifebloom
        if Unit(unitID):HasBuffs(48438, true) < 3 and Unit(unitID):HasBuffs(48438, true) < 3 then 
            local SoulOfForest = Unit("player"):HasBuffs(114108, true) > 0
            -- LifeBloom 15sec
            local LB = A.GetSpellDescription(33763)[1]
            --total = A.GetSpellDescription(33763)[1]
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
            total = incHeal + RG + WG + LB + RN + (HoTs * 12.25) - (incDMG * 12.25) + absorbPossitive - absorbNegative
        else 
            total = 88888888888888 -- skip
        end

		return Unit(unitID):HealthDeficit() >= total, total	

    end
    
    -- 8.1 PvP
    if self.predictName == "Nourish" then
	
		local desc = self:GetSpellDescription()
		local castTime = self:GetSpellCastTime()
		
		-- Add current GCD to pre-pare 
		if castTime > 0 then 
			castTime = castTime + GetCurrentGCD()
		end 
		
		local incHeal, incDMG, HoTs, absorbPossitive, absorbNegative = 0, 0, 0, 0, 0
		if PO[1] and castTime > 0 then 
			incHeal = Unit(unitID):GetIncomingHeals()
		end 
		
		if PO[2] and castTime > 0 then 
			incDMG = Unit(unitID):GetDMG() * castTime
		end 
		
		if PO[4] and castTime > 0 then -- 4 here!
			HoTs = Unit(unitID):GetHEAL() * castTime
		end 
		
		if PO[5] then 
			absorbPossitive = Unit(unitID):GetAbsorb()
			-- Better don't touch it, not tested anyway
			if absorbPossitive >= Unit(unitID):HealthDeficit() then 
				absorbPossitive = 0
			end 
		end 
		
		if PO[6] then 
			absorbNegative = Unit(unitID):GetTotalHealAbsorbs()
		end

        local extraCritModifier = 1
        if 
        -- Rejuvenation
        Unit(unitID):HasBuffs(774, true) >= castTime and 
        -- Germination
        (
            not RESTO.Germination:IsSpellLearned() or 
            Unit(unitID):HasBuffs(155777, true) >= castTime
        ) and
        -- Lifebloom
        Unit(unitID):HasBuffs(33763, true) > castTime and
        -- Wild Growth
        Unit(unitID):HasBuffs(48438, true) > castTime and
        -- Regrowth
        Unit(unitID):HasBuffs(8936, true) > castTime
        then
            extraCritModifier = 2
        end

		local withoutOptions = (desc[1] * extraCritModifier) * variation -- + (HPS * castTime) + pre_heal - (DMG * castTime)
		local total = withoutOptions + incHeal - incDMG + HoTs + absorbPossitive - absorbNegative
		
		return Unit(unitID):HealthDeficit() >= total, total
	
    end    
    
	if self.predictName == "EssenceFont" then 
		local desc = self:GetSpellDescription()
		local castTime = desc[6] or 0; local clearCastTime = castTime
		local duration = desc[4] or 0
		local pureHeal = desc[1] or 0
		local perTick  = desc[2] / duration
		local sumTicks = math_ceil(cast_time / 0.9)
		
 		-- Add current GCD to pre-pare 
		if castTime > 0 then 
			castTime = castTime + GetCurrentGCD()
		end
						
		local incHeal, incDMG, HoTs, absorbPossitive, absorbNegative = 0, 0, 0, 0, 0
		if PO[1] and castTime > 0 then 
			incHeal = Unit(unitID):GetIncomingHeals()
		end 
		
		if PO[2] and castTime > 0 then 
			incDMG = Unit(unitID):GetDMG() * castTime
		end 
		
		if PO[4] and castTime > 0 then -- 4 here!
			HoTs = Unit(unitID):GetHEAL() * castTime
		end 
		
		if PO[5] then 
			absorbPossitive = Unit(unitID):GetAbsorb()
			-- Better don't touch it, not tested anyway
			if absorbPossitive >= Unit(unitID):HealthDeficit() then 
				absorbPossitive = 0
			end 
		end 
		
		if PO[6] then 
			absorbNegative = Unit(unitID):GetTotalHealAbsorbs()
		end 					
		
		local withoutOptions = desc[1] * variation
		local total = withoutOptions + incHeal - incDMG + HoTs + absorbPossitive - absorbNegative
		
		return Unit(unitID):HealthDeficit() >= total, total
	end 	
	
	-- Debug 
	if not self.predictName then 
		error((self:GetKeyName() or "Unknown action name") .. " doesn't contain predictName")		
	end 

    return false, 0
	
end