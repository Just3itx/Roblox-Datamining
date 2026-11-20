-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T20:00:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local LuauPolyfill = require(scriptParentParent.LuauPolyfill)
local Boolean = LuauPolyfill.Boolean
local Object = LuauPolyfill.Object
local module = {}
local GraphQLObjectType = require(scriptParentParent.GraphQL).GraphQLObjectType

local MapperKind = require(script.Parent.Interfaces).MapperKind
local mapSchema = require(script.Parent.mapSchema)

local mapSchema2 = mapSchema.mapSchema
local correctASTNodes = mapSchema.correctASTNodes

local addTypes = require(script.Parent.addTypes).addTypes

local Map = LuauPolyfill.Map

function module.appendObjectFields(arg1, name: string, fields)
    if arg1:getType(name) == nil then
        return addTypes(arg1, { GraphQLObjectType.new({ name = name, fields = fields }) })
    end
    local var1 = mapSchema2
    local tbl1 = {}

    tbl1[MapperKind.OBJECT_TYPE] = function(arg2)
        if arg2.name ~= name then
            return nil
        end

        local var2 = arg2:toConfig()
        local fields2 = var2.fields

        local map = Map.new()

        for _, field in fields2 do
            local var3 = field[1]

            map:set(var3, fields2:get(var3))
        end

        for _, field in fields do
            local var3 = field[1]

            map:set(var3, fields:get(var3))
        end

        return (correctASTNodes(GraphQLObjectType.new(Object.assign({}, var2, { fields = map }))))
    end

    return var1(arg1, tbl1)
end

function module.removeObjectFields(arg1, name: string, func1: (...any) -> (...any))
    local map = Map.new()

    local var1 = mapSchema2
    local tbl1 = {}

    tbl1[MapperKind.OBJECT_TYPE] = function(arg2)
        if arg2.name ~= name then
            return nil
        end

        local var2 = arg2:toConfig()
        local fields = var2.fields

        local map2 = Map.new()

        for _, field in fields do
            local var3 = table.unpack(field)

            local var4 = fields:get(var3)

            if Boolean.toJSBoolean(func1(var3, var4)) then
                map:set(var3, var4)
            else
                map2:set(var3, var4)
            end
        end

        return (correctASTNodes(GraphQLObjectType.new(Object.assign({}, var2, { fields = map2 }))))
    end

    return { var1(arg1, tbl1), map }
end

function module.selectObjectFields(arg1, name: string, func1: (...any) -> (...any))
    local map = Map.new()

    local var1 = mapSchema2
    local tbl1 = {}
    local objectType = MapperKind.OBJECT_TYPE

    tbl1[tostring(objectType)] = function(arg2)
        if arg2.name == name then
            local fields = arg2:toConfig().fields

            for _, field in fields do
                local var2 = field[1]

                local var3 = fields:get(var2)

                if Boolean.toJSBoolean(func1(var2, var3)) then
                    map:set(var2, var3)
                end
            end
        end

        return nil
    end

    var1(arg1, tbl1)

    return map
end

function module.modifyObjectFields(arg1, name: string, func1: (...any) -> (...any), arg2)
    local map = Map.new()

    local var1 = mapSchema2
    local tbl1 = {}

    tbl1[MapperKind.OBJECT_TYPE] = function(arg3)
        if arg3.name ~= name then
            return nil
        end

        local var2 = arg3:toConfig()
        local fields = var2.fields

        local map2 = Map.new()

        for _, field in fields do
            local var3 = field[1]

            local var4 = fields:get(var3)

            if Boolean.toJSBoolean(func1(var3, var4)) then
                map:set(var3, var4)
            else
                map2:set(var3, var4)
            end
        end

        for _, value in arg2 do
            local var3 = value[1]

            map2:set(var3, (arg2:get(var3)))
        end

        return (correctASTNodes(GraphQLObjectType.new(Object.assign({}, var2, { fields = map2 }))))
    end

    return { var1(arg1, tbl1), map }
end

return module
