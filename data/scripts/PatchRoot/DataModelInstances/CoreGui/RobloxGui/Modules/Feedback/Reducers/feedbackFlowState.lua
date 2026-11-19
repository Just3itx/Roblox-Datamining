-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T20:31:01Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

local Cryo = require(CorePackages.Packages.Cryo)
local Rodux = require(CorePackages.Packages.Rodux)

local scriptParentParent = script.Parent.Parent

local Constants = require(scriptParentParent.Resources.Constants)

local SetFeedbackFlowState = require(scriptParentParent.Actions.SetFeedbackFlowState)
local SetFeedbackReason = require(scriptParentParent.Actions.SetFeedbackReason)

local createReducer = Rodux.createReducer
local tbl1 = {
    feedbackFlowState = Constants.State.Default,
    feedbackReason = 0
}
local tbl2 = {}
tbl2[SetFeedbackFlowState.name] = function(arg1, tbl3)
    return Cryo.Dictionary.join(arg1, { feedbackFlowState = tbl3.feedbackFlowState })
end

tbl2[SetFeedbackReason.name] = function(arg1, tbl3)
    return Cryo.Dictionary.join(arg1, { feedbackReason = tbl3.feedbackReason })
end

return createReducer(tbl1, tbl2)
