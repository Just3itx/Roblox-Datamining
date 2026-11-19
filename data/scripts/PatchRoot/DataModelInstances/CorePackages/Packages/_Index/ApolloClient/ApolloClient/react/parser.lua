-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T05:41:06Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local module = {}
local scriptParentParent = script.Parent.Parent
local scriptParentParentParent = scriptParentParent.Parent
local LuauPolyfill = require(scriptParentParentParent.LuauPolyfill)
local Array = LuauPolyfill.Array
local Boolean = LuauPolyfill.Boolean

local _GraphQL = require(scriptParentParentParent.GraphQL)

local invariant = require(scriptParentParent.jsutils.invariant).invariant

local Map = LuauPolyfill.Map

local DocumentType = { Query = 0, Mutation = 1, Subscription = 2 }

module.DocumentType = DocumentType

local map = Map.new(nil)
function module.operationName(num1: number)
    local var1 = nil

    if num1 == DocumentType.Query then
        return "Query"
    end

    if num1 == DocumentType.Mutation then
        return "Mutation"
    end

    if num1 == DocumentType.Subscription then
        var1 = "Subscription"
    end

    return var1
end

function module.parser(arg1)
    local var1 = map:get(arg1)
    if var1 ~= nil then
        return var1
    end

    invariant(
        Boolean.toJSBoolean(arg1) and Boolean.toJSBoolean(arg1.kind),
        ("Argument of %s passed to parser was not a valid GraphQL "):format(tostring(arg1)) .. "DocumentNode. You may need to use 'graphql-tag' or another method to convert your operation into a document"
    )
    local var2 = Array.filter(arg1.definitions, function(arg2): boolean
        return arg2.kind == "FragmentDefinition"
    end)

    local var3 = Array.filter(arg1.definitions, function(arg2): boolean
        return arg2.kind == "OperationDefinition" and arg2.operation == "query"
    end)

    local var4 = Array.filter(arg1.definitions, function(arg2): boolean
        return arg2.kind == "OperationDefinition" and arg2.operation == "mutation"
    end)

    local var5 = Array.filter(arg1.definitions, function(arg2): boolean
        return arg2.kind == "OperationDefinition" and arg2.operation == "subscription"
    end)

    invariant(
        #var2 == 0 or #var3 ~= 0 or #var4 ~= 0 or #var5 ~= 0,
        "Passing only a fragment to 'graphql' is not yet supported. You must include a query, subscription or mutation as well"
    )

    local var6 = invariant
    local bool1 = #var3 + #var4 + #var5 <= 1

    local str1 = tostring(arg1)
    local str2 = tostring(#var3)
    local num1 = #var5
    local str3 = ("%s had %s queries, %s "):format(str1, str2, tostring(num1))
    local num2 = #var4
    var6(
        bool1,
        "react-apollo only supports a query, subscription, or a mutation per HOC. " .. str3 .. ("subscriptions and %s mutations. "):format(tostring(num2)) .. "You can use 'compose' to join multiple operation types to a component"
    )
    local num3 = if #var3 ~= 0 then DocumentType.Query else DocumentType.Mutation

    if #var3 == 0 and #var4 == 0 then
        num3 = DocumentType.Subscription
    end

    if #var3 > 0 then
        var5 = var3
    elseif #var4 > 0 then
        var5 = var4
    end
    local var7 = invariant
    local bool2 = #var5 == 1
    local str4 = ("react-apollo only supports one definition per HOC. %s had "):format(tostring(arg1))
    local num4 = #var5
    var7(
        bool2,
        str4 .. ("%s definitions. "):format(tostring(num4)) .. "You can use 'compose' to join multiple operation types to a component"
    )

    local var8 = var5[1]
    local variables = not var8.variableDefinitions and {} or var8.variableDefinitions or {}
    local tbl2 = {
        name = if not var8.name or var8.name.kind ~= "Name" then "data" else var8.name.value,
        type = num3,
        variables = variables
    }
    map:set(arg1, tbl2)
    return tbl2
end
return module
