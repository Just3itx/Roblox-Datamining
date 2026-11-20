-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T09:50:45Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local LuauPolyfill = require(scriptParentParentParent.LuauPolyfill)
local Array = LuauPolyfill.Array
local Boolean = LuauPolyfill.Boolean

local module = {}

local _GraphQL = require(scriptParentParentParent.GraphQL)

local _mergeTypedefs_types = require(script.Parent["merge-typedefs_types"])

local compareNodes = require(scriptParentParentParent.Utils).compareNodes

local function alreadyExists(arg1, arg2): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    return not not Boolean.toJSBoolean(Array.find(arg1, function(arg3): boolean
        return arg3.name.value == arg2.name.value
    end))
end

function module.mergeNamedTypeArray(arg1, arg2, arg3)
    local var1 = arg2 == nil and {} or arg2
    local var2 = arg3 == nil and {} or arg3

    local var3 = Array.concat({}, var1, Array.filter(arg1 == nil and {} or arg1, function(arg4): boolean
        return not Boolean.toJSBoolean((alreadyExists(var1, arg4)))
    end))

    if var2 and Boolean.toJSBoolean(var2.sort) then
        Array.sort(var3, compareNodes)
    end
    return var3
end

return module
