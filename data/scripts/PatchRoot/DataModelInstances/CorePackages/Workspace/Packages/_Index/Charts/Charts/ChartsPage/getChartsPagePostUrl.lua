-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T06:30:44Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ChartsParent = script:FindFirstAncestor("Charts").Parent

local UrlBuilder = require(ChartsParent.UrlBuilder).UrlBuilder
local Url = require(ChartsParent.Http).Url

local urlBuilder = UrlBuilder.new({ base = Url.APIS_URL, path = "charts-api/v1/charts-page" })

local function getChartsPagePostUrl()
    return urlBuilder()
end

return getChartsPagePostUrl
