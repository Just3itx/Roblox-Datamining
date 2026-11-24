-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T17:31:43Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GroupsParent = script:FindFirstAncestor("Groups").Parent

local HttpService = game:GetService("HttpService")

local UrlBuilder = require(GroupsParent.UrlBuilder).UrlBuilder

return function(arg1, profileId: number)
    local string2 = UrlBuilder.fromString("apis:profile-platform-api/v1/profiles/get")

    local postBody = HttpService:JSONEncode({ profileId = profileId, profileType = "Community", components = {{ component = "Actions" }} })

    return arg1(string2(), "POST", { postBody = postBody }):andThen(function(arg2)
        return arg2.responseBody
    end)
end
