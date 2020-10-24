-------------------------------
-- Taste TMW Action Rotation --
-------------------------------
local TMW                                       = TMW
local CNDT                                      = TMW.CNDT
local Env                                       = CNDT.Env
local Action                                    = Action
local Listener                                  = Action.Listener
local Create                                    = Create
local GetToggle                                 = Action.GetToggle
local SetToggle                                 = Action.SetToggle
local GetGCD                                    = Action.GetGCD
local GetCurrentGCD                             = Action.GetCurrentGCD
local GetPing                                   = Action.GetPing
local ShouldStop                                = Action.ShouldStop
local BurstIsON                                 = Action.BurstIsON
local AuraIsValid                               = Action.AuraIsValid
local InterruptIsValid                          = Action.InterruptIsValid
local FrameHasSpell                             = Action.FrameHasSpell
local Azerite                                   = LibStub("AzeriteTraits")
local Utils                                     = Action.Utils
local TeamCache                                 = Action.TeamCache
local EnemyTeam                                 = Action.EnemyTeam
local FriendlyTeam                              = Action.FriendlyTeam
local LoC                                       = Action.LossOfControl
local Player                                    = Action.Player
local MultiUnits                                = Action.MultiUnits
local UnitCooldown                              = Action.UnitCooldown
local Unit                                      = Action.Unit
local IsUnitEnemy                               = Action.IsUnitEnemy
local IsUnitFriendly                            = Action.IsUnitFriendly
local HealingEngine                             = Action.HealingEngine
local ActiveUnitPlates                          = MultiUnits:GetActiveUnitPlates()
local TeamCacheFriendly                         = TeamCache.Friendly
local TeamCacheFriendlyIndexToPLAYERs           = TeamCacheFriendly.IndexToPLAYERs
local IsIndoors, UnitIsUnit                     = IsIndoors, UnitIsUnit
local TR                                        = Action.TasteRotation
local Pet                                       = LibStub("PetLibrary")
local next, pairs, type, print                  = next, pairs, type, print
local math_floor                                = math.floor
local math_ceil                                 = math.ceil
local tinsert                                   = table.insert
local select, unpack, table                     = select, unpack, table
local CombatLogGetCurrentEventInfo              = _G.CombatLogGetCurrentEventInfo
local UnitGUID, UnitIsUnit, UnitDamage, UnitAttackSpeed, UnitAttackPower = UnitGUID, UnitIsUnit, UnitDamage, UnitAttackSpeed, UnitAttackPower
local _G, setmetatable, select, math            = _G, setmetatable, select, math
local huge                                      = math.huge
local UIParent                                  = _G.UIParent
local CreateFrame                               = _G.CreateFrame
local wipe                                      = _G.wipe
local IsUsableSpell                             = IsUsableSpell
local UnitPowerType                             = UnitPowerType

--- ============================ CONTENT =========================== ---
--- ======================= SPELLS DECLARATION ===================== ---

Action[ACTION_CONST_DEATHKNIGHT_FROST] = {
    -- Racial
    ArcaneTorrent                          = Create({ Type = "Spell", ID = 50613     }),
    BloodFury                              = Create({ Type = "Spell", ID = 20572      }),
    Fireblood                              = Create({ Type = "Spell", ID = 265221     }),
    AncestralCall                          = Create({ Type = "Spell", ID = 274738     }),
    Berserking                             = Create({ Type = "Spell", ID = 26297    }),
    ArcanePulse                            = Create({ Type = "Spell", ID = 260364    }),
    QuakingPalm                            = Create({ Type = "Spell", ID = 107079     }),
    Haymaker                               = Create({ Type = "Spell", ID = 287712     }), 
    WarStomp                               = Create({ Type = "Spell", ID = 20549     }),
    BullRush                               = Create({ Type = "Spell", ID = 255654     }),  
    GiftofNaaru                            = Create({ Type = "Spell", ID = 59544    }),
    Shadowmeld                             = Create({ Type = "Spell", ID = 58984    }), -- usable in Action Core 
    Stoneform                              = Create({ Type = "Spell", ID = 20594    }), 
    WilloftheForsaken                      = Create({ Type = "Spell", ID = 7744        }), -- not usable in APL but user can Queue it   
    EscapeArtist                           = Create({ Type = "Spell", ID = 20589    }), -- not usable in APL but user can Queue it
    EveryManforHimself                     = Create({ Type = "Spell", ID = 59752    }), -- not usable in APL but user can Queue it
    -- Generics
    RemorselessWinter                      = Create({ Type = "Spell", ID = 196770 }),
    GatheringStorm                         = Create({ Type = "Spell", ID = 194912 }),
    FrozenTempest                          = Create({ Type = "Spell", ID =  }),
    RimeBuff                               = Create({ Type = "Spell", ID =  }),
    GlacialAdvance                         = Create({ Type = "Spell", ID = 194913 }),
    Frostscythe                            = Create({ Type = "Spell", ID = 207230 }),
    FrostStrike                            = Create({ Type = "Spell", ID = 49143 }),
    RazoriceDebuff                         = Create({ Type = "Spell", ID = 51714 }),
    HowlingBlast                           = Create({ Type = "Spell", ID = 49184 }),
    KillingMachineBuff                     = Create({ Type = "Spell", ID = 51124 }),
    RunicAttenuation                       = Create({ Type = "Spell", ID = 207104 }),
    Obliterate                             = Create({ Type = "Spell", ID = 49020 }),
    HornofWinter                           = Create({ Type = "Spell", ID = 57330 }),
    ArcaneTorrent                          = Create({ Type = "Spell", ID = 50613 }),
    PillarofFrost                          = Create({ Type = "Spell", ID = 51271 }),
    ChainsofIce                            = Create({ Type = "Spell", ID = 45524 }),
    ColdHeartBuff                          = Create({ Type = "Spell", ID =  }),
    SeethingRageBuff                       = Create({ Type = "Spell", ID =  }),
    PillarofFrostBuff                      = Create({ Type = "Spell", ID =  }),
    FrostwyrmsFury                         = Create({ Type = "Spell", ID = 279302 }),
    IcyCitadel                             = Create({ Type = "Spell", ID =  }),
    BreathofSindragosaBuff                 = Create({ Type = "Spell", ID = 155166 }),
    Icecap                                 = Create({ Type = "Spell", ID = 207126 }),
    UnholyStrengthBuff                     = Create({ Type = "Spell", ID = 53365 }),
    IcyCitadelBuff                         = Create({ Type = "Spell", ID =  }),
    EmpoweredRuneWeapon                    = Create({ Type = "Spell", ID =  }),
    BreathofSindragosa                     = Create({ Type = "Spell", ID = 152279 }),
    EmpowerRuneWeapon                      = Create({ Type = "Spell", ID = 47568 }),
    EmpowerRuneWeaponBuff                  = Create({ Type = "Spell", ID =  }),
    BloodFury                              = Create({ Type = "Spell", ID = 20572 }),
    Berserking                             = Create({ Type = "Spell", ID = 26297 }),
    ArcanePulse                            = Create({ Type = "Spell", ID =  }),
    LightsJudgment                         = Create({ Type = "Spell", ID = 255647 }),
    AncestralCall                          = Create({ Type = "Spell", ID = 274738 }),
    Fireblood                              = Create({ Type = "Spell", ID = 265221 }),
    BagofTricks                            = Create({ Type = "Spell", ID =  }),
    ColdHeart                              = Create({ Type = "Spell", ID =  }),
    Obliteration                           = Create({ Type = "Spell", ID = 281238 }),
    ChillStreak                            = Create({ Type = "Spell", ID =  }),
    ReapingFlames                          = Create({ Type = "Spell", ID =  }),
    FrozenPulseBuff                        = Create({ Type = "Spell", ID =  }),
    FrozenPulse                            = Create({ Type = "Spell", ID = 194909 }),
    FrostFeverDebuff                       = Create({ Type = "Spell", ID =  }),
    IcyTalonsBuff                          = Create({ Type = "Spell", ID = 194879 })
    -- Trinkets
    TrinketTest                            = Create({ Type = "Trinket", ID = 122530, QueueForbidden = true }), 
    TrinketTest2                           = Create({ Type = "Trinket", ID = 159611, QueueForbidden = true }), 
    AzsharasFontofPower                    = Create({ Type = "Trinket", ID = 169314, QueueForbidden = true }), 
    PocketsizedComputationDevice           = Create({ Type = "Trinket", ID = 167555, QueueForbidden = true }), 
    RotcrustedVoodooDoll                   = Create({ Type = "Trinket", ID = 159624, QueueForbidden = true }), 
    ShiverVenomRelic                       = Create({ Type = "Trinket", ID = 168905, QueueForbidden = true }), 
    AquipotentNautilus                     = Create({ Type = "Trinket", ID = 169305, QueueForbidden = true }), 
    TidestormCodex                         = Create({ Type = "Trinket", ID = 165576, QueueForbidden = true }), 
    VialofStorms                           = Create({ Type = "Trinket", ID = 158224, QueueForbidden = true }), 
    -- Potions
    PotionofUnbridledFury                  = Create({ Type = "Potion", ID = 169299, QueueForbidden = true }), 
    BattlePotionOfAgility                  = Create({ Type = "Potion", ID = 163223, QueueForbidden = true }), 
    SuperiorBattlePotionOfAgility          = Create({ Type = "Potion", ID = 168489, QueueForbidden = true }), 
    PotionTest                             = Create({ Type = "Potion", ID = 142117, QueueForbidden = true }), 
    -- Trinkets
    GenericTrinket1                        = Create({ Type = "Trinket", ID = 114616, QueueForbidden = true }),
    GenericTrinket2                        = Create({ Type = "Trinket", ID = 114081, QueueForbidden = true }),
    TrinketTest                            = Create({ Type = "Trinket", ID = 122530, QueueForbidden = true }),
    TrinketTest2                           = Create({ Type = "Trinket", ID = 159611, QueueForbidden = true }), 
    AzsharasFontofPower                    = Create({ Type = "Trinket", ID = 169314, QueueForbidden = true }),
    PocketsizedComputationDevice           = Create({ Type = "Trinket", ID = 167555, QueueForbidden = true }),
    RotcrustedVoodooDoll                   = Create({ Type = "Trinket", ID = 159624, QueueForbidden = true }),
    ShiverVenomRelic                       = Create({ Type = "Trinket", ID = 168905, QueueForbidden = true }),
    AquipotentNautilus                     = Create({ Type = "Trinket", ID = 169305, QueueForbidden = true }),
    TidestormCodex                         = Create({ Type = "Trinket", ID = 165576, QueueForbidden = true }),
    VialofStorms                           = Create({ Type = "Trinket", ID = 158224, QueueForbidden = true }),
    GalecallersBoon                        = Create({ Type = "Trinket", ID = 159614, QueueForbidden = true }),
    InvocationOfYulon                      = Create({ Type = "Trinket", ID = 165568, QueueForbidden = true }),
    LustrousGoldenPlumage                  = Create({ Type = "Trinket", ID = 159617, QueueForbidden = true }),
    ComputationDevice                      = Create({ Type = "Trinket", ID = 167555, QueueForbidden = true }),
    VigorTrinket                           = Create({ Type = "Trinket", ID = 165572, QueueForbidden = true }),
    FontOfPower                            = Create({ Type = "Trinket", ID = 169314, QueueForbidden = true }),
    RazorCoral                             = Create({ Type = "Trinket", ID = 169311, QueueForbidden = true }),
    AshvanesRazorCoral                     = Create({ Type = "Trinket", ID = 169311, QueueForbidden = true }),
    -- Misc
    Channeling                             = Create({ Type = "Spell", ID = 209274, Hidden = true     }),	-- Show an icon during channeling
    TargetEnemy                            = Create({ Type = "Spell", ID = 44603, Hidden = true     }),	-- Change Target (Tab button)
    StopCast                               = Create({ Type = "Spell", ID = 61721, Hidden = true     }),		-- spell_magic_polymorphrabbit
    CyclotronicBlast                       = Create({ Type = "Spell", ID = 293491, Hidden = true}),
    ConcentratedFlameBurn                  = Create({ Type = "Spell", ID = 295368, Hidden = true}),
    RazorCoralDebuff                       = Create({ Type = "Spell", ID = 303568, Hidden = true     }),
    ConductiveInkDebuff                    = Create({ Type = "Spell", ID = 302565, Hidden = true     }),
};

-- To create covenant use next code:
A:CreateCovenantsFor(ACTION_CONST_DEATHKNIGHT_FROST)  -- where PLAYERSPEC is Constance (example: ACTION_CONST_MONK_BM)
local A = setmetatable(Action[ACTION_CONST_DEATHKNIGHT_FROST], { __index = Action })


------------------------------------------
---------------- VARIABLES ---------------
------------------------------------------
local VarOtherOnUseEquipped = 0;

A.Listener:Add("ROTATION_VARS", "PLAYER_REGEN_ENABLED", function()
  VarOtherOnUseEquipped = 0
end)



local function num(val)
    if val then return 1 else return 0 end
end

local function bool(val)
    return val ~= 0
end

------------------------------------------
--------- FROST PRE APL SETUP ------------
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

local IsIndoors, UnitIsUnit = IsIndoors, UnitIsUnit

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

local function EvaluateCycleFrostStrike42(unit)
    return (Unit(unit):HasDeBuffsStacks(A.RazoriceDebuff.ID, true) < 5 or Unit(unit):HasDeBuffs(A.RazoriceDebuff.ID, true) < 10) and A.RemorselessWinter:GetCooldown() <= 2 * GetGCD() and A.GatheringStorm:IsSpellLearned() and not A.Frostscythe:IsSpellLearned()
end

local function EvaluateCycleFrostStrike77(unit)
    return (Unit(unit):HasDeBuffsStacks(A.RazoriceDebuff.ID, true) < 5 or Unit(unit):HasDeBuffs(A.RazoriceDebuff.ID, true) < 10) and Player:RunicPowerDeficit() < (15 + num(A.RunicAttenuation:IsSpellLearned()) * 3) and not A.Frostscythe:IsSpellLearned()
end

local function EvaluateCycleObliterate102(unit)
    return (Unit(unit):HasDeBuffsStacks(A.RazoriceDebuff.ID, true) < 5 or Unit(unit):HasDeBuffs(A.RazoriceDebuff.ID, true) < 10) and Player:RunicPowerDeficit() > (25 + num(A.RunicAttenuation:IsSpellLearned()) * 3) and not A.Frostscythe:IsSpellLearned()
end

local function EvaluateCycleFrostStrike123(unit)
    return (Unit(unit):HasDeBuffsStacks(A.RazoriceDebuff.ID, true) < 5 or Unit(unit):HasDeBuffs(A.RazoriceDebuff.ID, true) < 10) and not A.Frostscythe:IsSpellLearned()
end

local function EvaluateCycleObliterate146(unit)
    return (Unit(unit):HasDeBuffsStacks(A.RazoriceDebuff.ID, true) < 5 or Unit(unit):HasDeBuffs(A.RazoriceDebuff.ID, true) < 10) and true and Player:RunicPowerDeficit() >= 25 and not A.Frostscythe:IsSpellLearned()
end

local function EvaluateCycleFrostStrike165(unit)
    return (Unit(unit):HasDeBuffsStacks(A.RazoriceDebuff.ID, true) < 5 or Unit(unit):HasDeBuffs(A.RazoriceDebuff.ID, true) < 10) and Player:RunicPowerDeficit() < 20 and not A.Frostscythe:IsSpellLearned() and A.PillarofFrost:GetCooldown() > 5
end

local function EvaluateCycleObliterate194(unit)
    return (Unit(unit):HasDeBuffsStacks(A.RazoriceDebuff.ID, true) < 5 or Unit(unit):HasDeBuffs(A.RazoriceDebuff.ID, true) < 10) and Player:RunicPowerDeficit() >= (35 + num(A.RunicAttenuation:IsSpellLearned()) * 3) and not A.Frostscythe:IsSpellLearned()
end

local function EvaluateCycleFrostStrike217(unit)
    return (Unit(unit):HasDeBuffsStacks(A.RazoriceDebuff.ID, true) < 5 or Unit(unit):HasDeBuffs(A.RazoriceDebuff.ID, true) < 10) and A.PillarofFrost:GetCooldown() > Player:RuneTimeToX(4) and Player:RunicPowerDeficit() < 40 and not A.Frostscythe:IsSpellLearned()
end

local function EvaluateCycleObliterate236(unit)
    return (Unit(unit):HasDeBuffsStacks(A.RazoriceDebuff.ID, true) < 5 or Unit(unit):HasDeBuffs(A.RazoriceDebuff.ID, true) < 10) and Player:RunicPower() <= 32 and not A.Frostscythe:IsSpellLearned()
end

local function EvaluateCycleObliterate259(unit)
    return (Unit(unit):HasDeBuffsStacks(A.RazoriceDebuff.ID, true) < 5 or Unit(unit):HasDeBuffs(A.RazoriceDebuff.ID, true) < 10) and Player:RuneTimeToX(5) < GetGCD() or Player:RunicPower() <= 45 and not A.Frostscythe:IsSpellLearned()
end

local function EvaluateCycleObliterate284(unit)
    return (Unit(unit):HasDeBuffsStacks(A.RazoriceDebuff.ID, true) < 5 or Unit(unit):HasDeBuffs(A.RazoriceDebuff.ID, true) < 10) and Player:RunicPowerDeficit() > 25 or Player:Rune() > 3 and not A.Frostscythe:IsSpellLearned()
end

local function EvaluateCycleObliterate728(unit)
    return (Unit(unit):HasDeBuffsStacks(A.RazoriceDebuff.ID, true) < 5 or Unit(unit):HasDeBuffs(A.RazoriceDebuff.ID, true) < 10) and not A.Frostscythe:IsSpellLearned() and not Unit("player"):HasBuffs(A.RimeBuff.ID, true) and MultiUnits:GetByRangeInCombat(30, 5, 10) >= 3
end

local function EvaluateCycleObliterate761(unit)
    return (Unit(unit):HasDeBuffsStacks(A.RazoriceDebuff.ID, true) < 5 or Unit(unit):HasDeBuffs(A.RazoriceDebuff.ID, true) < 10) and Unit("player"):HasBuffsStacks(A.KillingMachineBuff.ID, true) or (Unit("player"):HasBuffs(A.KillingMachineBuff.ID, true) and (Player:PrevGCD(1, A.FrostStrike) or Player:PrevGCD(1, A.HowlingBlast) or Player:PrevGCD(1, A.GlacialAdvance)))
end

local function EvaluateCycleFrostStrike802(unit)
    return (Unit(unit):HasDeBuffsStacks(A.RazoriceDebuff.ID, true) < 5 or Unit(unit):HasDeBuffs(A.RazoriceDebuff.ID, true) < 10) and not Unit("player"):HasBuffs(A.RimeBuff.ID, true) or Player:RunicPowerDeficit() < 10 or Player:RuneTimeToX(2) > GetGCD() and not A.Frostscythe:IsSpellLearned()
end

local function EvaluateCycleObliterate825(unit)
    return (Unit(unit):HasDeBuffsStacks(A.RazoriceDebuff.ID, true) < 5 or Unit(unit):HasDeBuffs(A.RazoriceDebuff.ID, true) < 10) and not A.Frostscythe:IsSpellLearned()
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
    local Pull = Action.BossMods_Pulling()
    local DBM = Action.GetToggle(1, "DBM")
    local HeartOfAzeroth = Action.GetToggle(1, "HeartOfAzeroth")
    local Racial = Action.GetToggle(1, "Racial")
    local Potion = Action.GetToggle(1, "Potion")

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
            if A.PotionofSpectralStrength:IsReady(unit) and Potion then
                return A.PotionofSpectralStrength:Show(icon)
            end
            
            -- use_item,name=azsharas_font_of_power
            if A.AzsharasFontofPower:IsReady(unit) then
                return A.AzsharasFontofPower:Show(icon)
            end
            
            -- variable,name=other_on_use_equipped,value=(equipped.notorious_gladiators_badge|equipped.corrupted_gladiators_badge|equipped.corrupted_gladiators_medallion|equipped.vial_of_animated_blood|equipped.first_mates_spyglass|equipped.jes_howler|equipped.notorious_gladiators_medallion|equipped.ashvanes_razor_coral)
            VarOtherOnUseEquipped = num((A.NotoriousGladiatorsBadge:IsExists() or A.CorruptedGladiatorsBadge:IsExists() or A.CorruptedGladiatorsMedallion:IsExists() or A.VialofAnimatedBlood:IsExists() or A.FirstMatesSpyglass:IsExists() or A.JesHowler:IsExists() or A.NotoriousGladiatorsMedallion:IsExists() or A.AshvanesRazorCoral:IsExists()))
            
        end
        
        --Aoe
        local function Aoe(unit)
        
            -- remorseless_winter,if=talent.gathering_storm.enabled|(azerite.frozen_tempest.rank&spell_targets.remorseless_winter>=3&!buff.rime.up)
            if A.RemorselessWinter:IsReady(unit) and (A.GatheringStorm:IsSpellLearned() or (A.FrozenTempest:GetAzeriteRank() and MultiUnits:GetByRangeInCombat(8, 5, 10) >= 3 and not Unit("player"):HasBuffs(A.RimeBuff.ID, true))) then
                return A.RemorselessWinter:Show(icon)
            end
            
            -- glacial_advance,if=talent.frostscythe.enabled
            if A.GlacialAdvance:IsReady(unit) and (A.Frostscythe:IsSpellLearned()) then
                return A.GlacialAdvance:Show(icon)
            end
            
            -- frost_strike,target_if=(debuff.razorice.stack<5|debuff.razorice.remains<10)&cooldown.remorseless_winter.remains<=2*gcd&talent.gathering_storm.enabled&!talent.frostscythe.enabled
            if A.FrostStrike:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.FrostStrike, 10, "min", EvaluateCycleFrostStrike42) then
                    return A.FrostStrike:Show(icon) 
                end
            end
            -- frost_strike,if=cooldown.remorseless_winter.remains<=2*gcd&talent.gathering_storm.enabled
            if A.FrostStrike:IsReady(unit) and (A.RemorselessWinter:GetCooldown() <= 2 * GetGCD() and A.GatheringStorm:IsSpellLearned()) then
                return A.FrostStrike:Show(icon)
            end
            
            -- howling_blast,if=buff.rime.up
            if A.HowlingBlast:IsReady(unit) and (Unit("player"):HasBuffs(A.RimeBuff.ID, true)) then
                return A.HowlingBlast:Show(icon)
            end
            
            -- frostscythe,if=buff.killing_machine.up
            if A.Frostscythe:IsReady(unit) and (Unit("player"):HasBuffs(A.KillingMachineBuff.ID, true)) then
                return A.Frostscythe:Show(icon)
            end
            
            -- glacial_advance,if=runic_power.deficit<(15+talent.runic_attenuation.enabled*3)
            if A.GlacialAdvance:IsReady(unit) and (Player:RunicPowerDeficit() < (15 + num(A.RunicAttenuation:IsSpellLearned()) * 3)) then
                return A.GlacialAdvance:Show(icon)
            end
            
            -- frost_strike,target_if=(debuff.razorice.stack<5|debuff.razorice.remains<10)&runic_power.deficit<(15+talent.runic_attenuation.enabled*3)&!talent.frostscythe.enabled
            if A.FrostStrike:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.FrostStrike, 10, "min", EvaluateCycleFrostStrike77) then
                    return A.FrostStrike:Show(icon) 
                end
            end
            -- frost_strike,if=runic_power.deficit<(15+talent.runic_attenuation.enabled*3)&!talent.frostscythe.enabled
            if A.FrostStrike:IsReady(unit) and (Player:RunicPowerDeficit() < (15 + num(A.RunicAttenuation:IsSpellLearned()) * 3) and not A.Frostscythe:IsSpellLearned()) then
                return A.FrostStrike:Show(icon)
            end
            
            -- remorseless_winter
            if A.RemorselessWinter:IsReady(unit) then
                return A.RemorselessWinter:Show(icon)
            end
            
            -- frostscythe
            if A.Frostscythe:IsReady(unit) then
                return A.Frostscythe:Show(icon)
            end
            
            -- obliterate,target_if=(debuff.razorice.stack<5|debuff.razorice.remains<10)&runic_power.deficit>(25+talent.runic_attenuation.enabled*3)&!talent.frostscythe.enabled
            if A.Obliterate:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.Obliterate, 10, "min", EvaluateCycleObliterate102) then
                    return A.Obliterate:Show(icon) 
                end
            end
            -- obliterate,if=runic_power.deficit>(25+talent.runic_attenuation.enabled*3)
            if A.Obliterate:IsReady(unit) and (Player:RunicPowerDeficit() > (25 + num(A.RunicAttenuation:IsSpellLearned()) * 3)) then
                return A.Obliterate:Show(icon)
            end
            
            -- glacial_advance
            if A.GlacialAdvance:IsReady(unit) then
                return A.GlacialAdvance:Show(icon)
            end
            
            -- frost_strike,target_if=(debuff.razorice.stack<5|debuff.razorice.remains<10)&!talent.frostscythe.enabled
            if A.FrostStrike:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.FrostStrike, 10, "min", EvaluateCycleFrostStrike123) then
                    return A.FrostStrike:Show(icon) 
                end
            end
            -- frost_strike
            if A.FrostStrike:IsReady(unit) then
                return A.FrostStrike:Show(icon)
            end
            
            -- horn_of_winter
            if A.HornofWinter:IsReady(unit) then
                return A.HornofWinter:Show(icon)
            end
            
            -- arcane_torrent
            if A.ArcaneTorrent:AutoRacial(unit) and Racial and A.BurstIsON(unit) then
                return A.ArcaneTorrent:Show(icon)
            end
            
        end
        
        --BosPooling
        local function BosPooling(unit)
        
            -- howling_blast,if=buff.rime.up
            if A.HowlingBlast:IsReady(unit) and (Unit("player"):HasBuffs(A.RimeBuff.ID, true)) then
                return A.HowlingBlast:Show(icon)
            end
            
            -- obliterate,target_if=(debuff.razorice.stack<5|debuff.razorice.remains<10)&&runic_power.deficit>=25&!talent.frostscythe.enabled
            if A.Obliterate:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.Obliterate, 10, "min", EvaluateCycleObliterate146) then
                    return A.Obliterate:Show(icon) 
                end
            end
            -- obliterate,if=runic_power.deficit>=25
            if A.Obliterate:IsReady(unit) and (Player:RunicPowerDeficit() >= 25) then
                return A.Obliterate:Show(icon)
            end
            
            -- glacial_advance,if=runic_power.deficit<20&spell_targets.glacial_advance>=2&cooldown.pillar_of_frost.remains>5
            if A.GlacialAdvance:IsReady(unit) and (Player:RunicPowerDeficit() < 20 and MultiUnits:GetByRangeInCombat(30, 5, 10) >= 2 and A.PillarofFrost:GetCooldown() > 5) then
                return A.GlacialAdvance:Show(icon)
            end
            
            -- frost_strike,target_if=(debuff.razorice.stack<5|debuff.razorice.remains<10)&runic_power.deficit<20&!talent.frostscythe.enabled&cooldown.pillar_of_frost.remains>5
            if A.FrostStrike:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.FrostStrike, 10, "min", EvaluateCycleFrostStrike165) then
                    return A.FrostStrike:Show(icon) 
                end
            end
            -- frost_strike,if=runic_power.deficit<20&cooldown.pillar_of_frost.remains>5
            if A.FrostStrike:IsReady(unit) and (Player:RunicPowerDeficit() < 20 and A.PillarofFrost:GetCooldown() > 5) then
                return A.FrostStrike:Show(icon)
            end
            
            -- frostscythe,if=buff.killing_machine.up&runic_power.deficit>(15+talent.runic_attenuation.enabled*3)&spell_targets.frostscythe>=2
            if A.Frostscythe:IsReady(unit) and (Unit("player"):HasBuffs(A.KillingMachineBuff.ID, true) and Player:RunicPowerDeficit() > (15 + num(A.RunicAttenuation:IsSpellLearned()) * 3) and MultiUnits:GetByRangeInCombat(8, 5, 10) >= 2) then
                return A.Frostscythe:Show(icon)
            end
            
            -- frostscythe,if=runic_power.deficit>=(35+talent.runic_attenuation.enabled*3)&spell_targets.frostscythe>=2
            if A.Frostscythe:IsReady(unit) and (Player:RunicPowerDeficit() >= (35 + num(A.RunicAttenuation:IsSpellLearned()) * 3) and MultiUnits:GetByRangeInCombat(8, 5, 10) >= 2) then
                return A.Frostscythe:Show(icon)
            end
            
            -- obliterate,target_if=(debuff.razorice.stack<5|debuff.razorice.remains<10)&runic_power.deficit>=(35+talent.runic_attenuation.enabled*3)&!talent.frostscythe.enabled
            if A.Obliterate:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.Obliterate, 10, "min", EvaluateCycleObliterate194) then
                    return A.Obliterate:Show(icon) 
                end
            end
            -- obliterate,if=runic_power.deficit>=(35+talent.runic_attenuation.enabled*3)
            if A.Obliterate:IsReady(unit) and (Player:RunicPowerDeficit() >= (35 + num(A.RunicAttenuation:IsSpellLearned()) * 3)) then
                return A.Obliterate:Show(icon)
            end
            
            -- glacial_advance,if=cooldown.pillar_of_frost.remains>rune.time_to_4&runic_power.deficit<40&spell_targets.glacial_advance>=2
            if A.GlacialAdvance:IsReady(unit) and (A.PillarofFrost:GetCooldown() > Player:RuneTimeToX(4) and Player:RunicPowerDeficit() < 40 and MultiUnits:GetByRangeInCombat(30, 5, 10) >= 2) then
                return A.GlacialAdvance:Show(icon)
            end
            
            -- frost_strike,target_if=(debuff.razorice.stack<5|debuff.razorice.remains<10)&cooldown.pillar_of_frost.remains>rune.time_to_4&runic_power.deficit<40&!talent.frostscythe.enabled
            if A.FrostStrike:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.FrostStrike, 10, "min", EvaluateCycleFrostStrike217) then
                    return A.FrostStrike:Show(icon) 
                end
            end
            -- frost_strike,if=cooldown.pillar_of_frost.remains>rune.time_to_4&runic_power.deficit<40
            if A.FrostStrike:IsReady(unit) and (A.PillarofFrost:GetCooldown() > Player:RuneTimeToX(4) and Player:RunicPowerDeficit() < 40) then
                return A.FrostStrike:Show(icon)
            end
            
        end
        
        --BosTicking
        local function BosTicking(unit)
        
            -- obliterate,target_if=(debuff.razorice.stack<5|debuff.razorice.remains<10)&runic_power<=32&!talent.frostscythe.enabled
            if A.Obliterate:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.Obliterate, 10, "min", EvaluateCycleObliterate236) then
                    return A.Obliterate:Show(icon) 
                end
            end
            -- obliterate,if=runic_power<=32
            if A.Obliterate:IsReady(unit) and (Player:RunicPower() <= 32) then
                return A.Obliterate:Show(icon)
            end
            
            -- remorseless_winter,if=talent.gathering_storm.enabled
            if A.RemorselessWinter:IsReady(unit) and (A.GatheringStorm:IsSpellLearned()) then
                return A.RemorselessWinter:Show(icon)
            end
            
            -- howling_blast,if=buff.rime.up
            if A.HowlingBlast:IsReady(unit) and (Unit("player"):HasBuffs(A.RimeBuff.ID, true)) then
                return A.HowlingBlast:Show(icon)
            end
            
            -- obliterate,target_if=(debuff.razorice.stack<5|debuff.razorice.remains<10)&rune.time_to_5<gcd|runic_power<=45&!talent.frostscythe.enabled
            if A.Obliterate:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.Obliterate, 10, "min", EvaluateCycleObliterate259) then
                    return A.Obliterate:Show(icon) 
                end
            end
            -- obliterate,if=rune.time_to_5<gcd|runic_power<=45
            if A.Obliterate:IsReady(unit) and (Player:RuneTimeToX(5) < GetGCD() or Player:RunicPower() <= 45) then
                return A.Obliterate:Show(icon)
            end
            
            -- frostscythe,if=buff.killing_machine.up&spell_targets.frostscythe>=2
            if A.Frostscythe:IsReady(unit) and (Unit("player"):HasBuffs(A.KillingMachineBuff.ID, true) and MultiUnits:GetByRangeInCombat(8, 5, 10) >= 2) then
                return A.Frostscythe:Show(icon)
            end
            
            -- horn_of_winter,if=runic_power.deficit>=32&rune.time_to_3>gcd
            if A.HornofWinter:IsReady(unit) and (Player:RunicPowerDeficit() >= 32 and Player:RuneTimeToX(3) > GetGCD()) then
                return A.HornofWinter:Show(icon)
            end
            
            -- remorseless_winter
            if A.RemorselessWinter:IsReady(unit) then
                return A.RemorselessWinter:Show(icon)
            end
            
            -- frostscythe,if=spell_targets.frostscythe>=2
            if A.Frostscythe:IsReady(unit) and (MultiUnits:GetByRangeInCombat(8, 5, 10) >= 2) then
                return A.Frostscythe:Show(icon)
            end
            
            -- obliterate,target_if=(debuff.razorice.stack<5|debuff.razorice.remains<10)&runic_power.deficit>25|rune>3&!talent.frostscythe.enabled
            if A.Obliterate:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.Obliterate, 10, "min", EvaluateCycleObliterate284) then
                    return A.Obliterate:Show(icon) 
                end
            end
            -- obliterate,if=runic_power.deficit>25|rune>3
            if A.Obliterate:IsReady(unit) and (Player:RunicPowerDeficit() > 25 or Player:Rune() > 3) then
                return A.Obliterate:Show(icon)
            end
            
            -- arcane_torrent,if=runic_power.deficit>50
            if A.ArcaneTorrent:AutoRacial(unit) and Racial and A.BurstIsON(unit) and (Player:RunicPowerDeficit() > 50) then
                return A.ArcaneTorrent:Show(icon)
            end
            
        end
        
        --ColdHeart
        local function ColdHeart(unit)
        
            -- chains_of_ice,if=buff.cold_heart.stack>5&target.1.time_to_die<gcd
            if A.ChainsofIce:IsReady(unit) and (Unit("player"):HasBuffsStacks(A.ColdHeartBuff.ID, true) > 5 and target.1.time_to_die < GetGCD()) then
                return A.ChainsofIce:Show(icon)
            end
            
            -- chains_of_ice,if=(buff.seething_rage.remains<gcd)&buff.seething_rage.up
            if A.ChainsofIce:IsReady(unit) and ((Unit("player"):HasBuffs(A.SeethingRageBuff.ID, true) < GetGCD()) and Unit("player"):HasBuffs(A.SeethingRageBuff.ID, true)) then
                return A.ChainsofIce:Show(icon)
            end
            
            -- chains_of_ice,if=(buff.pillar_of_frost.remains<=gcd*(1+cooldown.frostwyrms_fury.ready)|buff.pillar_of_frost.remains<rune.time_to_3)&buff.pillar_of_frost.up&(azerite.icy_citadel.rank<=1|buff.breath_of_sindragosa.up)&!talent.icecap.enabled
            if A.ChainsofIce:IsReady(unit) and ((Unit("player"):HasBuffs(A.PillarofFrostBuff.ID, true) <= GetGCD() * (1 + num(A.FrostwyrmsFury:GetCooldown() == 0)) or Unit("player"):HasBuffs(A.PillarofFrostBuff.ID, true) < Player:RuneTimeToX(3)) and Unit("player"):HasBuffs(A.PillarofFrostBuff.ID, true) and (A.IcyCitadel:GetAzeriteRank() <= 1 or Unit("player"):HasBuffs(A.BreathofSindragosaBuff.ID, true)) and not A.Icecap:IsSpellLearned()) then
                return A.ChainsofIce:Show(icon)
            end
            
            -- chains_of_ice,if=buff.pillar_of_frost.remains<8&buff.unholy_strength.remains<gcd*(1+cooldown.frostwyrms_fury.ready)&buff.unholy_strength.remains&buff.pillar_of_frost.up&(azerite.icy_citadel.rank<=1|buff.breath_of_sindragosa.up)&!talent.icecap.enabled
            if A.ChainsofIce:IsReady(unit) and (Unit("player"):HasBuffs(A.PillarofFrostBuff.ID, true) < 8 and Unit("player"):HasBuffs(A.UnholyStrengthBuff.ID, true) < GetGCD() * (1 + num(A.FrostwyrmsFury:GetCooldown() == 0)) and Unit("player"):HasBuffs(A.UnholyStrengthBuff.ID, true) and Unit("player"):HasBuffs(A.PillarofFrostBuff.ID, true) and (A.IcyCitadel:GetAzeriteRank() <= 1 or Unit("player"):HasBuffs(A.BreathofSindragosaBuff.ID, true)) and not A.Icecap:IsSpellLearned()) then
                return A.ChainsofIce:Show(icon)
            end
            
            -- chains_of_ice,if=(buff.icy_citadel.remains<4|buff.icy_citadel.remains<rune.time_to_3)&buff.icy_citadel.up&azerite.icy_citadel.rank>=2&!buff.breath_of_sindragosa.up&!talent.icecap.enabled
            if A.ChainsofIce:IsReady(unit) and ((Unit("player"):HasBuffs(A.IcyCitadelBuff.ID, true) < 4 or Unit("player"):HasBuffs(A.IcyCitadelBuff.ID, true) < Player:RuneTimeToX(3)) and Unit("player"):HasBuffs(A.IcyCitadelBuff.ID, true) and A.IcyCitadel:GetAzeriteRank() >= 2 and not Unit("player"):HasBuffs(A.BreathofSindragosaBuff.ID, true) and not A.Icecap:IsSpellLearned()) then
                return A.ChainsofIce:Show(icon)
            end
            
            -- chains_of_ice,if=buff.icy_citadel.up&buff.unholy_strength.up&azerite.icy_citadel.rank>=2&!buff.breath_of_sindragosa.up&!talent.icecap.enabled
            if A.ChainsofIce:IsReady(unit) and (Unit("player"):HasBuffs(A.IcyCitadelBuff.ID, true) and Unit("player"):HasBuffs(A.UnholyStrengthBuff.ID, true) and A.IcyCitadel:GetAzeriteRank() >= 2 and not Unit("player"):HasBuffs(A.BreathofSindragosaBuff.ID, true) and not A.Icecap:IsSpellLearned()) then
                return A.ChainsofIce:Show(icon)
            end
            
            -- chains_of_ice,if=buff.pillar_of_frost.remains<4&buff.pillar_of_frost.up&talent.icecap.enabled&buff.cold_heart.stack>=18&azerite.icy_citadel.rank<=1
            if A.ChainsofIce:IsReady(unit) and (Unit("player"):HasBuffs(A.PillarofFrostBuff.ID, true) < 4 and Unit("player"):HasBuffs(A.PillarofFrostBuff.ID, true) and A.Icecap:IsSpellLearned() and Unit("player"):HasBuffsStacks(A.ColdHeartBuff.ID, true) >= 18 and A.IcyCitadel:GetAzeriteRank() <= 1) then
                return A.ChainsofIce:Show(icon)
            end
            
            -- chains_of_ice,if=buff.pillar_of_frost.up&talent.icecap.enabled&azerite.icy_citadel.rank>=2&(buff.cold_heart.stack>=19&buff.icy_citadel.remains<gcd&buff.icy_citadel.up|buff.unholy_strength.up&buff.cold_heart.stack>=18)
            if A.ChainsofIce:IsReady(unit) and (Unit("player"):HasBuffs(A.PillarofFrostBuff.ID, true) and A.Icecap:IsSpellLearned() and A.IcyCitadel:GetAzeriteRank() >= 2 and (Unit("player"):HasBuffsStacks(A.ColdHeartBuff.ID, true) >= 19 and Unit("player"):HasBuffs(A.IcyCitadelBuff.ID, true) < GetGCD() and Unit("player"):HasBuffs(A.IcyCitadelBuff.ID, true) or Unit("player"):HasBuffs(A.UnholyStrengthBuff.ID, true) and Unit("player"):HasBuffsStacks(A.ColdHeartBuff.ID, true) >= 18)) then
                return A.ChainsofIce:Show(icon)
            end
            
        end
        
        --Cooldowns
        local function Cooldowns(unit)
        
            -- use_item,name=azsharas_font_of_power,if=(cooldown.empowered_rune_weapon.ready&!variable.other_on_use_equipped)|(cooldown.pillar_of_frost.remains<=10&variable.other_on_use_equipped)
            if A.AzsharasFontofPower:IsReady(unit) and ((A.EmpoweredRuneWeapon:GetCooldown() == 0 and not VarOtherOnUseEquipped) or (A.PillarofFrost:GetCooldown() <= 10 and VarOtherOnUseEquipped)) then
                return A.AzsharasFontofPower:Show(icon)
            end
            
            -- use_item,name=lurkers_insidious_gift,if=talent.breath_of_sindragosa.enabled&((cooldown.pillar_of_frost.remains<=10&variable.other_on_use_equipped)|(buff.pillar_of_frost.up&!variable.other_on_use_equipped))|(buff.pillar_of_frost.up&!talent.breath_of_sindragosa.enabled)
            if A.LurkersInsidiousGift:IsReady(unit) and (A.BreathofSindragosa:IsSpellLearned() and ((A.PillarofFrost:GetCooldown() <= 10 and VarOtherOnUseEquipped) or (Unit("player"):HasBuffs(A.PillarofFrostBuff.ID, true) and not VarOtherOnUseEquipped)) or (Unit("player"):HasBuffs(A.PillarofFrostBuff.ID, true) and not A.BreathofSindragosa:IsSpellLearned())) then
                return A.LurkersInsidiousGift:Show(icon)
            end
            
            -- use_item,name=cyclotronic_blast,if=!buff.pillar_of_frost.up
            if A.CyclotronicBlast:IsReady(unit) and (not Unit("player"):HasBuffs(A.PillarofFrostBuff.ID, true)) then
                return A.CyclotronicBlast:Show(icon)
            end
            
            -- use_items,if=(cooldown.pillar_of_frost.ready|cooldown.pillar_of_frost.remains>20)&(!talent.breath_of_sindragosa.enabled|cooldown.empower_rune_weapon.remains>95)
            -- use_item,name=ashvanes_razor_coral,if=debuff.razor_coral_debuff.down
            if A.AshvanesRazorCoral:IsReady(unit) and (Unit(unit):HasDeBuffsDown(A.RazorCoralDebuff.ID, true)) then
                return A.AshvanesRazorCoral:Show(icon)
            end
            
            -- use_item,name=ashvanes_razor_coral,if=cooldown.empower_rune_weapon.remains>90&debuff.razor_coral_debuff.up&variable.other_on_use_equipped|buff.breath_of_sindragosa.up&debuff.razor_coral_debuff.up&!variable.other_on_use_equipped|buff.empower_rune_weapon.up&debuff.razor_coral_debuff.up&!talent.breath_of_sindragosa.enabled|target.1.time_to_die<21
            if A.AshvanesRazorCoral:IsReady(unit) and (A.EmpowerRuneWeapon:GetCooldown() > 90 and Unit(unit):HasDeBuffs(A.RazorCoralDebuff.ID, true) and VarOtherOnUseEquipped or Unit("player"):HasBuffs(A.BreathofSindragosaBuff.ID, true) and Unit(unit):HasDeBuffs(A.RazorCoralDebuff.ID, true) and not VarOtherOnUseEquipped or Unit("player"):HasBuffs(A.EmpowerRuneWeaponBuff.ID, true) and Unit(unit):HasDeBuffs(A.RazorCoralDebuff.ID, true) and not A.BreathofSindragosa:IsSpellLearned() or target.1.time_to_die < 21) then
                return A.AshvanesRazorCoral:Show(icon)
            end
            
            -- use_item,name=jes_howler,if=(equipped.lurkers_insidious_gift&buff.pillar_of_frost.remains)|(!equipped.lurkers_insidious_gift&buff.pillar_of_frost.remains<12&buff.pillar_of_frost.up)
            if A.JesHowler:IsReady(unit) and ((A.LurkersInsidiousGift:IsExists() and Unit("player"):HasBuffs(A.PillarofFrostBuff.ID, true)) or (not A.LurkersInsidiousGift:IsExists() and Unit("player"):HasBuffs(A.PillarofFrostBuff.ID, true) < 12 and Unit("player"):HasBuffs(A.PillarofFrostBuff.ID, true))) then
                return A.JesHowler:Show(icon)
            end
            
            -- use_item,name=knot_of_ancient_fury,if=cooldown.empower_rune_weapon.remains>40
            if A.KnotofAncientFury:IsReady(unit) and (A.EmpowerRuneWeapon:GetCooldown() > 40) then
                return A.KnotofAncientFury:Show(icon)
            end
            
            -- use_item,name=grongs_primal_rage,if=rune<=3&!buff.pillar_of_frost.up&(!buff.breath_of_sindragosa.up|!talent.breath_of_sindragosa.enabled)
            if A.GrongsPrimalRage:IsReady(unit) and (Player:Rune() <= 3 and not Unit("player"):HasBuffs(A.PillarofFrostBuff.ID, true) and (not Unit("player"):HasBuffs(A.BreathofSindragosaBuff.ID, true) or not A.BreathofSindragosa:IsSpellLearned())) then
                return A.GrongsPrimalRage:Show(icon)
            end
            
            -- use_item,name=razdunks_big_red_button
            if A.RazdunksBigRedButton:IsReady(unit) then
                return A.RazdunksBigRedButton:Show(icon)
            end
            
            -- use_item,name=merekthas_fang,if=!buff.breath_of_sindragosa.up&!buff.pillar_of_frost.up
            if A.MerekthasFang:IsReady(unit) and (not Unit("player"):HasBuffs(A.BreathofSindragosaBuff.ID, true) and not Unit("player"):HasBuffs(A.PillarofFrostBuff.ID, true)) then
                return A.MerekthasFang:Show(icon)
            end
            
            -- potion,if=buff.pillar_of_frost.up&buff.empower_rune_weapon.up
            if A.PotionofSpectralStrength:IsReady(unit) and Potion and (Unit("player"):HasBuffs(A.PillarofFrostBuff.ID, true) and Unit("player"):HasBuffs(A.EmpowerRuneWeaponBuff.ID, true)) then
                return A.PotionofSpectralStrength:Show(icon)
            end
            
            -- blood_fury,if=buff.pillar_of_frost.up&buff.empower_rune_weapon.up
            if A.BloodFury:AutoRacial(unit) and Racial and A.BurstIsON(unit) and (Unit("player"):HasBuffs(A.PillarofFrostBuff.ID, true) and Unit("player"):HasBuffs(A.EmpowerRuneWeaponBuff.ID, true)) then
                return A.BloodFury:Show(icon)
            end
            
            -- berserking,if=buff.pillar_of_frost.up
            if A.Berserking:AutoRacial(unit) and Racial and A.BurstIsON(unit) and (Unit("player"):HasBuffs(A.PillarofFrostBuff.ID, true)) then
                return A.Berserking:Show(icon)
            end
            
            -- arcane_pulse,if=(!buff.pillar_of_frost.up&active_enemies>=2)|!buff.pillar_of_frost.up&(rune.deficit>=5&runic_power.deficit>=60)
            if A.ArcanePulse:AutoRacial(unit) and Racial and ((not Unit("player"):HasBuffs(A.PillarofFrostBuff.ID, true) and MultiUnits:GetByRangeInCombat(10, 5, 10) >= 2) or not Unit("player"):HasBuffs(A.PillarofFrostBuff.ID, true) and (Player:RuneDeficit() >= 5 and Player:RunicPowerDeficit() >= 60)) then
                return A.ArcanePulse:Show(icon)
            end
            
            -- lights_judgment,if=buff.pillar_of_frost.up
            if A.LightsJudgment:IsReady(unit) and A.BurstIsON(unit) and (Unit("player"):HasBuffs(A.PillarofFrostBuff.ID, true)) then
                return A.LightsJudgment:Show(icon)
            end
            
            -- ancestral_call,if=buff.pillar_of_frost.up&buff.empower_rune_weapon.up
            if A.AncestralCall:AutoRacial(unit) and Racial and A.BurstIsON(unit) and (Unit("player"):HasBuffs(A.PillarofFrostBuff.ID, true) and Unit("player"):HasBuffs(A.EmpowerRuneWeaponBuff.ID, true)) then
                return A.AncestralCall:Show(icon)
            end
            
            -- fireblood,if=buff.pillar_of_frost.remains<=8&buff.empower_rune_weapon.up
            if A.Fireblood:AutoRacial(unit) and Racial and A.BurstIsON(unit) and (Unit("player"):HasBuffs(A.PillarofFrostBuff.ID, true) <= 8 and Unit("player"):HasBuffs(A.EmpowerRuneWeaponBuff.ID, true)) then
                return A.Fireblood:Show(icon)
            end
            
            -- bag_of_tricks,if=buff.pillar_of_frost.up&(buff.pillar_of_frost.remains<5&talent.cold_heart.enabled|!talent.cold_heart.enabled&buff.pillar_of_frost.remains<3)&active_enemies=1|buff.seething_rage.up&active_enemies=1
            if A.BagofTricks:IsReady(unit) and (Unit("player"):HasBuffs(A.PillarofFrostBuff.ID, true) and (Unit("player"):HasBuffs(A.PillarofFrostBuff.ID, true) < 5 and A.ColdHeart:IsSpellLearned() or not A.ColdHeart:IsSpellLearned() and Unit("player"):HasBuffs(A.PillarofFrostBuff.ID, true) < 3) and MultiUnits:GetByRangeInCombat(10, 5, 10) == 1 or Unit("player"):HasBuffs(A.SeethingRageBuff.ID, true) and MultiUnits:GetByRangeInCombat(10, 5, 10) == 1) then
                return A.BagofTricks:Show(icon)
            end
            
            -- pillar_of_frost,if=(cooldown.empower_rune_weapon.remains|talent.icecap.enabled)&!buff.pillar_of_frost.up
            if A.PillarofFrost:IsReady(unit) and ((A.EmpowerRuneWeapon:GetCooldown() or A.Icecap:IsSpellLearned()) and not Unit("player"):HasBuffs(A.PillarofFrostBuff.ID, true)) then
                return A.PillarofFrost:Show(icon)
            end
            
            -- breath_of_sindragosa,use_off_gcd=1,if=cooldown.empower_rune_weapon.remains&cooldown.pillar_of_frost.remains
            if A.BreathofSindragosa:IsReady(unit) and (A.EmpowerRuneWeapon:GetCooldown() and A.PillarofFrost:GetCooldown()) then
                return A.BreathofSindragosa:Show(icon)
            end
            
            -- empower_rune_weapon,if=cooldown.pillar_of_frost.ready&talent.obliteration.enabled&rune.time_to_5>gcd&runic_power.deficit>=10|target.1.time_to_die<20
            if A.EmpowerRuneWeapon:IsReady(unit) and (A.PillarofFrost:GetCooldown() == 0 and A.Obliteration:IsSpellLearned() and Player:RuneTimeToX(5) > GetGCD() and Player:RunicPowerDeficit() >= 10 or target.1.time_to_die < 20) then
                return A.EmpowerRuneWeapon:Show(icon)
            end
            
            -- empower_rune_weapon,if=(cooldown.pillar_of_frost.ready|target.1.time_to_die<20)&talent.breath_of_sindragosa.enabled&runic_power>60
            if A.EmpowerRuneWeapon:IsReady(unit) and ((A.PillarofFrost:GetCooldown() == 0 or target.1.time_to_die < 20) and A.BreathofSindragosa:IsSpellLearned() and Player:RunicPower() > 60) then
                return A.EmpowerRuneWeapon:Show(icon)
            end
            
            -- empower_rune_weapon,if=talent.icecap.enabled&rune<3
            if A.EmpowerRuneWeapon:IsReady(unit) and (A.Icecap:IsSpellLearned() and Player:Rune() < 3) then
                return A.EmpowerRuneWeapon:Show(icon)
            end
            
            -- call_action_list,name=cold_heart,if=talent.cold_heart.enabled&((buff.cold_heart.stack>=10&debuff.razorice.stack=5)|target.1.time_to_die<=gcd)
            if (A.ColdHeart:IsSpellLearned() and ((Unit("player"):HasBuffsStacks(A.ColdHeartBuff.ID, true) >= 10 and Unit(unit):HasDeBuffsStacks(A.RazoriceDebuff.ID, true) == 5) or target.1.time_to_die <= GetGCD())) then
                if ColdHeart(unit) then
                    return true
                end
            end
            
            -- frostwyrms_fury,if=(buff.pillar_of_frost.up&azerite.icy_citadel.rank<=1&(buff.pillar_of_frost.remains<=gcd|buff.unholy_strength.remains<=gcd&buff.unholy_strength.up))
            if A.FrostwyrmsFury:IsReady(unit) and ((Unit("player"):HasBuffs(A.PillarofFrostBuff.ID, true) and A.IcyCitadel:GetAzeriteRank() <= 1 and (Unit("player"):HasBuffs(A.PillarofFrostBuff.ID, true) <= GetGCD() or Unit("player"):HasBuffs(A.UnholyStrengthBuff.ID, true) <= GetGCD() and Unit("player"):HasBuffs(A.UnholyStrengthBuff.ID, true)))) then
                return A.FrostwyrmsFury:Show(icon)
            end
            
            -- frostwyrms_fury,if=(buff.icy_citadel.up&!talent.icecap.enabled&(buff.unholy_strength.up|buff.icy_citadel.remains<=gcd))|buff.icy_citadel.up&buff.icy_citadel.remains<=gcd&talent.icecap.enabled&buff.pillar_of_frost.up
            if A.FrostwyrmsFury:IsReady(unit) and ((Unit("player"):HasBuffs(A.IcyCitadelBuff.ID, true) and not A.Icecap:IsSpellLearned() and (Unit("player"):HasBuffs(A.UnholyStrengthBuff.ID, true) or Unit("player"):HasBuffs(A.IcyCitadelBuff.ID, true) <= GetGCD())) or Unit("player"):HasBuffs(A.IcyCitadelBuff.ID, true) and Unit("player"):HasBuffs(A.IcyCitadelBuff.ID, true) <= GetGCD() and A.Icecap:IsSpellLearned() and Unit("player"):HasBuffs(A.PillarofFrostBuff.ID, true)) then
                return A.FrostwyrmsFury:Show(icon)
            end
            
            -- frostwyrms_fury,if=target.1.time_to_die<gcd|(target.1.time_to_die<cooldown.pillar_of_frost.remains&buff.unholy_strength.up)
            if A.FrostwyrmsFury:IsReady(unit) and (target.1.time_to_die < GetGCD() or (target.1.time_to_die < A.PillarofFrost:GetCooldown() and Unit("player"):HasBuffs(A.UnholyStrengthBuff.ID, true))) then
                return A.FrostwyrmsFury:Show(icon)
            end
            
        end
        
        --Essences
        local function Essences(unit)
        
            -- blood_of_the_enemy,if=buff.pillar_of_frost.up&(buff.pillar_of_frost.remains<10&(buff.breath_of_sindragosa.up|talent.obliteration.enabled|talent.icecap.enabled&!azerite.icy_citadel.enabled)|buff.icy_citadel.up&talent.icecap.enabled)
            if A.BloodoftheEnemy:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and (Unit("player"):HasBuffs(A.PillarofFrostBuff.ID, true) and (Unit("player"):HasBuffs(A.PillarofFrostBuff.ID, true) < 10 and (Unit("player"):HasBuffs(A.BreathofSindragosaBuff.ID, true) or A.Obliteration:IsSpellLearned() or A.Icecap:IsSpellLearned() and not A.IcyCitadel:GetAzeriteRank() > 0) or Unit("player"):HasBuffs(A.IcyCitadelBuff.ID, true) and A.Icecap:IsSpellLearned())) then
                return A.BloodoftheEnemy:Show(icon)
            end
            
            -- guardian_of_azeroth,if=!talent.icecap.enabled|talent.icecap.enabled&azerite.icy_citadel.enabled&buff.pillar_of_frost.remains<6&buff.pillar_of_frost.up|talent.icecap.enabled&!azerite.icy_citadel.enabled
            if A.GuardianofAzeroth:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and (not A.Icecap:IsSpellLearned() or A.Icecap:IsSpellLearned() and A.IcyCitadel:GetAzeriteRank() > 0 and Unit("player"):HasBuffs(A.PillarofFrostBuff.ID, true) < 6 and Unit("player"):HasBuffs(A.PillarofFrostBuff.ID, true) or A.Icecap:IsSpellLearned() and not A.IcyCitadel:GetAzeriteRank() > 0) then
                return A.GuardianofAzeroth:Show(icon)
            end
            
            -- chill_streak,if=buff.pillar_of_frost.remains<5&buff.pillar_of_frost.up|target.1.time_to_die<5
            if A.ChillStreak:IsReady(unit) and (Unit("player"):HasBuffs(A.PillarofFrostBuff.ID, true) < 5 and Unit("player"):HasBuffs(A.PillarofFrostBuff.ID, true) or target.1.time_to_die < 5) then
                return A.ChillStreak:Show(icon)
            end
            
            -- the_unbound_force,if=buff.reckless_force.up|buff.reckless_force_counter.stack<11
            if A.TheUnboundForce:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and (Unit("player"):HasBuffs(A.RecklessForceBuff.ID, true) or Unit("player"):HasBuffsStacks(A.RecklessForceCounterBuff.ID, true) < 11) then
                return A.TheUnboundForce:Show(icon)
            end
            
            -- focused_azerite_beam,if=!buff.pillar_of_frost.up&!buff.breath_of_sindragosa.up
            if A.FocusedAzeriteBeam:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and (not Unit("player"):HasBuffs(A.PillarofFrostBuff.ID, true) and not Unit("player"):HasBuffs(A.BreathofSindragosaBuff.ID, true)) then
                return A.FocusedAzeriteBeam:Show(icon)
            end
            
            -- concentrated_flame,if=!buff.pillar_of_frost.up&!buff.breath_of_sindragosa.up&dot.concentrated_flame_burn.remains=0
            if A.ConcentratedFlame:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and (not Unit("player"):HasBuffs(A.PillarofFrostBuff.ID, true) and not Unit("player"):HasBuffs(A.BreathofSindragosaBuff.ID, true) and Unit(unit):HasDeBuffs(A.ConcentratedFlameBurnDebuff.ID, true) == 0) then
                return A.ConcentratedFlame:Show(icon)
            end
            
            -- purifying_blast,if=!buff.pillar_of_frost.up&!buff.breath_of_sindragosa.up
            if A.PurifyingBlast:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and (not Unit("player"):HasBuffs(A.PillarofFrostBuff.ID, true) and not Unit("player"):HasBuffs(A.BreathofSindragosaBuff.ID, true)) then
                return A.PurifyingBlast:Show(icon)
            end
            
            -- worldvein_resonance,if=buff.pillar_of_frost.up|buff.empower_rune_weapon.up|cooldown.breath_of_sindragosa.remains>60+15|equipped.ineffable_truth|equipped.ineffable_truth_oh
            if A.WorldveinResonance:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and (Unit("player"):HasBuffs(A.PillarofFrostBuff.ID, true) or Unit("player"):HasBuffs(A.EmpowerRuneWeaponBuff.ID, true) or A.BreathofSindragosa:GetCooldown() > 60 + 15 or A.IneffableTruth:IsExists() or A.IneffableTruthOh:IsExists()) then
                return A.WorldveinResonance:Show(icon)
            end
            
            -- ripple_in_space,if=!buff.pillar_of_frost.up&!buff.breath_of_sindragosa.up
            if A.RippleInSpace:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and (not Unit("player"):HasBuffs(A.PillarofFrostBuff.ID, true) and not Unit("player"):HasBuffs(A.BreathofSindragosaBuff.ID, true)) then
                return A.RippleInSpace:Show(icon)
            end
            
            -- memory_of_lucid_dreams,if=buff.empower_rune_weapon.remains<5&buff.breath_of_sindragosa.up|(rune.time_to_2>gcd&runic_power<50)
            if A.MemoryofLucidDreams:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and (Unit("player"):HasBuffs(A.EmpowerRuneWeaponBuff.ID, true) < 5 and Unit("player"):HasBuffs(A.BreathofSindragosaBuff.ID, true) or (Player:RuneTimeToX(2) > GetGCD() and Player:RunicPower() < 50)) then
                return A.MemoryofLucidDreams:Show(icon)
            end
            
            -- reaping_flames
            if A.ReapingFlames:IsReady(unit) then
                return A.ReapingFlames:Show(icon)
            end
            
        end
        
        --Obliteration
        local function Obliteration(unit)
        
            -- remorseless_winter,if=talent.gathering_storm.enabled
            if A.RemorselessWinter:IsReady(unit) and (A.GatheringStorm:IsSpellLearned()) then
                return A.RemorselessWinter:Show(icon)
            end
            
            -- obliterate,target_if=(debuff.razorice.stack<5|debuff.razorice.remains<10)&!talent.frostscythe.enabled&!buff.rime.up&spell_targets.howling_blast>=3
            if A.Obliterate:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.Obliterate, 10, "min", EvaluateCycleObliterate728) then
                    return A.Obliterate:Show(icon) 
                end
            end
            -- obliterate,if=!talent.frostscythe.enabled&!buff.rime.up&spell_targets.howling_blast>=3
            if A.Obliterate:IsReady(unit) and (not A.Frostscythe:IsSpellLearned() and not Unit("player"):HasBuffs(A.RimeBuff.ID, true) and MultiUnits:GetByRangeInCombat(30, 5, 10) >= 3) then
                return A.Obliterate:Show(icon)
            end
            
            -- frostscythe,if=(buff.killing_machine.react|(buff.killing_machine.up&(prev_gcd.1.frost_strike|prev_gcd.1.howling_blast|prev_gcd.1.glacial_advance)))&spell_targets.frostscythe>=2
            if A.Frostscythe:IsReady(unit) and ((Unit("player"):HasBuffsStacks(A.KillingMachineBuff.ID, true) or (Unit("player"):HasBuffs(A.KillingMachineBuff.ID, true) and (Player:PrevGCD(1, A.FrostStrike) or Player:PrevGCD(1, A.HowlingBlast) or Player:PrevGCD(1, A.GlacialAdvance)))) and MultiUnits:GetByRangeInCombat(8, 5, 10) >= 2) then
                return A.Frostscythe:Show(icon)
            end
            
            -- obliterate,target_if=(debuff.razorice.stack<5|debuff.razorice.remains<10)&buff.killing_machine.react|(buff.killing_machine.up&(prev_gcd.1.frost_strike|prev_gcd.1.howling_blast|prev_gcd.1.glacial_advance))
            if A.Obliterate:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.Obliterate, 10, "min", EvaluateCycleObliterate761) then
                    return A.Obliterate:Show(icon) 
                end
            end
            -- obliterate,if=buff.killing_machine.react|(buff.killing_machine.up&(prev_gcd.1.frost_strike|prev_gcd.1.howling_blast|prev_gcd.1.glacial_advance))
            if A.Obliterate:IsReady(unit) and (Unit("player"):HasBuffsStacks(A.KillingMachineBuff.ID, true) or (Unit("player"):HasBuffs(A.KillingMachineBuff.ID, true) and (Player:PrevGCD(1, A.FrostStrike) or Player:PrevGCD(1, A.HowlingBlast) or Player:PrevGCD(1, A.GlacialAdvance)))) then
                return A.Obliterate:Show(icon)
            end
            
            -- glacial_advance,if=(!buff.rime.up|runic_power.deficit<10|rune.time_to_2>gcd)&spell_targets.glacial_advance>=2
            if A.GlacialAdvance:IsReady(unit) and ((not Unit("player"):HasBuffs(A.RimeBuff.ID, true) or Player:RunicPowerDeficit() < 10 or Player:RuneTimeToX(2) > GetGCD()) and MultiUnits:GetByRangeInCombat(30, 5, 10) >= 2) then
                return A.GlacialAdvance:Show(icon)
            end
            
            -- howling_blast,if=buff.rime.up&spell_targets.howling_blast>=2
            if A.HowlingBlast:IsReady(unit) and (Unit("player"):HasBuffs(A.RimeBuff.ID, true) and MultiUnits:GetByRangeInCombat(30, 5, 10) >= 2) then
                return A.HowlingBlast:Show(icon)
            end
            
            -- frost_strike,target_if=(debuff.razorice.stack<5|debuff.razorice.remains<10)&!buff.rime.up|runic_power.deficit<10|rune.time_to_2>gcd&!talent.frostscythe.enabled
            if A.FrostStrike:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.FrostStrike, 10, "min", EvaluateCycleFrostStrike802) then
                    return A.FrostStrike:Show(icon) 
                end
            end
            -- frost_strike,if=!buff.rime.up|runic_power.deficit<10|rune.time_to_2>gcd
            if A.FrostStrike:IsReady(unit) and (not Unit("player"):HasBuffs(A.RimeBuff.ID, true) or Player:RunicPowerDeficit() < 10 or Player:RuneTimeToX(2) > GetGCD()) then
                return A.FrostStrike:Show(icon)
            end
            
            -- howling_blast,if=buff.rime.up
            if A.HowlingBlast:IsReady(unit) and (Unit("player"):HasBuffs(A.RimeBuff.ID, true)) then
                return A.HowlingBlast:Show(icon)
            end
            
            -- obliterate,target_if=(debuff.razorice.stack<5|debuff.razorice.remains<10)&!talent.frostscythe.enabled
            if A.Obliterate:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.Obliterate, 10, "min", EvaluateCycleObliterate825) then
                    return A.Obliterate:Show(icon) 
                end
            end
            -- obliterate
            if A.Obliterate:IsReady(unit) then
                return A.Obliterate:Show(icon)
            end
            
        end
        
        --Standard
        local function Standard(unit)
        
            -- remorseless_winter
            if A.RemorselessWinter:IsReady(unit) then
                return A.RemorselessWinter:Show(icon)
            end
            
            -- frost_strike,if=cooldown.remorseless_winter.remains<=2*gcd&talent.gathering_storm.enabled
            if A.FrostStrike:IsReady(unit) and (A.RemorselessWinter:GetCooldown() <= 2 * GetGCD() and A.GatheringStorm:IsSpellLearned()) then
                return A.FrostStrike:Show(icon)
            end
            
            -- howling_blast,if=buff.rime.up
            if A.HowlingBlast:IsReady(unit) and (Unit("player"):HasBuffs(A.RimeBuff.ID, true)) then
                return A.HowlingBlast:Show(icon)
            end
            
            -- obliterate,if=talent.icecap.enabled&buff.pillar_of_frost.up&azerite.icy_citadel.rank>=2
            if A.Obliterate:IsReady(unit) and (A.Icecap:IsSpellLearned() and Unit("player"):HasBuffs(A.PillarofFrostBuff.ID, true) and A.IcyCitadel:GetAzeriteRank() >= 2) then
                return A.Obliterate:Show(icon)
            end
            
            -- obliterate,if=!buff.frozen_pulse.up&talent.frozen_pulse.enabled
            if A.Obliterate:IsReady(unit) and (not Unit("player"):HasBuffs(A.FrozenPulseBuff.ID, true) and A.FrozenPulse:IsSpellLearned()) then
                return A.Obliterate:Show(icon)
            end
            
            -- frost_strike,if=runic_power.deficit<(15+talent.runic_attenuation.enabled*3)
            if A.FrostStrike:IsReady(unit) and (Player:RunicPowerDeficit() < (15 + num(A.RunicAttenuation:IsSpellLearned()) * 3)) then
                return A.FrostStrike:Show(icon)
            end
            
            -- frostscythe,if=buff.killing_machine.up&rune.time_to_4>=gcd
            if A.Frostscythe:IsReady(unit) and (Unit("player"):HasBuffs(A.KillingMachineBuff.ID, true) and Player:RuneTimeToX(4) >= GetGCD()) then
                return A.Frostscythe:Show(icon)
            end
            
            -- obliterate,if=runic_power.deficit>(25+talent.runic_attenuation.enabled*3)
            if A.Obliterate:IsReady(unit) and (Player:RunicPowerDeficit() > (25 + num(A.RunicAttenuation:IsSpellLearned()) * 3)) then
                return A.Obliterate:Show(icon)
            end
            
            -- frost_strike
            if A.FrostStrike:IsReady(unit) then
                return A.FrostStrike:Show(icon)
            end
            
            -- horn_of_winter
            if A.HornofWinter:IsReady(unit) then
                return A.HornofWinter:Show(icon)
            end
            
            -- arcane_torrent
            if A.ArcaneTorrent:AutoRacial(unit) and Racial and A.BurstIsON(unit) then
                return A.ArcaneTorrent:Show(icon)
            end
            
        end
        
        
        -- call precombat
        if Precombat(unit) and not inCombat and Unit(unit):IsExists() and unit ~= "mouseover" then 
            return true
        end

        -- In Combat
        if inCombat and Unit(unit):IsExists() then

                    -- auto_attack
            -- howling_blast,if=!dot.frost_fever.ticking&(!talent.breath_of_sindragosa.enabled|cooldown.breath_of_sindragosa.remains>15)
            if A.HowlingBlast:IsReady(unit) and (not Unit(unit):HasDeBuffs(A.FrostFeverDebuff.ID, true) and (not A.BreathofSindragosa:IsSpellLearned() or A.BreathofSindragosa:GetCooldown() > 15)) then
                return A.HowlingBlast:Show(icon)
            end
            
            -- glacial_advance,if=buff.icy_talons.remains<=gcd&buff.icy_talons.up&spell_targets.glacial_advance>=2&(!talent.breath_of_sindragosa.enabled|cooldown.breath_of_sindragosa.remains>15)
            if A.GlacialAdvance:IsReady(unit) and (Unit("player"):HasBuffs(A.IcyTalonsBuff.ID, true) <= GetGCD() and Unit("player"):HasBuffs(A.IcyTalonsBuff.ID, true) and MultiUnits:GetByRangeInCombat(30, 5, 10) >= 2 and (not A.BreathofSindragosa:IsSpellLearned() or A.BreathofSindragosa:GetCooldown() > 15)) then
                return A.GlacialAdvance:Show(icon)
            end
            
            -- frost_strike,if=buff.icy_talons.remains<=gcd&buff.icy_talons.up&(!talent.breath_of_sindragosa.enabled|cooldown.breath_of_sindragosa.remains>15)
            if A.FrostStrike:IsReady(unit) and (Unit("player"):HasBuffs(A.IcyTalonsBuff.ID, true) <= GetGCD() and Unit("player"):HasBuffs(A.IcyTalonsBuff.ID, true) and (not A.BreathofSindragosa:IsSpellLearned() or A.BreathofSindragosa:GetCooldown() > 15)) then
                return A.FrostStrike:Show(icon)
            end
            
            -- call_action_list,name=essences
            if Essences(unit) then
                return true
            end
            
            -- call_action_list,name=cooldowns
            if Cooldowns(unit) then
                return true
            end
            
            -- run_action_list,name=bos_ticking,if=buff.breath_of_sindragosa.up
            if (Unit("player"):HasBuffs(A.BreathofSindragosaBuff.ID, true)) then
                return BosTicking(unit);
            end
            
            -- run_action_list,name=bos_pooling,if=talent.breath_of_sindragosa.enabled&((cooldown.breath_of_sindragosa.remains=0&cooldown.pillar_of_frost.remains<10)|(cooldown.breath_of_sindragosa.remains<20&target.1.time_to_die<35))
            if (A.BreathofSindragosa:IsSpellLearned() and ((A.BreathofSindragosa:GetCooldown() == 0 and A.PillarofFrost:GetCooldown() < 10) or (A.BreathofSindragosa:GetCooldown() < 20 and target.1.time_to_die < 35))) then
                return BosPooling(unit);
            end
            
            -- run_action_list,name=obliteration,if=buff.pillar_of_frost.up&talent.obliteration.enabled
            if (Unit("player"):HasBuffs(A.PillarofFrostBuff.ID, true) and A.Obliteration:IsSpellLearned()) then
                return Obliteration(unit);
            end
            
            -- run_action_list,name=aoe,if=active_enemies>=2
            if (MultiUnits:GetByRangeInCombat(10, 5, 10) >= 2) then
                return Aoe(unit);
            end
            
            -- call_action_list,name=standard
            if Standard(unit) then
                return true
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
end 
local function ArenaRotation(icon, unit)
    if A.IsInPvP and (A.Zone == "pvp" or A.Zone == "arena") and not Player:IsStealthed() and not Player:IsMounted() then
        -- Note: "arena1" is just identification of meta 6
        if (unit == "arena1" or unit == "arena2" or unit == "arena3") then 
            -- Reflect Casting BreakAble CC
            if A.NetherWard:IsReady() and A.NetherWard:IsSpellLearned() and Action.ShouldReflect(EnemyTeam()) and EnemyTeam():IsCastingBreakAble(0.25) then 
                return A.NetherWard:Show(icon)
            end 
        end
    end 
end 
local function PartyRotation(unit)
    if (unit == "party1" and not A.GetToggle(2, "PartyUnits")[1]) or (unit == "party2" and not A.GetToggle(2, "PartyUnits")[2]) then 
        return false 
    end

  	-- SingeMagic
    if A.SingeMagic:IsCastable() and A.SingeMagic:AbsentImun(unit, Temp.TotalAndMag) and IsSchoolFree() and Action.AuraIsValid(unit, "UseDispel", "Magic") and not Unit(unit):InLOS() then
        return A.SingeMagic:Show(icon)
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
end]]--

