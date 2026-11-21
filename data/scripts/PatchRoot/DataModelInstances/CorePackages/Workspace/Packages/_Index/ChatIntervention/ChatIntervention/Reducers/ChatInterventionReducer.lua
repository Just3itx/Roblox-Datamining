-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T06:40:46Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ChatIntervention = script:FindFirstAncestor("ChatIntervention")
local ChatInterventionParent = ChatIntervention.Parent
local Rodux = require(ChatInterventionParent.Rodux)
local Actions = ChatIntervention.Actions
local Dictionary = require(ChatInterventionParent.llama).Dictionary

local UpdateShowChatFeedbackModalAction = require(Actions.UpdateShowChatFeedbackModalAction)
local UpdateShowChatFeedbackPillAction = require(Actions.UpdateShowChatFeedbackPillAction)
local UpdateShowChatNudgeModalAction = require(Actions.UpdateShowChatNudgeModalAction)
local UpdateShowChatTimeoutModalAction = require(Actions.UpdateShowChatTimeoutModalAction)

local createReducer = Rodux.createReducer
local tbl1 = {}

tbl1[UpdateShowChatFeedbackModalAction.name] = function(tbl2, arg1) -- name: setIsShowChatFeedbackModal
    return Dictionary.set(tbl2, "isShowChatFeedbackModal", arg1.isShow)
end

tbl1[UpdateShowChatFeedbackPillAction.name] = function(tbl2, arg1) -- name: setIsShowChatFeedbackPill
    return Dictionary.set(tbl2, "isShowChatFeedbackPill", arg1.isShow)
end

tbl1[UpdateShowChatNudgeModalAction.name] = function(tbl2, arg1) -- name: setIsShowChatNudgeModal
    return Dictionary.set(tbl2, "isShowChatNudgeModal", arg1.isShow)
end

tbl1[UpdateShowChatTimeoutModalAction.name] = function(tbl2, arg1) -- name: setIsShowChatTimeoutModal
    return Dictionary.set(tbl2, "isShowChatTimeoutModal", arg1.isShow)
end

return createReducer({
    isShowChatFeedbackModal = false,
    isShowChatFeedbackPill = false,
    isShowChatNudgeModal = false,
    isShowChatTimeoutModal = false
}, tbl1)
