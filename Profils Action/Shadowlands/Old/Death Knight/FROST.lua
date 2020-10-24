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

--- ============================ CONTENT ===========================
--- ======= APL LOCALS =======
-- luacheck: max_line_length 9999

-- Spells
Action[ACTION_CONST_DEATHKNIGHT_FROST] = {
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
    GiftofNaaru                            = Action.Create({ Type = "Spell", ID = 59544     }),
    BagofTricks                            = Action.Create({ Type = "Spell", ID = 312411    }),
    Shadowmeld                             = Action.Create({ Type = "Spell", ID = 58984     }), -- usable in Action Core 
    Stoneform                              = Action.Create({ Type = "Spell", ID = 20594     }), 
    LightsJudgment                         = Action.Create({ Type = "Spell", ID = 255647 }),
    WilloftheForsaken                      = Action.Create({ Type = "Spell", ID = 7744        }), -- not usable in APL but user can Queue it   
    EscapeArtist                           = Action.Create({ Type = "Spell", ID = 20589    }), -- not usable in APL but user can Queue it
    EveryManforHimself                     = Action.Create({ Type = "Spell", ID = 59752    }), -- not usable in APL but user can Queue it
    -- Generic Spells 
    RemorselessWinter                      = Action.Create({ Type = "Spell", ID = 196770     }),
    GatheringStorm                         = Action.Create({ Type = "Spell", ID = 194912     }),
    GlacialAdvance                         = Action.Create({ Type = "Spell", ID = 194913     }),
    Frostscythe                            = Action.Create({ Type = "Spell", ID = 207230     }),
    FrostStrike                            = Action.Create({ Type = "Spell", ID = 49143     }),
    HowlingBlast                           = Action.Create({ Type = "Spell", ID = 49184     }),
    RunicAttenuation                       = Action.Create({ Type = "Spell", ID = 207104     }),
    Obliterate                             = Action.Create({ Type = "Spell", ID = 49020     }),
    HornofWinter                           = Action.Create({ Type = "Spell", ID = 57330     }),
    PillarofFrost                          = Action.Create({ Type = "Spell", ID = 51271     }),
    ChainsofIce                            = Action.Create({ Type = "Spell", ID = 45524     }),
    FrostwyrmsFury                         = Action.Create({ Type = "Spell", ID = 279302     }),
    BloodFury                              = Action.Create({ Type = "Spell", ID = 20572     }),
    Berserking                             = Action.Create({ Type = "Spell", ID = 26297     }),
    EmpowerRuneWeapon                      = Action.Create({ Type = "Spell", ID = 47568     }),
    BreathofSindragosa                     = Action.Create({ Type = "Spell", ID = 152279     }),
    ColdHeart                              = Action.Create({ Type = "Spell", ID = 281208     }),
    FrozenPulse                            = Action.Create({ Type = "Spell", ID = 194909     }),
    Obliteration                           = Action.Create({ Type = "Spell", ID = 281238     }),
    DeathStrike                            = Action.Create({ Type = "Spell", ID = 49998      }),
    FrozenTempest                          = Action.Create({ Type = "Spell", ID = 278487     }),
    IcyCitadel                             = Action.Create({ Type = "Spell", ID = 272718     }),
    MindFreeze                             = Action.Create({ Type = "Spell", ID = 47528      }),
    ConcentratedFlameBurn                  = Action.Create({ Type = "Spell", ID = 295368     }),
    ChillStreak                            = Action.Create({ Type = "Spell", ID = 305392     }),
    Icecap                                 = Action.Create({ Type = "Spell", ID = 207126     }),
    -- Buffs
    RecklessForceBuff                      = Action.Create({ Type = "Spell", ID = 302932, Hidden = true     }),
    IcyCitadelBuff                         = Action.Create({ Type = "Spell", ID = 272719, Hidden = true     }),
    UnholyStrengthBuff                     = Action.Create({ Type = "Spell", ID = 53365, Hidden = true     }),
    DeathStrikeBuff                        = Action.Create({ Type = "Spell", ID = 101568, Hidden = true     }),
    IcyTalonsBuff                          = Action.Create({ Type = "Spell", ID = 194879, Hidden = true     }),
    FrozenPulseBuff                        = Action.Create({ Type = "Spell", ID = 194909, Hidden = true     }),
    EmpowerRuneWeaponBuff                  = Action.Create({ Type = "Spell", ID = 47568, Hidden = true     }),
    PillarofFrostBuff                      = Action.Create({ Type = "Spell", ID = 51271, Hidden = true     }),
    ColdHeartBuff                          = Action.Create({ Type = "Spell", ID = 281209, Hidden = true     }),
    KillingMachineBuff                     = Action.Create({ Type = "Spell", ID = 51124, Hidden = true     }),
    RimeBuff                               = Action.Create({ Type = "Spell", ID = 59052, Hidden = true     }), 
    SeethingRageBuff                       = Action.Create({ Type = "Spell", ID = 297126, Hidden = true }),  
    BreathofSindragosaBuff                 = Action.Create({ Type = "Spell", ID = 155166, Hidden = true }),
	-- Defensives
    IceboundFortitude                      = Action.Create({ Type = "Spell", ID = 48792 }),
    AntiMagicShell                         = Action.Create({ Type = "Spell", ID = 48707 }),
    DeathPact                              = Action.Create({ Type = "Spell", ID = 48743 }),	-- Talent
    -- Debuffs
    RazorCoralDebuff                       = Action.Create({ Type = "Spell", ID = 303568, Hidden = true     }),
    FrostFeverDebuff                       = Action.Create({ Type = "Spell", ID = 55095, Hidden = true     }),
    RazoriceDebuff                         = Action.Create({ Type = "Spell", ID = 51714, Hidden = true     }), 
	-- Utilities
	WraithWalk                             = Action.Create({ Type = "Spell", ID = 212552     }), 
	MindFreeze                             = Action.Create({ Type = "Spell", ID = 47528     }),
	Asphyxiate                             = Action.Create({ Type = "Spell", ID = 108194     }),
	DeathsAdvance                          = Action.Create({ Type = "Spell", ID = 48265     }), -- 30% Speed & immune to 100% normal speed
	DeathGrip                              = Action.Create({ Type = "Spell", ID = 49576     }),
    ChainsofIce                            = Action.Create({ Type = "Spell", ID = 45524     }), -- 70% snare, 8sec
    RaiseAlly                              = Action.Create({ Type = "Spell", ID = 61999     }),	 -- Battle rez 
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
    -- Misc
    PoolResource						   = Action.Create({ Type = "Spell", ID = 97238, Hidden = true}),
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
    RecklessForceBuff                      = Action.Create({ Type = "Spell", ID = 302932, Hidden = true     }),
    DummyTest                              = Action.Create({ Type = "Spell", ID = 159999, Hidden = true     }), -- Dummy stop dps icon	
	FrostwhelpsIndignation                 = Action.Create({ Type = "Spell", ID = 287283, Hidden = true     }), -- Azerite 
};

-- To create essences use next code:
Action:CreateEssencesFor(ACTION_CONST_DEATHKNIGHT_FROST)  -- where PLAYERSPEC is Constance (example: ACTION_CONST_MONK_BM)
local A = setmetatable(Action[ACTION_CONST_DEATHKNIGHT_FROST], { __index = Action })


------------------------------------------
---------------- VARIABLES ---------------
------------------------------------------
local VarOtherOnUseEquipped = 0;

A.Listener:Add("ROTATION_VARS", "PLAYER_REGEN_ENABLED", function()
  VarOtherOnUseEquipped = 0
end)
local player = "player"

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

local MetaQueue                             = {
    [3]                                        = {
        player                                = {UnitID = "player",         Silence = true, Auto = true, Value = true, Priority = 1},
        mouseover                             = {UnitID = "mouseover",     Silence = true, Auto = true, Value = true, Priority = 1},
        target                                 = {UnitID = "target",         Silence = true, Auto = true, Value = true, Priority = 1},
    },
    [6]                                        = {
        player                                 = {UnitID = "player",         Silence = true, Auto = true, Value = true, Priority = 1, MetaSlot = 6},
        target                                 = {UnitID = "arena1",         Silence = true, Auto = true, Value = true, Priority = 1, MetaSlot = 6},
    },
    [7]                                        = {
        player                                 = {UnitID = "player",         Silence = true, Auto = true, Value = true, Priority = 1, MetaSlot = 7},
        target                                 = {UnitID = "arena2",         Silence = true, Auto = true, Value = true, Priority = 1, MetaSlot = 7},
    },
    [8]                                        = {
        player                                 = {UnitID = "player",         Silence = true, Auto = true, Value = true, Priority = 1, MetaSlot = 8},
        target                                 = {UnitID = "arena3",         Silence = true, Auto = true, Value = true, Priority = 1, MetaSlot = 8},
    },
    Cancel                                     = {Silence = true},
}

local IsIndoors, UnitIsUnit, UnitName = IsIndoors, UnitIsUnit, UnitName

local function IsSchoolFree()
	return LoC:IsMissed("SILENCE") and LoC:Get("SCHOOL_INTERRUPT", "SHADOW") == 0
end 

local function InMelee(unit)
	-- @return boolean 
	return A.FrostStrike:IsInRange(unit)
end 

-- @return boolean  
-- @parameters count, range are mandatory, others parameters optionals
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
			if InMelee(unit) then 
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

-- ExpectedCombatLength
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

-------------------------------------------
-- [[ QUEUE GENERATOR ]] 
-------------------------------------------
local function GenerateBreathofSindragosa(meta, obj, skipObj, unit)
    -- Usage: @number meta, @table obj, @number castLeft or @string unit, @boolean skipObj will not queue itself Breath of Sindragosa if true 
    -- Sorts queue priority for specified meta to build enough runic power for successfully Breath of Sindragosa 
	
	--local BoSPoolSequenceMacro = A.GetToggle(2, "BoSPoolSequenceMacro")
	
    if not A.IsQueueRunningAuto() then                
        local BoSEnemies      = A.GetToggle(2, "BoSEnemies")                             -- not static
        local BoSPoolTime     = A.GetToggle(2, "BoSPoolTime")                                                     -- not static
        local BoSMinPower     = A.GetToggle(2, "BoSMinPower")                                                 -- not static
        
        local myRunicPower        = Player:RunicPower()        
        local needRunicPower      = obj:GetSpellPowerCostCache()                                                                      
        
        -- Do nothing if not enough Runic Power generate
        local canBreathofSindragosa = BoSMinPower > 0 and A.BreathofSindragosa:IsReadyP("player") and myRunicPower >= BoSMinPower
        
		if A.BreathofSindragosa:GetCooldown() > 0 then
		    return false
		end
		
        -- General 
        if not skipObj and canBreathofSindragosa and A.EmpowerRuneWeapon:GetCooldown() > 0 and A.PillarofFrost:GetCooldown() > 0 then 
            local target = unit == "mouseover" and MetaQueue[3].mouseover or MetaQueue[meta].target
           -- obj:SetQueue(target)                                     -- #4
			obj:SetQueue(MetaQueue[meta].player)                     -- #4
        end 
		
        -- Empower Rune Weapon
        if canBreathofSindragosa and A.EmpowerRuneWeapon:GetCooldown() == 0 then 
            A.EmpowerRuneWeapon:SetQueue(MetaQueue[meta].player)             -- #3
        end 
		
        -- Pilar of Frost
        if canBreathofSindragosa and A.PillarofFrost:GetCooldown() == 0 and (A.EmpowerRuneWeapon:GetCooldown() > 110 or A.LastPlayerCastName == A.EmpowerRuneWeapon:Info()) then 
            A.PillarofFrost:SetQueue(MetaQueue[meta].player)             -- #2
        end 	
		
		-- Obliterate
        if not canBreathofSindragosa and Player:Rune() >= 2 then 
		    local target = unit == "mouseover" and MetaQueue[3].mouseover or MetaQueue[meta].target
            A.Obliterate:SetQueue(target)             -- #1
        end 
		
        -- howling_blast,if=buff.rime.up
        if not canBreathofSindragosa and Player:Rune() < 2 and Unit(player):HasBuffs(A.RimeBuff.ID, true) > 0 then
            A.HowlingBlast:SetQueue(target)             -- #1
        end	
		
		-- Custom pool time user
		if not canBreathofSindragosa and A.BreathofSindragosa:GetCooldown() <= BoSPoolTime then
		    return true
		end	
        
    end 
end 

-- Guardian of Azeroth active
-- @return true if guardian is active
local function GuardianofAzerothIsActive() 
    return Pet:GetRemainDuration(152396) > 0 and true or false
end	

-- Guardian of Azeroth time
-- @return remaining time duration in seconds
local function GuardianofAzerothRemains() 
    return Pet:GetRemainDuration(152396)
end	

local function DeathStrikeHeal()
    return Unit(player):HealthPercent() < Action.GetToggle(2, "UseDeathStrikeHP")
end


-- SelfDefensives
local function SelfDefensives()
    local HPLoosePerSecond = Unit(player):GetDMG() * 100 / Unit(player):HealthMax()
		
    if Unit(player):CombatTime() == 0 then 
        return 
    end 

    -- Icebound Fortitude
    local IceboundFortitude = Action.GetToggle(2, "IceboundFortitudeHP")
    if     IceboundFortitude >= 0 and A.IceboundFortitude:IsReady(player) and 
    (
        (   -- Auto 
            IceboundFortitude >= 100 and 
            (
                -- HP lose per sec >= 20
                Unit(player):GetDMG() * 100 / Unit(player):HealthMax() >= 20 or 
                Unit(player):GetRealTimeDMG() >= Unit(player):HealthMax() * 0.20 or 
                -- TTD 
                Unit(player):TimeToDieX(25) < 5 or
				-- Player stunned
                LoC:Get("STUN") > 0	or			
                (
                    A.IsInPvP and 
                    (
                        Unit(player):UseDeff() or 
                        (
                            Unit(player, 5):HasFlags() and 
                            Unit(player):GetRealTimeDMG() > 0 and 
                            Unit(player):IsFocused() 
                        )
                    )
                )
            ) and 
            Unit(player):HasBuffs("DeffBuffs", true) == 0
        ) or 
        (    -- Custom
            IceboundFortitude < 100 and 
            Unit(player):HealthPercent() <= IceboundFortitude
        )
    ) 
    then 
        return A.IceboundFortitude
    end  
		
    -- Emergency AntiMagicShell
        local AntiMagicShell = Action.GetToggle(2, "AntiMagicShellHP")
        if     AntiMagicShell >= 0 and A.AntiMagicShell:IsReady(player) and 
        (
            (   -- Auto 
                AntiMagicShell >= 100 and 
                (
                    -- HP lose per sec >= 10
                    Unit(player):GetDMG() * 100 / Unit(player):HealthMax() >= 10 or 
                    Unit(player):GetRealTimeDMG() >= Unit(player):HealthMax() * 0.10 or 
                    -- TTD Magic
                    Unit(player):TimeToDieMagicX(50) < 5 or 
					
                    (
                        A.IsInPvP and 
                        (
                            Unit(player):UseDeff() or 
                            (
                                Unit(player, 5):HasFlags() and 
                                Unit(player):GetRealTimeDMG() > 0 and 
                                Unit(player):IsFocused() 
                            )
                        )
                    )
                ) and 
                Unit(player):HasBuffs("DeffBuffs", true) == 0
            ) or 
            (    -- Custom
                AntiMagicShell < 100 and 
                Unit(player):HealthPercent() <= AntiMagicShell
            )
        ) 
        then 
            return A.AntiMagicShell
        end  		

        -- Emergency Death Pact
        local DeathPact = Action.GetToggle(2, "DeathPactHP")
        if     DeathPact >= 0 and A.DeathPact:IsReady(player) and A.DeathPact:IsSpellLearned() and 
        (
            (   -- Auto 
                DeathPact >= 100 and 
                (
                    -- HP lose per sec >= 30
                    Unit(player):GetDMG() * 100 / Unit(player):HealthMax() >= 30 or 
                    Unit(player):GetRealTimeDMG() >= Unit(player):HealthMax() * 0.30 or 
                    -- TTD 
                    Unit(player):TimeToDieX(25) < 5 or 
                    (
                        A.IsInPvP and 
                        (
                            Unit(player):UseDeff() or 
                            (
                                Unit(player, 5):HasFlags() and 
                                Unit(player):GetRealTimeDMG() > 0 and 
                                Unit(player):IsFocused() 
                            )
                        )
                    )
                ) and 
                Unit(player):HasBuffs("DeffBuffs", true) == 0
            ) or 
            (    -- Custom
                DeathPact < 100 and 
                Unit(player):HealthPercent() <= DeathPact
            )
        ) 
        then 
            return A.DeathPact
        end  

	    -- HealingPotion
    local AbyssalHealingPotion = A.GetToggle(2, "AbyssalHealingPotionHP")
    if     AbyssalHealingPotion >= 0 and A.AbyssalHealingPotion:IsReady(player) and 
    (
        (     -- Auto 
            AbyssalHealingPotion >= 100 and 
            (
                -- HP lose per sec >= 20
                Unit(player):GetDMG() * 100 / Unit(player):HealthMax() >= 20 or 
                Unit(player):GetRealTimeDMG() >= Unit(player):HealthMax() * 0.20 or 
                -- TTD 
                Unit(player):TimeToDieX(25) < 5 or 
                (
                    A.IsInPvP and 
                    (
                        Unit(player):UseDeff() or 
                        (
                            Unit(player, 5):HasFlags() and 
                            Unit(player):GetRealTimeDMG() > 0 and 
                            Unit(player):IsFocused() 
                        )
                    )
                )
            ) and 
            Unit(player):HasBuffs("DeffBuffs", true) == 0
        ) or 
        (    -- Custom
            AbyssalHealingPotion < 100 and 
            Unit(player):HealthPercent() <= AbyssalHealingPotion
        )
    ) 
    then 
        return A.AbyssalHealingPotion
    end 		

end 
SelfDefensives = A.MakeFunctionCachedDynamic(SelfDefensives)

-- Non GCD spell check
local function countInterruptGCD(unit)
    if not A.MindFreeze:IsReadyByPassCastGCD(unit) or not A.MindFreeze:AbsentImun(unit, Temp.TotalAndMagKick) then
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
        -- MindFreeze
        if useKick and not notInterruptable and A.MindFreeze:IsReady(unit) then 
            return A.MindFreeze
        end
	
        -- DeathGrip
        if useCC and A.DeathGrip:IsReady(unit) and DeathGripInterrupt then 
            return A.DeathGrip
   	    end 
	
   	    -- Asphyxiate
   	    if useCC and A.Asphyxiate:IsSpellLearned() and A.Asphyxiate:IsReady(unit) then 
   	        return A.Asphyxiate
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



--- ======= ACTION LISTS =======
-- [3] Single Rotation
A[3] = function(icon, isMulti)
    --------------------
    --- ROTATION VAR ---
    --------------------
    local isMoving = A.Player:IsMoving()
	local isMovingFor = A.Player:IsMovingTime()
    local inCombat = Unit(player):CombatTime() > 0
    local combatTime = Unit(player):CombatTime()
    local ShouldStop = Action.ShouldStop()
    local Pull = Action.BossMods:GetPullTimer()
    local DeathStrikeHeal = DeathStrikeHeal()
	local BoSPoolTime = A.GetToggle(2, "BoSPoolTime")
	local BoSMinPower = A.GetToggle(2, "BoSMinPower")
	local BoSEnemies = A.GetToggle(2, "BoSEnemies")
	local BoSLucidDream = A.GetToggle(2, "BoSLucidDream")
	local BoSEnemiesRange = A.GetToggle(2, "BoSEnemiesRange")
	local BosUsage = A.GetToggle(2, "BosUsage")
	local LucidDreamPower = A.GetToggle(2, "LucidDreamPower")
	local LucidDreamUseAfter = A.GetToggle(2, "LucidDreamUseAfter")
	local BloodoftheEnemySyncAoE = GetToggle(2, "BloodoftheEnemySyncAoE")
	local BloodoftheEnemyAoETTD = GetToggle(2, "BloodoftheEnemyAoETTD")
	local BloodoftheEnemyUnits = GetToggle(2, "BloodoftheEnemyUnits")
	local MinAoETargets = GetToggle(2, "MinAoETargets")
	local MaxAoERange = GetToggle(2, "MaxAoERange")
	local VarPoolForBoS = false
	local VarPoolForBoSQueue = false
	local BoSisActive = Unit(player):HasBuffs(A.BreathofSindragosaBuff.ID, true) > 0
	local profileStop = false
	local meta = 3
	-- Trinkets vars
    local Trinket1IsAllowed, Trinket2IsAllowed = TR:TrinketIsAllowed()
	local TrinketsAoE = GetToggle(2, "TrinketsAoE")
	local TrinketsMinTTD = GetToggle(2, "TrinketsMinTTD")
	local TrinketsUnitsRange = GetToggle(2, "TrinketsUnitsRange")
	local TrinketsMinUnits = GetToggle(2, "TrinketsMinUnits")
	-- BreathofSindragosa protection channel
	local CanCast = true
	local TotalCast, CurrentCastLeft, CurrentCastDone = Unit(player):CastTime()
	local _, castStartedTime, castEndTime = Unit(player):IsCasting()
	local secondsLeft, percentLeft, spellID, spellName, notInterruptable, isChannel = Unit(player):IsCastingRemains()
	-- Ensure all channel and cast are really safe
	-- Double protection with check on current casts and also timestamp of the cast
	if (spellID == A.BreathofSindragosa.ID or spellID == A.FocusedAzeriteBeam.ID) then 
	    if (CurrentCastLeft > 0 or secondsLeft > 0 or isChannel) then
		    if TMW.time < castEndTime then			
			    CanCast = false
	        else
	            CanCast = true
			end
		end
	end
	--print(CanCast)
	if not CanCast then
	    return A.PoolResource:Show(icon)
	end
	
	------------------------------------
	---------- DUMMY DPS TEST ----------
	------------------------------------
	local DummyTime = A.GetToggle(2, "DummyTime")
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
    ------------------------------------------------------
    ---------------- ENEMY UNIT ROTATION -----------------
    ------------------------------------------------------
    local function EnemyRotation(unit)

        --Precombat
        local function Precombat(unit)
            -- flask
            -- food
            -- augmentation
            -- snapshot_stats
			
            -- potion
            if A.PotionofUnbridledFury:IsReady(unit) and Action.GetToggle(1, "Potion") 
			and (Pull > 0 and Pull <= 2 or not A.GetToggle(1 ,"DBM"))
			then
                return A.PotionofUnbridledFury:Show(icon)
            end
			
            -- use_item,name=azsharas_font_of_power
            if A.AzsharasFontofPower:IsReady(player) 
			and (Pull > 0 and Pull <= 6 or not A.GetToggle(1 ,"DBM"))
			then
                return A.AzsharasFontofPower:Show(icon)
            end
			
            -- variable,name=other_on_use_equipped,value=(equipped.notorious_gladiators_badge|equipped.sinister_gladiators_badge|equipped.sinister_gladiators_medallion|equipped.vial_of_animated_blood|equipped.first_mates_spyglass|equipped.jes_howler|equipped.notorious_gladiators_medallion|equipped.ashvanes_razor_coral)
            if (true) then
                VarOtherOnUseEquipped = (A.NotoriousGladiatorsBadge:IsExists() or A.SinisterGladiatorsBadge:IsExists() or A.SinisterGladiatorsMedallion:IsExists() or A.VialofAnimatedBlood:IsExists() or A.FirstMatesSpyglass:IsExists() or A.JesHowler:IsExists() or A.NotoriousGladiatorsMedallion:IsExists() or A.AshvanesRazorCoral:IsExists())
            end
			
	        -- obliterate,if=runic_power.deficit>(25+talent.runic_attenuation.enabled*3)
            if A.Obliterate:IsReadyByPassCastGCD(unit) and A.Obliterate:AbsentImun(unit, Temp.TotalAndPhys)
            and (Pull > 0 and Pull <= A.GetGCD() or not A.GetToggle(1 ,"DBM"))
			then
                return A.Obliterate:Show(icon)                                                                   
            end	
        end
        Precombat = A.MakeFunctionCachedDynamic(Precombat)
				
        --Essences
        local function Essences(unit)
			
            -- memory_of_lucid_dreams,if=buff.empower_rune_weapon.remains<5&buff.breath_of_sindragosa.up|(rune.time_to_2>gcd&runic_power<50)
            --if A.MemoryofLucidDreams:AutoHeartOfAzeroth(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") and (Unit(player):HasBuffs(A.EmpowerRuneWeaponBuff.ID, true) < 5 and Unit(player):HasBuffs(A.BreathofSindragosaBuff.ID, true) > 0 or (Player:RuneTimeToX(2) > A.GetGCD() and Player:RunicPower() < 50)) then
           --     return A.MemoryofLucidDreams:Show(icon)
           -- end

           -- blood_of_the_enemy,if=buff.pillar_of_frost.up&(buff.pillar_of_frost.remains<10&(buff.breath_of_sindragosa.up|talent.obliteration.enabled|talent.icecap.enabled&!azerite.icy_citadel.enabled)|buff.icy_citadel.up&talent.icecap.enabled)&(active_enemies=1|!talent.icecap.enabled)|active_enemies>=2&talent.icecap.enabled&cooldown.pillar_of_frost.ready&(azerite.icy_citadel.rank>=1&buff.icy_citadel.up|!azerite.icy_citadel.enabled)
            if A.BloodoftheEnemy:AutoHeartOfAzerothP(unit, true) and not BloodoftheEnemySyncAoE and Action.GetToggle(1, "HeartOfAzeroth") and 
			(
			    Unit("player"):HasBuffs(A.PillarofFrostBuff.ID, true) and 
				(
				    Unit("player"):HasBuffs(A.PillarofFrostBuff.ID, true) < 10 and 
					(
					    Unit("player"):HasBuffs(A.BreathofSindragosaBuff.ID, true) 
						or 
						A.Obliteration:IsSpellLearned() 
						or 
						A.Icecap:IsSpellLearned() and not A.IcyCitadel:GetAzeriteRank() > 0
					)
					or 
					Unit("player"):HasBuffs(A.IcyCitadelBuff.ID, true) > 0 and A.Icecap:IsSpellLearned()
					or
					Unit(unit):IsBoss()
				)
				and 
				(
				    GetByRange(1, 20, false, true) 
					or 
					not A.Icecap:IsSpellLearned()
				)
				or 
				GetByRange(2, 20) and A.Icecap:IsSpellLearned() and A.PillarofFrost:GetCooldown() == 0 and 
				(
				    A.IcyCitadel:GetAzeriteRank() >= 1 and Unit("player"):HasBuffs(A.IcyCitadelBuff.ID, true) 
					or 
					not A.IcyCitadel:GetAzeriteRank() > 0
				)
			)
			then
                return A.BloodoftheEnemy:Show(icon)
            end
			
            -- blood_of_the_enemy,if=buff.pillar_of_frost.up&(buff.pillar_of_frost.remains<10&(buff.breath_of_sindragosa.up|talent.obliteration.enabled|talent.icecap.enabled&!azerite.icy_citadel.enabled)|buff.icy_citadel.up&talent.icecap.enabled)
            if A.BloodoftheEnemy:AutoHeartOfAzeroth(unit, true) and not BloodoftheEnemySyncAoE and Action.GetToggle(1, "HeartOfAzeroth") and 
			(
			    Unit(player):HasBuffs(A.PillarofFrostBuff.ID, true) > 0 and 
				(
				    Unit(player):HasBuffs(A.PillarofFrostBuff.ID, true) < 10 and 
					(
					    Unit(player):HasBuffs(A.BreathofSindragosaBuff.ID, true) > 0 
					    or 
					    A.Obliteration:IsSpellLearned() 
					    or 
					    A.Icecap:IsSpellLearned() and A.IcyCitadel:GetAzeriteRank() == 0
					) 
					or 
					Unit(player):HasBuffs(A.IcyCitadelBuff.ID, true) > 0 and A.Icecap:IsSpellLearned()
					or
					Unit(unit):IsBoss()
				)
			)
			then
                return A.BloodoftheEnemy:Show(icon)
            end
			
            -- guardian_of_azeroth,if=!talent.icecap.enabled|talent.icecap.enabled&azerite.icy_citadel.enabled&buff.pillar_of_frost.remains<6&buff.pillar_of_frost.up|talent.icecap.enabled&!azerite.icy_citadel.enabled
            if A.GuardianofAzeroth:AutoHeartOfAzeroth(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") and (not A.Icecap:IsSpellLearned() or A.Icecap:IsSpellLearned() and A.IcyCitadel:GetAzeriteRank() > 0 and Unit(player):HasBuffs(A.PillarofFrostBuff.ID, true) < 6 and Unit(player):HasBuffs(A.PillarofFrostBuff.ID, true) > 0 or A.Icecap:IsSpellLearned() and A.IcyCitadel:GetAzeriteRank() == 0) then
                return A.GuardianofAzeroth:Show(icon)
            end
			
			-- reaping_flames
            if A.ReapingFlames:AutoHeartOfAzeroth(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") then
                return A.ReapingFlames:Show(icon)
            end
			
			-- moment_of_glory
            if A.MomentofGlory:AutoHeartOfAzeroth(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") then
                return A.MomentofGlory:Show(icon)
            end

			-- ReplicaofKnowledge
            if A.ReplicaofKnowledge:AutoHeartOfAzeroth(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") then
                return A.ReplicaofKnowledge:Show(icon)
            end		
			
            -- chill_streak,if=buff.pillar_of_frost.remains<5&buff.pillar_of_frost.up|Unit(unit):TimeToDie()<5
            if A.ChillStreak:IsReady(unit) and (Unit(player):HasBuffs(A.PillarofFrostBuff.ID, true) < 5 and Unit(player):HasBuffs(A.PillarofFrostBuff.ID, true) > 0 or Unit(unit):TimeToDie() < 5) then
                return A.ChillStreak:Show(icon)
            end
			
            -- the_unbound_force,if=buff.reckless_force.up|buff.reckless_force_counter.stack<11
            if A.TheUnboundForce:AutoHeartOfAzeroth(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") and (Unit(player):HasBuffs(A.RecklessForceBuff.ID, true) > 0 or Unit(player):HasBuffsStacks(A.RecklessForceCounterBuff.ID, true) < 11) then
                return A.TheUnboundForce:Show(icon)
            end
			
            -- focused_azerite_beam,if=!buff.pillar_of_frost.up&!buff.breath_of_sindragosa.up
            if A.FocusedAzeriteBeam:AutoHeartOfAzeroth(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") and (Unit(player):HasBuffs(A.PillarofFrostBuff.ID, true) == 0 and Unit(player):HasBuffs(A.BreathofSindragosaBuff.ID, true) == 0) then
                return A.FocusedAzeriteBeam:Show(icon)
            end
			
            -- concentrated_flame,if=!buff.pillar_of_frost.up&!buff.breath_of_sindragosa.up&dot.concentrated_flame_burn.remains=0
            if A.ConcentratedFlame:AutoHeartOfAzeroth(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") and (Unit(player):HasBuffs(A.PillarofFrostBuff.ID, true) == 0 and Unit(player):HasBuffs(A.BreathofSindragosaBuff.ID, true) == 0 and Unit(unit):HasDeBuffs(A.ConcentratedFlameBurn.ID, true) == 0) then
                return A.ConcentratedFlame:Show(icon)
            end
			
            -- purifying_blast,if=!buff.pillar_of_frost.up&!buff.breath_of_sindragosa.up
            if A.PurifyingBlast:AutoHeartOfAzeroth(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") and (Unit(player):HasBuffs(A.PillarofFrostBuff.ID, true) == 0 and Unit(player):HasBuffs(A.BreathofSindragosaBuff.ID, true) == 0) then
                return A.PurifyingBlast:Show(icon)
            end
			
	        -- worldvein_resonance,if=buff.pillar_of_frost.up|buff.empower_rune_weapon.up|cooldown.breath_of_sindragosa.remains>60+15
            if A.WorldveinResonance:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") and (Unit(player):HasBuffs(A.PillarofFrostBuff.ID, true) > 0 or Unit(player):HasBuffs(A.EmpowerRuneWeaponBuff.ID, true) > 0 or A.BreathofSindragosa:GetCooldown() > 60 + 15) then
                return A.WorldveinResonance:Show(icon)
            end
			
            -- ripple_in_space,if=!buff.pillar_of_frost.up&!buff.breath_of_sindragosa.up
            if A.RippleinSpace:AutoHeartOfAzeroth(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") and (Unit(player):HasBuffs(A.PillarofFrostBuff.ID, true) == 0 and Unit(player):HasBuffs(A.BreathofSindragosaBuff.ID, true) == 0) then
                return A.RippleinSpace:Show(icon)
            end

        end
        Essences = A.MakeFunctionCachedDynamic(Essences)
		        
        -- call precombat
        if Precombat(unit) and not profileStop and not inCombat and Unit(unit):IsExists() and unit ~= "mouseover" then 
            return true
        end

        -- In Combat
        if not profileStop and inCombat and CanCast and unit ~= "mouseover" then
           
		    -- auto_attack
			VarPoolForBoS = A.BurstIsON(unit) and A.BreathofSindragosa:IsSpellLearned() and 
			(
			    A.BreathofSindragosa:GetCooldown() < BoSPoolTime and Player:RunicPower() < BoSMinPower  
				or
				BoSisActive
				or
				BosUsage == "MACRO" and VarPoolForBoSQueue
			)
	        --print(VarPoolForBoS)
			
			-- Interrupt
            local Interrupt = Interrupts(unit)
            if Interrupt then 
                return Interrupt:Show(icon)
            end			
			
			-- Chains of Ice
			if A.IsInPvP and Unit(unit):IsMovingOut() and A.GetToggle(2, "UseChainsofIce") and A.ChainsofIce:AbsentImun(unit, Temp.TotalAndMag) and A.ChainsofIce:IsReady(unit) and Unit(unit):HasDeBuffs(A.ChainsofIce.ID, true) == 0 then
		   	    -- Notification					
	            Action.SendNotification(A.GetSpellInfo(A.ChainsofIce.ID) .. " on " .. unit, A.ChainsofIce.ID)
			    return A.ChainsofIce:Show(icon) 
			end
			
			-- Death Grip
			if Unit(unit):IsMovingOut() and A.GetToggle(2, "UseDeathGrip") and A.DeathGrip:AbsentImun(unit, Temp.TotalAndMag) and A.DeathGrip:IsReady(unit) and Unit(unit):GetRange() > 8 and Unit(unit):GetRange() <= 30 then
		   	    -- Notification					
	            Action.SendNotification(A.GetSpellInfo(A.DeathGrip.ID) .. " on " .. unit, A.DeathGrip.ID)
				return A.DeathGrip:Show(icon) 
			end
			
			-- Wraith Walk if out of range 
            if A.WraithWalk:IsReady(player) and A.WraithWalk:IsSpellLearned() and isMovingFor > A.GetToggle(2, "WraithWalkTime") and A.GetToggle(2, "UseWraithWalk") and CanCast then
				-- Notification					
	            Action.SendNotification("Using " .. A.GetSpellInfo(A.WraithWalk.ID), A.WraithWalk.ID)
                return A.WraithWalk:Show(icon)
            end
			
			-- Deaths Advance if out of range 
            if A.DeathsAdvance:IsReady(player) and isMovingFor > A.GetToggle(2, "DeathsAdvanceTime") and A.GetToggle(2, "UseDeathsAdvance") and CanCast then
				-- Notification					
	            Action.SendNotification("Using " .. A.GetSpellInfo(A.DeathsAdvance.ID), A.DeathsAdvance.ID)
                return A.DeathsAdvance:Show(icon)
            end
            
            -- use DeathStrike on low HP in Solo Mode
            if DeathStrikeHeal and A.DeathStrike:IsReady(unit) and A.DeathStrike:AbsentImun(unit, Temp.TotalAndPhys) then
                return A.DeathStrike:Show(icon) 
            end	
			
			-- COLD HEART ROTATION
            -- call_action_list,name=cold_heart,if=talent.cold_heart.enabled&((buff.cold_heart.stack>=10&debuff.razorice.stack=5)|target.time_to_die<=gcd)
            if A.ColdHeart:IsSpellLearned() and 
			(
			    (
				    Unit(player):HasBuffsStacks(A.ColdHeartBuff.ID, true) >= 10 and 
					(
					    Unit(unit):HasDeBuffsStacks(A.RazoriceDebuff.ID, true) == 5
						or 
						Unit(player):HasBuffsStacks(A.ColdHeartBuff.ID, true) >= 18
					)
					or 
					(
					    Unit(unit):TimeToDie() < A.GetGCD() and 
						(
						    UnitExists("boss1") 
						    or 
						    UnitClassification("target") == "worldboss" 
						    or 
						    UnitClassification("target") == "rareelite" 
						    or 
						    UnitClassification("target") == "rare"
						)
					)
				)
			)			 
		    then

                -- chains_of_ice,if=buff.icy_citadel.remains<8&buff.unholy_strength.remains<gcd*(1+cooldown.frostwyrms_fury.ready)&buff.unholy_strength.remains&buff.icy_citadel.up&!azerite.icy_citadel.enabled&azerite.icy_citadel.rank>2
                if A.ChainsofIce:IsReady(unit) and 
				(
				    Unit(player):HasBuffs(A.IcyCitadelBuff.ID, true) > 0 and 
				    A.IcyCitadel:GetAzeriteRank() > 1 and
				    (
				        (
     					    Unit(player):HasBuffsStacks(A.ColdHeartBuff.ID, true) >= 20
				            or
					        (
					            Unit(player):HasBuffs(A.UnholyStrengthBuff.ID, true) > 0 and 
					    	    Unit(player):HasBuffs(A.UnholyStrengthBuff.ID, true) < A.GetGCD() * 2 and 
						        Unit(player):HasBuffsStacks(A.ColdHeartBuff.ID, true) > 17
							)
				    	)
				    )
					or
					(
					    A.IcyCitadel:GetAzeriteRank() == 0 and 
						Unit(player):HasBuffsStacks(A.ColdHeartBuff.ID, true) >= 20
					)
				)
				then
                    return A.ChainsofIce:Show(icon)
                end

	            -- chains_of_ice,if=buff.cold_heart.stack>5&target.time_to_die<gcd
                if A.ChainsofIce:IsReady(unit) and Unit(player):HasBuffsStacks(A.ColdHeartBuff.ID, true) > 5 and Unit(unit):TimeToDie() <= A.GetGCD() then
                    return A.ChainsofIce:Show(icon)
                end
			
            end	

			-- call_action_list,name=essences
            if Essences(unit) then
                return true
            end
			
            -- pillar_of_frost,no BreathofSindragosa
            if A.PillarofFrost:IsReady(player) and Player:RunicPower() >= BoSMinPower and not A.BreathofSindragosa:IsSpellLearned() and not VarPoolForBoS and not VarPoolForBoSQueue then
                return A.PillarofFrost:Show(icon)
            end
			
            -- pillar_of_frost,no burst mode on
            if A.PillarofFrost:IsReady(player) and not A.BurstIsON(unit) then
                return A.PillarofFrost:Show(icon)
            end	
			
			-- howling_blast,if=!dot.frost_fever.ticking&(!talent.breath_of_sindragosa.enabled|cooldown.breath_of_sindragosa.remains>15)
            if A.HowlingBlast:IsReadyByPassCastGCD(unit) and A.HowlingBlast:AbsentImun(unit, Temp.TotalAndMag) and 
			(
			    Unit(unit):HasDeBuffs(A.FrostFeverDebuff.ID, true) == 0 and 
				(
				    not A.BreathofSindragosa:IsSpellLearned() 
					or 
					A.BreathofSindragosa:GetCooldown() > 15
				)
			)
			then
                return A.HowlingBlast:Show(icon)
            end
            
			-- glacial_advance,if=buff.icy_talons.remains<=gcd&buff.icy_talons.up&spell_targets.glacial_advance>=2&(!talent.breath_of_sindragosa.enabled|cooldown.breath_of_sindragosa.remains>15)
            if A.GlacialAdvance:IsReady(unit) and (Unit(player):HasBuffs(A.IcyTalonsBuff.ID, true) <= A.GetGCD() and Unit(player):HasBuffs(A.IcyTalonsBuff.ID, true) > 0 and GetByRange(2, 30) and (not A.BreathofSindragosa:IsSpellLearned() or A.BreathofSindragosa:GetCooldown() > 15)) then
                return A.GlacialAdvance:Show(icon)
            end
            
			-- frost_strike,if=buff.icy_talons.remains<=gcd&buff.icy_talons.up&(!talent.breath_of_sindragosa.enabled|cooldown.breath_of_sindragosa.remains>15)
            if A.FrostStrike:IsReady(unit) and A.FrostStrike:AbsentImun(unit, Temp.TotalAndPhys) and not VarPoolForBoS and (Unit(player):HasBuffs(A.IcyTalonsBuff.ID, true) <= A.GetGCD() and Unit(player):HasBuffs(A.IcyTalonsBuff.ID, true) > 0 and (not A.BreathofSindragosa:IsSpellLearned() or A.BreathofSindragosa:GetCooldown() > 15)) then
                return A.FrostStrike:Show(icon)
            end
 
	    	-- Non SIMC Custom Trinket1
	        if A.Trinket1:IsReady(unit) and Trinket1IsAllowed and CanCast and    
			(
    			TrinketsAoE and GetByRange(TrinketsMinUnits, TrinketsUnitsRange) and Player:AreaTTD(TrinketsUnitsRange) > TrinketsMinTTD
				or
				not TrinketsAoE and Unit(unit):TimeToDie() >= TrinketsMinTTD 					
			)
			then 
      	        return A.Trinket1:Show(icon)
   	        end 		
	        
		
		    -- Non SIMC Custom Trinket2
	        if A.Trinket2:IsReady(unit) and Trinket2IsAllowed and CanCast and	    
			(
    			TrinketsAoE and GetByRange(TrinketsMinUnits, TrinketsUnitsRange) and Player:AreaTTD(TrinketsUnitsRange) > TrinketsMinTTD
				or
				not TrinketsAoE and Unit(unit):TimeToDie() >= TrinketsMinTTD 					
			)
			then
      	       	return A.Trinket2:Show(icon) 	
	        end
			
            -- Defensives trinkets
            if Unit(player):CombatTime() > 0 and (Unit(player):HealthPercent() < 50 or Unit(player):TimeToDie() < 5) then 
                if A.Trinket1:IsReady(player) and Trinket1IsAllowed and A.Trinket1:GetItemCategory() ~= "DPS" then 
                    return A.Trinket1:Show(icon)
               end 
        
                if A.Trinket2:IsReady(player) and Trinket2IsAllowed and A.Trinket2:GetItemCategory() ~= "DPS" then 
                   return A.Trinket2:Show(icon)
                end
            end 
			
		    -- Burst Phase
		    if unit ~= "mouseover" and BurstIsON(unit) and inCombat and not profileStop then
                -- use_item,name=azsharas_font_of_power,if=(cooldown.empowered_rune_weapon.ready&!variable.other_on_use_equipped)|(cooldown.pillar_of_frost.remains<=10&variable.other_on_use_equipped)
                if A.AzsharasFontofPower:IsReady(player) and ((A.EmpowerRuneWeapon:GetCooldown() == 0 and not VarOtherOnUseEquipped) or (A.PillarofFrost:GetCooldown() <= 10 and VarOtherOnUseEquipped)) then
                    return A.AzsharasFontofPower:Show(icon)
                end
			
                -- use_item,name=lurkers_insidious_gift,if=talent.breath_of_sindragosa.enabled&((cooldown.pillar_of_frost.remains<=10&variable.other_on_use_equipped)|(buff.pillar_of_frost.up&!variable.other_on_use_equipped))|(buff.pillar_of_frost.up&!talent.breath_of_sindragosa.enabled)
                if A.LurkersInsidiousGift:IsReady(unit) and (A.BreathofSindragosa:IsSpellLearned() and ((A.PillarofFrost:GetCooldown() <= 10 and VarOtherOnUseEquipped) or (Unit(player):HasBuffs(A.PillarofFrostBuff.ID, true) > 0 and not VarOtherOnUseEquipped)) or (Unit(player):HasBuffs(A.PillarofFrostBuff.ID, true) > 0 and not A.BreathofSindragosa:IsSpellLearned())) then
                    return A.LurkersInsidiousGift:Show(icon)
                end
			
                -- use_item,name=cyclotronic_blast,if=!buff.pillar_of_frost.up
                if A.CyclotronicBlast:IsReady(unit) and (Unit(player):HasBuffs(A.PillarofFrostBuff.ID, true) == 0) then
                    return A.CyclotronicBlast:Show(icon)
                end
			
                -- use_items,if=(cooldown.pillar_of_frost.ready|cooldown.pillar_of_frost.remains>20)&(!talent.breath_of_sindragosa.enabled|cooldown.empower_rune_weapon.remains>95)
                -- use_item,name=ashvanes_razor_coral,if=debuff.razor_coral_debuff.down
               if A.AshvanesRazorCoral:IsReady(unit) and Unit(unit):HasDeBuffs(A.RazorCoralDebuff.ID, true) == 0 then
                    return A.AshvanesRazorCoral:Show(icon)
                end
			
                -- use_item,name=ashvanes_razor_coral,if=cooldown.empower_rune_weapon.remains>90&debuff.razor_coral_debuff.up&variable.other_on_use_equipped|buff.breath_of_sindragosa.up&debuff.razor_coral_debuff.up&!variable.other_on_use_equipped|buff.empower_rune_weapon.up&debuff.razor_coral_debuff.up&!talent.breath_of_sindragosa.enabled|Unit(unit):TimeToDie()<21
                if A.AshvanesRazorCoral:IsReady(unit) and (A.EmpowerRuneWeapon:GetCooldown() > 90 and Unit(unit):HasDeBuffs(A.RazorCoralDebuff.ID, true) > 0 and VarOtherOnUseEquipped or Unit(player):HasBuffs(A.BreathofSindragosaBuff.ID, true) > 0 and Unit(unit):HasDeBuffs(A.RazorCoralDebuff.ID, true) > 0 and not VarOtherOnUseEquipped or Unit(player):HasBuffs(A.EmpowerRuneWeaponBuff.ID, true) > 0 and Unit(unit):HasDeBuffs(A.RazorCoralDebuff.ID, true) > 0 and not A.BreathofSindragosa:IsSpellLearned() or Unit(unit):TimeToDie() < 21) then
                    return A.AshvanesRazorCoral:Show(icon)
                end
			
                -- use_item,name=jes_howler,if=(equipped.lurkers_insidious_gift&buff.pillar_of_frost.remains)|(!equipped.lurkers_insidious_gift&buff.pillar_of_frost.remains<12&buff.pillar_of_frost.up)
                if A.JesHowler:IsReady(unit) and ((A.LurkersInsidiousGift:IsExists() and Unit(player):HasBuffs(A.PillarofFrostBuff.ID, true) > 0) or (not A.LurkersInsidiousGift:IsExists() and Unit(player):HasBuffs(A.PillarofFrostBuff.ID, true) < 12 and Unit(player):HasBuffs(A.PillarofFrostBuff.ID, true) > 0)) then
                    return A.JesHowler:Show(icon)
                end
			
                -- use_item,name=knot_of_ancient_fury,if=cooldown.empower_rune_weapon.remains>40
                if A.KnotofAncientFuryAlliance:IsReady(unit) and (A.EmpowerRuneWeapon:GetCooldown() > 40) then
                    return A.KnotofAncientFuryAlliance:Show(icon)
                end
			
                -- use_item,name=knot_of_ancient_fury,if=cooldown.empower_rune_weapon.remains>40
                if A.KnotofAncientFuryHorde:IsReady(unit) and (A.EmpowerRuneWeapon:GetCooldown() > 40) then
                    return A.KnotofAncientFuryHorde:Show(icon)
                end
			
                -- use_item,name=grongs_primal_rage,if=rune<=3&!buff.pillar_of_frost.up&(!buff.breath_of_sindragosa.up|!talent.breath_of_sindragosa.enabled)
                if A.GrongsPrimalRage:IsReady(unit) and (Player:Rune() <= 3 and Unit(player):HasBuffs(A.PillarofFrostBuff.ID, true) == 0 and (Unit(player):HasBuffs(A.BreathofSindragosaBuff.ID, true) == 0 or not A.BreathofSindragosa:IsSpellLearned())) then
                    return A.GrongsPrimalRage:Show(icon)
                end
			
                -- use_item,name=razdunks_big_red_button
                if A.RazdunksBigRedButton:IsReady(unit) then
                    return A.RazdunksBigRedButton:Show(icon)
                end
			
                -- use_item,name=merekthas_fang,if=!buff.breath_of_sindragosa.up&!buff.pillar_of_frost.up
                if A.MerekthasFang:IsReady(player) --and (Unit(player):HasBuffs(A.BreathofSindragosaBuff.ID, true) == 0 and Unit(player):HasBuffs(A.PillarofFrostBuff.ID, true) == 0) 
				then
                    return A.MerekthasFang:Show(icon)
                end
			
                -- potion,if=buff.pillar_of_frost.up&buff.empower_rune_weapon.up
                if A.PotionofUnbridledFury:IsReady(unit) and Action.GetToggle(1, "Potion") and (Unit(player):HasBuffs(A.PillarofFrostBuff.ID, true) > 0 and Unit(player):HasBuffs(A.EmpowerRuneWeaponBuff.ID, true) > 0) then
                    return A.PotionofUnbridledFury:Show(icon)
                end
			    
                -- blood_fury,if=buff.pillar_of_frost.up&buff.empower_rune_weapon.up
                if A.BloodFury:AutoRacial(unit) and Action.GetToggle(1, "Racial") and A.BurstIsON(unit) and (Unit(player):HasBuffs(A.PillarofFrostBuff.ID, true) > 0 and Unit(player):HasBuffs(A.EmpowerRuneWeaponBuff.ID, true) > 0) then
                    return A.BloodFury:Show(icon)
                end
			
                -- berserking,if=buff.pillar_of_frost.up
                if A.Berserking:AutoRacial(unit) and Action.GetToggle(1, "Racial") and A.BurstIsON(unit) and (Unit(player):HasBuffs(A.PillarofFrostBuff.ID, true) > 0) then
                    return A.Berserking:Show(icon)
                end
			
                -- arcane_pulse,if=(!buff.pillar_of_frost.up&active_enemies>=2)|!buff.pillar_of_frost.up&(rune.deficit>=5&runic_power.deficit>=60)
                if A.ArcanePulse:AutoRacial(unit) and Action.GetToggle(1, "Racial") and ((Unit(player):HasBuffs(A.PillarofFrostBuff.ID, true) == 0 and MultiUnits:GetByRange(10) >= 2) or Unit(player):HasBuffs(A.PillarofFrostBuff.ID, true) == 0 and (Player:RuneDeficit() >= 5 and Player:RunicPowerDeficit() >= 60)) then
                    return A.ArcanePulse:Show(icon)
                end
			
                -- lights_judgment,if=buff.pillar_of_frost.up
                if A.LightsJudgment:IsReady(unit) and A.BurstIsON(unit) and (Unit(player):HasBuffs(A.PillarofFrostBuff.ID, true) > 0) then
                    return A.LightsJudgment:Show(icon)
                end
			
                -- ancestral_call,if=buff.pillar_of_frost.up&buff.empower_rune_weapon.up
                if A.AncestralCall:AutoRacial(unit) and Action.GetToggle(1, "Racial") and A.BurstIsON(unit) and (Unit(player):HasBuffs(A.PillarofFrostBuff.ID, true) > 0 and Unit(player):HasBuffs(A.EmpowerRuneWeaponBuff.ID, true) > 0) then
                    return A.AncestralCall:Show(icon)
                end
			
                -- fireblood,if=buff.pillar_of_frost.remains<=8&buff.empower_rune_weapon.up
                if A.Fireblood:AutoRacial(unit) and Action.GetToggle(1, "Racial") and A.BurstIsON(unit) and (Unit(player):HasBuffs(A.PillarofFrostBuff.ID, true) <= 8 and Unit(player):HasBuffs(A.EmpowerRuneWeaponBuff.ID, true) > 0) then
                    return A.Fireblood:Show(icon)
                end
				
                -- empower_rune_weapon,if=cooldown.pillar_of_frost.ready&talent.obliteration.enabled&rune.time_to_5>gcd&runic_power.deficit>=10|target.1.time_to_die<20
        --        if A.EmpowerRuneWeapon:IsReadyByPassCastGCD(player) and 
		--		(
		--		    A.PillarofFrost:GetCooldown() == 0 and A.Obliteration:IsSpellLearned() and Player:RuneTimeToX(5) > A.GetGCD() and (Player:RunicPower() >= BoSMinPower or not A.BreathofSindragosa:IsSpellLearned()) 
		--			or 
		--			Unit(unit):IsBoss() and Unit(unit):TimeToDie() < 20
		--		)
		--		then
       --             return A.EmpowerRuneWeapon:Show(icon)
       --         end	
				
                -- pillar_of_frost,if=(cooldown.empower_rune_weapon.remains|talent.icecap.enabled)&!buff.pillar_of_frost.up|talent.icecap.enabled&azerite.frostwhelps_indignation.enabled&buff.pillar_of_frost.remains<2
                if A.PillarofFrost:IsReady(player) and 
				(
				    (
					    A.EmpowerRuneWeapon:GetCooldown() 
						or 
						A.Icecap:IsSpellLearned()
					)
					and not Unit("player"):HasBuffs(A.PillarofFrostBuff.ID, true) 
					or 
					A.Icecap:IsSpellLearned() and A.FrostwhelpsIndignation:GetAzeriteRank() > 0 and Unit("player"):HasBuffs(A.PillarofFrostBuff.ID, true) < 2) 
				then
                    return A.PillarofFrost:Show(icon)
                end	
			
                -- empower_rune_weapon,if=(cooldown.pillar_of_frost.ready|Unit(unit):TimeToDie()<20)&talent.breath_of_sindragosa.enabled&runic_power>60
            --    if A.EmpowerRuneWeapon:IsReadyByPassCastGCD(player) and A.PillarofFrost:GetCooldown() == 0 and A.BreathofSindragosa:IsSpellLearned() and Player:RunicPower() > BoSMinPower then
            --       return A.EmpowerRuneWeapon:Show(icon)
            --    end

                -- empower_rune_weapon,if=talent.icecap.enabled&rune<3
                if A.EmpowerRuneWeapon:IsReadyByPassCastGCD(player) and not A.BreathofSindragosa:IsSpellLearned() and A.Icecap:IsSpellLearned() and Player:Rune() < 3 then
                    return A.EmpowerRuneWeapon:Show(icon)
                end
						
                -- pillar_of_frost,if=cooldown.empower_rune_weapon.remains
                if A.PillarofFrost:IsReady(player) and A.EmpowerRuneWeapon:GetCooldown() > 0 and (not A.BreathofSindragosa:IsSpellLearned() or A.BreathofSindragosa:IsSpellLearned() and A.BreathofSindragosa:GetCooldown() >= 45) then
                    return A.PillarofFrost:Show(icon)
                end		
				
				
				-- breath_of_sindragosa special logic builder
                if A.BreathofSindragosa:IsSpellLearned() and A.BreathofSindragosa:AbsentImun(unit, Temp.TotalAndMag) and A.BreathofSindragosa:IsReadyByPassCastGCD(unit, nil, nil, true) and BosUsage == "AUTO" then 
                    if GenerateBreathofSindragosa(meta, A.BreathofSindragosa, false, unit) then 
						-- Notification					
	                    Action.SendNotification("Building: " .. A.GetSpellInfo(A.BreathofSindragosa.ID) .. " burst.", A.BreathofSindragosa.ID)
                        return false 
                    end 
				end 				
--[[
                -- breath_of_sindragosa,use_off_gcd=1,if=cooldown.empower_rune_weapon.remains&cooldown.pillar_of_frost.remains
                if A.BreathofSindragosa:IsReadyByPassCastGCD(player) and A.BreathofSindragosa:IsSpellLearned() and GetByRange(BoSEnemies, BoSEnemiesRange) and
			    (A.EmpowerRuneWeapon:GetCooldown() > 0 and A.PillarofFrost:GetCooldown() > 0) 
			    --and Unit(player):HasBuffs(A.PillarofFrostBuff.ID, true) > 0  and Unit(player):HasBuffs(A.PillarofFrostBuff.ID, true) < 4 
			    then
                    return A.BreathofSindragosa:Show(icon)
                end			
]]--
                -- frostwyrms_fury,if=(buff.pillar_of_frost.up&azerite.icy_citadel.rank<=1&(buff.pillar_of_frost.remains<=gcd|buff.unholy_strength.remains<=gcd&buff.unholy_strength.up))
                if A.FrostwyrmsFury:IsReady(unit) and A.FrostwyrmsFury:AbsentImun(unit, Temp.TotalAndMag) and ((Unit(player):HasBuffs(A.PillarofFrostBuff.ID, true) > 0 and A.IcyCitadel:GetAzeriteRank() <= 1 and (Unit(player):HasBuffs(A.PillarofFrostBuff.ID, true) <= A.GetGCD() or Unit(player):HasBuffs(A.UnholyStrengthBuff.ID, true) <= A.GetGCD() and Unit(player):HasBuffs(A.UnholyStrengthBuff.ID, true) > 0))) then
                    return A.FrostwyrmsFury:Show(icon)
                end
			
                -- frostwyrms_fury,if=(buff.icy_citadel.up&!talent.icecap.enabled&(buff.unholy_strength.up|buff.icy_citadel.remains<=gcd))|buff.icy_citadel.up&buff.icy_citadel.remains<=gcd&talent.icecap.enabled&buff.pillar_of_frost.up
                if A.FrostwyrmsFury:IsReady(unit) and A.FrostwyrmsFury:AbsentImun(unit, Temp.TotalAndMag) and ((Unit(player):HasBuffs(A.IcyCitadelBuff.ID, true) > 0 and not A.Icecap:IsSpellLearned() and (Unit(player):HasBuffs(A.UnholyStrengthBuff.ID, true) > 0 or Unit(player):HasBuffs(A.IcyCitadelBuff.ID, true) <= A.GetGCD())) or Unit(player):HasBuffs(A.IcyCitadelBuff.ID, true) > 0 and Unit(player):HasBuffs(A.IcyCitadelBuff.ID, true) <= A.GetGCD() and A.Icecap:IsSpellLearned() and Unit(player):HasBuffs(A.PillarofFrostBuff.ID, true) > 0) then
                    return A.FrostwyrmsFury:Show(icon)
                end
			
                -- frostwyrms_fury,if=Unit(unit):TimeToDie()<gcd|(Unit(unit):TimeToDie()<cooldown.pillar_of_frost.remains&buff.unholy_strength.up)
                if A.FrostwyrmsFury:IsReady(unit) and A.FrostwyrmsFury:AbsentImun(unit, Temp.TotalAndMag) and (Unit(unit):TimeToDie() < A.GetGCD() or (Unit(unit):TimeToDie() < A.PillarofFrost:GetCooldown() and Unit(player):HasBuffs(A.UnholyStrengthBuff.ID, true) > 0)) then
                    return A.FrostwyrmsFury:Show(icon)
                end
            end

            -- run_action_list,name=bos_pooling,if=talent.breath_of_sindragosa.enabled&((cooldown.breath_of_sindragosa.remains=0&cooldown.pillar_of_frost.remains<10)|(cooldown.breath_of_sindragosa.remains<20&target.1.time_to_die<35))
        --    if A.BreathofSindragosa:IsSpellLearned() and A.BurstIsON(unit) and 
		--	(
		--	    (A.BreathofSindragosa:GetCooldown() < 5 and A.PillarofFrost:GetCooldown() < 10) 
		---		or 
		--		(A.BreathofSindragosa:GetCooldown() < 20 and Unit(unit):IsBoss() and Unit(unit):TimeToDie() < 35)
		--	)
		--	then
         --       return BosPooling(unit)
          --  end
            
			-- BREATH OF SINDRAGOSA POOL
			
			-- run_action_list,name=bos_pooling,if=talent.breath_of_sindragosa.enabled&((cooldown.breath_of_sindragosa.remains=0&cooldown.pillar_of_frost.remains<10)|(cooldown.breath_of_sindragosa.remains<20&Unit(unit):TimeToDie()<35))
            if A.BreathofSindragosa:IsSpellLearned() and A.BreathofSindragosa:GetCooldown() <= BoSPoolTime then
                -- howling_blast,if=buff.rime.up
                if A.HowlingBlast:IsReadyByPassCastGCD(unit) and A.HowlingBlast:AbsentImun(unit, Temp.TotalAndMag) and Unit(unit):GetRange() < 30 and Unit(player):HasBuffs(A.RimeBuff.ID, true) > 0 then
                    return A.HowlingBlast:Show(icon)
                end
			
                -- obliterate,target_if=(debuff.razorice.stack<5|debuff.razorice.remains<10)&rune.time_to_4<gcd&runic_power.deficit>=25&!talent.frostscythe.enabled
                if A.Obliterate:IsReadyByPassCastGCD(unit) and A.Obliterate:AbsentImun(unit, Temp.TotalAndPhys) and ((Unit(unit):HasDeBuffsStacks(A.RazoriceDebuff.ID, true) < 5 or Unit(unit):HasDeBuffs(A.RazoriceDebuff.ID, true) < 10) and Player:RuneTimeToX(4) < A.GetGCD() and Player:RunicPowerDeficit() >= 25 and not A.Frostscythe:IsSpellLearned()) then
                   return A.Obliterate:Show(icon)
                end
			
                -- obliterate,if=rune.time_to_4<gcd&runic_power.deficit>=25
                if A.Obliterate:IsReadyByPassCastGCD(unit) and A.Obliterate:AbsentImun(unit, Temp.TotalAndPhys) and (Player:RuneTimeToX(4) < A.GetGCD() and Player:RunicPowerDeficit() >= 25) then
                    return A.Obliterate:Show(icon)
                end
			
                -- glacial_advance,if=runic_power.deficit<20&cooldown.pillar_of_frost.remains>rune.time_to_4&spell_targetA.glacial_advance>=2
                if A.GlacialAdvance:IsReady(unit) and (Player:RunicPowerDeficit() < 20 and A.PillarofFrost:GetCooldown() > Player:RuneTimeToX(4) and GetByRange(2, 30)) then
                    return A.GlacialAdvance:Show(icon)
                end
			
                -- frost_strike,if=runic_power.deficit<20&cooldown.pillar_of_frost.remains>rune.time_to_4
                if A.FrostStrike:IsReady(unit) and A.FrostStrike:AbsentImun(unit, Temp.TotalAndPhys) and not VarPoolForBoS and (Player:RunicPowerDeficit() < 20 and A.PillarofFrost:GetCooldown() > Player:RuneTimeToX(4)) then
                    return A.FrostStrike:Show(icon)
                end
			
                -- frost_strike,target_if=(debuff.razorice.stack<5|debuff.razorice.remains<10)&runic_power.deficit<20&cooldown.pillar_of_frost.remains>rune.time_to_4&!talent.frostscythe.enabled
                if A.FrostStrike:IsReady(unit) and A.FrostStrike:AbsentImun(unit, Temp.TotalAndPhys) and not VarPoolForBoS and ((Unit(unit):HasDeBuffsStacks(A.RazoriceDebuff.ID, true) < 5 or Unit(unit):HasDeBuffs(A.RazoriceDebuff.ID, true) < 10) and Player:RunicPowerDeficit() < 20 and A.PillarofFrost:GetCooldown() > Player:RuneTimeToX(4) and not A.Frostscythe:IsSpellLearned()) then
                    return A.FrostStrike:Show(icon)
                end
			
                -- frostscythe,if=buff.killing_machine.up&runic_power.deficit>(15+talent.runic_attenuation.enabled*3)&spell_targetA.frostscythe>=2
                if A.Frostscythe:IsReady(player) and A.Frostscythe:AbsentImun(unit, Temp.TotalAndPhys) and (Unit(player):HasBuffs(A.KillingMachineBuff.ID, true) > 0 and Player:RunicPowerDeficit() > (15 + num(A.RunicAttenuation:IsSpellLearned()) * 3) and GetByRange(2, 8)) then
                    return A.Frostscythe:Show(icon)
                end
			
                -- frostscythe,if=runic_power.deficit>=(35+talent.runic_attenuation.enabled*3)&spell_targetA.frostscythe>=2
                if A.Frostscythe:IsReady(player) and A.Frostscythe:AbsentImun(unit, Temp.TotalAndPhys) and (Player:RunicPowerDeficit() >= (35 + num(A.RunicAttenuation:IsSpellLearned()) * 3) and GetByRange(2, 8)) then
                    return A.Frostscythe:Show(icon)
                end
			
                -- obliterate,target_if=(debuff.razorice.stack<5|debuff.razorice.remains<10)&runic_power.deficit>=(35+talent.runic_attenuation.enabled*3)&!talent.frostscythe.enabled
                if A.Obliterate:IsReadyByPassCastGCD(unit) and A.Obliterate:AbsentImun(unit, Temp.TotalAndPhys) and ((Unit(unit):HasDeBuffsStacks(A.RazoriceDebuff.ID, true) < 5 or Unit(unit):HasDeBuffs(A.RazoriceDebuff.ID, true) < 10) and Player:RunicPowerDeficit() >= (35 + num(A.RunicAttenuation:IsSpellLearned()) * 3) and not A.Frostscythe:IsSpellLearned()) then
                    return A.Obliterate:Show(icon)
                end
			
                -- obliterate,if=runic_power.deficit>=(35+talent.runic_attenuation.enabled*3)
                if A.Obliterate:IsReadyByPassCastGCD(unit) and A.Obliterate:AbsentImun(unit, Temp.TotalAndPhys) and (Player:RunicPowerDeficit() >= (35 + num(A.RunicAttenuation:IsSpellLearned()) * 3)) then
                    return A.Obliterate:Show(icon)
                end
			
               -- glacial_advance,if=cooldown.pillar_of_frost.remains>rune.time_to_4&runic_power.deficit<40&spell_targetA.glacial_advance>=2
               if A.GlacialAdvance:IsReady(unit) and (A.PillarofFrost:GetCooldown() > Player:RuneTimeToX(4) and Player:RunicPowerDeficit() < 40 and GetByRange(2, 30)) then
                    return A.GlacialAdvance:Show(icon)
                end
			
                -- frost_strike,target_if=(debuff.razorice.stack<5|debuff.razorice.remains<10)&cooldown.pillar_of_frost.remains>rune.time_to_4&runic_power.deficit<40&!talent.frostscythe.enabled
                if A.FrostStrike:IsReady(unit) and A.FrostStrike:AbsentImun(unit, Temp.TotalAndPhys) and not VarPoolForBoS and ((Unit(unit):HasDeBuffsStacks(A.RazoriceDebuff.ID, true) < 5 or Unit(unit):HasDeBuffs(A.RazoriceDebuff.ID, true) < 10) and A.PillarofFrost:GetCooldown() > Player:RuneTimeToX(4) and Player:RunicPowerDeficit() < 40 and not A.Frostscythe:IsSpellLearned()) then
                    return A.FrostStrike:Show(icon)
                end
			
                -- frost_strike,if=cooldown.pillar_of_frost.remains>rune.time_to_4&runic_power.deficit<40
                if A.FrostStrike:IsReady(unit) and A.FrostStrike:AbsentImun(unit, Temp.TotalAndPhys) and not VarPoolForBoS and (A.PillarofFrost:GetCooldown() > Player:RuneTimeToX(4) and Player:RunicPowerDeficit() < 40) then
                    return A.FrostStrike:Show(icon)
                end
            end
            
			-- BREATH OF SINDRAGOSA ACTIVE
            if BoSisActive then
                
				-- memory_of_lucid_dreams,if=buff.empower_rune_weapon.remains<5&buff.breath_of_sindragosa.up|(rune.time_to_2>gcd&runic_power<50)
                if A.MemoryofLucidDreams:AutoHeartOfAzeroth(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") and 
		    	(
			        Unit(player):HasBuffs(A.EmpowerRuneWeaponBuff.ID, true) < 8 
			    	or 
		    		Player:RuneTimeToX(3) > A.GetGCD()
			    	or 
		    		A.BreathofSindragosa:GetSpellTimeSinceLastCast() >= LucidDreamUseAfter and Player:Rune() < LucidDreamPower
		    	) 
		    	then
                    return A.MemoryofLucidDreams:Show(icon)
                end	
			
                -- arcane_torrent
                if A.ArcaneTorrent:IsRacialReady(unit) and 
				(
				    (Unit(player):HasBuffs(A.BreathofSindragosa.ID, true) > 0 and Player:RuneTimeToX(3) > A.GetGCD() and Player:RunicPower() <= 80) 
					or 
					not A.BreathofSindragosa:IsSpellLearned() and Player:RunicPowerDeficit() >= 20
				)  
				then
                    return A.ArcaneTorrent:Show(icon)
                end	
				
                -- obliterate,target_if=(debuff.razorice.stack<5|debuff.razorice.remains<10)&runic_power<=30&!talent.frostscythe.enabled
                if A.Obliterate:IsReadyByPassCastGCD(unit) and A.Obliterate:AbsentImun(unit, Temp.TotalAndPhys) and ((Unit(unit):HasDeBuffsStacks(A.RazoriceDebuff.ID, true) < 5 or Unit(unit):HasDeBuffs(A.RazoriceDebuff.ID, true) < 10) and Player:RunicPower() <= 30 and not A.Frostscythe:IsSpellLearned()) then
                    return A.Obliterate:Show(icon)
                end
			
               -- obliterate,if=runic_power<=30
                if A.Obliterate:IsReadyByPassCastGCD(unit) and A.Obliterate:AbsentImun(unit, Temp.TotalAndPhys) and (Player:RunicPower() <= 80 - num(A.RunicAttenuation:IsSpellLearned()) * 3 + num(Unit(unit):HasDeBuffs(A.FrostFeverDebuff.ID, true) > 0) * 5) then
                    return A.Obliterate:Show(icon)
                end
			
                -- remorseless_winter,if=talent.gathering_storm.enabled
                if A.RemorselessWinter:IsReady(player) and Unit(unit):GetRange() <= 8 and A.GatheringStorm:IsSpellLearned() and Player:AreaTTD(20) >= 4 then
                    return A.RemorselessWinter:Show(icon)
                end
			
                -- howling_blast,if=buff.rime.up
                if A.HowlingBlast:IsReadyByPassCastGCD(unit) and A.HowlingBlast:AbsentImun(unit, Temp.TotalAndMag) and Unit(unit):GetRange() < 30 and Unit(player):HasBuffs(A.RimeBuff.ID, true) > 0 then
                    return A.HowlingBlast:Show(icon)
                end
			
                -- obliterate,target_if=(debuff.razorice.stack<5|debuff.razorice.remains<10)&rune.time_to_5<gcd|runic_power<=45&!talent.frostscythe.enabled
                if A.Obliterate:IsReadyByPassCastGCD(unit) and A.Obliterate:AbsentImun(unit, Temp.TotalAndPhys) and ((Unit(unit):HasDeBuffsStacks(A.RazoriceDebuff.ID, true) < 5 or Unit(unit):HasDeBuffs(A.RazoriceDebuff.ID, true) < 10) and Player:RuneTimeToX(5) < A.GetGCD() or Player:RunicPower() <= 45 and not A.Frostscythe:IsSpellLearned()) then
                   return A.Obliterate:Show(icon)
                end
			
                -- obliterate,if=rune.time_to_5<gcd|runic_power<=45
                if A.Obliterate:IsReadyByPassCastGCD(unit) and A.Obliterate:AbsentImun(unit, Temp.TotalAndPhys) and (Player:RuneTimeToX(5) < A.GetGCD() or Player:RunicPower() <= 45) then
                    return A.Obliterate:Show(icon)
                end
			
                -- frostscythe,if=buff.killing_machine.up&spell_targetA.frostscythe>=2
                if A.Frostscythe:IsReady(player) and A.Frostscythe:AbsentImun(unit, Temp.TotalAndPhys) and (Unit(player):HasBuffs(A.KillingMachineBuff.ID, true) > 0 and GetByRange(2, 8)) then
                   return A.Frostscythe:Show(icon)
                end
			
                -- horn_of_winter,if=runic_power.deficit>=30&rune.time_to_3>gcd
                if A.HornofWinter:IsReady(player) and A.HornofWinter:IsSpellLearned() and (Player:RunicPowerDeficit() >= 30 and Player:RuneTimeToX(3) > A.GetGCD()) then
                    return A.HornofWinter:Show(icon)
                end
			
                -- remorseless_winter
                if A.RemorselessWinter:IsReady(player) and Unit(unit):GetRange() <= 8 and Player:AreaTTD(20) >= 4 then
                    return A.RemorselessWinter:Show(icon)
                end
		    	
                -- frostscythe,if=spell_targetA.frostscythe>=2
                if A.Frostscythe:IsReady(player) and A.Frostscythe:AbsentImun(unit, Temp.TotalAndPhys) and (GetByRange(2, 8)) then
                    return A.Frostscythe:Show(icon)
                end
			
                -- obliterate,target_if=(debuff.razorice.stack<5|debuff.razorice.remains<10)&runic_power.deficit>25|rune>3&!talent.frostscythe.enabled
                if A.Obliterate:IsReadyByPassCastGCD(unit) and A.Obliterate:AbsentImun(unit, Temp.TotalAndPhys) and ((Unit(unit):HasDeBuffsStacks(A.RazoriceDebuff.ID, true) < 5 or Unit(unit):HasDeBuffs(A.RazoriceDebuff.ID, true) < 10) and Player:RunicPowerDeficit() > 25 or Player:Rune() > 3 and not A.Frostscythe:IsSpellLearned()) then
                    return A.Obliterate:Show(icon)
                end
			
                -- obliterate,if=runic_power.deficit>25|rune>3
                if A.Obliterate:IsReadyByPassCastGCD(unit) and A.Obliterate:AbsentImun(unit, Temp.TotalAndPhys) and (Player:RunicPowerDeficit() > 25 or Player:Rune() > 3) then
                    return A.Obliterate:Show(icon)
                end
			

            end
            
			-- OBLITERATION ROTATION
			-- run_action_list,name=obliteration,if=buff.pillar_of_frost.up&talent.obliteration.enabled
            if Unit(player):HasBuffs(A.PillarofFrostBuff.ID, true) > 0 and A.Obliteration:IsSpellLearned() then
			
                -- remorseless_winter,if=talent.gathering_storm.enabled
                if A.RemorselessWinter:IsReady(player) and Unit(unit):GetRange() <= 8 and (A.GatheringStorm:IsSpellLearned()) and Player:AreaTTD(20) >= 4 then
                    return A.RemorselessWinter:Show(icon)
                end
			
                -- obliterate,target_if=(debuff.razorice.stack<5|debuff.razorice.remains<10)&!talent.frostscythe.enabled&!buff.rime.up&spell_targetA.howling_blast>=3
                if A.Obliterate:IsReadyByPassCastGCD(unit) and A.Obliterate:AbsentImun(unit, Temp.TotalAndPhys) and ((Unit(unit):HasDeBuffsStacks(A.RazoriceDebuff.ID, true) < 5 or Unit(unit):HasDeBuffs(A.RazoriceDebuff.ID, true) < 10) and not A.Frostscythe:IsSpellLearned() and Unit(player):HasBuffs(A.RimeBuff.ID, true) == 0 and GetByRange(3, 30)) then
                    return A.Obliterate:Show(icon)
                end
			
                -- obliterate,if=!talent.frostscythe.enabled&!buff.rime.up&spell_targetA.howling_blast>=3
                if A.Obliterate:IsReadyByPassCastGCD(unit) and A.Obliterate:AbsentImun(unit, Temp.TotalAndPhys) and (not A.Frostscythe:IsSpellLearned() and Unit(player):HasBuffs(A.RimeBuff.ID, true) == 0 and GetByRange(3, 10)) then
                    return A.Obliterate:Show(icon)
                end
			
                -- frostscythe,if=(buff.killing_machine.react|(buff.killing_machine.up&(prev_gcd.1.frost_strike|prev_gcd.1.howling_blast|prev_gcd.1.glacial_advance)))&spell_targetA.frostscythe>=2
                if A.Frostscythe:IsReady(player) and A.Frostscythe:AbsentImun(unit, Temp.TotalAndPhys) and ((Unit(player):HasBuffsStacks(A.KillingMachineBuff.ID, true) > 0 or (Unit(player):HasBuffs(A.KillingMachineBuff.ID, true) > 0 and (A.LastPlayerCastName == A.FrostStrike:Info() or A.LastPlayerCastName == A.HowlingBlast:Info() or A.LastPlayerCastName == A.GlacialAdvance:Info()))) and GetByRange(2, 8)) then
                    return A.Frostscythe:Show(icon)
                end
			
                -- obliterate,target_if=(debuff.razorice.stack<5|debuff.razorice.remains<10)&buff.killing_machine.react|(buff.killing_machine.up&(prev_gcd.1.frost_strike|prev_gcd.1.howling_blast|prev_gcd.1.glacial_advance))
                if A.Obliterate:IsReadyByPassCastGCD(unit) and A.Obliterate:AbsentImun(unit, Temp.TotalAndPhys) and ((Unit(unit):HasDeBuffsStacks(A.RazoriceDebuff.ID, true) < 5 or Unit(unit):HasDeBuffs(A.RazoriceDebuff.ID, true) < 10) and Unit(player):HasBuffsStacks(A.KillingMachineBuff.ID, true) > 0 or (Unit(player):HasBuffs(A.KillingMachineBuff.ID, true) > 0 and (A.LastPlayerCastName == A.FrostStrike:Info() or A.LastPlayerCastName == A.HowlingBlast:Info() or A.LastPlayerCastName == A.GlacialAdvance:Info()))) then
                    return A.Obliterate:Show(icon)
                end
			
                -- obliterate,if=buff.killing_machine.react|(buff.killing_machine.up&(prev_gcd.1.frost_strike|prev_gcd.1.howling_blast|prev_gcd.1.glacial_advance))
                if A.Obliterate:IsReadyByPassCastGCD(unit) and A.Obliterate:AbsentImun(unit, Temp.TotalAndPhys) and (Unit(player):HasBuffsStacks(A.KillingMachineBuff.ID, true) > 0 or (Unit(player):HasBuffs(A.KillingMachineBuff.ID, true) > 0 and (A.LastPlayerCastName == A.FrostStrike:Info() or A.LastPlayerCastName == A.HowlingBlast:Info() or A.LastPlayerCastName == A.GlacialAdvance:Info()))) then
                    return A.Obliterate:Show(icon)
                end
			
                -- glacial_advance,if=(!buff.rime.up|runic_power.deficit<10|rune.time_to_2>gcd)&spell_targetA.glacial_advance>=2
                if A.GlacialAdvance:IsReady(unit) and ((Unit(player):HasBuffs(A.RimeBuff.ID, true) == 0 or Player:RunicPowerDeficit() < 10 or Player:RuneTimeToX(2) > A.GetGCD()) and GetByRange(2, 30)) then
                    return A.GlacialAdvance:Show(icon)
                end
			
                -- howling_blast,if=buff.rime.up&spell_targetA.howling_blast>=2
                if A.HowlingBlast:IsReadyByPassCastGCD(unit) and A.HowlingBlast:AbsentImun(unit, Temp.TotalAndMag) and Unit(player):HasBuffs(A.RimeBuff.ID, true) > 0 and GetByRange(2, 10) then
                    return A.HowlingBlast:Show(icon)
                end
			
                -- frost_strike,target_if=(debuff.razorice.stack<5|debuff.razorice.remains<10)&!buff.rime.up|runic_power.deficit<10|rune.time_to_2>gcd&!talent.frostscythe.enabled
                if A.FrostStrike:IsReady(unit) and A.FrostStrike:AbsentImun(unit, Temp.TotalAndPhys) and not VarPoolForBoS and ((Unit(unit):HasDeBuffsStacks(A.RazoriceDebuff.ID, true) < 5 or Unit(unit):HasDeBuffs(A.RazoriceDebuff.ID, true) < 10) and Unit(player):HasBuffs(A.RimeBuff.ID, true) == 0 or Player:RunicPowerDeficit() < 10 or Player:RuneTimeToX(2) > A.GetGCD() and not A.Frostscythe:IsSpellLearned()) then
                    return A.FrostStrike:Show(icon)
                end
			
                -- frost_strike,if=!buff.rime.up|runic_power.deficit<10|rune.time_to_2>gcd
                if A.FrostStrike:IsReady(unit) and A.FrostStrike:AbsentImun(unit, Temp.TotalAndPhys) and not VarPoolForBoS and (Unit(player):HasBuffs(A.RimeBuff.ID, true) == 0 or Player:RunicPowerDeficit() < 10 or Player:RuneTimeToX(2) > A.GetGCD()) then
                    return A.FrostStrike:Show(icon)
                end
			
                -- howling_blast,if=buff.rime.up
                if A.HowlingBlast:IsReadyByPassCastGCD(unit) and A.HowlingBlast:AbsentImun(unit, Temp.TotalAndMag) and Unit(player):HasBuffs(A.RimeBuff.ID, true) > 0 then
                    return A.HowlingBlast:Show(icon)
                end
			
                -- obliterate,target_if=(debuff.razorice.stack<5|debuff.razorice.remains<10)&!talent.frostscythe.enabled
                if A.Obliterate:IsReadyByPassCastGCD(unit) and A.Obliterate:AbsentImun(unit, Temp.TotalAndPhys) and ((Unit(unit):HasDeBuffsStacks(A.RazoriceDebuff.ID, true) < 5 or Unit(unit):HasDeBuffs(A.RazoriceDebuff.ID, true) < 10) and not A.Frostscythe:IsSpellLearned()) then
                    return A.Obliterate:Show(icon)
                end
			
                -- obliterate
                if A.Obliterate:IsReadyByPassCastGCD(unit) and A.Obliterate:AbsentImun(unit, Temp.TotalAndPhys) then
                    return A.Obliterate:Show(icon)
                end
            end
            
			-- AoE ROTATION
			-- run_action_list,name=aoe,if=active_enemies>=2
            if (isMulti or GetToggle(2, "AoE")) and MultiUnits:GetByRange(MaxAoERange) > MinAoETargets and Unit(player):HasBuffs(A.BreathofSindragosaBuff.ID, true) == 0 and CanCast then
			
		        -- blood_of_the_enemy,if=(cooldown.death_and_decay.remains&spell_targets.death_and_decay>1)|(cooldown.defile.remains&spell_targets.defile>1)|(cooldown.apocalypse.remains&cooldown.death_and_decay.ready)
                if A.BloodoftheEnemy:AutoHeartOfAzerothP(unit, true) and A.BloodoftheEnemy:AbsentImun(unit, Temp.TotalAndMag) and BloodoftheEnemySyncAoE and BurstIsON(unit) and HeartOfAzeroth and 
			    (
			        Unit(player):HasBuffs(A.BreathofSindragosaBuff.ID, true) > 0 and Player:AreaTTD(MaxAoERange) >= BloodoftheEnemyAoETTD and MultiUnits:GetByRange(MaxAoERange) >= BloodoftheEnemyUnits
					or
					Unit(unit):IsBoss()
				
			    )
			    then
                    return A.BloodoftheEnemy:Show(icon)
                end	
				
                -- frostscythe,if=buff.killing_machine.up
                if A.Frostscythe:IsReady(player) and GetByRange(2, 8) and A.Frostscythe:AbsentImun(unit, Temp.TotalAndPhys) then
                    return A.Frostscythe:Show(icon)
                end
				
                -- remorseless_winter,if=talent.gathering_storm.enabled|(azerite.frozen_tempest.rank&spell_targetA.remorseless_winter>=3&!buff.rime.up)
                if A.RemorselessWinter:IsReady(player) and Unit(unit):GetRange() <= 8 and CanCast and (A.GatheringStorm:IsSpellLearned() or (A.FrozenTempest:GetAzeriteRank() > 0 and GetByRange(3, 8) and Unit(player):HasBuffs(A.RimeBuff.ID, true) == 0)) and Player:AreaTTD(20) >= 4 then
                    return A.RemorselessWinter:Show(icon)
                end
			
                -- glacial_advance,if=talent.frostscythe.enabled
                if A.GlacialAdvance:IsReady(unit) and A.Frostscythe:IsSpellLearned() then
                    return A.GlacialAdvance:Show(icon)
                end
			
                -- frost_strike,target_if=(debuff.razorice.stack<5|debuff.razorice.remains<10)&cooldown.remorseless_winter.remains<=2*gcd&talent.gathering_storm.enabled&!talent.frostscythe.enabled
                if A.FrostStrike:IsReady(unit) and A.FrostStrike:AbsentImun(unit, Temp.TotalAndPhys) and not VarPoolForBoS and ((Unit(unit):HasDeBuffsStacks(A.RazoriceDebuff.ID, true) < 5 or Unit(unit):HasDeBuffs(A.RazoriceDebuff.ID, true) < 10) and A.RemorselessWinter:GetCooldown() <= 2 * A.GetGCD() and A.GatheringStorm:IsSpellLearned() and not A.Frostscythe:IsSpellLearned()) then
                    return A.FrostStrike:Show(icon)
                end
			
                -- frost_strike,if=cooldown.remorseless_winter.remains<=2*gcd&talent.gathering_storm.enabled
                if A.FrostStrike:IsReady(unit) and A.FrostStrike:AbsentImun(unit, Temp.TotalAndPhys) and not VarPoolForBoS and (A.RemorselessWinter:GetCooldown() <= 2 * A.GetGCD() and A.GatheringStorm:IsSpellLearned()) then
                    return A.FrostStrike:Show(icon)
                end
			
                -- howling_blast,if=buff.rime.up
                if A.HowlingBlast:IsReadyByPassCastGCD(unit) and Unit(unit):GetRange() < 30 and Unit(player):HasBuffs(A.RimeBuff.ID, true) > 0 then
                    return A.HowlingBlast:Show(icon)
                end
			
                -- frostscythe,if=buff.killing_machine.up
                if A.Frostscythe:IsReady(player) and A.Frostscythe:AbsentImun(unit, Temp.TotalAndPhys) and GetByRange(2, 8) and (Unit(player):HasBuffs(A.KillingMachineBuff.ID, true) > 0) then
                    return A.Frostscythe:Show(icon)
                end
			
                -- glacial_advance,if=runic_power.deficit<(15+talent.runic_attenuation.enabled*3)
                if A.GlacialAdvance:IsReady(unit) and (Player:RunicPowerDeficit() < (15 + num(A.RunicAttenuation:IsSpellLearned()) * 3)) then
                    return A.GlacialAdvance:Show(icon)
                end
			
                -- frost_strike,target_if=(debuff.razorice.stack<5|debuff.razorice.remains<10)&runic_power.deficit<(15+talent.runic_attenuation.enabled*3)&!talent.frostscythe.enabled
                if A.FrostStrike:IsReady(unit) and A.FrostStrike:AbsentImun(unit, Temp.TotalAndPhys) and not VarPoolForBoS and ((Unit(unit):HasDeBuffsStacks(A.RazoriceDebuff.ID, true) < 5 or Unit(unit):HasDeBuffs(A.RazoriceDebuff.ID, true) < 10) and Player:RunicPowerDeficit() < (15 + num(A.RunicAttenuation:IsSpellLearned()) * 3) and not A.Frostscythe:IsSpellLearned()) then
                    return A.FrostStrike:Show(icon)
                end
			
                -- frost_strike,if=runic_power.deficit<(15+talent.runic_attenuation.enabled*3)
                if A.FrostStrike:IsReady(unit) and A.FrostStrike:AbsentImun(unit, Temp.TotalAndPhys) and not VarPoolForBoS and (Player:RunicPowerDeficit() < (15 + num(A.RunicAttenuation:IsSpellLearned()) * 3)) and Player:Rune() <= 2 then
                    return A.FrostStrike:Show(icon)
                end
			
                -- remorseless_winter
                if A.RemorselessWinter:IsReady(player) and Unit(unit):GetRange() <= 8 and Player:AreaTTD(20) >= 4 then
                    return A.RemorselessWinter:Show(icon)
                end
			
                -- frostscythe
                if A.Frostscythe:IsReady(player) and A.Frostscythe:AbsentImun(unit, Temp.TotalAndPhys) and GetByRange(2, 8) then
                    return A.Frostscythe:Show(icon)
                end
			
                -- obliterate,target_if=(debuff.razorice.stack<5|debuff.razorice.remains<10)&runic_power.deficit>(25+talent.runic_attenuation.enabled*3)&!talent.frostscythe.enabled
                if A.Obliterate:IsReadyByPassCastGCD(unit) and A.Obliterate:AbsentImun(unit, Temp.TotalAndPhys) and ((Unit(unit):HasDeBuffsStacks(A.RazoriceDebuff.ID, true) < 5 or Unit(unit):HasDeBuffs(A.RazoriceDebuff.ID, true) < 10) and Player:RunicPowerDeficit() > (25 + num(A.RunicAttenuation:IsSpellLearned()) * 3) and not A.Frostscythe:IsSpellLearned()) then
                    return A.Obliterate:Show(icon)
                end
			
                -- obliterate,if=runic_power.deficit>(25+talent.runic_attenuation.enabled*3)
                if A.Obliterate:IsReadyByPassCastGCD(unit) and A.Obliterate:AbsentImun(unit, Temp.TotalAndPhys) and (Player:RunicPowerDeficit() > (25 + num(A.RunicAttenuation:IsSpellLearned()) * 3)) then
                    return A.Obliterate:Show(icon)
                end
			
                -- glacial_advance
                if A.GlacialAdvance:IsReady(unit) then
                    return A.GlacialAdvance:Show(icon)
                end
		    	
                -- frost_strike,target_if=(debuff.razorice.stack<5|debuff.razorice.remains<10)&!talent.frostscythe.enabled
                if A.FrostStrike:IsReady(unit) and A.FrostStrike:AbsentImun(unit, Temp.TotalAndPhys) and not VarPoolForBoS and ((Unit(unit):HasDeBuffsStacks(A.RazoriceDebuff.ID, true) < 5 or Unit(unit):HasDeBuffs(A.RazoriceDebuff.ID, true) < 10) and not A.Frostscythe:IsSpellLearned()) then
                    return A.FrostStrike:Show(icon)
                end
			
                -- frost_strike
                if A.FrostStrike:IsReady(unit) and A.FrostStrike:AbsentImun(unit, Temp.TotalAndPhys) and not VarPoolForBoS then
                    return A.FrostStrike:Show(icon)
                end
			
                -- horn_of_winter
                if A.HornofWinter:IsReady(player) and A.HornofWinter:IsSpellLearned() then
                    return A.HornofWinter:Show(icon)
                end
						
                -- arcane_torrent
                if A.ArcaneTorrent:IsRacialReady(unit) and 
				(
				    (Unit(player):HasBuffs(A.BreathofSindragosa.ID, true) > 0 and Player:RunicPower() <= 80) 
					or 
					not A.BreathofSindragosa:IsSpellLearned() and Player:RunicPowerDeficit() >= 20
				)  
				then
                    return A.ArcaneTorrent:Show(icon)
                end
            end
            
			-- STANDARD ROTATION

            -- howling_blast,if=buff.rime.up
            if A.HowlingBlast:IsReadyByPassCastGCD(unit) and Unit(player):HasBuffs(A.RimeBuff.ID, true) > 0 then
                return A.HowlingBlast:Show(icon)
            end
			
            -- remorseless_winter
            if A.RemorselessWinter:IsReady(player) and Unit(unit):GetRange() <= 8 and Player:AreaTTD(20) >= 4 then
                return A.RemorselessWinter:Show(icon)
            end

            -- obliterate,if=buff.killing_machine.up
            if A.Obliterate:IsReadyByPassCastGCD(unit) and A.Obliterate:AbsentImun(unit, Temp.TotalAndPhys) and 
			(
			    Unit(player):HasBuffs(A.KillingMachineBuff.ID, true) > 0
				and
			    Player:Rune() >= 2
			) 
			then
                return A.Obliterate:Show(icon)
            end
			
            -- frost_strike,if=cooldown.remorseless_winter.remains<=2*gcd&talent.gathering_storm.enabled
            if A.FrostStrike:IsReady(unit) and A.FrostStrike:AbsentImun(unit, Temp.TotalAndPhys) and not VarPoolForBoS and (A.RemorselessWinter:GetCooldown() <= 2 * A.GetGCD() and A.GatheringStorm:IsSpellLearned()) then
                return A.FrostStrike:Show(icon)
            end
						
            -- obliterate,if=!buff.frozen_pulse.up&talent.frozen_pulse.enabled
            if A.Obliterate:IsReadyByPassCastGCD(unit) and A.Obliterate:AbsentImun(unit, Temp.TotalAndPhys) and 
			(
			    Unit(player):HasBuffs(A.FrozenPulseBuff.ID, true) == 0 and A.FrozenPulse:IsSpellLearned()
				or
			    Player:Rune() >= 3
			) 
			then
                return A.Obliterate:Show(icon)
            end
			
            -- frost_strike,if=runic_power.deficit<(15+talent.runic_attenuation.enabled*3)
            if A.FrostStrike:IsReady(unit) and A.FrostStrike:AbsentImun(unit, Temp.TotalAndPhys) and not VarPoolForBoS and 
			(
			    Player:RunicPowerDeficit() < (15 + num(A.RunicAttenuation:IsSpellLearned()) * 3)
				or				
			    Player:Rune() < 3
			)
			then
                return A.FrostStrike:Show(icon)
            end
			
            -- frostscythe,if=buff.killing_machine.up&rune.time_to_4>=gcd
            if A.Frostscythe:IsReady(player) and GetByRange(1, 8) and A.Frostscythe:AbsentImun(unit, Temp.TotalAndPhys) and (Unit(player):HasBuffs(A.KillingMachineBuff.ID, true) > 0 and Player:RuneTimeToX(4) >= A.GetGCD()) then
                return A.Frostscythe:Show(icon)
            end
			
            -- obliterate,if=runic_power.deficit>(25+talent.runic_attenuation.enabled*3)
            if A.Obliterate:IsReadyByPassCastGCD(unit) and A.Obliterate:AbsentImun(unit, Temp.TotalAndPhys) and (Player:RunicPowerDeficit() > (25 + num(A.RunicAttenuation:IsSpellLearned()) * 3)) then
                return A.Obliterate:Show(icon)                                                                   
            end
			
            -- frost_strike
            if A.FrostStrike:IsReady(unit) and A.FrostStrike:AbsentImun(unit, Temp.TotalAndPhys) and not VarPoolForBoS then
                return A.FrostStrike:Show(icon)
            end
			
            -- horn_of_winter
            if A.HornofWinter:IsReady(player) and A.HornofWinter:IsSpellLearned() then
                return A.HornofWinter:Show(icon)
            end
			
            -- arcane_torrent
            if A.ArcaneTorrent:IsRacialReady(unit) and ((Unit(player):HasBuffs(A.BreathofSindragosa.ID, true) > 0 and Player:RunicPower() <= 80) or not A.BreathofSindragosa:IsSpellLearned() and Player:RunicPowerDeficit() >= 20)  then
                return A.ArcaneTorrent:Show(icon)
            end
			
        end
    end

    -- End on EnemyRotation()

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
    Unit(player):GetDR("incapacitate") >= 50 
    then 
        local Caster = UnitCooldown:GetUnitID("arena", 3355)
        if Caster and Unit(Caster):GetRange() <= 40 then 
            return true 
        end 
    end 
end 
local function ArenaRotation(icon, unit)
    local DeathGripLowHealth = GetToggle(2, "DeathGripLowHealth")
    if A.IsInPvP and (A.Zone == "pvp" or A.Zone == "arena") and not Player:IsStealthed() and not Player:IsMounted() then
        -- Note: "arena1" is just identification of meta 6
        if unit == "arena1" or unit == "arena2" or unit == "arena3" --and (Unit(player):GetDMG() == 0 or not Unit(player):IsFocused("DAMAGER")) 
		then 	
			-- Interrupt
   		    local Interrupt = Interrupts(unit)
  		    if Interrupt then 
  		        return Interrupt:Show(icon)
  		    end	

			-- Death Grip
			if UseDeathGrip and A.DeathGrip:IsReady(unit) and Unit(unit):GetRange() > 8 and Unit(unit):GetRange() <= 30 and Unit(unit):IsMovingOut() and Unit(unit):HealthPercent() < DeathGripLowHealth
			then
			    return A.DeathGrip:Show(icon) 
			end
        end
    end 
end 
local function PartyRotation(unit)
    if (unit == "party1" and not GetToggle(2, "PartyUnits")[1]) or (unit == "party2" and not GetToggle(2, "PartyUnits")[2]) then 
        return false 
    end
  	
	-- RaiseAlly
    if A.RaiseAlly:IsReady(unit) and Unit(player):CombatTime() > 0 and Unit(unit):IsDead() and not Unit(unit):InLOS() and
	(
	    -- Tank
	    GetToggle(2, "RaiseAllyUnits")[1] and Unit(unit):IsTank() and Unit(unit):IsPlayer()
		or
		-- Healer
		GetToggle(2, "RaiseAllyUnits")[2] and Unit(unit):IsHealer() and Unit(unit):IsPlayer()
		or
		-- Damager
		GetToggle(2, "RaiseAllyUnits")[3] and Unit(unit):IsDamager() and Unit(unit):IsPlayer() 
		or
		-- Mouseover
		GetToggle(2, "RaiseAllyUnits")[4] and Unit("mouseover"):IsExists() and Unit(unit):IsPlayer()
	)	
	then
        return A.RaiseAlly
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

-------------------------------------------
-- [[ UI: QUEUE BASE ]] 
-------------------------------------------
local GameLocale = GetLocale()    
local Localization = {
    [GameLocale] = {},
    enUS          = {
        QERROR1 = "Already queued: ",
        QERROR2 = "Not available: ",
    },
    ruRU         = {
        QERROR1 = "Уже находится в очереди: ",
        QERROR2 = "Недоступно: ",
    },
}
local L = setmetatable(Localization[GameLocale], { __index = Localization.enUS })

local QB = {
    player                                 = {UnitID = "player",         Silence = false, Value = true, Auto = true, Priority = 1},
    target                                 = {UnitID = "target",         Silence = false, Value = true, Auto = true, Priority = 1},
    Cancel                                 = {Silence = false},
    IsQueuedObjects                        = function(...)
        local found 
        for i = 1, select("#", ...) do
            local object = select(i, ...)
            if object:IsQueued() then 
                found = true 
                A.Print(L.QERROR1 .. object:Info())
            end 
        end 
        
        return found 
    end,
    IsUnavailableObjects                = function(...)
        local found 
        for i = 1, select("#", ...) do
            local object = select(i, ...)
            if object:GetCooldown() > 0 then 
                found = true 
                A.Print(L.QERROR2 .. object:Info())
            end 
        end 
        
        return found 
    end,
}

function Action.QueueBase(name)
     
    local BoSEnemies      = A.GetToggle(2, "BoSEnemies")                             -- not static
    local BoSPoolTime     = A.GetToggle(2, "BoSPoolTime")                                                     -- not static
    local BoSMinPower     = A.GetToggle(2, "BoSMinPower")                                                 -- not static       
    local myRunicPower    = Player:RunicPower()           
    
    if name == "BreathofSindragosa" then 	
        
		-- Check valid 
        if QB.IsQueuedObjects(A.BreathofSindragosa, A.EmpowerRuneWeapon) or QB.IsUnavailableObjects(A.BreathofSindragosa, A.EmpowerRuneWeapon) then 
            return 
        end         
        
        -- Cancel other queues 
        A.CancelAllQueueForMeta(3)                                                       
        
		-- Obliterate
		if myRunicPower < BoSMinPower then
            A.Obliterate:SetQueue(QB.player)        -- #0
			VarPoolForBoSQueue = true
			-- Notification					
	        Action.SendNotification("Pooling ressources for " .. A.GetSpellInfo(A.BreathofSindragosa.ID), A.BreathofSindragosa.ID)	
		end

	   -- EmpowerRuneWeapon
        if not A.EmpowerRuneWeapon:IsQueued() and A.EmpowerRuneWeapon:IsReadyByPassCastGCDP("player", nil, nil, true) and myRunicPower >= BoSMinPower then  
            A.EmpowerRuneWeapon:SetQueue(QB.player)        -- #1
        end 	
		
		-- PillarofFrost
        if not A.PillarofFrost:IsQueued() and A.PillarofFrost:IsReadyByPassCastGCDP("player", nil, nil, true) and myRunicPower >= BoSMinPower then  
            A.PillarofFrost:SetQueue(QB.player)            -- #2	
		end
		
        -- Do nothing if not enough Runic Power generate
        local canBreathofSindragosa = BoSMinPower > 0 and A.BreathofSindragosa:IsReadyP("player") 
        if (A.EmpowerRuneWeapon:IsQueued() or A.EmpowerRuneWeapon:GetCooldown() > 0) and A.BreathofSindragosa:IsReadyByPassCastGCDP("player", nil, nil, true) and myRunicPower >= BoSMinPower then
		    A.BreathofSindragosa:SetQueue(QB.player)    -- #3
        end
		
		-- Notification if all good		
		if A.EmpowerRuneWeapon:IsQueued() and A.BreathofSindragosa:IsQueued() then
			-- Notification					
	        Action.SendNotification("BoS Bursting ", A.BreathofSindragosa.ID)	
		end
		
		VarPoolForBoSQueue = false
    end 		
end 