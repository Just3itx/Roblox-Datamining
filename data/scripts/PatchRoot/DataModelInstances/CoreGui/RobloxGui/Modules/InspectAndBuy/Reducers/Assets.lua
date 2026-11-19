-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T22:20:32Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local Cryo = require(CorePackages.Packages.Cryo)
local Rodux = require(CorePackages.Packages.Rodux)
local scriptParentParent = script.Parent.Parent
local AssetInfo = require(scriptParentParent.Models.AssetInfo)
local SetAssets = require(scriptParentParent.Actions.SetAssets)
local SetBundlesAssetIsPartOf = require(scriptParentParent.Actions.SetBundlesAssetIsPartOf)
local SetAssetFromBundleInfo = require(scriptParentParent.Actions.SetAssetFromBundleInfo)
local SetAvatarPreviewDetails = require(scriptParentParent.Actions.SetAvatarPreviewDetails)
local SetFavoriteAsset = require(scriptParentParent.Actions.SetFavoriteAsset)
local UpdateBulkPuchaseResults = require(scriptParentParent.Actions.UpdateBulkPuchaseResults)
local ItemTypeEnum = require(CorePackages.Workspace.Packages.AvatarExperienceModel).Enums.ItemTypeEnum
local FFlagAXEnableFetchAvatarPreview = require(scriptParentParent.Flags.FFlagAXEnableFetchAvatarPreview)

local FFlagAXEnableInspectAndBuyBulkPurchase = require(CorePackages.Workspace.Packages.SharedFlags).FFlagAXEnableInspectAndBuyBulkPurchase

local createReducer = Rodux.createReducer
local tbl1 = {}

tbl1[SetFavoriteAsset.name] = function(arg1, arg2)
    local var1 = arg1[arg2.id] or {}
    local var2 = Cryo.Dictionary.join({}, var1)
    arg1[arg2.id] = Cryo.Dictionary.join(var2, AssetInfo.fromGetFavoriteForAsset(arg2.id, arg2.isFavorite))
    return arg1
end

tbl1[UpdateBulkPuchaseResults.name] = FFlagAXEnableInspectAndBuyBulkPurchase and function(arg1, arg2)
    for _, item in arg2.result.Items do
        if item.type == Enum.MarketplaceProductType.AvatarAsset then
            local var1 = Cryo.Dictionary.join({}, arg1[item.id])
            arg1[item.id] = Cryo.Dictionary.join(var1, AssetInfo.fromBulkPurchaseResult(item, var1))
        end
    end
    return arg1
end or nil

tbl1[SetAssets.name] = function(arg1, arg2)
    local tbl2 = {}

    for _, asset in ipairs(arg2.assets) do
        assert(asset.assetId ~= nil, "Expected an asset id when setting an asset's information.")
        local var1 = arg1[asset.assetId] or {}
        tbl2[asset.assetId] = Cryo.Dictionary.join(var1, asset)
        if tbl2[asset.assetId] then
            tbl2[asset.assetId] = AssetInfo.getSaleDetailsForCollectibles(tbl2[asset.assetId])
        end
    end

    return (Cryo.Dictionary.join(arg1, tbl2))
end

tbl1[SetAvatarPreviewDetails.name] = FFlagAXEnableFetchAvatarPreview and function(arg1, arg2)
    local look = arg2.avatarPreviewDetails.look
    if not look.items then
        return arg1
    end

    local tbl2 = {}
    for _, item in look.items do
        if item.itemType == ItemTypeEnum.Asset then
            local id = item.id
            tbl2[tostring(id)] = AssetInfo.fromAvatarPreviewItem(item)
        end
    end
    return Cryo.Dictionary.join(arg1, tbl2)
end or nil

tbl1[SetBundlesAssetIsPartOf.name] = function(arg1, arg2)
    local str1 = tostring(arg2.assetId)
    local bundleIds = arg2.bundleIds
    local var1 = arg1[str1] or {}
    local getAssetBundles = AssetInfo.fromGetAssetBundles(str1, bundleIds)
    local var2 = Cryo.Dictionary.join(var1, getAssetBundles)
    return Cryo.Dictionary.join(arg1, { [str1] = var2 })
end

tbl1[SetAssetFromBundleInfo.name] = function(arg1, arg2)
    local bundleInfo = arg2.bundleInfo
    local str1 = tostring(arg2.assetId)
    local var1 = arg1[str1] or {}
    local bundleInfo2 = AssetInfo.fromBundleInfo(str1, bundleInfo)
    local var2 = Cryo.Dictionary.join(var1, bundleInfo2)

    return Cryo.Dictionary.join(arg1, { [str1] = var2 })
end

return createReducer({}, tbl1)
