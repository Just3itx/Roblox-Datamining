-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T12:11:07Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local ReactGlobals = require(scriptParentParent.ReactGlobals)
local Array = require(scriptParentParent.LuauPolyfill).Array

local console = require(scriptParentParent.Shared).console

local _Shared = require(scriptParentParent.Shared)

local _Shared2 = require(scriptParentParent.Shared)

local ReactCurrentDispatcher = require(scriptParentParent.Shared).ReactSharedInternals.ReactCurrentDispatcher

local function resolveDispatcher() -- Luacid: Inlined by compiler; 13 call sites recovered
    local current = ReactCurrentDispatcher.current

    if ReactGlobals.__DEV__ and current == nil then
        console.error(
            "Invalid hook call. Hooks can only be called inside of the body of a function component. This could happen for one of the following reasons:\n1. You might have mismatching versions of React and the renderer (such as React DOM)\n2. You might be breaking the Rules of Hooks\n3. You might have more than one copy of React in the same app\nSee https://reactjs.org/link/invalid-hook-call for tips about how to debug and fix this problem."
        )
    end

    return current
end

local module = {}

function module.useContext(arg1, passed, ...)
    local var1 = resolveDispatcher()

    if ReactGlobals.__DEV__ then
        if passed ~= nil then
            console.error(
                "useContext() second argument is reserved for future use in React. Passing it is not supported. You passed: %s.%s",
                passed,
                if typeof(passed) ~= "number" then "" elseif Array.isArray({ ... }) then "\n\nDid you call Array.map(useContext)? Calling Hooks inside a loop is not supported. Learn more at https://reactjs.org/link/rules-of-hooks" else ""
            )
        end

        if arg1._context ~= nil then
            local _context = arg1._context

            if _context.Consumer == arg1 then
                console.error(
                    "Calling useContext(Context.Consumer) is not supported, may cause bugs, and will be removed in a future major release. Did you mean to call useContext(Context) instead?"
                )
            elseif _context.Provider == arg1 then
                console.error(
                    "Calling useContext(Context.Provider) is not supported. Did you mean to call useContext(Context) instead?"
                )
            end
        end
    end

    return var1.useContext(arg1, passed)
end

function module.useState(arg1, ...)
    return resolveDispatcher().useState(arg1, ...)
end

function module.useReducer(func1: (...any) -> (...any), arg1, func2: ((...any) -> (...any))?)
    return resolveDispatcher().useReducer(func1, arg1, func2)
end

function module.useRef(arg1)
    return resolveDispatcher().useRef(arg1)
end

function module.useBinding(arg1)
    return resolveDispatcher().useBinding(arg1)
end

function module.useEffect(func1: (...any) -> (...any), arg1)
    return resolveDispatcher().useEffect(func1, arg1)
end

function module.useLayoutEffect(func1: (...any) -> (...any), arg1)
    return resolveDispatcher().useLayoutEffect(func1, arg1)
end

function module.useCallback(arg1, arg2)
    return resolveDispatcher().useCallback(arg1, arg2)
end

function module.useMemo(func1: (...any) -> (...any), arg1)
    return resolveDispatcher().useMemo(func1, arg1)
end

function module.useImperativeHandle(arg1, func1: (...any) -> (...any), arg2)
    return resolveDispatcher().useImperativeHandle(arg1, func1, arg2)
end

function module.useDebugValue(arg1, func1: ((...any) -> (...any))?)
    if ReactGlobals.__DEV__ then
        return resolveDispatcher().useDebugValue(arg1, func1)
    end

    return nil
end
module.emptyObject = {}

function module.useOpaqueIdentifier()
    return resolveDispatcher().useOpaqueIdentifier()
end

function module.useMutableSource(arg1, arg2, arg3)
    return resolveDispatcher().useMutableSource(arg1, arg2, arg3)
end

return module
