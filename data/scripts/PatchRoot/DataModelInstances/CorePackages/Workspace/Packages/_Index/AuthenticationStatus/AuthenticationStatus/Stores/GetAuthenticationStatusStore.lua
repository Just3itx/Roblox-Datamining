-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T01:20:32Z
-- Luau bytecode version: 14 | Luau type version: 3
local AuthenticationStatusParent = script:FindFirstAncestor("AuthenticationStatus").Parent

local Signals = require(AuthenticationStatusParent.Signals)
local createAuthenticationStatusStore = require(script.createAuthenticationStatusStore)

return Signals.createComputed(createAuthenticationStatusStore)
