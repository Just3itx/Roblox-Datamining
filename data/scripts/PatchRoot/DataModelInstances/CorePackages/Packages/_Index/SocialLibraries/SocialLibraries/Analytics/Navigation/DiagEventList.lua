-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T15:41:08Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local EventNames = require(script.Parent.EventNames)
local _Types = require(script.Parent.Parent.FireEvent.Types)

return {
    [EventNames.HomePage_AddFriends] = {
        name = game:DefineFastString("SocialNavigationHomePageAddFriends", "HomePageAddFriends")
    },
    [EventNames.HomePage_Carousel_LuaProfile] = {
        name = game:DefineFastString("SocialNavigationHomePageCarouselLuaProfile", "LuaProfileEntryHomePageFriendsCarousel")
    },
    [EventNames.HomePage_Carousel_FriendsLanding] = {
        name = game:DefineFastString("SocialNavigationHomePageFriendsLanding", "HomePageNavigationFriendsLanding")
    },
    [EventNames.MorePage_FriendsLanding] = {
        name = game:DefineFastString("SocialNavigationMorePageFriendsLanding", "MorePageNavigationFriendsLanding")
    }
}
