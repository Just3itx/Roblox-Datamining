-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T13:00:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppStorageService = game:GetService("AppStorageService")

local PurchasePromptLiteParent = script:FindFirstAncestor("PurchasePromptLite").Parent
local Url = require(PurchasePromptLiteParent.Http).Url
local Promise = require(PurchasePromptLiteParent.Promise)

local function APIGetRobloxSubscriptionMetadata(arg1)
    if arg1 == nil then
        return Promise.reject()
    end

    return arg1(string.format("%sroblox-subscriptions/v1/metadata", Url.APIS_URL), "GET"):andThen(function(arg2)
        return Promise.resolve(arg2.responseBody)
    end, function(arg2)
        return Promise.reject(arg2)
    end)
end

local function getUnifiedPurchaseFlowIsUserEligibleFromStorage(): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    return AppStorageService:GetItem("UnifiedPurchaseFlowIsUserEligible") == "true"
end

local function getUnifiedPurchaseFlowExpirationTimeSecondsUTCFromStorage(): number -- Luacid: Inlined by compiler; 1 call site recovered
    return tonumber((AppStorageService:GetItem("UnifiedPurchaseFlowExpirationTimeSecondsUTC"))) or -1
end

local function persistUnifiedPurchaseFlowMetadata(isUserEligibleForUnifiedPurchaseFlow: boolean, num1: number) -- Luacid: Inlined by compiler; 1 call site recovered
    if isUserEligibleForUnifiedPurchaseFlow then
        AppStorageService:SetItem("UnifiedPurchaseFlowIsUserEligible", "true")
    else
        AppStorageService:SetItem("UnifiedPurchaseFlowIsUserEligible", "false")
    end

    AppStorageService:SetItem("UnifiedPurchaseFlowExpirationTimeSecondsUTC", tostring(num1))

    AppStorageService:Flush()
end

local function getIsUserEligibleForUnifiedPurchaseFlow(arg1, str1: string?)
    if str1 == "DeveloperSubscription" then
        return Promise.resolve(true)
    end

    local num1 = os.time(os.date("!*t"))
    local unifiedPurchaseFlowExpirationTimeSecondsUtcFromStorage = getUnifiedPurchaseFlowExpirationTimeSecondsUTCFromStorage()

    if unifiedPurchaseFlowExpirationTimeSecondsUtcFromStorage ~= -1
        and num1 < unifiedPurchaseFlowExpirationTimeSecondsUtcFromStorage
    then
        local bool1 = not not getUnifiedPurchaseFlowIsUserEligibleFromStorage()

        return Promise.resolve(bool1)
    end

    return APIGetRobloxSubscriptionMetadata(arg1):andThen(function(tbl1)
        local unifiedPurchaseFlowMetadata = tbl1.unifiedPurchaseFlowMetadata
        local isUserEligibleForUnifiedPurchaseFlow = unifiedPurchaseFlowMetadata.isUserEligibleForUnifiedPurchaseFlow
        local expiresInSeconds = unifiedPurchaseFlowMetadata.expiresInSeconds or 0

        persistUnifiedPurchaseFlowMetadata(isUserEligibleForUnifiedPurchaseFlow, num1 + expiresInSeconds)

        return Promise.resolve(isUserEligibleForUnifiedPurchaseFlow)
    end):catch(function(_)
        return Promise.resolve(false)
    end)
end

return getIsUserEligibleForUnifiedPurchaseFlow
