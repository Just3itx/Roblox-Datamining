-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T13:51:26Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RoduxFriendsParent = script:FindFirstAncestor("RoduxFriends").Parent
local Rodux = require(RoduxFriendsParent.Rodux)

local tbl1 = {}

return function(arg1)
    local friendsNetworking = arg1.friendsNetworking

    local createReducer = Rodux.createReducer
    local tbl2 = tbl1
    local tbl3 = {}
    tbl3[friendsNetworking.GetFriendRequests.Succeeded.name] = function(arg2, arg3)
        local var1 = arg2 or {}
        local count = var1.count or 0
        local requestsById = var1.requestsById or {}

        local data = arg3.responseBody.data
        local nextPageCursor = arg3.responseBody.nextPageCursor

        if nextPageCursor == var1.lastCursor and nextPageCursor ~= nil then
            return var1
        end

        for i, value in ipairs(data) do
            local var2 = count + i
            if not requestsById[tostring(value.id)] then
                local id = value.id
                requestsById[tostring(id)] = var2
            end
        end

        return {
            count = count + #data,
            lastCursor = nextPageCursor,
            requestsById = requestsById
        }
    end

    return createReducer(tbl2, tbl3)
end
