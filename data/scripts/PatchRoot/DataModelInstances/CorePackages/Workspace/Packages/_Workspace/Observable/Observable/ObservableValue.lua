-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T00:50:40Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent

local Signal = require(scriptParentParent.AppCommonLib).Signal

local module = {}
module.__index = module

local function defaultCompareFn(arg1, arg2): boolean
    return arg1 == arg2
end

function module.new(_value, _isEqual: ((...any) -> (...any))?)
    return (setmetatable({ _isEqual = _isEqual or defaultCompareFn, _value = _value, _changeSignal = Signal.new() }, module))
end

function module:get()
    return self._value
end

function module:set(_value)
    if not self._isEqual(self._value, _value) then
        self._value = _value
        self._changeSignal:fire(_value)
    end
end

function module:connect(callback, arg1)
    local connection = self._changeSignal:connect(callback)
    if arg1 == true then
        callback(self._value)
    end
    return connection
end

function module:__tostring(): string
    return "ObservableValue(" .. tostring(self._value) .. ")"
end

return module
