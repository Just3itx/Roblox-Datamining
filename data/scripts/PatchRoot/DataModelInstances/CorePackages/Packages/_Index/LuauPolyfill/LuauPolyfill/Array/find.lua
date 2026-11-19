-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T04:41:08Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local _types = require(scriptParentParent.types)

return function(arg1, func1: (...any) -> (...any))
    for i = 1, #arg1 do
        local var1 = arg1[i]
        if func1(var1, i, arg1) then
            return var1
        end
    end
    return nil
end
