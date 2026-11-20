-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T19:11:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local scriptParentParentParent = scriptParent.Parent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent

local Roact = require(scriptParentParentParentParent.Roact)
local Cryo = require(scriptParentParentParentParent.Cryo)
local t = require(scriptParentParentParentParent.t)

local ControlState = require(scriptParent.Enum.ControlState)
local StateTable = require(scriptParentParentParent.StateTable.StateTable)

local var1 = Roact.PureComponent:extend("Controllable")

function var1.init(arg1)
    arg1.isMounted = false
    local initialize = ControlState.Initialize
    arg1.state = { currentState = initialize }

    local str1 = string.format("Controllable(%s)", tostring(arg1))

    function arg1.setDisabled(arg2)
        if arg2 then
            arg1.stateTable.events.Disable()
            return
        end
        arg1.stateTable.events.Enable()
    end

    local new = StateTable.new
    local tbl1 = {
        [ControlState.Initialize] = {
            Enable = {
                nextState = ControlState.Default
            },
            Disable = {
                nextState = ControlState.Disabled
            }
        },
        [ControlState.Default] = {
            OnPressed = {
                nextState = ControlState.Pressed
            },
            StartHover = {
                nextState = ControlState.Hover
            },
            OnSelectionGained = {
                nextState = ControlState.Selected
            },
            Disable = {
                nextState = ControlState.Disabled
            }
        },
        [ControlState.Hover] = {
            OnSelectionGained = {
                nextState = ControlState.Selected
            },
            OnPressed = {
                nextState = ControlState.Pressed
            },
            EndHover = {
                nextState = ControlState.Default
            },
            Disable = {
                nextState = ControlState.Disabled
            }
        },
        [ControlState.Pressed] = {
            OnSelectionGained = {
                nextState = ControlState.SelectedPressed
            },
            OnReleased = {
                nextState = ControlState.Default
            },
            OnReleasedHover = {
                nextState = ControlState.Hover
            },
            Disable = {
                nextState = ControlState.Disabled
            }
        },
        [ControlState.Selected] = {
            OnSelectionLost = {
                nextState = ControlState.Default
            },
            OnPressed = {
                nextState = ControlState.SelectedPressed
            },
            Disable = {
                nextState = ControlState.Disabled
            }
        },
        [ControlState.SelectedPressed] = {
            OnSelectionLost = {
                nextState = ControlState.Default
            },
            OnReleased = {
                nextState = ControlState.Selected
            },
            Disable = {
                nextState = ControlState.Disabled
            }
        },
        [ControlState.Disabled] = {
            Enable = {
                nextState = ControlState.Default
            }
        }
    }
    arg1.stateTable = new(str1, initialize, {}, tbl1)

    arg1.stateTable:onStateChange(function(arg2, currentState)
        arg1:setState({ currentState = currentState })

        if arg1.props.onStateChanged then
            arg1.props.onStateChanged(arg2, currentState)
        end
    end)
end

var1.validateProps = t.strictInterface({
    controlComponent = t.strictInterface(
        {
            component = t.union(t.callback, t.string, t.table),
            props = t.optional(t.table),
            children = t.optional(t.table)
        }
    ),
    onStateChanged = t.callback,
    isDisabled = t.optional(t.boolean),
    userInteractionEnabled = t.optional(t.boolean)
})

var1.defaultProps = { userInteractionEnabled = true, isDisabled = false }

function var1.render(arg1)
    local controlComponent = arg1.props.controlComponent
    local userInteractionEnabled = arg1.props.userInteractionEnabled

    if arg1.state.currentState == ControlState.Initialize then
        return nil
    end

    local selectable = controlComponent.props and controlComponent.props.Selectable
    if selectable == nil then
        selectable = true
    end

    local join = Cryo.Dictionary.join
    local props = arg1.props
    local var2 = controlComponent.props or {}
    local tbl1 = {
        Selectable = selectable,
        Active = not arg1.props.isDisabled
    }

    tbl1[Roact.Event.MouseEnter] = function(...)
        if not userInteractionEnabled then
            return nil
        end
        arg1.stateTable.events.StartHover()
        if controlComponent.props[Roact.Event.MouseEnter] ~= nil then
            return controlComponent.props[Roact.Event.MouseEnter](...)
        end
        return nil
    end
    tbl1[Roact.Event.MouseLeave] = function(...)
        if not userInteractionEnabled then
            return nil
        end
        arg1.stateTable.events.EndHover()
        if controlComponent.props[Roact.Event.MouseLeave] ~= nil then
            return controlComponent.props[Roact.Event.MouseLeave](...)
        end
        return nil
    end
    tbl1[Roact.Event.InputBegan] = function(...)
        if not userInteractionEnabled then
            return nil
        end
        local select = select
        local var3 = select(2, ...)

        if var3.UserInputType == Enum.UserInputType.MouseButton1
            or var3.UserInputType == Enum.UserInputType.Touch
            or var3.KeyCode == Enum.KeyCode.ButtonA
        then
            arg1.stateTable.events.OnPressed()
        end
        if controlComponent.props[Roact.Event.InputBegan] ~= nil then
            return controlComponent.props[Roact.Event.InputBegan](...)
        end
        return nil
    end
    tbl1[Roact.Event.InputEnded] = function(...)
        if not userInteractionEnabled then
            return nil
        end
        local select = select
        local var3 = select(2, ...)
        if var3.UserInputType == Enum.UserInputType.MouseButton1 then
            arg1.stateTable.events.OnReleasedHover()
        elseif var3.UserInputType == Enum.UserInputType.Touch
            or var3.KeyCode == Enum.KeyCode.ButtonA
            or var3.UserInputType == Enum.UserInputType.MouseMovement
        then
            arg1.stateTable.events.OnReleased()
        end
        if controlComponent.props[Roact.Event.InputEnded] ~= nil then
            return controlComponent.props[Roact.Event.InputEnded](...)
        end
        return nil
    end
    tbl1[Roact.Event.SelectionGained] = function(...)
        if not userInteractionEnabled then
            return nil
        end
        arg1.stateTable.events.OnSelectionGained()
        if controlComponent.props[Roact.Event.SelectionGained] ~= nil then
            return controlComponent.props[Roact.Event.SelectionGained](...)
        end
        return nil
    end
    tbl1[Roact.Event.SelectionLost] = function(...)
        if not userInteractionEnabled then
            return nil
        end
        arg1.stateTable.events.OnSelectionLost()
        if controlComponent.props[Roact.Event.SelectionLost] ~= nil then
            return controlComponent.props[Roact.Event.SelectionLost](...)
        end
        return nil
    end
    tbl1[Roact.Event.Activated] = function(...)
        if not userInteractionEnabled then
            return nil
        elseif controlComponent.props[Roact.Event.Activated] and arg1.state.currentState ~= ControlState.Disabled and arg1.isMounted then
            return controlComponent.props[Roact.Event.Activated](...)
        end

        return nil
    end
    tbl1[Roact.Ref] = controlComponent.props.forwardedRef

    tbl1.forwardedRef = Cryo.None
    tbl1.userInteractionEnabled = Cryo.None
    tbl1.isDisabled = Cryo.None
    tbl1.onStateChanged = Cryo.None
    tbl1[Roact.Children] = Cryo.None
    tbl1.controlComponent = Cryo.None
    local var3 = join(props, var2, tbl1)

    return Roact.createElement(controlComponent.component, var3, controlComponent.children)
end

function var1.didMount(arg1)
    arg1.isMounted = true
    arg1.setDisabled(arg1.props.isDisabled)
end

function var1.didUpdate(arg1, arg2)
    if arg1.props.isDisabled ~= arg2.isDisabled then
        arg1.setDisabled(arg1.props.isDisabled)
    end
end

function var1.willUnmount(arg1)
    arg1.isMounted = false
end

return var1
