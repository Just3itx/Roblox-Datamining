-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T04:51:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsParent = script:FindFirstAncestor("Moments").Parent

local Http = require(MomentsParent.Http)
local HttpClient = require(MomentsParent.HttpClient)

local url = Http.Url.APIS_URL .. "content-captures-api/v1/moment-generated-text-feedback"

local function momentGeneratedTextFeedback(generationToken: string, reason: string, network)
    return HttpClient.asPromise(
        HttpClient.fetch({
            method = "POST",
            url = url,
            body = { generationToken = generationToken, reason = reason },
            analyticsKey = "moments.moment-generated-text-feedback",
            network = network,
            decode = function(_)
                return { ok = true }
            end
        })
    )
end
return momentGeneratedTextFeedback
