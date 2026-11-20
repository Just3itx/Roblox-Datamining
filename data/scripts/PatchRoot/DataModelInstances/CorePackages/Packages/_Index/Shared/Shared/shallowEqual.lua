-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T15:21:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local objectIs = require(script.Parent.objectIs)

local function shallowEqual(arg1, arg2)
    if objectIs(arg1, arg2) then
        return true
    end

    if typeof(arg1) ~= "table" or arg1 == nil or typeof(arg2) ~= "table" or arg2 == nil then
        return false
    end

    for value, value2 in arg1 do
        if not objectIs(arg2[value], value2) then
            return false
        end
    end

    for value, value2 in arg2 do
        if not objectIs(arg1[value], value2) then
            return false
        end
    end

    return true
end

return shallowEqual
