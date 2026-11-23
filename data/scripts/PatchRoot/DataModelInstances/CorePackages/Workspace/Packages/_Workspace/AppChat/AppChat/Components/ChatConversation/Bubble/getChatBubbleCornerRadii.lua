-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T07:11:14Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ChatBubbleEnum = require(script.Parent.ChatBubbleEnum)
local MessageGroupShape = require(script.Parent.Parent.Grouping.MessageGroupShape)
local getGroupCornerRadii = require(script.Parent.Parent.Grouping.getGroupCornerRadii)

local tbl1 = {
    [ChatBubbleEnum.BUBBLE_VARIANTS.SINGLE] = MessageGroupShape.Position.Only,
    [ChatBubbleEnum.BUBBLE_VARIANTS.TOP] = MessageGroupShape.Position.First,
    [ChatBubbleEnum.BUBBLE_VARIANTS.MIDDLE] = MessageGroupShape.Position.Middle,
    [ChatBubbleEnum.BUBBLE_VARIANTS.BOTTOM] = MessageGroupShape.Position.Last
}

local function getChatBubbleCornerRadii(arg1, bool1: boolean, num1: number)
    return getGroupCornerRadii({
        direction = if bool1 then MessageGroupShape.Direction.Incoming else MessageGroupShape.Direction.Outgoing,
        position = tbl1[arg1]
    }, num1)
end

return getChatBubbleCornerRadii
