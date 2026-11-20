-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T14:00:57Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local byUserId = require(script.Parent.Friends.byUserId)
local countsByUserId = require(script.Parent.Friends.countsByUserId)
local requests = require(script.Parent.Friends.requests)
local recommendations = require(script.Parent.Friends.recommendations)
local friendshipStatus = require(script.Parent.Friends.friendshipStatus)
local friendsRankByUserId = require(script.Parent.Friends.friendsRankByUserId)
local contactNamesByUserId = require(script.Parent.Friends.contactNamesByUserId)

local tbl1 = {
    countsByUserId = {},
    byUserId = {},
    requests = { receivedCount = 0 },
    recommendations = {},
    friendshipStatus = {},
    friendsRankByUserId = {},
    contactNamesByUserId = {}
}

return function(arg1)
    return function(arg2, arg3)
        local var1 = arg2 or tbl1

        local var2 = byUserId(arg1)
        local var3 = countsByUserId(arg1)
        local var4 = requests(arg1)
        local var5 = recommendations(arg1)
        local var6 = friendshipStatus(arg1)
        local var7 = friendsRankByUserId(arg1)
        local var8 = contactNamesByUserId(arg1)

        return {
            byUserId = var2(var1.byUserId, arg3),
            countsByUserId = var3(arg2, arg3),
            requests = var4(var1.requests, arg3),
            recommendations = var5(var1.recommendations, arg3),
            friendshipStatus = var6(var1.friendshipStatus, arg3),
            friendsRankByUserId = var7(var1.friendsRankByUserId, arg3),
            contactNamesByUserId = var8(var1.contactNamesByUserId, arg3)
        }
    end
end
