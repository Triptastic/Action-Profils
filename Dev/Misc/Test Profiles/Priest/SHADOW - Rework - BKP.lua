local Action                                 	= Action
local TeamCache                                	= Action.TeamCache
local EnemyTeam                                	= Action.EnemyTeam
local FriendlyTeam                            	= Action.FriendlyTeam
local LoC                                     	= Action.LossOfControl
local Player                                	= Action.Player 
local MultiUnits                            	= Action.MultiUnits
local UnitCooldown                            	= Action.UnitCooldown
local Unit                                    	= Action.Unit 

local setmetatable                            	= setmetatable

Action[ACTION_CONST_PRIEST_SHADOW] = {
    -- Racial
    ArcaneTorrent                             	= Action.Create({ Type = "Spell", ID = 50613}),
    BloodFury                                 	= Action.Create({ Type = "Spell", ID = 20572}),
    Fireblood                                   = Action.Create({ Type = "Spell", ID = 265221}),
    AncestralCall                              	= Action.Create({ Type = "Spell", ID = 274738}),
    Berserking                                	= Action.Create({ Type = "Spell", ID = 26297}),
    ArcanePulse                                 = Action.Create({ Type = "Spell", ID = 260364}),
    QuakingPalm                                 = Action.Create({ Type = "Spell", ID = 107079}),
    Haymaker                                  	= Action.Create({ Type = "Spell", ID = 287712}), 
    WarStomp                                  	= Action.Create({ Type = "Spell", ID = 20549}),
    BullRush                                  	= Action.Create({ Type = "Spell", ID = 255654}),    
    GiftofNaaru                               	= Action.Create({ Type = "Spell", ID = 59544}),
    Shadowmeld                                  = Action.Create({ Type = "Spell", ID = 58984}), -- usable in Action Core 
    Stoneform                                  	= Action.Create({ Type = "Spell", ID = 20594}), 
    WilloftheForsaken                          	= Action.Create({ Type = "Spell", ID = 7744}), -- not usable in APL but user can Queue it    
    EscapeArtist                              	= Action.Create({ Type = "Spell", ID = 20589}), -- not usable in APL but user can Queue it
    EveryManforHimself                          = Action.Create({ Type = "Spell", ID = 59752}), -- not usable in APL but user can Queue it
	-- Core API
	AntiFakeInterrupt							= Action.Create({ Type = "SpellSingleColor", ID = 15487, Color = "GREEN", Desc = "[2] Interrupt", QueueForbidden = true, BlockForbidden = true}),
	CastBarsInterrupt							= Action.Create({ Type = "Spell", ID = 15487, Desc = "[CastBars] Interrupt", QueueForbidden = true, BlockForbidden = true}),
    -- CrownControl   
	Silence                                		= Action.Create({ Type = "Spell", ID = 15487}),	
    PsychicScream                               = Action.Create({ Type = "Spell", ID = 8122}),
    PsychicHorror                               = Action.Create({ Type = "Spell", ID = 64044, isTalent = true}), -- Talent
	PsychicHorrorGreen                    		= Action.Create({ Type = "SpellSingleColor", ID = 8122,	Color = "GREEN", Desc = "[1] CC", QueueForbidden = true, BlockForbidden = true}),
	-- Suppotive 
	PowerWordFortitude							= Action.Create({ Type = "Spell", ID = 21562}),	
	DispelMagic									= Action.Create({ Type = "Spell", ID = 528}),	
	PurifyDisease								= Action.Create({ Type = "Spell", ID = 213634}),
	VoidShift                            		= Action.Create({ Type = "Spell", ID = 108968, isTalent = true}), -- PvP Talent
	Resurrection								= Action.Create({ Type = "Spell", ID = 2006}),
	ShadowMend									= Action.Create({ Type = "Spell", ID = 186263}),
	LeapofFaith									= Action.Create({ Type = "Spell", ID = 73325}),
	-- Self Defensives
	PowerWordShield					      		= Action.Create({ Type = "Spell", ID = 17}), 
	VampiricEmbrace								= Action.Create({ Type = "Spell", ID = 15286}),
	Dispersion                            		= Action.Create({ Type = "Spell", ID = 47585}),	
	Fade                            			= Action.Create({ Type = "Spell", ID = 586}),	
	-- Burst
	Shadowfiend									= Action.Create({ Type = "Spell", ID = 34433}),
	Mindbender                            		= Action.Create({ Type = "Spell", ID = 200174, isTalent = true}), -- Talent
	SurrenderToMadness                    		= Action.Create({ Type = "Spell", ID = 193223, isTalent = true}), -- Talent
	DarkAscension                         		= Action.Create({ Type = "Spell", ID = 280711, isTalent = true}), -- Talent
	Psyfiend									= Action.Create({ Type = "Spell", ID = 211522, isTalent = true}), -- PvP Talent
	-- Rotation
	VampiricTouch                         		= Action.Create({ Type = "Spell", ID = 34914}),
	ShadowWordPain                        		= Action.Create({ Type = "Spell", ID = 589}),
	MindBlast                             		= Action.Create({ Type = "Spell", ID = 8092}),
	ShadowWordVoid                        		= Action.Create({ Type = "Spell", ID = 205351, isTalent = true}), -- Talent
	MindFlay                              		= Action.Create({ Type = "Spell", ID = 15407}),
	MindSear                              		= Action.Create({ Type = "Spell", ID = 48045}),
	VoidEruption                          		= Action.Create({ Type = "Spell", ID = 228260}),
	VoidBolt                              		= Action.Create({ Type = "Spell", ID = 205448}),
	DarkVoid                              		= Action.Create({ Type = "Spell", ID = 263346, isTalent = true}), -- Talent
	ShadowCrash                           		= Action.Create({ Type = "Spell", ID = 205385, isTalent = true}), -- Talent
	ShadowWordDeath                       		= Action.Create({ Type = "Spell", ID = 32379, isTalent = true}), -- Talent
	VoidTorrent                           		= Action.Create({ Type = "Spell", ID = 263165, isTalent = true}), -- Talent
	Misery                                		= Action.Create({ Type = "Spell", ID = 238558, isTalent = true}), -- Talent
	-- Hidden 
	VoidOrigins									= Action.Create({ Type = "Spell", ID = 204775, isTalent = true}), -- PvP Talent
	Shadowform									= Action.Create({ Type = "Spell", ID = 232698, Hidden = true}),
	LegacyOfTheVoid                       		= Action.Create({ Type = "Spell", ID = 193225, Hidden = true, isTalent = true}),
	ShadowyInsightBuff                     		= Action.Create({ Type = "Spell", ID = 124430, Hidden = true}),
	ShadowformBuff                        		= Action.Create({ Type = "Spell", ID = 232698, Hidden = true}),
    VoidformBuff                         		= Action.Create({ Type = "Spell", ID = 194249, Hidden = true}),
    HarvestedThoughtsBuff                 		= Action.Create({ Type = "Spell", ID = 288343, Hidden = true}),	
	VampiricTouchDebuff                   		= Action.Create({ Type = "Spell", ID = 34914, Hidden = true}),
    ShadowWordPainDebuff                  		= Action.Create({ Type = "Spell", ID = 589, Hidden = true}),
	WeakenedSoulDebuff					  		= Action.Create({ Type = "Spell", ID = 6788, Hidden = true}),
	SearingDialogue                       		= Action.Create({ Type = "Spell", ID = 272788, Hidden = true}), -- Simcraft Azerite
	ThoughtHarvester                      		= Action.Create({ Type = "Spell", ID = 288340, Hidden = true}), -- Simcraft Azerite
	WhispersoftheDamned							= Action.Create({ Type = "Spell", ID = 275722, Hidden = true}), -- Simcraft Azerite
	DeathThroes									= Action.Create({ Type = "Spell", ID = 278659, Hidden = true}), -- Simcraft Azerite
	SpitefulApparitions							= Action.Create({ Type = "Spell", ID = 277682, Hidden = true}), -- Simcraft Azerite
	ChorusofInsanity                      		= Action.Create({ Type = "Spell", ID = 278661, Hidden = true}), -- Simcraft Azerite
	TargetEnemy                           		= Action.Create({ Type = "Spell", ID = 44603, Hidden = true}),	-- Change Target (Tab button)
}

Action:CreateEssencesFor(ACTION_CONST_PRIEST_SHADOW)
local A = setmetatable(Action[ACTION_CONST_PRIEST_SHADOW], { __index = Action })

local Temp 									= {
	TotalAndMagicAndCC						= {"TotalImun", "DamageMagicImun", "CCTotalImun", "CCMagicImun"},
	AttackTypes 							= {"TotalImun", "DamageMagicImun"},
	AuraForInterrupt 						= {"TotalImun", "KickImun", "DamageMagicImun", "CCTotalImun", "CCMagicImun"},
	AuraForFear								= {"TotalImun", "FearImun"},
	TotalAndMagicAndStun                    = {"TotalImun", "DamageMagicImun", "StunImun"},
	MindFlayRowCasted						= 0,
}

local IsIndoors, UnitIsUnit = 
IsIndoors, UnitIsUnit

local function IsSchoolShadowUP()
	return LoC:IsMissed("SILENCE") and LoC:Get("SCHOOL_INTERRUPT", "SHADOW") == 0
end 

local function IsSchoolHolyUP()
	return LoC:IsMissed("SILENCE") and LoC:Get("SCHOOL_INTERRUPT", "HOLY") == 0
end 

-- [Cast Bars]
function Action.Main_CastBars(unitID, list)
	-- IsReadyM here just to skip gcd checks
	if A.IsInitialized and A.Zone == "pvp" and A.CastBarsInterrupt:IsReadyM(unitID) and A.InterruptIsValid(unitID, list) and A.CastBarsInterrupt:AbsentImun(unitID, Temp.AuraForInterrupt) and IsSchoolShadowUP() then  
		return true 		
	end 
end

-- [1] CC AntiFake Rotation
A[1] = function(icon)	
	local unitID = "target"
	if A.PsychicHorrorGreen:IsReady(nil, nil, nil, true) and A.IsUnitEnemy(unitID) and Unit(unitID):GetRange() <= 30 and Unit(unitID):IsControlAble("stun", 0) and 
	A.PsychicHorrorGreen:AbsentImun(unit, Temp.TotalAndMagicAndStun, true) then
		return A.PsychicHorrorGreen:Show(icon)
	end 
end

-- [2] Kick AntiFake Rotation
A[2] = function(icon)	
	-- IsReadyM here just to skip gcd checks
	local unitID
	if A.IsUnitEnemy("mouseover") then 
		unitID = "mouseover"
	elseif A.IsUnitEnemy("target") then 
		unitID = "target"
	end 
			
	if unitID and A.AntiFakeInterrupt:IsReadyM(unitID) then 		
		local castLeft, _, _, _, notKickAble = Unit(unitID):IsCastingRemains()
		if castLeft > 0 and not notKickAble and A.AntiFakeInterrupt:AbsentImun(unitID, Temp.AuraForInterrupt) and Unit(unitID):IsControlAble("silence") then 			
			return A.AntiFakeInterrupt:Show(icon)			
		end 
	end 																				
end

local function Interrupts(unit)
    local useKick, useCC, useRacial = A.InterruptIsValid(unit, "TargetMouseover")    
    
    if useKick and A.Silence:IsReady(unit) and A.Silence:AbsentImun(unit, Temp.AuraForInterrupt, true) and Unit(unit):CanInterrupt(true) then 
        return A.Silence
    end 
    
    if useCC and A.PsychicHorror:IsReady(unit) and A.PsychicHorror:AbsentImun(unit, Temp.TotalAndMagicAndCC, true) and Unit(unit):IsControlAble("stun", 0) then 
        return A.PsychicHorror              
    end          
    
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

local function EvaluateCycleShadowWordPain(TargetUnit)
	if Unit("player"):HasBuffs(A.VoidformBuff.ID, true) > 0 then
		return Unit(TargetUnit):HasDeBuffs(A.ShadowWordPainDebuff.ID) <= A.GetGCD() + A.GetCurrentGCD()
	else 
		return Unit(TargetUnit):HasDeBuffs(A.ShadowWordPainDebuff.ID) <= 4.8
	end
end

local function EvaluateCycleShadowWordPainTTD(swpTraitRanksCheck)
	--((-1.2+3.3*spell_targets.mind_sear)*variable.swp_trait_ranks_check*(1-0.012*azerite.searing_dialogue.rank*spell_targets.mind_sear))
	return ((-1.2 + 3.3 * MultiUnits:GetActiveEnemies()) * swpTraitRanksCheck * (1 - 0.012 * A.SearingDialogue:GetAzeriteRank() * MultiUnits:GetActiveEnemies()))
end

local function EvaluateCycleVampiricTouchTTD(vtTraitRanksCheck)
	--((1+3.3*spell_targets.mind_sear)*variable.vt_trait_ranks_check*(1+0.10*azerite.searing_dialogue.rank*spell_targets.mind_sear))
	return ((1 + 3.3 * MultiUnits:GetActiveEnemies()) * vtTraitRanksCheck * (1 + 0.10 * A.SearingDialogue:GetAzeriteRank() * MultiUnits:GetActiveEnemies()))
end

local function EvaluateCycleShadowWordPainMiseryTTD(vtMissTraitRanksCheck, vtMissSDCheck)
	--((1.0+2.0*spell_targets.mind_sear)*variable.vt_mis_trait_ranks_check*(variable.vt_mis_sd_check*spell_targets.mind_sear))
	return ((1.0 + 2.0 * MultiUnits:GetActiveEnemies()) * vtMissTraitRanksCheck * (vtMissSDCheck * MultiUnits:GetActiveEnemies()))
end

local function EvaluateCycleVampiricTouch(TargetUnit)
	if Unit("player"):HasBuffs(A.VoidformBuff.ID, true) > 0 then
		return Unit(TargetUnit):HasDeBuffs(A.VampiricTouchDebuff.ID) <= A.GetGCD() + A.GetCurrentGCD()
	else 
		return Unit(TargetUnit):HasDeBuffs(A.VampiricTouchDebuff.ID) <= 6.3
	end
end

local function num(val)
  if val then return 1 else return 0 end
end

local function InsanityDrain()
  return (Unit("player"):HasBuffs(A.VoidformBuff.ID, true) > 0) and (math.ceil(5 + Unit("player"):HasBuffsStacks(A.VoidformBuff.ID, true) * 0.68)) or 0
end


local function SelfDefensives()
    if Unit("player"):CombatTime() == 0 then 
        return 
    end
	
	local VampiricEmbrace = A.GetToggle(2, "VampiricEmbrace")
    if	VampiricEmbrace >= 0 and A.VampiricEmbrace:IsReady("player") and 
    (
        (     -- Auto 
            VampiricEmbrace >= 100 and 
            (
                (
                    not A.IsInPvP and 
                    Unit("player"):HealthPercent() < 80 and 
                    Unit("player"):TimeToDieX(20) < 8 
                ) or 
                (
                    A.IsInPvP and 
                    (
                        Unit("player"):UseDeff() or 
                        (
                            Unit("player", 5):HasFlags() and 
                            Unit("player"):GetRealTimeDMG() > 0 and 
                            Unit("player"):IsFocused(nil, true)                                 
                        )
                    )
                )
            ) and 
            Unit("player"):HasBuffs("DeffBuffs") == 0
        ) or 
        (    -- Custom
            VampiricEmbrace < 100 and 
            Unit("player"):HealthPercent() <= VampiricEmbrace
        )
    ) 
    then 
        return A.VampiricEmbrace
    end 
	
	if A.Fade:IsReady("player") and Unit("player"):InGroup() and Unit("player", 5):HasFlags() then
		return A.Fade
	end
	--InGroup
end 
SelfDefensives = A.MakeFunctionCachedStatic(SelfDefensives)

-- [3] Single Rotation
A[3] = function(icon)
	local combatTime			= Unit("player"):CombatTime()
	local inCombat 				= combatTime > 0
	local inAoE					= A.GetToggle(2, "AoE")
	local inShadowform 			= Unit("player"):HasBuffs(A.Shadowform.ID, true) > 0
	local inVoidform 			= Unit("player"):HasBuffs(A.VoidformBuff.ID, true) > 0
	local isSpellsTiming		= A.GetToggle(2, "SpellsTiming")
	local inMoving 				= Player:IsMoving()
	local canCast				= not Player:IsMoving() or Unit("player"):HasBuffs(A.SurrenderToMadness.ID, true) > 0
	local insanityThreshold		= A.LegacyOfTheVoid:IsSpellLearned() and 60 or 90;
	local mindBlastTargets 		= math.floor ((4.5 + A.WhispersoftheDamned:GetAzeriteRank()) / (1 + 0.27 * A.SearingDialogue:GetAzeriteRank()))
	local swpTraitRanksCheck 	= (1 - 0.07 * A.DeathThroes:GetAzeriteRank() + 0.2 * A.ThoughtHarvester:GetAzeriteRank()) * (1 - 0.09 * A.ThoughtHarvester:GetAzeriteRank() * A.SearingDialogue:GetAzeriteRank())
	local vtTraitRanksCheck 	= (1 - 0.04 * A.ThoughtHarvester:GetAzeriteRank() - 0.05 * A.SpitefulApparitions:GetAzeriteRank())
	local vtMissTraitRanksCheck = (1- 0.07 * A.DeathThroes:GetAzeriteRank() - 0.03 * A.ThoughtHarvester:GetAzeriteRank() - 0.055 * A.SpitefulApparitions:GetAzeriteRank()) * (1 - 0.027 * A.ThoughtHarvester:GetAzeriteRank() * A.SearingDialogue:GetAzeriteRank())
    local vtMissSDCheck 		= 1 - 0.014 * A.SearingDialogue:GetAzeriteRank()
	local unitID 				= "player"

	local function UnitRebuff(unitID)		
		-- Group 
		if TeamCache.Friendly.Type and Unit(unitID):InGroup() and IsSchoolHolyUP() then 
			if A.PowerWordFortitude:IsReady(unitID) and Unit(unitID):HasBuffs(A.PowerWordFortitude.ID) == 0 then 		
				return A.PowerWordFortitude:Show(icon)
			end 			
		end 
		
		-- Solo 
		if Unit(unitID):IsPlayer() or Unit(unitID):IsPet() then 
			if A.PowerWordFortitude:IsReady(unitID) and Unit(unitID):HasBuffs(A.PowerWordFortitude.ID) == 0 then 		
				return A.PowerWordFortitude:Show(icon)
			end 
		end
	end
	
	local function Supportive(unitID)
		-- Purge
        if A.ArcaneTorrent:AutoRacial(unitID) then 
            return A.ArcaneTorrent:Show(icon)
        end    
		
		-- Out of combat        
        if not inCombat and A.Resurrection:IsReady(unitID) and Unit(unitID):IsDead() and Unit(unitID):IsPlayer() and not isMoving and IsSchoolHolyUP() then 
            return A.Resurrection:Show(icon)
        end 
		
		-- Supportive
        if A.PurifyDisease:IsReady(unitID, nil, nil, true) and IsSchoolHolyUP() and A.AuraIsValid(unitID, "UseDispel", "Disease") then 
            return A.PurifyDisease:Show(icon)
        end 
		
		if A.DispelMagic:IsReady(unitID, nil, nil, true) and IsSchoolHolyUP() and (A.AuraIsValid(unitID, "UseDispel", "Magic") or A.AuraIsValid(unitID, "UsePurge", "PurgeFriendly")) then 
            return A.DispelMagic:Show(icon)
        end 
		
		if A.PowerWordShield:IsReady(unitID) and IsSchoolHolyUP() and inCombat and Unit(unitID):HasDeBuffs(A.WeakenedSoulDebuff.ID) == 0 and Unit(unitID):IsFocused() then 
			return A.PowerWordShield:Show(icon)
		end 
		
		--Leap of Faith
		if A.LeapofFaith:IsReady(unitID) and IsSchoolHolyUP() and inCombat and (Unit(unitID):HasDeBuffs("Rooted") == 0 and Unit(unitID):TimeToDieX(15) <= A.GetGCD() + A.GetCurrentGCD() * 2) then
			return A.LeapofFaith:Show(icon)
		end
		
		--Leap of Faith (Smoke Bomb)
		if A.LeapofFaith:IsReady(unitID) and IsSchoolHolyUP() and inCombat and (Unit(unitID):HasDeBuffs("Stuned") > 4 and Unit(unitID):IsFocused("MELEE")) then
			return A.LeapofFaith:Show(icon)
		end
		
		-- Azerite Essences 
        if A.ConcentratedFlame:AutoHeartOfAzeroth(unitID) then 
            return A.ConcentratedFlame:Show(icon)
        end 
		
		-- ShadowMend
      --  if not isMoving and A.ShadowMend:IsReady(unitID) and A.ShadowMend:AbsentImun(unitID) and IsSchoolShadowUP() and (UnitIsUnit(unitID, "player")) then  --or A.ShadowMend:PredictHeal("FlashHeal", unitID)
      --      return A.ShadowMend:Show(icon)
      --  end
	  
		-- Racial 
        if A.GiftofNaaru:AutoRacial(unitID) then 
            return A.GiftofNaaru:Show(icon)
        end		
	end
	
	local function Enemy(unitID)
		-- Out of combat: Player Buffer 
	--	if not unitID ~= "targettarget" and not inCombat and UnitRebuff("player") then  
	--		return true 			 
	--	end 
		
		-- Interrupts 
		if not unitID ~= "targettarget" and A.Silence:IsReady(unitID) and IsSchoolShadowUP() then 
			local castLeft, _, _, _, notKickAble = Unit(unitID):IsCastingRemains()
			if castLeft > 0 and not notKickAble and A.InterruptIsValid(unitID, "TargetMouseover") and castLeft < A.GetGCD() + A.GetCurrentGCD() and A.Silence:AbsentImun(unitID, Temp.AuraForInterrupt) and Unit(unitID):IsControlAble("silence") then 
				return A.Silence:Show(icon)
			end 
		end
		
		-- Shadowform 
		if unitID ~= "targettarget" and not inShadowform and not inVoidform and A.Shadowform:IsReady("player") and IsSchoolShadowUP() then 
			return A.Shadowform:Show(icon)
		end 
		
		-- Purge (high)
		if unitID ~= "targettarget" and A.DispelMagic:IsReady(unitID, nil, nil, true) and A.DispelMagic:AbsentImun(unitID, Temp.TotalAndMagicAndCC) and IsSchoolHolyUP() and A.AuraIsValid(unitID, "UsePurge", Unit(unitID):InGroup() and "PurgeFriendly" or "PurgeHigh") then 
			return A.DispelMagic:Show(icon)
		end 	
		--Void Eruption
		if unitID ~= "mouseover" and A.VoidEruption:IsReady(unitID, nil, nil, A.GetToggle(2, "ByPassSpells")) and IsSchoolShadowUP() and A.VoidEruption:AbsentImun(unitID, Temp.AttackTypes) and Player:Insanity() >= insanityThreshold and (canCast or (A.IsInPvP and A.VoidOrigins:IsSpellLearned())) and not A.FocusedAzeriteBeam:IsSpellInCasting() and not inVoidform and not A.FocusedAzeriteBeam:IsSpellInCasting() then
			return A.VoidEruption:Show(icon)
		end
		--Void Bolt
		if unitID ~= "mouseover" and ((A.GetToggle(2, "SpellsTiming") and inVoidform and A.VoidBolt:GetCooldown() <= A.GetGCD() + A.GetCurrentGCD() + A.GetPing() + (TMW.UPD_INTV or 0) + ACTION_CONST_CACHE_DEFAULT_TIMER) or (A.VoidBolt:IsReady(unitID, nil, nil, A.GetToggle(2, "ByPassSpells")) and inVoidform)) and IsSchoolShadowUP() and A.VoidBolt:AbsentImun(unitID, Temp.AttackTypes) and not A.FocusedAzeriteBeam:IsSpellInCasting() then
			return A.VoidBolt:Show(icon)
		end
		
		-- CD's
		if unitID ~= "targettarget" and A.BurstIsON(unitID) and A.AbsentImun(nil, unitID, Temp.AttackTypes) then 
			local insanityDrain = inVoidform and (math.ceil(5 + Unit("player"):HasBuffsStacks(A.VoidformBuff.ID, true) * 0.68)) or 0

			--memory_of_lucid_dreams,if=(buff.voidform.stack>20&insanity<=50)|buff.voidform.stack>(26+7*buff.bloodlust.up)|(current_insanity_drain*((gcd.max*2)+action.mind_blast.cast_time))>insanity
			if A.MemoryofLucidDreams:AutoHeartOfAzeroth(unitID) and ((Unit("player"):HasBuffsStacks(A.VoidformBuff.ID, true) > 20 and Player:Insanity() <= 50) or (Unit("player"):HasBuffsStacks(A.VoidformBuff.ID, true) > (26 + 7 * Unit("player"):HasBuffs("BurstHaste")) or (insanityDrain * ((A.GetGCD() * 2) + A.MindBlast:GetSpellCastTime())) > Player:Insanity())) then 
				return A.MemoryofLucidDreams:Show(icon)
			end
				
			if A.GuardianofAzeroth:AutoHeartOfAzeroth(unit) and Unit("player"):HasBuffsStacks(A.VoidformBuff.ID, true) >  15 then 
				return A.GuardianofAzeroth:Show(icon)
			end
				
			if A.FocusedAzeriteBeam:AutoHeartOfAzeroth(unitID) and (Unit(unitID):IsBoss() or (inAoE and MultiUnits:GetActiveEnemies() >= 2 and Unit(unitID):TimeToDie() > 6) or Unit(unitID):IsPlayer()) then 
				return A.FocusedAzeriteBeam:Show(icon)
			end
				
			if A.Psyfiend:IsReady(unitID) and IsSchoolShadowUP() and A.IsInPvP and A.Psyfiend:AbsentImun(unitID, Temp.AttackTypes) and Unit("player"):HasBuffsStacks(A.VoidformBuff.ID, true) > 9 then
				return A.Psyfiend:Show(icon)
			end
				
			if A.Shadowfiend:IsReady(unitID) and IsSchoolShadowUP() and A.Shadowfiend:AbsentImun(unitID, Temp.AttackTypes) and (Unit("player"):HasBuffsStacks(A.VoidformBuff.ID, true) > 18 and (Unit(unitID):IsBoss() or Unit(unitID):IsPlayer())) then
				return A.Shadowfiend:Show(icon)
			end
				
			if A.ConcentratedFlame:AutoHeartOfAzeroth(unitID) and Unit("player"):CombatTime() <= 10 or (Unit("player"):HasBuffsStacks(A.ChorusofInsanity.ID, true) >= 15 and inVoidform) or Unit(unitID):TimeToDie() < 5 then 
				return A.ConcentratedFlame:Show(icon)
			end 
		end
		
		--Mouseover DoT Rotation
		if unitID == "mouseover" then
			if A.ShadowWordPain:IsReady(unitID) and IsSchoolShadowUP() and A.ShadowWordPain:AbsentImun(unitID, Temp.AttackTypes) and ((EvaluateCycleShadowWordPain(unitID) and Unit(unitID):TimeToDie() > 4 and not A.Misery:IsSpellLearned()) or (canCast and (not inVoidform or A.VoidBolt:GetCooldown() >= A.GetGCD() + A.GetCurrentGCD()))) then
				return A.ShadowWordPain:Show(icon)
			end
			
			if A.VampiricTouch:IsReady(unitID) and IsSchoolShadowUP() and A.VampiricTouch:AbsentImun(unitID, Temp.AttackTypes) and canCast and ((EvaluateCycleVampiricTouch(unitID) and Unit(unitID):TimeToDie() > 6) or (A.Misery:IsSpellLearned() and EvaluateCycleShadowWordPain(unitID) or EvaluateCycleVampiricTouch(unitID))) and (not inVoidform or A.VoidBolt:GetCooldown() >= A.GetGCD() + A.GetCurrentGCD()) and not Unit(unitID):IsTotem() then
				return A.VampiricTouch:Show(icon)
			end
		end
		
		if unitID ~= "mouseover" then		
			if inAoE and MultiUnits:GetActiveEnemies() >= 2 and not Unit(unitID):IsTotem() then 				
				if A.VampiricTouch:IsReady(unitID) and IsSchoolShadowUP() and A.VampiricTouch:AbsentImun(unitID, Temp.AttackTypes) and canCast and EvaluateCycleVampiricTouch(unitID) and A.ThoughtHarvester:GetAzeriteRank() >= 1 then
					return A.VampiricTouch:Show(icon)
				end
				
				if A.MindSear:IsReady(unitID) and A.MindSear:AbsentImun(unitID, Temp.AttackTypes) and IsSchoolShadowUP() and canCast and Unit("player"):HasBuffs(A.HarvestedThoughtsBuff.ID, true) > 0 then
					return A.MindSear:Show(icon)
				end	
				
				if A.ShadowWordDeath:IsReady(unitID, nil, nil, A.GetToggle(2, "ByPassSpells")) and IsSchoolShadowUP() and A.ShadowWordDeath:AbsentImun(unitID, Temp.AttackTypes) and (Unit(unitID):TimeToDie() < 3 or not inVoidform) then
					return A.ShadowWordDeath:Show(icon)
				end
				
				if A.DarkVoid:IsReady(unitID) and A.DarkVoid:AbsentImun(unitID, Temp.AttackTypes) and IsSchoolShadowUP() and canCast and (A.VoidBolt:GetCooldown() >= A.GetGCD() + 0.5 or not inVoidform) and (EvaluateCycleShadowWordPain(unitID) or Unit(unitID):TimeToDie() > 30) then
					return A.DarkVoid:Show(icon)
				end
				
				if A.MindBlast:IsReady(unitID, nil, nil, A.GetToggle(2, "ByPassSpells")) and A.MindBlast:AbsentImun(unitID, Temp.AttackTypes) and IsSchoolShadowUP() and (canCast or Unit("player"):HasBuffs(A.ShadowyInsightBuff.ID) > 0) and MultiUnits:GetActiveEnemies() < mindBlastTargets and (isSpellsTiming or (A.VoidBolt:GetCooldown() >= A.GetGCD() + 0.5 or not inVoidForm)) and not A.FocusedAzeriteBeam:IsSpellInCasting() then
					return A.MindBlast:Show(icon)
				end
				
				if A.ShadowCrash:IsReady(unit, true) and IsSchoolShadowUP() and A.ShadowCrash:AbsentImun(unitID, Temp.AttackTypes) then 
					return A.ShadowCrash:Show(icon)
				end
				
				if A.ShadowWordPain:IsReady(unitID) and IsSchoolShadowUP() and A.ShadowWordPain:AbsentImun(unitID, Temp.AttackTypes) and ((EvaluateCycleShadowWordPain(unitID) and Unit(unitID):TimeToDie() > EvaluateCycleShadowWordPainTTD(swpTraitRanksCheck) and not A.Misery:IsSpellLearned()) or (isMoving and (not inVoidform or A.VoidBolt:GetCooldown() >= A.GetGCD() + A.GetCurrentGCD()))) then
					return A.ShadowWordPain:Show(icon)
				end
				
				if A.VampiricTouch:IsReady(unitID) and IsSchoolShadowUP() and A.VampiricTouch:AbsentImun(unitID, Temp.AttackTypes) and canCast and (EvaluateCycleVampiricTouch(unitID) and Unit(unitID):TimeToDie() > EvaluateCycleVampiricTouchTTD(vtTraitRanksCheck)) then 
					return A.VampiricTouch:Show(icon)
				end

				if A.VampiricTouch:IsReady(unitID) and IsSchoolShadowUP() and A.VampiricTouch:AbsentImun(unitID, Temp.AttackTypes) and canCast and EvaluateCycleShadowWordPain(unitID) and (A.Misery:IsSpellLearned() and Unit(unitID):TimeToDie() > EvaluateCycleShadowWordPainMiseryTTD(vtMissTraitRanksCheck, vtMissSDCheck)) then
					return A.VampiricTouch:Show(icon)
				end
				
				if A.MindSear:IsReady(unitID) and A.MindSear:AbsentImun(unitID, Temp.AttackTypes) and IsSchoolShadowUP() and canCast and ((MultiUnits:GetActiveEnemies() > 1 and A.SearingDialogue:GetAzeriteRank() >= 1) or  MultiUnits:GetActiveEnemies() > 2) then 
					return A.MindSear:Show(icon)		 
				end 
				
				if A.MindFlay:IsReady(unitID) and A.MindFlay:AbsentImun(unitID, Temp.AttackTypes) and IsSchoolShadowUP() and canCast and MultiUnits:GetActiveEnemies() <= 2 then 
					return A.MindFlay:Show(icon)		 
				end	
			end

			-- Single 
			if not inAoE or MultiUnits:GetActiveEnemies() < 2 then 		
				if A.MindSear:IsReady(unitID) and A.MindSear:AbsentImun(unitID, Temp.AttackTypes) and IsSchoolShadowUP() and canCast and Unit("player"):HasBuffs(A.HarvestedThoughtsBuff.ID, true) > 0 and A.VoidBolt:GetCooldown() >= 1.5 and A.SearingDialogue:GetAzeriteRank() >= 1 then
					return A.MindSear:Show(icon)
				end	
				
				if A.ShadowWordDeath:IsReady(unitID, nil, nil, A.GetToggle(2, "ByPassSpells")) and IsSchoolShadowUP() and A.ShadowWordDeath:AbsentImun(unitID, Temp.AttackTypes) and (Unit(unitID):TimeToDie() < 3 or A.ShadowWordDeath:GetSpellCharges() == 2 or (A.ShadowWordDeath:GetSpellCharges() == 1 and A.ShadowWordDeath:GetCooldown() < A.GetGCD() + A.GetCurrentGCD())) then
					return A.ShadowWordDeath:Show(icon)
				end
				
				if A.DarkVoid:IsReady(unitID) and IsSchoolShadowUP() and A.DarkVoid:AbsentImun(unitID, Temp.AttackTypes) and canCast and not inVoidform and Unit(unitID):IsBoss() then
					return A.DarkVoid:Show(icon)
				end
				
				if A.ShadowWordDeath:IsReady(unitID, nil, nil, A.GetToggle(2, "ByPassSpells")) and IsSchoolShadowUP() and A.ShadowWordDeath:AbsentImun(unitID, Temp.AttackTypes) and (not inVoidform or	(A.ShadowWordDeath:GetSpellCharges() == 2 and Unit("player"):HasBuffsStacks(A.VoidformBuff.ID, true) < 15)) then
					return A.ShadowWordDeath:Show(icon)
				end
				
				if A.ShadowCrash:IsReady(unit, true) and IsSchoolShadowUP() and A.ShadowCrash:AbsentImun(unitID, Temp.AttackTypes) then 
					return A.ShadowCrash:Show(icon)
				end
				
				if A.MindBlast:IsReady(unitID, nil, nil, A.GetToggle(2, "ByPassSpells")) and IsSchoolShadowUP() and A.MindBlast:AbsentImun(unitID, Temp.AttackTypes) and (Unit(unitID):HasDeBuffs(A.ShadowWordPain.ID) > 0 and canCast or Unit("player"):HasBuffs(A.ShadowyInsightBuff.ID) > 0) and
					(not inVoidform or Unit("player"):HasBuffsStacks(A.VoidformBuff.ID, true) > 14 and (Player:Insanity() < 70 or A.MindBlast:GetSpellChargesFrac() > 1.33) or Unit("player"):HasBuffsStacks(A.VoidformBuff.ID, true) <= 14 and (Player:Insanity() < 60 or A.MindBlast:GetSpellChargesFrac() > 1.33)) and (isSpellsTiming or (A.VoidBolt:GetCooldown() >= A.GetGCD() +  A.GetCurrentGCD() or not inVoidForm)) and not A.FocusedAzeriteBeam:IsSpellInCasting() then
						return A.MindBlast:Show(icon)
				end
				
				if A.ShadowWordPain:IsReady(unitID) and IsSchoolShadowUP() and A.ShadowWordPain:AbsentImun(unitID, Temp.AttackTypes) and ((EvaluateCycleShadowWordPain(unitID) and Unit(unitID):TimeToDie() > 4 and not A.Misery:IsSpellLearned()) or (inMoving and (not inVoidform or A.VoidBolt:GetCooldown() >= A.GetGCD() + A.GetCurrentGCD()))) then
					return A.ShadowWordPain:Show(icon)
				end
				
				if A.MindFlay:IsReady(unitID) and A.MindFlay:AbsentImun(unitID, Temp.AttackTypes) and IsSchoolShadowUP() and canCast then 
					return A.MindFlay:Show(icon)		 
				end	
				--mind_blast,if=variable.dots_up&((raid_event.movement.in>cast_time+0.5&raid_event.movement.in<4)|!talent.shadow_word_void.enabled|buff.voidform.down|buff.voidform.stack>14&(insanity<70|charges_fractional>1.33)|buff.voidform.stack<=14&(insanity<60|charges_fractional>1.33))
				
			end
		end
	end
	
	
    if A.IsUnitEnemy("mouseover") then 
        unitID = "mouseover"
        if Enemy(unitID) then 
            return true 
        end 
    end 

	
    if A.IsUnitEnemy("target") then 
        unitID = "target"
        
        if Enemy(unitID) then 
            return true 
        end 
    end 
    
	
	if A.PowerWordShield:IsReady(unitID, true) and (unitID == "player" or not Unit(unitID):IsExists()) and IsIndoors() and Unit("player"):CombatTime() == 0 and Unit("player"):HasDeBuffs(A.WeakenedSoulDebuff.ID) == 0 then 
        return A.PowerWordShield:Show(icon)
    end 
end 

-- [4] AoE Rotation
A[4] = function(icon)
    return A[3](icon, true)
end 

local function PartyRotation(unitID)  
    -- Dispels 
    if A.PurifyDisease:IsReady(unitID, nil, nil, true) and IsSchoolHolyUP() and A.AuraIsValid(unitID, "UseDispel", "Disease") and not Unit(unitID):InLOS() then                         
        return A.PurifyDisease
    end         
	
	if A.DispelMagic:IsReady(unitID, nil, nil, true) and IsSchoolHolyUP() and (A.AuraIsValid(unitID, "UseDispel", "Magic") or A.AuraIsValid(unitID, "UsePurge", "PurgeFriendly")) and not Unit(unitID):InLOS() then 
		return A.DispelMagic
	end 
		
	if A.VoidShift:IsReady(unitID, nil, nil, true) and IsSchoolShadowUP() and ((Unit(unitID):TimeToDieX(15) <= A.GetGCD() + A.GetCurrentGCD() * 2 and Unit(unitID):HealthPercent() < 40 and Unit("player"):HealthPercent() >= Unit(unitID):HealthPercent() * 2) or
	(Unit("player"):HealthPercent() <= 15 and Unit(unitID):HealthPercent() >= Unit("player"):HealthPercent() * 4 and not Unit(unitID):IsFocused())) and not Unit(unitID):InLOS() then
		return A.VoidShift
	end
	
end 

A[6] = function(icon)    
   -- return ArenaRotation(icon, "arena1")
end

A[7] = function(icon)
    local Party = PartyRotation("party1") 
    if Party then 
        return Party:Show(icon)
    end 
    
   -- return ArenaRotation(icon, "arena2")
end

A[8] = function(icon)
    local Party = PartyRotation("party2") 
    if Party then 
        return Party:Show(icon)
    end     
    
   -- return ArenaRotation(icon, "arena3")
end

