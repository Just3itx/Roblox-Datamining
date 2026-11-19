-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T10:50:37Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local _types = require(scriptParentParent.types)

return function(arg1, func1: (...any) -> (...any), arg2)
    if _G.__DEV__ then
        if typeof(arg1) ~= "table" then
            error(string.format("Array.filter called on %s", typeof(arg1)))
        end
        if typeof(func1) ~= "function" then
            error("callback is not a function")
        end
    end

    local num1 = #arg1
    local result = ({})
    local num2 = 1

    if arg2 == nil then
        for i = 1, num1 do
            local var1 = arg1[i]
            if var1 ~= nil and func1(var1, i, arg1) then
                result[num2] = var1
                num2 += 1
            end
        end

        return result
    end

    for i = 1, num1 do
        local var1 = arg1[i]
        if var1 ~= nil and func1(arg2, var1, i, arg1) then
            result[num2] = var1
            num2 += 1
        end
    end

    return result
end
