-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T16:31:27Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceInspectAndBuy = script:FindFirstAncestor("AvatarExperienceInspectAndBuy")
local AvatarExperienceInspectAndBuyParent = AvatarExperienceInspectAndBuy.Parent
local ItemTypeEnum = require(AvatarExperienceInspectAndBuyParent.AvatarExperienceModel).Enums.ItemTypeEnum
local _Types = require(AvatarExperienceInspectAndBuy.Types)
local convertAssetInfoToItemData = require(AvatarExperienceInspectAndBuy.Utils.convertAssetInfoToItemData)
local convertBundleInfoToItemData = require(AvatarExperienceInspectAndBuy.Utils.convertBundleInfoToItemData)
local getPriceStatus = require(AvatarExperienceInspectAndBuy.Utils.getPriceStatus)
local PriceStatus = require(AvatarExperienceInspectAndBuy.Enums.PriceStatus)
local getPriceInRobux = require(AvatarExperienceInspectAndBuy.Utils.itemDetailsUtils).getPriceInRobux
local _createItemSelectionStore = require(AvatarExperienceInspectAndBuy.Stores.createItemSelectionStore)

local function convertAvatarItemToItemData(arg1, arg2) -- Luacid: Inlined by compiler; 1 call site recovered
    if arg1.itemType == ItemTypeEnum.Asset then
        local asset = arg2.assets[arg1.id]
        if not asset then
            return nil
        end
        return convertAssetInfoToItemData(asset)
    elseif arg1.itemType == ItemTypeEnum.Bundle then
        local var1 = arg2.bundles[arg1.id]
        if not var1 then
            return nil
        end
        return convertBundleInfoToItemData(var1)
    else
        return nil
    end
end

local function isPurchasableItem(arg1): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    return arg1 == PriceStatus.Free or arg1 == PriceStatus.PurchaseFromRoblox or arg1 == PriceStatus.PurchaseFromResale
end

local function createBulkPurchaseRequestItem(arg1)
    local var1 = if arg1.id then tonumber(arg1.id) or 0 else 0
    return {
        id = var1,
        itemType = if arg1.itemType == ItemTypeEnum.Asset then Enum.AvatarItemType.Asset.Value else Enum.AvatarItemType.Bundle.Value
    }
end

return {
    convertAvatarItemToItemData = convertAvatarItemToItemData,
    isPurchasableItem = isPurchasableItem,
    createBulkPurchaseRequestItem = createBulkPurchaseRequestItem,
    getBulkPurchaseEligibleItems = function(tbl1, arg1, arg2)
        if not tbl1 then
            return {
                requestedItems = {},
                totalPrice = 0
            }
        end

        local requestedItems = {}

        local num1 = 0

        for _, value in tbl1 do
            local var1 = convertAvatarItemToItemData(value, arg1)
            local priceStatus = getPriceStatus(var1, true)

            if not (var1 and isPurchasableItem(priceStatus)) then
                continue
            end
            local var2 = nil

            if var1.id then
                local var3 = arg2[var1.id]

                if var3 and var3.timedOptions then
                    for _, timedOption in var3.timedOptions do
                        if not timedOption.selected then
                            continue
                        end
                        var2 = getPriceInRobux(var1, priceStatus)
                        local bulkPurchaseRequestItem = createBulkPurchaseRequestItem(var1)

                        if timedOption.days > 0 then
                            var2 = timedOption.price
                            bulkPurchaseRequestItem.PurchaseOptions = {{
                                Type = Enum.PurchaseOption.TimedOption,
                                Value = timedOption.days * 86400
                            }}
                        end

                        table.insert(requestedItems, bulkPurchaseRequestItem)
                        break
                    end
                else
                    var2 = getPriceInRobux(var1, priceStatus)
                    table.insert(requestedItems, (createBulkPurchaseRequestItem(var1)))
                end
            end

            if var2 ~= nil then
                num1 += var2
            end
        end

        return { requestedItems = requestedItems, totalPrice = num1 }
    end
}
