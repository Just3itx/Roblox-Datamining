-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T16:31:10Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceInspectAndBuy = script:FindFirstAncestor("AvatarExperienceInspectAndBuy")
local AvatarExperienceInspectAndBuyParent = AvatarExperienceInspectAndBuy.Parent
local _Types = require(AvatarExperienceInspectAndBuy.Types)
local AvatarExperienceModel = require(AvatarExperienceInspectAndBuy.Parent.AvatarExperienceModel)
local React = require(AvatarExperienceInspectAndBuyParent.React)
local useMemo = React.useMemo
local useCallback = React.useCallback
local RoactUtils = require(AvatarExperienceInspectAndBuyParent.RoactUtils)
local convertAssetInfoToItemData = require(AvatarExperienceInspectAndBuy.Utils.convertAssetInfoToItemData)
local convertBundleInfoToItemData = require(AvatarExperienceInspectAndBuy.Utils.convertBundleInfoToItemData)
local useSelector = RoactUtils.Hooks.RoactRodux.useSelector
local tutils = require(AvatarExperienceInspectAndBuyParent.tutils)
local PerformFetch = require(AvatarExperienceInspectAndBuyParent.Http).PerformFetch
local ItemTypeEnum = AvatarExperienceModel.Enums.ItemTypeEnum
local FFlagAXEnableBatchItemDetailsFetchV2 = require(AvatarExperienceInspectAndBuyParent.AvatarExperienceFlags).FFlagAXEnableBatchItemDetailsFetchV2
local BatchItemDetailsPerformFetchKey = require(AvatarExperienceInspectAndBuy.Constants).BatchItemDetailsPerformFetchKey

local function getResellableInsances(arg1)
    return arg1.collectibleResellableInstances
end

local function useConvertedItemData(arg1)
    local id = if arg1 then arg1.id else nil
    local itemType = if arg1 then arg1.itemType else nil

    local var1 = useCallback(function(arg2)
        if itemType == ItemTypeEnum.Asset then
            return arg2.assets[id]
        end

        if itemType == ItemTypeEnum.Bundle then
            return arg2.bundles[id]
        end

        return nil
    end, { id, itemType })

    local var2 = useCallback(function(arg2)
        if FFlagAXEnableBatchItemDetailsFetchV2 then
            return PerformFetch.GetStatus(arg2, BatchItemDetailsPerformFetchKey)
        end

        if not (id and itemType) then
            return nil
        end

        local format = string.format
        local str1 = "inspectAndBuy.%d.getItemDetails.%s.%s"
        local storeId = arg2.storeId
        local var2 = id
        local var3 = if itemType == ItemTypeEnum.Asset then tostring(Enum.AvatarItemType.Asset) else tostring(Enum.AvatarItemType.Bundle)
        local var4 = format(str1, storeId, var2, var3)

        return PerformFetch.GetStatus(arg2, var4)
    end, { id, itemType })

    local var3 = useSelector(var1, tutils.deepEqual)
    local var4 = useSelector(getResellableInsances, tutils.deepEqual)
    local var5 = useSelector(var2, tutils.deepEqual)

    return useMemo(function()
        local var6 = if var3 and var3.collectibleItemId ~= nil and var4 ~= nil then var4[var3.collectibleItemId] else nil

        if var3 then
            if itemType == ItemTypeEnum.Asset then
                return (convertAssetInfoToItemData(var3, var6))
            end

            if itemType == ItemTypeEnum.Bundle then
                return (convertBundleInfoToItemData(var3, var6))
            end
        end

        return nil
    end, { var3, var4, itemType }), var5
end

return useConvertedItemData
