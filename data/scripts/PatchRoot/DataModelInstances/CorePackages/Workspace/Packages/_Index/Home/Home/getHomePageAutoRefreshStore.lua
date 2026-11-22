-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T00:21:24Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Home = script:FindFirstAncestor("Home")
local HomeParent = Home.Parent

local Signals = require(HomeParent.Signals)
local createHomePageAutoRefreshStore = require(Home.createHomePageAutoRefreshStore)

return Signals.createComputed(function()
    return createHomePageAutoRefreshStore()
end)
