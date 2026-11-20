-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T02:31:27Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local __DEV__ = _G.__DEV__
local scriptParentParentParent = script.Parent.Parent.Parent
local _ES7Types = require(scriptParentParentParent.ES7Types)

return function(arg1, func1: (...any) -> (...any), arg2)
    if __DEV__ then
        if typeof(arg1) ~= "table" then
            error(string.format("Array.every called on %s", typeof(arg1)))
        end
        if typeof(func1) ~= "function" then
            error("callback is not a function")
        end
    end

    local num1 = #arg1
    local num2 = 1

    while num2 <= num1 do
        local var1 = arg1[num2]

        if var1 ~= nil and not (if arg2 ~= nil then func1(arg2, var1, num2, arg1) else func1(var1, num2, arg1)) then
            return false
        end

        num2 += 1
    end
    return true
end
