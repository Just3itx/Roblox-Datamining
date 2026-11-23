-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T03:11:27Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local UserSignalTypes = require(script.UserSignalTypes)

return {
    PostSendUserSignal = require(script.PostSendUserSignal),
    UserSignalTypes = UserSignalTypes,
    ["jest.config"] = script["jest.config"]
}
