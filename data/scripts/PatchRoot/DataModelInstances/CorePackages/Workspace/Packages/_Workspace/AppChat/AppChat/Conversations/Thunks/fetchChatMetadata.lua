-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T08:51:14Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent
local SetAppLoaded = require(AppChat.Actions.SetAppLoaded)
local GetAppLoadedStore = require(AppChat.Stores.GetAppLoadedStore)
local FFlagAppChatUseSignalsForAppLoaded = require(AppChat.Flags.FFlagAppChatUseSignalsForAppLoaded)
local RoactChatAnalytics = require(AppChat.LegacyAnalytics.RoactChatAnalytics)
local var1 = require(AppChat.Logger):new(script.Name)

local RbxAnalyticsService = game:GetService("RbxAnalyticsService")
local var2 = require(AppChatParent.Analytics).Analytics.new(RbxAnalyticsService)

local AppChatNetworking = require(AppChatParent.AppChatNetworking)

return function()
    var1:info("Fetching chat metadata...")

    return function(arg1)
        local localUserId = arg1:getState().LocalUserId

        return arg1:dispatch(AppChatNetworking.rodux.GetMetadata.API()):andThen(function(arg2)
            local isChatEnabled = arg2.responseBody.isChatEnabled

            if isChatEnabled then
                var1:info("Chat is enabled and privacy settings allow chat")

                if localUserId then
                    RoactChatAnalytics.new(var2, localUserId):userLoadedChat()
                end
            else
                var1:info("Chat is disabled or privacy settings do not allow chat")
            end

            if FFlagAppChatUseSignalsForAppLoaded then
                GetAppLoadedStore(false).setAppLoaded(isChatEnabled)
            else
                arg1:dispatch(SetAppLoaded(isChatEnabled))
            end
            return isChatEnabled
        end):catch(function(arg2)
            var1:warning("FetchChatData failed with error: {}", tostring(arg2))
        end)
    end
end
