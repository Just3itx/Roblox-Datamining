-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T07:11:16Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChatParent = script:FindFirstAncestor("AppChat").Parent

local React = require(AppChatParent.React)
local Cryo = require(AppChatParent.Cryo)
local ChatBubbleEnum = require(script.Parent.ChatBubbleEnum)
local Foundation = require(AppChatParent.Foundation)

local tbl1 = { isIncoming = false }

function RepliedToMarker(tbl2)
    local var1 = Cryo.Dictionary.union(tbl1, tbl2)

    return React.createElement(
        Foundation.View,
        {
            tag = "bg-shift-400 self-stretch",
            Size = UDim2.new(0, ChatBubbleEnum.REPLIED_TO_MARKER_WIDTH, 0, 0),
            BorderSizePixel = 0,
            AnchorPoint = if var1.isIncoming then Vector2.new(0, 0) else Vector2.new(1, 0),
            LayoutOrder = var1.layoutOrder
        },
        {
            UICorner = React.createElement("UICorner", { CornerRadius = UDim.new(1, 0) })
        }
    )
end

return React.memo(RepliedToMarker)
