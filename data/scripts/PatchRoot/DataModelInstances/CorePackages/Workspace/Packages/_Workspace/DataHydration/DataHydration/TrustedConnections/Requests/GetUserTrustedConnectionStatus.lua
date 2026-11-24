-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T05:20:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DataHydration = script:FindFirstAncestor("DataHydration")
local DataHydrationParent = DataHydration.Parent

local Url = require(DataHydrationParent.Http).Url

local TrustedConnections = DataHydration.TrustedConnections
local myHttpRequest = require(TrustedConnections.Networking.myHttpRequest)

return function(arg1)
    local str1 = string.format("%s/my/trusted-friends/%s/status", Url.FRIEND_URL, tostring(arg1))
    return myHttpRequest(str1, "GET"):andThen(function(arg2)
        return arg2 and arg2.responseBody and arg2.responseBody.status
    end)
end
