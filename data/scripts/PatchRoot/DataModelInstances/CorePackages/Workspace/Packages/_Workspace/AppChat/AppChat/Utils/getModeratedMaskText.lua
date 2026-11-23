-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T10:40:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChatParent = script:FindFirstAncestor("AppChat").Parent

local SharedFlags = require(AppChatParent.SharedFlags)
local FIntFriendsChatModeratedMaskMinLength = SharedFlags.FIntFriendsChatModeratedMaskMinLength
local FIntFriendsChatModeratedMaskMaxLength = SharedFlags.FIntFriendsChatModeratedMaskMaxLength

local function getModeratedMaskText(str1: string)
    local var1 = FIntFriendsChatModeratedMaskMaxLength - FIntFriendsChatModeratedMaskMinLength + 1

    return string.rep("#", FIntFriendsChatModeratedMaskMinLength + string.byte(str1, #str1) % var1)
end

return getModeratedMaskText
