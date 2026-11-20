-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T20:01:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local LuauPolyfill = require(scriptParentParent.LuauPolyfill)
local Array = LuauPolyfill.Array
local Boolean = LuauPolyfill.Boolean
local Error = LuauPolyfill.Error

local console = LuauPolyfill.console

local module = {}
local GraphQL = require(scriptParentParent.GraphQL)

local GraphQLList = GraphQL.GraphQLList

local GraphQLNonNull = GraphQL.GraphQLNonNull

local isNamedType = GraphQL.isNamedType

local isObjectType = GraphQL.isObjectType
local isInterfaceType = GraphQL.isInterfaceType
local isUnionType = GraphQL.isUnionType
local isInputObjectType = GraphQL.isInputObjectType
local isLeafType = GraphQL.isLeafType
local isListType = GraphQL.isListType
local isNonNullType = GraphQL.isNonNullType

local Map = LuauPolyfill.Map
local String = LuauPolyfill.String

local healTypes = nil

function module.healSchema<T>(arg1: T): T
    healTypes(arg1:getTypeMap(), arg1:getDirectives())

    return arg1
end

healTypes = function(arg1, arg2)
    local healFields = nil
    local healInterfaces = nil
    local healInputFields = nil
    local healUnderlyingTypes = nil
    local healType = nil

    local function healNamedType(arg3)
        if Boolean.toJSBoolean(isObjectType(arg3)) then
            healFields(arg3)
            healInterfaces(arg3)
            return
        end

        if Boolean.toJSBoolean(isInterfaceType(arg3)) then
            healFields(arg3)

            if arg3.getInterfaces ~= nil then
                healInterfaces(arg3)
            end

            return
        end

        if Boolean.toJSBoolean(isUnionType(arg3)) then
            healUnderlyingTypes(arg3)
            return
        end

        if Boolean.toJSBoolean(isInputObjectType(arg3)) then
            healInputFields(arg3)
        elseif not Boolean.toJSBoolean(isLeafType(arg3)) then
            error(Error.new(("Unexpected schema type: %s"):format(tostring(arg3))))
        end
    end

    healFields = function(arg3)
        local fields = arg3:getFields()

        for _, value in fields:entries() do
            local var1 = value[1]
            local var2 = value[2]

            Array.filter(Array.map(var2.args, function(arg4)
                arg4.type = healType(arg4.type)
                return if arg4.type == nil then nil else arg4
            end), Boolean.toJSBoolean)

            var2.type = healType(var2.type)
            if var2.type == nil then
                fields[tostring(var1)] = nil
            end
        end
    end

    healInterfaces = function(arg3)
        if arg3.getInterfaces ~= nil then
            local interfaces = arg3:getInterfaces()

            Array.concat(interfaces, Array.filter(Array.map(Array.splice(interfaces, 1), function(arg4)
                return (healType(arg4))
            end), Boolean.toJSBoolean))
        end
    end

    healInputFields = function(arg3)
        local fields = arg3:getFields()

        for _, value in fields:entries() do
            local var1 = value[1]
            local var2 = value[2]

            var2.type = healType(var2.type)
            if var2.type == nil then
                fields[tostring(var1)] = nil
            end
        end
    end

    healUnderlyingTypes = function(arg3)
        local types = arg3:getTypes()

        Array.concat(types, Array.filter(Array.map(Array.splice(types, 1), function(arg4)
            return (healType(arg4))
        end), Boolean.toJSBoolean))
    end

    healType = function(arg3)
        if Boolean.toJSBoolean(isListType(arg3)) then
            local var1 = healType(arg3.ofType)

            if var1 ~= nil then
                return (GraphQLList.new(var1))
            end

            return nil
        elseif Boolean.toJSBoolean(isNonNullType(arg3)) then
            local var1 = healType(arg3.ofType)

            if var1 ~= nil then
                return (GraphQLNonNull.new(var1))
            end

            return nil
        else
            if Boolean.toJSBoolean(isNamedType(arg3)) then
                local var1 = arg1:get(arg3.name)

                local toJsBoolean = Boolean.toJSBoolean

                if toJsBoolean(if Boolean.toJSBoolean(var1) then arg3 ~= var1 else var1) then
                    return var1
                end
            end

            return arg3
        end
    end
    local map = Map.new()

    for _, value in arg1 do
        local var1 = table.unpack(value)
        local var2 = arg1:get(var1)
        if var2 == nil or String.startsWith(var1, "__") then
            continue
        end

        local name = var2.name
        if String.startsWith(name, "__") then
            continue
        end

        if map:get(name) ~= nil then
            console.warn(("Duplicate schema type name %s found; keeping the existing one found in the schema"):format(name))
        else
            map:set(name, var2)
        end
    end

    for _, value in map do
        local var1 = table.unpack(value)
        arg1:set(var1, (map:get(var1)))
    end

    for _, value in arg2 do
        value.args = Array.filter(value.args, function(arg3): boolean
            arg3.type = healType(arg3.type)
            return arg3.type ~= nil
        end)
    end

    for _, value in arg1 do
        local var1 = table.unpack(value)
        local var2 = arg1:get(var1)

        if not String.startsWith(var1, "__") and Array.indexOf(map:keys(), var1) ~= -1 and var2 ~= nil then
            healNamedType(var2)
        end
    end

    for _, value in arg1 do
        local var1 = table.unpack(value)
        if not String.startsWith(var1, "__") and Array.indexOf(map:keys(), var1) == -1 then
            arg1:set(var1, nil)
        end
    end
end

module.healTypes = healTypes
return module
