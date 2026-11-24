-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T13:11:21Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FriendsChat = script:FindFirstAncestor("FriendsChat")
local GetFriendsChatNavigationStore = require(FriendsChat.Stores.GetFriendsChatNavigationStore)

local FFlagFriendsChatConversationListFocusNav = require(FriendsChat.Parent.SharedFlags).FFlagFriendsChatConversationListFocusNav

local function getActiveConversationId(arg1) -- Luacid: Inlined by compiler; 2 call sites recovered
    if FFlagFriendsChatConversationListFocusNav then
        return arg1.getEffectiveConversationId(false)
    end
    return arg1.getSelectedConversationId(false)
end

return {
    canFocus = function(): boolean
        return if FFlagFriendsChatConversationListFocusNav then true else getActiveConversationId((GetFriendsChatNavigationStore(false))) ~= nil
    end,
    focus = function(_)
        local friendsChatNavigationStore = GetFriendsChatNavigationStore(false)
        if FFlagFriendsChatConversationListFocusNav then
            if getActiveConversationId(friendsChatNavigationStore) ~= nil then
                friendsChatNavigationStore.requestFocusInputBar()
            else
                friendsChatNavigationStore.requestFocusConversationList()
            end
            return nil
        end

        if friendsChatNavigationStore.getSelectedConversationId(false) == nil then
            return Enum.ContextActionResult.Pass
        end
        if friendsChatNavigationStore.getIsInputBarFocused(false) then
            return Enum.ContextActionResult.Pass
        end
        friendsChatNavigationStore.requestFocusInputBar()
        return Enum.ContextActionResult.Sink
    end
}
