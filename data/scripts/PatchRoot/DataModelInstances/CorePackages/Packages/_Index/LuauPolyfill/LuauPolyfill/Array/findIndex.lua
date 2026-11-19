-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T10:50:39Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local _types = require(scriptParentParent.types)

return function(arg1, func1: (...any) -> (...any))
    for i = 1, #arg1 do
        if func1(arg1[i], i, arg1) then
            return i
        end
    end
    return -1
end
