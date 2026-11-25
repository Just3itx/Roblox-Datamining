-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T20:01:34Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UniversalFeatureRestrictions = script:FindFirstAncestor("UniversalFeatureRestrictions")
local UniversalFeatureRestrictionsParent = UniversalFeatureRestrictions.Parent

local HttpRbxApiService = game:GetService("HttpRbxApiService")
local HttpService = game:GetService("HttpService")

local UrlBuilder = require(UniversalFeatureRestrictionsParent.UrlBuilder).UrlBuilder
local Promise = require(UniversalFeatureRestrictionsParent.Promise)
local buildQueryString = require(UniversalFeatureRestrictions.Utils.buildQueryString)

local function GetModerationDetail(tbl1)
    local apiUrl = UrlBuilder.usermoderation.moderationDetail() .. buildQueryString(tbl1)

    return Promise.new(function(callback, callback2)
        task.defer(function()
            local success, result = pcall(function(): string
                return HttpRbxApiService:GetAsyncFullUrl(apiUrl, Enum.ThrottlingPriority.Default)
            end)

            if not success then
                callback2({ error = "HTTP request failed", details = result })

                return
            end

            local success2, result2 = pcall(function()
                return HttpService:JSONDecode(result)
            end)

            if success2 then
                callback(result2)
                return
            end
            callback2({ error = "Failed to parse JSON response", details = result2 })
        end)
    end)
end
return GetModerationDetail
