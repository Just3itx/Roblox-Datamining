-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T01:31:22Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

local _Types = require(CorePackages.Workspace.Packages.ModerationCommon.Types)

local _createVoiceRestrictionController = require(CorePackages.Workspace.Packages.VoiceChat.createVoiceRestrictionController)

local function buildLegacyVoiceRestrictionDetail(tbl1)
    local settings = tbl1.settings
    local format = tbl1.format

    local str1 = ""
    local var1, var2, str2

    if not settings then
        var1 = format("Feature.UniversalFeatureRestrictions.Generic.DialogBody.Nudge")
        var2 = format(
            "Feature.UniversalFeatureRestrictions.Generic.DialogTitleV2.Nudge",
            {
                abuseVector = format("Feature.UniversalFeatureRestrictions.AbuseVector.Lowercase.LabelName.Voice")
            }
        )
        str2 = "nudge"
    elseif not settings.bannedUntil then
        var1 = format("Feature.UniversalFeatureRestrictions.Generic.DialogBody.Banned")
        var2 = format(
            "Feature.UniversalFeatureRestrictions.Generic.DialogTitle.Banned",
            {
                abuseVector = format("Feature.UniversalFeatureRestrictions.AbuseVector.Lowercase.LabelName.Voice")
            }
        )
        str2 = "ban"
    else
        local number = math.max(1, math.ceil((settings.bannedUntil.Seconds - tbl1.now) / 60))

        var1 = format("Feature.UniversalFeatureRestrictions.Generic.DialogBody.Suspended")
        var2 = format(
            if number == 1 then "Feature.UniversalFeatureRestrictions.Generic.DialogTitleV2.Suspended.Minute" else "Feature.UniversalFeatureRestrictions.Generic.DialogTitleV2.Suspended.Minutes",
            {
                abuseVector = format("Feature.UniversalFeatureRestrictions.AbuseVector.LabelName.Voice"),
                number = number
            }
        )
        str1 = DateTime.fromUnixTimestamp(settings.bannedUntil.Seconds):ToIsoDate()
        str2 = "timeout"
    end

    return {
        punishmentId = 0,
        punishedUserId = tbl1.userId,
        interventionId = "",
        messageToUser = "",
        title = var2,
        body = var1,
        punishmentTypeDescription = str2,
        acknowledgeable = false,
        beginDate = "",
        endDate = str1,
        badUtterances = {},
        context = {},
        verificationCategory = "",
        consequenceTransparencyMessage = "",
        showAppealsProcessLink = false,
        isForeshadowingConsequenceEnabled = false,
        showUGCAvatarGuidelinesLink = false,
        labelTranslationKey = ""
    }
end

return buildLegacyVoiceRestrictionDetail
