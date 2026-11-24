-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T01:00:49Z
-- Luau bytecode version: 14 | Luau type version: 3
local CoreGuiCommonParent = script:FindFirstAncestor("CoreGuiCommon").Parent
local Signals = require(CoreGuiCommonParent.Signals)
local createUiSelectorSignalStore = require(script.createUiSelectorSignalStore)

return Signals.createComputed(createUiSelectorSignalStore)
