-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T20:10:46Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local _LuauPolyfill = require(scriptParentParent.LuauPolyfill)

local module = {}
local GraphQL = require(scriptParentParent.GraphQL)
local GraphQLObjectType = GraphQL.GraphQLObjectType

local GraphQLInterfaceType = GraphQL.GraphQLInterfaceType

local GraphQLInputObjectType = GraphQL.GraphQLInputObjectType

local GraphQLString = GraphQL.GraphQLString

local GraphQLInt = GraphQL.GraphQLInt
local GraphQLFloat = GraphQL.GraphQLFloat
local GraphQLBoolean = GraphQL.GraphQLBoolean
local GraphQLID = GraphQL.GraphQLID

local Kind = GraphQL.Kind

local GraphQLList = GraphQL.GraphQLList
local GraphQLNonNull = GraphQL.GraphQLNonNull

local function createNamedStub(name: string, arg1)
    return (if arg1 == "object" then GraphQLObjectType elseif arg1 == "interface" then GraphQLInterfaceType else GraphQLInputObjectType).new(
        {
            name = name,
            fields = {
                _fake = { type = GraphQLString }
            }
        }
    )
end

module.createNamedStub = createNamedStub

local function createStub(arg1, arg2)
    local kind = arg1.kind
    if kind == Kind.LIST_TYPE then
        return GraphQLList.new(createStub(arg1.type, arg2))
    elseif kind == Kind.NON_NULL_TYPE then
        return GraphQLNonNull.new(createStub(arg1.type, arg2))
    elseif arg2 == "output" then
        return createNamedStub(arg1.name.value, "object")
    end

    return createNamedStub(arg1.name.value, "input")
end

module.createStub = createStub

function module.isNamedStub(arg1)
    if arg1.getFields ~= nil then
        local fields = arg1:getFields()

        for _, field in fields do
            return fields[tostring((table.unpack(field)))].name == "_fake"
        end
    end
    return false
end

function module.getBuiltInForStub(arg1)
    local name = arg1.name

    if name == GraphQLInt.name then
        return GraphQLInt
    end

    if name == GraphQLFloat.name then
        return GraphQLFloat
    end

    if name == GraphQLString.name then
        return GraphQLString
    end

    if name == GraphQLBoolean.name then
        return GraphQLBoolean
    end

    if name == GraphQLID.name then
        return GraphQLID
    end

    return arg1
end

return module
