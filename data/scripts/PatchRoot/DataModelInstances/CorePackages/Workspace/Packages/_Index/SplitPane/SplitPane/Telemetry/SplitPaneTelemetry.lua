-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T21:31:28Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SplitPaneParent = script:FindFirstAncestor("SplitPane").Parent
local TelemetryService = require(SplitPaneParent.MockableProxyServices).TelemetryService
local LoggingProtocol = require(SplitPaneParent.LoggingProtocol)
local _AppSplitView = require(SplitPaneParent.AppSplitView)

local Action = { Launch = 1, Toggle = 2, ViewportChanged = 3 }

local tbl2 = {
    eventName = "splitPaneViewChange",
    backends = { LoggingProtocol.TelemetryBackends.EventIngest },
    throttlingPercentage = game:DefineFastInt("SplitPaneViewChangeTelemetryThrottleHundredthsPercent", 1),
    lastUpdated = { 2026, 10, 12 },
    description = "Resolved split pane visibility at user-session launch, explicit control activation, or viewport change."
}

local tbl3 = {
    eventName = "appLaunchViewport",
    backends = { LoggingProtocol.TelemetryBackends.EventIngest },
    throttlingPercentage = game:DefineFastInt("AppLaunchViewportTelemetryThrottleHundredthsPercent", 10),
    lastUpdated = { 2026, 10, 12 },
    description = "Initial resolved user-session viewport in design-space pixels."
}

local tbl4 = {
    eventName = "SplitPane_StateChanged",
    backends = { LoggingProtocol.TelemetryBackends.Counter },
    lastUpdated = { 2026, 10, 12 },
    description = "Resolved pane mode at user-session launch and changes from toggles or viewport changes."
}

local tbl5 = {
    eventName = "SplitPane_PaneControlPressed",
    backends = { LoggingProtocol.TelemetryBackends.Counter },
    lastUpdated = { 2026, 10, 12 },
    description = "Activations of the support host Back, Expand/Restore, and Close controls."
}

local tbl6 = {
    eventName = "SplitPane_SupportRouteOpened",
    backends = { LoggingProtocol.TelemetryBackends.Counter },
    lastUpdated = { 2026, 10, 12 },
    description = "Root support pane transitions from zero routes to one or more, including remounts and fallback returns."
}

local tbl7 = {
    [Action.Launch] = "launch",
    [Action.Toggle] = "toggle",
    [Action.ViewportChanged] = "viewport_changed"
}

local function getIsViewportReady(tbl8): boolean -- Luacid: Inlined by compiler; 2 call sites recovered
    local var1 = tonumber(tbl8.userId)
    return not (var1 == nil or not (var1 > 0)) and tbl8.viewportSize ~= nil
end

return {
    View = { Shown = 1, Hidden = 2 },
    Action = Action,
    Control = { Back = "back", Expand = "expand", Close = "close" },
    getTelemetryStateFromMode = function(arg1)
        return arg1 or "inactive"
    end,
    logStateChanged = function(toState, num1: number)
        TelemetryService:LogCounter(tbl4, { customFields = { to_state = toState, cause = tbl7[num1] } }, 1)
    end,
    logPaneControlPressed = function(control: string)
        TelemetryService:LogCounter(tbl5, { customFields = { control = control } }, 1)
    end,
    logSupportRouteOpened = function()
        TelemetryService:LogCounter(tbl6, {}, 1)
    end,
    logSplitPaneViewChange = function(tbl8, action: number): boolean
        if not getIsViewportReady(tbl8) then
            return false
        end
        local viewportSize = tbl8.viewportSize
        TelemetryService:LogEvent(tbl2, {
            customFields = {
                view = tbl8.view,
                action = action,
                viewport_width = viewportSize.X,
                viewport_height = viewportSize.Y
            }
        })
        return true
    end,
    logAppLaunchViewport = function(tbl8): boolean
        if not getIsViewportReady(tbl8) then
            return false
        end
        local viewportSize = tbl8.viewportSize
        TelemetryService:LogEvent(tbl3, {
            customFields = {
                viewport_width = viewportSize.X,
                viewport_height = viewportSize.Y,
                is_landscape = tbl8.isLandscape
            }
        })
        return true
    end
}
