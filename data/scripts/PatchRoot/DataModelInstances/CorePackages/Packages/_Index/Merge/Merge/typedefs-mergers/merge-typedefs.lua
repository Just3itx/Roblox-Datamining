-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T09:50:48Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local LuauPolyfill = require(scriptParentParentParent.LuauPolyfill)
local Array = LuauPolyfill.Array
local Boolean = LuauPolyfill.Boolean
local Error = LuauPolyfill.Error
local Object = LuauPolyfill.Object
local Set = LuauPolyfill.Set

local module = {}

local _mergeTypedefs_types = require(script.Parent["merge-typedefs_types"])

local mergeGraphQLTypes = nil

local GraphQL = require(scriptParentParentParent.GraphQL)

local parse = GraphQL.parse
local Kind = GraphQL.Kind
local isSchema = GraphQL.isSchema

local isDefinitionNode = GraphQL.isDefinitionNode

local utils = require(script.Parent.utils)

local defaultStringComparator = utils.defaultStringComparator
local isSourceTypes = utils.isSourceTypes
local isStringTypes = utils.isStringTypes
local mergeNodes = require(script.Parent["merge-nodes"])

local mergeGraphQLNodes = mergeNodes.mergeGraphQLNodes
local schemaDefSymbol = mergeNodes.schemaDefSymbol

local Utils = require(scriptParentParentParent.Utils)

local getDocumentNodeFromSchema = Utils.getDocumentNodeFromSchema

local isDocumentNode = Utils.isDocumentNode

local resetComments = Utils.resetComments
local printWithComments = Utils.printWithComments

local DEFAULT_OPERATION_TYPE_NAME_MAP = require(script.Parent["schema-def"]).DEFAULT_OPERATION_TYPE_NAME_MAP

function module.mergeTypeDefs(arg1, arg2)
    resetComments()
    local tbl1 = {
        kind = Kind.DOCUMENT,
        definitions = mergeGraphQLTypes(
            arg1,
            Object.assign(
                {},
                {
                    useSchemaDefinition = true,
                    forceSchemaDefinition = false,
                    throwOnConflict = false,
                    commentDescriptions = false
                },
                arg2
            )
        )
    }

    if arg2 and arg2.commentDescriptions then
        tbl1 = printWithComments(tbl1)
    end

    resetComments()
    return tbl1
end

local function visitTypeSources(arg1, arg2, arg3, arg4)
    local var1 = arg3 == nil and {} or arg3
    if arg4 == nil then
        arg4 = Set.new()
    end
    local toJsBoolean = Boolean.toJSBoolean

    if toJsBoolean(if Boolean.toJSBoolean(arg1) then not Boolean.toJSBoolean(arg4:has(arg1)) else arg1) then
        arg4:add(arg1)
        if typeof(arg1) == "function" then
            visitTypeSources(arg1(), arg2, var1, arg4)
            return var1
        end

        if Boolean.toJSBoolean(Array.isArray(arg1)) then
            for _, value in arg1 do
                visitTypeSources(value, arg2, var1, arg4)
            end

            return var1
        end
        if Boolean.toJSBoolean(isSchema(arg1)) then
            local documentNodeFromSchema = getDocumentNodeFromSchema(arg1, arg2)

            visitTypeSources(documentNodeFromSchema.definitions, arg2, var1, arg4)
            return var1
        end

        local toJsBoolean2 = Boolean.toJSBoolean
        local var2 = isStringTypes(arg1)

        if toJsBoolean2(Boolean.toJSBoolean(var2) and var2 or isSourceTypes(arg1)) then
            local var3 = parse(arg1, arg2)

            visitTypeSources(var3.definitions, arg2, var1, arg4)
            return var1
        end

        local toJsBoolean3 = Boolean.toJSBoolean

        if toJsBoolean3(typeof(arg1) == "table" and isDefinitionNode(arg1)) then
            table.insert(var1, arg1)
            return var1
        end
        if isDocumentNode(arg1) then
            visitTypeSources(arg1.definitions, arg2, var1, arg4)
            return var1
        end

        local error = error
        local new = Error.new

        local str1 = typeof(arg1)
        error(new(("typeDefs must contain only strings, documents, schemas, or functions, got %s"):format(tostring(str1))))
    end

    return var1
end

mergeGraphQLTypes = function(arg1, arg2)
    resetComments()
    local var1 = visitTypeSources(arg1, arg2)
    local var2 = mergeGraphQLNodes(var1, arg2)

    if arg2 and Boolean.toJSBoolean(arg2.useSchemaDefinition) then
        local var3 = Boolean.toJSBoolean(var2:get(schemaDefSymbol)) and var2:get(schemaDefSymbol)
            or {
                kind = Kind.SCHEMA_DEFINITION,
                operationTypes = {}
            }
        local operationTypes = var3.operationTypes

        for operation in DEFAULT_OPERATION_TYPE_NAME_MAP do
            local var4 = Array.find(operationTypes, function(arg3): boolean
                return arg3.operation == operation
            end)
            if Boolean.toJSBoolean(var4) then
                continue
            end

            local var5 = var2:get(DEFAULT_OPERATION_TYPE_NAME_MAP[tostring(operation)])

            if var5 == nil or var5.name == nil then
                continue
            end
            table.insert(
                operationTypes,
                {
                    kind = Kind.OPERATION_TYPE_DEFINITION,
                    type = {
                        kind = Kind.NAMED_TYPE,
                        name = var5.name
                    },
                    operation = operation
                }
            )
        end

        if typeof(var3) == "table" and typeof(var3.operationTypes) == "table" and #var3.operationTypes > 0 then
            var2:set(schemaDefSymbol, var3)
        end
    end

    if arg2
        and Boolean.toJSBoolean(arg2.forceSchemaDefinition)
        and (typeof(var2:get(schemaDefSymbol)) ~= "table"
            or typeof(var2:get(schemaDefSymbol).operationTypes) ~= "table"
            or not (#var2:get(schemaDefSymbol).operationTypes > 0))
    then
        var2:set(schemaDefSymbol, {
            kind = Kind.SCHEMA_DEFINITION,
            operationTypes = {{
                kind = Kind.OPERATION_TYPE_DEFINITION,
                operation = "query",
                type = {
                    kind = Kind.NAMED_TYPE,
                    name = {
                        kind = Kind.NAME,
                        value = "Query"
                    }
                }
            }}
        })
    end

    local var3 = var2:values()

    if arg2 and Boolean.toJSBoolean(arg2.sort) then
        local var4 = if typeof(arg2.sort) == "function" then arg2.sort else defaultStringComparator
        Array.sort(var3, function(arg3, arg4)
            return var4(
                if typeof(arg3.name) == "table" then arg3.name.value else nil,
                if typeof(arg4.name) == "table" then arg4.name.value else nil
            )
        end)
    end

    return var3
end

module.mergeGraphQLTypes = mergeGraphQLTypes
return module
