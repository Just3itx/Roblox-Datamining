-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T09:41:00Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local useSelector = require(AppChatParent.RoactUtils).Hooks.RoactRodux.useSelector
local getDeepValue = require(AppChat.Utils.getDeepValue)
local Cryo = require(AppChatParent.Cryo)

return function()
    return useSelector(function(arg1): boolean
        return not Cryo.isEmpty(getDeepValue(arg1, "ChatAppReducer.Conversations") or {})
    end)
end
