-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T12:21:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local scriptParent = script.Parent
local FFlagEnableClassicThemeHeaderBackground = require(scriptParent.SharedFlags).FFlagEnableClassicThemeHeaderBackground

return {
    AppHeaderBar = require(script.Components.AppHeaderBarResponsive),
    AppHeaderBarClassicThemeBackground = if FFlagEnableClassicThemeHeaderBackground then require(script.Components.AppHeaderBarClassicThemeBackground) else nil,
    useClassicThemeHeaderBackgroundConfig = if FFlagEnableClassicThemeHeaderBackground then require(script.Hooks.useClassicThemeHeaderBackgroundConfig) else nil,
    makeBackButton = require(script.Utils).makeBackButton,
    makeCloseButton = require(script.Utils).makeCloseButton,
    ["jest.config"] = script["jest.config"]
}
