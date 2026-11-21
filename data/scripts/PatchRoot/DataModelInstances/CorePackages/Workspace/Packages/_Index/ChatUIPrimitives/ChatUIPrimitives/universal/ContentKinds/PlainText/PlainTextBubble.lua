-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T07:30:47Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ChatUIPrimitivesParent = script:FindFirstAncestor("ChatUIPrimitives").Parent
local React = require(ChatUIPrimitivesParent.React)
local Foundation = require(ChatUIPrimitivesParent.Foundation)
local _Signals = require(ChatUIPrimitivesParent.Signals)
local SignalsReact = require(ChatUIPrimitivesParent.SignalsReact)

local BubbleStyleContext = require(script.Parent.Parent.Parent.MessageList.Bubble.BubbleStyleContext)
local useBubbleTextConstraint = require(script.Parent.Parent.useBubbleTextConstraint)
local _PlainTextTypes = require(script.Parent.PlainTextTypes)

local function PlainTextBubble(tbl1)
    local var1, fontStyle = BubbleStyleContext.useBubbleFontStyle()
    local var3 = SignalsReact.useSignalBinding(tbl1.getContent)
    local sizeConstraint = useBubbleTextConstraint()

    return React.createElement(Foundation.Text, {
        tag = "auto-xy text-wrap text-align-x-left text-align-y-top",
        Text = var3:map(function(arg1)
            return arg1.displayText.text
        end),
        textStyle = var1.textStyle,
        fontStyle = fontStyle,
        sizeConstraint = sizeConstraint,
        LayoutOrder = tbl1.LayoutOrder
    })
end

return PlainTextBubble
