-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T08:20:42Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local GraphQLError = require(scriptParentParentParent.error.GraphQLError).GraphQLError

local module = {}

function module.UniqueDirectiveNamesRule(arg1)
    local tbl1 = ({})
    local schema = arg1:getSchema()

    return {
        DirectiveDefinition = function(_, arg2)
            local value = arg2.name.value

            if schema and schema:getDirective(value) then
                arg1:reportError(
                    GraphQLError.new(("Directive \"@%s\" already exists in the schema. It cannot be redefined."):format(value), arg2.name)
                )
                return
            end

            if tbl1[value] then
                arg1:reportError(
                    GraphQLError.new(("There can be only one directive named \"@%s\"."):format(value), { tbl1[value], arg2.name })
                )
            else
                tbl1[value] = arg2.name
            end

            return false
        end
    }
end

return module
