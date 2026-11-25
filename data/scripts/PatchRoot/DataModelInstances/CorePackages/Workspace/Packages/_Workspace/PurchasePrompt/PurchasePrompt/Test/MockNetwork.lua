-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T07:40:44Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local Promise = require(scriptParentParent.Promise)

local PurchaseWarning = require(scriptParentParent.Enums.PurchaseWarning)

local FFlagRefreshPriceOnRetryAfterUpsell = require(scriptParentParent.Flags.FFlagRefreshPriceOnRetryAfterUpsell)

local function getABTestGroup()
    return Promise.resolve(false)
end

local function getProductInfo(_, _)
    return Promise.resolve({
        AssetId = 1,
        AssetTypeId = 2,
        ContentRatingTypeId = 0,
        Creator = { CreatorType = "Group", CreatorTargetId = 1, Name = "ROBLOX", Id = 1 },
        Description = "This item isn't real!",
        IconImageAssetId = 1,
        IsForSale = true,
        IsLimited = false,
        IsLimitedUnique = false,
        IsNew = false,
        IsPublicDomain = false,
        MinimumMembershipLevel = 0,
        Name = "Test Item",
        PriceInRobux = 100,
        ProductId = 1
    })
end

local function getPlayerOwns(_, _, _)
    return Promise.resolve(false)
end

local function performPurchase(_, _, _, _)
    return Promise.resolve({ success = true, purchased = true, receipt = "fake-receipt-hash" })
end

local function loadAssetForEquip(_)
    return Promise.resolve(Instance.new("Tool"))
end

local function getAccountInfo()
    return Promise.resolve({ isPremium = false })
end

local function getBalanceInfo()
    return Promise.resolve({ robux = 2147483647 })
end

local function getBundleDetails(_)
    return Promise.resolve({
        id = 1,
        name = "mock-name",
        description = "mock-description",
        items = {{ id = 1, name = "outfit-name", type = "UserOutfit" }},
        creator = { id = 1, name = "ROBLOX", type = "User" },
        product = { id = 1, isForSale = true, priceInRobux = 100 }
    })
end

local function getProductPurchasableDetails(_)
    return Promise.resolve({ purchasable = false, reason = "mock-reason", price = 100 })
end

local function getCatalogItemDetails(_: number, _: string)
    return Promise.resolve({
        bundleType = 1,
        bundledItems = {
            { id = 10001, name = "Mock bundle - Left Arm", owned = true, type = "Asset" },
            { id = 1002, name = "Mock bundle - Right Leg", owned = true, type = "Asset" },
            { id = 1003, name = "Mock bundle - Right Arm", owned = true, type = "Asset" },
            { id = 1004, name = "Mock bundle - Left Leg", owned = true, type = "Asset" },
            { id = 1005, name = "Mock bundle - Dynamic Head", owned = true, type = "Asset" },
            { id = 1006, name = "Default Mood", owned = true, type = "Asset" },
            { id = 1007, name = "Mock bundle - Torso", owned = true, type = "Asset" },
            { id = 1008, name = "Mock item", owned = true, type = "UserOutfit" },
            { id = 1009, name = "Mock bundle Head", owned = true, type = "UserOutfit" }
        },
        collectibleItemId = "random-collectible-item-id-123",
        creatorHasVerifiedBadge = true,
        creatorName = "mockRobloxCreator",
        creatorTargetId = 123,
        creatorType = "User",
        description = "Mock bundle",
        expectedSellerId = 123,
        favoriteCount = 908,
        hasReseller = false,
        id = 123456,
        isPurchasable = true,
        itemRestrictions = {},
        itemStatus = {},
        itemType = "Bundle",
        lowestPrice = 175,
        lowestResalePrice = 0,
        name = "Roblox Collectible Bundle",
        owned = false,
        price = 175,
        productId = 1234567890123456,
        purchaseCount = 0,
        saleLocationType = "ShopAndAllExperiences",
        totalQuantity = 0,
        unitsAvailableForConsumption = 0
    })
end

local function getResellers(_: string, _: number?)
    return Promise.resolve({ data = {}, nextPageCursor = nil })
end

local function getRobuxUpsellProductWithUniverseItemInfo(_, _, _, _, _, _)
    return Promise.resolve(
        {
            roblox_product_id = 50,
            provider_product_id = "robux50",
            roblox_product_name = "providerRobux50",
            robux_amount = 500
        }
    )
end

local function getPurchaseWarning(_)
    return Promise.resolve({ action = PurchaseWarning.NoAction })
end

local function postPurchaseWarningAcknowledge()
    return Promise.resolve()
end

local function checkUserPurchaseSettings()
    return Promise.resolve({ isEligible = false, failureReason = "PurchaseNotEnabled" })
end

local function getUnifiedPurchaseFlowUserEligibility()
    return Promise.resolve({ isUserEligibleForUnifiedPurchaseFlow = true, expiresInSeconds = 120 })
end

local function getSubscriptionProductInfo(_)
    return Promise.resolve({
        Name = "Mock Subscription",
        Description = "A mock developer subscription",
        IconImageAssetId = 12345,
        IsForSale = true,
        DisplayPrice = "$4.99",
        DisplaySubscriptionPeriod = "/month",
        SubscriptionProviderName = "MockGame",
        PriceTier = 499,
        PriceInRobux = 0
    })
end

local function GetLookDetailsV2ProductInfo(_)
    return Promise.resolve({ look = { items = {{ id = 1, itemType = "Asset", priceInRobux = 100 }} } })
end

local module = {}
module.__index = module

function module.new(arg1, arg2): {GetLookDetailsV2ProductInfo: number, checkUserPurchaseSettings: number, getABTestGroup: () -> any, getAccountInfo: () -> any, getBalanceInfo: () -> any, getBundleDetails: (any) -> any, getCatalogItemDetails: number, getPlayerOwns: (any, any, any) -> any, getProductInfo: (any, any) -> any, getProductPurchasableDetails: (any) -> any, getPurchaseWarning: number, getResellers: number, getRobuxUpsellProductWithUniverseItemInfo: number, getSubscriptionProductInfo: number, getUnifiedPurchaseFlowUserEligibility: number, loadAssetForEquip: (any) -> any, performPurchase: (any, any, any, any) -> any, postPurchaseWarningAcknowledge: number} | {checkUserPurchaseSettings: number, getABTestGroup: () -> any, getAccountInfo: () -> any, getBalanceInfo: () -> any, getBundleDetails: () -> any, getCatalogItemDetails: number, getPlayerOwns: () -> any, getProductInfo: () -> any, getProductPurchasableDetails: () -> any, getPurchaseWarning: number, getResellers: number, getRobuxUpsellProductWithUniverseItemInfo: number, getSubscriptionProductInfo: number, getUnifiedPurchaseFlowUserEligibility: number, loadAssetForEquip: () -> any, performPurchase: () -> any, postPurchaseWarningAcknowledge: number}
    local tbl1

    if arg2 or arg1 then
        local function func1()
            if arg1 then
                return Promise.resolve(arg1)
            end
            return Promise.reject(arg2)
        end

        tbl1 = {
            getABTestGroup = func1,
            getProductInfo = func1,
            getPlayerOwns = func1,
            performPurchase = func1,
            loadAssetForEquip = func1,
            getAccountInfo = func1,
            getBalanceInfo = func1,
            getBundleDetails = func1,
            getProductPurchasableDetails = func1,
            getCatalogItemDetails = if FFlagRefreshPriceOnRetryAfterUpsell then func1 else nil,
            getResellers = if FFlagRefreshPriceOnRetryAfterUpsell then func1 else nil,
            getRobuxUpsellProductWithUniverseItemInfo = func1,
            getPurchaseWarning = func1,
            postPurchaseWarningAcknowledge = func1,
            checkUserPurchaseSettings = func1,
            getUnifiedPurchaseFlowUserEligibility = func1,
            getSubscriptionProductInfo = func1
        }
    else
        tbl1 = {
            getABTestGroup = getABTestGroup,
            getProductInfo = getProductInfo,
            getPlayerOwns = getPlayerOwns,
            performPurchase = performPurchase,
            loadAssetForEquip = loadAssetForEquip,
            getAccountInfo = getAccountInfo,
            getBalanceInfo = getBalanceInfo,
            getBundleDetails = getBundleDetails,
            getProductPurchasableDetails = getProductPurchasableDetails,
            getCatalogItemDetails = if FFlagRefreshPriceOnRetryAfterUpsell then getCatalogItemDetails else nil,
            getResellers = if FFlagRefreshPriceOnRetryAfterUpsell then getResellers else nil,
            getRobuxUpsellProductWithUniverseItemInfo = getRobuxUpsellProductWithUniverseItemInfo,
            getPurchaseWarning = getPurchaseWarning,
            postPurchaseWarningAcknowledge = postPurchaseWarningAcknowledge,
            checkUserPurchaseSettings = checkUserPurchaseSettings,
            getUnifiedPurchaseFlowUserEligibility = getUnifiedPurchaseFlowUserEligibility,
            getSubscriptionProductInfo = getSubscriptionProductInfo,
            GetLookDetailsV2ProductInfo = GetLookDetailsV2ProductInfo
        }
    end

    setmetatable(tbl1, {
        __tostring = function(): string
            return "MockService(Network)"
        end
    })

    return tbl1
end

return module
