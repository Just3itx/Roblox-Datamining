-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T07:30:40Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ChatUIPrimitivesParent = script:FindFirstAncestor("ChatUIPrimitives").Parent
local React = require(ChatUIPrimitivesParent.React)
local Foundation = require(ChatUIPrimitivesParent.Foundation)
local _Signals = require(ChatUIPrimitivesParent.Signals)
local SignalsReact = require(ChatUIPrimitivesParent.SignalsReact)

local BubbleStyleContext = require(script.Parent.Parent.Parent.MessageList.Bubble.BubbleStyleContext)
local useBubbleTextConstraint = require(script.Parent.Parent.useBubbleTextConstraint)
local EmojiContentModel = require(script.Parent.EmojiContentModel)
local _EmojiTypes = require(script.Parent.EmojiTypes)

local function EmojiBubble(tbl1)
    local var1 = Foundation.Hooks.useTokens()
    local var2 = BubbleStyleContext.useBubbleStyle()
    local var3 = SignalsReact.useSignalBinding(tbl1.getContent)

    local fontStyle = React.useMemo(function()
        local headingSmall = var1.Typography.HeadingSmall
        return {
            Font = headingSmall.Font,
            FontSize = headingSmall.FontSize,
            LineHeight = headingSmall.LineHeight
        }
    end, { var1 })
    local sizeConstraint = useBubbleTextConstraint()

    return React.createElement(Foundation.Text, {
        tag = "auto-xy text-wrap text-align-x-left text-align-y-top",
        Text = var3:map(EmojiContentModel.getDisplayText),
        textStyle = var2.textStyle,
        fontStyle = fontStyle,
        sizeConstraint = sizeConstraint,
        LayoutOrder = tbl1.LayoutOrder
    })
end

return EmojiBubble
