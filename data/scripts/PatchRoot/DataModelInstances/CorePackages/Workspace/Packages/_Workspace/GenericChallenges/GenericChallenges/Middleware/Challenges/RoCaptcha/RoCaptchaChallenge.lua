-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T16:31:11Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GenericChallenges = script:FindFirstAncestor("GenericChallenges")
local GenericChallengesParent = GenericChallenges.Parent

local HttpService = game:GetService("HttpService")

local React = require(GenericChallengesParent.React)

local RoCaptchaChallengeView = require(script.Parent.RoCaptchaChallengeView)
local RoCaptchaChallengeEvent = require(script.Parent.RoCaptchaChallengeEvent)
local RoCaptchaChallengeContext = require(script.Parent.RoCaptchaChallengeContext)
local _ChallengeMetadata = require(GenericChallenges.Types.ChallengeMetadata)

local ExperienceService = require(GenericChallengesParent.ExperienceService).ExperienceService
local default = require(GenericChallengesParent.LoggingProtocol).default

local function RoCaptchaChallenge(tbl1)
    local var1 = tbl1.experienceService or ExperienceService
    local desiredPlaceId = tbl1.desiredPlaceId or game.PlaceId
    local var3 = tbl1.logging or default

    local challengeId = tbl1.challengeId

    local var4 = React.useMemo(function()
        local challengeMetadata = tbl1.challengeMetadata
        if not challengeMetadata then
            return nil
        end

        return tonumber(challengeMetadata.challengePlaceId)
    end, { tbl1.challengeMetadata })

    local var5 = React.useRef(tbl1.onChallengeFailed)
    var5.current = tbl1.onChallengeFailed
    local var6 = React.useRef(tbl1.onChallengeAbandoned)
    var6.current = tbl1.onChallengeAbandoned
    local var7 = React.useRef(tbl1.onChallengeLoaded)
    var7.current = tbl1.onChallengeLoaded

    local var8 = React.useCallback(function(context)
        var3:logRobloxTelemetryEvent(
            RoCaptchaChallengeEvent,
            {},
            { context = context, challengeId = challengeId, challengePlaceId = var4 }
        )
    end, { var3, challengeId, var4 })

    React.useEffect(function()
        var8(RoCaptchaChallengeContext.ChallengeInitialized)
        if var4 ~= nil then
            var8(RoCaptchaChallengeContext.ChallengeDisplayed)
            if var7.current then
                var7.current(true)
            end

            return
        end

        var8(RoCaptchaChallengeContext.ChallengeInvalidated)
        if var7.current then
            var7.current(false)
        end
        if var5.current then
            var5.current()
        end
    end, { var8, var4 })

    local onJoin = React.useCallback(function()
        var8(RoCaptchaChallengeContext.ChallengeLaunched)

        var1:LaunchExperience(
            {
                placeId = var4,
                launchData = HttpService:JSONEncode({ challengeId = challengeId, desiredPlaceId = desiredPlaceId })
            },
            "RoCaptchaChallenge"
        )
    end, {
        var8,
        var1,
        challengeId,
        var4,
        desiredPlaceId
    })
    local onAbandon = React.useCallback(function()
        var8(RoCaptchaChallengeContext.ChallengeAbandoned)
        if var6.current then
            var6.current()
        end
    end, { var8 })

    if var4 == nil then
        return nil
    end

    return React.createElement(
        RoCaptchaChallengeView,
        {
            onJoin = onJoin,
            onAbandon = onAbandon,
            waitForFrame = tbl1.waitForFrame
        }
    )
end
return RoCaptchaChallenge
