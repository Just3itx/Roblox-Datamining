-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T01:00:46Z
-- Luau bytecode version: 14 | Luau type version: 3
local CoreGuiCommonParent = script:FindFirstAncestor("CoreGuiCommon").Parent
local Signals = require(CoreGuiCommonParent.Signals)
local createUILessStore = require(script.createUILessStore)

return Signals.createComputed(createUILessStore)
