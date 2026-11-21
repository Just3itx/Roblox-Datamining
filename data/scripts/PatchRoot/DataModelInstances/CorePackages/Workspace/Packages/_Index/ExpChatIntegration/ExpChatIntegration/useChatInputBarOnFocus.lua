-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T12:51:21Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ExpChatIntegrationParent = script:FindFirstAncestor("ExpChatIntegration").Parent

local React = require(ExpChatIntegrationParent.React)

local useChatPlatform = require(script.Parent.useChatPlatform)

local function useChatInputBarOnFocus()
    local getTransparencyStore = useChatPlatform().getTransparencyStore

    return {
        onFocusGained = React.useCallback(function()
            getTransparencyStore(false).setTextboxFocus()
        end, { getTransparencyStore }),
        onFocusLost = React.useCallback(function()
            getTransparencyStore(false).clearTextboxFocus()
        end, { getTransparencyStore })
    }
end

return useChatInputBarOnFocus
