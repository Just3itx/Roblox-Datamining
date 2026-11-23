-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T17:41:09Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarWorkshop = script:FindFirstAncestor("AvatarWorkshop")
local AvatarWorkshopParent = AvatarWorkshop.Parent

local React = require(AvatarWorkshopParent.React)
local Foundation = require(AvatarWorkshopParent.Foundation)
local SignalsReact = require(AvatarWorkshopParent.SignalsReact)

local _InventoryPagesData = require(AvatarWorkshop.Constants.InventoryPagesData)
local getInventoryPageStore = require(AvatarWorkshop.Stores.Getters.getInventoryPageStore)
local getUiStateStore = require(AvatarWorkshop.Stores.Getters.getUiStateStore)
local _InventoryGridTypes = require(script.Parent.InventoryGridTypes)

local useTokens = Foundation.Hooks.useTokens
local useSignalState = SignalsReact.useSignalState
local getRbxThumb = Foundation.Utility.getRbxThumb
local ThumbnailSize = Foundation.Enums.ThumbnailSize
local ThumbnailType = Foundation.Enums.ThumbnailType

local function useInventoryGridViewModel(tbl1)
    local pageData = tbl1.pageData
    local var1 = useTokens()

    local inventoryPageStore = getInventoryPageStore(pageData)
    local var2 = useSignalState(getUiStateStore)
    local var3 = useSignalState(inventoryPageStore.getEntries)
    local var4 = useSignalState(inventoryPageStore.getIsFetching)
    local var5 = useSignalState(inventoryPageStore.getDidInitialFetch)
    local var6 = useSignalState(inventoryPageStore.getHasFetchError)
    local var7 = useSignalState(inventoryPageStore.getLastPageReached)
    local lastMeasuredGridWidth = useSignalState(var2.getLastMeasuredGridWidth)

    local fetchNextPage = inventoryPageStore.fetchNextPage

    local var9, var10 = React.useState(nil)

    local var11 = React.useCallback(function(str1: string)
        var10(function(str2: string?): string?
            return if str2 == str1 then nil else str1
        end)
    end, {})

    local bool1 = #var3 > 0
    React.useEffect(function()
        if not (bool1 or var4 or var6 or var7) then
            fetchNextPage()
        end
    end, {
        bool1,
        var4,
        var6,
        var7,
        fetchNextPage
    })
    local items = React.useMemo(function()
        local var12 = table.create(#var3)

        for _, value in var3 do
            local itemId = value.itemId
            local image = if value.itemType == "Outfit" then getRbxThumb(ThumbnailType.Outfit, itemId, ThumbnailSize.Medium) else getRbxThumb(ThumbnailType.Asset, itemId, ThumbnailSize.Medium)
            local tbl2 = {
                id = itemId,
                image = image,
                isSelected = var9 == itemId,
                onActivated = 0
            }

            function tbl2.onActivated()
                var11(itemId)
            end

            table.insert(var12, tbl2)
        end

        return var12
    end, { var3, var9, var11 })

    local bool2 = #items > 0

    return {
        items = items,
        isLoadingInitialPage = var4 and not bool2,
        isLoadingNextPage = var4 and bool2,
        isEmpty = var5 and var7 and not var4 and not (var6 or bool2),
        hasFetchError = var6 and not bool2,
        hasNextPageError = var6 and bool2,
        fallbackNumColumns = 5,
        minItemWidth = var1.Size.Size_2000,
        minColumns = 3,
        lastMeasuredGridWidth = lastMeasuredGridWidth,
        onGridWidthChanged = var2.setLastMeasuredGridWidth,
        rowGap = var1.Gap.Medium,
        columnGap = var1.Gap.Medium,
        contentPaddingY = var1.Padding.Large,
        onEndReached = if var6 then nil else fetchNextPage,
        onRetry = fetchNextPage
    }
end

return useInventoryGridViewModel
