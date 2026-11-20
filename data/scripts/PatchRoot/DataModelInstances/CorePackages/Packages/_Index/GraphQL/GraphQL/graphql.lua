-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T07:50:51Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent

local scriptParentParent = scriptParent.Parent
local Error = require(scriptParentParent.LuauPolyfill).Error
local Promise = require(scriptParentParent.Promise)

local _PromiseOrValue = require(scriptParent.jsutils.PromiseOrValue)

local isPromise = require(scriptParent.jsutils.isPromise).isPromise

local _source = require(scriptParent.language.source)

local parse = require(scriptParent.language.parser).parse

local _definition = require(scriptParent.type.definition)

local _schema = require(scriptParent.type.schema)

local validate = require(scriptParent.validation.validate).validate

local validateSchema = require(scriptParent.type.validate).validateSchema

local execute = require(scriptParent.execution.execute).execute

local module = {}

local graphqlImpl = nil

function module.graphql(tbl1)
    return Promise.new(function(arg1)
        return arg1(graphqlImpl(tbl1))
    end)
end

function module.graphqlSync(tbl1)
    local var1 = graphqlImpl(tbl1)

    if isPromise(var1) then
        error(Error.new("GraphQL execution failed to complete synchronously."))
    end

    return var1
end

graphqlImpl = function(tbl1)
    local schema = tbl1.schema
    local source = tbl1.source
    local rootValue = tbl1.rootValue
    local contextValue = tbl1.contextValue
    local variableValues = tbl1.variableValues
    local operationName = tbl1.operationName
    local fieldResolver = tbl1.fieldResolver
    local typeResolver = tbl1.typeResolver

    local errors = validateSchema(schema)
    if #errors > 0 then
        return { errors = errors }
    end

    local var2 = nil
    local success, result = pcall(function()
        var2 = parse(source)
    end)
    if not success then
        return {
            errors = { result }
        }
    end

    local var1 = validate(schema, var2)
    if #var1 > 0 then
        return { errors = var1 }
    end

    return execute({
        schema = schema,
        document = var2,
        rootValue = rootValue,
        contextValue = contextValue,
        variableValues = variableValues,
        operationName = operationName,
        fieldResolver = fieldResolver,
        typeResolver = typeResolver
    })
end

return module
