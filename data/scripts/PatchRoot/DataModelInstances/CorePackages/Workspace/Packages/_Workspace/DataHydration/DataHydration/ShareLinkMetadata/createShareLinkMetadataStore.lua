-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T05:11:16Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DataHydration = script:FindFirstAncestor("DataHydration")
local DataHydrationParent = DataHydration.Parent

local _HttpClient = require(DataHydrationParent.HttpClient)

local createDataCache = require(DataHydration.createDataCache)
local createDataResolver = require(DataHydration.createDataResolver)
local _DataHydrationTypes = require(DataHydration.DataHydrationTypes)
local fetchShareLinkMetadata = require(script.Parent.fetchShareLinkMetadata)
local _ShareLinkMetadataStoreTypes = require(script.Parent.ShareLinkMetadataStoreTypes)

local function createShareLinkMetadataStore(tbl1)
    local tbl2 = tbl1 or {}
    local tbl3 = ({})

    local cache = createDataCache(tbl2.ttlSeconds, tbl2.failedTtlSeconds)
    local dataResolver = createDataResolver({
        cache = cache,
        supportsMultiGet = false,
        replaceItems = true,
        logError = tbl2.logError,
        fetchFn = function(str1: string, _)
            local var1 = tbl3[str1]
            if var1 == nil then
                error(`Missing link type for {str1}`)
            end
            return fetchShareLinkMetadata(str1, var1, { network = tbl2.network, baseUrl = tbl2.baseUrl })
        end
    })

    local function setLinkType(str1: string, str2: string): string -- Luacid: unused: defined but never referenced
        tbl3[str1] = str2
        return str1
    end

    return {
        getShareLinkMetadata = dataResolver.getCachedItem,
        fetchShareLinkMetadata = function(arg1, arg2)
            local fetchItem = dataResolver.fetchItem
            tbl3[arg1] = arg2

            return fetchItem(arg1)
        end,
        getAndFetchShareLinkMetadata = function(arg1, arg2)
            local getAndFetchItem = dataResolver.getAndFetchItem
            tbl3[arg1] = arg2

            return getAndFetchItem(arg1)
        end,
        clear = function()
            tbl3 = {}
            dataResolver.clear()
        end,
        dispose = function()
            tbl3 = {}
            dataResolver.dispose()
        end
    }
end
return createShareLinkMetadataStore
