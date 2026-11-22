-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T06:20:51Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsCommon = script:FindFirstAncestor("MomentsCommon")
local MomentsCommonParent = MomentsCommon.Parent

local Foundation = require(MomentsCommonParent.Foundation)
local React = require(MomentsCommonParent.React)
local ReactRoblox = require(MomentsCommonParent.Dev.ReactRoblox)

local tbl1 = {
    Default = Foundation.Enums.ColorMode.Dark,
    Light = Foundation.Enums.ColorMode.Light,
    Dark = Foundation.Enums.ColorMode.Dark
}

return {
    name = MomentsCommon.Name,
    roact = React,
    reactRoblox = ReactRoblox,
    storyRoot = MomentsCommon,
    mapStory = function(arg1)
        return function(arg2)
            local colorMode = arg2 and tbl1[arg2.theme] or tbl1.Default
            return React.createElement(
                Foundation.FoundationProvider,
                { colorMode = colorMode },
                {
                    Child = React.createElement(arg1, arg2)
                }
            )
        end
    end
}
