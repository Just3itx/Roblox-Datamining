-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T08:10:42Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local luaUtils = scriptParentParent.luaUtils
local scriptParentParentParent = scriptParentParent.Parent
local LuauPolyfill = require(scriptParentParentParent.LuauPolyfill)
local Array = LuauPolyfill.Array
local Error = LuauPolyfill.Error

local null = require(luaUtils.null)

local isNillish = require(luaUtils.isNillish)
local isNillish2 = isNillish.isNillish
local isNotNillish = isNillish.isNotNillish

local inspect = require(scriptParentParent.jsutils.inspect).inspect
local devAssert = require(scriptParentParent.jsutils.devAssert).devAssert
local keyValMap = require(scriptParentParent.jsutils.keyValMap).keyValMap
local isObjectLike = require(scriptParentParent.jsutils.isObjectLike).isObjectLike

local parseValue = require(scriptParentParent.language.parser).parseValue

local schema = require(scriptParentParent.type.schema)

local definition = require(scriptParentParent.type.definition)

local GraphQLSchema = schema.GraphQLSchema
local GraphQLDirective = require(scriptParentParent.type.directives).GraphQLDirective
local specifiedScalarTypes = require(scriptParentParent.type.scalars).specifiedScalarTypes
local introspection = require(scriptParentParent.type.introspection)
local introspectionTypes = introspection.introspectionTypes
local TypeKind = introspection.TypeKind
local isInputType = definition.isInputType
local isOutputType = definition.isOutputType
local GraphQLList = definition.GraphQLList
local GraphQLNonNull = definition.GraphQLNonNull

local GraphQLScalarType = definition.GraphQLScalarType

local GraphQLObjectType = definition.GraphQLObjectType

local GraphQLInterfaceType = definition.GraphQLInterfaceType

local GraphQLUnionType = definition.GraphQLUnionType

local GraphQLEnumType = definition.GraphQLEnumType

local GraphQLInputObjectType = definition.GraphQLInputObjectType
local assertNullableType = definition.assertNullableType
local assertObjectType = definition.assertObjectType
local assertInterfaceType = definition.assertInterfaceType

local _getIntrospectionQuery = require(script.Parent.getIntrospectionQuery)

local valueFromAST = require(script.Parent.valueFromAST).valueFromAST

return {
    buildClientSchema = function(arg1, arg2)
        local getNamedType = nil

        local buildScalarDef = nil

        local buildObjectDef = nil
        local buildInterfaceDef = nil
        local buildUnionDef = nil
        local buildEnumDef = nil
        local buildInputObjectDef = nil
        local buildFieldDefMap = nil
        local buildField = nil
        local buildInputValueDefMap = nil
        local buildInputValue = nil

        local var1 = nil

        local function getType(arg3)
            if arg3.kind == TypeKind.LIST then
                local ofType = arg3.ofType
                if not ofType then
                    error(Error.new("Decorated type deeper than introspection query."))
                end

                return GraphQLList.new(getType(ofType))
            end
            if arg3.kind ~= TypeKind.NON_NULL then
                return getNamedType(arg3)
            end

            local ofType = arg3.ofType
            if not ofType then
                error(Error.new("Decorated type deeper than introspection query."))
            end
            local type = getType(ofType)

            return GraphQLNonNull.new(assertNullableType(type))
        end

        getNamedType = function(arg3)
            local name = arg3.name
            if isNillish2(name) then
                error(Error.new(("Unknown type reference: %s."):format(inspect(arg3))))
            end

            local var2 = var1:get(name)
            if isNillish2(var2) then
                error(
                    Error.new(
                        ("Invalid or incomplete schema, unknown type: %s. Ensure that a full introspection query is used in order to build a client schema."):format(
                            name
                        )
                    )
                )
            end

            return var2
        end

        local function getObjectType(arg3)
            return assertObjectType(getNamedType(arg3))
        end

        local function getInterfaceType(arg3)
            return assertInterfaceType(getNamedType(arg3))
        end

        local function buildType(arg3)
            if isNotNillish(arg3) and isNotNillish(arg3.name) and isNotNillish(arg3.kind) then
                if arg3.kind == TypeKind.SCALAR then
                    return buildScalarDef(arg3)
                end

                if arg3.kind == TypeKind.OBJECT then
                    return buildObjectDef(arg3)
                end

                if arg3.kind == TypeKind.INTERFACE then
                    return buildInterfaceDef(arg3)
                end

                if arg3.kind == TypeKind.UNION then
                    return buildUnionDef(arg3)
                end

                if arg3.kind == TypeKind.ENUM then
                    return buildEnumDef(arg3)
                end

                if arg3.kind == TypeKind.INPUT_OBJECT then
                    return buildInputObjectDef(arg3)
                end
            end
            local var2 = inspect(arg3)
            error(
                Error.new(
                    ("Invalid or incomplete introspection result. Ensure that a full introspection query is used in order to build a client schema: %s."):format(
                        var2
                    )
                )
            )
        end

        buildScalarDef = function(arg3)
            return GraphQLScalarType.new({ name = arg3.name, description = arg3.description, specifiedByUrl = arg3.specifiedByUrl })
        end

        local function buildImplementationsList(arg3)
            if arg3.interfaces == nil and arg3.kind == TypeKind.INTERFACE then
                return {}
            end

            if not arg3.interfaces then
                local var2 = inspect(arg3)
                error(Error.new(("Introspection result missing interfaces: %s."):format(var2)))
            end

            return Array.map(arg3.interfaces, getInterfaceType)
        end

        buildObjectDef = function(arg3)
            return GraphQLObjectType.new({
                name = arg3.name,
                description = arg3.description,
                interfaces = function()
                    return buildImplementationsList(arg3)
                end,
                fields = function()
                    return buildFieldDefMap(arg3)
                end
            })
        end

        buildInterfaceDef = function(arg3)
            return GraphQLInterfaceType.new({
                name = arg3.name,
                description = arg3.description,
                interfaces = function()
                    return buildImplementationsList(arg3)
                end,
                fields = function()
                    return buildFieldDefMap(arg3)
                end
            })
        end

        buildUnionDef = function(arg3)
            if not arg3.possibleTypes then
                local var2 = inspect(arg3)
                error(Error.new(("Introspection result missing possibleTypes: %s."):format(var2)))
            end

            return GraphQLUnionType.new({
                name = arg3.name,
                description = arg3.description,
                types = function()
                    return Array.map(arg3.possibleTypes, getObjectType)
                end
            })
        end

        buildEnumDef = function(arg3)
            if not arg3.enumValues then
                local var2 = inspect(arg3)
                error(Error.new(("Introspection result missing enumValues: %s."):format(var2)))
            end

            return GraphQLEnumType.new({
                name = arg3.name,
                description = arg3.description,
                values = keyValMap(arg3.enumValues, function(arg4)
                    return arg4.name
                end, function(arg4)
                    return {
                        description = arg4.description,
                        deprecationReason = arg4.deprecationReason
                    }
                end)
            })
        end

        buildInputObjectDef = function(arg3)
            if not arg3.inputFields then
                local var2 = inspect(arg3)
                error(Error.new(("Introspection result missing inputFields: %s."):format(var2)))
            end

            return GraphQLInputObjectType.new({
                name = arg3.name,
                description = arg3.description,
                fields = function()
                    return buildInputValueDefMap(arg3.inputFields)
                end
            })
        end

        buildFieldDefMap = function(arg3)
            if not arg3.fields then
                error(Error.new(("Introspection result missing fields: %s."):format(inspect(arg3))))
            end

            return keyValMap(arg3.fields, function(arg4)
                return arg4.name
            end, buildField)
        end

        buildField = function(arg3)
            local type = getType(arg3.type)
            if not isOutputType(type) then
                local var2 = inspect(type)
                error(Error.new(("Introspection must provide output type for fields, but received: %s."):format(var2)))
            end

            if not arg3.args then
                local var2 = inspect(arg3)

                error(Error.new(("Introspection result missing field args: %s."):format(var2)))
            end

            return {
                description = arg3.description,
                deprecationReason = arg3.deprecationReason,
                type = type,
                args = buildInputValueDefMap(arg3.args)
            }
        end

        buildInputValueDefMap = function(arg3)
            return keyValMap(arg3, function(arg4)
                return arg4.name
            end, buildInputValue)
        end

        buildInputValue = function(arg3)
            local type = getType(arg3.type)
            if not isInputType(type) then
                local var2 = inspect(type)
                error(Error.new(("Introspection must provide input type for arguments, but received: %s."):format(var2)))
            end

            local defaultValue = if isNotNillish(arg3.defaultValue) then valueFromAST(parseValue(arg3.defaultValue), type) else nil
            return {
                description = arg3.description,
                type = type,
                defaultValue = defaultValue,
                deprecationReason = arg3.deprecationReason
            }
        end

        local function buildDirective(arg3)
            if not arg3.args then
                local var2 = inspect(arg3)

                error(Error.new(("Introspection result missing directive args: %s."):format(var2)))
            end

            if not arg3.locations then
                local var2 = inspect(arg3)
                error(Error.new(("Introspection result missing directive locations: %s."):format(var2)))
            end

            return GraphQLDirective.new({
                name = arg3.name,
                description = arg3.description,
                isRepeatable = arg3.isRepeatable,
                locations = Array.slice(arg3.locations),
                args = buildInputValueDefMap(arg3.args)
            })
        end

        devAssert(
            isObjectLike(arg1) and isObjectLike(arg1.__schema),
            ("Invalid or incomplete introspection result. Ensure that you are passing \"data\" property of introspection response and no \"errors\" was returned alongside: %s."):format(
                inspect(arg1)
            )
        )

        local __schema = arg1.__schema

        var1 = keyValMap(__schema.types, function(arg3)
            return arg3.name
        end, function(arg3)
            return buildType(arg3)
        end)

        for _, value in ipairs(Array.concat(specifiedScalarTypes, introspectionTypes)) do
            local name = value.name

            if var1:get(name) then
                local name2 = value.name
                var1:set(name2, value)
            end
        end

        local query = if isNotNillish(__schema.queryType) then getObjectType(__schema.queryType) else null
        local mutation = if isNotNillish(__schema.mutationType) then getObjectType(__schema.mutationType) else null
        local subscription = if isNotNillish(__schema.subscriptionType) then getObjectType(__schema.subscriptionType) else null
        local directives = not isNotNillish(__schema.directives) and {} or Array.map(__schema.directives, buildDirective)

        return GraphQLSchema.new({
            description = __schema.description,
            query = query,
            mutation = mutation,
            subscription = subscription,
            types = var1:values(),
            directives = directives,
            assumeValid = if arg2 then arg2.assumeValid else nil
        })
    end
}
