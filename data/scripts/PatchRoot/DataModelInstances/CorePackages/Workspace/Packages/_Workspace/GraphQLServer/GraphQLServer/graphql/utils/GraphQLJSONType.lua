-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T17:01:38Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GraphQLServerParent = script:FindFirstAncestor("GraphQLServer").Parent
local LuauPolyfill = require(GraphQLServerParent.LuauPolyfill)
local Array = LuauPolyfill.Array
local Boolean = LuauPolyfill.Boolean
local Error = LuauPolyfill.Error
local tbl1 = {}
local GraphQL = require(GraphQLServerParent.GraphQL)
local GraphQLScalarType = GraphQL.GraphQLScalarType

local Kind = GraphQL.Kind
local print = GraphQL.print

local parseLiteral = nil

local function parseFloat(arg1, arg2): number? -- Luacid: Inlined by compiler; 1 call site recovered
    return tonumber(arg1, arg2)
end

local function identity<T>(arg1: T): T
    return arg1
end

local function ensureObject(arg1)
    if Boolean.toJSBoolean(typeof(arg1) ~= "table" or arg1 == nil or Array.isArray(arg1)) then
        error(Error.new(("JSONObject cannot represent non-object value: %s"):format(tostring(arg1))))
    end
    return arg1
end

local function parseObject(arg1, arg2, arg3) -- Luacid: Inlined by compiler; 2 call sites recovered
    local result = {}
    Array.forEach(arg2.fields, function(arg4)
        result[arg4.name.value] = parseLiteral(arg1, arg4.value, arg3)
    end)
    return result
end

parseLiteral = function(arg1, arg2, arg3)
    local kind = arg2.kind
    if kind == Kind.STRING or kind == Kind.BOOLEAN then
        return arg2.value
    end

    if kind == Kind.INT or kind == Kind.FLOAT then
        return (parseFloat(arg2.value, nil))
    end

    if kind == Kind.OBJECT then
        return parseObject(arg1, arg2, arg3)
    end
    if kind == Kind.LIST then
        return Array.map(arg2.values, function(arg4)
            return parseLiteral(arg1, arg4, arg3)
        end)
    end

    if kind == Kind.NULL then
        return nil
    end

    if kind == Kind.VARIABLE then
        if Boolean.toJSBoolean(arg3) then
            return arg3[arg2.name.value]
        end

        return nil
    end

    error(Error.new(("%s cannot represent value: %s"):format(arg1, print(arg2))))
    return nil
end

local graphQlScalarType = GraphQLScalarType.new({
    name = "JSON",
    description = "The `JSON` scalar type represents JSON values as specified by [ECMA-404](http://www.ecma-international.org/publications/files/ECMA-ST/ECMA-404.pdf).",
    specifiedByUrl = "http://www.ecma-international.org/publications/files/ECMA-ST/ECMA-404.pdf",
    serialize = identity,
    parseValue = identity,
    parseLiteral = function(arg1, arg2)
        return parseLiteral("JSON", arg1, arg2)
    end
})
tbl1.GraphQLJSON = graphQlScalarType
tbl1.default = graphQlScalarType

tbl1.GraphQLJSONObject = GraphQLScalarType.new({
    name = "JSONObject",
    description = "The `JSONObject` scalar type represents JSON objects as specified by [ECMA-404](http://www.ecma-international.org/publications/files/ECMA-ST/ECMA-404.pdf).",
    specifiedByUrl = "http://www.ecma-international.org/publications/files/ECMA-ST/ECMA-404.pdf",
    serialize = ensureObject,
    parseValue = ensureObject,
    parseLiteral = function(arg1, arg2)
        if arg1.kind ~= Kind.OBJECT then
            error(Error.new(("JSONObject cannot represent non-object value: %s"):format(print(arg1))))
        end

        return parseObject("JSONObject", arg1, arg2)
    end
})

return tbl1
