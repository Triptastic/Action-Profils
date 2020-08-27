local ADDON_NAME, private = ...

local _G = getfenv(0)

local isReleaseVersion = true
--[===[@debug@
isReleaseVersion = false
--@end-debug@]===]


local L = _G.LibStub("AceLocale-3.0"):NewLocale(ADDON_NAME, "enUS", isReleaseVersion, isReleaseVersion)

if not L then return end

Background = true
BOTTOM = "Bottom"
BOTTOMLEFT = "Bottom Left"
BOTTOMRIGHT = "Bottom Right"
CENTER = "Center"
Drag_to_set_the_spawn_point_for_toasts = true
Emergency = true
Floating_Icon = true
Hide_Toasts = true
High = true
Horizontal_offset_from_the_anchor_point = true
Icon_Size = true
LEFT = "Left"
Moderate = true
Mute_Toasts = true
Normal = "Normal"
Preview = true
Reset_Position = true
RIGHT = "Right"
Show_Anchor = true
Show_Minimap_Icon = true
Spawn_Point = true
Text = true
Title = true
TOP = "Top"
TOPLEFT = "Top Left"
TOPRIGHT = "Top Right"
Vertical_offset_from_the_anchor_point = true
Very_Low = true
X_Offset = true
Y_Offset = true

