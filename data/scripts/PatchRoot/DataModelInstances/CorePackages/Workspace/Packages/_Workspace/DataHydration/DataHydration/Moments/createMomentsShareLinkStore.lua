-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T04:41:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DataHydration = script:FindFirstAncestor("DataHydration")
local DataHydrationParent = DataHydration.Parent

local HttpClient = require(DataHydrationParent.HttpClient)
local createDataCache = require(DataHydration.createDataCache)
local createDataResolver = require(DataHydration.createDataResolver)
local _DataHydrationTypes = require(DataHydration.DataHydrationTypes)
local _MomentsStoreTypes = require(script.Parent.MomentsStoreTypes)
local fetchShareLink = require(script.Parent.Requests.fetchShareLink)

local function shouldRefreshCachedShareLink(str1: string?): boolean
    return str1 == nil
end

local function createMomentsShareLinkStore(arg1)
    local var1 = arg1 or {}

    local tbl1 = ({})
    local tbl2 = ({})
    local tbl3 = ({})
    local cache = createDataCache()
    local dataResolver = createDataResolver({
        cache = cache,
        supportsMultiGet = false,
        replaceItems = true,
        fetchFn = function(momentId: string, _)
            return HttpClient.asPromise(
                fetchShareLink(
                    {
                        momentId = momentId,
                        feedItemId = tbl3[momentId],
                        description = tbl1[momentId],
                        title = tbl2[momentId]
                    },
                    var1.network
                )
            )
        end
    })

    local function setRequestParams(str1: string, str2: string?, str3: string?, str4: string?): string -- Luacid: Inlined by compiler; 2 call sites recovered
        tbl1[str1] = str2
        tbl2[str1] = str3
        tbl3[str1] = str4
        return str1
    end

    return {
        getCachedShareLink = function(str1: string)
            return dataResolver.getCachedItem(str1)
        end,
        fetchShareLink = function(str1: string, str2: string?, str3: string?, str4: string?)
            local fetchItem = dataResolver.fetchItem
            setRequestParams(str1, str2, str3, str4)
            return fetchItem(str1)
        end,
        getAndFetchShareLink = function(str1: string, str2: string?, str3: string?, str4: string?)
            local getAndFetchItem = dataResolver.getAndFetchItem
            setRequestParams(str1, str2, str3, str4)
            return getAndFetchItem(str1, shouldRefreshCachedShareLink)
        end,
        clear = function()
            tbl1 = {}
            tbl2 = {}
            tbl3 = {}
            dataResolver.clear()
        end,
        dispose = function()
            tbl1 = {}
            tbl2 = {}
            tbl3 = {}
            dataResolver.dispose()
        end
    }
end
return createMomentsShareLinkStore
