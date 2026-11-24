-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T23:01:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InterventionSharedParent = script:FindFirstAncestor("InterventionShared").Parent

local HttpRbxApiService = game:GetService("HttpRbxApiService")
local HttpService = game:GetService("HttpService")

local Promise = require(InterventionSharedParent.Promise)
local UrlBuilder = require(InterventionSharedParent.UrlBuilder).UrlBuilder

local function PostDismissIntervention(interventionId: string)
    local apiUrl = UrlBuilder.usermoderation.dismissIntervention()
    local str1 = HttpService:JSONEncode({ intervention_id = interventionId })

    return Promise.new(function(callback, callback2)
        task.defer(function()
            local success, result = pcall(function(): string
                return HttpRbxApiService:PostAsyncFullUrl(apiUrl, str1, Enum.ThrottlingPriority.Default)
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
return PostDismissIntervention
