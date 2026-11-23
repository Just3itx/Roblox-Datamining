-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T07:30:49Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChatParent = script:FindFirstAncestor("AppChat").Parent
local React = require(AppChatParent.React)

local ReplyingToMessageContext = require(script.Parent.ReplyingToMessageContext)
local ReplyingToMessageDispatchContext = require(script.Parent.ReplyingToMessageDispatchContext)

local function ReplyingToMessageProvider(tbl1)
    local value, var1 = React.useState(nil)

    return React.createElement(ReplyingToMessageContext.Provider, { value = value }, {
        ReplyingToMessageDispatch = React.createElement(ReplyingToMessageDispatchContext.Provider, { value = var1 }, tbl1.children)
    })
end

return ReplyingToMessageProvider
