-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T10:41:08Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RunService = game:GetService("RunService")
local DiscoveryAnalyticsParent = script:FindFirstAncestor("DiscoveryAnalytics").Parent
local LoggingProtocol = require(DiscoveryAnalyticsParent.LoggingProtocol)
local default = LoggingProtocol.default

local throttlingPercentage = game:DefineFastInt("DiscoveryWarningEventHundredthsPercent", 0)

local tbl1 = {
    eventName = "DiscoveryWarning",
    backends = { default.TelemetryBackends.Points },
    throttlingPercentage = throttlingPercentage,
    lastUpdated = { 25, 1, 22 },
    description = "Generic warning message for Discovery surfaces",
    links = ""
}

local tbl2 = {
    eventName = "DiscoveryWarningCounter",
    backends = { LoggingProtocol.TelemetryBackends.Counter },
    throttlingPercentage = 0,
    lastUpdated = { 25, 1, 22 },
    description = "Counter for the total number of warnings sent"
}

local function reportWarning(arg1, category: string, extraMessage: string, tbl3)
    local var1 = tbl3 and table.clone(tbl3) or {}
    var1.category = category
    var1.extraMessage = extraMessage

    if RunService:IsStudio() or _G.__TESTEZ_RUNNING_TEST__ or _G.__TEST_SUITE_PACKAGE__ then
        warn(`DiscoveryWarning: [{category}] {extraMessage}`)
    end

    arg1:logRobloxTelemetryCounter(tbl2, 1, { category = category })

    arg1:logRobloxTelemetryEvent(tbl1, { arg1.StandardizedFields.addOsInfo }, var1)
end

return reportWarning
