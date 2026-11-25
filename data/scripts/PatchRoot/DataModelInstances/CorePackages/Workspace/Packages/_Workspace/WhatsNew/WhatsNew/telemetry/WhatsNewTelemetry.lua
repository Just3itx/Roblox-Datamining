-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T23:01:14Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local TelemetryService = game:GetService("TelemetryService")

local WhatsNew = script:FindFirstAncestor("WhatsNew")
local WhatsNewParent = WhatsNew.Parent

local LoggingProtocol = require(WhatsNewParent.LoggingProtocol)
local _Types = require(WhatsNew.Types)

local EventIngest = LoggingProtocol.TelemetryBackends.EventIngest

local throttlingPercentage = game:DefineFastInt("WhatsNewTelemetryThrottleHundredthsPercent", 10000)

local Events = {
    tourtipInteraction = {
        eventName = "whatsNewTourtipInteraction",
        backends = { EventIngest },
        throttlingPercentage = throttlingPercentage,
        lastUpdated = { 2026, 7, 6 },
        description = "Fires for tourtip impressions, clicks, dismissals, and skipped steps",
        links = "https://github.rbx.com/Roblox/proto-schemas/blob/master/production/eventstream/coreui/whatsnew/tourtip_interaction.proto"
    },
    tourLifecycle = {
        eventName = "whatsNewTourLifecycle",
        backends = { EventIngest },
        throttlingPercentage = throttlingPercentage,
        lastUpdated = { 2026, 7, 6 },
        description = "Fires for tour session lifecycle transitions",
        links = "https://github.rbx.com/Roblox/proto-schemas/blob/master/production/eventstream/coreui/whatsnew/tour_lifecycle.proto"
    }
}

local standardizedFields = { "addPlaceId", "addUniverseId", "addPlaySessionId" }
local module = {
    Events = Events,
    InteractionType = { IMPRESSION = 1, CLICK = 2, DISMISS = 3, SKIP = 4 },
    Button = { NEXT = 1, BACK = 2, CLOSE = 3 },
    SkipReason = { TOUR_ENDED_EARLY = 1 },
    LifecycleType = { TOUR_STARTED = 1, TOUR_COMPLETED = 2, TOUR_STOPPED = 3 },
    StopReason = { DISMISS = 1, ABORT = 2 },
    StartContext = { ROOT = 1, GATEWAY = 2, IDLE = 3 }
}

function module.buildTourSessionFields(arg1)
    local currentScopeTour = arg1.currentScopeTour
    return {
        screen_scope_id = arg1.screenScopeId,
        scope_id = if currentScopeTour == nil then nil else currentScopeTour.id,
        root_array = arg1.activeTourType,
        global_step_index = arg1.globalStepIndex,
        global_total_steps = arg1.globalTotalSteps
    }
end

function module.logTourtipInteraction(interactionType: number, entryId: string, button: number?, arg1, skipReason: number?)
    local customFields = module.buildTourSessionFields(arg1)
    customFields.entry_id = entryId
    customFields.interaction_type = interactionType
    customFields.button = button

    local currentEntry = arg1.currentEntry
    if currentEntry ~= nil and entryId == currentEntry.id then
        customFields.is_gateway = currentEntry.gateway ~= nil
    end

    if skipReason ~= nil then
        customFields.skip_reason = skipReason
    end

    TelemetryService:LogEvent(
        Events.tourtipInteraction,
        { standardizedFields = standardizedFields, customFields = customFields }
    )
end

function module.logTourLifecycle(lifecycleType: number, arg1, stopReason: number?, startContext: number?)
    local customFields = module.buildTourSessionFields(arg1)
    customFields.lifecycle_type = lifecycleType
    if stopReason ~= nil then
        customFields.stop_reason = stopReason
    end
    if startContext ~= nil then
        customFields.start_context = startContext
    end

    TelemetryService:LogEvent(
        Events.tourLifecycle,
        { standardizedFields = standardizedFields, customFields = customFields }
    )
end

return module
