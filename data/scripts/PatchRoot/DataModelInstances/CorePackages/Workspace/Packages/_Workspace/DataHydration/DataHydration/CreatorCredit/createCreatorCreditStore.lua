-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T03:40:48Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DataHydration = script:FindFirstAncestor("DataHydration")
local DataHydrationParent = DataHydration.Parent

local HttpClient = require(DataHydrationParent.HttpClient)
local Promise = require(DataHydrationParent.Promise)

local createDataCache = require(script.Parent.Parent.createDataCache)
local createDataResolver = require(script.Parent.Parent.createDataResolver)
local config = require(script.Parent.config)
local responseDecoders = require(script.Parent.responseDecoders)
local _types = require(script.Parent.types)
local DataHydrationUtils = require(DataHydration.DataHydrationUtils)
local createTierQuotaStore = require(script.Parent.createTierQuotaStore)
local FFlagBuildExperienceModelPickerData = require(DataHydrationParent.SharedFlags).FFlagBuildExperienceModelPickerData

local fetch = HttpClient.fetch
local asPromise = HttpClient.asPromise

local function createCreatorCreditStore(tbl1)
    local tbl2 = tbl1 or {}
    local quotaSummaryUrl = tbl2.quotaSummaryUrl or config.quotaSummaryUrl
    local dailyLimitUrl = tbl2.dailyLimitUrl or config.dailyLimitUrl
    local network = tbl2.network
    local ttlSeconds = tbl2.ttlSeconds or config.pollIntervalSeconds

    local cache = createDataCache(ttlSeconds, ttlSeconds)
    local dataCache = createDataCache(ttlSeconds, ttlSeconds)
    local num1 = 0
    local num2 = 0
    local var2 = Promise.resolve()
    local var3 = Promise.resolve()
    local var4 = Promise.resolve()
    local bool1 = false
    local getLocalPlayerUserId = tbl2.getLocalPlayerUserId or DataHydrationUtils.getLocalPlayerUserId
    local tierQuotaStore = if FFlagBuildExperienceModelPickerData then createTierQuotaStore({
        quotaSummaryUrl = quotaSummaryUrl,
        network = network,
        ttlSeconds = ttlSeconds,
        getLocalPlayerUserId = getLocalPlayerUserId
    }) else nil

    local function getTierStore() -- Luacid: Inlined by compiler; 4 call sites recovered
        assert(tierQuotaStore, "Tier quota requires FFlagBuildExperienceModelPickerData")
        return tierQuotaStore
    end

    local function fetchQuotaSummary(_: string)
        local num3 = num1
        local localPlayerUserId = if FFlagBuildExperienceModelPickerData then getLocalPlayerUserId() else nil
        local num4 = num2
        local var5 = var2:catch(function()
            return nil
        end):andThen(function()
            if bool1 or num3 ~= num1 or FFlagBuildExperienceModelPickerData and localPlayerUserId ~= getLocalPlayerUserId() then
                return Promise.reject("Creator Credit store changed before queued quota read")
            end

            return asPromise(
                fetch({
                    method = "GET",
                    url = quotaSummaryUrl,
                    analyticsKey = "creator-credit.get-quota-summary",
                    network = network,
                    decode = responseDecoders.decodeQuotaSummary
                })
            ):andThen(
                function(arg1)
                    if bool1 or num3 ~= num1 then
                        return Promise.reject("Creator Credit store changed during quota read")
                    end
                    if FFlagBuildExperienceModelPickerData and localPlayerUserId ~= getLocalPlayerUserId() then
                        return Promise.reject("Creator Credit store changed during quota read")
                    end
                    if num4 ~= num2 then
                        local limitSettings = dataCache.getItem("current-user").data(false)
                        if limitSettings then
                            arg1.limitSettings = limitSettings
                        end
                    end
                    return arg1
                end
            )
        end)

        var2 = var5
        return var5
    end

    local dataResolver = createDataResolver({ cache = cache, supportsMultiGet = false, fetchFn = fetchQuotaSummary })

    local function fetchDailyLimit(_: string)
        local num3 = num1
        local localPlayerUserId = if FFlagBuildExperienceModelPickerData then getLocalPlayerUserId() else nil
        local num4 = num2
        local var5 = var3:catch(function()
            return nil
        end):andThen(function()
            if bool1 or num3 ~= num1 or FFlagBuildExperienceModelPickerData and localPlayerUserId ~= getLocalPlayerUserId() then
                return Promise.reject("Creator Credit store changed before queued daily-limit read")
            end

            return asPromise(
                fetch({
                    method = "GET",
                    url = dailyLimitUrl,
                    analyticsKey = "creator-credit.get-daily-limit",
                    network = network,
                    decode = responseDecoders.decodeDailyLimitSettings
                })
            ):andThen(
                function(arg1)
                    if bool1 or num3 ~= num1 or FFlagBuildExperienceModelPickerData and localPlayerUserId ~= getLocalPlayerUserId() then
                        return Promise.reject("Creator Credit store changed during daily-limit read")
                    else
                        if num4 == num2 then
                            return arg1
                        end

                        return dataCache.getItem("current-user").data(false) or arg1
                    end
                end
            )
        end)

        var3 = var5
        return var5
    end

    local dataResolver2 = createDataResolver({ cache = dataCache, supportsMultiGet = false, fetchFn = fetchDailyLimit })

    local function getQuotaSummary()
        return dataResolver.getAndFetchItem("current-user")
    end

    local function getQuotaSummarySignals()
        return dataResolver.getCachedItem("current-user")
    end

    local function refreshQuotaSummary()
        local num3 = num1
        local localPlayerUserId = if FFlagBuildExperienceModelPickerData then getLocalPlayerUserId() else nil

        return fetchQuotaSummary("current-user"):andThen(function(arg1)
            if bool1 or num3 ~= num1 then
                return Promise.reject("Creator Credit store changed during quota refresh")
            end
            if FFlagBuildExperienceModelPickerData and localPlayerUserId ~= getLocalPlayerUserId() then
                return Promise.reject("Creator Credit store changed during quota refresh")
            end
            cache.replaceItem("current-user", arg1)
            return arg1
        end)
    end

    local function getDailyLimit()
        return dataResolver2.getAndFetchItem("current-user")
    end

    local function getDailyLimitSignals()
        return dataResolver2.getCachedItem("current-user")
    end

    local function refreshDailyLimit()
        local num3 = num1
        local localPlayerUserId = if FFlagBuildExperienceModelPickerData then getLocalPlayerUserId() else nil

        return fetchDailyLimit("current-user"):andThen(function(arg1)
            if bool1 or num3 ~= num1 then
                return Promise.reject("Creator Credit store changed during daily-limit refresh")
            end
            if FFlagBuildExperienceModelPickerData and localPlayerUserId ~= getLocalPlayerUserId() then
                return Promise.reject("Creator Credit store changed during daily-limit refresh")
            end
            dataCache.replaceItem("current-user", arg1)
            return arg1
        end)
    end

    local function setDailyLimit(body)
        local num3 = num1
        local localPlayerUserId = if FFlagBuildExperienceModelPickerData then getLocalPlayerUserId() else nil

        local var5 = var4:catch(function() end):andThen(function()
            if FFlagBuildExperienceModelPickerData and localPlayerUserId ~= getLocalPlayerUserId() then
                return Promise.reject("Creator Credit account changed before daily-limit write")
            end
            if bool1 or num3 ~= num1 then
                return Promise.reject("Creator Credit store changed before queued daily-limit write")
            end
            local var5 = fetch({
                method = "PUT",
                url = dailyLimitUrl,
                analyticsKey = "creator-credit.set-daily-limit",
                body = body,
                network = network,
                decode = responseDecoders.decodeDailyLimitSettings
            })
            return asPromise(var5)
        end)
        var4 = var5
        return var5:andThen(function(limitSettings)
            if FFlagBuildExperienceModelPickerData and localPlayerUserId ~= getLocalPlayerUserId() then
                return Promise.reject("Creator Credit account changed during daily-limit write")
            end
            if not bool1 and num3 == num1 then
                num2 += 1
                dataCache.replaceItem("current-user", limitSettings)
                local var6 = cache.getItem("current-user").data(false)
                if var6 then
                    local var7 = table.clone(var6)
                    var7.limitSettings = limitSettings
                    cache.replaceItem("current-user", var7)
                end
                if FFlagBuildExperienceModelPickerData then
                    getTierStore().invalidate()
                end
            end
            return limitSettings
        end)
    end

    local function clear()
        num1 += 1
        num2 += 1
        dataResolver.clear()
        dataResolver2.clear()
        if FFlagBuildExperienceModelPickerData then
            var2 = Promise.resolve()
            var3 = Promise.resolve()
            getTierStore().clear()
        end
    end

    local var5 = if FFlagBuildExperienceModelPickerData then (tbl2.observeLocalPlayerUserId or DataHydrationUtils.observeLocalPlayerUserId)(clear) else nil

    local tbl3 = {
        getQuotaSummary = getQuotaSummary,
        getQuotaSummarySignals = getQuotaSummarySignals,
        refreshQuotaSummary = refreshQuotaSummary,
        getDailyLimit = getDailyLimit,
        getDailyLimitSignals = getDailyLimitSignals,
        refreshDailyLimit = refreshDailyLimit,
        setDailyLimit = setDailyLimit,
        clear = clear,
        dispose = function()
            if bool1 then
                return
            end
            bool1 = true
            num1 += 1
            num2 += 1
            dataResolver.dispose()
            dataResolver2.dispose()
            if not FFlagBuildExperienceModelPickerData then
                return
            end

            if var5 then
                var5()
            end
            getTierStore().dispose()
        end
    }

    if FFlagBuildExperienceModelPickerData then
        local tierStore = getTierStore()
        tbl3.getTierQuotaSummary = tierStore.getTierQuotaSummary
        tbl3.getTierQuotaSummarySignals = tierStore.getTierQuotaSummarySignals
        tbl3.refreshTierQuotaSummary = tierStore.refreshTierQuotaSummary
    end
    return tbl3
end

return createCreatorCreditStore
