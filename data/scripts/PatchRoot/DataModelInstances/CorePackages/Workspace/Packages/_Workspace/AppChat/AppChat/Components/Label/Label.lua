-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T08:21:27Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local _types = require(AppChat.types)
local Cryo = require(AppChatParent.Cryo)
local React = require(AppChatParent.React)
local memo = React.memo

local UIBlox = require(AppChatParent.UIBlox)
local normalizeFontFace = require(AppChatParent.Foundation).Utility.normalizeFontFace
local ImageSetLabel = UIBlox.Core.ImageSet.ImageSetLabel
local useStyle = UIBlox.Core.Style.useStyle

local tbl1 = { bodyText = "" }

return memo(function(tbl2) -- name: Label
    local var1 = Cryo.Dictionary.join(tbl1, tbl2)
    local var2 = useStyle()
    local var3 = var1.style or var2

    local size100 = var3.Tokens.Size.Size_100
    local size150 = var3.Tokens.Size.Size_150
    local size300 = var3.Tokens.Size.Size_300

    local createElement = React.createElement
    local str1 = "Frame"
    local tbl3 = {
        AutomaticSize = Enum.AutomaticSize.X,
        BackgroundColor3 = var1.backgroundColor3 or var3.Theme.BackgroundDefault.Color,
        BackgroundTransparency = var1.backgroundTransparency or var3.Theme.BackgroundDefault.Transparency,
        BorderSizePixel = 0,
        Size = UDim2.new(0, 0, 0, var3.Tokens.Size.Size_500),
        LayoutOrder = var1.layoutOrder
    }
    local tbl4 = {
        UIListLayout = React.createElement("UIListLayout", {
            FillDirection = Enum.FillDirection.Horizontal,
            SortOrder = Enum.SortOrder.LayoutOrder,
            VerticalAlignment = Enum.VerticalAlignment.Center,
            Padding = UDim.new(0, size100)
        }),
        ContentPadding = React.createElement("UIPadding", {
            PaddingLeft = UDim.new(0, size100),
            PaddingRight = UDim.new(0, size150),
            PaddingBottom = UDim.new(0, size100),
            PaddingTop = UDim.new(0, size100)
        }),
        UICorner = React.createElement("UICorner", { CornerRadius = UDim.new(0, var3.Tokens.Radius.Small) }),
        IconImage = 0,
        BodyText = 0
    }
    local element

    if var1.iconImage then
        element = React.createElement(ImageSetLabel, {
            Size = UDim2.new(0, size300, 0, size300),
            BackgroundTransparency = 1,
            Image = var1.iconImage,
            ImageColor3 = var1.imageColor3 or var3.Theme.IconEmphasis.Color,
            ImageTransparency = var1.imageTransparency or var3.Theme.IconEmphasis.Transparency,
            LayoutOrder = 1
        })
    else
        element = nil
    end

    tbl4.IconImage = element

    tbl4.BodyText = React.createElement("TextLabel", {
        AutomaticSize = Enum.AutomaticSize.X,
        BackgroundTransparency = 1,
        FontFace = normalizeFontFace(var3.Tokens.Typography.BodyLarge.Font),
        LayoutOrder = 2,
        Size = UDim2.new(0, 0, 1, 0),
        Text = var1.bodyText,
        TextColor3 = var1.bodyTextColor3 or var3.Theme.TextEmphasis.Color,
        TextSize = var3.Tokens.FontSize.FontSize_250,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextYAlignment = Enum.TextYAlignment.Center
    })
    return createElement(str1, tbl3, tbl4)
end)
