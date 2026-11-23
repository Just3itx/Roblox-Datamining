-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T07:11:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local React = require(AppChatParent.React)
local Cryo = require(AppChatParent.Cryo)
local ChatBubbleEnum = require(script.Parent.ChatBubbleEnum)
local getChatBubbleCornerRadii = require(script.Parent.getChatBubbleCornerRadii)
local Foundation = require(AppChatParent.Foundation)
local Image = Foundation.Image
local View = Foundation.View
local useTokens = Foundation.Hooks.useTokens

local FFlagAppChatNativeFoundationCornerRadii = require(AppChat.Flags.FFlagAppChatNativeFoundationCornerRadii)

local tbl1 = {
    alignment = Enum.HorizontalAlignment.Right,
    children = {},
    imageStyle = {
        Color3 = Color3.new(0, 0, 0),
        Transparency = 0
    },
    layoutOrder = 0,
    onAbsoluteSizeChanged = function(_) end,
    padding = 0,
    position = UDim2.new(0, 0, 0, 0),
    setContentWidth = function(_: number) end,
    variant = ChatBubbleEnum.BUBBLE_VARIANTS.SINGLE
}

function ChatBubbleGroupable(tbl2)
    local var1 = Cryo.Dictionary.union(tbl1, tbl2)
    local bool1 = var1.alignment == Enum.HorizontalAlignment.Left
    local size500 = useTokens().Size.Size_500

    local element = React.createElement(View, { tag = "size-0 auto-xy", BackgroundTransparency = 1, padding = var1.padding }, var1.children)

    if FFlagAppChatNativeFoundationCornerRadii then
        return React.createElement(View, {
            AutomaticSize = Enum.AutomaticSize.XY,
            backgroundStyle = var1.imageStyle,
            cornerRadius = getChatBubbleCornerRadii(var1.variant, bool1, size500),
            Position = var1.position,
            LayoutOrder = var1.layoutOrder,
            onAbsoluteSizeChanged = var1.onAbsoluteSizeChanged
        }, element)
    end

    local var2 = if bool1 then ChatBubbleEnum.GROUPED_RECEIVED_BUBBLES else ChatBubbleEnum.GROUPED_OUTGOING_BUBBLES
    local var3

    if var1.variant == ChatBubbleEnum.BUBBLE_VARIANTS.SINGLE then
        var3 = ChatBubbleEnum.GROUPED_BUBBLE_SINGLE
    elseif var1.variant == ChatBubbleEnum.BUBBLE_VARIANTS.TOP then
        var3 = var2.BUBBLE_TOP
    elseif var1.variant == ChatBubbleEnum.BUBBLE_VARIANTS.BOTTOM then
        var3 = var2.BUBBLE_BOTTOM
    else
        var3 = var2.BUBBLE_MIDDLE
    end
    return React.createElement(Image, {
        AutomaticSize = Enum.AutomaticSize.XY,
        BackgroundTransparency = 1,
        Image = var3,
        ScaleType = Enum.ScaleType.Slice,
        slice = {
            center = ChatBubbleEnum.GROUPED_BUBBLE_SLICE_CENTER
        },
        imageStyle = var1.imageStyle,
        Position = var1.position,
        LayoutOrder = var1.layoutOrder,
        onAbsoluteSizeChanged = var1.onAbsoluteSizeChanged
    }, element)
end

return React.memo(ChatBubbleGroupable)
