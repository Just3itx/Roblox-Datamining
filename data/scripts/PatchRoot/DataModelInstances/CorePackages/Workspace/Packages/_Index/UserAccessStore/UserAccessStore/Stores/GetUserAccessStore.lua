-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T01:30:46Z
-- Luau bytecode version: 14 | Luau type version: 3
local UserAccessStoreParent = script:FindFirstAncestor("UserAccessStore").Parent

local Signals = require(UserAccessStoreParent.Signals)
local createUserAccessStore = require(script.createUserAccessStore)

return Signals.createComputed(createUserAccessStore)
