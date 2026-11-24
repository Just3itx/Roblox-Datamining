-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T05:01:42Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DataHydration = script:FindFirstAncestor("DataHydration")
local DataHydrationParent = DataHydration.Parent

local Url = require(DataHydrationParent.Http).Url

local Presence = DataHydration.Presence
local myHttpRequest = require(Presence.Networking.myHttpRequest)

return function(userIds)
    local str1 = string.format("%s/presence/users", Url.PRESENCE_URL)
    return myHttpRequest(str1, "POST", { postBody = { userIds = userIds } })
end
