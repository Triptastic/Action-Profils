-----------------------------
-- Taste TMW Action Rotation
-----------------------------

local TMW = TMW 
local CNDT = TMW.CNDT 
local Env = CNDT.Env
local Action = Action
local TeamCache = Action.TeamCache
local EnemyTeam = Action.EnemyTeam
local FriendlyTeam = Action.FriendlyTeam
--local HealingEngine = Action.HealingEngine
local LoC = Action.LossOfControl
local ActionPlayer = Action.Player 
local MultiUnits = Action.MultiUnits
local UnitCooldown = Action.UnitCooldown
local ActionUnit = Action.Unit 
--local Pet = LibStub("PetLibrary")
--local Azerite = LibStub("AzeriteTraits")
local TR                                     = Action.TasteRotation

Action[ACTION_CONST_MAGE_FIRE] = {
    -- Racials
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
    -- Generics Spells    
    ArcaneIntellect                      = Action.Create({ Type = "Spell", ID = 1459}),
    MirrorImage                          = Action.Create({ Type = "Spell", ID = 55342}),
    Pyroblast                            = Action.Create({ Type = "Spell", ID = 11366}),
    LivingBomb                           = Action.Create({ Type = "Spell", ID = 44457}),    
    Combustion                           = Action.Create({ Type = "Spell", ID = 190319}),
    Meteor                               = Action.Create({ Type = "Spell", ID = 153561}),    
    RuneofPower                          = Action.Create({ Type = "Spell", ID = 116011}),
    Firestarter                          = Action.Create({ Type = "Spell", ID = 205026}),
    LightsJudgment                       = Action.Create({ Type = "Spell", ID = 255647}),
    FireBlast                            = Action.Create({ Type = "Spell", ID = 108853}),    
    Fireball                             = Action.Create({ Type = "Spell", ID = 133}),
    BlasterMaster                        = Action.Create({ Type = "Spell", ID = 274596}),
    BloodFury                            = Action.Create({ Type = "Spell", ID = 20572}),
    Berserking                           = Action.Create({ Type = "Spell", ID = 26297}),
    Fireblood                            = Action.Create({ Type = "Spell", ID = 265221}),
    AncestralCall                        = Action.Create({ Type = "Spell", ID = 274738}),
    Scorch                               = Action.Create({ Type = "Spell", ID = 2948}),
    PhoenixFlames                        = Action.Create({ Type = "Spell", ID = 257541}),
    DragonsBreath                        = Action.Create({ Type = "Spell", ID = 31661}),
    FlameOn                              = Action.Create({ Type = "Spell", ID = 205029}),
    Flamestrike                          = Action.Create({ Type = "Spell", ID = 2120}),
    FlamePatch                           = Action.Create({ Type = "Spell", ID = 205037}),
    SearingTouch                         = Action.Create({ Type = "Spell", ID = 269644}),
    AlexstraszasFury                     = Action.Create({ Type = "Spell", ID = 235870}),
    Kindling                             = Action.Create({ Type = "Spell", ID = 155148}),
    -- Utilities
    Counterspell                         = Action.Create({ Type = "Spell", ID = 2139}),
    Spellsteal                           = Action.Create({ Type = "Spell", ID = 30449}),
	Polymorph                            = Action.Create({ Type = "Spell", ID = 118}),
	-- Defensives
    IceBlock                             = Action.Create({ Type = "Spell", ID = 45438}),
    BlazingBarrier                       = Action.Create({ Type = "Spell", ID = 235313}),
    -- Misc
    Channeling                           = Action.Create({ Type = "Spell", ID = 209274, Hidden = true     }),
    RecklessForceBuff                    = Action.Create({ Type = "Spell", ID = 302932, Hidden = true     }),
    ConcentratedFlameBurn                = Action.Create({ Type = "Spell", ID = 295368, Hidden = true     }),
    CyclotronicBlast                     = Action.Create({ Type = "Spell", ID = 167672, Hidden = true     }),
    HarmonicDematerializer               = Action.Create({ Type = "Spell", ID = 293512, Hidden = true     }),
    -- Buffs
    ArcaneIntellectBuff                  = Action.Create({ Type = "Spell", ID = 1459, Hidden = true     }),
	CombustionBuff                       = Action.Create({ Type = "Spell", ID = 190319, Hidden = true     }),
	RuneofPowerBuff                      = Action.Create({ Type = "Spell", ID = 116014, Hidden = true     }),
	BlasterMasterBuff                    = Action.Create({ Type = "Spell", ID = 274598, Hidden = true     }),
    HeatingUpBuff                        = Action.Create({ Type = "Spell", ID = 48107, Hidden = true     }),
    HotStreakBuff                        = Action.Create({ Type = "Spell", ID = 48108, Hidden = true     }),
    PyroclasmBuff                        = Action.Create({ Type = "Spell", ID = 269651, Hidden = true     }),
    -- Debuffs 

    -- Potions
    PotionofUnbridledFury                = Action.Create({ Type = "Potion", ID = 169299, QueueForbidden = true }),
    -- Trinkets
	
    
    TidestormCodex                       = Action.Create({ Type = "Trinket", ID = 165576, QueueForbidden = true }),
    MalformedHeraldsLegwraps             = Action.Create({ Type = "Trinket", ID = 167835, QueueForbidden = true }),
    PocketsizedComputationDevice         = Action.Create({ Type = "Trinket", ID = 167555, QueueForbidden = true }),
    AzsharasFontofPower                  = Action.Create({ Type = "Trinket", ID = 169314, QueueForbidden = true }),
    RotcrustedVoodooDoll                 = Action.Create({ Type = "Trinket", ID = 159624, QueueForbidden = true }),
    AquipotentNautilus                   = Action.Create({ Type = "Trinket", ID = 169305, QueueForbidden = true }),
    ShiverVenomRelic                     = Action.Create({ Type = "Trinket", ID = 168905, QueueForbidden = true }),
    HyperthreadWristwraps                = Action.Create({ Type = "Trinket", ID = 168989, QueueForbidden = true }),
    NotoriousAspirantsBadge              = Action.Create({ Type = "Trinket", ID = 167528, QueueForbidden = true }),
    NotoriousGladiatorsBadge             = Action.Create({ Type = "Trinket", ID = 167380, QueueForbidden = true }),
    SinisterGladiatorsBadge              = Action.Create({ Type = "Trinket", ID = 165058, QueueForbidden = true }),
    SinisterAspirantsBadge               = Action.Create({ Type = "Trinket", ID = 165223, QueueForbidden = true }),
    DreadGladiatorsBadge                 = Action.Create({ Type = "Trinket", ID = 161902, QueueForbidden = true }),
    DreadAspirantsBadge                  = Action.Create({ Type = "Trinket", ID = 162966, QueueForbidden = true }),
    DreadCombatantsInsignia              = Action.Create({ Type = "Trinket", ID = 161676, QueueForbidden = true }),
    NotoriousAspirantsMedallion          = Action.Create({ Type = "Trinket", ID = 167525, QueueForbidden = true }),
    NotoriousGladiatorsMedallion         = Action.Create({ Type = "Trinket", ID = 167377, QueueForbidden = true }),
    SinisterGladiatorsMedallion          = Action.Create({ Type = "Trinket", ID = 165055, QueueForbidden = true }),
    SinisterAspirantsMedallion           = Action.Create({ Type = "Trinket", ID = 165220, QueueForbidden = true }),
    DreadGladiatorsMedallion             = Action.Create({ Type = "Trinket", ID = 161674, QueueForbidden = true }),
    DreadAspirantsMedallion              = Action.Create({ Type = "Trinket", ID = 162897, QueueForbidden = true }),
    DreadCombatantsMedallion             = Action.Create({ Type = "Trinket", ID = 161811, QueueForbidden = true }),
    IgnitionMagesFuse                    = Action.Create({ Type = "Trinket", ID = 159615, QueueForbidden = true }),
    TzanesBarkspines                     = Action.Create({ Type = "Trinket", ID = 161411, QueueForbidden = true }),
    AzurethoseSingedPlumage              = Action.Create({ Type = "Trinket", ID = 161377, QueueForbidden = true }),
    AncientKnotofWisdomAlliance          = Action.Create({ Type = "Trinket", ID = 161417, QueueForbidden = true }),
    AncientKnotofWisdomHorde             = Action.Create({ Type = "Trinket", ID = 166793, QueueForbidden = true }),
    ShockbitersFang                      = Action.Create({ Type = "Trinket", ID = 169318, QueueForbidden = true }),
    NeuralSynapseEnhancer                = Action.Create({ Type = "Trinket", ID = 168973, QueueForbidden = true }),
    BalefireBranch                       = Action.Create({ Type = "Trinket", ID = 159630, QueueForbidden = true }),
    -- Misc
    CyclotronicBlast                     = Action.Create({ Type = "Spell", ID = 293491, Hidden = true}),
    -- Hidden Heart of Azeroth
    VisionofPerfectionMinor              = Action.Create({ Type = "Spell", ID = 296320, Hidden = true}),
    VisionofPerfectionMinor2             = Action.Create({ Type = "Spell", ID = 299367, Hidden = true}),
    VisionofPerfectionMinor3             = Action.Create({ Type = "Spell", ID = 299369, Hidden = true}),
	MemoryofLucidDreamsMinor             = Action.Create({ Type = "Spell", ID = 298268, Hidden = true}),
    MemoryofLucidDreamsMinor2            = Action.Create({ Type = "Spell", ID = 299371, Hidden = true}),
    MemoryofLucidDreamsMinor3            = Action.Create({ Type = "Spell", ID = 299373, Hidden = true}),
    UnleashHeartOfAzeroth                = Action.Create({ Type = "Spell", ID = 280431, Hidden = true}),
    BloodoftheEnemy                      = Action.Create({ Type = "HeartOfAzeroth", ID = 297108, Hidden = true}),
    BloodoftheEnemy2                     = Action.Create({ Type = "HeartOfAzeroth", ID = 298273, Hidden = true}),
    BloodoftheEnemy3                     = Action.Create({ Type = "HeartOfAzeroth", ID = 298277, Hidden = true}),
    ConcentratedFlame                    = Action.Create({ Type = "HeartOfAzeroth", ID = 295373, Hidden = true}),
    ConcentratedFlame2                   = Action.Create({ Type = "HeartOfAzeroth", ID = 299349, Hidden = true}),
    ConcentratedFlame3                   = Action.Create({ Type = "HeartOfAzeroth", ID = 299353, Hidden = true}),
    GuardianofAzeroth                    = Action.Create({ Type = "HeartOfAzeroth", ID = 295840, Hidden = true}),
    GuardianofAzeroth2                   = Action.Create({ Type = "HeartOfAzeroth", ID = 299355, Hidden = true}),
    GuardianofAzeroth3                   = Action.Create({ Type = "HeartOfAzeroth", ID = 295840, Hidden = true}),
    FocusedAzeriteBeam                   = Action.Create({ Type = "HeartOfAzeroth", ID = 295258, Hidden = true}),
    FocusedAzeriteBeam2                  = Action.Create({ Type = "HeartOfAzeroth", ID = 299336, Hidden = true}),
    FocusedAzeriteBeam3                  = Action.Create({ Type = "HeartOfAzeroth", ID = 299338, Hidden = true}),
    PurifyingBlast                       = Action.Create({ Type = "HeartOfAzeroth", ID = 295337, Hidden = true}),
    PurifyingBlast2                      = Action.Create({ Type = "HeartOfAzeroth", ID = 299345, Hidden = true}),
    PurifyingBlast3                      = Action.Create({ Type = "HeartOfAzeroth", ID = 299347, Hidden = true}),
    TheUnboundForce                      = Action.Create({ Type = "HeartOfAzeroth", ID = 298452, Hidden = true}),
    TheUnboundForce2                     = Action.Create({ Type = "HeartOfAzeroth", ID = 299376, Hidden = true}),
    TheUnboundForce3                     = Action.Create({ Type = "HeartOfAzeroth", ID = 299378, Hidden = true}),
    RippleInSpace                        = Action.Create({ Type = "HeartOfAzeroth", ID = 302731, Hidden = true}),
    RippleInSpace2                       = Action.Create({ Type = "HeartOfAzeroth", ID = 302982, Hidden = true}),
    RippleInSpace3                       = Action.Create({ Type = "HeartOfAzeroth", ID = 302983, Hidden = true}),
    WorldveinResonance                   = Action.Create({ Type = "HeartOfAzeroth", ID = 295186, Hidden = true}),
    WorldveinResonance2                  = Action.Create({ Type = "HeartOfAzeroth", ID = 298628, Hidden = true}),
    WorldveinResonance3                  = Action.Create({ Type = "HeartOfAzeroth", ID = 299334, Hidden = true}),
    MemoryofLucidDreams                  = Action.Create({ Type = "HeartOfAzeroth", ID = 298357, Hidden = true}),
    MemoryofLucidDreams2                 = Action.Create({ Type = "HeartOfAzeroth", ID = 299372, Hidden = true}),
    MemoryofLucidDreams3                 = Action.Create({ Type = "HeartOfAzeroth", ID = 299374, Hidden = true}),
    -- Here come all the stuff needed by simcraft but not classic spells or items. 
}

-- To create essences use next code:
Action:CreateEssencesFor(ACTION_CONST_MAGE_FIRE)        -- where PLAYERSPEC is Constance (example: ACTION_CONST_MONK_BM)

-- This code making shorter access to both tables Action[PLAYERSPEC] and Action
-- However if you prefer long access it still can be used like Action[PLAYERSPEC].Guard:IsReady(), it doesn't make any conflict if you will skip shorter access
-- So with shorter access you can just do A.Guard:IsReady() instead of Action[PLAYERSPEC].Guard:IsReady()
local A = setmetatable(Action[ACTION_CONST_MAGE_FIRE], { __index = Action })

-- Simcraft Imported
-- HeroLib
local HL         = HeroLib
local Cache      = HeroCache
local Unit       = HL.Unit
local Player     = Unit.Player
local Target     = Unit.Target
local Pet        = Unit.Pet
local Spell      = HL.Spell
local Item       = HL.Item
-- HeroRotation
local HR         = HeroRotation

---------------------------
-- PORT TO ACTION 
local S, I = A:HeroCreate()
Action.HeroSetHookAllTable(S, {
        [3] = "TellMeWhen_Group4_Icon3",
        [4] = "TellMeWhen_Group4_Icon4",
		[6] = "TellMeWhen_Group4_Icon6", 
})
Action.HeroSetHookAllTable(I, {
        [3] = "TellMeWhen_Group4_Icon3",
        [4] = "TellMeWhen_Group4_Icon4",
		[6] = "TellMeWhen_Group4_Icon6",
})
-- Adding manually missed staff
--S.Brews                                 = Spell(115308)
--S.BlackoutCombo                         = Spell(196736)
--S.BlackoutComboBuff                     = Spell(228563)

---------------------------

-- Rotation Var
local ShouldReturn; -- Used to get the return string
local ForceOffGCD = {true, false};
local Everyone = HR.Commons.Everyone;

-- Variables
local VarCombustionRopCutoff = 0;
local VarFireBlastPooling = 0;
local VarPhoenixPooling = 0;
local VarCombustionOnUse = 0;
local VarFontDoubleOnUse = 0;
local VarOnUseCutoff = 0;

HL:RegisterForEvent(function()
    VarCombustionRopCutoff = 0
    VarFireBlastPooling = 0
    VarPhoenixPooling = 0
    VarCombustionOnUse = 0
    VarFontDoubleOnUse = 0
    VarOnUseCutoff = 0
end, "PLAYER_REGEN_ENABLED")

local EnemyRanges = {40, 12}
local function UpdateRanges()
    for _, i in ipairs(EnemyRanges) do
        HL.GetEnemies(i);
    end
end

-- AoE Detection Mode
local function GetEnemiesCount(range)
    -- Unit Update - Update differently depending on if splash data is being used
    if HR.AoEON() then
        if Action.GetToggle(2, "AoeDetectionMode") == "USE COMBAT LOGS" then
	       return active_enemies()
	    elseif Action.GetToggle(2, "AoeDetectionMode") == "USE SPLASH DATA" then
	        HL.GetEnemies(range, nil, true, Target)
            return Cache.EnemiesCount[range]
	    else 
            UpdateRanges()
            return Cache.EnemiesCount[40]
        end
    else
        return 1
    end
end

local function num(val)
  if val then return 1 else return 0 end
end

local function bool(val)
  return val ~= 0
end

S.Pyroblast:RegisterInFlight()
S.Fireball:RegisterInFlight()
S.Meteor:RegisterInFlight()
S.PhoenixFlames:RegisterInFlight();
S.Pyroblast:RegisterInFlight(S.CombustionBuff);
S.Fireball:RegisterInFlight(S.CombustionBuff);

function S.Firestarter:ActiveStatus()
    return (S.Firestarter:IsAvailable() and (Target:HealthPercentage() > 90)) and 1 or 0
end

function S.Firestarter:ActiveRemains()
    return S.Firestarter:IsAvailable() and ((Target:HealthPercentage() > 90) and Target:TimeToX(90, 3) or 0) or 0
end

local function DetermineEssenceRanks()
    S.BloodoftheEnemy = S.BloodoftheEnemy2:IsAvailable() and S.BloodoftheEnemy2 or S.BloodoftheEnemy
    S.BloodoftheEnemy = S.BloodoftheEnemy3:IsAvailable() and S.BloodoftheEnemy3 or S.BloodoftheEnemy
    S.MemoryofLucidDreams = S.MemoryofLucidDreams2:IsAvailable() and S.MemoryofLucidDreams2 or S.MemoryofLucidDreams
    S.MemoryofLucidDreams = S.MemoryofLucidDreams3:IsAvailable() and S.MemoryofLucidDreams3 or S.MemoryofLucidDreams
    S.PurifyingBlast = S.PurifyingBlast2:IsAvailable() and S.PurifyingBlast2 or S.PurifyingBlast
    S.PurifyingBlast = S.PurifyingBlast3:IsAvailable() and S.PurifyingBlast3 or S.PurifyingBlast
    S.RippleInSpace = S.RippleInSpace2:IsAvailable() and S.RippleInSpace2 or S.RippleInSpace
    S.RippleInSpace = S.RippleInSpace3:IsAvailable() and S.RippleInSpace3 or S.RippleInSpace
    S.ConcentratedFlame = S.ConcentratedFlame2:IsAvailable() and S.ConcentratedFlame2 or S.ConcentratedFlame
    S.ConcentratedFlame = S.ConcentratedFlame3:IsAvailable() and S.ConcentratedFlame3 or S.ConcentratedFlame
    S.TheUnboundForce = S.TheUnboundForce2:IsAvailable() and S.TheUnboundForce2 or S.TheUnboundForce
    S.TheUnboundForce = S.TheUnboundForce3:IsAvailable() and S.TheUnboundForce3 or S.TheUnboundForce
    S.WorldveinResonance = S.WorldveinResonance2:IsAvailable() and S.WorldveinResonance2 or S.WorldveinResonance
    S.WorldveinResonance = S.WorldveinResonance3:IsAvailable() and S.WorldveinResonance3 or S.WorldveinResonance
    S.FocusedAzeriteBeam = S.FocusedAzeriteBeam2:IsAvailable() and S.FocusedAzeriteBeam2 or S.FocusedAzeriteBeam
    S.FocusedAzeriteBeam = S.FocusedAzeriteBeam3:IsAvailable() and S.FocusedAzeriteBeam3 or S.FocusedAzeriteBeam
    S.VisionofPerfectionMinor = S.VisionofPerfectionMinor2:IsAvailable() and S.VisionofPerfectionMinor2 or S.VisionofPerfectionMinor
    S.VisionofPerfectionMinor = S.VisionofPerfectionMinor3:IsAvailable() and S.VisionofPerfectionMinor3 or S.VisionofPerfectionMinor
    S.GuardianofAzeroth = S.GuardianofAzeroth2:IsAvailable() and S.GuardianofAzeroth2 or S.GuardianofAzeroth
    S.GuardianofAzeroth = S.GuardianofAzeroth3:IsAvailable() and S.GuardianofAzeroth3 or S.GuardianofAzeroth
    S.MemoryofLucidDreamsMinor = S.MemoryofLucidDreamsMinor2:IsAvailable() and S.MemoryofLucidDreamsMinor2 or S.MemoryofLucidDreamsMinor
    S.MemoryofLucidDreamsMinor = S.MemoryofLucidDreamsMinor3:IsAvailable() and S.MemoryofLucidDreamsMinor3 or S.MemoryofLucidDreamsMinor
end

local function num(val)
    if val then return 1 else return 0 end
end

local function bool(val)
    return val ~= 0
end

-- Initiate Nucleus Ability registration
local function Init()
  HL.RegisterNucleusAbility(157981, 8, 6)               -- Blast Wave
  HL.RegisterNucleusAbility(153561, 8, 6)               -- Meteor
  HL.RegisterNucleusAbility(31661, 8, 6)                -- Dragon's Breath
  HL.RegisterNucleusAbility(44457, 10, 6)               -- Living Bomb
  HL.RegisterNucleusAbility(2120, 8, 6)                 -- Flamestrike
  HL.RegisterNucleusAbility(257541, 8, 6)               -- Phoenix Flames
end
-- Init data for splash data (To Check)
Init()

--- ======= ACTION LISTS =======
local function APL(icon) 
    
	-- Action specifics remap
	local ShouldStop = Action.ShouldStop()
	local Pull = Action.BossMods_Pulling()
	
	-- Local functions remap
    EnemiesCount = GetEnemiesCount(40)
    HL.GetEnemies(40, 12) -- For interrupts
    DetermineEssenceRanks()
	UpdateRanges()
	
	local function Precombat_DBM()
        -- flask
        -- food
        -- augmentation
		if Everyone.TargetIsValid() then
        -- arcane_intellect
         if S.ArcaneIntellect:IsCastableP() and not ShouldStop and Player:BuffDownP(S.ArcaneIntellectBuff, true) then
            if HR.Cast(S.ArcaneIntellect) then return "arcane_intellect 3"; end
        end
        -- variable,name=combustion_rop_cutoff,op=set,value=60
        if (true) then
            VarCombustionRopCutoff = 60
        end
        -- variable,name=combustion_on_use,op=set,value=equipped.notorious_aspirants_badge|equipped.notorious_gladiators_badge|equipped.sinister_gladiators_badge|equipped.sinister_aspirants_badge|equipped.dread_gladiators_badge|equipped.dread_aspirants_badge|equipped.dread_combatants_insignia|equipped.notorious_aspirants_medallion|equipped.notorious_gladiators_medallion|equipped.sinister_gladiators_medallion|equipped.sinister_aspirants_medallion|equipped.dread_gladiators_medallion|equipped.dread_aspirants_medallion|equipped.dread_combatants_medallion|equipped.ignition_mages_fuse|equipped.tzanes_barkspines|equipped.azurethos_singed_plumage|equipped.ancient_knot_of_wisdom|equipped.shockbiters_fang|equipped.neural_synapse_enhancer|equipped.balefire_branch
        if (true) then
            VarCombustionOnUse = num(I.NotoriousAspirantsBadge:IsEquipped() or I.NotoriousGladiatorsBadge:IsEquipped() or I.SinisterGladiatorsBadge:IsEquipped() or I.SinisterAspirantsBadge:IsEquipped() or I.DreadGladiatorsBadge:IsEquipped() or I.DreadAspirantsBadge:IsEquipped() or I.DreadCombatantsInsignia:IsEquipped() or I.NotoriousAspirantsMedallion:IsEquipped() or I.NotoriousGladiatorsMedallion:IsEquipped() or I.SinisterGladiatorsMedallion:IsEquipped() or I.SinisterAspirantsMedallion:IsEquipped() or I.DreadGladiatorsMedallion:IsEquipped() or I.DreadAspirantsMedallion:IsEquipped() or I.DreadCombatantsMedallion:IsEquipped() or I.IgnitionMagesFuse:IsEquipped() or I.TzanesBarkspines:IsEquipped() or I.AzurethoseSingedPlumage:IsEquipped() or I.AncientKnotofWisdomAlliance:IsEquipped() or I.AncientKnotofWisdomHorde:IsEquipped() or I.ShockbitersFang:IsEquipped() or I.NeuralSynapseEnhancer:IsEquipped() or I.BalefireBranch:IsEquipped())
        end
        -- variable,name=font_double_on_use,op=set,value=equipped.azsharas_font_of_power&variable.combustion_on_use
        if (true) then
            VarFontDoubleOnUse = num(I.AzsharasFontofPower:IsEquipped() and bool(VarCombustionOnUse))
        end
        -- variable,name=on_use_cutoff,op=set,value=20*variable.combustion_on_use&!variable.font_double_on_use+40*variable.font_double_on_use+25*equipped.azsharas_font_of_power&!variable.font_double_on_use
        if (true) then
            VarOnUseCutoff = 20 * num(bool(VarCombustionOnUse) and not bool(VarFontDoubleOnUse)) + 40 * VarFontDoubleOnUse + 25 * num(I.AzsharasFontofPower:IsEquipped() and not bool(VarFontDoubleOnUse))
        end
        -- snapshot_stats
        -- use_item,name=azsharas_font_of_power
        if I.AzsharasFontofPower:IsEquipped() and I.AzsharasFontofPower:IsReady() and TR.TrinketON() and Pull > 2 and Pull <= I.AzsharasFontofPower:CastTime() then
            if HR.Cast(I.AzsharasFontofPower) then return "azsharas_font_of_power 9"; end
        end
        -- mirror_image
        if S.MirrorImage:IsCastableP() and not ShouldStop and Pull > 1 and Pull <= 2 then
            if HR.Cast(S.MirrorImage) then return "mirror_image 10"; end
        end
        -- potion
        if I.PotionofUnbridledFury:IsReady() and Action.GetToggle(1, "Potion") then
            if HR.Cast(I.PotionofUnbridledFury) then return "battle_potion_of_intellect 12"; end
        end
        -- pyroblast
        if S.Pyroblast:IsCastableP() and not Player:PrevGCDP(1, S.Pyroblast) and Pull > 0 and Pull <= (S.Pyroblast:CastTime() + S.Pyroblast:TravelTime()) and not ShouldStop then
            if HR.Cast(S.Pyroblast) then return "pyroblast 14"; end
        end
		end
    end

	local function Precombat()
        -- flask
        -- food
        -- augmentation
		if Everyone.TargetIsValid() then
        -- arcane_intellect
         if S.ArcaneIntellect:IsCastableP() and not ShouldStop and Player:BuffDownP(S.ArcaneIntellectBuff, true) then
            if HR.Cast(S.ArcaneIntellect) then return "arcane_intellect 3"; end
        end
        -- variable,name=combustion_rop_cutoff,op=set,value=60
        if (true) then
            VarCombustionRopCutoff = 60
        end
        -- variable,name=combustion_on_use,op=set,value=equipped.notorious_aspirants_badge|equipped.notorious_gladiators_badge|equipped.sinister_gladiators_badge|equipped.sinister_aspirants_badge|equipped.dread_gladiators_badge|equipped.dread_aspirants_badge|equipped.dread_combatants_insignia|equipped.notorious_aspirants_medallion|equipped.notorious_gladiators_medallion|equipped.sinister_gladiators_medallion|equipped.sinister_aspirants_medallion|equipped.dread_gladiators_medallion|equipped.dread_aspirants_medallion|equipped.dread_combatants_medallion|equipped.ignition_mages_fuse|equipped.tzanes_barkspines|equipped.azurethos_singed_plumage|equipped.ancient_knot_of_wisdom|equipped.shockbiters_fang|equipped.neural_synapse_enhancer|equipped.balefire_branch
        if (true) then
            VarCombustionOnUse = num(I.NotoriousAspirantsBadge:IsEquipped() or I.NotoriousGladiatorsBadge:IsEquipped() or I.SinisterGladiatorsBadge:IsEquipped() or I.SinisterAspirantsBadge:IsEquipped() or I.DreadGladiatorsBadge:IsEquipped() or I.DreadAspirantsBadge:IsEquipped() or I.DreadCombatantsInsignia:IsEquipped() or I.NotoriousAspirantsMedallion:IsEquipped() or I.NotoriousGladiatorsMedallion:IsEquipped() or I.SinisterGladiatorsMedallion:IsEquipped() or I.SinisterAspirantsMedallion:IsEquipped() or I.DreadGladiatorsMedallion:IsEquipped() or I.DreadAspirantsMedallion:IsEquipped() or I.DreadCombatantsMedallion:IsEquipped() or I.IgnitionMagesFuse:IsEquipped() or I.TzanesBarkspines:IsEquipped() or I.AzurethoseSingedPlumage:IsEquipped() or I.AncientKnotofWisdomAlliance:IsEquipped() or I.AncientKnotofWisdomHorde:IsEquipped() or I.ShockbitersFang:IsEquipped() or I.NeuralSynapseEnhancer:IsEquipped() or I.BalefireBranch:IsEquipped())
        end
        -- variable,name=font_double_on_use,op=set,value=equipped.azsharas_font_of_power&variable.combustion_on_use
        if (true) then
            VarFontDoubleOnUse = num(I.AzsharasFontofPower:IsEquipped() and bool(VarCombustionOnUse))
        end
        -- variable,name=on_use_cutoff,op=set,value=20*variable.combustion_on_use&!variable.font_double_on_use+40*variable.font_double_on_use+25*equipped.azsharas_font_of_power&!variable.font_double_on_use
        if (true) then
            VarOnUseCutoff = 20 * num(bool(VarCombustionOnUse) and not bool(VarFontDoubleOnUse)) + 40 * VarFontDoubleOnUse + 25 * num(I.AzsharasFontofPower:IsEquipped() and not bool(VarFontDoubleOnUse))
        end
        -- snapshot_stats
        -- use_item,name=azsharas_font_of_power
        if I.AzsharasFontofPower:IsEquipped() and I.AzsharasFontofPower:IsReady() and TR.TrinketON() then
            if HR.Cast(I.AzsharasFontofPower) then return "azsharas_font_of_power 9"; end
        end
        -- mirror_image
        if S.MirrorImage:IsCastableP() and not ShouldStop then
            if HR.Cast(S.MirrorImage) then return "mirror_image 10"; end
        end
        -- potion
        if I.PotionofUnbridledFury:IsReady() and Action.GetToggle(1, "Potion") then
            if HR.Cast(I.PotionofUnbridledFury) then return "battle_potion_of_intellect 12"; end
        end
        -- pyroblast
        if S.Pyroblast:IsCastableP() and not ShouldStop then
            if HR.Cast(S.Pyroblast) then return "pyroblast 14"; end
        end
		end
    end
	
    local function ActiveTalents()
        -- living_bomb,if=active_enemies>1&buff.combustion.down&(cooldown.combustion.remains>cooldown.living_bomb.duration|cooldown.combustion.ready)
        if S.LivingBomb:IsCastableP() and not ShouldStop and (EnemiesCount > 1 and Player:BuffDownP(S.CombustionBuff) and (S.Combustion:CooldownRemainsP() > S.LivingBomb:BaseDuration() or S.Combustion:CooldownUpP())) then
            if HR.Cast(S.LivingBomb) then return "living_bomb 16"; end
        end
        -- meteor,if=buff.rune_of_power.up&(firestarter.remains>cooldown.meteor.duration|!firestarter.active)|cooldown.rune_of_power.remains>target.time_to_die&action.rune_of_power.charges<1|(cooldown.meteor.duration<cooldown.combustion.remains|cooldown.combustion.ready)&!talent.rune_of_power.enabled&(cooldown.meteor.duration<firestarter.remains|!talent.firestarter.enabled|!firestarter.active)
        if S.Meteor:IsCastableP() and not ShouldStop and (Player:BuffP(S.RuneofPowerBuff) and (S.Firestarter:ActiveRemains() > S.Meteor:BaseDuration() or not bool(S.Firestarter:ActiveStatus())) or S.RuneofPower:CooldownRemainsP() > Target:TimeToDie() and S.RuneofPower:ChargesP() < 1 or (S.Meteor:BaseDuration() < S.Combustion:CooldownRemainsP() or S.Combustion:CooldownUpP()) and not S.RuneofPower:IsAvailable() and (S.Meteor:BaseDuration() < S.Firestarter:ActiveRemains() or not S.Firestarter:IsAvailable() or not bool(S.Firestarter:ActiveStatus()))) then
            if HR.Cast(S.Meteor) then return "meteor 32"; end
        end
    end
  
    local function CombustionPhase()
        -- lights_judgment,if=buff.combustion.down
        if S.LightsJudgment:IsCastableP() and not ShouldStop and HR.CDsON() and (Player:BuffDownP(S.CombustionBuff)) then
            if HR.Cast(S.LightsJudgment) then return "lights_judgment 234"; end
        end
        -- blood_of_the_enemy
        if S.BloodoftheEnemy:IsCastableP() and Action.GetToggle(1, "HeartOfAzeroth") and not ShouldStop then
            if HR.Cast(S.BloodoftheEnemy, Action.GetToggle(2, "OffGCDasOffGCD")) then return "blood_of_the_enemy 244"; end
        end
        -- memory_of_lucid_dreams
        if S.MemoryofLucidDreams:IsCastableP() and Action.GetToggle(1, "HeartOfAzeroth") and not ShouldStop then
            if HR.Cast(S.MemoryofLucidDreams, Action.GetToggle(2, "OffGCDasOffGCD")) then return "memory_of_lucid_dreams 246"; end
        end
        -- fire_blast,use_while_casting=1,use_off_gcd=1,if=charges>=1&((action.fire_blast.charges_fractional+(buff.combustion.remains-buff.blaster_master.duration)%cooldown.fire_blast.duration-(buff.combustion.remains)%(buff.blaster_master.duration-0.5))>=0|!azerite.blaster_master.enabled|!talent.flame_on.enabled|buff.combustion.remains<=buff.blaster_master.duration|buff.blaster_master.remains<0.5|equipped.hyperthread_wristwraps&cooldown.hyperthread_wristwraps_300142.remains<5)&buff.combustion.up&(!action.scorch.executing&!action.pyroblast.in_flight&buff.heating_up.up|action.scorch.executing&buff.hot_streak.down&(buff.heating_up.down|azerite.blaster_master.enabled)|azerite.blaster_master.enabled&talent.flame_on.enabled&action.pyroblast.in_flight&buff.heating_up.down&buff.hot_streak.down)
        if S.FireBlast:IsReady() and (S.FireBlast:ChargesP() >= 1 and ((S.FireBlast:ChargesFractional() + (Player:BuffRemainsP(S.CombustionBuff) - S.BlasterMasterBuff:BaseDuration()) % S.FireBlast:Cooldown() - (Player:BuffRemainsP(S.CombustionBuff)) % (S.BlasterMasterBuff:BaseDuration() - 0.5)) >= 0 or not S.BlasterMaster:AzeriteEnabled() or not S.FlameOn:IsAvailable() or Player:BuffRemainsP(S.CombustionBuff) <= S.BlasterMasterBuff:BaseDuration() or Player:BuffRemainsP(S.BlasterMasterBuff) < 0.5 or I.HyperthreadWristwraps:IsEquipped() and I.HyperthreadWristwraps:CooldownRemains() < 5) and Player:BuffP(S.Combustion) and (not Player:IsCasting(S.Scorch) and not S.Pyroblast:InFlight() and Player:BuffP(S.HeatingUpBuff) or Player:IsCasting(S.Scorch) and Player:BuffDownP(S.HotStreakBuff) and (Player:BuffDownP(S.HeatingUpBuff) or S.BlasterMaster:AzeriteEnabled()) or S.BlasterMaster:AzeriteEnabled() and S.FlameOn:IsAvailable() and S.Pyroblast:InFlight() and Player:BuffP(S.HeatingUpBuff) and Player:BuffDownP(S.HotStreakBuff))) then
            if HR.Cast(S.FireBlast, Action.GetToggle(2, "OffGCDasOffGCD")) then return "FireBlast 247"; end
        end
        -- rune_of_power,if=buff.combustion.down
        if S.RuneofPower:IsCastableP() and not ShouldStop and (Player:BuffDownP(S.CombustionBuff)) then
            if HR.Cast(S.RuneofPower, Action.GetToggle(2, "OffGCDasOffGCD")) then return "rune_of_power 250"; end
        end
        -- fire_blast,use_while_casting=1,if=azerite.blaster_master.enabled&talent.flame_on.enabled&buff.blaster_master.down&(talent.rune_of_power.enabled&action.rune_of_power.executing&action.rune_of_power.execute_remains<0.6|(cooldown.combustion.ready|buff.combustion.up)&!talent.rune_of_power.enabled&!action.pyroblast.in_flight&!action.fireball.in_flight)
        if S.FireBlast:IsReady() and (S.BlasterMaster:AzeriteEnabled() and S.FlameOn:IsAvailable() and Player:BuffDownP(S.BlasterMasterBuff) and (S.RuneofPower:IsAvailable() and Player:IsCasting(S.RuneofPower) and Player:CastRemains() < 0.6 or (S.Combustion:IsReady() or Player:BuffP(S.CombustionBuff)) and not S.RuneofPower:IsAvailable() and not S.Pyroblast:InFlight() and not S.Fireball:InFlight())) then
            if HR.Cast(S.FireBlast, Action.GetToggle(2, "OffGCDasOffGCD")) then return "fire_blast 255"; end
        end
        -- call_action_list,name=active_talents
        if (true) then
            local ShouldReturn = ActiveTalents(); if ShouldReturn then return ShouldReturn; end
        end
        -- combustion,use_off_gcd=1,use_while_casting=1,if=((action.meteor.in_flight&action.meteor.in_flight_remains<=0.5)|!talent.meteor.enabled)&(buff.rune_of_power.up|!talent.rune_of_power.enabled)
        if S.Combustion:IsCastableP() and not ShouldStop and (((S.Meteor:InFlight() and Player:PrevGCDP(1, S.Meteor)) or not S.Meteor:IsAvailable()) and (Player:BuffP(S.RuneofPowerBuff) or not S.RuneofPower:IsAvailable())) then
            if HR.Cast(S.Combustion, Action.GetToggle(2, "OffGCDasOffGCD")) then return "combustion 265"; end
        end
        -- potion
        if I.PotionofUnbridledFury:IsReady() and Action.GetToggle(1, "Potion") then
            if HR.Cast(I.PotionofUnbridledFury) then return "battle_potion_of_intellect 288"; end
        end
        -- blood_fury
        if S.BloodFury:IsCastableP() and not ShouldStop and HR.CDsON() then
            if HR.Cast(S.BloodFury, Action.GetToggle(2, "OffGCDasOffGCD")) then return "blood_fury 290"; end
        end
        -- berserking
        if S.Berserking:IsCastableP() and not ShouldStop and HR.CDsON() then
            if HR.Cast(S.Berserking, Action.GetToggle(2, "OffGCDasOffGCD")) then return "berserking 292"; end
        end
        -- fireblood
        if S.Fireblood:IsCastableP() and not ShouldStop and HR.CDsON() then
            if HR.Cast(S.Fireblood, Action.GetToggle(2, "OffGCDasOffGCD")) then return "fireblood 294"; end
        end
        -- ancestral_call
        if S.AncestralCall:IsCastableP() and not ShouldStop and HR.CDsON() then
            if HR.Cast(S.AncestralCall, Action.GetToggle(2, "OffGCDasOffGCD")) then return "ancestral_call 296"; end
        end
        -- flamestrike,if=((talent.flame_patch.enabled&active_enemies>2)|active_enemies>6)&buff.hot_streak.react&!azerite.blaster_master.enabled
        if S.Flamestrike:IsCastableP() and not ShouldStop and (((S.FlamePatch:IsAvailable() and EnemiesCount > 2) or EnemiesCount > 6) and Player:BuffP(S.HotStreakBuff) and not S.BlasterMaster:AzeriteEnabled()) then
            if HR.Cast(S.Flamestrike) then return "flamestrike 300"; end
        end
        -- pyroblast,if=buff.pyroclasm.react&buff.combustion.remains>cast_time
        if S.Pyroblast:IsCastableP() and not ShouldStop and (Player:BuffP(S.PyroclasmBuff) and Player:BuffRemainsP(S.CombustionBuff) > S.Pyroblast:CastTime()) then
            if HR.Cast(S.Pyroblast) then return "pyroblast 320"; end
        end
        -- pyroblast,if=buff.hot_streak.react
        if S.Pyroblast:IsCastableP() and not ShouldStop and (Player:BuffP(S.HotStreakBuff)) then
            if HR.Cast(S.Pyroblast) then return "pyroblast 330"; end
        end
        -- pyroblast,if=prev_gcd.1.scorch&buff.heating_up.up
        if S.Pyroblast:IsCastableP() and not ShouldStop and (Player:PrevGCDP(1, S.Scorch) and Player:BuffP(S.HeatingUpBuff)) then
            if HR.Cast(S.Pyroblast) then return "pyroblast 390"; end
        end
        -- phoenix_flames
        if S.PhoenixFlames:IsCastableP() and not ShouldStop then
            if HR.Cast(S.PhoenixFlames) then return "phoenix_flames 396"; end
        end
        -- scorch,if=buff.combustion.remains>cast_time&buff.combustion.up|buff.combustion.down
        if S.Scorch:IsCastableP() and not ShouldStop and (Player:BuffRemainsP(S.CombustionBuff) > S.Scorch:CastTime() and Player:BuffP(S.CombustionBuff) or Player:BuffDownP(S.CombustionBuff)) then
            if HR.Cast(S.Scorch) then return "scorch 398"; end
        end
        -- living_bomb,if=buff.combustion.remains<gcd.max&active_enemies>1
        if S.LivingBomb:IsCastableP() and not ShouldStop and (Player:BuffRemainsP(S.CombustionBuff) < Player:GCD() and EnemiesCount > 1) then
            if HR.Cast(S.LivingBomb) then return "living_bomb 410"; end
        end
        -- dragons_breath,if=buff.combustion.remains<gcd.max&buff.combustion.up
        if S.DragonsBreath:IsReadyP(12) and not ShouldStop and (Player:BuffRemainsP(S.CombustionBuff) < Player:GCD() and Player:BuffP(S.CombustionBuff)) then
            if HR.Cast(S.DragonsBreath) then return "dragons_breath 420"; end
        end
        -- scorch,if=target.health.pct<=30&talent.searing_touch.enabled
        if S.Scorch:IsCastableP() and not ShouldStop and (Target:HealthPercentage() <= 30 and S.SearingTouch:IsAvailable()) then
            if HR.Cast(S.Scorch) then return "scorch 426"; end
        end
    end
	
    local function ItemsCombustion()
        -- use_item,name=ignition_mages_fuse
        if I.IgnitionMagesFuse:IsEquipped() and I.IgnitionMagesFuse:IsReady() and TR.TrinketON() then
            if HR.Cast(I.IgnitionMagesFuse) then return "ignition_mages_fuse combustion"; end
        end
        -- use_item,name=hyperthread_wristwraps,if=buff.combustion.up&action.fire_blast.charges=0&action.fire_blast.recharge_time>gcd.remains
        if I.HyperthreadWristwraps:IsEquipped() and I.HyperthreadWristwraps:IsReady() and TR.TrinketON() and (Player:BuffP(S.CombustionBuff) and S.FireBlast:Charges() == 0 and S.FireBlast:RechargeP() > Player:GCD()) then
            if HR.Cast(I.HyperthreadWristwraps) then return "hyperthread_wristwraps combustion"; end
        end
        -- use_item,use_off_gcd=1,name=azurethos_singed_plumage,if=buff.combustion.up|action.meteor.in_flight&action.meteor.in_flight_remains<=0.5
        if I.AzurethoseSingedPlumage:IsEquipped() and I.AzurethoseSingedPlumage:IsReady() and TR.TrinketON() and (Player:BuffP(S.CombustionBuff) or S.Meteor:InFlight() and Player:PrevGCDP(1, S.Meteor)) then
            if HR.Cast(I.AzurethoseSingedPlumage) then return "azurethos_singed_plumage combustion"; end
        end
        -- use_item,use_off_gcd=1,effect_name=gladiators_badge,if=buff.combustion.up|action.meteor.in_flight&action.meteor.in_flight_remains<=0.5
        -- One line per badge
        if I.NotoriousAspirantsBadge:IsEquipped() and I.NotoriousAspirantsBadge:IsReady() and TR.TrinketON() and (Player:BuffP(S.CombustionBuff) or S.Meteor:InFlight() and Player:PrevGCDP(1, S.Meteor)) then
            if HR.Cast(I.NotoriousAspirantsBadge) then return "gladiators_badge combustion"; end
        end
        if I.NotoriousGladiatorsBadge:IsEquipped() and I.NotoriousGladiatorsBadge:IsReady() and TR.TrinketON() and (Player:BuffP(S.CombustionBuff) or S.Meteor:InFlight() and Player:PrevGCDP(1, S.Meteor)) then
            if HR.Cast(I.NotoriousGladiatorsBadge) then return "gladiators_badge combustion"; end
        end
        if I.SinisterGladiatorsBadge:IsEquipped() and I.SinisterGladiatorsBadge:IsReady() and TR.TrinketON() and (Player:BuffP(S.CombustionBuff) or S.Meteor:InFlight() and Player:PrevGCDP(1, S.Meteor)) then
            if HR.Cast(I.SinisterGladiatorsBadge) then return "gladiators_badge combustion"; end
        end
        if I.SinisterAspirantsBadge:IsEquipped() and I.SinisterAspirantsBadge:IsReady() and TR.TrinketON() and (Player:BuffP(S.CombustionBuff) or S.Meteor:InFlight() and Player:PrevGCDP(1, S.Meteor)) then
            if HR.Cast(I.SinisterAspirantsBadge) then return "gladiators_badge combustion"; end
        end
        if I.DreadGladiatorsBadge:IsEquipped() and I.DreadGladiatorsBadge:IsReady() and TR.TrinketON() and (Player:BuffP(S.CombustionBuff) or S.Meteor:InFlight() and Player:PrevGCDP(1, S.Meteor)) then
            if HR.Cast(I.DreadGladiatorsBadge) then return "gladiators_badge combustion"; end
        end
        if I.DreadAspirantsBadge:IsEquipped() and I.DreadAspirantsBadge:IsReady() and TR.TrinketON() and (Player:BuffP(S.CombustionBuff) or S.Meteor:InFlight() and Player:PrevGCDP(1, S.Meteor)) then
            if HR.Cast(I.DreadAspirantsBadge) then return "gladiators_badge combustion"; end
        end
        -- use_item,use_off_gcd=1,effect_name=gladiators_medallion,if=buff.combustion.up|action.meteor.in_flight&action.meteor.in_flight_remains<=0.5
        -- One line per medallion
        if I.NotoriousAspirantsMedallion:IsEquipped() and I.NotoriousAspirantsMedallion:IsReady() and TR.TrinketON() and (Player:BuffP(S.CombustionBuff) or S.Meteor:InFlight() and Player:PrevGCDP(1, S.Meteor)) then
            if HR.Cast(I.NotoriousAspirantsMedallion) then return "gladiators_medallion combustion"; end
        end
        if I.NotoriousGladiatorsMedallion:IsEquipped() and I.NotoriousGladiatorsMedallion:IsReady() and TR.TrinketON() and (Player:BuffP(S.CombustionBuff) or S.Meteor:InFlight() and Player:PrevGCDP(1, S.Meteor)) then
            if HR.Cast(I.NotoriousGladiatorsMedallion) then return "gladiators_medallion combustion"; end
        end
        if I.SinisterGladiatorsMedallion:IsEquipped() and I.SinisterGladiatorsMedallion:IsReady() and TR.TrinketON() and (Player:BuffP(S.CombustionBuff) or S.Meteor:InFlight() and Player:PrevGCDP(1, S.Meteor)) then
            if HR.Cast(I.SinisterGladiatorsMedallion) then return "gladiators_medallion combustion"; end
        end
        if I.SinisterAspirantsMedallion:IsEquipped() and I.SinisterAspirantsMedallion:IsReady() and TR.TrinketON() and (Player:BuffP(S.CombustionBuff) or S.Meteor:InFlight() and Player:PrevGCDP(1, S.Meteor)) then
            if HR.Cast(I.SinisterAspirantsMedallion) then return "gladiators_medallion combustion"; end
        end
        if I.DreadGladiatorsMedallion:IsEquipped() and I.DreadGladiatorsMedallion:IsReady() and TR.TrinketON() and (Player:BuffP(S.CombustionBuff) or S.Meteor:InFlight() and Player:PrevGCDP(1, S.Meteor)) then
            if HR.Cast(I.DreadGladiatorsMedallion) then return "gladiators_medallion combustion"; end
        end
        if I.DreadAspirantsMedallion:IsEquipped() and I.DreadAspirantsMedallion:IsReady() and TR.TrinketON() and (Player:BuffP(S.CombustionBuff) or S.Meteor:InFlight() and Player:PrevGCDP(1, S.Meteor)) then
            if HR.Cast(I.DreadAspirantsMedallion) then return "gladiators_medallion combustion"; end
        end
        if I.DreadCombatantsMedallion:IsEquipped() and I.DreadCombatantsMedallion:IsReady() and TR.TrinketON() and (Player:BuffP(S.CombustionBuff) or S.Meteor:InFlight() and Player:PrevGCDP(1, S.Meteor)) then
            if HR.Cast(I.DreadCombatantsMedallion) then return "gladiators_medallion combustion"; end
        end
        -- use_item,use_off_gcd=1,name=balefire_branch,if=buff.combustion.up|action.meteor.in_flight&action.meteor.in_flight_remains<=0.5
        if I.BalefireBranch:IsEquipped() and I.BalefireBranch:IsReady() and TR.TrinketON() and (Player:BuffP(S.CombustionBuff) or S.Meteor:InFlight() and Player:PrevGCDP(1, S.Meteor)) then
            if HR.Cast(I.BalefireBranch) then return "balefire_branch combustion"; end
        end
        -- use_item,use_off_gcd=1,name=shockbiters_fang,if=buff.combustion.up|action.meteor.in_flight&action.meteor.in_flight_remains<=0.5
        if I.ShockbitersFang:IsEquipped() and I.ShockbitersFang:IsReady() and TR.TrinketON() and (Player:BuffP(S.CombustionBuff) or S.Meteor:InFlight() and Player:PrevGCDP(1, S.Meteor)) then
            if HR.Cast(I.ShockbitersFang) then return "shockbiters_fang combustion"; end
        end
        -- use_item,use_off_gcd=1,name=tzanes_barkspines,if=buff.combustion.up|action.meteor.in_flight&action.meteor.in_flight_remains<=0.5
        if I.TzanesBarkspines:IsEquipped() and I.TzanesBarkspines:IsReady() and TR.TrinketON() and (Player:BuffP(S.CombustionBuff) or S.Meteor:InFlight() and Player:PrevGCDP(1, S.Meteor)) then
            if HR.Cast(I.TzanesBarkspines) then return "tzanes_barkspines combustion"; end
        end
        -- use_item,use_off_gcd=1,name=ancient_knot_of_wisdom,if=buff.combustion.up|action.meteor.in_flight&action.meteor.in_flight_remains<=0.5
        -- Two conditions, since the horde and alliance trinkets have different IDs
        if I.AncientKnotofWisdomAlliance:IsEquipped() and I.AncientKnotofWisdomAlliance:IsReady() and TR.TrinketON() and (Player:BuffP(S.CombustionBuff) or S.Meteor:InFlight() and Player:PrevGCDP(1, S.Meteor)) then
            if HR.Cast(I.AncientKnotofWisdomAlliance) then return "ancient_knot_of_wisdom combustion"; end
       end
        if I.AncientKnotofWisdomHorde:IsEquipped() and I.AncientKnotofWisdomHorde:IsReady() and TR.TrinketON() and (Player:BuffP(S.CombustionBuff) or S.Meteor:InFlight() and Player:PrevGCDP(1, S.Meteor)) then
            if HR.Cast(I.AncientKnotofWisdomHorde) then return "ancient_knot_of_wisdom combustion"; end
        end
        -- use_item,use_off_gcd=1,name=neural_synapse_enhancer,if=buff.combustion.up|action.meteor.in_flight&action.meteor.in_flight_remains<=0.5
        if I.NeuralSynapseEnhancer:IsEquipped() and I.NeuralSynapseEnhancer:IsReady() and TR.TrinketON() and (Player:BuffP(S.CombustionBuff) or S.Meteor:InFlight() and Player:PrevGCDP(1, S.Meteor)) then
            if HR.Cast(I.NeuralSynapseEnhancer) then return "neural_synapse_enhancer combustion"; end
        end
        -- use_item,use_off_gcd=1,name=malformed_heralds_legwraps,if=buff.combustion.up|action.meteor.in_flight&action.meteor.in_flight_remains<=0.5
        if I.MalformedHeraldsLegwraps:IsEquipped() and I.MalformedHeraldsLegwraps:IsReady() and TR.TrinketON() and (Player:BuffP(S.CombustionBuff) or S.Meteor:InFlight() and Player:PrevGCDP(1, S.Meteor)) then
            if HR.Cast(I.MalformedHeraldsLegwraps) then return "malformed_heralds_legwraps combustion"; end
        end
    end
    
	local function ItemsHighPriority()
        -- call_action_list,name=items_combustion,if=(talent.rune_of_power.enabled&cooldown.combustion.remains<=action.rune_of_power.cast_time|cooldown.combustion.ready)&!firestarter.active|buff.combustion.up
        if ((S.RuneofPower:IsAvailable() and S.Combustion:CooldownRemainsP() <= S.RuneofPower:CastTime() or S.Combustion:IsReadyP()) and not bool(S.Firestarter:ActiveStatus()) or Player:BuffP(S.CombustionBuff)) then
            local ShouldReturn = ItemsCombustion(); if ShouldReturn then return ShouldReturn; end
        end
        -- use_items
        -- use_item,name=azsharas_font_of_power,if=cooldown.combustion.remains<=5+15*variable.font_double_on_use
        if I.AzsharasFontofPower:IsEquipped() and I.AzsharasFontofPower:IsReady() and TR.TrinketON() and (S.Combustion:CooldownRemainsP() <= 5 + 15 * VarFontDoubleOnUse) then
            if HR.Cast(I.AzsharasFontofPower) then return "azsharas_font_of_power high_priority"; end
        end
        -- use_item,name=rotcrusted_voodoo_doll,if=cooldown.combustion.remains>variable.on_use_cutoff
        if I.RotcrustedVoodooDoll:IsEquipped() and I.RotcrustedVoodooDoll:IsReady() and TR.TrinketON() and (S.Combustion:CooldownRemainsP() > VarOnUseCutoff) then
            if HR.Cast(I.RotcrustedVoodooDoll) then return "rotcrusted_voodoo_doll high_priority"; end
        end
        -- use_item,name=aquipotent_nautilus,if=cooldown.combustion.remains>variable.on_use_cutoff
        if I.AquipotentNautilus:IsEquipped() and I.AquipotentNautilus:IsReady() and TR.TrinketON() and (S.Combustion:CooldownRemainsP() > VarOnUseCutoff) then
            if HR.Cast(I.AquipotentNautilus) then return "aquipotent_nautilus high_priority"; end
        end
        -- use_item,name=shiver_venom_relic,if=cooldown.combustion.remains>variable.on_use_cutoff
        if I.ShiverVenomRelic:IsEquipped() and I.ShiverVenomRelic:IsReady() and TR.TrinketON() and (S.Combustion:CooldownRemainsP() > VarOnUseCutoff) then
            if HR.Cast(I.ShiverVenomRelic) then return "shiver_venom_relic high_priority"; end
        end
        -- use_item,effect_name=harmonic_dematerializer
        if I.PocketsizedComputationDevice:IsEquipped() and I.PocketsizedComputationDevice:IsReady() and TR.TrinketON() and S.HarmonicDematerializer:IsAvailable() then
            if HR.Cast(I.PocketsizedComputationDevice) then return "harmonic_dematerializer high_priority"; end
        end
        -- use_item,name=malformed_heralds_legwraps,if=cooldown.combustion.remains>=55&buff.combustion.down&cooldown.combustion.remains>variable.on_use_cutoff
        if I.MalformedHeraldsLegwraps:IsEquipped() and I.MalformedHeraldsLegwraps:IsReady() and TR.TrinketON() and (S.Combustion:CooldownRemainsP() >= 55 and Player:BuffDownP(S.CombustionBuff) and S.Combustion:CooldownRemainsP() > VarOnUseCutoff) then
            if HR.Cast(I.MalformedHeraldsLegwraps) then return "malformed_heralds_legwraps high_priority"; end
        end
        -- use_item,name=ancient_knot_of_wisdom,if=cooldown.combustion.remains>=55&buff.combustion.down&cooldown.combustion.remains>variable.on_use_cutoff
        -- Two conditions, since the horde and alliance trinkets have different IDs
        if I.AncientKnotofWisdomAlliance:IsEquipped() and I.AncientKnotofWisdomAlliance:IsReady() and TR.TrinketON() and (S.Combustion:CooldownRemainsP() >= 55 and Player:BuffDownP(S.CombustionBuff) and S.Combustion:CooldownRemainsP() > VarOnUseCutoff) then
            if HR.Cast(I.AncientKnotofWisdomAlliance) then return "ancient_knot_of_wisdom high_priority"; end
        end
        if I.AncientKnotofWisdomHorde:IsEquipped() and I.AncientKnotofWisdomHorde:IsReady() and TR.TrinketON() and (S.Combustion:CooldownRemainsP() >= 55 and Player:BuffDownP(S.CombustionBuff) and S.Combustion:CooldownRemainsP() > VarOnUseCutoff) then
            if HR.Cast(I.AncientKnotofWisdomHorde) then return "ancient_knot_of_wisdom high_priority"; end
        end
        -- use_item,name=neural_synapse_enhancer,if=cooldown.combustion.remains>=45&buff.combustion.down&cooldown.combustion.remains>variable.on_use_cutoff
        if I.NeuralSynapseEnhancer:IsEquipped() and I.NeuralSynapseEnhancer:IsReady() and TR.TrinketON() and (S.Combustion:CooldownRemainsP() >= 45 and Player:BuffDownP(S.CombustionBuff) and S.Combustion:CooldownRemainsP() > VarOnUseCutoff) then
            if HR.Cast(I.NeuralSynapseEnhancer) then return "neural_synapse_enhancer high_priority"; end
        end
    end
	
    local function ItemsLowPriority()
        -- use_item,name=tidestorm_codex,if=cooldown.combustion.remains>variable.on_use_cutoff|talent.firestarter.enabled&firestarter.remains>variable.on_use_cutoff
        if I.TidestormCodex:IsEquipped() and I.TidestormCodex:IsReady() and TR.TrinketON() and (S.Combustion:CooldownRemainsP() > VarOnUseCutoff or S.Firestarter:IsAvailable() and S.Firestarter:ActiveRemains() > VarOnUseCutoff) then
            if HR.Cast(I.TidestormCodex) then return "tidestorm_codex low_priority"; end
        end
        -- use_item,effect_name=cyclotronic_blast,if=cooldown.combustion.remains>variable.on_use_cutoff|talent.firestarter.enabled&firestarter.remains>variable.on_use_cutoff
        if I.PocketsizedComputationDevice:IsEquipped() and I.PocketsizedComputationDevice:IsReady() and TR.TrinketON() and S.CyclotronicBlast:IsAvailable() and (S.Combustion:CooldownRemainsP() > VarOnUseCutoff or S.Firestarter:IsAvailable() and S.Firestarter:ActiveRemains() > VarOnUseCutoff) then
            if HR.Cast(I.PocketsizedComputationDevice) then return "cyclotronic_blast low_priority"; end
        end
    end
    
	local function RopPhase()
        -- rune_of_power
        if S.RuneofPower:IsCastableP() and not ShouldStop then
            if HR.Cast(S.RuneofPower, Action.GetToggle(2, "OffGCDasOffGCD")) then return "rune_of_power 430"; end
        end
        -- flamestrike,if=(talent.flame_patch.enabled&active_enemies>1|active_enemies>4)&buff.hot_streak.react
        if S.Flamestrike:IsCastableP() and ((S.FlamePatch:IsAvailable() and EnemiesCount > 1 or EnemiesCount > 4) and Player:BuffP(S.HotStreakBuff)) then
            if HR.Cast(S.Flamestrike) then return "flamestrike 432"; end
        end
        -- pyroblast,if=buff.hot_streak.react
        if S.Pyroblast:IsCastableP() and not ShouldStop and (Player:BuffP(S.HotStreakBuff)) then
            if HR.Cast(S.Pyroblast) then return "pyroblast 450"; end
        end
        -- fire_blast,use_off_gcd=1,use_while_casting=1,if=!(talent.flame_patch.enabled&active_enemies>2|active_enemies>5)&(!firestarter.active&cooldown.combustion.remains>0)&(!buff.heating_up.react&!buff.hot_streak.react&!prev_off_gcd.fire_blast&(action.fire_blast.charges>=2|(action.phoenix_flames.charges>=1&talent.phoenix_flames.enabled)|(talent.alexstraszas_fury.enabled&cooldown.dragons_breath.ready)|(talent.searing_touch.enabled&target.health.pct<=30)))
        if S.FireBlast:IsCastableP() and (not (S.FlamePatch:IsAvailable() and EnemiesCount > 2 or EnemiesCount > 5) and (not bool(S.Firestarter:ActiveStatus()) and S.Combustion:CooldownRemainsP() > 0) and (Player:BuffDownP(S.HeatingUpBuff) and Player:BuffDownP(S.HotStreakBuff) and not Player:PrevOffGCDP(1, S.FireBlast) and (S.FireBlast:ChargesP() >= 2 or (S.PhoenixFlames:ChargesP() >= 1 and S.PhoenixFlames:IsAvailable()) or (S.AlexstraszasFury:IsAvailable() and S.DragonsBreath:CooldownUpP()) or (S.SearingTouch:IsAvailable() and Target:HealthPercentage() <= 30)))) then
            if HR.Cast(S.FireBlast) then return "fire_blast 454"; end
        end
        -- call_action_list,name=active_talents
        if (true) then
            local ShouldReturn = ActiveTalents(); if ShouldReturn then return ShouldReturn; end
        end
        -- pyroblast,if=buff.pyroclasm.react&cast_time<buff.pyroclasm.remains&buff.rune_of_power.remains>cast_time
        if S.Pyroblast:IsCastableP() and not ShouldStop and (Player:BuffP(S.PyroclasmBuff) and S.Pyroblast:CastTime() < Player:BuffRemainsP(S.PyroclasmBuff) and Player:BuffRemainsP(S.RuneofPowerBuff) > S.Pyroblast:CastTime()) then
            if HR.Cast(S.Pyroblast) then return "pyroblast 486"; end
        end
        -- fire_blast,use_off_gcd=1,use_while_casting=1,if=!(talent.flame_patch.enabled&active_enemies>2|active_enemies>5)&(!firestarter.active&cooldown.combustion.remains>0)&(buff.heating_up.react&(target.health.pct>=30|!talent.searing_touch.enabled))
        if S.FireBlast:IsCastableP() and (not (S.FlamePatch:IsAvailable() and EnemiesCount > 2 or EnemiesCount > 5) and (not bool(S.Firestarter:ActiveStatus()) and S.Combustion:CooldownRemainsP() > 0) and (Player:BuffP(S.HeatingUpBuff) and (Target:HealthPercentage() >= 30 or not S.SearingTouch:IsAvailable()))) then
            if HR.Cast(S.FireBlast) then return "fire_blast 502"; end
        end
        -- fire_blast,use_off_gcd=1,use_while_casting=1,if=!(talent.flame_patch.enabled&active_enemies>2|active_enemies>5)&(!firestarter.active&cooldown.combustion.remains>0)&talent.searing_touch.enabled&target.health.pct<=30&(buff.heating_up.react&!action.scorch.executing|!buff.heating_up.react&!buff.hot_streak.react)
        if S.FireBlast:IsCastableP() and (not (S.FlamePatch:IsAvailable() and EnemiesCount > 2 or EnemiesCount > 5) and (not bool(S.Firestarter:ActiveStatus()) and S.Combustion:CooldownRemainsP() > 0) and S.SearingTouch:IsAvailable() and Target:HealthPercentage() <= 30 and (Player:BuffP(S.HeatingUpBuff) and not Player:IsCasting(S.Scorch) or Player:BuffDownP(S.HeatingUpBuff) and Player:BuffDownP(S.HotStreakBuff))) then
            if HR.Cast(S.FireBlast) then return "fire_blast 512"; end
        end
        -- pyroblast,if=prev_gcd.1.scorch&buff.heating_up.up&talent.searing_touch.enabled&target.health.pct<=30&(!talent.flame_patch.enabled|active_enemies=1)
        if S.Pyroblast:IsCastableP() and not ShouldStop and (Player:PrevGCDP(1, S.Scorch) and Player:BuffP(S.HeatingUpBuff) and S.SearingTouch:IsAvailable() and Target:HealthPercentage() <= 30 and (not S.FlamePatch:IsAvailable() or EnemiesCount == 1)) then
            if HR.Cast(S.Pyroblast) then return "pyroblast 530"; end
        end
        -- phoenix_flames,if=!prev_gcd.1.phoenix_flames&buff.heating_up.react
        if S.PhoenixFlames:IsCastableP() and not ShouldStop and (not Player:PrevGCDP(1, S.PhoenixFlames) and Player:BuffP(S.HeatingUpBuff)) then
            if HR.Cast(S.PhoenixFlames) then return "phoenix_flames 546"; end
        end
        -- scorch,if=target.health.pct<=30&talent.searing_touch.enabled
        if S.Scorch:IsCastableP() and not ShouldStop and (Target:HealthPercentage() <= 30 and S.SearingTouch:IsAvailable()) then
            if HR.Cast(S.Scorch) then return "scorch 552"; end
        end
        -- dragons_breath,if=active_enemies>2
        if S.DragonsBreath:IsCastableP(12) and not ShouldStop and (EnemiesCount > 2) then
            if HR.Cast(S.DragonsBreath) then return "dragons_breath 556"; end
        end
	    -- fire_blast,use_off_gcd=1,use_while_casting=1,if=(talent.flame_patch.enabled&active_enemies>2|active_enemies>5)&(cooldown.combustion.remains>0&!firestarter.active)&buff.hot_streak.down&(!azerite.blaster_master.enabled|buff.blaster_master.remains<0.5)
        if S.FireBlast:IsCastableP() and ((S.FlamePatch:IsAvailable() and EnemiesCount > 2 or EnemiesCount > 5) and (S.Combustion:CooldownRemainsP() > 0 and not bool(S.Firestarter:ActiveStatus())) and Player:BuffDownP(S.HotStreakBuff) and (not S.BlasterMaster:AzeriteEnabled() or Player:BuffRemainsP(S.BlasterMasterBuff) < 0.5)) then
            if HR.Cast(S.FireBlast) then return "fire_blast 562"; end
        end
        -- flamestrike,if=talent.flame_patch.enabled&active_enemies>2|active_enemies>5
        if S.Flamestrike:IsCastableP() and (S.FlamePatch:IsAvailable() and EnemiesCount > 2 or EnemiesCount > 5) then
            if HR.Cast(S.Flamestrike) then return "flamestrike 564"; end
        end
        -- fireball
        if S.Fireball:IsCastableP() and not ShouldStop then
            if HR.Cast(S.Fireball) then return "fireball 580"; end
        end
    end
	
    local function StandardRotation()
        -- flamestrike,if=((talent.flame_patch.enabled&active_enemies>1&!firestarter.active)|active_enemies>4)&buff.hot_streak.react
        if S.Flamestrike:IsCastableP() and not ShouldStop and (((S.FlamePatch:IsAvailable() and EnemiesCount > 1 and not bool(S.Firestarter:ActiveStatus())) or EnemiesCount >= 4) and Player:BuffP(S.HotStreakBuff)) then
            if HR.Cast(S.Flamestrike) then return "flamestrike 582"; end
        end
        -- pyroblast,if=buff.hot_streak.react&buff.hot_streak.remains<action.fireball.execute_time
        if S.Pyroblast:IsCastableP() and not ShouldStop and (Player:BuffP(S.HotStreakBuff) and Player:BuffRemainsP(S.HotStreakBuff) < S.Fireball:ExecuteTime()) then
            if HR.Cast(S.Pyroblast) then return "pyroblast 600"; end
        end
        -- pyroblast,if=buff.hot_streak.react&(prev_gcd.1.fireball|firestarter.active|action.pyroblast.in_flight)
        if S.Pyroblast:IsCastableP() and not ShouldStop and (Player:BuffP(S.HotStreakBuff) and (Player:PrevGCDP(1, S.Fireball) or bool(S.Firestarter:ActiveStatus()) or S.Pyroblast:InFlight())) then
            if HR.Cast(S.Pyroblast) then return "pyroblast 610"; end
        end
        -- phoenix_flames,if=charges>=3&active_enemies>2&!variable.phoenix_pooling
        if S.PhoenixFlames:IsReadyP() and (S.PhoenixFlames:ChargesP() >= 3 and EnemiesCount > 2 and not bool(VarPhoenixPooling)) then
            if HR.Cast(S.PhoenixFlames) then return "phoenix_flames 615"; end
        end
        -- pyroblast,if=buff.hot_streak.react&target.health.pct<=30&talent.searing_touch.enabled
        if S.Pyroblast:IsCastableP() and not ShouldStop and (Player:BuffP(S.HotStreakBuff) and Target:HealthPercentage() <= 30 and S.SearingTouch:IsAvailable()) then
            if HR.Cast(S.Pyroblast) then return "pyroblast 620"; end
        end
        -- pyroblast,if=buff.pyroclasm.react&cast_time<buff.pyroclasm.remains
        if S.Pyroblast:IsCastableP() and not ShouldStop and (Player:BuffP(S.PyroclasmBuff) and S.Pyroblast:CastTime() < Player:BuffRemainsP(S.PyroclasmBuff)) then
            if HR.Cast(S.Pyroblast) then return "pyroblast 626"; end
        end
        -- fire_blast,use_off_gcd=1,use_while_casting=1,if=(cooldown.combustion.remains>0&buff.rune_of_power.down|firestarter.active)&!talent.kindling.enabled&!variable.fire_blast_pooling&(((action.fireball.executing|action.pyroblast.executing)&(buff.heating_up.react|firestarter.active&!buff.hot_streak.react&!buff.heating_up.react))|(talent.searing_touch.enabled&target.health.pct<=30&(buff.heating_up.react&!action.scorch.executing|!buff.hot_streak.react&!buff.heating_up.react&action.scorch.executing&!action.pyroblast.in_flight&!action.fireball.in_flight))|(firestarter.active&(action.pyroblast.in_flight|action.fireball.in_flight)&!buff.heating_up.react&!buff.hot_streak.react))
        if S.FireBlast:IsReady() and ((S.Combustion:CooldownRemainsP() > 0 and Player:BuffDownP(S.RuneofPowerBuff) or bool(S.Firestarter:ActiveStatus())) and not S.Kindling:IsAvailable() and not bool(VarFireBlastPooling) and (((Player:IsCasting(S.Fireball) or Player:IsCasting(S.Pyroblast)) and (Player:BuffP(S.HeatingUpBuff) or bool(S.Firestarter:ActiveStatus()) and Player:BuffDownP(S.HotStreakBuff) and Player:BuffDownP(S.HeatingUpBuff))) or (S.SearingTouch:IsAvailable() and Target:HealthPercentage() <= 30 and (Player:BuffP(S.HeatingUpBuff) and not Player:IsCasting(S.Scorch) or Player:BuffDownP(S.HotStreakBuff) and Player:BuffDownP(S.HeatingUpBuff) and Player:IsCasting(S.Scorch) and not S.Pyroblast:InFlight() and not S.Fireball:InFlight())) or (bool(S.Firestarter:ActiveStatus()) and (S.Pyroblast:InFlight() or S.Fireball:InFlight()) and Player:BuffDownP(S.HeatingUpBuff) and Player:BuffDownP(S.HotStreakBuff)))) then
            if HR.Cast(S.FireBlast, Action.GetToggle(2, "OffGCDasOffGCD")) then return "fire_blast 636"; end
        end
        -- fire_blast,if=talent.kindling.enabled&buff.heating_up.react&(cooldown.combustion.remains>full_recharge_time+2+talent.kindling.enabled|firestarter.remains>full_recharge_time|(!talent.rune_of_power.enabled|cooldown.rune_of_power.remains>target.time_to_die&action.rune_of_power.charges<1)&cooldown.combustion.remains>target.time_to_die)
        if S.FireBlast:IsReady() and (S.Kindling:IsAvailable() and Player:BuffP(S.HeatingUpBuff) and (S.Combustion:CooldownRemainsP() > S.FireBlast:FullRechargeTimeP() + 2 + num(S.Kindling:IsAvailable()) or S.Firestarter:ActiveRemains() > S.FireBlast:FullRechargeTimeP() or (not S.RuneofPower:IsAvailable() or S.RuneofPower:CooldownRemainsP() > Target:TimeToDie() and S.RuneofPower:ChargesP() < 1) and S.Combustion:CooldownRemainsP() > Target:TimeToDie())) then
            if HR.Cast(S.FireBlast, Action.GetToggle(2, "OffGCDasOffGCD")) then return "fire_blast 696"; end
        end
        -- pyroblast,if=prev_gcd.1.scorch&buff.heating_up.up&talent.searing_touch.enabled&target.health.pct<=30&((talent.flame_patch.enabled&active_enemies=1&!firestarter.active)|(active_enemies<4&!talent.flame_patch.enabled))
        if S.Pyroblast:IsCastableP() and not ShouldStop and (Player:PrevGCDP(1, S.Scorch) and Player:BuffP(S.HeatingUpBuff) and S.SearingTouch:IsAvailable() and Target:HealthPercentage() <= 30 and ((S.FlamePatch:IsAvailable() and EnemiesCount == 1 and not bool(S.Firestarter:ActiveStatus())) or (EnemiesCount < 4 and not S.FlamePatch:IsAvailable()))) then
            if HR.Cast(S.Pyroblast) then return "pyroblast 726"; end
        end
        -- phoenix_flames,if=(buff.heating_up.react|(!buff.hot_streak.react&(action.fire_blast.charges>0|talent.searing_touch.enabled&target.health.pct<=30)))&!variable.phoenix_pooling
        if S.PhoenixFlames:IsCastableP() and not ShouldStop and ((Player:BuffP(S.HeatingUpBuff) or (Player:BuffDownP(S.HotStreakBuff) and (S.FireBlast:ChargesP() > 0 or S.SearingTouch:IsAvailable() and Target:HealthPercentage() <= 30))) and not bool(VarPhoenixPooling)) then
            if HR.Cast(S.PhoenixFlames) then return "phoenix_flames 750"; end
        end
        -- call_action_list,name=active_talents
        if (true) then
            local ShouldReturn = ActiveTalents(); if ShouldReturn then return ShouldReturn; end
        end
        -- dragons_breath,if=active_enemies>1
        if S.DragonsBreath:IsCastableP(12) and not ShouldStop and (EnemiesCount > 1) then
            if HR.Cast(S.DragonsBreath) then return "dragons_breath 766"; end
        end
        -- call_action_list,name=items_low_priority
        if (true) then
            local ShouldReturn = ItemsLowPriority(); if ShouldReturn then return ShouldReturn; end
        end
        -- scorch,if=target.health.pct<=30&talent.searing_touch.enabled
        if S.Scorch:IsCastableP() and not ShouldStop and (Target:HealthPercentage() <= 30 and S.SearingTouch:IsAvailable()) then
            if HR.Cast(S.Scorch) then return "scorch 780"; end
        end
        -- fireball
        if S.Fireball:IsCastableP() and not ShouldStop then
            if HR.Cast(S.Fireball) then return "fireball 784"; end
        end
	    -- fire_blast,use_off_gcd=1,use_while_casting=1,if=(talent.flame_patch.enabled&active_enemies>2|active_enemies>9)&(cooldown.combustion.remains>0&!firestarter.active)&buff.hot_streak.down&(!azerite.blaster_master.enabled|buff.blaster_master.remains<0.5)
        if S.FireBlast:IsCastableP() and ((S.FlamePatch:IsAvailable() and EnemiesCount > 2 or EnemiesCount > 9) and (S.Combustion:CooldownRemainsP() > 0 and not bool(S.Firestarter:ActiveStatus())) and Player:BuffDownP(S.HotStreakBuff) and (not S.BlasterMaster:AzeriteEnabled() or Player:BuffRemainsP(S.BlasterMasterBuff) < 0.5)) then
            if HR.Cast(S.FireBlast) then return "fire_blast 781"; end
        end
        -- flamestrike,if=talent.flame_patch.enabled&active_enemies>2|active_enemies>9
        if S.Flamestrike:IsCastableP() and ((S.FlamePatch:IsAvailable() and EnemiesCount > 2) or EnemiesCount > 5) then
            if HR.Cast(S.Flamestrike) then return "flamestrike 783"; end
        end
        -- scorch
        if S.Scorch:IsCastableP() and not ShouldStop then
            if HR.Cast(S.Scorch) then return "scorch 786"; end
        end
    end
	
	-- Emergency situations
	local function Emergency()
	    if S.IceBlock:IsReady() and Player:HealthPercentage() <= Action.GetToggle(2, "IceBlock") then
            if HR.Cast(S.IceBlock) then return "IceBlock 786"; end
        end

        if S.BlazingBarrier:IsReady() and not Player:Buff(S.BlazingBarrier) and  Player:HealthPercentage() <= Action.GetToggle(2, "BlazingBarrier") then
            if HR.Cast(S.BlazingBarrier) then return "BlazingBarrier 786"; end
        end
	end
 
	-- call DBM precombat
    if not Player:AffectingCombat() and Action.GetToggle(1, "DBM") and not Player:IsCasting() then
        local ShouldReturn = Precombat_DBM(); 
            if ShouldReturn then return ShouldReturn; 
        end    
    end
	
    -- call non DBM precombat
    if not Player:AffectingCombat() and not Action.GetToggle(1, "DBM") and not Player:IsCasting() then        
        local ShouldReturn = Precombat(); 
            if ShouldReturn then return ShouldReturn; 
        end    
    end
	
	-- Make use of all trinkets of the game
	-- Dont forget to add check on SIMC recommanded trinkets to keep using them with APLs.
	local function TrinketsRotation(icon)
	    --print(Trinket1IsAllowed)	
        -- print(Trinket2IsAllowed)
		
       	-- Trinkets
       	if A.Trinket1:IsReady("target") and Trinket1IsAllowed and A.Trinket1:AbsentImun(unit, "DamageMagicImun")  then 
      	   	return A.Trinket1:Show(icon)
   	    end 
              
   		if A.Trinket2:IsReady("target") and Trinket2IsAllowed and A.Trinket2:AbsentImun(unit, "DamageMagicImun")  then 
       	   	return A.Trinket2:Show(icon)
   	    end  	   	
     	
   	end
	
    --- In Combat
    if Player:AffectingCombat() then

	    -- Interrupt Handler
        
        local unit = "target"
        local useKick, useCC, useRacial = Action.InterruptIsValid(unit, "TargetMouseover")    
        local Trinket1IsAllowed, Trinket2IsAllowed = TR.TrinketIsAllowed()
		
		-- Counterspell
        if useKick and S.Counterspell:IsReady() and Target:IsInterruptible() then 
		    if ActionUnit(unit):CanInterrupt(true, nil, 25, 70) then
                if HR.Cast(S.Counterspell, true) then return "Counterspell 5"; end
            end 
        end    
		
		-- Purge
		-- Note: Toggles  ("UseDispel", "UsePurge", "UseExpelEnrage")
        -- Category ("Dispel", "MagicMovement", "PurgeFriendly", "PurgeHigh", "PurgeLow", "Enrage")
        if S.Spellsteal:IsReady() and not ShouldStop and Action.AuraIsValid("player", "UsePurge", "PurgeHigh") then
            if HR.Cast(S.Spellsteal) then return "" end
        end	
		-- Emergency
		local ShouldReturn = Emergency(); if ShouldReturn then return ShouldReturn; end		
		-- fireblast,!moving
        if S.FireBlast:IsReady() and Player:BuffP(S.HeatingUpBuff) and Player:BuffDownP(S.HotStreakBuff) and not Player:PrevOffGCDP(1, S.FireBlast) and S.FireBlast:ChargesP() >= 1 then
            if HR.Cast(S.FireBlast, Action.GetToggle(2, "OffGCDasOffGCD")) then return "fire_blast 454"; end
        end
		-- pyroblast,if=moving
        if S.Pyroblast:IsCastableP() and not ShouldStop and Player:IsMoving() and Player:BuffP(S.HotStreakBuff) then
            if HR.Cast(S.Pyroblast) then return "pyroblast 726"; end
        end
		-- fireblast,if.moving
        if S.FireBlast:IsReady() and Player:IsMoving() and Player:BuffP(S.HeatingUpBuff) and Player:BuffDownP(S.HotStreakBuff) and not Player:PrevOffGCDP(1, S.FireBlast) and S.FireBlast:ChargesP() >= 2 then
            if HR.Cast(S.FireBlast, Action.GetToggle(2, "OffGCDasOffGCD")) then return "fire_blast 454"; end
        end
		-- scorch.moving
        if S.Scorch:IsCastableP() and not ShouldStop and Player:IsMoving() then
            if HR.Cast(S.Scorch) then return "scorch 786"; end
        end
        -- call_action_list,name=items_high_priority
        if (true) then
            local ShouldReturn = ItemsHighPriority(); if ShouldReturn then return ShouldReturn; end
        end
        -- mirror_image,if=buff.combustion.down
        if S.MirrorImage:IsCastableP() and not ShouldStop and (Player:BuffDownP(S.CombustionBuff)) then
            if HR.Cast(S.MirrorImage) then return "mirror_image 791"; end
        end
        -- guardian_of_azeroth,if=cooldown.combustion.remains<10|target.time_to_die<cooldown.combustion.remains
        if S.GuardianofAzeroth:IsCastableP() and Action.GetToggle(1, "HeartOfAzeroth") and not ShouldStop and (S.Combustion:CooldownRemainsP() < 10 or Target:TimeToDie() < S.Combustion:CooldownRemainsP()) then
            if HR.Cast(S.GuardianofAzeroth, Action.GetToggle(2, "OffGCDasOffGCD")) then return "guardian_of_azeroth 793"; end
        end
        -- concentrated_flame
        if S.ConcentratedFlame:IsCastableP() and Action.GetToggle(1, "HeartOfAzeroth") and not ShouldStop then
            if HR.Cast(S.ConcentratedFlame, Action.GetToggle(2, "OffGCDasOffGCD")) then return "concentrated_flame 795"; end
        end
        -- focused_azerite_beam
        if S.FocusedAzeriteBeam:IsCastableP() and Action.GetToggle(1, "HeartOfAzeroth") and not ShouldStop then
            if HR.Cast(S.FocusedAzeriteBeam, Action.GetToggle(2, "OffGCDasOffGCD")) then return "focused_azerite_beam 797"; end
        end
        -- purifying_blast
        if S.PurifyingBlast:IsCastableP() and Action.GetToggle(1, "HeartOfAzeroth") and not ShouldStop then
            if HR.Cast(S.PurifyingBlast, Action.GetToggle(2, "OffGCDasOffGCD")) then return "purifying_blast 799"; end
        end
        -- ripple_in_space
        if S.RippleInSpace:IsCastableP() and Action.GetToggle(1, "HeartOfAzeroth") and not ShouldStop then
            if HR.Cast(S.RippleInSpace, Action.GetToggle(2, "OffGCDasOffGCD")) then return "ripple_in_space 801"; end
        end
        -- the_unbound_force
        if S.TheUnboundForce:IsCastableP() and Action.GetToggle(1, "HeartOfAzeroth") and not ShouldStop then
            if HR.Cast(S.TheUnboundForce, Action.GetToggle(2, "OffGCDasOffGCD")) then return "the_unbound_force 803"; end
        end
        -- worldvein_resonance
        if S.WorldveinResonance:IsCastableP() and Action.GetToggle(1, "HeartOfAzeroth") and not ShouldStop then
            if HR.Cast(S.WorldveinResonance, Action.GetToggle(2, "OffGCDasOffGCD")) then return "worldvein_resonance 805"; end
        end
        -- rune_of_power,if=talent.firestarter.enabled&firestarter.remains>full_recharge_time|cooldown.combustion.remains>variable.combustion_rop_cutoff&buff.combustion.down|target.time_to_die<cooldown.combustion.remains&buff.combustion.down
        if S.RuneofPower:IsCastableP() and not ShouldStop and (S.Firestarter:IsAvailable() and S.Firestarter:ActiveRemains() > S.RuneofPower:FullRechargeTimeP() or S.Combustion:CooldownRemainsP() > VarCombustionRopCutoff and Player:BuffDownP(S.CombustionBuff) or Target:TimeToDie() < S.Combustion:CooldownRemainsP() and Player:BuffDownP(S.CombustionBuff)) then
            if HR.Cast(S.RuneofPower, Action.GetToggle(2, "OffGCDasOffGCD")) then return "rune_of_power 807"; end
        end
        -- call_action_list,name=combustion_phase,if=(talent.rune_of_power.enabled&cooldown.combustion.remains<=action.rune_of_power.cast_time|cooldown.combustion.ready)&!firestarter.active|buff.combustion.up
        if HR.CDsON() and ((S.RuneofPower:IsAvailable() and S.Combustion:CooldownRemainsP() <= S.RuneofPower:CastTime() or S.Combustion:CooldownUpP()) and not bool(S.Firestarter:ActiveStatus()) or Player:BuffP(S.CombustionBuff)) then
            local ShouldReturn = CombustionPhase(); if ShouldReturn then return ShouldReturn; end
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
        -- fire_blast,use_while_casting=1,use_off_gcd=1,if=(essence.memory_of_lucid_dreams.major|essence.memory_of_lucid_dreams.minor&azerite.blaster_master.enabled)&charges=max_charges&!buff.hot_streak.react&!(buff.heating_up.react&(buff.combustion.up&(action.fireball.in_flight|action.pyroblast.in_flight|action.scorch.executing)|target.health.pct<=30&action.scorch.executing))&!(!buff.heating_up.react&!buff.hot_streak.react&buff.combustion.down&(action.fireball.in_flight|action.pyroblast.in_flight))
        if S.FireBlast:IsReady() and ((S.MemoryofLucidDreams:IsAvailable() or S.MemoryofLucidDreamsMinor:IsAvailable() and S.BlasterMaster:AzeriteEnabled()) and S.FireBlast:ChargesP() == S.FireBlast:MaxCharges() and not Player:BuffP(S.HotStreakBuff) and not (Player:BuffP(S.HeatingUpBuff) and (Player:BuffP(S.CombustionBuff) and (S.Fireball:InFlight() or S.Pyroblast:InFlight() or Player:IsCasting(S.Scorch)) or Target:HealthPercentage() <= 30 and Player:IsCasting(S.Scorch))) and not (not Player:BuffP(S.HeatingUpBuff) and not Player:BuffP(S.HotStreakBuff) and Player:BuffDownP(S.CombustionBuff) and (S.Fireball:InFlight() or S.Pyroblast:InFlight()))) then
            if HR.Cast(S.FireBlast, Action.GetToggle(2, "OffGCDasOffGCD")) then return "fire_blast 830"; end
        end
        -- call_action_list,name=rop_phase,if=buff.rune_of_power.up&buff.combustion.down
        if (Player:BuffP(S.RuneofPowerBuff) and Player:BuffDownP(S.CombustionBuff)) then
            local ShouldReturn = RopPhase(); if ShouldReturn then return ShouldReturn; end
        end
        -- variable,name=fire_blast_pooling,value=talent.rune_of_power.enabled&cooldown.rune_of_power.remains<cooldown.fire_blast.full_recharge_time&(cooldown.combustion.remains>variable.combustion_rop_cutoff|firestarter.active)&(cooldown.rune_of_power.remains<target.time_to_die|action.rune_of_power.charges>0)|cooldown.combustion.remains<action.fire_blast.full_recharge_time+cooldown.fire_blast.duration*azerite.blaster_master.enabled&!firestarter.active&cooldown.combustion.remains<target.time_to_die|talent.firestarter.enabled&firestarter.active&firestarter.remains<cooldown.fire_blast.full_recharge_time+cooldown.fire_blast.duration*azerite.blaster_master.enabled
        if (true) then
            VarFireBlastPooling = num(S.RuneofPower:IsAvailable() and S.RuneofPower:CooldownRemainsP() < S.FireBlast:FullRechargeTimeP() and (S.Combustion:CooldownRemainsP() > VarCombustionRopCutoff or bool(S.Firestarter:ActiveStatus())) and (S.RuneofPower:CooldownRemainsP() < Target:TimeToDie() or S.RuneofPower:ChargesP() > 0) or S.Combustion:CooldownRemainsP() < S.FireBlast:FullRechargeTimeP() + S.FireBlast:BaseDuration() * num(S.BlasterMaster:AzeriteEnabled()) and not bool(S.Firestarter:ActiveStatus()) and S.Combustion:CooldownRemainsP() < Target:TimeToDie() or S.Firestarter:IsAvailable() and bool(S.Firestarter:ActiveStatus()) and S.Firestarter:ActiveRemains() < S.FireBlast:FullRechargeTimeP() + S.FireBlast:BaseDuration() * num(S.BlasterMaster:AzeriteEnabled()))
        end
        -- variable,name=phoenix_pooling,value=talent.rune_of_power.enabled&cooldown.rune_of_power.remains<cooldown.phoenix_flames.full_recharge_time&cooldown.combustion.remains>variable.combustion_rop_cutoff&(cooldown.rune_of_power.remains<target.time_to_die|action.rune_of_power.charges>0)|cooldown.combustion.remains<action.phoenix_flames.full_recharge_time&cooldown.combustion.remains<target.time_to_die
        if (true) then
            VarPhoenixPooling = num(S.RuneofPower:IsAvailable() and S.RuneofPower:CooldownRemainsP() < S.PhoenixFlames:FullRechargeTimeP() and S.Combustion:CooldownRemainsP() > VarCombustionRopCutoff and (S.RuneofPower:CooldownRemainsP() < Target:TimeToDie() or S.RuneofPower:ChargesP() > 0) or S.Combustion:CooldownRemainsP() < S.PhoenixFlames:FullRechargeTimeP() and S.Combustion:CooldownRemainsP() < Target:TimeToDie())
        end
        -- call_action_list,name=standard_rotation
        if (true) then
            local ShouldReturn = StandardRotation(); if ShouldReturn then return ShouldReturn; end
        end
    end
end
-- Finished


-----------------------------------------
--                 ROTATION  
-----------------------------------------

-- [3] is Single rotation (supports all actions)
A[3] = function(icon)
    if APL(icon) then 
        return true 
    end
end