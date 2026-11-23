-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T08:11:12Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local React = require(AppChatParent.React)
local Signals = require(AppChatParent.Signals)
local SignalsReact = require(AppChatParent.SignalsReact)
local DateTime = require(AppChatParent.Time).DateTime
local getConversationTimestamp = require(AppChat.Utils.getConversationTimestamp)

local function computeTimestamp(num1: number?)
    if num1 == nil then
        return ""
    end
    return getConversationTimestamp(DateTime.fromUnixTimestamp(num1))
end

local function useRelativeTimestampSignalBinding(arg1, func1: (...any) -> (...any))
    local var1 = React.useState(function()
        local signal, setSignal = Signals.createSignal(0)
        return { signal = signal, setSignal = setSignal }
    end)

    React.useEffect(function()
        local bool1 = false
        local num1 = 0

        local function scheduleUpdate() -- Luacid: Inlined by compiler; 1 call site recovered
            task.delay(30, function()
                if bool1 then
                    return
                end
                num1 += 1
                var1.setSignal(num1)
                scheduleUpdate()
            end)
        end

        scheduleUpdate()

        return function()
            bool1 = true
        end
    end, { var1 })

    local var2 = React.useCallback(function(arg2, arg3)
        var1.signal(arg3)
        return computeTimestamp(func1(arg2, arg3))
    end, { var1, func1 })

    return SignalsReact.useSignalBinding(function(arg2)
        return var2(arg1(arg2), arg2)
    end)
end

return useRelativeTimestampSignalBinding
