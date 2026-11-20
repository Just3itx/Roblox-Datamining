-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T23:11:27Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppShortcutBarParent = script:FindFirstAncestor("AppShortcutBar").Parent

local TelemetryService = require(AppShortcutBarParent.MockableProxyServices).TelemetryService

local tbl1 = {
    eventName = "UnifyShortcutBarExposureLoggedEvent",
    backends = { "EventIngest" },
    throttlingPercentage = 10000,
    lastUpdated = { 26, 11, 11 },
    links = "proto-schemas: production/eventstream/console/unify_shortcut_bar_exposure_logged.proto",
    description = "Once per session, right before the shortcut bar calls LogFlagLinkedUserLayerExposure. Sent to ingest_proto.unify_shortcut_bar_exposure_logged."
}

local function logUnifyShortcutBarExposureLogged(stickyBarEnabled: boolean)
    TelemetryService:LogEvent(tbl1, { customFields = { sticky_bar_enabled = stickyBarEnabled } })
end

return logUnifyShortcutBarExposureLogged
