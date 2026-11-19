-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T06:21:05Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local module = {}
module.__index = module

function module.new()
    return (setmetatable({ _keys = {}, _present = {}, _values = {} }, module))
end

function module.newMap(arg1)
    local module2 = module.new()
    for value, value2 in arg1:entrySet() do
        module2:put(value, value2)
    end
    return module2
end

local of = table.freeze(
    (setmetatable({ _keys = table.freeze({}), _present = table.freeze({}), _values = table.freeze({}) }, module))
)

function module.of()
    return of
end

function module:put(arg1, arg2)
    local var2 = self._values[arg1]
    if self._present[arg1] == nil then
        table.insert(self._keys, arg1)
        self._present[arg1] = true
    end
    self._values[arg1] = arg2
    return var2
end

function module:remove(arg1)
    if self._present[arg1] == nil then
        return nil
    end
    local var2 = self._values[arg1]
    table.remove(self._keys, table.find(self._keys, arg1))
    self._present[arg1] = nil
    self._values[arg1] = nil
    return var2
end

function module:get(arg1)
    return self._values[arg1]
end

function module:containsKey(arg1): boolean
    return self._present[arg1] ~= nil
end

function module:size(): number
    return #self._keys
end

function module:isEmpty(): boolean
    return #self._keys == 0
end

function module:entrySet()
    local _keys = self._keys
    local _values = self._values
    local num1 = 0
    return function()
        num1 += 1
        local _key = _keys[num1]
        if _key == nil then
            return nil, nil
        end
        return _key, _values[_key]
    end
end

return module
