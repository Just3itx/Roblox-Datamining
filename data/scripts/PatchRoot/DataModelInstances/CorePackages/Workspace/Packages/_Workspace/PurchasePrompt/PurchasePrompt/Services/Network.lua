-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T07:31:29Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PurchasePrompt = script:FindFirstAncestor("PurchasePrompt")
local PurchasePromptParent = PurchasePrompt.Parent
local HttpService = game:GetService("HttpService")
local ContentProvider = game:GetService("ContentProvider")
local MarketplaceService = game:GetService("MarketplaceService")
local InsertService = game:GetService("InsertService")
local Players = game:GetService("Players")
local CreatorStoreService = game:GetService("CreatorStoreService")

local UrlBuilder = require(PurchasePromptParent.PurchasePromptDeps).UrlBuilder.UrlBuilder

local Promise = require(PurchasePrompt.Promise)
local _types = require(PurchasePrompt.types)
local debugLog = require(PurchasePrompt.Utils.debugLog)
local serializeTable = require(PurchasePrompt.Utils.serializeTable)
local isGenericChallengeResponse = require(PurchasePrompt.Utils.isGenericChallengeResponse)
local isGetPassOwnershipApiEnabled = require(PurchasePrompt.Utils.isGetPassOwnershipApiEnabled)

local engineFeature = game:GetEngineFeature("EnablePlayerOwnsBundleApi")
local engineFeature2 = game:GetEngineFeature("EnableDevSubscriptionPurchaseWithRobux")
local GetFFlagEnablePromptPurchaseRequestedV2 = require(PurchasePrompt.Flags.GetFFlagEnablePromptPurchaseRequestedV2)
local GetFFlagEnablePromptPurchaseRequestedV2Take2 = require(PurchasePrompt.Flags.GetFFlagEnablePromptPurchaseRequestedV2Take2)
local GetFFlagEnableCreatorStorePurchasingCutover = require(PurchasePrompt.Flags.GetFFlagEnableCreatorStorePurchasingCutover)
local FFlagEnableUnifiedPurchaseFlowForDevSubs = require(PurchasePromptParent.SharedFlags).FFlagEnableUnifiedPurchaseFlowForDevSubs

local FFlagUnifiedPurchaseSupportRefetchingLooksAfterUpsell = require(PurchasePrompt.Flags.FFlagUnifiedPurchaseSupportRefetchingLooksAfterUpsell)
local FFlagEnableRequestLocationTypeForSduiPurchase = require(PurchasePrompt.Flags.FFlagEnableRequestLocationTypeForSduiPurchase)

local SharedFlags = require(PurchasePromptParent.SharedFlags)
local FFlagUseGetGamePassOwnershipApi = SharedFlags.FFlagUseGetGamePassOwnershipApi

local FFlagAXSupportRentalPurchaseInUnifiedProductPurchaseFlow = SharedFlags.FFlagAXSupportRentalPurchaseInUnifiedProductPurchaseFlow
local FFlagEnablePurchasePayloadInExperienceShop = SharedFlags.FFlagEnablePurchasePayloadInExperienceShop
local FFlagEnableMarketplacePurchaseDeepLinkAttribution = SharedFlags.FFlagEnableMarketplacePurchaseDeepLinkAttribution
local FFlagRefreshPriceOnRetryAfterUpsell = require(PurchasePrompt.Flags.FFlagRefreshPriceOnRetryAfterUpsell)
local FFlagPurchasePromptFetchCartPricingForLooks = SharedFlags.FFlagPurchasePromptFetchCartPricingForLooks
local FFlagLuaAppsEnablePromptVIPServerPurchase = SharedFlags.FFlagLuaAppsEnablePromptVIPServerPurchase

local var1 = string.gsub(ContentProvider.BaseUrl:lower(), "/m.", "/www.")
local var2 = string.gsub(var1, "http:", "https:")

string.gsub(var2, "https://www", "https://api")
local var3 = string.gsub(var2, "https://www", "https://apis")
local var4 = string.gsub(var2, "https://www", "https://games")
local var5 = string.gsub(var2, "https://www", "https://abtesting")
local var6 = string.gsub(var2, "https://www.", "https://catalog.")
local var7 = string.gsub(var2, "https://www.", "https://economy.")
local var8 = string.gsub(var2, "https://www", "https://users")

local function request(options, callback, callback2)
    debugLog(function()
        return "Request " .. options.Url .. "\n" .. serializeTable(options)
    end)
    return HttpService:RequestInternal(options):Start(function(arg1, arg2)
        debugLog(function()
            return "Response " .. options.Url .. "\n" .. serializeTable(arg2)
        end)
        if not arg1 then
            callback2(tostring(arg2.StatusMessage))

            return
        end

        local jsonDecode = HttpService.JSONDecode
        local httpService = HttpService
        local body = arg2.Body
        local result
        arg1, result = pcall(jsonDecode, httpService, body)

        if arg1 then
            callback(result)
            return
        end
        callback2("Could not parse JSON.")
    end)
end

local function getABTestGroup(subjectTargetId, experimentName)
    local input = {{
        ExperimentName = experimentName,
        SubjectType = 1,
        SubjectTargetId = subjectTargetId
    }}

    return Promise.new(function(callback, arg1)
        return request({
            Url = var5 .. "v1/get-enrollments",
            Method = "POST",
            Body = HttpService:JSONEncode(input),
            Headers = { ["Content-Type"] = "application/json", Accept = "application/json" }
        }, callback, arg1)
    end)
end

local function getProductInfo(assetId: number, infoType: Enum.InfoType?)
    return MarketplaceService:GetProductInfoAsync(assetId, infoType)
end

local function getSubscriptionProductInfo(subscriptionId: string)
    return MarketplaceService:GetSubscriptionProductInfoAsync(subscriptionId)
end

local function getPlayerOwns(arg1, num1: number, infoType)
    if infoType == Enum.InfoType.Asset then
        return MarketplaceService:PlayerOwnsAssetAsync(arg1, num1)
    elseif engineFeature and infoType == Enum.InfoType.Bundle then
        return MarketplaceService:PlayerOwnsBundleAsync(arg1, num1)
    elseif infoType == Enum.InfoType.GamePass then
        if FFlagUseGetGamePassOwnershipApi then
            local success, result = pcall(function()
                return MarketplaceService:GetPassOwnershipAsync(arg1, num1)
            end)
            if success then
                return typeof(result) == "table" and result.Owned == true
            end

            if isGetPassOwnershipApiEnabled() then
                error(result, 0)
            end
        end
        return MarketplaceService:UserOwnsGamePassAsync(arg1.UserId, num1)
    elseif infoType == Enum.InfoType.Subscription then
        return MarketplaceService:IsPlayerSubscribed(arg1, num1)
    else
        return false
    end
end

local function performPurchase(infoType: Enum.InfoType, productId: number, expectedPrice: number, requestId: string, isRobloxPurchase: boolean, collectibleItemId: string?, collectibleProductId: string?, idempotencyKey: string?, arg1, arg2, arg3, purchaseOptions)
    local success, result = pcall(function()
        if not (GetFFlagEnablePromptPurchaseRequestedV2() or GetFFlagEnablePromptPurchaseRequestedV2Take2()) then
            return MarketplaceService:PerformPurchase(
                infoType,
                productId,
                expectedPrice,
                requestId,
                isRobloxPurchase,
                collectibleItemId,
                collectibleProductId,
                idempotencyKey
            )
        end

        if FFlagAXSupportRentalPurchaseInUnifiedProductPurchaseFlow then
            return MarketplaceService:PerformPurchase(
                infoType,
                productId,
                expectedPrice,
                requestId,
                isRobloxPurchase,
                collectibleItemId,
                collectibleProductId,
                idempotencyKey,
                arg1,
                arg2,
                if FFlagEnablePurchasePayloadInExperienceShop then arg3 else nil,
                purchaseOptions
            )
        elseif FFlagEnablePurchasePayloadInExperienceShop then
            return MarketplaceService:PerformPurchase(
                infoType,
                productId,
                expectedPrice,
                requestId,
                isRobloxPurchase,
                collectibleItemId,
                collectibleProductId,
                idempotencyKey,
                arg1,
                nil,
                arg3,
                if FFlagEnableMarketplacePurchaseDeepLinkAttribution then purchaseOptions else nil
            )
        end

        return MarketplaceService:PerformPurchase(
            infoType,
            productId,
            expectedPrice,
            requestId,
            isRobloxPurchase,
            collectibleItemId,
            collectibleProductId,
            idempotencyKey,
            arg1,
            nil,
            nil,
            if FFlagEnableMarketplacePurchaseDeepLinkAttribution then purchaseOptions else nil
        )
    end)

    if success then
        return result
    end

    if isGenericChallengeResponse(result) then
        return result
    end

    error(tostring(result))
end

local function performPurchaseV2(infoType: Enum.InfoType, productId: number, expectedPrice: number, requestId: string, isRobloxPurchase: boolean, collectibleItemId, collectibleProductId, idempotencyKey, purchaseAuthToken, collectibleItemInstanceId, purchaseOptions)
    local success, result = pcall(function()
        return MarketplaceService:PerformPurchaseV2(infoType, productId, expectedPrice, requestId, isRobloxPurchase, {
            CollectibleItemId = collectibleItemId,
            CollectibleProductId = collectibleProductId,
            IdempotencyKey = idempotencyKey,
            PurchaseAuthToken = purchaseAuthToken,
            CollectibleItemInstanceId = collectibleItemInstanceId,
            PurchaseOptions = purchaseOptions
        })
    end)

    if success then
        return result
    end

    if isGenericChallengeResponse(result) then
        return result
    end

    error(tostring(result))
end

local function performCreatorStorePurchase(arg1, arg2)
    local success, result = pcall(function()
        return CreatorStoreService:performCreatorStorePurchase(arg1, arg2)
    end)

    if success then
        return result
    end

    if isGenericChallengeResponse(result) then
        return result
    end

    error(tostring(result))
end

local function getAssetInfo(num1: number)
    return CreatorStoreService:getAssetInfoAsync(num1)
end

local function getCreatorStoreProductInfo(num1: number, str1: string)
    return CreatorStoreService:getCreatorStoreProductInfoAsync(num1, str1)
end

local function loadAssetForEquip(assetId: number): Instance
    return InsertService:LoadAsset(assetId)
end

local function getAccountInfo()
    return Promise.new(function(callback, arg1)
        request({ Url = var8 .. "v1/users/authenticated/app-launch-info", Method = "GET" }, callback, arg1)
    end)
end

local function getBalanceInfo()
    return Promise.new(function(callback, arg1)
        request({ Url = var7 .. "v1/user/currency", Method = "GET" }, callback, arg1)
    end)
end

local function getBundleDetails(arg1)
    local options = {
        Url = var6 .. "v1/bundles/" .. tostring(arg1) .. "/details",
        Method = "GET"
    }

    return Promise.new(function(callback, arg2)
        spawn(function()
            request(options, callback, arg2)
        end)
    end)
end

local function getProductPurchasableDetails(arg1)
    local options = {
        Url = var7 .. "v1/products/" .. tostring(arg1) .. "?showPurchasable=true",
        Method = "GET"
    }

    return Promise.new(function(callback, arg2)
        spawn(function()
            request(options, callback, arg2)
        end)
    end)
end

local function getCatalogItemDetails(num1: number, str1: string)
    local options = {
        Url = string.format("%sv1/catalog/items/%d/details?itemType=%s", var6, num1, str1),
        Method = "GET"
    }

    return Promise.new(function(callback, arg1)
        spawn(function()
            request(options, callback, arg1)
        end)
    end)
end

local function getResellers(str1: string, num1: number?)
    local options = {
        Url = string.format("%smarketplace-sales/v1/item/%s/resellers?cursor=&limit=%d", var3, str1, num1 or 10),
        Method = "GET"
    }

    return Promise.new(function(callback, arg1)
        spawn(function()
            request(options, callback, arg1)
        end)
    end)
end

local function postCartPricing(input)
    local options = {
        Url = var3 .. "marketplace-sales/v1/cart-pricing",
        Method = "POST",
        Body = HttpService:JSONEncode(input),
        Headers = { ["Content-Type"] = "application/json", Accept = "application/json" }
    }

    return Promise.new(function(callback, callback2)
        spawn(function()
            request(options, function(arg1)
                callback(arg1)
            end, function(arg1)
                callback2(arg1)
            end)
        end)
    end)
end

local function postInGameItemCartPricing(input)
    local options = {
        Url = var3 .. "checkout/v1/cart-pricing",
        Method = "POST",
        Body = HttpService:JSONEncode(input),
        Headers = { ["Content-Type"] = "application/json", Accept = "application/json" }
    }

    return Promise.new(function(callback, arg1)
        request(options, callback, arg1)
    end)
end

local function getSubscriptionPurchaseInfo(subscriptionId: string)
    return MarketplaceService:GetSubscriptionPurchaseInfoAsync(subscriptionId)
end

local function performSubscriptionPurchase(subscriptionId: string, paymentProvider: string)
    return MarketplaceService:PerformSubscriptionPurchaseV2(subscriptionId, paymentProvider)
end

local function getPurchaseWarning(str1: string?, num1: number?, bool1: boolean)
    local options = {
        Url = UrlBuilder.economy.purchaseWarning.getPurchaseWarning(str1, num1, not bool1),
        Method = "GET"
    }

    return Promise.new(function(callback, arg1)
        spawn(function()
            request(options, callback, arg1)
        end)
    end)
end

local function postPurchaseWarningAcknowledge(acknowledgement)
    local options = {
        Url = UrlBuilder.economy.purchaseWarning.ackPurchaseWarning(),
        Method = "POST",
        Body = HttpService:JSONEncode({ acknowledgement = acknowledgement }),
        Headers = { ["Content-Type"] = "application/json", Accept = "application/json" }
    }

    return Promise.new(function(_, _)
        spawn(function()
            return HttpService:RequestInternal(options):Start(function(_, _) end)
        end)
    end)
end

local function checkUserPurchaseSettings()
    local options = {
        Url = UrlBuilder.economy.paymentsGateway.checkUserPurchaseSettings(),
        Method = "POST",
        Body = HttpService:JSONEncode("{}"),
        Headers = { ["Content-Type"] = "application/json", Accept = "application/json" }
    }

    return Promise.new(function(callback, arg1)
        spawn(function()
            request(options, callback, arg1)
        end)
    end)
end

local function getVngShopUrl()
    local options = {
        Url = UrlBuilder.economy.vngPayments.getVngShopUrl(),
        Method = "GET"
    }

    return Promise.new(function(callback, arg1)
        spawn(function()
            request(options, callback, arg1)
        end)
    end)
end

local function performDevProductEdpPurchase(num1: number, input)
    local var9

    if FFlagEnableRequestLocationTypeForSduiPurchase then
        local requestLocationType = input.requestLocationType
        if requestLocationType == nil or requestLocationType == "" then
            var9 = ("%sdeveloper-products/v1/developer-products/%i/purchase"):format(var3, num1)
        else
            var9 = ("%sdeveloper-products/v1/developer-products/%i/purchase?requestLocationType=%s"):format(
                var3,
                num1,
                requestLocationType
            )
        end
    else
        var9 = ("%sdeveloper-products/v1/developer-products/%i/purchase?requestLocationType=ExperienceDetailPage"):format(var3, num1)
    end

    local options = {
        Url = var9,
        Method = "POST",
        Body = HttpService:JSONEncode(input),
        Headers = { ["Content-Type"] = "application/json", Accept = "application/json" }
    }

    return Promise.new(function(callback, arg1)
        spawn(function()
            request(options, callback, arg1)
        end)
    end)
end

local function getExperienceProductInfo(arg1)
    local options = {
        Url = ("%sv1/games/games-product-info?universeIds=%s"):format(var4, arg1),
        Method = "GET"
    }

    return Promise.new(function(callback, arg2)
        spawn(function()
            request(options, callback, arg2)
        end)
    end)
end

local function getUniversePrivateServerSettings(num1: number)
    local options = {
        Url = ("%sprivate-servers-api/universe-private-server-settings?universeId=%d"):format(var3, num1),
        Method = "GET"
    }

    return Promise.new(function(callback, arg1)
        spawn(function()
            request(options, callback, arg1)
        end)
    end)
end

local function performExperiencePurchase(str1: string, input)
    local options = {
        Url = ("%sv1/purchases/products/%s"):format(var7, str1),
        Method = "POST",
        Body = HttpService:JSONEncode(input),
        Headers = { ["Content-Type"] = "application/json", Accept = "application/json" }
    }

    return Promise.new(function(callback, arg1)
        spawn(function()
            request(options, callback, arg1)
        end)
    end)
end

local function performVIPServerPurchase(num1: number, input)
    local options = {
        Url = ("%sv1/games/vip-servers/%d"):format(var4, num1),
        Method = "POST",
        Body = HttpService:JSONEncode(input),
        Headers = { ["Content-Type"] = "application/json", Accept = "application/json" }
    }

    return Promise.new(function(callback, arg1)
        request(options, callback, arg1)
    end)
end

local function patchVIPServer(str1: string, input)
    local options = {
        Url = ("%sv1/vip-servers/%s"):format(var4, str1),
        Method = "PATCH",
        Body = HttpService:JSONEncode(input),
        Headers = { ["Content-Type"] = "application/json", Accept = "application/json" }
    }

    return Promise.new(function(callback, arg1)
        request(options, callback, arg1)
    end)
end

local function updateVIPServer(num1: number, arg1)
    return patchVIPServer(`{num1}`, arg1)
end

local function updateVIPServerPermissions(num1: number, arg1)
    return patchVIPServer(`{num1}/permissions`, arg1)
end

local function searchUsers(input: string)
    local options = {
        Url = ("%sv1/users/search?keyword=%s&limit=10"):format(var8, HttpService:UrlEncode(input)),
        Method = "GET"
    }

    return Promise.new(function(callback, arg1)
        request(options, callback, arg1)
    end)
end

local function performLookPurchase(str1: string, input)
    local options = {
        Url = ("%slook-api/v2/looks/%s/purchase"):format(var3, str1),
        Method = "POST",
        Body = HttpService:JSONEncode(input),
        Headers = { ["Content-Type"] = "application/json", Accept = "application/json" }
    }

    return Promise.new(function(callback, arg1)
        spawn(function()
            request(options, callback, arg1)
        end)
    end)
end

local function performLookPurchaseBulkPurchase(lookId: string, str2: string, lineItems)
    local options = {
        Url = ("%scloud/v2/avatar-marketplace-orders?idempotencyKey.key=%s"):format(var3, str2),
        Method = "POST",
        Body = HttpService:JSONEncode({
            purchasingUser = `users/{Players.LocalPlayer.UserId}`,
            context = {
                productSurface = "MARKETPLACE_UA",
                lookId = lookId,
                lookContext = {
                    lookIds = { lookId }
                }
            },
            fulfillmentGroups = {{ strategy = "BEST_EFFORT", lineItems = lineItems }}
        }),
        Headers = { ["Content-Type"] = "application/json", Accept = "application/json" }
    }

    return Promise.new(function(callback, arg1)
        spawn(function()
            request(options, callback, arg1)
        end)
    end)
end

local function performDeveloperSubscriptionRobuxPurchase(subscriptionId: string, priceInRobux: number)
    if not engineFeature2 then
        error("Developer subscription Robux purchase requires engine feature to be enabled")
        return
    end

    local success, result = pcall(function()
        MarketplaceService:PerformSubscriptionPurchaseWithRobuxAsync(subscriptionId, priceInRobux)
    end)
    if not success then
        error(result)
    end
end

local function getUnifiedPurchaseFlowUserEligibility()
    local options = {
        Url = ("%sroblox-subscriptions/v1/metadata"):format(var3),
        Method = "GET"
    }

    return Promise.new(function(callback, arg1)
        spawn(function()
            request(options, callback, arg1)
        end)
    end)
end

local function GetLookDetailsV2ProductInfo(str1: string)
    local options = {
        Url = string.format("%slook-api/v2/looks/%s", var3, str1),
        Method = "GET"
    }

    return Promise.new(function(callback, arg1)
        spawn(function()
            request(options, callback, arg1)
        end)
    end)
end

local module = {}

function module.new()
    local tbl1 = {
        getABTestGroup = Promise.promisify(getABTestGroup),
        getProductInfo = Promise.promisify(getProductInfo),
        getPlayerOwns = Promise.promisify(getPlayerOwns),
        performPurchase = Promise.promisify(performPurchase),
        performPurchaseV2 = Promise.promisify(performPurchaseV2),
        performCreatorStorePurchase = if GetFFlagEnableCreatorStorePurchasingCutover() then Promise.promisify(performCreatorStorePurchase) else nil,
        loadAssetForEquip = Promise.promisify(loadAssetForEquip),
        getAccountInfo = Promise.promisify(getAccountInfo),
        getAssetInfo = if GetFFlagEnableCreatorStorePurchasingCutover() then Promise.promisify(getAssetInfo) else nil,
        getBalanceInfo = Promise.promisify(getBalanceInfo),
        getBundleDetails = getBundleDetails,
        getProductPurchasableDetails = getProductPurchasableDetails,
        getCatalogItemDetails = if FFlagRefreshPriceOnRetryAfterUpsell then getCatalogItemDetails else nil,
        getResellers = if FFlagRefreshPriceOnRetryAfterUpsell then getResellers else nil,
        getCreatorStoreProductInfo = if GetFFlagEnableCreatorStorePurchasingCutover() then Promise.promisify(getCreatorStoreProductInfo) else nil,
        getSubscriptionPurchaseInfo = Promise.promisify(getSubscriptionPurchaseInfo),
        performSubscriptionPurchase = Promise.promisify(performSubscriptionPurchase),
        getPurchaseWarning = Promise.promisify(getPurchaseWarning),
        postPurchaseWarningAcknowledge = Promise.promisify(postPurchaseWarningAcknowledge),
        checkUserPurchaseSettings = Promise.promisify(checkUserPurchaseSettings),
        getVngShopUrl = Promise.promisify(getVngShopUrl),
        performDevProductEdpPurchase = Promise.promisify(performDevProductEdpPurchase),
        getExperienceProductInfo = Promise.promisify(getExperienceProductInfo),
        performExperiencePurchase = Promise.promisify(performExperiencePurchase),
        getUniversePrivateServerSettings = Promise.promisify(getUniversePrivateServerSettings),
        performVIPServerPurchase = if FFlagLuaAppsEnablePromptVIPServerPurchase then performVIPServerPurchase else nil,
        updateVIPServer = if FFlagLuaAppsEnablePromptVIPServerPurchase then updateVIPServer else nil,
        updateVIPServerPermissions = if FFlagLuaAppsEnablePromptVIPServerPurchase then updateVIPServerPermissions else nil,
        searchUsers = if FFlagLuaAppsEnablePromptVIPServerPurchase then searchUsers else nil,
        performLookPurchase = Promise.promisify(performLookPurchase),
        getUnifiedPurchaseFlowUserEligibility = Promise.promisify(getUnifiedPurchaseFlowUserEligibility),
        performLookPurchaseBulkPurchase = if FFlagPurchasePromptFetchCartPricingForLooks then Promise.promisify(performLookPurchaseBulkPurchase) else nil,
        performDeveloperSubscriptionRobuxPurchase = if FFlagEnableUnifiedPurchaseFlowForDevSubs then Promise.promisify(performDeveloperSubscriptionRobuxPurchase) else nil,
        getSubscriptionProductInfo = if FFlagEnableUnifiedPurchaseFlowForDevSubs then Promise.promisify(getSubscriptionProductInfo) else nil,
        GetLookDetailsV2ProductInfo = if FFlagUnifiedPurchaseSupportRefetchingLooksAfterUpsell then Promise.promisify(GetLookDetailsV2ProductInfo) else nil,
        postCartPricing = postCartPricing,
        postInGameItemCartPricing = postInGameItemCartPricing
    }

    setmetatable(tbl1, {
        __tostring = function(): string
            return "Service(Network)"
        end
    })

    return tbl1
end

return module
