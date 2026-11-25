-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T11:11:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SduiSharedContentParent = script:FindFirstAncestor("SduiSharedContent").Parent
local React = require(SduiSharedContentParent.React)
local Foundation = require(SduiSharedContentParent.Foundation)
local FoundationProvider = Foundation.FoundationProvider
local ColorMode = Foundation.Enums.ColorMode
local Device = Foundation.Enums.Device
local ReactRoblox = require(SduiSharedContentParent.Dev.ReactRoblox)

local tbl1 = {
    Light = ColorMode.Light,
    Dark = ColorMode.Dark
}

return {
    name = "SduiSharedContent",
    roact = React,
    reactRoblox = ReactRoblox,
    mapStory = function(arg1)
        return function(arg2)
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
                    FoundationContext = React.createElement(FoundationProvider, {
                        colorMode = tbl1[arg2.theme],
                        device = Device[arg2.platform],
                        preferences = arg2.settings,
                        scale = arg2.settings and arg2.settings.scale
                    }, {
                        Child = React.createElement(arg1, arg2)
                    })
                }
            )
        end
    end
}
