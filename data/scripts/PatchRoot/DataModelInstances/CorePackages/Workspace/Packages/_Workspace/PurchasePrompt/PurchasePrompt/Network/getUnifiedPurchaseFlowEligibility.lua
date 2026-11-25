-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T07:20:59Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppStorageService = game:GetService("AppStorageService")
local PurchasePrompt = script:FindFirstAncestor("PurchasePrompt")
local PurchasePromptParent = PurchasePrompt.Parent
local Promise = require(PurchasePrompt.Promise)
local ProductTypeEnum = require(PurchasePrompt.types).ProductTypeEnum

local FFlagShipUnifiedPurchaseInExperience = require(PurchasePromptParent.SharedFlags).FFlagShipUnifiedPurchaseInExperience

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

local function getUnifiedPurchaseFlowEligibility(arg1, arg2)
    if arg2 == ProductTypeEnum.DeveloperSubscription then
        return Promise.resolve(true)
    end

    if arg2 == ProductTypeEnum.VIPServer then
        return Promise.resolve(true)
    end

    if FFlagShipUnifiedPurchaseInExperience then
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

    return arg1.getUnifiedPurchaseFlowUserEligibility():andThen(function(arg3)
        if not arg3 then
            return Promise.reject(false)
        end

        local unifiedPurchaseFlowMetadata = arg3.unifiedPurchaseFlowMetadata
        local isUserEligibleForUnifiedPurchaseFlow = unifiedPurchaseFlowMetadata.isUserEligibleForUnifiedPurchaseFlow
        local expiresInSeconds = unifiedPurchaseFlowMetadata.expiresInSeconds or 0

        persistUnifiedPurchaseFlowMetadata(isUserEligibleForUnifiedPurchaseFlow, num1 + expiresInSeconds)

        return Promise.resolve(isUserEligibleForUnifiedPurchaseFlow)
    end, function(_)
        return Promise.resolve(false)
    end):catch(function(_)
        return Promise.resolve(false)
    end)
end

return getUnifiedPurchaseFlowEligibility
