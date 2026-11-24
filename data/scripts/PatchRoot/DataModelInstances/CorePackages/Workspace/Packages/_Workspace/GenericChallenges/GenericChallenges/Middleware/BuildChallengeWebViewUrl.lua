-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T16:21:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local _ChallengeHeaders = require(script.Parent.ChallengeHeaders)
local GenericChallenges = script:FindFirstAncestor("GenericChallenges")
local constants = require(GenericChallenges.Utils.constants)
local ChallengeType = require(GenericChallenges.Types.ChallengeType)
local _ChallengeParameters = require(GenericChallenges.Types.ChallengeParameters)
local TwoStepVerificationActionType = require(GenericChallenges.Types.TwoStepVerificationActionType)
local CaptchaActionType = require(GenericChallenges.Types.CaptchaActionType)
local GenericChallengesParent = GenericChallenges.Parent

local Base64 = require(GenericChallengesParent.AuthCommon).Utils.Base64

local NotificationService = game:GetService("NotificationService")
local UserInputService = game:GetService("UserInputService")

local UrlBuilder = require(GenericChallengesParent.UrlBuilder).UrlBuilder
local UrlBase = require(GenericChallengesParent.UrlBuilder).UrlBase
local Cryo = require(GenericChallengesParent.Cryo)

local function getUserDarkModeSettingQueryParam(): string -- Luacid: Inlined by compiler; 1 call site recovered
    return if string.lower(NotificationService.SelectedTheme) == "dark" then "true" else "false"
end

local function getUserAppTypeQueryParam()
    local platform = UserInputService:GetPlatform()
    local str1 = "unknown"
    if platform == Enum.Platform.Android then
        return "android"
    end

    if platform == Enum.Platform.IOS then
        return "ios"
    end

    if platform == Enum.Platform.Windows then
        return "windows"
    end

    if platform == Enum.Platform.OSX then
        return "osx"
    end

    if platform == Enum.Platform.UWP then
        return "uwp"
    end

    if platform == Enum.Platform.XBoxOne then
        str1 = "xbox"
    end

    return str1
end

local function getChallengeTypeQueryParameters(arg1, arg2)
    if arg1 == ChallengeType.Captcha then
        assert(arg2.actionType ~= nil, "actionType must be provided to render captcha")
        assert(arg2.dataExchangeBlob ~= nil, "dataExchangeBlob must be provided to render captcha")
        assert(arg2.captchaId ~= nil, "captchaId must be provided to render captcha")
        return {
            ["action-type"] = CaptchaActionType.toRawValue(arg2.actionType),
            ["data-exchange-blob"] = arg2.dataExchangeBlob,
            ["captcha-id"] = arg2.captchaId
        }
    end

    if arg1 == ChallengeType.TwoStepVerification then
        assert(arg2.challengeId ~= nil, "challengeId must be provided to render 2sv")
        assert(arg2.userId ~= nil, "userId must be provided to render 2sv")
        assert(arg2.actionType ~= nil, "actionType must be provided to render 2sv")
        assert(arg2.allowRememberDevice ~= nil, "allowRememberDevice must be provided to render 2sv")
        local tbl1 = {
            ["challenge-id"] = arg2.challengeId,
            ["user-id"] = arg2.userId,
            ["action-type"] = TwoStepVerificationActionType.toRawValue(arg2.actionType),
            ["allow-remember-device"] = if arg2.allowRememberDevice then "true" else "false",
            ["client-supports-2sv-recovery"] = if arg2.clientSupports2svRecovery then "true" else "false"
        }
        if arg2.recoverySessionId ~= nil and string.len(arg2.recoverySessionId) > 0 then
            tbl1["recovery-session-id"] = arg2.recoverySessionId
        end
        return tbl1
    end

    if arg1 == ChallengeType.SecurityQuestions then
        assert(arg2.sessionId ~= nil, "sessionId must be provided to render security questions")
        assert(arg2.userId ~= nil, "userId must be provided to render security questions")
        return {
            ["user-id"] = arg2.userId,
            ["session-id"] = arg2.sessionId
        }
    end

    if arg1 == ChallengeType.Reauthentication then
        return {}
    end

    if arg1 ~= ChallengeType.Generic then
        return {}
    end

    assert(arg2.genericChallengeId ~= nil, "genericChallengeId must be provided to render challenge")
    assert(arg2.genericChallengeType ~= nil, "genericChallengeType must be provided to render challenge")

    assert(arg2.genericChallengeMetadata ~= nil, "genericChallengeMetadata must be provided to render challenge")

    return {
        ["generic-challenge-id"] = arg2.genericChallengeId,
        ["generic-challenge-type"] = arg2.genericChallengeType,
        ["challenge-metadata-json"] = arg2.genericChallengeMetadata
    }
end

return function(arg1, arg2, arg3)
    if arg1 ~= nil then
        assert(arg3 == nil, "challenge parameters cannot be specified for generic challenge rendering")
        assert(string.len(arg1.challengeId) > 0, "challenge id does not exist")
        assert(arg1.challengeType.typed ~= nil, "challenge is of an unknown type")
    end
    local generic = ChallengeType.Generic
    if arg2 == nil then
        arg2 = generic
    else
        assert(ChallengeType.toRawValue(arg2) ~= nil, "challenge type is not valid")
    end

    local tbl1 = {
        [constants.appTypeQueryParam] = getUserAppTypeQueryParam(),
        [constants.challengeTypeQueryParam] = ChallengeType.toRawValue(arg2),
        [constants.darkModeQueryParam] = getUserDarkModeSettingQueryParam()
    }
    local challengeTypeQueryParameters

    if arg3 ~= nil then
        challengeTypeQueryParameters = getChallengeTypeQueryParameters(arg2, arg3)
    else
        assert(arg1 ~= nil, "challenge headers must be defined for generic challenge rendering")

        challengeTypeQueryParameters = {
            [constants.genericChallengeIdQueryParam] = arg1.challengeId,
            [constants.genericChallengeTypeQueryParam] = arg1.challengeType.raw,
            [constants.challengeMetadataJsonQueryParam] = Base64.EncodeUrl(arg1.challengeMetadata.decoded)
        }
    end
    return UrlBuilder.new(
        {
            base = UrlBase.WWW,
            path = "challenge/cdn/hybrid",
            query = Cryo.Dictionary.join(tbl1, challengeTypeQueryParameters)
        }
    )()
end
