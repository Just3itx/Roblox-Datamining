-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T11:31:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppStorageService = game:GetService("AppStorageService")
local IXPService = game:GetService("IXPService")
local HttpService = game:GetService("HttpService")
local EventIngestService = game:GetService("EventIngestService")

local ExperimentCacheManagerParent = script:FindFirstAncestor("ExperimentCacheManager").Parent
local EventIngest = require(ExperimentCacheManagerParent.Analytics).AnalyticsReporters.EventIngest
local memoize = require(ExperimentCacheManagerParent.AppCommonLib).memoize
local AppStorageJsonCacheUtils = require(ExperimentCacheManagerParent.AppCommonLib).Utils.AppStorageJsonCacheUtils
local mutedError = require(ExperimentCacheManagerParent.Loggers).mutedError
local LocalStorageKey = require(ExperimentCacheManagerParent.LocalStorage).Enums.LocalStorageKey

local GetExperimentCacheLayers = require(script.Parent.GetExperimentCacheLayers)
local bool1 = game:DefineFastFlag("EnableAppStorageJsonDecodeCache", false)

local module = ({})
module.__index = module

function module.new(_ixpService, _eventIngest, _layersToCache)
    local tbl1 = {
        _ixpService = _ixpService or IXPService,
        _eventIngest = _eventIngest or EventIngest.new(EventIngestService),
        _cache = {},
        _loadingStatusChanged = nil,
        _layersToCache = _layersToCache or GetExperimentCacheLayers(),
        _exposureLoggingTable = {},
        _hasLoggedMissingLayerError = nil
    }

    setmetatable(tbl1, module)
    return tbl1
end

function module:_getCachedVariables()
    if bool1 then
        local cachedJsonForKey = AppStorageJsonCacheUtils.default:getCachedJsonForKey(LocalStorageKey.ExperimentCache, true)
        return if cachedJsonForKey == nil then {} else cachedJsonForKey
    end

    local success, result = pcall(function(): string
        return AppStorageService:GetItem(LocalStorageKey.ExperimentCache)
    end)

    if success then
        local success2, result2 = pcall(function()
            return HttpService:JSONDecode(result)
        end)

        if success2 then
            return result2
        end
    end

    return {}
end

function module:_flushToCache(input)
    assert(type(input) == "table", "expected table type for cache to persist")

    local success, result = pcall(function(): string
        return HttpService:JSONEncode(input)
    end)

    if not success then
        return
    end

    local success2, result2 = pcall(function()
        AppStorageService:SetItem(LocalStorageKey.ExperimentCache, result)
        AppStorageService:Flush()
    end)

    if not success2 then
        warn(result2)
    end
end

function module:_onIXPInitialized()
    local userLayerLoadingStatus = self._ixpService:GetUserLayerLoadingStatus()
    if userLayerLoadingStatus ~= Enum.IXPLoadingStatus.Pending and self._loadingStatusChanged then
        self._loadingStatusChanged:disconnect()
        self._loadingStatusChanged = nil
    end

    if userLayerLoadingStatus ~= Enum.IXPLoadingStatus.Initialized then
        return
    end

    local tbl1 = ({})
    for _, value in ipairs(self._layersToCache) do
        local userLayerVariables = nil
        pcall(function()
            userLayerVariables = self._ixpService:GetUserLayerVariables(value)
        end)

        tbl1[value] = userLayerVariables
    end

    self:_flushToCache(tbl1)
end

function module:_logCustomExposure(layerName: string)
    assert(type(layerName) == "string", "expected layerName to be a string")
    self._eventIngest:setRBXEventStream("experimentCacheManager", "exposureLog", { layerName = layerName })
end

function module:_containsLayer(str1: string)
    return memoize(function(arg1)
        for _, value in ipairs(self._layersToCache) do
            if value == arg1 then
                return true
            end
        end

        return false
    end)(str1)
end

function module:initialize()
    self._cache = self:_getCachedVariables()

    if self._ixpService:GetUserLayerLoadingStatus() == Enum.IXPLoadingStatus.Initialized then
        self:_onIXPInitialized()
        return
    end
    self._loadingStatusChanged = self._ixpService.OnUserLayerLoadingStatusChanged:Connect(function(status: Enum.IXPLoadingStatus)
        if status == Enum.IXPLoadingStatus.Initialized then
            self:_onIXPInitialized()
        end
    end)
end

function module:getLayerVariables(str1: string, _: boolean?)
    assert(type(str1) == "string", "expected layerName to be a string")

    if not (self:_containsLayer(str1) or self._hasLoggedMissingLayerError) then
        self._hasLoggedMissingLayerError = true
        mutedError("Layer " .. str1 .. " has not been configured to be cached, please add layer to `GetExperimentCacheLayers`")
    end

    return self._cache[str1] or nil
end

function module:clearCache()
    self._cache = {}
    self._exposureLoggingTable = {}

    pcall(function()
        AppStorageService:SetItem(LocalStorageKey.ExperimentCache, "")
        AppStorageService:Flush()
    end)
end

function module:sendCustomExposureLog(arg1)
    if self._exposureLoggingTable[arg1] == nil then
        self:_logCustomExposure(arg1)

        self._exposureLoggingTable[arg1] = true
    end
end

function module:logLayerExposure(arg1)
    self._ixpService:LogUserLayerExposure(arg1)
end

module.default = module.new()
return module
