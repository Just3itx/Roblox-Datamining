-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T10:31:12Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local Cryo = require(AppChatParent.Cryo)
local getStandardSizeAvatarHeadShotRbxthumb = require(AppChatParent.UserLib).Utils.getStandardSizeAvatarHeadShotRbxthumb
local FFlagAppChatUseProfileFrameThumbnail = require(AppChat.Flags.FFlagAppChatUseProfileFrameThumbnail)

return function(arg1)
    return Cryo.List.map(arg1, function(arg2)
        return getStandardSizeAvatarHeadShotRbxthumb(tostring(arg2), FFlagAppChatUseProfileFrameThumbnail)
    end)
end
