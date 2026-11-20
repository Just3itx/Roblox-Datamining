-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T19:30:37Z
-- Luau bytecode version: 14 | Luau type version: 3
local scriptParent = script.Parent
local scriptParentParentParentParentParent = scriptParent.Parent.Parent.Parent.Parent

local t = require(scriptParentParentParentParentParent.t)
local validateBinding = require(scriptParent.validateBinding)

return t.strictInterface({ Color = t.Color3, Transparency = t.union(t.numberConstrained(0, 1), validateBinding) })
