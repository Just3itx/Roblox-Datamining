-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T05:20:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DataHydration = script:FindFirstAncestor("DataHydration")
local DataHydrationParent = DataHydration.Parent

local Url = require(DataHydrationParent.Http).Url

local TrustedConnections = DataHydration.TrustedConnections
local myHttpRequest = require(TrustedConnections.Networking.myHttpRequest)

return function()
    local str1 = string.format("%s/user/trusted-friend-requests/count", Url.FRIEND_URL)

    return myHttpRequest(str1, "GET"):andThen(function(arg1)
        return arg1 and arg1.responseBody
    end)
end
