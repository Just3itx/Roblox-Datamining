-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T17:41:08Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarWorkshop = script:FindFirstAncestor("AvatarWorkshop")
local AvatarWorkshopParent = AvatarWorkshop.Parent

local React = require(AvatarWorkshopParent.React)
local Foundation = require(AvatarWorkshopParent.Foundation)
local Localization = require(AvatarWorkshopParent.Localization)

local ItemCard = require(AvatarWorkshop.Components.ItemCard.ItemCard)
local VirtualizedGrid = require(AvatarWorkshop.Components.VirtualizedGrid.VirtualizedGrid)
local _InventoryGridTypes = require(script.Parent.InventoryGridTypes)

local InputSize = Foundation.Enums.InputSize
local useLocalization = Localization.Hooks.useLocalization

local function renderItem(arg1)
    return React.createElement(
        ItemCard,
        {
            image = arg1.image,
            isSelected = arg1.isSelected,
            showDetails = false,
            onActivated = arg1.onActivated
        }
    )
end

local function keyExtractor(arg1)
    return arg1.id
end

local function renderFooter(arg1, tbl1)
    if arg1.isLoadingNextPage then
        return React.createElement(
            Foundation.View,
            { tag = "align-x-center size-full-0 auto-y padding-medium" },
            {
                Loading = React.createElement(Foundation.Loading)
            }
        )
    elseif arg1.hasNextPageError then
        return React.createElement(
            Foundation.View,
            { tag = "col align-x-center gap-small size-full-0 auto-y padding-medium" },
            {
                Message = React.createElement(
                    Foundation.Text,
                    {
                        tag = "auto-xy text-body-small content-muted",
                        Text = tbl1.loadMoreItemsError,
                        LayoutOrder = 1
                    }
                ),
                Retry = React.createElement(Foundation.Button, {
                    testId = "--avatar-workshop-inventorygrid-button-retry-next-page",
                    size = InputSize.Small,
                    text = tbl1.tryAgain,
                    onActivated = arg1.onRetry,
                    LayoutOrder = 2
                })
            }
        )
    end

    return nil
end

local function InventoryGridView(arg1)
    local var1 = useLocalization({
        loadItemsError = "Feature.AvatarWorkshop.Message.LoadItemsError",
        loadMoreItemsError = "Feature.AvatarWorkshop.Message.LoadMoreItemsError",
        noItemsOwned = "Feature.AvatarWorkshop.Message.NoItemsOwned",
        tryAgain = "Feature.AvatarWorkshop.Action.TryAgain"
    })

    if arg1.hasFetchError then
        return React.createElement(Foundation.View, {
            tag = "size-full padding-large",
            testId = "InventoryGridView"
        }, {
            ErrorState = React.createElement(
                Foundation.Empty,
                {
                    text = var1.loadItemsError,
                    button = {
                        text = var1.tryAgain,
                        onActivated = arg1.onRetry
                    }
                }
            )
        })
    elseif arg1.isLoadingInitialPage then
        return React.createElement(
            Foundation.View,
            { tag = "align-x-center align-y-center size-full", testId = "InventoryGridView" },
            {
                Loading = React.createElement(Foundation.Loading)
            }
        )
    elseif arg1.isEmpty then
        return React.createElement(
            Foundation.View,
            { tag = "size-full padding-large", testId = "InventoryGridView" },
            {
                EmptyState = React.createElement(Foundation.Empty, { text = var1.noItemsOwned })
            }
        )
    end

    return React.createElement(Foundation.View, {
        tag = "size-full padding-x-large",
        testId = "InventoryGridView"
    }, {
        Grid = React.createElement(VirtualizedGrid, {
            data = arg1.items,
            fallbackNumColumns = arg1.fallbackNumColumns,
            minItemWidth = arg1.minItemWidth,
            minColumns = arg1.minColumns,
            lastMeasuredGridWidth = arg1.lastMeasuredGridWidth,
            onGridWidthChanged = arg1.onGridWidthChanged,
            rowGap = arg1.rowGap,
            columnGap = arg1.columnGap,
            contentPaddingTop = arg1.contentPaddingY,
            contentPaddingBottom = arg1.contentPaddingY,
            renderItem = renderItem,
            keyExtractor = keyExtractor,
            onEndReached = arg1.onEndReached,
            ListFooterSlot = renderFooter(arg1, var1)
        })
    })
end

return InventoryGridView
