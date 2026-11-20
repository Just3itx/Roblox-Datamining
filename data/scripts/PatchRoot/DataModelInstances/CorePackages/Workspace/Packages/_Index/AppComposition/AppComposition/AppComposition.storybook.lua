-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T22:31:26Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppComposition = script:FindFirstAncestor("AppComposition")

local AppCompositionParent = AppComposition.Parent
local React = require(AppCompositionParent.React)
local Foundation = require(AppCompositionParent.Foundation)
local ReactRoblox = require(AppCompositionParent.Dev.ReactRoblox)

local FoundationProvider = Foundation.FoundationProvider

return {
    name = AppComposition.Name,
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
    storyRoots = { AppComposition }
}
