-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T16:31:38Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceInspectAndBuy = script:FindFirstAncestor("AvatarExperienceInspectAndBuy")
local AvatarExperienceInspectAndBuyParent = AvatarExperienceInspectAndBuy.Parent
local AXCommon = require(AvatarExperienceInspectAndBuyParent.AXCommon)
local PriceStatus = require(AvatarExperienceInspectAndBuy.Enums.PriceStatus)
local ItemRestrictions = AXCommon.Enums.ItemRestrictions
local SalesLocationType = AXCommon.Enums.SalesLocationType
local NoPriceStatus = AXCommon.Enums.NoPriceStatus

local _Types = require(AvatarExperienceInspectAndBuy.Types)

local function getAvailableInExperienceOnly(arg1): boolean -- Luacid: Inlined by compiler; 4 call sites recovered
    return arg1.saleLocationType == SalesLocationType.ExperiencesDevApiOnly
end

local function getHasLimitedAmount(arg1) -- Luacid: Inlined by compiler; 11 call sites recovered
    local itemRestrictions = arg1.itemRestrictions
    local itemRestriction = itemRestrictions and itemRestrictions[ItemRestrictions.Limited]
    local itemRestriction2 = itemRestrictions and itemRestrictions[ItemRestrictions.LimitedUnique]
    local itemRestriction3 = itemRestrictions and itemRestrictions[ItemRestrictions.Collectible]
    return itemRestriction or itemRestriction2 or itemRestriction3
end

local function getUserHasReachedQuantityLimit(arg1): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    if not getHasLimitedAmount(arg1) and arg1.isOwned then
        return true
    end
    if not (arg1.collectibleItemDetails and arg1.collectibleItemDetails.quantityLimitPerUser) then
        return false
    end

    return arg1.collectibleItemDetails.quantityLimitPerUser > 0
        and arg1.collectibleItemDetails.resellableCount >= arg1.collectibleItemDetails.quantityLimitPerUser
end

local function getOriginalStockAvailable(arg1) -- Luacid: Inlined by compiler; 3 call sites recovered
    local hasLimitedAmount = getHasLimitedAmount(arg1)
    return hasLimitedAmount
        and arg1.collectibleItemDetails
        and arg1.collectibleItemDetails.unitsAvailableForConsumption
        and arg1.collectibleItemDetails.unitsAvailableForConsumption > 0
        or not hasLimitedAmount
end

local function getIsOwned(arg1) -- Luacid: unused: defined but never referenced
    local isOwned = arg1.isOwned
    local bool1

    if not getHasLimitedAmount(arg1) and arg1.isOwned then
        bool1 = true
    elseif arg1.collectibleItemDetails
        and arg1.collectibleItemDetails.quantityLimitPerUser
        and arg1.collectibleItemDetails.quantityLimitPerUser > 0
    then
        bool1 = arg1.collectibleItemDetails.resellableCount >= arg1.collectibleItemDetails.quantityLimitPerUser
    else
        bool1 = false
    end

    local hasResellers = arg1.collectibleItemDetails and arg1.collectibleItemDetails.hasResellers
    local hasLimitedAmount = getHasLimitedAmount(arg1)
    local var1 = not not (not (hasLimitedAmount
        and arg1.collectibleItemDetails
        and arg1.collectibleItemDetails.unitsAvailableForConsumption
        and arg1.collectibleItemDetails.unitsAvailableForConsumption > 0)
        and hasLimitedAmount)
        or bool1
        or arg1.isOffSale
    return isOwned and var1 and not hasResellers
end

local function getIsSoldOut(arg1): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    local originalStockAvailable = getOriginalStockAvailable(arg1)
    local hasResellers = arg1.collectibleItemDetails and arg1.collectibleItemDetails.hasResellers
    return not (originalStockAvailable or hasResellers)
end

local function getIsPurchaseFromResale(arg1)
    if not (arg1.collectibleItemDetails and arg1.collectibleItemDetails.hasResellers) then
        return false
    end

    local bool1

    if arg1.priceInRobux
        and arg1.collectibleItemDetails
        and arg1.collectibleItemDetails.lowestResalePrice
        and arg1.catalogPriceStatus ~= "Free"
    then
        bool1 = arg1.collectibleItemDetails.lowestResalePrice < arg1.priceInRobux
    else
        bool1 = arg1.collectibleItemDetails and arg1.collectibleItemDetails.lowestResalePrice ~= nil
    end

    local hasLimitedAmount = getHasLimitedAmount(arg1)
    local bool2 = not not (not (hasLimitedAmount
        and arg1.collectibleItemDetails
        and arg1.collectibleItemDetails.unitsAvailableForConsumption
        and arg1.collectibleItemDetails.unitsAvailableForConsumption > 0)
        and hasLimitedAmount)
        or arg1.isOffSale == true
    return bool1 or bool2
end

local function getIsExperienceOnly(arg1) -- Luacid: unused: defined but never referenced
    if arg1.isOffSale then
        return false
    end
    local bool1 = arg1.saleLocationType == SalesLocationType.ExperiencesDevApiOnly
        or arg1.saleLocationType == SalesLocationType.MyExperiencesOnly
        or arg1.saleLocationType == SalesLocationType.ExperiencesById
    local hasLimitedAmount = getHasLimitedAmount(arg1)
    local var1 = hasLimitedAmount
        and arg1.collectibleItemDetails
        and arg1.collectibleItemDetails.unitsAvailableForConsumption
        and arg1.collectibleItemDetails.unitsAvailableForConsumption > 0
    return bool1 and (var1 or not hasLimitedAmount)
end

local function getIsFree(arg1): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    if arg1.isOffSale then
        return false
    end

    local bool1 = not getAvailableInExperienceOnly(arg1)

    return if arg1.noPriceStatus == NoPriceStatus.Free or bool1 and arg1.priceInRobux == 0 then true else arg1.catalogPriceStatus == "Free"
end

local function getIsPurchasableFromRoblox(arg1): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    return not (arg1.isOffSale or arg1.noPriceStatus == NoPriceStatus.OffSale) and not getAvailableInExperienceOnly(arg1)
end

local function getPriceStatusInShop(arg1)
    if not arg1 then
        return PriceStatus.Unavailable
    end

    local isOwned = arg1.isOwned
    local userHasReachedQuantityLimit = getUserHasReachedQuantityLimit(arg1)
    local hasResellers = arg1.collectibleItemDetails and arg1.collectibleItemDetails.hasResellers
    local var1 = not getOriginalStockAvailable(arg1) or userHasReachedQuantityLimit or arg1.isOffSale
    if isOwned and var1 and not hasResellers then
        return PriceStatus.Owned
    end

    if getIsSoldOut(arg1) then
        return PriceStatus.SoldOut
    end

    if getIsPurchaseFromResale(arg1) then
        return PriceStatus.PurchaseFromResale
    end

    local var2

    if arg1.isOffSale then
        var2 = false
    else
        local bool1 = arg1.saleLocationType == SalesLocationType.ExperiencesDevApiOnly
            or arg1.saleLocationType == SalesLocationType.MyExperiencesOnly
            or arg1.saleLocationType == SalesLocationType.ExperiencesById
        local hasLimitedAmount = getHasLimitedAmount(arg1)
        local var3 = hasLimitedAmount
            and arg1.collectibleItemDetails
            and arg1.collectibleItemDetails.unitsAvailableForConsumption
            and arg1.collectibleItemDetails.unitsAvailableForConsumption > 0
        var2 = bool1 and (var3 or not hasLimitedAmount)
    end

    if var2 then
        return PriceStatus.InExperienceOnly
    end

    if getIsFree(arg1) then
        return PriceStatus.Free
    end

    if getIsPurchasableFromRoblox(arg1) then
        return PriceStatus.PurchaseFromRoblox
    end

    return PriceStatus.Unavailable
end

return getPriceStatusInShop
