-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T08:11:14Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent
local Array = require(scriptParentParentParentParent.LuauPolyfill).Array

local GraphQLError = require(scriptParentParentParent.error.GraphQLError).GraphQLError
local language = scriptParentParentParent.language
local jsutils = scriptParentParentParent.jsutils
local inspect = require(jsutils.inspect).inspect
local invariant = require(jsutils.invariant).invariant
local Kind = require(language.kinds).Kind
local DirectiveLocation = require(language.directiveLocation).DirectiveLocation
local specifiedDirectives = require(scriptParentParentParent.type.directives).specifiedDirectives

local module = {}

local getDirectiveLocationForASTPath = nil
local getDirectiveLocationForOperation = nil

function module.KnownDirectivesRule(arg1)
    local tbl1 = {}

    local schema = arg1:getSchema()
    local var1 = specifiedDirectives
    if schema then
        var1 = schema:getDirectives()
    end
    for _, value in ipairs(var1) do
        tbl1[value.name] = value.locations
    end

    local definitions = arg1:getDocument().definitions
    for _, definition in ipairs(definitions) do
        if definition.kind == Kind.DIRECTIVE_DEFINITION then
            tbl1[definition.name.value] = Array.map(definition.locations, function(arg2)
                return arg2.value
            end)
        end
    end

    return {
        Directive = function(_, arg2, _, _, _, arg3)
            local value = arg2.name.value
            local var2 = tbl1[value]

            if not var2 then
                arg1:reportError(GraphQLError.new(("Unknown directive \"@%s\"."):format(value), arg2))

                return
            end

            local directiveLocationForAstPath = getDirectiveLocationForASTPath(arg3)

            if directiveLocationForAstPath and Array.indexOf(var2, directiveLocationForAstPath) == -1 then
                arg1:reportError(
                    GraphQLError.new(("Directive \"@%s\" may not be used on %s."):format(value, directiveLocationForAstPath), arg2)
                )
            end
        end
    }
end

getDirectiveLocationForASTPath = function(arg1)
    local var1 = arg1[#arg1]
    invariant(not Array.isArray(var1))

    local kind = var1.kind
    if kind == Kind.OPERATION_DEFINITION then
        return getDirectiveLocationForOperation(var1.operation)
    end

    if kind == Kind.FIELD then
        return DirectiveLocation.FIELD
    end

    if kind == Kind.FRAGMENT_SPREAD then
        return DirectiveLocation.FRAGMENT_SPREAD
    end

    if kind == Kind.INLINE_FRAGMENT then
        return DirectiveLocation.INLINE_FRAGMENT
    end

    if kind == Kind.FRAGMENT_DEFINITION then
        return DirectiveLocation.FRAGMENT_DEFINITION
    end

    if kind == Kind.VARIABLE_DEFINITION then
        return DirectiveLocation.VARIABLE_DEFINITION
    end

    if kind == Kind.SCHEMA_DEFINITION or kind == Kind.SCHEMA_EXTENSION then
        return DirectiveLocation.SCHEMA
    end

    if kind == Kind.SCALAR_TYPE_DEFINITION or kind == Kind.SCALAR_TYPE_EXTENSION then
        return DirectiveLocation.SCALAR
    end

    if kind == Kind.OBJECT_TYPE_DEFINITION or kind == Kind.OBJECT_TYPE_EXTENSION then
        return DirectiveLocation.OBJECT
    end

    if kind == Kind.FIELD_DEFINITION then
        return DirectiveLocation.FIELD_DEFINITION
    end

    if kind == Kind.INTERFACE_TYPE_DEFINITION or kind == Kind.INTERFACE_TYPE_EXTENSION then
        return DirectiveLocation.INTERFACE
    end

    if kind == Kind.UNION_TYPE_DEFINITION or kind == Kind.UNION_TYPE_EXTENSION then
        return DirectiveLocation.UNION
    end

    if kind == Kind.ENUM_TYPE_DEFINITION or kind == Kind.ENUM_TYPE_EXTENSION then
        return DirectiveLocation.ENUM
    end

    if kind == Kind.ENUM_VALUE_DEFINITION then
        return DirectiveLocation.ENUM_VALUE
    end

    if kind == Kind.INPUT_OBJECT_TYPE_DEFINITION or kind == Kind.INPUT_OBJECT_TYPE_EXTENSION then
        return DirectiveLocation.INPUT_OBJECT
    end

    if kind == Kind.INPUT_VALUE_DEFINITION then
        return arg1[#arg1 - 2].kind == Kind.INPUT_OBJECT_TYPE_DEFINITION and DirectiveLocation.INPUT_FIELD_DEFINITION
            or DirectiveLocation.ARGUMENT_DEFINITION
    end

    return nil
end

getDirectiveLocationForOperation = function(arg1)
    if arg1 == "query" then
        return DirectiveLocation.QUERY
    elseif arg1 == "mutation" then
        return DirectiveLocation.MUTATION
    elseif arg1 == "subscription" then
        return DirectiveLocation.SUBSCRIPTION
    end

    invariant(false, "Unexpected operation: " .. inspect(arg1))

    return nil
end

return module
