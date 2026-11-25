-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T18:31:20Z
-- Luau bytecode version: 14 | Luau type version: 3
local SwitchServerParent = script:FindFirstAncestor("SwitchServer").Parent

local Signals = require(SwitchServerParent.Signals)
local createSwitchServerStore = require(script.createSwitchServerStore)

return Signals.createComputed(createSwitchServerStore)
