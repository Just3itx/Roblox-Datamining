-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T05:11:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DataHydration = script:FindFirstAncestor("DataHydration")
local DataHydrationParent = DataHydration.Parent

local Cryo = require(DataHydrationParent.Cryo)
local createDataCache = require(DataHydration.createDataCache)
local createDataResolver = require(DataHydration.createDataResolver)
local _DataHydrationTypes = require(DataHydration.DataHydrationTypes)
local ProfileInsightsModel = require(DataHydrationParent.ProfileInsights).ProfileInsightsModel

local MultiGetProfileInsights = require(script.Parent.Requests.MultiGetProfileInsights)
local _ProfileInsightsStoreTypes = require(script.Parent.ProfileInsightsStoreTypes)

local FFlagProfileInsightsKeyByRankingStrategy = require(DataHydrationParent.SharedFlags).FFlagProfileInsightsKeyByRankingStrategy

local queueProcessDelaySec = game:DefineFastInt("ProfileInsightsStoreProcessDelaySec", 0)

local function createInsightBucket()
    local cache = createDataCache()
    local pendingFetchOptions = ({})

    return {
        resolver = createDataResolver({
            cache = cache,
            queueProcessDelaySec = queueProcessDelaySec,
            replaceItems = true,
            onClear = function()
                table.clear(pendingFetchOptions)
            end,
            fetchFn = function(tbl2)
                local userIds = Cryo.Dictionary.keys(tbl2)

                local rankingStrategy = nil
                local count = nil
                for _, value in userIds do
                    local var2 = pendingFetchOptions[value]
                    if not var2 then
                        continue
                    end

                    if rankingStrategy == nil then
                        rankingStrategy = var2.rankingStrategy
                    end
                    if count == nil then
                        count = var2.count
                    end
                    pendingFetchOptions[value] = nil
                end

                return MultiGetProfileInsights({ userIds = userIds, count = count, rankingStrategy = rankingStrategy }):andThen(function(arg1)
                    local profileInsightsList = ProfileInsightsModel.createProfileInsightsList(if arg1 then arg1.userInsights else nil)

                    local result = ({})
                    for _, targetUserId in userIds do
                        result[targetUserId] = {
                            targetUserId = targetUserId,
                            isOfflineFrequents = false,
                            mutualFriends = {}
                        }
                    end
                    for _, profileInsight in profileInsightsList do
                        if result[profileInsight.targetUserId] ~= nil then
                            result[profileInsight.targetUserId] = profileInsight
                        end
                    end

                    return result
                end)
            end
        }),
        pendingFetchOptions = pendingFetchOptions
    }
end

return if FFlagProfileInsightsKeyByRankingStrategy then function() -- name: createProfileInsightsStoreKeyedByRankingStrategy
    local tbl1 = ({})

    local function getBucket(str1: string?) -- Luacid: Inlined by compiler; 1 call site recovered
        local str2 = str1 or ""
        local var1 = tbl1[str2]
        if var1 == nil then
            var1 = createInsightBucket()
            tbl1[str2] = var1
        end
        return var1
    end

    return {
        GetProfileInsight = function(arg1, arg2)
            local rankingStrategy = if arg2 then arg2.rankingStrategy else nil
            local bucket = getBucket(rankingStrategy)

            if arg2 and arg2.skipFetch then
                return bucket.resolver.getCachedItem(arg1)
            end
            if arg2 then
                bucket.pendingFetchOptions[arg1] = {
                    rankingStrategy = arg2.rankingStrategy,
                    count = arg2.count
                }
            end
            return bucket.resolver.getAndFetchItem(arg1)
        end,
        clear = function()
            for _, value in tbl1 do
                value.resolver.clear()
            end
        end,
        dispose = function()
            for _, value in tbl1 do
                value.resolver.dispose()
            end
        end
    }
end else function() -- name: createProfileInsightsStore
    local cache = createDataCache()

    local tbl1 = ({})

    local dataResolver = createDataResolver({
        cache = cache,
        queueProcessDelaySec = queueProcessDelaySec,
        fetchFn = function(tbl2)
            local userIds = Cryo.Dictionary.keys(tbl2)

            local rankingStrategy = nil
            local count = nil
            for _, value in userIds do
                local var2 = tbl1[value]
                if not var2 then
                    continue
                end

                if rankingStrategy == nil then
                    rankingStrategy = var2.rankingStrategy
                end
                if count == nil then
                    count = var2.count
                end
                tbl1[value] = nil
            end

            return MultiGetProfileInsights({ userIds = userIds, count = count, rankingStrategy = rankingStrategy }):andThen(function(arg1)
                local profileInsightsList = ProfileInsightsModel.createProfileInsightsList(if arg1 then arg1.userInsights else nil)

                local result = ({})
                for _, targetUserId in userIds do
                    result[targetUserId] = {
                        targetUserId = targetUserId,
                        isOfflineFrequents = false,
                        mutualFriends = {}
                    }
                end
                for _, profileInsight in profileInsightsList do
                    if result[profileInsight.targetUserId] ~= nil then
                        result[profileInsight.targetUserId] = profileInsight
                    end
                end

                return result
            end)
        end
    })

    return {
        GetProfileInsight = function(arg1, arg2)
            if arg2 and arg2.skipFetch then
                return dataResolver.getCachedItem(arg1)
            end
            if arg2 then
                tbl1[arg1] = {
                    rankingStrategy = arg2.rankingStrategy,
                    count = arg2.count
                }
            end
            return dataResolver.getAndFetchItem(arg1)
        end,
        clear = cache.clear,
        dispose = cache.dispose
    }
end
