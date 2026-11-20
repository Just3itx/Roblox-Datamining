-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T18:41:12Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local scriptParentParentParent = scriptParentParent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent
local Core = scriptParentParentParent.Core

local Roact = require(scriptParentParentParentParent.Roact)
local t = require(scriptParentParentParentParent.t)
local Cryo = require(scriptParentParentParentParent.Cryo)
local Foundation = require(scriptParentParentParentParent.Foundation)

local Interactable = require(Core.Control.Interactable)

local ControlState = require(Core.Control.Enum.ControlState)

local withStyle = require(Core.Style.withStyle)
local useStyle = require(scriptParentParentParent.Core.Style.useStyle)
local withSelectionCursorProvider = require(scriptParentParent.SelectionImage.withSelectionCursorProvider)
local useCursorByType = require(scriptParentParent.SelectionCursor.useCursorByType)
local CursorType = require(scriptParentParent.SelectionCursor.CursorType)
local CursorKind = require(scriptParentParent.SelectionImage.CursorKind)
local ImageSetComponent = require(Core.ImageSet.ImageSetComponent)
local Skeleton = Foundation.Skeleton
local IconSize = require(scriptParentParent.Constant.IconSize)
local GenericTextLabel = require(Core.Text.GenericTextLabel.GenericTextLabel)

local validateImage = require(Core.ImageSet.Validator.validateImage)
local getContentStyle = require(Core.Button.getContentStyle)
local validateTypographyInfo = require(Core.Style.Validator.validateTypographyInfo)
local validateColorInfo = require(Core.Style.Validator.validateColorInfo)

local StyleDefaults = require(script.Parent.StyleDefaults)

local var1 = Roact.PureComponent:extend("DropdownMenuCell")

local function getColorFromMap(arg1, arg2)
    local var2 = arg1[arg2] or arg1[ControlState.Default]
    return {
        Color = var2.Color,
        Transparency = var2.Transparency
    }
end

local function getButtonStyle(arg1, buttonStateColorMap, controlState, arg2, isActivated) -- Luacid: Inlined by compiler; 1 call site recovered
    local var2 = arg1(buttonStateColorMap, controlState, arg2)
    if controlState ~= ControlState.Disabled and controlState ~= ControlState.Pressed and isActivated then
        var2.Transparency = 0.5 * var2.Transparency + 0.5
    end
    return var2
end

local function getButtonContentStyle(arg1, arg2, controlState, arg3, isActivated, arg4) -- Luacid: Inlined by compiler; 2 call sites recovered
    local var2 = arg1(arg2, controlState, arg3)

    if controlState ~= ControlState.Disabled and controlState ~= ControlState.Pressed and (isActivated or not arg4) then
        var2.Transparency = 0.5 * var2.Transparency + 0.5
    end
    return var2
end

function var1.init(arg1)
    arg1:setState({ controlState = ControlState.Initialize })

    function arg1.onStateChanged(arg2, controlState)
        arg1:setState({ controlState = controlState })

        if arg1.props.onStateChanged then
            arg1.props.onStateChanged(arg2, controlState)
        end
    end
end

local var2 = t.union(t.interface({ [ControlState.Default] = t.string }), t.interface({ [ControlState.Default] = validateColorInfo }))

var1.validateProps = t.interface({
    icon = t.optional(validateImage),
    text = t.optional(t.string),
    textFont = t.optional(validateTypographyInfo),
    buttonImage = validateImage,
    buttonStateColorMap = var2,
    contentStateColorMap = var2,
    textStateColorMap = t.optional(var2),
    iconStateColorMap = t.optional(var2),
    isDisabled = t.optional(t.boolean),
    isActivated = t.optional(t.boolean),
    hasContent = t.optional(t.boolean),
    isLoading = t.optional(t.boolean),
    onActivated = t.callback,
    onStateChanged = t.optional(t.callback),
    userInteractionEnabled = t.optional(t.boolean),
    iconSize = t.optional(t.number),
    containerPadding = t.optional(t.strictInterface({ left = t.number, right = t.number })),
    iconTextSpacing = t.optional(t.number),
    border = t.optional(t.strictInterface({ cornerRadius = t.number, size = t.number })),
    enableTokenOverride = t.optional(t.boolean),
    selectionOrder = t.optional(t.number),
    selectionCursor = t.optional(t.any)
})

var1.defaultProps = {
    isDisabled = false,
    isLoading = false,
    SliceCenter = Rect.new(8, 8, 9, 9),
    iconSize = IconSize.Regular,
    containerPadding = { left = 12, right = 20 },
    iconTextSpacing = 5,
    border = { cornerRadius = 8, size = 1 },
    enableTokenOverride = false
}

function var1.render(arg1)
    return withStyle(function(arg2)
        return withSelectionCursorProvider(function(arg3)
            assert(t.table(arg2), "Style provider is missing.")

            local controlState = arg1.state.controlState

            local text = arg1.props.text
            local icon = arg1.props.icon
            local iconSize = arg1.props.iconSize
            local containerPadding = arg1.props.containerPadding
            local iconTextSpacing = arg1.props.iconTextSpacing
            local isLoading = arg1.props.isLoading
            local isDisabled = arg1.props.isDisabled

            local buttonStateColorMap = arg1.props.buttonStateColorMap
            local contentStateColorMap = arg1.props.contentStateColorMap
            local var3 = arg1.props.textStateColorMap or contentStateColorMap
            local var4 = arg1.props.iconStateColorMap or contentStateColorMap

            if isLoading then
                isDisabled = true
            end

            local selectionImageObject = arg1.props.selectionCursor or arg3 and arg3(CursorKind.RoundedRectNoInset)
            local var6 = if arg1.props.enableTokenOverride then getColorFromMap else getContentStyle
            local buttonStyle = getButtonStyle(var6, buttonStateColorMap, controlState, arg2, arg1.props.isActivated)
            local colorStyle = text and getButtonContentStyle(var6, var3, controlState, arg2, arg1.props.isActivated, arg1.props.hasContent)

            local buttonContentStyle2 = icon and getButtonContentStyle(var6, var4, controlState, arg2, arg1.props.isActivated, true)

            local buttonImage = arg1.props.buttonImage
            local fontStyle = if arg1.props.enableTokenOverride then arg1.props.textFont else arg2.Font.Header2
            local var8 = if icon ~= nil then iconSize + iconTextSpacing + containerPadding.right else containerPadding.right
            local prop

            if isLoading then
                prop = {
                    isLoadingShimmer = Roact.createElement(Skeleton, { Size = UDim2.fromScale(1, 1) })
                }
            else
                prop = arg1.props[Roact.Children]

                if not prop then
                    prop = { TextContainer = 0, IconContainer = 0 }
                    local createElement = Roact.createElement
                    local str1 = "Frame"
                    local tbl1 = {
                        Size = UDim2.fromScale(1, 1),
                        BackgroundTransparency = 1
                    }
                    local tbl2 = {
                        UIListLayout = Roact.createElement("UIListLayout", {
                            FillDirection = Enum.FillDirection.Horizontal,
                            VerticalAlignment = Enum.VerticalAlignment.Center,
                            HorizontalAlignment = Enum.HorizontalAlignment.Left,
                            SortOrder = Enum.SortOrder.LayoutOrder
                        }),
                        Padding = Roact.createElement("UIPadding", { PaddingLeft = UDim.new(0, containerPadding.left) }),
                        Text = if text then Roact.createElement(GenericTextLabel, {
                            BackgroundTransparency = 1,
                            Text = text,
                            fontStyle = fontStyle,
                            colorStyle = colorStyle,
                            LayoutOrder = 1,
                            Size = UDim2.new(1, -var8, 1, 0),
                            TextTruncate = Enum.TextTruncate.AtEnd,
                            TextXAlignment = Enum.TextXAlignment.Left,
                            TextWrapped = false
                        }) else nil
                    }
                    prop.TextContainer = createElement(str1, tbl1, tbl2)

                    local createElement2 = Roact.createElement
                    local str2 = "Frame"
                    local tbl3 = {
                        Size = UDim2.fromScale(1, 1),
                        BackgroundTransparency = 1
                    }
                    local tbl4 = {
                        UIListLayout = Roact.createElement("UIListLayout", {
                            FillDirection = Enum.FillDirection.Horizontal,
                            VerticalAlignment = Enum.VerticalAlignment.Center,
                            HorizontalAlignment = Enum.HorizontalAlignment.Right,
                            SortOrder = Enum.SortOrder.LayoutOrder
                        }),
                        Padding = Roact.createElement("UIPadding", { PaddingRight = UDim.new(0, containerPadding.right) }),
                        Icon = if icon then Roact.createElement(ImageSetComponent.Label, {
                            Size = UDim2.fromOffset(iconSize, iconSize),
                            BackgroundTransparency = 1,
                            Image = icon,
                            ImageColor3 = buttonContentStyle2.Color,
                            ImageTransparency = buttonContentStyle2.Transparency,
                            LayoutOrder = 2
                        })
                            or nil else nil
                    }
                    prop.IconContainer = createElement2(str2, tbl3, tbl4)
                end
            end

            local tbl1 = {
                isActivated = Cryo.None,
                hasContent = Cryo.None,
                icon = Cryo.None,
                text = Cryo.None,
                textFont = Cryo.None,
                buttonImage = Cryo.None,
                buttonStateColorMap = Cryo.None,
                contentStateColorMap = Cryo.None,
                textStateColorMap = Cryo.None,
                iconStateColorMap = Cryo.None,
                iconSize = Cryo.None,
                containerPadding = Cryo.None,
                iconTextSpacing = Cryo.None,
                border = Cryo.None,
                enableTokenOverride = Cryo.None,
                onActivated = Cryo.None,
                isLoading = Cryo.None,
                [Roact.Children] = Cryo.None,
                isDisabled = isDisabled,
                onStateChanged = arg1.onStateChanged,
                userInteractionEnabled = arg1.props.userInteractionEnabled,
                ScaleType = Enum.ScaleType.Slice,
                BackgroundTransparency = 1,
                AutoButtonColor = false,
                selectionCursor = Cryo.None,
                SelectionImageObject = selectionImageObject,
                SelectionOrder = arg1.props.selectionOrder,
                [Roact.Event.Activated] = arg1.props.onActivated
            }
            local var9, tbl2, var10

            if arg1.props.enableTokenOverride then
                local size = arg1.props.border.size
                var9 = UDim2.new(1, -2 * size, 1, -2 * size)
                tbl2 = {
                    UIStroke = Roact.createElement(
                        "UIStroke",
                        {
                            Color = buttonStyle.Color,
                            Transparency = buttonStyle.Transparency,
                            Thickness = size
                        }
                    ),
                    UICorner = Roact.createElement("UICorner", { CornerRadius = UDim.new(0, arg1.props.border.cornerRadius) })
                }

                var10 = Cryo.Dictionary.join(arg1.props, tbl1)
            else
                var9 = UDim2.new(1, 0, 1, 0)

                var10 = Cryo.Dictionary.join(
                    arg1.props,
                    {
                        Image = buttonImage,
                        ImageColor3 = buttonStyle.Color,
                        ImageTransparency = buttonStyle.Transparency
                    },
                    tbl1
                )
                tbl2 = {}
            end

            return Roact.createElement(Interactable, var10, {
                ButtonContent = Roact.createElement("Frame", { Size = var9, BackgroundTransparency = 1 }, Cryo.Dictionary.join(tbl2, prop))
            })
        end)
    end)
end

return function(arg1)
    local selectionCursor = useCursorByType(CursorType.RoundedRectNoInset)
    local var4 = Cryo.Dictionary.join(arg1, { selectionCursor = selectionCursor })

    if arg1.enableTokenOverride then
        local var5 = useStyle()
        var4 = Cryo.Dictionary.join(StyleDefaults.getDropdownMenuCellDefaultTokens(var5), arg1)
    end
    return Roact.createElement(var1, var4)
end
