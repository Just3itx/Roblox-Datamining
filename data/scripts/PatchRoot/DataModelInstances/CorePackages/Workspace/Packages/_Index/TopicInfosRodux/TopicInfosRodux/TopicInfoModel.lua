-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T00:19:41Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local TopicInfosRoduxParent = script:FindFirstAncestor("TopicInfosRodux").Parent
local DiscoveryTypes = require(TopicInfosRoduxParent.DiscoveryTypes)
local FFlagEnableTopSongsSort = require(TopicInfosRoduxParent.SharedFlags).FFlagEnableTopSongsSort

local tbl1 = {
    default = "LuaApp/category/filter_default",
    Featured = "LuaApp/category/filter_featured",
    FriendActivity = "LuaApp/category/filter_friendsplaying",
    MyFavorite = "LuaApp/category/filter_myfavorites",
    MyRecent = "LuaApp/category/filter_continueplaying",
    Popular = "LuaApp/category/filter_popular",
    PopularInCountry = "LuaApp/category/filter_popularnearyou",
    TopGrossing = "LuaApp/category/filter_topearning",
    TopRated = "LuaApp/category/filter_toprated",
    TopRetaining = "LuaApp/category/filter_recommended"
}

local module = ({})
module.__index = module

function module.new()
    local tbl2 = {
        dataSource = DiscoveryTypes.DataSourceType.Unknown
    }

    setmetatable(tbl2, module)

    return tbl2
end

function module.mockFromExploreJsonData(sortId, treatmentType, gameSetTypeId)
    return (module.fromExploreJsonData({
        sortDisplayName = "",
        sortId = sortId,
        gameSetTargetId = 0,
        gameSetTypeId = gameSetTypeId or 0,
        topicLayoutData = {},
        treatmentType = treatmentType
    }))
end

function module.mockFromOmniApi(topicId)
    return (module.fromOmniApi({ topicId = topicId, topic = "", treatmentType = "" }))
end

function module.fromExploreJsonData(arg1)
    local module2 = module.new()
    module2.dataSource = DiscoveryTypes.DataSourceType.ExploreApi
    module2.displayName = arg1.sortDisplayName
    module2.name = arg1.sortId
    module2.subtitle = arg1.subtitle
    module2.token = ""
    module2.gameSetTargetId = arg1.gameSetTargetId
    module2.gameSetTypeId = tostring(arg1.gameSetTypeId)
    module2.topicLayoutData = arg1.topicLayoutData
    module2.treatmentType = arg1.treatmentType
    module2.appliedFilters = arg1.appliedFilters
    module2.subtitle = arg1.subtitle

    if FFlagEnableTopSongsSort then
        module2.contentType = arg1.contentType
    end

    if module2.name ~= nil then
        module2.displayIcon = tbl1[module2.name]
    end
    if module2.displayIcon == nil then
        module2.displayIcon = "LuaApp/category/filter_default"
    end

    module2.uniqueKey = module2.name
    module2.analyticsTypeId = module2.gameSetTypeId

    return module2
end

function module.fromOmniApi(arg1)
    local module2 = module.new()
    module2.dataSource = DiscoveryTypes.DataSourceType.DiscoveryApi
    module2.displayName = arg1.topic
    module2.topicId = tostring(arg1.topicId)
    module2.subtitle = arg1.subtitle
    module2.sortSubId = arg1.sortSubId
    module2.analyticsData = arg1.analyticsData
    module2.treatmentType = arg1.treatmentType

    module2.uniqueKey = module2.topicId
    module2.analyticsTypeId = module2.topicId

    return module2
end

function module.fromOmniAutocompleteApi(arg1)
    local module2 = module.new()
    module2.dataSource = DiscoveryTypes.DataSourceType.OmniAutocompleteApi
    module2.displayName = arg1.sortDisplayName
    module2.name = arg1.sortId
    module2.topicLayoutData = arg1.topicLayoutData or {}

    module2.uniqueKey = module2.name
    module2.analyticsTypeId = module2.name
    module2.gameSetTypeId = module2.name

    return module2
end

function module.makeTopSearchTopicKey(arg1, arg2): string
    return `{arg1}_{arg2}`
end

function module.fromTopSearchApi(tbl2, searchUuid: string)
    local module2 = module.new()
    module2.dataSource = DiscoveryTypes.DataSourceType.SearchApi
    module2.topicId = tostring(tbl2.topicId)
    module2.treatmentType = tbl2.treatmentType
    module2.topicLayoutData = tbl2.topicLayoutData or {}
    module2.searchUuid = searchUuid

    module2.uniqueKey = module.makeTopSearchTopicKey(module2.searchUuid, module2.topicId)
    module2.analyticsTypeId = module2.uniqueKey

    return module2
end

function module.makeSearchTopicKey(arg1, arg2)
    return module.makeTopSearchTopicKey(arg1, arg2)
end

function module.fromSearchApi(tbl2, str1: string)
    return module.fromTopSearchApi(tbl2, str1)
end

function module:isOmni(): boolean
    return self.dataSource == DiscoveryTypes.DataSourceType.DiscoveryApi
end

function module.isSponsored(arg1): boolean
    return arg1.topicId == "400000000" or arg1.gameSetTypeId == "27"
end

return module
