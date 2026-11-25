-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T11:11:18Z
-- Luau bytecode version: 14 | Luau type version: 3
local SduiSharedContentParent = script:FindFirstAncestor("SduiSharedContent").Parent

local Signals = require(SduiSharedContentParent.Signals)

local createContentReactionsStore = require(script.Parent.createContentReactionsStore)

return Signals.createComputed(createContentReactionsStore)
