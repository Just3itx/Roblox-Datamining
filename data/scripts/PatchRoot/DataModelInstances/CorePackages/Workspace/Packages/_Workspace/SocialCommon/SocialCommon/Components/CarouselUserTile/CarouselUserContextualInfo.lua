-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T15:11:17Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialCommonParent = script:FindFirstAncestor("SocialCommon").Parent
local React = require(SocialCommonParent.React)
local Cryo = require(SocialCommonParent.Cryo)

local UIBlox = require(SocialCommonParent.UIBlox)
local useStyle = UIBlox.Core.Style.useStyle
local StyledTextLabel = UIBlox.App.Text.StyledTextLabel
local ImageSetLabel = UIBlox.Core.ImageSet.ImageSetLabel
local Images = UIBlox.App.ImageSet.Images
local IconSize = UIBlox.App.Constant.IconSize
local useTextSizeOffset = UIBlox.Core.Style.useTextSizeOffset

local AppCommonLibText = require(SocialCommonParent.AppCommonLib).Text

local Constants = require(script.Parent.Constants)

local tbl1 = {
    maxNumberOfLines = Constants.LINES_MAX,
    lineWidth = Constants.TILE_SIZE
}

function CarouselUserContextualInfo(tbl2)
    local var1 = Cryo.Dictionary.join(tbl1, tbl2)
    local icon = var1.icon
    local label = var1.label
    local var2 = useStyle()
    local var3 = useTextSizeOffset()
    local theme = var2.Theme
    local font = var2.Font
    local fontStyle = label.font or font.CaptionBody
    local text = label.text

    local xOffset = icon and var1.lineWidth - (IconSize.Small + 2) or var1.lineWidth

    local yOffset = React.useMemo(function(): number
        return math.min(
            (font.BaseSize * fontStyle.RelativeSize + var3) * var1.maxNumberOfLines,
            AppCommonLibText.GetTextHeight(text or "", fontStyle.Font, font.BaseSize * fontStyle.RelativeSize, xOffset)
        )
    end, {
        fontStyle.Font,
        font.BaseSize,
        fontStyle.RelativeSize,
        var1.maxNumberOfLines,
        text,
        var3,
        xOffset
    })

    local createElement = React.createElement
    local str1 = "Frame"
    local tbl3 = {
        LayoutOrder = var1.layoutOrder,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 1, 0)
    }
    local tbl4 = {
        UIListLayout = React.createElement("UIListLayout", {
            FillDirection = Enum.FillDirection.Horizontal,
            SortOrder = Enum.SortOrder.LayoutOrder,
            VerticalAlignment = Enum.VerticalAlignment.Center,
            Padding = UDim.new(0, 2)
        }),
        IconFrame = 0,
        ContextualText = 0
    }
    local element

    if icon and icon.path then
        element = React.createElement(
            "Frame",
            {
                Size = UDim2.fromOffset(IconSize.Small, IconSize.Small),
                BackgroundTransparency = 1
            },
            {
                layout = React.createElement(
                    "UIListLayout",
                    {
                        VerticalAlignment = Enum.VerticalAlignment.Top,
                        HorizontalAlignment = Enum.HorizontalAlignment.Center
                    }
                ),
                ImageLabel = React.createElement(ImageSetLabel, {
                    LayoutOrder = 1,
                    BackgroundTransparency = 1,
                    Image = Images[icon.path],
                    ImageColor3 = icon.color or theme.IconDefault.Color,
                    ImageTransparency = icon.transparency or theme.IconDefault.Transparency,
                    Size = icon.size or UDim2.fromOffset(IconSize.Small, IconSize.Small),
                    AnchorPoint = Vector2.new(0.5, 0.5),
                    Position = UDim2.fromScale(0.5, 0.5)
                })
            }
        )
    else
        element = nil
    end

    tbl4.IconFrame = element
    local element2

    if text then
        element2 = React.createElement(StyledTextLabel, {
            layoutOrder = 2,
            size = UDim2.fromOffset(xOffset, yOffset),
            lineHeight = 1,
            text = text,
            textXAlignment = Enum.TextXAlignment.Left,
            textYAlignment = Enum.TextYAlignment.Top,
            textTruncate = Enum.TextTruncate.AtEnd,
            fontStyle = fontStyle,
            colorStyle = label.colorStyle or theme.SecondaryContent,
            fluidSizing = false,
            richText = false
        })
    else
        element2 = nil
    end

    tbl4.ContextualText = element2
    return createElement(str1, tbl3, tbl4)
end

return CarouselUserContextualInfo
