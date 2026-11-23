-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T09:40:53Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local useSelector = require(AppChatParent.RoactUtils).Hooks.RoactRodux.useSelector
local getDeepValue = require(AppChat.Utils.getDeepValue)

return function(str1: string)
    return useSelector(function(arg1)
        return getDeepValue(arg1, `ChatAppReducer.Conversations.{str1}.hasGroupUp`)
    end)
end
