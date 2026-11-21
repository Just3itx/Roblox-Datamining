-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T05:31:08Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BadgesParent = script:FindFirstAncestor("Badges").Parent

local UrlBuilder = require(BadgesParent.UrlBuilder).UrlBuilder
local Url = require(BadgesParent.Http).Url

local urlBuilder = UrlBuilder.new({ base = Url.APIS_URL, path = "landing-page-api/badge-details-page/v1beta1" })

local function getBadgeDetailsUrl(badgeId: string, userId: string?)
    local tbl1 = { badgeId = badgeId }

    if userId then
        tbl1.userId = userId
    end
    tbl1.PageEntryFormat = "Universal"
    return (UrlBuilder.addQueryString(urlBuilder(), tbl1))
end
return getBadgeDetailsUrl
