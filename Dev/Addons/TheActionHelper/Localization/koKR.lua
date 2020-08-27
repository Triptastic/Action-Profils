local ADDON_NAME, private = ...

local _G = getfenv(0)
local L = _G.LibStub("AceLocale-3.0"):NewLocale(ADDON_NAME, "koKR", false)

if not L then return end

Background = "배경"
BOTTOM = "하단"
L["BOTTOMLEFT"] = "좌측하단"
L["BOTTOMRIGHT"] = "우측하단"
L["CENTER"] = "중앙"
Drag_to_set_the_spawn_point_for_toasts = "드래그해서 팝업창의 생성 지점을 설정하세요."
Emergency = "긴급"
Floating_Icon = "아이콘 분리"
Hide_Toasts = "Toasts 숨기기"
High = "높음"
Horizontal_offset_from_the_anchor_point = "고정 위치로부터 수평으로 이동합니다."
Icon_Size = "아이콘 크기"
LEFT = "좌측"
Moderate = "보통"
Mute_Toasts = "Toasts 음소거"
Normal = "일반"
Preview = "미리보기"
Reset_Position = "위치 초기화"
RIGHT = "우측"
Show_Anchor = "고정기 표시"
Show_Minimap_Icon = "미니맵 아이콘 표시"
Spawn_Point = "생성 지점"
Text = "문자"
Title = "제목"
TOP = "상단"
TOPLEFT = "좌측상단"
TOPRIGHT = "우측상단"
Vertical_offset_from_the_anchor_point = "고정 위치로부터 수직으로 이동합니다."
Very_Low = "매우 낮음"
X_Offset = "X 좌표"
Y_Offset = "Y 좌표"

