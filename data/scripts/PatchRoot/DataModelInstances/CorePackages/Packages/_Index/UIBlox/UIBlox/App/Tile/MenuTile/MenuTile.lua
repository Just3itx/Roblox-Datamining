-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T19:10:42Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent
local Core = scriptParentParentParentParent.Core
local scriptParentParentParentParentParent = scriptParentParentParentParent.Parent

local Otter = require(scriptParentParentParentParentParent.Otter)
local Roact = require(scriptParentParentParentParentParent.Roact)
local t = require(scriptParentParentParentParentParent.t)
local Cryo = require(scriptParentParentParentParentParent.Cryo)
local Foundation = require(scriptParentParentParentParentParent.Foundation)
local normalizeFontFace = Foundation.Utility.normalizeFontFace

local BadgeStates = require(scriptParentParentParent.Indicator.Enum.BadgeStates)
local IconSize = require(scriptParentParentParent.ImageSet.Enum.IconSize)
local getIconSize = require(scriptParentParentParent.ImageSet.getIconSize)
local BadgeVariant = require(scriptParentParentParent.Indicator.Enum.BadgeVariant)
local StatusIndicator = Foundation.StatusIndicator

local ControlState = require(Core.Control.Enum.ControlState)
local Interactable = require(Core.Control.Interactable)
local ImageSetComponent = require(Core.ImageSet.ImageSetComponent)
local validateImage = require(Core.ImageSet.Validator.validateImage)
local validateColorInfo = require(scriptParentParentParentParent.Core.Style.Validator.validateColorInfo)
local validateFontInfo = require(scriptParentParentParentParent.Core.Style.Validator.validateFontInfo)
local validateTypographyInfo = require(scriptParentParentParentParent.Core.Style.Validator.validateTypographyInfo)

local withStyle = require(scriptParentParentParentParent.Core.Style.withStyle)
local divideTransparency = require(scriptParentParentParentParent.Utility.divideTransparency)
local CursorType = require(scriptParentParentParent.SelectionCursor.CursorType)
local useCursorByType = require(scriptParentParentParent.SelectionCursor.useCursorByType)
local GetTextSize = require(scriptParentParentParentParent.Core.Text.GetTextSize)

local migrateBadgeVariant = require(scriptParentParentParentParent.Utility.migrateBadgeVariant)

local uDim = UDim.new(0, 12)
local uDim2 = UDim.new(0, 8)

local tbl1 = { frequency = 6, dampingRatio = 1 }

local var1 = Roact.Component:extend("MenuTile")

var1.defaultProps = {
    size = UDim2.fromScale(1, 1),
    styleProps = {}
}

var1.validateProps = t.strictInterface({
    size = t.optional(t.UDim2),
    position = t.optional(t.UDim2),
    layoutOrder = t.optional(t.number),
    cursor = t.table,
    badgeValue = t.optional(t.union(t.string, t.number, BadgeStates.isEnumValue)),
    badgeVariant = t.optional(BadgeVariant.isEnumValue),
    icon = t.optional(validateImage),
    title = t.string,
    onActivated = t.callback,
    styleProps = t.optional(
        t.strictInterface({
            iconStyle = t.optional(validateColorInfo),
            iconSize = t.optional(IconSize.isEnumValue),
            titleStyle = t.optional(validateColorInfo),
            titleFont = t.optional(t.union(validateFontInfo, validateTypographyInfo))
        })
    )
})
local function withProviders(arg1, cursor)
    return withStyle(function(arg2)
        return arg1(arg2, nil, cursor)
    end)
end

local function getStyleProps(styleProps, arg1)
    local theme = arg1.Theme
    local font = arg1.Font
    local iconSize = if styleProps.iconSize then getIconSize(styleProps.iconSize, arg1) else getIconSize(IconSize.Large)
    return {
        iconStyle = styleProps.iconStyle or theme.IconDefault,
        iconSize = iconSize,
        titleStyle = styleProps.titleStyle or theme.TextDefault,
        titleFont = styleProps.titleFont or font.SubHeader1
    }
end

function var1.init(arg1)
    local hoverTransparency, updateHoverTransparency = Roact.createBinding(1)
    arg1.hoverTransparency = hoverTransparency
    arg1.updateHoverTransparency = updateHoverTransparency
    arg1.hoverTransparencyMotor = Otter.createSingleMotor(1)
    arg1.hoverTransparencyMotor:onStep(arg1.updateHoverTransparency)
    arg1.hoverTransparencyMotor:onComplete(function(arg2)
        if arg2 == 1 then
            arg1:setState({ showHoverMask = false })
        end
    end)

    arg1:setState({ backgroundTransparency = 0, iconTransparency = 0, titleTransparency = 0, showHoverMask = false })
end

function var1.render(arg1)
    local backgroundTransparency = arg1.state.backgroundTransparency
    local iconTransparency = arg1.state.iconTransparency
    local titleTransparency = arg1.state.titleTransparency

    local badgeValue = arg1.props.badgeValue
    local icon = arg1.props.icon
    local layoutOrder = arg1.props.layoutOrder
    local onActivated = arg1.props.onActivated
    local position = arg1.props.position
    local size = arg1.props.size
    local title = arg1.props.title

    return withProviders(function(arg2, _, selectionImageObject)
        local theme = arg2.Theme

        local styleProps = getStyleProps(arg1.props.styleProps, arg2)

        local backgroundUiDefault = theme.BackgroundUIDefault
        local backgroundOnHover = theme.BackgroundOnHover

        local iconStyle = styleProps.iconStyle
        local iconSize = styleProps.iconSize

        local titleStyle = styleProps.titleStyle
        local titleFont = styleProps.titleFont
        local y = if titleFont.RelativeSize then titleFont.RelativeSize * arg2.Font.BaseSize else titleFont.FontSize
        local textSizeY = GetTextSize(title, y, titleFont.Font, Vector2.new(100, y)).Y

        local function onStateChanged(_, arg3)
            if arg3 == ControlState.Hover then
                arg1:setState({
                    backgroundTransparency = backgroundUiDefault.Transparency,
                    iconTransparency = iconStyle.Transparency,
                    titleTransparency = titleStyle.Transparency,
                    showHoverMask = true
                })

                arg1.hoverTransparencyMotor:setGoal(Otter.spring(backgroundOnHover.Transparency, tbl1))
                return
            end

            if arg3 == ControlState.Default then
                arg1:setState({
                    backgroundTransparency = backgroundUiDefault.Transparency,
                    iconTransparency = iconStyle.Transparency,
                    titleTransparency = titleStyle.Transparency
                })
                arg1.hoverTransparencyMotor:setGoal(Otter.spring(1, tbl1))
                return
            end

            if arg3 ~= ControlState.Pressed then
                return
            end

            arg1:setState({
                backgroundTransparency = divideTransparency(backgroundUiDefault.Transparency, 2),
                iconTransparency = divideTransparency(iconStyle.Transparency, 2),
                titleTransparency = divideTransparency(titleStyle.Transparency, 2),
                showHoverMask = false
            })

            arg1.hoverTransparencyMotor:setGoal(Otter.instant(1))
        end

        return Roact.createElement(Interactable, {
            Size = size,
            Position = position,
            BackgroundTransparency = 1,
            SelectionImageObject = selectionImageObject,
            LayoutOrder = layoutOrder,
            onStateChanged = onStateChanged,
            [Roact.Event.Activated] = onActivated
        }, {
            MenuTileFrame = Roact.createElement("Frame", { BackgroundTransparency = 1, Size = size }, {
                Background = Roact.createElement(
                    "Frame",
                    {
                        BackgroundColor3 = backgroundUiDefault.Color,
                        BackgroundTransparency = backgroundTransparency,
                        BorderSizePixel = 0,
                        Size = UDim2.fromScale(1, 1),
                        ZIndex = 1
                    },
                    {
                        RoundedCornerUI = Roact.createElement("UICorner", { CornerRadius = UDim.new(0, 8) })
                    }
                ),
                HoverMask = arg1.state.showHoverMask
                    and Roact.createElement(
                        "Frame",
                        {
                            BackgroundColor3 = backgroundOnHover.Color,
                            BackgroundTransparency = arg1.hoverTransparency,
                            BorderSizePixel = 0,
                            Size = UDim2.fromScale(1, 1),
                            ZIndex = 2
                        },
                        {
                            RoundedCornerUI = Roact.createElement("UICorner", { CornerRadius = UDim.new(0, 8) })
                        }
                    ),
                IconAndTitleContainer = Roact.createElement(
                    "Frame",
                    {
                        BackgroundTransparency = 1,
                        Size = UDim2.fromScale(1, 1),
                        ZIndex = 3
                    },
                    {
                        IconAndTitleUIListLayout = Roact.createElement("UIListLayout", {
                            FillDirection = Enum.FillDirection.Vertical,
                            HorizontalAlignment = Enum.HorizontalAlignment.Center,
                            Padding = uDim,
                            VerticalAlignment = Enum.VerticalAlignment.Center
                        }),
                        IconAndTitleUIPadding = Roact.createElement(
                            "UIPadding",
                            {
                                PaddingBottom = uDim2,
                                PaddingLeft = uDim2,
                                PaddingRight = uDim2,
                                PaddingTop = uDim2 + UDim.new(0, textSizeY)
                            }
                        ),
                        Icon = icon
                            and Roact.createElement(ImageSetComponent.Label, {
                                BackgroundTransparency = 1,
                                Image = icon,
                                ImageColor3 = iconStyle.Color,
                                ImageTransparency = iconTransparency,
                                LayoutOrder = 1,
                                Size = UDim2.fromOffset(iconSize, iconSize)
                            }),
                        Title = title
                            and Roact.createElement("TextLabel", {
                                BackgroundTransparency = 1,
                                FontFace = normalizeFontFace(titleFont.Font),
                                LayoutOrder = 2,
                                Size = UDim2.new(1, 0, 0, textSizeY * 2),
                                Text = title,
                                TextColor3 = titleStyle.Color,
                                TextSize = y,
                                TextTransparency = titleTransparency,
                                TextTruncate = Enum.TextTruncate.AtEnd,
                                TextWrapped = true,
                                TextYAlignment = Enum.TextYAlignment.Top
                            })
                    }
                ),
                BadgeContainer = badgeValue
                    and Roact.createElement("Frame", {
                        BackgroundTransparency = 1,
                        Size = UDim2.fromScale(1, 1),
                        ZIndex = 4
                    }, {
                        BadgeUIListLayout = Roact.createElement("UIListLayout", {
                            FillDirection = Enum.FillDirection.Vertical,
                            HorizontalAlignment = Enum.HorizontalAlignment.Right,
                            Padding = uDim,
                            VerticalAlignment = Enum.VerticalAlignment.Top
                        }),
                        BadgeUIPadding = Roact.createElement(
                            "UIPadding",
                            {
                                PaddingBottom = uDim2,
                                PaddingLeft = uDim2,
                                PaddingRight = uDim2,
                                PaddingTop = uDim2
                            }
                        ),
                        Badge = Roact.createElement(StatusIndicator, {
                            value = tonumber(badgeValue),
                            max = if tonumber(badgeValue) then 99 else nil,
                            variant = migrateBadgeVariant(arg1.props.badgeVariant)
                        })
                    })
            })
        })
    end, arg1.props.cursor)
end

function var1.willUnmount(arg1)
    if arg1.hoverTransparencyMotor then
        arg1.hoverTransparencyMotor:destroy()
    end
end

function MenuTileFunctionalWrapper(arg1)
    local cursor = useCursorByType(CursorType.RoundedRect)

    return Roact.createElement(var1, Cryo.Dictionary.join(arg1, { cursor = cursor }))
end

return MenuTileFunctionalWrapper
