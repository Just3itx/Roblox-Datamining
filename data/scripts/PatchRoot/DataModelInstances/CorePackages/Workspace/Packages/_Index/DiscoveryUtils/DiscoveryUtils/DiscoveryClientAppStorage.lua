-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T11:11:00Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppStorageService = game:GetService("AppStorageService")
local HttpService = game:GetService("HttpService")
local TelemetryService = game:GetService("TelemetryService")

local DiscoveryUtils = script:FindFirstAncestor("DiscoveryUtils")
local DiscoveryEventErrorLogger = require(DiscoveryUtils.Telemetry.DiscoveryEventErrorLogger)
local DiscoveryUtilsParent = DiscoveryUtils.Parent
local LocalStorageKey = require(DiscoveryUtilsParent.LocalStorage).Enums.LocalStorageKey

local num1 = game:DefineFastInt("LuaAppDiscoveryClientAppStorageCacheTtlDays", 30)

local bool1 = game:DefineFastFlag("LuaAppDiscoveryClientAppStorageEmptyCacheTelemetry", false)

local throttlingPercentage = game:DefineFastInt("DiscoveryClientAppStorageGetItemErrorThrottleHundredthsPercent", 10000)

local CacheKey = {
    HomeOmniFeedCache = LocalStorageKey.DiscoveryClientFallbackCache
}

local config = bool1
    and {
        eventName = "discoveryClientAppStorageEmptyCache",
        backends = { "EventIngest" },
        throttlingPercentage = throttlingPercentage,
        lastUpdated = { 25, 11, 19 },
        description = "Cached data not found after omni recommendations fetch fails"
    }
    or nil

function getJsonStorageData(key: string, version: number)
    if not game:GetEngineFeature("UniversalAppDiscoveryClientFallbackCacheStorageKey") then
        return nil
    end

    local item = AppStorageService:GetItem(key)

    if item == nil or item == "" then
        if bool1 then
            TelemetryService:LogEvent(config, { standardizedFields = { "addSessionInfo" }, customFields = { cacheKey = key } })
        end

        return nil
    end

    local success, result = pcall(function()
        return HttpService:JSONDecode(item)
    end)

    if not success then
        DiscoveryEventErrorLogger.reportError("DiscoveryClientAppStorageDataError", result)
        error(`Failed to decode cache data for key: {key}`)
    end

    if not result.version then
        DiscoveryEventErrorLogger.reportError(
            "DiscoveryClientAppStorageDataError",
            `Cached data version not found for key: {key}`
        )
        error(`Cached data version not found for key: {key}`)
    end

    if not result.lastUpdatedTime then
        DiscoveryEventErrorLogger.reportError(
            "DiscoveryClientAppStorageDataError",
            `Cached data time not found for key: {key}`
        )
        error(`Cached data time not found for key: {key}`)
    end

    return if result.version == version and not (result.lastUpdatedTime and result.lastUpdatedTime < os.time() - 86400 * num1) then result.data else nil
end

function setJsonStorageData(key: string, arg1, version: number)
    if not game:GetEngineFeature("UniversalAppDiscoveryClientFallbackCacheStorageKey") then
        return
    end

    local input = {
        data = arg1,
        lastUpdatedTime = os.time(),
        version = version
    }

    local str1 = HttpService:JSONEncode(input)
    AppStorageService:SetItem(key, str1)
end

return {
    CacheKey = CacheKey,
    getJsonStorageData = getJsonStorageData,
    setJsonStorageData = setJsonStorageData
}
