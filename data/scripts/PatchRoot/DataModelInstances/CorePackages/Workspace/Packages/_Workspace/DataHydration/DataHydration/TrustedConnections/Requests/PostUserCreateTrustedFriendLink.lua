-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T05:21:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DataHydration = script:FindFirstAncestor("DataHydration")
local DataHydrationParent = DataHydration.Parent

local Url = require(DataHydrationParent.Http).Url

local TrustedConnections = DataHydration.TrustedConnections
local myHttpRequest = require(TrustedConnections.Networking.myHttpRequest)

return function(arg1, _: string?)
    local str1 = string.format("%s/users/%s/create-trusted-friend-link", Url.FRIEND_URL, tostring(arg1))

    return myHttpRequest(str1, "POST", { postBody = {} })
end
