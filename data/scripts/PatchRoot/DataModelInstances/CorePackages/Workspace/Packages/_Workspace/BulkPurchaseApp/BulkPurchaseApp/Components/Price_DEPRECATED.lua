-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T22:31:26Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local LocalizationService = game:GetService("LocalizationService")

local BulkPurchaseAppParent = script:FindFirstAncestor("BulkPurchaseApp").Parent
local React = require(BulkPurchaseAppParent.React)
local useDesignTokens = require(BulkPurchaseAppParent.Style).useDesignTokens
local NumberLocalization = require(BulkPurchaseAppParent.Localization).NumberLocalization
local UIBlox = require(BulkPurchaseAppParent.UIBlox)

local StyledTextLabel = UIBlox.App.Text.StyledTextLabel
local ImageSetLabel = UIBlox.Core.ImageSet.ImageSetLabel
local Images = UIBlox.App.ImageSet.Images

local function PriceIcon(tbl1)
    return React.createElement(ImageSetLabel, {
        Size = tbl1.Size,
        Image = Images["icons/common/robux_small"],
        ImageColor3 = tbl1.color,
        ImageTransparency = 0,
        BackgroundTransparency = 1,
        LayoutOrder = tbl1.LayoutOrder
    })
end

local function Price_DEPRECATED(tbl1)
    local var1 = useDesignTokens()

    return React.createElement(
        "Frame",
        {
            Size = UDim2.fromScale(1, 0),
            AutomaticSize = Enum.AutomaticSize.Y,
            BackgroundTransparency = 1,
            BorderSizePixel = 0
        },
        React.createElement("UIListLayout", {
            SortOrder = Enum.SortOrder.LayoutOrder,
            HorizontalAlignment = Enum.HorizontalAlignment.Right,
            VerticalAlignment = Enum.VerticalAlignment.Center,
            FillDirection = Enum.FillDirection.Horizontal,
            Padding = UDim.new(0, var1.Size.Size_100)
        }),
        React.createElement(PriceIcon, {
            Size = UDim2.fromOffset(tbl1.fontStyle.FontSize, tbl1.fontStyle.FontSize),
            color = tbl1.colorStyle.Color3,
            LayoutOrder = 1
        }),
        React.createElement(StyledTextLabel, {
            fontStyle = tbl1.fontStyle,
            colorStyle = tbl1.colorStyle,
            text = NumberLocalization.localize(tbl1.amount, LocalizationService.RobloxLocaleId),
            textXAlignment = Enum.TextXAlignment.Right,
            layoutOrder = 2
        })
    )
end

return Price_DEPRECATED
