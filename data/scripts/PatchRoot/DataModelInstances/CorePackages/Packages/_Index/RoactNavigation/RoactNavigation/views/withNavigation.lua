-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T13:30:46Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local scriptParentParent = scriptParent.Parent
local scriptParentParentParent = scriptParentParent.Parent
local Object = require(scriptParentParentParent.LuauPolyfill).Object
local React = require(scriptParentParentParent.React)
local NavigationContext = require(scriptParent.NavigationContext)
local invariant = require(scriptParentParent.utils.invariant)

local function isComponent(arg1): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    local str1 = type(arg1)
    return str1 == "function" or str1 == "table"
end

return function(arg1, tbl1)
    assert(isComponent(arg1), "withNavigation must be called with a Roact component (stateful or functional)")
    local var1 = Object.assign({ forwardRef = true }, tbl1)

    return function(arg2)
        local navigation = arg2.navigation
        return React.createElement(NavigationContext.Consumer, {
            render = function(arg3)
                local var2 = navigation or arg3
                invariant(
                    var2,
                    "withNavigation and withNavigationFocus can only be used on a view hierarchy of a navigator. The wrapped component is unable to get access to navigation from props or context."
                )

                return React.createElement(
                    arg1,
                    Object.assign(table.clone(arg2), { navigation = var2, ref = if var1.forwardRef then arg2.onRef else Object.None })
                )
            end
        })
    end
end
