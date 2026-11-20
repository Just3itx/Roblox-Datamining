-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T13:20:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local scriptParentParentParent = scriptParentParent.Parent
local LuauPolyfill = require(scriptParentParentParent.LuauPolyfill)
local Array = LuauPolyfill.Array
local Object = LuauPolyfill.Object

local NavigationActions = require(scriptParentParent.NavigationActions)
local BackBehavior = require(scriptParentParent.BackBehavior)
local getScreenForRouteName = require(script.Parent.getScreenForRouteName)
local createConfigGetter = require(script.Parent.createConfigGetter)
local validateRouteConfigMap = require(script.Parent.validateRouteConfigMap)
local validateRouteConfigArray = require(script.Parent.validateRouteConfigArray)
local invariant = require(scriptParentParent.utils.invariant)
local StackActions = require(scriptParentParent.routers.StackActions)
local SwitchActions = require(script.Parent.SwitchActions)
local createPathParser = require(script.Parent.pathUtils).createPathParser

local function defaultActionCreators()
    return {}
end

local function mapToRouteName(arg1)
    return (next(arg1))
end

local function foldToRoutes(arg1, arg2)
    local var1, var2 = next(arg2)
    arg1[var1] = var2
    return arg1
end

return function(arg1, arg2)
    validateRouteConfigArray(arg1)
    arg2 = arg2 or {}
    local var1 = validateRouteConfigMap(Array.reduce(arg1, foldToRoutes, {}))

    local var2 = arg2.order or Array.map(arg1, mapToRouteName)

    local var3 = arg2.getCustomActionCreators or defaultActionCreators

    local initialRouteParams = arg2.initialRouteParams
    local var4 = arg2.initialRouteName or var2[1]
    local var5 = arg2.backBehavior or BackBehavior.None

    local bool1 = not (arg2.resetOnBlur ~= nil) or arg2.resetOnBlur

    local index = Array.indexOf(var2, var4)
    if index < 1 then
        local str1 = table.concat(Array.map(var2, function(arg3): string
            return ("\"%s\""):format(arg3)
        end), ", ")

        error(("Invalid initialRouteName '%s'. Should be one of %s"):format(var4, str1), 2)
    end

    local childRouters = ({})
    for _, value in var2 do
        local screenForRouteName = getScreenForRouteName(var1, value)
        if type(screenForRouteName) == "table" and screenForRouteName.router then
            childRouters[value] = screenForRouteName.router
        else
            childRouters[value] = false
        end
    end

    local function getParamsForRoute(arg3, arg4) -- Luacid: Inlined by compiler; 1 call site recovered
        local var7 = var1[arg3]
        if type(var7) == "table" and var7.params then
            if arg4 then
                return (Object.assign(table.clone(var7.params), arg4))
            end

            return (table.clone(var7.params))
        end
        return arg4
    end

    local pathParser = createPathParser(childRouters, var1, arg2)
    local getPathAndParamsForRoute = pathParser.getPathAndParamsForRoute
    local getActionForPathAndParams = pathParser.getActionForPathAndParams

    local function resetChildRoute(arg3)
        local var7 = if arg3 == var4 then initialRouteParams else nil
        local params = getParamsForRoute(arg3, var7)
        local var8 = childRouters[arg3]
        if not var8 then
            return { key = arg3, routeName = arg3, params = params }
        end

        local var9 = NavigationActions.init()
        return Object.assign(table.clone(var8.getStateForAction(var9)), { key = arg3, routeName = arg3, params = params })
    end

    local function getNextState(arg3, arg4, arg5)
        if arg4 and arg5 and arg4.index ~= arg5.index and bool1 then
            local routeName = arg4.routes[arg4.index].routeName
            local routes = table.clone(arg5.routes)
            routes[arg4.index] = resetChildRoute(routeName)
            arg5 = Object.assign(table.clone(arg5), { routes = routes })
        end

        if var5 ~= BackBehavior.History or arg4 and arg5 and arg5.index == arg4.index then
            return arg5
        end

        local var7 = not arg4 and {} or arg4.routeKeyHistory

        if arg3.type == NavigationActions.Navigate then
            local key = arg5.routes[arg5.index].key
            var7 = Array.filter(var7, function(arg6): boolean
                return arg6 ~= key
            end)
            table.insert(var7, key)
        elseif arg3.type == NavigationActions.Back then
            var7 = table.clone(var7)
            table.remove(var7, #var7)
        end

        return Object.assign(table.clone(arg5), { routeKeyHistory = var7 })
    end

    local function getInitialState()
        local routes = Array.map(var2, resetChildRoute)
        local tbl2 = { routes = routes, index = index }

        if var5 == BackBehavior.History then
            tbl2.routeKeyHistory = { routes[index].key }
        end

        return tbl2
    end

    local module = {
        childRouters = childRouters,
        getActionCreators = function(arg3, arg4)
            return var3(arg3, arg4)
        end,
        getScreenOptions = createConfigGetter(var1, arg2.defaultNavigationOptions)
    }

    function module.getStateForAction(arg3, arg4)
        local var7 = if arg4 then table.clone(arg4) else nil
        local var8 = arg4 or getInitialState()
        local index5 = var8.index

        if arg3.type == NavigationActions.Init then
            local params = arg3.params
            if params then
                var8.routes = Array.map(var8.routes, function(arg5)
                    local var9 = arg5.routeName == var4 and initialRouteParams or {}
                    return Object.assign(table.clone(arg5), {
                        params = if arg5.params then Object.assign(table.clone(arg5.params), params, var9) else Object.assign(table.clone(params), var9)
                    })
                end)
            end
        end

        if arg3.type == SwitchActions.JumpTo and (arg3.key == nil or arg3.key == var8.key) then
            local params = arg3.params
            local index2 = Array.findIndex(var8.routes, function(arg5): boolean
                return arg5.routeName == arg3.routeName
            end)

            if index2 < 1 then
                error(
                    ("There is no route named '%s' in the navigator with the key '%s'.\n"):format(arg3.routeName, arg3.key) .. "Must be one of: " .. table.concat(Array.map(var8.routes, function(arg5)
                        return arg5.routeName
                    end), ",")
                )
            end

            local routes = var8.routes
            if params then
                return var8.routes.map(function(arg5, arg6)
                    if arg6 == index2 then
                        return Object.assign(table.clone(arg5), { params = Object.assign(table.clone(arg5.params), params) })
                    end

                    return arg5
                end)
            end

            return getNextState(arg3, var7, Object.assign(table.clone(var8), { routes = routes, index = index2 }))
        end

        local var9 = var8.routes[var8.index]
        local var10 = childRouters[var2[var8.index]]

        if var10 then
            local stateForAction = var10.getStateForAction(arg3, var9)
            if not stateForAction and arg4 then
                return nil
            end
            if stateForAction and stateForAction ~= var9 then
                local routes = table.clone(var8.routes)
                routes[var8.index] = stateForAction
                return getNextState(arg3, var7, Object.assign(table.clone(var8), { routes = routes }))
            end
        end

        local bool2 = arg3.key == nil or arg3.key == var9.key

        if arg3.type == NavigationActions.Back then
            if bool2 and var5 == BackBehavior.InitialRoute then
                index5 = index
            elseif bool2 and var5 == BackBehavior.Order then
                index5 = math.max(1, index5 - 1)
            elseif bool2 and var5 == BackBehavior.History and #var8.routeKeyHistory > 1 then
                local var11 = var8.routeKeyHistory[#var8.routeKeyHistory - 1]
                index5 = Array.indexOf(var2, var11)
            end
        end

        local bool3

        if arg3.type == NavigationActions.Navigate then
            bool3 = Array.find(var2, function(routeName, arg5): boolean
                if routeName ~= arg3.routeName then
                    return false
                end

                index5 = arg5
                return true
            end) ~= nil

            if bool3 then
                local var11 = var8.routes[index5]
                local var12 = childRouters[arg3.routeName]
                local var13 = if arg3.action and var12 then var12.getStateForAction(arg3.action, var11) or var11 else var11

                if arg3.params then
                    var13 = Object.assign(table.clone(var13), {
                        params = if arg3.params == Object.None then Object.None elseif var13.params then Object.assign(table.clone(var13.params), arg3.params) else table.clone(arg3.params)
                    })
                end

                if var13 ~= var11 then
                    local routes = table.clone(var8.routes)
                    routes[index5] = var13
                    local var15 = Object.assign(table.clone(var8), { routes = routes, index = index5 })

                    return getNextState(arg3, var7, var15)
                end

                if var13 == var11 and var8.index == index5 and var7 then
                    return nil
                end
            end
        else
            bool3 = false
        end

        if arg3.type == NavigationActions.SetParams then
            local key = arg3.key
            local index2 = Array.findIndex(var8.routes, function(arg5): boolean
                return arg5.key == key
            end)

            if index2 > 0 then
                local var11 = var8.routes[index2]

                local none = Object.None
                if arg3.params ~= Object.None then
                    if var11.params and arg3.params then
                        none = Object.assign(table.clone(var11.params), arg3.params)
                    elseif var11.params then
                        none = table.clone(var11.params)
                    else
                        none = not arg3.params and {} or table.clone(arg3.params)
                    end
                end
                local routes = table.clone(var8.routes)

                routes[index2] = Object.assign(table.clone(var11), { params = none })

                return getNextState(arg3, var7, Object.assign(table.clone(var8), { routes = routes }))
            end
        end

        local index2 = var8.index

        if index5 ~= index2 then
            return getNextState(arg3, var7, Object.assign(table.clone(var8), { index = index5 }))
        end

        if bool3 and not arg4 then
            return var8
        end

        if bool3 then
            return table.clone(var8)
        end

        local bool4 = arg3.type ~= NavigationActions.Back and arg3.type ~= StackActions.Pop and arg3.type ~= StackActions.PopToTop

        if not bool4 then
            if arg3.type == NavigationActions.Back then
                bool4 = arg3.key ~= nil
            else
                bool4 = false
            end
        end

        if not bool4 then
            return var8
        end

        local index3 = var8.index
        local routes = var8.routes
        Array.find(var2, function(arg5, arg6): boolean
            local var11 = childRouters[arg5]
            if arg6 == index3 then
                return false
            end

            local var12 = routes[arg6]
            if var11 then
                var12 = var11.getStateForAction(arg3, var12)
            end

            if not var12 then
                index3 = arg6
                return true
            end

            if var12 == routes[arg6] then
                return false
            end

            routes = table.clone(routes)
            routes[arg6] = var12
            index3 = arg6
            return true
        end)

        if arg3.preserveFocus then
            index3 = var8.index
        end

        local index4 = var8.index

        if index3 == index4 then
            local routes2 = var8.routes

            if routes == routes2 then
                return var8
            end
        end

        return getNextState(arg3, var7, Object.assign(table.clone(var8), { index = index3, routes = routes }))
    end

    function module.getComponentForState(arg3)
        local routeName = (arg3.routes[arg3.index] or {}).routeName
        invariant(
            routeName,
            "There is no route defined for index '%d'. Check that you passed in a navigation state with a valid tab/screen index.",
            arg3.index
        )

        local var7 = childRouters[routeName]

        if var7 then
            return var7.getComponentForState(arg3.routes[arg3.index])
        end

        return getScreenForRouteName(var1, routeName)
    end

    function module.getComponentForRouteName(arg3)
        return getScreenForRouteName(var1, arg3)
    end

    function module.getPathAndParamsForState(arg3)
        local var7 = arg3.routes[arg3.index]
        return getPathAndParamsForRoute(var7)
    end

    function module.getActionForPathAndParams(arg3, arg4)
        return getActionForPathAndParams(arg3, arg4)
    end

    return module
end
