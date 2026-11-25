-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T04:40:52Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfilePlatform = script:FindFirstAncestor("ProfilePlatform")
local ProfilePlatformParent = ProfilePlatform.Parent
local Enums = require(ProfilePlatform.Common.Enums)
local FFlagSocialEnableProfileInspectAndBuy = require(ProfilePlatformParent.SharedFlags).FFlagSocialEnableProfileInspectAndBuy

local FFlagProfilePlatformEnableBundlesInAssetsCarousel = require(ProfilePlatformParent.SharedFlags).FFlagProfilePlatformEnableBundlesInAssetsCarousel
local FFlagProfileStoreShowLimitedResalePrice = require(ProfilePlatform.Flags.FFlagProfileStoreShowLimitedResalePrice)

local num1 = 0

local function func1(): string -- Luacid: Inlined by compiler; 1 call site recovered
    num1 += 1
    return tostring(num1)
end

local module = {}

function module.mock(arg1, itemType: string?)
    return {
        id = tostring(arg1) or func1(),
        assetType = "0",
        itemType = itemType or Enums.ItemTypes.Asset,
        name = ""
    }
end

function module.fromAsset(arg1)
    local tbl1 = {
        id = tostring(arg1.id)
    }
    local assetType = arg1.assetType

    if not assetType then
        if FFlagProfilePlatformEnableBundlesInAssetsCarousel then
            assetType = arg1.bundleType
        else
            assetType = nil
        end
    end

    tbl1.assetType = tostring(assetType)
    tbl1.itemType = arg1.itemType
    tbl1.name = arg1.name
    tbl1.price = arg1.price
    tbl1.lowestResalePrice = arg1.lowestResalePrice
    tbl1.isOffSale = arg1.isOffSale
    tbl1.favoriteCount = arg1.favoriteCount
    if FFlagSocialEnableProfileInspectAndBuy then
        tbl1.creatorName = arg1.creatorName
        tbl1.creatorHasVerifiedBadge = arg1.creatorHasVerifiedBadge
        tbl1.collectibleItemId = arg1.collectibleItemId
        tbl1.owned = arg1.owned
        tbl1.bundledItems = arg1.bundledItems
        tbl1.taxonomyName = if arg1.taxonomy and #arg1.taxonomy > 0 then arg1.taxonomy[1].taxonomyName else nil
    end
    if FFlagProfileStoreShowLimitedResalePrice then
        tbl1.hasResellers = arg1.hasResellers
        tbl1.unitsAvailableForConsumption = arg1.unitsAvailableForConsumption
        tbl1.itemRestrictions = arg1.itemRestrictions
    end

    return tbl1
end

return module
