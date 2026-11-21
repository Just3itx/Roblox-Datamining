-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T07:31:19Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local _Types = require(script.Parent.Types)

local module = {}

function module.incoming(message)
    return {
        direction = "incoming",
        stableId = message.id,
        payload = { kind = "message", message = message }
    }
end

function module.sending(stableId: string, draft, author, attemptedAtUnixMilliseconds: number)
    return {
        direction = "outgoing",
        stableId = stableId,
        payload = { kind = "draft", draft = draft, author = author },
        delivery = { state = "sending", attemptedAtUnixMilliseconds = attemptedAtUnixMilliseconds }
    }
end

function module.acknowledged(arg1, message, resolvedAtUnixMilliseconds: number)
    return {
        direction = "outgoing",
        stableId = arg1.stableId,
        payload = { kind = "message", message = message },
        delivery = {
            state = "acknowledged",
            attemptedAtUnixMilliseconds = arg1.delivery.attemptedAtUnixMilliseconds,
            resolvedAtUnixMilliseconds = resolvedAtUnixMilliseconds
        }
    }
end

function module.failed(arg1, resolvedAtUnixMilliseconds: number)
    return {
        direction = "outgoing",
        stableId = arg1.stableId,
        payload = arg1.payload,
        delivery = {
            state = "failed",
            attemptedAtUnixMilliseconds = arg1.delivery.attemptedAtUnixMilliseconds,
            resolvedAtUnixMilliseconds = resolvedAtUnixMilliseconds
        }
    }
end

return module
