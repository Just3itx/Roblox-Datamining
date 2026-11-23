-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T05:50:48Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AmpUpsellParent = script:FindFirstAncestor("AmpUpsell").Parent
local UIBlox = require(AmpUpsellParent.UIBlox)
local Foundation = require(AmpUpsellParent.Foundation)
local IconSize = Foundation.Enums.IconSize
local Loading = Foundation.Loading

local React = require(AmpUpsellParent.React)
local StyledTextLabel = UIBlox.App.Text.StyledTextLabel

local ImageSetLabel = UIBlox.Core.ImageSet.ImageSetLabel
local Images = UIBlox.App.ImageSet.Images
local useStyle = UIBlox.Core.Style.useStyle

local function ProgressTile(tbl1)
    local frameHeight = tbl1.frameHeight
    local layoutOrder = tbl1.layoutOrder
    local finished = tbl1.finished
    local progressText = tbl1.progressText
    local var1 = useStyle()

    local createElement = React.createElement
    local str1 = "Frame"
    local tbl2 = {
        Size = UDim2.new(1, 0, 0, frameHeight),
        BackgroundTransparency = 1,
        LayoutOrder = layoutOrder
    }
    local tbl3 = {
        UIListLayout = React.createElement("UIListLayout", {
            SortOrder = Enum.SortOrder.LayoutOrder,
            FillDirection = Enum.FillDirection.Horizontal,
            HorizontalAlignment = Enum.HorizontalAlignment.Center,
            VerticalAlignment = Enum.VerticalAlignment.Center,
            Padding = UDim.new(0, 12)
        }),
        StatusIcon = 0,
        TextFrame = 0
    }
    local element

    if finished then
        element = React.createElement(ImageSetLabel, {
            Size = UDim2.new(0, frameHeight, 0, frameHeight),
            ScaleType = Enum.ScaleType.Fit,
            LayoutOrder = 1,
            BackgroundTransparency = 1,
            Image = Images["icons/status/success"],
            ImageTransparency = var1.Theme.SystemPrimaryDefault.Transparency,
            ImageColor3 = var1.Theme.IconEmphasis.Color
        })
    else
        element = React.createElement(Loading, { size = IconSize.Small })
    end

    tbl3.StatusIcon = element

    tbl3.TextFrame = React.createElement(
        "Frame",
        {
            Size = UDim2.new(1, -frameHeight - 12, 0, frameHeight),
            BackgroundTransparency = 1,
            LayoutOrder = 2
        },
        {
            ProgressText = React.createElement(StyledTextLabel, {
                text = progressText,
                fontStyle = var1.Font.CaptionBody,
                colorStyle = var1.Theme.TextDefault,
                size = UDim2.new(1, 0, 1, 0),
                lineHeight = 1,
                textTruncate = Enum.TextTruncate.AtEnd,
                textXAlignment = Enum.TextXAlignment.Left,
                textYAlignment = Enum.TextYAlignment.Center
            })
        }
    )
    return createElement(str1, tbl2, tbl3)
end

return ProgressTile
