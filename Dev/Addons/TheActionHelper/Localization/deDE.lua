local ADDON_NAME, private = ...

local _G = getfenv(0)
local L = _G.LibStub("AceLocale-3.0"):NewLocale(ADDON_NAME, "deDE", false)

if not L then return end

Background = "Hintergrund"
BOTTOM = "Unten"
L["BOTTOMLEFT"] = "Unten Links"
L["BOTTOMRIGHT"] = "Unten Rechts"
L["CENTER"] = "Zentrum"
Drag_to_set_the_spawn_point_for_toasts = "Ziehen, um den Ankerpunkt festzulegen."
Emergency = "Notfall"
Floating_Icon = "Schwebendes Symbol"
Hide_Toasts = "Fenster verstecken"
High = "Hoch"
Horizontal_offset_from_the_anchor_point = "Der horizontale Offset vom Ankerpunkt aus."
Icon_Size = "Symbolgröße"
LEFT = "Links"
Moderate = "Moderat"
Mute_Toasts = "Fenster stummschalten"
Normal = "Normal"
Preview = "Vorschau"
Reset_Position = "Position zurücksetzen"
RIGHT = "Rechts"
Show_Anchor = "Anker anzeigen"
Show_Minimap_Icon = "Minikartensymbol anzeigen"
Spawn_Point = "Ankerpunkt"
Text = true
Title = "Titel"
TOP = "Oben"
TOPLEFT = "Oben Links"
TOPRIGHT = "Oben Rechts"
Vertical_offset_from_the_anchor_point = "Der vertikale Offset vom Ankerpunkt aus."
Very_Low = "Sehr niedrig"
X_Offset = true
Y_Offset = true

