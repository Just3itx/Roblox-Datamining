-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T10:50:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfileInsightsParent = script:FindFirstAncestor("ProfileInsights").Parent
local Signals = require(ProfileInsightsParent.Signals)
local createSignal = Signals.createSignal
local createComputed = Signals.createComputed
local ProfileInsightsModel = require(script.Parent.ProfileInsightsModel)
local HttpService = game:GetService("HttpService")

local Timeout = game:DefineFastInt("ProfileInsightsStoreHttpTimeout", 1500)

local FFlagAddFriendsPageTrustedFriendRequestSection = require(ProfileInsightsParent.SharedFlags).FFlagAddFriendsPageTrustedFriendRequestSection

local FFlagProfileInsightsSkipFetchNoCacheEntry = require(ProfileInsightsParent.SharedFlags).FFlagProfileInsightsSkipFetchNoCacheEntry
local FFlagUserSearchClassmatesInsight = require(ProfileInsightsParent.SharedFlags).FFlagUserSearchClassmatesInsight

local UrlBuilder = require(ProfileInsightsParent.UrlBuilder)
local UrlBuilder2 = UrlBuilder.UrlBuilder
local UrlBase = UrlBuilder.UrlBase
local Url = UrlBuilder2.new({ base = UrlBase.APIS, path = "profile-insights-api/v1/multiProfileInsights" })()

local function makeHttpCall(userIds, count: number?, rankingStrategy: string?, func1: (...any) -> (...any))
    HttpService:RequestInternal({
        Url = Url,
        Method = "POST",
        Body = HttpService:JSONEncode({
            userIds = userIds,
            count = FFlagUserSearchClassmatesInsight and count or not rankingStrategy and (count or 2) or nil,
            rankingStrategy = rankingStrategy
        }),
        Timeout = Timeout,
        CachePolicy = Enum.HttpCachePolicy.None,
        Priority = 0,
        Headers = { ["Content-Type"] = "application/json", Accept = "application/json" },
        RequestType = Enum.HttpRequestType.Default
    }):Start(
        function(arg1, arg2)
            local success, result

            if arg2 and arg2.Body then
                success, result = pcall(function()
                    return HttpService:JSONDecode(arg2.Body)
                end)
            else
                success = false
                result = nil
            end

            local func2 = func1

            if not arg1 then
                success = false
            end

            func2(success, result)
        end
    )
end

local function createFetchResult(status: string, arg1) -- Luacid: Inlined by compiler; 12 call sites recovered
    return { status = status, data = arg1 }
end

return createComputed(function(_)
    local tbl1 = ({})

    local tbl2 = ({})

    local profileInsightsSignalList = ProfileInsightsModel.createProfileInsightsSignalList()

    local function getCacheKey(userIds, count: number?, rankingStrategy: string?): string -- Luacid: Inlined by compiler; 2 call sites recovered
        return table.concat(userIds, ",") .. tostring(count) .. tostring(rankingStrategy)
    end

    local function mergeWithExisting(str1: string, tbl3)
        local var2 = tbl2[str1]
        if not var2 then
            return tbl3
        end

        local tbl4 = {}

        local tbl5 = { table.unpack(var2.getProfileInsights(false)) }
        local bool1 = false
        for _, value in tbl5 do
            tbl4[value.targetUserId] = true
        end
        for _, value in tbl3 do
            if not tbl4[value.targetUserId] then
                tbl4[value.targetUserId] = true
                table.insert(tbl5, value)
                bool1 = true
            end
        end

        if bool1 then
            return tbl5
        end

        return (var2.getProfileInsights(false))
    end

    return {
        getProfileInsightsByUserId = function(tbl3)
            local userIds = tbl3.userIds
            local count = tbl3.count
            local rankingStrategy = tbl3.rankingStrategy
            if not userIds or #userIds == 0 then
                local fetchResult = createFetchResult("success", {})
                return createSignal(fetchResult)
            end

            local cacheKey = getCacheKey(userIds, count, rankingStrategy)

            if FFlagProfileInsightsSkipFetchNoCacheEntry
                and FFlagAddFriendsPageTrustedFriendRequestSection
                and tbl3.skipFetch
                and not tbl1[cacheKey]
            then
                local fetchResult = createFetchResult("success", profileInsightsSignalList)
                return createSignal(fetchResult)
            end
            if tbl1[cacheKey] and not tbl3.forceFetch then
                return createSignal((createFetchResult("success", tbl1[cacheKey])))
            end
            if not tbl1[cacheKey] then
                tbl1[cacheKey] = ProfileInsightsModel.createProfileInsightsSignalList()
            end

            if FFlagAddFriendsPageTrustedFriendRequestSection and tbl3.skipFetch then
                return createSignal((createFetchResult("success", tbl1[cacheKey])))
            end

            local fetchResult = createFetchResult("fetching", tbl1[cacheKey])

            local var2, var3 = createSignal(fetchResult)
            makeHttpCall(userIds, count, rankingStrategy, function(arg1, arg2)
                if arg1 and arg2.userInsights then
                    tbl1[cacheKey].setProfileInsights(ProfileInsightsModel.createProfileInsightsList(arg2.userInsights))

                    local fetchResult2 = createFetchResult("success", tbl1[cacheKey])
                    var3(fetchResult2)
                    return
                end
                var3((createFetchResult("failed", tbl1[cacheKey])))
            end)

            return var2
        end,
        getProfileInsightsByPage = function(tbl3)
            local var2 = if tbl3.pageId then tbl3.pageId else HttpService:GenerateGUID(false)
            local userIds = tbl3.userIds
            local count = tbl3.count
            local rankingStrategy = tbl3.rankingStrategy
            if not tbl2[var2] then
                tbl2[var2] = ProfileInsightsModel.createProfileInsightsSignalList()
            end

            if not userIds or #userIds == 0 then
                return createSignal((createFetchResult("success", tbl2[var2])))
            end

            local cacheKey = getCacheKey(userIds, count, rankingStrategy)

            if tbl1[cacheKey] then
                tbl2[var2].setProfileInsights((mergeWithExisting(var2, tbl1[cacheKey].getProfileInsights(false))))
                return createSignal((createFetchResult("success", tbl2[var2])))
            end

            tbl1[cacheKey] = ProfileInsightsModel.createProfileInsightsSignalList()
            local var3, var4 = createSignal((createFetchResult("success", tbl2[var2])))
            makeHttpCall(userIds, count, rankingStrategy, function(arg1, arg2)
                if arg1 and arg2.userInsights then
                    local profileInsightsList = ProfileInsightsModel.createProfileInsightsList(arg2.userInsights)

                    tbl1[cacheKey].setProfileInsights(profileInsightsList)

                    tbl2[var2].setProfileInsights((mergeWithExisting(var2, profileInsightsList)))
                    var4((createFetchResult("success", tbl2[var2])))
                    return
                end
                local fetchResult = createFetchResult("failed", {})
                var4(fetchResult)
            end)

            return var3
        end
    }
end)
