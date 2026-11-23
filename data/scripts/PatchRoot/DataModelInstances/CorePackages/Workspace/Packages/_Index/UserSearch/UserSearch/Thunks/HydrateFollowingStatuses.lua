-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T03:11:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UserSearch = script:FindFirstAncestor("UserSearch")
local UserSearchParent = UserSearch.Parent

local FriendsNetworking = require(UserSearch.Networking.FriendsNetworking)
local RODUX_KEY = require(UserSearch.Common.Constants).RODUX_KEY
local getDeepValue = require(UserSearchParent.LuaSocialLibrariesDeps).SocialLibraries.config({}).Dictionary.getDeepValue

local hydrateEmptyIdsHelper = require(UserSearchParent.SocialCommon).Utils.hydrateEmptyIdsHelper

return function(ids)
    return function(arg1)
        local state = arg1:getState() or {}
        local deepValue = getDeepValue(state, string.format("%s.Friends.followings.followingStatuses", RODUX_KEY)) or {}

        return hydrateEmptyIdsHelper({
            ids = ids,
            selector = function(arg2)
                return deepValue[arg2]
            end,
            hydrate = function(targetUserIds)
                return arg1:dispatch(FriendsNetworking.GetFollowingExists.API({ targetUserIds = targetUserIds }))
            end
        })
    end
end
