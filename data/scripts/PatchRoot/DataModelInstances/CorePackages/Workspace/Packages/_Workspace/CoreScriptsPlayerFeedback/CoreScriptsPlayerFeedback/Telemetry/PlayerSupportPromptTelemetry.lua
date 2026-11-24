-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T01:11:31Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local TelemetryService = game:GetService("TelemetryService")

local standardizedFields = {
    "addPlaceId",
    "addUniverseId",
    "addSessionInfo",
    "addPlaySessionId"
}
local config = {
    eventName = "PlayerSupportPromptAction",
    backends = { "EventIngest" },
    throttlingPercentage = game:DefineFastInt("PlayerSupportPromptTelemetryThrottleHundredthsPercent", 10000),
    lastUpdated = { 2026, 9, 23 },
    description = "Funnel events for the player support ticket prompt."
}

local Action = {
    Opened = "opened",
    Submitted = "submitted",
    Dismissed = "dismissed",
    ReportAbuseClicked = "report_abuse_clicked",
    EligibilityBlocked = "eligibility_blocked",
    ErrorShown = "error_shown",
    RejectionRetry = "rejection_retry",
    TicketResult = "ticket_result"
}

local TicketResult = { Submitted = "submitted", Failed = "failed", Rejected = "rejected" }

local tbl4 = {
    TICKET_CREATION_SUBMITTED = TicketResult.Submitted,
    TICKET_CREATION_FAILED = TicketResult.Failed,
    TICKET_CREATION_TEXT_FILTER_ERROR = TicketResult.Rejected,
    TICKET_CREATION_GIBBERISH_ERROR = TicketResult.Rejected
}

local function fieldString(arg1): string -- Luacid: Inlined by compiler; 3 call sites recovered
    if arg1 == nil then
        return ""
    end
    return tostring(arg1)
end

local module = {
    Action = Action,
    DismissMethod = { Escape = "escape", DialogClose = "dialog_close" },
    TicketResult = TicketResult
}

function module.log(tbl5)
    pcall(function()
        TelemetryService:LogEvent(config, {
            eventContext = "PlayerSupportPrompt",
            standardizedFields = standardizedFields,
            customFields = {
                action = tbl5.action,
                category = tbl5.category or "",
                share_user_id = fieldString(tbl5.shareUserId),
                share_user_id_required = fieldString(tbl5.shareUserIdRequired),
                description_length = fieldString(tbl5.descriptionLength),
                dismiss_method = tbl5.dismissMethod or "",
                reason = tbl5.reason or "",
                result = tbl5.result or ""
            }
        })
    end)
end

function module.logTicketResult(reason: string, tbl5)
    local var1 = tbl4[reason]
    if not var1 then
        return
    end
    local tbl6 = tbl5 or {}
    module.log({
        action = Action.TicketResult,
        result = var1,
        reason = reason,
        category = tbl6.category,
        shareUserId = tbl6.shareUserId,
        descriptionLength = tbl6.descriptionLength
    })
end

function module.logUnavailableShown(reason: string)
    if tbl4[reason] then
        return
    end

    local action = if string.sub(reason, 1, 43) == "TICKET_CREATION_ELIGIBILITY_FAILURE_REASON_" then Action.EligibilityBlocked else Action.ErrorShown
    module.log({ action = action, reason = reason })
end

function module._setServicesForTesting(arg1)
    TelemetryService = arg1
end

return module
