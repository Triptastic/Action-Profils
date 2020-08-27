-----------------------------
-- ZakLL TMW Action Rotation
-----------------------------

local TMW								= TMW 
local Action							= Action
local TeamCache							= Action.TeamCache
local EnemyTeam							= Action.EnemyTeam
local FriendlyTeam						= Action.FriendlyTeam
local LoC								= Action.LossOfControl
local Player							= Action.Player 
local MultiUnits						= Action.MultiUnits
local UnitCooldown						= Action.UnitCooldown
local Unit								= Action.Unit 

Action[ACTION_CONST_WARRIOR_ARMS] = {
    -- Racial
	ArcaneTorrent						= Action.Create({ Type = "Spell", ID = 50613}),
	BloodFury							= Action.Create({ Type = "Spell", ID = 20572}),
	Fireblood							= Action.Create({ Type = "Spell", ID = 265221}),
	AncestralCall						= Action.Create({ Type = "Spell", ID = 274738}),
	Berserking							= Action.Create({ Type = "Spell", ID = 26297}),
	ArcanePulse							= Action.Create({ Type = "Spell", ID = 260364}),
	QuakingPalm							= Action.Create({ Type = "Spell", ID = 107079}),
	Haymaker							= Action.Create({ Type = "Spell", ID = 287712}), 
	BullRush							= Action.Create({ Type = "Spell", ID = 255654}),    
	WarStomp							= Action.Create({ Type = "Spell", ID = 20549}),
	GiftofNaaru							= Action.Create({ Type = "Spell", ID = 59544}),
	Shadowmeld							= Action.Create({ Type = "Spell", ID = 58984}),
	Stoneform							= Action.Create({ Type = "Spell", ID = 20594}), 
	WilloftheForsaken					= Action.Create({ Type = "Spell", ID = 7744}),
	EscapeArtist						= Action.Create({ Type = "Spell", ID = 20589}),
	EveryManforHimself					= Action.Create({ Type = "Spell", ID = 59752}),
	-- CrownControl
	StormBoltGreen						= Action.Create({ Type = "SpellSingleColor", ID = 107570, Color = "GREEN", Desc = "[1] CC", QueueForbidden = true }),
	StormBoltAntiFake                   = Action.Create({ Type = "Spell", ID = 107570, Desc = "[2] Kick", QueueForbidden = true    }),
	Pummel                              = Action.Create({ Type = "Spell", ID = 6552    }),
	PummelGreen							= Action.Create({ Type = "SpellSingleColor", ID = 6552, Color = "GREEN", Desc = "[2] Kick", QueueForbidden = true }),  
	IntimidatingShout                   = Action.Create({ Type = "Spell", ID = 5246    }),
	Hamstring							= Action.Create({ Type = "Spell", ID = 1715    }),
	Taunt								= Action.Create({ Type = "Spell", ID = 355, Desc = "[6] PvP Pets Taunt", QueueForbidden = true}),
	-- Suppotive  
	RallyingCry							= Action.Create({ Type = "Spell", ID = 97462}),
	-- Self Defensive
	BerserkerRage						= Action.Create({ Type = "Spell", ID = 18499}),
	DiebytheSword						= Action.Create({ Type = "Spell", ID = 118038}),
	VictoryRush							= Action.Create({ Type = "Spell", ID = 34428}),
	-- Spells
	Overpower							= Action.Create({ Type = "Spell", ID = 7384}),
	MortalStrike						= Action.Create({ Type = "Spell", ID = 12294}),
	ColossusSmash						= Action.Create({ Type = "Spell", ID = 167105}),
	Slam								= Action.Create({ Type = "Spell", ID = 1464}),
	Bladestorm							= Action.Create({ Type = "Spell", ID = 227847}),
	Execute								= Action.Create({ Type = "Spell", ID = 5308}),
	Whirlwind							= Action.Create({ Type = "Spell", ID = 1680}),
	SweepingStrikes						= Action.Create({ Type = "Spell", ID = 260708}),
	-- Buffs
	VictoriousBuff						= Action.Create({ Type = "Spell", ID = 32216, Hidden = true}),
	SweepingStrikesBuff					= Action.Create({ Type = "Spell", ID = 260708, Hidden = true}),
	TestofMightBuff						= Action.Create({ Type = "Spell", ID = 275540, Hidden = true}),
	SuddenDeathBuff						= Action.Create({ Type = "Spell", ID = 52437, Hidden = true}),
	DeadlyCalmBuff						= Action.Create({ Type = "Spell", ID = 262228, Hidden = true}),
	CrushingAssaultBuff					= Action.Create({ Type = "Spell", ID = 278826, Hidden = true}),
	ExecutionersPrecisionBuff			= Action.Create({ Type = "Spell", ID = 272866, Hidden = true}),
	-- Debuffs
	RendDebuff							= Action.Create({ Type = "Spell", ID = 772, Hidden = true}),
	ColossusSmashDebuff					= Action.Create({ Type = "Spell", ID = 208086, Hidden = true}),
	DeepWoundsDebuff					= Action.Create({ Type = "Spell", ID = 262115, Hidden = true}),
	-- Trinkets
   
	-- Talents
	WarMachine							= Action.Create({ Type = "Spell", ID = 262231, isTalent = true}),	-- Talent 1/1
	SuddenDeath							= Action.Create({ Type = "Spell", ID = 29725, isTalent = true}),	-- Talent 1/2
	Skullsplitter						= Action.Create({ Type = "Spell", ID = 260643, isTalent = true}),	-- Talent 1/3
	DoubleTime							= Action.Create({ Type = "Spell", ID = 103827, isTalent = true}),	-- Talent 2/1
	ImpendingVictory					= Action.Create({ Type = "Spell", ID = 202168, isTalent = true}),	-- Talent 2/2
	StormBolt							= Action.Create({ Type = "Spell", ID = 107570, isTalent = true}),	-- Talent 2/3
	Massacre							= Action.Create({ Type = "Spell", ID = 281001, isTalent = true}),	-- Talent 3/1
	FervorofBattle						= Action.Create({ Type = "Spell", ID = 202316, isTalent = true}),	-- Talent 3/2
	Rend								= Action.Create({ Type = "Spell", ID = 772, isTalent = true}),		-- Talent 3/3
	SecondWind							= Action.Create({ Type = "Spell", ID = 29838, isTalent = true}),	-- Talent 4/1
	BoundingStride						= Action.Create({ Type = "Spell", ID = 202163, isTalent = true}),	-- Talent 4/2
	DefensiveStance						= Action.Create({ Type = "Spell", ID = 197690, isTalent = true}),	-- Talent 4/3
	BattleStance						= Action.Create({ Type = "Spell", ID = 212520, isTalent = true}),	-- Talent 4/3
	CollateralDamage					= Action.Create({ Type = "Spell", ID = 268243, isTalent = true}),	-- Talent 5/1
	Warbreaker							= Action.Create({ Type = "Spell", ID = 262161, isTalent = true}),	-- Talent 5/2
	Cleave								= Action.Create({ Type = "Spell", ID = 845, isTalent = true}),		-- Talent 5/3
	InForTheKill						= Action.Create({ Type = "Spell", ID = 248621, isTalent = true}),	-- Talent 6/1
	Avatar								= Action.Create({ Type = "Spell", ID = 107574, isTalent = true}),	-- Talent 6/2
	DeadlyCalm							= Action.Create({ Type = "Spell", ID = 262228, isTalent = true}),	-- Talent 6/3
	AngerManagement						= Action.Create({ Type = "Spell", ID = 152278, isTalent = true}),	-- Talent 7/1
	Dreadnaught							= Action.Create({ Type = "Spell", ID = 262150, isTalent = true}),	-- Talent 7/2
	Ravager								= Action.Create({ Type = "Spell", ID = 152277, isTalent = true}),	-- Talent 7/3
   -- PvP Talents
	WarBanner							= Action.Create({ Type = "Spell", ID = 236320, isTalent = true}), -- PvP Talent
	SharpenBlade						= Action.Create({ Type = "Spell", ID = 198817, isTalent = true}), -- PvP Talent
	Disarm								= Action.Create({ Type = "Spell", ID = 236077, isTalent = true}), -- PvP Talent 
	-- Hidden
	SeismicWave							= Action.Create({ Type = "Spell", ID = 277639, Hidden = true}), -- Simcraft Azerite
	TestofMight							= Action.Create({ Type = "Spell", ID = 275529, Hidden = true}), -- Simcraft Azerite
    
}

Action:CreateEssencesFor(ACTION_CONST_WARRIOR_ARMS)
local A 								= setmetatable(Action[ACTION_CONST_WARRIOR_ARMS], { __index = Action })

local player 							= "player"
local targettarget						= "targettarget"
local UnitIsUnit						= UnitIsUnit
local Temp								= {
	AttackTypes 						= {"TotalImun", "DamagePhysImun"},	
	AuraForStun							= {"TotalImun", "DamagePhysImun", "CCTotalImun", "StunImun"},	
	AuraForCC							= {"TotalImun", "DamagePhysImun", "CCTotalImun"},
	AuraForOnlyCCAndStun				= {"CCTotalImun", "StunImun"},
	AuraForDisableMag					= {"TotalImun", "DamageMagicImun", "Freedom", "CCTotalImun"},
	AuraForInterrupt					= {"TotalImun", "DamagePhysImun", "KickImun"},
}

local function InMelee(unitID)
	-- @return boolean 
	return A.MortalStrike:IsInRange(unitID)
end 

local BlackListedTrinkets = {

    [1] = 167555, -- Pocket Sized Computation Device
	[2] = 169314, -- Azsharas Font of Power
    [3] = 169311, -- AshvanesRazorCoral
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


-- [1] CC AntiFake Rotation
local function AntiFakeStun(unit) 
    return 
    A.IsUnitEnemy(unit) and  
    Unit(unit):GetRange() <= 20 and 
    Unit(unit):IsControlAble("stun", 0) and 
    A.StormBoltGreen:AbsentImun(unit, Temp.TotalAndPhysAndCCAndStun, true)          
end 
A[1] = function(icon)    
    if	A.StormBoltGreen:IsReady(nil, nil, nil, true) and 
    (
        AntiFakeStun("mouseover") or 
        AntiFakeStun("target") or 
        (
            not A.IsUnitEnemy("mouseover") and 
            not A.IsUnitEnemy("target")
        )
    )
    then 
        return A.StormBoltGreen:Show(icon)         
    end                                                                     
end

-- [2] Kick AntiFake Rotation
A[2] = function(icon)        
    local unit
    if A.IsUnitEnemy("mouseover") then 
        unit = "mouseover"
    elseif A.IsUnitEnemy("target") then 
        unit = "target"
    end 
    
    if unit then         
        local castLeft, _, _, _, notKickAble = Unit(unit):IsCastingRemains()
        if castLeft > 0 then             
            if not notKickAble and A.PummelGreen:IsReady(unit, nil, nil, true) and A.PummelGreen:AbsentImun(unit, Temp.TotalAndPhysKick, true) then
                return A.PummelGreen:Show(icon)                                                  
            end 
            
            if A.StormBoltAntiFake:IsReady(unit, nil, nil, true) and A.StormBoltAntiFake:AbsentImun(unit, Temp.TotalAndPhysAndStun, true) and Unit(unit):IsControlAble("stun", 0) then
                return A.StormBoltAntiFake:Show(icon)                  
            end 
            
            -- Racials 
            if A.QuakingPalm:IsRacialReadyP(unit, nil, nil, true) then 
                return A.QuakingPalm:Show(icon)
            end 
            
            if A.Haymaker:IsRacialReadyP(unit, nil, nil, true) then 
                return A.Haymaker:Show(icon)
            end 
            
            if A.WarStomp:IsRacialReadyP(unit, nil, nil, true) then 
                return A.WarStomp:Show(icon)
            end 
            
            if A.BullRush:IsRacialReadyP(unit, nil, nil, true) then 
                return A.BullRush:Show(icon)
            end                         
        end 
    end                                                                                 
end

-----------------------------------------
--                 ROTATION  
-----------------------------------------
local function SelfDefensives()
    if Unit("player"):CombatTime() == 0 then 
        return 
    end 
    
    local RallyingCry = A.GetToggle(2, "RallyingCry")
    if     RallyingCry >= 0 and A.RallyingCry:IsReady("player") and 
    (
        (     -- Auto 
            RallyingCry >= 100 and 
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
            RallyingCry < 100 and 
            Unit("player"):HealthPercent() <= RallyingCry
        )
    ) 
    then 
        return A.RallyingCry
    end  
end 
SelfDefensives = A.MakeFunctionCachedStatic(SelfDefensives)

local function Interrupts(unit)
    local useKick, useCC, useRacial = A.InterruptIsValid(unit, "TargetMouseover")    
    
    if useKick and A.Pummel:IsReady(unit) and A.Pummel:AbsentImun(unit, Temp.TotalAndPhysKick, true) and Unit(unit):CanInterrupt(true) then 
        return A.Pummel
    end 
    
    if useCC and A.StormBolt:IsReady(unit) and A.StormBolt:AbsentImun(unit, Temp.TotalAndPhysAndCCAndStun, true) and Unit(unit):IsControlAble("stun", 0) then
        return A.StormBolt              
    end          
	
	--if useCC and A.IntimidatingShout:IsReady(unit) and A.IntimidatingShout:AbsentImun(unit, {"TotalImun", "DamagePhysImun", "CCTotalImun"}, true) and Unit(unit):IsControlAble("disorient", 0) then 
      --  return A.IntimidatingShout              
   -- end
    
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
Interrupts = A.MakeFunctionCachedDynamic(Interrupts)


-- [3] Single Rotation
A[3] = function(icon)
	local rage 		  							= Player:Rage()
	local inAoE									= A.GetToggle(2, "AoE")
	local combatTime							= Unit(player):CombatTime()
	local inCombat								= combatTime > 0
	local Trinket1IsAllowed, Trinket2IsAllowed 	= TrinketIsAllowed()
	local TrinketON								= ((Action.GetToggle(1, "Trinkets")[1]) or (Action.GetToggle(1, "Trinkets")[2]))
	
	
	
	
	local function EnemyPvE(unitID)
		-- CDs 
		if A.BurstIsON(unitID) and InMelee(unitID) and inCombat then
			
			if A.SweepingStrikes:IsReady(player) and (inAoE and MultiUnits:GetByRange(8, 2) > 1) and (A.Bladestorm:GetCooldown() > 10 or (not A.Warbreaker:IsSpellLearned() 
			and A.ColossusSmash:GetCooldown() > 8 or A.Warbreaker:GetCooldown() > 8) or A.TestofMight:GetAzeriteRank() >= 1) then
				return A.SweepingStrikes:Show(icon)
			end
			
			if A.BloodoftheEnemy:AutoHeartOfAzerothP(unitID) and (Unit(player):HasBuffs(A.TestofMightBuff.ID) > 0 or (Unit(unitID):HasDeBuffs(A.ColossusSmashDebuff.ID) > 0 and
			A.TestofMight:GetAzeriteRank() == 0)) then
				return A.BloodoftheEnemy:Show(icon) 
			end
			
			if A.MemoryofLucidDreams:AutoHeartOfAzerothP(unitID) and (not A.Warbreaker:IsSpellLearned() and A.ColossusSmash:GetCooldown() < 3 or A.Warbreaker:GetCooldown() < 3) then
				return A.MemoryofLucidDreams:Show(icon)
			end
		end
		
		-- Five Targets
		if inAoE and MultiUnits:GetByRange(8, 5) > 4 then
			if A.Skullsplitter:IsReady(unitID) and A.Skullsplitter:AbsentImun(unitID, Temp.AttackTypes) and (rage < 60 and (not A.DeadlyCalm:IsSpellLearned() or 
			Unit(player):HasBuffs(A.DeadlyCalmBuff.ID) == 0)) then
				return A.Skullsplitter:Show(icon)
			end
			
			if A.BurstIsON(unitID) and InMelee(unitID) then
				if A.Ravager:IsReady(unitID, true) and A.Ravager:AbsentImun(unitID, Temp.AttackTypes) and (Unit(unitID):TimeToDie() > 4 and 
				(A.ColossusSmash:GetCooldown() < 2 or (A.Warbreaker:IsSpellLearned() and A.Warbreaker:GetCooldown() < 2))) then
					return A.Ravager:Show(icon)
				end
				
				if A.ColossusSmash:IsReady(unitID) and A.ColossusSmash:AbsentImun(unitID, Temp.AttackTypes) and not A.Warbreaker:IsSpellLearned() and Unit(unitID):TimeToDie() > 2 then
					return A.ColossusSmash:Show(icon)
				end
				
				if A.Warbreaker:IsReady(unitID, true) and A.Warbreaker:AbsentImun(unitID, Temp.AttackTypes) and A.Warbreaker:IsSpellLearned() and Unit(unitID):TimeToDie() > 2 then
					return A.Warbreaker:Show(icon)
				end
				
				if A.Bladestorm:IsReady(unitID, true) and A.Bladestorm:AbsentImun(unitID, Temp.AttackTypes) and Unit(unitID):TimeToDie() > 2 and 
				(Unit(player):HasBuffs(A.SweepingStrikesBuff.ID) == 0 and (not A.DeadlyCalm:IsSpellLearned() or Unit(player):HasBuffs(A.DeadlyCalmBuff.ID) == 0) and 
				((Unit(unitID):HasDeBuffs(A.ColossusSmashDebuff.ID) > 4.5 and A.TestofMight:GetAzeriteRank() == 0) or Unit(player):HasBuffs(A.TestofMightBuff.ID) > 0)) then
					return A.Bladestorm:Show(icon)
				end
				
				if A.DeadlyCalm:IsReady(player) then
					return A.DeadlyCalm:Show(icon)
				end
			end
			
			if A.Cleave:IsReady(unitID, true) and A.Cleave:AbsentImun(unitID, Temp.AttackTypes) and InMelee(unitID) then
				return A.Cleave:Show(icon)
			end
			
			if A.Execute:IsReady(unitID) and A.Execute:AbsentImun(unitID, Temp.AttackTypes) and ((not A.Cleave:IsSpellLearned() and Unit(unitID):HasDeBuffs(A.DeepWoundsDebuff.ID) < 2) or
			Unit(player):HasBuffs(A.SuddenDeathBuff.ID) > 0 and (Unit(player):HasBuffs(A.SweepingStrikesBuff.ID) > 0 or A.SweepingStrikes:GetCooldown() > 8)) then
				return A.Execute:Show(icon)
			end
			
			if A.MortalStrike:IsReady(unitID) and A.MortalStrike:AbsentImun(unitID, Temp.AttackTypes) and ((not A.Cleave:IsSpellLearned() and Unit(unitID):HasDeBuffs(A.DeepWoundsDebuff.ID) < 2) or
			Unit(player):HasBuffs(A.SweepingStrikesBuff.ID) > 0 and Unit(player):HasBuffsStacks(A.Overpower.ID, true) == 2 and (A.Dreadnaught:IsSpellLearned() or 
			Unit(player):HasBuffsStacks(A.ExecutionersPrecisionBuff.ID, true) == 2)) then
				return A.MortalStrike:Show(icon)
			end
			
			if A.Whirlwind:IsReady(unitID, true) and A.Whirlwind:AbsentImun(unitID, Temp.AttackTypes) and InMelee(unitID) and (Unit(unitID):HasDeBuffs(A.ColossusSmashDebuff.ID) > 0 or
			(A.FervorofBattle:IsSpellLearned() and Unit(player):HasBuffs(A.CrushingAssaultBuff.ID) > 0)) then
				return A.Whirlwind:Show(icon)
			end
			
			if A.Whirlwind:IsReady(unitID, true) and A.Whirlwind:AbsentImun(unitID, Temp.AttackTypes) and InMelee(unitID) and (Unit(player):HasBuffs(A.DeadlyCalmBuff.ID) > 0 or
			rage > 60) then
				return A.Whirlwind:Show(icon)
			end
			
			if A.Overpower:IsReady(unitID) and A.Overpower:AbsentImun(unitID, Temp.AttackTypes) then
				return A.Overpower:Show(icon)
			end
			
			if A.Whirlwind:IsReady(unitID, true) and A.Whirlwind:AbsentImun(unitID, Temp.AttackTypes) and InMelee(unitID) then
				return A.Whirlwind:Show(icon)
			end
		end
		
		-- Hac 
		if inAoE and MultiUnits:GetByRange(8, 2) > 1 then
			if A.Rend:IsReady(unitID) and A.Rend:AbsentImun(unitID, Temp.AttackTypes) and (Unit(unitID):HasDeBuffs(A.RendDebuff.ID) <= A.GetGCD() + A.GetCurrentGCD() and 
			Unit(player):HasBuffs(A.SweepingStrikesBuff.ID) > 0) then
				return A.Rend:Show(icon)
			end
			
			if A.Skullsplitter:IsReady(unitID) and A.Skullsplitter:AbsentImun(unitID, Temp.AttackTypes) and (rage < 60 and (A.DeadlyCalm:GetCooldown() > 3 or not A.DeadlyCalm:IsSpellLearned())) then
				return A.Skullsplitter:Show(icon)
			end
			
			if A.BurstIsON(unitID) and InMelee(unitID) then
				if A.DeadlyCalm:IsReady(player) and ((A.Bladestorm:GetCooldown() > 6 or A.Ravager:IsSpellLearned() and A.Ravager:GetCooldown() > 6) and (A.ColossusSmash:GetCooldown() < 2 or 
				(A.Warbreaker:IsSpellLearned() and A.Warbreaker:GetCooldown() < 2))) then
					return A.DeadlyCalm:Show(icon)
				end
			
				if A.Ravager:IsReady(unitID, true) and A.Ravager:AbsentImun(unitID, Temp.AttackTypes) and (Unit(unitID):TimeToDie() > 4 and 
				(A.ColossusSmash:GetCooldown() < 2 or (A.Warbreaker:IsSpellLearned() and A.Warbreaker:GetCooldown() < 2))) then
					return A.Ravager:Show(icon)
				end
				
				if A.ColossusSmash:IsReady(unitID) and A.ColossusSmash:AbsentImun(unitID, Temp.AttackTypes) and not A.Warbreaker:IsSpellLearned() and Unit(unitID):TimeToDie() > 2 then
					return A.ColossusSmash:Show(icon)
				end
				
				if A.Warbreaker:IsReady(unitID, true) and A.Warbreaker:AbsentImun(unitID, Temp.AttackTypes) and A.Warbreaker:IsSpellLearned() and Unit(unitID):TimeToDie() > 2 then
					return A.Warbreaker:Show(icon)
				end

				if A.Bladestorm:IsReady(unitID, true) and A.Bladestorm:AbsentImun(unitID, Temp.AttackTypes) and Unit(unitID):TimeToDie() > 2 and 
				(Unit(unitID):HasDeBuffs(A.ColossusSmashDebuff.ID) > 4.5 or Unit(player):HasBuffs(A.TestofMightBuff.ID) > 0) then
					return A.Bladestorm:Show(icon)
				end				
			end
			
			if A.Overpower:IsReady(unitID) and A.Overpower:AbsentImun(unitID, Temp.AttackTypes) and A.SeismicWave:GetAzeriteRank() > 0 then
				return A.Overpower:Show(icon)
			end
			
			if A.Cleave:IsReady(unitID, true) and A.Cleave:AbsentImun(unitID, Temp.AttackTypes) and InMelee(unitID) and MultiUnits:GetByRange(8, 3) > 2 then
				return A.Cleave:Show(icon)
			end
			
			if A.Execute:IsReady(unitID) and A.Execute:AbsentImun(unitID, Temp.AttackTypes) and ((not A.Cleave:IsSpellLearned() and Unit(unitID):HasDeBuffs(A.DeepWoundsDebuff.ID) < 2) or
			Unit(player):HasBuffs(A.SuddenDeathBuff.ID) > 0) then
				return A.Execute:Show(icon)
			end
			
			if A.MortalStrike:IsReady(unitID) and A.MortalStrike:AbsentImun(unitID, Temp.AttackTypes) and (not A.Cleave:IsSpellLearned() and Unit(unitID):HasDeBuffs(A.DeepWoundsDebuff.ID) < 2) then
				return A.MortalStrike:Show(icon)
			end
			
			if A.Whirlwind:IsReady(unitID, true) and A.Whirlwind:AbsentImun(unitID, Temp.AttackTypes) and InMelee(unitID) then
				return A.Whirlwind:Show(icon)
			end
			
			if A.Overpower:IsReady(unitID) and A.Overpower:AbsentImun(unitID, Temp.AttackTypes) then
				return A.Overpower:Show(icon)
			end
		end
		
		-- Execute 
		if (A.Massacre:IsSpellLearned() and Unit(unitID):HealthPercent() < 35) or Unit(unitID):HealthPercent() < 20 then
			if A.Skullsplitter:IsReady(unitID) and A.Skullsplitter:AbsentImun(unitID, Temp.AttackTypes) and (rage < 60 and Unit(player):HasBuffs(A.DeadlyCalmBuff.ID) == 0 and
			Unit(player):HasBuffs(A.MemoryofLucidDreams.ID) == 0) then
				return A.Skullsplitter:Show(icon)
			end
			
			if A.BurstIsON(unitID) and InMelee(unitID) then
				if A.Ravager:IsReady(unitID, true) and A.Ravager:AbsentImun(unitID, Temp.AttackTypes) and (Unit(unitID):TimeToDie() > 4 and Unit(player):HasBuffs(A.DeadlyCalmBuff.ID) == 0 and 
				(A.ColossusSmash:GetCooldown() < 2 or (A.Warbreaker:IsSpellLearned() and A.Warbreaker:GetCooldown() < 2))) then				
					return A.Ravager:Show(icon)
				end
				
				if A.ColossusSmash:IsReady(unitID) and A.ColossusSmash:AbsentImun(unitID, Temp.AttackTypes) and not A.Warbreaker:IsSpellLearned() and (not A.MemoryofLucidDreams:IsReady(player) or
				(Unit(player):HasBuffs(A.MemoryofLucidDreams.ID, true) > 0 or A.MemoryofLucidDreams:GetCooldown() > 10)) then
					return A.ColossusSmash:Show(icon)
				end
				
				if A.Warbreaker:IsReady(unitID, true) and A.Warbreaker:AbsentImun(unitID, Temp.AttackTypes) and A.Warbreaker:IsSpellLearned() and Unit(unitID):TimeToDie() > 2 and 
				(not A.MemoryofLucidDreams:IsReady(player) or (Unit(player):HasBuffs(A.MemoryofLucidDreams.ID, true) > 0 or A.MemoryofLucidDreams:GetCooldown() > 10)) then
					return A.Warbreaker:Show(icon)
				end
				
				if A.DeadlyCalm:IsReady(player) then
					return A.DeadlyCalm:Show(icon)
				end
				
				if A.Bladestorm:IsReady(unitID, true) and A.Bladestorm:AbsentImun(unitID, Temp.AttackTypes) and Unit(unitID):TimeToDie() > 2 and
				(Unit(player):HasBuffs(A.MemoryofLucidDreams.ID, true) == 0 and (Unit(unitID):HasDeBuffs(A.ColossusSmashDebuff.ID) > 0 and A.TestofMight:GetAzeriteRank() == 0 or 
				Unit(player):HasBuffs(A.TestofMightBuff.ID) > 0) and rage < 30 and Unit(player):HasBuffs(A.DeadlyCalmBuff.ID) == 0) then
					return A.Bladestorm:Show(icon)
				end
			end
			
			if A.Slam:IsReady(unitID) and A.Slam:AbsentImun(unitID, Temp.AttackTypes) and (Unit(player):HasBuffs(A.CrushingAssaultBuff.ID) > 0 and 
			Unit(player):HasBuffs(A.MemoryofLucidDreams.ID, true) == 0) then
				return A.Slam:Show(icon)
			end
			
			if A.MortalStrike:IsReady(unitID) and A.MortalStrike:AbsentImun(unitID, Temp.AttackTypes) and (Unit(player):HasBuffsStacks(A.Overpower.ID, true) == 2 and
			A.Dreadnaught:IsSpellLearned() or Unit(player):HasBuffsStacks(A.ExecutionersPrecisionBuff.ID, true) == 2) then
				return A.MortalStrike:Show(icon)
			end
			
			if A.Execute:IsReady(unitID) and A.Execute:AbsentImun(unitID, Temp.AttackTypes) and (Unit(player):HasBuffs(A.MemoryofLucidDreams.ID, true) > 0 or 
			Unit(player):HasBuffs(A.DeadlyCalmBuff.ID) > 0) then
				return A.Execute:Show(icon)
			end
			
			if A.Overpower:IsReady(unitID) and A.Overpower:AbsentImun(unitID, Temp.AttackTypes) then
				return A.Overpower:Show(icon)
			end
			
			if A.Execute:IsReady(unitID) and A.Execute:AbsentImun(unitID, Temp.AttackTypes) then
				return A.Execute:Show(icon)
			end
		end
		
		
		-- Single Target
		if (inAoE and MultiUnits:GetByRange(8, 2) == 1 or not inAoE) and  
		(A.Massacre:IsSpellLearned() and Unit(unitID):HealthPercent() > 35) or Unit(unitID):HealthPercent() > 20 then
			if A.Rend:IsReady(unitID) and A.Rend:AbsentImun(unitID, Temp.AttackTypes) and (Unit(unitID):HasDeBuffs(A.RendDebuff.ID) <= A.GetGCD() + A.GetCurrentGCD() and
			Unit(unitID):HasDeBuffs(A.ColossusSmashDebuff.ID) == 0) then
				return A.Rend:Show(icon)
			end
			
			if A.Skullsplitter:IsReady(unitID) and A.Skullsplitter:AbsentImun(unitID, Temp.AttackTypes) and (rage < 60 and Unit(player):HasBuffs(A.DeadlyCalmBuff.ID) == 0 and
			Unit(player):HasBuffs(A.MemoryofLucidDreams.ID) == 0) then
				return A.Skullsplitter:Show(icon)
			end
			
			if A.BurstIsON(unitID) and InMelee(unitID) then
				if A.Ravager:IsReady(unitID, true) and A.Ravager:AbsentImun(unitID, Temp.AttackTypes) and (Unit(unitID):TimeToDie() > 4 and Unit(player):HasBuffs(A.DeadlyCalmBuff.ID) == 0 and 
				(A.ColossusSmash:GetCooldown() < 2 or (A.Warbreaker:IsSpellLearned() and A.Warbreaker:GetCooldown() < 2))) then
					return A.Ravager:Show(icon)
				end
				
				if A.ColossusSmash:IsReady(unitID) and A.ColossusSmash:AbsentImun(unitID, Temp.AttackTypes) and not A.Warbreaker:IsSpellLearned() and (not A.MemoryofLucidDreams:IsReady(player) or
				(Unit(player):HasBuffs(A.MemoryofLucidDreams.ID, true) > 0 or A.MemoryofLucidDreams:GetCooldown() > 10)) then
					return A.ColossusSmash:Show(icon)
				end
				
				if A.Warbreaker:IsReady(unitID, true) and A.Warbreaker:AbsentImun(unitID, Temp.AttackTypes) and A.Warbreaker:IsSpellLearned() and Unit(unitID):TimeToDie() > 2 and 
				(not A.MemoryofLucidDreams:IsReady(player) or (Unit(player):HasBuffs(A.MemoryofLucidDreams.ID, true) > 0 or A.MemoryofLucidDreams:GetCooldown() > 10)) then
					return A.Warbreaker:Show(icon)
				end
				
				if A.DeadlyCalm:IsReady(player) then
					return A.DeadlyCalm:Show(icon)
				end
				
				if A.Bladestorm:IsReady(unitID, true) and A.Bladestorm:AbsentImun(unitID, Temp.AttackTypes) and Unit(unitID):TimeToDie() > 2 and (A.MortalStrike:GetCooldown() > 0 and 
				(not A.DeadlyCalm:IsSpellLearned() or Unit(player):HasBuffs(A.DeadlyCalmBuff.ID) == 0) and ((Unit(unitID):HasDeBuffs(A.ColossusSmashDebuff.ID) > 0 and
				A.TestofMight:GetAzeriteRank() == 0) or Unit(player):HasBuffs(A.TestofMightBuff.ID) > 0) and Unit(player):HasBuffs(A.MemoryofLucidDreams.ID, true) == 0) then
					return A.Bladestorm:Show(icon)
				end 
			end
			
			if A.Execute:IsReady(unitID) and A.Execute:AbsentImun(unitID, Temp.AttackTypes) and Unit(player):HasBuffs(A.SuddenDeathBuff.ID) > 0 then
				return A.Execute:Show(icon)
			end
			
			if A.Overpower:IsReady(unitID) and A.Overpower:AbsentImun(unitID, Temp.AttackTypes) and (rage < 30 and Unit(player):HasBuffs(A.MemoryofLucidDreams.ID, true) > 0 and
			Unit(unitID):HasDeBuffs(A.ColossusSmashDebuff.ID) > 0) then
				return A.Overpower:Show(icon)
			end
			
			if A.MortalStrike:IsReady(unitID) and A.MortalStrike:AbsentImun(unitID, Temp.AttackTypes) then
				return A.MortalStrike:Show(icon)
			end
			
			if A.Whirlwind:IsReady(unitID, true) and A.Whirlwind:AbsentImun(unitID, Temp.AttackTypes) and InMelee(unitID) and (A.FervorofBattle:IsSpellLearned() and
			(Unit(player):HasBuffs(A.MemoryofLucidDreams.ID, true) > 0 or Unit(player):HasBuffs(A.DeadlyCalmBuff.ID) > 0)) then
				return A.Whirlwind:Show(icon)
			end
			
			if A.Overpower:IsReady(unitID) and A.Overpower:AbsentImun(unitID, Temp.AttackTypes) then
				return A.Overpower:Show(icon)
			end
			
			if A.Whirlwind:IsReady(unitID, true) and A.Whirlwind:AbsentImun(unitID, Temp.AttackTypes) and InMelee(unitID) and A.FervorofBattle:IsSpellLearned() then
				return A.Whirlwind:Show(icon)
			end
			
			if A.Slam:IsReady(unitID) and A.Slam:AbsentImun(unitID, Temp.AttackTypes) and (not A.FervorofBattle:IsSpellLearned() or Unit(player):HasBuffs(A.CrushingAssaultBuff.ID) > 0) then
				return A.Slam:Show(icon)
			end
		end
		
	end	
	
	local function EnemyPvP(unit)
		-- Variables
        inMelee = A.MortalStrike:IsInRange(unit)

		-- Interrupts
        local Interrupt = Interrupts(unit)
        if Interrupt then 
            return Interrupt:Show(icon)
        end  

		if A.VictoryRush:IsReady(unit) and Unit("player"):HealthPercent() <= A.GetToggle(2, "VictoryRush") then
			return A.VictoryRush:Show(icon)
		end
		--if A.ExecuteDefault:IsReady(unit) and (Unit("player"):HasBuffs(A.SuddenDeathBuff.ID, true) > 1) then
		--if A.ExecuteDefault:IsReady(unit)  then
		--	return A.ExecuteDefault:Show(icon)
		--end

		-- Hamstring (slow)
        if unit ~= "mouseover" and  Unit(unit):GetRange() <= 14 and (A.IsInPvP or (not Unit(unit):IsBoss() and Unit(unit):IsMovingOut())) and A.Hamstring:IsReady(unit) and A.Hamstring:AbsentImun(unit, {"TotalImun", "DamagePhysImun", "Freedom", "CCTotalImun"}, true) and Unit(unit):GetMaxSpeed() >= 100 and Unit(unit):HasDeBuffs("Slowed") == 0 and not Unit(unit):IsTotem() then 
            return A.Hamstring:Show(icon)
        end	
		
		if A.Execute:IsReady(unitID) and A.Execute:AbsentImun(unit, Temp.TotalAndPhys) and Unit("player"):HasBuffs(A.SuddenDeathBuff.ID, true) > 0 then
		    return A.Execute:Show(icon)
        end
		
		if A.Warbreaker:IsReady(unit, true) and A.Warbreaker:AbsentImun(unit, Temp.TotalAndPhys) and inMelee then
			return A.Warbreaker:Show(icon)
		end

		-- AoE
		if inAoE and MultiUnits:GetByRange(8, 2) >= 2 and A.SweepingStrikes:IsReady(unit, true) then
			return A.SweepingStrikes:Show(icon)
		end

		if A.Rend:IsReady(unit) and A.Rend:AbsentImun(unit, Temp.TotalAndPhys) and Unit(unit):HasDeBuffs(A.RendDebuff.ID) <= A.GetGCD() + A.GetCurrentGCD() then
			return A.Rend:Show(icon)
		end	
		
		if A.Overpower:IsReady(unit) and A.Overpower:AbsentImun(unit, Temp.TotalAndPhys) and Unit("player"):HasBuffsStacks(A.Overpower.ID, true) <= 2 then
			return A.Overpower:Show(icon)
		end
		
		if A.MortalStrike:IsReady(unit) and A.MortalStrike:AbsentImun(unit, Temp.TotalAndPhys) then
			return A.MortalStrike:Show(icon)
		end
		
		if inMelee and A.Bladestorm:IsReady(unit, true) then
			return A.Bladestorm:Show(icon)
		end
		
		if A.Slam:IsReady(unit) and A.Slam:AbsentImun(unit, Temp.TotalAndPhys) and (Player:Rage() >= 40 or Unit("player"):HasBuffs(A.CrushingAssaultBuff.ID, true) > 0) then
			return A.Slam:Show(icon)
		end
		
		if A.Execute:IsReady(unitID) and A.Execute:AbsentImun(unit, Temp.TotalAndPhys) then
		    return A.Execute:Show(icon)
        end

		if A.WarBanner:IsReady("player") and Unit("player"):CombatTime() > 0 and Unit("player"):HealthPercent() <= 70 then
			return A.WarBanner:Show(icon)
		end	
 	end 
	
	
	if A.IsUnitEnemy("target") and not Unit("target"):IsDead() and not A.IsInPvP then 
        unitID = "target"
        
        if EnemyPvE(unitID) then 
            return true 
        end 
    end
	
	if A.IsUnitEnemy("target") and not Unit("target"):IsDead() and A.IsInPvP then 
        unitID = "target"
        
        if EnemyPvP(unitID) then 
            return true 
        end 
    end

end  

-- Passive 
local function FreezingTrapUsedByEnemy()
    if     UnitCooldown:GetCooldown("arena", 3355) > UnitCooldown:GetMaxDuration("arena", 3355) - 2 and 
    UnitCooldown:IsSpellInFly("arena", 3355) and 
    Unit("player"):GetDR("incapacitate") >= 50 
    then 
        local Caster = UnitCooldown:GetUnitID("arena", 3355)
        if Caster and Unit(Caster):GetRange() <= 40 then 
            return true 
        end 
    end 
end 

local function ArenaRotation(icon, unit)
    if A.IsInPvP and (A.Zone == "pvp" or A.Zone == "arena") and not Player:IsStealthed() and not Player:IsMounted() then             
        -- Note: "arena1" is just identification of meta 6
        if unit == "arena1" and (Unit("player"):GetDMG() == 0 or not Unit("player"):IsFocused("DAMAGER")) then                 
            -- PvP Pet Taunt        
            if A.Taunt:IsReady() and EnemyTeam():IsTauntPetAble(A.Taunt.ID) then 
                -- Freezing Trap 
                if FreezingTrapUsedByEnemy() then 
                    return A.Taunt:Show(icon)
                end 
                
                -- Casting BreakAble CC
                if EnemyTeam():IsCastingBreakAble(0.25) then 
                    return A.Taunt:Show(icon)
                end 
                
                -- Try avoid something totally random at opener (like sap / blind)
                if Unit("player"):CombatTime() <= 5 and (Unit("player"):CombatTime() > 0 or Unit("target"):CombatTime() > 0 or MultiUnits:GetByRangeInCombat(40, 1) >= 1) then 
                    return A.Taunt:Show(icon) 
                end 
                
                -- Roots if not available freedom 
                if LoC:Get("ROOT") > 0 then 
                    return A.Taunt:Show(icon) 
                end 
            end 
        end 

		if A.Rend:IsReady(unit) and A.Rend:AbsentImun(unit, Temp.TotalAndPhys) and Unit(unit):HasDeBuffs(A.RendDebuff.ID) <= A.GetGCD() + A.GetCurrentGCD() then
			return A.Rend:Show(icon)
		end	
        
        if A.DisarmIsReady(unit) and not Unit(unit):InLOS() then
            return A.Disarm:Show(icon)
        end         
        
       -- if A.IsInPvP and A.GetToggle(1, "AutoTarget") and A.IsUnitEnemy("target") and not A.AbsentImun(nil, "target", {"TotalImun", "DamagePhysImun"}) and MultiUnits:GetByRangeInCombat(12, 2) >= 2  then 
      --      Action.TMWAPL(icon, "texture", ACTION_CONST_AUTOTARGET)             
      --      return true
     --   end         
    end 
end 

local function PartyRotation(unitID)  
    -- RallyingCry 
	local RallyingCry = A.GetToggle(2, "RallyingCryPvP")
    if	RallyingCry >= 0 and A.RallyingCry:IsReady(unitID) and 
    (
        (     -- Auto 
            RallyingCry >= 100 and 
            (
                -- HP lose per sec >= 20
                Unit(unitID):GetDMG() * 100 / Unit(unitID):HealthMax() >= 20 or 
                Unit(unitID):GetRealTimeDMG() >= Unit(unitID):HealthMax() * 0.20 or 
                -- TTD 
                Unit(unitID):TimeToDieX(25) < 5 or 
                (
                    A.IsInPvP and 
                    (
                        Unit(unitID):UseDeff() or 
                        (
                            Unit(unitID, 5):HasFlags() and 
                            Unit(unitID):GetRealTimeDMG() > 0 and 
                            Unit(unitID):IsFocused() 
                        )
                    )
                )
            ) and 
            Unit(unitID):HasBuffs(unitID, true) == 0
        ) or 
        (    -- Custom
            RallyingCry < 100 and 
            Unit(unitID):HealthPercent() <= RallyingCry
        )
    ) 
    then 
        return A.RallyingCry
    end  
	
	if A.WarBanner:IsReady(unitID) and Unit(unitID):CombatTime() > 0 and Unit(unitID):HealthPercent() <= 70 and Unit(unitID):IsFocused() then
		return A.WarBanner:Show(icon)
	end
	
end 

A[6] = function(icon)    
    --return ArenaRotation(icon, "arena1")
end

A[7] = function(icon)   
  --  local Party = PartyRotation("party1") 
   -- if Party then 
--		return Party:Show(icon)
--	end 
	
  --  return ArenaRotation(icon, "arena2")
end

A[8] = function(icon)   
--	local Party = PartyRotation("party1") 
 --   if Party then 
--		return Party:Show(icon)
	--end 
    
	--return ArenaRotation(icon, "arena3")
end