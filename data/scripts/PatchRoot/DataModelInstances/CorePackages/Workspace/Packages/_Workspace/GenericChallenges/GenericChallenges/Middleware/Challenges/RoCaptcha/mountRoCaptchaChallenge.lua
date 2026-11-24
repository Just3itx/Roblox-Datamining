-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T16:31:09Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GenericChallenges = script:FindFirstAncestor("GenericChallenges")
local GenericChallengesParent = GenericChallenges.Parent

local React = require(GenericChallengesParent.React)

local RoCaptchaChallenge = require(script.Parent.RoCaptchaChallenge)
local mountNativeChallenge = require(script.Parent.Parent.Common.mountNativeChallenge)
local _ChallengeMetadata = require(GenericChallenges.Types.ChallengeMetadata)

return function(tbl1)
    mountNativeChallenge({
        challengeId = tbl1.challengeId,
        shutdownOnTeardown = true,
        mount = tbl1.mount,
        shutdownGame = tbl1.shutdownGame,
        render = function(callback)
            return React.createElement(RoCaptchaChallenge, {
                challengeId = tbl1.challengeId,
                challengeMetadata = tbl1.challengeMetadata,
                experienceService = tbl1.experienceService,
                desiredPlaceId = tbl1.desiredPlaceId,
                logging = tbl1.logging,
                onChallengeLoaded = tbl1.onChallengeLoaded,
                onChallengeFailed = function()
                    if tbl1.onChallengeFailed then
                        tbl1.onChallengeFailed()
                    end
                    callback()
                end,
                onChallengeAbandoned = function()
                    if tbl1.onChallengeAbandoned then
                        tbl1.onChallengeAbandoned()
                    end
                    callback()
                end,
                onChallengeCompleted = function()
                    if tbl1.onChallengeCompleted then
                        tbl1.onChallengeCompleted()
                    end
                    callback()
                end
            })
        end
    })
end
