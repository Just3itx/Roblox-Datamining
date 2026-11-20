-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T20:00:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local LuauPolyfill = require(scriptParentParent.LuauPolyfill)
local Array = LuauPolyfill.Array
local Boolean = LuauPolyfill.Boolean
local Object = LuauPolyfill.Object
local module = {}
local GraphQL = require(scriptParentParent.GraphQL)

local GraphQLInputObjectType = GraphQL.GraphQLInputObjectType
local GraphQLInterfaceType = GraphQL.GraphQLInterfaceType
local GraphQLObjectType = GraphQL.GraphQLObjectType

local MapperKind = require(script.Parent.Interfaces).MapperKind

local mapSchema = require(script.Parent.mapSchema).mapSchema
local _types = require(script.Parent.types)

local filterRootFields = nil
local filterElementFields = nil

function module.filterSchema(tbl1)
    local schema = tbl1.schema

    local var1 = tbl1.typeFilter == nil and function(...): boolean
        return true
    end or tbl1.typeFilter

    local fieldFilter = if tbl1.fieldFilter == nil then nil else tbl1.fieldFilter
    local rootFieldFilter = if tbl1.rootFieldFilter == nil then nil else tbl1.rootFieldFilter
    local objectFieldFilter = if tbl1.objectFieldFilter == nil then nil else tbl1.objectFieldFilter
    local interfaceFieldFilter = if tbl1.interfaceFieldFilter == nil then nil else tbl1.interfaceFieldFilter
    local inputObjectFieldFilter = if tbl1.inputObjectFieldFilter == nil then nil else tbl1.inputObjectFieldFilter
    local argumentFilter = if tbl1.argumentFilter == nil then nil else tbl1.argumentFilter
    local var2 = mapSchema
    local tbl2 = {}

    tbl2[MapperKind.QUERY] = function(arg1)
        return filterRootFields(arg1, "Query", rootFieldFilter, argumentFilter)
    end

    tbl2[MapperKind.MUTATION] = function(arg1)
        return filterRootFields(arg1, "Mutation", rootFieldFilter, argumentFilter)
    end

    tbl2[MapperKind.SUBSCRIPTION] = function(arg1)
        return filterRootFields(arg1, "Subscription", rootFieldFilter, argumentFilter)
    end

    tbl2[MapperKind.OBJECT_TYPE] = function(arg1)
        if Boolean.toJSBoolean(var1(arg1.name, arg1)) then
            return (filterElementFields(
                GraphQLObjectType,
                arg1,
                Boolean.toJSBoolean(objectFieldFilter) and objectFieldFilter or fieldFilter,
                argumentFilter
            ))
        end

        return Object.None
    end

    tbl2[MapperKind.INTERFACE_TYPE] = function(arg1)
        if Boolean.toJSBoolean(var1(arg1.name, arg1)) then
            return (filterElementFields(
                GraphQLInterfaceType,
                arg1,
                Boolean.toJSBoolean(interfaceFieldFilter) and interfaceFieldFilter or fieldFilter,
                argumentFilter
            ))
        end

        return Object.None
    end

    tbl2[MapperKind.INPUT_OBJECT_TYPE] = function(arg1)
        if Boolean.toJSBoolean(var1(arg1.name, arg1)) then
            return (filterElementFields(
                GraphQLInputObjectType,
                arg1,
                Boolean.toJSBoolean(inputObjectFieldFilter) and inputObjectFieldFilter or fieldFilter
            ))
        end

        return Object.None
    end

    tbl2[MapperKind.UNION_TYPE] = function(arg1)
        return if Boolean.toJSBoolean(var1(arg1.name, arg1)) then nil else Object.None
    end

    tbl2[MapperKind.ENUM_TYPE] = function(arg1)
        return if Boolean.toJSBoolean(var1(arg1.name, arg1)) then nil else Object.None
    end

    tbl2[MapperKind.SCALAR_TYPE] = function(arg1)
        return if Boolean.toJSBoolean(var1(arg1.name, arg1)) then nil else Object.None
    end

    return (var2(schema, tbl2))
end

filterRootFields = function(arg1, str1: string, arg2, arg3)
    if not Boolean.toJSBoolean(Boolean.toJSBoolean(arg2) and arg2 or arg3) then
        return arg1
    end

    local var1 = arg1:toConfig()

    for _, field in var1.fields do
        local var2 = table.unpack(field)
        local var3 = var1.fields:get(var2)

        if arg2 and not arg2(str1, var2, (var1.fields:get(var2))) then
            var1.fields:delete(var2)
        else
            local toJsBoolean = Boolean.toJSBoolean

            if toJsBoolean(if Boolean.toJSBoolean(arg3) then var3.args else arg3) then
                for _, arg in var3.args do
                    local var4 = table.unpack(arg)

                    if not arg3(str1, var2, var4, var3.args:get(var4)) then
                        var3.args:delete(var4)
                    end
                end
            end
        end
    end
    return GraphQLObjectType.new(var1)
end

filterElementFields = function(arg1, arg2, arg3, arg4)
    if not Boolean.toJSBoolean(Boolean.toJSBoolean(arg3) and arg3 or arg4) then
        return nil
    end

    local var1 = arg2:toConfig()

    for _, field in var1.fields do
        local var2 = table.unpack(field)
        local var3 = var1.fields:get(var2)

        if Boolean.toJSBoolean(arg3 and not arg3(arg2.name, var2, var1.fields:get(var2))) then
            var1.fields:delete(var2)
        else
            local toJsBoolean = Boolean.toJSBoolean

            if toJsBoolean(if Boolean.toJSBoolean(arg4) then Array.indexOf(Object.keys(var3), "args") ~= -1 else arg4) then
                for _, arg in var3.args do
                    local var4 = table.unpack(arg)

                    if not Boolean.toJSBoolean(arg4(arg2.name, var2, var4, var3.args:get(var4))) then
                        var3.args:delete(var4)
                    end
                end
            end
        end
    end
    return arg1.new(var1)
end

return module
