-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T04:50:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DataHydration = script:FindFirstAncestor("DataHydration")
local DataHydrationParent = DataHydration.Parent

local HttpService = game:GetService("HttpService")

local Http = require(DataHydrationParent.Http)
local HttpClient = require(DataHydrationParent.HttpClient)
local MomentsTypes = require(DataHydrationParent.MomentsTypes)
local _MomentsStoreTypes = require(DataHydration.Moments.MomentsStoreTypes)

local url = Http.Url.APIS_URL .. "deeplinks/v2/get-or-create-static"

local ShareLinkTargetIdType = MomentsTypes.Enums.ShareLinkTargetIdType

local function decodeShareLink(tbl1)
    return if tbl1.link and type(tbl1.link) == "string" then tbl1.link else nil
end

local function fetchShareLink(tbl1, network)
    local input = {
        momentId = tbl1.momentId
    }
    local feedItemId = tbl1.feedItemId
    assert(not (feedItemId == nil) and feedItemId ~= "", "feedItemId is required to create a Moments share link")

    input.targetIdType = ShareLinkTargetIdType.FeedItemId
    return HttpClient.fetch({
        method = "POST",
        url = url,
        body = {
            linkType = 6,
            targetId = feedItemId,
            linkPreviewTitle = tbl1.title,
            linkPreviewDescription = tbl1.description or "",
            linkPreviewAssetId = 0,
            customData = HttpService:JSONEncode(input)
        },
        analyticsKey = "moments.get-or-create-static-share-link",
        network = network,
        decode = decodeShareLink
    })
end

return fetchShareLink
