-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T09:00:59Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ExpChat = script:FindFirstAncestor("ExpChat")
local ExpChatParent = ExpChat.Parent
local Rodux = require(ExpChatParent.Rodux)
local Dictionary = require(ExpChatParent.llama).Dictionary

local Actions = ExpChat.Actions
local AddReverseNudgeToxicUser = require(Actions.AddReverseNudgeToxicUser)
local RemoveReverseNudgeToxicUser = require(Actions.RemoveReverseNudgeToxicUser)

local createReducer = Rodux.createReducer
local tbl1 = {}
tbl1[AddReverseNudgeToxicUser.name] = function(tbl2, arg1)
    return Dictionary.join(tbl2, { [arg1.toxicUserId] = arg1.reverseNudgeType })
end

tbl1[RemoveReverseNudgeToxicUser.name] = function(tbl2, arg1)
    return Dictionary.removeKey(tbl2, arg1.toxicUserId)
end

return createReducer({}, tbl1)
