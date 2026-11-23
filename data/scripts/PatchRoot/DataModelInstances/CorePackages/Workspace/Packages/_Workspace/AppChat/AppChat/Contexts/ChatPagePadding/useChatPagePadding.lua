-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T08:40:45Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChatParent = script:FindFirstAncestor("AppChat").Parent

local React = require(AppChatParent.React)
local Context = require(script.Parent.Context)

local function useChatPagePadding()
    return React.useContext(Context)
end

return useChatPagePadding
