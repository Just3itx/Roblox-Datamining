-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T19:10:47Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InExperienceIntervention = script:FindFirstAncestor("InExperienceIntervention")
local InExperienceInterventionParent = InExperienceIntervention.Parent

local IXPService = game:GetService("IXPService")
local LocalizationService = game:GetService("LocalizationService")

local React = require(InExperienceInterventionParent.React)

local AppUserLayers = require(InExperienceInterventionParent.ExperimentLayers).AppUserLayers
local GenericInterventionDialog = require(InExperienceInterventionParent.InterventionShared).Components.GenericInterventionDialog
local useLocalization = require(InExperienceInterventionParent.Localization).Hooks.useLocalization
local InterventionAnalytics = require(InExperienceInterventionParent.InterventionShared).InterventionAnalytics
local useParsedBadUtterances = require(InExperienceInterventionParent.InterventionShared).Hooks.useParsedBadUtterances
local var1 = require(InExperienceInterventionParent.RobloxAppLocales).Localization.new(LocalizationService.RobloxLocaleId)

local FFlagNotApprovedPageIXPExposure = require(InExperienceInterventionParent.SharedFlags).FFlagNotApprovedPageIXPExposure

local Constants = require(InExperienceInterventionParent.InterventionShared).Utils.Constants
local _Types = require(InExperienceIntervention.Utils.Types)

return React.memo(function(tbl1) -- name: ChatNudgeCustomDialogV2
    local var2 = useLocalization(Constants.localizationKeys)

    React.useEffect(function()
        if FFlagNotApprovedPageIXPExposure and game:GetEngineFeature("EnableLogFlagLinkedUserLayerExposure") then
            IXPService:LogFlagLinkedUserLayerExposure(AppUserLayers.NotApprovedPageUserIDLayer)
        end
    end, {})

    local moderationDetail = tbl1.moderationDetail
    local consequenceTransparencyMessage = moderationDetail.consequenceTransparencyMessage
    local interventionId = moderationDetail.interventionId
    local acknowledgeable = moderationDetail.acknowledgeable
    local badUtterances = moderationDetail.badUtterances

    local var3 = useParsedBadUtterances(badUtterances or {}, { shouldAddPlayerName = true })

    local evidence = table.concat(var3.textItems, "\n")
    local str2 = table.concat(var3.abuseTypes, ", ")

    if str2 == "" then
        str2 = var1:Format("Feature.NotApproved.Label.AbuseType.Other")
    end

    return React.createElement(GenericInterventionDialog, {
        titleText = var2.ChatBreaksRulesText,
        isAppealable = true,
        bodyText = var2.TextChatMayBeSuspendedText,
        evidence = evidence,
        violationReason = str2,
        onDismiss = tbl1.onDismiss,
        dsaMessage = consequenceTransparencyMessage,
        interventionId = interventionId,
        acknowledgeable = acknowledgeable,
        eventId = interventionId,
        interventionTypeForAnalytics = InterventionAnalytics.Constants.InterventionTypes.Nudge
    })
end)
