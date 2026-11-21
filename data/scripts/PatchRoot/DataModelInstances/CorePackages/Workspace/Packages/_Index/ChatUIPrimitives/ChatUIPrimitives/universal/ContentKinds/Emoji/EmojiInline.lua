-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T07:30:43Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ChatUIPrimitivesParent = script:FindFirstAncestor("ChatUIPrimitives").Parent
local React = require(ChatUIPrimitivesParent.React)
local Foundation = require(ChatUIPrimitivesParent.Foundation)
local _Signals = require(ChatUIPrimitivesParent.Signals)
local SignalsReact = require(ChatUIPrimitivesParent.SignalsReact)

local EmojiContentModel = require(script.Parent.EmojiContentModel)
local _EmojiTypes = require(script.Parent.EmojiTypes)

local function EmojiInline(tbl1)
    local var1 = SignalsReact.useSignalBinding(tbl1.getContent)

    return React.createElement(Foundation.Text, {
        tag = "size-full-0 auto-y text-heading-small text-wrap text-align-x-left text-align-y-top",
        Text = var1:map(EmojiContentModel.getDisplayText),
        LayoutOrder = tbl1.LayoutOrder
    })
end

return EmojiInline
