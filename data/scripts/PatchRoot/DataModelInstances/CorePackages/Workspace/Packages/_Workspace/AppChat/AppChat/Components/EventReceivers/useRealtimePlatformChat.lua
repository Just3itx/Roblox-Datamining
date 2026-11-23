-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T08:21:19Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChatParent = script:FindFirstAncestor("AppChat").Parent
local RealtimeDelivery = require(AppChatParent.RealtimeDelivery)

local _CommunicationChannelsTypes = require(script.Parent.CommunicationChannelsTypes)

local function useRealtimePlatformChat(callback: (...any) -> (...any), tbl1)
    RealtimeDelivery.useRealtimeNamespace("CommunicationChannels", function(arg1)
        if arg1.ChannelVertical == "PlatformChat" then
            callback(arg1)
        end
    end, tbl1)
end

return useRealtimePlatformChat
