-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T13:30:57Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FriendsChatParent = script:FindFirstAncestor("FriendsChat").Parent

local EmptyStateType = require(FriendsChatParent.AppChat.EmptyStateType)

local function getLandingEmptyStateType(tbl1, bool1: boolean)
    if bool1 then
        return nil
    end

    if tbl1.shouldShowBlockingError then
        return EmptyStateType.ConversationsLoadErrorView
    end

    if tbl1.shouldShowEmptyState then
        if tbl1.hasNoFriends then
            return EmptyStateType.NoFriendsView
        end

        return EmptyStateType.EmptyConversationList
    end

    return nil
end

return getLandingEmptyStateType
