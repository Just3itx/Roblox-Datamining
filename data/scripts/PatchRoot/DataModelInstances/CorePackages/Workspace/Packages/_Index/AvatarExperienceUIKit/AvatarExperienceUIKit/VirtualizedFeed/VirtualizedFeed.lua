-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T05:11:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UserGameSettings = UserSettings():GetService("UserGameSettings")
local AvatarExperienceUIKitParent = script:FindFirstAncestor("AvatarExperienceUIKit").Parent

local React = require(AvatarExperienceUIKitParent.React)
local useLocalization = require(AvatarExperienceUIKitParent.Localization).Hooks.useLocalization
local FFlagAXVirtualizedFeedVerticalPadding = require(AvatarExperienceUIKitParent.SharedFlags).FFlagAXVirtualizedFeedVerticalPadding

local FFlagAXSduiFeedBackToTopAndNavClearance = require(AvatarExperienceUIKitParent.AvatarExperienceFlags).FFlagAXSduiFeedBackToTopAndNavClearance

local FFlagAXSduiFeedSkipScrollWithoutContent = require(AvatarExperienceUIKitParent.AvatarExperienceFlags).FFlagAXSduiFeedSkipScrollWithoutContent
local FFlagAXFixVirtualizedFeedUpdateDepth = require(script.Parent.FFlagAXFixVirtualizedFeedUpdateDepth)
local Foundation = require(AvatarExperienceUIKitParent.Foundation)
local Button = Foundation.Button
local ButtonVariant = Foundation.Enums.ButtonVariant
local View = Foundation.View
local Loading = Foundation.Loading
local IconSize = Foundation.Enums.IconSize
local VirtualizedList = require(AvatarExperienceUIKitParent.VirtualizedList)
local FlatList = VirtualizedList.FlatList
local ScrollView = VirtualizedList.ScrollView
local isFeedContentScrollable = require(script.Parent.isFeedContentScrollable)
local FFlagVirtualizedFeedFooterWrapperProp = require(AvatarExperienceUIKitParent.SharedFlags).FFlagVirtualizedFeedFooterWrapperProp
local FFlagAXScrollTelemetryIntegration2 = require(AvatarExperienceUIKitParent.SharedFlags).FFlagAXScrollTelemetryIntegration2
local useFlatListScrollPerformanceTracker = require(script.Parent.useFlatListScrollPerformanceTracker)

local contentContainerStyle = { BackgroundTransparency = 1, BorderSizePixel = 0 }

local style = {
    Selectable = false,
    BackgroundTransparency = 1,
    ScrollBarThickness = 0,
    BorderSizePixel = 0,
    ElasticBehavior = Enum.ElasticBehavior.Always,
    ClipsDescendants = false,
    AutomaticCanvasSize = Enum.AutomaticSize.Y
}

local tbl3 = { backToTop = "Feature.GamePage.Action.BackToTop" }

local function getNativeScrollingFrameRef(tbl4) -- Luacid: Inlined by compiler; 1 call site recovered
    if tbl4.current ~= nil then
        local nativeScrollRef = tbl4.current:getNativeScrollRef()
        if nativeScrollRef ~= nil then
            return nativeScrollRef._nativeRef
        end
    end
    return nil
end

local function renderScrollViewSkippingScrollsWithoutContent(tbl4)
    local onScroll = tbl4.onScroll
    local var1 = table.clone(tbl4)
    function var1.onScroll(arg1)
        if onScroll ~= nil and arg1:GetChildren()[1] ~= nil then
            onScroll(arg1)
        end
    end
    return React.createElement(ScrollView, var1)
end

local function VirtualizedFeedBackToTopButton(tbl4)
    local var1 = useLocalization(tbl3)

    return React.createElement(
        Button,
        {
            text = tbl4.text or var1.backToTop,
            variant = ButtonVariant.Link,
            onActivated = tbl4.onActivated
        }
    )
end

local tag = if FFlagAXSduiFeedBackToTopAndNavClearance then "row align-x-center align-y-center size-full-0 auto-y padding-xlarge" else "row align-y-center align-x-center padding-xlarge"

local function VirtualizedFeedFooterLayout(tbl4)
    return React.createElement(View, { tag = tag }, tbl4.children)
end

local function createFooterComponent(tbl4) -- Luacid: Inlined by compiler; 3 call sites recovered
    if tbl4.shouldWrap then
        return (React.createElement(VirtualizedFeedFooterLayout, {}, tbl4.footerContent))
    end

    return tbl4.footerContent
end

return React.forwardRef(function(tbl4, ref) -- name: VirtualizedFeed
    local horizontalPadding = tbl4.horizontalPadding or 0
    local verticalPadding = FFlagAXVirtualizedFeedVerticalPadding and tbl4.verticalPadding or 0
    local shouldWrap = not FFlagVirtualizedFeedFooterWrapperProp or tbl4.shouldWrapFooter ~= false
    local var1 = React.useRef(nil)

    local var2 = React.useCallback(function(current)
        var1.current = current
        local flatListRef = tbl4.flatListRef
        if not flatListRef then
            return
        end

        if typeof(flatListRef) == "function" then
            flatListRef(current)
            return
        end

        if typeof(flatListRef) == "table" then
            flatListRef.current = current
        end
    end, { tbl4.flatListRef })

    if FFlagAXScrollTelemetryIntegration2 then
        useFlatListScrollPerformanceTracker(tbl4.scrollPerformanceIntervalName, var1)
    end

    local var3, var4 = React.useState(false)

    local var5 = nil
    local var6 = nil
    local var7 = nil
    local var8 = nil
    local var9 = nil
    local var10 = nil
    if FFlagAXSduiFeedBackToTopAndNavClearance and not FFlagAXFixVirtualizedFeedUpdateDepth then
        local var11
        var5, var11 = React.useState(0)
        var6 = var11
        local var12
        var7, var12 = React.useState(0)
        var8 = var12
        var9 = React.useCallback(function(_: number, num1: number)
            var6(num1)
        end, {})
    end

    if FFlagAXSduiFeedBackToTopAndNavClearance and FFlagAXFixVirtualizedFeedUpdateDepth then
        local var11 = React.useRef(0)
        local var12 = React.useRef(0)
        local var13 = React.useCallback(function()
            var4(isFeedContentScrollable(var11.current, var12.current, verticalPadding))
        end, { verticalPadding })
        var9 = React.useCallback(function(_: number, current: number)
            var11.current = current
            var13()
        end, { var13 })
        var10 = React.useCallback(function(current: number)
            var12.current = current
            var13()
        end, { var13 })
    end

    local onActivated = React.useCallback(function()
        if var1.current then
            var1.current:scrollToOffset({ offset = 0, animated = not UserGameSettings.ReducedMotion })
        end
    end, {})

    if not FFlagAXSduiFeedBackToTopAndNavClearance then
        local nativeScrollingFrameRef = getNativeScrollingFrameRef(var1)

        React.useEffect(function()
            local tbl5 = {}

            local function sizeChangeHandler() -- Luacid: Inlined by compiler; 1 call site recovered
                if nativeScrollingFrameRef == nil or nativeScrollingFrameRef.current == nil then
                    return
                end
                local current = nativeScrollingFrameRef.current
                var4(current.AbsoluteCanvasSize.Y > current.AbsoluteWindowSize.Y)
            end
            if nativeScrollingFrameRef and nativeScrollingFrameRef.current then
                local absoluteCanvasSizeChanged = nativeScrollingFrameRef.current:GetPropertyChangedSignal("AbsoluteCanvasSize")
                table.insert(tbl5, absoluteCanvasSizeChanged:Connect(sizeChangeHandler))

                local absoluteWindowSizeChanged = nativeScrollingFrameRef.current:GetPropertyChangedSignal("AbsoluteWindowSize")
                table.insert(tbl5, absoluteWindowSizeChanged:Connect(sizeChangeHandler))
                sizeChangeHandler()
            end

            return function()
                for _, value in tbl5 do
                    value:Disconnect()
                end
            end
        end, { nativeScrollingFrameRef })
    end

    local var12 = nil
    if FFlagAXSduiFeedBackToTopAndNavClearance then
        if not FFlagAXFixVirtualizedFeedUpdateDepth then
            var3 = isFeedContentScrollable(var5 or 0, var7 or 0, verticalPadding)
        end

        local var13 = var3 and tbl4.isEndOfList == true
        local footerContent = if tbl4.ListFooterComponent then tbl4.ListFooterComponent elseif var13 then React.createElement(VirtualizedFeedBackToTopButton, { text = tbl4.scrollToTopLabel, onActivated = onActivated }) elseif tbl4.isLoading then React.createElement(Loading, { size = IconSize.Medium }) else nil
        local endOfListBottomPadding = tbl4.endOfListBottomPadding or 0
        local padding = React.useMemo(function(): {bottom: UDim}?
            return if endOfListBottomPadding <= 0 then nil else {
                bottom = UDim.new(0, endOfListBottomPadding)
            }
        end, { endOfListBottomPadding })

        if padding then
            local createElement = React.createElement
            local var16 = View
            local tbl5 = { tag = "size-full-0 auto-y", padding = padding }
            local tbl6 = { FooterContent = 0 }
            local var17

            if footerContent then
                if FFlagVirtualizedFeedFooterWrapperProp then
                    local tbl7 = { footerContent = footerContent, shouldWrap = shouldWrap }
                    var17 = createFooterComponent(tbl7)
                else
                    var17 = React.createElement(VirtualizedFeedFooterLayout, {}, footerContent)
                end
            else
                var17 = nil
            end

            tbl6.FooterContent = var17
            var12 = createElement(var16, tbl5, tbl6)
        elseif footerContent then
            if FFlagVirtualizedFeedFooterWrapperProp then
                local tbl5 = { footerContent = footerContent, shouldWrap = shouldWrap }
                var12 = createFooterComponent(tbl5)
            else
                var12 = React.createElement(VirtualizedFeedFooterLayout, {}, footerContent)
            end
        end
    else
        local footerContent = if tbl4.ListFooterComponent then tbl4.ListFooterComponent elseif tbl4.isEndOfList and var3 then React.createElement(VirtualizedFeedBackToTopButton, { text = tbl4.scrollToTopLabel, onActivated = onActivated }) elseif tbl4.isLoading then React.createElement(Loading, { size = IconSize.Medium }) else nil

        if footerContent then
            if FFlagVirtualizedFeedFooterWrapperProp then
                local tbl5 = { footerContent = footerContent, shouldWrap = shouldWrap }
                var12 = createFooterComponent(tbl5)
            else
                var12 = React.createElement(VirtualizedFeedFooterLayout, {}, footerContent)
            end
        else
            var12 = nil
        end
    end

    local onScroll = React.useCallback(function(arg1)
        if tbl4.onScroll then
            tbl4.onScroll(arg1.CanvasPosition.Y)
        end
    end, { tbl4.onScroll })

    local var14 = React.useCallback(function(arg1)
        if tbl4.onContainerWidthChanged then
            tbl4.onContainerWidthChanged(arg1.AbsoluteSize.X)
        end
        if FFlagAXSduiFeedBackToTopAndNavClearance and var8 then
            var8(arg1.AbsoluteSize.Y)
        end
        if FFlagAXFixVirtualizedFeedUpdateDepth and var10 then
            var10(arg1.AbsoluteSize.Y)
        end
    end, { tbl4.onContainerWidthChanged, var10 })

    local createElement = React.createElement
    local str2 = "Frame"
    local tbl5 = {
        BackgroundColor3 = tbl4.backgroundColor,
        BackgroundTransparency = if tbl4.backgroundTransparency ~= nil then tbl4.backgroundTransparency elseif tbl4.backgroundColor then 0 else 1,
        BorderSizePixel = 0,
        Size = tbl4.Size or UDim2.new(1, 0, 1, 0),
        ClipsDescendants = tbl4.clipsDescendants == nil or tbl4.clipsDescendants,
        LayoutOrder = tbl4.LayoutOrder,
        [React.Change.AbsoluteSize] = var14,
        ref = ref
    }
    local tbl6 = {
        UIPadding = if horizontalPadding > 0 or verticalPadding > 0 then React.createElement("UIPadding", {
            PaddingLeft = UDim.new(0, horizontalPadding),
            PaddingRight = UDim.new(0, horizontalPadding),
            PaddingTop = UDim.new(0, verticalPadding),
            PaddingBottom = UDim.new(0, verticalPadding)
        }) else nil,
        FeedFlatList = 0
    }

    local createElement2 = React.createElement
    local var15 = FlatList
    local tbl7 = {
        data = tbl4.data,
        renderItem = tbl4.renderItem,
        windowSize = tbl4.windowSize or 21,
        initialNumToRender = tbl4.initialNumToRender or 8,
        maxToRenderPerBatch = tbl4.maxToRenderPerBatch or 1,
        updateCellsBatchingPeriod = tbl4.updateCellsBatchingPeriod or 30,
        scrollEventThrottle = tbl4.scrollEventThrottle or 0,
        UNSTABLE_forceSiblingLayoutUpdate = true,
        ref = var2,
        contentContainerStyle = contentContainerStyle,
        style = style,
        onScroll = onScroll,
        onContentSizeChange = 0,
        onEndReachedThreshold = 0,
        onEndReached = 0,
        showDefaultLoadingIndicators = true,
        ListHeaderComponent = 0,
        ListFooterComponent = 0,
        scrollEnabled = 0,
        renderScrollComponent = 0
    }

    if not FFlagAXSduiFeedBackToTopAndNavClearance then
        var9 = nil
    end

    tbl7.onContentSizeChange = var9
    tbl7.onEndReachedThreshold = tbl4.onEndReachedThreshold
    tbl7.onEndReached = tbl4.onEndReached

    tbl7.ListHeaderComponent = tbl4.ListHeaderComponent
    tbl7.ListFooterComponent = var12
    tbl7.scrollEnabled = tbl4.scrollEnabled
    tbl7.renderScrollComponent = if FFlagAXSduiFeedSkipScrollWithoutContent and tbl4.skipScrollWithoutContent then renderScrollViewSkippingScrollsWithoutContent else nil
    tbl6.FeedFlatList = createElement2(var15, tbl7)
    return createElement(str2, tbl5, tbl6)
end)
