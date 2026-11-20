-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T13:11:23Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local LuauPolyfill = require(scriptParentParent.LuauPolyfill)
local Array = LuauPolyfill.Array
local Object = LuauPolyfill.Object
local getEventManager = require(script.Parent.getEventManager)
local getChildRouter = require(script.Parent.getChildRouter)
local getNavigationActionCreators = require(script.Parent.routers.getNavigationActionCreators)
local getChildrenNavigationCache = require(script.Parent.getChildrenNavigationCache)

local function createParamGetter(arg1) -- Luacid: Inlined by compiler; 2 call sites recovered
    return function(arg2, arg3)
        local params = arg1.params

        return if params and params[arg2] ~= nil then params[arg2] else arg3
    end
end

local function getChildNavigation(arg1, key, _dangerouslyGetParent)
    local childrenNavigationCache = getChildrenNavigationCache(arg1)

    local index = Array.findIndex(arg1.state.routes, function(arg2): boolean
        return arg2.key == key
    end)

    if index < 1 then
        return nil
    end
    local state = arg1.state.routes[index]

    local var2 = childrenNavigationCache[key]

    if var2 and var2.state == state then
        return var2
    end

    local router = getChildRouter(arg1.router, state.routeName)
    local var3 = if state.routes and type(state.index) == "number" then state.routes[state.index] else nil
    local var4 = not router and {} or router.getActionCreators(var3, state.key) or {}

    local actions = Object.assign(
        not arg1.actions and {} or table.clone(arg1.actions),
        arg1.router.getActionCreators(state, arg1.state.key) or {},
        var4 or {},
        getNavigationActionCreators(state) or {}
    )

    local tbl1 = ({})
    for value, value2 in actions do
        tbl1[value] = function(...)
            local var6 = value2(...)
            return arg1.dispatch(var6)
        end
    end

    local isFirstRouteInParent = true

    local var6 = _dangerouslyGetParent()

    if var6 then
        isFirstRouteInParent = Array.indexOf(var6.state.routes, state) == 1
    end

    if var2 and var2.isFirstRouteInParent() == isFirstRouteInParent then
        local var7 = nil
        var7 = Object.assign(table.clone(var2), tbl1, {
            state = state,
            router = router,
            actions = actions,
            getParam = createParamGetter(state),
            getChildNavigation = function(arg2)
                return getChildNavigation(var7, arg2, function()
                    local var8 = _dangerouslyGetParent()
                    if var8 then
                        return (var8.getChildNavigation(key))
                    end

                    return nil
                end)
            end
        })

        childrenNavigationCache[key] = var7

        return var7
    end

    local eventManager = getEventManager(key)

    local var7 = nil
    var7 = Object.assign(table.clone(tbl1), {
        state = state,
        router = router,
        actions = actions,
        getParam = createParamGetter(state),
        getChildNavigation = function(arg2)
            return getChildNavigation(var7, arg2, function()
                local var8 = _dangerouslyGetParent()
                if var8 then
                    return (var8.getChildNavigation(key))
                end

                return nil
            end)
        end,
        isFocused = function(): boolean
            local var8 = _dangerouslyGetParent()
            if not var8 then
                return false
            end

            if not var8.isFocused() then
                return false
            end

            local state = var8.state
            return state.routes[state.index].key == key
        end,
        isFirstRouteInParent = function()
            return isFirstRouteInParent
        end,
        dispatch = arg1.dispatch,
        getScreenProps = arg1.getScreenProps,
        _dangerouslyGetParent = _dangerouslyGetParent,
        addListener = eventManager.addListener,
        emit = eventManager.emit
    })

    childrenNavigationCache[key] = var7

    return var7
end

return getChildNavigation
