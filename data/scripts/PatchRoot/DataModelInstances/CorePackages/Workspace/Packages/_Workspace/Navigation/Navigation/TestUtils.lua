-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T00:10:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local _types = require(script.Parent.types)

local function createMockRouteState(str1: string, params, routes, isTransitioning: boolean?) -- Luacid: Inlined by compiler; 3 call sites recovered
    local tbl1 = {
        key = str1,
        routeName = str1,
        params = params,
        isTransitioning = isTransitioning
    }
    if routes ~= nil then
        tbl1.routes = routes
        tbl1.index = #routes
    end
    return tbl1
end

return {
    createMockStackState = function(str1: string, routes)
        return (createMockRouteState(str1, nil, routes, false))
    end,
    createMockSwitchState = function(str1: string, routes)
        return (createMockRouteState(str1, nil, routes, nil))
    end,
    createMockScreenState = function(str1: string, params)
        return createMockRouteState(str1, params, nil, nil)
    end,
    createMockNavigationObject = function(state)
        return {
            state = state,
            dispatch = function(): boolean
                return true
            end,
            getParam = function(...) end,
            addListener = function(_, _)
                return {
                    remove = function() end
                }
            end,
            isFocused = function() end,
            getChildNavigation = function(_)
                return nil
            end,
            router = {
                getScreenOptions = function(_, _)
                    return {}
                end,
                getStateForAction = function<T>(_, arg1: T): T
                    return arg1
                end,
                getComponentForRouteName = function(_): () -> nil
                    return function()
                        return nil
                    end
                end,
                getActionCreators = function()
                    return {}
                end,
                childRouters = {}
            },
            _dangerouslyGetParent = function()
                return nil
            end
        }
    end
}
