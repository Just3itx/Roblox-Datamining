-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T13:11:29Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local scriptParentParent = scriptParent.Parent
local Object = require(scriptParentParent.LuauPolyfill).Object

local Events = require(scriptParent.Events)
local getNavigationActionCreators = require(scriptParent.routers.getNavigationActionCreators)
local getChildNavigation = require(scriptParent.getChildNavigation)
local getChildrenNavigationCache = require(scriptParent.getChildrenNavigationCache)

return function(router, state, dispatch, arg1, getScreenProps, arg2)
    local actions = router.getActionCreators(state, nil)

    local module = {
        actions = actions,
        router = router,
        state = state,
        dispatch = dispatch,
        getScreenProps = getScreenProps,
        _dangerouslyGetParent = function()
            return nil
        end,
        isFirstRouteInParent = function(): boolean
            return true
        end,
        _childrenNavigation = getChildrenNavigationCache(arg2())
    }

    function module.getChildNavigation(arg3)
        return getChildNavigation(module, arg3, arg2)
    end

    function module.isFocused(key): boolean
        local state2 = arg2().state
        local routes = state2.routes
        local index = state2.index

        return key == nil or routes[index].key == key
    end

    function module.addListener(action, arg3)
        if action ~= Events.Action then
            return {
                remove = function() end
            }
        end

        arg1[arg3] = true
        return {
            remove = function()
                arg1[arg3] = nil
            end
        }
    end

    local var1 = Object.assign(getNavigationActionCreators(module.state), actions)

    for value, _ in var1 do
        module[value] = function(...)
            module.dispatch(var1[value](...))
        end
    end

    return module
end
