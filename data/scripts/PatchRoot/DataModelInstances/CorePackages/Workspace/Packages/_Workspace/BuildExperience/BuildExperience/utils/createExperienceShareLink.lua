-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T21:11:24Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperienceParent = script:FindFirstAncestor("BuildExperience").Parent

local HttpService = game:GetService("HttpService")

local HttpClient = require(BuildExperienceParent.HttpClient)
local UrlBase = require(BuildExperienceParent.UrlBuilder).UrlBase

local fetch = HttpClient.fetch
local asPromise = HttpClient.asPromise

local url = UrlBase.APIS .. "/sharelinks/v1/get-or-create-link"

local function decodeShareLink(tbl1)
    return if type(tbl1) == "table" and type(tbl1.shortUrl) == "string" then tbl1.shortUrl else nil
end

local function createExperienceShareLink(num1: number, retry: boolean?)
    local var2 = fetch({
        method = "POST",
        url = url,
        body = {
            linkType = "ExperienceDetails",
            data = HttpService:JSONEncode({ universeId = tostring(num1) })
        },
        analyticsKey = "build-experience.create-private-share-link",
        decode = decodeShareLink,
        retry = retry
    })
    return asPromise(var2)
end

return createExperienceShareLink
