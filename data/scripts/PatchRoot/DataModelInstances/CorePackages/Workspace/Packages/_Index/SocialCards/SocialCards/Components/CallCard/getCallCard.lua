-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T17:01:11Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")

local SocialCardsParent = script:FindFirstAncestor("SocialCards").Parent

local UrlBuilder = require(SocialCardsParent.UrlBuilder)

local _parseCallCard = require(script.Parent.parseCallCard)

local UrlBuilder2 = UrlBuilder.UrlBuilder
local UrlBase = UrlBuilder.UrlBase

local function getCallCard(callId: string, callback: (...any) -> (...any))
    local url = UrlBuilder2.new({ base = UrlBase.APIS, path = "call/v2/get-call-card", query = { callId = callId } })()
    HttpService:RequestInternal({ Headers = { Accept = "application/json" }, Method = "GET", Url = url }):Start(function(_, arg1)
        if arg1.StatusCode == 200 then
            callback(HttpService:JSONDecode(arg1.Body))
        end
    end)
end

return getCallCard
