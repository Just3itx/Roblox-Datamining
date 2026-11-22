-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T14:01:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RealtimeDelivery = script:FindFirstAncestor("RealtimeDelivery")
local RealtimeDeliveryParent = RealtimeDelivery.Parent
local List = require(RealtimeDeliveryParent.Cryo).List
local React = require(RealtimeDeliveryParent.React)
local _RealtimeTypes = require(RealtimeDelivery.RealtimeTypes)

local useRobloxEventReceiver = require(script.Parent.useRobloxEventReceiver)
local useRealtimeNamespace = require(script.Parent.useRealtimeNamespace)

local function useRealtimeConnectionStateChanged(str1: string, callback: (...any) -> (...any), tbl1)
    local var1 = useRobloxEventReceiver()
    local var2 = React.useRef(nil)

    useRealtimeNamespace(str1, function(arg1)
        local sequenceNumber = arg1.SequenceNumber
        if sequenceNumber and (var2.current == nil or var2.current < sequenceNumber) then
            var2.current = sequenceNumber
        end
    end, List.join({ str1 }, tbl1))

    React.useEffect(function()
        local var3 = var1:observeEvent("signalR", function(arg1, _, arg2)
            local current = arg2[str1]
            local bool1 = not (current == nil) and (var2.current == nil or var2.current ~= current)

            if current then
                var2.current = current
            end

            callback(arg1, bool1)
        end)

        return function()
            var3:disconnect()
        end
    end, List.join({ var1, var2.current }, tbl1))
end

return useRealtimeConnectionStateChanged
