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

Action[ACTION_CONST_DRUID_BALANCE] = {
    -- Racial
    ArcaneTorrent                         = Action.Create({ Type = "Spell", ID = 50613     }),
    BloodFury                             = Action.Create({ Type = "Spell", ID = 20572      }),
    Fireblood                             = Action.Create({ Type = "Spell", ID = 265221     }),
    AncestralCall                         = Action.Create({ Type = "Spell", ID = 274738     }),
    Berserking                            = Action.Create({ Type = "Spell", ID = 26297    }),
    ArcanePulse                           = Action.Create({ Type = "Spell", ID = 260364    }),
    QuakingPalm                           = Action.Create({ Type = "Spell", ID = 107079     }),
    Haymaker                              = Action.Create({ Type = "Spell", ID = 287712     }), 
    BullRush                              = Action.Create({ Type = "Spell", ID = 255654     }),    
    WarStomp                              = Action.Create({ Type = "Spell", ID = 20549     }),
    GiftofNaaru                           = Action.Create({ Type = "Spell", ID = 59544    }),
    Shadowmeld                            = Action.Create({ Type = "Spell", ID = 58984    }), -- usable in Action Core 
    Stoneform                             = Action.Create({ Type = "Spell", ID = 20594    }), 
    WilloftheForsaken                     = Action.Create({ Type = "Spell", ID = 7744        }), -- not usable in APL but user can Queue it    
    EscapeArtist                          = Action.Create({ Type = "Spell", ID = 20589    }), -- not usable in APL but user can Queue it
    EveryManforHimself                    = Action.Create({ Type = "Spell", ID = 59752    }), -- not usable in APL but user can Queue it
    PetKick                               = Action.Create({ Type = "Spell", ID = 47482, Color = "RED", Desc = "RED" }),  
    -- Generics Spells 
    StreakingStars                        = Action.Create({ Type = "Spell", ID = 272871     }),
    ArcanicPulsar                         = Action.Create({ Type = "Spell", ID = 287773     }),
    Starlord                              = Action.Create({ Type = "Spell", ID = 202345     }),
    TwinMoons                             = Action.Create({ Type = "Spell", ID = 279620     }),
    MoonkinForm                           = Action.Create({ Type = "Spell", ID = 24858     }),
    SolarWrath                            = Action.Create({ Type = "Spell", ID = 190984     }),
    LightsJudgment                        = Action.Create({ Type = "Spell", ID = 255647     }),
    WarriorofElune                        = Action.Create({ Type = "Spell", ID = 202425     }),
    Innervate                             = Action.Create({ Type = "Spell", ID = 29166     }),
    LivelySpirit                          = Action.Create({ Type = "Spell", ID = 279642     }),
    Incarnation                           = Action.Create({ Type = "Spell", ID = 102560     }),
    CelestialAlignment                    = Action.Create({ Type = "Spell", ID = 194223     }),
    StellarFlare                          = Action.Create({ Type = "Spell", ID = 202347     }),
    FuryofElune                           = Action.Create({ Type = "Spell", ID = 202770     }),
    ForceofNature                         = Action.Create({ Type = "Spell", ID = 205636     }),
    Starfall                              = Action.Create({ Type = "Spell", ID = 191034     }),
    Starsurge                             = Action.Create({ Type = "Spell", ID = 78674     }),
    Sunfire                               = Action.Create({ Type = "Spell", ID = 93402     }),
    Moonfire                              = Action.Create({ Type = "Spell", ID = 8921     }),
    NewMoon                               = Action.Create({ Type = "Spell", ID = 274281     }),
    HalfMoon                              = Action.Create({ Type = "Spell", ID = 274282     }),
    FullMoon                              = Action.Create({ Type = "Spell", ID = 274283     }),
    LunarStrike                           = Action.Create({ Type = "Spell", ID = 194153     }),
    ShootingStars                         = Action.Create({ Type = "Spell", ID = 202342     }),
    NaturesBalance                        = Action.Create({ Type = "Spell", ID = 202430     }),
    Renewal                               = Action.Create({ Type = "Spell", ID = 108238     }),
    SolarBeam                             = Action.Create({ Type = "Spell", ID = 78675     }),
    CyclotronicBlast                      = Action.Create({ Type = "Spell", ID = 167672     }),
    ConcentratedFlameBurn                 = Action.Create({ Type = "Spell", ID = 295368     }),
    Thorns                                = Action.Create({ Type = "Spell", ID = 236696     }),
	-- Utilities
	Typhoon                               = Action.Create({ Type = "Spell", ID = 132469   }),
	MightyBash                            = Action.Create({ Type = "Spell", ID = 5211   }),
	Soothe                                = Action.Create({ Type = "Spell", ID = 2908   }),
    -- Defensive
	Barkskin                              = Action.Create({ Type = "Spell", ID = 22812   }),	
    -- Buffs
    ArcanicPulsarBuff                     = Action.Create({ Type = "Spell", ID = 287790     }),
    StarlordBuff                          = Action.Create({ Type = "Spell", ID = 279709     }),
    LivelySpiritBuff                      = Action.Create({ Type = "Spell", ID = 279646     }),	
    LunarEmpowermentBuff                  = Action.Create({ Type = "Spell", ID = 164547     }),
    SolarEmpowermentBuff                  = Action.Create({ Type = "Spell", ID = 164545     }),
    WarriorofEluneBuff                    = Action.Create({ Type = "Spell", ID = 202425     }),	
    AzsharasFontofPowerBuff               = Action.Create({ Type = "Spell", ID = 296962     }),
    RecklessForceBuff                     = Action.Create({ Type = "Spell", ID = 302932     }),	
    OwlkinFrenzyBuff                      = Action.Create({ Type = "Spell", ID = 157228     }),	
	-- Debuffs 
    SunfireDebuff                         = Action.Create({ Type = "Spell", ID = 164815     }),
    MoonfireDebuff                        = Action.Create({ Type = "Spell", ID = 164812     }),
    StellarFlareDebuff                    = Action.Create({ Type = "Spell", ID = 202347     }),
    ShiverVenomDebuff                     = Action.Create({ Type = "Spell", ID = 301624     }),		
    -- Misc
    Channeling                            = Action.Create({ Type = "Spell", ID = 209274, Hidden = true     }),	
    -- Trinkets    
    MalformedHeraldsLegwraps             = Action.Create({ Type = "Trinket", ID = 167835}),
    HyperthreadWristwraps                = Action.Create({ Type = "Trinket", ID = 168989}),
    NotoriousAspirantsBadge              = Action.Create({ Type = "Trinket", ID = 167528}),
    NotoriousGladiatorsBadge             = Action.Create({ Type = "Trinket", ID = 167380}),
    SinisterGladiatorsBadge              = Action.Create({ Type = "Trinket", ID = 165058}),
    SinisterAspirantsBadge               = Action.Create({ Type = "Trinket", ID = 165223}),
    DreadGladiatorsBadge                 = Action.Create({ Type = "Trinket", ID = 161902}),
    DreadAspirantsBadge                  = Action.Create({ Type = "Trinket", ID = 162966}),
    DreadCombatantsInsignia              = Action.Create({ Type = "Trinket", ID = 161676}),
    NotoriousAspirantsMedallion          = Action.Create({ Type = "Trinket", ID = 167525}),
    NotoriousGladiatorsMedallion         = Action.Create({ Type = "Trinket", ID = 167377}),
    SinisterGladiatorsMedallion          = Action.Create({ Type = "Trinket", ID = 165055}),
    SinisterAspirantsMedallion           = Action.Create({ Type = "Trinket", ID = 165220}),
    DreadGladiatorsMedallion             = Action.Create({ Type = "Trinket", ID = 161674}),
    DreadAspirantsMedallion              = Action.Create({ Type = "Trinket", ID = 162897}),
    DreadCombatantsMedallion             = Action.Create({ Type = "Trinket", ID = 161811}),
    IgnitionMagesFuse                    = Action.Create({ Type = "Trinket", ID = 159615}),
    TzanesBarkspines                     = Action.Create({ Type = "Trinket", ID = 161411}),
    AzurethoseSingedPlumage              = Action.Create({ Type = "Trinket", ID = 161377}),
    AncientKnotofWisdomAlliance          = Action.Create({ Type = "Trinket", ID = 161417}),
    AncientKnotofWisdomHorde             = Action.Create({ Type = "Trinket", ID = 166793}),
    ShockbitersFang                      = Action.Create({ Type = "Trinket", ID = 169318}),
    NeuralSynapseEnhancer                = Action.Create({ Type = "Trinket", ID = 168973}),
    BalefireBranch                       = Action.Create({ Type = "Trinket", ID = 159630}),    
    
    TrinketTest                           = Action.Create({ Type = "Trinket", ID = 122530, QueueForbidden = true }),
    TrinketTest2                          = Action.Create({ Type = "Trinket", ID = 159611, QueueForbidden = true }), 
    AzsharasFontofPower                   = Action.Create({ Type = "Trinket", ID = 169314, QueueForbidden = true }),
    PocketsizedComputationDevice          = Action.Create({ Type = "Trinket", ID = 167555 }),
    RotcrustedVoodooDoll                  = Action.Create({ Type = "Trinket", ID = 159624, QueueForbidden = true }),
    ShiverVenomRelic                      = Action.Create({ Type = "Trinket", ID = 168905, QueueForbidden = true }),
    AquipotentNautilus                    = Action.Create({ Type = "Trinket", ID = 169305, QueueForbidden = true }),
    TidestormCodex                        = Action.Create({ Type = "Trinket", ID = 165576, QueueForbidden = true }),
    VialofStorms                          = Action.Create({ Type = "Trinket", ID = 158224, QueueForbidden = true }),
	AshvanesRazorCoral                    = Action.Create({ Type = "Trinket", ID = 169311, QueueForbidden = true }),
    -- Potions
    PotionofUnbridledFury                 = Action.Create({ Type = "Potion", ID = 169299, QueueForbidden = true }),
    PotionofFocusedResolve                = Action.Create({ Type = "Potion", ID = 168506, QueueForbidden = true }),
    PotionTest                            = Action.Create({ Type = "Potion", ID = 142117, QueueForbidden = true }),
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
	CondensedLifeforce                    = Action.Create({ Type = "HeartOfAzeroth", ID = 295834, Hidden = true}),
	CondensedLifeforce2                   = Action.Create({ Type = "HeartOfAzeroth", ID = 299354, Hidden = true}),
	CondensedLifeforce3                   = Action.Create({ Type = "HeartOfAzeroth", ID = 299357, Hidden = true}),
    -- Here come all the stuff needed by simcraft but not classic spells or items. 
}

-- To create essences use next code:
Action:CreateEssencesFor(ACTION_CONST_DRUID_BALANCE)        -- where PLAYERSPEC is Constance (example: ACTION_CONST_MONK_BM)

-- This code making shorter access to both tables Action[PLAYERSPEC] and Action
-- However if you prefer long access it still can be used like Action[PLAYERSPEC].Guard:IsReady(), it doesn't make any conflict if you will skip shorter access
-- So with shorter access you can just do Action.Guard:IsReady() instead of Action[PLAYERSPEC].Guard:IsReady()
local A = setmetatable(Action[ACTION_CONST_DRUID_BALANCE], { __index = Action })

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


-- Rotation Var
local ShouldReturn; -- Used to get the return string
local ForceOffGCD = {true, false};
local Everyone = HR.Commons.Everyone;
local EnemiesCount;

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
    S.CondensedLifeforce = S.CondensedLifeforce2:IsAvailable() and S.CondensedLifeforce2 or S.CondensedLifeforce
    S.CondensedLifeforce = S.CondensedLifeforce3:IsAvailable() and S.CondensedLifeforce3 or S.CondensedLifeforce
end

-- Variables
local VarAzSs = 0;
local VarAzAp = 0;
local VarSfTargets = 0;

HL:RegisterForEvent(function()
    VarAzSs = 0
    VarAzAp = 0
    VarSfTargets = 0
end, "PLAYER_REGEN_ENABLED")

local EnemyRanges = {40, 15, 8}
local function UpdateRanges()
    for _, i in ipairs(EnemyRanges) do
        HL.GetEnemies(i);
    end
end

local function num(val)
    if val then return 1 else return 0 end
end

local function bool(val)
    return val ~= 0
end

local function FutureAstralPower()
    local AstralPower=Player:AstralPower()
    if not Player:IsCasting() then
        return AstralPower
    else
        if Player:IsCasting(S.NewMoon) then
            return AstralPower + 10
        elseif Player:IsCasting(S.HalfMoon) then
            return AstralPower + 20
        elseif Player:IsCasting(S.FullMoon) then
            return AstralPower + 40
        elseif Player:IsCasting(S.StellarFlare) then
            return AstralPower + 8
        elseif Player:IsCasting(S.SolarWrath) then
            return AstralPower + 8
        elseif Player:IsCasting(S.LunarStrike) then
            return AstralPower + 12
        else
           return AstralPower
        end
    end
end

local function CaInc()
    return S.Incarnation:IsAvailable() and S.Incarnation or S.CelestialAlignment
end

local function AP_Check(spell)
  local APGen = 0
  local CurAP = Player:AstralPower()
  if spell == S.Sunfire or spell == S.Moonfire then 
    APGen = 3
  elseif spell == S.StellarFlare or spell == S.SolarWrath then
    APGen = 8
  elseif spell == S.Incarnation or spell == S.CelestialAlignment then
    APGen = 40
  elseif spell == S.ForceofNature then
    APGen = 20
  elseif spell == S.LunarStrike then
    APGen = 12
  end
  
  if S.ShootingStars:IsAvailable() then 
    APGen = APGen + 4
  end
  if S.NaturesBalance:IsAvailable() then
    APGen = APGen + 2
  end
  
  if CurAP + APGen < Player:AstralPowerMax() then
    return true
  else
    return false
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

local function DoTsUp()
    return (Target:DebuffP(S.MoonfireDebuff) and Target:DebuffP(S.Sunfire) and (not S.StellarFlare:IsAvailable() or Target:DebuffP(S.StellarFlareDebuff)))
end

local function EvaluateCycleGuardianofAzeroth78(Target)
    return (Target:DebuffP(S.MoonfireDebuff) and Target:DebuffP(S.SunfireDebuff) and (not S.StellarFlare:IsAvailable() or Target:DebuffP(S.StellarFlareDebuff))) and ((not S.Starlord:IsAvailable() or Player:BuffP(S.StarlordBuff)) and Player:BuffDownP(CaInc()))
end

local function EvaluateCyclePocketsizedComputationDevice103(Target)
    return (Target:DebuffP(S.MoonfireDebuff) and Target:DebuffP(S.SunfireDebuff) and (not S.StellarFlare:IsAvailable() or Target:DebuffP(S.StellarFlareDebuff))) and (I.PocketsizedComputationDevice:IsEquipped() and Player:BuffDownP(CaInc()))
end

local function EvaluateCycleMemoryofLucidDreams135(Target)
    return (Target:DebuffRemainsP(S.SunfireDebuff) > 10 and Target:DebuffRemainsP(S.MoonfireDebuff) > 10 and (not S.StellarFlare:IsAvailable() or Target:DebuffRemainsP(S.StellarFlareDebuff) > 10)) and (Player:BuffDownP(CaInc()) and (FutureAstralPower() < 25 or CaInc():CooldownRemainsP() > 30))
end

local function EvaluateCycleTheUnboundForce160(Target)
    return (Target:DebuffP(S.MoonfireDebuff) and Target:DebuffP(S.SunfireDebuff) and (not S.StellarFlare:IsAvailable() or Target:DebuffP(S.StellarFlareDebuff))) and (Player:BuffP(S.RecklessForceBuff))
end

local function EvaluateCycleFocusedAzeriteBeam179(Target)
    return (Target:DebuffP(S.MoonfireDebuff) and Target:DebuffP(S.SunfireDebuff) and (not S.StellarFlare:IsAvailable() or Target:DebuffP(S.StellarFlareDebuff))) and ((not bool(VarAzSs) or Player:BuffDownP(CaInc())))
end

local function EvaluateCycleSunfire250(Target)
    return (Target:DebuffRefreshableCP(S.SunfireDebuff)) and (AP_Check(S.Sunfire) and math.floor (Target:TimeToDie() / (2 * Player:SpellHaste())) * EnemiesCount >= math.ceil (math.floor (2 / EnemiesCount) * 1.5) + 2 * EnemiesCount and (EnemiesCount > 1 + num(S.TwinMoons:IsAvailable()) or Target:DebuffP(S.MoonfireDebuff)) and (not bool(VarAzSs) or Player:BuffDownP(CaInc()) or not Player:PrevGCDP(1, S.Sunfire)) and (Player:BuffRemainsP(CaInc()) > Target:DebuffRemainsP(S.SunfireDebuff) or Player:BuffDownP(CaInc())))
end

local function EvaluateCycleMoonfire313(Target)
    return (Target:DebuffRefreshableCP(S.MoonfireDebuff)) and (AP_Check(S.Moonfire) and math.floor (Target:TimeToDie() / (2 * Player:SpellHaste())) * EnemiesCount >= 6 and (not bool(VarAzSs) or Player:BuffDownP(CaInc()) or not Player:PrevGCDP(1, S.Moonfire)) and (Player:BuffRemainsP(CaInc()) > Target:DebuffRemainsP(S.MoonfireDebuff) or Player:BuffDownP(CaInc())))
end

local function EvaluateCycleStellarFlare348(Target)
    return (S.StreakingStars:AzeriteEnabled() and not Player:PrevGCDP(1, S.StellarFlare) or not S.StreakingStars:AzeriteEnabled()) and (Target:DebuffRefreshableCP(S.StellarFlareDebuff)) and (AP_Check(S.StellarFlare) and math.floor (Target:TimeToDie() / (2 * Player:SpellHaste())) >= 5 and (not bool(VarAzSs) or Player:BuffDownP(CaInc()) or not Player:PrevGCDP(1, S.StellarFlare)) and not Player:IsCasting(S.StellarFlare))
end

-- Initiate Nucleus Ability registration
local function Init()
    HL.RegisterNucleusAbility(164815, 8, 6)               -- Sunfire DoT
    HL.RegisterNucleusAbility(191037, 15, 6)              -- Starfall
    HL.RegisterNucleusAbility(194153, 8, 6)               -- Lunar Strike
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
    HL.GetEnemies(40) -- To populate Cache.Enemies[40] for CastCycles
	DetermineEssenceRanks()
	CaInc()
	
  	local function Precombat_DBM()	    
        -- flask
        -- food
        -- augmentation
        -- variable,name=az_ss,value=azerite.streaking_stars.rank
        if (true) then
            VarAzSs = S.StreakingStars:AzeriteRank()
        end
        -- variable,name=az_ap,value=azerite.arcanic_pulsar.rank
        if (true) then
            VarAzAp = S.ArcanicPulsar:AzeriteRank()
        end
        -- variable,name=sf_targets,value=4
        if (true) then
            VarSfTargets = 4
        end
        -- variable,name=sf_targets,op=add,value=1,if=azerite.arcanic_pulsar.enabled
        if (S.ArcanicPulsar:AzeriteEnabled()) then
            VarSfTargets = VarSfTargets + 1
        end
        -- variable,name=sf_targets,op=add,value=1,if=talent.starlord.enabled
        if (S.Starlord:IsAvailable()) then
            VarSfTargets = VarSfTargets + 1
        end
        -- variable,name=sf_targets,op=add,value=1,if=azerite.streaking_stars.rank>2&azerite.arcanic_pulsar.enabled
        if (S.StreakingStars:AzeriteRank() > 2 and S.ArcanicPulsar:AzeriteEnabled()) then
            VarSfTargets = VarSfTargets + 1
        end
        -- variable,name=sf_targets,op=sub,value=1,if=!talent.twin_moons.enabled
        if (not S.TwinMoons:IsAvailable()) then
            VarSfTargets = VarSfTargets - 1
        end
        -- moonkin_form
        if S.MoonkinForm:IsCastableP() and not ShouldStop and Player:BuffDownP(S.MoonkinForm) then
            if HR.Cast(S.MoonkinForm, Action.GetToggle(2, "GCDasOffGCD")) then return "moonkin_form 39"; end
        end
        -- snapshot_stats
        -- potion,dynamic_prepot=1
        if I.PotionofUnbridledFury:IsReady() and Action.GetToggle(1, "Potion") and Pull > 1 and Pull <= (S.SolarWrath:CastTime() + S.SolarWrath:TravelTime() + 1) then
            if HR.Cast(I.PotionofUnbridledFury) then return "battle_potion_of_intellect 42"; end
        end
        -- solar_wrath
        if S.SolarWrath:IsReady() and (S.StreakingStars:AzeriteEnabled() and not Player:PrevGCDP(1, S.StellarFlare) or not S.StreakingStars:AzeriteEnabled()) and not Player:IsCasting(S.SolarWrath) and Pull > 0.1 and Pull <= S.SolarWrath:CastTime() + S.SolarWrath:TravelTime() then
            if HR.Cast(S.SolarWrath) then return "solar_wrath 44"; end
        end
    end	
 
    local function Precombat()
        -- flask
        -- food
        -- augmentation
        -- snapshot_stats
		if Everyone.TargetIsValid() then
        -- variable,name=az_ss,value=azerite.streaking_stars.rank
        if (true) then
            VarAzSs = S.StreakingStars:AzeriteRank()
        end
        -- variable,name=az_ap,value=azerite.arcanic_pulsar.rank
        if (true) then
            VarAzAp = S.ArcanicPulsar:AzeriteRank()
        end
        -- variable,name=sf_targets,value=4
        if (true) then
            VarSfTargets = 4
        end
        -- variable,name=sf_targets,op=add,value=1,if=azerite.arcanic_pulsar.enabled
        if (S.ArcanicPulsar:AzeriteEnabled()) then
            VarSfTargets = VarSfTargets + 1
        end
        -- variable,name=sf_targets,op=add,value=1,if=talent.starlord.enabled
        if (S.Starlord:IsAvailable()) then
            VarSfTargets = VarSfTargets + 1
        end
        -- variable,name=sf_targets,op=add,value=1,if=azerite.streaking_stars.rank>2&azerite.arcanic_pulsar.enabled
        if (S.StreakingStars:AzeriteRank() > 2 and S.ArcanicPulsar:AzeriteEnabled()) then
            VarSfTargets = VarSfTargets + 1
        end
        -- variable,name=sf_targets,op=sub,value=1,if=!talent.twin_moons.enabled
        if (not S.TwinMoons:IsAvailable()) then
            VarSfTargets = VarSfTargets - 1
        end
        -- moonkin_form
        if S.MoonkinForm:IsCastableP() and not ShouldStop and Player:BuffDownP(S.MoonkinForm) then
            if HR.Cast(S.MoonkinForm, Action.GetToggle(2, "GCDasOffGCD")) then return "moonkin_form 39"; end
        end
        -- use_item,name=azsharas_font_of_power
        if I.AzsharasFontofPower:IsEquipped() and I.AzsharasFontofPower:IsReady() and TR.TrinketON() then
            if HR.Cast(I.AzsharasFontofPower) then return "azsharas_font_of_power precombat"; end
        end
        -- potion,dynamic_prepot=1
        if I.PotionofUnbridledFury:IsReady() and Action.GetToggle(1, "Potion") then
            if HR.Cast(I.PotionofUnbridledFury) then return "battle_potion_of_intellect 42"; end
        end
        -- solar_wrath
        if S.SolarWrath:IsCastableP() and (S.StreakingStars:AzeriteEnabled() and not Player:PrevGCDP(1, S.SolarWrath) or not S.StreakingStars:AzeriteEnabled()) and not ShouldStop and (not Player:PrevGCDP(1, S.SolarWrath) and not Player:PrevGCDP(2, S.SolarWrath)) then
            if HR.Cast(S.SolarWrath) then return "solar_wrath 43"; end
        end
        -- solar_wrath
        if S.SolarWrath:IsCastableP() and (S.StreakingStars:AzeriteEnabled() and not Player:PrevGCDP(1, S.SolarWrath) or not S.StreakingStars:AzeriteEnabled()) and not ShouldStop and (Player:PrevGCDP(1, S.SolarWrath) and not Player:PrevGCDP(2, S.SolarWrath)) then
            if HR.Cast(S.SolarWrath) then return "solar_wrath 44"; end
        end
        -- starsurge
        if S.Starsurge:IsReadyP() then
            if HR.Cast(S.Starsurge) then return "starsurge 45"; end
        end
		end
    end
	
	-- Cooldows
	local function CDs()
	    -- actions.cds+=/call_action_list,name=essences

        -- Suggest moonkin form if you're not in it.
        -- potion,if=buff.celestial_alignment.up|buff.incarnation.up
        -- blood_fury,if=buff.celestial_alignment.up|buff.incarnation.up
        if S.BloodFury:IsReady() and HR.CDsON() and (Player:BuffP(S.CelestialAlignment) or Player:BuffP(S.Incarnation)) then
            if HR.Cast(S.BloodFury) then return "" end
        end
        -- arcane_torrent,if=buff.celestial_alignment.up|buff.incarnation.up
        if S.ArcaneTorrent:IsReady() and HR.CDsON() and (Player:BuffP(S.CelestialAlignment) or Player:BuffP(S.Incarnation)) then
            if HR.Cast(S.ArcaneTorrent) then return "" end
        end
        -- lights_judgment,if=buff.celestial_alignment.up|buff.incarnation.up
        if S.LightsJudgment:IsReady() and HR.CDsON() and (Player:BuffP(S.CelestialAlignment) or Player:BuffP(S.Incarnation)) then
            if HR.Cast(S.LightsJudgment) then return "" end
        end
        -- warrior_of_elune
        if S.WarriorofElune:IsReady() and not Player:BuffP(S.WarriorofElune) then
            if HR.Cast(S.WarriorofElune) then return "" end
        end	
        -- incarnation,if=dot.sunfire.remains>8&dot.moonfire.remains>12&(dot.stellar_flare.remains>6|!talent.stellar_flare.enabled)&(buff.memory_of_lucid_dreams.up|ap_check)&!buff.ca_inc.up
        if S.Incarnation:IsCastableP() and (Target:DebuffRemainsP(S.SunfireDebuff) > 8 and Target:DebuffRemainsP(S.MoonfireDebuff) > 12 and (Target:DebuffRemainsP(S.StellarFlareDebuff) > 6 or not S.StellarFlare:IsAvailable()) and (Player:BuffP(S.MemoryofLucidDreams) or AP_Check(S.Incarnation)) and not Player:BuffP(CaInc())) then
            if HR.Cast(S.Incarnation) then return "" end
        end
        -- celestial_alignment,if=!buff.ca_inc.up&(buff.memory_of_lucid_dreams.up|(ap_check&astral_power>=40))&(!azerite.lively_spirit.enabled|buff.lively_spirit.up)&(dot.sunfire.remains>2&dot.moonfire.ticking&(dot.stellar_flare.ticking|!talent.stellar_flare.enabled))
        -- and   
        if S.CelestialAlignment:IsCastableP() and not Player:BuffP(CaInc()) and (Player:BuffP(S.MemoryofLucidDreams) or (AP_Check(S.CelestialAlignment) and FutureAstralPower() >= 40)) and (Target:DebuffRemainsP(S.SunfireDebuff) > 2 and Target:DebuffP(S.MoonfireDebuff) and (Target:DebuffP(S.StellarFlareDebuff) or not S.StellarFlare:IsAvailable())) then
           if HR.Cast(S.CelestialAlignment) then return "" end
        end
        -- use_item,use_off_gcd=1,name=balefire_branch,if=buff.combustion.up|action.meteor.in_flight&action.meteor.in_flight_remains<=0.5
        if I.BalefireBranch:IsEquipped() and I.BalefireBranch:IsReady() and TR.TrinketON() then
            if HR.Cast(I.BalefireBranch) then return "balefire_branch combustion"; end
        end
	    -- fury_of_elune,if=(buff.celestial_alignment.up|buff.incarnation.up)|(cooldown.celestial_alignment.remains>30|cooldown.incarnation.remains>30)
        if S.FuryofElune:IsReady() and ((Player:BuffP(CaInc())) or (S.CelestialAlignment:CooldownRemainsP() > 30 or S.Incarnation:CooldownRemainsP() > 30)) then
            if HR.Cast(S.FuryofElune) then return "" end
        end
        -- force_of_nature,if=(buff.celestial_alignment.up|buff.incarnation.up)|(cooldown.celestial_alignment.remains>30|cooldown.incarnation.remains>30)
        if S.ForceofNature:IsReady() and ((Player:BuffP(CaInc())) or (S.CelestialAlignment:CooldownRemainsP() > 30 or S.Incarnation:CooldownRemainsP() > 30)) then
            if HR.Cast(S.ForceofNature) then return "" end
       end
	    -- call_action_list,name=essences
        -- berserking,if=buff.ca_inc.up
        if S.Berserking:IsCastableP() and not ShouldStop and HR.CDsON() and (Player:BuffP(CaInc())) then
            if HR.Cast(S.Berserking, Action.GetToggle(2, "GCDasOffGCD")) then return "berserking 65"; end
        end
        -- use_item,name=azsharas_font_of_power,if=!buff.ca_inc.up,target_if=dot.moonfire.ticking&dot.sunfire.ticking&(!talent.stellar_flare.enabled|dot.stellar_flare.ticking)
        if I.AzsharasFontofPower:IsEquipped() and I.AzsharasFontofPower:IsReady() and TR.TrinketON() and (Player:BuffDownP(CaInc()) and DoTsUp())then
            if HR.Cast(I.AzsharasFontofPower) then return "azsharas_font_of_power 73" end
        end
        -- guardian_of_azeroth,if=(!talent.starlord.enabled|buff.starlord.up)&!buff.ca_inc.up,target_if=dot.moonfire.ticking&dot.sunfire.ticking&(!talent.stellar_flare.enabled|dot.stellar_flare.ticking)
        if S.GuardianofAzeroth:IsCastableP() and not ShouldStop and Action.GetToggle(1, "HeartOfAzeroth") and EvaluateCycleGuardianofAzeroth78(Target) then
            if HR.Cast(S.GuardianofAzeroth) then return "guardian_of_azeroth 94" end
        end
        -- use_item,effect_name=cyclotronic_blast,if=!buff.ca_inc.up,target_if=dot.moonfire.ticking&dot.sunfire.ticking&(!talent.stellar_flare.enabled|dot.stellar_flare.ticking)
        if I.PocketsizedComputationDevice:IsEquipped() and EvaluateCyclePocketsizedComputationDevice103(Target) and I.PocketsizedComputationDevice:IsReady() and S.CyclotronicBlast:IsAvailable() and TR.TrinketON() then
            if HR.Cast(I.PocketsizedComputationDevice) then return "pocketsized_computation_device 117" end
        end
        -- use_item,name=shiver_venom_relicif=!buff.ca_inc.up,target_if=dot.shiver_venom.stack>=5
        if I.ShiverVenomRelic:IsEquipped() and I.ShiverVenomRelic:IsReady() and TR.TrinketON() and Target:DebuffStackP(S.ShiverVenomDebuff) >= 5 then
            if HR.Cast(I.ShiverVenomRelic) then return "shiver_venom_relic 105"; end
        end
        -- blood_of_the_enemy,if=cooldown.ca_inc.remains>30
        if S.BloodoftheEnemy:IsCastableP() and not ShouldStop and Action.GetToggle(1, "HeartOfAzeroth") and Action.GetToggle(1, "HeartOfAzeroth") and (CaInc():CooldownRemainsP() > 30) then
            if HR.Cast(S.BloodoftheEnemy) then return "blood_of_the_enemy"; end
        end
        -- memory_of_lucid_dreams,if=!buff.ca_inc.up&(astral_power<25|cooldown.ca_inc.remains>30),target_if=dot.sunfire.remains>10&dot.moonfire.remains>10&(!talent.stellar_flare.enabled|dot.stellar_flare.remains>10)
        if S.MemoryofLucidDreams:IsCastableP() and not ShouldStop and Action.GetToggle(1, "HeartOfAzeroth") and EvaluateCycleMemoryofLucidDreams135(Target) then
            if HR.Cast(S.MemoryofLucidDreams) then return "memory_of_lucid_dreams 149" end
        end
        -- purifying_blast
        if S.PurifyingBlast:IsCastableP() and not ShouldStop and Action.GetToggle(1, "HeartOfAzeroth") then
            if HR.Cast(S.PurifyingBlast) then return "purifying_blast"; end
        end
        -- ripple_in_space
        if S.RippleInSpace:IsCastableP() and not ShouldStop and Action.GetToggle(1, "HeartOfAzeroth") then
            if HR.Cast(S.RippleInSpace) then return "ripple_in_space"; end
        end
        -- concentrated_flame
        if S.ConcentratedFlame:IsCastableP() and not ShouldStop and Action.GetToggle(1, "HeartOfAzeroth") then
            if HR.Cast(S.ConcentratedFlame) then return "concentrated_flame"; end
        end
        -- the_unbound_force,if=buff.reckless_force.up,target_if=dot.moonfire.ticking&dot.sunfire.ticking&(!talent.stellar_flare.enabled|dot.stellar_flare.ticking)
        if S.TheUnboundForce:IsCastableP() and not ShouldStop and Action.GetToggle(1, "HeartOfAzeroth") and EvaluateCycleTheUnboundForce160(Target) then
            if HR.Cast(S.TheUnboundForce) then return "the_unbound_force 172" end
        end
        -- worldvein_resonance
        if S.WorldveinResonance:IsCastableP() and not ShouldStop and Action.GetToggle(1, "HeartOfAzeroth") then
            if HR.Cast(S.WorldveinResonance) then return "worldvein_resonance"; end
        end
        -- focused_azerite_beam,if=(!variable.az_ss|!buff.ca_inc.up),target_if=dot.moonfire.ticking&dot.sunfire.ticking&(!talent.stellar_flare.enabled|dot.stellar_flare.ticking)
        if S.FocusedAzeriteBeam:IsCastableP() and not ShouldStop and Action.GetToggle(1, "HeartOfAzeroth") and EvaluateCycleFocusedAzeriteBeam179(Target) then
            if HR.Cast(S.FocusedAzeriteBeam) then return "focused_azerite_beam 193" end
        end
    end
	
    local function Dot()
        -- TODO(mrdmnd): add conditions on azerite traits
        -- Code largely lifted from assassination implmentation.
        --actions+=/sunfire,
        --          target_if=refreshable|(variable.az_hn=3&active_enemies<=2&(dot.moonfire.ticking|time_to_die<=6.6)&(!talent.stellar_flare.enabled|dot.stellar_flare.ticking|time_to_die<=7.2)&astral_power<40),
        --          if=astral_power.deficit>=7&target.time_to_die>5.4&(!buff.celestial_alignment.up&!buff.incarnation.up|!variable.az_streak|!prev_gcd.1.sunfire)|variable.az_hn=3
        --actions+=/moonfire,
        --          target_if=refreshable,
        --          if=astral_power.deficit>=7&target.time_to_die>6.6&(!buff.celestial_alignment.up&!buff.incarnation.up|!variable.az_streak|!prev_gcd.1.moonfire)
        --actions+=/stellar_flare,
        --          target_if=refreshable,
        --          if=astral_power.deficit>=12&target.time_to_die>7.2&(!buff.celestial_alignment.up&!buff.incarnation.up|!variable.az_streak|!prev_gcd.1.stellar_flare)
        local function Evaluate_Sunfire_Target(TargetUnit)
            return TargetUnit:DebuffRefreshableCP(S.SunfireDebuff) and Target:TimeToDie() > 5.4
        end
        local function Evaluate_Moonfire_Target(TargetUnit)
            return TargetUnit:DebuffRefreshableCP(S.MoonfireDebuff) and Target:TimeToDie() > 6.6
        end
        local function Evaluate_StellarFlare_Target(TargetUnit)
            return TargetUnit:DebuffRefreshableCP(S.StellarFlare) and Target:TimeToDie() > 7.2
        end

        -- main target refreshes
        if Evaluate_Sunfire_Target(Target) then
            if HR.Cast(S.Sunfire) then return "" end
        end
        if Evaluate_Moonfire_Target(Target) then
            if HR.Cast(S.Moonfire) then return "" end
        end
        if S.StellarFlare:IsReady() and not Player:PrevGCDP(1, S.StellarFlare) and Evaluate_StellarFlare_Target(Target) then
            if HR.Cast(S.StellarFlare) then return "" end
        end
    end
	
	local function EmpowermentCapCheck()
        -- TODO(mrdmnd) - add conditions on azerite traits
        --actions+=/lunar_strike,
        --          if=astral_power.deficit>=16&
        --          (buff.lunar_empowerment.stack=3|(spell_targets<3 & astral_power>=40 & (buff.lunar_empowerment.stack=2&buff.solar_empowerment.stack=2)))&
        --          !(variable.az_hn=3&active_enemies=1)&
        --          !(spell_targets.moonfire>=2&variable.az_potm=3&active_enemies=2)
        --actions+=/solar_wrath,
        --          if=astral_power.deficit>=12&
        --          (buff.solar_empowerment.stack=3|(variable.az_sb>1&spell_targets.starfall<3&astral_power>=32&!buff.sunblaze.up))&
        --          !(variable.az_hn=3&active_enemies=1)&
        --          !(spell_targets.moonfire>=2&active_enemies<=4&variable.az_potm=3)
        if S.LunarStrike:IsReady() and Player:AstralPowerDeficit() >= 16 and (Player:BuffStackP(S.LunarEmpowermentBuff) == 3 or (Cache.EnemiesCount[40] < 3 and Player:AstralPower() >= 40 and Player:BuffStackP(S.LunarEmpowermentBuff) == 2 and Player:BuffStack(S.SolarEmpowermentBuff) == 2)) then
           if HR.Cast(S.LunarStrike) then return "" end
        end

        if S.SolarWrath:IsReady() and Player:AstralPowerDeficit() >= 12 and (Player:BuffStackP(S.SolarEmpowermentBuff) == 3) then
            if HR.Cast(S.SolarWrath) then return "" end
        end
    end
	
  	local function CoreRotation()
     	 -- TODO(mrdmnd): Implement conditionals on azerite traits. For now, assume all vairable.az_WHATEVER evaluates to zero.
     	 -- actions+=/starsurge,if=(spell_targets.starfall<3&(!buff.starlord.up|buff.starlord.remains>=4)|execute_time*(astral_power%40)>target.time_to_die)&(!buff.celestial_alignment.up&!buff.incarnation.up|variable.az_streak<2|!prev_gcd.1.starsurge)
     	 -- actions+=/starfall,if=spell_targets.starfall>=3&(!buff.starlord.up|buff.starlord.remains>=4)
     	 -- actions+=/new_moon,if=astral_power.deficit>10+execute_time%1.5
     	 -- actions+=/half_moon,if=astral_power.deficit>20+execute_time%1.5
     	 -- actions+=/full_moon,if=astral_power.deficit>40+execute_time%1.5
     	 -- actions+=/lunar_strike,if=((buff.warrior_of_elune.up|buff.lunar_empowerment.up|spell_targets>=3&!buff.solar_empowerment.up)&(!buff.celestial_alignment.up&!buff.incarnation.up|variable.az_streak<2|!prev_gcd.1.lunar_strike)|(variable.az_ds&!buff.dawning_sun.up))&!(spell_targets.moonfire>=2&active_enemies<=4&(variable.az_potm=3|variable.az_potm=2&active_enemies=2))
     	 -- actions+=/solar_wrath,if=(!buff.celestial_alignment.up&!buff.incarnation.up|variable.az_streak<2|!prev_gcd.1.solar_wrath)&!(spell_targets.moonfire>=2&active_enemies<=4&(variable.az_potm=3|variable.az_potm=2&active_enemies=2))
      	-- actions+=/sunfire,if=(!buff.celestial_alignment.up&!buff.incarnation.up|!variable.az_streak|!prev_gcd.1.sunfire)&!(variable.az_potm>=2&spell_targets.moonfire>=2)
      	-- actions+=/moonfire
      	if S.Starsurge:IsReady() and Cache.EnemiesCount[40] < 3 and (not Player:BuffP(S.StarlordBuff) or Player:BuffRemainsP(S.StarlordBuff) >= 4 or (Player:GCD() * (FutureAstralPower() / 40)) > Target:TimeToDie()) and FutureAstralPower() >= 40 then
      	    if HR.Cast(S.Starsurge) then return "" end
      	end
	  	-- starsurge,if=(talent.starlord.enabled&(buff.starlord.stack<3|buff.starlord.remains>=5&buff.arcanic_pulsar.stack<8)|!talent.starlord.enabled&(buff.arcanic_pulsar.stack<8|buff.ca_inc.up))&spell_targets.starfall<variable.sf_targets&buff.lunar_empowerment.stack+buff.solar_empowerment.stack<4&buff.solar_empowerment.stack<3&buff.lunar_empowerment.stack<3&(!variable.az_ss|!buff.ca_inc.up|!prev.starsurge)|target.time_to_die<=execute_time*astral_power%40|!solar_wrath.ap_check
      	if S.Starsurge:IsReadyP() and ((S.Starlord:IsAvailable() and (Player:BuffStackP(S.StarlordBuff) < 3 or Player:BuffRemainsP(S.StarlordBuff) >= 5 and Player:BuffStackP(S.ArcanicPulsarBuff) < 8) or not S.Starlord:IsAvailable() and (Player:BuffStackP(S.ArcanicPulsarBuff) < 8 or Player:BuffP(CaInc()))) and Cache.EnemiesCount[40] < VarSfTargets and Player:BuffStackP(S.LunarEmpowermentBuff) + Player:BuffStackP(S.SolarEmpowermentBuff) < 4 and Player:BuffStackP(S.SolarEmpowermentBuff) < 3 and Player:BuffStackP(S.LunarEmpowermentBuff) < 3 and (not bool(VarAzSs) or not Player:BuffP(CaInc()) or not Player:PrevGCDP(1, S.Starsurge)) or Target:TimeToDie() <= S.Starsurge:ExecuteTime() * FutureAstralPower() / 40 or not AP_Check(S.SolarWrath)) then
      	    if HR.Cast(S.Starsurge) then return "" end
     	 end
     	 if S.Starfall:IsReady() and Cache.EnemiesCount[40] >= 3 and (not Player:BuffP(S.StarlordBuff) or Player:BuffRemainsP(S.StarlordBuff) >= 4) and FutureAstralPower() >= 50 and active_enemies() > 7 then
      	    if HR.Cast(S.Starfall) then return "" end
     	 end
      	if S.NewMoon:IsReady() and (Player:AstralPowerDeficit() > 10 + (Player:GCD() / 1.5)) then
     	     if HR.Cast(S.NewMoon) then return "" end
     	 end
     	 if S.HalfMoon:IsReady() and (Player:AstralPowerDeficit() > 20 + (Player:GCD() / 1.5)) then
     	     if HR.Cast(S.HalfMoon) then return "" end
      	end
     	 if S.FullMoon:IsReady() and (Player:AstralPowerDeficit() > 40 + (Player:GCD() / 1.5)) then
      	    if HR.Cast(S.FullMoon) then return "" end
      	end
     	 -- Lunar strike when warrior of elune or OwlkinFrenzy is up
      	if S.LunarStrike:IsReady() and (Player:BuffP(S.WarriorofEluneBuff) or Player:BuffP(S.OwlkinFrenzyBuff)) then
      	    if HR.Cast(S.LunarStrike) then return "" end
     	 end
     	 -- don't suggest an empowered cast if we're casting the last empowered stack
      	-- bad assumption: detects cleave targets based on 20yds from caster, centered. cannot do clump detection, i am not clever enough yet
     	 if (Cache.EnemiesCount[40] >= 2) then
         	 -- Cleave situation: prioritize lunar strike empower > solar wrath empower > lunar strike
         	 if S.LunarStrike:IsReady() and Player:BuffP(S.LunarEmpowermentBuff) and not (Player:BuffStackP(S.LunarEmpowermentBuff) == 1 and Player:IsCasting(S.LunarStrike)) then
         	     if HR.Cast(S.LunarStrike) then return "" end
         	 end
         	 if S.SolarWrath:IsReady() and Player:BuffP(S.SolarEmpowermentBuff) and not (Player:BuffStackP(S.SolarEmpowermentBuff) == 1 and Player:IsCasting(S.SolarWrath)) then
          	    if HR.Cast(S.SolarWrath) then return "" end
          	end
         	 if S.LunarStrike:IsReady() and (true) then
         	     if HR.Cast(S.LunarStrike) then return "" end
        	  end
     	 else
         	 -- ST situation: prioritize solar wrath empower > lunar strike empower > solar wrath
         	 if S.SolarWrath:IsReady() and Player:BuffP(S.SolarEmpowermentBuff) and not (Player:BuffStackP(S.SolarEmpowermentBuff) == 1 and Player:IsCasting(S.SolarWrath)) then
         	     if HR.Cast(S.SolarWrath) then return "" end
         	 end
         	 if S.LunarStrike:IsReady() and Player:BuffP(S.LunarEmpowermentBuff) and not (Player:BuffStackP(S.LunarEmpowermentBuff) == 1 and Player:IsCasting(S.LunarStrike)) then
          	    if HR.Cast(S.LunarStrike) then return "" end
          	end
         	 if S.SolarWrath:IsReady() and (true) then
       	       if HR.Cast(S.SolarWrath) then return "" end
      	    end
      	end

     	 if S.Moonfire:IsReady() and (true) then
    	      if HR.Cast(S.Moonfire) then return "" end
   	   end
  	end
	
    -- Moonkin Form OOC, if setting is true
    if S.MoonkinForm:IsCastableP() and not ShouldStop and Player:BuffDownP(S.MoonkinForm) and Action.GetToggle(2, "ShowMoonkinFormOOC") then
        if HR.Cast(S.MoonkinForm) then return "moonkin_form ooc"; end
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
		
  	    -- SolarBeam
  	    if useKick and S.SolarBeam:IsReady() and S.SolarBeam:IsAvailable() and Target:IsInterruptible() then 
		  	if ActionUnit(unit):CanInterrupt(true, nil, 25, 70) then
          	    if HR.Cast(S.SolarBeam, true) then return "SolarBeam 5"; end
         	end 
      	end 
	
     	-- MightyBash
      	if useCC and S.MightyBash:IsAvailable() and S.MightyBash:IsReady() and Target:IsInterruptible() then 
	  		if ActionUnit(unit):CanInterrupt(true, nil, 25, 70) then
     	        if HR.Cast(S.MightyBash, true) then return "MightyBash 5"; end
     	    end 
     	end 
		
        -- Defensives
        if S.Renewal:IsCastableP() and not ShouldStop and Player:HealthPercentage() <= Action.GetToggle(2, "RenewalHP") then
            if HR.Cast(S.Renewal, Action.GetToggle(2, "GCDasOffGCD")) then return "renewal defensive"; end
        end
        if S.Barkskin:IsCastableP() and not ShouldStop and Player:HealthPercentage() <= Action.GetToggle(2, "BarkskinHP") then
            if HR.Cast(S.Barkskin, Action.GetToggle(2, "GCDasOffGCD")) then return "barkskin defensive"; end
        end
		
        -- potion,if=buff.celestial_alignment.remains>13|buff.incarnation.remains>16.5
        if I.PotionofUnbridledFury:IsReady() and Action.GetToggle(1, "Potion") and (Player:BuffRemainsP(S.CelestialAlignment) > 13 or Player:BuffRemainsP(S.Incarnation) > 16.5) then
            if HR.Cast(I.PotionofUnbridledFury) then return "battle_potion_of_intellect 57"; end
        end
		
		-- CDs
        if HR.CDsON() then
            local ShouldReturn = CDs(); 
                if ShouldReturn then return ShouldReturn; 
            end  
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
		-- Sunfire when moving
        if S.Sunfire:IsCastableP() and Player:IsMoving()then
            if HR.Cast(S.Sunfire) then return "" end
        end
		
		-- Moonfire when moving
        if S.Moonfire:IsCastableP() and Player:IsMoving() then
            if HR.Cast(S.Moonfire) then return "" end
        end
		
        -- Dots
        local ShouldReturn = Dot(); 
            if ShouldReturn then return ShouldReturn; 
        end  
		
        -- EmpowermentCapCheck
        local ShouldReturn = EmpowermentCapCheck(); 
            if ShouldReturn then return ShouldReturn; 
        end  
		
        -- Main Rotation
        if CoreRotation() ~= nil then
            return CoreRotation()
        end

        -- thorns
        if S.Thorns:IsCastableP() and not ShouldStop then
            if HR.Cast(S.Thorns) then return "thorns"; end
        end
		
        -- use_items,slots=trinket1,if=!trinket.1.has_proc.any|buff.ca_inc.up
        -- use_items,slots=trinket2,if=!trinket.2.has_proc.any|buff.ca_inc.up
        -- use_items
        -- innervate,if=azerite.lively_spirit.enabled&(cooldown.incarnation.remains<2|cooldown.celestial_alignment.remains<12)
        if S.Innervate:IsCastableP() and not ShouldStop and HR.CDsON() and (S.LivelySpirit:AzeriteEnabled() and (S.Incarnation:CooldownRemainsP() < 2 or S.CelestialAlignment:CooldownRemainsP() < 12)) then
            if HR.Cast(S.Innervate) then return "innervate 110"; end
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