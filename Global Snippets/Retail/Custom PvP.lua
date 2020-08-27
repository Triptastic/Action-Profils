---------------------------------------------------
---------------- CUSTOM PVP FUNCTIONS -------------
---------------------------------------------------
local _G, setmetatable, select, math        = _G, setmetatable, select, math
local TMW                                   = TMW
local CNDT                                  = TMW.CNDT
local Env                                   = CNDT.Env
local Action                                = _G.Action
local MultiUnits                            = Action.MultiUnits
local next, pairs, type, print              = next, pairs, type, print
local IsActionInRange, GetActionInfo, PetHasActionBar, GetPetActionsUsable, GetSpellInfo = IsActionInRange, GetActionInfo, PetHasActionBar, GetPetActionsUsable, GetSpellInfo
local UnitIsPlayer, UnitExists, UnitGUID    = UnitIsPlayer, UnitExists, UnitGUID
local PetLib                                = LibStub("PetLibrary")
local Unit                                  = Action.Unit 
local huge                                  = math.huge
local TeamCache                             = Action.TeamCache
local TeamCacheEnemy 						= TeamCache.Enemy
local TeamCacheEnemyIndexToPLAYERs			= TeamCacheEnemy.IndexToPLAYERs
local Re                                    = Action.Re
local CombatLogGetCurrentEventInfo          = _G.CombatLogGetCurrentEventInfo
---------------------------------------------------
-------------------- CONSTANTS --------------------
---------------------------------------------------
--- Reflect Spells List
local pvpReflect = {
    161372, -- Poly
    190319, -- Combustion
    161372, -- Polymorph
    203286, -- Greater Pyroblast
    199786, --  Glacial Spike
    257537, -- Ebonbolt
    210714, -- Icefury
    191634, -- Stormkeeper
    116858, -- Chaos Bolt
	118, -- Poly
}

---------------------------------------------------
-------------------- FUNCTIONS --------------------
---------------------------------------------------
-- Local Randomizer
local randomReflect = math.random(90, 100)

-- Should Reflect behavior
-- Parameter "unit" is mandatory
-- @return Boolean
function Action.ShouldReflect(unit)	

	local GoodToReflect = false
	-- Protect if nil parameter 
	if not unit or unit == nil then 
		unit = "target"
	end

    for i = 1, #pvpReflect do 
		local castingTime, castingLeftSec, castingDonePer, spellID, spellName = Unit(unit):CastTime()
        if not spellID then 
            break 
        elseif pvpReflect[i] then 
            if  castingDonePer >= randomReflect then
                GoodToReflect = true
            else
		        GoodToReflect = false
			end
        end 
    end 
	
	return GoodToReflect
end 

-- Get Lowest Enemy from EnemyTeam
-- Parameter "range" is optional
-- @return "unitID" of current lowest enemy team member
function GetLowestEnemy(range)
    local lowestUnit = "player"
	local currentUnitHP = 0
	local lowestUnitHP = 999999999
	
	if range == nil then 
	    range = 40 
	end
	
	if Action and TeamCacheEnemy then
	    for i = 1, TeamCacheEnemy.MaxSize do
			arena = TeamCacheEnemyIndexToPLAYERs[i]
			if arena and (not range or Unit(arena):GetRange() <= range) then
			    
			    currentUnitHP = Unit(arena):HealthPercent()
				if currentUnitHP < lowestUnitHP then
				    lowestUnitHP = currentUnitHP
					lowestUnit = Unit(arena):GetUnitID()   					
				end      
			end 
		end  
	end
	
	return lowestUnit 
end

-- Get current CC applied on Enemy from EnemyTeam
-- Parameter "range" is optional
-- Parameters checkspellcasttime and spell are optional too. But both are mandatory if used (spell = A.Spell)
-- @return "boolean" true if Chain CC Able, "unitID" of current enemy that is controled
function FindChainCCAbleUnit(range, checkspellcasttime, spell)
    local CCAbleUnit = "target"
	local IsCCAble = false
	
	if range == nil then 
	    range = 40 
	end
	
	if Action and TeamCacheEnemy then
	    for i = 1, TeamCacheEnemy.MaxSize do
			arena = TeamCacheEnemyIndexToPLAYERs[i]
			if arena and (not range or Unit(arena):GetRange() <= range) then
			    if not checkspellcasttime then
				    if Unit(arena):HasDeBuffs("BreakAble") > 0 and Unit(arena):HasDeBuffs("BreakAble") < A.GetGCD() + A.GetLatency() + 0.1 then
			            CCAbleUnit = Unit(arena):GetUnitID()
					    IsCCAble = true 
                    end
				else
                    if Unit(arena):HasDeBuffs("BreakAble") > 0 and Unit(arena):HasDeBuffs("BreakAble") < A.GetGCD() + A.GetLatency() + spell:GetSpellCastTime() then
			            CCAbleUnit = Unit(arena):GetUnitID()
					    IsCCAble = true 
                    end 				
				end      
			end 
		end  
	end
	
	return IsCCAble, CCAbleUnit 
end

-- Get current status of enemy PvP trinket
-- @return "boolean" true if unit has PvP Trinket ready
function Unit:HasPvPTrinketAvailable(isHealer)
    if not isHealer then
        return self:GetCooldown(208683) > self:GetMaxDuration(208683) - 2
	else
	    return self:GetCooldown(208683) > self:GetMaxDuration(208683) - 2 and self:IsHealer()
	end
end

-- Fake Cast script 
-- Not yet tested
-- Will track Enemies interrupts status. If Interrupt is ready, then will fake cast depending of settings else will cast without faking
-- @Return STOP_CAST icon 
-- @Usage just call function from rotation to auto STOP_CAST 

if not FakeCastTable then 
    FakeCastTable = {} 
end

-- CLEU events 
local function COMBAT_LOG_EVENT_UNFILTERED()
    
	local InterruptSpells = {
		{Spell = "Mind Freeze", Cooldown = 15 },
		{Spell = "Strangulate", Cooldown = 120},
		{Spell = "Skull Bash", Cooldown = 15},
		{Spell = "Solar Beam", Cooldown = 60},
		{Spell = "Counter Shot", Cooldown = 24},
		{Spell = "Counterspell", Cooldown = 24},
		{Spell = "Spear Hand Strike", Cooldown = 15},
		{Spell = "Avenger's Shield", Cooldown = 15},
		{Spell = "Rebuke", Cooldown = 15},
		{Spell = "Silence", Cooldown = 45},
		{Spell = "Kick", Cooldown = 15},
		{Spell = "Deadly Throw", Cooldown = 0},
		{Spell = "Wind Shear", Cooldown = 12},
		{Spell = "Spell Lock", Cooldown = 24},
		{Spell = "Optical Blast", Cooldown = 24},
		{Spell = "Pummel", Cooldown = 15}
		-- Add more if you want, make sure to format it correctly
	}
	
	if A.Zone == "arena" or A.Zone == "pvp" then -- check for Arena or PvP Zones
 	
	    local _, Event, _, SourceGUID, _, SourceFlags, _, DestGUID, DestName, DestFlags,_, SpellID, SpellName = CombatLogGetCurrentEventInfo()
            
		if (Event == "SPELL_AURA_APPLIED") or (Event == "SPELL_CAST_SUCCESS") then

			for i=1, #InterruptSpells do
				
				if InterruptSpells[i].Spell == SpellName then

					if DestGUID == UnitGUID("player") then
						--local tspell, _, _, _, tstart, tend, _, _, tint = UnitCastingInfo("player")
						local PlayercastName, _, _, PlayercastStartTime, PlayercastEndTime, _, _, PlayernotInterruptable, PlayerspellID = UnitCastingInfo("player")
						--local tchannel, _, _, _, tchannelstart, tchannelend, _, tchannelint = UnitChannelInfo("player")
						local PlayerchannelName, _, _, PlayerchannelStartTime, PlayerchannelEndTime, _, PlayerchannelnotInterruptable, PlayerchannelspellID = UnitChannelInfo("player")
						if (PlayerspellID and PlayernotInterruptable) or (PlayerchannelspellID and PlayerchannelnotInterruptable) then
							-- if immune to disrupts, then return
							return
						else
						    -- else stop spell casting
     						return A:Show(icon, ACTION_CONST_STOPCAST)								
						end
					end
					if not isHostileSource and not isNeutralSource then return end
					if isFriendlySource and not isNeutralSource then return end
					if not isPlayerSource and not isNeutralSource then return end
					-- these are filters for enemy so we don't track friendly disrupts
					if( not FakeCastTable[SourceGUID] ) then
						FakeCastTable[SourceGUID] = {}
					end

					if( not FakeCastTable[SourceGUID][InterruptSpells[i].Spell]) then
						FakeCastTable[SourceGUID][InterruptSpells[i].Spell] = { time = GetTime(), reset = InterruptSpells[i].Cooldown + GetTime() }
						--This tracks GUID interrupt cooldown in a table					
					end
				end
			end
		end		
    end
end
A.Listener:Add("ACTION_TASTE_FAKE_CAST_TRACKER", "COMBAT_LOG_EVENT_UNFILTERED", COMBAT_LOG_EVENT_UNFILTERED)