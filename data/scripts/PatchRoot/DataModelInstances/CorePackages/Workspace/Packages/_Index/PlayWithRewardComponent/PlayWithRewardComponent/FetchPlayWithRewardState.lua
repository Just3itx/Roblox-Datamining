-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T10:10:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")

local PlayWithRewardComponent = script:FindFirstAncestor("PlayWithRewardComponent")
local PlayWithRewardTelemetry = require(PlayWithRewardComponent.PlayWithRewardTelemetry)

local PlayWithRewardComponentParent = PlayWithRewardComponent.Parent
local Promise = require(PlayWithRewardComponentParent.Promise)
local Logger = require(PlayWithRewardComponentParent.Loggers).Logger
local mutedError = require(PlayWithRewardComponentParent.Loggers).mutedError
local t = require(PlayWithRewardComponentParent.t)

local PlayWithRewardState = require(PlayWithRewardComponentParent.PlayWithRewardState)
local PlayWithRewardAdData = PlayWithRewardState.PlayWithRewardAdData
local SetPlayWithRewardState = PlayWithRewardState.SetPlayWithRewardState

local var1 = t.interface({
    AdAvailabilityResult = t.userdata,
    ProductId = t.optional(t.string),
    ProductName = t.optional(t.string),
    ProductImageAssetId = t.optional(t.string),
    ExperimentVariantData = t.optional(t.string)
})

local var2 = t.interface({ IsEligible = t.boolean })

local function getDurationSinceStartFetchMs(num1: number): number -- Luacid: Inlined by compiler; 3 call sites recovered
    return (os.clock() - num1) * 1000
end

local function fetchAd(arg1, str1: string, _) -- Luacid: Inlined by compiler; 1 call site recovered
    return arg1:GetAdAvailabilityNowForUniverseAsync(Enum.AdFormat.RewardedVideo, tonumber(str1), true) or nil
end

local function fetchPlayWithRewardStateAsync(arg1, str1: string, _: number, str2: string)
    if not arg1 then
        Logger:warning(`AdService is not available. Cannot fetch Play with Reward data for universe ID {str1}.`)
        return nil
    end

    local now = os.clock()
    PlayWithRewardTelemetry.logPlayWithRewardAdRequested(str2, str1)
    local var3 = fetchAd(arg1, str1, nil)

    if var3 == nil then
        Logger:warning(`Could not fetch Play with Reward ad for universe ID {str1}.`)
        PlayWithRewardTelemetry.logPlayWithRewardAdReceived(str2, str1, false, nil, getDurationSinceStartFetchMs(now), nil)

        return nil
    end

    local var4, var5 = var1(var3)
    if not var4 then
        mutedError(`PlayWithRewardAdData invalid: {tostring(var5)}`)
        PlayWithRewardTelemetry.logPlayWithRewardAdReceived(str2, str1, false, nil, getDurationSinceStartFetchMs(now), nil)

        return nil
    end

    local adAvailabilityResult = var3.AdAvailabilityResult
    local productId = var3.ProductId
    local productName = var3.ProductName
    local productImageAssetId = var3.ProductImageAssetId
    local experimentVariantData = var3.ExperimentVariantData

    PlayWithRewardTelemetry.logPlayWithRewardAdReceived(
        str2,
        str1,
        true,
        tostring(adAvailabilityResult),
        getDurationSinceStartFetchMs(now),
        productId
    )

    return PlayWithRewardAdData.new(adAvailabilityResult, productId, productName, productImageAssetId, experimentVariantData)
end

local function shouldShowShimmer(arg1, str1: string): boolean
    if not arg1 then
        Logger:warning(
            `AdService is not available. Cannot determine whether to show shimmer for universe ID {str1}.`
        )
        return false
    end
    local success, result = pcall(function()
        return arg1:GetUniversalAppAdsEligibility()
    end)
    if not (success and result) then
        return false
    end
    local var3, _ = var2(result)
    return not not (var3 and result.IsEligible)
end

local function FetchPlayWithRewardState(arg1, str1: string, num1: number)
    return function(arg2)
        local str2 = HttpService:GenerateGUID(false)
        if shouldShowShimmer(arg1, str1) then
            PlayWithRewardTelemetry.logPlayWithRewardShimmerShown(str2, str1)
            arg2:dispatch(SetPlayWithRewardState(str2, str1, true, nil))
        end

        return Promise.new(function(callback, callback2)
            local success, result = pcall(function()
                return fetchPlayWithRewardStateAsync(arg1, str1, num1, str2)
            end)
            if success and result then
                arg2:dispatch(SetPlayWithRewardState(str2, str1, false, result))
                callback()
                return
            end
            arg2:dispatch(SetPlayWithRewardState(str2, str1, false, nil))
            callback2(result)
        end):catch(function(arg3)
            Logger:warning(
                `Promise for fetching Play With Reward data rejected for universe ID {str1}: {tostring(arg3)}`
            )
        end)
    end
end

return FetchPlayWithRewardState
