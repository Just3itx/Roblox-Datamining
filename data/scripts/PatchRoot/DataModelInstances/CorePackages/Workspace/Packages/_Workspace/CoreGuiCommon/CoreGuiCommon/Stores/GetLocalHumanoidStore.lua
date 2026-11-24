-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T01:00:42Z
-- Luau bytecode version: 14 | Luau type version: 3
local CoreGuiCommonParent = script:FindFirstAncestor("CoreGuiCommon").Parent
local Signals = require(CoreGuiCommonParent.Signals)
local createLocalHumanoidStore = require(script.createLocalHumanoidStore)

return Signals.createComputed(createLocalHumanoidStore)
