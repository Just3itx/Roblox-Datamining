-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T20:01:10Z
-- Luau bytecode version: 14 | Luau type version: 3
local UniversalAppPolicyParent = script:FindFirstAncestor("UniversalAppPolicy").Parent

local Signals = require(UniversalAppPolicyParent.Signals)

local createAppPolicyStore = require(script.createAppPolicyStore)

return Signals.createComputed(createAppPolicyStore)
