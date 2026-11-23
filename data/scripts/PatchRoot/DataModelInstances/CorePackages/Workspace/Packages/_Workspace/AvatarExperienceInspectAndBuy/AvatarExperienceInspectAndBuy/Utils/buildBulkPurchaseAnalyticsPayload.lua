-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T16:31:25Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceInspectAndBuy = script:FindFirstAncestor("AvatarExperienceInspectAndBuy")
local AvatarExperienceInspectAndBuyParent = AvatarExperienceInspectAndBuy.Parent

local _Types = require(AvatarExperienceInspectAndBuy.Types)
local ItemTypeEnum = require(AvatarExperienceInspectAndBuyParent.AvatarExperienceModel).Enums.ItemTypeEnum
local _createItemSelectionStore = require(AvatarExperienceInspectAndBuy.Stores.createItemSelectionStore)
local convertAssetInfoToItemData = require(AvatarExperienceInspectAndBuy.Utils.convertAssetInfoToItemData)
local convertBundleInfoToItemData = require(AvatarExperienceInspectAndBuy.Utils.convertBundleInfoToItemData)
local getPriceStatus = require(AvatarExperienceInspectAndBuy.Utils.getPriceStatus)
local _PriceStatus = require(AvatarExperienceInspectAndBuy.Enums.PriceStatus)
local getPriceInRobux = require(AvatarExperienceInspectAndBuy.Utils.itemDetailsUtils).getPriceInRobux

local function buildBulkPurchaseAnalyticsPayload(tbl1)
    local itemId = tbl1.itemId
    local collectibleResellableInstances = tbl1.collectibleResellableInstances
    local storedData = tbl1.storedData

    local days = nil
    local var1, var2

    if tbl1.itemType == ItemTypeEnum.Asset then
        local asset = tbl1.assetsMap and tbl1.assetsMap[itemId]
        if not asset then
            return nil
        end

        local var3 = if asset.collectibleItemId and collectibleResellableInstances then collectibleResellableInstances[asset.collectibleItemId] else nil
        local var4 = convertAssetInfoToItemData(asset, var3)
        local priceStatus = getPriceStatus(var4, true)
        var1 = getPriceInRobux(var4, priceStatus)
        var2 = asset.assetTypeId

        if storedData and storedData.timedOptions then
            for _, timedOption in storedData.timedOptions do
                if timedOption.selected then
                    days = timedOption.days
                    var1 = timedOption.price
                    break
                end
            end
        end
    else
        local var3 = tbl1.bundlesMap and tbl1.bundlesMap[itemId]
        if not var3 then
            return nil
        end

        local var4 = if var3.collectibleItemId and collectibleResellableInstances then collectibleResellableInstances[var3.collectibleItemId] else nil
        local var5 = convertBundleInfoToItemData(var3, var4)
        local priceStatus = getPriceStatus(var5, true)
        var1 = getPriceInRobux(var5, priceStatus)
        if var5 then
            var2 = var5.itemSubType
        else
            var2 = nil
        end
    end
    return { itemSubType = var2, timedOptionDays = days, price = var1 }
end

return buildBulkPurchaseAnalyticsPayload
