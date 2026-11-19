-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T21:31:41Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local GuiService = game:GetService("GuiService")
local RobloxGui = game:GetService("CoreGui"):WaitForChild("RobloxGui")

local InGameMenuDependencies = require(CorePackages.Packages.InGameMenuDependencies)
local Roact = InGameMenuDependencies.Roact
local RoactRodux = InGameMenuDependencies.RoactRodux
local t = InGameMenuDependencies.t
local Cryo = InGameMenuDependencies.Cryo

local scriptParentParentParent = script.Parent.Parent.Parent

local Constants = require(scriptParentParentParent.Resources.Constants)
local PlayerLabel = require(scriptParentParentParent.Components.PlayerLabel)
local Divider = require(scriptParentParentParent.Components.Divider)
local BarOnTopScrollingFrame = require(scriptParentParentParent.Components.BarOnTopScrollingFrame)
local GameLabel = require(script.Parent.GameLabel)
local ReportButton = require(script.Parent.ReportButton)
local FocusHandler = require(script.Parent.Parent.Connection.FocusHandler)
local ThemedTextLabel = require(scriptParentParentParent.Components.ThemedTextLabel)
local withLocalization = require(scriptParentParentParent.Localization.withLocalization)

local isShowEUDSAIllegalContentReportingLink = require(CorePackages.Workspace.Packages.DsaIllegalContentReporting).isShowEUDSAIllegalContentReportingLink

local TrustAndSafety = require(RobloxGui.Modules.TrustAndSafety)

local var1 = Roact.PureComponent:extend("ReportList")
local GetFFlagIGMGamepadSelectionHistory = require(scriptParentParentParent.Flags.GetFFlagIGMGamepadSelectionHistory)

var1.validateProps = t.strictInterface({
    placeName = t.string,
    players = t.array(t.union(t.instanceIsA("Player"), t.strictInterface({ UserId = t.integer, Name = t.string }))),
    canCaptureFocus = t.optional(t.boolean),
    currentPage = if GetFFlagIGMGamepadSelectionHistory() then t.optional(t.string) or nil else nil,
    currentZone = GetFFlagIGMGamepadSelectionHistory() and t.optional(t.number) or nil
})

local function sortPlayers(arg1, arg2): boolean
    return arg1.Name:lower() < arg2.Name:lower()
end

function var1.init(arg1)
    arg1.reportGameRef = Roact.createRef()
end

function var1.renderListEntries(arg1)
    local var2 = Cryo.List.sort(arg1.props.players, sortPlayers)

    local num1 = #var2
    local num2 = 3

    local tbl1 = {
        ListLayout = Roact.createElement(
            "UIListLayout",
            {
                SortOrder = Enum.SortOrder.LayoutOrder,
                HorizontalAlignment = Enum.HorizontalAlignment.Right
            }
        )
    }

    if GetFFlagIGMGamepadSelectionHistory() then
        tbl1.FocusHandler = Roact.createElement(FocusHandler, {
            isFocused = arg1.props.canCaptureFocus,
            shouldForgetPreviousSelection = arg1.props.currentPage == Constants.MainPagePageKey or arg1.props.currentZone == 0,
            didFocus = function(selectedCoreObject)
                GuiService.SelectedCoreObject = selectedCoreObject or arg1.reportGameRef:getValue()
            end
        })
    end

    local createElement = Roact.createElement
    local var3 = GameLabel
    local tbl2 = {
        gameId = nil,
        gameId = game.GameId,
        gameName = arg1.props.placeName,
        LayoutOrder = 1,
        [Roact.Ref] = arg1.reportGameRef
    }

    function tbl2.onActivated()
        TrustAndSafety.openReportDialogForPlace(Constants.AnalyticsInGameMenuName)
    end

    tbl1.GameReport = createElement(var3, tbl2, { ReportButton = Roact.createElement(ReportButton, { LayoutOrder = 1 }) })

    if #var2 > 0 then
        tbl1["divider_" .. num2] = Roact.createElement(Divider, { LayoutOrder = 2, Size = UDim2.new(1, -80, 0, 1) })
    end

    for k, value in pairs(var2) do
        local var4 = "player_" .. k
        local createElement2 = Roact.createElement
        local var5 = PlayerLabel
        local tbl3 = {
            username = value.Name,
            userId = value.UserId,
            isOnline = true,
            isSelected = false,
            LayoutOrder = num2,
            onActivated = 0
        }
        function tbl3.onActivated()
            TrustAndSafety.openReportDialogForPlayer(value, Constants.AnalyticsInGameMenuName)
        end
        local tbl4 = {
            ReportButton = Roact.createElement(ReportButton, { userId = value.UserId, userName = value.Name, LayoutOrder = 1 })
        }
        tbl1[var4] = createElement2(var5, tbl3, tbl4)

        num2 += 1

        if not (k < num1) then
            continue
        end

        local str1 = "divider_" .. num2
        tbl1[str1] = Roact.createElement(Divider, { LayoutOrder = num2, Size = UDim2.new(1, -80, 0, 1) })

        num2 += 1
    end

    return tbl1
end

function var1.didUpdate(arg1, arg2, _)
    if not GetFFlagIGMGamepadSelectionHistory() and arg1.props.canCaptureFocus and not arg2.canCaptureFocus then
        GuiService.SelectedCoreObject = arg1.reportGameRef:getValue()
    end
end

function var1.render(arg1)
    local yOffset = #arg1.props.players * 71 + 70

    if not isShowEUDSAIllegalContentReportingLink() then
        return Roact.createElement(
            BarOnTopScrollingFrame,
            {
                Position = UDim2.new(0, 0, 0, 0),
                Size = UDim2.new(1, 0, 1, 0),
                CanvasSize = UDim2.new(1, 0, 0, yOffset)
            },
            arg1:renderListEntries()
        )
    end

    return withLocalization({ DSAFooterText = "CoreScripts.InGameMenu.Report.DSAFooter" })(function(arg2)
        return Roact.createElement(
            "Frame",
            {
                Position = UDim2.new(0, 0, 0, 0),
                Size = UDim2.new(1, 0, 1, -50),
                BackgroundTransparency = 1
            },
            {
                ScrollingFrame = Roact.createElement(
                    BarOnTopScrollingFrame,
                    {
                        Position = UDim2.new(0, 0, 0, 0),
                        Size = UDim2.new(1, 0, 1, -50),
                        CanvasSize = UDim2.new(1, 0, 0, yOffset)
                    },
                    arg1:renderListEntries()
                ),
                EUWarning = Roact.createElement(
                    "Frame",
                    {
                        Size = UDim2.new(1, 0, 0, 50),
                        Position = UDim2.new(0, 0, 1, -50),
                        BackgroundTransparency = 1
                    },
                    {
                        Padding = Roact.createElement(
                            "UIPadding",
                            {
                                PaddingLeft = UDim.new(0, 30),
                                PaddingRight = UDim.new(0, 30),
                                PaddingTop = UDim.new(0, 20)
                            }
                        ),
                        TextLabel = Roact.createElement(ThemedTextLabel, {
                            fontKey = "Footer",
                            themeKey = "TextEmphasis",
                            AnchorPoint = Vector2.new(0.5, 0.5),
                            Position = UDim2.new(0.5, 0, 0.5, 0),
                            Size = UDim2.new(1, 0, 1, 0),
                            TextWrapped = true,
                            Text = arg2.DSAFooterText,
                            TextXAlignment = Enum.TextXAlignment.Center
                        })
                    }
                )
            }
        )
    end)
end

return RoactRodux.UNSTABLE_connect2(function(arg1, _)
    return {
        placeName = arg1.gameInfo.name,
        canCaptureFocus = arg1.menuPage == "Report"
            and arg1.displayOptions.inputType == Constants.InputType.Gamepad
            and not (arg1.report.dialogOpen or arg1.report.reportSentOpen or arg1.respawn.dialogOpen)
            and arg1.currentZone == 1,
        currentPage = if GetFFlagIGMGamepadSelectionHistory() then arg1.menuPage else nil,
        currentZone = if GetFFlagIGMGamepadSelectionHistory() then arg1.currentZone else nil
    }
end)(var1)
