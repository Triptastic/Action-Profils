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
Action[ACTION_CONST_PALADIN_PROTECTION] = {
    -- Racial
    ArcaneTorrent                        = Action.Create({ Type = "Spell", ID = 50613     }),
    BloodFury                            = Action.Create({ Type = "Spell", ID = 20572      }),
    Fireblood                            = Action.Create({ Type = "Spell", ID = 265221     }),
    AncestralCall                        = Action.Create({ Type = "Spell", ID = 274738     }),
    Berserking                           = Action.Create({ Type = "Spell", ID = 26297    }),
    ArcanePulse                          = Action.Create({ Type = "Spell", ID = 260364    }),
    QuakingPalm                          = Action.Create({ Type = "Spell", ID = 107079     }),
    Haymaker                             = Action.Create({ Type = "Spell", ID = 287712     }), 
    BullRush                             = Action.Create({ Type = "Spell", ID = 255654     }),    
    WarStomp                             = Action.Create({ Type = "Spell", ID = 20549     }),
    GiftofNaaru                          = Action.Create({ Type = "Spell", ID = 59544    }),
    Shadowmeld                           = Action.Create({ Type = "Spell", ID = 58984    }), -- usable in Action Core 
    Stoneform                            = Action.Create({ Type = "Spell", ID = 20594    }), 
    WilloftheForsaken                    = Action.Create({ Type = "Spell", ID = 7744        }), -- not usable in APL but user can Queue it    
    EscapeArtist                         = Action.Create({ Type = "Spell", ID = 20589    }), -- not usable in APL but user can Queue it
    EveryManforHimself                   = Action.Create({ Type = "Spell", ID = 59752    }), -- not usable in APL but user can Queue it
    PetKick                              = Action.Create({ Type = "Spell", ID = 47482, Color = "RED", Desc = "RED" }),
    -- Generic Spells
    Consecration                          = Action.Create({ Type = "Spell", ID = 26573     }),
    LightsJudgment                        = Action.Create({ Type = "Spell", ID = 255647     }),
    Fireblood                             = Action.Create({ Type = "Spell", ID = 265221     }),
    Seraphim                              = Action.Create({ Type = "Spell", ID = 152262     }),
    ShieldoftheRighteous                  = Action.Create({ Type = "Spell", ID = 53600     }),
    AvengingWrath                         = Action.Create({ Type = "Spell", ID = 31884     }),
    BastionofLight                        = Action.Create({ Type = "Spell", ID = 204035     }),
    Judgment                              = Action.Create({ Type = "Spell", ID = 275779     }),
    CrusadersJudgment                     = Action.Create({ Type = "Spell", ID = 204023     }),
    AvengersShield                        = Action.Create({ Type = "Spell", ID = 31935     }),
    BlessedHammer                         = Action.Create({ Type = "Spell", ID = 204019     }),
    HammeroftheRighteous                  = Action.Create({ Type = "Spell", ID = 53595     }),
    HeartEssence                          = Action.Create({ Type = "Spell", ID = 298554     }),
    RecklessForceBuff                     = Action.Create({ Type = "Spell", ID = 302932     }),
    ConcentratedFlameBurn                 = Action.Create({ Type = "Spell", ID = 295368     }),
    -- Buffs
    ShieldoftheRighteousBuff              = Action.Create({ Type = "Spell", ID = 132403     }),	
    AvengersValorBuff                     = Action.Create({ Type = "Spell", ID = 197561     }),
    SeraphimBuff                          = Action.Create({ Type = "Spell", ID = 152262     }),
    AvengingWrathBuff                     = Action.Create({ Type = "Spell", ID = 31884     }),
    ConsecrationBuff                      = Action.Create({ Type = "Spell", ID = 188370     }),
	-- Utilities
    Rebuke                               = Action.Create({ Type = "Spell", ID = 96231     }),
    FistofJustice                        = Action.Create({ Type = "Spell", ID = 198054     }),
    Repentance                           = Action.Create({ Type = "Spell", ID = 20066     }), 
    Cavalier                             = Action.Create({ Type = "Spell", ID = 190784     }),
    BlessingofProtectionYellow           = Action.Create({ Type = "Spell", ID = 1022, Color = "YELLOW", Desc = "YELLOW Color for Party Blessing"     }),	
    BlessingofProtection                 = Action.Create({ Type = "Spell", ID = 1022     }), 
    WordofGlory                          = Action.Create({ Type = "Spell", ID = 210191     }),
    BlessingofFreedom                    = Action.Create({ Type = "Spell", ID = 1044     }),
    BlessingofFreedomYellow              = Action.Create({ Type = "Spell", ID = 1044, Color = "YELLOW", Desc = "YELLOW Color for Party Blessing"     }),	
    HammerofJustice                      = Action.Create({ Type = "Spell", ID = 853     }),
	HammerofJusticeGreen                 = Action.Create({ Type = "SpellSingleColor", ID = 853, Color = "GREEN", Desc = "[1] CC", QueueForbidden = true }),
	DivineShield                         = Action.Create({ Type = "Spell", ID = 642     }),
    -- Defensives
    LightoftheProtector                   = Action.Create({ Type = "Spell", ID = 184092     }),
    HandoftheProtector                    = Action.Create({ Type = "Spell", ID = 213652     }),
	HandofReckoning                       = Action.Create({ Type = "Spell", ID = 62124     }), -- Taunt
	ArdentDefender                         = Action.Create({ Type = "Spell", ID = 31850     }),
	GuardianofAncientKings                = Action.Create({ Type = "Spell", ID = 86659     }),
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
	SuperiorSteelskinPotion                = Action.Create({ Type = "Potion", ID = 168501, QueueForbidden = true }), 
	AbyssalHealingPotion                   = Action.Create({ Type = "Potion", ID = 169451, QueueForbidden = true }), 
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
    -- Trinkets 2 
    DribblingInkpod                        = Action.Create({ Type = "Trinket", ID = 169319, QueueForbidden = true }),
    RazdunksBigRedButton                   = Action.Create({ Type = "Trinket", ID = 159611, QueueForbidden = true }),
    MerekthasFang                          = Action.Create({ Type = "Trinket", ID = 158367, QueueForbidden = true }),
    KnotofAncientFuryAlliance              = Action.Create({ Type = "Trinket", ID = 161413, QueueForbidden = true }),
    KnotofAncientFuryHorde                 = Action.Create({ Type = "Trinket", ID = 166795, QueueForbidden = true }),
    FirstMatesSpyglass                     = Action.Create({ Type = "Trinket", ID = 158163, QueueForbidden = true }),
    GrongsPrimalRage                       = Action.Create({ Type = "Trinket", ID = 165574, QueueForbidden = true }),
    LurkersInsidiousGift                   = Action.Create({ Type = "Trinket", ID = 167866, QueueForbidden = true }),
    NotoriousGladiatorsBadge               = Action.Create({ Type = "Trinket", ID = 167380, QueueForbidden = true }),
    NotoriousGladiatorsMedallion           = Action.Create({ Type = "Trinket", ID = 167377, QueueForbidden = true }),
    SinisterGladiatorsBadge                = Action.Create({ Type = "Trinket", ID = 165058, QueueForbidden = true }),
    SinisterGladiatorsMedallion            = Action.Create({ Type = "Trinket", ID = 165055, QueueForbidden = true }),
    VialofAnimatedBlood                    = Action.Create({ Type = "Trinket", ID = 159625, QueueForbidden = true }),
    JesHowler                              = Action.Create({ Type = "Trinket", ID = 159627, QueueForbidden = true }),
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
Action:CreateEssencesFor(ACTION_CONST_PALADIN_PROTECTION)  -- where PLAYERSPEC is Constance (example: ACTION_CONST_MONK_BM)
local A = setmetatable(Action[ACTION_CONST_PALADIN_PROTECTION], { __index = Action })


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
                (not A.IsInPvP and MultiUnits:GetByRange(10, 1) >= 1)
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

-- SelfDefensives
local function SelfDefensives(unit)
    local HPLoosePerSecond = Unit("player"):GetDMG() * 100 / Unit("player"):HealthMax()
		
    if Unit("player"):CombatTime() == 0 then 
        return 
    end 
	
    -- DivineShield
    local DivineShield = A.GetToggle(2, "DivineShieldHP")
    if     DivineShield >= 0 and A.DivineShield:IsReady("player") and 
    (
        (     -- Auto 
            DivineShield >= 100 and 
            (
                -- HP lose per sec >= 20
                Unit("player"):GetDMG() * 100 / Unit("player"):HealthMax() >= 25 or 
                Unit("player"):GetRealTimeDMG() >= Unit("player"):HealthMax() * 0.25 or 
                -- TTD 
                Unit("player"):TimeToDieX(5) < 5 or 
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
            DivineShield < 100 and 
            Unit("player"):HealthPercent() <= DivineShield
        )
    ) 
    then 
	    -- Notification					
        Action.SendNotification("[DEF] Divine Shield", A.DivineShield.ID)
        return A.DivineShield
    end	
	
    -- Ardent Defender
    local ArdentDefender = Action.GetToggle(2, "ArdentDefenderHP")
    if     ArdentDefender >= 0 and A.ArdentDefender:IsReady("player") and 
    (
        (   -- Auto 
            ArdentDefender >= 100 and 
            (
                -- HP lose per sec >= 20
                Unit("player"):GetDMG() * 100 / Unit("player"):HealthMax() >= 10 or 
                Unit("player"):GetRealTimeDMG() >= Unit("player"):HealthMax() * 0.10 or 
                -- TTD 
                Unit("player"):TimeToDieX(45) < 5 or
				-- Custom logic with current HPS and DMG
				Unit("player"):HealthPercent() <= 55 or			
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
            ArdentDefender < 100 and 
            Unit("player"):HealthPercent() <= ArdentDefender
        )
    ) 
    then 
        return A.ArdentDefender
    end
	
    -- Guardian of AncientKings
    local GuardianofAncientKings = Action.GetToggle(2, "GuardianofAncientKingsHP")
    if     GuardianofAncientKings >= 0 and A.GuardianofAncientKings:IsReady("player") and 
    (
        (   -- Auto 
            GuardianofAncientKings >= 100 and 
            (
                -- HP lose per sec >= 20
                Unit("player"):GetDMG() * 100 / Unit("player"):HealthMax() >= 40 or 
                Unit("player"):GetRealTimeDMG() >= Unit("player"):HealthMax() * 0.40 or 
                -- TTD 
                Unit("player"):TimeToDieX(5) < 3 or
				-- Custom logic with current HPS and DMG
				Unit("player"):HealthPercent() <= 10 or			
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
            GuardianofAncientKings < 100 and 
            Unit("player"):HealthPercent() <= GuardianofAncientKings
        )
    ) 
    then 
        return A.GuardianofAncientKings
    end
	
	
    -- LightoftheProtector
    local LightoftheProtector = Action.GetToggle(2, "LightoftheProtectorHP")
    if     LightoftheProtector >= 0 and A.LightoftheProtector:IsReady("player") and 
    (
        (   -- Auto 
            LightoftheProtector >= 100 and 
            (
                -- HP lose per sec >= 20
                Unit("player"):GetDMG() * 100 / Unit("player"):HealthMax() >= 15 or 
                Unit("player"):GetRealTimeDMG() >= Unit("player"):HealthMax() * 0.15 or 
                -- TTD 
                Unit("player"):TimeToDieX(55) < 5 or
				-- Custom logic with current HPS and DMG
				Unit("player"):HealthPercent() <= 70 or						
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
            LightoftheProtector < 100 and 
            Unit("player"):HealthPercent() <= LightoftheProtector
        )
    ) 
    then 
        return A.LightoftheProtector
    end  
	
	-- HealingPotion
    local AbyssalHealingPotion = A.GetToggle(2, "AbyssalHealingPotionHP")
    if     AbyssalHealingPotion >= 0 and A.AbyssalHealingPotion:IsReady("player") and 
    (
        (     -- Auto 
            AbyssalHealingPotion >= 100 and 
            (
                -- HP lose per sec >= 20
                Unit("player"):GetDMG() * 100 / Unit("player"):HealthMax() >= 10 or 
                Unit("player"):GetRealTimeDMG() >= Unit("player"):HealthMax() * 0.10 or 
                -- TTD 
                Unit("player"):TimeToDieX(20) < 5 or 
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

local function ExpectedCombatLength()
    local BossTTD = 0
    if not A.IsInPvP then 
        for i = 1, MAX_BOSS_FRAMES do 
            if Unit("boss" .. i):IsExists() and not Unit("boss" .. i):IsDead() then 
                BossTTD = Unit("boss" .. i):TimeToDie()
            end 
        end 
    end 
    return BossTTD
end 
ExpectedCombatLength = A.MakeFunctionCachedStatic(ExpectedCombatLength)

--- ======= ACTION LISTS =======
-- [3] Single Rotation
A[3] = function(icon, isMulti)
    --------------------
    --- ROTATION VAR ---
    --------------------
    local isMoving = A.Player:IsMoving()
    local inCombat = Unit("player"):CombatTime() > 0
	local combatTime = Unit("player"):CombatTime()
    local ShouldStop = Action.ShouldStop()
    local Pull = Action.BossMods_Pulling()
	-- Trinkets vars
    local Trinket1IsAllowed, Trinket2IsAllowed = TR:TrinketIsAllowed()
	local expected_combat_length = ExpectedCombatLength()
    ------------------------------------------------------
    ---------------- ENEMY UNIT ROTATION -----------------
    ------------------------------------------------------
    local function EnemyRotation(unit)
        local Precombat, Cooldowns
        --Precombat
        local function Precombat(unit)
            -- flask
            -- food
            -- augmentation
            -- snapshot_stats
            -- potion
            if A.SuperiorSteelskinPotion:IsReady(unit) and Action.GetToggle(1, "Potion") then
                return A.SuperiorSteelskinPotion:Show(icon)
            end
            -- consecration
            if A.Consecration:IsReady("player") and Unit("player"):HasBuffsDown(A.ConsecrationBuff.ID, true) then
                return A.Consecration:Show(icon)
            end
            -- lights_judgment
            if A.LightsJudgment:IsReady(unit) and A.BurstIsON(unit) then
                return A.LightsJudgment:Show(icon)
            end
        end
        
        --Cooldowns
        local function Cooldowns(unit)
            -- fireblood,if=buff.avenging_wrath.up
            if A.Fireblood:AutoRacial(unit) and A.BurstIsON(unit) and Action.GetToggle(1, "Racial") and A.BurstIsON(unit) and (Unit("player"):HasBuffs(A.AvengingWrathBuff.ID, true)) then
                return A.Fireblood:Show(icon)
            end
            -- use_item,name=azsharas_font_of_power,if=cooldown.seraphim.remains<=10|!talent.seraphim.enabled
            if A.AzsharasFontofPower:IsReady("player") and (A.Seraphim:GetCooldown() <= 10 or not A.Seraphim:IsSpellLearned()) then
                return A.AzsharasFontofPower:Show(icon)
            end
            -- use_item,name=ashvanes_razor_coral,if=(debuff.razor_coral_debuff.stack>7&buff.avenging_wrath.up)|debuff.razor_coral_debuff.stack=0
            if A.AshvanesRazorCoral:IsReady(unit) and ((Unit(unit):HasDeBuffsStacks(A.RazorCoralDebuff.ID, true) > 7 and Unit("player"):HasBuffs(A.AvengingWrathBuff.ID, true)) or Unit(unit):HasDeBuffsStacks(A.RazorCoralDebuff.ID, true) == 0) then
                return A.AshvanesRazorCoral:Show(icon)
            end
            -- seraphim,if=cooldown.shield_of_the_righteous.charges_fractional>=2
            if A.Seraphim:IsReady(unit) and (A.ShieldoftheRighteous:GetSpellChargesFrac() >= 2) then
                return A.Seraphim:Show(icon)
            end
            -- avenging_wrath,if=buff.seraphim.up|cooldown.seraphim.remains<2|!talent.seraphim.enabled
            if A.AvengingWrath:IsReady(unit) and A.BurstIsON(unit) and (Unit("player"):HasBuffs(A.SeraphimBuff.ID, true) or A.Seraphim:GetCooldown() < 2 or not A.Seraphim:IsSpellLearned()) then
                return A.AvengingWrath:Show(icon)
            end
            -- memory_of_lucid_dreams,if=!talent.seraphim.enabled|cooldown.seraphim.remains<=gcd|buff.seraphim.up
            if A.MemoryofLucidDreams:AutoHeartOfAzeroth(unit, true) and A.BurstIsON(unit) and Action.GetToggle(1, "HeartOfAzeroth") and (not A.Seraphim:IsSpellLearned() or A.Seraphim:GetCooldown() <= A.GetGCD() or Unit("player"):HasBuffs(A.SeraphimBuff.ID, true)) then
                return A.MemoryofLucidDreams:Show(icon)
            end
            -- bastion_of_light,if=cooldown.shield_of_the_righteous.charges_fractional<=0.5
            if A.BastionofLight:IsReady(unit) and (A.ShieldoftheRighteous:GetSpellChargesFrac() <= 0.5) and A.BurstIsON(unit) then
                return A.BastionofLight:Show(icon)
            end
            -- potion,if=buff.avenging_wrath.up
            if A.SuperiorSteelskinPotion:IsReady(unit) and Action.GetToggle(1, "Potion") and (Unit("player"):HasBuffs(A.AvengingWrathBuff.ID, true) > 0) then
                return A.SuperiorSteelskinPotion:Show(icon)
            end
            -- use_items,if=buff.seraphim.up|!talent.seraphim.enabled
            -- use_item,name=grongs_primal_rage,if=cooldown.judgment.full_recharge_time>4&cooldown.avengers_shield.remains>4&(buff.seraphim.up|cooldown.seraphim.remains+4+gcd>expected_combat_length-time)&consecration.up
            if A.GrongsPrimalRage:IsReady(unit) and (A.Judgment:GetSpellChargesFullRechargeTime() > 4 and A.AvengersShield:GetCooldown() > 4 and (Unit("player"):HasBuffs(A.SeraphimBuff.ID, true) or A.Seraphim:GetCooldown() + 4 + A.GetGCD() > expected_combat_length - combatTime) and Unit("player"):HasBuffs(A.ConsecrationBuff.ID, true)) then
                return A.GrongsPrimalRage:Show(icon)
            end
            -- use_item,name=pocketsized_computation_device,if=cooldown.judgment.full_recharge_time>4*spell_haste&cooldown.avengers_shield.remains>4*spell_haste&(!equipped.grongs_primal_rage|!trinket.grongs_primal_rage.cooldown.up)&consecration.up
            if A.PocketsizedComputationDevice:IsReady(unit) and (A.Judgment:GetSpellChargesFullRechargeTime() > 4 * Player:SpellHaste() and A.AvengersShield:GetCooldown() > 4 * Player:SpellHaste() and Unit("player"):HasBuffs(A.ConsecrationBuff.ID, true) > 0) then
                return A.PocketsizedComputationDevice:Show(icon)
            end
            -- use_item,name=merekthas_fang,if=!buff.avenging_wrath.up&(buff.seraphim.up|!talent.seraphim.enabled)
            if A.MerekthasFang:IsReady(unit) and (not Unit("player"):HasBuffs(A.AvengingWrathBuff.ID, true) and (Unit("player"):HasBuffs(A.SeraphimBuff.ID, true) or not A.Seraphim:IsSpellLearned())) then
                return A.MerekthasFang:Show(icon)
            end
            -- use_item,name=razdunks_big_red_button
            if A.RazdunksBigRedButton:IsReady(unit) then
                return A.RazdunksBigRedButton:Show(icon)
            end
        end
        
        
        -- call precombat
        if Precombat(unit) and not inCombat and Unit(unit):IsExists() and unit ~= "mouseover" then 
            return true
        end

        -- In Combat
        if inCombat and Unit(unit):IsExists() then

			-- VigilantProtector
            if A.VigilantProtector:AutoHeartOfAzeroth(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") then
                return A.VigilantProtector:Show(icon)
            end

		    -- Taunt HandofReckoning
            if A.GetToggle(2, "AutoTaunt") 
			and combatTime > 0     
			then 
			    -- if not fully aggroed or we are not current target then use taunt
			    if A.HandofReckoning:IsReady(unit, true, nil, nil, nil) and not Unit(unit):IsBoss() and Unit(unit):GetRange() <= 30 and ( Unit("targettarget"):InfoGUID() ~= Unit("player"):InfoGUID() ) then 
                    return A.HandofReckoning:Show(icon)
				-- else if all good on current target, switch to another one we know we dont currently tank
                else
                    local HandofReckoning_Nameplates = MultiUnits:GetActiveUnitPlates()
                    if HandofReckoning_Nameplates then  
                        for HandofReckoning_UnitID in pairs(HandofReckoning_Nameplates) do             
                            if not UnitIsUnit("target", HandofReckoning_UnitID) and A.HandofReckoning:IsReady(HandofReckoning_UnitID, true, nil, nil, nil) and not Unit(HandofReckoning_UnitID):IsBoss() and Unit(HandofReckoning_UnitID):GetRange() <= 30 and not Unit(HandofReckoning_UnitID):InLOS() and Unit("player"):ThreatSituation(HandofReckoning_UnitID) ~= 3 then 
                                return A:Show(icon, ACTION_CONST_AUTOTARGET)
                            end         
                        end 
                    end
				end
            end
			
			-- Interrupt
            local Interrupt = Interrupts(unit)
            if Interrupt then 
                return Interrupt:Show(icon)
            end	
            
			-- auto_attack
            -- call_action_list,name=cooldowns
            if Cooldowns(unit) then
                return true
            end
			
			-- Non SIMC Custom Trinket1
	   		 if Action.GetToggle(1, "Trinkets")[1] and A.Trinket1:IsReady("target") and Trinket1IsAllowed then	    
       	    	if A.Trinket1:AbsentImun(unit, "DamageMagicImun")  then 
      	   	    	return A.Trinket1:Show(icon)
   	        	end 		
	    	end
		
			-- Non SIMC Custom Trinket2
	    	if Action.GetToggle(1, "Trinkets")[2] and A.Trinket2:IsReady("target") and Trinket2IsAllowed then	    
       	    	if A.Trinket2:AbsentImun(unit, "DamageMagicImun")  then 
      	   	    	return A.Trinket2:Show(icon)
   	        	end 	
	    	end
			
            -- worldvein_resonance,if=buff.lifeblood.stack<3
            if A.WorldveinResonance:AutoHeartOfAzeroth(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") and (Unit("player"):HasBuffsStacks(A.LifebloodBuff.ID, true) < 3) then
                return A.WorldveinResonance:Show(icon)
            end
			
            -- shield_of_the_righteous,if=(buff.avengers_valor.up&cooldown.shield_of_the_righteous.charges_fractional>=2.5)&(cooldown.seraphim.remains>gcd|!talent.seraphim.enabled)
            if A.ShieldoftheRighteous:IsReady("player") and ((Unit("player"):HasBuffs(A.AvengersValorBuff.ID, true) > 0 and A.ShieldoftheRighteous:GetSpellChargesFrac() >= 2.5) and (A.Seraphim:GetCooldown() > A.GetGCD() or not A.Seraphim:IsSpellLearned())) then
                return A.ShieldoftheRighteous:Show(icon)
            end
			
            -- shield_of_the_righteous,if=(buff.avenging_wrath.up&!talent.seraphim.enabled)|buff.seraphim.up&buff.avengers_valor.up
            if A.ShieldoftheRighteous:IsReady("player") and ((Unit("player"):HasBuffs(A.AvengingWrathBuff.ID, true) > 0 and not A.Seraphim:IsSpellLearned()) or Unit("player"):HasBuffs(A.SeraphimBuff.ID, true) > 0 and Unit("player"):HasBuffs(A.AvengersValorBuff.ID, true) > 0) then
                return A.ShieldoftheRighteous:Show(icon)
            end
			
            -- shield_of_the_righteous,if=(buff.avenging_wrath.up&buff.avenging_wrath.remains<4&!talent.seraphim.enabled)|(buff.seraphim.remains<4&buff.seraphim.up)
            if A.ShieldoftheRighteous:IsReady("player") and ((Unit("player"):HasBuffs(A.AvengingWrathBuff.ID, true) > 0 and Unit("player"):HasBuffs(A.AvengingWrathBuff.ID, true) < 4 and not A.Seraphim:IsSpellLearned()) or (Unit("player"):HasBuffs(A.SeraphimBuff.ID, true) < 4 and Unit("player"):HasBuffs(A.SeraphimBuff.ID, true) > 0)) then
                return A.ShieldoftheRighteous:Show(icon)
            end
			
            -- lights_judgment,if=buff.seraphim.up&buff.seraphim.remains<3
            if A.LightsJudgment:IsReady(unit) and A.BurstIsON(unit) and (Unit("player"):HasBuffs(A.SeraphimBuff.ID, true) > 0 and Unit("player"):HasBuffs(A.SeraphimBuff.ID, true) < 3) then
                return A.LightsJudgment:Show(icon)
            end
			
            -- consecration,if=!consecration.up
            if A.Consecration:IsReady("player") and (Unit("player"):HasBuffs(A.ConsecrationBuff.ID, true) == 0) then
                return A.Consecration:Show(icon)
            end
			
            -- judgment,if=(cooldown.judgment.remains<gcd&cooldown.judgment.charges_fractional>1&cooldown_react)|!talent.crusaders_judgment.enabled
            if A.Judgment:IsReady(unit) and ((A.Judgment:GetCooldown() < A.GetGCD() and A.Judgment:GetSpellChargesFrac() > 1 and A.Judgment:GetCooldown() == 0) or not A.CrusadersJudgment:IsSpellLearned()) then
                return A.Judgment:Show(icon)
            end
			
            -- avengers_shield,if=cooldown_react
            if A.AvengersShield:IsReady(unit) and (A.AvengersShield:GetCooldown() == 0) then
                return A.AvengersShield:Show(icon)
            end
			
            -- judgment,if=cooldown_react|!talent.crusaders_judgment.enabled
            if A.Judgment:IsReady(unit) and (A.Judgment:GetCooldown() == 0 or not A.CrusadersJudgment:IsSpellLearned()) then
                return A.Judgment:Show(icon)
            end
			
            -- concentrated_flame,if=(!talent.seraphim.enabled|buff.seraphim.up)&!dot.concentrated_flame_burn.remains>0|essence.the_crucible_of_flame.rank<3
            if A.ConcentratedFlame:AutoHeartOfAzeroth(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") and ((not A.Seraphim:IsSpellLearned() or Unit("player"):HasBuffs(A.SeraphimBuff.ID, true) > 0)) then
                return A.ConcentratedFlame:Show(icon)
            end
			
            -- lights_judgment,if=!talent.seraphim.enabled|buff.seraphim.up
            if A.LightsJudgment:IsReady(unit) and A.BurstIsON(unit) and (not A.Seraphim:IsSpellLearned() or Unit("player"):HasBuffs(A.SeraphimBuff.ID, true)) then
                return A.LightsJudgment:Show(icon)
            end
			
            -- anima_of_death
            if A.AnimaofDeath:AutoHeartOfAzeroth(unit, true) then
                return A.AnimaofDeath:Show(icon)
            end
			
            -- blessed_hammer,strikes=3
            if A.BlessedHammer:IsReady(unit) then
                return A.BlessedHammer:Show(icon)
            end
			
            -- hammer_of_the_righteous
            if A.HammeroftheRighteous:IsReady(unit) then
                return A.HammeroftheRighteous:Show(icon)
            end
			
            -- consecration
            if A.Consecration:IsReady("player") then
                return A.Consecration:Show(icon)
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
end ]]--

local function ArenaRotation(icon, unit)
    if A.IsInPvP and (A.Zone == "pvp" or A.Zone == "arena") and not Player:IsStealthed() and not Player:IsMounted() then
        -- Note: "arena1" is just identification of meta 6
        if unit == "arena1" and (Unit("player"):GetDMG() == 0 or not Unit("player"):IsFocused("DAMAGER")) then 
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

  	-- BlessingofFreedomYellow
    if A.BlessingofFreedomYellow:IsCastable() and Unit(unit):HasDeBuffs("Rooted") > 0 and not Unit(unit):InLOS() then
        return A.BlessingofFreedomYellow
    end
	
  	-- BlessingofProtectionYellow
    if A.BlessingofProtectionYellow:IsCastable() and not Unit(unit):InLOS() and 	
	    Unit(unit):HasBuffs("DeffBuffs") == 0 
	    or  
	   -- HP lose per sec >= 20
        Unit("player"):GetDMG() * 100 / Unit("player"):HealthMax() >= 20 
		or 
        Unit("player"):GetRealTimeDMG() >= Unit("player"):HealthMax() * 0.20 
		or 
        -- TTD 
        Unit("player"):TimeToDieX(10) < 3 
	then
        return A.BlessingofProtectionYellow
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

