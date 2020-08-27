-----------------------------
-- ZakLL TMW Action Rotation
-----------------------------
local Action								= Action
local TeamCache								= Action.TeamCache
local EnemyTeam								= Action.EnemyTeam
local FriendlyTeam							= Action.FriendlyTeam
local LoC									= Action.LossOfControl
local Player								= Action.Player 
local MultiUnits							= Action.MultiUnits
local UnitCooldown							= Action.UnitCooldown
local Unit									= Action.Unit 
local TR                                     = Action.TasteRotation
local setmetatable							= setmetatable

Action[ACTION_CONST_WARRIOR_FURY] = {
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
    BagofTricks                            = Action.Create({ Type = "Spell", ID = 312411    }),
    WilloftheForsaken						= Action.Create({ Type = "Spell", ID = 7744}), -- not usable in APL but user can Queue it    
    EscapeArtist							= Action.Create({ Type = "Spell", ID = 20589}), -- not usable in APL but user can Queue it
    EveryManforHimself						= Action.Create({ Type = "Spell", ID = 59752}), -- not usable in APL but user can Queue it
    PetKick									= Action.Create({ Type = "Spell", ID = 47482, Color = "RED", Desc = "RED" }),  
	-- CrownControl
	StormBolt								= Action.Create({ Type = "Spell", ID = 107570}),
	StormBoltGreen							= Action.Create({ Type = "SpellSingleColor", ID = 107570, Color = "GREEN", Desc = "[1] CC", QueueForbidden = true}),
	Pummel									= Action.Create({ Type = "Spell", ID = 6552}),
	PummelGreen								= Action.Create({ Type = "SpellSingleColor", ID = 6552, Color = "GREEN", Desc = "[2] Kick", QueueForbidden = true}),  
	IntimidatingShout						= Action.Create({ Type = "Spell", ID = 5246}),
	IntimidatingShoutAntiFake				= Action.Create({ Type = "Spell", ID = 115078, Desc = "[2] Kick", QueueForbidden = true}),
	PiercingHowl							= Action.Create({ Type = "Spell", ID = 23600}),
	-- Self Defensive
	EnragedRegeneration						= Action.Create({ Type = "Spell", ID = 184364}),
	BerserkerRage							= Action.Create({ Type = "Spell", ID = 18499}),
	VictoryRush								= Action.Create({ Type = "Spell", ID = 34428}),
	ImpendingVictory						= Action.Create({ Type = "Spell", ID = 202168, isTalent = true}), -- Talent
	-- Suppotive
	RallyingCry								= Action.Create({ Type = "Spell", ID = 97462}),
	Charge									= Action.Create({ Type = "Spell", ID = 100}),
	-- Burst
	Recklessness                          	= Action.Create({ Type = "Spell", ID = 1719}),
	-- Rotation
    Siegebreaker							= Action.Create({ Type = "Spell", ID = 280772, isTalent = true}), -- Talent
	Bloodthirst								= Action.Create({ Type = "Spell", ID = 23881}),
	Rampage									= Action.Create({ Type = "Spell", ID = 184367}),
	FuriousSlash							= Action.Create({ Type = "Spell", ID = 100130, isTalent = true}), -- Talent
	Bladestorm								= Action.Create({ Type = "Spell", ID = 46924, isTalent = true}), -- Talent
	Execute									= Action.Create({ Type = "Spell", ID = 5308}),
	RagingBlow								= Action.Create({ Type = "Spell", ID = 85288}),
	DragonRoar                            	= Action.Create({ Type = "Spell", ID = 118000, isTalent = true}), -- Talent
	Whirlwind								= Action.Create({ Type = "Spell", ID = 190411}),
	-- Talents
	Carnage									= Action.Create({ Type = "Spell", ID = 202922, Hidden = true, isTalent = true}), -- Talent
	Massacre								= Action.Create({ Type = "Spell", ID = 206315, Hidden = true, isTalent = true}), -- Talent
	FrothingBerserker						= Action.Create({ Type = "Spell", ID = 215571, Hidden = true, isTalent = true}), -- Talent
    RecklessAbandon                       	= Action.Create({ Type = "Spell", ID = 202751, Hidden = true, isTalent = true}), -- Talent    
	ColdSteelHotBlood						= Action.Create({ Type = "Spell", ID = 288080, Hidden = true}), -- Simcraft Azerite
    -- Buffs
    RecklessForceBuff                       = Action.Create({ Type = "Spell", ID = 302932, Hidden = true}),
    FujiedasFuryBuff                        = Action.Create({ Type = "Spell", ID = 207775, Hidden = true}),
    MeatCleaverBuff                         = Action.Create({ Type = "Spell", ID = 85739, Hidden = true}),
	EnrageBuff                              = Action.Create({ Type = "Spell", ID = 184362, Hidden = true}),
    FuriousSlashBuff                        = Action.Create({ Type = "Spell", ID = 202539, Hidden = true}),
    RecklessnessBuff                        = Action.Create({ Type = "Spell", ID = 1719, Hidden = true}),
	Enrage                                  = Action.Create({ Type = "Spell", ID = 184362, Hidden = true}),
	SuddenDeathBuff                         = Action.Create({ Type = "Spell", ID = 280776, Hidden = true}),
    -- Debuffs 
    RazorCoralDebuff                        = Action.Create({ Type = "Spell", ID = 303568, Hidden = true}),
    ConductiveInkDebuff                     = Action.Create({ Type = "Spell", ID = 302565, Hidden = true}),
    SiegebreakerDebuff                      = Action.Create({ Type = "Spell", ID = 280773, Hidden = true}),
    -- Trinkets    
    AzsharasFontofPower                     = Action.Create({ Type = "Trinket", ID = 169314 }),
    PocketsizedComputationDevice            = Action.Create({ Type = "Trinket", ID = 167555 }),
    RotcrustedVoodooDoll                    = Action.Create({ Type = "Trinket", ID = 159624 }),
    ShiverVenomRelic                        = Action.Create({ Type = "Trinket", ID = 168905 }),
    AquipotentNautilus                      = Action.Create({ Type = "Trinket", ID = 169305 }),
    TidestormCodex                          = Action.Create({ Type = "Trinket", ID = 165576 }),
    VialofStorms                            = Action.Create({ Type = "Trinket", ID = 158224 }),
	AshvanesRazorCoral                      = Action.Create({ Type = "Trinket", ID = 169311 }),
}

Action:CreateEssencesFor(ACTION_CONST_WARRIOR_FURY)
local A = setmetatable(Action[ACTION_CONST_WARRIOR_FURY], { __index = Action })

local Temp									= {
    TotalAndPhys							= {"TotalImun", "DamagePhysImun"},
    TotalAndPhysKick						= {"TotalImun", "DamagePhysImun", "KickImun"},
    TotalAndPhysAndCC						= {"TotalImun", "DamagePhysImun", "CCTotalImun"},
    TotalAndPhysAndStun						= {"TotalImun", "DamagePhysImun", "StunImun"},
    TotalAndPhysAndCCAndStun				= {"TotalImun", "DamagePhysImun", "CCTotalImun", "StunImun"},
	SlowPhys								= {"TotalImun", "DamagePhysImun", "Freedom", "CCTotalImun"},
}

local IsIndoors, UnitIsUnit = 
IsIndoors, UnitIsUnit

-- [1] CC AntiFake Rotation
local function AntiFakeStun(unit) 
    return 
    A.IsUnitEnemy(unit) and  Unit(unit):GetRange() <= 20 and 
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
            not A.IsUnitEnemy("target") and                     
            (
                (A.IsInPvP and EnemyTeam():PlayersInRange(20)) or 
                (not A.IsInPvP and MultiUnits:GetByRange(20, 1) >= 1)
            )
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
            
            if A.IntimidatingShoutAntiFake:IsReady(unit, nil, nil, true) and A.IntimidatingShoutAntiFake:AbsentImun(unit, Temp.TotalAndPhysAndCC, true) and Unit(unit):IsControlAble("fear", 0) then
                return A.IntimidatingShoutAntiFake:Show(icon)                  
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
	
	local EnragedRegeneration = A.GetToggle(2, "EnragedRegeneration")
    if     EnragedRegeneration >= 0 and A.EnragedRegeneration:IsReady("player") and 
    (
        (     -- Auto 
            EnragedRegeneration >= 100 and 
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
            EnragedRegeneration < 100 and 
            Unit("player"):HealthPercent() <= EnragedRegeneration
        )
    ) 
    then 
        return A.EnragedRegeneration
    end  
end 
SelfDefensives = A.MakeFunctionCachedStatic(SelfDefensives)

local function Interrupts(unit)
    local useKick, useCC, useRacial = A.InterruptIsValid(unit, "TargetMouseover")    
    
    if useKick and A.Pummel:IsReady(unit) and A.Pummel:AbsentImun(unit, Temp.TotalAndPhysKick, true) and Unit(unit):CanInterrupt(true) then 
        return A.Pummel
    end 
    
    if useCC and A.IntimidatingShout:IsReady(unit) and A.IntimidatingShout:AbsentImun(unit, Temp.TotalAndPhysAndCC, true) and Unit(unit):IsControlAble("fear", 0) then 
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

local function WWAllowed() --and ((A.Massacre:IsSpellLearned() and  Player:Rage() < 80) or (A.FrothingBerserker:IsSpellLearned() and Player:Rage() < 90))
	return A.Siegebreaker:GetCooldown() > A.GetGCD() and A.Bloodthirst:GetCooldown() > A.GetGCD()
end
-----------------------------------------
--                 ROTATION  
-----------------------------------------
-- [3] Single Rotation
A[3] = function(icon, isMulti)
    local unitID 				= "player"
    local isMoving 				= Player:IsMoving()
    local inMelee 				= false
	local inAoE					= A.GetToggle(2, "AoE")
	local inHoldAoE			 	= A.GetToggle(2, "holdAoE")
	local minHoldAoE			= A.GetToggle(2, "holdAoENum")
    --local Trinket1IsAllowed, Trinket2IsAllowed = TR.TrinketIsAllowed()
			
	local function EnemyRotation(unitID)
		-- Variables
        inMelee = A.Bloodthirst:IsInRange(unitID)

		-- Interrupts
        local Interrupt = Interrupts(unitID)
        if Interrupt then 
            return Interrupt:Show(icon)
        end  

		if A.VictoryRush:IsReady(unitID) and Unit("player"):HealthPercent() <= A.GetToggle(2, "VictoryRush") then
			return A.VictoryRush:Show(icon)
		end

		-- PiercingHowl (slow)
        if unitID ~= "mouseover" and A.PiercingHowl:IsReady(unitID) and Unit(unitID):HasDeBuffs(A.PiercingHowl.ID) <= 2 and not Unit(unitID):IsBoss() and Unit(unitID):GetRange() <= 14 and 
		A.PiercingHowl:AbsentImun(unitID, Temp.SlowPhys, true) and Unit(unitID):GetMaxSpeed() >= 100 and Unit(unitID):HasDeBuffs("Slowed") == 0 and not Unit(unitID):IsTotem() and
		Unit(unitID):IsMovingOut() then 
            return A.PiercingHowl:Show(icon)
        end
	
		--rampage,if=cooldown.recklessness.remains<3
		if A.Rampage:IsReady(unitID) and A.Rampage:AbsentImun(unitID, Temp.TotalAndPhys) and A.Recklessness:GetCooldown() < 3 then
			return A.Rampage:Show(icon)
		end
		
		-- Bursting
        if unitID ~= "mouseover" and A.BurstIsON(unitID) then             
            -- Simcraft 
            -- Cooldowns --						
			--blood_of_the_enemy,if=buff.recklessness.up
			if inHoldAoE and MultiUnits:GetByRange(8, minHoldAoE) >= minHoldAoE and inMelee and A.BloodoftheEnemy:AutoHeartOfAzeroth(unitID) and (Unit("player"):HasBuffs(A.RecklessnessBuff.ID, true) > 4 and A.Siegebreaker:GetCooldown() > 6) then                             
                return A.BloodoftheEnemy:Show(icon)                                                 
            elseif not inHoldAoE and inMelee and A.BloodoftheEnemy:AutoHeartOfAzeroth(unitID) and (Unit("player"):HasBuffs(A.RecklessnessBuff.ID, true) > 4 and A.Siegebreaker:GetCooldown() > 6) then 
				return A.BloodoftheEnemy:Show(icon)   
			end 

			--purifying_blast,if=!buff.recklessness.up&!buff.siegebreaker.up
			if (isMulti or A.GetToggle(2, "AoE")) and A.PurifyingBlast:AutoHeartOfAzeroth(unitID) and Unit("player"):HasBuffs(A.RecklessnessBuff.ID, true) <= 0 and	Unit(unitID):HasDeBuffs(A.SiegebreakerDebuff.ID) <= 0 then 
				return A.PurifyingBlast:Show(icon)
			end 
			
			--ripple_in_space,if=!buff.recklessness.up&!buff.siegebreaker.up
			if A.RippleinSpace:AutoHeartOfAzeroth(unitID) and Unit(unitID):GetRange() <= 25 and Unit("player"):HasBuffs(A.RecklessnessBuff.ID, true) <= 0 and	Unit(unitID):HasDeBuffs(A.SiegebreakerDebuff.ID) <= 0 then 
				return A.RippleinSpace:Show(icon)
			end 
			
			--guardian_of_azeroth,if=!buff.recklessness.up
            if A.GuardianofAzeroth:AutoHeartOfAzeroth(unitID) and Unit("player"):HasBuffs(A.RecklessnessBuff.ID, true) <= 0 then 
                return A.GuardianofAzeroth:Show(icon)
            end 
			
			--recklessness,if=!essence.condensed_lifeforce.major&!essence.blood_of_the_enemy.major|cooldown.guardian_of_azeroth.remains>20|buff.guardian_of_azeroth.up|cooldown.blood_of_the_enemy.remains<gcd
			if A.Recklessness:IsReady(unitID) and inMelee and (not A.GuardianofAzeroth:IsSpellLearned() and not A.BloodoftheEnemy:IsSpellLearned() or A.GuardianofAzeroth:GetCooldown() > 20 or 
			Unit("player"):HasBuffs(A.GuardianofAzeroth.ID, true) > 0 or A.BloodoftheEnemy:GetCooldown() <= A.GetCurrentGCD()) then
				return A.Recklessness:Show(icon)
			end
			
			if inMelee then 
                -- Racials 
                if A.BloodFury:AutoRacial(unitID) then 
                    return A.BloodFury:Show(icon)
                end 
                
                if A.Fireblood:AutoRacial(unitID) then 
                    return A.Fireblood:Show(icon)
                end 
                
                if A.AncestralCall:AutoRacial(unitID) then 
                    return A.AncestralCall:Show(icon)
                end 
                
                if A.Berserking:AutoRacial(unitID) then 
                    return A.Berserking:Show(icon)
                end 
				
				if A.Trinket1:IsReady(unit) and A.Trinket1:GetItemCategory() ~= "DEFF" and A.Trinket1:AbsentImun(unit, "DamageMagicImun")  then 
                    return A.Trinket1:Show(icon)
                end 
                
                if A.Trinket2:IsReady(unit) and A.Trinket2:GetItemCategory() ~= "DEFF" and A.Trinket2:AbsentImun(unit, "DamageMagicImun")  then 
                    return A.Trinket2:Show(icon)
                end   
				
				-- Razor Coral specific logic
			   -- if A.AshvanesRazorCoral:IsExists() and A.AshvanesRazorCoral:IsReady(unitID) and (not Unit(unitID):HasDeBuffs(A.RazorCoralDebuff.ID) <= 0 or (Unit(unitID):HasDeBuffs(A.RazorCoralDebuff.ID) > 0 and Unit(unitID):HealthPercent() <= 30 and Unit(unitID):TimeToDie() >= 10)) then
               --     if A.AshvanesRazorCoral:AbsentImun(unitID, "DamageMagicImun")  then 
				--       return A.AshvanesRazorCoral:Show(icon)
				--	end
              --  end
				
				-- Trinket1 with check for blacklisted trinkets
				--if Action.GetToggle(1, "Trinkets")[1] and A.Trinket2:GetItemCategory() ~= "DEFF" and A.Trinket1:IsReady(unitID) and Trinket1IsAllowed then	    
				--	if A.Trinket1:AbsentImun(unitID, "DamageMagicImun")  then 
				--		return A.Trinket1:Show(icon)
				--	end 		
			--	end
		
				-- Trinket2 with check for blacklisted trinkets
			--	if Action.GetToggle(1, "Trinkets")[2] and A.Trinket1:GetItemCategory() ~= "DEFF" and A.Trinket2:IsReady(unitID) and Trinket2IsAllowed then	    
			--		if A.Trinket2:AbsentImun(unitID, "DamageMagicImun")  then 
			--			return A.Trinket2:Show(icon)
			--		end 	
			--	end                   
            end 
            
            if A.FocusedAzeriteBeam:AutoHeartOfAzeroth(unitID) then 
                return A.FocusedAzeriteBeam:Show(icon)
            end 
            
			
            
            if A.WorldveinResonance:AutoHeartOfAzeroth(unitID) then 
                return A.WorldveinResonance:Show(icon)
            end 
        end
		
		--whirlwind
		if inAoE and MultiUnits:GetByRange(8, 2) >= 2 and A.Whirlwind:IsReady(unitID, true) and A.Whirlwind:AbsentImun(unitID, Temp.TotalAndPhys) and Unit("player"):HasBuffs(A.MeatCleaverBuff.ID, true) == 0 and A.LastPlayerCastID ~= A.Whirlwind.ID then
			return A.Whirlwind:Show(icon)
		end

		-- Single SimC 01/08/2019
		--siegebreaker
		if A.Siegebreaker:IsReady(unitID) and A.Siegebreaker:AbsentImun(unitID, Temp.TotalAndPhys) then
			return A.Siegebreaker:Show(icon)
        end 
		
		if A.GetToggle(2, "RampageLogic") == "Simcraft Logic" then
			--rampage,if=(buff.recklessness.up|buff.memory_of_lucid_dreams.up)|(talent.frothing_berserker.enabled|talent.carnage.enabled&(buff.enrage.remains<gcd|rage>90)|talent.massacre.enabled&(buff.enrage.remains<gcd|rage>90))
			if A.Rampage:IsReady(unitID) and A.Rampage:AbsentImun(unitID, Temp.TotalAndPhys) and ((Unit("player"):HasBuffs(A.RecklessnessBuff.ID, true) > 0 or  Unit("player"):HasBuffs(A.MemoryofLucidDreams.ID, true) > 0) or 
			(A.FrothingBerserker:IsSpellLearned() or A.Carnage:IsSpellLearned() and (Unit("player"):HasBuffs(A.EnrageBuff.ID, true) < A.GetGCD() or Player:Rage() > 90) or 
			A.Massacre:IsSpellLearned() and (Unit("player"):HasBuffs(A.EnrageBuff.ID, true) < A.GetGCD() or Player:Rage() > 90))) then
				return A.Rampage:Show(icon)
			end
		elseif A.GetToggle(2, "RampageLogic") == "High Priority Logic" then
			if A.Rampage:IsReady(unitID) and A.Rampage:AbsentImun(unitID, Temp.TotalAndPhys) then
				return A.Rampage:Show(icon)
			end
		end	
		
		-- execute,if=buff.enrage.up
        if A.Execute:IsReady(unitID) and Unit("player"):HasBuffs(A.SuddenDeathBuff.ID, true) > 0 and Unit("player"):HasBuffs(A.EnrageBuff.ID, true) > 0 then
		    return A.Execute:Show(icon)
        end
		
		--execute
		if A.Execute:IsReady(unitID) and A.Execute:AbsentImun(unitID, Temp.TotalAndPhys) then
			return A.Execute:Show(icon)
		end
		
		--furious_slash,if=!buff.bloodlust.up&buff.furious_slash.remains<3
		if A.FuriousSlash:IsReady(unitID) and A.FuriousSlash:AbsentImun(unitID, Temp.TotalAndPhys) and Unit("player"):HasBuffs("BurstHaste") <= 0 and Unit("player"):HasBuffs(A.FuriousSlashBuff.ID, true) < 3 then
			return A.FuriousSlash:Show(icon)
		end
		
		--bladestorm,if=prev_gcd.1.rampage
		if A.Bladestorm:IsReady(unitID) and A.Bladestorm:AbsentImun(unitID, Temp.TotalAndPhys) and A.LastPlayerCastID == A.Rampage.ID then
			return A.Bladestorm:Show(icon)
		end
		
		--bloodthirst,if=buff.enrage.down|azerite.cold_steel_hot_blood.rank>1
		if A.Bloodthirst:IsReady(unitID) and A.Bloodthirst:AbsentImun(unitID, Temp.TotalAndPhys) and (Unit("player"):HasBuffs(A.EnrageBuff.ID, true) == 0 or A.ColdSteelHotBlood:GetAzeriteRank() > 1) then
			return A.Bloodthirst:Show(icon)
		end
		--/dump Action.MultiUnits:GetByRange(8, 2)
		--dragon_roar,if=buff.enrage.up
		if inHoldAoE and MultiUnits:GetByRange(8, minHoldAoE) >= minHoldAoE and A.DragonRoar:IsReady(unitID, true) and A.DragonRoar:AbsentImun(unitID, Temp.TotalAndPhys) and Unit(unitID):GetRange() <= 12 and Unit("player"):HasBuffs(A.EnrageBuff.ID, true) > 0 then
			return A.DragonRoar:Show(icon)
		elseif not inHoldAoE and A.DragonRoar:IsReady(unitID, true) and A.DragonRoar:AbsentImun(unitID, Temp.TotalAndPhys) and Unit(unitID):GetRange() <= 12 and Unit("player"):HasBuffs(A.EnrageBuff.ID, true) > 0 then
			return A.DragonRoar:Show(icon)
		end
		
		--raging_blow,if=charges=2
		if A.RagingBlow:IsReady(unitID) and A.RagingBlow:AbsentImun(unitID, Temp.TotalAndPhys) and A.RagingBlow:GetSpellCharges() == 2 then
			return A.RagingBlow:Show(icon)
		end
		
		--bloodthirst
		if A.Bloodthirst:IsReady(unitID) and A.Bloodthirst:AbsentImun(unitID, Temp.TotalAndPhys) then
			return A.Bloodthirst:Show(icon)
		end

		--raging_blow,if=talent.carnage.enabled|(talent.massacre.enabled&rage<80)|(talent.frothing_berserker.enabled&rage<90)
		if A.RagingBlow:IsReady(unitID) and A.RagingBlow:AbsentImun(unitID, Temp.TotalAndPhys) and (A.Carnage:IsSpellLearned() or (A.Massacre:IsSpellLearned() and  Player:Rage() < 80) or 
		(A.FrothingBerserker:IsSpellLearned() and Player:Rage() < 90)) then
			return A.RagingBlow:Show(icon)
		end
			
		--furious_slash,if=talent.furious_slash.enabled
		if A.FuriousSlash:IsReady(unitID) and A.FuriousSlash:AbsentImun(unitID, Temp.TotalAndPhys) then
			return A.FuriousSlash:Show(icon)
		end
		
		--whirlwind
		if A.Whirlwind:IsReady(unitID, true) and A.Whirlwind:AbsentImun(unitID, Temp.TotalAndPhys) and inMelee and WWAllowed() then
			return A.Whirlwind:Show(icon)
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
    
    -- Movement
    -- If not moving or moving lower than 2.5 sec 
    if Player:IsMovingTime() < 2.5 then 
        return 
    end 	
end  