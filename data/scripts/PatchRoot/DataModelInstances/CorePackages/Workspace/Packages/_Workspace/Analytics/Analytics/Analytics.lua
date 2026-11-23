-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T06:10:37Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RbxAnalyticsService = game:GetService("RbxAnalyticsService")
local AnalyticsReporters = script.Parent.AnalyticsReporters

local Diag = require(AnalyticsReporters.Diag)
local EventStream = require(AnalyticsReporters.EventStream)
local GoogleAnalytics = require(AnalyticsReporters.GoogleAnalytics)
local Influx = require(AnalyticsReporters.Influx)

local module = ({})
module.__index = module

function module.new(arg1)
    arg1 = arg1 or RbxAnalyticsService

    local tbl1 = {
        Diag = Diag.new(arg1),
        EventStream = EventStream.new(arg1),
        GoogleAnalytics = GoogleAnalytics.new(arg1),
        InfluxDb = Influx.new(arg1)
    }
    setmetatable(tbl1, module)

    return tbl1
end

function module.mock()
    return module.new({
        ReportCounter = function() end,
        ReportInfluxSeries = function() end,
        ReportStats = function() end,
        SetRBXEvent = function() end,
        SetRBXEventStream = function() end,
        TrackEvent = function() end,
        UpdateHeartbeatObject = function() end,
        SendEventDeferred = function() end
    })
end
return module
