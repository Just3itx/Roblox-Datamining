-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T22:50:35Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local _AppNavItem = require(script.Components.AppNavItem)

return {
    Placement = require(script.Enum.Placement),
    AppNavBar = require(script.Components.AppNavBar),
    BottomBarInsetBackground = require(script.Components.BottomBarInsetBackground),
    StudioCTAIcon = require(script.Components.StudioCTAIcon),
    useNavBarPlacement = require(script.Hooks.useNavBarPlacement),
    useNavBarSize = require(script.Hooks.useNavBarSize),
    VisibilityControl = require(script.VisibilityControl),
    Constants = require(script.Constants),
    Mocks = require(script.Mocks),
    getScrollAwayEnabled = require(script.getScrollAwayEnabled),
    getAppNavRootName = require(script.Utils.getAppNavRootName),
    getAppNavCurrentPage = require(script.Utils.getAppNavCurrentPage),
    AppNavTelemetry = require(script.Telemetry.AppNavTelemetry),
    ["jest.config"] = script["jest.config"]
}
