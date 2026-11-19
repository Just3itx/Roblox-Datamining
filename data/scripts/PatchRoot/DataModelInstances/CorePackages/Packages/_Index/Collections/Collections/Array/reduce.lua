-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T06:01:13Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local __DEV__ = _G.__DEV__
local scriptParentParentParent = script.Parent.Parent.Parent
local _ES7Types = require(scriptParentParentParent.ES7Types)

return function(arg1, func1: (...any) -> (...any), arg2)
    if __DEV__ then
        if typeof(arg1) ~= "table" then
            error(string.format("Array.reduce called on %s", typeof(arg1)))
        end
        if typeof(func1) ~= "function" then
            error("callback is not a function")
        end
    end

    local num1 = #arg1
    local num2

    if arg2 == nil then
        num2 = 2
        if num1 == 0 then
            error("reduce of empty array with no initial value")
        end
        arg2 = arg1[1]
    else
        num2 = 1
    end

    for i = num2, num1 do
        arg2 = func1(arg2, arg1[i], i, arg1)
    end

    return arg2
end
