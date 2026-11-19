-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T18:40:33Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

local React = require(CorePackages.Packages.React)
local Constants = require(CorePackages.Packages.UIBlox).App.Style.Constants
local Style = require(CorePackages.Workspace.Packages.Style)
local UiModeStyleProvider = Style.UiModeStyleProvider
local AppearanceContext = Style.AppearanceContext
local ColorMode = require(CorePackages.Packages.Foundation).Enums.ColorMode

local useIsPlaytestMode = require(script.Parent.Parent.Hooks.useIsPlaytestMode)

local function ThemeSwitcher(tbl1)
    local var1 = React.useContext(AppearanceContext)

    React.useLayoutEffect(function()
        var1.setTheme(tbl1.themeName)
    end, { tbl1.themeName, var1 })

    return React.createElement(React.Fragment, nil, tbl1.children)
end

local function PlaytestModeThemeProvider(tbl1)
    local themeName = if useIsPlaytestMode() then ColorMode.Light else ColorMode.Dark
    return React.createElement(
        UiModeStyleProvider,
        {
            style = {
                themeName = themeName,
                fontName = Constants.FontName.Gotham
            }
        },
        {
            ThemeSwitcher = React.createElement(ThemeSwitcher, { themeName = themeName }, tbl1.children)
        }
    )
end
return PlaytestModeThemeProvider
