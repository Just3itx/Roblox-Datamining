-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T04:20:47Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DataHydration = script:FindFirstAncestor("DataHydration")
local DataHydrationParent = DataHydration.Parent
local Dash = require(DataHydrationParent.Dash)
local DiscoveryUtils = require(DataHydrationParent.DiscoveryUtils)
local logResponseError = DiscoveryUtils.logResponseError
local DiscoveryEventErrorLogger = DiscoveryUtils.DiscoveryEventErrorLogger

local createDataCache = require(DataHydration.createDataCache)
local createDataResolver = require(DataHydration.createDataResolver)
local _DataHydrationTypes = require(DataHydration.DataHydrationTypes)

local fetchGameDetails = require(script.Parent.fetchGameDetails)
local GameInfoStoreTypes = require(script.Parent.GameInfoStoreTypes)

local trim = require(DataHydrationParent.LuauPolyfill).String.trim

local FFlagLuaAppInExperienceDetailsPrompt = require(DataHydrationParent.SharedFlags).FFlagLuaAppInExperienceDetailsPrompt

local GetFIntLuaAppThrottleRefreshPlayabilityIntervalSeconds = require(DataHydrationParent.SharedFlags).GetFIntLuaAppThrottleRefreshPlayabilityIntervalSeconds
local FFlagLuaAppDataHydrationUpdateItem = require(DataHydrationParent.SharedFlags).FFlagLuaAppDataHydrationUpdateItem
local fIntLuaAppThrottleRefreshPlayabilityIntervalSeconds = if FFlagLuaAppInExperienceDetailsPrompt then GetFIntLuaAppThrottleRefreshPlayabilityIntervalSeconds() else nil

local function sanitizeGameInfo(arg1)
    if arg1.name then
        arg1.name = trim(arg1.name)
    end
    return arg1
end

local function createGameInfoStore()
    local tbl1 = {}

    local function indexPlaceId(str1: string, arg1) -- Luacid: Inlined by compiler; 3 call sites recovered
        if arg1 and arg1.rootPlaceId then
            local tbl2 = tbl1
            local rootPlaceId = arg1.rootPlaceId
            tbl2[tostring(rootPlaceId)] = str1
        end
    end

    local cache = if FFlagLuaAppInExperienceDetailsPrompt then createDataCache(fIntLuaAppThrottleRefreshPlayabilityIntervalSeconds, nil, { sanitizeItem = sanitizeGameInfo }) else createDataCache(nil, nil, { sanitizeItem = sanitizeGameInfo })

    local dataResolver = createDataResolver({
        cache = cache,
        logError = FFlagLuaAppInExperienceDetailsPrompt and function(arg1)
            if type(arg1) ~= "table" then
                DiscoveryEventErrorLogger.reportError("FetchGameDetailsError", tostring(arg1))
                return
            end

            if arg1.responseCode then
                logResponseError("v1/games/universeIds", { StatusCode = tonumber(arg1.responseCode) })
            end
            if arg1.errorType and arg1.errorMessage then
                DiscoveryEventErrorLogger.reportError(arg1.errorType, arg1.errorMessage, arg1.customFields)
            end
        end or nil,
        fetchFn = function(tbl2)
            local universeIds = Dash.keys(tbl2)
            return fetchGameDetails(universeIds):andThen(function(arg1)
                if FFlagLuaAppInExperienceDetailsPrompt then
                    if not (arg1 and arg1.responseBody) then
                        error({
                            responseCode = arg1 and arg1.responseCode,
                            errorType = "FetchGameDetailsResponseError",
                            errorMessage = if arg1 then "Missing response body" else "No response",
                            customFields = { universeIds = universeIds }
                        })
                    end
                else
                    if not arg1 then
                        error("No response")
                    end
                    if not (arg1.responseBody and arg1.responseBody.data) then
                        error(`Response Code: {arg1.reponseCode}`)
                    end
                end

                if FFlagLuaAppInExperienceDetailsPrompt then
                    local var2, errorMessage = GameInfoStoreTypes.gameInfoResponseValidator(arg1.responseBody)
                    if not var2 then
                        error({
                            responseCode = arg1.responseCode,
                            errorType = "FetchGameDetailsResponseInvalidInterface",
                            errorMessage = errorMessage,
                            customFields = { universeIds = universeIds }
                        })
                    end
                end

                local result = ({})
                local data = arg1.responseBody.data
                if FFlagLuaAppInExperienceDetailsPrompt then
                    for _, value in data do
                        if not value then
                            continue
                        end

                        local str1 = tostring(value.id)
                        local tbl3 = {
                            name = value.name,
                            rootPlaceId = tostring(value.rootPlaceId),
                            universeId = tostring(value.id),
                            description = value.description,
                            creator = 0,
                            playerCount = 0,
                            totalVisits = 0
                        }
                        local tbl4

                        if value.creator then
                            tbl4 = { id = 0, name = 0, hasVerifiedBadge = 0 }
                            local id = value.creator.id
                            tbl4.id = tostring(id)
                            tbl4.name = value.creator.name
                            tbl4.hasVerifiedBadge = value.creator.hasVerifiedBadge
                        else
                            tbl4 = nil
                        end

                        tbl3.creator = tbl4

                        tbl3.playerCount = value.playing
                        tbl3.totalVisits = value.visits
                        result[str1] = tbl3
                    end

                    for _, value in universeIds do
                        if not result[tostring(value)] then
                            result[tostring(value)] = { isUnavailable = true }
                        end
                    end
                else
                    Dash.forEach(data, function(arg2)
                        local tbl3 = result
                        local str1 = tostring(arg2.id)
                        tbl3[str1] = {
                            name = arg2.name,
                            rootPlaceId = tostring(arg2.rootPlaceId),
                            universeId = tostring(arg2.id),
                            playerCount = arg2.playing,
                            totalVisits = arg2.visits
                        }
                    end)
                end
                for value, value2 in result do
                    indexPlaceId(value, value2)
                end

                return result
            end):catch(function(arg1)
                error(arg1)
            end)
        end
    })

    local function clear()
        if not FFlagLuaAppInExperienceDetailsPrompt then
            cache.clear()
            dataResolver.clear()
        end
    end

    local function dispose()
        if not FFlagLuaAppInExperienceDetailsPrompt then
            cache.dispose()
            dataResolver.dispose()
        end
    end

    local tbl2 = {
        fetchGameInfo = dataResolver.fetchItem,
        fetchGameInfos = dataResolver.fetchItems,
        getGameInfo = dataResolver.getCachedItem,
        getGameInfos = dataResolver.getCachedItems,
        getAndFetchGameInfo = dataResolver.getAndFetchItem,
        getAndFetchGameInfos = dataResolver.getAndFetchItems,
        updateGameInfo = FFlagLuaAppDataHydrationUpdateItem and function(str1: string, arg1, bool1: boolean?) -- name: updateGameInfo
            indexPlaceId(str1, arg1)
            cache.updateItem(str1, arg1, bool1)
        end or nil,
        updateGameInfos = function(tbl2, bool1: boolean?)
            for value, value2 in tbl2 do
                indexPlaceId(value, value2)
            end

            cache.updateItems(tbl2, bool1)
        end,
        getUniverseIdForPlaceId = function(arg1)
            return tbl1[tostring(arg1)]
        end,
        applyVoteChange = function(str1: string, bool1: boolean?, bool2: boolean?): {totalDownVotes: any, totalUpVotes: any}?
            local cachedItem = dataResolver.getCachedItem(str1)
            local var1 = cachedItem and cachedItem.data(false)
            if not var1 or var1.totalUpVotes == nil then
                return nil
            end

            local num1 = tonumber(var1.totalUpVotes) or 0
            local num2 = tonumber(var1.totalDownVotes) or 0
            local tbl2 = {
                totalUpVotes = var1.totalUpVotes,
                totalDownVotes = var1.totalDownVotes
            }
            local num3 = (if bool2 == true then 1 else 0) - (if bool1 == true then 1 else 0)
            local num4 = (if bool2 == false then 1 else 0) - (if bool1 == false then 1 else 0)
            cache.updateItem(
                str1,
                {
                    totalUpVotes = tostring(math.max(0, num1 + num3)),
                    totalDownVotes = tostring(math.max(0, num2 + num4))
                },
                false
            )
            return tbl2
        end,
        clear = 0,
        dispose = 0
    }
    if FFlagLuaAppInExperienceDetailsPrompt then
        clear = dataResolver.clear
    end

    tbl2.clear = clear
    if FFlagLuaAppInExperienceDetailsPrompt then
        dispose = dataResolver.dispose
    end

    tbl2.dispose = dispose
    return tbl2
end

return createGameInfoStore
