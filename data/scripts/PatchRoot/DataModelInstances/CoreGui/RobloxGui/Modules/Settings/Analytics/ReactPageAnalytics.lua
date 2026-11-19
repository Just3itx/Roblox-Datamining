-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T23:41:22Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RbxAnalyticsService = game:GetService("RbxAnalyticsService")
local CorePackages = game:GetService("CorePackages")
local TelemetryService = game:GetService("TelemetryService")

local LoggingProtocol = require(CorePackages.Workspace.Packages.LoggingProtocol)

local engineFeature = game:GetEngineFeature("TelemetryServicePlaySessionInfoEnabled")

local throttlingPercentage = game:DefineFastInt("OpenReactPageThrottleHundredthsPercent", 0)
local num1 = game:DefineFastInt("CloseReactPageThrottleHundredthsPercent", 0)

local module = ({})
module.__index = module

module.configs = {
    openPage = {
        eventName = "ingame_menu_action",
        backends = { LoggingProtocol.TelemetryBackends.EventIngest },
        throttlingPercentage = throttlingPercentage,
        lastUpdated = { 2025, 9, 23 },
        description = "Fires when a React menu page is opened"
    },
    closePage = {
        eventName = "ingame_menu_action",
        backends = { LoggingProtocol.TelemetryBackends.EventIngest },
        throttlingPercentage = num1,
        lastUpdated = { 2025, 9, 23 },
        description = "Fires when a React menu page is closed"
    }
}

function module.new()
    return (setmetatable({}, module))
end

function module._logEventWithStandardizedFields(_, config, eventContext: string, tbl1)
    local standardizedFields = { "addPlaceId", "addUniverseId", "addSessionInfo" }
    local customFields = tbl1 or {}

    if engineFeature then
        table.insert(standardizedFields, "addPlaySessionId")
    else
        customFields.playsessionid = RbxAnalyticsService:GetPlaySessionId()
    end

    TelemetryService:LogEvent(
        config,
        {
            eventContext = eventContext,
            standardizedFields = standardizedFields,
            customFields = customFields
        }
    )
end

function module.openPage(tbl1, str1: string)
    local str2 = `open_{str1}_page`
    tbl1:_logEventWithStandardizedFields(tbl1.configs.openPage, str2)
end

function module.closePage(tbl1, str1: string)
    local str2 = `close_{str1}_page`
    tbl1:_logEventWithStandardizedFields(tbl1.configs.closePage, str2)
end

return module
