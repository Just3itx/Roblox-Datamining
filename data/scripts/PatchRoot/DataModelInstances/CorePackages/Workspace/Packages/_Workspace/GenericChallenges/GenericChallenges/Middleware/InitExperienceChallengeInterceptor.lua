-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T16:31:31Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RenderChallenge = require(script.Parent.RenderChallenge)
local RenderNativeChallenge = require(script.Parent.RenderNativeChallenge)
local FFlagEnableRenderNativeChallenge = require(script.Parent.Flags.FFlagEnableRenderNativeChallenge)
local GenericChallenges = script:FindFirstAncestor("GenericChallenges")
local ChallengeType = require(GenericChallenges.Types.ChallengeType)
local decodeChallengeMetadata = require(GenericChallenges.Utils.decodeChallengeMetadata)
local GenericChallengesParent = GenericChallenges.Parent
local Base64 = require(GenericChallengesParent.AuthCommon).Utils.Base64

local HttpService = game:GetService("HttpService")
local GenericChallengeService = game:GetService("GenericChallengeService")

local bool1 = game:DefineFastFlag("FFlagEnableMutexOnGenericChallengeInterceptorMount", false)
local bool2 = false

function challengeRequiredEventHandler(challengeId: string, challengeType: string, genericChallengeMetadata: string)
    if FFlagEnableRenderNativeChallenge and RenderNativeChallenge.canRenderNativeChallenge(challengeType) then
        RenderNativeChallenge.render({
            challengeId = challengeId,
            challengeType = challengeType,
            challengeMetadata = decodeChallengeMetadata(genericChallengeMetadata)
        })
        return
    end

    RenderChallenge({
        challengeType = ChallengeType.Generic,
        challengeParameters = {
            genericChallengeId = challengeId,
            genericChallengeType = challengeType,
            genericChallengeMetadata = genericChallengeMetadata
        },
        callbacks = {
            OnChallengeLoadFailed = function(_)
                GenericChallengeService:SignalChallengeLoaded(challengeId, false)
            end,
            OnChallengeCompleted = function(arg1)
                if arg1.data.metadata ~= nil then
                    local challengeMetadata = Base64.Encode(HttpService:JSONEncode(arg1.data.metadata))
                    GenericChallengeService:SignalChallengeCompleted(challengeId, challengeType, challengeMetadata)
                end
            end,
            OnChallengeInvalidated = function(_)
                GenericChallengeService:SignalChallengeInvalidated(challengeId)
            end,
            OnChallengeAbandoned = function()
                GenericChallengeService:SignalChallengeAbandoned(challengeId)
            end
        },
        renderWebViewInModal = true,
        onWebViewOpen = function()
            GenericChallengeService:SignalChallengeLoaded(challengeId, true)
        end
    })
end

return function()
    if bool1 then
        if not bool2 then
            bool2 = true
            GenericChallengeService.ChallengeRequiredEvent:Connect(challengeRequiredEventHandler)
        end
    else
        GenericChallengeService.ChallengeRequiredEvent:Connect(challengeRequiredEventHandler)
    end
end
