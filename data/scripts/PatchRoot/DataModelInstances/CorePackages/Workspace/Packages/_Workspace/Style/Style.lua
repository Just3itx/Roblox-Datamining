-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T18:21:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local scriptParent = script.Parent
local UIBlox = require(scriptParent.UIBlox)
local StyleProviderWithDefaultTheme = require(script.StyleProviderWithDefaultTheme)
local FFlagAppNavBarPerItemThemeOverride = require(scriptParent.SharedFlags).FFlagAppNavBarPerItemThemeOverride

local DesignTokens = require(script.DesignTokens)
local UiModeStyleProvider = require(script.UiModeStyleProvider)
local AppFoundationThemeName = require(script.AppFoundationThemeName)
local FFlagAppClassicThemeGreenButtonColors = require(script.FFlagAppClassicThemeGreenButtonColors)
local getClassicThemeTokenOverrides = require(script.getClassicThemeTokenOverrides)

return {
    AppStyleProvider = UIBlox.App.Style.AppStyleProvider,
    Colors = require(script.Colors),
    Constants = UIBlox.App.Style.Constants,
    Themes = {
        DarkTheme = UIBlox.App.Style.Themes.DarkTheme,
        LightTheme = UIBlox.App.Style.Themes.LightTheme
    },
    DesignTokenProvider = DesignTokens.DesignTokenProvider,
    UiModeStyleProvider = UiModeStyleProvider,
    useDesignTokens = DesignTokens.useDesignTokens,
    mapTypographyVariantToFontEnum = DesignTokens.mapTypographyVariantToFontEnum,
    GetTextSize = require(script.Utils.GetTextSize),
    StyleProviderWithDefaultTheme = StyleProviderWithDefaultTheme,
    AppFoundationThemeName = AppFoundationThemeName,
    FFlagAppClassicThemeGreenButtonColors = FFlagAppClassicThemeGreenButtonColors,
    getClassicThemeTokenOverrides = getClassicThemeTokenOverrides,
    AppFonts = require(script.AppFonts),
    AppearanceContext = require(script.AppearanceContext),
    UiModeBrandThemeContext = if FFlagAppNavBarPerItemThemeOverride then require(script.UiModeBrandThemeContext) else nil,
    getSceneOverridesStore = require(script.getSceneOverridesStore),
    ["jest.config"] = script["jest.config"]
}
