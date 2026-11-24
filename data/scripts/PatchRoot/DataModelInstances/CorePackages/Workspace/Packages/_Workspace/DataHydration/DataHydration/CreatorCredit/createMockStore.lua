-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T03:40:49Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DataHydration = script:FindFirstAncestor("DataHydration")
local DataHydrationParent = DataHydration.Parent

local LuauPolyfill = require(DataHydrationParent.LuauPolyfill)
local Promise = require(DataHydrationParent.Promise)

local createDataCache = require(script.Parent.Parent.createDataCache)
local _types = require(script.Parent.types)
local _DataHydrationTypes = require(DataHydration.DataHydrationTypes)
local FFlagBuildExperienceModelPickerData = require(DataHydrationParent.SharedFlags).FFlagBuildExperienceModelPickerData

local function defaultDailyLimit() -- Luacid: Inlined by compiler; 4 call sites recovered
    return { additionalUsageEnabled = false, dailyLimitSet = true, dailyLimit = 100 }
end

local function defaultQuota() -- Luacid: Inlined by compiler; 2 call sites recovered
    return {
        freeTrialDailyAllowance = 100,
        freeTrialRemaining = 72,
        freeTrialPctUsed = 28,
        nextResetEligibleTime = "2026-07-17T00:00:00Z",
        robuxBalance = 500,
        limitSettings = defaultDailyLimit(),
        robuxSpentToday = 0,
        limitRemaining = 100,
        freeTrialResetPeriod = "Daily"
    }
end

local function createMockStore(tbl1)
    local tbl2 = tbl1 or {}
    local dataCache = createDataCache(300, 300)
    local dataCache2 = createDataCache(300, 300)
    local tbl3 = ({})
    local bool1 = false

    local function getTierEntry(product, tier)
        assert(FFlagBuildExperienceModelPickerData, "Tier quota requires FFlagBuildExperienceModelPickerData")
        assert(not bool1, "Creator Credit tier store is disposed")
        assert(product == "PRODUCT_BUILD" or product == "PRODUCT_BUILD_IN_STUDIO", "Invalid quota product")
        assert(tier == "default" or tier == "advanced", "Invalid model tier")
        local str1 = `{product}:{tier}`
        if tbl3[str1] == nil then
            tbl3[str1] = {
                cache = createDataCache(300, 300),
                product = product,
                tier = tier,
                requested = false
            }
        end

        return tbl3[str1]
    end

    local function setTierQuota(product, tier, quota) -- Luacid: Inlined by compiler; 2 call sites recovered
        local tierEntry = getTierEntry(product, tier)
        tierEntry.quota = quota
        tierEntry.error = nil
        local var1 = table.clone(quota)
        tierEntry.cache.replaceItem("current-user", var1)
    end

    local function refreshTierQuotaSummary(product, tier)
        local tierEntry = getTierEntry(product, tier)
        tierEntry.requested = true
        if tierEntry.error == nil and tierEntry.quota ~= nil then
            setTierQuota(product, tier, tierEntry.quota)
        else
            tierEntry.cache.getItem("current-user")
            tierEntry.cache.markItemsAsFailed({ "current-user" })
        end

        return tierEntry.cache.getItem("current-user")
    end

    if FFlagBuildExperienceModelPickerData and tbl2.initialTierQuotas then
        for k, initialTierQuota in tbl2.initialTierQuotas do
            for value, value2 in initialTierQuota do
                setTierQuota(k, value, value2)
            end
        end
    end

    if tbl2.initialQuota then
        dataCache.replaceItem("current-user", tbl2.initialQuota)
    end
    if tbl2.initialDailyLimit then
        dataCache2.replaceItem("current-user", tbl2.initialDailyLimit)
    end

    local var1 = nil
    local num1 = 0

    local function scheduleAutoPopulate() -- Luacid: Inlined by compiler; 1 call site recovered
        if var1 == nil then
            return
        end
        local var2 = var1
        if num1 <= 0 then
            dataCache.replaceItem("current-user", var2)
            return
        end
        LuauPolyfill.setTimeout(function()
            dataCache.replaceItem("current-user", var2)
        end, num1 * 1000)
    end

    local tbl4 = {
        getQuotaSummary = function()
            local var2, var3 = dataCache.getItem("current-user")
            if var3 then
                scheduleAutoPopulate()
            end

            return var2
        end,
        getQuotaSummarySignals = function()
            return (dataCache.getItem("current-user"))
        end,
        refreshQuotaSummary = function()
            local var2 = dataCache.getItem("current-user").data(false)
            local var3 = var1 or var2 or defaultQuota()
            dataCache.replaceItem("current-user", var3)
            return Promise.resolve(var3)
        end,
        getDailyLimit = function()
            if dataCache2.getItem("current-user").data(false) == nil then
                local tbl4 = defaultDailyLimit()
                dataCache2.replaceItem("current-user", tbl4)
            end
            return (dataCache2.getItem("current-user"))
        end,
        getDailyLimitSignals = function()
            return (dataCache2.getItem("current-user"))
        end,
        refreshDailyLimit = function()
            local var2 = dataCache2.getItem("current-user").data(false)
                or { additionalUsageEnabled = false, dailyLimitSet = true, dailyLimit = 100 }
            dataCache2.replaceItem("current-user", var2)
            return Promise.resolve(var2)
        end,
        setDailyLimit = function(arg1)
            dataCache2.replaceItem("current-user", arg1)
            if FFlagBuildExperienceModelPickerData then
                for _, value in tbl3 do
                    value.cache.clear()
                    if value.requested then
                        refreshTierQuotaSummary(value.product, value.tier)
                    end
                end
            end
            return Promise.resolve(arg1)
        end,
        clear = function()
            dataCache.clear()
            dataCache2.clear()
            if not FFlagBuildExperienceModelPickerData then
                return
            end

            for _, value in tbl3 do
                value.cache.clear()
                value.quota = nil
                value.error = nil
            end
        end,
        dispose = function()
            if FFlagBuildExperienceModelPickerData then
                if bool1 then
                    return
                end
                bool1 = true
            end
            dataCache.dispose()
            dataCache2.dispose()
            if not FFlagBuildExperienceModelPickerData then
                return
            end

            for _, value in tbl3 do
                value.cache.dispose()
            end
        end,
        _setQuota = function(arg1)
            dataCache.replaceItem("current-user", arg1)
        end,
        _setDailyLimit = function(arg1)
            dataCache2.replaceItem("current-user", arg1)
        end,
        _setError = function()
            dataCache.markItemsAsFailed({ "current-user" })
        end,
        _setLoading = function()
            dataCache.clear()
        end,
        _setAutoPopulate = function(arg1, num2: number?)
            var1 = arg1 or defaultQuota()
            num1 = num2 or 0
        end
    }
    if FFlagBuildExperienceModelPickerData then
        function tbl4.getTierQuotaSummary(product, tier)
            local tierEntry = getTierEntry(product, tier)
            tierEntry.requested = true
            local var2, var3 = tierEntry.cache.getItem("current-user")
            if var3 and tierEntry.quota then
                refreshTierQuotaSummary(product, tier)
            end
            return var2
        end
        function tbl4.getTierQuotaSummarySignals(product, tier)
            return getTierEntry(product, tier).cache.getItem("current-user")
        end
        tbl4.refreshTierQuotaSummary = refreshTierQuotaSummary
        tbl4._setTierQuota = setTierQuota
        function tbl4._setTierError(product, tier, error)
            local tierEntry = getTierEntry(product, tier)
            tierEntry.error = error or { errorMessage = "Mock tier quota failed" }
            tierEntry.cache.getItem("current-user")
            tierEntry.cache.markItemsAsFailed({ "current-user" })
        end
        function tbl4._setTierLoading(product, tier)
            local tierEntry = getTierEntry(product, tier)
            tierEntry.cache.clear()
            tierEntry.quota = nil
            tierEntry.error = nil
        end
        function tbl4._setTierRefreshQuota(product, tier, quota)
            local tierEntry = getTierEntry(product, tier)
            tierEntry.quota = quota
            tierEntry.error = nil
        end
    end
    return tbl4
end

return createMockStore
