-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T06:00:56Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local __DEV__ = _G.__DEV__
local scriptParent = script.Parent
local scriptParentParentParent = scriptParent.Parent.Parent
local flat = require(scriptParent.flat)
local map = require(scriptParent.map)
local _ES7Types = require(scriptParentParentParent.ES7Types)

local function flatMap(arg1, func1: (...any) -> (...any), arg2)
    if __DEV__ then
        if typeof(arg1) ~= "table" then
            error(string.format("Array.flatMap called on %s", typeof(arg1)))
        end
        if typeof(func1) ~= "function" then
            error("callback is not a function")
        end
    end
    return flat(map(arg1, func1, arg2))
end

return flatMap
