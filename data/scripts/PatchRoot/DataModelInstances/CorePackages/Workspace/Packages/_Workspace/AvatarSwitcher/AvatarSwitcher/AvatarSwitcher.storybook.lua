-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T17:21:27Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarSwitcher = script:FindFirstAncestor("AvatarSwitcher")

local AvatarSwitcherParent = AvatarSwitcher.Parent
local React = require(AvatarSwitcherParent.React)
local ReactRoblox = require(AvatarSwitcherParent.ReactRoblox)

local ContextProviders = require(AvatarSwitcher.Internal.ContextProviders)

return {
    name = AvatarSwitcher.Name,
    roact = React,
    reactRoblox = ReactRoblox,
    storyRoots = { AvatarSwitcher.Components },
    mapStory = function(arg1)
        return function(arg2)
            return React.createElement(ContextProviders, { theme = arg2.theme, overlayGui = arg2.focus }, React.createElement(arg1, arg2))
        end
    end
}
