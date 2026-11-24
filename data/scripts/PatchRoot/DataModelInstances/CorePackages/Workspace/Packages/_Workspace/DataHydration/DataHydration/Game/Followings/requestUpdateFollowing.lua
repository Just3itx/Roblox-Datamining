-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T04:11:28Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DataHydration = script:FindFirstAncestor("DataHydration")
local DataHydrationParent = DataHydration.Parent

local HttpService = game:GetService("HttpService")
local HttpRequest = require(DataHydrationParent.HttpRequest)
local Promise = require(DataHydrationParent.Promise)
local getLocalPlayerUserId = require(DataHydration.DataHydrationUtils).getLocalPlayerUserId

local FollowingsUrlBuilder = require(script.Parent.FollowingsUrlBuilder)

local function requestUpdateFollowing(str1: string, bool1: boolean)
    local localPlayerUserId = getLocalPlayerUserId()
    if not localPlayerUserId or localPlayerUserId <= 0 then
        return Promise.reject({
            ClientError = "Missing or invalid local player ID",
            message = "Cannot update following status: missing or invalid local player ID"
        })
    end

    local followingUpdateUrl = FollowingsUrlBuilder.buildFollowingUpdateUrl(tostring(localPlayerUserId), str1)

    local var1 = HttpRequest.config({
        requestFunction = function(str2: string, str3: string, arg1)
            return HttpRequest.requestFunctions.RequestInternal(str2, str3, arg1)
        end
    })

    return var1(
        followingUpdateUrl,
        if bool1 then "POST" else "DELETE",
        {
            postBody = if bool1 then HttpService:JSONEncode({}) else nil
        }
    )
end

return requestUpdateFollowing
