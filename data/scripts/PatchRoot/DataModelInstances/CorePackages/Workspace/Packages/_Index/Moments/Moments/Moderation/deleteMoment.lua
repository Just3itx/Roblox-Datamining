-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T05:21:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsParent = script:FindFirstAncestor("Moments").Parent

local Http = require(MomentsParent.Http)
local HttpClient = require(MomentsParent.HttpClient)
local Promise = require(MomentsParent.Promise)

local var1 = Http.Url.APIS_URL .. "content-captures-api/v2/moments/"

local function deleteMoment(str1: string?, network)
    if str1 == nil or str1 == "" then
        return Promise.reject("feedItemId is required to delete a Moment")
    end
    local str2 = "by-feed-item/" .. str1

    return HttpClient.asPromise(
        HttpClient.fetch({
            method = "DELETE",
            url = var1 .. str2,
            analyticsKey = "moments.delete-moment",
            network = network,
            decode = function(_)
                return { ok = true }
            end
        })
    )
end
return deleteMoment
