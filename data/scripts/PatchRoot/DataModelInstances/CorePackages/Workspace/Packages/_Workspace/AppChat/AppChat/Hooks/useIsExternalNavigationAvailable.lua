-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T09:41:08Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local isPageAvailable = require(AppChat.Utils.isPageAvailable)

local useChatPlacementContext = require(AppChat.Contexts.ChatPlacementContext).useChatPlacementContext

local FFlagAppChatOnConsoles = require(AppChatParent.SharedFlags).FFlagAppChatOnConsoles
local useAppPolicy = require(AppChatParent.UniversalAppPolicy).useAppPolicy

return function(tbl1)
    local chatPlacement = useChatPlacementContext().chatPlacement

    local var1 = if FFlagAppChatOnConsoles then useAppPolicy(function(arg1)
        return arg1.getWebViewSupport()
    end) else nil

    local result = ({})

    for _, value in tbl1 do
        result[value] = isPageAvailable(value, chatPlacement, if FFlagAppChatOnConsoles then var1 else nil)
    end

    return result
end
