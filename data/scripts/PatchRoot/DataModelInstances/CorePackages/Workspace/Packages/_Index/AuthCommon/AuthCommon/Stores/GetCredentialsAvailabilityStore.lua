-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T00:40:57Z
-- Luau bytecode version: 14 | Luau type version: 3
local AuthCommonParent = script:FindFirstAncestor("AuthCommon").Parent

local Signals = require(AuthCommonParent.Signals)
local createCredentialsAvailabilityStore = require(script.createCredentialsAvailabilityStore)

return Signals.createComputed(createCredentialsAvailabilityStore)
