-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T16:31:16Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceInspectAndBuy = script:FindFirstAncestor("AvatarExperienceInspectAndBuy")
local AvatarExperienceInspectAndBuyParent = AvatarExperienceInspectAndBuy.Parent
local React = require(AvatarExperienceInspectAndBuyParent.React)
local AvatarExperienceModel = require(AvatarExperienceInspectAndBuyParent.AvatarExperienceModel)
local _Types = require(AvatarExperienceInspectAndBuy.Types)
local ItemTypeEnum = AvatarExperienceModel.Enums.ItemTypeEnum
local Constants = require(AvatarExperienceInspectAndBuy.Constants)
local AssetLocalizationKeys = Constants.AssetLocalizationKeys
local BundleLocalizationKeys = Constants.BundleLocalizationKeys
local PriceStatusLocalizationKeys = Constants.PriceStatusLocalizationKeys
local ItemDetailsLocalizationKeys = Constants.ItemDetailsLocalizationKeys
local Cryo = require(AvatarExperienceInspectAndBuyParent.Cryo)
local useLocalization = require(AvatarExperienceInspectAndBuyParent.Localization).Hooks.useLocalization

return function(arg1)
    local var1 = React.useMemo(function()
        return if arg1 and arg1.itemType == ItemTypeEnum.Bundle then BundleLocalizationKeys else AssetLocalizationKeys
    end, { arg1 })

    local var2 = React.useMemo(function()
        return Cryo.Dictionary.join(var1, PriceStatusLocalizationKeys, ItemDetailsLocalizationKeys, {
            ownedItems = {
                ItemDetailsLocalizationKeys.ownedItems,
                QUANTITY = if arg1 and arg1.collectibleItemDetails then arg1.collectibleItemDetails.resellableCount else 0
            }
        })
    end, { var1, arg1 })

    return (useLocalization(var2))
end
