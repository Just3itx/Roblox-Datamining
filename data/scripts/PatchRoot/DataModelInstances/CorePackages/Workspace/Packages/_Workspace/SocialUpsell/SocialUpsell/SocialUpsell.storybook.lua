-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T16:40:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialUpsell = script:FindFirstAncestor("SocialUpsell")

local SocialUpsellParent = SocialUpsell.Parent
local React = require(SocialUpsellParent.React)
local ReactRoblox = require(SocialUpsellParent.ReactRoblox)
local FoundationProvider = require(SocialUpsellParent.Foundation).FoundationProvider

return {
    name = SocialUpsell.Name,
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
    storyRoots = { SocialUpsell }
}
