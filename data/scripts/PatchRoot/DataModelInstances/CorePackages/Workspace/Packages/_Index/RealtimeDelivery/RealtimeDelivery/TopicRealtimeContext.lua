-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T14:01:16Z
-- Luau bytecode version: 14 | Luau type version: 3
local RealtimeDelivery = script:FindFirstAncestor("RealtimeDelivery")
local React = require(RealtimeDelivery.Parent.React)

local NotificationService = game:GetService("NotificationService")
local var1 = require(script.Parent.TopicEventReceiver).new(NotificationService)

return React.createContext(var1)
