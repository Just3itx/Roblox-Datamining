-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T10:50:47Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local _types = require(scriptParentParentParent.types)

return function(str1: string, func1: ((...any) -> (...any))?, arg1)
    local num1 = #str1
    local var1 = table.create(num1)
    if not func1 then
        for i = 1, num1 do
            var1[i] = string.sub(str1, i, i)
        end

        return var1
    end

    for i = 1, num1 do
        if arg1 ~= nil then
            var1[i] = func1(arg1, string.sub(str1, i, i), i)
        else
            var1[i] = func1(string.sub(str1, i, i), i)
        end
    end

    return var1
end
