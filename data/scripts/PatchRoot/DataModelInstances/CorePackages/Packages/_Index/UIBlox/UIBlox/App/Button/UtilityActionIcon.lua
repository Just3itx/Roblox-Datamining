-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T18:30:51Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CoreGui = game:GetService("CoreGui")

local scriptParentParentParent = script.Parent.Parent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent

local React = require(scriptParentParentParentParent.React)
local Cryo = require(scriptParentParentParentParent.Cryo)
local Foundation = require(scriptParentParentParentParent.Foundation)

local Label = require(scriptParentParentParent.Core.ImageSet.ImageSetComponent).Label
local useStyle = require(scriptParentParentParent.Core.Style.useStyle)
local _ImagesTypes = require(scriptParentParentParent.App.ImageSet.ImagesTypes)
local _StyleTypes = require(scriptParentParentParent.App.Style.StyleTypes)
local withHoverTooltip = require(scriptParentParentParent.App.Dialog.TooltipV2.Controllers).withHoverTooltip
local TooltipOrientation = require(scriptParentParentParent.App.Dialog.Tooltip.Enum.TooltipOrientation)
local StateLayer = require(scriptParentParentParent.Core.Control.StateLayer)
local BadgeVariant = require(scriptParentParentParent.App.Indicator.Enum.BadgeVariant)

local migrateBadgeVariant = require(scriptParentParentParent.Utility.migrateBadgeVariant)

local StatusIndicator = Foundation.StatusIndicator

local tbl1 = {
    badgeVariant = BadgeVariant.Alert,
    tooltipTarget = CoreGui,
    disableOutset = false,
    onMedia = false
}

return React.forwardRef(function(tbl2, ref) -- name: UtilityActionIcon
    local var1 = Cryo.Dictionary.join(tbl1, tbl2)
    local anchorPoint = var1.anchorPoint
    local position = var1.position
    local layoutOrder = var1.layoutOrder
    local icon = var1.icon
    local badgeValue = var1.badgeValue
    local badgeVariant = var1.badgeVariant
    local tooltipText = var1.tooltipText
    local tooltipTarget = var1.tooltipTarget
    local disableOutset = var1.disableOutset
    local onMedia = var1.onMedia
    local onActivated = var1.onActivated

    local tokens = useStyle().Tokens

    local size1000 = tokens.Size.Size_1000
    local size900 = tokens.Size.Size_900
    local var2 = if onMedia then tokens.Color.Extended.White.White_100 else tokens.Color.Content.Emphasis

    if var1.iconColor then
        var2 = var1.iconColor
    end
    local stateStyle = if onMedia then "Darken" else "Standard"
    local vector2 = Vector2.new(0, 1)
    local uDim2 = UDim2.new(0.5, tokens.Size.Size_50, 0.5, -tokens.Size.Size_50)

    local outset = React.useMemo(function()
        if disableOutset then
            return nil
        end

        return {
            top = UDim.new(0, tokens.Size.Size_100),
            right = UDim.new(0, tokens.Size.Size_100),
            bottom = UDim.new(0, tokens.Size.Size_100),
            left = UDim.new(0, tokens.Size.Size_100)
        }
    end, { disableOutset, tokens })

    local var4 = React.useMemo(function()
        local uDim = UDim.new(0, size1000)
        if outset then
            return UDim2.new(uDim + outset.left + outset.right, uDim + outset.top + outset.bottom)
        end

        return UDim2.new(uDim, uDim)
    end, { size1000, outset })

    return withHoverTooltip({ bodyText = tooltipText }, {
        disabled = not tooltipText,
        preferredOrientation = TooltipOrientation.Bottom,
        guiTarget = tooltipTarget,
        DEBUG_useTargetDirectly = var1._DEBUG_is_plugin,
        DisplayOrder = 10
    }, function(arg1, onStateChanged)
        local createElement = React.createElement
        local str2 = "Frame"
        local tbl3 = {
            Selectable = false,
            Size = var4,
            AnchorPoint = anchorPoint,
            Position = position,
            BorderSizePixel = 0,
            BackgroundTransparency = 1,
            LayoutOrder = layoutOrder,
            [React.Change.AbsoluteSize] = arg1,
            [React.Change.AbsolutePosition] = arg1,
            ref = ref
        }
        local tbl4 = { Background = 0, StateLayer = 0, Icon = 0 }
        local element

        if onMedia then
            element = React.createElement(
                "Frame",
                {
                    Selectable = false,
                    Size = UDim2.fromOffset(size1000, size1000),
                    AnchorPoint = Vector2.new(0.5, 0.5),
                    Position = UDim2.fromScale(0.5, 0.5),
                    BorderSizePixel = 0,
                    BackgroundColor3 = tokens.Color.Extended.Black.Black_100.Color3,
                    BackgroundTransparency = 0.5,
                    ZIndex = 1
                },
                {
                    UICorner = React.createElement("UICorner", { CornerRadius = UDim.new(0, tokens.Radius.Circle) })
                }
            )
        else
            element = nil
        end

        tbl4.Background = element

        tbl4.StateLayer = React.createElement(StateLayer, {
            size = UDim2.fromOffset(size1000, size1000),
            anchorPoint = Vector2.new(0.5, 0.5),
            position = UDim2.fromScale(0.5, 0.5),
            cornerRadius = UDim.new(0, tokens.Radius.Circle),
            zIndex = 2,
            stateStyle = stateStyle,
            outset = outset,
            onStateChanged = onStateChanged,
            onActivated = onActivated
        })
        tbl4.Icon = React.createElement(Label, {
            Selectable = false,
            Size = UDim2.fromOffset(size900, size900),
            AnchorPoint = Vector2.new(0.5, 0.5),
            Position = UDim2.fromScale(0.5, 0.5),
            Image = icon,
            ImageColor3 = var2.Color3,
            ImageTransparency = var2.Transparency,
            BackgroundTransparency = 1,
            ZIndex = 3
        }, {
            UICorner = React.createElement("UICorner", { CornerRadius = UDim.new(0, tokens.Radius.Circle) }),
            Badge = if badgeValue then React.createElement(StatusIndicator, {
                Position = uDim2,
                AnchorPoint = vector2,
                value = tonumber(badgeValue),
                variant = migrateBadgeVariant(badgeVariant),
                max = if tonumber(badgeValue) then 99 else nil
            }) else nil
        }, var1.children)
        return createElement(str2, tbl3, tbl4)
    end)
end)
