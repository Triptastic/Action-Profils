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
    -- Abilities
    RaiseDead                                                = Create({ Type = "Spell", ID = 46584 }),
    SacrificialPact                                          = Create({ Type = "Spell", ID = 327574 }),
    ArmyoftheDead                                            = Create({ Type = "Spell", ID = 42650 }),
    Apocalypse                                                        = Create({ Type = "Spell", ID = 275699 }),
    DeathAndDecay                                                 = Create({ Type = "Spell", ID = 43265 }),
    Epidemic                                                            = Create({ Type = "Spell", ID = 207317 }),
    FesteringStrike                                             = Create({ Type = "Spell", ID = 85948 }),
    DeathCoil                                                         = Create({ Type = "Spell", ID = 47541 }),
    ScourgeStrike                                                 = Create({ Type = "Spell", ID = 55090 }),
    Outbreak                                                            = Create({ Type = "Spell", ID = 77575 }),
    DeathStrike                                                     = Create({ Type = "Spell", ID = 49998 }),
    DarkTransformation                                        = Create({ Type = "Spell", ID = 63560 }),
    -- Talents
    Defile                                                                = Create({ Type = "Spell", ID = 152280 }),
    BurstingSores                                                 = Create({ Type = "Spell", ID = 207264 }),
    ClawingShadows                                                = Create({ Type = "Spell", ID = 207311 }),
    SoulReaper                                                        = Create({ Type = "Spell", ID = 343294 }),
    UnholyBlight                                                    = Create({ Type = "Spell", ID = 115989 }),
    --SummonGargoyle                                                = MultiSpell(49206, 207349 }),
    Pestilence                                                        = Create({ Type = "Spell", ID = 277234 }),
    UnholyPact                                                        = Create({ Type = "Spell", ID = 319230 }),
    UnholyAssault                                                 = Create({ Type = "Spell", ID = 207289 }),
    ArmyoftheDamned                                             = Create({ Type = "Spell", ID = 276837 }),
    -- Covenant Abilities
    ShackleTheUnworthy                                        = Create({ Type = "Spell", ID = 312202 }),
    SwarmingMist                                                    = Create({ Type = "Spell", ID = 311648 }),
    AbominationLimb                                             = Create({ Type = "Spell", ID = 315443 }),
    DeathsDue                                                         = Create({ Type = "Spell", ID = 324128 }),
    -- Conduit Effects
    ConvocationOfTheDead                                    = Create({ Type = "Spell", ID = 338553 }),
    -- Buffs
    DeathAndDecayBuff                                         = Create({ Type = "Spell", ID = 188290 }),
    DeathStrikeBuff                                             = Create({ Type = "Spell", ID = 101568 }),
    SuddenDoomBuff                                                = Create({ Type = "Spell", ID = 81340 }),
    UnholyAssaultBuff                                         = Create({ Type = "Spell", ID = 207289 }),
    UnholyStrengthBuff                                        = Create({ Type = "Spell", ID = 53365 }),
    -- Debuffs
    FesteringWoundDebuff                                    = Create({ Type = "Spell", ID = 194310 }),
    VirulentPlagueDebuff                                    = Create({ Type = "Spell", ID = 191587 }),
    UnholyBlightDebuff                                        = Create({ Type = "Spell", ID = 115994 }),
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
--Action:CreateEssencesFor(ACTION_CONST_DEATHKNIGHT_UNHOLY)  -- BFA

-- To create covenants
Action:CreateCovenantsFor(ACTION_CONST_DEATHKNIGHT_UNHOLY)

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
	local MinAoETargets = GetToggle(2, "MinAoETargets")
	local MaxAoERange = GetToggle(2, "MaxAoERange")	
	local MinRuneDeathandDecay = GetToggle(2, "MinRuneDeathandDecay")
	local MinAreaTTDDeathandDecay = GetToggle(2, "MinAreaTTDDeathandDecay")
	local DeathandDecayIgnoreFesteringWoundUnits = GetToggle(2, "DeathandDecayIgnoreFesteringWoundUnits")
	local MinFesteringWoundDeathandDecay = GetToggle(2, "MinFesteringWoundDeathandDecay")
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
                
        local function AOE_Setup()
            -- death_and_decay,if=death_knight.fwounded_targets=active_enemies|raid_event.adds.exists&raid_event.adds.remains<=11
            if A.DeathAndDecay:IsReady(unit) and (A.FesteringWoundDebuff:AuraActiveCount() == EnemiesMeleeCount) then
                return A.DeathAndDecay:Show(icon)
            end
            -- death_and_decay,if=death_knight.fwounded_targets>=5
            if A.DeathAndDecay:IsReady(unit) and A.FesteringWoundDebuff:AuraActiveCount() >= 5 then
                return A.DeathAndDecay:Show(icon)
            end
            -- defile,if=death_knight.fwounded_targets=active_enemies|raid_event.adds.exists&raid_event.adds.remains<=11
            if A.Defile:IsReady(unit) and (A.FesteringWoundDebuff:AuraActiveCount() == EnemiesMeleeCount) then
                return A.Defile:Show(icon)
            end
            -- defile,if=death_knight.fwounded_targets>=5
            if A.Defile:IsReady(unit) and A.FesteringWoundDebuff:AuraActiveCount() >= 5 then
                return A.Defile:Show(icon)
            end
            -- epidemic,if=!variable.pooling_for_gargoyle&runic_power.deficit<20
            -- Added check to ensure at least 2 targets have Plague
            if A.Epidemic:IsReady() and not bool(VarPoolingForGargoyle) and Player:RunicPowerDeficit() < 20 and A.VirulentPlagueDebuff:AuraActiveCount() > 1 then
                return A.Epidemic:Show(icon)
            end
            -- festering_strike,target_if=debuff.festering_wound.stack<1
            if A.FesteringStrike:IsReady(unit) then
                return A.FesteringStrike, EnemiesMelee, EvaluateTargetUnitNoFWDebuff) then return "festering_strike target_if aoe_setup 6" end
            end 
            -- epidemic,if=!variable.pooling_for_gargoyle
            -- Added check to ensure at least 2 targets have Plague
            if A.Epidemic:IsReady() and not bool(VarPoolingForGargoyle) and A.VirulentPlagueDebuff:AuraActiveCount() > 1 then
                return A.Epidemic:Show(icon)
            end
        end

        local function AOE_Burst()
            -- epidemic,if=runic_power.deficit<(10+death_knight.fwounded_targets*3)&death_knight.fwounded_targets<6&!variable.pooling_for_gargoyle
            if A.Epidemic:IsReady() and (Player:RunicPowerDeficit() < (10 + A.FesteringWoundDebuff:AuraActiveCount() * 3) and A.FesteringWoundDebuff:AuraActiveCount() < 6 and not bool(VarPoolingForGargoyle) and A.VirulentPlagueDebuff:AuraActiveCount() > 1) then
                return A.Epidemic:Show(icon)
            end
            -- epidemic,if=runic_power.deficit<25&death_knight.fwounded_targets>5&!variable.pooling_for_gargoyle
            if A.Epidemic:IsReady() and (Player:RunicPowerDeficit() < 25 and A.FesteringWoundDebuff:AuraActiveCount() > 5 and not bool(VarPoolingForGargoyle)) then
                return A.Epidemic:Show(icon)
            end
            -- epidemic,if=!death_knight.fwounded_targets&!variable.pooling_for_gargoyle
            if A.Epidemic:IsReady() and (A.FesteringWoundDebuff:AuraActiveCount() < 1 and not bool(VarPoolingForGargoyle)) then
                return A.Epidemic:Show(icon)
            end
            -- scourge_strike
            if A.ScourgeStrike:IsReady(unit) then
                return A.ScourgeStrike:Show(icon)
            end
            -- clawing_shadows
            if A.ClawingShadows:IsReady(unit) then
                return A.ClawingShadows:Show(icon)
            end
            -- epidemic,if=!variable.pooling_for_gargoyle
            -- Added check to ensure at least 2 targets have Plague
            if A.Epidemic:IsReady() and (not bool(VarPoolingForGargoyle) and A.VirulentPlagueDebuff:AuraActiveCount() > 1) then
                return A.Epidemic:Show(icon)
            end
        end

        local function AOE_Generic()
            -- epidemic,if=buff.sudden_doom.react
            if A.Epidemic:IsReady() and Player:BuffUp(A.SuddenDoomBuff) then
                return A.Epidemic:Show(icon)
            end
            -- epidemic,if=!variable.pooling_for_gargoyle
            -- Added check to ensure at least 2 targets have Plague
            if A.Epidemic:IsReady() and (not bool(VarPoolingForGargoyle) and A.VirulentPlagueDebuff:AuraActiveCount() > 1) then
                return A.Epidemic:Show(icon)
            end
            -- scourge_strike,target_if=max:debuff.festering_wound.stack,if=cooldown.apocalypse.remains>5&debuff.festering_wound.stack>=1
            if A.ScourgeStrike:IsReady(unit) then
                return A.ScourgeStrike:Show(icon)
            end
            -- clawing_shadows,target_if=max:debuff.festering_wound.stack,if=cooldown.apocalypse.remains>5&debuff.festering_wound.stack>=1
            if A.ClawingShadows:IsReady(unit) then
                return A.ClawingShadows:Show(icon)
            end
            -- festering_strike,target_if=min:debuff.festering_wound.stack,if=cooldown.apocalypse.remains>5&debuff.festering_wound.stack<1
            if A.FesteringStrike:IsReady(unit) then
                return A.FesteringStrike:Show(icon)
            end
            -- scourge_strike,target_if=max:debuff.festering_wound.stack,if=(cooldown.apocalypse.remains>5&debuff.festering_wound.up|debuff.festering_wound.stack>4)&(target.1.time_to_die<cooldown.death_and_decay.remains+10|target.1.time_to_die>cooldown.apocalypse.remains)
            if A.ScourgeStrike:IsReady(unit) then
                return A.ScourgeStrike:Show(icon)
            end
            -- clawing_shadows,target_if=max:debuff.festering_wound.stack,if=(cooldown.apocalypse.remains>5&debuff.festering_wound.up|debuff.festering_wound.stack>4)&(target.1.time_to_die<cooldown.death_and_decay.remains+10|target.1.time_to_die>cooldown.apocalypse.remains)
            if A.ClawingShadows:IsReady(unit) then
                return A.ClawingShadows:Show(icon)
            end
            -- festering_strike,target_if=max:debuff.festering_wound.stack,if=debuff.festering_wound.stack<3&cooldown.apocalypse.remains<3|debuff.festering_wound.stack<1
            if A.FesteringStrike:IsReady(unit) then
                return A.FesteringStrike:Show(icon)
            end
        end

        local function Cooldowns()
            -- army_of_the_dead,if=cooldown.unholy_blight.remains<5&talent.unholy_blight.enabled|!talent.unholy_blight.enabled
            if A.ArmyoftheDead:IsReady(unit) and (A.UnholyBlight:CooldownRemains() < 5 and A.UnholyBlight:IsAvailable() or not A.UnholyBlight:IsAvailable()) then
                return A.ArmyoftheDead:Show(icon)
            end
            -- unholy_blight,if=(cooldown.army_of_the_dead.remains>5|death_knight.disable_aotd)&(cooldown.apocalypse.ready&(debuff.festering_wound.stack>=4|rune>=3)|cooldown.apocalypse.remains)&!raid_event.adds.exists
            if A.UnholyBlight:IsReady(unit) and (DisableAOTD() and (A.Apocalypse:CooldownUp() and (Target:DebuffStack(A.FesteringWoundDebuff) >= 4 or Player:Rune() >= 3) or bool(A.Apocalypse:CooldownRemains()))) then
                return A.UnholyBlight:Show(icon)
            end
            -- unholy_blight,if=raid_event.adds.exists&(active_enemies>=2|raid_event.adds.in>15)
            if A.UnholyBlight:IsReady(unit) and EnemiesMeleeCount >= 2 then
                return A.UnholyBlight:Show(icon)
            end
            -- dark_transformation,if=!raid_event.adds.exists&cooldown.unholy_blight.remains&(runeforge.deadliest_coil.equipped&(!buff.dark_transformation.up&!talent.unholy_pact.enabled|talent.unholy_pact.enabled)|!runeforge.deadliest_coil.equipped)|!talent.unholy_blight.enabled
            if A.DarkTransformation:IsReady(unit) and (bool(A.UnholyBlight:CooldownRemains()) and (DeadliestCoilEquipped and (not Pet:BuffUp(A.DarkTransformation) and not A.UnholyPact:IsAvailable() or A.UnholyPact:IsAvailable()) or not DeadliestCoilEquipped) or not A.UnholyBlight:IsAvailable()) then
                return A.DarkTransformation:Show(icon)
            end
            -- dark_transformation,if=raid_event.adds.exists&(active_enemies>=2|raid_event.adds.in>15)
            if A.DarkTransformation:IsReady(unit) and EnemiesMeleeCount >= 2 then
                return A.DarkTransformation:Show(icon)
            end
            -- unholy_assault,if=active_enemies=1&(pet.apoc_ghoul.active|conduit.convocation_of_the_dead.enabled)
            if A.UnholyAssault:IsReady(unit) and (EnemiesMeleeCount == 1 and (A.Apocalypse:TimeSinceLastCast() <= 15) or A.ConvocationOfTheDead:IsAvailable()) then
                return A.UnholyAssault:Show(icon)
            end
            -- unholy_assault,target_if=min:debuff.festering_wound.stack,if=active_enemies>=2&debuff.festering_wound.stack<2
            if A.UnholyAssault:IsReady(unit) then
                return A.UnholyAssault:Show(icon)
            end
            -- apocalypse,if=debuff.festering_wound.stack>=4&((!talent.unholy_blight.enabled|talent.army_of_the_damned.enabled|conduit.convocation_of_the_dead.enabled)|talent.unholy_blight.enabled&!talent.army_of_the_damned.enabled&dot.unholy_blight.remains)&active_enemies=1
            if A.Apocalypse:IsReady(unit) and (Target:DebuffStack(A.FesteringWoundDebuff) >= 4 and ((not A.UnholyBlight:IsAvailable() or A.ArmyoftheDamned:IsAvailable() or A.ConvocationOfTheDead:IsAvailable()) or not A.UnholyBlight:IsAvailable() and not A.ArmyoftheDamned:IsAvailable() and Target:DebuffUp(A.UnholyBlightDebuff)) and EnemiesMeleeCount == 1) then
                return A.Apocalypse:Show(icon)
            end
            -- apocalypse,target_if=max:debuff.festering_wound.stack,if=debuff.festering_wound.stack>=4&active_enemies>=2&!death_and_decay.ticking
            if A.Apocalypse:IsReady(unit) then
                return A.Apocalypse:Show(icon)
            end
            -- summon_gargoyle,if=runic_power.deficit<14
            if A.SummonGargoyle:IsReady(unit) and (Player:RunicPowerDeficit() < 14) then
                return A.SummonGargoyle:Show(icon)
            end
            -- soul_reaper,target_if=target.health.pct<35&target.time_to_die>5
            if A.SoulReaper:IsReady(unit) then
                return A.SoulReaper:Show(icon)
            end
            -- raise_dead,if=!pet.risen_ghoul.active
            if A.RaiseDead:IsReady(unit) then
                if HR.CastSuggested(A.RaiseDead) then return "raise_dead cooldown 12"; end
            end
            -- sacrificial_pact,if=active_enemies>=2&!buff.dark_transformation.up&!cooldown.dark_transformation.ready 
            if A.SacrificialPact:IsReady(unit) and (EnemiesMeleeCount >= 2 and not Pet:BuffUp(A.DarkTransformation) and not A.DarkTransformation:CooldownUp() and A.RaiseDead:CooldownUp()) then
                return A.SacrificialPact:Show(icon)
            end
        end

        local function Racials()
            if (A.BurstIsON(unit)) then
                -- arcane_torrent,if=runic_power.deficit>65&pet.gargoyle.active&rune.deficit>=5
                if A.ArcaneTorrent:IsReady(unit) and (Player:RunicPowerDeficit() > 65 and A.SummonGargoyle:TimeSinceLastCast() <= 35 and Player:Rune() <= 1) then
                    return A.ArcaneTorrent:Show(icon)
                end
                -- blood_fury,if=pet.gargoyle.active|buff.unholy_assault.up|talent.army_of_the_damned.enabled&(pet.army_ghoul.active|cooldown.army_of_the_dead.remains>target.time_to_die)
                if A.BloodFury:IsReady(unit) and (A.SummonGargoyle:TimeSinceLastCast() <= 35 and A.SummonGargoyle:IsAvailable() or A.UnholyAssault:BuffUp() and A.UnholyAssault:IsAvailable() or A.ArmyoftheDamned:IsAvailable() and (ArmyoftheDead:TimeSinceLastCast() <= 30 or A.ArmyoftheDead:CooldownRemains() > Target:TimeToDie())) then
                    return A.BloodFury:Show(icon)
                end
                -- berserking,if=pet.gargoyle.active|buff.unholy_assault.up|talent.army_of_the_damned.enabled&(pet.army_ghoul.active|cooldown.army_of_the_dead.remains>target.time_to_die)
                if A.Berserking:IsReady(unit) and (A.SummonGargoyle:TimeSinceLastCast() <= 35 and A.SummonGargoyle:IsAvailable() or A.UnholyAssault:BuffUp() and A.UnholyAssault:IsAvailable() or A.ArmyoftheDamned:IsAvailable() and (ArmyoftheDead:TimeSinceLastCast() <= 30 or A.ArmyoftheDead:CooldownRemains() > Target:TimeToDie())) then
                    return A.Berserking:Show(icon)
                end
                -- lights_judgment,if=buff.unholy_strength.up
                if A.LightsJudgment:IsReady(unit) and Player:BuffUp(A.UnholyStrengthBuff) then
                    return A.LightsJudgment:Show(icon)
                end
                -- ancestral_call,if=pet.gargoyle.active|buff.unholy_assault.up|talent.army_of_the_damned.enabled&(pet.army_ghoul.active|cooldown.army_of_the_dead.remains>target.time_to_die)
                if A.AncestralCall:IsReady(unit) and (A.SummonGargoyle:TimeSinceLastCast() <= 35 and A.SummonGargoyle:IsAvailable() or A.UnholyAssault:BuffUp() and A.UnholyAssault:IsAvailable() or A.ArmyoftheDamned:IsAvailable() and (ArmyoftheDead:TimeSinceLastCast() <= 30 or A.ArmyoftheDead:CooldownRemains() > Target:TimeToDie())) then
                    return A.AncestralCall:Show(icon)
                end
                -- arcane_pulse,if=active_enemies>=2|(rune.deficit>=5&runic_power.deficit>=60)
                if A.ArcanePulse:IsReady(unit) and (EnemiesMeleeCount >= 2 or (Player:Rune() <= 1 and Player:RunicPowerDeficit() >= 60)) then
                    return A.ArcanePulse:Show(icon)
                end
                -- fireblood, if=pet.gargoyle.active|buff.unholy_assault.up|talent.army_of_the_damned.enabled&(pet.army_ghoul.active|cooldown.army_of_the_dead.remains>target.time_to_die)
                if A.Fireblood:IsReady(unit) and (A.SummonGargoyle:TimeSinceLastCast() <= 35 and A.SummonGargoyle:IsAvailable() or A.UnholyAssault:BuffUp() and A.UnholyAssault:IsAvailable() or A.ArmyoftheDamned:IsAvailable() and (ArmyoftheDead:TimeSinceLastCast() <= 30 or A.ArmyoftheDead:CooldownRemains() > Target:TimeToDie())) then
                    return A.Fireblood:Show(icon)
                end
                -- bag_of_tricks,if=buff.unholy_strength.up&active_enemies=1
                if A.BagofTricks:IsReady(unit) and Player:BuffUp(A.UnholyStrengthBuff) and EnemiesMeleeCount == 1 then
                    return A.BagofTricks:Show(icon)
                end
            end
        end

        local function Generic()
            -- death_coil,if=buff.sudden_doom.react&!variable.pooling_for_gargoyle|pet.gargoyle.active
            if A.DeathCoil:IsReady(unit) and (Player:BuffUp(A.SuddenDoomBuff)            and not bool(VarPoolingForGargoyle) or A.SummonGargoyle:TimeSinceLastCast() <= 35) then
                return A.DeathCoil:Show(icon)
            end
            -- death_coil,if=runic_power.deficit<14&!variable.pooling_for_gargoyle
            if A.DeathCoil:IsReady(unit) and (Player:RunicPowerDeficit() < 14 and not bool(VarPoolingForGargoyle)) then
                return A.DeathCoil:Show(icon)
            end
            -- defile,if=cooldown.apocalypse.remains
            if A.Defile:IsReady(unit) and bool(A.Apocalypse:CooldownRemains()) then
                return A.Defile:Show(icon)
            end
            -- scourge_strike,if=debuff.festering_wound.up&(!talent.unholy_blight.enabled|talent.army_of_the_damned.enabled|conduit.convocation_of_the_dead.enabled|raid_event.adds.exists)&cooldown.apocalypse.remains>5
            if A.ScourgeStrike:IsReady(unit) and (Target:DebuffUp(A.FesteringWoundDebuff) and (not A.UnholyBlight:IsAvailable() or A.ArmyoftheDamned:IsAvailable() or A.ConvocationOfTheDead:IsAvailable()) and A.Apocalypse:CooldownRemains() > 5) then
                return A.ScourgeStrike:Show(icon)
            end
            -- scourge_strike,if=debuff.festering_wound.stack>4
            if A.ScourgeStrike:IsReady(unit) and Target:DebuffStack(A.FesteringWoundDebuff) > 4            then
                return A.ScourgeStrike:Show(icon)
            end
            -- scourge_strike,if=debuff.festering_wound.up&talent.unholy_blight.enabled&!talent.army_of_the_damned.enabled&cooldown.unholy_blight.remains>5&!cooldown.apocalypse.ready&!raid_event.adds.exists
            if A.ScourgeStrike:IsReady(unit) and (Target:DebuffUp(A.FesteringWoundDebuff) and A.UnholyBlight:IsAvailable() and not A.ArmyoftheDamned:IsAvailable() and A.UnholyBlight:CooldownRemains() > 5 and not A.Apocalypse:CooldownUp())            then
                return A.ScourgeStrike:Show(icon)
            end
            -- clawing_shadows,if=debuff.festering_wound.up&(!talent.unholy_blight.enabled|talent.army_of_the_damned.enabled|conduit.convocation_of_the_dead.enabled|raid_event.adds.exists)&cooldown.apocalypse.remains>5
            if A.ClawingShadows:IsReady(unit) and (Target:DebuffUp(A.FesteringWoundDebuff) and (not A.UnholyBlight:IsAvailable() or A.ArmyoftheDamned:IsAvailable() or A.ConvocationOfTheDead:IsAvailable()) and A.Apocalypse:CooldownRemains() > 5) then
                return A.ClawingShadows:Show(icon)
            end
            -- clawing_shadows,if=debuff.festering_wound.stack>4
            if A.ClawingShadows:IsReady(unit) and Target:DebuffStack(A.FesteringWoundDebuff) > 4            then
                return A.ClawingShadows:Show(icon)
            end
            -- clawing_shadows,if=debuff.festering_wound.up&talent.unholy_blight.enabled&!talent.army_of_the_damned.enabled&cooldown.unholy_blight.remains>5&!cooldown.apocalypse.ready&!raid_event.adds.exists
            if A.ClawingShadows:IsReady(unit) and (Target:DebuffUp(A.FesteringWoundDebuff) and A.UnholyBlight:IsAvailable() and not A.ArmyoftheDamned:IsAvailable() and A.UnholyBlight:CooldownRemains() > 5 and not A.Apocalypse:CooldownUp())            then
                return A.ClawingShadows:Show(icon)
            end
            -- death_coil,if=runic_power.deficit<20&!variable.pooling_for_gargoyle
            if A.DeathCoil:IsReady(unit) and (Player:RunicPowerDeficit() < 20 and not bool(VarPoolingForGargoyle)) then
                return A.DeathCoil:Show(icon)
            end
            -- festering_strike,if=debuff.festering_wound.stack<4&cooldown.apocalypse.remains<3&(!talent.unholy_blight.enabled|talent.army_of_the_damned.enabled|conduit.convocation_of_the_dead.enabled|raid_event.adds.exists)
            if A.FesteringStrike:IsReady(unit) and (Target:DebuffStack(A.FesteringWoundDebuff) < 4 and A.Apocalypse:CooldownRemains() < 3 and (not A.UnholyBlight:IsAvailable() or A.ArmyoftheDamned:IsAvailable() or A.ConvocationOfTheDead:IsAvailable())) then
                return A.FesteringStrike:Show(icon)
            end
            -- festering_strike,if=debuff.festering_wound.stack<1
            if A.FesteringStrike:IsReady(unit) and Target:DebuffStack(A.FesteringWoundDebuff) < 1 then
                return A.FesteringStrike:Show(icon)
            end
            -- festering_strike,if=debuff.festering_wound.stack<4&(cooldown.unholy_blight.remains<3|(cooldown.apocalypse.ready&dot.unholy_blight.remains)&talent.unholy_blight.enabled&!talent.army_of_the_damned.enabled)&!raid_event.adds.exists
            if A.FesteringStrike:IsReady(unit) and (Target:DebuffStack(A.FesteringWoundDebuff) < 4 and (A.UnholyBlight:CooldownRemains() < 3 or (A.Apocalypse:CooldownUp() and Target:DebuffUp(A.UnholyBlightDebuff)) and A.UnholyBlight:IsAvailable() and not A.ArmyoftheDamned:IsAvailable())) then
                return A.FesteringStrike:Show(icon)
            end
            -- death_coil,if=!variable.pooling_for_gargoyle
            if A.DeathCoil:IsReady(unit) and (not bool(VarPoolingForGargoyle)) then
                return A.DeathCoil:Show(icon)
            end
        end
		
        --Precombat
        if combatTime == 0 and not profileStop and Unit(unit):IsExists() and unit ~= "mouseover" then
            -- flask
            -- food
            -- augmentation
            -- snapshot_stats			
            -- raise_dead
            if A.RaiseDead:IsReady(player) and not Pet:IsActive() then
                return A.RaiseDead:Show(icon)
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
			
            -- use DeathStrike on low HP in Solo Mode
            if DeathStrikeHeal and CanCast and A.DeathStrike:IsReady(unit) then
                return A.DeathStrike:Show(icon) 
            end	

            -- outbreak,target_if=dot.virulent_plague.remains<=gcd
            if A.Outbreak:IsReady(unit) and Target:DebuffRemains(A.VirulentPlagueDebuff) <= Player:GCD() then
              return A.Outbreak:Show(icon)
            end
	
            -- Death Coil/Epidemic when we are not in melee range
            if Unit(unit):GetRange() >= 8 then
                if  A.Epidemic:IsReady(unit) and A.VirulentPlagueDebuff:AuraActiveCount() > 1 then
                    return A.Epidemic:Show(icon)
                end
                if A.DeathCoil:IsReady(unit) then
                    return A.DeathCoil:Show(icon)
                end
            end
 	
            -- call_action_list,name=cooldowns
            if unit ~= "mouseover" and BurstIsON(unit) and inCombat and not profileStop then
                return = Cooldowns()
            end
	
            -- racials
            if BurstIsON(unit) then
                return = Racials()
            end	
	
            -- AoE multi targets
	        if (isMulti or GetToggle(2, "AoE")) and MultiUnits:GetByRange(MaxAoERange) > MinAoETargets and CanCast then
			
                -- run_action_list,name=aoe_setup,if=active_enemies>=2&(cooldown.death_and_decay.remains<10&!talent.defile.enabled|cooldown.defile.remains<10&talent.defile.enabled)&!death_and_decay.ticking
                if (EnemiesMeleeCount >= 2 and (A.DeathAndDecay:CooldownRemains() < 10 and not A.Defile:IsAvailable() or A.Defile:CooldownRemains() < 10 and A.Defile:IsAvailable()) and not Unit("player"):HasBuffs(A.DeathAndDecayBuff.ID, true)) then
                    return AOE_Setup()
                end
				
                -- run_action_list,name=aoe_burst,if=active_enemies>=2&death_and_decay.ticking
                if (EnemiesMeleeCount >= 2 and Unit("player"):HasBuffs(A.DeathAndDecayBuff.ID, true)) then
                    return AOE_Burst()
                end
				
                -- generic_aoe,if=active_enemies>=2&(!death_and_decay.ticking&(cooldown.death_and_decay.remains>10&!talent.defile.enabled|cooldown.defile.remains>10&talent.defile.enabled))
                if (EnemiesMeleeCount >= 2 and (not Unit("player"):HasBuffs(A.DeathAndDecayBuff.ID, true) and (A.DeathAndDecay:CooldownRemains() > 10 and not A.Defile:IsAvailable() or A.Defile:CooldownRemains() > 10 and A.Defile:IsAvailable()))) then
                    return AOE_Generic()
                end
				
            end
	
            -- call_action_list,name=generic,if=active_enemies=1
            if (EnemiesMeleeCount == 1 or (EnemiesMeleeCount > 1 and not GetToggle(2, "AoE"))) then
                return Generic()
            end
	
            -- Add pool resources icon if nothing else to do
            if (true) then
                return A.PoolResources:Show(icon)
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
