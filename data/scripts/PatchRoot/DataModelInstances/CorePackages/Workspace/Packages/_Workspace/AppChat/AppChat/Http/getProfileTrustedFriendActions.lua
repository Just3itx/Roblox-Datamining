-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T09:50:41Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChatParent = script:FindFirstAncestor("AppChat").Parent

local Http = require(AppChatParent.Http)

local RoduxNetworking = require(script.Parent.RoduxNetworking)

local var1 = Http.Url.APIS_URL .. "profile-platform-api/v1/profiles/get"

return function(profileId: string, arg1)
    return (arg1 or RoduxNetworking.getNetworkImpl())(var1, "POST", {
        postBody = {
            profileType = "User",
            profileId = profileId,
            components = {{ component = "Actions" }},
            includeComponentOrdering = false
        }
    }):andThen(
        function(arg2)
            return arg2
                and arg2.responseBody
                and arg2.responseBody.components
                and arg2.responseBody.components.Actions
                and arg2.responseBody.components.Actions.contextual
                or {}
        end
    )
end
