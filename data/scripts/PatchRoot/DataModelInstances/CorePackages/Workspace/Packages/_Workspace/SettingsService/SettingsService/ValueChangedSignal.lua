-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T13:51:12Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local scriptParentParent = scriptParent.Parent

local Signal = require(scriptParentParent.AppCommonLib).Signal
local _Types = require(scriptParent.Types)

local module = {}
module.__index = module

function module.new(_value)
    return (setmetatable({ _value = _value, _changeSignal = Signal.new() }, module))
end

function module:get()
    return self._value
end

function module:set(_value)
    if self._value ~= _value then
        self._value = _value
        self._changeSignal:fire(_value)
    end
end

function module:signal()
    return self._changeSignal
end

function module:connect(callback, arg1)
    local connection = self._changeSignal:connect(callback)
    if arg1 == true then
        callback(self._value)
    end
    return connection
end

return module
