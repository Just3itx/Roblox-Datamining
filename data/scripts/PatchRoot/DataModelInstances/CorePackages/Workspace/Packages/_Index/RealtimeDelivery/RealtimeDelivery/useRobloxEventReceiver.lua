-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T14:01:25Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RealtimeDeliveryParent = script:FindFirstAncestor("RealtimeDelivery").Parent
local React = require(RealtimeDeliveryParent.React)

local RealtimeContext = require(script.Parent.RealtimeContext)

local function useRobloxEventReceiver()
    return React.useContext(RealtimeContext)
end

return useRobloxEventReceiver
