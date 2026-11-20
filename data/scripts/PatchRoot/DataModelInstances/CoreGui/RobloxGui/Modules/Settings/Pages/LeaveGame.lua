-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T00:11:08Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CoreGui = game:GetService("CoreGui")
local CorePackages = game:GetService("CorePackages")
local ContextActionService = game:GetService("ContextActionService")
local RobloxGui = CoreGui:WaitForChild("RobloxGui")
local GuiService = game:GetService("GuiService")
local RbxAnalyticsService = game:GetService("RbxAnalyticsService")
local LocalizationService = game:GetService("LocalizationService")

local Utility = require(RobloxGui.Modules.Settings.Utility)
local leaveGame = require(RobloxGui.Modules.Settings.leaveGame)
local Create = require(CorePackages.Workspace.Packages.AppCommonLib).Create
local React = require(CorePackages.Packages.React)
local ReactRoblox = require(CorePackages.Packages.ReactRoblox)

local ReactFocusNavigation = require(CorePackages.Packages.ReactFocusNavigation)
local useFocusGuiObject = ReactFocusNavigation.useFocusGuiObject

local Responsive = require(CorePackages.Workspace.Packages.Responsive)
local Input = Responsive.Input
local useLastInput = Responsive.useLastInput

local Localization = require(CorePackages.Workspace.Packages.InExperienceLocales).Localization
local Localization2 = require(CorePackages.Workspace.Packages.Localization)
local LocalizationProvider = Localization2.LocalizationProvider
local useLocalization = Localization2.Hooks.useLocalization

local Foundation = require(CorePackages.Packages.Foundation)

local var1 = require(CorePackages.Workspace.Packages.Chrome).Enabled()
local Service = if var1 then require(RobloxGui.Modules.Chrome.Service) else nil
local Constants = if var1 then require(RobloxGui.Modules.Chrome.ChromeShared.Unibar.Constants) else nil
local SharedFlags = require(CorePackages.Workspace.Packages.SharedFlags)

RobloxGui:WaitForChild("Modules"):WaitForChild("TenFootInterface")
local FFlagResponsiveUnitsDeprecateTenFoot = SharedFlags.FFlagResponsiveUnitsDeprecateTenFoot
local var2 = require(RobloxGui.Modules.TenFootInterface):IsEnabled() and not FFlagResponsiveUnitsDeprecateTenFoot

local engineFeature = game:GetEngineFeature("RbxAnalyticsServiceExposePlaySessionId")

local FFlagEnableConsoleExpControls = SharedFlags.FFlagEnableConsoleExpControls
local FFlagChromeShortcutRemoveRespawnOnLeavePage = SharedFlags.FFlagChromeShortcutRemoveRespawnOnLeavePage
local isPioneerLaunch = require(CorePackages.Workspace.Packages.PioneerUtils).isPioneerLaunch
local PioneerLeaveReason = require(CorePackages.Workspace.Packages.PioneerUtils).PioneerLeaveReason
local FFlagPioneerLeaveLogsOut = SharedFlags.FFlagPioneerLeaveLogsOut

local FFlagRefactorMenuConfirmationButtons = require(RobloxGui.Modules.Settings.Flags.FFlagRefactorMenuConfirmationButtons)

local FFlagConfirmationButtonsUseGreyButtons = require(RobloxGui.Modules.Settings.Flags.FFlagConfirmationButtonsUseGreyButtons)

local Constants2 = require(RobloxGui.Modules:WaitForChild("InGameMenu"):WaitForChild("Resources"):WaitForChild("Constants"))

local InExperienceSideSheet = require(CorePackages.Workspace.Packages.InExperienceSideSheet)
local LocalizationKeys = InExperienceSideSheet.Constants.LocalizationKeys
local FFlagPioneerLogoutButtonLabel = InExperienceSideSheet.Flags.FFlagPioneerLogoutButtonLabel

local focusNavigationService = ReactFocusNavigation.FocusNavigationService.new(ReactFocusNavigation.EngineInterface.CoreGui)

local Theme = require(RobloxGui.Modules.Settings.Theme)

local FoundationProvider = Foundation.FoundationProvider
local Button = Foundation.Button
local ButtonVariant = Foundation.Enums.ButtonVariant
local InputSize = Foundation.Enums.InputSize
local FoundationText = Foundation.Text
local View = Foundation.View

local RobloxTranslator = require(CorePackages.Workspace.Packages.RobloxTranslator)

local function LeaveButtonsContainer(tbl1)
    local ref = React.useRef(nil)

    local var4 = useLastInput()
    local var5 = useFocusGuiObject()

    local var6 = useLocalization({
        ConfirmLeaveGame = if isPioneerLaunch() and not FFlagPioneerLeaveLogsOut then LocalizationKeys.QuitConfirmation elseif FFlagPioneerLogoutButtonLabel and isPioneerLaunch() and FFlagPioneerLeaveLogsOut then LocalizationKeys.LogoutConfirmation else Constants2.ConfirmLeaveGameLocalizedKey,
        LeaveGame = if isPioneerLaunch() and not FFlagPioneerLeaveLogsOut then LocalizationKeys.QuitButton elseif FFlagPioneerLogoutButtonLabel and isPioneerLaunch() and FFlagPioneerLeaveLogsOut then LocalizationKeys.LogoutButton else Constants2.LeaveGameLocalizedKey,
        DontLeaveGame = if isPioneerLaunch() and not FFlagPioneerLeaveLogsOut then LocalizationKeys.Resume else Constants2.DontLeaveGameLocalizedKey
    })

    local confirmLeaveGame = var6.ConfirmLeaveGame
    local leaveGame2 = var6.LeaveGame

    React.useEffect(function()
        if var4 ~= Input.Touch then
            var5(ref.current)
            return
        end
        var5(nil)
    end, { var4, var5 })

    local onActivated = React.useCallback(function()
        if FFlagPioneerLeaveLogsOut and isPioneerLaunch() then
            leaveGame(false, { leaveReason = PioneerLeaveReason.Logout, inhibitAppRating = true })
        elseif isPioneerLaunch() then
            leaveGame(false, { shouldNativeExit = true })
        else
            leaveGame(true)
        end
    end, { leaveGame })

    local var3 = React.useCallback(function()
        tbl1.dontLeaveFromButton(Utility:IsUsingGamepad())
    end, { Utility, tbl1.dontLeaveFromButton })

    local createElement = React.createElement
    local var9 = View
    local tbl2 = {
        Position = UDim2.new(0, 0, 0, if var2 then 100 else 0),
        tag = "size-full-0 auto-y col"
    }
    local tbl3 = {
        LeaveGameText = React.createElement(FoundationText, {
            Text = confirmLeaveGame,
            Size = UDim2.new(1, 0, 0, if Utility:IsSmallTouchScreen() then 100 else 200),
            LayoutOrder = 1,
            tag = {
                ["text-wrap"] = true,
                ["text-heading-medium"] = not (Utility:IsSmallTouchScreen() or var2),
                ["text-heading-small"] = Utility:IsSmallTouchScreen(),
                ["text-heading-large"] = var2
            }
        }),
        LeaveButtonsContainer = 0
    }

    local createElement2 = React.createElement
    local var10 = View
    local tbl4 = { LayoutOrder = 2, tag = "size-full-0 auto-y row align-x-center gap-xlarge wrap" }

    local tbl5 = {
        LeaveGameButton = React.createElement(Button, {
            text = leaveGame2,
            size = InputSize.Large,
            variant = if FFlagConfirmationButtonsUseGreyButtons then ButtonVariant.Standard else ButtonVariant.SoftEmphasis,
            width = UDim.new(0, if var2 then 300 else 200),
            LayoutOrder = 1,
            ref = ref,
            onActivated = onActivated,
            testId = if FFlagPioneerLogoutButtonLabel then "--leave-game-page-button-leave" else nil
        }),
        DontLeaveGameButton = React.createElement(Button, {
            text = var6.DontLeaveGame,
            size = InputSize.Large,
            variant = ButtonVariant.Subtle,
            width = UDim.new(0, if var2 then 300 else 200),
            LayoutOrder = 2,
            onActivated = var3,
            testId = if FFlagPioneerLogoutButtonLabel then "--leave-game-page-button-dont-leave" else nil
        })
    }
    tbl3.LeaveButtonsContainer = createElement2(var10, tbl4, tbl5)
    return createElement(var9, tbl2, tbl3)
end

local function LeaveGameContainer(tbl1)
    local localization = Localization.new(LocalizationService.RobloxLocaleId)

    return React.createElement(LocalizationProvider, { localization = localization }, {
        FoundationProvider = React.createElement(FoundationProvider, {
            colorMode = Foundation.Enums.ColorMode.Dark
        }, {
            FocusNavigationProvider = React.createElement(
                ReactFocusNavigation.FocusNavigationContext.Provider,
                { value = focusNavigationService },
                {
                    LeaveButtonsContainer = React.createElement(LeaveButtonsContainer, tbl1)
                }
            )
        })
    })
end

local function Initialize()
    local var3 = require(RobloxGui.Modules.Settings.SettingsPageFactory):CreateNewPage()

    var3.playsessionid = ""
    if engineFeature then
        var3.playsessionid = RbxAnalyticsService:GetPlaySessionId()
    end

    function var3.DontLeaveFunc(arg1)
        if var3.HubRef then
            var3.HubRef:PopMenu(arg1, true)
        end

        RbxAnalyticsService:SetRBXEventStream(
            Constants2.AnalyticsTargetName,
            Constants2.AnalyticsInGameMenuName,
            Constants2.AnalyticsLeaveGameName,
            {
                confirmed = Constants2.AnalyticsCancelledName,
                universeid = tostring(game.GameId),
                source = Constants2.AnalyticsLeaveGameSource,
                playsessionid = var3.playsessionid
            }
        )
    end
    function var3.DontLeaveFromHotkey(_, userInputState, arg1)
        if userInputState == Enum.UserInputState.Begin then
            local bool1 = arg1.UserInputType == Enum.UserInputType.Gamepad1
                or arg1.UserInputType == Enum.UserInputType.Gamepad2
                or arg1.UserInputType == Enum.UserInputType.Gamepad3
                or arg1.UserInputType == Enum.UserInputType.Gamepad4

            var3.DontLeaveFunc(bool1)
        end
    end
    function var3.DontLeaveFromButton(arg1)
        var3.DontLeaveFunc(arg1)
    end

    var3.TabHeader = nil

    var3.Page.Name = "LeaveGamePage"
    var3.ShouldShowBottomBar = false
    var3.ShouldShowHubBar = false

    if FFlagRefactorMenuConfirmationButtons then
        function var3.RenderPage()
            var3.PageRoot = ReactRoblox.createRoot(var3.Page)
            var3.PageRoot:render(React.createElement(LeaveGameContainer, { dontLeaveFromButton = var3.DontLeaveFromButton }))
        end

        function var3.UnmountPage()
            if var3.PageRoot then
                var3.PageRoot:unmount()
            end
        end

        var3.Page.Size = UDim2.new(1, 0, 0, 0)
        return var3
    end

    local var4 = if isPioneerLaunch() and not FFlagPioneerLeaveLogsOut then RobloxTranslator:FormatByKey(LocalizationKeys.QuitConfirmation) elseif FFlagPioneerLogoutButtonLabel and isPioneerLaunch() and FFlagPioneerLeaveLogsOut then RobloxTranslator:FormatByKey(LocalizationKeys.LogoutConfirmation) else RobloxTranslator:FormatByKey(Constants2.ConfirmLeaveGameLocalizedKey)
    local var5 = Create("TextLabel")({
        Name = "LeaveGameText",
        Text = var4,
        Font = Theme.font(Enum.Font.SourceSansBold, "Confirmation"),
        FontSize = Theme.fontSize(Enum.FontSize.Size36, "Confirmation"),
        TextColor3 = Color3.new(1, 1, 1),
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 0, 200),
        TextWrapped = true,
        ZIndex = 2,
        Parent = var3.Page,
        Position = var2 and UDim2.new(0, 0, 0, 100) or UDim2.new(0, 0, 0, 0)
    })

    local var6 = Create("Frame")({
        Name = "LeaveButtonContainer",
        Parent = var5,
        Size = UDim2.new(1, 0, 0, 400),
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 0, 1, 0)
    })

    Create("UIGridLayout")({
        Name = "LeavetButtonsLayout",
        CellSize = var2 and UDim2.new(0, 300, 0, 80) or UDim2.new(0, 200, 0, 50),
        CellPadding = UDim2.new(0, 20, 0, 20),
        FillDirection = Enum.FillDirection.Horizontal,
        HorizontalAlignment = Enum.HorizontalAlignment.Center,
        SortOrder = Enum.SortOrder.LayoutOrder,
        VerticalAlignment = Enum.VerticalAlignment.Top,
        Parent = var6
    })

    if Utility:IsSmallTouchScreen() then
        var5.FontSize = Enum.FontSize.Size24
        var5.Size = UDim2.new(1, 0, 0, 100)
    elseif var2 then
        var5.FontSize = Enum.FontSize.Size48
    end

    local var7 = if isPioneerLaunch() and not FFlagPioneerLeaveLogsOut then RobloxTranslator:FormatByKey(LocalizationKeys.QuitButton) elseif FFlagPioneerLogoutButtonLabel and isPioneerLaunch() and FFlagPioneerLeaveLogsOut then RobloxTranslator:FormatByKey(LocalizationKeys.LogoutButton) else "Leave"

    var3.LeaveGameButton = Utility:MakeStyledButton("LeaveGame", var7, nil, function()
        if FFlagPioneerLeaveLogsOut and isPioneerLaunch() then
            leaveGame(false, { leaveReason = PioneerLeaveReason.Logout, inhibitAppRating = true })
        elseif isPioneerLaunch() then
            leaveGame(false, { shouldNativeExit = true })
        else
            leaveGame(true)
        end
    end)
    var3.LeaveGameButton.NextSelectionRight = nil
    var3.LeaveGameButton.Parent = var6

    local var8 = Utility:MakeStyledButton(
        "DontLeaveGame",
        RobloxTranslator:FormatByKey("Feature.SettingsHub.Label.DontLeaveButton"),
        nil,
        var3.DontLeaveFromButton
    )
    var8.NextSelectionLeft = nil
    var8.Parent = var6

    var3.Page.Size = UDim2.new(1, 0, 0, var8.AbsolutePosition.Y + var8.AbsoluteSize.Y)

    return var3
end

local var3 = Initialize()

var3.Displayed.Event:connect(function()
    if FFlagRefactorMenuConfirmationButtons then
        var3.RenderPage()
    end
    if not FFlagRefactorMenuConfirmationButtons then
        GuiService.SelectedCoreObject = var3.LeaveGameButton
    end
    if not FFlagEnableConsoleExpControls then
        ContextActionService:BindCoreAction("LeaveGameCancelAction", var3.DontLeaveFromHotkey, false, Enum.KeyCode.ButtonB)
        return
    end

    if not var1 then
        return
    end

    if FFlagChromeShortcutRemoveRespawnOnLeavePage then
        Service:setShortcutBar(Constants.TILTMENU_LEAVE_DIALOG_SHORTCUTBAR_ID)
        return
    end
    Service:setShortcutBar(Constants.TILTMENU_DIALOG_SHORTCUTBAR_ID)
end)

var3.Hidden.Event:connect(function()
    if FFlagRefactorMenuConfirmationButtons then
        var3.UnmountPage()
    end
    ContextActionService:UnbindCoreAction("LeaveGameCancelAction")
end)

return var3
