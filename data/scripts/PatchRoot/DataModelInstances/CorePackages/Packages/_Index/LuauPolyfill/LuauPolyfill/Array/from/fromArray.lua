-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T04:41:13Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local _types = require(scriptParentParentParent.types)

return function(arg1, func1: ((...any) -> (...any))?, arg2)
    if not func1 then
        return (table.clone(arg1))
    end

    local num1 = #arg1
    local var1 = table.create(num1)
    for i = 1, num1 do
        if arg2 ~= nil then
            var1[i] = func1(arg2, arg1[i], i)
        else
            var1[i] = func1(arg1[i], i)
        end
    end

    return var1
end
