-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T06:00:59Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local scriptParentParent = scriptParent.Parent
local scriptParentParentParent = scriptParentParent.Parent
local Set = require(scriptParentParent.Set)
local Map = require(scriptParentParent.Map.Map)
local isArray = require(scriptParent.isArray)
local InstanceOf = require(scriptParentParentParent.InstanceOf)
local _ES7Types = require(scriptParentParentParent.ES7Types)

local fromString = require(script.fromString)
local fromSet = require(script.fromSet)
local fromMap = require(script.fromMap)
local fromArray = require(script.fromArray)

return function(arg1, func1: ((...any) -> (...any))?, arg2)
    if arg1 == nil then
        error("cannot create array from a nil value")
    end
    local str1 = typeof(arg1)

    if str1 == "table" and isArray(arg1) then
        return (fromArray(arg1, func1, arg2))
    elseif InstanceOf(arg1, Set) then
        return (fromSet(arg1, func1, arg2))
    elseif InstanceOf(arg1, Map) then
        return (fromMap(arg1, func1, arg2))
    elseif str1 == "string" then
        return (fromString(arg1, func1, arg2))
    end
    return {}
end
