-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T03:40:59Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function makeMomentsPlayFields(tbl1)
    return {
        client_event_timestamp_ms = tbl1.clientEventTimestampMs,
        feedItemId = tbl1.feedItemId,
        momentsPlayIntentId = tbl1.momentsPlayIntentId,
        viewId = tbl1.viewId
    }
end

return makeMomentsPlayFields
