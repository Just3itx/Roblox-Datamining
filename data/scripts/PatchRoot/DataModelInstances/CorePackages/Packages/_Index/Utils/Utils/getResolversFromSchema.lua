-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T20:01:11Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local LuauPolyfill = require(scriptParentParent.LuauPolyfill)
local Boolean = LuauPolyfill.Boolean

local module = {}
local GraphQL = require(scriptParentParent.GraphQL)
local GraphQLScalarType = GraphQL.GraphQLScalarType

local isScalarType = GraphQL.isScalarType
local isEnumType = GraphQL.isEnumType
local isInterfaceType = GraphQL.isInterfaceType
local isUnionType = GraphQL.isUnionType
local isObjectType = GraphQL.isObjectType
local isSpecifiedScalarType = GraphQL.isSpecifiedScalarType

local _Interfaces = require(script.Parent.Interfaces)

local String = LuauPolyfill.String

function module.getResolversFromSchema(arg1, bool1: boolean?)
    local resolversFromSchema = ({})

    local typeMap = arg1:getTypeMap()

    for _, value in typeMap do
        local var1 = value[1]

        if String.startsWith(var1, "__") then
            continue
        end

        local var2 = typeMap:get(var1)

        if Boolean.toJSBoolean(isScalarType(var2)) then
            if Boolean.toJSBoolean(isSpecifiedScalarType(var2)) then
                continue
            end

            local var3 = var2:toConfig()

            var3.astNode = nil

            local serialize = var3.serialize
            local parseValue = var3.parseValue
            local parseLiteral = var3.parseLiteral

            if serialize then
                function var3.serialize(...)
                    return serialize(var3, ...)
                end
            end
            if parseValue then
                function var3.parseValue(...)
                    return parseValue(var3, ...)
                end
            end
            if parseLiteral then
                function var3.parseLiteral(...)
                    return parseLiteral(var3, ...)
                end
            end

            resolversFromSchema[tostring(var1)] = GraphQLScalarType.new(var3)
        elseif Boolean.toJSBoolean(isEnumType(var2)) then
            resolversFromSchema[tostring(var1)] = {}

            for _, value2 in (var2:getValues()) do
                local var3 = resolversFromSchema[tostring(var1)]
                local name = value2.name
                var3[tostring(name)] = value2.value
            end
        elseif Boolean.toJSBoolean(isInterfaceType(var2)) or Boolean.toJSBoolean(isUnionType(var2)) then
            if var2.resolveType == nil then
                continue
            end

            resolversFromSchema[var1] = {
                __resolveType = var2.resolveType
            }
        else
            if not Boolean.toJSBoolean(isObjectType(var2)) then
                continue
            end

            resolversFromSchema[tostring(var1)] = {}

            if var2.isTypeOf ~= nil then
                resolversFromSchema[var1].__isTypeOf = var2.isTypeOf
            end

            local fields = var2:getFields()

            for _, field in fields do
                local var3 = field[1]

                local var4 = fields:get(var3)

                if var4.subscribe ~= nil then
                    resolversFromSchema[tostring(var1)][tostring(var3)] = not Boolean.toJSBoolean(resolversFromSchema[tostring(var1)][tostring(var3)]) and {}
                        or resolversFromSchema[tostring(var1)][tostring(var3)]
                        or {}
                    resolversFromSchema[tostring(var1)][tostring(var3)].subscribe = var4.subscribe
                end

                if var4.resolve == nil then
                    continue
                end

                if (if typeof(var4.resolve) == "table" then var4.resolve.name else nil) == "defaultFieldResolver" then
                    continue
                end

                local name = if typeof(var4.resolve) == "table" then var4.resolve.name else nil
                if name == "defaultMergedResolver" then
                    if not Boolean.toJSBoolean(bool1) then
                        continue
                    end
                elseif name == "defaultFieldResolver" then
                    continue
                end

                resolversFromSchema[tostring(var1)][tostring(var3)] = not Boolean.toJSBoolean(resolversFromSchema[tostring(var1)][tostring(var3)]) and {}
                    or resolversFromSchema[tostring(var1)][tostring(var3)]
                    or {}
                resolversFromSchema[tostring(var1)][tostring(var3)].resolve = var4.resolve
            end
        end
    end

    return resolversFromSchema
end

return module
