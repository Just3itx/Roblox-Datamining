-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T08:20:50Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local GraphQLError = require(scriptParentParentParent.error.GraphQLError).GraphQLError

local module = {}

function module.UniqueOperationTypesRule(arg1)
    local schema = arg1:getSchema()
    local tbl1 = ({})
    local var1 = schema
        and {
            query = schema:getQueryType(),
            mutation = schema:getMutationType(),
            subscription = schema:getSubscriptionType()
        }
        or {}

    local function checkOperationTypes(_, arg2): boolean
        local operationTypes = arg2.operationTypes or {}

        for _, value in ipairs(operationTypes) do
            local operation = value.operation
            local var2 = tbl1[operation]

            if var1[operation] then
                arg1:reportError(
                    GraphQLError.new(("Type for %s already defined in the schema. It cannot be redefined."):format(operation), value)
                )
            elseif var2 then
                arg1:reportError(GraphQLError.new(("There can be only one %s type in schema."):format(operation), { var2, value }))
            else
                tbl1[operation] = value
            end
        end

        return false
    end

    return { SchemaDefinition = checkOperationTypes, SchemaExtension = checkOperationTypes }
end

return module
