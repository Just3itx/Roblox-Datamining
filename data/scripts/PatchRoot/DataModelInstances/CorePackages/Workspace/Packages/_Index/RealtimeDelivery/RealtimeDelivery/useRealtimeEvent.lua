-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T14:01:21Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RealtimeDelivery = script:FindFirstAncestor("RealtimeDelivery")
local _RealtimeTypes = require(RealtimeDelivery.RealtimeTypes)

local useRealtimeNamespace = require(script.Parent.useRealtimeNamespace)

local function useRealtimeEvent(str1: string, type: string, callback: (...any) -> (...any), tbl1)
    useRealtimeNamespace(str1, function(arg1)
        if arg1.Type == type then
            callback(arg1)
        end
    end, tbl1)
end

return useRealtimeEvent
