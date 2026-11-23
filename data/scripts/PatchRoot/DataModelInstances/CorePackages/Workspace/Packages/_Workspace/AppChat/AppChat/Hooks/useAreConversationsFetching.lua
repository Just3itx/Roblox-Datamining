-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T09:31:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local useSelector = require(AppChatParent.RoactUtils).Hooks.RoactRodux.useSelector
local RoduxNetworking = require(AppChat.Http.RoduxNetworking)
local AppChatNetworking = require(AppChatParent.AppChatNetworking)

return function()
    return useSelector(function(arg1): boolean
        return AppChatNetworking.rodux.GetUserConversations.getStatus(arg1, 1) == RoduxNetworking.Enum.NetworkStatus.Fetching
    end)
end
