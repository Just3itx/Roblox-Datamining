-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T04:11:08Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DataHydrationParent = script:FindFirstAncestor("DataHydration").Parent

local Http = require(DataHydrationParent.Http)
local HttpRequest = require(DataHydrationParent.HttpRequest)
local HttpService = game:GetService("HttpService")

local UrlBuilder = require(DataHydrationParent.UrlBuilder).UrlBuilder
local Url = Http.Url

local var1 = UrlBuilder.new({ base = Url.APIS_URL, path = "experience-guidelines-api/experience-guidelines/get-age-recommendation" })()

local function requestAgeRecommendation(universeId: string)
    local postBody = HttpService:JSONEncode({ universeId = universeId })
    return HttpRequest.config({
        requestFunction = function(str2: string, str3: string, arg1)
            return HttpRequest.requestFunctions.HttpRbxApi(str2, str3, arg1)
        end
    })(var1, "POST", { postBody = postBody })
end

return requestAgeRecommendation
