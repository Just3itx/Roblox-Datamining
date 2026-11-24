-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T04:21:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DataHydration = script:FindFirstAncestor("DataHydration")
local DataHydrationParent = DataHydration.Parent

local Cryo = require(DataHydrationParent.Cryo)
local Dash = require(DataHydrationParent.Dash)
local Signals = require(DataHydrationParent.Signals)

local HttpService = game:GetService("HttpService")
local createDataCache = require(DataHydration.createDataCache)
local createDataResolver = require(DataHydration.createDataResolver)
local _DataHydrationTypes = require(DataHydration.DataHydrationTypes)
local VotesStoreTypes = require(script.Parent.VotesStoreTypes)
local VotesUtils = require(script.Parent.VotesUtils)
local DiscoveryUtils = require(DataHydrationParent.DiscoveryUtils)
local StatusCodes = require(DataHydrationParent.Http).StatusCodes
local logResponseError = DiscoveryUtils.logResponseError
local DiscoveryEventErrorLogger = DiscoveryUtils.DiscoveryEventErrorLogger
local fetchVotes = require(script.Parent.fetchVotes)
local fetchUserVote = require(script.Parent.fetchUserVote)
local requestUserVoteUpdate = require(script.Parent.requestUserVoteUpdate)
local SharedFlags = require(DataHydrationParent.SharedFlags)
local ReasonNotVoteable = VotesStoreTypes.ReasonNotVoteable

local FFlagLuaAppInExperienceDetailsPrompt = require(DataHydrationParent.SharedFlags).FFlagLuaAppInExperienceDetailsPrompt
local FFlagLuaAppDataHydrationUpdateItem = SharedFlags.FFlagLuaAppDataHydrationUpdateItem

local getGameInfoStore = require(DataHydration.Game.GameInfo.getGameInfoStore)

local num1 = game:DefineFastInt("USER_VOTE_CACHE_TTL_SECONDS", 600)

local function createVotesStore()
    local cache = createDataCache()
    local dataResolver = createDataResolver({
        cache = cache,
        fetchFn = function(tbl1)
            local var1 = Dash.keys(tbl1)
            return fetchVotes(var1):andThen(function(arg1)
                if not arg1 then
                    error("No response")
                end
                if not (arg1.responseBody and arg1.responseBody.data) then
                    if FFlagLuaAppInExperienceDetailsPrompt then
                        error(`Response Code: {arg1.responseCode}`)
                    else
                        error(`Response Code: {arg1.reponseCode}`)
                    end
                end

                local result = {}
                local data = arg1.responseBody.data
                Dash.forEach(data, function(arg2)
                    local upVotes = arg2.upVotes
                    local downVotes = arg2.downVotes
                    local rating = if typeof(upVotes) == "number" and typeof(downVotes) == "number" then VotesUtils.calculateRating(upVotes, downVotes) else nil
                    local tbl2 = result
                    local id = arg2.id
                    tbl2[tostring(id)] = {
                        upVotes = upVotes,
                        downVotes = downVotes,
                        rating = rating
                    }
                end)

                return result
            end):catch(function(arg1)
                error(`Error requesting votes: {arg1}`)
            end)
        end
    })

    local dataCache = createDataCache(num1)

    local dataResolver2 = createDataResolver({
        cache = dataCache,
        logError = function(arg1)
            logResponseError("v1/games/votes/user", arg1)
        end,
        fetchFn = function(universeId: string, _)
            return fetchUserVote(universeId):andThen(function(arg1)
                local responseBody = arg1.responseBody
                if not VotesStoreTypes.userVoteResponseValidator(responseBody) then
                    DiscoveryEventErrorLogger.reportError(
                        "createVotesStore",
                        "Invalid user vote response",
                        { universeId = universeId, responseBody = responseBody }
                    )
                    error({ StatusCode = arg1.responseCode })
                end
                return responseBody
            end)
        end,
        supportsMultiGet = false,
        supportsMutations = true
    })

    local function clear()
        cache.clear()
        dataResolver.clear()
        dataCache.clear()
        dataResolver2.clear()
    end

    local function dispose()
        cache.dispose()
        dataResolver.dispose()
        dataResolver2.dispose()
    end

    return {
        fetchVote = dataResolver.fetchItem,
        fetchVotes = dataResolver.fetchItems,
        getVote = dataResolver.getCachedItem,
        getVotes = dataResolver.getCachedItems,
        getAndFetchVote = dataResolver.getAndFetchItem,
        getAndFetchVotes = dataResolver.getAndFetchItems,
        fetchUserVote = dataResolver2.fetchItem,
        fetchUserVotes = dataResolver2.fetchItems,
        getUserVote = dataResolver2.getOptimisticCachedItem,
        getUserVotes = dataResolver2.getOptimisticCachedItems,
        getAndFetchUserVote = dataResolver2.getOptimisticAndFetchItem,
        getAndFetchUserVotes = dataResolver2.getOptimisticAndFetchItems,
        updateUserVote = function(universeId: string, userVote: boolean?)
            local var1, var2 = Signals.createSignal(nil)

            local var3, var4 = dataResolver2.getOptimisticCachedItem(universeId)
            local var5 = var3 and var3.data(false)
            local userVote2 = if var5 then var5.userVote else nil
            local item = cache.getItem(universeId)
            local var6 = item and item.data(false)
            if not var4 and var5 and not var5.canVote then
                var2({ type = "error", reasonForNotVoteable = var5.reasonForNotVoteable })

                return var1
            end
            local tbl1 = {
                userVote = if userVote == nil then Cryo.None else userVote
            }
            dataResolver2.setMutation(universeId, tbl1)

            if var6 then
                local num2 = (if userVote == true then 1 else 0) - (if userVote2 == true then 1 else 0)
                local num3 = (if userVote == false then 1 else 0) - (if userVote2 == false then 1 else 0)
                local var7 = var6.upVotes + num2
                local var8 = var6.downVotes + num3
                local upVotes = math.max(0, var7)
                local downVotes = math.max(0, var8)
                local tbl2 = {
                    upVotes = upVotes,
                    downVotes = downVotes,
                    rating = VotesUtils.calculateRating(upVotes, downVotes)
                }
                cache.updateItem(universeId, tbl2)
            end

            local var7 = getGameInfoStore(false).applyVoteChange(universeId, userVote2, userVote)

            requestUserVoteUpdate(universeId, userVote):andThen(function(_)
                dataResolver2.commitMutation(universeId)
                var2({ type = "success", userVote = userVote })
            end):catch(function(arg1)
                dataResolver2.clearMutation(universeId)

                if var6 then
                    cache.updateItem(universeId, var6)
                end

                if var7 then
                    getGameInfoStore(false).updateGameInfo(universeId, var7)
                end

                local statusCode = if type(arg1) == "table" and arg1.StatusCode then arg1.StatusCode else nil
                local var8 = nil
                if statusCode then
                    local success, result = pcall(function()
                        return HttpService:JSONDecode(arg1.Body)
                    end)
                    if success and result and result.errors then
                        for _, error in ipairs(result.errors) do
                            if error.code == VotesStoreTypes.PLAY_GAME_ERROR_CODE then
                                var8 = ReasonNotVoteable.PlayGame
                            end
                        end
                    end

                    if statusCode == StatusCodes.TOO_MANY_REQUESTS then
                        var8 = ReasonNotVoteable.FloodCheckThresholdMet
                    end
                end

                var2({ type = "error", reasonForNotVoteable = var8 })
                local statusMessage = if type(arg1) == "table" and arg1.StatusMessage then arg1.StatusMessage else nil
                DiscoveryEventErrorLogger.reportError(
                    "updateUserVote",
                    "Error updating user vote",
                    {
                        universeId = universeId,
                        statusCode = statusCode,
                        statusMessage = statusMessage
                    }
                )
                logResponseError("v1/games/votes/user-votes", { StatusCode = statusCode })
            end)
            return var1
        end,
        updateVoteItem = FFlagLuaAppDataHydrationUpdateItem and function(str1: string, downVotes: number, upVotes: number)
            cache.updateItem(
                str1,
                {
                    downVotes = downVotes,
                    upVotes = upVotes,
                    rating = VotesUtils.calculateRating(upVotes, downVotes)
                }
            )
        end or nil,
        updateVoteItems = function(tbl1)
            local tbl2 = ({})
            for value, value2 in tbl1 do
                local tbl3 = {
                    upVotes = value2.upVotes,
                    downVotes = value2.downVotes,
                    rating = VotesUtils.calculateRating(value2.upVotes, value2.downVotes)
                }
                tbl2[value] = tbl3
            end

            cache.updateItems(tbl2)
        end,
        updateUserVoteItem = if FFlagLuaAppDataHydrationUpdateItem then dataCache.updateItem else nil,
        updateUserVoteItems = dataCache.updateItems,
        clear = clear,
        dispose = dispose
    }
end

return createVotesStore
