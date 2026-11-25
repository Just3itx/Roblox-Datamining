-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T08:20:57Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpRbxApiService = game:GetService("HttpRbxApiService")
local HttpService = game:GetService("HttpService")
local RunService = game:GetService("RunService")
local TelemetryService = game:GetService("TelemetryService")

local scriptParentParent = script.Parent.Parent
local Url = require(scriptParentParent.CoreScriptsCommon).Url

local apiUrl = `{Url.APIS_URL}ads-reward-service/v1/validateRewardAndPlacement`
local str1 = `{Url.APIS_URL}ads-reward-service/v1/validateRewardAndPlacementStudio`
local apiUrl2 = `{Url.APIS_URL}ads-reward-service/v1/grantAdReward`

local config = {
    eventName = "AdsRewardServiceHttpValidateCounter",
    backends = { "RobloxTelemetryCounter" },
    lastUpdated = { 2026, 10, 27 },
    description = "Counter for ValidateReward http calls"
}

local tbl1 = {
    eventName = "AdsRewardServiceHttpGrantAdCounter",
    backends = { "RobloxTelemetryCounter" },
    lastUpdated = { 2026, 10, 27 },
    description = "Counter for GrantAd http calls"
}

local config2 = {
    eventName = "AdsRewardServiceHttpError",
    backends = { "Points" },
    throttlingPercentage = game:DefineFastInt("AdsRewardServiceHttpErrorThrottleHundredthsPercent", 0),
    lastUpdated = { 2026, 10, 27 },
    description = "This event is sent whenever a ads-reward-service error occurs"
}

local function reportHttpError(endpoint: string, unixTimestampMillis: number, errorMessage: string)
    local latency = DateTime.now().UnixTimestampMillis - unixTimestampMillis
    TelemetryService:LogEvent(config2, {
        standardizedFields = { "addUniverseId", "addPlaceId" },
        customFields = { endpoint = endpoint, latency = latency, errorMessage = errorMessage }
    })
end

local function reportHttpStatusCounter(config3: {backends: {string}, description: string, eventName: string, lastUpdated: {number}}, status: string)
    TelemetryService:LogCounter(config3, { customFields = { status = status } }, 1)
end

local module = {}

function module.validateRewardAndPlacement(productId: number, placementId: number?)
    local apiUrl3 = if RunService:IsStudio() then str1 else apiUrl
    local unixTimestampMillis = DateTime.now().UnixTimestampMillis

    reportHttpStatusCounter(config, "called")
    local success, result = pcall(function(): string
        local str2 = HttpService:JSONEncode({ universeId = game.GameId, productId = productId, placementId = placementId })
        return HttpRbxApiService:PostAsyncFullUrl(apiUrl3, str2, Enum.ThrottlingPriority.Extreme, Enum.HttpContentType.ApplicationJson)
    end)

    if not success then
        reportHttpStatusCounter(config, "failed")
        reportHttpError(apiUrl3, unixTimestampMillis, `Validate Ad Reward failed: {result}`)
        return nil, `Validate Ad Reward failed: {result}`
    end

    local success2, result2 = pcall(function()
        local var1 = HttpService:JSONDecode(result)
        if type(var1) == "table" and type(var1.rewardDetails) == "table" then
            return var1
        end
        error("Failed to parse rewardDetails")
    end)

    if not success2 or type(result2) ~= "table" then
        reportHttpStatusCounter(config, "failed")
        reportHttpError(apiUrl3, unixTimestampMillis, `Validate Ad Reward failed to parse response: {result}`)
        return nil, `Validate Ad Reward failed to parse response: {result}`
    end

    reportHttpStatusCounter(config, "success")
    local rewardDetails = result2.rewardDetails
    return {
        isValidReward = result2.isValidReward == true,
        isValidPlacement = result2.isValidPlacement == true,
        defaultPlacementId = result2.defaultPlacement,
        productName = if type(rewardDetails.productName) ~= "string" then "" else rewardDetails.productName,
        imageAssetIdString = rewardDetails.imageAssetIdString
    }, nil
end

function module.grantAdReward(userId: number, productId: number, encryptedAdTrackingData: string, encryptionMetadata: string)
    local unixTimestampMillis = DateTime.now().UnixTimestampMillis
    reportHttpStatusCounter(tbl1, "called")
    local success, result = pcall(function(): string
        local str2 = HttpService:JSONEncode({
            encryptionMetadata = encryptionMetadata,
            encryptedAdTrackingData = encryptedAdTrackingData,
            productId = productId,
            userId = userId
        })
        return HttpRbxApiService:PostAsyncFullUrl(apiUrl2, str2, Enum.ThrottlingPriority.Extreme, Enum.HttpContentType.ApplicationJson)
    end)

    if success then
        reportHttpStatusCounter(tbl1, "success")
        return true, nil
    end

    reportHttpStatusCounter(tbl1, "failed")
    reportHttpError(apiUrl2, unixTimestampMillis, `Grant Ad Reward failed: {result}`)
    return false, `Grant Ad Reward failed: {result}`
end

return module
