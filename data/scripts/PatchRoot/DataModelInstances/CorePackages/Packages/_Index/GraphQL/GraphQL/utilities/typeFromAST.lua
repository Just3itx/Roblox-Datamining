-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T08:10:59Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local inspect = require(scriptParentParent.jsutils.inspect).inspect
local invariant = require(scriptParentParent.jsutils.invariant).invariant
local language = scriptParentParent.language
local _ast = require(language.ast)

local Kind = require(scriptParentParent.language.kinds).Kind
local definition = require(scriptParentParent.type.definition)
local GraphQLList = definition.GraphQLList
local GraphQLNonNull = definition.GraphQLNonNull

local type = scriptParentParent.type
local _schema = require(type.schema)

local function typeFromAST(arg1, arg2)
    if arg2.kind == Kind.LIST_TYPE then
        local var1 = typeFromAST(arg1, arg2.type)
        return var1 and GraphQLList.new(var1)
    end
    if arg2.kind == Kind.NON_NULL_TYPE then
        local var1 = typeFromAST(arg1, arg2.type)
        return var1 and GraphQLNonNull.new(var1)
    end

    if arg2.kind == Kind.NAMED_TYPE then
        return arg1:getType(arg2.name.value)
    end

    invariant(false, "Unexpected type node: " .. inspect(arg2))
    return nil
end

return { typeFromAST = typeFromAST }
