-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T05:10:39Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfilePlatform = script:FindFirstAncestor("ProfilePlatform")
local ProfilePlatformParent = ProfilePlatform.Parent

local Enums = require(ProfilePlatform.Common.Enums)
local UserLib = require(ProfilePlatformParent.UserLib)
local AvatarExperienceInspectAndBuy = require(ProfilePlatformParent.AvatarExperienceInspectAndBuy)
local Constants = AvatarExperienceInspectAndBuy.Constants
local getPriceStatusInShop = AvatarExperienceInspectAndBuy.Utils.getPriceStatusInShop
local PriceStatus = AvatarExperienceInspectAndBuy.Enums.PriceStatus

local Constants2 = UserLib.Utils.Constants
local getRbxthumbWithTypeSizeAndOptions = UserLib.Utils.getRbxthumbWithTypeSizeAndOptions

local _Types = require(ProfilePlatform.Common.Types)

local Asset = Constants2.RbxthumbTypes.Asset
local BundleThumbnail = Constants2.RbxthumbTypes.BundleThumbnail

local tbl1 = {
    Shirt = "Classic Shirt",
    Pants = "Classic Pants",
    TShirt = "Classic T-Shirt",
    TShirtAccessory = "T-Shirt",
    DressSkirtAccessory = "Dresses & Skirts"
}

local function isPurchasableStatus(str1: string): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    return str1 == PriceStatus.Free or str1 == PriceStatus.PurchaseFromRoblox or str1 == PriceStatus.PurchaseFromResale
end

local function isBundle(arg1): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    return arg1.itemType == Enums.ItemTypes.Bundle or arg1.itemType == "Bundle"
end

local function getAssetTypeDisplayName(itemSubType: string?, assetTypeNames)
    if not itemSubType then
        return ""
    end

    if assetTypeNames and assetTypeNames[itemSubType] then
        return assetTypeNames[itemSubType]
    end

    local var1 = tonumber(itemSubType)
    if not var1 then
        return tbl1[itemSubType] or itemSubType
    end

    for _, enumItem in Enum.AvatarAssetType:GetEnumItems() do
        if enumItem.Value == var1 then
            return tbl1[enumItem.Name] or enumItem.Name:gsub("(%l)(%u)", "%1 %2")
        end
    end
    return ""
end

return {
    isPurchasableStatus = isPurchasableStatus,
    getPriceStatus = function(arg1)
        return getPriceStatusInShop(arg1)
    end,
    PriceStatusEnum = PriceStatus,
    getThumbnailUrl = function(arg1)
        local var1 = if isBundle(arg1) then BundleThumbnail else Asset
        return getRbxthumbWithTypeSizeAndOptions(arg1.id, var1, 150)
    end,
    getItemTypeDisplayName = function(arg1, arg2)
        if arg1.taxonomyName then
            return arg1.taxonomyName
        end

        local assetTypeNames = arg2.assetTypeNames

        if arg1.itemType ~= Enums.ItemTypes.Bundle and arg1.itemType ~= "Bundle" then
            return (getAssetTypeDisplayName(arg1.itemSubType, assetTypeNames))
        end

        if arg1.itemSubType and assetTypeNames and assetTypeNames[arg1.itemSubType] then
            return assetTypeNames[arg1.itemSubType]
        end

        if arg2 and arg2.bundle then
            return arg2.bundle
        end

        return "Bundle"
    end,
    shouldShowBundleParts = function(arg1): boolean
        local priceStatusInShop = getPriceStatusInShop(arg1)

        if arg1.isOwned or not isPurchasableStatus(priceStatusInShop) then
            return false
        end
        return not (arg1.bundlePartsCount == nil) and arg1.bundlePartsCount > 0
    end,
    ASSET_TYPE_LOCALIZATION_KEYS = Constants.AssetLocalizationKeys,
    BUNDLE_TYPE_LOCALIZATION_KEYS = Constants.BundleLocalizationKeys,
    PRICE_STATUS_LOCALIZATION_KEYS = Constants.PriceStatusLocalizationKeys
}
