-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T05:21:07Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DataHydration = script:FindFirstAncestor("DataHydration")
local DataHydrationParent = DataHydration.Parent

local SharedFlags = require(DataHydrationParent.SharedFlags)
local Url = require(DataHydrationParent.Http).Url

local TrustedConnections = DataHydration.TrustedConnections
local myHttpRequest = require(TrustedConnections.Networking.myHttpRequest)

return function(arg1, str1: string?)
    local str2 = string.format("%s/users/%s/send-trusted-friend-request", Url.FRIEND_URL, tostring(arg1))

    if SharedFlags.FFlagProfilePlatformTrustedConnectionsMVP and str1 ~= nil then
        str2 ..= `?source={str1}`
    end

    return myHttpRequest(str2, "POST", { postBody = {} })
end
