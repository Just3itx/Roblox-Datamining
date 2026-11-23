-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T07:31:26Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local _types = require(AppChat.types)
local Cryo = require(AppChatParent.Cryo)
local React = require(AppChatParent.React)
local memo = React.memo
local useCallback = React.useCallback

local useStyle = require(AppChatParent.UIBlox).Core.Style.useStyle
local BidirectionalFlatList = require(AppChatParent.VirtualizedList).BidirectionalFlatList

local PendingShimmerBubble = require(script.Parent.PendingShimmerBubble)

local tbl1 = {
    itemList = {
        {
            addBottomPadding = true,
            heightFactor = 1,
            isIncoming = true,
            showAvatarCircle = true,
            widthPercentage = 0.5
        },
        {
            addBottomPadding = false,
            heightFactor = 1,
            isIncoming = true,
            showAvatarCircle = false,
            widthPercentage = 0.2
        },
        {
            addBottomPadding = true,
            heightFactor = 1,
            isIncoming = false,
            showAvatarCircle = false,
            widthPercentage = 0.6
        },
        {
            addBottomPadding = true,
            heightFactor = 2,
            isIncoming = true,
            showAvatarCircle = true,
            widthPercentage = 0.75
        },
        {
            addBottomPadding = true,
            heightFactor = 2,
            isIncoming = false,
            showAvatarCircle = false,
            widthPercentage = 0.75
        },
        {
            addBottomPadding = false,
            heightFactor = 1,
            isIncoming = false,
            showAvatarCircle = false,
            widthPercentage = 0.75
        },
        {
            addBottomPadding = false,
            heightFactor = 1,
            isIncoming = false,
            showAvatarCircle = false,
            widthPercentage = 0.2
        },
        {
            addBottomPadding = true,
            heightFactor = 2,
            isIncoming = true,
            showAvatarCircle = true,
            widthPercentage = 0.7
        },
        {
            addBottomPadding = false,
            heightFactor = 1,
            isIncoming = true,
            showAvatarCircle = false,
            widthPercentage = 0.5
        },
        {
            addTopPadding = true,
            addBottomPadding = false,
            heightFactor = 1,
            isIncoming = true,
            showAvatarCircle = false,
            widthPercentage = 0.2
        }
    },
    size = UDim2.new(1, 0, 1, 0),
    minTransparency = 0.5,
    maxTransparency = 0.9
}

return memo(function(tbl2) -- name: PendingStateIndicator
    local var1 = Cryo.Dictionary.join(tbl1, tbl2)
    local var2 = useStyle()
    local var3 = var1.style or var2
    local itemListLen = #var1.itemList

    local renderItem = useCallback(function(arg1)
        local num1 = math.max(1, #var1.itemList)

        local backgroundTransparency = var1.maxTransparency - (var1.maxTransparency - var1.minTransparency) * (arg1.index - 1) / num1
        return React.createElement(
            PendingShimmerBubble,
            Cryo.Dictionary.join(arg1.item, { backgroundTransparency = backgroundTransparency })
        )
    end, { itemListLen })

    return React.createElement("Frame", {
        BackgroundColor3 = var3.Theme.BackgroundDefault.Color,
        BorderSizePixel = 0,
        Size = var1.size,
        Transparency = var3.Tokens.Color.None.Transparency,
        LayoutOrder = var1.layoutOrder
    }, {
        ShimmerMessageList = React.createElement(BidirectionalFlatList, {
            data = var1.itemList,
            renderItem = renderItem,
            inverted = true,
            style = {
                BackgroundTransparency = 1,
                ScrollBarThickness = 0,
                Name = "ShimmerMessageList"
            },
            contentContainerStyle = { BackgroundTransparency = 1 },
            keyExtractor = function<T>(_, arg1: T): T
                return arg1
            end,
            optimizeInvertedCanvasResize = true
        })
    })
end)
