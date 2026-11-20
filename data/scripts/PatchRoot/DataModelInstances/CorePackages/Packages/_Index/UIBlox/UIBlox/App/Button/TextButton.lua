-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T18:30:49Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local App = script:FindFirstAncestor("App")
local AppParent = App.Parent
local Core = AppParent.Core
local AppParentParent = AppParent.Parent

local t = require(AppParentParent.t)
local Roact = require(AppParentParent.Roact)
local React = require(AppParentParent.React)
local Cryo = require(AppParentParent.Cryo)

local Interactable = require(Core.Control.Interactable)

local ControlState = require(Core.Control.Enum.ControlState)
local getContentStyle = require(Core.Button.getContentStyle)
local GetTextSize = require(Core.Text.GetTextSize)
local CleanRichTextTags = require(Core.Text.CleanRichTextTags)
local isReactTagProp = require(AppParent.Utility.isReactTagProp)
local CursorKind = require(App.SelectionImage.CursorKind)

local validateColorInfo = require(Core.Style.Validator.validateColorInfo)
local withStyle = require(Core.Style.withStyle)
local GenericTextLabel = require(Core.Text.GenericTextLabel.GenericTextLabel)

local useCursor = require(AppParent.App.SelectionCursor.useCursor)

local uDim = UDim.new(0, 8)

local var1 = Roact.PureComponent:extend("TextButton")

local strictInterface = t.strictInterface
local tbl1 = {
    [React.Tag] = isReactTagProp,
    onStateChanged = t.optional(t.callback),
    isDisabled = t.optional(t.boolean),
    fontStyle = t.optional(t.string),
    colorStyleDefault = t.optional(t.string),
    colorStyleHover = t.optional(t.string),
    hoverBackgroundEnabled = t.optional(t.boolean),
    richText = t.optional(t.boolean),
    showBackground = t.optional(t.boolean),
    backgroundColor = t.optional(validateColorInfo),
    horizontalPadding = t.optional(t.number),
    verticalPadding = t.optional(t.number),
    userInteractionEnabled = t.optional(t.boolean),
    onActivated = t.optional(t.callback),
    anchorPoint = t.optional(t.Vector2),
    layoutOrder = t.optional(t.number),
    position = t.optional(t.UDim2),
    size = t.optional(t.UDim2),
    text = t.optional(t.string),
    cursor = t.optional(t.table),
    debugGetTextSize = t.optional(t.callback),
    debugControlState = t.optional(ControlState.isEnumValue)
}
var1.validateProps = strictInterface(tbl1)

var1.defaultProps = {
    anchorPoint = Vector2.new(0, 0),
    layoutOrder = 0,
    position = UDim2.new(0, 0, 0, 0),
    size = UDim2.fromScale(0, 0),
    text = "",
    verticalPadding = 11,
    horizontalPadding = 8,
    showBackground = false,
    fontStyle = "Header2",
    colorStyleDefault = "TextEmphasis",
    colorStyleHover = "TextEmphasis",
    hoverBackgroundEnabled = true,
    richText = false,
    isDisabled = false,
    userInteractionEnabled = true,
    debugGetTextSize = GetTextSize,
    debugControlState = nil
}

function var1.init(arg1)
    arg1:setState({ controlState = ControlState.Initialize })

    function arg1.onStateChanged(arg2, controlState)
        arg1:setState({ controlState = controlState })

        if arg1.props.onStateChanged then
            arg1.props.onStateChanged(arg2, controlState)
        end
    end
end

function var1.render(arg1)
    return withStyle(function(arg2)
        return arg1:renderWithProviders(arg2, nil, nil)
    end)
end

function var1.renderWithProviders(arg1, arg2, arg3, arg4)
    local var2 = arg1.props.debugControlState or arg1.state.controlState

    local tbl2 = {
        [ControlState.Default] = arg1.props.colorStyleDefault,
        [ControlState.Hover] = arg1.props.colorStyleHover
    }

    local colorStyle = getContentStyle(tbl2, var2, arg2)
    local fontStyle = arg2.Font[arg1.props.fontStyle]

    local var4 = fontStyle.RelativeSize * arg2.Font.BaseSize
    local x = arg1.props.debugGetTextSize(
        arg1.props.richText and CleanRichTextTags(arg1.props.text) or arg1.props.text,
        var4,
        fontStyle.Font,
        Vector2.new(10000, 0)
    ).X

    local var5 = not arg1.props.showBackground and { Color = nil, Transparency = 1 } or arg1.props.backgroundColor or arg2.Theme.UIMuted

    local verticalPadding = arg1.props.verticalPadding
    local horizontalPadding = arg1.props.horizontalPadding

    local backgroundOnHover = arg2.Theme.BackgroundOnHover
    if arg1.props.hoverBackgroundEnabled and var2 == ControlState.Hover then
        var5 = var5.Color
            and {
                Color = var5.Color:Lerp(backgroundOnHover.Color, 1 - backgroundOnHover.Transparency),
                Transparency = var5.Transparency
            }
            or backgroundOnHover
    end

    return Roact.createElement(Interactable, {
        [React.Tag] = arg1.props[React.Tag],
        AnchorPoint = arg1.props.anchorPoint,
        LayoutOrder = arg1.props.layoutOrder,
        Position = arg1.props.position,
        Size = arg1.props.size,
        isDisabled = arg1.props.isDisabled,
        onStateChanged = arg1.onStateChanged,
        userInteractionEnabled = arg1.props.userInteractionEnabled,
        BackgroundColor3 = var5.Color,
        BackgroundTransparency = var5.Transparency,
        AutoButtonColor = false,
        SelectionImageObject = if arg4 then arg4(uDim) else arg3 and arg3(CursorKind.RoundedRectNoInset),
        [Roact.Event.Activated] = arg1.props.onActivated
    }, {
        corner = Roact.createElement("UICorner", { CornerRadius = uDim }),
        sizeConstraint = Roact.createElement(
            "UISizeConstraint",
            {
                MinSize = Vector2.new(x + horizontalPadding * 2, var4 + verticalPadding * 2)
            }
        ),
        textLabel = Roact.createElement(GenericTextLabel, {
            AnchorPoint = Vector2.new(0.5, 0.5),
            Position = UDim2.fromScale(0.5, 0.5),
            BackgroundTransparency = 1,
            Text = arg1.props.text,
            fontStyle = fontStyle,
            colorStyle = colorStyle,
            RichText = arg1.props.richText
        })
    })
end

local function TextButtonFunctionalWrapper(arg1)
    local cursor = useCursor(uDim)
    return Roact.createElement(var1, Cryo.Dictionary.join(arg1, { cursor = cursor }))
end

local var2 = Roact.PureComponent:extend("TextButtonOuterWrapper")

var2.validateProps = var1.validateProps

function var2.render(arg1)
    return Roact.createElement(TextButtonFunctionalWrapper, arg1.props)
end

return var2
