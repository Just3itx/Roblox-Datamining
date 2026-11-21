-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T07:30:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ChatUIPrimitives = script:FindFirstAncestor("ChatUIPrimitives")
local ChatUIPrimitivesParent = ChatUIPrimitives.Parent
local React = require(ChatUIPrimitivesParent.React)
local Foundation = require(ChatUIPrimitivesParent.Foundation)
local _Signals = require(ChatUIPrimitivesParent.Signals)
local SignalsReact = require(ChatUIPrimitivesParent.SignalsReact)

local escapeRichText = require(ChatUIPrimitives.Utils.escapeRichText)
local BubbleStyleContext = require(script.Parent.Parent.Parent.MessageList.Bubble.BubbleStyleContext)
local useBubbleTextConstraint = require(script.Parent.Parent.useBubbleTextConstraint)
local _PresetTypes = require(script.Parent.PresetTypes)
local getPresetIconRichText = require(script.Parent.getPresetIconRichText)

local function PresetBubble(tbl1)
    local var1, fontStyle = BubbleStyleContext.useBubbleFontStyle()
    local var3 = SignalsReact.useSignalBinding(tbl1.getContent)
    local sizeConstraint = useBubbleTextConstraint()

    local var5 = React.useMemo(function()
        return getPresetIconRichText(fontStyle.FontSize)
    end, { fontStyle.FontSize })

    return React.createElement(Foundation.Text, {
        tag = "auto-xy text-wrap text-align-x-left text-align-y-top",
        Text = var3:map(function(arg1): string
            return `{escapeRichText(arg1.displayText)} {var5}`
        end),
        textStyle = var1.textStyle,
        fontStyle = fontStyle,
        sizeConstraint = sizeConstraint,
        RichText = true,
        LayoutOrder = tbl1.LayoutOrder
    })
end

return PresetBubble
