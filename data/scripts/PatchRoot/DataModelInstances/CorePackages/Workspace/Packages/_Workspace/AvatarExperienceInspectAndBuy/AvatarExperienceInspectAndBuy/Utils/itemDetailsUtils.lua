-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T16:40:43Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceInspectAndBuy = script:FindFirstAncestor("AvatarExperienceInspectAndBuy")
local AvatarExperienceInspectAndBuyParent = AvatarExperienceInspectAndBuy.Parent
local ItemRestrictions = require(AvatarExperienceInspectAndBuyParent.AXCommon).Enums.ItemRestrictions
local PriceStatus = require(AvatarExperienceInspectAndBuy.Enums.PriceStatus)
local VerifiedBadges = require(AvatarExperienceInspectAndBuyParent.VerifiedBadges)
local Constants = require(AvatarExperienceInspectAndBuy.Constants)

local _Types = require(AvatarExperienceInspectAndBuy.Types)

return {
    isCollectible = function(arg1): boolean
        if not arg1 then
            return false
        end

        if not arg1.itemRestrictions then
            return false
        end

        local itemRestriction = arg1.itemRestrictions[ItemRestrictions.Collectible]
        local itemRestriction2 = arg1.itemRestrictions[ItemRestrictions.Limited]
        local itemRestriction3 = arg1.itemRestrictions[ItemRestrictions.LimitedUnique]

        return not not (itemRestriction or itemRestriction2 or itemRestriction3)
    end,
    isInExperienceCreationPlayable = function(arg1): boolean
        local playabilityStatus = if arg1 then arg1.playabilityStatus else nil
        return not not (playabilityStatus and Constants.ShowPlayableAttributionMapper[playabilityStatus])
    end,
    isTradeable = function(arg1)
        return arg1
            and arg1.itemRestrictions
            and (arg1.itemRestrictions[ItemRestrictions.Limited] or arg1.itemRestrictions[ItemRestrictions.LimitedUnique])
    end,
    getPriceInRobux = function(arg1, purchaseFromResale)
        return if arg1 and purchaseFromResale == PriceStatus.PurchaseFromResale and arg1.collectibleItemDetails then arg1.collectibleItemDetails.lowestResalePrice elseif arg1 then arg1.priceInRobux else nil
    end,
    getItemWidth = function(num1: number, num2: number, num3: number): number
        local num4 = math.floor((num1 - (num2 - 1) * num3) / num2)
        return if num4 < 0 then 0 else num4
    end,
    getCreatorName = function(arg1)
        if arg1 and arg1.creator and arg1.creator.creatorHasVerifiedBadge and arg1.creator.creatorName then
            return `{arg1.creator.creatorName}{VerifiedBadges.emoji.verified}`
        end

        return if arg1 and arg1.creator and arg1.creator.creatorName then arg1.creator.creatorName else ""
    end,
    getOriginalPrice = function(arg1, str1: string, func1: (...any) -> (...any))
        if arg1 and arg1.isOffSale then
            return str1
        elseif arg1 and arg1.priceInRobux then
            return func1(arg1.priceInRobux)
        end
        return ""
    end,
    getQuantitySold = function(arg1, func1: (...any) -> (...any))
        if arg1
            and arg1.collectibleItemDetails
            and arg1.collectibleItemDetails.totalQuantity
            and arg1.collectibleItemDetails.unitsAvailableForConsumption
        then
            return func1(arg1.collectibleItemDetails.totalQuantity - arg1.collectibleItemDetails.unitsAvailableForConsumption) .. "/" .. func1(arg1.collectibleItemDetails.totalQuantity)
        end

        return ""
    end,
    calculatePurchaseStatusForItem = function(arg1, purchaseFromResale)
        local lowestResalePrice, collectibleLowestAvailableResaleProductId, collectibleLowestAvailableResaleItemInstanceId

        if purchaseFromResale == PriceStatus.PurchaseFromResale and arg1.collectibleItemDetails then
            lowestResalePrice = arg1.collectibleItemDetails.lowestResalePrice

            collectibleLowestAvailableResaleProductId = arg1.collectibleItemDetails.collectibleLowestAvailableResaleProductId

            collectibleLowestAvailableResaleItemInstanceId = arg1.collectibleItemDetails.collectibleLowestAvailableResaleItemInstanceId
        else
            lowestResalePrice = nil
            collectibleLowestAvailableResaleProductId = nil
            collectibleLowestAvailableResaleItemInstanceId = nil
        end

        return {
            collectibleItemId = arg1.collectibleItemId,
            collectibleLowestResalePrice = lowestResalePrice,
            collectibleLowestAvailableResaleProductId = collectibleLowestAvailableResaleProductId,
            collectibleLowestAvailableResaleItemInstanceId = collectibleLowestAvailableResaleItemInstanceId
        }
    end,
    shouldShowPriceLabel = function(arg1): boolean
        return arg1 == nil or arg1 == PriceStatus.PurchaseFromResale or arg1 == PriceStatus.PurchaseFromRoblox
    end
}
