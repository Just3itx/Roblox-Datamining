-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T14:51:22Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local TelemetryService = game:GetService("TelemetryService")

local ShareSheet = script:FindFirstAncestor("ShareSheet")
local ShareSheetParent = ShareSheet.Parent

local _GetExternalChatMessageSenderStore = require(ShareSheetParent.AppChat.GetExternalChatMessageSenderStore)
local LoggingProtocol = require(ShareSheetParent.LoggingProtocol)
local _RecipientSource = require(ShareSheet.Recipients.RecipientSource)
local getElapsedTimeMs = require(ShareSheet.getElapsedTimeMs)

local EventIngest = LoggingProtocol.TelemetryBackends.EventIngest

local throttlingPercentage = game:DefineFastInt("ShareSheetTelemetryThrottleHundredthsPercent", 10000)

local tbl1 = {
    shareSheetOpened = {
        eventName = "shareSheetOpened",
        backends = { EventIngest },
        throttlingPercentage = throttlingPercentage,
        lastUpdated = { 2025, 7, 22 },
        description = "Share sheet was opened"
    },
    shareSheetLinkCopied = {
        eventName = "shareSheetLinkCopied",
        backends = { EventIngest },
        throttlingPercentage = throttlingPercentage,
        lastUpdated = { 2025, 7, 22 },
        description = "Link was copied from share sheet"
    },
    shareSheetMessageSent = {
        eventName = "shareSheetMessageSent",
        backends = { EventIngest },
        throttlingPercentage = throttlingPercentage,
        lastUpdated = { 2025, 7, 22 },
        description = "Message was sent from share sheet"
    },
    Lifecycle = {
        eventName = "shareSheetLifecycle",
        backends = { EventIngest },
        throttlingPercentage = throttlingPercentage,
        lastUpdated = { 2026, 8, 3 },
        description = "Share sheet request lifecycle transitions"
    },
    Interaction = {
        eventName = "shareSheetInteraction",
        backends = { EventIngest },
        throttlingPercentage = throttlingPercentage,
        lastUpdated = { 2026, 8, 3 },
        description = "User interactions within the share sheet"
    },
    MessageSendResult = {
        eventName = "shareSheetMessageSendResult",
        backends = { EventIngest },
        throttlingPercentage = throttlingPercentage,
        lastUpdated = { 2026, 9, 8 },
        description = "Per-recipient share sheet message send results"
    }
}

local standardizedFields = {
    "addPlaceId",
    "addUniverseId",
    "addPlaySessionId",
    "addSessionInfo"
}
local module = {
    LifecycleType = { Open = "open", Close = "close" },
    CloseReason = {
        UserDismissed = "userDismissed",
        SendSuccess = "sendSuccess",
        Programmatic = "programmatic",
        Replaced = "replaced"
    },
    InteractionType = {
        CopyLink = "copyLink",
        NativeShare = "nativeShare",
        ConversationSelected = "conversationSelected",
        ConversationDeselected = "conversationDeselected",
        CustomMessageComposerFocused = "customMessageComposerFocused",
        CustomMessageSubmitted = "customMessageSubmitted",
        ViewMessage = "viewMessage"
    },
    ViewDestination = { Conversation = "conversation", ChatLanding = "chatLanding" }
}

local tbl3 = {
    eventName = "shareSheetOpened",
    backends = { LoggingProtocol.TelemetryBackends.Counter },
    throttlingPercentage = throttlingPercentage,
    lastUpdated = { 2026, 8, 3 },
    description = "Count of share sheet requests opened"
}

local tbl4 = {
    eventName = "shareSheetClosed",
    backends = { LoggingProtocol.TelemetryBackends.Counter },
    throttlingPercentage = throttlingPercentage,
    lastUpdated = { 2026, 8, 3 },
    description = "Count of share sheet requests closed"
}

local config = {
    eventName = "shareSheetInteraction",
    backends = { LoggingProtocol.TelemetryBackends.Counter },
    throttlingPercentage = throttlingPercentage,
    lastUpdated = { 2026, 8, 3 },
    description = "Count of share sheet interactions"
}

local config2 = {
    eventName = "shareSheetMessageSendResult",
    backends = { LoggingProtocol.TelemetryBackends.Counter },
    throttlingPercentage = throttlingPercentage,
    lastUpdated = { 2026, 9, 8 },
    description = "Count of per-recipient share sheet message send results"
}

local config3 = {
    eventName = "shareSheetMessageSendResultDurationMs",
    backends = { LoggingProtocol.TelemetryBackends.Stats },
    throttlingPercentage = throttlingPercentage,
    lastUpdated = { 2026, 9, 8 },
    description = "Duration in milliseconds from recipient send invocation to result"
}

function module.logShareSheetOpened(customFields)
    TelemetryService:LogEvent(
        tbl1.shareSheetOpened,
        { standardizedFields = standardizedFields, customFields = customFields }
    )
end

function module.logShareSheetLinkCopied(customFields)
    TelemetryService:LogEvent(
        tbl1.shareSheetLinkCopied,
        { standardizedFields = standardizedFields, customFields = customFields }
    )
end

function module.logShareSheetMessageSent(customFields)
    TelemetryService:LogEvent(
        tbl1.shareSheetMessageSent,
        { standardizedFields = standardizedFields, customFields = customFields }
    )
end

function module.logLifecycle(customFields)
    TelemetryService:LogEvent(tbl1.Lifecycle, { standardizedFields = standardizedFields, customFields = customFields })

    TelemetryService:LogCounter(
        if customFields.lifecycleType == module.LifecycleType.Open then tbl3 else tbl4,
        {
            customFields = {
                context = customFields.context,
                closeReason = customFields.closeReason
            }
        },
        1
    )
end

function module.logInteraction(customFields)
    TelemetryService:LogEvent(tbl1.Interaction, { standardizedFields = standardizedFields, customFields = customFields })

    TelemetryService:LogCounter(
        config,
        {
            customFields = {
                context = customFields.context,
                interactionType = customFields.interactionType
            }
        },
        1
    )
end

function module.logMessageSendResult(customFields)
    TelemetryService:LogEvent(
        tbl1.MessageSendResult,
        { standardizedFields = standardizedFields, customFields = customFields }
    )
    TelemetryService:LogStat(config3, {
        customFields = {
            context = customFields.context,
            sendStatus = customFields.sendStatus,
            hasCustomMessage = customFields.hasCustomMessage
        }
    }, customFields.durationMs)
    TelemetryService:LogCounter(config2, {
        customFields = {
            context = customFields.context,
            sendStatus = customFields.sendStatus,
            hasCustomMessage = customFields.hasCustomMessage
        }
    }, 1)
end

function module.startMessageSendResult(arg1)
    local now = os.clock()
    return function(arg2)
        module.logMessageSendResult({
            context = arg1.context,
            recipientSource = arg1.recipientSource,
            telemetryId = arg1.telemetryId,
            requestedConversationId = arg1.requestedConversationId,
            resolvedConversationId = arg2.conversationId,
            sendStatus = arg2.status,
            hasCustomMessage = arg1.hasCustomMessage,
            durationMs = getElapsedTimeMs(now)
        })
    end
end

return module
