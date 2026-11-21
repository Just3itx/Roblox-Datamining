-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T05:31:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BadgesParent = script:FindFirstAncestor("Badges").Parent

local UrlBuilder = require(BadgesParent.UrlBuilder).UrlBuilder
local Url = require(BadgesParent.Http).Url

local urlBuilder = UrlBuilder.new({ base = Url.APIS_URL, path = "landing-page-api/badge-details-page/v1beta1" })

local function getBadgeDetailsPostUrl()
    return urlBuilder()
end

return getBadgeDetailsPostUrl
