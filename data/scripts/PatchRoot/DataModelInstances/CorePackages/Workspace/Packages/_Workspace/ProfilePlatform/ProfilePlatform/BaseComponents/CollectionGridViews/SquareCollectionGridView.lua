-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T04:40:49Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfilePlatform = script:FindFirstAncestor("ProfilePlatform")
local ProfilePlatformParent = ProfilePlatform.Parent
local React = require(ProfilePlatformParent.React)

local CollectionViews = require(ProfilePlatformParent.CollectionViews)
local CollectionGrid = CollectionViews.CollectionGrid
local CollectionItemSize = CollectionViews.CollectionViewTypes.CollectionItemSize
local useCollectionLayoutParams = CollectionViews.useCollectionLayoutParams
local useCollectionImpressionsSignal = CollectionViews.useCollectionImpressionsSignal

local ScreenSizeImpressionsTracker = require(ProfilePlatformParent.Impressions).ScreenSizeImpressionsTracker

local useProfileAnalyticsContext = require(ProfilePlatform.Contexts.useProfileAnalyticsContext)
local useDynamicSizeMargin = require(ProfilePlatform.Hooks.useDynamicSizeMargin)

local AppPage = require(ProfilePlatformParent.RobloxAppEnums).AppPage

local ProfileCollectionGridConfig = require(script.Parent.ProfileCollectionGridConfig)

local FFlagProfilePlatformEnableImpressions = require(ProfilePlatformParent.SharedFlags).FFlagProfilePlatformEnableImpressions

local function SquareCollectionsGridView(arg1)
    local current, containerRef = React.useState(nil)
    local parentRef = if FFlagProfilePlatformEnableImpressions then React.useRef(nil) else nil
    local var4 = if FFlagProfilePlatformEnableImpressions then useProfileAnalyticsContext() else nil
    local var5 = nil
    local var6 = nil
    if FFlagProfilePlatformEnableImpressions then
        local var7
        var5, var7 = useCollectionImpressionsSignal(var4.scrollViewPositionChangedSignal)
        var6 = var7
    end

    React.useEffect(function()
        if arg1.setForwardRef then
            arg1.setForwardRef(current)
        end
        if FFlagProfilePlatformEnableImpressions then
            parentRef.current = current
        end
    end, { current })

    local maxNumRows = arg1.maxNumRows or ProfileCollectionGridConfig.Constants.DEFAULT_MAX_NUM_ROWS

    local sideMargin, var9 = useDynamicSizeMargin()
    local var10 = useCollectionLayoutParams(CollectionItemSize.Small, current, false, { sideMargin = 0 })

    local var11 = if FFlagProfilePlatformEnableImpressions then React.useCallback(function(vector2: Vector2)
        if arg1.onContainerSizeChanged then
            arg1.onContainerSizeChanged(vector2)
        end
        var6()
    end, { arg1.onContainerSizeChanged, var6 }) else nil

    local var12 = if FFlagProfilePlatformEnableImpressions then React.useCallback(function(num1: number, num2: number)
        if arg1.onViewableItemsChanged then
            arg1.onViewableItemsChanged(num1, num2)
        end
        var6()
    end, { arg1.onViewableItemsChanged, var6 }) else nil

    local createElement = React.createElement
    local str1 = "Frame"
    local tbl1 = {
        Size = UDim2.new(1, 0, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        BackgroundTransparency = 1,
        LayoutOrder = arg1.layoutOrder,
        [React.Change.AbsoluteSize] = var9
    }
    local tbl2 = { CollectionGrid = 0, ScreenSizeImpressionsTracker = 0 }
    local createElement2 = React.createElement
    local var13 = CollectionGrid
    local tbl3 = {
        columnGap = var10.columnGap,
        containerRef = containerRef,
        getItemHeight = arg1.getItemHeight,
        headerButtonText = arg1.headerButtonText,
        hideHeaderButton = arg1.hideHeaderButton,
        items = arg1.items,
        LayoutOrder = arg1.layoutOrder,
        maxNumRows = maxNumRows,
        numColumns = arg1.overrides and arg1.overrides.numColumns or var10.numColumns,
        onActivateHeader = arg1.onActivateHeader,
        onActivateInfoIcon = arg1.onActivateInfoIcon,
        onContainerSizeChanged = 0,
        onViewableItemsChanged = 0,
        verticalScrollingFrameRef = 0,
        renderItem = 0,
        sideMargin = 0,
        subtitle = 0,
        title = 0,
        tooltipInfoText = 0,
        verticalPadding = 0
    }

    if not FFlagProfilePlatformEnableImpressions then
        var11 = arg1.onContainerSizeChanged
    end

    tbl3.onContainerSizeChanged = var11

    if not FFlagProfilePlatformEnableImpressions then
        var12 = arg1.onViewableItemsChanged
    end

    tbl3.onViewableItemsChanged = var12

    tbl3.verticalScrollingFrameRef = arg1.verticalScrollingFrameRef
    tbl3.renderItem = arg1.renderItem
    tbl3.sideMargin = sideMargin
    tbl3.subtitle = arg1.subtitle
    tbl3.title = arg1.title
    tbl3.tooltipInfoText = arg1.tooltipInfoText
    tbl3.verticalPadding = var10.verticalPadding
    tbl2.CollectionGrid = createElement2(var13, tbl3)

    tbl2.ScreenSizeImpressionsTracker = if FFlagProfilePlatformEnableImpressions and arg1.impressionsTag and arg1.sendImpressions then React.createElement(
        ScreenSizeImpressionsTracker,
        {
            pageContext = AppPage.ProfilePlatform,
            parentRef = parentRef,
            impressionsTag = arg1.impressionsTag,
            scrollViewPositionChangedSignal = var5,
            sendImpressions = arg1.sendImpressions
        }
    ) else nil
    return createElement(str1, tbl1, tbl2)
end

return SquareCollectionsGridView
