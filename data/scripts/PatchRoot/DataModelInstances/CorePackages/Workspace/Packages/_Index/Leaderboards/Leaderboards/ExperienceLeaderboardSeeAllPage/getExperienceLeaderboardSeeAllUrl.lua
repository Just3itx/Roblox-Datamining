-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T02:40:47Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Leaderboards = script:FindFirstAncestor("Leaderboards")
local LeaderboardsParent = Leaderboards.Parent

local UrlBuilder = require(LeaderboardsParent.UrlBuilder).UrlBuilder
local Url = require(LeaderboardsParent.Http).Url
local Constants = require(Leaderboards.ExperienceLeaderboardSeeAllPage.Constants)

local urlBuilder = UrlBuilder.new({ base = Url.APIS_URL, path = Constants.Path })

local function getExperienceLeaderboardSeeAllUrl()
    return urlBuilder()
end

return getExperienceLeaderboardSeeAllUrl
