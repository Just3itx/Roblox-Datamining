-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T10:01:32Z
-- Luau bytecode version: 14 | Luau type version: 3
local ExpChatServerParent = script:FindFirstAncestor("ExpChatServer").Parent
local Rodux = require(ExpChatServerParent.Rodux)
local ExpChatShared = require(ExpChatServerParent.ExpChatShared)

return Rodux.combineReducers({ Players = ExpChatShared.Reducers.Players })
