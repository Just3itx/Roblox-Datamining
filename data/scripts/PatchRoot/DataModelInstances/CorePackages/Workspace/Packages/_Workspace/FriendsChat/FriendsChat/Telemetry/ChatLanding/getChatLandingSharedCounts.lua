-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T13:30:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FriendsChatParent = script:FindFirstAncestor("FriendsChat").Parent

local ConversationChannels = require(FriendsChatParent.AppChat.ConversationChannels)
local _GetConversationListStore = require(FriendsChatParent.AppChat.GetConversationListStore)
local isUserPending = require(FriendsChatParent.AppChat.isUserPending)

local function getChatLandingSharedCounts(tbl1)
    local tbl2 = tbl1 or {}
    local num1 = 0
    local num2 = 0

    for _, value in tbl2 do
        if isUserPending(value) then
            num1 += 1
        end
        if value.moderationType == ConversationChannels.ModerationType.TrustedComms then
            num2 += 1
        end
    end

    return {
        chatLandingListCount = #tbl2,
        pendingConversationCount = num1,
        unfilteredConversationCount = num2
    }
end

return getChatLandingSharedCounts
