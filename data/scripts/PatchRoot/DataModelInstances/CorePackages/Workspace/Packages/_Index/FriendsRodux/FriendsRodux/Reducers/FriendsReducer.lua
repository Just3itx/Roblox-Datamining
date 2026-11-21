-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T17:10:37Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local byUserId = require(script.Parent.Friends.byUserId)
local countsByUserId = require(script.Parent.Friends.countsByUserId)
local requests = require(script.Parent.Friends.requests)
local recommendations = require(script.Parent.Friends.recommendations)
local followings = require(script.Parent.Friends.followings)
local friendshipStatus = require(script.Parent.Friends.friendshipStatus)
local friendsRankByUserId = require(script.Parent.Friends.friendsRankByUserId)
local contactNamesByUserId = require(script.Parent.Friends.contactNamesByUserId)

local tbl1 = {
    countsByUserId = {},
    byUserId = {},
    requests = { receivedCount = 0, newFriendRequestsCount = 0 },
    recommendations = {},
    followings = {},
    friendshipStatus = {},
    friendsRankByUserId = {},
    contactNamesByUserId = {}
}

return function(arg1)
    local var1 = byUserId(arg1)
    local var2 = countsByUserId(arg1)
    local var3 = requests(arg1)
    local var4 = recommendations(arg1)
    local var5 = followings(arg1)
    local var6 = friendshipStatus(arg1)
    local var7 = friendsRankByUserId(arg1)
    local var8 = contactNamesByUserId(arg1)

    return function(arg2, arg3)
        local var9 = arg2 or tbl1

        return {
            byUserId = var1(var9.byUserId, arg3),
            countsByUserId = var2(var9.countsByUserId, arg3),
            requests = var3(var9.requests, arg3),
            recommendations = var4(var9.recommendations, arg3),
            followings = var5(var9.followings, arg3),
            friendshipStatus = var6(var9.friendshipStatus, arg3),
            friendsRankByUserId = var7(var9.friendsRankByUserId, arg3),
            contactNamesByUserId = var8(var9.contactNamesByUserId, arg3)
        }
    end
end
