-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T10:21:04Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local React = require(Foundation.Parent.React)

local ColorMode = require(Foundation.Enums.ColorMode)

local Foundation2 = require(Foundation.Providers.Foundation)
local _PreferencesProvider = require(Foundation.Providers.Preferences.PreferencesProvider)
local View = require(Foundation.Components.View)

return function(arg1, preferences, colorMode)
    return React.createElement(
        Foundation2,
        {
            colorMode = colorMode or ColorMode.Dark,
            preferences = preferences
        },
        {
            Content = React.createElement(View, { Size = UDim2.fromScale(1, 1) }, arg1)
        }
    )
end
