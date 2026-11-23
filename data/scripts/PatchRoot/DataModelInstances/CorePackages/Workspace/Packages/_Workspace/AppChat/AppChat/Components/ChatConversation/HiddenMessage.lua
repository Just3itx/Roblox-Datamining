-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T07:21:16Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChatParent = script:FindFirstAncestor("AppChat").Parent

local React = require(AppChatParent.React)
local Cryo = require(AppChatParent.Cryo)
local Foundation = require(AppChatParent.Foundation)

local ChatBubbleContainer = require(script.Parent.Bubble.ChatBubbleContainer)

local tbl1 = {
    isIncoming = false,
    hasTail = false,
    isPending = false,
    isRepliedTo = false,
    isPressed = false,
    innerPadding = 0,
    maxWidth = 180,
    LayoutOrder = 0,
    isLastMessageInMessageGroup = false
}

local function HiddenMessage(tbl2)
    local var1 = Cryo.Dictionary.union(tbl1, tbl2)
    local var2 = Foundation.Hooks.useTokens()

    return React.createElement(ChatBubbleContainer, {
        isIncoming = var1.isIncoming,
        hasTail = var1.hasTail,
        isPending = var1.isPending,
        isUnfiltered = false,
        padding = {
            top = UDim.new(0, var2.Padding.Small),
            bottom = UDim.new(0, var2.Padding.Small),
            left = UDim.new(0, var2.Padding.Medium),
            right = UDim.new(0, var2.Padding.Medium)
        },
        LayoutOrder = var1.LayoutOrder,
        isRepliedTo = var1.isRepliedTo,
        isPressed = var1.isPressed,
        isLastMessageInMessageGroup = var1.isLastMessageInMessageGroup,
        bubbleRef = var1.bubbleRef,
        [React.Change.AbsoluteSize] = var1[React.Change.AbsoluteSize]
    }, {
        IconContainer = React.createElement(Foundation.View, {
            tag = "row align-x-center align-y-center content-muted",
            Size = UDim2.fromOffset(180 - var2.Padding.Medium * 2, 40 - var2.Padding.Small * 2)
        }, {
            LockIcon = React.createElement(Foundation.Icon, {
                name = Foundation.Enums.IconName.LockClosed,
                size = Foundation.Enums.IconSize.Medium,
                variant = Foundation.Enums.IconVariant.Regular
            })
        })
    })
end

return HiddenMessage
