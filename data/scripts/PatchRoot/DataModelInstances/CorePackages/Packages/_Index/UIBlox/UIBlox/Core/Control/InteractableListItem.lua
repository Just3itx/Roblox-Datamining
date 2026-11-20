-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T19:20:52Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent

local Roact = require(scriptParentParentParentParent.Roact)
local Cryo = require(scriptParentParentParentParent.Cryo)

local Interactable = require(scriptParentParentParent.Core.Control.Interactable)

local SelectionMode = require(script.Parent.Enum.SelectionMode)

local var1 = Roact.PureComponent:extend("InteractableListItem")

function var1.init(arg1)
    function arg1.onStateChanged(_, arg2)
        arg1.props.setInteractableState(arg1.props.id, arg2)
    end
    function arg1.onActivated()
        local selection = arg1.props.selection
        local tbl1 = { arg1.props.id }
        if arg1.props.selectionMode == SelectionMode.Multiple then
            tbl1 = Cryo.List.filter(selection, function(id): boolean
                return id ~= arg1.props.id
            end)
            if #tbl1 == #selection then
                table.insert(tbl1, arg1.props.id)
            end
        end
        if arg1.props.onSelectionChanged then
            arg1.props.onSelectionChanged(tbl1, selection)
        end
        if arg1.props.selectionMode ~= SelectionMode.None then
            arg1.props.setSelection(tbl1)
        end
    end
end

function var1.render(arg1)
    local bool1 = Cryo.List.find(arg1.props.selection, arg1.props.id) ~= nil

    local var2, var3 = arg1.props.renderItem(arg1.props.item, arg1.props.interactableState, bool1, arg1.props.id)

    local createElement = Roact.createElement
    local var4 = Interactable
    local join = Cryo.Dictionary.join
    local tbl1 = {
        Size = arg1.props.itemSize,
        BackgroundTransparency = 1,
        BorderSizePixel = 0
    }

    local tbl2 = {
        onStateChanged = arg1.onStateChanged,
        [Roact.Event.Activated] = arg1.onActivated
    }
    return createElement(var4, join(tbl1, var3 or {}, tbl2), var2)
end

return var1
