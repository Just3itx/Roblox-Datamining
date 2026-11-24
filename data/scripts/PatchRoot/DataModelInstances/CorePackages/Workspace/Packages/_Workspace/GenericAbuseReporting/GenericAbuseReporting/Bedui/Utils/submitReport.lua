-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T15:31:32Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GenericAbuseReportingParent = script:FindFirstAncestor("GenericAbuseReporting").Parent
local HttpService = game:GetService("HttpService")

local Url = require(GenericAbuseReportingParent.Http).Url

local FFlagAddThumbnailSelectorReport = require(GenericAbuseReportingParent.SharedFlags).FFlagAddThumbnailSelectorReport

return function(arg1, arg2)
    local input = {
        tags = {}
    }

    for value, value2 in FFlagAddThumbnailSelectorReport and arg2 == nil and {} or arg2 do
        if typeof(value2) ~= "table" then
            value2 = not FFlagAddThumbnailSelectorReport and { tostring(value2) } or tostring(value2):split(",")
        end

        local valueList = {}
        for _, value3 in value2 do
            table.insert(valueList, { data = tostring(value3) })
        end

        input.tags[value] = { valueList = valueList }
    end

    local success, result = pcall(function(): string
        return HttpService:JSONEncode(input)
    end)
    if not success then
        warn("Failed to encode report data")
    end
    return arg1(Url.APIS_URL .. "abuse-reporting/v2/abuse-report", "POST", { postBody = result })
end
