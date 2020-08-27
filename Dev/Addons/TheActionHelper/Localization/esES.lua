local ADDON_NAME, private = ...

local _G = getfenv(0)
local L = _G.LibStub("AceLocale-3.0"):NewLocale(ADDON_NAME, "esES", false)

if not L then return end

Background = "Fondo"
BOTTOM = "Inferior"
L["BOTTOMLEFT"] = "Inferior izquierda"
L["BOTTOMRIGHT"] = "Inferior derecha"
L["CENTER"] = "Centro"
Drag_to_set_the_spawn_point_for_toasts = "Arrastrar para establecer el punto de anclaje de las ventanas de aviso."
Emergency = "Emergencia"
Floating_Icon = "Icono flotante"
Hide_Toasts = "Ocultar ventanas de aviso"
High = "Elevado"
Horizontal_offset_from_the_anchor_point = "Cambiar el offset horizontal desde el punto de anclaje."
Icon_Size = "Tamaño de icono"
LEFT = "Izquierda"
Moderate = "Mediano"
Mute_Toasts = "Silenciar ventanas de aviso"
Normal = "Normal"
Preview = "Vista previa"
Reset_Position = "Restablecer posición"
RIGHT = "Derecha"
Show_Anchor = "Mostrar ancla"
Show_Minimap_Icon = "Mostrar icono en minimapa"
Spawn_Point = "Punto de anclaje"
Text = "Texto"
Title = "Título"
TOP = "Superior"
TOPLEFT = "Superior izquierda"
TOPRIGHT = "Superior derecha"
Vertical_offset_from_the_anchor_point = "Cambiar el offset vertical desde el punto de anclaje."
Very_Low = "Muy bajo"
X_Offset = "Offset X"
Y_Offset = "Offset Y"

