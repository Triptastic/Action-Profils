local TMW                                   = TMW 

local Action                                = Action
local TeamCache                             = Action.TeamCache
local EnemyTeam                             = Action.EnemyTeam
local FriendlyTeam                          = Action.FriendlyTeam
--local HealingEngine                       = Action.HealingEngine
local LoC                                   = Action.LossOfControl
local Player								= Action.Player 
local MultiUnits                            = Action.MultiUnits
local UnitCooldown                          = Action.UnitCooldown
local Unit                                  = Action.Unit 
--local Pet                                     = LibStub("PetLibrary")
--local Azerite                                 = LibStub("AzeriteTraits")

local setmetatable                          = setmetatable

Action[ACTION_CONST_WARRIOR_ARMS] = {
    -- Racial
    ArcaneTorrent                       = Action.Create({ Type = "Spell", ID = 50613     }),
    BloodFury                           = Action.Create({ Type = "Spell", ID = 20572      }),
    Fireblood                           = Action.Create({ Type = "Spell", ID = 265221     }),
    AncestralCall                       = Action.Create({ Type = "Spell", ID = 274738     }),
    Berserking                          = Action.Create({ Type = "Spell", ID = 26297    }),
    ArcanePulse                         = Action.Create({ Type = "Spell", ID = 260364    }),
    QuakingPalm                         = Action.Create({ Type = "Spell", ID = 107079     }),
    Haymaker                            = Action.Create({ Type = "Spell", ID = 287712     }), 
    BullRush                            = Action.Create({ Type = "Spell", ID = 255654     }),    
    WarStomp                            = Action.Create({ Type = "Spell", ID = 20549     }),
    GiftofNaaru                         = Action.Create({ Type = "Spell", ID = 59544    }),
    Shadowmeld                          = Action.Create({ Type = "Spell", ID = 58984    }), -- usable in Action Core 
    Stoneform                           = Action.Create({ Type = "Spell", ID = 20594    }), 
    WilloftheForsaken                   = Action.Create({ Type = "Spell", ID = 7744        }), -- not usable in APL but user can Queue it    
    EscapeArtist                        = Action.Create({ Type = "Spell", ID = 20589    }), -- not usable in APL but user can Queue it
    EveryManforHimself                  = Action.Create({ Type = "Spell", ID = 59752    }), -- not usable in APL but user can Queue it
    PetKick                             = Action.Create({ Type = "Spell", ID = 47482, Color = "RED", Desc = "RED" }),  
	-- CrownControl
	StormBolt							= Action.Create({ Type = "Spell", ID = 107570    }),
	StormBoltGreen						= Action.Create({ Type = "SpellSingleColor", ID = 107570, Color = "GREEN", Desc = "[1] CC", QueueForbidden = true }),
	Pummel                              = Action.Create({ Type = "Spell", ID = 6552    }),
	PummelGreen							= Action.Create({ Type = "SpellSingleColor", ID = 6552, Color = "GREEN", Desc = "[2] Kick", QueueForbidden = true }),  
	IntimidatingShout                   = Action.Create({ Type = "Spell", ID = 5246    }),
	Hamstring							= Action.Create({ Type = "Spell", ID = 1715    }),
	Taunt								= Action.Create({ Type = "Spell", ID = 355, Desc = "[6] PvP Pets Taunt", QueueForbidden = true    }),
	Disarm								= Action.Create({ Type = "Spell", ID = 236077, isTalent = true    }), -- PvP Talent 
	-- Self Defensive
	DiebytheSword						= Action.Create({ Type = "Spell", ID = 118038   }),
	RallyingCry							= Action.Create({ Type = "Spell", ID = 97462    }),
   -- Generics Spells
    Skullsplitter                         = Action.Create({ Type = "Spell", ID = 260643, isTalent = true    }), -- Talent
    DeadlyCalm                            = Action.Create({ Type = "Spell", ID = 262228, isTalent = true    }), -- Talent
    Ravager                               = Action.Create({ Type = "Spell", ID = 152277, isTalent = true    }), -- Talent
    ColossusSmash                         = Action.Create({ Type = "Spell", ID = 167105     }),
    Warbreaker                            = Action.Create({ Type = "Spell", ID = 262161, isTalent = true    }), -- Talent
    Bladestorm                            = Action.Create({ Type = "Spell", ID = 227847     }),
    Cleave                                = Action.Create({ Type = "Spell", ID = 845, isTalent = true    }), -- Talent
    Slam                                  = Action.Create({ Type = "Spell", ID = 1464     }),
    MortalStrike                          = Action.Create({ Type = "Spell", ID = 12294     }),
    Dreadnaught                           = Action.Create({ Type = "Spell", ID = 262150, isTalent = true    }), -- Talent
	Overpower							  = Action.Create({ Type = "Spell", ID = 7384, isTalent = false    }), -- Talent
    SweepingStrikes                       = Action.Create({ Type = "Spell", ID = 260708     }),
    Whirlwind                             = Action.Create({ Type = "Spell", ID = 1680     }),
    FervorofBattle                        = Action.Create({ Type = "Spell", ID = 202316, isTalent = true    }), -- Talent
    Rend                                  = Action.Create({ Type = "Spell", ID = 772, isTalent = true    }), -- Talent
    AngerManagement                       = Action.Create({ Type = "Spell", ID = 152278, isTalent = true    }), -- Talent
    Avatar                                = Action.Create({ Type = "Spell", ID = 107574, isTalent = true    }), -- Talent
    Massacre                              = Action.Create({ Type = "Spell", ID = 281001, isTalent = true    }), -- Talent 
	
    -- Misc
	BerserkerRage							= Action.Create({ Type = "Spell", ID = 18499    }),
    Channeling								= Action.Create({ Type = "Spell", ID = 209274, Hidden = true     }),
    Victorious								= Action.Create({ Type = "Spell", ID = 32216, Hidden = true     }),
    VictoryRush								= Action.Create({ Type = "Spell", ID = 34428, Hidden = true     }),
	ImpendingVictory						= Action.Create({ Type = "Spell", ID = 202168, Hidden = true     }),

    -- Buffs
    RecklessForceBuff						= Action.Create({ Type = "Spell", ID = 302932, Hidden = true     }),
    TestofMightBuff							= Action.Create({ Type = "Spell", ID = 275540, Hidden = true     }),
    SweepingStrikesBuff						= Action.Create({ Type = "Spell", ID = 260708, Hidden = true     }),
    SuddenDeathBuff							= Action.Create({ Type = "Spell", ID = 52437, Hidden = true     }),
    StoneHeartBuff							= Action.Create({ Type = "Spell", ID = 225947, Hidden = true     }),
    ExecutionersPrecisionBuff				= Action.Create({ Type = "Spell", ID = 242188, Hidden = true     }),
   -- OverpowerBuff							= Action.Create({ Type = "Spell", ID = 7384, Hidden = true     }),
    CrushingAssaultBuff						= Action.Create({ Type = "Spell", ID = 278826, Hidden = true     }),
    DeadlyCalmBuff							= Action.Create({ Type = "Spell", ID = 262228, Hidden = true     }),
    -- Debuffs 
    RazorCoralDebuff                      = Action.Create({ Type = "Spell", ID = 303568, Hidden = true     }),
    ConductiveInkDebuff                   = Action.Create({ Type = "Spell", ID = 302565, Hidden = true     }),
    DeepWoundsDebuff                      = Action.Create({ Type = "Spell", ID = 262115, Hidden = true     }),
    ColossusSmashDebuff                   = Action.Create({ Type = "Spell", ID = 208086, Hidden = true     }),
    RendDebuff                            = Action.Create({ Type = "Spell", ID = 772, Hidden = true     }),
    -- Trinkets
	GenericTrinket1                       = Action.Create({ Type = "Trinket", ID = 114616, QueueForbidden = true }),
    GenericTrinket2                       = Action.Create({ Type = "Trinket", ID = 114081, QueueForbidden = true }),
    TrinketTest                          = Action.Create({ Type = "Trinket", ID = 122530, QueueForbidden = true }),
    TrinketTest2                         = Action.Create({ Type = "Trinket", ID = 159611, QueueForbidden = true }), 
    AzsharasFontofPower                  = Action.Create({ Type = "Trinket", ID = 169314, QueueForbidden = true }),
    PocketsizedComputationDevice         = Action.Create({ Type = "Trinket", ID = 167555 }),
    RotcrustedVoodooDoll                 = Action.Create({ Type = "Trinket", ID = 159624, QueueForbidden = true }),
    ShiverVenomRelic                     = Action.Create({ Type = "Trinket", ID = 168905, QueueForbidden = true }),
    AquipotentNautilus                   = Action.Create({ Type = "Trinket", ID = 169305, QueueForbidden = true }),
    TidestormCodex                       = Action.Create({ Type = "Trinket", ID = 165576, QueueForbidden = true }),
    VialofStorms                         = Action.Create({ Type = "Trinket", ID = 158224, QueueForbidden = true }),
	AshvanesRazorCoral                   = Action.Create({ Type = "Trinket", ID = 169311, QueueForbidden = true }),
    -- Potions
    PotionofUnbridledFury                = Action.Create({ Type = "Potion", ID = 169299, QueueForbidden = true }),
    PotionTest                           = Action.Create({ Type = "Potion", ID = 142117, QueueForbidden = true }),
    -- Misc
    CyclotronicBlast                      = Action.Create({ Type = "Spell", ID = 293491, Hidden = true}),	
	ExecuteDefault                        = Action.Create({ Type = "Spell", ID = 163201, Hidden = true}),
    ExecuteMassacre                       = Action.Create({ Type = "Spell", ID = 281000, Hidden = true}),	
    -- Hidden Heart of Azeroth
    VisionofPerfectionMinor               = Action.Create({ Type = "Spell", ID = 296320, Hidden = true}),
    VisionofPerfectionMinor2              = Action.Create({ Type = "Spell", ID = 299367, Hidden = true}),
    VisionofPerfectionMinor3              = Action.Create({ Type = "Spell", ID = 299369, Hidden = true}),
    UnleashHeartOfAzeroth                 = Action.Create({ Type = "Spell", ID = 280431, Hidden = true}),
    BloodoftheEnemy                       = Action.Create({ Type = "HeartOfAzeroth", ID = 297108, Hidden = true}),
    BloodoftheEnemy2                      = Action.Create({ Type = "HeartOfAzeroth", ID = 298273, Hidden = true}),
    BloodoftheEnemy3                      = Action.Create({ Type = "HeartOfAzeroth", ID = 298277, Hidden = true}),
    ConcentratedFlame                     = Action.Create({ Type = "HeartOfAzeroth", ID = 295373, Hidden = true}),
    ConcentratedFlame2                    = Action.Create({ Type = "HeartOfAzeroth", ID = 299349, Hidden = true}),
    ConcentratedFlame3                    = Action.Create({ Type = "HeartOfAzeroth", ID = 299353, Hidden = true}),
    GuardianofAzeroth                     = Action.Create({ Type = "HeartOfAzeroth", ID = 295840, Hidden = true}),
    GuardianofAzeroth2                    = Action.Create({ Type = "HeartOfAzeroth", ID = 299355, Hidden = true}),
    GuardianofAzeroth3                    = Action.Create({ Type = "HeartOfAzeroth", ID = 299358, Hidden = true}),
    FocusedAzeriteBeam                    = Action.Create({ Type = "HeartOfAzeroth", ID = 295258, Hidden = true}),
    FocusedAzeriteBeam2                   = Action.Create({ Type = "HeartOfAzeroth", ID = 299336, Hidden = true}),
    FocusedAzeriteBeam3                   = Action.Create({ Type = "HeartOfAzeroth", ID = 299338, Hidden = true}),
    PurifyingBlast                        = Action.Create({ Type = "HeartOfAzeroth", ID = 295337, Hidden = true}),
    PurifyingBlast2                       = Action.Create({ Type = "HeartOfAzeroth", ID = 299345, Hidden = true}),
    PurifyingBlast3                       = Action.Create({ Type = "HeartOfAzeroth", ID = 299347, Hidden = true}),
    TheUnboundForce                       = Action.Create({ Type = "HeartOfAzeroth", ID = 298452, Hidden = true}),
    TheUnboundForce2                      = Action.Create({ Type = "HeartOfAzeroth", ID = 299376, Hidden = true}),
    TheUnboundForce3                      = Action.Create({ Type = "HeartOfAzeroth", ID = 299378, Hidden = true}),
    RippleInSpace                         = Action.Create({ Type = "HeartOfAzeroth", ID = 302731, Hidden = true}),
    RippleInSpace2                        = Action.Create({ Type = "HeartOfAzeroth", ID = 302982, Hidden = true}),
    RippleInSpace3                        = Action.Create({ Type = "HeartOfAzeroth", ID = 302983, Hidden = true}),
    WorldveinResonance                    = Action.Create({ Type = "HeartOfAzeroth", ID = 295186, Hidden = true}),
    WorldveinResonance2                   = Action.Create({ Type = "HeartOfAzeroth", ID = 298628, Hidden = true}),
    WorldveinResonance3                   = Action.Create({ Type = "HeartOfAzeroth", ID = 299334, Hidden = true}),
    MemoryofLucidDreams                   = Action.Create({ Type = "HeartOfAzeroth", ID = 298357, Hidden = true}),
    MemoryofLucidDreams2                  = Action.Create({ Type = "HeartOfAzeroth", ID = 299372, Hidden = true}),
    MemoryofLucidDreams3                  = Action.Create({ Type = "HeartOfAzeroth", ID = 299374, Hidden = true}),
	CondensedLifeforce                    = Action.Create({ Type = "HeartOfAzeroth", ID = 295834, Hidden = true}),
	CondensedLifeforce2                   = Action.Create({ Type = "HeartOfAzeroth", ID = 299354, Hidden = true}),
	CondensedLifeforce3                   = Action.Create({ Type = "HeartOfAzeroth", ID = 299357, Hidden = true}),
}

Action:CreateEssencesFor(ACTION_CONST_WARRIOR_ARMS)
local A = setmetatable(Action[ACTION_CONST_WARRIOR_ARMS], { __index = Action })

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
    
    if useKick and A.Pummel:IsReady(unit) and A.Pummel:AbsentImun(unit, {"TotalImun", "DamagePhysImun", "KickImun"}, true) and Unit(unit):CanInterrupt(true) then 
        return A.Pummel
    end 
    
    if useCC and A.StormBolt:IsReady(unit) and A.StormBolt:AbsentImun(unit, {"TotalImun", "DamagePhysImun", "CCTotalImun"}, true) and Unit(unit):IsControlAble("stun", 0) then 
        return A.StormBolt              
    end          
	
	if useCC and A.IntimidatingShout:IsReady(unit) and A.IntimidatingShout:AbsentImun(unit, {"TotalImun", "DamagePhysImun", "CCTotalImun"}, true) and Unit(unit):IsControlAble("disorient", 0) then 
        return A.IntimidatingShout              
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

-----------------------------------------
--                 ROTATION  
-----------------------------------------
-- [3] Single Rotation
A[3] = function(icon, isMulti)
    local unit = "player"
    local isMoving = Player:IsMoving()
    local inMelee = false
	
	local function EnemyRotation(unit)
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

		-- AoE
		if A.GetToggle(2, "AoE") and MultiUnits:GetByRange(8, 2) >= 2 and A.SweepingStrikes:IsReady(unit, true) then
			return A.SweepingStrikes:Show(icon)
		end

		if A.Rend:IsReady(unit) and A.Rend:AbsentImun(unit, {"TotalImun", "DamagePhysImun"}) and Unit(unit):HasDeBuffs(A.RendDebuff.ID) < 2  then
			return A.Rend:Show(icon)
		end	

		--if A.GetToggle(2, "AoE") and MultiUnits:GetByRange(8, 2) >= 2 and A.Whirlwind:IsReady(unit, true) and Unit("player"):HasBuffs(A.MeatCleaverBuff.ID, true) <= 0 then
		--	return A.Whirlwind:Show(icon)
		--end
		-- 

		-- Bursting #2
        if unit ~= "mouseover" and A.BurstIsON(unit) then             
            -- Simcraft 
            -- Cooldowns --
            
            if inMelee then 
                -- Racials 
                if A.BloodFury:AutoRacial(unit) then 
                    return A.BloodFury:Show(icon)
                end 
                
                if A.Fireblood:AutoRacial(unit) then 
                    return A.Fireblood:Show(icon)
                end 
                
                if A.AncestralCall:AutoRacial(unit) then 
                    return A.AncestralCall:Show(icon)
                end 
                
                if A.Berserking:AutoRacial(unit) then 
                    return A.Berserking:Show(icon)
                end 
                
                -- Trinkets
                if A.Trinket1:IsReady(unit) and A.Trinket1:GetItemCategory() ~= "DEFF" then 
                    return A.Trinket1:Show(icon)
                end 
                
                if A.Trinket2:IsReady(unit) and A.Trinket2:GetItemCategory() ~= "DEFF" then 
                    return A.Trinket2:Show(icon)
                end                     
            end 
			
            -- call_action_list,name=essences
            if (isMulti or A.GetToggle(2, "AoE")) and A.BloodoftheEnemy:AutoHeartOfAzeroth(unit) then                                 
                return A.BloodoftheEnemy:Show(icon)                                                 
            end 
            
            if A.FocusedAzeriteBeam:AutoHeartOfAzeroth(unit) then 
                return A.FocusedAzeriteBeam:Show(icon)
            end 
            
            if A.GuardianofAzeroth:AutoHeartOfAzeroth(unit) then 
                return A.GuardianofAzeroth:Show(icon)
            end 
            
            if A.WorldveinResonance:AutoHeartOfAzeroth(unit) then 
                return A.WorldveinResonance:Show(icon)
            end 
        end

		--Execute Rotation
		if Unit(unit):HealthPercent() <= 30 then
			if A.Skullsplitter:IsReady(unit) and A.Skullsplitter:AbsentImun(unit, {"TotalImun", "DamagePhysImun"}) and (Player:Rage() < 60 and Unit("player"):HasBuffs(A.DeadlyCalmBuff.ID) <= 0) then
				return A.Skullsplitter:Show(icon)
			end

			if inMelee and A.ColossusSmash:IsReady(unit) and A.ColossusSmash:AbsentImun(unit, {"TotalImun", "DamagePhysImun"}) then
				return A.ColossusSmash:Show(icon)
			end

			if inMelee then
				if  A.Warbreaker:IsReady(unit, true) and A.Warbreaker:AbsentImun(unit, {"TotalImun", "DamagePhysImun"}) then
					return A.Warbreaker:Show(icon)
				end
			end

			if A.MortalStrike:IsReady(unit) and A.MortalStrike:AbsentImun(unit, {"TotalImun", "DamagePhysImun"}) then
				return A.MortalStrike:Show(icon)
			end

			if A.ExecuteDefault:IsReady(unit)  then
				return A.ExecuteDefault:Show(icon)
			end

			if A.Overpower:IsReady(unit) and A.Overpower:AbsentImun(unit, {"TotalImun", "DamagePhysImun"}) then
				return A.Overpower:Show(icon)
			end

			if A.ExecuteDefault:IsReady(unit)  then
				return A.ExecuteDefault:Show(icon)
			end
		end

		-- Single 
		--if A.Rend:IsReady(unit) and A.Rend:AbsentImun(unit, {"TotalImun", "DamagePhysImun"}) and Unit(unit):HasDeBuffs(A.RendDebuff.ID) < 1 and Unit(unit):HasDeBuffs(A.ColossusSmashDebuff.ID) <= 0 then
		if A.Skullsplitter:IsReady(unit) and A.Skullsplitter:AbsentImun(unit, {"TotalImun", "DamagePhysImun"}) and (Player:Rage() < 60 and Unit("player"):HasBuffs(A.DeadlyCalmBuff.ID) <= 0) then
			return A.Skullsplitter:Show(icon)
		end

		-- Revanger

		if inMelee and A.ColossusSmash:IsReady(unit) and A.ColossusSmash:AbsentImun(unit, {"TotalImun", "DamagePhysImun"}) then
			return A.ColossusSmash:Show(icon)
		end

		if inMelee then
			if  A.Warbreaker:IsReady(unit, true) and A.Warbreaker:AbsentImun(unit, {"TotalImun", "DamagePhysImun"}) then
				return A.Warbreaker:Show(icon)
			end
		end

		if A.MortalStrike:IsReady(unit) and A.MortalStrike:AbsentImun(unit, {"TotalImun", "DamagePhysImun"}) then
			return A.MortalStrike:Show(icon)
		end

		if inMelee and A.DeadlyCalm:IsReady(unit) then
			A.DeadlyCalm:Show(icon)
		end

	--	if A.SweepingStrikes:IsReady(unit) and (isMulti or A.GetToggle(2, "AoE") or MultiUnits:GetByRange(8, 2) < 2) then
	--		A.SweepingStrikes:Show(icon)
	--	end

		if A.Cleave:IsReady(unit) and A.Cleave:AbsentImun(unit, {"TotalImun", "DamagePhysImun"}) and (isMulti or A.GetToggle(2, "AoE") or MultiUnits:GetByRange(8, 2) < 2) then
			A.Cleave:Show(icon)
		end

		if A.Overpower:IsReady(unit) and A.Overpower:AbsentImun(unit, {"TotalImun", "DamagePhysImun"}) and (Player:Rage() < 30 and Unit("player"):HasBuffs(A.ColossusSmashDebuff.ID) > 0) then
			return A.Overpower:Show(icon)
		end

		if inMelee and A.Bladestorm:IsReady(unit, true) and Unit(unit):HasDeBuffs(A.ColossusSmashDebuff.ID) > 0 then
			return A.Bladestorm:Show(icon)
		end

		if A.Whirlwind:IsReady(unit) and A.Whirlwind:AbsentImun(unit, {"TotalImun", "DamagePhysImun"}) and (A.FervorofBattle:IsSpellLearned() and Unit("player"):HasBuffs(A.DeadlyCalmBuff.ID) > 0) then
			return Whirlwind:Show(icon)
		end

		if A.Overpower:IsReady(unit) and A.Overpower:AbsentImun(unit, {"TotalImun", "DamagePhysImun"}) then
			return A.Overpower:Show(icon)
		end
		
		if A.Whirlwind:IsReady(unit) and A.Whirlwind:AbsentImun(unit, {"TotalImun", "DamagePhysImun"}) and (A.FervorofBattle:IsSpellLearned()) then
			return Whirlwind:Show(icon)
		end

		if A.Slam:IsReady(unit) and A.Slam:AbsentImun(unit, {"TotalImun", "DamagePhysImun"}) and (Player:Rage() > 50 and not A.FervorofBattle:IsSpellLearned()) then
			return A.Slam:Show(icon)
		end

		-- Misc - Supportive 
        if A.BerserkerRage:IsReady("player") then 
            if Unit("player"):HasDeBuffs("Fear") >= 4 then 
                return A.BerserkerRage:Show(icon)
            end 
        end 	
 	end 

	-- Defensive
    local SelfDefensive = SelfDefensives()
    if SelfDefensive then 
        return SelfDefensive:Show(icon)
    end 
    
    -- Trinkets (Defensive)
    if Unit("player"):CombatTime() > 0 and Unit("player"):HealthPercent() <= A.GetToggle(2, "TrinketDefensive") then 
        if A.Trinket1:IsReady("player") and A.Trinket1:GetItemCategory() ~= "DPS" then 
            return A.Trinket1:Show(icon)
        end 
        
        if A.Trinket2:IsReady("player") and A.Trinket2:GetItemCategory() ~= "DPS" then 
            return A.Trinket2:Show(icon)
        end             
    end 
    
    -- Mouseover     
    if A.IsUnitEnemy("mouseover") then 
        unit = "mouseover"
        
        if EnemyRotation(unit) then 
            return true 
        end 
    end 
    
    -- Target             
    if A.IsUnitEnemy("target") then 
        unit = "target"
        
        if EnemyRotation(unit) then 
            return true 
        end 
    end 
    
    -- Movement
    -- If not moving or moving lower than 2.5 sec 
    if Player:IsMovingTime() < 2.5 then 
        return 
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

		if A.Rend:IsReady(unit) and A.Rend:AbsentImun(unit, {"TotalImun", "DamagePhysImun"}) and Unit(unit):HasDeBuffs(A.RendDebuff.ID) < 2  then
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

A[6] = function(icon)    
    return ArenaRotation(icon, "arena1")
end

A[7] = function(icon)   
    return ArenaRotation(icon, "arena2")
end

A[8] = function(icon)   
    return ArenaRotation(icon, "arena3")
end