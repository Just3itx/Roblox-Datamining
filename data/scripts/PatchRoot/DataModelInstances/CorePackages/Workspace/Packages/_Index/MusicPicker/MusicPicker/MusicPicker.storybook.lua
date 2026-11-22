-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T07:50:59Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MusicPicker = script:FindFirstAncestor("MusicPicker")
local MusicPickerParent = MusicPicker.Parent

local Foundation = require(MusicPickerParent.Foundation)
local React = require(MusicPickerParent.React)
local ReactRoblox = require(MusicPickerParent.Dev.ReactRoblox)

local ColorMode = Foundation.Enums.ColorMode
local Device = Foundation.Enums.Device
local FoundationProvider = Foundation.FoundationProvider

local tbl1 = {
    Dark = ColorMode.Dark,
    Light = ColorMode.Light
}

return {
    name = "MusicPicker",
    roact = React,
    reactRoblox = ReactRoblox,
    mapStory = function(arg1)
        return function(arg2)
            return React.createElement(FoundationProvider, {
                colorMode = tbl1[arg2.theme] or ColorMode.Dark,
                device = Device[arg2.platform] or Device.Phone,
                preferences = arg2.settings,
                scale = arg2.settings and arg2.settings.scale
            }, {
                Child = React.createElement(arg1, arg2)
            })
        end
    end,
    storyRoots = { MusicPicker }
}
