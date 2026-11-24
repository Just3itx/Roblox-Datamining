-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T18:21:14Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local TelemetryService = game:GetService("TelemetryService")
local StandardFieldEnum = require(script.Parent.StandardFieldEnum)

local throttlingPercentage = game:DefineFastInt("HelpPageThrottleHundredthsPercent", 0)

local module = ({})
module.__index = module

function module.new()
    return (setmetatable({}, module))
end

module.telemetryConfigs = {
    helpPageInteraction = {
        eventConfig = {
            eventName = "ingame_menu_action",
            backends = { "EventIngest" },
            throttlingPercentage = throttlingPercentage,
            lastUpdated = { 2025, 8, 25 },
            description = "[[Event to track input type and screen orientation for the help page.]]"
        },
        standardizedFields = {
            StandardFieldEnum.addUniverseId,
            StandardFieldEnum.addPlaySessionId,
            StandardFieldEnum.addPlaceId,
            StandardFieldEnum.addSessionInfo
        }
    }
}

function module.logHelpPageInteraction(_, eventContext: string, customFields)
    local eventConfig = module.telemetryConfigs.helpPageInteraction.eventConfig
    local standardizedFields = module.telemetryConfigs.helpPageInteraction.standardizedFields

    TelemetryService:LogEvent(
        eventConfig,
        {
            eventContext = eventContext,
            standardizedFields = standardizedFields,
            customFields = customFields
        }
    )
end
module.default = module.new()
return module
