-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T19:10:50Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local React = require(CorePackages.Packages.React)
local StyleProviderWithDefaultTheme = require(CorePackages.Workspace.Packages.Style).StyleProviderWithDefaultTheme

return function(arg1, arg2)
    return React.createElement(
        StyleProviderWithDefaultTheme,
        {
            withUiModeSupport = if arg2 then arg2.withUiModeSupport else false,
            withDarkTheme = not arg2 or arg2.withDarkTheme
        },
        arg1
    )
end
