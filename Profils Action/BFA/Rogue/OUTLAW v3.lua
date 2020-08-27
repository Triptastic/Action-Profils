-------------------------------
-- Taste TMW Action Rotation --
-------------------------------
local _G, setmetatable							= _G, setmetatable
local A     									= _G.Action
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
	Vigor                                  = Action.Create({ Type = "Spell", ID = 14983     }),
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
	KeepYourWitsAboutYouBuff               = Action.Create({ Type = "Spell", ID = 202895, Hidden = true }),
    VigorTrinketBuff                       = Action.Create({ Type = "Spell", ID = 287916, Hidden = true     }),
    KeepYourWitsBuff                       = Action.Create({ Type = "Spell", ID = 288988, Hidden = true     }),
    SnakeEyesBuff                          = Action.Create({ Type = "Spell", ID = 275863, Hidden = true     }),
    DeadshotBuff                           = Action.Create({ Type = "Spell", ID = 272940, Hidden = true     }),
    LoadedDiceBuff                         = Action.Create({ Type = "Spell", ID = 256171, Hidden = true     }),
    VanishBuff                             = Action.Create({ Type = "Spell", ID = 11327, Hidden = true     }),
    RolltheBones                           = Action.Create({ Type = "Spell", ID = 193316, Hidden = true     }),
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
	CorruptedGladiatorsMedallion           = Action.Create({ Type = "Trinket", ID = 172666 }), -- PvP Trinket 8.3
    -- Misc
    Channeling                             = Action.Create({ Type = "Spell", ID = 209274, Hidden = true     }),    -- Show an icon during channeling
    TargetEnemy                            = Action.Create({ Type = "Spell", ID = 44603, Hidden = true     }),    -- Change Target (Tab button)
    StopCast                               = Action.Create({ Type = "Spell", ID = 61721, Hidden = true     }),        -- spell_magic_polymorphrabbit
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
    RecklessForceBuff                      = Action.Create({ Type = "Spell", ID = 302932, Hidden = true     }), 
    GrandDelusionsDebuff                   = Action.Create({ Type = "Spell", ID = 319695, Hidden = true     }), -- Corruption pet chasing you	    
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
local VarOverRpCritThreshold = 0;
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
		VarOverRpCritThreshold = 0
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
}

local IsIndoors, UnitIsUnit, UnitName = IsIndoors, UnitIsUnit, UnitName


local function InRange(unit)
	-- @return boolean 
	return A.SinisterStrike:IsInRange(unit)
end 
InRange = A.MakeFunctionCachedDynamic(InRange)

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

local function GetByRangeTTD(self, count, range)
    -- @return number
    local total, total_ttd = 0, 0
    
    for unit in pairs(ActiveUnitPlates) do 
        if not range or Unit(unit):CanInterract(range) then 
            total = total + 1
            total_ttd = total_ttd + Unit(unit):TimeToDie()
        end 
        
        if count and total >= count then 
            break 
        end 
    end 
    
    if total > 0 then 
        return total_ttd / total     
    else  
        return huge
    end
end 
GetByRangeTTD = A.MakeFunctionCachedDynamic(GetByRangeTTD)

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
    local RtB_BuffRemainsDuration = 0
    for i = 1, #RtB_BuffsList do
        if Unit("player"):HasBuffs(RtB_BuffsList[i], true) > 0 then
            RtB_BuffRemainsDuration = Unit("player"):HasBuffs(RtB_BuffsList[i], true)
        end
    end

    return RtB_BuffRemainsDuration
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
    local unit = "target"
	
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
	elseif choice == "AUTO" then
        if A.GetToggle(2, "AoE") and GetByRange(2, 20, false, true) and Player:AreaTTD(20) >= 4 then
            local buffsCount = RtB_Buffs()
        
            if Unit("player"):HasBuffs(A.SkullandCrossbones.ID, true) > 0 then
                buffsCount = buffsCount - 1
            end
        
            if (A.Vigor:IsSpellLearned() or A.MarkedforDeath:IsSpellLearned()) and buffsCount < 2 and Unit("player"):HasBuffs(A.RuthlessPrecision.ID, true) == 0 and Unit("player"):HasBuffs(A.GrandMelee.ID, true) == 0 then
                GotGoodBuff = true
            end
        
            if A.DeeperStratagem:IsSpellLearned() and buffsCount < 2 and Unit("player"):HasBuffs(A.Broadside.ID, true) == 0 and Unit("player"):HasBuffs(A.RuthlessPrecision.ID, true) == 0 and Unit("player"):HasBuffs(A.GrandMelee.ID, true) == 0 then
                GotGoodBuff = true
            end
        
            if Unit("player"):HasBuffs(A.BladeFlurry.ID, true) == 0 and RtB_Buffs() > 0 and RtB_BuffRemains()  > 3 then
                GotGoodBuff = false
            end
			
        elseif (not A.GetToggle(2, "AoE") or GetByRange(2, 20, false, true) or Unit(unit):IsBoss()) and Unit(unit):TimeToDie() > 10 then
            if (A.Deadshot:GetAzeriteRank() > 0 or A.AceUpYourSleeve:GetAzeriteRank() > 0) and RtB_Buffs() < 2 and 
			(
			    Unit("player"):HasBuffs(A.LoadedDiceBuff.ID, true) > 0 
				or
                Unit("player"):HasBuffs(A.RuthlessPrecision.ID, true) <= A.BetweentheEyes:GetCooldown()
			)
			then
                GotGoodBuff = true
			end
        elseif RtB_Buffs() < 2 and 
		(
		    Unit("player"):HasBuffs(A.LoadedDiceBuff.ID, true) > 0 
			or 
			Unit("player"):HasBuffs(A.GrandMelee.ID, true) == 0 and Unit("player"):HasBuffs(A.RuthlessPrecision.ID, true) == 0
		)
		then
            GotGoodBuff = true
        end	
    -- SimC Default
    elseif choice == "SIMC" then  
        -- # Reroll for 2+ buffs with Loaded Dice up. Otherwise reroll for 2+ or Grand Melee or Ruthless Precision.
        -- actions=variable,name=rtb_reroll,value=rtb_buffs<2&(buff.loaded_dice.up|!buff.grand_melee.up&!buff.ruthless_precision.up)
        -- # Reroll for 2+ buffs or Broadside with Deadshot.
        -- actions+=/variable,name=rtb_reroll,op=set,if=azerite.deadshot.enabled,value=rtb_buffs<2&(buff.loaded_dice.up|!buff.broadside.up)
        -- # Reroll for 2+ buffs or Ruthless Precision with Ace up your Sleeve, unless there are more Deadshot ranks.
        -- actions+=/variable,name=rtb_reroll,op=set,if=azerite.ace_up_your_sleeve.enabled&azerite.ace_up_your_sleeve.rank>=azerite.deadshot.rank,value=rtb_buffs<2&(buff.loaded_dice.up|buff.ruthless_precision.remains<=cooldown.between_the_eyes.remains)
        -- # Always reroll for 2+ buffs with Snake Eyes.
        -- actions+=/variable,name=rtb_reroll,op=set,if=azerite.snake_eyes.rank>=2,value=rtb_buffs<2
        -- actions+=/variable,name=rtb_reroll,op=set,if=buff.blade_flurry.up,value=rtb_buffs-buff.skull_and_crossbones.up<2&(buff.loaded_dice.up|!buff.grand_melee.up&!buff.ruthless_precision.up&!buff.broadside.up)
        if Unit("player"):HasBuffs(A.LoadedDiceBuff.ID, true) > 0 then
            GotGoodBuff = (RtB_Buffs() - num(Unit("player"):HasBuffs(A.BuriedTreasure.ID, true)) < 2 or RtB_BuffRemains() <= 12.6) and true or false;
        elseif Unit("player"):HasBuffs(A.BladeFlurry.ID, true) > 0 then
            GotGoodBuff = (RtB_Buffs() - num(Unit("player"):HasBuffs(A.SkullandCrossbones.ID, true)) < 2 and (Unit("player"):HasBuffs(A.LoadedDiceBuff.ID, true) > 0 or
            (Unit("player"):HasBuffs(A.GrandMelee.ID, true) == 0 and Unit("player"):HasBuffs(A.RuthlessPrecision.ID, true) == 0 and Unit("player"):HasBuffs(A.Broadside.ID, true) == 0))) and true or false;
        elseif A.SnakeEyesPower:GetAzeriteRank() >= 2 then
            GotGoodBuff = (RtB_Buffs() < 2) and true or false;
            -- # Do not reroll if Snake Eyes is at 2+ stacks of the buff (1+ stack with Broadside up)
            -- actions+=/variable,name=rtb_reroll,op=reset,if=azerite.snake_eyes.rank>=2&buff.snake_eyes.stack>=2-buff.broadside.up
            if Unit("player"):HasBuffsStacks(A.SnakeEyesBuff.ID, true) >= 2 - num(Unit("player"):HasBuffs(A.Broadside.ID, true) > 0) then
                GotGoodBuff = false;
            end
        elseif A.AceUpYourSleeve:GetAzeriteRank() > 0 and A.AceUpYourSleeve:GetAzeriteRank() >= A.Deadshot:GetAzeriteRank() and Player:CritChancePct() < 42 then
            GotGoodBuff = (RtB_Buffs() < 2 and (Unit("player"):HasBuffs(A.LoadedDiceBuff.ID, true) > 0 or
            Unit("player"):HasBuffs(A.RuthlessPrecision.ID, true) <= A.BetweentheEyes:GetCooldown())) and true or false;
        elseif A.Deadshot:GetAzeriteRank() > 0 or Player:CritChancePct() >= 42 then
            GotGoodBuff = (RtB_Buffs() < 2 and (Unit("player"):HasBuffs(A.LoadedDiceBuff.ID, true) > 0 or Unit("player"):HasBuffs(A.Broadside.ID, true) == 0)) and true or false;
        else
            GotGoodBuff = (RtB_Buffs() < 2 and (Unit("player"):HasBuffs(A.LoadedDiceBuff.ID, true) or
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
    elseif Action.GetToggle(2, "RolltheBonesLogic") == "AOESTRAT" and GetByRange(2, 10) or (not Unit("target"):IsBoss()) then
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
    return not Action.GetToggle(2,"AoE") or GetByRange(2, 10, false, true) or Unit("player"):HasBuffs(A.BladeFlurry.ID, true) > 0
end

local function EnergyTimeToMaxRounded()
    -- Round to the nearesth 10th to reduce prediction instability on very high regen rates
    return math.floor(Player:EnergyTimeToMaxPredicted() * 10 + 0.5) / 10;
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

-- Non GCD spell check
local function countInterruptGCD(unit)
    if not A.Kick:IsReadyByPassCastGCD(unit) or not A.Kick:AbsentImun(unit, Temp.TotalAndPhysKick) then
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

        if useCC and Player:IsStealthed() and A.CheapShot:IsReady(unit) and A.CheapShot:AbsentImun(unit, Temp.TotalAndCC, true) then 
            -- Notification                    
            Action.SendNotification("CheapShot on : " .. UnitName(unit), A.CheapShot.ID)
            return A.CheapShot              
        end

        if useKick and A.Kick:IsReady(unit) and A.Kick:AbsentImun(unit, Temp.TotalAndPhysKick, true) then 
            -- Notification                    
            Action.SendNotification("Kick on : " .. UnitName(unit), A.Kick.ID)
            return A.Kick
        end 
    
        if useCC and A.Gouge:IsReady(unit) and A.Gouge:AbsentImun(unit, Temp.TotalAndCC, true) then 
            -- Notification                    
            Action.SendNotification("Gouge on : " .. UnitName(unit), A.Gouge.ID)
            return A.Gouge              
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

local function EvaluateTargetIfFilterMarkedforDeath55(unit)
    return Unit(unit):TimeToDie()
end

local function EvaluateTargetIfMarkedforDeath60(unit)
    return (GetByRange(1, 10, true)) and (Unit(unit):TimeToDie() < Player:ComboPointsDeficit() or not Player:IsStealthed() and Player:ComboPointsDeficit() >= CPMaxSpend() - 1)
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
    local unit = "player"
    local RtB_Buffs = RtB_Buffs() 
    local RtB_Reroll = RtB_Reroll()
	local RtB_CurrentBuffsRemains = RtB_BuffRemains()
	local BloodoftheEnemySyncAoE = A.GetToggle(2, "BloodoftheEnemySyncAoE")
	local BloodoftheEnemyAoETTD = A.GetToggle(2, "BloodoftheEnemyAoETTD")
	local BloodoftheEnemyUnits = A.GetToggle(2, "BloodoftheEnemyUnits")
	
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

        -- variable,name=ambush_condition,value=combo_points.deficit>=2+2*(talent.ghostly_strike.enabled&cooldown.ghostly_strike.remains<1)+buff.broadside.up&energy>60&!buff.skull_and_crossbones.up&!buff.keep_your_wits_about_you.up
        local VarAmbushCondition = (Player:ComboPointsDeficit() >= 2 + 2 * num((A.GhostlyStrike:IsSpellLearned() and A.GhostlyStrike:GetCooldown() < 1)) + num(Unit("player"):HasBuffs(A.Broadside.ID, true) > 0) and Player:EnergyPredicted() > 60 and Unit("player"):HasBuffs(A.SkullandCrossbones.ID, true) == 0 and Unit("player"):HasBuffs(A.KeepYourWitsBuff.ID, true) == 0) and true or false
        -- variable,name=bte_condition,value=buff.ruthless_precision.up|(azerite.deadshot.enabled|azerite.ace_up_your_sleeve.enabled)&buff.roll_the_bones.up
        local VarBteCondition = ((Unit("player"):HasBuffs(A.RuthlessPrecision.ID, true) > 0 or (A.Deadshot:GetAzeriteRank() > 0 and A.AceUpYourSleeve:GetAzeriteRank() > 0) and RtB_Buffs > 0) and true) or false
        -- variable,name=blade_flurry_sync,value=spell_targets.blade_flurry<2&raid_event.adds.in>20|buff.blade_flurry.up
        local VarBladeFlurrySync = (GetByRange(2, 10, false, true) and Unit("player"):HasBuffs(A.BladeFlurry.ID, true) > 0) and true or false      
        --print(VarBladeFlurrySync)
        -- variable,name=over_rp_crit_threshold,value=attack_crit>0.42
        local VarOverRpCritThreshold = num(Player:CritChancePct() > 42)		
		
        -- Trinkets vars
        local Trinket1IsAllowed, Trinket2IsAllowed = TR:TrinketIsAllowed()
        local ActiveSap = MultiUnits:GetByRangeAppliedDoTs(40, 1, A.Sap.ID)
		
        --Precombat
        if not inCombat and Unit(unit):IsExists() and unit ~= "mouseover" then 
            -- flask
            -- augmentation
            -- food
            -- snapshot_stats
			
            -- potion
            if A.PotionofUnbridledFury:IsReady(unit) and Action.GetToggle(1, "Potion") 
            and (Pull > 0 and Pull <= 2 or not A.GetToggle(1, "BossMods"))
            then
                return A.PotionofUnbridledFury:Show(icon)
            end
			
            -- marked_for_death,precombat_seconds=5,if=raid_event.adds.in>40
            if A.MarkedforDeath:IsReady(unit) 
            and (Pull > 0 and Pull <= 5 or not A.GetToggle(1, "BossMods"))
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
            and (Pull > 0 and Pull <= 3 or not A.GetToggle(1, "BossMods"))
            then
                return A.RolltheBones:Show(icon)
            end
			
            -- slice_and_dice,precombat_seconds=2
            if A.SliceandDice:IsReady("player") and Unit("player"):HasBuffsDown(A.SliceandDice.ID, true) 
            and (Pull > 0 and Pull <= 3 or not A.GetToggle(1, "BossMods"))
            then
                return A.SliceandDice:Show(icon)
            end
			
            -- use_item,name=azsharas_font_of_power
            if A.AzsharasFontofPower:IsReady(unit) and A.BurstIsON(unit) 
            and (Pull > 0 and Pull <= 7 or not A.GetToggle(1, "BossMods"))
            then
                return A.AzsharasFontofPower:Show(icon)
            end
			
            -- use_item,effect_name=cyclotronic_blast,if=!raid_event.invulnerable.exists
            if A.CyclotronicBlast:IsReady(unit) and A.BurstIsON(unit) 
            and (Pull > 0 and Pull <= 1 or not A.GetToggle(1, "BossMods"))
            then
                return A.CyclotronicBlast:Show(icon)
            end
			
			-- Opener with UI settings
			local OpenerMode = A.GetToggle(2, "OpenerMode")
			
			if OpenerMode == "AUTO" then

                if A.IsInPvP and (A.Zone == "pvp" or A.Zone == "arena") then 
                	if Player:IsStealthed() and Unit(unit):IsPlayer() and A.LastPlayerCastName == A.Sap:Info() and not Unit(unit):IsBoss() and 
				    ( 
				        Unit(unit):HasDeBuffs(A.Sap.ID, true) > 0 and Unit(unit):HasDeBuffs(A.Sap.ID, true) <= 1
					    or
					    ActiveSap > 0 and Unit(unit):HasDeBuffs(A.Sap.ID, true) == 0
                    )
				    then
				        return A.CheapShot:Show(icon)
					end
                else
                    if Player:IsStealthed() and A.CheapShot:IsReadyByPassCastGCD(unit, nil, nil, true) and not Unit(unit):IsBoss() then
                        return A.CheapShot:Show(icon)
                    end
                
                    if Player:IsStealthed() and A.Ambush:IsReadyByPassCastGCD(unit, nil, nil, true) then
                        return A.Ambush:Show(icon)
                    end
                end
			elseif Player:IsStealthed() and OpenerMode == "CHEAPSHOT" then
			    return A.CheapShot:Show(icon)
			elseif Player:IsStealthed() and OpenerMode == "AMBUSH" then
			    return A.Ambush:Show(icon)
			end			    
			
            -- ambush
        --[[    if A.Ambush:IsReady(unit) 
            and (Pull > 0 and Pull < 1 or not A.GetToggle(1, "BossMods"))
            and
            (
                (Unit(unit):HasDeBuffs(A.Sap.ID, true) > 0 and Unit(unit):GetDR("incapacitate") < 50 ) 
                or
                Unit(unit):HasDeBuffs(A.Sap.ID, true) == 0
            )
            then
                return A.Ambush:Show(icon)
            end]]--
        end 
        
        -- Sap out of combat		
        if A.IsInPvP and A.Sap:IsReady(unit) and Player:IsStealthed() and Unit(unit):CombatTime() == 0 then
            if Unit(unit):HasDeBuffs(A.Sap.ID, true) == 0 and Unit(unit):IsControlAble("incapacitate", 75) and ActiveSap == 0 then 
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
        if inCombat then
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

	        -- Thing from Beyond handler
	        if unit == "mouseover" and
			(
				tonumber((UnitGUID("mouseover")):sub(-12, -9), 16) == 160966 -- Thing From Beyong
			    or 
				tonumber((UnitGUID("mouseover")):sub(-12, -9), 16) == 161895 -- Thing From Beyong
				or
                Unit("player"):HasDeBuffs(A.GrandDelusionsDebuff.ID, true) > 0 
				or
				UnitName("mouseover") == "Thing From Beyond"
			)
		    then
			    if A.PistolShot:IsReady(unit) then
				    return A.PistolShot:Show(icon)
				elseif A.BetweentheEyes:IsReady(unit) and Player:ComboPoints() >= 2 then
				    return A.BetweentheEyes:Show(icon)
				else
				    if A.Blind:IsReady(unit) then 
	                    return A.Blind:Show(icon)
					end
				end
	        end

            -- Explosives handler
            if CanCast and Unit(unit):IsExplosives() then
			    if Unit(unit):GetRange() < 6 then
				    if A.SinisterStrike:IsReady(unit) then
                        return A.SinisterStrike:Show(icon)
					end
				else
				    if A.PistolShot:IsReady(unit) then
				        return A.PistolShot:Show(icon)
					end
				end
            end
                 
            if A.LastPlayerCastName == A.Vanish:Info() then
			    if not Unit(unit):IsBoss() and A.CheapShot:IsReadyByPassCastGCD(unit, nil, nil, true) then
                    return A.CheapShot:Show(icon)   
                else
				    if A.Ambush:IsReadyByPassCastGCD(unit, nil, nil, true) then
                        return A.Ambush:Show(icon)
					end
                end
            end				
			
            -- call_action_list,name=stealth,if=stealthed.all
        --    if (Player:IsStealthed() or Unit("player"):HasBuffs(A.VanishBuff.ID, true) > 0) and CanCast then
        --        -- ambush
        --        if A.Ambush:IsReady(unit) then
        --            return A.Ambush:Show(icon)
        --        end
        --    end
            
            -- AoE
            if (A.GetToggle(2, "AoE") or isMulti) and CanCast then 
			    -- blade_flurry,if=spell_targets>=2&!buff.blade_flurry.up&(!raid_event.adds.exists|raid_event.adds.remains>8|raid_event.adds.in>(2-cooldown.blade_flurry.charges_fractional)*25)
			    if A.BladeFlurry:IsReady("player") and 
				GetByRange(A.GetToggle(2, "BladeFlurryTargets"), A.GetToggle(2, "BladeFlurryRange")) and 
        	    Unit("player"):HasBuffs(A.BladeFlurry.ID, true) <= A.GetCurrentGCD() + A.GetGCD() + A.GetPing() and 
				GetByRangeTTD(A.GetToggle(2, "BladeFlurryTargets"), A.GetToggle(2, "BladeFlurryRange")) >= 3 
				then
            	    return A.BladeFlurry:Show(icon)
       	        end
			
                -- blade_flurry,if=spell_targets>=2&!buff.blade_flurry.up&(!raid_event.adds.exists|raid_event.adds.remains>8|raid_event.adds.in>(2-cooldown.blade_flurry.charges_fractional)*25)
        --[[        if A.BladeFlurry:IsReady("player") and 
                (
                    GetByRange(A.GetToggle(2, "BladeFlurryTargets"), A.GetToggle(2, "BladeFlurryRange"))
                    and 
                    (
					    Unit("player"):HasBuffs(A.BladeFlurry.ID, true) <= A.GetCurrentGCD() + A.GetGCD() + A.GetPing() 
						or 
						Unit("player"):HasBuffs(A.BladeFlurry.ID, true) == 0
					)
                ) 
                then
                    return A.BladeFlurry:Show(icon)
                end
]]--
               -- blood_of_the_enemy,if=variable.blade_flurry_sync&cooldown.between_the_eyes.up&variable.bte_condition
                if A.BloodoftheEnemy:AutoHeartOfAzerothP(unit) and 
				RtB_Buffs > 0 and 
				A.BetweentheEyes:GetCooldown() == 0 and 
				BloodoftheEnemySyncAoE and 
				Action.GetToggle(1, "HeartOfAzeroth") and 				
				(
				    GetByRange(BloodoftheEnemyUnits, A.GetToggle(2, "BladeFlurryRange")) and
			        (
			            Player:AreaTTD(A.GetToggle(2, "BladeFlurryRange")) >= BloodoftheEnemyAoETTD and MultiUnits:GetByRange(A.GetToggle(2, "BladeFlurryRange")) >= BloodoftheEnemyUnits
			        )
					or 
					Unit(unit):IsBoss()
				)
			    then
                    return A.BloodoftheEnemy:Show(icon)
                end		
   
            end
            
            -- call_action_list,name=cds
            if A.BurstIsON(unit) and CanCast then			
			
                -- adrenaline_rush,if=!buff.adrenaline_rush.up&energy.time_to_max>1&(!equipped.azsharas_font_of_power|cooldown.latent_arcana.remains>20)
                if A.AdrenalineRush:IsReady("player") and Unit(unit):GetRange() <= 6 and A.BurstIsON(unit) and 
				(
				    (
					    (
						    (
							    Azerite:EssenceHasMajor(A.BloodoftheEnemy.ID) and 
								A.BloodoftheEnemy:GetCooldown() > 5
							)
							or 
							not Azerite:EssenceHasMajor(A.BloodoftheEnemy.ID)
						)
						and
					    Unit("player"):HasBuffs(A.AdrenalineRush.ID, true) == 0 and 
					    Player:EnergyTimeToMaxPredicted() > 1
					)
					or
					( 
					    A.BloodoftheEnemy:GetCooldown() > 0 
						or
						A.LastPlayerCastName == A.BloodoftheEnemy:Info()
					)
				)
				then
                    -- Notification                    
                    Action.SendNotification("Bursting ", A.AdrenalineRush.ID)
                    return A.AdrenalineRush:Show(icon)
                end
			
                -- ESSENCES
			    -- call_action_list,name=essences,if=!stealthed.all
                -- concentrated_flame,if=energy.time_to_max>1&!buff.blade_flurry.up&(!dot.concentrated_flame_burn.ticking&!action.concentrated_flame.in_flight|full_recharge_time<gcd.max)
                if A.ConcentratedFlame:AutoHeartOfAzerothP(unit) and Action.GetToggle(1, "HeartOfAzeroth") and (Player:EnergyTimeToMaxPredicted() > 1 and Unit("player"):HasBuffs(A.BladeFlurry.ID, true) == 0 and (Unit(unit):HasDeBuffs(A.ConcentratedFlameBurn.ID, true) == 0 and not A.ConcentratedFlame:IsSpellInFlight() or A.ConcentratedFlame:GetSpellChargesFullRechargeTime() < A.GetGCD())) then
                    return A.ConcentratedFlame:Show(icon)
                end
            
                -- blood_of_the_enemy,if=variable.blade_flurry_sync&cooldown.between_the_eyes.up&variable.bte_condition
                if A.BloodoftheEnemy:AutoHeartOfAzerothP(unit) and not BloodoftheEnemySyncAoE and Action.GetToggle(1, "HeartOfAzeroth") and A.BetweentheEyes:GetCooldown() == 0 and RtB_Buffs > 0 then
                    return A.BloodoftheEnemy:Show(icon)
                end
            
                -- guardian_of_azeroth
                if A.GuardianofAzeroth:AutoHeartOfAzerothP(unit) and A.BurstIsON(unit) and Action.GetToggle(1, "HeartOfAzeroth") then
                    return A.GuardianofAzeroth:Show(icon)
                end
            
                -- focused_azerite_beam,if=spell_targets.blade_flurry>=2|raid_event.adds.in>60&!buff.adrenaline_rush.up
                if A.FocusedAzeriteBeam:AutoHeartOfAzerothP(unit) and A.BurstIsON(unit) 
                and Action.GetToggle(1, "HeartOfAzeroth") 
                and ((GetByRange(2, 10) or Unit(unit):IsBoss()) and Unit("player"):HasBuffs(A.AdrenalineRush.ID, true) == 0) then
                    return A.FocusedAzeriteBeam:Show(icon)
                end
            
                -- purifying_blast,if=spell_targets.blade_flurry>=2|raid_event.adds.in>60
                if A.PurifyingBlast:AutoHeartOfAzerothP(unit) and A.BurstIsON(unit) and Action.GetToggle(1, "HeartOfAzeroth") and GetByRange(2, 10) >= 2 then
                    return A.PurifyingBlast:Show(icon)
                end
            
                -- the_unbound_force,if=buff.reckless_force.up|buff.reckless_force_counter.stack<10
                if A.TheUnboundForce:AutoHeartOfAzerothP(unit) and Action.GetToggle(1, "HeartOfAzeroth") and (Unit("player"):HasBuffs(A.RecklessForceBuff.ID, true) > 0 or Unit("player"):HasBuffsStacks(A.RecklessForceCounter.ID, true) < 10) then
                    return A.TheUnboundForce:Show(icon)
                end
            
                -- ripple_in_space
                if A.RippleinSpace:AutoHeartOfAzerothP(unit) and Action.GetToggle(1, "HeartOfAzeroth") then
                    return A.RippleinSpace:Show(icon)
                end
            
                -- worldvein_resonance
                if A.WorldveinResonance:AutoHeartOfAzerothP(unit) and Action.GetToggle(1, "HeartOfAzeroth") then
                    return A.WorldveinResonance:Show(icon)
                end
            
                -- memory_of_lucid_dreams,if=energy<45
                if A.MemoryofLucidDreams:AutoHeartOfAzerothP(unit) and A.BurstIsON(unit) and Action.GetToggle(1, "HeartOfAzeroth") and (Player:EnergyPredicted() < 45) then
                    return A.MemoryofLucidDreams:Show(icon)
                end
            
                -- reaping_flames,if=target.health.pct>80|target.health.pct<=20|target.time_to_pct_20>30
                if A.ReapingFlames:IsReady(unit) and (Unit(unit):HealthPercent() > 80 or Unit(unit):HealthPercent() <= 20 or Unit(unit):TimeToDieX(20) > 30) then
                    return A.ReapingFlames:Show(icon)
                end
            
                -- reaping_flames
                --  if A.ReapingFlames:AutoHeartOfAzerothP(unit) and Action.GetToggle(1, "HeartOfAzeroth") then
                --      return A.ReapingFlames:Show(icon)
                --  end
            
                -- moment_of_glory
                if A.MomentofGlory:AutoHeartOfAzerothP(unit) and Action.GetToggle(1, "HeartOfAzeroth") then
                    return A.MomentofGlory:Show(icon)
                end
            
                -- ReplicaofKnowledge
                if A.ReplicaofKnowledge:AutoHeartOfAzerothP(unit) and Action.GetToggle(1, "HeartOfAzeroth") then
                    return A.ReplicaofKnowledge:Show(icon)
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

		    	-- use_item,effect_name=gladiators_medallion,if=debuff.vendetta.up
                if A.CorruptedGladiatorsMedallion:IsReady("player") and 
			    (
			        Unit(unit):HasDeBuffs(A.Vendetta.ID, true) > 0 and 
				    (
					    Unit(unit):TimeToDie() < 30 
					    or 
					    A.IsInPvP and Unit(unit):TimeToDie() < 5
				    )
			    )
			    then
                    return A.CorruptedGladiatorsMedallion:Show(icon)
                end 
			
                -- use_item,effect_name=cyclotronic_blast,if=!stealthed.all&buff.adrenaline_rush.down&buff.memory_of_lucid_dreams.down&energy.time_to_max>4&rtb_buffs<5
                if A.CyclotronicBlast:IsReady(unit) and (not Player:IsStealthed() and Unit("player"):HasBuffs(A.AdrenalineRush.ID, true) == 0 and Unit("player"):HasBuffsDown(A.MemoryofLucidDreamsBuff.ID, true) == 0 and Player:EnergyTimeToMaxPredicted() > 4 and RtB_Buffs < 5) then
                    return A.CyclotronicBlast:Show(icon)
                end
			
                -- use_item,name=azsharas_font_of_power,if=!buff.adrenaline_rush.up&!buff.blade_flurry.up&cooldown.adrenaline_rush.remains<15
                if A.AzsharasFontofPower:IsReady("player") and 
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

            -- run_action_list,name=finish,if=combo_points>=cp_max_spend-(buff.broadside.up+buff.opportunity.up)*(talent.quick_draw.enabled&(!talent.marked_for_death.enabled|cooldown.marked_for_death.remains>1))*(azerite.ace_up_your_sleeve.rank<2|!cooldown.between_the_eyes.up|!buff.roll_the_bones.up)
            if (Player:ComboPoints() >= CPMaxSpend() - (num(Unit("player"):HasBuffs(A.Broadside.ID, true) > 0) + num(Unit("player"):HasBuffs(A.Opportunity.ID, true) > 0)) * num((A.QuickDraw:IsSpellLearned() and 
			(not A.MarkedforDeath:IsSpellLearned() or A.MarkedforDeath:GetCooldown() > 1))) * num((A.AceUpYourSleeve:GetAzeriteRank() < 2 or A.BetweentheEyes:GetCooldown() > 0 or RtB_Buffs < 1))) 
			then

				--print(RtB_CurrentBuffsRemains)
                -- roll_the_bones,if=buff.roll_the_bones.remains<=3|variable.rtb_reroll
                if A.RolltheBones:IsReady("player") and 
				(
				    RtB_CurrentBuffsRemains <= 3 
					or
					RtB_Reroll
				)
				then
                    return A.RolltheBones:Show(icon)
                end

                -- actions.finish+=/dispatch,if,between_the_eyes.cooldown
                if A.Dispatch:IsReady(unit) and A.BetweentheEyes:GetCooldown() > A.GetGCD() then
                    return A.Dispatch:Show(icon)
                end
                
				-- Cast Between the Eyes before rerolling with Broadside or RP if you have 1 or more Ace or Deadshot trait.				
                if A.BetweentheEyes:IsReady(unit) and Unit(unit):HasDeBuffs(A.Blind.ID, true) == 0 and
				(
				    Unit("player"):HasBuffs(A.RuthlessPrecision.ID, true) > 0
					or 
                    Unit("player"):HasBuffs(A.Broadside.ID, true) > 0 and 
					(
					    A.AceUpYourSleeve:GetAzeriteRank() >= 1 
						or 
						A.Deadshot:GetAzeriteRank() >= 1
					)
					or A.AceUpYourSleeve:GetAzeriteRank() >= 2 
					or A.Deadshot:GetAzeriteRank() >= 2 
					or A.AceUpYourSleeve:GetAzeriteRank() >= 1 and A.Deadshot:GetAzeriteRank() >= 1
				)
				and RtB_Buffs >= 1 and Unit("player"):HasBuffs(A.DeadshotBuff.ID, true) == 0 
			    then
                    return A.BetweentheEyes:Show(icon)
                end

                -- actions.finish=slice_and_dice,if=buff.slice_and_dice.remains<target.time_to_die&buff.slice_and_dice.remains<(1+combo_points)*1.8
                -- Note: Added Player:BuffRemainsP(A.SliceandDice) == 0 to maintain the buff while TTD is invalid (it's mainly for Solo, not an issue in raids)
                if A.SliceandDice:IsSpellLearned() and A.SliceandDice:IsReady(unit)
                        and (Target:FilteredTimeToDie(">", Player:BuffRemainsP(A.SliceandDice)) or Player:BuffRemainsP(A.SliceandDice) == 0)
                        and Player:BuffRemainsP(A.SliceandDice) < (1 + Player:ComboPoints()) * 1.8 then
                    return A.SliceandDice:Show(icon)
                end
				
                -- slice_and_dice,if=buff.slice_and_dice.remains<target.time_to_die&buff.slice_and_dice.remains<(1+combo_points)*1.8
                if A.SliceandDice:IsReady("player") and CanCast and 
				(
				    (
					    Unit("player"):HasBuffs(A.SliceandDice.ID, true) < Unit(unit):TimeToDie() 
						or 
						Unit("player"):HasBuffs(A.SliceandDice.ID, true) == 0 
					)
					and Unit("player"):HasBuffs(A.SliceandDice.ID, true) < (1 + Player:ComboPoints()) * 1.8
				)
				then
                    return A.SliceandDice:Show(icon)
                end
					
                -- # BTE worth being used with the boosted crit chance from Ruthless Precision
                -- actions.finish+=/between_the_eyes,if=buff.ruthless_precision.up|azerite.ace_up_your_sleeve.enabled|azerite.deadshot.enabled
                if A.BetweentheEyes:IsReady(unit) and Unit(unit):HasDeBuffs(A.Blind.ID, true) == 0 and 
				(
				    A.AceUpYourSleeve:GetAzeriteRank() >= 1 
					or 
					A.Deadshot:GetAzeriteRank() >= 1
				)
				and Unit("player"):HasBuffs(A.DeadshotBuff.ID, true) > 0 
				then
                    return A.BetweentheEyes:Show(icon)
                end

                -- # BTE AoE
                -- actions.finish+=/between_the_eyes,if=buff.ruthless_precision.up|azerite.ace_up_your_sleeve.enabled|azerite.deadshot.enabled
                if A.BetweentheEyes:IsReady(unit) and Unit("player"):HasBuffs(A.BloodoftheEnemy.ID, true) > 0 and 
				(
				    GetByRange(A.GetToggle(2, "BladeFlurryTargets"), A.GetToggle(2, "BladeFlurryRange")) 
					or 
					Unit(unit):IsBoss()
				)				 
				then
                    return A.BetweentheEyes:Show(icon)
                end
		
                -- OutofRange BtE
                if A.BetweentheEyes:IsReady(unit) and Unit(unit):GetRange() <= 20 and Unit(unit):GetRange() > 11 and Unit("player"):HasBuffs(A.DeadshotBuff.ID, true) > 0 and Unit(unit):HealthPercent() < 100 then
                    return A.BetweentheEyes:Show(icon)
                end
            end
                        
            -- call_action_list,name=build
            if CanCast then
			
                -- pistol_shot,if=(talent.quick_draw.enabled|azerite.keep_your_wits_about_you.rank<2)&buff.opportunity.up&(buff.keep_your_wits_about_you.stack<14|energy<45)
                if A.PistolShot:IsReady(unit) and 
				(
				    (
					    A.QuickDraw:IsSpellLearned() 
						or 
						A.KeepYourWitsAboutYou:GetAzeriteRank() < 2
					)
					and Unit("player"):HasBuffs(A.Opportunity.ID, true) > 0 and 
					(
					    Unit("player"):HasBuffsStacks(A.KeepYourWitsAboutYouBuff.ID, true) < 14 
						or 
						Player:EnergyPredicted() < 45
					)
				)
    			then
                    return A.PistolShot:Show(icon)
                end
            
                -- pistol_shot,if=buff.opportunity.up&buff.deadshot.up
                if A.PistolShot:IsReady(unit) and Unit("player"):HasBuffs(A.Opportunity.ID, true) > 0 --and Unit("player"):HasBuffs(A.DeadshotBuff.ID, true) > 0 
				then
                    return A.PistolShot:Show(icon)
                end
            
                -- actions.build=pistol_shot,if=combo_points.deficit>=1+buff.broadside.up+talent.quick_draw.enabled&buff.opportunity.up
                if A.PistolShot:IsReady(unit) and Unit(unit):GetRange() <= 20 and 
				Unit(unit):HasDeBuffs(A.Blind.ID, true) == 0 and 
				Player:ComboPointsDeficit() >= (1 + (Unit("player"):HasBuffs(A.Broadside.ID, true) > 0 and 1 or 0) + (A.QuickDraw:IsSpellLearned() and 1 or 0)) and 
				Unit("player"):HasBuffs(A.Opportunity.ID, true) > 0 
				then
                    return A.PistolShot:Show(icon)
                end
				
                -- actions.build+=/sinister_strike
                if A.SinisterStrike:IsReady(unit) then
                    return A.SinisterStrike:Show(icon)
                end
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

            -- OutofRange Pistol Shot
            if Unit(unit):GetRange() > 10 and Unit(unit):HasDeBuffs(A.Blind.ID, true) == 0 and A.PistolShot:IsReady(unit) and Unit(unit):GetRange() <= 20 and not Player:IsStealthed() and Unit("player"):HasBuffs(A.VanishBuff.ID, true) == 0 and Unit(unit):HealthPercent() < 100
            and Player:EnergyDeficitPredicted() < 25 and 
			(
			    Player:ComboPointsDeficit() >= 1 
				or 
				EnergyTimeToMaxRounded() <= 1.2
				or 
				Unit("player"):HasBuffs(A.DeadshotBuff.ID, true) > 0
			) 
			then
                return A.PistolShot:Show(icon)
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
        if (unit == "arena1" or unit == "arena2" or unit == "arena3") then 
	
	        -- Interrupt
   		    local Interrupt = Interrupts(unit)
  		    if Interrupt then 
  		        return Interrupt:Show(icon)
  		    end	
			
            -- Blind
            if A.Blind:IsReady(unit) and EnemyTeam():IsCastingBreakAble(0.25) then 
                return A.Blind:Show(icon)
            end 
        end
    end 
end 
local function PartyRotation(unit)
    if (unit == "party1" and not A.GetToggle(2, "PartyUnits")[1]) or (unit == "party2" and not A.GetToggle(2, "PartyUnits")[2]) then 
        return false 
    end   
end 

A[6] = function(icon)
    return ArenaRotation(icon, "arena1")
end

A[7] = function(icon)
    --local Party = PartyRotation("party1") 
    --if Party then 
    --    return Party:Show(icon)
    --end 
    return ArenaRotation(icon, "arena2")
end

A[8] = function(icon)
    --local Party = PartyRotation("party2") 
    --if Party then 
    --    return Party:Show(icon)
    --end     
    return ArenaRotation(icon, "arena3")
end

