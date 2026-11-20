-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T02:40:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local _ES7Types = require(scriptParentParentParent.ES7Types)

return function(arg1, func1: (...any) -> (...any), arg2)
    if typeof(arg1) ~= "table" then
        error(string.format("Array.some called on %s", typeof(arg1)))
    end
    if typeof(func1) ~= "function" then
        error("callback is not a function")
    end

    for value, value2 in arg1 do
        if arg2 ~= nil then
            if value2 ~= nil and func1(arg2, value2, value, arg1) then
                return true
            end
        elseif value2 ~= nil and func1(value2, value, arg1) then
            return true
        end
    end

    return false
end
