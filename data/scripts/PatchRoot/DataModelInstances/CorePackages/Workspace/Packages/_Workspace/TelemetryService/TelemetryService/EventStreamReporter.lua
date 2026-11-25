-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T18:41:01Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local module = {}
module.__index = module

function module.new(_reporter)
    local tbl1 = { _reporter = _reporter, _isEnabled = true }

    setmetatable(tbl1, module)

    return tbl1
end

function module:setEnabled(_isEnabled: boolean)
    self._isEnabled = _isEnabled
end

function module:sendTelemetryEvent(str1: string, eventName: string, tbl1)
    tbl1 = tbl1 or {}

    assert(type(str1) == "string", "Expected eventContext to be a string")
    assert(type(eventName) == "string", "Expected eventName to be a string")
    assert(type(tbl1) == "table", "Expected additionalArgs to be a table")
    assert(self._isEnabled, "This reporting service is disabled")

    self._reporter:logRobloxTelemetryEvent(
        {
            eventName = eventName,
            backends = { "EventIngest" },
            throttlingPercentage = 10000
        },
        { "addSessionId", "addSessionInfo" },
        tbl1,
        str1
    )
end
return module
