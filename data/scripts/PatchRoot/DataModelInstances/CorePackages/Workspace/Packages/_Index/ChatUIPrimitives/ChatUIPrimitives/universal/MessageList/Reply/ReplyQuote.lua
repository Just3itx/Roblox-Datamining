-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T07:41:07Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ChatUIPrimitives = script:FindFirstAncestor("ChatUIPrimitives")
local ChatUIPrimitivesParent = ChatUIPrimitives.Parent
local React = require(ChatUIPrimitivesParent.React)
local Foundation = require(ChatUIPrimitivesParent.Foundation)

local escapeRichText = require(ChatUIPrimitives.Utils.escapeRichText)
local formatInlineIcon = require(ChatUIPrimitives.Utils.formatInlineIcon)
local BubbleView = require(script.Parent.Parent.Bubble.BubbleView)
local Sizing = require(script.Parent.Parent.Parent.Sizing)

return {
    Bubble = function(tbl1) -- name: BubbleReplyQuote
        local var1 = Sizing.useSizing()
        local var2 = Foundation.Hooks.useTokens()
        local isObservingUser = tbl1.isObservingUser
        local reply = var1.reply
        local cornerRadius = var1.bubble.cornerRadius
        local contentMaxWidth = var1.bubble.contentMaxWidth
        local tag = Foundation.Hooks.useDefaultTags(
            if isObservingUser then reply.rightLabelTag else reply.leftLabelTag,
            "auto-xy content-muted"
        )

        local cornerRadii = React.useMemo(function()
            return {
                topLeft = cornerRadius,
                topRight = cornerRadius,
                bottomLeft = cornerRadius,
                bottomRight = cornerRadius
            }
        end, { cornerRadius })
        local sizeConstraint = React.useMemo(function()
            return {
                MinSize = Vector2.new(0, 0),
                MaxSize = Vector2.new(contentMaxWidth, math.huge)
            }
        end, { contentMaxWidth })
        local var3 = React.useMemo(function()
            return {
                MinSize = Vector2.new(0, 0),
                MaxSize = Vector2.new(reply.textMaxWidth, reply.textMaxHeight)
            }
        end, { reply.textMaxWidth, reply.textMaxHeight })

        return React.createElement(Foundation.View, {
            tag = {
                ["col gap-xxsmall auto-xy padding-bottom-xxsmall"] = true,
                ["align-x-right"] = isObservingUser,
                ["align-x-left"] = not isObservingUser
            },
            LayoutOrder = tbl1.LayoutOrder
        }, {
            Label = if tbl1.label == nil then nil else React.createElement(Foundation.Text, {
                tag = tag,
                Text = tbl1.label,
                TextTruncate = Enum.TextTruncate.AtEnd,
                sizeConstraint = sizeConstraint,
                LayoutOrder = 1,
                testId = "message-reply-label"
            }),
            Quote = React.createElement(
                Foundation.View,
                { tag = "row gap-small auto-xy", LayoutOrder = 2, testId = "message-reply-quote" },
                {
                    Marker = React.createElement(Foundation.View, {
                        tag = "self-stretch radius-circle bg-shift-400",
                        Size = UDim2.fromOffset(reply.markerWidth, 0),
                        LayoutOrder = if isObservingUser then 2 else 1,
                        testId = "message-reply-marker"
                    }),
                    Bubble = React.createElement(BubbleView, {
                        backgroundStyle = var2.Color.Shift.Shift_200,
                        cornerRadii = cornerRadii,
                        LayoutOrder = if isObservingUser then 1 else 2
                    }, {
                        Text = React.createElement(Foundation.Text, {
                            tag = "auto-xy text-wrap text-align-x-left text-align-y-top content-muted",
                            fontStyle = reply.fontStyle,
                            Text = tbl1.text,
                            TextTruncate = Enum.TextTruncate.AtEnd,
                            sizeConstraint = var3,
                            testId = "message-reply"
                        })
                    })
                }
            )
        })
    end,
    Inline = function(tbl1) -- name: InlineReplyQuote
        local var1 = React.useMemo(function(): string
            local var1 = string.gsub(tbl1.text, "%s+", " ")
            return `{formatInlineIcon(Foundation.Enums.IconName.ArrowCurlToLeft, { weight = "600" })} {escapeRichText(var1)}`
        end, { tbl1.text })

        return React.createElement(Foundation.Text, {
            tag = "size-full-0 auto-y text-caption-small text-align-x-left content-muted",
            Text = var1,
            RichText = true,
            TextTruncate = Enum.TextTruncate.AtEnd,
            LayoutOrder = tbl1.LayoutOrder,
            testId = "message-reply"
        })
    end
}
