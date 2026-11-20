-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T13:10:42Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local Roact = require(scriptParentParent.Roact)
local Cryo = require(scriptParentParent.Cryo)
local t = require(scriptParentParent.t)

local FocusContext = require(script.Parent.FocusContext)
local FocusNode = require(script.Parent.FocusNode)
local getEngineInterface = require(script.Parent.getEngineInterface)

local FocusControllerInternalApi = require(script.Parent.FocusControllerInternalApi)

local tbl1 = {
    parentFocusNode = Cryo.None,
    parentNeighbors = Cryo.None,
    focusController = Cryo.None,
    onFocusGained = Cryo.None,
    onFocusLost = Cryo.None,
    onFocusChanged = Cryo.None,
    inputBindings = Cryo.None,
    innerRef = Cryo.None,
    restorePreviousChildFocus = Cryo.None,
    defaultChild = Cryo.None
}

local tbl2 = {}

local validateProps = t.intersection(
    t.interface({
        parentFocusNode = t.optional(t.table),
        focusController = t.optional(t.table),
        innerRef = t.optional(t.table),
        restorePreviousChildFocus = t.boolean,
        inputBindings = t.table,
        defaultChild = t.optional(t.table),
        onFocusGained = t.optional(t.callback),
        onFocusLost = t.optional(t.callback),
        onFocusChanged = t.optional(t.callback)
    }),
    function(arg1) -- name: checkFocusManager
        if arg1.focusController ~= nil and arg1.parentFocusNode ~= nil then
            return false, "Cannot attach a new focusController beneath an existing one"
        end

        return true
    end
)

local defaultProps = {
    restorePreviousChildFocus = false,
    inputBindings = {}
}

local function asFocusable(arg1)
    local str1 = ("Focusable(%s)"):format(tostring(arg1))

    local var2 = Roact.Component:extend(str1)

    var2.validateProps = validateProps
    var2.defaultProps = defaultProps

    function var2.init(arg2)
        arg2.focused = false
        arg2.defaultRef = Roact.createRef()

        local parentNeighbors = arg2.props.parentNeighbors or tbl2
        arg2:setState({
            focusNode = FocusNode.new(arg2.props, arg2:getRef()),
            parentNeighbors = parentNeighbors,
            neighbors = {
                NextSelectionLeft = arg2.props.NextSelectionLeft or parentNeighbors.NextSelectionLeft,
                NextSelectionRight = arg2.props.NextSelectionRight or parentNeighbors.NextSelectionRight,
                NextSelectionUp = arg2.props.NextSelectionUp or parentNeighbors.NextSelectionUp,
                NextSelectionDown = arg2.props.NextSelectionDown or parentNeighbors.NextSelectionDown
            },
            needsDescendantAddedRefocusCounter = 0,
            needsDescendantRemovedRefocusCounter = 0
        })

        function arg2.updateFocusedState(arg3)
            if not arg2.focused and arg3 then
                arg2:gainFocus()
            elseif arg2.focused and not arg3 then
                arg2:loseFocus()
            end
        end

        if not arg2:isRoot() then
            return
        end

        local bool1 = false

        function arg2.ancestryChanged(arg3)
            if not bool1 and arg3:IsDescendantOf(game) then
                bool1 = true
                arg2:getFocusControllerInternal():initialize(getEngineInterface(arg3))
            end
        end

        function arg2.ancestryChangedListener(arg3)
            arg2.ancestryChanged(arg3)

            local prop = arg2.props[Roact.Event.AncestryChanged]
            if prop ~= nil then
                prop(arg3)
            end
        end

        function arg2.refreshFocusOnDescendantAdded(arg3)
            if arg2:getFocusControllerInternal():needsDescendantAddedRefocus() then
                arg2:setState(function(arg4)
                    return {
                        needsDescendantAddedRefocusCounter = arg4.needsDescendantAddedRefocusCounter + 1
                    }
                end)
            end

            local prop = arg2.props[Roact.Event.DescendantAdded]
            if prop ~= nil then
                prop(arg3)
            end
        end

        function arg2.refreshFocusOnDescendantRemoved(arg3)
            if arg2:getFocusControllerInternal():needsDescendantRemovedRefocus() then
                arg2:setState(function(arg4)
                    return {
                        needsDescendantRemovedRefocusCounter = arg4.needsDescendantRemovedRefocusCounter + 1
                    }
                end)
            end

            local prop = arg2.props[Roact.Event.DescendantRemoving]
            if prop ~= nil then
                prop(arg3)
            end
        end
    end

    function var2.getDerivedStateFromProps(arg2, arg3): {neighbors: {NextSelectionDown: any, NextSelectionLeft: any, NextSelectionRight: any, NextSelectionUp: any}, parentNeighbors: any}?
        local var3 = arg3.neighbors or tbl2
        local parentNeighbors = arg2.parentNeighbors or tbl2
        local nextSelectionLeft = arg2.NextSelectionLeft or parentNeighbors.NextSelectionLeft
        local nextSelectionRight = arg2.NextSelectionRight or parentNeighbors.NextSelectionRight
        local nextSelectionUp = arg2.NextSelectionUp or parentNeighbors.NextSelectionUp
        local nextSelectionDown = arg2.NextSelectionDown or parentNeighbors.NextSelectionDown

        return if nextSelectionLeft == var3.NextSelectionLeft
            and nextSelectionRight == var3.NextSelectionRight
            and nextSelectionDown == var3.NextSelectionDown
            and nextSelectionUp == var3.NextSelectionUp then nil else {
            parentNeighbors = parentNeighbors,
            neighbors = {
                NextSelectionLeft = nextSelectionLeft,
                NextSelectionRight = nextSelectionRight,
                NextSelectionUp = nextSelectionUp,
                NextSelectionDown = nextSelectionDown
            }
        }
    end

    function var2.gainFocus(arg2)
        arg2.focused = true

        if arg2.props.onFocusGained ~= nil then
            arg2.props.onFocusGained()
        end

        if arg2.props.onFocusChanged ~= nil then
            arg2.props.onFocusChanged(true)
        end
    end

    function var2.loseFocus(arg2)
        arg2.focused = false

        if arg2.props.onFocusLost ~= nil then
            arg2.props.onFocusLost()
        end

        if arg2.props.onFocusChanged ~= nil then
            arg2.props.onFocusChanged(false)
        end
    end

    function var2.isRoot(arg2): boolean
        return not (arg2.props.focusController == nil) and arg2.props.parentFocusNode == nil
    end

    function var2.getFocusControllerInternal(arg2)
        return arg2.state.focusNode.focusController[FocusControllerInternalApi]
    end

    function var2.getRef(arg2)
        return arg2.props.innerRef or arg2.defaultRef
    end

    function var2.render(arg2)
        local ref = arg2:getRef()
        local tbl4 = {
            NextSelectionLeft = ref,
            NextSelectionRight = ref,
            NextSelectionDown = ref,
            NextSelectionUp = ref,
            [Roact.Ref] = ref
        }
        local var3

        if arg2:isRoot() then
            local tbl5 = {
                [Roact.Event.AncestryChanged] = arg2.ancestryChangedListener,
                [Roact.Event.DescendantAdded] = arg2.refreshFocusOnDescendantAdded,
                [Roact.Event.DescendantRemoving] = arg2.refreshFocusOnDescendantRemoved
            }

            var3 = Cryo.Dictionary.join(tbl4, arg2.props, tbl5, tbl1)
        else
            var3 = Cryo.Dictionary.join(tbl4, arg2.props.parentNeighbors or tbl2, arg2.props, tbl1)
        end

        return Roact.createElement(FocusContext.Provider, { value = arg2.state }, Roact.createElement(arg1, var3))
    end

    function var2.didMount(arg2)
        arg2.state.focusNode:attachToTree(arg2.props.parentFocusNode, arg2.updateFocusedState)

        if arg2:isRoot() then
            arg2.ancestryChanged(arg2:getRef():getValue())
        end
    end

    function var2.didUpdate(arg2, _, arg3)
        arg2.state.focusNode:updateNavProps(arg2.props)

        local var3 = arg2.props.innerRef or arg2.defaultRef
        if arg2.state.focusNode.ref ~= var3 then
            error("Cannot change the ref passed to a Focusable component", 0)
        end

        if arg2.state.needsDescendantAddedRefocusCounter ~= arg3.needsDescendantAddedRefocusCounter then
            arg2:getFocusControllerInternal():descendantAddedRefocus()
        end

        if arg2.state.needsDescendantRemovedRefocusCounter ~= arg3.needsDescendantRemovedRefocusCounter then
            arg2:getFocusControllerInternal():descendantRemovedRefocus()
        end
    end

    function var2.willUnmount(arg2)
        arg2.state.focusNode:detachFromTree()

        if arg2:isRoot() then
            arg2:getFocusControllerInternal():teardown()
        end
    end

    return Roact.forwardRef(function(arg2, innerRef)
        return Roact.createElement(FocusContext.Consumer, {
            render = function(arg4)
                if arg4 == nil and arg2.focusController == nil then
                    local var3 = Cryo.Dictionary.join(arg2, tbl1, { [Roact.Ref] = innerRef })

                    return Roact.createElement(arg1, var3)
                end

                local var3 = Cryo.Dictionary.join(arg2, {
                    parentFocusNode = if arg4 then arg4.focusNode or nil else nil,
                    parentNeighbors = arg4 and arg4.neighbors or nil,
                    innerRef = innerRef
                })

                return Roact.createElement(var2, var3)
            end
        })
    end)
end

return asFocusable
