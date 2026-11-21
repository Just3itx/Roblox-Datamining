-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T07:40:52Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ChatUIPrimitivesParent = script:FindFirstAncestor("ChatUIPrimitives").Parent
local React = require(ChatUIPrimitivesParent.React)
local Foundation = require(ChatUIPrimitivesParent.Foundation)

local MessageInlineItemMetrics = require(script.Parent.MessageInlineItemMetrics)

local function InlineItemFrame(tbl1)
    return React.createElement(
        Foundation.View,
        {
            tag = "col size-full-0 auto-y",
            sizeConstraint = {
                MinSize = Vector2.new(0, MessageInlineItemMetrics.MIN_HEIGHT)
            }
        },
        tbl1.children
    )
end
return InlineItemFrame
