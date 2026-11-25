-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T19:01:31Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent

local React = require(scriptParentParent.React)
local useRobloxSystemMessage = require(script.Parent.useRobloxSystemMessage)
local _ChatAvailabilityContext = require(script.Parent.ChatAvailabilityContext)
local FFlagExpChatMemoizeSystemMessage = require(script.Parent.Flags.FFlagExpChatMemoizeSystemMessage)

local function useAvailabilitySystemMessage(arg1, arg2)
    local var1 = useRobloxSystemMessage()

    React.useEffect(function()
        if arg1.messageKey then
            var1.displayRobloxSystemMessage(arg1.messageKey, arg1.messageFallback or "")
        end
        return var1.clearAvailabilityMessage
    end, FFlagExpChatMemoizeSystemMessage and {
        var1,
        arg1.messageKey,
        arg1.messageFallback,
        arg2
    }
        or { var1, arg1.messageKey, arg1.messageFallback })
end

return useAvailabilitySystemMessage
