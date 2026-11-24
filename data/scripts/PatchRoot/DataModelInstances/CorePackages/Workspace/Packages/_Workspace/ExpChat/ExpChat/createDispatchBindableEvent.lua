-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T08:10:40Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DispatchBindableEvent = require(script.Parent.DispatchBindableEvent)

local function createDispatchBindableEvent(arg1)
    DispatchBindableEvent.Event:Connect(function(arg2)
        arg1:dispatch(arg2)
    end)

    DispatchBindableEvent:SetAttribute("isConnected", true)
    return DispatchBindableEvent
end

return createDispatchBindableEvent
