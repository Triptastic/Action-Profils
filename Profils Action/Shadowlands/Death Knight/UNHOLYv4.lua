-------------------------------
-- Taste TMW Action Rotation --
-------------------------------
local _G, setmetatable							= _G, setmetatable
local A                         			    = _G.Action
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
local IsIndoors, UnitIsUnit                     = IsIndoors, UnitIsUnit
local TR                                        = Action.TasteRotation
local pairs                                     = pairs
local Pet                                       = LibStub("PetLibrary")
local next, pairs, type, print                  = next, pairs, type, print

--- ============================ CONTENT ===========================
--- ======= APL LOCALS =======
-- luacheck: max_line_length 9999
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
	DeathandDecayBuff                      = Action.Create({ Type = "Spell", ID = 188290, Hidden = true }),
    Apocalypse                             = Action.Create({ Type = "Spell", ID = 275699 }),
    Defile                                 = Action.Create({ Type = "Spell", ID = 152280 }),
    DeathStrike                            = Action.Create({ Type = "Spell", ID = 49998     }),
    Epidemic                               = Action.Create({ Type = "Spell", ID = 207317 }),
    DeathCoil                              = Action.Create({ Type = "Spell", ID = 47541 }),
    ScourgeStrike                          = Action.Create({ Type = "Spell", ID = 55090 }),
    ClawingShadows                         = Action.Create({ Type = "Spell", ID = 207311 }),
    FesteringStrike                        = Action.Create({ Type = "Spell", ID = 85948 }),
    FesteringWoundDebuff                   = Action.Create({ Type = "Spell", ID = 194310, Hidden = true }),
    BurstingSores                          = Action.Create({ Type = "Spell", ID = 207264 }),
    SuddenDoomBuff                         = Action.Create({ Type = "Spell", ID = 81340, Hidden = true }),
    UnholyFrenzyBuff                       = Action.Create({ Type = "Spell", ID = 207289, Hidden = true }),
    DarkTransformation                     = Action.Create({ Type = "Spell", ID = 63560 }),
    SummonGargoyle                         = Action.Create({ Type = "Spell", ID = 49206 }),
	Gargoyle                               = Action.Create({ Type = "Spell", ID = 27829 , Hidden = true     }),
    UnholyFrenzy                           = Action.Create({ Type = "Spell", ID = 207289 }),
    MagusoftheDead                         = Action.Create({ Type = "Spell", ID = 288417 }),
    SoulReaper                             = Action.Create({ Type = "Spell", ID = 130736 }),
    UnholyBlight                           = Action.Create({ Type = "Spell", ID = 115989 }),
    Pestilence                             = Action.Create({ Type = "Spell", ID = 277234 }),
    ArmyoftheDamned                        = Action.Create({ Type = "Spell", ID = 276837 }),
    Outbreak                               = Action.Create({ Type = "Spell", ID = 77575 }),
    VirulentPlagueDebuff                   = Action.Create({ Type = "Spell", ID = 191587, Hidden = true }),
    Icecap                                 = Action.Create({ Type = "Spell", ID = 207126 }),
    NecroticStrike                         = Action.Create({ Type = "Spell", ID = 223829     }),	 -- PvP
    NecroticStrikeDebuff                   = Action.Create({ Type = "Spell", ID = 223929, Hidden = true     }),	 -- PvP
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
    -- Potions
    PotionofUnbridledFury                  = Action.Create({ Type = "Potion", ID = 169299, QueueForbidden = true }), 
    BattlePotionOfAgility                  = Action.Create({ Type = "Potion", ID = 163223, QueueForbidden = true }),  
    SuperiorPotionofUnbridledFury          = Action.Create({ Type = "Potion", ID = 168489, QueueForbidden = true }), 
	SuperiorSteelskinPotion                = Action.Create({ Type = "Potion", ID = 168501, QueueForbidden = true }), 
	AbyssalHealingPotion                   = Action.Create({ Type = "Potion", ID = 169451, QueueForbidden = true }),     
	PotionofFocusedResolve                 = Action.Create({ Type = "Potion", ID = 168506 }),
	SuperiorBattlePotionofStrength         = Action.Create({ Type = "Potion", ID = 168500 }),
	PotionofEmpoweredProximity             = Action.Create({ Type = "Potion", ID = 168529 }),
    -- Trinkets
    AzsharasFontofPower                    = Action.Create({ Type = "Trinket", ID = 169314 }),
    PocketsizedComputationDevice           = Action.Create({ Type = "Trinket", ID = 167555 }),
    RotcrustedVoodooDoll                   = Action.Create({ Type = "Trinket", ID = 159624 }),
    ShiverVenomRelic                       = Action.Create({ Type = "Trinket", ID = 168905 }),
    AquipotentNautilus                     = Action.Create({ Type = "Trinket", ID = 169305 }),
    TidestormCodex                         = Action.Create({ Type = "Trinket", ID = 165576 }),
    VialofStorms                           = Action.Create({ Type = "Trinket", ID = 158224 }),
    GalecallersBoon                        = Action.Create({ Type = "Trinket", ID = 159614 }),
    InvocationOfYulon                      = Action.Create({ Type = "Trinket", ID = 165568 }),
    LustrousGoldenPlumage                  = Action.Create({ Type = "Trinket", ID = 159617 }),
    LurkersInsidiousGift                   = Action.Create({ Type = "Trinket", ID = 167866 }),
    VigorTrinket                           = Action.Create({ Type = "Trinket", ID = 165572 }),
    AshvanesRazorCoral                     = Action.Create({ Type = "Trinket", ID = 169311 }),
    MalformedHeraldsLegwraps               = Action.Create({ Type = "Trinket", ID = 167835 }),
    HyperthreadWristwraps                  = Action.Create({ Type = "Trinket", ID = 168989 }),
    NotoriousAspirantsBadge                = Action.Create({ Type = "Trinket", ID = 167528 }),
    NotoriousGladiatorsBadge               = Action.Create({ Type = "Trinket", ID = 167380 }),
    SinisterGladiatorsBadge                = Action.Create({ Type = "Trinket", ID = 165058 }),
    SinisterAspirantsBadge                 = Action.Create({ Type = "Trinket", ID = 165223 }),
    DreadGladiatorsBadge                   = Action.Create({ Type = "Trinket", ID = 161902 }),
    DreadAspirantsBadge                    = Action.Create({ Type = "Trinket", ID = 162966 }),
    DreadCombatantsInsignia                = Action.Create({ Type = "Trinket", ID = 161676 }),
    NotoriousAspirantsMedallion            = Action.Create({ Type = "Trinket", ID = 167525 }),
    NotoriousGladiatorsMedallion           = Action.Create({ Type = "Trinket", ID = 167377 }),
    SinisterGladiatorsMedallion            = Action.Create({ Type = "Trinket", ID = 165055 }),
    SinisterAspirantsMedallion             = Action.Create({ Type = "Trinket", ID = 165220 }),
    DreadGladiatorsMedallion               = Action.Create({ Type = "Trinket", ID = 161674 }),
    DreadAspirantsMedallion                = Action.Create({ Type = "Trinket", ID = 162897 }),
    DreadCombatantsMedallion               = Action.Create({ Type = "Trinket", ID = 161811 }),
    IgnitionMagesFuse                      = Action.Create({ Type = "Trinket", ID = 159615 }),
    TzanesBarkspines                       = Action.Create({ Type = "Trinket", ID = 161411 }),
    AzurethosSingedPlumage                 = Action.Create({ Type = "Trinket", ID = 161377 }),
    AncientKnotofWisdomAlliance            = Action.Create({ Type = "Trinket", ID = 161417 }),
    AncientKnotofWisdomHorde               = Action.Create({ Type = "Trinket", ID = 166793 }),
    ShockbitersFang                        = Action.Create({ Type = "Trinket", ID = 169318 }),
    NeuralSynapseEnhancer                  = Action.Create({ Type = "Trinket", ID = 168973 }),
    BalefireBranch                         = Action.Create({ Type = "Trinket", ID = 159630 }),
	GrongsPrimalRage                       = Action.Create({ Type = "Trinket", ID = 165574 }),
	BygoneBeeAlmanac                       = Action.Create({ Type = "Trinket", ID = 163936 }),
	RampingAmplitudeGigavoltEngine         = Action.Create({ Type = "Trinket", ID = 165580 }),
	VisionofDemise                         = Action.Create({ Type = "Trinket", ID = 169307 }),
	JesHowler                              = Action.Create({ Type = "Trinket", ID = 159627 }),
	GalecallersBeak                        = Action.Create({ Type = "Trinket", ID = 161379 }),
    DribblingInkpod                        = Action.Create({ Type = "Trinket", ID = 169319 }),
    MerekthasFang                          = Action.Create({ Type = "Trinket", ID = 158367 }),	
	GrongsPrimalRage                       = Action.Create({ Type = "Trinket", ID = 165574 }),
	BygoneBeeAlmanac                       = Action.Create({ Type = "Trinket", ID = 163936 }),
	RampingAmplitudeGigavoltEngine         = Action.Create({ Type = "Trinket", ID = 165580 }),
	VisionofDemise                         = Action.Create({ Type = "Trinket", ID = 169307 }),
	JesHowler                              = Action.Create({ Type = "Trinket", ID = 159627 }),
	GalecallersBeak                        = Action.Create({ Type = "Trinket", ID = 161379 }),
    DribblingInkpod                        = Action.Create({ Type = "Trinket", ID = 169319 }),
    RazdunksBigRedButton                   = Action.Create({ Type = "Trinket", ID = 159611 }),
    MerekthasFang                          = Action.Create({ Type = "Trinket", ID = 158367 }),
    KnotofAncientFuryAlliance              = Action.Create({ Type = "Trinket", ID = 161413 }),
    KnotofAncientFuryHorde                 = Action.Create({ Type = "Trinket", ID = 166795 }),
    FirstMatesSpyglass                     = Action.Create({ Type = "Trinket", ID = 158163 }),
    VialofAnimatedBlood                    = Action.Create({ Type = "Trinket", ID = 159625 }),
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
    RecklessForceBuff                      = Action.Create({ Type = "Spell", ID = 302932, Hidden = true     }),	 
    PoolResource                           = Action.Create({ Type = "Spell", ID = 209274, Hidden = true     }),
	DummyTest                              = Action.Create({ Type = "Spell", ID = 159999, Hidden = true     }), -- Dummy stop dps icon
};

-- To create essences use next code:
Action:CreateEssencesFor(ACTION_CONST_DEATHKNIGHT_UNHOLY)  -- where PLAYERSPEC is Constance (example: ACTION_CONST_MONK_BM)
local A = setmetatable(Action[ACTION_CONST_DEATHKNIGHT_UNHOLY], { __index = Action })

------------------------------------------
---------------- VARIABLES ---------------
------------------------------------------


local function num(val)
    if val then return 1 else return 0 end
end

local function bool(val)
    return val ~= 0
end

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

local IsIndoors, UnitIsUnit, UnitName = IsIndoors, UnitIsUnit, UnitName
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


local CanCast = true

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
    local Pull = Action.BossMods:GetPullTimer()
    local GuardianofAzerothIsActive = GuardianofAzerothIsActive()
    local DeathStrikeHeal = DeathStrikeHeal()
	local DBM = GetToggle(1 ,"DBM")
	local Potion = GetToggle(1, "Potion")
	local Racial = GetToggle(1, "Racial")
	local HeartOfAzeroth = GetToggle(1, "HeartOfAzeroth")
	local AutoSwitchFesteringStrike = GetToggle(2, "AutoSwitchFesteringStrike")
	local MinRuneSoulReaper = GetToggle(2, "MinRuneSoulReaper")
	local MinFesteringWoundSoulReaper = GetToggle(2, "MinFesteringWoundSoulReaper")
	local MinAoETargets = GetToggle(2, "MinAoETargets")
	local MaxAoERange = GetToggle(2, "MaxAoERange")
	
	
	local MinRuneDeathandDecay = GetToggle(2, "MinRuneDeathandDecay")
	local MinAreaTTDDeathandDecay = GetToggle(2, "MinAreaTTDDeathandDecay")
	local DeathandDecayIgnoreFesteringWoundUnits = GetToggle(2, "DeathandDecayIgnoreFesteringWoundUnits")
	local MinFesteringWoundDeathandDecay = GetToggle(2, "MinFesteringWoundDeathandDecay")
	local BloodoftheEnemySyncAoE = GetToggle(2, "BloodoftheEnemySyncAoE")
	local BloodoftheEnemyAoETTD = GetToggle(2, "BloodoftheEnemyAoETTD")
	local BloodoftheEnemyUnits = GetToggle(2, "BloodoftheEnemyUnits")
	local ChainsofIceRange = GetToggle(2, "ChainsofIceRange")
	local UseChainsofIce = GetToggle(2, "UseChainsofIce")
	local DeathGripLowHealth = GetToggle(2, "DeathGripLowHealth")
	local DeathGripInterrupt = GetToggle(2, "DeathGripInterrupt")
	local UseDeathGrip = GetToggle(2, "UseDeathGrip")
	local DeathGripHealthPercent = GetToggle(2, "DeathGripHealthPercent")
	-- Trinkets vars
    local Trinket1IsAllowed, Trinket2IsAllowed = TR:TrinketIsAllowed()
	local TrinketsAoE = GetToggle(2, "TrinketsAoE")
	local TrinketsMinTTD = GetToggle(2, "TrinketsMinTTD")
	local TrinketsUnitsRange = GetToggle(2, "TrinketsUnitsRange")
	local TrinketsMinUnits = GetToggle(2, "TrinketsMinUnits")
	local profileStop = false
	
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


	------------------------------------
	---------- DUMMY DPS TEST ----------
	------------------------------------
	local DummyTime = GetToggle(2, "DummyTime")
	if DummyTime > 0 then
    	local unit = "target"
		local endtimer = 0
		
    	if Unit(unit):IsExists() and Unit(unit):IsDummy() then
        	if Unit(player):CombatTime() >= (DummyTime * 60) then
            	StopAttack()
				endtimer = TMW.time
            	--ClearTarget() -- Protected ? 
	       	    -- Notification					
          	    Action.SendNotification(DummyTime .. " Minutes Dummy Test Concluded - Profile Stopped", A.DummyTest.ID)			
         	    
				if endtimer < TMW.time + 5 then
				    profileStop = true
				    --return A.DummyTest:Show(icon)
				end
    	    end
  	    end
	end	
	-- Mounted
	if Player:IsMounted() then
	    profileStop = true
	end
    ------------------------------------------------------
    ---------------- ENEMY UNIT ROTATION -----------------
    ------------------------------------------------------
    local function EnemyRotation(unit)
                
        --Essences
        local function Essences(unit)
		
            -- memory_of_lucid_dreams,if=rune.time_to_1>gcd&runic_power<40
            if A.MemoryofLucidDreams:AutoHeartOfAzerothP(unit, true) and BurstIsON(unit) and HeartOfAzeroth and (Player:RuneTimeToX(1) > A.GetGCD() and Player:RunicPower() < 40) then
                return A.MemoryofLucidDreams:Show(icon)
            end
			
			-- reaping_flames
            if A.ReapingFlames:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth then
                return A.ReapingFlames:Show(icon)
            end
			
			-- moment_of_glory
            if A.MomentofGlory:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth then
                return A.MomentofGlory:Show(icon)
            end

			-- ReplicaofKnowledge
            if A.ReplicaofKnowledge:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth then
                return A.ReplicaofKnowledge:Show(icon)
            end				
			
            -- blood_of_the_enemy,if=(cooldown.death_and_decay.remains&spell_targets.death_and_decay>1)|(cooldown.defile.remains&spell_targets.defile>1)|(cooldown.apocalypse.remains&cooldown.death_and_decay.ready)
            if A.BloodoftheEnemy:AutoHeartOfAzerothP(unit, true) and not BloodoftheEnemySyncAoE and BurstIsON(unit) and HeartOfAzeroth and 
			(
			    (A.DeathandDecay:GetCooldown() > 0 and GetByRange(1, 30)) 
				or 
				(A.Defile:GetCooldown() > 0 and GetByRange(1, 8)) 
				or 
				(A.Apocalypse:GetCooldown() > 0 and A.DeathandDecay:GetCooldown() == 0)
			)
			then
                return A.BloodoftheEnemy:Show(icon)
            end
			
            -- guardian_of_azeroth,if=(cooldown.apocalypse.remains<6&cooldown.army_of_the_dead.remains>cooldown.condensed_lifeforce.remains)|cooldown.army_of_the_dead.remains<2
            if A.GuardianofAzeroth:AutoHeartOfAzerothP(unit, true) and BurstIsON(unit) and HeartOfAzeroth and (A.Apocalypse:GetCooldown() < 6) then
                return A.GuardianofAzeroth:Show(icon)
            end
			
            -- the_unbound_force,if=buff.reckless_force.up|buff.reckless_force_counter.stack<11
            if A.TheUnboundForce:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and (Unit(player):HasBuffs(A.RecklessForceBuff.ID, true) > 0 or Unit(player):HasBuffsStacks(A.RecklessForceCounterBuff.ID, true) < 11) then
                return A.TheUnboundForce:Show(icon)
            end
			
            -- focused_azerite_beam,if=!death_and_decay.ticking
            if A.FocusedAzeriteBeam:AutoHeartOfAzerothP(unit, true) and BurstIsON(unit) and HeartOfAzeroth then
                return A.FocusedAzeriteBeam:Show(icon)
            end
			
            -- concentrated_flame,if=dot.concentrated_flame_burn.remains=0
            if A.ConcentratedFlame:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth then
                return A.ConcentratedFlame:Show(icon)
            end
			
            -- purifying_blast,if=!death_and_decay.ticking
            if A.PurifyingBlast:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth then
                return A.PurifyingBlast:Show(icon)
            end
			
            -- worldvein_resonance,if=!death_and_decay.ticking
            if A.WorldveinResonance:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth then
                return A.WorldveinResonance:Show(icon)
            end
			
            -- ripple_in_space,if=!death_and_decay.ticking
            if A.RippleinSpace:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth then
                return A.RippleinSpace:Show(icon)
            end
        end
        Essences = A.MakeFunctionCachedDynamic(Essences)  
		
        --Precombat
        if combatTime == 0 and not profileStop and Unit(unit):IsExists() and unit ~= "mouseover" then
            -- flask
            -- food
            -- augmentation
            -- snapshot_stats
			
            -- potion
            if A.PotionofUnbridledFury:IsReady(unit) and Potion 
			and (Pull > 0 and Pull <= 2 or not DBM)
			then
                return A.PotionofUnbridledFury:Show(icon)
            end
			
            -- raise_dead
            if A.RaiseDead:IsReady(player) and not Pet:IsActive() then
                return A.RaiseDead:Show(icon)
            end
			
            -- use_item,name=azsharas_font_of_power
            if A.AzsharasFontofPower:IsReady(player)
			and (Pull > 0 and Pull <= 6 or not DBM)
			then
                return A.AzsharasFontofPower:Show(icon)
            end
			
            -- army_of_the_dead,delay=2
            if A.ArmyoftheDead:IsReady(unit) and BurstIsON(unit) 
			and (Pull > 0 and Pull <= 3 or not DBM)
			then
                return A.ArmyoftheDead:Show(icon)
            end
			
            -- army_of_the_dead,delay=2
            if A.FesteringStrike:IsReady(unit)
            and (Pull > 0 and Pull <= 1 or not DBM)			
			then
                return A.FesteringStrike:Show(icon)
            end
        end

		-- Burst Phase
		if unit ~= "mouseover" and BurstIsON(unit) and inCombat and not profileStop then
		
            -- army_of_the_dead
            if A.ArmyoftheDead:IsReady(unit) then
                return A.ArmyoftheDead:Show(icon)
            end
						
            -- summon_gargoyle,if=runic_power.deficit<14
            if A.SummonGargoyle:IsReady(player) and Player:RunicPowerDeficit() < 14 and BurstIsON(unit) then
                return A.SummonGargoyle:Show(icon)
            end
			
            -- unholy_frenzy,if=essence.vision_of_perfection.enabled|(essence.condensed_lifeforce.enabled&pet.apoc_ghoul.active)|debuff.festering_wound.stack<4&!(equipped.ramping_amplitude_gigavolt_engine|azerite.magus_of_the_dead.enabled)|cooldown.apocalypse.remains<2&(equipped.ramping_amplitude_gigavolt_engine|azerite.magus_of_the_dead.enabled)
            if A.UnholyFrenzy:IsReady(player) and BurstIsON(unit) and A.DarkTransformation:GetCooldown() > 0 and 
			(
			    Azerite:EssenceHasMajor(A.VisionofPerfection.ID) 
				or 
				(A.GuardianofAzeroth:GetAzeriteRank() > 0 and Pet:IsActive(24207)) 
				or 
				Unit(unit):HasDeBuffsStacks(A.FesteringWoundDebuff.ID, true) < 4 and not (A.RampingAmplitudeGigavoltEngine:IsExists() or A.MagusoftheDead:GetAzeriteRank() > 0) 
				or 
				A.Apocalypse:GetCooldown() < 2 and (A.RampingAmplitudeGigavoltEngine:IsExists()	or A.MagusoftheDead:GetAzeriteRank() > 0)
			)
			then
                return A.UnholyFrenzy:Show(icon)
            end
			
            -- unholy_frenzy,if=active_enemies>=2&((cooldown.death_and_decay.remains<=gcd&!talent.defile.enabled)|(cooldown.defile.remains<=gcd&talent.defile.enabled))
            if A.UnholyFrenzy:IsReady(player) and BurstIsON(unit) and A.DarkTransformation:GetCooldown() > 0 and 
			(
			    GetByRange(2, 8) and 
				(
				    (A.DeathandDecay:GetCooldown() <= A.GetGCD() and not A.Defile:IsSpellLearned()) 
					or 
					(A.Defile:GetCooldown() <= A.GetGCD() and A.Defile:IsSpellLearned())
				)
			)
			then
                return A.UnholyFrenzy:Show(icon)
            end
			
        end    
    
        -- In Combat
        if not profileStop and inCombat and CanCast and unit ~= "mouseover" then
		
            -- variable,name=pooling_for_gargoyle,value=cooldown.summon_gargoyle.remains<5&talent.summon_gargoyle.enabled
			local VarPoolingForGargoyle = A.SummonGargoyle:GetCooldown() < 5 and A.SummonGargoyle:IsSpellLearned()
			
			-- Interrupt
            local Interrupt = Interrupts(unit)
            if Interrupt then 
                return Interrupt:Show(icon)
            end	
			
            -- apocalypse,if=debuff.festering_wound.stack>=4
            if A.Apocalypse:IsReady(unit) and Unit(unit):HasDeBuffsStacks(A.FesteringWoundDebuff.ID, true) >= 4 and A.BurstIsON(unit) then
                return A.Apocalypse:Show(icon)
            end
			
            -- dark_transformation,if=!raid_event.adds.exists|raid_event.adds.in>15
            if A.DarkTransformation:IsReady(player) and Unit(unit):HasDeBuffs(A.VirulentPlagueDebuff.ID, true) > 0 then
                return A.DarkTransformation:Show(icon)
            end		
			
            -- soul_reaper,target_if=target.time_to_die<8&target.time_to_die>4
            if A.SoulReaper:IsReady(player) and Unit(unit):TimeToDie() < 8 and Unit(unit):TimeToDie() > 4 then
                return A.SoulReaper:Show(icon) 
            end
			
            -- soul_reaper,if=(!raid_event.adds.exists|raid_event.adds.in>20)&rune<=(1-buff.unholy_frenzy.up)
            if A.SoulReaper:IsReady(player) and Player:Rune() <= 2 then
                return A.SoulReaper:Show(icon)
            end
			
			-- necrotic strike pvp
			if A.IsInPvP and A.NecroticStrike:IsReady(unit) and A.NecroticStrike:IsSpellLearned() and Unit(unit):HasDeBuffsStacks(A.FesteringWoundDebuff.ID, true) > 0 and 
			(
			    Unit(unit):HasDeBuffs(A.NecroticStrikeDebuff.ID, true) <= 2 
				or
				A.Zone == "arena" and Unit(unit):HealthPercent() <= 30
			)
			then
			    return A.NecroticStrike:Show(icon)
			end
			
            -- unholy_blight
            if A.UnholyBlight:IsReady(unit) then
                return A.UnholyBlight:Show(icon)
            end	
			
			-- auto_attack
			-- Chains of Ice
			if (Unit(unit):IsMovingOut() or Unit(unit):GetRange() > ChainsofIceRange) and CanCast and UseChainsofIce and A.ChainsofIce:IsReady(unit) and Unit(unit):HasDeBuffs(A.ChainsofIce.ID, true) == 0 then
			    return A.ChainsofIce:Show(icon) 
			end
			
			-- Death Grip
			if Unit(unit):CombatTime() > 0 and CanCast and UseDeathGrip and A.DeathGrip:IsReady(unit) and Unit(unit):GetRange() > 8 and Unit(unit):GetRange() <= 30 and
			(
				(
				    A.IsInPvP and 
					(
					    Unit(unit):IsMovingOut() 
					    or
					    DeathGripLowHealth and Unit(unit):HealthPercent() < DeathGripHealthPercent
					)
				)
				or
				not A.IsInPvP and Unit(unit):TimeToDie() > 3 and not Unit(unit):IsBoss()
			)
			then
			    return A.DeathGrip:Show(icon) 
			end
			
			-- Wraith Walk if out of range 
            if A.WraithWalk:IsReady(player) and CanCast and isMovingFor > GetToggle(2, "WraithWalkTime") and GetToggle(2, "UseWraithWalk") 
			then
			    -- Avoid to stay in WraithWalk when our target is reached
			    if Unit(unit):GetRange() <= 5 and Unit(player):HasBuffs(A.WraithWalk.ID, true) > 0 then
				    Player:CancelBuff(A.WraithWalk:Info())
				end
                return A.WraithWalk:Show(icon)
            end
			
			-- Deaths Advance if out of range 
            if A.DeathsAdvance:IsReady(player) and CanCast and isMovingFor > GetToggle(2, "DeathsAdvanceTime") and GetToggle(2, "UseDeathsAdvance") then
                return A.DeathsAdvance:Show(icon)
            end			
		
            -- arcane_torrent,if=runic_power.deficit>65&(pet.gargoyle.active|!talent.summon_gargoyle.enabled)&rune.deficit>=5
            if A.ArcaneTorrent:IsRacialReady(unit) and CanCast and Racial and BurstIsON(unit) and (Player:RunicPowerDeficit() > 65 and (Pet:IsActive(27829) or not A.SummonGargoyle:IsSpellLearned()) and Player:Rune() <= 1) then
                return A.ArcaneTorrent:Show(icon)
            end
			
            -- bag_of_tricks
            if A.BagofTricks:AutoRacial(unit) and Racial and BurstIsON(unit) then
                return A.BagofTricks:Show(icon)
            end		
			
            -- blood_fury,if=pet.gargoyle.active|!talent.summon_gargoyle.enabled
            if A.BloodFury:AutoRacial(unit) and CanCast and Racial and BurstIsON(unit) and (Pet:IsActive(27829) or not A.SummonGargoyle:IsSpellLearned()) then
                return A.BloodFury:Show(icon)
            end
			
            -- berserking,if=buff.unholy_frenzy.up|pet.gargoyle.active|(talent.army_of_the_damned.enabled&pet.apoc_ghoul.active)
            if A.Berserking:AutoRacial(unit) and CanCast and Racial and BurstIsON(unit) and (Unit(player):HasBuffs(A.UnholyFrenzyBuff.ID, true) > 0 or Pet:IsActive(27829) or (A.ArmyoftheDamned:IsSpellLearned() and Pet:IsActive(24207))) then
                return A.Berserking:Show(icon)
            end
			
	        -- lights_judgment,if=(buff.unholy_strength.up&buff.festermight.remains<=5)|active_enemies>=2&(buff.unholy_strength.up|buff.festermight.remains<=5)
            if A.LightsJudgment:IsReady(unit) and BurstIsON(unit) and ((Unit(player):HasBuffs(A.UnholyStrengthBuff.ID, true) > 0 and Unit(player):HasBuffs(A.FestermightBuff.ID, true) <= 5) or GetByRange(2, 20) and (Unit(player):HasBuffs(A.UnholyStrengthBuff.ID, true) or Unit(player):HasBuffs(A.FestermightBuff.ID, true) <= 5)) then
                return A.LightsJudgment:Show(icon)
            end
			
            -- ancestral_call,if=(pet.gargoyle.active&talent.summon_gargoyle.enabled)|pet.apoc_ghoul.active
            if A.AncestralCall:AutoRacial(unit) and Racial and BurstIsON(unit) and ((Pet:IsActive(A.Gargoyle.ID) and A.SummonGargoyle:IsSpellLearned()) or Pet:IsActive(A.ApocGhoul.ID)) then
                return A.AncestralCall:Show(icon)
            end
			
            -- arcane_pulse,if=active_enemies>=2|(rune.deficit>=5&runic_power.deficit>=60)
            if A.ArcanePulse:AutoRacial(unit) and Racial and (GetByRange(2, 20) or (Player:RuneDeficit() >= 5 and Player:RunicPowerDeficit() >= 60)) then
                return A.ArcanePulse:Show(icon)
            end
			
            -- fireblood,if=(pet.gargoyle.active&talent.summon_gargoyle.enabled)|pet.apoc_ghoul.active
            if A.Fireblood:AutoRacial(unit) and Racial and BurstIsON(unit) and ((Pet:IsActive(27829) and A.SummonGargoyle:IsSpellLearned()) or Pet:IsActive(24207)) then
                return A.Fireblood:Show(icon)
            end
			
            -- use_items,if=time>20|!equipped.ramping_amplitude_gigavolt_engine|!equipped.vision_of_demise
            -- use_item,name=azsharas_font_of_power,if=(essence.vision_of_perfection.enabled&!talent.unholy_frenzy.enabled)|(!essence.condensed_lifeforce.major&!essence.vision_of_perfection.enabled)
            if A.AzsharasFontofPower:IsReady(player) and ((A.VisionofPerfection:GetAzeriteRank() > 0 and not A.UnholyFrenzy:IsSpellLearned()) or (not Azerite:EssenceHasMajor(A.GuardianofAzeroth.ID) and A.VisionofPerfection:GetAzeriteRank() == 0)) then
                return A.AzsharasFontofPower:Show(icon)
            end
			
	        -- use_item,name=azsharas_font_of_power,if=(essence.vision_of_perfection.enabled&!talent.unholy_frenzy.enabled)|(!essence.condensed_lifeforce.major&!essence.vision_of_perfection.enabled)
            if A.AzsharasFontofPower:IsReady(player) and ((A.VisionofPerfection:GetAzeriteRank() > 0 and not A.UnholyFrenzy:IsSpellLearned()) or (not Azerite:EssenceHasMajor(A.GuardianofAzeroth.ID) and A.VisionofPerfection:GetAzeriteRank() == 0)) then
                return A.AzsharasFontofPower:Show(icon)
            end
			
            -- use_item,name=azsharas_font_of_power,if=cooldown.apocalypse.remains<14&(essence.condensed_lifeforce.major|essence.vision_of_perfection.enabled&talent.unholy_frenzy.enabled)
            if A.AzsharasFontofPower:IsReady(player) and (A.Apocalypse:GetCooldown() < 14 and (Azerite:EssenceHasMajor(A.GuardianofAzeroth.ID) or A.VisionofPerfection:GetAzeriteRank() > 0 and A.UnholyFrenzy:IsSpellLearned())) then
                return A.AzsharasFontofPower:Show(icon)
            end
			
            -- use_item,name=azsharas_font_of_power,if=target.1.time_to_die<cooldown.apocalypse.remains+34
            if A.AzsharasFontofPower:IsReady(player) and (Unit(unit):TimeToDie() < A.Apocalypse:GetCooldown() + 34) then
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
            if A.AshvanesRazorCoral:IsReady(unit) and CanCast and (A.Apocalypse:GetCooldown() == 0 and (Azerite:EssenceHasMajor(A.GuardianofAzeroth.ID) and Unit(unit):TimeToDie() < A.GuardianofAzeroth:GetCooldown() + 20 or not Azerite:EssenceHasMajor(A.GuardianofAzeroth.ID))) then
                return A.AshvanesRazorCoral:Show(icon)
            end
			
            -- use_item,name=ashvanes_razor_coral,if=Unit(unit):TimeToDie()<cooldown.apocalypse.remains+20
            if A.AshvanesRazorCoral:IsReady(unit) and CanCast and (Unit(unit):TimeToDie() < A.Apocalypse:GetCooldown() + 20) then
                return A.AshvanesRazorCoral:Show(icon)
            end
			
            -- use_item,name=vision_of_demise,if=(cooldown.apocalypse.ready&debuff.festering_wound.stack>=4&essence.vision_of_perfection.enabled)|buff.unholy_frenzy.up|pet.gargoyle.active
            if A.VisionofDemise:IsReady(unit) and CanCast and ((A.Apocalypse:GetCooldown() == 0 and Unit(unit):HasDeBuffsStacks(A.FesteringWoundDebuff.ID, true) >= 4 and Azerite:EssenceHasMajor(A.VisionofPerfection.ID)) or Unit(player):HasBuffs(A.UnholyFrenzyBuff.ID, true) > 0 or Pet:IsActive(27829)) then
                return A.VisionofDemise:Show(icon)
            end
			
            -- use_item,name=ramping_amplitude_gigavolt_engine,if=cooldown.apocalypse.remains<2|talent.army_of_the_damned.enabled|raid_event.adds.in<5
            if A.RampingAmplitudeGigavoltEngine:IsReady(unit) and CanCast and (A.Apocalypse:GetCooldown() < 2 or A.ArmyoftheDamned:IsSpellLearned()) then
                return A.RampingAmplitudeGigavoltEngine:Show(icon)
            end
			
            -- use_item,name=bygone_bee_almanac,if=cooldown.summon_gargoyle.remains>60|!talent.summon_gargoyle.enabled&time>20|!equipped.ramping_amplitude_gigavolt_engine
            if A.BygoneBeeAlmanac:IsReady(unit) and CanCast and (A.SummonGargoyle:GetCooldown() > 60 or not A.SummonGargoyle:IsSpellLearned() and Unit(player):CombatTime() > 20 or not A.RampingAmplitudeGigavoltEngine:IsExists()) then
                return A.BygoneBeeAlmanac:Show(icon)
            end
			
            -- use_item,name=jes_howler,if=pet.gargoyle.active|!talent.summon_gargoyle.enabled&time>20|!equipped.ramping_amplitude_gigavolt_engine
            if A.JesHowler:IsReady(unit) and CanCast and (Pet:IsActive(27829) or not A.SummonGargoyle:IsSpellLearned() and Unit(player):CombatTime() > 20 or not A.RampingAmplitudeGigavoltEngine:IsExists()) then
                return A.JesHowler:Show(icon)
            end
			
            -- use_item,name=galecallers_beak,if=pet.gargoyle.active|!talent.summon_gargoyle.enabled&time>20|!equipped.ramping_amplitude_gigavolt_engine
            if A.GalecallersBeak:IsReady(unit) and CanCast and (Pet:IsActive(27829) or not A.SummonGargoyle:IsSpellLearned() and Unit(player):CombatTime() > 20 or not A.RampingAmplitudeGigavoltEngine:IsExists()) then
                return A.GalecallersBeak:Show(icon)
            end
			
            -- use_item,name=grongs_primal_rage,if=rune<=3&(time>20|!equipped.ramping_amplitude_gigavolt_engine)
            if A.GrongsPrimalRage:IsReady(unit) and CanCast and (Player:Rune() <= 3 and (Unit(player):CombatTime() > 20 or not A.RampingAmplitudeGigavoltEngine:IsExists())) then
                return A.GrongsPrimalRage:Show(icon)
            end
			
	    	-- Non SIMC Custom Trinket1
	        if A.Trinket1:IsReady(unit) and Trinket1IsAllowed and CanCast and    
			(
    			TrinketsAoE and GetByRange(TrinketsMinUnits, TrinketsUnitsRange) and Player:AreaTTD(TrinketsUnitsRange) > TrinketsMinTTD
				or
				not TrinketsAoE and Unit(unit):TimeToDie() >= TrinketsMinTTD 					
			)
			then 
      	        return A.Trinket1:Show(icon)
   	        end 		
	        
		
		    -- Non SIMC Custom Trinket2
	        if A.Trinket2:IsReady(unit) and Trinket2IsAllowed and CanCast and	    
			(
    			TrinketsAoE and GetByRange(TrinketsMinUnits, TrinketsUnitsRange) and Player:AreaTTD(TrinketsUnitsRange) > TrinketsMinTTD
				or
				not TrinketsAoE and Unit(unit):TimeToDie() >= TrinketsMinTTD 					
			)
			then
      	       	return A.Trinket2:Show(icon) 	
	        end
			
            -- Defensives trinkets
            if Unit(player):CombatTime() > 0 and (Unit(player):HealthPercent() < 50 or Unit(player):TimeToDie() < 5) then 
                if A.Trinket1:IsReady(player) and Trinket1IsAllowed and A.Trinket1:GetItemCategory() ~= "DPS" then 
                    return A.Trinket1:Show(icon)
               end 
        
                if A.Trinket2:IsReady(player) and Trinket2IsAllowed and A.Trinket2:GetItemCategory() ~= "DPS" then 
                   return A.Trinket2:Show(icon)
                end
            end 
			
            -- potion,if=cooldown.army_of_the_dead.ready|pet.gargoyle.active|buff.unholy_frenzy.up
            if A.PotionofUnbridledFury:IsReady(unit) and CanCast and Potion and (A.ArmyoftheDead:GetCooldown() == 0 or Pet:IsActive(27829) or Unit(player):HasBuffs(A.UnholyFrenzyBuff.ID, true) > 0) then
                return A.PotionofUnbridledFury:Show(icon)
            end
			
            -- outbreak,target_if=dot.virulent_plague.remains<=gcd
            if A.Outbreak:IsReady(player) and CanCast and Unit(unit):HasDeBuffs(A.VirulentPlagueDebuff.ID, true) < 5 then
                return A.Outbreak:Show(icon) 
            end
			
            -- use DeathStrike on low HP in Solo Mode
            if DeathStrikeHeal and CanCast and A.DeathStrike:IsReady(unit) then
                return A.DeathStrike:Show(icon) 
            end	
			
            -- call_action_list,name=essences
            if Essences(unit) and CanCast then
                return true
            end

        
            -- AoE multi targets
	    	if (isMulti or GetToggle(2, "AoE")) and MultiUnits:GetByRange(MaxAoERange) > MinAoETargets and CanCast then
			
			    local ActiveFesteringWound = MultiUnits:GetByRangeAppliedDoTs(6, 5, A.FesteringWoundDebuff.ID)
				local MissingFesteringWound = MultiUnits:GetByRangeMissedDoTs(6, 5, A.FesteringWoundDebuff.ID)
				local currentTargets = MultiUnits:GetByRange(MaxAoERange)
				
				--Action.MultiUnits.GetByRangeDoTsToRefresh(self, range, count, deBuffs, refreshTime, upTTD)
				
			--	/dump Action.MultiUnits:GetByRangeAppliedDoTs(10, 10, 194310)	
                local FesteringWoundTimeNeededToCastOnAll = currentTargets * 2	
                --local FesteringStrikeToCast = 0 				
                -- Compare current AreaTTD with FesteringWoundTimeNeededToCastOnAll 
				-- We need the current pack to survive at least the time to spend FesteringStrike on all target
				if Player:AreaTTD(10) >= (FesteringWoundTimeNeededToCastOnAll - ActiveFesteringWound ) * 1.5  then
				    DeathandDecayCanByPassLUA = true
                elseif currentTargets > 5 and MissingFesteringWound > 3 and ActiveFesteringWound > 3  then
                    DeathandDecayCanByPassLUA = true
				else
				    DeathandDecayCanByPassLUA = false
                end	
				
                -- blood_of_the_enemy,if=(cooldown.death_and_decay.remains&spell_targets.death_and_decay>1)|(cooldown.defile.remains&spell_targets.defile>1)|(cooldown.apocalypse.remains&cooldown.death_and_decay.ready)
                if A.BloodoftheEnemy:AutoHeartOfAzerothP(unit, true) and BloodoftheEnemySyncAoE and HeartOfAzeroth and 
			    (
			        Unit(player):HasBuffs(A.DeathandDecayBuff.ID, true) > 0 and Player:AreaTTD(MaxAoERange) >= BloodoftheEnemyAoETTD and MultiUnits:GetByRange(MaxAoERange) >= BloodoftheEnemyUnits
					or
					(A.LastPlayerCastName == A.DeathandDecay:Info() or Unit(player):HasBuffs(A.DeathandDecayBuff.ID, true) > 0) and Unit(unit):IsDummy()
					or 
					Unit(unit):IsBoss()
			    )
			    then
                    return A.BloodoftheEnemy:Show(icon)
                end					
				
                -- scourge_strike,if=death_and_decay.ticking&cooldown.apocalypse.remains
                if A.ScourgeStrike:IsReadyByPassCastGCD(unit) and Unit(player):HasBuffs(A.DeathandDecayBuff.ID, true) > 0 and (A.Apocalypse:GetCooldown() > 0 or not A.BurstIsON(unit))  and				--and Unit(unit):HasDeBuffsStacks(A.FesteringWoundDebuff.ID, true) > 0 and Unit(unit):HasDeBuffsStacks(A.FesteringWoundDebuff.ID, true) > 0 
				(    
				    A.BloodoftheEnemy:GetAzeriteRank() > 0 and A.BloodoftheEnemy:GetCooldown() > 0 
					or 
					A.BloodoftheEnemy:GetAzeriteRank() == 0
				)
				then
                    return A.ScourgeStrike:Show(icon)
                end		
			
                -- death_and_decay,if=cooldown.apocalypse.remains
                if A.DeathandDecay:IsReady(player) and Player:Rune() >= MinRuneDeathandDecay and 
				(
				    ActiveFesteringWound > MinFesteringWoundDeathandDecay 
					or 
					-- Dummy hack because GetByRangeAppliedDoTs methods dont work with dummies
					Unit(unit):IsDummy() and Unit(unit):HasDeBuffsStacks(A.FesteringWoundDebuff.ID, true) > 0
					or
					Player:AreaTTD(MaxAoERange) > MinAreaTTDDeathandDecay and Player:AreaTTD(MaxAoERange) <= 15 and currentTargets > 3
					or
					Player:Rune() > 2 and currentTargets > 5 and Player:AreaTTD(MaxAoERange) > MinAreaTTDDeathandDecay
					or
					DeathandDecayIgnoreFesteringWoundUnits > 0 and currentTargets >= DeathandDecayIgnoreFesteringWoundUnits
				) 
				then
                    return A.DeathandDecay:Show(icon)
                end
				
                -- epidemic,if=death_and_decay.ticking&rune<2&!variable.pooling_for_gargoyle
                if A.Epidemic:IsReady(unit) and Player:Rune() <= 2 and Unit(player):HasBuffs(A.DeathandDecayBuff.ID, true) > 0 and not VarPoolingForGargoyle then
                    return A.Epidemic:Show(icon)
                end		
				
				-- FesteringStrike auto spread
				if AutoSwitchFesteringStrike and Unit(unit):HasDeBuffsStacks(A.FesteringWoundDebuff.ID, true) > 0 and Player:AreaTTD(10) > 15 and Player:Rune() >= 2 and A.DeathandDecay:GetCooldown() == 0 and currentTargets > 2 and currentTargets <= 3 and (MissingFesteringWound > 0 and MissingFesteringWound < 3 or Unit(unit):IsDummy())
				then
				    local FesteringStrike_Nameplates = MultiUnits:GetActiveUnitPlates()
                    if FesteringStrike_Nameplates then  
                        for FesteringStrike_UnitID in pairs(FesteringStrike_Nameplates) do             
                            if Unit(FesteringStrike_UnitID):GetRange() < 6 and InMelee(FesteringStrike_UnitID) and not Unit(FesteringStrike_UnitID):InLOS() and Unit(FesteringStrike_UnitID):HasDeBuffsStacks(A.FesteringWoundDebuff.ID, true) == 0 then 
							    return A:Show(icon, ACTION_CONST_AUTOTARGET)
                            end         
                        end 
                    end
				end
				
                -- soul_reaper,if=(!raid_event.adds.exists|raid_event.adds.in>20)&rune<=(1-buff.unholy_frenzy.up)
                if A.SoulReaper:IsReady(player) and Player:Rune() <= MinRuneSoulReaper and ActiveFesteringWound >= MinFesteringWoundSoulReaper then
                    return A.SoulReaper:Show(icon)
                end	
			
                -- defile
                if A.Defile:IsReady(unit) then
                    return A.Defile:Show(icon)
                end
			
                -- epidemic,if=death_and_decay.ticking&rune<2&!variable.pooling_for_gargoyle
                if A.Epidemic:IsReady(unit) and Unit(unit):HasDeBuffs(A.DeathandDecay.ID, true) > 0 and Player:Rune() < 2 and not VarPoolingForGargoyle then
                    return A.Epidemic:Show(icon)
                end
			
                -- death_coil,if=death_and_decay.ticking&rune<2&!variable.pooling_for_gargoyle
                if A.DeathCoil:IsReady(unit) and Unit(unit):HasDeBuffs(A.DeathandDecay.ID, true) > 0 and Player:Rune() < 2 and not VarPoolingForGargoyle then
                    return A.DeathCoil:Show(icon)
                end
						
                -- clawing_shadows,if=death_and_decay.ticking&cooldown.apocalypse.remains
                if A.ClawingShadows:IsReady(unit) and (Unit(unit):HasDeBuffs(A.DeathandDecay.ID, true) > 0 and (A.Apocalypse:GetCooldown() > 0 or not A.BurstIsON(unit))) then
                    return A.ClawingShadows:Show(icon)
                end
			
                -- epidemic,if=!variable.pooling_for_gargoyle
                if A.Epidemic:IsReady(unit) and not VarPoolingForGargoyle then
                    return A.Epidemic:Show(icon)
                end
			
                -- festering_strike,target_if=debuff.festering_wound.stack<=1&cooldown.death_and_decay.remains
                if A.FesteringStrike:IsReady(unit) and Unit(unit):HasDeBuffsStacks(A.FesteringWoundDebuff.ID, true) <= 1 and A.DeathandDecay:GetCooldown() > 0 then
                    return A.FesteringStrike:Show(icon) 
                end
			
                -- festering_strike,if=talent.bursting_sores.enabled&spell_targets.bursting_sores>=2&debuff.festering_wound.stack<=1
                if A.FesteringStrike:IsReady(unit) and (A.BurstingSores:IsSpellLearned() and GetByRange(2, 8) and Unit(unit):HasDeBuffsStacks(A.FesteringWoundDebuff.ID, true) <= 1) then
                    return A.FesteringStrike:Show(icon)
                end
			
                -- death_coil,if=buff.sudden_doom.react&rune.deficit>=4
                if A.DeathCoil:IsReady(unit) and Unit(player):HasBuffs(A.SuddenDoomBuff.ID, true) > 0 and Player:Rune() <= 2 then
                    return A.DeathCoil:Show(icon)
                end
			
                -- death_coil,if=buff.sudden_doom.react&!variable.pooling_for_gargoyle|pet.gargoyle.active
                if A.DeathCoil:IsReady(unit) and (Unit(player):HasBuffs(A.SuddenDoomBuff.ID, true) > 0 and not VarPoolingForGargoyle or Pet:IsActive(27829)) then
                    return A.DeathCoil:Show(icon)
                end
			
                -- death_coil,if=runic_power.deficit<14&(cooldown.apocalypse.remains>5|debuff.festering_wound.stack>4)&!variable.pooling_for_gargoyle
                if A.DeathCoil:IsReady(unit) and Player:RunicPowerDeficit() < 14 and (A.Apocalypse:GetCooldown() > 5 or Unit(unit):HasDeBuffsStacks(A.FesteringWoundDebuff.ID, true) > 4) and not VarPoolingForGargoyle then
                    return A.DeathCoil:Show(icon)
                end
			
                -- scourge_strike,if=((debuff.festering_wound.up&cooldown.apocalypse.remains>5)|debuff.festering_wound.stack>4)&(cooldown.army_of_the_dead.remains>5|death_knight.disable_aotd)
                if A.ScourgeStrike:IsReadyByPassCastGCD(unit) and 
				(
				    Unit(unit):HasDeBuffsStacks(A.FesteringWoundDebuff.ID, true) > 0 and (A.Apocalypse:GetCooldown() > 5 or not A.BurstIsON(unit)) 
					or 
					Unit(unit):HasDeBuffsStacks(A.FesteringWoundDebuff.ID, true) > 4
				)
			    and (A.ArmyoftheDead:GetCooldown() > 5 or GetToggle(2, "DisableAotD")) 
			    then
                    return A.ScourgeStrike:Show(icon)
                end
			
                -- clawing_shadows,if=((debuff.festering_wound.up&cooldown.apocalypse.remains>5)|debuff.festering_wound.stack>4)&(cooldown.army_of_the_dead.remains>5|death_knight.disable_aotd)
                if A.ClawingShadows:IsReady(unit) and (((Unit(unit):HasDeBuffsStacks(A.FesteringWoundDebuff.ID, true) > 0 and A.Apocalypse:GetCooldown() > 5) or Unit(unit):HasDeBuffsStacks(A.FesteringWoundDebuff.ID, true) > 4) and (A.ArmyoftheDead:GetCooldown() > 5 or GetToggle(2, "DisableAotD"))) then
                    return A.ClawingShadows:Show(icon)
                end
			
                -- death_coil,if=runic_power.deficit<20&!variable.pooling_for_gargoyle
                if A.DeathCoil:IsReady(unit) and (Player:RunicPowerDeficit() < 20 and not VarPoolingForGargoyle) then
                    return A.DeathCoil:Show(icon)
                end
			
                -- festering_strike,if=((((debuff.festering_wound.stack<4&!buff.unholy_frenzy.up)|debuff.festering_wound.stack<3)&cooldown.apocalypse.remains<3)|debuff.festering_wound.stack<1)&(cooldown.army_of_the_dead.remains>5|death_knight.disable_aotd)
                if A.FesteringStrike:IsReady(unit) and 
			    (
			        Unit(unit):HasDeBuffsStacks(A.FesteringWoundDebuff.ID, true) < 4 and Unit(player):HasBuffs(A.UnholyFrenzyBuff.ID, true) == 0 
				    or 
				    Unit(unit):HasDeBuffsStacks(A.FesteringWoundDebuff.ID, true) < 3 and (A.Apocalypse:GetCooldown() < 3 or not A.BurstIsON(unit))
			    	or 
			    	Unit(unit):HasDeBuffsStacks(A.FesteringWoundDebuff.ID, true) < 1 and (A.ArmyoftheDead:GetCooldown() > 5 or GetToggle(2, "DisableAotD"))
			    )
			    then
                    return A.FesteringStrike:Show(icon)
                end
				
                -- scourge_strike,if=((debuff.festering_wound.up&cooldown.apocalypse.remains>5)|debuff.festering_wound.stack>4)&(cooldown.army_of_the_dead.remains>5|death_knight.disable_aotd)
                if A.ScourgeStrike:IsReadyByPassCastGCD(unit) and 
				(
				    Unit(unit):HasDeBuffsStacks(A.FesteringWoundDebuff.ID, true) > 0 and (A.Apocalypse:GetCooldown() > 5 or not A.BurstIsON(unit))
					or 
					Unit(unit):HasDeBuffsStacks(A.FesteringWoundDebuff.ID, true) > 4
				)
			    and (A.ArmyoftheDead:GetCooldown() > 5 or GetToggle(2, "DisableAotD")) 
			    then
                    return A.ScourgeStrike:Show(icon)
                end
			
                -- death_coil,if=!variable.pooling_for_gargoyle
                if A.DeathCoil:IsReady(unit) and (not VarPoolingForGargoyle) then
                    return A.DeathCoil:Show(icon)
                end
            end
										
            -- death_coil,if=buff.sudden_doom.react&!variable.pooling_for_gargoyle|pet.gargoyle.active
            if A.DeathCoil:IsReady(unit) and (Unit(player):HasBuffs(A.SuddenDoomBuff.ID, true) > 0 and not VarPoolingForGargoyle or Pet:IsActive(27829)) then
                return A.DeathCoil:Show(icon)
            end
			
            -- death_coil,if=runic_power.deficit<14&(cooldown.apocalypse.remains>5|debuff.festering_wound.stack>4)&!variable.pooling_for_gargoyle
            if A.DeathCoil:IsReady(unit) and (Player:RunicPowerDeficit() < 14 and (A.Apocalypse:GetCooldown() > 5 or Unit(unit):HasDeBuffsStacks(A.FesteringWoundDebuff.ID, true) > 4) and not VarPoolingForGargoyle) then
                return A.DeathCoil:Show(icon)
            end
			
            -- death_and_decay,if=talent.pestilence.enabled&cooldown.apocalypse.remains
            if A.DeathandDecay:IsReady(player) and A.Pestilence:IsSpellLearned() and (A.Apocalypse:GetCooldown() > 0 or not A.BurstIsON(unit)) then
                return A.DeathandDecay:Show(icon)
            end
			
            -- defile,if=cooldown.apocalypse.remains
            if A.Defile:IsReady(unit) and (A.Apocalypse:GetCooldown() > 0) then
                return A.Defile:Show(icon)
            end
			
            -- scourge_strike,if=((debuff.festering_wound.up&cooldown.apocalypse.remains>5)|debuff.festering_wound.stack>4)&(cooldown.army_of_the_dead.remains>5|death_knight.disable_aotd)
            if A.ScourgeStrike:IsReadyByPassCastGCD(unit) and 
			(
			    Unit(unit):HasDeBuffsStacks(A.FesteringWoundDebuff.ID, true) > 0 and (A.Apocalypse:GetCooldown() > 5 or not A.BurstIsON(unit))
				or 
				Unit(unit):HasDeBuffsStacks(A.FesteringWoundDebuff.ID, true) > 4
			)
			and (A.ArmyoftheDead:GetCooldown() > 5 or GetToggle(2, "DisableAotD")) 
			then
                return A.ScourgeStrike:Show(icon)
            end
			
            -- clawing_shadows,if=((debuff.festering_wound.up&cooldown.apocalypse.remains>5)|debuff.festering_wound.stack>4)&(cooldown.army_of_the_dead.remains>5|death_knight.disable_aotd)
            if A.ClawingShadows:IsReady(unit) and (((Unit(unit):HasDeBuffsStacks(A.FesteringWoundDebuff.ID, true) > 0 and A.Apocalypse:GetCooldown() > 5) or Unit(unit):HasDeBuffsStacks(A.FesteringWoundDebuff.ID, true) > 4) and (A.ArmyoftheDead:GetCooldown() > 5 or GetToggle(2, "DisableAotD"))) then
                return A.ClawingShadows:Show(icon)
            end
			
            -- death_coil,if=runic_power.deficit<20&!variable.pooling_for_gargoyle
            if A.DeathCoil:IsReady(unit) and (Player:RunicPowerDeficit() < 20 and not VarPoolingForGargoyle) then
                return A.DeathCoil:Show(icon)
            end
			
            -- festering_strike,if=((((debuff.festering_wound.stack<4&!buff.unholy_frenzy.up)|debuff.festering_wound.stack<3)&cooldown.apocalypse.remains<3)|debuff.festering_wound.stack<1)&(cooldown.army_of_the_dead.remains>5|death_knight.disable_aotd)
            if A.FesteringStrike:IsReady(unit) and 
			(
			    (
				    (
					    (
						    (Unit(unit):HasDeBuffsStacks(A.FesteringWoundDebuff.ID, true) < 4 and Unit(player):HasBuffs(A.UnholyFrenzyBuff.ID, true) == 0) 
							or 
							Unit(unit):HasDeBuffsStacks(A.FesteringWoundDebuff.ID, true) < 3
						)
						and (A.Apocalypse:GetCooldown() < 3 or not A.BurstIsON(unit))
					) 
					or 
					Unit(unit):HasDeBuffsStacks(A.FesteringWoundDebuff.ID, true) < 1
				) 
				and (A.ArmyoftheDead:GetCooldown() > 5 or GetToggle(2, "DisableAotD"))
			)
			then
                return A.FesteringStrike:Show(icon)
            end
			
            -- death_coil,if=!variable.pooling_for_gargoyle
            if A.DeathCoil:IsReady(unit) and (not VarPoolingForGargoyle) then
                return A.DeathCoil:Show(icon)
            end
			
        end
    end
    EnemyRotation = A.MakeFunctionCachedDynamic(EnemyRotation)  
    -- End on EnemyRotation()
    
	-- raise_dead
    if A.RaiseDead:IsReady(player) and not Pet:IsActive() and not Player:IsMounted() then
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
local function FreezingTrapUsedByEnemy()
    if     UnitCooldown:GetCooldown("arena", 3355) > UnitCooldown:GetMaxDuration("arena", 3355) - 2 and
    UnitCooldown:IsSpellInFly("arena", 3355) and 
    Unit(player):GetDR("incapacitate") >= 50 
    then 
        local Caster = UnitCooldown:GetUnitID("arena", 3355)
        if Caster and Unit(Caster):GetRange() <= 40 then 
            return true 
        end 
    end 
end 
local function ArenaRotation(icon, unit)
    local DeathGripLowHealth = GetToggle(2, "DeathGripLowHealth")
    if A.IsInPvP and (A.Zone == "pvp" or A.Zone == "arena") and not Player:IsStealthed() and not Player:IsMounted() then
        -- Note: "arena1" is just identification of meta 6
        if unit == "arena1" or unit == "arena2" or unit == "arena3" --and (Unit(player):GetDMG() == 0 or not Unit(player):IsFocused("DAMAGER")) 
		then 	
			-- Interrupt
   		    local Interrupt = Interrupts(unit)
  		    if Interrupt then 
  		        return Interrupt:Show(icon)
  		    end	

			-- Death Grip
			if UseDeathGrip and A.DeathGrip:IsReady(unit) and Unit(unit):GetRange() > 8 and Unit(unit):GetRange() <= 30 and Unit(unit):IsMovingOut() and Unit(unit):HealthPercent() < DeathGripLowHealth
			then
			    return A.DeathGrip:Show(icon) 
			end
        end
    end 
end 
local function PartyRotation(unit)
    if (unit == "party1" and not GetToggle(2, "PartyUnits")[1]) or (unit == "party2" and not GetToggle(2, "PartyUnits")[2]) then 
        return false 
    end
  	
	-- RaiseAlly
    if A.RaiseAlly:IsReady(unit) and Unit(player):CombatTime() > 0 and Unit(unit):IsDead() and not Unit(unit):InLOS() and
	(
	    -- Tank
	    GetToggle(2, "RaiseAllyUnits")[1] and Unit(unit):IsTank() and Unit(unit):IsPlayer()
		or
		-- Healer
		GetToggle(2, "RaiseAllyUnits")[2] and Unit(unit):IsHealer() and Unit(unit):IsPlayer()
		or
		-- Damager
		GetToggle(2, "RaiseAllyUnits")[3] and Unit(unit):IsDamager() and Unit(unit):IsPlayer() 
		or
		-- Mouseover
		GetToggle(2, "RaiseAllyUnits")[4] and Unit("mouseover"):IsExists() and Unit(unit):IsPlayer()
	)	
	then
        return A.RaiseAlly
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
