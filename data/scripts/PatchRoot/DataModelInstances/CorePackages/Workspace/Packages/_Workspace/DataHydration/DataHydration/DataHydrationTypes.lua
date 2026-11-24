-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T03:41:08Z
-- Luau bytecode version: 14 | Luau type version: 3
local DataHydrationParent = script:FindFirstAncestor("DataHydration").Parent
local _Signals = require(DataHydrationParent.Signals)

return {
    DataStatus = { NotReady = "NotReady", Ready = "Ready", Failed = "Failed" }
}
