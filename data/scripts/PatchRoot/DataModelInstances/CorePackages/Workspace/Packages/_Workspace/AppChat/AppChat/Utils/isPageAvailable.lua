-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T10:41:07Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local EnumScreens = require(AppChat.EnumScreens)
local isPlacementInExperience = require(AppChat.Contexts.ChatPlacementContext).isPlacementInExperience
local FFlagAppChatOnConsoles = require(AppChatParent.SharedFlags).FFlagAppChatOnConsoles
local FFlagAppChatHidePrivacySettingsWithoutWebView = require(AppChat.Flags.FFlagAppChatHidePrivacySettingsWithoutWebView)

local tbl1 = {
    [EnumScreens.AddFriends] = true,
    [EnumScreens.PrivacySettings] = true,
    [EnumScreens.GameDetail] = true,
    [EnumScreens.ViewUserProfile] = true,
    [EnumScreens.Groups] = true
}

local tbl2 = {
    [EnumScreens.Groups] = true,
    [EnumScreens.PrivacySettings] = FFlagAppChatHidePrivacySettingsWithoutWebView
}

return function(str1: string, arg1, bool1: boolean?): boolean
    return not (isPlacementInExperience(arg1) and tbl1[str1])
        and (not FFlagAppChatOnConsoles or bool1 ~= false or not tbl2[str1] or false)
end
