-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T17:40:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarWorkshop = script:FindFirstAncestor("AvatarWorkshop")

local AvatarWorkshopParent = AvatarWorkshop.Parent
local React = require(AvatarWorkshopParent.React)
local ReactRoblox = require(AvatarWorkshopParent.ReactRoblox)

local ContextProviders = require(AvatarWorkshop.Internal.ContextProviders)

return {
    name = AvatarWorkshop.Name,
    roact = React,
    reactRoblox = ReactRoblox,
    storyRoots = { AvatarWorkshop },
    mapStory = function(arg1)
        return function(arg2)
            return React.createElement(ContextProviders, { theme = arg2.theme, overlayGui = arg2.focus }, React.createElement(arg1, arg2))
        end
    end
}
