-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T09:41:26Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local React = require(AppChatParent.React)
local DateTime = require(AppChatParent.Time).DateTime
local getConversationTimestamp = require(AppChat.Utils.getConversationTimestamp)

local function computeTimestamp(num1: number?)
    if num1 == nil then
        return ""
    end
    return getConversationTimestamp(DateTime.fromUnixTimestamp(num1))
end

local function useRelativeTimestampBinding(num1: number?)
    local var1, var2 = React.useBinding(computeTimestamp(num1))

    React.useEffect(function()
        var2(computeTimestamp(num1))

        if num1 == nil then
            return function() end
        end

        local bool1 = false

        local function scheduleUpdate() -- Luacid: Inlined by compiler; 1 call site recovered
            task.delay(30, function()
                if bool1 then
                    return
                end
                var2(computeTimestamp(num1))
                scheduleUpdate()
            end)
        end

        scheduleUpdate()

        return function()
            bool1 = true
        end
    end, { num1 })

    return var1
end

return useRelativeTimestampBinding
