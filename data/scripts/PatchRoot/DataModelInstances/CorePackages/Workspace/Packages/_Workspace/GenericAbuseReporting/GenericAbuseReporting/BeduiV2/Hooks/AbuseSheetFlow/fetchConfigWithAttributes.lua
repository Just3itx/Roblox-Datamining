-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T15:41:22Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GenericAbuseReporting = script:FindFirstAncestor("GenericAbuseReporting")
local GenericAbuseReportingParent = GenericAbuseReporting.Parent
local HttpService = game:GetService("HttpService")
local LocalizationService = game:GetService("LocalizationService")

local ArgCheck = require(GenericAbuseReportingParent.ArgCheck)
local Url = require(GenericAbuseReportingParent.Http).Url

local _AbuseVector = require(GenericAbuseReporting.Enums.AbuseVector)

local FFlagAbuseReportInExpPlayerListV3 = require(GenericAbuseReportingParent.SharedFlags).FFlagAbuseReportInExpPlayerListV3
local FFlagAbuseReportSubmissionTargetV4 = require(GenericAbuseReportingParent.SharedFlags).FFlagAbuseReportSubmissionTargetV4

local str1 = if game:DefineFastFlag("AbuseReportSubmissionLegacyChatV5", false) and FFlagAbuseReportSubmissionTargetV4 then "&version=5" elseif FFlagAbuseReportSubmissionTargetV4 then "&version=4" elseif FFlagAbuseReportInExpPlayerListV3 then "&version=3" else "&version=2"

return function(arg1, input: string, input2)
    ArgCheck.assert(input, "abuseVector is required")
    ArgCheck.isType(input, "string", "fetchConfigWithAttributes expects abuseVector as a string")

    local robloxLocaleId = LocalizationService.RobloxLocaleId
    local var1

    if input2 and next(input2) ~= nil then
        local input3 = HttpService:JSONEncode(input2)
        var1 = `&attributes={HttpService:UrlEncode(input3)}`
    else
        var1 = ""
    end

    local str2 = HttpService:UrlEncode(input)
    local str3 = HttpService:UrlEncode(robloxLocaleId)

    return arg1(
        `{Url.APIS_URL}abuse-reporting/v1/dynamic-config?abuseVector={str2}&locale={str3}&entryPoint=ua{var1}{str1}`,
        "GET"
    )
end
