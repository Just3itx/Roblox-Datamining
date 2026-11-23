-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T07:31:24Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local _types = require(AppChat.types)
local Cryo = require(AppChatParent.Cryo)
local React = require(AppChatParent.React)

local UIBlox = require(AppChatParent.UIBlox)
local useChatPagePadding = require(AppChat.Contexts.ChatPagePadding.useChatPagePadding)
local useStyle = UIBlox.Core.Style.useStyle

local tbl1 = {
    addTopPadding = false,
    addBottomPadding = false,
    backgroundTransparency = 0.4,
    heightFactor = 1,
    isIncoming = false,
    showAvatarCircle = false,
    widthPercentage = 0.5
}

local function PendingShimmerBubble(tbl2)
    local var1 = Cryo.Dictionary.join(tbl1, tbl2)
    local var2 = useStyle()
    local var3 = var1.style or var2
    local offset = if var1.addBottomPadding then var3.Tokens.Size.Size_600 else var3.Tokens.Size.Size_100
    local size900 = var3.Tokens.Size.Size_900
    local uiDefaultColor = var3.Theme.UIDefault.Color
    local var4 = useChatPagePadding()

    local createElement = React.createElement
    local str1 = "Frame"
    local tbl3 = {
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y
    }
    local tbl4 = {
        UIListLayout = React.createElement("UIListLayout", {
            FillDirection = Enum.FillDirection.Horizontal,
            HorizontalAlignment = if var1.isIncoming then Enum.HorizontalAlignment.Left else Enum.HorizontalAlignment.Right,
            SortOrder = Enum.SortOrder.LayoutOrder,
            VerticalAlignment = Enum.VerticalAlignment.Bottom,
            Padding = UDim.new(0, var3.Tokens.Size.Size_100)
        }),
        ContentPadding = React.createElement("UIPadding", {
            PaddingLeft = UDim.new(0, var4.left),
            PaddingRight = UDim.new(0, var4.right),
            PaddingBottom = UDim.new(0, offset),
            PaddingTop = if var1.addTopPadding then UDim.new(0, var3.Tokens.Size.Size_600) else nil
        }),
        IncomingFrame = 0,
        ShimmerBubble = 0
    }
    local var5

    if var1.isIncoming then
        local createElement2 = React.createElement
        local str2 = "Frame"
        local tbl5 = {
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            Size = UDim2.new(0, size900, 0, size900),
            LayoutOrder = 1
        }

        local tbl6 = { AvatarCircleShimmer = 0 }
        local element

        if var1.showAvatarCircle then
            element = React.createElement(
                "Frame",
                {
                    BackgroundTransparency = var1.backgroundTransparency,
                    BackgroundColor3 = uiDefaultColor,
                    BorderSizePixel = 0,
                    Size = UDim2.new(1, 0, 1, 0),
                    LayoutOrder = 1
                },
                {
                    UICorner = React.createElement("UICorner", { CornerRadius = UDim.new(1, var3.Tokens.Radius.Circle) })
                }
            )
        else
            element = nil
        end

        tbl6.AvatarCircleShimmer = element
        var5 = createElement2(str2, tbl5, tbl6)
    else
        var5 = nil
    end

    tbl4.IncomingFrame = var5

    tbl4.ShimmerBubble = React.createElement("Frame", {
        BackgroundTransparency = var1.backgroundTransparency,
        BackgroundColor3 = uiDefaultColor,
        BorderSizePixel = 0,
        Size = UDim2.new(var1.widthPercentage, 0, 0, var1.heightFactor * var3.Tokens.Size.Size_500 + var3.Tokens.Size.Size_400),
        LayoutOrder = 2
    }, {
        UICorner = React.createElement("UICorner", { CornerRadius = UDim.new(0, var3.Tokens.Size.Size_300) }),
        UISizeConstraint = React.createElement("UISizeConstraint", { MaxSize = Vector2.new(800 * var1.widthPercentage, 1000) })
    })
    return createElement(str1, tbl3, tbl4)
end

return PendingShimmerBubble
