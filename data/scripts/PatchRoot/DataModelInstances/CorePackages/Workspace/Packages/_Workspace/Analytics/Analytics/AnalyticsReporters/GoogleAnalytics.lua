-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T06:10:44Z
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

function module:trackEvent(str1: string, str2: string, str3: string?, num1: number?)
    assert(type(str1) == "string", "Expected category to be a string")
    assert(type(str2) == "string", "Expected action to be a string")
    if str3 then
        assert(type(str3) == "string", "Expected label to be a string")
    end
    if num1 then
        assert(type(num1) == "number", "Expected value to be a number")
        assert(num1 >= 0, "Expected value must not be a negative value")
    end
    assert(self._isEnabled, "This reporting service is disabled")

    self._reporter:TrackEvent(str1, str2, str3, num1)
end

return module
