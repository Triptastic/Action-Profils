--- ====================== ACTION HEADER ============================ ---
local Action                                 = Action
local TeamCache                              = Action.TeamCache
local EnemyTeam                              = Action.EnemyTeam
local FriendlyTeam                           = Action.FriendlyTeam
--local HealingEngine                        = Action.HealingEngine
local LoC                                    = Action.LossOfControl
local Player                                 = Action.Player
local MultiUnits                             = Action.MultiUnits
local UnitCooldown                           = Action.UnitCooldown
local Unit                                   = Action.Unit
local Pet                                    = LibStub("PetLibrary")
local Azerite                                = LibStub("AzeriteTraits")
local setmetatable                           = setmetatable
local TR                                     = Action.TasteRotation
local pairs                                  = pairs
--- ============================ CONTENT ===========================
--- ======= APL LOCALS =======
-- luacheck: max_line_length 9999

-- Spells
Action[ACTION_CONST_DEATHKNIGHT_UNHOLY] = {
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
    BagofTricks                            = Action.Create({ Type = "Spell", ID = 312411    }),
    LightsJudgment                         = Action.Create({ Type = "Spell", ID = 255647 }),
    WilloftheForsaken                      = Action.Create({ Type = "Spell", ID = 7744        }), -- not usable in APL but user can Queue it   
    EscapeArtist                           = Action.Create({ Type = "Spell", ID = 20589    }), -- not usable in APL but user can Queue it
    EveryManforHimself                     = Action.Create({ Type = "Spell", ID = 59752    }), -- not usable in APL but user can Queue it
    -- Generics
    RaiseDead                              = Action.Create({ Type = "Spell", ID = 46584 }),
    ArmyoftheDead                          = Action.Create({ Type = "Spell", ID = 42650 }),
    DeathandDecay                          = Action.Create({ Type = "Spell", ID = 43265 }),
    Apocalypse                             = Action.Create({ Type = "Spell", ID = 275699 }),
    Defile                                 = Action.Create({ Type = "Spell", ID = 152280 }),
    DeathStrike                            = Action.Create({ Type = "Spell", ID = 49998     }),
    Epidemic                               = Action.Create({ Type = "Spell", ID = 207317 }),
    DeathCoil                              = Action.Create({ Type = "Spell", ID = 47541 }),
    ScourgeStrike                          = Action.Create({ Type = "Spell", ID = 55090 }),
    ClawingShadows                         = Action.Create({ Type = "Spell", ID = 207311 }),
    FesteringStrike                        = Action.Create({ Type = "Spell", ID = 85948 }),
    FesteringWoundDebuff                   = Action.Create({ Type = "Spell", ID = 194310 }),
    BurstingSores                          = Action.Create({ Type = "Spell", ID = 207264 }),
    SuddenDoomBuff                         = Action.Create({ Type = "Spell", ID = 81340 }),
    UnholyFrenzyBuff                       = Action.Create({ Type = "Spell", ID = 207289 }),
    DarkTransformation                     = Action.Create({ Type = "Spell", ID = 63560 }),
    SummonGargoyle                         = Action.Create({ Type = "Spell", ID = 49206 }),
	Gargoyle                               = Action.Create({ Type = "Spell", ID = 27829 , Hidden = true     }),
    UnholyFrenzy                           = Action.Create({ Type = "Spell", ID = 207289 }),
    MagusoftheDead                         = Action.Create({ Type = "Spell", ID = 288417 }),
    SoulReaper                             = Action.Create({ Type = "Spell", ID = 130736 }),
    UnholyBlight                           = Action.Create({ Type = "Spell", ID = 115989 }),
    Pestilence                             = Action.Create({ Type = "Spell", ID = 277234 }),
    ArcaneTorrent                          = Action.Create({ Type = "Spell", ID = 50613 }),
    BloodFury                              = Action.Create({ Type = "Spell", ID = 20572 }),
    Berserking                             = Action.Create({ Type = "Spell", ID = 26297 }),
    ArmyoftheDamned                        = Action.Create({ Type = "Spell", ID = 276837 }),
    Outbreak                               = Action.Create({ Type = "Spell", ID = 77575 }),
    VirulentPlagueDebuff                   = Action.Create({ Type = "Spell", ID = 191587 }),
    Icecap                                 = Action.Create({ Type = "Spell", ID = 207126 }),
	-- Defensives
    IceboundFortitude                      = Action.Create({ Type = "Spell", ID = 48792 }),
    AntiMagicShell                         = Action.Create({ Type = "Spell", ID = 48707 }),
    DeathPact                              = Action.Create({ Type = "Spell", ID = 48743 }),	-- Talent
	-- Utilities
	WraithWalk                             = Action.Create({ Type = "Spell", ID = 212552     }), 
	MindFreeze                             = Action.Create({ Type = "Spell", ID = 47528     }),
	Asphyxiate                             = Action.Create({ Type = "Spell", ID = 108194     }),
	DeathsAdvance                          = Action.Create({ Type = "Spell", ID = 48265     }), -- 30% Speed & immune to 100% normal speed
	DeathGrip                              = Action.Create({ Type = "Spell", ID = 49576     }),
    ChainsofIce                            = Action.Create({ Type = "Spell", ID = 45524     }), -- 70% snare, 8sec
    RaiseAlly                              = Action.Create({ Type = "Spell", ID = 61999     }),	 -- Battle rez
    -- Trinkets
    TrinketTest                            = Action.Create({ Type = "Trinket", ID = 122530, QueueForbidden = true }), 
    TrinketTest2                           = Action.Create({ Type = "Trinket", ID = 159611, QueueForbidden = true }), 
    AzsharasFontofPower                    = Action.Create({ Type = "Trinket", ID = 169314, QueueForbidden = true }), 
    PocketsizedComputationDevice           = Action.Create({ Type = "Trinket", ID = 167555, QueueForbidden = true }), 
    RotcrustedVoodooDoll                   = Action.Create({ Type = "Trinket", ID = 159624, QueueForbidden = true }), 
    ShiverVenomRelic                       = Action.Create({ Type = "Trinket", ID = 168905, QueueForbidden = true }), 
    AquipotentNautilus                     = Action.Create({ Type = "Trinket", ID = 169305, QueueForbidden = true }), 
    TidestormCodex                         = Action.Create({ Type = "Trinket", ID = 165576, QueueForbidden = true }), 
    VialofStorms                           = Action.Create({ Type = "Trinket", ID = 158224, QueueForbidden = true }), 
    -- Potions
    PotionofUnbridledFury                  = Action.Create({ Type = "Potion", ID = 169299, QueueForbidden = true }), 
    BattlePotionOfAgility                  = Action.Create({ Type = "Potion", ID = 163223, QueueForbidden = true }), 
	AbyssalHealingPotion                   = Action.Create({ Type = "Potion", ID = 169451, QueueForbidden = true }), 
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
	GrongsPrimalRage                       = Action.Create({ Type = "Trinket", ID = 165574, QueueForbidden = true }),
	BygoneBeeAlmanac                       = Action.Create({ Type = "Trinket", ID = 163936, QueueForbidden = true }),
	RampingAmplitudeGigavoltEngine         = Action.Create({ Type = "Trinket", ID = 165580, QueueForbidden = true }),
	VisionofDemise                         = Action.Create({ Type = "Trinket", ID = 169307, QueueForbidden = true }),
	JesHowler                              = Action.Create({ Type = "Trinket", ID = 159627, QueueForbidden = true }),
	GalecallersBeak                        = Action.Create({ Type = "Trinket", ID = 161379, QueueForbidden = true }),
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
	VisionofPerfection			           = Action.Create({ Type = "Spell", ID = 299368, Hidden = true}),
    BloodoftheEnemy                        = Action.Create({ Type = "HeartOfAzeroth", ID = 297108, Hidden = true}),
    BloodoftheEnemy2                       = Action.Create({ Type = "HeartOfAzeroth", ID = 298273, Hidden = true}),
    BloodoftheEnemy3                       = Action.Create({ Type = "HeartOfAzeroth", ID = 298277, Hidden = true}),
    ConcentratedFlame                      = Action.Create({ Type = "HeartOfAzeroth", ID = 295373, Hidden = true}),
    ConcentratedFlame2                     = Action.Create({ Type = "HeartOfAzeroth", ID = 299349, Hidden = true}),
    ConcentratedFlame3                     = Action.Create({ Type = "HeartOfAzeroth", ID = 299353, Hidden = true}),
    GuardianofAzeroth                      = Action.Create({ Type = "HeartOfAzeroth", ID = 295840, Hidden = true}),
    GuardianofAzeroth2                     = Action.Create({ Type = "HeartOfAzeroth", ID = 299355, Hidden = true}),
    GuardianofAzeroth3                     = Action.Create({ Type = "HeartOfAzeroth", ID = 299358, Hidden = true}),
    FocusedAzeriteBeam                     = Action.Create({ Type = "HeartOfAzeroth", ID = 295258, Hidden = true}),
    FocusedAzeriteBeam2                    = Action.Create({ Type = "HeartOfAzeroth", ID = 299336, Hidden = true}),
    FocusedAzeriteBeam3                    = Action.Create({ Type = "HeartOfAzeroth", ID = 299338, Hidden = true}),
    PurifyingBlast                         = Action.Create({ Type = "HeartOfAzeroth", ID = 295337, Hidden = true}),
    PurifyingBlast2                        = Action.Create({ Type = "HeartOfAzeroth", ID = 299345, Hidden = true}),
    PurifyingBlast3                        = Action.Create({ Type = "HeartOfAzeroth", ID = 299347, Hidden = true}),
    TheUnboundForce                        = Action.Create({ Type = "HeartOfAzeroth", ID = 298452, Hidden = true}),
    TheUnboundForce2                       = Action.Create({ Type = "HeartOfAzeroth", ID = 299376, Hidden = true}),
    TheUnboundForce3                       = Action.Create({ Type = "HeartOfAzeroth", ID = 299378, Hidden = true}),
    RippleInSpace                          = Action.Create({ Type = "HeartOfAzeroth", ID = 302731, Hidden = true}),
    RippleInSpace2                         = Action.Create({ Type = "HeartOfAzeroth", ID = 302982, Hidden = true}),
    RippleInSpace3                         = Action.Create({ Type = "HeartOfAzeroth", ID = 302983, Hidden = true}),
    WorldveinResonance                     = Action.Create({ Type = "HeartOfAzeroth", ID = 295186, Hidden = true}),
    WorldveinResonance2                    = Action.Create({ Type = "HeartOfAzeroth", ID = 298628, Hidden = true}),
    WorldveinResonance3                    = Action.Create({ Type = "HeartOfAzeroth", ID = 299334, Hidden = true}),
    MemoryofLucidDreams                    = Action.Create({ Type = "HeartOfAzeroth", ID = 298357, Hidden = true}),
    MemoryofLucidDreams2                   = Action.Create({ Type = "HeartOfAzeroth", ID = 299372, Hidden = true}),
    MemoryofLucidDreams3                   = Action.Create({ Type = "HeartOfAzeroth", ID = 299374, Hidden = true}), 
    RecklessForceBuff                      = Action.Create({ Type = "Spell", ID = 302932, Hidden = true     }),	 
    PoolResource                           = Action.Create({ Type = "Spell", ID = 209274, Hidden = true     }),
};

-- To create essences use next code:
Action:CreateEssencesFor(ACTION_CONST_DEATHKNIGHT_UNHOLY)  -- where PLAYERSPEC is Constance (example: ACTION_CONST_MONK_BM)
local A = setmetatable(Action[ACTION_CONST_DEATHKNIGHT_UNHOLY], { __index = Action })

-- API - Pet Tracker 
Pet:InitializeTrackerFor(ACTION_CONST_DEATHKNIGHT_UNHOLY, { -- this template table is the same with what has this library already built-in, just for example
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
---------------- VARIABLES ---------------
------------------------------------------


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
	return A.Ann:IsInRange(unit)
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

local function GuardianofAzerothIsActive() 
    return Pet:GetRemainDuration(152396) > 0 and true or false
end	

local function DeathStrikeHeal()
    return (Action.GetToggle(2, "SoloMode") and Unit("player"):HealthPercent() < Action.GetToggle(2, "UseDeathStrikeHP")) and true or false;
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
    local HPLoosePerSecond = Unit("player"):GetDMG() * 100 / Unit("player"):HealthMax()
		
    if Unit("player"):CombatTime() == 0 then 
        return 
    end 

    -- Icebound Fortitude
    local IceboundFortitude = Action.GetToggle(2, "IceboundFortitudeHP")
    if     IceboundFortitude >= 0 and A.IceboundFortitude:IsReady("player") and 
    (
        (   -- Auto 
            IceboundFortitude >= 100 and 
            (
                -- HP lose per sec >= 20
                Unit("player"):GetDMG() * 100 / Unit("player"):HealthMax() >= 20 or 
                Unit("player"):GetRealTimeDMG() >= Unit("player"):HealthMax() * 0.20 or 
                -- TTD 
                Unit("player"):TimeToDieX(25) < 5 or
				-- Player stunned
                LoC:Get("STUN") > 0	or			
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
            IceboundFortitude < 100 and 
            Unit("player"):HealthPercent() <= IceboundFortitude
        )
    ) 
    then 
        return A.IceboundFortitude
    end  
	
	    -- HealingPotion
    local AbyssalHealingPotion = A.GetToggle(2, "AbyssalHealingPotionHP")
    if     AbyssalHealingPotion >= 0 and A.AbyssalHealingPotion:IsReady("player") and 
    (
        (     -- Auto 
            AbyssalHealingPotion >= 100 and 
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
            AbyssalHealingPotion < 100 and 
            Unit("player"):HealthPercent() <= AbyssalHealingPotion
        )
    ) 
    then 
        return A.AbyssalHealingPotion
    end 
		
    -- Emergency AntiMagicShell
        local AntiMagicShell = Action.GetToggle(2, "AntiMagicShellHP")
        if     AntiMagicShell >= 0 and A.AntiMagicShell:IsReady("player") and 
        (
            (   -- Auto 
                AntiMagicShell >= 100 and 
                (
                    -- HP lose per sec >= 10
                    Unit("player"):GetDMG() * 100 / Unit("player"):HealthMax() >= 10 or 
                    Unit("player"):GetRealTimeDMG() >= Unit("player"):HealthMax() * 0.10 or 
                    -- TTD Magic
                    Unit("player"):TimeToDieMagicX(50) < 5 or 
					
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
                AntiMagicShell < 100 and 
                Unit("player"):HealthPercent() <= AntiMagicShell
            )
        ) 
        then 
            return A.AntiMagicShell
        end  		

        -- Emergency Death Pact
        local DeathPact = Action.GetToggle(2, "DeathPactHP")
        if     DeathPact >= 0 and A.DeathPact:IsReady("player") and A.DeathPact:IsSpellLearned() and 
        (
            (   -- Auto 
                DeathPact >= 100 and 
                (
                    -- HP lose per sec >= 30
                    Unit("player"):GetDMG() * 100 / Unit("player"):HealthMax() >= 30 or 
                    Unit("player"):GetRealTimeDMG() >= Unit("player"):HealthMax() * 0.30 or 
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
                DeathPact < 100 and 
                Unit("player"):HealthPercent() <= DeathPact
            )
        ) 
        then 
            return A.DeathPact
        end  		

end 
SelfDefensives = A.MakeFunctionCachedDynamic(SelfDefensives)

local function Interrupts(unit)
    local useKick, useCC, useRacial = A.InterruptIsValid(unit, "TargetMouseover")    
    local EnemiesCasting = MultiUnits:GetByRangeCasting(10, 5, true, "TargetMouseover")
		
    -- MindFreeze
    if useKick and A.MindFreeze:IsReady(unit) then 
     	if Unit(unit):CanInterrupt(true, nil, 25, 70) then
       	    return A.MindFreeze
       	end 
   	end 
	
    -- DeathGrip
    if useCC and not A.MindFreeze:IsReady(unit) and A.DeathGrip:IsReady(unit) and A.GetToggle(2, "DeathGripInterrupt") then 
     	if Unit(unit):CanInterrupt(true, nil, 25, 70) then
       	    return A.DeathGrip
       	end 
   	end 
	
   	-- Asphyxiate
   	if useCC and A.Asphyxiate:IsSpellLearned() and A.Asphyxiate:IsReady(unit) then 
 		if Unit(unit):CanInterrupt(true, nil, 25, 70) then
   	        return A.Asphyxiate
   	    end 
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

local CanCast = true

--- ======= ACTION LISTS =======
-- [3] Single Rotation
A[3] = function(icon, isMulti)
    --------------------
    --- ROTATION VAR ---
    --------------------
    local isMoving = A.Player:IsMoving()
	local isMovingFor = A.Player:IsMovingTime()
    local inCombat = Unit("player"):CombatTime() > 0
    local combatTime = Unit("player"):CombatTime()
    local ShouldStop = Action.ShouldStop()
    local Pull = Action.BossMods_Pulling()
    local unit = "player"
    local GuardianofAzerothIsActive = GuardianofAzerothIsActive()
    local DeathStrikeHeal = DeathStrikeHeal()
	-- Trinkets vars
    local Trinket1IsAllowed, Trinket2IsAllowed = TR:TrinketIsAllowed()
	
	-- FocusedAzeriteBeam protection channel
	local secondsLeft, percentLeft, spellID, spellName, notInterruptable, isChannel = Unit("player"):IsCastingRemains()
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
        local Precombat, Aoe, Cooldowns, Essences, Generic
        --Precombat
        local function Precombat(unit)
            -- flask
            -- food
            -- augmentation
            -- snapshot_stats
			
            -- potion
            if A.PotionofUnbridledFury:IsReady(unit) and Action.GetToggle(1, "Potion") 
			and (Pull > 0 and Pull <= 2 or not A.GetToggle(1 ,"DBM"))
			then
                return A.PotionofUnbridledFury:Show(icon)
            end
			
            -- raise_dead
            if A.RaiseDead:IsReady("player") and not Pet:IsActive() then
                return A.RaiseDead:Show(icon)
            end
			
            -- use_item,name=azsharas_font_of_power
            if A.AzsharasFontofPower:IsReady(unit)
			and (Pull > 0 and Pull <= 6 or not A.GetToggle(1 ,"DBM"))
			then
                return A.AzsharasFontofPower:Show(icon)
            end
			
            -- army_of_the_dead,delay=2
            if A.ArmyoftheDead:IsReady(unit) and A.BurstIsON(unit) 
			and (Pull > 0 and Pull <= 3 or not A.GetToggle(1 ,"DBM"))
			then
                return A.ArmyoftheDead:Show(icon)
            end
			
            -- army_of_the_dead,delay=2
            if A.FesteringStrike:IsReady(unit)
            and (Pull > 0 and Pull <= 1 or not A.GetToggle(1 ,"DBM"))			
			then
                return A.FesteringStrike:Show(icon)
            end
        end
        
        --Aoe
        local function Aoe(unit)
		
            -- death_and_decay,if=cooldown.apocalypse.remains
            if A.DeathandDecay:IsReadyByPassCastGCDP("player", true, true, nil) then
                return A.DeathandDecay:Show(icon)
            end
			
            -- defile
            if A.Defile:IsReady(unit) then
                return A.Defile:Show(icon)
            end
			
            -- epidemic,if=death_and_decay.ticking&rune<2&!variable.pooling_for_gargoyle
            if A.Epidemic:IsReady(unit) and (Unit(unit):HasDeBuffs(A.DeathandDecay.ID, true) > 0 and Player:Rune() < 2 and not VarPoolingForGargoyle) then
                return A.Epidemic:Show(icon)
            end
			
            -- death_coil,if=death_and_decay.ticking&rune<2&!variable.pooling_for_gargoyle
            if A.DeathCoil:IsReady(unit) and (Unit(unit):HasDeBuffs(A.DeathandDecay.ID, true) > 0 and Player:Rune() < 2 and not VarPoolingForGargoyle) then
                return A.DeathCoil:Show(icon)
            end
			
            -- scourge_strike,if=death_and_decay.ticking&cooldown.apocalypse.remains
            if A.ScourgeStrike:IsReady(unit) and Unit(unit):HasDeBuffs(A.FesteringWoundDebuff.ID, true) > 0 and Unit(unit):HasDeBuffs(A.DeathandDecay.ID, true) > 0 then
                return A.ScourgeStrike:Show(icon)
            end
			
            -- clawing_shadows,if=death_and_decay.ticking&cooldown.apocalypse.remains
            if A.ClawingShadows:IsReady(unit) and (Unit(unit):HasDeBuffs(A.DeathandDecay.ID, true) > 0 and bool(A.Apocalypse:GetCooldown())) then
                return A.ClawingShadows:Show(icon)
            end
			
            -- epidemic,if=!variable.pooling_for_gargoyle
            if A.Epidemic:IsReady(unit) and (not VarPoolingForGargoyle) then
                return A.Epidemic:Show(icon)
            end
			
            -- festering_strike,target_if=debuff.festering_wound.stack<=1&cooldown.death_and_decay.remains
            if A.FesteringStrike:IsReady(unit) and Unit(unit):HasDeBuffsStacks(A.FesteringWoundDebuff.ID, true) <= 1 and A.DeathandDecay:GetCooldown() > 0 then
                return A.FesteringStrike:Show(icon) 
            end
			
            -- festering_strike,if=talent.bursting_sores.enabled&spell_targets.bursting_sores>=2&debuff.festering_wound.stack<=1
            if A.FesteringStrike:IsReady(unit) and (A.BurstingSores:IsSpellLearned() and MultiUnits:GetByRange(8) >= 2 and Unit(unit):HasDeBuffsStacks(A.FesteringWoundDebuff.ID, true) <= 1) then
                return A.FesteringStrike:Show(icon)
            end
			
            -- death_coil,if=buff.sudden_doom.react&rune.deficit>=4
            if A.DeathCoil:IsReady(unit) and (Unit("player"):HasBuffsStacks(A.SuddenDoomBuff.ID, true) > 0 and Player:Rune() <= 2) then
                return A.DeathCoil:Show(icon)
            end
			
            -- death_coil,if=buff.sudden_doom.react&!variable.pooling_for_gargoyle|pet.gargoyle.active
            if A.DeathCoil:IsReady(unit) and (Unit("player"):HasBuffsStacks(A.SuddenDoomBuff.ID, true) > 0 and not VarPoolingForGargoyle or Pet:IsActive(27829)) then
                return A.DeathCoil:Show(icon)
            end
			
            -- death_coil,if=runic_power.deficit<14&(cooldown.apocalypse.remains>5|debuff.festering_wound.stack>4)&!variable.pooling_for_gargoyle
            if A.DeathCoil:IsReady(unit) and Player:RunicPowerDeficit() < 14 and (A.Apocalypse:GetCooldown() > 5 or Unit(unit):HasDeBuffsStacks(A.FesteringWoundDebuff.ID, true) > 4) and not VarPoolingForGargoyle then
                return A.DeathCoil:Show(icon)
            end
			
            -- scourge_strike,if=((debuff.festering_wound.up&cooldown.apocalypse.remains>5)|debuff.festering_wound.stack>4)&(cooldown.army_of_the_dead.remains>5|death_knight.disable_aotd)
            if A.ScourgeStrike:IsReady(unit) 
			and (Unit(unit):HasDeBuffs(A.FesteringWoundDebuff.ID, true) > 0 and A.Apocalypse:GetCooldown() > 5 or Unit(unit):HasDeBuffsStacks(A.FesteringWoundDebuff.ID, true) > 4)
			and (A.ArmyoftheDead:GetCooldown() > 5 or A.GetToggle(2, "DisableAotD")) 
			then
                return A.ScourgeStrike:Show(icon)
            end
			
            -- clawing_shadows,if=((debuff.festering_wound.up&cooldown.apocalypse.remains>5)|debuff.festering_wound.stack>4)&(cooldown.army_of_the_dead.remains>5|death_knight.disable_aotd)
            if A.ClawingShadows:IsReady(unit) and (((Unit(unit):HasDeBuffs(A.FesteringWoundDebuff.ID, true) > 0 and A.Apocalypse:GetCooldown() > 5) or Unit(unit):HasDeBuffsStacks(A.FesteringWoundDebuff.ID, true) > 4) and (A.ArmyoftheDead:GetCooldown() > 5 or A.GetToggle(2, "DisableAotD"))) then
                return A.ClawingShadows:Show(icon)
            end
			
            -- death_coil,if=runic_power.deficit<20&!variable.pooling_for_gargoyle
            if A.DeathCoil:IsReady(unit) and (Player:RunicPowerDeficit() < 20 and not VarPoolingForGargoyle) then
                return A.DeathCoil:Show(icon)
            end
			
            -- festering_strike,if=((((debuff.festering_wound.stack<4&!buff.unholy_frenzy.up)|debuff.festering_wound.stack<3)&cooldown.apocalypse.remains<3)|debuff.festering_wound.stack<1)&(cooldown.army_of_the_dead.remains>5|death_knight.disable_aotd)
            if A.FesteringStrike:IsReady(unit) and 
			(
			    Unit(unit):HasDeBuffsStacks(A.FesteringWoundDebuff.ID, true) < 4 and Unit("player"):HasBuffs(A.UnholyFrenzyBuff.ID, true) == 0 
				or 
				Unit(unit):HasDeBuffsStacks(A.FesteringWoundDebuff.ID, true) < 3 and A.Apocalypse:GetCooldown() < 3 
				or 
				Unit(unit):HasDeBuffsStacks(A.FesteringWoundDebuff.ID, true) < 1 and (A.ArmyoftheDead:GetCooldown() > 5 or A.GetToggle(2, "DisableAotD"))
			)
			then
                return A.FesteringStrike:Show(icon)
            end
			
            -- death_coil,if=!variable.pooling_for_gargoyle
            if A.DeathCoil:IsReady(unit) and (not VarPoolingForGargoyle) then
                return A.DeathCoil:Show(icon)
            end
        end
        
        --Cooldowns
        local function Cooldowns(unit)
		
            -- army_of_the_dead
            if A.ArmyoftheDead:IsReady(unit) and A.BurstIsON(unit) then
                return A.ArmyoftheDead:Show(icon)
            end
			
            -- apocalypse,if=debuff.festering_wound.stack>=4
            if A.Apocalypse:IsReady(unit) and (Unit(unit):HasDeBuffsStacks(A.FesteringWoundDebuff.ID, true) >= 4) then
                return A.Apocalypse:Show(icon)
            end
			
            -- dark_transformation,if=!raid_event.adds.exists|raid_event.adds.in>15
            if A.DarkTransformation:IsReady(unit) then
                return A.DarkTransformation:Show(icon)
            end
			
            -- summon_gargoyle,if=runic_power.deficit<14
            if A.SummonGargoyle:IsReady("player") and Player:RunicPowerDeficit() < 14 and A.BurstIsON(unit) then
                return A.SummonGargoyle:Show(icon)
            end
			
            -- unholy_frenzy,if=essence.vision_of_perfection.enabled|(essence.condensed_lifeforce.enabled&pet.apoc_ghoul.active)|debuff.festering_wound.stack<4&!(equipped.ramping_amplitude_gigavolt_engine|azerite.magus_of_the_dead.enabled)|cooldown.apocalypse.remains<2&(equipped.ramping_amplitude_gigavolt_engine|azerite.magus_of_the_dead.enabled)
            if A.UnholyFrenzy:IsReady(unit) and A.BurstIsON(unit) and (Azerite:EssenceHasMajor(A.VisionofPerfection.ID) or (A.GuardianofAzeroth:GetAzeriteRank() > 0 and Pet:IsActive(24207)) or Unit(unit):HasDeBuffsStacks(A.FesteringWoundDebuff.ID, true) < 4 and not (A.RampingAmplitudeGigavoltEngine:IsExists() or bool(A.MagusoftheDead:GetAzeriteRank())) or A.Apocalypse:GetCooldown() < 2 and (A.RampingAmplitudeGigavoltEngine:IsExists() or bool(A.MagusoftheDead:GetAzeriteRank()))) then
                return A.UnholyFrenzy:Show(icon)
            end
			
            -- unholy_frenzy,if=active_enemies>=2&((cooldown.death_and_decay.remains<=gcd&!talent.defile.enabled)|(cooldown.defile.remains<=gcd&talent.defile.enabled))
            if A.UnholyFrenzy:IsReady(unit) and A.BurstIsON(unit) and (MultiUnits:GetByRange(8) >= 2 and ((A.DeathandDecay:GetCooldown() <= A.GetGCD() and not A.Defile:IsSpellLearned()) or (A.Defile:GetCooldown() <= A.GetGCD() and A.Defile:IsSpellLearned()))) then
                return A.UnholyFrenzy:Show(icon)
            end
			
            -- soul_reaper,target_if=target.time_to_die<8&target.time_to_die>4
            if A.SoulReaper:IsReady(unit) and Unit(unit):TimeToDie() < 8 and Unit(unit):TimeToDie() > 4 then
                return A.SoulReaper:Show(icon) 
            end
			
            -- soul_reaper,if=(!raid_event.adds.exists|raid_event.adds.in>20)&rune<=(1-buff.unholy_frenzy.up)
            if A.SoulReaper:IsReady(unit) and Player:Rune() <= 2 then
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
            if A.MemoryofLucidDreams:AutoHeartOfAzeroth(unit, true) and A.BurstIsON(unit) and Action.GetToggle(1, "HeartOfAzeroth") and (Player:RuneTimeToX(1) > A.GetGCD() and Player:RunicPower() < 40) then
                return A.MemoryofLucidDreams:Show(icon)
            end
			
			-- reaping_flames
            if A.ReapingFlames:AutoHeartOfAzeroth(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") then
                return A.ReapingFlames:Show(icon)
            end
			
			-- moment_of_glory
            if A.MomentofGlory:AutoHeartOfAzeroth(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") then
                return A.MomentofGlory:Show(icon)
            end

			-- ReplicaofKnowledge
            if A.ReplicaofKnowledge:AutoHeartOfAzeroth(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") then
                return A.ReplicaofKnowledge:Show(icon)
            end				
			
            -- blood_of_the_enemy,if=(cooldown.death_and_decay.remains&spell_targets.death_and_decay>1)|(cooldown.defile.remains&spell_targets.defile>1)|(cooldown.apocalypse.remains&cooldown.death_and_decay.ready)
            if A.BloodoftheEnemy:AutoHeartOfAzeroth(unit, true) and A.BurstIsON(unit) and Action.GetToggle(1, "HeartOfAzeroth") and ((A.DeathandDecay:GetCooldown() > 0 and MultiUnits:GetByRange(30) > 1) or (A.Defile:GetCooldown() > 0 and MultiUnits:GetByRange(8) > 1) or (A.Apocalypse:GetCooldown() > 0 and A.DeathandDecay:GetCooldown() == 0)) then
                return A.BloodoftheEnemy:Show(icon)
            end
			
            -- guardian_of_azeroth,if=(cooldown.apocalypse.remains<6&cooldown.army_of_the_dead.remains>cooldown.condensed_lifeforce.remains)|cooldown.army_of_the_dead.remains<2
            if A.GuardianofAzeroth:AutoHeartOfAzeroth(unit, true) and A.BurstIsON(unit) and Action.GetToggle(1, "HeartOfAzeroth") and (A.Apocalypse:GetCooldown() < 6) then
                return A.GuardianofAzeroth:Show(icon)
            end
			
            -- the_unbound_force,if=buff.reckless_force.up|buff.reckless_force_counter.stack<11
            if A.TheUnboundForce:AutoHeartOfAzeroth(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") and (Unit("player"):HasBuffs(A.RecklessForceBuff.ID, true) > 0 or Unit("player"):HasBuffsStacks(A.RecklessForceCounterBuff.ID, true) < 11) then
                return A.TheUnboundForce:Show(icon)
            end
			
            -- focused_azerite_beam,if=!death_and_decay.ticking
            if A.FocusedAzeriteBeam:AutoHeartOfAzeroth(unit, true) and A.BurstIsON(unit) and Action.GetToggle(1, "HeartOfAzeroth") then
                return A.FocusedAzeriteBeam:Show(icon)
            end
			
            -- concentrated_flame,if=dot.concentrated_flame_burn.remains=0
            if A.ConcentratedFlame:AutoHeartOfAzeroth(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") then
                return A.ConcentratedFlame:Show(icon)
            end
			
            -- purifying_blast,if=!death_and_decay.ticking
            if A.PurifyingBlast:AutoHeartOfAzeroth(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") then
                return A.PurifyingBlast:Show(icon)
            end
			
            -- worldvein_resonance,if=!death_and_decay.ticking
            if A.WorldveinResonance:AutoHeartOfAzeroth(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") then
                return A.WorldveinResonance:Show(icon)
            end
			
            -- ripple_in_space,if=!death_and_decay.ticking
            if A.RippleInSpace:AutoHeartOfAzeroth(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") then
                return A.RippleInSpace:Show(icon)
            end
        end
        
        --Generic
        local function Generic(unit)
		
            -- death_coil,if=buff.sudden_doom.react&!variable.pooling_for_gargoyle|pet.gargoyle.active
            if A.DeathCoil:IsReady(unit) and (Unit("player"):HasBuffsStacks(A.SuddenDoomBuff.ID, true) > 0 and not VarPoolingForGargoyle or Pet:IsActive(27829)) then
                return A.DeathCoil:Show(icon)
            end
			
            -- death_coil,if=runic_power.deficit<14&(cooldown.apocalypse.remains>5|debuff.festering_wound.stack>4)&!variable.pooling_for_gargoyle
            if A.DeathCoil:IsReady(unit) and (Player:RunicPowerDeficit() < 14 and (A.Apocalypse:GetCooldown() > 5 or Unit(unit):HasDeBuffsStacks(A.FesteringWoundDebuff.ID, true) > 4) and not VarPoolingForGargoyle) then
                return A.DeathCoil:Show(icon)
            end
			
            -- death_and_decay,if=talent.pestilence.enabled&cooldown.apocalypse.remains
            if A.DeathandDecay:IsReadyByPassCastGCDP("player", true, true, nil) and (A.Pestilence:IsSpellLearned() and A.Apocalypse:GetCooldown() > 0) then
                return A.DeathandDecay:Show(icon)
            end
			
            -- defile,if=cooldown.apocalypse.remains
            if A.Defile:IsReady(unit) and (A.Apocalypse:GetCooldown() > 0) then
                return A.Defile:Show(icon)
            end
			
            -- scourge_strike,if=((debuff.festering_wound.up&cooldown.apocalypse.remains>5)|debuff.festering_wound.stack>4)&(cooldown.army_of_the_dead.remains>5|death_knight.disable_aotd)
            if A.ScourgeStrike:IsReady(unit) and Unit(unit):HasDeBuffs(A.FesteringWoundDebuff.ID, true) > 0 
			then
                return A.ScourgeStrike:Show(icon)
            end
			
            -- clawing_shadows,if=((debuff.festering_wound.up&cooldown.apocalypse.remains>5)|debuff.festering_wound.stack>4)&(cooldown.army_of_the_dead.remains>5|death_knight.disable_aotd)
            if A.ClawingShadows:IsReady(unit) and (((Unit(unit):HasDeBuffs(A.FesteringWoundDebuff.ID, true) > 0 and A.Apocalypse:GetCooldown() > 5) or Unit(unit):HasDeBuffsStacks(A.FesteringWoundDebuff.ID, true) > 4) and (A.ArmyoftheDead:GetCooldown() > 5 or A.GetToggle(2, "DisableAotD"))) then
                return A.ClawingShadows:Show(icon)
            end
			
            -- death_coil,if=runic_power.deficit<20&!variable.pooling_for_gargoyle
            if A.DeathCoil:IsReady(unit) and (Player:RunicPowerDeficit() < 20 and not VarPoolingForGargoyle) then
                return A.DeathCoil:Show(icon)
            end
			
            -- festering_strike,if=((((debuff.festering_wound.stack<4&!buff.unholy_frenzy.up)|debuff.festering_wound.stack<3)&cooldown.apocalypse.remains<3)|debuff.festering_wound.stack<1)&(cooldown.army_of_the_dead.remains>5|death_knight.disable_aotd)
            if A.FesteringStrike:IsReady(unit) and (((((Unit(unit):HasDeBuffsStacks(A.FesteringWoundDebuff.ID, true) < 4 and Unit("player"):HasBuffs(A.UnholyFrenzyBuff.ID, true) == 0) or Unit(unit):HasDeBuffsStacks(A.FesteringWoundDebuff.ID, true) < 3) and A.Apocalypse:GetCooldown() < 3) or Unit(unit):HasDeBuffsStacks(A.FesteringWoundDebuff.ID, true) < 1) and (A.ArmyoftheDead:GetCooldown() > 5 or A.GetToggle(2, "DisableAotD"))) then
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
            -- variable,name=pooling_for_gargoyle,value=cooldown.summon_gargoyle.remains<5&talent.summon_gargoyle.enabled
			local VarPoolingForGargoyle = A.SummonGargoyle:GetCooldown() < 5 and A.SummonGargoyle:IsSpellLearned()
			
			--print(VarPoolingForGargoyle)
			
			-- auto_attack
			-- Chains of Ice
			if Unit(unit):IsMovingOut() and CanCast and A.GetToggle(2, "UseChainsofIce") and A.ChainsofIce:IsReady(unit) and Unit(unit):HasDeBuffs(A.ChainsofIce.ID, true) == 0 then
			    return A.ChainsofIce:Show(icon) 
			end
			
			-- Death Grip
			if Unit(unit):IsMovingOut() and CanCast and A.GetToggle(2, "UseDeathGrip") and Unit(unit):HasDeBuffs(A.ChainsofIce.ID, true) > 0 and A.DeathGrip:IsReady(unit) and Unit(unit):GetRange() > 8 and Unit(unit):GetRange() <= 30 then
			    return A.DeathGrip:Show(icon) 
			end
			
			-- Wraith Walk if out of range 
            if A.WraithWalk:IsReady("player") and CanCast and isMovingFor > A.GetToggle(2, "WraithWalkTime") and A.GetToggle(2, "UseWraithWalk") then
                return A.WraithWalk:Show(icon)
            end
			
			-- Deaths Advance if out of range 
            if A.DeathsAdvance:IsReady("player") and CanCast and isMovingFor > A.GetToggle(2, "DeathsAdvanceTime") and A.GetToggle(2, "UseDeathsAdvance") then
                return A.DeathsAdvance:Show(icon)
            end			
		
            -- arcane_torrent,if=runic_power.deficit>65&(pet.gargoyle.active|!talent.summon_gargoyle.enabled)&rune.deficit>=5
            if A.ArcaneTorrent:IsRacialReady(unit) and CanCast and Action.GetToggle(1, "Racial") and A.BurstIsON(unit) and (Player:RunicPowerDeficit() > 65 and (Pet:IsActive(27829) or not A.SummonGargoyle:IsSpellLearned()) and Player:Rune() <= 1) then
                return A.ArcaneTorrent:Show(icon)
            end
			
            -- bag_of_tricks
            if A.BagofTricks:AutoRacial(unit) and Action.GetToggle(1, "Racial") and A.BurstIsON(unit) then
                return A.BagofTricks:Show(icon)
            end		
			
            -- blood_fury,if=pet.gargoyle.active|!talent.summon_gargoyle.enabled
            if A.BloodFury:AutoRacial(unit) and CanCast and Action.GetToggle(1, "Racial") and A.BurstIsON(unit) and (Pet:IsActive(27829) or not A.SummonGargoyle:IsSpellLearned()) then
                return A.BloodFury:Show(icon)
            end
			
            -- berserking,if=buff.unholy_frenzy.up|pet.gargoyle.active|(talent.army_of_the_damned.enabled&pet.apoc_ghoul.active)
            if A.Berserking:AutoRacial(unit) and CanCast and Action.GetToggle(1, "Racial") and A.BurstIsON(unit) and (Unit("player"):HasBuffs(A.UnholyFrenzyBuff.ID, true) > 0 or Pet:IsActive(27829) or (A.ArmyoftheDamned:IsSpellLearned() and Pet:IsActive(24207))) then
                return A.Berserking:Show(icon)
            end
			
	        -- lights_judgment,if=(buff.unholy_strength.up&buff.festermight.remains<=5)|active_enemies>=2&(buff.unholy_strength.up|buff.festermight.remains<=5)
            if A.LightsJudgment:IsReady(unit) and A.BurstIsON(unit) and ((Unit("player"):HasBuffs(A.UnholyStrengthBuff.ID, true) and Unit("player"):HasBuffs(A.FestermightBuff.ID, true) <= 5) or MultiUnits:GetByRange(20) >= 2 and (Unit("player"):HasBuffs(A.UnholyStrengthBuff.ID, true) or Unit("player"):HasBuffs(A.FestermightBuff.ID, true) <= 5)) then
                return A.LightsJudgment:Show(icon)
            end
			
            -- ancestral_call,if=(pet.gargoyle.active&talent.summon_gargoyle.enabled)|pet.apoc_ghoul.active
            if A.AncestralCall:AutoRacial(unit) and Action.GetToggle(1, "Racial") and A.BurstIsON(unit) and ((bool(Pet:IsActive(A.Gargoyle.ID)) and A.SummonGargoyle:IsSpellLearned()) or bool(Pet:IsActive(A.ApocGhoul.ID))) then
                return A.AncestralCall:Show(icon)
            end
			
            -- arcane_pulse,if=active_enemies>=2|(rune.deficit>=5&runic_power.deficit>=60)
            if A.ArcanePulse:AutoRacial(unit) and Action.GetToggle(1, "Racial") and (MultiUnits:GetByRange(20) >= 2 or (Player:RuneDeficit() >= 5 and Player:RunicPowerDeficit() >= 60)) then
                return A.ArcanePulse:Show(icon)
            end
			
            -- fireblood,if=(pet.gargoyle.active&talent.summon_gargoyle.enabled)|pet.apoc_ghoul.active
            if A.Fireblood:AutoRacial(unit) and Action.GetToggle(1, "Racial") and A.BurstIsON(unit) and ((Pet:IsActive(27829) and A.SummonGargoyle:IsSpellLearned()) or Pet:IsActive(24207)) then
                return A.Fireblood:Show(icon)
            end
			
            -- use_items,if=time>20|!equipped.ramping_amplitude_gigavolt_engine|!equipped.vision_of_demise
            -- use_item,name=azsharas_font_of_power,if=(essence.vision_of_perfection.enabled&!talent.unholy_frenzy.enabled)|(!essence.condensed_lifeforce.major&!essence.vision_of_perfection.enabled)
            if A.AzsharasFontofPower:IsReady(unit) and ((bool(A.VisionofPerfection:IsSpellLearned()) and not A.UnholyFrenzy:IsSpellLearned()) or (not bool(Azerite:EssenceHasMajor(A.CondensedLifeforce.ID)) and not bool(A.VisionofPerfection:IsSpellLearned()))) then
                return A.AzsharasFontofPower:Show(icon)
            end
			
	        -- use_item,name=azsharas_font_of_power,if=(essence.vision_of_perfection.enabled&!talent.unholy_frenzy.enabled)|(!essence.condensed_lifeforce.major&!essence.vision_of_perfection.enabled)
            if A.AzsharasFontofPower:IsReady(unit) and ((bool(A.VisionofPerfection:IsSpellLearned()) and not A.UnholyFrenzy:IsSpellLearned()) or (not bool(Azerite:EssenceHasMajor(A.CondensedLifeforce.ID)) and not bool(A.VisionofPerfection:IsSpellLearned()))) then
                return A.AzsharasFontofPower:Show(icon)
            end
			
            -- use_item,name=azsharas_font_of_power,if=cooldown.apocalypse.remains<14&(essence.condensed_lifeforce.major|essence.vision_of_perfection.enabled&talent.unholy_frenzy.enabled)
            if A.AzsharasFontofPower:IsReady(unit) and (A.Apocalypse:GetCooldown() < 14 and (bool(Azerite:EssenceHasMajor(A.CondensedLifeforce.ID)) or bool(A.VisionofPerfection:IsSpellLearned()) and A.UnholyFrenzy:IsSpellLearned())) then
                return A.AzsharasFontofPower:Show(icon)
            end
			
            -- use_item,name=azsharas_font_of_power,if=target.1.time_to_die<cooldown.apocalypse.remains+34
            if A.AzsharasFontofPower:IsReady(unit) and (Unit(unit):TimeToDie() < A.Apocalypse:GetCooldown() + 34) then
                return A.AzsharasFontofPower:Show(icon)
            end
			
            -- use_item,name=ashvanes_razor_coral,if=debuff.razor_coral_debuff.stack<1
            if A.AshvanesRazorCoral:IsReady(unit) and CanCast and (Unit(unit):HasDeBuffsStacks(A.RazorCoralDebuff.ID, true) < 1) then
                return A.AshvanesRazorCoral:Show(icon)
            end
			
            -- use_item,name=ashvanes_razor_coral,if=pet.guardian_of_azeroth.active&pet.apoc_ghoul.active
            if A.AshvanesRazorCoral:IsReady(unit) and CanCast and (GuardianofAzerothIsActive and Pet:IsActive(24207)) then
                return A.AshvanesRazorCoral:Show(icon)
            end
			
            -- use_item,name=ashvanes_razor_coral,if=cooldown.apocalypse.ready&(essence.condensed_lifeforce.major&Unit(unit):TimeToDie()<cooldown.condensed_lifeforce.remains+20|!essence.condensed_lifeforce.major)
            if A.AshvanesRazorCoral:IsReady(unit) and CanCast and (A.Apocalypse:GetCooldown() == 0 and (bool(Azerite:EssenceHasMajor(A.GuardianofAzeroth.ID)) and Unit(unit):TimeToDie() < A.GuardianofAzeroth:GetCooldown() + 20 or not bool(Azerite:EssenceHasMajor(A.GuardianofAzeroth.ID)))) then
                return A.AshvanesRazorCoral:Show(icon)
            end
			
            -- use_item,name=ashvanes_razor_coral,if=Unit(unit):TimeToDie()<cooldown.apocalypse.remains+20
            if A.AshvanesRazorCoral:IsReady(unit) and CanCast and (Unit(unit):TimeToDie() < A.Apocalypse:GetCooldown() + 20) then
                return A.AshvanesRazorCoral:Show(icon)
            end
			
            -- use_item,name=vision_of_demise,if=(cooldown.apocalypse.ready&debuff.festering_wound.stack>=4&essence.vision_of_perfection.enabled)|buff.unholy_frenzy.up|pet.gargoyle.active
            if A.VisionofDemise:IsReady(unit) and CanCast and ((A.Apocalypse:GetCooldown() == 0 and Unit(unit):HasDeBuffsStacks(A.FesteringWoundDebuff.ID, true) >= 4 and bool(Azerite:EssenceHasMajor(A.VisionofPerfection.ID))) or Unit("player"):HasBuffs(A.UnholyFrenzyBuff.ID, true) > 0 or Pet:IsActive(27829)) then
                return A.VisionofDemise:Show(icon)
            end
			
            -- use_item,name=ramping_amplitude_gigavolt_engine,if=cooldown.apocalypse.remains<2|talent.army_of_the_damned.enabled|raid_event.adds.in<5
            if A.RampingAmplitudeGigavoltEngine:IsReady(unit) and CanCast and (A.Apocalypse:GetCooldown() < 2 or A.ArmyoftheDamned:IsSpellLearned()) then
                return A.RampingAmplitudeGigavoltEngine:Show(icon)
            end
			
            -- use_item,name=bygone_bee_almanac,if=cooldown.summon_gargoyle.remains>60|!talent.summon_gargoyle.enabled&time>20|!equipped.ramping_amplitude_gigavolt_engine
            if A.BygoneBeeAlmanac:IsReady(unit) and CanCast and (A.SummonGargoyle:GetCooldown() > 60 or not A.SummonGargoyle:IsSpellLearned() and Unit("player"):CombatTime() > 20 or not A.RampingAmplitudeGigavoltEngine:IsExists()) then
                return A.BygoneBeeAlmanac:Show(icon)
            end
			
            -- use_item,name=jes_howler,if=pet.gargoyle.active|!talent.summon_gargoyle.enabled&time>20|!equipped.ramping_amplitude_gigavolt_engine
            if A.JesHowler:IsReady(unit) and CanCast and (Pet:IsActive(27829) or not A.SummonGargoyle:IsSpellLearned() and Unit("player"):CombatTime() > 20 or not A.RampingAmplitudeGigavoltEngine:IsExists()) then
                return A.JesHowler:Show(icon)
            end
			
            -- use_item,name=galecallers_beak,if=pet.gargoyle.active|!talent.summon_gargoyle.enabled&time>20|!equipped.ramping_amplitude_gigavolt_engine
            if A.GalecallersBeak:IsReady(unit) and CanCast and (Pet:IsActive(27829) or not A.SummonGargoyle:IsSpellLearned() and Unit("player"):CombatTime() > 20 or not A.RampingAmplitudeGigavoltEngine:IsExists()) then
                return A.GalecallersBeak:Show(icon)
            end
			
            -- use_item,name=grongs_primal_rage,if=rune<=3&(time>20|!equipped.ramping_amplitude_gigavolt_engine)
            if A.GrongsPrimalRage:IsReady(unit) and CanCast and (Player:Rune() <= 3 and (Unit("player"):CombatTime() > 20 or not A.RampingAmplitudeGigavoltEngine:IsExists())) then
                return A.GrongsPrimalRage:Show(icon)
            end
			
            -- potion,if=cooldown.army_of_the_dead.ready|pet.gargoyle.active|buff.unholy_frenzy.up
            if A.PotionofUnbridledFury:IsReady(unit) and CanCast and Action.GetToggle(1, "Potion") and (A.ArmyoftheDead:GetCooldown() == 0 or Pet:IsActive(27829) or Unit("player"):HasBuffs(A.UnholyFrenzyBuff.ID, true) > 0) then
                return A.PotionofUnbridledFury:Show(icon)
            end
			
            -- outbreak,target_if=dot.virulent_plague.remains<=gcd
            if A.Outbreak:IsReady(unit) and CanCast and Unit(unit):HasDeBuffs(A.VirulentPlagueDebuff.ID, true) <= 1 + (A.GetGCD() + A.GetCurrentGCD() + A.GetPing() + (TMW.UPD_INTV or 0) + ACTION_CONST_CACHE_DEFAULT_TIMER) then
                return A.Outbreak:Show(icon) 
            end
			
            -- use DeathStrike on low HP in Solo Mode
            if DeathStrikeHeal and CanCast and A.DeathStrike:IsReady(unit) then
                return A.DeathStrike:Show(icon) 
            end	
			
            -- call_action_list,name=essences
            if Essences(unit) then
                return true
            end
			
            -- call_action_list,name=cooldowns
            if Cooldowns(unit) and CanCast then
                return true
            end
			
            -- run_action_list,name=aoe,if=active_enemies>=2
            if (isMulti or A.GetToggle(2, "AoE")) and Aoe(unit) and (MultiUnits:GetByRange(25) >= 2) and CanCast then
               return true
            end
			
            -- call_action_list,name=generic
            if Generic(unit) and CanCast then
                return true
            end
			
        end
    end

    -- End on EnemyRotation()
    
	-- raise_dead
    if A.RaiseDead:IsReady("player") and not Pet:IsActive() then
        return A.RaiseDead:Show(icon)
    end
	
    -- Defensive
    local SelfDefensive = SelfDefensives()
    if SelfDefensive and CanCast then 
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
        if unit == "arena1" and (Unit("player"):GetDMG() == 0 or not Unit("player"):IsFocused("DAMAGER")) then 
            -- Reflect Casting BreakAble CC
            if A.NetherWard:IsReady() and A.NetherWard:IsSpellLearned() and Action.ShouldReflect(unit) and EnemyTeam():IsCastingBreakAble(0.25) then 
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

