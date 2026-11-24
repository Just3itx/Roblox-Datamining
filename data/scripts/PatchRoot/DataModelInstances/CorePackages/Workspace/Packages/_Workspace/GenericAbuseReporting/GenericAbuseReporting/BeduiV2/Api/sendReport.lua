-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T15:31:40Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GenericAbuseReporting = script:FindFirstAncestor("GenericAbuseReporting")
local GenericAbuseReportingParent = GenericAbuseReporting.Parent
local HttpService = game:GetService("HttpService")

local Promise = require(GenericAbuseReportingParent.Promise)
local Url = require(GenericAbuseReportingParent.Http).Url

local FFlagAbuseReportImproveErrorEvents = require(GenericAbuseReporting.Flags.FFlagAbuseReportImproveErrorEvents)

return function(arg1, str1: string, input)
    local success, result = pcall(function(): string
        return HttpService:JSONEncode(input)
    end)
    if not success then
        warn("Failed to encode v1 report body")
        if FFlagAbuseReportImproveErrorEvents then
            return Promise.reject("Failed to encode v1 report body")
        end
    end
    return arg1(Url.APIS_URL .. str1, "POST", { postBody = result })
end
