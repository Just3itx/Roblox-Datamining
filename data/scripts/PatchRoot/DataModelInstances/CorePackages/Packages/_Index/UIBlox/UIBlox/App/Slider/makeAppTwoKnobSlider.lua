-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T18:51:21Z
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

local function makeAppTwoKnobSlider(arg1)
    local var1 = Roact.PureComponent:extend("TwoKnobAppSliderFor" .. arg1)
    local appSlider = makeAppSlider(arg1, true)
    local var2 = t.strictInterface({
        lowerValue = t.number,
        upperValue = t.number,
        min = t.number,
        max = t.number,
        stepInterval = t.optional(t.numberPositive),
        onValueChanged = t.callback,
        onDragStartLower = t.optional(t.callback),
        onDragStartUpper = t.optional(t.callback),
        onDragEnd = t.optional(t.callback),
        isDisabled = t.optional(t.boolean),
        width = t.optional(t.UDim),
        position = t.optional(t.UDim2),
        anchorPoint = t.optional(t.Vector2),
        layoutOrder = t.optional(t.integer),
        forwardedRef = t.optional(t.table),
        NextSelectionUp = t.optional(t.table),
        NextSelectionDown = t.optional(t.table),
        focusController = t.optional(t.table),
        style = validateStyle
    })

    var1.validateProps = t.intersection(var2, function(arg2) -- name: valueValidator
        if arg2.lowerValue > arg2.upperValue then
            return false, "The upper value must be greater than or equal to the lower"
        end

        return true
    end)
    var1.defaultProps = {
        stepInterval = 1,
        width = UDim.new(1, 0)
    }

    function var1.render(arg2)
        return Roact.createElement(appSlider, arg2.props)
    end

    return wrapStyleAndRef(var1)
end

return makeAppTwoKnobSlider
