-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T03:01:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local TelemetryService = game:GetService("TelemetryService")

local throttlingPercentage = game:DefineFastInt("PlayerListContextMenuTelemetryThrottleHundredthsPercent", 10000)

local _PlayerListContextMenuTelemetryAction = require(script.Parent.PlayerListContextMenuTelemetryAction)

local lastUpdated = { 2026, 8, 4 }

local config = {
    eventName = "coreui_playerlist_context_menu_action",
    backends = { "EventIngest" },
    throttlingPercentage = throttlingPercentage,
    lastUpdated = lastUpdated,
    description = "Fired when the PlayerList contextual menu is opened, closed, or an action row is activated."
}

local config2 = {
    eventName = "coreui_playerlist_context_menu_action",
    backends = { "RobloxTelemetryCounter" },
    throttlingPercentage = throttlingPercentage,
    lastUpdated = lastUpdated,
    description = "Counter for PlayerList contextual menu open / close / action activations."
}

return {
    logAction = function(action, tbl2)
        local standardizedFields = {
            "addPlaceId",
            "addUniverseId",
            "addSessionInfo",
            "addSessionId",
            "addPlaySessionId"
        }
        local customFields = { action = action }

        if tbl2 ~= nil then
            if tbl2.isSelf ~= nil then
                customFields.is_self = tostring(tbl2.isSelf)
            end
            if tbl2.friendStatus ~= nil then
                customFields.friend_status = tbl2.friendStatus
            end
        end

        local tbl5 = { standardizedFields = standardizedFields, customFields = customFields }
        TelemetryService:LogEvent(config, tbl5)
        TelemetryService:LogCounter(config2, tbl5, 1)
    end,
    _setServicesForTesting = function(arg1)
        TelemetryService = arg1
    end
}
