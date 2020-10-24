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
Action[ACTION_CONST_ROGUE_OUTLAW] = {
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
	-- Generics Spells
    AdrenalineRush                         = Action.Create({ Type = "Spell", ID = 13750        }),
    Ambush                                 = Action.Create({ Type = "Spell", ID = 8676        }),
    BetweentheEyes                         = Action.Create({ Type = "Spell", ID = 199804        }),
    BladeFlurry                            = Action.Create({ Type = "Spell", ID = 13877        }),
    Opportunity                            = Action.Create({ Type = "Spell", ID = 195627        }),
    PistolShot                             = Action.Create({ Type = "Spell", ID = 185763        }),
    RolltheBones                           = Action.Create({ Type = "Spell", ID = 193316        }),
    Dispatch                               = Action.Create({ Type = "Spell", ID = 2098        }),
    SinisterStrike                         = Action.Create({ Type = "Spell", ID = 193315        }),
    Stealth                                = Action.Create({ Type = "Spell", ID = 1784        }),
    Vanish                                 = Action.Create({ Type = "Spell", ID = 1856        }),    
    -- Talents
    AcrobaticStrikes                       = Action.Create({ Type = "Spell", ID = 196924        }),
    BladeRush                              = Action.Create({ Type = "Spell", ID = 271877        }),
    DeeperStratagem                        = Action.Create({ Type = "Spell", ID = 193531        }),
    GhostlyStrike                          = Action.Create({ Type = "Spell", ID = 196937        }),
    KillingSpree                           = Action.Create({ Type = "Spell", ID = 51690        }),    
    MarkedforDeath                         = Action.Create({ Type = "Spell", ID = 137619        }),
    QuickDraw                              = Action.Create({ Type = "Spell", ID = 196938        }),
    SliceandDice                           = Action.Create({ Type = "Spell", ID = 5171        }),
	Dismantle                              = Action.Create({ Type = "Spell", ID = 207777     }), -- PvP Talent
    -- Azerite Traits
    AceUpYourSleeve                        = Action.Create({ Type = "Spell", ID = 278676        }),
    Deadshot                               = Action.Create({ Type = "Spell", ID = 272935        }),    
    SnakeEyesPower                         = Action.Create({ Type = "Spell", ID = 275846        }),   
    -- Defensive
    CrimsonVial                            = Action.Create({ Type = "Spell", ID = 185311        }),
    Feint                                  = Action.Create({ Type = "Spell", ID = 1966        }),
	Riposte                                = Action.Create({ Type = "Spell", ID = 199754       }),
	CloakofShadow                          = Action.Create({ Type = "Spell", ID = 31224     }),
	Evade                                  = Action.Create({ Type = "Spell", ID = 5277     }),
    -- Utilities
    KidneyShot                             = Action.Create({ Type = "Spell", ID = 408       }),
    Gouge                                  = Action.Create({ Type = "Spell", ID = 1776       }),
    Blind                                  = Action.Create({ Type = "Spell", ID = 2094     }),
    Kick                                   = Action.Create({ Type = "Spell", ID = 1766     }),
    Sprint                                 = Action.Create({ Type = "Spell", ID = 2983       }),
    CheapShot                              = Action.Create({ Type = "Spell", ID = 1833       }),
	ShadowStep                             = Action.Create({ Type = "Spell", ID = 36554       }),
	TricksoftheTrade                       = Action.Create({ Type = "Spell", ID = 57934       }),
	-- PvP
	Sap                                    = Action.Create({ Type = "Spell", ID = 6770       }),
	Shiv                                   = Action.Create({ Type = "Spell", ID = 248744       }),
	SmokeBomb                              = Action.Create({ Type = "Spell", ID = 212182       }),
	DFA                                    = Action.Create({ Type = "Spell", ID = 269513       }),
	Neuro                                  = Action.Create({ Type = "Spell", ID = 206328       }),  
	-- Roll the Bones
    Broadside                              = Action.Create({ Type = "Spell", ID = 193356       }),
    BuriedTreasure                         = Action.Create({ Type = "Spell", ID = 199600       }),
    GrandMelee                             = Action.Create({ Type = "Spell", ID = 193358       }),
    RuthlessPrecision                      = Action.Create({ Type = "Spell", ID = 193357       }),
    SkullandCrossbones                     = Action.Create({ Type = "Spell", ID = 199603       }),
    TrueBearing                            = Action.Create({ Type = "Spell", ID = 193359       }),
    -- Misc
    Channeling                             = Action.Create({ Type = "Spell", ID = 209274, Hidden = true     }),	
    -- Buffs
    VigorTrinketBuff                       = Action.Create({ Type = "Spell", ID = 287916, Hidden = true     }),
	KeepYourWitsBuff                       = Action.Create({ Type = "Spell", ID = 288988, Hidden = true     }),
	SnakeEyesBuff                          = Action.Create({ Type = "Spell", ID = 275863, Hidden = true     }),
	DeadshotBuff                           = Action.Create({ Type = "Spell", ID = 272940, Hidden = true     }),
	LoadedDiceBuff                         = Action.Create({ Type = "Spell", ID = 256171, Hidden = true     }),
	VanishBuff                             = Action.Create({ Type = "Spell", ID = 11327, Hidden = true     }),
	RolltheBones                       = Action.Create({ Type = "Spell", ID = 193316, Hidden = true     }),

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
    BattlePotionofAgility                  = Action.Create({ Type = "Potion", ID = 163223, QueueForbidden = true }),
    SuperiorPotionofUnbridledFury          = Action.Create({ Type = "Potion", ID = 168489, QueueForbidden = true }), 
	AbyssalHealingPotion    			   = Action.Create({ Type = "Potion", ID = 169451, QueueForbidden = true }),	
    PotionTest                             = Action.Create({ Type = "Potion", ID = 142117, QueueForbidden = true }), 
    -- Trinkets
    GenericTrinket1                        = Action.Create({ Type = "Trinket", ID = 114616, QueueForbidden = true }),
    GenericTrinket2                        = Action.Create({ Type = "Trinket", ID = 114081, QueueForbidden = true }),
    TrinketTest                            = Action.Create({ Type = "Trinket", ID = 122530, QueueForbidden = true }),
    TrinketTest2                           = Action.Create({ Type = "Trinket", ID = 159611, QueueForbidden = true }), 
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
	LifebloodBuff                          = Action.Create({ Type = "Spell", ID = 295137, Hidden = true     }),
    PoolResource                             = Action.Create({ Type = "Spell", ID = 209274, Hidden = true     }),	
    RecklessForceCounter                   = Action.Create({ Type = "Spell", ID = 302917, Hidden = true     }),
    -- Hidden Heart of Azeroth
    -- added all 3 ranks ids in case used by rotation
    VisionofPerfectionMinor                = Action.Create({ Type = "Spell", ID = 296320, Hidden = true}),
    VisionofPerfectionMinor2               = Action.Create({ Type = "Spell", ID = 299367, Hidden = true}),
    VisionofPerfectionMinor3               = Action.Create({ Type = "Spell", ID = 299369, Hidden = true}),
    UnleashHeartOfAzeroth                  = Action.Create({ Type = "Spell", ID = 280431, Hidden = true}),
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
    RippleinSpace                          = Action.Create({ Type = "HeartOfAzeroth", ID = 302731, Hidden = true}),
    RippleinSpace2                         = Action.Create({ Type = "HeartOfAzeroth", ID = 302982, Hidden = true}),
    RippleinSpace3                         = Action.Create({ Type = "HeartOfAzeroth", ID = 302983, Hidden = true}),
    WorldveinResonance                     = Action.Create({ Type = "HeartOfAzeroth", ID = 295186, Hidden = true}),
    WorldveinResonance2                    = Action.Create({ Type = "HeartOfAzeroth", ID = 298628, Hidden = true}),
    WorldveinResonance3                    = Action.Create({ Type = "HeartOfAzeroth", ID = 299334, Hidden = true}),
    MemoryofLucidDreams                    = Action.Create({ Type = "HeartOfAzeroth", ID = 298357, Hidden = true}),
    MemoryofLucidDreams2                   = Action.Create({ Type = "HeartOfAzeroth", ID = 299372, Hidden = true}),
    MemoryofLucidDreams3                   = Action.Create({ Type = "HeartOfAzeroth", ID = 299374, Hidden = true}), 
    RecklessForceBuff                      = Action.Create({ Type = "Spell", ID = 302932, Hidden = true     }),	 
};

-- To create essences use next code:
Action:CreateEssencesFor(ACTION_CONST_ROGUE_OUTLAW)  -- where PLAYERSPEC is Constance (example: ACTION_CONST_MONK_BM)
local A = setmetatable(Action[ACTION_CONST_ROGUE_OUTLAW], { __index = Action })


------------------------------------------
---------------- VARIABLES ---------------
------------------------------------------
local VarBladeFlurrySync = 0;
local VarAmbushCondition = 0;
local VarBteCondition = 0;
local VarRtbReroll = 0;
local SapUsed = 0;
-- Lua
local mathmin = math.min;
local pairs = pairs;
local tableconcat = table.concat;
local tostring = tostring;

A.Listener:Add("ROTATION_VARS", "PLAYER_REGEN_ENABLED", function()
  VarBladeFlurrySync = 0
  VarAmbushCondition = 0
  VarBteCondition = 0
  VarRtbReroll = 0
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

-- cp_max_spend
local function CPMaxSpend()
    -- Should work for all 3 specs since they have same Deeper Stratagem Spell ID.
    return A.DeeperStratagem:IsSpellLearned() and 6 or 5;
end

-- "cp_spend"
local function CPSpend()
    return mathmin(Unit("player"):ComboPoints(), CPMaxSpend());
end

-- APL Action Lists (and Variables)
local SappedSoulSpells = {
    {A.Kick.ID, "Cast Kick (Sapped Soul)", function () return Unit(unit):IsInRange(A.SinisterStrike); end},
    {A.Feint.ID, "Cast Feint (Sapped Soul)", function () return true; end},
    {A.CrimsonVial.ID, "Cast Crimson Vial (Sapped Soul)", function () return true; end}
};

-- Roll the bones buff list
local RtB_BuffsList = {

    [1] = A.Broadside.ID, 
	[2] = A.GrandMelee.ID, 
    [3] = A.BuriedTreasure.ID, 
	[4] = A.RuthlessPrecision.ID,
	[5] = A.TrueBearing.ID,
	[6] = A.SkullandCrossbones.ID
}

-- Roll the bones list on player checker
local function RtB_List (Type, List)
    if not RtB_List then 
	    RtB_List = {}; 
	end
	
    if not RtB_List[Type] then 
	    RtB_List[Type] = {}; 
	end
    local Sequence = table.concat(List);
	
    -- All
    if Type == "All" then
        if not RtB_List[Type][Sequence] then
            local Count = 0;
            for i = 1, #List do
                if Unit("player"):HasBuffs(RtB_BuffsList[List[i]], true) > 0 then
                    Count = Count + 1;
                end
            end
            RtB_List[Type][Sequence] = Count == #List and true or false;
        end		
    -- Any
    else
        if not RtB_List[Type][Sequence] then
            RtB_List[Type][Sequence] = false;
            for i = 1, #List do
                if Unit("player"):HasBuffs(RtB_BuffsList[List[i]], true) > 0 then
                    RtB_List[Type][Sequence] = true;
                break;
                end
            end
        end
    end
    return RtB_List[Type][Sequence];
end

-- Roll the bones current buff remaining time
local function RtB_BuffRemains()
    if not RtB_BuffRemains then
        local RtB_BuffRemains = 0;
        for i = 1, #RtB_BuffsList do
            if Unit("player"):HasBuffs(RtB_BuffsList[i], true) > 0 then
                RtB_BuffRemains = Unit("player"):HasBuffs(RtB_BuffsList[i], true)
                break
            end
        end
    end
    return RtB_BuffRemains
end

-- Get the number of Roll the Bones buffs currently on
local function RtB_Buffs()
    local RtB_Buffs = 0
    for i = 1, #RtB_BuffsList do
        if Unit("player"):HasBuffs(RtB_BuffsList[i], true) > 0 then
            RtB_Buffs = RtB_Buffs + 1
        end
    end
    return RtB_Buffs
end

-- Used to handle different UI choices and return Roll the Bones conditions
local function CheckGoodBuffs()
    local choice = Action.GetToggle(2, "RolltheBonesLogic")
    local GotGoodBuff = false
	
    if choice == "1BUFF" then
        GotGoodBuff = (not A.SliceandDice:IsSpellLearned() and RtB_Buffs() < 1 and true) or false;
    elseif choice == "MYTHICPLUS" then
        GotGoodBuff = (not A.SliceandDice:IsSpellLearned() and (Unit("player"):HasBuffs(A.RuthlessPrecision.ID, true) == 0 and Unit("player"):HasBuffs(A.GrandMelee.ID, true) == 0 and Unit("player"):HasBuffs(A.Broadside.ID, true) == 0) and not (RtB_Buffs() >= 2) and true) or false
    elseif choice == "AOESTRAT" then   
        GotGoodBuff = (not A.SliceandDice:IsSpellLearned() and (Unit("player"):HasBuffs(A.RuthlessPrecision.ID, true) == 0 and Unit("player"):HasBuffs(A.GrandMelee.ID, true) == 0 and Unit("player"):HasBuffs(A.Broadside.ID, true) == 0) and not (RtB_Buffs() >= 2) and true) or false
    elseif choice == "BROADSIDE" then  
        GotGoodBuff = (not A.SliceandDice:IsSpellLearned() and Unit("player"):HasBuffs(A.Broadside.ID, true) == 0 and true) or false;
    elseif choice == "BURIEDTREASURE" then  
        GotGoodBuff = (not A.SliceandDice:IsSpellLearned() and Unit("player"):HasBuffs(A.BuriedTreasure.ID, true) == 0 and true) or false;
    elseif choice == "GRANDMELEE" then  
        GotGoodBuff = (not A.SliceandDice:IsSpellLearned() and Unit("player"):HasBuffs(A.GrandMelee.ID, true) == 0 and true) or false;
    elseif choice == "SKULLANDCROSS" then  
        GotGoodBuff = (not A.SliceandDice:IsSpellLearned() and Unit("player"):HasBuffs(A.SkullandCrossbones.ID, true) == 0 and true) or false;
    elseif choice == "RUTHLESSPRECISION" then  
        GotGoodBuff = (not A.SliceandDice:IsSpellLearned() and Unit("player"):HasBuffs(A.RuthlessPrecision.ID, true) == 0 and true) or false;
    elseif choice == "TRUEBEARING" then  
        GotGoodBuff = (not A.SliceandDice:IsSpellLearned() and Unit("player"):HasBuffs(A.TrueBearing.ID, true) == 0 and true) or false;
    elseif choice == "SIMC" then  
        if Unit("player"):HasBuffs(A.BladeFlurry.ID, true) > 0 then
            GotGoodBuff = (RtB_Buffs() < 2 and (Unit("player"):HasBuffs(A.LoadedDiceBuff.ID, true) > 0 or
            (Unit("player"):HasBuffs(A.GrandMelee.ID, true) == 0 and Unit("player"):HasBuffs(A.RuthlessPrecision.ID, true) == 0 and Unit("player"):HasBuffs(A.Broadside.ID, true) == 0))) and true or false;
        elseif A.SnakeEyesPower:GetAzeriteRank() >= 2 then
            GotGoodBuff = (RtB_Buffs() < 2 ) and true or false;
            -- # Do not reroll if Snake Eyes is at 2+ stacks of the buff (1+ stack with Broadside up)
            -- actions+=/variable,name=rtb_reroll,op=reset,if=azerite.snake_eyeA.rank>=2&buff.snake_eyeA.stack>=2-buff.broadside.up
            if Unit("player"):HasBuffsStacks(A.SnakeEyesBuff.ID, true) >= 2 - num(Unit("player"):HasBuffs(A.Broadside.ID, true) > 0) then
                GotGoodBuff = false;
            end
        elseif A.Deadshot:GetAzeriteRank() > 0 or A.AceUpYourSleeve:GetAzeriteRank() > 0 then
            GotGoodBuff = (RtB_Buffs() < 2 and (Unit("player"):HasBuffs(A.LoadedDiceBuff.ID, true) > 0 or
            Unit("player"):HasBuffs(A.RuthlessPrecision.ID, true) <= A.BetweentheEyes:GetCooldown())) and true or false;
        else
            GotGoodBuff = (RtB_Buffs() < 2 and (Unit("player"):HasBuffs(A.LoadedDiceBuff.ID, true) > 0 or
           (Unit("player"):HasBuffs(A.GrandMelee.ID, true) == 0 and Unit("player"):HasBuffs(A.RuthlessPrecision.ID, true) == 0))) and true or false;
        end
	else
        return
    end
    return GotGoodBuff
end

-- Roll the Bones rerolling strategy, return true if we should reroll
local function RtB_Reroll()
    
    local RtB_Reroll = false
	
        -- Defensive Override : Grand Melee if HP < 60
        if Action.GetToggle(2, "SoloMode") and Unit("player"):HealthPercent() < Action.GetToggle(2, "RolltheBonesLeechHP") then
            RtB_Reroll = (not A.SliceandDice:IsSpellLearned() and Unit("player"):HasBuffs(A.GrandMelee.ID, true) == 0) and true or false;
        -- 1+ Buff
        elseif Action.GetToggle(2, "RolltheBonesLogic") == "1BUFF" then
            RtB_Reroll = CheckGoodBuffs()
        -- Mythic+
        elseif Action.GetToggle(2, "RolltheBonesLogic") == "MYTHICPLUS" then
            RtB_Reroll = CheckGoodBuffs()
        -- Broadside
        elseif Action.GetToggle(2, "RolltheBonesLogic") == "AOESTRAT" and MultiUnits:GetByRangeInCombat(8, 5, 10) >= 2 or (not Unit("target"):IsBoss()) then
            RtB_Reroll = CheckGoodBuffs()
        -- Broadside
        elseif Action.GetToggle(2, "RolltheBonesLogic") == "BROADSIDE" then
            RtB_Reroll = CheckGoodBuffs()
        -- Buried Treasure
        elseif Action.GetToggle(2, "RolltheBonesLogic") == "BURIEDTREASURE" then
            RtB_Reroll = CheckGoodBuffs()
        -- Grand Melee
        elseif Action.GetToggle(2, "RolltheBonesLogic") == "GRANDMELEE" then
            RtB_Reroll = CheckGoodBuffs()
        -- Skull and Crossbones
        elseif Action.GetToggle(2, "RolltheBonesLogic") == "SKULLANDCROSS" then
            RtB_Reroll = CheckGoodBuffs()
        -- Ruthless Precision
        elseif Action.GetToggle(2, "RolltheBonesLogic") == "RUTHLESSPRECISION" then
            RtB_Reroll = CheckGoodBuffs()
        -- True Bearing
        elseif Action.GetToggle(2, "RolltheBonesLogic") == "TRUEBEARING" then
            RtB_Reroll = CheckGoodBuffs()
        -- SimC Default
        elseif Action.GetToggle(2, "RolltheBonesLogic") == "SIMC" then
            RtB_Reroll = CheckGoodBuffs()
        else
			return false
        end
    return RtB_Reroll;
end

-- # Condition to use Stealth cooldowns for Ambush
local function Ambush_Condition ()
    -- actions+=/variable,name=ambush_condition,value=combo_pointA.deficit>=2+2*(talent.ghostly_strike.enabled&cooldown.ghostly_strike.remains<1)+buff.broadside.up&energy>60&!buff.skull_and_crossboneA.up&!buff.keep_your_wits_about_you.up
    return Player:ComboPointsDeficit() >= 2 + 2 * ((A.GhostlyStrike:IsSpellLearned() and A.GhostlyStrike:GetCooldown() < 1) and 1 or 0)
    + (Unit("player"):HasBuffs(A.Broadside.ID, true) > 0 and 1 or 0) and Player:EnergyPredicted() > 60 and Unit("player"):HasBuffs(A.SkullandCrossbones.ID, true) == 0 and Unit("player"):HasBuffs(A.KeepYourWitsBuff.ID, true) == 0;
end

-- actions+=/variable,name=bte_condition,value=buff.ruthless_precision.up|(azerite.deadshot.enabled|azerite.ace_up_your_sleeve.enabled)&buff.roll_the_boneA.up
local function BtECondition ()
    return Unit("player"):HasBuffs(A.RuthlessPrecision.ID, true) > 0 or (A.Deadshot:GetAzeriteRank() > 0 or A.AceUpYourSleeve:GetAzeriteRank() > 0) and RtB_Buffs() >= 1;
end

-- # With multiple targets, this variable is checked to decide whether some CDs should be synced with Blade Flurry
-- actions+=/variable,name=blade_flurry_sync,value=spell_targetA.blade_flurry<2&raid_event.addA.in>20|buff.blade_flurry.up
local function Blade_Flurry_Sync ()
    return not Action.GetToggle(2,"AoE") or MultiUnits:GetByRangeInCombat(8, 5, 10) < 2 or Unit("player"):HasBuffs(A.BladeFlurry.ID, true) > 0
end

local function EnergyTimeToMaxRounded ()
    -- Round to the nearesth 10th to reduce prediction instability on very high regen rates
    return math.floor(Unit("player"):EnergyTimeToMaxPredicted() * 10 + 0.5) / 10;
end

-- Marked for Death Sniping
-- Will try to get best unit to apply Marked for Death considering time to die to get cooldown reset
local BestUnit, BestUnitTTD;
local function MfDSniping (MarkedforDeath)
    local unit = "target"
	
    if MarkedforDeath:IsReady(unit) and A.MarkedforDeath:IsSpellLearned() then
        -- Get Units up to 30y for MfD.

        BestUnit, BestUnitTTD = nil, 60;
		local unit = "target"
		local MOunit = "mouseover"
        local MOTTD = Unit("mouseover"):GetRange() <= 30 and Unit("mouseover"):TimeToDie() or 11111;
        local TTD = Unit(unit):TimeToDie()
		
        for _, CycleUnit in pairs(MultiUnits:GetActiveUnitPlates()) do
		                			
            -- Note: Increased the SimC condition by 50% since we are slower.
			-- TEST - REMOVED 50% lowered value on Action
            if not Unit(CycleUnit):IsMfdBlacklisted() and TTD < Player:ComboPointsDeficit() * 1 and TTD < BestUnitTTD then
                if MOTTD - TTD > 1 then
                    BestUnit, BestUnitTTD = Unit(CycleUnit), TTD;
                else
                   BestUnit, BestUnitTTD = MouseOver, MOTTD;
                end
            end
        end
        if BestUnit and BestUnit:InfoGUID() ~= Unit(CycleUnit):InfoGUID() then
            return A:Show(icon, ACTION_CONST_AUTOTARGET)
        end
    end
end


-- SelfDefensives
local function SelfDefensives(unit)
    local HPLoosePerSecond = Unit("player"):GetDMG() * 100 / Unit("player"):HealthMax()
		
    if Unit("player"):CombatTime() == 0 then 
        return 
    end 

    -- Emergency Riposte
    local Riposte = Action.GetToggle(2, "RiposteHP")
    if     Riposte >= 0 and A.Riposte:IsReady("player") and 
    (
        (   -- Auto 
            Riposte >= 100 and 
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
            Riposte < 100 and 
            Unit("player"):HealthPercent() <= Riposte
        )
    ) 
    then 
        return A.Riposte
    end  
		
    -- Emergency Feint
        local Feint = Action.GetToggle(2, "FeintHP")
        if     Feint >= 0 and A.Feint:IsReady("player") and 
        (
            (   -- Auto 
                Feint >= 100 and 
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
                Feint < 100 and 
                Unit("player"):HealthPercent() <= Feint
            )
        ) 
        then 
            return A.Feint
        end  		

        -- Emergency CrimsonVial
        local CrimsonVial = Action.GetToggle(2, "CrimsonVialHP")
        if     CrimsonVial >= 0 and A.CrimsonVial:IsReady("player") and 
        (
            (   -- Auto 
                CrimsonVial >= 100 and 
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
                CrimsonVial < 100 and 
                Unit("player"):HealthPercent() <= CrimsonVial
            )
        ) 
        then 
            return A.CrimsonVial
        end  		

        -- Emergency Cloak of Shadow
        local CloakofShadow = Action.GetToggle(2, "CloakofShadowHP")
        if     CloakofShadow >= 0 and A.CloakofShadow:IsReady("player") and 
        (
            (   -- Auto 
                CloakofShadow >= 100 and 
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
                CloakofShadow < 100 and 
                Unit("player"):HealthPercent() <= CloakofShadow
            )
        ) 
        then 
            return A.CloakofShadow
        end 
		
        -- Emergency Vanish
        local Vanish = Action.GetToggle(2, "VanishDefensive")
        if     Vanish >= 0 and A.Vanish:IsReady("player") and 
        (
            (   -- Auto 
                Vanish >= 100 and 
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
                Vanish < 100 and 
                Unit("player"):HealthPercent() <= Vanish
            )
        ) 
    then 
        return A.Vanish
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

end 
SelfDefensives = A.MakeFunctionCachedDynamic(SelfDefensives)

local function Interrupts(unit)
    local useKick, useCC, useRacial = A.InterruptIsValid(unit, "TargetMouseover")    
    
    if useKick and A.Kick:IsReady(unit) and A.Kick:AbsentImun(unit, Temp.TotalAndMagKick, true) and Unit(unit):CanInterrupt(true, nil, 25, 70) then 
        -- Notification					
        Action.SendNotification("Kick on : " .. UnitName(unit), A.Kick.ID)
		return A.Kick
    end 
    
	if useCC and A.Gouge:IsReady(unit) and A.Gouge:AbsentImun(unit, Temp.TotalAndCC, true) and Unit(unit):IsControlAble("stun") then 
        -- Notification					
        Action.SendNotification("Gouge on : " .. UnitName(unit), A.Gouge.ID)
		return A.Gouge              
    end          
	
	if useCC and Player:IsStealthed() and A.CheapShot:IsReady(unit) and A.CheapShot:AbsentImun(unit, Temp.TotalAndCC, true) and Unit(unit):IsControlAble("stun") then 
        -- Notification					
        Action.SendNotification("CheapShot on : " .. UnitName(unit), A.CheapShot.ID)
		return A.CheapShot              
    end
    
    if useRacial and A.QuakingPalm:AutoRacial(unit) then 
        -- Notification					
        Action.SendNotification("QuakingPalm on : " .. UnitName(unit), A.QuakingPalm.ID)
		return A.QuakingPalm
    end 
    
    if useRacial and A.Haymaker:AutoRacial(unit) then 
        -- Notification					
        Action.SendNotification("Haymaker on : " .. UnitName(unit), A.Haymaker.ID)
		return A.Haymaker
    end 
    
    if useRacial and A.WarStomp:AutoRacial(unit) then 
        -- Notification					
        Action.SendNotification("WarStomp on : " .. UnitName(unit), A.WarStomp.ID)
		return A.WarStomp
    end 
    
    if useRacial and A.BullRush:AutoRacial(unit) then 
        -- Notification					
        Action.SendNotification("BullRush on : " .. UnitName(unit), A.BullRush.ID)
		return A.BullRush
    end      
end 
Interrupts = A.MakeFunctionCachedDynamic(Interrupts)

local function EvaluateTargetIfFilterMarkedforDeath55(unit)
  return Unit(unit):TimeToDie()
end

local function EvaluateTargetIfMarkedforDeath60(unit)
  return (MultiUnits:GetByRangeInCombat(40, 5, 10) > 1) and (Unit(unit):TimeToDie() < Player:ComboPointsDeficit() or not Player:IsStealthed() and Player:ComboPointsDeficit() >= CPMaxSpend() - 1)
end


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
    local Pull = Action.BossMods:GetPullTimer()
	local RtB_Buffs = RtB_Buffs() 
	local RtB_Reroll = RtB_Reroll()
	CheckGoodBuffs()
	
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
    --print(RtB_Buffs())
	--print(RtB_Reroll())
    ------------------------------------------------------
    ---------------- ENEMY UNIT ROTATION -----------------
    ------------------------------------------------------
    local function EnemyRotation(unit)
        local Precombat, Build, Cds, Essences, Finish, Stealth
        -- variable,name=ambush_condition,value=combo_points.deficit>=2+2*(talent.ghostly_strike.enabled&cooldown.ghostly_strike.remains<1)+buff.broadside.up&energy>60&!buff.skull_and_crossbones.up&!buff.keep_your_wits_about_you.up
        local VarAmbushCondition = (Player:ComboPointsDeficit() >= 2 + 2 * num((A.GhostlyStrike:IsSpellLearned() and A.GhostlyStrike:GetCooldown() < 1)) + num(Unit("player"):HasBuffs(A.Broadside.ID, true) > 0) and Player:EnergyPredicted() > 60 and Unit("player"):HasBuffs(A.SkullandCrossbones.ID, true) == 0 and Unit("player"):HasBuffs(A.KeepYourWitsBuff.ID, true) == 0) and true or false
        -- variable,name=bte_condition,value=buff.ruthless_precision.up|(azerite.deadshot.enabled|azerite.ace_up_your_sleeve.enabled)&buff.roll_the_bones.up
        local VarBteCondition = ((Unit("player"):HasBuffs(A.RuthlessPrecision.ID, true) > 0 or (A.Deadshot:GetAzeriteRank() > 0 or A.AceUpYourSleeve:GetAzeriteRank() > 0) and RtB_Buffs > 0) and true) or false
        -- variable,name=blade_flurry_sync,value=spell_targets.blade_flurry<2&raid_event.adds.in>20|buff.blade_flurry.up
        local VarBladeFlurrySync = (MultiUnits:GetByRange(8, 5, 10) >= 2 and Unit("player"):HasBuffs(A.BladeFlurry.ID, true) > 0) and true or false      
		--print(VarBladeFlurrySync)
		-- Trinkets vars
        local Trinket1IsAllowed, Trinket2IsAllowed = TR:TrinketIsAllowed()
		
		--Precombat
        local function Precombat(unit)
            -- flask
            -- augmentation
            -- food
            -- snapshot_stats
            -- potion
            if A.PotionofUnbridledFury:IsReady(unit) and Action.GetToggle(1, "Potion") 
			and (Pull > 0 and Pull <= 2 or not A.GetToggle(1, "DBM"))
			then
                return A.PotionofUnbridledFury:Show(icon)
            end
            -- marked_for_death,precombat_seconds=5,if=raid_event.adds.in>40
            if A.MarkedforDeath:IsReady(unit) 
			and (Pull > 0 and Pull <= 5 or not A.GetToggle(1, "DBM"))
			then
                return A.MarkedforDeath:Show(icon)
            end
            -- stealth,if=(!equipped.pocketsized_computation_device|!cooldown.cyclotronic_blast.duration|raid_event.invulnerable.exists)
            if A.Stealth:IsReady(unit) and not Player:IsStealthed() and Unit("player"):HasBuffs(A.VanishBuff.ID, true) == 0
			then
                return A.Stealth:Show(icon)
            end
            -- roll_the_bones,precombat_seconds=2
            if A.RolltheBones:IsReady("player") and RtB_Reroll 
			and (Pull > 0 and Pull <= 3 or not A.GetToggle(1, "DBM"))
			then
                return A.RolltheBones:Show(icon)
            end
            -- slice_and_dice,precombat_seconds=2
            if A.SliceandDice:IsReady("player") and Unit("player"):HasBuffsDown(A.SliceandDice.ID, true) 
			and (Pull > 0 and Pull <= 3 or not A.GetToggle(1, "DBM"))
			then
                return A.SliceandDice:Show(icon)
            end
            -- use_item,name=azsharas_font_of_power
            if A.AzsharasFontofPower:IsReady(player) and A.BurstIsON(unit) 
			and (Pull > 0 and Pull <= 7 or not A.GetToggle(1, "DBM"))
			then
                return A.AzsharasFontofPower:Show(icon)
            end
            -- use_item,effect_name=cyclotronic_blast,if=!raid_event.invulnerable.exists
            if A.CyclotronicBlast:IsReady(unit) and A.BurstIsON(unit) 
			and (Pull > 0 and Pull <= 1 or not A.GetToggle(1, "DBM"))
			then
                return A.CyclotronicBlast:Show(icon)
            end
            -- ambush
            if A.Ambush:IsReady(unit) 
			and (Pull > 0 and Pull < 1 or not A.GetToggle(1, "DBM"))
			and
			    (
				    (Unit(unit):HasDeBuffs(A.Sap.ID, true) > 0 and Unit(unit):GetDR("incapacitate") < 50 ) 
					or
					Unit(unit):HasDeBuffs(A.Sap.ID, true) == 0
				)
			then
                return A.Ambush:Show(icon)
            end
        end
        
        --Essences
        local function Essences(unit)
            -- concentrated_flame,if=energy.time_to_max>1&!buff.blade_flurry.up&(!dot.concentrated_flame_burn.ticking&!action.concentrated_flame.in_flight|full_recharge_time<gcd.max)
            if A.ConcentratedFlame:AutoHeartOfAzeroth(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") and (Player:EnergyTimeToMaxPredicted() > 1 and Unit("player"):HasBuffs(A.BladeFlurry.ID, true) == 0 and (not Unit(unit):HasDeBuffs(A.ConcentratedFlameBurn.ID, true) and not A.ConcentratedFlame:IsSpellInFlight() or A.ConcentratedFlame:GetSpellChargesFullRechargeTime() < A.GetGCD())) then
                return A.ConcentratedFlame:Show(icon)
            end
			
            -- blood_of_the_enemy,if=variable.blade_flurry_sync&cooldown.between_the_eyes.up&variable.bte_condition
            if A.BloodoftheEnemy:AutoHeartOfAzeroth(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") and A.BetweentheEyes:GetCooldown() == 0 then
                return A.BloodoftheEnemy:Show(icon)
            end
			
            -- guardian_of_azeroth
            if A.GuardianofAzeroth:AutoHeartOfAzeroth(unit, true) and A.BurstIsON(unit) and Action.GetToggle(1, "HeartOfAzeroth") then
                return A.GuardianofAzeroth:Show(icon)
            end
			
            -- focused_azerite_beam,if=spell_targets.blade_flurry>=2|raid_event.adds.in>60&!buff.adrenaline_rush.up
            if A.FocusedAzeriteBeam:AutoHeartOfAzeroth(unit, true) and A.BurstIsON(unit) 
			and Action.GetToggle(1, "HeartOfAzeroth") 
			and ((MultiUnits:GetByRange(8, 5, 10) >= 2 or Unit(unit):IsBoss()) and Unit("player"):HasBuffs(A.AdrenalineRush.ID, true) == 0) then
                return A.FocusedAzeriteBeam:Show(icon)
            end
			
            -- purifying_blast,if=spell_targets.blade_flurry>=2|raid_event.adds.in>60
            if A.PurifyingBlast:AutoHeartOfAzeroth(unit, true) and A.BurstIsON(unit) and Action.GetToggle(1, "HeartOfAzeroth") and (MultiUnits:GetByRange(8, 5, 10) >= 2) then
                return A.PurifyingBlast:Show(icon)
            end
			
            -- the_unbound_force,if=buff.reckless_force.up|buff.reckless_force_counter.stack<10
            if A.TheUnboundForce:AutoHeartOfAzeroth(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") and (Unit("player"):HasBuffs(A.RecklessForceBuff.ID, true) > 0 or Unit("player"):HasBuffsStacks(A.RecklessForceCounter.ID, true) < 10) then
                return A.TheUnboundForce:Show(icon)
            end
			
            -- ripple_in_space
            if A.RippleinSpace:AutoHeartOfAzeroth(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") then
                return A.RippleinSpace:Show(icon)
            end
			
            -- worldvein_resonance
            if A.WorldveinResonance:AutoHeartOfAzeroth(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") then
                return A.WorldveinResonance:Show(icon)
            end
			
            -- memory_of_lucid_dreams,if=energy<45
            if A.MemoryofLucidDreams:AutoHeartOfAzeroth(unit, true) and A.BurstIsON(unit) and Action.GetToggle(1, "HeartOfAzeroth") and (Player:EnergyPredicted() < 45) then
                return A.MemoryofLucidDreams:Show(icon)
            end
			
            -- reaping_flames,if=target.health.pct>80|target.health.pct<=20|target.time_to_pct_20>30
            if A.ReapingFlames:AutoHeartOfAzerothP(unit, true) and (Unit(unit):HealthPercent() > 80 or Unit(unit):HealthPercent() <= 20 or Unit(unit):TimeToDieX(20) > 30) then
                return A.ReapingFlames:Show(icon)
            end
			
			-- reaping_flames
          --  if A.ReapingFlames:AutoHeartOfAzeroth(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") then
          --      return A.ReapingFlames:Show(icon)
          --  end
			
			-- moment_of_glory
            if A.MomentofGlory:AutoHeartOfAzeroth(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") then
                return A.MomentofGlory:Show(icon)
            end

			-- ReplicaofKnowledge
            if A.ReplicaofKnowledge:AutoHeartOfAzeroth(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") then
                return A.ReplicaofKnowledge:Show(icon)
            end	
        end
		
        --Build
        local function Build(unit)
            -- pistol_shot,if=buff.opportunity.up&(buff.keep_your_wits_about_you.stack<14|buff.deadshot.up|energy<45)
            if A.PistolShot:IsReadyByPassCastGCD(unit, nil, nil, true) and 
			    (
				    Unit("player"):HasBuffs(A.Opportunity.ID, true) > 0 
					and 
					(
					    Unit("player"):HasBuffsStacks(A.KeepYourWitsBuff.ID, true) < 14 
						or 
						Unit("player"):HasBuffs(A.DeadshotBuff.ID, true) > 0 
						or 
						Player:EnergyPredicted() < 45
					)
				) 
			then
                return A.PistolShot:Show(icon)
            end
            -- sinister_strike
            if A.SinisterStrike:IsReady(unit) then
                return A.SinisterStrike:Show(icon)
            end
        end
        
        --Cds
        local function Cds(unit)
            -- call_action_list,name=essences,if=!stealthed.all
            if (not Player:IsStealthed()) and Essences(unit) then
                return true
            end
            -- adrenaline_rush,if=!buff.adrenaline_rush.up&energy.time_to_max>1&(!equipped.azsharas_font_of_power|cooldown.latent_arcana.remains>20)
            if A.AdrenalineRush:IsReady(unit) and A.BurstIsON(unit) and (Unit("player"):HasBuffs(A.AdrenalineRush.ID, true) == 0 and Player:EnergyTimeToMaxPredicted() > 1 ) then
			    -- Notification					
                Action.SendNotification("Bursting ", A.AdrenalineRush.ID)
				return A.AdrenalineRush:Show(icon)
            end
            -- marked_for_death,if=raid_event.adds.in>30-raid_event.adds.duration&!stealthed.rogue&combo_points.deficit>=cp_max_spend-1
            if A.MarkedforDeath:IsReady(unit) and (not Player:IsStealthed() and Player:ComboPointsDeficit() >= CPMaxSpend() - 1) then
                return A.MarkedforDeath:Show(icon)
            end
            -- ghostly_strike,if=variable.blade_flurry_sync&combo_points.deficit>=1+buff.broadside.up
            if A.GhostlyStrike:IsReady(unit) and (Player:ComboPointsDeficit() >= 1 + num(Unit("player"):HasBuffs(A.Broadside.ID, true) > 0)) then
                return A.GhostlyStrike:Show(icon)
            end
            -- killing_spree,if=variable.blade_flurry_sync&(energy.time_to_max>5|energy<15)
            if A.KillingSpree:IsReady(unit) and (Player:EnergyTimeToMaxPredicted() > 5 or Player:EnergyPredicted() < 15) then
                return A.KillingSpree:Show(icon)
            end
            -- blade_rush,if=variable.blade_flurry_sync&energy.time_to_max>1
            if A.BladeRush:IsReady(unit) and (Player:EnergyTimeToMaxPredicted() > 1) then
                return A.BladeRush:Show(icon)
            end
            -- vanish,if=!stealthed.all&variable.ambush_condition
            if A.Vanish:IsReady(unit) and (not Player:IsStealthed() and VarAmbushCondition) and A.GetToggle(2, "UseDPSVanish") then
                -- Notification					
                Action.SendNotification("Vanish burst", A.Vanish.ID)
				return A.Vanish:Show(icon)
            end
            -- shadowmeld,if=!stealthed.all&variable.ambush_condition
            if A.Shadowmeld:AutoRacial(unit) and Action.GetToggle(1, "Racial") and A.BurstIsON(unit) and (not Player:IsStealthed() and VarAmbushCondition) then
                return A.Shadowmeld:Show(icon)
            end
            -- potion,if=buff.bloodlust.react|buff.adrenaline_rush.up
            if A.PotionofUnbridledFury:IsReady(unit) and Action.GetToggle(1, "Potion") and (Unit("player"):HasHeroism() or Unit("player"):HasBuffs(A.AdrenalineRush.ID, true) > 0) then
                return A.PotionofUnbridledFury:Show(icon)
            end
            -- blood_fury
            if A.BloodFury:AutoRacial(unit) and Action.GetToggle(1, "Racial") and A.BurstIsON(unit) then
                return A.BloodFury:Show(icon)
            end
            -- berserking
            if A.Berserking:AutoRacial(unit) and Action.GetToggle(1, "Racial") and A.BurstIsON(unit) then
                return A.Berserking:Show(icon)
            end
            -- fireblood
            if A.Fireblood:AutoRacial(unit) and Action.GetToggle(1, "Racial") and A.BurstIsON(unit) then
                return A.Fireblood:Show(icon)
            end
            -- ancestral_call
            if A.AncestralCall:AutoRacial(unit) and Action.GetToggle(1, "Racial") and A.BurstIsON(unit) then
                return A.AncestralCall:Show(icon)
            end
            -- Trinkets
            if A.Trinket1:IsReady(unit) and Trinket1IsAllowed and A.Trinket1:GetItemCategory() ~= "DEFF" then 
                return A.Trinket1:Show(icon)
            end                                 
            if A.Trinket2:IsReady(unit) and Trinket2IsAllowed and A.Trinket2:GetItemCategory() ~= "DEFF" then 
                return A.Trinket2:Show(icon)
            end 
            -- use_item,effect_name=cyclotronic_blast,if=!stealthed.all&buff.adrenaline_rush.down&buff.memory_of_lucid_dreams.down&energy.time_to_max>4&rtb_buffs<5
            if A.CyclotronicBlast:IsReady(unit) and (not Player:IsStealthed() and bool(Unit("player"):HasBuffsDown(A.AdrenalineRush.ID, true)) and bool(Unit("player"):HasBuffsDown(A.MemoryofLucidDreamsBuff.ID, true)) and Player:EnergyTimeToMaxPredicted() > 4 and RtB_Buffs() < 5) then
                return A.CyclotronicBlast:Show(icon)
            end
            -- use_item,name=azsharas_font_of_power,if=!buff.adrenaline_rush.up&!buff.blade_flurry.up&cooldown.adrenaline_rush.remains<15
            if A.AzsharasFontofPower:IsReady(player) and 
			    (
				    Unit("player"):HasBuffs(A.AdrenalineRush.ID, true) == 0 
					and 
					A.AdrenalineRush:GetCooldown() < 15
				) 
			then
                return A.AzsharasFontofPower:Show(icon)
            end			
            -- use_item,name=ashvanes_razor_coral,if=debuff.razor_coral_debuff.down|debuff.vendetta.remains>10-4*equipped.azsharas_font_of_power|target.time_to_die<20
            if A.AshvanesRazorCoral:IsReady(unit) 
	    	and (
		            (Unit(unit):HasDeBuffsStacks(A.RazorCoralDebuff.ID, true) == 0)
		    		or 
			    	-- Execute phase
                    (
			    	    Unit(unit):HealthPercent() <= 31 and Unit(unit):HasDeBuffsStacks(A.RazorCoralDebuff.ID, true) >= 10 
			    	) 
		    	) 
		    then
                return A.AshvanesRazorCoral:Show(icon)
            end	
			
            -- use_items,if=buff.bloodlust.react|target.time_to_die<=20|combo_points.deficit<=2
        end
                
        --Finish
        local function Finish(unit)
            -- between_the_eyes,if=variable.bte_condition
            if A.BetweentheEyes:IsReadyByPassCastGCD(unit, nil, nil, true) and CanCast and (VarBteCondition) and not RtB_Reroll then
                return A.BetweentheEyes:Show(icon)
            end
            -- slice_and_dice,if=buff.slice_and_dice.remains<target.time_to_die&buff.slice_and_dice.remains<(1+combo_points)*1.8
            if A.SliceandDice:IsReady("player") and CanCast and (Unit("player"):HasBuffs(A.SliceandDice.ID, true) < Unit(unit):TimeToDie() and Unit("player"):HasBuffs(A.SliceandDice.ID, true) < (1 + Player:ComboPoints()) * 1.8) then
                return A.SliceandDice:Show(icon)
            end
            -- roll_the_bones,if=buff.roll_the_bones.remains<=3|variable.rtb_reroll
            if A.RolltheBones:IsReady("player") and CanCast and RtB_Reroll then
                return A.RolltheBones:Show(icon)
            end
            -- between_the_eyes,if=azerite.ace_up_your_sleeve.enabled|azerite.deadshot.enabled
            if A.BetweentheEyes:IsReadyByPassCastGCD(unit, nil, nil, true) and CanCast and not RtB_Reroll and (A.AceUpYourSleeve:GetAzeriteRank() > 0 or A.Deadshot:GetAzeriteRank() > 0) then
                return A.BetweentheEyes:Show(icon)
            end
            -- dispatch
            if A.Dispatch:IsReadyByPassCastGCD(unit, nil, nil, true) and CanCast and not RtB_Reroll then
                return A.Dispatch:Show(icon)
            end
        end
        
        --Stealth
        local function Stealth(unit)
            -- ambush
            if A.Ambush:IsReady(unit) then
                return A.Ambush:Show(icon)
            end
        end
                
        -- call precombat
        if not inCombat and Unit(unit):IsExists() and unit ~= "mouseover" and Precombat(unit) then 
            return true
        end
		
	    -- Sap out of combat
	    if A.Sap:IsReady(unit) and Player:IsStealthed() and Unit(unit):CombatTime() == 0 then
	        if Unit(unit):HasDeBuffs(A.Sap.ID, true) == 0 and Unit(unit):IsControlAble("incapacitate", 75) then 
	            -- Notification					
                Action.SendNotification("Out of combat Sap on : " .. UnitName(unit), A.Sap.ID)
		        return A.Sap:Show(icon)
		    else 
		        if Unit(unit):HasDeBuffs(A.Sap.ID, true) > 0 and Unit(unit):HasDeBuffs(A.Sap.ID, true) <= 1 and Unit(unit):IsControlAble("incapacitate", 25) then
   			        -- Notification					
                    Action.SendNotification("Refreshing Sap on : " .. UnitName(unit), A.Sap.ID)
		            return A.Sap:Show(icon)
			    end
		    end
	    end	

        -- In Combat
        if inCombat and Unit(unit):IsExists() then
            -- MfD Sniping
           --MfDSniping(A.MarkedforDeath)
			
    		-- stealth
            if A.Stealth:IsReady(unit) and not Player:IsStealthed() and Unit("player"):HasBuffs(A.VanishBuff.ID, true) == 0 then
                return A.Stealth:Show(icon)
            end
			
		    -- Interrupt
            local Interrupt = Interrupts(unit)
            if Interrupt and CanCast then 
                return Interrupt:Show(icon)
            end	
			
	        -- Sprint if out of range 
            if A.Sprint:IsReady("player") and CanCast and isMovingFor > A.GetToggle(2, "SprintTime") and A.GetToggle(2, "UseSprint") then
                return A.Sprint:Show(icon)
            end
			            
			-- call_action_list,name=stealth,if=stealthed.all
            if (Player:IsStealthed() or Unit("player"):HasBuffs(A.VanishBuff.ID, true) > 0) and CanCast and Stealth(unit) then
                return true
            end
			
			-- AoE
			if (A.GetToggle(2, "AoE") or isMulti) and CanCast then 
                -- blade_flurry,if=spell_targets>=2&!buff.blade_flurry.up&(!raid_event.adds.exists|raid_event.adds.remains>8|raid_event.adds.in>(2-cooldown.blade_flurry.charges_fractional)*25)
                if A.BladeFlurry:IsReady("player") and 
			        (
				        MultiUnits:GetByRange(A.GetToggle(2, "BladeFlurryRange"), 5, 5) >= A.GetToggle(2, "BladeFlurryTargets") 
				    	and 
				    	(Unit("player"):HasBuffs(A.BladeFlurry.ID, true) <= A.GetCurrentGCD() + A.GetGCD() + A.GetPing() or Unit("player"):HasBuffs(A.BladeFlurry.ID, true) == 0)
			    	) 
			    then
                    return A.BladeFlurry:Show(icon)
                end
			
                -- blood_of_the_enemy,if=big_aoe
                if A.BloodoftheEnemy:AutoHeartOfAzeroth(unit, true) and Action.GetToggle(2, "BotEAoEBurst") and Action.GetToggle(1, "HeartOfAzeroth") and 
     	            (
			    	    MultiUnits:GetByRange(A.GetToggle(2, "BladeFlurryRange"), 5, 5) >= A.GetToggle(2, "BladeFlurryTargets") 
			    		and 
			    		(Unit("player"):HasBuffs(A.BladeFlurry.ID, true) > 0)
			    	)           
			    then
                    return A.BloodoftheEnemy:Show(icon)
                end	
			end
			
            -- call_action_list,name=cds
            if Cds(unit) and CanCast then
                return true
            end
			
            -- run_action_list,name=finish,if=combo_points>=cp_max_spend-(buff.broadside.up+buff.opportunity.up)*(talent.quick_draw.enabled&(!talent.marked_for_death.enabled|cooldown.marked_for_death.remains>1))*(azerite.ace_up_your_sleeve.rank<2|!cooldown.between_the_eyes.up|!buff.roll_the_bones.up)
            if Finish(unit) and 
			(
    			(
				    A.QuickDraw:IsSpellLearned() and Player:ComboPoints() >= CPMaxSpend() -
					                           (
											      num(Unit("player"):HasBuffs(A.Broadside.ID, true) > 0) 
												  + 
												  num(Unit("player"):HasBuffs(A.Opportunity.ID, true) > 0)
												) 
				) 
				or
				(
				    not A.QuickDraw:IsSpellLearned() and Player:ComboPoints() >= CPMaxSpend()
				
				)
			)
			then
                return true
            end
			
            -- call_action_list,name=build
            if Build(unit) and CanCast then
                return true
            end
			
            -- arcane_torrent,if=energy.deficit>=15+energy.regen
            if A.ArcaneTorrent:IsRacialReady(unit) and CanCast and Action.GetToggle(1, "Racial") and A.BurstIsON(unit) and (Player:EnergyDeficitPredicted() >= 15 + Player:EnergyRegen()) then
                return A.ArcaneTorrent:Show(icon)
            end
			
            -- bag_of_tricks
            if A.BagofTricks:AutoRacial(unit) and Action.GetToggle(1, "Racial") and A.BurstIsON(unit) then
                return A.BagofTricks:Show(icon)
            end	
			
            -- arcane_pulse
            if A.ArcanePulse:AutoRacial(unit) and CanCast and Action.GetToggle(1, "Racial") then
                return A.ArcanePulse:Show(icon)
            end

        end
    end

    -- End on EnemyRotation()
	
    -- Stealth out of combat	
    if not inCombat and Unit("player"):HasBuffs(A.VanishBuff.ID, true) == 0 and Action.GetToggle(2, "StealthOOC") and not Unit("player"):HasFlags() and A.Stealth:IsReady("player") and Unit("player"):HasBuffs(A.Stealth.ID, true) == 0 then
        -- Notification					
        Action.SendNotification("Auto Stealthing", A.Stealth.ID)
        return A.Stealth:Show(icon)
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
