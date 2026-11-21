-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T17:30:45Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameCollectionsParent = script:FindFirstAncestor("GameCollections").Parent
local RetrievalStatus = require(GameCollectionsParent.Http).Enum.RetrievalStatus
local tutils = require(GameCollectionsParent.tutils)
local useSelector = require(GameCollectionsParent.RoactUtils).Hooks.RoactRodux.useSelector
local AppPage = require(GameCollectionsParent.RobloxAppEnums).AppPage
local memoize = require(GameCollectionsParent.AppCommonLib).memoize
local TopicInfosRodux = require(GameCollectionsParent.TopicInfosRodux)
local TopicInfosReducer = TopicInfosRodux.TopicInfosReducer
local TopicInfoModel = TopicInfosRodux.TopicInfoModel
local GameSortGroups = require(GameCollectionsParent.DiscoveryTypes).GameSortGroups
local FetchStatusRodux = require(GameCollectionsParent.FetchStatusRodux)
local FetchStatusReducer = FetchStatusRodux.FetchStatusReducer
local FetchStatusNamespace = FetchStatusRodux.FetchStatusNamespace
local TopicContentsReducer = require(GameCollectionsParent.TopicContentsRodux).TopicContentsReducer
local LoggingProtocol = require(GameCollectionsParent.LoggingProtocol)
local reportWarning = require(GameCollectionsParent.DiscoveryAnalytics).Points.reportWarning
local getTopSearchResultsFetchName = require(GameCollectionsParent.DiscoveryUtils).getTopSearchResultsFetchName

local var1 = memoize(function(arg1)
    local result = {}
    if arg1 and arg1.sorts then
        for i, sort in ipairs(arg1.sorts) do
            if sort.topicId then
                local topicId = sort.topicId
                result[tostring(topicId)] = i
            end
        end
    end
    return result
end)

local function useGameSortData(str1: string, str2: string, str3: string?)
    return useSelector(function(arg1)
        local bool1 = false
        local bool2 = false
        local var2 = nil
        local pageId = nil
        local var3 = arg1.Personalization[TopicInfosReducer.key][str1]

        if var3 ~= nil then
            if var3:isOmni() then
                if str2 == AppPage.Home then
                    local omniRecommendation = arg1.OmniRecommendations[str2]
                    local var4 = var1(omniRecommendation)[str1]
                    if var4 then
                        var2 = var4
                        bool2 = true
                        bool1 = true
                    end
                end
            else
                bool1 = true

                local var4 = nil
                if str2 == AppPage.Games then
                    var4 = GameSortGroups.Games
                elseif str2 == AppPage.Home then
                    var4 = GameSortGroups.HomeGames
                end

                if var4 then
                    pageId = arg1.GameSortGroups[var4].pageId
                else
                    pageId = nil
                end
            end
        end
        local var4 = nil
        local var5 = nil
        local var6 = nil
        if str2 ~= AppPage.SearchPage then
            var4 = arg1.Personalization[TopicContentsReducer.key][str1]
            var5 = arg1.Personalization[TopicInfosReducer.key][str1]
            local var7, var8

            if bool2 then
                var7 = FetchStatusNamespace.OmniRecommendations
                var8 = str2
            else
                var7 = FetchStatusNamespace.GameSorts
                var8 = str1
            end

            var6 = arg1.Personalization[FetchStatusReducer.key][var7][var8]
        elseif str3 then
            var4 = arg1.Personalization[TopicContentsReducer.key][str3]
            local searchTopicKey = TopicInfoModel.makeSearchTopicKey(str3, str1)
            var5 = arg1.Personalization[TopicInfosReducer.key][searchTopicKey]

            bool1 = true

            local var7 = arg1.RequestsStatus.SearchesInGamesStatus[str3]

            if var7 == "Removed" then
                var7 = RetrievalStatus.NotStarted
            end
            local var8 = arg1.FetchingStatus[getTopSearchResultsFetchName("blended", str3)]
            var6 = var7 or var8
        else
            reportWarning(
                LoggingProtocol.default,
                "useGameSortData_MissingSearchUuid",
                "searchUuid is nil when pageContext is SearchPage"
            )
            bool1 = false
        end

        return {
            sortIndex = var2,
            isOmni = bool2,
            gameSortDataFound = bool1,
            gamesApiSortPageId = pageId,
            sort = var5,
            gameSortContents = var4,
            gameSortFetchingStatus = var6 or RetrievalStatus.NotStarted
        }
    end, tutils.shallowEqual)
end

return useGameSortData
