-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T14:01:09Z
-- Luau bytecode version: 14 | Luau type version: 3
local RealtimeDeliveryParent = script:FindFirstAncestor("RealtimeDelivery").Parent
local React = require(RealtimeDeliveryParent.React)

local NotificationService = game:GetService("NotificationService")
local var1 = require(script.Parent.RobloxEventReceiver).new(NotificationService)

return React.createContext(var1)
