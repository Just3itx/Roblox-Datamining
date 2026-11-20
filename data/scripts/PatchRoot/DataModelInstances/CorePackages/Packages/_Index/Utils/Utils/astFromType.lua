-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T20:00:43Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local LuauPolyfill = require(scriptParentParent.LuauPolyfill)
local Boolean = LuauPolyfill.Boolean
local Error = LuauPolyfill.Error
local tbl1 = {}
local GraphQL = require(scriptParentParent.GraphQL)
local isNonNullType = GraphQL.isNonNullType
local Kind = GraphQL.Kind

local isListType = GraphQL.isListType

local inspect = require(script.Parent.inspect).inspect

local function astFromType(arg1)
    if Boolean.toJSBoolean(isNonNullType(arg1)) then
        local type = astFromType(arg1.ofType)
        if type.kind == Kind.NON_NULL_TYPE then
            error(
                Error.new(
                    ("Invalid type node %s. Inner type of non-null type cannot be a non-null type."):format(tostring(inspect(arg1)))
                )
            )
        end

        return {
            kind = Kind.NON_NULL_TYPE,
            type = type
        }
    end

    if Boolean.toJSBoolean(isListType(arg1)) then
        return {
            kind = Kind.LIST_TYPE,
            type = astFromType(arg1.ofType)
        }
    end

    return {
        kind = Kind.NAMED_TYPE,
        name = {
            kind = Kind.NAME,
            value = arg1.name
        }
    }
end

tbl1.astFromType = astFromType
return tbl1
