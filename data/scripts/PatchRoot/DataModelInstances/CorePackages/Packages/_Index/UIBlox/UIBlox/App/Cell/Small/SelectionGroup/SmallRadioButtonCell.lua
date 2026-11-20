-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T18:30:52Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParentParentParentParent = script.Parent.Parent.Parent.Parent.Parent.Parent

local Roact = require(scriptParentParentParentParentParentParent.Roact)
local Cryo = require(scriptParentParentParentParentParentParent.Cryo)
local t = require(scriptParentParentParentParentParentParent.t)
local Images = require(scriptParentParentParentParentParentParent.UIBlox.App.ImageSet.Images)

local GenericSelectionCell = require(scriptParentParentParentParentParentParent.UIBlox.Core.Cell.GenericSelectionCell)

local component_assetsCircle_24_stroke_1 = Images["component_assets/circle_24_stroke_1"]
local component_assetsCircle_16 = Images["component_assets/circle_16"]

local var1 = Roact.PureComponent:extend("SmallRadioButtonCell")

var1.validateProps = t.strictInterface({
    id = t.string,
    text = t.optional(t.string),
    onActivated = t.optional(t.callback),
    isSelected = t.optional(t.boolean),
    isDisabled = t.optional(t.boolean),
    useDefaultControlState = t.optional(t.boolean),
    layoutOrder = t.optional(t.number),
    controlRef = t.optional(t.table),
    NextSelectionLeft = t.optional(t.table),
    NextSelectionRight = t.optional(t.table),
    NextSelectionUp = t.optional(t.table),
    NextSelectionDown = t.optional(t.table),
    SelectionImageObject = t.optional(t.table)
})

var1.defaultProps = { text = "", isSelected = false }

function var1.init(arg1)
    function arg1.onSetValue()
        arg1.props.onActivated(arg1.props.id)
    end
end

function var1.render(arg1)
    assert(arg1.validateProps(arg1.props))

    local createElement = Roact.createElement
    local tbl1 = {
        Size = UDim2.new(1, 0, 0, 56),
        BorderSizePixel = 0,
        BackgroundTransparency = 1,
        LayoutOrder = arg1.props.layoutOrder
    }
    local tbl2 = {
        GenericSelectionCell = Roact.createElement(GenericSelectionCell, {
            isSelected = arg1.props.isSelected,
            isDisabled = arg1.props.isDisabled,
            defaultImage = component_assetsCircle_24_stroke_1,
            selectedImage = component_assetsCircle_16,
            defaultImageSize = 24,
            selectedImageSize = 16,
            text = arg1.props.text,
            onActivated = arg1.onSetValue,
            useDefaultControlState = arg1.props.useDefaultControlState,
            [Roact.Ref] = arg1.props.controlRef,
            NextSelectionUp = arg1.props.NextSelectionUp,
            NextSelectionDown = arg1.props.NextSelectionDown,
            NextSelectionLeft = arg1.props.NextSelectionLeft,
            NextSelectionRight = arg1.props.NextSelectionRight,
            SelectionImageObject = arg1.props.SelectionImageObject
        })
    }
    return createElement("Frame", tbl1, tbl2)
end

return Roact.forwardRef(function(arg1, controlRef)
    return Roact.createElement(var1, Cryo.Dictionary.join(arg1, { controlRef = controlRef }))
end)
