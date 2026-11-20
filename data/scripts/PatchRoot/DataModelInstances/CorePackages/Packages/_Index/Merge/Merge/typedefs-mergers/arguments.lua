-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T09:50:36Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local LuauPolyfill = require(scriptParentParentParent.LuauPolyfill)
local Array = LuauPolyfill.Array
local Boolean = LuauPolyfill.Boolean

local module = {}

local _GraphQL = require(scriptParentParentParent.GraphQL)

local _mergeTypedefs_types = require(script.Parent["merge-typedefs_types"])

local Utils = require(scriptParentParentParent.Utils)

local compareNodes = Utils.compareNodes
local isSome = Utils.isSome

local deduplicateArguments = nil

function module.mergeArguments(arg1, arg2, arg3)
    local var1 = deduplicateArguments(Array.filter(Array.concat({}, arg2, arg1), isSome))

    if arg3 and arg3.sort then
        Array.sort(var1, compareNodes)
    end
    return var1
end

deduplicateArguments = function(arg1)
    return Array.reduce(arg1, function(arg2, arg3)
        local var1 = Array.find(arg2, function(arg4): boolean
            return arg4.name.value == arg3.name.value
        end)
        if not Boolean.toJSBoolean(var1) then
            return Array.concat(arg2, { arg3 })
        end
        return arg2
    end, {})
end
return module
