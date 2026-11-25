-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T15:11:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialCommonParent = script:FindFirstAncestor("SocialCommon").Parent

local React = require(SocialCommonParent.React)
local UIBlox = require(SocialCommonParent.UIBlox)
local Dash = require(SocialCommonParent.Dash)
local AppCommonLibText = require(SocialCommonParent.AppCommonLib).Text

local useStyle = UIBlox.Core.Style.useStyle
local ImageSetLabel = UIBlox.Core.ImageSet.ImageSetLabel
local ImageSetButton = UIBlox.Core.ImageSet.ImageSetButton
local StyledTextLabel = UIBlox.App.Text.StyledTextLabel
local IconSize = UIBlox.App.Constant.IconSize
local Badge = UIBlox.App.Indicator.Badge
local Colors = UIBlox.App.Style.Colors

local useImpressionsTagger = require(SocialCommonParent.Impressions).useImpressionsTagger

local tbl1 = {
    badgeValue = nil,
    icon = "",
    labelText = "",
    onActivated = function() end,
    tileSize = 100,
    iconSize = IconSize.Large,
    borderThickness = 0,
    cornerRadius = UDim.new(0, 8),
    styleProps = {
        textXAlignment = Enum.TextXAlignment.Center,
        containFooterInTileSize = false
    }
}

return function(arg1)
    local var1 = Dash.join(tbl1, arg1 or {})
    local var2 = useStyle()
    local font = var2.Font

    local styleProps = var1.styleProps
    local fontStyle = if styleProps.font then styleProps.font else font.CaptionHeader
    local var4 = font.BaseSize * fontStyle.RelativeSize
    local textHeight = AppCommonLibText.GetTextHeight(var1.labelText, fontStyle.Font, var4)

    local var5 = var1.tileSize - var1.borderThickness

    if var1.styleProps.containFooterInTileSize then
        var5 = var5 - textHeight * 2 - 8
    end

    local var6

    if var1.impressionsTag then
        var6 = React.useRef(nil)
        useImpressionsTagger(var6, var1.impressionsTag, var1.LayoutOrder)
    else
        var6 = nil
    end

    local createElement = React.createElement
    local tbl2 = {
        LayoutOrder = var1.LayoutOrder,
        AutomaticSize = Enum.AutomaticSize.Y,
        Size = UDim2.fromOffset(var5, 0),
        BackgroundTransparency = 1,
        ref = var6
    }
    local tbl3 = {
        UIPadding = React.createElement("UIPadding", { PaddingTop = UDim.new(0, var1.borderThickness) }),
        UIListLayout = React.createElement("UIListLayout", {
            FillDirection = Enum.FillDirection.Vertical,
            VerticalAlignment = Enum.VerticalAlignment.Bottom,
            SortOrder = Enum.SortOrder.LayoutOrder,
            Padding = UDim.new(0, 8)
        }),
        Tile = React.createElement(ImageSetButton, {
            Size = UDim2.fromOffset(var5, var5),
            BackgroundColor3 = var2.Theme.BackgroundUIDefault.Color,
            BackgroundTransparency = var2.Theme.BackgroundUIDefault.Transparency,
            [React.Event.Activated] = var1.onActivated,
            LayoutOrder = 1
        }, {
            UICorner = React.createElement("UICorner", { CornerRadius = var1.cornerRadius }),
            UIStroke = React.createElement(
                "UIStroke",
                {
                    Color = var2.Theme.Divider.Color,
                    Transparency = var2.Theme.Divider.Transparency,
                    Thickness = var1.borderThickness
                }
            ),
            Icon = React.createElement(ImageSetLabel, {
                AnchorPoint = Vector2.new(0.5, 0.5),
                BackgroundTransparency = 1,
                ImageTransparency = var2.Theme.IconEmphasis.Transparency,
                ImageColor3 = Colors.White,
                Image = var1.icon,
                Size = UDim2.fromOffset(var1.iconSize, var1.iconSize),
                Position = UDim2.fromScale(0.5, 0.5)
            }),
            Badge = var1.badgeValue
                and React.createElement(
                    Badge,
                    {
                        anchorPoint = Vector2.new(1, 0),
                        position = UDim2.fromOffset(var1.tileSize - 8, 8),
                        value = var1.badgeValue
                    }
                )
        }),
        Label = React.createElement(ImageSetButton, {
            BackgroundTransparency = 1,
            AutomaticSize = Enum.AutomaticSize.Y,
            Size = UDim2.fromScale(1, 0),
            [React.Event.Activated] = var1.onActivated,
            LayoutOrder = 2
        }, {
            Text = React.createElement(StyledTextLabel, {
                text = var1.labelText,
                fontStyle = fontStyle,
                colorStyle = var2.Theme.TextEmphasis,
                size = UDim2.fromOffset(var5, textHeight * 2),
                textTruncate = Enum.TextTruncate.AtEnd,
                textXAlignment = styleProps.textXAlignment,
                textYAlignment = Enum.TextYAlignment.Top,
                fluidSizing = false,
                richText = false,
                lineHeight = 1
            })
        })
    }
    return createElement("Frame", tbl2, tbl3)
end
