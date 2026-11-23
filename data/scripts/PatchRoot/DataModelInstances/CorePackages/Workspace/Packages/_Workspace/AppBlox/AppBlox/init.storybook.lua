-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T06:21:25Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppBlox = script:FindFirstAncestor("AppBlox")

local AppBloxParent = AppBlox.Parent
local React = require(AppBloxParent.React)
local Foundation = require(AppBloxParent.Foundation)
local ReactRoblox = require(AppBloxParent.Dev.ReactRoblox)

local FoundationProvider = Foundation.FoundationProvider

return {
    name = AppBlox.Name,
    roact = React,
    reactRoblox = ReactRoblox,
    mapStory = function(arg1)
        return function(arg2)
            return React.createElement(
                FoundationProvider,
                {
                    colorMode = arg2.theme,
                    device = arg2.platform
                },
                React.createElement(arg1, arg2)
            )
        end
    end,
    storyRoots = { AppBlox }
}
