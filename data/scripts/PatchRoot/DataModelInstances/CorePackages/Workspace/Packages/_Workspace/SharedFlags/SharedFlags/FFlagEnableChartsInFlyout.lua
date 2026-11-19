-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T13:21:14Z
-- Luau bytecode version: 14 | Luau type version: 3
local FFlagAppIaHomeSubTab = require(script.Parent.FFlagAppIaHomeSubTab)
local bool1 = game:DefineFastFlag("ChartsInFlyoutAddSubTabDependency", false)

return game:DefineFastFlag("EnableChartsInFlyout", false) and (not bool1 or FFlagAppIaHomeSubTab)
