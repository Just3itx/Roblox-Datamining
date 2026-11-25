-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T12:00:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SduiSharedUtilities = script:FindFirstAncestor("SduiSharedUtilities")
local SduiSharedUtilitiesParent = SduiSharedUtilities.Parent

local SduiLoadTimer = require(SduiSharedUtilities.SduiLoadTimer)
local TimeToInteractiveTracker = require(SduiSharedUtilitiesParent.TimeToInteractiveTracker).TimeToInteractiveTracker
local _SduiPageAnalytics = require(SduiSharedUtilities.SduiPageAnalytics)
local getSduiClientPageScope = require(SduiSharedUtilitiesParent.SduiCoreSystem).getSduiClientPageScope
local FFlagEDPTTIParityDefinitions = require(SduiSharedUtilitiesParent.SharedFlags).FFlagEDPTTIParityDefinitions

local Milestone = TimeToInteractiveTracker.Milestone

return {
    createLoadTimerWithSurfaceLoadTime = function(str1: string, tbl1, func1: ((...any) -> (...any))?)
        local eventName = tbl1.eventName
        local bool1 = tbl1.manualSurfaceReady == true
        local var1 = FFlagEDPTTIParityDefinitions and tbl1.manualFunctionallyReady == true
        local loadTimer = SduiLoadTimer.createLoadTimer(str1, func1)

        local bool2 = false
        local tbl2 = ({})

        local function trackOnce(str2: string) -- Luacid: Inlined by compiler; 9 call sites recovered
            if not tbl2[str2] then
                tbl2[str2] = true
                TimeToInteractiveTracker.trackMilestone(eventName, str2)
            end
        end

        local function trackSurfaceReady(tbl3) -- Luacid: Inlined by compiler; 1 call site recovered
            if tbl2[Milestone.SurfaceReady] then
                return
            end
            if tbl3 then
                TimeToInteractiveTracker.updateMetadata(eventName, tbl3)
            end
            trackOnce(Milestone.SurfaceReady)
            TimeToInteractiveTracker.trackEnd(eventName)
        end

        local function ensureStarted() -- Luacid: Inlined by compiler; 4 call sites recovered
            if bool2 then
                return
            end

            bool2 = true
            TimeToInteractiveTracker.trackStart(eventName, true)
            if tbl1.metadata then
                TimeToInteractiveTracker.updateMetadata(eventName, tbl1.metadata)
            end
        end

        local function logRenderStarted()
            ensureStarted()
            trackOnce(Milestone.RenderStarted)
        end

        local logUiRequestSent = loadTimer.logUiRequestSent
        function loadTimer.logUiRequestSent()
            logUiRequestSent()
            ensureStarted()
            trackOnce(Milestone.PrimaryDataStarted.Name)
        end

        local logUiRequestQueued = loadTimer.logUiRequestQueued
        function loadTimer.logUiRequestQueued()
            logUiRequestQueued()
            ensureStarted()
        end

        local logResponseDecodeBegin = loadTimer.logResponseDecodeBegin
        function loadTimer.logResponseDecodeBegin()
            logResponseDecodeBegin()
            trackOnce(Milestone.PrimaryDataReady.Name)
            trackOnce(Milestone.DataProcessingStarted.Name)
        end

        local logComponentMounted = loadTimer.logComponentMounted
        function loadTimer.logComponentMounted()
            logComponentMounted()
            trackOnce(Milestone.SurfaceMounted)
        end

        local logComponentReady = loadTimer.logComponentReady
        function loadTimer.logComponentReady()
            trackOnce(Milestone.DataProcessingCompleted.Name)
            logComponentReady()
            if not var1 then
                trackOnce(Milestone.FunctionallyReady)
            end
            if not bool1 then
                trackSurfaceReady(false)
            end
        end

        loadTimer.logRenderStarted = logRenderStarted
        loadTimer.trackOnce = trackOnce
        loadTimer.trackSurfaceReady = trackSurfaceReady
        loadTimer.surfaceLoadTimeEventName = eventName
        getSduiClientPageScope(str1).set("__sduiSurfaceLoadTimeTracker", loadTimer)

        if FFlagEDPTTIParityDefinitions and tbl1.startImmediately == true then
            ensureStarted()
        end

        return loadTimer
    end,
    SURFACE_LOAD_TIME_PAGE_SCOPE_KEY = "__sduiSurfaceLoadTimeTracker"
}
