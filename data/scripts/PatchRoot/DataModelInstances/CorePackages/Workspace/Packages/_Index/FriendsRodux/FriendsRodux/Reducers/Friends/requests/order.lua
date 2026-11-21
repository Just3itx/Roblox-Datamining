-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T17:01:21Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FriendsRodux = script:FindFirstAncestor("FriendsRodux")
local FriendsRoduxParent = FriendsRodux.Parent
local Rodux = require(FriendsRoduxParent.Rodux)

local _roduxFriendsTypes = require(FriendsRodux.roduxFriendsTypes)

local FFlagAddFriendsRefreshRequestOrder = require(FriendsRoduxParent.SharedFlags).FFlagAddFriendsRefreshRequestOrder

local tbl1 = {}

local function parkTrailingScores(arg1, data)
    local tbl2 = {}
    for _, value in ipairs(data) do
        local id = value.id
        tbl2[tostring(id)] = true
    end

    local tbl3 = {}
    for userId, score in pairs(arg1 and arg1.requestsById or {}) do
        if not tbl2[userId] then
            table.insert(tbl3, { userId = userId, score = score })
        end
    end
    table.sort(tbl3, function(arg2, arg3): boolean
        return arg2.score < arg3.score
    end)

    local tbl4 = {}
    for i, value in ipairs(tbl3) do
        tbl4[value.userId] = #data + i
    end

    return tbl4, #tbl3
end

return function(arg1)
    local friendsNetworking = arg1.friendsNetworking

    local createReducer = Rodux.createReducer
    local tbl2 = tbl1
    local tbl3 = {}
    tbl3[friendsNetworking.GetFriendRequests.Succeeded.name] = function(arg2, arg3)
        local var1

        if FFlagAddFriendsRefreshRequestOrder and arg3.queryArgs and arg3.queryArgs.cursor == nil then
            local var2
            var2, var1 = parkTrailingScores(arg2, arg3.responseBody.data)
            arg2 = { requestsById = var2 }
        else
            var1 = 0
        end

        local var2 = arg2 or {}
        local count = var2.count or 0
        local requestsById = var2.requestsById or {}

        local data = arg3.responseBody.data
        local nextPageCursor = arg3.responseBody.nextPageCursor

        if nextPageCursor == var2.lastCursor and nextPageCursor ~= nil then
            return var2
        end

        for i, value in ipairs(data) do
            local var3 = count + i
            if requestsById[tostring(value.id)] then
                continue
            end

            if FFlagAddFriendsRefreshRequestOrder then
                local id = value.id
                requestsById[tostring(id)] = var3
            elseif value.isUnseen then
                local sentAt = value.friendRequest.sentAt

                local var4 = string.gsub(sentAt, "%.%d+Z$", "Z")
                local num1 = tonumber((string.gsub(var4, "%D", ""))) or 0

                local id = value.id
                requestsById[tostring(id)] = -num1
            else
                local id = value.id
                requestsById[tostring(id)] = var3
            end
        end

        local var3 = count + #data
        if FFlagAddFriendsRefreshRequestOrder then
            var3 += var1
        end

        return { count = var3, lastCursor = nextPageCursor, requestsById = requestsById }
    end

    return createReducer(tbl2, tbl3)
end
