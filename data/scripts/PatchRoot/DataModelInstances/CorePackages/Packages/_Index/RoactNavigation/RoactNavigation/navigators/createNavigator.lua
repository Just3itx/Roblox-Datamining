-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T13:11:33Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local scriptParentParentParent = scriptParentParent.Parent
local React = require(scriptParentParentParent.React)
local LuauPolyfill = require(scriptParentParentParent.LuauPolyfill)
local Object = LuauPolyfill.Object
local Array = LuauPolyfill.Array
local invariant = require(scriptParentParent.utils.invariant)
local NavigationFocusEvents = require(scriptParentParent.views.NavigationFocusEvents)

return function(arg1, router, navigationConfig)
    local var1 = React.Component:extend("Navigator")

    var1.router = router
    var1.navigationOptions = navigationConfig.navigationOptions

    function var1.init(arg2)
        arg2.state = {
            descriptors = {},
            transitioningDescriptors = {},
            screenProps = arg2.props.screenProps
        }
    end

    function var1.getDerivedStateFromProps(arg2, arg3)
        local descriptors = arg3.descriptors

        local transitioningDescriptors = arg3.transitioningDescriptors
        local navigation = arg2.navigation
        local screenProps = arg2.screenProps

        invariant(
            navigation ~= nil,
            "The navigation prop is missing for this navigator. In react-navigation v3 and v4 you must set up your app container directly. More info: https://reactnavigation.org/docs/en/app-containers.html"
        )

        local routes = navigation.state.routes

        invariant(
            type(routes) == "table",
            "No \"routes\" found in navigation state. Did you try to pass the navigation prop of a React component to a Navigator child? See https://reactnavigation.org/docs/en/custom-navigators.html#navigator-navigation-prop"
        )

        return {
            descriptors = Array.reduce(routes, function(arg4, state)
                if descriptors and descriptors[state.key] and state == descriptors[state.key].state and screenProps == arg3.screenProps then
                    arg4[state.key] = descriptors[state.key]
                    return arg4
                end
                local function getComponent()
                    return router.getComponentForRouteName(state.routeName)
                end

                local childNavigation = navigation.getChildNavigation(state.key)
                local options = router.getScreenOptions(childNavigation, screenProps)

                arg4[state.key] = {
                    key = state.key,
                    getComponent = getComponent,
                    options = options,
                    state = state,
                    navigation = childNavigation
                }

                return arg4
            end, {}),
            transitioningDescriptors = not navigation.state.isTransitioning and {}
                or Object.assign({}, transitioningDescriptors, descriptors, Array.reduce(routes, function(arg4, arg5)
                    arg4[arg5.key] = Object.None
                    return arg4
                end, {})),
            screenProps = screenProps
        }
    end

    function var1.render(arg2)
        local navigation = arg2.props.navigation
        local screenProps = arg2.state.screenProps
        local descriptors = arg2.state.descriptors

        local transitioningDescriptors = arg2.state.transitioningDescriptors

        return React.createElement(React.Fragment, {}, {
            Events = React.createElement(NavigationFocusEvents, {
                navigation = navigation,
                onEvent = function(arg3, arg4, arg5)
                    if descriptors[arg3] then
                        descriptors[arg3].navigation.emit(arg4, arg5)
                    elseif transitioningDescriptors[arg3] then
                        transitioningDescriptors[arg3].navigation.emit(arg4, arg5)
                    end
                end
            }),
            View = React.createElement(
                arg1,
                Object.assign(
                    table.clone(arg2.props),
                    {
                        screenProps = screenProps,
                        navigation = navigation,
                        navigationConfig = navigationConfig,
                        descriptors = descriptors
                    }
                )
            )
        })
    end
    return var1
end
