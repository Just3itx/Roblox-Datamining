-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T23:31:27Z
-- Luau bytecode version: 14 | Luau type version: 3
local ThemeBackgroundParent = script:FindFirstAncestor("ThemeBackground").Parent

local Signals = require(ThemeBackgroundParent.Signals)

local createThemeBackgroundStore = require(script.createThemeBackgroundStore)

return Signals.createComputed(createThemeBackgroundStore)
