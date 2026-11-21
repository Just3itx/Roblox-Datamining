-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T17:01:16Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParentParent = script.Parent.Parent.Parent.Parent
local scriptParentParentParentParentParent = scriptParentParentParentParent.Parent
local Rodux = require(scriptParentParentParentParentParent.Rodux)

local Actions = scriptParentParentParentParent.Actions
local FriendRequestCreated = require(Actions.FriendRequestCreated)

local _roduxFriendsTypes = require(scriptParentParentParentParent.roduxFriendsTypes)

local llama = require(scriptParentParentParentParentParent.llama)

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
            tbl5[tostring(id)] = value.isUnseen
        end
        return (llama.Dictionary.join(tbl4, tbl5))
    end
    tbl3[FriendRequestCreated.name] = function(tbl4, arg2)
        local requesteeId = arg2.requesteeId

        return llama.Dictionary.join(tbl4, { [tostring(requesteeId)] = true })
    end

    tbl3[friendsNetworking.ClearNewFriendRequests.Succeeded.name] = function(_, _)
        return tbl1
    end

    return createReducer(tbl2, tbl3)
end
