-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T10:31:08Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ExpChatShared = script:FindFirstAncestor("ExpChatShared")
local ExpChatSharedParent = ExpChatShared.Parent
local Rodux = require(ExpChatSharedParent.Rodux)
local Set = require(ExpChatSharedParent.llama).Set

local Actions = ExpChatShared.Actions
local UserMuted = require(Actions.UserMuted)
local UserUnmuted = require(Actions.UserUnmuted)

local createReducer = Rodux.createReducer
local tbl1 = {}
tbl1[UserMuted.name] = function(tbl2, arg1)
    return Set.add(tbl2, arg1.userId)
end

tbl1[UserUnmuted.name] = function(tbl2, arg1)
    return Set.subtract(tbl2, arg1.userId)
end

return createReducer({}, tbl1)
