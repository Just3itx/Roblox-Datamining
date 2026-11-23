-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T10:11:15Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local Signals = require(AppChatParent.Signals)

local _useExternalChatMessageSender = require(AppChat.Hooks.useExternalChatMessageSender)

return Signals.createComputed(function()
    local getSender, var2 = Signals.createSignal(nil)
    return {
        getSender = getSender,
        setSender = function(arg1) -- name: setExternalChatMessageSender
            var2(arg1)
        end,
        clearSender = function()
            var2(nil)
        end
    }
end)
