-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T04:11:22Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DataHydration = script:FindFirstAncestor("DataHydration")
local DataHydrationParent = DataHydration.Parent

local HttpRequest = require(DataHydrationParent.HttpRequest)
local Promise = require(DataHydrationParent.Promise)
local getLocalPlayerUserId = require(DataHydration.DataHydrationUtils).getLocalPlayerUserId

local FollowingsUrlBuilder = require(script.Parent.FollowingsUrlBuilder)

local function fetchFollowing(str1: string)
    local localPlayerUserId = getLocalPlayerUserId()
    if not localPlayerUserId or localPlayerUserId <= 0 then
        return Promise.reject({
            ClientError = "Missing or invalid local player ID",
            message = "Cannot fetch following status: missing or invalid local player ID"
        })
    end

    local followingStatusUrl = FollowingsUrlBuilder.buildFollowingStatusUrl(tostring(localPlayerUserId), str1)

    return HttpRequest.config({
        requestFunction = function(str2: string, str3: string, arg1)
            return HttpRequest.requestFunctions.HttpRbxApi(str2, str3, arg1)
        end
    })(followingStatusUrl, "GET")
end

return fetchFollowing
