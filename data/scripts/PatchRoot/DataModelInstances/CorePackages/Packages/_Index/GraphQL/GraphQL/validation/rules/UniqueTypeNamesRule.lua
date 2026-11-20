-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T08:20:52Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local GraphQLError = require(scriptParentParentParent.error.GraphQLError).GraphQLError

local module = {}

function module.UniqueTypeNamesRule(arg1)
    local tbl1 = ({})
    local schema = arg1:getSchema()

    local function checkTypeName(_, arg2)
        local value = arg2.name.value

        if schema and schema:getType(value) then
            arg1:reportError(
                GraphQLError.new(
                    ("Type \"%s\" already exists in the schema. It cannot also be defined in this type definition."):format(value),
                    arg2.name
                )
            )
            return
        end

        if tbl1[value] then
            arg1:reportError(
                GraphQLError.new(("There can be only one type named \"%s\"."):format(value), { tbl1[value], arg2.name })
            )
        else
            tbl1[value] = arg2.name
        end

        return false
    end

    return {
        ScalarTypeDefinition = checkTypeName,
        ObjectTypeDefinition = checkTypeName,
        InterfaceTypeDefinition = checkTypeName,
        UnionTypeDefinition = checkTypeName,
        EnumTypeDefinition = checkTypeName,
        InputObjectTypeDefinition = checkTypeName
    }
end

return module
