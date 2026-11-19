-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T20:30:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

local Cryo = require(CorePackages.Packages.Cryo)
local Rodux = require(CorePackages.Packages.Rodux)

local scriptParentParent = script.Parent.Parent

local IncrementFeedbackSubmissionAttempts = require(scriptParentParent.Actions.IncrementFeedbackSubmissionAttempts)
local ShowHelpModal = require(scriptParentParent.Actions.ShowHelpModal)
local ShowOnboardingModal = require(scriptParentParent.Actions.ShowOnboardingModal)
local SetSourceLanguageName = require(scriptParentParent.Actions.SetSourceLanguageName)

local createReducer = Rodux.createReducer

local tbl1 = {}
tbl1[IncrementFeedbackSubmissionAttempts.name] = function(arg1, tbl2)
    return Cryo.Dictionary.join(arg1, { numFeedbackSubmissionAttempts = tbl2.numFeedbackSubmissionAttempts })
end

tbl1[ShowHelpModal.name] = function(arg1, tbl2)
    return Cryo.Dictionary.join(arg1, { showHelpModal = tbl2.helpModalVisible })
end

tbl1[ShowOnboardingModal.name] = function(arg1, tbl2)
    return Cryo.Dictionary.join(arg1, { showOnboardingModal = tbl2.onboardingModalVisible })
end

tbl1[SetSourceLanguageName.name] = function(arg1, tbl2)
    return Cryo.Dictionary.join(arg1, { sourceLanguageName = tbl2.sourceLanguageName })
end

return createReducer(
    {
        numFeedbackSubmissionAttempts = nil,
        showHelpModal = false,
        showOnboardingModal = true,
        sourceLanguageName = ""
    },
    tbl1
)
