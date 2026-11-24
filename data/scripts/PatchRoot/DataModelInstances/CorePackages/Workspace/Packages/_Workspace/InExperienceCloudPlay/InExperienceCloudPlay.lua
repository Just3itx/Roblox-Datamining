-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T18:31:35Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local UnsuccessfulJoin = require(script.UnsuccessfulJoin)

return {
    markUnsuccessfulJoin = UnsuccessfulJoin.markUnsuccessfulJoin,
    consumeUnsuccessfulJoin = UnsuccessfulJoin.consumeUnsuccessfulJoin,
    mountCloudPlayUIOverlay = require(script.mountCloudPlayUIOverlay),
    ["jest.config"] = script["jest.config"]
}
