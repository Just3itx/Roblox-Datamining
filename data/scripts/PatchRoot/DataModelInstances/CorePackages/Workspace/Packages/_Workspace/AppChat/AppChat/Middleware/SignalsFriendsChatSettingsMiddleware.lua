-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T10:01:07Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local AppChatNetworking = require(AppChatParent.AppChatNetworking)
local FFlagAppChatUseSignalsForChatSettings = require(AppChat.Flags.FFlagAppChatUseSignalsForChatSettings)

local ThirdPartyChatSettingsLoaded = require(AppChat.Actions.ThirdPartyChatSettingsLoaded)
local GetFriendsChatMetadataStore = require(AppChat.Stores.GetFriendsChatMetadataStore)
local GetFriendsChatSettingsStore = require(AppChat.Stores.GetFriendsChatSettingsStore)

local tbl1 = {}

tbl1[AppChatNetworking.rodux.GetMetadata.Succeeded.name] = function(arg1) -- name: handleGetMetadataSucceeded
    GetFriendsChatMetadataStore(false).updateFriendsChatMetadata(arg1.responseBody)
end

tbl1[ThirdPartyChatSettingsLoaded.name] = function(arg1) -- name: handleThirdPartyChatSettingsLoaded
    GetFriendsChatSettingsStore(false).setThirdPartyChatRestrictionStatus(arg1.status)
end

local function SignalsFriendsChatSettingsMiddleware(func1: (...any) -> (...any), _)
    return function(arg1)
        local var1 = func1(arg1)

        if FFlagAppChatUseSignalsForChatSettings then
            return var1
        end

        local var2 = tbl1[arg1.type]
        if var2 then
            var2(arg1)
        end

        return var1
    end
end

return SignalsFriendsChatSettingsMiddleware
