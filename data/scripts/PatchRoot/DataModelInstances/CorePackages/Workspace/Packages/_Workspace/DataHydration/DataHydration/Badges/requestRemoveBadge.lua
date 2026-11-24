-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T03:10:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DataHydrationParent = script:FindFirstAncestor("DataHydration").Parent

local HttpRequest = require(DataHydrationParent.HttpRequest)
local HttpService = game:GetService("HttpService")
local BadgesUrlBuilder = require(script.Parent.BadgesUrlBuilder)

local function requestRemoveBadge(str1: string)
    local badgeRemoveUrl = BadgesUrlBuilder.buildBadgeRemoveUrl(str1)

    return HttpRequest.config({
        requestFunction = function(str2: string, str3: string, arg1)
            return HttpRequest.requestFunctions.RequestInternal(str2, str3, arg1)
        end
    })(badgeRemoveUrl, "DELETE", {
        postBody = HttpService:JSONEncode({})
    })
end
return requestRemoveBadge
