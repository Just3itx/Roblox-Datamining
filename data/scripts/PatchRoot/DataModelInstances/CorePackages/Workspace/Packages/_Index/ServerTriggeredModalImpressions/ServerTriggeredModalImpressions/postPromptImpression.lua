-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T15:30:47Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")

local ServerTriggeredModalImpressionsParent = script:FindFirstAncestor("ServerTriggeredModalImpressions").Parent

local Promise = require(ServerTriggeredModalImpressionsParent.Promise)
local UrlBuilder = require(ServerTriggeredModalImpressionsParent.UrlBuilder).UrlBuilder
local UrlBase = require(ServerTriggeredModalImpressionsParent.UrlBuilder).UrlBase

local urlBuilder = UrlBuilder.new({ base = UrlBase.APIS, path = "modals-api/v1/prompts/impression" })

return function(arg1, promptType: string, promptId: string?)
    local success, result = pcall(function()
        return arg1(urlBuilder(), "POST", { postBody = HttpService:JSONEncode({ promptType = promptType, promptId = promptId }) })
    end)

    if not success then
        return Promise.reject(result)
    end

    return result
end
