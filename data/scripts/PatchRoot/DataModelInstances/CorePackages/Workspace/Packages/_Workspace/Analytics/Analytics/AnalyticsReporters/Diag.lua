-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T06:10:40Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UserInputService = game:GetService("UserInputService")

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

function module:reportCounter(str1: string, num1: number)
    assert(type(str1) == "string", "Expected counterName to be a string")
    assert(type(num1) == "number", "Expected amount to be a number")
    assert(self._isEnabled, "This reporting service is disabled")

    local none = Enum.Platform.None
    pcall(function()
        none = UserInputService:GetPlatform()
    end)
    local xBoxOne = Enum.Platform.XBoxOne

    if none == xBoxOne then
        str1 = "Xbox-" .. tostring(str1)
    end

    self._reporter:ReportCounter(str1, num1)
end

function module:reportCounterSimple(str1: string, num1: number)
    if self._isEnabled then
        self._reporter:ReportCounter(str1, num1)
    end
end

function module:reportStats(str1: string, num1: number)
    assert(type(str1) == "string", "Expected category to be a string")
    assert(type(num1) == "number", "Expected value to be a number")
    assert(self._isEnabled, "This reporting service is disabled")

    self._reporter:ReportStats(str1, num1)
end

return module
