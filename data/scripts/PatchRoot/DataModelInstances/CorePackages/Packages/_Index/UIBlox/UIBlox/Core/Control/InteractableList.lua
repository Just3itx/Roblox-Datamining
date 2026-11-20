-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T19:20:51Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent

local Roact = require(scriptParentParentParentParent.Roact)
local t = require(scriptParentParentParentParent.t)
local Cryo = require(scriptParentParentParentParent.Cryo)

local bindingValidator = require(scriptParentParentParent.Core.Utility.bindingValidator)
local ControlState = require(scriptParentParentParent.Core.Control.Enum.ControlState)

local InteractableListItem = require(script.Parent.InteractableListItem)
local SelectionMode = require(script.Parent.Enum.SelectionMode)

local var1 = Roact.PureComponent:extend("InteractableList")

var1.validateProps = t.strictInterface({
    itemList = t.table,
    renderItem = t.callback,
    renderList = t.optional(t.callback),
    selection = t.optional(t.table),
    selectionMode = t.optional(SelectionMode.isEnumValue),
    onSelectionChanged = t.optional(t.callback),
    size = t.optional(t.UDim2),
    position = t.optional(t.UDim2),
    layoutOrder = t.optional(t.integer),
    padding = t.optional(t.UDim),
    fillDirection = t.optional(t.enum(Enum.FillDirection)),
    horizontalAlignment = t.optional(t.enum(Enum.HorizontalAlignment)),
    verticalAlignment = t.optional(t.enum(Enum.VerticalAlignment)),
    sortOrder = t.optional(t.enum(Enum.SortOrder)),
    automaticSize = t.optional(t.enum(Enum.AutomaticSize)),
    itemSize = t.optional(t.union(t.UDim2, bindingValidator(t.UDim2)))
})

var1.defaultProps = {
    renderList = function(arg1, arg2, arg3)
        local tbl1 = { Roact.createElement("UIListLayout", {
                Padding = arg3.padding,
                FillDirection = arg3.fillDirection,
                HorizontalAlignment = arg3.horizontalAlignment,
                VerticalAlignment = arg3.verticalAlignment,
                SortOrder = arg3.sortOrder,
                key = "$layout"
            }) }

        for k in pairs(arg1) do
            table.insert(tbl1, arg2(k))
        end
        return Roact.createElement("Frame", {
            Size = arg3.size,
            Position = arg3.position,
            BackgroundTransparency = 1,
            AutomaticSize = arg3.automaticSize,
            BorderSizePixel = 0
        }, tbl1)
    end,
    size = UDim2.fromScale(1, 1),
    itemSize = UDim2.fromScale(1, 1),
    selectionMode = SelectionMode.Single
}

function var1.init(arg1)
    local tbl1 = {
        interactable = {},
        selection = {}
    }
    if arg1.props.selectionMode == SelectionMode.Single then
        local var2 = next(arg1.props.itemList)
        if var2 ~= nil then
            tbl1.selection = { var2 }
        end
    end
    arg1:setState(tbl1)

    function arg1.setInteractableState(arg2, arg3)
        arg1:setState(function(arg4)
            return {
                interactable = Cryo.Dictionary.join(arg4.interactable, { [arg2] = arg3 })
            }
        end)
    end

    function arg1.setSelection(selection)
        arg1:setState({ selection = selection })
    end
end

function var1.getSelection(arg1)
    if arg1.props.selection then
        return arg1.props.selection
    end
    if arg1.props.selectionMode == SelectionMode.None then
        return {}
    end
    local var2 = Cryo.List.filter(arg1.state.selection, function(arg2): boolean
        return arg1.props.itemList[arg2] ~= nil
    end)
    if arg1.props.selectionMode ~= SelectionMode.Single then
        return var2
    end

    local var3 = var2[#var2]
    if var3 == nil then
        var3 = next(arg1.props.itemList)
    end
    return if var3 == nil then {} else { var3 }
end

function var1.didMount(arg1)
    if arg1.props.selection == nil and arg1.props.onSelectionChanged then
        arg1.props.onSelectionChanged(arg1:getSelection())
    end
end

function var1.render(arg1)
    return arg1.props.renderList(arg1.props.itemList, function(id)
        local interactableState = arg1.state.interactable[id] or ControlState.Default
        local selection = arg1:getSelection()

        return Roact.createElement(InteractableListItem, {
            id = id,
            item = arg1.props.itemList[id],
            interactableState = interactableState,
            selection = selection,
            renderItem = arg1.props.renderItem,
            itemSize = arg1.props.itemList[id] and arg1.props.itemList[id].itemSize or arg1.props.itemSize,
            selectionMode = arg1.props.selectionMode,
            onSelectionChanged = arg1.props.onSelectionChanged,
            setInteractableState = arg1.setInteractableState,
            setSelection = arg1.setSelection,
            key = tostring(id)
        })
    end, arg1.props)
end

return var1
