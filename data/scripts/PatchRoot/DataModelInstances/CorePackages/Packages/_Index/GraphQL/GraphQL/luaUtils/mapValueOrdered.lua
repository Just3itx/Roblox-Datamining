-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T08:01:01Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local Map = require(scriptParentParentParent.LuauPolyfill).Map

return {
    mapValueOrdered = function(arg1, func1: (...any) -> (...any))
        local map = Map.new()
        for _, value in arg1 do
            local var1 = value[1]
            map:set(var1, func1(value[2], var1))
        end
        return map
    end
}
