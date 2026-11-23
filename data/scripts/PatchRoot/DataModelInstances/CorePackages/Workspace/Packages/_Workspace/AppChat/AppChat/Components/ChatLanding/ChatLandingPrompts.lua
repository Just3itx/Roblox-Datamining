-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T08:01:23Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local _React = require(AppChatParent.React)
local useNavigationFocus = require(AppChatParent.Navigation).useNavigationFocus
local useChatIsVisible = require(AppChat.Hooks.useChatIsVisible)

local function ChatLandingPrompts(tbl1)
    local var1 = useNavigationFocus()
    local var2 = useChatIsVisible()

    if not (var1 and var2) then
        return nil
    end
    return tbl1.renderPrompts()
end

return ChatLandingPrompts
