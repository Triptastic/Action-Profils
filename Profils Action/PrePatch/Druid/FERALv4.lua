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
local wipe                                      = wipe 
local math_floor                                = math.floor
local math_ceil                                 = math.ceil
local tinsert                                   = table.insert 
local TMW                                       = TMW
local _G, setmetatable                          = _G, setmetatable
local select, unpack, table, pairs              = select, unpack, table, pairs 
local CombatLogGetCurrentEventInfo              = _G.CombatLogGetCurrentEventInfo
local UnitGUID, UnitIsUnit, UnitDamage, UnitAttackSpeed, UnitAttackPower = UnitGUID, UnitIsUnit, UnitDamage, UnitAttackSpeed, UnitAttackPower

--- ============================ CONTENT ===========================
--- ======= APL LOCALS =======
-- luacheck: max_line_length 9999

Action[ACTION_CONST_DRUID_FERAL] = {
    -- Racial
    ArcaneTorrent                           = Create({ Type = "Spell", ID = 50613      }),
    BloodFury                               = Create({ Type = "Spell", ID = 20572       }),
    Fireblood                               = Create({ Type = "Spell", ID = 265221      }),
    AncestralCall                           = Create({ Type = "Spell", ID = 274738      }),
    Berserking                              = Create({ Type = "Spell", ID = 26297     }),
    ArcanePulse                             = Create({ Type = "Spell", ID = 260364     }),
    QuakingPalm                             = Create({ Type = "Spell", ID = 107079      }),
    Haymaker                                = Create({ Type = "Spell", ID = 287712      }), 
    WarStomp                                = Create({ Type = "Spell", ID = 20549      }),
    BullRush                                = Create({ Type = "Spell", ID = 255654      }),  
    GiftofNaaru                             = Create({ Type = "Spell", ID = 59544     }),
    Shadowmeld                              = Create({ Type = "Spell", ID = 58984     }), -- usable in Action Core 
    Stoneform                               = Create({ Type = "Spell", ID = 20594     }), 
    BagofTricks                             = Create({ Type = "Spell", ID = 312411     }),
    WilloftheForsaken                       = Create({ Type = "Spell", ID = 7744         }), -- not usable in APL but user can Queue it   
    EscapeArtist                            = Create({ Type = "Spell", ID = 20589     }), -- not usable in APL but user can Queue it
    EveryManforHimself                      = Create({ Type = "Spell", ID = 59752     }), -- not usable in APL but user can Queue it
    -- Generics
    Prowl                                   = Create({ Type = "Spell", ID = 5215     }),
    Berserk                                 = Create({ Type = "Spell", ID = 106951     }),
    Rake                                    = Create({ Type = "Spell", ID = 1822     }),
    ThrashCat                               = Create({ Type = "Spell", ID = 106830     }),
    SwipeCat                                = Create({ Type = "Spell", ID = 106785     }),
    MoonfireCat                             = Create({ Type = "Spell", ID = 155625     }),
    Shred                                   = Create({ Type = "Spell", ID = 5221     }),
    Rip                                     = Create({ Type = "Spell", ID = 1079     }),
    TigersFury                              = Create({ Type = "Spell", ID = 5217     }),
    FerociousBiteMaxEnergy                  = Create({ Type = "Spell", ID = 22568, Hidden = true    }), -- Used to check special conditions on FerociousBite
    FerociousBite                           = Create({ Type = "Spell", ID = 22568    }),
    Maim                                    = Create({ Type = "Spell", ID = 22570     }),  
    Incarnation                             = Create({ Type = "Spell", ID = 102543 }),	
    SavageRoar                              = Create({ Type = "Spell", ID = 52610 }),
	WildFleshrending						= Create({ Type = "Spell", ID = 279527, Hidden = true     }),
    -- Shapeshift
    TravelForm                              = Create({ Type = "Spell", ID = 783      }), 
    BearForm                                = Create({ Type = "Spell", ID = 5487      }), 
    CatForm                                 = Create({ Type = "Spell", ID = 768      }), 
	CatFormBuff                             = Create({ Type = "Spell", ID = 768, Hidden = true     }),
    AquaticForm                             = Create({ Type = "Spell", ID = 276012      }), 
    -- Balance Affinity
    Moonfire                                = Create({ Type = "Spell", ID = 8921      }), 
	MoonfireDebuff                          = Create({ Type = "Spell", ID = 164812, Hidden = true     }),
	Sunfire                                 = Create({ Type = "Spell", ID = 197630      }), 
	SunfireDebuff                           = Create({ Type = "Spell", ID = 164815, Hidden = true     }),
	SolarWrath                              = Create({ Type = "Spell", ID = 197629      }), 
	LunarStrike                             = Create({ Type = "Spell", ID = 197628      }), 
	Starsurge                               = Create({ Type = "Spell", ID = 197626      }), 
	LunarEmpowermentBuff                    = Create({ Type = "Spell", ID = 164547, Hidden = true     }),
	SolarEmpowermentBuff                    = Create({ Type = "Spell", ID = 164545, Hidden = true     }),
    -- Utilities
    EntanglingRoots                         = Create({ Type = "Spell", ID = 339     }),
    SkullBash                               = Create({ Type = "Spell", ID = 106839     }),
    MightyBashGreen                         = Create({ Type = "SpellSingleColor", ID = 5211, Color = "GREEN", Desc = "[1] CC Focus", isTalent = true     }), 
    AntiFakeCCFocusCyclone                  = Create({ Type = "Spell", ID = 33786, }), 
    SkullBashGreen                          = Create({ Type = "SpellSingleColor", ID = 106839, Color = "GREEN", Desc = "[2] Kick", QueueForbidden = true     }),
    UrsolVortex                             = Create({ Type = "Spell", ID = 102793      }),
    NaturesCure                             = Create({ Type = "Spell", ID = 88423      }),  
    Dash                                    = Create({ Type = "Spell", ID = 1850      }), 
    Rebirth                                 = Create({ Type = "Spell", ID = 20484      }),  -- Combat Rez
    Revive                                  = Create({ Type = "Spell", ID = 50769      }), 
    Hibernate                               = Create({ Type = "Spell", ID = 2637      }), 
    Revitalize                              = Create({ Type = "Spell", ID = 212040      }), 
    Regrowth                                = Create({ Type = "Spell", ID = 8936     }),
    Soothe                                  = Create({ Type = "Spell", ID = 2908     }),
    RemoveCorruption                        = Create({ Type = "Spell", ID = 2782     }),
    SurvivalInstincts                       = Create({ Type = "Spell", ID = 61336     }),
	StampedingRoar                          = Create({ Type = "Spell", ID = 106898     }),
	WildChargeCat							= Create({ Type = "Spell", ID = 49376, Hidden = true     }),    -- Charge + 3sec Stun
	--WildChargeTravel                        = Create({ Type = "Spell", ID = 49376, Hidden = true     }),   
	WildChargeBear                          = Create({ Type = "Spell", ID = 16979, Hidden = true     }),	-- Charge + 4sec Stun	
    -- Buffs
    PredatorySwiftnessBuff                  = Create({ Type = "Spell", ID = 69369, Hidden = true     }),
    BloodtalonsBuff                         = Create({ Type = "Spell", ID = 145152, Hidden = true     }),
    ScentofBloodBuff                        = Create({ Type = "Spell", ID = 285646, Hidden = true     }),
    TigersFuryBuff                          = Create({ Type = "Spell", ID = 5217, Hidden = true     }),
    IncarnationBuff                         = Create({ Type = "Spell", ID = 102543, Hidden = true     }),
    BerserkBuff                             = Create({ Type = "Spell", ID = 106951, Hidden = true     }),
    ClearcastingBuff                        = Create({ Type = "Spell", ID = 135700, Hidden = true     }),
    ProwlBuff                               = Create({ Type = "Spell", ID = 5215, Hidden = true     }),
	ShadowmeldBuff                          = Create({ Type = "Spell", ID = 58984 , Hidden = true     }),
	SavageRoarBuff                          = Create({ Type = "Spell", ID = 52610 , Hidden = true     }),
	IronJawsBuff                            = Create({ Type = "Spell", ID = 276026, Hidden = true     }),
    -- Debuffs
    RakeDebuff                              = Create({ Type = "Spell", ID = 155722, Hidden = true     }), -- Duration Base//Max [155722] = {15000, 19500},
    ThrashCatDebuff                         = Create({ Type = "Spell", ID = 106830, Hidden = true     }),
    MoonfireCatDebuff                       = Create({ Type = "Spell", ID = 155625, Hidden = true     }),
    RipDebuff                               = Create({ Type = "Spell", ID = 1079, Hidden = true     }), -- Duration Base//Max [1079] = {4000, 5200},
    ConcentratedFlameDebuff                 = Create({ Type = "Spell", ID = 295368, Hidden = true     }),
    AshvanesRazorCoralDebuff                = Create({ Type = "Spell", ID = 303568, Hidden = true     }),
    ConductiveInkDebuff                     = Create({ Type = "Spell", ID = 302565, Hidden = true     }),
    BloodoftheEnemyDebuff                   = Create({ Type = "Spell", ID = 297108, Hidden = true     }),
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
    AzurethosSingedPlumage                = Action.Create({ Type = "Trinket", ID = 161377 }),
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
    --Talents
	MassEntanglement                        = Create({ Type = "Spell", ID = 102359, isTalent = true, Hidden = true     }),
    Predator                                = Create({ Type = "Spell", ID = 202021, isTalent = true, Hidden = true     }),
    Sabertooth                              = Create({ Type = "Spell", ID = 202031, isTalent = true, Hidden = true     }),
    LunarInspiration                        = Create({ Type = "Spell", ID = 155580, isTalent = true, Hidden = true     }),
    WildCharge                              = Create({ Type = "Spell", ID = 102401, isTalent = true, Hidden = true     }),
    BalanceAffinity                         = Create({ Type = "Spell", ID = 197488, isTalent = true, Hidden = true     }),
    MightyBash                              = Create({ Type = "Spell", ID = 5211, isTalent = true, Hidden = true     }),
    Typhoon                                 = Create({ Type = "Spell", ID = 132469, isTalent = true, Hidden = true     }),
    ScentofBlood                            = Create({ Type = "Spell", ID = 285564, isTalent = true, Hidden = true     }),
    BrutalSlash                             = Create({ Type = "Spell", ID = 202028, isTalent = true, Hidden = true     }),
    PrimalWrath                             = Create({ Type = "Spell", ID = 285381, isTalent = true, Hidden = true     }),
    Bloodtalons                             = Create({ Type = "Spell", ID = 155672, isTalent = true, Hidden = true     }),
    FeralFrenzy                             = Create({ Type = "Spell", ID = 274837, isTalent = true, Hidden = true     }),
    Thorns                                  = Create({ Type = "Spell", ID = 236696, isTalent = true, Hidden = true     }), -- PvP
    -- Misc
    Channeling                             = Action.Create({ Type = "Spell", ID = 209274, Hidden = true     }),	-- Show an icon during channeling
    TargetEnemy                            = Action.Create({ Type = "Spell", ID = 44603, Hidden = true     }),	-- Change Target (Tab button)
    StopCast                               = Action.Create({ Type = "Spell", ID = 61721, Hidden = true     }),		-- spell_magic_polymorphrabbit
    CyclotronicBlast                       = Action.Create({ Type = "Spell", ID = 293491, Hidden = true}),
    ConcentratedFlameBurn                  = Action.Create({ Type = "Spell", ID = 295368, Hidden = true}),
    RazorCoralDebuff                       = Action.Create({ Type = "Spell", ID = 303568, Hidden = true     }),
    ConductiveInkDebuff                    = Action.Create({ Type = "Spell", ID = 302565, Hidden = true     }),
    PoolResource                           = Action.Create({ Type = "Spell", ID = 209274, Hidden = true     }),
    DummyTest                              = Action.Create({ Type = "Spell", ID = 159999, Hidden = true     }), -- Dummy stop dps icon   
    GrandDelusionsDebuff                   = Action.Create({ Type = "Spell", ID = 319695, Hidden = true     }), -- Corruption pet chasing you	
}

-- To create essences use next code:
Action:CreateEssencesFor(ACTION_CONST_DRUID_FERAL)  -- where PLAYERSPEC is Constance (example: ACTION_CONST_MONK_BM)
local A = setmetatable(Action[ACTION_CONST_DRUID_FERAL], { __index = Action })

------------------------------------------
---------------- VARIABLES ---------------
------------------------------------------
local VarUseThrash = 0
local VarReapingDelay = 0
local VarOpenerDone = 0
local LastRakeAP = 0

A.Listener:Add("ROTATION_VARS", "PLAYER_REGEN_ENABLED", function()
  VarUseThrash = 0
  VarReapingDelay = 0
  VarOpenerDone = 0
  LastRakeAP = 0
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
local player = "player"

local function IsSchoolFree()
    return LoC:IsMissed("SILENCE") and LoC:Get("SCHOOL_INTERRUPT", "NATURE") == 0
end 

local function InMelee(unit)
    -- @return boolean 
    return A.Rake:IsInRange(unit)
end 

local function GetByRange(count, range, isCheckEqual, isCheckCombat)
    -- @return boolean 
    local c = 0 
    for unit in pairs(ActiveUnitPlates) do 
        if (not isCheckEqual or not UnitIsUnit(target, unit)) and (not isCheckCombat or Unit(unit):CombatTime() > 0) then 
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

-- Return the lowest Unit TTD value
-- Used as snipping function 
local function LowestTTD()
    local lowTTD = 0
    for activeunits in pairs(ActiveUnitPlates) do
        if (lowTTD == 0 or Unit(activeunits):TimeToDie() < lowTTD) then
            lowTTD = Unit(activeunits):TimeToDie()
        end
    end
    return lowTTD
end

local function SwipeBleedMult()
    return (Unit(unit):HasDeBuffs(A.RipDebuff.ID, true) > 0 or Unit(unit):HasDeBuffs(A.RakeDebuff.ID, true) > 0 or Unit(unit):HasDeBuffs(A.ThrashCatDebuff.ID, true) > 0) and 1.2 or 1
end

local function RakeBleedTick()
    return LastRakeAP * 0.15561 * (1 + Player:VersatilityDmgPct() / 100)
end

-- [1] CC AntiFake Rotation
local function AntiFakeStun(unit) 
    return A.IsUnitEnemy(unit)    
end 
A[1] = function(icon)    

	-- Cyclone
    if     A.AntiFakeCCFocusCyclone:IsReady(nil, nil, nil, true) and Unit("target"):GetRange() <= 20 and 
    (
        AntiFakeStun("mouseover") 
		or 
        AntiFakeStun("target") 
    )
    then 
        return A.AntiFakeCCFocusCyclone:Show(icon)         
    end 
	
	-- MightyBash
    if     A.MightyBashGreen:IsReady(nil, nil, nil, true) and Unit("target"):GetRange() <= 8 and 
    (
        AntiFakeStun("mouseover") 
		or 
        AntiFakeStun("target") 
    )
    then 
        return A.MightyBashGreen:Show(icon)         
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
            if not notKickAble and A.SkullBashGreen:IsReady(unit, nil, nil, true) and A.SkullBashGreen:AbsentImun(unit, Temp.TotalAndMag, true) then
                return A.SkullBashGreen:Show(icon)                                                  
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
    
    -- SurvivalInstincts
    local SurvivalInstincts = A.GetToggle(2, "SurvivalInstincts")
    if     SurvivalInstincts >= 0 and A.SurvivalInstincts:IsReady("player", nil, nil, true) and
    (
        (     -- Auto 
            SurvivalInstincts >= 100 and 
            (
                Unit(player):HealthPercent() <= 50 or
                (                        
                    Unit(player):HealthPercent() < 70 
                )
            )
        ) 
        or 
        (    -- Custom
            SurvivalInstincts < 100 and 
            Unit(player):HealthPercent() <= SurvivalInstincts
        )
    ) 
    then 
        return A.SurvivalInstincts
    end 
 
    -- Bear Form
 --[[   local BearForm = A.GetToggle(2, "BearForm")
    if     BearForm >= 0 and not IsInBearForm and A.BearForm:IsReady("player") and
    (
        (     -- Auto 
            BearForm >= 100 and Unit(player):HealthPercent() < 20 and
            (
			    EnemyTeam():IsReshiftAble() 
				or 
				(Unit(player):HasDeBuffs(78675) > 0 and Unit(player):HasDeBuffs("Rooted") > 0)
			)
        ) 
        or 
        (    -- Custom
            BearForm < 100 and 
            Unit(player):HealthPercent() <= BearForm
        )
    ) 
    then 
        return A.BearForm
    end
 ]]--
    -- Stoneform on self dispel (only PvE)
    if A.Stoneform:IsRacialReady(player, true) and not A.IsInPvP and A.AuraIsValid(player, "UseDispel", "Dispel") then 
        return A.Stoneform
    end 
end 
SelfDefensives = A.MakeFunctionCachedStatic(SelfDefensives)

-- Non GCD spell check
local function countInterruptGCD(unit)
    if not A.SkullBash:IsReadyByPassCastGCD(unit) or not A.SkullBash:AbsentImun(unit, Temp.TotalAndMagKick) then
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
        if useKick and A.SkullBash:IsReady(unit) and A.SkullBash:AbsentImun(unit, Temp.TotalAndPhysKick, true) then 
            -- Notification                    
            Action.SendNotification("Skull Bash interrupting on " .. unit, A.SkullBash.ID)
            return A.SkullBash
        end         

        if useCC and A.MightyBash:IsReady(unit) and A.MightyBash:IsSpellLearned() and A.MightyBash:AbsentImun(unit, Temp.TotalAndPhysKick, true) then 
            -- Notification                    
            Action.SendNotification("Mighty Bash interrupting on " .. unit, A.MightyBash.ID)
            return A.MightyBash
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

-- Stealth Handler UI --
local function HandleStealth()
    local choice = GetToggle(2, "AutoStealthOOC")
    local unit = "target"
    return     (
        (IsInRaid() and choice[1]) or 
        (IsInGroup() and choice[2]) or
        (A.IsInPvP and choice[3]) or
		(A.Prowl:IsReady() and choice[4])
    )
end

A.FerociousBiteMaxEnergy.CustomCost = {
    [3] = function ()
        if (Unit(player):HasBuffs(A.IncarnationBuff.ID, true) > 0 or Unit(player):HasBuffs(A.BerserkBuff.ID, true) > 0) then 
		    return 25
        else 
		    return 50
        end
    end
}

--[[
local function EvaluateCycleReapingFlames106(unit)
    return Unit(unit):TimeToDie() < 1.5 or ((Unit(unit):HealthPercent() > 80 or Unit(unit):HealthPercent() <= 20) and VarReapingDelay > 29) or (target.time_to_pct_20 > 30 and VarReapingDelay > 44)
end

local function EvaluateCyclePrimalWrath192(unit)
    return MultiUnits:GetByRangeInCombat(5, 5, 10) > 1 and Unit(unit):HasDeBuffs(A.RipDebuff.ID, true) < 4
end

local function EvaluateCyclePrimalWrath203(unit)
    return MultiUnits:GetByRangeInCombat(5, 5, 10) >= 2
end

local function EvaluateCycleRip212(unit)
    return not Unit(unit):HasDeBuffs(A.RipDebuff.ID, true) or (Unit(unit):HasDeBuffs(A.RipDebuff.ID, true) <= A.RipDebuff:BaseDuration() * 0.3) and (not A.Sabertooth:IsSpellLearned()) or (Unit(unit):HasDeBuffs(A.RipDebuff.ID, true) <= A.RipDebuff:BaseDuration() * 0.8 and A.Persistent_PMultiplier(A.Rip.ID) > A.PMultiplier(unit, A.Rip.ID)) and Unit(unit):TimeToDie() > 8
end

local function EvaluateTargetIfFilterFerociousBite271(unit)
  return max:druid.rip.ticks_gained_on_refresh
end

local function EvaluateCycleRake349(unit)
    return not Unit(unit):HasDeBuffs(A.RakeDebuff.ID, true) or (not A.Bloodtalons:IsSpellLearned() and Unit(unit):HasDeBuffs(A.RakeDebuff.ID, true) < A.RakeDebuff:BaseDuration() * 0.3) and Unit(unit):TimeToDie() > 4
end

local function EvaluateCycleRake378(unit)
    return A.Bloodtalons:IsSpellLearned() and Unit(player):HasBuffs(A.BloodtalonsBuff.ID, true) and ((Unit(unit):HasDeBuffs(A.RakeDebuff.ID, true) <= 7) and A.Persistent_PMultiplier(A.Rake.ID) > A.PMultiplier(unit, A.Rake.ID) * 0.85) and Unit(unit):TimeToDie() > 4
end

local function EvaluateCycleMoonfireCat437(unit)
    return Unit(unit):HasDeBuffsRefreshable(A.MoonfireCatDebuff.ID, true)
end

local function EvaluateCycleFerociousBite559(unit)
    return Unit(unit):HasDeBuffs(A.RipDebuff.ID, true) and Unit(unit):HasDeBuffs(A.RipDebuff.ID, true) < 3 and Unit(unit):TimeToDie() > 10 and (A.Sabertooth:IsSpellLearned())
end
]]--

local function BalanceAffinity(unit)
	
	-- Sunfire
	if A.Sunfire:IsReady(unit) and Unit(unit):HasDeBuffs(A.SunfireDebuff.ID, true) < 4 then
        return A.Sunfire	
	end
		
	-- Moonfire	
	if A.Moonfire:IsReady(unit) and Unit(unit):HasDeBuffs(A.MoonfireDebuff.ID, true) < 4 then
        return A.Moonfire	
	end
		
	-- Solar Wrath
	if A.SolarWrath:IsReady(unit) and Unit(unit):HasDeBuffs(A.SunfireDebuff.ID, true) > 3 and Unit(unit):HasDeBuffs(A.MoonfireDebuff.ID, true) > 3 and 
    Unit(player):HasBuffs(A.SolarEmpowermentBuff.ID, true) > 0
	then
        return A.SolarWrath	
	end
		
	-- Lunar Strike
	if A.LunarStrike:IsReady(unit) and Unit(unit):HasDeBuffs(A.SunfireDebuff.ID, true) > 3 and Unit(unit):HasDeBuffs(A.MoonfireDebuff.ID, true) > 3 and
	Unit(player):HasBuffs(A.LunarEmpowermentBuff.ID, true) > 0
	then
        return A.LunarStrike
	end
		
	-- Starsurge
	if A.Starsurge:IsReady(unit) and (Unit(player):HasBuffs(A.LunarEmpowermentBuff.ID, true) == 0 or Unit(player):HasBuffs(A.SolarEmpowermentBuff.ID, true) == 0) then
        return A.Starsurge	
	end	
	
	-- Solar Wrath
	if A.SolarWrath:IsReady(unit) and Unit(unit):HasDeBuffs(A.SunfireDebuff.ID, true) > 3 and Unit(unit):HasDeBuffs(A.MoonfireDebuff.ID, true) > 3 and 
    Unit(player):HasBuffs(A.SolarEmpowermentBuff.ID, true) == 0 and Unit(player):HasBuffs(A.LunarEmpowermentBuff.ID, true) == 0 and A.Starsurge:GetCooldown() > 0
	then
        return A.SolarWrath	
	end

end

local function IsInHumanForm()
    return Player:GetStance() == 0
end

local function IsInBearForm()
    return Player:GetStance() == 1
end

local function IsInCatForm()
    return Player:GetStance() == 2
end

local function IsInTravelForm()
    return Player:GetStance() == 3
end

local function IsInMoonkinForm()
    return Player:GetStance() == 4
end
    

-- [3] Single Rotation
A[3] = function(icon)
    --------------------
    --- ROTATION VAR ---
    --------------------
    local isMoving = A.Player:IsMoving()
	local isMovingFor = A.Player:IsMovingTime()
    local inCombat = Unit(player):CombatTime() > 0
    local combatTime = Unit(player):CombatTime()
    local ShouldStop = Action.ShouldStop()
    local Pull = Action.BossMods:GetPullTimer()
    local profileStop = false
    local Energy = Player:Energy()
    local EnergyRegen = Player:EnergyRegen()
    local EnergyPredicted = Player:EnergyPredicted()
    local EnergyDeficitPredicted = Player:EnergyDeficitPredicted()
    local DBM = Action.GetToggle(1, "BossMods")
    local HeartOfAzeroth = Action.GetToggle(1, "HeartOfAzeroth")
    local Racial = Action.GetToggle(1, "Racial")
    local Potion = Action.GetToggle(1, "Potion") 
    
    
    local IsInBearForm = IsInBearForm()
	local IsInCatForm = IsInCatForm()
	local IsInTravelForm = IsInTravelForm()
	local IsInMoonkinForm = IsInMoonkinForm()
	local IsInHumanForm = IsInHumanForm()
	local MassEntanglementThingFromBeyond = GetToggle(2, "MassEntanglementThingFromBeyond")
    local AoEMode = A.GetToggle(2, "AoEMode")        
    local BloodoftheEnemySyncAoE = Action.GetToggle(2, "BloodoftheEnemySyncAoE")
    local BloodoftheEnemyAoETTD = Action.GetToggle(2, "BloodoftheEnemyAoETTD")
    local BloodoftheEnemyUnits = Action.GetToggle(2, "BloodoftheEnemyUnits")
    local FocusedAzeriteBeamTTD = GetToggle(2, "FocusedAzeriteBeamTTD")
    local FocusedAzeriteBeamUnits = GetToggle(2, "FocusedAzeriteBeamUnits")
    local UnbridledFuryAuto = GetToggle(2, "UnbridledFuryAuto")
    local UnbridledFuryTTD = GetToggle(2, "UnbridledFuryTTD")
    local UnbridledFuryWithBloodlust = GetToggle(2, "UnbridledFuryWithBloodlust")
    local UnbridledFuryHP = GetToggle(2, "UnbridledFuryHP")
    local UnbridledFuryWithExecute = GetToggle(2, "UnbridledFuryWithExecute")
	local MoonfireOnlyOutOfRange = GetToggle(2, "MoonfireOnlyOutOfRange")
	local RootThingFromBeyond = GetToggle(2, "RootThingFromBeyond")
	local HandleStealth = HandleStealth()
	local OpenerRange = GetToggle(2, "OpenerRange")
	local UseWildChargeBear = GetToggle(2, "UseWildChargeBear")
	local UseWildChargeCat = GetToggle(2, "UseWildChargeCat")
	local AutoCatForm = GetToggle(2, "AutoCatForm")
    -- Trinkets vars
    local Trinket1IsAllowed, Trinket2IsAllowed = TR:TrinketIsAllowed()
    local TrinketsAoE = GetToggle(2, "TrinketsAoE")
	--local TrinketASAP = GetToggle(2, "TrinketASAP")
    local TrinketsMinTTD = GetToggle(2, "TrinketsMinTTD")
    local TrinketsUnitsRange = GetToggle(2, "TrinketsUnitsRange")
    local TrinketsMinUnits = GetToggle(2, "TrinketsMinUnits")    
    -- Azerite beam protection channel
    local CanCast = true
    local TotalCast, CurrentCastLeft, CurrentCastDone = Unit(player):CastTime()
    local _, castStartedTime, castEndTime = Unit(player):IsCasting()
    local secondsLeft, percentLeft, spellID, spellName, notInterruptable, isChannel = Unit(player):IsCastingRemains()
    -- Ensure all channel and cast are really safe
    -- Double protection with check on current casts and also timestamp of the cast
    if (spellID == A.FocusedAzeriteBeam.ID) then 
        if (CurrentCastLeft > 0 or secondsLeft > 0 or isChannel) then
            if TMW.time < castEndTime then            
                CanCast = false
            else
                CanCast = true
            end
        end
    end
    -- Showing icon PoolResource to make sure nothing else is read by GG
    if not CanCast then
        return A.PoolResource:Show(icon)
    end
	
--print("Rip:" .. A.RipDebuff:BaseDuration())
--print("Rake:" .. A.RakeDebuff:BaseDuration())
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

    -- prowl
    if A.Prowl:IsReady(player) and not inCombat and Unit(player):HasBuffs(A.Prowl.ID, true) == 0 and not Player:IsMounted() and not Player:IsStealthed() and HandleStealth then
        return A.Prowl:Show(icon)
    end
		
    -- cat_form,if=!buff.cat_form.up
    if A.CatForm:IsReady() and A.LastPlayerCastName ~= A.Prowl:Info() and not Player:IsMounted() and not Player:IsStealthed() and not IsInCatForm and AutoCatForm and 
    (
	    (not IsInMoonkinForm and A.BalanceAffinity:IsSpellLearned()) 
		or
		(not A.BalanceAffinity:IsSpellLearned() )
	)
	then
        return A.CatForm:Show(icon)
    end	

    ------------------------------------------------------
    ---------------- ENEMY UNIT ROTATION -----------------
    ------------------------------------------------------   
    local function EnemyRotation(unit)

		-- Rake update damage real time
		if A.LastPlayerCastName == A.Rake:Info() then
            LastRakeAP = Player:AttackPowerDamageMod()
        end 
				
		--Precombat
        if combatTime == 0 and not Unit(unit):IsDead() and IsInCatForm and Unit(unit):GetRange() <= OpenerRange and not Player:IsMounted() and not profileStop and Unit(unit):IsExists() and unit ~= "mouseover" then
            -- flask
            -- food
            -- augmentation
            -- snapshot_stats
            -- variable,name=use_thrash,value=0
            VarUseThrash = 0

            -- variable,name=use_thrash,value=2,if=azerite.wild_fleshrending.enabled
            if A.WildFleshrending:GetAzeriteRank() > 0 then
                VarUseThrash = 2
            end
			
            -- regrowth,if=talent.bloodtalons.enabled
            if A.Regrowth:IsReady(player) and not A.LastPlayerCastName == A.Regrowth:Info() and A.Bloodtalons:IsSpellLearned() and Unit(player):HasBuffs(A.BloodtalonsBuff.ID, true) == 0 then
                return A.Regrowth:Show(icon)
            end
			
            -- potion,dynamic_prepot=1
            if A.PotionofUnbridledFury:IsReady(unit) and Potion then
                return A.PotionofUnbridledFury:Show(icon)
            end	
			
            -- use_item,name=azsharas_font_of_power
            if A.AzsharasFontofPower:IsReady(player) then
                return A.AzsharasFontofPower:Show(icon)
            end
						
            -- berserk
            if A.Berserk:IsReady(player) and Unit(player):HasBuffs(A.BerserkBuff.ID, true) == 0 and A.BurstIsON(unit) then
                return A.Berserk:Show(icon)
            end		
		end

        --EntanglingRoots Thing from Beyond (Mouseover or Target)
		if Unit(player):HasDeBuffs(A.GrandDelusionsDebuff.ID, true) > 0 and RootThingFromBeyond then
            -- Notification					
	        Action.SendNotification("Thing from Beyond Detected!!! MOUSEOVER IT NOW!!", A.GrandDelusionsDebuff.ID)		   
		end
        if inCombat and RootThingFromBeyond and Unit(player):HasDeBuffs(A.GrandDelusionsDebuff.ID, true) > 0 then
		    if A.EntanglingRoots:IsReady(unit) and Unit(player):HasBuffs(A.PredatorySwiftnessBuff.ID, true) > 0 and Unit(player):HasBuffs(A.MassEntanglement.ID, true) == 0 then 
                return A.EntanglingRoots:Show(icon)
			else
			    if A.MassEntanglement:IsReady(unit) and MassEntanglementThingFromBeyond and Unit(player):HasBuffs(A.EntanglingRoots.ID, true) == 0 and Unit(player):HasBuffs(A.PredatorySwiftnessBuff.ID, true) == 0 and A.MassEntanglement:IsSpellLearned() then
			        return A.MassEntanglement:Show(icon)
				end
			end
        end
 		
        -- Expel Enrage 
        if inCombat and A.Soothe:IsReady(unit) and Action.AuraIsValid("target", "UseExpelEnrage", "Enrage") then
            return A.Soothe:Show(icon)
        end 

	    -- WildCharge Bear  out of range
        if inCombat and IsInBearForm and A.WildCharge:IsSpellLearned() and UseWildChargeBear and A.WildChargeBear:IsReady(unit) and Unit(unit):GetRange() >= 8 and Unit(unit):GetRange() <= 25 + (A.BalanceAffinity:IsSpellLearned() and 3 or 0) then
            return A.WildChargeBear:Show(icon)
        end

        -- WildCharge Cat out of range
        if inCombat and IsInCatForm and A.WildCharge:IsSpellLearned() and UseWildChargeCat and A.WildChargeCat:IsReady(unit) and Unit(unit):GetRange() >= 8 and Unit(unit):GetRange() <= 25 + (A.BalanceAffinity:IsSpellLearned() and 3 or 0) then
            return A.WildChargeCat:Show(icon)
        end
			
	    -- StampedingRoar if out of range 
        if inCombat and A.StampedingRoar:IsReady("player") and isMovingFor > A.GetToggle(2, "StampedingRoarTime") and A.GetToggle(2, "UseStampedingRoar") then
            return A.StampedingRoar:Show(icon)
        end
		
	    -- Dash if out of range 
        if inCombat and A.Dash:IsReady("player") and Unit(player):HasBuffs(A.StampedingRoar.ID, true) == 0 and isMovingFor > A.GetToggle(2, "DashTime") and A.GetToggle(2, "UseDash") then
            return A.Dash:Show(icon)
        end
 
		-- Interrupt
   	    local Interrupt = Interrupts(unit)
  	    if Interrupt and inCombat then 
  	        return Interrupt:Show(icon)
  	    end	
		
		-- Balance Affinity
		local BalanceRotation = BalanceAffinity(unit)
        if BalanceRotation and inCombat and IsInMoonkinForm then
		    return BalanceRotation:Show(icon)
		end
 
        --Opener
        -- auto_attack,if=!buff.prowl.up&!buff.shadowmeld.up        
        -- run_action_list,name=opener,if=variable.opener_done=0
        if VarOpenerDone == 0 and Unit(unit):GetRange() <= OpenerRange and IsInCatForm and not Unit(unit):IsDead() then
        
            -- tigers_fury
            if A.TigersFury:IsReady(player) then
                return A.TigersFury:Show(icon)
            end
			
			-- berserk,if=!tigers_fury.up
            if A.Berserk:IsReady(player) and A.TigersFury:GetCooldown() > 0 and A.BurstIsON(unit) then
                return A.Berserk:Show(icon) 
            end
            
            -- rake,if=!ticking|buff.prowl.up
            if A.Rake:IsReady(unit) and (Unit(unit):HasDeBuffs(A.RakeDebuff.ID, true) == 0 or Unit(player):HasBuffs(A.ProwlBuff.ID, true) > 0) then
                return A.Rake:Show(icon)
            end
            
            -- variable,name=opener_done,value=dot.rip.ticking
            VarOpenerDone = num(Unit(unit):HasDeBuffs(A.RipDebuff.ID, true) > 0)

            -- wait,sec=0.001,if=dot.rip.ticking
            if Unit(unit):HasDeBuffs(A.RipDebuff.ID, true) > 0 then
                Action.TimerSet("ACTION_TASTE_FERAL_OPENER", 0.001, function() return false end)
            end
            
            -- moonfire_cat,if=!ticking
        --    if A.MoonfireCat:IsReady(unit) and ((Unit(unit):GetRange() > 5 and MoonfireOnlyOutOfRange) or not MoonfireOnlyOutOfRange) and Unit(unit):HasDeBuffs(A.MoonfireCatDebuff.ID, true) == 0 then
        --        return A.MoonfireCat:Show(icon)
       --     end
			
            -- Manual addition: Use Primal Wrath if >= 2 targets or Rip if only 1 target
            if A.PrimalWrath:IsReady(player) and A.PrimalWrath:IsSpellLearned() and Unit(unit):HasDeBuffs(A.RipDebuff.ID, true) == 0 and GetByRange(2, 8) then
                return A.PrimalWrath:Show(icon)
            end 
			
            -- rip,if=!ticking
            if A.Rip:IsReady(unit) and Unit(unit):HasDeBuffs(A.RipDebuff.ID, true) == 0 then
                return A.Rip:Show(icon)
            end
            
        end
                
        -- rake,if=buff.prowl.up|buff.shadowmeld.up
        if A.Rake:IsReady(unit) and IsInCatForm and (Unit(player):HasBuffs(A.ProwlBuff.ID, true) > 0 or Unit(player):HasBuffs(A.ShadowmeldBuff.ID, true) > 0) then
            return A.Rake:Show(icon)
        end
        
        -- variable,name=reaping_delay,value=target.time_to_die,if=variable.reaping_delay=0
        if (VarReapingDelay == 0) then
            VarReapingDelay = Unit(unit):TimeToDie()
        end
    
        -- cycling_variable,name=reaping_delay,op=min,value=target.time_to_die
        --if VarReapingDelay then
            --VarReapingDelay = math.min(VarReapingDelay, Unit(unit):TimeToDie())
			VarReapingDelay = LowestTTD()
        --end
		
		-- Tigers Fury reset
		if inCombat and not Unit(unit):IsDead() and Unit(unit):GetRange() < 7 and IsInCatForm and A.TigersFury:IsReady(player) and A.Predator:IsSpellLearned() and
		    (
			    Unit(unit):HasDeBuffs(A.RakeDebuff.ID, true) > 0 and Unit(unit):TimeToDie() < Unit(unit):HasDeBuffs(A.RakeDebuff)  
				or
				Unit(unit):HasDeBuffs(A.RipDebuff.ID, true) > 0 and Unit(unit):TimeToDie() < Unit(unit):HasDeBuffs(A.RipDebuff)			
		    )
		then 
		    return A.TigersFury:Show(icon)
		end
		
        -- tigers_fury,if=energy.deficit>=60
       -- if A.TigersFury:IsReady(player) and GetByRange() then
      --      return A.TigersFury:Show(icon)
      --  end
	  
	    -- ZakLL Maim Logic for PvP :) 
	    if A.IsInPvP then
	  		if A.Maim:IsReady(unit) and Unit(unit):IsControlAble("stun", 0) and Unit(unit):HasDeBuffs("Stuned") == 0 and 
			   (A.Berserk:IsReady(player) or A.FeralFrenzy:IsReady(unit) or EnemyTeam("HEALER"):GetCC() >= A.GetGCD() * 3) and Unit(unit):HasBuffs("DeffBuffs") == 0 and Player:ComboPoints() > 3 then
				return A.Maim:Show(icon)
			end
        end
		
        -- call_action_list,name=cooldowns
        if inCombat and IsInCatForm and not Unit(unit):IsDead() and Unit(unit):GetRange() < 7 and unit ~= "mouseover" then
       
            -- tigers_fury,if=energy.deficit>=60
            if A.TigersFury:IsReady(player) and EnergyDeficitPredicted >= 60 then
                return A.TigersFury:Show(icon)
            end
        
            -- berserk,if=energy>=30&(cooldown.tigers_fury.remains>5|buff.tigers_fury.up)
            if A.Berserk:IsReady(player) and A.BurstIsON(unit) and 
			(
			    EnergyPredicted >= 30 and 
				(
				    A.TigersFury:GetCooldown() > 5 
					or
					Unit(player):HasBuffs(A.TigersFuryBuff.ID, true) > 0
				)
			)
			then
                return A.Berserk:Show(icon)
            end
            
            -- berserking
            if A.Berserking:AutoRacial(unit) and Racial and A.BurstIsON(unit) then
                return A.Berserking:Show(icon)
            end
            
            -- thorns,if=active_enemies>desired_targets|raid_event.adds.in>45
            --if A.Thorns:IsReady(unit) and (MultiUnits:GetByRangeInCombat(30, 5, 10) > 1 or 10000000000 > 45) then
            --    return A.Thorns:Show(icon)
            --end
            
            -- the_unbound_force,if=buff.reckless_force.up|buff.tigers_fury.up
            if A.TheUnboundForce:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and (Unit(player):HasBuffs(A.RecklessForceBuff.ID, true) > 0 or Unit(player):HasBuffs(A.TigersFuryBuff.ID, true) > 0) then
                return A.TheUnboundForce:Show(icon)
            end
			
             -- reaping_flames
            if A.ReapingFlames:AutoHeartOfAzeroth(unit) and UseHeartOfAzeroth then
                return A.ReapingFlames:Show(icon)
            end
			
            -- memory_of_lucid_dreams,if=buff.tigers_fury.up&buff.berserk.down
            if A.MemoryofLucidDreams:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and (Unit(player):HasBuffs(A.TigersFuryBuff.ID, true) > 0 and Unit(player):HasBuffs(A.BerserkBuff.ID, true) == 0) then
                return A.MemoryofLucidDreams:Show(icon)
            end
			
            -- blood_of_the_enemy,if=buff.tigers_fury.up
            if A.BloodoftheEnemy:AutoHeartOfAzerothP(unit, true) and Unit(player):HasBuffs(A.TigersFuryBuff.ID, true) > 0 and HeartOfAzeroth and 
			(
			    not BloodoftheEnemySyncAoE and Unit(unit):TimeToDie() > 3
				or
				BloodoftheEnemySyncAoE and Player:AreaTTD(OpenerRange) >= BloodoftheEnemyAoETTD and GetByRange(BloodoftheEnemyUnits, OpenerRange) 
				or
				Unit(unit):IsBoss()
			)
			then
                return A.BloodoftheEnemy:Show(icon)
            end           
  
            -- feral_frenzy,if=combo_points=0
            if A.FeralFrenzy:IsReady(unit) and (Player:ComboPoints() == 0) then
                return A.FeralFrenzy:Show(icon)
            end

            -- focused_azerite_beam,if=spell_targets.blade_dance1>=2|raid_event.adds.in>60
            if A.FocusedAzeriteBeam:AutoHeartOfAzeroth(unit, true) and CanCast and BurstIsON(unit) and UseHeartOfAzeroth 
               and (GetByRange(FocusedAzeriteBeamUnits, 30) or Unit(unit):IsBoss()) and Unit(unit):TimeToDie() >= FocusedAzeriteBeamTTD
            then
                 -- Notification                    
                Action.SendNotification("Stop moving!! Focused Azerite Beam", A.FocusedAzeriteBeam.ID)                 
                return A.FocusedAzeriteBeam:Show(icon)
            end            
            
            -- purifying_blast,if=active_enemies>desired_targets|raid_event.adds.in>60
            if A.PurifyingBlast:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and GetByRange(2, 8) > 1 then
                return A.PurifyingBlast:Show(icon)
            end
            
            -- guardian_of_azeroth,if=buff.tigers_fury.up
            if A.GuardianofAzeroth:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and (Unit(player):HasBuffs(A.TigersFuryBuff.ID, true)) then
                return A.GuardianofAzeroth:Show(icon)
            end
            
            -- concentrated_flame,if=buff.tigers_fury.up
            if A.ConcentratedFlame:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and (Unit(player):HasBuffs(A.TigersFuryBuff.ID, true)) then
                return A.ConcentratedFlame:Show(icon)
            end
            
            -- ripple_in_space,if=buff.tigers_fury.up
            if A.RippleinSpace:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and (Unit(player):HasBuffs(A.TigersFuryBuff.ID, true)) then
                return A.RippleinSpace:Show(icon)
            end
            
            -- worldvein_resonance,if=buff.tigers_fury.up
            if A.WorldveinResonance:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and (Unit(player):HasBuffs(A.TigersFuryBuff.ID, true)) then
                return A.WorldveinResonance:Show(icon)
            end
            
            -- reaping_flames,target_if=target.time_to_die<1.5|((target.health.pct>80|target.health.pct<=20)&variable.reaping_delay>29)|(target.time_to_pct_20>30&variable.reaping_delay>44)
            if A.ReapingFlames:AutoHeartOfAzerothP(unit) then
                if Unit(unit):TimeToDie() < 1.5 
                    or 
                    (
                        (Unit(unit):HealthPercent() > 80 or Unit(unit):HealthPercent() <= 20) 
                        and 
                        VarReapingDelay > 29
                    ) 
                    or 
                    (Unit(unit):TimeToDieX(20) > 30 and VarReapingDelay > 44) 
                then
                    return A.ReapingFlames:Show(icon) 
                end
            end
            
            -- incarnation,if=energy>=30&(cooldown.tigers_fury.remains>15|buff.tigers_fury.up)
            if A.Incarnation:IsReady(player) and A.BurstIsON(unit) and 
			(
			    EnergyPredicted >= 30 and 
				(
				    A.TigersFury:GetCooldown() > 15 
					or
					Unit(player):HasBuffs(A.TigersFuryBuff.ID, true) > 0
				)
			)
			then
                return A.Incarnation:Show(icon)
            end

            -- potion
            if A.PotionofUnbridledFury:IsReady(unit) and Action.GetToggle(1, "Potion") and UnbridledFuryAuto
			and 
			(
				(UnbridledFuryWithBloodlust and Unit(player):HasHeroism())
				or
				(UnbridledFuryWithExecute and Unit(unit):HealthPercent() <= 30)
				or
				(
				    Unit(unit):TimeToDie() < 65 
					or 
					(
					    Unit(unit):TimeToDie() < 180 and 
						(
						    Unit(player):HasBuffs(A.BerserkBuff.ID, true) > 0 
							or 
							Unit(player):HasBuffs(A.IncarnationBuff.ID, true) > 0
						)
					)
				)
			) and Unit(unit):TimeToDie() > UnbridledFuryTTD
			then
 	            -- Notification					
                Action.SendNotification("Burst: Potion of Unbridled Fury", A.PotionofUnbridledFury.ID)	
                return A.PotionofUnbridledFury:Show(icon)
            end
            
            -- shadowmeld,if=combo_points<5&energy>=action.rake.cost&dot.rake.pmultiplier<2.1&buff.tigers_fury.up&(buff.bloodtalons.up|!talent.bloodtalons.enabled)&(!talent.incarnation.enabled|cooldown.incarnation.remains>18)&!buff.incarnation.up
            if A.Shadowmeld:AutoRacial(unit) and Racial and A.BurstIsON(unit) and 
			(
			    Player:ComboPoints() < 5 and EnergyPredicted >= A.Rake:GetSpellPowerCost() and A.PMultiplier(unit, A.Rake.ID) < 2.1 and Unit(player):HasBuffs(A.TigersFuryBuff.ID, true) > 0 and 
				(
				    Unit(player):HasBuffs(A.BloodtalonsBuff.ID, true) > 0 
					or
					not A.Bloodtalons:IsSpellLearned()
				)
				and 
				(
				    not A.Incarnation:IsSpellLearned() 
					or
					A.Incarnation:GetCooldown() > 18
				) 
				and Unit(player):HasBuffs(A.IncarnationBuff.ID, true) == 0
			)
			then
                return A.Shadowmeld:Show(icon)
            end
            
            -- use_item,name=ashvanes_razor_coral,if=debuff.razor_coral_debuff.down|debuff.conductive_ink_debuff.up&target.time_to_pct_30<1.5|!debuff.conductive_ink_debuff.up&(debuff.razor_coral_debuff.stack>=25-10*debuff.blood_of_the_enemy.up|target.time_to_die<40)&buff.tigers_fury.remains>10
            if A.AshvanesRazorCoral:IsReady(unit) and 
			(
			    Unit(unit):HasDeBuffs(A.RazorCoralDebuff.ID, true) == 0 
				or 
				Unit(unit):HasDeBuffs(A.ConductiveInkDebuff.ID, true) > 0 and Unit(unit):TimeToDieX(30) < 1.5 
				or 
				Unit(unit):HasDeBuffs(A.ConductiveInkDebuff.ID, true) == 0 and 
				(
				    Unit(unit):HasDeBuffsStacks(A.RazorCoralDebuff.ID, true) >= 25 - 10 * num(Unit(unit):HasDeBuffs(A.BloodoftheEnemyDebuff.ID, true) > 0) 
				    or
				    Unit(unit):IsBoss() and Unit(unit):TimeToDie() < 40
				)
				and Unit(player):HasBuffs(A.TigersFuryBuff.ID, true) > 10
			)
			then
                return A.AshvanesRazorCoral:Show(icon)
            end     			
		
            -- use_item,effect_name=cyclotronic_blast,if=(energy.deficit>=energy.regen*3)&buff.tigers_fury.down&!azerite.jungle_fury.enabled
            if A.CyclotronicBlast:IsReady(unit) and ((EnergyDeficitPredicted >= EnergyRegen * 3) and Unit(player):HasBuffs(A.TigersFuryBuff.ID, true) == 0 and A.JungleFury:GetAzeriteRank() == 0) 
			and    
            (
                (TrinketsAoE and GetByRange(TrinketsMinUnits, TrinketsUnitsRange) and Player:AreaTTD(TrinketsUnitsRange) > TrinketsMinTTD)
                or
                (not TrinketsAoE and Unit(unit):TimeToDie() >= TrinketsMinTTD) 		
            )
			then
                return A.CyclotronicBlast:Show(icon)
            end
            
            -- use_item,effect_name=cyclotronic_blast,if=buff.tigers_fury.up&azerite.jungle_fury.enabled
            if A.CyclotronicBlast:IsReady(unit) and (Unit(player):HasBuffs(A.TigersFuryBuff.ID, true) > 0 and A.JungleFury:GetAzeriteRank() > 0) 
			and    
            (
                (TrinketsAoE and GetByRange(TrinketsMinUnits, TrinketsUnitsRange) and Player:AreaTTD(TrinketsUnitsRange) > TrinketsMinTTD)
                or
                (not TrinketsAoE and Unit(unit):TimeToDie() >= TrinketsMinTTD) 		
            )
			then
                return A.CyclotronicBlast:Show(icon)
            end
            
            -- use_item,effect_name=azsharas_font_of_power,if=energy.deficit>=50
            if A.AzsharasFontofPower:IsReady(player) and EnergyDeficitPredicted >= 50 
			and    
            (
                (TrinketsAoE and GetByRange(TrinketsMinUnits, TrinketsUnitsRange) and Player:AreaTTD(TrinketsUnitsRange) > TrinketsMinTTD)
                or
                (not TrinketsAoE and Unit(unit):TimeToDie() >= TrinketsMinTTD) 		
            )
			then
                return A.AzsharasFontofPower:Show(icon)
            end
            
            -- use_items,if=buff.tigers_fury.up|target.time_to_die<20
            
            -- Non SIMC Custom Trinket1
            if A.Trinket1:IsReady(unit) and Trinket1IsAllowed and    
            (
                (TrinketsAoE and GetByRange(TrinketsMinUnits, TrinketsUnitsRange) and Player:AreaTTD(TrinketsUnitsRange) > TrinketsMinTTD)
                or
                (not TrinketsAoE and Unit(unit):TimeToDie() >= TrinketsMinTTD) 		
            )
            then 
                  return A.Trinket1:Show(icon)
            end         
            
        
            -- Non SIMC Custom Trinket2
            if A.Trinket2:IsReady(unit) and Trinket2IsAllowed and        
            (
                (TrinketsAoE and GetByRange(TrinketsMinUnits, TrinketsUnitsRange) and Player:AreaTTD(TrinketsUnitsRange) > TrinketsMinTTD)
                or
                (not TrinketsAoE and Unit(unit):TimeToDie() >= TrinketsMinTTD)        			
            )
            then
                return A.Trinket2:Show(icon)     
            end    
            
        end

        -- ferocious_bite,target_if=dot.rip.ticking&dot.rip.remains<3&target.time_to_die>10&(talent.sabertooth.enabled)
        if inCombat and IsInCatForm and A.FerociousBite:IsReady(unit) then
            if Unit(unit):HasDeBuffs(A.RipDebuff.ID, true) > 0 and Unit(unit):HasDeBuffs(A.RipDebuff.ID, true) < 3 and Unit(unit):TimeToDie() > 10 and A.Sabertooth:IsSpellLearned() then
                return A.FerociousBite:Show(icon) 
            end
        end

        -- regrowth,if=combo_points=5&buff.predatory_swiftness.up&talent.bloodtalons.enabled&buff.bloodtalons.down
        if inCombat and A.Regrowth:IsReady(player) and not A.LastPlayerCastName == A.Regrowth:Info() and 
        (
            Player:ComboPoints() == 5 
            and
            Unit(player):HasBuffs(A.PredatorySwiftnessBuff.ID, true) > 0 
            and 
            A.Bloodtalons:IsSpellLearned() 
            and 
            Unit(player):HasBuffs(A.BloodtalonsBuff.ID, true) == 0
        )
        then
            return A.Regrowth:Show(icon)
        end

        -- run_action_list,name=finishers,if=combo_points>4
        if Player:ComboPoints() > 4 and not Unit(unit):IsDead() and Unit(unit):GetRange() < 7 then
        
            -- pool_resource,for_next=1            
            -- savage_roar,if=buff.savage_roar.down
            if A.SavageRoar:IsReadyByPassCastGCD(player) and (Unit(player):HasBuffs(A.SavageRoarBuff.ID, true) == 0) then
                if A.SavageRoar:IsUsablePPool() then
                    return A.SavageRoar:Show(icon)
                else
                    return A.PoolResource:Show(icon)
                end
            end
            
            -- pool_resource,for_next=1            
            -- primal_wrath,target_if=spell_targets.primal_wrath>1&dot.rip.remains<4
            if A.PrimalWrath:IsReadyByPassCastGCD(player) then
                if GetByRange(2, 8) and Unit(unit):HasDeBuffs(A.RipDebuff.ID, true) < 4 then
                    return A.PrimalWrath:Show(icon) 
                end
            end
            
            -- pool_resource,for_next=1
            -- primal_wrath,target_if=spell_targets.primal_wrath>=2
            if A.PrimalWrath:IsReadyByPassCastGCD(player) then
                if GetByRange(2, 8) then
                    return A.PrimalWrath:Show(icon) 
                end
            end
            
            -- pool_resource,for_next=1
            -- rip,target_if=!ticking|(remains<=duration*0.3)&(!talent.sabertooth.enabled)|(remains<=duration*0.8&persistent_multiplier>dot.rip.pmultiplier)&target.time_to_die>8
            if A.Rip:IsReadyByPassCastGCD(unit) then
                if Unit(unit):HasDeBuffs(A.RipDebuff.ID, true) == 0 or 
				(
				    Unit(unit):HasDeBuffs(A.RipDebuff.ID, true) <= A.RipDebuff:BaseDuration() * 0.3
				) and (not A.Sabertooth:IsSpellLearned()) 
				or 
				(
				    Unit(unit):HasDeBuffs(A.RipDebuff.ID, true) <= A.RipDebuff:BaseDuration() * 0.8 and A.Persistent_PMultiplier(A.Rip.ID) > A.PMultiplier(unit, A.Rip.ID)
				)
				and Unit(unit):TimeToDie() > 8 then
                    return A.Rip:Show(icon) 
                end
            end
            
            -- pool_resource,for_next=1
            -- savage_roar,if=buff.savage_roar.remains<12
            if A.SavageRoar:IsReadyByPassCastGCD(player) and (Unit(player):HasBuffs(A.SavageRoarBuff.ID, true) < 12) then
                if A.SavageRoar:IsUsablePPool() then
                    return A.SavageRoar:Show(icon)
                else
                    return A.PoolResource:Show(icon)
                end
            end
            
            -- pool_resource,for_next=1
            -- maim,if=buff.iron_jaws.up
            if A.Maim:IsReadyByPassCastGCD(unit) and (Unit(player):HasBuffs(A.IronJawsBuff.ID, true) > 0) then
                if A.Maim:IsUsablePPool() then
                    return A.Maim:Show(icon)
                else
                    return A.PoolResource:Show(icon)
                end
            end
            
            -- ferocious_bite,max_energy=1
            if A.FerociousBiteMaxEnergy:IsReady(unit) and (Player:Energy() >= 50 or (Unit(player):HasBuffs(A.BerserkBuff.ID, true) > 0 and Player:Energy() >= 30)) and Player:ComboPoints() > 0 then
                return A.FerociousBiteMaxEnergy:Show(icon)
            end
			
            -- ferocious_bite,max_energy=1,target_if=max:druid.rip.ticks_gained_on_refresh
          --  if A.FerociousBiteMaxEnergy:IsReady(unit) and A.FerociousBiteMaxEnergy:IsUsableP() then
          --      if max:druid.rip.ticks_gained_on_refresh then 
          --          return A.FerociousBiteMaxEnergy:Show(icon) 
          --      end
          --  end
        
        else
        -- run_action_list,name=generators

            -- regrowth,if=talent.bloodtalons.enabled&buff.predatory_swiftness.up&buff.bloodtalons.down&combo_points=4&dot.rake.remains<4
            if A.Regrowth:IsReady(player) and not A.LastPlayerCastName == A.Regrowth:Info() and (A.Bloodtalons:IsSpellLearned() and Unit(player):HasBuffs(A.PredatorySwiftnessBuff.ID, true) > 0 and Unit(player):HasBuffs(A.BloodtalonsBuff.ID, true) == 0 and Player:ComboPoints() == 4 and Unit(unit):HasDeBuffs(A.RakeDebuff.ID, true) < 4) then
                return A.Regrowth:Show(icon)
            end
			
            -- regrowth,if=talent.bloodtalons.enabled&buff.bloodtalons.down&buff.predatory_swiftness.up&talent.lunar_inspiration.enabled&dot.rake.remains<1
            if A.Regrowth:IsReady(player) and not A.LastPlayerCastName == A.Regrowth:Info() and (A.Bloodtalons:IsSpellLearned() and Unit(player):HasBuffs(A.BloodtalonsBuff.ID, true) == 0 and Unit(player):HasBuffs(A.PredatorySwiftnessBuff.ID, true) > 0 and A.LunarInspiration:IsSpellLearned() and Unit(unit):HasDeBuffs(A.RakeDebuff.ID, true) < 1) then
                return A.Regrowth:Show(icon)
            end
			
            -- brutal_slash,if=spell_targets.brutal_slash>desired_targets
            if A.BrutalSlash:IsReadyByPassCastGCD(player, true) and not Unit(unit):IsDead() and Unit(unit):GetRange() < 7 and GetByRange(2, 8) and A.BrutalSlash:IsSpellLearned() then
                return A.BrutalSlash:Show(icon)
            end
			
            -- pool_resource,for_next=1
            -- thrash_cat,if=(refreshable)&(spell_targets.thrash_cat>2)
            if A.ThrashCat:IsReady(player) and not Unit(unit):IsDead() and Unit(unit):GetRange() < 7 and (Unit(unit):HasDeBuffs(A.ThrashCatDebuff.ID, true) < 5) and GetByRange(3, 8) then
                if A.ThrashCat:IsUsablePPool() then
                    return A.ThrashCat:Show(icon)
                else
                    return A.PoolResource:Show(icon)
                end
            end
			
            -- pool_resource,for_next=1
            -- thrash_cat,if=(talent.scent_of_blood.enabled&buff.scent_of_blood.down)&spell_targets.thrash_cat>3
            if A.ThrashCat:IsReady(player) and not Unit(unit):IsDead() and Unit(unit):GetRange() < 7 and (A.ScentofBlood:IsSpellLearned() and Unit(player):HasBuffs(A.ScentofBloodBuff.ID, true) == 0) and GetByRange(4, 8) then
                if A.ThrashCat:IsUsablePPool() then
                    return A.ThrashCat:Show(icon)
                else
                    return A.PoolResource:Show(icon)
                end
            end
			
            -- pool_resource,for_next=1
            -- swipe_cat,if=buff.scent_of_blood.up|(A.SwipeCat:Damage()*spell_targets.swipe_cat>(A.Rake:Damage()+(RakeBleedTick()*5)))
            if A.SwipeCat:IsReady(player) and not Unit(unit):IsDead() and Unit(unit):GetRange() < 7 and 
			(
			    Unit(player):HasBuffs(A.ScentofBloodBuff.ID, true) > 0 
				or
				(A.SwipeCat:Damage() * MultiUnits:GetByRange(5) > (A.Rake:Damage() + (RakeBleedTick() * 5)))
			)
			then
                if A.SwipeCat:IsUsablePPool() then
                    return A.SwipeCat:Show(icon)
                else
                    return A.PoolResource:Show(icon)
                end
            end
			
            -- pool_resource,for_next=1
            -- rake,target_if=!ticking|(!talent.bloodtalons.enabled&remains<duration*0.3)&target.time_to_die>4
            if A.Rake:IsReady(unit) then
                if Unit(unit):HasDeBuffs(A.RakeDebuff.ID, true) == 0 or (not A.Bloodtalons:IsSpellLearned() and Unit(unit):HasDeBuffs(A.RakeDebuff.ID, true) < A.RakeDebuff:BaseDuration() * 0.3) and Unit(unit):TimeToDie() > 4 then
                    return A.Rake:Show(icon) 
                end
            end
			
            -- pool_resource,for_next=1
            -- rake,target_if=talent.bloodtalons.enabled&buff.bloodtalons.up&((remains<=7)&persistent_multiplier>dot.rake.pmultiplier*0.85)&target.time_to_die>4
            if A.Rake:IsReady(unit) then
                if A.Bloodtalons:IsSpellLearned() and Unit(player):HasBuffs(A.BloodtalonsBuff.ID, true) > 0 and ((Unit(unit):HasDeBuffs(A.RakeDebuff.ID, true) <= 7) and A.Persistent_PMultiplier(A.Rake.ID) > A.PMultiplier(unit, A.Rake.ID) * 0.85) and Unit(unit):TimeToDie() > 4 then
                    return A.Rake:Show(icon) 
                end
            end
			
            -- moonfire_cat,if=buff.bloodtalons.up&buff.predatory_swiftness.down&combo_points<5
       --     if A.MoonfireCat:IsReady(unit) and ((Unit(unit):GetRange() > 5 and MoonfireOnlyOutOfRange) or not MoonfireOnlyOutOfRange) and (Unit(player):HasBuffs(A.BloodtalonsBuff.ID, true) > 0 and Unit(player):HasBuffs(A.PredatorySwiftnessBuff.ID, true) == 0 and Player:ComboPoints() < 5) then
        --        return A.MoonfireCat:Show(icon)
        --    end
			
            -- brutal_slash,if=(buff.tigers_fury.up&(raid_event.adds.in>(1+max_charges-charges_fractional)*recharge_time))&(spell_targets.brutal_slash*A.BrutalSlash:Damage()%action.brutal_slash.cost)>(A.Shred:Damage()%action.shred.cost)
            if A.BrutalSlash:IsReadyByPassCastGCD(player, true) and not Unit(unit):IsDead() and Unit(unit):GetRange() < 7 and 
			(
			    (Unit(player):HasBuffs(A.TigersFuryBuff.ID, true) > 0 ) 
				and
				(MultiUnits:GetByRange(8) * A.BrutalSlash:Damage() / A.BrutalSlash:GetSpellPowerCost()) > (A.Shred:Damage() / A.Shred:GetSpellPowerCost())
			)
			then
                return A.BrutalSlash:Show(icon)
            end
			
            -- moonfire_cat,target_if=refreshable
        --    if A.MoonfireCat:IsReady(unit) and ((Unit(unit):GetRange() > 5 and MoonfireOnlyOutOfRange) or not MoonfireOnlyOutOfRange) then
        --        if Unit(unit):HasDeBuffs(A.MoonfireCatDebuff.ID, true) < 5 then
        --            return A.MoonfireCat:Show(icon) 
        --        end
        --    end
			
            -- pool_resource,for_next=1
            -- thrash_cat,if=refreshable&((variable.use_thrash=2&(!buff.incarnation.up|azerite.wild_fleshrending.enabled))|spell_targets.thrash_cat>1)
            if A.ThrashCat:IsReady(player) and not Unit(unit):IsDead() and Unit(unit):GetRange() < 7 and (Unit(unit):HasDeBuffs(A.ThrashCatDebuff.ID, true) < 5 and ((VarUseThrash == 2 and (Unit(player):HasBuffs(A.IncarnationBuff.ID, true) == 0 or A.WildFleshrending:GetAzeriteRank() > 0)) or GetByRange(2, 8))) then
                if A.ThrashCat:IsUsablePPool() then
                    return A.ThrashCat:Show(icon)
                else
                    return A.PoolResource:Show(icon)
                end
            end
			
            -- thrash_cat,if=refreshable&variable.use_thrash=1&buff.clearcasting.react&(!buff.incarnation.up|azerite.wild_fleshrending.enabled)
            if A.ThrashCat:IsReady(player) and not Unit(unit):IsDead() and Unit(unit):GetRange() < 7 and (Unit(unit):HasDeBuffs(A.ThrashCatDebuff.ID, true) < 5 and VarUseThrash == 1 and Unit(player):HasBuffsStacks(A.ClearcastingBuff.ID, true) > 0 and (Unit(player):HasBuffs(A.IncarnationBuff.ID, true) == 0 or A.WildFleshrending:GetAzeriteRank() > 0)) then
                return A.ThrashCat:Show(icon)
            end
			
            -- pool_resource,for_next=1
            -- swipe_cat,if=spell_targets.swipe_cat>1
            if A.SwipeCat:IsReady(player) and not Unit(unit):IsDead() and Unit(unit):GetRange() < 7 and GetByRange(2, 8) then
                if A.SwipeCat:IsUsablePPool() then
                    return A.SwipeCat:Show(icon)
                else
                    return A.PoolResource:Show(icon)
                end
            end
			
            -- shred,if=dot.rake.remains>(action.shred.cost+action.rake.cost-energy)%energy.regen|buff.clearcasting.react
            if A.Shred:IsReadyByPassCastGCD(unit) and (Unit(unit):HasDeBuffs(A.RakeDebuff.ID, true) > (A.Shred:GetSpellPowerCost() + A.Rake:GetSpellPowerCost() - EnergyPredicted) / EnergyRegen or Unit(player):HasBuffsStacks(A.ClearcastingBuff.ID, true) > 0) then
                return A.Shred:Show(icon)
            end
			
        end        
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

-- [4] AoE Rotation
A[4] = function(icon)
    return A[3](icon, true)
end 

local function ArenaRotation(icon, unit)
    if A.IsInPvP and (A.Zone == "pvp" or A.Zone == "arena") and not Player:IsStealthed() and not Player:IsMounted() then     
        -- Interrupt
   	    local Interrupt = Interrupts(unit)
  	    if Interrupt and inCombat then 
  	        return Interrupt:Show(icon)
  	    end	
    end
end

local function PartyRotation(unit) 
    -- RemoveCorruption dispell Curse and Poison
    if A.RemoveCorruption:IsReady(unit) and (Unit(unit):HasDeBuffs("Poison") > 0 or Unit(unit):HasDeBuffs("Curse") > 0) and not Unit(unit):InLOS() then                         
        return A.RemoveCorruption
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

