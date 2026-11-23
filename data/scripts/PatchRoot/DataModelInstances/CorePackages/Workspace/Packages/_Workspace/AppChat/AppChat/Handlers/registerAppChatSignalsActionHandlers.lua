-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T09:31:11Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local ActionHandlers = require(AppChatParent.SignalsMiddleware).ActionHandlers

local FFlagAppChatUseSignalsForLastEntryPoint = require(AppChat.Flags.FFlagAppChatUseSignalsForLastEntryPoint)

local FFlagAppChatUseSignalsForExternalNavigationRequest = require(AppChat.Flags.FFlagAppChatUseSignalsForExternalNavigationRequest)
local FFlagAppChatUseSignalsForChatSettings = require(AppChat.Flags.FFlagAppChatUseSignalsForChatSettings)

return function(arg1)
    if FFlagAppChatUseSignalsForLastEntryPoint then
        ActionHandlers.register(arg1, "EnteredChatFromEntryPoint", function(arg2): boolean
            require(AppChat.Stores.GetLastEntryPointStore)(false).enteredChatFromEntryPoint(arg2.entryPoint)
            return false
        end)
    end

    if FFlagAppChatUseSignalsForExternalNavigationRequest then
        ActionHandlers.register(arg1, "NavigateIntoChat", function(arg2): boolean
            require(AppChat.Stores.GetExternalNavigationRequestStore)(false).navigateIntoChat(arg2.screen, arg2.params)
            return false
        end)
    end

    if not FFlagAppChatUseSignalsForChatSettings then
        return
    end

    ActionHandlers.register(arg1, "GetMetadata_Succeeded", function(arg2): boolean
        local getFriendsChatMetadataStore = require(AppChat.Stores.GetFriendsChatMetadataStore)
        local getFriendsChatSettingsStore = require(AppChat.Stores.GetFriendsChatSettingsStore)
        getFriendsChatMetadataStore(false).updateFriendsChatMetadata(arg2.responseBody)
        getFriendsChatSettingsStore(false).clearDebugGroupChatToggle()
        return false
    end)
    ActionHandlers.register(arg1, "ThirdPartyChatSettingsLoaded", function(arg2): boolean
        require(AppChat.Stores.GetFriendsChatSettingsStore)(false).setThirdPartyChatRestrictionStatus(arg2.status)
        return false
    end)
    ActionHandlers.register(arg1, "Debug_GroupChatEnabledToggled", function(_): boolean
        require(AppChat.Stores.GetFriendsChatSettingsStore)(false).toggleDebugGroupChatEnabled()
        return false
    end)
end
