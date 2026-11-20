-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T08:10:32Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function parseInt(arg1, arg2): number? -- Luacid: Inlined by compiler; 2 call sites recovered
    return tonumber(arg1, arg2)
end

local function NumberisFinite(arg1): boolean -- Luacid: Inlined by compiler; 4 call sites recovered
    return typeof(arg1) == "number" and arg1 ~= math.huge and arg1 == arg1
end

local scriptParentParentParent = script.Parent.Parent.Parent
local LuauPolyfill = require(scriptParentParentParent.LuauPolyfill)
local Array = LuauPolyfill.Array

local Number = LuauPolyfill.Number
local Object = LuauPolyfill.Object

local _ast = require(script.Parent.Parent.language.ast)

local inspect = require(script.Parent.Parent.jsutils.inspect).inspect
local isObjectLike = require(script.Parent.Parent.jsutils.isObjectLike).isObjectLike
local Kind = require(script.Parent.Parent.language.kinds).Kind
local print = require(script.Parent.Parent.language.printer).print
local GraphQLError = require(script.Parent.Parent.error.GraphQLError).GraphQLError

local GraphQLScalarType = require(script.Parent.definition).GraphQLScalarType

local serializeObject = nil

function serializeInt(arg1): number
    local var1 = serializeObject(arg1)

    if typeof(var1) == "boolean" then
        return if var1 then 1 else 0
    end

    local var2 = if typeof(var1) == "string" and var1 ~= "" then tonumber(var1) else var1

    if typeof(var2) ~= "number" or not Number.isInteger(var2) then
        error(GraphQLError.new(("Int cannot represent non-integer value: %s"):format(inspect(var1))))
    end

    if var2 > 2147483647 or var2 < -2147483648 then
        error(GraphQLError.new("Int cannot represent non 32-bit signed integer value: " .. inspect(var1)))
    end

    return var2
end

function coerceInt(arg1)
    if typeof(arg1) ~= "number" or not Number.isInteger(arg1) then
        error(GraphQLError.new(("Int cannot represent non-integer value: %s"):format(inspect(arg1))))
    end

    if arg1 > 2147483647 or arg1 < -2147483648 then
        error(GraphQLError.new(("Int cannot represent non 32-bit signed integer value: %s"):format(arg1)))
    end

    return arg1
end

local graphQlScalarType = GraphQLScalarType.new({
    name = "Int",
    description = "The `Int` scalar type represents non-fractional signed whole numeric values. Int can represent values between -(2^31) and 2^31 - 1.",
    serialize = serializeInt,
    parseValue = coerceInt,
    parseLiteral = function(arg1)
        if arg1.kind ~= Kind.INT then
            error(GraphQLError.new(("Int cannot represent non-integer value: %s"):format(print(arg1)), arg1))
        end

        local var1 = parseInt(arg1.value, 10)

        if var1 > 2147483647 or var1 < -2147483648 then
            error(GraphQLError.new(("Int cannot represent non 32-bit signed integer value: %s"):format(arg1.value), arg1))
        end

        return var1
    end
})

local function serializeFloat(arg1): number
    local var1 = serializeObject(arg1)

    if typeof(var1) == "boolean" then
        return if var1 then 1 else 0
    end

    local var2 = if typeof(var1) == "string" and var1 ~= "" then tonumber(var1) else var1

    if typeof(var2) ~= "number" or not NumberisFinite(var2) then
        error(GraphQLError.new(("Float cannot represent non numeric value: %s"):format(inspect(var1))))
    end

    return var2
end

function coerceFloat(arg1)
    if typeof(arg1) ~= "number" or not NumberisFinite(arg1) then
        error(GraphQLError.new(("Float cannot represent non numeric value: %s"):format(inspect(arg1))))
    end

    return arg1
end

local graphQlScalarType2 = GraphQLScalarType.new({
    name = "Float",
    description = "The `Float` scalar type represents signed double-precision fractional values as specified by [IEEE 754](https://en.wikipedia.org/wiki/IEEE_floating_point).",
    serialize = serializeFloat,
    parseValue = coerceFloat,
    parseLiteral = function(arg1): number?
        if arg1.kind ~= Kind.FLOAT and arg1.kind ~= Kind.INT then
            error(GraphQLError.new(("Float cannot represent non numeric value: %s"):format(print(arg1)), arg1))
        end

        return (parseInt(arg1.value, nil))
    end
})

serializeObject = function(arg1)
    if isObjectLike(arg1) then
        if typeof(arg1.valueOf) == "function" then
            local var1 = arg1:valueOf()

            if not isObjectLike(var1) then
                return var1
            end
        end
        if typeof(arg1.toJSON) == "function" then
            return arg1:toJSON()
        end
    end

    return arg1
end

local function serializeString(arg1): string
    local var1 = serializeObject(arg1)

    if typeof(var1) == "string" then
        return var1
    end
    if typeof(var1) == "boolean" then
        return if var1 then "true" else "false"
    end

    if typeof(var1) == "number" and NumberisFinite(var1) then
        return tostring(var1)
    end

    error(GraphQLError.new(("String cannot represent value: %s"):format(inspect(arg1))))
end

function coerceString(arg1)
    if typeof(arg1) ~= "string" then
        error(GraphQLError.new(("String cannot represent a non string value: %s"):format(inspect(arg1))))
    end

    return arg1
end

local graphQlScalarType3 = GraphQLScalarType.new({
    name = "String",
    description = "The `String` scalar type represents textual data, represented as UTF-8 character sequences. The String type is most often used by GraphQL to represent free-form human-readable text.",
    serialize = serializeString,
    parseValue = coerceString,
    parseLiteral = function(arg1)
        if arg1.kind ~= Kind.STRING then
            error(GraphQLError.new(("String cannot represent a non string value: %s"):format(print(arg1)), arg1))
        end

        return arg1.value
    end
})

local function serializeBoolean(arg1): boolean
    local var1 = serializeObject(arg1)

    if typeof(var1) == "boolean" then
        return var1
    end

    if NumberisFinite(var1) then
        return var1 ~= 0
    end

    error(GraphQLError.new(("Boolean cannot represent a non boolean value: %s"):format(inspect(var1))))
end

function coerceBoolean(arg1)
    if typeof(arg1) ~= "boolean" then
        error(GraphQLError.new(("Boolean cannot represent a non boolean value: %s"):format(inspect(arg1))))
    end

    return arg1
end

local graphQlScalarType4 = GraphQLScalarType.new({
    name = "Boolean",
    description = "The `Boolean` scalar type represents `true` or `false`.",
    serialize = serializeBoolean,
    parseValue = coerceBoolean,
    parseLiteral = function(arg1)
        if arg1.kind ~= Kind.BOOLEAN then
            error(GraphQLError.new(("Boolean cannot represent a non boolean value: %s"):format(print(arg1)), arg1))
        end

        return arg1.value
    end
})

local function serializeID(arg1): string
    local var1 = serializeObject(arg1)

    if typeof(var1) == "string" then
        return var1
    end
    if Number.isInteger(var1) then
        return tostring(var1)
    end

    error(GraphQLError.new(("ID cannot represent value: %s"):format(inspect(arg1))))
end

function coerceID(arg1): string
    if typeof(arg1) == "string" then
        return arg1
    end
    if typeof(arg1) == "number" and Number.isInteger(arg1) then
        return tostring(arg1)
    end

    error(GraphQLError.new(("ID cannot represent value: %s"):format(inspect(arg1))))
end

local graphQlScalarType5 = GraphQLScalarType.new({
    name = "ID",
    description = "The `ID` scalar type represents a unique identifier, often used to refetch an object or as key for a cache. The ID type appears in a JSON response as a String; however, it is not intended to be human-readable. When expected as an input type, any string (such as `\"4\"`) or integer (such as `4`) input value will be accepted as an ID.",
    serialize = serializeID,
    parseValue = coerceID,
    parseLiteral = function(arg1)
        if arg1.kind ~= Kind.STRING and arg1.kind ~= Kind.INT then
            error(GraphQLError.new("ID cannot represent a non-string and non-integer value: " .. print(arg1), arg1))
        end

        return arg1.value
    end
})
local specifiedScalarTypes = Object.freeze({ graphQlScalarType3, graphQlScalarType, graphQlScalarType2, graphQlScalarType4, graphQlScalarType5 })

return {
    GraphQLInt = graphQlScalarType,
    GraphQLFloat = graphQlScalarType2,
    GraphQLString = graphQlScalarType3,
    GraphQLBoolean = graphQlScalarType4,
    GraphQLID = graphQlScalarType5,
    specifiedScalarTypes = specifiedScalarTypes,
    isSpecifiedScalarType = function(arg1)
        return Array.some(specifiedScalarTypes, function(arg2): boolean
            local name = arg2.name
            return arg1.name == name
        end)
    end
}
