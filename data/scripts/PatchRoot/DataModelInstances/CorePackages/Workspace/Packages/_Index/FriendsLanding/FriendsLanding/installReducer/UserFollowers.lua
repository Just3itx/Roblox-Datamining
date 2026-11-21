-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T16:01:15Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FriendsLanding = script:FindFirstAncestor("FriendsLanding")
local dependencies = require(FriendsLanding.dependencies)

local Rodux = dependencies.Rodux
local FriendsNetworking = dependencies.FriendsNetworking

local createReducer = Rodux.createReducer
local tbl1 = {}
tbl1[FriendsNetworking.GetUserFollowers.Succeeded.name] = function(_, arg1)
    local result = {}
    local data = arg1.responseBody.data
    for _, value in ipairs(data) do
        local id = value.id
        result[tostring(id)] = true
    end
    return result
end

return createReducer({}, tbl1)
