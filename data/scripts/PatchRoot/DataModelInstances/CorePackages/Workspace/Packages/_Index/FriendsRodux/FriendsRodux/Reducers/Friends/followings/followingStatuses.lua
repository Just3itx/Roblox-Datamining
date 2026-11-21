-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T17:01:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FriendsRodux = script:FindFirstAncestor("FriendsRodux")
local FriendsRoduxParent = FriendsRodux.Parent
local _roduxFriendsTypes = require(FriendsRodux.roduxFriendsTypes)

local Rodux = require(FriendsRoduxParent.Rodux)
local Dash = require(FriendsRoduxParent.Dash)

local tbl1 = {}
return function(arg1)
    local friendsNetworking = arg1.friendsNetworking
    local userBlockingNetworking = arg1.userBlockingNetworking

    local createReducer = Rodux.createReducer
    local tbl2 = tbl1
    local tbl3 = {}
    tbl3[friendsNetworking.GetFollowingExists.Succeeded.name] = function(arg2, arg3)
        local tbl4 = {}
        Dash.forEach(arg3.responseBody.followings, function(arg4)
            local tbl5 = tbl4
            local userId = arg4.userId
            tbl5[tostring(userId)] = {
                isFollowed = arg4.isFollowed,
                isFollowing = arg4.isFollowing
            }
        end)
        return Dash.join(arg2, tbl4)
    end

    tbl3[userBlockingNetworking.BlockUserById.Succeeded.name] = function(arg2, arg3)
        local str1 = tostring(arg3.namedIds.users)
        return Dash.join(arg2, { [str1] = { isFollowed = false, isFollowing = false } })
    end

    return createReducer(tbl2, tbl3)
end
