-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T03:31:21Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceProfilePictureEditor = script:FindFirstAncestor("AvatarExperienceProfilePictureEditor")
local AvatarExperienceProfilePictureEditorParent = AvatarExperienceProfilePictureEditor.Parent
local React = require(AvatarExperienceProfilePictureEditorParent.React)

local _VirtualizedFeedView = require(script.Parent.VirtualizedFeedView)
local _AssetPickerTile = require(script.Parent.AssetPickerTile)
local getGridMetrics = require(AvatarExperienceProfilePictureEditor.Utils.getGridMetrics)

local function useAssetPickerVirtualizedFeedViewModel(tbl1)
    local containerWidth, var2 = React.useState(tbl1.initialContainerWidth)
    local var3 = React.useMemo(function()
        return getGridMetrics({
            containerWidth = containerWidth,
            minTileSize = tbl1.minTileSize,
            gap = tbl1.gap,
            horizontalPadding = tbl1.horizontalPadding,
            strokeInset = tbl1.strokeInset
        })
    end, {
        containerWidth,
        tbl1.minTileSize,
        tbl1.gap,
        tbl1.horizontalPadding,
        tbl1.strokeInset
    })

    local rows = React.useMemo(function()
        local result = ({})
        for k, item in tbl1.items do
            local num1 = math.floor((k - 1) / var3.itemsPerRow) + 1
            local tbl2 = result[num1]
            if tbl2 == nil then
                tbl2 = {}
                result[num1] = tbl2
            end
            table.insert(tbl2, item)
        end
        return result
    end, { tbl1.items, var3.itemsPerRow })

    local onContainerWidthChanged = React.useCallback(function(num1: number)
        var2(num1)
    end, {})

    local var6 = React.useRef(nil)
    local onEndReached = React.useCallback(function()
        if not tbl1.hasMoreItems or tbl1.isLoadingMore or tbl1.hasLoadMoreError or var6.current == tbl1.items then
            return
        end

        var6.current = tbl1.items
        tbl1.onMoreItems()
    end, {
        tbl1.items,
        tbl1.hasMoreItems,
        tbl1.isLoadingMore,
        tbl1.hasLoadMoreError,
        tbl1.onMoreItems
    })

    return {
        rows = rows,
        itemsPerRow = var3.itemsPerRow,
        gap = tbl1.gap,
        selectedId = tbl1.selectedId,
        onSelect = tbl1.onSelect,
        onDetailsActivated = tbl1.onDetailsActivated,
        labels = tbl1.labels,
        onContainerWidthChanged = onContainerWidthChanged,
        onEndReached = onEndReached,
        isLoadingMore = tbl1.isLoadingMore,
        hasLoadMoreError = tbl1.hasLoadMoreError,
        onRetryLoadMore = tbl1.onRetryLoadMore,
        listHeaderComponent = tbl1.listHeaderComponent,
        listFooterComponent = tbl1.listFooterComponent,
        horizontalPadding = tbl1.horizontalPadding + tbl1.strokeInset,
        LayoutOrder = tbl1.LayoutOrder
    }
end

return useAssetPickerVirtualizedFeedViewModel
