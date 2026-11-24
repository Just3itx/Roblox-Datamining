-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T03:11:26Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DataHydrationParent = script:FindFirstAncestor("DataHydration").Parent

local HttpService = game:GetService("HttpService")
local HttpRequest = require(DataHydrationParent.HttpRequest)
local CommunityUserMembershipUrlBuilder = require(script.Parent.CommunityUserMembershipUrlBuilder)

local function requestJoinCommunity(str1: string)
    local joinCommunityUrl = CommunityUserMembershipUrlBuilder.buildJoinCommunityUrl(str1)

    return HttpRequest.config({
        requestFunction = function(str2: string, str3: string, arg1)
            return HttpRequest.requestFunctions.RequestInternal(str2, str3, arg1)
        end
    })(joinCommunityUrl, "POST", {
        postBody = HttpService:JSONEncode({})
    })
end
return requestJoinCommunity
