-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T07:50:48Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local jsutils = scriptParentParent.jsutils
local error2 = scriptParentParent.error
local language = scriptParentParent.language
local type = scriptParentParent.type
local utilities = scriptParentParent.utilities
local luaUtils = scriptParentParent.luaUtils
local scriptParentParentParent = scriptParentParent.Parent

local LuauPolyfill = require(scriptParentParentParent.LuauPolyfill)
local Array = LuauPolyfill.Array
local Error = LuauPolyfill.Error
local Map = LuauPolyfill.Map
local Set = LuauPolyfill.Set
local instanceof = LuauPolyfill.instanceof

local _ObjMap = require(jsutils.ObjMap)

local _PromiseOrValue = require(jsutils.PromiseOrValue)

local Promise = require(scriptParentParent.Parent.Promise)

local null = require(luaUtils.null)
local isNillish = require(luaUtils.isNillish).isNillish

local inspect = require(jsutils.inspect).inspect
local memoize3 = require(jsutils.memoize3).memoize3
local invariant = require(jsutils.invariant).invariant
local devAssert = require(jsutils.devAssert).devAssert
local isPromise = require(jsutils.isPromise).isPromise
local isObjectLike = require(jsutils.isObjectLike).isObjectLike
local promiseReduce = require(jsutils.promiseReduce).promiseReduce
local promiseForObject = require(jsutils.promiseForObject).promiseForObject
local Path = require(jsutils.Path)

local addPath = Path.addPath
local pathToArray = Path.pathToArray
local isIteratableObject = require(jsutils.isIteratableObject).isIteratableObject

local _formatError = require(error2.formatError)

local GraphQLError = require(error2.GraphQLError).GraphQLError
local locatedError = require(error2.locatedError).locatedError

local _ast = require(language.ast)

local Kind = require(scriptParentParent.language.kinds).Kind

local _schema = require(type.schema)

local definition = require(type.definition)

local assertValidSchema = require(type.validate).assertValidSchema
local introspection = require(type.introspection)
local SchemaMetaFieldDef = introspection.SchemaMetaFieldDef
local TypeMetaFieldDef = introspection.TypeMetaFieldDef
local TypeNameMetaFieldDef = introspection.TypeNameMetaFieldDef
local directives = require(type.directives)
local GraphQLIncludeDirective = directives.GraphQLIncludeDirective
local GraphQLSkipDirective = directives.GraphQLSkipDirective
local isObjectType = definition.isObjectType
local isAbstractType = definition.isAbstractType
local isLeafType = definition.isLeafType
local isListType = definition.isListType
local isNonNullType = definition.isNonNullType

local typeFromAST = require(utilities.typeFromAST).typeFromAST
local getOperationRootType = require(utilities.getOperationRootType).getOperationRootType

local values = require(script.Parent.values)
local getVariableValues = values.getVariableValues
local getArgumentValues = values.getArgumentValues
local getDirectiveValues = values.getDirectiveValues

local assertValidExecutionArguments = nil
local buildExecutionContext = nil
local collectFields = nil
local buildResolveInfo = nil
local var1 = nil
local var2 = nil
local getFieldDef = nil

local buildResponse = nil
local executeOperation = nil
local executeFieldsSerially = nil
local executeFields = nil
local shouldIncludeNode = nil
local doesFragmentConditionMatch = nil

local getFieldEntryKey = nil
local resolveField = nil
local handleFieldError = nil
local completeValue = nil
local completeListValue = nil
local completeLeafValue = nil
local completeAbstractValue = nil
local ensureValidRuntimeType = nil
local completeObjectValue = nil
local invalidReturnTypeError = nil
local collectAndExecuteSubfields = nil

local var3 = nil

local function execute(tbl1)
    local schema = tbl1.schema
    local document = tbl1.document
    local rootValue = tbl1.rootValue
    local contextValue = tbl1.contextValue
    local variableValues = tbl1.variableValues
    local operationName = tbl1.operationName
    local fieldResolver = tbl1.fieldResolver
    local typeResolver = tbl1.typeResolver

    assertValidExecutionArguments(schema, document, variableValues)

    local errors = buildExecutionContext(
        schema,
        document,
        rootValue,
        contextValue,
        variableValues,
        operationName,
        fieldResolver,
        typeResolver
    )

    if Array.isArray(errors) or not errors.schema then
        return { errors = errors }
    end

    local var4 = executeOperation(errors, errors.operation, rootValue)

    return buildResponse(errors, var4)
end

local function executeSync(tbl1)
    local var4 = execute(tbl1)

    if isPromise(var4) then
        error(Error.new("GraphQL execution failed to complete synchronously."))
    end

    return var4
end

buildResponse = function(tbl1, arg1)
    if isPromise(arg1) then
        return arg1:andThen(function(arg2)
            return buildResponse(tbl1, arg2)
        end)
    end

    return if #tbl1.errors == 0 then { data = arg1 } else {
        errors = tbl1.errors,
        data = arg1
    }
end

assertValidExecutionArguments = function(arg1, arg2, tbl1)
    devAssert(arg2, "Must provide document.")

    assertValidSchema(arg1)

    devAssert(
        tbl1 == nil or isObjectLike(tbl1),
        "Variables must be provided as an Object where each property is a variable value. Perhaps look to see if an unparsed JSON string was provided."
    )
end

buildExecutionContext = function(schema, arg1, rootValue, contextValue, tbl1, str1: string?, fieldResolver, typeResolver)
    local var4 = nil
    local fragments = {}

    for _, definition2 in ipairs(arg1.definitions) do
        if definition2.kind == Kind.OPERATION_DEFINITION then
            if str1 == nil then
                if var4 ~= nil then
                    return { GraphQLError.new("Must provide operation name if query contains multiple operations.") }
                end

                var4 = definition2
            elseif (definition2.name and definition2.name.value) == str1 then
                var4 = definition2
            end
        elseif definition2.kind == Kind.FRAGMENT_DEFINITION then
            fragments[definition2.name.value] = definition2
        end
    end

    if not var4 then
        if str1 == nil then
            return { GraphQLError.new("Must provide an operation.") }
        end

        return { GraphQLError.new(("Unknown operation named \"%s\"."):format(str1)) }
    end

    local var5 = var4.variableDefinitions or {}

    local variableValues = getVariableValues(schema, var5, tbl1 or {}, { maxErrors = 50 })

    if variableValues.errors then
        return variableValues.errors
    end

    return {
        schema = schema,
        fragments = fragments,
        rootValue = rootValue,
        contextValue = contextValue,
        operation = var4,
        variableValues = variableValues.coerced,
        fieldResolver = fieldResolver or var2,
        typeResolver = typeResolver or var1,
        errors = {}
    }
end

executeOperation = function(tbl1, arg1, arg2)
    local operationRootType = getOperationRootType(tbl1.schema, arg1)
    local var4 = collectFields(tbl1, operationRootType, arg1.selectionSet, Map.new(), {})
    local success, result

    if arg1.operation == "mutation" then
        success, result = pcall(executeFieldsSerially, tbl1, operationRootType, arg2, nil, var4)
    else
        success, result = pcall(executeFields, tbl1, operationRootType, arg2, nil, var4)
    end

    if isPromise(result) then
        return result:andThen(nil, function(arg3)
            table.insert(tbl1.errors, arg3)
            return Promise.resolve(null)
        end)
    end

    if success then
        return result
    end

    table.insert(tbl1.errors, result)
    return null
end

executeFieldsSerially = function(tbl1, arg1, arg2, arg3, arg4)
    return promiseReduce(arg4:keys(), function(arg5, str1: string)
        local var4 = arg4[str1]
        local var5 = addPath(arg3, str1, arg1.name)
        local var6 = resolveField(tbl1, arg1, arg2, var4, var5)

        if var6 == nil then
            return arg5
        end
        if isPromise(var6) then
            return var6:andThen(function(arg6)
                arg5[str1] = arg6

                return arg5
            end)
        end

        arg5[str1] = var6

        return arg5
    end, {})
end

executeFields = function(tbl1, arg1, arg2, arg3, arg4)
    local tbl2 = ({})
    local bool1 = false

    for _, value in ipairs(arg4:keys()) do
        local var4 = arg4[value]
        local var5 = addPath(arg3, value, arg1.name)
        local var6 = resolveField(tbl1, arg1, arg2, var4, var5)

        if var6 == nil then
            continue
        end

        tbl2[value] = var6

        if isPromise(var6) then
            bool1 = true
        end
    end

    if not bool1 then
        return tbl2
    end

    return promiseForObject(tbl2)
end

collectFields = function(tbl1, arg1, arg2, arg3, arg4)
    for _, selection in ipairs(arg2.selections) do
        if selection.kind == Kind.FIELD then
            if shouldIncludeNode(tbl1, selection) then
                local fieldEntryKey = getFieldEntryKey(selection)

                if not arg3[fieldEntryKey] then
                    arg3[fieldEntryKey] = {}
                end
                table.insert(arg3[fieldEntryKey], selection)
            end
        elseif selection.kind == Kind.INLINE_FRAGMENT then
            if shouldIncludeNode(tbl1, selection) and doesFragmentConditionMatch(tbl1, selection, arg1) then
                collectFields(tbl1, arg1, selection.selectionSet, arg3, arg4)
            end
        elseif selection.kind == Kind.FRAGMENT_SPREAD then
            local value = selection.name.value
            if not arg4[value] and shouldIncludeNode(tbl1, selection) then
                arg4[value] = true
                local fragment = tbl1.fragments[value]
                if fragment and doesFragmentConditionMatch(tbl1, fragment, arg1) then
                    collectFields(tbl1, arg1, fragment.selectionSet, arg3, arg4)
                end
            end
        end
    end

    return arg3
end

shouldIncludeNode = function(tbl1, arg1): boolean
    local directiveValues = getDirectiveValues(GraphQLSkipDirective, arg1, tbl1.variableValues)

    if (directiveValues and directiveValues["if"]) == true then
        return false
    end

    local directiveValues2 = getDirectiveValues(GraphQLIncludeDirective, arg1, tbl1.variableValues)

    return (directiveValues2 and directiveValues2["if"]) ~= false
end

doesFragmentConditionMatch = function(tbl1, arg1, arg2)
    local typeCondition = arg1.typeCondition

    if not typeCondition then
        return true
    end

    local var4 = typeFromAST(tbl1.schema, typeCondition)

    if var4 == arg2 then
        return true
    elseif isAbstractType(var4) then
        return tbl1.schema:isSubType(var4, arg2)
    end

    return false
end

getFieldEntryKey = function(arg1)
    return if arg1.alias then arg1.alias.value else arg1.name.value
end

resolveField = function(tbl1, arg1, arg2, arg3, arg4)
    local value = arg3[1].name.value

    local fieldDef = getFieldDef(tbl1.schema, arg1, value)

    if not fieldDef then
        return
    end

    local type2 = fieldDef.type
    local var4 = if fieldDef.resolve then fieldDef.resolve else tbl1.fieldResolver
    local resolveInfo = buildResolveInfo(tbl1, fieldDef, arg3, arg1, arg4)

    local success, result = pcall(function()
        local argumentValues = getArgumentValues(fieldDef, arg3[1], tbl1.variableValues)

        local contextValue = tbl1.contextValue

        local var5 = var4(arg2, argumentValues, contextValue, resolveInfo)

        local var6 = if isPromise(var5) then var5:andThen(function(arg5)
            return completeValue(tbl1, type2, arg3, resolveInfo, arg4, arg5)
        end) else completeValue(tbl1, type2, arg3, resolveInfo, arg4, var5)

        if isPromise(var6) then
            return var6:andThen(nil, function(arg5)
                local var7 = locatedError(arg5, arg3, pathToArray(arg4))
                return handleFieldError(var7, type2, tbl1)
            end)
        end
        return var6
    end)

    if success then
        return result
    end

    local var5 = locatedError(result, arg3, pathToArray(arg4))
    return handleFieldError(var5, type2, tbl1)
end

buildResolveInfo = function(tbl1, arg1, fieldNodes, parentType, path)
    return {
        fieldName = arg1.name,
        fieldNodes = fieldNodes,
        returnType = arg1.type,
        parentType = parentType,
        path = path,
        schema = tbl1.schema,
        fragments = tbl1.fragments,
        rootValue = tbl1.rootValue,
        operation = tbl1.operation,
        variableValues = tbl1.variableValues
    }
end

handleFieldError = function(arg1, arg2, tbl1)
    if isNonNullType(arg2) then
        error(arg1)
    end

    table.insert(tbl1.errors, arg1)
    return null
end

completeValue = function(tbl1, arg1, arg2, arg3, arg4, arg5)
    if instanceof(arg5, Error) then
        error(arg5)
    end

    if isNonNullType(arg1) then
        local var4 = completeValue(tbl1, arg1.ofType, arg2, arg3, arg4, arg5)

        if isNillish(var4) then
            error(Error.new(("Cannot return null for non-nullable field %s.%s."):format(arg3.parentType.name, arg3.fieldName)))
        end

        return var4
    end

    if isNillish(arg5) then
        return null
    end

    if isListType(arg1) then
        return completeListValue(tbl1, arg1, arg2, arg3, arg4, arg5)
    end

    if isLeafType(arg1) then
        return completeLeafValue(arg1, arg5)
    end

    if isAbstractType(arg1) then
        return completeAbstractValue(tbl1, arg1, arg2, arg3, arg4, arg5)
    end

    if isObjectType(arg1) then
        return completeObjectValue(tbl1, arg1, arg2, arg3, arg4, arg5)
    end

    invariant(false, "Cannot complete value of unexpected output type: " .. inspect(arg1))

    assert(false, "Cannot complete value of unexpected output type: " .. inspect(arg1))
end

completeListValue = function(tbl1, arg1, arg2, arg3, arg4, arg5)
    local tbl2

    if instanceof(arg5, Set) then
        tbl2 = {}
        for _, value in arg5 do
            table.insert(tbl2, value)
        end
    else
        tbl2 = arg5
    end

    if not isIteratableObject(tbl2) then
        error(
            GraphQLError.new(
                ("Expected Iterable, but did not find one for field \"%s.%s\"."):format(arg3.parentType.name, arg3.fieldName)
            )
        )
    end

    local ofType = arg1.ofType
    local bool1 = false

    local bool2 = false

    local var4 = Array.from(tbl2, function(arg6, arg7)
        local var4 = addPath(arg4, arg7, nil)

        local success, result = pcall(function()
            local var5 = if isPromise(arg6) then arg6:andThen(function(arg8)
                return completeValue(tbl1, ofType, arg2, arg3, var4, arg8)
            end) else completeValue(tbl1, ofType, arg2, arg3, var4, arg6)

            if not isPromise(var5) then
                bool2 = true

                return var5
            end

            bool1 = true

            return var5:andThen(nil, function(arg8)
                local var6 = locatedError(arg8, arg2, pathToArray(var4))
                return handleFieldError(var6, ofType, tbl1)
            end)
        end)
        if success then
            return result
        end

        local var5 = locatedError(result, arg2, pathToArray(var4))
        return handleFieldError(var5, ofType, tbl1)
    end)

    if bool2 and bool1 then
        var4 = Array.map(var4, function(arg6)
            if isPromise(arg6) then
                return arg6
            end

            return (Promise.resolve(arg6))
        end)
    end

    if bool1 then
        var4 = Promise.all(var4)
    end

    return var4
end

completeLeafValue = function(arg1, arg2)
    local var4 = arg1:serialize(arg2)

    if var4 == nil then
        error(
            Error.new(("Expected a value of type \"%s\" but "):format(inspect(arg1)) .. ("received: %s"):format(inspect(arg2)))
        )
    end

    return var4
end

completeAbstractValue = function(tbl1, arg1, arg2, arg3, arg4, arg5)
    local var4 = (if arg1.resolveType then arg1.resolveType else tbl1.typeResolver)(arg5, tbl1.contextValue, arg3, arg1)

    if isPromise(var4) then
        return var4:andThen(function(arg6)
            return completeObjectValue(tbl1, ensureValidRuntimeType(arg6, tbl1, arg1, arg2, arg3, arg5), arg2, arg3, arg4, arg5)
        end)
    end

    return completeObjectValue(tbl1, ensureValidRuntimeType(var4, tbl1, arg1, arg2, arg3, arg5), arg2, arg3, arg4, arg5)
end

ensureValidRuntimeType = function(arg1, tbl1, arg2, arg3, arg4, arg5)
    if arg1 == nil then
        error(
            GraphQLError.new(
                ("Abstract type \"%s\" must resolve to an Object type at runtime for field \"%s.%s\". Either the \"%s\" type should provide a \"resolveType\" function or each possible type should provide an \"isTypeOf\" function."):format(
                    arg2.name,
                    arg4.parentType.name,
                    arg4.fieldName,
                    arg2.name
                ),
                arg3
            )
        )
    end

    if isObjectType(arg1) then
        error(
            GraphQLError.new(
                "Support for returning GraphQLObjectType from resolveType was removed in graphql-js@16.0.0 please return type name instead."
            )
        )
    end

    if typeof(arg1) ~= "string" then
        error(
            GraphQLError.new(
                ("Abstract type \"%s\" must resolve to an Object type at runtime for field \"%s.%s\" with "):format(
                    arg2.name,
                    arg4.parentType.name,
                    arg4.fieldName
                ) .. ("value %s, received \"%s\"."):format(inspect(arg5), inspect(arg1))
            )
        )
    end

    local type2 = tbl1.schema:getType(arg1)
    if type2 == nil then
        error(
            GraphQLError.new(
                ("Abstract type \"%s\" was resolve to a type \"%s\" that does not exist inside schema."):format(arg2.name, arg1),
                arg3
            )
        )
    end

    if not isObjectType(type2) then
        error(GraphQLError.new(("Abstract type \"%s\" was resolve to a non-object type \"%s\"."):format(arg2.name, arg1), arg3))
    end

    if not tbl1.schema:isSubType(arg2, type2) then
        error(
            GraphQLError.new(("Runtime Object type \"%s\" is not a possible type for \"%s\"."):format(type2.name, arg2.name), arg3)
        )
    end

    return type2
end

completeObjectValue = function(tbl1, arg1, arg2, arg3, arg4, arg5)
    if arg1.isTypeOf ~= nil then
        local var4 = arg1.isTypeOf(arg1, arg5, tbl1.contextValue, arg3)

        if isPromise(var4) then
            return var4:andThen(function(arg6)
                if not arg6 then
                    error(invalidReturnTypeError(arg1, arg5, arg2))
                end

                return collectAndExecuteSubfields(tbl1, arg1, arg2, arg4, arg5)
            end)
        end

        if not var4 then
            error(invalidReturnTypeError(arg1, arg5, arg2))
        end
    end

    return collectAndExecuteSubfields(tbl1, arg1, arg2, arg4, arg5)
end

invalidReturnTypeError = function(arg1, arg2, arg3)
    return GraphQLError.new(("Expected value of type \"%s\" but got: %s."):format(arg1.name, inspect(arg2)), arg3)
end

collectAndExecuteSubfields = function(tbl1, arg1, arg2, arg3, arg4)
    local var4 = var3(tbl1, arg1, arg2)
    return executeFields(tbl1, arg1, arg4, arg3, var4)
end

var3 = memoize3(function(tbl1, arg1, arg2) -- name: _collectSubfields
    local map = Map.new()
    local tbl2 = {}

    for _, value in ipairs(arg2) do
        if value.selectionSet then
            map = collectFields(tbl1, arg1, value.selectionSet, map, tbl2)
        end
    end

    return map
end)

var1 = function(arg1, arg2, arg3, arg4)
    if isObjectLike(arg1) and typeof(arg1.__typename) == "string" then
        return arg1.__typename
    end

    local possibleTypes = arg3.schema:getPossibleTypes(arg4)
    local tbl1 = ({})

    for i = 1, #possibleTypes do
        local var4 = possibleTypes[i]

        if not var4.isTypeOf then
            continue
        end

        local var5 = var4:isTypeOf(arg1, arg2, arg3)

        if isPromise(var5) then
            tbl1[i] = var5
        elseif var5 then
            return var4.name
        end
    end

    if not (#tbl1 > 0) then
        return nil
    end

    return Promise.all(tbl1):andThen(function(arg5)
        for i = 1, #arg5 do
            if arg5[i] then
                return possibleTypes[i].name
            end
        end
        return nil
    end)
end

var2 = function(arg1, arg2, arg3, arg4)
    if not isObjectLike(arg1) and typeof(arg1) ~= "function" then
        return nil
    end

    local var4 = arg1[arg4.fieldName]
    if typeof(var4) == "function" then
        return arg1[arg4.fieldName](arg1, arg2, arg3, arg4)
    end
    return var4
end

getFieldDef = function(arg1, arg2, name: string)
    if name == SchemaMetaFieldDef.name and arg1:getQueryType() == arg2 then
        return SchemaMetaFieldDef
    elseif name == TypeMetaFieldDef.name and arg1:getQueryType() == arg2 then
        return TypeMetaFieldDef
    elseif name == TypeNameMetaFieldDef.name then
        return TypeNameMetaFieldDef
    end

    return arg2:getFields():get(name)
end

return {
    execute = execute,
    executeSync = executeSync,
    assertValidExecutionArguments = assertValidExecutionArguments,
    buildExecutionContext = buildExecutionContext,
    collectFields = collectFields,
    buildResolveInfo = buildResolveInfo,
    getFieldDef = getFieldDef,
    defaultFieldResolver = var2,
    defaultTypeResolver = var1
}
