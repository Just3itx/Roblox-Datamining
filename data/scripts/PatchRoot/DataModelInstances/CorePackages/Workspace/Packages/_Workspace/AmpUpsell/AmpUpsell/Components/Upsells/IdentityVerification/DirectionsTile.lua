-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T05:41:25Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AmpUpsellParent = script:FindFirstAncestor("AmpUpsell").Parent
local UIBlox = require(AmpUpsellParent.UIBlox)
local React = require(AmpUpsellParent.React)
local ImageSetLabel = UIBlox.Core.ImageSet.ImageSetLabel
local IconSize = UIBlox.App.Constant.IconSize
local Images = UIBlox.App.ImageSet.Images
local useStyle = UIBlox.Core.Style.useStyle
local StyledTextLabel = UIBlox.App.Text.StyledTextLabel

return function(tbl1)
    local var1 = useStyle()

    local frameHeight = tbl1.frameHeight

    return React.createElement(
        "Frame",
        {
            Size = UDim2.new(1, 0, 0, frameHeight),
            BackgroundTransparency = 1,
            LayoutOrder = tbl1.layoutOrder
        },
        {
            UIListLayout = React.createElement("UIListLayout", {
                SortOrder = Enum.SortOrder.LayoutOrder,
                FillDirection = Enum.FillDirection.Horizontal,
                HorizontalAlignment = Enum.HorizontalAlignment.Center,
                VerticalAlignment = Enum.VerticalAlignment.Center
            }),
            ImageIcon = React.createElement(ImageSetLabel, {
                AnchorPoint = Vector2.new(0, 0.5),
                Size = UDim2.new(0, IconSize.Large, 0, IconSize.Large),
                ScaleType = Enum.ScaleType.Fit,
                LayoutOrder = 1,
                BackgroundTransparency = 1,
                Image = Images[tbl1.imagePath],
                ImageTransparency = var1.Theme.SystemPrimaryDefault.Transparency
            }),
            TextFrame = React.createElement(
                "Frame",
                {
                    BackgroundTransparency = 1,
                    Size = UDim2.new(1, -48, 0, frameHeight),
                    LayoutOrder = 2
                },
                {
                    TextLayout = React.createElement("UIListLayout", {
                        SortOrder = Enum.SortOrder.LayoutOrder,
                        FillDirection = Enum.FillDirection.Vertical,
                        HorizontalAlignment = Enum.HorizontalAlignment.Center,
                        VerticalAlignment = Enum.VerticalAlignment.Center
                    }),
                    Header = React.createElement(StyledTextLabel, {
                        text = tbl1.headerText,
                        fontStyle = var1.Font.Header2,
                        colorStyle = var1.Theme.TextEmphasis,
                        size = UDim2.new(1, 0, 0.5, 0),
                        lineHeight = 1,
                        textTruncate = Enum.TextTruncate.AtEnd,
                        textXAlignment = Enum.TextXAlignment.Left,
                        textYAlignment = Enum.TextYAlignment.Center,
                        layoutOrder = 1
                    }),
                    Body = React.createElement(StyledTextLabel, {
                        text = tbl1.descriptionText,
                        fontStyle = var1.Font.CaptionBody,
                        colorStyle = var1.Theme.TextDefault,
                        size = UDim2.new(1, 0, 0.5, 0),
                        lineHeight = 1,
                        textTruncate = Enum.TextTruncate.AtEnd,
                        textXAlignment = Enum.TextXAlignment.Left,
                        textYAlignment = Enum.TextYAlignment.Center,
                        layoutOrder = 2
                    })
                }
            )
        }
    )
end
