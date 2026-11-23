-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T07:01:30Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local NotificationService = game:GetService("NotificationService")

local AppChatParent = script:FindFirstAncestor("AppChat").Parent

local RobloxEventReceiver = require(AppChatParent.RealtimeDelivery).RobloxEventReceiver

local createHttpPort = require(script.createHttpPort)
local createRealtimePort = require(script.createRealtimePort)

return {
    current = {
        http = createHttpPort(nil),
        realtime = createRealtimePort(function()
            return RobloxEventReceiver.new(NotificationService)
        end)
    }
}
