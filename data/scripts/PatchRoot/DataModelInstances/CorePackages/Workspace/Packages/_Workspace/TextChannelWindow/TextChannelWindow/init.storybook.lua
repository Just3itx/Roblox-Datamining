-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T19:00:57Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local TextChannelWindow = script:FindFirstAncestor("TextChannelWindow")

local TextChannelWindowParent = TextChannelWindow.Parent
local React = require(TextChannelWindowParent.React)
local ReactRoblox = require(TextChannelWindowParent.ReactRoblox)
local FoundationProvider = require(TextChannelWindowParent.Foundation).FoundationProvider

return {
    name = TextChannelWindow.Name,
    roact = React,
    reactRoblox = ReactRoblox,
    storyRoots = { TextChannelWindow },
    mapStory = function(arg1)
        return function(arg2)
            return React.createElement(
                FoundationProvider,
                {
                    colorMode = arg2 and arg2.theme,
                    device = arg2 and arg2.platform
                },
                React.createElement(arg1, arg2)
            )
        end
    end
}
