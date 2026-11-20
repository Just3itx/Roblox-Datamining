-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T01:10:51Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

local Signals = require(CorePackages.Packages.Signals)
local SignalsReact = require(CorePackages.Packages.SignalsReact)
local Display = require(CorePackages.Workspace.Packages.Display)
local getUIScale = Display.GetDisplayStore(false).getUIScale

local scriptParentParent = script.Parent.Parent
local TenFootInterface = require(scriptParentParent.TenFootInterface)
local ChromeEnabled = require(CorePackages.Workspace.Packages.Chrome).Enabled
local ChromeShared = scriptParentParent.Chrome.ChromeShared
local isNewTiltIconEnabled = require(scriptParentParent.isNewTiltIconEnabled)
local FFlagTopBarRefactor = require(CorePackages.Workspace.Packages.InExperienceTopBar).Flags.FFlagTopBarRefactor
local FFlagResponsiveUnitsDeprecateTenFoot = require(CorePackages.Workspace.Packages.SharedFlags).FFlagResponsiveUnitsDeprecateTenFoot

local isSideSheetEnabled = require(CorePackages.Workspace.Packages.InExperienceSideSheetUtils.isSideSheetEnabled)
local var1 = if ChromeEnabled() then require(ChromeShared.Utility.GetStyleTokens)() else nil

local function withUIScale(num1: number): number -- Luacid: Inlined by compiler; 1 call site recovered
    if FFlagResponsiveUnitsDeprecateTenFoot then
        return num1
    end
    local num2 = if TenFootInterface:IsEnabled() then 1.5 else 1
    return if ChromeEnabled() then num2 * num1 else num1
end

local var2 = if ChromeEnabled() then var1.Size.Size_900 else 36
local var3 = var2 - 4

local num1 = if ChromeEnabled() then withUIScale(58) else 58
local var4 = if ChromeEnabled() then var1.Size.Size_1100 else 44

local function getTopbarHeight() -- Luacid: Inlined by compiler; 1 call site recovered
    return if isNewTiltIconEnabled() then if ChromeEnabled() then num1 else var2 else var2
end

local TopBarHeight = getTopbarHeight()

if not ChromeEnabled() then
    var4 = var3
end

local TopBarButtonPadding = if ChromeEnabled() then var1.Padding.XXSmall else 2
local ScreenSideOffset = if ChromeEnabled() then var1.Gap.Large else 16
local TopBarPadding = if ChromeEnabled() then var1.Padding.Small else 12

local GamepadInputTypes = {
    Enum.UserInputType.Gamepad1,
    Enum.UserInputType.Gamepad2,
    Enum.UserInputType.Gamepad3,
    Enum.UserInputType.Gamepad4,
    Enum.UserInputType.Gamepad5,
    Enum.UserInputType.Gamepad6,
    Enum.UserInputType.Gamepad7,
    Enum.UserInputType.Gamepad8
}

return {
    ApplyDisplayScale = function(num2: number)
        return getUIScale(false) * num2
    end,
    useDisplayScaleState = function(num2: number)
        return SignalsReact.useSignalState(Signals.createComputed(function(arg1)
            local getUiScale = Display.GetDisplayStore(arg1).getUIScale
            return num2 * getUiScale(arg1)
        end))
    end,
    TopBarHeight = TopBarHeight,
    TopBarHeightTenFoot = if ChromeEnabled() then nil else 72,
    TopBarButtonHeight = var4,
    TopBarButtonPadding = TopBarButtonPadding,
    TopBarTopMargin = if FFlagTopBarRefactor then var1.Gap.Medium else TopBarHeight - var4 - 2 * TopBarButtonPadding,
    LegacyCloseMenuIconSize = if isNewTiltIconEnabled() then TopBarHeight - var1.Size.Size_100 else 30,
    MENU_ICON_SIZE = if ChromeEnabled() then var1.Size.Size_600 else 24,
    MenuIconOpenScale = 1.25,
    UnibarFrame = {
        PaddingTop = if ChromeEnabled() then var1.Padding.XXSmall else 2,
        PaddingBottom = if ChromeEnabled() then var1.Padding.XXSmall else 2,
        PaddingLeft = ScreenSideOffset + TopBarPadding + (if isSideSheetEnabled then 0 else TopBarHeight) + (if ChromeEnabled() then var1.Padding.XXSmall else 2),
        ExtendedSize = TopBarHeight - (if ChromeEnabled() then var1.Size.Size_100 else 4)
    },
    MenuIconKeepOutAreaId = "roblox-menu-icon",
    HealthBarKeepOutAreaId = "health-bar",
    MoreMenuKeepOutAreaId = "more-menu",
    ChatIconKeepOutAreaId = "chat-icon",
    BackIconKeepOutAreaId = "back-icon",
    TopBarKeepOutAreaId = "roblox-topbar",
    ScreenSideOffset = ScreenSideOffset,
    ScreenSideOffsetTenFoot = if ChromeEnabled() then nil else 48,
    TopBarPadding = TopBarPadding,
    InitialHealth = 100,
    HealthPercentForOverlay = 0.05,
    HealthRedColor = Color3.fromRGB(255, 28, 0),
    HealthYellowColor = Color3.fromRGB(250, 235, 0),
    HealthGreenColor = Color3.fromRGB(27, 252, 107),
    InputType = { MouseAndKeyBoard = "MouseAndKeyboard", Touch = "Touch", Gamepad = "Gamepad" },
    GamepadInputTypes = GamepadInputTypes,
    Analytics = {
        ShowGamepadNavigationDialog = "show-gamepad-navigation-dialog",
        DismissGamepadNavigationDialog = "dismiss-gamepad-navigation-dialog",
        EventNameTopBarButtonActivated = "topbar-button-activated",
        ChatButtonName = "chat",
        MoreMenuButtonName = "more-menu",
        InventoryButtonName = "inventory",
        LeaderboardButtonName = "leaderboard",
        EmotesButtonName = "emotes",
        StatusActive = "active",
        StatusInactive = "inactive"
    },
    LocalizedKeys = {
        UILessTooltipTitle = "CoreScripts.TopBar.Label.UILessHintTitle",
        UILessTooltipDescription = "CoreScripts.TopBar.Label.UILessHintDescription"
    }
}
