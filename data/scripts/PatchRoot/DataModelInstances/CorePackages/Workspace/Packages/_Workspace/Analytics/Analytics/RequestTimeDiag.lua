-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T06:10:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ReportToDiagByCountryCode = require(script.Parent.ReportToDiagByCountryCode)

local module = {}
module.__index = module

function module.new(arg1, metricName)
    assert(metricName, "metricName is required")
    return (setmetatable({ metricName = metricName, startTime = tick() }, arg1))
end

function module.report(arg1)
    local var1 = tick() - arg1.startTime
    ReportToDiagByCountryCode(arg1.metricName, "RoundTripTime", var1, 100)
end

return module
