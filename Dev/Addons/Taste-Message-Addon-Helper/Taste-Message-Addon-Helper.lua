-- Addon by Tastemylock
-- Update: 30-07-2019

TasteMsgAddonHelper = LibStub("AceAddon-3.0"):NewAddon("TasteMsgAddonHelper", "AceConsole-3.0", "AceEvent-3.0", "AceTimer-3.0", "AceComm-3.0", "AceSerializer-3.0")
local L = LibStub("AceLocale-3.0"):GetLocale("TasteMsgAddonHelper", true)
local LibC = LibStub:GetLibrary("LibCompress")
local LibCE = LibC:GetAddonEncodeTable()
local addonName, addon = ...
local TasteMsgAddonHelperLDB = LibStub("LibDataBroker-1.1"):NewDataObject("TasteMsgAddonHelper", {
	type = "launcher",
	label = "Taste Silas Helper",
	icon = "Interface\\Icons\\Trade_alchemy_potione1",
	OnClick = function(self, button)
	    print("Taste Silas Helper loaded.")
        InterfaceOptionsFrame_OpenToCategory(TasteMsgAddonHelper.configFrame)
		InterfaceOptionsFrame_OpenToCategory(TasteMsgAddonHelper.configFrame)
    end,
})
local icon = LibStub("LibDBIcon-1.0")
local debug = false
local playername = ''
local player_class = UnitClass("player")
local default_whisper = "Sorry mate but no Silas up yet :("

-- init function
function isReady()
    return true
end

-- return boolean for current receiver alchemist
function SilasBuffIsUp()	
    local SilasBuffId = 293945
	for i = 1, 40 do
	    local name, icon, count, debuffType, duration, expirationTime, source, isStealable, nameplateShowPersonal, spellId, canApplyAura, isBossDebuff, castByPlayer, nameplateShowAll, timeMod = UnitBuff("player",i)
        if spellId == SilasBuffId then		
	        return true
	    end
	end
	return false
end

-- return Silas Item duration 
function SilasItemDuration()
    --Silas' Potion of Prosperity buff id
    local SilasItemId = 156633	
	local itemtimeleft = 0
	
	--TODO improve this maybe
    local itemtimeleft = 0
    for i=0,4 do
        for j=1,GetContainerNumSlots(i) do
        local itemID = GetContainerItemID(i,j)
            if itemID then
                GameTooltip:SetOwner(UIParent,"ANCHOR_NONE")
                GameTooltip:SetBagItem(i,j)
                for k = GameTooltip:NumLines(),2,-1 do
                    local timetooltip = (_G["GameTooltipTextLeft"..k]:GetText() or ""):match("Duration: ([%d,]+) min")
                    if timetooltip then
					    --print("Found corresponding tooltip")
                        --timetooltip = timetooltip:gsub(",","")
                        itemtimeleft = itemtimeleft + tonumber(timetooltip)
                    break
                    end
                end
            end
        end
    end
	
    GameTooltip:Hide()
	return itemtimeleft
   --print("Silas Item Time Left:",itemtimeleft)
end
local remain_item_whisper = "Remaining time on Silas item :" .. SilasItemDuration() .. " minutes"

-- return Silas Buff duration 
function SilasBuffDuration()
    --Silas' Potion of Prosperity buff id
    local SilasId = 293946
	local TimeLeft = 0
    for i = 1, 40 do
	    local name, icon, count, debuffType, duration, expirationTime, source, isStealable, nameplateShowPersonal, spellId, canApplyAura, isBossDebuff, castByPlayer, nameplateShowAll, timeMod = UnitBuff("player",i)
        if spellId == SilasId then
	        --Handle conversion to minutes if > 60sec
	        if expirationTime > 0 then 
	            TimeLeft = expirationTime - GetTime()
				--print(TimeLeft)
			else 
			    TimeLeft = 0
			end
		end
	end
	return TimeLeft 
end

local incombat_whisper = "Sorry im currently in fight"
-- get option value
local function GetGlobalOptionLocal(info)
	return TasteMsgAddonHelper.db.global[info[#info]]
end

-- set option value
local function SetGlobalOptionLocal(info, value)
	if debug and TasteMsgAddonHelper.db.global[info[#info]] ~= value then
		TasteMsgAddonHelper:Printf("DEBUG: global option %s changed from '%s' to '%s'", info[#info], tostring(GuildRecr.db.global[info[#info]]), tostring(value))
	end
	TasteMsgAddonHelper.db.global[info[#info]] = value
	LibStub("AceConfigRegistry-3.0"):NotifyChange("TasteMsgAddonHelper")
end

-- declare defaults to be used in the DB
local defaults = {
	global = {
		enabled = isReady(),
		whisper = default_whisper,
        auto_party = false,
		use_msg_addon = false,
		use_guild_channel = false,
        display_whisper_overlay = false,
	}
}

-- Messages to trigger addon
function TasteMsgAddonHelper:ContainsSilasMessages(msg)
  return (
    msg:lower():match('!silas') or 
    msg:lower():match('!pots') or 
	msg:lower():match('!taste') or
	msg:lower():match('!dreitz') or
    msg:lower():match('!potions') or 
	msg:lower():match('!tsh')
	)
end

-- TODO a filter to hide all yelled messaged containing certain text
function NoWhisperWindow(self,event,msg)
  return TasteMsgAddonHelper:ContainsSilasMessages(msg)
end

function InitTextFrame()
    MOD_TextFrame = CreateFrame("Frame");
    MOD_TextFrame:ClearAllPoints();
    MOD_TextFrame:SetHeight(300);
    MOD_TextFrame:SetWidth(300);
    MOD_TextFrame:SetScript("OnUpdate", MOD_TextFrame_OnUpdate);
    MOD_TextFrame:Hide();
    MOD_TextFrame.text = MOD_TextFrame:CreateFontString(nil, "BACKGROUND", "PVPInfoTextFont");
    MOD_TextFrame.text:SetAllPoints();
    MOD_TextFrame:SetPoint("CENTER", 0, 200);
    MOD_TextFrameTime = 0;
end

function MOD_TextFrame_OnUpdate()
  if (MOD_TextFrameTime < GetTime() - 3) then
    local alpha = MOD_TextFrame:GetAlpha();
    if (alpha ~= 0) then MOD_TextFrame:SetAlpha(alpha - .05); end
    if (alpha == 0) then MOD_TextFrame:Hide(); end
  end
end

function MOD_TextMessage(message)
      MOD_TextFrame.text:SetText(message);
      MOD_TextFrame:SetAlpha(1);
      MOD_TextFrame:Show();
      MOD_TextFrameTime = GetTime();
end

-- Option menu (Interface-->Settings)
local options = {
    name = "TasteMsgAddonHelper",
	type = "group",
	childGroups = "tab",
	args = {
		general_tab = {
			name = "Silas Potion of Prosperity",
			type = "group",
			order = 10,
			args = {
				enabled = {
					type = "toggle",
					order = 2,
					name = "Enable Addon",
					desc = "Enable or disable addon functionality.",
					width = "full",
					get =	GetGlobalOptionLocal,
					set =	function (info, value)
								SetGlobalOptionLocal(info, value)
							end
				},
                display_whisper_overlay = 
                {
                   type = "toggle",
					order = 3,
					name = "Enable whisper from player in overlay",
					desc = "Enable or disable get the whisper of the player in an overlay and dissapear in 3 seconds.",
					width = "full",
					get =	GetGlobalOptionLocal,
					set =	function (info, value)
								SetGlobalOptionLocal(info, value)
								if not TasteMsgAddonHelper.db.global.display_whisper_overlay then 
								    print("Desactivated whispers in overlay")
								else
								   print("Activated whispers in overlay")
								end
							end   
                },
                use_guild_channel = 
                {
                   type = "toggle",
					order = 4,
					name = "Enable addon only for guild channel",
					desc = "Enable or disable Guild channel only.",
					width = "full",
					get =	GetGlobalOptionLocal,
					set =	function (info, value)
								SetGlobalOptionLocal(info, value)
								if not TasteMsgAddonHelper.db.global.use_guild_channel then 
								    print("Desactivated Guild channel only")
								else
								   print("Activated Guild channel only")
								end
							end   
                },
                auto_party = 
                {
                   type = "toggle",
					order = 5,
					name = "Enable auto accept party invites.",
					desc = "Enable or disable auto accept party invites.",
					width = "full",
					get =	GetGlobalOptionLocal,
					set =	function (info, value)
								SetGlobalOptionLocal(info, value)
								if not TasteMsgAddonHelper.db.global.auto_party then 
								    print("Desactivated Auto party invite")
								else
								   print("Activated Auto party invite")
								end
							end   
                },
				use_msg_addon = 
                {
                   type = "toggle",
					order = 6,
					name = "[TEST] Enable use of MSG ADDON Channel",
					desc = "[TEST] Enable or disable use of MSG ADDON Channel. Prefix in WA or TMW should be ' TSH '",
					width = "full",
					get =	GetGlobalOptionLocal,
					set =	function (info, value)
								SetGlobalOptionLocal(info, value)
								if not TasteMsgAddonHelper.db.global.use_msg_addon then 
								    print("Desactivated MSG_ADDON")
								else
								   print("Activated MSG_ADDON")
								end
							end   
                },
				whisper = 
				{
					type = "input",
					order = 7,
					name = "Custom Whisp Answer",
					multiline = true,
					desc = "Write your own custom whisp answer message",
					width = "full",
					get = GetGlobalOptionLocal,
					set = function (info, value)
							  SetGlobalOptionLocal(info, value)
						  end
				}
			}
		}
	}	
}

-- get server time in unix timestamp format
local function GetServerTime()
	local weekday, month, day, year = CalendarGetDate()
	local hours, minutes = GetGameTime()
	
	local timeset = { year = year, month = month, day = day, hour = hours, min = minutes }
	
	return time(timeset)
end

local function isempty(s)
  return s == nil or s == ''
end

function TasteMsgAddonHelper:AcceptInvite()
   if TasteMsgAddonHelper.db.global.auto_party then
        AcceptGroup()
        for i = 1, STATICPOPUP_NUMDIALOGS do
            local dialog = _G["StaticPopup" .. i]
            if dialog.which == "PARTY_INVITE" then
                dialog.inviteAccepted = 1
                break
            end
        end
        StaticPopup_Hide("PARTY_INVITE")
        f:UnregisterEvent("PARTY_MEMBERS_CHANGED")
    end
end

function TasteMsgAddonHelper:AutoAccept()
    if TasteMsgAddonHelper.db.global.auto_party then
        f = CreateFrame("Frame")
        f:RegisterEvent("PARTY_INVITE_REQUEST")
        f:SetScript("OnEvent", function(self, event, msg, sender)
              TasteMsgAddonHelper:AcceptInvite()
          end)
    else
        f:UnregisterEvent("PARTY_INVITE_REQUEST")
    end
end
	local remain_buff_whisper = "Remaining time on Silas buff : " .. SilasBuffDuration() .. " seconds and item up for " .. SilasItemDuration() .. "minutes"
-- The whisperback functon..
function TasteMsgAddonHelper:WhisperBack()

	local dist, target
    dist, target = "WHISPER", dest
    SilasBuffDuration()
    -- Current Playername.. ( Yourself )
    playername = GetUnitName("player", true)
    f = CreateFrame("frame")
    local destination = "WHISPER"
	
    -- Hook various chat event.
	-- Msg Addon only
    if TasteMsgAddonHelper.db.global.use_msg_addon then 
	    C_ChatInfo.RegisterAddonMessagePrefix("TSH")
		f:RegisterEvent("CHAT_MSG_ADDON")
		f:RegisterEvent("CHAT_MSG_GUILD")
		f:RegisterEvent("CHAT_MSG_WHISPER")
        f:RegisterEvent("CHAT_MSG_RAID")
		f:RegisterEvent("CHAT_MSG_RAID_LEADER")
        f:RegisterEvent("CHAT_MSG_PARTY")
		f:RegisterEvent("CHAT_MSG_PARTY_LEADER")
	-- Guild channel only
	elseif TasteMsgAddonHelper.db.global.use_guild_channel then 
	    f:RegisterEvent("CHAT_MSG_GUILD")
	-- Classic chat events
	else
		f:RegisterEvent("CHAT_MSG_WHISPER")
        f:RegisterEvent("CHAT_MSG_RAID")
		f:RegisterEvent("CHAT_MSG_RAID_LEADER")
        f:RegisterEvent("CHAT_MSG_PARTY")
		f:RegisterEvent("CHAT_MSG_PARTY_LEADER")
	end
	
    
	-- Listen to OnEvent... from chats events
    f:SetScript("OnEvent", function(self, event, msg, sender)
        SilasBuffDuration()
        -- Only do something when the addon is enabled.
		if TasteMsgAddonHelper.db.global.enabled then
			
			local realm = GetUnitName(sender, true)
            --f:RegisterEvent("PLAYER_LOGIN");
            --f:RegisterEvent("PLAYER_ENTERING_WORLD");
			
			-- Handle all events type and define channel answer
			if event == "CHAT_MSG_WHISPER" then 
				-- Define answer to whisper channel
				local remain_buff_whisper = "Remaining time on Silas buff : " .. SilasBuffDuration() .. " seconds and item up for " .. SilasItemDuration() .. "minutes"
		        destination = "WHISPER"
			elseif event == "CHAT_MSG_RAID" or event == "CHAT_MSG_RAID_LEADER" then 
	    		-- Define answer to raid channel
				local remain_buff_whisper = "Remaining time on Silas buff : " .. SilasBuffDuration() .. " seconds and item up for " .. SilasItemDuration() .. "minutes"
		        destination = "RAID"
			elseif event == "CHAT_MSG_PARTY" or event == "CHAT_MSG_PARTY_LEADER" then 
				-- Define answer to party channel
				local remain_buff_whisper = "Remaining time on Silas buff : " .. SilasBuffDuration() .. " seconds and item up for " .. SilasItemDuration() .. "minutes"
		        destination = "PARTY"	
			elseif event == "CHAT_MSG_GUILD" then 
    			-- Define answer to guild channel
				local remain_buff_whisper = "Remaining time on Silas buff : " .. SilasBuffDuration() .. " seconds and item up for " .. SilasItemDuration() .. "minutes"
		        destination = "GUILD"
            elseif event == "CHAT_MSG_ADDON" then
				if realm then
				local remain_buff_whisper = "Remaining time on Silas buff : " .. SilasBuffDuration() .. " seconds and item up for " .. SilasItemDuration() .. "minutes"
			        destination = "WHISPER"
				    --print("Received MSG ADDON REQUEST FROM " .. realm)	
                else 
                    return	
                end					
			else
			    return
			end
			
			-- If not available then return custom whisper
            if not isempty(TasteMsgAddonHelper.db.global.whisper) and not SilasBuffIsUp() then
                wmessage = TasteMsgAddonHelper.db.global.whisper				
			-- else return remaining time on buff and item
			elseif UnitAffectingCombat("player") then
			    wmessage = TasteMsgAddonHelper.db.global.incombat_whisper
			elseif SilasBuffIsUp() then 
			    wmessage = "Remaining time on Silas buff : " .. SilasBuffDuration() .. " seconds and item up for " .. SilasItemDuration() .. "minutes"
			else
			    return
            end
			
            -- If MSG_ADDON is used, send prefix, message 
			if event == "CHAT_MSG_ADDON" and TasteMsgAddonHelper.db.global.use_msg_addon then
                if not sender:match(playername) then		
                    SilasBuffDuration()				
				    SendChatMessage(wmessage, destination, nil, realm);
				    --C_ChatInfo.SendAddonMessage("TSH", "message" [, "chatType", "target"])
				    --if debug then 
				    --print("Message and prefix successfully sent to " .. realm)
				else
				    return
				end
			end			

		   
    	    -- Only do something when one of the incoming messages contains Silas etc..
            if TasteMsgAddonHelper:ContainsSilasMessages(msg) then
			    
                -- If we got valid message
                if not isempty(wmessage) then
                    -- Debug false
                    if not debug then

                        -- if the player NOT matches yourself then..
                        if not sender:match(playername) then
						    
							-- Get the whisper of the player in an overlay and dissapear in 3 seconds.
                            if TasteMsgAddonHelper.db.global.display_whisper_overlay then
                                InitTextFrame()
                                MOD_TextFrame:Hide();
                                MOD_TextMessage("|cffffff00"..sender.."|r: "..msg)
								
                            end
							-- Send an answer to the player depending of current channel used
							    
                                SendChatMessage(wmessage, destination, nil, sender);
							

                        else
                            --TasteMsgAddonHelper:Printf("|cff40c040This should not happen? hic...|r")
							return
                        end
                    -- Debug activated
                    else
                        -- if the player matches yourself then (DEBUGMODE)..
                        if sender:match(playername) then
                            if TasteMsgAddonHelper.db.global.display_whisper_overlay then
                                -- Get the whisper of the player in an overlay and dissapear in 3 seconds.
                                --MOD_TextMessage(msg)
								return
                            end
                            -- Send a whisper to the yourself youre the sender in this case...
                           -- SendChatMessage(string.gsub(wmessage, "silas", ""), "WHISPER", nil, sender);
						   return
                        end
                    end

                    else
                        -- No whisper given..
                        TasteMsgAddonHelper:Printf('|cff40c040Please define a Whisper text in /tsh or interface --> Taste Silas Helper |r')
                    end

            end
		
		end
            
        -- Break out of the function.
		do return end			
			
	end)
	
end

-- Called when the addon is disabled
function TasteMsgAddonHelper:OnDisable()	
	-- unregister events
	self:UnregisterAllEvents()
	icon:Hide("TasteMsgAddonHelper")
	-- unregister comm events
	self:UnregisterAllComm()
	self:UnregisterChatCommand("tsh")
	
end

-- Called when the addon is enabled
function TasteMsgAddonHelper:OnEnable()
    icon:Register("TasteMsgAddonHelper", TasteMsgAddonHelperLDB, TasteMsgAddonHelper.db.global.minimap)
    -- If this is a Alchemist than we can go further.
    if isReady() then
	    icon:Show("TasteMsgAddonHelper")
        TasteMsgAddonHelper:WhisperBack()
        TasteMsgAddonHelper:AutoAccept()
		SilasBuffDuration()
    else
        TasteMsgAddonHelper:Printf("|cff0070ddthis addon can only be used on a alchemist character|r")
    end
    
end

-- Process the slash command ("input" contains whatever follows the slash command)
function TasteMsgAddonHelper:ConsoleCommand(input)
	-- show configuration window if no params given
	if not input or input:trim() == "" then
		InterfaceOptionsFrame_OpenToCategory(self.configFrame)
	end
	
	if input == "debug" then
		self:Print("DEBUG: enabled")
		debug = true
	end

	if input == "nodebug" then
		self:Print("DEBUG: disabled")
		debug = false
	end
    
end

-- Code that you want to run when the addon is first loaded goes here.
function TasteMsgAddonHelper:OnInitialize()

    -- Only Init when the class is a alchemist? !
    if isReady() then
        
        -- initialize saved variables
        self.db = LibStub("AceDB-3.0"):New("TasteMsgAddonHelperDB", defaults, true)

        -- initialize configuration options
        LibStub("AceConfig-3.0"):RegisterOptionsTable("TasteMsgAddonHelperDB", options)
        self.configFrame = LibStub("AceConfigDialog-3.0"):AddToBlizOptions("TasteMsgAddonHelperDB", "Taste Silas Helper");

        -- create LibDataBroker
        self.ldb = LibStub("LibDataBroker-1.1"):NewDataObject("TasteMsgAddonHelper", {
            type = "data source",
            text = "",
            label = "",
            icon = "Interface\\Icons\\trade_alchemy_potione1"
        })

        -- Only onetime init
        -- TextOverlay.
        InitTextFrame()
        
        -- Block the crappy portals in channels.
        -- Unlikly behaviour so commented for now
        -- I want to UnRegisterMessageEventFilter but its not working properly.
        -- ChatFrame_AddMessageEventFilter("CHAT_MSG_CHANNEL", NoWhisperWindow)
        -- ChatFrame_AddMessageEventFilter("CHAT_MSG_SAY", NoWhisperWindow)
        -- ChatFrame_AddMessageEventFilter("CHAT_MSG_YELL", NoWhisperWindow)
        -- ChatFrame_AddMessageEventFilter("CHAT_MSG_WHISPER", NoWhisperWindow)
    
        -- Register /tsh to get the settings window.
        self:RegisterChatCommand("tsh", "ConsoleCommand")
        
	end
    
end
