-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T11:11:08Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DiscoveryUtils = script:FindFirstAncestor("DiscoveryUtils")
local DiscoveryClientAppStorage = require(DiscoveryUtils.DiscoveryClientAppStorage)
local DiscoveryEventErrorLogger = require(DiscoveryUtils.Telemetry.DiscoveryEventErrorLogger)

local str1 = game:DefineFastString(
    "LuaAppOmniRecommendationsTopicIdAndNumberOfItemsToCache",
    `{100000000}:20,{100000001}:20,{100000003}:20`
)

return {
    cacheOmniRecommendationsData = function(arg1)
        assert(arg1.pageType, "pageType is required")
        assert(arg1.sorts, "sorts is required")
        assert(arg1.contentMetadata, "contentMetadata is required")
        assert(arg1.contentMetadata.Game, "contentMetadata.Game is required")

        task.spawn(function()
            local success, result = pcall(function()
                local tbl1 = ({})

                for _, value in string.split(str1, ",") do
                    local tbl2 = string.split(value, ":")
                    local var1 = tonumber(tbl2[1])
                    local cap = tonumber(tbl2[2])
                    if var1 and cap then
                        tbl1[var1] = { cap = cap, count = 0 }
                    end
                end

                local sorts = {}

                for _, sort in arg1.sorts do
                    local var1 = tbl1[sort.topicId]
                    if var1 == nil or sort.recommendationList == nil then
                        continue
                    end

                    local var2 = table.clone(sort)

                    if var1.count >= var1.cap then
                        continue
                    end

                    local recommendationList = {}
                    for _, value in sort.recommendationList do
                        if var1.count >= var1.cap then
                            break
                        end

                        table.insert(recommendationList, value)
                        var1.count += 1
                    end
                    var2.recommendationList = recommendationList

                    table.insert(sorts, var2)
                end

                local game = ({})
                for _, value in ipairs(sorts) do
                    for _, value2 in ipairs(value.recommendationList) do
                        if value2.contentType ~= "Game" then
                            continue
                        end

                        local str2 = tostring(value2.contentId)
                        local var1 = arg1.contentMetadata.Game[str2]
                        if var1 then
                            local var2 = table.clone(var1)
                            var2.playerCount = nil

                            game[str2] = var2
                        end
                    end
                end

                DiscoveryClientAppStorage.setJsonStorageData(
                    DiscoveryClientAppStorage.CacheKey.HomeOmniFeedCache,
                    {
                        pageType = arg1.pageType,
                        sorts = sorts,
                        contentMetadata = { Game = game }
                    },
                    2
                )
            end)
            if not success then
                DiscoveryEventErrorLogger.reportError("HomeOmniFeedCacheError", result)
            end
        end)
    end,
    getTopicIdToNumCacheItems = function()
        local topicIdToNumCacheItems = {}
        for _, value in string.split(str1, ",") do
            local tbl1 = string.split(value, ":")
            local var1 = tonumber(tbl1[1])
            local cap = tonumber(tbl1[2])
            if var1 and cap then
                topicIdToNumCacheItems[tostring(var1)] = { cap = cap, count = 0 }
            end
        end
        return topicIdToNumCacheItems
    end,
    HOME_OMNI_FEED_CACHE_VERSION = 2,
    cacheSduiHomePageData = function(str2: string)
        task.spawn(function()
            local success, result = pcall(function()
                DiscoveryClientAppStorage.setJsonStorageData(DiscoveryClientAppStorage.CacheKey.HomeOmniFeedCache, str2, 3)
            end)

            if not success then
                DiscoveryEventErrorLogger.reportError("HomeSduiFeedCacheError", result)
            end
        end)
    end,
    getCachedSduiHomePageData = function(): string?
        local jsonStorageData = DiscoveryClientAppStorage.getJsonStorageData(DiscoveryClientAppStorage.CacheKey.HomeOmniFeedCache, 3)

        return if type(jsonStorageData) == "string" then jsonStorageData else nil
    end,
    HOME_SDUI_FEED_CACHE_VERSION = 3
}
