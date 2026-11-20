-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T13:30:47Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local scriptParentParent = scriptParent.Parent
local scriptParentParentParent = scriptParentParent.Parent
local Object = require(scriptParentParentParent.LuauPolyfill).Object
local React = require(scriptParentParentParent.React)
local Events = require(scriptParentParent.Events)
local withNavigation = require(scriptParent.withNavigation)

local function isComponent(arg1): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    local str1 = type(arg1)
    return str1 == "function" or str1 == "table"
end

return function(arg1)
    assert(isComponent(arg1), "withNavigationFocus must be called with a Roact component (stateful or functional)")
    local var1 = React.Component:extend("NavigationFocusComponent")

    function var1.init(arg2)
        arg2.state = {
            isFocused = arg2.props.navigation.isFocused()
        }
    end

    function var1.didMount(arg2)
        local navigation = arg2.props.navigation

        arg2.subscriptions = {
            navigation.addListener(Events.WillFocus, function()
                arg2:setState({ isFocused = true })
            end),
            navigation.addListener(Events.WillBlur, function()
                arg2:setState({ isFocused = false })
            end)
        }
    end

    function var1.willUnmount(arg2)
        for _, subscription in arg2.subscriptions do
            subscription.remove()
        end
    end

    function var1.render(arg2)
        return React.createElement(arg1, Object.assign(table.clone(arg2.props), { isFocused = arg2.state.isFocused }))
    end

    return withNavigation(var1, { forwardRef = false })
end
