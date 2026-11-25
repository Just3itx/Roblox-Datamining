-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T20:21:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UserLib = script:FindFirstAncestor("UserLib")
local UserLibParent = UserLib.Parent

local Immutable = require(UserLibParent.AppCommonLib).Immutable

local AddUser = require(UserLib.Actions).AddUser
local AddUsers = require(UserLib.Actions).AddUsers
local ReceivedUserPresence = require(UserLib.Actions).ReceivedUserPresence
local RemoveUser = require(UserLib.Actions).RemoveUser
local SetUserIsFriend = require(UserLib.Actions).SetUserIsFriend
local SetUserMembershipType = require(UserLib.Actions).SetUserMembershipType
local SetUserHasRobloxSubscription = require(UserLib.Actions).SetUserHasRobloxSubscription
local SetUserPresence = require(UserLib.Actions).SetUserPresence
local ReceivedDisplayName = require(UserLib.Actions).ReceivedDisplayName

local FFlagEnableBlackbirdCheck = require(UserLibParent.SharedFlags).FFlagEnableBlackbirdCheck

return function(arg1, arg2)
    arg1 = arg1 or {}
    assert(arg1, "")

    if arg2.type == AddUser.name then
        local user = arg2.user
        return (Immutable.Set(arg1, user.id, user))
    elseif arg2.type == AddUsers.name then
        local users = arg2.users
        local tbl1 = ({})
        for k, user in pairs(users) do
            local var1 = arg1[k]
            if var1 then
                tbl1[k] = Immutable.JoinDictionaries(var1, user)
            else
                tbl1[k] = user
            end
        end

        return (Immutable.JoinDictionaries(arg1, tbl1))
    elseif arg2.type == SetUserIsFriend.name then
        local var1 = arg1[arg2.userId]
        if var1 then
            local var2 = Immutable.Set(var1, "isFriend", arg2.isFriend)
            return (Immutable.Set(arg1, var1.id, var2))
        end
        warn("Setting isFriend on user", arg2.userId, "who doesn't exist yet")
        return arg1
    elseif arg2.type == SetUserPresence.name then
        local var1 = arg1[arg2.userId]
        if var1 then
            local var2 = Immutable.JoinDictionaries(var1, { presence = arg2.presence, lastLocation = arg2.lastLocation })

            return (Immutable.Set(arg1, var1.id, var2))
        end
        warn("Setting presence on user", arg2.userId, "who doesn't exist yet")
        return arg1
    else
        if arg2.type == ReceivedUserPresence.name then
            local var1 = arg1[arg2.userId]
            if var1 then
                return (Immutable.JoinDictionaries(arg1, {
                    [arg2.userId] = Immutable.JoinDictionaries(var1, {
                        presence = arg2.presence,
                        lastLocation = arg2.lastLocation,
                        placeId = arg2.placeId,
                        rootPlaceId = arg2.rootPlaceId,
                        gameInstanceId = arg2.gameInstanceId,
                        lastOnline = arg2.lastOnline,
                        universeId = arg2.universeId
                    })
                }))
            end
        elseif arg2.type == SetUserMembershipType.name then
            local var1 = arg1[arg2.userId]
            if var1 then
                return (Immutable.JoinDictionaries(
                    arg1,
                    {
                        [arg2.userId] = Immutable.JoinDictionaries(var1, { membership = arg2.membershipType })
                    }
                ))
            end
        elseif FFlagEnableBlackbirdCheck and arg2.type == SetUserHasRobloxSubscription.name then
            local var1 = arg1[arg2.userId]
            if var1 then
                return (Immutable.JoinDictionaries(
                    arg1,
                    {
                        [arg2.userId] = Immutable.JoinDictionaries(var1, { hasRobloxSubscription = arg2.hasRobloxSubscription })
                    }
                ))
            end
        elseif arg2.type == RemoveUser.name then
            if arg1[arg2.userId] then
                return (Immutable.RemoveFromDictionary(arg1, arg2.userId))
            end
        elseif arg2.type == ReceivedDisplayName.name then
            local var1 = arg1[arg2.userId]
            if var1 then
                arg1 = Immutable.JoinDictionaries(
                    arg1,
                    {
                        [arg2.userId] = Immutable.JoinDictionaries(var1, { displayName = arg2.displayName })
                    }
                )
            end
        end
        return arg1
    end
end
