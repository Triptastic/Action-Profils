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
    -- Abilities
    RaiseDead                                                         = Create({ Type = "Spell", ID = 46585 }),
    SacrificialPact                                             = Create({ Type = "Spell", ID = 327574 }),
    DeathAndDecay                                                 = Create({ Type = "Spell", ID = 43265 }),
    DeathStrike                                                     = Create({ Type = "Spell", ID = 49998 }),
    RemorselessWinter                                         = Create({ Type = "Spell", ID = 196770 }),
    FrostStrike                                                     = Create({ Type = "Spell", ID = 49143 }),
    Obliterate                                                        = Create({ Type = "Spell", ID = 49020 }),
    HowlingBlast                                                    = Create({ Type = "Spell", ID = 49184 }),
    ChainsofIce                                                     = Create({ Type = "Spell", ID = 45524 }),
    FrostwyrmsFury                                                = Create({ Type = "Spell", ID = 279302 }),
    EmpowerRuneWeapon                                         = Create({ Type = "Spell", ID = 47568 }),
    PillarofFrost                                                 = Create({ Type = "Spell", ID = 51271 }),
    -- Talents
    GatheringStorm                                                = Create({ Type = "Spell", ID = 194912 }),
    GlacialAdvance                                                = Create({ Type = "Spell", ID = 194913 }),
    IcyTalons                                                         = Create({ Type = "Spell", ID = 194878 }),
    Frostscythe                                                     = Create({ Type = "Spell", ID = 207230 }),
    RunicAttenuation                                            = Create({ Type = "Spell", ID = 207104 }),
    FrozenPulse                                                     = Create({ Type = "Spell", ID = 194909 }),
    HornofWinter                                                    = Create({ Type = "Spell", ID = 57330 }),
    ColdHeart                                                         = Create({ Type = "Spell", ID = 281208 }),
    HypothermicPresence                                     = Create({ Type = "Spell", ID = 321995 }),
    Icecap                                                                = Create({ Type = "Spell", ID = 207126 }),
    Obliteration                                                    = Create({ Type = "Spell", ID = 281238 }),
    BreathofSindragosa                                        = Create({ Type = "Spell", ID = 152279 }),
    -- Covenant Abilities
    ShackleTheUnworthy                                        = Create({ Type = "Spell", ID = 312202 }),
    SwarmingMist                                                    = Create({ Type = "Spell", ID = 311648 }),
    AbominationLimb                                             = Create({ Type = "Spell", ID = 315443 }),
    DeathsDue                                                         = Create({ Type = "Spell", ID = 324128 }),
    -- Conduit Effects
    EradicatingBlow                                             = Create({ Type = "Spell", ID = 337934 }),
    BitingCold                                                        = Create({ Type = "Spell", ID = 337988 }),
    UnleashedFrenzy                                             = Create({ Type = "Spell", ID = 338492 }),
    -- Buffs
    RimeBuff                                                            = Create({ Type = "Spell", ID = 59052 }),
    KillingMachineBuff                                        = Create({ Type = "Spell", ID = 51124 }),
    PillarofFrostBuff                                         = Create({ Type = "Spell", ID = 51271 }),
    ColdHeartBuff                                                 = Create({ Type = "Spell", ID = 281209 }),
    FrozenPulseBuff                                             = Create({ Type = "Spell", ID = 194909 }),
    EmpowerRuneWeaponBuff                                 = Create({ Type = "Spell", ID = 47568 }),
    DeathStrikeBuff                                             = Create({ Type = "Spell", ID = 101568 }),
    IcyTalonsBuff                                                 = Create({ Type = "Spell", ID = 194879 }),
    UnholyStrengthBuff                                        = Create({ Type = "Spell", ID = 53365 }),
    EradicatingBlowBuff                                     = Create({ Type = "Spell", ID = 337936 }),
    UnleashedFrenzyBuff                                     = Create({ Type = "Spell", ID = 338501 }),
    -- Debuffs
    RazoriceDebuff                                                = Create({ Type = "Spell", ID = 51714 }),
    FrostFeverDebuff                                            = Create({ Type = "Spell", ID = 55095 }),
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
--[[				-- breath_of_sindragosa special logic builder
                if A.BreathofSindragosa:IsSpellLearned() and A.BreathofSindragosa:AbsentImun(unit, Temp.TotalAndMag) and A.BreathofSindragosa:IsReadyByPassCastGCD(unit, nil, nil, true) and BosUsage == "AUTO" then 
                    if GenerateBreathofSindragosa(meta, A.BreathofSindragosa, false, unit) then 
						-- Notification					
	                    Action.SendNotification("Building: " .. A.GetSpellInfo(A.BreathofSindragosa.ID) .. " burst.", A.BreathofSindragosa.ID)
                        return false 
                    end 
				end 	
				]]--
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

            -- frost_strike,if=buff.icy_talons.remains<=gcd&buff.icy_talons.up&(!talent.breath_of_sindragosa.enabled|cooldown.breath_of_sindragosa.remains>15)
            if not DeathStrikeHeal and S.FrostStrike:IsReady() and (Player:BuffRemains(S.IcyTalonsBuff) <= Player:GCD() and Player:BuffUp(S.IcyTalonsBuff) and (not S.BreathofSindragosa:IsAvailable() or S.BreathofSindragosa:CooldownRemains() > 15)) then
              if HR.Cast(S.FrostStrike) then return "frost_strike 5"; end
            end
			
			-- BURST
            -- call_action_list,name=cooldowns
    			
		    -- Burst Phase
		    if unit ~= "mouseover" and BurstIsON(unit) and inCombat and not profileStop then
                -- empower_rune_weapon,if=talent.obliteration.enabled&(cooldown.pillar_of_frost.ready&rune.time_to_5>gcd&runic_power.deficit>=10|buff.pillar_of_frost.up&rune.time_to_5>gcd)|target.1.time_to_die<20
                if S.EmpowerRuneWeapon:IsCastable() and (S.Obliteration:IsAvailable() and (S.PillarofFrost:CooldownUp() and Player:RuneTimeToX(5) > Player:GCD() and Player:RunicPowerDeficit() >= 10 or Player:BuffUp(S.PillarofFrostBuff) and Player:RuneTimeToX(5) > Player:GCD()) or Target:TimeToDie() < 20) then
                    if HR.Cast(S.EmpowerRuneWeapon, Settings.Frost.GCDasOffGCD.EmpowerRuneWeapon) then return "empower_rune_weapon cd 1"; end
                end
                -- empower_rune_weapon,if=(buff.breath_of_sindragosa.up|target.1.time_to_die<20)&talent.breath_of_sindragosa.enabled&runic_power.deficit>30&rune.time_to_5>gcd
                if S.EmpowerRuneWeapon:IsCastable() and ((Player:BuffUp(S.BreathofSindragosa) or Target:TimeToDie() < 20) and S.BreathofSindragosa:IsAvailable() and Player:RunicPowerDeficit() > 30 and Player:RuneTimeToX(5) > Player:GCD()) then
                    if HR.Cast(S.EmpowerRuneWeapon, Settings.Frost.GCDasOffGCD.EmpowerRuneWeapon) then return "empower_rune_weapon cd 2"; end
                end
                -- empower_rune_weapon,if=talent.icecap.enabled&rune<3
                if S.EmpowerRuneWeapon:IsCastable() and (S.Icecap:IsAvailable() and Player:Rune() < 3) then
                    if HR.Cast(S.EmpowerRuneWeapon, Settings.Frost.GCDasOffGCD.EmpowerRuneWeapon) then return "empower_rune_weapon cd 3"; end
                end
                -- pillar_of_frost,if=talent.breath_of_sindragosa.enabled&cooldown.breath_of_sindragosa.remains|talent.icecap.enabled&!buff.pillar_of_frost.up
                if S.PillarofFrost:IsCastable() and (S.BreathofSindragosa:IsAvailable() and bool(S.BreathofSindragosa:CooldownRemains()) or S.Icecap:IsAvailable() and not Player:BuffUp(S.PillarofFrostBuff)) then
                    if HR.Cast(S.PillarofFrost, Settings.Frost.GCDasOffGCD.PillarofFrost) then return "pillar_of_frost cd 4"; end
                end
                -- pillar_of_frost,if=talent.obliteration.enabled&(talent.gathering_storm.enabled&buff.remorseless_winter.up&cooldown.raise_dead.ready|cooldown.raise_dead.remains|!talent.gathering_storm.enabled)
                if S.PillarofFrost:IsCastable() and (S.Obliteration:IsAvailable() and (S.GatheringStorm:IsAvailable() and Player:BuffUp(S.RemorselessWinter) and S.RaiseDead:CooldownUp() or bool(S.RaiseDead:CooldownRemains()) or not S.GatheringStorm:IsAvailable())) then
                    if HR.Cast(S.PillarofFrost, Settings.Frost.GCDasOffGCD.PillarofFrost) then return "pillar_of_frost cd 5"; end
                end
                -- breath_of_sindragosa,use_off_gcd=1,if=cooldown.pillar_of_frost.ready&runic_power.deficit<60
                if S.BreathofSindragosa:IsCastable() and (S.PillarofFrost:CooldownUp() and Player:RunicPowerDeficit() < 60) then
                    if HR.Cast(S.BreathofSindragosa, nil, Settings.Frost.BoSDisplayStyle, not TargetIsInRange[8]) then return "breath_of_sindragosa cd 6"; end
                end
                -- frostwyrms_fury,if=buff.pillar_of_frost.remains<gcd&buff.pillar_of_frost.up&!talent.obliteration.enabled
                if S.FrostwyrmsFury:IsCastable() and (Player:BuffRemains(S.PillarofFrostBuff) < Player:GCD() and Player:BuffUp(S.PillarofFrostBuff) and not S.Obliteration:IsAvailable()) then
                    if HR.Cast(S.FrostwyrmsFury, Settings.Frost.GCDasOffGCD.FrostwyrmsFury, nil, not TargetIsInRange[40]) then return "frostwyrms_fury cd 7"; end
                end
                -- frostwyrms_fury,if=active_enemies>=2&cooldown.pillar_of_frost.remains+15>target.time_to_die|target.1.time_to_die<gcd
                if S.FrostwyrmsFury:IsCastable() and (EnemiesMeleeCount >= 2 and S.PillarofFrost:CooldownRemains() + 15 > Target:TimeToDie() or Target:TimeToDie() < Player:GCD()) then
                    if HR.Cast(S.FrostwyrmsFury, Settings.Frost.GCDasOffGCD.FrostwyrmsFury, nil, not TargetIsInRange[40]) then return "frostwyrms_fury cd 8"; end
                end
                -- frostwyrms_fury,if=talent.obliteration.enabled&!buff.pillar_of_frost.up&((death_knight.runeforge.fallen_crusader&buff.unholy_strength.up)|(death_knight.runeforge.razorice&debuff.razorice.stack=5)|(!death_knight.runeforge.razorice&!death_knight.runeforge.fallen_crusader))
                if S.FrostwyrmsFury:IsCastable() and (S.Obliteration:IsAvailable() and not Player:BuffUp(S.PillarofFrostBuff) and (Player:BuffUp(S.UnholyStrengthBuff) or Target:DebuffStack(S.RazoriceDebuff) == 5 )) then
                    if HR.Cast(S.FrostwyrmsFury, Settings.Frost.GCDasOffGCD.FrostwyrmsFury, nil, not TargetIsInRange[40]) then return "frostwyrms_fury cd 9"; end
                end
                -- hypothermic_presence,if=talent.breath_of_sindragosa.enabled&runic_power.deficit>40&rune>=3&cooldown.pillar_of_frost.up|!talent.breath_of_sindragosa.enabled&runic_power.deficit>=25
                if S.HypothermicPresence:IsCastable() and (S.BreathofSindragosa:IsAvailable() and Player:RunicPowerDeficit() > 40 and Player:Rune() >= 3 and S.PillarofFrost:CooldownUp() or not S.BreathofSindragosa:IsAvailable() and Player:RunicPowerDeficit() >= 25) then
                    if HR.Cast(S.HypothermicPresence, Settings.Frost.GCDasOffGCD.HypothermicPresence, nil, nil) then return "hypothermic_presence cd 10"; end
               end 
                -- raise_dead
                if S.RaiseDead:IsCastable() and Player:BuffUp(S.PillarofFrostBuff) then
                    if HR.CastSuggested(S.RaiseDead) then return "raise_dead cd 11"; end
                end
                -- sacrificial_pact,if=active_enemies>=2&(pet.ghoul.remains<gcd|target.time_to_die<gcd)
                if S.SacrificialPact:IsCastable() and (EnemiesCount10yd >= 2 and (S.SacrificialPact:TimeSinceLastCast() < (60 - Player:GCD()) or Target:TimeToDie() < Player:GCD())) then
                    if HR.Cast(S.SacrificialPact, Settings.Commons.GCDasOffGCD.SacrificialPact, nil, not TargetIsInRange[8]) then return "sacrificial pact cd 12"; end
                end
            end		
	
			-- COLD HEART ROTATION
            -- call_action_list,name=cold_heart,if=talent.cold_heart.enabled&(buff.cold_heart.stack>=10&(debuff.razorice.stack=5&death_knight.runeforge.razorice|!death_knight.runeforge.razorice)|target.1.time_to_die<=gcd)
            if (S.ColdHeart:IsAvailable() and ((Player:BuffStack(S.ColdHeartBuff) >= 10 and Target:DebuffStack(S.RazoriceDebuff) == 5) or Target:TimeToDie() <= Player:GCD())) then
                -- chains_of_ice,if=target.1.time_to_die<gcd|buff.pillar_of_frost.remains<3&buff.cold_heart.stack=20&!talent.obliteration.enabled
                if S.ChainsofIce:IsCastable() and (Target:TimeToDie() < Player:GCD() * 1.5 or Player:BuffRemains(S.PillarofFrostBuff) < 3 and Player:BuffStack(S.ColdHeartBuff) == 20 and not S.Obliteration:IsAvailable()) then 
                    if HR.Cast(S.ChainsofIce, nil, nil, not TargetIsInRange[30]) then return "chains_of_ice coldheart 1"; end
                end
                -- chains_of_ice,if=talent.obliteration.enabled&!buff.pillar_of_frost.up&(buff.cold_heart.stack>=16&buff.unholy_strength.up|buff.cold_heart.stack>=19)
                if S.ChainsofIce:IsCastable() and ((S.Obliteration:IsAvailable() and not Player:BuffUp(S.PillarofFrostBuff) and Player:BuffStack(S.ColdHeartBuff) >= 16 and Player:BuffUp(S.UnholyStrengthBuff) or Player:BuffStack(S.ColdHeartBuff) >= 19)) then
                    if HR.Cast(S.ChainsofIce, nil, nil, not TargetIsInRange[30]) then return "chains_of_ice coldheart 2"; end
                end
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


           -- run_action_list,name=bos_ticking,if=buff.breath_of_sindragosa.up
    if (Player:BuffUp(S.BreathofSindragosa)) then
      return BosTicking();
    end
    -- run_action_list,name=bos_pooling,if=talent.breath_of_sindragosa.enabled&((cooldown.breath_of_sindragosa.remains<10)|(cooldown.breath_of_sindragosa.remains<20&target.1.time_to_die<35))
    if (not Settings.Frost.DisableBoSPooling and S.BreathofSindragosa:IsAvailable() and ((S.BreathofSindragosa:CooldownRemains() < 10) or (S.BreathofSindragosa:CooldownRemains() < 20 and Target:TimeToDie() < 35))) then
      return BosPooling();
    end
    -- run_action_list,name=obliteration,if=buff.pillar_of_frost.up&talent.obliteration.enabled
    if (Player:BuffUp(S.PillarofFrostBuff) and S.Obliteration:IsAvailable()) then
      return Obliteration();
    end
    -- run_action_list,name=aoe,if=active_enemies>=2
    if (HR.AoEON() and EnemiesCount10yd >= 2) then
      return Aoe();
    end
    -- call_action_list,name=standard
    if (true) then
      local ShouldReturn = Standard(); if ShouldReturn then return ShouldReturn; end
    end
    -- racials
    if (true) then
      local ShouldReturn = Racials(); if ShouldReturn then return ShouldReturn; end
    end
    -- nothing to cast, wait for resouces
    if HR.CastAnnotated(S.PoolRange, false, "WAIT") then return "Wait/Pool Resources"; end
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