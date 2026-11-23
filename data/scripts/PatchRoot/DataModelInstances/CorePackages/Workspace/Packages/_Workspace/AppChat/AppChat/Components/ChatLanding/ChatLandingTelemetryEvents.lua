-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T08:01:27Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent
local Telemetry = require(AppChat.Telemetry.Telemetry)
local _ChatLandingTelemetryLayer = require(AppChat.Telemetry.Layers.ChatLandingTelemetryLayer)
local _SocialLuaAnalytics = require(AppChatParent.SocialLuaAnalytics)
local DefaultTelemetryEvents = require(AppChat.Telemetry.DefaultTelemetryEvents)

local namedCounterConfigurationNoEmittedInfo = DefaultTelemetryEvents.namedCounterConfigurationNoEmittedInfo
local namedCounterConfigurationAndFormat = DefaultTelemetryEvents.namedCounterConfigurationAndFormat
local namedStatConfigurationAndFormat = DefaultTelemetryEvents.namedStatConfigurationAndFormat

local EVENT_INGEST_NO_EMITTED_INFO = DefaultTelemetryEvents.EVENT_INGEST_NO_EMITTED_INFO

return {
    AppChatVisible = Telemetry.new({
        name = "appChatVisible",
        description = "",
        lastUpdated = { 2026, 10, 7 },
        backendsList = {
            namedCounterConfigurationAndFormat("AppChat.Navigation.Visible", function(tbl1)
                return {
                    isChatEnabled = tbl1.isChatEnabled,
                    isChatLoading = tbl1.isChatLoading,
                    isInConversation = tbl1.isInConversation
                }
            end),
            DefaultTelemetryEvents.eventIngestWithFormatFunction(function(tbl1)
                return {
                    isChatEnabled = tbl1.isChatEnabled,
                    isChatLoading = tbl1.isChatLoading
                }
            end)
        }
    }),
    AppChatClosed = Telemetry.new({
        name = "appChatClosed",
        description = "",
        lastUpdated = { 2026, 2, 9 },
        backendsList = {
            namedCounterConfigurationAndFormat("AppChat.Navigation.Closed", function(tbl1)
                return {
                    isChatEnabled = tbl1.isChatEnabled,
                    isChatLoading = tbl1.isChatLoading
                }
            end),
            DefaultTelemetryEvents.eventIngestWithFormatFunction(function(tbl1)
                return {
                    isChatEnabled = tbl1.isChatEnabled,
                    isChatLoading = tbl1.isChatLoading
                }
            end)
        }
    }),
    ScreenRendered = Telemetry.new({
        name = "chatLandingScreenRendered",
        description = "",
        lastUpdated = { 2026, 1, 27 },
        backendsList = {
            namedCounterConfigurationAndFormat("AppChat.ChatLanding.Rendered", function(tbl1)
                return {
                    isChatEnabled = tbl1.isChatEnabled
                }
            end),
            DefaultTelemetryEvents.eventIngestWithFormatFunction(function(tbl1)
                return {
                    isChatEnabled = tbl1.isChatEnabled
                }
            end)
        }
    }),
    ChatEmptyStateScreenRendered = Telemetry.new({
        name = "chatEmptyStateScreenRendered",
        description = "",
        lastUpdated = { 2026, 1, 27 },
        backendsList = {
            namedCounterConfigurationAndFormat("AppChat.ChatLanding.EmptyState.Rendered", function(tbl1)
                return {
                    emptyStateType = tbl1.emptyStateType
                }
            end),
            DefaultTelemetryEvents.eventIngestWithFormatFunction(function(tbl1)
                return {
                    emptyStateType = tbl1.emptyStateType
                }
            end)
        }
    }),
    ChatAddFriendsBtnClicked = Telemetry.new({
        name = "chatAddFriendsBtnClicked",
        description = "",
        lastUpdated = { 2026, 1, 27 },
        backendsList = { namedCounterConfigurationNoEmittedInfo("AppChat.ChatLanding.Button.AddConnections"), EVENT_INGEST_NO_EMITTED_INFO }
    }),
    ChatLandingSearchBtnClicked = Telemetry.new({
        name = "chatLandingSearchBtnClicked",
        description = "",
        lastUpdated = { 2025, 7, 31 },
        backendsList = { namedCounterConfigurationNoEmittedInfo("AppChat.ChatLanding.Button.Search"), EVENT_INGEST_NO_EMITTED_INFO }
    }),
    ChatLandingComposeBtnClicked = Telemetry.new({
        name = "chatLandingComposeBtnClicked",
        description = "",
        lastUpdated = { 2025, 7, 31 },
        backendsList = { namedCounterConfigurationNoEmittedInfo("AppChat.ChatLanding.Button.Compose"), EVENT_INGEST_NO_EMITTED_INFO }
    }),
    ChatLandingNotifBtnClicked = Telemetry.new({
        name = "chatLandingNotifBtnClicked",
        description = "",
        lastUpdated = { 2025, 7, 31 },
        backendsList = { namedCounterConfigurationNoEmittedInfo("AppChat.ChatLanding.Button.Notifications"), EVENT_INGEST_NO_EMITTED_INFO }
    }),
    ChatLandingSnoozeBtnClicked = Telemetry.new({
        name = "chatLandingSnoozeBtnClicked",
        description = "",
        lastUpdated = { 2026, 1, 27 },
        backendsList = {
            namedCounterConfigurationAndFormat("AppChat.ChatLanding.Button.Snooze", function(tbl1)
                return {
                    isChatNotificationsMuted = tbl1.isChatNotificationsMuted
                }
            end),
            DefaultTelemetryEvents.eventIngestWithFormatFunction(function(tbl1)
                return {
                    isChatNotificationsMuted = tbl1.isChatNotificationsMuted
                }
            end)
        }
    }),
    ConversationCellRendered = Telemetry.new({
        name = "chatLandingConversationCellRendered",
        description = "",
        lastUpdated = { 2026, 1, 27 },
        backendsList = {
            namedCounterConfigurationAndFormat("AppChat.ChatLanding.ConversationCell.Rendered", function(tbl1)
                return {
                    isFiltered = tbl1.isFiltered,
                    hasUnreadMessages = tbl1.hasUnreadMessages,
                    selectedConversationModerationType = tbl1.selectedConversationModerationType,
                    selectedConversationUserPendingStatus = tbl1.selectedConversationUserPendingStatus,
                    osaAcknowledgementStatus = tbl1.osaAcknowledgementStatus
                }
            end),
            DefaultTelemetryEvents.eventIngestWithFormatFunction(function(tbl1)
                return {
                    isFiltered = tbl1.isFiltered,
                    conversationListCount = tbl1.conversationListCount,
                    selectedConversationId = tbl1.selectedConversationId,
                    selectedIndex = tbl1.selectedIndex,
                    hasUnreadMessages = tbl1.hasUnreadMessages,
                    selectedConversationModerationType = tbl1.selectedConversationModerationType,
                    selectedConversationUserPendingStatus = tbl1.selectedConversationUserPendingStatus,
                    participantUserIds = tbl1.participantUserIds,
                    osaAcknowledgementStatus = tbl1.osaAcknowledgementStatus
                }
            end)
        }
    }),
    ConversationCellRenderedIndexStat = Telemetry.new({
        name = "chatLandingConversationCellRenderedIndexStat",
        description = "",
        lastUpdated = { 2026, 1, 30 },
        backendsList = {
            namedStatConfigurationAndFormat("chatLandingConversationCellRenderedIndexStat", function(_)
                return {}
            end)
        }
    }),
    ConversationClicked = Telemetry.new({
        name = "chatLandingConversationClicked",
        description = "",
        lastUpdated = { 2026, 1, 27 },
        backendsList = {
            namedCounterConfigurationAndFormat("AppChat.ChatLanding.Button.Conversation", function(tbl1)
                return {
                    isFiltered = tbl1.isFiltered,
                    hasUnreadMessages = tbl1.hasUnreadMessages,
                    selectedConversationModerationType = tbl1.selectedConversationModerationType,
                    selectedConversationUserPendingStatus = tbl1.selectedConversationUserPendingStatus,
                    osaAcknowledgementStatus = tbl1.osaAcknowledgementStatus
                }
            end),
            DefaultTelemetryEvents.eventIngestWithFormatFunction(function(tbl1)
                return {
                    isFiltered = tbl1.isFiltered,
                    conversationListCount = tbl1.conversationListCount,
                    selectedConversationId = tbl1.selectedConversationId,
                    selectedIndex = tbl1.selectedIndex,
                    hasUnreadMessages = tbl1.hasUnreadMessages,
                    selectedConversationModerationType = tbl1.selectedConversationModerationType,
                    selectedConversationUserPendingStatus = tbl1.selectedConversationUserPendingStatus,
                    participantUserIds = tbl1.participantUserIds,
                    osaAcknowledgementStatus = tbl1.osaAcknowledgementStatus,
                    osaImpressionId = tbl1.osaImpressionId
                }
            end)
        }
    }),
    ConversationClickedIndexStat = Telemetry.new({
        name = "chatLandingConversationClickedIndexStat",
        description = "",
        lastUpdated = { 2026, 1, 30 },
        backendsList = {
            namedStatConfigurationAndFormat("chatLandingConversationClickedIndexStat", function(_)
                return {}
            end)
        }
    }),
    SearchStarted = Telemetry.new({
        name = "chatLandingSearchStarted",
        description = "A search session opened on the chat landing list. Once per session, on both the client-filter and backend-search paths.",
        lastUpdated = { 2026, 9, 21 },
        backendsList = { namedCounterConfigurationNoEmittedInfo("AppChat.ChatLanding.Search.Started"), EVENT_INGEST_NO_EMITTED_INFO }
    }),
    SearchResultsRendered = Telemetry.new({
        name = "chatLandingSearchResultsRendered",
        description = "A search query settled. Once per query, with the result count and outcome, which the cell events cannot express when zero cells render.",
        lastUpdated = { 2026, 9, 21 },
        backendsList = {
            namedCounterConfigurationAndFormat("AppChat.ChatLanding.Search.ResultsRendered", function(tbl1)
                return {
                    searchResultType = tbl1.searchResultType
                }
            end),
            DefaultTelemetryEvents.eventIngestWithFormatFunction(function(tbl1)
                return {
                    searchResultCount = tbl1.searchResultCount,
                    searchResultType = tbl1.searchResultType,
                    searchLatencyMs = tbl1.searchLatencyMs
                }
            end)
        }
    }),
    ChatLandingGroupsBtnClicked = Telemetry.new({
        name = "chatLandingGroupsBtnClicked",
        description = "",
        lastUpdated = { 2025, 7, 31 },
        backendsList = { namedCounterConfigurationNoEmittedInfo("AppChat.ChatLanding.Button.Groups"), EVENT_INGEST_NO_EMITTED_INFO }
    }),
    ChatLandingPvUpsellRendered = Telemetry.new({
        name = "chatLandingPvUpsellRendered",
        description = "",
        lastUpdated = { 2025, 7, 31 },
        backendsList = { namedCounterConfigurationNoEmittedInfo("AppChat.ChatLanding.PvUpsell.Rendered"), EVENT_INGEST_NO_EMITTED_INFO }
    }),
    ChatLandingPvUpsellDismissed = Telemetry.new({
        name = "chatLandingPvUpsellDismissed",
        description = "",
        lastUpdated = { 2025, 7, 31 },
        backendsList = { namedCounterConfigurationNoEmittedInfo("AppChat.ChatLanding.PvUpsell.Dismissed"), EVENT_INGEST_NO_EMITTED_INFO }
    }),
    ChatLandingPvUpsellContinueClicked = Telemetry.new({
        name = "chatLandingPvUpsellContinueClicked",
        description = "",
        lastUpdated = { 2025, 7, 31 },
        backendsList = { namedCounterConfigurationNoEmittedInfo("AppChat.ChatLanding.PvUpsell.Button.Continue"), EVENT_INGEST_NO_EMITTED_INFO }
    }),
    ChatLandingPvUpsellSucceeded = Telemetry.new({
        name = "chatLandingPvUpsellSucceeded",
        description = "",
        lastUpdated = { 2025, 7, 31 },
        backendsList = { namedCounterConfigurationNoEmittedInfo("AppChat.ChatLanding.PvUpsell.Succeeded"), EVENT_INGEST_NO_EMITTED_INFO }
    }),
    ChatLandingPvUpsellFailed = Telemetry.new({
        name = "chatLandingPvUpsellFailed",
        description = "",
        lastUpdated = { 2025, 7, 31 },
        backendsList = { namedCounterConfigurationNoEmittedInfo("AppChat.ChatLanding.PvUpsell.Failed"), EVENT_INGEST_NO_EMITTED_INFO }
    }),
    ChatLandingUnfilteredThreadsFtuxRendered = Telemetry.new({
        name = "chatLandingUnfilteredThreadsFtuxRendered",
        description = "",
        lastUpdated = { 2025, 7, 31 },
        backendsList = { namedCounterConfigurationNoEmittedInfo("AppChat.ChatLanding.UnfilteredThreadsFtux.Rendered"), EVENT_INGEST_NO_EMITTED_INFO }
    }),
    ChatLandingUnfilteredThreadsFtuxDismissed = Telemetry.new({
        name = "chatLandingUnfilteredThreadsFtuxDismissed",
        description = "",
        lastUpdated = { 2025, 7, 31 },
        backendsList = { namedCounterConfigurationNoEmittedInfo("AppChat.ChatLanding.UnfilteredThreadsFtux.Dismissed"), EVENT_INGEST_NO_EMITTED_INFO }
    }),
    ChatLandingUnfilteredThreadsFtuxLearnMoreClicked = Telemetry.new({
        name = "chatLandingUnfilteredThreadsFtuxLearnMoreClicked",
        description = "",
        lastUpdated = { 2025, 7, 31 },
        backendsList = { namedCounterConfigurationNoEmittedInfo("AppChat.ChatLanding.UnfilteredThreadsFtux.Button.LearnMore"), EVENT_INGEST_NO_EMITTED_INFO }
    })
}
