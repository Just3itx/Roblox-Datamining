-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T08:01:27Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CollectionViews = script:FindFirstAncestor("CollectionViews")
local CollectionViewsParent = CollectionViews.Parent

local React = require(CollectionViewsParent.React)
local Cryo = require(CollectionViewsParent.Cryo)
local ArgCheck = require(CollectionViewsParent.ArgCheck)
local useDesignTokens = require(CollectionViewsParent.Style).useDesignTokens
local useTokens = require(CollectionViewsParent.Foundation).Hooks.useTokens
local FFlagSduiComponentsUseFoundationTokens = require(CollectionViewsParent.SharedFlags).FFlagSduiComponentsUseFoundationTokens
local Responsive = require(CollectionViewsParent.Responsive)
local useLastInput = Responsive.useLastInput
local usePreferredInput = Responsive.usePreferredInput
local useIsSpatial = Responsive.useIsSpatial
local t = require(CollectionViewsParent.t)
local validateProps = require(CollectionViewsParent.DiscoveryUtils).validateProps

local useCollectionSizeBindings = require(CollectionViews.useCollectionSizeBindings)
local useScrollButtonHandlers = require(CollectionViews.Carousel.useScrollButtonHandlers)
local useCarouselScrollingBinding = require(CollectionViews.Carousel.useCarouselScrollingBinding)
local CollectionBackgroundMural = require(CollectionViews.Carousel.CollectionBackgroundMural)
local CollectionHeader = require(CollectionViews.CollectionHeader)
local ScrollingRowOfCollectionItems = require(CollectionViews.Carousel.ScrollingRowOfCollectionItems)
local maybeForceDarkTheme = require(CollectionViews.maybeForceDarkTheme)
local CarouselScrollButtons = require(CollectionViews.Carousel.CarouselScrollButtons)

local _CollectionViewTypes = require(CollectionViews.CollectionViewTypes)
local useCollectionLayout = require(CollectionViews.CollectionLayoutStore.useCollectionLayout)

local CompositionTags = require(CollectionViewsParent.AppComposition).CompositionTags

local var1 = t.strictInterface({
    testId = t.optional(t.string),
    Position = t.optional(t.UDim2),
    LayoutOrder = t.optional(t.number),
    containerRef = t.optional(t.union(t.table, t.callback)),
    scrollingFrameRef = t.optional(t.table),
    onScrollingFrameRefCallback = t.optional(t.callback),
    numColumns = t.optional(t.number),
    fractionalItemAmount = t.optional(t.number),
    items = t.table,
    renderItem = t.callback,
    getItemHeight = t.callback,
    columnGap = t.optional(t.number),
    sideMargin = t.optional(t.number),
    backgroundMuralUrl = t.optional(t.string),
    title = t.optional(t.union(t.string, t.callback)),
    subtitle = t.optional(t.string),
    tooltipInfoText = t.optional(t.string),
    onActivateInfoIcon = t.optional(t.callback),
    tooltipSupportsVR = t.optional(t.boolean),
    tooltipSupportsTenFootUi = t.optional(t.boolean),
    onActivateHeader = t.optional(t.callback),
    onActivateSubtitle = t.optional(t.callback),
    headerButtonText = t.optional(t.string),
    onViewableItemsChanged = t.optional(t.callback),
    onContainerSizeChanged = t.optional(t.callback),
    onChangeCanvasPosition = t.optional(t.callback),
    onReachedThresholdFromEnd = t.optional(t.union(t.callback, t.table)),
    thresholdFromEnd = t.optional(t.number),
    scrollingEnabledOverride = t.optional(t.boolean),
    shouldShowScrollButtonsOverride = t.optional(t.boolean),
    hideHeaderButton = t.optional(t.boolean),
    maxItemsToShow = t.optional(t.number),
    numItemsToRenderOffScreen = t.optional(t.number),
    onScrollButtonEnter = t.optional(t.callback),
    onScrollButtonLeave = t.optional(t.callback),
    AutomaticSize = t.optional(t.enum(Enum.AutomaticSize)),
    headerComponent = t.optional(t.table),
    collectionItemSize = t.optional(t.string),
    enableHoverOverflow = t.optional(t.boolean),
    hideSubtitleChevron = t.optional(t.boolean)
})

local tbl1 = { numColumns = 0, fractionalItemAmount = 0, columnGap = 0, sideMargin = 0 }

local function isScrollingEnabled(scrollingEnabledOverride: boolean?, _: boolean?): boolean? -- Luacid: Inlined by compiler; 1 call site recovered
    return scrollingEnabledOverride == nil or scrollingEnabledOverride
end

local function areScrollButtonsEnabled(pointer: string, _: string, bool1: boolean, shouldShowScrollButtonsOverride: boolean?, bool2: boolean): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    return if bool1 then if shouldShowScrollButtonsOverride == nil then pointer == Responsive.Input.Pointer or bool2 else shouldShowScrollButtonsOverride else false
end

return (React.memo(function(tbl2) -- name: CollectionCarousel
    validateProps(var1, tbl2)
    local var2 = Cryo.Dictionary.join(tbl1, tbl2)

    local sideMargin = var2.sideMargin
    local var3 = useCollectionLayout(tbl2.collectionItemSize)
    local numColumns = tbl2.numColumns or var3.itemsPerRow
    local columnGap = tbl2.columnGap or var3.gutter
    local carouselPeek = if tbl2.collectionItemSize then var3.carouselPeek or 0 else nil
    ArgCheck.assert(numColumns >= 1)
    ArgCheck.assert(sideMargin >= 0)
    ArgCheck.assert(var2.fractionalItemAmount >= 0)
    ArgCheck.assert(columnGap >= 0)

    local var6 = React.useRef(nil)

    local onScrollingFrameRefCallback = React.useCallback(function(current)
        var6.current = current

        if var2.onScrollingFrameRefCallback then
            var2.onScrollingFrameRefCallback(current)
        end
        if var2.scrollingFrameRef then
            var2.scrollingFrameRef.current = current
        end
    end, { var2.onScrollingFrameRefCallback, var2.scrollingFrameRef })

    local var8 = useLastInput()
    local var9 = usePreferredInput()
    local var10 = useIsSpatial()

    local var11 = var2.hideHeaderButton or var9 == Responsive.Input.Directional

    local scrollingEnabled = isScrollingEnabled(var2.scrollingEnabledOverride, nil)

    local num1 = math.min(var2.maxItemsToShow or #var2.items, #var2.items)
    if not scrollingEnabled then
        num1 = math.min(numColumns, num1)
    end
    ArgCheck.assert(num1 >= 0)

    local var13 = if scrollingEnabled then if numColumns < num1 then var2.fractionalItemAmount else 0 else 0

    local itemSizeBinding, containerSizeBinding, var16, ref = useCollectionSizeBindings(
        numColumns,
        columnGap,
        sideMargin,
        var13,
        var2.getItemHeight,
        var2.onContainerSizeChanged,
        carouselPeek
    )

    local bool1 = areScrollButtonsEnabled(var8, nil, scrollingEnabled, var2.shouldShowScrollButtonsOverride, var10)

    local handleScrollLeft, handleScrollRight, leftScrollingEnabled, rightScrollingEnabled = useScrollButtonHandlers(var6, num1, bool1, numColumns, itemSizeBinding, columnGap, nil)

    local var22 = useCarouselScrollingBinding(var6, var2.enableHoverOverflow == true)
    local var23 = columnGap * 0.5
    local var24 = React.useMemo(function()
        if not var2.enableHoverOverflow then
            return nil
        end
        return React.joinBindings({ itemSizeBinding, var22 }):map(function(arg1): UDim2
            local var24 = arg1[1]
            local var25 = arg1[2]
            return UDim2.new(1, if var25 then 0 else -var23 * 2, 0, var24.Y)
        end)
    end, {
        itemSizeBinding,
        var22,
        var23,
        var2.enableHoverOverflow
    })

    local var25 = React.useMemo(function()
        if not var2.enableHoverOverflow then
            return nil
        end
        return var22:map(function(arg1): UDim2
            return UDim2.new(0, if arg1 then 0 else var23, 0, 500)
        end)
    end, { var22, var23, var2.enableHoverOverflow })

    local var26 = if FFlagSduiComponentsUseFoundationTokens then useTokens() else useDesignTokens()
    local size400 = var26.Size.Size_400
    local size500 = var26.Size.Size_500

    local white100 = var26.Color.Extended.White.White_100
    local bool2 = var2.backgroundMuralUrl ~= nil
    local var27 = var2.title and var2.title ~= ""
    local element = React.createElement(ScrollingRowOfCollectionItems, {
        Position = var25,
        Size = var24,
        ScrollingEnabled = scrollingEnabled,
        onChangeCanvasPosition = var2.onChangeCanvasPosition,
        onScrollingFrameRefCallback = onScrollingFrameRefCallback,
        itemSizeBinding = itemSizeBinding,
        items = var2.items,
        totalItemsOnCanvas = num1,
        numColumns = numColumns,
        columnGap = columnGap,
        renderItem = var2.renderItem,
        sideMargin = sideMargin,
        numItemsToRenderOffScreen = var2.numItemsToRenderOffScreen,
        onReachedThresholdFromEnd = var2.onReachedThresholdFromEnd,
        thresholdFromEnd = var2.thresholdFromEnd,
        onViewableItemsChanged = var2.onViewableItemsChanged,
        AutomaticSize = var2.AutomaticSize
    })

    local createElement = React.createElement
    local str1 = "Frame"
    local tbl3 = {
        ref = var2.containerRef,
        Size = UDim2.new(1, 0, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        Position = var2.Position,
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        LayoutOrder = var2.LayoutOrder,
        [React.Tag] = if var2.testId then `data-testid={var2.testId}` else nil
    }
    local tbl4 = {
        BackgroundMural = if var2.backgroundMuralUrl then React.createElement(
            CollectionBackgroundMural,
            {
                backgroundMuralUrl = var2.backgroundMuralUrl,
                containerSizeBinding = containerSizeBinding,
                ZIndex = -1
            }
        )
            or nil else nil,
        CollectionContent = 0
    }

    local createElement2 = React.createElement
    local str2 = "Frame"
    local tbl5 = {
        AutomaticSize = Enum.AutomaticSize.Y,
        Size = UDim2.new(1, 0, 0, 0),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        [React.Change.AbsoluteSize] = var16,
        ref = ref
    }
    local tbl6 = {
        UIPadding = React.createElement("UIPadding", {
            PaddingTop = if var2.backgroundMuralUrl == nil then nil else UDim.new(0, size500),
            PaddingLeft = if sideMargin > 0 then UDim.new(0, sideMargin) else nil,
            PaddingRight = if sideMargin > 0 then UDim.new(0, sideMargin) else nil
        }),
        UIListLayout = 0,
        CollectionHeader = 0,
        Items = 0
    }
    local createElement3 = React.createElement
    local str3 = "UIListLayout"
    local tbl7 = {
        FillDirection = Enum.FillDirection.Vertical,
        HorizontalAlignment = Enum.HorizontalAlignment.Center,
        SortOrder = Enum.SortOrder.LayoutOrder,
        Padding = 0
    }
    local new = UDim.new
    local num2 = 0

    if not var27 then
        size400 = if var2.headerComponent then size400 else 0
    end

    tbl7.Padding = new(num2, size400)
    tbl6.UIListLayout = createElement3(str3, tbl7)
    local headerComponent

    if var2.headerComponent then
        headerComponent = var2.headerComponent
    else
        local var28 = maybeForceDarkTheme
        local createElement4 = React.createElement
        local var29 = CollectionHeader
        local tbl8 = {
            LayoutOrder = 1,
            title = var2.title,
            subtitle = var2.subtitle,
            tooltipInfoText = var2.tooltipInfoText,
            onActivateInfoIcon = var2.onActivateInfoIcon,
            tooltipSupportsVR = var2.tooltipSupportsVR,
            tooltipSupportsTenFootUi = var2.tooltipSupportsTenFootUi,
            hideButton = #var2.items < 1 or var11 or not var27,
            onActivate = var2.onActivateHeader,
            onActivateSubtitle = var2.onActivateSubtitle,
            buttonText = var2.headerButtonText,
            titleColor = if bool2 then white100 else nil,
            subtitleColor = 0,
            hideSubtitleChevron = 0
        }

        if not bool2 then
            white100 = nil
        end

        tbl8.subtitleColor = white100
        tbl8.hideSubtitleChevron = var2.hideSubtitleChevron
        headerComponent = var28(createElement4(var29, tbl8), bool2)
    end

    tbl6.CollectionHeader = headerComponent

    local createElement4 = React.createElement
    local str4 = "Frame"

    local tbl8 = {
        Size = if var2.enableHoverOverflow then itemSizeBinding:map(function(vector2: Vector2): UDim2
            return UDim2.new(1, 0, 0, vector2.Y)
        end) else UDim2.new(1, 0, 0, 0),
        AutomaticSize = if var2.enableHoverOverflow then nil else Enum.AutomaticSize.Y,
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        LayoutOrder = 2,
        [React.Tag] = if var2.collectionItemSize and not var2.enableHoverOverflow then CompositionTags.Utility.ClipAtMaxWidth else nil
    }

    local tbl9 = { CarouselClip = 0, ScrollingItems = 0, ScrollButtons = 0 }
    local var28

    if var2.enableHoverOverflow then
        local createElement5 = React.createElement
        local str5 = "Frame"

        local tbl10 = {
            Size = var22:map(function(arg1): UDim2
                return UDim2.new(1, if arg1 then 0 else var23 * 2, 1, 1000)
            end),
            Position = var22:map(function(arg1): UDim2
                return UDim2.new(0, if arg1 then 0 else -var23, 0, -500)
            end),
            BackgroundTransparency = 1,
            [React.Tag] = if var2.collectionItemSize then CompositionTags.Utility.ClipAtMaxWidth else nil
        }

        var28 = createElement5(str5, tbl10, { ScrollingItems = element })
    else
        var28 = nil
    end

    tbl9.CarouselClip = var28

    if var2.enableHoverOverflow then
        element = nil
    end

    tbl9.ScrollingItems = element
    local element2

    if bool1 then
        element2 = React.createElement(CarouselScrollButtons, {
            handleScrollLeft = handleScrollLeft,
            handleScrollRight = handleScrollRight,
            leftScrollingEnabled = leftScrollingEnabled,
            rightScrollingEnabled = rightScrollingEnabled,
            ZIndex = 10,
            Size = UDim2.new(1, 2 * sideMargin, 1, 0),
            Position = UDim2.new(0.5, 0, 0, 0),
            AnchorPoint = Vector2.new(0.5, 0),
            buttonOffsetFromEdge = var26.Size.Size_200,
            onScrollButtonEnter = var2.onScrollButtonEnter,
            onScrollButtonLeave = var2.onScrollButtonLeave
        })
    else
        element2 = nil
    end

    tbl9.ScrollButtons = element2
    tbl6.Items = createElement4(str4, tbl8, tbl9)
    tbl4.CollectionContent = createElement2(str2, tbl5, tbl6)
    return createElement(str1, tbl3, tbl4)
end))
