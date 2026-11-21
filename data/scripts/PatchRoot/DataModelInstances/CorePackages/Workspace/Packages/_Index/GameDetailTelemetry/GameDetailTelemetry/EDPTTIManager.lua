-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T18:10:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameDetailTelemetryParent = script:FindFirstAncestor("GameDetailTelemetry").Parent

local TimeToInteractiveTracker = require(GameDetailTelemetryParent.TimeToInteractiveTracker).TimeToInteractiveTracker
local Milestone = TimeToInteractiveTracker.Milestone
local PageGate = require(GameDetailTelemetryParent.PageGate)
local FFlagEnablePLTPrefetchCallbacks = PageGate.FFlagEnablePLTPrefetchCallbacks

local EDPTTIConstants = require(script.Parent.EDPTTIConstants)

local bool1 = game:DefineFastFlag("EnableEDPTTIManagerColdWarmDetection", false)

local EDP_TTI_EVENT_NAME = EDPTTIConstants.EDP_TTI_EVENT_NAME
local FIRST_MEDIA_RESOLVED = EDPTTIConstants.EDP_MILESTONE.FIRST_MEDIA_RESOLVED

local bool2 = false
local bool3 = false
local bool4 = false

local module = {}

function module.startTracking(page: string)
    bool2 = false
    bool3 = false
    bool4 = false

    local var1 = TimeToInteractiveTracker.getEvents(false)[EDP_TTI_EVENT_NAME]
    if not (var1 and var1.startTime) then
        TimeToInteractiveTracker.trackStart(EDP_TTI_EVENT_NAME, if bool1 then true else nil)

        TimeToInteractiveTracker.updateMetadata(EDP_TTI_EVENT_NAME, { page = page })
    end
end

function module.restartTracking(page: string)
    bool2 = false
    bool3 = false
    bool4 = false

    TimeToInteractiveTracker.trackStart(EDP_TTI_EVENT_NAME, if bool1 then true else nil)

    TimeToInteractiveTracker.updateMetadata(EDP_TTI_EVENT_NAME, { page = page })
end

function module.setImplementation(category: string)
    TimeToInteractiveTracker.updateMetadata(EDP_TTI_EVENT_NAME, { category = category })
end

function module.trackFunctionallyReady()
    if bool2 then
        return
    end
    bool2 = true

    if TimeToInteractiveTracker.trackMilestone then
        TimeToInteractiveTracker.trackMilestone(EDP_TTI_EVENT_NAME, Milestone.FunctionallyReady)
    end
    if FFlagEnablePLTPrefetchCallbacks then
        PageGate.signal(PageGate.Page.ExperienceDetail, PageGate.Milestone.FunctionallyReady)
    end
end

function module.trackFirstMediaResolved(id: string)
    if bool4 then
        return
    end
    bool4 = true

    if TimeToInteractiveTracker.trackMilestone then
        TimeToInteractiveTracker.trackMilestone(EDP_TTI_EVENT_NAME, FIRST_MEDIA_RESOLVED, { id = id })
    end
end

function module.trackSurfaceReady(tbl1)
    if bool3 then
        return
    end
    bool3 = true

    if tbl1 then
        TimeToInteractiveTracker.updateMetadata(EDP_TTI_EVENT_NAME, tbl1)
    end

    if TimeToInteractiveTracker.trackMilestone then
        TimeToInteractiveTracker.trackMilestone(EDP_TTI_EVENT_NAME, Milestone.SurfaceReady)
    end
    TimeToInteractiveTracker.trackEnd(EDP_TTI_EVENT_NAME)
end

return module
