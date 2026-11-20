-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T13:21:19Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local scriptParentParentParent = scriptParentParent.Parent
local Array = require(scriptParentParentParent.LuauPolyfill).Array

local React = require(scriptParentParentParent.React)
local Events = require(scriptParentParent.Events)

local var1 = React.Component:extend("NavigationEventManager")

function var1.didMount(arg1)
    local navigation = arg1.props.navigation

    arg1._actionSubscription = navigation.addListener(Events.Action, function(...)
        return arg1:_handleAction(...)
    end)

    arg1._willFocusSubscription = navigation.addListener(Events.WillFocus, function(...)
        return arg1:_handleWillFocus(...)
    end)

    arg1._willBlurSubscription = navigation.addListener(Events.WillBlur, function(...)
        return arg1:_handleWillBlur(...)
    end)

    arg1._didFocusSubscription = navigation.addListener(Events.DidFocus, function(...)
        return arg1:_handleDidFocus(...)
    end)

    arg1._didBlurSubscription = navigation.addListener(Events.DidBlur, function(...)
        return arg1:_handleDidBlur(...)
    end)

    arg1._refocusSubscription = navigation.addListener(Events.Refocus, function(...)
        return arg1:_handleRefocus(...)
    end)
end

function var1.willUnmount(arg1)
    if arg1._actionSubscription then
        arg1._actionSubscription.remove()
    end
    if arg1._willFocusSubscription then
        arg1._willFocusSubscription.remove()
    end
    if arg1._willBlurSubscription then
        arg1._willBlurSubscription.remove()
    end
    if arg1._didFocusSubscription then
        arg1._didFocusSubscription.remove()
    end
    if arg1._didBlurSubscription then
        arg1._didBlurSubscription.remove()
    end
    if arg1._refocusSubscription then
        arg1._refocusSubscription.remove()
    end
end

function var1._handleAction(arg1, arg2)
    local state = arg2.state
    local lastState = arg2.lastState
    local action = arg2.action
    local type = arg2.type
    local context = arg2.context

    local navigation = arg1.props.navigation
    local onEvent = arg1.props.onEvent

    if not navigation.isFocused() then
        return
    end

    local var2 = if lastState and lastState.routes then lastState.routes[lastState.index] else nil
    local var3 = state.routes[state.index]

    local tbl1 = { context = 0, state = 0, lastState = 0, action = 0, type = 0 }
    local key = var3.key
    local type2 = action.type
    tbl1.context = ("%s:%s_%s"):format(key, tostring(type2), context or "Root")
    tbl1.state = var3
    tbl1.lastState = var2
    tbl1.action = action
    tbl1.type = type

    if (var2 and var2.key) ~= var3.key then
        arg1:_emitWillFocus(var3.key, tbl1)

        if var2 and var2.key then
            arg1:_emitWillBlur(var2.key, tbl1)
        end
    end

    if lastState and lastState.isTransitioning ~= state.isTransitioning and state.isTransitioning == false then
        if arg1._lastWillBlurKey then
            arg1:_emitDidBlur(arg1._lastWillBlurKey, tbl1)
        end

        if arg1._lastWillFocusKey then
            arg1:_emitDidFocus(arg1._lastWillFocusKey, tbl1)
        end
    end

    onEvent(var3.key, Events.Action, tbl1)
end

function var1._handleWillFocus(arg1, arg2)
    local lastState = arg2.lastState
    local action = arg2.action
    local context = arg2.context
    local type = arg2.type

    local navigation = arg1.props.navigation
    local state = navigation.state.routes[navigation.state.index]

    local var3 = nil
    if lastState and lastState.routes then
        local var4 = if lastState then Array.findIndex(lastState.routes, function(arg3): boolean
            return arg3.key == state.key
        end) else -1

        if var4 > 0 then
            var3 = lastState.routes[var4]
        end
    end

    local key = state.key
    local tbl1 = { context = 0, state = 0, lastState = 0, action = 0, type = 0 }
    local key2 = state.key
    local type2 = action.type
    tbl1.context = ("%s:%s_%s"):format(key2, tostring(type2), context or "Root")
    tbl1.state = state
    tbl1.lastState = var3
    tbl1.action = action
    tbl1.type = type
    arg1:_emitWillFocus(key, tbl1)
end

function var1._handleWillBlur(arg1, arg2)
    local lastState = arg2.lastState
    local action = arg2.action
    local context = arg2.context
    local type = arg2.type

    local navigation = arg1.props.navigation
    local state = navigation.state.routes[navigation.state.index]

    local var3 = nil
    if lastState and lastState.routes then
        local var4 = if lastState then Array.findIndex(lastState.routes, function(arg3): boolean
            return arg3.key == state.key
        end) else -1

        if var4 > 0 then
            var3 = lastState.routes[var4]
        end
    end

    local key = state.key
    local tbl1 = { context = 0, state = 0, lastState = 0, action = 0, type = 0 }
    local key2 = state.key
    local type2 = action.type
    tbl1.context = ("%s:%s_%s"):format(key2, tostring(type2), context or "Root")
    tbl1.state = state
    tbl1.lastState = var3
    tbl1.action = action
    tbl1.type = type
    arg1:_emitWillBlur(key, tbl1)
end

function var1._handleDidFocus(arg1, arg2)
    local lastState = arg2.lastState
    local action = arg2.action
    local context = arg2.context
    local type = arg2.type

    local navigation = arg1.props.navigation

    if not arg1._lastWillFocusKey then
        return
    end

    local index = Array.findIndex(navigation.state.routes, function(arg3): boolean
        return arg3.key == arg1._lastWillFocusKey
    end)

    if not (index > 0) then
        return
    end

    local state = navigation.state.routes[index]

    local var3 = nil
    if lastState and lastState.routes then
        local var4 = if lastState then Array.findIndex(lastState.routes, function(arg3): boolean
            return arg3.key == state.key
        end) else -1

        if var4 > 0 then
            var3 = lastState.routes[var4]
        end
    end

    local key = state.key
    local tbl1 = { context = 0, state = 0, lastState = 0, action = 0, type = 0 }
    local key2 = state.key
    local type2 = action.type
    tbl1.context = ("%s:%s_%s"):format(key2, tostring(type2), context or "Root")
    tbl1.state = state
    tbl1.lastState = var3
    tbl1.action = action
    tbl1.type = type
    arg1:_emitDidFocus(key, tbl1)
end

function var1._handleDidBlur(arg1, arg2)
    local lastState = arg2.lastState
    local action = arg2.action
    local context = arg2.context
    local type = arg2.type

    local navigation = arg1.props.navigation

    if not arg1._lastWillBlurKey then
        return
    end

    local index = Array.findIndex(navigation.state.routes, function(arg3): boolean
        return arg3.key == arg1._lastWillBlurKey
    end)

    if not (index > 0) then
        return
    end

    local state = navigation.state.routes[index]

    local var3 = nil
    if lastState and lastState.routes then
        local var4 = if lastState then Array.findIndex(lastState.routes, function(arg3): boolean
            return arg3.key == state.key
        end) else -1

        if var4 > 0 then
            var3 = lastState.routes[var4]
        end
    end

    local key = state.key
    local tbl1 = { context = 0, state = 0, lastState = 0, action = 0, type = 0 }
    local key2 = state.key
    local type2 = action.type
    tbl1.context = ("%s:%s_%s"):format(key2, tostring(type2), context or "Root")
    tbl1.state = state
    tbl1.lastState = var3
    tbl1.action = action
    tbl1.type = type
    arg1:_emitDidBlur(key, tbl1)
end

function var1._handleRefocus(arg1)
    local onEvent = arg1.props.onEvent
    local navigation = arg1.props.navigation
    onEvent(navigation.state.routes[navigation.state.index].key, Events.Refocus)
end

function var1._emitWillFocus(arg1, _lastWillFocusKey, arg2)
    if arg1._lastWillBlurKey == _lastWillFocusKey then
        arg1._lastWillBlurKey = nil
    end

    if arg1._lastWillFocusKey == _lastWillFocusKey then
        return
    end

    arg1._lastDidFocusKey = nil
    arg1._lastWillFocusKey = _lastWillFocusKey

    local navigation = arg1.props.navigation
    arg1.props.onEvent(_lastWillFocusKey, Events.WillFocus, arg2)

    if type(navigation.state.isTransitioning) ~= "boolean"
        or navigation.state.isTransitioning ~= true and not navigation._dangerouslyGetParent()
    then
        arg1:_emitDidFocus(_lastWillFocusKey, arg2)
    end
end

function var1._emitWillBlur(arg1, _lastWillBlurKey, arg2)
    if arg1._lastWillFocusKey == _lastWillBlurKey then
        arg1._lastWillFocusKey = nil
    end

    if arg1._lastWillBlurKey == _lastWillBlurKey then
        return
    end

    arg1._lastDidBlurKey = nil
    arg1._lastWillBlurKey = _lastWillBlurKey

    local navigation = arg1.props.navigation
    arg1.props.onEvent(_lastWillBlurKey, Events.WillBlur, arg2)

    if type(navigation.state.isTransitioning) ~= "boolean"
        or navigation.state.isTransitioning ~= true and not navigation._dangerouslyGetParent()
    then
        arg1:_emitDidBlur(_lastWillBlurKey, arg2)
    end
end

function var1._emitDidFocus(arg1, _lastDidFocusKey, arg2)
    if arg1._lastWillFocusKey ~= _lastDidFocusKey or arg1._lastDidFocusKey == _lastDidFocusKey then
        return
    end

    arg1._lastDidFocusKey = _lastDidFocusKey

    arg1.props.onEvent(_lastDidFocusKey, Events.DidFocus, arg2)
end

function var1._emitDidBlur(arg1, _lastDidBlurKey, arg2)
    if arg1._lastWillBlurKey ~= _lastDidBlurKey or arg1._lastDidBlurKey == _lastDidBlurKey then
        return
    end

    arg1._lastDidBlurKey = _lastDidBlurKey

    arg1.props.onEvent(_lastDidBlurKey, Events.DidBlur, arg2)
end

function var1.render(_)
    return nil
end

return var1
