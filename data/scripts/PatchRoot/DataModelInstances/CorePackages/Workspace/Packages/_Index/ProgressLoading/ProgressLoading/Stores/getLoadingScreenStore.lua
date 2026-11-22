-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T12:31:19Z
-- Luau bytecode version: 14 | Luau type version: 3
local ProgressLoadingParent = script:FindFirstAncestor("ProgressLoading").Parent

local Signals = require(ProgressLoadingParent.Signals)

local createLoadingScreenStore = require(script.Parent.createLoadingScreenStore)

return Signals.createComputed(createLoadingScreenStore)
