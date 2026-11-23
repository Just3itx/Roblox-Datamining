-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T10:11:25Z
-- Luau bytecode version: 14 | Luau type version: 3
local AppChatParent = script:FindFirstAncestor("AppChat").Parent
local Signals = require(AppChatParent.Signals)

local createLastEntryPointStore = require(script.createLastEntryPointStore)

return Signals.createComputed(createLastEntryPointStore)
