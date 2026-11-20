-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T08:11:19Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent

local GraphQLError = require(scriptParentParentParent.error.GraphQLError).GraphQLError

local isNillish = require(scriptParentParentParent.luaUtils.isNillish)
local isNillish2 = isNillish.isNillish
local isNotNillish = isNillish.isNotNillish

local module = {}

function module.LoneSchemaDefinitionRule(arg1)
    local schema = arg1:getSchema()
    local var1 = nil
    if schema then
        var1 = schema.astNode
        if isNillish2(var1) then
            var1 = schema:getQueryType()
        end
        if isNillish2(var1) then
            var1 = schema:getMutationType()
        end
        if isNillish2(var1) then
            var1 = schema:getSubscriptionType()
        end
    end

    local num1 = 0
    return {
        SchemaDefinition = function(_, arg2)
            if isNotNillish(var1) then
                arg1:reportError(GraphQLError.new("Cannot define a new schema within a schema extension.", arg2))

                return
            end

            if num1 > 0 then
                arg1:reportError(GraphQLError.new("Must provide only one schema definition.", arg2))
            end

            num1 += 1
        end
    }
end

return module
