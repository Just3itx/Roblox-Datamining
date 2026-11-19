-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T10:51:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local Parent = require(script.Parent)
local Object = require(scriptParentParent.Object)
local instanceof = require(scriptParentParent.instanceof)
local _types = require(scriptParentParent.types)

local function coerceToMap(arg1)
    return instanceof(arg1, Parent) and arg1 or Parent.new(Object.entries(arg1))
end

return coerceToMap
