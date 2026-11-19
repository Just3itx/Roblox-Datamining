-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T21:20:59Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CoreGui = game:GetService("CoreGui")
local GuiService = game:GetService("GuiService")
local CorePackages = game:GetService("CorePackages")

local UserGameSettings = UserSettings():GetService("UserGameSettings")
local OnScreenProfilerEnabledChanged = UserGameSettings:GetPropertyChangedSignal("OnScreenProfilerEnabled")

local InGameMenuDependencies = require(CorePackages.Packages.InGameMenuDependencies)
local Roact = InGameMenuDependencies.Roact
local RoactRodux = InGameMenuDependencies.RoactRodux
local t = InGameMenuDependencies.t
local UIBlox = InGameMenuDependencies.UIBlox

local withFoundationOrUIBloxStyle = require(CorePackages.Workspace.Packages.CoreGuiCommon).withFoundationOrUIBloxStyle
local Foundation = require(CorePackages.Packages.Foundation)
local normalizeFontFace = Foundation.Utility.normalizeFontFace

local FFlagCoreUiMigrateUIBloxToFoundation = require(CorePackages.Workspace.Packages.SharedFlags).FFlagCoreUiMigrateUIBloxToFoundation
local var1 = if FFlagCoreUiMigrateUIBloxToFoundation then Foundation.UNSTABLE.withCursorMigration else UIBlox.App.SelectionImage.withSelectionCursorProvider
local var2 = if FFlagCoreUiMigrateUIBloxToFoundation then Foundation.Enums.CursorType else UIBlox.App.SelectionImage.CursorKind
local DevConsoleMaster = require(CoreGui.RobloxGui.Modules.DevConsoleMaster)

local scriptParentParentParent = script.Parent.Parent.Parent

local Divider = require(scriptParentParentParent.Components.Divider)
local ExternalEventConnection = require(scriptParentParentParent.Utility.ExternalEventConnection)
local Page = require(script.Parent.Parent.Page)

local CategoryHeader = require(script.Parent.CategoryHeader)
local ToggleEntry = require(script.Parent.ToggleEntry)
local VersionReporter = require(script.Parent.VersionReporter)

local CloseMenu = require(scriptParentParentParent.Thunks.CloseMenu)

local FocusHandler = require(script.Parent.Parent.Connection.FocusHandler)

local withLocalization = require(scriptParentParentParent.Localization.withLocalization)

local SendAnalytics = require(scriptParentParentParent.Utility.SendAnalytics)
local Constants = require(scriptParentParentParent.Resources.Constants)

local Flags = scriptParentParentParent.Flags
local GetFFlagIGMGamepadSelectionHistory = require(Flags.GetFFlagIGMGamepadSelectionHistory)

local var3 = Roact.PureComponent:extend("AdvancedPage")

var3.validateProps = t.strictInterface({
    canCaptureFocus = t.boolean,
    closeMenu = t.callback,
    pageTitle = t.string,
    currentPage = if GetFFlagIGMGamepadSelectionHistory() then t.string or nil else nil,
    currentZone = GetFFlagIGMGamepadSelectionHistory() and t.optional(t.number) or nil
})

function var3.init(arg1)
    arg1:setState({
        microProfilerEnabled = UserGameSettings.OnScreenProfilerEnabled,
        performanceStatsEnabled = UserGameSettings.PerformanceStatsVisible
    })

    arg1.backButtonRef = Roact.createRef()
    arg1.performanceToggleRef = Roact.createRef()
end

if not GetFFlagIGMGamepadSelectionHistory() then
    function var3.didUpdate(arg1, arg2)
        if arg1.props.canCaptureFocus and not arg2.canCaptureFocus then
            GuiService.SelectedCoreObject = arg1.performanceToggleRef:getValue()
        end
    end
end

function var3.renderWithSelectionCursor(arg1, arg2)
    return withFoundationOrUIBloxStyle(function(tokens)
        return {
            Tokens = tokens,
            Theme = {
                TextEmphasis = {
                    Color = tokens.Color.Content.Emphasis.Color3,
                    Transparency = tokens.Color.Content.Emphasis.Transparency
                }
            },
            Font = {
                BaseSize = 1,
                Header2 = {
                    Font = tokens.Typography.TitleLarge.Font,
                    RelativeSize = tokens.Typography.TitleLarge.FontSize
                }
            }
        }
    end, function(arg3)
        return Roact.createElement(Page, {
            pageTitle = arg1.props.pageTitle,
            zIndex = 2,
            position = arg1.props.position,
            buttonRef = arg1.backButtonRef,
            NextSelectionDown = arg1.performanceToggleRef
        }, {
            FocusHandler = if GetFFlagIGMGamepadSelectionHistory() then Roact.createElement(FocusHandler, {
                isFocused = arg1.props.canCaptureFocus,
                shouldForgetPreviousSelection = arg1.props.currentPage ~= Constants.advancedSettingsPageKey or arg1.props.currentZone == 0,
                didFocus = function(selectedCoreObject)
                    GuiService.SelectedCoreObject = selectedCoreObject or arg1.performanceToggleRef:getValue()
                end
            })
                or nil else nil,
            Layout = Roact.createElement("UIListLayout", {
                SortOrder = Enum.SortOrder.LayoutOrder,
                HorizontalAlignment = Enum.HorizontalAlignment.Right,
                VerticalAlignment = Enum.VerticalAlignment.Top
            }),
            AdvancedHeader = Roact.createElement(
                CategoryHeader,
                {
                    LayoutOrder = 1,
                    localizationKey = "CoreScripts.InGameMenu.GameSettings.AdvancedSettingsTitle"
                }
            ),
            PerformanceStats = Roact.createElement(ToggleEntry, {
                LayoutOrder = 2,
                labelKey = "CoreScripts.InGameMenu.GameSettings.ShowPerfStats",
                checked = arg1.state.performanceStatsEnabled,
                onToggled = function()
                    UserGameSettings.PerformanceStatsVisible = not UserGameSettings.PerformanceStatsVisible
                    SendAnalytics(Constants.AnalyticsSettingsChangeName, nil, {}, true)
                end,
                buttonRef = arg1.performanceToggleRef,
                NextSelectionUp = arg1.backButtonRef
            }),
            MicroProfiler = Roact.createElement(ToggleEntry, {
                LayoutOrder = 3,
                labelKey = "CoreScripts.InGameMenu.GameSettings.ShowMicroProfiler",
                checked = arg1.state.microProfilerEnabled,
                onToggled = function()
                    UserGameSettings.OnScreenProfilerEnabled = not UserGameSettings.OnScreenProfilerEnabled
                    SendAnalytics(Constants.AnalyticsSettingsChangeName, nil, {}, true)
                end
            }),
            DeveloperConsole = withLocalization({ text = "CoreScripts.InGameMenu.GameSettings.DeveloperConsole" })(function(arg4)
                local createElement = Roact.createElement
                local tbl1 = {
                    BackgroundTransparency = 1,
                    Size = UDim2.new(1, 0, 0, 54),
                    Text = arg4.text,
                    TextColor3 = arg3.Theme.TextEmphasis.Color,
                    FontFace = normalizeFontFace(arg3.Tokens.Typography.TitleLarge.Font),
                    TextSize = arg3.Font.Header2.RelativeSize * arg3.Font.BaseSize,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    LayoutOrder = 4,
                    SelectionImageObject = arg2(var2.Square)
                }

                tbl1[Roact.Event.Activated] = function()
                    DevConsoleMaster:SetVisibility(true)
                    arg1.props.closeMenu()
                end

                return createElement("TextButton", tbl1, { Padding = Roact.createElement("UIPadding", { PaddingLeft = UDim.new(0, 24) }) })
            end),
            Divider = Roact.createElement(Divider, { Size = UDim2.new(1, -24, 0, 1), LayoutOrder = 5 }),
            VersionReporter = Roact.createElement(VersionReporter, { LayoutOrder = 6 }),
            MicroProfilerVisibilityListener = Roact.createElement(ExternalEventConnection, {
                event = OnScreenProfilerEnabledChanged,
                callback = function()
                    arg1:setState({ microProfilerEnabled = UserGameSettings.OnScreenProfilerEnabled })
                end
            }),
            PerformanceStatsVisibilityListener = Roact.createElement(ExternalEventConnection, {
                event = UserGameSettings.PerformanceStatsVisibleChanged,
                callback = function()
                    arg1:setState({ performanceStatsEnabled = UserGameSettings.PerformanceStatsVisible })
                end
            })
        })
    end)
end

function var3.render(arg1)
    return var1(function(arg2)
        return arg1:renderWithSelectionCursor(arg2)
    end)
end

return RoactRodux.UNSTABLE_connect2(function(arg1)
    local canCaptureFocus = arg1.menuPage == "AdvancedGameSettings"
        and arg1.displayOptions.inputType == Constants.InputType.Gamepad
        and not arg1.respawn.dialogOpen
        and arg1.currentZone == 1
    local currentZone = if GetFFlagIGMGamepadSelectionHistory() then arg1.currentZone else nil
    return {
        canCaptureFocus = canCaptureFocus,
        currentPage = GetFFlagIGMGamepadSelectionHistory() and arg1.menuPage or nil,
        currentZone = currentZone
    }
end, function(callback)
    return {
        closeMenu = function()
            callback(CloseMenu)
        end
    }
end)(var3)
