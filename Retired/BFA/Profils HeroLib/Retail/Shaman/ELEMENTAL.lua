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

Action[ACTION_CONST_SHAMAN_ELEMENTAL] = {
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
    TotemMastery                          = Action.Create({ Type = "Spell", ID = 210643     }),
    Stormkeeper                           = Action.Create({ Type = "Spell", ID = 191634     }),
    FireElemental                         = Action.Create({ Type = "Spell", ID = 198067     }),
    EarthElemental                        = Action.Create({ Type = "Spell", ID = 198103     }),
    StormElemental                        = Action.Create({ Type = "Spell", ID = 192249     }),
    ElementalBlast                        = Action.Create({ Type = "Spell", ID = 117014     }),
    LavaBurst                             = Action.Create({ Type = "Spell", ID = 51505      }),
    ChainLightning                        = Action.Create({ Type = "Spell", ID = 188443     }),
    FlameShock                            = Action.Create({ Type = "Spell", ID = 188389     }),
    Ascendance                            = Action.Create({ Type = "Spell", ID = 114050     }),
    Icefury                               = Action.Create({ Type = "Spell", ID = 210714     }),
    LiquidMagmaTotem                      = Action.Create({ Type = "Spell", ID = 192222     }),
    Earthquake                            = Action.Create({ Type = "Spell", ID = 61882      }),
    MasteroftheElements                   = Action.Create({ Type = "Spell", ID = 16166      }),
    FrostShock                            = Action.Create({ Type = "Spell", ID = 196840     }),
    LavaBeam                              = Action.Create({ Type = "Spell", ID = 114074     }),
    IgneousPotential                      = Action.Create({ Type = "Spell", ID = 279829     }),
    NaturalHarmony                        = Action.Create({ Type = "Spell", ID = 278697     }),
    SurgeofPower                          = Action.Create({ Type = "Spell", ID = 262303     }),
    LightningBolt                         = Action.Create({ Type = "Spell", ID = 188196     }),
    LavaShock                             = Action.Create({ Type = "Spell", ID = 273448     }),
    TectonicThunder                       = Action.Create({ Type = "Spell", ID = 286949     }),
    CalltheThunder                        = Action.Create({ Type = "Spell", ID = 260897     }),
    EarthShock                            = Action.Create({ Type = "Spell", ID = 8042       }),
    EchooftheElementals                   = Action.Create({ Type = "Spell", ID = 275381     }),
    EchooftheElements                     = Action.Create({ Type = "Spell", ID = 108283     }),
    WindShear                             = Action.Create({ Type = "Spell", ID = 57994      }),
    ConcentratedFlameBurn                 = Action.Create({ Type = "Spell", ID = 295368     }),
	-- Utilities
    LightningLasso                        = Action.Create({ Type = "Spell", ID = 305483     }),
    CapacitorTotem                        = Action.Create({ Type = "Spell", ID = 192058     }),
    Purge                                 = Action.Create({ Type = "Spell", ID = 370     }),
    GhostWolf                             = Action.Create({ Type = "Spell", ID = 2645     }),
    EarthShield                           = Action.Create({ Type = "Spell", ID = 974     }),
    HealingSurge                          = Action.Create({ Type = "Spell", ID = 8004     }),
	PrimalElementalist                    = Action.Create({ Type = "Spell", ID = 117013 , Hidden = true     }),
    -- Storm Elemental   
    EyeOfTheStorm                         = Action.Create({ Type = "Spell", ID = 157375 , Hidden = true     }), 
    CallLightning                         = Action.Create({ Type = "Spell", ID = 157348 , Hidden = true     }),
    -- Defensive
	AstralShift                           = Action.Create({ Type = "Spell", ID = 108271     }),	
    -- Buffs
    RecklessForceBuff                     = Action.Create({ Type = "Spell", ID = 302932  , Hidden = true     }),	
    ResonanceTotemBuff                    = Action.Create({ Type = "Spell", ID = 202192  , Hidden = true     }),	
    TectonicThunderBuff                   = Action.Create({ Type = "Spell", ID = 286949  , Hidden = true     }),	
    LavaShockBuff                         = Action.Create({ Type = "Spell", ID = 273453 , Hidden = true     }),	
    SurgeofPowerBuff                      = Action.Create({ Type = "Spell", ID = 285514 , Hidden = true     }),	
    MasteroftheElementsBuff               = Action.Create({ Type = "Spell", ID = 260734 , Hidden = true     }),	
    LavaSurgeBuff                         = Action.Create({ Type = "Spell", ID = 77762  , Hidden = true     }),	
    AscendanceBuff                        = Action.Create({ Type = "Spell", ID = 114050, Hidden = true     }),	
    IcefuryBuff                           = Action.Create({ Type = "Spell", ID = 210714, Hidden = true     }),	
    StormkeeperBuff                       = Action.Create({ Type = "Spell", ID = 191634, Hidden = true     }),	
    WindGustBuff                          = Action.Create({ Type = "Spell", ID = 263806, Hidden = true     }),
    GhostWolfBuff                         = Action.Create({ Type = "Spell", ID = 2645, Hidden = true     }),	
	-- Debuffs 
    ShiverVenomDebuff                     = Action.Create({ Type = "Spell", ID = 301624, Hidden = true     }),
    FlameShockDebuff                      = Action.Create({ Type = "Spell", ID = 188389, Hidden = true     }),		
    -- Misc
    Channeling                            = Action.Create({ Type = "Spell", ID = 209274, Hidden = true     }),	-- Show an icon during channeling
	TargetEnemy                           = Action.Create({ Type = "Spell", ID = 44603, Hidden = true     }),	-- Change Target (Tab button)
	-- Trinkets    
    TrinketTest                           = Action.Create({ Type = "Trinket", ID = 122530, QueueForbidden = true }),
    TrinketTest2                          = Action.Create({ Type = "Trinket", ID = 159611, QueueForbidden = true }), 
    VialofStorms                          = Action.Create({ Type = "Trinket", ID = 158224, QueueForbidden = true }),
	AshvanesRazorCoral                    = Action.Create({ Type = "Trinket", ID = 169311, QueueForbidden = true }),
    -- Trinkets    
    TidestormCodex                       = Action.Create({ Type = "Trinket", ID = 165576}),
    MalformedHeraldsLegwraps             = Action.Create({ Type = "Trinket", ID = 167835}),
    PocketsizedComputationDevice         = Action.Create({ Type = "Trinket", ID = 167555}),
    AzsharasFontofPower                  = Action.Create({ Type = "Trinket", ID = 169314}),
    RotcrustedVoodooDoll                 = Action.Create({ Type = "Trinket", ID = 159624}),
    AquipotentNautilus                   = Action.Create({ Type = "Trinket", ID = 169305}),
    ShiverVenomRelic                     = Action.Create({ Type = "Trinket", ID = 168905}),
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
Action:CreateEssencesFor(ACTION_CONST_SHAMAN_ELEMENTAL)        -- where PLAYERSPEC is Constance (example: ACTION_CONST_MONK_BM)

-- This code making shorter access to both tables Action[PLAYERSPEC] and Action
-- However if you prefer long access it still can be used like Action[PLAYERSPEC].Guard:IsReady() and not ShouldStop, it doesn't make any conflict if you will skip shorter access
-- So with shorter access you can just do Action.Guard:IsReady() and not ShouldStop instead of Action[PLAYERSPEC].Guard:IsReady() and not ShouldStop
local A = setmetatable(Action[ACTION_CONST_SHAMAN_ELEMENTAL], { __index = Action })

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
local EnemiesCount;
-- GUI Settings
local Everyone = HR.Commons.Everyone;

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

local EnemyRanges = {40, 30, 5}
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
	        Everyone.AoEToggleEnemiesUpdate()
            return Cache.EnemiesCount[40]
        end
    else
        return 1
    end
end

-- Pet functions
local PetType = {
  [77942] = {"Primal Storm Elemental", 30},
};

HL.ElementalGuardiansTable = {
    --{PetType,petID,dateEvent,UnitPetGUID,CastsLeft}
    Pets = {
    },
    PetList={
    [77942]="Primal Storm Elemental",
}
};
    
HL:RegisterForSelfCombatEvent(
function (...)
    local dateEvent,_,_,_,_,_,_,UnitPetGUID=select(1,...)
    local t={} ; i=1
  
    for str in string.gmatch(UnitPetGUID, "([^-]+)") do
        t[i] = str
        i = i + 1
    end
    
	local PetType=HL.ElementalGuardiansTable.PetList[tonumber(t[6])]
    if PetType then
        table.insert(HL.ElementalGuardiansTable.Pets,{PetType,tonumber(t[6]),GetTime(),UnitPetGUID,5})
    end
end
    , "SPELL_SUMMON"
);
        
-- Summoned pet duration
local function PetDuration(PetType)
    if not PetType then 
        return 0 
    end
    local PetsInfo = {
        [77942] = {"Primal Storm Elemental", 30},
    }
    local maxduration = 0
    for key, Value in pairs(HL.ElementalGuardiansTable.Pets) do
        if HL.ElementalGuardiansTable.Pets[key][1] == PetType then
            if (PetsInfo[HL.ElementalGuardiansTable.Pets[key][2]][2] - (GetTime() - HL.ElementalGuardiansTable.Pets[key][3])) > maxduration then
                maxduration = HL.OffsetRemains((PetsInfo[HL.ElementalGuardiansTable.Pets[key][2]][2] - (GetTime() - HL.ElementalGuardiansTable.Pets[key][3])), "Auto" );
            end
        end
    end
    return maxduration
end

local function StormElementalIsActive()
    if PetDuration("Primal Storm Elemental") > 1 then
        return true
   else
        return false
    end
end

local function ResonanceTotemTime()
  for index=1,4 do
    local _, totemName, startTime, duration = GetTotemInfo(index)
    if totemName == S.TotemMastery:Name() then
      return (floor(startTime + duration - GetTime() + 0.5)) or 0
    end
  end
  return 0
end

local function FutureMaelstromPower()
  local MaelstromPower = Player:Maelstrom()
  local overloadChance = Player:MasteryPct() / 100
  local factor = 1 + 0.75 * overloadChance
  local resonance = 0

  if Player:AffectingCombat() then
    if S.TotemMastery:IsCastableP() then
      resonance = Player:CastRemains()
    end
    if not Player:IsCasting() then
      return MaelstromPower
    else
      if Player:IsCasting(S.LightningBolt) then
        return MaelstromPower + 8 + resonance
      elseif Player:IsCasting(S.LavaBurst) then
        return MaelstromPower + 10 + resonance
      elseif Player:IsCasting(S.ChainLightning) then
        local enemiesHit = min(Cache.EnemiesCount[40], 3)
        return MaelstromPower + 4 * enemiesHit * factor + resonance
      elseif Player:IsCasting(S.Icefury) then
        return MaelstromPower + 25 * factor + resonance
      else
        return MaelstromPower
      end
    end
  end
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

local function EvaluateCycleFlameShock47(Target)
  return Target:DebuffRefreshableCP(S.FlameShockDebuff) and (EnemiesCount < (5 - num(not S.TotemMastery:IsAvailable())) or not S.StormElemental:IsAvailable() and (S.FireElemental:CooldownRemainsP() > (120 + 14 * Player:SpellHaste()) or S.FireElemental:CooldownRemainsP() < (24 - 14 * Player:SpellHaste()))) and (not S.StormElemental:IsAvailable() or S.StormElemental:CooldownRemainsP() < 120 or EnemiesCount == 3 and Player:BuffStackP(S.WindGustBuff) < 14)
end

local function EvaluateCycleFlameShock148(Target)
  return Target:DebuffRefreshableCP(S.FlameShockDebuff)
end

local function EvaluateCycleFlameShock163(Target)
  return (not Target:DebuffP(S.FlameShockDebuff) or S.StormElemental:IsAvailable() and S.StormElemental:CooldownRemainsP() < 2 * Player:GCD() or Target:DebuffRemainsP(S.FlameShockDebuff) <= Player:GCD() or S.Ascendance:IsAvailable() and Target:DebuffRemainsP(S.FlameShockDebuff) < (S.Ascendance:CooldownRemainsP() + S.AscendanceBuff:BaseDuration()) and S.Ascendance:CooldownRemainsP() < 4 and (not S.StormElemental:IsAvailable() or S.StormElemental:IsAvailable() and S.StormElemental:CooldownRemainsP() < 120)) and (Player:BuffStackP(S.WindGustBuff) < 14 or S.IgneousPotential:AzeriteRank() >= 2 or Player:BuffP(S.LavaSurgeBuff) or not Player:HasHeroism()) and not Player:BuffP(S.SurgeofPowerBuff)
end

local function EvaluateCycleFlameShock390(Target)
  return Target:DebuffRefreshableCP(S.FlameShockDebuff) and EnemiesCount > 1 and Player:BuffP(S.SurgeofPowerBuff)
end

local function EvaluateCycleFlameShock511(Target)
  return Target:DebuffRefreshableCP(S.FlameShockDebuff) and not Player:BuffP(S.SurgeofPowerBuff)
end

local function EvaluateCycleFlameShock562(Target)
  return Target:DebuffRefreshableCP(S.FlameShockDebuff)
end

local function EvaluateCycleFlameShock702(Target)
  return ((not Target:DebuffP(S.FlameShockDebuff) or S.StormElemental:IsAvailable() and S.StormElemental:CooldownRemainsP() < 2 * Player:GCD() or Target:DebuffRemainsP(S.FlameShockDebuff) <= Player:GCD() or S.Ascendance:IsAvailable() and Target:DebuffRemainsP(S.FlameShockDebuff) < (S.Ascendance:CooldownRemainsP() + S.AscendanceBuff:BaseDuration()) and S.Ascendance:CooldownRemainsP() < 4 and (not S.StormElemental:IsAvailable() or S.StormElemental:IsAvailable() and S.StormElemental:CooldownRemainsP() < 120)) and (Player:BuffStackP(S.WindGustBuff) < 14 or S.IgneousPotential:AzeriteRank() >= 2 or Player:BuffP(S.LavaSurgeBuff) or not Player:HasHeroism()) and Player:BuffDownP(S.SurgeofPowerBuff))
end

-- Initiate Nucleus Ability registration
local function Init ()
    HL.RegisterNucleusAbility(188443, 10, 6)               -- Chain Lightning
    HL.RegisterNucleusAbility(61882, 8, 6)                 -- Earthquake
    HL.RegisterNucleusAbility(192222, 8, 6)                -- Liquid Magma Totem
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
    HL.GetEnemies(40) -- For CastCycle calls
    HL.GetEnemies(30) -- For WindShear
	DetermineEssenceRanks()
	FutureMaelstromPower()
    AppliedFlameShock = MultiUnits:GetByRangeAppliedDoTs(40, 5, 188389) --MultiDots(40, S.FlameShockDebuff, 15, 4) --MultiUnits:GetByRangeMissedDoTs(40, 10, 188389)  MultiUnits:GetByRangeMissedDoTs(range, stop, dots, ttd)
    FlameShockToRefresh = MultiUnits:GetByRangeDoTsToRefresh(40, 5, 188389, 5)
    MissingFlameShock = MultiUnits:GetByRangeMissedDoTs(40, 5, 188389) --MultiDots(40, S.FlameShockDebuff, 15, 4) --MultiUnits:GetByRangeMissedDoTs(40, 10, 188389)  MultiUnits:GetByRangeMissedDoTs(range, stop, dots, ttd)

	local CanMultidot = HandleMultidots()
	
    local function Precombat_DBM()
        -- flask
        -- food
        -- augmentation
        -- snapshot_stats
        if Everyone.TargetIsValid() then
            -- totem_mastery
            if S.TotemMastery:IsReadyP() and not ShouldStop and ResonanceTotemTime() < 6 then
                if HR.Cast(S.TotemMastery) then return "totem_mastery 4"; end
            end
            -- earth_elemental,if=!talent.primal_elementalist.enabled
            -- stormkeeper,if=talent.stormkeeper.enabled&(raid_event.adds.count<3|raid_event.adds.in>50)
            if S.Stormkeeper:IsCastableP() and not Player:IsMoving() and not ShouldStop and Player:BuffDownP(S.StormkeeperBuff) and S.Stormkeeper:IsAvailable() and Pull > 0.1 and Pull <= (S.LavaBurst:CastTime() + S.LavaBurst:TravelTime() + 2) then
                if HR.Cast(S.Stormkeeper) then return "stormkeeper 7"; end
            end
            -- potion
            if I.PotionofUnbridledFury:IsReady() and not ShouldStop and Action.GetToggle(1, "Potion") and Pull > 0.1 and Pull <= (S.LavaBurst:CastTime() + S.LavaBurst:TravelTime() + 1) then
                if HR.Cast(I.PotionofUnbridledFury) then return "battle_potion_of_intellect 27"; end
            end
            -- lava_burst,if=!talent.elemental_blast.enabled&spell_targets.chain_lightning<3
            if S.LavaBurst:IsCastableP() and not ShouldStop and not Player:IsCasting(S.LavaBurst) and Pull > 0.1 and Pull <= (S.LavaBurst:CastTime() + S.LavaBurst:TravelTime()) then
                if HR.Cast(S.LavaBurst) then return "lava_burst 33"; end
            end
            -- Add Flame Shock as part of the "opener" 
            if S.FlameShock:IsCastableP() and not ShouldStop and ((not Target:DebuffP(S.FlameShockDebuff)) and (Player:IsCasting(S.LavaBurst) or Player:PrevGCDP(1, S.LavaBurst))) and Pull > 0.01 and Pull <= 0.1 then
                if HR.Cast(S.FlameShock) then return "flame_shock opener"; end
            end
        end
    end
    
    local function Precombat()
        -- flask
        -- food
        -- augmentation
        -- snapshot_stats
        if Everyone.TargetIsValid() then
            -- totem_mastery
            if S.TotemMastery:IsReadyP() and not ShouldStop and ResonanceTotemTime() < 6 then
                if HR.Cast(S.TotemMastery) then return "totem_mastery 4"; end
            end
			-- stormkeeper,if=talent.stormkeeper.enabled&(raid_event.adds.count<3|raid_event.adds.in>50)
            if S.Stormkeeper:IsCastableP() and not Player:IsMoving() and not ShouldStop and Player:BuffDownP(S.StormkeeperBuff) and (S.Stormkeeper:IsAvailable() and ((EnemiesCount - 1) < 3)) then
                if HR.Cast(S.Stormkeeper) then return "stormkeeper 7"; end
            end
            -- fire_elemental,if=!talent.storm_elemental.enabled
            if S.FireElemental:IsCastableP() and not ShouldStop and HR.CDsON() and (not S.StormElemental:IsAvailable()) then
                if HR.Cast(S.FireElemental, Action.GetToggle(2, "OffGCDasOffGCD")) then return "fire_elemental 19"; end
            end
            -- storm_elemental,if=talent.storm_elemental.enabled
            if S.StormElemental:IsCastableP() and not ShouldStop and HR.CDsON() and (S.StormElemental:IsAvailable()) then
                if HR.Cast(S.StormElemental, Action.GetToggle(2, "OffGCDasOffGCD")) then return "storm_elemental 23"; end
            end
            -- potion
            if I.PotionofUnbridledFury:IsReady() and not ShouldStop and Action.GetToggle(1, "Potion") then
                if HR.Cast(I.PotionofUnbridledFury) then return "battle_potion_of_intellect 27"; end
            end
            -- elemental_blast,if=talent.elemental_blast.enabled
            if S.ElementalBlast:IsCastableP() and not ShouldStop and (S.ElementalBlast:IsAvailable()) then
                if HR.Cast(S.ElementalBlast) then return "elemental_blast 29"; end
            end
            -- chain_lightning,if=spell_targets.chain_lightning>2
            if S.ChainLightning:IsCastableP() and not ShouldStop and HR.AoEON() and Cache.EnemiesCount[40] > 2 then
                if HR.Cast(S.ChainLightning) then return "chain_lightning 37"; end
            end
            -- lava_burst,if=!talent.elemental_blast.enabled&spell_targets.chain_lightning<3
            if S.LavaBurst:IsCastableP() and not Player:IsMoving() and not ShouldStop and not S.ElementalBlast:IsAvailable() and EnemiesCount < 3 and not Player:IsCasting(S.LavaBurst) then
                if HR.Cast(S.LavaBurst) then return "lava_burst 33"; end
            end
            -- Add Flame Shock as part of the "opener" 
            if S.FlameShock:IsCastableP() and not ShouldStop and ((not Target:DebuffP(S.FlameShockDebuff)) and (Player:IsCasting(S.LavaBurst) or Player:PrevGCDP(1, S.LavaBurst))) then
                if HR.Cast(S.FlameShock) then return "flame_shock opener"; end
            end
        end
    end
    local function Aoe()
        -- stormkeeper,if=talent.stormkeeper.enabled
        if S.Stormkeeper:IsCastableP() and not Player:IsMoving() and not ShouldStop and (S.Stormkeeper:IsAvailable()) then
            if HR.Cast(S.Stormkeeper) then return "stormkeeper 39"; end
        end
        -- flame_shock,target_if=refreshable&(spell_targets.chain_lightning<(5-!talent.totem_mastery.enabled)|!talent.storm_elemental.enabled&(cooldown.fire_elemental.remains>(120+14*spell_haste)|cooldown.fire_elemental.remains<(24-14*spell_haste)))&(!talent.storm_elemental.enabled|cooldown.storm_elemental.remains<120|spell_targets.chain_lightning=3&buff.wind_gust.stack<14)
        if S.FlameShock:IsCastableP() and not ShouldStop and EvaluateCycleFlameShock47(Target) then
            if HR.Cast(S.FlameShock) then return "flame_shock 69" end
        end 	  		
        -- ascendance,if=talent.ascendance.enabled&(talent.storm_elemental.enabled&cooldown.storm_elemental.remains<120&cooldown.storm_elemental.remains>15|!talent.storm_elemental.enabled)&(!talent.icefury.enabled|!buff.icefury.up&!cooldown.icefury.up)
        if S.Ascendance:IsCastableP() and not ShouldStop and HR.CDsON() and S.Ascendance:IsAvailable() and (S.StormElemental:IsAvailable() and S.StormElemental:CooldownRemainsP() < 120 and S.StormElemental:CooldownRemainsP() > 15 or not S.StormElemental:IsAvailable()) and (not S.Icefury:IsAvailable() or not Player:BuffP(S.IcefuryBuff) and not S.Icefury:CooldownUpP()) then
            if HR.Cast(S.Ascendance, Action.GetToggle(2, "OffGCDasOffGCD")) then return "ascendance 70"; end
        end
        -- liquid_magma_totem,if=talent.liquid_magma_totem.enabled
        if S.LiquidMagmaTotem:IsCastableP() and not ShouldStop and (S.LiquidMagmaTotem:IsAvailable()) then
            if HR.Cast(S.LiquidMagmaTotem) then return "liquid_magma_totem 88"; end
        end
        -- earthquake,if=!talent.master_of_the_elements.enabled|buff.stormkeeper.up|maelstrom>=(100-4*spell_targets.chain_lightning)|buff.master_of_the_elements.up|spell_targets.chain_lightning>3
        if S.Earthquake:IsReadyP() and not ShouldStop and (not S.MasteroftheElements:IsAvailable() or Player:BuffP(S.StormkeeperBuff) or Player:Maelstrom() >= (100 - 4 * EnemiesCount) or Player:BuffP(S.MasteroftheElementsBuff) or EnemiesCount > 3) then
            if HR.Cast(S.Earthquake) then return "earthquake 92"; end
        end
        -- chain_lightning,if=buff.stormkeeper.remains<3*gcd*buff.stormkeeper.stack
        if S.ChainLightning:IsCastableP() and HR.AoEON() and not ShouldStop and (Player:BuffRemainsP(S.StormkeeperBuff) < 3 * Player:GCD() * Player:BuffStackP(S.StormkeeperBuff)) then
            if HR.Cast(S.ChainLightning) then return "chain_lightning 100"; end
        end
        -- lava_burst,if=buff.lava_surge.up&spell_targets.chain_lightning<4&(!talent.storm_elemental.enabled|cooldown.storm_elemental.remains<120)&dot.flame_shock.ticking
        if S.LavaBurst:IsCastableP() and not StormElementalIsActive() and not ShouldStop and (Player:BuffP(S.LavaSurgeBuff) and EnemiesCount < 4 and (not S.StormElemental:IsAvailable() or S.StormElemental:CooldownRemainsP() < 120) and Target:DebuffP(S.FlameShockDebuff)) then
            if HR.Cast(S.LavaBurst) then return "lava_burst 106"; end
        end
		-- Disabled in AoE for better performances
        -- icefury,if=spell_targets.chain_lightning<4&!buff.ascendance.up
        --if S.Icefury:IsCastableP() and not Player:IsMoving() and not ShouldStop and EnemiesCount < 4 and not Player:BuffP(S.AscendanceBuff) and not StormElementalIsActive() then
        --    if HR.Cast(S.Icefury) then return "icefury 116"; end
        --end
		-- 14 Lavaburst while moving
        if S.LavaBurst:IsCastableP() and not StormElementalIsActive() and Player:IsMoving() and Target:DebuffRemainsP(S.FlameShockDebuff) >= S.LavaBurst:CastTime() and Player:BuffP(S.LavaSurgeBuff) and FutureMaelstromPower() <= 90 then
            if HR.Cast(S.LavaBurst) then return "lava_burst 734"; end
        end	
        -- frost_shock,if=spell_targets.chain_lightning<4&buff.icefury.up&!buff.ascendance.up
        if S.FrostShock:IsCastableP() and not ShouldStop and (EnemiesCount < 4 and Player:BuffP(S.IcefuryBuff) and not Player:BuffP(S.AscendanceBuff)) then
            if HR.Cast(S.FrostShock) then return "frost_shock 120"; end
        end
        -- elemental_blast,if=talent.elemental_blast.enabled&spell_targets.chain_lightning<4&(!talent.storm_elemental.enabled|cooldown.storm_elemental.remains<120)
        if S.ElementalBlast:IsCastableP() and not ShouldStop and (S.ElementalBlast:IsAvailable() and EnemiesCount < 4 and (not S.StormElemental:IsAvailable() or S.StormElemental:CooldownRemainsP() < 120)) then
            if HR.Cast(S.ElementalBlast) then return "elemental_blast 126"; end
        end
        -- lava_beam,if=talent.ascendance.enabled
        if S.LavaBeam:IsCastableP() and not ShouldStop and (S.Ascendance:IsAvailable()) then
            if HR.Cast(S.LavaBeam) then return "lava_beam 134"; end
        end
        -- chain_lightning
        if S.ChainLightning:IsCastableP() and HR.AoEON() and not Player:IsMoving() and not ShouldStop then
            if HR.Cast(S.ChainLightning) then return "chain_lightning 138"; end
        end
        -- flame_shock,moving=1,target_if=refreshable
        if S.FlameShock:IsCastableP() and not ShouldStop and EvaluateCycleFlameShock148(Target) and Player:IsMoving() then
            if HR.Cast(S.FlameShock) then return "flame_shock 156" end
        end
        -- frost_shock,moving=1
        if S.FrostShock:IsCastableP() and not ShouldStop and Player:IsMoving() then
            if HR.Cast(S.FrostShock) then return "frost_shock 157"; end
        end
    end
    local function Funnel()
        -- flame_shock,target_if=(!ticking|talent.storm_elemental.enabled&cooldown.storm_elemental.remains<2*gcd|dot.flame_shock.remains<=gcd|talent.ascendance.enabled&dot.flame_shock.remains<(cooldown.ascendance.remains+buff.ascendance.duration)&cooldown.ascendance.remains<4&(!talent.storm_elemental.enabled|talent.storm_elemental.enabled&cooldown.storm_elemental.remains<120))&(buff.wind_gust.stack<14|azerite.igneous_potential.rank>=2|buff.lava_surge.up|!buff.bloodlust.up)&!buff.surge_of_power.up
        if S.FlameShock:IsCastableP() and not ShouldStop and EvaluateCycleFlameShock702(Target) then
            if HR.Cast(S.FlameShock) then return "flame_shock 704"; end
        end
        -- ascendance,if=talent.ascendance.enabled&(time>=60|buff.bloodlust.up)&cooldown.lava_burst.remains>0&(cooldown.storm_elemental.remains<120|!talent.storm_elemental.enabled)&(!talent.icefury.enabled|!buff.icefury.up&!cooldown.icefury.up)
        if S.Ascendance:IsCastableP() and not ShouldStop and (S.Ascendance:IsAvailable() and (HL.CombatTime() >= 60 or Player:HasHeroism()) and bool(S.LavaBurst:CooldownRemainsP()) and (S.StormElemental:CooldownRemainsP() < 120 or not S.StormElemental:IsAvailable()) and (not S.Icefury:IsAvailable() or Player:BuffDownP(S.IcefuryBuff) and not S.Icefury:CooldownUpP())) then
            if HR.Cast(S.Ascendance, Action.GetToggle(2, "OffGCDasOffGCD")) then return "ascendance 706"; end
        end
        -- elemental_blast,if=talent.elemental_blast.enabled&(talent.master_of_the_elements.enabled&buff.master_of_the_elements.up&maelstrom<60|!talent.master_of_the_elements.enabled)&(!(cooldown.storm_elemental.remains>120&talent.storm_elemental.enabled)|azerite.natural_harmony.rank=3&buff.wind_gust.stack<14)
        if S.ElementalBlast:IsCastableP() and not ShouldStop and (S.ElementalBlast:IsAvailable() and (S.MasteroftheElements:IsAvailable() and Player:BuffP(S.MasteroftheElementsBuff) and Player:Maelstrom() < 60 or not S.MasteroftheElements:IsAvailable()) and (not (S.StormElemental:CooldownRemainsP() > 120 and S.StormElemental:IsAvailable()) or S.NaturalHarmony:AzeriteRank() == 3 and Player:BuffStackP(S.WindGustBuff) < 14)) then
            if HR.Cast(S.ElementalBlast) then return "elemental_blast 708"; end
        end
        -- stormkeeper,if=talent.stormkeeper.enabled&(raid_event.adds.count<3|raid_event.adds.in>50)&(!talent.surge_of_power.enabled|buff.surge_of_power.up|maelstrom>=44)
        if S.Stormkeeper:IsCastableP() and not Player:IsMoving() and not ShouldStop and (S.Stormkeeper:IsAvailable() and EnemiesCount < 3 and (not S.SurgeofPower:IsAvailable() or Player:BuffP(S.SurgeofPowerBuff) or Player:Maelstrom() >= 44)) then
            if HR.Cast(S.Stormkeeper) then return "stormkeeper 710"; end
        end
        -- liquid_magma_totem,if=talent.liquid_magma_totem.enabled&(raid_event.adds.count<3|raid_event.adds.in>50)
        if S.LiquidMagmaTotem:IsCastableP() and not ShouldStop and S.LiquidMagmaTotem:IsAvailable() then
            if HR.Cast(S.LiquidMagmaTotem) then return "liquid_magma_totem 712"; end
        end
        -- lightning_bolt,if=buff.stormkeeper.up&spell_targets.chain_lightning<6&(azerite.lava_shock.rank*buff.lava_shock.stack)<36&(buff.master_of_the_elements.up&!talent.surge_of_power.enabled|buff.surge_of_power.up)
        if S.LightningBolt:IsCastableP() and not ShouldStop and (Player:BuffP(S.StormkeeperBuff) and EnemiesCount < 6 and (S.LavaShock:AzeriteRank() * Player:BuffStackP(S.LavaShockBuff)) < 36 and (Player:BuffP(S.MasteroftheElementsBuff) and not S.SurgeofPower:IsAvailable() or Player:BuffP(S.SurgeofPowerBuff))) then
            if HR.Cast(S.LightningBolt) then return "lightning_bolt 714"; end
        end
        -- earth_shock,if=!buff.surge_of_power.up&talent.master_of_the_elements.enabled&(buff.master_of_the_elements.up|cooldown.lava_burst.remains>0&maelstrom>=92+30*talent.call_the_thunder.enabled|(azerite.lava_shock.rank*buff.lava_shock.stack<36)&buff.stormkeeper.up&cooldown.lava_burst.remains<=gcd)
        if S.EarthShock:IsReadyP() and not ShouldStop and (Player:BuffDownP(S.SurgeofPowerBuff) and S.MasteroftheElements:IsAvailable() and (Player:BuffP(S.MasteroftheElementsBuff) or not S.LavaBurst:CooldownUpP() and Player:Maelstrom() >= 60 or (S.LavaShock:AzeriteRank() * Player:BuffStackP(S.LavaShockBuff) < 36) and Player:BuffP(S.StormkeeperBuff) and S.LavaBurst:CooldownRemainsP() <= Player:GCD())) then
            if HR.Cast(S.EarthShock) then return "earth_shock 716"; end
        end
        -- earth_shock,if=!talent.master_of_the_elements.enabled&!(azerite.igneous_potential.rank>2&buff.ascendance.up)&(buff.stormkeeper.up|maelstrom>=90+30*talent.call_the_thunder.enabled|!(cooldown.storm_elemental.remains>120&talent.storm_elemental.enabled)&expected_combat_length-time-cooldown.storm_elemental.remains-150*floor((expected_combat_length-time-cooldown.storm_elemental.remains)%150)>=30*(1+(azerite.echo_of_the_elementals.rank>=2)))
        if S.EarthShock:IsReadyP() and not ShouldStop and (not S.MasteroftheElements:IsAvailable() and not (S.IgneousPotential:AzeriteRank() > 2 and Player:BuffP(S.AscendanceBuff)) and (Player:BuffP(S.StormkeeperBuff) or Player:Maelstrom() >= 60 or not (S.StormElemental:CooldownRemainsP() > 120 and S.StormElemental:IsAvailable()) and Target:TimeToDie() - S.StormElemental:CooldownRemainsP() - 150 * floor((Target:TimeToDie() - S.StormElemental:CooldownRemainsP()) % 150) >= 30 * (1 + num(S.EchooftheElementals:AzeriteRank() >= 2)))) then
            if HR.Cast(S.EarthShock) then return "earth_shock 718"; end
        end
        -- earth_shock,if=talent.surge_of_power.enabled&!buff.surge_of_power.up&cooldown.lava_burst.remains<=gcd&(!talent.storm_elemental.enabled&!(cooldown.fire_elemental.remains>120)|talent.storm_elemental.enabled&!(cooldown.storm_elemental.remains>120))
        if S.EarthShock:IsReadyP() and not ShouldStop and (S.SurgeofPower:IsAvailable() and Player:BuffDownP(S.SurgeofPowerBuff) and S.LavaBurst:CooldownRemainsP() <= Player:GCD() and (not S.StormElemental:IsAvailable() and not (S.FireElemental:CooldownRemainsP() > 120) or S.StormElemental:IsAvailable() and not (S.StormElemental:CooldownRemainsP() > 120))) then
            if HR.Cast(S.EarthShock) then return "earth_shock 720"; end
        end
        -- lightning_bolt,if=cooldown.storm_elemental.remains>120&talent.storm_elemental.enabled&(azerite.igneous_potential.rank<2|!buff.lava_surge.up&buff.bloodlust.up)
        if S.LightningBolt:IsCastableP() and not Player:IsMoving() and not ShouldStop and (S.StormElemental:CooldownRemainsP() > 120 and S.StormElemental:IsAvailable() and (S.IgneousPotential:AzeriteRank() < 2 or Player:BuffDownP(S.LavaSurgeBuff) and Player:HasHeroism())) then
            if HR.Cast(S.LightningBolt) then return "lightning_bolt 722"; end
        end
        -- lightning_bolt,if=(buff.stormkeeper.remains<1.1*gcd*buff.stormkeeper.stack|buff.stormkeeper.up&buff.master_of_the_elements.up)
        if S.LightningBolt:IsCastableP() and not ShouldStop and (Player:BuffRemainsP(S.StormkeeperBuff) < 1.1 * Player:GCD() * Player:BuffStackP(S.StormkeeperBuff) or Player:BuffP(S.StormkeeperBuff) and Player:BuffP(S.MasteroftheElementsBuff)) then
            if HR.Cast(S.LightningBolt) then return "lightning_bolt 724"; end
        end
        -- frost_shock,if=talent.icefury.enabled&talent.master_of_the_elements.enabled&buff.icefury.up&buff.master_of_the_elements.up
        if S.FrostShock:IsCastableP() and not ShouldStop and (S.Icefury:IsAvailable() and S.MasteroftheElements:IsAvailable() and Player:BuffP(S.IcefuryBuff) and Player:BuffP(S.MasteroftheElementsBuff)) then
            if HR.Cast(S.FrostShock) then return "frost_shock 726"; end
        end
        -- lava_burst,if=buff.ascendance.up
        if S.LavaBurst:IsReadyP() and not Player:IsMoving() and not ShouldStop and (Player:BuffP(S.AscendanceBuff)) then
            if HR.Cast(S.LavaBurst) then return "lava_burst 728"; end
        end
        -- flame_shock,target_if=refreshable&active_enemies>1&buff.surge_of_power.up
        if S.FlameShock:IsCastableP() and not ShouldStop and (Target:DebuffRefreshableCP(S.FlameShock) and EnemiesCount > 1 and Player:BuffP(S.SurgeofPowerBuff)) then
            if HR.Cast(S.FlameShock) then return "flame_shock 730"; end
        end
        -- lava_burst,if=!talent.storm_elemental.enabled&cooldown_react&buff.surge_of_power.up&(expected_combat_length-time-cooldown.fire_elemental.remains-150*floor((expected_combat_length-time-cooldown.fire_elemental.remains)%150)<30*(1+(azerite.echo_of_the_elementals.rank>=2))|(1.16*(expected_combat_length-time)-cooldown.fire_elemental.remains-150*floor((1.16*(expected_combat_length-time)-cooldown.fire_elemental.remains)%150))<(expected_combat_length-time-cooldown.fire_elemental.remains-150*floor((expected_combat_length-time-cooldown.fire_elemental.remains)%150)))
        if S.LavaBurst:IsCastableP() and not Player:IsMoving() and not ShouldStop and Player:BuffP(S.SurgeofPowerBuff) then
            if HR.Cast(S.LavaBurst) then return "lava_burst 734"; end
        end
        -- lightning_bolt,if=buff.surge_of_power.up
        if S.LightningBolt:IsCastableP() and not Player:IsMoving() and not ShouldStop and (Player:BuffP(S.SurgeofPowerBuff)) then
            if HR.Cast(S.LightningBolt) then return "lightning_bolt 736"; end
        end
        -- lava_burst,if=cooldown_react&!talent.master_of_the_elements.enabled
        if S.LavaBurst:IsCastableP() and not ShouldStop and (Player:BuffP(S.LavaSurgeBuff) and not S.MasteroftheElements:IsAvailable()) then
            if HR.Cast(S.LavaBurst) then return "lava_burst 738"; end
        end
        -- icefury,if=talent.icefury.enabled&!(maelstrom>75&cooldown.lava_burst.remains<=0)&(!talent.storm_elemental.enabled|cooldown.storm_elemental.remains<120)
        if S.Icefury:IsCastableP() and not Player:IsMoving() and not ShouldStop and not StormElementalIsActive() and (S.Icefury:IsAvailable() and not (Player:Maelstrom() > 75 and S.LavaBurst:CooldownUpP()) and (not S.StormElemental:IsAvailable() or S.StormElemental:CooldownRemainsP() < 120)) then
            if HR.Cast(S.Icefury) then return "icefury 740"; end
        end
        -- lava_burst,if=cooldown_react&charges>talent.echo_of_the_elements.enabled
        if S.LavaBurst:IsCastableP() and not ShouldStop and (Player:BuffP(S.LavaSurgeBuff) and S.LavaBurst:ChargesP() > num(S.EchooftheElementals:IsAvailable())) then
            if HR.Cast(S.LavaBurst) then return "lava_burst 742"; end
        end
        -- frost_shock,if=talent.icefury.enabled&buff.icefury.up&buff.icefury.remains<1.1*gcd*buff.icefury.stack
        if S.FrostShock:IsCastableP() and not ShouldStop and (S.Icefury:IsAvailable() and Player:BuffP(S.IcefuryBuff) and Player:BuffRemainsP(S.IcefuryBuff) < 1.1 * Player:GCD() * num(Player:BuffStackP(S.IcefuryBuff))) then
            if HR.Cast(S.FrostShock) then return "frost_shock 744"; end
        end
        -- lava_burst,if=cooldown_react
        if S.LavaBurst:IsCastableP() and not ShouldStop and (Player:BuffP(S.LavaSurgeBuff)) then
            if HR.Cast(S.LavaBurst) then return "lava_burst 746"; end
        end
        -- flame_shock,target_if=refreshable&!buff.surge_of_power.up
        if S.FlameShock:IsCastableP() and not ShouldStop and (Target:DebuffRefreshableCP(S.FlameShockDebuff) and Player:BuffDownP(S.SurgeofPowerBuff)) then
            if HR.Cast(S.FlameShock) then return "flame_shock 748"; end
        end
        -- totem_mastery,if=talent.totem_mastery.enabled&(buff.resonance_totem.remains<6|(buff.resonance_totem.remains<(buff.ascendance.duration+cooldown.ascendance.remains)&cooldown.ascendance.remains<15))
        if S.TotemMastery:IsReadyP() and not ShouldStop and (S.TotemMastery:IsAvailable() and (ResonanceTotemTime() < 6 or (ResonanceTotemTime() < (S.Ascendance:BaseDuration() + S.Ascendance:CooldownRemainsP()) and S.Ascendance:CooldownRemainsP() < 15))) then
            if HR.Cast(S.TotemMastery) then return "totem_mastery 750"; end
        end
        -- frost_shock,if=talent.icefury.enabled&buff.icefury.up&(buff.icefury.remains<gcd*4*buff.icefury.stack|buff.stormkeeper.up|!talent.master_of_the_elements.enabled)
        if S.FrostShock:IsCastableP() and not ShouldStop and (S.Icefury:IsAvailable() and Player:BuffP(S.IcefuryBuff) and (Player:BuffRemainsP(S.IcefuryBuff) < Player:GCD() * 4 * Player:BuffStackP(S.IcefuryBuff) or Player:BuffP(S.StormkeeperBuff) or not S.MasteroftheElements:IsAvailable())) then
            if HR.Cast(S.FrostShock) then return "frost_shock 752"; end
        end
        -- flame_shock,moving=1,target_if=refreshable
        if S.FlameShock:IsCastableP() and not ShouldStop and (Player:IsMoving() and Target:DebuffRefreshableCP(S.FlameShockDebuff)) then
            if HR.Cast(S.FlameShock) then return "flame_shock 754"; end
        end
        -- flame_shock,moving=1,if=movement.distance>6
        -- frost_shock,moving=1
        if S.FlameShock:IsCastableP() and not ShouldStop and (Player:IsMoving()) then
            if HR.Cast(S.FlameShock) then return "flame_shock 756"; end
        end
        -- lightning_bolt
        -- Moved moving abilities above LB filler
        if S.LightningBolt:IsCastableP() and not Player:IsMoving() and not ShouldStop then
            if HR.Cast(S.LightningBolt) then return "lightning_bolt 758"; end
        end
    end
	
    local function SingleTarget()
        -- flame_shock,target_if=(!ticking|talent.storm_elemental.enabled&cooldown.storm_elemental.remains<2*gcd|dot.flame_shock.remains<=gcd|talent.ascendance.enabled&dot.flame_shock.remains<(cooldown.ascendance.remains+buff.ascendance.duration)&cooldown.ascendance.remains<4&(!talent.storm_elemental.enabled|talent.storm_elemental.enabled&cooldown.storm_elemental.remains<120))&(buff.wind_gust.stack<14|azerite.igneous_potential.rank>=2|buff.lava_surge.up|!buff.bloodlust.up)&!buff.surge_of_power.up
        if S.FlameShock:IsCastableP() and not ShouldStop and EvaluateCycleFlameShock163(Target) then
            if HR.Cast(S.FlameShock) then return "flame_shock 201" end
        end
        -- ascendance,if=talent.ascendance.enabled&(time>=60|buff.bloodlust.up)&cooldown.lava_burst.remains>0&(cooldown.storm_elemental.remains<120|!talent.storm_elemental.enabled)&(!talent.icefury.enabled|!buff.icefury.up&!cooldown.icefury.up)
        if S.Ascendance:IsCastableP() and not ShouldStop and HR.CDsON() and (S.Ascendance:IsAvailable() and (HL.CombatTime() >= 60 or Player:HasHeroism()) and S.LavaBurst:CooldownRemainsP() > 0 and (S.StormElemental:CooldownRemainsP() < 120 or not S.StormElemental:IsAvailable()) and (not S.Icefury:IsAvailable() or not Player:BuffP(S.IcefuryBuff) and not S.Icefury:CooldownUpP())) then
            if HR.Cast(S.Ascendance, Action.GetToggle(2, "OffGCDasOffGCD")) then return "ascendance 202"; end
        end
        -- elemental_blast,if=talent.elemental_blast.enabled&(talent.master_of_the_elements.enabled&buff.master_of_the_elements.up&maelstrom<60|!talent.master_of_the_elements.enabled)&(!(cooldown.storm_elemental.remains>120&talent.storm_elemental.enabled)|azerite.natural_harmony.rank=3&buff.wind_gust.stack<14)
        if S.ElementalBlast:IsCastableP() and not ShouldStop and (S.ElementalBlast:IsAvailable() and (S.MasteroftheElements:IsAvailable() and Player:BuffP(S.MasteroftheElementsBuff) and Player:Maelstrom() < 60 or not S.MasteroftheElements:IsAvailable()) and (not (S.StormElemental:CooldownRemainsP() > 120 and S.StormElemental:IsAvailable()) or S.NaturalHarmony:AzeriteRank() == 3 and Player:BuffStackP(S.WindGustBuff) < 14)) then
            if HR.Cast(S.ElementalBlast) then return "elemental_blast 218"; end
        end
        -- stormkeeper,if=talent.stormkeeper.enabled&(raid_event.adds.count<3|raid_event.adds.in>50)&(!talent.surge_of_power.enabled|buff.surge_of_power.up|maelstrom>=44)
        if S.Stormkeeper:IsCastableP() and not Player:IsMoving() and not ShouldStop and (S.Stormkeeper:IsAvailable() and ((EnemiesCount - 1) < 3) and (not S.SurgeofPower:IsAvailable() or Player:BuffP(S.SurgeofPowerBuff) or Player:Maelstrom() >= 44)) then
            if HR.Cast(S.Stormkeeper) then return "stormkeeper 236"; end
        end
        -- liquid_magma_totem,if=talent.liquid_magma_totem.enabled&(raid_event.adds.count<3|raid_event.adds.in>50)
        if S.LiquidMagmaTotem:IsCastableP() and not ShouldStop and S.LiquidMagmaTotem:IsAvailable() then
            if HR.Cast(S.LiquidMagmaTotem) then return "liquid_magma_totem 246"; end
        end
        -- lightning_bolt,if=buff.stormkeeper.up&spell_targets.chain_lightning<2&(azerite.lava_shock.rank*buff.lava_shock.stack)<26&(buff.master_of_the_elements.up&!talent.surge_of_power.enabled|buff.surge_of_power.up)
        if S.LightningBolt:IsCastableP() and not ShouldStop and Player:BuffP(S.StormkeeperBuff) and FutureMaelstromPower() <= 90 then
            if HR.Cast(S.LightningBolt) then return "lightning_bolt 252"; end
        end
        -- earth_shock,if=!buff.surge_of_power.up&talent.master_of_the_elements.enabled&(buff.master_of_the_elements.up|cooldown.lava_burst.remains>0&maelstrom>=92+30*talent.call_the_thunder.enabled|spell_targets.chain_lightning<2&(azerite.lava_shock.rank*buff.lava_shock.stack<26)&buff.stormkeeper.up&cooldown.lava_burst.remains<=gcd)
        if S.EarthShock:IsReadyP() and not ShouldStop and S.MasteroftheElements:IsAvailable() and Player:BuffP(S.MasteroftheElementsBuff) and FutureMaelstromPower() >= 60  then
            if HR.Cast(S.EarthShock) then return "earth_shock 294"; end
        end
        -- earth_shock,if=!talent.master_of_the_elements.enabled&!(azerite.igneous_potential.rank>2&buff.ascendance.up)&(buff.stormkeeper.up|maelstrom>=90+30*talent.call_the_thunder.enabled|!(cooldown.storm_elemental.remains>120&talent.storm_elemental.enabled)&expected_combat_length-time-cooldown.storm_elemental.remains-150*floor((expected_combat_length-time-cooldown.storm_elemental.remains)%150)>=30*(1+(azerite.echo_of_the_elementals.rank>=2)))
        if S.EarthShock:IsReadyP() and not ShouldStop and (not S.MasteroftheElements:IsAvailable() and not (S.IgneousPotential:AzeriteRank() > 2 and Player:BuffP(S.AscendanceBuff)) and (Player:BuffP(S.StormkeeperBuff) or Player:Maelstrom() >= 90 + 30 * num(S.CalltheThunder:IsAvailable()) or not (S.StormElemental:CooldownRemainsP() > 120 and S.StormElemental:IsAvailable()) and Target:TimeToDie() - S.StormElemental:CooldownRemainsP() - 150 * math.floor ((Target:TimeToDie() - S.StormElemental:CooldownRemainsP()) / 150) >= 30 * (1 + num((S.EchooftheElementals:AzeriteRank() >= 2))))) then
            if HR.Cast(S.EarthShock) then return "earth_shock 314"; end
        end
        -- earth_shock,if=talent.surge_of_power.enabled&!buff.surge_of_power.up&cooldown.lava_burst.remains<=gcd&(!talent.storm_elemental.enabled&!(cooldown.fire_elemental.remains>120)|talent.storm_elemental.enabled&!(cooldown.storm_elemental.remains>120))
        if S.EarthShock:IsReadyP() and not ShouldStop and (S.SurgeofPower:IsAvailable() and not Player:BuffP(S.SurgeofPowerBuff) and S.LavaBurst:CooldownRemainsP() <= Player:GCD() and (not S.StormElemental:IsAvailable() and not (S.FireElemental:CooldownRemainsP() > 120) or S.StormElemental:IsAvailable() and not (S.StormElemental:CooldownRemainsP() > 120))) then
            if HR.Cast(S.EarthShock) then return "earth_shock 336"; end
        end
        -- frost_shock,if=talent.icefury.enabled&talent.master_of_the_elements.enabled&buff.icefury.up&buff.master_of_the_elements.up
        if S.FrostShock:IsCastableP() and not ShouldStop and (S.Icefury:IsAvailable() and S.MasteroftheElements:IsAvailable() and Player:BuffP(S.IcefuryBuff) and Player:BuffP(S.MasteroftheElementsBuff)) then
            if HR.Cast(S.FrostShock) then return "frost_shock 372"; end
        end
        -- lava_burst,if=buff.ascendance.up
        if S.LavaBurst:IsCastableP() and not Player:IsMoving() and not Player:PrevGCDP(1, S.LavaBurst) and not Player:IsCasting(S.LavaBurst) and not ShouldStop and (Player:BuffP(S.AscendanceBuff)) then
            if HR.Cast(S.LavaBurst) then return "lava_burst 382"; end
        end
        -- flame_shock,target_if=refreshable&active_enemies>1&buff.surge_of_power.up
        if S.FlameShock:IsCastableP() and not ShouldStop and EvaluateCycleFlameShock390(Target)  then
            if HR.Cast(S.FlameShock) then return "flame_shock 408" end
        end
        -- lava_burst,if=talent.storm_elemental.enabled&cooldown_react&buff.surge_of_power.up&(expected_combat_length-time-cooldown.storm_elemental.remains-150*floor((expected_combat_length-time-cooldown.storm_elemental.remains)%150)<30*(1+(azerite.echo_of_the_elementals.rank>=2))|(1.16*(expected_combat_length-time)-cooldown.storm_elemental.remains-150*floor((1.16*(expected_combat_length-time)-cooldown.storm_elemental.remains)%150))<(expected_combat_length-time-cooldown.storm_elemental.remains-150*floor((expected_combat_length-time-cooldown.storm_elemental.remains)%150)))
        if S.LavaBurst:IsCastableP() and not Player:IsMoving() and not Player:PrevGCDP(1, S.LavaBurst) and not Player:IsCasting(S.LavaBurst) and not Player:BuffP(S.MasteroftheElementsBuff) and not ShouldStop and (S.StormElemental:IsAvailable() and S.LavaBurst:CooldownUpP() and Player:BuffP(S.SurgeofPowerBuff) and (Target:TimeToDie() - S.StormElemental:CooldownRemainsP() - 150 * math.floor ((Target:TimeToDie() - S.StormElemental:CooldownRemainsP()) / 150) < 30 * (1 + num((S.EchooftheElementals:AzeriteRank() >= 2))) or (1.16 * Target:TimeToDie() - S.StormElemental:CooldownRemainsP() - 150 * math.floor ((1.16 * Target:TimeToDie() - S.StormElemental:CooldownRemainsP()) / 150)) < (Target:TimeToDie() - S.StormElemental:CooldownRemainsP() - 150 * math.floor ((Target:TimeToDie() - S.StormElemental:CooldownRemainsP()) / 150)))) then
            if HR.Cast(S.LavaBurst) then return "lava_burst 409"; end
        end
        -- lava_burst,if=!talent.storm_elemental.enabled&cooldown_react&buff.surge_of_power.up&(expected_combat_length-time-cooldown.fire_elemental.remains-150*floor((expected_combat_length-time-cooldown.fire_elemental.remains)%150)<30*(1+(azerite.echo_of_the_elementals.rank>=2))|(1.16*(expected_combat_length-time)-cooldown.fire_elemental.remains-150*floor((1.16*(expected_combat_length-time)-cooldown.fire_elemental.remains)%150))<(expected_combat_length-time-cooldown.fire_elemental.remains-150*floor((expected_combat_length-time-cooldown.fire_elemental.remains)%150)))
        if S.LavaBurst:IsCastableP() and not Player:IsMoving() and not Player:PrevGCDP(1, S.LavaBurst) and not Player:IsCasting(S.LavaBurst) and not Player:BuffP(S.MasteroftheElementsBuff) and not ShouldStop and (not S.StormElemental:IsAvailable() and S.LavaBurst:CooldownUpP() and Player:BuffP(S.SurgeofPowerBuff) and (Target:TimeToDie() - S.FireElemental:CooldownRemainsP() - 150 * math.floor ((Target:TimeToDie() - S.FireElemental:CooldownRemainsP()) / 150) < 30 * (1 + num((S.EchooftheElementals:AzeriteRank() >= 2))) or (1.16 * Target:TimeToDie() - S.FireElemental:CooldownRemainsP() - 150 * math.floor ((1.16 * Target:TimeToDie() - S.FireElemental:CooldownRemainsP()) / 150)) < (Target:TimeToDie() - S.FireElemental:CooldownRemainsP() - 150 * math.floor ((Target:TimeToDie() - S.FireElemental:CooldownRemainsP()) / 150)))) then
            if HR.Cast(S.LavaBurst) then return "lava_burst 433"; end
        end
        -- lightning_bolt,if=buff.surge_of_power.up
        if S.LightningBolt:IsCastableP() and not Player:IsMoving() and not ShouldStop and (Player:BuffP(S.SurgeofPowerBuff)) and FutureMaelstromPower() <= 90 then
            if HR.Cast(S.LightningBolt) then return "lightning_bolt 457"; end
        end
        -- lava_burst,if=cooldown_react&!talent.master_of_the_elements.enabled
        if S.LavaBurst:IsCastableP() and not Player:IsMoving() and not Player:PrevGCDP(1, S.LavaBurst) and not Player:IsCasting(S.LavaBurst) and not ShouldStop and (S.LavaBurst:CooldownUpP() and not S.MasteroftheElements:IsAvailable()) then
            if HR.Cast(S.LavaBurst) then return "lava_burst 461"; end
        end
        -- icefury,if=talent.icefury.enabled&!(maelstrom>75&cooldown.lava_burst.remains<=0)&(!talent.storm_elemental.enabled|cooldown.storm_elemental.remains<120)
        if S.Icefury:IsCastableP() and not Player:IsMoving() and not ShouldStop and not StormElementalIsActive() and (S.Icefury:IsAvailable() and not (FutureMaelstromPower() > 75 and S.LavaBurst:CooldownRemainsP() <= 0) and (not S.StormElemental:IsAvailable() or S.StormElemental:CooldownRemainsP() < 120)) then
            if HR.Cast(S.Icefury) then return "icefury 469"; end
        end
        -- lava_burst,if=cooldown_react&charges>talent.echo_of_the_elements.enabled
        if S.LavaBurst:IsCastableP() and not Player:IsMoving() and not Player:PrevGCDP(1, S.LavaBurst) and not Player:IsCasting(S.LavaBurst) and not ShouldStop and not Player:BuffP(S.MasteroftheElementsBuff) and (S.LavaBurst:CooldownUpP() and S.LavaBurst:ChargesP() > num(S.EchooftheElements:IsAvailable())) then
            if HR.Cast(S.LavaBurst) then return "lava_burst 479"; end
        end
        -- frost_shock,if=talent.icefury.enabled&buff.icefury.up&buff.icefury.remains<1.1*gcd*buff.icefury.stack
        if S.FrostShock:IsCastableP() and not ShouldStop and (S.Icefury:IsAvailable() and Player:BuffP(S.IcefuryBuff) and Player:BuffRemainsP(S.IcefuryBuff) < 1.1 * Player:GCD() * Player:BuffStackP(S.IcefuryBuff)) then
            if HR.Cast(S.FrostShock) then return "frost_shock 491"; end
        end
        -- lava_burst,if=cooldown_react
        if S.LavaBurst:IsCastableP() and not Player:IsMoving() and not Player:PrevGCDP(1, S.LavaBurst) and not Player:IsCasting(S.LavaBurst) and not ShouldStop and (S.LavaBurst:CooldownUpP()) and not Player:BuffP(S.MasteroftheElementsBuff) then
            if HR.Cast(S.LavaBurst) then return "lava_burst 501"; end
        end
        -- flame_shock,target_if=refreshable&!buff.surge_of_power.up
        if S.FlameShock:IsCastableP() and not ShouldStop and EvaluateCycleFlameShock511(Target) then
            if HR.Cast(S.FlameShock) then return "flame_shock 521" end
        end
        -- totem_mastery,if=talent.totem_mastery.enabled&(buff.resonance_totem.remains<6|(buff.resonance_totem.remains<(buff.ascendance.duration+cooldown.ascendance.remains)&cooldown.ascendance.remains<15))
        if S.TotemMastery:IsReadyP() and not ShouldStop and (S.TotemMastery:IsAvailable() and (ResonanceTotemTime() < 6 or (ResonanceTotemTime() < (S.AscendanceBuff:BaseDuration() + S.Ascendance:CooldownRemainsP()) and S.Ascendance:CooldownRemainsP() < 15))) then
            if HR.Cast(S.TotemMastery) then return "totem_mastery 522"; end
        end
        -- frost_shock,if=talent.icefury.enabled&buff.icefury.up&(buff.icefury.remains<gcd*4*buff.icefury.stack|buff.stormkeeper.up|!talent.master_of_the_elements.enabled)
        if S.FrostShock:IsCastableP() and not ShouldStop and (S.Icefury:IsAvailable() and Player:BuffP(S.IcefuryBuff) and (Player:BuffRemainsP(S.IcefuryBuff) < Player:GCD() * 4 * Player:BuffStackP(S.IcefuryBuff) or Player:BuffP(S.StormkeeperBuff) or not S.MasteroftheElements:IsAvailable())) then
            if HR.Cast(S.FrostShock) then return "frost_shock 536"; end
        end
        -- chain_lightning,if=buff.tectonic_thunder.up&!buff.stormkeeper.up&spell_targets.chain_lightning>1
        if S.ChainLightning:IsCastableP() and HR.AoEON() and not ShouldStop and (Player:BuffP(S.TectonicThunderBuff) and not Player:BuffP(S.StormkeeperBuff) and EnemiesCount > 1) then
            if HR.Cast(S.ChainLightning) then return "chain_lightning 550"; end
        end
        -- lightning_bolt
        if S.LightningBolt:IsCastableP() and not Player:IsMoving() and not ShouldStop and FutureMaelstromPower() <= 90 then
            if HR.Cast(S.LightningBolt) then return "lightning_bolt 556"; end
        end
        -- flame_shock,moving=1,target_if=refreshable
        if S.FlameShock:IsCastableP() and not ShouldStop and EvaluateCycleFlameShock562(Target) and Player:IsMoving() then
            if HR.Cast(S.FlameShock) then return "flame_shock 570" end
        end
        -- flame_shock,moving=1,if=movement.distance>6
        if S.FlameShock:IsCastableP() and not ShouldStop and Player:IsMoving() and Player:MovingFor() > 6 then
            if HR.Cast(S.FlameShock) then return "flame_shock 571"; end
        end
		-- 14 Lavaburst while moving
        if S.LavaBurst:IsCastableP() and Player:IsMoving() and Target:DebuffRemainsP(S.FlameShockDebuff) >= S.LavaBurst:CastTime() and Player:BuffP(S.LavaSurgeBuff) and FutureMaelstromPower() <= 90 then
            if HR.Cast(S.LavaBurst) then return "lava_burst 734"; end
        end		
        -- 15 lightning_bolt while moving w buff sk
        if S.LightningBolt:IsCastableP() and Player:IsMoving()  and Player:BuffP(S.StormkeeperBuff) then
            if HR.Cast(S.LightningBolt) then return "lightning_bolt 556"; end
        end		
		-- 16 frost_shock  ,moving
        if S.FrostShock:IsCastableP() and Player:IsMoving() and not Player:BuffP(S.StormkeeperBuff) then
            if HR.Cast(S.FrostShock, Action.GetToggle(2, "OffGCDasOffGCD")) then return "frost_shock 157"; end
        end	
        -- frost_shock,moving=1
        if S.FrostShock:IsCastableP() and not ShouldStop and Player:IsMoving() then
            if HR.Cast(S.FrostShock) then return "frost_shock 573"; end
        end
    end
	
	local function Trinkets()
	    -- use_item,name=azsharas_font_of_power,if=cooldown.combustion.remains<=5+15*variable.font_double_on_use
        if I.AzsharasFontofPower:IsEquipped() and I.AzsharasFontofPower:IsReady() and TR.TrinketON() then
            if HR.Cast(I.AzsharasFontofPower) then return "azsharas_font_of_power high_priority"; end
        end
        -- use_item,name=rotcrusted_voodoo_doll,if=cooldown.combustion.remains>variable.on_use_cutoff
        if I.RotcrustedVoodooDoll:IsEquipped() and I.RotcrustedVoodooDoll:IsReady() and TR.TrinketON() then
            if HR.Cast(I.RotcrustedVoodooDoll) then return "rotcrusted_voodoo_doll high_priority"; end
        end
        -- use_item,name=aquipotent_nautilus,if=cooldown.combustion.remains>variable.on_use_cutoff
        if I.AquipotentNautilus:IsEquipped() and I.AquipotentNautilus:IsReady() and TR.TrinketON() then
            if HR.Cast(I.AquipotentNautilus) then return "aquipotent_nautilus high_priority"; end
        end
        -- use_item,name=shiver_venom_relic,if=(cooldown.summon_demonic_tyrant.remains>=25|target.time_to_die<=30)
        if I.ShiverVenomRelic:IsEquipped() and I.ShiverVenomRelic:IsReady() and Target:DebuffStackP(S.ShiverVenomDebuff) >= 5 and not ShouldStop and TR.TrinketON() then
            if HR.Cast(I.ShiverVenomRelic) then return "shiver_venom_relic"; end
        end
        -- use_item,effect_name=harmonic_dematerializer
        if I.PocketsizedComputationDevice:IsEquipped() and I.PocketsizedComputationDevice:IsReady() and TR.TrinketON() then
            if HR.Cast(I.PocketsizedComputationDevice) then return "harmonic_dematerializer high_priority"; end
        end
        -- use_item,use_off_gcd=1,name=balefire_branch,if=buff.combustion.up|action.meteor.in_flight&action.meteor.in_flight_remains<=0.5
        if I.BalefireBranch:IsEquipped() and I.BalefireBranch:IsReady() and TR.TrinketON() then
            if HR.Cast(I.BalefireBranch) then return "balefire_branch combustion"; end
        end
	end
	
	local function CustomST()
	    -- 0 TotemMastery
        if S.TotemMastery:IsReadyP() and ResonanceTotemTime() < 6 and (S.TotemMastery:IsAvailable() and not Player:BuffP(S.ResonanceTotemBuff)) then
            if HR.Cast(S.TotemMastery) then return "totem_mastery 585"; end
        end
	    -- 1 FLame shock
	    if S.FlameShock:IsReadyP() and (not Target:DebuffP(S.FlameShockDebuff) or Target:DebuffRemainsP(S.FlameShockDebuff) <= 6) and Target:TimeToDie() > 15 then 
	        if HR.Cast(S.FlameShock) then return "flame_shock 571"; end
		end		
		-- 2 Stormkeeper
		if S.Stormkeeper:IsCastableP() and not Player:IsMoving() and S.Stormkeeper:IsAvailable() then 
            if HR.Cast(S.Stormkeeper) then return "stormkeeper 236"; end
        end		
		-- 3 Fire Elemental
        if S.FireElemental:IsCastableP() and HR.CDsON() and (not S.StormElemental:IsAvailable()) then
            if HR.Cast(S.FireElemental, Action.GetToggle(2, "OffGCDasOffGCD")) then return "fire_elemental 591"; end
        end
        -- 3 Storm Elemental
        if S.StormElemental:IsCastableP() and HR.CDsON() then
            if HR.Cast(S.StormElemental, Action.GetToggle(2, "OffGCDasOffGCD")) then return "storm_elemental 595"; end
        end
		-- 4 Icefury
        if S.Icefury:IsCastableP() and not Player:IsMoving() and not StormElementalIsActive() and S.Icefury:IsAvailable() and not Player:BuffP(S.StormkeeperBuff) then
            if HR.Cast(S.Icefury) then return "icefury 469"; end
        end	
    	-- 5 Eye of the Storm if Storm Elemental is up and we got Primal Elementalists
    	if S.EyeOfTheStorm:CooldownRemainsP() < 0.1 and S.PrimalElementalist:IsAvailable() and HR.CDsON() and StormElementalIsActive() and S.CallLightning:CooldownRemainsP() > 1 then
           if HR.Cast(S.EyeOfTheStorm) then return "EyeOfTheStorm 469"; end
        end
		-- 6 Earth Elemental		
		-- 7 Racials		
		-- 8 Trinkets
		local ShouldReturn = Trinkets(); if ShouldReturn and HR.CDsON() then return ShouldReturn; end
		-- 9 Liquid Magma Totem
        if S.LiquidMagmaTotem:IsCastableP() and S.LiquidMagmaTotem:IsAvailable() then
            if HR.Cast(S.LiquidMagmaTotem) then return "liquid_magma_totem 88"; end
        end
		-- 10 Elemental Blast
        if S.ElementalBlast:IsReadyP() and S.ElementalBlast:IsAvailable() then
            if HR.Cast(S.ElementalBlast) then return "elemental_blast 218"; end
        end
		-- 11 Ascendance
        if S.Ascendance:IsCastableP() and HR.CDsON() and S.Ascendance:IsAvailable() then
            if HR.Cast(S.Ascendance, Action.GetToggle(2, "OffGCDasOffGCD")) then return "ascendance 202"; end
        end	
		-- 13 EarthShock
		if S.EarthShock:IsReadyP() and FutureMaelstromPower() >= 60 then 
		    if HR.Cast(S.EarthShock, Action.GetToggle(2, "OffGCDasOffGCD")) then return "EarthShock 33"; end
		end
        -- 18 lava_burst
        if S.LavaBurst:IsCastableP() and not Player:IsMoving() and Target:DebuffRemainsP(S.FlameShockDebuff) >= S.LavaBurst:CastTime() and FutureMaelstromPower() <= 90 and Player:BuffP(S.SurgeofPowerBuff) and not Player:BuffP(S.StormkeeperBuff) then
            if HR.Cast(S.LavaBurst) then return "lava_burst 734"; end
        end
        -- 17 frost_shock
        if S.FrostShock:IsCastableP() and S.Icefury:IsAvailable() and Player:BuffP(S.IcefuryBuff) and not Player:BuffP(S.LavaSurgeBuff) then
            if HR.Cast(S.FrostShock, Action.GetToggle(2, "OffGCDasOffGCD")) then return "frost_shock 536"; end
        end	
        -- 15 lightning_bolt
        if S.LightningBolt:IsCastableP() and Player:BuffP(S.StormkeeperBuff) then
            if HR.Cast(S.LightningBolt) then return "lightning_bolt 556"; end
        end
		-- 14 Lavaburst while moving
        if S.LavaBurst:IsCastableP() and Player:IsMoving() and Target:DebuffRemainsP(S.FlameShockDebuff) >= S.LavaBurst:CastTime() and Player:BuffP(S.LavaSurgeBuff) and FutureMaelstromPower() <= 90 then
            if HR.Cast(S.LavaBurst) then return "lava_burst 734"; end
        end		
        -- 15 lightning_bolt while moving w buff sk
        if S.LightningBolt:IsCastableP() and Player:IsMoving()  and Player:BuffP(S.StormkeeperBuff) then
            if HR.Cast(S.LightningBolt) then return "lightning_bolt 556"; end
        end		
		-- 16 frost_shock  ,moving
        if S.FrostShock:IsCastableP() and Player:IsMoving() and not Player:BuffP(S.StormkeeperBuff) then
            if HR.Cast(S.FrostShock, Action.GetToggle(2, "OffGCDasOffGCD")) then return "frost_shock 157"; end
        end	
        -- 12 Lavaburst		
        if S.LavaBurst:IsCastableP() and Target:DebuffRemainsP(S.FlameShockDebuff) >= S.LavaBurst:CastTime() and not Player:BuffP(S.LavaSurgeBuff) and not Player:BuffP(S.IcefuryBuff) and FutureMaelstromPower() <= 80 then
            if HR.Cast(S.LavaBurst) then return "lava_burst 33"; end
        end		
			
		
	end
	
	------------------------------------------------------
	---------------- MOUSE OVER ROTATION -----------------
	------------------------------------------------------
	-- Mouseover DPS Rotation
	-- Only handling mouseover multidots and dots refreshable
	local function MouseoverRotation(unit)
		
		-- Variables
        inRange = A.ChainLightning:IsInRange(unit)
		
		-- Note: Toggles  ("UseDispel", "UsePurge", "UseExpelEnrage")
        -- Category ("Dispel", "MagicMovement", "PurgeFriendly", "PurgeHigh", "PurgeLow", "Enrage")
        -- Purge
		if S.Purge:IsReady() and Action.GetToggle(2, "mouseover") and not ShouldStop and Action.AuraIsValid(unit, "UsePurge", "PurgeHigh") then
            if HR.Cast(S.Purge) then return "" end
        end	
		
		-- WindShear
        if useKick and Action.GetToggle(2, "mouseover") and S.WindShear:IsReadyP(30) and ActionUnit(unit):CanInterrupt(true) then 
            if HR.Cast(S.WindShear, true) then return "WindShear 5"; end
        else 
            return
        end   	
				
		-- FlameShock
		if A.FlameShock:IsReady(unit) and Action.GetToggle(2, "mouseover") and EnemiesCount <= 3 and not ShouldStop and (ActionUnit(unit):HasDeBuffs(A.FlameShockDebuff.ID) <= 5 or ActionUnit(unit):HasDeBuffs(A.FlameShockDebuff.ID) == 0) and not Player:PrevGCDP(1, S.FlameShock) and ActionUnit(unit):TimeToDie() >= 15 then
			if HR.Cast(S.FlameShock) then return "FlameShock 837" end
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
		
  	    -- WindShear
  	    if useKick and S.WindShear:IsReadyP(30) and not ShouldStop then 
		  	if ActionUnit(unit):CanInterrupt(true, nil, 25, 70) then
          	    if HR.Cast(S.WindShear, true) then return "WindShear 5"; end
         	end 
      	end	
     	-- CapacitorTotem
      	if useCC and Action.GetToggle(2, "UseCapacitorTotem") and not S.WindShear:IsReadyP(30) and not ShouldStop and S.CapacitorTotem:IsReady() and not ShouldStop then 
	  		if ActionUnit(unit):CanInterrupt(true, nil, 25, 70) then
     	        if HR.Cast(S.CapacitorTotem, true) then return "CapacitorTotem 5"; end
     	    end 
     	end 
        -- Mouseover         
        if Action.IsUnitEnemy("mouseover") and not ActionUnit("mouseover"):IsDead() and Action.GetToggle(2, "mouseover") then 
            unit = "mouseover"
                
            if MouseoverRotation(unit) then 
                return true 
            end 
        end
		-- Purge
		-- Note: Toggles  ("UseDispel", "UsePurge", "UseExpelEnrage")
        -- Category ("Dispel", "MagicMovement", "PurgeFriendly", "PurgeHigh", "PurgeLow", "Enrage")
        if S.Purge:IsReady() and not ShouldStop and Action.AuraIsValid("target", "UsePurge", "PurgeHigh") then
            if HR.Cast(S.Purge) then return "" end
        end	
		-- Ghost Wolf
		if Target:MinDistanceToPlayer(true) > 40 and S.GhostWolf:IsReadyP() and not ShouldStop and not Player:BuffP(S.GhostWolfBuff) and Action.GetToggle(2, "UseGhostWolf") then
		    if HR.Cast(S.GhostWolf) then return "GhostWolf 585"; end
		end
		-- Earth Shield
        if S.EarthShield:IsReady() and Player:HealthPercentage() <= Action.GetToggle(2, "EarthShieldHP") then
            if HR.Cast(S.EarthShield) then return "EarthShield 267"; end
        end
		-- Healing Surge
        if S.HealingSurge:IsReady() and Player:HealthPercentage() <= Action.GetToggle(2, "HealingSurgeHP") then
            if HR.Cast(S.HealingSurge) then return "HealingSurge 267"; end
        end
		-- Astral Shift
        if S.AstralShift:IsReady() and Player:HealthPercentage() <= Action.GetToggle(2, "AstralShiftHP") then
            if HR.Cast(S.AstralShift) then return "AstralShift 267"; end
        end
        -- bloodlust,if=azerite.ancestral_resonance.enabled
        -- potion,if=expected_combat_length-time<30|cooldown.fire_elemental.remains>120|cooldown.storm_elemental.remains>120
        if I.PotionofUnbridledFury:IsReady() and not ShouldStop and Action.GetToggle(1, "Potion") and (Target:TimeToDie() < 30 or S.FireElemental:CooldownRemainsP() > 120 or S.StormElemental:CooldownRemainsP() > 120) then
            if HR.Cast(I.PotionofUnbridledFury) then return "battle_potion_of_intellect 577"; end
        end
        -- totem_mastery,if=talent.totem_mastery.enabled&buff.resonance_totem.remains<2
        if S.TotemMastery:IsReadyP() and not ShouldStop and ResonanceTotemTime() < 6 and (S.TotemMastery:IsAvailable() and not Player:BuffP(S.ResonanceTotemBuff)) then
            if HR.Cast(S.TotemMastery) then return "totem_mastery 585"; end
        end
        -- use_items
        -- fire_elemental,if=!talent.storm_elemental.enabled
        if S.FireElemental:IsCastableP() and not ShouldStop and HR.CDsON() and (not S.StormElemental:IsAvailable()) then
            if HR.Cast(S.FireElemental, Action.GetToggle(2, "OffGCDasOffGCD")) then return "fire_elemental 591"; end
        end
        -- storm_elemental,if=talent.storm_elemental.enabled&(!talent.icefury.enabled|!buff.icefury.up&!cooldown.icefury.up)&(!talent.ascendance.enabled|!cooldown.ascendance.up)
        if S.StormElemental:IsCastableP() and not ShouldStop and HR.CDsON() and (S.StormElemental:IsAvailable() and (not S.Icefury:IsAvailable() or not Player:BuffP(S.IcefuryBuff) and not S.Icefury:CooldownUpP()) and (not S.Ascendance:IsAvailable() or not S.Ascendance:CooldownUpP())) then
            if HR.Cast(S.StormElemental, Action.GetToggle(2, "OffGCDasOffGCD")) then return "storm_elemental 595"; end
        end
    	-- Eye of the Storm if Storm Elemental is up and we got Primal Elementalists
    	if S.EyeOfTheStorm:CooldownRemainsP() < 0.1 and S.PrimalElementalist:IsAvailable() and HR.CDsON() and StormElementalIsActive() and S.CallLightning:CooldownRemainsP() > 1 then
		    if HR.Cast(S.EyeOfTheStorm) then return "EyeOfTheStorm"; end
        end
        -- Manually added, defensive Earth Elemental with custom settings from UI. 
		if S.EarthElemental:IsCastableP() and Action.GetToggle(2, "UseEarthElemental") and Player:HealthPercentage() <= Action.GetToggle(2, "EarthElementalHP") and EnemiesCount >= Action.GetToggle(2, "EarthElementalEnemies") then
		    if HR.Cast(S.EarthElemental) then return "EarthElemental 7"; end
		end
		-- concentrated_flame
        if S.ConcentratedFlame:IsCastableP() and Action.GetToggle(1, "HeartOfAzeroth") and not Player:IsMoving() and not ShouldStop then
            if HR.Cast(S.ConcentratedFlame) then return "concentrated_flame"; end
        end
        -- blood_of_the_enemy
        if S.BloodoftheEnemy:IsCastableP() and HR.CDsON() and Action.GetToggle(1, "HeartOfAzeroth") and not Player:IsMoving() and not ShouldStop then
            if HR.Cast(S.BloodoftheEnemy) then return "blood_of_the_enemy"; end
        end
        -- guardian_of_azeroth
        if S.GuardianofAzeroth:IsCastableP() and HR.CDsON() and Action.GetToggle(1, "HeartOfAzeroth") and not Player:IsMoving() and not ShouldStop then
            if HR.Cast(S.GuardianofAzeroth) then return "guardian_of_azeroth"; end
        end
        -- focused_azerite_beam
        if S.FocusedAzeriteBeam:IsCastableP() and HR.CDsON() and Action.GetToggle(1, "HeartOfAzeroth") and not Player:IsMoving() and not ShouldStop then
            if HR.Cast(S.FocusedAzeriteBeam) then return "focused_azerite_beam"; end
        end
        -- purifying_blast
        if S.PurifyingBlast:IsCastableP() and Action.GetToggle(1, "HeartOfAzeroth") and not Player:IsMoving() and not ShouldStop then
            if HR.Cast(S.PurifyingBlast) then return "purifying_blast"; end
        end
        -- the_unbound_force
        if S.TheUnboundForce:IsCastableP() and HR.CDsON() and Action.GetToggle(1, "HeartOfAzeroth") and not Player:IsMoving() and not ShouldStop then
            if HR.Cast(S.TheUnboundForce) then return "the_unbound_force"; end
        end
        -- memory_of_lucid_dreams
        if S.MemoryofLucidDreams:IsCastableP() and HR.CDsON() and Action.GetToggle(1, "HeartOfAzeroth") and not Player:IsMoving() and not ShouldStop then
            if HR.Cast(S.MemoryofLucidDreams) then return "memory_of_lucid_dreams"; end
        end
        -- ripple_in_space
        if S.RippleInSpace:IsCastableP() and Action.GetToggle(1, "HeartOfAzeroth") and not Player:IsMoving() and not ShouldStop then
            if HR.Cast(S.RippleInSpace) then return "ripple_in_space"; end
        end
        -- worldvein_resonance
        if S.WorldveinResonance:IsCastableP() and Action.GetToggle(1, "HeartOfAzeroth") and not Player:IsMoving() and not ShouldStop then
            if HR.Cast(S.WorldveinResonance) then return "worldvein_resonance"; end
        end
        -- blood_fury,if=!talent.ascendance.enabled|buff.ascendance.up|cooldown.ascendance.remains>50
        if S.BloodFury:IsCastableP() and not ShouldStop and HR.CDsON() and (not S.Ascendance:IsAvailable() or Player:BuffP(S.AscendanceBuff) or S.Ascendance:CooldownRemainsP() > 50) then
            if HR.Cast(S.BloodFury, Action.GetToggle(2, "OffGCDasOffGCD")) then return "blood_fury 611"; end
        end
        -- berserking,if=!talent.ascendance.enabled|buff.ascendance.up
        if S.Berserking:IsCastableP() and not Player:BuffP(S.StormkeeperBuff) and not ShouldStop and HR.CDsON() and (not S.Ascendance:IsAvailable() or Player:BuffP(S.AscendanceBuff)) then
            if HR.Cast(S.Berserking, Action.GetToggle(2, "OffGCDasOffGCD")) then return "berserking 619"; end
        end
        -- fireblood,if=!talent.ascendance.enabled|buff.ascendance.up|cooldown.ascendance.remains>50
        if S.Fireblood:IsCastableP() and not ShouldStop and HR.CDsON() and (not S.Ascendance:IsAvailable() or Player:BuffP(S.AscendanceBuff) or S.Ascendance:CooldownRemainsP() > 50) then
            if HR.Cast(S.Fireblood, Action.GetToggle(2, "OffGCDasOffGCD")) then return "fireblood 625"; end
        end
        -- ancestral_call,if=!talent.ascendance.enabled|buff.ascendance.up|cooldown.ascendance.remains>50
        if S.AncestralCall:IsCastableP() and not ShouldStop and HR.CDsON() and (not S.Ascendance:IsAvailable() or Player:BuffP(S.AscendanceBuff) or S.Ascendance:CooldownRemainsP() > 50) then
            if HR.Cast(S.AncestralCall, Action.GetToggle(2, "OffGCDasOffGCD")) then return "ancestral_call 633"; end
        end
		-- Auto Multi Dot	  
	    if not Player:PrevGCDP(1, S.TargetEnemy) and Action.GetToggle(2, "AutoDot") and S.FlameShock:IsReadyP() and CanMultidot and (MissingFlameShock >= 1 or FlameShockToRefresh >= 1) and EnemiesCount > 1 and EnemiesCount < 4 and Target:DebuffRemainsP(S.FlameShockDebuff) >= 12 then
            if HR.Cast(S.TargetEnemy) then return "TargetEnemy 69" end
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
        -- Trinkets with CDs check ON
        if (true) and HR.CDsON() then
            local ShouldReturn = Trinkets(); if ShouldReturn then return ShouldReturn; end
        end			
        -- run_action_list,name=aoe,if=active_enemies>2&(spell_targets.chain_lightning>2|spell_targets.lava_beam>2)
        if (EnemiesCount > 2 or Cache.EnemiesCount[40] > 2) and Action.GetToggle(2, "AoE") then
            local ShouldReturn = Aoe(); if ShouldReturn then return ShouldReturn; end
        end
        -- run_action_list,name=single_target
        if S.MasteroftheElements:IsAvailable() then
            local ShouldReturn = SingleTarget(); if ShouldReturn then return ShouldReturn; end
        end
        -- CustomST
        if (EnemiesCount < 2) or not Action.GetToggle(2, "AoE") and not S.MasteroftheElements:IsAvailable() then
            local ShouldReturn = CustomST(); if ShouldReturn then return ShouldReturn; end
        end
        -- run_action_list,name=funnel,if=active_enemies>=2&(spell_targets.chain_lightning<2|spell_targets.lava_beam<2)
        if (EnemiesCount < 2) then
            local ShouldReturn = Funnel(); if ShouldReturn then return ShouldReturn; end
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