-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T08:51:23Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local NavigateIntoChat = require(AppChat.Actions.NavigateIntoChat)
local NavigateToRoute = require(AppChatParent.NavigationRodux).Thunks.NavigateToRoute
local AppPage = require(AppChatParent.RobloxAppEnums).AppPage
local getFFlagEnableStandaloneAppChat = require(AppChat.Flags.getFFlagEnableStandaloneAppChat)
local EnumScreens = require(AppChat.EnumScreens)
local FFlagSignalsNavP3Dispatch = require(AppChatParent.SharedFlags).FFlagSignalsNavP3Dispatch
local NavigationCommands = if FFlagSignalsNavP3Dispatch then require(AppChatParent.RobloxAppNavigation).NavigationCommands else nil
local tbl1 = {{
    name = AppPage.Chat
}}

return function(params, bool1: boolean)
    return function(arg1)
        if FFlagSignalsNavP3Dispatch then
            NavigationCommands.to(NavigationCommands.fromLegacyPage(tbl1[#tbl1]), bool1)
        else
            arg1:dispatch(NavigateToRoute(tbl1, bool1))
        end
        local var1 = NavigateIntoChat
        local tbl2 = {
            screen = if getFFlagEnableStandaloneAppChat() then EnumScreens.ChatConversation else EnumScreens.RoactChat,
            params = params
        }
        arg1:dispatch(var1(tbl2))
    end
end
