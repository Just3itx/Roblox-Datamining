-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T23:00:59Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

local React = require(CorePackages.Packages.React)
local ReactRoblox = require(CorePackages.Packages.ReactRoblox)
local UIBlox = require(CorePackages.Packages.UIBlox)
local Foundation = require(CorePackages.Packages.Foundation)

local AppStyleProvider = UIBlox.App.Style.AppStyleProvider
local FoundationProvider = Foundation.FoundationProvider
local ColorMode = Foundation.Enums.ColorMode

return {
    name = "PlayerList (legacy)",
    storyRoot = script.Parent,
    roact = React,
    reactRoblox = ReactRoblox,
    mapStory = function(arg1)
        return function(arg2)
            local settings = arg2.settings
            return React.createElement(
                FoundationProvider,
                {
                    colorMode = ColorMode.Dark,
                    preferences = settings,
                    scale = if settings then settings.scale else nil
                },
                {
                    Style = React.createElement(
                        AppStyleProvider,
                        {
                            style = { themeName = "Dark", fontName = "Gotham", settings = settings }
                        },
                        {
                            Child = React.createElement(arg1, arg2)
                        }
                    )
                }
            )
        end
    end
}
