-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T05:20:53Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfilePlatform = script:FindFirstAncestor("ProfilePlatform")
local ProfilePlatformParent = ProfilePlatform.Parent

local React = require(ProfilePlatformParent.React)

local Enums = require(ProfilePlatform.Common.Enums)
local _Types = require(ProfilePlatform.Common.Types)
local useInspectAvatarData = require(ProfilePlatform.Components.InspectAvatar.useInspectAvatarData)

local useRecentActivityPurchase = require(script.Parent.useRecentActivityPurchase)

local function useRecentActivityInspectAndBuyViewModel(tbl1)
    local assetIds = tbl1.assetIds
    local var1 = React.useMemo(function()
        local result = {}
        for _, assetId in assetIds do
            table.insert(result, { assetId = assetId, itemType = Enums.ItemTypes.Asset })
        end
        return result
    end, { assetIds })

    local var2 = useInspectAvatarData(var1)
    local displayItems = var2.displayItems

    local var3 = useRecentActivityPurchase({ displayItems = displayItems, localUserId = var2.localUserId, onClose = tbl1.onClose })

    local openItemDetails = React.useCallback(function(_: string, _: string, _: number?) end, {})

    return {
        displayItems = displayItems,
        selectedItems = var3.selectedItems,
        isLoading = var2.isLoading,
        purchaseSummary = var3.purchaseSummary,
        isPurchasing = var3.isPurchasing,
        isConfirmingPurchase = var3.isConfirmingPurchase,
        isShowingInsufficientRobux = var3.isShowingInsufficientRobux,
        robuxBalance = var3.robuxBalance,
        onToggleItem = var3.onToggleItem,
        onBuyAll = var3.onBuyAll,
        onConfirmPurchase = var3.onConfirmPurchase,
        onCancelPurchase = var3.onCancelPurchase,
        onDismissInsufficientRobux = var3.onDismissInsufficientRobux,
        onClose = tbl1.onClose,
        openItemDetails = openItemDetails
    }
end

return useRecentActivityInspectAndBuyViewModel
