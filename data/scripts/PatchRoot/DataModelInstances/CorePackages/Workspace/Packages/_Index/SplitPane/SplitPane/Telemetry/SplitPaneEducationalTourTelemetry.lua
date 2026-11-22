-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T21:31:27Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")

local SplitPaneParent = script:FindFirstAncestor("SplitPane").Parent

local TelemetryService = require(SplitPaneParent.MockableProxyServices).TelemetryService
local LoggingProtocol = require(SplitPaneParent.LoggingProtocol)
local Display = require(SplitPaneParent.Display)
local Responsive = require(SplitPaneParent.Responsive)

local EndReason = {
    TooltipHiddenTimeout = 1,
    UserChanged = 2,
    HostUnmounted = 3,
    BreakpointLost = 4,
    DeepLink = 5
}

local tbl2 = { Collapsed = 1, Open = 2 }
local tbl3 = { Pointer = 1, Touch = 2, Gamepad = 3 }

local tbl4 = {
    "delivered",
    "started",
    "step_shown",
    "step_advanced",
    "skipped",
    "completed",
    "abandoned",
    "interrupted",
    "restarted"
}
local tbl5 = {
    [EndReason.TooltipHiddenTimeout] = "tooltip_hidden_timeout",
    [EndReason.UserChanged] = "user_changed",
    [EndReason.HostUnmounted] = "host_unmounted",
    [EndReason.BreakpointLost] = "breakpoint_lost",
    [EndReason.DeepLink] = "deep_link"
}

local tbl6 = {
    eventName = "splitPaneTourEvent",
    backends = { LoggingProtocol.TelemetryBackends.EventIngest },
    throttlingPercentage = game:DefineFastInt("SplitPaneTourEventTelemetryThrottleHundredthsPercent", 10000),
    lastUpdated = { 2026, 10, 13 },
    description = "Split Pane educational tour lifecycle, from delivery through its ending."
}

local tbl7 = {
    eventName = "SplitPane_TourEvent",
    backends = { LoggingProtocol.TelemetryBackends.Counter },
    lastUpdated = { 2026, 10, 13 },
    description = "Split Pane educational tour lifecycle events by type and end reason."
}

local standardizedFields = { "addSessionId", "addOSInfo" }

local var1 = nil

local function getInputMode(): number -- Luacid: unused: defined but never referenced
    local var2 = Responsive.GetInputModeStore(false).getPreferredInputType(false)

    if var2 == Responsive.Input.Directional then
        return 3
    end

    if var2 == Responsive.Input.Touch then
        return 2
    end

    return 1
end

local function getPaneState(bool1: boolean): number -- Luacid: unused: defined but never referenced
    return if bool1 then 1 else 2
end

local function getOrCreateRun() -- Luacid: Inlined by compiler; 4 call sites recovered
    if var1 == nil then
        var1 = {
            id = HttpService:GenerateGUID(false),
            hasStarted = false,
            didTourOpenPane = false
        }
    end

    return var1
end

local function log(eventType: number, tbl9)
    local orCreateRun = getOrCreateRun()
    local displayStore = Display.GetDisplayStore(false)
    local platformScale = displayStore.getPlatformScale(false)
    local customFields = table.clone(tbl9)
    customFields.tour_run_id = orCreateRun.id
    customFields.event_type = eventType
    local var3 = Responsive.GetInputModeStore(false).getPreferredInputType(false)

    customFields.input_mode = if var3 == Responsive.Input.Directional then tbl3.Gamepad elseif var3 == Responsive.Input.Touch then tbl3.Touch else tbl3.Pointer
    customFields.start_pane_state = orCreateRun.startPaneState
    customFields.viewport_width = math.round((displayStore.getDesignSpaceViewportWidth(false)))
    customFields.viewport_height = math.round(
        displayStore.getViewportSize(false).Y / (if platformScale then if platformScale > 0 then platformScale else 1 else 1)
    )
    TelemetryService:LogEvent(tbl6, { standardizedFields = standardizedFields, customFields = customFields })

    TelemetryService:LogCounter(tbl7, {
        customFields = {
            event_type = tbl4[eventType],
            end_reason = if tbl9.end_reason == nil then "none" else tbl5[tbl9.end_reason]
        }
    }, 1)
end

local function getStepDurationMs() -- Luacid: Inlined by compiler; 2 call sites recovered
    local stepShownAt = if var1 == nil then nil else var1.stepShownAt

    if stepShownAt == nil then
        return nil
    end

    return math.round((os.clock() - stepShownAt) * 1000)
end

local module = { EndReason = EndReason }

function module.logDelivered(totalSteps: number)
    if var1 ~= nil and var1.hasStarted then
        return
    end
    var1 = nil
    log(1, { total_steps = totalSteps })
end

function module.logStepShown(stepIndex: number, totalSteps: number, bool1: boolean)
    local orCreateRun = getOrCreateRun()

    if stepIndex == 1 and not orCreateRun.hasStarted then
        orCreateRun.hasStarted = true
        orCreateRun.startPaneState = if bool1 then tbl2.Collapsed else tbl2.Open
        log(2, { step_index = stepIndex, total_steps = totalSteps })
    elseif stepIndex == 1 and orCreateRun.interruptedAtStep ~= nil then
        log(9, { step_index = stepIndex, total_steps = totalSteps, interrupted_at_step = orCreateRun.interruptedAtStep })
    end

    orCreateRun.interruptedAtStep = nil
    orCreateRun.stepShownAt = os.clock()
    log(3, { step_index = stepIndex, total_steps = totalSteps })
end

function module.logStepAdvanced(stepIndex: number, totalSteps: number, bool1: boolean)
    if bool1 then
        getOrCreateRun().didTourOpenPane = true
    end
    log(4, { step_index = stepIndex, total_steps = totalSteps, step_duration_ms = getStepDurationMs() })
end

function module.logInterrupted(num1: number, totalSteps: number)
    if var1 == nil or not var1.hasStarted then
        return
    end
    local var2 = var1
    var2.interruptedAtStep = num1
    var2.stepShownAt = nil
    log(8, { step_index = num1, total_steps = totalSteps, interrupted_at_step = num1 })
end

function module.logUserEnded(bool1: boolean, stepIndex: number, totalSteps: number, bool2: boolean)
    log(if bool1 then 6 else 5, {
        step_index = stepIndex,
        total_steps = totalSteps,
        step_duration_ms = getStepDurationMs(),
        end_pane_state = if bool2 then tbl2.Collapsed else tbl2.Open,
        did_tour_open_pane = getOrCreateRun().didTourOpenPane
    })
    var1 = nil
end

function module.logAbandoned(endReason: number, stepIndex: number, totalSteps: number, bool1: boolean)
    if var1 == nil then
        return
    end
    local func1 = log
    local num2 = 7
    local tbl9 = {
        step_index = 0,
        total_steps = 0,
        end_pane_state = 0,
        end_reason = 0,
        did_tour_open_pane = 0,
        interrupted_at_step = 0
    }

    if not (stepIndex > 0) then
        stepIndex = nil
    end

    tbl9.step_index = stepIndex
    tbl9.total_steps = totalSteps
    tbl9.end_pane_state = if bool1 then tbl2.Collapsed else tbl2.Open
    tbl9.end_reason = endReason
    tbl9.did_tour_open_pane = var1.didTourOpenPane
    tbl9.interrupted_at_step = var1.interruptedAtStep
    func1(num2, tbl9)

    var1 = nil
end

return module
