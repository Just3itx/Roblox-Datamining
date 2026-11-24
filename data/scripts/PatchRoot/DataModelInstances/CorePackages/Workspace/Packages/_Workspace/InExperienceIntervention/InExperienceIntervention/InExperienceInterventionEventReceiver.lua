-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T19:11:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InExperienceIntervention = script:FindFirstAncestor("InExperienceIntervention")
local InExperienceInterventionParent = InExperienceIntervention.Parent

local Chat = game:GetService("Chat")
local FeatureRestrictionManager = game:GetService("FeatureRestrictionManager")
local HttpService = game:GetService("HttpService")
local NotificationService = game:GetService("NotificationService")

local React = require(InExperienceInterventionParent.React)

local chatInputBoxDisabledPressedSignal = require(InExperienceInterventionParent.InterventionShared).Signals.chatInputBoxDisabledPressedSignal
local dictationSafetyReminderSignal = require(InExperienceInterventionParent.InterventionShared).Signals.dictationSafetyReminderSignal

local experienceChatInterventionShownSignal = require(InExperienceInterventionParent.InterventionShared).Signals.experienceChatInterventionShownSignal
local Constants = require(InExperienceInterventionParent.InterventionShared).Utils.Constants
local determineUFRInterventionType = require(InExperienceInterventionParent.InterventionShared).Utils.determineUFRInterventionType

local featureRestrictionDisplayDirectSignal = require(InExperienceInterventionParent.UniversalFeatureRestrictions.featureRestrictionDisplayDirectSignal)
local featureRestrictionDisplaySignal = require(InExperienceInterventionParent.UniversalFeatureRestrictions.featureRestrictionDisplaySignal)
local GetModerationDetail = require(InExperienceInterventionParent.InterventionShared).Http.GetModerationDetail
local InExperienceInterventionAnalytics = require(InExperienceIntervention.InExperienceInterventionAnalytics)
local InterventionAnalytics = require(InExperienceInterventionParent.InterventionShared).InterventionAnalytics
local InterventionTreatmentConfigList = require(InExperienceIntervention.InterventionTreatmentConfigs.InterventionTreatmentConfigList)
local InterventionTypes = InterventionAnalytics.Constants.InterventionTypes

local GetFFlagGameJoinTimeoutChatAttemptEnabled = require(InExperienceInterventionParent.SharedFlags).GetFFlagGameJoinTimeoutChatAttemptEnabled
local FFlagAppChatUniversalFeatureRestriction = require(InExperienceInterventionParent.SharedFlags).FFlagAppChatUniversalFeatureRestriction
local FFlagUFRImprovements = require(InExperienceInterventionParent.InterventionShared.FFlagUFRImprovements)
local FFlagUFRAppealsAndModNoteFix = require(InExperienceInterventionParent.InterventionShared.FFlagUFRAppealsAndModNoteFix)

local FFlagUFRRunUnlessFeatureRestricted = require(InExperienceInterventionParent.UniversalFeatureRestrictions.FFlagUFRRunUnlessFeatureRestricted)

local FFlagExpChatDictationContinuousSafetyReminder = require(InExperienceInterventionParent.SharedFlags).FFlagExpChatDictationContinuousSafetyReminder

local FFlagExpChatDictationStopOnSafetyIntervention = require(InExperienceInterventionParent.SharedFlags).FFlagExpChatDictationStopOnSafetyIntervention

function InExperienceInterventionEventReceiver(tbl1)
    React.useEffect(function()
        local connection = NotificationService.RobloxEventReceived:Connect(function(eventData)
            if eventData.namespace ~= Constants.FEATURE_INTERV_SIGNAL_NAMESPACE then
                return
            end

            local success, result = pcall(function()
                return HttpService:JSONDecode(eventData.detail)
            end)

            if not success then
                return
            end

            for _, value in InterventionTreatmentConfigList do
                if value.shouldTriggerEventReceived(result) then
                    value.onTriggerEventReceived(result)
                end
                if value.shouldTriggerVisualTreatment(result) then
                    value.onTriggerVisualTreatment(tbl1.uiStateDispatch, result)
                end
                if value.shouldTriggerBehavioralTreatment(result) then
                    value.onTriggerBehavioralTreatment(result)
                end
            end
        end)

        local connection2 = Chat.TimeoutChatAttempt:Connect(function(_: boolean, endTime: number)
            tbl1.uiStateDispatch({
                type = Constants.UIStateActions.ToggleNotificationDialog,
                treatmentType = Constants.TreatmentType.ChatTimeoutChatAttempt,
                endTime = endTime,
                isShown = true
            })

            if FFlagExpChatDictationStopOnSafetyIntervention then
                experienceChatInterventionShownSignal:fire()
            end
        end)

        local connection3 = if GetFFlagGameJoinTimeoutChatAttemptEnabled() then FeatureRestrictionManager.TimeoutChatAttempt:Connect(function(_: boolean, endTime: number)
            tbl1.uiStateDispatch({
                type = Constants.UIStateActions.ToggleNotificationDialog,
                treatmentType = Constants.TreatmentType.ChatTimeoutGameJoin,
                endTime = endTime,
                isShown = true
            })

            if FFlagExpChatDictationStopOnSafetyIntervention then
                experienceChatInterventionShownSignal:fire()
            end
        end) else nil

        local connection4 = FeatureRestrictionManager.FeatureTimeoutAttempt:Connect(function(_: boolean, startTime: number, duration: number, featureRestrictionAbuseVector: Enum.FeatureRestrictionAbuseVector)
            if featureRestrictionAbuseVector ~= Enum.FeatureRestrictionAbuseVector.ExperienceChat then
                return
            end

            tbl1.uiStateDispatch({
                type = Constants.UIStateActions.ToggleNotificationDialog,
                treatmentType = Constants.TreatmentType.ChatTimeoutChatAttempt,
                endTime = startTime + duration,
                isShown = true
            })

            if FFlagExpChatDictationStopOnSafetyIntervention then
                experienceChatInterventionShownSignal:fire()
            end
        end)

        local connection5 = FeatureRestrictionManager.ShowFeatureInterventionDetails:Connect(function(featureRestrictionAbuseVector: Enum.FeatureRestrictionAbuseVector)
            if featureRestrictionAbuseVector ~= Enum.FeatureRestrictionAbuseVector.ExperienceChat then
                return
            end

            local var1 = nil

            GetModerationDetail({ abuseVector = Constants.AbuseVectorType.ExperienceChat }):andThen(function(arg1)
                var1 = arg1
            end):catch(function(arg1)
                InExperienceInterventionAnalytics.sendAnalyticsEvent(
                    InExperienceInterventionAnalytics.Constants.EventTypes.GetModerationDetailFailed,
                    nil,
                    DateTime.now().UnixTimestampMillis,
                    nil,
                    nil,
                    nil,
                    arg1.error
                )
            end):await()

            if not var1 then
                return
            end

            if not var1.acknowledgeable then
                return
            end

            if FFlagExpChatDictationStopOnSafetyIntervention then
                experienceChatInterventionShownSignal:fire()
            end

            local punishmentTypeDescription = var1.punishmentTypeDescription
            if FFlagUFRImprovements then
                local var2 = determineUFRInterventionType(punishmentTypeDescription)

                if var2 == InterventionTypes.UFRTimeout then
                    tbl1.uiStateDispatch({
                        type = Constants.UIStateActions.ToggleNotificationDialog,
                        treatmentType = Constants.TreatmentType.ChatTimeoutDialogV2,
                        detail = { moderationDetail = var1 },
                        isShown = true
                    })
                elseif var2 == InterventionTypes.UFRNudge then
                    tbl1.uiStateDispatch({
                        type = Constants.UIStateActions.ToggleNotificationDialog,
                        treatmentType = Constants.TreatmentType.ChatNudgeDialogV2,
                        detail = { moderationDetail = var1 },
                        isShown = true
                    })
                end
            elseif punishmentTypeDescription == Constants.PunishmentTypeDescription.ChatTimeout then
                tbl1.uiStateDispatch({
                    type = Constants.UIStateActions.ToggleNotificationDialog,
                    treatmentType = Constants.TreatmentType.ChatTimeoutDialogV2,
                    detail = { moderationDetail = var1 },
                    isShown = true
                })
            elseif punishmentTypeDescription == Constants.PunishmentTypeDescription.ChatNudge then
                tbl1.uiStateDispatch({
                    type = Constants.UIStateActions.ToggleNotificationDialog,
                    treatmentType = Constants.TreatmentType.ChatNudgeDialogV2,
                    detail = { moderationDetail = var1 },
                    isShown = true
                })
            end
        end)

        local connection6 = FeatureRestrictionManager.FeatureTimeoutRestored:Connect(function(featureRestrictionAbuseVector: Enum.FeatureRestrictionAbuseVector)
            print("FeatureTimeoutRestored - Abuse Vector: ", featureRestrictionAbuseVector)
        end)

        local connection7 = if FFlagAppChatUniversalFeatureRestriction then nil else chatInputBoxDisabledPressedSignal:connect(function(arg1)
            tbl1.uiStateDispatch({
                detail = {
                    decisionEventId = arg1.decisionEventId,
                    timeoutDurationSeconds = arg1.duration
                },
                type = Constants.UIStateActions.ToggleNotificationDialog,
                treatmentType = Constants.TreatmentType.PartyChatTimeoutDialog,
                endTime = arg1.endTimestamp,
                isShown = true
            })
        end)

        local connection8 = if FFlagExpChatDictationContinuousSafetyReminder then dictationSafetyReminderSignal:connect(function()
            tbl1.uiStateDispatch({
                type = Constants.UIStateActions.ToggleNotificationDialog,
                treatmentType = Constants.TreatmentType.DictationSafetyReminderToast,
                isShown = true
            })
        end) else nil

        local connection9 = featureRestrictionDisplaySignal:connect(function(arg1)
            local abuseVector = arg1.abuseVector
            local options = arg1.options
            local var1 = nil

            GetModerationDetail({ abuseVector = abuseVector }):andThen(function(arg2)
                var1 = arg2
            end):catch(function(arg2)
                InterventionAnalytics.sendAnalyticsEvent(InterventionAnalytics.TelemetryConfigs.GetModerationDetailFailed, {
                    eventType = InterventionAnalytics.Constants.EventTypes.GetModerationDetailFailed,
                    placement = Constants.InterventionPlacementType.InExperience,
                    renderedTimestamp = DateTime.now().UnixTimestampMillis,
                    error = arg2.error,
                    abuseVector = abuseVector
                })
            end):await()

            if not var1 or FFlagUFRAppealsAndModNoteFix and next(var1) == nil then
                return
            end

            tbl1.uiStateDispatch({
                type = Constants.UIStateActions.ToggleNotificationDialog,
                treatmentType = Constants.TreatmentType.UniversalFeatureRestriction,
                detail = { moderationDetail = var1, options = options, abuseVector = abuseVector },
                isShown = true
            })
        end)

        local connection10 = featureRestrictionDisplayDirectSignal:connect(function(arg1)
            local abuseVector = arg1.abuseVector
            local moderationDetail = arg1.moderationDetail
            local options = arg1.options

            if not moderationDetail then
                return
            end

            tbl1.uiStateDispatch({
                type = Constants.UIStateActions.ToggleNotificationDialog,
                treatmentType = Constants.TreatmentType.UniversalFeatureRestriction,
                detail = {
                    moderationDetail = moderationDetail,
                    options = options,
                    abuseVector = abuseVector,
                    onClosed = arg1.onClosed
                },
                isShown = true
            })

            if FFlagUFRRunUnlessFeatureRestricted and arg1.onHandled then
                arg1.onHandled()
            end
        end)

        return function()
            connection:Disconnect()
            connection2:Disconnect()
            if GetFFlagGameJoinTimeoutChatAttemptEnabled() then
                connection3:Disconnect()
            end
            connection4:Disconnect()
            connection5:Disconnect()
            connection6:Disconnect()
            if connection7 then
                connection7:disconnect()
            end
            if connection8 then
                connection8:disconnect()
            end
            connection9:disconnect()
            connection10:disconnect()
        end
    end, {})

    return React.createElement("Frame", { BackgroundTransparency = 1 })
end

return InExperienceInterventionEventReceiver
