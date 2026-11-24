-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T08:51:22Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ExpChat = script:FindFirstAncestor("ExpChat")
local ExpChatParent = ExpChat.Parent
local Rodux = require(ExpChatParent.Rodux)
local Dictionary = require(ExpChatParent.llama).Dictionary

local Actions = ExpChat.Actions
local ChatTimeoutUpdated = require(Actions.ChatTimeoutUpdated)

local createReducer = Rodux.createReducer
local tbl1 = {}

tbl1[ChatTimeoutUpdated.name] = function(tbl2, arg1) -- name: updateChatTimeoutData
    return Dictionary.join(tbl2, { timeoutData = { endTimestamp = arg1.endTimestamp, isEnforced = arg1.isEnforced } })
end

return createReducer({ timeoutData = { endTimestamp = 0, isEnforced = false } }, tbl1)
