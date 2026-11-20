-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T18:40:49Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local App = script:FindFirstAncestor("App")
local AppParent = App.Parent
local AppParentParent = AppParent.Parent

local React = require(AppParentParent.React)
local Cryo = require(AppParentParent.Cryo)

local _ImagesTypes = require(App.ImageSet.ImagesTypes)
local _StyleTypes = require(App.Style.StyleTypes)

local IconSize = require(App.ImageSet.Enum.IconSize)
local getIconSize = require(App.ImageSet.getIconSize)
local Label = require(AppParent.Core.ImageSet.ImageSetComponent).Label
local GenericTextLabel = require(AppParent.Core.Text.GenericTextLabel.GenericTextLabel)
local useStyle = require(AppParent.Core.Style.useStyle)

local tbl1 = {
    containerPaddingLeft = 12,
    containerPaddingRight = 12,
    containerGap = 12,
    iconSize = getIconSize(IconSize.Large),
    dataGap = 0
}

local function StatWidget(tbl2)
    local var1 = useStyle()

    local var2 = Cryo.Dictionary.join(tbl1, tbl2.styleProps or {})
    local containerPaddingLeft = var2.containerPaddingLeft
    local containerPaddingRight = var2.containerPaddingRight
    local containerGap = var2.containerGap
    local iconSize = var2.iconSize
    local var3 = var2.iconContentColor or var1.Theme.IconEmphasis
    local dataGap = var2.dataGap
    local colorStyle = var2.dataContentColor or var1.Theme.TextEmphasis
    local var4 = var2.dataLabelContentColor or var1.Theme.TextEmphasis

    return React.createElement("Frame", {
        Position = tbl2.position,
        AnchorPoint = tbl2.anchorPoint,
        Size = tbl2.size,
        AutomaticSize = Enum.AutomaticSize.Y,
        BackgroundTransparency = 1,
        LayoutOrder = tbl2.layoutOrder
    }, {
        ListLayout = React.createElement("UIListLayout", {
            FillDirection = Enum.FillDirection.Horizontal,
            HorizontalAlignment = tbl2.horizontalAlignment,
            VerticalAlignment = Enum.VerticalAlignment.Center,
            Padding = UDim.new(0, containerGap)
        }),
        Padding = React.createElement(
            "UIPadding",
            {
                PaddingLeft = UDim.new(0, containerPaddingLeft),
                PaddingRight = UDim.new(0, containerPaddingRight)
            }
        ),
        Icon = React.createElement(Label, {
            Size = UDim2.new(0, iconSize, 0, iconSize),
            Image = tbl2.icon,
            ImageColor3 = var3.Color,
            Position = UDim2.new(0, 0, 0, 0),
            BackgroundTransparency = 1
        }),
        TextSection = React.createElement("Frame", {
            Size = UDim2.fromScale(0, 0),
            AutomaticSize = Enum.AutomaticSize.XY,
            BackgroundTransparency = 1,
            Position = UDim2.new(0, iconSize + containerGap, 0, 0)
        }, {
            ListLayout = React.createElement(
                "UIListLayout",
                {
                    SortOrder = Enum.SortOrder.LayoutOrder,
                    FillDirection = Enum.FillDirection.Vertical,
                    Padding = UDim.new(0, dataGap)
                }
            ),
            Number = React.createElement(GenericTextLabel, {
                Size = UDim2.fromScale(0, 0),
                AutomaticSize = Enum.AutomaticSize.XY,
                LayoutOrder = 1,
                Text = tbl2.countText,
                fluidSizing = true,
                TextWrapped = false,
                TextXAlignment = Enum.TextXAlignment.Left,
                colorStyle = colorStyle,
                fontStyle = var1.Font.Title,
                TextTruncate = Enum.TextTruncate.AtEnd,
                BackgroundTransparency = 1
            }),
            Label = React.createElement(GenericTextLabel, {
                Size = UDim2.fromScale(0, 0),
                AutomaticSize = Enum.AutomaticSize.XY,
                LayoutOrder = 2,
                Text = tbl2.labelText,
                fluidSizing = true,
                TextWrapped = false,
                TextXAlignment = Enum.TextXAlignment.Left,
                colorStyle = var4,
                fontStyle = var1.Font.CaptionHeader,
                TextTruncate = Enum.TextTruncate.AtEnd,
                BackgroundTransparency = 1
            })
        })
    })
end

return StatWidget
