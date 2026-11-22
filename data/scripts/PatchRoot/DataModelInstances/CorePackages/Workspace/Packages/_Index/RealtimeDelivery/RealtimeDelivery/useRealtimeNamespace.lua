-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T14:01:23Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RealtimeDelivery = script:FindFirstAncestor("RealtimeDelivery")
local RealtimeDeliveryParent = RealtimeDelivery.Parent
local List = require(RealtimeDeliveryParent.Cryo).List
local React = require(RealtimeDeliveryParent.React)
local _RealtimeTypes = require(RealtimeDelivery.RealtimeTypes)

local useRobloxEventReceiver = require(script.Parent.useRobloxEventReceiver)

local function useRealtimeNamespace(str1: string, func1: (...any) -> (...any), tbl1)
    local var1 = useRobloxEventReceiver()

    React.useEffect(function()
        local var2 = var1:observeEvent(str1, func1)

        return function()
            var2:disconnect()
        end
    end, List.join({ str1, var1 }, tbl1))
end

return useRealtimeNamespace
