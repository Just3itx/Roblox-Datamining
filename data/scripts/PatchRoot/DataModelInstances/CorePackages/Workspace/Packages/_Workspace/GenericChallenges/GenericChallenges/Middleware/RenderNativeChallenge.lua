-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T16:31:38Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GenericChallenges = script:FindFirstAncestor("GenericChallenges")
local GenericType = require(GenericChallenges.Types.GenericType)
local mountRoCaptchaChallenge = require(script.Parent.Challenges.RoCaptcha.mountRoCaptchaChallenge)
local mountDeniedChallenge = require(script.Parent.Challenges.Denied.mountDeniedChallenge)
local DeniedMetadata = require(script.Parent.Challenges.Denied.DeniedMetadata)
local _ChallengeMetadata = require(GenericChallenges.Types.ChallengeMetadata)
local FFlagEnableRoCaptchaChallenge = require(script.Parent.Flags.FFlagEnableRoCaptchaChallenge)
local FFlagEnableDeniedChallenge = require(script.Parent.Flags.FFlagEnableDeniedChallenge)

local GenericChallengeService = game:GetService("GenericChallengeService")

local module = {}

function module.canRenderNativeChallenge(str1: string)
    return if FFlagEnableRoCaptchaChallenge and str1 == GenericType.toRawValue(GenericType.RoCaptcha) then true else FFlagEnableDeniedChallenge and str1 == GenericType.toRawValue(GenericType.Denied)
end

function module.render(tbl1)
    local challengeId = tbl1.challengeId
    local var1 = tbl1.genericChallengeService or GenericChallengeService

    if tbl1.challengeType == GenericType.toRawValue(GenericType.Denied) then
        local challengeMetadata = tbl1.challengeMetadata
        if challengeMetadata and challengeMetadata.reason == DeniedMetadata.DeniedReason.PromptUser then
            mountDeniedChallenge({
                challengeId = challengeId,
                reason = DeniedMetadata.DeniedReason.PromptUser,
                prompt = DeniedMetadata.getPrompt(challengeMetadata),
                onChallengeLoaded = function(bool1: boolean)
                    var1:SignalChallengeLoaded(challengeId, bool1)
                end,
                onChallengeAbandoned = function()
                    var1:SignalChallengeAbandoned(challengeId)
                end
            })

            return
        end

        var1:SignalChallengeLoaded(challengeId, false)

        return
    end

    if tbl1.challengeType ~= GenericType.toRawValue(GenericType.RoCaptcha) then
        return
    end

    mountRoCaptchaChallenge({
        challengeId = challengeId,
        challengeMetadata = tbl1.challengeMetadata,
        onChallengeLoaded = function(bool1: boolean)
            var1:SignalChallengeLoaded(challengeId, bool1)
        end,
        onChallengeFailed = function()
            var1:SignalChallengeAbandoned(challengeId)
        end,
        onChallengeAbandoned = function()
            var1:SignalChallengeAbandoned(challengeId)
        end
    })
end

return module
