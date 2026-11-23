-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T08:11:19Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local React = require(AppChatParent.React)

local ChatPlacementContext = require(AppChat.Contexts.ChatPlacementContext)
local useThemeBackground = require(AppChatParent.ThemeBackground).useThemeBackground
local FFlagAppThemeHalloween2026ChatBackground = require(AppChat.Flags.FFlagAppThemeHalloween2026ChatBackground)
local useChatPagePadding = require(AppChat.Contexts.ChatPagePadding.useChatPagePadding)

local function useCustomConversationListRowPresentation(tbl1)
    local var1 = useChatPagePadding()
    local var2 = ChatPlacementContext.useChatPlacementContext()
    local bool1 = if FFlagAppThemeHalloween2026ChatBackground then useThemeBackground() ~= nil else false
    local onActivated = tbl1.onActivated
    local var3 = React.useCallback(function()
        if onActivated ~= nil then
            onActivated()
        end
    end, { onActivated })

    return {
        entryHeight = tbl1.entryHeight or 64,
        pagePaddingLeft = var1.left,
        pagePaddingRight = var1.right,
        showBackground = not (ChatPlacementContext.isPlacementInExperience(var2.chatPlacement) or bool1),
        onActivated = var3
    }
end

return useCustomConversationListRowPresentation
