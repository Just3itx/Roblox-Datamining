-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T06:00:58Z
-- Luau bytecode version: 14 | Luau type version: 3
local BuyRobuxRoutingParent = script:FindFirstAncestor("BuyRobuxRouting").Parent

return {
    displayName = "BuyRobuxRouting",
    setupFilesAfterEnv = { require(BuyRobuxRoutingParent.Dev.JestConfigs).setupFiles.LogHandler }
}
