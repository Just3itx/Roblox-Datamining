-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T00:31:36Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local UserInputService = game:GetService("UserInputService")
local RobloxGui = game:GetService("CoreGui"):WaitForChild("RobloxGui")

local FFlagResponsiveUnitsDeprecateTenFoot = require(CorePackages.Workspace.Packages.SharedFlags).FFlagResponsiveUnitsDeprecateTenFoot
local var1 = require(RobloxGui.Modules.TenFootInterface):IsEnabled() and not FFlagResponsiveUnitsDeprecateTenFoot
local AppFonts = require(CorePackages.Workspace.Packages.Style).AppFonts
local DarkTheme = require(CorePackages.Workspace.Packages.Style).Themes.DarkTheme
local UIBlox = require(CorePackages.Packages.UIBlox)
local Images = UIBlox.App.ImageSet.Images
local getIconSize = UIBlox.App.ImageSet.getIconSize
local IconSize = UIBlox.App.ImageSet.Enum.IconSize

local getUIScale = require(CorePackages.Workspace.Packages.Display).GetDisplayStore(false).getUIScale

local bool1 = game:DefineFastFlag("IncreaseUtilityRowTextSizeConsole", false)

local isInExperienceUIVREnabled = require(CorePackages.Workspace.Packages.SharedExperimentDefinition).isInExperienceUIVREnabled
local FFlagRelocateMobileMenuButtons = require(RobloxGui.Modules.Settings.Flags.FFlagRelocateMobileMenuButtons)
local FIntRelocateMobileMenuButtonsVariant = require(RobloxGui.Modules.Settings.Flags.FIntRelocateMobileMenuButtonsVariant)

local tbl1 = {
    [Enum.FontSize.Size14] = Enum.FontSize.Size11,
    [Enum.FontSize.Size18] = Enum.FontSize.Size14,
    [Enum.FontSize.Size24] = Enum.FontSize.Size18,
    [Enum.FontSize.Size36] = Enum.FontSize.Size28,
    [Enum.FontSize.Size48] = Enum.FontSize.Size36
}

local black = Color3.fromRGB(0, 0, 0)
local default = AppFonts.default:getDefault()
local var2 = tbl1[Enum.FontSize.Size24]

local tbl2 = {
    MenuContainer = {
        Color = Color3.new(0, 0, 0),
        Transparency = 0.2
    },
    IGM_TabSelection = {
        Color = Color3.new(1, 1, 1),
        Transparency = 0
    },
    White = {
        Color = Color3.new(1, 1, 1),
        Transparency = 0
    },
    IGM_Background = {
        Color = Color3.fromRGB(0, 0, 0),
        Transparency = 1
    },
    IGM_Button = {
        Color = Color3.fromRGB(0, 0, 0),
        Transparency = 1
    },
    IGM_ButtonNonInteractable = {
        Color = Color3.fromRGB(100, 100, 100),
        Transparency = 0
    },
    IGM_ButtonHover = {
        Color = Color3.fromRGB(56, 57, 59),
        Transparency = 0
    },
    IGM_Stroke = {
        Color = Color3.new(0.776, 0.776, 0.776),
        Transparency = 0
    },
    IGM_Selected = {
        Color = Color3.fromRGB(217, 217, 217),
        Transparency = 0
    },
    Player_RowSelection = {
        Color = Color3.new(0.396, 0.4, 0.408),
        Transparency = 0.9
    }
}

local tbl3 = {
    Confirmation_Font = {
        Font = AppFonts.default:getBold(),
        RelativeSize = tbl1[Enum.FontSize.Size36],
        TextSize = 28.584000000000003
    },
    Button_Font = {
        Font = AppFonts.default:getMedium(),
        RelativeSize = tbl1[Enum.FontSize.Size24],
        TextSize = 17.468
    },
    Username = {
        RelativeSize = if var1 then tbl1[Enum.FontSize.Size24] else tbl1[Enum.FontSize.Size18]
    },
    DisplayName = {
        RelativeSize = if var1 then Enum.FontSize.Size24 else Enum.FontSize.Size18,
        Font = AppFonts.default:getMedium()
    },
    Settings_Font = {
        Font = AppFonts.default:getDefault()
    },
    Help_Title_Font = {
        Font = AppFonts.default:getMedium(),
        RelativeSize = tbl1[Enum.FontSize.Size18]
    },
    Help_Text_Font = {
        Font = AppFonts.default:getDefault(),
        RelativeSize = tbl1[Enum.FontSize.Size18],
        TextSize = 14.292000000000002
    },
    Help_Gamepad_Font = {
        Font = AppFonts.default:getMedium()
    },
    Help_Touch_Font = {
        Font = AppFonts.default:getBold(),
        RelativeSize = tbl1[Enum.FontSize.Size14]
    },
    Game_Settings_Font = {
        Font = AppFonts.default:getDefault(),
        RelativeSize = tbl1[Enum.FontSize.Size24]
    },
    Conversation_Details_Font = {
        Font = AppFonts.default:getDefault(),
        TextSize = 12.704
    },
    Utility_Text_Font = {
        Font = AppFonts.default:getDefault(),
        TextSize = 17.468
    },
    Utility_Text_Small_Font = {
        Font = AppFonts.default:getDefault(),
        TextSize = 12.704
    },
    Utility_Row_Small_Font = {
        Font = AppFonts.default:getDefault(),
        TextSize = 12.704
    },
    Utility_Row_Font = {
        Font = AppFonts.default:getMedium(),
        TextSize = if bool1 and var1 then 19.056 else 12.704
    },
    Back_Button_Font = {
        Font = AppFonts.default:getSemibold(),
        TextSize = 19.056
    },
    Semibold_Font = {
        Font = AppFonts.default:getSemibold()
    },
    Bold_Font = {
        Font = AppFonts.default:getMedium()
    }
}

setmetatable(tbl2, {
    __index = function(_, arg1)
        return DarkTheme[arg1]
    end
})

local tbl4 = {
    SETTINGS_SHIELD = "IGM_Background",
    SETTINGS_SHIELD_TRANSPARENCY = "IGM_Background",
    SELECTION_TEXT_COLOR_NORMAL = "White",
    SELECTION_TEXT_COLOR_HIGHLIGHTED = "White",
    HubBarContainer = "IGM_Background",
    HubBarContainerTransparency = "IGM_Background",
    HubBarContainerHover = "IGM_Background",
    DarkenBackground = "Overlay",
    PlayerRowFrame = "BackgroundDefault",
    PlayerRowSelection = "Player_RowSelection",
    TabSelection = "IGM_TabSelection",
    DefaultButton = "IGM_Button",
    DefaultButtonHover = "IGM_ButtonHover",
    DefaultButtonStroke = "SecondaryDefault",
    WhiteButtonText = "SecondaryContent",
    MenuContainer = "BackgroundUIContrast",
    ControlInputText = "SystemPrimaryDefault",
    ControlInputStroke = "Divider",
    ControlInputBackground = "BackgroundDefault",
    ControlInputFocusedStroke = "IGM_TabSelection",
    InputActionBackground = "BackgroundUIDefault",
    IconButton = "UIDefault",
    IconButtonHover = "BackgroundOnHover",
    ImageButton = "Divider",
    RowFrameBackground = "BackgroundDefault",
    DropdownListBg = "BackgroundUIDefault",
    DropdownListFocusBg = "UIDefault",
    SELECTED_COLOR = "IGM_Selected",
    NON_SELECTED_COLOR = "BackgroundUIDefault",
    NotInteractableSelection = "UIEmphasis",
    Confirmation = "Confirmation_Font",
    Button = "Button_Font",
    SettingsHub = "Settings_Font",
    HelpTitle = "Help_Title_Font",
    HelpText = "Help_Text_Font",
    HelpGamepad = "Help_Gamepad_Font",
    HelpTouch = "Help_Touch_Font",
    GameSettings = "Game_Settings_Font",
    ConversationDetails = "Conversation_Details_Font",
    UtilityText = "Utility_Text_Font",
    UtilityRow = "Utility_Row_Font",
    UtilityRowSmall = "Utility_Row_Small_Font",
    UtilityTextSmall = "Utility_Text_Small_Font",
    BackButton = "Back_Button_Font",
    Semibold = "Semibold_Font",
    Bold = "Bold_Font",
    ShareLinkTitle = "Utility_Text_Font",
    ButtonNonInteractable = "IGM_ButtonNonInteractable"
}

local function getViewportSize()
    if _G.__TESTEZ_RUNNING_TEST__ then
        return Vector2.new(1024, 1024)
    end

    if workspace.CurrentCamera then
        if workspace.CurrentCamera.ViewportSize == Vector2.new(0, 0) or workspace.CurrentCamera.ViewportSize == Vector2.new(1, 1) then
            return nil
        end

        return workspace.CurrentCamera.ViewportSize
    end

    return nil
end

local viewportSize = getViewportSize()
local TouchEnabled = viewportSize and UserInputService.TouchEnabled
if TouchEnabled then
    TouchEnabled = true

    if not (viewportSize.Y < 500) then
        TouchEnabled = viewportSize.X < 700
    end
end

local tbl5 = {
    PaddingTop = UDim.new(0, 0),
    PaddingLeft = UDim.new(0, 20),
    PaddingRight = UDim.new(0, 20),
    PaddingBottom = UDim.new(0, 14)
}

local tbl6 = {
    PaddingTop = UDim.new(0, 0),
    PaddingLeft = UDim.new(0, 12),
    PaddingRight = UDim.new(0, 12),
    PaddingBottom = if FFlagRelocateMobileMenuButtons
        and (FIntRelocateMobileMenuButtonsVariant == 1 or FIntRelocateMobileMenuButtonsVariant == 3) then UDim.new(0, 24) else UDim.new(0, 12)
}

local tbl7 = {
    AnchorPoint = Vector2.new(0.5, 0.5),
    Position = UDim2.new(0.5, 0, 0.5, 10),
    Size = UDim2.new(0, 0, 0, 0),
    AutomaticSize = Enum.AutomaticSize.XY
}

local tbl8 = {
    AnchorPoint = Vector2.new(0.5, 1),
    Position = UDim2.new(0.5, 0, 1, 8),
    Size = UDim2.new(0, 0, 0, 0),
    AutomaticSize = Enum.AutomaticSize.XY
}

return {
    DefaultScrollBarThickness = 1,
    DefaultCornerRadius = UDim.new(0, 8),
    MenuContainerCornerRadius = UDim.new(0, 10),
    DefaultStokeThickness = 1,
    AlwaysShowBottomBar = function(): boolean
        return not TouchEnabled
    end,
    TabHeaderIconPadding = 5,
    UseInspectAndBuyPanel = function()
        return TouchEnabled
    end,
    ExtraHubBottomPaddingMobile = 12,
    HubPadding = function()
        if not FFlagRelocateMobileMenuButtons or FIntRelocateMobileMenuButtonsVariant == 0 then
            return if TouchEnabled then tbl6 else tbl5
        end

        local function func1() -- Luacid: Inlined by compiler; 1 call site recovered
            local viewportSize2 = getViewportSize()
            return viewportSize2 and UserInputService.TouchEnabled and (viewportSize2.Y < 500 or viewportSize2.X < 700)
        end

        return if func1() then tbl6 else tbl5
    end,
    MenuContainerPosition = function(arg1)
        if isInExperienceUIVREnabled and arg1 then
            local menuContainerPositionOverride = arg1:getMenuContainerPositionOverride()
            if menuContainerPositionOverride then
                return menuContainerPositionOverride
            end
        end
        return if TouchEnabled then tbl8 else tbl7
    end,
    ExtraPageBottomPaddingMobile = 48,
    ButtonHeight = 36,
    LargeButtonHeight = 48,
    SelectorArrowButtonWidth = 32,
    Images = Images,
    getIconSize = getIconSize,
    IconSize = IconSize,
    SHIELD_INACTIVE_POSITION = UDim2.new(0, 0, 1, 36),
    viewportResized = function()
        viewportSize = getViewportSize()
        TouchEnabled = viewportSize and UserInputService.TouchEnabled and (viewportSize.Y < 500 or viewportSize.X < 700)
    end,
    color = function(str1: string, color3: Color3?)
        str1 = tbl4[str1] or str1
        return if tbl2[str1] then tbl2[str1].Color else color3 or black
    end,
    transparency = function(str1: string, num1: number?)
        str1 = tbl4[str1] or str1
        return if tbl2[str1] then tbl2[str1].Transparency else num1 or 0
    end,
    font = function(arg1, str1: string?)
        if not str1 then
            return default
        end
        str1 = tbl4[str1] or str1
        return if tbl3[str1] then tbl3[str1].Font else arg1 or default
    end,
    fontSize = function(arg1, str1: string?)
        if not str1 then
            return tbl1[arg1]
        end
        str1 = tbl4[str1] or str1
        return if tbl3[str1] then tbl3[str1].RelativeSize else arg1 or var2
    end,
    textSize = function(num1: number, str1: string?)
        local uIScale = getUIScale(false)
        if not str1 then
            return num1 * 0.794 * uIScale
        end
        str1 = if TouchEnabled and str1 == "UtilityRow" then "UtilityRowSmall" elseif TouchEnabled and str1 == "UtilityText" then "UtilityTextSmall" else str1

        str1 = tbl4[str1] or str1

        if num1 == nil then
            if tbl3[str1] and tbl3[str1].TextSize then
                return tbl3[str1].TextSize
            end

            return num1 * 0.794 or 19
        end

        if tbl3[str1] and tbl3[str1].TextSize then
            return tbl3[str1].TextSize * uIScale
        end

        return num1 * 0.794 * uIScale
    end,
    hydrateLabel = function(arg1, str1: string, str2: string)
        str1 = tbl4[str1] or str1
        if tbl2[str1] then
            local var3 = tbl2[str1]
            arg1.TextColor3 = var3.Color
            arg1.TextTransparency = var3.Transparency
        end

        if tbl3[str2] then
            local var3 = tbl3[str1]
            arg1.Font = var3.RelativeSize * 19.2
            arg1.TextSize = var3.TextSize
        end
    end,
    platformNameTextSize = 18,
    platformNameIconSize = UDim2.fromOffset(36, 36),
    selectionCursor = tbl2.SelectionCursor
}
