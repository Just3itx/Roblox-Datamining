-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T08:21:08Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local React = require(AppChatParent.React)

local GetExternalChatMessageSenderStore = require(AppChat.Stores.GetExternalChatMessageSenderStore)
local useExternalChatMessageSender = require(AppChat.Hooks.useExternalChatMessageSender)

local function ExternalChatMessageSenderRegistration(tbl1)
    local var1 = useExternalChatMessageSender(tbl1.isInExperience == true)
    local externalChatMessageSenderStore = GetExternalChatMessageSenderStore()

    React.useEffect(function()
        externalChatMessageSenderStore.setSender(var1)
    end, { var1, externalChatMessageSenderStore })

    React.useEffect(function()
        return externalChatMessageSenderStore.clearSender
    end, { externalChatMessageSenderStore })

    return nil
end

return ExternalChatMessageSenderRegistration
