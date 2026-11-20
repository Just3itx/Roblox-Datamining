-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T12:20:51Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local ReactGlobals = require(scriptParent.ReactGlobals)

local console = require(scriptParent.Shared).console

local module = {}

local ReactSymbols = require(scriptParent.Shared).ReactSymbols

local REACT_CONTEXT_TYPE = ReactSymbols.REACT_CONTEXT_TYPE
local REACT_ELEMENT_TYPE = ReactSymbols.REACT_ELEMENT_TYPE
local REACT_FORWARD_REF_TYPE = ReactSymbols.REACT_FORWARD_REF_TYPE
local REACT_FRAGMENT_TYPE = ReactSymbols.REACT_FRAGMENT_TYPE
local REACT_LAZY_TYPE = ReactSymbols.REACT_LAZY_TYPE
local REACT_MEMO_TYPE = ReactSymbols.REACT_MEMO_TYPE
local REACT_PORTAL_TYPE = ReactSymbols.REACT_PORTAL_TYPE
local REACT_PROFILER_TYPE = ReactSymbols.REACT_PROFILER_TYPE
local REACT_PROVIDER_TYPE = ReactSymbols.REACT_PROVIDER_TYPE
local REACT_STRICT_MODE_TYPE = ReactSymbols.REACT_STRICT_MODE_TYPE
local REACT_SUSPENSE_TYPE = ReactSymbols.REACT_SUSPENSE_TYPE
local REACT_SUSPENSE_LIST_TYPE = ReactSymbols.REACT_SUSPENSE_LIST_TYPE

local isValidElementType = require(scriptParent.Shared).isValidElementType

local REACT_BINDING_TYPE = ReactSymbols.REACT_BINDING_TYPE

local var1 = require(scriptParent.SafeFlags).createGetFFlag("ReactIsProtectedTypeOf", false)()

local function typeOf(arg1)
    if typeof(arg1) == "table" and arg1 ~= nil then
        local typeof2

        if var1 then
            local success

            success, typeof2 = pcall(function()
                return arg1["$$typeof"]
            end)

            if not success then
                return nil
            end
        else
            typeof2 = arg1["$$typeof"]
        end

        if typeof2 == REACT_ELEMENT_TYPE then
            local type = arg1.type

            if type == REACT_FRAGMENT_TYPE
                or type == REACT_PROFILER_TYPE
                or type == REACT_STRICT_MODE_TYPE
                or type == REACT_SUSPENSE_TYPE
                or type == REACT_SUSPENSE_LIST_TYPE
            then
                return type
            end

            if type then
                if typeof(type) == "table" then
                    type = type["$$typeof"]
                else
                    type = false
                end
            end
            return if type == REACT_CONTEXT_TYPE
                or type == REACT_FORWARD_REF_TYPE
                or type == REACT_LAZY_TYPE
                or type == REACT_MEMO_TYPE
                or type == REACT_PROVIDER_TYPE then type else typeof2
        end

        if typeof2 == REACT_PORTAL_TYPE or typeof2 == REACT_BINDING_TYPE then
            return typeof2
        end
    end

    return nil
end
module.typeOf = typeOf

module.ContextConsumer = REACT_CONTEXT_TYPE

module.ContextProvider = REACT_PROVIDER_TYPE

module.Element = REACT_ELEMENT_TYPE

module.ForwardRef = REACT_FORWARD_REF_TYPE

module.Fragment = REACT_FRAGMENT_TYPE

module.Lazy = REACT_LAZY_TYPE

module.Memo = REACT_MEMO_TYPE

module.Portal = REACT_PORTAL_TYPE

module.Profiler = REACT_PROFILER_TYPE

module.StrictMode = REACT_STRICT_MODE_TYPE

module.Suspense = REACT_SUSPENSE_TYPE

module.Binding = ReactSymbols.REACT_BINDING_TYPE

module.isValidElementType = isValidElementType
local bool1 = false
local bool2 = false
function module.isAsyncMode(_): boolean
    if ReactGlobals.__DEV__ and not bool1 then
        bool1 = true
        console.warn("The ReactIs.isAsyncMode() alias has been deprecated, and will be removed in React 18+.")
    end

    return false
end

function module.isConcurrentMode(_): boolean
    if ReactGlobals.__DEV__ and not bool2 then
        bool2 = true
        console.warn("The ReactIs.isConcurrentMode() alias has been deprecated, and will be removed in React 18+.")
    end

    return false
end

function module.isContextConsumer(arg1): boolean
    return typeOf(arg1) == REACT_CONTEXT_TYPE
end

function module.isContextProvider(arg1): boolean
    return typeOf(arg1) == REACT_PROVIDER_TYPE
end

function module.isElement(arg1): boolean
    return typeof(arg1) == "table" and arg1 ~= nil and arg1["$$typeof"] == REACT_ELEMENT_TYPE
end

function module.isForwardRef(arg1): boolean
    return typeOf(arg1) == REACT_FORWARD_REF_TYPE
end

function module.isFragment(arg1): boolean
    return typeOf(arg1) == REACT_FRAGMENT_TYPE
end

function module.isLazy(arg1): boolean
    return typeOf(arg1) == REACT_LAZY_TYPE
end

function module.isMemo(arg1): boolean
    return typeOf(arg1) == REACT_MEMO_TYPE
end

function module.isPortal(arg1): boolean
    return typeOf(arg1) == REACT_PORTAL_TYPE
end

function module.isProfiler(arg1): boolean
    return typeOf(arg1) == REACT_PROFILER_TYPE
end

function module.isStrictMode(arg1): boolean
    return typeOf(arg1) == REACT_STRICT_MODE_TYPE
end

function module.isSuspense(arg1): boolean
    return typeOf(arg1) == REACT_SUSPENSE_TYPE
end

function module.isBinding(arg1): boolean
    return typeOf(arg1) == REACT_BINDING_TYPE
end

return module
