-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T14:01:26Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RealtimeDelivery = script:FindFirstAncestor("RealtimeDelivery")
local React = require(RealtimeDelivery.Parent.React)

local _TopicEventReceiver = require(script.Parent.TopicEventReceiver)
local TopicRealtimeContext = require(script.Parent.TopicRealtimeContext)

local function useTopicNotification(str1: string?, current: (...any) -> (...any), arg1)
    local var1 = React.useContext(TopicRealtimeContext)
    local var2 = React.useRef(current)
    local onError = if arg1 then arg1.onError else nil
    local var3 = React.useRef(onError)
    local var4 = React.useRef(nil)

    React.useEffect(function()
        var2.current = current
    end, { current })

    React.useEffect(function()
        var3.current = onError
    end, { onError or false })

    React.useEffect(function()
        local current = var4.current
        local var5 = var4

        var5.current = if str1 then var1:observeTopic(str1, function(arg2)
            var2.current(arg2)
        end, {
            onError = function(arg2)
                local current2 = var3.current
                if current2 then
                    current2(arg2)
                end
            end
        }) else nil

        if current then
            current:disconnect()
        end
    end, { str1 or false, var1 })

    React.useEffect(function()
        return function()
            local current = var4.current
            var4.current = nil
            if current then
                current:disconnect()
            end
        end
    end, {})
end

return useTopicNotification
