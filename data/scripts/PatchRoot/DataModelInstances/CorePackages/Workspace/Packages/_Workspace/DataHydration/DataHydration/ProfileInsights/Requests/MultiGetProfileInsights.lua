-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T05:11:07Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DataHydrationParent = script:FindFirstAncestor("DataHydration").Parent

local HttpClient = require(DataHydrationParent.HttpClient)
local Http = require(DataHydrationParent.Http)

local _ProfileInsightsStoreTypes = require(script.Parent.Parent.ProfileInsightsStoreTypes)

local fetch = HttpClient.fetch
local asPromise = HttpClient.asPromise

return function(arg1, network)
    local var1 = fetch({
        method = "POST",
        url = `{Http.Url.APIS_URL}profile-insights-api/v1/multiProfileInsights`,
        body = {
            userIds = arg1.userIds,
            count = arg1.count,
            rankingStrategy = arg1.rankingStrategy
        },
        network = network,
        analyticsKey = "profile-insights.multi-profile-insights",
        decode = function<T>(arg2: T): T
            return arg2
        end
    })
    return asPromise(var1)
end
