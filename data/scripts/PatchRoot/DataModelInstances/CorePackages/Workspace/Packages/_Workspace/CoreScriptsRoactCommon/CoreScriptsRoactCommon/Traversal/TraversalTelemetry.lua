-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T01:31:29Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local TelemetryService = game:GetService("TelemetryService")

local throttlingPercentage = game:DefineFastInt("TraversalTelemetryThrottleHundrethsPercent", 0)

local tbl1 = {
    BackButtonActions = {
        eventName = "coreui_inexp_back_button_actions",
        backends = { "EventIngest" },
        throttlingPercentage = throttlingPercentage,
        lastUpdated = { 22, 10, 25 },
        description = "Event fired every time the User engages with Traversal Back Button",
        links = "https://github.rbx.com/Roblox/proto-schemas/pull/8339"
    },
    HistoryMenuButtonActions = {
        eventName = "coreui_inexp_history_chevron_clicks",
        backends = { "EventIngest" },
        throttlingPercentage = throttlingPercentage,
        lastUpdated = { 22, 10, 25 },
        description = "Event fired every time the User engages with Traversal History Menu Button",
        links = "https://github.rbx.com/Roblox/proto-schemas/pull/8339"
    },
    HistoryMenuItemClick = {
        eventName = "coreui_inexp_history_dropdown_clicks",
        backends = { "EventIngest" },
        throttlingPercentage = throttlingPercentage,
        lastUpdated = { 22, 10, 25 },
        description = "Event fired every time the User engages with Traversal History Menu Items",
        links = "https://github.rbx.com/Roblox/proto-schemas/pull/8339"
    },
    HistoryMenuHistoryClick = {
        eventName = "coreui_inexp_history_landing_entrypoint_clicks",
        backends = { "EventIngest" },
        throttlingPercentage = throttlingPercentage,
        lastUpdated = { 22, 10, 25 },
        description = "Event fired every time the User engages with Traversal History Menu's History Item",
        links = "https://github.rbx.com/Roblox/proto-schemas/pull/8339"
    },
    HistoryPageBackButtonClick = {
        eventName = "coreui_inexp_history_back_clicks",
        backends = { "EventIngest" },
        throttlingPercentage = throttlingPercentage,
        lastUpdated = { 22, 10, 25 },
        description = "Event fired every time the User engages with Traversal History Page's Back Button",
        links = "https://github.rbx.com/Roblox/proto-schemas/pull/8339"
    },
    HistoryPageExperienceTileClick = {
        eventName = "coreui_inexp_history_landing_tiles_clicks",
        backends = { "EventIngest" },
        throttlingPercentage = throttlingPercentage,
        lastUpdated = { 22, 10, 25 },
        description = "Event fired every time the User engages with Traversal History Page Tiles",
        links = "https://github.rbx.com/Roblox/proto-schemas/pull/8339"
    },
    TeleportConfirmationActions = {
        eventName = "coreui_inexp_history_leave_page_actions",
        backends = { "EventIngest" },
        throttlingPercentage = throttlingPercentage,
        lastUpdated = { 22, 10, 25 },
        description = "Event fired every time the User engages with Traversal History Leave Confirmation",
        links = "https://github.rbx.com/Roblox/proto-schemas/pull/8339"
    }
}

local module = ({})
module.__index = module

function module.sendBackButtonActionEvent(customFields)
    TelemetryService:LogEvent(
        tbl1.BackButtonActions,
        {
            standardizedFields = { "addPlaceId", "addUniverseId", "addPlaySessionId" },
            customFields = customFields
        }
    )
end

function module.sendHistoryMenuButtonActionEvent(customFields)
    TelemetryService:LogEvent(
        tbl1.HistoryMenuButtonActions,
        {
            standardizedFields = { "addPlaceId", "addUniverseId", "addPlaySessionId" },
            customFields = customFields
        }
    )
end

function module.sendHistoryMenuItemClick(customFields)
    TelemetryService:LogEvent(
        tbl1.HistoryMenuItemClick,
        {
            standardizedFields = { "addPlaceId", "addUniverseId", "addPlaySessionId" },
            customFields = customFields
        }
    )
end

function module.sendHistoryMenuHistoryClick(customFields)
    TelemetryService:LogEvent(
        tbl1.HistoryMenuHistoryClick,
        {
            standardizedFields = { "addPlaceId", "addUniverseId", "addPlaySessionId" },
            customFields = customFields
        }
    )
end

function module.sendHistoryPageBackButtonClick(customFields)
    TelemetryService:LogEvent(
        tbl1.HistoryPageBackButtonClick,
        {
            standardizedFields = { "addPlaceId", "addUniverseId", "addPlaySessionId" },
            customFields = customFields
        }
    )
end

function module.sendHistoryPageExperienceTileClick(customFields)
    TelemetryService:LogEvent(
        tbl1.HistoryPageExperienceTileClick,
        {
            standardizedFields = { "addPlaceId", "addUniverseId", "addPlaySessionId" },
            customFields = customFields
        }
    )
end

function module.sendTeleportConfirmationActions(customFields)
    TelemetryService:LogEvent(
        tbl1.TeleportConfirmationActions,
        {
            standardizedFields = { "addPlaceId", "addUniverseId", "addPlaySessionId" },
            customFields = customFields
        }
    )
end
return module
