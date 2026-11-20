-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T13:20:40Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local NavigationActions = require(script.Parent.Parent.NavigationActions)
local invariant = require(script.Parent.Parent.utils.invariant)

return function(arg1)
    return {
        goBack = function(key)
            if key == nil and arg1.key then
                invariant(type(arg1.key) == "string", ".goBack(): key should be a string")
                key = arg1.key
            end

            return NavigationActions.back({ key = key })
        end,
        navigate = function(routeName, params, action)
            if type(routeName) == "string" then
                return NavigationActions.navigate({ routeName = routeName, params = params, action = action })
            end

            invariant(type(routeName) == "table", ".navigate(): navigateTo must be a string or table")
            invariant(params == nil, ".navigate(): params can only be provided with a string navigateTo value")
            invariant(action == nil, ".navigate(): child action can only be provided with a string navigateTo value")

            return NavigationActions.navigate(routeName)
        end,
        setParams = function(params)
            invariant(type(arg1.key) == "string", ".setParams(): cannot be called by the root navigator")
            return NavigationActions.setParams({ params = params, key = arg1.key })
        end
    }
end
