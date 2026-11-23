-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T22:51:24Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BulkPurchaseApp = script:FindFirstAncestor("BulkPurchaseApp")

local _Types = require(BulkPurchaseApp.Store.Types)

local function getMarketPlaceProductTypeFromItemType(str1: string): Enum.MarketplaceProductType -- Luacid: Inlined by compiler; 1 call site recovered
    return if str1 == "AvatarBundle" then Enum.MarketplaceProductType.AvatarBundle else Enum.MarketplaceProductType.AvatarAsset
end

local function selectResultItems(arg1)
    local result = {}
    if arg1.itemData then
        for _, value in arg1.itemData do
            table.insert(result, {
                id = value.id,
                type = if value.type == "AvatarBundle" then getMarketPlaceProductTypeFromItemType("AvatarBundle") else Enum.MarketplaceProductType.AvatarAsset,
                status = if arg1.itemStatuses then arg1.itemStatuses[value.id] or Enum.MarketplaceItemPurchaseStatus.SystemError else Enum.MarketplaceItemPurchaseStatus.SystemError
            })
        end
    end

    return result
end

return selectResultItems
