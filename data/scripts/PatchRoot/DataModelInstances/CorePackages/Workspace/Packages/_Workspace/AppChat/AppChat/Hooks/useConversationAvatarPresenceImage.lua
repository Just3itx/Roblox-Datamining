-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T09:40:38Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local useGetPresenceByUserId = require(AppChatParent.FriendsCommon).Hooks.useGetPresenceByUserId
local userPresenceUtils = require(AppChat.Users.userPresenceUtils)

local function useConversationAvatarPresenceImage(str1: string?)
    local var1 = useGetPresenceByUserId(str1)
    return userPresenceUtils.getUserDisplayPresence(var1).image
end

return useConversationAvatarPresenceImage
