-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T05:21:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsParent = script:FindFirstAncestor("Moments").Parent

local Http = require(MomentsParent.Http)
local HttpClient = require(MomentsParent.HttpClient)

local url = Http.Url.APIS_URL .. "post-moderation-api/v1/moderate/report-video"

local function reportEdpVideo(tbl1, network)
    return HttpClient.asPromise(
        HttpClient.fetch({
            method = "POST",
            url = url,
            body = {
                feedItemId = tbl1.data.targetIdStr,
                category = tbl1.data.category,
                comment = tbl1.data.comment
            },
            analyticsKey = "moments.report-video",
            network = network,
            decode = function(arg1)
                return {
                    ok = true,
                    reportCode = if type(arg1) == "table" then arg1.reportCode else nil
                }
            end
        })
    )
end
return reportEdpVideo
