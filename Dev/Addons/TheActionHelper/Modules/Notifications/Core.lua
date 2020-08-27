-----------------------------------------------------------------------
-- Upvalued Lua API.
-----------------------------------------------------------------------
local _G = getfenv(0)

-----------------------------------------------------------------------
-- AddOn namespace.
-----------------------------------------------------------------------
local ADDON_NAME, private = ...

local LibStub = _G.LibStub
local L = LibStub("AceLocale-3.0"):GetLocale(ADDON_NAME)
local LDBIcon = LibStub("LibDBIcon-1.0")
local TheActionHelper = _G.TheActionHelper 
local TheActionHelper = LibStub("AceAddon-3.0"):NewAddon(ADDON_NAME, "AceConsole-3.0")

_G.TheActionHelper = TheActionHelper



-----------------------------------------------------------------------
-- Constants
-----------------------------------------------------------------------
local DEFAULT_BACKGROUND_COLORS = {
    r = 0,
    g = 0,
    b = 0,
}

local DEFAULT_TITLE_COLORS = {
    r = 0.510,
    g = 0.773,
    b = 1,
}

local DEFAULT_TEXT_COLORS = {
    r = 0.486,
    g = 0.518,
    b = 0.541
}

-----------------------------------------------------------------------
-- Variables
-----------------------------------------------------------------------
local AddOnObjects = {}
private.AddOnObjects = AddOnObjects

local db

-----------------------------------------------------------------------
-- Helpers.
-----------------------------------------------------------------------
local function RegisterAddOn(addonName)
    if addonName == ADDON_NAME or addonName == "LibToast-1.0" or AddOnObjects[addonName] then
        return false
    end

    db.global.addons[addonName].known = true
    AddOnObjects[addonName] = { name = addonName }

    TheActionHelper:UpdateAddOnOptions()

    return true
end

-----------------------------------------------------------------------
-- Public API
-----------------------------------------------------------------------
function TheActionHelper:SpawnPoint()
    return db.global.display.anchor.point
end

function TheActionHelper:SpawnOffsetX()
    return db.global.display.anchor.x
end

function TheActionHelper:SpawnOffsetY()
    return db.global.display.anchor.y
end

function TheActionHelper:TitleColors(urgency)
    if not urgency then
        urgency = "normal"
    end
    local colors = db.global.display.title[urgency] or DEFAULT_TITLE_COLORS
    return colors.r, colors.g, colors.b
end

function TheActionHelper:TextColors(urgency)
    if not urgency then
        urgency = "normal"
    end
    local colors = db.global.display.text[urgency]
    return colors.r, colors.g, colors.b
end

function TheActionHelper:Backdrop()

end

function TheActionHelper:Duration(addonName)
    local addon = addonName and db.global.addons[addonName]
    return (addon and addon.known) and addon.duration or db.global.display.duration
end

function TheActionHelper:FloatingIcon(addonName)
    local addon = addonName and db.global.addons[addonName]
    return (addon and addon.known) and addon.floating_icon or db.global.display.floating_icon
end

function TheActionHelper:IconSize(addonName)
    local addon = addonName and db.global.addons[addonName]
    return (addon and addon.known) and addon.icon_size or db.global.display.icon_size
end

function TheActionHelper:Opacity(addonName)
    local addon = addonName and db.global.addons[addonName]
    return (addon and addon.known) and addon.opacity or db.global.display.opacity
end

function TheActionHelper:BackgroundColors(urgency)
    if not urgency then
        urgency = "normal"
    end
    local colors = db.global.display.background[urgency]
    return colors.r, colors.g, colors.b
end

function TheActionHelper:HideToasts()
    return db.global.general.hide_toasts
end

function TheActionHelper:HideToastsFromSource(addonName)
    if not addonName or RegisterAddOn(addonName) then
        return false
    end
    return not db.global.addons[addonName].enabled
end

function TheActionHelper:MuteToasts()
    return db.global.general.mute_toasts
end

function TheActionHelper:MuteToastsFromSource(addonName)
    if not addonName or RegisterAddOn(addonName) then
        return false
    end
    return db.global.addons[addonName].mute
end

-----------------------------------------------------------------------
-- Initialization/Enable/Disable
-----------------------------------------------------------------------
local DEFAULT_OFFSET_X = {
    TOPRIGHT = -20,
    BOTTOMRIGHT = -20,
}

local DEFAULT_OFFSET_Y = {
    TOPRIGHT = -30,
    BOTTOMRIGHT = 30,
}

local DATABASE_DEFAULTS = {
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

private.DATABASE_DEFAULTS = DATABASE_DEFAULTS

function TheActionHelper:OnInitialize()
    --db = LibStub("AceDB-3.0"):New(("TheActionHelperSettingsDB"):format(ADDON_NAME), DATABASE_DEFAULTS, "Default")
	--db = LibStub("AceDB-3.0"):New("TheActionHelperSettingsDB", DATABASE_DEFAULTS, true)
    private.db = db

    LDBIcon:Register(ADDON_NAME, LibStub("LibDataBroker-1.1", true):NewDataObject(ADDON_NAME,
        {
            type = "launcher",
            label = ADDON_NAME,
            icon = [[Interface\DialogFrame\UI-Dialog-Icon-AlertNew]],
            OnClick = function(display, button)
                local optionsFrame = _G.InterfaceOptionsFrame
                if optionsFrame:IsVisible() then
                    optionsFrame:Hide()
                else
                    _G.InterfaceOptionsFrame_OpenToCategory(self.OptionsFrame)
                end
            end,
			OnTooltipShow = function(tooltip)
				tooltip:AddLine("ActionHelper")
			end,
        }), db.global.general.minimap_icon)

    -- Make sure this doesn't exist, since earlier versions allowed it.
    -- TODO: Remove this after a few months.
    db.global.addons["LibToast-1.0"] = nil

    for addonName, data in _G.pairs(db.global.addons) do
        -- Migration.
        if _G.type(data.show) == "boolean" then
            data.enabled = data.show
            data.show = nil
        end
        -- End migration.

        AddOnObjects[addonName] = { name = addonName }
    end

    self:SetupOptions()
    self:UpdateAddOnOptions()

    self:RegisterChatCommand("toaster", function(args)
        local optionsFrame = _G.InterfaceOptionsFrame
        if optionsFrame:IsVisible() then
            optionsFrame:Hide()
        else
            _G.InterfaceOptionsFrame_OpenToCategory(self.OptionsFrame)
        end
    end)
end

function TheActionHelper:OnEnable()
end

function TheActionHelper:OnDisable()
end

