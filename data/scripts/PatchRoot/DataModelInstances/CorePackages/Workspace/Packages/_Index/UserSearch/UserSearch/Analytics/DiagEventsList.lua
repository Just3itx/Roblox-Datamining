-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T03:00:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UserSearchParent = script:FindFirstAncestor("UserSearch").Parent

local SocialLuaAnalytics = require(UserSearchParent.SocialLuaAnalytics)
local DiagEventTypes = SocialLuaAnalytics.Analytics.Enums.DiagEventTypes

local EventNames = require(script.Parent.EventNames)

local tbl1 = {
    Done = game:DefineFastString("UserSearchLoadingTimeDoneStats", "UserSearchLoadingTimeDone"),
    Failed = game:DefineFastString("UserSearchLoadingTimeFailedStats", "UserSearchLoadingTimeFailed")
}

local tbl2 = {
    Done = game:DefineFastString("UserSearchLoadingTimeNextPageDoneStats", "UserSearchLoadingTimeNextPageDone"),
    Failed = game:DefineFastString("UserSearchLoadingTimeNextPageFailedStats", "UserSearchLoadingTimeNextPageFailed")
}

local tbl3 = { Done = "UserSearchLoadedDone", Failed = "UserSearchLoadedFailed" }

local tbl4 = { Done = "UserSearchLoadedNextPageDone", Failed = "UserSearchLoadedNextPageFailed" }

return {
    [EventNames.PlayerFriendRequest] = {
        type = DiagEventTypes.Counter,
        name = game:DefineFastString("UserSearchPlayerFriendRequestCounter", "UserSearchPlayerFriendRequest")
    },
    [EventNames.PlayerFriendAccept] = {
        type = DiagEventTypes.Counter,
        name = game:DefineFastString("UserSearchPlayerFriendAcceptCounter", "UserSearchPlayerFriendAccept")
    },
    [EventNames.PlayerTileClick] = {
        type = DiagEventTypes.Counter,
        name = game:DefineFastString("UserSearchPlayerTileClickCounter", "UserSearchPlayerTileClick")
    },
    [EventNames.PlayerTileImpressions] = {
        type = DiagEventTypes.Counter,
        name = game:DefineFastString("UserSearchPlayerTileImpressionsCounter", "UserSearchPlayerTileImpressions"),
        count = function(arg1): number
            return if arg1 and arg1.playerId then #arg1.playerId else 0
        end
    },
    [EventNames.UserSearchLoadingTime] = {
        type = DiagEventTypes.Stats,
        name = function(arg1)
            return if arg1.nextPage then tbl2[arg1.status] else tbl1[arg1.status]
        end,
        stats = function(arg1)
            return arg1.loadingTime or 0
        end
    },
    [EventNames.UserSearchLoaded] = {
        type = DiagEventTypes.Counter,
        name = function(arg1)
            return if arg1.nextPage then tbl4[arg1.status] else tbl3[arg1.status]
        end,
        platformSpecificity = SocialLuaAnalytics.Analytics.Enums.PlatformSpecificity.BucketsOnly
    }
}
