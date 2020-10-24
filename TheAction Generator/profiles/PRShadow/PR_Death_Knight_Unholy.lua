-------------------------------
-- Taste TMW Action Rotation --
-------------------------------
local TMW                                       = TMW
local CNDT                                      = TMW.CNDT
local Env                                       = CNDT.Env
local Action                                    = Action
local Listener                                  = Action.Listener
local Create                                    = Create
local GetToggle                                 = Action.GetToggle
local SetToggle                                 = Action.SetToggle
local GetGCD                                    = Action.GetGCD
local GetCurrentGCD                             = Action.GetCurrentGCD
local GetPing                                   = Action.GetPing
local ShouldStop                                = Action.ShouldStop
local BurstIsON                                 = Action.BurstIsON
local AuraIsValid                               = Action.AuraIsValid
local InterruptIsValid                          = Action.InterruptIsValid
local FrameHasSpell                             = Action.FrameHasSpell
local Azerite                                   = LibStub("AzeriteTraits")
local Utils                                     = Action.Utils
local TeamCache                                 = Action.TeamCache
local EnemyTeam                                 = Action.EnemyTeam
local FriendlyTeam                              = Action.FriendlyTeam
local LoC                                       = Action.LossOfControl
local Player                                    = Action.Player
local MultiUnits                                = Action.MultiUnits
local UnitCooldown                              = Action.UnitCooldown
local Unit                                      = Action.Unit
local IsUnitEnemy                               = Action.IsUnitEnemy
local IsUnitFriendly                            = Action.IsUnitFriendly
local HealingEngine                             = Action.HealingEngine
local ActiveUnitPlates                          = MultiUnits:GetActiveUnitPlates()
local TeamCacheFriendly                         = TeamCache.Friendly
local TeamCacheFriendlyIndexToPLAYERs           = TeamCacheFriendly.IndexToPLAYERs
local IsIndoors, UnitIsUnit                     = IsIndoors, UnitIsUnit
local TR                                        = Action.TasteRotation
local Pet                                       = LibStub("PetLibrary")
local next, pairs, type, print                  = next, pairs, type, print
local math_floor                                = math.floor
local math_ceil                                 = math.ceil
local tinsert                                   = table.insert
local select, unpack, table                     = select, unpack, table
local CombatLogGetCurrentEventInfo              = _G.CombatLogGetCurrentEventInfo
local UnitGUID, UnitIsUnit, UnitDamage, UnitAttackSpeed, UnitAttackPower = UnitGUID, UnitIsUnit, UnitDamage, UnitAttackSpeed, UnitAttackPower
local _G, setmetatable, select, math            = _G, setmetatable, select, math
local huge                                      = math.huge
local UIParent                                  = _G.UIParent
local CreateFrame                               = _G.CreateFrame
local wipe                                      = _G.wipe
local IsUsableSpell                             = IsUsableSpell
local UnitPowerType                             = UnitPowerType

--- ============================ CONTENT =========================== ---
--- ======================= SPELLS DECLARATION ===================== ---

Action[ACTION_CONST_DEATHKNIGHT_UNHOLY] = {
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
    -- Generics
    RaiseDead                              = Create({ Type = "Spell", ID = 46584 }),
    ArmyoftheDead                          = Create({ Type = "Spell", ID = 42650 }),
    DeathandDecay                          = Create({ Type = "Spell", ID = 43265 }),
    Apocalypse                             = Create({ Type = "Spell", ID = 275699 }),
    Defile                                 = Create({ Type = "Spell", ID = 152280 }),
    Epidemic                               = Create({ Type = "Spell", ID = 207317 }),
    BurstingSores                          = Create({ Type = "Spell", ID = 207264 }),
    ScourgeStrike                          = Create({ Type = "Spell", ID = 55090 }),
    ClawingShadows                         = Create({ Type = "Spell", ID = 207311 }),
    FesteringStrike                        = Create({ Type = "Spell", ID = 85948 }),
    FesteringWoundDebuff                   = Create({ Type = "Spell", ID = 194310 }),
    DeathCoil                              = Create({ Type = "Spell", ID = 47541 }),
    SuddenDoomBuff                         = Create({ Type = "Spell", ID = 81340 }),
    UnholyAssaultBuff                      = Create({ Type = "Spell", ID =  }),
    VisionofPerfection                     = Create({ Type = "Spell", ID =  }),
    MagusoftheDead                         = Create({ Type = "Spell", ID = 288417 }),
    UnholyAssault                          = Create({ Type = "Spell", ID =  }),
    DarkTransformation                     = Create({ Type = "Spell", ID = 63560 }),
    SummonGargoyle                         = Create({ Type = "Spell", ID = 49206 }),
    SoulReaper                             = Create({ Type = "Spell", ID = 130736 }),
    UnholyBlight                           = Create({ Type = "Spell", ID = 115989 }),
    BloodoftheEnemyBuff                    = Create({ Type = "Spell", ID = 297108 }),
    ArmyoftheDamned                        = Create({ Type = "Spell", ID = 276837 }),
    UnholyStrengthBuff                     = Create({ Type = "Spell", ID = 53365 }),
    ReapingFlames                          = Create({ Type = "Spell", ID =  }),
    ArcaneTorrent                          = Create({ Type = "Spell", ID = 50613 }),
    BloodFury                              = Create({ Type = "Spell", ID = 20572 }),
    Berserking                             = Create({ Type = "Spell", ID = 26297 }),
    LightsJudgment                         = Create({ Type = "Spell", ID = 255647 }),
    FestermightBuff                        = Create({ Type = "Spell", ID =  }),
    AncestralCall                          = Create({ Type = "Spell", ID = 274738 }),
    ArcanePulse                            = Create({ Type = "Spell", ID =  }),
    Fireblood                              = Create({ Type = "Spell", ID = 265221 }),
    BagofTricks                            = Create({ Type = "Spell", ID =  }),
    Outbreak                               = Create({ Type = "Spell", ID = 77575 }),
    VirulentPlagueDebuff                   = Create({ Type = "Spell", ID = 191587 })
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
    PotionofUnbridledFury                  = Create({ Type = "Potion", ID = 169299, QueueForbidden = true }), 
    BattlePotionOfAgility                  = Create({ Type = "Potion", ID = 163223, QueueForbidden = true }), 
    SuperiorBattlePotionOfAgility          = Create({ Type = "Potion", ID = 168489, QueueForbidden = true }), 
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
};

-- To create covenant use next code:
A:CreateCovenantsFor(ACTION_CONST_DEATHKNIGHT_UNHOLY)  -- where PLAYERSPEC is Constance (example: ACTION_CONST_MONK_BM)
local A = setmetatable(Action[ACTION_CONST_DEATHKNIGHT_UNHOLY], { __index = Action })


------------------------------------------
---------------- VARIABLES ---------------
------------------------------------------
local VarPoolingForGargoyle = 0;

A.Listener:Add("ROTATION_VARS", "PLAYER_REGEN_ENABLED", function()
  VarPoolingForGargoyle = 0
end)



local function num(val)
    if val then return 1 else return 0 end
end

local function bool(val)
    return val ~= 0
end

------------------------------------------
--------- UNHOLY PRE APL SETUP -----------
------------------------------------------

-- API - Pet Tracker 
Pet:AddTrackers(ACTION_CONST_DEATHKNIGHT_UNHOLY, { -- this template table is the same with what has this library already built-in, just for example
	[152396] = {
		name = "GuardianofAzeroth",
		duration = 30,
	},
	[26125] = {
		name = "RisenAlly",
		duration = 9999,
	},
	[24207] = {
		name = "ApocGhoul",
		duration = 15,
	},
	[27829] = {
		name = "Gargoyle",
		duration = 30,
	},
})

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
local player = "player"

local function IsSchoolFree()
	return LoC:IsMissed("SILENCE") and LoC:Get("SCHOOL_INTERRUPT", "SHADOW") == 0
end 

local function InMelee(unit)
	-- @return boolean 
	return A.ScourgeStrike:IsInRange(unit)
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

local function GuardianofAzerothIsActive() 
    return Pet:GetRemainDuration(152396) > 0 and true or false
end	

local function DeathStrikeHeal()
    return (GetToggle(2, "SoloMode") and Unit(player):HealthPercent() < GetToggle(2, "UseDeathStrikeHP")) and true or false;
end

local function EvaluateCycleFesteringStrike42(unit)
    return Unit(unit):HasDeBuffsStacks(A.FesteringWoundDebuff.ID, true) <= 1 and A.DeathandDecay:GetCooldown() > 0
end

local function EvaluateCycleSoulReaper167(unit)
    return Unit(unit):TimeToDie() < 8 and Unit(unit):TimeToDie() > 4
end

local function EvaluateCycleOutbreak401(unit)
    return Unit(unit):HasDeBuffs(A.VirulentPlagueDebuff.ID, true) <= A.GetGCD()
end

-- SelfDefensives
local function SelfDefensives(unit)
    local HPLoosePerSecond = Unit(player):GetDMG() * 100 / Unit(player):HealthMax()
		
    if Unit(player):CombatTime() == 0 then 
        return 
    end 

    -- Icebound Fortitude
	
	local IceboundFortitudeAntiStun = GetToggle(2, "IceboundFortitudeAntiStun")
    local IceboundFortitude = GetToggle(2, "IceboundFortitudeHP")
    if     IceboundFortitude >= 0 and A.IceboundFortitude:IsReady(player) and 
    (
        (   -- Auto 
            IceboundFortitude >= 100 and 
            (
                -- HP lose per sec >= 20
                Unit(player):GetDMG() * 100 / Unit(player):HealthMax() >= 30 or 
                Unit(player):GetRealTimeDMG() >= Unit(player):HealthMax() * 0.30 or 
                -- TTD 
                Unit(player):TimeToDieX(25) < 2 or
				-- Player stunned
                LoC:Get("STUN") > 2 and IceboundFortitudeAntiStun or			
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
            IceboundFortitude < 100 and 
            Unit(player):HealthPercent() <= IceboundFortitude
        )
    ) 
    then 
        return A.IceboundFortitude
    end  
	
	    -- HealingPotion
    local AbyssalHealingPotion = GetToggle(2, "AbyssalHealingPotionHP")
    if     AbyssalHealingPotion >= 0 and A.AbyssalHealingPotion:IsReady(player) and 
    (
        (     -- Auto 
            AbyssalHealingPotion >= 100 and 
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
            AbyssalHealingPotion < 100 and 
            Unit(player):HealthPercent() <= AbyssalHealingPotion
        )
    ) 
    then 
        return A.AbyssalHealingPotion
    end 
		
    -- Emergency AntiMagicShell
        local AntiMagicShell = GetToggle(2, "AntiMagicShellHP")
        if     AntiMagicShell >= 0 and A.AntiMagicShell:IsReady(player) and 
        (
            (   -- Auto 
                AntiMagicShell >= 100 and 
                (
                    -- HP lose per sec >= 10
                    Unit(player):GetDMG() * 100 / Unit(player):HealthMax() >= 15 or 
                    Unit(player):GetRealTimeDMG() >= Unit(player):HealthMax() * 0.15 or 
                    -- TTD Magic
                    Unit(player):TimeToDieMagicX(30) < 3 or 
					
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
                AntiMagicShell < 100 and 
                Unit(player):HealthPercent() <= AntiMagicShell
            )
        ) 
        then 
            return A.AntiMagicShell
        end  		

        -- Emergency Death Pact
        local DeathPact = GetToggle(2, "DeathPactHP")
        if     DeathPact >= 0 and A.DeathPact:IsReady(player) and A.DeathPact:IsSpellLearned() and 
        (
            (   -- Auto 
                DeathPact >= 100 and 
                (
                    -- HP lose per sec >= 30
                    Unit(player):GetDMG() * 100 / Unit(player):HealthMax() >= 30 or 
                    Unit(player):GetRealTimeDMG() >= Unit(player):HealthMax() * 0.30 or 
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
                DeathPact < 100 and 
                Unit(player):HealthPercent() <= DeathPact
            )
        ) 
        then 
            return A.DeathPact
        end  		

end 
SelfDefensives = A.MakeFunctionCachedDynamic(SelfDefensives)

-- Non GCD spell check
local function countInterruptGCD(unit)
    if not A.MindFreeze:IsReadyByPassCastGCD(unit) or not A.MindFreeze:AbsentImun(unit, Temp.TotalAndMagKick) then
	    return true
	end
end

-- Interrupts spells
local function Interrupts(unit)
    if A.GetToggle(2, "TasteInterruptList") and (IsInRaid() or A.InstanceInfo.KeyStone > 1) then
	    useKick, useCC, useRacial, notInterruptable, castRemainsTime, castDoneTime = Action.InterruptIsValid(unit, "TasteBFAContent", true, countInterruptGCD(unit))
	else
        useKick, useCC, useRacial, notInterruptable, castRemainsTime, castDoneTime = Action.InterruptIsValid(unit, nil, nil, countInterruptGCD(unit))
    end
    
	if castRemainsTime >= A.GetLatency() then
        -- MindFreeze
        if useKick and not notInterruptable and A.MindFreeze:IsReady(unit) then 
            return A.MindFreeze
        end
	
        -- DeathGrip
        if useCC and A.DeathGrip:IsReady(unit) and DeathGripInterrupt then 
            return A.DeathGrip
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

local function EvaluateCycleFesteringStrike48(unit)
    return Unit(unit):HasDeBuffsStacks(A.FesteringWoundDebuff.ID, true) <= 2 and A.DeathandDecay:GetCooldown() and A.Apocalypse:GetCooldown() > 5 and (A.ArmyoftheDead:GetCooldown() > 5 or death_knight.disable_aotd)
end

local function EvaluateCycleScourgeStrike81(unit)
    return ((A.ArmyoftheDead:GetCooldown() > 5 or death_knight.disable_aotd) and (A.Apocalypse:GetCooldown() > 5 and Unit(unit):HasDeBuffsStacks(A.FesteringWoundDebuff.ID, true) > 0 or Unit(unit):HasDeBuffsStacks(A.FesteringWoundDebuff.ID, true) > 4) and (target.1.time_to_die < A.DeathandDecay:GetCooldown() + 10 or target.1.time_to_die > A.Apocalypse:GetCooldown()))
end

local function EvaluateCycleClawingShadows100(unit)
    return ((A.ArmyoftheDead:GetCooldown() > 5 or death_knight.disable_aotd) and (A.Apocalypse:GetCooldown() > 5 and Unit(unit):HasDeBuffsStacks(A.FesteringWoundDebuff.ID, true) > 0 or Unit(unit):HasDeBuffsStacks(A.FesteringWoundDebuff.ID, true) > 4) and (target.1.time_to_die < A.DeathandDecay:GetCooldown() + 10 or target.1.time_to_die > A.Apocalypse:GetCooldown()))
end

local function EvaluateCycleSoulReaper201(unit)
    return Unit(unit):TimeToDie() < 8 and Unit(unit):TimeToDie() > 4
end

local function EvaluateCycleOutbreak487(unit)
    return Unit(unit):HasDeBuffs(A.VirulentPlagueDebuff.ID, true) <= GetGCD()
end

--- ======= ACTION LISTS =======
-- [3] Single Rotation
A[3] = function(icon, isMulti)

    --------------------
    --- ROTATION VAR ---
    --------------------
    local isMoving = A.Player:IsMoving()
    local isMovingFor = A.Player:IsMovingTime()
    local inCombat = Unit(player):CombatTime() > 0
    local combatTime = Unit(player):CombatTime()
    local ShouldStop = Action.ShouldStop()
    local Pull = Action.BossMods_Pulling()
    local DBM = Action.GetToggle(1, "DBM")
    local HeartOfAzeroth = Action.GetToggle(1, "HeartOfAzeroth")
    local Racial = Action.GetToggle(1, "Racial")
    local Potion = Action.GetToggle(1, "Potion")

    ------------------------------------------------------
    ---------------- ENEMY UNIT ROTATION -----------------
    ------------------------------------------------------
    local function EnemyRotation(unit)

        --Precombat
        local function Precombat(unit)
        
            -- flask
            -- food
            -- augmentation
            -- snapshot_stats
            -- potion
            if A.PotionofSpectralStrength:IsReady(unit) and Potion then
                return A.PotionofSpectralStrength:Show(icon)
            end
            
            -- raise_dead
            if A.RaiseDead:IsReady(unit) then
                return A.RaiseDead:Show(icon)
            end
            
            -- use_item,name=azsharas_font_of_power
            if A.AzsharasFontofPower:IsReady(unit) then
                return A.AzsharasFontofPower:Show(icon)
            end
            
            -- army_of_the_dead,precombat_time=2
            if A.ArmyoftheDead:IsReady(unit) then
                return A.ArmyoftheDead:Show(icon)
            end
            
        end
        
        --Aoe
        local function Aoe(unit)
        
            -- death_and_decay,if=cooldown.apocalypse.remains
            if A.DeathandDecay:IsReady(unit) and (A.Apocalypse:GetCooldown()) then
                return A.DeathandDecay:Show(icon)
            end
            
            -- defile,if=cooldown.apocalypse.remains
            if A.Defile:IsReady(unit) and (A.Apocalypse:GetCooldown()) then
                return A.Defile:Show(icon)
            end
            
            -- epidemic,if=death_and_decay.ticking&runic_power.deficit<14&!talent.bursting_sores.enabled&!variable.pooling_for_gargoyle
            if A.Epidemic:IsReady(unit) and (death_and_decay.ticking and Player:RunicPowerDeficit() < 14 and not A.BurstingSores:IsSpellLearned() and not VarPoolingForGargoyle) then
                return A.Epidemic:Show(icon)
            end
            
            -- epidemic,if=death_and_decay.ticking&(!death_knight.fwounded_targets&talent.bursting_sores.enabled)&!variable.pooling_for_gargoyle
            if A.Epidemic:IsReady(unit) and (death_and_decay.ticking and (not death_knight.fwounded_targets and A.BurstingSores:IsSpellLearned()) and not VarPoolingForGargoyle) then
                return A.Epidemic:Show(icon)
            end
            
            -- scourge_strike,if=death_and_decay.ticking&cooldown.apocalypse.remains
            if A.ScourgeStrike:IsReady(unit) and (death_and_decay.ticking and A.Apocalypse:GetCooldown()) then
                return A.ScourgeStrike:Show(icon)
            end
            
            -- clawing_shadows,if=death_and_decay.ticking&cooldown.apocalypse.remains
            if A.ClawingShadows:IsReady(unit) and (death_and_decay.ticking and A.Apocalypse:GetCooldown()) then
                return A.ClawingShadows:Show(icon)
            end
            
            -- epidemic,if=!variable.pooling_for_gargoyle
            if A.Epidemic:IsReady(unit) and (not VarPoolingForGargoyle) then
                return A.Epidemic:Show(icon)
            end
            
            -- festering_strike,target_if=debuff.festering_wound.stack<=2&cooldown.death_and_decay.remains&cooldown.apocalypse.remains>5&(cooldown.army_of_the_dead.remains>5|death_knight.disable_aotd)
            if A.FesteringStrike:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.FesteringStrike, 40, "min", EvaluateCycleFesteringStrike48) then
                    return A.FesteringStrike:Show(icon) 
                end
            end
            -- death_coil,if=buff.sudden_doom.react&rune.time_to_4>gcd
            if A.DeathCoil:IsReady(unit) and (Unit("player"):HasBuffsStacks(A.SuddenDoomBuff.ID, true) and Player:RuneTimeToX(4) > GetGCD()) then
                return A.DeathCoil:Show(icon)
            end
            
            -- death_coil,if=buff.sudden_doom.react&!variable.pooling_for_gargoyle|pet.gargoyle.active
            if A.DeathCoil:IsReady(unit) and (Unit("player"):HasBuffsStacks(A.SuddenDoomBuff.ID, true) and not VarPoolingForGargoyle or Pet:IsActive(A.Gargoyle.ID)) then
                return A.DeathCoil:Show(icon)
            end
            
            -- death_coil,if=runic_power.deficit<14&(cooldown.apocalypse.remains>5|debuff.festering_wound.stack>4)&!variable.pooling_for_gargoyle
            if A.DeathCoil:IsReady(unit) and (Player:RunicPowerDeficit() < 14 and (A.Apocalypse:GetCooldown() > 5 or Unit(unit):HasDeBuffsStacks(A.FesteringWoundDebuff.ID, true) > 4) and not VarPoolingForGargoyle) then
                return A.DeathCoil:Show(icon)
            end
            
            -- scourge_strike,target_if=((cooldown.army_of_the_dead.remains>5|death_knight.disable_aotd)&(cooldown.apocalypse.remains>5&debuff.festering_wound.stack>0|debuff.festering_wound.stack>4)&(target.1.time_to_die<cooldown.death_and_decay.remains+10|target.1.time_to_die>cooldown.apocalypse.remains))
            if A.ScourgeStrike:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.ScourgeStrike, 40, "min", EvaluateCycleScourgeStrike81) then
                    return A.ScourgeStrike:Show(icon) 
                end
            end
            -- clawing_shadows,target_if=((cooldown.army_of_the_dead.remains>5|death_knight.disable_aotd)&(cooldown.apocalypse.remains>5&debuff.festering_wound.stack>0|debuff.festering_wound.stack>4)&(target.1.time_to_die<cooldown.death_and_decay.remains+10|target.1.time_to_die>cooldown.apocalypse.remains))
            if A.ClawingShadows:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.ClawingShadows, 30, "min", EvaluateCycleClawingShadows100) then
                    return A.ClawingShadows:Show(icon) 
                end
            end
            -- death_coil,if=runic_power.deficit<20&!variable.pooling_for_gargoyle
            if A.DeathCoil:IsReady(unit) and (Player:RunicPowerDeficit() < 20 and not VarPoolingForGargoyle) then
                return A.DeathCoil:Show(icon)
            end
            
            -- festering_strike,if=((((debuff.festering_wound.stack<4&!buff.unholy_assault.up)|debuff.festering_wound.stack<3)&cooldown.apocalypse.remains<3)|debuff.festering_wound.stack<1)&(cooldown.army_of_the_dead.remains>5|death_knight.disable_aotd)
            if A.FesteringStrike:IsReady(unit) and (((((Unit(unit):HasDeBuffsStacks(A.FesteringWoundDebuff.ID, true) < 4 and not Unit("player"):HasBuffs(A.UnholyAssaultBuff.ID, true)) or Unit(unit):HasDeBuffsStacks(A.FesteringWoundDebuff.ID, true) < 3) and A.Apocalypse:GetCooldown() < 3) or Unit(unit):HasDeBuffsStacks(A.FesteringWoundDebuff.ID, true) < 1) and (A.ArmyoftheDead:GetCooldown() > 5 or death_knight.disable_aotd)) then
                return A.FesteringStrike:Show(icon)
            end
            
            -- scourge_strike,if=death_and_decay.ticking
            if A.ScourgeStrike:IsReady(unit) and (death_and_decay.ticking) then
                return A.ScourgeStrike:Show(icon)
            end
            
            -- death_coil,if=!variable.pooling_for_gargoyle
            if A.DeathCoil:IsReady(unit) and (not VarPoolingForGargoyle) then
                return A.DeathCoil:Show(icon)
            end
            
        end
        
        --Cooldowns
        local function Cooldowns(unit)
        
            -- army_of_the_dead
            if A.ArmyoftheDead:IsReady(unit) then
                return A.ArmyoftheDead:Show(icon)
            end
            
            -- apocalypse,if=debuff.festering_wound.stack>=4&(active_enemies>=2|!essence.vision_of_perfection.enabled|!azerite.magus_of_the_dead.enabled|essence.vision_of_perfection.enabled&(talent.unholy_assault.enabled&cooldown.unholy_assault.remains<=3|!talent.unholy_assault.enabled))
            if A.Apocalypse:IsReady(unit) and (Unit(unit):HasDeBuffsStacks(A.FesteringWoundDebuff.ID, true) >= 4 and (MultiUnits:GetByRangeInCombat(40, 5, 10) >= 2 or not A.VisionofPerfection:IsSpellLearned() or not A.MagusoftheDead:GetAzeriteRank() > 0 or A.VisionofPerfection:IsSpellLearned() and (A.UnholyAssault:IsSpellLearned() and A.UnholyAssault:GetCooldown() <= 3 or not A.UnholyAssault:IsSpellLearned()))) then
                return A.Apocalypse:Show(icon)
            end
            
            -- dark_transformation,if=!raid_event.adds.exists|raid_event.adds.in>15
            if A.DarkTransformation:IsReady(unit) and (not (MultiUnits:GetByRangeInCombat(40, 5, 10) > 1) or IncomingAddsIn > 15) then
                return A.DarkTransformation:Show(icon)
            end
            
            -- summon_gargoyle,if=runic_power.deficit<14
            if A.SummonGargoyle:IsReady(unit) and (Player:RunicPowerDeficit() < 14) then
                return A.SummonGargoyle:Show(icon)
            end
            
            -- unholy_assault,if=essence.vision_of_perfection.enabled&pet.apoc_ghoul.active|debuff.festering_wound.stack<4&!essence.vision_of_perfection.enabled&(!azerite.magus_of_the_dead.enabled|azerite.magus_of_the_dead.enabled&pet.apoc_ghoul.active)
            if A.UnholyAssault:IsReady(unit) and (A.VisionofPerfection:IsSpellLearned() and Pet:IsActive(A.ApocGhoul.ID) or Unit(unit):HasDeBuffsStacks(A.FesteringWoundDebuff.ID, true) < 4 and not A.VisionofPerfection:IsSpellLearned() and (not A.MagusoftheDead:GetAzeriteRank() > 0 or A.MagusoftheDead:GetAzeriteRank() > 0 and Pet:IsActive(A.ApocGhoul.ID))) then
                return A.UnholyAssault:Show(icon)
            end
            
            -- unholy_assault,if=active_enemies>=2&((cooldown.death_and_decay.remains<=gcd&!talent.defile.enabled)|(cooldown.defile.remains<=gcd&talent.defile.enabled))
            if A.UnholyAssault:IsReady(unit) and (MultiUnits:GetByRangeInCombat(40, 5, 10) >= 2 and ((A.DeathandDecay:GetCooldown() <= GetGCD() and not A.Defile:IsSpellLearned()) or (A.Defile:GetCooldown() <= GetGCD() and A.Defile:IsSpellLearned()))) then
                return A.UnholyAssault:Show(icon)
            end
            
            -- soul_reaper,target_if=target.time_to_die<8&target.time_to_die>4
            if A.SoulReaper:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.SoulReaper, 40, "min", EvaluateCycleSoulReaper201) then
                    return A.SoulReaper:Show(icon) 
                end
            end
            -- soul_reaper,if=(!raid_event.adds.exists|raid_event.adds.in>20)&rune<=(1-buff.unholy_assault.up)
            if A.SoulReaper:IsReady(unit) and ((not (MultiUnits:GetByRangeInCombat(40, 5, 10) > 1) or IncomingAddsIn > 20) and Player:Rune() <= (1 - num(Unit("player"):HasBuffs(A.UnholyAssaultBuff.ID, true)))) then
                return A.SoulReaper:Show(icon)
            end
            
            -- unholy_blight
            if A.UnholyBlight:IsReady(unit) then
                return A.UnholyBlight:Show(icon)
            end
            
        end
        
        --Essences
        local function Essences(unit)
        
            -- memory_of_lucid_dreams,if=rune.time_to_1>gcd&runic_power<40
            if A.MemoryofLucidDreams:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and (Player:RuneTimeToX(1) > GetGCD() and Player:RunicPower() < 40) then
                return A.MemoryofLucidDreams:Show(icon)
            end
            
            -- blood_of_the_enemy,if=death_and_decay.ticking|pet.apoc_ghoul.active&active_enemies=1
            if A.BloodoftheEnemy:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and (death_and_decay.ticking or Pet:IsActive(A.ApocGhoul.ID) and MultiUnits:GetByRangeInCombat(40, 5, 10) == 1) then
                return A.BloodoftheEnemy:Show(icon)
            end
            
            -- guardian_of_azeroth,if=(cooldown.apocalypse.remains<6&cooldown.army_of_the_dead.remains>cooldown.condensed_lifeforce.remains)|cooldown.army_of_the_dead.remains<2|equipped.ineffable_truth|equipped.ineffable_truth_oh
            if A.GuardianofAzeroth:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and ((A.Apocalypse:GetCooldown() < 6 and A.ArmyoftheDead:GetCooldown() > A.CondensedLifeforce:GetCooldown()) or A.ArmyoftheDead:GetCooldown() < 2 or A.IneffableTruth:IsExists() or A.IneffableTruthOh:IsExists()) then
                return A.GuardianofAzeroth:Show(icon)
            end
            
            -- the_unbound_force,if=buff.reckless_force.up|buff.reckless_force_counter.stack<11
            if A.TheUnboundForce:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and (Unit("player"):HasBuffs(A.RecklessForceBuff.ID, true) or Unit("player"):HasBuffsStacks(A.RecklessForceCounterBuff.ID, true) < 11) then
                return A.TheUnboundForce:Show(icon)
            end
            
            -- focused_azerite_beam,if=!death_and_decay.ticking
            if A.FocusedAzeriteBeam:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and (not death_and_decay.ticking) then
                return A.FocusedAzeriteBeam:Show(icon)
            end
            
            -- concentrated_flame,if=dot.concentrated_flame_burn.remains=0
            if A.ConcentratedFlame:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and (Unit(unit):HasDeBuffs(A.ConcentratedFlameBurnDebuff.ID, true) == 0) then
                return A.ConcentratedFlame:Show(icon)
            end
            
            -- purifying_blast,if=!death_and_decay.ticking
            if A.PurifyingBlast:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and (not death_and_decay.ticking) then
                return A.PurifyingBlast:Show(icon)
            end
            
            -- worldvein_resonance,if=talent.army_of_the_damned.enabled&essence.vision_of_perfection.minor&buff.unholy_strength.up|essence.vision_of_perfection.minor&pet.apoc_ghoul.active|talent.army_of_the_damned.enabled&pet.apoc_ghoul.active&cooldown.army_of_the_dead.remains>60|talent.army_of_the_damned.enabled&pet.army_ghoul.active
            if A.WorldveinResonance:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and (A.ArmyoftheDamned:IsSpellLearned() and Azerite:EssenceHasMinor(A.VisionofPerfection.ID) and Unit("player"):HasBuffs(A.UnholyStrengthBuff.ID, true) or Azerite:EssenceHasMinor(A.VisionofPerfection.ID) and Pet:IsActive(A.ApocGhoul.ID) or A.ArmyoftheDamned:IsSpellLearned() and Pet:IsActive(A.ApocGhoul.ID) and A.ArmyoftheDead:GetCooldown() > 60 or A.ArmyoftheDamned:IsSpellLearned() and pet.army_ghoul.active) then
                return A.WorldveinResonance:Show(icon)
            end
            
            -- worldvein_resonance,if=!death_and_decay.ticking&buff.unholy_strength.up&!essence.vision_of_perfection.minor&!talent.army_of_the_damned.enabled|target.time_to_die<cooldown.apocalypse.remains
            if A.WorldveinResonance:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and (not death_and_decay.ticking and Unit("player"):HasBuffs(A.UnholyStrengthBuff.ID, true) and not Azerite:EssenceHasMinor(A.VisionofPerfection.ID) and not A.ArmyoftheDamned:IsSpellLearned() or Unit(unit):TimeToDie() < A.Apocalypse:GetCooldown()) then
                return A.WorldveinResonance:Show(icon)
            end
            
            -- ripple_in_space,if=!death_and_decay.ticking
            if A.RippleInSpace:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and (not death_and_decay.ticking) then
                return A.RippleInSpace:Show(icon)
            end
            
            -- reaping_flames
            if A.ReapingFlames:IsReady(unit) then
                return A.ReapingFlames:Show(icon)
            end
            
        end
        
        --Generic
        local function Generic(unit)
        
            -- death_coil,if=buff.sudden_doom.react&rune.time_to_4>gcd&!variable.pooling_for_gargoyle|pet.gargoyle.active
            if A.DeathCoil:IsReady(unit) and (Unit("player"):HasBuffsStacks(A.SuddenDoomBuff.ID, true) and Player:RuneTimeToX(4) > GetGCD() and not VarPoolingForGargoyle or Pet:IsActive(A.Gargoyle.ID)) then
                return A.DeathCoil:Show(icon)
            end
            
            -- death_coil,if=runic_power.deficit<14&rune.time_to_4>gcd&!variable.pooling_for_gargoyle
            if A.DeathCoil:IsReady(unit) and (Player:RunicPowerDeficit() < 14 and Player:RuneTimeToX(4) > GetGCD() and not VarPoolingForGargoyle) then
                return A.DeathCoil:Show(icon)
            end
            
            -- scourge_strike,if=debuff.festering_wound.up
            if A.ScourgeStrike:IsReady(unit) and (Unit(unit):HasDeBuffs(A.FesteringWoundDebuff.ID, true)) then
                return A.ScourgeStrike:Show(icon)
            end
            
            -- clawing_shadows,if=debuff.festering_wound.up&(cooldown.apocalypse.remains>5|debuff.festering_wound.stack>4)
            if A.ClawingShadows:IsReady(unit) and (Unit(unit):HasDeBuffs(A.FesteringWoundDebuff.ID, true) and (A.Apocalypse:GetCooldown() > 5 or Unit(unit):HasDeBuffsStacks(A.FesteringWoundDebuff.ID, true) > 4)) then
                return A.ClawingShadows:Show(icon)
            end
            
            -- death_coil,if=runic_power.deficit<20&!variable.pooling_for_gargoyle
            if A.DeathCoil:IsReady(unit) and (Player:RunicPowerDeficit() < 20 and not VarPoolingForGargoyle) then
                return A.DeathCoil:Show(icon)
            end
            
            -- festering_strike,if=debuff.festering_wound.stack<4&cooldown.apocalypse.remains<3|debuff.festering_wound.stack<1
            if A.FesteringStrike:IsReady(unit) and (Unit(unit):HasDeBuffsStacks(A.FesteringWoundDebuff.ID, true) < 4 and A.Apocalypse:GetCooldown() < 3 or Unit(unit):HasDeBuffsStacks(A.FesteringWoundDebuff.ID, true) < 1) then
                return A.FesteringStrike:Show(icon)
            end
            
            -- death_coil,if=!variable.pooling_for_gargoyle
            if A.DeathCoil:IsReady(unit) and (not VarPoolingForGargoyle) then
                return A.DeathCoil:Show(icon)
            end
            
        end
        
        
        -- call precombat
        if Precombat(unit) and not inCombat and Unit(unit):IsExists() and unit ~= "mouseover" then 
            return true
        end

        -- In Combat
        if inCombat and Unit(unit):IsExists() then

                    -- auto_attack
            -- variable,name=pooling_for_gargoyle,value=cooldown.summon_gargoyle.remains<5&talent.summon_gargoyle.enabled
            VarPoolingForGargoyle = num(A.SummonGargoyle:GetCooldown() < 5 and A.SummonGargoyle:IsSpellLearned())
            
            -- arcane_torrent,if=runic_power.deficit>65&(pet.gargoyle.active|!talent.summon_gargoyle.enabled)&rune.deficit>=5
            if A.ArcaneTorrent:AutoRacial(unit) and Racial and A.BurstIsON(unit) and (Player:RunicPowerDeficit() > 65 and (Pet:IsActive(A.Gargoyle.ID) or not A.SummonGargoyle:IsSpellLearned()) and Player:RuneDeficit() >= 5) then
                return A.ArcaneTorrent:Show(icon)
            end
            
            -- blood_fury,if=pet.gargoyle.active|!talent.summon_gargoyle.enabled
            if A.BloodFury:AutoRacial(unit) and Racial and A.BurstIsON(unit) and (Pet:IsActive(A.Gargoyle.ID) or not A.SummonGargoyle:IsSpellLearned()) then
                return A.BloodFury:Show(icon)
            end
            
            -- berserking,if=buff.unholy_assault.up|pet.gargoyle.active|(talent.army_of_the_damned.enabled&pet.apoc_ghoul.active)
            if A.Berserking:AutoRacial(unit) and Racial and A.BurstIsON(unit) and (Unit("player"):HasBuffs(A.UnholyAssaultBuff.ID, true) or Pet:IsActive(A.Gargoyle.ID) or (A.ArmyoftheDamned:IsSpellLearned() and Pet:IsActive(A.ApocGhoul.ID))) then
                return A.Berserking:Show(icon)
            end
            
            -- lights_judgment,if=(buff.unholy_strength.up&buff.festermight.remains<=5)|active_enemies>=2&(buff.unholy_strength.up|buff.festermight.remains<=5)
            if A.LightsJudgment:IsReady(unit) and A.BurstIsON(unit) and ((Unit("player"):HasBuffs(A.UnholyStrengthBuff.ID, true) and Unit("player"):HasBuffs(A.FestermightBuff.ID, true) <= 5) or MultiUnits:GetByRangeInCombat(40, 5, 10) >= 2 and (Unit("player"):HasBuffs(A.UnholyStrengthBuff.ID, true) or Unit("player"):HasBuffs(A.FestermightBuff.ID, true) <= 5)) then
                return A.LightsJudgment:Show(icon)
            end
            
            -- ancestral_call,if=(pet.gargoyle.active&talent.summon_gargoyle.enabled)|pet.apoc_ghoul.active
            if A.AncestralCall:AutoRacial(unit) and Racial and A.BurstIsON(unit) and ((Pet:IsActive(A.Gargoyle.ID) and A.SummonGargoyle:IsSpellLearned()) or Pet:IsActive(A.ApocGhoul.ID)) then
                return A.AncestralCall:Show(icon)
            end
            
            -- arcane_pulse,if=active_enemies>=2|(rune.deficit>=5&runic_power.deficit>=60)
            if A.ArcanePulse:AutoRacial(unit) and Racial and (MultiUnits:GetByRangeInCombat(40, 5, 10) >= 2 or (Player:RuneDeficit() >= 5 and Player:RunicPowerDeficit() >= 60)) then
                return A.ArcanePulse:Show(icon)
            end
            
            -- fireblood,if=(pet.gargoyle.active&talent.summon_gargoyle.enabled)|pet.apoc_ghoul.active
            if A.Fireblood:AutoRacial(unit) and Racial and A.BurstIsON(unit) and ((Pet:IsActive(A.Gargoyle.ID) and A.SummonGargoyle:IsSpellLearned()) or Pet:IsActive(A.ApocGhoul.ID)) then
                return A.Fireblood:Show(icon)
            end
            
            -- bag_of_tricks,if=buff.unholy_strength.up&active_enemies=1|buff.festermight.remains<gcd&active_enemies=1
            if A.BagofTricks:IsReady(unit) and (Unit("player"):HasBuffs(A.UnholyStrengthBuff.ID, true) and MultiUnits:GetByRangeInCombat(40, 5, 10) == 1 or Unit("player"):HasBuffs(A.FestermightBuff.ID, true) < GetGCD() and MultiUnits:GetByRangeInCombat(40, 5, 10) == 1) then
                return A.BagofTricks:Show(icon)
            end
            
            -- use_items,if=time>20|!equipped.ramping_amplitude_gigavolt_engine|!equipped.vision_of_demise
            -- use_item,name=azsharas_font_of_power,if=(essence.vision_of_perfection.enabled&!talent.unholy_assault.enabled)|(!essence.condensed_lifeforce.major&!essence.vision_of_perfection.enabled)
            if A.AzsharasFontofPower:IsReady(unit) and ((A.VisionofPerfection:IsSpellLearned() and not A.UnholyAssault:IsSpellLearned()) or (not Azerite:EssenceHasMajor(A.CondensedLifeforce.ID) and not A.VisionofPerfection:IsSpellLearned())) then
                return A.AzsharasFontofPower:Show(icon)
            end
            
            -- use_item,name=azsharas_font_of_power,if=cooldown.apocalypse.remains<14&(essence.condensed_lifeforce.major|essence.vision_of_perfection.enabled&talent.unholy_assault.enabled)
            if A.AzsharasFontofPower:IsReady(unit) and (A.Apocalypse:GetCooldown() < 14 and (Azerite:EssenceHasMajor(A.CondensedLifeforce.ID) or A.VisionofPerfection:IsSpellLearned() and A.UnholyAssault:IsSpellLearned())) then
                return A.AzsharasFontofPower:Show(icon)
            end
            
            -- use_item,name=azsharas_font_of_power,if=target.1.time_to_die<cooldown.apocalypse.remains+34
            if A.AzsharasFontofPower:IsReady(unit) and (target.1.time_to_die < A.Apocalypse:GetCooldown() + 34) then
                return A.AzsharasFontofPower:Show(icon)
            end
            
            -- use_item,name=ashvanes_razor_coral,if=debuff.razor_coral_debuff.stack<1
            if A.AshvanesRazorCoral:IsReady(unit) and (Unit(unit):HasDeBuffsStacks(A.RazorCoralDebuff.ID, true) < 1) then
                return A.AshvanesRazorCoral:Show(icon)
            end
            
            -- use_item,name=ashvanes_razor_coral,if=pet.guardian_of_azeroth.active&pet.apoc_ghoul.active
            if A.AshvanesRazorCoral:IsReady(unit) and (pet.guardian_of_azeroth.active and Pet:IsActive(A.ApocGhoul.ID)) then
                return A.AshvanesRazorCoral:Show(icon)
            end
            
            -- use_item,name=ashvanes_razor_coral,if=cooldown.apocalypse.ready&(essence.condensed_lifeforce.major&target.1.time_to_die<cooldown.condensed_lifeforce.remains+20|!essence.condensed_lifeforce.major)
            if A.AshvanesRazorCoral:IsReady(unit) and (A.Apocalypse:GetCooldown() == 0 and (Azerite:EssenceHasMajor(A.CondensedLifeforce.ID) and target.1.time_to_die < A.CondensedLifeforce:GetCooldown() + 20 or not Azerite:EssenceHasMajor(A.CondensedLifeforce.ID))) then
                return A.AshvanesRazorCoral:Show(icon)
            end
            
            -- use_item,name=ashvanes_razor_coral,if=target.1.time_to_die<cooldown.apocalypse.remains+20
            if A.AshvanesRazorCoral:IsReady(unit) and (target.1.time_to_die < A.Apocalypse:GetCooldown() + 20) then
                return A.AshvanesRazorCoral:Show(icon)
            end
            
            -- use_item,name=vision_of_demise,if=(cooldown.apocalypse.ready&debuff.festering_wound.stack>=4&essence.vision_of_perfection.enabled)|buff.unholy_assault.up|pet.gargoyle.active
            if A.VisionofDemise:IsReady(unit) and ((A.Apocalypse:GetCooldown() == 0 and Unit(unit):HasDeBuffsStacks(A.FesteringWoundDebuff.ID, true) >= 4 and A.VisionofPerfection:IsSpellLearned()) or Unit("player"):HasBuffs(A.UnholyAssaultBuff.ID, true) or Pet:IsActive(A.Gargoyle.ID)) then
                return A.VisionofDemise:Show(icon)
            end
            
            -- use_item,name=ramping_amplitude_gigavolt_engine,if=cooldown.apocalypse.remains<2|talent.army_of_the_damned.enabled|raid_event.adds.in<5
            if A.RampingAmplitudeGigavoltEngine:IsReady(unit) and (A.Apocalypse:GetCooldown() < 2 or A.ArmyoftheDamned:IsSpellLearned() or IncomingAddsIn < 5) then
                return A.RampingAmplitudeGigavoltEngine:Show(icon)
            end
            
            -- use_item,name=bygone_bee_almanac,if=cooldown.summon_gargoyle.remains>60|!talent.summon_gargoyle.enabled&time>20|!equipped.ramping_amplitude_gigavolt_engine
            if A.BygoneBeeAlmanac:IsReady(unit) and (A.SummonGargoyle:GetCooldown() > 60 or not A.SummonGargoyle:IsSpellLearned() and Unit("player"):CombatTime() > 20 or not A.RampingAmplitudeGigavoltEngine:IsExists()) then
                return A.BygoneBeeAlmanac:Show(icon)
            end
            
            -- use_item,name=jes_howler,if=pet.gargoyle.active|!talent.summon_gargoyle.enabled&time>20|!equipped.ramping_amplitude_gigavolt_engine
            if A.JesHowler:IsReady(unit) and (Pet:IsActive(A.Gargoyle.ID) or not A.SummonGargoyle:IsSpellLearned() and Unit("player"):CombatTime() > 20 or not A.RampingAmplitudeGigavoltEngine:IsExists()) then
                return A.JesHowler:Show(icon)
            end
            
            -- use_item,name=galecallers_beak,if=pet.gargoyle.active|!talent.summon_gargoyle.enabled&time>20|!equipped.ramping_amplitude_gigavolt_engine
            if A.GalecallersBeak:IsReady(unit) and (Pet:IsActive(A.Gargoyle.ID) or not A.SummonGargoyle:IsSpellLearned() and Unit("player"):CombatTime() > 20 or not A.RampingAmplitudeGigavoltEngine:IsExists()) then
                return A.GalecallersBeak:Show(icon)
            end
            
            -- use_item,name=grongs_primal_rage,if=rune<=3&(time>20|!equipped.ramping_amplitude_gigavolt_engine)
            if A.GrongsPrimalRage:IsReady(unit) and (Player:Rune() <= 3 and (Unit("player"):CombatTime() > 20 or not A.RampingAmplitudeGigavoltEngine:IsExists())) then
                return A.GrongsPrimalRage:Show(icon)
            end
            
            -- potion,if=cooldown.army_of_the_dead.ready|pet.gargoyle.active|buff.unholy_assault.up
            if A.PotionofSpectralStrength:IsReady(unit) and Potion and (A.ArmyoftheDead:GetCooldown() == 0 or Pet:IsActive(A.Gargoyle.ID) or Unit("player"):HasBuffs(A.UnholyAssaultBuff.ID, true)) then
                return A.PotionofSpectralStrength:Show(icon)
            end
            
            -- outbreak,target_if=dot.virulent_plague.remains<=gcd
            if A.Outbreak:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.Outbreak, 40, "min", EvaluateCycleOutbreak487) then
                    return A.Outbreak:Show(icon) 
                end
            end
            -- call_action_list,name=essences
            if Essences(unit) then
                return true
            end
            
            -- call_action_list,name=cooldowns
            if Cooldowns(unit) then
                return true
            end
            
            -- run_action_list,name=aoe,if=active_enemies>=2
            if (MultiUnits:GetByRangeInCombat(40, 5, 10) >= 2) then
                return Aoe(unit);
            end
            
            -- call_action_list,name=generic
            if Generic(unit) then
                return true
            end
            
        end
    end

    -- End on EnemyRotation()

    -- Defensive
    --local SelfDefensive = SelfDefensives()
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
        if (unit == "arena1" or unit == "arena2" or unit == "arena3") then 
            -- Reflect Casting BreakAble CC
            if A.NetherWard:IsReady() and A.NetherWard:IsSpellLearned() and Action.ShouldReflect(EnemyTeam()) and EnemyTeam():IsCastingBreakAble(0.25) then 
                return A.NetherWard:Show(icon)
            end 
        end
    end 
end 
local function PartyRotation(unit)
    if (unit == "party1" and not A.GetToggle(2, "PartyUnits")[1]) or (unit == "party2" and not A.GetToggle(2, "PartyUnits")[2]) then 
        return false 
    end

  	-- SingeMagic
    if A.SingeMagic:IsCastable() and A.SingeMagic:AbsentImun(unit, Temp.TotalAndMag) and IsSchoolFree() and Action.AuraIsValid(unit, "UseDispel", "Magic") and not Unit(unit):InLOS() then
        return A.SingeMagic:Show(icon)
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
end]]--

