-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T00:21:25Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Home = script:FindFirstAncestor("Home")
local HomeParent = Home.Parent

local UrlBuilder = require(HomeParent.UrlBuilder).UrlBuilder
local Url = require(HomeParent.Http).Url
local HomeConstants = require(Home.HomeConstants)

local urlBuilder = UrlBuilder.new({ base = Url.APIS_URL, path = HomeConstants.ApiName })

local function getHomePageUrl()
    return urlBuilder()
end

return getHomePageUrl
