-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T04:11:31Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DataHydration = script:FindFirstAncestor("DataHydration")
local DataHydrationParent = DataHydration.Parent

local Promise = require(DataHydrationParent.Promise)

local DiscoveryUtils = require(DataHydrationParent.DiscoveryUtils)
local logResponseError = DiscoveryUtils.logResponseError
local DiscoveryEventErrorLogger = DiscoveryUtils.DiscoveryEventErrorLogger

local SharedFlags = require(DataHydrationParent.SharedFlags)
local FFlagSduiDevStoreSeeAllSupport = SharedFlags.FFlagSduiDevStoreSeeAllSupport
local FFlagEnableHomeGameItemOwnershipUpdate = SharedFlags.FFlagEnableHomeGameItemOwnershipUpdate
local FFlagEnableSearchGameItemOwnershipUpdate = SharedFlags.FFlagEnableSearchGameItemOwnershipUpdate

local createDataCache = require(DataHydration.createDataCache)
local createDataResolver = require(DataHydration.createDataResolver)
local _DataHydrationTypes = require(DataHydration.DataHydrationTypes)

local _GameDeveloperProductStoreTypes = require(script.Parent.GameDeveloperProductStoreTypes)
local fetchGameDeveloperProductStatuses = require(script.Parent.fetchGameDeveloperProductStatuses)

local function buildStatusesKey(str1: string, str2: string): string -- Luacid: Inlined by compiler; 1 call site recovered
    return str1 .. "|" .. str2
end

local function createGameDeveloperProductStore()
    local dataCache = createDataCache()

    local dataCache2 = nil
    local dataResolver = nil

    if FFlagSduiDevStoreSeeAllSupport or FFlagEnableHomeGameItemOwnershipUpdate or FFlagEnableSearchGameItemOwnershipUpdate then
        dataCache2 = createDataCache()
        dataResolver = createDataResolver({
            cache = dataCache2,
            supportsMultiGet = false,
            logError = function(arg1)
                local statusCode = if type(arg1) == "table" and arg1.StatusCode then arg1.StatusCode else nil
                logResponseError("game-transactions/v1/receipts", { StatusCode = statusCode })
                DiscoveryEventErrorLogger.reportError(
                    "GameDeveloperProductStore",
                    "Failed to fetch developer product statuses",
                    {
                        err = tostring(arg1)
                    }
                )
            end,
            fetchFn = function(str1: string, arg1)
                local var1, var2 = string.match(str1, "^(.-)|(.+)$")
                if var1 == nil or var2 == nil then
                    return Promise.reject("Invalid developer product statuses key: " .. tostring(str1))
                end
                return fetchGameDeveloperProductStatuses.fetch(var1, var2):andThen(function(arg2)
                    local tbl1 = ({})
                    for k, pendingReceiptCount in arg2.counts do
                        tbl1[k] = { pendingReceiptCount = pendingReceiptCount }
                    end

                    local var3 = arg1 and arg1.data(false)
                    if var3 and var3.counts then
                        for k in var3.counts do
                            if arg2.counts[k] == nil then
                                tbl1[k] = { pendingReceiptCount = 0 }
                            end
                        end
                    end
                    if next(tbl1) ~= nil then
                        dataCache.updateItems(tbl1)
                    end
                    return arg2
                end)
            end
        })
    end

    return {
        getGameDeveloperProductInfo = dataCache.getItem,
        updateGameDeveloperProductInfos = dataCache.updateItems,
        fetchStatuses = function(str1: string, str2: string)
            if dataResolver then
                dataResolver.fetchItem((buildStatusesKey(str1, str2)))
            end
        end,
        clear = function()
            if dataCache2 then
                dataCache2.clear()
            end
            if dataResolver then
                dataResolver.clear()
            end
            dataCache.clear()
        end,
        dispose = function()
            if dataResolver then
                dataResolver.dispose()
            end
            dataCache.dispose()
        end
    }
end
return createGameDeveloperProductStore
