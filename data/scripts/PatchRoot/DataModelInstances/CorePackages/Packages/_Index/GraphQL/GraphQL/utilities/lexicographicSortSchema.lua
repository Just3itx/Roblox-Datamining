-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T08:10:53Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local scriptParentParentParent = scriptParentParent.Parent

local LuauPolyfill = require(scriptParentParentParent.LuauPolyfill)
local Array = LuauPolyfill.Array
local Map = LuauPolyfill.Map
local Object = LuauPolyfill.Object

local inspect = require(scriptParentParent.jsutils.inspect).inspect
local invariant = require(scriptParentParent.jsutils.invariant).invariant
local keyValMap = require(scriptParentParent.jsutils.keyValMap).keyValMap
local naturalCompare = require(scriptParentParent.jsutils.naturalCompare).naturalCompare

local GraphQLSchema = require(scriptParentParent.type.schema).GraphQLSchema

local GraphQLDirective = require(scriptParentParent.type.directives).GraphQLDirective

local definition = require(scriptParentParent.type.definition)

local _ast = require(scriptParentParent.language.ast)

local isIntrospectionType = require(scriptParentParent.type.introspection).isIntrospectionType
local GraphQLList = definition.GraphQLList
local GraphQLNonNull = definition.GraphQLNonNull
local GraphQLObjectType = definition.GraphQLObjectType
local GraphQLInterfaceType = definition.GraphQLInterfaceType
local GraphQLUnionType = definition.GraphQLUnionType
local GraphQLEnumType = definition.GraphQLEnumType
local GraphQLInputObjectType = definition.GraphQLInputObjectType
local isListType = definition.isListType
local isNonNullType = definition.isNonNullType
local isScalarType = definition.isScalarType
local isObjectType = definition.isObjectType
local isInterfaceType = definition.isInterfaceType
local isUnionType = definition.isUnionType
local isEnumType = definition.isEnumType
local isInputObjectType = definition.isInputObjectType

local sortObjMap = nil
local sortByName = nil
local sortBy = nil

local function lexicographicSortSchema(arg1)
    local var1 = nil
    local replaceNamedType = nil
    local sortArgs = nil

    local var2 = arg1:toConfig()

    local function replaceType(arg2)
        if isListType(arg2) then
            return GraphQLList.new(replaceType(arg2.ofType))
        elseif isNonNullType(arg2) then
            return GraphQLNonNull.new(replaceType(arg2.ofType))
        end

        return replaceNamedType(arg2)
    end

    replaceNamedType = function(arg2)
        return var1[arg2.name]
    end

    local function replaceMaybeType(arg2)
        if arg2 then
            return (replaceNamedType(arg2))
        end

        return nil
    end

    local function sortDirective(arg2)
        local var3 = arg2:toConfig()

        return GraphQLDirective.new(Object.assign({}, var3, {
            locations = sortBy(var3.locations, function<T>(arg3: T): T
                return arg3
            end),
            args = sortArgs(var3.args)
        }))
    end

    sortArgs = function(arg2)
        return sortObjMap(arg2, function(arg3)
            return Object.assign({}, arg3, { type = replaceType(arg3.type) })
        end)
    end

    local function sortFields(fields)
        return sortObjMap(fields, function(arg2)
            return Object.assign({}, arg2, { type = replaceType(arg2.type), args = if arg2.args then sortArgs(arg2.args) else nil })
        end)
    end

    local function sortInputFields(fields)
        return sortObjMap(fields, function(arg2)
            return Object.assign({}, arg2, { type = replaceType(arg2.type) })
        end)
    end

    local function sortTypes(arg2)
        return Array.map(sortByName(arg2), replaceNamedType)
    end

    local function sortNamedType(arg2)
        if isScalarType(arg2) or isIntrospectionType(arg2) then
            return arg2
        end
        if isObjectType(arg2) then
            local var3 = arg2:toConfig()

            return GraphQLObjectType.new(Object.assign({}, var3, {
                interfaces = function()
                    return sortTypes(var3.interfaces)
                end,
                fields = function()
                    return sortFields(var3.fields)
                end
            }))
        end
        if isInterfaceType(arg2) then
            local var3 = arg2:toConfig()

            return GraphQLInterfaceType.new(Object.assign({}, var3, {
                interfaces = function()
                    return sortTypes(var3.interfaces)
                end,
                fields = function()
                    return sortFields(var3.fields)
                end
            }))
        end
        if isUnionType(arg2) then
            local var3 = arg2:toConfig()

            return GraphQLUnionType.new(Object.assign({}, var3, {
                types = function()
                    return sortTypes(var3.types)
                end
            }))
        end
        if isEnumType(arg2) then
            local var3 = arg2:toConfig()

            return GraphQLEnumType.new(Object.assign({}, var3, {
                values = sortObjMap(var3.values, function<T>(arg3: T): T
                    return arg3
                end)
            }))
        end

        if not isInputObjectType(arg2) then
            invariant(false, "Unexpected type: " .. inspect(arg2))
            error("Unexpected type: " .. inspect(arg2))
            return
        end

        local var3 = arg2:toConfig()

        return GraphQLInputObjectType.new(Object.assign({}, var3, {
            fields = function()
                return sortInputFields(var3.fields)
            end
        }))
    end
    var1 = keyValMap(sortByName(var2.types), function(arg2)
        return arg2.name
    end, sortNamedType)

    return GraphQLSchema.new(
        Object.assign({}, var2, {
            types = var1:values(),
            directives = Array.map(sortByName(var2.directives), sortDirective),
            query = replaceMaybeType(var2.query),
            mutation = replaceMaybeType(var2.mutation),
            subscription = replaceMaybeType(var2.subscription)
        })
    )
end

sortObjMap = function(arg1, func1: (...any) -> (...any))
    local map = Map.new()

    local var1 = sortBy(arg1:keys(), function<T>(arg2: T): T
        return arg2
    end)

    for _, value in ipairs(var1) do
        map[value] = func1(arg1[value])
    end

    return map
end

sortByName = function(arg1)
    return sortBy(arg1, function(arg2)
        return arg2.name
    end)
end

sortBy = function(arg1, func1: (...any) -> (...any))
    return Array.sort(Array.slice(arg1), function(arg2, arg3)
        local var1 = func1(arg2)
        local var2 = func1(arg3)
        return naturalCompare(var1, var2)
    end)
end

return { lexicographicSortSchema = lexicographicSortSchema }
