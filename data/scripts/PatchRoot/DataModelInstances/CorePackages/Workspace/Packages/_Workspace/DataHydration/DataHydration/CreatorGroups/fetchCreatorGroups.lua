-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T03:41:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DataHydrationParent = script:FindFirstAncestor("DataHydration").Parent

local HttpClient = require(DataHydrationParent.HttpClient)
local UrlBase = require(DataHydrationParent.UrlBuilder).UrlBase

local _CreatorGroupsStoreTypes = require(script.Parent.CreatorGroupsStoreTypes)

local fetch = HttpClient.fetch
local asPromise = HttpClient.asPromise

local function fetchCreatorGroups(arg1, tbl1)
    local tbl2 = tbl1 or {}
    local var1 = tbl2.baseUrl or UrlBase.APIS
    local var2 = fetch({
        network = tbl2.network,
        method = "GET",
        url = ("%s/creator-home-api/v1/groups?surface=%s"):format(var1, arg1),
        analyticsKey = "creator-home.groups",
        decode = function<T>(arg2: T): T
            return arg2
        end
    })
    return asPromise(var2)
end

return fetchCreatorGroups
