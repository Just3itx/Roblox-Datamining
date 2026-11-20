-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T18:51:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local scriptParentParent = scriptParent.Parent
local scriptParentParentParent = scriptParentParent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent

local Roact = require(scriptParentParentParentParent.Roact)
local Cryo = require(scriptParentParentParentParent.Cryo)
local t = require(scriptParentParentParentParent.t)

local makeAppSlider = require(scriptParent.makeAppSlider)
local SliderTextInput = require(scriptParent.SliderTextInput)
local withStyle = require(scriptParentParentParent.Core.Style.withStyle)
local validateStyle = require(scriptParentParent.Style.Validator.validateStyle)

local function wrapStyleAndRef(arg1)
    return Roact.forwardRef(function(arg2, forwardedRef)
        return withStyle(function(style)
            local var1 = Cryo.Dictionary.join(arg2, { style = style, forwardedRef = forwardedRef })

            return Roact.createElement(arg1, var1)
        end)
    end)
end

local function makeAppOneKnobSlider(arg1)
    local var1 = Roact.PureComponent:extend("OneKnobAppSliderFor" .. arg1)
    local appSlider = makeAppSlider(arg1, false)

    var1.validateProps = t.strictInterface({
        value = t.number,
        min = t.number,
        max = t.number,
        onValueChanged = t.callback,
        onDragStart = t.optional(t.callback),
        onDragEnd = t.optional(t.callback),
        stepInterval = t.optional(t.numberPositive),
        textInputEnabled = t.optional(t.boolean),
        isDisabled = t.optional(t.boolean),
        width = t.optional(t.UDim),
        position = t.optional(t.UDim2),
        anchorPoint = t.optional(t.Vector2),
        layoutOrder = t.optional(t.integer),
        forwardedRef = t.optional(t.table),
        NextSelectionUp = t.optional(t.table),
        NextSelectionDown = t.optional(t.table),
        customTrack = t.optional(t.table),
        customKnobColorLower = t.optional(t.Color3),
        customPressedKnobShadowTransparencyLower = t.optional(t.number),
        customKnobHeight = t.optional(t.number),
        customKnobBorderSize = t.optional(t.number),
        customKnobBorderColor = t.optional(t.Color3),
        style = validateStyle,
        containerRef = t.optional(t.table)
    })

    var1.defaultProps = {
        stepInterval = 1,
        width = UDim.new(1, 0),
        textInputEnabled = false
    }

    function var1.render(arg2)
        local props = arg2.props

        local tbl1 = {
            value = props.value,
            min = props.min,
            max = props.max,
            stepInterval = props.stepInterval,
            isDisabled = props.isDisabled,
            onValueChanged = props.onValueChanged,
            onDragStartLower = props.onDragStart,
            onDragEnd = props.onDragEnd,
            style = props.style,
            forwardedRef = props.forwardedRef,
            NextSelectionUp = props.NextSelectionUp,
            NextSelectionDown = props.NextSelectionDown,
            customTrack = props.customTrack,
            customKnobHeight = props.customKnobHeight,
            customKnobBorderColor = props.customKnobBorderColor,
            customKnobBorderSize = props.customKnobBorderSize,
            customKnobColorLower = props.customKnobColorLower,
            customPressedKnobShadowTransparencyLower = props.customPressedKnobShadowTransparencyLower,
            containerRef = props.containerRef
        }

        if not props.textInputEnabled then
            tbl1.width = props.width
            tbl1.position = props.position
            tbl1.anchorPoint = props.anchorPoint
            tbl1.layoutOrder = props.layoutOrder
            return Roact.createElement(appSlider, tbl1)
        end
        tbl1.width = UDim.new(1, -68)
        return Roact.createElement("Frame", {
            BackgroundTransparency = 1,
            Size = UDim2.new(props.width.Scale, props.width.Offset, 0, 44),
            AnchorPoint = props.anchorPoint,
            LayoutOrder = props.layoutOrder,
            Position = props.position
        }, {
            Slider = Roact.createElement(appSlider, tbl1),
            TextInput = Roact.createElement(SliderTextInput, {
                position = UDim2.new(1, 0, 0.5, 0),
                anchorPoint = Vector2.new(1, 0.5),
                value = props.value,
                min = props.min,
                max = props.max,
                disabled = props.isDisabled,
                stepInterval = props.stepInterval,
                onValueChanged = props.onValueChanged
            })
        })
    end

    return wrapStyleAndRef(var1)
end

return makeAppOneKnobSlider
