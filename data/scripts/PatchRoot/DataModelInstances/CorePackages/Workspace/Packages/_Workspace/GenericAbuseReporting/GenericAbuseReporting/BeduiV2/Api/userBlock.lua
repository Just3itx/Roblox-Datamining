-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T15:31:41Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GenericAbuseReportingParent = script:FindFirstAncestor("GenericAbuseReporting").Parent

local Url = require(GenericAbuseReportingParent.Http).Url

return {
    blockUser = function(arg1, str1: string)
        return arg1(`{Url.APIS_URL}user-blocking-api/v1/users/{str1}/block-user`, "POST")
    end,
    unblockUser = function(arg1, str1: string)
        return arg1(`{Url.APIS_URL}user-blocking-api/v1/users/{str1}/unblock-user`, "POST")
    end,
    isBlockedUser = function(arg1, str1: string)
        return arg1(`{Url.APIS_URL}user-blocking-api/v1/users/{str1}/is-blocked`, "GET")
    end
}
