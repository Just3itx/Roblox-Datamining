-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T11:01:27Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SduiSharedContent = script:FindFirstAncestor("SduiSharedContent")
local SduiSharedContentParent = SduiSharedContent.Parent

local React = require(SduiSharedContentParent.React)
local Foundation = require(SduiSharedContentParent.Foundation)
local View = Foundation.View
local useTokens = Foundation.Hooks.useTokens
local useAnimateScrollViewToSelection = require(SduiSharedContentParent.AppBlox).useAnimateScrollViewToSelection
local AppNavBar = require(SduiSharedContentParent.AppNavBar)
local useNavBarPlacement = AppNavBar.useNavBarPlacement
local useLastInputMode = require(SduiSharedContentParent.FocusNavigationUtils).useLastInputMode
local Responsive = require(SduiSharedContentParent.Responsive)
local usePreferredInput = Responsive.usePreferredInput
local AppCommonLib = require(SduiSharedContentParent.AppCommonLib)
local ScrollMovementDirection = require(SduiSharedContentParent.RobloxAppEnums).ScrollMovementDirection
local _SduiCompat = require(SduiSharedContentParent.SduiCompat)
local SduiCoreSystem = require(SduiSharedContentParent.SduiCoreSystem)
local DiscoveryTypes = require(SduiSharedContentParent.DiscoveryTypes)

local CollectionViews = require(SduiSharedContentParent.CollectionViews)
local CollectionLayoutStoreProvider = CollectionViews.CollectionLayoutStoreProvider
local CollectionLayoutStoreContext = CollectionViews.CollectionLayoutStoreContext

local SduiPoolStore = SduiCoreSystem.SduiPoolStore

local SduiFeedContext = require(SduiSharedContent.Components.SduiFeedContext)
local SduiStickyHeader = require(SduiSharedContent.Components.SduiStickyHeader)
local PullToRefreshSpinner = require(SduiSharedContentParent.AppPageShell).PullToRefreshSpinner
local Signals = require(SduiSharedContentParent.Signals)
local SignalsReact = require(SduiSharedContentParent.SignalsReact)
local tutils = require(SduiSharedContentParent.tutils)
local useVerticalScrolledToEndThreshold = require(SduiSharedContent.Components.useVerticalScrolledToEndThreshold)
local useProgressiveRowCap = require(SduiSharedContent.Components.useProgressiveRowCap)
local useProgressiveItemCapOnScroll = require(SduiSharedContent.Components.useProgressiveItemCapOnScroll)
local buildSduiFeedChildren = require(SduiSharedContent.Components.buildSduiFeedChildren)
local SduiFeedImpressionsDetector = require(SduiSharedContent.Components.SduiFeedImpressionsDetector)
local BackToTopButton = require(SduiSharedContent.Components.BackToTopButton)
local ScrollDetector = require(SduiSharedContentParent.ScrollTelemetry).ScrollDetector

local createScrollIntervalPerformanceTracker = require(SduiSharedContentParent.IntervalPerformanceTracker).createScrollIntervalPerformanceTracker
local ViewportVideoAutoplaySync = require(SduiSharedContentParent.VideoUtils).ViewportVideoAutoplaySync

local SharedFlags = require(SduiSharedContentParent.SharedFlags)
local FFlagLuaAppSduiHomeFriendCarousel = SharedFlags.FFlagLuaAppSduiHomeFriendCarousel
local num1 = game:DefineFastInt("SduiVerticalFeedScrollInitialNumRows", 4)
local num2 = game:DefineFastInt("SduiVerticalFeedScrollLoadNumRows", 3)
local num3 = game:DefineFastInt("SduiVerticalFeedScrollPreloadDistancePx", 2000)

local num4 = game:DefineFastInt("SduiVerticalFeedScrollUnderfillDebounceMs", 50)
local bool1 = game:DefineFastFlag("SduiEnableBackToTop", false)
local FFlagSduiPageCanvasCollectionLayout = SharedFlags.FFlagSduiPageCanvasCollectionLayout
local FFlagLuaAppSduiVideoThumbnail = SharedFlags.FFlagLuaAppSduiVideoThumbnail
local FFlagLuaAppMediaGalleryGamepadSupport = SharedFlags.FFlagLuaAppMediaGalleryGamepadSupport
local FFlagLuaAppOneByTwoHoverIdleAutoplay = SharedFlags.FFlagLuaAppOneByTwoHoverIdleAutoplay
local FFlagLuaAppSduiSuppressVideoDetectorDuringScroll = SharedFlags.FFlagLuaAppSduiSuppressVideoDetectorDuringScroll
local FFlagAppPageShellScrollToTopFocus = SharedFlags.FFlagAppPageShellScrollToTopFocus
local FFlagSduiVerticalFeedScrollTelemetry = SharedFlags.FFlagSduiVerticalFeedScrollTelemetry
local FFlagSduiIndividualFeedItemSpacing = SharedFlags.FFlagSduiIndividualFeedItemSpacing
local FFlagSduiSamePoolFeedItemSpacing = SharedFlags.FFlagSduiSamePoolFeedItemSpacing

local signal = Signals.createSignal(nil)

local var1 = table.freeze({})

local function PoolStoreLayoutStoreWiring(tbl1)
    local var2 = React.useContext(CollectionLayoutStoreContext)
    React.useEffect(function()
        if var2 == nil then
            return
        end

        local sduiPoolStore = SduiPoolStore.getSduiPoolStore(tbl1.configKey)
        sduiPoolStore.setLayoutStore(var2)
        return function()
            sduiPoolStore.setLayoutStore(nil)
        end
    end, { tbl1.configKey, var2 })
    return nil
end

local function getFeedItemRowCount(arg1, arg2) -- Luacid: Inlined by compiler; 1 call site recovered
    local numberOfRowsGetter = arg1.numberOfRowsGetter
    if numberOfRowsGetter ~= nil then
        local var2 = numberOfRowsGetter(arg2)
        if var2 > 0 then
            return var2
        end
    end
    return 1
end

local function useProgressiveRowCapWithScroll(feedItems, initialNumToRender: number?, progressiveFillRate: number?, progressiveFillIntervalMs: number?, progressiveFillOnScroll: boolean?, tbl1, tbl2, num5: number)
    local feedItemsLen = feedItems and #feedItems or 0

    local var2, var3 = useProgressiveRowCap(feedItemsLen, initialNumToRender, progressiveFillRate, progressiveFillIntervalMs)

    local var4 = React.useMemo(function()
        return Signals.createComputed(function(arg1)
            signal(arg1)
            if not progressiveFillOnScroll then
                return var1
            end
            local var4 = table.create(feedItems and #feedItems or 0)
            if feedItems then
                for k, feedItem in feedItems do
                    var4[k] = getFeedItemRowCount(feedItem, arg1)
                end
            end
            return var4
        end, tutils.shallowEqual)
    end, { feedItems, progressiveFillOnScroll })

    local var5 = SignalsReact.useSignalState(var4)

    local var6 = useProgressiveItemCapOnScroll

    local num6 = num1
    local num7 = num2
    if not progressiveFillOnScroll then
        tbl1 = nil
    end

    if not progressiveFillOnScroll then
        tbl2 = nil
    end

    local var7, var8 = var6(var5, num6, num7, tbl1, tbl2, num3, num5)

    if progressiveFillOnScroll then
        return math.min(var2, var7), var3 or var8
    end
    return var2, var3
end

return React.memo(function(tbl1) -- name: SduiVerticalFeed
    local analyticsContext = tbl1.analyticsContext
    local sduiContext = tbl1.sduiContext
    local videoPlaybackContext = if FFlagLuaAppSduiVideoThumbnail or FFlagLuaAppOneByTwoHoverIdleAutoplay then sduiContext.videoPlaybackContext else nil
    local feedItems = tbl1.feedItems
    local debugName = tbl1.debugName
    local var2 = tbl1.contentTag or tbl1.defaultContentTag
    local bool2 = not (var2 == nil) and var2 ~= ""
    local var3 = useTokens()
    local bool3 = not (tbl1.stickyItems == nil) and #tbl1.stickyItems > 0
    local bool4 = tbl1.onRefresh ~= nil
    local contentTag = tbl1.stickyContentTag or tbl1.defaultStickyContentTag
    local backgroundStyle = tbl1.stickyBackgroundStyle or var3.Color.Surface.Surface_0

    local paddingTop = tbl1.stickyPaddingTop or var3.Gap.Medium
    local paddingBottom = tbl1.stickyPaddingBottom or var3.Gap.Medium
    local gapBetweenItems = tbl1.gapBetweenStickyItems or var3.Gap.Medium
    local var9 = tbl1.gapAfterStickyItems or var3.Gap.Medium
    local var10 = useNavBarPlacement()
    local impressionsTag = tbl1.impressionsTag or sduiContext.routeName or sduiContext.appPage
    local selectionBehaviorLeft = tbl1.selectionBehaviorLeft

    if not selectionBehaviorLeft then
        if var10 == AppNavBar.Placement.Left then
            selectionBehaviorLeft = Enum.SelectionBehavior.Escape
        else
            selectionBehaviorLeft = Enum.SelectionBehavior.Stop
        end
    end

    local selectionBehaviorRight = tbl1.selectionBehaviorRight or Enum.SelectionBehavior.Stop
    local var13 = usePreferredInput()
    local scrollBarThickness = tbl1.scrollBarThickness or (if var13 == Responsive.Input.Pointer then 4 else 0)

    local container, ref = React.useState(nil)

    local var17 = React.useRef(nil)
    local var18 = tbl1.scrollingFrameRef or var17

    local var4 = React.useRef(nil)

    local var20 = React.useRef(nil)
    if var20.current == nil then
        var20.current = AppCommonLib.Signal.new()
    end
    local var21 = React.useCallback(function()
        var20.current:fire()
    end, {})

    local var22 = nil
    local onRefresh

    if FFlagLuaAppSduiHomeFriendCarousel then
        var22 = React.useRef(nil)
        if var22.current == nil then
            local current = if tbl1.refreshSignal then tbl1.refreshSignal else AppCommonLib.Signal.new()
            var22.current = current
        end

        onRefresh = React.useCallback(function()
            if var22.current then
                var22.current:fire()
            end

            if tbl1.onRefresh then
                return tbl1.onRefresh()
            end

            return nil
        end, { tbl1.onRefresh, var22 })
    else
        onRefresh = nil
    end

    local var23 = React.useRef(0)
    local var24 = React.useRef(ScrollMovementDirection.Backward)
    local var25 = React.useCallback(function(arg1)
        var21()
        local onScrollDirectionChanged = tbl1.onScrollDirectionChanged
        if not onScrollDirectionChanged then
            return
        end

        local canvasPositionY = arg1.CanvasPosition.Y

        if canvasPositionY < 0 or canvasPositionY == var23.current then
            return
        end

        local current = if var23.current < canvasPositionY then ScrollMovementDirection.Forward else ScrollMovementDirection.Backward

        if current ~= var24.current then
            onScrollDirectionChanged(current)
            var24.current = current
        end
        var23.current = canvasPositionY
    end, { var21, tbl1.onScrollDirectionChanged })

    local value = React.useMemo(function()
        return {
            scrollViewPositionChangedSignal = var20.current,
            verticalScrollingFrameRef = var18
        }
    end, { var20, var17, var18 })

    local var27 = tbl1.gapBetweenFeedItems or var3.Gap.Large
    local var28 = if FFlagSduiSamePoolFeedItemSpacing then tbl1.samePoolFeedItemGap or var3.Gap.Large else nil

    local extraLocalProps = React.useMemo(function()
        return {
            scrollViewPositionChangedSignal = var20.current,
            verticalScrollingFrameRef = var18,
            refreshSignal = if FFlagLuaAppSduiHomeFriendCarousel then var22.current else nil
        }
    end, { var20, var18 })

    local var30 = nil
    local var31 = nil
    if bool1 then
        var30, var31 = React.useState(false)
        React.useEffect(function()
            if not tbl1.enableBackToTop then
                return
            end
            local current = var18.current
            if not current then
                return
            end

            local function updateIsScrollable() -- Luacid: Inlined by compiler; 1 call site recovered
                local absoluteWindowSizeY = current.AbsoluteWindowSize.Y
                local absoluteCanvasSizeY = current.AbsoluteCanvasSize.Y

                if not (absoluteWindowSizeY < 0 or absoluteCanvasSizeY < 0) then
                    var31(absoluteWindowSizeY < absoluteCanvasSizeY)
                end
            end
            local tbl2 = { current:GetPropertyChangedSignal("AbsoluteWindowSize"):Connect(updateIsScrollable), current:GetPropertyChangedSignal("AbsoluteCanvasSize"):Connect(updateIsScrollable) }
            updateIsScrollable()

            return function()
                for _, value in tbl2 do
                    value:Disconnect()
                end
            end
        end, { var18, tbl1.enableBackToTop })
    end
    if FFlagSduiVerticalFeedScrollTelemetry then
        React.useEffect(function()
            local scrollPerformanceIntervalName = tbl1.scrollPerformanceIntervalName
            local current = var18.current
            if scrollPerformanceIntervalName == nil or current == nil then
                return
            end

            local scrollIntervalPerformanceTracker = createScrollIntervalPerformanceTracker(scrollPerformanceIntervalName, current)
            local connection = current:GetPropertyChangedSignal("CanvasPosition"):Connect(scrollIntervalPerformanceTracker.onScrollTick)
            return function()
                connection:Disconnect()
                scrollIntervalPerformanceTracker.cleanup()
            end
        end, { var18, tbl1.scrollPerformanceIntervalName })
    end
    React.useEffect(function()
        if not (tbl1.scrollingFrameRef and tbl1.scrollingFrameRef.current) then
            return nil
        end

        local current = tbl1.scrollingFrameRef.current
        var23.current = current.CanvasPosition.Y

        local tbl2 = {
            current:GetPropertyChangedSignal("CanvasPosition"):Connect(function()
                var25(current)
            end),
            current:GetPropertyChangedSignal("AbsoluteCanvasSize"):Connect(var21)
        }

        return function()
            for _, value in tbl2 do
                value:Disconnect()
            end
        end
    end, { tbl1.scrollingFrameRef, var21, var25 })

    useAnimateScrollViewToSelection(
        if tbl1.scrollToSelectionAnimationManagedByParent then nil else var18,
        0.4,
        if FFlagLuaAppMediaGalleryGamepadSupport then tbl1.scrollToSelectionRevealOnly else nil
    )

    local bool5 = useLastInputMode() ~= "Cursor"

    local thresholdFromEnd = tbl1.thresholdFromEnd or 600

    local viewportVideoAutoplayController = nil
    local var32, var33

    if FFlagLuaAppSduiVideoThumbnail or FFlagLuaAppOneByTwoHoverIdleAutoplay then
        if videoPlaybackContext then
            viewportVideoAutoplayController = videoPlaybackContext.viewportVideoAutoplayController
        else
            viewportVideoAutoplayController = nil
        end
        var32 = React.useCallback(function()
            if not viewportVideoAutoplayController then
                return
            end

            viewportVideoAutoplayController:onScrollStart()

            if FFlagLuaAppSduiSuppressVideoDetectorDuringScroll and viewportVideoAutoplayController.suppressDetectorsDuringScroll then
                viewportVideoAutoplayController.setDetectorsUnmounted(true)
            end
        end, { viewportVideoAutoplayController })
        var33 = React.useCallback(function(num5: number)
            if not viewportVideoAutoplayController then
                return
            end
            if FFlagLuaAppSduiSuppressVideoDetectorDuringScroll and viewportVideoAutoplayController.suppressDetectorsDuringScroll then
                viewportVideoAutoplayController.setDetectorsUnmounted(false)
            end
            viewportVideoAutoplayController:onScrollSettled("Y", num5)
        end, { viewportVideoAutoplayController })
    else
        var32 = nil
        var33 = nil
    end

    local maxConfigs, var35 = useProgressiveRowCapWithScroll(
        feedItems,
        tbl1.initialNumToRender,
        tbl1.progressiveFillRate,
        tbl1.progressiveFillIntervalMs,
        tbl1.progressiveFillOnScroll,
        var18,
        var4,
        num4
    )

    local var36 = useVerticalScrolledToEndThreshold
    local onScrollToEnd = if var35 then nil else tbl1.onScrollToEnd
    var36(var18, thresholdFromEnd, onScrollToEnd)

    local useMemo = React.useMemo
    local function func1(): {BottomSpacer: number, FeedImpressionsDetector: number, NoStickyTopMargin: number, PoolStoreLayoutStoreWiring: number, StickyGap: number, UIListLayout: number}?
        if feedItems == nil then
            return nil
        end
        local pageBottomPadding = tbl1.pageBottomPadding or 80
        local tbl2 = {
            BottomSpacer = 0,
            UIListLayout = 0,
            StickyGap = 0,
            NoStickyTopMargin = 0,
            PoolStoreLayoutStoreWiring = 0,
            FeedImpressionsDetector = 0
        }
        local element

        if bool1 and tbl1.enableBackToTop and var30 then
            element = React.createElement("Frame", {
                Size = UDim2.new(1, 0, 0, 0),
                AutomaticSize = Enum.AutomaticSize.Y,
                BackgroundTransparency = 1,
                LayoutOrder = 1000000
            }, {
                Layout = React.createElement(
                    "UIListLayout",
                    {
                        FillDirection = Enum.FillDirection.Vertical,
                        SortOrder = Enum.SortOrder.LayoutOrder,
                        Padding = UDim.new(0, 0)
                    }
                ),
                Spacer = React.createElement(
                    "Frame",
                    {
                        Size = UDim2.new(1, 0, 0, pageBottomPadding),
                        BackgroundTransparency = 1,
                        LayoutOrder = 1
                    }
                ),
                BackToTop = React.createElement(BackToTopButton, { scrollingFrameRef = var18, pageContext = sduiContext.appPage, layoutOrder = 2 })
            })
        else
            element = React.createElement(
                "Frame",
                {
                    Size = UDim2.new(1, 0, 0, pageBottomPadding),
                    BackgroundTransparency = 1,
                    LayoutOrder = 1000000
                }
            )
        end

        tbl2.BottomSpacer = element

        tbl2.UIListLayout = React.createElement("UIListLayout", {
            FillDirection = Enum.FillDirection.Vertical,
            SortOrder = Enum.SortOrder.LayoutOrder,
            Padding = UDim.new(0, if FFlagSduiIndividualFeedItemSpacing then 0 else var27),
            ref = var4
        })
        local var37

        if bool3 and var9 and var9 > 0 then
            local createElement = React.createElement
            local str1 = "Frame"
            local tbl3 = { Size = 0, BackgroundTransparency = 1, LayoutOrder = 0 }
            local new = UDim2.new
            local num5 = 1
            local num6 = 0
            local num7 = 0
            local var38 = if FFlagSduiIndividualFeedItemSpacing then math.max(var9, var27) else math.max(0, var9 - var27)
            tbl3.Size = new(num5, num6, num7, var38)
            var37 = createElement(str1, tbl3)
        else
            var37 = nil
        end

        tbl2.StickyGap = var37
        local var38

        if bool3 or not (tbl1.feedTopMargin and tbl1.feedTopMargin > 0) then
            var38 = nil
        else
            local createElement = React.createElement
            local str1 = "Frame"
            local tbl3 = { Size = 0, BackgroundTransparency = 1, LayoutOrder = 0 }
            local new = UDim2.new
            local num5 = 1
            local num6 = 0
            local num7 = 0
            local var39 = if FFlagSduiIndividualFeedItemSpacing then math.max(tbl1.feedTopMargin, var27) else math.max(0, tbl1.feedTopMargin - var27)
            tbl3.Size = new(num5, num6, num7, var39)
            var38 = createElement(str1, tbl3)
        end

        tbl2.NoStickyTopMargin = var38

        tbl2.PoolStoreLayoutStoreWiring = if sduiContext.configKey == nil then nil else React.createElement(PoolStoreLayoutStoreWiring, { configKey = sduiContext.configKey })

        tbl2.FeedImpressionsDetector = if impressionsTag and feedItems then React.createElement(SduiFeedImpressionsDetector, {
            sduiContext = sduiContext,
            feedItems = feedItems,
            parentRef = var18,
            impressionsTag = impressionsTag,
            scrollViewPositionChangedSignal = var20.current
        }) else nil

        local var39 = buildSduiFeedChildren
        local tbl3 = {
            configs = feedItems,
            sduiContext = sduiContext,
            debugName = debugName,
            componentType = "VerticalFeed",
            impressionsTag = impressionsTag,
            selectionBehaviorLeft = selectionBehaviorLeft,
            selectionBehaviorRight = selectionBehaviorRight,
            extraLocalProps = extraLocalProps,
            selectionOrderBase = if FFlagAppPageShellScrollToTopFocus then DiscoveryTypes.Constants.SORT_SELECTION_ORDER_BASE else nil,
            defaultFocusRef = if FFlagAppPageShellScrollToTopFocus then tbl1.defaultFocusRef else nil,
            maxConfigs = maxConfigs,
            gapBetweenFeedItems = if FFlagSduiIndividualFeedItemSpacing then var27 else nil,
            gapAfterFirstFeedItem = if FFlagSduiIndividualFeedItemSpacing then tbl1.gapAfterFirstFeedItem else nil,
            samePoolFeedItemGap = if FFlagSduiSamePoolFeedItemSpacing then var28 else nil
        }

        for value, value2 in (var39(tbl3)) do
            tbl2[value] = value2
        end
        return tbl2
    end

    local gapAfterFirstFeedItem = if FFlagSduiIndividualFeedItemSpacing then tbl1.gapAfterFirstFeedItem else nil
    local var37 = if FFlagSduiSamePoolFeedItemSpacing then var28 else nil
    local tableValue1 = feedItems
    local tableValue2 = debugName
    local tableValue3 = var17
    local tableValue4 = var20
    local tableValue5 = sduiContext
    local tableValue6 = analyticsContext
    local tableValue7 = var27
    local tableValue8 = gapAfterFirstFeedItem
    local tableValue9 = var37
    local tableValue10 = impressionsTag
    local tableValue11 = selectionBehaviorLeft
    local tableValue12 = selectionBehaviorRight
    local tableValue13 = bool3
    local tableValue14 = var9
    local tableValue15 = tbl1.feedTopMargin
    local tableValue16 = extraLocalProps
    local pageBottomPadding = tbl1.pageBottomPadding
    local enableBackToTop = if bool1 then tbl1.enableBackToTop else nil
    local var38 = if bool1 then var30 else nil
    local defaultFocusRef = if FFlagAppPageShellScrollToTopFocus then tbl1.defaultFocusRef else nil
    local var39 = useMemo(func1, {
        tableValue1,
        tableValue2,
        tableValue3,
        tableValue4,
        tableValue5,
        tableValue6,
        tableValue7,
        tableValue8,
        tableValue9,
        tableValue10,
        tableValue11,
        tableValue12,
        tableValue13,
        tableValue14,
        tableValue15,
        tableValue16,
        bool2,
        pageBottomPadding,
        enableBackToTop,
        var38,
        var18,
        maxConfigs,
        defaultFocusRef
    })

    if value then
        var39 = React.createElement(SduiFeedContext.Provider, { value = value }, var39)
    end
    if not (FFlagSduiPageCanvasCollectionLayout and tbl1.disableCollectionLayoutStoreProvider) then
        var39 = React.createElement(CollectionLayoutStoreProvider, { container = container }, var39)
    end

    local tag = { ["size-full-0 auto-y"] = true }
    if bool2 then
        tag[var2] = true
    end

    local element = React.createElement(View, { tag = tag, LayoutOrder = tbl1.layoutOrder, ref = ref }, var39)

    if FFlagLuaAppSduiVideoThumbnail or FFlagLuaAppOneByTwoHoverIdleAutoplay then
        element = React.createElement(React.Fragment, nil, {
            Content = element,
            ViewportVideoAutoplaySync = if viewportVideoAutoplayController then React.createElement(
                ViewportVideoAutoplaySync,
                {
                    viewportAutoplayController = viewportVideoAutoplayController,
                    scrollingFrameRef = var18
                }
            ) else nil,
            ScrollDetector = if viewportVideoAutoplayController then React.createElement(ScrollDetector, { scrollingFrameRef = var18, onScrollStart = var32, onScrollSettled = var33 }) else nil
        })
    end

    if tbl1.scrollingFrameRef ~= nil then
        return element
    end

    local scroll = React.createElement(
        "ScrollingFrame",
        {
            LayoutOrder = 3,
            ref = var17,
            [React.Change.CanvasPosition] = var25,
            [React.Change.CanvasSize] = var21,
            BackgroundColor3 = if tbl1.backgroundStyle then tbl1.backgroundStyle.Color3 else var3.Color.Surface.Surface_0.Color3,
            BackgroundTransparency = if tbl1.backgroundStyle then tbl1.backgroundStyle.Transparency else nil,
            Size = UDim2.fromScale(1, 0),
            CanvasSize = UDim2.new(1, 0, 0, 0),
            AutomaticCanvasSize = Enum.AutomaticSize.Y,
            BorderSizePixel = 0,
            ScrollBarThickness = scrollBarThickness,
            ElasticBehavior = Enum.ElasticBehavior.Always,
            ScrollingDirection = Enum.ScrollingDirection.Y,
            Selectable = false,
            ScrollingEnabled = not bool5,
            ClipsDescendants = false
        },
        {
            FlexFill = React.createElement("UIFlexItem", { FlexMode = Enum.UIFlexMode.Fill }),
            Content = element
        }
    )
    local createElement = React.createElement
    local var40 = View
    local tbl3 = {
        tag = "size-full",
        LayoutOrder = tbl1.layoutOrder,
        layout = {
            FillDirection = Enum.FillDirection.Vertical,
            SortOrder = Enum.SortOrder.LayoutOrder
        }
    }
    local tbl4 = {
        Sticky = if bool3 then React.createElement(SduiStickyHeader, {
            stickyItems = tbl1.stickyItems,
            sduiContext = sduiContext,
            debugName = `{debugName}.StickyHeader`,
            contentTag = contentTag,
            backgroundStyle = backgroundStyle,
            paddingTop = paddingTop,
            paddingBottom = paddingBottom,
            gapBetweenItems = gapBetweenItems,
            zIndex = 2,
            extraLocalProps = extraLocalProps,
            impressionsTag = impressionsTag,
            selectionBehaviorLeft = selectionBehaviorLeft,
            selectionBehaviorRight = selectionBehaviorRight
        }) else nil,
        RefreshSpinner = 0,
        Scroll = 0
    }
    local var41

    if bool4 then
        local createElement2 = React.createElement
        local var42 = PullToRefreshSpinner
        local tbl5 = { LayoutOrder = 2, onRefresh = 0, scrollingFrameRef = 0, appEventName = 0 }

        if not FFlagLuaAppSduiHomeFriendCarousel then
            onRefresh = tbl1.onRefresh
        end

        tbl5.onRefresh = onRefresh
        tbl5.scrollingFrameRef = var17
        tbl5.appEventName = sduiContext.appPage
        var41 = createElement2(var42, tbl5)
    else
        var41 = nil
    end

    tbl4.RefreshSpinner = var41

    tbl4.Scroll = scroll
    return createElement(var40, tbl3, tbl4)
end)
