-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T13:31:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PYMKCarousel = script:FindFirstAncestor("PYMKCarousel")
local dependencies = require(PYMKCarousel.dependencies)

local RoduxFriends = dependencies.RoduxFriends
local convertActions = dependencies.convertActions
local friendsActionAdaptor = dependencies.friendsActionAdaptor
local llama = dependencies.llama
local friendsOmniActionAdaptor = require(script.Parent.friendsOmniActionAdaptor)
local tbl1 = {
    countsByUserId = {},
    byUserId = {},
    requests = {
        receivedCount = 0,
        newFriendRequestsCount = 0,
        byUserId = {},
        mutualFriends = {},
        sentAt = {},
        sourceUniverseIds = {}
    },
    recommendations = {
        byUserId = {},
        bySource = {}
    },
    friendshipStatus = {},
    friendsRankByUserId = {}
}

local var1 = RoduxFriends.installReducer()

local function func1(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    return llama.Dictionary.join(friendsActionAdaptor(RoduxFriends), friendsOmniActionAdaptor(arg1))
end

return function(arg1)
    return convertActions(var1, func1(arg1), tbl1)
end
