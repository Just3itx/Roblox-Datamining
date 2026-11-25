-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T20:21:11Z
-- Luau bytecode version: 14 | Luau type version: 3
local UserLibParent = script:FindFirstAncestor("UserLib").Parent

local Signals = require(UserLibParent.Signals)
local createIsLocalUserUnder13Store = require(script.createIsLocalUserUnder13Store)

return Signals.createComputed(createIsLocalUserUnder13Store)
