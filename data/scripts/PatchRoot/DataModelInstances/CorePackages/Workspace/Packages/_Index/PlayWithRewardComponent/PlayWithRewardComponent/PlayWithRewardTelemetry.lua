-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T10:11:01Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local TelemetryService = game:GetService("TelemetryService")

local PlayWithRewardComponentParent = script:FindFirstAncestor("PlayWithRewardComponent").Parent
local FFlagSduiPlayWithRewardRefactor = require(PlayWithRewardComponentParent.SharedFlags).FFlagSduiPlayWithRewardRefactor

local standardizedFields = { "addOSInfo", "addSessionInfo", "addSessionId" }
local tbl1 = { "addOSInfo" }

local config = {
    eventName = "PlayWithRewardAdRequested",
    backends = { "EventIngest", "Points" },
    throttlingPercentage = game:DefineFastInt("PlayWithRewardAdRequestedTelemetryThrottleHundredthsPercent", 0),
    lastUpdated = { 26, 9, 28 },
    description = "        This is fired when a Play with Reward ad is requested.\n    "
}

local config2 = {
    eventName = "PlayWithRewardAdReceived",
    backends = { "EventIngest", "Points" },
    throttlingPercentage = game:DefineFastInt("PlayWithRewardAdReceivedTelemetryThrottleHundredthsPercent", 0),
    lastUpdated = { 26, 9, 30 },
    description = "        This is fired when a Play with Reward ad is received.\n    "
}

local config3 = {
    eventName = "PlayWithRewardBannerShown",
    backends = { "EventIngest", "Points" },
    throttlingPercentage = game:DefineFastInt("PlayWithRewardBannerShownTelemetryThrottleHundredthsPercent", 0),
    lastUpdated = { 26, 4, 27 },
    description = "        This is fired when a Play with Reward banner is shown on an EDP.\n    "
}

local config4 = {
    eventName = "PlayWithRewardButtonClicked",
    backends = { "EventIngest", "Points" },
    throttlingPercentage = game:DefineFastInt("PlayWithRewardButtonClickedTelemetryThrottleHundredthsPercent", 0),
    lastUpdated = { 25, 9, 24 },
    description = "        This is fired when a Play with Reward button is clicked on an EDP.\n    "
}

local config5 = {
    eventName = "PlayWithRewardAdPlaybackAttempted",
    backends = { "EventIngest", "Points" },
    throttlingPercentage = game:DefineFastInt("PlayWithRewardAdPlaybackAttemptedTelemetryThrottleHundredthsPercent", 0),
    lastUpdated = { 25, 9, 24 },
    description = "        This is fired when a Play with Reward ad starts playing.\n    "
}

local config6 = {
    eventName = "PlayWithRewardAdPlaybackStopped",
    backends = { "EventIngest", "Points" },
    throttlingPercentage = game:DefineFastInt("PlayWithRewardAdPlaybackStoppedTelemetryThrottleHundredthsPercent", 0),
    lastUpdated = { 25, 9, 24 },
    description = "        This is fired when a Play with Reward ad stops playing.\n    "
}

local config7 = {
    eventName = "PlayWithRewardGameJoinInitiated",
    backends = { "EventIngest", "Points" },
    throttlingPercentage = game:DefineFastInt("PlayWithRewardGameJoinInitiatedTelemetryThrottleHundredthsPercent", 0),
    lastUpdated = { 25, 9, 24 },
    description = "        This is fired when a Play with Reward game join is initiated from an EDP.\n    "
}

local config8 = {
    eventName = "PlayWithRewardBlackoutCurtain",
    backends = { "EventIngest", "Points" },
    throttlingPercentage = game:DefineFastInt("PlayWithRewardBlackoutCurtainTelemetryThrottleHundredthsPercent", 0),
    lastUpdated = { 26, 4, 3 },
    description = "        This is fired when the Play with Reward blackout curtain state changes (shown or hidden).\n    "
}

local config9 = {
    eventName = "PlayWithRewardShimmerShown",
    backends = { "EventIngest", "Points" },
    throttlingPercentage = game:DefineFastInt("PlayWithRewardShimmerShownTelemetryThrottleHundredthsPercent", 0),
    lastUpdated = { 26, 4, 28 },
    description = "        This is fired when the Play with Reward shimmer is shown.\n    "
}

local config10 = {
    eventName = "PlayWithRewardCoachmark",
    backends = { "EventIngest", "Points" },
    throttlingPercentage = game:DefineFastInt("PlayWithRewardCoachmarkTelemetryThrottleHundredthsPercent", 0),
    lastUpdated = { 26, 4, 21 },
    description = "        This is fired when a Play with Reward coachmark is shown or dismissed on an EDP.\n    "
}

local config11 = {
    eventName = "PlayWithRewardAdRequestedCounter",
    backends = { "RobloxTelemetryCounter" },
    lastUpdated = { 25, 9, 24 },
    description = "\t        Counter for PlayWithRewardAdRequested events.\n\t    "
}

local config12 = {
    eventName = "PlayWithRewardAdReceivedCounter",
    backends = { "RobloxTelemetryCounter" },
    lastUpdated = { 25, 9, 24 },
    description = "\t        Counter for PlayWithRewardAdReceived events with status.\n\t    "
}

local config13 = {
    eventName = "PlayWithRewardBannerShownCounter",
    backends = { "RobloxTelemetryCounter" },
    lastUpdated = { 26, 4, 27 },
    description = "\t        Counter for PlayWithRewardBannerShown events.\n\t    "
}

local config14 = {
    eventName = "PlayWithRewardButtonClickedCounter",
    backends = { "RobloxTelemetryCounter" },
    lastUpdated = { 25, 9, 24 },
    description = "\t        Counter for PlayWithRewardButtonClicked events.\n\t    "
}

local config15 = {
    eventName = "PlayWithRewardAdPlaybackAttemptedCounter",
    backends = { "RobloxTelemetryCounter" },
    lastUpdated = { 25, 9, 24 },
    description = "\t        Counter for PlayWithRewardAdPlaybackAttempted events.\n\t    "
}

local config16 = {
    eventName = "PlayWithRewardAdPlaybackStoppedCounter",
    backends = { "RobloxTelemetryCounter" },
    lastUpdated = { 25, 9, 24 },
    description = "\t        Counter for PlayWithRewardAdPlaybackStopped events with status.\n\t    "
}

local config17 = {
    eventName = "PlayWithRewardGameJoinInitiatedCounter",
    backends = { "RobloxTelemetryCounter" },
    lastUpdated = { 25, 9, 24 },
    description = "\t        Counter for PlayWithRewardGameJoinInitiated events.\n\t    "
}

local config18 = {
    eventName = "PlayWithRewardCoachmarkCounter",
    backends = { "RobloxTelemetryCounter" },
    lastUpdated = { 26, 4, 21 },
    description = "\t        Counter for PlayWithRewardCoachmark events, split by action.\n\t    "
}

local config19 = {
    eventName = "PlayWithRewardAdReceivedSuccessfully",
    backends = { "RobloxTelemetryStat" },
    lastUpdated = { 25, 9, 24 },
    description = "\t        Stats for successful PlayWithRewardAdReceived events.\n\t    "
}

local module = {}

local function getCoachmarkCustomFields(action: string, playWithRewardFlowId: string, universeId: string, productId: string) -- Luacid: Inlined by compiler; 1 call site recovered
    return {
        action = action,
        playWithRewardFlowId = playWithRewardFlowId,
        universeId = universeId,
        productId = productId
    }
end

function module.logPlayWithRewardAdRequested(playWithRewardFlowId: string, universeId: string, experimentUiVariant: string?)
    local customFields = {
        playWithRewardFlowId = playWithRewardFlowId,
        universeId = universeId,
        experimentUiVariant = 0
    }

    if not FFlagSduiPlayWithRewardRefactor then
        experimentUiVariant = nil
    end

    customFields.experimentUiVariant = experimentUiVariant

    TelemetryService:LogEvent(config, { standardizedFields = standardizedFields, customFields = customFields })

    TelemetryService:LogCounter(config11, { standardizedFields = tbl1, customFields = {} }, 1)
end

function module.logPlayWithRewardAdReceived(playWithRewardFlowId: string, universeId: string, isSuccessful: boolean, adAvailabilityResult: string?, fetchLatencyMs: number, productId: string?, experimentUiVariant: string?)
    local customFields = {
        playWithRewardFlowId = playWithRewardFlowId,
        universeId = universeId,
        isSuccessful = isSuccessful,
        adAvailabilityResult = adAvailabilityResult,
        fetchLatencyMs = fetchLatencyMs,
        productId = productId,
        experimentUiVariant = 0
    }

    if not FFlagSduiPlayWithRewardRefactor then
        experimentUiVariant = nil
    end

    customFields.experimentUiVariant = experimentUiVariant

    TelemetryService:LogEvent(config2, { standardizedFields = standardizedFields, customFields = customFields })

    TelemetryService:LogCounter(config12, {
        standardizedFields = tbl1,
        customFields = { isSuccessful = isSuccessful, adAvailabilityResult = adAvailabilityResult }
    }, 1)

    if not isSuccessful then
        return
    end

    TelemetryService:LogStat(
        config19,
        {
            standardizedFields = tbl1,
            customFields = { adAvailabilityResult = adAvailabilityResult }
        },
        fetchLatencyMs
    )
end

function module.logPlayWithRewardBannerShown(playWithRewardFlowId: string, universeId: string, showState: string, productId: string, experimentUiVariant: string)
    TelemetryService:LogEvent(config3, {
        standardizedFields = standardizedFields,
        customFields = {
            playWithRewardFlowId = playWithRewardFlowId,
            universeId = universeId,
            showState = showState,
            productId = productId,
            experimentUiVariant = experimentUiVariant
        }
    })

    TelemetryService:LogCounter(config13, { standardizedFields = tbl1, customFields = {} }, 1)
end

function module.logPlayWithRewardButtonClicked(playWithRewardFlowId: string, universeId: string, productId: string)
    TelemetryService:LogEvent(config4, {
        standardizedFields = standardizedFields,
        customFields = {
            playWithRewardFlowId = playWithRewardFlowId,
            universeId = universeId,
            productId = productId
        }
    })

    TelemetryService:LogCounter(config14, { standardizedFields = tbl1, customFields = {} }, 1)
end

function module.logPlayWithRewardAdPlaybackAttempted(playWithRewardFlowId: string, universeId: string, productId: string)
    TelemetryService:LogEvent(config5, {
        standardizedFields = standardizedFields,
        customFields = {
            playWithRewardFlowId = playWithRewardFlowId,
            universeId = universeId,
            productId = productId
        }
    })

    TelemetryService:LogCounter(config15, { standardizedFields = tbl1, customFields = {} }, 1)
end

function module.logPlayWithRewardAdPlaybackStopped(playWithRewardFlowId: string, universeId: string, adPlaybackStatus: string, productId: string)
    TelemetryService:LogEvent(config6, {
        standardizedFields = standardizedFields,
        customFields = {
            playWithRewardFlowId = playWithRewardFlowId,
            universeId = universeId,
            adPlaybackStatus = adPlaybackStatus,
            productId = productId
        }
    })

    TelemetryService:LogCounter(
        config16,
        {
            standardizedFields = tbl1,
            customFields = { adPlaybackStatus = adPlaybackStatus }
        },
        1
    )
end

function module.logPlayWithRewardGameJoinInitiated(playWithRewardFlowId: string, universeId: string, productId: string)
    TelemetryService:LogEvent(config7, {
        standardizedFields = standardizedFields,
        customFields = {
            playWithRewardFlowId = playWithRewardFlowId,
            universeId = universeId,
            productId = productId
        }
    })

    TelemetryService:LogCounter(config17, { standardizedFields = tbl1, customFields = {} }, 1)
end

function module.logPlayWithRewardBlackoutCurtainAction(playWithRewardFlowId: string, universeId: string, action: string, productId: string)
    TelemetryService:LogEvent(config8, {
        standardizedFields = standardizedFields,
        customFields = {
            playWithRewardFlowId = playWithRewardFlowId,
            universeId = universeId,
            action = action,
            productId = productId
        }
    })
end

function module.logPlayWithRewardShimmerShown(playWithRewardFlowId: string, universeId: string)
    TelemetryService:LogEvent(config9, {
        standardizedFields = standardizedFields,
        customFields = { playWithRewardFlowId = playWithRewardFlowId, universeId = universeId }
    })
end

function module.logPlayWithRewardCoachmark(action: string, playWithRewardFlowId: string, universeId: string, productId: string)
    local customFields = getCoachmarkCustomFields(action, playWithRewardFlowId, universeId, productId)
    TelemetryService:LogEvent(config10, { standardizedFields = standardizedFields, customFields = customFields })

    TelemetryService:LogCounter(config18, { standardizedFields = tbl1, customFields = { action = action } }, 1)
end

return module
