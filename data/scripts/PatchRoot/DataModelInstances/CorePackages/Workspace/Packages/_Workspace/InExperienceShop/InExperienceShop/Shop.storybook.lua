-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T20:50:49Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InExperienceShop = script:FindFirstAncestor("InExperienceShop")

local InExperienceShopParent = InExperienceShop.Parent
local React = require(InExperienceShopParent.React)
local ReactRoblox = require(InExperienceShopParent.ReactRoblox)

local ContextProviders = require(InExperienceShop.Internal.ContextProviders)

return {
    name = InExperienceShop.Name,
    roact = React,
    reactRoblox = ReactRoblox,
    storyRoots = { InExperienceShop.Components },
    mapStory = function(arg1)
        return function(arg2)
            return React.createElement(ContextProviders, { theme = arg2.theme, overlayGui = arg2.focus }, React.createElement(arg1, arg2))
        end
    end
}
