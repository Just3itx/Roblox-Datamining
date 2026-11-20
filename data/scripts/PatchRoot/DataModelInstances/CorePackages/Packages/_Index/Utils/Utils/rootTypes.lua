-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T20:10:43Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local LuauPolyfill = require(scriptParentParent.LuauPolyfill)
local Array = LuauPolyfill.Array
local Boolean = LuauPolyfill.Boolean
local Error = LuauPolyfill.Error
local Map = LuauPolyfill.Map
local Set = LuauPolyfill.Set

local module = {}
local _GraphQL = require(scriptParentParent.GraphQL)

local memoize1 = require(script.Parent.memoize).memoize1

local var1 = nil
local var2 = nil

function module.getDefinedRootType(arg1, arg2)
    local var3 = var1(arg1):get(arg2)
    if var3 == nil then
        error(Error.new(("Root type for operation \"%s\" not defined by the given schema."):format(tostring(arg2))))
    end

    return var3
end

local function setToArray(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    local result = {}
    arg1:forEach(function(arg2)
        table.insert(result, arg2)
    end)
    return result
end

module.getRootTypeNames = memoize1(function(arg1)
    local var3 = var2(arg1)

    return Set.new(Array.map(Array.concat({}, (setToArray(var3))), function(arg2)
        return arg2.name
    end))
end)
var2 = memoize1(function(arg1)
    local var3 = var1(arg1)
    return Set.new(var3:values())
end)
module.getRootTypes = var2

var1 = memoize1(function(arg1)
    local map = Map.new()
    local queryType = arg1:getQueryType()
    if Boolean.toJSBoolean(queryType) then
        map:set("query", queryType)
    end

    local mutationType = arg1:getMutationType()
    if Boolean.toJSBoolean(mutationType) then
        map:set("mutation", mutationType)
    end

    local subscriptionType = arg1:getSubscriptionType()
    if Boolean.toJSBoolean(subscriptionType) then
        map:set("subscription", subscriptionType)
    end

    return map
end)
module.getRootTypeMap = var1
return module
