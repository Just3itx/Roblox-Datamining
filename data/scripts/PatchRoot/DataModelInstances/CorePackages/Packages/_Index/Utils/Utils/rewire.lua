-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T20:10:42Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local LuauPolyfill = require(scriptParentParent.LuauPolyfill)
local Array = LuauPolyfill.Array

local Error = LuauPolyfill.Error
local Object = LuauPolyfill.Object
local console = LuauPolyfill.console

local module = {}
local GraphQL = require(scriptParentParent.GraphQL)
local GraphQLDirective = GraphQL.GraphQLDirective

local GraphQLEnumType = GraphQL.GraphQLEnumType

local GraphQLInputObjectType = GraphQL.GraphQLInputObjectType

local GraphQLInterfaceType = GraphQL.GraphQLInterfaceType

local GraphQLList = GraphQL.GraphQLList
local GraphQLObjectType = GraphQL.GraphQLObjectType

local GraphQLNonNull = GraphQL.GraphQLNonNull
local GraphQLScalarType = GraphQL.GraphQLScalarType

local GraphQLUnionType = GraphQL.GraphQLUnionType

local isInterfaceType = GraphQL.isInterfaceType
local isEnumType = GraphQL.isEnumType
local isInputObjectType = GraphQL.isInputObjectType
local isListType = GraphQL.isListType
local isNamedType = GraphQL.isNamedType
local isNonNullType = GraphQL.isNonNullType
local isObjectType = GraphQL.isObjectType
local isScalarType = GraphQL.isScalarType
local isUnionType = GraphQL.isUnionType
local isSpecifiedScalarType = GraphQL.isSpecifiedScalarType
local isSpecifiedDirective = GraphQL.isSpecifiedDirective

local stub = require(script.Parent.stub)

local getBuiltInForStub = stub.getBuiltInForStub
local isNamedStub = stub.isNamedStub

local Map = LuauPolyfill.Map
local String = LuauPolyfill.String

function module.rewireTypes(arg1, arg2)
    local map = nil
    local map2 = nil

    local rewireArgs = nil

    local rewireFields = nil
    local rewireInputFields = nil
    local rewireNamedTypes = nil
    local rewireType = nil
    local function rewireDirective(arg3)
        if isSpecifiedDirective(arg3) then
            return arg3
        end
        local var1 = arg3:toConfig()
        var1.args = rewireArgs(var1.args)
        return GraphQLDirective.new(var1)
    end

    rewireArgs = function(arg3)
        local map3 = Map.new()
        for _, value in arg3 do
            local var1 = value[1]

            local var2 = arg3:get(var1)
            local type = rewireType(var2.type)
            if type ~= nil then
                var2.type = type
                map3:set(var1, var2)
            end
        end
        return map3
    end

    local function rewireNamedType(arg3)
        if isObjectType(arg3) then
            local var1 = arg3:toConfig()
            local var2 = Object.assign({}, var1, {
                fields = function()
                    return rewireFields(var1.fields)
                end,
                interfaces = function()
                    return rewireNamedTypes(var1.interfaces)
                end
            })
            return GraphQLObjectType.new(var2)
        end

        if isInterfaceType(arg3) then
            local var1 = arg3:toConfig()
            local var2 = Object.assign({}, var1, {
                fields = function()
                    return rewireFields(var1.fields)
                end
            })
            if Array.indexOf(Object.keys(var2), "interfaces") ~= -1 then
                function var2.interfaces(_)
                    return rewireNamedTypes(var1.interfaces)
                end
            end

            return GraphQLInterfaceType.new(var2)
        end

        if isUnionType(arg3) then
            local var1 = arg3:toConfig()
            local var2 = Object.assign({}, var1, {
                types = function()
                    return rewireNamedTypes(var1.types)
                end
            })
            return GraphQLUnionType.new(var2)
        end

        if isInputObjectType(arg3) then
            local var1 = arg3:toConfig()
            local var2 = Object.assign({}, var1, {
                fields = function()
                    return rewireInputFields(var1.fields)
                end
            })
            return GraphQLInputObjectType.new(var2)
        end

        if isEnumType(arg3) then
            local var1 = arg3:toConfig()
            return GraphQLEnumType.new(var1)
        end

        if not isScalarType(arg3) then
            error(Error.new(("Unexpected schema type: %s"):format(tostring(arg3))))
            return
        end

        if isSpecifiedScalarType(arg3) then
            return arg3
        end
        local var1 = arg3:toConfig()

        local serialize = var1.serialize
        local parseValue = var1.parseValue
        local parseLiteral = var1.parseLiteral

        if serialize then
            function var1.serialize(...)
                return serialize(var1, ...)
            end
        end
        if parseValue then
            function var1.parseValue(...)
                return parseValue(var1, ...)
            end
        end
        if parseLiteral then
            function var1.parseLiteral(...)
                return parseLiteral(var1, ...)
            end
        end

        return GraphQLScalarType.new(var1)
    end

    rewireFields = function(arg3)
        local map3 = Map.new()
        for _, value in arg3 do
            local var1 = value[1]
            local var2 = arg3:get(var1)
            local type = rewireType(var2.type)
            if type ~= nil and var2.args then
                var2.type = type
                var2.args = rewireArgs(var2.args)
                map3:set(var1, var2)
            end
        end
        return map3
    end

    rewireInputFields = function(arg3)
        local map3 = Map.new()
        for _, value in arg3 do
            local var1 = value[1]
            local var2 = arg3:get(var1)
            local type = rewireType(var2.type)
            if type ~= nil then
                var2.type = type
                map3:set(var1, var2)
            end
        end
        return map3
    end

    rewireNamedTypes = function(arg3)
        local result = {}
        for _, value in arg3 do
            local var1 = rewireType(value)
            if var1 ~= nil and var1 ~= Object.None then
                table.insert(result, var1)
            end
        end
        return result
    end

    rewireType = function(arg3)
        if isListType(arg3) then
            local var1 = rewireType(arg3.ofType)
            if var1 ~= nil and var1 ~= Object.None then
                return (GraphQLList.new(var1))
            end

            return nil
        elseif isNonNullType(arg3) then
            local var1 = rewireType(arg3.ofType)
            if var1 ~= nil and var1 ~= Object.None then
                return (GraphQLNonNull.new(var1))
            end

            return nil
        elseif isNamedType(arg3) then
            local var1 = map:get(arg3.name)
            if var1 == nil then
                if isNamedStub(arg3) then
                    var1 = getBuiltInForStub(arg3)
                else
                    var1 = rewireNamedType(arg3)
                end

                map:set(arg3.name, var1)
                map2:set(var1.name, (map:get(arg3.name)))
            end

            if var1 ~= nil and var1 ~= Object.None then
                return (map2:get(var1.name))
            end

            return nil
        else
            return nil
        end
    end

    map = Map.new()

    for _, value in arg1 do
        local var1 = value[1]

        local var2 = arg1:get(var1)
        map:set(var1, var2)
    end

    map2 = Map.new()

    for _, value in map do
        local var1 = value[1]

        local var2 = map:get(var1)

        if var2 == nil or var2 == Object.None or String.startsWith(var1, "__") then
            continue
        end

        local name = var2.name

        if String.startsWith(name, "__") then
            continue
        end

        if map2:get(name) ~= nil then
            console.warn(
                ("Duplicate schema type name %s found; keeping the existing one found in the schema"):format(tostring(name))
            )
        else
            map2:set(name, var2)
        end
    end

    for _, value in map2 do
        local var1 = value[1]

        map2:set(var1, rewireNamedType(map2:get(var1)))
    end

    local directives = Array.map(arg2, function(arg3)
        return rewireDirective(arg3)
    end)
    return { typeMap = map2, directives = directives }
end

return module
