-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T19:10:51Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InExperienceIntervention = script:FindFirstAncestor("InExperienceIntervention")
local InExperienceInterventionParent = InExperienceIntervention.Parent

local IXPService = game:GetService("IXPService")
local LocalizationService = game:GetService("LocalizationService")

local React = require(InExperienceInterventionParent.React)

local AppUserLayers = require(InExperienceInterventionParent.ExperimentLayers).AppUserLayers
local GenericInterventionDialog = require(InExperienceInterventionParent.InterventionShared).Components.GenericInterventionDialog
local useTimeoutInfoBinding = require(InExperienceInterventionParent.InterventionShared).Hooks.useTimeoutInfoBinding
local InterventionAnalytics = require(InExperienceInterventionParent.InterventionShared).InterventionAnalytics
local useParsedBadUtterances = require(InExperienceInterventionParent.InterventionShared).Hooks.useParsedBadUtterances
local var1 = require(InExperienceInterventionParent.RobloxAppLocales).Localization.new(LocalizationService.RobloxLocaleId)

local FFlagNotApprovedPageIXPExposure = require(InExperienceInterventionParent.SharedFlags).FFlagNotApprovedPageIXPExposure

local _Types = require(InExperienceIntervention.Utils.Types)

return React.memo(function(tbl1) -- name: ChatTimeoutCustomDialogV2
    local moderationDetail = tbl1.moderationDetail

    React.useEffect(function()
        if FFlagNotApprovedPageIXPExposure and game:GetEngineFeature("EnableLogFlagLinkedUserLayerExposure") then
            IXPService:LogFlagLinkedUserLayerExposure(AppUserLayers.NotApprovedPageUserIDLayer)
        end
    end, {})

    local var2 = useTimeoutInfoBinding(moderationDetail.endDate, moderationDetail.duration)
    local heading = var2.heading
    local description = var2.description

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
        titleText = heading:map(function<T>(arg1: T): T
            return arg1
        end),
        isAppealable = true,
        bodyText = description:map(function<T>(arg1: T): T
            return arg1
        end),
        evidence = evidence,
        violationReason = str2,
        onDismiss = tbl1.onDismiss,
        dsaMessage = consequenceTransparencyMessage,
        interventionId = interventionId,
        acknowledgeable = acknowledgeable,
        eventId = interventionId,
        durationForAnalytics = moderationDetail.duration / 1000000000,
        interventionTypeForAnalytics = InterventionAnalytics.Constants.InterventionTypes.Timeout
    })
end)
