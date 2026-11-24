-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T17:01:19Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GraphQLServer = script:FindFirstAncestor("GraphQLServer")
local GraphQLServerParent = GraphQLServer.Parent
local GraphQLError = require(GraphQLServer.Parent.GraphQL).GraphQLError
local _generatedTypes = require(GraphQLServer.graphql.generatedTypes)

local _LuauPolyfill = require(GraphQLServerParent.LuauPolyfill)

local FriendsConnector = require(GraphQLServer.graphql.connectors.FriendsConnector)
local getAllFriendsByUserId = FriendsConnector.getAllFriendsByUserId
local getOnlineFriendsByUserId = FriendsConnector.getOnlineFriendsByUserId

local function convertToStringWithDefault(arg1): string -- Luacid: Inlined by compiler; 4 call sites recovered
    if arg1 then
        return tostring(arg1)
    end

    return ""
end

return {
    UserPresence = {
        id = function(arg1)
            return arg1.id
        end,
        userPresenceType = function(arg1)
            return arg1.userPresence.UserPresenceType
        end,
        gameId = function(arg1): string
            return convertToStringWithDefault(arg1.userPresence.gameInstanceId)
        end,
        placeId = function(arg1): string
            return convertToStringWithDefault(arg1.userPresence.placeId)
        end,
        rootPlaceId = function(arg1): string
            return convertToStringWithDefault(arg1.userPresence.rootPlaceId)
        end,
        universeId = function(arg1): string
            return convertToStringWithDefault(arg1.userPresence.universeId)
        end,
        lastLocation = function(arg1)
            return arg1.userPresence.lastLocation
        end,
        lastOnline = function(arg1)
            return arg1.userPresence.lastOnline
        end
    },
    Friend = {
        targetUserId = function(_, _, _, arg1)
            return arg1.variableValues.userId
        end,
        displayName = function()
            return GraphQLError.new("The displayName field is being deprecated, please use UserProfile to retrieve names")
        end,
        presence = function<T>(arg1: T): T
            return arg1
        end,
        hasVerifiedBadge = function(_): boolean
            return false
        end,
        sortScore = function(arg1)
            return arg1.sortScore or 0
        end
    },
    AllFriendsPage = {
        targetUserId = function(_, _, _, arg1)
            return arg1.variableValues.userId
        end,
        curCursor = function(_, _, _, arg1)
            return arg1.variableValues.pageCursor or ""
        end,
        nextCursor = function(arg1)
            return arg1.NextCursor or ""
        end,
        prevCursor = function(arg1)
            return arg1.PreviousCursor or ""
        end,
        friends = function(arg1)
            return arg1.PageItems or {}
        end
    },
    Query = {
        allFriendsByUserId = function(_, arg1, arg2)
            return getAllFriendsByUserId(arg1, arg2.fetchImpl)
        end,
        onlineFriendsByUserId = function(_, arg1, arg2)
            return getOnlineFriendsByUserId(arg1, arg2.fetchImpl)
        end
    }
}
