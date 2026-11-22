-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T18:01:23Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialCarouselParent = script:FindFirstAncestor("SocialCarousel").Parent
local SocialCarouselContext = require(script.Parent.SocialCarouselContext)
local React = require(SocialCarouselParent.React)

return function()
    return React.useContext(SocialCarouselContext)
end
