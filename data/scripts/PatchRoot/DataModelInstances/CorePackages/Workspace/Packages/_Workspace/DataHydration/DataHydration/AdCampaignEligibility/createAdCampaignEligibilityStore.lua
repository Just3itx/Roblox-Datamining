-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T03:01:07Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DataHydration = script:FindFirstAncestor("DataHydration")
local DataHydrationParent = DataHydration.Parent

local Players = game:GetService("Players")

local createDataCache = require(DataHydration.createDataCache)
local createDataResolver = require(DataHydration.createDataResolver)
local _DataHydrationTypes = require(DataHydration.DataHydrationTypes)
local Signals = require(DataHydrationParent.Signals)

local FFlagBuildAgentAdCampaignRefreshEligibility = require(DataHydrationParent.SharedFlags).FFlagBuildAgentAdCampaignRefreshEligibility

local fetchAdCampaignEligibility = require(script.Parent.fetchAdCampaignEligibility)
local _AdCampaignEligibilityStoreTypes = require(script.Parent.AdCampaignEligibilityStoreTypes)

local function createAdCampaignEligibilityStore(tbl1)
    local var1 = fetchAdCampaignEligibility
    if tbl1 and tbl1.fetchEligibility then
        var1 = tbl1.fetchEligibility
    end
    local var2 = nil
    local cache = createDataCache()
    local dataResolver = createDataResolver({
        cache = cache,
        supportsMultiGet = false,
        replaceItems = true,
        ignoreResponsesAfterTimeout = FFlagBuildAgentAdCampaignRefreshEligibility,
        onClear = FFlagBuildAgentAdCampaignRefreshEligibility and function()
            var2()
        end or nil,
        fetchFn = function(str1: string, _)
            return var1(tonumber(str1))
        end
    })
    local tbl2 = ({})
    local var3 = FFlagBuildAgentAdCampaignRefreshEligibility and {} or nil

    local function fetchEligibility(num1: number, func1: ((...any) -> (...any))?)
        if not FFlagBuildAgentAdCampaignRefreshEligibility then
            local str1 = tostring(num1)
            if not dataResolver.isRequestInQueueOrInFlight(str1) then
                return dataResolver.fetchItem(str1)
            end

            local cachedItem = dataResolver.getCachedItem(str1)
            if tbl2[str1] == nil then
                tbl2[str1] = Signals.createEffect(function(arg1)
                    cachedItem.data(arg1)
                    cachedItem.status(arg1)
                    if dataResolver.isRequestInQueueOrInFlight(str1) then
                        return
                    end

                    local var4 = tbl2[str1]
                    tbl2[str1] = nil
                    if var4 ~= nil then
                        var4()
                    end
                    dataResolver.fetchItem(str1)
                end)
            end

            return cachedItem
        end

        local str1 = tostring(num1)
        local pending = dataResolver.isRequestInQueueOrInFlight(str1)
        if not pending and func1 == nil then
            return dataResolver.fetchItem(str1)
        end

        local cachedItem = dataResolver.getCachedItem(str1)
        local var5 = var3[str1]
        if var5 ~= nil then
            var5.pending = true
            if func1 ~= nil then
                table.insert(var5.nextCallbacks, func1)
            end
            return cachedItem
        end

        local tbl3 = {
            pending = pending,
            callbacks = {},
            nextCallbacks = {}
        }

        if func1 ~= nil then
            table.insert(if pending then tbl3.nextCallbacks else tbl3.callbacks, func1)
        end
        var3[str1] = tbl3
        if not pending then
            dataResolver.fetchItem(str1)
        end
        tbl3.dispose = Signals.createEffect(function(arg1)
            local var6 = cachedItem.data(arg1)
            local var7 = cachedItem.status(arg1)
            if var7 == "NotReady" or dataResolver.isRequestInQueueOrInFlight(str1) then
                return
            end

            local callbacks = tbl3.callbacks
            tbl3.callbacks = tbl3.nextCallbacks
            tbl3.nextCallbacks = {}
            if tbl3.pending then
                tbl3.pending = false
                dataResolver.fetchItem(str1)
            else
                var3[str1] = nil
                if tbl3.dispose ~= nil then
                    tbl3.dispose()
                end
            end
            for _, callback in callbacks do
                callback(if var7 == "Ready" then var6 else nil)
            end
        end)
        return cachedItem
    end

    var2 = function()
        if FFlagBuildAgentAdCampaignRefreshEligibility then
            for value, value2 in var3 do
                var3[value] = nil
                if value2.dispose ~= nil then
                    value2.dispose()
                end
            end
            return
        end
        for value, value2 in tbl2 do
            tbl2[value] = nil
            value2()
        end
    end
    local localPlayer = Players.LocalPlayer
    local connection = Players:GetPropertyChangedSignal("LocalPlayer"):Connect(function()
        if Players.LocalPlayer ~= localPlayer then
            localPlayer = Players.LocalPlayer
            var2()
        end
    end)

    return {
        getEligibility = function(arg1)
            return dataResolver.getCachedItem(tostring(arg1))
        end,
        fetchEligibility = fetchEligibility,
        getAndFetchEligibility = function(arg1)
            return dataResolver.getAndFetchItem(tostring(arg1))
        end,
        clear = function()
            var2()
            dataResolver.clear()
        end,
        dispose = function()
            var2()
            if connection ~= nil then
                connection:Disconnect()
                connection = nil
            end
            dataResolver.dispose()
        end
    }
end

return createAdCampaignEligibilityStore
