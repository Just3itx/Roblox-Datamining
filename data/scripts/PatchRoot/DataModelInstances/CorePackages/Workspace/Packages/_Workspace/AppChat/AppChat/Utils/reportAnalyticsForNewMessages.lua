-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T10:41:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Players = game:GetService("Players")
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local Analytics = require(AppChatParent.Analytics).Analytics
local RbxAnalyticsService = game:GetService("RbxAnalyticsService")

local RoactChatAnalytics = require(AppChat.LegacyAnalytics.RoactChatAnalytics)
local filterForLinksWithPolicy = require(AppChat.Components.ChatConversation.Utils.filterForLinksWithPolicy)
local EnumMessageTypes = require(AppChat.Components.ChatConversation.EnumMessageTypes)

return function(arg1, arg2, arg3)
    if not arg3 then
        local analytics = Analytics.new(RbxAnalyticsService)
        local str1 = tostring(Players.LocalPlayer.UserId)
        arg3 = RoactChatAnalytics.new(analytics, str1)
    end

    if arg1.messageType ~= EnumMessageTypes.PlainText then
        if arg1.messageType == EnumMessageTypes.Link then
            arg3:loadGameLinkCardInChat(arg2, arg1.gameLink.universeId)
        end
        return
    end

    for _, value in pairs(filterForLinksWithPolicy(arg1)) do
        if value.messageType == EnumMessageTypes.Link then
            arg3:loadGameLinkCardInChat(arg2, value.placeId)
        end
    end
end
