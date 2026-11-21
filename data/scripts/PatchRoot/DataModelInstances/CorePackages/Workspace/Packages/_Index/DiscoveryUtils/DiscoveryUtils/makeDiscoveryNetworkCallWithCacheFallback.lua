-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T11:11:15Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DiscoveryUtils = script:FindFirstAncestor("DiscoveryUtils")
local DiscoveryUtilsParent = DiscoveryUtils.Parent
local _LuauPolyfill = require(DiscoveryUtilsParent.LuauPolyfill)
local Promise = require(DiscoveryUtilsParent.Promise)
local DiscoveryClientAppStorage = require(DiscoveryUtils.DiscoveryClientAppStorage)

local function makeDiscoveryNetworkCallWithCacheFallback(arg1, arg2, num1: number)
    return arg1:andThen(function<T>(arg3: T): T
        return arg3
    end):catch(function(arg3)
        local success, result = pcall(function()
            return DiscoveryClientAppStorage.getJsonStorageData(arg2, num1)
        end)

        if not success then
            return Promise.reject(result)
        elseif result then
            return Promise.resolve({ responseBody = result, isFromCache = true })
        end

        return Promise.reject(arg3)
    end)
end

return makeDiscoveryNetworkCallWithCacheFallback
