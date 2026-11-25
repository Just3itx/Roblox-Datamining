-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T08:20:35Z
-- Luau bytecode version: 14 | Luau type version: 3
local scriptParentParentParent = script.Parent.Parent.Parent
local Signals = require(scriptParentParentParent.Signals)
local createInputModeStore = require(script.createInputModeStore)

return Signals.createComputed(createInputModeStore)
