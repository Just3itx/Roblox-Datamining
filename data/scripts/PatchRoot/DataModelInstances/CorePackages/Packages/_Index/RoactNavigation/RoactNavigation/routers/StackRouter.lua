-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T13:20:52Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local scriptParentParentParent = scriptParentParent.Parent

local LuauPolyfill = require(scriptParentParentParent.LuauPolyfill)
local Array = LuauPolyfill.Array
local Object = LuauPolyfill.Object

local NavigationActions = require(scriptParentParent.NavigationActions)
local StackActions = require(script.Parent.StackActions)
local KeyGenerator = require(scriptParentParent.utils.KeyGenerator)
local StateUtils = require(scriptParentParent.StateUtils)
local getScreenForRouteName = require(script.Parent.getScreenForRouteName)
local createConfigGetter = require(script.Parent.createConfigGetter)
local validateRouteConfigArray = require(script.Parent.validateRouteConfigArray)
local validateRouteConfigMap = require(script.Parent.validateRouteConfigMap)
local invariant = require(scriptParentParent.utils.invariant)
local createPathParser = require(script.Parent.pathUtils).createPathParser

local ChildIsScreenRouterSymbolRoblox = require(script.Parent["ChildIsScreenRouterSymbol.roblox"])

local function func1()
    return {}
end

local function behavesLikePushAction(arg1): boolean -- Luacid: Inlined by compiler; 3 call sites recovered
    return arg1.type == NavigationActions.Navigate or arg1.type == StackActions.Push
end

local function isResetToRootStack(arg1): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    return arg1.type == StackActions.Reset and arg1.key == nil
end

local function mapToRouteName(arg1)
    return (next(arg1))
end

local function foldToRoutes(arg1, arg2, _)
    local var1, var2 = next(arg2)
    arg1[var1] = var2
    return arg1
end

return function(arg1, arg2)
    validateRouteConfigArray(arg1)
    local var1 = arg2 or {}
    local var2 = validateRouteConfigMap(Array.reduce(arg1, foldToRoutes, {}))

    local var3 = var1.order or Array.map(arg1, mapToRouteName)

    local tbl1 = ({})
    for _, value in var3 do
        local var4 = var2[value]
        if type(var4) == "table" and var4.screen then
            var4 = var4.screen
        end

        if type(var4) == "table" and var4.router then
            tbl1[value] = var4.router
        else
            tbl1[value] = ChildIsScreenRouterSymbolRoblox
        end
    end

    local initialRouteParams = var1.initialRouteParams
    local var4 = var1.getCustomActionCreators or func1

    local routeName = var1.initialRouteName or var3[1]

    local var6 = tbl1[routeName]

    if Array.indexOf(var3, routeName) < 1 then
        local str1 = ""
        for _, value in var3 do
            str1 ..= value .. ","
        end

        error(string.format("Invalid initialRouteName '%s'. Must be one of [%s]", routeName, str1), 2)
    end

    local function getInitialState(arg3)
        local tbl2 = {}
        local var7 = tbl1[arg3.routeName]

        if behavesLikePushAction(arg3) and var7 ~= nil then
            local stateForAction

            if var7 == ChildIsScreenRouterSymbolRoblox then
                stateForAction = {}
            else
                local var8 = arg3.action or NavigationActions.init({ params = arg3.params })
                stateForAction = var7.getStateForAction(var8)
            end

            return {
                key = "StackRouterRoot",
                isTransitioning = false,
                index = 1,
                routes = { Object.assign(
                        {
                            params = arg3.params
                        },
                        stateForAction,
                        {
                            key = arg3.key or KeyGenerator.generateKey(),
                            routeName = arg3.routeName
                        }
                    ) }
            }
        end

        if var6 ~= nil and var6 ~= ChildIsScreenRouterSymbolRoblox then
            tbl2 = var6.getStateForAction(NavigationActions.navigate({ routeName = routeName, params = initialRouteParams }))
        end

        local var8 = var2[routeName]
        local params = type(var8) == "table" and var8.params
        local var5 = (params or tbl2.params or arg3.params or initialRouteParams)
            and Object.assign(not params and {} or table.clone(params), tbl2.params or {}, arg3.params or {}, initialRouteParams or {})

        local initialRouteKey = var1.initialRouteKey
        return {
            key = "StackRouterRoot",
            isTransitioning = false,
            index = 1,
            routes = { (Object.assign(
                    table.clone(tbl2),
                    {
                        params = var5,
                        routeName = routeName,
                        key = arg3.key or initialRouteKey or KeyGenerator.generateKey()
                    }
                )) }
        }
    end

    local function getParamsForRouteAndAction(routeName, arg3)
        if arg3.params == Object.None then
            return nil
        end

        local var7 = var2[routeName]

        if type(var7) == "table" and var7.params then
            return Object.assign(table.clone(var7.params), arg3.params)
        elseif arg3.params then
            return Object.assign({}, arg3.params)
        end
        return nil
    end

    local pathParser = createPathParser(tbl1, var2, var1)
    local getPathAndParamsForRoute = pathParser.getPathAndParamsForRoute
    local getActionForPathAndParams = pathParser.getActionForPathAndParams

    local childRouters = ({})
    for value, value2 in tbl1 do
        if value2 ~= ChildIsScreenRouterSymbolRoblox then
            childRouters[value] = value2
        end
    end

    local module = {
        childRouters = childRouters,
        _CHILD_IS_SCREEN = ChildIsScreenRouterSymbolRoblox
    }

    function module.getComponentForState(arg3)
        local var7 = arg3.routes[arg3.index] or {}
        local routeName = var7.routeName
        invariant(
            routeName,
            "There is no route defined for index '%d'. Make sure that you passed in a navigation state with a valid stack index.",
            arg3.index
        )

        local var8 = tbl1[routeName]

        if var8 ~= nil and var8 ~= ChildIsScreenRouterSymbolRoblox then
            return tbl1[routeName].getComponentForState(var7)
        end

        return getScreenForRouteName(var2, routeName)
    end

    function module.getComponentForRouteName(arg3)
        return getScreenForRouteName(var2, arg3)
    end

    function module.getActionCreators(arg3, key)
        return Object.assign(table.clone(var4(arg3, key)), {
            pop = function(n, arg5)
                return StackActions.pop(Object.assign({ n = n }, arg5 or {}))
            end,
            popToTop = function(arg4)
                return StackActions.popToTop(arg4)
            end,
            push = function(routeName2, params, action)
                return StackActions.push({ routeName = routeName2, params = params, action = action })
            end,
            replace = function(routeName2, params, action, newKey)
                if type(routeName2) ~= "string" then
                    invariant(type(routeName2) == "table", "replaceWith must be a table or string")
                    invariant(params == nil, "params must not be provided to .replace() when specifying a table")
                    invariant(action == nil, "Child action must not be provided to .replace() when specifying a table")
                    invariant(newKey == nil, "newKey must not be provided to .replace() when specifying a table")

                    return StackActions.replace(routeName2)
                end

                return StackActions.replace({ routeName = routeName2, params = params, action = action, key = arg3.key, newKey = newKey })
            end,
            reset = function(actions, arg4)
                local index = arg4 == nil and #actions or arg4

                return StackActions.reset({ actions = actions, index = index, key = key })
            end,
            dismiss = function()
                return NavigationActions.back({ key = key })
            end
        })
    end

    function module.getStateForAction(arg3, arg4)
        if not arg4 then
            return (getInitialState(arg3))
        end

        local var7 = arg4.routes[arg4.index]

        if not isResetToRootStack(arg3) and arg3.type ~= NavigationActions.Navigate then
            local var8 = tbl1[var7.routeName]
            if var8 ~= nil and var8 ~= ChildIsScreenRouterSymbolRoblox then
                local stateForAction = var8.getStateForAction(arg3, var7)
                if stateForAction ~= nil and stateForAction ~= var7 then
                    return StateUtils.replaceAt(arg4, var7.key, stateForAction, arg3.type == NavigationActions.SetParams)
                end
            end
        elseif arg3.type == NavigationActions.Navigate then
            for i = #arg4.routes, 1, -1 do
                local var8 = arg4.routes[i]
                local var9 = tbl1[var8.routeName]
                local var10 = if arg3.routeName == var8.routeName and arg3.action then arg3.action else arg3

                if var9 == nil or var9 == ChildIsScreenRouterSymbolRoblox then
                    continue
                end

                local stateForAction = var9.getStateForAction(var10, var8)
                if stateForAction ~= nil and stateForAction == var8 then
                    continue
                end

                local var11 = StateUtils.replaceAndPrune(arg4, if stateForAction then stateForAction.key else var8.key, stateForAction or var8)

                local isTransitioning = arg4.isTransitioning
                if arg4.index ~= var11.index then
                    isTransitioning = arg3.immediate ~= true
                end

                return Object.assign(table.clone(var11), { isTransitioning = isTransitioning })
            end
        end

        if behavesLikePushAction(arg3) and tbl1[arg3.routeName] ~= nil then
            local var8 = tbl1[arg3.routeName]
            invariant(arg3.type ~= StackActions.Push or arg3.key == nil, "StackRouter does not support key on the push action")

            local func2 = arg3.key and function(arg5): boolean
                return arg5.key == arg3.key
            end or function(arg5): boolean
                return arg5.routeName == arg3.routeName
            end

            local index = Array.findIndex(arg4.routes, func2)

            if arg3.type == StackActions.Push or not (index > 0) then
                local tbl3

                if var8 ~= ChildIsScreenRouterSymbolRoblox then
                    local var9 = arg3.action or NavigationActions.init({ params = getParamsForRouteAndAction(arg3.routeName, arg3) })

                    tbl3 = Object.assign(
                        {
                            params = getParamsForRouteAndAction(arg3.routeName, arg3)
                        },
                        var8.getStateForAction(var9),
                        {
                            routeName = arg3.routeName,
                            key = arg3.key or KeyGenerator.generateKey()
                        }
                    )
                else
                    tbl3 = {
                        params = getParamsForRouteAndAction(arg3.routeName, arg3),
                        routeName = arg3.routeName,
                        key = arg3.key or KeyGenerator.generateKey()
                    }
                end

                return Object.assign(StateUtils.push(arg4, tbl3), { isTransitioning = arg3.immediate ~= true })
            end

            if arg4.index == index and not arg3.params then
                return nil
            end

            local routes = Array.slice(arg4.routes, 1, index + 1)

            if arg3.params then
                local var10 = arg4.routes[index]
                routes[index] = Object.assign(table.clone(var10), {
                    params = if arg3.params == Object.None then Object.None elseif var10.params then Object.assign(table.clone(var10.params), arg3.params) else table.clone(arg3.params)
                })
            end

            local isTransitioning = arg4.isTransitioning
            if arg4.index ~= index then
                isTransitioning = arg3.immediate ~= true
            end

            return Object.assign(table.clone(arg4), { isTransitioning = isTransitioning, index = index, routes = routes })
        elseif arg3.type == StackActions.Push and tbl1[arg3.routeName] == nil then
            return arg4
        else
            if behavesLikePushAction(arg3) then
                for value in tbl1 do
                    local var8 = tbl1[value]

                    if var8 == nil or var8 == ChildIsScreenRouterSymbolRoblox then
                        continue
                    end
                    local stateForAction = var8.getStateForAction(NavigationActions.init())

                    local stateForAction2 = var8.getStateForAction(arg3, stateForAction)

                    local var9 = nil
                    if stateForAction2 == nil then
                        stateForAction2 = stateForAction
                    elseif stateForAction2 == stateForAction then
                        stateForAction2 = var9
                    end

                    if not stateForAction2 then
                        continue
                    end

                    local var10 = Object.assign(table.clone(stateForAction2), { routeName = value, key = arg3.key or KeyGenerator.generateKey() })

                    return Object.assign(StateUtils.push(arg4, var10), { isTransitioning = arg3.immediate ~= true })
                end
            end

            if arg3.type == StackActions.PopToTop then
                if arg3.key and arg4.key ~= arg3.key then
                    return arg4
                elseif arg4.index > 1 then
                    return Object.assign(table.clone(arg4), { isTransitioning = arg3.immediate ~= true, index = 1, routes = { arg4.routes[1] } })
                end

                return arg4
            end

            if arg3.type == StackActions.Replace then
                local var8 = arg3.key == nil and #arg4.routes > 0 and #arg4.routes or Array.findIndex(arg4.routes, function(arg5): boolean
                    return arg5.key == arg3.key
                end)

                if var8 > 0 then
                    local var9 = tbl1[arg3.routeName]
                    local stateForAction

                    if var9 == nil or var9 == ChildIsScreenRouterSymbolRoblox then
                        stateForAction = {}
                    else
                        local var10 = arg3.action or NavigationActions.init({ params = getParamsForRouteAndAction(arg3.routeName, arg3) })

                        stateForAction = var9.getStateForAction(var10)
                    end

                    local routes = table.clone(arg4.routes)
                    routes[var8] = Object.assign(
                        {
                            params = getParamsForRouteAndAction(arg3.routeName, arg3)
                        },
                        stateForAction,
                        {
                            routeName = arg3.routeName,
                            key = arg3.newKey or KeyGenerator.generateKey()
                        }
                    )

                    return Object.assign(table.clone(arg4), { routes = routes })
                end
            end

            if arg3.type == StackActions.CompleteTransition
                and (arg3.key == nil or arg3.key == arg4.key)
                and arg3.toChildKey == arg4.routes[arg4.index].key
                and arg4.isTransitioning
            then
                return Object.assign(table.clone(arg4), { isTransitioning = false })
            end

            if arg3.type == NavigationActions.SetParams then
                local key = arg3.key
                local index = Array.findIndex(arg4.routes, function(arg5): boolean
                    return arg5.key == key
                end)

                if index > 0 then
                    local var8 = arg4.routes[index]

                    local none = Object.None
                    if arg3.params ~= Object.None then
                        if var8.params and arg3.params then
                            none = Object.assign(table.clone(var8.params), arg3.params)
                        elseif var8.params then
                            none = table.clone(var8.params)
                        else
                            none = not arg3.params and {} or table.clone(arg3.params)
                        end
                    end
                    local routes = table.clone(arg4.routes)
                    routes[index] = Object.assign(table.clone(var8), { params = none })

                    return Object.assign(table.clone(arg4), { routes = routes })
                end
            end

            if arg3.type == StackActions.Reset then
                if arg3.key ~= nil and arg3.key ~= arg4.key then
                    return arg4
                end

                local routes = not arg3.actions and {} or Array.map(arg3.actions, function(arg5)
                    local var8 = tbl1[arg5.routeName]
                    local stateForAction

                    if var8 == nil or var8 == ChildIsScreenRouterSymbolRoblox then
                        stateForAction = {}
                    else
                        local var9 = arg5.action or NavigationActions.init({ params = getParamsForRouteAndAction(arg5.routeName, arg5) })

                        stateForAction = var8.getStateForAction(var9)
                    end

                    return Object.assign(
                        {
                            params = getParamsForRouteAndAction(arg5.routeName, arg5)
                        },
                        stateForAction,
                        {
                            routeName = arg5.routeName,
                            key = arg5.key or KeyGenerator.generateKey()
                        }
                    )
                end)

                return Object.assign(table.clone(arg4), { routes = routes, index = arg3.index })
            end

            if arg3.type == NavigationActions.Back or arg3.type == StackActions.Pop then
                local key = arg3.key
                local n = arg3.n
                local immediate = arg3.immediate
                local prune = arg3.prune

                if arg3.type == StackActions.Pop and prune == false and key then
                    local index = Array.findIndex(arg4.routes, function(arg5): boolean
                        return arg5.key == key
                    end)

                    if index > 0 then
                        local num1 = math.max(index - (n or 1), 1)

                        local routes = Array.concat(Array.slice(arg4.routes, 1, num1 + 1), Array.slice(arg4.routes, index + 1))

                        if #routes > 0 then
                            return Object.assign(table.clone(arg4), { routes = routes, index = #routes, isTransitioning = immediate ~= true })
                        end
                    end
                else
                    local index = arg4.index

                    if arg3.type == StackActions.Pop and n ~= nil then
                        index = math.max(2, arg4.index - n + 1)
                    elseif key then
                        index = Array.findIndex(arg4.routes, function(arg5): boolean
                            return arg5.key == key
                        end)
                    end

                    if index > 1 then
                        return Object.assign(
                            table.clone(arg4),
                            {
                                routes = Array.slice(arg4.routes, 1, index),
                                index = index - 1,
                                isTransitioning = immediate ~= true
                            }
                        )
                    end
                end
            end

            local var8 = if arg3.key then StateUtils.indexOf(arg4, arg3.key) else nil

            for i = #arg4.routes, 1, -1 do
                local var9 = arg4.routes[i]

                if var9.key == var7.key or var8 ~= 1 and var9.key ~= arg3.key then
                    continue
                end

                local var10 = tbl1[var9.routeName]
                if var10 == nil or var10 == ChildIsScreenRouterSymbolRoblox then
                    continue
                end

                local stateForAction = var10.getStateForAction(arg3, var9)

                if stateForAction == nil then
                    return arg4
                end

                if stateForAction ~= var9 then
                    return StateUtils.replaceAt(arg4, var9.key, stateForAction, arg3.preserveFocus)
                end
            end

            return arg4
        end
    end
    function module.getPathAndParamsForState(arg3)
        local var7 = arg3.routes[arg3.index]
        return getPathAndParamsForRoute(var7)
    end

    function module.getActionForPathAndParams(arg3, arg4)
        return getActionForPathAndParams(arg3, arg4)
    end

    module.getScreenOptions = createConfigGetter(var2, var1.defaultNavigationOptions)

    return module
end
