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

Action[ACTION_CONST_PRIEST_SHADOW] = {
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
    PetKick                              = Action.Create({ Type = "SpellSingleColor", ID = 119910, Color = "RED", Desc = "RED Color for Pet Target kick" }),  
    -- Generics Spells
    WhispersoftheDamned                   = Action.Create({ Type = "Spell", ID = 275722     }),
    SearingDialogue                       = Action.Create({ Type = "Spell", ID = 272788     }),
    DeathThroes                           = Action.Create({ Type = "Spell", ID = 278659     }),
    ThoughtHarvester                      = Action.Create({ Type = "Spell", ID = 288340     }),
    SpitefulApparitions                   = Action.Create({ Type = "Spell", ID = 277682     }),
    Shadowform                            = Action.Create({ Type = "Spell", ID = 232698     }),
    MindBlast                             = Action.Create({ Type = "Spell", ID = 8092     }),
    VampiricTouch                         = Action.Create({ Type = "Spell", ID = 34914     }),
    VoidEruption                          = Action.Create({ Type = "Spell", ID = 228260     }),
    DarkAscension                         = Action.Create({ Type = "Spell", ID = 280711     }),
    MindSear                              = Action.Create({ Type = "Spell", ID = 48045     }),
    VoidBolt                              = Action.Create({ Type = "Spell", ID = 205448     }),
    ShadowWordDeath                       = Action.Create({ Type = "Spell", ID = 32379     }),
    SurrenderToMadness                    = Action.Create({ Type = "Spell", ID = 193223     }),
    DarkVoid                              = Action.Create({ Type = "Spell", ID = 263346     }),
    Mindbender                            = Action.Create({ Type = "Spell", ID = 200174     }),
    Shadowfiend                           = Action.Create({ Type = "Spell", ID = 34433     }),
    ShadowCrash                           = Action.Create({ Type = "Spell", ID = 205385     }),
    ShadowWordPain                        = Action.Create({ Type = "Spell", ID = 589     }),
    Misery                                = Action.Create({ Type = "Spell", ID = 238558     }),
    VoidTorrent                           = Action.Create({ Type = "Spell", ID = 263165     }),
    MindFlay                              = Action.Create({ Type = "Spell", ID = 15407     }),
    ShadowWordVoid                        = Action.Create({ Type = "Spell", ID = 205351     }),
    LegacyOfTheVoid                       = Action.Create({ Type = "Spell", ID = 193225     }),
    FortressOfTheMind                     = Action.Create({ Type = "Spell", ID = 193195     }),
    ShadowWordVoid                        = Action.Create({ Type = "Spell", ID = 205351     }),
    Silence                               = Action.Create({ Type = "Spell", ID = 15487     }),
    ChorusofInsanity                      = Action.Create({ Type = "Spell", ID = 278661     }),
    -- Defensive
    Dispersion                            = Action.Create({ Type = "Spell", ID = 47585     }),	
    -- Misc
    Channeling                            = Action.Create({ Type = "Spell", ID = 209274, Hidden = true     }),	-- Show an icon during channeling
	TargetEnemy                           = Action.Create({ Type = "Spell", ID = 44603, Hidden = true     }),	-- Change Target (Tab button)
    StopCast                             = Action.Create({ Type = "Spell", ID = 125145, Hidden = true, Texture = 125145     }),	-- Return the stop cast icon (Fake Polymorph 61721)
    RecklessForceBuff                    = Action.Create({ Type = "Spell", ID = 302932, Hidden = true     }),
    -- Buffs
    ShadowformBuff                        = Action.Create({ Type = "Spell", ID = 232698, Hidden = true     }),
    VoidformBuff                          = Action.Create({ Type = "Spell", ID = 194249, Hidden = true     }),
    HarvestedThoughtsBuff                 = Action.Create({ Type = "Spell", ID = 288343, Hidden = true     }),	
    -- Debuffs 
    VampiricTouchDebuff                   = Action.Create({ Type = "Spell", ID = 34914, Hidden = true     }),
    ShadowWordPainDebuff                  = Action.Create({ Type = "Spell", ID = 589, Hidden = true     }),
    -- Trinkets 
    TrinketTest                          = Action.Create({ Type = "Trinket", ID = 122530, QueueForbidden = true }),
    TrinketTest2                         = Action.Create({ Type = "Trinket", ID = 159611, QueueForbidden = true }), 
    AzsharasFontofPower                  = Action.Create({ Type = "Trinket", ID = 169314, QueueForbidden = true }),
    PocketsizedComputationDevice         = Action.Create({ Type = "Trinket", ID = 167555 }),
    RotcrustedVoodooDoll                 = Action.Create({ Type = "Trinket", ID = 159624, QueueForbidden = true }),
    ShiverVenomRelic                     = Action.Create({ Type = "Trinket", ID = 168905, QueueForbidden = true }),
    ShiverVenomDebuff                     = Action.Create({ Type = "Spell", ID = 301624, Hidden = true}),		
    AquipotentNautilus                   = Action.Create({ Type = "Trinket", ID = 169305, QueueForbidden = true }),
    TidestormCodex                       = Action.Create({ Type = "Trinket", ID = 165576, QueueForbidden = true }),
    VialofStorms                         = Action.Create({ Type = "Trinket", ID = 158224, QueueForbidden = true }),
    -- Potions
    PotionofUnbridledFury                = Action.Create({ Type = "Potion", ID = 169299, QueueForbidden = true }),
    PotionTest                           = Action.Create({ Type = "Potion", ID = 142117, QueueForbidden = true }),
    -- Misc
    CyclotronicBlast                      = Action.Create({ Type = "Spell", ID = 293491, Hidden = true}),
    ConcentratedFlameBurn                 = Action.Create({ Type = "Spell", ID = 295368, Hidden = true}),
    -- Hidden Heart of Azeroth
    VisionofPerfectionMinor               = Action.Create({ Type = "Spell", ID = 296320, Hidden = true}),
    VisionofPerfectionMinor2              = Action.Create({ Type = "Spell", ID = 299367, Hidden = true}),
    VisionofPerfectionMinor3              = Action.Create({ Type = "Spell", ID = 299369, Hidden = true}),
    UnleashHeartOfAzeroth                 = Action.Create({ Type = "Spell", ID = 280431, Hidden = true}),
    BloodoftheEnemy                       = Action.Create({ Type = "HeartOfAzeroth", ID = 297108, Hidden = true}),
    BloodoftheEnemy2                      = Action.Create({ Type = "HeartOfAzeroth", ID = 298273, Hidden = true}),
    BloodoftheEnemy3                      = Action.Create({ Type = "HeartOfAzeroth", ID = 298277, Hidden = true}),
    ConcentratedFlame                     = Action.Create({ Type = "HeartOfAzeroth", ID = 295373, Hidden = true}),
    ConcentratedFlame2                    = Action.Create({ Type = "HeartOfAzeroth", ID = 299349, Hidden = true}),
    ConcentratedFlame3                    = Action.Create({ Type = "HeartOfAzeroth", ID = 299353, Hidden = true}),
    GuardianofAzeroth                     = Action.Create({ Type = "HeartOfAzeroth", ID = 295840, Hidden = true}),
    GuardianofAzeroth2                    = Action.Create({ Type = "HeartOfAzeroth", ID = 299355, Hidden = true}),
    GuardianofAzeroth3                    = Action.Create({ Type = "HeartOfAzeroth", ID = 299358, Hidden = true}),
    FocusedAzeriteBeam                    = Action.Create({ Type = "HeartOfAzeroth", ID = 295258, Hidden = true}),
    FocusedAzeriteBeam2                   = Action.Create({ Type = "HeartOfAzeroth", ID = 299336, Hidden = true}),
    FocusedAzeriteBeam3                   = Action.Create({ Type = "HeartOfAzeroth", ID = 299338, Hidden = true}),
    PurifyingBlast                        = Action.Create({ Type = "HeartOfAzeroth", ID = 295337, Hidden = true}),
    PurifyingBlast2                       = Action.Create({ Type = "HeartOfAzeroth", ID = 299345, Hidden = true}),
    PurifyingBlast3                       = Action.Create({ Type = "HeartOfAzeroth", ID = 299347, Hidden = true}),
    TheUnboundForce                       = Action.Create({ Type = "HeartOfAzeroth", ID = 298452, Hidden = true}),
    TheUnboundForce2                      = Action.Create({ Type = "HeartOfAzeroth", ID = 299376, Hidden = true}),
    TheUnboundForce3                      = Action.Create({ Type = "HeartOfAzeroth", ID = 299378, Hidden = true}),
    RippleInSpace                         = Action.Create({ Type = "HeartOfAzeroth", ID = 302731, Hidden = true}),
    RippleInSpace2                        = Action.Create({ Type = "HeartOfAzeroth", ID = 302982, Hidden = true}),
    RippleInSpace3                        = Action.Create({ Type = "HeartOfAzeroth", ID = 302983, Hidden = true}),
    WorldveinResonance                    = Action.Create({ Type = "HeartOfAzeroth", ID = 295186, Hidden = true}),
    WorldveinResonance2                   = Action.Create({ Type = "HeartOfAzeroth", ID = 298628, Hidden = true}),
    WorldveinResonance3                   = Action.Create({ Type = "HeartOfAzeroth", ID = 299334, Hidden = true}),
    MemoryofLucidDreams                   = Action.Create({ Type = "HeartOfAzeroth", ID = 298357, Hidden = true}),
    MemoryofLucidDreams2                  = Action.Create({ Type = "HeartOfAzeroth", ID = 299372, Hidden = true}),
    MemoryofLucidDreams3                  = Action.Create({ Type = "HeartOfAzeroth", ID = 299374, Hidden = true}),
    -- Here come all the stuff needed by simcraft but not classic spells or items. 
}

-- To create essences use next code:
Action:CreateEssencesFor(ACTION_CONST_PRIEST_SHADOW)        -- where PLAYERSPEC is Constance (example: ACTION_CONST_MONK_BM)

-- This code making shorter access to both tables Action[PLAYERSPEC] and Action
-- However if you prefer long access it still can be used like Action[PLAYERSPEC].Guard:IsReady() and not ShouldStop, it doesn't make any conflict if you will skip shorter access
-- So with shorter access you can just do Action.Guard:IsReady() and not ShouldStop instead of Action[PLAYERSPEC].Guard:IsReady() and not ShouldStop
local A = setmetatable(Action[ACTION_CONST_PRIEST_SHADOW], { __index = Action })

local GetSpellCount = 
GetSpellCount
local IsIndoors, IsStealthed, IsMounted = 
IsIndoors, IsStealthed, IsMounted
local UnitIsPlayer, UnitExists, UnitIsUnit, UnitPower, UnitPowerMax = 
UnitIsPlayer, UnitExists, UnitIsUnit, UnitPower, UnitPowerMax

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
local EnemiesCount;

-- Variables
local VarMindBlastTargets = 0;
local VarSwpTraitRanksCheck = 0;
local VarVtTraitRanksCheck = 0;
local VarVtMisTraitRanksCheck = 0;
local VarVtMisSdCheck = 0;
local VarDotsUp = 0;
S.MindbenderTalent = S.Mindbender

HL:RegisterForEvent(function()
  VarMindBlastTargets = 0
  VarSwpTraitRanksCheck = 0
  VarVtTraitRanksCheck = 0
  VarVtMisTraitRanksCheck = 0
  VarVtMisSdCheck = 0
  VarDotsUp = 0
end, "PLAYER_REGEN_ENABLED")

local EnemyRanges = {40}
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
end

local function HandleMultidots()
    local choice = Action.GetToggle(2, "AutoDotSelection")
       
    if choice == "In Raid" then
		if Player:InRaid() then
    		return true
		else
		    return false
		end
    elseif choice == "In Dungeon" then 
		if Player:InDungeon() then
    		return true
		else
		    return false
		end
	elseif choice == "In PvP" then 	
		if Player:InPvP() then 
    		return true
		else
		    return false
		end		
    elseif choice == "Everywhere" then 
        return true
    else
		return false
    end
	--print(choice)
end


local function num(val)
  if val then return 1 else return 0 end
end

local function bool(val)
  return val ~= 0
end

local function InsanityThreshold ()
	return S.LegacyOfTheVoid:IsAvailable() and 60 or 90;
end
local function ExecuteRange ()
	return 20;
end

local function EvaluateCycleShadowWordDeath84(Target)
  return (Target:TimeToDie() < 3 or Player:BuffDownP(S.VoidformBuff)) and (Target:HealthPercentage() < ExecuteRange ())
end

local function EvaluateCycleMindBlast103(Target)
  return EnemiesCount < VarMindBlastTargets
end

local function EvaluateCycleShadowWordPain114(Target)
  return (Target:DebuffRefreshableCP(S.ShadowWordPainDebuff) and Target:TimeToDie() > ((-1.2 + 3.3 * EnemiesCount) * VarSwpTraitRanksCheck * (1 - 0.012 * S.SearingDialogue:AzeriteRank() * EnemiesCount))) and (not S.Misery:IsAvailable())
end

local function EvaluateCycleVampiricTouch133(Target)
  return (Target:DebuffRefreshableCP(S.VampiricTouchDebuff)) and (Target:TimeToDie() > ((1 + 3.3 * EnemiesCount) * VarVtTraitRanksCheck * (1 + 0.10 * S.SearingDialogue:AzeriteRank() * EnemiesCount)))
end

local function EvaluateCycleVampiricTouch150(Target)
  return (Target:DebuffRefreshableCP(S.ShadowWordPainDebuff)) and ((S.Misery:IsAvailable() and Target:TimeToDie() > ((1.0 + 2.0 * EnemiesCount) * VarVtMisTraitRanksCheck * (VarVtMisSdCheck * EnemiesCount))))
end

local function EvaluateCycleMindSear169(Target)
  return EnemiesCount > 1
end

local function InsanityDrain()
  return (Player:BuffP(S.VoidformBuff)) and (math.ceil(5 + Player:BuffStackP(S.VoidformBuff) * 0.68)) or 0
end

local function Init ()
    HL.RegisterNucleusAbility(228260, 10, 6)               -- Void Eruption 1st Bolt
    HL.RegisterNucleusAbility(228261, 10, 6)               -- Void Eruption 2nd Bolt
    HL.RegisterNucleusAbility(48045, 10, 6)                -- Mind Sear
    HL.RegisterNucleusAbility(49821, 10, 6)                -- Mind Sear 2nd ID
    HL.RegisterNucleusAbility(263346, 10, 6)               -- Dark Void
    HL.RegisterNucleusAbility(205385, 8, 6)                -- Shadow Crash
end
-- Init data for splash data (To Check)
Init()

--- ======= ACTION LISTS =======
local function APL(icon) 
	-- Action specifics remap
	local ShouldStop = Action.ShouldStop()
	local Pull = Action.BossMods_Pulling()
	
	-- Local functions remap
    local InsanityDrain = InsanityDrain()
    EnemiesCount = GetEnemiesCount(40)
    HL.GetEnemies(40, true) -- To populate Cache.Enemies[40] for CastCycles
    DetermineEssenceRanks()
	-- Multidots var
	MissingVampiricTouch = MultiUnits:GetByRangeMissedDoTs(40, 5, 34914) --MultiDots(40, S.FlameShockDebuff, 15, 4) --MultiUnits:GetByRangeMissedDoTs(40, 10, 188389)  MultiUnits:GetByRangeMissedDoTs(range, stop, dots, ttd)
	MissingShadowWordPain = MultiUnits:GetByRangeMissedDoTs(40, 5, 589) --MultiDots(40, S.FlameShockDebuff, 15, 4) --MultiUnits:GetByRangeMissedDoTs(40, 10, 188389)  MultiUnits:GetByRangeMissedDoTs(range, stop, dots, ttd)
    --print(MissingVampiricTouch)
    AppliedVampiricTouch = MultiUnits:GetByRangeAppliedDoTs(40, 5, 34914) --MultiDots(40, S.FlameShockDebuff, 15, 4) --MultiUnits:GetByRangeMissedDoTs(40, 10, 188389)  MultiUnits:GetByRangeMissedDoTs(range, stop, dots, ttd)
 	AppliedShadowWordPain = MultiUnits:GetByRangeAppliedDoTs(40, 5, 589) --MultiDots(40, S.FlameShockDebuff, 15, 4) --MultiUnits:GetByRangeMissedDoTs(40, 10, 188389)  MultiUnits:GetByRangeMissedDoTs(range, stop, dots, ttd)
    --print(AppliedVampiricTouch)
    VampiricTouchToRefresh = MultiUnits:GetByRangeDoTsToRefresh(40, 5, 34914, 5)
    ShadowWordPainToRefresh = MultiUnits:GetByRangeDoTsToRefresh(40, 5, 589, 5)
	--print(VampiricTouchToRefresh)
	local CanMultidot = HandleMultidots()	
	--print(CanMultidot)
	
	if Player:IsChanneling(S.MindFlay) then 
	    ShouldStop = false
	elseif Player:IsChanneling(S.MindSear) then 
	    ShouldStop = false
	else
        ShouldStop = ShouldStop
    end	

    local function Precombat_DBM()
        -- flask
        -- food
        -- augmentation
        -- snapshot_stats
		if Everyone.TargetIsValid() then

            -- variable,name=mind_blast_targets,op=set,value=floor((4.5+azerite.whispers_of_the_damned.rank)%(1+0.27*azerite.searing_dialogue.rank))
            VarMindBlastTargets = math.floor ((4.5 + S.WhispersoftheDamned:AzeriteRank()) / (1 + 0.27 * S.SearingDialogue:AzeriteRank()))
            -- variable,name=swp_trait_ranks_check,op=set,value=(1-0.07*azerite.death_throes.rank+0.2*azerite.thought_harvester.rank)*(1-0.09*azerite.thought_harvester.rank*azerite.searing_dialogue.rank)
            VarSwpTraitRanksCheck = (1 - 0.07 * S.DeathThroes:AzeriteRank() + 0.2 * S.ThoughtHarvester:AzeriteRank()) * (1 - 0.09 * S.ThoughtHarvester:AzeriteRank() * S.SearingDialogue:AzeriteRank())
            -- variable,name=vt_trait_ranks_check,op=set,value=(1-0.04*azerite.thought_harvester.rank-0.05*azerite.spiteful_apparitions.rank)
            VarVtTraitRanksCheck = (1 - 0.04 * S.ThoughtHarvester:AzeriteRank() - 0.05 * S.SpitefulApparitions:AzeriteRank())
            -- variable,name=vt_mis_trait_ranks_check,op=set,value=(1-0.07*azerite.death_throes.rank-0.03*azerite.thought_harvester.rank-0.055*azerite.spiteful_apparitions.rank)*(1-0.027*azerite.thought_harvester.rank*azerite.searing_dialogue.rank)
            VarVtMisTraitRanksCheck = (1 - 0.07 * S.DeathThroes:AzeriteRank() - 0.03 * S.ThoughtHarvester:AzeriteRank() - 0.055 * S.SpitefulApparitions:AzeriteRank()) * (1 - 0.027 * S.ThoughtHarvester:AzeriteRank() * S.SearingDialogue:AzeriteRank())
            -- variable,name=vt_mis_sd_check,op=set,value=1-0.014*azerite.searing_dialogue.rank
            VarVtMisSdCheck = 1 - 0.014 * S.SearingDialogue:AzeriteRank()
            -- Mindbender management
            S.Mindbender = S.MindbenderTalent:IsAvailable() and S.MindbenderTalent or S.Shadowfiend
            -- shadowform,if=!buff.shadowform.up
            if S.Shadowform:IsCastableP() and not ShouldStop and Player:BuffDownP(S.ShadowformBuff) and (not Player:BuffP(S.ShadowformBuff)) then
                if HR.Cast(S.Shadowform, Action.GetToggle(2, "GCDasOffGCD")) then return "shadowform 44"; end
            end

            -- use_item,name=azsharas_font_of_power
            if I.AzsharasFontofPower:IsEquipReady() and TR.TrinketON() and Pull > 0.1 and ((not S.ShadowWordVoid:IsAvailable() and Pull <= S.MindBlast:CastTime() + 5) or (S.ShadowWordVoid:IsAvailable() and Pull <= S.ShadowWordVoid:CastTime() + 5)) then
                if HR.Cast(I.AzsharasFontofPower) then return "azsharas_font_of_power 50"; end
            end
			-- potion
            if I.PotionofUnbridledFury:IsReady() and not ShouldStop and Action.GetToggle(1, "Potion") and Pull > 0.1 and ((not S.ShadowWordVoid:IsAvailable() and Pull <= S.MindBlast:CastTime() + 1) or (S.ShadowWordVoid:IsAvailable() and Pull <= S.ShadowWordVoid:CastTime() + 1)) then
                if HR.Cast(I.PotionofUnbridledFury) then return "battle_potion_of_intellect 4"; end
            end
            -- mind_blast,if=spell_targets.mind_sear<2|azerite.thought_harvester.rank=0
            if S.MindBlast:IsReadyP() and not S.ShadowWordVoid:IsAvailable() and (EnemiesCount < 2 or S.ThoughtHarvester:AzeriteRank() == 0) and not Player:IsCasting(S.MindBlast) and Pull > 0.1 and Pull <= S.MindBlast:CastTime() then
                if HR.Cast(S.MindBlast) then return "mind_blast 54"; end
            end
            -- shadow_word_void (added)
            if S.ShadowWordVoid:IsReadyP() and S.ShadowWordVoid:IsAvailable() and not ShouldStop and (EnemiesCount < 2 or S.ThoughtHarvester:AzeriteRank() == 0) and not Player:IsCasting(S.ShadowWordVoid) and Pull > 0.1 and Pull <= S.ShadowWordVoid:CastTime() then
                if HR.Cast(S.ShadowWordVoid) then return "shadow_word_void added 54"; end
            end
		end
    end	

    local function Precombat()
        -- flask
        -- food
        -- augmentation
        -- snapshot_stats
		if Everyone.TargetIsValid() then
            -- potion
            if I.PotionofUnbridledFury:IsReady() and not ShouldStop and Action.GetToggle(1, "Potion") then
                if HR.Cast(I.PotionofUnbridledFury) then return "battle_potion_of_intellect 4"; end
            end
            -- variable,name=mind_blast_targets,op=set,value=floor((4.5+azerite.whispers_of_the_damned.rank)%(1+0.27*azerite.searing_dialogue.rank))
            VarMindBlastTargets = math.floor ((4.5 + S.WhispersoftheDamned:AzeriteRank()) / (1 + 0.27 * S.SearingDialogue:AzeriteRank()))
            -- variable,name=swp_trait_ranks_check,op=set,value=(1-0.07*azerite.death_throes.rank+0.2*azerite.thought_harvester.rank)*(1-0.09*azerite.thought_harvester.rank*azerite.searing_dialogue.rank)
            VarSwpTraitRanksCheck = (1 - 0.07 * S.DeathThroes:AzeriteRank() + 0.2 * S.ThoughtHarvester:AzeriteRank()) * (1 - 0.09 * S.ThoughtHarvester:AzeriteRank() * S.SearingDialogue:AzeriteRank())
            -- variable,name=vt_trait_ranks_check,op=set,value=(1-0.04*azerite.thought_harvester.rank-0.05*azerite.spiteful_apparitions.rank)
            VarVtTraitRanksCheck = (1 - 0.04 * S.ThoughtHarvester:AzeriteRank() - 0.05 * S.SpitefulApparitions:AzeriteRank())
            -- variable,name=vt_mis_trait_ranks_check,op=set,value=(1-0.07*azerite.death_throes.rank-0.03*azerite.thought_harvester.rank-0.055*azerite.spiteful_apparitions.rank)*(1-0.027*azerite.thought_harvester.rank*azerite.searing_dialogue.rank)
            VarVtMisTraitRanksCheck = (1 - 0.07 * S.DeathThroes:AzeriteRank() - 0.03 * S.ThoughtHarvester:AzeriteRank() - 0.055 * S.SpitefulApparitions:AzeriteRank()) * (1 - 0.027 * S.ThoughtHarvester:AzeriteRank() * S.SearingDialogue:AzeriteRank())
            -- variable,name=vt_mis_sd_check,op=set,value=1-0.014*azerite.searing_dialogue.rank
            VarVtMisSdCheck = 1 - 0.014 * S.SearingDialogue:AzeriteRank()
            -- Mindbender management
            S.Mindbender = S.MindbenderTalent:IsAvailable() and S.MindbenderTalent or S.Shadowfiend
            -- shadowform,if=!buff.shadowform.up
            if S.Shadowform:IsCastableP() and not ShouldStop and Player:BuffDownP(S.ShadowformBuff) and (not Player:BuffP(S.ShadowformBuff)) then
                if HR.Cast(S.Shadowform, Action.GetToggle(2, "GCDasOffGCD")) then return "shadowform 44"; end
            end
            -- use_item,name=azsharas_font_of_power
            if I.AzsharasFontofPower:IsEquipReady() and TR.TrinketON() then
                if HR.Cast(I.AzsharasFontofPower) then return "azsharas_font_of_power 50"; end
            end
            -- mind_blast,if=spell_targets.mind_sear<2|azerite.thought_harvester.rank=0
            if S.MindBlast:IsReadyP() and (EnemiesCount < 2 or S.ThoughtHarvester:AzeriteRank() == 0) and not Player:IsCasting(S.MindBlast) then
                if HR.Cast(S.MindBlast) then return "mind_blast 54"; end
            end
            -- shadow_word_void (added)
            if S.ShadowWordVoid:IsReadyP() and not ShouldStop and (EnemiesCount < 2 or S.ThoughtHarvester:AzeriteRank() == 0) and not Player:IsCasting(S.ShadowWordVoid) then
                if HR.Cast(S.ShadowWordVoid) then return "shadow_word_void added 54"; end
            end
            -- vampiric_touch
            if S.VampiricTouch:IsCastableP() and not Player:IsCasting(S.VampiricTouch) and not Player:PrevGCDP(1, S.VampiricTouch) and not ShouldStop and Player:DebuffDownP(S.VampiricTouchDebuff) then
                if HR.Cast(S.VampiricTouch) then return "vampiric_touch 54"; end
            end
		end
    end
	
    local function CritCds()
        -- use_item,name=azsharas_font_of_power
        if I.AzsharasFontofPower:IsEquipReady() and TR.TrinketON() then
            if HR.Cast(I.AzsharasFontofPower) then return "azsharas_font_of_power critcds"; end
        end
        -- use_item,effect_name=cyclotronic_blast
        if I.PocketsizedComputationDevice:IsEquipReady() and TR.TrinketON() then
            if HR.Cast(I.PocketsizedComputationDevice) then return "pocketsized_computation_device critcds"; end
        end
    end
	
    local function Cds()
        -- memory_of_lucid_dreams,if=(buff.voidform.stack>20&insanity<=50)|buff.voidform.stack>(26+7*buff.bloodlust.up)|(current_insanity_drain*((gcd.max*2)+action.mind_blast.cast_time)>insanity
        if S.MemoryofLucidDreams:IsCastableP() and not ShouldStop and Action.GetToggle(1, "HeartOfAzeroth") and ((Player:BuffStackP(S.VoidformBuff) > 20 and Player:Insanity() <= 50) or Player:BuffStackP(S.VoidformBuff) > (26 + 7 * num(Player:HasHeroism())) or (InsanityDrain * ((Player:GCD() * 2) + S.MindBlast:CastTime())) > Player:Insanity()) then
            if HR.Cast(S.MemoryofLucidDreams) then return "memory_of_lucid_dreams cds"; end
        end
        -- blood_of_the_enemy
        if S.BloodoftheEnemy:IsCastableP() and not ShouldStop and Action.GetToggle(1, "HeartOfAzeroth") then
            if HR.Cast(S.BloodoftheEnemy) then return "blood_of_the_enemy cds"; end
        end
        -- guardian_of_azeroth,if=buff.voidform.stack>15
        if S.GuardianofAzeroth:IsCastableP() and not ShouldStop and Action.GetToggle(1, "HeartOfAzeroth") and (Player:BuffStackP(S.VoidformBuff) > 15) then
            if HR.Cast(S.GuardianofAzeroth) then return "guardian_of_azeroth cds"; end
        end
        -- focused_azerite_beam,if=spell_targets.mind_sear>=2|raid_event.adds.in>60
		if S.FocusedAzeriteBeam:IsCastableP() and not ShouldStop and Action.GetToggle(1, "HeartOfAzeroth") and (EnemiesCount >= 4 or ActionUnit("target"):IsBoss()) then
			if HR.Cast(S.FocusedAzeriteBeam) then return "focused_azerite_beam implosion"; end
		end
        -- purifying_blast,if=spell_targets.mind_sear>=2|raid_event.adds.in>60
        if S.PurifyingBlast:IsCastableP() and not ShouldStop and Action.GetToggle(1, "HeartOfAzeroth") and (EnemiesCount >= 2) then
            if HR.Cast(S.PurifyingBlast) then return "purifying_blast cds"; end
        end
        -- the_unbound_force
        if S.TheUnboundForce:IsCastableP() and not ShouldStop and Action.GetToggle(1, "HeartOfAzeroth") then
            if HR.Cast(S.TheUnboundForce) then return "the_unbound_force cds"; end
        end
        -- concentrated_flame,line_cd=6,if=time<=10|(buff.chorus_of_insanity.stack>=15&buff.voidform.up)|full_recharge_time<gcd|target.time_to_die<5
        if S.ConcentratedFlame:IsCastableP() and not ShouldStop and Action.GetToggle(1, "HeartOfAzeroth") and (HL.CombatTime() <= 10 or (Player:BuffStackP(S.ChorusofInsanity) >= 15 and Player:BuffP(S.VoidformBuff)) or S.ConcentratedFlame:FullRechargeTimeP() < Player:GCD() or Target:TimeToDie() < 5) then
            if HR.Cast(S.ConcentratedFlame) then return "concentrated_flame cds"; end
        end
        -- ripple_in_space
        if S.RippleInSpace:IsCastableP() and not ShouldStop and Action.GetToggle(1, "HeartOfAzeroth") then
            if HR.Cast(S.RippleInSpace) then return "ripple_in_space cds"; end
        end
        -- worldvein_resonance,if=buff.lifeblood.stack<3
        if S.WorldveinResonance:IsCastableP() and not ShouldStop and Action.GetToggle(1, "HeartOfAzeroth") and (Player:BuffStackP(S.LifebloodBuff)) then
            if HR.Cast(S.WorldveinResonance) then return "worldvein_resonance cds"; end
        end
        -- call_action_list,name=crit_cds,if=(buff.voidform.up&buff.chorus_of_insanity.stack>20)|azerite.chorus_of_insanity.rank=0
        if ((Player:BuffP(S.VoidformBuff) and Player:BuffStackP(S.ChorusofInsanity) > 20) or not S.ChorusofInsanity:AzeriteEnabled() and HR.CDsON()) then
            local ShouldReturn = CritCds(); if ShouldReturn then return ShouldReturn; end
        end
        -- use_items
    end
	
	local function AoE25()
		-- vampiric_touch,if=refreshable&target.time_to_die>6|(talent.misery.enabled&dot.shadow_word_pain.refreshable)
        if S.VampiricTouch:IsCastableP() and not Player:IsCasting(S.VampiricTouch) and not Player:PrevGCDP(1, S.VampiricTouch) and not ShouldStop and not  Player:IsMoving() and (Target:DebuffRefreshableCP(S.VampiricTouchDebuff) and Target:TimeToDie() > 6 or (S.Misery:IsAvailable() and Target:DebuffRefreshableCP(S.ShadowWordPainDebuff))) and not Player:IsCasting(S.VampiricTouch) then
            if HR.Cast(S.VampiricTouch) then return "vampiric_touch 266"; end
        end
		
		-- dark_void,if=raid_event.adds.in>10&(dot.shadow_word_pain.refreshable|target.time_to_die>30)
        if S.DarkVoid:IsReadyP() and not ShouldStop and not  Player:IsMoving() and (Target:DebuffRefreshableCP(S.ShadowWordPainDebuff) or Target:TimeToDie() > 30) and not Player:IsCasting(S.DarkVoid) then
            if HR.Cast(S.DarkVoid) then return "dark_void 93"; end
        end
		
		-- shadow_word_pain,if=refreshable&target.time_to_die>4&!talent.misery.enabled&!talent.dark_void.enabled
        if S.ShadowWordPain:IsCastableP() and not ShouldStop and (Target:DebuffRefreshableCP(S.ShadowWordPainDebuff) and Target:TimeToDie() > 4 and not S.Misery:IsAvailable() and (not S.DarkVoid:IsAvailable() or S.DarkVoid:CooldownRemainsP() > 2)) or (Player:IsMoving() and Target:DebuffRefreshableCP(S.ShadowWordPainDebuff) and Target:TimeToDie() > 4) then
            if HR.Cast(S.ShadowWordPain) then return "shadow_word_pain 254"; end
        end
		
		-- void_eruption
        if S.VoidEruption:IsReadyP() and not ShouldStop and not  Player:IsMoving() and Player:Insanity() >= InsanityThreshold() and not Player:IsCasting(S.VoidEruption) then
            if HR.Cast(S.VoidEruption, Action.GetToggle(2, "GCDasOffGCD")) then return "void_eruption 58"; end
        end
		
		-- dark_ascension,if=buff.voidform.down
        if S.DarkAscension:IsReadyP() and not ShouldStop and (Player:BuffDownP(S.VoidformBuff)) and not Player:IsCasting(S.VoidEruption) then
            if HR.Cast(S.DarkAscension) then return "dark_ascension 60"; end
        end
		
		-- mind_sear,if=buff.harvested_thoughts.up
        if S.MindSear:IsCastableP() and not ShouldStop and (Player:BuffP(S.HarvestedThoughtsBuff)) then
            if HR.Cast(S.MindSear) then return "mind_sear 74"; end
        end
		
		-- void_bolt
        if S.VoidBolt:IsReadyP() or Player:IsCasting(S.VoidEruption) then
            if HR.Cast(S.VoidBolt) then return "void_bolt 182"; end
        end
		
		-- shadow_crash,if=(raid_event.adds.in>5&raid_event.adds.duration<2)|raid_event.adds.duration>2
        if S.ShadowCrash:IsReadyP() and not ShouldStop and Player:IsMoving() and not Player:IsCasting(S.ShadowCrash) then
            if HR.Cast(S.ShadowCrash) then return "shadow_crash 108"; end
        end
		
		-- shadow_word_death channeling
        if S.ShadowWordDeath:IsReadyP() and EnemiesCount < 4 and S.ShadowWordDeath:CooldownRemainsP() < 0.2 and not Player:IsMoving() and (Player:IsChanneling(S.MindSear) or Player:IsChanneling(S.MindFlay)) then
            if HR.Cast(S.ShadowWordDeath) then return "MindBlast 182"; end
        end	
		
		-- mind_blast_if channeling
        if Player:BuffP(S.VoidformBuff) and EnemiesCount < 4 and S.MindBlast:CooldownRemainsP() < 0.2 and S.MindBlast:IsReadyP() and not Player:IsMoving() and (Player:IsChanneling(S.MindSear) or Player:IsChanneling(S.MindFlay)) then
            if HR.Cast(S.MindBlast) then return "MindBlast 182"; end
        end	
		
		if (HR.CDsON()) then
            local ShouldReturn = Cds(); if ShouldReturn then return ShouldReturn; end
        end
		
		-- surrender_to_madness,if=buff.voidform.stack>10+(10*buff.bloodlust.up)
        if S.SurrenderToMadness:IsReadyP() and not ShouldStop and (Player:BuffStackP(S.VoidformBuff) > 10 + (10 * num(Player:HasHeroism()))) then
            if HR.Cast(S.SurrenderToMadness, Action.GetToggle(2, "GCDasOffGCD")) then return "surrender_to_madness 89"; end
        end
		
		-- mindbender
        if S.Mindbender:IsReadyP() and not ShouldStop then
            if HR.Cast(S.Mindbender, Action.GetToggle(2, "GCDasOffGCD")) then return "mindbender 97"; end
        end
		
		-- mind_blast,target_if=spell_targets.mind_sear<variable.mind_blast_targets
        if S.MindBlast:IsReadyP() and not ShouldStop and EnemiesCount < 4 and not Player:IsMoving() and EvaluateCycleMindBlast103(Target) and not Player:IsCasting(S.MindBlast) then
            if HR.Cast(S.MindBlast) then return "mind_blast 107" end
        end	
		
        -- shadow_word_void (added)
        if S.ShadowWordVoid:IsReadyP() and not ShouldStop and EnemiesCount < 4 and EvaluateCycleMindBlast103(Target) and not (Player:IsCasting(S.ShadowWordVoid) and not Player:IsMoving() and S.ShadowWordVoid:ChargesP() == 1) then
            if HR.Cast(S.ShadowWordVoid) then return "shadow_word_void added 107" end
        end
		
		-- mind_sear,target_if=spell_targets.mind_sear>1,chain=1,interrupt_immediate=1,interrupt_if=ticks>=2
        if S.MindSear:IsCastableP() and not ShouldStop and EvaluateCycleMindSear169(Target) then
            if HR.Cast(S.MindSear) then return "mind_sear 171" end
        end	
	end
	
    local function Cleave()
        -- void_eruption
        if S.VoidEruption:IsReadyP() and not ShouldStop and Player:Insanity() >= InsanityThreshold() and not Player:IsCasting(S.VoidEruption) then
            if HR.Cast(S.VoidEruption, Action.GetToggle(2, "GCDasOffGCD")) then return "void_eruption 58"; end
        end
        -- dark_ascension,if=buff.voidform.down
        if S.DarkAscension:IsReadyP() and not ShouldStop and (Player:BuffDownP(S.VoidformBuff)) and not Player:IsCasting(S.VoidEruption) then
            if HR.Cast(S.DarkAscension) then return "dark_ascension 60"; end
        end
        -- vampiric_touch,if=!ticking&azerite.thought_harvester.rank>=1
        if S.VampiricTouch:IsCastableP() and not ShouldStop and (not Target:DebuffP(S.VampiricTouchDebuff) and S.ThoughtHarvester:AzeriteRank() >= 1)  and not Player:IsCasting(S.VampiricTouch) and not Player:PrevGCDP(1, S.VampiricTouch) then
            if HR.Cast(S.VampiricTouch) then return "vampiric_touch 64"; end
        end
        -- mind_sear,if=buff.harvested_thoughts.up
        if S.MindSear:IsCastableP() and not ShouldStop and (Player:BuffP(S.HarvestedThoughtsBuff)) then
            if HR.Cast(S.MindSear) then return "mind_sear 74"; end
        end
        -- void_bolt
        if S.VoidBolt:IsReadyP() or Player:IsCasting(S.VoidEruption) then
            if HR.Cast(S.VoidBolt) then return "void_bolt 78"; end
        end
        -- shadow_word_death channeling
        if S.ShadowWordDeath:IsReadyP() and S.ShadowWordDeath:CooldownRemainsP() < 0.2 and (Player:IsChanneling(S.MindSear) or Player:IsChanneling(S.MindFlay)) then
            if HR.Cast(S.ShadowWordDeath) then return "MindBlast 182"; end
        end	
        -- mind_blast_if channeling
        if Player:BuffP(S.VoidformBuff) and S.MindBlast:CooldownRemainsP() < 0.2 and S.MindBlast:IsReadyP() and (Player:IsChanneling(S.MindSear) or Player:IsChanneling(S.MindFlay)) then
            if HR.Cast(S.MindBlast) then return "MindBlast 182"; end
        end	
        -- void_bolt_if channeling
        --if Player:BuffP(S.VoidformBuff) and S.VoidBolt:CooldownRemainsP() < 0.2 and (Player:IsChanneling(S.MindSear) or Player:IsChanneling(S.MindFlay)) then
        --    if HR.Cast(S.VoidBolt) then return "void_bolt 182"; end
        --end		
        -- call_action_list,name=cds
        if (HR.CDsON()) then
            local ShouldReturn = Cds(); if ShouldReturn then return ShouldReturn; end
        end
        -- shadow_word_death,target_if=target.time_to_die<3|buff.voidform.down
        if S.ShadowWordDeath:IsReadyP() and not ShouldStop and EvaluateCycleShadowWordDeath84(Target) then
            if HR.Cast(S.ShadowWordDeath) then return "shadow_word_death 88" end
        end
        -- surrender_to_madness,if=buff.voidform.stack>10+(10*buff.bloodlust.up)
        if S.SurrenderToMadness:IsReadyP() and not ShouldStop and (Player:BuffStackP(S.VoidformBuff) > 10 + (10 * num(Player:HasHeroism()))) then
            if HR.Cast(S.SurrenderToMadness, Action.GetToggle(2, "GCDasOffGCD")) then return "surrender_to_madness 89"; end
        end
        -- dark_void,if=raid_event.adds.in>10&(dot.shadow_word_pain.refreshable|target.time_to_die>30)
        if S.DarkVoid:IsReadyP() and not ShouldStop and (Target:DebuffRefreshableCP(S.ShadowWordPainDebuff) or Target:TimeToDie() > 30) and not Player:IsCasting(S.DarkVoid) then
            if HR.Cast(S.DarkVoid) then return "dark_void 93"; end
        end
        -- mindbender
        if S.Mindbender:IsReadyP() and not ShouldStop then
            if HR.Cast(S.Mindbender, Action.GetToggle(2, "GCDasOffGCD")) then return "mindbender 97"; end
        end
        -- mind_blast,target_if=spell_targets.mind_sear<variable.mind_blast_targets
        if S.MindBlast:IsReadyP() and not ShouldStop and EvaluateCycleMindBlast103(Target) and not Player:IsCasting(S.MindBlast) then
            if HR.Cast(S.MindBlast) then return "mind_blast 107" end
        end	
        -- shadow_word_void (added)
        if S.ShadowWordVoid:IsReadyP() and not ShouldStop and EvaluateCycleMindBlast103(Target) and not (Player:IsCasting(S.ShadowWordVoid) and S.ShadowWordVoid:ChargesP() == 1) then
            if HR.Cast(S.ShadowWordVoid) then return "shadow_word_void added 107" end
        end
        -- shadow_crash,if=(raid_event.adds.in>5&raid_event.adds.duration<2)|raid_event.adds.duration>2
        if S.ShadowCrash:IsReadyP() and not ShouldStop and not Player:IsCasting(S.ShadowCrash) then
            if HR.Cast(S.ShadowCrash) then return "shadow_crash 108"; end
        end
        -- shadow_word_pain,target_if=refreshable&target.time_to_die>((-1.2+3.3*spell_targets.mind_sear)*variable.swp_trait_ranks_check*(1-0.012*azerite.searing_dialogue.rank*spell_targets.mind_sear)),if=!talent.misery.enabled
        if S.ShadowWordPain:IsCastableP() and not S.Misery:IsAvailable() and not ShouldStop and EvaluateCycleShadowWordPain114(Target) then
            if HR.Cast(S.ShadowWordPain) then return "shadow_word_pain 128" end
        end
        -- vampiric_touch,target_if=refreshable,if=target.time_to_die>((1+3.3*spell_targets.mind_sear)*variable.vt_trait_ranks_check*(1+0.10*azerite.searing_dialogue.rank*spell_targets.mind_sear))
        if S.VampiricTouch:IsCastableP() and not Player:IsCasting(S.VampiricTouch) and not Player:PrevGCDP(1, S.VampiricTouch)  and not ShouldStop and EvaluateCycleVampiricTouch133(Target) then
            if HR.Cast(S.VampiricTouch) then return "vampiric_touch 145" end
        end
        -- vampiric_touch,target_if=dot.shadow_word_pain.refreshable,if=(talent.misery.enabled&target.time_to_die>((1.0+2.0*spell_targets.mind_sear)*variable.vt_mis_trait_ranks_check*(variable.vt_mis_sd_check*spell_targets.mind_sear)))
        if S.VampiricTouch:IsCastableP() and not Player:IsCasting(S.VampiricTouch) and not Player:PrevGCDP(1, S.VampiricTouch) and not ShouldStop and EvaluateCycleVampiricTouch150(Target) then
            if HR.Cast(S.VampiricTouch) then return "vampiric_touch 160" end
        end
        -- void_torrent,if=buff.voidform.up
        if S.VoidTorrent:IsReadyP() and not ShouldStop and (Player:BuffP(S.VoidformBuff)) and not Player:IsCasting(S.VoidTorrent) then
            if HR.Cast(S.VoidTorrent) then return "void_torrent 161"; end
        end		
        -- mind_sear,target_if=spell_targets.mind_sear>1,chain=1,interrupt_immediate=1,interrupt_if=ticks>=2
        if S.MindSear:IsCastableP() and not ShouldStop and EvaluateCycleMindSear169(Target) then
            if HR.Cast(S.MindSear) then return "mind_sear 171" end
        end
        -- mind_flay,chain=1,interrupt_immediate=1,interrupt_if=ticks>=2&(cooldown.void_bolt.up|cooldown.mind_blast.up)
        if S.MindFlay:IsCastableP() and not ShouldStop then
            if HR.Cast(S.MindFlay) then return "mind_flay 172"; end
        end
        -- shadow_word_pain
        if S.ShadowWordPain:IsCastableP() and not S.Misery:IsAvailable() and not ShouldStop then
            if HR.Cast(S.ShadowWordPain) then return "shadow_word_pain 174"; end
        end
    end
		
    local function Single()
		-- vampiric_touch,if=refreshable&target.time_to_die>6|(talent.misery.enabled&dot.shadow_word_pain.refreshable)
        if S.VampiricTouch:IsCastableP() and not Player:IsCasting(S.VampiricTouch) and not Player:PrevGCDP(1, S.VampiricTouch) and not ShouldStop and not  Player:IsMoving() and (Target:DebuffRefreshableCP(S.VampiricTouchDebuff) and Target:TimeToDie() > 6 or (S.Misery:IsAvailable() and Target:DebuffRefreshableCP(S.ShadowWordPainDebuff))) and not Player:IsCasting(S.VampiricTouch) then
            if HR.Cast(S.VampiricTouch) then return "vampiric_touch 266"; end
        end

		-- shadow_word_pain,if=refreshable&target.time_to_die>4&!talent.misery.enabled&!talent.dark_void.enabled
        if S.ShadowWordPain:IsCastableP() and not ShouldStop and (Target:DebuffRefreshableCP(S.ShadowWordPainDebuff) and Target:TimeToDie() > 4 and not S.Misery:IsAvailable()) or (Player:IsMoving() and Target:DebuffRefreshableCP(S.ShadowWordPainDebuff) and Target:TimeToDie() > 4) then
            if HR.Cast(S.ShadowWordPain) then return "shadow_word_pain 254"; end
        end

        -- void_eruption
        if S.VoidEruption:IsReadyP() and not ShouldStop and not  Player:IsMoving() and Player:Insanity() >= InsanityThreshold() and not Player:IsCasting(S.VoidEruption) then
            if HR.Cast(S.VoidEruption, Action.GetToggle(2, "GCDasOffGCD")) then return "void_eruption 176"; end
        end
        -- dark_ascension,if=buff.voidform.down
        if S.DarkAscension:IsReadyP() and not ShouldStop and (Player:BuffDownP(S.VoidformBuff)) and not Player:IsCasting(S.VoidEruption) then
            if HR.Cast(S.DarkAscension) then return "dark_ascension 178"; end
        end
		-- void_bolt
        if S.VoidBolt:IsReadyP() or Player:IsCasting(S.VoidEruption) then
            if HR.Cast(S.VoidBolt) then return "void_bolt 182"; end
        end
        -- shadow_word_death channeling
        if S.ShadowWordDeath:IsReadyP() and (Player:IsChanneling(S.MindSear) or Player:IsChanneling(S.MindFlay)) then
            if HR.Cast(S.ShadowWordDeath) then return "MindBlast 182"; end
        end	
        -- mind_blast_if channeling
        if S.MindBlast:IsReadyP() and (Player:IsChanneling(S.MindSear) or Player:IsChanneling(S.MindFlay)) then
            if HR.Cast(S.MindBlast) then return "MindBlast 182"; end
        end	
        
        -- void_bolt_if channeling
      --  if Player:BuffP(S.VoidformBuff) and S.VoidBolt:CooldownRemainsP() < 0.1 and (Player:IsChanneling(S.MindSear) or Player:IsChanneling(S.MindFlay)) then
      --      if HR.Cast(S.VoidBolt) then return "void_bolt 182"; end
      --  end			
        -- call_action_list,name=cds
        if (HR.CDsON()) then
            local ShouldReturn = Cds(); if ShouldReturn then return ShouldReturn; end
        end		
        -- mind_sear,if=buff.harvested_thoughts.up&cooldown.void_bolt.remains>=1.5&azerite.searing_dialogue.rank>=1
        if S.MindSear:IsCastableP() and not ShouldStop and (Player:BuffP(S.HarvestedThoughtsBuff) and S.VoidBolt:CooldownRemainsP() >= 1.5 and S.SearingDialogue:AzeriteRank() >= 1) then
            if HR.Cast(S.MindSear) then return "mind_sear 184"; end
        end
        -- shadow_word_death,if=target.time_to_die<3|cooldown.shadow_word_death.charges=2|(cooldown.shadow_word_death.charges=1&cooldown.shadow_word_death.remains<gcd.max)
        if S.ShadowWordDeath:IsReadyP() and not ShouldStop and (Target:TimeToDie() < 3 or S.ShadowWordDeath:ChargesP() == 2 or (S.ShadowWordDeath:ChargesP() == 1 and S.ShadowWordDeath:CooldownRemainsP() < Player:GCD())) and Target:HealthPercentage() < ExecuteRange () then
            if HR.Cast(S.ShadowWordDeath) then return "shadow_word_death 192"; end
        end
        -- surrender_to_madness,if=buff.voidform.stack>10+(10*buff.bloodlust.up)
        if S.SurrenderToMadness:IsReadyP() and not ShouldStop and (Player:BuffStackP(S.VoidformBuff) > 10 + (10 * num(Player:HasHeroism()))) then
            if HR.Cast(S.SurrenderToMadness, Action.GetToggle(2, "GCDasOffGCD")) then return "surrender_to_madness 200"; end
        end
        
        -- mindbender,if=talent.mindbender.enabled|(buff.voidform.stack>18|target.time_to_die<15)
        if S.Mindbender:IsReadyP() and not ShouldStop and (S.MindbenderTalent:IsAvailable() or (Player:BuffStackP(S.VoidformBuff) > 18 or Target:TimeToDie() < 15)) then
            if HR.Cast(S.Mindbender, Action.GetToggle(2, "GCDasOffGCD")) then return "mindbender 206"; end
        end
        -- shadow_word_death,if=!buff.voidform.up|(cooldown.shadow_word_death.charges=2&buff.voidform.stack<15)
        if S.ShadowWordDeath:IsReadyP() and not ShouldStop and (not Player:BuffP(S.VoidformBuff) or (S.ShadowWordDeath:ChargesP() == 2 and Player:BuffStackP(S.VoidformBuff) < 15)) and Target:HealthPercentage() < ExecuteRange () then
            if HR.Cast(S.ShadowWordDeath) then return "shadow_word_death 212"; end
        end
        -- shadow_crash,if=raid_event.adds.in>5&raid_event.adds.duration<20
        if S.ShadowCrash:IsReadyP() and not ShouldStop and not Player:IsCasting(S.ShadowCrash) and Player:IsMoving() then
            if HR.Cast(S.ShadowCrash) then return "shadow_crash 220"; end
        end
        -- mind_blast,if=variable.dots_up&((raid_event.movement.in>cast_time+0.5&raid_event.movement.in<4)|!talent.shadow_word_void.enabled|buff.voidform.down|buff.voidform.stack>14&(insanity<70|charges_fractional>1.33)|buff.voidform.stack<=14&(insanity<60|charges_fractional>1.33))
        if S.MindBlast:IsReadyP() and (bool(VarDotsUp) and 
        (not S.ShadowWordVoid:IsAvailable() or Player:BuffDownP(S.VoidformBuff) or Player:BuffStackP(S.VoidformBuff) > 14 and 
            (Player:Insanity() < 70 or S.MindBlast:ChargesFractionalP() > 1.33) 
            or Player:BuffStackP(S.VoidformBuff) <= 14 and (Player:Insanity() < 60 or S.MindBlast:ChargesFractionalP() > 1.33))) 
        and not Player:IsCasting(S.MindBlast) then
            if HR.Cast(S.MindBlast) then return "mind_blast 222"; end
        end
        -- shadow_word_void (added)--and not Player:IsCasting(S.ShadowWordVoid)
        if S.ShadowWordVoid:IsReadyP() and not ShouldStop and not  Player:IsMoving() and bool(VarDotsUp) then
            if HR.Cast(S.ShadowWordVoid) then return "shadow_word_void added 222"; end
        end
		
		-- dark_void,if=raid_event.adds.in>10
        if S.DarkVoid:IsReadyP() and not ShouldStop and not Player:BuffP(S.VoidformBuff) then
            if HR.Cast(S.DarkVoid) then return "dark_void 204"; end
        end
		
        -- void_torrent,if=dot.shadow_word_pain.remains>4&dot.vampiric_touch.remains>4&buff.voidform.up
        if S.VoidTorrent:IsReadyP() and not ShouldStop and (Target:DebuffRemainsP(S.ShadowWordPainDebuff) > 4 and Target:DebuffRemainsP(S.VampiricTouchDebuff) > 4 and Player:BuffP(S.VoidformBuff)) then
            if HR.Cast(S.VoidTorrent) then return "void_torrent 246"; end
        end
        -- shadow_word_pain,if=refreshable&target.time_to_die>4&!talent.misery.enabled&!talent.dark_void.enabled
        if S.ShadowWordPain:IsCastableP() and not ShouldStop and (Target:DebuffRefreshableCP(S.ShadowWordPainDebuff) and Target:TimeToDie() > 4 and not S.Misery:IsAvailable() and not S.DarkVoid:IsAvailable()) then
            if HR.Cast(S.ShadowWordPain) then return "shadow_word_pain 254"; end
        end
        
        -- mind_flay,chain=1,interrupt_immediate=1,interrupt_if=ticks>=2&(cooldown.void_bolt.up|cooldown.mind_blast.up)
        if S.MindFlay:IsCastableP() and not ShouldStop then
            if HR.Cast(S.MindFlay) then return "mind_flay 278"; end
        end
       
    end
	
	local function MultidotsRefresh()
	    -- vampiric_touch
        if S.VampiricTouch:IsCastableP() and not ShouldStop and Target:DebuffRemainsP(S.VampiricTouchDebuff) <= 10 and not Player:IsCasting(S.VampiricTouch) and not Player:PrevGCDP(1, S.VampiricTouch) then
            if HR.Cast(S.VampiricTouch) then return "vampiric_touch 266"; end
        end
        -- shadow_word_pain
        if S.ShadowWordPain:IsCastableP() and not S.Misery:IsAvailable() and not Player:PrevGCDP(1, S.ShadowWordPain) and not ShouldStop and Target:DebuffRemainsP(S.ShadowWordPainDebuff) <= 10 then
            if HR.Cast(S.ShadowWordPain) then return "shadow_word_pain 280"; end
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

	------------------------------------------------------
	---------------- MOUSE OVER ROTATION -----------------
	------------------------------------------------------
	-- Mouseover DPS Rotation
	-- Only handling mouseover multidots and dots refreshable
	local function MouseoverRotation(unit)
		
		-- Variables
        inRange = A.VampiricTouch:IsInRange(unit)
				
		-- Vampiric Touch
        if A.VampiricTouch:IsReady(unit) and not ShouldStop and ActionUnit(unit):HasDeBuffs(A.VampiricTouchDebuff.ID) <= 10 and not Player:PrevGCDP(1, S.VampiricTouch) then
            if HR.Cast(S.VampiricTouch) then return "vampiric_touch 266"; end
        end
        -- shadow_word_pain
        if A.ShadowWordPain:IsReady(unit) and not S.Misery:IsAvailable() and not Player:PrevGCDP(1, S.ShadowWordPain) and not ShouldStop and ActionUnit(unit):HasDeBuffs(A.ShadowWordPainDebuff.ID) <= 10 then
            if HR.Cast(S.ShadowWordPain) then return "shadow_word_pain 280"; end
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
		
		-- Silence
        if useKick and S.Silence:IsReady() and not ShouldStop then 
		    if ActionUnit(unit):CanInterrupt(true, nil, 25, 70) then
                if HR.Cast(S.Silence, true) then return "Silence 5"; end
            end 
        end 		
		
		-- Mouseover rotation         
        if Action.IsUnitEnemy("mouseover") and Action.GetToggle(2, "mouseover") then 
            unit = "mouseover"
                
            if MouseoverRotation(unit) then 
                return true 
            end 

        end	
			
		-- Auto Multi Dot	  
	    if S.TargetEnemy:TimeSinceLastCast() >= 2 and not Player:PrevGCDP(1, S.TargetEnemy) and not Player:PrevGCDP(2, S.TargetEnemy) and not Player:PrevGCDP(3, S.TargetEnemy) and not Player:PrevGCDP(4, S.TargetEnemy) and Action.GetToggle(2, "AutoDot") and CanMultidot 
		and ((MissingShadowWordPain >= 1 or MissingVampiricTouch >= 1) or (AppliedVampiricTouch < EnemiesCount or AppliedShadowWordPain < EnemiesCount) or (VampiricTouchToRefresh >= 1 or ShadowWordPainToRefresh >= 1)) 
		and EnemiesCount > 1 and EnemiesCount <= 10 and Target:DebuffRemainsP(S.ShadowWordPainDebuff) >= 6 and Target:DebuffRemainsP(S.VampiricTouchDebuff) >= 6 then
            if HR.Cast(S.TargetEnemy) then return "TargetEnemy 69" end
        end	
        -- Multidots Refresh
        if Action.GetToggle(2, "AutoDot") and EnemiesCount > 2 and EnemiesCount <= 5 and ((MissingShadowWordPain >= 1 or MissingVampiricTouch >= 1) or (VampiricTouchToRefresh >= 1 or ShadowWordPainToRefresh >= 1)) then
            local ShouldReturn = MultidotsRefresh(); if ShouldReturn then return ShouldReturn; end
        end 		
		-- Dispersion if activated
		if S.Dispersion:IsCastableP() and Player:HealthPercentage() <= Action.GetToggle(2, "DispersionHP") and Action.GetToggle(2, "UseDispersion") then
		    if HR.Cast(S.Dispersion, true) then return "Dispersion 5"; end
		end
        -- potion,if=buff.bloodlust.react|target.time_to_die<=80|target.health.pct<35
        if I.PotionofUnbridledFury:IsReady() and not ShouldStop and Action.GetToggle(1, "Potion") and (Player:HasHeroism() or Target:TimeToDie() <= 80 or Target:HealthPercentage() < 35) then
            if HR.Cast(I.PotionofUnbridledFury) then return "battle_potion_of_intellect 283"; end
        end
        -- use_item,name=shiver_venom_relicif=!buff.ca_inc.up,target_if=dot.shiver_venom.stack>=5
        if I.ShiverVenomRelic:IsEquipped() and I.ShiverVenomRelic:IsReady() and TR.TrinketON() and Target:DebuffStackP(S.ShiverVenomDebuff) >= 5 then
            if HR.CastCycle(I.ShiverVenomRelic) then return "shiver_venom_relic 105"; end
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
        -- variable,name=dots_up,op=set,value=dot.shadow_word_pain.ticking&dot.vampiric_touch.ticking
        VarDotsUp = num(Target:DebuffP(S.ShadowWordPainDebuff) and Target:DebuffP(S.VampiricTouchDebuff))
        -- berserking
        if S.Berserking:IsCastableP() and not ShouldStop and HR.CDsON() then
            if HR.Cast(S.Berserking, Action.GetToggle(2, "GCDasOffGCD")) then return "berserking 271"; end
        end
		-- Shadow Word Death allowed to cut Mindsear & Mindflay
		if (Player:IsChanneling(S.MindSear) or Player:IsChanneling(S.MindFlay)) and S.ShadowWordDeath:IsCastableP() then 
		    if HR.Cast(S.ShadowWordDeath) then return "StopCast" end		
		end
		-- Mind Blast allowed to cut Mindsear & Mindflay
		if (Player:IsChanneling(S.MindSear) or Player:IsChanneling(S.MindFlay)) and S.MindBlast:CooldownRemainsP() < 0.1 then 
		    if HR.Cast(S.MindBlast) then return "StopCast" end		
		end

		-- Void Form allowed to cut Mindsear & Mindflay
		--if (Player:IsChanneling(S.MindSear) or Player:IsChanneling(S.MindFlay)) and S.VoidEruption:CooldownRemainsP() < 0.1 then 
		--    if HR.Cast(S.StopCast) then return "StopCast" end		
		--end

		-- Void Bolt allowed to cut Mindsear & Mindflay
		if (Player:IsChanneling(S.MindSear) or Player:IsChanneling(S.MindFlay)) and Player:BuffP(S.VoidformBuff) and S.VoidBolt:CooldownRemainsP() < 0.1 then 
		    if HR.Cast(S.VoidBolt) then return "StopCast" end		
		end		
        -- run_action_list,name=cleave,if=active_enemies>1
        if (EnemiesCount > 1) and HR.AoEON() then
           local ShouldReturn = AoE25(); if ShouldReturn then return ShouldReturn; end
        end
        -- run_action_list,name=single,if=active_enemies=1
        if (EnemiesCount == 1) or not HR.AoEON() then
            local ShouldReturn = Single(); if ShouldReturn then return ShouldReturn; end
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

