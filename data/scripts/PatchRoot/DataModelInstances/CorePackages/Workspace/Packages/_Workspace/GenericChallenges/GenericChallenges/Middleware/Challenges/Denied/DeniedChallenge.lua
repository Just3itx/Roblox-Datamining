-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T16:30:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GenericChallenges = script:FindFirstAncestor("GenericChallenges")
local GenericChallengesParent = GenericChallenges.Parent

local React = require(GenericChallengesParent.React)
local LoggingProtocol = require(GenericChallengesParent.LoggingProtocol)

local ChallengeEventConstants = require(GenericChallenges.Utils.ChallengeEventConstants)
local DeniedChallengeView = require(script.Parent.DeniedChallengeView)
local DeniedChallengeEvent = require(script.Parent.DeniedChallengeEvent)

local ChallengeLifecycleEventConstants = ChallengeEventConstants.ChallengeLifecycleEventConstants

local default = LoggingProtocol.default

local function DeniedChallenge(tbl1)
    local var1 = tbl1.logging or default
    local challengeId = tbl1.challengeId
    local reason = tbl1.reason
    local prompt = tbl1.prompt

    local var2 = React.useRef(tbl1.onChallengeAbandoned)
    var2.current = tbl1.onChallengeAbandoned
    local var3 = React.useRef(tbl1.onChallengeLoaded)
    var3.current = tbl1.onChallengeLoaded

    local var4 = React.useCallback(function(context)
        var1:logRobloxTelemetryEvent(
            DeniedChallengeEvent,
            {},
            { context = context, challengeId = challengeId, reason = reason, prompt = prompt }
        )
    end, {
        var1,
        challengeId,
        reason,
        prompt
    })

    React.useEffect(function()
        var4(ChallengeLifecycleEventConstants.ChallengeInitialized)
        var4(ChallengeLifecycleEventConstants.ChallengeDisplayed)
        if var3.current then
            var3.current(true)
        end
    end, { var4 })

    local onAcknowledge = React.useCallback(function()
        var4(ChallengeLifecycleEventConstants.ChallengeAbandoned)
        if var2.current then
            var2.current()
        end
    end, { var4 })

    return React.createElement(
        DeniedChallengeView,
        {
            prompt = prompt,
            onAcknowledge = onAcknowledge,
            opaqueBackdrop = tbl1.opaqueBackdrop
        }
    )
end
return DeniedChallenge
