-------------------------------
-- Taste TMW Action Rotation --
-------------------------------
local _G, setmetatable							= _G, setmetatable
local A                         			    = _G.Action
--local Re                                        = Action.Re
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
local TeamCacheEnemyMaxSize                     = TeamCache.Enemy.MaxSize

--- ============================ CONTENT ===========================
--- ======= APL LOCALS =======
-- luacheck: max_line_length 9999

-- Spells
Action[ACTION_CONST_WARLOCK_DESTRUCTION] = {
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
    WilloftheForsaken                      = Action.Create({ Type = "Spell", ID = 7744        }), -- not usable in APL but user can Queue it   
    EscapeArtist                           = Action.Create({ Type = "Spell", ID = 20589    }), -- not usable in APL but user can Queue it
    EveryManforHimself                     = Action.Create({ Type = "Spell", ID = 59752    }), -- not usable in APL but user can Queue it
    -- Generics
    SummonImp                              = Action.Create({ Type = "Spell", ID = 688        }),    
    SummonVoidwalker                       = Action.Create({ Type = "Spell", ID = 697        }),
    SummonFelhunter                        = Action.Create({ Type = "Spell", ID = 691        }),
    SummonSuccubus                         = Action.Create({ Type = "Spell", ID = 712        }),
    --SummonPet                              = Action.Create({ Type = "Spell", ID = 688 }),
    GrimoireofSacrifice                    = Action.Create({ Type = "Spell", ID = 108503 }),
    SoulFire                               = Action.Create({ Type = "Spell", ID = 6353 }),
    Incinerate                             = Action.Create({ Type = "Spell", ID = 29722 }),
    RainofFire                             = Action.Create({ Type = "Spell", ID = 5740 }),
    CrashingChaosBuff                      = Action.Create({ Type = "Spell", ID = 277706, Hidden = true }),
    GrimoireofSupremacy                    = Action.Create({ Type = "Spell", ID = 266086 }),
    Havoc                                  = Action.Create({ Type = "Spell", ID = 80240 }),
    RainofFireDebuff                       = Action.Create({ Type = "Spell", ID = 5740, Hidden = true }),
    ChannelDemonfire                       = Action.Create({ Type = "Spell", ID = 196447 }),
    ImmolateDebuff                         = Action.Create({ Type = "Spell", ID = 157736, Hidden = true }),
    Immolate                               = Action.Create({ Type = "Spell", ID = 348 }),
    Cataclysm                              = Action.Create({ Type = "Spell", ID = 152108 }),
    HavocDebuff                            = Action.Create({ Type = "Spell", ID = 80240, Hidden = true }),
    ChaosBolt                              = Action.Create({ Type = "Spell", ID = 116858 }),
    Inferno                                = Action.Create({ Type = "Spell", ID = 270545 }),
    FireandBrimstone                       = Action.Create({ Type = "Spell", ID = 196408 }),
    BackdraftBuff                          = Action.Create({ Type = "Spell", ID = 117828, Hidden = true }),
    Conflagrate                            = Action.Create({ Type = "Spell", ID = 17962 }),
    Shadowburn                             = Action.Create({ Type = "Spell", ID = 17877 }),
    SummonInfernal                         = Action.Create({ Type = "Spell", ID = 1122 }),
    DarkSoulInstability                    = Action.Create({ Type = "Spell", ID = 113858 }),
    DarkSoulInstabilityBuff                = Action.Create({ Type = "Spell", ID = 113858, Hidden = true }),
    Berserking                             = Action.Create({ Type = "Spell", ID = 26297 }),
    BloodFury                              = Action.Create({ Type = "Spell", ID = 20572 }),
    Fireblood                              = Action.Create({ Type = "Spell", ID = 265221 }),
    GrimoireofSupremacyBuff                = Action.Create({ Type = "Spell", ID = 266091, Hidden = true }),
    InternalCombustion                     = Action.Create({ Type = "Spell", ID = 266134 }),
    ShadowburnDebuff                       = Action.Create({ Type = "Spell", ID = 17877, Hidden = true }),
    Flashover                              = Action.Create({ Type = "Spell", ID = 267115 }),
    CrashingChaos                          = Action.Create({ Type = "Spell", ID = 277644 }),
    Eradication                            = Action.Create({ Type = "Spell", ID = 196412 }),
    EradicationDebuff                      = Action.Create({ Type = "Spell", ID = 196414, Hidden = true }),
    PetKick                                = Action.Create({ Type = "SpellSingleColor", ID = 119910, Color = "RED", Desc = "RED Color for Pet Target kick" }),  
    FearGreen                              = Action.Create({ Type = "SpellSingleColor", ID = 5782, Color = "GREEN", Desc = "[2] Kick", Hidden = true, QueueForbidden = true }),	
    Fear                                   = Action.Create({ Type = "Spell", ID = 5782       }),
    SpellLock                              = Action.Create({ Type = "Spell", ID = 119898     }),
    DispellMagic                           = Action.Create({ Type = "Spell", ID = 111400     }),
    Shadowfury                             = Action.Create({ Type = "Spell", ID = 30283      }),
    -- Defensive 
    UnendingResolve                        = Action.Create({ Type = "Spell", ID = 104773     }),
	SingeMagic                             = Action.Create({ Type = "Spell", ID = 89808, Color = "YELLOW", Desc = "YELLOW Color for Pet Target dispel"     }),
    -- Utilities 
    DemonicCircle                          = Action.Create({ Type = "Spell", ID = 268358     }),
    DemonicCircleTeleport                  = Action.Create({ Type = "Spell", ID = 48020     }),
    -- PvP
    NetherWard                             = Action.Create({ Type = "Spell", ID = 212295     }), -- Spell Reflect	
    BaneofHavoc                            = Action.Create({ Type = "Spell", ID = 200546     }), -- Replace Havoc with same logic but on sticky zone
	DemonArmor                             = Action.Create({ Type = "Spell", ID = 285933     }), -- Demon Armor PvP		
	CurseofTongues                         = Action.Create({ Type = "Spell", ID = 199890     }), -- 30% increase cast time on target for 10sec
	CurseofWeakness                        = Action.Create({ Type = "Spell", ID = 199892     }), -- 30% reduction attack power for 10sec
	CastingCircle                          = Action.Create({ Type = "Spell", ID = 221703     }), -- Silence interrupt immune for 8sec
	CurseofShadows                         = Action.Create({ Type = "Spell", ID = 234877     }), -- Additional damage 10sec
	RotandDecay                            = Action.Create({ Type = "Spell", ID = 212371, Hidden = true        }), -- Drain Life increasing dots duration by 1sec per tick
	Soulshatter                            = Action.Create({ Type = "Spell", ID = 212356     }), -- Big burst on multi target 
    MortalCoil                             = Action.Create({ Type = "Spell", ID = 6789     }),
	-- Misc
    BurningRush                            = Action.Create({ Type = "Spell", ID = 278727     }),
    Channeling                             = Action.Create({ Type = "Spell", ID = 209274, Hidden = true     }),	-- Show an icon during channeling
    --TargetEnemy                          = Action.Create({ Type = "Spell", ID = 44603, Hidden = true     }),	-- Change Target (Tab button)
	--StopCast 				               = Action.Create({ Type = "Spell", ID = 61721, Hidden = true     }),		-- spell_magic_polymorphrabbit
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
	CorruptedGladiatorsBadge               = Action.Create({ Type = "Trinket", ID = 172669 }),
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
	ForbiddenObsidianClaw                  = Action.Create({ Type = "Trinket", ID = 173944 }),
	CorruptedGladiatorsMedallion           = Action.Create({ Type = "Trinket", ID = 172666 }), -- PvP Trinket 8.3
	ShiverVenomDebuff                      = Action.Create({ Type = "Spell", ID = 301624, Hidden = true     }),
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
    DummyTest                              = Action.Create({ Type = "Spell", ID = 159999, Hidden = true     }), -- Dummy stop dps icon	
};

-- To create essences use next code:
Action:CreateEssencesFor(ACTION_CONST_WARLOCK_DESTRUCTION)  -- where PLAYERSPEC is Constance (example: ACTION_CONST_MONK_BM)
local A = setmetatable(Action[ACTION_CONST_WARLOCK_DESTRUCTION], { __index = Action })


------------------------------------------
---------------- VARIABLES ---------------
------------------------------------------
local VarPoolSoulShards = false

A.Listener:Add("ROTATION_VARS", "PLAYER_REGEN_ENABLED", function()
  VarPoolSoulShards = false
end)

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
	ImmolateDelay                           = 0,
	CastStartTime                           = {},
}
local player = "player"
local SoulShardsP = Player:SoulShardsP()
local IsIndoors, UnitIsUnit, UnitName = IsIndoors, UnitIsUnit, UnitName

local function IsLatenced(self)
    -- @return boolean 
    return TMW.time - (Temp.CastStartTime[self:Info()] or 0) > GetGCD() + 0.5
end 

-- Chaos School tricks
-- https://wow.gamepedia.com/Chaos_(spell_school)
local ChaosSchool = {
    "SHADOW",
    "ARCANE",
    "FIRE",
    "FROST",
    "HOLY",
    "NATURE",
    "PHYSICAL"	
}
local function IsChaosSchoolFree()
	return LoC:IsMissed("SILENCE") and LoC:Get("SCHOOL_INTERRUPT", ChaosSchool) == 0
end 

local function IsFireSchoolFree()
	return LoC:IsMissed("SILENCE") and LoC:Get("SCHOOL_INTERRUPT", "FIRE") == 0
end 

local function IsShadowSchoolFree()
	return LoC:IsMissed("SILENCE") and LoC:Get("SCHOOL_INTERRUPT", "SHADOW") == 0
end 

local function FutureShard ()
    local Shard = Player:SoulShards()
    local castName, castStartTime, castEndTime, notInterruptable, spellID, isChannel = Unit(player):IsCasting()
    
    if not Unit(player):IsCasting() then
        return Shard
    else
        if spellID == A.SummonDoomGuard.ID 
                or spellID == A.SummonDoomGuardSuppremacy.ID 
                or spellID == A.SummonInfernal.ID
                or spellID == A.SummonInfernalSuppremacy.ID 
                or spellID == A.GrimoireFelhunter.ID 
                or spellID == A.SummonFelhunter.ID 
		then
            return Shard - 1
        else
            return Shard
        end
    end
end

-- API - Tracker
-- Initialize Tracker 
Pet:AddTrackers(ACTION_CONST_WARLOCK_DESTRUCTION, { -- this template table is the same with what has this library already built-in, just for example
    [89] = {
        name = "Infernal",
        duration = 30,
    },
})

-- Function to check for Infernal duration
local function InfernalTime()
    return Pet:GetRemainDuration(89) or 0
end 

local function InfernalIsActive()
    return InfernalTime() > 5.25 and true or false -- 5.25 because Vision of Perfection procs and Infernal with same NPC ID
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
		
    -- UnendingResolve
    local UnendingResolve = GetToggle(2, "UnendingResolve")
    if     UnendingResolve >= 0 and A.UnendingResolve:IsReady("player") and 
    (
        (     -- Auto 
            UnendingResolve >= 100 and 
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
                            Unit("player", 5):HasFlags() and 
                            Unit(player):GetRealTimeDMG() > 0 and 
                            Unit(player):IsFocused() 
                        )
                    )
                )
            ) and 
            Unit(player):HasBuffs("DeffBuffs", true) == 0
        ) or 
        (    -- Custom
            UnendingResolve < 100 and 
            Unit(player):HealthPercent() <= UnendingResolve
        )
    ) 
    then 
        return A.UnendingResolve
    end     
    -- Stoneform on self dispel (only PvE)
    if A.Stoneform:IsRacialReady("player", true) and not A.IsInPvP and A.AuraIsValid("player", "UseDispel", "Dispel") then 
        return A.Stoneform
    end 
	
	    -- HealingPotion
    local AbyssalHealingPotion = GetToggle(2, "AbyssalHealingPotionHP")
    if     AbyssalHealingPotion >= 0 and A.AbyssalHealingPotion:IsReady("player") and 
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
                            Unit("player", 5):HasFlags() and 
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
	
end 
SelfDefensives = A.MakeFunctionCachedStatic(SelfDefensives)

-- Non GCD spell check
local function countInterruptGCD(unit)
    if not A.PetKick:IsReadyByPassCastGCD(unit) or not A.PetKick:AbsentImun(unit, Temp.TotalAndMagKick) then
	    return true
	end
end

-- Interrupts spells : "MainPvP", "MainPvE", "MousePvE", "MousePvP"
local function Interrupts(unit)
    if A.GetToggle(2, "TasteInterruptList") and (IsInRaid() or A.InstanceInfo.KeyStone > 1) then
	    useKick, useCC, useRacial, notInterruptable, castRemainsTime, castDoneTime = Action.InterruptIsValid(unit, "TasteBFAContent", true, countInterruptGCD(unit))
	else
        useKick, useCC, useRacial, notInterruptable, castRemainsTime, castDoneTime = Action.InterruptIsValid(unit, nil, nil, countInterruptGCD(unit))
    end
	
	if castRemainsTime >= A.GetLatency() then
        if useKick and A.PetKick:IsReady(unit) and A.PetKick:AbsentImun(unit, Temp.TotalAndMagKick, true) then 
            return A.PetKick
        end 
    
        if useCC and A.Shadowfury:IsReady(unit) and MultiUnits:GetActiveEnemies() >= 2 and A.Shadowfury:AbsentImun(unit, Temp.TotalAndCC, true) then 
            return A.Shadowfury              
        end          
	
	    if useCC and A.Fear:IsReady(unit) and A.Fear:AbsentImun(unit, Temp.TotalAndCC, true) and 
		(
		    A.Zone ~= "arena" and Unit(unit):IsControlAble("disorient", 75) 
			or
			A.Zone == "arena" and
			(
			    Unit("player"):IsFocused("DAMAGER") and FriendlyTeam("HEALER"):GetCC() > 0
			    or 
			    EnemyTeam():IsCastingBreakAble(0.25) and FriendlyTeam():GetTTD(1, 5)
				or
				EnemyTeam("HEALER"):GetCC() > 0 and EnemyTeam("HEALER"):GetCC() <= A.Fear:GetSpellCastTime() + A.GetGCD()
			)
		)
		then 
            return A.Fear              
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
            if not notKickAble and Pet:IsActive(417) and A.PetKick:IsReady(unit, nil, nil, true) and A.PetKick:AbsentImun(unit, Temp.TotalAndMag, true) then
                return A.PetKick:Show(icon)                                                  
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

local function IsSaveManaPhase()
    if not A.IsInPvP and GetToggle(2, "ManaManagement") and Unit(player):HasBuffs(A.Innervate.ID) == 0 then 
        for i = 1, MAX_BOSS_FRAMES do 
            if Unit("boss" .. i):IsExists() and not Unit("boss" .. i):IsDead() and Unit(player):PowerPercent() < Unit("boss" .. i):HealthPercent() then 
                return true 
            end 
        end 
    end 
    return Unit(player):PowerPercent() < 20 
end 
IsSaveManaPhase = A.MakeFunctionCachedStatic(IsSaveManaPhase)



local Havoc_Nameplates = MultiUnits:GetActiveUnitPlates()
local pairs = pairs

local function HavocDebuffTime()
    --local Havoc_Nameplates = MultiUnits:GetActiveUnitPlates() -- don't use here, it will create pointer to table from this function which overflow memory a bit
   -- if Havoc_Nameplates then  
        for Havoc_UnitID in pairs(Havoc_Nameplates) do
            local debuff = Unit(Havoc_UnitID):HasDeBuffs(A.Havoc.ID, true)
            if debuff > 0 then         
                return debuff 
            --else -- logical error
               -- return 0
            end
        end
    --end    
    return 0    
end
HavocDebuffTime = A.MakeFunctionCachedStatic(HavocDebuffTime)

-- Pet Handler UI --
local function HandlePetChoice()
    local choice = GetToggle(2, "PetChoice")
    local currentspell = "Spell(688)"
    
    if choice == "IMP" then
        --print("IMP")
        currentspell = "Spell(688)"    
    elseif choice == "VOIDWALKER" then
        --print("VOIDWALKER")
        currentspell = "Spell(697)"
    elseif choice == "FELHUNTER" then 
        --print("FELHUNTER")    
        currentspell = "Spell(691)"
    elseif choice == "SUCCUBUS" then 
        --print("SUCCUBUS")    
        currentspell = "Spell(712)"
    else
        print("No Pet Data")
    end
    return choice
end
HandlePetChoice = A.MakeFunctionCachedStatic(HandlePetChoice)

local function InRange(unit)
	-- @return boolean 
	return A.Incinerate:IsInRange(unit)
end 

-- @return boolean  
-- @parameters count, range are mandatory, others parameters optionals
local function GetByRange(count, range, isStrictlySuperior, isStrictlyInferior, isCheckEqual, isCheckCombat)
	-- @return boolean 
	local c = 0 
	
	if isStrictlySuperior == nil then
	    isStrictlySuperior = false
	end

	if isStrictlyInferior == nil then
	    isStrictlyInferior = false
	end	
	
	for unit in pairs(ActiveUnitPlates) do 
		if (not isCheckEqual or not UnitIsUnit("target", unit)) and (not isCheckCombat or Unit(unit):CombatTime() > 0) then 
			if InRange(unit) then 
				c = c + 1
			elseif range then 
				local r = Unit(unit):GetRange()
				if r > 0 and r <= range then 
					c = c + 1
				end 
			end 
			-- Strictly superior than >
			if isStrictlySuperior and not isStrictlyInferior then
			    if c > count then
				    return true
				end
			end
			
			-- Stryctly inferior <
			if isStrictlyInferior and not isStrictlySuperior then
			    if c < count then
			        return true
				end
			end
			
			-- Classic >=
			if not isStrictlyInferior and not isStrictlySuperior then
			    if c >= count then 
				    return true 
			    end 
			end
		end 
		
	end
	
end  
GetByRange = A.MakeFunctionCachedDynamic(GetByRange) 

local function EvaluateCycleImmolate46(unit)
  return Unit(unit):HasDeBuffs(A.ImmolateDebuff.ID, true) < 5 and (not A.Cataclysm:IsSpellLearned() or A.Cataclysm:GetCooldown() > Unit(unit):HasDeBuffs(A.ImmolateDebuff.ID, true))
end

local function EvaluateCycleHavoc71(unit)
  return not (Unit(unit):GetUnitID() == A.LastTargetUnitID) and MultiUnits:GetActiveEnemies() < 4
end

local function EvaluateCycleHavoc106(unit)
  return not (Unit(unit):GetUnitID() == A.LastTargetUnitID) and (not A.GrimoireofSupremacy:IsSpellLearned() or not A.Inferno:IsSpellLearned() or A.GrimoireofSupremacy:IsSpellLearned() and Unit(unit):HasDeBuffs(A.HavocDebuff.ID, true) <= 10)
end

local function EvaluateCycleImmolate507(unit)
  return Unit(unit):HasDeBuffsRefreshable(A.ImmolateDebuff.ID, true) and (not A.Cataclysm:IsSpellLearned() or A.Cataclysm:GetCooldown() > Unit(unit):HasDeBuffs(A.ImmolateDebuff.ID, true))
end

local function EvaluateCycleHavoc572(unit)
  return not (Unit(unit):GetUnitID() == A.LastTargetUnitID) and (Unit(unit):HasDeBuffs(A.ImmolateDebuff.ID, true) > 18 * 0.5 or not A.InternalCombustion:IsSpellLearned()) and (not A.SummonInfernal:GetCooldown() == 0 or not A.GrimoireofSupremacy:IsSpellLearned() or A.GrimoireofSupremacy:IsSpellLearned() and Unit(unit):HasDeBuffs(A.HavocDebuff.ID, true) <= 10)
end

--- ======= ACTION LISTS =======
-- [3] Single Rotation
A[3] = function(icon, isMulti)
    --------------------
    --- ROTATION VAR ---
    --------------------
    local isMoving = A.Player:IsMoving()
    local inCombat = Unit(player):CombatTime() > 0
	local combatTime = Unit(player):CombatTime()
    local ShouldStop = Action.ShouldStop()
    local Pull = Action.BossMods:GetPullTimer()
	local profileStop = false
    local InfernalIsActive = InfernalIsActive()
	local InfernalTime = InfernalTime()
	local RainofFireUnits = GetToggle(2, "RainofFireUnits")	
	local RainofFireRange = GetToggle(2, "RainofFireRange")	
	local RainofFireTTD = GetToggle(2, "RainofFireTTD")
    local RainofFireForceUse = GetToggle(2, "RainofFireForceUse") -- Ignore CrashingChaos buffs
	local HavocTTD = GetToggle(2, "HavocTTD")
	local HavocPoolShards = GetToggle(2, "HavocPoolShards")	
	local HavocRange = GetToggle(2, "HavocRange")
	local HavocUnits = GetToggle(2, "HavocUnits")
	local AutoHavoc = GetToggle(2, "AutoHavoc")
    local IgnoreChaosBolt = GetToggle(2, "IgnoreChaosBolt")
	local UseFearAsInterrupt = GetToggle(2, "UseFearAsInterrupt")
	local DummyStopDelay = GetToggle(2, "DummyStopDelay")
	local MortalCoilHP = GetToggle(2, "MortalCoilHP")
	local HeartOfAzeroth = Action.GetToggle(1, "HeartOfAzeroth")
	local Racial = Action.GetToggle(1, "Racial")
	
	local arenaID = "arena1" or "arena2" or "arena3"
	
    -- Call for Havoc debuff tracking on every unit nameplates
	HavocDebuffTime()
    local HavocRemains = HavocDebuffTime()
    local EnemyHasHavoc = HavocRemains > 0	
	-- Pet Selection Menu
    local PetSpell = HandlePetChoice()    
    if PetSpell == "IMP" then
        SummonPet = A.SummonImp    
    elseif PetSpell == "VOIDWALKER" then
        SummonPet = A.SummonVoidwalker
    elseif PetSpell == "FELHUNTER" then    
        SummonPet = A.SummonFelhunter
    elseif PetSpell == "SUCCUBUS" then     
        SummonPet = A.SummonSuccubus
    else
        Action.Print("Error : You have to select Pet in UI Settings.") 
    end	

    local castName    = Unit(player):IsCasting()
    -- Log CastStartTime - Latency
    if castName then 
        Temp.CastStartTime[castName] = TMW.time 
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
         	    
				if endtimer < TMW.time + DummyStopDelay then
				    profileStop = true
				    --return A.DummyTest:Show(icon)
				end
    	    end
  	    end
	end	
	
   	-- Out of combat Pet Handler
   	if SummonPet:IsReady(unit) and IsLatenced(SummonPet) and (not isMoving) and not ShouldStop and not Pet:IsActive() then
       	return SummonPet:Show(icon)
   	end
    
	if Temp.ImmolateDelay == 0 and A.Immolate:IsSpellInCasting() then
        Temp.ImmolateDelay = 15
    end
    
    if Temp.ImmolateDelay > 0 then
    --    print(Temp.ImmolateDelay)
        Temp.ImmolateDelay = Temp.ImmolateDelay - 1
    end
    ------------------------------------------------------
    ---------------- ENEMY UNIT ROTATION -----------------
    ------------------------------------------------------
    local function EnemyRotation(unit)
	   --print(InfernalIsActive)		
            
			-- VarPoolSoulShards
			VarPoolSoulShards = 
			(
			    -- Pool Havoc
				(GetToggle(2, "AoE") and AutoHavoc and Player:SoulShards() < HavocPoolShards and MultiUnits:GetByRange(HavocRange) > 1 and A.Havoc:GetCooldown() <= 5)  
				or 
				-- Pool for coming Burst
				(A.BurstIsON(unit) and Player:SoulShards() < 3.8 and A.SummonInfernal:GetCooldown() <= 5) --and 
			)    
	
				--( 
			   --    (A.GrimoireofSupremacy:IsSpellLearned() or A.DarkSoulInstability:IsSpellLearned() and A.DarkSoulInstability:GetCooldown() <= 15) 
				--	or 
				--	A.DarkSoulInstability:IsSpellLearned() and A.DarkSoulInstability:GetCooldown() <= 15 and (A.SummonInfernal:GetCooldown() > Unit(unit):TimeToDie() or A.SummonInfernal:GetCooldown() + 30 > Unit(unit):TimeToDie())
			   -- )
					
					--print(VarPoolSoulShards)
					
        -- Precombat
        local function Precombat(unit)
            -- flask
            -- food
            -- augmentation
        	-- summon_pet
        	if SummonPet:IsReady(unit) and IsLatenced(SummonPet) and (not isMoving) and not ShouldStop and not Pet:IsActive() then
            	return SummonPet:Show(icon)
        	end
			
            -- grimoire_of_sacrifice,if=talent.grimoire_of_sacrifice.enabled
            if A.GrimoireofSacrifice:IsReady(unit) and (A.GrimoireofSacrifice:IsSpellLearned()) then
                return A.GrimoireofSacrifice:Show(icon)
            end
			
            -- snapshot_stats
            -- potion
            if A.PotionofUnbridledFury:IsReady(unit) and Action.GetToggle(1, "Potion") then
                return A.PotionofUnbridledFury:Show(icon)
            end
			
            -- soul_fire
            if A.SoulFire:IsReady(unit) and MultiUnits:GetByRange(40) < 2 then
                return A.SoulFire:Show(icon)
            end

            -- cataclysm,if=!(pet.infernal.active&dot.immolate.remains+1>InfernalTime)|spell_targets.cataclysm>1|!talent.grimoire_of_supremacy.enabled
            if A.Cataclysm:IsReady("player") and not isMoving and MultiUnits:GetByRange(40) >= 2 and Action.GetToggle(1, "AoE") and Unit("mouseover"):IsExists() then
                return A.Cataclysm:Show(icon)
            end
			
            -- incinerate,if=!talent.soul_fire.enabled
            if A.Incinerate:IsReady(unit) and SoulShardsP < 5 and not A.SoulFire:IsSpellLearned() then
                return A.Incinerate:Show(icon)
            end
			
        end
        Precombat = A.MakeFunctionCachedDynamic(Precombat)
		
		
		
        -- Cds
		-- Contains all burst cooldown, essences and high end items 
        local function Cooldowns(unit)
		    local Trinket1IsAllowed, Trinket2IsAllowed = TR.TrinketIsAllowed()
			
			-- Non SIMC Custom Trinket1
    		if A.Trinket1:IsReady(unit) and Trinket1IsAllowed and inCombat and     
			(
   				A.GetToggle(2, "TrinketsAoE") and GetByRange(A.GetToggle(2, "TrinketsMinUnits"), A.GetToggle(2, "TrinketsUnitsRange")) and Player:AreaTTD(A.GetToggle(2, "TrinketsUnitsRange")) > A.GetToggle(2, "TrinketsMinTTD")	
				or
				not A.GetToggle(2, "TrinketsAoE") and Unit(unit):TimeToDie() >= A.GetToggle(2, "TrinketsMinTTD")	 					
			)
			then 
   	    		return A.Trinket1:Show(icon)
    		end 		
	        	
			-- Non SIMC Custom Trinket2
    		if A.Trinket2:IsReady(unit) and Trinket2IsAllowed and inCombat and    
			(
   				A.GetToggle(2, "TrinketsAoE") and GetByRange(A.GetToggle(2, "TrinketsMinUnits"), A.GetToggle(2, "TrinketsUnitsRange")) and Player:AreaTTD(A.GetToggle(2, "TrinketsUnitsRange")) > A.GetToggle(2, "TrinketsMinTTD")	
				or
				not A.GetToggle(2, "TrinketsAoE") and Unit(unit):TimeToDie() >= A.GetToggle(2, "TrinketsMinTTD")					
			)
			then
   	   			return A.Trinket2:Show(icon) 	
   		    end	
			
            -- use_item,name=azsharas_font_of_power,if=cooldown.summon_infernal.up|cooldown.summon_infernal.remains<=4
            if A.AzsharasFontofPower:IsReady("player") and (A.SummonInfernal:GetCooldown() == 0 or A.SummonInfernal:GetCooldown() <= 4) then
                return A.AzsharasFontofPower:Show(icon)
            end
			
            -- summon_infernal
            if A.SummonInfernal:IsReady("player") and IsFireSchoolFree() then
                return A.SummonInfernal:Show(icon)
            end
			
            -- guardian_of_azeroth,if=pet.infernal.active
            if A.GuardianofAzeroth:AutoHeartOfAzeroth(unit, true) and HeartOfAzeroth and (InfernalIsActive) then
                return A.GuardianofAzeroth:Show(icon)
            end
			
            -- dark_soul_instability,if=pet.infernal.active&(InfernalTime<20.5|InfernalTime<22&soul_shard>=3.6|!talent.grimoire_of_supremacy.enabled)
            if A.DarkSoulInstability:IsSpellLearned() and A.DarkSoulInstability:IsReadyByPassCastGCD("player", true, nil, true) and IsFireSchoolFree() and 
			(
			    InfernalIsActive and 
				(
				    InfernalTime < 20.5 
					or 
					InfernalTime < 22 and SoulShardsP >= 3.6 
					or 
					not A.GrimoireofSupremacy:IsSpellLearned()
				)
				or A.LastPlayerCastName == A.SummonInfernal:Info()
			) 
			then
                return A.DarkSoulInstability:Show(icon)
            end
			
            -- memory_of_lucid_dreams,if=pet.infernal.active&(InfernalTime<15.5|soul_shard<3.5&(buff.dark_soul_instability.up|!talent.grimoire_of_supremacy.enabled&dot.immolate.remains>12))
            if A.MemoryofLucidDreams:AutoHeartOfAzeroth(unit, true) and HeartOfAzeroth and (InfernalIsActive and (InfernalTime < 15.5 or SoulShardsP < 3.5 and (Unit(player):HasBuffs(A.DarkSoulInstabilityBuff.ID, true) > 0 or not A.GrimoireofSupremacy:IsSpellLearned() and Unit(unit):HasDeBuffs(A.ImmolateDebuff.ID, true) > 12))) then
                return A.MemoryofLucidDreams:Show(icon)
            end
			
            -- summon_infernal,if=target.time_to_die>cooldown.summon_infernal.duration+30
            if A.SummonInfernal:IsReady("player") and IsFireSchoolFree() and (Unit(unit):TimeToDie() > 30 + 30) then
                return A.SummonInfernal:Show(icon)
            end
			
            -- guardian_of_azeroth,if=time>30&target.time_to_die>cooldown.guardian_of_azeroth.duration+30
            if A.GuardianofAzeroth:AutoHeartOfAzeroth(unit, true) and HeartOfAzeroth and (Unit(player):CombatTime() > 30 and Unit(unit):TimeToDie() > 180 + 30) then
                return A.GuardianofAzeroth:Show(icon)
            end
			
            -- summon_infernal,if=talent.dark_soul_instability.enabled&cooldown.dark_soul_instability.remains>target.time_to_die
            if A.SummonInfernal:IsReady("player") and IsFireSchoolFree() and (A.DarkSoulInstability:IsSpellLearned() and A.DarkSoulInstability:GetCooldown() > Unit(unit):TimeToDie()) then
                return A.SummonInfernal:Show(icon)
            end
			
            -- guardian_of_azeroth,if=cooldown.summon_infernal.remains>target.time_to_die
            if A.GuardianofAzeroth:AutoHeartOfAzeroth(unit, true) and HeartOfAzeroth and (A.SummonInfernal:GetCooldown() > Unit(unit):TimeToDie()) then
                return A.GuardianofAzeroth:Show(icon)
            end
			
            -- memory_of_lucid_dreams,if=cooldown.summon_infernal.remains>target.time_to_die&(InfernalTime<15.5|buff.dark_soul_instability.up&soul_shard<3)
            if A.MemoryofLucidDreams:AutoHeartOfAzeroth(unit, true) and HeartOfAzeroth and (A.SummonInfernal:GetCooldown() > Unit(unit):TimeToDie() and (InfernalTime < 15.5 or Unit(player):HasBuffs(A.DarkSoulInstabilityBuff.ID, true) > 0 and SoulShardsP < 3)) then
                return A.MemoryofLucidDreams:Show(icon)
            end
			
            -- summon_infernal,if=target.time_to_die<30
            if A.SummonInfernal:IsReady("player") and (Unit(unit):TimeToDie() < 30) then
                return A.SummonInfernal:Show(icon)
            end
			
            -- guardian_of_azeroth,if=target.time_to_die<30
            if A.GuardianofAzeroth:AutoHeartOfAzeroth(unit, true) and HeartOfAzeroth and (Unit(unit):TimeToDie() < 30) then
                return A.GuardianofAzeroth:Show(icon)
            end
			
            -- dark_soul_instability,if=target.time_to_die<21&target.time_to_die>4
            if A.DarkSoulInstability:IsReadyByPassCastGCD("player", true, nil, nil) and (Unit(unit):TimeToDie() < 21 and Unit(unit):TimeToDie() > 4) then
                return A.DarkSoulInstability:Show(icon)
            end
			
            -- memory_of_lucid_dreams,if=target.time_to_die<16&target.time_to_die>6
            if A.MemoryofLucidDreams:AutoHeartOfAzeroth(unit, true) and HeartOfAzeroth and (Unit(unit):TimeToDie() < 16 and Unit(unit):TimeToDie() > 6) then
                return A.MemoryofLucidDreams:Show(icon)
            end
			
            -- blood_of_the_enemy
            if A.BloodoftheEnemy:AutoHeartOfAzeroth(unit, true) and HeartOfAzeroth then
                return A.BloodoftheEnemy:Show(icon)
            end
			
            -- worldvein_resonance
            if A.WorldveinResonance:AutoHeartOfAzeroth(unit, true) and HeartOfAzeroth then
                return A.WorldveinResonance:Show(icon)
            end
			
            -- ripple_in_space
            if A.RippleinSpace:AutoHeartOfAzeroth(unit, true) and HeartOfAzeroth then
                return A.RippleinSpace:Show(icon)
            end
			
            -- potion,if=pet.infernal.active|target.time_to_die<30
            if A.PotionofUnbridledFury:IsReady(unit) and Action.GetToggle(1, "Potion") and (InfernalIsActive or Unit(unit):TimeToDie() < 30) then
                return A.PotionofUnbridledFury:Show(icon)
            end
			
            -- berserking,if=pet.infernal.active&(!talent.grimoire_of_supremacy.enabled|(!essence.memory_of_lucid_dreams.major|buff.memory_of_lucid_dreams.remains)&(!talent.dark_soul_instability.enabled|buff.dark_soul_instability.remains))|target.time_to_die<=15
            if A.Berserking:AutoRacial(unit) and Racial and A.BurstIsON(unit) and InfernalIsActive and (not A.DarkSoulInstability:IsSpellLearned() or Unit(player):HasBuffs(A.DarkSoulInstabilityBuff.ID, true) > 0) then
                return A.Berserking:Show(icon)
            end
			
            -- blood_fury,if=pet.infernal.active&(!talent.grimoire_of_supremacy.enabled|(!essence.memory_of_lucid_dreams.major|buff.memory_of_lucid_dreams.remains)&(!talent.dark_soul_instability.enabled|buff.dark_soul_instability.remains))|target.time_to_die<=15
            if A.BloodFury:AutoRacial(unit) and Racial and A.BurstIsON(unit) and InfernalIsActive and (not A.DarkSoulInstability:IsSpellLearned() or Unit(player):HasBuffs(A.DarkSoulInstabilityBuff.ID, true) > 0) then
                return A.BloodFury:Show(icon)
            end
			
            -- bag_of_tricks
            if A.BagofTricks:AutoRacial(unit) and Racial and A.BurstIsON(unit) then
                return A.BagofTricks:Show(icon)
            end
			
            -- fireblood,if=pet.infernal.active&(!talent.grimoire_of_supremacy.enabled|(!essence.memory_of_lucid_dreams.major|buff.memory_of_lucid_dreams.remains)&(!talent.dark_soul_instability.enabled|buff.dark_soul_instability.remains))|target.time_to_die<=15
            if A.Fireblood:AutoRacial(unit) and Racial and A.BurstIsON(unit) and InfernalIsActive and (not A.DarkSoulInstability:IsSpellLearned() or Unit(player):HasBuffs(A.DarkSoulInstabilityBuff.ID, true) > 0) then
                return A.Fireblood:Show(icon)
            end
			
            -- use_item,name=pocketsized_computation_device,if=dot.immolate.remains>=5&(cooldown.summon_infernal.remains>=20|target.time_to_die<30)
            if A.CorruptedGladiatorsMedallion:IsReady("player") and 
			(
			    Unit(unit):HasDeBuffs(A.ImmolateDebuff.ID, true) >= 5 and 
				(
				    A.SummonInfernal:GetCooldown() >= 20 
					or 
					Unit(unit):TimeToDie() < 30 
					or 
					A.IsInPvP and Unit(unit):TimeToDie() < 5
				)
			)
			then
                return A.CorruptedGladiatorsMedallion:Show(icon)
            end
			
            -- use_item,name=ForbiddenObsidianClaw,if=dot.immolate.remains>=5&(cooldown.summon_infernal.remains>=20|target.time_to_die<30)
            if A.ForbiddenObsidianClaw:IsReady(unit) and (Unit(unit):HasDeBuffs(A.ImmolateDebuff.ID, true) >= 5 and (A.SummonInfernal:GetCooldown() >= 20 or Unit(unit):TimeToDie() < 30 or A.IsInPvP)) then
                return A.ForbiddenObsidianClaw:Show(icon)
            end	
			
            -- use_items,if=pet.infernal.active&(!talent.grimoire_of_supremacy.enabled|InfernalTime<=20)|target.time_to_die<=20
            -- use_item,name=pocketsized_computation_device,if=dot.immolate.remains>=5&(cooldown.summon_infernal.remains>=20|target.time_to_die<30)
            if A.PocketsizedComputationDevice:IsReady(unit) and (Unit(unit):HasDeBuffs(A.ImmolateDebuff.ID, true) >= 5 and (A.SummonInfernal:GetCooldown() >= 20 or Unit(unit):TimeToDie() < 30)) then
                return A.PocketsizedComputationDevice:Show(icon)
            end
			
            -- use_item,name=rotcrusted_voodoo_doll,if=dot.immolate.remains>=5&(cooldown.summon_infernal.remains>=20|target.time_to_die<30)
            if A.RotcrustedVoodooDoll:IsReady(unit) and (Unit(unit):HasDeBuffs(A.ImmolateDebuff.ID, true) >= 5 and (A.SummonInfernal:GetCooldown() >= 20 or Unit(unit):TimeToDie() < 30)) then
                return A.RotcrustedVoodooDoll:Show(icon)
            end
			
            -- use_item,name=shiver_venom_relic,if=dot.immolate.remains>=5&(cooldown.summon_infernal.remains>=20|target.time_to_die<30)
            if A.ShiverVenomRelic:IsReady(unit) and Unit(unit):HasDeBuffsStacks(A.ShiverVenomDebuff.ID, true) >= 5 and (Unit(unit):HasDeBuffs(A.ImmolateDebuff.ID, true) >= 5 and (A.SummonInfernal:GetCooldown() >= 20 or Unit(unit):TimeToDie() < 30)) then
                return A.ShiverVenomRelic:Show(icon)
            end
			
            -- use_item,name=aquipotent_nautilus,if=dot.immolate.remains>=5&(cooldown.summon_infernal.remains>=20|target.time_to_die<30)
            if A.AquipotentNautilus:IsReady(unit) and (Unit(unit):HasDeBuffs(A.ImmolateDebuff.ID, true) >= 5 and (A.SummonInfernal:GetCooldown() >= 20 or Unit(unit):TimeToDie() < 30)) then
                return A.AquipotentNautilus:Show(icon)
            end
			
            -- use_item,name=tidestorm_codex,if=dot.immolate.remains>=5&(cooldown.summon_infernal.remains>=20|target.time_to_die<30)
            if A.TidestormCodex:IsReady(unit) and (Unit(unit):HasDeBuffs(A.ImmolateDebuff.ID, true) >= 5 and (A.SummonInfernal:GetCooldown() >= 20 or Unit(unit):TimeToDie() < 30)) then
                return A.TidestormCodex:Show(icon)
            end
			
            -- use_item,name=vial_of_storms,if=dot.immolate.remains>=5&(cooldown.summon_infernal.remains>=20|target.time_to_die<30)
            if A.VialofStorms:IsReady(unit) and (Unit(unit):HasDeBuffs(A.ImmolateDebuff.ID, true) >= 5 and (A.SummonInfernal:GetCooldown() >= 20 or Unit(unit):TimeToDie() < 30)) then
                return A.VialofStorms:Show(icon)
            end
			
        end
        Cooldowns = A.MakeFunctionCachedDynamic(Cooldowns)
		
        --Aoe
        local function Aoe(unit)
            -- rain_of_fire,if=pet.infernal.active&(buff.crashing_chaos.down|!talent.grimoire_of_supremacy.enabled)&(!cooldown.havoc.ready|active_enemies>3)
            if A.RainofFire:IsReady("player") and IsFireSchoolFree() and GetToggle(2, "AoE") and Player:AreaTTD(RainofFireRange) > RainofFireTTD
			and MultiUnits:GetByRange(RainofFireRange) > RainofFireUnits and  
			    (
				    (
					    (Unit(player):HasBuffs(A.CrashingChaosBuff.ID, true) == 0 or RainofFireForceUse)
						or 
						not A.GrimoireofSupremacy:IsSpellLearned()
					) 
					and 
					(
					    (
						    (
							    A.Havoc:GetCooldown() > 0 
								or 
								not AutoHavoc
							)							 
						) 
					    or 
					    MultiUnits:GetByRange(RainofFireRange) > RainofFireUnits
					)
				)
			then
                return A.RainofFire:Show(icon)
            end
			
            -- channel_demonfire,if=dot.immolate.remains>cast_time
            if A.ChannelDemonfire:IsReady(unit) and IsFireSchoolFree() and (Unit(unit):HasDeBuffs(A.ImmolateDebuff.ID, true) > A.ChannelDemonfire:GetSpellCastTime()) then
                return A.ChannelDemonfire:Show(icon)
            end
			
            -- immolate,cycle_targets=1,if=remains<5&(!talent.cataclysm.enabled|cooldown.cataclysm.remains>remains)
            if A.Immolate:IsReady(unit) and 
			not Unit(unit):IsExplosives() and 
			IsFireSchoolFree() and 
			A.LastPlayerCastName ~= A.Immolate:Info() and 
			Unit(unit):HasDeBuffs(A.ImmolateDebuff.ID, true) < 5 and 
			(
			    not A.Cataclysm:IsSpellLearned() 
				or
				A.Cataclysm:GetCooldown() > Unit(unit):HasDeBuffs(A.ImmolateDebuff.ID, true)
			)
			then
                return A.Immolate:Show(icon) 
            end
			
            -- call_action_list,name=cds
            if A.BurstIsON(unit) and Cooldowns(unit) then
                return true
            end
			
	--[[		
			-- if Havoc available then use it on main target
			if A.Havoc:IsReady(unit) and GetToggle(2, "AutoHavoc") and MultiUnits:GetByRange(40) > 1 then 
                local currentUnitID = Unit(unit):GetUnitID()
                -- if boss frames				
				for i = 1, MAX_BOSS_FRAMES do 
                    if Unit("boss" .. i):IsExists() and not Unit("boss" .. i):InLOS() and not Unit("boss" .. i):IsDead() and Unit("boss" .. i):HasDeBuffs(A.HavocDebuff.ID, true) > 0 then
				        if A.LastTarget and not A.LastTargetIsExists and Unit("boss" .. i):GetUnitID() ~= A.LastTargetUnitID then
				            return A:Show(icon, A.LastTargetTexture)
				        else
						    if Unit("boss" .. i):HasDeBuffs(A.HavocDebuff.ID, true) == 0 then
							    return A.Havoc:Show(icon)
							end
				        return A:Show(icon, ACTION_CONST_AUTOTARGET)
			            end
                    end   
			    end  
				-- normal behavior
                local PotentialHavoc_Nameplates = MultiUnits:GetActiveUnitPlates()				
                if PotentialHavoc_Nameplates then  
                    for PotentialHavoc_UnitID in pairs(PotentialHavoc_Nameplates) do  
                        if Unit(PotentialHavoc_UnitID):IsExists() and not Unit(PotentialHavoc_UnitID):InLOS() and not Unit(PotentialHavoc_UnitID):IsDead() and Unit(PotentialHavoc_UnitID):HasDeBuffs(A.HavocDebuff.ID, true) > 0 then
				            if A.LastTarget and not A.LastTargetIsExists and Unit(PotentialHavoc_UnitID):GetUnitID() ~= A.LastTargetUnitID then
				                return A:Show(icon, A.LastTargetTexture)
				            else
						        if Unit(PotentialHavoc_UnitID):HasDeBuffs(A.HavocDebuff.ID, true) == 0 then
							        return A.Havoc:Show(icon)
							    end
				            return A:Show(icon, ACTION_CONST_AUTOTARGET)
			                end
                        end  					        
                    end 
                end
			end
			]]--
				
            -- chaos_bolt,if=talent.grimoire_of_supremacy.enabled&pet.infernal.active&(havoc_active|talent.cataclysm.enabled|talent.inferno.enabled&active_enemies<4)
            if A.ChaosBolt:IsReady(unit) and A.ChaosBolt:AbsentImun(unit, Temp.TotalAndMag) and not RainofFireForceUse and not VarPoolSoulShards and IsChaosSchoolFree() and 
			(
			    A.GrimoireofSupremacy:IsSpellLearned() and InfernalIsActive and 
				(
				    EnemyHasHavoc 
					or 
					A.Cataclysm:IsSpellLearned() 
					or 
					A.Inferno:IsSpellLearned() and MultiUnits:GetActiveEnemies() <= 4
				)
				or 
				(
				    EnemyHasHavoc and Player:SoulShards() >= HavocPoolShards
				)
			)
			then
                return A.ChaosBolt:Show(icon)
            end
			
            -- focused_azerite_beam
            if A.FocusedAzeriteBeam:AutoHeartOfAzeroth(unit, true) and HeartOfAzeroth then
                return A.FocusedAzeriteBeam:Show(icon)
            end
			
            -- purifying_blast
            if A.PurifyingBlast:AutoHeartOfAzeroth(unit, true) and HeartOfAzeroth then
                return A.PurifyingBlast:Show(icon)
            end
            -- havoc,cycle_targets=1,if=!(target=self.target)&(!talent.grimoire_of_supremacy.enabled|!talent.inferno.enabled|talent.grimoire_of_supremacy.enabled&InfernalTime<=10)
           -- if A.Havoc:IsReady(unit) then
          --      if Action.Utils.CastTargetIf(A.Havoc, 40, "min", EvaluateCycleHavoc106) then
          --          return A.Havoc:Show(icon) 
          --      end
          --  end
		  
            -- incinerate,if=talent.fire_and_brimstone.enabled&buff.backdraft.up&soul_shard<5-0.2*active_enemies
            if A.Incinerate:IsReady(unit) and IsFireSchoolFree() and (A.FireandBrimstone:IsSpellLearned() and Unit(player):HasBuffs(A.BackdraftBuff.ID, true) > 0 and SoulShardsP < 5 - 0.2 * MultiUnits:GetByRange(40)) then
                return A.Incinerate:Show(icon)
            end
			
            -- soul_fire
            if A.SoulFire:IsReady(unit) and IsFireSchoolFree() then
                return A.SoulFire:Show(icon)
            end
			
            -- conflagrate,if=buff.backdraft.down
            if A.Conflagrate:IsReady(unit) and IsFireSchoolFree() and (Unit(player):HasBuffs(A.BackdraftBuff.ID, true) == 0) then
                return A.Conflagrate:Show(icon)
            end
			
            -- shadowburn,if=!talent.fire_and_brimstone.enabled
            if A.Shadowburn:IsReady(unit) and IsShadowSchoolFree() and (not A.FireandBrimstone:IsSpellLearned()) then
                return A.Shadowburn:Show(icon)
            end
			
            -- concentrated_flame,if=!dot.concentrated_flame_burn.remains&!action.concentrated_flame.in_flight&active_enemies<5
            if A.ConcentratedFlame:AutoHeartOfAzeroth(unit, true) and HeartOfAzeroth and (Unit(unit):HasDeBuffs(A.ConcentratedFlameBurn.ID, true) == 0 and not A.ConcentratedFlame:IsSpellInFlight() and MultiUnits:GetActiveEnemies() < 5) then
                return A.ConcentratedFlame:Show(icon)
            end
			
            -- incinerate
            if A.Incinerate:IsReady(unit) and IsFireSchoolFree() and SoulShardsP < 5 then
                return A.Incinerate:Show(icon)
            end
			
        end
		Aoe = A.MakeFunctionCachedDynamic(Aoe)
                
        --GosupInfernal
        local function GosupInfernal(unit)
            -- rain_of_fire,if=soul_shard=5&!buff.backdraft.up&buff.memory_of_lucid_dreams.up&buff.grimoire_of_supremacy.stack<=10
            if A.RainofFire:IsReady("player") and IsFireSchoolFree() and GetToggle(2, "AoE") 
			and MultiUnits:GetByRange(RainofFireRange) > RainofFireUnits and 
			(
			    SoulShardsP == 5 and Unit(player):HasBuffs(A.BackdraftBuff.ID, true) == 0 and Unit(player):HasBuffs(A.MemoryofLucidDreams.ID, true) > 0 and Unit(player):HasBuffsStacks(A.GrimoireofSupremacyBuff.ID, true) <= 10
			)
			then
                return A.RainofFire:Show(icon)
            end
            -- chaos_bolt,if=buff.backdraft.up
            if A.ChaosBolt:IsReady(unit) and A.ChaosBolt:AbsentImun(unit, Temp.TotalAndMag) and IsChaosSchoolFree() and (Unit(player):HasBuffs(A.BackdraftBuff.ID, true) > 0) and not RainofFireForceUse then
                return A.ChaosBolt:Show(icon)
            end
            -- chaos_bolt,if=soul_shard>=4.2-buff.memory_of_lucid_dreams.up
            if A.ChaosBolt:IsReady(unit) and A.ChaosBolt:AbsentImun(unit, Temp.TotalAndMag) and IsChaosSchoolFree() and (SoulShardsP >= 4.2 - num(Unit(player):HasBuffs(A.MemoryofLucidDreams.ID, true) > 0)) and not RainofFireForceUse then
                return A.ChaosBolt:Show(icon)
            end
            -- chaos_bolt,if=!cooldown.conflagrate.up
            if A.ChaosBolt:IsReady(unit) and A.ChaosBolt:AbsentImun(unit, Temp.TotalAndMag) and IsChaosSchoolFree() and A.Conflagrate:GetCooldown() > 0 and not RainofFireForceUse then
                return A.ChaosBolt:Show(icon)
            end
            -- chaos_bolt,if=cast_time<InfernalTime&InfernalTime<cast_time+gcd
            if A.ChaosBolt:IsReady(unit) and A.ChaosBolt:AbsentImun(unit, Temp.TotalAndMag) and IsChaosSchoolFree() and (A.ChaosBolt:GetSpellCastTime() < InfernalTime and InfernalTime < A.ChaosBolt:GetSpellCastTime() + A.GetGCD()) and not RainofFireForceUse then
                return A.ChaosBolt:Show(icon)
            end
            -- conflagrate,if=buff.backdraft.down&buff.memory_of_lucid_dreams.up&soul_shard>=1.3
            if A.Conflagrate:IsReady(unit) and IsFireSchoolFree() and (Unit(player):HasBuffs(A.BackdraftBuff.ID, true) == 0 and Unit(player):HasBuffs(A.MemoryofLucidDreams.ID, true) > 0 and SoulShardsP >= 1.3) then
                return A.Conflagrate:Show(icon)
            end
            -- conflagrate,if=buff.backdraft.down&!buff.memory_of_lucid_dreams.up&(soul_shard>=2.8|charges_fractional>1.9&soul_shard>=1.3)
            if A.Conflagrate:IsReady(unit) and IsFireSchoolFree() and (Unit(player):HasBuffs(A.BackdraftBuff.ID, true) == 0 and Unit(player):HasBuffs(A.MemoryofLucidDreams.ID, true) == 0 and (SoulShardsP >= 2.8 or A.Conflagrate:GetSpellChargesFrac() > 1.9 and SoulShardsP >= 1.3)) then
                return A.Conflagrate:Show(icon)
            end
            -- conflagrate,if=InfernalTime<5
            if A.Conflagrate:IsReady(unit) and IsFireSchoolFree() and InfernalTime < 5 then
                return A.Conflagrate:Show(icon)
            end
            -- conflagrate,if=charges>1
            if A.Conflagrate:IsReady(unit) and A.Conflagrate:GetSpellCharges() > 1 and IsFireSchoolFree() then
                return A.Conflagrate:Show(icon)
            end
            -- soul_fire
            if A.SoulFire:IsReady(unit) and IsFireSchoolFree() then
                return A.SoulFire:Show(icon)
            end
            -- shadowburn
            if A.Shadowburn:IsReady(unit) and IsShadowSchoolFree() then
                return A.Shadowburn:Show(icon)
            end
            -- incinerate
            if A.Incinerate:IsReady(unit) and IsFireSchoolFree() and SoulShardsP < 5 then
                return A.Incinerate:Show(icon)
            end
        end
        GosupInfernal = A.MakeFunctionCachedDynamic(GosupInfernal)
		
        --Havoc
        local function Havoc(unit)
		
            -- conflagrate,if=buff.backdraft.down&soul_shard>=1&soul_shard<=4
            if A.Conflagrate:IsReady(unit) and IsFireSchoolFree() and 
			(
			    Unit(player):HasBuffs(A.BackdraftBuff.ID, true) == 0 and SoulShardsP >= 1 and SoulShardsP <= 4
				or
				Unit(player):HasBuffs(A.BackdraftBuff.ID, true) == 0 and SoulShardsP >= 2 and A.LastPlayerCastName == A.ChaosBolt:Info()
			)
			then
                return A.Conflagrate:Show(icon)
            end
			
            -- immolate,if=talent.internal_combustion.enabled&remains<duration*0.5|!talent.internal_combustion.enabled&refreshable
          --  if A.Immolate:IsReady(unit) and A.LastPlayerCastName ~= A.Immolate:Info() and (A.InternalCombustion:IsSpellLearned() and Unit(unit):HasDeBuffs(A.ImmolateDebuff.ID, true) < 18 * 0.5 or not A.InternalCombustion:IsSpellLearned() and Unit(unit):HasDeBuffsRefreshable(A.ImmolateDebuff.ID, true)) then
          --      return A.Immolate:Show(icon)
          --  end
		  
            -- chaos_bolt,if=cast_time<havoc_remains
            if A.ChaosBolt:IsReady(unit) and A.ChaosBolt:AbsentImun(unit, Temp.TotalAndMag) and IsChaosSchoolFree() --and Unit(player):HasBuffs(A.BackdraftBuff.ID, true) > 0 and A.ChaosBolt:GetSpellCastTime() < HavocRemains 
			then
                return A.ChaosBolt:Show(icon)
            end
			
            -- soul_fire
            if A.SoulFire:IsReady(unit) and IsFireSchoolFree() then
                return A.SoulFire:Show(icon)
            end
			
            -- shadowburn,if=active_enemies<3|!talent.fire_and_brimstone.enabled
            if A.Shadowburn:IsReady(unit) and IsShadowSchoolFree() and (MultiUnits:GetActiveEnemies() < 3 or not A.FireandBrimstone:IsSpellLearned()) then
                return A.Shadowburn:Show(icon)
            end
			
            -- incinerate,if=cast_time<havoc_remains
            if A.Incinerate:IsReady(unit) and IsFireSchoolFree() and A.Incinerate:GetSpellCastTime() < HavocRemains then
                return A.Incinerate:Show(icon)
            end
        end
		Havoc = A.MakeFunctionCachedDynamic(Havoc)
        
        -- call precombat
        if Precombat(unit) and not inCombat and Unit(unit):IsExists() and unit ~= "mouseover" then
            return true
        end

        -- In Combat
        if inCombat and Unit(unit):IsExists() and unit ~= "mouseover" then

            -- Explosives or Totems
            if inCombat and (Unit(unit):IsExplosives() or Unit(unit):IsTotem()) and CanCast then
                
				-- Instant Shadowburn on explosives orbs
                if A.Shadowburn:IsReady(unit) and IsChaosSchoolFree() then 
                    return A.Shadowburn:Show(icon)
                end	
				
                -- Instant Conflag on explosives orbs
                if A.Conflagrate:IsReady(unit) and IsFireSchoolFree() then 
                    return A.Conflagrate:Show(icon)
                end				
				
            end
		
			-- Interrupt
            local Interrupt = Interrupts(unit)
            if Interrupt then 
                return Interrupt:Show(icon)
            end

            -- conflagrate,killstrike
            if A.IsInPvP and A.Conflagrate:IsReady(unit) and IsFireSchoolFree() and 
			(
			    Unit(unit):HealthPercent() <= 2 
				or 
				Unit(unit):TimeToDie() < 1
			)
			then
                return A.Conflagrate:Show(icon)
            end

            -- immolate,cycle_targets=1,if=refreshable&(!talent.cataclysm.enabled|cooldown.cataclysm.remains>remains)
            if A.Immolate:IsReady(unit) and 
			A.IsInPvP and 
			IsFireSchoolFree() and 
			A.LastPlayerCastName ~= A.Immolate:Info() and 
			Unit(unit):HasDeBuffs(A.ImmolateDebuff.ID, true) <= 5 
			then
                return A.Immolate:Show(icon) 
            end

            -- call_action_list,name=havoc,if=havoc_active&active_enemies<5-talent.inferno.enabled+(talent.inferno.enabled&talent.internal_combustion.enabled)
            if Havoc(unit) and (EnemyHasHavoc or A.LastPlayerCastName == A.Havoc:Info()) then
                return true
            end
			
            -- Bane of Havoc, pvp 
            if A.IsInPvP and A.BaneofHavoc:IsReady("player") and MultiUnits:GetByRange(40) >= 2 and A.BaneofHavoc:IsSpellLearned() and SoulShardsP > 1.5 then
                return A.Havoc:Show(icon)
            end	
			
            -- rain_of_fire,if=pet.infernal.active&(buff.crashing_chaos.down|!talent.grimoire_of_supremacy.enabled)&(!cooldown.havoc.ready|active_enemies>3)
            if A.RainofFire:IsReady("player") and IsFireSchoolFree() and GetToggle(2, "AoE") 
			and MultiUnits:GetByRange(RainofFireRange) > RainofFireUnits and RainofFireForceUse
			then
                return A.RainofFire:Show(icon)
            end
			
            -- chaos_bolt, pvp use 
            if A.IsInPvP and A.ChaosBolt:IsReady(unit) and A.ChaosBolt:AbsentImun(unit, Temp.TotalAndMag) and Unit(player):HasBuffs(A.BackdraftBuff.ID, true) > 0 and IsChaosSchoolFree() and SoulShardsP > 2 then
                return A.ChaosBolt:Show(icon)
            end			

            -- chaos_bolt,if=talent.grimoire_of_supremacy.enabled&pet.infernal.active&(havoc_active|talent.cataclysm.enabled|talent.inferno.enabled&active_enemies<4)
            if A.ChaosBolt:IsReady(unit) and A.ChaosBolt:AbsentImun(unit, Temp.TotalAndMag) and not RainofFireForceUse and not VarPoolSoulShards and IsChaosSchoolFree() and 
			(
			    EnemyHasHavoc and Player:SoulShards() >= HavocPoolShards
				or
				A.Havoc:GetCooldown() > 2 and Player:SoulShards() > 4.2
			)		
			then
                return A.ChaosBolt:Show(icon)
            end
						
            -- cataclysm,if=!(pet.infernal.active&dot.immolate.remains+1>InfernalTime)|spell_targets.cataclysm>1|!talent.grimoire_of_supremacy.enabled
            if A.Cataclysm:IsReady("player") and Unit("mouseover"):IsExists() and IsFireSchoolFree() and not isMoving and 
			(
			    not (InfernalIsActive and Unit(unit):HasDeBuffs(A.ImmolateDebuff.ID, true) + 1 > InfernalTime) 
				or 
				MultiUnits:GetActiveEnemies() > 1 
				or 
				not A.GrimoireofSupremacy:IsSpellLearned()
			)
			then
                return A.Cataclysm:Show(icon)
            end
			
		    -- Auto Havoc PvE
			-- Crappy auto switch target until i find a way to fix Retarget
			-- then switch to another target
			if GetToggle(2, "AutoHavoc") and 
			not A.IsInPvP and 
			A.Zone ~= "arena" and 
			GetByRange(HavocUnits, HavocRange, false, true) and 
			Unit(unit):HasDeBuffs(A.HavocDebuff.ID, true) > 0
			then
			    return A:Show(icon, ACTION_CONST_AUTOTARGET)
			end

            -- Auto Havoc Arena
       --[[     if UnitIsUnit("target", arenaID) then 
			    if A.Zone == "arena" and TeamCacheEnemyMaxSize == 3 and	    -- Check for 3v3
				(		
				    Unit(unit):IsHealer() and Unit(unit):HasDeBuffs(A.HavocDebuff.ID, true) == 0
					or
					A.MortalCoil:IsSpellLearned() and 
			    )
				or
				A.Zone == "arena" and TeamCacheEnemyMaxSize == 2 and
				(
				    Unit(unit):HealthPercent() < 50
				    or
				    Unit(unit):HasDeBuffs(A.HavocDebuff.ID, true) == 0
				)
				then
				    return A.Havoc:Show(icon)
				end
            else
                -- set target what we need without cause break down for other code if user has not assigned /target
                Re:SetTarget(arenaID) -- even if you sent "target" == arenaID then nothing will not happen, unit will be unqueued just
            end ]]--
			
            -- Arena Havoc auto target
			if GetToggle(2, "AutoHavoc") and A.IsInPvP  and A.Zone == "arena" and
			(
				-- Check for 3v3
				TeamCacheEnemyMaxSize == 3 and EnemyTeam():PlayersInRange(2, 33) and
				(		
                    -- PvP Switch to healer to apply Havoc and then switch back to target				
				    not Unit(unit):IsHealer() and Unit(unit):HealthPercent() < 90 and A.Havoc:GetCooldown() == 0
					or
					Unit(unit):IsHealer()
					or
					Unit("player"):HealthPercent() <= MortalCoilHP
			    )
				or
				TeamCacheEnemyMaxSize == 2 and EnemyTeam():PlayersInRange(2, 33) and
				(
				    Unit(unit):HealthPercent() < 95					
					or
					Unit("player"):HealthPercent() <= MortalCoilHP
				)
			)
			then
			    if unit == "arena1" and not UnitIsUnit("target", unit) then
				    return A:Show(icon, ACTION_CONST_PVP_TARGET_ARENA1)
				elseif unit == "arena2" and not UnitIsUnit("target", unit) then
				    return A:Show(icon, ACTION_CONST_PVP_TARGET_ARENA2)
				elseif unit == "arena3" and not UnitIsUnit("target", unit) then
				    return A:Show(icon, ACTION_CONST_PVP_TARGET_ARENA3)
				else
				    if Unit(unit):HasDeBuffs(A.HavocDebuff.ID, true) > 0 then
					    return A:Show(icon, ACTION_CONST_AUTOTARGET)
					end
				end
			end 

			-- PvP MortalCoil logic
			if A.MortalCoil:IsReady(unit) and A.MortalCoil:IsSpellLearned() and A.IsInPvP and
			(
			    -- Offensive
				not Unit(unit):IsHealer() and A.Havoc:GetCooldown() > A.MortalCoil:GetCooldown() and
				(
				    Unit(unit):HealthPercent() < 45 
					or 
					Unit(unit):TimeToDie() < 5
				)
				-- Defensive
				or
				(				     
					A.Havoc:GetCooldown() > 0 and
					(
					    Unit("player"):IsExecuted() 
						or
					    Unit("player"):IsFocused("MELEE") and Unit("player"):HealthPercent() <= MortalCoilHP
					)
				)
				or
				A.LastPlayerCastName == A.Havoc:Info() and Unit(unit):HasDeBuffs(A.Havoc.ID, true) == 0
			)
			then
			    return A.MortalCoil:Show(icon)
			end			
			
			-- if Havoc available then use it on main target
			if A.Havoc:IsReady(unit) and GetToggle(2, "AoE") and
			(
			    not A.IsInPvP and 
				(
			        Player:SoulShards() >= HavocPoolShards and AutoHavoc and not VarPoolSoulShards and 			
			        -- protect override with Rain of fire value. 
			        GetByRange(HavocUnits, HavocRange, false, true) and 
			        GetByRange(HavocUnits, HavocRange, false, true) and 
			        Unit(unit):TimeToDie() > HavocTTD
					or
					(
					    Unit(unit):IsDummy() 
						and 
						Unit(unit):NPCID() == 144081 -- Dazaralor AoE Dummies
					)
                ) 
                or
                A.IsInPvP and
                (
				    -- Check for 3v3
				    A.Zone == "arena" and TeamCacheEnemyMaxSize == 3 and
				    (		
					    Unit(unit):IsHealer() and Unit(unit):HasDeBuffs(A.HavocDebuff.ID, true) == 0
			        )
				    or
				    A.Zone == "arena" and TeamCacheEnemyMaxSize == 2 and
				    (
				        Unit(unit):HealthPercent() < 50
					    or
					    Unit(unit):HasDeBuffs(A.HavocDebuff.ID, true) == 0
				    )					
                )				
			)       
			then 		
			    return A.Havoc:Show(icon)
            end
											
            -- call_action_list,name=aoe,if=active_enemies>2
            if Aoe(unit) and not A.IsInPvP and GetToggle(2, "AoE") and MultiUnits:GetByRange(40) > 2 then
                return true
            end
			
            -- immolate,cycle_targets=1,if=refreshable&(!talent.cataclysm.enabled|cooldown.cataclysm.remains>remains)
            if A.Immolate:IsReady(unit) and 
			not Unit(unit):IsExplosives() and 
			IsFireSchoolFree() and 
			A.LastPlayerCastName ~= A.Immolate:Info() and 
			Unit(unit):HasDeBuffs(A.ImmolateDebuff.ID, true) <= 5 and 
			(
			    not A.Cataclysm:IsSpellLearned() 
				or 
				A.Cataclysm:GetCooldown() > Unit(unit):HasDeBuffs(A.ImmolateDebuff.ID, true)
			) 
			then
                return A.Immolate:Show(icon) 
            end
			
            -- immolate,if=talent.internal_combustion.enabled&action.chaos_bolt.in_flight&remains<duration*0.5
            if A.Immolate:IsReady(unit) and Temp.ImmolateDelay == 0 and IsFireSchoolFree() and A.LastPlayerCastName ~= A.Immolate:Info() and (A.InternalCombustion:IsSpellLearned() and A.ChaosBolt:IsSpellInFlight() and Unit(unit):HasDeBuffs(A.ImmolateDebuff.ID, true) < 6) then
                return A.Immolate:Show(icon)
            end
			
            -- call_action_list,name=cds
            if Cooldowns(unit) and A.BurstIsON(unit) then
                return true
            end
			
            -- chaos_bolt basic usage no cd, no aoe, no pooling
            if A.ChaosBolt:IsReady(unit) and IsChaosSchoolFree() and A.ChaosBolt:AbsentImun(unit, Temp.TotalAndMag) and SoulShardsP >= 3.8 and not VarPoolSoulShards and not RainofFireForceUse then
                return A.ChaosBolt:Show(icon)
            end		
			
            -- focused_azerite_beam,if=!pet.infernal.active|!talent.grimoire_of_supremacy.enabled
            if A.FocusedAzeriteBeam:AutoHeartOfAzeroth(unit, true) and HeartOfAzeroth and (not InfernalIsActive or not A.GrimoireofSupremacy:IsSpellLearned()) then
                return A.FocusedAzeriteBeam:Show(icon)
            end
			
            -- the_unbound_force,if=buff.reckless_force.react
            if A.TheUnboundForce:AutoHeartOfAzeroth(unit, true) and HeartOfAzeroth and (Unit(player):HasBuffsStacks(A.RecklessForceBuff.ID, true) > 0) then
                return A.TheUnboundForce:Show(icon)
            end
			
            -- purifying_blast
            if A.PurifyingBlast:AutoHeartOfAzeroth(unit, true) and HeartOfAzeroth then
                return A.PurifyingBlast:Show(icon)
            end
			
            -- concentrated_flame,if=!dot.concentrated_flame_burn.remains&!action.concentrated_flame.in_flight
            if A.ConcentratedFlame:AutoHeartOfAzeroth(unit, true) and HeartOfAzeroth and (Unit(unit):HasDeBuffs(A.ConcentratedFlameBurn.ID, true) == 0 and not A.ConcentratedFlame:IsSpellInFlight()) then
                return A.ConcentratedFlame:Show(icon)
            end
			
            -- channel_demonfire
            if A.ChannelDemonfire:IsReady(unit) and IsFireSchoolFree() then
                return A.ChannelDemonfire:Show(icon)
            end
			
            -- havoc,cycle_targets=1,if=!(target=self.target)&(dot.immolate.remains>dot.immolate.duration*0.5|!talent.internal_combustion.enabled)&(!cooldown.summon_infernal.ready|!talent.grimoire_of_supremacy.enabled|talent.grimoire_of_supremacy.enabled&InfernalTime<=10)
          --  if A.Havoc:IsReady(unit) then
         --       if Action.Utils.CastTargetIf(A.Havoc, 40, "min", EvaluateCycleHavoc572) then
          --          return A.Havoc:Show(icon) 
         --       end
         --   end
		 
            -- call_action_list,name=gosup_infernal,if=talent.grimoire_of_supremacy.enabled&pet.infernal.active
            if GosupInfernal(unit) and A.GrimoireofSupremacy:IsSpellLearned() and InfernalIsActive
			then
                return true
            end
			
            -- soul_fire
            if A.SoulFire:IsReady(unit) and IsFireSchoolFree() then
                return A.SoulFire:Show(icon)
            end
            
			-- conflagrate,if=buff.backdraft.down&soul_shard>=1.5-0.3*talent.flashover.enabled&!variable.pool_soul_shards
            if A.Conflagrate:IsReady(unit) and IsFireSchoolFree() and (Unit(player):HasBuffs(A.BackdraftBuff.ID, true) == 0 and SoulShardsP >= 1.5 - 0.3 * num(A.Flashover:IsSpellLearned()) and not VarPoolSoulShards) then
                return A.Conflagrate:Show(icon)
            end
			
            -- shadowburn,if=soul_shard<2&(!variable.pool_soul_shards|charges>1)
            if A.Shadowburn:IsReady(unit) and IsShadowSchoolFree() and (SoulShardsP < 2 and (not VarPoolSoulShards or A.Shadowburn:GetSpellCharges() > 1)) then
                return A.Shadowburn:Show(icon)
            end
			
            -- chaos_bolt,if=(talent.grimoire_of_supremacy.enabled|azerite.crashing_chaos.enabled)&pet.infernal.active|buff.dark_soul_instability.up|buff.reckless_force.react&buff.reckless_force.remains>cast_time
            if A.ChaosBolt:IsReady(unit) and A.ChaosBolt:AbsentImun(unit, Temp.TotalAndMag) and not VarPoolSoulShards and IsChaosSchoolFree() and 
			(
			    (A.GrimoireofSupremacy:IsSpellLearned() or A.CrashingChaos:GetAzeriteRank() > 0) and InfernalIsActive 
				or 
				Unit(player):HasBuffs(A.DarkSoulInstabilityBuff.ID, true) > 0 
				or 
				Unit(player):HasBuffsStacks(A.RecklessForceBuff.ID, true) > 0 and Unit(player):HasBuffs(A.RecklessForceBuff.ID, true) > A.ChaosBolt:GetSpellCastTime()
			)
			then
                return A.ChaosBolt:Show(icon)
            end
			
            -- chaos_bolt,if=buff.backdraft.up&!variable.pool_soul_shards&!talent.eradication.enabled
            if A.ChaosBolt:IsReady(unit) and A.ChaosBolt:AbsentImun(unit, Temp.TotalAndMag) and IsChaosSchoolFree() and SoulShardsP > 2.8 and not VarPoolSoulShards then
                return A.ChaosBolt:Show(icon)
            end
			
            -- chaos_bolt,if=buff.backdraft.up&!variable.pool_soul_shards&!talent.eradication.enabled
            if A.ChaosBolt:IsReady(unit) and A.ChaosBolt:AbsentImun(unit, Temp.TotalAndMag) and IsChaosSchoolFree() and (Unit(player):HasBuffs(A.BackdraftBuff.ID, true) > 0 and not VarPoolSoulShards and not A.Eradication:IsSpellLearned()) then
                return A.ChaosBolt:Show(icon)
            end
			
            -- chaos_bolt,if=!variable.pool_soul_shards&talent.eradication.enabled&(debuff.eradication.remains<cast_time|buff.backdraft.up)
            if A.ChaosBolt:IsReady(unit) and A.ChaosBolt:AbsentImun(unit, Temp.TotalAndMag) and IsChaosSchoolFree() and not VarPoolSoulShards and A.Eradication:IsSpellLearned() and (Unit(unit):HasDeBuffs(A.EradicationDebuff.ID, true) < A.ChaosBolt:GetSpellCastTime() or Unit(player):HasBuffs(A.BackdraftBuff.ID, true) > 0) then
                return A.ChaosBolt:Show(icon)
            end
			
            -- chaos_bolt,if=(soul_shard>=4.5-0.2*active_enemies)&(!talent.grimoire_of_supremacy.enabled|cooldown.summon_infernal.remains>7)
            if A.ChaosBolt:IsReady(unit) and A.ChaosBolt:AbsentImun(unit, Temp.TotalAndMag) and IsChaosSchoolFree() and ((SoulShardsP >= 4.5 - 0.2 * MultiUnits:GetByRange(40)) and (not A.GrimoireofSupremacy:IsSpellLearned() or (A.SummonInfernal:GetCooldown() > 7))) then
                return A.ChaosBolt:Show(icon)
            end
			
            -- conflagrate,if=charges>1
            if A.Conflagrate:IsReady(unit) and A.Conflagrate:GetSpellCharges() > 1 and IsFireSchoolFree() then
                return A.Conflagrate:Show(icon)
            end
			
            -- incinerate
            if A.Incinerate:IsReady(unit) and SoulShardsP < 5 and IsFireSchoolFree() then
                return A.Incinerate:Show(icon)
            end
			
        end
    end

    -- End on EnemyRotation()
	-- Demon Armor PvP
	if A.IsInPvP and A.DemonArmor:IsReady("player") and A.DemonArmor:IsSpellLearned() and Unit(player):HasBuffs(A.DemonArmor.ID, true) == 0 then 
	    return A.DemonArmor:Show(icon)
    end 
	
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

    -- Arena1  
    if A.IsUnitEnemy("arena1") then 
        unit = "arena1"
        if EnemyRotation(unit) then 
            return true
        end
    end
	
    -- Arena2 
    if A.IsUnitEnemy("arena2") then 
        unit = "arena2"
        if EnemyRotation(unit) then 
            return true
        end
    end
	
    -- Arena3  
    if A.IsUnitEnemy("arena3") then 
        unit = "arena3"
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
end]]-- 

local function ArenaRotation(icon, unit)
    if A.IsInPvP and (A.Zone == "pvp" or A.Zone == "arena") and not Player:IsStealthed() and not Player:IsMounted() then   
        local useKick, useCC, useRacial = A.InterruptIsValid(unit, "PvP")    

		-- Interrupt
        local Interrupt = Interrupts(unit)
	    if Interrupt then 
	        return Interrupt:Show(icon)
	    end	
		
        -- Reflect Casting BreakAble CC
        if A.IsInPvP and A.NetherWard:IsReady("player") and A.NetherWard:IsSpellLearned() and Action.ShouldReflect(unit) then 
            return A.NetherWard:Show(icon)
        end 
	
        -- Note: "arena1" is just identification of meta 6
        if (unit == "arena1" or unit == "arena2" or unit == "arena3") then 
		
		    -- Interrupt
            local Interrupt = Interrupts(unit)
	        if Interrupt then 
	            return Interrupt:Show(icon)
	        end	
		
            -- Reflect Casting BreakAble CC
            if A.IsInPvP and A.NetherWard:IsReady("player") and A.NetherWard:IsSpellLearned() and Action.ShouldReflect(unit) then 
                return A.NetherWard:Show(icon)
            end 
        end 
                        
    end 
end 

local function PartyRotation(unit)
    if (unit == "party1" and not GetToggle(2, "PartyUnits")[1]) or (unit == "party2" and not GetToggle(2, "PartyUnits")[2]) then 
        return false 
    end 
    
  	-- SingeMagic
    if A.SingeMagic:IsCastable() and Pet:IsActive(416) and A.SingeMagic:AbsentImun(unit, Temp.TotalAndMag) and IsFireSchoolFree() and Action.AuraIsValid(unit, "UseDispel", "Magic") and not Unit(unit):InLOS() then
        return A.SingeMagic
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