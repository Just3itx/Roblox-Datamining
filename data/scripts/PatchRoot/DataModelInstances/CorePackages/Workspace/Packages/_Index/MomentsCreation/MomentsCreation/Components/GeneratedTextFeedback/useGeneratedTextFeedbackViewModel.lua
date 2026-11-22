-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T06:51:11Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsCreation = script:FindFirstAncestor("MomentsCreation")
local MomentsCreationParent = MomentsCreation.Parent

local Localization = require(MomentsCreationParent.Localization)
local MomentsCommon = require(MomentsCreationParent.MomentsCommon)
local React = require(MomentsCreationParent.React)
local SignalsReact = require(MomentsCreationParent.SignalsReact)

local useLocalization = Localization.Hooks.useLocalization
local useState = React.useState
local useSignalState = SignalsReact.useSignalState

local GetCreationFlowStore = require(MomentsCreation.Stores.GetCreationFlowStore)
local useCreationController = require(MomentsCreation.CreationController.useCreationController)
local fireAnalyticsEvent = require(MomentsCreation.Analytics.fireAnalyticsEvent)
local makeCreationEventFields = require(MomentsCreation.Analytics.makeCreationEventFields)
local _GeneratedTextFeedbackView = require(script.Parent.GeneratedTextFeedbackView)

local EventNames = MomentsCommon.Analytics.EventNames
local SessionManager = MomentsCommon.Analytics.SessionManager
local FunnelEventNames = MomentsCommon.Analytics.FunnelEventNames

local tbl1 = { disclosure = "Feature.Moments.Description.GenerateTextFeedbackDisclosure" }

local function fireFeedbackEvent(arg1) -- Luacid: Inlined by compiler; 3 call sites recovered
    local sessionId = SessionManager.getSessionId(FunnelEventNames.FunnelTypes.CreationFlow)
    fireAnalyticsEvent(arg1, makeCreationEventFields.makeCreationBaseFields(sessionId))
end

local function useGeneratedTextFeedbackViewModel(tbl2)
    local creationFlowStore = GetCreationFlowStore(false)
    local var1 = useCreationController()

    local success, result = pcall(useLocalization, tbl1)

    local var2 = useSignalState(creationFlowStore.getGeneratedDescription)
    local selectedAction, var4 = useState(nil)
    local showReasonDialog, var6 = useState(false)

    return {
        visible = var2 ~= nil,
        layoutOrder = tbl2.layoutOrder,
        disclosureText = (not success and {} or result).disclosure or "",
        selectedAction = selectedAction,
        showReasonDialog = showReasonDialog,
        onThumbsUp = function()
            if selectedAction == "thumbs_up" then
                return
            end
            var4("thumbs_up")
            fireFeedbackEvent(EventNames.EditingFlowGenerateTextFeedbackThumbsUp)
            var1.submitGeneratedTextFeedback("thumbs_up")
        end,
        onThumbsDown = function()
            var6(true)
        end,
        onNotHelpful = function()
            var4("thumbs_down")
            var6(false)
            fireFeedbackEvent(EventNames.EditingFlowGenerateTextFeedbackThumbsDownNotHelpful)
            var1.submitGeneratedTextFeedback("not_helpful")
        end,
        onPolicyViolation = function()
            var4("thumbs_down")
            var6(false)
            fireFeedbackEvent(EventNames.EditingFlowGenerateTextFeedbackThumbsDownPolicy)
            var1.submitGeneratedTextFeedback("policy_violation")
        end,
        onDismissDialog = function()
            var6(false)
        end
    }
end
return useGeneratedTextFeedbackViewModel
