-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T08:01:00Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local Map = require(scriptParentParentParent.LuauPolyfill).Map

return {
    keyMapOrdered = function(arg1, func1: (...any) -> (...any))
        local map = Map.new()
        for i = 1, #arg1 do
            local var1 = arg1[i]
            map:set(func1(var1), var1)
        end
        return map
    end
}
