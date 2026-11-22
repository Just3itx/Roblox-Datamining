-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T13:21:11Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local scriptParentParentParent = scriptParentParent.Parent

local dependencies = require(scriptParentParent.dependencies)
local EventNames = require(script.Parent.EventNames)
local SocialLuaAnalytics = require(scriptParentParentParent.SocialLuaAnalytics)
local DiagEventTypes = SocialLuaAnalytics.Analytics.Enums.DiagEventTypes

local getFFlagPYMKAddFriendsEntry = dependencies.getFFlagPYMKAddFriendsEntry

local tbl1 = {
    [EventNames.CarouselLoadedWithUsers] = {
        name = game:DefineFastString("PYMKCarouselLoadedWithUsers", "PYMKCarouselLoadedWithUsers")
    },
    [EventNames.UserPressed] = {
        name = game:DefineFastString("PYMKCarouselUserPressed", "PYMKCarouselUserPressed")
    },
    [EventNames.RequestFriendship] = {
        name = game:DefineFastString("PYMKCarouselRequestFriendship", "PYMKCarouselRequestFriendship")
    },
    [EventNames.PYMKCarouselLoadingTime] = {
        type = DiagEventTypes.Stats,
        name = EventNames.PYMKCarouselLoadingTime.rawValue(),
        stats = function(arg1)
            return arg1.loadingTime or 0
        end,
        platformSpecificity = SocialLuaAnalytics.Analytics.Enums.PlatformSpecificity.BucketsOnly
    }
}

if getFFlagPYMKAddFriendsEntry() then
    tbl1[EventNames.CarouselGenericTileClicked] = {
        name = game:DefineFastString("PYMKCarouselGenericTileClicked", "PYMKCarouselGenericTileClicked")
    }
end

return tbl1
