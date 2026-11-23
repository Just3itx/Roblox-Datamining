-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T07:20:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local Cryo = require(AppChatParent.Cryo)
local React = require(AppChatParent.React)
local memo = React.memo

local Foundation = require(AppChatParent.Foundation)
local View = Foundation.View
local Skeleton = Foundation.Skeleton
local Radius = Foundation.Enums.Radius
local useTokens = Foundation.Hooks.useTokens

local useChatPagePadding = require(AppChat.Contexts.ChatPagePadding.useChatPagePadding)

local itemList = {
    {
        heightFactor = 1,
        isIncoming = true,
        showAvatarCircle = true,
        widthPercentage = 0.5,
        addBottomPadding = true
    },
    { heightFactor = 1, isIncoming = true, showAvatarCircle = false, widthPercentage = 0.2 },
    {
        heightFactor = 1,
        isIncoming = false,
        showAvatarCircle = false,
        widthPercentage = 0.6,
        addBottomPadding = true
    },
    {
        heightFactor = 2,
        isIncoming = true,
        showAvatarCircle = true,
        widthPercentage = 0.75,
        addBottomPadding = true
    },
    {
        heightFactor = 2,
        isIncoming = false,
        showAvatarCircle = false,
        widthPercentage = 0.75,
        addBottomPadding = true
    },
    { heightFactor = 1, isIncoming = false, showAvatarCircle = false, widthPercentage = 0.4 },
    {
        heightFactor = 1,
        isIncoming = true,
        showAvatarCircle = true,
        widthPercentage = 0.7,
        addBottomPadding = true
    },
    { heightFactor = 1, isIncoming = true, showAvatarCircle = false, widthPercentage = 0.5 }
}

local tbl2 = {
    size = UDim2.fromScale(1, 1),
    itemList = itemList
}

local function renderSkeletonRow(tbl3, arg1, tbl4, layoutOrder: number)
    local yOffset = tbl3.heightFactor * arg1.Size.Size_500 + arg1.Size.Size_400
    local size900 = arg1.Size.Size_900
    local offset = if tbl3.addBottomPadding then arg1.Size.Size_600 else arg1.Size.Size_100
    return React.createElement(View, {
        testId = "ConversationMessageSkeletonRow",
        LayoutOrder = layoutOrder,
        tag = {
            ["row align-y-bottom gap-small size-full-0 auto-y"] = true,
            ["align-x-left"] = tbl3.isIncoming,
            ["align-x-right"] = not tbl3.isIncoming
        },
        padding = {
            left = UDim.new(0, tbl4.left),
            right = UDim.new(0, tbl4.right),
            bottom = UDim.new(0, offset),
            top = if tbl3.addTopPadding then UDim.new(0, arg1.Size.Size_600) else nil
        }
    }, {
        Avatar = if tbl3.isIncoming and tbl3.showAvatarCircle then React.createElement(Skeleton, { LayoutOrder = 1, radius = Radius.Circle, Size = UDim2.fromOffset(size900, size900) }) else nil,
        Bubble = React.createElement(
            Skeleton,
            {
                LayoutOrder = 2,
                radius = Radius.Medium,
                Size = UDim2.new(tbl3.widthPercentage, 0, 0, yOffset)
            }
        )
    })
end
return memo(function(tbl3) -- name: ConversationMessageSkeletonList
    local var1 = Cryo.Dictionary.union(tbl2, tbl3)
    local var2 = useTokens()
    local var3 = useChatPagePadding()

    local tbl4 = {}

    for value, value2 in var1.itemList or itemList do
        tbl4["SkeletonRow" .. value] = renderSkeletonRow(value2, var2, var3, value)
    end

    return React.createElement(View, {
        testId = "ConversationMessageSkeletonList",
        Size = var1.size,
        LayoutOrder = var1.layoutOrder,
        tag = "size-full clip",
        layout = {
            FillDirection = Enum.FillDirection.Vertical,
            SortOrder = Enum.SortOrder.LayoutOrder,
            VerticalAlignment = Enum.VerticalAlignment.Bottom
        }
    }, tbl4)
end)
