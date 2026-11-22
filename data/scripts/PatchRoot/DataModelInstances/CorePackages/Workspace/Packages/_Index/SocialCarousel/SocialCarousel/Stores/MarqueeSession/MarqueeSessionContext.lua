-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T18:11:07Z
-- Luau bytecode version: 14 | Luau type version: 3
local SocialCarouselParent = script:FindFirstAncestor("SocialCarousel").Parent

local React = require(SocialCarouselParent.React)

local _createMarqueeSessionStore = require(script.Parent.createMarqueeSessionStore)

return {
    MarqueeSessionContext = React.createContext(nil)
}
