-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T13:51:14Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceCommon = script:FindFirstAncestor("AvatarExperienceCommon")

local AvatarExperienceCommonParent = AvatarExperienceCommon.Parent

local ItemPurchaseActionTypeEnum = require(AvatarExperienceCommon.Enums.ItemPurchaseActionTypeEnum)
local SalesLocationType = require(AvatarExperienceCommon.Enums.SalesLocationType)
local ItemRestrictions = require(AvatarExperienceCommon.Enums.ItemRestrictions)

local FFlagAXDurablesForMIS = require(AvatarExperienceCommonParent.AvatarExperienceFlags).FFlagAXDurablesForMIS

local function getExperienceCount(tbl1): number -- Luacid: Inlined by compiler; 2 call sites recovered
    return #(not tbl1 and {} or tbl1.experiences or {})
end

local function getAvailableInExperienceOnly(tbl1): boolean -- Luacid: Inlined by compiler; 4 call sites recovered
    return tbl1.saleLocationType == SalesLocationType.ExperiencesDevApiOnly
end

local function getHasLimitedAmount(tbl1) -- Luacid: Inlined by compiler; 12 call sites recovered
    local itemRestrictions = tbl1.itemRestrictions
    local itemRestriction = itemRestrictions and itemRestrictions[ItemRestrictions.Limited]
    local itemRestriction2 = itemRestrictions and itemRestrictions[ItemRestrictions.LimitedUnique]
    local itemRestriction3 = itemRestrictions and itemRestrictions[ItemRestrictions.Collectible]
    return itemRestriction or itemRestriction2 or itemRestriction3
end

local function getUserHasReachedQuantityLimit(tbl1, tbl2, quantityLimitPerUser: number): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    if not getHasLimitedAmount(tbl1) and tbl1.isOwned then
        return true
    end
    if not (tbl2 and tbl2.quantityLimitPerUser) then
        return false
    end
    if tbl2 and tbl2.quantityLimitPerUser > 0 then
        return tbl2.quantityLimitPerUser <= quantityLimitPerUser
    end

    return false
end

local function getOriginalStockAvailable(tbl1) -- Luacid: Inlined by compiler; 6 call sites recovered
    local hasLimitedAmount = getHasLimitedAmount(tbl1)
    return hasLimitedAmount and tbl1.numberRobloxHasAvailable and tbl1.numberRobloxHasAvailable > 0 or not hasLimitedAmount
end

local function getButtonTypeIsPurchaseFromResale(tbl1, bool1: boolean): boolean -- Luacid: unused: defined but never referenced
    if not (bool1 and tbl1.hasResellers) then
        return false
    end

    local bool2 = if tbl1.priceInRobux and tbl1.lowestResalePrice then tbl1.lowestResalePrice < tbl1.priceInRobux else tbl1.lowestResalePrice ~= nil
    local bool3 = tbl1.saleLocationType == SalesLocationType.ExperiencesDevApiOnly
    local hasLimitedAmount = getHasLimitedAmount(tbl1)
    local bool4 = not not (not (hasLimitedAmount and tbl1.numberRobloxHasAvailable and tbl1.numberRobloxHasAvailable > 0) and hasLimitedAmount)
        or tbl1.isOffSale == true
        or bool3

    return bool2 or bool4
end

local function getButtonTypeIsFree(tbl1): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    return not tbl1.isOffSale and not getAvailableInExperienceOnly(tbl1) and tbl1.priceInRobux == 0
end

local function getButtonTypeIsExperienceLink(tbl1, tbl2) -- Luacid: Inlined by compiler; 1 call site recovered
    if tbl1.isOffSale then
        return false
    end
    local bool1 = tbl1.saleLocationType == SalesLocationType.ExperiencesDevApiOnly
    local originalStockAvailable = getOriginalStockAvailable(tbl1)
    local bool2 = getExperienceCount(tbl2) > 0
    return bool1 and bool2 and originalStockAvailable
end

local function getButtonTypeIsSoldOut(tbl1, bool1: boolean): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    local originalStockAvailable = getOriginalStockAvailable(tbl1)
    local hasResellers = bool1 and tbl1.hasResellers
    return not (originalStockAvailable or hasResellers)
end

local function getButtonTypeIsCustomizeLink(tbl1, tbl2, quantityLimitPerUser: number, bool1: boolean) -- Luacid: unused: defined but never referenced
    local var1 = if FFlagAXDurablesForMIS then tbl1.isOwned and not tbl1.expirationTime else tbl1.isOwned
    local bool2 = if not getHasLimitedAmount(tbl1) and tbl1.isOwned then true elseif tbl2 and tbl2.quantityLimitPerUser and tbl2 and tbl2.quantityLimitPerUser > 0 then tbl2.quantityLimitPerUser <= quantityLimitPerUser else false
    local hasResellers = bool1 and tbl1.hasResellers
    local hasLimitedAmount = getHasLimitedAmount(tbl1)
    local var2 = not not (not (hasLimitedAmount and tbl1.numberRobloxHasAvailable and tbl1.numberRobloxHasAvailable > 0) and hasLimitedAmount)
        or bool2
        or tbl1.isOffSale

    return var1 and var2 and not hasResellers
end

local function getButtonTypeIsPurchasableFromRoblox(tbl1): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    return not tbl1.isOffSale and not getAvailableInExperienceOnly(tbl1)
end

local function getButtonTypeIsQuantityLimitExceeded(_, tbl1, quantityLimitPerUser: number): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    if tbl1 == nil or tbl1.quantityLimitPerUser == nil then
        return false
    end
    return tbl1.quantityLimitPerUser > 0 and tbl1.quantityLimitPerUser <= quantityLimitPerUser
end

local function getItemPurchaseActionType(tbl1, tbl2, quantityLimitPerUser: number, bool1: boolean)
    if not tbl1 then
        return ItemPurchaseActionTypeEnum.Disabled
    end

    if getButtonTypeIsQuantityLimitExceeded(nil, tbl2, quantityLimitPerUser) then
        return ItemPurchaseActionTypeEnum.QuantityLimitExceeded
    end

    local var1 = if FFlagAXDurablesForMIS then tbl1.isOwned and not tbl1.expirationTime else tbl1.isOwned
    local userHasReachedQuantityLimit = getUserHasReachedQuantityLimit(tbl1, tbl2, quantityLimitPerUser)
    local hasResellers = bool1 and tbl1.hasResellers
    local var2 = not getOriginalStockAvailable(tbl1) or userHasReachedQuantityLimit or tbl1.isOffSale

    if var1 and var2 and not hasResellers then
        return ItemPurchaseActionTypeEnum.CustomizeLink
    end

    if getButtonTypeIsSoldOut(tbl1, bool1) then
        return ItemPurchaseActionTypeEnum.SoldOut
    end

    local bool2

    if bool1 and tbl1.hasResellers then
        local bool3 = if tbl1.priceInRobux and tbl1.lowestResalePrice then tbl1.lowestResalePrice < tbl1.priceInRobux else tbl1.lowestResalePrice ~= nil
        local bool4 = tbl1.saleLocationType == SalesLocationType.ExperiencesDevApiOnly
        local bool5 = not getOriginalStockAvailable(tbl1) or tbl1.isOffSale == true or bool4
        bool2 = bool3 or bool5
    else
        bool2 = false
    end
    if bool2 then
        return ItemPurchaseActionTypeEnum.PurchaseFromResale
    end

    local buttonTypeIsExperienceLink = getButtonTypeIsExperienceLink(tbl1, tbl2)

    if buttonTypeIsExperienceLink then
        return ItemPurchaseActionTypeEnum.ExperienceLink
    end

    if getButtonTypeIsFree(tbl1) then
        return ItemPurchaseActionTypeEnum.Free
    end

    if getButtonTypeIsPurchasableFromRoblox(tbl1) then
        return ItemPurchaseActionTypeEnum.PurchaseFromRoblox
    end

    return ItemPurchaseActionTypeEnum.Disabled
end

return getItemPurchaseActionType
