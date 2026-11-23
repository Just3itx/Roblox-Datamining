-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T07:11:24Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent
local Telemetry = require(AppChat.Telemetry.Telemetry)
local _ChatConversationTelemetryLayer = require(AppChat.Telemetry.Layers.ChatConversationTelemetryLayer)
local _ConversationActionType = require(AppChat.Analytics.Enums.ConversationActionType)
local _SocialLuaAnalytics = require(AppChatParent.SocialLuaAnalytics)
local DefaultTelemetryEvents = require(AppChat.Telemetry.DefaultTelemetryEvents)
local FFlagAppChatEnableMessageContextMenu = require(AppChat.Flags.FFlagAppChatEnableMessageContextMenu)

local namedCounterConfigurationNoEmittedInfo = DefaultTelemetryEvents.namedCounterConfigurationNoEmittedInfo
local namedCounterConfigurationAndFormat = DefaultTelemetryEvents.namedCounterConfigurationAndFormat

local EVENT_INGEST_NO_EMITTED_INFO = DefaultTelemetryEvents.EVENT_INGEST_NO_EMITTED_INFO

local function targetMessageFormatFunction()
    return DefaultTelemetryEvents.eventIngestWithFormatFunction(function(tbl1)
        return {
            targetMessageId = tbl1.targetMessageId,
            targetMessageSenderId = tbl1.targetMessageSenderId,
            targetMessageSentAt = tbl1.targetMessageSentAt,
            targetMessageLength = tbl1.targetMessageLength,
            targetMessageVisibility = tbl1.targetMessageVisibility
        }
    end)
end

return {
    ScreenRendered = Telemetry.new({
        name = "conversationScreenRendered",
        description = "",
        lastUpdated = { 2025, 7, 31 },
        backendsList = {
            namedCounterConfigurationNoEmittedInfo("AppChat.ChatConversation.Rendered"),
            DefaultTelemetryEvents.eventIngestWithFormatFunction(function(tbl1)
                return {
                    loadedMessageCount = tbl1.loadedMessageCount
                }
            end)
        }
    }),
    ScreenExit = Telemetry.new({
        name = "conversationScreenExit",
        description = "",
        lastUpdated = { 2026, 11, 4 },
        backendsList = {
            namedCounterConfigurationAndFormat("AppChat.ChatConversation.Exit", function(tbl1)
                return {
                    conversationExitType = tbl1.conversationExitType
                }
            end),
            DefaultTelemetryEvents.eventIngestWithFormatFunction(function(tbl1)
                return {
                    conversationExitType = tbl1.conversationExitType,
                    loadedMessageCount = tbl1.loadedMessageCount
                }
            end)
        }
    }),
    ConversationInfoBtnClicked = Telemetry.new({
        name = "conversationInfoBtnClicked",
        description = "",
        lastUpdated = { 2026, 1, 27 },
        backendsList = { namedCounterConfigurationNoEmittedInfo("AppChat.ChatConversation.Button.Info"), EVENT_INGEST_NO_EMITTED_INFO }
    }),
    ConversationMessageSent = Telemetry.new({
        name = "conversationMessageSent",
        description = "",
        lastUpdated = { 2026, 1, 27 },
        backendsList = {
            namedCounterConfigurationAndFormat("AppChat.ChatConversation.Message.Sent", function(tbl1)
                return {
                    messageSentResult = tbl1.messageSentResult
                }
            end),
            DefaultTelemetryEvents.eventIngestWithFormatFunction(function(tbl1)
                return {
                    messageSentResult = tbl1.messageSentResult,
                    messageId = tbl1.messageId,
                    recipientIds = tbl1.recipientIds,
                    targetMessageId = tbl1.targetMessageId,
                    targetMessageSenderId = tbl1.targetMessageSenderId,
                    targetMessageSentAt = tbl1.targetMessageSentAt,
                    targetMessageLength = tbl1.targetMessageLength
                }
            end)
        }
    }),
    ConversationMoreMenuBtnClicked = Telemetry.new({
        name = "conversationMoreMenuBtnClicked",
        description = "",
        lastUpdated = { 2026, 1, 27 },
        backendsList = {
            namedCounterConfigurationAndFormat("AppChat.ChatConversation.Button.MoreMenu", function(tbl1)
                return {
                    action = tbl1.action
                }
            end),
            DefaultTelemetryEvents.eventIngestWithFormatFunction(function(tbl1)
                return {
                    action = tbl1.action
                }
            end)
        }
    }),
    ConversationSendBtnClicked = Telemetry.new({
        name = "conversationSendBtnClicked",
        description = "",
        lastUpdated = { 2026, 1, 27 },
        backendsList = {
            namedCounterConfigurationAndFormat("AppChat.ChatConversation.Button.Send", function(tbl1)
                return {
                    sendBtnClickResult = tbl1.sendBtnClickResult
                }
            end),
            DefaultTelemetryEvents.eventIngestWithFormatFunction(function(tbl1)
                return {
                    sendBtnClickResult = tbl1.sendBtnClickResult
                }
            end)
        }
    }),
    ConversationMessagePressed = Telemetry.new({
        name = "chatMessagePressed",
        description = "",
        lastUpdated = { 2025, 9, 9 },
        backendsList = { namedCounterConfigurationNoEmittedInfo("AppChat.ChatConversation.Message.Pressed"), targetMessageFormatFunction() }
    }),
    ConversationMessageLongPressed = Telemetry.new({
        name = "chatMessageLongPressed",
        description = "",
        lastUpdated = { 2025, 9, 9 },
        backendsList = { namedCounterConfigurationNoEmittedInfo("AppChat.ChatConversation.Message.LongPressed"), targetMessageFormatFunction() }
    }),
    ConversationMessageSwiped = Telemetry.new({
        name = "chatMessageSwiped",
        description = "",
        lastUpdated = { 2025, 11, 25 },
        backendsList = { namedCounterConfigurationNoEmittedInfo("AppChat.ChatConversation.Message.Swiped"), targetMessageFormatFunction() }
    }),
    ConversationMessageReplyIconImpression = Telemetry.new({
        name = "chatMessageReplyIconImpression",
        description = "",
        lastUpdated = { 2025, 9, 9 },
        backendsList = { namedCounterConfigurationNoEmittedInfo("AppChat.ChatConversation.Message.ReplyIcon.Impression"), targetMessageFormatFunction() }
    }),
    ConversationMessageReplyIconClicked = Telemetry.new({
        name = "chatMessageReplyIconClicked",
        description = "",
        lastUpdated = { 2025, 9, 9 },
        backendsList = { namedCounterConfigurationNoEmittedInfo("AppChat.ChatConversation.Message.ReplyIcon.Clicked"), targetMessageFormatFunction() }
    }),
    ConversationMessageOpenMenuIconClicked = if FFlagAppChatEnableMessageContextMenu then Telemetry.new({
        name = "chatMessageOpenMenuIconClicked",
        description = "",
        lastUpdated = { 2025, 9, 9 },
        backendsList = { namedCounterConfigurationNoEmittedInfo("AppChat.ChatConversation.Message.OpenMenuIcon.Clicked"), targetMessageFormatFunction() }
    }) else nil,
    ConversationInputBarReplyComposeRendered = Telemetry.new({
        name = "chatInputBarReplyComposeRendered",
        description = "",
        lastUpdated = { 2025, 9, 17 },
        backendsList = { namedCounterConfigurationNoEmittedInfo("AppChat.ChatConversation.ReplyComposeBar.Rendered"), targetMessageFormatFunction() }
    }),
    ConversationInputBarReplyComposeCancelBtnActivated = Telemetry.new({
        name = "chatInputBarReplyComposeCancelBtnActivated",
        description = "",
        lastUpdated = { 2025, 9, 17 },
        backendsList = { namedCounterConfigurationNoEmittedInfo("AppChat.ChatConversation.ReplyComposeBar.Button.Cancel"), targetMessageFormatFunction() }
    }),
    ConversationMessageFtuxTooltipImpression = Telemetry.new({
        name = "chatMessageFtuxTooltipImpression",
        description = "",
        lastUpdated = { 2026, 1, 27 },
        backendsList = {
            namedCounterConfigurationAndFormat("AppChat.ChatConversation.Message.FtuxTooltip.Impression", function(tbl1)
                return {
                    tooltipVariant = tbl1.tooltipVariant
                }
            end),
            DefaultTelemetryEvents.eventIngestWithFormatFunction(function(tbl1)
                return {
                    tooltipVariant = tbl1.tooltipVariant
                }
            end)
        }
    }),
    ConversationMessageFtuxTooltipDismissed = Telemetry.new({
        name = "chatMessageFtuxTooltipDismissed",
        description = "",
        lastUpdated = { 2026, 1, 27 },
        backendsList = {
            namedCounterConfigurationAndFormat("AppChat.ChatConversation.Message.FtuxTooltip.Dismissed", function(tbl1)
                return {
                    tooltipVariant = tbl1.tooltipVariant
                }
            end),
            DefaultTelemetryEvents.eventIngestWithFormatFunction(function(tbl1)
                return {
                    tooltipVariant = tbl1.tooltipVariant
                }
            end)
        }
    }),
    GameCardThumbnailClicked = Telemetry.new({
        name = "gameCardThumbnailClicked",
        description = "",
        lastUpdated = { 2025, 11, 18 },
        backendsList = {
            namedCounterConfigurationNoEmittedInfo("AppChat.ChatConversation.GameCard.Thumbnail.Clicked"),
            DefaultTelemetryEvents.eventIngestWithFormatFunction(function(tbl1)
                return {
                    universeId = tbl1.universeId,
                    placeId = tbl1.placeId
                }
            end)
        }
    }),
    GameCardPlayButtonClicked = Telemetry.new({
        name = "gameCardPlayButtonClicked",
        description = "",
        lastUpdated = { 2025, 11, 18 },
        backendsList = {
            namedCounterConfigurationNoEmittedInfo("AppChat.ChatConversation.GameCard.Button.Play"),
            DefaultTelemetryEvents.eventIngestWithFormatFunction(function(tbl1)
                return {
                    universeId = tbl1.universeId,
                    placeId = tbl1.placeId
                }
            end)
        }
    }),
    GameCardMetadataClicked = Telemetry.new({
        name = "gameCardMetadataClicked",
        description = "",
        lastUpdated = { 2025, 11, 19 },
        backendsList = {
            namedCounterConfigurationNoEmittedInfo("AppChat.ChatConversation.GameCard.Metadata.Clicked"),
            DefaultTelemetryEvents.eventIngestWithFormatFunction(function(tbl1)
                return {
                    universeId = tbl1.universeId,
                    placeId = tbl1.placeId
                }
            end)
        }
    })
}
