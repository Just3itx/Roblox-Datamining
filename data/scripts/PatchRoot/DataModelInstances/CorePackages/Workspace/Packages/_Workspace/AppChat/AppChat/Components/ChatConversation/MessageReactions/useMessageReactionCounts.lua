-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T07:30:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local React = require(AppChatParent.React)
local SignalsReact = require(AppChatParent.SignalsReact)

local GetMessageReactionsViewModelStore = require(AppChat.Stores.GetMessageReactionsViewModelStore)

local function useMessageReactionCounts(str1: string)
    local var1 = React.useMemo(function()
        return GetMessageReactionsViewModelStore(false).getReactionCounts(str1)
    end, { str1 })
    SignalsReact.useSignalState(var1)

    return var1(false)
end

return useMessageReactionCounts
