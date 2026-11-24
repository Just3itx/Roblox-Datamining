-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T04:11:21Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DataHydration = script:FindFirstAncestor("DataHydration")
local DataHydrationParent = DataHydration.Parent

local Signals = require(DataHydrationParent.Signals)

local createDataCache = require(DataHydration.createDataCache)
local createDataResolver = require(DataHydration.createDataResolver)
local _DataHydrationTypes = require(DataHydration.DataHydrationTypes)

local DiscoveryUtils = require(DataHydrationParent.DiscoveryUtils)
local _LuauPolyfill = require(DataHydrationParent.LuauPolyfill)
local logResponseError = DiscoveryUtils.logResponseError
local DiscoveryEventErrorLogger = DiscoveryUtils.DiscoveryEventErrorLogger

local fetchFollowing = require(script.Parent.fetchFollowing)
local requestUpdateFollowing = require(script.Parent.requestUpdateFollowing)
local FollowingsStoreTypes = require(script.Parent.FollowingsStoreTypes)
local FollowingsUrlBuilder = require(script.Parent.FollowingsUrlBuilder)

local FFlagLuaAppDataHydrationUpdateItem = require(DataHydrationParent.SharedFlags).FFlagLuaAppDataHydrationUpdateItem

local function createFollowingsStore()
    local cache = createDataCache()
    local var1 = nil

    local dataResolver = createDataResolver({
        cache = cache,
        supportsMultiGet = false,
        logError = function(arg1)
            logResponseError(FollowingsUrlBuilder.FOLLOWING_STATUS_URL, arg1)
        end,
        onClear = function()
            var1 = nil
        end,
        fetchFn = function(universeId: string, _)
            return fetchFollowing(universeId):andThen(function(arg1)
                local responseBody = arg1.responseBody
                if not FollowingsStoreTypes.followingResponseValidator(responseBody) then
                    DiscoveryEventErrorLogger.reportError("createFollowingsStore", "Invalid following response", {
                        universeId = responseBody.UniverseId,
                        isFollowing = responseBody.IsFollowing,
                        userId = responseBody.UserId,
                        canFollow = responseBody.CanFollow
                    })
                    error({ StatusCode = arg1.responseCode })
                end

                if responseBody.FollowingCountByType and responseBody.FollowingLimitByType then
                    var1 = {
                        followingCountByType = responseBody.FollowingCountByType,
                        followingLimitByType = responseBody.FollowingLimitByType
                    }
                end

                return {
                    universeId = tostring(responseBody.UniverseId),
                    userId = tostring(responseBody.UserId),
                    canFollow = responseBody.CanFollow,
                    isFollowing = responseBody.IsFollowing
                }
            end):catch(function(arg1)
                if type(arg1) ~= "table" or arg1.ClientError == nil then
                    error(arg1)
                    return
                end

                local clientError = arg1.message or arg1.ClientError
                DiscoveryEventErrorLogger.reportError(
                    "createFollowingsStore",
                    "Client validation error fetching following",
                    { universeId = universeId, clientError = clientError }
                )
            end)
        end
    })

    local function clear()
        var1 = nil
        dataResolver.clear()
    end

    local function dispose()
        dataResolver.dispose()
    end

    return {
        fetchFollowing = dataResolver.fetchItem,
        fetchFollowings = dataResolver.fetchItems,
        getFollowing = dataResolver.getCachedItem,
        getFollowings = dataResolver.getCachedItems,
        getAndFetchFollowing = dataResolver.getAndFetchItem,
        getAndFetchFollowings = dataResolver.getAndFetchItems,
        updateFollowing = function(universeId: string, isFollowing: boolean)
            local var2, var3 = Signals.createSignal(nil)

            local item = cache.getItem(universeId)
            local var4 = item and item.data(false)
            local isFollowing2 = if var4 then var4.isFollowing else nil
            local var5 = var1

            if isFollowing and var5 and var5.followingCountByType >= var5.followingLimitByType then
                var3({ type = "error", errorType = "LimitReached", statusCode = nil, statusMessage = nil })

                return var2
            end

            cache.updateItem(universeId, { isFollowing = isFollowing })

            if var5 then
                var1 = {
                    followingCountByType = (var5 and var5.followingCountByType or 0) + (if isFollowing then 1 else -1),
                    followingLimitByType = var5.followingLimitByType
                }
            end

            requestUpdateFollowing(universeId, isFollowing):andThen(function()
                var3({ type = "success", isFollowing = isFollowing })
            end):catch(function(arg1)
                cache.updateItem(universeId, { isFollowing = isFollowing2 })

                if var5 then
                    var1 = var5
                end

                local bool1 = type(arg1) == "table" and arg1.ClientError ~= nil
                local var6 = if bool1 then arg1.message or arg1.ClientError else nil
                local statusCode = if type(arg1) == "table" and arg1.StatusCode then arg1.StatusCode else nil
                local statusMessage = if type(arg1) == "table" and arg1.StatusMessage then arg1.StatusMessage else nil
                var3({
                    type = "error",
                    errorType = if bool1 then "ClientError" elseif statusCode == 400 then "LimitReached" else "NetworkError",
                    statusCode = statusCode,
                    statusMessage = var6 or statusMessage
                })

                if bool1 then
                    DiscoveryEventErrorLogger.reportError(
                        "updateFollowing",
                        "Client validation error updating following",
                        {
                            universeId = universeId,
                            method = if isFollowing then "POST" else "DELETE",
                            clientError = var6
                        }
                    )
                    return
                end

                logResponseError(FollowingsUrlBuilder.FOLLOWING_UPDATE_URL, { StatusCode = statusCode })

                DiscoveryEventErrorLogger.reportError("updateFollowing", "Error updating following", {
                    universeId = universeId,
                    statusCode = statusCode,
                    method = if isFollowing then "POST" else "DELETE",
                    statusMessage = statusMessage
                })
            end)

            return var2
        end,
        updateItem = if FFlagLuaAppDataHydrationUpdateItem then cache.updateItem else nil,
        updateUserFollowingLimits = FFlagLuaAppDataHydrationUpdateItem and function(arg1)
            var1 = arg1
        end or nil,
        clear = clear,
        dispose = dispose
    }
end

return createFollowingsStore
