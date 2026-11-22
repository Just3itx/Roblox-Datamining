-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T14:01:19Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RealtimeDeliveryParent = script:FindFirstAncestor("RealtimeDelivery").Parent
local React = require(RealtimeDeliveryParent.React)

local useRobloxEventReceiver = require(script.Parent.useRobloxEventReceiver)

local function useRealtimeConnectionState()
    local var1 = useRobloxEventReceiver()
    local var2, var3 = React.useState(Enum.ConnectionState.Connected)

    React.useEffect(function()
        local var4 = var1:observeEvent("signalR", function(arg1)
            var3(arg1)
        end)

        return function()
            var4:disconnect()
        end
    end, { var1 })

    return var2
end

return useRealtimeConnectionState
