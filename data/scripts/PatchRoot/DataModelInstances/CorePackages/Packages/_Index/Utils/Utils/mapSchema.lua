-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T20:01:28Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local LuauPolyfill = require(scriptParentParent.LuauPolyfill)
local Array = LuauPolyfill.Array
local Boolean = LuauPolyfill.Boolean
local Object = LuauPolyfill.Object

local module = {}
local GraphQL = require(scriptParentParent.GraphQL)

local GraphQLObjectType = GraphQL.GraphQLObjectType

local GraphQLSchema = GraphQL.GraphQLSchema

local isInterfaceType = GraphQL.isInterfaceType
local isEnumType = GraphQL.isEnumType
local isObjectType = GraphQL.isObjectType
local isScalarType = GraphQL.isScalarType
local isUnionType = GraphQL.isUnionType
local isInputObjectType = GraphQL.isInputObjectType

local GraphQLInputObjectType = GraphQL.GraphQLInputObjectType

local GraphQLInterfaceType = GraphQL.GraphQLInterfaceType

local isLeafType = GraphQL.isLeafType
local isListType = GraphQL.isListType
local isNonNullType = GraphQL.isNonNullType
local isNamedType = GraphQL.isNamedType
local GraphQLList = GraphQL.GraphQLList
local GraphQLNonNull = GraphQL.GraphQLNonNull
local GraphQLEnumType = GraphQL.GraphQLEnumType

local Kind = GraphQL.Kind

local getObjectTypeFromTypeMap = require(script.Parent.getObjectTypeFromTypeMap).getObjectTypeFromTypeMap
local MapperKind = require(script.Parent.Interfaces).MapperKind

local rewireTypes = require(script.Parent.rewire).rewireTypes
local transformInputValue = require(script.Parent.transformInputValue)

local serializeInputValue = transformInputValue.serializeInputValue
local parseInputValue = transformInputValue.parseInputValue

local Map = LuauPolyfill.Map

local String = LuauPolyfill.String

local mapTypes = nil

local mapArguments = nil

local mapFields = nil

local mapDefaultValues = nil

local mapEnumValues = nil

local getEnumValueMapper = nil
local getDirectiveMapper = nil
local mapDirectives = nil

local getFieldMapper = nil
local getTypeMapper = nil
local getArgumentMapper = nil
local getNewType = nil
local correctASTNodes = nil

function module.mapSchema(arg1, arg2)
    local var1 = arg2 == nil and {} or arg2
    local var2 = mapArguments(
        mapFields(
            mapTypes(
                mapDefaultValues(
                    mapEnumValues(mapTypes(mapDefaultValues(arg1:getTypeMap(), arg1, serializeInputValue), arg1, var1, function(arg3)
                        return isLeafType(arg3)
                    end), arg1, var1),
                    arg1,
                    parseInputValue
                ),
                arg1,
                var1,
                function(arg3): boolean
                    return not Boolean.toJSBoolean(isLeafType(arg3))
                end
            ),
            arg1,
            var1
        ),
        arg1,
        var1
    )

    local directives = arg1:getDirectives()
    local var3 = mapDirectives(directives, arg1, var1)

    local var4 = rewireTypes(var2, var3)
    local typeMap = var4.typeMap
    local directives2 = var4.directives

    return GraphQLSchema.new(
        Object.assign({}, arg1:toConfig(), {
            query = getObjectTypeFromTypeMap(typeMap, getObjectTypeFromTypeMap(var2, arg1:getQueryType())) or Object.None,
            mutation = getObjectTypeFromTypeMap(typeMap, getObjectTypeFromTypeMap(var2, arg1:getMutationType())) or Object.None,
            subscription = getObjectTypeFromTypeMap(typeMap, getObjectTypeFromTypeMap(var2, arg1:getSubscriptionType())) or Object.None,
            types = typeMap:values() or Object.None,
            directives = directives2 or Object.None
        })
    )
end

mapTypes = function(arg1, arg2, arg3, func1: ((...any) -> (...any))?)
    local var1 = func1 == nil and function(): boolean
        return true
    end or func1

    local map = Map.new()
    for _, value in arg1 do
        local var2 = table.unpack(value)
        if String.startsWith(var2, "__") then
            continue
        end

        local var3 = arg1:get(var2)
        if var3 == nil or var3 == Object.None or not var1(var3) then
            map:set(var2, var3)
        else
            local typeMapper = getTypeMapper(arg2, arg3, var2)
            if typeMapper == nil or typeMapper == Object.None then
                map:set(var2, var3)
            else
                local var4 = typeMapper(var3, arg2)

                if var4 == nil then
                    map:set(var2, var3)
                else
                    map:set(var2, var4)
                end
            end
        end
    end

    return map
end

mapEnumValues = function(arg1, arg2, arg3)
    local enumValueMapper = getEnumValueMapper(arg3)
    if not Boolean.toJSBoolean(enumValueMapper) then
        return arg1
    end

    local func1 = mapTypes

    local tbl1 = {}

    local enumType = MapperKind.ENUM_TYPE

    tbl1[tostring(enumType)] = function(arg4)
        local var1 = arg4:toConfig()
        local values = var1.values

        local map = Map.new()
        for _, value in values do
            local var2 = table.unpack(value)
            local var3 = values:get(var2)

            local var4 = enumValueMapper(var3, arg4.name, arg2, var2)

            if var4 == nil then
                map:set(var2, var3)
            elseif Boolean.toJSBoolean(Array.isArray(var4)) then
                local var5, var6 = table.unpack(var4, 1, 2)

                if var6 == nil then
                    var6 = var3
                end

                map:set(var5, var6)
            elseif var4 ~= Object.None then
                map:set(var2, var4)
            end
        end

        return (correctASTNodes(GraphQLEnumType.new(Object.assign({}, var1, { values = map }))))
    end

    return func1(arg1, arg2, tbl1, function(arg4)
        return isEnumType(arg4)
    end)
end

mapDefaultValues = function(arg1, arg2, arg3)
    local var1 = mapArguments

    local tbl1 = {}

    tbl1[MapperKind.ARGUMENT] = function(arg4)
        if arg4.defaultValue == nil then
            return arg4
        end
        local newType = getNewType(arg1, arg4.type)
        if newType ~= nil then
            return Object.assign({}, arg4, { defaultValue = arg3(newType, arg4.defaultValue) })
        end

        return nil
    end

    local var2 = var1(arg1, arg2, tbl1)

    local var3 = mapFields

    local tbl2 = {}

    tbl2[MapperKind.INPUT_OBJECT_FIELD] = function(arg4)
        if arg4.defaultValue == nil then
            return arg4
        end
        local newType = getNewType(var2, arg4.type)
        if newType ~= nil then
            return Object.assign({}, arg4, { defaultValue = arg3(newType, arg4.defaultValue) })
        end

        return nil
    end

    return var3(var2, arg2, tbl2)
end

getNewType = function(arg1, arg2)
    if Boolean.toJSBoolean(isListType(arg2)) then
        local newType = getNewType(arg1, arg2.ofType)

        if newType ~= nil then
            return (GraphQLList.new(newType))
        end

        return nil
    elseif Boolean.toJSBoolean(isNonNullType(arg2)) then
        local newType = getNewType(arg1, arg2.ofType)

        if newType ~= nil then
            return (GraphQLNonNull.new(newType))
        end

        return nil
    else
        if not Boolean.toJSBoolean(isNamedType(arg2)) then
            return nil
        end

        local var1 = arg1:get(arg2.name)

        return if var1 == nil then nil else var1
    end
end

mapFields = function(arg1, arg2, arg3)
    local map = Map.new()
    for _, value in arg1 do
        local var1 = table.unpack(value)

        if String.startsWith(var1, "__") then
            continue
        end

        local var2 = arg1:get(var1)

        if not (Boolean.toJSBoolean(isObjectType(var2))
            or Boolean.toJSBoolean(isInterfaceType(var2))
            or Boolean.toJSBoolean(isInputObjectType(var2))) then
            map:set(var1, var2)
        else
            local fieldMapper = getFieldMapper(arg2, arg3, var1)
            if fieldMapper == nil or fieldMapper == Object.None then
                map:set(var1, var2)
            else
                local var3 = var2:toConfig()

                local fields = var3.fields

                local map2 = Map.new()
                for _, field in fields do
                    local var4 = table.unpack(field)

                    local var5 = fields:get(var4)

                    local var6 = fieldMapper(var5, var4, var1, arg2)

                    if var6 == nil then
                        map2:set(var4, var5)
                    elseif Boolean.toJSBoolean(Array.isArray(var6)) then
                        local var7, var8 = table.unpack(var6, 1, 2)

                        if var8.astNode ~= nil and var8.astNode ~= Object.None then
                            local assign = Object.assign
                            local astNode = var8.astNode
                            local tbl1 = {
                                name = Object.assign({}, var8.astNode.name, { value = var7 })
                            }
                            var8.astNode = assign({}, astNode, tbl1)
                        end

                        if var8 == nil then
                            var8 = var5
                        end

                        map2:set(var7, var8)
                    elseif var6 ~= Object.None then
                        map2:set(var4, var6)
                    end
                end

                if Boolean.toJSBoolean(isObjectType(var2)) then
                    map:set(var1, (correctASTNodes(GraphQLObjectType.new(Object.assign({}, var3, { fields = map2 })))))
                elseif Boolean.toJSBoolean(isInterfaceType(var2)) then
                    map:set(var1, (correctASTNodes(GraphQLInterfaceType.new(Object.assign({}, var3, { fields = map2 })))))
                else
                    map:set(var1, (correctASTNodes(GraphQLInputObjectType.new(Object.assign({}, var3, { fields = map2 })))))
                end
            end
        end
    end

    return map
end

mapArguments = function(arg1, arg2, arg3)
    local map = Map.new()
    for _, value in arg1 do
        local var1 = table.unpack(value)

        if String.startsWith(var1, "__") then
            continue
        end

        local var2 = arg1:get(var1)

        if not (Boolean.toJSBoolean(isObjectType(var2)) or Boolean.toJSBoolean(isInterfaceType(var2))) then
            map:set(var1, var2)
        else
            local argumentMapper = getArgumentMapper(arg3)
            if argumentMapper == nil or argumentMapper == Object.None then
                map:set(var1, var2)
            else
                local var3 = var2:toConfig()

                local fields = var3.fields

                local map2 = Map.new()

                for _, field in fields do
                    local var4 = table.unpack(field)
                    local var5 = fields:get(var4)

                    local args = var5.args
                    if args == nil or args == Object.None then
                        map2:set(var4, var5)
                    else
                        local var6 = args:keys()

                        if not (#var6 > 0) then
                            map2:set(var4, var5)
                        else
                            local map3 = Map.new()

                            for _, value2 in var6 do
                                local var7 = args:get(value2)

                                local var8 = argumentMapper(var7, var4, var1, arg2)

                                if var8 == nil then
                                    map3:set(value2, var7)
                                elseif Boolean.toJSBoolean(Array.isArray(var8)) then
                                    local var9, var10 = table.unpack(var8, 1, 2)

                                    map3:set(var9, var10)
                                elseif var8 ~= Object.None then
                                    map3:set(value2, var8)
                                end
                            end

                            map2:set(var4, Object.assign({}, var5, { args = map3 }))
                        end
                    end
                end

                if Boolean.toJSBoolean(isObjectType(var2)) then
                    map:set(var1, GraphQLObjectType.new(Object.assign({}, var3, { fields = map2 })))
                elseif Boolean.toJSBoolean(isInterfaceType(var2)) then
                    map:set(var1, GraphQLInterfaceType.new(Object.assign({}, var3, { fields = map2 })))
                else
                    map:set(var1, GraphQLInputObjectType.new(Object.assign({}, var3, { fields = map2 })))
                end
            end
        end
    end

    return map
end

mapDirectives = function(arg1, arg2, arg3)
    local directiveMapper = getDirectiveMapper(arg3)
    if directiveMapper == nil or directiveMapper == Object.None then
        return Array.slice(arg1)
    end
    local result = {}
    for _, value in arg1 do
        local var1 = directiveMapper(value, arg2)

        if var1 == nil then
            table.insert(result, value)
        elseif var1 ~= Object.None then
            table.insert(result, var1)
        end
    end
    return result
end

local function getTypeSpecifiers(arg1, str1: string)
    local type = arg1:getType(str1)

    local tbl1 = { MapperKind.TYPE }

    if Boolean.toJSBoolean(isObjectType(type)) then
        tbl1 = Array.concat(tbl1, { MapperKind.COMPOSITE_TYPE, MapperKind.OBJECT_TYPE })
        local name = if typeof(arg1:getQueryType()) == "table" then arg1:getQueryType().name else nil

        if str1 == name then
            return (Array.concat(tbl1, { MapperKind.ROOT_OBJECT, MapperKind.QUERY }))
        end

        local name2 = if typeof(arg1:getMutationType()) == "table" then arg1:getMutationType().name else nil

        if str1 == name2 then
            return (Array.concat(tbl1, { MapperKind.ROOT_OBJECT, MapperKind.MUTATION }))
        end

        local name3 = if typeof(arg1:getSubscriptionType()) == "table" then arg1:getSubscriptionType().name else nil

        if str1 == name3 then
            return (Array.concat(tbl1, { MapperKind.ROOT_OBJECT, MapperKind.SUBSCRIPTION }))
        end
    else
        if Boolean.toJSBoolean(isInputObjectType(type)) then
            table.insert(tbl1, MapperKind.INPUT_OBJECT_TYPE)
            return tbl1
        end

        if Boolean.toJSBoolean(isInterfaceType(type)) then
            return (Array.concat(tbl1, { MapperKind.COMPOSITE_TYPE, MapperKind.ABSTRACT_TYPE, MapperKind.INTERFACE_TYPE }))
        end
        if Boolean.toJSBoolean(isUnionType(type)) then
            return (Array.concat(tbl1, { MapperKind.COMPOSITE_TYPE, MapperKind.ABSTRACT_TYPE, MapperKind.UNION_TYPE }))
        end
        if Boolean.toJSBoolean(isEnumType(type)) then
            table.insert(tbl1, MapperKind.ENUM_TYPE)
            return tbl1
        end

        if Boolean.toJSBoolean(isScalarType(type)) then
            table.insert(tbl1, MapperKind.SCALAR_TYPE)
        end
    end

    return tbl1
end

getTypeMapper = function(arg1, arg2, str1: string)
    local typeSpecifiers = getTypeSpecifiers(arg1, str1)

    local var1 = Array.concat({}, typeSpecifiers)
    local var2 = nil

    while not Boolean.toJSBoolean(var2) and #var1 > 0 do
        var2 = arg2[tostring(table.remove(var1))]
    end
    return if var2 == nil then nil else var2
end

local function getFieldSpecifiers(arg1, str1: string)
    local type = arg1:getType(str1)

    local tbl1 = { MapperKind.FIELD }

    if Boolean.toJSBoolean(isObjectType(type)) then
        tbl1 = Array.concat(tbl1, { MapperKind.COMPOSITE_FIELD, MapperKind.OBJECT_FIELD })
        local name = if typeof(arg1:getQueryType()) == "table" then arg1:getQueryType().name else nil

        if str1 == name then
            return (Array.concat(tbl1, { MapperKind.ROOT_FIELD, MapperKind.QUERY_ROOT_FIELD }))
        end

        local name2 = if typeof(arg1:getMutationType()) == "table" then arg1:getMutationType().name else nil

        if str1 == name2 then
            return (Array.concat(tbl1, { MapperKind.ROOT_FIELD, MapperKind.MUTATION_ROOT_FIELD }))
        end

        local name3 = if typeof(arg1:getSubscriptionType()) == "table" then arg1:getSubscriptionType().name else nil

        if str1 == name3 then
            return (Array.concat(tbl1, { MapperKind.ROOT_FIELD, MapperKind.SUBSCRIPTION_ROOT_FIELD }))
        end
    else
        if Boolean.toJSBoolean(isInterfaceType(type)) then
            return (Array.concat(tbl1, { MapperKind.COMPOSITE_FIELD, MapperKind.INTERFACE_FIELD }))
        end

        if Boolean.toJSBoolean(isInputObjectType(type)) then
            table.insert(tbl1, MapperKind.INPUT_OBJECT_FIELD)
        end
    end

    return tbl1
end

getFieldMapper = function(arg1, arg2, str1: string)
    local fieldSpecifiers = getFieldSpecifiers(arg1, str1)

    local var1 = Array.concat({}, table.unpack(fieldSpecifiers))
    local var2 = nil

    while not Boolean.toJSBoolean(var2) and #var1 > 0 do
        var2 = arg2[tostring(table.remove(var1))]
    end
    return if var2 == nil then nil else var2
end

getArgumentMapper = function(arg1)
    local var1 = arg1[tostring(MapperKind.ARGUMENT)]
    return if var1 == nil then nil else var1
end

getDirectiveMapper = function(arg1)
    local var1 = arg1[tostring(MapperKind.DIRECTIVE)]
    return if var1 == nil then nil else var1
end

getEnumValueMapper = function(arg1)
    local var1 = arg1[tostring(MapperKind.ENUM_VALUE)]
    return if var1 == nil then nil else var1
end

correctASTNodes = function(arg1)
    if Boolean.toJSBoolean(isObjectType(arg1)) then
        local var1 = arg1:toConfig()

        if var1.astNode ~= nil then
            local fields = {}

            for _, field in var1.fields do
                local var2 = table.unpack(field)

                local var3 = var1.fields:get(var2)

                if var3.astNode ~= nil then
                    table.insert(fields, var3.astNode)
                end
            end

            var1.astNode = Object.assign({}, var1.astNode, { kind = Kind.OBJECT_TYPE_DEFINITION, fields = fields })
        end

        if var1.extensionASTNodes ~= nil then
            var1.extensionASTNodes = Array.map(var1.extensionASTNodes, function(arg2)
                return Object.assign({}, arg2, { kind = Kind.OBJECT_TYPE_EXTENSION, fields = Object.None })
            end)
        end
        return GraphQLObjectType.new(var1)
    end

    if Boolean.toJSBoolean(isInterfaceType(arg1)) then
        local var1 = arg1:toConfig()

        if var1.astNode ~= nil then
            local fields = {}

            for _, field in var1.fields do
                local var2 = table.unpack(field)
                local var3 = var1.fields:get(var2)

                if var3.astNode ~= nil then
                    table.insert(fields, var3.astNode)
                end
            end
            var1.astNode = Object.assign({}, var1.astNode, { kind = Kind.INTERFACE_TYPE_DEFINITION, fields = fields })
        end

        if var1.extensionASTNodes ~= nil then
            var1.extensionASTNodes = Array.map(var1.extensionASTNodes, function(arg2)
                return Object.assign({}, arg2, { kind = Kind.INTERFACE_TYPE_EXTENSION, fields = Object.None })
            end)
        end
        return GraphQLInterfaceType.new(var1)
    end

    if Boolean.toJSBoolean(isInputObjectType(arg1)) then
        local var1 = arg1:toConfig()

        if var1.astNode ~= nil then
            local fields = {}

            for _, field in var1.fields do
                local var2 = table.unpack(field)
                local var3 = var1.fields:get(var2)

                if var3.astNode ~= nil then
                    table.insert(fields, var3.astNode)
                end
            end
            var1.astNode = Object.assign({}, var1.astNode, { kind = Kind.INPUT_OBJECT_TYPE_DEFINITION, fields = fields })
        end

        if var1.extensionASTNodes ~= nil then
            var1.extensionASTNodes = Array.map(var1.extensionASTNodes, function(arg2)
                return Object.assign({}, arg2, { kind = Kind.INPUT_OBJECT_TYPE_EXTENSION, fields = Object.None })
            end)
        end
        return GraphQLInputObjectType.new(var1)
    end

    if not Boolean.toJSBoolean(isEnumType(arg1)) then
        return arg1
    end

    local var1 = arg1:toConfig()

    if var1.astNode ~= nil then
        local values = {}

        for _, value in var1.values do
            local var2 = table.unpack(value)
            local var3 = var1.values:get(var2)

            if var3.astNode ~= nil then
                table.insert(values, var3.astNode)
            end
        end

        var1.astNode = Object.assign({}, var1.astNode, { values = values })
    end

    if var1.extensionASTNodes ~= nil then
        var1.extensionASTNodes = Array.map(var1.extensionASTNodes, function(arg2)
            return Object.assign({}, arg2, { values = Object.None })
        end)
    end
    return GraphQLEnumType.new(var1)
end

module.correctASTNodes = correctASTNodes
return module
