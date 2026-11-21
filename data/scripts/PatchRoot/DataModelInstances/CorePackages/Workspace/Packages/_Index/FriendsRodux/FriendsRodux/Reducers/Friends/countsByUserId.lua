-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T17:01:01Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FriendsRodux = script:FindFirstAncestor("FriendsRodux")
local FriendsRoduxParent = FriendsRodux.Parent
local Rodux = require(FriendsRoduxParent.Rodux)
local Cryo = require(FriendsRoduxParent.Cryo)
local _roduxFriendsTypes = require(FriendsRodux.roduxFriendsTypes)
local tbl1 = {}

return function(arg1)
    local friendsNetworking = arg1.friendsNetworking

    local createReducer = Rodux.createReducer
    local tbl2 = tbl1
    local tbl3 = {}
    tbl3[friendsNetworking.GetFriendsCountFromUserId.Succeeded.name] = function(arg2, arg3)
        local str1 = tostring(arg3.namedIds.users)
        return Cryo.Dictionary.union(arg2, { [str1] = arg3.responseBody.count })
    end

    return createReducer(tbl2, tbl3)
end
