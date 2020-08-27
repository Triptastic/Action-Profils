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

Action[ACTION_CONST_WARRIOR_ARMS] = {
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
    -- CrowdControl
	StormBolt							= Action.Create({ Type = "Spell", ID = 107570    }),
	StormBoltGreen						= Action.Create({ Type = "SpellSingleColor", ID = 107570, Color = "GREEN", Desc = "[1] CC", Hidden = true, QueueForbidden = true }),
	StormBoltAntiFake                   = Action.Create({ Type = "Spell", ID = 107570, Desc = "[2] Kick", Hidden = true, QueueForbidden = true    }),
	Pummel                              = Action.Create({ Type = "Spell", ID = 6552    }),
	PummelGreen							= Action.Create({ Type = "SpellSingleColor", ID = 6552, Color = "GREEN", Desc = "[2] Kick", Hidden = true, QueueForbidden = true }), 
	IntimidatingShout                   = Action.Create({ Type = "Spell", ID = 5246    }),
	IntimidatingShoutAntiFake           = Action.Create({ Type = "Spell", ID = 5246, Desc = "[2] Kick", QueueForbidden = true    }),
	Hamstring							= Action.Create({ Type = "Spell", ID = 1715    }),
	Taunt								= Action.Create({ Type = "Spell", ID = 355, Desc = "[6] PvP Pets Taunt", QueueForbidden = true    }),
	Disarm								= Action.Create({ Type = "Spell", ID = 236077, isTalent = true    }), -- PvP Talent 
	SpellReflection  					= Action.Create({ Type = "Spell", ID = 216890, isTalent = true    }), -- PvP Talent
	-- Self Defensive
	DiebytheSword						= Action.Create({ Type = "Spell", ID = 118038   }),
	RallyingCry							= Action.Create({ Type = "Spell", ID = 97462    }),
    -- Misc
	BerserkerRage						= Action.Create({ Type = "Spell", ID = 18499    }),
    Victorious							= Action.Create({ Type = "Spell", ID = 32216, Hidden = true     }),
    VictoryRush							= Action.Create({ Type = "Spell", ID = 34428, Hidden = true     }),
	ImpendingVictory					= Action.Create({ Type = "Spell", ID = 202168, Hidden = true     }),
    -- Generics Spells
    Skullsplitter                         = Action.Create({ Type = "Spell", ID = 260643     }),
    DeadlyCalm                            = Action.Create({ Type = "Spell", ID = 262228     }),
    Ravager                               = Action.Create({ Type = "Spell", ID = 152277     }),
    ColossusSmash                         = Action.Create({ Type = "Spell", ID = 167105     }),
    Warbreaker                            = Action.Create({ Type = "Spell", ID = 262161     }),
    Bladestorm                            = Action.Create({ Type = "Spell", ID = 227847     }),
    Cleave                                = Action.Create({ Type = "Spell", ID = 845     }),
    Slam                                  = Action.Create({ Type = "Spell", ID = 1464     }),
    MortalStrike                          = Action.Create({ Type = "Spell", ID = 12294     }),
    Dreadnaught                           = Action.Create({ Type = "Spell", ID = 262150     }),
    --Execute                               = MultiSpell(163201, 281000     }),
    Overpower                             = Action.Create({ Type = "Spell", ID = 7384     }),
    TestofMight                           = Action.Create({ Type = "Spell", ID = 275529     }),
    SweepingStrikes                       = Action.Create({ Type = "Spell", ID = 260708     }),
    Whirlwind                             = Action.Create({ Type = "Spell", ID = 1680     }),
    FervorofBattle                        = Action.Create({ Type = "Spell", ID = 202316     }),
    Rend                                  = Action.Create({ Type = "Spell", ID = 772     }),
    AngerManagement                       = Action.Create({ Type = "Spell", ID = 152278     }),
    SeismicWave                           = Action.Create({ Type = "Spell", ID = 277639     }),
    Charge                                = Action.Create({ Type = "Spell", ID = 100     }),
    HeroicLeap                            = Action.Create({ Type = "Spell", ID = 6544     }),
    LightsJudgment                        = Action.Create({ Type = "Spell", ID = 255647     }),
    Avatar                                = Action.Create({ Type = "Spell", ID = 107574     }),
    Massacre                              = Action.Create({ Type = "Spell", ID = 281001     }),
    ConcentratedFlameBurn                 = Action.Create({ Type = "Spell", ID = 295368     }),
    -- Defensive
	RallyingCry                           = Action.Create({ Type = "Spell", ID = 97462    }),
    -- Misc
    Channeling                           = Action.Create({ Type = "Spell", ID = 209274, Hidden = true     }),
    -- Buffs
    RecklessForceBuff                     = Action.Create({ Type = "Spell", ID = 302932, Hidden = true     }),
    TestofMightBuff                       = Action.Create({ Type = "Spell", ID = 275540, Hidden = true     }),
    SweepingStrikesBuff                   = Action.Create({ Type = "Spell", ID = 260708, Hidden = true     }),
    SuddenDeathBuff                       = Action.Create({ Type = "Spell", ID = 52437, Hidden = true     }),
    StoneHeartBuff                        = Action.Create({ Type = "Spell", ID = 225947, Hidden = true     }),
    ExecutionersPrecisionBuff             = Action.Create({ Type = "Spell", ID = 242188, Hidden = true     }),
    OverpowerBuff                         = Action.Create({ Type = "Spell", ID = 7384, Hidden = true     }),
    CrushingAssaultBuff                   = Action.Create({ Type = "Spell", ID = 278826, Hidden = true     }),
    DeadlyCalmBuff                        = Action.Create({ Type = "Spell", ID = 262228, Hidden = true     }),
    -- Debuffs 
    RazorCoralDebuff                      = Action.Create({ Type = "Spell", ID = 303568, Hidden = true     }),
    ConductiveInkDebuff                   = Action.Create({ Type = "Spell", ID = 302565, Hidden = true     }),
    DeepWoundsDebuff                      = Action.Create({ Type = "Spell", ID = 262115, Hidden = true     }),
    ColossusSmashDebuff                   = Action.Create({ Type = "Spell", ID = 208086, Hidden = true     }),
    RendDebuff                            = Action.Create({ Type = "Spell", ID = 772, Hidden = true     }),
    -- Trinkets    
    TrinketTest                          = Action.Create({ Type = "Trinket", ID = 122530, QueueForbidden = true }),
    TrinketTest2                         = Action.Create({ Type = "Trinket", ID = 159611, QueueForbidden = true }), 
    AzsharasFontofPower                  = Action.Create({ Type = "Trinket", ID = 169314, QueueForbidden = true }),
    PocketsizedComputationDevice         = Action.Create({ Type = "Trinket", ID = 167555 }),
    RotcrustedVoodooDoll                 = Action.Create({ Type = "Trinket", ID = 159624, QueueForbidden = true }),
    ShiverVenomRelic                     = Action.Create({ Type = "Trinket", ID = 168905, QueueForbidden = true }),
    AquipotentNautilus                   = Action.Create({ Type = "Trinket", ID = 169305, QueueForbidden = true }),
    TidestormCodex                       = Action.Create({ Type = "Trinket", ID = 165576, QueueForbidden = true }),
    VialofStorms                         = Action.Create({ Type = "Trinket", ID = 158224, QueueForbidden = true }),
	AshvanesRazorCoral                   = Action.Create({ Type = "Trinket", ID = 169311, QueueForbidden = true }),
    -- Potions
    PotionofUnbridledFury                = Action.Create({ Type = "Potion", ID = 169299, QueueForbidden = true }),
    PotionTest                           = Action.Create({ Type = "Potion", ID = 142117, QueueForbidden = true }),
    -- Misc
    CyclotronicBlast                      = Action.Create({ Type = "Spell", ID = 293491, Hidden = true}),	
	ExecuteDefault                        = Action.Create({ Type = "Spell", ID = 163201, Hidden = true}),
    ExecuteMassacre                       = Action.Create({ Type = "Spell", ID = 281000, Hidden = true}),	
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
Action:CreateEssencesFor(ACTION_CONST_WARRIOR_ARMS)        -- where PLAYERSPEC is Constance (example: ACTION_CONST_MONK_BM)

-- This code making shorter access to both tables Action[PLAYERSPEC] and Action
-- However if you prefer long access it still can be used like Action[PLAYERSPEC].Guard:IsReady() and not ShouldStop, it doesn't make any conflict if you will skip shorter access
-- So with shorter access you can just do A.Guard:IsReady() and not ShouldStop instead of Action[PLAYERSPEC].Guard:IsReady() and not ShouldStop
local A = setmetatable(Action[ACTION_CONST_WARRIOR_ARMS], { __index = Action })

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

-- Stuns
local StunInterrupts = {
  {S.IntimidatingShout, "Cast Intimidating Shout (Interrupt)", function () return true; end},
};

local EnemyRanges = {8, "Melee", 40}
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


local function UpdateExecuteID()
    S.Execute = S.Massacre:IsAvailable() and S.ExecuteMassacre or S.ExecuteDefault
end

local function ExecuteRange()
	return S.Massacre:IsAvailable() and 35 or 20;
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
    S.CondensedLifeforce = S.CondensedLifeforce2:IsAvailable() and S.CondensedLifeforce2 or S.CondensedLifeforce
    S.CondensedLifeforce = S.CondensedLifeforce3:IsAvailable() and S.CondensedLifeforce3 or S.CondensedLifeforce
end

local function Init ()
  HL.RegisterNucleusAbility(152277, 8, 6)               -- Ravager
  HL.RegisterNucleusAbility(227847, 8, 6)               -- Bladestorm
  HL.RegisterNucleusAbility(845, 8, 6)                  -- Cleave
  HL.RegisterNucleusAbility(1680, 8, 6)                 -- Whirlwind
end
Init()

-----------------------------------------
--           PVE ROTATION  
-----------------------------------------

--- ======= ACTION LISTS =======
local function APL(icon) 
    
	-- Action specifics remap
	local ShouldStop = Action.ShouldStop()
	local Pull = Action.BossMods_Pulling()
	
	-- Local functions remap
    UpdateRanges()
    HL.GetEnemies(40, true) -- To populate Cache.Enemies[40] for CastCycles
    UpdateExecuteID()
	ExecuteRange()
	DetermineEssenceRanks()
	
	if Player:IsCasting() or Player:IsChanneling() then
	    ShouldStop = true
	else
	    ShouldStop = false
	end
	
    local function Precombat_DBM()
        -- flask
        -- food
        -- augmentation
        -- snapshot_stats
        if Everyone.TargetIsValid() then
		    -- use_item,name=azsharas_font_of_power
            if I.AzsharasFontofPower:IsEquipReady() and TR.TrinketON() and Pull > 1 and Pull <= 6 then
                if HR.Cast(I.AzsharasFontofPower) then return "azsharas_font_of_power 7"; end
            end
            -- memory_of_lucid_dreams
            if S.MemoryofLucidDreams:IsCastableP() and Action.GetToggle(1, "HeartOfAzeroth") and not ShouldStop and Pull > 0.1 and Pull <= 1 then
                if HR.Cast(S.MemoryofLucidDreams) then return "memory_of_lucid_dreams"; end
            end
            -- guardian_of_azeroth
            if S.GuardianofAzeroth:IsCastableP() and Action.GetToggle(1, "HeartOfAzeroth") and not ShouldStop and Pull > 0.1 and Pull <= 1 then
                if HR.Cast(S.GuardianofAzeroth) then return "guardian_of_azeroth"; end
            end
            -- potion
            if I.PotionofUnbridledFury:IsReady() and not ShouldStop and Action.GetToggle(1, "Potion") and Pull > 0.1 + Player:GCD() and Pull < 0.5 + Player:GCD() then
                if HR.Cast(I.PotionofUnbridledFury) then return "battle_potion_of_strength 4"; end
            end
        end
    end    
    local function Precombat()
        -- flask
        -- food
        -- augmentation
        -- snapshot_stats
        if Everyone.TargetIsValid() then
            -- use_item,name=azsharas_font_of_power
            if I.AzsharasFontofPower:IsEquipReady() and TR.TrinketON() then
                if HR.Cast(I.AzsharasFontofPower) then return "azsharas_font_of_power"; end
            end
            -- memory_of_lucid_dreams
            if S.MemoryofLucidDreams:IsCastableP() and Action.GetToggle(1, "HeartOfAzeroth") and not ShouldStop then
                if HR.Cast(S.MemoryofLucidDreams) then return "memory_of_lucid_dreams"; end
            end
            -- guardian_of_azeroth
            if S.GuardianofAzeroth:IsCastableP() and Action.GetToggle(1, "HeartOfAzeroth") and not ShouldStop then
                if HR.Cast(S.GuardianofAzeroth) then return "guardian_of_azeroth"; end
            end
            -- potion
            if I.PotionofUnbridledFury:IsReady() and not ShouldStop and Action.GetToggle(1, "Potion") then
                if HR.Cast(I.PotionofUnbridledFury) then return "battle_potion_of_strength 4"; end
            end
        end
    end
    local function Movement()
        -- heroic_leap
        if S.HeroicLeap:IsCastableP() and not ShouldStop then
            if HR.Cast(S.HeroicLeap, Action.GetToggle(2, "OffGCDasOffGCD")) then return "heroic_leap 16"; end
        end
    end
    local function Execute()
        -- skullsplitter,if=rage<60&buff.deadly_calm.down&buff.memory_of_lucid_dreams.down
        if S.Skullsplitter:IsCastableP("Melee") and not ShouldStop and (Player:Rage() < 60 and Player:BuffDownP(S.DeadlyCalmBuff) and Player:BuffDownP(S.MemoryofLucidDreams)) then
            if HR.Cast(S.Skullsplitter) then return "skullsplitter 6"; end
        end
        -- ravager,if=!buff.deadly_calm.up&(cooldown.colossus_smash.remains<2|(talent.warbreaker.enabled&cooldown.warbreaker.remains<2))
        if S.Ravager:IsCastableP(40) and not ShouldStop and HR.CDsON() and (not Player:BuffP(S.DeadlyCalmBuff) and (S.ColossusSmash:CooldownRemainsP() < 2 or (S.Warbreaker:IsAvailable() and S.Warbreaker:CooldownRemainsP() < 2))) then
            if HR.Cast(S.Ravager, Action.GetToggle(2, "OffGCDasOffGCD")) then return "ravager 12"; end
        end
        -- colossus_smash,if=!essence.memory_of_lucid_dreams.major|(buff.memory_of_lucid_dreams.up|cooldown.memory_of_lucid_dreams.remains>10)
        if S.ColossusSmash:IsCastableP("Melee") and not ShouldStop and (not S.MemoryofLucidDreams:IsAvailable() or (Player:BuffP(S.MemoryofLucidDreams) or S.MemoryofLucidDreams:CooldownRemainsP() > 10)) then
            if HR.Cast(S.ColossusSmash) then return "colossus_smash 22"; end
        end
        -- warbreaker,if=!essence.memory_of_lucid_dreams.major|(buff.memory_of_lucid_dreams.up|cooldown.memory_of_lucid_dreams.remains>10)
        if S.Warbreaker:IsCastableP("Melee") and not ShouldStop and (not S.MemoryofLucidDreams:IsAvailable() or (Player:BuffP(S.MemoryofLucidDreams) or S.MemoryofLucidDreams:CooldownRemainsP() > 10)) then
            if HR.Cast(S.Warbreaker, Action.GetToggle(2, "OffGCDasOffGCD")) then return "warbreaker 26"; end
        end
        -- deadly_calm
        if S.DeadlyCalm:IsCastableP() and not ShouldStop then
            if HR.Cast(S.DeadlyCalm, Action.GetToggle(2, "OffGCDasOffGCD")) then return "deadly_calm 30"; end
        end
        -- bladestorm,if=!buff.memory_of_lucid_dreams.up&buff.test_of_might.up&rage<30&!buff.deadly_calm.up
        if S.Bladestorm:IsCastableP() and not ShouldStop and HR.CDsON() and (Player:BuffDownP(S.MemoryofLucidDreams) and Player:BuffP(S.TestofMightBuff) and Player:Rage() < 30 and Player:BuffDownP(S.DeadlyCalmBuff)) then
            if HR.Cast(S.Bladestorm, Action.GetToggle(2, "OffGCDasOffGCD")) then return "bladestorm 32"; end
        end
        -- cleave,if=spell_targets.whirlwind>2
        if S.Cleave:IsReadyP("Melee") and not ShouldStop and (Cache.EnemiesCount[8] > 2) then
            if HR.Cast(S.Cleave) then return "cleave 36"; end
        end
        -- slam,if=buff.crushing_assault.up&buff.memory_of_lucid_dreams.down
        if S.Slam:IsReadyP("Melee") and not ShouldStop and (Player:BuffP(S.CrushingAssaultBuff) and Player:BuffDownP(S.MemoryofLucidDreams)) then
            if HR.Cast(S.Slam) then return "slam 38"; end
        end
        -- mortal_strike,if=buff.overpower.stack=2&talent.dreadnaught.enabled|buff.executioners_precision.stack=2
        if S.MortalStrike:IsReadyP("Melee") and not ShouldStop and (Player:BuffStackP(S.OverpowerBuff) == 2 and S.Dreadnaught:IsAvailable() or Player:BuffStackP(S.ExecutionersPrecisionBuff) == 2) then
            if HR.Cast(S.MortalStrike) then return "mortal_strike 42"; end
        end
        -- execute,if=buff.memory_of_lucid_dreams.up|buff.deadly_calm.up
        if S.Execute:IsReady("Melee") and not ShouldStop and (Player:BuffP(S.MemoryofLucidDreams) or Player:BuffP(S.DeadlyCalmBuff)) then
            if HR.Cast(S.Execute) then return "execute 50"; end
        end
        -- overpower
        if S.Overpower:IsCastableP("Melee") and not ShouldStop then
            if HR.Cast(S.Overpower) then return "overpower 54"; end
        end
        -- execute
        if S.Execute:IsReady("Melee") and not ShouldStop then
            if HR.Cast(S.Execute) then return "execute 56"; end
        end
    end
    local function FiveTarget()
        -- skullsplitter,if=rage<60&(!talent.deadly_calm.enabled|buff.deadly_calm.down)
        if S.Skullsplitter:IsCastableP("Melee") and not ShouldStop and (Player:Rage() < 60 and (not S.DeadlyCalm:IsAvailable() or Player:BuffDownP(S.DeadlyCalmBuff))) then
            if HR.Cast(S.Skullsplitter) then return "skullsplitter 58"; end
        end
        -- ravager,if=(!talent.warbreaker.enabled|cooldown.warbreaker.remains<2)
        if S.Ravager:IsCastableP(40) and not ShouldStop and HR.CDsON() and ((not S.Warbreaker:IsAvailable() or S.Warbreaker:CooldownRemainsP() < 2)) then
            if HR.Cast(S.Ravager, Action.GetToggle(2, "OffGCDasOffGCD")) then return "ravager 64"; end
        end
        -- colossus_smash,if=debuff.colossus_smash.down
        if S.ColossusSmash:IsCastableP("Melee") and not ShouldStop and (Target:DebuffDownP(S.ColossusSmashDebuff)) then
            if HR.Cast(S.ColossusSmash) then return "colossus_smash 70"; end
        end
        -- warbreaker,if=debuff.colossus_smash.down
        if S.Warbreaker:IsCastableP("Melee") and not ShouldStop and (Target:DebuffDownP(S.ColossusSmashDebuff)) then
            if HR.Cast(S.Warbreaker, Action.GetToggle(2, "OffGCDasOffGCD")) then return "warbreaker 74"; end
        end
        -- bladestorm,if=buff.sweeping_strikes.down&(!talent.deadly_calm.enabled|buff.deadly_calm.down)&((debuff.colossus_smash.remains>4.5&!azerite.test_of_might.enabled)|buff.test_of_might.up)
        if S.Bladestorm:IsCastableP() and not ShouldStop and HR.CDsON() and (Player:BuffDownP(S.SweepingStrikesBuff) and (not S.DeadlyCalm:IsAvailable() or Player:BuffDownP(S.DeadlyCalmBuff)) and ((Target:DebuffRemainsP(S.ColossusSmashDebuff) > 4.5 and not S.TestofMight:AzeriteEnabled()) or Player:BuffP(S.TestofMightBuff))) then
            if HR.Cast(S.Bladestorm, Action.GetToggle(2, "OffGCDasOffGCD")) then return "bladestorm 78"; end
        end
        -- deadly_calm
        if S.DeadlyCalm:IsCastableP() and not ShouldStop then
            if HR.Cast(S.DeadlyCalm, Action.GetToggle(2, "OffGCDasOffGCD")) then return "deadly_calm 92"; end
        end
        -- cleave
        if S.Cleave:IsReadyP("Melee") and not ShouldStop then
            if HR.Cast(S.Cleave) then return "cleave 94"; end
        end
        -- execute,if=(!talent.cleave.enabled&dot.deep_wounds.remains<2)|(buff.sudden_death.react|buff.stone_heart.react)&(buff.sweeping_strikes.up|cooldown.sweeping_strikes.remains>8)
        if S.Execute:IsReady("Melee") and not ShouldStop and ((not S.Cleave:IsAvailable() and Target:DebuffRemainsP(S.DeepWoundsDebuff) < 2) or (Player:BuffP(S.SuddenDeathBuff) or Player:BuffP(S.StoneHeartBuff)) and (Player:BuffP(S.SweepingStrikesBuff) or S.SweepingStrikes:CooldownRemainsP() > 8)) then
            if HR.Cast(S.Execute) then return "execute 96"; end
        end
        -- mortal_strike,if=(!talent.cleave.enabled&dot.deep_wounds.remains<2)|buff.sweeping_strikes.up&buff.overpower.stack=2&(talent.dreadnaught.enabled|buff.executioners_precision.stack=2)
        if S.MortalStrike:IsReadyP("Melee") and not ShouldStop and ((not S.Cleave:IsAvailable() and Target:DebuffRemainsP(S.DeepWoundsDebuff) < 2) or Player:BuffP(S.SweepingStrikesBuff) and Player:BuffStackP(S.OverpowerBuff) == 2 and (S.Dreadnaught:IsAvailable() or Player:BuffStackP(S.ExecutionersPrecisionBuff) == 2)) then
            if HR.Cast(S.MortalStrike) then return "mortal_strike 110"; end
        end
        -- whirlwind,if=debuff.colossus_smash.up|(buff.crushing_assault.up&talent.fervor_of_battle.enabled)
        if S.Whirlwind:IsReadyP("Melee") and not ShouldStop and (Target:DebuffP(S.ColossusSmashDebuff) or (Player:BuffP(S.CrushingAssaultBuff) and S.FervorofBattle:IsAvailable())) then
            if HR.Cast(S.Whirlwind) then return "whirlwind 124"; end
        end
        -- whirlwind,if=buff.deadly_calm.up|rage>60
        if S.Whirlwind:IsReadyP("Melee") and not ShouldStop and (Player:BuffP(S.DeadlyCalmBuff) or Player:Rage() > 60) then
            if HR.Cast(S.Whirlwind) then return "whirlwind 132"; end
        end
        -- overpower
        if S.Overpower:IsCastableP("Melee") and not ShouldStop then
            if HR.Cast(S.Overpower) then return "overpower 136"; end
        end
        -- whirlwind
        if S.Whirlwind:IsReadyP("Melee") and not ShouldStop then
            if HR.Cast(S.Whirlwind) then return "whirlwind 138"; end
        end
    end
    local function Hac()
        -- rend,if=remains<=duration*0.3&(!raid_event.adds.up|buff.sweeping_strikes.up)
        if S.Rend:IsReadyP("Melee") and not ShouldStop and (Target:DebuffRemainsP(S.RendDebuff) <= S.RendDebuff:BaseDuration() * 0.3 and (not (Cache.EnemiesCount[8] > 1) or Player:BuffP(S.SweepingStrikesBuff))) then
            if HR.Cast(S.Rend) then return "rend 140"; end
        end
        -- skullsplitter,if=rage<60&(cooldown.deadly_calm.remains>3|!talent.deadly_calm.enabled)
        if S.Skullsplitter:IsCastableP("Melee") and not ShouldStop and (Player:Rage() < 60 and (S.DeadlyCalm:CooldownRemainsP() > 3 or not S.DeadlyCalm:IsAvailable())) then
            if HR.Cast(S.Skullsplitter) then return "skullsplitter 158"; end
        end
        -- deadly_calm,if=(cooldown.bladestorm.remains>6|talent.ravager.enabled&cooldown.ravager.remains>6)&(cooldown.colossus_smash.remains<2|(talent.warbreaker.enabled&cooldown.warbreaker.remains<2))
        if S.DeadlyCalm:IsCastableP() and not ShouldStop and ((S.Bladestorm:CooldownRemainsP() > 6 or S.Ravager:IsAvailable() and S.Ravager:CooldownRemainsP() > 6) and (S.ColossusSmash:CooldownRemainsP() < 2 or (S.Warbreaker:IsAvailable() and S.Warbreaker:CooldownRemainsP() < 2))) then
            if HR.Cast(S.DeadlyCalm, Action.GetToggle(2, "OffGCDasOffGCD")) then return "deadly_calm 164"; end
        end
        -- ravager,if=(raid_event.adds.up|raid_event.adds.in>target.time_to_die)&(cooldown.colossus_smash.remains<2|(talent.warbreaker.enabled&cooldown.warbreaker.remains<2))
        if S.Ravager:IsCastableP(40) and not ShouldStop and HR.CDsON() and (((Cache.EnemiesCount[8] > 1) or 10000000000 > Target:TimeToDie()) and (S.ColossusSmash:CooldownRemainsP() < 2 or (S.Warbreaker:IsAvailable() and S.Warbreaker:CooldownRemainsP() < 2))) then
            if HR.Cast(S.Ravager, Action.GetToggle(2, "OffGCDasOffGCD")) then return "ravager 178"; end
        end
        -- colossus_smash,if=raid_event.adds.up|raid_event.adds.in>40|(raid_event.adds.in>20&talent.anger_management.enabled)
        if S.ColossusSmash:IsCastableP("Melee") and not ShouldStop and ((Cache.EnemiesCount[8] > 1) or 10000000000 > 40 or (10000000000 > 20 and S.AngerManagement:IsAvailable())) then
            if HR.Cast(S.ColossusSmash) then return "colossus_smash 188"; end
        end
        -- warbreaker,if=raid_event.adds.up|raid_event.adds.in>40|(raid_event.adds.in>20&talent.anger_management.enabled)
        if S.Warbreaker:IsCastableP("Melee") and not ShouldStop and ((Cache.EnemiesCount[8] > 1) or 10000000000 > 40 or (10000000000 > 20 and S.AngerManagement:IsAvailable())) then
            if HR.Cast(S.Warbreaker, Action.GetToggle(2, "OffGCDasOffGCD")) then return "warbreaker 194"; end
        end
        -- bladestorm,if=(debuff.colossus_smash.up&raid_event.adds.in>target.time_to_die)|raid_event.adds.up&((debuff.colossus_smash.remains>4.5&!azerite.test_of_might.enabled)|buff.test_of_might.up)
        if S.Bladestorm:IsCastableP() and not ShouldStop and HR.CDsON() and ((Target:DebuffP(S.ColossusSmashDebuff) and 10000000000 > Target:TimeToDie()) or (Cache.EnemiesCount[8] > 1) and ((Target:DebuffRemainsP(S.ColossusSmashDebuff) > 4.5 and not S.TestofMight:AzeriteEnabled()) or Player:BuffP(S.TestofMightBuff))) then
            if HR.Cast(S.Bladestorm, Action.GetToggle(2, "OffGCDasOffGCD")) then return "bladestorm 200"; end
        end
        -- overpower,if=!raid_event.adds.up|(raid_event.adds.up&azerite.seismic_wave.enabled)
        if S.Overpower:IsCastableP("Melee") and not ShouldStop and (not (Cache.EnemiesCount[8] > 1) or ((Cache.EnemiesCount[8] > 1) and S.SeismicWave:AzeriteEnabled())) then
            if HR.Cast(S.Overpower) then return "overpower 212"; end
        end
        -- cleave,if=spell_targets.whirlwind>2
        if S.Cleave:IsReadyP("Melee") and not ShouldStop and (Cache.EnemiesCount[8] > 2) then
            if HR.Cast(S.Cleave) then return "cleave 220"; end
        end
        -- execute,if=!raid_event.adds.up|(!talent.cleave.enabled&dot.deep_wounds.remains<2)|buff.sudden_death.react
        if S.Execute:IsReady("Melee") and not ShouldStop and ((not S.Cleave:IsAvailable() and Target:DebuffRemainsP(S.DeepWoundsDebuff) < 2) or Player:BuffStackP(S.SuddenDeathBuff)) then
            if HR.Cast(S.Execute) then return "execute 222"; end
        end
        -- mortal_strike,if=!raid_event.adds.up|(!talent.cleave.enabled&dot.deep_wounds.remains<2)
        if S.MortalStrike:IsReadyP("Melee") and not ShouldStop and (not S.Cleave:IsAvailable() and Target:DebuffRemainsP(S.DeepWoundsDebuff) < 2) then
            if HR.Cast(S.MortalStrike) then return "mortal_strike 232"; end
        end
        -- whirlwind,if=raid_event.adds.up
        if S.Whirlwind:IsReadyP("Melee") and not ShouldStop then
            if HR.Cast(S.Whirlwind) then return "whirlwind 240"; end
        end
        -- overpower
        if S.Overpower:IsCastableP("Melee") and not ShouldStop then
            if HR.Cast(S.Overpower) then return "overpower 244"; end
        end
        -- whirlwind,if=talent.fervor_of_battle.enabled
        if S.Whirlwind:IsReadyP("Melee") and not ShouldStop and (S.FervorofBattle:IsAvailable()) then
            if HR.Cast(S.Whirlwind) then return "whirlwind 246"; end
        end
        -- slam,if=!talent.fervor_of_battle.enabled&!raid_event.adds.up
        if S.Slam:IsReadyP("Melee") and not ShouldStop and (not S.FervorofBattle:IsAvailable()) then
            if HR.Cast(S.Slam) then return "slam 250"; end
        end
    end
    local function SingleTarget()
        -- rend,if=remains<=duration*0.3&debuff.colossus_smash.down
        if S.Rend:IsReadyP("Melee") and not ShouldStop and (Target:DebuffRemainsP(S.RendDebuff) <= S.RendDebuff:BaseDuration() * 0.3 and Target:DebuffDownP(S.ColossusSmashDebuff)) then
            if HR.Cast(S.Rend) then return "rend 256"; end
        end
        -- skullsplitter,if=rage<60&buff.deadly_calm.down&buff.memory_of_lucid_dreams.down
        if S.Skullsplitter:IsCastableP("Melee") and not ShouldStop and (Player:Rage() < 60 and Player:BuffDownP(S.DeadlyCalmBuff) and Player:BuffDownP(S.MemoryofLucidDreams)) then
            if HR.Cast(S.Skullsplitter) then return "skullsplitter 272"; end
        end
        -- ravager,if=!buff.deadly_calm.up&(cooldown.colossus_smash.remains<2|(talent.warbreaker.enabled&cooldown.warbreaker.remains<2))
        if S.Ravager:IsCastableP(40) and not ShouldStop and HR.CDsON() and (not Player:BuffP(S.DeadlyCalmBuff) and (S.ColossusSmash:CooldownRemainsP() < 2 or (S.Warbreaker:IsAvailable() and S.Warbreaker:CooldownRemainsP() < 2))) then
            if HR.Cast(S.Ravager, Action.GetToggle(2, "OffGCDasOffGCD")) then return "ravager 278"; end
        end
        -- colossus_smash,if=!essence.memory_of_lucid_dreams.major|(buff.memory_of_lucid_dreams.up|cooldown.memory_of_lucid_dreams.remains>10)
        if S.ColossusSmash:IsCastableP("Melee") and not ShouldStop and (not S.MemoryofLucidDreams:IsAvailable() or (Player:BuffP(S.MemoryofLucidDreams) or S.MemoryofLucidDreams:CooldownRemainsP() > 10)) then
            if HR.Cast(S.ColossusSmash) then return "colossus_smash 288"; end
        end
        -- warbreaker,if=!essence.memory_of_lucid_dreams.major|(buff.memory_of_lucid_dreams.up|cooldown.memory_of_lucid_dreams.remains>10)
        if S.Warbreaker:IsCastableP("Melee") and not ShouldStop and (not S.MemoryofLucidDreams:IsAvailable() or (Player:BuffP(S.MemoryofLucidDreams) or S.MemoryofLucidDreams:CooldownRemainsP() > 10)) then
            if HR.Cast(S.Warbreaker, Action.GetToggle(2, "OffGCDasOffGCD")) then return "warbreaker 292"; end
        end
        -- deadly_calm
        if S.DeadlyCalm:IsCastableP() and not ShouldStop then
            if HR.Cast(S.DeadlyCalm, Action.GetToggle(2, "OffGCDasOffGCD")) then return "deadly_calm 296"; end
        end
        -- execute,if=buff.sudden_death.react
        if S.Execute:IsReady("Melee") and not ShouldStop and (Player:BuffP(S.SuddenDeathBuff)) then
            if HR.Cast(S.Execute) then return "execute 298"; end
        end
        -- bladestorm,if=cooldown.mortal_strike.remains&(!talent.deadly_calm.enabled|buff.deadly_calm.down)&((debuff.colossus_smash.up&!azerite.test_of_might.enabled)|buff.test_of_might.up)&buff.memory_of_lucid_dreams.down
        if S.Bladestorm:IsCastableP() and not ShouldStop and HR.CDsON() and (bool(S.MortalStrike:CooldownRemainsP()) and (not S.DeadlyCalm:IsAvailable() or Player:BuffDownP(S.DeadlyCalmBuff)) and ((Target:DebuffP(S.ColossusSmashDebuff) and not S.TestofMight:AzeriteEnabled()) or Player:BuffP(S.TestofMightBuff)) and Player:BuffDownP(S.MemoryofLucidDreams)) then
            if HR.Cast(S.Bladestorm, Action.GetToggle(2, "OffGCDasOffGCD")) then return "bladestorm 302"; end
        end
        -- cleave,if=spell_targets.whirlwind>2
        if S.Cleave:IsReadyP("Melee") and not ShouldStop and (Cache.EnemiesCount[8] > 2) then
            if HR.Cast(S.Cleave) then return "cleave 316"; end
        end
        -- overpower,if=rage<30&buff.memory_of_lucid_dreams.up&debuff.colossus_smash.up
        if S.Overpower:IsCastableP("Melee") and not ShouldStop and (Player:Rage() < 30 and Player:BuffP(S.MemoryofLucidDreams) and Target:DebuffP(S.ColossusSmashDebuff)) then
            if HR.Cast(S.Overpower) then return "overpower 318"; end
        end
        -- mortal_strike
        if S.MortalStrike:IsReadyP("Melee") and not ShouldStop then
            if HR.Cast(S.MortalStrike) then return "mortal_strike 322"; end
        end
        -- whirlwind,if=talent.fervor_of_battle.enabled&(buff.memory_of_lucid_dreams.up|buff.deadly_calm.up)
        if S.Whirlwind:IsReadyP("Melee") and not ShouldStop and (S.FervorofBattle:IsAvailable() and (Player:BuffP(S.MemoryofLucidDreams) or Player:BuffP(S.DeadlyCalmBuff))) then
            if HR.Cast(S.Whirlwind) then return "whirlwind 324"; end
        end
        -- overpower
        if S.Overpower:IsCastableP("Melee") and not ShouldStop then
            if HR.Cast(S.Overpower) then return "overpower 330"; end
        end
        -- whirlwind,if=talent.fervor_of_battle.enabled
        if S.Whirlwind:IsReadyP("Melee") and not ShouldStop and (S.FervorofBattle:IsAvailable()) then
            if HR.Cast(S.Whirlwind) then return "whirlwind 332"; end
        end
        -- slam,if=!talent.fervor_of_battle.enabled
        if S.Slam:IsReadyP("Melee") and not ShouldStop and (not S.FervorofBattle:IsAvailable()) then
            if HR.Cast(S.Slam) then return "slam 340"; end
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
        -- auto_attack

		-- Interrupt Handler
  		local unit = "target"
   		local useKick, useCC, useRacial = Action.InterruptIsValid(unit, "TargetMouseover")    
        local Trinket1IsAllowed, Trinket2IsAllowed = TR.TrinketIsAllowed()
		
  	    -- Pummel
  	    if useKick and S.Pummel:IsReady() and Target:IsInRange(5) and not ShouldStop then 
		  	if ActionUnit(unit):CanInterrupt(true, nil, 25, 70) then
          	    if HR.Cast(S.Pummel, true) then return "Pummel 5"; end
         	end 
      	end 
        -- charge
        if S.Charge:IsReadyP() and not ShouldStop and S.Charge:ChargesP() >= 1 and Target:MaxDistanceToPlayer(true) >= 8 then
            if HR.Cast(S.Charge, Action.GetToggle(2, "OffGCDasOffGCD")) then return "charge 351"; end
        end
        -- auto_attack
        if ((not Target:IsInRange("Melee")) and Target:IsInRange(40)) then
            return Movement();
        end
        -- potion
        if I.PotionofUnbridledFury:IsReady() and not ShouldStop and Action.GetToggle(1, "Potion") then
            if HR.Cast(I.PotionofUnbridledFury) then return "battle_potion_of_strength 354"; end
        end
        -- blood_fury,if=debuff.colossus_smash.up
        if S.BloodFury:IsCastableP() and not ShouldStop and HR.CDsON() and (Target:DebuffP(S.ColossusSmashDebuff)) then
            if HR.Cast(S.BloodFury, Action.GetToggle(2, "OffGCDasOffGCD")) then return "blood_fury 356"; end
        end
        -- berserking,if=debuff.colossus_smash.up
        if S.Berserking:IsCastableP() and not ShouldStop and HR.CDsON() and (Target:DebuffP(S.ColossusSmashDebuff)) then
            if HR.Cast(S.Berserking, Action.GetToggle(2, "OffGCDasOffGCD")) then return "berserking 360"; end
        end
        -- arcane_torrent,if=debuff.colossus_smash.down&cooldown.mortal_strike.remains>1.5&rage<50
        if S.ArcaneTorrent:IsCastableP() and not ShouldStop and HR.CDsON() and (Target:DebuffDownP(S.ColossusSmashDebuff) and S.MortalStrike:CooldownRemainsP() > 1.5 and Player:Rage() < 50) then
            if HR.Cast(S.ArcaneTorrent, Action.GetToggle(2, "OffGCDasOffGCD")) then return "arcane_torrent 364"; end
        end
        -- lights_judgment,if=debuff.colossus_smash.down
        if S.LightsJudgment:IsCastableP() and not ShouldStop and HR.CDsON() and (Target:DebuffDownP(S.ColossusSmashDebuff)) then
            if HR.Cast(S.LightsJudgment) then return "lights_judgment 370"; end
        end
        -- fireblood,if=debuff.colossus_smash.up
        if S.Fireblood:IsCastableP() and not ShouldStop and HR.CDsON() and (Target:DebuffP(S.ColossusSmashDebuff)) then
            if HR.Cast(S.Fireblood, Action.GetToggle(2, "OffGCDasOffGCD")) then return "fireblood 374"; end
        end
        -- ancestral_call,if=debuff.colossus_smash.up
        if S.AncestralCall:IsCastableP() and not ShouldStop and HR.CDsON() and (Target:DebuffP(S.ColossusSmashDebuff)) then
            if HR.Cast(S.AncestralCall, Action.GetToggle(2, "OffGCDasOffGCD")) then return "ancestral_call 378"; end
        end
        -- use_item,name=ashvanes_razor_coral,if=debuff.razor_coral_debuff.down|(debuff.conductive_ink_debuff.up|buff.metamorphosis.remains>20)&target.health.pct<31|target.time_to_die<20
        if I.AshvanesRazorCoral:IsEquipped() and I.AshvanesRazorCoral:IsReady() and TR.TrinketON() and ActionUnit("target"):IsBoss() and (not Target:DebuffP(S.RazorCoralDebuff) or Target:DebuffP(S.RazorCoralDebuff) and Target:HealthPercentage() <= 30) then
            if HR.Cast(I.AshvanesRazorCoral) then return "ashvanes_razor_coral 59"; end
        end
        -- use_item,name=ashvanes_razor_coral,if=debuff.razor_coral_debuff.down|(debuff.conductive_ink_debuff.up|buff.metamorphosis.remains>20)&target.health.pct<31|target.time_to_die<20
        if I.AshvanesRazorCoral:IsEquipped() and I.AshvanesRazorCoral:IsReady() and TR.TrinketON() and (not Target:DebuffP(S.RazorCoralDebuff) or Target:DebuffP(S.RazorCoralDebuff) and Target:HealthPercentage() <= 30 and Target:TimeToDie() >= 10) then
            if HR.Cast(I.AshvanesRazorCoral) then return "ashvanes_razor_coral 59"; end
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
        -- avatar,if=cooldown.colossus_smash.remains<8|(talent.warbreaker.enabled&cooldown.warbreaker.remains<8)
        if S.Avatar:IsCastableP() and not ShouldStop and HR.CDsON() and (S.ColossusSmash:CooldownRemainsP() < 8 or (S.Warbreaker:IsAvailable() and S.Warbreaker:CooldownRemainsP() < 8)) then
            if HR.Cast(S.Avatar, Action.GetToggle(2, "OffGCDasOffGCD")) then return "avatar 382"; end
        end
        -- sweeping_strikes,if=spell_targets.whirlwind>1&(cooldown.bladestorm.remains>10|cooldown.colossus_smash.remains>8|azerite.test_of_might.enabled)
        if S.SweepingStrikes:IsCastableP() and not ShouldStop and (Cache.EnemiesCount[8] > 1 and (S.Bladestorm:CooldownRemainsP() > 10 or S.ColossusSmash:CooldownRemainsP() > 8 or S.TestofMight:AzeriteEnabled())) then
            if HR.Cast(S.SweepingStrikes) then return "sweeping_strikes 390"; end
        end
        -- blood_of_the_enemy,if=buff.test_of_might.up|(debuff.colossus_smash.up&!azerite.test_of_might.enabled)
        if S.BloodoftheEnemy:IsCastableP() and Action.GetToggle(1, "HeartOfAzeroth") and not ShouldStop and (Player:BuffP(S.TestofMightBuff) or (Target:DebuffP(S.ColossusSmashDebuff) and not S.TestofMight:IsAvailable())) then
            if HR.Cast(S.BloodoftheEnemy) then return "blood_of_the_enemy"; end
        end
        -- purifying_blast,if=!debuff.colossus_smash.up&!buff.test_of_might.up
        if S.PurifyingBlast:IsCastableP() and Action.GetToggle(1, "HeartOfAzeroth") and not ShouldStop and (not Target:DebuffP(S.ColossusSmashDebuff) and not Player:BuffP(S.TestofMightBuff)) then
            if HR.Cast(S.PurifyingBlast) then return "purifying_blast"; end
        end
        -- ripple_in_space,if=!debuff.colossus_smash.up&!buff.test_of_might.up
        if S.RippleInSpace:IsCastableP() and Action.GetToggle(1, "HeartOfAzeroth") and not ShouldStop and (not Target:DebuffP(S.ColossusSmashDebuff) and not Player:BuffP(S.TestofMightBuff)) then
            if HR.Cast(S.RippleInSpace) then return "ripple_in_space"; end
        end
        -- worldvein_resonance,if=!debuff.colossus_smash.up&!buff.test_of_might.up
        if S.WorldveinResonance:IsCastableP() and Action.GetToggle(1, "HeartOfAzeroth") and not ShouldStop and (not Target:DebuffP(S.ColossusSmashDebuff) and not Player:BuffP(S.TestofMightBuff)) then
            if HR.Cast(S.WorldveinResonance) then return "worldvein_resonance"; end
        end
        -- focused_azerite_beam,if=!debuff.colossus_smash.up&!buff.test_of_might.up
        if S.FocusedAzeriteBeam:IsCastableP() and (Cache.EnemiesCount[8] >= 4 or ActionUnit("target"):IsBoss()) and Action.GetToggle(1, "HeartOfAzeroth") and not ShouldStop and (not Target:DebuffP(S.ColossusSmashDebuff) and not Player:BuffP(S.TestofMightBuff)) then
            if HR.Cast(S.FocusedAzeriteBeam) then return "focused_azerite_beam"; end
        end
        -- concentrated_flame,if=!debuff.colossus_smash.up&!buff.test_of_might.up&dot.concentrated_flame_burn.remains=0
        if S.ConcentratedFlame:IsCastableP() and Action.GetToggle(1, "HeartOfAzeroth") and not ShouldStop and (Target:DebuffDownP(S.ColossusSmashDebuff) and Player:BuffDownP(S.TestofMightBuff) and Target:DebuffDownP(S.ConcentratedFlameBurn)) then
            if HR.Cast(S.ConcentratedFlame) then return "concentrated_flame"; end
        end
        -- the_unbound_force,if=buff.reckless_force.up
        if S.TheUnboundForce:IsCastableP() and Action.GetToggle(1, "HeartOfAzeroth") and not ShouldStop and (Player:BuffP(S.RecklessForceBuff)) then
            if HR.Cast(S.TheUnboundForce) then return "the_unbound_force"; end
        end
        -- guardian_of_azeroth,if=cooldown.colossus_smash.remains<10
        if S.GuardianofAzeroth:IsCastableP() and Action.GetToggle(1, "HeartOfAzeroth") and not ShouldStop and (S.ColossusSmash:CooldownRemainsP() < 10) then
            if HR.Cast(S.GuardianofAzeroth) then return "guardian_of_azeroth"; end
        end
        -- memory_of_lucid_dreams,if=!talent.warbreaker.enabled&cooldown.colossus_smash.remains<3|cooldown.warbreaker.remains<3
        if S.MemoryofLucidDreams:IsCastableP() and Action.GetToggle(1, "HeartOfAzeroth") and not ShouldStop and (not S.Warbreaker:IsAvailable() and S.ColossusSmash:CooldownRemainsP() < 3 or S.Warbreaker:CooldownRemainsP() < 3) then
            if HR.Cast(S.MemoryofLucidDreams) then return "memory_of_lucid_dreams"; end
        end
        -- execute,if=buff.sudden_death.react
        if S.Execute:IsReady("Melee") and not ShouldStop and (Player:BuffP(S.SuddenDeathBuff)) then
            if HR.Cast(S.Execute) then return "execute 298"; end
        end
        -- run_action_list,name=hac,if=raid_event.adds.exists
        if (Cache.EnemiesCount[8] > 1) then
            return Hac();
        end
        -- run_action_list,name=five_target,if=spell_targets.whirlwind>4
        if (Cache.EnemiesCount[8] > 4) then
            return FiveTarget();
        end
        -- run_action_list,name=execute,if=(talent.massacre.enabled&target.health.pct<35)|target.health.pct<20
        if ((S.Massacre:IsAvailable() and Target:HealthPercentage() < 35) or Target:HealthPercentage() < 20) then
            return Execute();
        end
        -- run_action_list,name=single_target
        if (true) then
            return SingleTarget();
        end
    end
end
-- Finished



-----------------------------------------
--           PVP ROTATION  
-----------------------------------------
-- Locals
local Temp                                     = {
    TotalAndPhys                            = {"TotalImun", "DamagePhysImun"},
    TotalAndPhysKick                        = {"TotalImun", "DamagePhysImun", "KickImun"},
    TotalAndPhysAndCC                        = {"TotalImun", "DamagePhysImun", "CCTotalImun"},
    TotalAndPhysAndStun                     = {"TotalImun", "DamagePhysImun", "StunImun"},
    TotalAndPhysAndCCAndStun                 = {"TotalImun", "DamagePhysImun", "CCTotalImun", "StunImun"},
    TotalAndMag                                = {"TotalImun", "DamageMagicImun"},
    DisablePhys                                = {"TotalImun", "DamagePhysImun", "Freedom", "CCTotalImun"},
    DisableMag                                = {"TotalImun", "DamageMagicImun", "Freedom", "CCTotalImun"},
}

local IsIndoors, UnitIsUnit = 
IsIndoors, UnitIsUnit

local function IsSchoolFree()
    return LoC:IsMissed("SILENCE") and LoC:Get("SCHOOL_INTERRUPT", "NATURE") == 0
end 

local function UpdateExecuteID()
    A.Execute = A.Massacre:IsSpellLearned() and A.ExecuteMassacre or A.ExecuteDefault
end

local function ExecuteRange()
	return A.Massacre:IsSpellLearned() and 35 or 20;
end
	


-- [1] CC AntiFake Rotation
local function AntiFakeStun(unit) 
    return 
    Action.IsUnitEnemy(unit) and  
    ActionUnit(unit):GetRange() <= 5 and 
    ActionUnit(unit):IsControlAble("stun", 0) and 
    A.StormBoltGreen:AbsentImun(unit, Temp.TotalAndPhysAndCCAndStun, true)          
end 
A[1] = function(icon)    
    if     A.StormBoltGreen:IsReady(nil, nil, nil, true) and 
    (
        AntiFakeStun("mouseover") or 
        AntiFakeStun("target") or 
        (
            not Action.IsUnitEnemy("mouseover") and 
            not Action.IsUnitEnemy("target") and                     
            (
                (Action.IsInPvP and EnemyTeam():PlayersInRange(1, 5)) or 
                (not Action.IsInPvP and MultiUnits:GetByRange(5, 1) >= 1)
            )
        )
    )
    then 
        return A.StormBoltGreen:Show(icon)         
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
        local castLeft, _, _, _, notKickAble = ActionUnit(unit):IsCastingRemains()
        if castLeft > 0 then             
            if not notKickAble and A.PummelGreen:IsReady(unit, nil, nil, true) and A.PummelGreen:AbsentImun(unit, Temp.TotalAndPhysKick, true) then
                return A.PummelGreen:Show(icon)                                                  
            end 
            
            if A.StormBoltAntiFake:IsReady(unit, nil, nil, true) and A.StormBoltAntiFake:AbsentImun(unit, Temp.TotalAndPhysAndCC, true) and ActionUnit(unit):IsControlAble("stun", 0) then
                return A.StormBoltAntiFake:Show(icon)                  
            end 
			
			if A.IntimidatingShoutAntiFake:IsReady(unit, nil, nil, true) and A.IntimidatingShoutAntiFake:AbsentImun(unit, Temp.TotalAndPhysAndCC, true) and ActionUnit(unit):IsControlAble("fear", 0) then
				return A.IntimidatingShoutAntiFake:Show(icon)
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

local function PvPRotation(icon)

    local unit = "player"
    local isMoving = Player:IsMoving()
    local inMelee = false
    UpdateExecuteID()
	ExecuteRange()

    local function SelfDefensives()
        if ActionUnit("player"):CombatTime() == 0 then 
            return 
        end 
        
		-- DiebytheSword
	    local DiebytheSword = Action.GetToggle(2, "DiebytheSword")
        if     DiebytheSword >= 0 and A.DiebytheSword:IsReady("player") and 
        (
            (         -- Auto 
                DiebytheSword >= 100 and 
                (
                    -- HP lose per sec >= 20
                    ActionUnit("player"):GetDMG() * 100 / ActionUnit("player"):HealthMax() >= 20 or 
                    ActionUnit("player"):GetRealTimeDMG() >= ActionUnit("player"):HealthMax() * 0.20 or 
                    -- TTD 
                    ActionUnit("player"):TimeToDieX(25) < 5 or 
                    (
                        Action.IsInPvP and 
                        (
                            ActionUnit("player"):UseDeff() or 
                            (
                                ActionUnit("player", 5):HasFlags() and 
                                ActionUnit("player"):GetRealTimeDMG() > 0 and 
                                ActionUnit("player"):IsFocused("MELEE") 
                            )
                        )
                    )
                ) and 
                ActionUnit("player"):HasBuffs("DeffBuffs", true) == 0
            ) or 
            (    -- Custom
                DiebytheSword < 100 and 
                ActionUnit("player"):HealthPercent() <= DiebytheSword
            )
        ) 
        then 
            return A.DiebytheSword
        end
	    
		-- RallyingCry
        local RallyingCry = Action.GetToggle(2, "RallyingCry")
        if     RallyingCry >= 0 and A.RallyingCry:IsReady("player") and 
        (
            (         -- Auto 
                RallyingCry >= 100 and 
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
                RallyingCry < 100 and 
                ActionUnit("player"):HealthPercent() <= RallyingCry
            )
        ) 
        then 
            return A.RallyingCry
        end  
    end 
    SelfDefensives = Action.MakeFunctionCachedStatic(SelfDefensives)

	local function Reflects(unit)
	    local useKick, useCC, useRacial = Action.InterruptIsValid(unit, "TargetMouseover") 
		
		-- Reflect
   		if A.SpellReflection:IsReady(unit) and Action.ShouldReflect(unit) then
    	    return A.SpellReflection:Show(icon)
    	end	
	end
	Reflects = Action.MakeFunctionCachedDynamic(Reflects)
	
    local function Interrupts(unit)
        local useKick, useCC, useRacial = A.InterruptIsValid(unit, "TargetMouseover")    
 
	
        if useKick and A.Pummel:IsReady(unit) and A.Pummel:AbsentImun(unit, {"TotalImun", "DamagePhysImun", "KickImun"}, true) and ActionUnit(unit):CanInterrupt(true) then 
            return A.Pummel
        end 
    
        if useCC and A.StormBolt:IsReady(unit) and A.StormBolt:AbsentImun(unit, {"TotalImun", "DamagePhysImun", "CCTotalImun"}, true) and ActionUnit(unit):IsControlAble("stun", 0) then 
            return A.StormBolt              
        end          
	
	    if useCC and A.IntimidatingShout:IsReady(unit) and A.IntimidatingShout:AbsentImun(unit, {"TotalImun", "DamagePhysImun", "CCTotalImun"}, true) and ActionUnit(unit):IsControlAble("disorient", 0) then 
            return A.IntimidatingShout              
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
	
	local function EnemyRotation(unit)
		-- Variables
        inMelee = A.MortalStrike:IsInRange(unit)
		
		-- Victory Rush -> Buff about to expire or under UI value
		if A.VictoryRush:IsReady(unit) and ((A.GetToggle(2, "VictoryRush") >= 100 and ActionUnit("player"):HasBuffs(A.Victorious.ID, true) <= 3) or (ActionUnit("player"):HealthPercent() <= A.GetToggle(2, "VictoryRush") and ActionUnit("player"):HasBuffs(A.Victorious.ID, true) > 0)) then
			return A.VictoryRush:Show(icon)
		end
		
		-- Impending Victory 
		if A.ImpendingVictory:IsReady(unit) and (A.GetToggle(2, "ImpendingVictory") >= 100 or ActionUnit("player"):HealthPercent() <= A.GetToggle(2, "ImpendingVictory")) then
			return A.ImpendingVictory:Show(icon)
		end
		
		-- Execute SuddenDeath Buff
		if A.Execute:IsReady(unit) and ActionUnit("player"):HasBuffs(A.SuddenDeathBuff.ID, true) > 1 then
			return A.Execute:Show(icon)
		end
		
		-- Reflect
   		if A.SpellReflection:IsReady(unit) and Action.ShouldReflect(unit) then
    	    return A.SpellReflection:Show(icon)
    	end

		-- Hamstring (slow)
        if unit ~= "mouseover" and  ActionUnit(unit):GetRange() <= 14 and (A.IsInPvP or (not ActionUnit(unit):IsBoss() and ActionUnit(unit):IsMovingOut())) and A.Hamstring:IsReady(unit) and A.Hamstring:AbsentImun(unit, {"TotalImun", "DamagePhysImun", "Freedom", "CCTotalImun"}, true) and ActionUnit(unit):GetMaxSpeed() >= 100 and ActionUnit(unit):HasDeBuffs("Slowed") == 0 and not ActionUnit(unit):IsTotem() then 
            return A.Hamstring:Show(icon)
        end	

		-- AoE
		if A.GetToggle(2, "AoE") and MultiUnits:GetByRange(8, 2) >= 2 and A.SweepingStrikes:IsReady(unit, true) then
			return A.SweepingStrikes:Show(icon)
		end

		if A.Rend:IsReady(unit) and A.Rend:AbsentImun(unit, {"TotalImun", "DamagePhysImun"}) and ActionUnit(unit):HasDeBuffs(A.RendDebuff.ID) < 2  then
			return A.Rend:Show(icon)
		end	

		--if A.GetToggle(2, "AoE") and MultiUnits:GetByRange(8, 2) >= 2 and A.Whirlwind:IsReady(unit, true) and Unit("player"):HasBuffs(A.MeatCleaverBuff.ID, true) <= 0 then
		--	return A.Whirlwind:Show(icon)
		--end
		-- 

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

		--Execute Rotation
		if ActionUnit(unit):HealthPercent() <= 30 then
			if A.Skullsplitter:IsReady(unit) and A.Skullsplitter:AbsentImun(unit, {"TotalImun", "DamagePhysImun"}) and (Player:Rage() < 60 and ActionUnit("player"):HasBuffs(A.DeadlyCalmBuff.ID) <= 0) then
				return A.Skullsplitter:Show(icon)
			end

			if inMelee and A.ColossusSmash:IsReady(unit) and A.ColossusSmash:AbsentImun(unit, {"TotalImun", "DamagePhysImun"}) then
				return A.ColossusSmash:Show(icon)
			end

			if inMelee then
				if  A.Warbreaker:IsReady(unit, true) and A.Warbreaker:AbsentImun(unit, {"TotalImun", "DamagePhysImun"}) then
					return A.Warbreaker:Show(icon)
				end
			end

			if A.MortalStrike:IsReady(unit) and A.MortalStrike:AbsentImun(unit, {"TotalImun", "DamagePhysImun"}) then
				return A.MortalStrike:Show(icon)
			end

			if A.Execute:IsReady(unit)  then
				return A.Execute:Show(icon)
			end

			if A.Overpower:IsReady(unit) and A.Overpower:AbsentImun(unit, {"TotalImun", "DamagePhysImun"}) then
				return A.Overpower:Show(icon)
			end

			if A.Execute:IsReady(unit)  then
				return A.Execute:Show(icon)
			end
		end

		-- Single 
		--if A.Rend:IsReady(unit) and A.Rend:AbsentImun(unit, {"TotalImun", "DamagePhysImun"}) and Unit(unit):HasDeBuffs(A.RendDebuff.ID) < 1 and Unit(unit):HasDeBuffs(A.ColossusSmashDebuff.ID) <= 0 then
		if A.Skullsplitter:IsReady(unit) and A.Skullsplitter:AbsentImun(unit, {"TotalImun", "DamagePhysImun"}) and (Player:Rage() < 60 and ActionUnit("player"):HasBuffs(A.DeadlyCalmBuff.ID) <= 0) then
			return A.Skullsplitter:Show(icon)
		end

		-- Revanger

		if inMelee and A.ColossusSmash:IsReady(unit) and A.ColossusSmash:AbsentImun(unit, {"TotalImun", "DamagePhysImun"}) then
			return A.ColossusSmash:Show(icon)
		end

		if inMelee then
			if  A.Warbreaker:IsReady(unit, true) and A.Warbreaker:AbsentImun(unit, {"TotalImun", "DamagePhysImun"}) then
				return A.Warbreaker:Show(icon)
			end
		end

		if A.MortalStrike:IsReady(unit) and A.MortalStrike:AbsentImun(unit, {"TotalImun", "DamagePhysImun"}) then
			return A.MortalStrike:Show(icon)
		end

		if inMelee and A.DeadlyCalm:IsReady(unit) then
			A.DeadlyCalm:Show(icon)
		end

	--	if A.SweepingStrikes:IsReady(unit) and (isMulti or A.GetToggle(2, "AoE") or MultiUnits:GetByRange(8, 2) < 2) then
	--		A.SweepingStrikes:Show(icon)
	--	end

		if A.Cleave:IsReady(unit) and A.Cleave:AbsentImun(unit, {"TotalImun", "DamagePhysImun"}) and (isMulti or A.GetToggle(2, "AoE") or MultiUnits:GetByRange(8, 2) < 2) then
			A.Cleave:Show(icon)
		end

		if A.Overpower:IsReady(unit) and A.Overpower:AbsentImun(unit, {"TotalImun", "DamagePhysImun"}) and (Player:Rage() < 30 and ActionUnit("player"):HasBuffs(A.ColossusSmashDebuff.ID) > 0) then
			return A.Overpower:Show(icon)
		end

		if inMelee and A.Bladestorm:IsReady(unit, true) and ActionUnit(unit):HasDeBuffs(A.ColossusSmashDebuff.ID) > 0 then
			return A.Bladestorm:Show(icon)
		end

		if A.Whirlwind:IsReady(unit) and A.Whirlwind:AbsentImun(unit, {"TotalImun", "DamagePhysImun"}) and (A.FervorofBattle:IsSpellLearned() and ActionUnit("player"):HasBuffs(A.DeadlyCalmBuff.ID) > 0) then
			return A.Whirlwind:Show(icon)
		end

		if A.Overpower:IsReady(unit) and A.Overpower:AbsentImun(unit, {"TotalImun", "DamagePhysImun"}) then
			return A.Overpower:Show(icon)
		end
		
		if A.Slam:IsReady(unit) and A.Slam:AbsentImun(unit, {"TotalImun", "DamagePhysImun"}) and (Player:Rage() > 50 and not A.FervorofBattle:IsSpellLearned()) then
			return A.Slam:Show(icon)
		end
		
		if A.Whirlwind:IsReady(unit) and A.Whirlwind:AbsentImun(unit, {"TotalImun", "DamagePhysImun"}) and (A.FervorofBattle:IsSpellLearned()) then
			return A.Whirlwind:Show(icon)
		end



		-- Misc - Supportive 
        if A.BerserkerRage:IsReady("player") then 
            if ActionUnit("player"):HasDeBuffs("Fear") >= 4 then 
                return A.BerserkerRage:Show(icon)
            end 
        end 	
 	end 
	
	-- Defensive
    local SelfDefensive = SelfDefensives()
    if SelfDefensive then 
        return SelfDefensive:Show(icon)
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
    if Action.IsUnitEnemy("mouseover") then 
        unit = "mouseover"
        -- Interrupts
        if Interrupts(unit) then 
            return true
        end 
        -- Reflect		
        if Reflects(unit) then 
            return true
        end 
		-- Rotation
        if EnemyRotation(unit) then 
            return true 
        end 
    end 
        
    -- Target                         
    if Action.IsUnitEnemy("target") then 
        unit = "target"
        -- Interrupts
        if Interrupts(unit) then 
            return true
        end 
        -- Reflect		
        if Reflects(unit) then 
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
	if not Action.IsInPvP and APL() then 
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
    if A.IsInPvP and (A.Zone == "pvp" or A.Zone == "arena") and not ActionPlayer:IsStealthed() and not ActionPlayer:IsMounted() then             
        -- Note: "arena1" is just identification of meta 6
        if unit == "arena1" and (ActionUnit("player"):GetDMG() == 0 or not ActionUnit("player"):IsFocused("DAMAGER")) then                 
            -- PvP Pet Taunt        
            if A.Taunt:IsReady() and EnemyTeam():IsTauntPetAble(A.Taunt.ID) then 
                -- Freezing Trap 
                if FreezingTrapUsedByEnemy() then 
                    return A.Taunt:Show(icon)
                end 
                
                -- Casting BreakAble CC
                if EnemyTeam():IsCastingBreakAble(0.25) then 
                    return A.Taunt:Show(icon)
                end 
                
                -- Try avoid something totally random at opener (like sap / blind)
                if ActionUnit("player"):CombatTime() <= 5 and (ActionUnit("player"):CombatTime() > 0 or ActionUnit("target"):CombatTime() > 0 or MultiUnits:GetByRangeInCombat(40, 1) >= 1) then 
                    return A.Taunt:Show(icon) 
                end 
                
                -- Roots if not available freedom 
                if LoC:Get("ROOT") > 0 then 
                    return A.Taunt:Show(icon) 
                end 
            end 
        end 

		if A.Rend:IsReady(unit) and A.Rend:AbsentImun(unit, {"TotalImun", "DamagePhysImun"}) and ActionUnit(unit):HasDeBuffs(A.RendDebuff.ID) < 2  then
			return A.Rend:Show(icon)
		end	
		
        -- Disarm
        if A.DisarmIsReady(unit) and not ActionUnit(unit):InLOS() then
            return A.Disarm:Show(icon)
        end         
        
       -- if A.IsInPvP and A.GetToggle(1, "AutoTarget") and A.IsUnitEnemy("target") and not A.AbsentImun(nil, "target", {"TotalImun", "DamagePhysImun"}) and MultiUnits:GetByRangeInCombat(12, 2) >= 2  then 
      --      Action.TMWAPL(icon, "texture", ACTION_CONST_AUTOTARGET)             
      --      return true
     --   end         
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



