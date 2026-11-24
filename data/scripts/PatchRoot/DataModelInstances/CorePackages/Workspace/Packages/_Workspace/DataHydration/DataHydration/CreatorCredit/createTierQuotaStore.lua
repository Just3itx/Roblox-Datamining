-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T03:40:51Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DataHydration = script:FindFirstAncestor("DataHydration")
local DataHydrationParent = DataHydration.Parent

local HttpClient = require(DataHydrationParent.HttpClient)

local createDataCache = require(DataHydration.createDataCache)
local createDataResolver = require(DataHydration.createDataResolver)
local _DataHydrationTypes = require(DataHydration.DataHydrationTypes)
local responseDecoders = require(script.Parent.responseDecoders)
local _types = require(script.Parent.types)

local tbl1 = { default = "MODEL_TIER_DEFAULT", advanced = "MODEL_TIER_ADVANCED" }

local function createTierQuotaStore(tbl2)
    local cache = createDataCache(tbl2.ttlSeconds, tbl2.ttlSeconds)
    local tbl3 = ({})
    local bool1 = false
    local str1 = if string.find(tbl2.quotaSummaryUrl, "?", 1, true) then "&" else "?"
    local dataResolver = createDataResolver({
        cache = cache,
        supportsMultiGet = false,
        replaceItems = true,
        ignoreResponsesAfterTimeout = true,
        onBeforeClear = function()
            tbl3 = {}
        end,
        fetchFn = function(str2: string)
            local var1, var2 = string.match(str2, "^([^:]+):([^:]+)$")
            return HttpClient.asPromise(
                HttpClient.fetch({
                    method = "GET",
                    url = `{tbl2.quotaSummaryUrl}{str1}product={var1}&modelTier={tbl1[var2]}`,
                    analyticsKey = "creator-credit.get-quota-summary",
                    network = tbl2.network,
                    decode = responseDecoders.decodeTierQuotaSummary
                })
            )
        end
    })
    local function getKey(arg1, arg2): string -- Luacid: Inlined by compiler; 3 call sites recovered
        assert(not bool1, "Creator Credit tier store is disposed")
        assert(arg1 == "PRODUCT_BUILD" or arg1 == "PRODUCT_BUILD_IN_STUDIO", "Invalid quota product")
        assert(tbl1[arg2] ~= nil, "Invalid model tier")
        return `{arg1}:{arg2}`
    end

    return {
        getTierQuotaSummary = function(arg1, arg2)
            local key = getKey(arg1, arg2)

            if tbl2.getLocalPlayerUserId() == nil then
                return dataResolver.getCachedItem(key)
            end
            tbl3[key] = true
            return dataResolver.getAndFetchItem(key)
        end,
        getTierQuotaSummarySignals = function(arg1, arg2)
            return dataResolver.getCachedItem((getKey(arg1, arg2)))
        end,
        refreshTierQuotaSummary = function(arg1, arg2)
            local key = getKey(arg1, arg2)

            if tbl2.getLocalPlayerUserId() == nil then
                return dataResolver.getCachedItem(key)
            end
            tbl3[key] = true
            return dataResolver.fetchItem(key)
        end,
        invalidate = function()
            local tbl4 = tbl3
            dataResolver.clear()
            if tbl2.getLocalPlayerUserId() == nil then
                return
            end

            tbl3 = tbl4
            for value in tbl4 do
                dataResolver.fetchItem(value)
            end
        end,
        clear = dataResolver.clear,
        dispose = function()
            if bool1 then
                return
            end
            bool1 = true
            dataResolver.dispose()
        end
    }
end
return createTierQuotaStore
