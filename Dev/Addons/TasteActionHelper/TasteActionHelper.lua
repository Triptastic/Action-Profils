-- Addon by Tastemylock
-- Update: 30-07-2019

TasteActionHelper = LibStub("AceAddon-3.0"):NewAddon("TasteActionHelper", "AceConsole-3.0", "AceEvent-3.0", "AceTimer-3.0", "AceComm-3.0", "AceSerializer-3.0")
local LibStub = _G.LibStub
local L = LibStub("AceLocale-3.0"):GetLocale("TellMeWhen", true)
local AceConfigDialog = LibStub("AceConfigDialog-3.0")
local AceConfigRegistry = LibStub("AceConfigRegistry-3.0")
local LDBIcon = LibStub("LibDBIcon-1.0")
local LibToast = LibStub("LibToast-1.0", true)
local LibWindow = LibStub("LibWindow-1.1")
local LibC = LibStub:GetLibrary("LibCompress")
local LibCE = LibC:GetAddonEncodeTable()
local addonName, addon = ...
local TasteActionHelperLDB = LibStub("LibDataBroker-1.1"):NewDataObject("TasteActionHelper", {
	type = "launcher",
	label = "TasteActionHelper",
	icon = "Interface\\Icons\\achievement_featsofstrength_gladiator_10",
	OnClick = function(self, button)
	    print("Taste Action Helper loaded.")
        InterfaceOptionsFrame_OpenToCategory(TasteActionHelper.configFrame)
		InterfaceOptionsFrame_OpenToCategory(TasteActionHelper.configFrame)
    end,
})
local icon = LibStub("LibDBIcon-1.0")
local debug = false
local playername = ''
local player_class = UnitClass("player")

-- init function
function isReady()
    return true
end

-- get option value
local function GetGlobalOptionLocal(info)
	return TasteActionHelper.db.global[info[#info]]
end

-- set option value
local function SetGlobalOptionLocal(info, value)
	if debug and TasteActionHelper.db.global[info[#info]] ~= value then
		TasteActionHelper:Printf("DEBUG: global option %s changed from '%s' to '%s'", info[#info], tostring(GuildRecr.db.global[info[#info]]), tostring(value))
	end
	TasteActionHelper.db.global[info[#info]] = value
	LibStub("AceConfigRegistry-3.0"):NotifyChange("TasteActionHelper")
end

local DEFAULT_OFFSET_X = {
    TOPRIGHT = -20,
    BOTTOMRIGHT = -20,
}

local DEFAULT_OFFSET_Y = {
    TOPRIGHT = -30,
    BOTTOMRIGHT = 30,
}

-- declare defaults to be used in the DB
local defaults = {
	global = {
		enabled = isReady(),
	},
    global = {
        addons = {
            ["*"] = {
                enabled = true,
                mute = false,

                duration = 5,
                icon_size = 30,
                floating_icon = false,
                opacity = 0.75,

                -- This is required so the AddOn stays in the SavedVariables table, and is hence visible in further sessions.
                known = false,
            },
        },
        display = {
            anchor = {
                point = "TOPRIGHT",
                scale = 1,
                y = DEFAULT_OFFSET_Y["TOPRIGHT"],
                x = DEFAULT_OFFSET_X["TOPRIGHT"],
            },
            background = {
                ["*"] = DEFAULT_BACKGROUND_COLORS,
            },
            duration = 5,
            icon_size = 30,
            floating_icon = false,
            opacity = 0.75,
            text = {
                ["*"] = DEFAULT_TEXT_COLORS,
            },
            title = {
                ["*"] = DEFAULT_TITLE_COLORS,
            },
        },
        general = {
            hide_toasts = false,
            minimap_icon = {
                hide = false,
            },
        },
    },
}

-- Option menu (Interface-->Settings)
local options = {
    name = "Taste Action Helper",
	type = "group",
	childGroups = "tab",
      --[[  anonymizer_tab = {
            name = "Action Customization",
			type = "group",
			order = 1,	
            args = {
                empty_1 = {
                    order = 21,
                    type = "description",
                    width = "full",
                   name = "",
                },
                header1 = {
                    order = 30,
                    type = "header",
                    name = "Very Low",
                },
                urgency_very_low_title = ColorDefinition(31, "title", "very_low"),
                urgency_very_low_text = ColorDefinition(32, "text", "very_low"),
                urgency_very_low_background = ColorDefinition(33, "background", "very_low"),
                urgency_very_low_preview = ColorPreview(34, "very_low"),
                empty_3 = {
                order = 35,
                    type = "description",
                    width = "full",
                    name = "",
                },
                header2 = {
                    order = 36,
                    type = "header",
                    name = "Moderate",
                },
                urgency_moderate_title = ColorDefinition(40, "title", "moderate"),
                urgency_moderate_text = ColorDefinition(41, "text", "moderate"),
                urgency_moderate_background = ColorDefinition(42, "background", "moderate"),
                urgency_moderate_preview = ColorPreview(43, "moderate"),
                empty_4 = {
                    order = 44,
                    type = "description",
                    width = "full",
                    name = "",
                },
                header3 = {
                    order = 45,
                    type = "header",
                    name = "Normal",
                },
                urgency_normal_title = ColorDefinition(50, "title", "normal"),
                urgency_normal_text = ColorDefinition(51, "text", "normal"),
                urgency_normal_background = ColorDefinition(52, "background", "normal"),
                urgency_normal_preview = ColorPreview(53, "normal"),
                empty_5 = {
                    order = 54,
                    type = "description",
                    width = "full",
                    name = "",
                },
                header4 = {
                    order = 55,
                    type = "header",
                    name = "High",
                },
                urgency_high_title = ColorDefinition(60, "title", "high"),
                urgency_high_text = ColorDefinition(61, "text", "high"),
                urgency_high_background = ColorDefinition(62, "background", "high"),
                urgency_high_preview = ColorPreview(63, "high"),
                empty_6 = {
                    order = 64,
                    type = "description",
                    width = "full",
                    name = "",
                },
                header5 = {
                    order = 65,
                    type = "header",
                    name = "Emergency",
                },
                urgency_emergency_title = ColorDefinition(70, "title", "emergency"),
                urgency_emergency_text = ColorDefinition(71, "text", "emergency"),
                urgency_emergency_background = ColorDefinition(72, "background", "emergency"),
                urgency_emergency_preview = ColorPreview(73, "emergency"),
                empty_7 = {
                    order = 74,
                    type = "description",
                    width = "full",
                    name = "",
                },
            }				
		}, ]]-- 
        general_tab2 = {
            name = "Action Customization",
			type = "group",
			order = 1,	
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
            }				
		},
	    general_tab3 = {
            name = "Action Customization",
			type = "group",
			order = 1,	
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
            }				
		},
		general_tab4 = {
			name = "Silas Potion of Prosperity",
			type = "group",
			order = 4,
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
								if not TasteActionHelper.db.global.display_whisper_overlay then 
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
								if not TasteActionHelper.db.global.use_guild_channel then 
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
								if not TasteActionHelper.db.global.auto_party then 
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
								if not TasteActionHelper.db.global.use_msg_addon then 
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



-- Called when the addon is disabled
function TasteActionHelper:OnDisable()	
	-- unregister events
	self:UnregisterAllEvents()
	icon:Hide("TasteActionHelper")
	-- unregister comm events
	self:UnregisterAllComm()
	self:UnregisterChatCommand("tsh")
	
end

-- Called when the addon is enabled
function TasteActionHelper:OnEnable()
    icon:Register("TasteActionHelper", TasteActionHelperLDB, TasteActionHelper.db.global.minimap)
    -- If this is a Alchemist than we can go further.
    if isReady() then
	    icon:Show("TasteActionHelper")
        --TasteActionHelper:WhisperBack()
        --TasteActionHelper:AutoAccept()
		--SilasBuffDuration()
    else
        TasteActionHelper:Printf("|cff0070ddthis addon can only be used on a alchemist character|r")
    end
    
end

-- Process the slash command ("input" contains whatever follows the slash command)
function TasteActionHelper:ConsoleCommand(input)
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
function TasteActionHelper:OnInitialize()

    -- Only Init when the class is a alchemist? !
    if isReady() then
        
        -- initialize saved variables
        self.db = LibStub("AceDB-3.0"):New("TasteActionHelperDB", defaults, true)

        -- initialize configuration options
        LibStub("AceConfig-3.0"):RegisterOptionsTable("TasteActionHelperDB", options)
        self.configFrame = LibStub("AceConfigDialog-3.0"):AddToBlizOptions("TasteActionHelperDB", "Taste Silas Helper");

        -- create LibDataBroker
        self.ldb = LibStub("LibDataBroker-1.1"):NewDataObject("TasteActionHelper", {
            type = "data source",
            text = "",
            label = "",
            icon = "Interface\\Icons\\trade_alchemy_potione1"
        })

        -- Only onetime init
        -- TextOverlay.
        --InitTextFrame()
 -- Using LibToast v0.1
LibToast:Embed(TasteActionHelper)

-- Creates a template called "UrgencyToast" which sets the text to whatever
local function CloseToast()
end

TasteActionHelper:RegisterToast("UrgencyToast", function(toast, message, icon)
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
