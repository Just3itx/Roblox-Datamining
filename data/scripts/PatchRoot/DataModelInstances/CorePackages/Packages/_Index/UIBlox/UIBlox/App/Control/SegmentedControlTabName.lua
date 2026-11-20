-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T18:31:42Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local Core = scriptParentParentParent.Core
local scriptParentParentParentParent = scriptParentParentParent.Parent

local Roact = require(scriptParentParentParentParent.Roact)
local t = require(scriptParentParentParentParent.t)
local Cryo = require(scriptParentParentParentParent.Cryo)
local Foundation = require(scriptParentParentParentParent.Foundation)

local Interactable = require(Core.Control.Interactable)

local ControlState = require(Core.Control.Enum.ControlState)
local getContentStyle = require(Core.Button.getContentStyle)

local withStyle = require(scriptParentParentParent.Core.Style.withStyle)
local ImageSetComponent = require(Core.ImageSet.ImageSetComponent)
local Skeleton = Foundation.Skeleton
local IconSize = require(scriptParentParentParent.App.ImageSet.Enum.IconSize)
local getIconSize = require(scriptParentParentParent.App.ImageSet.getIconSize)
local GenericTextLabel = require(Core.Text.GenericTextLabel.GenericTextLabel)
local validateFontInfo = require(scriptParentParentParent.Core.Style.Validator.validateFontInfo)

local validateImage = require(Core.ImageSet.Validator.validateImage)

local var1 = Roact.PureComponent:extend("SegmentedControlTabName")

function var1.init(arg1)
    arg1.state = {
        controlState = ControlState.Initialize
    }

    function arg1.onStateChanged(arg2, controlState)
        arg1:setState({ controlState = controlState })

        if arg1.props.onStateChanged then
            arg1.props.onStateChanged(arg2, controlState)
        end
    end
end

local var2 = t.interface({ [ControlState.Default] = t.string })

var1.validateProps = t.interface({
    icon = t.optional(validateImage),
    text = t.optional(t.string),
    fontStyle = t.optional(validateFontInfo),
    textStateColorMap = t.optional(var2),
    iconStateColorMap = t.optional(var2),
    isDisabled = t.optional(t.boolean),
    isLoading = t.optional(t.boolean),
    onActivated = t.callback,
    onStateChanged = t.optional(t.callback),
    userInteractionEnabled = t.optional(t.boolean),
    isSelectedStyle = t.optional(t.boolean)
})

var1.defaultProps = {
    isDisabled = false,
    isLoading = false,
    isSelectedStyle = false,
    SliceCenter = Rect.new(8, 8, 9, 9),
    textStateColorMap = {
        [ControlState.Default] = "TextDefault",
        [ControlState.Hover] = "TextEmphasis"
    },
    buttonStateColorMap = {
        [ControlState.Default] = "SecondaryContent"
    }
}

function var1.render(arg1)
    return withStyle(function(arg2)
        local controlState = arg1.state.controlState

        local text = arg1.props.text
        local icon = arg1.props.icon
        local isLoading = arg1.props.isLoading
        local isDisabled = arg1.props.isDisabled

        local buttonStateColorMap = arg1.props.buttonStateColorMap
        local contentStateColorMap = arg1.props.contentStateColorMap
        local var3 = arg1.props.textStateColorMap or contentStateColorMap
        local var4 = arg1.props.iconStateColorMap or contentStateColorMap

        if isLoading then
            isDisabled = true
        end

        local var5 = if arg1.props.isDisabled then ControlState.Disabled elseif arg1.props.isSelectedStyle then ControlState.Hover else controlState
        local contentStyle = getContentStyle(buttonStateColorMap, controlState, arg2)
        local colorStyle = text and getContentStyle(var3, var5, arg2)
        local contentStyle3 = icon and getContentStyle(var4, controlState, arg2)
        local fontStyle = arg1.props.fontStyle or arg2.Font.Header2

        local var7 = isLoading and {
            isLoadingShimmer = Roact.createElement(Skeleton, { Size = UDim2.fromScale(1, 1) })
        }
            or arg1.props[Roact.Children]
            or {
                UIListLayout = Roact.createElement("UIListLayout", {
                    FillDirection = Enum.FillDirection.Horizontal,
                    VerticalAlignment = Enum.VerticalAlignment.Center,
                    HorizontalAlignment = Enum.HorizontalAlignment.Center,
                    SortOrder = Enum.SortOrder.LayoutOrder,
                    Padding = UDim.new(0, 5)
                }),
                Icon = icon
                    and Roact.createElement(ImageSetComponent.Label, {
                        Size = UDim2.new(0, getIconSize(IconSize.Medium), 0, getIconSize(IconSize.Medium)),
                        BackgroundTransparency = 1,
                        Image = icon,
                        ImageColor3 = contentStyle3.Color,
                        ImageTransparency = contentStyle3.Transparency,
                        LayoutOrder = 1
                    })
                    or nil,
                Text = text
                    and Roact.createElement(GenericTextLabel, {
                        AutomaticSize = Enum.AutomaticSize.X,
                        TextTruncate = Enum.TextTruncate.AtEnd,
                        BackgroundTransparency = 1,
                        Text = text,
                        fontStyle = fontStyle,
                        colorStyle = colorStyle,
                        LayoutOrder = 2
                    })
                    or nil
            }

        return Roact.createElement(
            Interactable,
            Cryo.Dictionary.join(arg1.props, {
                icon = Cryo.None,
                text = Cryo.None,
                buttonStateColorMap = Cryo.None,
                contentStateColorMap = Cryo.None,
                textStateColorMap = Cryo.None,
                iconStateColorMap = Cryo.None,
                onActivated = Cryo.None,
                isLoading = Cryo.None,
                isSelectedStyle = Cryo.None,
                [Roact.Children] = Cryo.None,
                isDisabled = isDisabled,
                onStateChanged = arg1.onStateChanged,
                userInteractionEnabled = arg1.props.userInteractionEnabled,
                Image = Cryo.None,
                ScaleType = Enum.ScaleType.Slice,
                ImageColor3 = contentStyle.Color,
                ImageTransparency = contentStyle.Transparency,
                BackgroundTransparency = 1,
                AutoButtonColor = false,
                [Roact.Event.Activated] = arg1.props.onActivated
            }),
            {
                ButtonContent = Roact.createElement("Frame", { Size = UDim2.new(1, 0, 1, 0), BackgroundTransparency = 1 }, var7)
            }
        )
    end)
end

return var1
