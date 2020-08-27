---------------------------------------------------
--------------- CUSTOM PREV SPELLS ----------------
---------------------------------------------------
local A                                     = Action
local Player								= Action.Player 
local Pet                                   = LibStub("PetLibrary")
local Unit                                  = Action.Unit 
-- Lua methods
local next, pairs, type, print              = next, pairs, type, print
local error                                 = error
local setmetatable                          = setmetatable
local stringformat                          = string.format
local tableinsert                           = table.insert
local tableremove							= table.remove 


-- File Locals
local TriggerGCD = A.Enum.TriggerGCD -- TriggerGCD table
local LastRecord = 15 -- Number of recorded spells
local PrevGCDPredicted = 0
local Prev = {
    GCD = {},
    OffGCD = {},
    PetGCD = {},
    PetOffGCD = {},
}
local Custom = {
    Whitelist = {},
    Blacklist = {}
}


---------------------------------------------
------------------- CORE --------------------
---------------------------------------------

-- Init all the records at 0, so it saves one check on PrevGCD method.
for i = 1, LastRecord do
    for _, Table in pairs(Prev) do
        tableinsert(Table, 0)
    end
end

-- Clear Old Records
local function RemoveOldRecords()
    for _, Table in pairs(Prev) do
        local n = #Table
        while n > LastRecord do
            Table[n] = nil
            n = n - 1
        end
    end
end

local function COMBAT_LOG_EVENT_UNFILTERED(...)
	 	
	local _, Event, _, SourceGUID, _, SourceFlags, _, DestGUID, DestName, DestFlags,_, SpellID, SpellName = CombatLogGetCurrentEventInfo()
	
	-- On Cast Success Listener
    if Event == "SPELL_CAST_SUCCESS" and TriggerGCD[SpellID] ~= nil then
	    -- Player
	    if SourceGUID == UnitGUID("player") then
            if TriggerGCD[SpellID] then
                tableinsert(Prev.GCD, 1, SpellID)
                Prev.OffGCD = {}
                PrevGCDPredicted = 0
            else -- Prevents unwanted spells to be registered as OffGCD.
                tableinsert(Prev.OffGCD, 1, SpellID)
			end
		-- Pet
		elseif Pet:IsActive() and SourceGUID == UnitGUID("pet") then
            if TriggerGCD[SpellID] then
                tableinsert(Prev.PetGCD, 1, SpellID)
                Prev.PetOffGCD = {}
            else -- Prevents unwanted spells to be registered as OffGCD.
                tableinsert(Prev.PetOffGCD, 1, SpellID)
            end		    
        end
    end

    -- Player Start Cast prediction
    if Event == "SPELL_CAST_START" and SourceGUID == UnitGUID("player") and TriggerGCD[SpellID] then
        PrevGCDPredicted = SpellID
    end

    -- Player Cast Failed prediction
    if Event == "SPELL_CAST_FAILED" and SourceGUID == UnitGUID("player") and PrevGCDPredicted == SpellID then
        PrevGCDPredicted = 0
    end
	
    RemoveOldRecords()	
end
A.Listener:Add("ACTION_EVENT_PREV_GCD_SPELLS", "COMBAT_LOG_EVENT_UNFILTERED", COMBAT_LOG_EVENT_UNFILTERED)


------------------------------------
--------------- API ----------------
------------------------------------

-- Filter the Enum TriggerGCD table to keep only registered spells for a given class (based on SpecID).
function Player:FilterTriggerGCD(SpecID)
    local RegisteredSpells = {}
    local BaseTriggerGCD = A.Enum.TriggerGCD -- In case FilterTriggerGCD is called multiple time, we take the Enum table as base.
    -- Fetch current action player spec spells during the init
    for Spec, Spells in pairs(Action[Action.PlayerSpec]) do
        for _, Spell in pairs(Spells) do
            local SpellID = Spell.SpellID
            local TriggerGCDInfo = BaseTriggerGCD[SpellID]
            if TriggerGCDInfo ~= nil then
                RegisteredSpells[SpellID] = (TriggerGCDInfo > 0)
            end
        end
    end
    -- Add Spells based on the Whitelist
    for SpellID, Value in pairs(Custom.Whitelist) do
        RegisteredSpells[SpellID] = Value
    end
    -- Remove Spells based on the Blacklist
    for i = 1, #Custom.Blacklist do
        local SpellID = Custom.Blacklist[i]
        if RegisteredSpells[SpellID] then
            RegisteredSpells[SpellID] = nil
        end
    end
    TriggerGCD = RegisteredSpells
end

-- Add spells in the Trigger GCD Whitelist (potion, non native class spells)
function A:AddToTriggerGCD(Value)
    if type(Value) ~= "boolean" then Action.Print("You must give a boolean as argument.") end
    Custom.Whitelist[self.SpellID] = Value
end

-- Add spells in the Trigger GCD Blacklist 
function A:RemoveFromTriggerGCD()
    tableinsert(Custom.Blacklist, self.SpellID)
end

-- Simc reference: "prev_gcd.x.foo"
function Player:PrevGCD(Index, Spell)
    if Index > LastRecord then Action.Print("Only the last " .. LastRecord .. " GCDs can be checked.") end
    if Spell then
        return Prev.GCD[Index] == Spell.SpellID
    else
        return Prev.GCD[Index]
    end
end

-- Player:PrevGCD with cast start prediction
function Player:PrevGCDP(Index, Spell, ForcePred)
    if Index > LastRecord then Action.Print("Only the last " .. (LastRecord) .. " GCDs can be checked.") end
    if PrevGCDPredicted > 0 and Index == 1 or ForcePred then
        return PrevGCDPredicted == Spell.SpellID
    elseif PrevGCDPredicted > 0 then
        return Player:PrevGCD(Index - 1, Spell)
    else
        return Player:PrevGCD(Index, Spell)
    end
end

-- Simc reference: "prev_off_gcd.x.foo"
function Player:PrevOffGCD(Index, Spell)
    if Index > LastRecord then Action.Print("Only the last " .. LastRecord .. " OffGCDs can be checked.") end
    return Prev.OffGCD[Index] == Spell.SpellID
end

-- Player:PrevOffGCD with cast start prediction
function Player:PrevOffGCDP(Index, Spell)
    if Index > LastRecord then Action.Print("Only the last " .. (LastRecord) .. " GCDs can be checked.") end
    if PrevGCDPredicted > 0 and Index == 1 then
        return false
    elseif PrevGCDPredicted > 0 then
        return Player:PrevOffGCD(Index - 1, Spell)
    else
        return Player:PrevOffGCD(Index, Spell)
    end
end

-- Simc reference: "pet.prev_gcd.x.foo"
function Pet:PrevGCD(Index, Spell)
    if Index > LastRecord then Action.Print("Only the last " .. LastRecord .. " GCDs can be checked.") end
    return Prev.PetGCD[Index] == Spell.SpellID
end

-- "pet.prev_off_gcd.x.foo"
function Pet:PrevOffGCD(Index, Spell)
    if Index > LastRecord then Action.Print("Only the last " .. LastRecord .. " OffGCDs can be checked.") end
    return Prev.PetOffGCD[Index] == Spell.SpellID
end
