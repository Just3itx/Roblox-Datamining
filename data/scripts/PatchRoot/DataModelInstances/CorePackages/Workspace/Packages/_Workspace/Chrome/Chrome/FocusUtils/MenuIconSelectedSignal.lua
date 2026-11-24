-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T00:40:46Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent

local Signal = require(scriptParentParentParent.AppCommonLib).Signal

local tbl1 = {}
tbl1.__index = tbl1

function tbl1.new()
    return (setmetatable({ _value = false, _changeSignal = Signal.new() }, tbl1))
end

function tbl1:get()
    return self._value
end

function tbl1:set(_value: boolean)
    if self._value ~= _value then
        self._value = _value
        self._changeSignal:fire(_value)
    end
end

function tbl1:connect(callback, arg1)
    local connection = self._changeSignal:connect(callback)
    if arg1 == true then
        callback(self._value)
    end
    return connection
end

return tbl1.new()
