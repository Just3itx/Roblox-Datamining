-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T07:31:11Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ChatUIPrimitives = script:FindFirstAncestor("ChatUIPrimitives")
local ChatUIPrimitivesParent = ChatUIPrimitives.Parent
local React = require(ChatUIPrimitivesParent.React)

local ChatInputBarView = require(ChatUIPrimitives.Components.ChatInputBar.ChatInputBarView)
local useMessageComposerViewModel = require(script.Parent.useMessageComposerViewModel)

local function MessageComposer(arg1)
    local var1 = useMessageComposerViewModel(arg1)
    return React.createElement(ChatInputBarView, var1)
end

return MessageComposer
