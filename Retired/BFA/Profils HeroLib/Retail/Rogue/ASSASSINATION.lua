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

Action[ACTION_CONST_ROGUE_ASSASSINATION] = {
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
    LightsJudgment                        = Action.Create({ Type = "Spell", ID = 255647     }),
    -- Generics Spells
    Envenom                                = Action.Create({ Type = "Spell", ID = 32645     }),
    FanofKnives                            = Action.Create({ Type = "Spell", ID = 51723     }),
    Garrote                                = Action.Create({ Type = "Spell", ID = 703     }),
    KidneyShot                             = Action.Create({ Type = "Spell", ID = 408     }),
    Mutilate                               = Action.Create({ Type = "Spell", ID = 1329     }),
    PoisonedKnife                          = Action.Create({ Type = "Spell", ID = 185565     }),
    Rupture                                = Action.Create({ Type = "Spell", ID = 1943     }),
    Stealth                                = Action.Create({ Type = "Spell", ID = 1784     }),
    Stealth2                               = Action.Create({ Type = "Spell", ID = 115191     }), -- w/ Subterfuge Talent
    Vanish                                 = Action.Create({ Type = "Spell", ID = 1856     }),
    Vendetta                               = Action.Create({ Type = "Spell", ID = 79140     }),
    -- Talents
    Blindside                              = Action.Create({ Type = "Spell", ID = 111240     }),
    CrimsonTempest                         = Action.Create({ Type = "Spell", ID = 121411     }),
    DeeperStratagem                        = Action.Create({ Type = "Spell", ID = 193531     }),
    Exsanguinate                           = Action.Create({ Type = "Spell", ID = 200806     }),
    InternalBleeding                       = Action.Create({ Type = "Spell", ID = 154953     }),
    MarkedforDeath                         = Action.Create({ Type = "Spell", ID = 137619     }),
    MasterAssassin                         = Action.Create({ Type = "Spell", ID = 255989     }),
    Nightstalker                           = Action.Create({ Type = "Spell", ID = 14062     }),
    Subterfuge                             = Action.Create({ Type = "Spell", ID = 108208     }),
    ToxicBlade                             = Action.Create({ Type = "Spell", ID = 245388     }),
    VenomRush                              = Action.Create({ Type = "Spell", ID = 152152     }),
	Dismantle                              = Action.Create({ Type = "Spell", ID = 207777     }), -- PvP Talent
    -- Azerite Traits
    DoubleDose                             = Action.Create({ Type = "Spell", ID = 273007     }),
    EchoingBlades                          = Action.Create({ Type = "Spell", ID = 287649     }),
    ShroudedSuffocation                    = Action.Create({ Type = "Spell", ID = 278666     }),
    ScentOfBlood                           = Action.Create({ Type = "Spell", ID = 277679     }),
    RecklessForceCounter                   = Action.Create({ Type = "Spell", ID = 302917     }),
    ConcentratedFlameBurn                  = Action.Create({ Type = "Spell", ID = 295368     }),
    -- Defensive
    CrimsonVial                            = Action.Create({ Type = "Spell", ID = 185311     }),
    Feint                                  = Action.Create({ Type = "Spell", ID = 1966     }),
	CloakofShadow                          = Action.Create({ Type = "Spell", ID = 31224     }),
	Evade                                  = Action.Create({ Type = "Spell", ID = 5277     }),
    -- Utility
    Blind                                  = Action.Create({ Type = "Spell", ID = 2094     }),
    Kick                                   = Action.Create({ Type = "Spell", ID = 1766     }),
    Sprint                                 = Action.Create({ Type = "Spell", ID = 2983       }),
    CheapShot                              = Action.Create({ Type = "Spell", ID = 1833       }),
	ShadowStep                             = Action.Create({ Type = "Spell", ID = 36554       }),
	-- PvP
	Sap                                    = Action.Create({ Type = "Spell", ID = 6770       }),
	Shiv                                   = Action.Create({ Type = "Spell", ID = 248744       }),
	SmokeBomb                              = Action.Create({ Type = "Spell", ID = 212182       }),
	DFA                                    = Action.Create({ Type = "Spell", ID = 269513       }),
	Neuro                                  = Action.Create({ Type = "Spell", ID = 206328       }),    
	-- Poisons
    CripplingPoison                        = Action.Create({ Type = "Spell", ID = 3408     }),
    DeadlyPoison                           = Action.Create({ Type = "Spell", ID = 2823     }),
    WoundPoison                            = Action.Create({ Type = "Spell", ID = 8679     }),
    -- Misc
    TheDreadlordsDeceit                    = Action.Create({ Type = "Spell", ID = 208693     }),
    --PoolEnergy                             = Action.Create({ Type = "Spell", ID = 9999000010   }),
    Channeling                             = Action.Create({ Type = "Spell", ID = 209274, Hidden = true     }),	
    -- Buffs
    VigorTrinketBuff                       = Action.Create({ Type = "Spell", ID = 287916, Hidden = true     }),
    LifebloodBuff                          = Action.Create({ Type = "Spell", ID = 295137, Hidden = true     }),
    HiddenBladesBuff                       = Action.Create({ Type = "Spell", ID = 270070, Hidden = true     }),
    BlindsideBuff                          = Action.Create({ Type = "Spell", ID = 121153 , Hidden = true     }),
    VanishBuff                             = Action.Create({ Type = "Spell", ID = 11327 , Hidden = true     }),
    RecklessForceBuff                      = Action.Create({ Type = "Spell", ID = 302932 , Hidden = true     }),
    -- Debuffs 
    RazorCoralDebuff                       = Action.Create({ Type = "Spell", ID = 303568, Hidden = true     }),
    WoundPoisonDebuff                      = Action.Create({ Type = "Spell", ID = 8680, Hidden = true     }),
    DeadlyPoisonDebuff                     = Action.Create({ Type = "Spell", ID = 2818 , Hidden = true     }),
    BloodoftheEnemyDebuff                  = Action.Create({ Type = "Spell", ID = 297108 , Hidden = true     }),
    ToxicBladeDebuff                       = Action.Create({ Type = "Spell", ID = 245389, Hidden = true     }),
    -- Trinkets
	GenericTrinket1                      = Action.Create({ Type = "Trinket", ID = 114616, QueueForbidden = true }),
    GenericTrinket2                      = Action.Create({ Type = "Trinket", ID = 114081, QueueForbidden = true }),
    TrinketTest                          = Action.Create({ Type = "Trinket", ID = 122530, QueueForbidden = true }),
    TrinketTest2                         = Action.Create({ Type = "Trinket", ID = 159611, QueueForbidden = true }), 
    AzsharasFontofPower                  = Action.Create({ Type = "Trinket", ID = 169314, QueueForbidden = true }),
    PocketsizedComputationDevice         = Action.Create({ Type = "Trinket", ID = 167555 }),
    RotcrustedVoodooDoll                 = Action.Create({ Type = "Trinket", ID = 159624, QueueForbidden = true }),
    ShiverVenomRelic                     = Action.Create({ Type = "Trinket", ID = 168905, QueueForbidden = true }),
    AquipotentNautilus                   = Action.Create({ Type = "Trinket", ID = 169305, QueueForbidden = true }),
    TidestormCodex                       = Action.Create({ Type = "Trinket", ID = 165576, QueueForbidden = true }),
    VialofStorms                         = Action.Create({ Type = "Trinket", ID = 158224, QueueForbidden = true }),
	GalecallersBoon                      = Action.Create({ Type = "Trinket", ID = 159614, QueueForbidden = true }),
    InvocationOfYulon                    = Action.Create({ Type = "Trinket", ID = 165568, QueueForbidden = true }),
    LustrousGoldenPlumage                = Action.Create({ Type = "Trinket", ID = 159617, QueueForbidden = true }),
    ComputationDevice                    = Action.Create({ Type = "Trinket", ID = 167555, QueueForbidden = true }),
    VigorTrinket                         = Action.Create({ Type = "Trinket", ID = 165572, QueueForbidden = true }),
    FontOfPower                          = Action.Create({ Type = "Trinket", ID = 169314, QueueForbidden = true }),
    RazorCoral                           = Action.Create({ Type = "Trinket", ID = 169311, QueueForbidden = true }),
	AshvanesRazorCoral                   = Action.Create({ Type = "Trinket", ID = 169311, QueueForbidden = true }),
    -- Potions
    PotionofUnbridledFury                = Action.Create({ Type = "Potion", ID = 169299, QueueForbidden = true }),
    PotionTest                           = Action.Create({ Type = "Potion", ID = 142117, QueueForbidden = true }),
    -- Misc
    CyclotronicBlast                      = Action.Create({ Type = "Spell", ID = 293491, Hidden = true}),
	ConcentratedFlameBurn                 = Action.Create({ Type = "Spell", ID = 295368, Hidden = true}),
    BloodoftheEnemyDebuff                 = Action.Create({ Type = "Spell", ID = 297108, Hidden = true}),
    RecklessForceBuff                     = Action.Create({ Type = "Spell", ID = 302932, Hidden = true}),
    RecklessForceCounter                  = Action.Create({ Type = "Spell", ID = 298409}),
    RecklessForceCounter2                 = Action.Create({ Type = "Spell", ID = 302917}),
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
    LucidDreamsBuff                       = Action.Create({ Type = "HeartOfAzeroth", ID = 298357, Hidden = true}),
    LucidDreamsBuff2                      = Action.Create({ Type = "HeartOfAzeroth", ID = 299372, Hidden = true}),	
    LucidDreamsBuff3                      = Action.Create({ Type = "HeartOfAzeroth", ID = 299374, Hidden = true}),	
    -- Here come all the stuff needed by simcraft but not classic spells or items. 
}

-- To create essences use next code:
Action:CreateEssencesFor(ACTION_CONST_ROGUE_ASSASSINATION)        -- where PLAYERSPEC is Constance (example: ACTION_CONST_MONK_BM)

-- This code making shorter access to both tables Action[PLAYERSPEC] and Action
-- However if you prefer long access it still can be used like Action[PLAYERSPEC].Guard:IsReady() and not ShouldStop, it doesn't make any conflict if you will skip shorter access
-- So with shorter access you can just do A.Guard:IsReady() and not ShouldStop instead of Action[PLAYERSPEC].Guard:IsReady() and not ShouldStop
local A = setmetatable(Action[ACTION_CONST_ROGUE_ASSASSINATION], { __index = Action })

-- Simcraft Imported
-- HeroLib
local HL         = HeroLib
local Cache      = HeroCache
local Unit       = HL.Unit
local Player     = Unit.Player
local Target     = Unit.Target
local Pet        = Unit.Pet
local MouseOver  = Unit.MouseOver;
local Spell      = HL.Spell;
local Item       = HL.Item;
-- HeroRotation
local HR         = HeroRotation;
-- Lua
local mathmin = math.min;
-- Lua
local pairs = pairs;
local tableconcat = table.concat;
local tostring = tostring;

---------------------------
-- PORT TO ACTION 
local S, I = A:HeroCreate()
Action.HeroSetHookAllTable(S, {
        [3] = "TellMeWhen_Group4_Icon3",
        [4] = "TellMeWhen_Group4_Icon4",
		[6] = "TellMeWhen_Group4_Icon6",
        [7] = "TellMeWhen_Group4_Icon7",
        [8] = "TellMeWhen_Group4_Icon8",
})
Action.HeroSetHookAllTable(I, {
        [3] = "TellMeWhen_Group4_Icon3",
        [4] = "TellMeWhen_Group4_Icon4",
		[6] = "TellMeWhen_Group4_Icon6",
        [7] = "TellMeWhen_Group4_Icon7",
        [8] = "TellMeWhen_Group4_Icon8",
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
local BleedTickTime, ExsanguinatedBleedTickTime = 2 / Player:SpellHaste(), 1 / Player:SpellHaste();
local Stealth;
local RuptureThreshold, RuptureDMGThreshold, GarroteDMGThreshold;
local ComboPoints, ComboPointsDeficit, Energy_Regen_Combined, PoisonedBleeds;
local PriorityRotation;

local function num(val)
  if val then return 1 else return 0 end
end

-- Stuns
local Interrupts = {
  {S.Blind, "Cast Blind (Interrupt)", function () return true; end},
};

-----------------------------------------------------------------------------
----------------------------- EVENTS HANDLERS -------------------------------
  -- Arguments Variables
  local DestGUID, SpellID;

  -- TODO: Register/Unregister Events on SpecChange
  HL.BleedTable = {
    Assassination = {
      Garrote = {},
      Rupture = {}
    },
    Subtlety = {
      Nightblade = {},
    }
  };
  local BleedGUID;
  --- Exsanguinated Handler
    -- Exsanguinate Expression
    local BleedDuration, BleedExpires;
    function HL.Exsanguinated (Unit, SpellName)
      BleedGUID = Unit:GUID();
      if BleedGUID then
        if SpellName == "Garrote" then
          if HL.BleedTable.Assassination.Garrote[BleedGUID] then
              return HL.BleedTable.Assassination.Garrote[BleedGUID][3];
          end
        elseif SpellName == "Rupture" then
          if HL.BleedTable.Assassination.Rupture[BleedGUID] then
              return HL.BleedTable.Assassination.Rupture[BleedGUID][3];
          end
        end
      end
      return false;
    end
    -- Exsanguinate OnCast Listener
    HL:RegisterForSelfCombatEvent(
      function (...)
        DestGUID, _, _, _, SpellID = select(8, ...);

        -- Exsanguinate
        if SpellID == 200806 then
          for Key, _ in pairs(HL.BleedTable.Assassination) do
            for Key2, _ in pairs(HL.BleedTable.Assassination[Key]) do
              if Key2 == DestGUID then
                  -- Change the Exsanguinate info to true
                  HL.BleedTable.Assassination[Key][Key2][3] = true;
              end
            end
          end
        end
      end
      , "SPELL_CAST_SUCCESS"
    );
    -- Bleed infos
    local function GetBleedInfos (GUID, SpellID)
      -- Core API is not used since we don't want cached informations
      for i = 1, HL.MAXIMUM do
        local auraInfo = {UnitAura(GUID, i, "HARMFUL|PLAYER")};
        if auraInfo[10] == SpellID then
          return auraInfo[5];
        end
      end
      return nil
    end
    -- Bleed OnApply/OnRefresh Listener
    HL:RegisterForSelfCombatEvent(
      function (...)
        DestGUID, _, _, _, SpellID = select(8, ...);

        --- Record the Bleed Target and its Infos
        -- Garrote
        if SpellID == 703 then
          BleedDuration, BleedExpires = GetBleedInfos(DestGUID, SpellID);
          HL.BleedTable.Assassination.Garrote[DestGUID] = {BleedDuration, BleedExpires, false};
        -- Rupture
        elseif SpellID == 1943 then
          BleedDuration, BleedExpires = GetBleedInfos(DestGUID, SpellID);
          HL.BleedTable.Assassination.Rupture[DestGUID] = {BleedDuration, BleedExpires, false};
        end
      end
      , "SPELL_AURA_APPLIED"
      , "SPELL_AURA_REFRESH"
    );
    -- Bleed OnRemove Listener
    HL:RegisterForSelfCombatEvent(
      function (...)
        DestGUID, _, _, _, SpellID = select(8, ...);

        -- Removes the Unit from Garrote Table
        if SpellID == 703 then
          if HL.BleedTable.Assassination.Garrote[DestGUID] then
              HL.BleedTable.Assassination.Garrote[DestGUID] = nil;
          end
        -- Removes the Unit from Rupture Table
        elseif SpellID == 1943 then
          if HL.BleedTable.Assassination.Rupture[DestGUID] then
              HL.BleedTable.Assassination.Rupture[DestGUID] = nil;
          end
        end
      end
      , "SPELL_AURA_REMOVED"
    );
    -- Bleed OnUnitDeath Listener
    HL:RegisterForCombatEvent(
      function (...)
        DestGUID = select(8, ...);

        -- Removes the Unit from Garrote Table
        if HL.BleedTable.Assassination.Garrote[DestGUID] then
          HL.BleedTable.Assassination.Garrote[DestGUID] = nil;
        end
        -- Removes the Unit from Rupture Table
        if HL.BleedTable.Assassination.Rupture[DestGUID] then
          HL.BleedTable.Assassination.Rupture[DestGUID] = nil;
        end
      end
      , "UNIT_DIED"
      , "UNIT_DESTROYED"
    );

---------------------------------------------------

-- Master Assassin Remains Check
local MasterAssassinBuff, NominalDuration = Spell(256735), 3;
local function MasterAssassinRemains()
    if Player:BuffRemains(MasterAssassinBuff) < 0 then
        return Player:GCDRemains() + NominalDuration;
    else
        return Player:BuffRemainsP(MasterAssassinBuff);
    end
end

function Poisoned (Unit)
    return (Unit:Debuff(S.DeadlyPoisonDebuff) or Unit:Debuff(S.WoundPoisonDebuff)) and true or false;
end

function Bleeds ()
    return (Target:Debuff(S.Garrote) and 1 or 0) + (Target:Debuff(S.Rupture) and 1 or 0)
    + (Target:Debuff(S.CrimsonTempest) and 1 or 0) + (Target:Debuff(S.InternalBleeding) and 1 or 0);
end
  
local PoisonedBleedsCount = 0;
function PoisonedBleeds ()
    PoisonedBleedsCount = 0;
    for _, Unit in pairs(Cache.Enemies[50]) do
      if Poisoned(Unit) then
        -- TODO: For loop for this ? Not sure it's worth considering we would have to make 2 times spell object (Assa is init after Commons)
        if Unit:Debuff(S.Garrote) then
          PoisonedBleedsCount = PoisonedBleedsCount + 1;
        end
        if Unit:Debuff(S.InternalBleeding) then
          PoisonedBleedsCount = PoisonedBleedsCount + 1;
        end
        if Unit:Debuff(S.Rupture) then
          PoisonedBleedsCount = PoisonedBleedsCount + 1;
        end
      end
    end
    return PoisonedBleedsCount;
end
 ----------------------------------------------------

local function DetermineEssenceRanks()
    S.BloodoftheEnemy = S.BloodoftheEnemy2:IsAvailable() and S.BloodoftheEnemy2 or S.BloodoftheEnemy
    S.BloodoftheEnemy = S.BloodoftheEnemy3:IsAvailable() and S.BloodoftheEnemy3 or S.BloodoftheEnemy
    S.MemoryofLucidDreams = S.MemoryofLucidDreams2:IsAvailable() and S.MemoryofLucidDreams2 or S.MemoryofLucidDreams
    S.MemoryofLucidDreams = S.MemoryofLucidDreams3:IsAvailable() and S.MemoryofLucidDreams3 or S.MemoryofLucidDreams
    S.LucidDreamsBuff = S.LucidDreamsBuff2:IsAvailable() and S.LucidDreamsBuff2 or S.LucidDreamsBuff
    S.LucidDreamsBuff = S.LucidDreamsBuff3:IsAvailable() and S.LucidDreamsBuff3 or S.LucidDreamsBuff
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
	S.RecklessForceCounter = S.RecklessForceCounter2:IsAvailable() and S.RecklessForceCounter2 or S.RecklessForceCounter
end
--DetermineEssenceRanks = Action.MakeFunctionCachedStatic(DetermineEssenceRanks)
DetermineEssenceRanks = Action.MakeFunctionCachedDynamic(DetermineEssenceRanks)

-- HeroLib EnemiesCount handler
local EnemyRanges = {"Melee", 6, 8, 9}
local function UpdateRanges()
    for _, i in ipairs(EnemyRanges) do
        HL.GetEnemies(i);
    end
end

--- ======= SIMC CUSTOM FUNCTION / EXPRESSION =======
-- cp_max_spend
local function CPMaxSpend()
    -- Should work for all 3 specs since they have same Deeper Stratagem Spell ID.
    return S.DeeperStratagem:IsAvailable() and 6 or 5;
end

-- "cp_spend"
local function CPSpend()
    return mathmin(Player:ComboPoints(), CPMaxSpend());
end

-- Spells Damage
S.Envenom:RegisterDamage(
-- Envenom DMG Formula:
--    AP * CP * Env_APCoef * Aura_M * ToxicB_M * DS_M * Mastery_M * Versa_M
function ()
    return
        -- Attack Power
        Player:AttackPowerDamageMod() *
        -- Combo Points
        CPSpend() *
        -- Envenom AP Coef
        0.16 *
        -- Aura Multiplier (SpellID: 137037)
        1.27 *
        -- Toxic Blade Multiplier
        (Target:DebuffP(S.ToxicBladeDebuff) and 1.3 or 1) *
        -- Deeper Stratagem Multiplier
        (S.DeeperStratagem:IsAvailable() and 1.05 or 1) *
        -- Mastery Finisher Multiplier
        (1 + Player:MasteryPct()/100) *
        -- Versatility Damage Multiplier
        (1 + Player:VersatilityDmgPct()/100);
    end
);
S.Mutilate:RegisterDamage(
    function ()
        return
            -- Attack Power (MH Factor + OH Factor)
            (Player:AttackPowerDamageMod() + Player:AttackPowerDamageMod(true)) *
            -- Mutilate Coefficient
            0.35 *
            -- Aura Multiplier (SpellID: 137037)
            1.27 *
            -- Versatility Damage Multiplier
            (1 + Player:VersatilityDmgPct()/100);
    end
);
local function NighstalkerMultiplier ()
    return S.Nightstalker:IsAvailable() and Player:IsStealthed(true, false) and 1.5 or 1;
end
local function SubterfugeGarroteMultiplier ()
    return S.Subterfuge:IsAvailable() and Player:IsStealthed(true, false) and 2 or 1;
end
S.Garrote:RegisterPMultiplier(
    {NighstalkerMultiplier},
    {SubterfugeGarroteMultiplier}
);
S.Rupture:RegisterPMultiplier(
    {NighstalkerMultiplier}
);

-- Marked for Death Sniping
local BestUnit, BestUnitTTD;
local function MfDSniping (MarkedforDeath)
    if MarkedforDeath:IsCastable() then
    -- Get Units up to 30y for MfD.
    HL.GetEnemies(30);

    BestUnit, BestUnitTTD = nil, 60;
    local MOTTD = MouseOver:IsInRange(30) and MouseOver:TimeToDie() or 11111;
    local TTD;
    for _, Unit in pairs(Cache.Enemies[30]) do
        TTD = Unit:TimeToDie();
        -- Note: Increased the SimC condition by 50% since we are slower.
        if not Unit:IsMfdBlacklisted() and TTD < Player:ComboPointsDeficit()*1.5 and TTD < BestUnitTTD then
            if MOTTD - TTD > 1 then
                BestUnit, BestUnitTTD = Unit, TTD;
            else
                BestUnit, BestUnitTTD = MouseOver, MOTTD;
            end
        end
    end
    if BestUnit and BestUnit:GUID() ~= Target:GUID() then
        HR.CastLeftNameplate(BestUnit, MarkedforDeath);
        end
    end
end
-- Spell ID Changes check
  Stealth = S.Subterfuge:IsAvailable() and S.Stealth2 or S.Stealth; -- w/ or w/o Subterfuge Talent
-- Stealth
function Stealth(Stealth, Setting)
    if Action.GetToggle(2, "StealthOOC") and Stealth:IsCastable() and not Player:IsStealthed() then
        if HR.Cast(Stealth, Action.GetToggle(2, "GCDasOffGCD")) then return "Cast Stealth (OOC)"; end
    end
    return false;
end

-- Crimson Vial
function CrimsonVial(CrimsonVial)
    if CrimsonVial:IsCastable() and Player:HealthPercentage() <= Action.GetToggle(2, "CrimsonVialHP") then
        if HR.Cast(CrimsonVial, Action.GetToggle(2, "GCDasOffGCD")) then return "Cast Crimson Vial (Defensives)"; end
    end
    return false;
end

-- Feint
function Feint(Feint)
    if Feint:IsCastable() and not Player:Buff(Feint) and Player:HealthPercentage() <= Action.GetToggle(2, "FeintHP") then
        if HR.Cast(Feint, Action.GetToggle(2, "GCDasOffGCD")) then return "Cast Feint (Defensives)"; end
    end
end


    -- Defensives
    local function SelfDefensives(unit)
	    local HPLoosePerSecond = ActionUnit("player"):GetDMG() * 100 / ActionUnit("player"):HealthMax()
		
        if ActionUnit("player"):CombatTime() == 0 then 
            return 
        end 

        -- Emergency Evade
        local Evade = Action.GetToggle(2, "EvadeHP")
        if     Evade >= 0 and A.Evade:IsReady("player") and 
        (
            (   -- Auto 
                Evade >= 100 and 
                (
                    -- HP lose per sec >= 20
                    ActionUnit("player"):GetDMG() * 100 / ActionUnit("player"):HealthMax() >= 20 or 
                    ActionUnit("player"):GetRealTimeDMG() >= ActionUnit("player"):HealthMax() * 0.20 or 
                    -- TTD 
                    ActionUnit("player"):TimeToDieX(25) < 5 or 
                    (
                        A.IsInPvP and 
                        (
                            ActionUnit("player"):UseDeff() or 
                            (
                                ActionUnit("player", 5):HasFlags() and 
                                ActionUnit("player"):GetRealTimeDMG() > 0 and 
                                ActionUnit("player"):IsFocused() 
                            )
                        )
                    )
                ) and 
                ActionUnit("player"):HasBuffs("DeffBuffs", true) == 0
            ) or 
            (    -- Custom
                Evade < 100 and 
                ActionUnit("player"):HealthPercent() <= Evade
            )
        ) 
        then 
            if HR.Cast(S.Evade, Action.GetToggle(2, "GCDasOffGCD")) then return "Cast Evade (Defensives)"; end
        end  
		
        -- Emergency Feint
        local Feint = Action.GetToggle(2, "FeintHP")
        if     Feint >= 0 and A.Feint:IsReady("player") and 
        (
            (   -- Auto 
                Feint >= 100 and 
                (
                    -- HP lose per sec >= 20
                    ActionUnit("player"):GetDMG() * 100 / ActionUnit("player"):HealthMax() >= 20 or 
                    ActionUnit("player"):GetRealTimeDMG() >= ActionUnit("player"):HealthMax() * 0.20 or 
                    -- TTD 
                    ActionUnit("player"):TimeToDieX(25) < 5 or 
                    (
                        A.IsInPvP and 
                        (
                            ActionUnit("player"):UseDeff() or 
                            (
                                ActionUnit("player", 5):HasFlags() and 
                                ActionUnit("player"):GetRealTimeDMG() > 0 and 
                                ActionUnit("player"):IsFocused() 
                            )
                        )
                    )
                ) and 
                ActionUnit("player"):HasBuffs("DeffBuffs", true) == 0
            ) or 
            (    -- Custom
                Feint < 100 and 
                ActionUnit("player"):HealthPercent() <= Feint
            )
        ) 
        then 
            if HR.Cast(S.Feint, Action.GetToggle(2, "GCDasOffGCD")) then return "Cast Evade (Defensives)"; end
        end  		

        -- Emergency CrimsonVial
        local CrimsonVial = Action.GetToggle(2, "CrimsonVialHP")
        if     CrimsonVial >= 0 and A.CrimsonVial:IsReady("player") and 
        (
            (   -- Auto 
                CrimsonVial >= 100 and 
                (
                    -- HP lose per sec >= 20
                    ActionUnit("player"):GetDMG() * 100 / ActionUnit("player"):HealthMax() >= 20 or 
                    ActionUnit("player"):GetRealTimeDMG() >= ActionUnit("player"):HealthMax() * 0.20 or 
                    -- TTD 
                    ActionUnit("player"):TimeToDieX(25) < 5 or 
                    (
                        A.IsInPvP and 
                        (
                            ActionUnit("player"):UseDeff() or 
                            (
                                ActionUnit("player", 5):HasFlags() and 
                                ActionUnit("player"):GetRealTimeDMG() > 0 and 
                                ActionUnit("player"):IsFocused() 
                            )
                        )
                    )
                ) and 
                ActionUnit("player"):HasBuffs("DeffBuffs", true) == 0
            ) or 
            (    -- Custom
                CrimsonVial < 100 and 
                ActionUnit("player"):HealthPercent() <= CrimsonVial
            )
        ) 
        then 
            if HR.Cast(S.CrimsonVial, Action.GetToggle(2, "GCDasOffGCD")) then return "Cast Evade (Defensives)"; end
        end  		

        -- Emergency Cloak of Shadow
        local CloakofShadow = Action.GetToggle(2, "CloakofShadowHP")
        if     CloakofShadow >= 0 and A.CloakofShadow:IsReady("player") and 
        (
            (   -- Auto 
                CloakofShadow >= 100 and 
                (
                    -- HP lose per sec >= 20
                    ActionUnit("player"):GetDMG() * 100 / ActionUnit("player"):HealthMax() >= 20 or 
                    ActionUnit("player"):GetRealTimeDMG() >= ActionUnit("player"):HealthMax() * 0.20 or 
                    -- TTD 
                    ActionUnit("player"):TimeToDieX(25) < 5 or 
                    (
                        A.IsInPvP and 
                        (
                            ActionUnit("player"):UseDeff() or 
                            (
                                ActionUnit("player", 5):HasFlags() and 
                                ActionUnit("player"):GetRealTimeDMG() > 0 and 
                                ActionUnit("player"):IsFocused() 
                            )
                        )
                    )
                ) and 
                ActionUnit("player"):HasBuffs("DeffBuffs", true) == 0
            ) or 
            (    -- Custom
                CloakofShadow < 100 and 
                ActionUnit("player"):HealthPercent() <= CloakofShadow
            )
        ) 
        then 
            if HR.Cast(S.CloakofShadow, Action.GetToggle(2, "GCDasOffGCD")) then return "Cast Evade (Defensives)"; end
        end 
		
        -- Emergency Vanish
        local Vanish = Action.GetToggle(2, "VanishDefensive")
        if     Vanish >= 0 and A.Vanish:IsReady("player") and 
        (
            (   -- Auto 
                Vanish >= 100 and 
                (
                    -- HP lose per sec >= 20
                    ActionUnit("player"):GetDMG() * 100 / ActionUnit("player"):HealthMax() >= 20 or 
                    ActionUnit("player"):GetRealTimeDMG() >= ActionUnit("player"):HealthMax() * 0.20 or 
                    -- TTD 
                    ActionUnit("player"):TimeToDieX(25) < 5 or 
                    (
                        A.IsInPvP and 
                        (
                            ActionUnit("player"):UseDeff() or 
                            (
                                ActionUnit("player", 5):HasFlags() and 
                                ActionUnit("player"):GetRealTimeDMG() > 0 and 
                                ActionUnit("player"):IsFocused() 
                            )
                        )
                    )
                ) and 
                ActionUnit("player"):HasBuffs("DeffBuffs", true) == 0
            ) or 
            (    -- Custom
                Vanish < 100 and 
                ActionUnit("player"):HealthPercent() <= Vanish
            )
        ) 
        then 
            if HR.Cast(S.Vanish, Action.GetToggle(2, "GCDasOffGCD")) then return "Cast Evade (Defensives)"; end
        end  

    end 
    SelfDefensives = A.MakeFunctionCachedDynamic(SelfDefensives)

local function RefreshPoisons()
    local choice = Action.GetToggle(2, "PoisonToUse")
	
	if S.CripplingPoison:IsCastableP() and (Player:BuffRemainsP(S.CripplingPoison) <= 10 or not Player:BuffP(S.CripplingPoison)) and not Player:PrevGCDP(1, S.CripplingPoison) and not Player:IsCasting() then
	    if HR.Cast(S.CripplingPoison) then return "Refresh CripplingPoison"; end
	end	
	-- Wound Poison
	if choice == "Wound Poison" then 
	    if S.WoundPoison:IsCastableP() and (Player:BuffRemainsP(S.WoundPoison) <= 10 or not Player:BuffP(S.WoundPoison)) and not Player:PrevGCDP(1, S.WoundPoison) and not Player:IsCasting() then 
		    if HR.Cast(S.WoundPoison) then return "Refresh WoundPoison"; end
        end
	-- Deadly Poison
	elseif choice == "Deadly Poison" then
	    if S.DeadlyPoison:IsCastableP() and (Player:BuffRemainsP(S.DeadlyPoison) <= 10 or not Player:BuffP(S.DeadlyPoison)) and not Player:PrevGCDP(1, S.DeadlyPoison) and not Player:IsCasting() then 
		    if HR.Cast(S.DeadlyPoison) then return "Refresh DeadlyPoison"; end
        end
	elseif choice == "Auto" then
	    -- Auto
	    if Action.IsInPvP and S.WoundPoison:IsCastableP() and (Player:BuffRemainsP(S.WoundPoison) <= 10 or not Player:BuffP(S.WoundPoison)) and not Player:PrevGCDP(1, S.WoundPoison) and not Player:IsCasting() then 		
	        if HR.Cast(S.WoundPoison) then return "Refresh WoundPoison"; end
		else
		    if S.DeadlyPoison:IsCastableP() and (Player:BuffRemainsP(S.DeadlyPoison) <= 10 or not Player:BuffP(S.DeadlyPoison)) and not Action.IsInPvP and not Player:PrevGCDP(1, S.DeadlyPoison) and not Player:IsCasting() then
		        if HR.Cast(S.DeadlyPoison) then return "Refresh DeadlyPoison"; end
		    end
	    end
	else
	    return
	end	
end
	
-- Check if the Priority Rotation variable should be set
local function UsePriorityRotation()
    if Cache.EnemiesCount[10] < 2 then
        return false
    end
    if Action.GetToggle(2, "UsePriorityRotation") == "Always" then
        return true
    end
    if Action.GetToggle(2, "UsePriorityRotation") == "On Bosses" and Target:IsInBossList() then
        return true
    end
    -- Zul Mythic
    if Player:InstanceDifficulty() == 16 and Target:NPCID() == 138967 then
        return true
    end
    return false
end

-- Handle CastLeftNameplate Suggestions for DoT Spells
local function SuggestCycleDoT(DoTSpell, DoTEvaluation, DoTMinTTD)
    -- Prefer melee cycle units
    local BestUnit, BestUnitTTD = nil, DoTMinTTD;
    local TargetGUID = Target:GUID();
    for _, CycleUnit in pairs(Cache.Enemies["Melee"]) do
        if CycleUnit:GUID() ~= TargetGUID and Everyone.UnitIsCycleValid(CycleUnit, BestUnitTTD, -CycleUnit:DebuffRemainsP(DoTSpell))
        and DoTEvaluation(CycleUnit) then
            BestUnit, BestUnitTTD = CycleUnit, CycleUnit:TimeToDie();
        end
    end
    if BestUnit then
        HR.CastLeftNameplate(BestUnit, DoTSpell);
    -- Check ranged units next, if the RangedMultiDoT option is enabled
    elseif Action.GetToggle(2, "MultiDoT") then
        BestUnit, BestUnitTTD = nil, DoTMinTTD;
        for _, CycleUnit in pairs(Cache.Enemies[10]) do
            if CycleUnit:GUID() ~= TargetGUID and Everyone.UnitIsCycleValid(CycleUnit, BestUnitTTD, -CycleUnit:DebuffRemainsP(DoTSpell))
            and DoTEvaluation(CycleUnit) then
                BestUnit, BestUnitTTD = CycleUnit, CycleUnit:TimeToDie();
            end
        end
        if BestUnit then
            HR.CastLeftNameplate(BestUnit, DoTSpell);
        end
    end
end
SuggestCycleDoT = Action.MakeFunctionCachedDynamic(SuggestCycleDoT)

-- Target If handler
-- Mode is "min", "max", or "first"
-- ModeEval the target_if condition (function with a target as param)
-- IfEval the condition on the resulting target (function with a target as param)
local function CheckTargetIfTarget(Mode, ModeEvaluation, IfEvaluation)
    -- First mode: Only check target if necessary
    local TargetsModeValue = ModeEvaluation(Target);
    if Mode == "first" and TargetsModeValue ~= 0 then
        return Target;
    end

    local BestUnit, BestValue = nil, 0;
    local function RunTargetIfCycler(Range)
        for _, CycleUnit in pairs(Cache.Enemies[Range]) do
            local ValueForUnit = ModeEvaluation(CycleUnit);
            if not BestUnit and Mode == "first" then
                if ValueForUnit ~= 0 then
                    BestUnit, BestValue = CycleUnit, ValueForUnit;
                end
            elseif Mode == "min" then
                if not BestUnit or ValueForUnit < BestValue then
                    BestUnit, BestValue = CycleUnit, ValueForUnit;
                end
            elseif Mode == "max" then
                if not BestUnit or ValueForUnit > BestValue then
                    BestUnit, BestValue = CycleUnit, ValueForUnit;
                end
            end
            -- Same mode value, prefer longer TTD
            if BestUnit and ValueForUnit == BestValue and CycleUnit:TimeToDie() > BestUnit:TimeToDie() then
                BestUnit, BestValue = CycleUnit, ValueForUnit;
            end
        end
    end

    -- Prefer melee cycle units over ranged
    RunTargetIfCycler("Melee");
    if Action.GetToggle(2, "RangedMultiDoT") then
        RunTargetIfCycler(10);
    end
    -- Prefer current target if equal mode value results to prevent "flickering"
    if BestUnit and BestValue == TargetsModeValue and IfEvaluation(Target) then
        return Target;
    end
    if BestUnit and IfEvaluation(BestUnit) then
        return BestUnit;
    end
    return nil
end
CheckTargetIfTarget = Action.MakeFunctionCachedDynamic(CheckTargetIfTarget)

-- Master Assassin Remains Check
local MasterAssassinBuff, NominalDuration = Spell(256735), 3;
local function MasterAssassinRemains ()
    if Player:BuffRemains(MasterAssassinBuff) < 0 then
        return Player:GCDRemains() + NominalDuration;
    else
        return Player:BuffRemainsP(MasterAssassinBuff);
    end
end

-- Fake ss_buffed (wonky without Subterfuge but why would you, eh?)
local function SSBuffed(Target)
    return S.ShroudedSuffocation:AzeriteEnabled() and Target:PMultiplier(S.Garrote) > 1;
end

-- non_ss_buffed_targets
local function NonSSBuffedTargets()
    local count = 0;
    for _, CycleUnit in pairs(Cache.Enemies[10]) do
        if not CycleUnit:DebuffP(S.Garrote) or not SSBuffed(CycleUnit) then
            count = count + 1;
        end
    end
    return count;
end

-- ss_buffed_targets_above_pandemic
local function SSBuffedTargetsAbovePandemic()
    local count = 0;
    for _, CycleUnit in pairs(Cache.Enemies[10]) do
        if CycleUnit:DebuffRemainsP(S.Garrote) > 5.4 and SSBuffed(CycleUnit) then
            count = count + 1;
        end
    end
    return count;
end

local MythicDungeon;
do
    local SappedSoulSpells = {
        {S.Kick, "Cast Kick (Sapped Soul)", function () return Target:IsInRange("Melee"); end},
        {S.Feint, "Cast Feint (Sapped Soul)", function () return true; end},
        {S.CrimsonVial, "Cast Crimson Vial (Sapped Soul)", function () return true; end}
    };
    MythicDungeon = function ()
        -- Sapped Soul
        if HL.MythicDungeon() == "Sapped Soul" then
            for i = 1, #SappedSoulSpells do
                local SappedSoulSpell = SappedSoulSpells[i];
                if SappedSoulSpell[1]:IsCastable() and SappedSoulSpell[3]() then
                    HR.ChangePulseTimer(1);
                    HR.Cast(SappedSoulSpell[1]);
                    return SappedSoulSpell[2];
                end
            end
        end
        return false;
    end
end
local function TrainingScenario ()
    if Target:CastName() == "Unstable Explosion" and Target:CastPercentage() > 60-10*ComboPoints then
        -- Kidney Shot
        if S.KidneyShot:IsCastable("Melee") and ComboPoints > 0 then
            if HR.Cast(S.KidneyShot) then return "Cast Kidney Shot (Unstable Explosion)"; end
        end
    end
    return false;
end
local Interrupts = {
    {S.Blind, "Cast Blind (Interrupt)", function () return true; end},
    {S.KidneyShot, "Cast Kidney Shot (Interrupt)", function () return ComboPoints > 0; end}
}

-- APL Action Lists (and Variables)
-- # Essences
local function Essences ()
    -- actions.essences+=/blood_of_the_enemy,if=debuff.vendetta.up&(!talent.toxic_blade.enabled|debuff.toxic_blade.up&combo_points.deficit<=1|debuff.vendetta.remains<=10)|target.time_to_die<=10
    if S.BloodoftheEnemy:IsCastableP() and Action.GetToggle(1, "HeartOfAzeroth") and not ShouldStop and Target:DebuffP(S.Vendetta) and (not S.ToxicBlade:IsAvailable()
        or (Target:DebuffP(S.ToxicBladeDebuff) and Player:ComboPointsDeficit() <= 1) or Target:DebuffRemainsP(S.Vendetta) <= 10) then
        if HR.Cast(S.BloodoftheEnemy) then return "Cast BloodoftheEnemy"; end
    end
    -- concentrated_flame,if=energy.time_to_max>1&!debuff.vendetta.up&(!dot.concentrated_flame_burn.ticking&!action.concentrated_flame.in_flight|full_recharge_time<gcd.max)
    if S.ConcentratedFlame:IsCastableP() and Action.GetToggle(1, "HeartOfAzeroth") and not ShouldStop and Player:EnergyTimeToMaxPredicted() > 1 and not Target:DebuffP(S.Vendetta) and (not Target:DebuffP(S.ConcentratedFlameBurn)
        and not Player:PrevGCD(1, S.ConcentratedFlame) or S.ConcentratedFlame:FullRechargeTime() < Player:GCD() + Player:GCDRemains()) then
        if HR.Cast(S.ConcentratedFlame) then return "Cast ConcentratedFlame"; end
    end
    if S.GuardianofAzeroth:IsCastableP() and Action.GetToggle(1, "HeartOfAzeroth") and not ShouldStop then
        -- guardian_of_azeroth,if=cooldown.vendetta.remains<3|debuff.vendetta.up|target.time_to_die<30
        if S.Vendetta:CooldownRemainsP() < 3 or Target:DebuffP(S.Vendetta) or Target:BossFilteredTimeToDie("<", 30) then
            if HR.Cast(S.GuardianofAzeroth) then return "Cast GuardianofAzeroth Synced"; end
        elseif not Target:BossTimeToDieIsNotValid() then
            -- guardian_of_azeroth,if=floor((target.time_to_die-30)%cooldown)>floor((target.time_to_die-30-cooldown.vendetta.remains)%cooldown)
            if mathfloor(Target:BossTimeToDie() - 30 / 180) > mathfloor((Target:BossTimeToDie() - 30 - S.Vendetta:CooldownRemainsP()) / 180) then
                if HR.Cast(S.GuardianofAzeroth) then return "Cast GuardianofAzeroth Desynced"; end
            end
        end
    end
    -- focused_azerite_beam,if=spell_targets.fan_of_knives>=2|raid_event.adds.in>60&energy<70
    if S.FocusedAzeriteBeam:IsCastableP() and (Cache.EnemiesCount[10] >= 4 or ActionUnit("target"):IsBoss()) and Action.GetToggle(1, "HeartOfAzeroth") and not ShouldStop and Player:EnergyPredicted() < 70 then
        if HR.Cast(S.FocusedAzeriteBeam) then return "Cast FocusedAzeriteBeam"; end
    end
    -- purifying_blast,if=spell_targets.fan_of_knives>=2|raid_event.adds.in>60
    if S.PurifyingBlast:IsCastableP() and Action.GetToggle(1, "HeartOfAzeroth") and not ShouldStop then
        if HR.Cast(S.PurifyingBlast) then return "Cast PurifyingBlast"; end
    end
    -- actions.essences+=/the_unbound_force,if=buff.reckless_force.up|buff.reckless_force_counter.stack<10
    if S.TheUnboundForce:IsCastableP() and Action.GetToggle(1, "HeartOfAzeroth") and not ShouldStop and (Player:BuffP(S.RecklessForceBuff) or Player:BuffStackP(S.RecklessForceCounter) < 10) then
        if HR.Cast(S.TheUnboundForce) then return "Cast TheUnboundForce"; end
    end
    -- ripple_in_space
    if S.RippleInSpace:IsCastableP() and Action.GetToggle(1, "HeartOfAzeroth") and not ShouldStop then
        if HR.Cast(S.RippleInSpace) then return "Cast RippleInSpace"; end
    end
    -- worldvein_resonance,if=buff.lifeblood.stack<3
    if S.WorldveinResonance:IsCastableP() and Action.GetToggle(1, "HeartOfAzeroth") and not ShouldStop and Player:BuffStackP(S.LifebloodBuff) < 3 then
        if HR.Cast(S.WorldveinResonance) then return "Cast WorldveinResonance"; end
    end
    -- memory_of_lucid_dreams,if=energy<50&!cooldown.vendetta.up
    if S.MemoryofLucidDreams:IsCastableP() and Action.GetToggle(1, "HeartOfAzeroth") and not ShouldStop and Player:EnergyPredicted() < 50 and not S.Vendetta:CooldownUpP() then
        if HR.Cast(S.MemoryofLucidDreams) then return "Cast MemoryofLucidDreams"; end
    end
    return false;
end
Essences = Action.MakeFunctionCachedStatic(Essences)

-- # Cooldowns
local function CDs ()
    if Target:IsInRange("Melee") then
        -- actions.cds+=/call_action_list,name=essences,if=!stealthed.all&dot.rupture.ticking&master_assassin_remains=0
        if HR.CDsON() and not Player:IsStealthedP(true, true) and Target:DebuffP(S.Rupture) and MasterAssassinRemains() <= 0 then
            ShouldReturn = Essences();
            if ShouldReturn then return ShouldReturn; end
        end

        -- actions.cds+=/marked_for_death,target_if=min:target.time_to_die,if=target.time_to_die<combo_points.deficit*1.5|(raid_event.adds.in>40&combo_points.deficit>=cp_max_spend)
        if S.MarkedforDeath:IsCastable() then
            if Target:FilteredTimeToDie("<", Player:ComboPointsDeficit() * 1.5) then
                if HR.Cast(S.MarkedforDeath, Action.GetToggle(2, "GCDasOffGCD")) then return "Cast Marked for Death"; end
            end
            if ComboPointsDeficit >= CPMaxSpend() then
                HR.Cast(S.MarkedforDeath);
            end
        end

        if HR.CDsON() then
            -- actions.cds+=/vendetta,if=!stealthed.rogue&dot.rupture.ticking&!debuff.vendetta.up&(!talent.subterfuge.enabled|!azerite.shrouded_suffocation.enabled|dot.garrote.pmultiplier>1&(spell_targets.fan_of_knives<6|!cooldown.vanish.up))&(!talent.nightstalker.enabled|!talent.exsanguinate.enabled|cooldown.exsanguinate.remains<5-2*talent.deeper_stratagem.enabled)&(!equipped.azsharas_font_of_power|azerite.shrouded_suffocation.enabled|debuff.razor_coral_debuff.down|trinket.ashvanes_razor_coral.cooldown.remains<10&cooldown.toxic_blade.remains<1)
            if S.Vendetta:IsCastable() and not Player:IsStealthedP(true, false) and Target:DebuffP(S.Rupture) and not Target:DebuffP(S.Vendetta)
                and (not S.Subterfuge:IsAvailable() or not S.ShroudedSuffocation:AzeriteEnabled() or Target:PMultiplier(S.Garrote) > 1 and (Cache.EnemiesCount[10] < 6 or not S.Vanish:CooldownUpP()))
                and (not S.Nightstalker:IsAvailable() or not S.Exsanguinate:IsAvailable() or S.Exsanguinate:CooldownRemainsP() < 5 - 2 * num(S.DeeperStratagem:IsAvailable()))
                and (not TR.TrinketON() or not I.FontOfPower:IsEquipped() or S.ShroudedSuffocation:AzeriteEnabled() or S.RazorCoralDebuff:ActiveCount() == 0 or I.RazorCoral:CooldownRemains() < 10 and S.ToxicBlade:CooldownRemainsP() <= 1) then
                if HR.Cast(S.Vendetta, Action.GetToggle(2, "GCDasOffGCD")) then return "Cast Vendetta"; end
            end
            if S.Vanish:IsCastable() and not Player:IsTanking(Target) and Target:DebuffRemainsP(S.Rupture) > 3 then
                local VanishSuggested = false;
                -- actions.cds+=/vanish,if=talent.exsanguinate.enabled&(talent.nightstalker.enabled|talent.subterfuge.enabled&spell_targets.fan_of_knives<2)&combo_points>=cp_max_spend&cooldown.exsanguinate.remains<1&(!talent.subterfuge.enabled|!azerite.shrouded_suffocation.enabled|dot.garrote.pmultiplier<=1)
                if not VanishSuggested and S.Exsanguinate:IsAvailable() and (S.Nightstalker:IsAvailable() or S.Subterfuge:IsAvailable() and Cache.EnemiesCount[10] < 2)
                    and ComboPoints >= CPMaxSpend() and S.Exsanguinate:CooldownRemainsP() < 1
                    and (not S.Subterfuge:IsAvailable() or not S.ShroudedSuffocation:AzeriteEnabled() or Target:PMultiplier(S.Garrote) <= 1) then
                    if HR.Cast(S.Vanish, Action.GetToggle(2, "GCDasOffGCD")) then return "Cast Vanish (Exsanguinate)"; end
                    VanishSuggested = true;
                end
                -- actions.cds+=/vanish,if=talent.nightstalker.enabled&!talent.exsanguinate.enabled&combo_points>=cp_max_spend&debuff.vendetta.up
                if not VanishSuggested and S.Nightstalker:IsAvailable() and not S.Exsanguinate:IsAvailable() and ComboPoints >= CPMaxSpend() and Target:Debuff(S.Vendetta) then
                    if HR.Cast(S.Vanish, Action.GetToggle(2, "GCDasOffGCD")) then return "Cast Vanish (Nightstalker)"; end
                    VanishSuggested = true;
                end
                -- actions.cds+=/variable,name=ss_vanish_condition,value=azerite.shrouded_suffocation.enabled&(non_ss_buffed_targets>=1|spell_targets.fan_of_knives=3)&(ss_buffed_targets_above_pandemic=0|spell_targets.fan_of_knives>=6)
                local VarSSVanishCondition = S.ShroudedSuffocation:AzeriteEnabled() and (NonSSBuffedTargets() >= 1 or Cache.EnemiesCount[10] == 3)
                    and (SSBuffedTargetsAbovePandemic() == 0 or Cache.EnemiesCount[10] >= 6);
                -- actions.cds+=/vanish,if=talent.subterfuge.enabled&!stealthed.rogue&cooldown.garrote.up&(variable.ss_vanish_condition|!azerite.shrouded_suffocation.enabled&dot.garrote.refreshable)&combo_points.deficit>=((1+2*azerite.shrouded_suffocation.enabled)*spell_targets.fan_of_knives)>?4&raid_event.adds.in>12
                if not VanishSuggested and S.Subterfuge:IsAvailable() and not Player:IsStealthedP(true, false)
                    and S.Garrote:CooldownUpP() and (VarSSVanishCondition or not S.ShroudedSuffocation:AzeriteEnabled() and Target:DebuffRefreshableP(S.Garrote, 5.4))
                    and ComboPointsDeficit >= math.min((1 + 2 * num(S.ShroudedSuffocation:AzeriteEnabled())) * Cache.EnemiesCount[10], 4) then
                    -- actions.cds+=/pool_resource,for_next=1,extra_amount=45
                    if Player:EnergyPredicted() < 45 then
                        if HR.Cast(S.Channeling) then return "Pool for Vanish (Subterfuge)"; end
                    end
                    if HR.Cast(S.Vanish, Action.GetToggle(2, "GCDasOffGCD")) then return "Cast Vanish (Subterfuge)"; end
                    VanishSuggested = true;
                end
                -- actions.cds+=/vanish,if=talent.master_assassin.enabled&!stealthed.all&master_assassin_remains<=0&!dot.rupture.refreshable&dot.garrote.remains>3&debuff.vendetta.up&(!talent.toxic_blade.enabled|debuff.toxic_blade.up)&(!essence.blood_of_the_enemy.major|debuff.blood_of_the_enemy.up)
                if not VanishSuggested and S.MasterAssassin:IsAvailable() and not Player:IsStealthedP(true, false) and MasterAssassinRemains() <= 0
                    and not Target:DebuffRefreshableP(S.Rupture, RuptureThreshold) and Target:DebuffRemainsP(S.Garrote) > 3
                    and Target:DebuffP(S.Vendetta) and (not S.ToxicBlade:IsAvailable() or Target:DebuffP(S.ToxicBladeDebuff))
                    and (not S.BloodoftheEnemy:IsAvailable() or Target:DebuffP(S.BloodoftheEnemyDebuff)) then
                    if HR.Cast(S.Vanish, Action.GetToggle(2, "GCDasOffGCD")) then return "Cast Vanish (Master Assassin)"; end
                end
            end
            -- actions.cds+=/shadowmeld,if=!stealthed.all&azerite.shrouded_suffocation.enabled&dot.garrote.refreshable&dot.garrote.pmultiplier<=1&combo_points.deficit>=1
            if HR.CDsON() and S.Shadowmeld:IsCastable() and not Player:IsStealthedP(true, true) and S.ShroudedSuffocation:AzeriteEnabled() and Target:DebuffRefreshableP(S.Garrote, 5.4) and Target:PMultiplier(S.Garrote) <= 1 and Player:ComboPointsDeficit() >= 1 then
                if HR.Cast(S.Shadowmeld, Action.GetToggle(2, "GCDasOffGCD")) then return "Cast Shadowmeld"; end
            end
            if S.Exsanguinate:IsCastable() then
                -- actions.cds+=/exsanguinate,if=dot.rupture.remains>4+4*cp_max_spend&!dot.garrote.refreshable
                if Target:DebuffRemainsP(S.Rupture) > 4+4*CPMaxSpend() and not Target:DebuffRefreshableP(S.Garrote, 5.4) then
                    if HR.Cast(S.Exsanguinate) then return "Cast Exsanguinate"; end
                end
            end
            -- actions.cds+=/toxic_blade,if=dot.rupture.ticking
            if S.ToxicBlade:IsCastable("Melee") and Target:DebuffP(S.Rupture) and Player:ComboPoints() < Player:ComboPointsMax() then
                if HR.Cast(S.ToxicBlade) then return "Cast Toxic Blade"; end
            end
        end

        -- actions.cds=potion,if=buff.bloodlust.react|target.time_to_die<=60|debuff.vendetta.up&cooldown.vanish.remains<5

        -- Trinkets
        if TR.TrinketON() then
            -- use_item,name=galecallers_boon,if=cooldown.vendetta.remains>45
            if I.GalecallersBoon:IsEquipped() and I.GalecallersBoon:IsReady() and not ShouldStop and S.Vendetta:CooldownRemains() > 45 then
                if HR.Cast(I.GalecallersBoon) then return "Cast Galecallers Boon"; end
            end
            -- use_item,name=lustrous_golden_plumage,if=debuff.vendetta.up
            if I.LustrousGoldenPlumage:IsEquipped() and I.LustrousGoldenPlumage:IsReady() and not ShouldStop and Target:Debuff(S.Vendetta) then
                if HR.Cast(I.LustrousGoldenPlumage) then return "Cast Golden Plumage"; end
            end
            if I.InvocationOfYulon:IsEquipped() and I.InvocationOfYulon:IsReady() and not ShouldStop then
                if HR.Cast(I.InvocationOfYulon) then return "Cast Invocation of Yulon"; end
            end
            -- if=master_assassin_remains=0&!debuff.vendetta.up&!debuff.toxic_blade.up&buff.memory_of_lucid_dreams.down&energy<80&dot.rupture.remains>4
            if I.ComputationDevice:IsEquipped() and I.ComputationDevice:IsReady() and not ShouldStop and MasterAssassinRemains() <= 0 and not Target:DebuffP(S.Vendetta)
                and not Target:DebuffP(S.ToxicBladeDebuff) and not Player:BuffP(S.LucidDreamsBuff) and Player:EnergyPredicted() < 80 and Target:DebuffRemainsP(S.Rupture) > 4 then
                if HR.Cast(I.ComputationDevice) then return "Cast Computation Device"; end
            end
            -- if=debuff.razor_coral_debuff.down|debuff.vendetta.remains>10-4*equipped.azsharas_font_of_power|target.time_to_die<20
            if I.RazorCoral:IsEquipped() and I.RazorCoral:IsReady() and not ShouldStop and (S.RazorCoralDebuff:ActiveCount() == 0
                or Target:DebuffRemainsP(S.Vendetta) > 10 - 4 * num(I.FontOfPower:IsEquipped()) or Target:FilteredTimeToDie("<", 20)) then
                if HR.Cast(I.RazorCoral) then return "Cast Razor Coral"; end
            end
            -- V.I.G.O.R. trinket, emulate SimC default behavior to use at max stacks
            if I.VigorTrinket:IsEquipped() and I.VigorTrinket:IsReady() and not ShouldStop and Player:BuffStack(S.VigorTrinketBuff) == 6 then
                if HR.Cast(I.VigorTrinket) then return "Cast Vigor Trinket"; end
            end
        end

        -- Racials
        if HR.CDsON() and Target:Debuff(S.Vendetta) then
            -- actions.cds+=/blood_fury,if=debuff.vendetta.up
            if S.BloodFury:IsCastable() then
                if HR.Cast(S.BloodFury, Action.GetToggle(2, "GCDasOffGCD")) then return "Cast Blood Fury"; end
            end
            -- actions.cds+=/berserking,if=debuff.vendetta.up
            if S.Berserking:IsCastable() then
                if HR.Cast(S.Berserking, Action.GetToggle(2, "GCDasOffGCD")) then return "Cast Berserking"; end
            end
            -- actions.cds+=/fireblood,if=debuff.vendetta.up
            if S.Fireblood:IsCastable() then
                if HR.Cast(S.Fireblood, Action.GetToggle(2, "GCDasOffGCD")) then return "Cast Fireblood"; end
            end
            -- actions.cds+=/ancestral_call,if=debuff.vendetta.up
            if S.AncestralCall:IsCastable() then
                if HR.Cast(S.AncestralCall, Action.GetToggle(2, "GCDasOffGCD")) then return "Cast Ancestral Call"; end
            end
        end
    end
    return false;
end
CDs = Action.MakeFunctionCachedDynamic(CDs)

-- # Stealthed
local function Stealthed ()
    -- actions.stealthed=rupture,if=combo_points>=4&(talent.nightstalker.enabled|talent.subterfuge.enabled&(talent.exsanguinate.enabled&cooldown.exsanguinate.remains<=2|!ticking)&variable.single_target)&target.time_to_die-remains>6
    if S.Rupture:IsCastable("Melee") and ComboPoints >= 4
        and (S.Nightstalker:IsAvailable() or (S.Subterfuge:IsAvailable() and (S.Exsanguinate:IsAvailable() and S.Exsanguinate:CooldownRemainsP() <= 2 or not Target:DebuffP(S.Rupture)) and Cache.EnemiesCount[10] < 2))
        and (Target:FilteredTimeToDie(">", 6, -Target:DebuffRemainsP(S.Rupture)) or Target:TimeToDieIsNotValid()) then
        if HR.Cast(S.Rupture) then return "Cast Rupture (Exsanguinate)"; end
    end    
	-- actions.stealthed+=/envenom,if=combo_points>=cp_max_spend
	if S.Envenom:IsReady("Melee") and ComboPoints >= CPMaxSpend() then
		if HR.Cast(S.Envenom) then return "Cast Envenom"; end
	end
    if S.Garrote:IsCastable("Melee") and S.Subterfuge:IsAvailable() then
        -- actions.stealthed+=/garrote,if=azerite.shrouded_suffocation.enabled&buff.subterfuge.up&buff.subterfuge.remains<1.3&!ss_buffed
        -- Not implemented because this is special for simc and we can have a shifting main target in reality where simc checks only a fix target on all normal abilities.
        -- actions.stealthed+=/garrote,target_if=min:remains,if=talent.subterfuge.enabled&(remains<12|pmultiplier<=1)&target.time_to_die-remains>2
        local function GarroteTargetIfFunc(Target)
            return Target:DebuffRemainsP(S.Garrote);
        end
        local function GarroteIfFunc(Target)
            return (Target:DebuffRemainsP(S.Garrote) < 12 or Target:PMultiplier(S.Garrote) <= 1)
                and (Target:FilteredTimeToDie(">", 2, -Target:DebuffRemainsP(S.Garrote)) or Target:TimeToDieIsNotValid())
                and Everyone.CanDoTUnit(Target, GarroteDMGThreshold);
        end
        if HR.AoEON() then
            local TargetIfUnit = CheckTargetIfTarget("min", GarroteTargetIfFunc, GarroteIfFunc);
            if TargetIfUnit and TargetIfUnit:GUID() ~= Target:GUID() then
                HR.CastLeftNameplate(TargetIfUnit, S.Garrote);
            end
        end
        if GarroteIfFunc(Target) then
            if HR.Cast(S.Garrote) then return "Cast Garrote (Subterfuge)"; end
        end
    end
    -- actions.stealthed+=/rupture,if=talent.subterfuge.enabled&azerite.shrouded_suffocation.enabled&!dot.rupture.ticking&variable.single_target
    if S.Rupture:IsCastable("Melee") and S.Subterfuge:IsAvailable() and ComboPoints > 0 and S.ShroudedSuffocation:AzeriteEnabled()
        and not Target:DebuffP(S.Rupture) and Cache.EnemiesCount[10] < 2 then
        if HR.Cast(S.Rupture) then return "Cast Rupture (Shrouded Suffocation)"; end
    end
    if S.Garrote:IsCastable("Melee") and S.Subterfuge:IsAvailable() then
        -- actions.stealthed+=/garrote,target_if=min:remains,if=talent.subterfuge.enabled&azerite.shrouded_suffocation.enabled&target.time_to_die>remains&(remains<18|!ss_buffed)
        local function GarroteTargetIfFunc(Target)
            return Target:DebuffRemainsP(S.Garrote);
        end
        local function GarroteIfFunc(Target)
            return S.ShroudedSuffocation:AzeriteEnabled()
                and (Target:FilteredTimeToDie(">", 0, -Target:DebuffRemainsP(S.Garrote)) or Target:TimeToDieIsNotValid())
                and (Target:DebuffRemainsP(S.Garrote) < 18 or not SSBuffed(Target))
                and Everyone.CanDoTUnit(Target, GarroteDMGThreshold);
        end
        if HR.AoEON() then
            local TargetIfUnit = CheckTargetIfTarget("min", GarroteTargetIfFunc, GarroteIfFunc);
            if TargetIfUnit and TargetIfUnit:GUID() ~= Target:GUID() then
                HR.CastLeftNameplate(TargetIfUnit, S.Garrote);
            end
        end
        if GarroteIfFunc(Target) then
            if HR.Cast(S.Garrote) then return "Cast Garrote (Shrouded Suffocation)"; end
        end
        -- actions.stealthed+=/garrote,if=talent.subterfuge.enabled&talent.exsanguinate.enabled&cooldown.exsanguinate.remains<1&prev_gcd.1.rupture&dot.rupture.remains>5+4*cp_max_spend
        if S.Exsanguinate:IsAvailable() and S.Exsanguinate:CooldownRemainsP() < 1 and Player:PrevGCD(1, S.Rupture) and Target:DebuffRemainsP(S.Rupture) > 5+4*CPMaxSpend() then
            -- actions.stealthed+=/pool_resource,for_next=1
            if Player:EnergyPredicted() < 45 then
                if HR.Cast(S.Channeling) then return "Pool for Garrote (Exsanguinate)"; end
            end
            if HR.Cast(S.Garrote) then return "Cast Garrote (Exsanguinate)"; end
        end
    end
end
Stealthed = Action.MakeFunctionCachedDynamic(Stealthed)

-- # Damage over time abilities
local function Dot ()
    local SkipCycleGarrote, SkipCycleRupture, SkipRupture
    if PriorityRotation and Cache.EnemiesCount[10] > 3 then
        -- actions.dot=variable,name=skip_cycle_garrote,value=priority_rotation&spell_targets.fan_of_knives>3&(dot.garrote.remains<cooldown.garrote.duration|poisoned_bleeds>5)
        SkipCycleGarrote = Target:DebuffRemainsP(S.Garrote) < 6 or PoisonedBleeds > 5
        -- actions.dot+=/variable,name=skip_cycle_rupture,value=priority_rotation&spell_targets.fan_of_knives>3&(debuff.toxic_blade.up|(poisoned_bleeds>5&!azerite.scent_of_blood.enabled))
        SkipCycleRupture = Target:DebuffP(S.ToxicBladeDebuff) or (PoisonedBleeds > 5 and not S.ScentOfBlood:AzeriteEnabled())
    end
    -- actions.dot+=/variable,name=skip_rupture,value=debuff.vendetta.up&(debuff.toxic_blade.up|master_assassin_remains>0)&dot.rupture.remains>2
    SkipRupture = Target:DebuffP(S.Vendetta) and (Target:DebuffP(S.ToxicBladeDebuff) or MasterAssassinRemains() > 0) and Target:DebuffRemainsP(S.Rupture) > 2

    -- actions.dot=rupture,if=talent.exsanguinate.enabled&((combo_points>=cp_max_spend&cooldown.exsanguinate.remains<1)|(!ticking&(time>10|combo_points>=2)))
    if HR.CDsON() and S.Rupture:IsCastable("Melee") and ComboPoints > 0 and S.Exsanguinate:IsAvailable()
        and ((ComboPoints >= CPMaxSpend() and S.Exsanguinate:CooldownRemainsP() < 1)
            or (not Target:DebuffP(S.Rupture) and (HL.CombatTime() > 10 or (ComboPoints >= 2)))) then
        if HR.Cast(S.Rupture) then return "Cast Rupture (Exsanguinate)"; end
    end
    -- actions.dot+=/garrote,if=(!talent.subterfuge.enabled|!(cooldown.vanish.up&cooldown.vendetta.remains<=4))&combo_points.deficit>=1+3*(azerite.shrouded_suffocation.enabled&cooldown.vanish.up)&refreshable&(pmultiplier<=1|remains<=tick_time&spell_targets.fan_of_knives>=3+azerite.shrouded_suffocation.enabled)&(!exsanguinated|remains<=tick_time*2&spell_targets.fan_of_knives>=3+azerite.shrouded_suffocation.enabled)&!ss_buffed&(target.time_to_die-remains)>4&(master_assassin_remains=0|!ticking&azerite.shrouded_suffocation.enabled)
    -- actions.dot+=/garrote,cycle_targets=1,if=!variable.skip_cycle_garrote&target!=self.target&(!talent.subterfuge.enabled|!(cooldown.vanish.up&cooldown.vendetta.remains<=4))&combo_points.deficit>=1+3*(azerite.shrouded_suffocation.enabled&cooldown.vanish.up)&refreshable&(pmultiplier<=1|remains<=tick_time&spell_targets.fan_of_knives>=3+azerite.shrouded_suffocation.enabled)&(!exsanguinated|remains<=tick_time*2&spell_targets.fan_of_knives>=3+azerite.shrouded_suffocation.enabled)&!ss_buffed&(target.time_to_die-remains)>12&(master_assassin_remains=0|!ticking&azerite.shrouded_suffocation.enabled)
    local EmpoweredDotRefresh = Cache.EnemiesCount[10] >= 3 + num(S.ShroudedSuffocation:AzeriteEnabled())
    if S.Garrote:IsCastable() and (Action.GetToggle(2, "AlwaysSuggestGarrote") or not S.Subterfuge:IsAvailable()
        or not HR.CDsON() or not (S.Vanish:CooldownUpP() and S.Vendetta:CooldownRemainsP() <= 4))
        and (ComboPointsDeficit >= 1 + 3 * num(S.ShroudedSuffocation:AzeriteEnabled() and S.Vanish:CooldownUpP())) then
        local function Evaluate_Garrote_Target(Target)
            return Target:DebuffRefreshableP(S.Garrote, 5.4)
                and (Target:PMultiplier(S.Garrote) <= 1 or Target:DebuffRemainsP(S.Garrote)
                    <= (HL.Exsanguinated(Target, "Garrote") and ExsanguinatedBleedTickTime or BleedTickTime) and EmpoweredDotRefresh)
                and (not HL.Exsanguinated(Target, "Garrote") or Target:DebuffRemainsP(S.Garrote) <= 1.5 and EmpoweredDotRefresh)
                and not SSBuffed(Target)
                and (MasterAssassinRemains() <= 0 or not Target:DebuffP(S.Garrote) and S.ShroudedSuffocation:AzeriteEnabled())
                and Everyone.CanDoTUnit(Target, GarroteDMGThreshold);
        end
        if Target:IsInRange("Melee") and Evaluate_Garrote_Target(Target)
            and (Target:FilteredTimeToDie(">", 4, -Target:DebuffRemainsP(S.Garrote)) or Target:TimeToDieIsNotValid()) then
            -- actions.maintain+=/pool_resource,for_next=1
            if Player:EnergyPredicted() < 45 then
                if HR.Cast(S.Channeling) then return "Pool for Garrote (ST)"; end
            end
            if HR.Cast(S.Garrote) then return "Cast Garrote (Refresh)"; end
        end
        if HR.AoEON() and not SkipCycleGarrote then
            SuggestCycleDoT(S.Garrote, Evaluate_Garrote_Target, 12);
        end
    end
    -- actions.dot+=/crimson_tempest,if=spell_targets>=2&remains<2+(spell_targets>=5)&combo_points>=4
    if HR.AoEON() and S.CrimsonTempest:IsCastable("Melee") and ComboPoints >= 4 and Cache.EnemiesCount[10] >= 2
        and Target:DebuffRemainsP(S.CrimsonTempest) < 2 + num(Cache.EnemiesCount[10] >= 5) then
        if HR.Cast(S.CrimsonTempest) then return "Cast Crimson Tempest"; end
    end
    -- actions.dot+=/rupture,if=!variable.skip_rupture&combo_points>=4&refreshable&(pmultiplier<=1|remains<=tick_time&spell_targets.fan_of_knives>=3+azerite.shrouded_suffocation.enabled)&(!exsanguinated|remains<=tick_time*2&spell_targets.fan_of_knives>=3+azerite.shrouded_suffocation.enabled)&target.time_to_die-remains>4
    -- actions.dot+=/rupture,cycle_targets=1,if=!variable.skip_cycle_rupture&!variable.skip_rupture&target!=self.target&combo_points>=4&refreshable&(pmultiplier<=1|remains<=tick_time&spell_targets.fan_of_knives>=3+azerite.shrouded_suffocation.enabled)&(!exsanguinated|remains<=tick_time*2&spell_targets.fan_of_knives>=3+azerite.shrouded_suffocation.enabled)&target.time_to_die-remains>4
    if not SkipRupture and ComboPoints >= 4 then
        local function Evaluate_Rupture_Target(Target)
            return Target:DebuffRefreshableP(S.Rupture, RuptureThreshold)
                and (Target:PMultiplier(S.Rupture) <= 1 or Target:DebuffRemainsP(S.Rupture)
                    <= (HL.Exsanguinated(Target, "Rupture") and ExsanguinatedBleedTickTime or BleedTickTime) and EmpoweredDotRefresh)
                and (not HL.Exsanguinated(Target, "Rupture") or Target:DebuffRemainsP(S.Rupture) <= ExsanguinatedBleedTickTime*2 and EmpoweredDotRefresh)
                and Everyone.CanDoTUnit(Target, RuptureDMGThreshold);
        end
        if Target:IsInRange("Melee") and Evaluate_Rupture_Target(Target)
            and (Target:FilteredTimeToDie(">", 4, -Target:DebuffRemainsP(S.Rupture)) or Target:TimeToDieIsNotValid()) then
            if HR.Cast(S.Rupture) then return "Cast Rupture (Refresh)"; end
        end
        if HR.AoEON() and not SkipCycleRupture then
            SuggestCycleDoT(S.Rupture, Evaluate_Rupture_Target, 4);
        end
    end
    return false;
end
Dot = Action.MakeFunctionCachedDynamic(Dot)

-- # Direct damage abilities
local function Direct ()
    -- actions.direct=envenom,if=combo_points>=4+talent.deeper_stratagem.enabled&(debuff.vendetta.up|debuff.toxic_blade.up|energy.deficit<=25+variable.energy_regen_combined|spell_targets.fan_of_knives>=2)&(!talent.exsanguinate.enabled|cooldown.exsanguinate.remains>2)
    --if S.Envenom:IsCastable("Melee") and ComboPoints >= 4 + (S.DeeperStratagem:IsAvailable() and 1 or 0)
    --    and (Target:DebuffP(S.Vendetta) or Target:DebuffP(S.ToxicBladeDebuff) or Player:EnergyDeficitPredicted() <= 25 + Energy_Regen_Combined or Cache.EnemiesCount[10] >= 2)
    --    and (not S.Exsanguinate:IsAvailable() or S.Exsanguinate:CooldownRemainsP() > 2) then
    --    if HR.Cast(S.Envenom) then return "Cast Envenom"; end
    --end
    -- actions.direct=envenom,if=combo_points>=4+talent.deeper_stratagem.enabled&(debuff.vendetta.up|debuff.toxic_blade.up|energy.deficit<=25+variable.energy_regen_combined|spell_targets.fan_of_knives>=2)&(!talent.exsanguinate.enabled|cooldown.exsanguinate.remains>2)
    if S.Envenom:IsCastable("Melee") and ComboPoints >= 4 + (S.DeeperStratagem:IsAvailable() and 1 or 0) and Target:DebuffP(S.Rupture) then 
        if HR.Cast(S.Envenom) then return "Cast Envenom"; end
    end

    if S.Envenom:IsReady("Melee") and ComboPoints >= 4 + (S.DeeperStratagem:IsAvailable() and 1 or 0)
            and (Target:DebuffP(S.Vendetta) or Target:DebuffP(S.ToxicBladeDebuff) or Player:EnergyDeficitPredicted() <= 25 + Energy_Regen_Combined or Cache.EnemiesCount[10] >= 2)
            and (not S.Exsanguinate:IsAvailable() or S.Exsanguinate:CooldownRemainsP() > 2) then
        if HR.Cast(S.Envenom) then return "Cast Envenom"; end
    end
	

    -------------------------------------------------------------------
    -------------------------------------------------------------------
    -- actions.direct+=/variable,name=use_filler,value=combo_points.deficit>1|energy.deficit<=25+variable.energy_regen_combined|spell_targets.fan_of_knives>=2
    -- This is used in all following fillers, so we just return false if not true and won't consider these.
    if not (ComboPointsDeficit > 1 or Player:EnergyDeficitPredicted() <= 25 + Energy_Regen_Combined or Cache.EnemiesCount[10] >= 2) then
        return false;
    end
    -------------------------------------------------------------------
    -------------------------------------------------------------------

    if S.FanofKnives:IsCastable("Melee") then
        -- actions.direct+=/fan_of_knives,if=variable.use_filler&azerite.echoing_blades.enabled&spell_targets.fan_of_knives>=2
        if S.EchoingBlades:AzeriteEnabled() and Cache.EnemiesCount[10] >= 2 then
            if HR.Cast(S.FanofKnives) then return "Cast Fan of Knives (Echoing Blades)"; end
        end
        -- actions.direct+=/fan_of_knives,if=variable.use_filler&(buff.hidden_blades.stack>=19|(!priority_rotation&spell_targets.fan_of_knives>=4+(azerite.double_dose.rank>2)+stealthed.rogue))
        if HR.AoEON() and (Player:BuffStack(S.HiddenBladesBuff) >= 19 or Player:BuffStack(S.TheDreadlordsDeceit) >= 29
            or not PriorityRotation and Cache.EnemiesCount[10] >= 4 + num(Player:IsStealthedP(true, false)) + num(S.DoubleDose:AzeriteRank() > 2)) then
            if HR.Cast(S.FanofKnives) then return "Cast Fan of Knives"; end
        end
        -- actions.direct+=/fan_of_knives,target_if=!dot.deadly_poison_dot.ticking,if=variable.use_filler&spell_targets.fan_of_knives>=3
        if HR.AoEON() and Player:BuffP(S.DeadlyPoison) and Cache.EnemiesCount[10] >= 3 then
            for _, CycleUnit in pairs(Cache.Enemies[10]) do
                -- Note: The APL does not do this due to target_if mechanics, but since we are cycling we should check to see if the unit has a bleed
                if (CycleUnit:DebuffP(S.Garrote) or CycleUnit:DebuffP(S.Rupture)) and not CycleUnit:DebuffP(S.DeadlyPoisonDebuff) then
                    if HR.Cast(S.FanofKnives) then return "Cast Fan of Knives (DP Refresh)"; end
                end
            end
        end
        -- Manually Added Fan of Knives big aoe
        if HR.AoEON() and Player:EnergyPredicted() >= 35 and Cache.EnemiesCount[10] >= 3 and Player:ComboPoints() <= 3 and not Player:PrevGCDP(1, S.FanofKnives) then
            if HR.Cast(S.FanofKnives) then return "Cast Fan of Knives (Echoing Blades)"; end
        end
    end
    -- actions.direct+=/blindside,if=variable.use_filler&(buff.blindside.up|!talent.venom_rush.enabled&!azerite.double_dose.enabled)
    if S.Blindside:IsCastable("Melee") and (Player:BuffP(S.BlindsideBuff) or (not S.VenomRush:IsAvailable() and not S.DoubleDose:AzeriteEnabled() and Target:HealthPercentage() < 30)) then
        if HR.Cast(S.Blindside) then return "Cast Blindside"; end
    end
    -- actions.direct+=/mutilate,target_if=!dot.deadly_poison_dot.ticking,if=variable.use_filler&spell_targets.fan_of_knives=2
    if S.Mutilate:IsCastable("Melee") and Cache.EnemiesCount[10] == 2 then
        local TargetGUID = Target:GUID();
        for _, CycleUnit in pairs(Cache.Enemies["Melee"]) do
            -- Note: The APL does not do this due to target_if mechanics, but since we are cycling we should check to see if the unit has a bleed
            if CycleUnit:GUID() ~= TargetGUID and (CycleUnit:DebuffP(S.Garrote) or CycleUnit:DebuffP(S.Rupture)) and not CycleUnit:DebuffP(S.DeadlyPoisonDebuff) then
                HR.CastLeftNameplate(CycleUnit, S.Mutilate);
                break;
            end
        end
    end
    -- actions.direct+=/mutilate,if=variable.use_filler
    if S.Mutilate:IsCastable("Melee") then
        if HR.Cast(S.Mutilate) then return "Cast Mutilate"; end
    end
    return false;
end
Direct = Action.MakeFunctionCachedDynamic(Direct)


--- ======= ACTION LISTS =======
local function APL(icon) 
    
	-- Action specifics remap
	local ShouldStop = Action.ShouldStop()
	local Pull = Action.BossMods_Pulling()	   
	
	ShouldReturn = RefreshPoisons()
    if ShouldReturn then
        -- Notification					
        Action.SendNotification("Auto refreshing poisons", A.CripplingPoison.ID)	
	    return ShouldReturn; 
	end
    
	-- Spell ID Changes check
    Stealth = S.Subterfuge:IsAvailable() and S.Stealth2 or S.Stealth; -- w/ or w/o Subterfuge Talent
    -- Unit Update
    HL.GetEnemies(50); -- Used for PoisonedBleeds()
    HL.GetEnemies(30); -- Used for Poisoned Knife Poison refresh
    HL.GetEnemies(10, true); -- Fan of Knives
    HL.GetEnemies("Melee"); -- Melee
    -- Compute Cache
    ComboPoints = Player:ComboPoints();
    ComboPointsDeficit = Player:ComboPointsMax() - ComboPoints;
    RuptureThreshold = (4 + ComboPoints * 4) * 0.3;
    RuptureDMGThreshold = S.Envenom:Damage() * Action.GetToggle(2, "EnvenomDMGOffset"); -- Used to check if Rupture is worth to be casted since it's a finisher.
    GarroteDMGThreshold = S.Mutilate:Damage() * Action.GetToggle(2, "MutilateDMGOffset"); -- Used as TTD Not Valid fallback since it's a generator.
    PriorityRotation = UsePriorityRotation();
    -- Defensives
	
	-- Black Water Behemot timerNextPhase
	-- InstanceDifficulty - See https://wow.gamepedia.com/DifficultyID
	--if Player:InstanceDifficulty() == 16 and Target:NPCID() == 154986 and Action.DBM_GetTimer("timerNextPhase") > 0 and Action.DBM_GetTimer("timerNextPhase") <= 2 and S.ShadowStep:IsReady() then
	--    if HR.Cast(S.ShadowStep) then return "ShadowStep"; end
	--end    
	
    -- Crimson Vial
    --ShouldReturn = CrimsonVial(S.CrimsonVial);
    --if ShouldReturn then return ShouldReturn; end
    -- Feint
    --ShouldReturn = Feint(S.Feint);
    --if ShouldReturn then return ShouldReturn; end
	
    -- Target                         
    if A.IsUnitEnemy("target") then 
        unit = "target"        		
		
	    -- Defensive
        if SelfDefensives(unit) then 
            return true
        end 
    end
	
	-- Anti channel interrupt
	if Player:IsCasting() or Player:IsChanneling() then
	    ShouldStop = true
	else
	    ShouldStop = false
	end
	
	local function Defensives()
		--ShadowStep
		if S.ShadowStep:IsReady() and Target:IsAPlayer() and not Player:CanAttack(Target) and not Target:IsDeadOrGhost() and Target:Exists()  then
            if not Target:IsInRange("Melee") and Target:IsInRange(25) then
				if Player:HealthPercentage() <= 55 then
                    if HR.Cast(S.ShadowStep) then return "ShadowStep"; end
                end
            end
	    end
		-- Sap
		if Target:Exists() and Target:IsAPlayer() and not Target:IsDeadOrGhost() then
			if Player:IsStealthed() and  Target:IsInRange(10) and not Target:AffectingCombat() and (Player:CanAttack(Target)) then
				if S.Sap:IsReady() then
			        if HR.Cast(S.Sap) then return "Sap"; end			  
				end
			end
		end	
	end
   	
    -- Out of Combat
    if not Player:AffectingCombat() then
        -- Stealth
        if not Player:Buff(S.VanishBuff) and Action.GetToggle(2, "StealthOOC") and Stealth:IsCastable() and not Player:IsStealthed() then
            if HR.Cast(Stealth, Action.GetToggle(2, "GCDasOffGCD")) then return "Cast Stealth (OOC)"; end
        end
        -- Flask
        -- Food
        -- Rune
        -- PrePot w/ Bossmod Countdown
        -- Opener
		-- ShadowStep with DBM opener
        if Everyone.TargetIsValid() and  S.ShadowStep:IsReady() and Action.GetToggle(1, "DBM") and Player:CanAttack(Target) and not Target:IsDeadOrGhost() and Target:Exists() and Pull > 0 and Pull < 0.2 then
            if Target:IsInRange(25) then
                if HR.Cast(S.ShadowStep) then return "ShadowStep"; end
            end
        end
		
	    -- Garrote
	    if Everyone.TargetIsValid() and S.Garrote:IsCastableP() and (Player:Buff(S.VanishBuff) or (Player:IsStealthed() and Player:PrevGCDP(1, S.ShadowStep))) and not Player:PrevGCDP(1, S.Garrote) then
		    if HR.Cast(S.Garrote) then return "Cast Garrote"; end
	    end

        if Everyone.TargetIsValid() and Target:IsInRange("Melee") then
            -- Precombat CDs
            if HR.CDsON() then

                if S.MarkedforDeath:IsCastableP() and not ShouldStop and Player:ComboPointsDeficit() >= CPMaxSpend() then
                    if HR.Cast(S.MarkedforDeath, Action.GetToggle(2, "GCDasOffGCD")) then return "Cast Marked for Death (OOC)"; end
                end
                -- actions.precombat+=/use_item,name=azsharas_font_of_power
                if TR.TrinketON() and I.FontOfPower:IsEquipped() and I.FontOfPower:IsReady() and not ShouldStop then
                    if HR.Cast(I.FontOfPower) then return "Use Font of Power (OOC)"; end
                end
            end
        end
    end
	
	-- Make use of all trinkets of the game
	-- Dont forget to add check on SIMC recommanded trinkets to keep using them with APLs.
	local function TrinketsRotation(icon)
	    local Trinket1IsAllowed, Trinket2IsAllowed = TR.TrinketIsAllowed()
		
       	-- Trinkets
       	if A.Trinket1:IsReady("target") and Trinket1IsAllowed and A.Trinket1:AbsentImun(unit, "DamageMagicImun")  then 
      	   	return A.Trinket1:Show(icon)
   	    end 
              
   		if A.Trinket2:IsReady("target") and Trinket2IsAllowed and A.Trinket2:AbsentImun(unit, "DamageMagicImun")  then 
       	   	return A.Trinket2:Show(icon)
   	    end  	   	
     	
   	end
    
	-- In Combat
    -- MfD Sniping
    MfDSniping(S.MarkedforDeath); 
	if Player:AffectingCombat() then
		
		-- Mythic Dungeon
        ShouldReturn = MythicDungeon();
        if ShouldReturn then return ShouldReturn; end
        
		-- Training Scenario
        ShouldReturn = TrainingScenario();
        if ShouldReturn then return ShouldReturn; end
        
 		-- Interrupt Handler
 	 	
  		local unit = "target"
   		local useKick, useCC, useRacial = Action.InterruptIsValid(unit, "TargetMouseover")    
        local Trinket1IsAllowed, Trinket2IsAllowed = TR.TrinketIsAllowed()
		     
		-- ShadowStep in combat and not in range
        --if S.ShadowStep:IsReady() and Player:CanAttack(Target) and not Target:IsDeadOrGhost() and Target:Exists() then
        --    if not Target:IsInRange("Melee") and Target:IsInRange(25) then
        --        if HR.Cast(S.ShadowStep) then return "ShadowStep"; end
        --    end
        --end
		
  	    -- Kick
  	    if useKick and S.Kick:IsReady() and not ShouldStop then 
		  	if ActionUnit(unit):CanInterrupt(true, nil, 25, 70) then
          	    if HR.Cast(S.Kick, true) then return "Kick 5"; end
         	end 
      	end 
	
     	 -- CheapShot
      	if useCC and S.CheapShot:IsReady() and not ShouldStop and Target:IsInterruptible() and Player:EnergyPredicted() >= 40 then 
	  		if ActionUnit(unit):CanInterrupt(true, nil, 25, 70) then
     	        if HR.Cast(S.CheapShot, true) then return "CheapShot 5"; end
     	    end 
     	end 

        -- Mythic Dungeon
        ShouldReturn = MythicDungeon();
        if ShouldReturn then return ShouldReturn; end
        -- Training Scenario
        ShouldReturn = TrainingScenario();
        if ShouldReturn then return ShouldReturn; end
		
        -- actions=variable,name=energy_regen_combined,value=energy.regen+poisoned_bleeds*7%(2*spell_haste)
        local PoisonedBleeds = PoisonedBleeds()
        Energy_Regen_Combined = Player:EnergyRegen() + PoisonedBleeds * 7 / (2 * Player:SpellHaste());

        -- Special Font of Power Handling
        if TR.TrinketON() then
            -- use_item,name=azsharas_font_of_power,if=!stealthed.all&master_assassin_remains=0&cooldown.vendetta.remains<10+10*equipped.ashvanes_razor_coral&!debuff.vendetta.up&!debuff.toxic_blade.up
            if I.FontOfPower:IsEquipped() and I.FontOfPower:IsReady() and not ShouldStop and MasterAssassinRemains() <= 0
                and S.Vendetta:CooldownRemains() < 10 + 10 * num(I.RazorCoral:IsEquipped()) and not Target:DebuffP(S.Vendetta) and not Target:DebuffP(S.ToxicBladeDebuff) then
                if HR.Cast(I.FontOfPower) then return "Use Font of Power"; end
            end
        end
        -- actions+=/call_action_list,name=stealthed,if=stealthed.rogue
        if Player:IsStealthedP(true, false) then
            ShouldReturn = Stealthed();
            if ShouldReturn then return ShouldReturn .. " (Stealthed)"; end
        end
        -- Manually added, pvp defensives
        ShouldReturn = Defensives();
        if ShouldReturn then return ShouldReturn; end
		
        -- actions+=/call_action_list,name=cds,if=(!talent.master_assassin.enabled|dot.garrote.ticking)&(!equipped.azsharas_font_of_power|!trinket.azsharas_font_of_power.cooldown.up)
        if not S.MasterAssassin:IsAvailable() or Target:DebuffP(S.Garrote) and (not TR.TrinketON() or not I.FontOfPower:IsEquipped() or not I.FontOfPower:IsReady() and not ShouldStop) then
            ShouldReturn = CDs();
            if ShouldReturn then return ShouldReturn; end
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
		-- Manually added Toxic blade
        -- actions.cds+=/toxic_blade,if=dot.rupture.ticking
        if S.ToxicBlade:IsCastable("Melee") and Target:DebuffP(S.Rupture) and Player:ComboPoints() < Player:ComboPointsMax() then
            if HR.Cast(S.ToxicBlade) then return "Cast Toxic Blade"; end
        end
        -- actions+=/call_action_list,name=dot
        ShouldReturn = Dot();
        if ShouldReturn then return ShouldReturn; end		
        -- actions+=/call_action_list,name=direct
        ShouldReturn = Direct();
        if ShouldReturn then return ShouldReturn; end
        -- Racials
        if HR.CDsON() then
            -- actions+=/arcane_torrent,if=energy.deficit>=15+variable.energy_regen_combined
            if S.ArcaneTorrent:IsCastableP("Melee") and not ShouldStop and Player:EnergyDeficitPredicted() > 15 + Energy_Regen_Combined then
                if HR.Cast(S.ArcaneTorrent, Action.GetToggle(2, "GCDasOffGCD")) then return "Cast Arcane Torrent"; end
            end
            -- actions+=/arcane_pulse
            if S.ArcanePulse:IsCastableP("Melee") and not ShouldStop then
                if HR.Cast(S.ArcanePulse, Action.GetToggle(2, "GCDasOffGCD")) then return "Cast Arcane Pulse"; end
            end
            -- actions+=/lights_judgment
            if S.LightsJudgment:IsCastableP("Melee") and not ShouldStop then
                if HR.Cast(S.LightsJudgment, Action.GetToggle(2, "GCDasOffGCD")) then return "Cast Lights Judgment"; end
            end
        end
        -- Poisoned Knife Out of Range [EnergyCap] or [PoisonRefresh]
        if S.PoisonedKnife:IsCastable(30) and not Player:IsStealthedP(true, true) and Player:ComboPoints() < Player:ComboPointsMax()
            and ((not Target:IsInRange(10) and Player:EnergyTimeToMax() <= Player:GCD()*1.2)
                or (not Target:IsInRange("Melee") and Target:DebuffRefreshableP(S.DeadlyPoisonDebuff, 4))) then
            if HR.Cast(S.PoisonedKnife) then return "Cast Poisoned Knife"; end
        end
        -- Trick to take in consideration the Recovery Setting
        --if S.Mutilate:IsCastable("Melee") then
        --    if HR.Cast(S.Channeling) then return "Normal Pooling"; end
        --end
    end    
end
-- Finished


-----------------------------------------
--           PVP ROTATION  
-----------------------------------------

local function PvPRotation(icon)

    local unit = "target"
    local isMoving = Player:IsMoving()
    local inMelee = false
    
	-- Poisons Refresh
	ShouldReturn = RefreshPoisons()
    if ShouldReturn then
        -- Notification					
        Action.SendNotification("Auto refreshing poisons", A.CripplingPoison.ID)	
	    return ShouldReturn; 
	end
	
    CurrentStealth = A.Subterfuge:IsSpellLearned() and A.Stealth2 or A.Stealth; -- w/ or w/o Subterfuge Talent
		
	-- Stealth out of combat
    if ActionUnit("player"):HasBuffs(A.VanishBuff.ID) == 0 and Action.GetToggle(2, "StealthOOC") and not ActionUnit("player"):HasFlags() and CurrentStealth:IsReady("player") and ActionUnit("player"):HasBuffs(CurrentStealth.ID) == 0 then
        -- Notification					
        Action.SendNotification("Auto Stealthing", A.Stealth.ID)
        return CurrentStealth:Show(icon)
    end
    
	-- Defensives
    local function SelfDefensives(unit)
	    local HPLoosePerSecond = ActionUnit("player"):GetDMG() * 100 / ActionUnit("player"):HealthMax()
		
        if ActionUnit("player"):CombatTime() == 0 then 
            return 
        end 
		
        -- Emergency CrimsonVial
        local CrimsonVial = Action.GetToggle(2, "CrimsonVialHP")
        if     CrimsonVial >= 0 and A.CrimsonVial:IsReady("player") and 
        (
            (   -- Auto 
                CrimsonVial >= 100 and 
                (
                    -- HP lose per sec >= 10
                    ActionUnit("player"):GetDMG() * 100 / ActionUnit("player"):HealthMax() >= 10 or 
                    ActionUnit("player"):GetRealTimeDMG() >= ActionUnit("player"):HealthMax() * 0.10 or 
                    -- TTD 
                    ActionUnit("player"):TimeToDieX(25) < 5 or 
                    (
                        A.IsInPvP and 
                        (
                            ActionUnit("player"):UseDeff() or 
                            (
                                ActionUnit("player", 5):HasFlags() and 
                                ActionUnit("player"):GetRealTimeDMG() > 0 and 
                                ActionUnit("player"):IsFocused() 
                            )
                        )
                    )
                ) and 
                ActionUnit("player"):HasBuffs("DeffBuffs", true) == 0
            ) or 
            (    -- Custom
                CrimsonVial < 100 and 
                ActionUnit("player"):HealthPercent() <= CrimsonVial
            )
        ) 
        then 
		    -- Notification					
            Action.SendNotification("Defensive Crimson Vial", A.CrimsonVial.ID)
            return A.CrimsonVial:Show(icon)
        end 
		
        -- Emergency Evade
        local Evade = Action.GetToggle(2, "EvadeHP")
        if     Evade >= 0 and A.Evade:IsReady("player") and 
        (
            (   -- Auto 
                Evade >= 100 and 
                (
                    -- HP lose per sec >= 30
                    ActionUnit("player"):GetDMG() * 100 / ActionUnit("player"):HealthMax() >= 30 or 
                    ActionUnit("player"):GetRealTimeDMG() >= ActionUnit("player"):HealthMax() * 0.30 or 
                    -- TTD 
                    ActionUnit("player"):TimeToDieX(25) < 5 or 
                    (
                        A.IsInPvP and 
                        (
                            ActionUnit("player"):UseDeff() or 
                            (
                                ActionUnit("player", 5):HasFlags() and 
                                ActionUnit("player"):GetRealTimeDMG() > 0 and 
                                ActionUnit("player"):IsFocused() 
                            )
                        )
                    )
                ) and 
                ActionUnit("player"):HasBuffs("DeffBuffs", true) == 0
            ) or 
            (    -- Custom
                Evade < 100 and 
                ActionUnit("player"):HealthPercent() <= Evade
            )
        ) 
        then
		    -- Notification					
            Action.SendNotification("Defensive Evade", A.Evade.ID)
            return A.Evade:Show(icon)
        end  
		
        -- Emergency Feint
        local Feint = Action.GetToggle(2, "FeintHP")
        if     Feint >= 0 and A.Feint:IsReady("player") and 
        (
            (   -- Auto 
                Feint >= 100 and 
                (
                    -- HP lose per sec >= 10
                    ActionUnit("player"):GetDMG() * 100 / ActionUnit("player"):HealthMax() >= 10 or 
                    ActionUnit("player"):GetRealTimeDMG() >= ActionUnit("player"):HealthMax() * 0.10 or 
                    -- TTD 
                    ActionUnit("player"):TimeToDieX(25) < 5 or 
                    (
                        A.IsInPvP and 
                        (
                            ActionUnit("player"):UseDeff() or 
                            (
                                ActionUnit("player", 5):HasFlags() and 
                                ActionUnit("player"):GetRealTimeDMG() > 0 and 
                                ActionUnit("player"):IsFocused() 
                            )
                        )
                    )
                ) and 
                ActionUnit("player"):HasBuffs("DeffBuffs", true) == 0
            ) or 
            (    -- Custom
                Feint < 100 and 
                ActionUnit("player"):HealthPercent() <= Feint
            )
        ) 
        then 
		    -- Notification					
            Action.SendNotification("Defensive Feint", A.Feint.ID)
            return A.Feint:Show(icon)
        end  		 		

        -- Emergency Cloak of Shadow with Vanish
        local CloakofShadow = Action.GetToggle(2, "CloakofShadowHP")
        if     CloakofShadow >= 0 and A.CloakofShadow:IsReady("player") and Action.GetToggle(2, "ShadowVanish") and 
        (
            (   -- Auto 
                CloakofShadow >= 100 and 
                (
                    -- HP lose per sec >= 25
                    ActionUnit("player"):GetDMG() * 100 / ActionUnit("player"):HealthMax() >= 25 or 
                    ActionUnit("player"):GetRealTimeDMG() >= ActionUnit("player"):HealthMax() * 0.25 or 
                    -- TTD 
                    ActionUnit("player"):TimeToDieX(25) < 5 or 
                    (
                        A.IsInPvP and 
                        (
                            ActionUnit("player"):UseDeff() or 
                            (
                                ActionUnit("player", 5):HasFlags() and 
                                ActionUnit("player"):GetRealTimeDMG() > 0 and 
                                ActionUnit("player"):IsFocused() 
                            )
                        )
                    )
                ) and 
                ActionUnit("player"):HasBuffs("DeffBuffs", true) == 0
            ) or 
            (    -- Custom
                CloakofShadow < 100 and 
                ActionUnit("player"):HealthPercent() <= CloakofShadow
            )
        ) 
        then 
		    -- Notification					
            Action.SendNotification("Defensive Cloak of Shadow", A.CloakofShadow.ID)
            return A.CloakofShadow:Show(icon)
        end 
		
        -- Emergency Vanish
        local Vanish = Action.GetToggle(2, "VanishDefensive")
        if     Vanish >= 0 and A.Vanish:IsReady("player") and not ActionUnit("player"):HasFlags() and
        (
            (   -- Auto 
                Vanish >= 100 and 
                (
                    -- HP lose per sec >= 20
                    ActionUnit("player"):GetDMG() * 100 / ActionUnit("player"):HealthMax() >= 20 or 
                    ActionUnit("player"):GetRealTimeDMG() >= ActionUnit("player"):HealthMax() * 0.20 or 
                    -- TTD 
                    ActionUnit("player"):TimeToDieX(25) < 5 or 
                    (
                        A.IsInPvP and 
                        (
                            ActionUnit("player"):UseDeff() or 
                            (
                                ActionUnit("player", 5):HasFlags() and 
                                ActionUnit("player"):GetRealTimeDMG() > 0 and 
                                ActionUnit("player"):IsFocused() 
                            )
                        )
                    )
                ) and 
                ActionUnit("player"):HasBuffs("DeffBuffs", true) == 0
            ) or 
            (    -- Custom
                Vanish < 100 and 
                ActionUnit("player"):HealthPercent() <= Vanish
            )
        ) 
        then 
			-- Notification					
            Action.SendNotification("Emergency Vanish", A.Vanish.ID)
            return A.Vanish:Show(icon)
        end  

    end 
    SelfDefensives = Action.MakeFunctionCachedDynamic(SelfDefensives)

	-- Interrupts
    local function Interrupts(unit)
        local useKick, useCC, useRacial = A.InterruptIsValid(unit, "TargetMouseover")    
        local EnemyHealerUnitID = EnemyTeam("HEALER"):GetUnitID(5)
		
        if useKick and A.Kick:IsReady(unit) and A.Kick:AbsentImun(unit, {"TotalImun", "DamagePhysImun", "KickImun"}, true) and ActionUnit(unit):CanInterrupt(true) then 
		    -- Notification					
            Action.SendNotification("Interrupting with Kick on : " .. UnitName(unit), A.Kick.ID)		
            return A.Kick:Show(icon)
        end 
    
        if useCC and A.KidneyShot:IsReady(unit) and Player:ComboPoints() >= 4 and A.KidneyShot:AbsentImun(unit, {"TotalImun", "DamagePhysImun", "CCTotalImun"}, true) and ActionUnit(unit):IsControlAble("stun", 0) then
		    -- Notification					
            Action.SendNotification("Interrupting with Kidney Shot on : " .. UnitName(unit), A.KidneyShot.ID)		
            return A.KidneyShot:Show(icon)              
        end  		
    
        if useRacial and A.QuakingPalm:AutoRacial(unit) then 
            return A.QuakingPalm:Show(icon)
        end 
    
        if useRacial and A.Haymaker:AutoRacial(unit) then 
            return A.Haymaker:Show(icon)
        end 
    
        if useRacial and A.WarStomp:AutoRacial(unit) then 
            return A.WarStomp:Show(icon)
        end 
    
        if useRacial and A.BullRush:AutoRacial(unit) then 
            return A.BullRush:Show(icon)
        end      
    end 
    Interrupts = Action.MakeFunctionCachedDynamic(Interrupts)


    -- Passive 
    local function FreezingTrapUsedByEnemy()
        if     UnitCooldown:GetCooldown("arena", 3355) > UnitCooldown:GetMaxDuration("arena", 3355) - 2 and 
        UnitCooldown:IsSpellInFly("arena", 3355) and 
        ActionUnit("player"):GetDR("incapacitate") >= 50 
        then 
            local Caster = UnitCooldown:GetUnitID("arena", 3355)
            if Caster and ActionUnit(Caster):GetRange() <= 40 then 
                return true 
            end 
        end 
    end 
	
	-- DPS Rotation
	local function EnemyRotation(unit)
		
		-- Variables
        inMelee = A.Mutilate:IsInRange(unit)
        local EnemyHealerUnitID = EnemyTeam("HEALER"):GetUnitID(5)	
		
		
		-- Sap out of combat
		if A.Sap:IsReady(unit) and Player:IsStealthed() and ActionUnit(unit):CombatTime() == 0 and ActionUnit(unit):IsControlAble("incapacitate") and ActionUnit("player"):GetDR("incapacitate") > 25 then
		    if ActionUnit(unit):HasDeBuffs(A.Sap.ID) == 0 then 
			    -- Notification					
                Action.SendNotification("Out of combat Sap on : " .. UnitName(unit), A.Sap.ID)
			    return A.Sap:Show(icon)
			else 
			    if ActionUnit(unit):HasDeBuffs(A.Sap.ID) > 0 and ActionUnit(unit):HasDeBuffs(A.Sap.ID) <= 1 then
    			    -- Notification					
                    Action.SendNotification("Refreshing Sap on : " .. UnitName(unit), A.Sap.ID)
			        return A.Sap:Show(icon)
				end
			end
		end			
		
		-- ShadowStep
		--if ActionUnit(unit):CombatTime() > 0 and A.ShadowStep:IsReady(unit) and ActionUnit(unit):GetRange() > 7 and ActionUnit(unit):GetRange() <= 25 then
			-- ShadowStep
		--    if A.ShadowStep:IsReady(unit) then
		--	    return A.ShadowStep:Show(icon)
		--    end			
		--end		
		
		-- Vanish to garrote when in fight
		if Player:IsStealthed() and ActionUnit(unit):CombatTime() > 0 then
			-- Garrote
		    if A.Garrote:IsReady(unit) then
			    return A.Garrote:Show(icon)
		    end			
		end
		
        -- Marked for Death
		if A.MarkedforDeath:IsReady(unit) and Player:ComboPoints() <= 1 and S.ToxicBlade:IsAvailable() and S.MarkedforDeath:IsAvailable() then
			return A.MarkedforDeath:Show(icon)
		end
		
		-- Garrote
		if A.Garrote:IsReady(unit) and Player:ComboPoints() < 5  and (not ActionUnit(unit):HasDeBuffs(A.Garrote.ID) or ActionUnit(unit):HasDeBuffs(A.Garrote.ID) <= 2) then
			return A.Garrote:Show(icon)
		end	
		
   		-- Envenom
		if A.Envenom:IsReady(unit) and Player:ComboPoints() >= 5 and ActionUnit(unit):HasDeBuffs(A.Rupture.ID) > 2 then
			return A.Envenom:Show(icon)
		end
		
		-- Rupture
		if A.Rupture:IsReady(unit) and Player:ComboPoints() >= 5 and ActionUnit(unit):HasDeBuffs(A.Garrote.ID) and (not ActionUnit(unit):HasDeBuffs(A.Rupture.ID) or ActionUnit(unit):HasDeBuffs(A.Rupture.ID) <= 2) then
			return A.Rupture:Show(icon)
		end	

		-- Kidney Shot on enemies with burst damage buff or if our friend healer is cc
        if A.KidneyShot:IsReady(unit) and inMelee and Player:ComboPoints() >= 4 and ActionUnit(unit):IsControlAble("stun", 25) and ActionUnit(unit):HasBuffs("DamageBuffs") > 0 then
   			-- Notification					
            Action.SendNotification("Defensive Kidney Shot on : " .. UnitName(unit), A.KidneyShot.ID)
			return A.KidneyShot:Show(icon)
        end	
       
	   -- Full Kidney Shot
		if A.KidneyShot:IsReady(unit) and ActionUnit(unit):HealthPercent() <= 50 and Player:ComboPoints() >= 5 and A.KidneyShot:AbsentImun(unit, {"TotalImun", "DamagePhysImun", "CCTotalImun"}, true) and ActionUnit(unit):IsControlAble("stun", 0) then 
            return A.KidneyShot:Show(icon)              
        end
		
		-- Vendetta
		if A.Vendetta:IsReady(unit) and Player:ComboPoints() >= 5 and ActionUnit(unit):HealthPercent() <= 75 and HR.CDsON() and ActionUnit(unit):HasDeBuffs(A.Rupture.ID) > 4 then
			return A.Vendetta:Show(icon)
		end		
		
		-- Blood of the Enemy
        if A.BloodoftheEnemy:AutoHeartOfAzeroth(unit) and (ActionUnit(unit):HealthPercent() <= 40 or Player:PrevGCDP(1, S.Vendetta)) and HR.CDsON() and ActionUnit(unit):HasDeBuffs(A.Rupture.ID) > 4 then                                                                 
            return A.BloodoftheEnemy:Show(icon)                                                                                                 
        end 
		
		-- Neuro
		if S.Neuro:IsAvailable() and S.Neuro:CooldownUp() and inMelee and ActionUnit(unit):HealthPercent() <= 75 and not Player:IsStealthed() then
			return A.Neuro:Show(icon)
		end
		
		-- Shiv
		if S.Shiv:IsAvailable() and S.Shiv:CooldownUp() and inMelee and ActionUnit(unit):HealthPercent() <= 50 and Action.AbsentImun(unit, "DamagePhysImun", true) and A.Shiv:IsReady(unit) and not ActionUnit(unit):InCC()  then
			return A.Shiv:Show(icon)
   		end
		
        -- Death From Above
		if S.DFA:IsAvailable() and A.DFA:IsReady(unit) and ActionUnit(unit):HealthPercent() <= 70 and Player:ComboPoints() >= 5 and ActionUnit(unit):GetRange() <= 15 and Action.AbsentImun("target", "DamagePhysImun", true) then
			return A.DFA:Show(icon)
   	    end		
		
		-- Toxic Blade
		if A.ToxicBlade:IsReady(unit) and S.ToxicBlade:IsAvailable() and Player:ComboPoints() < 5 and ActionUnit(unit):HasDeBuffs(A.Rupture.ID) > 0 then
			return A.ToxicBlade:Show(icon)
		end	

		-- Mutilate
		if A.Mutilate:IsReady(unit) and Player:ComboPoints() < 5 then
			return A.Mutilate:Show(icon)
		end			

		-- Mouseover KidneyShot on enemy trying to leave with less than 30% HP
        if unit ~= "mouseover" and Player:ComboPoints() >= 4 and ActionUnit(unit):HealthPercent() <= 30 and  ActionUnit(unit):GetRange() <= 5 and (A.IsInPvP or (not ActionUnit(unit):IsBoss() and ActionUnit(unit):IsMovingOut())) and A.CheapShot:IsReady(unit) and A.CheapShot:AbsentImun(unit, {"TotalImun", "DamagePhysImun", "Freedom", "CCTotalImun"}, true) and ActionUnit(unit):GetMaxSpeed() >= 100 and ActionUnit(unit):HasDeBuffs("Slowed") == 0 and not ActionUnit(unit):IsTotem() then 
            return A.KidneyShot:Show(icon)
        end	
		
		-- PoisonedKnife
		if A.PoisonedKnife:IsReady(unit) and ActionUnit(unit):CombatTime() >= 1 and not inMelee and A.PoisonedKnife:AbsentImun(unit, {"TotalImun", "DamagePhysImun"}) and ActionUnit(unit):HasDeBuffs(A.DeadlyPoisonDebuff.ID) < 2  then
			return A.PoisonedKnife:Show(icon)
		end
		
		-- AoE Fan of Knives to spread poisons
		if A.GetToggle(2, "AoE") and MultiUnits:GetByRange(8, 2) >= 2 and A.FanofKnives:IsReady(unit, true) then
			return A.FanofKnives:Show(icon)
		end	

		-- Bursting #2
        if unit ~= "mouseover" and A.BurstIsON(unit) then                         
            -- Simcraft 
            -- Cooldowns --
                        
            if inMelee then 
                -- Racials 
                if A.BloodFury:AutoRacial(unit) then 
                    return A.BloodFury:Show(icon)
                end 
                                
                if A.Fireblood:AutoRacial(unit) then 
                    return A.Fireblood:Show(icon)
                end 
                                
                if A.AncestralCall:AutoRacial(unit) then 
                    return A.AncestralCall:Show(icon)
                end 
                                
                if A.Berserking:AutoRacial(unit) then 
                    return A.Berserking:Show(icon)
                end 
                                
                -- Trinkets
                if A.Trinket1:IsReady(unit) and A.Trinket1:GetItemCategory() ~= "DEFF" then 
                    return A.Trinket1:Show(icon)
                end 
                                
                if A.Trinket2:IsReady(unit) and A.Trinket2:GetItemCategory() ~= "DEFF" then 
                    return A.Trinket2:Show(icon)
                end                                         
            end 
			
            -- call_action_list,name=essences
            if (isMulti or A.GetToggle(2, "AoE")) and A.BloodoftheEnemy:AutoHeartOfAzeroth(unit) then                                                                 
                return A.BloodoftheEnemy:Show(icon)                                                                                                 
            end 
                        
            if A.FocusedAzeriteBeam:AutoHeartOfAzeroth(unit) then 
                return A.FocusedAzeriteBeam:Show(icon)
            end 
                        
            if A.GuardianofAzeroth:AutoHeartOfAzeroth(unit) then 
                return A.GuardianofAzeroth:Show(icon)
            end 
                        
            if A.WorldveinResonance:AutoHeartOfAzeroth(unit) then 
                return A.WorldveinResonance:Show(icon)
            end 
        end

		-- Agressive CC Burst Rotation
		if (ActionUnit(unit):HealthPercent() <= 40 or ActionUnit(EnemyHealerUnitID):InCC() >= 5) then
		    -- SmokeBomb under 30% HP
		    if S.SmokeBomb:IsAvailable() and Action.GetToggle(2, "SmokeBombFinishComco") then
		    	if inMelee then
			        if A.SmokeBomb:IsReady(unit) and ActionUnit(unit):TimeToDieX(30) < 6 and ActionUnit(unit):HealthPercent() <= 30 then
					    -- Notification					
                        Action.SendNotification("Offensive Smoke Bomb", A.SmokeBomb.ID)
                        return A.SmokeBomb:Show(icon)
                    end
			    end
	        end
			-- Garrote 
			if inMelee and A.Garrote:IsReady(unit) and A.Garrote:AbsentImun(unit, {"TotalImun", "DamagePhysImun"}) and (not ActionUnit(unit):HasDeBuffs(A.Garrote.ID) or ActionUnit(unit):HasDeBuffs(A.Garrote.ID) <= 2) then
				return A.Garrote:Show(icon)
			end
			-- KidneyShot
			if inMelee and A.KidneyShot:IsReady(unit) and A.KidneyShot:AbsentImun(unit, {"TotalImun", "DamagePhysImun"}) and Player:ComboPoints() >= 5 and ActionUnit(unit):HasDeBuffs(A.Rupture.ID) > 0 then
				return A.KidneyShot:Show(icon)
			end
			-- Rupture
			if inMelee and A.Rupture:IsReady(unit) and A.Rupture:AbsentImun(unit, {"TotalImun", "DamagePhysImun"}) and Player:ComboPoints() >= 5 and (not ActionUnit(unit):HasDeBuffs(A.Rupture.ID) or ActionUnit(unit):HasDeBuffs(A.Rupture.ID) <= 2) then
				return A.Rupture:Show(icon)
			end
			-- Envenom
			if inMelee and A.Envenom:IsReady(unit) and A.Envenom:AbsentImun(unit, {"TotalImun", "DamagePhysImun"}) and Player:ComboPoints() >= 5 and ((S.ToxicBlade:IsAvailable() and ActionUnit(unit):HasDeBuffs(A.ToxicBladeDebuff.ID) >= 2) or not S.ToxicBlade:IsAvailable()) and ActionUnit(unit):HasDeBuffs(A.Rupture.ID) > 2 then
				return A.Envenom:Show(icon)
			end
			-- Vendetta
			if inMelee and A.Vendetta:IsReady(unit) and A.Vendetta:AbsentImun(unit, {"TotalImun", "DamagePhysImun"}) and HR.CDsON() and ActionUnit(unit):HasDeBuffs(A.Rupture.ID) > 2 then
				return A.Vendetta:Show(icon)
			end
			-- ToxicBlade
			if inMelee and S.ToxicBlade:IsAvailable() and A.ToxicBlade:IsReady(unit) and A.ToxicBlade:AbsentImun(unit, {"TotalImun", "DamagePhysImun"}) and ActionUnit(unit):HasDeBuffs(A.Rupture.ID) > 2 then
				return A.ToxicBlade:Show(icon)
			end
			-- MarkedforDeath
			if inMelee and A.MarkedforDeath:IsReady(unit) and A.MarkedforDeath:AbsentImun(unit, {"TotalImun", "DamagePhysImun"}) and Player:ComboPoints() <= 1 then
				return A.MarkedforDeath:Show(icon)
			end
            -- Mutilate
			if inMelee and A.Mutilate:IsReady(unit) and A.Mutilate:AbsentImun(unit, {"TotalImun", "DamagePhysImun"}) and Player:ComboPoints() < 5 then
				return A.Mutilate:Show(icon)
			end
		end

        --...
		--...
 	end 
  
        
    -- Trinkets (Defensive)
    if ActionUnit("player"):CombatTime() > 0 and ActionUnit("player"):HealthPercent() <= 75 then --A.GetToggle(2, "TrinketDefensive") then 
        if A.Trinket1:IsReady("player") and A.Trinket1:GetItemCategory() ~= "DPS" then 
            return A.Trinket1:Show(icon)
        end 
                
        if A.Trinket2:IsReady("player") and A.Trinket2:GetItemCategory() ~= "DPS" then 
            return A.Trinket2:Show(icon)
        end                         
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
        
		-- Interrupts
        if Interrupts(unit) then 
            return true
        end  		
		
	    -- Defensive
        if SelfDefensives(unit) then 
            return true
        end  

        -- Rotation		
        if EnemyRotation(unit) then 
            return true 
        end 
    end 
        
    -- Movement
    -- If not moving or moving lower than 2.5 sec 
    if ActionPlayer:IsMovingTime() < 2.5 then 
        return 
    end 	


end

-- [3] is Single rotation (supports all actions)
A[3] = function(icon, isMulti)
    -- PvE Simc Rotation
	if not Action.IsInPvP and APL(icon) then 
        return true 
    end
	
	-- PvP Custom Rotation
	if Action.IsInPvP then	    
	    return PvPRotation(icon)		
	end
		
end

-----------------------------------------
--           ARENA ROTATION  
-----------------------------------------

local function ArenaRotation(icon, unit)
    if A.IsInPvP and (A.Zone == "pvp" or A.Zone == "arena") and not ActionPlayer:IsMounted() then              
        local EnemyHealerUnitID = EnemyTeam("HEALER"):GetUnitID(5)
		local useKickHeal, useCCHeal, useRacialHeal = A.InterruptIsValid(EnemyHealerUnitID, "TargetMouseover")  
		
		-- Blind on Enemy Healer
        if A.Blind:IsReady(EnemyHealerUnitID) and ActionUnit(EnemyHealerUnitID):GetRange() <= 15 and not ActionUnit(EnemyHealerUnitID):InLOS() and ActionUnit(EnemyHealerUnitID):IsControlAble("disorient", 25) and ActionUnit(unit):HealthPercent() <= 30 then
            return A.Blind:Show(icon)
        end 
		
        -- Shadowstep into KidneyShot or Interrupt
        if A.ShadowStep:IsReady(EnemyHealerUnitID) and ActionUnit(EnemyHealerUnitID):GetRange() <= 25 and ActionUnit(unit):HealthPercent() <= 30 and not ActionUnit(EnemyHealerUnitID):InLOS() and ActionUnit(EnemyHealerUnitID):InCC() < 1 then
            return A.ShadowStep:Show(icon)              
        end
		
		-- Kidney Shot on enemies with burst damage buff
        if A.KidneyShot:IsReady(unit) and inMelee and ActionUnit(unit):IsControlAble("stun", 25) and ActionUnit(unit):HasBuffs("DamageBuffs") > 0 then
            return A.KidneyShot:Show(icon)
        end          

        -- Disarm
        if A.DisarmIsReady(unit) and not ActionUnit(unit):InLOS() then
            return A.Disarm:Show(icon)
        end 
    end 
end 

A[6] = function(icon)    
    return ArenaRotation(icon, "arena1")
end

A[7] = function(icon)   
    return ArenaRotation(icon, "arena2")
end

A[8] = function(icon)   
    return ArenaRotation(icon, "arena3")
end

