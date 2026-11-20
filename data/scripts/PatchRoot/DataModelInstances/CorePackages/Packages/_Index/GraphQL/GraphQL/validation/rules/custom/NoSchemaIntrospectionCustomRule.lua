-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T08:11:08Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParentParent = script.Parent.Parent.Parent.Parent
local GraphQLError = require(scriptParentParentParentParent.error.GraphQLError).GraphQLError
local getNamedType = require(scriptParentParentParentParent.type.definition).getNamedType
local isIntrospectionType = require(scriptParentParentParentParent.type.introspection).isIntrospectionType

local module = {}

function module.NoSchemaIntrospectionCustomRule(arg1)
    return {
        Field = function(_, arg2)
            local namedType = getNamedType(arg1:getType())
            if namedType and isIntrospectionType(namedType) then
                arg1:reportError(
                    GraphQLError.new(
                        ("GraphQL introspection has been disabled, but the requested query contained the field \"%s\"."):format(arg2.name.value),
                        arg2
                    )
                )
            end
        end
    }
end

return module
