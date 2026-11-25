-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T14:41:10Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ShareSheet = script:FindFirstAncestor("ShareSheet")
local ShareSheetParent = ShareSheet.Parent

local Foundation = require(ShareSheetParent.Foundation)
local React = require(ShareSheetParent.React)
local SignalsReact = require(ShareSheetParent.SignalsReact)
local ViewRecycler = require(ShareSheetParent.ViewRecycler)

local PeoplePickerListView = require(script.Parent.PeoplePickerListView)
local ShareSheetConstants = require(ShareSheet.ShareSheetConstants)
local usePeoplePickerListItemViewModel = require(script.Parent.usePeoplePickerListItemViewModel)
local _usePeoplePickerListViewModel = require(script.Parent.usePeoplePickerListViewModel)
local _usePeoplePickerPagination = require(ShareSheet.Components.PeoplePicker.usePeoplePickerPagination)

local useTokens = Foundation.Hooks.useTokens

local function PeoplePickerListItem(arg1)
    local var1 = usePeoplePickerListItemViewModel(arg1)

    return React.createElement(PeoplePickerListView.Item, var1)
end

local function getItemKey(tbl1): string
    if tbl1.kind == "conversation" then
        return `item--{tbl1.item.id}`
    end

    return `skeleton--{tbl1.index}`
end

local recyclableView = ViewRecycler.createRecyclableView(function(arg1) -- name: ConversationRowView
    local var1 = SignalsReact.useSignalState(arg1.itemSignal)
    local item = var1.item

    return React.createElement(PeoplePickerListItem, {
        description = item.description,
        isLoading = item.isLoading,
        isSelected = item.isSelected,
        primaryUserId = item.primaryUserId,
        secondUserId = item.secondUserId,
        title = item.displayName,
        onActivated = function()
            var1.onConversationActivated(item.id)
        end,
        testId = `share-sheet-people-picker-row--{item.id}`
    })
end)

local recyclableView2 = ViewRecycler.createRecyclableView(function(arg1) -- name: SkeletonRowView
    local var1 = SignalsReact.useSignalState(arg1.itemSignal)

    return React.createElement(PeoplePickerListItem, {
        description = "",
        isLoading = true,
        isSelected = false,
        primaryUserId = "",
        title = "",
        onActivated = function() end,
        testId = `share-sheet-people-picker-skeleton--{var1.index}`
    })
end)

local function getItemType(tbl1)
    return if tbl1.kind == "conversation" then recyclableView else recyclableView2
end

local function useMeasuredLayout(estimatedItemLength: number)
    local var1 = React.useMemo(function()
        return ViewRecycler.Layout.measured({ estimatedItemLength = estimatedItemLength })
    end, { estimatedItemLength })

    React.useEffect(function()
        return function()
            var1.destroy()
        end
    end, { var1 })

    return var1
end

local function PeoplePickerVirtualizedList(tbl1)
    local var1 = useTokens()
    local items = React.useMemo(function()
        local itemsLen = #tbl1.items
        local var2 = table.create(itemsLen + tbl1.skeletonCount)
        for k, item in tbl1.items do
            local tbl2 = {
                kind = "conversation",
                item = item,
                onConversationActivated = tbl1.onConversationActivated
            }
            var2[k] = tbl2
        end

        for index = 1, tbl1.skeletonCount do
            var2[itemsLen + index] = { kind = "skeleton", index = index }
        end

        return var2
    end, { tbl1.items, tbl1.onConversationActivated, tbl1.skeletonCount })
    local var3 = React.useMemo(function()
        return { items = items, getItemKey = getItemKey }
    end, { items })
    local itemLayoutMetrics = PeoplePickerListView.getItemLayoutMetrics(var1)
    local layout = useMeasuredLayout(itemLayoutMetrics.estimatedRowHeight)
    local listRef = React.useRef(nil)
    local var6 = React.useRef(tbl1.scrollResetQuery)
    React.useEffect(function()
        if var6.current == tbl1.scrollResetQuery then
            return
        end
        var6.current = tbl1.scrollResetQuery

        local current = listRef.current
        if current then
            current.scrollToOffset(0)
        end
    end, { tbl1.scrollResetQuery })

    return React.createElement(ViewRecycler.VirtualList, {
        data = var3,
        layout = layout,
        axis = ViewRecycler.Axis.Y,
        itemType = getItemType,
        overscan = math.max(0, ShareSheetConstants.FIntShareSheetPeoplePickerOverscanRows),
        endReachedThreshold = tbl1.paginationProps.endReachedThreshold,
        listRef = listRef,
        onContentLengthChanged = tbl1.paginationProps.onContentLengthChanged,
        onEndReached = tbl1.paginationProps.onEndReached,
        onScrollOffsetChanged = tbl1.paginationProps.onScrollOffsetChanged,
        onViewportChanged = tbl1.paginationProps.onViewportChanged,
        scrollingFrameRef = tbl1.paginationProps.scrollingFrameRef,
        scrollingFrameProps = {
            Name = "ShareSheetPeoplePickerScrollingFrame",
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            ScrollBarThickness = 0,
            Selectable = false
        }
    })
end

return PeoplePickerVirtualizedList
