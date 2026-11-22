-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T03:40:47Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local tbl1 = {
    AuthenticationRequired = "authentication_required",
    CommentsEndpointDisabled = "endpoint_disabled",
    CommentsDisabledByCreator = "comments_disabled",
    MomentUnavailable = "moment_unavailable",
    MomentNotFound = "moment_unavailable",
    MomentNotVisible = "moment_unavailable",
    ViewerNotEligibleToRead = "not_eligible",
    ViewerNotEligibleToWrite = "not_eligible",
    TextFilterRejected = "text_rejected",
    RateLimited = "rate_limited",
    InvalidCursor = "invalid_cursor",
    InvalidRequest = "invalid_request"
}

local function getCommentsFailureReason(str1: string?, num1: number?)
    if str1 ~= nil and tbl1[str1] ~= nil then
        return tbl1[str1]
    elseif num1 == 408 or num1 == 504 then
        return "timeout"
    elseif num1 == 429 then
        return "rate_limited"
    elseif num1 == 401 then
        return "authentication_required"
    elseif num1 ~= nil and num1 >= 500 then
        return "server_error"
    elseif num1 ~= nil and num1 >= 400 then
        return "request_rejected"
    elseif num1 ~= nil then
        return `unknown_{num1}`
    end

    return "unknown"
end

return getCommentsFailureReason
