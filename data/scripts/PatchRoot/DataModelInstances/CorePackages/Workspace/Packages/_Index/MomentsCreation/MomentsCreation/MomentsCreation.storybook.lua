-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T07:30:34Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsCreation = script:FindFirstAncestor("MomentsCreation")
local MomentsCreationParent = MomentsCreation.Parent

local Foundation = require(MomentsCreationParent.Foundation)
local React = require(MomentsCreationParent.React)
local ReactRoblox = require(MomentsCreationParent.Dev.ReactRoblox)

local ColorMode = Foundation.Enums.ColorMode
local Device = Foundation.Enums.Device
local FoundationProvider = Foundation.FoundationProvider

local tbl1 = {
    Dark = ColorMode.Dark,
    Light = ColorMode.Light
}

return {
    name = "MomentsCreation",
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
    storyRoots = { MomentsCreation }
}
