-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T06:01:20Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local scriptParentParentParent = scriptParentParent.Parent
local None = require(scriptParentParent.Object.None)
local _ES7Types = require(scriptParentParentParent.ES7Types)

local function func1(arg1, arg2): boolean
    return type(arg1) .. tostring(arg1) < type(arg2) .. tostring(arg2)
end

return function<T>(tbl1: {T}, func2: ((...any) -> (...any))?): {T}
    local func3 = func1
    if func2 ~= nil and func2 ~= None then
        if typeof(func2) == "function" then
            func3 = function(arg1, arg2): boolean
                local var1 = func2(arg1, arg2)
                if typeof(var1) ~= "number" then
                    error(("invalid result from compare function, expected number but got %s"):format(typeof(var1)))
                end
                return var1 < 0
            end
        else
            error("invalid argument to Array.sort: compareFunction must be a function")

            func3 = function(arg1, arg2): boolean
                local var1 = func2(arg1, arg2)
                if typeof(var1) ~= "number" then
                    error(("invalid result from compare function, expected number but got %s"):format(typeof(var1)))
                end
                return var1 < 0
            end
        end
    end

    table.sort(tbl1, func3)
    return tbl1
end
