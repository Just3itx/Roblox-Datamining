-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T05:31:19Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Moments = script:FindFirstAncestor("Moments")
local MomentsParent = Moments.Parent

local HttpClient = require(MomentsParent.HttpClient)
local MomentsCommon = require(MomentsParent.MomentsCommon)
local createMomentsUsageHeartbeat = require(MomentsParent.MomentsCommon.createMomentsUsageHeartbeat)
local Signals = require(MomentsParent.Signals)
local _MomentsStoreTypes = require(MomentsParent.DataHydration.MomentsStoreTypes)

local FIntMomentsUsageHeartbeatIntervalSec = require(Moments.Flags.FIntMomentsUsageHeartbeatIntervalSec)
local FIntMomentsUsageResumePollSec = require(Moments.Flags.FIntMomentsUsageResumePollSec)

local Analytics = MomentsCommon.Analytics

local function defaultPostHeartbeat()
    local momentsPostMomentsUsageHeartbeat = require(MomentsParent.DataHydration.MomentsPostMomentsUsageHeartbeat)
    return HttpClient.asPromise(momentsPostMomentsUsageHeartbeat())
end

local function defaultGetUsage()
    local momentsGetMomentsUsage = require(MomentsParent.DataHydration.MomentsGetMomentsUsage)
    return HttpClient.asPromise(momentsGetMomentsUsage())
end

local function defaultGetHasDailyLimit(arg1)
    return MomentsCommon.Stores.GetMomentsCapabilities(false).getHasDailyLimit(arg1)
end

local function defaultGetIsInExperience(arg1)
    return require(Moments.Stores.GetMomentsPreferencesStore)(false).getIsTeleporting(arg1)
end

local function defaultLifecycleObserver() -- Luacid: Inlined by compiler; 1 call site recovered
    local success, result = pcall(function(): AppLifecycleObserverService
        return game:GetService("AppLifecycleObserverService")
    end)
    return if success then result else nil
end

local function createMomentsUsageStore(tbl1)
    local tbl2 = tbl1 or {}
    local var1 = tbl2.postHeartbeat or defaultPostHeartbeat
    local var2 = tbl2.getUsage or defaultGetUsage
    local var3 = tbl2.getHasDailyLimit or defaultGetHasDailyLimit
    local var4 = tbl2.getIsInExperience or defaultGetIsInExperience

    local getIsLimitReached, var6 = Signals.createSignal(false)
    local getLimitSeconds, var8 = Signals.createSignal(0)

    local bool1 = false
    local bool2 = true
    local bool3 = false
    local bool4 = false
    local bool5 = false

    local momentsUsageHeartbeat = nil
    local momentsSessionHeartbeat = nil

    local function reconcile()
        local var9 = getIsLimitReached(false)
        momentsUsageHeartbeat.setSuspended(var9 or not bool1)
        local isWatching = var9 and momentsUsageHeartbeat.getIsWatching()
        if isWatching == bool4 then
            return
        end

        bool4 = isWatching
        if isWatching then
            momentsSessionHeartbeat.start("time_limit_poll")
            return
        end
        momentsSessionHeartbeat.stop()
    end

    local function markLimitReached(num1: number) -- Luacid: Inlined by compiler; 1 call site recovered
        var8(num1)
        var6(true)
        reconcile()
    end

    local function applyUsage(arg1)
        if bool5 then
            return
        end

        if arg1.limitSeconds >= 0 and arg1.remainingSeconds <= 0 then
            markLimitReached(arg1.limitSeconds)
        elseif getIsLimitReached(false) then
            var6(false)
            reconcile()
        end
    end

    local function ignoreFailure() end

    local function checkUsage() -- Luacid: Inlined by compiler; 3 call sites recovered
        var2():andThen(applyUsage):catch(ignoreFailure)
    end

    momentsUsageHeartbeat = createMomentsUsageHeartbeat(FIntMomentsUsageHeartbeatIntervalSec, function() -- name: sendHeartbeat
        var1():andThen(applyUsage):catch(ignoreFailure)
    end, function(bool6: boolean)
        if bool6 and getIsLimitReached(false) then
            checkUsage()
        end
    end, tbl2.scheduler, tbl2.clock)

    momentsSessionHeartbeat = Analytics.createMomentsSessionHeartbeat(FIntMomentsUsageResumePollSec, function(_: string)
        checkUsage()
    end, tbl2.scheduler)

    local function applyForeground() -- Luacid: Inlined by compiler; 4 call sites recovered
        momentsUsageHeartbeat.setForegrounded(bool2 and not bool3)
        reconcile()
    end

    local effect = Signals.createEffect(function(arg1)
        bool1 = var3(arg1)
        reconcile()
    end)
    local effect2 = Signals.createEffect(function(arg1)
        bool3 = var4(arg1)
        applyForeground()
    end)

    local function setTabFocused(bool6: boolean) -- Luacid: Inlined by compiler; 2 call sites recovered
        momentsUsageHeartbeat.setTabFocused(bool6)
        reconcile()
    end

    local function setForegrounded(bool6: boolean) -- Luacid: Inlined by compiler; 2 call sites recovered
        bool2 = bool6
        applyForeground()
    end

    local num1 = 0
    local function retainWatching()
        num1 += 1
        setTabFocused(true)
        local bool6 = false
        return function()
            if bool6 then
                return
            end
            bool6 = true
            num1 -= 1
            setTabFocused(num1 > 0)
        end
    end

    local var9 = tbl2.lifecycleObserver or defaultLifecycleObserver()
    local tbl3 = {}
    if var9 ~= nil then
        local onHide = var9.OnHide

        table.insert(tbl3, onHide:Connect(function()
            setForegrounded(false)
        end))

        local onUnhide = var9.OnUnhide

        table.insert(tbl3, onUnhide:Connect(function()
            setForegrounded(true)
        end))
    end

    return {
        getIsLimitReached = getIsLimitReached,
        getLimitSeconds = getLimitSeconds,
        markLimitReached = markLimitReached,
        checkForMoreTime = function()
            if getIsLimitReached(false) then
                checkUsage()
            end
        end,
        setTabFocused = setTabFocused,
        setForegrounded = setForegrounded,
        retainWatching = retainWatching,
        dispose = function()
            bool5 = true
            effect()
            effect2()
            momentsUsageHeartbeat.stop()
            momentsSessionHeartbeat.stop()
            for _, value in tbl3 do
                value:Disconnect()
            end
        end
    }
end

return createMomentsUsageStore
