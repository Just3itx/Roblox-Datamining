-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T15:11:27Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ReactSymbols = require(script.Parent.ReactSymbols)
local REACT_CONTEXT_TYPE = ReactSymbols.REACT_CONTEXT_TYPE
local REACT_FORWARD_REF_TYPE = ReactSymbols.REACT_FORWARD_REF_TYPE
local REACT_FRAGMENT_TYPE = ReactSymbols.REACT_FRAGMENT_TYPE
local REACT_PROFILER_TYPE = ReactSymbols.REACT_PROFILER_TYPE
local REACT_PROVIDER_TYPE = ReactSymbols.REACT_PROVIDER_TYPE
local REACT_DEBUG_TRACING_MODE_TYPE = ReactSymbols.REACT_DEBUG_TRACING_MODE_TYPE
local REACT_STRICT_MODE_TYPE = ReactSymbols.REACT_STRICT_MODE_TYPE
local REACT_SUSPENSE_TYPE = ReactSymbols.REACT_SUSPENSE_TYPE

local REACT_MEMO_TYPE = ReactSymbols.REACT_MEMO_TYPE
local REACT_LAZY_TYPE = ReactSymbols.REACT_LAZY_TYPE
local REACT_FUNDAMENTAL_TYPE = ReactSymbols.REACT_FUNDAMENTAL_TYPE

local REACT_BLOCK_TYPE = ReactSymbols.REACT_BLOCK_TYPE
local REACT_SERVER_BLOCK_TYPE = ReactSymbols.REACT_SERVER_BLOCK_TYPE
local REACT_LEGACY_HIDDEN_TYPE = ReactSymbols.REACT_LEGACY_HIDDEN_TYPE

return function(arg1)
    local str1 = typeof(arg1)
    if str1 == "string" or str1 == "function" then
        return true
    end

    if arg1 == REACT_FRAGMENT_TYPE
        or arg1 == REACT_PROFILER_TYPE
        or arg1 == REACT_DEBUG_TRACING_MODE_TYPE
        or arg1 == REACT_STRICT_MODE_TYPE
        or arg1 == REACT_SUSPENSE_TYPE
        or arg1 == REACT_LEGACY_HIDDEN_TYPE
    then
        return true
    end

    if str1 == "table" then
        if arg1.isReactComponent then
            return true
        end

        if arg1["$$typeof"] == REACT_LAZY_TYPE
            or arg1["$$typeof"] == REACT_MEMO_TYPE
            or arg1["$$typeof"] == REACT_PROVIDER_TYPE
            or arg1["$$typeof"] == REACT_CONTEXT_TYPE
            or arg1["$$typeof"] == REACT_FORWARD_REF_TYPE
            or arg1["$$typeof"] == REACT_FUNDAMENTAL_TYPE
            or arg1["$$typeof"] == REACT_BLOCK_TYPE
            or arg1[1] == REACT_SERVER_BLOCK_TYPE
        then
            return true
        end
    end

    return false
end
