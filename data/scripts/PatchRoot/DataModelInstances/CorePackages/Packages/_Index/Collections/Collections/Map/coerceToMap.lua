-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T02:41:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local scriptParentParent = scriptParent.Parent
local scriptParentParentParent = scriptParentParent.Parent

local Map = require(scriptParent.Map)
local Object = require(scriptParentParent.Object)
local InstanceOf = require(scriptParentParentParent.InstanceOf)
local _ES7Types = require(scriptParentParentParent.ES7Types)

local function coerceToMap(arg1)
    return InstanceOf(arg1, Map) and arg1 or Map.new(Object.entries(arg1))
end

return coerceToMap
