---------------------------------------------------
-------------- CUSTOM STUFF FUNCTIONS -------------
---------------------------------------------------
local TMW                                   = TMW
local A     								= Action
local TeamCache								= Action.TeamCache
local EnemyTeam								= Action.EnemyTeam
local FriendlyTeam							= Action.FriendlyTeam
local LoC									= Action.LossOfControl
local Player								= Action.Player 
local MultiUnits							= Action.MultiUnits
local UnitCooldown							= Action.UnitCooldown
local ActiveUnitPlates						= MultiUnits:GetActiveUnitPlates()
local next, pairs, type, print              = next, pairs, type, print
local IsActionInRange, GetActionInfo, PetHasActionBar, GetPetActionsUsable, GetSpellInfo = IsActionInRange, GetActionInfo, PetHasActionBar, GetPetActionsUsable, GetSpellInfo
local UnitLevel, UnitPower, UnitPowerMax, UnitStagger, UnitAttackSpeed, UnitRangedDamage, UnitDamage, UnitAura = UnitLevel, UnitPower, UnitPowerMax, UnitStagger, UnitAttackSpeed, UnitRangedDamage, UnitDamage, UnitAura
local UnitIsPlayer, UnitExists, UnitGUID    = UnitIsPlayer, UnitExists, UnitGUID
--local Pet                                 = LibStub("PetLibrary") Don't work. Too fast loading snippets ?
local LibToast                              = LibStub("LibToast-1.0", true)
local LibWindow                             = LibStub("LibWindow-1.1")
local Unit                                  = Action.Unit 
local huge                                  = math.huge
local UnitBuff                              = _G.UnitBuff
local EventFrame                            = CreateFrame("Frame", "Taste_EventFrame", UIParent)
local UnitIsUnit                            = UnitIsUnit
local StdUi                                 = Action.StdUi -- Custom StdUI with Action shared settings
-- Lua methods
local error                                 = error
local setmetatable 						    = setmetatable
local stringformat 						    = string.format
local tableinsert 						    = table.insert
local tableremove							= table.remove 
local _G = getfenv(0)

local math = _G.math
local string = _G.string
local table = _G.table

local pairs = _G.pairs
local tonumber = _G.tonumber
local tostring = _G.tostring

-- Local Tables
local Events = {}             -- All Events
local CombatEvents = {}       -- Combat Log Unfiltered
local SelfCombatEvents = {}   -- Combat Log Unfiltered with SourceGUID == PlayerGUID filter
local PetCombatEvents = {}    -- Combat Log Unfiltered with SourceGUID == PetGUID filter
local PrefixCombatEvents = {}
local SuffixCombatEvents = {}
-- Global TasteRotation Table
Action.TasteRotation = {}
local TR                                    = Action.TasteRotation
-- Global Tables
TR.Enum = {}
TR.Lists = {}
TR.storedTables = {}

-------------------------------------------------------------------------------
-- UI Toggles
-------------------------------------------------------------------------------
-- AoE Status on Main Icon
function Action.AoEToggleMode()
    Action.UseAoE = Action.GetToggle(2, "AoE")    
    if Action.UseAoE == false then 
        Action.UseAoE = true
    else
        Action.UseAoE = false
    end
    Action.SetToggle({2, "AoE"})        
    Action.Print(Action.UseAoE and "Mode AoE: On" or not Action.UseAoE and "Mode AoE: Off")
    TMW:Fire("TMW_ACTION_AOE_MODE_CHANGED")
end 

------------------------------------
--- Area Time To Die
------------------------------------
--@return current average AoE time to die 
function Player:AreaTTD(range)
    local ttdtotal = 0
    local totalunits = 0
	local r = range
	
	for _, unitID in pairs(ActiveUnitPlates) do 
	    if Unit(unitID):GetRange() <= r then 
            local ttd = Unit(unitID):TimeToDie()
            totalunits = totalunits + 1
            ttdtotal = ttd + ttdtotal
		end
    end
	
    if totalunits == 0 then
        return 0
    end

    return ttdtotal / totalunits
end

-----------------------------------
-- Trinkets
-----------------------------------
-- List all BlackListed Trinkets we dont want to use on cooldown but with some specific APLs.
local BlackListedTrinkets = {

    [1] = 168905, -- Shiver Venom Relic
	[2] = 169314, -- Azsharas Font of Power
    [3] = 169311, -- AshvanesRazorCoral
	[4] = 174044, -- Humming Black Dragonscale
	[5] = 158367, -- MerekthasFang

}

function TR:TrinketIsAllowed()
    local Trinket1IsAllowed = true
	local Trinket2IsAllowed = true
     
   	    for i = 1, #BlackListedTrinkets do
            if Action.Trinket1.ID == BlackListedTrinkets[i] then
                Trinket1IsAllowed = false				
			end
            if Action.Trinket2.ID == BlackListedTrinkets[i] then
                Trinket2IsAllowed = false					
            end
        end
	return Trinket1IsAllowed, Trinket2IsAllowed
end
    
-- Trinkets checker
function TR:TrinketON()
  return ( (Action.GetToggle(1, "Trinkets")[1]) or (Action.GetToggle(1, "Trinkets")[2]) )
end

------------------------------------
--- RegisterDamage simc reference
------------------------------------
-- Register the spell damage formula.
function A:RegisterDamage(Function)
    self.DamageFormula = Function
end

-- Get the spell damage formula if it exists.
function A:Damage()
    return self.DamageFormula and self.DamageFormula() or 0
end

-- attack_power
function A.Player:AttackPower()
    return UnitAttackPower("player")
end

-- AttackPowerDamageMod
function A.Player:AttackPowerDamageMod(offHand)
    local useOH = offHand or false
    local wdpsCoeff = 6
    local ap = Player:AttackPower()
    local minDamage, maxDamage, minOffHandDamage, maxOffHandDamage, physicalBonusPos, physicalBonusNeg, percent = UnitDamage(self.UnitID)
    local speed, offhandSpeed = UnitAttackSpeed(self.UnitID)
    if useOH and offhandSpeed then
        local wSpeed = offhandSpeed * (1 + Player:HastePct() / 100)
        local wdps = (minOffHandDamage + maxOffHandDamage) / wSpeed / percent - ap / wdpsCoeff
            return (ap + wdps * wdpsCoeff) * 0.5
    else
        local wSpeed = speed * (1 + Player:HastePct() / 100)
        local wdps = (minDamage + maxDamage) / 2 / wSpeed / percent - ap / wdpsCoeff
        return ap + wdps * wdpsCoeff
    end
end

------------------------------------
--- HasHeroism simc reference
------------------------------------
local HeroismBuff = { 
    [2825] =  true, -- Bloodlust Horde 
    [32182] =  true, -- Heroism Ally  		
    [90355] =  true, -- Ancient Hysteria
    [160452] =  true, -- Netherwinds
    [80353] =  true, -- Time Warp
    [178207] =  true, -- Drums of Fury
    [35475] =  true, -- Drums of War
    [230935] =  true, -- Drums of Montain
    [256740] =  true, -- Drums of Maelstrom
    --[974] =  true, -- Test Earth Shield
}

function Unit:HasHeroism()
    local unitID = self.UnitID
    -- @return boolean 
    local spellId 
    for i = 1, huge do 
        name,_,_,_,_,_,_,_,_,spellId = UnitBuff(unitID, i, "HELPFUL")
        if not spellId  then 
            break 
        elseif HeroismBuff[spellId] then 
            return true 
        end 
    end 
	return false
end 

------------------------------------
--- Corruption API patch 8.3
------------------------------------
-- Return current Corruption amount (Total - Resistance)
function Player:GetCurrentCorruption()
    local TotalCorruption = GetCorruption()
    local CorruptionResistance = GetCorruptionResistance()
    return TotalCorruption - CorruptionResistance
end

------------------------------------
--- HasDeBuffsDown simc reference
------------------------------------
function Unit:HasDeBuffsDown(spell, byID)
	local unitID = self.UnitID
	
    return (self(unitID):HasDeBuffs(spell, byID) == 0 and true) or false
end

------------------------------------
--- HasBuffsDown simc reference
------------------------------------
function Unit:HasBuffsDown(spell, byID)
    local unitID = self.UnitID
	
    return (self(unitID):HasBuffs(spell, byID) == 0 and true) or false
end

------------------------------------
--- HasDeBuffsRefreshable simc reference
------------------------------------
function Unit:HasDeBuffsRefreshable(spell, byID)
    local unitID = self.UnitID
	
    return (self(unitID):HasDeBuffs(spell, byID) < 5 or self(unitID):HasDeBuffsDown(spell, byID) and true) or false
end

-------------------------------------------------------------------------------
-- Multiunits
-------------------------------------------------------------------------------
function Action.MultiUnits.GetByRangeDoTsToRefresh(self, range, count, deBuffs, refreshTime, upTTD)
	-- @return number
	-- @usage A.MultiUnits:GetByRangeDoTsToRefresh(@number, @number, @table or @number, @number, @number)
	-- deBuffs is required, refreshTime too, rest options are optimal
	local total = 0
	local nameplates = self:GetActiveUnitPlates()
	
	if nameplates then 
		for unitID in pairs(nameplates) do 
			if Unit(unitID):CombatTime() > 0 and (not range or Unit(unitID):CanInterract(range)) and (not upTTD or Unit(unitID):TimeToDie() >= upTTD) and Unit(unitID):HasDeBuffs(deBuffs, true) <= refreshTime then 
				total = total + 1
			end 
			
			if count and total >= count then 
				break 
			end 
		end 
	end 
	
	return total 
end 
Action.MultiUnits.GetByRangeDoTsToRefresh = Action.MakeFunctionCachedDynamic(Action.MultiUnits.GetByRangeDoTsToRefresh)

-------------------------------------------------------------------------------
-- Event register
-------------------------------------------------------------------------------
-- Register a handler for an event.
-- @param Handler The handler function.
-- @param Events The events name.
function Action:RegisterForEvent(Handler, ...)
    local EventsTable = { ... }
    for i = 1, #EventsTable do
        local Event = EventsTable[i]
        if not Events[Event] then
            Events[Event] = { Handler }
            EventFrame:RegisterEvent(Event)
        else
            tableinsert(Events[Event], Handler)
        end
    end
end

-- Register a handler for a combat event.
-- @param Handler The handler function.
-- @param Events The events name.
function Action:RegisterForCombatEvent(Handler, ...)
    local EventsTable = { ... }
    for i = 1, #EventsTable do
        local Event = EventsTable[i]
        if not CombatEvents[Event] then
            CombatEvents[Event] = { Handler }
        else
            tableinsert(CombatEvents[Event], Handler)
        end
    end
end

-- Register a handler for a self combat event.
-- @param Handler The handler function.
-- @param Events The events name.
function Action:RegisterForSelfCombatEvent(Handler, ...)
    local EventsTable = { ... }
    for i = 1, #EventsTable do
        local Event = EventsTable[i]
        if not SelfCombatEvents[Event] then
            SelfCombatEvents[Event] = { Handler }
        else
            tableinsert(SelfCombatEvents[Event], Handler)
        end
    end
end

local function removeLastChar(text)
	return text:sub(1, -2)
end

--[[*
  * @mixin HL.OffsetRemains
  * @desc Apply an offset to an expiration time.
  *
  * @param {number} ExpirationTime - The expiration time to apply the offset on.
  * @param {string|number} Offset - The offset to apply, can be a string for a known method or directly the offset value in seconds.
  *
  * @returns {number}
  *]]
function Action.OffsetRemains(ExpirationTime, Offset)
    if type(Offset) == "number" then
        ExpirationTime = ExpirationTime - Offset
    elseif type(Offset) == "string" then
        local CastRemains = Player:CastRemains()
        local GCDRemains = Player:GCDRemains()
        if Offset == "GCDRemains" then
            ExpirationTime = ExpirationTime - GCDRemains
        elseif Offset == "CastRemains" then
            ExpirationTime = ExpirationTime - CastRemains
        elseif Offset == "Auto" then
            ExpirationTime = ExpirationTime - math.max(GCDRemains, CastRemains)
        end
    else
        error("Invalid Offset.")
    end
    return ExpirationTime
end

--------------------------------------
--------- Action Status Frame --------
--------------------------------------
--- Draw a dynamic list based on current Blocked spells
--- Future will add Queued frame and maybe other options depending on users feedbacks

TR.BlockedListAssoc				= {}
TR.BlockedListArray 			= {}
TR.BlockedListIcon   			= {}

local pairs, next, type, wipe	= pairs, next, type, wipe
local hooksecurefunc 			= hooksecurefunc
local isHooked					-- nil 

local L 						= {
	enUS 						= "No blocked actions :)",
	frFR 						= "Aucune action bloquée :)",
	ruRU						= "Нет заблокированных действий :)",
}

local function GetActionSpellStatus(this)
	if not this then 
		wipe(TR.BlockedListAssoc)
		
		if Action[Action.PlayerSpec] then 
			for k, v in pairs(Action[Action.PlayerSpec]) do 
				if type(v) == "table" and v.Type and v:IsBlocked() then 	
					TR.BlockedListAssoc[k] = v
				end 
			end 
		end 
	else 
		local k = this:GetKeyName()
		if k then 
			if this:IsBlocked() then 
				TR.BlockedListAssoc[k] = this 
			else 
				TR.BlockedListAssoc[k] = nil 
			end 
		end 
	end 
	
	wipe(TR.BlockedListArray)
	wipe(TR.BlockedListIcon)
	for k, v in pairs(TR.BlockedListAssoc) do 
		TR.BlockedListArray[#TR.BlockedListArray + 1] = k --.. " " .. (v.Desc or "") .. " " .. (v.Color or "")
		TR.BlockedListIcon[#TR.BlockedListIcon + 1] = v:Icon()
	end 
	
	TMW:Fire("TMW_ACTION_STATUS_BLOCKED_CHANGED")
end

local function OnCallback()
	GetActionSpellStatus()
end 

-- Finally, callbackEvent on init
TMW:RegisterCallback("TMW_ACTION_IS_INITIALIZED", function(callbackEvent) 
	if Action.CurrentProfile:match("Taste") then 
		GetActionSpellStatus()
		if not isHooked then 
			TMW:RegisterCallback("TMW_ACTION_PLAYER_SPECIALIZATION_CHANGED", OnCallback, "TASTE_BLOCKED_TRACKER")
			isHooked = true 
		end 
	else
		if isHooked then 
			wipe(TR.BlockedListAssoc)
			wipe(TR.BlockedListArray)
			wipe(TR.BlockedListIcon)
			TMW:UnregisterCallback("TMW_ACTION_PLAYER_SPECIALIZATION_CHANGED", OnCallback, "TASTE_BLOCKED_TRACKER")
			TMW:Fire("TMW_ACTION_STATUS_BLOCKED_CHANGED")			
			isHooked = nil
		end 
	end 
end)

--------------------------------------
--------- StdUI Status Frame ---------
--------------------------------------
Action.StatusFrame = StdUi:Window(UIParent, 120, 150, "-- Blocked Spells --");
Action.StatusFrame.titlePanel.label:SetFontSize(14)
Action.StatusFrame.default_w = Action.StatusFrame:GetWidth()
Action.StatusFrame.default_h = Action.StatusFrame:GetHeight() 
Action.StatusFrame.titlePanel:SetPoint("TOP", 0, -10)
Action.StatusFrame:SetFrameStrata("HIGH")
Action.StatusFrame:SetPoint("CENTER")
Action.StatusFrame:SetShown(false) 

-- Test refresh button
--local btn = StdUi:Button(StatusFrame, 100, 24, 'Refresh Data');
--StdUi:GlueTop(btn, StatusFrame, 0, -40);

local data = {};
local columns = {
	{
		name         = 'Name',
		width        = 70,
		defaultwidth = 70,
		align        = 'LEFT',
		index        = 'name',
		format       = 'string',
	},
    {
		name         = '',
		width        = 20,
		defaultwidth = 20,
		align        = 'RIGHT',
		index        = 'icon',
		format       = 'icon',
	},
}

local customHeight = 5

local StatusFrameScrollTable = StdUi:ScrollTable(Action.StatusFrame, columns, customHeight, 15);
StatusFrameScrollTable:EnableSelection(true);
StatusFrameScrollTable:SetResizable(true)
StdUi:GlueTop(StatusFrameScrollTable, Action.StatusFrame, 0, -50);
StatusFrameScrollTable.defaultrows = { numberOfRows = StatusFrameScrollTable.numberOfRows, rowHeight = StatusFrameScrollTable.rowHeight }

function Action.StatusFrame.UpdateResize()
    --StatusFrameScrollTable:SetWidth(Action.StatusFrame:GetWidth() - 50 )
    --StatusFrameScrollTable:SetHeight(Action.StatusFrame:GetHeight() ) 
	-- ScrollTable
	if StatusFrameScrollTable.columns then 
		for i = 1, #StatusFrameScrollTable.columns do 										
			if StatusFrameScrollTable.columns[i].index == "name" then
				-- Column by Name resize
				StatusFrameScrollTable.columns[i].width = round(StatusFrameScrollTable.columns[i].defaultwidth + (Action.StatusFrame:GetWidth() - Action.StatusFrame.default_w - 1), 0)
				StatusFrameScrollTable:SetColumns(StatusFrameScrollTable.columns)	
				-- Row resize
				StatusFrameScrollTable.numberOfRows = StatusFrameScrollTable.defaultrows.numberOfRows + round((Action.StatusFrame:GetHeight() - Action.StatusFrame.default_h + 10) / StatusFrameScrollTable.defaultrows.rowHeight, 0)
				StatusFrameScrollTable:SetDisplayRows(StatusFrameScrollTable.numberOfRows, StatusFrameScrollTable.defaultrows.rowHeight)
				break 
			end 
		end
	end 
end

Action.StatusFrame:HookScript("OnSizeChanged", Action.StatusFrame.UpdateResize)

local function UpdateTableData()
	data = {};

	for i = 1, #TR.BlockedListArray do
		local r = {name = TR.BlockedListArray[i] or (L[Action.GetCL()] or L.enUS), icon = TR.BlockedListIcon[i] or 841383}
		-- index
		r.i = i;
		tableinsert(data, r);
	end

	-- update scroll table data
	StatusFrameScrollTable:SetData(data);
end

--btn:SetScript('OnClick', UpdateTableData)

hooksecurefunc(Action, "SetBlocker", function(this)
	if isHooked then 
		GetActionSpellStatus(this)
		UpdateTableData()
		
	end 
end)

function TR.ToggleStatusFrame()
	if not Action.PlayerSpec or (not Action.MainUI and not Action.IsInitialized) then 
		return 
	end 
	
	if Action.StatusFrame:IsShown() then 
	    UpdateTableData()
		customHeight = #TR.BlockedListArray or 5
		Action.StatusFrame:SetShown(not Action.StatusFrame:IsShown())
		Action.StatusFrame.resizer = Action.CreateResizer(Action.StatusFrame)
		return
	else 
	    UpdateTableData()
		customHeight = #TR.BlockedListArray or 5
		Action.StatusFrame:SetShown(not Action.StatusFrame:IsShown())
        Action.StatusFrame.resizer = Action.CreateResizer(Action.StatusFrame)		
	end 
	
end

--------------------------------------------------------
----------- DOGTAG CALL FOR STATUS FRAME ---------------
--------------------------------------------------------
-- Replaced by StdUI code as of 24/03/2020 but still working if someone wants to use it through TMW DogTags
local DogTag = LibStub("LibDogTag-3.0", true)
TMW:RegisterCallback("TMW_ACTION_STATUS_BLOCKED_CHANGED",  	DogTag.FireEvent, DogTag)
if DogTag then 
	-- Status Frame Blocked Spells
	DogTag:AddTag("TMW", "ActionStatusBlockedSpell", {
		code = function()
			if #TR.BlockedListArray > 0 then
			    for i = 1, #TR.BlockedListArray do
				    return TR.BlockedListArray[i]
				end
			else
				return L[Action.GetCL()] or L.enUS
			end
		end,
		ret = "string",
		doc = "Displays Blocked Spells Icon",
		example = '[ActionStatusFrame] => "TR.BlockedListArray.icon"',
		events = "TMW_ACTION_STATUS_BLOCKED_CHANGED",
		category = "Action",
	})	
	-- Status Frame Blocked Spells Icon
	DogTag:AddTag("TMW", "ActionStatusBlockedIcon", {
		code = function()
			if #TR.BlockedListIcon > 0 then
			    for i = 1, #TR.BlockedListIcon do
				    return TR.BlockedListIcon[i]
				end
			else
				return L[Action.GetCL()] or L.enUS
			end
		end,
		ret = "string",
		doc = "Displays Blocked Spells",
		example = '[ActionStatusFrame] => "TR.BlockedListArray.spellname"',
		events = "TMW_ACTION_STATUS_BLOCKED_CHANGED",
		category = "Action",
	})
end 

			
-- Using LibToast v0.1
LibToast:Embed(Action)

-- Creates a template called "UrgencyToast" which sets the text to whatever
local function CloseToast()
end

A:RegisterToast("UrgencyToast", function(toast, message, icon)
    local icontexture = GetSpellTexture(icon)
    --toast:SetTitle(" ") -- Do we really need title ? Lets see later
    toast:SetText(message)
    toast:SetIconTexture(icontexture)
	toast:SetUrgencyLevel("emergency") 
	toast:SetTextFont("Fonts\\ARIALN.ttf", 25)
	--toast:SetFormattedText("FriendsFont_Large", message)
    --toast:MakePersistent()
    --toast:SetPrimaryCallback(_G.OKAY, CloseToast)
end)
-- /run Action:SpawnToast("UrgencyToast", "Urgency!!!", 22812)

------------------------------------
--------- NOTIFICATIONS API --------
------------------------------------
-- !!! DEPRECATED !!! --
-- Return a tost notification directly in game with status information from rotation. Useful for custom events announcer    
-- @Parameters : Message and Spell are mandatory settings. 
-- @optional Parameters : Delay and incombat can be nil 
-- @NEW : Now support differents type of notifications to differents frames with the parameter : "reason" - possible values : {Defensive, Urgency, KickCC, Lockout, General}
-- Usage : /run Action.SendNotification("test", 22812, 2, false, "Urgency")    
function Action.SendNotification(message, spell, delay, incombat, reason)
    local DelaySetting = Action.GetToggle(2, "AnnouncerDelay")
    local InCombatSetting = Action.GetToggle(2, "AnnouncerInCombatOnly")
    local Enabled = Action.GetToggle(2, "UseAnnouncer")
    
    if not message then
        Action.Print("You didn't set any message for Notification.(Parameter #1)")
    end
	
    if not spell then
        Action.Print("You didn't set any spell icon for Notification.(Parameter #2)")
    end  
	
	if reason == nil then
	    reason = "General"
	end
	
    if not delay then
        if DelaySetting then 
            delay = DelaySetting
        else
            delay = 2
        end
    end
    
    if not incombat then
        if InCombatSetting then 
            incombat = InCombatSetting
        else        
            incombat = false
        end
    else
        incombat = true
    end
    
    -- Locals Variables
    local timer = TMW.time
    local endtimer = timer + delay 
	-- Globals vars
    Action.NotificationIsValid = false
    Action.NotificationIsValidUntil = endtimer
    Action.NotificationReason = reason
	
	-- Globals vars by reason
    -- @General	
    Action.NotificationMessageGeneral = ""
    Action.CurrentNotificationIconGeneral = GetSpellTexture(spell)
	
    -- @KickCC	
    Action.NotificationMessageKickCC = ""
    Action.CurrentNotificationIconKickCC = GetSpellTexture(spell)
	
    -- @Lockout	
    Action.NotificationMessageLockout = ""
    Action.CurrentNotificationIconLockout = GetSpellTexture(spell)

    -- @Defensive	
    Action.NotificationMessageDefensive = ""
    Action.CurrentNotificationIconDefensive = GetSpellTexture(spell)
	
    -- @Urgency	
    Action.NotificationMessageUrgency = ""
    Action.CurrentNotificationIconUrgency = GetSpellTexture(spell)
	
    -- Check if overlay enabled by user
    if Enabled then
        -- Option 1 : Combat only        
        if message and spell and incombat then 
            if (TMW.time <= endtimer) and Unit("player"):CombatTime() > 0 then 
                Action.NotificationIsValid = true
				-- KickCC reason
				if reason == "KickCC" then
                    Action.NotificationMessageKickCC = message 
                -- Lockout reason					
                elseif reason == "Lockout" then
				    Action.NotificationMessageLockout = message
                -- Urgency reason					
                elseif reason == "Urgency" then
				    Action.NotificationMessageUrgency = message
                -- Defensive reason					
                elseif reason == "Defensive" then
				    Action.NotificationMessageDefensive = message
                -- General reason					
				else
				    Action.NotificationMessageGeneral = message 
				end              
            else
                Action.NotificationIsValid = false
            end
        -- Option 2 : Everytime
        elseif message and spell and not incombat then     
            if TMW.time <= endtimer then 
                Action.NotificationIsValid = true
				-- KickCC reason
				if reason == "KickCC" then
                    Action.NotificationMessageKickCC = message 
                -- Lockout reason					
                elseif reason == "Lockout" then
				    Action.NotificationMessageLockout = message
                -- Urgency reason					
                elseif reason == "Urgency" then
				    Action.NotificationMessageUrgency = message
                -- Defensive reason					
                elseif reason == "Defensive" then
				    Action.NotificationMessageDefensive = message
                -- General reason					
				else
				    Action.NotificationMessageGeneral = message 
				end   
            else
                Action.NotificationIsValid = false
            end
        end
    end
	
	-- Fire DogTag event
    TMW:Fire("TMW_ACTION_NOTIFICATION")
	
    -- KickCC frame
    if reason == "KickCC" then
        return Action.NotificationMessageKickCC, Action.CurrentNotificationIconKickCC, Action.NotificationIsValid, Action.NotificationIsValidUntil
	-- Lockout frame
    elseif reason == "Lockout" then
	    return Action.NotificationMessageLockout, Action.CurrentNotificationIconLockout, Action.NotificationIsValid, Action.NotificationIsValidUntil
	-- Urgency frame
    elseif reason == "Urgency" then
	    return Action.NotificationMessageUrgency, Action.CurrentNotificationIconUrgency, Action.NotificationIsValid, Action.NotificationIsValidUntil
	-- Defensive frame
    elseif reason == "Defensive" then
	    return Action.NotificationMessageDefensive, Action.CurrentNotificationIconDefensive, Action.NotificationIsValid, Action.NotificationIsValidUntil
	-- General Frame
	else
	    return Action.NotificationMessageGeneral, Action.CurrentNotificationIconGeneral, Action.NotificationIsValid, Action.NotificationIsValidUntil
	end
end  			

------------------------------------
-- DogTags
------------------------------------
-- Taste's 
TMW:RegisterCallback("TMW_ACTION_NOTIFICATION", DogTag.FireEvent, DogTag)

if DogTag then
    
	------------------
	---- GENERAL -----
	------------------
	
	-- Custom Icon 
	DogTag:AddTag("TMW", "ActionNotificationIconGeneral", {
        code = function()
			if Action.CurrentNotificationIconGeneral and Action.NotificationIsValid then
				return Action.CurrentNotificationIconGeneral
			else 
				return ""
			end 
        end,
        ret = "string",
        doc = "Displays General Notification Icon",
		example = '[ActionNotification] => "Action.SendNotification(message, spell, delay)"',
        events = "TMW_ACTION_NOTIFICATION",
        category = "Action",
    })

	-- Custom Notifications
	DogTag:AddTag("TMW", "ActionNotificationMessageGeneral", {
        code = function()
			if Action.NotificationMessageGeneral and Action.NotificationIsValid then				
				return Action.NotificationMessageGeneral
			else 
				return ""
			end 
        end,
        ret = "string",
        doc = "Displays General Notification Message",
		example = '[ActionNotification] => "Action.SendNotification(message, spell, delay)"',
        events = "TMW_ACTION_NOTIFICATION",
        category = "Action",
    })	

	--------------------
	---- KICKS & CC ----
	--------------------
	
	-- Custom Icon 
	DogTag:AddTag("TMW", "ActionNotificationIconKickCC", {
        code = function()
			if Action.CurrentNotificationIconKickCC and Action.NotificationIsValid then
				return Action.CurrentNotificationIconKickCC
			else 
				return ""
			end 
        end,
        ret = "string",
        doc = "Displays KickCC Notification Icon",
		example = '[ActionNotification] => "Action.SendNotification(message, spell, delay)"',
        events = "TMW_ACTION_NOTIFICATION",
        category = "Action",
    })

	-- Custom Notifications
	DogTag:AddTag("TMW", "ActionNotificationMessageKickCC", {
        code = function()
			if Action.NotificationMessageKickCC and Action.NotificationIsValid then				
				return Action.NotificationMessageKickCC
			else 
				return ""
			end 
        end,
        ret = "string",
        doc = "Displays KickCC Notification Message",
		example = '[ActionNotification] => "Action.SendNotification(message, spell, delay)"',
        events = "TMW_ACTION_NOTIFICATION",
        category = "Action",
    })	

	------------------
	---- LOCKOUT -----
	------------------
	
	-- Custom Icon 
	DogTag:AddTag("TMW", "ActionNotificationIconLockout", {
        code = function()
			if Action.CurrentNotificationIconLockout and Action.NotificationIsValid then
				return Action.CurrentNotificationIconLockout
			else 
				return ""
			end 
        end,
        ret = "string",
        doc = "Displays Lockout Notification Icon",
		example = '[ActionNotification] => "Action.SendNotification(message, spell, delay)"',
        events = "TMW_ACTION_NOTIFICATION",
        category = "Action",
    })

	-- Custom Notifications
	DogTag:AddTag("TMW", "ActionNotificationMessageLockout", {
        code = function()
			if Action.NotificationMessageLockout and Action.NotificationIsValid then				
				return Action.NotificationMessageLockout
			else 
				return ""
			end 
        end,
        ret = "string",
        doc = "Displays Lockout Notification Message",
		example = '[ActionNotification] => "Action.SendNotification(message, spell, delay)"',
        events = "TMW_ACTION_NOTIFICATION",
        category = "Action",
    })		

	------------------
	---- DEFENSIVE ----
	------------------
	
	-- Custom Icon 
	DogTag:AddTag("TMW", "ActionNotificationIconDefensive", {
        code = function()
			if Action.CurrentNotificationIconDefensive and Action.NotificationIsValid then
				return Action.CurrentNotificationIconDefensive
			else 
				return ""
			end 
        end,
        ret = "string",
        doc = "Displays Defensive Notification Icon",
		example = '[ActionNotification] => "Action.SendNotification(message, spell, delay)"',
        events = "TMW_ACTION_NOTIFICATION",
        category = "Action",
    })

	-- Custom Notifications
	DogTag:AddTag("TMW", "ActionNotificationMessageDefensive", {
        code = function()
			if Action.NotificationMessageDefensive and Action.NotificationIsValid then				
				return Action.NotificationMessageDefensive
			else 
				return ""
			end 
        end,
        ret = "string",
        doc = "Displays Defensive Notification Message",
		example = '[ActionNotification] => "Action.SendNotification(message, spell, delay)"',
        events = "TMW_ACTION_NOTIFICATION",
        category = "Action",
    })	
	
	------------------
	---- URGENCY -----
	------------------
	
	-- Custom Icon 
	DogTag:AddTag("TMW", "ActionNotificationIconUrgency", {
        code = function()
			if Action.CurrentNotificationIconUrgency and Action.NotificationIsValid then
				return Action.CurrentNotificationIconUrgency
			else 
				return ""
			end 
        end,
        ret = "string",
        doc = "Displays Urgency Notification Icon",
		example = '[ActionNotification] => "Action.SendNotification(message, spell, delay)"',
        events = "TMW_ACTION_NOTIFICATION",
        category = "Action",
    })

	-- Custom Notifications
	DogTag:AddTag("TMW", "ActionNotificationMessageUrgency", {
        code = function()
			if Action.NotificationMessageUrgency and Action.NotificationIsValid then				
				return Action.NotificationMessageUrgency
			else 
				return ""
			end 
        end,
        ret = "string",
        doc = "Displays Urgency Notification Message",
		example = '[ActionNotification] => "Action.SendNotification(message, spell, delay)"',
        events = "TMW_ACTION_NOTIFICATION",
        category = "Action",
    })	
	
	-- The biggest problem of TellMeWhen what he using :setup on frames which use DogTag and it's bring an error
	TMW:RegisterCallback("TMW_ACTION_IS_INITIALIZED", function()
		TMW:Fire("TMW_ACTION_NOTIFICATION")
	end)
end
