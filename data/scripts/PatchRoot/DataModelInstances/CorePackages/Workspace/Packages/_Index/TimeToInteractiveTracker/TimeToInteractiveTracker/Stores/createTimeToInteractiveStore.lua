-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T23:51:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local TimeToInteractiveTracker = script:FindFirstAncestor("TimeToInteractiveTracker")
local TimeToInteractiveTrackerParent = TimeToInteractiveTracker.Parent

local createSignal = require(TimeToInteractiveTrackerParent.Signals).createSignal

local FFlagEnableTTIRecordWebViewMilestones = require(TimeToInteractiveTrackerParent.SharedFlags).FFlagEnableTTIRecordWebViewMilestones
local FFlagLuaAppNavTTIMeasurementV2 = require(TimeToInteractiveTrackerParent.SharedFlags).FFlagLuaAppNavTTIMeasurementV2
local FFlagTTITrackerDropEventsOnAppHide = require(TimeToInteractiveTracker.Utils.FFlagTTITrackerDropEventsOnAppHide)
local getAppLifecycleObserverService = require(TimeToInteractiveTracker.Utils.getAppLifecycleObserverService)
local FFlagTTITrackerDropEventsOnJoinAttempt = require(TimeToInteractiveTracker.Utils.FFlagTTITrackerDropEventsOnJoinAttempt)
local getOnNewJoinAttempt = require(TimeToInteractiveTracker.Utils.getOnNewJoinAttempt)

local updateTTIEventMetadata = require(script.Parent.Actions.updateTTIEventMetadata)
local trackTTIEventStart = require(script.Parent.Actions.trackTTIEventStart)
local trackTTIEventEnd = require(script.Parent.Actions.trackTTIEventEnd)
local trackMilestone = require(script.Parent.Actions.trackMilestone)
local trackSubphase = require(script.Parent.Actions.trackSubphase)
local trackRequest = require(script.Parent.Actions.trackRequest)
local recordWebViewMilestones = require(script.Parent.Actions.recordWebViewMilestones)
local resetTTIEvent = require(script.Parent.Actions.resetTTIEvent)
local destroyTTIEvent = require(script.Parent.Actions.destroyTTIEvent)
local dropInFlightTTIEvents = require(script.Parent.Actions.dropInFlightTTIEvents)
local discardOlderNavigationStarts = require(script.Parent.Actions.discardOlderNavigationStarts)

local logTTIDiscard = require(TimeToInteractiveTracker.Utils.logTTIDiscard)
local hasNavigationCommitted = require(TimeToInteractiveTracker.Utils.hasNavigationCommitted)
local constants = require(TimeToInteractiveTracker.Milestones.constants)
local navigationEventPrefix = require(TimeToInteractiveTracker.Utils.navigationEventPrefix)
local useTTIRenderAndMountedTracking = require(TimeToInteractiveTracker.Hooks.useTTIRenderAndMountedTracking)

local _types = require(script.Parent.types)

return function()
    local getEvents, setEvents = createSignal({})

    local tbl1 = {}
    local trackEnd, trackEndAtNextFrame = trackTTIEventEnd(setEvents, tbl1)

    if FFlagTTITrackerDropEventsOnAppHide then
        local appLifecycleObserverService = getAppLifecycleObserverService()
        if FFlagLuaAppNavTTIMeasurementV2 and appLifecycleObserverService then
            local var5 = dropInFlightTTIEvents(setEvents)
            appLifecycleObserverService.OnHide:Connect(function()
                local var6 = getEvents(false)
                for _, value in var5() do
                    if hasNavigationCommitted(var6[value]) then
                        logTTIDiscard(value, "backgrounded")
                    end
                end
            end)
        elseif appLifecycleObserverService then
            appLifecycleObserverService.OnHide:Connect(dropInFlightTTIEvents(setEvents))
        end
    end

    if FFlagTTITrackerDropEventsOnJoinAttempt then
        local onNewJoinAttempt = getOnNewJoinAttempt()
        if FFlagLuaAppNavTTIMeasurementV2 and onNewJoinAttempt then
            local var5 = dropInFlightTTIEvents(setEvents)
            onNewJoinAttempt:Connect(function()
                local var6 = getEvents(false)
                for _, value in var5() do
                    if hasNavigationCommitted(var6[value]) then
                        logTTIDiscard(value, "joinAttempt")
                    end
                end
            end)
        elseif onNewJoinAttempt then
            onNewJoinAttempt:Connect(dropInFlightTTIEvents(setEvents))
        end
    end

    return {
        getEvents = getEvents,
        setEvents = setEvents,
        updateMetadata = updateTTIEventMetadata(setEvents),
        trackStart = trackTTIEventStart(setEvents, tbl1),
        trackEnd = trackEnd,
        trackEndAtNextFrame = trackEndAtNextFrame,
        trackMilestone = trackMilestone(getEvents, setEvents),
        trackSubphase = trackSubphase(getEvents, setEvents),
        trackRequest = trackRequest(getEvents, setEvents),
        recordWebViewMilestones = if FFlagEnableTTIRecordWebViewMilestones then recordWebViewMilestones(getEvents, setEvents) else nil,
        resetEvent = resetTTIEvent(setEvents),
        destroyEvent = destroyTTIEvent(setEvents),
        discardOlderNavigationStarts = discardOlderNavigationStarts(setEvents, tbl1),
        Milestone = constants,
        NAVIGATION_EVENT_PREFIX = navigationEventPrefix,
        Hooks = {
            useTTIRenderAndMountedTracking = useTTIRenderAndMountedTracking(trackMilestone(getEvents, setEvents))
        }
    }
end
