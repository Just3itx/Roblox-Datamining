-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T03:01:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceControlBarParent = script:FindFirstAncestor("AvatarExperienceControlBar").Parent
local React = require(AvatarExperienceControlBarParent.React)
local Foundation = require(AvatarExperienceControlBarParent.Foundation)
local FoundationProvider = Foundation.FoundationProvider
local LocalizationProvider = require(AvatarExperienceControlBarParent.Localization).LocalizationProvider
local Localization = require(AvatarExperienceControlBarParent.Dev.AppLocales).Localization
local ColorMode = Foundation.Enums.ColorMode
local Device = Foundation.Enums.Device
local ReactRoblox = require(AvatarExperienceControlBarParent.Dev.ReactRoblox)

local tbl1 = {
    Light = ColorMode.Light,
    Dark = ColorMode.Dark
}

local tbl2 = {
    Console = Device.Console,
    Desktop = Device.Desktop
}

local styleTable = {
    Default = { themeName = "Dark", fontName = "Gotham" },
    Light = { themeName = "Light", fontName = "Gotham" },
    Dark = { themeName = "Dark", fontName = "Gotham" }
}

return {
    name = "AvatarExperienceControlBar",
    roact = React,
    reactRoblox = ReactRoblox,
    mapStory = function(arg1)
        return function(arg2)
            local colorMode = tbl1[arg2.theme]

            return React.createElement(
                "Frame",
                {
                    AutomaticSize = Enum.AutomaticSize.Y,
                    Size = UDim2.fromScale(1, 0),
                    BackgroundTransparency = 1
                },
                {
                    UIPadding = React.createElement("UIPadding", {
                        PaddingTop = UDim.new(0, 10),
                        PaddingBottom = UDim.new(0, 10),
                        PaddingLeft = UDim.new(0, 10),
                        PaddingRight = UDim.new(0, 10)
                    }),
                    LocalizationProvider = React.createElement(LocalizationProvider, {
                        localization = Localization.new("en-us")
                    }, {
                        FoundationProvider = React.createElement(FoundationProvider, {
                            styleTable = styleTable,
                            colorMode = colorMode,
                            device = tbl2[arg2.platform],
                            preferences = arg2.settings,
                            DONOTUSE_colorUpdate = true
                        }, {
                            Child = React.createElement(arg1, arg2)
                        })
                    })
                }
            )
        end
    end
}
