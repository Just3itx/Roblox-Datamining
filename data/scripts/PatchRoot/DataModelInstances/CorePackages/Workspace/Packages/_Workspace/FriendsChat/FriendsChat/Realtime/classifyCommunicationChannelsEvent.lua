-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T13:21:04Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FriendsChatParent = script:FindFirstAncestor("FriendsChat").Parent

local CommunicationChannelsTypes = require(FriendsChatParent.AppChat.CommunicationChannelsTypes)

local tbl1 = { kind = "ignore", channelId = nil }

local tbl2 = {
    MessageCreated = "fetchMessage",
    SystemMessageCreated = "fetchMessage",
    ChannelDeleted = "removeConversation",
    RemovedFromChannel = "removeConversation",
    ChannelArchived = "removeConversation",
    ChannelUpdated = "fetchConversationDetails",
    ParticipantsAdded = "fetchConversationDetails",
    ParticipantsRemoved = "fetchConversationDetails",
    ChannelMetadataUpdated = "fetchConversationDetails",
    AddedToChannel = "fetchConversationDetails",
    ChannelCreated = "fetchConversationDetails",
    ChannelUnarchived = "fetchConversationDetails",
    ChannelMarkedRead = "fetchConversationDetails"
}

local function classifyCommunicationChannelsEvent(arg1)
    if arg1 == nil then
        return tbl1
    end

    if arg1.ChannelVertical ~= "PlatformChat" then
        return tbl1
    end

    if table.find(CommunicationChannelsTypes.ChannelTypeAllowlist, arg1.ChannelType) == nil then
        return tbl1
    end

    local kind = tbl2[arg1.Type]
    if kind == nil then
        return tbl1
    end

    local channelId = arg1.ChannelId
    return if channelId == nil or channelId == "" then tbl1 else {
        kind = kind,
        channelId = channelId
    }
end

return classifyCommunicationChannelsEvent
