-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T02:10:38Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceCatalogParent = script:FindFirstAncestor("AvatarExperienceCatalog").Parent
local getTryOnItemReducerKey = require(AvatarExperienceCatalogParent.AvatarExperienceCommon).Utils.getTryOnItemReducerKey

local function mapPurchaseItemsResponse(arg1)
    local lineItems = ({})

    for _, fulfillmentGroup in arg1.fulfillmentGroups do
        for _, lineItem in fulfillmentGroup.lineItems do
            local var1 = if lineItem.assetId then lineItem.assetId else lineItem.bundleId
            local name = if lineItem.assetId then Enum.AvatarItemType.Asset.Name else Enum.AvatarItemType.Bundle.Name

            if not (var1 and name) then
                continue
            end

            local tryOnItemReducerKey = getTryOnItemReducerKey(var1, name)
            lineItems[tryOnItemReducerKey] = {
                collectibleProductId = lineItem.collectibleProductId,
                agreedPriceRobux = lineItem.agreedPriceRobux,
                assetId = lineItem.assetId,
                bundleId = lineItem.bundleId,
                status = lineItem.status,
                errorReason = lineItem.errorReason
            }
        end
    end

    return {
        status = arg1.status,
        lineItems = lineItems
    }
end

return mapPurchaseItemsResponse
