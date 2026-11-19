-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T06:30:40Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local CommonMark = script:FindFirstAncestor("CommonMark")
local Escaping = require(CommonMark.internal.util.Escaping)

local module = {}
module.__index = module

function module.new(_type: string)
    return (setmetatable({ _type = _type, _keys = {}, _definitions = {} }, module))
end

local function putIfAbsentNormalized(arg1, str1: string, arg2) -- Luacid: Inlined by compiler; 1 call site recovered
    local _definition = arg1._definitions[str1]
    if _definition ~= nil then
        return _definition
    end
    table.insert(arg1._keys, str1)
    arg1._definitions[str1] = arg2
    return nil
end

function module:getType()
    return self._type
end

function module:addAll(arg1)
    for _, _key in ipairs(arg1._keys) do
        local _definition = arg1._definitions[_key]

        if self._definitions[_key] == nil then
            table.insert(self._keys, _key)
            self._definitions[_key] = _definition
        end
    end
end

function module.putIfAbsent(arg1, str1: string, arg2)
    return putIfAbsentNormalized(arg1, Escaping.normalizeLabelContent(str1), arg2)
end

function module:get(str1: string)
    local var1 = Escaping.normalizeLabelContent(str1)
    return self._definitions[var1]
end

function module:keySet()
    return table.clone(self._keys)
end

function module:values()
    local var1 = table.create(#self._keys)
    for i, _key in ipairs(self._keys) do
        var1[i] = self._definitions[_key]
    end
    return var1
end

return module
