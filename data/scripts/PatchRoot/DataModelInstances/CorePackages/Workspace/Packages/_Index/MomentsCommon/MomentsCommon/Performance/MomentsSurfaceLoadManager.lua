-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T06:30:40Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsCommon = script:FindFirstAncestor("MomentsCommon")
local MomentsCommonParent = MomentsCommon.Parent

local SharedFlags = require(MomentsCommonParent.SharedFlags)
local TimeToInteractiveTracker = require(MomentsCommonParent.TimeToInteractiveTracker).TimeToInteractiveTracker
local Milestone = TimeToInteractiveTracker.Milestone

local Analytics = require(MomentsCommon.Analytics)
local _CaptureKind = require(MomentsCommon.Enums.CaptureKind)
local EventNames = Analytics.EventNames
local fireAnalyticsEvent = Analytics.fireAnalyticsEvent
local FIntMomentsSurfaceLoadTTISamplingRate = SharedFlags.FIntMomentsSurfaceLoadTTISamplingRate

local getSessionGeneration = 0
local var1 = nil

local function isSessionActive(): boolean -- Luacid: Inlined by compiler; 13 call sites recovered
    local events = TimeToInteractiveTracker.getEvents()
    return not (events == nil) and events.Watch_MomentsFeed ~= nil
end

local function computeElapsedMs(): number -- Luacid: Inlined by compiler; 1 call site recovered
    if var1 == nil then
        return 0
    end

    return (os.clock() - var1) * 1000
end

local function scheduleCapTimeout(num2: number) -- Luacid: Inlined by compiler; 1 call site recovered
    local fIntMomentsSurfaceLoadTtiMaxMs = SharedFlags.FIntMomentsSurfaceLoadTTIMaxMs
    if fIntMomentsSurfaceLoadTtiMaxMs <= 0 then
        return
    end
    task.delay(fIntMomentsSurfaceLoadTtiMaxMs / 1000, function()
        if num2 == getSessionGeneration and isSessionActive() and isSessionActive() then
            Analytics.reportMomentsSurfaceLoadAbort("capped")

            TimeToInteractiveTracker.destroyEvent("Watch_MomentsFeed")
            var1 = nil
        end
    end)
end

return {
    EVENT_NAME = "Watch_MomentsFeed",
    start = function()
        getSessionGeneration += 1
        var1 = os.clock()
        TimeToInteractiveTracker.trackStart("Watch_MomentsFeed", true)
        scheduleCapTimeout(getSessionGeneration)
    end,
    isSessionActive = isSessionActive,
    getSessionGeneration = function()
        return getSessionGeneration
    end,
    elapsedMs = computeElapsedMs,
    renderStarted = function()
        if not isSessionActive() then
            return
        end
        TimeToInteractiveTracker.trackMilestone("Watch_MomentsFeed", Milestone.RenderStarted)
    end,
    surfaceMounted = function()
        if not isSessionActive() then
            return
        end
        TimeToInteractiveTracker.trackMilestone("Watch_MomentsFeed", Milestone.SurfaceMounted)
    end,
    primaryDataStarted = function()
        if not isSessionActive() then
            return
        end
        TimeToInteractiveTracker.trackMilestone("Watch_MomentsFeed", Milestone.PrimaryDataStarted.Name)
    end,
    primaryDataNetworkFetch = function()
        if not isSessionActive() then
            return
        end
        TimeToInteractiveTracker.trackSubphase(
            "Watch_MomentsFeed",
            Milestone.PrimaryDataStarted.Name,
            Milestone.PrimaryDataStarted.Subphase.NetworkFetch
        )
    end,
    primaryDataResponseReceived = function()
        if not isSessionActive() then
            return
        end
        TimeToInteractiveTracker.trackSubphase(
            "Watch_MomentsFeed",
            Milestone.PrimaryDataStarted.Name,
            Milestone.PrimaryDataStarted.Subphase.ResponseReceived
        )
    end,
    primaryDataReady = function()
        if not isSessionActive() then
            return
        end
        TimeToInteractiveTracker.trackMilestone("Watch_MomentsFeed", Milestone.PrimaryDataReady.Name)
    end,
    markSurfaceReady = function(subcategory)
        if not isSessionActive() then
            return
        end

        local value = computeElapsedMs()
        local fIntMomentsSurfaceLoadTtiMaxMs = SharedFlags.FIntMomentsSurfaceLoadTTIMaxMs
        if fIntMomentsSurfaceLoadTtiMaxMs > 0 and fIntMomentsSurfaceLoadTtiMaxMs < value then
            if not isSessionActive() then
                return
            end

            Analytics.reportMomentsSurfaceLoadAbort("capped")

            TimeToInteractiveTracker.destroyEvent("Watch_MomentsFeed")
            var1 = nil

            return
        end

        if subcategory ~= nil then
            TimeToInteractiveTracker.updateMetadata("Watch_MomentsFeed", { subcategory = subcategory })
        end

        TimeToInteractiveTracker.trackMilestone("Watch_MomentsFeed", Milestone.SurfaceReady)
        TimeToInteractiveTracker.trackEnd("Watch_MomentsFeed", { samplingRateOverride = FIntMomentsSurfaceLoadTTISamplingRate })

        fireAnalyticsEvent(EventNames.MomentsFirstContentLoadedTimestamp, { value = value })
        var1 = nil
    end,
    abort = function(arg1) -- name: abortMeasurement
        if not isSessionActive() then
            return
        end
        if arg1 ~= nil then
            Analytics.reportMomentsSurfaceLoadAbort(arg1)
        end
        TimeToInteractiveTracker.destroyEvent("Watch_MomentsFeed")
        var1 = nil
    end
}
