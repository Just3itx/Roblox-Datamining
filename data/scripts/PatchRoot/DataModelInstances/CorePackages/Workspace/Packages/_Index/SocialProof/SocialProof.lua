-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T19:10:37Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local installReducer = require(script.Rodux.installReducer)
local Chips = require(script.Containers.Chips)
local UserLists = require(script.Containers.UserLists)

return {
    ["jest.config"] = script["jest.config"],
    RoduxKey = require(script.Common.Constants).RODUX_KEY,
    installReducer = installReducer,
    Chips = Chips,
    UserLists = UserLists
}
