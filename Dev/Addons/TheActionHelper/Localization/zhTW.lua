local ADDON_NAME, private = ...

local _G = getfenv(0)
local L = _G.LibStub("AceLocale-3.0"):NewLocale(ADDON_NAME, "zhTW", false)

if not L then return end

Background = "背景"
BOTTOM = "下"
L["BOTTOMLEFT"] = "左下"
L["BOTTOMRIGHT"] = "右下"
L["CENTER"] = "中央"
Drag_to_set_the_spawn_point_for_toasts = "拖曳來設定提醒的顯現點。"
Emergency = "緊急"
Floating_Icon = "浮動圖標"
Hide_Toasts = "隱藏提醒"
High = "高"
Horizontal_offset_from_the_anchor_point = "定位點的水平偏移。"
Icon_Size = "圖標尺寸"
LEFT = "左"
Moderate = "中等"
Mute_Toasts = "提醒靜音"
Normal = "一般"
Preview = "預覽"
Reset_Position = "重設位置"
RIGHT = "右"
Show_Anchor = "顯示定位點"
Show_Minimap_Icon = "顯示小地圖圖標"
Spawn_Point = "顯現點"
Text = "文字"
Title = "標題"
TOP = "上"
TOPLEFT = "左上"
TOPRIGHT = "右上"
Vertical_offset_from_the_anchor_point = "定位點的垂直偏移。'"
Very_Low = "非常低"
X_Offset = "X軸偏移"
Y_Offset = "Y軸偏移"

