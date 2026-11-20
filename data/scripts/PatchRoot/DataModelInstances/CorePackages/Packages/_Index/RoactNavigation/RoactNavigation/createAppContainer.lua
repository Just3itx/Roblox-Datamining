-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T13:11:21Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local scriptParentParent = scriptParent.Parent
local React = require(scriptParentParent.React)
local LuauPolyfill = require(scriptParentParent.LuauPolyfill)
local console = LuauPolyfill.console
local Object = LuauPolyfill.Object
local NavigationActions = require(scriptParent.NavigationActions)
local Events = require(scriptParent.Events)
local NavigationContext = require(scriptParent.views.NavigationContext)
local getNavigation = require(scriptParent.getNavigation)

local assert = assert

local urlToPathAndParams = require(scriptParent.routers.pathUtils).urlToPathAndParams

local function isStateful(props): boolean -- Luacid: Inlined by compiler; 2 call sites recovered
    return not props.navigation
end

local function validateProps(arg1)
    if arg1.persistenceKey then
        warn(
            "You passed persistenceKey prop to a navigator. The persistenceKey prop was replaced by a more flexible persistence mechanism, please see the navigation state persistence docs for more information. Passing the persistenceKey prop is a no-op."
        )
    end

    if isStateful(arg1) then
        return
    end

    local var1 = Object.assign(table.clone(arg1), {
        navigation = Object.None,
        screenProps = Object.None,
        persistNavigationState = Object.None,
        loadNavigationState = Object.None,
        externalDispatchConnector = Object.None
    })

    if next(var1) ~= nil then
        error(
            "This navigator has both navigation and container props, so it is "
                .. ("unclear if it should own its own state. Remove props: %q "):format(table.concat(Object.keys(var1), ", "))
                    .. "if the navigator should get its state from the navigation prop. If the navigator should maintain its own state, do not pass a navigation prop."
        )
    end

    local persistNavigationState = arg1.persistNavigationState
    local loadNavigationState = arg1.loadNavigationState
    assert(
        persistNavigationState == nil and loadNavigationState == nil
            or type(persistNavigationState) == "function" and type(loadNavigationState) == "function",
        "both persistNavigationState and loadNavigationState must either be undefined, or be functions"
    )
end

local num1 = 0
return {
    createAppContainer = function(arg1, arg2)
        assert(
            type(arg1) == "table" and arg1.router ~= nil,
            "AppComponent must be a navigator or a stateful Roact component with a 'router' field"
        )

        local str1 = string.format("NavigationContainer(%s)", tostring(arg1))
        local var1 = React.Component:extend(str1)

        var1.router = arg1.router

        function var1.getDerivedStateFromProps(arg3)
            validateProps(arg3)
            return nil
        end

        function var1.init(arg3)
            validateProps(arg3.props)

            arg3._actionEventSubscribers = {}
            arg3._initialAction = NavigationActions.init()

            arg3.state = {
                nav = if arg3:_isStateful() and not arg3.props.loadNavigationState then arg1.router.getStateForAction(arg3._initialAction) else nil
            }
        end

        function var1._updateExternalDispatchConnector(arg3)
            if arg3._disconnectExternalDispatch then
                arg3._disconnectExternalDispatch()
                arg3._disconnectExternalDispatch = nil
            end

            local externalDispatchConnector = arg3.props.externalDispatchConnector
            if externalDispatchConnector == nil then
                return
            end

            arg3._disconnectExternalDispatch = externalDispatchConnector(function(...)
                if arg3._isMounted then
                    return arg3:dispatch(...)
                end

                return false
            end)
        end

        function var1._renderLoading(arg3)
            return arg3.props.renderLoading and arg3.props.renderLoading()
        end

        function var1._isStateful(arg3): boolean
            return isStateful(arg3.props)
        end

        function var1._handleOpenURL(arg3, arg4)
            local url = arg4.url
            local enableUrlHandling = arg3.props.enableURLHandling
            local uriPrefix = arg3.props.uriPrefix

            if enableUrlHandling == false then
                return
            end
            local var2 = urlToPathAndParams(url, uriPrefix)
            if not var2 then
                return
            end

            local path = var2.path
            local params = var2.params
            local actionForPathAndParams = arg1.router.getActionForPathAndParams(path, params)
            if actionForPathAndParams then
                arg3:dispatch(actionForPathAndParams)
            end
        end

        function var1._onNavigationStateChange(arg3, arg4, arg5, arg6)
            local onNavigationStateChange = arg3.props.onNavigationStateChange
            if onNavigationStateChange == nil and arg3:_isStateful() and _G.REACT_NAV_LOGGING then
                console.group("Navigation Dispatch: ")
                console.log("Action: ", arg6)
                console.log("New State: ", arg5)
                console.log("Last State: ", arg4)
                console.groupEnd()
                return
            end

            if type(onNavigationStateChange) == "function" then
                onNavigationStateChange(arg4, arg5, arg6)
            end
        end

        function var1.didUpdate(arg3, arg4)
            if arg3._navState == arg3.state.nav then
                arg3._navState = nil
            end

            if arg3.props.externalDispatchConnector ~= arg4.externalDispatchConnector then
                arg3:_updateExternalDispatchConnector()
            end
        end

        function var1.didMount(arg3)
            arg3._isMounted = true

            arg3:_updateExternalDispatchConnector()

            if not arg3:_isStateful() then
                return
            end

            if _G.__DEV__ and not arg3.props.detached and num1 > 0 then
                console.warn(
                    "You should only render one navigator explicitly in your app, and other navigators should be rendered by including them in that navigator. Full details at: https://reactnavigation.org/docs/4.x/common-mistakes#explicitly-rendering-more-than-one-navigator"
                )
            end

            num1 += 1

            if arg2 then
                arg2:listenForLuaURLs(function(url)
                    arg3:_handleOpenURL({ url = url })
                end, false)
            end

            local userProvidedStartupState, parsedUrl

            if arg3.props.enableURLHandling == false then
                userProvidedStartupState = nil
                parsedUrl = nil
            else
                local startupParams = arg3:getStartupParams()
                parsedUrl = startupParams.parsedUrl
                userProvidedStartupState = startupParams.userProvidedStartupState
            end

            local _initialAction = arg3._initialAction
            local var2 = arg3.state.nav or arg1.router.getStateForAction(_initialAction)

            local var3 = userProvidedStartupState or var2

            if parsedUrl then
                local path = parsedUrl.path
                local params = parsedUrl.params
                local actionForPathAndParams = arg1.router.getActionForPathAndParams(path, params)
                if actionForPathAndParams then
                    _initialAction = actionForPathAndParams
                    var3 = arg1.router.getStateForAction(actionForPathAndParams, var3)
                end
            end

            local function dispatchAction()
                for k in arg3._actionEventSubscribers do
                    local tbl1 = {
                        type = Events.Action,
                        action = _initialAction,
                        state = arg3.state.nav,
                        lastState = nil
                    }
                    k(tbl1)
                end
            end

            if var3 == arg3.state.nav then
                spawn(dispatchAction)
                return
            end

            arg3:setState({ nav = var3 }, dispatchAction)
        end

        function var1.getStartupParams(arg3)
            local props = arg3.props
            local uriPrefix = props.uriPrefix
            local loadNavigationState = props.loadNavigationState
            local lastLuaUrl = nil
            local var2 = nil

            if arg2 then
                pcall(function()
                    lastLuaUrl = arg2:getLastLuaURL()
                end)
            end
            if loadNavigationState then
                pcall(function()
                    var2 = loadNavigationState()
                end)
            end

            return {
                parsedUrl = lastLuaUrl and urlToPathAndParams(lastLuaUrl, uriPrefix),
                userProvidedStartupState = var2
            }
        end

        function var1._persistNavigationState(arg3, arg4)
            local persistNavigationState = arg3.props.persistNavigationState
            if not persistNavigationState then
                return
            end

            local success, result = pcall(persistNavigationState, arg4)

            if not success then
                warn(
                    "Uncaught error while calling persistNavigationState()! " .. "You should handle exceptions thrown from persistNavigationState(), " .. "ignoring them may result in undefined behavior.\n" .. result
                )
            end
        end

        function var1.willUnmount(arg3)
            arg3._isMounted = false

            if arg2 then
                arg2:stopListeningForLuaURLs()
            end

            if arg3._disconnectExternalDispatch then
                arg3._disconnectExternalDispatch()
                arg3._disconnectExternalDispatch = nil
            end

            if arg3:_isStateful() then
                num1 -= 1
            end
        end

        function var1.dispatch(arg3, action)
            if arg3.props.navigation then
                return arg3.props.navigation.dispatch(action)
            end

            arg3._navState = arg3._navState or arg3.state.nav
            local _navState = arg3._navState
            assert(_navState ~= nil, "should be set in constructor if stateful")

            local stateForAction = arg1.router.getStateForAction(action, _navState)
            local var2 = stateForAction
            if stateForAction == nil then
                var2 = _navState
            end

            local function dispatchActionEvents()
                for k in arg3._actionEventSubscribers do
                    local tbl1 = {
                        type = Events.Action,
                        action = action,
                        state = var2,
                        lastState = _navState
                    }
                    k(tbl1)
                end
            end

            if stateForAction == nil then
                dispatchActionEvents()
                return true
            end

            if var2 == _navState then
                dispatchActionEvents()
                return false
            end

            arg3._navState = var2

            arg3:setState({ nav = var2 }, function()
                arg3:_onNavigationStateChange(_navState, var2, action)
                task.defer(dispatchActionEvents)
                arg3:_persistNavigationState(var2)
            end)

            return true
        end

        function var1._getScreenProps(arg3, arg4, arg5)
            if arg4 == nil then
                return arg3.props.screenProps
            end

            local screenProps = arg3.props.screenProps
            return if screenProps == nil or screenProps[arg4] == nil then arg5 else screenProps[arg4]
        end

        function var1.render(arg3)
            local navigation = arg3.props.navigation

            if arg3:_isStateful() then
                local nav = arg3.state.nav
                if not nav then
                    return arg3:_renderLoading()
                end

                if not arg3._navigation or arg3._navigation.state ~= nav then
                    arg3._navigation = getNavigation(arg1.router, nav, function(...)
                        return arg3:dispatch(...)
                    end, arg3._actionEventSubscribers, function(...)
                        return arg3:_getScreenProps(...)
                    end, function()
                        return arg3._navigation
                    end)
                end

                navigation = arg3._navigation
            end

            assert(navigation ~= nil, "failed to get navigation")

            return React.createElement(
                NavigationContext.Provider,
                { value = navigation },
                {
                    AppComponent = React.createElement(arg1, Object.assign(table.clone(arg3.props), { navigation = navigation }))
                }
            )
        end

        return var1
    end,
    _TESTING_ONLY_reset_container_count = function()
        num1 = 0
    end
}
