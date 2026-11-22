-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T05:21:21Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsParent = script:FindFirstAncestor("Moments").Parent

local Http = require(MomentsParent.Http)
local HttpClient = require(MomentsParent.HttpClient)

local url = Http.Url.APIS_URL .. "content-captures-api/v1/moderate/report"

local function reportMoment(feedItemId: string, reportType: string?, network)
    return HttpClient.asPromise(
        HttpClient.fetch({
            method = "POST",
            url = url,
            body = { feedItemId = feedItemId, reportType = reportType },
            analyticsKey = "moments.report-moment",
            network = network,
            decode = function(arg1)
                return {
                    ok = true,
                    reportCode = arg1.reportCode
                }
            end
        })
    )
end

return reportMoment
