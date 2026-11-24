-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T15:31:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GenericAbuseReporting = script:FindFirstAncestor("GenericAbuseReporting")
local GenericAbuseReportingParent = GenericAbuseReporting.Parent
local LocalizationService = game:GetService("LocalizationService")

local ArgCheck = require(GenericAbuseReportingParent.ArgCheck)
local Url = require(GenericAbuseReportingParent.Http).Url

local _AbuseVector = require(GenericAbuseReporting.Enums.AbuseVector)

return function(arg1, arg2)
    ArgCheck.assert(arg2, "abuseVector is required")
    ArgCheck.isType(arg2, "string", "fetchBeduiData expects abuseVector as a string")

    local robloxLocaleId = LocalizationService.RobloxLocaleId

    return arg1(
        `{Url.APIS_URL}abuse-reporting/v1/dynamic-dialog-sequential?context={arg2}&locale={robloxLocaleId}&surface=ua&version=v1`,
        "GET"
    )
end
