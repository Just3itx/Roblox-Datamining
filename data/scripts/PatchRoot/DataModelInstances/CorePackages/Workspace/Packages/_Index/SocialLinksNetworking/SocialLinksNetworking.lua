-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T18:51:15Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local createRequestThunks = require(script.createRequestThunks)

return {
    ["jest.config"] = script["jest.config"],
    config = createRequestThunks
}
