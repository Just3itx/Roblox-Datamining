-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T15:30:52Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local React = require(scriptParentParent.React)

local createEffect = require(scriptParentParent.Signals).createEffect

local _success, result = xpcall(function(): boolean
    return game:DefineFastFlag("SignalsReactUseMutableSource", false)
end, function(): boolean
    return true
end)

local function getSignalVersion(callback)
    local function dummyObserver()
        return callback
    end

    local var1 = nil

    callback(function(func1: (...any) -> (...any)) -- name: scope
        var1 = func1
        return dummyObserver
    end)
    var1(dummyObserver, true)

    return var1()
end

local function getSignalSnapshot(arg1)
    return arg1(false)
end

local function subscribeToSignal(arg1, callback: (...any) -> (...any))
    return createEffect(function(arg2)
        callback(arg1(arg2))
    end)
end

return if result then function(arg1) -- name: useSignalState
    local var1 = React.useMemo(function()
        return React.createMutableSource(arg1, getSignalVersion)
    end, { arg1 })

    return React.useMutableSource(var1, getSignalSnapshot, subscribeToSignal)
end else function(arg1) -- name: useSignalState_old
    local var1, var2 = React.useState(function()
        return arg1(false)
    end)

    React.useLayoutEffect(function()
        var2(arg1(false))
        return createEffect(function(arg2)
            var2(arg1(arg2))
        end)
    end, { arg1 })

    return var1
end
