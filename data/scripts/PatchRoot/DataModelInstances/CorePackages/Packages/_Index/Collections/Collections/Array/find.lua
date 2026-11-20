-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T02:31:30Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local _ES7Types = require(scriptParentParentParent.ES7Types)

return function(arg1, func1: (...any) -> (...any))
    for i = 1, #arg1 do
        local var1 = arg1[i]
        if func1(var1, i, arg1) then
            return var1
        end
    end
    return nil
end
