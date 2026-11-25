-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T20:21:16Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UserLib = script:FindFirstAncestor("UserLib")
local UserLibParent = UserLib.Parent

local getFriendsActiveGamesPlaceIdsFromUsersPresence = require(UserLib.Utils.getFriendsActiveGamesPlaceIdsFromUsersPresence)
local receiveUsersPresence = require(UserLib.Utils.receiveUsersPresence)

local ApiFetchGamesDataByPlaceIds = require(UserLibParent.GameDetailRodux).GamesByPlaceId.ApiFetchGamesDataByPlaceIds

local UsersGetPresence = require(UserLib.Requests.UsersGetPresence)

return function(arg1, arg2)
    return function(arg3)
        return UsersGetPresence(arg1, arg2):andThen(function(arg4)
            local userPresences = arg4.responseBody.userPresences
            receiveUsersPresence(userPresences, arg3)

            local friendsActiveGamesPlaceIdsFromUsersPresence = getFriendsActiveGamesPlaceIdsFromUsersPresence(userPresences, arg3)
            arg3:dispatch(ApiFetchGamesDataByPlaceIds(arg1, friendsActiveGamesPlaceIdsFromUsersPresence))
        end)
    end
end
