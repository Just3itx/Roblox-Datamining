-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T22:31:17Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BulkPurchaseAppParent = script:FindFirstAncestor("BulkPurchaseApp").Parent
local React = require(BulkPurchaseAppParent.React)
local StyledTextLabel = require(BulkPurchaseAppParent.UIBlox).App.Text.StyledTextLabel
local useDesignTokens = require(BulkPurchaseAppParent.Style).useDesignTokens

local FFlagReplaceMissingDesignTokens = require(BulkPurchaseAppParent.SharedFlags).FFlagReplaceMissingDesignTokens

local Box = require(script.Parent.Box)

local function mapTokens(arg1)
    local size1200 = arg1.Size.Size_1200
    local size200 = arg1.Size.Size_200

    return {
        fontStyle = arg1.Typography.BodyLarge,
        colorStyle = arg1.Color.Content.Default,
        imageRightMargin = arg1.Size.Size_300,
        imageBoxSize = size1200,
        imageBoxPadding = size200,
        imageBoxTransparency = arg1.Color.Common.Shimmer.Transparency,
        imageBoxBackgroundColor = arg1.Color.Common.Shimmer.Color3,
        imageBoxCornerRadius = arg1.Radius.Medium,
        imageSize = size1200 - size200 * 2
    }
end

local function Item(tbl1)
    local var1 = useDesignTokens(mapTokens)

    local createElement = React.createElement
    local str1 = "Frame"
    local tbl2 = {
        Size = UDim2.new(1, 0, 0, var1.imageBoxSize),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        LayoutOrder = tbl1.LayoutOrder
    }
    local tbl3 = { ImageBox = 0, LineItem = 0 }
    local createElement2 = React.createElement
    local var2 = Box
    local tbl4 = {
        Size = UDim2.fromOffset(var1.imageBoxSize, var1.imageBoxSize),
        BorderSizePixel = 0,
        BackgroundTransparency = var1.imageBoxTransparency,
        BackgroundColor3 = var1.imageBoxBackgroundColor,
        padding = {
            var1.imageBoxPadding,
            var1.imageBoxPadding,
            var1.imageBoxPadding,
            var1.imageBoxPadding
        },
        cornerRadius = UDim.new(0, var1.imageBoxCornerRadius)
    }
    local tbl5 = {
        Image = React.createElement("ImageLabel", {
            Image = tbl1.image,
            BorderSizePixel = 0,
            BackgroundTransparency = 1,
            Size = UDim2.fromOffset(var1.imageSize, var1.imageSize),
            [React.Tag] = "data-testid=BulkPurchaseApp_ItemImage"
        })
    }
    tbl3.ImageBox = createElement2(var2, tbl4, tbl5)

    tbl3.LineItem = React.createElement(
        "Frame",
        {
            Position = UDim2.fromOffset(var1.imageBoxSize + var1.imageRightMargin, 0),
            Size = UDim2.new(1, -(var1.imageBoxSize + var1.imageRightMargin), 1, 0),
            BackgroundTransparency = 1,
            BorderSizePixel = 0
        },
        React.createElement(StyledTextLabel, {
            fontStyle = var1.fontStyle,
            colorStyle = var1.colorStyle,
            text = tbl1.name,
            textTruncate = Enum.TextTruncate.AtEnd,
            textYAlignment = Enum.TextYAlignment.Top,
            size = UDim2.new(0.66, 0, 1, 0),
            lineHeight = if FFlagReplaceMissingDesignTokens then var1.fontStyle.LineHeight else var1.fontStyle.lineHeight
        }),
        React.createElement("Frame", {
            AnchorPoint = Vector2.new(1, 0),
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            Size = UDim2.new(0.33, 0, 1, 0),
            Position = UDim2.new(1, 0, 0, 0)
        }, tbl1.endSlot)
    )
    return createElement(str1, tbl2, tbl3)
end

return Item
