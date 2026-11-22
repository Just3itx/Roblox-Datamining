-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T07:51:17Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local NavigationRodux = script:FindFirstAncestor("NavigationRodux")
local NavigationRoduxParent = NavigationRodux.Parent

local Signals = require(NavigationRoduxParent.Signals)
local RobloxAppNavigation = require(NavigationRoduxParent.RobloxAppNavigation)
local createLegacyNavigationStore = require(NavigationRodux.createLegacyNavigationStore)

return Signals.createComputed(function()
    return createLegacyNavigationStore(RobloxAppNavigation.AppNavigationRegistry.get())
end)
