-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T02:11:21Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceCatalog = script:FindFirstAncestor("AvatarExperienceCatalog")

local AvatarExperienceCatalogParent = AvatarExperienceCatalog.Parent
local Signals = require(AvatarExperienceCatalogParent.Signals)
local tutils = require(AvatarExperienceCatalogParent.tutils)
local AvatarExperienceCommon = require(AvatarExperienceCatalogParent.AvatarExperienceCommon)
local PurchaseItemsErrorStatusMap = require(AvatarExperienceCatalog.Enums.PurchaseItemsErrorStatusMap)
local Cryo = require(AvatarExperienceCatalogParent.Cryo)
local SharedFlags = require(AvatarExperienceCatalogParent.SharedFlags)
local ItemTileEnums = require(AvatarExperienceCatalogParent.UIBlox).Tile.ItemTileEnums

local getTryOnItemReducerKey = AvatarExperienceCommon.Utils.getTryOnItemReducerKey
local Constants = AvatarExperienceCommon.Constants

local AvatarExperienceFlags = require(AvatarExperienceCatalogParent.AvatarExperienceFlags)
local FFlagAXDurablesForMIS = AvatarExperienceFlags.FFlagAXDurablesForMIS
local FFlagAXMISWithBlackbird = SharedFlags.FFlagAXMISWithBlackbird
local FFlagAXMISSmallUIChanges = AvatarExperienceFlags.FFlagAXMISSmallUIChanges
local FFlagAXMISWithOffers = AvatarExperienceFlags.FFlagAXMISWithOffers
local FFlagAXGifting = AvatarExperienceFlags.FFlagAXGifting

local createSignal = Signals.createSignal
local createComputed = Signals.createComputed

local getItemPurchaseActionType = AvatarExperienceCommon.Utils.getItemPurchaseActionType
local ItemPurchaseActionTypeEnum = AvatarExperienceCommon.Enums.ItemPurchaseActionTypeEnum

local function getItemRestrictionFromItemData(itemData) -- Luacid: Inlined by compiler; 1 call site recovered
    local tileRestrictionsMap = if itemData then itemData.tileRestrictionsMap else nil

    if tileRestrictionsMap then
        if tileRestrictionsMap[ItemTileEnums.Restriction.Limited] then
            return "Limited"
        end

        if tileRestrictionsMap[ItemTileEnums.Restriction.LimitedUnique]
            or tileRestrictionsMap[ItemTileEnums.Restriction.Collectible]
        then
            return "Collectible"
        end
    end
    return nil
end

local function getItemCartData(tbl1, bool1: boolean?)
    if tbl1.itemId == Constants.AVATAR_BLOCKY_DEFAULT_BUNDLE_ID then
        return {
            itemId = tbl1.itemId,
            collectibleItemId = if FFlagAXMISWithOffers then "n/a" else nil,
            itemType = tbl1.itemType,
            itemSubType = "1",
            ordering = tbl1.ordering,
            creatorName = if FFlagAXMISSmallUIChanges then nil else "Roblox",
            creatorVerified = not FFlagAXMISSmallUIChanges or nil,
            collectibleProductId = tbl1.itemId,
            status = PurchaseItemsErrorStatusMap.ALREADY_OWNED,
            priceInRobux = 0,
            name = "Default Body",
            isOwned = true
        }
    end

    local itemData = tbl1.itemData
    local collectibleItemId = tbl1.collectibleItemId
    local collectibleItemInfo = tbl1.collectibleItemInfo
    local resellableInstances = tbl1.resellableInstances

    local var1 = if resellableInstances then tutils.fieldCount(resellableInstances) else 0
    local itemPurchaseActionType = getItemPurchaseActionType(itemData, collectibleItemInfo, var1, not (bool1 and collectibleItemId))

    local bool2 = itemPurchaseActionType == ItemPurchaseActionTypeEnum.PurchaseFromResale
    local var2 = if bool2 then itemData.lowestResalePrice else itemData.priceInRobux
    local collectibleProductId = if collectibleItemInfo then if bool2 then collectibleItemInfo.lowestAvailableResaleProductId else collectibleItemInfo.collectibleProductId else nil
    local itemSubType = if tbl1.itemType == Enum.AvatarItemType.Asset.Name then itemData.assetType else itemData.bundleType
    local creator = itemData.creator or {}
    local name = creator.name
    local hasVerifiedBadge = creator.hasVerifiedBadge
    local name2 = itemData.name

    local var5 = nil
    if itemPurchaseActionType == ItemPurchaseActionTypeEnum.SoldOut then
        var5 = PurchaseItemsErrorStatusMap.SOLD_OUT
    elseif itemPurchaseActionType == ItemPurchaseActionTypeEnum.CustomizeLink then
        var5 = PurchaseItemsErrorStatusMap.ALREADY_OWNED
    elseif itemPurchaseActionType == ItemPurchaseActionTypeEnum.ExperienceLink then
        var5 = PurchaseItemsErrorStatusMap.EXPERIENCE_LINK
    elseif itemPurchaseActionType == ItemPurchaseActionTypeEnum.Disabled then
        var5 = PurchaseItemsErrorStatusMap.NOT_FOR_SALE
    elseif itemPurchaseActionType == ItemPurchaseActionTypeEnum.QuantityLimitExceeded then
        var5 = PurchaseItemsErrorStatusMap.QUANTITY_LIMIT_EXCEEDED
    end

    local days = nil
    if FFlagAXDurablesForMIS and itemData.timedOptions then
        if tbl1.selectedTimedOptionIndex ~= nil then
            local timedOption = itemData.timedOptions[tbl1.selectedTimedOptionIndex]
            if timedOption then
                days = timedOption.days
                var2 = timedOption.price
            end
        else
            for _, timedOption in itemData.timedOptions do
                if timedOption.selected then
                    days = timedOption.days
                    var2 = timedOption.price
                    break
                end
            end
        end
    end

    local tbl2 = {
        itemId = tbl1.itemId,
        itemType = tbl1.itemType,
        expirationTime = itemData.expirationTime,
        isOwned = itemData.isOwned,
        discountInformation = itemData.discountInformation,
        itemSubType = itemSubType,
        itemRestriction = getItemRestrictionFromItemData(itemData),
        ordering = tbl1.ordering,
        creatorName = 0,
        creatorVerified = 0,
        collectibleProductId = 0,
        collectibleItemId = 0,
        status = 0,
        priceInRobux = 0,
        name = 0,
        timedOptions = 0,
        selectedTimedOptionDays = 0,
        selectedTimedOptionIndexInReducer = 0
    }

    if FFlagAXMISSmallUIChanges then
        name = nil
    end

    tbl2.creatorName = name
    if FFlagAXMISSmallUIChanges then
        hasVerifiedBadge = nil
    end

    tbl2.creatorVerified = hasVerifiedBadge
    tbl2.collectibleProductId = collectibleProductId
    if not (FFlagAXMISWithOffers or FFlagAXGifting) then
        collectibleItemId = nil
    end

    tbl2.collectibleItemId = collectibleItemId
    tbl2.status = var5
    tbl2.priceInRobux = var2
    tbl2.name = name2
    tbl2.timedOptions = if FFlagAXDurablesForMIS then itemData.timedOptions else nil
    if not FFlagAXDurablesForMIS then
        days = nil
    end

    tbl2.selectedTimedOptionDays = days
    tbl2.selectedTimedOptionIndexInReducer = if FFlagAXDurablesForMIS then tbl1.selectedTimedOptionIndex else nil
    return tbl2
end

local function areCartItemsDifferent(tbl1, tbl2) -- Luacid: Inlined by compiler; 1 call site recovered
    if tutils.fieldCount(tbl1) ~= tutils.fieldCount(tbl2) then
        return true
    end

    for value, _ in tbl2 do
        if tbl1[value] == nil then
            return true
        end
    end
    return false
end

local function createAXShoppingCartStore()
    local var1, var2 = createSignal({})
    local var3, var4 = createSignal(0)
    local signal = nil
    local var5 = nil
    if FFlagAXMISWithBlackbird then
        signal, var5 = createSignal({})
    end

    local getErroredItemCount = createComputed(function(arg1)
        return var3(arg1)
    end)

    local computed2 = if FFlagAXMISWithBlackbird then createComputed(function(arg1)
        return signal(arg1)
    end) else nil

    local getItems = createComputed(function(arg1)
        local result = {}

        for _, value in (var1(arg1)) do
            table.insert(result, value)
        end

        table.sort(result, function(arg2, arg3): boolean
            return not (arg2.status == PurchaseItemsErrorStatusMap.ALREADY_OWNED and arg3.status ~= PurchaseItemsErrorStatusMap.ALREADY_OWNED)
                and (arg3.status == PurchaseItemsErrorStatusMap.ALREADY_OWNED and arg2.status ~= PurchaseItemsErrorStatusMap.ALREADY_OWNED
                    or arg2.ordering > arg3.ordering)
        end)

        return result
    end, tutils.deepEqual)

    local getCanPurchase = createComputed(function(arg1)
        local var6 = var1(arg1)
        local num1 = 0
        for _, value in var6 do
            if value.status == PurchaseItemsErrorStatusMap.ALREADY_OWNED then
                num1 += 1
            end

            if value.status ~= nil
                and value.status ~= PurchaseItemsErrorStatusMap.ALREADY_OWNED
                and value.status ~= PurchaseItemsErrorStatusMap.PRICE_MISMATCH
            then
                return false
            end
        end

        return num1 ~= tutils.fieldCount(var6)
    end)

    local getPurchasableItemsTotalPriceInRobux = createComputed(function(arg1)
        local num1 = 0

        for _, value in (var1(arg1)) do
            if value.status ~= PurchaseItemsErrorStatusMap.ALREADY_OWNED then
                num1 += value.priceInRobux
            end
        end
        return num1
    end)

    local getPurchasableItemsTotalOriginalPriceInRobux = createComputed(function(arg1)
        local num1 = 0

        for _, value in (var1(arg1)) do
            if value.status == PurchaseItemsErrorStatusMap.ALREADY_OWNED then
                continue
            end

            if value.discountInformation then
                if value.selectedTimedOptionDays ~= nil and value.timedOptions then
                    local var6 = nil

                    for _, timedOption in value.timedOptions do
                        if timedOption.days == value.selectedTimedOptionDays then
                            var6 = timedOption
                            break
                        end
                    end

                    if var6 and var6.discountInformation then
                        num1 += var6.discountInformation.originalPrice
                    elseif var6 and not var6.discountInformation and var6.days ~= 0 then
                        num1 += var6.price
                    else
                        num1 += value.discountInformation.originalPrice
                    end
                else
                    num1 += value.discountInformation.originalPrice
                end
            else
                num1 += value.priceInRobux
            end
        end

        return num1
    end)

    local function syncFromTryOns(tbl1, bool1: boolean?)
        local var6 = var1(false)
        local tbl2 = ({})

        local discounts = nil

        for _, value in tbl1 do
            local tryOnItemReducerKey = getTryOnItemReducerKey(value.itemId, value.itemType)
            local var7 = var6[tryOnItemReducerKey]
            local itemCartData = getItemCartData(value, bool1)
            if var7 then
                itemCartData = Cryo.Dictionary.join(var7, itemCartData)
            end

            tbl2[tryOnItemReducerKey] = itemCartData

            if FFlagAXMISWithBlackbird and value.itemData and value.itemData.discountInformation and not discounts then
                discounts = value.itemData.discountInformation.discounts
            end
        end

        if FFlagAXMISWithBlackbird and discounts then
            var5(discounts)
        end

        if not tutils.deepEqual(var6, tbl2) then
            var2(tbl2)
        end

        if areCartItemsDifferent(var6, tbl2) then
            var4(0)
        end
    end

    local function updateCartFromPurchaseResponse(arg1)
        local var6 = var1(false)
        local tbl1 = ({})

        local boughtItems = {}
        local equippableItems = {}

        local needDataRefeshItems = {}
        local num1 = 0

        local lineItems = arg1.lineItems
        for value, value2 in var6 do
            local lineItem = lineItems[value]
            local bool1 = value2.status == PurchaseItemsErrorStatusMap.ALREADY_OWNED

            if lineItem and lineItem.status ~= "SUCCEEDED" and not bool1 then
                local status = PurchaseItemsErrorStatusMap[lineItem.errorReason] or PurchaseItemsErrorStatusMap.UNKNOWN
                local tbl5

                if status == PurchaseItemsErrorStatusMap.PRICE_MISMATCH then
                    tbl5 = {
                        oldPriceInRobux = value2.priceInRobux
                    }
                    table.insert(needDataRefeshItems, value2)
                else
                    tbl5 = nil
                end
                tbl1[value] = Cryo.Dictionary.join(value2, { status = status, priceMismatchMetadata = tbl5 })
                num1 += 1
            else
                table.insert(equippableItems, value2)
                if not bool1 then
                    table.insert(boughtItems, value2)
                end
            end
        end
        var2(tbl1)
        var4(num1)

        return {
            boughtItems = boughtItems,
            equippableItems = equippableItems,
            needDataRefeshItems = needDataRefeshItems
        }
    end

    local function updateItemPrice(str1: string, str2: string, priceInRobux: number, selectedTimedOptionDays: number?)
        if not FFlagAXDurablesForMIS then
            return
        end

        local var6 = var1(false)
        local tryOnItemReducerKey = getTryOnItemReducerKey(str1, str2)
        local var7 = var6[tryOnItemReducerKey]
        if not var7 or var7.priceInRobux == priceInRobux and var7.selectedTimedOptionDays == selectedTimedOptionDays then
            return
        end

        local var8 = var2
        local join = Cryo.Dictionary.join
        local tbl1 = {}
        local join2 = Cryo.Dictionary.join
        local tbl2 = { priceInRobux = priceInRobux, selectedTimedOptionDays = 0 }
        if selectedTimedOptionDays == nil then
            selectedTimedOptionDays = Cryo.None
        end

        tbl2.selectedTimedOptionDays = selectedTimedOptionDays
        tbl1[tryOnItemReducerKey] = join2(var7, tbl2)
        var8(join(var6, tbl1))
    end

    local tbl1 = {
        getCanPurchase = getCanPurchase,
        getErroredItemCount = getErroredItemCount,
        getItems = getItems,
        getDiscounts = 0,
        getPurchasableItemsTotalPriceInRobux = 0,
        getPurchasableItemsTotalOriginalPriceInRobux = 0,
        syncFromTryOns = 0,
        updateCartFromPurchaseResponse = 0,
        updateItemPrice = 0
    }

    if not FFlagAXMISWithBlackbird then
        computed2 = nil
    end

    tbl1.getDiscounts = computed2
    tbl1.getPurchasableItemsTotalPriceInRobux = getPurchasableItemsTotalPriceInRobux
    tbl1.getPurchasableItemsTotalOriginalPriceInRobux = getPurchasableItemsTotalOriginalPriceInRobux
    tbl1.syncFromTryOns = syncFromTryOns
    tbl1.updateCartFromPurchaseResponse = updateCartFromPurchaseResponse
    if not FFlagAXDurablesForMIS then
        updateItemPrice = nil
    end

    tbl1.updateItemPrice = updateItemPrice
    return tbl1
end

return createAXShoppingCartStore
