-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T14:10:50Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FriendsCarouselParent = script:FindFirstAncestor("FriendsCarousel").Parent

local DiagEventTypes = require(FriendsCarouselParent.SocialLuaAnalytics).Analytics.Enums.DiagEventTypes

local EventNames = require(script.Parent.EventNames)
local FetchNames = require(script.Parent.FetchNames)

local tbl1 = {
    Done = game:DefineFastString("AllFriendsCarouselLoadingTimeDoneStats", "AllFriendsCarouselLoadingTimeDone"),
    Failed = game:DefineFastString("AllFriendsCarouselLoadingTimeFailedStats", "AllFriendsCarouselLoadingTimeFailed")
}

local tbl2 = {
    Done = game:DefineFastString("AllFriendsNextPageCarouselLoadingTimeDoneStats", "AllFriendsNextPageCarouselLoadingTimeDone"),
    Failed = game:DefineFastString("AllFriendsNextPageCarouselLoadingTimeFailedStats", "AllFriendsNextPageCarouselLoadingTimeFailed")
}

local tbl3 = {
    Done = game:DefineFastString("OnlineFriendsCarouselLoadingTimeDoneStats", "OnlineFriendsCarouselLoadingTimeDone"),
    Failed = game:DefineFastString("OnlineFriendsCarouselLoadingTimeFailedStats", "OnlineFriendsCarouselLoadingTimeFailed")
}

local tbl4 = {
    Done = game:DefineFastString("OldAllFriendsCarouselLoadingTimeDoneStats", "OldAllFriendsCarouselLoadingTimeDone"),
    Failed = game:DefineFastString("OldAllFriendsCarouselLoadingTimeFailedStats", "OldAllFriendsCarouselLoadingTimeFailed")
}

local str1 = game:DefineFastString("FriendsCarouselUILoadingTimeStats", "FriendsCarouselUILoadingTime")

local name = game:DefineFastString("OnlineFriendsRefetchOnPresenceUpdateCounter", "OnlineFriendsRefetchOnPresenceUpdate")

local str2 = game:DefineFastString("OnlineFriendsRefetchOnFriendshipUpdateCounter", "OnlineFriendsRefetchOnFriendshipUpdate")

return {
    [EventNames.CarouselLoadedWithUsers] = {
        name = game:DefineFastString("FriendsCarouselLoadedWithUsers", "FriendsCarouselLoadedWithUsers")
    },
    [EventNames.UserPressed] = {
        name = game:DefineFastString("FriendsCarouselUserPressed", "FriendsCarouselUserPressed")
    },
    [EventNames.RequestFriendship] = {
        name = game:DefineFastString("FriendsCarouselRequestFriendship", "FriendsCarouselRequestFriendship")
    },
    [EventNames.RevokeFriendRequest] = {
        name = game:DefineFastString("FriendsCarouselRevokeFriendRequest", "FriendsCarouselRevokeFriendRequest")
    },
    [EventNames.ViewAllFriends] = {
        name = game:DefineFastString("HomePageNavigationViewAllFriends", "HomePageNavigationFriendsLanding")
    },
    [EventNames.ViewAddFriends] = {
        name = game:DefineFastString("HomePageNavigationViewAddFriends", "AddFriendsHomeEntry")
    },
    [EventNames.PaginatedFriendsCarouselLoadingTime] = {
        type = DiagEventTypes.Stats,
        name = function(arg1)
            if arg1.fetch == FetchNames.AllFriends then
                if arg1.nextPage then
                    return tbl2[arg1.status]
                end

                return tbl1[arg1.status]
            end

            return tbl3[arg1.status]
        end,
        stats = function(arg1)
            return arg1.loadingTime or 0
        end
    },
    [EventNames.FriendsEndpointLoadingTime] = {
        type = DiagEventTypes.Stats,
        name = function(arg1)
            return tbl4[arg1.status]
        end,
        stats = function(arg1)
            return arg1.loadingTime or 0
        end
    },
    [EventNames.FriendsCarouselUILoadingTime] = {
        type = DiagEventTypes.Stats,
        name = function(arg1): string
            return `{str1}_{arg1.fetch}`
        end,
        stats = function(arg1)
            return arg1.loadingTime or 0
        end
    },
    [EventNames.OnlineFriendsRefetchOnPresenceUpdate] = {
        type = DiagEventTypes.Counter,
        name = name
    },
    [EventNames.OnlineFriendsRefetchOnFriendshipUpdate] = {
        type = DiagEventTypes.Counter,
        name = str2
    }
}
