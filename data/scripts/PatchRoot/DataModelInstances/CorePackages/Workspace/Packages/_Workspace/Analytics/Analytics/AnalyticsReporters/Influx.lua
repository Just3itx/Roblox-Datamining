-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T06:10:45Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local module = ({})
module.__index = module

function module.new(_reporter)
    local str1 = type(_reporter)
    assert(str1 == "table" or str1 == "userdata", "Unexpected value for reportingService")

    local tbl1 = { _reporter = _reporter, _isEnabled = true }

    setmetatable(tbl1, module)

    return tbl1
end

function module:setEnabled(_isEnabled: boolean)
    assert(type(_isEnabled) == "boolean", "Expected isEnabled to be a boolean")
    self._isEnabled = _isEnabled
end

function module:reportSeries(str1: string, tbl1, num1: number)
    tbl1 = tbl1 or {}

    assert(type(str1) == "string", "Expected seriesName to be a string")
    assert(type(tbl1) == "table", "Expected additionalArgs to be a table")
    assert(type(num1) == "number", "Expected throttlingPercent to be a number")
    assert(num1 >= 0 and num1 <= 10000, "throttlingPercent must be between 0 - 10,000")
    assert(self._isEnabled, "This reporting service is disabled")

    self._reporter:ReportInfluxSeries(str1, tbl1, num1)
end

return module
