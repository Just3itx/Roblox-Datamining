-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T20:10:39Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local LuauPolyfill = require(scriptParentParent.LuauPolyfill)
local Array = LuauPolyfill.Array
local Boolean = LuauPolyfill.Boolean
local Map = LuauPolyfill.Map
local Object = LuauPolyfill.Object
local Set = LuauPolyfill.Set

local module = {}
local GraphQL = require(scriptParentParent.GraphQL)

local getNamedType = GraphQL.getNamedType
local isObjectType = GraphQL.isObjectType
local isInterfaceType = GraphQL.isInterfaceType
local isUnionType = GraphQL.isUnionType
local isInputObjectType = GraphQL.isInputObjectType

local isSpecifiedScalarType = GraphQL.isSpecifiedScalarType
local isScalarType = GraphQL.isScalarType
local isEnumType = GraphQL.isEnumType

local _types = require(script.Parent.types)

local mapSchema = require(script.Parent.mapSchema).mapSchema
local MapperKind = require(script.Parent.Interfaces).MapperKind
local getRootTypes = require(script.Parent.rootTypes).getRootTypes
local getImplementingTypes = require(script.Parent["get-implementing-types"]).getImplementingTypes

local String = LuauPolyfill.String

local visitSchema = nil
local visitQueue = nil
local getDirectivesArgumentsTypeNames = nil

function module.pruneSchema(arg1, arg2)
    local var1 = arg2 == nil and {} or arg2

    local skipEmptyCompositeTypePruning = var1.skipEmptyCompositeTypePruning
    local skipEmptyUnionPruning = var1.skipEmptyUnionPruning
    local skipPruning = var1.skipPruning
    local skipUnimplementedInterfacesPruning = var1.skipUnimplementedInterfacesPruning
    local skipUnusedTypesPruning = var1.skipUnusedTypesPruning
    local tbl1 = {}

    repeat
        local var2 = visitSchema(arg1)

        if skipPruning then
            local tbl2 = {}
            local var3 = var2

            for _, value in arg1:getTypeMap() do
                local var4 = value[1]

                if String.startsWith(var4, "__") then
                    continue
                end

                local type = arg1:getType(var4)

                if type and skipPruning(type) then
                    table.insert(tbl2, var4)
                end
            end
            var2 = visitQueue(tbl2, arg1, var3)
        end
        tbl1 = {}
        local var3 = mapSchema
        local tbl2 = {}

        tbl2[MapperKind.TYPE] = function(arg3)
            if Boolean.toJSBoolean(var2:has(arg3.name)) or Boolean.toJSBoolean(isSpecifiedScalarType(arg3)) then
                return arg3
            end

            if isUnionType(arg3) or isInputObjectType(arg3) or isInterfaceType(arg3) or isObjectType(arg3) or isScalarType(arg3) then
                if Boolean.toJSBoolean(skipUnusedTypesPruning) then
                    return arg3
                end

                if isUnionType(arg3) and skipEmptyUnionPruning and not Boolean.toJSBoolean(#arg3.getTypes(arg3)) then
                    return arg3
                end

                if (isInputObjectType(arg3) or isInterfaceType(arg3) or isObjectType(arg3))
                    and skipEmptyCompositeTypePruning
                    and not Boolean.toJSBoolean(#arg3.getFields(arg3):keys())
                then
                    return arg3
                end

                if isInterfaceType(arg3) and skipUnimplementedInterfacesPruning then
                    return arg3
                end
            end
            table.insert(tbl1, arg3.name)
            var2:delete(arg3.name)

            return Object.None
        end

        arg1 = var3(arg1, tbl2)
    until #tbl1 == 0

    return arg1
end

visitSchema = function(arg1)
    local tbl1 = {}

    for _, value in getRootTypes(arg1) do
        table.insert(tbl1, value.name)
    end
    return visitQueue(tbl1, arg1)
end

visitQueue = function(arg1, arg2, arg3)
    if arg3 == nil then
        arg3 = Set.new()
    end
    local map = Map.new()

    while true do
        if #arg1 == 0 then
            return arg3
        end

        local var1 = table.remove(arg1)

        if arg3:has(var1) and map[var1] ~= true then
            continue
        end

        local type = arg2:getType(var1)

        if not (Boolean.toJSBoolean(type) and type) then
            continue
        end

        if Boolean.toJSBoolean(isUnionType(type)) then
            arg1 = Array.concat(arg1, Array.map(type:getTypes(), function(arg4)
                return arg4.name
            end))
        end

        if isInterfaceType(type) and map[var1] == true then
            arg1 = Array.concat(arg1, getImplementingTypes(type.name, arg2))

            map[tostring(var1)] = false
        end
        if Boolean.toJSBoolean(isEnumType(type)) then
            arg1 = Array.concat(arg1, Array.flatMap(type:getValues(), function(arg4)
                if arg4.astNode then
                    return getDirectivesArgumentsTypeNames(arg2, arg4.astNode)
                end
                return {}
            end))
        end

        if type.getInterfaces ~= nil then
            arg1 = Array.concat(arg1, Array.map(type:getInterfaces(), function(arg4)
                return arg4.name
            end))
        end

        if type.getFields ~= nil then
            local var2 = type:getFields():entries()

            if #var2 == 0 then
                continue
            end

            for _, value in var2 do
                local var3 = value[2]

                if Boolean.toJSBoolean(isObjectType(type)) then
                    arg1 = Array.concat(arg1, Array.flatMap(var3.args, function(arg4)
                        local tbl1 = { getNamedType(arg4.type).name }
                        if arg4.astNode then
                            tbl1 = Array.concat(tbl1, getDirectivesArgumentsTypeNames(arg2, arg4.astNode))
                        end
                        return tbl1
                    end))
                end

                local namedType = getNamedType(var3.type)
                table.insert(arg1, namedType.name)
                if Boolean.toJSBoolean(var3.astNode) then
                    arg1 = Array.concat(arg1, getDirectivesArgumentsTypeNames(arg2, var3.astNode))
                end

                if isInterfaceType(namedType) and not map:has(namedType.name) then
                    local name = namedType.name
                    map[tostring(name)] = true
                end
            end
        end
        if Boolean.toJSBoolean(type.astNode) then
            arg1 = Array.concat(arg1, getDirectivesArgumentsTypeNames(arg2, type.astNode))
        end

        arg3:add(var1)
    end
end

getDirectivesArgumentsTypeNames = function(arg1, arg2)
    return Array.flatMap(arg2.directives or {}, function(arg3)
        local directive = arg1:getDirective(arg3.name.value)
        local args = if typeof(directive) == "table" then directive.args else nil

        local var1 = if args == nil then nil else Array.map(args, function(arg4)
            return getNamedType(arg4.type).name
        end)

        return if var1 == nil then {} else var1
    end)
end

return module
