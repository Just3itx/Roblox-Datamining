-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T17:00:59Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent
local Rodux = require(scriptParentParentParentParent.Rodux)
local llama = require(scriptParentParentParentParent.llama)

local _roduxFriendsTypes = require(scriptParentParentParent.roduxFriendsTypes)

local Actions = scriptParentParentParent.Actions
local FriendRequestCreated = require(Actions.FriendRequestCreated)

local tbl1 = {}

return function(arg1)
    local friendsNetworking = arg1.friendsNetworking

    local createReducer = Rodux.createReducer
    local tbl2 = tbl1
    local tbl3 = {}
    tbl3[friendsNetworking.GetFriendRequests.Succeeded.name] = function(tbl4, arg2)
        local data = arg2.responseBody.data

        local tbl5 = {}
        for _, value in pairs(data) do
            local id = value.id
            tbl5[tostring(id)] = value.friendRequest.contactName
        end

        return llama.Dictionary.join(tbl4, tbl5)
    end
    tbl3[FriendRequestCreated.name] = function(tbl4, arg2)
        local str1 = tostring(arg2.requesteeId)
        local contactName = arg2.contactName

        return llama.Dictionary.join(tbl4, { [str1] = contactName })
    end

    return createReducer(tbl2, tbl3)
end
