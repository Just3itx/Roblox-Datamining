-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T07:51:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local Map = require(scriptParentParentParent.LuauPolyfill).Map

return {
    keyValMap = function(arg1, func1: (...any) -> (...any), func2: (...any) -> (...any))
        local map = Map.new()
        for _, value in ipairs(arg1) do
            map:set(func1(value), func2(value))
        end
        return map
    end
}
