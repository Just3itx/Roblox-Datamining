-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T18:50:47Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local scriptParentParentParentParent = scriptParentParent.Parent.Parent
local scriptParentParentParentParentParent = scriptParentParentParentParent.Parent

local React = require(scriptParentParentParentParentParent.React)
local Object = require(scriptParentParentParentParentParent.LuauPolyfill).Object

local useStyle = require(scriptParentParentParentParent.Core.Style.useStyle)
local Label = require(scriptParentParentParentParent.Core.ImageSet.ImageSetComponent).Label
local GenericTextLabel = require(scriptParentParentParentParent.Core.Text.GenericTextLabel.GenericTextLabel)
local Placement = require(scriptParentParent.Enum.Placement)
local ControlState = require(scriptParentParentParentParent.Core.Control.Enum.ControlState)
local IconSize = require(scriptParentParentParentParent.App.ImageSet.Enum.IconSize)
local getIconSize = require(scriptParentParentParentParent.App.ImageSet.getIconSize)

local HorizontalContainer = require(script.Parent.HorizontalContainer)

local _Types = require(script.Parent.Types)

local Constants = require(script.Parent.Constants)

local tbl1 = {
    selected = false,
    controlState = ControlState.Default,
    padding = {
        left = Constants.ICON_TAB_ITEM_PADDING_LEFT,
        right = Constants.ICON_TAB_ITEM_PADDING_RIGHT
    }
}

local function IconTab(tbl2)
    local var1 = Object.assign({}, tbl1, tbl2)
    local item = var1.item
    local pressed = var1.controlState == ControlState.SelectedPressed
    local selected = var1.selected
    local var2 = useStyle()
    local var3 = if selected then var2.Tokens.Color.Content.Emphasis else var2.Tokens.Color.Content.Default
    local iconSize = getIconSize(IconSize.Medium, var2)
    local yOffset = Constants.ICON_TAB_HEIGHT - Constants.ICON_TAB_PADDING * 2
    assert(item.icon == nil or item.iconComponent == nil, "icon or iconComponent cannot be assigned at same time")
    local spacing = if item.icon == nil and item.iconComponent == nil then 0 else Constants.ICON_TAB_ITEM_ICON_TITLE_SPACING

    local var5 = HorizontalContainer
    local tbl3 = {
        size = UDim2.new(0, 0, 0, Constants.ICON_TAB_HEIGHT),
        automaticSize = Enum.AutomaticSize.X,
        roundedBackgroundSize = UDim2.new(1, -(Constants.ICON_TAB_PADDING * 2), 0, yOffset),
        roundedBackgroundPosition = UDim2.fromOffset(Constants.ICON_TAB_PADDING, Constants.ICON_TAB_PADDING),
        roundedBackgroundColor = var2.Theme.Divider.Color,
        roundedBackgroundTransparency = Constants.ICON_TAB_SELECTED_TRANSPARENCY,
        spacing = spacing,
        padding = var1.padding,
        showRoundedBackground = if item.showRoundedBackground == nil then selected else item.showRoundedBackground,
        showOverlay = if item.showOverlay == nil then pressed else item.showOverlay
    }
    local tbl4 = { Icon = 0, Title = 0 }
    local element

    if item.icon ~= nil then
        element = React.createElement(Label, {
            Size = UDim2.new(0, iconSize, 0, iconSize),
            LayoutOrder = 1,
            Image = item.icon,
            BackgroundTransparency = 1,
            ScaleType = Enum.ScaleType.Fit,
            ImageColor3 = var3.Color3,
            ImageTransparency = var3.Transparency
        })
    elseif item.iconComponent == nil then
        element = nil
    else
        element = React.createElement(
            "Frame",
            {
                Size = UDim2.new(0, iconSize, 0, iconSize),
                BackgroundTransparency = 1,
                LayoutOrder = 1
            },
            React.createElement(
                item.iconComponent,
                {
                    placement = Placement.Bottom,
                    selected = selected,
                    pressed = pressed,
                    hovered = false
                }
            )
        )
    end

    tbl4.Icon = element

    tbl4.Title = React.createElement(GenericTextLabel, {
        LayoutOrder = 2,
        Size = UDim2.new(0, 0, 1, 0),
        AutomaticSize = Enum.AutomaticSize.X,
        Text = item.title,
        fluidSizing = false,
        TextWrapped = true,
        TextXAlignment = Enum.TextXAlignment.Left,
        colorStyle = {
            Color = if selected then var2.Theme.TextEmphasis.Color else var2.Theme.TextDefault.Color,
            Transparency = 0
        },
        fontStyle = var2.Tokens.Typography.HeadingSmall,
        TextTruncate = Enum.TextTruncate.AtEnd,
        BackgroundTransparency = 1
    })
    return var5(tbl3, tbl4)
end

return IconTab
