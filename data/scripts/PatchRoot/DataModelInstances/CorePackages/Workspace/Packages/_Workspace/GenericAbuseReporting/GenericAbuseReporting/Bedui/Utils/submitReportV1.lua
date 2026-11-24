-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T15:31:33Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GenericAbuseReportingParent = script:FindFirstAncestor("GenericAbuseReporting").Parent
local HttpService = game:GetService("HttpService")

local Url = require(GenericAbuseReportingParent.Http).Url

return function(arg1, input)
    local success, result = pcall(function(): string
        return HttpService:JSONEncode(input)
    end)
    if not success then
        warn("Failed to encode v1 report body")
    end
    return arg1(Url.APIS_URL .. "abuse-reporting/v1/abuse-report", "POST", { postBody = result })
end
