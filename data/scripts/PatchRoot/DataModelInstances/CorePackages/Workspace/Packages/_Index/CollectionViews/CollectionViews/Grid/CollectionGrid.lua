-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T08:11:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CollectionViews = script:FindFirstAncestor("CollectionViews")
local CollectionViewsParent = CollectionViews.Parent

local React = require(CollectionViewsParent.React)
local Cryo = require(CollectionViewsParent.Cryo)
local ArgCheck = require(CollectionViewsParent.ArgCheck)
local useDesignTokens = require(CollectionViewsParent.Style).useDesignTokens
local useTokens = require(CollectionViewsParent.Foundation).Hooks.useTokens
local t = require(CollectionViewsParent.t)
local validateProps = require(CollectionViewsParent.DiscoveryUtils).validateProps

local useCollectionSizeBindings = require(CollectionViews.useCollectionSizeBindings)
local CollectionHeader = require(CollectionViews.CollectionHeader)
local GridOfCollectionItems = require(CollectionViews.Grid.GridOfCollectionItems)
local _CollectionViewTypes = require(CollectionViews.CollectionViewTypes)
local useCollectionLayout = require(CollectionViews.CollectionLayoutStore.useCollectionLayout)

local SharedFlags = require(CollectionViewsParent.SharedFlags)

local FFlagLuaAppRfyRevealRows = SharedFlags.FFlagLuaAppRfyRevealRows
local FFlagLuaAppSortHeaderAnchorTag = SharedFlags.FFlagLuaAppSortHeaderAnchorTag
local FFlagSduiCollectionGridRevealRows = SharedFlags.FFlagSduiCollectionGridRevealRows
local FFlagSduiComponentsUseFoundationTokens = SharedFlags.FFlagSduiComponentsUseFoundationTokens

local var1 = t.strictInterface({
    testId = t.optional(t.string),
    Position = t.optional(t.UDim2),
    LayoutOrder = t.optional(t.number),
    ZIndex = if FFlagLuaAppRfyRevealRows or FFlagSduiCollectionGridRevealRows then t.optional(t.number) else nil,
    containerRef = t.optional(t.union(t.table, t.callback)),
    verticalPadding = t.optional(t.number),
    maxNumRows = t.optional(t.number),
    verticalScrollingFrameRef = t.optional(t.table),
    collectionItemSize = t.optional(t.string),
    numColumns = t.optional(t.number),
    items = t.table,
    renderItem = t.callback,
    getItemHeight = t.callback,
    columnGap = t.optional(t.number),
    sideMargin = t.optional(t.number),
    title = t.optional(t.union(t.string, t.callback)),
    subtitle = t.optional(t.string),
    tooltipInfoText = t.optional(t.string),
    onActivateInfoIcon = t.optional(t.callback),
    tooltipSupportsVR = t.optional(t.boolean),
    tooltipSupportsTenFootUi = t.optional(t.boolean),
    onActivateHeader = t.optional(t.callback),
    headerButtonText = t.optional(t.string),
    headerTag = if FFlagLuaAppSortHeaderAnchorTag then t.optional(t.string) else nil,
    onViewableItemsChanged = t.optional(t.callback),
    onContainerSizeChanged = t.optional(t.callback),
    hideHeaderButton = t.optional(t.boolean),
    bufferRowsBelowScreen = t.optional(t.number),
    bufferRowsAboveScreen = t.optional(t.number),
    disableRelativeGap = t.optional(t.boolean),
    headerComponent = t.optional(t.table),
    thresholdRowsFromBottom = t.optional(t.number),
    onReachedThresholdFromEnd = t.optional(t.union(t.table, t.callback))
})

local tbl1 = { numColumns = 0, columnGap = 0, sideMargin = 0, verticalPadding = 0 }

return (React.memo(function(tbl2) -- name: CollectionGrid
    validateProps(var1, tbl2)
    local var2 = Cryo.Dictionary.join(tbl1, tbl2)

    local sideMargin = var2.sideMargin
    local var3 = useCollectionLayout(var2.collectionItemSize)
    local numColumns = tbl2.numColumns or var3.itemsPerRow
    local columnGap = tbl2.columnGap or var3.gutter
    local verticalPadding = tbl2.verticalPadding or var3.verticalGap

    ArgCheck.assert(numColumns >= 1)
    ArgCheck.assert(sideMargin >= 0)
    ArgCheck.assert(verticalPadding >= 0)
    ArgCheck.assert(columnGap >= 0)

    local size400 = (if FFlagSduiComponentsUseFoundationTokens then useTokens() else useDesignTokens()).Size.Size_400

    local itemSizeBinding, _, var8, ref = useCollectionSizeBindings(numColumns, columnGap, sideMargin, 0, var2.getItemHeight, var2.onContainerSizeChanged)

    local var10 = var2.title and var2.title ~= ""

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
        ZIndex = if FFlagLuaAppRfyRevealRows or FFlagSduiCollectionGridRevealRows then var2.ZIndex else nil,
        [React.Tag] = if var2.testId then `data-testid={var2.testId}` else nil
    }
    local tbl4 = { CollectionContent = 0 }
    local createElement2 = React.createElement
    local str2 = "Frame"
    local tbl5 = {
        AutomaticSize = Enum.AutomaticSize.Y,
        Size = UDim2.new(1, 0, 0, 0),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        [React.Change.AbsoluteSize] = var8,
        ref = ref
    }
    local tbl6 = {
        UIPadding = if sideMargin > 0 then React.createElement("UIPadding", { PaddingLeft = UDim.new(0, sideMargin), PaddingRight = UDim.new(0, sideMargin) }) else nil,
        UIListLayout = 0,
        Header = 0,
        GridOfItems = 0
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
    local num1 = 0

    if not (var10 or var2.headerComponent) then
        size400 = nil
    end

    tbl7.Padding = new(num1, size400)
    tbl6.UIListLayout = createElement3(str3, tbl7)
    local var11

    if var2.headerComponent then
        var11 = var2.headerComponent
    else
        var11 = React.createElement(CollectionHeader, {
            LayoutOrder = 1,
            title = var2.title,
            subtitle = var2.subtitle,
            tooltipInfoText = var2.tooltipInfoText,
            onActivateInfoIcon = var2.onActivateInfoIcon,
            tooltipSupportsVR = var2.tooltipSupportsVR,
            tooltipSupportsTenFootUi = var2.tooltipSupportsTenFootUi,
            hideButton = #var2.items < 1 or var2.hideHeaderButton or not var10,
            onActivate = var2.onActivateHeader,
            buttonText = var2.headerButtonText,
            headerTag = if FFlagLuaAppSortHeaderAnchorTag then var2.headerTag else nil
        })
    end

    tbl6.Header = var11

    tbl6.GridOfItems = React.createElement(GridOfCollectionItems, {
        verticalScrollingFrameRef = var2.verticalScrollingFrameRef,
        onViewableItemsChanged = var2.onViewableItemsChanged,
        itemSizeBinding = itemSizeBinding,
        maxNumRows = var2.maxNumRows,
        numColumns = numColumns,
        items = var2.items,
        renderItem = var2.renderItem,
        columnGap = columnGap,
        sideMargin = sideMargin,
        verticalPadding = verticalPadding,
        bufferRowsBelowScreen = var2.bufferRowsBelowScreen,
        bufferRowsAboveScreen = var2.bufferRowsAboveScreen,
        LayoutOrder = 2,
        disableRelativeGap = var2.disableRelativeGap,
        thresholdRowsFromBottom = var2.thresholdRowsFromBottom,
        onReachedThresholdFromEnd = var2.onReachedThresholdFromEnd
    })
    tbl4.CollectionContent = createElement2(str2, tbl5, tbl6)
    return createElement(str1, tbl3, tbl4)
end))
