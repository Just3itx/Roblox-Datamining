-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T13:21:25Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FriendsChat = script:FindFirstAncestor("FriendsChat")
local FriendsChatParent = FriendsChat.Parent

local React = require(FriendsChatParent.React)

local AppTelemetryLayer = require(FriendsChatParent.AppChat.AppTelemetryLayer)
local GetConversationListStore = require(FriendsChatParent.AppChat.GetConversationListStore)
local GetFriendsChatSettingsStore = require(FriendsChatParent.AppChat.GetFriendsChatSettingsStore)
local useTelemetry = require(FriendsChatParent.AppChat.useTelemetry)

local FFlagAppChatVisibleIsInConversation = require(FriendsChatParent.AppChat.FFlagAppChatVisibleIsInConversation)
local FFlagFriendsChatLandingTelemetryFields = require(FriendsChat.Flags.FFlagFriendsChatLandingTelemetryFields)
local GetFriendsChatNavigationStore = require(FriendsChat.Stores.GetFriendsChatNavigationStore)
local isInboxInitialLoading = require(FriendsChat.ConversationList.isInboxInitialLoading)

local AppLevelTelemetryEvents = require(script.Parent.AppLevelTelemetryEvents)

local function getIsChatEnabled() -- Luacid: Inlined by compiler; 1 call site recovered
    return GetFriendsChatSettingsStore(false).getChatEnabled(false)
end

local function getEmittedInfo()
    local tbl1 = {
        isChatEnabled = getIsChatEnabled()
    }
    if FFlagFriendsChatLandingTelemetryFields then
        local bool1 = GetFriendsChatNavigationStore(false).getEffectiveConversationId(false) == nil
        local conversationListStore = GetConversationListStore(false)
        local listStatus = conversationListStore.getListStatus(false)
        local num1 = #conversationListStore.getConversations(false)
        tbl1.isChatLoading = bool1 and isInboxInitialLoading(listStatus.isFetchingConversations == true, num1)
    end
    if FFlagAppChatVisibleIsInConversation then
        tbl1.isInConversation = GetFriendsChatNavigationStore(false).getEffectiveConversationId(false) ~= nil
    end
    return tbl1
end

local function useFriendsChatVisibilityTelemetry()
    local emit = useTelemetry(AppTelemetryLayer.Context).emit

    React.useEffect(function()
        emit(AppLevelTelemetryEvents.AppChatVisible, (getEmittedInfo()))
        return function()
            emit(AppLevelTelemetryEvents.AppChatClosed, (getEmittedInfo()))
        end
    end, {})
end

return useFriendsChatVisibilityTelemetry
