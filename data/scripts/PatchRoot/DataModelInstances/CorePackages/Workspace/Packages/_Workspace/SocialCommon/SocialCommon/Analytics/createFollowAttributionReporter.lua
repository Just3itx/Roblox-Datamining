-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T15:11:08Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local tbl1 = {
    eventName = "followSuccess",
    backends = { "EventIngest" },
    throttlingPercentage = 10000,
    lastUpdated = { 2026, 11, 5 },
    description = "Fires after a user successfully follows another user"
}

local function createFollowAttributionReporter(callback: (...any) -> (...any))
    return function(tbl2)
        callback(tbl1, {
            eventContext = "SocialFollow",
            standardizedFields = { "addSessionInfo", "addSessionId", "addOSInfo" },
            customFields = {
                surface = tbl2.surface,
                source = tbl2.source or tbl2.surface
            }
        })
    end
end

return createFollowAttributionReporter
