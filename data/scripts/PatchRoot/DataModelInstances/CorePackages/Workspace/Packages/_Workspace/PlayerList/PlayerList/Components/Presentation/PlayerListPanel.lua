-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T03:04:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent

local React = require(scriptParentParentParentParent.React)
local Cryo = require(scriptParentParentParentParent.Cryo)
local SignalsReact = require(scriptParentParentParentParent.SignalsReact)
local Foundation = require(scriptParentParentParentParent.Foundation)
local ReactOtter = require(scriptParentParentParentParent.ReactOtter)
local createSignalMap = require(scriptParentParentParentParent.CoreScriptsRoactCommon).Utilities.createSignalMap
local _LeaderboardStore = require(scriptParentParentParentParent.LeaderboardStore)

local View = Foundation.View
local ScrollView = Foundation.ScrollView
local useTokens = Foundation.Hooks.useTokens

local PanelContentHeightStore = require(scriptParentParentParent.Common.PanelContentHeightStore)
local useReportPanelContentHeight = require(scriptParentParentParent.Hooks.useReportPanelContentHeight)
local usePreferredBackgroundStyle = require(scriptParentParentParent.Hooks.usePreferredBackgroundStyle)

local useLeaderboardStore = require(scriptParentParentParent.Hooks.useLeaderboardStore)
local usePanelLayout = require(scriptParentParentParent.Hooks.usePanelLayout)
local usePlatformLeaderboard = require(scriptParentParentParent.Hooks.usePlatformLeaderboard)
local useSlideOpenCloseAnimation = require(scriptParentParentParent.Hooks.useSlideOpenCloseAnimation)
local useSlideOpenCloseAnimation2 = useSlideOpenCloseAnimation.useSlideOpenCloseAnimation
local PANEL_SLIDE_CONFIG = useSlideOpenCloseAnimation.PANEL_SLIDE_CONFIG
local PANEL_ZOOM_CONFIG = useSlideOpenCloseAnimation.PANEL_ZOOM_CONFIG
local MOBILE_ZOOM_SPRING = useSlideOpenCloseAnimation.MOBILE_ZOOM_SPRING
local MENU_ZOOM_CLOSED_SCALE = useSlideOpenCloseAnimation.MENU_ZOOM_CLOSED_SCALE
local PANEL_RECESS_SCALE = useSlideOpenCloseAnimation.PANEL_RECESS_SCALE
local PANEL_RECESS_TRANSPARENCY = useSlideOpenCloseAnimation.PANEL_RECESS_TRANSPARENCY
local computeStatColumns = require(scriptParentParentParent.Common.computeStatColumns)
local PlayerListVisibilityStore = require(scriptParentParentParent.Common.PlayerListVisibilityStore)
local PlayerContextualMenuStore = require(scriptParentParentParent.Common.PlayerContextualMenuStore)
local toggleContextMenu = PlayerContextualMenuStore.toggleContextMenu
local Constants = require(scriptParentParentParent.Common.Constants)

local PanelHeader = require(scriptParentParentParent.Components.Presentation.PanelHeader)
local ColumnHeaderRow = require(scriptParentParentParent.Components.Presentation.ColumnHeaderRow)
local TeamListView = require(scriptParentParentParent.Components.Presentation.TeamListView)
local ConsoleFocusScrollView = require(scriptParentParentParent.Components.Presentation.ConsoleFocusScrollView)
local EntryView = require(scriptParentParentParent.Components.Presentation.EntryView)
local TabbedLeaderboardBody = require(scriptParentParentParent.Components.Presentation.TabbedLeaderboardBody)

local FFlagPlayerListReskin = require(scriptParentParentParent.Flags.FFlagPlayerListReskin)

local FallbackSignals = require(scriptParentParentParent.Common.FallbackSignals)

local signalMap = createSignalMap()
local signalMap2 = createSignalMap()

local function wrapWithSlide(panelContent, position, xOffset: number, yOffset: number)
    if position == nil then
        return panelContent
    end

    return React.createElement(
        View,
        {
            Size = UDim2.fromOffset(xOffset, yOffset)
        },
        {
            SlideOffset = React.createElement(View, { tag = "size-full", Position = position }, { PanelContent = panelContent })
        }
    )
end

local function createZoomDecorations(scale, transparency, arg1): {UIScale: any}?
    if scale == nil then
        return nil
    end
    local tbl1 = {
        UIScale = React.createElement("UIScale", { Scale = scale })
    }

    if transparency ~= nil then
        tbl1.UIStroke = React.createElement("UIStroke", {
            ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
            Color = arg1.Color.Stroke.Default.Color3,
            Transparency = transparency,
            Thickness = arg1.Stroke.Standard
        })
    end
    return tbl1
end

local function renderWithSlideAndZoomDecorations(arg1, tbl1, tbl2, slidePosition, panelWidth: number, panelHeight: number, zoomDecorations)
    if zoomDecorations ~= nil then
        tbl2 = Cryo.Dictionary.join(tbl2, zoomDecorations)
    end
    return wrapWithSlide(React.createElement(arg1, tbl1, tbl2), slidePosition, panelWidth, panelHeight)
end

local function PlayerListPanelContent(tbl1)
    local bool1 = tbl1.isSmallTouchDevice == true
    local title = tbl1.title
    local platformLeaderboardOverride = tbl1.platformLeaderboardOverride
    local leaderboardStore = useLeaderboardStore()
    local var2 = tbl1.localPlayerOverride or game:GetService("Players").LocalPlayer
    local var3 = if leaderboardStore then leaderboardStore.getTeamList() else signalMap
    local var4 = if leaderboardStore then leaderboardStore.getGameStatsList() else signalMap2
    local allTeams = SignalsReact.useSignalState(var3.getAllData)
    local var6 = SignalsReact.useSignalState(var4.getAllData)
    local count = var4.getCount(false)
    local var7 = if FFlagPlayerListReskin then platformLeaderboardOverride or usePlatformLeaderboard() else nil
    local getHasActiveLeaderboard = if var7 then var7.getHasActiveLeaderboard else FallbackSignals.getHasActiveLeaderboard
    local var8 = if FFlagPlayerListReskin then SignalsReact.useSignalState(getHasActiveLeaderboard) else false
    local var9 = usePanelLayout(bool1, count, var8)

    local var10 = useTokens()
    local backgroundStyle = usePreferredBackgroundStyle(var10.Color.OverMedia.OverMedia_200)

    local var12 = SignalsReact.useSignalState(PlayerListVisibilityStore.getEffectiveVisible)

    local onClose = React.useCallback(function()
        if not PlayerListVisibilityStore.getEffectiveVisible(false) then
            return
        end

        PlayerContextualMenuStore.closeContextMenu()
        PlayerListVisibilityStore.setVisible(false)
    end, {})

    local onActivated = if var12 then toggleContextMenu else nil
    local bool2 = SignalsReact.useSignalState(PlayerContextualMenuStore.getMenuData) ~= nil
    local var15, var16 = ReactOtter.useAnimatedBinding(0)

    React.useEffect(function()
        if not bool1 then
            return
        end
        var16(ReactOtter.spring(if bool2 then 1 else 0, MOBILE_ZOOM_SPRING))
    end, { bool2, bool1 })
    local openCloseOffset = tbl1.openCloseOffset
    local bool3 = bool1 and openCloseOffset ~= nil
    local var17 = React.useMemo(function()
        if not bool3 or openCloseOffset == nil then
            return nil
        end
        return React.joinBindings({ openCloseOffset, var15 }):map(function(arg1)
            local var17 = arg1[1]
            local var18 = arg1[2]
            return (1 + (MENU_ZOOM_CLOSED_SCALE - 1) * var17) * (1 - (1 - PANEL_RECESS_SCALE) * var18)
        end)
    end, { bool3, openCloseOffset, var15 })
    local groupTransparency = React.useMemo(function()
        if not bool3 or openCloseOffset == nil then
            return nil
        end
        return React.joinBindings({ openCloseOffset, var15 }):map(function(tbl2: {number})
            local var18 = tbl2[1]
            local var19 = tbl2[2]
            return 1 - (1 - var18) * (1 - PANEL_RECESS_TRANSPARENCY * var19)
        end)
    end, { bool3, openCloseOffset, var15 })

    local var19 = React.useMemo(function()
        if groupTransparency == nil then
            return nil
        end
        local defaultTransparency = var10.Color.Stroke.Default.Transparency
        return groupTransparency:map(function(num1: number): number
            return defaultTransparency + (1 - defaultTransparency) * num1
        end)
    end, { groupTransparency, var10.Color.Stroke.Default.Transparency })
    local zoomDecorations = createZoomDecorations(var17, var19, var10)

    local scrollingFrameRef = useReportPanelContentHeight(var9.columnHeaderHeight)

    React.useEffect(function()
        return function()
            PanelContentHeightStore.reset()
        end
    end, {})

    local bool4 = if bool1 and var2 ~= nil and leaderboardStore ~= nil then var3.getCount(false) > 0 or count > 0 else false
    local maxStatColumns = var9.maxStatColumns

    local statColumns = React.useMemo(function()
        return computeStatColumns(var4, maxStatColumns)
    end, { var6, var4, maxStatColumns })

    local bool5 = false
    if leaderboardStore then
        for k, value in pairs(allTeams) do
            if value and k ~= "Neutral" then
                bool5 = true
                break
            end
        end
    end

    local scrollViewProps = {
        LayoutOrder = 2,
        tag = "fill size-full-0",
        layout = {
            FillDirection = Enum.FillDirection.Vertical,
            HorizontalAlignment = Enum.HorizontalAlignment.Left
        },
        scroll = {
            AutomaticCanvasSize = nil,
            ScrollingDirection = Enum.ScrollingDirection.Y
        },
        scrollingFrameRef = scrollingFrameRef,
        selectionGroup = Constants.CONSOLE_FOCUS_SCROLL_ESCAPE_UP,
        selection = Constants.NOT_SELECTABLE
    }
    local element

    if leaderboardStore then
        element = React.createElement(ConsoleFocusScrollView, {
            allTeams = allTeams,
            hasNonNeutralTeams = bool5,
            leaderboardStore = leaderboardStore,
            statColumns = statColumns,
            statWidth = var9.statWidth,
            rowHeight = var9.rowHeight,
            columnHeaderHeight = var9.columnHeaderHeight,
            localPlayer = var2,
            scrollViewProps = scrollViewProps,
            onActivated = onActivated
        })
    else
        local tbl3 = ({})
        if leaderboardStore then
            for k, teamEntry in pairs(allTeams) do
                if not teamEntry then
                    continue
                end

                local str1 = `Team_{tostring(k)}`
                tbl3[str1] = React.createElement(TeamListView, {
                    teamEntry = teamEntry,
                    isNeutral = k == "Neutral",
                    hasNonNeutralTeams = bool5,
                    leaderboardStore = leaderboardStore,
                    statColumns = statColumns,
                    statWidth = var9.statWidth,
                    rowHeight = var9.rowHeight,
                    columnHeaderHeight = var9.columnHeaderHeight,
                    onActivated = onActivated,
                    localPlayer = var2
                })
            end
        end
        element = React.createElement(ScrollView, scrollViewProps, tbl3)
    end

    local tbl3 = {
        StickySelfRow = if bool4 then React.createElement(EntryView, {
            player = var2,
            leaderboardStore = leaderboardStore,
            statColumns = statColumns,
            statWidth = var9.statWidth,
            rowHeight = var9.rowHeight,
            onActivated = onActivated,
            isCurrentUser = true,
            layoutOrder = 0
        }) else nil,
        ColumnHeaders = React.createElement(
            ColumnHeaderRow,
            {
                statColumns = statColumns,
                statWidth = var9.statWidth,
                headerHeight = var9.columnHeaderHeight,
                layoutOrder = 1
            }
        ),
        PlayerRows = element
    }

    local bool6 = var19 == nil
    local panelProps = React.useMemo(function()
        return {
            Size = UDim2.fromOffset(var9.panelWidth, var9.panelHeight),
            tag = { ["col radius-medium"] = true, ["stroke-standard stroke-default"] = bool6 },
            backgroundStyle = backgroundStyle,
            Visible = true,
            GroupTransparency = groupTransparency,
            selectionGroup = Constants.CONSOLE_FOCUS_ISOLATE,
            selection = Constants.NOT_SELECTABLE
        }
    end, {
        var9.panelWidth,
        var9.panelHeight,
        bool6,
        backgroundStyle,
        groupTransparency
    })

    local element2 = React.createElement(
        PanelHeader,
        {
            onClose = onClose,
            isDisabled = not var12,
            height = var9.headerHeight,
            title = title,
            layoutOrder = 1
        }
    )

    local element3 = React.createElement(Foundation.Divider, { LayoutOrder = 2 })

    if not FFlagPlayerListReskin then
        return renderWithSlideAndZoomDecorations(
            View,
            panelProps,
            {
                Header = element2,
                HeaderDivider = element3,
                LeaderboardBody = React.createElement(View, { LayoutOrder = 3, tag = "col fill size-full-0" }, tbl3)
            },
            tbl1.slidePosition,
            var9.panelWidth,
            var9.panelHeight,
            zoomDecorations
        )
    end

    local serverBody = React.createElement(View, { LayoutOrder = 4, tag = "col fill size-full-0" }, tbl3)

    return renderWithSlideAndZoomDecorations(
        TabbedLeaderboardBody,
        {
            serverBody = serverBody,
            panelHeader = element2,
            panelDivider = element3,
            panelProps = panelProps
        },
        {},
        tbl1.slidePosition,
        var9.panelWidth,
        var9.panelHeight,
        zoomDecorations
    )
end
return React.memo(function(tbl1) -- name: PlayerListPanel
    local var1 = SignalsReact.useSignalState(PlayerListVisibilityStore.getEffectiveVisible)
    local bool1 = tbl1.isSmallTouchDevice == true

    local var2 = useSlideOpenCloseAnimation2(var1, if bool1 then PANEL_ZOOM_CONFIG else PANEL_SLIDE_CONFIG)
    if not var2.shouldMount then
        return nil
    end
    return React.createElement(PlayerListPanelContent, {
        isSmallTouchDevice = tbl1.isSmallTouchDevice,
        title = tbl1.title,
        localPlayerOverride = tbl1.localPlayerOverride,
        platformLeaderboardOverride = tbl1.platformLeaderboardOverride,
        slidePosition = if bool1 then nil else var2.position,
        openCloseOffset = if bool1 then var2.offset else nil
    })
end)
