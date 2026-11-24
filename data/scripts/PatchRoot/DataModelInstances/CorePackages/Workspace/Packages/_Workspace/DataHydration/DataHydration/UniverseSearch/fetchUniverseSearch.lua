-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T05:30:47Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DataHydration = script:FindFirstAncestor("DataHydration")
local DataHydrationParent = DataHydration.Parent

local HttpClient = require(DataHydrationParent.HttpClient)
local UrlBuilder = require(DataHydrationParent.UrlBuilder)
local UrlBase = UrlBuilder.UrlBase

local withCsrfRetry = require(DataHydration.withCsrfRetry)
local FFlagBuildWithGroups = require(DataHydrationParent.SharedFlags).FFlagBuildWithGroups
local _UniverseSearchStoreTypes = require(script.Parent.UniverseSearchStoreTypes)

local fetch = HttpClient.fetch
local asPromise = HttpClient.asPromise

local function fetchUniverseSearch(arg1, tbl1)
    local tbl2 = tbl1 or {}
    local var1 = tbl2.baseUrl or UrlBase.APIS

    if FFlagBuildWithGroups and arg1.creators ~= nil then
        local var2 = fetch({
            network = withCsrfRetry(tbl2.network or HttpClient.createRequestInternalNetwork()),
            method = "POST",
            url = var1 .. "/universes/v1/search",
            body = {
                creators = arg1.creators,
                surface = arg1.surface,
                search = arg1.search,
                isArchived = arg1.isArchived,
                isPublic = arg1.isPublic,
                isShared = arg1.isShared,
                isTeamCreateEnabled = arg1.isTeamCreateEnabled,
                sortParam = arg1.sortParam,
                sortOrder = arg1.sortOrder,
                needsAssetOptions = arg1.needsAssetOptions,
                limit = arg1.pageSize,
                cursor = arg1.cursor
            },
            analyticsKey = "universes-search.multi-creator-search",
            decode = function<T>(arg2: T): T
                return arg2
            end
        })
        return asPromise(var2)
    end

    local tbl3 = {}
    if arg1.creatorType ~= nil then
        tbl3.CreatorType = arg1.creatorType
    end
    if arg1.creatorTargetId ~= nil then
        tbl3.CreatorTargetId = arg1.creatorTargetId
    end
    if arg1.surface ~= nil then
        tbl3.Surface = arg1.surface
    end
    if arg1.search ~= nil then
        tbl3.Search = arg1.search
    end
    if arg1.isArchived ~= nil then
        tbl3.IsArchived = tostring(arg1.isArchived)
    end
    if arg1.isPublic ~= nil then
        tbl3.IsPublic = tostring(arg1.isPublic)
    end
    if arg1.isShared ~= nil then
        tbl3.IsShared = tostring(arg1.isShared)
    end
    if arg1.isTeamCreateEnabled ~= nil then
        tbl3.IsTeamCreateEnabled = tostring(arg1.isTeamCreateEnabled)
    end
    if arg1.sortParam ~= nil then
        tbl3.SortParam = arg1.sortParam
    end
    if arg1.sortOrder ~= nil then
        tbl3.SortOrder = arg1.sortOrder
    end
    if arg1.needsAssetOptions ~= nil then
        tbl3.NeedsAssetOptions = tostring(arg1.needsAssetOptions)
    end
    if arg1.pageIndex ~= nil then
        tbl3.PageIndex = arg1.pageIndex
    end
    if arg1.pageSize ~= nil then
        tbl3.PageSize = arg1.pageSize
    end

    local var2 = fetch({
        network = tbl2.network,
        method = "GET",
        url = UrlBuilder.UrlBuilder.addQueryString(var1 .. "/universes/v1/search", tbl3),
        analyticsKey = "universes-search.search",
        decode = function<T>(arg2: T): T
            return arg2
        end
    })
    return asPromise(var2)
end

return fetchUniverseSearch
