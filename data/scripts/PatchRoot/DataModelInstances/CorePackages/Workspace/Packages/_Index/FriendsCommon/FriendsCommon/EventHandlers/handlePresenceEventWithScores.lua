-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T14:41:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FriendsCommonParent = script:FindFirstAncestor("FriendsCommon").Parent

local queries = require(FriendsCommonParent.ApolloLocalState).queries

local ApolloFriends = require(FriendsCommonParent.ApolloFriends)
local ApolloPresence = require(FriendsCommonParent.ApolloPresence)

local _GraphQLServer = require(FriendsCommonParent.GraphQLServer)

local SocialLuaAnalytics = require(FriendsCommonParent.SocialLuaAnalytics)
local LoggingProtocol = require(FriendsCommonParent.LoggingProtocol)

local function rtnPresenceToGraphQLPresence(tbl1)
    local tbl2 = {
        id = tostring(tbl1.userId),
        userPresenceType = ApolloPresence.Formatters.formatNumberToPresenceType(tbl1.userPresenceType),
        lastLocation = tbl1.lastLocation,
        lastOnline = tbl1.lastOnline or "",
        gameId = tbl1.gameId or "",
        placeId = if tbl1.placeId then tostring(tbl1.placeId) or "" else "",
        rootPlaceId = if tbl1.rootPlaceId then tostring(tbl1.rootPlaceId) or "" else "",
        universeId = tbl1.universeId and tostring(tbl1.universeId) or "",
        __typename = "UserPresence"
    }
    return tbl2
end

local function toUserIdToFriendMap(onlineFriendsByUserId)
    local result = {}
    for _, value in onlineFriendsByUserId do
        result[value.id] = table.clone(value)
    end

    return result
end

local function userIdFriendMapToList(tbl1) -- Luacid: Inlined by compiler; 1 call site recovered
    local result = {}
    for _, value in tbl1 do
        table.insert(result, value)
    end

    return result
end

local emitter = SocialLuaAnalytics.Telemetry.createEmitter({
    telemetryImpl = LoggingProtocol.default,
    defaultTelemetryConfig = {
        throttlingThousandths = game:DefineFastInt("FriendsCommonAnalyticsThrottlingThousandths", 10000),
        links = "https://docs.google.com/document/d/1uRCdl8pEuiW9wDiOTL39JPMGLhgxtpvVgiXovE8Xof4"
    },
    getSharedInfo = function()
        return {}
    end
})

local telemetry = SocialLuaAnalytics.Telemetry.new({
    name = "FriendsSortFeRtnMessage",
    description = "User received an rtn message v2",
    lastUpdated = { 2026, 3, 18 },
    backendsList = {{
        type = "EventIngest",
        format = function<T>(tbl1, _): T
            return tbl1
        end
    }}
})

local function handlePresenceEventWithScores(tbl1)
    local variables = {
        userId = tbl1.localUserId,
        sort = ApolloFriends.Enums.Sort.FriendshipScore
    }

    local var1 = tbl1.apolloClient:readQuery({ query = queries.onlineFriendsByUserId, variables = variables })

    local tbl3 = not (var1 and var1.onlineFriendsByUserId) and {} or toUserIdToFriendMap(var1.onlineFriendsByUserId)

    local tbl4 = {}
    for _, value in pairs(tbl1.updatedPresences) do
        local str1 = tostring(value.userId)
        local sortScore = tbl1.updatedSortScores[str1]

        table.insert(tbl4, str1)

        if value.userPresenceType == 0 then
            tbl3[str1] = nil
        elseif tbl3[str1] ~= nil then
            local var3 = tbl3[str1]
            var3.presence = rtnPresenceToGraphQLPresence(value)
            var3.sortScore = sortScore
        else
            tbl3[str1] = {
                __typename = "Friend",
                id = tostring(value.userId),
                targetUserId = tbl1.localUserId,
                presence = rtnPresenceToGraphQLPresence(value),
                sortScore = sortScore
            }
        end
    end

    local onlineFriendsByUserId = userIdFriendMapToList(tbl3)
    tbl1.apolloClient:writeQuery({
        query = queries.onlineFriendsByUserId,
        variables = variables,
        data = { onlineFriendsByUserId = onlineFriendsByUserId }
    })

    if tbl1.rtnMessageId == nil then
        return
    end

    local tbl6 = {
        messageId = tbl1.rtnMessageId,
        userId = tonumber(tbl1.localUserId),
        friendIds = table.concat(tbl4, ","),
        sortType = "Carousel"
    }

    emitter.emit(telemetry, tbl6)
end

return handlePresenceEventWithScores
