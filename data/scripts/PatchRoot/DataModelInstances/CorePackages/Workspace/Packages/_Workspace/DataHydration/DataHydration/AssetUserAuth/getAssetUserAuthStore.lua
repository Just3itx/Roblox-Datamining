-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T03:01:33Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DataHydrationParent = script:FindFirstAncestor("DataHydration").Parent

local Signals = require(DataHydrationParent.Signals)

local createAssetUserAuthStore = require(script.Parent.createAssetUserAuthStore)

return Signals.createComputed(function()
    return createAssetUserAuthStore()
end)
