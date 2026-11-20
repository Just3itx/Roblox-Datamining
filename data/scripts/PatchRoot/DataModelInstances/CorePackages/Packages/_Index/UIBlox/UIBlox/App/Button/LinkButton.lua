-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T18:30:47Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local App = script:FindFirstAncestor("App")
local AppParent = App.Parent
local Core = AppParent.Core
local AppParentParent = AppParent.Parent

local t = require(AppParentParent.t)
local Roact = require(AppParentParent.Roact)
local Cryo = require(AppParentParent.Cryo)

local Interactable = require(Core.Control.Interactable)

local ControlState = require(Core.Control.Enum.ControlState)
local getContentStyle = require(Core.Button.getContentStyle)
local GetTextSize = require(Core.Text.GetTextSize)
local CleanRichTextTags = require(Core.Text.CleanRichTextTags)

local withStyle = require(Core.Style.withStyle)
local GenericTextLabel = require(Core.Text.GenericTextLabel.GenericTextLabel)
local HoverButtonBackground = require(Core.Button.HoverButtonBackground)

local useCursorByType = require(App.SelectionCursor.useCursorByType)
local CursorType = require(App.SelectionCursor.CursorType)
local Focusable = require(AppParentParent.RoactGamepad).Focusable

local var1 = Roact.PureComponent:extend("LinkButton")

var1.validateProps = t.strictInterface({
    onStateChanged = t.optional(t.callback),
    isDisabled = t.optional(t.boolean),
    fontStyle = t.optional(t.string),
    colorStyleDefault = t.optional(t.string),
    colorStyleHover = t.optional(t.string),
    hoverBackgroundEnabled = t.optional(t.boolean),
    underlineAlwaysEnabled = t.optional(t.boolean),
    userInteractionEnabled = t.optional(t.boolean),
    onActivated = t.optional(t.callback),
    anchorPoint = t.optional(t.Vector2),
    layoutOrder = t.optional(t.number),
    position = t.optional(t.UDim2),
    size = t.optional(t.UDim2),
    text = t.optional(t.string),
    minPaddingX = t.optional(t.number),
    minPaddingY = t.optional(t.number),
    selectionCursorKind = t.optional(t.userdata),
    debugGetTextSize = t.optional(t.callback),
    debugControlState = t.optional(ControlState.isEnumValue),
    NextSelectionLeft = t.optional(t.table),
    NextSelectionRight = t.optional(t.table),
    NextSelectionUp = t.optional(t.table),
    NextSelectionDown = t.optional(t.table),
    buttonRef = t.optional(t.union(t.callback, t.table)),
    cursor = t.optional(t.table)
})

var1.defaultProps = {
    anchorPoint = Vector2.new(0, 0),
    layoutOrder = 0,
    position = UDim2.new(0, 0, 0, 0),
    size = UDim2.fromScale(0, 0),
    text = "",
    fontStyle = "Header2",
    colorStyleDefault = "TextLink",
    colorStyleHover = "TextLink",
    hoverBackgroundEnabled = false,
    underlineAlwaysEnabled = false,
    isDisabled = false,
    userInteractionEnabled = true,
    minPaddingX = 8,
    minPaddingY = 11,
    debugGetTextSize = GetTextSize,
    debugControlState = nil
}

function var1.init(arg1)
    arg1:setState({ controlState = ControlState.Initialize })

    function arg1.applyRichTextUnderline(arg2)
        return "<u>" .. arg2 .. "</u>"
    end

    function arg1.onStateChanged(arg2, controlState)
        arg1:setState({ controlState = controlState })

        if arg1.props.onStateChanged then
            arg1.props.onStateChanged(arg2, controlState)
        end
    end
end

function var1.render(arg1)
    return arg1:renderWithSelectionCursorProvider(nil, arg1.props.cursor)
end

function var1.renderWithSelectionCursorProvider(arg1, _, selectionImageObject)
    return withStyle(function(arg2)
        local var2 = arg1.props.debugControlState or arg1.state.controlState

        local tbl1 = {
            [ControlState.Default] = arg1.props.colorStyleDefault,
            [ControlState.Hover] = arg1.props.colorStyleHover
        }

        local colorStyle = getContentStyle(tbl1, var2, arg2)
        local fontStyle = arg2.Font[arg1.props.fontStyle]

        if arg1.props.underlineAlwaysEnabled == true and var2 == ControlState.Hover then
            colorStyle.Transparency = 0.3
        end

        local var4 = fontStyle.RelativeSize * arg2.Font.BaseSize
        local x = arg1.props.debugGetTextSize(CleanRichTextTags(arg1.props.text), var4, fontStyle.Font, Vector2.new(10000, 0)).X

        local text = arg1.props.text

        if arg1.props.underlineAlwaysEnabled or var2 == ControlState.Hover or var2 == ControlState.Pressed then
            text = arg1.applyRichTextUnderline(arg1.props.text)
        end

        local minPaddingX = arg1.props.minPaddingX
        local minPaddingY = arg1.props.minPaddingY

        local vector2 = Vector2.new(x + minPaddingX * 2, var4 + minPaddingY * 2)

        local var3 = selectionImageObject

        local createElement = Roact.createElement
        local var6 = Focusable[Interactable]
        local tbl2 = {
            AnchorPoint = arg1.props.anchorPoint,
            LayoutOrder = arg1.props.layoutOrder,
            Position = arg1.props.position,
            Size = arg1.props.size,
            isDisabled = arg1.props.isDisabled,
            onStateChanged = arg1.onStateChanged,
            userInteractionEnabled = arg1.props.userInteractionEnabled,
            BackgroundTransparency = 1,
            AutoButtonColor = false,
            SelectionImageObject = var3,
            [Roact.Event.Activated] = arg1.props.onActivated,
            [Roact.Ref] = arg1.props.buttonRef,
            NextSelectionLeft = arg1.props.NextSelectionLeft,
            NextSelectionRight = arg1.props.NextSelectionRight,
            NextSelectionUp = arg1.props.NextSelectionUp,
            NextSelectionDown = arg1.props.NextSelectionDown
        }
        local tbl3 = {
            sizeConstraint = Roact.createElement("UISizeConstraint", { MinSize = vector2 }),
            textLabel = Roact.createElement(GenericTextLabel, {
                AnchorPoint = Vector2.new(0.5, 0.5),
                Position = UDim2.fromScale(0.5, 0.5),
                BackgroundTransparency = 1,
                Text = text,
                fontStyle = fontStyle,
                colorStyle = colorStyle,
                RichText = true
            }),
            background = 0
        }

        local hoverBackgroundEnabled = arg1.props.hoverBackgroundEnabled

        if hoverBackgroundEnabled then
            if var2 == ControlState.Hover then
                hoverBackgroundEnabled = Roact.createElement(HoverButtonBackground)
            else
                hoverBackgroundEnabled = false
            end
        end

        tbl3.background = hoverBackgroundEnabled
        return createElement(var6, tbl2, tbl3)
    end)
end

function LinkButtonFunctionalWrapper(arg1)
    local cursor = useCursorByType(CursorType.RoundedRectNoInset)
    return Roact.createElement(var1, Cryo.Dictionary.join(arg1, { cursor = cursor }))
end

return LinkButtonFunctionalWrapper
