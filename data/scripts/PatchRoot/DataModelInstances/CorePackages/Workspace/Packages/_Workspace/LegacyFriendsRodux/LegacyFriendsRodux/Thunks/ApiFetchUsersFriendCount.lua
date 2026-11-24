-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T23:31:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local LegacyFriendsRodux = script:FindFirstAncestor("LegacyFriendsRodux")
local LegacyFriendsRoduxParent = LegacyFriendsRodux.Parent

local UsersGetFriendCount = require(LegacyFriendsRodux.Requests).UsersGetFriendCount
local SetFriendCount = require(LegacyFriendsRodux.Actions).SetFriendCount

local isNewFriendsEndpointsEnabled = require(LegacyFriendsRoduxParent.SharedFlags).isNewFriendsEndpointsEnabled
local FFlagRemoveUnusedFriendCountRoduxSlice = require(LegacyFriendsRoduxParent.SharedFlags).FFlagRemoveUnusedFriendCountRoduxSlice

return function(arg1)
    return function(arg2)
        return UsersGetFriendCount(arg1):andThen(function(arg3)
            local responseBody = arg3.responseBody

            if not FFlagRemoveUnusedFriendCountRoduxSlice then
                if isNewFriendsEndpointsEnabled() then
                    if responseBody.count then
                        arg2:dispatch(SetFriendCount(responseBody.count))
                    end
                elseif responseBody.success and responseBody.count then
                    arg2:dispatch(SetFriendCount(responseBody.count))
                end
            end

            return responseBody.count
        end)
    end
end
