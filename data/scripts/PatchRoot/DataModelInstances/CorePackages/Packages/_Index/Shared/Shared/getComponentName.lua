-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T15:11:23Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local ReactGlobals = require(scriptParentParent.ReactGlobals)

local console = require(script.Parent.console)

local ReactSymbols = require(script.Parent.ReactSymbols)
local REACT_CONTEXT_TYPE = ReactSymbols.REACT_CONTEXT_TYPE
local REACT_FORWARD_REF_TYPE = ReactSymbols.REACT_FORWARD_REF_TYPE
local REACT_FRAGMENT_TYPE = ReactSymbols.REACT_FRAGMENT_TYPE
local REACT_PORTAL_TYPE = ReactSymbols.REACT_PORTAL_TYPE
local REACT_MEMO_TYPE = ReactSymbols.REACT_MEMO_TYPE
local REACT_PROFILER_TYPE = ReactSymbols.REACT_PROFILER_TYPE
local REACT_PROVIDER_TYPE = ReactSymbols.REACT_PROVIDER_TYPE
local REACT_STRICT_MODE_TYPE = ReactSymbols.REACT_STRICT_MODE_TYPE
local REACT_SUSPENSE_TYPE = ReactSymbols.REACT_SUSPENSE_TYPE
local REACT_SUSPENSE_LIST_TYPE = ReactSymbols.REACT_SUSPENSE_LIST_TYPE
local REACT_LAZY_TYPE = ReactSymbols.REACT_LAZY_TYPE
local REACT_BLOCK_TYPE = ReactSymbols.REACT_BLOCK_TYPE
local _ReactTypes = require(script.Parent.ReactTypes)

local describeError = require(script.Parent["ErrorHandling.roblox"]).describeError

local function getWrappedName(arg1, render, str1: string) -- Luacid: Inlined by compiler; 1 call site recovered
    local var1 = if typeof(render) ~= "table" then "<function>" else render.displayName or render.name or ""

    local displayName = arg1.displayName

    if displayName then
        str1 = displayName
    elseif var1 ~= "" then
        str1 = string.format("%s(%s)", str1, var1) or str1
    end

    return str1
end

local function getContextName(arg1) -- Luacid: Inlined by compiler; 2 call sites recovered
    return arg1.displayName or "Context"
end

local function getComponentName(arg1)
    if arg1 == nil then
        return nil
    end
    local str1 = typeof(arg1)

    if ReactGlobals.__DEV__ and str1 == "table" and typeof(arg1.tag) == "number" then
        console.warn(
            "Received an unexpected object in getComponentName(). This is likely a bug in React. Please file an issue."
        )
    end

    if str1 == "function" then
        local var1 = debug.info(arg1, "n")

        if var1 and string.len(var1) > 0 then
            return var1
        end
        local var2, var3 = debug.info(arg1, "sl")
        return string.format("%s:%d", var2, var3)
    elseif str1 == "string" then
        return arg1
    end

    if arg1 == REACT_FRAGMENT_TYPE then
        return "Fragment"
    end

    if arg1 == REACT_PORTAL_TYPE then
        return "Portal"
    end

    if arg1 == REACT_PROFILER_TYPE then
        return "Profiler"
    end

    if arg1 == REACT_STRICT_MODE_TYPE then
        return "StrictMode"
    end

    if arg1 == REACT_SUSPENSE_TYPE then
        return "Suspense"
    end

    if arg1 == REACT_SUSPENSE_LIST_TYPE then
        return "SuspenseList"
    end

    if str1 == "table" then
        local typeof = arg1["$$typeof"]
        if typeof == REACT_CONTEXT_TYPE then
            return getContextName(arg1) .. ".Consumer"
        end

        if typeof == REACT_PROVIDER_TYPE then
            return getContextName(arg1._context) .. ".Provider"
        end

        if typeof == REACT_FORWARD_REF_TYPE then
            return (getWrappedName(arg1, arg1.render, "ForwardRef"))
        end

        if typeof == REACT_MEMO_TYPE then
            return getComponentName(arg1.type)
        end

        if typeof == REACT_BLOCK_TYPE then
            return getComponentName(arg1._render)
        end

        if typeof == REACT_LAZY_TYPE then
            local _payload = arg1._payload
            local success, result = xpcall(arg1._init, describeError, _payload)
            if success then
                return getComponentName(result)
            end
            return nil
        end

        if arg1.displayName then
            return arg1.displayName
        end
        if arg1.name then
            return arg1.name
        end

        local var1 = getmetatable(arg1)
        if var1 and rawget(var1, "__tostring") then
            return tostring(arg1)
        end
    end

    return nil
end

return getComponentName
