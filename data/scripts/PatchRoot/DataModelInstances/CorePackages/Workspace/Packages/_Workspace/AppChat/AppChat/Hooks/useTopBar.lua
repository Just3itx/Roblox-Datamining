-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T09:50:37Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local React = require(AppChatParent.React)
local GetTopBarStore = require(AppChat.Stores.GetTopBarStore)

local function useTopBar(str1: string)
    local topBarStore = GetTopBarStore(false)

    return {
        setScreenTopBar = React.useCallback(function(arg1)
            topBarStore.setScreenTopBar(str1, arg1)
        end, { str1 }),
        clearScreenTopBar = React.useCallback(function()
            topBarStore.clearScreenTopBar(str1)
        end, { str1 })
    }
end

return useTopBar
