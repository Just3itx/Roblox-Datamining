-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T15:41:15Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FriendsLanding = script:FindFirstAncestor("FriendsLanding")
local dependencies = require(FriendsLanding.dependencies)

local Promise = dependencies.Promise
local t = dependencies.t

local FriendsNetworking = dependencies.FriendsNetworking

local var1 = t.strictInterface({
    localUserId = t.string,
    inactiveFriendsNetworkRequestStatus = t.string,
    onResolve = t.union(t.callback, t.table),
    onError = t.union(t.callback, t.table)
})

return function(arg1)
    return {
        refreshPageData = function(arg2)
            assert(var1(arg2))

            local tbl1 = {}
            table.insert(tbl1, arg1(FriendsNetworking.GetFriendRequestsCount.API()))
            return Promise.all(tbl1):andThen(arg2.onResolve):catch(arg2.onError)
        end,
        getFriendRequestsCount = function()
            return arg1(FriendsNetworking.GetFriendRequestsCount.API())
        end
    }
end
