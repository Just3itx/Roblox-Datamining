-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T20:01:16Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local Boolean = require(scriptParentParent.LuauPolyfill).Boolean
local module = {}
local GraphQL = require(scriptParentParent.GraphQL)

local doTypesOverlap = GraphQL.doTypesOverlap
local isCompositeType = GraphQL.isCompositeType

local _types = require(script.Parent.types)

function module.implementsAbstractType(arg1, arg2, arg3)
    if arg3 == nil or arg2 == nil then
        return false
    elseif arg2 == arg3 then
        return true
    else
        local toJsBoolean = Boolean.toJSBoolean
        local var1 = isCompositeType(arg2)
        if Boolean.toJSBoolean(var1) then
            var1 = isCompositeType(arg3)
        end

        if toJsBoolean(var1) then
            return doTypesOverlap(arg1, arg2, arg3)
        end
        return false
    end
end

return module
