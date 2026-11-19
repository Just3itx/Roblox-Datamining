-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T22:20:35Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local Cryo = require(CorePackages.Packages.Cryo)
local Rodux = require(CorePackages.Packages.Rodux)
local scriptParentParent = script.Parent.Parent
local SetBundles = require(scriptParentParent.Actions.SetBundles)
local SetFavoriteBundle = require(scriptParentParent.Actions.SetFavoriteBundle)
local UpdateBulkPuchaseResults = require(scriptParentParent.Actions.UpdateBulkPuchaseResults)
local SetAvatarPreviewDetails = require(scriptParentParent.Actions.SetAvatarPreviewDetails)
local ItemTypeEnum = require(CorePackages.Workspace.Packages.AvatarExperienceModel).Enums.ItemTypeEnum

local FFlagAXEnableFetchAvatarPreview = require(scriptParentParent.Flags.FFlagAXEnableFetchAvatarPreview)

local FFlagAXEnableInspectAndBuyBulkPurchase = require(CorePackages.Workspace.Packages.SharedFlags).FFlagAXEnableInspectAndBuyBulkPurchase

local BundleInfo = require(scriptParentParent.Models.BundleInfo)

local createReducer = Rodux.createReducer

local tbl1 = {}

tbl1[SetFavoriteBundle.name] = function(arg1, arg2)
    local var1 = arg1[arg2.id] or {}
    local var2 = Cryo.Dictionary.join({}, var1)
    arg1[arg2.id] = Cryo.Dictionary.join(var2, BundleInfo.fromGetFavoriteForAsset(arg2.id, arg2.isFavorite))
    return arg1
end

tbl1[UpdateBulkPuchaseResults.name] = FFlagAXEnableInspectAndBuyBulkPurchase and function(arg1, arg2)
    for _, item in arg2.result.Items do
        if item.type == Enum.MarketplaceProductType.AvatarBundle then
            local var1 = Cryo.Dictionary.join({}, arg1[item.id])
            arg1[item.id] = Cryo.Dictionary.join(var1, BundleInfo.fromBulkPurchaseResult(item, var1))
        end
    end
    return arg1
end or nil

tbl1[SetAvatarPreviewDetails.name] = FFlagAXEnableFetchAvatarPreview and function(arg1, arg2)
    local look = arg2.avatarPreviewDetails.look
    local tbl2 = {}
    if look.items then
        for _, item in look.items do
            if item.itemType == ItemTypeEnum.Bundle then
                local id = item.id
                tbl2[tostring(id)] = BundleInfo.fromAvatarPreviewItem(item)
            end
        end
    end
    return Cryo.Dictionary.join(arg1, tbl2)
end or nil

tbl1[SetBundles.name] = function(arg1, arg2)
    local tbl2 = {}

    for _, value in ipairs(arg2.bundles) do
        assert(value.bundleId ~= nil, "Expected a bundle id when setting a bundle's information.")
        local var1 = arg1[value.bundleId] or {}

        if value.assetsInBundle then
            local assetsInBundle = {}

            for _, value2 in value.assetsInBundle do
                for _, value3 in var1.assetsInBundle or {} do
                    if value3.id == value2.id then
                        table.insert(assetsInBundle, (Cryo.Dictionary.join(value3, value2)))
                        break
                    end
                end
            end

            value.assetsInBundle = assetsInBundle
        end

        tbl2[value.bundleId] = Cryo.Dictionary.join(var1, value)
        if tbl2[value.bundleId] then
            tbl2[value.bundleId] = BundleInfo.getSaleDetailsForCollectibles(tbl2[value.bundleId])
        end
    end

    return Cryo.Dictionary.join(arg1, tbl2)
end

return createReducer({}, tbl1)
