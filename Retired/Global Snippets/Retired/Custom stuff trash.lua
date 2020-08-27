


------------------------------------
--------- COLOR PICKER API ---------
------------------------------------

-- Colors
local cPurple    = "|cffC942FD"
local cBlue      = "|cff00CCFF"
local cGreen     = "|cff00FF00"
local cRed       = "|cffFF0000"
local cWhite     = "|cffFFFFFF"
local cGold      = "|cffFFDD11"
local cLegendary = "|cffff8000"
--[[
-- Color Picker mainframe
local colortitle = StdUi:FontString(tab.frame, 'Main UI color :')
StdUi:GlueTop(colortitle, system1_2, 0, -100, 'LEFT');			
            
local r, g, b, a = RubimRH.db.profile.mainOption.mainframeColor_r, RubimRH.db.profile.mainOption.mainframeColor_g, RubimRH.db.profile.mainOption.mainframeColor_b, RubimRH.db.profile.mainOption.mainframeColor_a                         
            			
window:SetBackdropColor(r, g, b, a)    
local colorInput = StdUi:ColorInput(tab.frame, '', 40, 40, r, g, b, a);
StdUi:FrameTooltip(colorInput, 'Click to open the color picker', 'TOPLEFT', 'TOPRIGHT', true);                
StdUi:GlueTop(colorInput, system1_2, 100, -85, 'LEFT');
function colorInput:OnValueChanged(r, g, b, a)
    window:SetBackdropColor(r, g, b, a)                
    RubimRH.db.profile.mainOption.mainframeColor_r = r 
    RubimRH.db.profile.mainOption.mainframeColor_g = g 
    RubimRH.db.profile.mainOption.mainframeColor_b = b 
    RubimRH.db.profile.mainOption.mainframeColor_a = a 
end	
  ]]-- 

-- Color Picker mainframe action
--local colortitle = StdUi:FontString(tab.frame, 'Main UI color :')
--StdUi:GlueTop(colortitle, anchor, 0, -10, 'LEFT');	
--[[	    
local R, G, B, A = Action.GetToggle(2, "colorpicker").R, Action.GetToggle(2, "colorpicker").G, Action.GetToggle(2, "colorpicker").B, Action.GetToggle(2, "colorpicker").A                       
local color = {r = R, g = G, b = B, a = A}
			

--StdUi:ColorInput(parent, label, width, height, color)
local TastecolorInput = StdUi:ColorInput(anchor, 'colorpicker', 150, 50, color);
StdUi:FrameTooltip(TastecolorInput, 'Click to open the color picker', 'TOPLEFT', 'TOPRIGHT', true);                
StdUi:GlueTop(TastecolorInput, colortitle, 20, -10, 'RIGHT');
function TastecolorInput:OnValueChanged(color)
    TMW.db.global.ActionDB.mainframeColor_r = color.r
    TMW.db.global.ActionDB.mainframeColor_g = color.g
    TMW.db.global.ActionDB.mainframeColor_b = color.b
    TMW.db.global.ActionDB.mainframeColor_a = color.a
	ColorizeUI('Panel', color.r, color.g, color.b, color.a)
    StdUi.config.backdrop.panel = { r = color.r, g = color.g, b = color.b, a = color.a }
    Action.MainUI:SetBackdropColor(color.r, color.g, color.b, color.a   )     
	
    print(color.r)
	print(color.g)
	print(color.b)
	print(color.a)
end	

]]--

--local StdUi = LibStub('StdUi'):NewInstance();


--[[
function Action.ColorizeUI(elementType, R, G, B, A)
local L = Action.GetLocalization()
local colorpickertoggle = Action.GetToggle(2, "colorpicker")
--print(colorpickertoggle.R)
--print(colorpickertoggle.G)
--print(colorpickertoggle.B)
--print(colorpickertoggle.A)



    local currentElement = elementType
	
    local PanelCustom =  { r = colorpickertoggle.R, g = colorpickertoggle.G, b = colorpickertoggle.B, a = colorpickertoggle.A }
    local PanelDefault = { r = 0.0588, g = 0.0588, b = 0, a = 0.8 }

	local SlidersCustom = { r = R, g = G, b = B, a = A }
	local SlidersDefault = { r = 0.15, g = 0.15, b = 0.15, a = 1 }

	local BordersCustom = { r = R, g = G, b = B, a = A }
	local BordersDefault = { r = 0.00, g = 0.00, b = 0.00, a = 1 }
	
	local HighlightCustom = { r = R, g = G, b = B, a = A }
	local HighlightDefault = { r = 0.40, g = 0.40, b = 0, a = 0.5 }	
	
	-- Panel
    -- Seems to contain all window, tooltips, widget including ScrollFrame and ScrollChilds		
	if currentElement == 'Panel' then
        PanelSettings = PanelCustom
	else
	    PanelSettings = PanelDefault
	end
	
	-- Sliders
	if currentElement == 'Sliders' then	
        SlidersSettings = SlidersCustom
	else
	    SlidersSettings = SlidersDefault
	end
	
	-- Borders
	if currentElement == 'Borders' then	
        BordersSettings = BordersCustom
	else
	    BordersSettings = BordersDefault
	end
	
	-- Highlight
	if currentElement == 'Highlight' then	
        HighlightSettings = HighlightCustom
	else
	    HighlightSettings = HighlightDefault
	end
	
	-- Font Size
	local fontSize = 8
	
-- Customizations from UI settings
--StdUi.config.backdrop.panel = { r = R, g = G, b = B, a = A }
StdUi.config = {

	font        = {
		family    = font,
		size      = fontSize,
		titleSize = largeFontSize,
		effect    = 'NONE',
		strata    = 'OVERLAY',
		color     = {
			normal   = { r = 1, g = 1, b = 1, a = 1 },
			custom   = { r = 1, g = 0.9, b = 0, a = 1 },
			disabled = { r = 0.55, g = 0.55, b = 0.55, a = 1 },
			header   = { r = 1, g = 0.9, b = 0, a = 1 },
		}
	},

	backdrop    = {
		texture        = [[Interface\Buttons\WHITE8X8]],
		panel          = PanelSettings,
		slider         = SlidersSettings,

		highlight      = HighlightSettings,
		button         = { r = 0.20, g = 0.20, b = 0.20, a = 1 },
		buttonDisabled = { r = 0.15, g = 0.15, b = 0.15, a = 1 },

		border         = BordersSettings,
		borderDisabled = { r = 0.40, g = 0.40, b = 0.40, a = 1 }
	},
	
	progressBar = {
		color = { r = 1, g = 0.9, b = 0, a = 0.5 },
	},

	highlight   = {
		color = { r = 1, g = 0.9, b = 0, a = 0.4 },
		blank = { r = 0, g = 0, b = 0, a = 0 }
	},

	dialog      = {
		width  = 400,
		height = 100,
		button = {
			width  = 100,
			height = 20,
			margin = 5
		}
	},

	tooltip     = {
		padding = 10
	}
};	
	--StdUi:ApplyBackdrop(frame, type, border, insets)
end
]]--
--[[
-- The biggest problem of TellMeWhen what he using :setup on frames which use DogTag and it's bring an error
TMW:RegisterCallback("TMW_ACTION_IS_INITIALIZED", function()
    
    local colorpickerPanel = Action.GetToggle(2, "colorpickerPanel")
	local colorpickerHighlight = Action.GetToggle(2, "colorpickerHighlight")
	local colorpickerBorder = Action.GetToggle(2, "colorpickerBorder")
	local colorpickerMain = Action.GetToggle(2, "colorpickerMain")
	local colorpickerFontNormal = Action.GetToggle(2, "colorpickerFontNormal")
	local colorpickerFontHeader = Action.GetToggle(2, "colorpickerFontHeader")
    --print(colorpickertoggle.R)
    --print(colorpickertoggle.G)
    --print(colorpickertoggle.B)
    --print(colorpickertoggle.A)
    if colorpickerFontNormal then
	    -- Font normal
	    StdUi.config.font.color.normal = { r = colorpickerFontNormal.R, g = colorpickerFontNormal.G, b = colorpickerFontNormal.B, a = colorpickerFontNormal.A }
	end
	
    if colorpickerFontHeader then	
	    -- Font header
	    StdUi.config.font.color.header = { r = colorpickerFontHeader.R, g = colorpickerFontHeader.G, b = colorpickerFontHeader.B, a = colorpickerFontHeader.A }
	end
	
	if colorpickerPanel then
	    -- Panel
	    -- This one seems to override all other settings in StdUi.config
	    --ColorizeUI('Panel', colorpickerPanel.R, colorpickerPanel.G, colorpickerPanel.B, colorpickerPanel.A)	
	    StdUi.config.backdrop.panel = { r = colorpickerPanel.R, g = colorpickerPanel.G, b = colorpickerPanel.B, a = colorpickerPanel.A }
	end
	
	if colorpickerHighlight then
	    -- highlight
	    --ColorizeUI('Highlight', colorpickerHighlight.R, colorpickerHighlight.G, colorpickerHighlight.B, colorpickerHighlight.A)	
	    StdUi.config.backdrop.highlight = { r = colorpickerHighlight.R, g = colorpickerHighlight.G, b = colorpickerHighlight.B, a = colorpickerHighlight.A }
	end
	
	if colorpickerBorder then
	    -- border
	    --ColorizeUI('Border', colorpickerBorder.R, colorpickerBorder.G, colorpickerBorder.B, colorpickerBorder.A)	
	    StdUi.config.backdrop.border = { r = colorpickerBorder.R, g = colorpickerBorder.G, b = colorpickerBorder.B, a = colorpickerBorder.A }
	end
		
	-- Main
	--ColorizeUI('Panel', colorpickerMain.R, colorpickerMain.G, colorpickerMain.B, colorpickerMain.A)	
	--StdUi.config.backdrop.panel = { r = colorpickerMain.R, g = colorpickerMain.G, b = colorpickerMain.B, a = colorpickerMain.A }
	--if Action.MainUI:IsShown() then 
	--	Action.MainUI:SetBackdropColor(colorpickerMain.R, colorpickerMain.G, colorpickerMain.B, colorpickerMain.A   )
	--end 
	
		
	
end)

--/dump TMW.db.global.ActionDB.mainframeColor_r
--local mainframeColor_r = TMW.db.profile.ActionDB[tab.name][specID][config.DB].mainframeColor_r --TMW.db.global.ActionDB.mainframeColor_r
--local mainframeColor_g = TMW.db.profile.ActionDB[tab.name][specID][config.DB].mainframeColor_g --TMW.db.global.ActionDB.mainframeColor_g
---local mainframeColor_b = TMW.db.profile.ActionDB[tab.name][specID][config.DB].mainframeColor_b --TMW.db.global.ActionDB.mainframeColor_b
--local mainframeColor_a = TMW.db.profile.ActionDB[tab.name][specID][config.DB].mainframeColor_a --TMW.db.global.ActionDB.mainframeColor_a
--ColorizeUI('Panel', mainframeColor_r, mainframeColor_g, mainframeColor_b, mainframeColor_a)
--ColorizeUI("Borders", 1, 0, 0.5, 0.6)

-- The biggest problem of TellMeWhen what he using :setup on frames which use DogTag and it's bring an error
TMW:RegisterCallback("TMW_ACTION_UI_COLOR_PICKER", function()
    local colorpickertoggle = Action.GetToggle(2, "colorpicker")
    --print(colorpickertoggle.R)
    --print(colorpickertoggle.G)
    --print(colorpickertoggle.B)
    --print(colorpickertoggle.A)
	ColorizeUI('Panel', colorpickertoggle.R, colorpickertoggle.G, colorpickertoggle.B, colorpickertoggle.A)	
	StdUi.config.backdrop.panel = { r = colorpickertoggle.R, g = colorpickertoggle.G, b = colorpickertoggle.B, a = colorpickertoggle.A }
end)

-- The biggest problem of TellMeWhen what he using :setup on frames which use DogTag and it's bring an error
TMW:RegisterCallback("TMW_ACTION_IS_INITIALIZED", function()
    local colorpickertoggle = Action.GetToggle(2, "colorpicker")
    --print(colorpickertoggle.R)
    --print(colorpickertoggle.G)
    --print(colorpickertoggle.B)
    --print(colorpickertoggle.A)
	ColorizeUI('Panel', colorpickertoggle.R, colorpickertoggle.G, colorpickertoggle.B, colorpickertoggle.A)	
	StdUi.config.backdrop.panel = { r = colorpickertoggle.R, g = colorpickertoggle.G, b = colorpickertoggle.B, a = colorpickertoggle.A }
	
end)

-- Hook on Action initilization
hooksecurefunc(Action, "OnInitialize", function()
    local colorpickertoggle = Action.GetToggle(2, "colorpicker")
    --print(colorpickertoggle.R)
    --print(colorpickertoggle.G)
    --print(colorpickertoggle.B)
    --print(colorpickertoggle.A)
	ColorizeUI('Panel', colorpickertoggle.R, colorpickertoggle.G, colorpickertoggle.B, colorpickertoggle.A)	
	StdUi.config.backdrop.panel = { r = colorpickertoggle.R, g = colorpickertoggle.G, b = colorpickertoggle.B, a = colorpickertoggle.A }
	
end)

-- Hook on Action initilization
--hooksecurefunc(Action, "ToggleMainUI", function()

	
--end)
]]--
--[[]]--

-- Hook on Action initilization
hooksecurefunc(Action, "ToggleMainUI", function()
    local colorpickerMain = Action.GetToggle(2, "colorpickerMain")
	if Action.MainUI:IsShown() and colorpickerMain then 
		Action.MainUI:SetBackdropColor(colorpickerMain.R, colorpickerMain.G, colorpickerMain.B, colorpickerMain.A   )
    end 
	
end)




----------------- Status Frame Resizer trash -----------------------
if not TMW.db.global.ActionDB.StatusFrame then
    TMW.db.global.ActionDB.StatusFrame = {Width = 0, Height = 0}
end
TMW.db.global.ActionDB.StatusFrame.Width = 160
TMW.db.global.ActionDB.StatusFrame.Height = 200

local function OnMoveStart(self)
	if IsMouseButtonDown() then
		self:StartMoving()
	elseif IsAltKeyDown() then
		self:StartSizing("BOTTOMRIGHT")
	end
end

local function OnMovingStop(self)
	self:StopMovingOrSizing()
end

local function OnSizeChanged(self)
	if not TMW.db.global.ActionDB.StatusFrame then return end
	TMW.db.global.ActionDB.StatusFrame.Width = self:GetWidth() -- Save the new width
	TMW.db.global.ActionDB.StatusFrame.Height = self:GetHeight() -- and height to SavedVariables
end 


local customHeight = #TR.BlockedListArray > 0 and #TR.BlockedListArray * 10 or 20

local StatusFrame = StdUi:Window(Action.MainUI, 160, 200, "Blocked Spells");
StatusFrame:SetPoint('CENTER');
StatusFrame:SetMovable(true)
StatusFrame:SetResizable(true)
StatusFrame:SetUserPlaced()
StatusFrame:EnableMouse(true)
StatusFrame:SetMinResize(16, 20)
StatusFrame:SetMaxResize(1600, 2000)
StatusFrame:RegisterForDrag("LeftButton")
StatusFrame:SetScript("OnDragStart", OnMoveStart)
StatusFrame:SetScript("OnDragStop", OnMovingStop)
StatusFrame:SetScript("OnSizeChanged", OnSizeChanged)
StatusFrame:RegisterEvent("PLAYER_LOGIN")
StatusFrame:SetScript("OnEvent", function(self, event, ...)
	if not TMW.db.global.ActionDB.StatusFrame then
		TMW.db.global.ActionDB.StatusFrame = {
			Width = 160,
			Height = 200,
		}
	end
	self:SetSize(TMW.db.global.ActionDB.StatusFrame.Width, TMW.db.global.ActionDB.StatusFrame.Height)
end)