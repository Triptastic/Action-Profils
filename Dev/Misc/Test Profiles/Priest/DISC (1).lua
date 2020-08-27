local Action									= Action
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
local Azerite									= LibStub("AzeriteTraits")
local Pull										= Action.BossMods_Pulling()
local Utils										= Action.Utils
local TeamCache									= Action.TeamCache
local EnemyTeam									= Action.EnemyTeam
local FriendlyTeam								= Action.FriendlyTeam
local HealingEngine								= Action.HealingEngine
local LoC										= Action.LossOfControl
local Player									= Action.Player 
local MultiUnits								= Action.MultiUnits
local UnitCooldown								= Action.UnitCooldown
local Unit										= Action.Unit 
local IsUnitEnemy								= Action.IsUnitEnemy
local IsUnitFriendly							= Action.IsUnitFriendly
local ActiveUnitPlates							= MultiUnits:GetActiveUnitPlates()

local TeamCacheFriendly							= TeamCache.Friendly
local HealingEngineMembers 						= HealingEngine.Members 
local HealingEngineMembersALL					= HealingEngine.GetMembersAll()
local HealingEngineGetMinimumUnits				= HealingEngine.GetMinimumUnits
local HealingEngineGetIncomingDMGAVG			= HealingEngine.GetIncomingDMGAVG
local HealingEngineGetIncomingHPSAVG			= HealingEngine.GetIncomingHPSAVG
local HealingEngineQueueOrder     				= HealingEngine.Data.QueueOrder

local _G, setmetatable, select, math			= _G, setmetatable, select, math 
local ACTION_CONST_STOPCAST						= _G.ACTION_CONST_STOPCAST
local ACTION_CONST_SPELLID_FREEZING_TRAP		= _G.ACTION_CONST_SPELLID_FREEZING_TRAP
local huge										= math.huge

local IsIndoors, UnitIsUnit = 
IsIndoors, UnitIsUnit

Action[ACTION_CONST_PRIEST_DISCIPLINE] = {
    -- Racial
    ArcaneTorrent								= Create({ Type = "Spell", ID = 50613}),
    BloodFury									= Create({ Type = "Spell", ID = 20572}),
    BagofTricks                                 = Create({ Type = "Spell", ID = 312411}),
    Fireblood									= Create({ Type = "Spell", ID = 265221}),
    AncestralCall								= Create({ Type = "Spell", ID = 274738}),
    Berserking									= Create({ Type = "Spell", ID = 26297}),
    ArcanePulse									= Create({ Type = "Spell", ID = 260364}),
    QuakingPalm									= Create({ Type = "Spell", ID = 107079}),
    Haymaker                                    = Create({ Type = "Spell", ID = 287712}), 
    WarStomp                                    = Create({ Type = "Spell", ID = 20549}),
    BullRush                                    = Create({ Type = "Spell", ID = 255654}),    
    GiftofNaaru									= Create({ Type = "Spell", ID = 59544}),
    Shadowmeld									= Create({ Type = "Spell", ID = 58984}), -- usable in Action Core 
    Stoneform									= Create({ Type = "Spell", ID = 20594}), 
    WilloftheForsaken							= Create({ Type = "Spell", ID = 7744}), -- not usable in APL but user can Queue it    
    EscapeArtist                                = Create({ Type = "Spell", ID = 20589}), -- not usable in APL but user can Queue it
    EveryManforHimself                          = Create({ Type = "Spell", ID = 59752}), -- not usable in APL but user can Queue it
    -- CrownControl    
	KidneyShot									= Create({ Type = "Spell", ID = 408}),

     

    -- Self Defensives

    -- Burst
	Rapture										= Create({ Type = "Spell", ID = 47536}),
	PainSuppression								= Create({ Type = "Spell", ID = 33206}),
	PowerWordBarrier							= Create({ Type = "Spell", ID = 62618}),
	PowerWordRadiance							= Create({ Type = "Spell", ID = 194509}),
	-- Suppotive   
	PowerWordShield								= Create({ Type = "Spell", ID = 17}),
	ShadowMend									= Create({ Type = "Spell", ID = 186263}),
	Penance										= Create({ Type = "Spell", ID = 47540}),
    -- Rotation       
	ShadowWordPain								= Create({ Type = "Spell", ID = 589}),	
	PenanceDMG									= Create({ Type = "Spell", ID = 23018}),
	Smite										= Create({ Type = "Spell", ID = 585}),
    -- Movement    

    -- Utilities

	-- PvP

    -- Buffs
	AtonementBuff								= Create({ Type = "Spell", ID = 81749 , Hidden = true}),
	InnervateBuff									= Create({ Type = "Spell", ID = 29166 , Hidden = true}),
    -- Debuffs
	WeakenedSoulDebuff							= Create({ Type = "Spell", ID = 6788, Hidden = true}),
    PurgetheWickedDebuff						= Create({ Type = "Spell", ID = 204213, Hidden = true}),
	ConcentratedFlameDebuff						= Create({ Type = "Spell", ID = 295368, Hidden = true}),
    -- Talents
	Castigation									= Create({ Type = "Spell", ID = 193134, isTalent = true}), -- Talent 1/1
	TwistofFate									= Create({ Type = "Spell", ID = 265259, isTalent = true}), -- Talent 1/2
	Schism										= Create({ Type = "Spell", ID = 214621, isTalent = true}), -- Talent 1/3
	BodyandSoul									= Create({ Type = "Spell", ID = 64129, isTalent = true}),  -- Talent 2/1
	Masochism									= Create({ Type = "Spell", ID = 193063, isTalent = true}), -- Talent 2/2
	AngelicFeather								= Create({ Type = "Spell", ID = 121536, isTalent = true}), -- Talent 2/3
	ShieldDiscipline							= Create({ Type = "Spell", ID = 197045, isTalent = true}), -- Talent 3/1
	Mindbender									= Create({ Type = "Spell", ID = 123040, isTalent = true}), -- Talent 3/2
	PowerWordSolace								= Create({ Type = "Spell", ID = 129250, isTalent = true}), -- Talent 3/3
	PsychicVoice								= Create({ Type = "Spell", ID = 196704, isTalent = true}), -- Talent 4/1
	DominantMind								= Create({ Type = "Spell", ID = 205367, isTalent = true}), -- Talent 4/2
	ShiningForce								= Create({ Type = "Spell", ID = 204263, isTalent = true}), -- Talent 4/3
	SinsoftheMany								= Create({ Type = "Spell", ID = 280391, isTalent = true}), -- Talent 5/1
	Contrition									= Create({ Type = "Spell", ID = 197419, isTalent = true}), -- Talent 5/2
	ShadowCovenant								= Create({ Type = "Spell", ID = 204065, isTalent = true}), -- Talent 5/3
	PurgetheWicked								= Create({ Type = "Spell", ID = 204197, isTalent = true}), -- Talent 6/1
	DivineStar									= Create({ Type = "Spell", ID = 110744, isTalent = true}), -- Talent 6/2
	Halo										= Create({ Type = "Spell", ID = 120517, isTalent = true}), -- Talent 6/3
	Lenience									= Create({ Type = "Spell", ID = 238063, isTalent = true}), -- Talent 7/1
	LuminousBarrier								= Create({ Type = "Spell", ID = 271466, isTalent = true}), -- Talent 7/2
	Evangelism									= Create({ Type = "Spell", ID = 246287, isTalent = true}), -- Talent 7/3
	-- PvP Talents

    -- Items
	PotionofUnbridledFury						= Create({ Type = "Potion",  ID = 169299 }), 

    -- Hidden 
	PoolResource								= Create({ Type = "Spell", ID = 97238, Hidden = true}),
	Channeling								    = Create({ Type = "Spell", ID = 209274, Hidden = true}),	
	EchoingBlades								= Create({ Type = "Spell", ID = 287649, Hidden = true}), -- Simcraft Azerite
	
	--Mythic Plus Spells 
	Quake										= Create({ Type = "Spell", ID = 240447, Hidden = true}), -- Quake (Mythic Plus Affix) 

}

Action:CreateEssencesFor(ACTION_CONST_PRIEST_DISCIPLINE)
local A = setmetatable(Action[ACTION_CONST_PRIEST_DISCIPLINE], { __index = Action })


local player									= "player"
local target                                    = "target"
local PartyUnits
local Temp										= {
	TotalAndMagicAndCC							= {"TotalImun", "DamageMagicImun", "CCTotalImun", "CCMagicImun"},
	AttackTypes 								= {"TotalImun", "DamageMagicImun"},
	AuraForInterrupt 							= {"TotalImun", "KickImun", "DamageMagicImun", "CCTotalImun", "CCMagicImun"},
	AuraForFear									= {"TotalImun", "FearImun"},
	TotalAndMagicAndStun                    	= {"TotalImun", "DamageMagicImun", "StunImun"},
	ForceApplyAtone								= true
}

local IsIndoors, UnitIsUnit = 
IsIndoors, UnitIsUnit                                                              

local function IsSchoolShadowUP()
	return LoC:IsMissed("SILENCE") and LoC:Get("SCHOOL_INTERRUPT", "SHADOW") == 0
end 

local function IsSchoolHolyUP()
	return LoC:IsMissed("SILENCE") and LoC:Get("SCHOOL_INTERRUPT", "HOLY") == 0
end 

local function IsSchoolFireUP()
	return LoC:IsMissed("SILENCE") and LoC:Get("SCHOOL_INTERRUPT", "FIRE") == 0
end 

local function IsEnoughHPS(unitID)
    return Unit(player):GetHPS() > Unit(unitID):GetDMG()
end 

local function selectEnemyByMember()
  for i = 1, #HealingEngineMembersALL do
    local unitID = HealingEngineMembersALL[i].Unit .. "target"
    if Unit(unitID):IsEnemy() and Unit(unitID):GetRange() <= 40 and not UnitIsUnit(HealingEngineMembersALL[i].Unit, "target") then
      HealingEngine.SetTarget(HealingEngineMembersALL[i].Unit)
      return
    end
  end
end

local function CanBarrier() 
	if A.PowerWordBarrier:IsReady(player, true) then
		local BarrierHP 	= GetToggle(2, "Barrier")
		local BarrierUnits	= GetToggle(2, "BarrierUnits")
		
		if BarrierUnits > 40 then
			BarrierUnits = HealingEngineGetMinimumUnits(1)
			
			if BarrierUnits > 5 then
				BarrierUnits = BarrierUnits - (#HealingEngineMembersALL * 0.2)
			end
		elseif BarrierUnits >= TeamCacheFriendly.Size then 
			BarrierUnits = TeamCacheFriendly.Size
		end
		
		 if BarrierUnits < 3 and not A.IsInPvP then 
            return false 
        end 
		
		local counter = 0 
        for i = 1, #HealingEngineMembersALL do 
			-- Auto HP
			if BarrierHP >= 100 and Unit(HealingEngineMembersALL[i].Unit):TimeToDieX(20) < 3 and HealingEngineMembersALL[i].HP < 50 then
				counter = counter + 1
			end
			
			if BarrierHP < 100 and HealingEngineMembersALL[i].HP <= BarrierHP then 
				counter = counter + 1
			end
			
			if counter >= BarrierUnits then 
                return true 
            end 
        end 
    end 
    return false 
end
CanBarrier = A.MakeFunctionCachedStatic(CanBarrier)

local function CanRadiance(unitID) 
	if A.PowerWordRadiance:IsReady(unitID) then
		local counter = 0 
        for i = 1, #HealingEngineMembersALL do --HealingEngineMembersALL[i].HP < 80 and 
			if Unit(HealingEngineMembersALL[i].Unit):HasBuffs(A.AtonementBuff.ID, true) <= GetCurrentGCD() + GetPing() + A.PowerWordRadiance:GetSpellCastTime() and 
			A.PowerWordRadiance:PredictHeal("PW:R", HealingEngineMembersALL[i].Unit) then
				counter = counter + 1
			end
			
			if counter >= 3 then
				return true
			end
		end
	end
	
	return false 
end
CanRadiance = A.MakeFunctionCachedStatic(CanRadiance)

local function CanRaptureAoE(hp) 
	local counter = 0 
	for i = 1, #HealingEngineMembersALL do 
		if HealingEngineMembersALL[i].HP <= hp and HealingEngineMembersALL[i].isPlayer then
			if A.PowerWordShield:PredictHeal("PW:S", HealingEngineMembersALL[i].Unit, 200) then
				counter = counter + 1
			end
			
			if counter >= 2 then
				return true
			end
		end
	end	
	return false 
end
CanRaptureAoE = A.MakeFunctionCachedStatic(CanRaptureAoE)
-----------------------------------------
--                 ROTATION  
-----------------------------------------

-- [3] Single Rotation
A[3] = function(icon, isMulti)
    local unitID			= player
	local canCast			= true
	local combatTime		= Unit(player):CombatTime()
	local inCombat 			= combatTime > 0
	local isSchoolShadowUP	= IsSchoolShadowUP()
	local isSchoolHolyUP	= IsSchoolHolyUP()
	local isSchoolFireUP	= IsSchoolFireUP()
	local inAoE				= GetToggle(2, "AoE")
	
	local DamageRotation, HealingRotation
	
	if Unit(player):HasDeBuffs(A.Quake.ID) > 0 then
		canCast = false
	else
		canCast = true
	end
	
	local function DamageRotation(unitID)	
		if isSchoolShadowUP and A.ShadowWordPain:IsReady(unitID) and A.ShadowWordPain:AbsentImun(unitID, Temp.AttackTypes) and
		not A.PurgetheWicked:IsSpellLearned() and Unit(unitID):HasDeBuffs(A.ShadowWordPain.ID) <= GetGCD() + GetCurrentGCD() then
			return A.ShadowWordPain:Show(icon)
		end
		
		if isSchoolFireUP and A.PurgetheWicked:IsReady(unitID) and A.PurgetheWicked:AbsentImun(unitID, Temp.AttackTypes) and canCast and 
		Unit(unitID):HasDeBuffs(A.PurgetheWickedDebuff.ID) <= GetGCD() + GetCurrentGCD() then
			return A.PurgetheWicked:Show(icon)
		end
		
		if isSchoolShadowUP and Player:IsStaying() and A.Schism:IsReady(unitID) and A.Schism:AbsentImun(unitID, Temp.AttackTypes) and canCast and Unit(unitID):TimeToDie() > 7 then
			return A.Schism:Show(icon)
		end
		
		if isSchoolHolyUP and A.PowerWordSolace:IsReady(unitID) and A.PowerWordSolace:AbsentImun(unitID, Temp.AttackTypes) and canCast then
			return A.PowerWordSolace:Show(icon)
		end
		
		if isSchoolHolyUP and A.Penance:IsReady(unitID) and A.Penance:AbsentImun(unitID, Temp.AttackTypes) and canCast and 
		A.Penance:PredictHeal("PenanceDMG", unitID) then
			return A.PenanceDMG:Show(icon)
		end
		
		if A.ConcentratedFlame:AutoHeartOfAzeroth(unitID) and canCast and Unit(unitID):HasDeBuffs(A.ConcentratedFlameDebuff.ID) == 0 and unitID ~= "targettarget" then
			return A.ConcentratedFlame:Show(icon)
		end
		
		if isSchoolHolyUP and Player:IsStaying() and A.Smite:IsReady(unitID) and A.Smite:AbsentImun(unitID, Temp.AttackTypes) and canCast then
			return A.Smite:Show(icon)
		end
	end
	
	local function HealingRotation(unitID)
	
		--if Temp.ForceApplyAtone and HealingEngine.GetBuffsCount(A.AtonementBuff.ID, nil, true) >= 4 then
		--	Temp.ForceApplyAtone = false
		--end
		
		if BurstIsON(unitID) then
		
			-- Rapture 
			if isSchoolHolyUP and A.Rapture:IsReady(player) and (inAoE and CanRaptureAoE(65) or 
			Unit(unitID):TimeToDie() > GetGCD() * 2 + GetCurrentGCD() and Unit(unitID):TimeToDie() <= 8 and Unit(unitID):GetRealTimeDMG() > 0 and Unit(unitID):HealthPercent() < 40 and
			Unit(unitID):HasBuffs("DeffBuffs") <= GCD() * 2 + GetCurrentGCD() or Unit(player):HasBuffs(A.InnervateBuff.ID) > 0 and CanRaptureAoE(85)) then
				return A.Rapture:Show(icon)
			end			
			
			-- Barrier
			if isSchoolHolyUP and inAoE and CanBarrier() and Unit(player):HasBuffs(A.Rapture.ID, true) == 0 then
				return A.PowerWordBarrier:Show(icon)
			end
			
			-- Pain Suppression 
			if isSchoolHolyUP and A.PainSuppression:IsReady(unitID) and A.PainSuppression:AbsentImun(unitID) and Unit(player):HasBuffs(A.Rapture.ID, true) == 0 then
				if not IsEnoughHPS(unitID) and Unit(unitID):HasBuffs("DeffBuffs") == 0 and ((Unit(unitID):TimeToDieX(20) < 3 and Unit(unitID):HealthPercent() < 50) or 
				(A.IsInPvP and Unit(unitID):HealthPercent() < 80 and (Unit(unitID):HasDeBuffs("DamageDeBuffs") > 5 or Unit(unitID):IsExecuted()))) then
					return A.PainSuppression:Show(icon)
				end
			end		
		end
		
		--if A.Detox:IsReady(unitID) and A.Detox:AbsentImun(unitID) and IsSchoolFree() and AuraIsValid(unit, "UseDispel", "Dispel") and Unit(unit):TimeToDie() > 5 then 
      --      return A.Detox:Show(icon)
        --end 
		
		local Emergency = (Unit(unitID):TimeToDieX(15) < 4 and Unit(unitID):HealthPercent() <= 30 or not inCombat and Unit(unitID):HealthPercent() < 100)
		local EmergencyP = Unit(unitID):TimeToDieX(25) < 5 and Unit(unitID):HealthPercent() <= 60
		
		if isSchoolHolyUP and A.Penance:IsReady(unitID) and A.Penance:AbsentImun(unitID, Temp.AttackTypes) and canCast and EmergencyP and 
		A.Penance:PredictHeal("PenanceHeal", unitID) then
			return A.Penance:Show(icon)
		end
		
		if isSchoolShadowUP and Player:IsStaying() and A.ShadowMend:IsReady(unitID) and A.ShadowMend:AbsentImun(unitID) and canCast and Emergency and 
		A.ShadowMend:PredictHeal("ShadowMend", unitID) then
			return A.ShadowMend:Show(icon)
		end
		
		if isSchoolHolyUP and Player:IsStaying() and canCast and CanRadiance(unitID) and A.PowerWordRadiance:AbsentImun(unitID) then
			return A.PowerWordRadiance:Show(icon)
		end
		
		HealingEngine.SetPerformByProfileHP(
			function(member, memberhp, membermhp, DMG)
				if not HealingEngineQueueOrder.usePWS and Unit(member):HasBuffs(A.AtonementBuff.ID, true) == 0 and Unit(member):HasDeBuffs(A.WeakenedSoulDebuff.ID) == 0 then 
					HealingEngineQueueOrder.usePWS = true -- that will skips check :HasBuffs(18, true) for other members and save performance because you can use shield only on one unit per GCD but loop refrehes every ~0.3 sec
					memberhp = memberhp - 20
					if memberhp < 40 then 
						memberhp = 40 
					end 
				end 
				
				return memberhp
			end)
		
		if A.ConcentratedFlame:AutoHeartOfAzeroth(unitID) then 
            return A.ConcentratedFlame:Show(icon)
        end 
		
		if isSchoolHolyUP and A.PowerWordShield:IsReady(unitID) and A.PowerWordShield:AbsentImun(unitID) and canCast and (A.PowerWordShield:PredictHeal("PW:S", unitID) or Temp.ForceApplyAtone) and 
		(Unit(unitID):HasDeBuffs(A.WeakenedSoulDebuff.ID) == 0 and HealingEngine.GetBuffsCount(A.AtonementBuff.ID, nil, true) < 4 and Unit(unitID):HasBuffs(A.PowerWordShield.ID, true) == 0 or 
		Unit(player):HasBuffs(A.Rapture.ID) > 0 and A.PowerWordShield:PredictHeal("PW:S", unitID, 200) and 
		(Unit(unitID):HasBuffs(A.PowerWordShield.ID, true) == 0 or Unit(unitID):TimeToDieX(25) <= GetGCD() * 2 + GetCurrentGCD())) then
			return A.PowerWordShield:Show(icon)
		end

		--[[if Unit(unitID):HasBuffs(A.AtonementBuff.ID, true) > 0 and not Emergency and HealingEngine.GetBuffsCount(A.AtonementBuff.ID, nil, true) < 4 then
			for i = 1, #HealingEngineMembersALL do
				local H_unitID = HealingEngineMembersALL[i].Unit
				local H_unitHP = HealingEngineMembersALL[i].HP
		
				if Unit(H_unitID):HasBuffs(A.AtonementBuff.ID, true) == 0 and H_unitHP < 100 then
					A.HealingEngine.SetTarget(H_unitID, 2)
					return true 
				end
			end
		end]]
		
		if not IsUnitEnemy("targettarget") and Unit(unitID):HasBuffs(A.AtonementBuff.ID, true) > 0 and not Emergency and inCombat then
			selectEnemyByMember()
		end
		
		 -- Damage Rotation		 
        if unitID == target and IsUnitEnemy("targettarget") then 
            local CanMakeDamage = DamageRotation("targettarget")
            if CanMakeDamage then 
                return true 
            end 
        end
		
		--if not Unit("targettarget"):IsExists() or not IsUnitEnemy("targettarget") then
		--	return A:Show(icon, ACTION_CONST_AUTOTARGET)
		--end
	end

	-- Mouseover 
    if IsUnitEnemy("mouseover") then 
        unitID = "mouseover"
        
        if DamageRotation(unitID) then 
            return true 
        end 
    end 
    
    if IsUnitFriendly("mouseover") then 
        unitID = "mouseover"    
        
        if HealingRotation(unitID) then 
            return true 
        end             
    end 
	
	if IsUnitEnemy(target) then 
        unitID = target
		
		if DamageRotation(unitID) then 
            return true 
        end 
    end  
	
	if IsUnitFriendly(target) then 
        unitID = target
        
        if HealingRotation(unitID) then 
            return true 
        end 
    end 
    
end 

-- [4] AoE Rotation
A[4] = function(icon)
    return A[3](icon, true)
end 

A[6] = function(icon)    
	--Stop Cast M+ Quake Affix
	if Unit(player):IsCastingRemains() > 0 and GetToggle(1, "StopCast") and Unit(player):HasDeBuffs(A.Quake.ID) <= 1 and Unit(player):HasDeBuffs(A.Quake.ID) > 0 then
		return A:Show(icon, ACTION_CONST_STOPCAST)
	end
end
