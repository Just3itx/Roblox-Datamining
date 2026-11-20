-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T01:17:44Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local Players = game:GetService("Players")

local Cryo = require(CorePackages.Packages.Cryo)
local Roact = require(CorePackages.Packages.Roact)
local RoactRodux = require(CorePackages.Packages.RoactRodux)
local UIBlox = require(CorePackages.Packages.UIBlox)
local t = require(CorePackages.Packages.t)

local scriptParentParent = script.Parent.Parent
local Dependencies = require(scriptParentParent.Dependencies)
local BarOnTopScrollingFrame = require(Dependencies.BarOnTopScrollingFrame)
local Divider = require(Dependencies.Divider)
local PlayerCell = require(Dependencies.PlayerCell)
local PlayerSearchPredicate = require(Dependencies.PlayerSearchPredicate)
local SearchBar = require(Dependencies.SearchBar)
local _ThemedTextLabel = require(Dependencies.ThemedTextLabel)
local withLocalization = require(Dependencies.withLocalization)

local NavigateBack = require(scriptParentParent.Actions.NavigateBack)
local EndReportFlow = require(scriptParentParent.Actions.EndReportFlow)
local SelectReportListing = require(scriptParentParent.Actions.SelectReportListing)
local _Assets = require(scriptParentParent.Resources.Assets)
local Constants = require(scriptParentParent.Resources.Constants)
local ModalDialog = require(scriptParentParent.Components.ModalDialog)
local GameCell = require(scriptParentParent.Components.GameCell)
local SendAnalytics = require(scriptParentParent.Utility.SendAnalytics)
local SessionUtility = require(scriptParentParent.Utility.SessionUtility)

local RobloxGui = game:GetService("CoreGui"):WaitForChild("RobloxGui")
local default = require(RobloxGui.Modules.VoiceChat.VoiceChatServiceManager).default
local VoiceIndicatorFunc = require(RobloxGui.Modules.VoiceChat.Components.VoiceIndicatorFunc)
local VoiceStateContext = require(RobloxGui.Modules.VoiceChat.VoiceStateContext)
local Constants2 = require(RobloxGui.Modules.VoiceChat.Constants)
local React = require(CorePackages.Packages.React)

local Colors = UIBlox.App.Style.Colors

local HeaderBar = UIBlox.App.Bar.HeaderBar
local IconButton = UIBlox.App.Button.IconButton
local IconSize = UIBlox.App.ImageSet.Enum.IconSize
local Provider = UIBlox.Core.Style.Provider
local Images = UIBlox.App.ImageSet.Images
local withStyle = UIBlox.Core.Style.withStyle

local isPlayerVerified = require(CorePackages.Workspace.Packages.UserLib).Utils.isPlayerVerified
local makeBackButton = require(CorePackages.Workspace.Packages.AppHeaderBar).makeBackButton

local tbl1 = {
    BackgroundDefault = {
        Color = Colors.Flint,
        Transparency = 1
    }
}

local var1 = Roact.PureComponent:extend("ReportMenu")

local function func1(arg1)
    if not React.useContext(VoiceStateContext.Context).voiceEnabled then
        return nil
    end
    return React.createElement(VoiceIndicatorFunc, Cryo.Dictionary.join(arg1, {}))
end

var1.validateProps = t.strictInterface({
    isReportMenuOpen = t.boolean,
    screenSize = t.Vector2,
    closeDialog = t.callback,
    openReportDialog = t.callback,
    canNavigateBack = t.boolean,
    reportCategory = t.optional(t.string),
    navigateBack = t.optional(t.callback)
})

function var1.init(arg1)
    arg1.scrollingFrameRef = Roact.createRef()

    arg1.state = { isFilterMode = false, filterText = nil }

    function arg1.onSearch()
        arg1:setState({ isFilterMode = true, filterText = "" })
    end

    function arg1.onTextChanged(filterText)
        arg1:setState({ filterText = filterText })
    end

    function arg1.onCancel()
        arg1:setState({ isFilterMode = false, filterText = Roact.None })
    end

    function arg1.scrollToTop()
        local value = arg1.scrollingFrameRef:getValue()
        if value then
            value:scrollToTop()
        end
    end

    function arg1.navigateBack()
        arg1.props.navigateBack(arg1.state.filterText ~= nil)
    end

    function arg1.closeDialog()
        arg1.props.closeDialog(arg1.state.filterText ~= nil)
    end

    arg1.layoutBindings = {}
    function arg1.getLayoutBinding(arg2, value)
        local layoutBinding = arg1.layoutBindings[arg2]
        if not layoutBinding then
            local valueBinding, setValue = Roact.createBinding(value)
            layoutBinding = { valueBinding = valueBinding, setValue = setValue, value = value }

            arg1.layoutBindings[arg2] = layoutBinding
        end

        if layoutBinding.value ~= value then
            layoutBinding.value = value
            layoutBinding.setValue(value)
        end

        return layoutBinding.valueBinding
    end

    function arg1.playerIsVoiceActive(num1: number): boolean
        return default.participants[tostring(num1)] ~= nil
    end

    arg1.sortedUserIds = {}
end

local function sortPlayers(arg1, arg2): boolean
    return arg1.DisplayName:lower() < arg2.DisplayName:lower()
end

function var1.getPlayerList(arg1)
    local tbl2 = {}
    local var2 = Cryo.List.sort(Players:GetPlayers(), sortPlayers)

    for _, value in ipairs(var2) do
        if value ~= Players.LocalPlayer
            and (not arg1.state.isFilterMode or PlayerSearchPredicate(arg1.state.filterText, value.Name, value.DisplayName))
        then
            table.insert(tbl2, value)
        end
    end

    return (Cryo.List.sort(tbl2, function(arg2, arg3): boolean
        return arg2.DisplayName:lower() < arg3.DisplayName:lower()
    end))
end
local tbl2 = {
    [Constants.Category.Voice] = "CoreScripts.InGameMenu.Report.Title.VoiceChat",
    [Constants.Category.Text] = "CoreScripts.InGameMenu.Report.Title.TextChat",
    [Constants.Category.Other] = "CoreScripts.InGameMenu.Report.Title.Other"
}

function var1.categoryTitle(arg1)
    return tbl2[arg1.props.reportCategory] or "CoreScripts.InGameMenu.Report.MenuTitle"
end

function var1.renderHeaderBar(arg1)
    local renderLeft = not arg1.props.canNavigateBack and function()
        return Roact.createElement(
            IconButton,
            {
                iconSize = IconSize.Medium,
                icon = Images["icons/navigation/close"],
                onActivated = arg1.closeDialog
            }
        )
    end or makeBackButton(arg1.navigateBack)

    if arg1.state.isFilterMode then
        return Roact.createElement(
            "Frame",
            {
                BackgroundTransparency = 1,
                Position = UDim2.fromOffset(24, 6),
                Size = UDim2.new(1, -48, 1, -12)
            },
            { Roact.createElement(SearchBar, {
                    size = UDim2.fromScale(1, 1),
                    text = arg1.state.filterText,
                    autoCaptureFocus = true,
                    onTextChanged = arg1.onTextChanged,
                    onCancelled = arg1.onCancel
                }) }
        )
    end

    return withLocalization({ titleText = arg1:categoryTitle() })(function(arg2)
        return Roact.createElement(HeaderBar, {
            backgroundTransparency = 1,
            barHeight = 48,
            renderLeft = renderLeft,
            renderRight = function()
                return Roact.createElement(
                    IconButton,
                    {
                        iconSize = IconSize.Medium,
                        icon = Images["icons/common/search"],
                        onActivated = arg1.onSearch
                    }
                )
            end,
            onHeaderActivated = arg1.scrollToTop,
            title = arg2.titleText
        })
    end)
end

function var1.renderContents(arg1)
    local props = arg1.props
    local bool1 = arg1.props.reportCategory == Constants.Category.Voice

    local num1 = 0
    local tbl3 = {
        ListLayout = Roact.createElement(
            "UIListLayout",
            {
                FillDirection = Enum.FillDirection.Vertical,
                SortOrder = Enum.SortOrder.LayoutOrder
            }
        )
    }
    if not arg1.state.isFilterMode and arg1.props.reportCategory == Constants.Category.None then
        tbl3.GameCell = Roact.createElement(GameCell, {
            gameId = game.GameId,
            layoutOrder = arg1.getLayoutBinding("GameCell", num1),
            onActivated = function()
                props.openReportDialog(Constants.ReportType.Place, nil)
            end
        })
    end
    local num2 = num1 + 1
    local yOffset = 72

    local playerList = arg1:getPlayerList()

    local var2 = not bool1 and {} or default:getRecentUsersInteractionData()

    arg1.sortedUserIds = {}

    for _, value in pairs(playerList) do
        local str1 = tostring(value.UserId)

        if bool1 and not var2[tostring(value.UserId)] then
            continue
        end

        table.insert(arg1.sortedUserIds, value.UserId)

        local num3 = 0
        if bool1 then
            num3 += 1
        end
        if arg1.props.isReportMenuOpen then
            num3 += 2
        end
        local str2 = "Divider" .. str1
        local createElement = Roact.createElement
        local var3 = Divider
        local tbl4 = {
            LayoutOrder = arg1.getLayoutBinding("Divider" .. str1, num2),
            Size = UDim2.new(1, 0, 0, 1)
        }
        tbl3[str2] = createElement(var3, tbl4)

        local num4 = num2 + 1

        local str3 = "PlayerCell" .. str1
        local createElement2 = Roact.createElement
        local var4 = PlayerCell
        local tbl5 = {
            userId = value.UserId,
            username = value.Name,
            displayName = value.DisplayName,
            hasVerifiedBadge = isPlayerVerified(value),
            isOnline = true,
            isSelected = false,
            LayoutOrder = arg1.getLayoutBinding("PlayerCell" .. str1, num4),
            onActivated = 0,
            memoKey = 0
        }

        function tbl5.onActivated()
            props.openReportDialog(Constants.ReportType.Player, value)
        end
        tbl5.memoKey = num3
        local tbl6 = { VoiceIndicator = 0 }
        local var5

        if bool1 and arg1.props.isReportMenuOpen then
            local createElement3 = Roact.createElement
            local func2 = func1
            local tbl7 = {
                userId = tostring(value.UserId),
                hideOnError = true,
                iconStyle = "SpeakerLight",
                size = UDim2.fromOffset(36, 36),
                onClicked = 0
            }

            function tbl7.onClicked()
                default:ToggleMutePlayer(value.UserId, Constants2.VOICE_CONTEXT_TYPE.REPORT_MENU)
            end

            var5 = createElement3(func2, tbl7) or nil
        else
            var5 = nil
        end

        tbl6.VoiceIndicator = var5
        tbl3[str3] = createElement2(var4, tbl5, tbl6)

        num2 = num4 + 1

        yOffset += 73
    end
    tbl3.DividerEnd = Roact.createElement(Divider, { LayoutOrder = arg1.getLayoutBinding("DividerEnd", num2), Size = UDim2.new(1, 0, 0, 1) })

    local _ = num2 + 1

    return withStyle(function(arg2)
        local theme = Cryo.Dictionary.join(arg2.Theme, tbl1)
        local style = Cryo.Dictionary.join(arg2, { Theme = theme })

        return Roact.createElement(Provider, { style = style }, { Roact.createElement(
                BarOnTopScrollingFrame,
                {
                    Size = UDim2.fromScale(1, 1),
                    CanvasSize = UDim2.new(1, 0, 0, yOffset),
                    scrollingFrameRef = arg1.scrollingFrameRef
                },
                tbl3
            ) })
    end)
end

function var1.render(arg1)
    local bool1 = arg1.props.reportCategory ~= nil

    return Roact.createFragment({
        ModalDialog = Roact.createElement(ModalDialog, {
            visible = arg1.props.isReportMenuOpen,
            screenSize = arg1.props.screenSize,
            headerBar = arg1:renderHeaderBar(),
            showCloseButton = not bool1,
            contents = arg1:renderContents(),
            onDismiss = arg1.closeDialog
        })
    })
end

function var1.didUpdate(arg1, arg2)
    if not arg2.isReportMenuOpen or arg1.props.isReportMenuOpen then
        return
    end
    arg1:setState({ isFilterMode = false, filterText = Roact.None })

    local value = arg1.scrollingFrameRef:getValue()
    if value and value.CanvasPosition.Y > 0 then
        value.CanvasPosition = Vector2.new(0, 0)
    end
end

return RoactRodux.UNSTABLE_connect2(function(arg1, _)
    return {
        isReportMenuOpen = arg1.report.currentPage == Constants.Page.Listing,
        screenSize = arg1.displayOptions.screenSize,
        reportCategory = arg1.report.reportCategory,
        canNavigateBack = #arg1.report.history > 1
    }
end, function(callback)
    return {
        navigateBack = function(filterTextChanged)
            callback(NavigateBack())
            SendAnalytics(
                Constants.Page.Listing,
                Constants.Analytics.ReportFlowBack,
                {
                    source = Constants.Page.Listing,
                    filterTextChanged = filterTextChanged
                }
            )
        end,
        closeDialog = function(filterTextChanged)
            callback(EndReportFlow())
            SendAnalytics(
                Constants.Page.Listing,
                Constants.Analytics.ReportFlowAbandoned,
                {
                    source = Constants.Page.Listing,
                    filterTextChanged = filterTextChanged
                }
            )
            SessionUtility.endAbuseReportSession()
        end,
        openReportDialog = function(reportType, arg1, arg2)
            callback(SelectReportListing(reportType, arg1, arg2))
            SendAnalytics(
                Constants.Page.Listing,
                Constants.Analytics.ReportFlowAdvance,
                {
                    source = Constants.Page.Listing,
                    reportType = reportType
                }
            )
        end
    }
end)(var1)
