-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T05:11:16Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local LoggingProtocol = require(scriptParentParent.LoggingProtocol)

local default = LoggingProtocol.default

local tbl1 = {
    eventName = "AdMenuEvent",
    backends = { LoggingProtocol.TelemetryBackends.Counter },
    lastUpdated = { 24, 10, 29 },
    description = "        This event is fired when a user interacts with the ad menu.\n    ",
    links = "https://roblox.atlassian.net/browse/ADS-6383"
}

local tbl2 = {
    eventName = "WhyThisAdEvent",
    backends = { LoggingProtocol.TelemetryBackends.Counter },
    lastUpdated = { 24, 10, 29 },
    description = "        This event is fired when a user interacts with the \"Why this ad?\" button.\n    ",
    links = "https://roblox.atlassian.net/browse/ADS-6383"
}

local tbl3 = {
    eventName = "ReportAdEvent",
    backends = { LoggingProtocol.TelemetryBackends.Counter },
    lastUpdated = { 24, 10, 29 },
    description = "        This event is fired when a user interacts with the \"Report this ad\" button.\n    ",
    links = "https://roblox.atlassian.net/browse/ADS-6383"
}

local tbl4 = {
    eventName = "ImmersiveBrandedAdButtonClickEvent",
    backends = { LoggingProtocol.TelemetryBackends.Counter },
    lastUpdated = { 26, 3, 11 },
    description = "This event is fired when a user clicks one of the immersive branded ad buttons (disclosure, \"Why this ad?\", or \"Report this ad\").",
    links = ""
}

local tbl5 = {
    eventName = "ImmersiveBrandedAdLinkingFailedEvent",
    backends = { LoggingProtocol.TelemetryBackends.Counter },
    lastUpdated = { 26, 3, 24 },
    description = "This event is fired when a user tries to click one of the immersive branded ad menu/dialog links, but LinkingProtocol fails.",
    links = ""
}

local module = {}

function module.logAdMenuEvent(state: string)
    default:logRobloxTelemetryCounter(tbl1, 1, { state = state })
end

function module.logWhyThisAdEvent()
    default:logRobloxTelemetryCounter(tbl2, 1)
end

function module.logReportAdEvent(state: string)
    default:logRobloxTelemetryCounter(tbl3, 1, { state = state })
end

function module.logImmersiveBrandedAdButtonClickCounter(buttonName: string)
    default:logRobloxTelemetryCounter(tbl4, 1, { buttonName = buttonName })
end

function module.logImmersiveBrandedAdLinkingFailedCounter(linkName: string)
    default:logRobloxTelemetryCounter(tbl5, 1, { linkName = linkName })
end

return module
