-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T14:11:17Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local bool1 = game:DefineFastFlag("FriendCarouselHas10ftPolicies", false)

local FriendsCarousel = script:FindFirstAncestor("FriendsCarousel")
local isTenFootInterface = require(FriendsCarousel.Parent.AppCommonLib).isTenFootInterface
return function()
    if bool1 then
        return isTenFootInterface()
    end

    return false
end
