-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T05:31:12Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BadgesParent = script:FindFirstAncestor("Badges").Parent

local UrlBuilder = require(BadgesParent.UrlBuilder).UrlBuilder
local Url = require(BadgesParent.Http).Url
local BadgesSeeAllPageConstants = require(script.Parent.BadgesSeeAllPageConstants)

local urlBuilder = UrlBuilder.new({ base = Url.APIS_URL, path = "landing-page-api/badges-see-all/v1beta1" })

local function getBadgesSeeAllUrl(universeId: string, cursor: string?)
    return (UrlBuilder.addQueryString(urlBuilder(), {
        universeId = universeId,
        pageSize = BadgesSeeAllPageConstants.RequestPageSize,
        cursor = cursor,
        PageEntryFormat = "Universal"
    }))
end

return getBadgesSeeAllUrl
