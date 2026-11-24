-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T23:01:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InterventionSharedParent = script:FindFirstAncestor("InterventionShared").Parent

local AbuseVector = require(InterventionSharedParent.UniversalFeatureRestrictions.AbuseVector)

local tbl1 = {
    {
        unitInSeconds = 86400,
        singularKey = "Feature.UniversalFeatureRestrictions.AbuseVector.RobloxKick.DialogTitle.Suspended.Day",
        pluralKey = "Feature.UniversalFeatureRestrictions.AbuseVector.RobloxKick.DialogTitle.Suspended.Days"
    },
    {
        unitInSeconds = 3600,
        singularKey = "Feature.UniversalFeatureRestrictions.AbuseVector.RobloxKick.DialogTitle.Suspended.Hour",
        pluralKey = "Feature.UniversalFeatureRestrictions.AbuseVector.RobloxKick.DialogTitle.Suspended.Hours"
    },
    {
        unitInSeconds = 60,
        singularKey = "Feature.UniversalFeatureRestrictions.AbuseVector.RobloxKick.DialogTitle.Suspended.Minute",
        pluralKey = "Feature.UniversalFeatureRestrictions.AbuseVector.RobloxKick.DialogTitle.Suspended.Minutes"
    }
}

local function parseErrorDetails(tbl2)
    if tbl2 == nil then
        return {
            beginTimestamp = "",
            endTimestamp = "",
            labelTranslationKey = "",
            durationSeconds = nil
        }
    end

    return {
        beginTimestamp = tbl2.beginTimestamp or "",
        endTimestamp = tbl2.endTimestamp or "",
        labelTranslationKey = tbl2.labelTranslationKey or "",
        durationSeconds = tonumber(tbl2.durationSeconds)
    }
end

local function buildModerationDetail(messageToUser: string, tbl2)
    return {
        messageToUser = messageToUser,
        beginDate = tbl2.beginTimestamp,
        endDate = tbl2.endTimestamp,
        duration = tbl2.durationSeconds,
        labelTranslationKey = tbl2.labelTranslationKey,
        interventionId = "",
        punishedUserId = 0,
        punishmentId = 0,
        punishmentTypeDescription = "",
        badUtterances = {},
        context = {},
        verificationCategory = "",
        consequenceTransparencyMessage = "",
        showAppealsProcessLink = false,
        isForeshadowingConsequenceEnabled = false,
        violation = nil,
        acknowledgeable = false,
        showUGCAvatarGuidelinesLink = false
    }
end

local function pickTitleAndBody(func1: (...any) -> (...any), unitInSeconds: number?)
    if unitInSeconds == nil or unitInSeconds <= 0 then
        return {
            title = func1("Feature.UniversalFeatureRestrictions.AbuseVector.RobloxKick.DialogTitle.Banned"),
            body = func1("Feature.UniversalFeatureRestrictions.AbuseVector.RobloxKick.DialogBody.Banned")
        }
    end

    for _, value in tbl1 do
        if not (value.unitInSeconds <= unitInSeconds) then
            continue
        end

        local number = math.ceil(unitInSeconds / value.unitInSeconds)

        return {
            title = func1(if number == 1 then value.singularKey else value.pluralKey, { number = number }),
            body = func1("Feature.UniversalFeatureRestrictions.AbuseVector.RobloxKick.DialogBody.Suspended")
        }
    end

    return {
        title = func1(tbl1[3].singularKey, { number = 1 }),
        body = func1("Feature.UniversalFeatureRestrictions.AbuseVector.RobloxKick.DialogBody.Suspended")
    }
end

local function buildRobloxExperienceKickContent(messageToUser: string, tbl2, func1: (...any) -> (...any))
    local var1 = parseErrorDetails(tbl2)
    local moderationDetail = buildModerationDetail(messageToUser, var1)
    local tbl3 = pickTitleAndBody(func1, var1.durationSeconds)

    return {
        abuseVector = AbuseVector.RobloxExperienceKick,
        moderationDetail = moderationDetail,
        options = {
            titleOverride = tbl3.title,
            bodyOverride = tbl3.body
        }
    }
end

return buildRobloxExperienceKickContent
