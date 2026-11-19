-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T06:00:54Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local __DEV__ = _G.__DEV__
local scriptParent = script.Parent
local scriptParentParentParent = scriptParent.Parent.Parent
local isArray = require(scriptParent.isArray)
local _ES7Types = require(scriptParentParentParent.ES7Types)

local function flat(arg1, num1: number?)
    if __DEV__ then
        if typeof(arg1) ~= "table" then
            error(string.format("Array.flat called on %s", typeof(arg1)))
        end
        if num1 ~= nil and typeof(num1) ~= "number" then
            error("depth is not a number or nil")
        end
    end
    local num2 = num1 or 1
    local result = {}

    for _, value in arg1 do
        if isArray(value) then
            if num2 > 1 then
                value = flat(value, num2 - 1)
            end

            for _, value2 in value do
                table.insert(result, value2)
            end
        else
            table.insert(result, value)
        end
    end

    return result
end

return flat
