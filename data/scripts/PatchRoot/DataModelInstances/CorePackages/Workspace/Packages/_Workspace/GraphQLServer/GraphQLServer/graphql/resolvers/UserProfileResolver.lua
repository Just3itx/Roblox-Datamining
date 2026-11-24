-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T17:01:31Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GraphQLServer = script:FindFirstAncestor("GraphQLServer")
local GraphQLServerParent = GraphQLServer.Parent
local _LuauPolyfill = require(GraphQLServerParent.LuauPolyfill)
local GraphQLError = require(GraphQLServer.Parent.GraphQL).GraphQLError
local formatUserProfileFields = require(GraphQLServer.graphql.utils.formatUserProfileFields)
local _generatedTypes = require(script.Parent.Parent.generatedTypes)
local FFlagUserProfileBetterErrors = require(GraphQLServer.Flags.FFlagUserProfileBetterErrors)

return {
    UserProfile = {
        id = function(arg1): string
            return tostring(arg1.userId)
        end,
        displayName = function()
            return GraphQLError.new(
                "The displayName field is not available on the UserProfile implementation of User, please use the names field instead"
            )
        end
    },
    Query = {
        userProfiles = function(_, arg1, arg2, arg3)
            local var1 = formatUserProfileFields(arg3, arg2.collectSubFieldsImpl)
            return arg2.dataLoaders.userProfiles:getLoader(arg2.fetchImpl, var1):loadMany(arg1.userIds):andThen(function(arg4)
                return arg4 or {}
            end):catch(function(arg4)
                return if FFlagUserProfileBetterErrors then arg4 else {}
            end)
        end
    }
}
