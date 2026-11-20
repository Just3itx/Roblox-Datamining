-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T12:30:39Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local ReactGlobals = require(scriptParentParent.ReactGlobals)

local console = require(scriptParentParent.Shared).console
local _LuauPolyfill = require(scriptParentParent.LuauPolyfill)

local module = {}

local function isCallable(arg1) -- Luacid: Inlined by compiler; 3 call sites recovered
    if typeof(arg1) == "function" then
        return true
    end
    if typeof(arg1) == "table" then
        local var1 = getmetatable(arg1)
        if var1 and rawget(var1, "__call") then
            return true
        end
        if arg1._isMockFunction then
            return true
        end
    end
    return false
end

local enableProfilerTimer = require(scriptParentParent.Shared).ReactFeatureFlags.enableProfilerTimer

local _ReactInternalTypes = require(script.Parent.ReactInternalTypes)

local _Shared = require(scriptParentParent.Shared)

local DidCapture = require(script.Parent.ReactFiberFlags).DidCapture

local var1 = nil
local var2 = nil
local bool1 = false

function module.isDevToolsPresent(): boolean
    return ReactGlobals.__REACT_DEVTOOLS_GLOBAL_HOOK__ ~= nil
end

function module.injectInternals(arg1): boolean
    if ReactGlobals.__REACT_DEVTOOLS_GLOBAL_HOOK__ == nil then
        return false
    end
    local __reactDevtoolsGlobalHook = ReactGlobals.__REACT_DEVTOOLS_GLOBAL_HOOK__
    if __reactDevtoolsGlobalHook.isDisabled then
        return true
    end
    if not __reactDevtoolsGlobalHook.supportsFiber then
        if ReactGlobals.__DEV__ then
            console.error(
                "The installed version of React DevTools is too old and will not work with the current version of React. Please update React DevTools. https://reactjs.org/link/react-devtools"
            )
        end

        return true
    end
    local success, result = pcall(function()
        var1 = __reactDevtoolsGlobalHook.inject(arg1)

        var2 = __reactDevtoolsGlobalHook
    end)

    if not success and ReactGlobals.__DEV__ then
        console.error("React instrumentation encountered an error: %s.", result)
    end

    return true
end

function module.onScheduleRoot(arg1, arg2)
    if not ReactGlobals.__DEV__ or not var2 or not isCallable(var2.onScheduleFiberRoot) then
        return
    end

    local success, result = pcall(var2.onScheduleFiberRoot, var1, arg1, arg2)

    if not success and ReactGlobals.__DEV__ and not bool1 then
        bool1 = true
        console.error("React instrumentation encountered an error: %s", result)
    end
end

function module.onCommitRoot(arg1, arg2)
    if not var2 or not isCallable(var2.onCommitFiberRoot) then
        return
    end
    local success, result = pcall(function()
        local bool2 = bit32.band(arg1.current.flags, DidCapture) == DidCapture
        if enableProfilerTimer then
            var2.onCommitFiberRoot(var1, arg1, arg2, bool2)
            return
        end
        var2.onCommitFiberRoot(var1, arg1, nil, bool2)
    end)

    if not success and ReactGlobals.__DEV__ and not bool1 then
        bool1 = true
        console.error("React instrumentation encountered an error: %s", result)
    end
end

function module.onCommitUnmount(arg1)
    if not var2 or not isCallable(var2.onCommitFiberUnmount) then
        return
    end
    local success, result = pcall(var2.onCommitFiberUnmount, var1, arg1)
    if not success and ReactGlobals.__DEV__ and not bool1 then
        bool1 = true
        console.error("React instrumentation encountered an error: %s", result)
    end
end

return module
