-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T20:50:48Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InExperienceShop = script:FindFirstAncestor("InExperienceShop")
local InExperienceShopParent = InExperienceShop.Parent

local Signals = require(InExperienceShopParent.Signals)

local Constants = require(InExperienceShop.Constants)
local _Types = require(InExperienceShop.Types)
local FFlagEnableShopPrefetch = require(InExperienceShop.Flags.FFlagEnableShopPrefetch)
local FFlagEnableShopProductInfoRefresh = require(InExperienceShop.Flags.FFlagEnableShopProductInfoRefresh)
local FFlagShopPrefetchProductInfo = require(InExperienceShop.Flags.FFlagShopPrefetchProductInfo)
local FIntShopPrefetchMaxRetries = require(InExperienceShop.Flags.FIntShopPrefetchMaxRetries)
local FIntShopPrefetchRetryBackoffMs = require(InExperienceShop.Flags.FIntShopPrefetchRetryBackoffMs)
local FIntShopPrefetchDelayMs = require(InExperienceShop.Flags.FIntShopPrefetchDelayMs)
local getInExperienceShopStore = require(InExperienceShop.Stores.getInExperienceShopStore)
local whenJoinSettles = require(InExperienceShop.Internal.whenJoinSettles)
local schedulePrefetchDelay = require(InExperienceShop.Internal.schedulePrefetchDelay)
local scheduleRetry = require(InExperienceShop.Internal.scheduleRetry)
local logCounter = require(InExperienceShop.Internal.logCounter)
local ShopDebugLogger = require(InExperienceShop.Internal.ShopDebugLogger)
local PrefetchOnJoinFiredFallbackPathCounter = require(InExperienceShop.Events.PrefetchOnJoinFiredFallbackPathCounter)
local PrefetchOnJoinFiredPrimaryPathCounter = require(InExperienceShop.Events.PrefetchOnJoinFiredPrimaryPathCounter)
local PrefetchOnJoinRetriedCounter = require(InExperienceShop.Events.PrefetchOnJoinRetriedCounter)

local function hasNonSyntheticCategory(tbl1) -- Luacid: Inlined by compiler; 1 call site recovered
    for _, value in tbl1 do
        if value.id ~= Constants.HOME_CATEGORY_ID then
            return true
        end
    end
    return false
end

local function awaitPrefetchOutcome(callback: (...any) -> (...any)) -- Luacid: Inlined by compiler; 1 call site recovered
    local inExperienceShopStore = getInExperienceShopStore(false)
    local bool1 = false
    local effect = nil
    effect = Signals.createEffect(function(arg1)
        if bool1 or inExperienceShopStore.getLoading(arg1) then
            return
        end

        local categories = inExperienceShopStore.getCategories(arg1)
        local error = inExperienceShopStore.getError(arg1)
        bool1 = true
        task.spawn(function()
            callback(error, categories)
        end)
        task.defer(function()
            if effect then
                effect()
            end
        end)
    end)
end

local function triggerPrefetch(arg1, callback: ((...any) -> (...any))?)
    ShopDebugLogger.logLazy(function()
        return "prefetchShopDataOnGameJoin: triggerPrefetch path=" .. arg1
    end)
    if arg1 == "primary" then
        logCounter(PrefetchOnJoinFiredPrimaryPathCounter)
    else
        logCounter(PrefetchOnJoinFiredFallbackPathCounter)
    end

    local inExperienceShopStore = getInExperienceShopStore(false)
    local var1 = ShopDebugLogger.startTimer()

    local function func1() -- Luacid: Inlined by compiler; 2 call sites recovered
        if FFlagEnableShopProductInfoRefresh and not FFlagShopPrefetchProductInfo then
            ShopDebugLogger.log("prefetchShopDataOnGameJoin: starting prefetchWidgetsOnly")
            inExperienceShopStore.prefetchWidgetsOnly()
            return
        end
        ShopDebugLogger.log("prefetchShopDataOnGameJoin: starting fetchAllShopData")
        inExperienceShopStore.fetchAllShopData()
    end

    if not callback then
        func1()
        return
    end

    local var2 = FIntShopPrefetchMaxRetries
    local var3 = FIntShopPrefetchRetryBackoffMs / 1000
    local var4 = var2

    local function tryFetch()
        ShopDebugLogger.logLazy(function()
            return "prefetchShopDataOnGameJoin: attempt=" .. var2 - var4 + 1 .. " of " .. var2 + 1
        end)

        func1()

        awaitPrefetchOutcome(function(arg2, tbl1)
            local bool1 = arg2 == nil and hasNonSyntheticCategory(tbl1)

            if arg2 ~= nil and var4 > 0 then
                var4 -= 1
                ShopDebugLogger.logLazy(function()
                    return "prefetchShopDataOnGameJoin: error, retrying attemptsRemaining=" .. var4 .. " backoffSeconds=" .. var3
                end)

                logCounter(PrefetchOnJoinRetriedCounter)
                scheduleRetry(var3, tryFetch)
                return
            end
            ShopDebugLogger.logElapsedLazy(function(): string
                return "prefetchShopDataOnGameJoin: settled hasItems=" .. tostring(bool1)
            end, var1)
            callback(bool1)
        end)
    end

    tryFetch()
end

local function prefetchShopDataOnGameJoin(callback: ((...any) -> (...any))?)
    if not FFlagEnableShopPrefetch then
        return
    end
    ShopDebugLogger.log("prefetchShopDataOnGameJoin: waiting for join to settle")
    whenJoinSettles(function(arg1)
        ShopDebugLogger.logLazy(function()
            return "prefetchShopDataOnGameJoin: join settled path=" .. arg1
        end)
        local var1 = FIntShopPrefetchDelayMs
        if var1 <= 0 then
            triggerPrefetch(arg1, callback)
            return
        end
        schedulePrefetchDelay(var1 / 1000, function()
            triggerPrefetch(arg1, callback)
        end)
    end)
end

return prefetchShopDataOnGameJoin
