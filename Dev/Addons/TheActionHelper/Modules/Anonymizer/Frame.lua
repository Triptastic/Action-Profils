local svframe = CreateFrame("FRAME");
svframe:RegisterEvent("ADDON_LOADED");
svframe:RegisterEvent("PLAYER_LOGIN");

svframe:SetScript("OnEvent", function(self, event, arg1)
    if event == "ADDON_LOADED" and arg1 == "TheActionHelper" then
		btnRemove:Disable()
		if FakeCharacterName == nil then
			FakeCharacterName = UnitName("player")
	    else
			RegisterNewCharacterName(FakeCharacterName)
		end
	   
		if FakeGuildName == nil then
			FakeGuildName = "ActionPowered"
		else
			RegisterNewGuildName(FakeGuildName)
		end
	   
		if isEnabled == "false" then
			inputCharacterName:SetText(FakeCharacterName)
			inputGuildName:SetText(FakeGuildName)
			btnUpdateNames:SetText("Enable")
			inputCharacterName:Disable()
			inputGuildName:Disable()
		elseif isEnabled == "true" then
			local total = 0
			local isUpdate = "0"
						
			local function onUpdate(self,elapsed)
				total = total + elapsed
				if total >= 0.5 then
					if isUpdate == "0" then
						PlayerName:SetText(FakeCharacterName)
						isUpdate = "1"
					end
				end
			end
						 
			local f = CreateFrame("frame")
			f:SetScript("OnUpdate", onUpdate)
			
			inputCharacterName:SetText(FakeCharacterName)
			inputGuildName:SetText(FakeGuildName)
			GuildFrame.TitleText:SetText("")
			RenameDoHide()
			btnUpdateNames:SetText("Disable")
			inputCharacterName:Enable()
			inputGuildName:Enable()
		end
		
		if isVisible == "true" then
			sgPersonalFrame:Show()
			
		elseif isVisible == "false" then
			sgPersonalFrame:Hide()
		else
			sgPersonalFrame:Show()
		end
	end
end)

-------------------------------------------this crap

local isBubbleHooked = 0
isVisble = "true"
isPvPMasked = "true"
isEnabled = "false"
FakeCharacterName = UnitName("player")
FakeGuildName = "ActionPowered"
currentFrameChosenName = ""
playerName = UnitName("player");
local realGuildName = GetGuildInfo("player");

function RegisterNewCharacterName(name)
	local newName = name
	FakeCharacterName = newName
	RenameHideCharName()
end

function RegisterNewGuildName(name)
	local newName = name
	FakeGuildName = newName
	RenameHideGuildName()
end

local dutotal = 0
 
local function detailUpdater(self,elapsed)
    dutotal = dutotal + elapsed
    if dutotal >= 0.5 then
        realGuildName = GetGuildInfo("player")
        dutotal = 0
    end
end
 
local du = CreateFrame("frame")
du:SetScript("OnUpdate", detailUpdater)


------------------------------------------------------ Party Functions

partyMemberNames = {}
partyMembers = {}
partyMemberRealms = {}

function NamesScrollBar_Update()
	local line
	local lineo
	FauxScrollFrame_Update(NamesScrollBar,50,7,15)
	for line=1,7 do
		lineo = line + FauxScrollFrame_GetOffset(NamesScrollBar);
		if lineo <= 50 then
			if partyMembers[lineo] ~= "" or partyMembers[lineo] ~= nil then
				_G["NamesEntry"..line]:SetText(partyMembers[lineo])
				_G["NamesEntry"..line]:Show()
			end
		end
	end
end

function memberIsHidden(set, key)
    if set[key] ~= nil then
		return true
	end
end

function memberOtherRealm(key)
	if partyMemberRealms[key] ~= nil then
		return true
	end
end

function importSelected()
	local name, realm = UnitName("target")
	if name ~= nil then
		inputPartyName:SetText(name)
	end
	if realm ~= nil then
		inputRealmName:SetText(realm)
	end
	inputPartyNew:SetFocus()
end

function addPartyMember()
	local oName = inputPartyName:GetText()
	local nName = inputPartyNew:GetText()
	local rName = inputRealmName:GetText()
	if oName ~= "" and oName ~= nil and nName ~= "" and nName ~= "" then
		if partyMemberNames[oName] ~= nil then
			removePartyMember(oName)
		end
		table.insert(partyMembers, oName)
		partyMemberNames[oName] = nName
			if rName ~= "" or rName ~= nil then
				partyMemberRealms[oName] = rName
			end
		inputPartyName:SetText("")
		inputPartyNew:SetText("")
		inputRealmName:SetText("")
		NamesScrollBar_Update()
		RenameDoHide()
	else
		print ("Names cannot be left blank.")
	end
end

function removePartyMember(name)
	local rName = name
	for i=1,#partyMembers do
		if partyMembers[i] == rName then
			table.remove(partyMembers, i)
			partyMemberNames[rName] = nil
			partyMemberRealms[rName] = nil
			RenameDoHide()
		end
	end
end

function NameWithRealm(unit)
        local name = unit
		local realm = partyMemberRealms[name]
        if type(realm) ~= "nil" then
                return name.."-"..realm
        else
                return name
        end
end

function NameWithoutRealm(unit)
	if unit ~= nil then
		name = gsub(unit, "%-[^|]+", "")
		return name
	end
end

function RealmWithoutName(unit)
	if unit ~= nil then
		name = gsub(unit, "[^|]+%-", "")
		return name
	end
end

function NameWithoutStar(unit)
	if unit ~= nil then
		name = gsub(unit, "%\([^|]+", "")
		name = string.gsub(name, "%s+", "")
		return name
	end
end

------------------------------------------------------ Character Functions

function RenameHideCharName()
	PlayerFrame:HookScript("OnUpdate", function()
		if isEnabled == "true" then
			PlayerFrame.name:SetText(FakeCharacterName)
		end
	end)
end

function RenameCompactPartyFrame()
	if CompactPartyFrame then 
		CompactPartyFrame:HookScript("OnUpdate", function()
			if isEnabled == "true" then
			for i=1,5 do 
				local currentFrame = _G["CompactPartyFrameMember"..i]
				if currentFrame then 
					local currentName = currentFrame.name:GetText(); 
					if currentFrame.name:GetText() == UnitName("player") or currentFrame.name:GetText() == currentFrameChosenName then
						currentFrame.name:SetText(FakeCharacterName)
						currentFrameChosenName = FakeCharacterName
					end
					if memberIsHidden(partyMemberNames, NameWithoutRealm(currentName)) == true then
						currentFrame.name:SetText(partyMemberNames[NameWithoutRealm(currentName)])
					end
				end 
			end
			end
		end) 
	end
end

function RenameHideRaidFrameName()
	if CompactRaidFrameContainer then 
		CompactRaidFrameContainer:HookScript("OnUpdate", function() 
			if isEnabled == "true" then
			for i=1,40 do 
				local currentFrame = _G["CompactRaidFrame"..i] 
				if currentFrame then
					local currentName = currentFrame.name:GetText(); 
					if currentFrame.name:GetText() == UnitName("player") or currentFrame.name:GetText() == currentFrameChosenName then
						currentFrame.name:SetText(FakeCharacterName)
						currentFrameChosenName = FakeCharacterName
					end
					if memberIsHidden(partyMemberNames, NameWithoutRealm(currentName)) == true then
						currentFrame.name:SetText(partyMemberNames[NameWithoutRealm(currentName)])
					end
				end 
			end
			end 
		end) 
	end
end

function RenameHideGroupedRaid1FrameName()
	if CompactRaidGroup1 then 
		CompactRaidGroup1:HookScript("OnUpdate", function()
			if isEnabled == "true" then
			for i=1,5 do 
				local currentFrame = _G["CompactRaidGroup1Member"..i] 
				if currentFrame then
					local currentName = currentFrame.name:GetText(); 
					if currentName == UnitName("player") or currentName == currentFrameChosenName then
						currentFrame.name:SetText(FakeCharacterName)
						currentFrameChosenName = FakeCharacterName
					end
					if memberIsHidden(partyMemberNames, NameWithoutRealm(currentName)) == true then
						currentFrame.name:SetText(partyMemberNames[NameWithoutRealm(currentName)])
					end
				end 
			end
			end
		end) 
	end
end

function RenameHideGroupedRaid2FrameName()
	if CompactRaidGroup2 then 
		CompactRaidGroup2:HookScript("OnUpdate", function() 
			if isEnabled == "true" then
			for i=1,5 do 
				local currentFrame = _G["CompactRaidGroup2Member"..i] 
				if currentFrame then
					local currentName = currentFrame.name:GetText(); 
					if currentName == UnitName("player") or currentName == currentFrameChosenName then
						currentFrame.name:SetText(FakeCharacterName)
						currentFrameChosenName = FakeCharacterName
					end
					if memberIsHidden(partyMemberNames, NameWithoutRealm(currentName)) == true then
						currentFrame.name:SetText(partyMemberNames[NameWithoutRealm(currentName)])
					end
				end 
			end
			end 
		end) 
	end
end

function RenameHideGroupedRaid3FrameName()
	if CompactRaidGroup3 then 
		CompactRaidGroup3:HookScript("OnUpdate", function() 
			if isEnabled == "true" then
			for i=1,5 do 
				local currentFrame = _G["CompactRaidGroup3Member"..i]
				if currentFrame then
					local currentName = currentFrame.name:GetText(); 
					if currentName == UnitName("player") or currentName == currentFrameChosenName then
						currentFrame.name:SetText(FakeCharacterName)
						currentFrameChosenName = FakeCharacterName
					end
					if memberIsHidden(partyMemberNames, NameWithoutRealm(currentName)) == true then
						currentFrame.name:SetText(partyMemberNames[NameWithoutRealm(currentName)])
					end
				end 
			end
			end 
		end) 
	end
end

function RenameHideGroupedRaid4FrameName()
	if CompactRaidGroup4 then 
		CompactRaidGroup4:HookScript("OnUpdate", function() 
			if isEnabled == "true" then
			for i=1,5 do 
				local currentFrame = _G["CompactRaidGroup4Member"..i] 
				if currentFrame then
					local currentName = currentFrame.name:GetText(); 
					if currentName == UnitName("player") or currentName == currentFrameChosenName then
						currentFrame.name:SetText(FakeCharacterName)
						currentFrameChosenName = FakeCharacterName
					end
					if memberIsHidden(partyMemberNames, NameWithoutRealm(currentName)) == true then
						currentFrame.name:SetText(partyMemberNames[NameWithoutRealm(currentName)])
					end
				end 
			end
			end
		end) 
	end
end

function RenameHideGroupedRaid5FrameName()
	if CompactRaidGroup5 then 
		CompactRaidGroup5:HookScript("OnUpdate", function() 
			if isEnabled == "true" then
			for i=1,5 do 
				local currentFrame = _G["CompactRaidGroup5Member"..i] 
				if currentFrame then
					local currentName = currentFrame.name:GetText(); 
					if currentName == UnitName("player") or currentName == currentFrameChosenName then
						currentFrame.name:SetText(FakeCharacterName)
						currentFrameChosenName = FakeCharacterName
					end
					if memberIsHidden(partyMemberNames, NameWithoutRealm(currentName)) == true then
						currentFrame.name:SetText(partyMemberNames[NameWithoutRealm(currentName)])
					end
				end 
			end
			end 
		end) 
	end
end

function RenameHideGroupedRaid6FrameName()
	if CompactRaidGroup6 then 
		CompactRaidGroup6:HookScript("OnUpdate", function()
			if isEnabled == "true" then
			for i=1,5 do 
				local currentFrame = _G["CompactRaidGroup6Member"..i] 
				if currentFrame then
					local currentName = currentFrame.name:GetText(); 
					if currentName == UnitName("player") or currentName == currentFrameChosenName then
						currentFrame.name:SetText(FakeCharacterName)
						currentFrameChosenName = FakeCharacterName
					end
					if memberIsHidden(partyMemberNames, NameWithoutRealm(currentName)) == true then
						currentFrame.name:SetText(partyMemberNames[NameWithoutRealm(currentName)])
					end
				end 
			end
			end
		end) 
	end
end

function RenameHideGroupedRaid7FrameName()
	if CompactRaidGroup7 then 
		CompactRaidGroup7:HookScript("OnUpdate", function()
			if isEnabled == "true" then
			for i=1,5 do 
				local currentFrame = _G["CompactRaidGroup7Member"..i] 
				if currentFrame then
					local currentName = currentFrame.name:GetText(); 
					if currentName == UnitName("player") or currentName == currentFrameChosenName then
						currentFrame.name:SetText(FakeCharacterName)
						currentFrameChosenName = FakeCharacterName
					end
					if memberIsHidden(partyMemberNames, NameWithoutRealm(currentName)) == true then
						currentFrame.name:SetText(partyMemberNames[NameWithoutRealm(currentName)])
					end
				end 
			end
			end 
		end) 
	end
end

function RenameHideGroupedRaid8FrameName()
	if CompactRaidGroup8 then 
		CompactRaidGroup8:HookScript("OnUpdate", function()
			if isEnabled == "true" then
			for i=1,5 do 
				local currentFrame = _G["CompactRaidGroup8Member"..i] 
				if currentFrame then
					local currentName = currentFrame.name:GetText(); 
					if currentName == UnitName("player") or currentName == currentFrameChosenName then
						currentFrame.name:SetText(FakeCharacterName)
						currentFrameChosenName = FakeCharacterName
					end
					if memberIsHidden(partyMemberNames, NameWithoutRealm(currentName)) == true then
						currentFrame.name:SetText(partyMemberNames[NameWithoutRealm(currentName)])
					end
				end 
			end
			end 
		end) 
	end
end

function RenameHideRaidFrameOverviewName()
	if RaidFrame then
		RaidFrame:HookScript("OnUpdate", function()
			if isEnabled == "true" then
			for i=1,40 do 
				local currentFrame = _G["RaidGroupButton"..i.."Name"] 
				if currentFrame then
					local currentName = currentFrame:GetText(); 
					if currentName == UnitName("player") or currentName == currentFrameChosenName then
						currentFrame:SetText(FakeCharacterName)
						currentFrameChosenName = FakeCharacterName
					end
					if memberIsHidden(partyMemberNames, NameWithoutRealm(currentName)) == true then
						currentFrame:SetText(partyMemberNames[NameWithoutRealm(currentName)])
					end
				end 
			end
			end 
		end) 
	end
end

function RenameHideCharacterFrame()
	CharacterFrame:HookScript("OnUpdate", function()
		if isEnabled == "true" then
			local nText = gsub(CharacterFrame.TitleText:GetText(), playerName, FakeCharacterName)
			CharacterFrame.TitleText:SetText(nText)
		end
	end)
end
----- tooltips
function RenameHideTooltips()
	if GameTooltip then 
		GameTooltip:HookScript("OnTooltipSetUnit", function()
			if isEnabled == "true" then
				for i = 1, GameTooltip:NumLines() do
					local TT = (_G["GameTooltipTextLeft"..i]: GetText() or "") 
					if TT:find(UnitName("player")) or TT:find(FakeCharacterName) then
						local newText = string.gsub(TT, playerName, FakeCharacterName)
						_G["GameTooltipTextLeft"..i]:SetText(newText)
					elseif TT == realGuildName or TT:find(FakeGuildName) then
						_G["GameTooltipTextLeft"..i]:SetText(FakeGuildName) 
					end
					for x=1,#partyMembers do
						if TT:find(partyMembers[x]) then
							local newText = string.gsub(NameWithoutRealm(TT), partyMembers[x], partyMemberNames[partyMembers[x]])
							_G["GameTooltipTextLeft"..i]:SetText(newText)
						end
					end
				end
			end
		end)
		-- Recount, probably Skada and lots of other stuff that aren't units.
		GameTooltip:HookScript("OnUpdate", function()
			if isEnabled == "true" then
			    local guildName, guildRankName, _, guildRealm = GetGuildInfo("player")
				for i = 1, GameTooltip:NumLines() do
					local TT = (_G["GameTooltipTextLeft"..i]:GetText() or "") 
					local line = _G[format("GameTooltipTextLeft%d", i)]
					local text = _G.GameTooltipTextLeft2:GetText()
                   
					if TT:find(UnitName("player")) or TT:find(FakeCharacterName) then
					local newText = string.gsub(TT, playerName, FakeCharacterName)
						_G["GameTooltipTextLeft"..i]:SetText(newText)
					end
					--if TT == realGuildName or TT:find(FakeGuildName) then 
					--	_G["GameTooltipTextLeft"..i]:SetText(FakeGuildName) 
					--end
				--	if line then 
				--	    _G.GameTooltipTextLeft2:SetFormattedText("<|cff00ff10%s|r>", FakeGuildName)
				--	end
				
					if guildName and line and TT:find(realGuildName) then
				        _G.GameTooltipTextLeft2:SetFormattedText("<|cff00ff10%s|r> [|cff00ff10%s|r]", FakeGuildName, guildRankName)
			        --else
				    --    _G.GameTooltipTextLeft2:SetFormattedText("<|cff00ff10%s|r>", FakeGuildName)
			        end
					for x=1,#partyMembers do
						if TT:find(partyMembers[x]) then
							local newText = string.gsub(TT, partyMembers[x], partyMemberNames[partyMembers[x]])
							_G["GameTooltipTextLeft"..i]:SetText(newText)
						end
					end
				end 
			end
		end)
	end
end

--------------------- end tooltips

function RenameHideBG()
	if WorldStateScoreFrame then
		WorldStateScoreFrame:HookScript("OnUpdate", function()  
		if isEnabled == "true" then
			for i = 1, GetNumBattlefieldScores() do 
				local bgChar = _G["WorldStateScoreButton"..i.."NameText"] 
					if bgChar then 
					local BGName = bgChar:GetText() 
						if BGName == UnitName("player") 
							then bgChar:SetText(FakeCharacterName) 
						end
						if memberIsHidden(partyMemberNames, BGName) == true then
							bgChar:SetText(partyMemberNames[currentName])
						end
					end 
				end
			end 
		end) 
	end
end

function RenameHideTargets()
	local frames = {"TargetFrame", "FocusFrame", "TargetFrameToT", "FocusFrameToT", "ArenaEnemyFrame1", "ArenaEnemyFrame2"} -- Arena 1/2 for FCing in BGs.
	for i = 1,#frames do 
	local currentFrame = _G[frames[i]] 
		if currentFrame then
			currentFrame:HookScript("OnUpdate", function()
				if isEnabled == "true" then
					local name = currentFrame.name:GetText() 
					if name == UnitName("player") or currentFrame.name:GetText()==FakeCharacterName  then 
						currentFrame.name:SetText(FakeCharacterName) 
					end
					if memberIsHidden(partyMemberNames, name) == true then
						currentFrame.name:SetText(partyMemberNames[name])
					end
					-- Other Realm Check
					if memberOtherRealm(NameWithoutStar(name)) == true then
						currentFrame.name:SetText(partyMemberNames[NameWithoutStar(name)])
					end
				end
			end) 
		end 
	end
end

function RenameHideGuildName()
	gFrame = CreateFrame('frame', nil, UIParent)
	gFrame:RegisterEvent("ADDON_LOADED")
	gFrame:SetScript('OnEvent', function(a, b)
	if b == "ADDON_LOADED" then
		if IsAddOnLoaded("Blizzard_GuildUI") then
			if GuildFrame then
				if isEnabled == "true" then
					GuildFrame:HookScript("OnUpdate", function() GuildFrameTitleText:SetText(FakeGuildName)
				end)
				end
			end
		end
	end
	end)
	GuildFrame:HookScript("OnUpdate", function() --names of hidden players in guild tab
		if isEnabled=="true" then
			for i=1,14 do   --  Guild Members
				local currentFrame = _G["GuildRosterContainerButton"..i.."String2"]
				local currentName = currentFrame:GetText()
				if currentName == playerName then
					currentFrame:SetText(FakeCharacterName)
				end
				for p=1,#partyMembers do
					if currentName == partyMembers[p] then
						currentFrame:SetText(partyMemberNames[currentName])
					end
				end
			end
            for i=1,16 do   --  Guild News
				local currentFrame = _G["GuildNewsContainerButton"..i.."Text"]
				local currentName = currentFrame:GetText()
				if currentName:find(playerName) then
                    currentFrame:SetText(igsub(currentName, playerName, FakeCharacterName))
                end
                for x=1,#partyMembers do
                    if currentName:find(partyMembers[x]) then
                        currentFrame:SetText(igsub(currentName, partyMembers[x], partyMemberNames[NameWithoutRealm(partyMembers[x])]))
                    end
                end
			end
		end
	end)
	
	GuildMemberDetailFrame:HookScript("OnUpdate", function() -- names in detail popout
		if isEnabled=="true" then
			local currentName = GuildMemberDetailName:GetText()
			if currentName:find(playerName) then
				GuildMemberDetailName:SetText(igsub(currentName, playerName, FakeCharacterName))
			end
			for x=1,#partyMembers do
				if currentName:find(partyMembers[x]) then
					GuildMemberDetailName:SetText(igsub(currentName, partyMembers[x], partyMemberNames[NameWithoutRealm(currentName)]))
				end
			end
		end
	end)
    
    
end

function RenameDoHide()
	if isEnabled == "true" then
		-- RenameHideChatBubbles() -- bubbles / broken kinda
		-- RenameHideNameplates() -- Nameplates /   broken with 7.0
		-- Player, Pets, Minions and Guardians Tooltips
		RenameHideTooltips() -- all the tooltips
		-- Character, Targetting and World Frames
		RenameHideCharName() -- Character Portrait
		RenameHideBG() -- name in BG/Arena
		RenameHideCharacterFrame() -- Character inspect
		RenameHideTargets() -- target, focus, target of target, FC in BG
        RenameHideBattleTag() -- It hides your battletag from the friends list. 
		-- Party/Raid Frames
		RenameCompactPartyFrame() -- hide name on compact party frame
		RenameHideRaidFrameName() -- hide name on raid frame party
		RenameHideGroupedRaid1FrameName()
		RenameHideGroupedRaid2FrameName()
		RenameHideGroupedRaid3FrameName()
		RenameHideGroupedRaid4FrameName()
		RenameHideGroupedRaid5FrameName()
		RenameHideGroupedRaid6FrameName()
		RenameHideGroupedRaid7FrameName()
		RenameHideGroupedRaid8FrameName()
        RenameHideRaidFrameOverviewName()
		-- Guild Name in Guild Tab
		RenameHideGuildName() -- Hide guild's name in guild tab
		-- Addons
		RenameHideRecount() -- Recount
		-- NPC/Mail Frames
		RenameHideMail() -- Your name in letters (todo: returned mail)
		RenameHideGossip() -- Your name when talking to NPCs
		RenameHideQuestInfo() -- Your name in quest description text (I think some have these)
		RenameHideQuesDetails() -- Quest Frame
		RenameHideReadyCheck() -- Ready Check for hidden party members
		RenameHideCharDropDown() -- Right Click Portrait
		RoleChangedFrame:UnregisterAllEvents() -- Stops Role Changes. Can't filter that crap.
		RenameHideLinkedProfessions() -- Profession Links
	end
end

------------------------------------------------------ Chat Filter (very experimental)

local function nameFilter(self, event, msg, sender, ...)
	if isEnabled == "true" then
		local uname = UnitName("player")
		if msg:find(nocase(uname)) then
			return false, igsub(msg, uname, FakeCharacterName), sender, ...
		end
		for i=1,#partyMembers do
			local pname = partyMembers[i]
			if msg:find(nocase(pname)) then
				return false, igsub(msg, pname, partyMemberNames[pname]), sender, ...
			end
		end
	end
end

--Chat Messages
ChatFrame_AddMessageEventFilter("CHAT_MSG_BATTLEGROUND", nameFilter)
ChatFrame_AddMessageEventFilter("CHAT_MSG_BATTLEGROUND_LEADER", nameFilter)
ChatFrame_AddMessageEventFilter("CHAT_MSG_CHANNEL", nameFilter)
ChatFrame_AddMessageEventFilter("CHAT_MSG_CHANNEL_NOTICE", nameFilter)
ChatFrame_AddMessageEventFilter("CHAT_MSG_CHANNEL_NOTICE_USER", nameFilter)
ChatFrame_AddMessageEventFilter("CHAT_MSG_GUILD", nameFilter)
ChatFrame_AddMessageEventFilter("CHAT_MSG_OFFICER", nameFilter)
ChatFrame_AddMessageEventFilter("CHAT_MSG_PARTY", nameFilter)
ChatFrame_AddMessageEventFilter("CHAT_MSG_PARTY_LEADER", nameFilter)
ChatFrame_AddMessageEventFilter("CHAT_MSG_RAID", nameFilter)
ChatFrame_AddMessageEventFilter("CHAT_MSG_RAID_LEADER", nameFilter)
ChatFrame_AddMessageEventFilter("CHAT_MSG_RAID_WARNING", nameFilter)
ChatFrame_AddMessageEventFilter("CHAT_MSG_SAY", nameFilter)
ChatFrame_AddMessageEventFilter("CHAT_MSG_WHISPER", nameFilter)
ChatFrame_AddMessageEventFilter("CHAT_MSG_WHISPER_INFORM", nameFilter)
ChatFrame_AddMessageEventFilter("CHAT_MSG_YELL", nameFilter)
--Emotes and System / NPC Messages
ChatFrame_AddMessageEventFilter("CHAT_MSG_ACHIEVEMENT", nameFilter)
ChatFrame_AddMessageEventFilter("CHAT_MSG_EMOTE", nameFilter)
ChatFrame_AddMessageEventFilter("CHAT_MSG_GUILD_ACHIEVEMENT", nameFilter)
ChatFrame_AddMessageEventFilter("CHAT_MSG_MONSTER_EMOTE", nameFilter)
ChatFrame_AddMessageEventFilter("CHAT_MSG_MONSTER_PARTY", nameFilter)
ChatFrame_AddMessageEventFilter("CHAT_MSG_MONSTER_SAY", nameFilter)
ChatFrame_AddMessageEventFilter("CHAT_MSG_MONSTER_WHISPER", nameFilter)
ChatFrame_AddMessageEventFilter("CHAT_MSG_MONSTER_YELL", nameFilter)
ChatFrame_AddMessageEventFilter("CHAT_MSG_RAID_BOSS_EMOTE", nameFilter)
ChatFrame_AddMessageEventFilter("CHAT_MSG_RAID_BOSS_WHISPER", nameFilter)
ChatFrame_AddMessageEventFilter("CHAT_MSG_SYSTEM", nameFilter)
ChatFrame_AddMessageEventFilter("CHAT_MSG_TEXT_EMOTE", nameFilter)
ChatFrame_AddMessageEventFilter("ROLE_CHANGED_INFORM", nameFilter)
ChatFrame_AddMessageEventFilter("CHAT_MSG_LOOT", nameFilter)
--PVP Stuff.
ChatFrame_AddMessageEventFilter("CHAT_MSG_BG_SYSTEM_ALLIANCE", nameFilter)
ChatFrame_AddMessageEventFilter("CHAT_MSG_BG_SYSTEM_HORDE", nameFilter)
ChatFrame_AddMessageEventFilter("CHAT_MSG_BG_SYSTEM_NEUTRAL", nameFilter)

local function senderFilter(self, event, msg, sender, ...)
	if isEnabled == "true" then
		local name = sender:match(UnitName("player"))
		if name == UnitName("player") then
			return false, msg, FakeCharacterName, ...
		end
		for i=1, #partyMembers do
			local cName = partyMembers[i]
			local name = sender:match(cName)
			if name==cName then
				return false, msg, partyMemberNames[cName], ...
			end
		end
	end
end

ChatFrame_AddMessageEventFilter("CHAT_MSG_ACHIEVEMENT", senderFilter)
ChatFrame_AddMessageEventFilter("CHAT_MSG_BATTLEGROUND", senderFilter)
ChatFrame_AddMessageEventFilter("CHAT_MSG_BATTLEGROUND_LEADER", senderFilter)
ChatFrame_AddMessageEventFilter("CHAT_MSG_CHANNEL", senderFilter)
ChatFrame_AddMessageEventFilter("CHAT_MSG_EMOTE", senderFilter)
ChatFrame_AddMessageEventFilter("CHAT_MSG_GUILD", senderFilter)
ChatFrame_AddMessageEventFilter("CHAT_MSG_GUILD_ACHIEVEMENT", senderFilter)
ChatFrame_AddMessageEventFilter("CHAT_MSG_INSTANCE_CHAT", senderFilter)
ChatFrame_AddMessageEventFilter("CHAT_MSG_INSTANCE_CHAT_LEADER", senderFilter)
ChatFrame_AddMessageEventFilter("CHAT_MSG_MONSTER_EMOTE", senderFilter) -- items/toys and stuff
ChatFrame_AddMessageEventFilter("CHAT_MSG_MONSTER_YELL", senderFilter) -- items/toys and stuff
ChatFrame_AddMessageEventFilter("CHAT_MSG_OFFICER", senderFilter)
ChatFrame_AddMessageEventFilter("CHAT_MSG_PARTY", senderFilter)
ChatFrame_AddMessageEventFilter("CHAT_MSG_PARTY_LEADER", senderFilter)
ChatFrame_AddMessageEventFilter("CHAT_MSG_RAID", senderFilter)
ChatFrame_AddMessageEventFilter("CHAT_MSG_RAID_LEADER", senderFilter)
ChatFrame_AddMessageEventFilter("CHAT_MSG_RAID_WARNING", senderFilter)
ChatFrame_AddMessageEventFilter("CHAT_MSG_SAY", senderFilter)
ChatFrame_AddMessageEventFilter("CHAT_MSG_SYSTEM", senderFilter)
ChatFrame_AddMessageEventFilter("CHAT_MSG_TEXT_EMOTE", senderFilter)
ChatFrame_AddMessageEventFilter("CHAT_MSG_WHISPER", senderFilter)
ChatFrame_AddMessageEventFilter("CHAT_MSG_WHISPER_INFORM", senderFilter)
ChatFrame_AddMessageEventFilter("CHAT_MSG_YELL", senderFilter)
ChatFrame_AddMessageEventFilter("ROLE_CHANGED_INFORM", senderFilter)

------------------------------------------------------ Slash Commands

SLASH_RENAME1 = "/rename"
SlashCmdList["RENAME"] = function(msg)
if (string.lower(msg)=="show") then
		isVisible="true"	
        sgPersonalFrame:Show()
	elseif (string.lower(msg)=="toggle") then
		btnUpdateNames:Click()
	else
		isVisible="true"	
        sgPersonalFrame:Show()
	end

end

------------------------------------------------------ Events
 
local w = CreateFrame("Frame")
w:RegisterEvent("GROUP_ROSTER_UPDATE")
--w:RegisterEvent("PARTY_CONVERTED_TO_RAID")
w:RegisterEvent("PLAYER_ENTERING_WORLD")
w:RegisterEvent("PLAYER_DEAD")
w:RegisterEvent("ZONE_CHANGED")
w:RegisterEvent("PLAYER_LOGIN")
w:RegisterEvent("CHAT_MSG_YELL")
w:RegisterEvent("CHAT_MSG_SAY")
w:RegisterEvent("CHAT_MSG_RAID")
w:RegisterEvent("CHAT_MSG_PARTY")
w:RegisterEvent("CHAT_MSG_PARTY_LEADER")

function w:OnEvent(event, ...)
	if event == "PLAYER_ENTERING_WORLD" or event == "GROUP_ROSTER_UPDATE" or event == "PARTY_CONVERTED_TO_RAID" or event == "PLAYER_DEAD" or event == "UPDATE_MOUSEOVER_UNIT" then
		if isEnabled == "true" then
			realGuildName = GetGuildInfo("player");
			RenameDoHide()
		end
		if isPvPMasked == "true" then
			RenameHidePvPRatings()
		end
	end
	if event == "ZONE_CHANGED" or event == "PLAYER_ENTERING_WORLD" or event == "PLAYER_LOGIN" then
		if isEnabled == "true" then
			RenameHideGarrisonTexts()
		end
	end
	if event == "CHAT_MSG_YELL" or event == "CHAT_MSG_SAY" or event == "CHAT_MSG_RAID" or event == "CHAT_MSG_PARTY" or event == "CHAT_MSG_PARTY_LEADER" then
		--RenameHideChatBubbles() - broken
	end
end

w:SetScript("OnEvent", w.OnEvent)


------------------------------------------------------ PVP

function RenameHidePvPRatings()
    isPvPSeasonActive = ConquestFrame.NoSeason:IsShown()
    if isPvPSeasonActive == 0 then    --  Check if PvP season is active. 0 = active, 1 = inactive. 
        PVPQueueFrameCategoryButton2:SetScript("OnUpdate", function(self, arg1)
            if isEnabled == "true" then
                if isPvPMasked == "true" then
                    for i = 1, 4 do 
                        local button = CONQUEST_BUTTONS[i];
                        rating, seasonBest, weeklyBest, seasonPlayed, seasonWon, weeklyPlayed, weeklyWon = GetPersonalRatedInfo(i);
                        
                        rating = tostring(rating)
                        rating = rating:sub(1, -3).."xx"
                        
                        weeklyBest = tostring(weeklyBest)
                        weeklyBest = weeklyBest:sub(1, -3).."xx"
                        
                        seasonWon = tostring(seasonWon)
                        seasonWon = seasonWon:sub(1, -2).."x"

                        button.Wins:SetText(seasonWon);
                        button.BestRating:SetText(weeklyBest);
                        button.CurrentRating:SetText(rating);
                    end
                end
            end
        end)
        ConquestTooltip:SetScript("OnShow", function(self,arg1)
        if isEnabled == "true" then
            if isPvPMasked == "true" then
                    self.WeeklyBest:SetText(PVP_BEST_RATING.."xxxx");
                    self.WeeklyGamesPlayed:SetText(PVP_GAMES_PLAYED.."xxxx");
                    self.SeasonBest:SetText(PVP_BEST_RATING.."xxxx");
                    self.SeasonGamesPlayed:SetText(PVP_GAMES_PLAYED.."xxxx");
            end
        end
        end)
    end
end

------------------------------------------------------ ADDONS

--- Recount
function RenameHideRecount()
	if (IsAddOnLoaded("Recount")) then
			local bars = {
				 "Recount_MainWindow_Bar1", "Recount_MainWindow_Bar2", "Recount_MainWindow_Bar3", "Recount_MainWindow_Bar4", "Recount_MainWindow_Bar5", "Recount_MainWindow_Bar6", "Recount_MainWindow_Bar7", "Recount_MainWindow_Bar8", "Recount_MainWindow_Bar9", "Recount_MainWindow_Bar10", "Recount_MainWindow_Bar11", "Recount_MainWindow_Bar12", "Recount_MainWindow_Bar13", "Recount_MainWindow_Bar14", "Recount_MainWindow_Bar15", "Recount_MainWindow_Bar16", "Recount_MainWindow_Bar17", "Recount_MainWindow_Bar18", "Recount_MainWindow_Bar19", "Recount_MainWindow_Bar20", "Recount_MainWindow_Bar21", "Recount_MainWindow_Bar22", "Recount_MainWindow_Bar23", "Recount_MainWindow_Bar24", "Recount_MainWindow_Bar25", "Recount_MainWindow_Bar26", "Recount_MainWindow_Bar27", "Recount_MainWindow_Bar28", "Recount_MainWindow_Bar29", "Recount_MainWindow_Bar30"
			}
			local frames = {
				"Recount_DetailWindow", "Recount_GraphWindow"
			}
			
		for i=1,#bars do
			local currentFrame = _G[bars[i]]
			if currentFrame then
				if currentFrame.LeftText:GetText()== (i..". "..playerName) then
					currentFrame.LeftText:SetText(i..". "..FakeCharacterName) 
				end 
				currentFrame:HookScript("OnUpdate", function(a, b)
					if isEnabled == "true" then
					local c = a.LeftText:GetText() 
						if c == (i..". "..playerName) then 
							a.LeftText:SetText(i..". "..FakeCharacterName) 
						end
						for p=1,#partyMembers do
							if c == (i..". "..partyMembers[p]) then 
								a.LeftText:SetText(i..". "..partyMemberNames[partyMembers[p]]) 
							end
						end
					end
				end) 
			end 
		end
		
		for i=1,#frames do
			local currentFrame = _G[frames[i]]
			if currentFrame then
				currentFrame:HookScript("OnUpdate", function ()
					theTitle = currentFrame.Title:GetText()
					if isEnabled == "true" then
						currentFrame.Title:SetText("")
						newTitle = string.gsub(theTitle,playerName,FakeCharacterName)
						currentFrame.Title:SetText(newTitle)
					end
				end)
			end
		end
	end
end

------------------------------------------------------ NPC & Misc Frames

function RenameHideMail()
	OpenMailBodyText:HookScript("OnUpdate", function()
		if isEnabled == "true" then
			local bodyText = GetInboxText(InboxFrame.openMailID);
			if bodyText ~= nil then -- not an invoice (AH)
				local nText = igsub(bodyText, playerName, FakeCharacterName)
				OpenMailBodyText:SetText(nText)
			end
		end
	end)
end

function RenameHideGossip()
	GossipFrame:HookScript("OnUpdate", function()
		if isEnabled == "true" then
			local gText = GossipGreetingText:GetText()
			if gText ~= "" and gText ~= nil then
				local nText = igsub(gText, playerName, FakeCharacterName)
				GossipGreetingText:SetText(nText)
			end
		end
	end)
end

function RenameHideQuestInfo()
	QuestFrame:HookScript("OnUpdate", function()
		if isEnabled == "true" then
			local qText = QuestInfoDescriptionText:GetText()
			if qText ~= "" and qText ~= nil then
				local nText = igsub(qText, playerName, FakeCharacterName)
				QuestInfoDescriptionText:SetText(nText)
			end
		end
	end)
end

function RenameHideQuesDetails()
	QuestMapDetailsScrollFrame:HookScript("OnUpdate", function()
		if isEnabled == "true" then
			local qText = QuestInfoDescriptionText:GetText()
			if qText ~= "" and qText ~= nil then
				local nText = igsub(qText, playerName, FakeCharacterName)
				QuestInfoDescriptionText:SetText(nText)
			end
		end
	end)
end

function RenameHideReadyCheck()
	ReadyCheckFrame:HookScript("OnUpdate", function()
		if isEnabled == "true" then
			local rText = ReadyCheckFrameText:GetText()
			if rText ~= "" and rText ~= nil then
				for p=1,#partyMembers do
					ReadyCheckFrameText:SetText("Ready Check Started")
				end
			end
		end
	end)
end

function RenameHideCharDropDown()
	DropDownList1:HookScript("OnUpdate", function()
		if isEnabled == "true" then
			local qText = DropDownList1Button1NormalText:GetText()
			if qText ~= "" and qText ~= nil then
				local nText = igsub(qText, playerName, FakeCharacterName)
				DropDownList1Button1NormalText:SetText(nText)
			end
		end
	end)
end

function RenameHideBattleTag()
    FriendsFrame:HookScript("OnUpdate", function()
		if isEnabled == "true" then
			FriendsFrameBattlenetFrame.Tag:SetText(FakeCharacterName)
		end
	end)
end

------------------------------------------------------ Boss Loot Frame (6.1+)

function BossBanner_ConfigureLootFrame(lootFrame, data)
	local itemName, itemLink, itemRarity, _, _, _, _, _, _, itemTexture = GetItemInfo(data.itemLink);
	lootFrame.ItemName:SetText(itemName);
	local rarityColor = ITEM_QUALITY_COLORS[itemRarity];
	lootFrame.ItemName:SetTextColor(rarityColor.r, rarityColor.g, rarityColor.b);
	lootFrame.Background:SetVertexColor(rarityColor.r, rarityColor.g, rarityColor.b);
	lootFrame.Icon:SetTexture(itemTexture);

	SetItemButtonQuality(lootFrame.IconHitBox, itemRarity, data.itemLink);

	if ( data.quantity > 1 ) then
		lootFrame.Count:Show();
		lootFrame.Count:SetText(data.quantity);
	else
		lootFrame.Count:Hide();
	end
    if isEnabled == "true" then
		local bText = data.playerName
        for p=1,#partyMembers do
			if bText == partyMembers[p] then 
				lootFrame.PlayerName:SetText(partyMemberNames[partyMembers[p]]) 
			end
		end
        if bText == playerName then
            local nText = igsub(bText, playerName, FakeCharacterName)
            lootFrame.PlayerName:SetText(nText)
        else
            lootFrame.PlayerName:SetText(data.playerName);
        end
    else
        lootFrame.PlayerName:SetText(data.playerName);
	end
	local classColor = RAID_CLASS_COLORS[data.className];
	lootFrame.PlayerName:SetTextColor(classColor.r, classColor.g, classColor.b);
	lootFrame.itemLink = data.itemLink;
end


------------------------------------------------------ Nameplates (BROKEN)
function RenameHideNameplates()
	local nK = -1 
	local cK = WorldFrame:GetNumChildren() 
	if cK ~= nK then 
		nK = cK 
		for i = 1, cK do 
			local np = select(i, WorldFrame:GetChildren())
			if (np:GetName() and np:GetName():find("NamePlate%d")) then 
				np:HookScript("OnShow", function()
					if isEnabled == "true" then
						np.barFrame, np.nameFrame = np:GetChildren()
						local newParent = np.barFrame
						nameTextRegion = np.nameFrame:GetRegions()
						npName = nameTextRegion
						if memberIsHidden(partyMemberNames, NameWithoutStar(npName:GetText())) == true or memberIsHidden(partyMemberNames, npName:GetText()) == true then
							npName:SetText(partyMemberNames[NameWithoutStar(npName:GetText())])
						end
					end
				end)
			end 
		end
	end
end

------------------------------------------------------ Chat Bubbles (broken)
function RenameHideChatBubbles()
	local bText	--	Bubble Text
	local nText	--	Player Name Text
	local pText	--	Party name Text
	for i = 1, WorldFrame:GetNumChildren() do
		local v = select(i, WorldFrame:GetChildren())
		local background = v:GetBackdrop()
		if background and background.bgFile == "Interface\\Tooltips\\ChatBubble-Background" then
			for i = 1, v:GetNumRegions() do
				local frame = v
				frame:HookScript("OnUpdate", function()
					if isEnabled == "true" then
						local v = select(i, v:GetRegions())
						if v:GetObjectType() == "FontString" then
							local fontstring = v
							bText = fontstring:GetText()
							if bText ~= "" and bText ~= nil then
								nText = igsub(bText, playerName, FakeCharacterName)
								if #partyMembers ~= nil or #partyMembers ~= 0 then
									for p=1,#partyMembers do
										nText = igsub(nText, partyMembers[p], partyMemberNames[partyMembers[p]])
									end
								end
								fontstring:SetWidth(math.min(fontstring:GetStringWidth(), 300))
								fontstring:SetText(nText)
							end
						end
					end
				end)
			end
		end
	end
end

  
------------------------------------------------------ Profession Links

function RenameHideLinkedProfessions()
	tFrame = CreateFrame('frame', nil, UIParent)
	tFrame:RegisterEvent("ADDON_LOADED")
	tFrame:SetScript('OnEvent', function(a, b)
	if b == "ADDON_LOADED" then
		if IsAddOnLoaded("Blizzard_TradeSkillUI") then
			if TradeSkillFrame then
				TradeSkillFrame:HookScript("OnUpdate", function()
					if isEnabled == "true" then
						local tText = TradeSkillFrameTitleText:GetText()
						if tText ~= "" and tText ~= nil then
							local nText = igsub(tText, playerName, FakeCharacterName)
							TradeSkillFrameTitleText:SetText(nText)
						end
					end
				end)
			end
		end
	end
	end)
end

------------------------------------------------------ Garrison Zone Text

function RenameHideGarrisonTexts()
	local zone = GetZoneText()
	if zone ==	"Lunarfall" or zone == "Frostwall" then
		MinimapZoneText:SetText(FakeCharacterName.."'s Garrison")
		SubZoneTextString:SetText(FakeCharacterName.."'s Garrison")
	end
end

------------------------------------------------------ Functions

-- Case Insensitive gsub - Credits: Peter Wang (http://lua-users.org/lists/lua-l/2001-04/msg00206.html)
function igsub(s, pat, repl, n)
    pat = gsub(pat, '(%a)', function (v) return '['..strupper(v)..strlower(v)..']' end)
    if n then
        return gsub(s, pat, repl, n)
    else
        return gsub(s, pat, repl)
    end
end

-- No Case - Credits: Roberto Ierusalimschy (http://www.lua.org/pil/20.4.html)
function nocase (s)
	s = string.gsub(s, "%a", function (c)
		return string.format("[%s%s]", string.lower(c), string.upper(c)) end)
	return s
end