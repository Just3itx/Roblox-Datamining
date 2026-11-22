-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T17:01:14Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local _mapCallCard = require(script.Parent.mapCallCard)

return {
    applyCallCardRefresh = function(tbl1, tbl2)
        local callCard = tbl2.callCard
        return {
            callId = tbl1.callId,
            isInitiator = tbl1.isInitiator,
            status = string.lower(callCard.status),
            durationSeconds = callCard.duration_seconds,
            enableJoin = callCard.enable_join
        }
    end,
    parseMessageCard = function(tbl1)
        return {
            callId = tbl1.call_id,
            isInitiator = tbl1.is_initiator,
            status = tbl1.status,
            durationSeconds = tbl1.duration_seconds,
            enableJoin = tbl1.enable_join
        }
    end
}
