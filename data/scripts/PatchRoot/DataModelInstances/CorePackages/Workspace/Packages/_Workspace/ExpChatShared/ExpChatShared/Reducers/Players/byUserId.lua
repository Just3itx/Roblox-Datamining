-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T10:31:11Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ExpChatShared = script:FindFirstAncestor("ExpChatShared")
local ExpChatSharedParent = ExpChatShared.Parent
local Rodux = require(ExpChatSharedParent.Rodux)
local Dictionary = require(ExpChatSharedParent.llama).Dictionary

local Actions = ExpChatShared.Actions
local PlayerAdded = require(Actions.PlayerAdded)
local PlayerRemoved = require(Actions.PlayerRemoved)

local createReducer = Rodux.createReducer
local tbl1 = {}
tbl1[PlayerAdded.name] = function(tbl2, arg1)
    return Dictionary.join(
        tbl2,
        {
            [arg1.userId] = {
                userId = arg1.userId,
                username = arg1.username,
                displayName = arg1.displayName
            }
        }
    )
end

tbl1[PlayerRemoved.name] = function(tbl2, arg1)
    return Dictionary.removeKey(tbl2, arg1.userId)
end

return createReducer({}, tbl1)
