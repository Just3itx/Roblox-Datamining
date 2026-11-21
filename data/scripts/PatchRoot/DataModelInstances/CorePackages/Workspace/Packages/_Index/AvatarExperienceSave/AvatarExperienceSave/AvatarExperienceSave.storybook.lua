-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T04:21:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceSaveParent = script:FindFirstAncestor("AvatarExperienceSave").Parent
local React = require(AvatarExperienceSaveParent.React)
local Foundation = require(AvatarExperienceSaveParent.Foundation)
local FoundationProvider = Foundation.FoundationProvider
local ColorMode = Foundation.Enums.ColorMode
local Device = Foundation.Enums.Device
local ReactRoblox = require(AvatarExperienceSaveParent.Dev.ReactRoblox)

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
    name = "AvatarExperienceSave",
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
                    FoundationProvider = React.createElement(
                        FoundationProvider,
                        {
                            styleTable = styleTable,
                            colorMode = colorMode,
                            device = tbl2[arg2.platform],
                            DONOTUSE_colorUpdate = true
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
