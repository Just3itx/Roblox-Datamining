-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T06:00:43Z
-- Luau bytecode version: 9 | Luau type version: 3
local scriptParent = script.Parent

local Array = require(script.Array)
local Map = require(script.Map)
local Object = require(script.Object)
local Set = require(script.Set)
local WeakMap = require(script.WeakMap)
local inspect = require(script.inspect)

local _ES7Types = require(scriptParent.ES7Types)

return {
    Array = Array,
    Object = Object,
    Map = Map.Map,
    coerceToMap = Map.coerceToMap,
    coerceToTable = Map.coerceToTable,
    Set = Set,
    WeakMap = WeakMap,
    inspect = inspect
}
