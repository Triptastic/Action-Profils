-----------------------------
-- Taste TMW Action Rotation
-----------------------------
--- ====================== ACTION HEADER ============================ ---
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
local Pet                                       = LibStub("PetLibrary")
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

--- ============================ CONTENT ===========================
--- ======= APL LOCALS =======
-- luacheck: max_line_length 9999

-- Spells
Action[ACTION_CONST_WARRIOR_ARMS] = {
    -- Racial
    ArcaneTorrent                          = Action.Create({ Type = "Spell", ID = 50613     }),
    BloodFury                              = Action.Create({ Type = "Spell", ID = 20572      }),
    Fireblood                              = Action.Create({ Type = "Spell", ID = 265221     }),
    AncestralCall                          = Action.Create({ Type = "Spell", ID = 274738     }),
    Berserking                             = Action.Create({ Type = "Spell", ID = 26297    }),
    ArcanePulse                            = Action.Create({ Type = "Spell", ID = 260364    }),
    QuakingPalm                            = Action.Create({ Type = "Spell", ID = 107079     }),
    Haymaker                               = Action.Create({ Type = "Spell", ID = 287712     }), 
    WarStomp                               = Action.Create({ Type = "Spell", ID = 20549     }),
    BullRush                               = Action.Create({ Type = "Spell", ID = 255654     }),  
    GiftofNaaru                            = Action.Create({ Type = "Spell", ID = 59544    }),
    Shadowmeld                             = Action.Create({ Type = "Spell", ID = 58984    }), -- usable in Action Core 
    Stoneform                              = Action.Create({ Type = "Spell", ID = 20594    }), 
    WilloftheForsaken                      = Action.Create({ Type = "Spell", ID = 7744        }), -- not usable in APL but user can Queue it   
    EscapeArtist                           = Action.Create({ Type = "Spell", ID = 20589    }), -- not usable in APL but user can Queue it
    EveryManforHimself                     = Action.Create({ Type = "Spell", ID = 59752    }), -- not usable in APL but user can Queue it
    -- Generics
    Skullsplitter                          = Action.Create({ Type = "Spell", ID = 260643 }),
    DeadlyCalmBuff                         = Action.Create({ Type = "Spell", ID = 262228 }),
    Ravager                                = Action.Create({ Type = "Spell", ID = 152277 }),
    ColossusSmash                          = Action.Create({ Type = "Spell", ID = 167105 }),
    Warbreaker                             = Action.Create({ Type = "Spell", ID = 262161 }),
    DeadlyCalm                             = Action.Create({ Type = "Spell", ID = 262228 }),
    Bladestorm                             = Action.Create({ Type = "Spell", ID = 227847 }),
    TestofMightBuff                        = Action.Create({ Type = "Spell", ID = 275540 }),
    Cleave                                 = Action.Create({ Type = "Spell", ID = 845 }),
    Slam                                   = Action.Create({ Type = "Spell", ID = 1464 }),
    CrushingAssaultBuff                    = Action.Create({ Type = "Spell", ID = 278826 }),
    MortalStrike                           = Action.Create({ Type = "Spell", ID = 12294 }),
    OverpowerBuff                          = Action.Create({ Type = "Spell", ID = 7384 }),
    Dreadnaught                            = Action.Create({ Type = "Spell", ID = 262150 }),
    ExecutionersPrecisionBuff              = Action.Create({ Type = "Spell", ID = 242188 }),
    Overpower                              = Action.Create({ Type = "Spell", ID = 7384 }),
    ColossusSmashDebuff                    = Action.Create({ Type = "Spell", ID = 208086 }),
    SweepingStrikesBuff                    = Action.Create({ Type = "Spell", ID = 260708 }),
    TestofMight                            = Action.Create({ Type = "Spell", ID = 275529 }),
    DeepWoundsDebuff                       = Action.Create({ Type = "Spell", ID = 262115 }),
    SuddenDeathBuff                        = Action.Create({ Type = "Spell", ID = 52437 }),
    StoneHeartBuff                         = Action.Create({ Type = "Spell", ID = 225947 }),
    SweepingStrikes                        = Action.Create({ Type = "Spell", ID = 260708 }),
    Whirlwind                              = Action.Create({ Type = "Spell", ID = 1680 }),
    FervorofBattle                         = Action.Create({ Type = "Spell", ID = 202316 }),
    Rend                                   = Action.Create({ Type = "Spell", ID = 772 }),
    RendDebuff                             = Action.Create({ Type = "Spell", ID = 772 }),
    AngerManagement                        = Action.Create({ Type = "Spell", ID = 152278 }),
    SeismicWave                            = Action.Create({ Type = "Spell", ID = 277639 }),
    Charge                                 = Action.Create({ Type = "Spell", ID = 100 }),
    BloodFury                              = Action.Create({ Type = "Spell", ID = 20572 }),
    Berserking                             = Action.Create({ Type = "Spell", ID = 26297 }),
    ArcaneTorrent                          = Action.Create({ Type = "Spell", ID = 50613 }),
    LightsJudgment                         = Action.Create({ Type = "Spell", ID = 255647 }),
    Fireblood                              = Action.Create({ Type = "Spell", ID = 265221 }),
    AncestralCall                          = Action.Create({ Type = "Spell", ID = 274738 }),
    Avatar                                 = Action.Create({ Type = "Spell", ID = 107574 }),
    Massacre                               = Action.Create({ Type = "Spell", ID = 281001 }),
    ExecuteDefault                         = Action.Create({ Type = "Spell", ID = 163201 }),
    ExecuteMassacre                        = Action.Create({ Type = "Spell", ID = 281000 }),
    -- Potions
    PotionofUnbridledFury                  = Action.Create({ Type = "Potion", ID = 169299, QueueForbidden = true }), 
    BattlePotionOfAgility                  = Action.Create({ Type = "Potion", ID = 163223, QueueForbidden = true }), 
    SuperiorBattlePotionOfAgility          = Action.Create({ Type = "Potion", ID = 168489, QueueForbidden = true }), 
    PotionTest                             = Action.Create({ Type = "Potion", ID = 142117, QueueForbidden = true }), 
    -- Trinkets
    GenericTrinket1                        = Action.Create({ Type = "Trinket", ID = 114616, QueueForbidden = true }),
    GenericTrinket2                        = Action.Create({ Type = "Trinket", ID = 114081, QueueForbidden = true }),
    TrinketTest                            = Action.Create({ Type = "Trinket", ID = 122530, QueueForbidden = true }),
    TrinketTest2                           = Action.Create({ Type = "Trinket", ID = 159611, QueueForbidden = true }), 
    AzsharasFontofPower                    = Action.Create({ Type = "Trinket", ID = 169314, QueueForbidden = true }),
    PocketsizedComputationDevice           = Action.Create({ Type = "Trinket", ID = 167555, QueueForbidden = true }),
    RotcrustedVoodooDoll                   = Action.Create({ Type = "Trinket", ID = 159624, QueueForbidden = true }),
    ShiverVenomRelic                       = Action.Create({ Type = "Trinket", ID = 168905, QueueForbidden = true }),
    AquipotentNautilus                     = Action.Create({ Type = "Trinket", ID = 169305, QueueForbidden = true }),
    TidestormCodex                         = Action.Create({ Type = "Trinket", ID = 165576, QueueForbidden = true }),
    VialofStorms                           = Action.Create({ Type = "Trinket", ID = 158224, QueueForbidden = true }),
    GalecallersBoon                        = Action.Create({ Type = "Trinket", ID = 159614, QueueForbidden = true }),
    InvocationOfYulon                      = Action.Create({ Type = "Trinket", ID = 165568, QueueForbidden = true }),
    LustrousGoldenPlumage                  = Action.Create({ Type = "Trinket", ID = 159617, QueueForbidden = true }),
    ComputationDevice                      = Action.Create({ Type = "Trinket", ID = 167555, QueueForbidden = true }),
    VigorTrinket                           = Action.Create({ Type = "Trinket", ID = 165572, QueueForbidden = true }),
    FontOfPower                            = Action.Create({ Type = "Trinket", ID = 169314, QueueForbidden = true }),
    RazorCoral                             = Action.Create({ Type = "Trinket", ID = 169311, QueueForbidden = true }),
    AshvanesRazorCoral                     = Action.Create({ Type = "Trinket", ID = 169311, QueueForbidden = true }),
    -- Misc
    Channeling                             = Action.Create({ Type = "Spell", ID = 209274, Hidden = true     }),	-- Show an icon during channeling
    TargetEnemy                            = Action.Create({ Type = "Spell", ID = 44603, Hidden = true     }),	-- Change Target (Tab button)
    StopCast                               = Action.Create({ Type = "Spell", ID = 61721, Hidden = true     }),		-- spell_magic_polymorphrabbit
    CyclotronicBlast                       = Action.Create({ Type = "Spell", ID = 293491, Hidden = true}),
    ConcentratedFlameBurn                  = Action.Create({ Type = "Spell", ID = 295368, Hidden = true}),
    RazorCoralDebuff                       = Action.Create({ Type = "Spell", ID = 303568, Hidden = true     }),
    ConductiveInkDebuff                    = Action.Create({ Type = "Spell", ID = 302565, Hidden = true     }),
    -- Hidden Heart of Azeroth
    -- added all 3 ranks ids in case used by rotation
    VisionofPerfectionMinor                = Action.Create({ Type = "Spell", ID = 296320, Hidden = true}),
    VisionofPerfectionMinor2               = Action.Create({ Type = "Spell", ID = 299367, Hidden = true}),
    VisionofPerfectionMinor3               = Action.Create({ Type = "Spell", ID = 299369, Hidden = true}),
    UnleashHeartOfAzeroth                  = Action.Create({ Type = "Spell", ID = 280431, Hidden = true}),
    RecklessForceBuff                      = Action.Create({ Type = "Spell", ID = 302932, Hidden = true     }),	 
};

-- To create essences use next code:
Action:CreateEssencesFor(ACTION_CONST_WARRIOR_ARMS)  -- where PLAYERSPEC is Constance (example: ACTION_CONST_MONK_BM)
local A = setmetatable(Action[ACTION_CONST_WARRIOR_ARMS], { __index = Action })

local function num(val)
    if val then return 1 else return 0 end
end

local function bool(val)
    return val ~= 0
end

------------------------------------------
-------------- COMMON PREAPL -------------
------------------------------------------
local Temp = {
    TotalAndPhys                            = {"TotalImun", "DamagePhysImun"},
	TotalAndCC                              = {"TotalImun", "CCTotalImun"},
    TotalAndPhysKick                        = {"TotalImun", "DamagePhysImun", "KickImun"},
    TotalAndPhysAndCC                       = {"TotalImun", "DamagePhysImun", "CCTotalImun"},
    TotalAndPhysAndStun                     = {"TotalImun", "DamagePhysImun", "StunImun"},
    TotalAndPhysAndCCAndStun                = {"TotalImun", "DamagePhysImun", "CCTotalImun", "StunImun"},
    TotalAndMag                             = {"TotalImun", "DamageMagicImun"},
	TotalAndMagKick                         = {"TotalImun", "DamageMagicImun", "KickImun"},
    DisablePhys                             = {"TotalImun", "DamagePhysImun", "Freedom", "CCTotalImun"},
    DisableMag                              = {"TotalImun", "DamageMagicImun", "Freedom", "CCTotalImun"},
}

local IsIndoors, UnitIsUnit = IsIndoors, UnitIsUnit

local function IsSchoolFree()
	return LoC:IsMissed("SILENCE") and LoC:Get("SCHOOL_INTERRUPT", "SHADOW") == 0
end 

local function InMelee(unit)
	-- @return boolean 
	return A.MortalStrike:IsInRange(unit)
end 

local function GetByRange(count, range, isCheckEqual, isCheckCombat)
	-- @return boolean 
	local c = 0 
	for unit in pairs(ActiveUnitPlates) do 
		if (not isCheckEqual or not UnitIsUnit("target", unit)) and (not isCheckCombat or Unit(unit):CombatTime() > 0) then 
			if InMelee(unit) then 
				c = c + 1
			elseif range then 
				local r = Unit(unit):GetRange()
				if r > 0 and r <= range then 
					c = c + 1
				end 
			end 
			
			if c >= count then 
				return true 
			end 
		end 
	end
end 
GetByRange = A.MakeFunctionCachedDynamic(GetByRange)

local function UpdateExecuteID()
    Execute = A.Massacre:IsSpellLearned() and A.ExecuteMassacre or A.ExecuteDefault
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
A[3] = function(icon, isMulti)
    local unitID 				= "player"
    local isMoving 				= Player:IsMoving()
    local inMelee 				= false
	local inAoE					= A.GetToggle(2, "AoE")
	
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

		 if unit ~= "mouseover" and A.BurstIsON(unit) then     
			if inMelee then 
                -- Racials 
                if A.BloodFury:AutoRacial(unit) and Unit(unit):HasDeBuffs(A.ColossusSmashDebuff.ID) > 0 then 
                    return A.BloodFury:Show(icon)
                end 
                
                if A.Fireblood:AutoRacial(unit) and Unit(unit):HasDeBuffs(A.ColossusSmashDebuff.ID) > 0 then 
                    return A.Fireblood:Show(icon)
                end 
                
                if A.AncestralCall:AutoRacial(unit) and Unit(unit):HasDeBuffs(A.ColossusSmashDebuff.ID) > 0 then 
                    return A.AncestralCall:Show(icon)
                end 
                
                if A.Berserking:AutoRacial(unit) and Unit(unit):HasDeBuffs(A.ColossusSmashDebuff.ID) > 0 then 
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
			
			if A.BloodoftheEnemy:AutoHeartOfAzerothP(unit) and (Unit("player"):HasBuffs(A.TestofMightBuff.ID, true) > 0 or (Unit(unit):HasDeBuffs(A.ColossusSmashDebuff.ID) > 0 and TestofMightBuff:GetAzeriteRank() > 1)) then
				return A.BloodoftheEnemy:Show(icon)    
			end
			
			if A.PurifyingBlast:AutoHeartOfAzerothP(unit) and (Unit("player"):HasBuffs(A.TestofMightBuff.ID, true) <= 0 and Unit(unit):HasDeBuffs(A.ColossusSmashDebuff.ID) <= 0) then
				return A.PurifyingBlast:Show(icon)
			end
			
			if A.RippleinSpace:AutoHeartOfAzerothP(unit) and (Unit("player"):HasBuffs(A.TestofMightBuff.ID, true) <= 0 and Unit(unit):HasDeBuffs(A.ColossusSmashDebuff.ID) <= 0) then
				return A.RippleinSpace:Show(icon)
			end
			
			if A.WorldveinResonance:AutoHeartOfAzerothP(unit) and (Unit("player"):HasBuffs(A.TestofMightBuff.ID, true) <= 0 and Unit(unit):HasDeBuffs(A.ColossusSmashDebuff.ID) <= 0) then
                return A.WorldveinResonance:Show(icon)
            end 
			
			if A.FocusedAzeriteBeam:AutoHeartOfAzerothP(unit) and (Unit("player"):HasBuffs(A.TestofMightBuff.ID, true) <= 0 and Unit(unit):HasDeBuffs(A.ColossusSmashDebuff.ID) <= 0) then 
                return A.FocusedAzeriteBeam:Show(icon)
            end 
			
			if A.ConcentratedFlame:AutoHeartOfAzeroth(unit) and (Unit("player"):HasBuffs(A.TestofMightBuff.ID, true) <= 0 and Unit(unit):HasDeBuffs(A.ColossusSmashDebuff.ID) <= 0) then 
				return A.ConcentratedFlame:Show(icon)
			end 
			
			--guardian_of_azeroth,if=cooldown.colossus_smash.remains<10
			if A.GuardianofAzeroth:AutoHeartOfAzerothP(unit) and (A.ColossusSmash:GetCooldown() < 10 or (A.Warbreaker:IsSpellLearned() and A.Warbreaker:GetCooldown() < 10)) then 
                return A.GuardianofAzeroth:Show(icon)
            end
			
			--if=!talent.warbreaker.enabled&cooldown.colossus_smash.remains<3|cooldown.warbreaker.remains<3
			 if A.MemoryofLucidDreams:AutoHeartOfAzerothP(unit) and (not A.Warbreaker:IsSpellLearned() and A.ColossusSmash:GetCooldown() < 3 or A.Warbreaker:GetCooldown() < 3) then
                return A.MemoryofLucidDreams:Show(icon)
            end
		 end

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
		
		if A.SharpenBlade:IsReady("player") then 
			return A.SharpenBlade:Show(icon)
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
    return ArenaRotation(icon, "arena1")
end

A[7] = function(icon)   
    local Party = PartyRotation("party1") 
    if Party then 
		return Party:Show(icon)
	end 
	
    return ArenaRotation(icon, "arena2")
end

A[8] = function(icon)   
	local Party = PartyRotation("party1") 
    if Party then 
		return Party:Show(icon)
	end 
    
	return ArenaRotation(icon, "arena3")
end