-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T19:20:42Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GetFFlagVoiceDebugConsoleV2 = require(script.Parent.Components.VoiceDebug.GetFFlagVoiceDebugConsoleV2)

local module = {}
module.__index = module

function module.new(_maxSize)
    assert(_maxSize, "Cannot initialize CircularBuffer with nil")
    assert(_maxSize > 0, "Cannot initialize CircularBuffer to size < 1")

    local result = {}
    setmetatable(result, module)

    result._data = {}
    result._backIndex = 0
    result._maxSize = _maxSize

    return result
end

function module:reset()
    self._data = {}
    self._backIndex = 0
end

function module:getSize(): number
    return #self._data
end

function module:getMaxSize()
    return self._maxSize
end

function module:setSize(_maxSize)
    assert(_maxSize, "Cannot set CircularBuffer with nil")
    assert(_maxSize > 0, "Cannot set CircularBuffer to size < 1")
    if _maxSize == self._maxSize then
        return
    end

    local var1 = self:iterator()
    local var2 = var1:next()
    local num1 = 0
    local _data = ({})

    while var2 and num1 < _maxSize do
        local num2 = num1 + 1

        _data[num2] = { entry = var2 }

        if _data[num1] then
            _data[num1]._next = _data[num2]
        end

        var2 = var1:next()
        num1 = num2
    end

    self._data = _data
    self._backIndex = num1
    self._maxSize = _maxSize
end

function module:getFrontIndex()
    local var1 = self._backIndex + 1
    return if self._data[var1] then var1 else 1
end

function module:front()
    local frontIndex = self:getFrontIndex()

    if self._data[frontIndex] then
        return self._data[frontIndex].entry
    end

    return nil
end

function module:back()
    if self._data[self._backIndex] then
        return self._data[self._backIndex].entry
    end

    return nil
end

function module:iterator()
    return {
        data = self._data[self:getFrontIndex()],
        next = function(arg1)
            local data = arg1.data
            if data then
                arg1.data = arg1.data._next
            end
            return data and data.entry
        end
    }
end

function module:getData()
    return self._data
end

if GetFFlagVoiceDebugConsoleV2() then
    function module:clone()
        local module2 = module.new(self._maxSize)
        local _data = ({})
        for value, value2 in self._data do
            local tbl2 = {
                entry = value2.entry
            }
            _data[value] = tbl2
        end
        for value, value2 in self._data do
            if value2._next then
                local var1 = value % self._maxSize + 1
                _data[value]._next = _data[var1]
            end
        end
        module2._data = _data
        module2._backIndex = self._backIndex
        return module2
    end
end

function module:at(arg1)
    assert(arg1, "Cannot index CircularBuffer with nil")

    local var1 = (self:getFrontIndex() + arg1 - 2) % self._maxSize + 1

    if self._data[var1] then
        return self._data[var1].entry
    end

    return nil
end

function module:reverseAt(arg1)
    local var1 = (self._backIndex - arg1) % self._maxSize + 1

    if self._data[var1] then
        return self._data[var1].entry
    end

    return nil
end

function module:push_back(entry)
    local _backIndex = self._backIndex
    local var1 = self._backIndex + 1
    local var2 = if self._maxSize < var1 then 1 else var1

    local var3 = self._data[var2]
    self._data[var2] = { entry = entry }

    if _backIndex > 0 then
        self._data[_backIndex]._next = self._data[var2]
        if var3 then
            var3._next = nil
        end
    end

    self._backIndex = var2
    return var3 and var3.entry
end

return module
