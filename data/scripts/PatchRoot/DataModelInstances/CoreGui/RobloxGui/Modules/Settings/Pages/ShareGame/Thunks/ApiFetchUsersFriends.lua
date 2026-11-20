-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T00:31:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

local Requests = require(CorePackages.Workspace.Packages.Http).Requests

local Promise = require(CorePackages.Packages.Promise)
local ApiFetchUsersPresences = require(CorePackages.Workspace.Packages.UserLib).Thunks.ApiFetchUsersPresences
local DEPRECATED_UsersGetFriends = Requests.DEPRECATED_UsersGetFriends
local FetchUserFriendsStarted = require(CorePackages.Workspace.Packages.LegacyFriendsRodux).Actions.FetchUserFriendsStarted
local FetchUserFriendsFailed = require(CorePackages.Workspace.Packages.LegacyFriendsRodux).Actions.FetchUserFriendsFailed
local FetchUserFriendsCompleted = require(CorePackages.Workspace.Packages.LegacyFriendsRodux).Actions.FetchUserFriendsCompleted
local UserModel = require(CorePackages.Workspace.Packages.UserLib).Models.UserModel
local UpdateUsers = require(CorePackages.Workspace.Packages.UserLib).Thunks.UpdateUsers

local GetFFlagInviteListRerank = require(CorePackages.Workspace.Packages.SharedFlags).GetFFlagInviteListRerank

return function(arg1, arg2, _, arg3)
    return function(arg4)
        arg4:dispatch(FetchUserFriendsStarted(arg2))

        return DEPRECATED_UsersGetFriends(arg1, arg2, arg3):andThen(function(arg5): {string}
            local responseBody = arg5.responseBody

            local result = {}
            local tbl1 = {}
            for friendRank, value in pairs(responseBody.data) do
                local str1 = tostring(value.id)
                value.isFriend = true

                if GetFFlagInviteListRerank() then
                    value.friendRank = friendRank
                end

                local dataTable = UserModel.fromDataTable(value)

                table.insert(result, str1)
                tbl1[dataTable.id] = dataTable
            end
            arg4:dispatch(UpdateUsers(tbl1))

            return result
        end):andThen(function(arg5)
            return arg4:dispatch(ApiFetchUsersPresences(arg1, arg5))
        end):andThen(function(arg5)
            arg4:dispatch(FetchUserFriendsCompleted(arg2))

            return Promise.resolve(arg5)
        end, function(arg5)
            arg4:dispatch(FetchUserFriendsFailed(arg2, arg5))
            return Promise.reject(arg5)
        end)
    end
end
