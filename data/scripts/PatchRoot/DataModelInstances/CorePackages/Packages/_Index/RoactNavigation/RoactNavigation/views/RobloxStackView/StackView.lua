-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T13:21:23Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local scriptParentParentParent = scriptParent.Parent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent

local Object = require(scriptParentParentParentParent.LuauPolyfill).Object
local React = require(scriptParentParentParentParent.React)
local StackActions = require(scriptParentParentParent.routers.StackActions)
local StackViewLayout = require(scriptParent.StackViewLayout)
local Transitioner = require(scriptParent.Transitioner)
local StackViewTransitionConfigs = require(scriptParent.StackViewTransitionConfigs)
local tbl1 = {
    mode = require(scriptParent.StackPresentationStyle).Default
}

local var1 = React.Component:extend("StackView")

function var1.init(arg1)
    function arg1._doRender(...)
        return arg1:_render(...)
    end

    function arg1._doConfigureTransition(...)
        return arg1:_configureTransition(...)
    end

    function arg1._doOnTransitionStart(...)
        return arg1:_onTransitionStart(...)
    end

    function arg1._doOnTransitionEnd(...)
        return arg1:_onTransitionEnd(...)
    end

    function arg1._doOnTransitionStep(...)
        return arg1:_onTransitionStep(...)
    end
end

function var1.render(arg1)
    local screenProps = arg1.props.screenProps
    local navigation = arg1.props.navigation
    local descriptors = arg1.props.descriptors

    return React.createElement(Transitioner, {
        render = arg1._doRender,
        configureTransition = arg1._doConfigureTransition,
        screenProps = screenProps,
        navigation = navigation,
        descriptors = descriptors,
        onTransitionStart = arg1._doOnTransitionStart,
        onTransitionEnd = arg1._doOnTransitionEnd,
        onTransitionStep = arg1._doOnTransitionStep
    })
end

function var1.didMount(arg1)
    local navigation = arg1.props.navigation
    if navigation.state.isTransitioning then
        navigation.dispatch(StackActions.completeTransition({ key = navigation.state.key }))
    end
end

function var1._render(arg1, transitionProps, lastTransitionProps)
    local screenProps = arg1.props.screenProps
    local var2 = Object.assign(table.clone(tbl1), arg1.props.navigationConfig)
    local descriptors = arg1.props.descriptors

    return React.createElement(
        StackViewLayout,
        Object.assign(var2, {
            screenProps = screenProps,
            descriptors = descriptors,
            transitionProps = transitionProps,
            lastTransitionProps = lastTransitionProps
        })
    )
end

function var1._configureTransition(arg1, arg2, arg3)
    return StackViewTransitionConfigs.getTransitionConfig(
        arg1.props.navigationConfig.transitionConfig,
        arg2,
        arg3,
        arg1.props.navigationConfig.mode
    ).transitionSpec
end

function var1._onTransitionStart(arg1, arg2, arg3)
    local onTransitionStart = arg1.props.onTransitionStart or arg1.props.navigationConfig.onTransitionStart

    if onTransitionStart and arg2.index ~= arg3.index then
        onTransitionStart(arg2.navigation, arg3.navigation)
    end
end

function var1._onTransitionEnd(arg1, arg2, arg3)
    local navigationConfig = arg1.props.navigationConfig
    local navigation = arg1.props.navigation
    local onTransitionEnd = arg1.props.onTransitionEnd or navigationConfig.onTransitionEnd
    local key = arg2.scene.route.key
    local bool1 = navigation.state.routes[navigation.state.index].key == key

    if arg2.navigation.state.isTransitioning and bool1 then
        navigation.dispatch(StackActions.completeTransition({ key = navigation.state.key, toChildKey = key }))
    end

    if onTransitionEnd and arg2.index ~= arg3.index then
        onTransitionEnd(arg2.navigation, arg3.navigation)
    end
end

function var1._onTransitionStep(arg1, arg2, arg3, arg4)
    local onTransitionStep = arg1.props.onTransitionStep or arg1.props.navigationConfig.onTransitionStep

    if onTransitionStep and arg2.index ~= arg3.index then
        onTransitionStep(arg2.navigation, arg3.navigation, arg4)
    end
end

return var1
