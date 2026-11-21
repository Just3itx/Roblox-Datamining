-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T16:00:59Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FriendsLanding = script:FindFirstAncestor("FriendsLanding")
local llama = require(FriendsLanding.dependencies).llama

return function(arg1)
    local tbl1 = {}
    local tbl2 = {}
    local tbl3 = {}
    local tbl4 = {}
    for k, value in pairs(arg1.responseBody.data) do
        table.insert(tbl1, table.concat(llama.List.map(value.mutualFriendsList, function<T>(arg2: T): T
            return arg2
        end), ","))

        table.insert(tbl2, if value.friendRequest.sourceUniverseId then value.friendRequest.sourceUniverseId else 0)

        table.insert(tbl3, value.friendRequest.senderId)
        table.insert(tbl4, k)
    end

    return {
        page = "friendRequests",
        requestingUserId = table.concat(tbl3, ","),
        gamesContext = table.concat(tbl2, ","),
        absPosition = table.concat(tbl4, ","),
        mutualFriendsContext = table.concat(tbl1, ";")
    }
end
