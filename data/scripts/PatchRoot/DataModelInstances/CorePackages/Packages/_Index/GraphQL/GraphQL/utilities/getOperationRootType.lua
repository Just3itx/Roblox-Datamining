-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T08:10:50Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GraphQLError = require(script.Parent.Parent.error.GraphQLError).GraphQLError

local _ast = require(script.Parent.Parent.language.ast)

local _definition = require(script.Parent.Parent.type.definition)

local _schema = require(script.Parent.Parent.type.schema)

return {
    getOperationRootType = function(arg1, arg2)
        if arg2.operation == "query" then
            local queryType = arg1:getQueryType()
            if not queryType then
                error(GraphQLError.new("Schema does not define the required query root type.", arg2))
            end

            return queryType
        elseif arg2.operation == "mutation" then
            local mutationType = arg1:getMutationType()
            if not mutationType then
                error(GraphQLError.new("Schema is not configured for mutations.", arg2))
            end

            return mutationType
        end

        if arg2.operation ~= "subscription" then
            error(GraphQLError.new("Can only have query, mutation and subscription operations.", arg2))
            return
        end

        local subscriptionType = arg1:getSubscriptionType()
        if not subscriptionType then
            error(GraphQLError.new("Schema is not configured for subscriptions.", arg2))
        end

        return subscriptionType
    end
}
