-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T02:21:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local tbl1 = {}
local scriptParentParentParentParent = script.Parent.Parent.Parent.Parent
local Boolean = require(scriptParentParentParentParent.LuauPolyfill).Boolean
local default = require(script.Parent.Parent.common.global).default

tbl1.default = (function() -- name: getDEV; Luacid: Inlined by compiler; 1 call site recovered
    local _success, result = xpcall(function()
        return Boolean.toJSBoolean(_G.__DEV__)
    end, function()
        default.__DEV__ = true

        return default.__DEV__
    end)
    return result
end)()
return tbl1
