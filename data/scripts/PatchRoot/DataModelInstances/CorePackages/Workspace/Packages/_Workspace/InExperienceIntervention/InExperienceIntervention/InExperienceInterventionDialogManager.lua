-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T19:11:00Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InExperienceIntervention = script:FindFirstAncestor("InExperienceIntervention")
local InExperienceInterventionParent = InExperienceIntervention.Parent
local React = require(InExperienceInterventionParent.React)

local ChatNudgeCustomDialog = require(InExperienceIntervention.Components.ChatNudgeCustomDialog)
local ChatNudgeCustomDialogV2 = require(InExperienceIntervention.Components.ChatNudgeCustomDialogV2)
local ChatTimeoutCustomDialog = require(InExperienceIntervention.Components.ChatTimeoutCustomDialog)
local ChatNudgeToast = require(InExperienceIntervention.Components.ChatNudgeToast)
local ChatTimeoutToast = require(InExperienceIntervention.Components.ChatTimeoutToast)
local ChatTimeoutCustomDialogV2 = require(InExperienceIntervention.Components.ChatTimeoutCustomDialogV2)
local DictationSafetyReminderToast = require(InExperienceIntervention.Components.DictationSafetyReminderToast)
local PartyChatNudgeCustomDialog = require(InExperienceInterventionParent.InterventionShared).Components.PartyChatNudgeCustomDialog
local PartyChatTimeoutCustomDialog = require(InExperienceInterventionParent.InterventionShared).Components.PartyChatTimeoutCustomDialog

local UniversalFeatureRestrictionDialog = require(InExperienceInterventionParent.InterventionShared).Components.UniversalFeatureRestrictionDialog

local CursorProvider = require(InExperienceInterventionParent.UIBlox).App.SelectionCursor.CursorProvider
local ReactFocusNavigation = require(InExperienceInterventionParent.ReactFocusNavigation)

local focusNavigationService = ReactFocusNavigation.FocusNavigationService.new(ReactFocusNavigation.EngineInterface.CoreGui)
local Provider = require(InExperienceInterventionParent.FocusNavigationUtils).FocusNavigableSurfaceRegistry.Provider

local Constants = require(InExperienceInterventionParent.InterventionShared).Utils.Constants
local _Types = require(InExperienceIntervention.Utils.Types)
local reportChatSuspensionDialogVisibility = require(InExperienceIntervention.Utils.reportChatSuspensionDialogVisibility)

local GetFFlagGameJoinTimeoutChatAttemptEnabled = require(InExperienceInterventionParent.SharedFlags).GetFFlagGameJoinTimeoutChatAttemptEnabled

local FFlagExpChatDictationContinuousSafetyReminder = require(InExperienceInterventionParent.SharedFlags).FFlagExpChatDictationContinuousSafetyReminder

local var1 = React.memo(function(arg1)
    return React.createElement(ReactFocusNavigation.FocusNavigationContext.Provider, {
        value = focusNavigationService
    }, {
        RegistryProvider = React.createElement(Provider, nil, { CursorProvider = React.createElement(CursorProvider, {}, arg1.children) })
    })
end)

function InExperienceInterventionDialogManager(tbl1)
    local onDismiss = React.useCallback(function()
        tbl1.uiStateDispatch({
            type = Constants.UIStateActions.ToggleNotificationDialog,
            treatmentType = Constants.TreatmentType.None,
            isShown = false
        })
    end, { tbl1.uiStateDispatch })

    local uiState = tbl1.uiState
    local treatmentType = uiState.treatmentType
    local detail = uiState.detail
    local options = if detail then detail.options else nil
    local isShown = uiState.isShown

    if FFlagExpChatDictationContinuousSafetyReminder and treatmentType == Constants.TreatmentType.DictationSafetyReminderToast then
        isShown = false
    end

    React.useEffect(function()
        reportChatSuspensionDialogVisibility(isShown)
    end, { isShown })

    if uiState.isShown then
        if treatmentType == Constants.TreatmentType.ChatNudgeDialog then
            return React.createElement(
                ChatNudgeCustomDialog,
                {
                    violatingChatLine = detail.evidence,
                    onDismiss = onDismiss,
                    eventId = detail.decisionEventId
                }
            )
        end

        if treatmentType == Constants.TreatmentType.ChatTimeoutDialog and (detail.timeoutDurationSeconds or 0) > 0 then
            return React.createElement(ChatTimeoutCustomDialog, {
                duration = detail.timeoutDurationSeconds,
                onDismiss = onDismiss,
                eventId = detail.decisionEventId,
                violatingChatLine = detail.evidence
            })
        end

        if treatmentType == Constants.TreatmentType.ChatNudgeToast then
            return React.createElement(ChatNudgeToast, { violatingChatLine = detail.evidence, eventId = detail.decisionEventId })
        end
        if treatmentType == Constants.TreatmentType.ChatTimeoutChatAttempt then
            return React.createElement(ChatTimeoutToast, {
                endTime = uiState.endTime,
                treatmentType = Constants.TreatmentType.ChatTimeoutChatAttempt,
                dispatchTimestamp = uiState.dispatchTimestamp
            })
        end
        if GetFFlagGameJoinTimeoutChatAttemptEnabled() and treatmentType == Constants.TreatmentType.ChatTimeoutGameJoin then
            return React.createElement(ChatTimeoutToast, {
                endTime = uiState.endTime,
                treatmentType = Constants.TreatmentType.ChatTimeoutGameJoin,
                dispatchTimestamp = uiState.dispatchTimestamp
            })
        end

        if treatmentType == Constants.TreatmentType.PartyChatNudgeDialog then
            return React.createElement(var1, {}, {
                dialog = React.createElement(
                    PartyChatNudgeCustomDialog,
                    {
                        evidence = detail.evidence,
                        eventId = detail.decisionEventId,
                        onDismiss = onDismiss
                    }
                )
            })
        end

        if treatmentType == Constants.TreatmentType.PartyChatTimeoutDialog then
            return React.createElement(var1, {}, { React.createElement(PartyChatTimeoutCustomDialog, {
                    endTimestamp = uiState.endTime,
                    evidence = detail.evidence,
                    eventId = detail.decisionEventId,
                    durationForAnalytics = detail.timeoutDurationSeconds,
                    onDismiss = onDismiss
                }) })
        end

        if treatmentType == Constants.TreatmentType.ChatTimeoutDialogV2 and detail.moderationDetail then
            return React.createElement(var1, {}, { React.createElement(ChatTimeoutCustomDialogV2, { onDismiss = onDismiss, moderationDetail = detail.moderationDetail }) })
        end

        if treatmentType == Constants.TreatmentType.ChatNudgeDialogV2 and detail.moderationDetail then
            return React.createElement(
                var1,
                {},
                { React.createElement(ChatNudgeCustomDialogV2, { onDismiss = onDismiss, moderationDetail = detail.moderationDetail }) }
            )
        end

        if treatmentType == Constants.TreatmentType.UniversalFeatureRestriction and detail.moderationDetail then
            return React.createElement(var1, {}, {
                UniversalFeatureRestrictionDialog = React.createElement(UniversalFeatureRestrictionDialog, {
                    onDismiss = onDismiss,
                    moderationDetail = detail.moderationDetail,
                    abuseVector = detail.abuseVector,
                    onDismissCallback = options and options.onDismiss,
                    titleOverride = options and options.titleOverride,
                    bodyOverride = options and options.bodyOverride,
                    onAppeal = options and options.onAppeal,
                    onShownCallback = options and options.onShown,
                    onAcknowledgementSuccess = options and options.onAcknowledgementSuccess,
                    onAcknowledgementFailure = options and options.onAcknowledgementFailure,
                    onClosedCallback = detail.onClosed,
                    analyticsEventId = options and options.analyticsEventId
                })
            })
        end
        if FFlagExpChatDictationContinuousSafetyReminder and treatmentType == Constants.TreatmentType.DictationSafetyReminderToast then
            return React.createElement(DictationSafetyReminderToast)
        end
    end

    return nil
end

return InExperienceInterventionDialogManager
