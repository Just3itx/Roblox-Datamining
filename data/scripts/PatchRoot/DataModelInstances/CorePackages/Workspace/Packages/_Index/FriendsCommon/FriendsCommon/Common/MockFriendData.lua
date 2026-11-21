-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T14:41:04Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
return {
    localUserId = "1",
    offlineFriend = {
        __typename = "Friend",
        id = "2",
        hasVerifiedBadge = false,
        targetUserId = "1"
    },
    onlineFriend = {
        __typename = "Friend",
        id = "5",
        targetUserId = "1",
        presence = {
            __typename = "UserPresence",
            id = "5",
            userPresenceType = "Online",
            lastLocation = "Website",
            lastOnline = "time3",
            gameId = "",
            placeId = "",
            rootPlaceId = "",
            universeId = ""
        },
        sortScore = 20.4
    },
    inGameFriend = {
        __typename = "Friend",
        id = "3",
        targetUserId = "1",
        presence = {
            __typename = "UserPresence",
            id = "3",
            userPresenceType = "InGame",
            lastLocation = "location",
            lastOnline = "time",
            gameId = "game-id",
            placeId = "123",
            rootPlaceId = "456",
            universeId = "789"
        },
        sortScore = 30.3
    },
    inStudioFriend = {
        __typename = "Friend",
        id = "4",
        targetUserId = "1",
        presence = {
            __typename = "UserPresence",
            id = "4",
            userPresenceType = "InStudio",
            lastLocation = "Studio",
            lastOnline = "time2",
            gameId = "",
            placeId = "",
            rootPlaceId = "",
            universeId = ""
        },
        sortScore = 10.5
    },
    inGameFriendNoUniverseId = {
        __typename = "Friend",
        id = "6",
        targetUserId = "1",
        presence = {
            __typename = "UserPresence",
            id = "6",
            userPresenceType = "InGame",
            lastLocation = "",
            lastOnline = "time4",
            gameId = "",
            placeId = "",
            rootPlaceId = "",
            universeId = ""
        },
        sortScore = 20.3
    },
    inGameFriendLowerSortScore = {
        __typename = "Friend",
        id = "7",
        targetUserId = "1",
        presence = {
            __typename = "UserPresence",
            id = "3",
            userPresenceType = "InGame",
            lastLocation = "location",
            lastOnline = "time",
            gameId = "game-id",
            placeId = "123",
            rootPlaceId = "456",
            universeId = "789"
        },
        sortScore = 30.1
    },
    convertGraphQlOnlineFriendsToPresenceApiFormat = function(arg1)
        local tbl1 = {}
        local tbl2 = ({})
        for _, value in arg1 do
            local id = value.id
            local presence = value.presence

            table.insert(tbl1, {
                userId = id,
                userPresenceType = presence.userPresenceType,
                lastLocation = presence.lastLocation,
                lastOnline = presence.lastOnline,
                gameId = presence.gameId,
                placeId = presence.placeId,
                rootPlaceId = presence.rootPlaceId,
                universeId = presence.universeId
            })
            tbl2[id] = value.sortScore
        end

        return tbl1, tbl2
    end,
    convertGraphQlOnlineFriendsToExectedSignalFormat = function(arg1)
        local result = {}
        for _, value in arg1 do
            local id = value.id
            local presence = value.presence

            table.insert(result, {
                id = id,
                sortScore = value.sortScore,
                presence = {
                    id = id,
                    userPresenceType = presence.userPresenceType,
                    lastLocation = presence.lastLocation,
                    lastOnline = presence.lastOnline,
                    gameId = presence.gameId,
                    placeId = presence.placeId,
                    rootPlaceId = presence.rootPlaceId,
                    universeId = presence.universeId
                }
            })
        end

        return result
    end
}
