-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T14:01:15Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameDetailRoduxParent = script:FindFirstAncestor("GameDetailRodux").Parent

local Url = require(GameDetailRoduxParent.Http).Url
local UrlBuilder = require(GameDetailRoduxParent.UrlBuilder).UrlBuilder
local HttpService = game:GetService("HttpService")

local urlBuilder = UrlBuilder.new({ base = Url.APIS_URL, path = "experience-guidelines-api/experience-guidelines/get-age-recommendation" })

return function(arg1, universeId: string)
    return arg1(urlBuilder(), "POST", { postBody = HttpService:JSONEncode({ universeId = universeId }) })
end
