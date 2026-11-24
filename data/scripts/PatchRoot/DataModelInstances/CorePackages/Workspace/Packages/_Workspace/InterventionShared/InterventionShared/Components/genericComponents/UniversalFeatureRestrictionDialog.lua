-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T22:51:12Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InterventionShared = script:FindFirstAncestor("InterventionShared")
local InterventionSharedParent = InterventionShared.Parent

local IXPService = game:GetService("IXPService")

local React = require(InterventionSharedParent.React)
local useCallback = React.useCallback
local useEffect = React.useEffect
local useRef = React.useRef

local AppUserLayers = require(InterventionSharedParent.ExperimentLayers).AppUserLayers
local Constants = require(InterventionShared.Utils.Constants)
local determineAppealsState = require(InterventionShared.Utils.determineAppealsState)
local determineUFRInterventionType = require(InterventionShared.Utils.determineUFRInterventionType)
local GenericInterventionDialog = require(InterventionShared.Components.genericComponents.GenericInterventionDialog)
local _Types = require(InterventionShared.Utils.Types)
local useParsedBadUtterances = require(InterventionShared.Hooks.useParsedBadUtterances)
local useRestrictionEndDateInfo = require(InterventionShared.Hooks.useRestrictionEndDateInfo)

local FFlagUFRAppealsAndModNoteFix = require(InterventionShared.Flags.FFlagUFRAppealsAndModNoteFix)
local FFlagUFRFriendsChatIXPExposure = require(InterventionShared.Flags.FFlagUFRFriendsChatIXPExposure)
local FFlagUFRImprovements = require(InterventionShared.Flags.FFlagUFRImprovements)

local FFlagUFRRunUnlessFeatureRestricted = require(InterventionSharedParent.UniversalFeatureRestrictions.FFlagUFRRunUnlessFeatureRestricted)

return React.memo(function(tbl1) -- name: UniversalFeatureRestrictionDialog
    local moderationDetail = tbl1.moderationDetail
    local consequenceTransparencyMessage = moderationDetail.consequenceTransparencyMessage
    local interventionId = moderationDetail.interventionId
    local acknowledgeable = moderationDetail.acknowledgeable
    local badUtterances = moderationDetail.badUtterances
    local labelTranslationKey = moderationDetail.labelTranslationKey
    local violation = moderationDetail.violation
    local messageToUser = if FFlagUFRAppealsAndModNoteFix and tbl1.abuseVector ~= Constants.AbuseVectorType.RobloxExperienceKick then nil else moderationDetail.messageToUser
    local interventionTypeForAnalytics = determineUFRInterventionType(moderationDetail.punishmentTypeDescription)

    local var2 = useParsedBadUtterances(badUtterances or {}, { labelTranslationKey = labelTranslationKey })

    local evidence = table.concat(var2.textItems, "\n")
    local violationReason = table.concat(var2.abuseTypes, ", ")

    local var3 = useRestrictionEndDateInfo(moderationDetail.endDate)
    local var4 = determineAppealsState({
        onAppeal = tbl1.onAppeal,
        beginDate = moderationDetail.beginDate,
        endDate = moderationDetail.endDate,
        acknowledgeable = acknowledgeable
    })

    useEffect(function()
        if FFlagUFRFriendsChatIXPExposure
            and tbl1.abuseVector == Constants.AbuseVectorType.PartyChat
            and game:GetEngineFeature("EnableLogFlagLinkedUserLayerExposure")
        then
            IXPService:LogFlagLinkedUserLayerExposure(AppUserLayers.FriendsChatRestrictionUserIDLayer)
        end

        if FFlagUFRImprovements and tbl1.onShownCallback then
            tbl1.onShownCallback()
        end
    end, {})

    local var5 = nil
    if FFlagUFRRunUnlessFeatureRestricted then
        local var6 = useRef(false)
        var5 = var6

        useEffect(function()
            local onClosedCallback = tbl1.onClosedCallback
            var6.current = false
            return function()
                if onClosedCallback then
                    onClosedCallback(var6.current)
                end
            end
        end, { tbl1.onClosedCallback })
    end

    local onDismiss = useCallback(function()
        if FFlagUFRRunUnlessFeatureRestricted and var5 then
            var5.current = true
        end
        tbl1.onDismiss()
        if tbl1.onDismissCallback then
            tbl1.onDismissCallback()
        end
    end, { tbl1.onDismiss, tbl1.onDismissCallback, if FFlagUFRRunUnlessFeatureRestricted then var5 else nil })

    local titleText = tbl1.titleOverride or (if FFlagUFRImprovements then moderationDetail.title or "" else "Chat suspended for 2 days")
    local bodyText = tbl1.bodyOverride
        or (if FFlagUFRImprovements then moderationDetail.body or "" else "You can't use chat because one or more of your messages broke the rules. If you break the rules again, you could be banned.")

    return React.createElement(GenericInterventionDialog, {
        titleText = titleText,
        bodyText = bodyText,
        userNote = messageToUser,
        isAppealable = var4.isAppealable,
        evidence = evidence,
        violationReason = violationReason,
        onDismiss = onDismiss,
        dsaMessage = consequenceTransparencyMessage,
        interventionId = interventionId,
        acknowledgeable = acknowledgeable,
        eventId = tbl1.analyticsEventId or interventionId,
        interventionTypeForAnalytics = interventionTypeForAnalytics,
        abuseVectorForAnalytics = tbl1.abuseVector,
        useDetailedLayout = true,
        formattedEndDate = var3.formattedEndDate,
        countdownText = var3.countdownText,
        onAppeal = tbl1.onAppeal,
        onAcknowledgementSuccess = tbl1.onAcknowledgementSuccess,
        onAcknowledgementFailure = tbl1.onAcknowledgementFailure,
        shouldOpenAppealsPortal = var4.shouldOpenAppealsPortal,
        violationUid = if violation then violation.uid else nil
    })
end)
