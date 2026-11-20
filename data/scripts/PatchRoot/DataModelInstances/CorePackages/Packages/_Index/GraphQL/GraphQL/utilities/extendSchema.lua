-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T08:10:45Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local scriptParentParentParent = scriptParentParent.Parent
local LuauPolyfill = require(scriptParentParentParent.LuauPolyfill)
local Array = LuauPolyfill.Array
local Error = LuauPolyfill.Error
local Map = LuauPolyfill.Map
local Object = LuauPolyfill.Object
local coerceToMap = LuauPolyfill.coerceToMap

local mapValueOrdered = require(scriptParentParent.luaUtils.mapValueOrdered).mapValueOrdered
local _null = require(scriptParentParent.luaUtils.null)

local jsutils = scriptParentParent.jsutils
local keyMap = require(jsutils.keyMap).keyMap
local inspect = require(jsutils.inspect).inspect
local devAssert = require(jsutils.devAssert).devAssert
local _ObjMap = require(jsutils.ObjMap)

local _ast = require(scriptParentParent.language.ast)

local Kind = require(scriptParentParent.language.kinds).Kind

local predicates = require(scriptParentParent.language.predicates)
local isTypeDefinitionNode = predicates.isTypeDefinitionNode
local isTypeExtensionNode = predicates.isTypeExtensionNode

local assertValidSDLExtension = require(scriptParentParent.validation.validate).assertValidSDLExtension

local getDirectiveValues = require(scriptParentParent.execution.values).getDirectiveValues

local type = scriptParentParent.type
local schema = require(type.schema)

local assertSchema = schema.assertSchema
local GraphQLSchema = schema.GraphQLSchema
local scalars = require(type.scalars)
local specifiedScalarTypes = scalars.specifiedScalarTypes
local isSpecifiedScalarType = scalars.isSpecifiedScalarType
local introspection = require(type.introspection)
local introspectionTypes = introspection.introspectionTypes
local isIntrospectionType = introspection.isIntrospectionType
local directives = require(type.directives)

local GraphQLDirective = directives.GraphQLDirective
local GraphQLDeprecatedDirective = directives.GraphQLDeprecatedDirective
local GraphQLSpecifiedByDirective = directives.GraphQLSpecifiedByDirective

local definition = require(type.definition)

local isScalarType = definition.isScalarType
local isObjectType = definition.isObjectType
local isInterfaceType = definition.isInterfaceType
local isUnionType = definition.isUnionType
local isListType = definition.isListType
local isNonNullType = definition.isNonNullType
local isEnumType = definition.isEnumType
local isInputObjectType = definition.isInputObjectType
local GraphQLList = definition.GraphQLList
local GraphQLNonNull = definition.GraphQLNonNull
local GraphQLScalarType = definition.GraphQLScalarType

local GraphQLObjectType = definition.GraphQLObjectType

local GraphQLInterfaceType = definition.GraphQLInterfaceType

local GraphQLUnionType = definition.GraphQLUnionType

local GraphQLEnumType = definition.GraphQLEnumType

local GraphQLInputObjectType = definition.GraphQLInputObjectType

local valueFromAST = require(script.Parent.valueFromAST).valueFromAST

local var1 = nil
local getDeprecationReason = nil
local getSpecifiedByUrl = nil

function extendSchemaImpl(arg1, arg2, arg3)
    local tbl1 = {}

    local map = Map.new()

    local tbl2 = {}

    local var2 = nil

    local tbl3 = {}

    for _, definition2 in ipairs(arg2.definitions) do
        if definition2.kind == Kind.SCHEMA_DEFINITION then
            var2 = definition2
        elseif definition2.kind == Kind.SCHEMA_EXTENSION then
            table.insert(tbl3, definition2)
        elseif isTypeDefinitionNode(definition2) then
            table.insert(tbl1, definition2)
        elseif isTypeExtensionNode(definition2) then
            local value = definition2.name.value

            local var3 = map:get(value)
            map:set(value, not var3 and { definition2 } or Array.concat(var3, { definition2 }))
        elseif definition2.kind == Kind.DIRECTIVE_DEFINITION then
            table.insert(tbl2, definition2)
        end
    end

    if #map:keys() == 0 and #tbl1 == 0 and #tbl2 == 0 and #tbl3 == 0 and var2 == nil then
        return arg1
    end

    local map2 = Map.new()

    local replaceNamedType = nil
    local extendArg = nil
    local extendField = nil
    local extendScalarType = nil
    local extendObjectType = nil
    local extendInterfaceType = nil
    local extendUnionType = nil
    local extendEnumType = nil
    local extendInputObjectType = nil
    local buildInputFieldMap = nil

    local buildEnumValueMap = nil

    local buildInterfaces = nil

    local buildUnionTypes = nil
    local getNamedType = nil
    local buildArgumentMap = nil
    local buildFieldMap = nil

    local function replaceType(arg4)
        if isListType(arg4) then
            return GraphQLList.new(replaceType(arg4.ofType))
        elseif isNonNullType(arg4) then
            return GraphQLNonNull.new(replaceType(arg4.ofType))
        end
        return replaceNamedType(arg4)
    end

    replaceNamedType = function(arg4)
        return map2:get(arg4.name)
    end

    local function replaceDirective(arg4)
        local var3 = arg4:toConfig()
        return GraphQLDirective.new(Object.assign({}, var3, { args = mapValueOrdered(coerceToMap(var3.args), extendArg) }))
    end

    local function extendNamedType(arg4)
        if isIntrospectionType(arg4) or isSpecifiedScalarType(arg4) then
            return arg4
        end

        if isScalarType(arg4) then
            return extendScalarType(arg4)
        end
        if isObjectType(arg4) then
            return extendObjectType(arg4)
        end
        if isInterfaceType(arg4) then
            return extendInterfaceType(arg4)
        end
        if isUnionType(arg4) then
            return extendUnionType(arg4)
        end
        if isEnumType(arg4) then
            return extendEnumType(arg4)
        end

        if isInputObjectType(arg4) then
            return extendInputObjectType(arg4)
        end

        assert(false, "Unexpected type: " .. inspect(arg4))
    end

    extendInputObjectType = function(arg4)
        local var3 = arg4:toConfig()

        local var4 = map[var3.name] or {}

        return GraphQLInputObjectType.new(Object.assign({}, var3, {
            fields = function()
                return Map.new(Array.concat(mapValueOrdered(coerceToMap(var3.fields), function(arg5)
                    return Object.assign({}, arg5, { type = replaceType(arg5.type) })
                end):entries(), buildInputFieldMap(var4):entries()))
            end,
            extensionASTNodes = Array.concat(var3.extensionASTNodes, var4)
        }))
    end

    extendEnumType = function(arg4)
        local var3 = arg4:toConfig()

        local var4 = map:get(arg4.name) or {}

        return GraphQLEnumType.new(
            Object.assign({}, var3, {
                values = Map.new(Array.concat(var3.values:entries(), buildEnumValueMap(var4):entries())),
                extensionASTNodes = Array.concat(var3.extensionASTNodes, var4)
            })
        )
    end
    extendScalarType = function(arg4)
        local var3 = arg4:toConfig()

        local var4 = map:get(var3.name) or {}

        local specifiedByUrl = var3.specifiedByUrl
        for _, value in ipairs(var4) do
            specifiedByUrl = getSpecifiedByUrl(value) or specifiedByUrl
        end

        return GraphQLScalarType.new(
            Object.assign(
                {},
                var3,
                {
                    specifiedByUrl = specifiedByUrl,
                    extensionASTNodes = Array.concat(var3.extensionASTNodes, var4)
                }
            )
        )
    end

    extendObjectType = function(arg4)
        local var3 = arg4:toConfig()

        local var4 = map:get(var3.name) or {}

        return GraphQLObjectType.new(Object.assign({}, var3, {
            interfaces = function()
                return Array.concat(Array.map(arg4:getInterfaces(), replaceNamedType), buildInterfaces(var4))
            end,
            fields = function()
                return Map.new(Array.concat(mapValueOrdered(coerceToMap(var3.fields), extendField):entries(), buildFieldMap(var4):entries()))
            end,
            extensionASTNodes = Array.concat(var3.extensionASTNodes, var4)
        }))
    end

    extendInterfaceType = function(arg4)
        local var3 = arg4:toConfig()

        local var4 = map:get(var3.name) or {}

        return GraphQLInterfaceType.new(Object.assign({}, var3, {
            interfaces = function()
                return Array.concat(Array.map(arg4:getInterfaces(), replaceNamedType), buildInterfaces(var4))
            end,
            fields = function()
                return Map.new(Array.concat(mapValueOrdered(coerceToMap(var3.fields), extendField):entries(), buildFieldMap(var4):entries()))
            end,
            extensionASTNodes = Array.concat(var3.extensionASTNodes, var4)
        }))
    end

    extendUnionType = function(arg4)
        local var3 = arg4:toConfig()

        local var4 = map:get(var3.name) or {}

        return GraphQLUnionType.new(Object.assign({}, var3, {
            types = function()
                return Array.concat(Array.map(arg4:getTypes(), replaceNamedType), buildUnionTypes(var4))
            end,
            extensionASTNodes = Array.concat(var3.extensionASTNodes, var4)
        }))
    end

    extendField = function(arg4)
        return Object.assign(
            {},
            arg4,
            {
                type = replaceType(arg4.type),
                args = if arg4.args then mapValueOrdered(arg4.args, extendArg) else nil
            }
        )
    end
    extendArg = function(arg4)
        return Object.assign({}, arg4, { type = replaceType(arg4.type) })
    end

    local function getOperationTypes(arg4)
        local operationTypes = {}
        for _, value in ipairs(arg4) do
            local operationTypes2 = value.operationTypes or {}

            for _, value2 in ipairs(operationTypes2) do
                operationTypes[value2.operation] = getNamedType(value2.type)
            end
        end

        return operationTypes
    end

    getNamedType = function(arg4)
        local value = arg4.name.value

        local var3 = var1[value] or map2[value]

        if var3 == nil then
            error(Error.new(("Unknown type: \"%s\"."):format(value)))
        end

        return var3
    end

    local function getWrappedType(arg4)
        if arg4.kind == Kind.LIST_TYPE then
            return GraphQLList.new(getWrappedType(arg4.type))
        elseif arg4.kind == Kind.NON_NULL_TYPE then
            return GraphQLNonNull.new(getWrappedType(arg4.type))
        end
        return getNamedType(arg4)
    end

    local function buildDirective(astNode)
        local locations = Array.map(astNode.locations, function(arg4)
            return arg4.value
        end)

        return GraphQLDirective.new({
            name = astNode.name.value,
            description = if astNode.description then astNode.description.value else nil,
            locations = locations,
            isRepeatable = astNode.repeatable,
            args = buildArgumentMap(astNode.arguments),
            astNode = astNode
        })
    end

    buildFieldMap = function(arg4)
        local map3 = Map.new()
        for _, value in ipairs(arg4) do
            local var3 = not value.fields and {} or value.fields

            for _, astNode in ipairs(var3) do
                local value3 = astNode.name.value
                local tbl4 = {
                    type = getWrappedType(astNode.type),
                    description = if astNode.description then astNode.description.value else nil,
                    args = buildArgumentMap(astNode.arguments),
                    deprecationReason = getDeprecationReason(astNode),
                    astNode = astNode
                }
                map3:set(value3, tbl4)
            end
        end

        return map3
    end

    buildArgumentMap = function(arg4)
        local map3 = Map.new()

        for _, astNode in ipairs(arg4 or {}) do
            local wrappedType = getWrappedType(astNode.type)

            local value2 = astNode.name.value
            local tbl4 = {
                type = wrappedType,
                description = if astNode.description then astNode.description.value else nil,
                defaultValue = valueFromAST(astNode.defaultValue, wrappedType),
                deprecationReason = getDeprecationReason(astNode),
                astNode = astNode
            }
            map3:set(value2, tbl4)
        end

        return map3
    end

    buildInputFieldMap = function(arg4)
        local map3 = Map.new()
        for _, value in ipairs(arg4) do
            local var3 = not value.fields and {} or value.fields

            for _, astNode in ipairs(var3) do
                local wrappedType = getWrappedType(astNode.type)

                local value3 = astNode.name.value
                local tbl4 = {
                    type = wrappedType,
                    description = if astNode.description then astNode.description.value else nil,
                    defaultValue = valueFromAST(astNode.defaultValue, wrappedType),
                    deprecationReason = getDeprecationReason(astNode),
                    astNode = astNode
                }
                map3:set(value3, tbl4)
            end
        end

        return map3
    end

    buildEnumValueMap = function(arg4)
        local map3 = Map.new()
        for _, value in ipairs(arg4) do
            local var3 = not value.values and {} or value.values

            for _, astNode in ipairs(var3) do
                local value3 = astNode.name.value
                local tbl4 = {
                    description = if astNode.description then astNode.description.value else nil,
                    deprecationReason = getDeprecationReason(astNode),
                    astNode = astNode
                }
                map3:set(value3, tbl4)
            end
        end

        return map3
    end

    buildInterfaces = function(arg4)
        local interfaces = {}
        for _, value in ipairs(arg4) do
            if not value.interfaces then
                continue
            end
            for _, value2 in ipairs(value.interfaces) do
                table.insert(interfaces, (getNamedType(value2)))
            end
        end

        return interfaces
    end

    buildUnionTypes = function(arg4)
        local unionTypes = {}
        for _, value in ipairs(arg4) do
            if not value.types then
                continue
            end

            for _, value2 in ipairs(value.types) do
                table.insert(unionTypes, (getNamedType(value2)))
            end
        end

        return unionTypes
    end

    local function buildType(astNode)
        local value = astNode.name.value

        local extensionAstNodes = map[value] or {}
        local kind = astNode.kind

        if kind == Kind.OBJECT_TYPE_DEFINITION then
            local var4 = Array.concat(astNode, extensionAstNodes)

            local new = GraphQLObjectType.new
            local tbl4 = {
                name = value,
                description = if astNode.description then astNode.description.value else nil,
                interfaces = 0,
                fields = 0,
                astNode = 0,
                extensionASTNodes = 0
            }

            function tbl4.interfaces()
                return buildInterfaces(var4)
            end
            function tbl4.fields()
                return buildFieldMap(var4)
            end
            tbl4.astNode = astNode

            tbl4.extensionASTNodes = extensionAstNodes
            return new(tbl4)
        end
        if kind == Kind.INTERFACE_TYPE_DEFINITION then
            local var4 = Array.concat(astNode, extensionAstNodes)

            local new = GraphQLInterfaceType.new
            local tbl4 = {
                name = value,
                description = if astNode.description then astNode.description.value else nil,
                interfaces = 0,
                fields = 0,
                astNode = 0,
                extensionASTNodes = 0
            }

            function tbl4.interfaces()
                return buildInterfaces(var4)
            end
            function tbl4.fields()
                return buildFieldMap(var4)
            end
            tbl4.astNode = astNode
            tbl4.extensionASTNodes = extensionAstNodes
            return new(tbl4)
        end
        if kind == Kind.ENUM_TYPE_DEFINITION then
            local var4 = Array.concat(astNode, extensionAstNodes)

            return GraphQLEnumType.new({
                name = value,
                description = if astNode.description then astNode.description.value else nil,
                values = buildEnumValueMap(var4),
                astNode = astNode,
                extensionASTNodes = extensionAstNodes
            })
        end

        if kind == Kind.UNION_TYPE_DEFINITION then
            local var4 = Array.concat(astNode, extensionAstNodes)

            local new = GraphQLUnionType.new
            local tbl4 = {
                name = value,
                description = if astNode.description then astNode.description.value else nil,
                types = 0,
                astNode = 0,
                extensionASTNodes = 0
            }

            function tbl4.types()
                return buildUnionTypes(var4)
            end

            tbl4.astNode = astNode
            tbl4.extensionASTNodes = extensionAstNodes
            return new(tbl4)
        end
        if kind == Kind.SCALAR_TYPE_DEFINITION then
            return GraphQLScalarType.new({
                name = value,
                description = if astNode.description then astNode.description.value else nil,
                specifiedByUrl = getSpecifiedByUrl(astNode),
                astNode = astNode,
                extensionASTNodes = extensionAstNodes
            })
        end

        if kind ~= Kind.INPUT_OBJECT_TYPE_DEFINITION then
            assert(false, "Unexpected type definition node: " .. inspect(astNode))
            return
        end

        local var4 = Array.concat(astNode, extensionAstNodes)

        local new = GraphQLInputObjectType.new
        local tbl4 = {
            name = value,
            description = if astNode.description then astNode.description.value else nil,
            fields = 0,
            astNode = 0,
            extensionASTNodes = 0
        }

        function tbl4.fields()
            return buildInputFieldMap(var4)
        end
        tbl4.astNode = astNode
        tbl4.extensionASTNodes = extensionAstNodes
        return new(tbl4)
    end

    for _, value in ipairs(arg1.types) do
        map2:set(value.name, extendNamedType(value))
    end

    for _, value in ipairs(tbl1) do
        local value2 = value.name.value

        map2:set(value2, var1[value2] or buildType(value))
    end

    local var3 = Object.assign({}, {
        query = arg1.query and replaceNamedType(arg1.query),
        mutation = arg1.mutation and replaceNamedType(arg1.mutation),
        subscription = arg1.subscription and replaceNamedType(arg1.subscription)
    }, not var2 and {} or getOperationTypes({ var2 }) or {}, (getOperationTypes(tbl3)))
    local value = if var2 == nil or var2.description == nil then nil else var2.description.value
    local assumeValid = not (arg3 == nil or arg3.assumeValid == nil) and arg3.assumeValid
    local var4 = Object.assign({}, { description = value }, var3, {
        types = map2:values(),
        directives = Array.concat(Array.map(arg1.directives, replaceDirective), Array.map(tbl2, buildDirective)),
        astNode = var2 or arg1.astNode,
        extensionASTNodes = Array.concat(arg1.extensionASTNodes, tbl3),
        assumeValid = assumeValid
    })

    var4.extensions = nil
    return var4
end

var1 = keyMap(Array.concat(specifiedScalarTypes, introspectionTypes), function(arg1)
    return arg1.name
end)

getDeprecationReason = function(arg1)
    local directiveValues = getDirectiveValues(GraphQLDeprecatedDirective, arg1)
    return directiveValues and directiveValues.reason
end

getSpecifiedByUrl = function(arg1)
    local directiveValues = getDirectiveValues(GraphQLSpecifiedByDirective, arg1)
    return directiveValues and directiveValues.url
end

return {
    extendSchema = function(arg1, arg2, arg3)
        assertSchema(arg1)

        devAssert(not (arg2 == nil) and arg2.kind == Kind.DOCUMENT, "Must provide valid Document AST.")

        if (arg3 and arg3.assumeValid) ~= true and (arg3 and arg3.assumeValidSDL) ~= true then
            assertValidSDLExtension(arg2, arg1)
        end

        local var2 = arg1:toConfig()
        local var3 = extendSchemaImpl(var2, arg2, arg3)
        if var2 == var3 then
            return arg1
        end

        return (GraphQLSchema.new(var3))
    end,
    extendSchemaImpl = extendSchemaImpl
}
