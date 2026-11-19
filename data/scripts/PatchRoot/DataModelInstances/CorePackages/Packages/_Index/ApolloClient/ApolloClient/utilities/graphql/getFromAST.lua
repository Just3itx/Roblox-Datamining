-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T05:50:32Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local module = {}

local scriptParentParentParent = script.Parent.Parent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent
local LuauPolyfill = require(scriptParentParentParentParent.LuauPolyfill)
local Array = LuauPolyfill.Array
local Boolean = LuauPolyfill.Boolean

local _GraphQL = require(scriptParentParentParentParent.GraphQL)

local invariant = require(scriptParentParentParent.jsutils.invariant)
local invariant2 = invariant.invariant
local InvariantError = invariant.InvariantError
local valueToObjectRepresentation = require(script.Parent.storeUtils).valueToObjectRepresentation

local function checkDocument(arg1)
    invariant2(
        arg1 and arg1.kind == "Document",
        "Expecting a parsed GraphQL document. Perhaps you need to wrap the query string in a \"gql\" tag? http://docs.apollostack.com/apollo-client/core.html#gql"
    )

    local var1 = Array.map(Array.filter(arg1.definitions, function(arg2): boolean
        return arg2.kind ~= "FragmentDefinition"
    end), function(arg2)
        if arg2.kind ~= "OperationDefinition" then
            error(InvariantError.new(("Schema type definitions not allowed in queries. Found: \"%s\""):format(arg2.kind)))
        end

        return arg2
    end)

    local var2 = invariant2
    local bool1 = #var1 <= 1
    local num1 = #var1
    var2(bool1, ("Ambiguous GraphQL document: contains %s operations"):format(tostring(num1)))

    return arg1
end
module.checkDocument = checkDocument

local function getOperationDefinition(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    checkDocument(arg1)
    return Array.filter(arg1.definitions, function(arg2): boolean
        return arg2.kind == "OperationDefinition"
    end)[1]
end
module.getOperationDefinition = getOperationDefinition

function module.getOperationName(arg1)
    local var1 = Array.map(Array.filter(arg1.definitions, function(arg2)
        return if Boolean.toJSBoolean(arg2.kind == "OperationDefinition") then arg2.name else arg2.kind == "OperationDefinition"
    end), function(arg2)
        return Boolean.toJSBoolean(arg2) and Boolean.toJSBoolean(arg2.name) and arg2.name.value or nil
    end)

    return Boolean.toJSBoolean(var1[1]) and var1[1] or nil
end

function module.getFragmentDefinitions(arg1)
    return (Array.filter(arg1.definitions, function(arg2): boolean
        return arg2.kind == "FragmentDefinition"
    end))
end

function module.getQueryDefinition(arg1)
    local operationDefinition = getOperationDefinition(arg1)
    invariant2(
        Boolean.toJSBoolean(operationDefinition) and operationDefinition.operation == "query",
        "Must contain a query definition."
    )
    return operationDefinition
end

function module.getFragmentDefinition(arg1)
    invariant2(
        arg1.kind == "Document",
        "Expecting a parsed GraphQL document. Perhaps you need to wrap the query string in a \"gql\" tag? http://docs.apollostack.com/apollo-client/core.html#gql"
    )

    invariant2(#arg1.definitions <= 1, "Fragment must have exactly one definition.")

    local definition = arg1.definitions[1]

    invariant2(definition.kind == "FragmentDefinition", "Must be a fragment definition.")

    return definition
end

function module.getMainDefinition(arg1)
    checkDocument(arg1)

    local var1 = nil

    for _, definition in ipairs(arg1.definitions) do
        if definition.kind == "OperationDefinition" then
            local operation = definition.operation

            if operation == "query" or operation == "mutation" or operation == "subscription" then
                return definition
            end
        end
        if definition.kind == "FragmentDefinition" and not Boolean.toJSBoolean(var1) then
            var1 = definition
        end
    end

    if Boolean.toJSBoolean(var1) then
        return var1
    end

    error(InvariantError.new("Expected a parsed GraphQL query with a query, mutation, subscription, or a fragment."))
end

function module.getDefaultValues(arg1)
    local defaultValues = {}
    local variableDefinitions = if arg1 == nil then nil else arg1.variableDefinitions

    if variableDefinitions ~= nil and #variableDefinitions > 0 then
        Array.forEach(variableDefinitions, function(arg2)
            if Boolean.toJSBoolean(arg2.defaultValue) then
                valueToObjectRepresentation(defaultValues, arg2.variable.name, arg2.defaultValue)
            end
        end)
    end
    return defaultValues
end

return module
