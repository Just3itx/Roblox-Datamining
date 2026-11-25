-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T03:04:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent

local Players = game:GetService("Players")

local React = require(scriptParentParentParentParent.React)
local CoreGuiCommon = require(scriptParentParentParentParent.CoreGuiCommon)
local Signals = require(scriptParentParentParentParent.Signals)
local SignalsReact = require(scriptParentParentParentParent.SignalsReact)
local Foundation = require(scriptParentParentParentParent.Foundation)

local View = Foundation.View
local FoundationText = Foundation.Text
local ScrollView = Foundation.ScrollView
local useTokens = Foundation.Hooks.useTokens

local Constants = require(scriptParentParentParent.Common.Constants)
local useGamepadStickScroll = CoreGuiCommon.Hooks.useGamepadStickScroll
local useReportPanelContentHeight = require(scriptParentParentParent.Hooks.useReportPanelContentHeight)
local usePlatformLeaderboard = require(scriptParentParentParent.Hooks.usePlatformLeaderboard)
local PlatformEntryView = require(scriptParentParentParent.Components.Presentation.PlatformEntryView)
local EmptyAndErrorStates = require(scriptParentParentParent.Components.Presentation.EmptyAndErrorStates)
local resolveDisplayName = require(scriptParentParentParent.Common.resolveDisplayName)
local getPeopleHeaderLabel = require(scriptParentParentParent.Common.getPeopleHeaderLabel)
local FFlagPlayerListLocalizeGameText = require(scriptParentParentParent.Flags.FFlagPlayerListLocalizeGameText)
local FFlagPlayerListReskin = require(scriptParentParentParent.Flags.FFlagPlayerListReskin)
local useLocalization = require(scriptParentParentParentParent.Localization).Hooks.useLocalization

local LoadingState = EmptyAndErrorStates.LoadingState
local EmptyFriendsState = EmptyAndErrorStates.EmptyFriendsState
local ServiceUnavailableState = EmptyAndErrorStates.ServiceUnavailableState

local LeaderboardViewChangeTelemetry = nil
local function getLeaderboardViewChangeTelemetry() -- Luacid: Inlined by compiler; 2 call sites recovered
    if LeaderboardViewChangeTelemetry == nil then
        LeaderboardViewChangeTelemetry = require(scriptParentParentParent.Common.LeaderboardViewChangeTelemetry)
    end
    return LeaderboardViewChangeTelemetry
end

local signal = Signals.createSignal(nil)
local signal2 = Signals.createSignal(nil)
local var1 = require(scriptParentParentParentParent.CoreScriptsRoactCommon).Utilities.createSignalMap()

local function formatRelativeTimeLegacy(lastRefreshedAt: number?, num1: number): string -- Luacid: Inlined by compiler; 1 call site recovered
    if lastRefreshedAt == nil then
        return "Unable to load"
    end
    local num2 = math.floor((num1 - lastRefreshedAt) / 60)
    return `Last updated {math.max(0, num2)} min ago`
end

return React.memo(function(tbl1) -- name: PlatformLeaderboardViewImpl
    local tab = tbl1.tab
    local bool1 = tab == "Friends"
    local useLegacyPanelStyling = tbl1.legacyPanelBackgroundColor ~= nil
    local var2 = usePlatformLeaderboard()

    local scale = useTokens().Config.UI.Scale
    local rowHeight = Constants.PLATFORM_ROW_HEIGHT * scale
    local yOffset = Constants.PLATFORM_HEADER_HEIGHT * scale
    local yOffset2 = Constants.PLATFORM_FOOTER_HEIGHT * scale
    local rankWidth = Constants.PLATFORM_RANK_WIDTH * scale
    local scoreWidth = Constants.PLATFORM_SCORE_WIDTH * scale

    local var6 = useReportPanelContentHeight(yOffset + rowHeight + yOffset2)
    local scrollingFrameRef = React.useRef(nil)
    local var8 = React.useCallback(function(current)
        scrollingFrameRef.current = current
        var6(current)
    end, { var6 })

    useGamepadStickScroll({
        actionName = "RbxPlayerListReskinGamepadStickScroll",
        scrollingFrameRef = scrollingFrameRef,
        enabled = not useLegacyPanelStyling
    })
    local var9 = if var2 then if bool1 then var2.friendsEntries else var2.globalEntries else var1
    local var10 = if var2 then if bool1 then var2.getFriendsLastRefreshedAt else var2.getGlobalLastRefreshedAt else signal
    local scoreGetter = if var2 then if bool1 then var2.getUserFriendScore else var2.getUserScore else signal
    local rankGetter = if var2 then if bool1 then var2.getUserFriendRank else var2.getUserRank else signal
    local var13 = if var2 then var2.getUnit else signal2
    local var14, var15 = React.useState("loading")
    local var16, var17 = React.useState(0)
    local var18 = React.useRef(false)

    local var19 = SignalsReact.useSignalState(var9.getAllData)

    local var20 = React.useMemo(function()
        return Signals.createComputed(function(arg1): boolean
            return var10(arg1) ~= nil
        end)
    end, { var10 })
    local var21 = SignalsReact.useSignalState(var20)

    local num1 = 0
    for _ in pairs(var19) do
        num1 += 1
    end

    local rankHeader = nil
    local var22

    if FFlagPlayerListLocalizeGameText then
        local var23 = SignalsReact.useSignalState(var10)

        local _, var24 = React.useState(0)
        React.useEffect(function()
            local var25 = nil
            local function schedule() -- Luacid: Inlined by compiler; 1 call site recovered
                var25 = task.delay(300, function()
                    var24(function(arg1): number
                        return arg1 + 1
                    end)
                    schedule()
                end)
            end

            schedule()

            return function()
                if var25 then
                    task.cancel(var25)
                    var25 = nil
                end
            end
        end, {})

        local var25 = if var23 == nil then 0 else math.max(0, math.floor((os.time() - var23) / 60))
        local var26 = useLocalization({
            rankHeader = "InGame.PlayerList.RankHeader",
            footerUnableToLoad = "InGame.PlayerList.FooterUnableToLoad",
            footerLastUpdated = { "InGame.PlayerList.FooterLastUpdated", minutes = var25 }
        })
        rankHeader = var26.rankHeader
        if var23 == nil then
            var22 = var26.footerUnableToLoad
        else
            var22 = var26.footerLastUpdated
        end
    else
        local lastRefreshedAt = SignalsReact.useSignalBinding(var10)

        local tick, var25 = React.useBinding(os.time())
        React.useEffect(function()
            local var26 = nil
            local function schedule() -- Luacid: Inlined by compiler; 1 call site recovered
                var26 = task.delay(300, function()
                    var25(os.time())
                    schedule()
                end)
            end

            schedule()

            return function()
                if var26 then
                    task.cancel(var26)
                    var26 = nil
                end
            end
        end, {})
        var22 = React.useMemo(function()
            return React.joinBindings({ lastRefreshedAt = lastRefreshedAt, tick = tick }):map(function(arg1): string
                return formatRelativeTimeLegacy(arg1.lastRefreshedAt, os.time())
            end)
        end, { lastRefreshedAt, tick })
    end

    React.useEffect(function()
        if var2 then
            var2:fireTabOpened(tab)
        end
        return function()
            if var2 then
                var2:fireTabClosed(tab)
            end
        end
    end, { var2, tab })

    React.useEffect(function()
        var18.current = false
        var15("loading")
        if var21 then
            return function()
                var18.current = true
            end
        end
        local var23 = task.delay(30, function()
            if not var18.current then
                var15("error")
            end
        end)
        return function()
            var18.current = true
            task.cancel(var23)
        end
    end, {
        var2,
        tab,
        var21,
        var16
    })
    if FFlagPlayerListReskin then
        React.useEffect(function()
            if useLegacyPanelStyling or var14 ~= "error" then
                return
            end
            getLeaderboardViewChangeTelemetry().logLoadError(string.lower(tab))
        end, { var14, useLegacyPanelStyling })
    end

    local localPlayer = Players.LocalPlayer
    local displayName = React.useMemo(function()
        if localPlayer then
            return (resolveDisplayName(localPlayer))
        end

        return nil
    end, { localPlayer })

    local scoreLabel = SignalsReact.useSignalState(var13)

    local peopleHeaderText = getPeopleHeaderLabel()

    local onRetry = React.useCallback(function()
        if FFlagPlayerListReskin and not useLegacyPanelStyling then
            getLeaderboardViewChangeTelemetry().logRetryError(string.lower(tab))
        end
        if var2 then
            var2:fireTabClosed(tab)
            var2:fireTabOpened(tab)
        end
        var15("loading")
        var17(function(arg1): number
            return arg1 + 1
        end)
    end, { var2, tab, useLegacyPanelStyling })

    if var2 == nil or not var21 then
        if var14 == "error" then
            return React.createElement(
                ServiceUnavailableState,
                {
                    onRetry = onRetry,
                    layoutOrder = tbl1.layoutOrder,
                    useLegacyPanelStyling = useLegacyPanelStyling
                }
            )
        end

        return React.createElement(LoadingState, { layoutOrder = tbl1.layoutOrder, useLegacyPanelStyling = useLegacyPanelStyling })
    end

    if bool1 and num1 == 0 then
        return React.createElement(
            EmptyFriendsState,
            {
                layoutOrder = tbl1.layoutOrder,
                useLegacyPanelStyling = useLegacyPanelStyling
            }
        )
    end
    local tbl2 = ({})
    for k, value in pairs(var19) do
        local str1 = `Row_{k}`
        tbl2[str1] = React.createElement(PlatformEntryView, {
            scoreGetter = value.getScore,
            rankGetter = value.getRank,
            displayName = value.displayName,
            isViewer = false,
            showDivider = true,
            rowHeight = rowHeight,
            rankWidth = rankWidth,
            scoreWidth = scoreWidth
        })
    end

    local createElement = React.createElement
    local var26 = ScrollView
    local tbl3 = {
        tag = "fill size-full-0",
        layout = {
            FillDirection = Enum.FillDirection.Vertical,
            HorizontalAlignment = Enum.HorizontalAlignment.Left,
            SortOrder = Enum.SortOrder.LayoutOrder
        },
        scroll = {
            AutomaticCanvasSize = if useLegacyPanelStyling then Enum.AutomaticSize.Y else nil,
            ScrollingDirection = Enum.ScrollingDirection.Y
        },
        scrollingFrameRef = 0,
        selection = 0
    }
    if useLegacyPanelStyling then
        var8 = nil
    end

    tbl3.scrollingFrameRef = var8
    tbl3.selection = Constants.NOT_SELECTABLE
    local rows = createElement(var26, tbl3, tbl2)
    local element2

    if useLegacyPanelStyling then
        element2 = React.createElement("Frame", {
            Name = "LegacyPlatformColumnHeader",
            Size = UDim2.new(1, 0, 0, yOffset),
            LayoutOrder = 1,
            BackgroundTransparency = 1,
            BorderSizePixel = 0
        }, {
            Header = React.createElement(PlatformEntryView, {
                isHeader = true,
                scoreLabel = scoreLabel,
                peopleHeaderText = peopleHeaderText,
                rankHeaderText = rankHeader,
                rowHeight = yOffset,
                rankWidth = rankWidth,
                scoreWidth = scoreWidth
            })
        })
    else
        element2 = React.createElement(
            View,
            {
                tag = "size-full-0 bg-surface-100",
                Size = UDim2.new(1, 0, 0, yOffset),
                LayoutOrder = 1
            },
            {
                Header = React.createElement(PlatformEntryView, {
                    isHeader = true,
                    scoreLabel = scoreLabel,
                    peopleHeaderText = peopleHeaderText,
                    rankHeaderText = rankHeader,
                    rowHeight = yOffset,
                    rankWidth = rankWidth,
                    scoreWidth = scoreWidth
                })
            }
        )
    end

    local element3

    if useLegacyPanelStyling then
        element3 = React.createElement("Frame", {
            Name = "LegacyPlatformFooter",
            Size = UDim2.new(1, 0, 0, yOffset2),
            LayoutOrder = 6,
            BackgroundTransparency = 1,
            BorderSizePixel = 0
        }, {
            FooterInner = React.createElement(
                View,
                {
                    tag = "row align-x-right align-y-center size-full padding-x-medium padding-y-xsmall",
                    Size = UDim2.fromScale(1, 1)
                },
                {
                    FooterText = React.createElement(
                        FoundationText,
                        {
                            Text = var22,
                            tag = "auto-xy text-caption-small text-align-x-right content-muted"
                        }
                    )
                }
            )
        })
    else
        element3 = React.createElement(View, {
            tag = "row align-x-right align-y-center size-full-0 padding-x-medium padding-y-xsmall stroke-standard stroke-default bg-surface-100",
            Size = UDim2.new(1, 0, 0, yOffset2),
            LayoutOrder = 6
        }, {
            FooterText = React.createElement(
                FoundationText,
                {
                    Text = var22,
                    tag = "auto-xy text-caption-small text-align-x-right content-muted"
                }
            )
        })
    end

    return React.createElement(View, {
        tag = "col fill size-full-0",
        LayoutOrder = tbl1.layoutOrder
    }, {
        ColumnHeader = element2,
        PinnedViewer = React.createElement(PlatformEntryView, {
            scoreGetter = scoreGetter,
            rankGetter = rankGetter,
            displayName = displayName,
            isViewer = true,
            highlightViewerRow = not useLegacyPanelStyling,
            layoutOrder = 3,
            rowHeight = rowHeight,
            rankWidth = rankWidth,
            scoreWidth = scoreWidth
        }),
        RowList = React.createElement(View, { tag = "col fill size-full-0", LayoutOrder = 5 }, { Rows = rows }),
        Footer = element3
    })
end)
