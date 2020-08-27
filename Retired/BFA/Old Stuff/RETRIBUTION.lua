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

-- Spells
Action[ACTION_CONST_PALADIN_RETRIBUTION] = {
    -- Racial
    ArcaneTorrent                          = Create({ Type = "Spell", ID = 50613     }),
    BloodFury                              = Create({ Type = "Spell", ID = 20572      }),
    Fireblood                              = Create({ Type = "Spell", ID = 265221     }),
    AncestralCall                          = Create({ Type = "Spell", ID = 274738     }),
    Berserking                             = Create({ Type = "Spell", ID = 26297    }),
    ArcanePulse                            = Create({ Type = "Spell", ID = 260364    }),
    QuakingPalm                            = Create({ Type = "Spell", ID = 107079     }),
    Haymaker                               = Create({ Type = "Spell", ID = 287712     }), 
    WarStomp                               = Create({ Type = "Spell", ID = 20549     }),
    BullRush                               = Create({ Type = "Spell", ID = 255654     }),  
    GiftofNaaru                            = Create({ Type = "Spell", ID = 59544    }),
    Shadowmeld                             = Create({ Type = "Spell", ID = 58984    }), -- usable in Action Core 
    Stoneform                              = Create({ Type = "Spell", ID = 20594    }), 
    WilloftheForsaken                      = Create({ Type = "Spell", ID = 7744        }), -- not usable in APL but user can Queue it   
    EscapeArtist                           = Create({ Type = "Spell", ID = 20589    }), -- not usable in APL but user can Queue it
    EveryManforHimself                     = Create({ Type = "Spell", ID = 59752    }), -- not usable in APL but user can Queue it
    -- Generic Spells
    WakeofAshes                            = Create({ Type = "Spell", ID = 255937     }),
    LightsJudgment                         = Create({ Type = "Spell", ID = 255647     }),
    ShieldofVengeance                      = Create({ Type = "Spell", ID = 184662     }),
    AvengingWrath                          = Create({ Type = "Spell", ID = 31884     }),
    Inquisition                            = Create({ Type = "Spell", ID = 84963     }),
    Crusade                                = Create({ Type = "Spell", ID = 231895     }),
    RighteousVerdict                       = Create({ Type = "Spell", ID = 267610     }),
    ExecutionSentence                      = Create({ Type = "Spell", ID = 267798     }),
    DivineStorm                            = Create({ Type = "Spell", ID = 53385     }),
    DivinePurpose                          = Create({ Type = "Spell", ID = 223817     }),
    TemplarsVerdict                        = Create({ Type = "Spell", ID = 85256     }),
    HammerofWrath                          = Create({ Type = "Spell", ID = 24275     }),
    BladeofJustice                         = Create({ Type = "Spell", ID = 184575     }),
    Judgment                               = Create({ Type = "Spell", ID = 20271     }),
    Consecration                           = Create({ Type = "Spell", ID = 205228     }),
    CrusaderStrike                         = Create({ Type = "Spell", ID = 35395     }),
    Rebuke                                 = Create({ Type = "Spell", ID = 96231     }),
    FistofJustice                          = Create({ Type = "Spell", ID = 198054     }),
    Repentance                             = Create({ Type = "Spell", ID = 20066     }), 
    Cavalier                               = Create({ Type = "Spell", ID = 190784     }),
	JusticarsVengeance                     = Create({ Type = "Spell", ID = 215661    }),
    BlessingofProtectionYellow             = Create({ Type = "Spell", ID = 1022, Color = "YELLOW", Desc = "YELLOW Color for Party Blessing"     }),	
    BlessingofProtection                   = Create({ Type = "Spell", ID = 1022     }), 
    WordofGlory                            = Create({ Type = "Spell", ID = 210191     }),
    BlessingofFreedom                      = Create({ Type = "Spell", ID = 1044     }),
    BlessingofFreedomYellow                = Create({ Type = "Spell", ID = 1044, Color = "YELLOW", Desc = "YELLOW Color for Party Blessing"     }),	
    HammerofJustice                        = Create({ Type = "Spell", ID = 853     }),
	HammerofJusticeGreen                   = Create({ Type = "SpellSingleColor", ID = 853, Color = "GREEN", Desc = "[1] CC", QueueForbidden = true }),
	DivineShield                           = Create({ Type = "Spell", ID = 642     }),
	FlashofLight                           = Create({ Type = "Spell", ID = 19750   }),
    CleanseToxins                          = Create({ Type = "Spell", ID = 213644   }),
    -- PvP
    HammerofReckoning                      = Create({ Type = "Spell", ID = 247675     }),
    BlessingofSanctuary                    = Create({ Type = "Spell", ID = 210256     }),
    BlessingofSanctuaryYellow              = Create({ Type = "Spell", ID = 210256, Color = "YELLOW", Desc = "YELLOW Color for Party Blessing"     }),	
    -- Buffs
    DivinePurposeBuff                      = Create({ Type = "Spell", ID = 223819, Hidden = true     }),
    EmpyreanPowerBuff                      = Create({ Type = "Spell", ID = 286393, Hidden = true     }),
    AvengingWrathBuff                      = Create({ Type = "Spell", ID = 31884, Hidden = true     }),
    AvengingWrathAutocritBuff              = Create({ Type = "Spell", ID = 294027, Hidden = true     }),
    InquisitionBuff                        = Create({ Type = "Spell", ID = 84963, Hidden = true     }),  
    CrusadeBuff                            = Create({ Type = "Spell", ID = 231895, Hidden = true     }), 
    SeethingRageBuff                       = Create({ Type = "Spell", ID = 297126, Hidden = true     }), 
    RecklessForceBuff                      = Create({ Type = "Spell", ID = 302932, Hidden = true     }),  
    SelfLessHealerBuff                     = Create({ Type = "Spell", ID = 114250, Hidden = true     }), 
    -- Debuffs
    JudgmentDebuff                         = Create({ Type = "Spell", ID = 197277, Hidden = true     }),
    ConcentratedFlameBurn                  = Create({ Type = "Spell", ID = 295368, Hidden = true     }),
    RazorCoralDebuff                       = Create({ Type = "Spell", ID = 303568, Hidden = true     }),
	
    -- Trinkets
    TrinketTest                            = Create({ Type = "Trinket", ID = 122530, QueueForbidden = true }), 
    TrinketTest2                           = Create({ Type = "Trinket", ID = 159611, QueueForbidden = true }), 
    AzsharasFontofPower                    = Create({ Type = "Trinket", ID = 169314, QueueForbidden = true }), 
    PocketsizedComputationDevice           = Create({ Type = "Trinket", ID = 167555, QueueForbidden = true }), 
    RotcrustedVoodooDoll                   = Create({ Type = "Trinket", ID = 159624, QueueForbidden = true }), 
    ShiverVenomRelic                       = Create({ Type = "Trinket", ID = 168905, QueueForbidden = true }), 
    AquipotentNautilus                     = Create({ Type = "Trinket", ID = 169305, QueueForbidden = true }), 
    TidestormCodex                         = Create({ Type = "Trinket", ID = 165576, QueueForbidden = true }), 
    VialofStorms                           = Create({ Type = "Trinket", ID = 158224, QueueForbidden = true }), 
    -- Potions
    PotionofUnbridledFury                  = Create({ Type = "Potion", ID = 169299 }), 
    SuperiorPotionofUnbridledFury          = Create({ Type = "Potion", ID = 168489 }), 
	PotionofFocusedResolve                 = Create({ Type = "Potion", ID = 168506 }),
	SuperiorBattlePotionofStrength         = Create({ Type = "Potion", ID = 168500 }),
	PotionofEmpoweredProximity             = Create({ Type = "Potion", ID = 168529 }),
    PotionTest                             = Create({ Type = "Potion", ID = 142117, QueueForbidden = true }), 
    -- Trinkets
    GenericTrinket1                        = Create({ Type = "Trinket", ID = 114616, QueueForbidden = true }),
    GenericTrinket2                        = Create({ Type = "Trinket", ID = 114081, QueueForbidden = true }),
    TrinketTest                            = Create({ Type = "Trinket", ID = 122530, QueueForbidden = true }),
    TrinketTest2                           = Create({ Type = "Trinket", ID = 159611, QueueForbidden = true }), 
    AzsharasFontofPower                    = Create({ Type = "Trinket", ID = 169314, QueueForbidden = true }),
    PocketsizedComputationDevice           = Create({ Type = "Trinket", ID = 167555, QueueForbidden = true }),
    RotcrustedVoodooDoll                   = Create({ Type = "Trinket", ID = 159624, QueueForbidden = true }),
    ShiverVenomRelic                       = Create({ Type = "Trinket", ID = 168905, QueueForbidden = true }),
    AquipotentNautilus                     = Create({ Type = "Trinket", ID = 169305, QueueForbidden = true }),
    TidestormCodex                         = Create({ Type = "Trinket", ID = 165576, QueueForbidden = true }),
    VialofStorms                           = Create({ Type = "Trinket", ID = 158224, QueueForbidden = true }),
    GalecallersBoon                        = Create({ Type = "Trinket", ID = 159614, QueueForbidden = true }),
    InvocationOfYulon                      = Create({ Type = "Trinket", ID = 165568, QueueForbidden = true }),
    LustrousGoldenPlumage                  = Create({ Type = "Trinket", ID = 159617, QueueForbidden = true }),
    ComputationDevice                      = Create({ Type = "Trinket", ID = 167555, QueueForbidden = true }),
    VigorTrinket                           = Create({ Type = "Trinket", ID = 165572, QueueForbidden = true }),
    FontOfPower                            = Create({ Type = "Trinket", ID = 169314, QueueForbidden = true }),
    RazorCoral                             = Create({ Type = "Trinket", ID = 169311, QueueForbidden = true }),
    AshvanesRazorCoral                     = Create({ Type = "Trinket", ID = 169311, QueueForbidden = true }),
    -- Misc
    Channeling                             = Create({ Type = "Spell", ID = 209274, Hidden = true     }),	-- Show an icon during channeling
    TargetEnemy                            = Create({ Type = "Spell", ID = 44603, Hidden = true     }),	-- Change Target (Tab button)
    StopCast                               = Create({ Type = "Spell", ID = 61721, Hidden = true     }),		-- spell_magic_polymorphrabbit
    CyclotronicBlast                       = Create({ Type = "Spell", ID = 293491, Hidden = true}),
    ConcentratedFlameBurn                  = Create({ Type = "Spell", ID = 295368, Hidden = true}),
    RazorCoralDebuff                       = Create({ Type = "Spell", ID = 303568, Hidden = true     }),
    ConductiveInkDebuff                    = Create({ Type = "Spell", ID = 302565, Hidden = true     }),
	CleansingLight                         = Create({ Type = "Spell", ID = 236186, Hidden = true     }), -- Talent AoE Dispell
	
    -- Hidden Heart of Azeroth
    -- added all 3 ranks ids in case used by rotation
    VisionofPerfectionMinor                = Create({ Type = "Spell", ID = 296320, Hidden = true     }),
    VisionofPerfectionMinor2               = Create({ Type = "Spell", ID = 299367, Hidden = true     }),
    VisionofPerfectionMinor3               = Create({ Type = "Spell", ID = 299369, Hidden = true     }),
    UnleashHeartOfAzeroth                  = Create({ Type = "Spell", ID = 280431, Hidden = true     }),
    RecklessForceBuff                      = Create({ Type = "Spell", ID = 302932, Hidden = true     }),	
    PoolResource                           = Create({ Type = "Spell", ID = 209274, Hidden = true     }),
    DummyTest                              = Create({ Type = "Spell", ID = 159999, Hidden = true     }), -- Dummy stop dps icon	
};

-- To create essences use next code:
Action:CreateEssencesFor(ACTION_CONST_PALADIN_RETRIBUTION)  -- where PLAYERSPEC is Constance (example: ACTION_CONST_MONK_BM)
local A = setmetatable(Action[ACTION_CONST_PALADIN_RETRIBUTION], { __index = Action })


------------------------------------------
---------------- VARIABLES ---------------
------------------------------------------
local VarWingsPool = false
local VarDsCastable = false
local VarHow = false
local player = "player"

A.Listener:Add("ROTATION_VARS", "PLAYER_REGEN_ENABLED", function()
  VarWingsPool = false
  VarDsCastable = false
  VarHow = false
end)

local function num(val)
    if val then return 1 else return 0 end
end

local function bool(val)
    return val ~= 0
end
local player = "player"
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

local function IsHolySchoolFree()
	return LoC:IsMissed("SILENCE") and LoC:Get("SCHOOL_INTERRUPT", "HOLY") == 0
end 

local function InMelee(unitID)
	-- @return boolean 
	return A.TemplarsVerdict:IsInRange(unitID)
end 

-- @return boolean  
-- @parameters count, range are mandatory, others parameters optionals
local ActiveUnitPlates = MultiUnits:GetActiveUnitPlates()
local function GetByRange(count, range, isCheckEqual, isCheckCombat)
	local c = 0 
	for unitID in pairs(ActiveUnitPlates) do 
		if (not isCheckEqual or not UnitIsUnit("target", unitID)) and (not isCheckCombat or Unit(unitID):CombatTime() > 0) then 
			if InMelee(unitID) then 
				c = c + 1
			elseif range then 
				local r = Unit(unitID):GetRange()
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

-- [1] CC AntiFake Rotation
local function AntiFakeStun(unit) 
    return 
    A.IsUnitEnemy(unit) and  
    Unit(unit):GetRange() <= 10 and 
    Unit(unit):IsControlAble("stun", 0) and 
    A.HammerofJusticeGreen:AbsentImun(unit, Temp.TotalAndPhysAndCCAndStun, true)          
end 
A[1] = function(icon)    
    if     A.HammerofJusticeGreen:IsReady(nil, nil, nil, true) and 
    (
        AntiFakeStun("mouseover") or 
        AntiFakeStun("target") or 
        (
            not A.IsUnitEnemy("mouseover") and 
            not A.IsUnitEnemy("target") and                     
            (
                (A.IsInPvP and EnemyTeam():PlayersInRange(1, 10)) or 
                (not A.IsInPvP and GetByRange(1, 10))
            )
        )
    )
    then 
        return A.HammerofJusticeGreen:Show(icon)         
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
            if not notKickAble and A.Rebuke:IsReady(unit, nil, nil, true) and A.Rebuke:AbsentImun(unit, Temp.TotalAndMag, true) then
                return A.Rebuke:Show(icon)                                                  
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
    if Unit(player):CombatTime() == 0 then 
        return 
    end 
    
    local unit
    if A.IsUnitEnemy("mouseover") then 
        unit = "mouseover"
    elseif A.IsUnitEnemy("target") then 
        unit = "target"
    end  
	
    -- DivineShield
    local DivineShield = A.GetToggle(2, "DivineShieldHP")
    if     DivineShield >= 0 and A.DivineShield:IsReady(player) and 
    (
        (     -- Auto 
            DivineShield >= 100 and 
            (
                -- HP lose per sec >= 20
                Unit(player):GetDMG() * 100 / Unit(player):HealthMax() >= 20 or 
                Unit(player):GetRealTimeDMG() >= Unit(player):HealthMax() * 0.20 or 
                -- TTD 
                Unit(player):TimeToDieX(25) < 5 or 
                (
                    A.IsInPvP and 
                    (
                        Unit(player):UseDeff() or 
                        (
                            Unit(player, 5):HasFlags() and 
                            Unit(player):GetRealTimeDMG() > 0 and 
                            Unit(player):IsFocused() 
                        )
                    )
                )
            ) and 
            Unit(player):HasBuffs("DeffBuffs", true) == 0
        ) or 
        (    -- Custom
            DivineShield < 100 and 
            Unit(player):HealthPercent() <= DivineShield
        )
    ) 
    then 
	    -- Notification					
        Action.SendNotification("[DEF] Divine Shield", A.DivineShield.ID)
        return A.DivineShield
    end
	
    -- Stoneform on self dispel (only PvE)
    if A.Stoneform:IsRacialReady(player, true) and not A.IsInPvP and A.AuraIsValid(player, "UseDispel", "Dispel") then 
        return A.Stoneform
    end 
end 
SelfDefensives = A.MakeFunctionCachedStatic(SelfDefensives)

-- TO USE AFTER NEXT ACTION UPDATE
local function InterruptsNEW(unit)
    local useKick, useCC, useRacial, notInterruptable, castRemainsTime, castDoneTime = Action.InterruptIsValid(unit, nil, nil, not A.Rebuke:IsReady(unit)) -- A.Kick non GCD spell
    
	if castDoneTime > 0 then
        if useKick and A.Rebuke:IsReady(unit) and A.Rebuke:AbsentImun(unit, Temp.TotalAndMagKick, true) then 
	        -- Notification					
            Action.SendNotification("Rebuke interrupting on Target ", A.Rebuke.ID)
            return A.Rebuke
        end 
    
        if useCC and A.HammerofJustice:IsReady(unit) and A.HammerofJustice:AbsentImun(unit, Temp.TotalAndCC, true) and Unit(unit):IsControlAble("stun", 0) then 
	        -- Notification					
            Action.SendNotification("HammerofJustice interrupting...", A.HammerofJustice.ID)
            return A.HammerofJustice              
        end    
	
   	    -- Asphyxiate
   	    if useCC and A.Asphyxiate:IsSpellLearned() and A.Asphyxiate:IsReady(unit) then 
   	        return A.Asphyxiate
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
end

local function Interrupts(unit)
    local useKick, useCC, useRacial = A.InterruptIsValid(unit, "TargetMouseover")    
    
    if useKick and A.Rebuke:IsReady(unit) and A.Rebuke:AbsentImun(unit, Temp.TotalAndMagKick, true) and Unit(unit):CanInterrupt(true, nil, 25, 70) then 
	    -- Notification					
        Action.SendNotification("Rebuke interrupting on Target ", A.Rebuke.ID)
        return A.Rebuke
    end 
    
    if useCC and A.HammerofJustice:IsReady(unit) and A.HammerofJustice:AbsentImun(unit, Temp.TotalAndCC, true) and Unit(unit):IsControlAble("stun", 0) then 
	    -- Notification					
        Action.SendNotification("HammerofJustice interrupting...", A.HammerofJustice.ID)
        return A.HammerofJustice              
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

--Finishers
local function Finishers(unit)
    -- inquisition,if=buff.avenging_wrath.down&(buff.inquisition.down|buff.inquisition.remains<8&holy_power>=3|talent.execution_sentence.enabled&cooldown.execution_sentence.remains<10&buff.inquisition.remains<15|cooldown.avenging_wrath.remains<15&buff.inquisition.remains<20&holy_power>=3)
    if A.Inquisition:IsReadyByPassCastGCD(unit) and 
	(
	    Unit(player):HasBuffs(A.AvengingWrathBuff.ID, true) == 0 and 
		(
		    Unit(player):HasBuffs(A.InquisitionBuff.ID, true) == 0 
			or 
			Unit(player):HasBuffs(A.InquisitionBuff.ID, true) < 8 and Player:HolyPower() >= 3 
			or 
			A.ExecutionSentence:IsSpellLearned() and A.ExecutionSentence:GetCooldown() < 10 and Unit(player):HasBuffs(A.InquisitionBuff.ID, true) < 15 
			or 
			A.AvengingWrath:GetCooldown() < 15 and Unit(player):HasBuffs(A.InquisitionBuff.ID, true) < 20 and Player:HolyPower() >= 3
		)
	)
	then
        return A.Inquisition
    end
			
    -- execution_sentence,if=spell_targets.divine_storm<=2&(!talent.crusade.enabled&cooldown.avenging_wrath.remains>10|talent.crusade.enabled&buff.crusade.down&cooldown.crusade.remains>10|buff.crusade.stack>=7)
    if A.ExecutionSentence:IsReadyByPassCastGCD(unit) and 
	(
	    MultiUnits:GetByRange(8) <= 2 and 
		(
		    not A.Crusade:IsSpellLearned() and A.AvengingWrath:GetCooldown() > 10 
			or 
			A.Crusade:IsSpellLearned() and Unit(player):HasBuffs(A.CrusadeBuff.ID, true) == 0 and A.Crusade:GetCooldown() > 10 
			or 
			Unit(player):HasBuffsStacks(A.CrusadeBuff.ID, true) >= 7
		)
	)
	then
        return A.ExecutionSentence
    end
			
			-- divine_storm,if=spell_targets.divine_storm>2
          --  if A.DivineStorm:IsReady(player) and Action.GetToggle(2, "AoE") and GetByRange(2, 10)
		--	then
         --       return A.DivineStorm
        --   end	

    -- divine_storm,fallback
    if A.DivineStorm:IsReadyByPassCastGCD(player) and Action.GetToggle(2, "AoE") and GetByRange(2, 8) 
	then
        return A.DivineStorm
    end
			
    -- divine_storm,if=variable.ds_castable&variable.wings_pool&((!talent.execution_sentence.enabled|(spell_targets.divine_storm>=2|cooldown.execution_sentence.remains>gcd*2))|(cooldown.avenging_wrath.remains>gcd*3&cooldown.avenging_wrath.remains<10|cooldown.crusade.remains>gcd*3&cooldown.crusade.remains<10|buff.crusade.up&buff.crusade.stack<10))
    if A.DivineStorm:IsReadyByPassCastGCD(player) and Action.GetToggle(2, "AoE") and 
	(
	    VarDsCastable and 
		(
		    VarWingsPool
		)
		and  
		(
		    (not A.ExecutionSentence:IsSpellLearned() or (GetByRange(2, 8) or A.ExecutionSentence:GetCooldown() > A.GetGCD() * 2)) 
			or 
			(A.AvengingWrath:GetCooldown() > A.GetGCD() * 3 and A.AvengingWrath:GetCooldown() < 10 or A.Crusade:GetCooldown() > A.GetGCD() * 3 and A.Crusade:GetCooldown() < 10 or Unit(player):HasBuffs(A.CrusadeBuff.ID, true) > 0 and Unit(player):HasBuffsStacks(A.CrusadeBuff.ID, true) < 10)
		)
	)
	then
        return A.DivineStorm
    end
			
    -- templars_verdict,if=variable.wings_pool&(!talent.execution_sentence.enabled|cooldown.execution_sentence.remains>gcd*2|cooldown.avenging_wrath.remains>gcd*3&cooldown.avenging_wrath.remains<10|cooldown.crusade.remains>gcd*3&cooldown.crusade.remains<10|buff.crusade.up&buff.crusade.stack<10)
    if A.TemplarsVerdict:IsReadyByPassCastGCD(unit) and 
	(
	    (
		    VarWingsPool 
		) 
		and 
		(
		    not A.ExecutionSentence:IsSpellLearned() 
			or 
			A.ExecutionSentence:GetCooldown() > A.GetGCD() * 2 
			or 
			A.AvengingWrath:GetCooldown() > A.GetGCD() * 3 and A.AvengingWrath:GetCooldown() < 10 
			or 
			A.Crusade:GetCooldown() > A.GetGCD() * 3 and A.Crusade:GetCooldown() < 10 
			or 
			Unit(player):HasBuffs(A.CrusadeBuff.ID, true) > 0 and Unit(player):HasBuffsStacks(A.CrusadeBuff.ID, true) < 10
		)
	) 
	then
        return A.TemplarsVerdict
    end	

end
Finishers = A.MakeFunctionCachedDynamic(Finishers)

--- ======= ACTION LISTS =======
-- [3] Single Rotation
A[3] = function(icon, isMulti)
    --------------------
    --- ROTATION VAR ---
    --------------------
    local isMoving = A.Player:IsMoving()
	local isMovingFor = A.Player:IsMovingTime()
    local inCombat = Unit(player):CombatTime() > 0
	local PlayerCombatTime = Unit(player):CombatTime()
	local TargetCombatTime = Unit("target"):CombatTime()
    local ShouldStop = Action.ShouldStop()
	local CanCast = true
    local Pull = Action.BossMods_Pulling()
    local FlashofLightHP = GetToggle(2, "FlashofLightHP")
	local WordofGloryHP = GetToggle(2, "WordofGloryHP")
	local JusticarsVengeanceHP = GetToggle(2, "JusticarsVengeanceHP")
	local DivineShieldHP = GetToggle(2, "DivineShieldHP")
	local UseCavalier = GetToggle(2, "UseCavalier")
	local CavalierTime = GetToggle(2, "CavalierTime")
	
	
	local Potion = GetToggle(1, "Potion")
	local Racial = GetToggle(1, "Racial")
	local HeartOfAzeroth = GetToggle(1, "HeartOfAzeroth")
	local TrinketsAoE = Action.GetToggle(2, "TrinketsAoE")
	local TrinketsMinTTD = Action.GetToggle(2, "TrinketsMinTTD")
	local TrinketsUnitsRange = Action.GetToggle(2, "TrinketsUnitsRange")
	local TrinketsMinUnits = Action.GetToggle(2, "TrinketsMinUnits")	
	local BlessingofProtectionHP = Action.GetToggle(2, "BlessingofProtectionHP")
	local BlessingofProtectionTTD = Action.GetToggle(2, "BlessingofProtectionTTD")
	local UnbridledFuryAuto = A.GetToggle(2, "UnbridledFuryAuto")
	local UnbridledFuryTTD = A.GetToggle(2, "UnbridledFuryTTD")
	local UnbridledFuryWithExecute = A.GetToggle(2, "UnbridledFuryWithExecute")
	local UnbridledFuryWithBloodlust = A.GetToggle(2, "UnbridledFuryWithBloodlust")
	local UnbridledFuryHP = A.GetToggle(2, "UnbridledFuryHP")	
	local AllowDelayedAW = A.GetToggle(2, "AllowDelayedAW")	
	
	-- FocusedAzeriteBeam protection channel
	local secondsLeft, percentLeft, spellID, spellName, notInterruptable, isChannel = Unit(player):IsCastingRemains()
		-- @return:
		-- [1] Currect Casting Left Time (seconds) (@number)
		-- [2] Current Casting Left Time (percent) (@number)
		-- [3] spellID (@number)
		-- [4] spellName (@string)
		-- [5] notInterruptable (@boolean, false is able to be interrupted)
		-- [6] isChannel (@boolean)
	if percentLeft > 0.01 and spellName == A.FocusedAzeriteBeam:Info() then 
	    CanCast = false
	else
	    CanCast = true
	end	
	
	if not CanCast then
	    return A.PoolResource:Show(icon)
	end	
    ------------------------------------------------------
    ---------------- ENEMY UNIT ROTATION -----------------
    ------------------------------------------------------
    local function EnemyRotation(unit)
	
        -- variable,name=wings_pool,value=!equipped.169314&(!talent.crusade.enabled&cooldown.avenging_wrath.remains>gcd*3|cooldown.crusade.remains>gcd*3)|equipped.169314&(!talent.crusade.enabled&cooldown.avenging_wrath.remains>gcd*6|cooldown.crusade.remains>gcd*6)
        VarWingsPool = (   
	                        not A.AzsharasFontofPower:IsExists() and 
	                        (
						        not A.Crusade:IsSpellLearned() and A.AvengingWrath:GetCooldown() > A.GetGCD() * 3 
							    or 
							    A.Crusade:GetCooldown() > A.GetGCD() * 3
						    )
						    or A.AzsharasFontofPower:IsExists() and 
						    (
						        not A.Crusade:IsSpellLearned() and A.AvengingWrath:GetCooldown() > A.GetGCD() * 6 
							    or 
							    A.Crusade:GetCooldown() > A.GetGCD() * 6
						    )
					    )
  	
		
        -- variable,name=ds_castable,value=spell_targets.divine_storm>=2&!talent.righteous_verdict.enabled|spell_targets.divine_storm>=3&talent.righteous_verdict.enabled|buff.empyrean_power.up&debuff.judgment.down&buff.divine_purpose.down&buff.avenging_wrath_autocrit.down
        VarDsCastable = (GetByRange(2, 8) and not A.RighteousVerdict:IsSpellLearned() or GetByRange(3, 8) and A.RighteousVerdict:IsSpellLearned() or Unit(player):HasBuffs(A.EmpyreanPowerBuff.ID, true) > 0 and Unit(unit):HasDeBuffs(A.JudgmentDebuff.ID, true) == 0 and Unit(player):HasBuffs(A.DivinePurposeBuff.ID, true) == 0 and Unit(player):HasBuffs(A.AvengingWrathAutocritBuff.ID, true) == 0)
        -- variable,name=HoW,value=(!talent.hammer_of_wrath.enabled|target.health.pct>=20&!(buff.avenging_wrath.up|buff.crusade.up))
        VarHow = (not A.HammerofWrath:IsSpellLearned() or Unit(unit):HealthPercent() >= 20 and (Unit(player):HasBuffs(A.AvengingWrathBuff.ID, true) == 0 or Unit(player):HasBuffs(A.CrusadeBuff.ID, true) == 0))
			
		-- Interrupt Handler 	 	
  		--local unit = "target"
   		local useKick, useCC, useRacial = Action.InterruptIsValid(unit, "TargetMouseover")          
      	local Trinket1IsAllowed, Trinket2IsAllowed = TR.TrinketIsAllowed()
		
        --Precombat and not profileStop
        if combatTime == 0 and Unit(unit):IsExists() and unit ~= "mouseover" then
            -- flask
            -- food
            -- augmentation
            -- snapshot_stats
            -- potion
            if A.PotionofUnbridledFury:IsReady(unit) and Potion then
                return A.PotionofUnbridledFury:Show(icon)
            end
			
            -- use_item,name=azsharas_font_of_power
            if A.AzsharasFontofPower:IsReady(player) then
                return A.AzsharasFontofPower:Show(icon)
            end
			
            -- arcane_torrent,if=!talent.wake_of_ashes.enabled
            if A.ArcaneTorrent:IsRacialReady(unit) and Racial and A.BurstIsON(unit) and (not A.WakeofAshes:IsSpellLearned()) then
                return A.ArcaneTorrent:Show(icon)
            end

            -- judgment,if=holy_power<=2|(holy_power<=4&(cooldown.blade_of_justice.remains>gcd*2|variable.HoW))
            if A.Judgment:IsReady(unit) then
                return A.Judgment:Show(icon)
            end
			
        end
		
		-- Rebuke
  	  	if useKick and A.Rebuke:IsReady(unit) then 
		 	if Unit(unit):CanInterrupt(true, nil, 25, 70) then
         	    return A.Rebuke:Show(icon)
        	end 
      	end 
			
     	-- Hammer of Justice
      	if useCC and A.HammerofJustice:IsReady(unit) then 
	  		if Unit(unit):CanInterrupt(true, nil, 25, 70) then
     	        return A.HammerofJustice:Show(icon)
     	    end 
     	end 

	    -- Cavalier if out of range 
        if A.Cavalier:IsReady(player) and isMovingFor > CavalierTime and UseCavalier then
           return A.Cavalier:Show(icon)
        end	
			
		-- Flash of Light
       	if A.FlashofLight:IsReady(player) and Unit(player):HasBuffsStacks(A.SelfLessHealerBuff.ID, true) == 4 and 
		Unit(player):HealthPercent() <= FlashofLightHP and Unit(player):IsStayingTime() >= 0.5 
		then
     	    return A.FlashofLight:Show(icon)
   		end

        -- Justicars Vengeance
        if A.JusticarsVengeance:IsReady(unit) and inCombat and Unit(unit):GetRange() <= 5 then
  		    -- Regular
  		    if Unit(player):HealthPercent() <= JusticarsVengeanceHP and Unit(player):HasBuffs(A.DivinePurposeBuff.ID, true) == 0 and Player:HolyPower() >= 5 then
   		        return A.JusticarsVengeance:Show(icon)
 		    end
  		    -- Divine Purpose
  		    if Unit(player):HealthPercent() <= JusticarsVengeanceHP - 5 and Unit(player):HasBuffs(A.DivinePurposeBuff) > 0 then
   		        return A.JusticarsVengeance:Show(icon)
   		    end
   		end
            
		-- Word of Glory
   		if A.WordofGlory:IsReady(player) and inCombat then
  		    -- Regular
    	    if Unit(player):HealthPercent() <= WordofGloryHP and Unit(player):HasBuffs(A.DivinePurposeBuff.ID, true) == 0 and Player:HolyPower() >= 3 then
   		        return A.WordofGlory:Show(icon)
   		    end
    	    -- Divine Purpose
    	    if Unit(player):HealthPercent() <= WordofGloryHP - 5 and Unit(player):HasBuffs(A.DivinePurposeBuff.ID, true) > 0 then
                return A.WordofGlory:Show(icon)
    	    end
  		end
			
	   	-- Non SIMC Custom Trinket1
	    if A.Trinket1:IsReady(unit) and inCombat and Trinket1IsAllowed and CanCast and Unit(unit):GetRange() < 6 and    
		(
    		TrinketsAoE and GetByRange(TrinketsMinUnits, TrinketsUnitsRange) and Player:AreaTTD(TrinketsUnitsRange) > TrinketsMinTTD
			or
			not TrinketAoE and Unit(unit):TimeToDie() >= TrinketsMinTTD 					
		)
		then 
      	    return A.Trinket1:Show(icon)
   	    end 		
	        
		
		-- Non SIMC Custom Trinket2
	    if A.Trinket2:IsReady(unit) and inCombat and Trinket2IsAllowed and CanCast and Unit(unit):GetRange() < 6 and	    
		(
    		TrinketsAoE and GetByRange(TrinketsMinUnits, TrinketsUnitsRange) and Player:AreaTTD(TrinketsUnitsRange) > TrinketsMinTTD
			or
			not TrinketAoE and Unit(unit):TimeToDie() >= TrinketsMinTTD 					
		)
		then
      	   	return A.Trinket2:Show(icon) 	
	    end
 
        -- BURST
        if A.BurstIsON(unit) and inCombat and unit ~= "mouseover" then
			
			-- custom potion from UI
			local PotionSelection = A.GetToggle(2, "PotionSelection")
			-- unbridled fury
			if PotionSelection == "UNBRIDLEDFURY" and Action.GetToggle(1, "Potion") and A.PotionofUnbridledFury:IsReady(unit) then
			    return A.PotionofUnbridledFury:Show(icon)
			end
			-- PotionofFocusedResolve
			if PotionSelection == "FOCUSEDRESOLVE" and Action.GetToggle(1, "Potion") and A.PotionofFocusedResolve:IsReady(unit) then
			    return A.PotionofFocusedResolve:Show(icon)
			end
			-- SuperiorBattlePotionofStrength
			if PotionSelection == "BATTLEPOTIONOFSTRENGTH" and Action.GetToggle(1, "Potion") and A.SuperiorBattlePotionofStrength:IsReady(unit) then
			    return A.SuperiorBattlePotionofStrength:Show(icon)
			end
			-- PotionofEmpoweredProximity
			if PotionSelection == "EMPOWEREDPROXIMITY" and Action.GetToggle(1, "Potion") and A.PotionofEmpoweredProximity:IsReady(unit) then
			    return A.PotionofEmpoweredProximity:Show(icon)
			end			
            -- potion,if=buff.metamorphosis.remains>25|target.time_to_die<60
            if A.PotionofUnbridledFury:IsReady(unit) and CanCast and Action.GetToggle(1, "Potion") and UnbridledFuryAuto
			and 
			(
			    (Unit(player):HasBuffs(A.AvengingWrathBuff.ID, true) > 0 )
				or
				(UnbridledFuryWithBloodlust and Unit("player"):HasHeroism())
				or
				(UnbridledFuryWithExecute and Unit(unit):HealthPercent() <= 30)
			)
			and Unit(unit):TimeToDie() > UnbridledFuryTTD
			then
 	            -- Notification					
                Action.SendNotification("Burst: Potion of Unbridled Fury", A.PotionofUnbridledFury.ID)	
                return A.PotionofUnbridledFury:Show(icon)
            end
			
            -- lights_judgment,if=spell_targets.lights_judgment>=2|(!raid_event.adds.exists|raid_event.adds.in>75)
            if A.LightsJudgment:IsReady(unit) and A.BurstIsON(unit) and GetByRange(2, 5) then
                return A.LightsJudgment:Show(icon)
            end
			
            -- fireblood,if=buff.avenging_wrath.up|buff.crusade.up&buff.crusade.stack=10
            if A.Fireblood:AutoRacial(unit) and Racial and A.BurstIsON(unit) and 
			(
			    Unit(player):HasBuffs(A.AvengingWrathBuff.ID, true) > 0 
				or 
				Unit(player):HasBuffs(A.CrusadeBuff.ID, true) > 0 and Unit(player):HasBuffsStacks(A.CrusadeBuff.ID, true) == 10
			)
			then
                return A.Fireblood:Show(icon)
            end
			
            -- shield_of_vengeance,if=buff.seething_rage.down&buff.memory_of_lucid_dreams.down
            if A.ShieldofVengeance:IsReady(unit) and (Unit(player):HasBuffs(A.SeethingRageBuff.ID, true) == 0 and Unit(player):HasBuffs(A.MemoryofLucidDreams.ID, true) == 0) then
                return A.ShieldofVengeance:Show(icon)
            end
			
            -- use_item,name=ashvanes_razor_coral,if=debuff.razor_coral_debuff.down|(buff.avenging_wrath.remains>=20|buff.crusade.stack=10&buff.crusade.remains>15)&(cooldown.guardian_of_azeroth.remains>90|target.time_to_die<30|!essence.condensed_lifeforce.major)
            if A.AshvanesRazorCoral:IsReady(unit) and 
			(
			    Unit(unit):HasDeBuffsDown(A.RazorCoralDebuff.ID, true) 
				or 
				(
				    Unit(player):HasBuffs(A.AvengingWrathBuff.ID, true) >= 20 
					or 
					Unit(player):HasBuffsStacks(A.CrusadeBuff.ID, true) == 10 and Unit(player):HasBuffs(A.CrusadeBuff.ID, true) > 15
				) 
				and 
				(
				    A.GuardianofAzeroth:GetCooldown() > 90 
					or 
					Unit(unit):TimeToDie() < 30 
					or 
					not Azerite:EssenceHasMajor(A.GuardianofAzeroth.ID)
				)
			)
			then
                return A.AshvanesRazorCoral:Show(icon)
            end
			
            -- the_unbound_force,if=time<=2|buff.reckless_force.up
            if A.TheUnboundForce:AutoHeartOfAzeroth(unit, true) and HeartOfAzeroth and (Unit(player):CombatTime() <= 2 or Unit(player):HasBuffs(A.RecklessForceBuff.ID, true) > 0) then
                return A.TheUnboundForce:Show(icon)
            end
			
            -- blood_of_the_enemy,if=buff.avenging_wrath.up|buff.crusade.up&buff.crusade.stack=10
            if A.BloodoftheEnemy:AutoHeartOfAzeroth(unit, true) and HeartOfAzeroth and (Unit(player):HasBuffs(A.AvengingWrathBuff.ID, true) > 0 or Unit(player):HasBuffs(A.CrusadeBuff.ID, true) > 0 and Unit(player):HasBuffsStacks(A.CrusadeBuff.ID, true) == 10) then
                return A.BloodoftheEnemy:Show(icon)
            end
			
            -- guardian_of_azeroth,if=!talent.crusade.enabled&(cooldown.avenging_wrath.remains<5&holy_power>=3&(buff.inquisition.up|!talent.inquisition.enabled)|cooldown.avenging_wrath.remains>=45)|(talent.crusade.enabled&cooldown.crusade.remains<gcd&holy_power>=4|holy_power>=3&time<10&talent.wake_of_ashes.enabled|cooldown.crusade.remains>=45)
            if A.GuardianofAzeroth:AutoHeartOfAzeroth(unit, true) and HeartOfAzeroth and (not A.Crusade:IsSpellLearned() and (A.AvengingWrath:GetCooldown() < 5 and Player:HolyPower() >= 3 and (Unit(player):HasBuffs(A.InquisitionBuff.ID, true) > 0 or not A.Inquisition:IsSpellLearned()) or A.AvengingWrath:GetCooldown() >= 45) or (A.Crusade:IsSpellLearned() and A.Crusade:GetCooldown() < A.GetGCD() and Player:HolyPower() >= 4 or Player:HolyPower() >= 3 and Unit(player):CombatTime() < 10 and A.WakeofAshes:IsSpellLearned() or A.Crusade:GetCooldown() >= 45)) then
                return A.GuardianofAzeroth:Show(icon)
            end
			
            -- worldvein_resonance,if=cooldown.avenging_wrath.remains<gcd&holy_power>=3|talent.crusade.enabled&cooldown.crusade.remains<gcd&holy_power>=4|cooldown.avenging_wrath.remains>=45|cooldown.crusade.remains>=45
            if A.WorldveinResonance:AutoHeartOfAzeroth(unit, true) and HeartOfAzeroth and (A.AvengingWrath:GetCooldown() < A.GetGCD() and Player:HolyPower() >= 3 or A.Crusade:IsSpellLearned() and A.Crusade:GetCooldown() < A.GetGCD() and Player:HolyPower() >= 4 or A.AvengingWrath:GetCooldown() >= 45 or A.Crusade:GetCooldown() >= 45) then
                return A.WorldveinResonance:Show(icon)
            end
			
            -- focused_azerite_beam,if=spell_targets.blade_dance1>=2|raid_event.adds.in>60
            if A.FocusedAzeriteBeam:AutoHeartOfAzeroth(unit, true) and CanCast and BurstIsON(unit) and UseHeartOfAzeroth 
	        and (GetByRange(FocusedAzeriteBeamUnits, 20) or Unit(unit):IsBoss()) and Unit(unit):TimeToDie() >= FocusedAzeriteBeamTTD
		    then
 	            -- Notification					
                Action.SendNotification("Stop moving!! Focused Azerite Beam", A.FocusedAzeriteBeam.ID)                 
			    return A.FocusedAzeriteBeam:Show(icon)
            end
			
            -- memory_of_lucid_dreams,if=(buff.avenging_wrath.up|buff.crusade.up&buff.crusade.stack=10)&holy_power<=3
            if A.MemoryofLucidDreams:AutoHeartOfAzeroth(unit, true) and HeartOfAzeroth and ((Unit(player):HasBuffs(A.AvengingWrathBuff.ID, true) > 0 or Unit(player):HasBuffs(A.CrusadeBuff.ID, true) > 0 and Unit(player):HasBuffsStacks(A.CrusadeBuff.ID, true) == 10) and Player:HolyPower() <= 3) then
                return A.MemoryofLucidDreams:Show(icon)
            end
			
            -- purifying_blast,if=(!raid_event.adds.exists|raid_event.adds.in>30|spell_targets.divine_storm>=2)
            if A.PurifyingBlast:AutoHeartOfAzeroth(unit, true) and HeartOfAzeroth and GetByRange(2, 8) then
                return A.PurifyingBlast:Show(icon)
            end
			
            -- use_item,effect_name=cyclotronic_blast,if=!(buff.avenging_wrath.up|buff.crusade.up)&(cooldown.blade_of_justice.remains>gcd*3&cooldown.judgment.remains>gcd*3)
            if A.CyclotronicBlast:IsReady(unit) and (not (Unit(player):HasBuffs(A.AvengingWrathBuff.ID, true) > 0 or Unit(player):HasBuffs(A.CrusadeBuff.ID, true) > 0) and (A.BladeofJustice:GetCooldown() > A.GetGCD() * 3 and A.Judgment:GetCooldown() > A.GetGCD() * 3)) then
                return A.CyclotronicBlast:Show(icon)
            end
			
            -- avenging_wrath,if=(!talent.inquisition.enabled|buff.inquisition.up)&holy_power>=3
            if A.AvengingWrath:IsReady(unit) and A.BurstIsON(unit) and 
			(
			    (
				    not A.Inquisition:IsSpellLearned() 
					or
					Unit(player):HasBuffs(A.InquisitionBuff.ID, true) > 0
				)
				and Player:HolyPower() >= 3
			)
			then
                return A.AvengingWrath:Show(icon)
            end
			
            -- crusade,if=holy_power>=4|holy_power>=3&time<10&talent.wake_of_ashes.enabled
            if A.Crusade:IsReady(unit) and A.BurstIsON(unit) and (Player:HolyPower() >= 4 or Player:HolyPower() >= 3 and Unit(player):CombatTime() < 10 and A.WakeofAshes:IsSpellLearned()) then
                return A.Crusade:Show(icon)
            end
        end


        -- GENERATORS
		
        -- templars_verdict fallback, in case the user is saving AW/Crusade/ExecutionSentence
        if A.TemplarsVerdict:IsReadyByPassCastGCD(unit) and inCombat and Player:HolyPower() >= 5 and AllowDelayedAW then
            return A.TemplarsVerdict:Show(icon)
        end
		
        -- call_action_list,name=finishers,if=holy_power>=5|buff.memory_of_lucid_dreams.up|buff.seething_rage.up|talent.inquisition.enabled&buff.inquisition.down&holy_power>=3
        if Finishers(unit) and inCombat and 
		(
		    Player:HolyPower() >= 5 
			or 
			Unit(player):HasBuffs(A.MemoryofLucidDreams.ID, true) > 0 
			or 
			Unit(player):HasBuffs(A.SeethingRageBuff.ID, true) > 0 
			or 
			A.Inquisition:IsSpellLearned() and Unit(player):HasBuffs(A.InquisitionBuff.ID, true) == 0 and Player:HolyPower() >= 3
		)
		then
            return Finishers(unit):Show(icon)
        end
			
        -- wake_of_ashes,if=(!raid_event.adds.exists|raid_event.adds.in>15|spell_targets.wake_of_ashes>=2)&(holy_power<=0|holy_power=1&cooldown.blade_of_justice.remains>gcd)&(cooldown.avenging_wrath.remains>10|talent.crusade.enabled&cooldown.crusade.remains>10)
        if A.WakeofAshes:IsReady(player) and inCombat and 
    	(
			(
			    Player:HolyPower() <= 0 
			    or
			    Player:HolyPower() == 1 and A.BladeofJustice:GetCooldown() > A.GetGCD()
			) 
			and 
			(
			    A.AvengingWrath:GetCooldown() > 10 
				or
				A.Crusade:IsSpellLearned() and A.Crusade:GetCooldown() > 10
			)
		)
		then
            return A.WakeofAshes:Show(icon)
        end
			
        -- blade_of_justice,if=holy_power<=2|(holy_power=3&(cooldown.hammer_of_wrath.remains>gcd*2|variable.HoW))
        if A.BladeofJustice:IsReady(unit) and inCombat and (Player:HolyPower() <= 2 or (Player:HolyPower() == 3 and (A.HammerofWrath:GetCooldown() > A.GetGCD() * 2 or VarHow))) then
            return A.BladeofJustice:Show(icon)
        end
			
        -- judgment,if=holy_power<=2|(holy_power<=4&(cooldown.blade_of_justice.remains>gcd*2|variable.HoW))
        if A.Judgment:IsReady(unit) and inCombat and (Player:HolyPower() <= 2 or (Player:HolyPower() <= 4 and (A.BladeofJustice:GetCooldown() > A.GetGCD() * 2 or VarHow))) then
            return A.Judgment:Show(icon)
        end
			
        -- hammer_of_wrath,if=holy_power<=4
        if A.HammerofWrath:IsReady(unit) and inCombat and (Player:HolyPower() <= 4) then
            return A.HammerofWrath:Show(icon)
        end
			
        -- consecration,if=holy_power<=2|holy_power<=3&cooldown.blade_of_justice.remains>gcd*2|holy_power=4&cooldown.blade_of_justice.remains>gcd*2&cooldown.judgment.remains>gcd*2
        if A.Consecration:IsReady(unit) and inCombat and (Player:HolyPower() <= 2 or Player:HolyPower() <= 3 and A.BladeofJustice:GetCooldown() > A.GetGCD() * 2 or Player:HolyPower() == 4 and A.BladeofJustice:GetCooldown() > A.GetGCD() * 2 and A.Judgment:GetCooldown() > A.GetGCD() * 2) then
            return A.Consecration:Show(icon)
        end
			
        -- call_action_list,name=finishers,if=talent.hammer_of_wrath.enabled&target.health.pct<=20|buff.avenging_wrath.up|buff.crusade.up
        if Finishers(unit) and inCombat and 
		(
		    A.HammerofWrath:IsSpellLearned() and Unit(unit):HealthPercent() <= 20 
			or 
			Unit(player):HasBuffs(A.AvengingWrathBuff.ID, true) > 0 
			or 
			Unit(player):HasBuffs(A.CrusadeBuff.ID, true) > 0
		)
		then
            return Finishers(unit):Show(icon)
        end
			
        -- crusader_strike,if=cooldown.crusader_strike.charges_fractional>=1.75&(holy_power<=2|holy_power<=3&cooldown.blade_of_justice.remains>gcd*2|holy_power=4&cooldown.blade_of_justice.remains>gcd*2&cooldown.judgment.remains>gcd*2&cooldown.consecration.remains>gcd*2)
        if A.CrusaderStrike:IsReady(unit) and inCombat and 
		(
		    A.CrusaderStrike:GetSpellChargesFrac() >= 1.75 and 
			(
			    Player:HolyPower() <= 2 
				or 
				Player:HolyPower() <= 3 and A.BladeofJustice:GetCooldown() > A.GetGCD() * 2 
				or 
				Player:HolyPower() == 4 and A.BladeofJustice:GetCooldown() > A.GetGCD() * 2 and A.Judgment:GetCooldown() > A.GetGCD() * 2 and A.Consecration:GetCooldown() > A.GetGCD() * 2
			)
		)
		then
            return A.CrusaderStrike:Show(icon)
        end
			
        -- call_action_list,name=finishers
        if Finishers(unit) and inCombat then
            return Finishers(unit):Show(icon)
        end
			
        -- concentrated_flame
        if A.ConcentratedFlame:AutoHeartOfAzeroth(unit, true) and inCombat and HeartOfAzeroth then
            return A.ConcentratedFlame:Show(icon)
        end
			
        -- reaping_flames
        if A.ReapingFlames:AutoHeartOfAzerothP(unit, true) and inCombat then
            return A.ReapingFlames:Show(icon)
        end
			
        -- crusader_strike,if=holy_power<=4
        if A.CrusaderStrike:IsReady(unit) and (Player:HolyPower() <= 4) and inCombat then
            return A.CrusaderStrike:Show(icon)
        end
			
        -- arcane_torrent,if=holy_power<=4
        if A.ArcaneTorrent:IsRacialReady(unit) and inCombat and Racial and A.BurstIsON(unit) and Player:HolyPower() <= 4 then
            return A.ArcaneTorrent:Show(icon)
        end
    end

    -- End on EnemyRotation()

    -- Defensive
    local SelfDefensive = SelfDefensives()
    if SelfDefensive then 
        return SelfDefensive:Show(icon)
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
end
-- Finished

-- [4] AoE Rotation
A[4] = function(icon)
    return A[3](icon, true)
end
 -- [5] Trinket Rotation
-- No specialization trinket actions 
-- Passive 
--[[local function FreezingTrapUsedByEnemy()
    if     UnitCooldown:GetCooldown("arena", 3355) > UnitCooldown:GetMaxDuration("arena", 3355) - 2 and
    UnitCooldown:IsSpellInFly("arena", 3355) and 
    Unit(player):GetDR("incapacitate") >= 50 
    then 
        local Caster = UnitCooldown:GetUnitID("arena", 3355)
        if Caster and Unit(Caster):GetRange() <= 40 then 
            return true 
        end 
    end 
end ]]--

local function ArenaRotation(icon, unit)
    if A.IsInPvP and (A.Zone == "pvp" or A.Zone == "arena") and not Player:IsStealthed() and not Player:IsMounted() then
        -- Note: "arena1" is just identification of meta 6
        if unit == "arena1" and (Unit(player):GetDMG() == 0 or not Unit(player):IsFocused("DAMAGER")) then 
            -- Reflect Casting BreakAble CC
            if A.HammerofJustice:IsReady() and A.HammerofJustice:IsSpellLearned() and EnemyTeam():IsCastingBreakAble(0.25) then 
                return A.HammerofJustice:Show(icon)
            end 
        end
    end 
end 

local function PartyRotation(unit)
    if (unit == "party1" and not A.GetToggle(2, "PartyUnits")[1]) or (unit == "party2" and not A.GetToggle(2, "PartyUnits")[2]) then 
        return false 
    end

   	-- Party Dispell
 	if A.CleanseToxins:IsReady(unit) and
	(
    	-- Poison CC 
        Unit(unit):HasDeBuffs("Poison") > 0 
		or
		-- Disease 
        Unit(unit):HasDeBuffs("Disease") > 0		
	)
	then
	    return A.CleanseToxins
	end

  	-- BlessingofFreedom
    if A.BlessingofFreedom:IsReady(unit) and Unit(unit):HasDeBuffs("Rooted") > 1 then
        return A.BlessingofFreedom
    end
	
  	-- BlessingofProtection
    if A.BlessingofProtection:IsReady(unit) and 	 
	(
	   -- HP lose per sec >= 20
        Unit(unit):GetDMG() * 100 / Unit(unit):HealthMax() >= 30 
		or 
        Unit(unit):GetRealTimeDMG() >= Unit(unit):HealthMax() * 0.30 
		or 
        -- TTD 
        Unit(unit):TimeToDieX(10) < 3 
	)
	then
        return A.BlessingofProtection
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
    local Party = PartyRotation("party2") 
    if Party then 
        return Party:Show(icon)
    end     
    return ArenaRotation(icon, "arena3")
end

