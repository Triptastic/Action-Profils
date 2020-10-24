-------------------------------
-- Taste TMW Action Rotation --
-------------------------------
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
local ActiveUnitPlates							= MultiUnits:GetActiveUnitPlates()
local _G, setmetatable							= _G, setmetatable
local IsIndoors, UnitIsUnit                     = IsIndoors, UnitIsUnit
local TR                                        = Action.TasteRotation
local pairs                                     = pairs
local Pet                                       = LibStub("PetLibrary")

--- ============================ CONTENT ===========================
--- ======= APL LOCALS =======
-- luacheck: max_line_length 9999

Action[ACTION_CONST_PRIEST_SHADOW] = {
    -- Racial
    ArcaneTorrent                             	= Action.Create({ Type = "Spell", ID = 50613     								}),
    BloodFury                                 	= Action.Create({ Type = "Spell", ID = 20572      								}),
    Fireblood                                   = Action.Create({ Type = "Spell", ID = 265221     								}),
    AncestralCall                              	= Action.Create({ Type = "Spell", ID = 274738     								}),
    Berserking                                	= Action.Create({ Type = "Spell", ID = 26297    								}),
    ArcanePulse                                 = Action.Create({ Type = "Spell", ID = 260364    								}),
    QuakingPalm                                 = Action.Create({ Type = "Spell", ID = 107079     								}),
    Haymaker                                  	= Action.Create({ Type = "Spell", ID = 287712     								}), 
    WarStomp                                  	= Action.Create({ Type = "Spell", ID = 20549     								}),
    BullRush                                  	= Action.Create({ Type = "Spell", ID = 255654     								}),    
    GiftofNaaru                               	= Action.Create({ Type = "Spell", ID = 59544    								}),
    Shadowmeld                                  = Action.Create({ Type = "Spell", ID = 58984    								}), -- usable in Action Core 
    Stoneform                                  	= Action.Create({ Type = "Spell", ID = 20594    								}), 
    WilloftheForsaken                          	= Action.Create({ Type = "Spell", ID = 7744       								}), -- not usable in APL but user can Queue it    
    EscapeArtist                              	= Action.Create({ Type = "Spell", ID = 20589    								}), -- not usable in APL but user can Queue it
    EveryManforHimself                          = Action.Create({ Type = "Spell", ID = 59752    								}), -- not usable in APL but user can Queue it
    -- CrownControl   
	Silence                                		= Action.Create({ Type = "Spell", ID = 15487    								}),	
    PsychicScream                               = Action.Create({ Type = "Spell", ID = 8122    									}),
    PsychicHorror                               = Action.Create({ Type = "Spell", ID = 64044, isTalent = true    				}), -- Talent
	-- Suppotive 
	PowerWordFortitude							= Action.Create({ Type = "Spell", ID = 21562    								}),	
	DispelMagic									= Action.Create({ Type = "Spell", ID = 528,    									}),	
	-- Self Defensives
	PowerWordShield					      		= Action.Create({ Type = "Spell", ID = 17     									}), 
	VampiricEmbrace								= Action.Create({ Type = "Spell", ID = 15286     								}),
	Dispersion                            		= Action.Create({ Type = "Spell", ID = 47585									}),	
	-- Burst
	Shadowfiend									= Action.Create({ Type = "Spell", ID = 34433     								}),
	Mindbender                            		= Action.Create({ Type = "Spell", ID = 200174, isTalent = true    				}), -- Talent
	SurrenderToMadness                    		= Action.Create({ Type = "Spell", ID = 193223, isTalent = true    				}), -- Talent
	DarkAscension                         		= Action.Create({ Type = "Spell", ID = 280711, isTalent = true    				}), -- Talent
	-- Rotation
	VampiricTouch                         		= Action.Create({ Type = "Spell", ID = 34914     								}),
	ShadowWordPain                        		= Action.Create({ Type = "Spell", ID = 589     									}),
	MindBlast                             		= Action.Create({ Type = "Spell", ID = 8092     								}),
	ShadowWordVoid                        		= Action.Create({ Type = "Spell", ID = 205351, isTalent = true    				}), -- Talent
	MindFlay                              		= Action.Create({ Type = "Spell", ID = 15407     								}),
	MindSear                              		= Action.Create({ Type = "Spell", ID = 48045     								}),
	VoidEruption                          		= Action.Create({ Type = "Spell", ID = 228260     								}),
	VoidBolt                              		= Action.Create({ Type = "Spell", ID = 205448     								}),
	DarkVoid                              		= Action.Create({ Type = "Spell", ID = 263346, isTalent = true    				}), -- Talent
	ShadowCrash                           		= Action.Create({ Type = "Spell", ID = 205385, isTalent = true    				}), -- Talent
	ShadowWordDeath                       		= Action.Create({ Type = "Spell", ID = 32379, isTalent = true    				}), -- Talent
	VoidTorrent                           		= Action.Create({ Type = "Spell", ID = 263165, isTalent = true    				}), -- Talent
	Misery                                		= Action.Create({ Type = "Spell", ID = 238558, isTalent = true    				}), -- Talent
	-- Hidden 
	Shadowform									= Action.Create({ Type = "Spell", ID = 232698, Hidden = true					}),
	LegacyOfTheVoid                       		= Action.Create({ Type = "Spell", ID = 193225, Hidden = true, isTalent = true 	}),
	ShadowformBuff                        		= Action.Create({ Type = "Spell", ID = 232698, Hidden = true     				}),
    VoidformBuff                         		= Action.Create({ Type = "Spell", ID = 194249, Hidden = true     				}),
    HarvestedThoughtsBuff                 		= Action.Create({ Type = "Spell", ID = 288343, Hidden = true     				}),	
	VampiricTouchDebuff                   		= Action.Create({ Type = "Spell", ID = 34914, Hidden = true     				}),
    ShadowWordPainDebuff                  		= Action.Create({ Type = "Spell", ID = 589, Hidden = true     					}),
	WeakenedSoulDebuff					  		= Action.Create({ Type = "Spell", ID = 6788, Hidden = true     					}),
	SearingDialogue                       		= Action.Create({ Type = "Spell", ID = 272788, Hidden = true 					}), -- Simcraft Azerite
	ThoughtHarvester                      		= Action.Create({ Type = "Spell", ID = 288340, Hidden = true 					}), -- Simcraft Azerite
	WhispersoftheDamned							= Action.Create({ Type = "Spell", ID = 275722, Hidden = true 					}), -- Simcraft Azerite
	TargetEnemy                           		= Action.Create({ Type = "Spell", ID = 44603, Hidden = true     				}),	-- Change Target (Tab button)
}

Action:CreateEssencesFor(ACTION_CONST_PRIEST_SHADOW)
local A = setmetatable(Action[ACTION_CONST_PRIEST_SHADOW], { __index = Action })

local Temp 									= {
	TotalAndMagicAndCC						= {"TotalImun", "DamageMagicImun", "CCTotalImun", "CCMagicImun"},
	AttackTypes 							= {"TotalImun", "DamageMagicImun"},
	AuraForInterrupt 						= {"TotalImun", "KickImun", "DamageMagicImun", "CCTotalImun", "CCMagicImun"},
	AuraForFear								= {"TotalImun", "FearImun"},
	MindFlayRowCasted						= 0,
}

local IsIndoors, UnitIsUnit = 
IsIndoors, UnitIsUnit

local player = "player"

local function IsSchoolShadowUP()
	return LoC:IsMissed("SILENCE") and LoC:Get("SCHOOL_INTERRUPT", "SHADOW") == 0
end 

local function Interrupts(unitID)
    local useKick, useCC, useRacial = A.InterruptIsValid(unitID, "TargetMouseover")    
    
    if useKick and A.Silence:IsReady(unitID) and A.Silence:AbsentImun(unitID, Temp.AuraForInterrupt, true) and Unit(unitID):CanInterrupt(true) then 
        return A.Silence
    end 
    
    if useCC and A.PsychicHorror:IsReady(unitID) and A.PsychicHorror:AbsentImun(unitID, Temp.TotalAndMagicAndCC, true) and Unit(unitID):IsControlAble("stun", 0) then 
        return A.StormBolt              
    end          
    
    if useRacial and A.QuakingPalm:AutoRacial(unitID) then 
        return A.QuakingPalm
    end 
    
    if useRacial and A.Haymaker:AutoRacial(unitID) then 
        return A.Haymaker
    end 
    
    if useRacial and A.WarStomp:AutoRacial(unitID) then 
        return A.WarStomp
    end 
    
    if useRacial and A.BullRush:AutoRacial(unitID) then 
        return A.BullRush
    end      
end 
Interrupts = A.MakeFunctionCachedDynamic(Interrupts)


local function InsanityThreshold ()
	return A.LegacyOfTheVoid:IsSpellLearned() and 60 or 90;
end

local function EvaluateCycleShadowWordPain(TargetUnit)
	if Unit("player"):HasBuffs(A.VoidformBuff.ID, true) > 0 then
		return Unit(TargetUnit):HasDeBuffs(A.ShadowWordPainDebuff.ID) <= A.GetGCD() + A.GetCurrentGCD()
	else 
		return Unit(TargetUnit):HasDeBuffs(A.ShadowWordPainDebuff.ID) <= 4.8
	end
end

local function EvaluateCycleVampiricTouch(TargetUnit)
	if Unit("player"):HasBuffs(A.VoidformBuff.ID, true) > 0 then
		return Unit(TargetUnit):HasDeBuffs(A.VampiricTouchDebuff.ID) <= A.GetGCD() + A.GetCurrentGCD()
	else 
		return Unit(TargetUnit):HasDeBuffs(A.VampiricTouchDebuff.ID) <= 6.3
	end
end

local function IsDotsUP (TargetUnit)
	return Unit(TargetUnit):HasDeBuffs(A.ShadowWordPainDebuff.ID) > 0 and Unit(TargetUnit):HasDeBuffs(A.VampiricTouchDebuff.ID) > 0
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
end 
SelfDefensives = A.MakeFunctionCachedStatic(SelfDefensives)

-- [3] Single Rotation
A[3] = function(icon, isMulti)
    local isMoving = Player:IsMoving()
	local inVoidForm = Unit("player"):HasBuffs(A.VoidformBuff.ID, true) > 0
	local mindBlastTargets = math.floor ((4.5 + A.WhispersoftheDamned:GetAzeriteRank()) / (1 + 0.27 * A.SearingDialogue:GetAzeriteRank()))
	
	
    local function EnemyRotation(unitID)
		
		-- Purge (high) 
		if unitID ~= "targettarget" and A.DispelMagic:IsReady(unitID, nil, nil, true) and A.DispelMagic:AbsentImun(unitID, Temp.TotalAndMagicAndCC) and A.AuraIsValid(unitID, "UsePurge", "PurgeHigh") then 
			return A.DispelMagic:Show(icon)
		end 

		-- Interrupts
        local Interrupt = Interrupts(unitID)
        if Interrupt then 
            return Interrupt:Show(icon)
        end   		
	
		if A.VoidEruption:IsReady(unitID, nil, nil, A.GetToggle(2, "ByPassSpells")) and IsSchoolShadowUP() and A.VoidEruption:AbsentImun(unitID, Temp.AttackTypes) and 
		Player:Insanity() >= InsanityThreshold() and not inVoidForm and not isMoving then
			return A.VoidEruption:Show(icon)
		end
		
		if A.DarkAscension:IsReady() and not inVoidForm and IsSchoolShadowUP() and not isMoving then
			return A.DarkAscension:Show(icon)
		end
		
		if unitID == "mouseover" and not Unit(unitID):IsTotem() then 		
			if A.ShadowWordPain:IsReady(unitID) and IsSchoolShadowUP() and A.ShadowWordPain:AbsentImun(unitID, Temp.AttackTypes) and 
			(EvaluateCycleShadowWordPain(unitID) and Unit(unitID):TimeToDie() > 4 and not A.Misery:IsSpellLearned() or (isMoving and (not inVoidForm or A.VoidBolt:GetCooldown() >= A.GetGCD()))) then
				return A.ShadowWordPain:Show(icon)
			end
		
			if A.VampiricTouch:IsReady(unitID) and not Player:IsCasting(A.VampiricTouch) and ((EvaluateCycleVampiricTouch(unitID) and Unit(unitID):TimeToDie() > 6) or (A.Misery:IsSpellLearned() and EvaluateCycleShadowWordPain(unitID))) then
				return A.VampiricTouch:Show(icon)
			end
		end
		
		-- AoE 
        if unitID ~= "mouseover" and (A.GetToggle(2, "AoE") and MultiUnits:GetActiveEnemies() >= 2) and not Unit(unitID):IsTotem() then 		
			if ((A.GetToggle(2, "SpellsTiming") and inVoidForm and A.VoidBolt:GetCooldown() <= A.GetGCD() + A.GetCurrentGCD() + A.GetPing() + (TMW.UPD_INTV or 0) + ACTION_CONST_CACHE_DEFAULT_TIMER) or
			(A.VoidBolt:IsReady(unitID, nil, nil, A.GetToggle(2, "ByPassSpells")) and inVoidForm)) and IsSchoolShadowUP() and A.VoidBolt:AbsentImun(unitID, Temp.AttackTypes) and not A.FocusedAzeriteBeam:IsSpellInCasting() then
				return A.VoidBolt:Show(icon)
			end
			
			--actions.cleave+=/vampiric_touch,if=!ticking&azerite.thought_harvester.rank>=1
			--if A.VampiricTouch:IsReady(unitID) and EvaluateCycleVampiricTouch(unitID) and not isMoving and IsSchoolShadowUP() and A.VampiricTouch:AbsentImun(unitID, Temp.AttackTypes) and A.ThoughtHarvester:GetAzeriteRank() >= 1 then
		--		return A.VampiricTouch:Show(icon)
		--	end
			
			if A.MindSear:IsReady(unitID) and A.MindSear:AbsentImun(unitID, Temp.AttackTypes) and IsDotsUP(unitID) and IsSchoolShadowUP() and not isMoving and (Unit("player"):HasBuffs(A.HarvestedThoughtsBuff.ID, true) > 0 and A.VoidBolt:GetCooldown() >= 1.5) then 
				return A.MindSear:Show(icon)
			end		
			
			if unitID ~= "mouseover" and A.BurstIsON(unitID) then
				local InsanityDrain = InsanityDrain()
				if A.MemoryofLucidDreams:AutoHeartOfAzerothP(unitID) and ((Unit("player"):HasBuffsStacks(A.VoidformBuff.ID, true) > 20 and Player:Insanity() <= 50) or   
				Unit("player"):HasBuffsStacks(A.VoidformBuff.ID, true) > (26 + 7 * num(Unit("player"):HasBuffs("BurstHaste") > 0)) or (InsanityDrain * ((A.GetGCD() * 2) + A.MindBlast:GetSpellCastTime())) > Player:Insanity()) then 
					return A.MemoryofLucidDreams:Show(icon)
				end	
				
				if A.GuardianofAzeroth:AutoHeartOfAzeroth(unitID) and Unit("player"):HasBuffsStacks(A.VoidformBuff.ID, true) >  15 then 
					return A.GuardianofAzeroth:Show(icon)
				end
				
				if A.FocusedAzeriteBeam:AutoHeartOfAzeroth(unitID) and (Unit(unitID):IsBoss() or MultiUnits:GetActiveEnemies() >= 3) then 
					return A.FocusedAzeriteBeam:Show(icon)
				end
		
				--Use Mindbender/Shadowfiend at 19 or more stacks, and is boss
				if A.Shadowfiend:IsReady(unitID) and IsSchoolShadowUP() and A.Shadowfiend:AbsentImun(unitID, Temp.AttackTypes) and (Unit("player"):HasBuffsStacks(A.VoidformBuff.ID, true) > 18 and Unit(unitID):IsBoss()) then
					return A.Shadowfiend:Show(icon)
				end
			end
			
			if A.ShadowCrash:IsReady(unitID, true) then 
				return A.ShadowCrash:Show(icon)
			end
			
			if A.ShadowWordVoid:IsReady(unitID, nil, nil, A.GetToggle(2, "ByPassSpells")) and IsDotsUP(unitID) and IsSchoolShadowUP() and A.ShadowWordVoid:AbsentImun(unitID, Temp.AttackTypes) and not isMoving and
			((A.GetToggle(2, "SpellsTiming")) or (not A.GetToggle(2, "SpellsTiming") and A.VoidBolt:GetCooldown() >= A.GetGCD() + 0.5 or not inVoidForm)) and (MultiUnits:GetActiveEnemies() < mindBlastTargets or not inVoidForm) and not A.FocusedAzeriteBeam:IsSpellInCasting() then
				return A.ShadowWordVoid:Show(icon)
			end
			
			if A.DarkVoid:IsReady(unitID) and A.DarkVoid:AbsentImun(unitID, Temp.AttackTypes) and IsSchoolShadowUP() and not isMoving and (A.VoidBolt:GetCooldown() >= A.GetGCD() + 0.5 or not inVoidForm) and MultiUnits:GetActiveEnemies() > 2 then
				return A.DarkVoid:Show(icon)
			end
			
			--actions.cleave+=/shadow_word_pain,target_if=refreshable&target.time_to_die>((-1.2+3.3*spell_targets.mind_sear)*variable.swp_trait_ranks_check*(1-0.012*azerite.searing_dialogue.rank*spell_targets.mind_sear)),if=!talent.misery.enabled
			
			if A.PowerWordShield:IsReady("player") and Player:IsMoving() and Unit("player"):HasDeBuffs(A.WeakenedSoulDebuff.ID) == 0 then
				return A.PowerWordShield:Show(icon)
			end
	
			if A.ShadowWordPain:IsReady(unitID) and IsSchoolShadowUP() and A.ShadowWordPain:AbsentImun(unitID, Temp.AttackTypes) and 
			(EvaluateCycleShadowWordPain(unitID) and Unit(unitID):TimeToDie() > 4 and not A.Misery:IsSpellLearned() or (isMoving and (not inVoidForm or A.VoidBolt:GetCooldown() >= A.GetGCD()))) then
				return A.ShadowWordPain:Show(icon)
			end
		
			if A.VampiricTouch:IsReady(unitID) and not Player:IsCasting(A.VampiricTouch) and ((EvaluateCycleVampiricTouch(unitID) and Unit(unitID):TimeToDie() > 6) or (A.Misery:IsSpellLearned() and EvaluateCycleShadowWordPain(unitID))) then
				return A.VampiricTouch:Show(icon)
			end
			
			if A.MindSear:IsReady(unitID) and A.MindSear:AbsentImun(unitID, Temp.AttackTypes) and IsSchoolShadowUP() and not isMoving and MultiUnits:GetActiveEnemies() > 2 and (IsDotsUP(unitID) or Unit(unitID):TimeToDie() < 6) then 
				return A.MindSear:Show(icon)		 
			end 
			
			if A.MindFlay:IsReady(unitID) and A.MindFlay:AbsentImun(unitID, Temp.AttackTypes) and IsSchoolShadowUP() and not isMoving and MultiUnits:GetActiveEnemies() <= 2  and (IsDotsUP(unitID) or Unit(unitID):TimeToDie() < 6) then 
				return A.MindFlay:Show(icon)		 
			end	
			
		end
		
		-- Single 
        if unitID ~= "mouseover" and (not A.GetToggle(2, "AoE") or MultiUnits:GetActiveEnemies() < 2)  then 
			if ((A.GetToggle(2, "SpellsTiming") and inVoidForm and A.VoidBolt:GetCooldown() <= A.GetGCD() + A.GetCurrentGCD() + A.GetPing() + (TMW.UPD_INTV or 0) + ACTION_CONST_CACHE_DEFAULT_TIMER) or
			(A.VoidBolt:IsReady(unitID, nil, nil, A.GetToggle(2, "ByPassSpells")) and inVoidForm)) and IsSchoolShadowUP() and A.VoidBolt:AbsentImun(unitID, Temp.AttackTypes) and not A.FocusedAzeriteBeam:IsSpellInCasting() then
				return A.VoidBolt:Show(icon)
			end
		
			if unitID ~= "mouseover" and A.BurstIsON(unitID) then
				local InsanityDrain = InsanityDrain()
				if A.MemoryofLucidDreams:AutoHeartOfAzerothP(unitID) and ((Unit("player"):HasBuffsStacks(A.VoidformBuff.ID, true) > 20 and Player:Insanity() <= 50) or   
				Unit("player"):HasBuffsStacks(A.VoidformBuff.ID, true) > (26 + 7 * num(Unit("player"):HasBuffs("BurstHaste") > 0)) or (InsanityDrain * ((A.GetGCD() * 2) + A.MindBlast:GetSpellCastTime())) > Player:Insanity()) then 
					return A.MemoryofLucidDreams:Show(icon)
				end
				
				if A.GuardianofAzeroth:AutoHeartOfAzeroth(unitID) and Unit("player"):HasBuffsStacks(A.VoidformBuff.ID, true) >  15 then 
					return A.GuardianofAzeroth:Show(icon)
				end
				
				if A.FocusedAzeriteBeam:AutoHeartOfAzeroth(unitID) and (Unit(unitID):IsBoss() or MultiUnits:GetActiveEnemies() >= 3) then 
					return A.FocusedAzeriteBeam:Show(icon)
				end
				
				--Use Mindbender/Shadowfiend at 19 or more stacks, or if the target will die in less than 15s.
				if A.Shadowfiend:IsReady(unitID) and IsSchoolShadowUP() and A.Shadowfiend:AbsentImun(unitID, Temp.AttackTypes) and (Unit("player"):HasBuffsStacks(A.VoidformBuff.ID, true) > 18 and Unit(unitID):IsBoss()) then
					return A.Shadowfiend:Show(icon)
				end
			end

			 
		
			if A.MindSear:IsReady(unitID) and A.MindSear:AbsentImun(unitID, Temp.AttackTypes) and IsSchoolShadowUP() and not isMoving and (Unit("player"):HasBuffs(A.HarvestedThoughtsBuff.ID, true) > 0 and 
			A.VoidBolt:GetCooldown() >= 1.5 and A.SearingDialogue:GetAzeriteRank() >= 1) then 
				return A.MindSear:Show(icon)
			end
			
			if A.ShadowCrash:IsReady(unitID, true) and IsDotsUP(unitID) then 
				return A.ShadowCrash:Show(icon)
			end

			if A.ShadowWordVoid:IsReady(unitID, nil, nil, A.GetToggle(2, "ByPassSpells")) and IsDotsUP(unitID) and IsSchoolShadowUP() and A.ShadowWordVoid:AbsentImun(unitID, Temp.AttackTypes) and not isMoving and
			((A.GetToggle(2, "SpellsTiming")) or (not A.GetToggle(2, "SpellsTiming") and A.VoidBolt:GetCooldown() >= A.GetGCD() + 0.5 or not inVoidForm)) and not A.FocusedAzeriteBeam:IsSpellInCasting() then
				return A.ShadowWordVoid:Show(icon)
			end
			
			if A.DarkVoid:IsReady(unitID) and A.DarkVoid:AbsentImun(unitID, Temp.AttackTypes) and IsSchoolShadowUP() and not isMoving and not inVoidForm and Unit(unitID):IsBoss() then
				return A.DarkVoid:Show(icon)
			end
		
			if A.PowerWordShield:IsReady("player") and Player:IsMoving() and Unit("player"):HasDeBuffs(A.WeakenedSoulDebuff.ID) == 0 then 
				return A.PowerWordShield:Show(icon)
			end
	
			if A.ShadowWordPain:IsReady(unitID) and IsSchoolShadowUP() and A.ShadowWordPain:AbsentImun(unitID, Temp.AttackTypes) and 
			(EvaluateCycleShadowWordPain(unitID) and Unit(unitID):TimeToDie() > 4 and not A.Misery:IsSpellLearned() or (isMoving and (not inVoidForm or A.VoidBolt:GetCooldown() >= A.GetGCD()))) then
				return A.ShadowWordPain:Show(icon)
			end
		
			--actions.single+=/vampiric_touch,if=refreshable&target.time_to_die>6|(talent.misery.enabled&dot.shadow_word_pain.refreshable)
			--if A.VampiricTouch:IsReady(unitID) and ((EvaluateCycleVampiricTouch(unitID) and Unit(unitID):TimeToDie() > 6) or (A.Misery:IsSpellLearned() and EvaluateCycleShadowWordPain(unitID) and Unit(unitID):HasDeBuffs(A.VampiricTouchDebuff.ID) > 0)) 
			--and not isMoving and IsSchoolShadowUP() and A.VampiricTouch:AbsentImun(unitID, Temp.AttackTypes) then
			--	return A.VampiricTouch:Show(icon)
			--end
			if A.VampiricTouch:IsReady(unitID) and not Player:IsCasting(A.VampiricTouch) and ((EvaluateCycleVampiricTouch(unitID) and Unit(unitID):TimeToDie() > 6) or (A.Misery:IsSpellLearned() and EvaluateCycleShadowWordPain(unitID))) then
				return A.VampiricTouch:Show(icon)
			end
		
			if A.MindFlay:IsReady(unitID) and A.MindFlay:AbsentImun(unitID, Temp.AttackTypes) and IsSchoolShadowUP() and not isMoving and (IsDotsUP(unitID) or Unit(unitID):TimeToDie() < 6) then 
				return A.MindFlay:Show(icon)		 
			end 
		end
		
		
		-- Purge (low) 
		if unitID ~= "targettarget" and A.DispelMagic:IsReady(unitID, nil, nil, true) and A.DispelMagic:AbsentImun(unitID, Temp.TotalAndMagicAndCC) and A.AuraIsValid(unitID, "UsePurge", "PurgeLow") then 
			return A.DispelMagic:Show(icon)
		end 

	end
	
	local function TestRotation(unitID)
		if A.VampiricTouch:IsReady(unitID) and not Player:IsCasting(A.VampiricTouch) and ((EvaluateCycleVampiricTouch(unitID) and Unit(unitID):TimeToDie() > 6) or (A.Misery:IsSpellLearned() and EvaluateCycleShadowWordPain(unitID))) then
				return A.VampiricTouch:Show(icon)
		end
		
	--	if Player:IsCasting(A.VampiricTouch) and not EvaluateCycleVampiricTouch(unitID) then
		--	return A:Show(icon, ACTION_CONST_STOPCAST)
	--	end
	end
	
	-- Defensive
    local SelfDefensive = SelfDefensives()
    if SelfDefensive then 
        return SelfDefensive:Show(icon)
    end 
	
    -- Mouseover     
    if A.IsUnitEnemy("mouseover") then 
        unitID = "mouseover"
        if EnemyRotation(unitID) then 
            return true 
        end 
    end 
    
    -- Target             
    if A.IsUnitEnemy("target") then 
        unitID = "target"
        
        if EnemyRotation(unitID) then 
            return true 
        end 
    end 
	
	-- Misc
	if A.Shadowform:IsReady("player") and (Unit("player"):HasBuffs(A.Shadowform.ID) <= 0 and Unit("player"):HasBuffs(A.VoidformBuff.ID) <= 0) then
		return A.Shadowform:Show(icon)
	end
	
	if A.PowerWordFortitude:IsReady("player") and Unit("player"):CombatTime() == 0 and not Player:IsMounted() and (Unit("player"):HasBuffs(A.PowerWordFortitude.ID) == 0) then  --FriendlyTeam(nil, 10):MissedBuffs(A.PowerWordFortitude.ID) or 
        return A.PowerWordFortitude:Show(icon)
    end 
    
    -- Movement
    -- If not moving or moving lower than 2.5 sec 
    if Player:IsMovingTime() < 2.5 then 
        return 
    end   
	
	if A.PowerWordShield:IsReady(unitID, true) and (unitID == "player" or not Unit(unitID):IsExists()) and IsIndoors() and Unit("player"):CombatTime() == 0 and Unit("player"):HasDeBuffs(A.WeakenedSoulDebuff.ID) == 0 then 
        return A.PowerWordShield:Show(icon)
    end 
end 
