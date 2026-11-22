-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T02:21:09Z
-- Luau bytecode version: 14 | Luau type version: 3
local scriptParent = script.Parent
local scriptParentParent = scriptParent.Parent
local Signals = require(scriptParentParent.Signals)

local createHttpStore = require(scriptParent.createHttpStore)

return Signals.createComputed(createHttpStore)
