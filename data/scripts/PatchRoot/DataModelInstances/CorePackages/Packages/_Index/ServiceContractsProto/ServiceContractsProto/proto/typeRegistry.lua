-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T14:41:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local TypeRegistry = {}
TypeRegistry.__index = TypeRegistry

local _message = require(script.Parent.message)

function TypeRegistry.new(tbl2)
    local _types = {}

    for _, value in tbl2 do
        _types[value.descriptor.fullName] = value
    end

    return (setmetatable({ _types = _types }, TypeRegistry))
end

function TypeRegistry:findMessage(str1: string)
    return self._types[str1]
end

function TypeRegistry:register(arg1)
    self._types[arg1.descriptor.fullName] = arg1
end

return {
    TypeRegistry = TypeRegistry,
    default = TypeRegistry.new({})
}
