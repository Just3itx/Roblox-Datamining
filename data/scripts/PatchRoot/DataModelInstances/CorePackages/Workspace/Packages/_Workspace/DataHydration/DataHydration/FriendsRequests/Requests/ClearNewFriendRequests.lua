-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T04:10:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DataHydrationParent = script:FindFirstAncestor("DataHydration").Parent

local HttpClient = require(DataHydrationParent.HttpClient)
local Http = require(DataHydrationParent.Http)

local fetch = HttpClient.fetch
local asPromise = HttpClient.asPromise

return function()
    local var1 = fetch({
        method = "DELETE",
        url = `{Http.Url.FRIEND_URL}/my/new-friend-requests`,
        analyticsKey = "friends.clear-new-friend-requests",
        decode = function(_)
            return nil
        end
    })
    return asPromise(var1)
end
