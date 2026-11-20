-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T18:40:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParentParent = script.Parent.Parent.Parent.Parent
local UIBlox = scriptParentParentParentParent.UIBlox

local Roact = require(scriptParentParentParentParent.Roact)
local RoactGamepad = require(scriptParentParentParentParent.RoactGamepad)
local t = require(scriptParentParentParentParent.t)
local RadioButton = require(script.Parent.RadioButton)
local Cryo = require(scriptParentParentParentParent.Cryo)

local useCursorByType = require(UIBlox.App.SelectionCursor.useCursorByType)
local CursorType = require(UIBlox.App.SelectionCursor.CursorType)

local var1 = Roact.PureComponent:extend("RadioButtonList")

local var2 = t.strictInterface({ label = t.string, isDisabled = t.optional(t.boolean) })

var1.validateProps = t.strictInterface({
    radioButtons = t.array(t.union(t.string, var2)),
    onActivated = t.callback,
    elementSize = t.UDim2,
    initialValue = t.optional(t.number),
    currentValue = t.optional(t.number),
    layoutOrder = t.optional(t.number),
    padding = t.optional(t.UDim),
    automaticSize = t.optional(t.boolean),
    cursor = t.table,
    NextSelectionLeft = t.optional(t.table),
    NextSelectionRight = t.optional(t.table),
    NextSelectionUp = t.optional(t.table),
    NextSelectionDown = t.optional(t.table),
    forwardRef = t.optional(t.table),
    isRoactGamepadEnabled = t.optional(t.boolean)
})

var1.defaultProps = { isRoactGamepadEnabled = true }

function var1.init(arg1)
    arg1.state = {
        currentValue = arg1.props.initialValue or 0
    }

    local disabledIndices = ({})
    for i, radioButton in ipairs(arg1.props.radioButtons) do
        local isDisabled = type(radioButton) == "table" and (radioButton.isDisabled or false)
        disabledIndices[i] = isDisabled
    end
    arg1.state.disabledIndices = disabledIndices

    function arg1.doLogic(currentValue)
        if arg1.state.disabledIndices[currentValue] then
            return
        end
        arg1:setState({ currentValue = currentValue })

        arg1.props.onActivated(currentValue)
    end

    arg1.gamepadRefs = arg1.props.isRoactGamepadEnabled and RoactGamepad.createRefCache() or {}
end

function var1.renderWithProviders(arg1, _, selectionImageObject)
    local tbl1 = {
        layout = Roact.createElement("UIListLayout", { SortOrder = Enum.SortOrder.LayoutOrder, Padding = arg1.props.padding })
    }

    for i, radioButton in ipairs(arg1.props.radioButtons) do
        if not arg1.props.isRoactGamepadEnabled then
            arg1.gamepadRefs[i] = arg1.gamepadRefs[i] or Roact.createRef()
        end

        local var3 = "RadioButton" .. i
        local createElement = Roact.createElement
        local var4 = if arg1.props.isRoactGamepadEnabled then RoactGamepad.Focusable[RadioButton] else RadioButton
        local tbl2 = {}
        if type(radioButton) == "table" then
            radioButton = radioButton.label or radioButton
        end

        tbl2.text = radioButton
        tbl2.isSelected = if arg1.props.currentValue ~= nil then i == arg1.props.currentValue else i == arg1.state.currentValue

        tbl2.isDisabled = arg1.state.disabledIndices[i]
        tbl2.onActivated = arg1.doLogic
        tbl2.size = arg1.props.elementSize
        tbl2.layoutOrder = i
        tbl2.id = i
        tbl2.isRoactGamepadEnabled = arg1.props.isRoactGamepadEnabled
        tbl2[Roact.Ref] = arg1.gamepadRefs[i]
        tbl2.NextSelectionUp = if i > 1 then arg1.gamepadRefs[i - 1] or nil else nil
        tbl2.NextSelectionDown = if i < #arg1.props.radioButtons then arg1.gamepadRefs[i + 1] or nil else nil
        tbl2.SelectionImageObject = selectionImageObject

        local tbl3 = if arg1.props.isRoactGamepadEnabled then {
            OnActivatedButton = RoactGamepad.Input.onBegin(Enum.KeyCode.ButtonA, function()
                arg1.doLogic(i)
            end)
        } else nil

        tbl2.inputBindings = tbl3
        tbl1[var3] = createElement(var4, tbl2)
    end

    return Roact.createElement(if arg1.props.isRoactGamepadEnabled then RoactGamepad.Focusable.Frame else "Frame", {
        Size = if arg1.props.automaticSize then UDim2.fromScale(1, 0) else UDim2.fromScale(1, 1),
        AutomaticSize = if arg1.props.automaticSize then Enum.AutomaticSize.Y else nil,
        BackgroundTransparency = 1,
        LayoutOrder = arg1.props.layoutOrder,
        [Roact.Ref] = arg1.props.forwardRef,
        NextSelectionLeft = arg1.props.NextSelectionLeft,
        NextSelectionRight = arg1.props.NextSelectionRight,
        NextSelectionDown = arg1.props.NextSelectionDown,
        NextSelectionUp = arg1.props.NextSelectionUp
    }, tbl1)
end

function var1.render(arg1)
    return arg1:renderWithProviders(nil, arg1.props.cursor)
end

return Roact.forwardRef(function(arg1, forwardRef)
    local cursor = useCursorByType(CursorType.RoundedRect)
    return Roact.createElement(var1, Cryo.Dictionary.join(arg1, { forwardRef = forwardRef, cursor = cursor }))
end)
