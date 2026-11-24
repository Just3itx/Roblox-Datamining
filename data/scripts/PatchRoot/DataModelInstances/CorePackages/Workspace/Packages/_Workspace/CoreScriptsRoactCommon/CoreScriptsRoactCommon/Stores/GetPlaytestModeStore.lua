-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T01:31:07Z
-- Luau bytecode version: 14 | Luau type version: 3
local CoreScriptsRoactCommonParent = script:FindFirstAncestor("CoreScriptsRoactCommon").Parent
local Signals = require(CoreScriptsRoactCommonParent.Signals)
local createPlaytestModeStore = require(script.createPlaytestModeStore)

return Signals.createComputed(createPlaytestModeStore)
