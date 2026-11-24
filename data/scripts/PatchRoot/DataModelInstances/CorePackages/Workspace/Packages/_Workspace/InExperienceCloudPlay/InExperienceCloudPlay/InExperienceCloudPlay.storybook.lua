-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T18:40:46Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InExperienceCloudPlay = script:FindFirstAncestor("InExperienceCloudPlay")
local InExperienceCloudPlayParent = InExperienceCloudPlay.Parent

local Foundation = require(InExperienceCloudPlayParent.Foundation)
local React = require(InExperienceCloudPlayParent.React)
local ReactRoblox = require(InExperienceCloudPlayParent.ReactRoblox)

local ColorMode = Foundation.Enums.ColorMode
local Device = Foundation.Enums.Device
local FoundationProvider = Foundation.FoundationProvider

local tbl1 = {
    Light = ColorMode.Light,
    Dark = ColorMode.Dark
}

return {
    name = "InExperienceCloudPlay",
    roact = React,
    reactRoblox = ReactRoblox,
    mapStory = function(arg1)
        return function(arg2)
            return React.createElement(FoundationProvider, {
                colorMode = tbl1[arg2.theme],
                device = Device[arg2.platform],
                preferences = arg2.settings,
                scale = arg2.settings and arg2.settings.scale
            }, {
                Child = React.createElement(arg1, arg2)
            })
        end
    end,
    storyRoots = { InExperienceCloudPlay }
}
