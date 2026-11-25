-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T19:01:36Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent

local React = require(scriptParentParent.React)
local Message = require(script.Parent.Message)
local MessageWriterContext = require(script.Parent.MessageWriterContext)
local useInExperienceLocalization = require(scriptParentParent.ChatUIPrimitives).Hooks.useInExperienceLocalization
local FFlagExpChatMemoizeSystemMessage = require(script.Parent.Flags.FFlagExpChatMemoizeSystemMessage)

local function useRobloxSystemMessage()
    local var1 = MessageWriterContext.useMessageWriter()
    local var2 = useInExperienceLocalization()

    local displayRobloxSystemMessage = React.useCallback(function(str1: string, str2: string)
        if not var1 then
            return
        end
        local var3 = var2(str1)
        if var3 ~= "" then
            str2 = var3
        end

        if str2 == "" then
            return
        end
        var1.write(Message.createSystemMessage(str2, "Roblox.ChatDisabled.Info"))
    end, { var1, var2 })

    local clearAvailabilityMessage = React.useCallback(function()
        if var1 then
            var1.remove("Roblox.ChatDisabled.Info")
        end
    end, { var1 })

    local var5 = React.useMemo(function()
        return {
            displayRobloxSystemMessage = displayRobloxSystemMessage,
            clearAvailabilityMessage = clearAvailabilityMessage
        }
    end, { displayRobloxSystemMessage, clearAvailabilityMessage })

    return if FFlagExpChatMemoizeSystemMessage then var5 else {
        displayRobloxSystemMessage = displayRobloxSystemMessage,
        clearAvailabilityMessage = clearAvailabilityMessage
    }
end

return useRobloxSystemMessage
