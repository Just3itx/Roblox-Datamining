-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T00:20:34Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarEditorService = game:GetService("AvatarEditorService")
local CoreGui = game:GetService("CoreGui")
local ContextActionService = game:GetService("ContextActionService")
local RobloxGui = CoreGui:WaitForChild("RobloxGui")
local GuiService = game:GetService("GuiService")
local Players = game:GetService("Players")
local RbxAnalyticsService = game:GetService("RbxAnalyticsService")
local CorePackages = game:GetService("CorePackages")
local LocalizationService = game:GetService("LocalizationService")

local Utility = require(RobloxGui.Modules.Settings.Utility)
local Theme = require(RobloxGui.Modules.Settings.Theme)
local Create = require(CorePackages.Workspace.Packages.AppCommonLib).Create
local Cryo = require(CorePackages.Packages.Cryo)
local React = require(CorePackages.Packages.React)
local ReactRoblox = require(CorePackages.Packages.ReactRoblox)

local ReactFocusNavigation = require(CorePackages.Packages.ReactFocusNavigation)
local useFocusGuiObject = ReactFocusNavigation.useFocusGuiObject

local Responsive = require(CorePackages.Workspace.Packages.Responsive)
local Input = Responsive.Input
local useLastInput = Responsive.useLastInput

local Localization = require(CorePackages.Workspace.Packages.InExperienceLocales).Localization
local LocalizationProvider = require(CorePackages.Workspace.Packages.Localization).LocalizationProvider
local useLocalization = require(CorePackages.Workspace.Packages.Localization).Hooks.useLocalization

local Foundation = require(CorePackages.Packages.Foundation)

local var1 = require(CorePackages.Workspace.Packages.Chrome).Enabled()
local Service = if var1 then require(RobloxGui.Modules.Chrome.Service) else nil
local Constants = if var1 then require(RobloxGui.Modules.Chrome.ChromeShared.Unibar.Constants) else nil
local SharedFlags = require(CorePackages.Workspace.Packages.SharedFlags)

RobloxGui:WaitForChild("Modules"):WaitForChild("TenFootInterface")
local FFlagResponsiveUnitsDeprecateTenFoot = SharedFlags.FFlagResponsiveUnitsDeprecateTenFoot
local var2 = require(RobloxGui.Modules.TenFootInterface):IsEnabled() and not FFlagResponsiveUnitsDeprecateTenFoot

local FFlagEnableConsoleExpControls = SharedFlags.FFlagEnableConsoleExpControls
local FFlagChromeShortcutRemoveLeaveOnRespawnPage = SharedFlags.FFlagChromeShortcutRemoveLeaveOnRespawnPage
local FFlagRespawnActionChromeShortcutTelemetry = require(RobloxGui.Modules.Chrome.Flags.FFlagRespawnActionChromeShortcutTelemetry)
local FFlagRefactorMenuConfirmationButtons = require(RobloxGui.Modules.Settings.Flags.FFlagRefactorMenuConfirmationButtons)
local FFlagConfirmationButtonsUseGreyButtons = require(RobloxGui.Modules.Settings.Flags.FFlagConfirmationButtonsUseGreyButtons)
local FFlagRenameRespawnConfirmationPage = SharedFlags.FFlagRenameRespawnConfirmationPage

local Constants2 = require(RobloxGui.Modules:WaitForChild("InGameMenu"):WaitForChild("Resources"):WaitForChild("Constants"))

local focusNavigationService = ReactFocusNavigation.FocusNavigationService.new(ReactFocusNavigation.EngineInterface.CoreGui)

local FoundationProvider = Foundation.FoundationProvider
local Button = Foundation.Button
local ButtonVariant = Foundation.Enums.ButtonVariant
local InputSize = Foundation.Enums.InputSize
local FoundationText = Foundation.Text
local View = Foundation.View

local function ResetCharacterButtonsContainer(tbl1)
    local ref = React.useRef(nil)

    local var4 = useLastInput()
    local var5 = useFocusGuiObject()

    local var6 = useLocalization({
        ConfirmResetCharacter = Constants2.ConfirmResetCharacterLocalizedKey,
        ResetCharacter = if FFlagRenameRespawnConfirmationPage then Constants2.RespawnLocalizedKey else Constants2.ResetCharacterLocalizedKey,
        DontResetCharacter = Constants2.DontResetCharacterLocalizedKey
    })

    React.useEffect(function()
        if var4 ~= Input.Touch then
            var5(ref.current)
            return
        end
        var5(nil)
    end, { var4, var5 })

    local onActivated = React.useCallback(function()
        tbl1.dontResetCharFromButton(Utility:IsUsingGamepad())
    end, { Utility, tbl1.dontResetCharFromButton })

    local createElement = React.createElement
    local var8 = View
    local tbl2 = {
        Position = UDim2.new(0, 0, 0, if var2 then 100 else 0),
        tag = "size-full-0 auto-y col"
    }
    local tbl3 = {
        ResetCharacterText = React.createElement(FoundationText, {
            Text = var6.ConfirmResetCharacter,
            Size = UDim2.new(1, 0, 0, if Utility:IsSmallTouchScreen() then 100 else 200),
            LayoutOrder = 1,
            tag = {
                ["text-wrap"] = true,
                ["text-heading-medium"] = not (Utility:IsSmallTouchScreen() or var2),
                ["text-heading-small"] = Utility:IsSmallTouchScreen(),
                ["text-heading-large"] = var2
            }
        }),
        ButtonsContainer = 0
    }

    local createElement2 = React.createElement
    local var9 = View
    local tbl4 = { LayoutOrder = 2, tag = "size-full-0 auto-y row align-x-center gap-xlarge wrap" }

    local tbl5 = {
        ResetCharacterButton = React.createElement(Button, {
            text = var6.ResetCharacter,
            size = InputSize.Large,
            variant = if FFlagConfirmationButtonsUseGreyButtons then ButtonVariant.Standard else ButtonVariant.SoftEmphasis,
            width = UDim.new(0, if var2 then 300 else 200),
            LayoutOrder = 1,
            ref = ref,
            onActivated = tbl1.onResetFunction
        }),
        DontResetCharacterButton = React.createElement(Button, {
            text = var6.DontResetCharacter,
            size = InputSize.Large,
            variant = ButtonVariant.Subtle,
            width = UDim.new(0, if var2 then 300 else 200),
            LayoutOrder = 2,
            onActivated = onActivated
        })
    }
    tbl3.ButtonsContainer = createElement2(var9, tbl4, tbl5)
    return createElement(var8, tbl2, tbl3)
end

local function ResetCharacterContainer(tbl1)
    local localization = Localization.new(LocalizationService.RobloxLocaleId)

    return React.createElement(LocalizationProvider, { localization = localization }, {
        FoundationProvider = React.createElement(FoundationProvider, {
            colorMode = Foundation.Enums.ColorMode.Dark
        }, {
            FocusNavigationProvider = React.createElement(
                ReactFocusNavigation.FocusNavigationContext.Provider,
                { value = focusNavigationService },
                {
                    ResetCharacterButtonsContainer = React.createElement(ResetCharacterButtonsContainer, tbl1)
                }
            )
        })
    })
end

local function Initialize()
    local var3 = require(RobloxGui.Modules.Settings.SettingsPageFactory):CreateNewPage()

    function var3.DontResetCharFunc(arg1)
        RbxAnalyticsService:SetRBXEventStream(
            Constants2.AnalyticsTargetName,
            Constants2.AnalyticsInGameMenuName,
            Constants2.AnalyticsRespawnCharacterName,
            {
                confirmed = Constants2.AnalyticsCancelledName,
                universeid = tostring(game.GameId)
            }
        )

        if var3.HubRef then
            var3.HubRef:PopMenu(arg1, true)
        end
    end
    function var3.DontResetCharFromHotkey(_, userInputState, arg1)
        if userInputState == Enum.UserInputState.Begin then
            local bool1 = arg1.UserInputType == Enum.UserInputType.Gamepad1
                or arg1.UserInputType == Enum.UserInputType.Gamepad2
                or arg1.UserInputType == Enum.UserInputType.Gamepad3
                or arg1.UserInputType == Enum.UserInputType.Gamepad4

            var3.DontResetCharFunc(bool1)
        end
    end
    function var3.DontResetCharFromButton(arg1)
        var3.DontResetCharFunc(arg1)
    end

    var3.TabHeader = nil

    var3.Page.Name = "ResetCharacter"
    var3.ShouldShowBottomBar = false
    var3.ShouldShowHubBar = false
    local var4

    if FFlagRefactorMenuConfirmationButtons then
        var4 = nil
    else
        local var5 = Create("TextLabel")({
            Name = "ResetCharacterText",
            Text = if FFlagRenameRespawnConfirmationPage then "Are you sure you want to respawn your character?" else "Are you sure you want to reset your character?",
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

        var4 = Create("Frame")({
            Name = "ResetButtonContainer",
            Parent = var5,
            Size = UDim2.new(1, 0, 0, 400),
            BackgroundTransparency = 1,
            Position = UDim2.new(0, 0, 1, 0)
        })

        Create("UIGridLayout")({
            Name = "ResetButtonsLayout",
            CellSize = var2 and UDim2.new(0, 300, 0, 80) or UDim2.new(0, 200, 0, 50),
            CellPadding = UDim2.new(0, 20, 0, 20),
            FillDirection = Enum.FillDirection.Horizontal,
            HorizontalAlignment = Enum.HorizontalAlignment.Center,
            SortOrder = Enum.SortOrder.LayoutOrder,
            VerticalAlignment = Enum.VerticalAlignment.Top,
            Parent = var4
        })

        if Utility:IsSmallTouchScreen() then
            var5.FontSize = Enum.FontSize.Size24
            var5.Size = UDim2.new(1, 0, 0, 100)
        elseif var2 then
            var5.FontSize = Enum.FontSize.Size48
        end
    end

    local function func1(tbl1)
        local localPlayer = Players.LocalPlayer
        if localPlayer then
            local character = localPlayer.Character
            if character then
                local humanoid = character:FindFirstChild("Humanoid")
                if humanoid then
                    humanoid.Health = 0
                end
            end
        end

        local additionalArgs = {
            confirmed = Constants2.AnalyticsConfirmedName,
            universeid = 0
        }
        local gameId = game.GameId
        additionalArgs.universeid = tostring(gameId)
        if FFlagRespawnActionChromeShortcutTelemetry and tbl1 and type(tbl1) == "table" and tbl1.resetTelemetryFields then
            additionalArgs = Cryo.Dictionary.join(additionalArgs, tbl1.resetTelemetryFields)
        end
        RbxAnalyticsService:SetRBXEventStream(
            Constants2.AnalyticsTargetName,
            Constants2.AnalyticsInGameMenuName,
            Constants2.AnalyticsRespawnCharacterName,
            additionalArgs
        )
        RbxAnalyticsService:ReportCounter("InGameMenu-ResetCharacter")
    end

    var3.ResetBindable = true

    local function func2(tbl1)
        AvatarEditorService:BustAvatarFetchCache()

        if var3.ResetBindable == true then
            func1(tbl1)
        elseif var3.ResetBindable then
            var3.ResetBindable:Fire()
        end
        if var3.HubRef then
            var3.HubRef:SetVisibility(false, true)
        end
    end

    if FFlagEnableConsoleExpControls then
        var3.ResetFunction = func2
    end

    if not FFlagRefactorMenuConfirmationButtons then
        var3.ResetCharacterButton = Utility:MakeStyledButton(
            "ResetCharacter",
            if FFlagRenameRespawnConfirmationPage then "Respawn" else "Reset",
            nil,
            func2
        )
        var3.ResetCharacterButton.NextSelectionRight = nil
        var3.ResetCharacterButton.Parent = var4

        local var5 = Utility:MakeStyledButton(
            "DontResetCharacter",
            if FFlagRenameRespawnConfirmationPage then "Don't Respawn" else "Don't Reset",
            nil,
            var3.DontResetCharFromButton
        )
        var5.NextSelectionLeft = nil
        var5.Parent = var4

        var3.Page.Size = UDim2.new(1, 0, 0, var5.AbsolutePosition.Y + var5.AbsoluteSize.Y)
    end

    if FFlagRefactorMenuConfirmationButtons then
        function var3.RenderPage()
            var3.PageRoot = ReactRoblox.createRoot(var3.Page)
            var3.PageRoot:render(
                React.createElement(
                    ResetCharacterContainer,
                    {
                        onResetFunction = func2,
                        dontResetCharFromButton = var3.DontResetCharFromButton
                    }
                )
            )
        end

        function var3.UnmountPage()
            if var3.PageRoot then
                var3.PageRoot:unmount()
            end
        end

        var3.Page.Size = UDim2.new(1, 0, 0, 0)
    end

    return var3
end

local var3 = Initialize()
local bool1 = false

var3.Displayed.Event:connect(function()
    bool1 = true
    if FFlagRefactorMenuConfirmationButtons then
        var3.RenderPage()
    end
    if not FFlagRefactorMenuConfirmationButtons then
        GuiService.SelectedCoreObject = var3.ResetCharacterButton
    end
    if not FFlagEnableConsoleExpControls then
        ContextActionService:BindCoreAction("ResetCharacterAction", var3.DontResetCharFromHotkey, false, Enum.KeyCode.ButtonB)
        return
    end

    if not var1 then
        return
    end

    if FFlagChromeShortcutRemoveLeaveOnRespawnPage then
        Service:setShortcutBar(Constants.TILTMENU_RESPAWN_DIALOG_SHORTCUTBAR_ID)
        return
    end
    Service:setShortcutBar(Constants.TILTMENU_DIALOG_SHORTCUTBAR_ID)
end)

var3.Hidden.Event:connect(function()
    bool1 = false
    if FFlagRefactorMenuConfirmationButtons then
        var3.UnmountPage()
    end
    ContextActionService:UnbindCoreAction("ResetCharacterAction")
end)

function var3.SetResetCallback(_, resetBindable)
    if resetBindable == false and bool1 then
        var3.HubRef:PopMenu(nil, true)
    end
    var3.ResetBindable = resetBindable
end

return var3
