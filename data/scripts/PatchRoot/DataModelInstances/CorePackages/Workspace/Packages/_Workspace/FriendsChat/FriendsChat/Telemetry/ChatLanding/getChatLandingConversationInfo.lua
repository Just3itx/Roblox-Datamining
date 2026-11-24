-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T13:30:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FriendsChatParent = script:FindFirstAncestor("FriendsChat").Parent

local _GetConversationListStore = require(FriendsChatParent.AppChat.GetConversationListStore)

local serializeParticipantIdsForTelemetry = require(script.Parent.Parent.App.serializeParticipantIdsForTelemetry)

local function indexOfConversation(tbl1, id: string) -- Luacid: Inlined by compiler; 1 call site recovered
    for value, value2 in tbl1 do
        if value2.id == id then
            return value
        end
    end
    return 0
end

local function getChatLandingConversationInfo(arg1, tbl1, isFiltered: boolean)
    return {
        isFiltered = isFiltered,
        conversationListCount = #tbl1,
        selectedConversationId = arg1.id,
        selectedIndex = indexOfConversation(tbl1, arg1.id),
        hasUnreadMessages = arg1.hasUnreadMessages,
        selectedConversationModerationType = arg1.moderationType,
        selectedConversationUserPendingStatus = arg1.userPendingStatus,
        participantUserIds = serializeParticipantIdsForTelemetry(arg1.participants),
        osaAcknowledgementStatus = arg1.osaAcknowledgementStatus
    }
end

return getChatLandingConversationInfo
