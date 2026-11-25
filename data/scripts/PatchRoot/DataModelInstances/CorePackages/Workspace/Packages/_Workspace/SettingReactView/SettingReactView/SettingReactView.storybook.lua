-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T13:50:57Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SettingReactView = script:FindFirstAncestor("SettingReactView")
local SettingReactViewParent = SettingReactView.Parent
local React = require(SettingReactViewParent.React)
local ReactRoblox = require(SettingReactViewParent.ReactRoblox)
local Foundation = require(SettingReactViewParent.Foundation)
local FoundationProvider = Foundation.FoundationProvider

local tbl1 = {
    Default = Foundation.Enums.ColorMode.Dark,
    Light = Foundation.Enums.ColorMode.Light,
    Dark = Foundation.Enums.ColorMode.Dark
}

local tbl2 = { Default = "Desktop", Desktop = "Desktop", Console = "Console" }

return {
    name = SettingReactView.Name,
    storyRoot = SettingReactView,
    roact = React,
    reactRoblox = ReactRoblox,
    mapStory = function(arg1) -- name: StoryBookMapStory
        return function(arg2)
            return React.createElement(
                FoundationProvider,
                {
                    colorMode = arg2 and tbl1[arg2.theme] or tbl1.Default,
                    device = arg2 and tbl2[arg2.platform] or "Desktop"
                },
                React.createElement(arg1, arg2)
            )
        end
    end
}
