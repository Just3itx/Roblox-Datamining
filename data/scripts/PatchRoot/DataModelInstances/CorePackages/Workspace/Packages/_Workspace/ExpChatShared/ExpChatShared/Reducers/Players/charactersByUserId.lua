-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T10:31:14Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ExpChatShared = script:FindFirstAncestor("ExpChatShared")
local ExpChatSharedParent = ExpChatShared.Parent
local Rodux = require(ExpChatSharedParent.Rodux)
local Dictionary = require(ExpChatSharedParent.llama).Dictionary

local Actions = ExpChatShared.Actions
local CharacterAdded = require(Actions.CharacterAdded)
local PlayerRemoved = require(Actions.PlayerRemoved)

local createReducer = Rodux.createReducer
local tbl1 = {}
tbl1[CharacterAdded.name] = function(tbl2, arg1)
    return Dictionary.join(tbl2, { [arg1.userId] = arg1.character })
end

tbl1[PlayerRemoved.name] = function(tbl2, arg1)
    return Dictionary.removeKey(tbl2, arg1.userId)
end

return createReducer({}, tbl1)
