-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T08:40:44Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChatParent = script:FindFirstAncestor("AppChat").Parent

local Cryo = require(AppChatParent.Cryo)
local React = require(AppChatParent.React)

local Context = require(script.Parent.Context)

local function ChatPagePaddingProvider(tbl1)
    return React.createElement(
        Context.Provider,
        {
            value = Cryo.Dictionary.join({ top = 0, right = 12, bottom = 0, left = 12 }, tbl1.value)
        },
        tbl1.children
    )
end
return ChatPagePaddingProvider
