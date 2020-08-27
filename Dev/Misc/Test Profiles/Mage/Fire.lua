local TMW 									= TMW 
local Action 								= Action
local TeamCache 							= Action.TeamCache
local EnemyTeam 							= Action.EnemyTeam
local FriendlyTeam 							= Action.FriendlyTeam
local LoC 									= Action.LossOfControl
local Player 								= Action.Player 
local MultiUnits 							= Action.MultiUnits
local UnitCooldown 							= Action.UnitCooldown
local Unit 									= Action.Unit 

Action[ACTION_CONST_MAGE_FIRE] 				= {
    -- Racial
    ArcaneTorrent							= Action.Create({ Type = "Spell", ID = 50613}),
    BloodFury								= Action.Create({ Type = "Spell", ID = 20572}),
    Fireblood								= Action.Create({ Type = "Spell", ID = 265221}),
    AncestralCall							= Action.Create({ Type = "Spell", ID = 274738}),
    Berserking								= Action.Create({ Type = "Spell", ID = 26297}),
    ArcanePulse								= Action.Create({ Type = "Spell", ID = 260364}),
    QuakingPalm								= Action.Create({ Type = "Spell", ID = 107079}),
    Haymaker								= Action.Create({ Type = "Spell", ID = 287712}), 
    BullRush								= Action.Create({ Type = "Spell", ID = 255654}),    
    WarStomp								= Action.Create({ Type = "Spell", ID = 20549}),
    GiftofNaaru								= Action.Create({ Type = "Spell", ID = 59544}),
    Shadowmeld								= Action.Create({ Type = "Spell", ID = 58984}), -- usable in Action Core 
    Stoneform								= Action.Create({ Type = "Spell", ID = 20594}), 
    WilloftheForsaken						= Action.Create({ Type = "Spell", ID = 7744}), -- not usable in APL but user can Queue it    
    EscapeArtist							= Action.Create({ Type = "Spell", ID = 20589}), -- not usable in APL but user can Queue it
    EveryManforHimself						= Action.Create({ Type = "Spell", ID = 59752}), -- not usable in APL but user can Queue it
	
	-- Crowd Control
	Counterspell							= Action.Create({ Type = "Spell", ID = 2139}),

	-- Suppotive 
	AbissalHealing							= Action.Create({ Type = "Potion", ID = 169451}),
	Barkskin								= Action.Create({ Type = "Spell", ID = 22812}),
	Soothe									= Action.Create({ Type = "Spell", ID = 2908}),
	RemoveCorruption						= Action.Create({ Type = "Spell", ID = 2782}),
	Swiftmend								= Action.Create({ Type = "Spell", ID = 18562}), -- Talent 3/3 -- Resto Affinity
	-- Spells
	Flamestrike								= Action.Create({ Type = "Spell", ID = 2120}),
	Pyroblast								= Action.Create({ Type = "Spell", ID = 11366}),
	Fireball								= Action.Create({ Type = "Spell", ID = 133}),
	FireBlast								= Action.Create({ Type = "Spell", ID = 108853}),
	Scorch									= Action.Create({ Type = "Spell", ID = 2948}),
	Combustion								= Action.Create({ Type = "Spell", ID = 190319}),
	DragonsBreath							= Action.Create({ Type = "Spell", ID = 31661}),

	-- Buffs
	HeatingUpBuff							= Action.Create({ Type = "Spell", ID = 48107, Hidden = true}),
	HotStreakBuff							= Action.Create({ Type = "Spell", ID = 48108, Hidden = true}),
	PyroclasmBuff							= Action.Create({ Type = "Spell", ID = 269651, Hidden = true}),
	RuneofPowerBuff							= Action.Create({ Type = "Spell", ID = 116014, Hidden = true}),
	CombustionBuff							= Action.Create({ Type = "Spell", ID = 190319, Hidden = true}),
	BlasterMasterBuff						= Action.Create({ Type = "Spell", ID = 274598, Hidden = true}),
	-- Debuffs
	ShiverVenomDebuff						= Action.Create({ Type = "Spell", ID = 301624}),
	-- Trinkets
	PocketsizedComputationDevice			= Action.Create({ Type = "Trinket", ID = 167555, QueueForbidden = true}),
	ShiverVenomRelic						= Action.Create({ Type = "Trinket", ID = 168905, QueueForbidden = true }), 
	-- Talents
	Firestarter								= Action.Create({ Type = "Spell", ID = 205026, isTalent = true}), -- Talent 1/1
	SearingTouch							= Action.Create({ Type = "Spell", ID = 269644, isTalent = true}), -- Talent 1/3
	RuneofPower								= Action.Create({ Type = "Spell", ID = 116011, isTalent = true}), -- Talent 3/3
	FlameOn									= Action.Create({ Type = "Spell", ID = 205029, isTalent = true}), -- Talent 4/1
	AlexstraszasFury						= Action.Create({ Type = "Spell", ID = 235870, isTalent = true}), -- Talent 4/1
	PhoenixFlames							= Action.Create({ Type = "Spell", ID = 257541, isTalent = true}), -- Talent 4/3
	FlamePatch								= Action.Create({ Type = "Spell", ID = 205037, isTalent = true}), -- Talent 6/1
	LivingBomb								= Action.Create({ Type = "Spell", ID = 44457, isTalent = true}), -- Talent 6/3
	Kindling								= Action.Create({ Type = "Spell", ID = 155148, isTalent = true}), -- Talent 7/1
	Meteor									= Action.Create({ Type = "Spell", ID = 153561, isTalent = true}), -- Talent 7/1

	-- Hidden	
	BlasterMaster							= Action.Create({ Type = "Spell", ID = 274596, Hidden = true}), -- Simcraft Azerite
}

Action:CreateEssencesFor(ACTION_CONST_MAGE_FIRE)
local A 									= setmetatable(Action[ACTION_CONST_MAGE_FIRE], { __index = Action })

-------------------------------------------
-- [[ CONDITIONS ]] 
-------------------------------------------
local player 								= "player"
local targettarget							= "targettarget"
local UnitIsUnit							= UnitIsUnit
local canCast								= false
local Temp 									= {
	AttackTypes 							= {"TotalImun", "DamageMagicImun"},
	AuraForStun								= {"TotalImun", "DamagePhysImun", "CCTotalImun", "StunImun"},	
	AuraForCC								= {"TotalImun", "DamagePhysImun", "CCTotalImun"},
	AuraForOnlyCCAndStun					= {"CCTotalImun", "StunImun"},
	AuraForDisableMag						= {"TotalImun", "DamageMagicImun", "Freedom", "CCTotalImun"},
	AuraForInterrupt						= {"TotalImun", "DamagePhysImun", "KickImun"},
	CombustionRopCutOff						= 60,
	FireblastPooling						= false,
	PhoenixPooling							= false,
	CombustionPhase							= 0,
	
}

local function IsSchoolFireUP()
	return LoC:IsMissed("SILENCE") and LoC:Get("SCHOOL_INTERRUPT", "FIRE") == 0
end 

local function IsSchoolArcaneUP()
	return LoC:IsMissed("SILENCE") and LoC:Get("SCHOOL_INTERRUPT", "ARCANE") == 0
end 

function Action:ExecuteTime()
	if self:GetSpellCastTime() > A.GetGCD() + A.GetCurrentGCD() then
		return self:GetSpellCastTime()
	else
		return A.GetGCD() + A.GetCurrentGCD()
	end
end

function FirestarterActive(unitID) 
	return (A.Firestarter:IsSpellLearned() and (Unit("target"):HealthPercent() > 90)) and true or false
end

local BlackListedTrinkets = {
    [1] = 167555, -- Pocket Sized Computation Device
	[2] = 169314, -- Azsharas Font of Power
	[3] = 168905, -- ShiverVenomRelic
}

function TrinketIsAllowed()
    local Trinket1IsAllowed = true
	local Trinket2IsAllowed = true
     
   	    for i = 1, #BlackListedTrinkets do
            if Action.Trinket1.ID == BlackListedTrinkets[i] then
                Trinket1IsAllowed = false				
			end
            if Action.Trinket2.ID == BlackListedTrinkets[i] then
                Trinket2IsAllowed = false					
            end
        end
	return Trinket1IsAllowed, Trinket2IsAllowed
end

local function num(val)
  if val then return 1 else return 0 end
end

local function SelfDefensives()	
	local PotHeal = A.GetToggle(2, "AbyssalPot")
	if A.AbissalHealing:IsReady(player) and  Unit(player):HealthPercent() <= PotHeal and Unit(player):CombatTime() > 0 then
		return A.AbissalHealing
	end
	
end
SelfDefensives = A.MakeFunctionCachedStatic(SelfDefensives)

A[3] = function(icon)
	local combatTime							= Unit(player):CombatTime()
	local inCombat 								= combatTime > 0
	local inStealth								= Player:IsStealthed()
	local inMoving								= Player:IsMoving()
	local inAoE									= A.GetToggle(2, "AoE")
	local Trinket1IsAllowed, Trinket2IsAllowed 	= TrinketIsAllowed()
	local TrinketON								= ((Action.GetToggle(1, "Trinkets")[1]) or (Action.GetToggle(1, "Trinkets")[2]))
	local disableCombustion						= false --A.GetToggle(2, "DisableCombustion")
	
	--Misc
	
	local function Enemy(unitID)		
		Temp.FireblastPooling 	= false
		Temp.PhoenixPooling 	= false
		
		if A.BurstIsON(unitID) then
			disableCombustion = false
		else
			disableCombustion = true
		end

		
		if Temp.CombustionPhase == 5 and Unit(player):HasBuffs(A.CombustionBuff.ID) == 0 and A.Combustion:GetCooldown() > 60 then
			Temp.CombustionPhase = 0
		end
		--if (A.Combustion:GetCooldown() == 0 and (A.MemoryofLucidDreams:IsReady(player)) and (not A.Meteor:IsSpellLearned() or A.Meteor:GetCooldown() == 0) and 
		--(not A.RuneofPower:IsSpellLearned() or A.RuneofPower:GetSpellCharges() >= 1)) or A.Combustion:GetCooldown() > 80 and Unit(player):HasBuffs(A.CombustionBuff.ID) == 0 then
		--	Temp.CombustionPhase = 0
	--	end
		
		if Unit(player):HasBuffs(A.CombustionBuff.ID) > 0 and Unit(player):HasBuffs(A.HotStreakBuff.ID) > 0 and (A.Scorch:IsSpellInCasting() or A.Pyroblast:IsSpellInCasting()) then
			return A:Show(icon, ACTION_CONST_STOPCAST)
		end
		
		
		if A.RuneofPower:IsSpellLearned() and A.RuneofPower:GetCooldown() < A.FireBlast:GetSpellChargesFullRechargeTime() and (A.Combustion:GetCooldown() > Temp.CombustionRopCutOff or 
		disableCombustion or FirestarterActive(unitID)) and A.RuneofPower:GetSpellCharges() > 0 or not disableCombustion and 
		A.Combustion:GetCooldown() < A.FireBlast:GetSpellChargesFullRechargeTime() * A.BlasterMaster:GetAzeriteRank() and not FirestarterActive(unitID) or 
		FirestarterActive(unitID) and Unit(unitID):TimeToDieX(90) < A.FireBlast:GetSpellChargesFullRechargeTime() * A.BlasterMaster:GetAzeriteRank() then
			Temp.FireblastPooling = true
		end
		
		
		if A.RuneofPower:IsSpellLearned() and A.RuneofPower:GetCooldown() < A.PhoenixFlames:GetSpellChargesFullRechargeTime() and (A.Combustion:GetCooldown() > Temp.CombustionRopCutOff or 
		disableCombustion) and (A.RuneofPower:GetCooldown() < Unit(unitID):TimeToDie() or A.RuneofPower:GetSpellCharges() > 0) or not disableCombustion and 
		A.Combustion:GetCooldown() < A.PhoenixFlames:GetSpellChargesFullRechargeTime() and A.Combustion:GetCooldown() < Unit(unitID):TimeToDie() then
			Temp.PhoenixPooling = true
		end
		
		if A.RuneofPower:IsReady(player) and (A.Firestarter:IsSpellLearned() and Unit(unitID):TimeToDieX(90) > A.RuneofPower:GetSpellChargesFullRechargeTime() or 
		(A.Combustion:GetCooldown() > Temp.CombustionRopCutOff or A.RuneofPower:GetSpellCharges() == 2 and A.Combustion:GetCooldown() > 0) and 
		Unit(player):HasBuffs(A.CombustionBuff.ID) == 0 and (not A.Meteor:IsSpellLearned() or A.Meteor:GetCooldown() < 5) or Unit(unitID):TimeToDie() < A.Combustion:GetCooldown() and 
		Unit(unitID):IsBoss() and Unit(player):HasBuffs(A.CombustionBuff.ID) == 0) and not inMoving then
			return A.RuneofPower:Show(icon)
		end
		
		-- Combustion Phase
		if not disableCombustion and (A.RuneofPower:IsSpellLearned() and A.Combustion:GetCooldown() <= A.RuneofPower:GetSpellCastTime() or A.Combustion:GetCooldown() == 0) and not
		FirestarterActive(unitID) or Unit(player):HasBuffs(A.CombustionBuff.ID) > 0 then 
		
		--	if A.LivingBomb:IsReady(unitID) and IsSchoolFireUP() and A.LivingBomb:AbsentImun(unitID, Temp.AttackTypes) and (MultiUnits:GetActiveEnemies() > 1 and inAoE and Unit(player):HasBuffs(A.CombustionBuff.ID) == 0) then
		--		return A.LivingBomb:Show(icon)
		--	end
			if A.LastPlayerCastID == A.MemoryofLucidDreams.ID and Temp.CombustionPhase == 0 then
				Temp.CombustionPhase = 2
			end
			
			if A.LastPlayerCastID == A.FireBlast.ID and Temp.CombustionPhase == 1 then
				--Temp.CombustionPhase = 2
			end
			
			if (A.LastPlayerCastID == A.RuneofPower.ID or not A.RuneofPower:IsSpellLearned()) and Temp.CombustionPhase == 2 then
				Temp.CombustionPhase = 3
			end
		
			if (A.LastPlayerCastID == A.Meteor.ID or not A.Meteor:IsSpellLearned()) and Temp.CombustionPhase == 3 then
				Temp.CombustionPhase = 4
			end
			
			if A.LastPlayerCastID == A.Combustion.ID and Temp.CombustionPhase == 4 then
				Temp.CombustionPhase = 5
			end
			
			if A.MemoryofLucidDreams:AutoHeartOfAzerothP(unitID) and (not A.Meteor:IsSpellLearned() or A.Meteor:GetCooldown() == 0) and (A.RuneofPower:GetSpellCharges() >= 1 or 
			not A.RuneofPower:IsSpellLearned()) and Temp.CombustionPhase == 0 then
				return A.MemoryofLucidDreams:Show(icon)
			end
			
			--if A.FireBlast:IsReady(unitID) and IsSchoolFireUP() and A.FireBlast:AbsentImun(unitID, Temp.AttackTypes) and Temp.CombustionPhase == 1 and 
			--A.LastPlayerCastID ~= A.FireBlast.ID and Unit(player):HasBuffs(A.HotStreakBuff.ID) == 0 and A.FireBlast:GetSpellTimeSinceLastCast() >= 0.5 then			
			--	return A.FireBlast:Show(icon)
			--end		
				

			if A.Counterspell:IsReadyByPassCastGCD(unitID, nil, nil, true) and A.FireBlast:GetSpellCharges() <= 1 then
				return A.Counterspell:Show(icon)
			end
			
			if A.FireBlast:IsReadyByPassCastGCD(unitID, nil, nil, true) and IsSchoolFireUP() and A.FireBlast:AbsentImun(unitID, Temp.AttackTypes) and (A.FireBlast:GetSpellCharges() >= 1 and ((A.FireBlast:GetSpellChargesFrac() +
			(Unit(player):HasBuffs(A.CombustionBuff.ID) - 3) % A.FireBlast:GetCooldown() - (Unit(player):HasBuffs(A.CombustionBuff.ID)) % (2.5)) >= 0 or A.BlasterMaster:GetAzeriteRank() == 0 or A.FlameOn:IsSpellLearned() or
			Unit(player):HasBuffs(A.CombustionBuff.ID) <= 3 or Unit(player):HasBuffs(A.BlasterMasterBuff.ID) <= 0.5) and Unit(player):HasBuffs(A.CombustionBuff.ID) > 0 and (not A.Scorch:IsSpellInCasting() and not
			A.Pyroblast:IsSpellInFlight() and Unit(player):HasBuffs(A.HeatingUpBuff.ID) > 0 or A.Scorch:IsSpellInCasting() and Unit(player):HasBuffs(A.HotStreakBuff.ID) == 0 and (Unit(player):HasBuffs(A.HeatingUpBuff.ID) == 0 or
			A.BlasterMaster:GetAzeriteRank() == 0) or A.BlasterMaster:GetAzeriteRank() >= 1 and A.FlameOn:IsSpellLearned() and A.Pyroblast:IsSpellInFlight() and Unit(player):HasBuffs(A.HeatingUpBuff.ID) == 0 and 
			Unit(player):HasBuffs(A.HotStreakBuff.ID) == 0)) and Temp.CombustionPhase == 5 and A.LastPlayerCastID ~= A.FireBlast.ID then
				return A.FireBlast:Show(icon)
			end
		
			if A.RuneofPower:IsReady(player) and Unit(player):HasBuffs(A.CombustionBuff.ID) == 0 and not inMoving and Temp.CombustionPhase == 2 then
				return A.RuneofPower:Show(icon)
			end
		
			if A.FireBlast:IsReadyByPassCastGCD(unitID, nil, nil, true) and IsSchoolFireUP() and A.FireBlast:AbsentImun(unitID, Temp.AttackTypes) and (A.BlasterMaster:GetAzeriteRank() >= 1 and A.Meteor:IsSpellLearned() and
			A.FlameOn:IsSpellLearned() and Unit(player):HasBuffs(A.BlasterMasterBuff.ID) == 0 and (A.RuneofPower:IsSpellLearned() and A.RuneofPower:IsSpellInCasting() and Unit(player):IsCastingRemains() < 0.6 or
			(A.Combustion:GetCooldown() == 0 or Unit(player):HasBuffs(A.CombustionBuff.ID) > 0) and not A.RuneofPower:IsSpellLearned() and not A.Pyroblast:IsSpellInFlight() and not A.Fireball:IsSpellInFlight()))
			and Temp.CombustionPhase == 5 and A.LastPlayerCastID ~= A.FireBlast.ID then
				return A.FireBlast:Show(icon)
			end
			
			if A.Meteor:IsReady(unitID, true) and IsSchoolFireUP() and A.Meteor:AbsentImun(unitID, Temp.AttackTypes) and (Unit(player):HasBuffs(A.RuneofPowerBuff.ID) > 0 and
			(Unit(unitID):TimeToDieX(90) > 3 or not FirestarterActive(unitID)) or A.RuneofPower:GetCooldown() < Unit(unitID):TimeToDie() or A.RuneofPower:GetSpellCharges() < 1 or 
			(3 < A.Combustion:GetCooldown() or A.Combustion:GetCooldown() == 0 or disableCombustion) and not A.RuneofPower:IsSpellLearned() and (3 < Unit(unitID):TimeToDieX(90) or
			not FirestarterActive(unitID))) and not inMoving and Temp.CombustionPhase == 3 then
				return A.Meteor:Show(icon)
			end
			
			if A.Combustion:IsReady(player) and (((A.Meteor:IsSpellInFlight() or (A.LastPlayerCastID == A.Meteor.ID and A.Meteor:GetSpellTimeSinceLastCast() >= 0.5 or
			A.Meteor:GetCooldown() <= 44 and A.Meteor:GetCooldown() >= 40) or not A.Meteor:IsSpellLearned()) and (Unit(player):HasBuffs(A.RuneofPowerBuff.ID) > 0 or not 
			A.RuneofPower:IsSpellLearned())) and Temp.CombustionPhase == 4) then
				return A.Combustion:Show(icon)
			end
			
			if A.Flamestrike:IsReady(unitID, true) and IsSchoolFireUP() and A.Flamestrike:AbsentImun(unitID, Temp.AttackTypes) and inAoE and ((A.FlamePatch:IsSpellLearned() and MultiUnits:GetActiveEnemies() > 2 or
			MultiUnits:GetActiveEnemies() > 6) and Unit(player):HasBuffs(A.HotStreakBuff.ID) > 0 and A.BlasterMaster:GetAzeriteRank() == 0) and not inMoving and Temp.CombustionPhase == 5 then
				return A.Flamestrike:Show(icon)
			end			
			
			if A.Pyroblast:IsReadyByPassCastGCD(unitID, nil, nil, true) and IsSchoolFireUP() and A.Pyroblast:AbsentImun(unitID, Temp.AttackTypes) and (Unit(player):HasBuffs(A.PyroclasmBuff.ID) > 0 and 
			Unit(player):HasBuffs(A.CombustionBuff.ID) > A.Pyroblast:GetSpellCastTime()) and Temp.CombustionPhase == 5 then
				return A.Pyroblast:Show(icon)
			end
			
			if A.Pyroblast:IsReadyByPassCastGCD(unitID, nil, nil, true) and IsSchoolFireUP() and A.Pyroblast:AbsentImun(unitID, Temp.AttackTypes) and Unit(player):HasBuffs(A.HotStreakBuff.ID) > 0 
			and Temp.CombustionPhase == 5 then
				return A.Pyroblast:Show(icon)
			end
			
			if A.PhoenixFlames:IsReady(unitID) and IsSchoolFireUP() and A.PhoenixFlames:AbsentImun(unitID, Temp.AttackTypes) and Temp.CombustionPhase == 5 then
				return A.PhoenixFlames:Show(icon)
			end
			
			if A.Scorch:IsReady(unitID) and IsSchoolFireUP() and A.Scorch:AbsentImun(unitID, Temp.AttackTypes) and (Unit(player):HasBuffs(A.CombustionBuff.ID) > A.Scorch:GetSpellCastTime() and 
			Unit(player):HasBuffs(A.CombustionBuff.ID) > 0 or Unit(player):HasBuffs(A.CombustionBuff.ID) == 0) and Temp.CombustionPhase == 5 then
				return A.Scorch:Show(icon)
			end
			
			if A.LivingBomb:IsReady(unitID) and IsSchoolFireUP() and A.LivingBomb:AbsentImun(unitID, Temp.AttackTypes) and (Unit(player):HasBuffs(A.CombustionBuff.ID) < A.GetGCD() + A.GetCurrentGCD() and 
			MultiUnits:GetActiveEnemies() > 1 and inAoE) and Temp.CombustionPhase == 5 then
				return A.LivingBomb:Show(icon)
			end
			
			if A.DragonsBreath:IsReady(unitID, true) and IsSchoolFireUP() and A.DragonsBreath:AbsentImun(unitID, Temp.AttackTypes) and (Unit(player):HasBuffs(A.CombustionBuff.ID) < A.GetGCD() and 
			Unit(player):HasBuffs(A.CombustionBuff.ID) > 0) and Temp.CombustionPhase == 5 then
				return A.DragonsBreath:Show(icon)
			end
			
			if A.Scorch:IsReady(unitID) and IsSchoolFireUP() and A.Scorch:AbsentImun(unitID, Temp.AttackTypes) and (Unit(unitID):HealthPercent() <= 30 and A.SearingTouch:IsSpellLearned()) 
			and Unit(player):HasBuffs(A.HotStreakBuff.ID) == 0 and Temp.CombustionPhase == 5 then
				return A.Scorch:Show(icon)
			end
			
		end
		
		if Temp.CombustionPhase == 0 then
			if A.FireBlast:IsReadyByPassCastGCD(unitID, nil, nil, true) and IsSchoolFireUP() and A.FireBlast:AbsentImun(unitID, Temp.AttackTypes) and 
			((A.MemoryofLucidDreams:IsReady(player) or A.MemoryofLucidDreams:GetCooldown() > 0) and A.FireBlast:GetSpellCharges() == A.FireBlast:GetSpellChargesMax() and 
			Unit(player):HasBuffs(A.HotStreakBuff.ID) == 0 and not (Unit(player):HasBuffs(A.HeatingUpBuff.ID) > 0 and (Unit(player):HasBuffs(A.CombustionBuff.ID) > 0 and 
			(A.Fireball:IsSpellInFlight() or A.Pyroblast:IsSpellInFlight() or A.Scorch:IsSpellInCasting()) or Unit(unitID):HealthPercent() <= 30 and A.Scorch:IsSpellInCasting())) and not 
			(Unit(player):HasBuffs(A.HeatingUpBuff.ID) == 0 and Unit(player):HasBuffs(A.HotStreakBuff.ID) == 0 and Unit(player):HasBuffs(A.CombustionBuff.ID) == 0 and 
			(A.Fireball:IsSpellInFlight() or A.Pyroblast:IsSpellInFlight()))) and A.LastPlayerCastID ~= A.FireBlast.ID then
				return A.FireBlast:Show(icon)
			end
			
			if A.FireBlast:IsReadyByPassCastGCD(unitID, nil, nil, true) and IsSchoolFireUP() and A.FireBlast:AbsentImun(unitID, Temp.AttackTypes) and 
			(FirestarterActive(unitID) and A.FireBlast:GetSpellCharges() >= 1 and (not Temp.FireblastPooling or Unit(player):HasBuffs(A.RuneofPowerBuff.ID) > 0) and 
			(A.BlasterMaster:GetAzeriteRank() == 0 or Unit(player):HasBuffs(A.BlasterMasterBuff.ID) <= 0.5) and (not A.Fireball:IsSpellInCasting() and not A.Pyroblast:IsSpellInFlight() and 
			Unit(player):HasBuffs(A.HeatingUpBuff.ID) > 0 or A.Fireball:IsSpellInCasting() and Unit(player):HasBuffs(A.HotStreakBuff.ID) == 0 or A.Pyroblast:IsSpellInFlight() and 
			Unit(player):HasBuffs(A.HeatingUpBuff.ID) == 0 and Unit(player):HasBuffs(A.HotStreakBuff.ID) == 0)) and A.LastPlayerCastID ~= A.FireBlast.ID then
				return A.FireBlast:Show(icon)
			end
		end
		
		-- RoP Phase
		if Unit(player):HasBuffs(A.RuneofPowerBuff.ID) > 0 and Unit(player):HasBuffs(A.CombustionBuff.ID) == 0 and Temp.CombustionPhase == 0 then
			--if A.Flamestrike:IsReady(unitID, true) and IsSchoolFireUP() and A.Flamestrike:AbsentImun(unitID, Temp.AttackTypes) and inAoE and ((A.FlamePatch:IsSpellLearned() and MultiUnits:GetActiveEnemies() > 1 or
		--	MultiUnits:GetActiveEnemies() > 4) and Unit(player):HasBuffs(A.HotStreakBuff.ID) > 0) then
			--	return A.Flamestrike:Show(icon)
		--	end			
			
			if A.Pyroblast:IsReadyByPassCastGCD(unitID, nil, nil, true) and IsSchoolFireUP() and A.Pyroblast:AbsentImun(unitID, Temp.AttackTypes) and Unit(player):HasBuffs(A.HotStreakBuff.ID) > 0 then
				return A.Pyroblast:Show(icon)
			end
			
			if A.FireBlast:IsReadyByPassCastGCD(unitID, nil, nil, true) and IsSchoolFireUP() and A.FireBlast:AbsentImun(unitID, Temp.AttackTypes) and (not (A.FlamePatch:IsSpellLearned() and MultiUnits:GetActiveEnemies() > 2 or
			MultiUnits:GetActiveEnemies() > 5) and inAoE and (not FirestarterActive(unitID) and (A.Combustion:GetCooldown() > 0 or disableCombustion)) and (Unit(player):HasBuffs(A.HeatingUpBuff.ID) == 0 and 
			Unit(player):HasBuffs(A.HotStreakBuff.ID) == 0 and A.LastPlayerCastID ~= A.FireBlast.ID and (A.FireBlast:GetSpellCharges() >= 2 or (A.PhoenixFlames:GetSpellCharges() >=1 and A.PhoenixFlames:IsSpellLearned()) or
			(A.AlexstraszasFury:IsSpellLearned() and A.DragonsBreath:GetCooldown() == 0) or (A.SearingTouch:IsSpellLearned() and Unit(unitID):HealthPercent() <= 30)))) then
				return A.FireBlast:Show(icon)
			end
			
		--	if A.LivingBomb:IsReady(unitID) and IsSchoolFireUP() and A.LivingBomb:AbsentImun(unitID, Temp.AttackTypes) and (MultiUnits:GetActiveEnemies() > 1 and inAoE and
		--	Unit(player):HasBuffs(A.CombustionBuff.ID) == 0 and (A.Combustion:GetCooldown() > 3.5 or A.Combustion:GetCooldown() == 0 or disableCombustion)) then
		--		return A.LivingBomb:Show(icon)
		--	end
	
			if A.Meteor:IsReady(unitID, true) and IsSchoolFireUP() and A.Meteor:AbsentImun(unitID, Temp.AttackTypes) and (Unit(player):HasBuffs(A.RuneofPowerBuff.ID) > 0 and
			(A.Combustion:GetCooldown() == 0 and not disableCombustion or A.Combustion:GetCooldown() > 45) and not FirestarterActive(unitID)) then
				return A.Meteor:Show(icon)
			end
			
			if A.Pyroblast:IsReadyByPassCastGCD(unitID, nil, nil, true) and IsSchoolFireUP() and A.Pyroblast:AbsentImun(unitID, Temp.AttackTypes) and (Unit(player):HasBuffs(A.PyroclasmBuff.ID) > 0 and
			A.Pyroblast:GetSpellCastTime() < Unit(player):HasBuffs(A.PyroclasmBuff.ID) and Unit(player):HasBuffs(A.RuneofPowerBuff.ID) > A.Pyroblast:GetSpellCastTime()) then
				return A.Pyroblast:Show(icon)
			end
			
			if A.FireBlast:IsReadyByPassCastGCD(unitID, nil, nil, true) and IsSchoolFireUP() and A.FireBlast:AbsentImun(unitID, Temp.AttackTypes) and (not (A.FlamePatch:IsSpellLearned() and MultiUnits:GetActiveEnemies() > 2
			or MultiUnits:GetActiveEnemies() > 5) and inAoE and (not FirestarterActive(unitID) and (A.Combustion:GetCooldown() > 0 or disableCombustion)) and (Unit(player):HasBuffs(A.HeatingUpBuff.ID) > 0 and 
			(Unit(unitID):HealthPercent() >= 30 or not A.SearingTouch:IsSpellLearned()))) then
				return A.FireBlast:Show(icon)
			end
			
			if A.FireBlast:IsReadyByPassCastGCD(unitID, nil, nil, true) and IsSchoolFireUP() and A.FireBlast:AbsentImun(unitID, Temp.AttackTypes) and (not (A.FlamePatch:IsSpellLearned() and MultiUnits:GetActiveEnemies() > 2
			or MultiUnits:GetActiveEnemies() > 5) and inAoE and (not FirestarterActive(unitID) and (A.Combustion:GetCooldown() > 0 or disableCombustion)) and A.SearingTouch:IsSpellLearned() and Unit(unitID):HealthPercent() <= 30 and
			(Unit(player):HasBuffs(A.HeatingUpBuff.ID) > 0 and not A.Scorch:IsSpellInCasting() or Unit(player):HasBuffs(A.HeatingUpBuff.ID) == 0 and Unit(player):HasBuffs(A.HotStreakBuff.ID) == 0)) then
				return A.FireBlast:Show(icon)
			end
			
			
			--if A.Pyroblast:IsReadyByPassCastGCD(unitID, nil, nil, true) and IsSchoolFireUP() and A.Pyroblast:AbsentImun(unitID, Temp.AttackTypes) and 
			--(A.LastPlayerCastID == A.Scorch.ID and Unit(player):HasBuffs(A.HeatingUpBuff.ID) > 0 and A.SearingTouch:IsSpellLearned() and Unit(unitID):HealthPercent() <= 30 and 
			--(not A.FlamePatch:IsSpellLearned() or (MultiUnits:GetActiveEnemies() == 1 or not inAoE))) then
			--	return A.Pyroblast:Show(icon)
			--end
			
			if A.Scorch:IsReady(unitID) and IsSchoolFireUP() and A.Scorch:AbsentImun(unitID, Temp.AttackTypes) and (Unit(unitID):HealthPercent() <= 30 and A.SearingTouch:IsSpellLearned()) then
				return A.Scorch:Show(icon)
			end

			if A.FireBlast:IsReadyByPassCastGCD(unitID, nil, nil, true) and IsSchoolFireUP() and A.FireBlast:AbsentImun(unitID, Temp.AttackTypes) and ((A.FlamePatch:IsSpellLearned() and MultiUnits:GetActiveEnemies() > 2 or
			MultiUnits:GetActiveEnemies() > 5) and inAoE and ((A.Combustion:GetCooldown() > 0 or disableCombustion) and not FirestarterActive(unitID)) and Unit(player):HasBuffs(A.HotStreakBuff.ID) == 0 and (A.BlasterMaster:GetAzeriteRank() == 0 or
			Unit(player):HasBuffs(A.BlasterMasterBuff.ID) <= 0.5)) then
				return A.FireBlast:Show(icon)
			end
			
			if A.Flamestrike:IsReady(unitID, true) and IsSchoolFireUP() and A.Flamestrike:AbsentImun(unitID, Temp.AttackTypes) and inAoE and (A.FlamePatch:IsSpellLearned() and MultiUnits:GetActiveEnemies() > 2 or
			MultiUnits:GetActiveEnemies() > 5) then
				return A.Flamestrike:Show(icon)
			end
			
			if A.Fireball:IsReady(unitID) and IsSchoolFireUP() and A.Fireball:AbsentImun(unitID, Temp.AttackTypes) and not inMoving  then
				return A.Fireball:Show(icon)
			end
		end
		
		if Temp.CombustionPhase == 0 then
			-- Standard Rotation
			if A.Flamestrike:IsReady(unitID, true) and IsSchoolFireUP() and A.Flamestrike:AbsentImun(unitID, Temp.AttackTypes) and (((A.FlamePatch:IsSpellLearned() and 
			(inAoE and MultiUnits:GetActiveEnemies() > 1 and not FirestarterActive(unitID)) or inAoE and MultiUnits:GetActiveEnemies() > 4) and Unit(player):HasBuffs(A.HotStreakBuff.ID) > 0)) then
				return A.Flamestrike:Show(icon)
			end
			
			if A.Pyroblast:IsReadyByPassCastGCD(unitID, nil, nil, true) and IsSchoolFireUP() and A.Pyroblast:AbsentImun(unitID, Temp.AttackTypes) and (Unit(player):HasBuffs(A.HotStreakBuff.ID) > 0 and 
			Unit(player):HasBuffs(A.HotStreakBuff.ID) < A.Fireball:ExecuteTime()) then
				return A.Pyroblast:Show(icon)
			end
			
			if A.Pyroblast:IsReadyByPassCastGCD(unitID, nil, nil, true) and IsSchoolFireUP() and A.Pyroblast:AbsentImun(unitID, Temp.AttackTypes) and (Unit(player):HasBuffs(A.HotStreakBuff.ID) > 0 and 
			(A.Fireball:IsSpellInCasting() or A.LastPlayerCastID == A.Fireball.ID or FirestarterActive(unitID) or A.Pyroblast:IsSpellInFlight())) then
				return A.Pyroblast:Show(icon)
			end
			
			if A.PhoenixFlames:IsReady(unitID) and IsSchoolFireUP() and A.PhoenixFlames:AbsentImun(unitID, Temp.AttackTypes) and (A.PhoenixFlames:GetSpellCharges() >= 3 and
			MultiUnits:GetActiveEnemies() > 2 and inAoE and not Temp.PhoenixPooling) then
				return A.PhoenixFlames:Show(icon)
			end
			
			if A.Pyroblast:IsReadyByPassCastGCD(unitID, nil, nil, true) and IsSchoolFireUP() and A.Pyroblast:AbsentImun(unitID, Temp.AttackTypes) and (Unit(player):HasBuffs(A.HotStreakBuff.ID) > 0 and 
			Unit(unitID):HealthPercent() <= 30 and A.SearingTouch:IsSpellLearned()) then
				return A.Pyroblast:Show(icon)
			end
			
			if A.Pyroblast:IsReadyByPassCastGCD(unitID, nil, nil, true) and IsSchoolFireUP() and A.Pyroblast:AbsentImun(unitID, Temp.AttackTypes) and (Unit(player):HasBuffs(A.PyroclasmBuff.ID) > 0 and
			A.Pyroblast:GetSpellCastTime() < Unit(player):HasBuffs(A.PyroclasmBuff.ID)) then
				return A.Pyroblast:Show(icon)
			end
			
			if A.FireBlast:IsReadyByPassCastGCD(unitID, nil, nil, true) and IsSchoolFireUP() and A.FireBlast:AbsentImun(unitID, Temp.AttackTypes) and 
			(((A.Combustion:GetCooldown() > 0 or disableCombustion) and Unit(player):HasBuffs(A.RuneofPowerBuff.ID) == 0 and not FirestarterActive(unitID)) and not 
			A.Kindling:IsSpellLearned() and not Temp.FireblastPooling and (((A.Fireball:IsSpellInCasting() or A.Pyroblast:IsSpellInCasting()) and 
			(Unit(player):HasBuffs(A.HeatingUpBuff.ID) > 0)) or (A.SearingTouch:IsSpellLearned() and Unit(unitID):HealthPercent() <= 30 and (Unit(player):HasBuffs(A.HeatingUpBuff.ID) > 0 and not 
			A.Scorch:IsSpellInCasting() or Unit(player):HasBuffs(A.HotStreakBuff.ID) == 0 and Unit(player):HasBuffs(A.HeatingUpBuff.ID) == 0 and A.Scorch:IsSpellInCasting() and not 
			A.Pyroblast:IsSpellInFlight() and not A.Fireball:IsSpellInFlight())))) and A.LastPlayerCastID ~= A.FireBlast.ID then
				return A.FireBlast:Show(icon)
			end
			
		--	if A.FireBlast:IsReady(unitID) and IsSchoolFireUP() and A.FireBlast:AbsentImun(unitID, Temp.AttackTypes) and (A.Kindling:IsSpellLearned() and Unit(player):HasBuffs(A.HeatingUpBuff.ID) > 0
		--	and not FirestarterActive(unitID) and (A.Combustion:GetCooldown() > A.FireBlast:GetSpellChargesFullRechargeTime() + 2 + num(A.Kindling:IsSpellLearned()) or disableCombustion or 
		--	(not A.RuneofPower:IsSpellLearned() or A.RuneofPower:GetCooldown() > Unit(unitID):TimeToDie() and A.RuneofPower:GetSpellCharges() < 1) and A.Combustion:GetCooldown() > Unit(unitID):TimeToDie())) then
		--		return A.FireBlast:Show(icon)
		--	end
			
			
			--if A.Pyroblast:IsReadyByPassCastGCD(unitID, nil, nil, true) and IsSchoolFireUP() and A.Pyroblast:AbsentImun(unitID, Temp.AttackTypes) and 
			--(A.LastPlayerCastID == A.Scorch.ID and Unit(player):HasBuffs(A.HeatingUpBuff.ID) > 0 and A.SearingTouch:IsSpellLearned() and Unit(unitID):HealthPercent() <= 30 and 
			--((A.FlamePatch:IsSpellLearned() and	(inAoE and MultiUnits:GetActiveEnemies() == 1 or not inAoE) and not FirestarterActive(unitID)) or ((inAoE and MultiUnits:GetActiveEnemies() < 4 or not inAoE)
			--and	not A.FlamePatch:IsSpellLearned()))) then
			--	return A.Pyroblast:Show(icon)
			--end
			
			if A.PhoenixFlames:IsReady(unitID) and IsSchoolFireUP() and A.PhoenixFlames:AbsentImun(unitID, Temp.AttackTypes) and (Unit(player):HasBuffs(A.HeatingUpBuff.ID) > 0 or
			(Unit(player):HasBuffs(A.HeatingUpBuff.ID) == 0 and (A.FireBlast:GetSpellCharges() > 0 or A.SearingTouch:IsSpellLearned() and Unit(unitID):HealthPercent() <= 30))) and
			not Temp.PhoenixPooling then
				return A.PhoenixFlames:Show(icon)
			end
			
		--	if A.LivingBomb:IsReady(unitID) and IsSchoolFireUP() and A.LivingBomb:AbsentImun(unitID, Temp.AttackTypes) and (MultiUnits:GetActiveEnemies() > 1 and inAoE and
		--	Unit(player):HasBuffs(A.CombustionBuff.ID) == 0 and (A.Combustion:GetCooldown() > 3.5 or A.Combustion:GetCooldown() == 0 or disableCombustion)) then
		--		return A.LivingBomb:Show(icon)
		--	end
		
			--if A.Meteor:IsReady(unitID, true) and IsSchoolFireUP() and A.Meteor:AbsentImun(unitID, Temp.AttackTypes) and (Unit(player):HasBuffs(A.RuneofPowerBuff.ID) > 0 and
		--	(Unit(unitID):TimeToDieX(90) > 3 or not FirestarterActive(unitID)) or A.RuneofPower:GetCooldown() < Unit(unitID):TimeToDie() or A.RuneofPower:GetSpellCharges() < 1 or 
		--	(3 < A.Combustion:GetCooldown() or A.Combustion:GetCooldown() == 0 or disableCombustion) and not A.RuneofPower:IsSpellLearned() and (3 < Unit(unitID):TimeToDieX(90) or
		--	not FirestarterActive(unitID))) then
		--		return A.Meteor:Show(icon)
		--	end
			
			if A.Scorch:IsReady(unitID) and IsSchoolFireUP() and A.Scorch:AbsentImun(unitID, Temp.AttackTypes) and (Unit(unitID):HealthPercent() <= 30 and A.SearingTouch:IsSpellLearned()) then
				return A.Scorch:Show(icon)
			end
			
			
			if A.FireBlast:IsReadyByPassCastGCD(unitID, nil, nil, true) and IsSchoolFireUP() and A.FireBlast:AbsentImun(unitID, Temp.AttackTypes) and 
			(not Temp.FireblastPooling and (A.FlamePatch:IsSpellLearned() and (MultiUnits:GetActiveEnemies() > 2 and inAoE or not inAoE) or (inAoE and MultiUnits:GetActiveEnemies() > 9 or not inAoE)) and 
			((A.Combustion:GetCooldown() > 0 or disableCombustion) and not FirestarterActive(unitID)) and Unit(player):HasBuffs(A.HotStreakBuff.ID) == 0 and (A.BlasterMaster:GetAzeriteRank() == 0 or 
			Unit(player):HasBuffs(A.BlasterMasterBuff.ID) <= 0.5)) and A.LastPlayerCastID ~= A.FireBlast.ID then
				return A.FireBlast:Show(icon)
			end
			
			if A.Flamestrike:IsReady(unitID, true) and IsSchoolFireUP() and A.Flamestrike:AbsentImun(unitID, Temp.AttackTypes) and inAoE and (A.FlamePatch:IsSpellLearned() and MultiUnits:GetActiveEnemies() > 2 or
			MultiUnits:GetActiveEnemies() > 9) then
				return A.Flamestrike:Show(icon)
			end
			
			
			if A.Fireball:IsReady(unitID) and IsSchoolFireUP() and A.Fireball:AbsentImun(unitID, Temp.AttackTypes) and not inMoving then
				return A.Fireball:Show(icon)
			end
			
			if A.Scorch:IsReady(unitID) and IsSchoolFireUP() and A.Scorch:AbsentImun(unitID, Temp.AttackTypes) and Player:IsMovingTime() > 2 then
				return A.Scorch:Show(icon)
			end
		end	
	end
	
	if A.IsUnitEnemy("target") and not Unit("target"):IsDead() then 
		unitID = "target"
        
		if Enemy(unitID) then 
			return true 
		end 
	end
end