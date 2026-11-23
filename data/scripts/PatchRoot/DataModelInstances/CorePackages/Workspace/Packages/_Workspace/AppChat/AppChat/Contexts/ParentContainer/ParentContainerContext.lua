-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T08:40:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local Promise = require(AppChatParent.Promise)
local React = require(AppChatParent.React)
local SocialCommon = require(AppChatParent.SocialCommon)
local _InExperienceAppChatModal = require(AppChat.App.InExperienceAppChatModal)

return React.createContext({
    getParentContainer = function()
        return nil
    end,
    visibilitySignal = Instance.new("BindableEvent"),
    getRequestedRoute = function()
        return nil
    end,
    requestedRouteSignal = Instance.new("BindableEvent"),
    clearRequestedRoute = function() end,
    getShouldSetAppChatVisible = function(): boolean
        return false
    end,
    entryPoint = SocialCommon.Enums.ChatEntryPointNames.Unknown,
    showParentContainer = function() end,
    hideParentContainer = function() end,
    updateCurrentSquadId = function() end,
    openFriendsChatConversation = function(_: string)
        return Promise.resolve(false)
    end
})
