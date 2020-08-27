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
local IsIndoors, UnitIsUnit                     = IsIndoors, UnitIsUnit
local TR                                        = Action.TasteRotation
local Pet                                       = LibStub("PetLibrary")
local wipe                                   = wipe 
local math_floor                             = math.floor
local math_ceil                              = math.ceil
local tinsert                                = table.insert 
local TMW                                    = TMW
local TR                                     = Action.TasteRotation
local _G, setmetatable							= _G, setmetatable
local select, unpack, table, pairs = select, unpack, table, pairs 
local CombatLogGetCurrentEventInfo			 = _G.CombatLogGetCurrentEventInfo
local UnitGUID, UnitIsUnit, UnitDamage, UnitAttackSpeed, UnitAttackPower = UnitGUID, UnitIsUnit, UnitDamage, UnitAttackSpeed, UnitAttackPower

--- ============================ CONTENT ===========================
--- ======= APL LOCALS =======
-- luacheck: max_line_length 9999

-- Spells
Action[ACTION_CONST_WARLOCK_DEMONOLOGY] = {
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
    GiftofNaaru                            = Action.Create({ Type = "Spell", ID = 59544    }),
    Shadowmeld                             = Action.Create({ Type = "Spell", ID = 58984    }), -- usable in Action Core 
    Stoneform                              = Action.Create({ Type = "Spell", ID = 20594    }), 
    BagofTricks                            = Action.Create({ Type = "Spell", ID = 312411    }),
    WilloftheForsaken                      = Action.Create({ Type = "Spell", ID = 7744        }), -- not usable in APL but user can Queue it   
    EscapeArtist                           = Action.Create({ Type = "Spell", ID = 20589    }), -- not usable in APL but user can Queue it
    EveryManforHimself                     = Action.Create({ Type = "Spell", ID = 59752    }), -- not usable in APL but user can Queue it
    -- Generics
    SummonPet                              = Action.Create({ Type = "Spell", ID = 30146 }),
    InnerDemons                            = Action.Create({ Type = "Spell", ID = 267216 }),
    Demonbolt                              = Action.Create({ Type = "Spell", ID = 264178 }),
    SoulStrike                             = Action.Create({ Type = "Spell", ID = 264057 }),
    DemonicConsumption                     = Action.Create({ Type = "Spell", ID = 267215 }),
    HandofGuldan                           = Action.Create({ Type = "Spell", ID = 105174 }),
    ShadowBolt                             = Action.Create({ Type = "Spell", ID = 686 }),
    Implosion                              = Action.Create({ Type = "Spell", ID = 196277 }),
    CallDreadstalkers                      = Action.Create({ Type = "Spell", ID = 104316 }),
    BilescourgeBombers                     = Action.Create({ Type = "Spell", ID = 267211 }),
    DemonicPowerBuff                       = Action.Create({ Type = "Spell", ID = 265273 , Hidden = true     }),
    DemonicCalling                         = Action.Create({ Type = "Spell", ID = 205145 }),
    GrimoireFelguard                       = Action.Create({ Type = "Spell", ID = 111898 }),
	GrimoireFelguardTexture                = Action.Create({ Type = "Spell", ID = 108503 }), -- Hacky spellID to avoid icon conflict with summon felguard
    SummonDemonicTyrant                    = Action.Create({ Type = "Spell", ID = 265187 }),
    DemonicCallingBuff                     = Action.Create({ Type = "Spell", ID = 205146 , Hidden = true     }),
    DemonicCoreBuff                        = Action.Create({ Type = "Spell", ID = 264173 }),
    SummonVilefiend                        = Action.Create({ Type = "Spell", ID = 264119 }),
    Doom                                   = Action.Create({ Type = "Spell", ID = 265412 }),
    DoomDebuff                             = Action.Create({ Type = "Spell", ID = 265412 }),
    NetherPortal                           = Action.Create({ Type = "Spell", ID = 267217 }),
    NetherPortalBuff                       = Action.Create({ Type = "Spell", ID = 267218 , Hidden = true     }),
    PowerSiphon                            = Action.Create({ Type = "Spell", ID = 264130 }),
    ExplosivePotential                     = Action.Create({ Type = "Spell", ID = 275395 }),
    ExplosivePotentialBuff                 = Action.Create({ Type = "Spell", ID = 275398 , Hidden = true     }),
    DemonicStrength                        = Action.Create({ Type = "Spell", ID = 267171 }),
    Berserking                             = Action.Create({ Type = "Spell", ID = 26297 }),
    BloodFury                              = Action.Create({ Type = "Spell", ID = 20572 }),
    Fireblood                              = Action.Create({ Type = "Spell", ID = 265221 }),
    BloodoftheEnemyBuff                    = Action.Create({ Type = "Spell", ID = 297108 , Hidden = true     }),
    LifebloodBuff                          = Action.Create({ Type = "Spell", ID = 295078 , Hidden = true     }),
    BalefulInvocation                      = Action.Create({ Type = "Spell", ID = 287059 }),
    ShadowsBite                            = Action.Create({ Type = "Spell", ID = 272944 }),
    ShadowsBiteBuff                        = Action.Create({ Type = "Spell", ID = 272945 , Hidden = true     }),
	-- Utilities
    SpellLock                              = Action.Create({ Type = "Spell", ID = 19647}),
    PetKick                                = Action.Create({ Type = "SpellSingleColor", ID = 119914, Color = "RED", Desc = "RED Pet Stun" }), 
	Shadowfury                             = Action.Create({ Type = "Spell", ID = 30283      }),
	MortalCoil                             = Action.Create({ Type = "Spell", ID = 6789     }),
    FearGreen                              = Action.Create({ Type = "SpellSingleColor", ID = 5782, Color = "GREEN", Desc = "[2] Kick", QueueForbidden = true , Hidden = true     }),	
    Fear                                   = Action.Create({ Type = "Spell", ID = 5782       }),
	NetherWard                             = Action.Create({ Type = "Spell", ID = 212295     }), -- Spell Reflect
    -- Defensive
    UnendingResolve                        = Action.Create({ Type = "Spell", ID = 104773     }),
	-- Felguard
    Felstorm                               = Action.Create({ Type = "Spell", ID = 89751 }),
    LegionStrike                           = Action.Create({ Type = "Spell", ID = 30213 }),
    Pursuit                                = Action.Create({ Type = "Spell", ID = 30151}),
    AxeToss                                = Action.Create({ Type = "Spell", ID = 89766}),	
    ThreateningPresence                    = Action.Create({ Type = "Spell", ID = 134477}),
    -- Misc
    BurningRush                            = Action.Create({ Type = "Spell", ID = 278727     }),
    Channeling                             = Action.Create({ Type = "Spell", ID = 209274, Hidden = true     }),
    -- Trinkets
    TrinketTest                            = Action.Create({ Type = "Trinket", ID = 122530, QueueForbidden = true , Hidden = true     }),
    TrinketTest2                           = Action.Create({ Type = "Trinket", ID = 159611, QueueForbidden = true , Hidden = true     }),
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
    RecklessForceBuff                      = Action.Create({ Type = "Spell", ID = 302932, Hidden = true     }),	 
	VisionofPerfection                     = Action.Create({ Type = "Spell", ID = 299368, Hidden = true     }),	
	DummyTest                              = Action.Create({ Type = "Spell", ID = 159999, Hidden = true     }), -- Dummy stop dps icon
};

-- To create essences use next code:
Action:CreateEssencesFor(ACTION_CONST_WARLOCK_DEMONOLOGY)  -- where PLAYERSPEC is Constance (example: ACTION_CONST_MONK_BM)
local A = setmetatable(Action[ACTION_CONST_WARLOCK_DEMONOLOGY], { __index = Action })

local player = "player"

-- API - Spell
Pet:Add(266, { -- Felguard
	-- number accepted
	89751, -- Felstorm
	30213, -- Legion Strike

	-- strings also accepted!
	--"Gnaw",
	--GetSpellInfo(47481),
})

-- API - Tracker
-- Initialize Tracker 
Pet:InitializeTrackerFor(ACTION_CONST_WARLOCK_DEMONOLOGY, { -- this template table is the same with what has this library already built-in, just for example
	[98035] = {
		name = "Dreadstalker",
		duration = 12.25,
	},
	[55659] = {
		name = "Wild Imp",
		duration = 20,
	},
	--[143622] = {
	--	name = "Wild Imp",
	--	duration = 12,
	--},
	[17252] = {
		name = "Felguard",
		duration = 28,
	},
	[135002] = {
		name = "Demonic Tyrant",
		duration = 15,
	},
    [135816] = {
        name = "Vilefiend",
        duration = 15,
    },
})

local PetTrackerGUID = Pet:GetTrackerGUID()
local PetTrackerData = Pet:GetTrackerData() -- this is table with [petID] = @table 


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

local IsIndoors, UnitIsUnit = IsIndoors, UnitIsUnit

local function IsSchoolFree()
	return LoC:IsMissed("SILENCE") and LoC:Get("SCHOOL_INTERRUPT", "SHADOW") == 0
end 

------------------------------------------
------------ DEMONOLOGY PREAPL -----------
------------------------------------------

-- Calculate future shard count
local function FutureShard()
    local Shard = Player:SoulShards()
    local castName, castStartTime, castEndTime, notInterruptable, spellID, isChannel = Unit(player):IsCasting()
    
	if not Unit(player):IsCasting() then
        return Shard
    else
        if spellID == A.NetherPortal.ID then
            return Shard - 1
        elseif spellID == A.CallDreadstalkers.ID and Unit(player):HasBuffs(A.DemonicCallingBuff.ID, true) == 0 then
            return Shard - 2
        elseif spellID == A.BilescourgeBombers.ID then
            return Shard - 2
        elseif spellID == A.SummonVilefiend.ID then
            return Shard - 1
        elseif spellID == A.GrimoireFelguard.ID then
            return Shard - 1
        elseif spellID == A.CallDreadstalkers.ID and Unit(player):HasBuffs(A.DemonicCallingBuff.ID, true) > 0 then
            return Shard - 1
        elseif spellID == A.SummonDemonicTyrant.ID and A.BalefulInvocation:GetAzeriteRank() > 0 then
            return 5
        elseif spellID == A.HandofGuldan.ID then
            if Shard > 3 then
                return Shard - 3
            else
                return 0
            end
        elseif spellID == A.Demonbolt.ID then
            if Shard >= 4 then
                return 5
            else
                return Shard + 2
            end
        elseif spellID == A.ShadowBolt.ID then
            if Shard == 5 then
                return Shard
            else
                return Shard + 1
            end
        elseif spellID == A.SoulStrike.ID then
            if Shard == 5 then
                return Shard
            else
                return Shard + 1
            end
        else
            return Shard
        end
    end
end

---------------------------
----- PETS MANAGEMENT -----
---------------------------
-- Example of use:
--[[
/dump LibStub("PetLibrary"):GetRemainDuration(135002)
/dump LibStub("PetLibrary"):IsActive(135002)
/dump LibStub("PetLibrary"):GetMainPet()
-- Callbacks 
local PetTrackerData = Pet:GetTrackerData() -- this is table with [petID] = @table 
TMW:RegisterCallback("TMW_ACTION_PET_LIBRARY_REMOVED", function(callbackEvent, PetID, PetGUID)
	print("Removed " .. PetID .. ", GUID: " .. PetGUID)
end)
TMW:RegisterCallback("TMW_ACTION_PET_LIBRARY_ADDED", function(callbackEvent, PetID, PetGUID, PetData)
	-- PetData is a @table with next keys: name, duration, count, GUIDs 
	print("Added " .. PetID .. ", his name is " .. PetData.name .. ", GUID: " .. PetGUID)
	-- If we want to modify data we can 
	PetTrackerData.myVar = "custom data"
	print(PetTrackerData.myVar)
end)
]]--


-- Function to check for imp count
--local function WildImpsCount()
--    return Pet:GetCount(55659) or 0
--end

-- Function to check for remaining Dreadstalker duration
local function DreadStalkersTime()
    return Pet:GetRemainDuration(98035) or 0
end

-- Function to check for remaining Grimoire Felguard duration
local function GrimoireFelguardTime()
    return Pet:GetRemainDuration(17252) or 0
end

-- Function to check for Demonic Tyrant duration
local function DemonicTyrantTime()
    return Pet:GetRemainDuration(135002) or 0
end  

-- Function to check for Vilefiend duration
local function VilefiendTime()
    return Pet:GetRemainDuration(135816) or 0
end        

-- Check for Real Tyran summoned since VoP randomly summon a Tyran for 35% of its base duration
local function RealTyrantIsActive()
    return DemonicTyrantTime() > 5.25 and true or false
end

-- Function to check for Demonic Tyrant duration
local function DemonicTyrantIsActive()
    return DemonicTyrantTime() > 0 and true or false
end 


-- Hack to record timestamp of passive imp spawn 
local function LastPassiveImpTimeStamp()
    -- Since imp is active for 20sec, track every special npcid for Inner Demons imps with duration at 19.9 to get timestamp record
    return Pet:GetRemainDuration(143622) > 19.8 and TMW.time or 0
end

-- Imps spawn every 12sec with talent Inner Demons
-- Use our previous timestamp to predict next passive Imp spawn timestamp
local function NextPassiveImpSpawn()
    return (LastPassiveImpTimeStamp() + 12) or 0 
end

local function GetGUID(unitID)
	return UnitGUID(unitID)
end 

-----------------------------------
------- CUSTOM IMP TRACKER --------
-----------------------------------

-- Protect errors
TMW:RegisterCallback("TMW_ACTION_IS_INITIALIZED", function()
    Action.TimerSet("DISABLE_PET_ERRORS", 99999, function() Pet:DisableErrors(true)  end)
end)

--TMW:RegisterCallback("TMW_ACTION_PET_LIBRARY_ADDED", function(callbackEvent, PetID, PetGUID, PetData)
	-- PetData is a @table with next keys: name, duration, count, GUIDs 
    -- Add 5 cast to PetData table for each summoned Imp
	--PetData.impcasts = 5
	--PetData.petenergy = 100
	--PetTrackerData[55659].impcasts = 5
	-- Also add 5 to local TR.GuardianTable
	--TR.GuardiansTable.ImpCastsRemaing = 5
	--if PetID == 55659 then
	   -- PetTrackerData[PetTrackerGUID[PetGUID]].GUIDs[PetGUID].impcasts = 5
		--PetTrackerData[PetTrackerGUID[PetGUID]].GUIDs[PetGUID].petenergy = 100
	    --PetTrackerData[PetID].GUIDs[PetGUID].impcasts = 5
	    --PetTrackerData[PetID].GUIDs[PetGUID].petenergy = 100
	--end
	--print("Added " .. PetID .. ", his name is " .. PetData.name .. ", GUID: " .. PetGUID .. "and he got " .. PetData.impcasts .. " casts lefts")

--end)

TMW:RegisterCallback("TMW_ACTION_PET_LIBRARY_REMOVED", function(callbackEvent, PetID, PetGUID)
	--PetTrackerGUID[PetGUID].impcasts = 0
	--PetTrackerGUID[PetGUID].petenergy = 0
	--print("Removed " .. PetID .. ", GUID: " .. PetGUID)
end)

TMW:RegisterCallback("TMW_ACTION_PET_LIBRARY_ADDED", function(callbackEvent, PetID, PetGUID, PetData)
	-- PetData is a @table with next keys: name, duration, count, GUIDs 
	if PetID == 55659 then
	    PetData.GUIDs[PetGUID].impcasts = 5
	    PetData.GUIDs[PetGUID].petenergy = 100
	    --print("Added " .. PetID .. ", his name is " .. PetData.name .. ", he got " .. PetData.GUIDs[PetGUID].impcasts .. " cast lefts and got " .. PetData.GUIDs[PetGUID].petenergy .. " energy. GUID: " .. PetGUID)
	    -- If we want to modify data we can 
	    --PetTrackerData.myVar = "custom data"
	    --print(PetTrackerData.myVar)
	end
end)
--/dump LibStub("PetLibrary"):GetTrackerData().[55659].GUIDs
-------------------------------------------------------------------------------
-- Remap
-------------------------------------------------------------------------------
local A_Unit, A_GetSpellInfo, A_GetSpellLink, ActiveNameplates
local TeamCacheFriendly, TeamCacheFriendlyUNITs

-------------------------------------------------------------------------------
local A_Unit						= A.Unit
local A_GetSpellInfo				= A.GetSpellInfo
local A_GetSpellLink				= A.GetSpellLink
local ActiveNameplates				= A.MultiUnits:GetActiveUnitPlates()
local TeamCacheFriendly				= TeamCache.Friendly
local TeamCacheFriendlyUNITs		= TeamCacheFriendly.UNITs

local PetOnEventCLEU					= {
		["UNIT_DIED"] 		= "Remove",
		["UNIT_DESTROYED"] 	= "Remove",
		["UNIT_DISSIPATES"] = "Remove",		
		["PARTY_KILL"] 		= "Remove",
		["SPELL_INSTAKILL"] = "Remove",
		["SPELL_SUMMON"] 	= "Add",
}
		
TR.ImpData = {
    ImpCastsRemaing = 0,
	ImpCount = 0,
	ImpTotalEnergy = 0,
}

local function GetGUID(unitID)
	return (unitID and TeamCacheFriendlyUNITs[unitID]) or UnitGUID(unitID)
end 
	  
local function ConvertGUIDtoNPCID(GUID)
	if A_Unit then 
		local _, _, _, _, _, npc_id = A_Unit(""):InfoGUID(GUID) -- A_Unit("") because no unitID 
		return npc_id
	else
		local _, _, _, _, _, _, _, NPCID = strfind(GUID, "(%S+)-(%d+)-(%d+)-(%d+)-(%d+)-(%d+)-(%S+)")
		return NPCID and tonumber(NPCID)
	end 
end 

local function AddWildImpToTracker(PetID, PetGUID, PetName)
	--local PetID = 55659
	
	if not PetTrackerData[PetID] then 
		PetTrackerData[PetID] = { count = 0, GUIDs = {} }
	end 
	
	PetTrackerData[PetID].name 				= "Wild Imp"
	PetTrackerData[PetID].duration 			= 20
	PetTrackerData[PetID].count				= PetTrackerData[PetID].count + 1
	PetTrackerData[PetID].GUIDs[PetGUID]	= { 
		updated			= TMW.time, 
		start 			= TMW.time, 
		expiration		= TMW.time + PetTrackerData[PetID].duration,
		impcasts        = 5,
		petenergy       = 100,
	}
	
	PetTrackerGUID[PetGUID]					= PetID
	
	TMW:Fire("TMW_ACTION_PET_LIBRARY_ADDED", PetID, PetGUID, PetTrackerData[PetID])
end 

TR.COMBAT_LOG_EVENT_UNFILTERED			= function(...)
	 	
		local _, Event, _, SourceGUID, _, SourceFlags, _, DestGUID, DestName, DestFlags,_, SpellID, SpellName = CombatLogGetCurrentEventInfo()
		--local PetID = 55659


		if SourceGUID and SourceGUID ~= Pet.MainGUID and PetTrackerData[55659] and PetTrackerData[55659].GUIDs[SourceGUID] then 
			PetTrackerData[55659].GUIDs[SourceGUID].updated = TMW.time 
		end 

        -- Decrement impcasts and petenergy
	    if PetTrackerData and PetTrackerData[55659] and PetTrackerGUID[SourceGUID] and SourceGUID and SourceGUID ~= Pet.MainGUID and (Event == "SPELL_CAST_SUCCESS") and SpellID == 104318 then
            --PetTrackerData[PetTrackerGUID[SourceGUID]].GUIDs[SourceGUID].impcasts = PetTrackerData[PetTrackerGUID[SourceGUID]].GUIDs[SourceGUID].impcasts - 1
			PetTrackerData[55659].GUIDs[SourceGUID].impcasts = PetTrackerData[55659].GUIDs[SourceGUID].impcasts - 1 
			--PetTrackerData[PetTrackerGUID[SourceGUID]].GUIDs[SourceGUID].petenergy = PetTrackerData[PetTrackerGUID[SourceGUID]].GUIDs[SourceGUID].petenergy - 20
			PetTrackerData[55659].GUIDs[SourceGUID].petenergy = PetTrackerData[55659].GUIDs[SourceGUID].petenergy - 20

		end

	    -- Add Implosion and Demonic Consumption listener
		if  (Event == "SPELL_CAST_SUCCESS") and SourceGUID == GetGUID("player") and PetTrackerData[55659] and  --and SourceGUID  and
	        (   -- Implosion
	            SpellID == 196277 or SpellName == A.Implosion:Info()
	           	or 
	       	    -- Summon Demonic Tyrant with Demonic Consumption
	       	    (SpellID == 265187 and A.DemonicConsumption:IsSpellLearned())
	        ) 
	    then 
	        local PetID = 55659
	        for GUID in pairs(PetTrackerData[PetID].GUIDs) do 
  	            PetTrackerGUID[GUID] = nil 
	        end
	        wipe(PetTrackerData[PetID].GUIDs)
	        if not PetTrackerData[PetID].isMain and PetTrackerData[PetID].count > 1 then 
  	            PetTrackerData[PetID].count = 0  
	        else  
 	            PetTrackerData[PetID] = nil 
	        end 
		end	
	
end
Listener:Add("ACTION_TASTE_IMP_TRACKER", "COMBAT_LOG_EVENT_UNFILTERED", TR.COMBAT_LOG_EVENT_UNFILTERED)

local function GetImpsData(petID, petName)
	-- @return number 
	-- Note: Only if template has "duration" key otherwise it's huge 
	local TotalImpEnergy = 0
	local TotalImpCast = 0
	local TotalImpCount = 0
	
	-- Note: Number of active pets
	if petName then 
		for _, v in pairs(PetTrackerData) do
			if v.name == petName and v.count > 0 then 
				TotalImpCount = v.count
			end 			 
		end
	end 
	
	-- Note: Imp energy value + remaining casts
	if petID and PetTrackerData[petID] then 
		for _, data in pairs(PetTrackerData[petID].GUIDs) do 
			local petenergy = data.petenergy
			local impcasts = data.impcasts
			local impcount = PetTrackerData[petID].count
			
			if PetTrackerData[petID].count > 1 then
			    TotalImpCount = impcount
			end
			
			if impcasts > 0 then 
                TotalImpCast = TotalImpCast + impcasts
			else
			    TotalImpCast = 0
				TotalImpCount = 0
				TotalImpEnergy = 0
			end 
			
			if petenergy > 0 then 
                TotalImpEnergy = TotalImpEnergy + petenergy
			else
			    TotalImpCast = 0
				TotalImpCount = 0
				TotalImpEnergy = 0
			end 			
		end 
	end 
	
	return TotalImpCount, TotalImpEnergy, TotalImpCast  
end 
	
-- On Successful HoG cast add how many Imps will spawn
local ImpsSpawnedFromHoG = 0 
local _, event, _, sourceGUID, _, _, _, destGUID, destName, _, _, spellID, spellName = CombatLogGetCurrentEventInfo()	
if (event == "SPELL_CAST_SUCCESS") and sourceGUID == UnitGUID(player) and spellID == 105174 then
    ImpsSpawnedFromHoG = ImpsSpawnedFromHoG + (Player:SoulShardsP() >= 3 and 3 or Player:SoulShardsP())
    Env.LastPlayerCastID 	= spellID
	A.LastPlayerCastName	= spellName
	A.LastPlayerCastID		= spellID
    TMW:Fire("TMW_CNDT_LASTCAST_UPDATED")
end

-- Give imp count prediction with HoG cast
local function ImpsSpawnedDuring(miliseconds)
    local ImpSpawned = 0
    -- Used for Wild Imps spawn prediction
    local InnerDemonsNextCast = 0
    local ImpCastsRemaing = 0
    local SpellCastTime = ( miliseconds / 1000 ) * Player:SpellHaste()
    local castName, castStartTime, castEndTime, notInterruptable, spellID, isChannel = Unit(player):IsCasting()
	
    if TMW.time <= NextPassiveImpSpawn() and (TMW.time + SpellCastTime) >= NextPassiveImpSpawn() then
        ImpSpawned = ImpSpawned + 1
    end

    if castName == A.HandofGuldan:Info() then
        ImpSpawned = ImpSpawned + (Player:SoulShards() >= 3 and 3 or Player:SoulShards())
    end

    ImpSpawned = ImpSpawned + ImpsSpawnedFromHoG

    return ImpSpawned
end
ImpsSpawnedDuring = A.MakeFunctionCachedDynamic(ImpsSpawnedDuring)

-- SummonDemonicTyrant checker
local function MegaTyrant()
    local castName, castStartTime, castEndTime, notInterruptable, spellID, isChannel = Unit(player):IsCasting()
	local WildImpCount, WildImpTotalEnergy, WildImpTotalCastsRemains = GetImpsData(55659, "Wild Imp")
    return (WildImpCount + ImpsSpawnedDuring(2000) >= 6 and A.LastPlayerCastName == A.HandofGuldan:Info() and castName == A.HandofGuldan:Info() and true) or false
end

local function SelfDefensives()
    if Unit(player):CombatTime() == 0 then 
        return 
    end 
    
    local unit
    if A.IsUnitEnemy("mouseover") then 
        unit = "mouseover"
    elseif A.IsUnitEnemy("target") then 
        unit = "target"
    end  
		
    -- UnendingResolve
    local UnendingResolve = A.GetToggle(2, "UnendingResolve")
    if     UnendingResolve >= 0 and A.UnendingResolve:IsReady(player) and 
    (
        (     -- Auto 
            UnendingResolve >= 100 and 
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
            UnendingResolve < 100 and 
            Unit(player):HealthPercent() <= UnendingResolve
        )
    ) 
    then 
        return A.UnendingResolve
    end     
    -- Stoneform on self dispel (only PvE)
    if A.Stoneform:IsRacialReady(player, true) and not A.IsInPvP and A.AuraIsValid(player, "UseDispel", "Dispel") then 
        return A.Stoneform
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
SelfDefensives = A.MakeFunctionCachedStatic(SelfDefensives)

-- TO USE AFTER NEXT ACTION UPDATE
local function InterruptsNEW(unit)
    local useKick, useCC, useRacial, notInterruptable, castRemainsTime, castDoneTime = Action.InterruptIsValid(unit, nil, nil, not A.PetKick:IsReady(unit)) -- A.Kick non GCD spell
    
	if castRemainsTime < A.GetLatency() then
        if useKick and A.PetKick:IsReady(unit) and A.PetKick:AbsentImun(unit, Temp.TotalAndMagKick, true) and Unit(unit):IsControlAble("stun", 0) then 
            return A.PetKick
        end 
    
        if useCC and A.Shadowfury:IsReady(unit) and MultiUnits:GetActiveEnemies() >= 2 and A.Shadowfury:AbsentImun(unit, Temp.TotalAndCC, true) and Unit(unit):IsControlAble("stun", 0) then 
            return A.Shadowfury              
        end          
	
	    if useCC and A.Fear:IsReady(unit) and A.Fear:AbsentImun(unit, Temp.TotalAndCC, true) and Unit(unit):IsControlAble("disorient", 75) then 
            return A.Fear              
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

local function Interrupts(unit)
    local useKick, useCC, useRacial = A.InterruptIsValid(unit, "TargetMouseover")    
    
    if useKick and A.PetKick:IsReady(unit) and A.PetKick:AbsentImun(unit, Temp.TotalAndMagKick, true) and Unit(unit):IsControlAble("stun", 0) and Unit(unit):CanInterrupt(true, nil, 25, 70) then 
        return A.PetKick
    end 
    
    if useCC and A.Shadowfury:IsReady(unit) and MultiUnits:GetActiveEnemies() >= 2 and A.Shadowfury:AbsentImun(unit, Temp.TotalAndCC, true) and Unit(unit):IsControlAble("stun", 0) then 
        return A.Shadowfury              
    end          
	
	if useCC and A.Fear:IsReady(unit) and A.Fear:AbsentImun(unit, Temp.TotalAndCC, true) and Unit(unit):IsControlAble("disorient", 75) then 
        return A.Fear              
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

-- Multidot Handler UI w/ Doom --
local function HandleMultidots()
    local choice = Action.GetToggle(2, "AutoDotSelection")
       
    if choice == "In Raid" then
		if IsInRaid() then
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

local function EvaluateCycleDoom140(unit)
    return Unit(unit):HasDeBuffsRefreshable(A.DoomDebuff.ID, true)
end

--- ======= ACTION LISTS =======
-- [3] Single Rotation
A[3] = function(icon, isMulti)

    --------------------
    --- ROTATION VAR ---
    --------------------
    local isMoving = A.Player:IsMoving()
    local inCombat = Unit(player):CombatTime() > 0
    local ShouldStop = Action.ShouldStop()
    local Pull = Action.BossMods:GetPullTimer()
	local FutureShard = FutureShard()
    local WildImpsCount, WildImpTotalEnergy, WildImpTotalCastsRemains = GetImpsData(55659, "Wild Imp")
	local DreadStalkersTime = DreadStalkersTime()
	local GrimoireFelguardTime = GrimoireFelguardTime()
	local DemonicTyrantTime = DemonicTyrantTime()
	local VilefiendTime = VilefiendTime()
	local RealTyrantIsActive = RealTyrantIsActive()
	local DemonicTyrantIsActive = DemonicTyrantIsActive()
	local MegaTyrant = MegaTyrant()
	local PredictShards = A.GetToggle(2, "PredictShards")
	local MultiDotDistance = A.GetToggle(2, "MultiDotDistance")
	local ImplosionEnemies = A.GetToggle(2, "ImplosionEnemies")
	local ImplosionImp = A.GetToggle(2, "ImplosionImp")
	local ImplosionRange = A.GetToggle(2, "ImplosionRange")
	local ImplosionMode = A.GetToggle(2, "ImplosionMode")
	
	
	-- Multidots var
	local MissingDoom = MultiUnits:GetByRangeMissedDoTs(MultiDotDistance, 5, A.Doom.ID) 
    local AppliedDoom = MultiUnits:GetByRangeAppliedDoTs(MultiDotDistance, 5, A.Doom.ID)
    local DoomToRefresh = MultiUnits:GetByRangeDoTsToRefresh(MultiDotDistance, 5, A.Doom.ID, 6, 5)
	local profileStop = false
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
        
	-- DEBUG PRINT PETS	
	--print("WildImpsCount: " .. WildImpsCount)
	--print("Pet:GetCount(55659): " .. Pet:GetWildImpCount(55659))
	--print("Pet:GetCount(Wild Imp): " .. Pet:GetWildImpCount("Wild Imp"))
	--print("DreadStalkersTime: " .. DreadStalkersTime)
	--if WildImpsCount ~= nil then
	-- print("WildImpsCount " .. WildImpsCount)

	--end	 
	--if WildImpTotalEnergy ~= nil then
	-- print("WildImpTotalEnergy " .. WildImpTotalEnergy)
	-- print("WildImpTotalCastsRemains " .. WildImpTotalCastsRemains)
	--end	
	
		--Precombat
        local function Precombat(unit)
            -- flask
            -- food
            -- augmentation
			
            -- summon_pet
            if A.SummonPet:IsReady(unit) and not Pet:IsActive() then
                return A.SummonPet:Show(icon)
            end
            -- snapshot_stats
			
            -- potion
            if A.PotionofUnbridledFury:IsReady(unit) and Action.GetToggle(1, "Potion") then
                return A.PotionofUnbridledFury:Show(icon)
            end
			
            -- demonbolt
            if A.Demonbolt:IsReady(unit) and A.LastPlayerCastName ~= A.Demonbolt:Info() then
                return A.Demonbolt:Show(icon)
            end
        end
        Precombat = A.MakeFunctionCachedDynamic(Precombat)
		
        --BuildAShard
        local function BuildAShard(unit)
		
            -- memory_of_lucid_dreams,if=soul_shard<2
            if A.MemoryofLucidDreams:AutoHeartOfAzeroth(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") and (FutureShard < 2) then
                return A.MemoryofLucidDreams:Show(icon)
            end
			
            -- soul_strike,if=!talent.demonic_consumption.enabled|time>15|prev_gcd.1.hand_of_guldan&!buff.bloodlust.remains
            if A.SoulStrike:IsReady(unit) and (Player:SoulShardsP() <= 4 or (FutureShard <= 4 and PredictShards)) then
                return A.SoulStrike:Show(icon)
            end
			
            -- shadow_bolt
            if A.ShadowBolt:IsReady(unit) and (Player:SoulShardsP() <= 4 or (FutureShard <= 4 and PredictShards)) then
                return A.ShadowBolt:Show(icon)
            end
        end
        BuildAShard = A.MakeFunctionCachedDynamic(BuildAShard)
		
        --Implosion
        local function Implosion(unit)
		
	        -- grimoire_felguard,if=cooldown.summon_demonic_tyrant.remains<13|!equipped.132369
            if A.GrimoireFelguard:IsReady(unit) and (A.SummonDemonicTyrant:GetCooldown() < 13) then
                return A.GrimoireFelguardTexture:Show(icon)
            end
			
            -- bilescourge_bombers
            if A.BilescourgeBombers:IsReady(player) then
                return A.BilescourgeBombers:Show(icon)
            end		
			
            -- implosion,if=(buff.wild_imps.stack>=6&(soul_shard<3|prev_gcd.1.call_dreadstalkers|buff.wild_imps.stack>=9|prev_gcd.1.bilescourge_bombers|(!prev_gcd.1.hand_of_guldan&!prev_gcd.2.hand_of_guldan))&!prev_gcd.1.hand_of_guldan&!prev_gcd.2.hand_of_guldan&buff.demonic_power.down)|(time_to_die<3&buff.wild_imps.stack>0)|(prev_gcd.2.call_dreadstalkers&buff.wild_imps.stack>2&!talent.demonic_calling.enabled)
            if A.Implosion:IsReady(unit) and
			    -- Range by pet
				ImplosionMode == "RangeByPet" and 
				(
				    WildImpsCount >= ImplosionImp and Pet:GetMultiUnitsBySpell(A.Felstorm.ID) >= ImplosionEnemies										    					
				)
				or 
				-- Range by nameplate
				ImplosionMode == "RangeByNameplate" and
				(					    
				    WildImpsCount >= ImplosionImp and MultiUnits:GetByRangeInCombat(ImplosionRange) >= ImplosionEnemies
				)
				or
				-- Range by active enemies CLEU
				ImplosionMode == "RangeByCLEU" and
				(        				
					WildImpsCount >= ImplosionImp and MultiUnits:GetActiveEnemies() >= ImplosionEnemies					     
				)
			then
			    --Action.SendNotification("Using " .. A.GetSpellInfo(A.Implosion.ID) .. " AoE", A.Implosion.ID)
                return A.Implosion:Show(icon)
            end
			
            -- call_dreadstalkers,if=(cooldown.summon_demonic_tyrant.remains<9&buff.demonic_calling.remains)|(cooldown.summon_demonic_tyrant.remains<11&!buff.demonic_calling.remains)|cooldown.summon_demonic_tyrant.remains>14
            if A.CallDreadstalkers:IsReady(unit) and 
			    (
				    (A.SummonDemonicTyrant:GetCooldown() < 9 and Unit(player):HasBuffs(A.DemonicCallingBuff.ID, true) > 0) 
					or 
					(A.SummonDemonicTyrant:GetCooldown() < 11 and Unit(player):HasBuffs(A.DemonicCallingBuff.ID, true) == 0) 
					or
					A.SummonDemonicTyrant:GetCooldown() > 14
					or
					not A.BurstIsON(unit)
				)
			then
                return A.CallDreadstalkers:Show(icon)
            end
						
            -- hand_of_guldan,if=soul_shard>=5
            if A.HandofGuldan:IsReady(unit) and (Player:SoulShardsP() >= 5 or (FutureShard >= 5 and PredictShards)) then
                return A.HandofGuldan:Show(icon)
            end
			
            -- hand_of_guldan,if=soul_shard>=3&(((prev_gcd.2.hand_of_guldan|buff.wild_imps.stack>=3)&buff.wild_imps.stack<9)|cooldown.summon_demonic_tyrant.remains<=gcd*2|buff.demonic_power.remains>gcd*2)
            if A.HandofGuldan:IsReady(unit) and 
			    (
				    (Player:SoulShardsP() >= 3 or (FutureShard >= 3 and PredictShards)) and 
					(
					    ((A.LastPlayerCastName == A.HandofGuldan:Info() or WildImpsCount >= 3) and WildImpsCount < 9)
						or 
						A.SummonDemonicTyrant:GetCooldown() <= A.GetGCD() * 2 
						or 
						Unit(player):HasBuffs(A.DemonicPowerBuff.ID, true) > A.GetGCD() * 2
					)
				)
			then
                return A.HandofGuldan:Show(icon)
            end
			
            -- demonbolt,if=prev_gcd.1.hand_of_guldan&soul_shard>=1&(buff.wild_imps.stack<=3|prev_gcd.3.hand_of_guldan)&soul_shard<4&buff.demonic_core.up
            if A.Demonbolt:IsReady(unit) and 
			    (
				    A.LastPlayerCastName == A.HandofGuldan:Info() and (Player:SoulShardsP() >= 1 or (FutureShard >= 1 and PredictShards))
					and 
					(WildImpsCount <= 3 or A.LastPlayerCastName == A.HandofGuldan:Info()) 
					and 
					(Player:SoulShardsP() < 4 or (FutureShard < 4 and PredictShards)) 
					and
					Unit(player):HasBuffs(A.DemonicCoreBuff.ID, true) > 0
				)
			then
                return A.Demonbolt:Show(icon)
            end
			
            -- summon_vilefiend,if=(cooldown.summon_demonic_tyrant.remains>40&spell_targets.implosion<=2)|cooldown.summon_demonic_tyrant.remains<12
            if A.SummonVilefiend:IsReady(unit) and ((A.SummonDemonicTyrant:GetCooldown() > 40 and MultiUnits:GetActiveEnemies() <= 2) or A.SummonDemonicTyrant:GetCooldown() < 12) then
                return A.SummonVilefiend:Show(icon)
            end
			
            -- bilescourge_bombers,if=cooldown.summon_demonic_tyrant.remains>9
            if A.BilescourgeBombers:IsReady(player) and (A.SummonDemonicTyrant:GetCooldown() > 9 or not A.BurstIsON(unit)) then
                return A.BilescourgeBombers:Show(icon)
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
			
            -- focused_azerite_beam
            if A.FocusedAzeriteBeam:AutoHeartOfAzeroth(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") then
                return A.FocusedAzeriteBeam:Show(icon)
            end
			
            -- purifying_blast
            if A.PurifyingBlast:AutoHeartOfAzeroth(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") then
                return A.PurifyingBlast:Show(icon)
            end
			
            -- blood_of_the_enemy
            if A.BloodoftheEnemy:AutoHeartOfAzeroth(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") then
                return A.BloodoftheEnemy:Show(icon)
            end
			
            -- concentrated_flame,if=!dot.concentrated_flame_burn.remains&!action.concentrated_flame.in_flight&spell_targets.implosion<5
            if A.ConcentratedFlame:AutoHeartOfAzeroth(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") and (Unit(unit):HasDeBuffs(A.ConcentratedFlameBurn.ID, true) == 0 and not A.ConcentratedFlame:IsSpellInFlight() and MultiUnits:GetActiveEnemies() < 5) then
                return A.ConcentratedFlame:Show(icon)
            end
			
            -- soul_strike,if=soul_shard<5&buff.demonic_core.stack<=2
            if A.SoulStrike:IsReady(unit) and ((Player:SoulShardsP() < 5 or (FutureShard < 5 and PredictShards)) and Unit(player):HasBuffsStacks(A.DemonicCoreBuff.ID, true) <= 2) then
                return A.SoulStrike:Show(icon)
            end
			
            -- demonbolt,if=soul_shard<=3&buff.demonic_core.up&(buff.demonic_core.stack>=3|buff.demonic_core.remains<=gcd*5.7)
            if A.Demonbolt:IsReady(unit) and 
			    (
				   (Player:SoulShardsP() <= 3 or (FutureShard <= 3 and PredictShards)) 
				   and 
				   Unit(player):HasBuffs(A.DemonicCoreBuff.ID, true) > 0 
				   and 
				   (Unit(player):HasBuffsStacks(A.DemonicCoreBuff.ID, true) >= 3 or Unit(player):HasBuffs(A.DemonicCoreBuff.ID, true) <= A.GetGCD() * 5.7)
			    )
			then
                return A.Demonbolt:Show(icon)
            end

		    -- Auto Multidot Doom
	    	if Unit(unit):TimeToDie() >= 10  
		       and Action.GetToggle(2, "AoE") and Action.GetToggle(2, "AutoDot") and CanMultidot
		       and (
            		   ((MissingDoom > 0 and MissingDoom < 5) or (DoomToRefresh > 0 and DoomToRefresh < 5)) 
					   and 
					   Unit(unit):HasDeBuffs(A.DoomDebuff.ID, true) > 5
			        ) 
		       and MultiUnits:GetByRange(MultiDotDistance, 5, 10) > 1 and MultiUnits:GetByRange(MultiDotDistance, 5, 10) <= 5
		    then
		       return A:Show(icon, ACTION_CONST_AUTOTARGET)
		    end	


            -- call_action_list,name=build_a_shard
            if BuildAShard(unit) then
                return true
            end
        end
        Implosion = A.MakeFunctionCachedDynamic(Implosion) 
		
        --NetherPortalActive
        local function NetherPortalActive(unit)
		
            -- bilescourge_bombers
            if A.BilescourgeBombers:IsReady(player) then
                return A.BilescourgeBombers:Show(icon)
            end
			
            -- grimoire_felguard,if=cooldown.summon_demonic_tyrant.remains<13|!equipped.132369
            if A.GrimoireFelguard:IsReady(unit) and A.SummonDemonicTyrant:GetCooldown() < 13 then
                return A.GrimoireFelguardTexture:Show(icon)
            end
			
            -- summon_vilefiend,if=cooldown.summon_demonic_tyrant.remains>40|cooldown.summon_demonic_tyrant.remains<12
            if A.SummonVilefiend:IsReady(unit) and (A.SummonDemonicTyrant:GetCooldown() > 40 or A.SummonDemonicTyrant:GetCooldown() < 12) then
                return A.SummonVilefiend:Show(icon)
            end
			
            -- call_dreadstalkers,if=(cooldown.summon_demonic_tyrant.remains<9&buff.demonic_calling.remains)|(cooldown.summon_demonic_tyrant.remains<11&!buff.demonic_calling.remains)|cooldown.summon_demonic_tyrant.remains>14
            if A.CallDreadstalkers:IsReady(unit) and 
			    (
				    (A.SummonDemonicTyrant:GetCooldown() < 9 and Unit(player):HasBuffs(A.DemonicCallingBuff.ID, true) > 0) 
					or 
					(A.SummonDemonicTyrant:GetCooldown() < 11 and Unit(player):HasBuffs(A.DemonicCallingBuff.ID, true) == 0) 
					or 
					A.SummonDemonicTyrant:GetCooldown() > 14
				)
			then
                return A.CallDreadstalkers:Show(icon)
            end
			
            -- call_action_list,name=build_a_shard,if=soul_shard=1&(cooldown.call_dreadstalkers.remains<action.shadow_bolt.cast_time|(talent.bilescourge_bombers.enabled&cooldown.bilescourge_bombers.remains<action.shadow_bolt.cast_time))
            if BuildAShard(unit) and 
			    (
				    (Player:SoulShardsP() == 1 or (FutureShard == 1 and PredictShards)) and 
					(
					    A.CallDreadstalkers:GetCooldown() < A.ShadowBolt:GetSpellCastTime() 
						or 
						(A.BilescourgeBombers:IsSpellLearned() and A.BilescourgeBombers:GetCooldown() < A.ShadowBolt:GetSpellCastTime())
					)
				) 
			then
                return true
            end
			
            -- hand_of_guldan,if=((cooldown.call_dreadstalkers.remains>action.demonbolt.cast_time)&(cooldown.call_dreadstalkers.remains>action.shadow_bolt.cast_time))&cooldown.nether_portal.remains>(165+action.hand_of_guldan.cast_time)
            if A.HandofGuldan:IsReady(unit) and 
			    (
				    ((A.CallDreadstalkers:GetCooldown() > A.Demonbolt:GetSpellCastTime()) and (A.CallDreadstalkers:GetCooldown() > A.ShadowBolt:GetSpellCastTime())) 
				    and 
				    A.NetherPortal:GetCooldown() > (165 + A.HandofGuldan:GetSpellCastTime())
				)
			then
                return A.HandofGuldan:Show(icon)
            end
			
            -- summon_demonic_tyrant,if=buff.nether_portal.remains<5&soul_shard=0
            if A.SummonDemonicTyrant:IsReady(player) and A.BurstIsON(unit) and (Unit(player):HasBuffs(A.NetherPortalBuff.ID, true) < 5 and (Player:SoulShardsP() == 0 or (FutureShard == 0 and PredictShards))) then
                return A.SummonDemonicTyrant:Show(icon)
            end
			
            -- summon_demonic_tyrant,if=buff.nether_portal.remains<action.summon_demonic_tyrant.cast_time+0.5
            if A.SummonDemonicTyrant:IsReady(player) and A.BurstIsON(unit) and (Unit(player):HasBuffs(A.NetherPortalBuff.ID, true) < A.SummonDemonicTyrant:GetSpellCastTime() + 0.5) then
                return A.SummonDemonicTyrant:Show(icon)
            end
			
            -- demonbolt,if=buff.demonic_core.up&soul_shard<=3
            if A.Demonbolt:IsReady(unit) and (Unit(player):HasBuffs(A.DemonicCoreBuff.ID, true) > 0 and (Player:SoulShardsP() <= 3 or (FutureShard <= 3 and PredictShards))) then
                return A.Demonbolt:Show(icon)
            end
			
            -- call_action_list,name=build_a_shard
            if BuildAShard(unit) then
                return true
            end
			
        end
        NetherPortalActive = A.MakeFunctionCachedDynamic(NetherPortalActive)
		
        --NetherPortalBuilding
        local function NetherPortalBuilding(unit)
		
            -- use_item,name=azsharas_font_of_power,if=cooldown.nether_portal.remains<=5*spell_haste
            if A.AzsharasFontofPower:IsReady(player) and (A.NetherPortal:GetCooldown() <= 5 * Player:SpellHaste()) then
                A.AzsharasFontofPower:Show(icon)
            end
			
            -- guardian_of_azeroth,if=!cooldown.nether_portal.remains&soul_shard>=5
            if A.GuardianofAzeroth:AutoHeartOfAzeroth(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") and (A.NetherPortal:GetCooldown() == 0 and Player:SoulShardsP() >= 5) then
                return A.GuardianofAzeroth:Show(icon)
            end
			
            -- nether_portal,if=soul_shard>=5
            if A.NetherPortal:IsReady(unit) and (Player:SoulShardsP() >= 5 or (FutureShard >= 5 and PredictShards)) then
                return A.NetherPortal:Show(icon)
            end
			
            -- call_dreadstalkers,if=time>=30
            if A.CallDreadstalkers:IsReady(unit) and (Unit(player):CombatTime() >= 30) then
                return A.CallDreadstalkers:Show(icon)
            end
			
            -- hand_of_guldan,if=time>=30&cooldown.call_dreadstalkers.remains>18&soul_shard>=3
            if A.HandofGuldan:IsReady(unit) and (Unit(player):CombatTime() >= 30 and A.CallDreadstalkers:GetCooldown() > 18 and (Player:SoulShardsP() >= 3 or (FutureShard >= 3 and PredictShards))) then
                return A.HandofGuldan:Show(icon)
            end
			
            -- power_siphon,if=time>=30&buff.wild_imps.stack>=2&buff.demonic_core.stack<=2&buff.demonic_power.down&soul_shard>=3
            if A.PowerSiphon:IsReady(unit) and 
			    (
				    Unit(player):CombatTime() >= 30 and WildImpsCount >= 2 and Unit(player):HasBuffsStacks(A.DemonicCoreBuff.ID, true) <= 2 
					and 
					Unit(player):HasBuffsDown(A.DemonicPowerBuff.ID, true) and (Player:SoulShardsP() >= 3 or (FutureShard >= 3 and PredictShards))
				)
			then
                return A.PowerSiphon:Show(icon)
            end
			
            -- hand_of_guldan,if=time>=30&soul_shard>=5
            if A.HandofGuldan:IsReady(unit) and (Unit(player):CombatTime() >= 30 and (Player:SoulShardsP() >= 5 or (FutureShard >= 5 and PredictShards))) then
                return A.HandofGuldan:Show(icon)
            end
			
            -- call_action_list,name=build_a_shard
            if BuildAShard(unit) then
                return true
            end
			
        end
		NetherPortalBuilding = A.MakeFunctionCachedDynamic(NetherPortalBuilding)
		
        --NetherPortal
        local function NetherPortal(unit)
		
            -- call_action_list,name=nether_portal_building,if=cooldown.nether_portal.remains<20
            if NetherPortalBuilding(unit) and (A.NetherPortal:GetCooldown() < 20) then
                return true
            end
			
            -- call_action_list,name=nether_portal_active,if=cooldown.nether_portal.remains>165
            if NetherPortalActive(unit) and (A.NetherPortal:GetCooldown() > 165) then
                return true
            end
			
        end
        NetherPortal = A.MakeFunctionCachedDynamic(NetherPortal)
		
        --Opener
        local function Opener(unit)
		
            -- hand_of_guldan,line_cd=30,if=azerite.explosive_potential.enabled
            if A.HandofGuldan:IsReady(unit) and A.LastPlayerCastName ~= A.HandofGuldan:Info() and Unit(player):CombatTime() < 2 and Player:SoulShardsP() >= 3 and A.ExplosivePotential:GetAzeriteRank() > 0 and Unit(player):HasBuffs(A.ExplosivePotentialBuff.ID, true) == 0 then
                return A.HandofGuldan:Show(icon)
            end
			
            -- implosion,if=azerite.explosive_potential.enabled&buff.wild_imps.stack>2&buff.explosive_potential.down
            if A.Implosion:IsReady(unit) and Unit(player):CombatTime() < 6 and (A.ExplosivePotential:GetAzeriteRank() > 0 and (WildImpsCount > 2 or A.HandofGuldan:GetSpellTimeSinceLastCast() > 1.5) and Unit(player):HasBuffs(A.ExplosivePotentialBuff.ID, true) == 0) then
                return A.Implosion:Show(icon)
            end
			
            -- doom,line_cd=30
            if A.Doom:IsReady(unit) and Unit(unit):HasDeBuffsDown(A.DoomDebuff.ID, true) then
                return A.Doom:Show(icon)
            end
			
            -- guardian_of_azeroth
            if A.GuardianofAzeroth:AutoHeartOfAzeroth(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") then
                return A.GuardianofAzeroth:Show(icon)
            end
			
            -- hand_of_guldan,if=prev_gcd.1.hand_of_guldan&soul_shard>0&prev_gcd.2.soul_strike
            if A.HandofGuldan:IsReady(unit) and Unit(player):CombatTime() > 5 and (A.LastPlayerCastName == A.HandofGuldan:Info() and (A.SoulStrike:GetSpellTimeSinceLastCast() > 1 and A.SoulStrike:GetCooldown() >= 7 or not A.SoulStrike:IsSpellLearned())) then
                return A.HandofGuldan:Show(icon)	
            end
			
            -- demonic_strength,if=prev_gcd.1.hand_of_guldan&!prev_gcd.2.hand_of_guldan&(buff.wild_imps.stack>1&action.hand_of_guldan.in_flight)
            if A.DemonicStrength:IsReady(unit) and (A.LastPlayerCastName == A.HandofGuldan:Info() and (WildImpsCount > 1 and A.HandofGuldan:IsSpellInFlight())) and Unit(player):HasBuffs(A.ExplosivePotentialBuff.ID, true) > 0 then
                return A.DemonicStrength:Show(icon)
            end
			
            -- bilescourge_bombers
            if A.BilescourgeBombers:IsReady(player) then
                return A.BilescourgeBombers:Show(icon)
            end
			
            -- soul_strike,line_cd=30,if=!buff.bloodlust.remains|time>5&prev_gcd.1.hand_of_guldan
            if A.SoulStrike:IsReady(unit) and Player:SoulShardsP() < 5 and (not Unit(player):HasHeroism() or Unit(player):CombatTime() > 3 and A.LastPlayerCastName == A.HandofGuldan:Info()) then
                return A.SoulStrike:Show(icon)
            end
			
            -- summon_vilefiend,if=soul_shard=5
            if A.SummonVilefiend:IsReady(unit) and (Player:SoulShardsP() == 5 or (FutureShard == 5 and PredictShards)) and Unit(player):CombatTime() > 3 then
                return A.SummonVilefiend:Show(icon)
            end
			
            -- grimoire_felguard,if=soul_shard=5
            if A.GrimoireFelguard:IsReady(unit) and (Player:SoulShardsP() == 5 or (FutureShard == 5 and PredictShards)) and Unit(player):CombatTime() > 3 then
                return A.GrimoireFelguardTexture:Show(icon)
            end
			
            -- call_dreadstalkers,if=soul_shard=5
            if A.CallDreadstalkers:IsReady(unit) and (Player:SoulShardsP() == 5 or (FutureShard == 5 and PredictShards)) and Unit(player):CombatTime() > 3 then
                return A.CallDreadstalkers:Show(icon)
            end
			
            -- hand_of_guldan,if=soul_shard=5
            if A.HandofGuldan:IsReady(unit) and (Player:SoulShardsP() == 5 or (FutureShard == 5 and PredictShards)) and Unit(player):CombatTime() > 3 then
                return A.HandofGuldan:Show(icon)
            end
			
            -- hand_of_guldan,if=soul_shard>=3&prev_gcd.2.hand_of_guldan&time>5&(prev_gcd.1.soul_strike|!talent.soul_strike.enabled&prev_gcd.1.shadow_bolt)
            if A.HandofGuldan:IsReady(unit) and Unit(player):CombatTime() > 3 and 
			    (
				    (Player:SoulShardsP() >= 3 or (FutureShard >= 3 and PredictShards))
					and 
					A.HandofGuldan:GetSpellTimeSinceLastCast() < 3 and A.HandofGuldan:GetSpellTimeSinceLastCast() > 0
					and 
					Unit(player):CombatTime() > 5 
					and 
					(A.LastPlayerCastName == A.SoulStrike:Info() or not A.SoulStrike:IsSpellLearned() and A.LastPlayerCastName == A.ShadowBolt:Info())
				)
			then
                return A.HandofGuldan:Show(icon)
            end
			
            -- summon_demonic_tyrant,if=prev_gcd.1.demonic_strength|prev_gcd.1.hand_of_guldan&prev_gcd.2.hand_of_guldan|!talent.demonic_strength.enabled&buff.wild_imps.stack+imps_spawned_during.2000%spell_haste>=6
            if A.SummonDemonicTyrant:IsReady(player) and A.BurstIsON(unit) and 
			(
			    A.LastPlayerCastName == A.DemonicStrength:Info() and (Player:SoulShardsP() <= 1 or (FutureShard <= 1 and PredictShards)) 
				or 
				A.LastPlayerCastName == A.HandofGuldan:Info() and WildImpsCount >= 3 
				or 
				not A.DemonicStrength:IsSpellLearned() and WildImpsCount / Player:SpellHaste() >= 6
			) 
			then
                return A.SummonDemonicTyrant:Show(icon)
            end
			
            -- demonbolt,if=soul_shard<=3&buff.demonic_core.remains
            if A.Demonbolt:IsReady(unit) and ((Player:SoulShardsP() <= 3 or (FutureShard <= 3 and PredictShards)) and Unit(player):HasBuffs(A.DemonicCoreBuff.ID, true) > 0) then
                return A.Demonbolt:Show(icon)
            end
			
            -- call_action_list,name=build_a_shard
            if BuildAShard(unit) then
                return true
            end
			
        end
        Opener = A.MakeFunctionCachedDynamic(Opener)
		
        -- call precombat
        if not inCombat and Unit(unit):IsExists() and unit ~= "mouseover" and Precombat(unit) then
            return true
        end

        -- In Combat
        if inCombat and Unit(unit):IsExists() then
		    -- Interrupt
            local Interrupt = Interrupts(unit)
            if Interrupt then 
                return Interrupt:Show(icon)
            end
		
            -- potion,if=pet.demonic_tyrant.active&(!essence.vision_of_perfection.major|!talent.demonic_consumption.enabled|cooldown.summon_demonic_tyrant.remains>=cooldown.summon_demonic_tyrant.duration-5)&(!talent.nether_portal.enabled|cooldown.nether_portal.remains>160)|target.time_to_die<30
            if A.PotionofUnbridledFury:IsReady(unit) and Action.GetToggle(1, "Potion") and (RealTyrantIsActive and (not Azerite:EssenceHasMajor(A.VisionofPerfection.ID) or not A.DemonicConsumption:IsSpellLearned() or A.SummonDemonicTyrant:GetCooldown() >= 15 - 5) and (not A.NetherPortal:IsSpellLearned() or A.NetherPortal:GetCooldown() > 160) or (Unit(unit):IsBoss() and Unit(unit):TimeToDie() <= 30)) then
                return A.PotionofUnbridledFury:Show(icon)
            end
			
            -- use_item,name=azsharas_font_of_power,if=cooldown.summon_demonic_tyrant.remains<=20&!talent.nether_portal.enabled
            if A.AzsharasFontofPower:IsReady(player) and (A.SummonDemonicTyrant:GetCooldown() <= 20 and not A.NetherPortal:IsSpellLearned()) then
                return A.AzsharasFontofPower:Show(icon)
            end
			
            -- use_items,if=pet.demonic_tyrant.active&(!essence.vision_of_perfection.major|!talent.demonic_consumption.enabled|cooldown.summon_demonic_tyrant.remains>=cooldown.summon_demonic_tyrant.duration-5)|target.time_to_die<=15
            -- berserking,if=pet.demonic_tyrant.active&(!essence.vision_of_perfection.major|!talent.demonic_consumption.enabled|cooldown.summon_demonic_tyrant.remains>=cooldown.summon_demonic_tyrant.duration-5)|target.time_to_die<=15
            if A.Berserking:AutoRacial(unit) and Action.GetToggle(1, "Racial") and A.BurstIsON(unit) and 
			(
			    (
				    RealTyrantIsActive and (not Azerite:EssenceHasMajor(A.VisionofPerfection.ID)) or not A.DemonicConsumption:IsSpellLearned() or A.SummonDemonicTyrant:GetCooldown() >= 15 - 5
				) 
				or 
				(
				    Unit(unit):IsBoss() and Unit(unit):TimeToDie() <= 15
				)
			)
			then
                return A.Berserking:Show(icon)
            end
			
            -- blood_fury,if=pet.demonic_tyrant.active&(!essence.vision_of_perfection.major|!talent.demonic_consumption.enabled|cooldown.summon_demonic_tyrant.remains>=cooldown.summon_demonic_tyrant.duration-5)|target.time_to_die<=15
            if A.BloodFury:AutoRacial(unit) and Action.GetToggle(1, "Racial") and A.BurstIsON(unit) and 
			(
			    (
				    RealTyrantIsActive and (not Azerite:EssenceHasMajor(A.VisionofPerfection.ID)) or not A.DemonicConsumption:IsSpellLearned() or A.SummonDemonicTyrant:GetCooldown() >= 15 - 5
				) 
				or 
				(
				    Unit(unit):IsBoss() and Unit(unit):TimeToDie() <= 15
				)
			)
			then
                return A.BloodFury:Show(icon)
            end
			
            -- fireblood,if=pet.demonic_tyrant.active&(!essence.vision_of_perfection.major|!talent.demonic_consumption.enabled|cooldown.summon_demonic_tyrant.remains>=cooldown.summon_demonic_tyrant.duration-5)|target.time_to_die<=15
            if A.Fireblood:AutoRacial(unit) and Action.GetToggle(1, "Racial") and A.BurstIsON(unit) and 
			(
			    (
				    RealTyrantIsActive and (not Azerite:EssenceHasMajor(A.VisionofPerfection.ID)) or not A.DemonicConsumption:IsSpellLearned() or A.SummonDemonicTyrant:GetCooldown() >= 15 - 5
				) 
				or 
				(
				    Unit(unit):IsBoss() and Unit(unit):TimeToDie() <= 15
				)
			)
			then
                return A.Fireblood:Show(icon)
            end

            -- bag_of_tricks
            if A.BagofTricks:AutoRacial(unit) and Action.GetToggle(1, "Racial") and A.BurstIsON(unit) then
                return A.BagofTricks:Show(icon)
            end
			
            -- blood_of_the_enemy,if=pet.demonic_tyrant.active&pet.demonic_tyrant.remains<=15-gcd*3&(!essence.vision_of_perfection.major|!talent.demonic_consumption.enabled|cooldown.summon_demonic_tyrant.remains>=cooldown.summon_demonic_tyrant.duration-5)
            if A.BloodoftheEnemy:AutoHeartOfAzeroth(unit, true) and A.BurstIsON(unit) and Action.GetToggle(1, "HeartOfAzeroth") and 
			    (
				    RealTyrantIsActive and DemonicTyrantTime <= 15 - A.GetGCD() * 3 
					and 
					(not Azerite:EssenceHasMajor(A.VisionofPerfection.ID))
					or 
					not A.DemonicConsumption:IsSpellLearned() 
					or 
					A.SummonDemonicTyrant:GetCooldown() >= 15 - 5
				)
			then
                return A.BloodoftheEnemy:Show(icon)
            end
			
            -- worldvein_resonance,if=buff.lifeblood.stack<3&(pet.demonic_tyrant.active&(!essence.vision_of_perfection.major|!talent.demonic_consumption.enabled|cooldown.summon_demonic_tyrant.remains>=cooldown.summon_demonic_tyrant.duration-5)|target.time_to_die<=15)
            if A.WorldveinResonance:AutoHeartOfAzeroth(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") and 
			    (
				    Unit(player):HasBuffsStacks(A.LifebloodBuff.ID, true) < 3 
					and 
					(RealTyrantIsActive and (not Azerite:EssenceHasMajor(A.VisionofPerfection.ID)) or not A.DemonicConsumption:IsSpellLearned() or A.SummonDemonicTyrant:GetCooldown() >= 15 - 5) 
					or 
					(Unit(unit):IsBoss() and Unit(unit):TimeToDie() <= 15)
				)
			then
                return A.WorldveinResonance:Show(icon)
            end
			
            -- ripple_in_space,if=pet.demonic_tyrant.active&(!essence.vision_of_perfection.major|!talent.demonic_consumption.enabled|cooldown.summon_demonic_tyrant.remains>=cooldown.summon_demonic_tyrant.duration-5)|target.time_to_die<=15
            if A.RippleinSpace:AutoHeartOfAzeroth(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") and 
			    (
				    RealTyrantIsActive and (not Azerite:EssenceHasMajor(A.VisionofPerfection.ID)) 
					or 
					not A.DemonicConsumption:IsSpellLearned() 
					or 
					A.SummonDemonicTyrant:GetCooldown() >= 15 - 5 
					or 
					(Unit(unit):IsBoss() and Unit(unit):TimeToDie() <= 15)
				)
			then
                return A.RippleinSpace:Show(icon)
            end
			
            -- use_item,name=pocketsized_computation_device,if=cooldown.summon_demonic_tyrant.remains>=20&cooldown.summon_demonic_tyrant.remains<=cooldown.summon_demonic_tyrant.duration-15|target.time_to_die<=30
            if A.PocketsizedComputationDevice:IsReady(unit) and (A.SummonDemonicTyrant:GetCooldown() >= 20 and A.SummonDemonicTyrant:GetCooldown() <= 15 - 15 or (Unit(unit):IsBoss() and Unit(unit):TimeToDie() <= 30)) then
                return A.PocketsizedComputationDevice:Show(icon)
            end
			
            -- use_item,name=rotcrusted_voodoo_doll,if=(cooldown.summon_demonic_tyrant.remains>=25|target.time_to_die<=30)
            if A.RotcrustedVoodooDoll:IsReady(unit) and ((A.SummonDemonicTyrant:GetCooldown() >= 25 or (Unit(unit):IsBoss() and Unit(unit):TimeToDie() <= 30))) then
                return A.RotcrustedVoodooDoll:Show(icon)
            end
			
            -- use_item,name=shiver_venom_relic,if=(cooldown.summon_demonic_tyrant.remains>=25|target.time_to_die<=30)
            if A.ShiverVenomRelic:IsReady(unit) and ((A.SummonDemonicTyrant:GetCooldown() >= 25 or (Unit(unit):IsBoss() and Unit(unit):TimeToDie() <= 30))) then
                return A.ShiverVenomRelic:Show(icon)
            end
			
            -- use_item,name=aquipotent_nautilus,if=(cooldown.summon_demonic_tyrant.remains>=25|target.time_to_die<=30)
            if A.AquipotentNautilus:IsReady(unit) and ((A.SummonDemonicTyrant:GetCooldown() >= 25 or (Unit(unit):IsBoss() and Unit(unit):TimeToDie() <= 30))) then
                return A.AquipotentNautilus:Show(icon)
            end
			
            -- use_item,name=tidestorm_codex,if=(cooldown.summon_demonic_tyrant.remains>=25|target.time_to_die<=30)
            if A.TidestormCodex:IsReady(unit) and ((A.SummonDemonicTyrant:GetCooldown() >= 25 or (Unit(unit):IsBoss() and Unit(unit):TimeToDie() <= 30))) then
                return A.TidestormCodex:Show(icon)
            end
			
            -- use_item,name=vial_of_storms,if=(cooldown.summon_demonic_tyrant.remains>=25|target.time_to_die<=30)
            if A.VialofStorms:IsReady(unit) and ((A.SummonDemonicTyrant:GetCooldown() >= 25 or (Unit(unit):IsBoss() and Unit(unit):TimeToDie() <= 30))) then
                return A.VialofStorms:Show(icon)
            end
			
            -- call_action_list,name=opener,if=!talent.nether_portal.enabled&time<30&!cooldown.summon_demonic_tyrant.remains
            if Opener(unit) and (not A.NetherPortal:IsSpellLearned() and Unit(player):CombatTime() < 30 and A.SummonDemonicTyrant:GetCooldown() == 0) then
                return true
            end
			
            -- use_item,name=azsharas_font_of_power,if=(time>30|!talent.nether_portal.enabled)&talent.grimoire_felguard.enabled&(target.time_to_die>120|target.time_to_die<cooldown.summon_demonic_tyrant.remains+15)|target.time_to_die<=35
            if A.AzsharasFontofPower:IsReady(player) and A.BurstIsON(unit) and 
			    (
				    (Unit(player):CombatTime() > 30 or not A.NetherPortal:IsSpellLearned()) 
					and 
					A.GrimoireFelguard:IsSpellLearned() 
					and 
					(Unit(unit):TimeToDie() > 120 or Unit(unit):TimeToDie() < A.SummonDemonicTyrant:GetCooldown() + 15) 
					or 
					(Unit(unit):TimeToDie() <= 35 and Unit(unit):IsBoss())
				)
			then
                return A.AzsharasFontofPower:Show(icon)
            end
			
            -- hand_of_guldan,if=azerite.explosive_potential.rank&time<5&soul_shard>2&buff.explosive_potential.down&buff.wild_imps.stack<3&!prev_gcd.1.hand_of_guldan&&!prev_gcd.2.hand_of_guldan
            if A.HandofGuldan:IsReady(unit) and 
			    (
				    A.ExplosivePotential:GetAzeriteRank() > 0 
					and 
					Unit(player):CombatTime() < 5 
					and 
					(Player:SoulShardsP() > 2 or (FutureShard > 2 and PredictShards))
					and 
					Unit(player):HasBuffsDown(A.ExplosivePotentialBuff.ID, true) 
					and 
					WildImpsCount < 3 
					and 
					not A.LastPlayerCastName == A.HandofGuldan:Info()
				) 
			then
                return A.HandofGuldan:Show(icon)
            end
			
            -- demonbolt,if=soul_shard<=3&buff.demonic_core.up&buff.demonic_core.stack=4
            if A.Demonbolt:IsReady(unit) and ((Player:SoulShardsP() <= 3 or (FutureShard <= 3 and PredictShards)) and Unit(player):HasBuffs(A.DemonicCoreBuff.ID, true) and Unit(player):HasBuffsStacks(A.DemonicCoreBuff.ID, true) == 4) then
                return A.Demonbolt:Show(icon)
            end
			
            -- implosion,if=azerite.explosive_potential.rank&buff.wild_imps.stack>2&buff.explosive_potential.remains<action.shadow_bolt.execute_time&(!talent.demonic_consumption.enabled|cooldown.summon_demonic_tyrant.remains>12)
            if A.Implosion:IsReady(unit) and 
			    (
				    A.ExplosivePotential:GetAzeriteRank() > 0 and WildImpsCount > 2 and Unit(player):HasBuffs(A.ExplosivePotentialBuff.ID, true) < A.GetGCD() + 0.5
					and 
					(not A.DemonicConsumption:IsSpellLearned() or A.SummonDemonicTyrant:GetCooldown() > 12)
				) 
			then
                return A.Implosion:Show(icon)
            end
			
            -- doom,if=!ticking&time_to_die>30&spell_targets.implosion<2&!buff.nether_portal.remains
            if A.Doom:IsReady(unit) and (Unit(unit):HasDeBuffs(A.DoomDebuff.ID, true) == 0 and Unit(unit):TimeToDie() > 30 and MultiUnits:GetActiveEnemies() < 2 and Unit(player):HasBuffs(A.NetherPortalBuff.ID, true) == 0) then
                return A.Doom:Show(icon)
            end
			
            -- bilescourge_bombers,if=azerite.explosive_potential.rank>0&time<10&spell_targets.implosion<2&buff.dreadstalkers.remains&talent.nether_portal.enabled
            if A.BilescourgeBombers:IsReady(player) and (A.ExplosivePotential:GetAzeriteRank() > 0 and Unit(player):CombatTime() < 10 and MultiUnits:GetActiveEnemies() < 2 and DreadStalkersTime > 0 and A.NetherPortal:IsSpellLearned()) then
                return A.BilescourgeBombers:Show(icon)
            end
			
            -- demonic_strength,if=(buff.wild_imps.stack<6|buff.demonic_power.up)|spell_targets.implosion<2
            if A.DemonicStrength:IsReady(unit) and ((WildImpsCount < 6 or Unit(player):HasBuffs(A.DemonicPowerBuff.ID, true) > 0) or MultiUnits:GetActiveEnemies() < 2) then
                return A.DemonicStrength:Show(icon)
            end
			
            -- call_action_list,name=nether_portal,if=talent.nether_portal.enabled&spell_targets.implosion<=2
            if NetherPortal(unit) and A.BurstIsON(unit) and (A.NetherPortal:IsSpellLearned() and MultiUnits:GetActiveEnemies() <= 2) then
                return true
            end
			
            -- call_action_list,name=implosion,if=spell_targets.implosion>1
            if Implosion(unit) and (MultiUnits:GetActiveEnemies() > 1 or Unit(unit):IsDummy() and MultiUnits:GetByRange(40) > 1) then
                return true
            end
			
            -- guardian_of_azeroth,if=cooldown.summon_demonic_tyrant.remains<=15|target.time_to_die<=30
            if A.GuardianofAzeroth:AutoHeartOfAzeroth(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") and (A.SummonDemonicTyrant:GetCooldown() <= 15 or (Unit(unit):IsBoss() and Unit(unit):TimeToDie() <= 30)) then
                return A.GuardianofAzeroth:Show(icon)
            end
			
            -- grimoire_felguard,if=(target.time_to_die>120|target.time_to_die<cooldown.summon_demonic_tyrant.remains+15|cooldown.summon_demonic_tyrant.remains<13)
            if A.GrimoireFelguard:IsReady(unit) and ((Unit(unit):TimeToDie() > 120 or Unit(unit):TimeToDie() < A.SummonDemonicTyrant:GetCooldown() + 15 or A.SummonDemonicTyrant:GetCooldown() < 13)) then
                return A.GrimoireFelguardTexture:Show(icon)
            end
			
            -- summon_vilefiend,if=cooldown.summon_demonic_tyrant.remains>40|cooldown.summon_demonic_tyrant.remains<12
            if A.SummonVilefiend:IsReady(unit) and (A.SummonDemonicTyrant:GetCooldown() > 40 or A.SummonDemonicTyrant:GetCooldown() < 12) then
                return A.SummonVilefiend:Show(icon)
            end
			
            -- call_dreadstalkers,if=(cooldown.summon_demonic_tyrant.remains<9&buff.demonic_calling.remains)|(cooldown.summon_demonic_tyrant.remains<11&!buff.demonic_calling.remains)|cooldown.summon_demonic_tyrant.remains>14
            if A.CallDreadstalkers:IsReady(unit) and 
			    (
				    (A.SummonDemonicTyrant:GetCooldown() < 9 and Unit(player):HasBuffs(A.DemonicCallingBuff.ID, true) > 0) 
					or 
					(A.SummonDemonicTyrant:GetCooldown() < 11 and Unit(player):HasBuffs(A.DemonicCallingBuff.ID, true) == 0) 
					or 
					A.SummonDemonicTyrant:GetCooldown() > 14
				) 
			then
                return A.CallDreadstalkers:Show(icon)
            end
			
            -- the_unbound_force,if=buff.reckless_force.react
            if A.TheUnboundForce:AutoHeartOfAzeroth(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") and (Unit(player):HasBuffsStacks(A.RecklessForceBuff.ID, true) > 0) then
                return A.TheUnboundForce:Show(icon)
            end
			
            -- bilescourge_bombers
            if A.BilescourgeBombers:IsReady(player) then
                return A.BilescourgeBombers:Show(icon)
            end
			
            -- hand_of_guldan,if=(azerite.baleful_invocation.enabled|talent.demonic_consumption.enabled)&prev_gcd.1.hand_of_guldan&cooldown.summon_demonic_tyrant.remains<2
            if A.HandofGuldan:IsReady(unit) and 
			    (
				    (A.BalefulInvocation:GetAzeriteRank() > 0 or A.DemonicConsumption:IsSpellLearned()) and A.LastPlayerCastName == A.HandofGuldan:Info() and A.SummonDemonicTyrant:GetCooldown() < 2
				)
			then
                return A.HandofGuldan:Show(icon)
            end
			
            -- summon_demonic_tyrant,if=soul_shard<3&(!talent.demonic_consumption.enabled|buff.wild_imps.stack+imps_spawned_during.2000%spell_haste>=6&time_to_imps.all.remains<cast_time)|target.time_to_die<20
            if A.SummonDemonicTyrant:IsReady(player) and A.BurstIsON(unit) and 
			    (
				    (Player:SoulShardsP() < 3 or (FutureShard < 3 and PredictShards)) 
					and 
					(not A.DemonicConsumption:IsSpellLearned() or WildImpsCount / Player:SpellHaste() >= 6) 
					or
                    MegaTyrant					
					or
					(Unit(unit):IsBoss() and Unit(unit):TimeToDie() < 20 and WildImpsCount > 2)
				) 
			then
                return A.SummonDemonicTyrant:Show(icon)
            end
			
            -- power_siphon,if=buff.wild_imps.stack>=2&buff.demonic_core.stack<=2&buff.demonic_power.down&spell_targets.implosion<2
            if A.PowerSiphon:IsReady(unit) and 
			    (
				    WildImpsCount >= 2 and Unit(player):HasBuffsStacks(A.DemonicCoreBuff.ID, true) <= 2 and Unit(player):HasBuffsDown(A.DemonicPowerBuff.ID, true) and MultiUnits:GetActiveEnemies() < 2
				) 
			then
                return A.PowerSiphon:Show(icon)
            end
			
            -- doom,if=talent.doom.enabled&refreshable&time_to_die>(dot.doom.remains+30)
            if A.Doom:IsReady(unit) and (A.Doom:IsSpellLearned() and Unit(unit):HasDeBuffsRefreshable(A.DoomDebuff.ID, true) and Unit(unit):TimeToDie() > (Unit(unit):HasDeBuffs(A.DoomDebuff.ID, true) + 30)) then
                return A.Doom:Show(icon)
            end
			
            -- hand_of_guldan,if=soul_shard>=5|(soul_shard>=3&cooldown.call_dreadstalkers.remains>4&(cooldown.summon_demonic_tyrant.remains>20|(cooldown.summon_demonic_tyrant.remains<gcd*2&talent.demonic_consumption.enabled|cooldown.summon_demonic_tyrant.remains<gcd*4&!talent.demonic_consumption.enabled))&(!talent.summon_vilefiend.enabled|cooldown.summon_vilefiend.remains>3))
            if A.HandofGuldan:IsReady(unit) and 
			    (
				    (Player:SoulShardsP() >= 5 or (FutureShard >= 5 and PredictShards))
					or 
					(
					    (Player:SoulShardsP() >= 3 or (FutureShard >= 3 and PredictShards)) and A.CallDreadstalkers:GetCooldown() > 4 and 
						(
						    A.SummonDemonicTyrant:GetCooldown() > 20 
							or 
							(
							    A.SummonDemonicTyrant:GetCooldown() < A.GetGCD() * 2 and A.DemonicConsumption:IsSpellLearned() 
								or 
								A.SummonDemonicTyrant:GetCooldown() < A.GetGCD() * 4 and not A.DemonicConsumption:IsSpellLearned()
							)
						) 
						and (not A.SummonVilefiend:IsSpellLearned() or A.SummonVilefiend:GetCooldown() > 3)
					)
				) 
			then
                return A.HandofGuldan:Show(icon)
            end
			
            -- soul_strike,if=soul_shard<5&buff.demonic_core.stack<=2
            if A.SoulStrike:IsReady(unit) and ((Player:SoulShardsP() < 5 or (FutureShard < 5 and PredictShards)) and Unit(player):HasBuffsStacks(A.DemonicCoreBuff.ID, true) <= 2) then
                return A.SoulStrike:Show(icon)
            end
			
            -- demonbolt,if=soul_shard<=3&buff.demonic_core.up&((cooldown.summon_demonic_tyrant.remains<6|cooldown.summon_demonic_tyrant.remains>22&!azerite.shadows_bite.enabled)|buff.demonic_core.stack>=3|buff.demonic_core.remains<5|time_to_die<25|buff.shadows_bite.remains)
            if A.Demonbolt:IsReady(unit) and 
			    (
				    (Player:SoulShardsP() <= 3 or (FutureShard <= 3 and PredictShards)) and Unit(player):HasBuffs(A.DemonicCoreBuff.ID, true) > 0 and 
					(
					    (A.SummonDemonicTyrant:GetCooldown() < 6 or A.SummonDemonicTyrant:GetCooldown() > 22 and A.ShadowsBite:GetAzeriteRank() == 0) 
						or 
						Unit(player):HasBuffsStacks(A.DemonicCoreBuff.ID, true) >= 3 
						or 
						Unit(player):HasBuffs(A.DemonicCoreBuff.ID, true) < 5 
						or 
						(Unit(unit):IsBoss() and Unit(unit):TimeToDie() < 25) 
						or 
						Unit(player):HasBuffs(A.ShadowsBiteBuff.ID, true) > 0
					)
				)
			then
                return A.Demonbolt:Show(icon)
            end
			
            -- focused_azerite_beam,if=!pet.demonic_tyrant.active
            if A.FocusedAzeriteBeam:AutoHeartOfAzeroth(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") and (not RealTyrantIsActive) then
                return A.FocusedAzeriteBeam:Show(icon)
            end
			
            -- purifying_blast
            if A.PurifyingBlast:AutoHeartOfAzeroth(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") then
                return A.PurifyingBlast:Show(icon)
            end
			
            -- blood_of_the_enemy
            if A.BloodoftheEnemy:AutoHeartOfAzeroth(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") then
                return A.BloodoftheEnemy:Show(icon)
            end
			
            -- concentrated_flame,if=!dot.concentrated_flame_burn.remains&!action.concentrated_flame.in_flight&!pet.demonic_tyrant.active
            if A.ConcentratedFlame:AutoHeartOfAzeroth(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") and 
			    (
				    Unit(unit):HasDeBuffs(A.ConcentratedFlameBurn.ID, true) == 0 
					and 
					not A.ConcentratedFlame:IsSpellInFlight() 
					and 
					not RealTyrantIsActive
				) 
			then
                return A.ConcentratedFlame:Show(icon)
            end
			
            -- call_action_list,name=build_a_shard
            if BuildAShard(unit) then
                return true
            end
			
        end
    end
    EnemyRotation = A.MakeFunctionCachedDynamic(EnemyRotation)
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
local function ArenaRotation(icon, unit)
    if A.IsInPvP and (A.Zone == "pvp" or A.Zone == "arena") and not Player:IsStealthed() and not Player:IsMounted() then
        -- Note: "arena1" is just identification of meta 6
        if unit == "arena1" and (Unit(player):GetDMG() == 0 or not Unit(player):IsFocused("DAMAGER")) then 
            -- Reflect Casting BreakAble CC
            if A.NetherWard:IsReady() and A.NetherWard:IsSpellLearned() and Action.ShouldReflect(unit) and EnemyTeam():IsCastingBreakAble(0.25) then 
                return A.NetherWard:Show(icon)
            end 
		    -- Interrupt
            local Interrupt = Interrupts(unit)
            if Interrupt then 
                return Interrupt:Show(icon)
            end
        end
    end 
end 
local function PartyRotation(unit)
    if (unit == "party1" and not A.GetToggle(2, "PartyUnits")[1]) or (unit == "party2" and not A.GetToggle(2, "PartyUnits")[2]) then 
        return false 
    end
    
  	-- SingeMagic
    --if A.SingeMagic:IsCastable() and A.SingeMagic:AbsentImun(unit, Temp.TotalAndMag) and IsSchoolFree() and Action.AuraIsValid(unit, "UseDispel", "Magic") and not Unit(unit):InLOS() then
   --     return A.SingeMagic
   -- end
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

