-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T18:30:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParentParent = script.Parent.Parent.Parent.Parent
local scriptParentParentParentParentParent = scriptParentParentParentParent.Parent
local scriptParentParentParentParentParentParent = scriptParentParentParentParentParent.Parent

local Roact = require(scriptParentParentParentParentParentParent.Roact)
local Cryo = require(scriptParentParentParentParentParentParent.Cryo)
local RoactGamepad = require(scriptParentParentParentParentParentParent.RoactGamepad)
local t = require(scriptParentParentParentParentParentParent.t)

local CursorType = require(scriptParentParentParentParent.SelectionCursor.CursorType)
local useCursorByType = require(scriptParentParentParentParent.SelectionCursor.useCursorByType)

local SmallRadioButtonCell = require(scriptParentParentParentParentParent.App.Cell.Small.SelectionGroup.SmallRadioButtonCell)

local var1 = Roact.PureComponent:extend("SmallRadioButtonGroup")

local var2 = t.strictInterface({ text = t.string, id = t.string, isDisabled = t.optional(t.boolean) })

var1.validateProps = t.strictInterface({
    items = t.optional(t.array(t.tuple(var2))),
    selectedValue = t.optional(t.string),
    cursor = t.optional(t.table),
    onActivated = t.callback,
    layoutOrder = t.optional(t.number),
    useDefaultControlState = t.optional(t.boolean),
    NextSelectionLeft = t.optional(t.table),
    NextSelectionRight = t.optional(t.table),
    NextSelectionUp = t.optional(t.table),
    NextSelectionDown = t.optional(t.table),
    frameRef = t.optional(t.table),
    isRoactGamepadEnabled = t.optional(t.boolean)
})

var1.defaultProps = { selectedValue = nil, isRoactGamepadEnabled = true }

function var1.init(arg1)
    arg1.gamepadRefs = arg1.props.isRoactGamepadEnabled and RoactGamepad.createRefCache() or {}
end

function var1.renderButtonCell(arg1, arg2, layoutOrder, arg3)
    return Roact.createElement(if arg3 then RoactGamepad.Focusable[SmallRadioButtonCell] else SmallRadioButtonCell, {
        id = arg2.id,
        text = arg2.text,
        onActivated = arg1.props.onActivated,
        isSelected = arg1.props.selectedValue == arg2.id,
        isDisabled = arg2.isDisabled,
        layoutOrder = layoutOrder,
        useDefaultControlState = arg1.props.useDefaultControlState,
        [Roact.Ref] = arg1.gamepadRefs[layoutOrder],
        NextSelectionUp = if layoutOrder > 1 then arg1.gamepadRefs[layoutOrder - 1] or nil else nil,
        NextSelectionDown = if layoutOrder < #arg1.props.items then arg1.gamepadRefs[layoutOrder + 1] or nil else nil,
        SelectionImageObject = arg1.props.cursor
    })
end

function var1.render(arg1)
    assert(arg1.validateProps(arg1.props))

    local tbl1 = {
        layout = Roact.createElement("UIListLayout", { SortOrder = Enum.SortOrder.LayoutOrder, Padding = UDim.new(0, 1) })
    }

    local isRoactGamepadEnabled = arg1.props.isRoactGamepadEnabled
    for i, item in ipairs(arg1.props.items) do
        if not isRoactGamepadEnabled then
            arg1.gamepadRefs[i] = arg1.gamepadRefs[i] or Roact.createRef()
        end
        tbl1["smallRadioButtonCell" .. item.id] = arg1:renderButtonCell(item, i, isRoactGamepadEnabled)
    end

    local var3 = isRoactGamepadEnabled and arg1.props.items and #arg1.props.items > 0
    return Roact.createElement(if var3 then RoactGamepad.Focusable.Frame else "Frame", {
        defaultChild = if var3 then arg1.gamepadRefs[1] else nil,
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1,
        LayoutOrder = arg1.props.layoutOrder,
        NextSelectionLeft = arg1.props.NextSelectionLeft,
        NextSelectionRight = arg1.props.NextSelectionRight,
        NextSelectionDown = arg1.props.NextSelectionDown,
        NextSelectionUp = arg1.props.NextSelectionUp,
        [Roact.Ref] = arg1.props.frameRef
    }, tbl1)
end

return Roact.forwardRef(function(arg1, frameRef)
    local cursor = useCursorByType(CursorType.SelectionCell)
    return Roact.createElement(var1, Cryo.Dictionary.join(arg1, { frameRef = frameRef, cursor = cursor }))
end)
