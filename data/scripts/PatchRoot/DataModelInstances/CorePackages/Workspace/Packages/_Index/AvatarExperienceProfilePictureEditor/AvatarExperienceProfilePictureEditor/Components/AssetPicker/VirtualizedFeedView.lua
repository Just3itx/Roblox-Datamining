-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T03:31:24Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceProfilePictureEditorParent = script:FindFirstAncestor("AvatarExperienceProfilePictureEditor").Parent
local React = require(AvatarExperienceProfilePictureEditorParent.React)
local Foundation = require(AvatarExperienceProfilePictureEditorParent.Foundation)
local AvatarExperienceUIKit = require(AvatarExperienceProfilePictureEditorParent.AvatarExperienceUIKit)

local AssetPickerErrorBody = require(script.Parent.AssetPickerErrorBody)
local AssetPickerTile = require(script.Parent.AssetPickerTile)

local View = Foundation.View
local Loading = Foundation.Loading
local IconSize = Foundation.Enums.IconSize
local VirtualizedFeed = AvatarExperienceUIKit.FeedComponents.VirtualizedFeed

local function AssetPickerVirtualizedFeedView(tbl1)
    local function renderRow(tbl2)
        local tbl3 = ({})
        for layoutOrder, value2 in tbl2.item do
            local var1 = (tbl2.index - 1) * tbl1.itemsPerRow + layoutOrder
            local str1 = `item-{value2.id}`
            local createElement = React.createElement
            local var2 = View
            local tbl4 = {
                Size = UDim2.new(1 / tbl1.itemsPerRow, 0, 0, 0),
                tag = "auto-y",
                LayoutOrder = layoutOrder,
                padding = {
                    left = UDim.new(0, tbl1.gap / 2),
                    right = UDim.new(0, tbl1.gap / 2)
                }
            }
            local tbl5 = {
                Tile = React.createElement(AssetPickerTile, {
                    item = value2,
                    selectedId = tbl1.selectedId,
                    onSelect = tbl1.onSelect,
                    onDetailsActivated = tbl1.onDetailsActivated,
                    labels = tbl1.labels,
                    layoutOrder = var1
                })
            }
            tbl3[str1] = createElement(var2, tbl4, tbl5)
        end

        return React.createElement(View, {
            tag = "row align-x-left align-y-top size-full-0 auto-y",
            LayoutOrder = tbl2.index,
            padding = {
                left = UDim.new(0, tbl1.horizontalPadding - tbl1.gap / 2),
                right = UDim.new(0, tbl1.horizontalPadding - tbl1.gap / 2),
                bottom = UDim.new(0, tbl1.gap)
            }
        }, tbl3)
    end

    local element = nil
    if tbl1.isLoadingMore then
        element = React.createElement(
            View,
            { tag = "align-x-center size-full-0 auto-y padding-large" },
            {
                Loading = React.createElement(Loading, { size = IconSize.Medium })
            }
        )
    elseif tbl1.hasLoadMoreError then
        element = React.createElement(AssetPickerErrorBody, { onRetry = tbl1.onRetryLoadMore })
    end

    local listFooterComponent = element or tbl1.listFooterComponent

    return React.createElement(VirtualizedFeed, {
        data = tbl1.rows,
        renderItem = renderRow,
        onContainerWidthChanged = tbl1.onContainerWidthChanged,
        onEndReached = tbl1.onEndReached,
        onEndReachedThreshold = 0.5,
        ListHeaderComponent = tbl1.listHeaderComponent,
        ListFooterComponent = listFooterComponent,
        shouldWrapFooter = false,
        LayoutOrder = tbl1.LayoutOrder,
        Size = UDim2.fromScale(1, 1)
    })
end

return AssetPickerVirtualizedFeedView
