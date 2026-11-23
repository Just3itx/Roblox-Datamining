-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T08:51:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Players = game:GetService("Players")
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local NetworkingFriends = require(AppChat.Http.NetworkingFriends)
local NetworkingPresence = require(AppChat.Http.NetworkingPresence)
local Promise = require(AppChatParent.Promise)
local RoduxNetworking = require(AppChat.Http.RoduxNetworking)
local AddUsers = require(AppChatParent.UserLib).Actions.AddUsers
local SetUserIsFriend = require(AppChatParent.UserLib).Actions.SetUserIsFriend
local UserModel = require(AppChatParent.UserLib).Models.UserModel
local llama = require(AppChatParent.LuaSocialLibrariesDeps).llama
local receiveUsersPresence = require(AppChatParent.UserLib).Utils.receiveUsersPresence
local FFlagAppChatPresenceStoreMigration = require(AppChat.Flags.FFlagAppChatPresenceStoreMigration)

return function(bool1: boolean?)
    return function(arg1)
        local localPlayer = Players.LocalPlayer

        assert(localPlayer, "Local Player not found")
        local userId = localPlayer.UserId

        if NetworkingFriends.GetFriendsFromUserId.getStatus(arg1:getState(), userId) == RoduxNetworking.Enum.NetworkStatus.Fetching then
            return Promise.resolve({})
        end

        return arg1:dispatch(NetworkingFriends.GetFriendsFromUserId.API(userId)):andThen(function(arg2)
            local data = arg2.responseBody.data
            local var1 = arg1:getState().Users or {}

            local tbl1 = ({})

            local var2 = bool1 and {} or nil

            for _, value in ipairs(data) do
                local str1 = tostring(value.id)

                if bool1 then
                    table.insert(var2, str1)
                end

                if var1[str1] == nil then
                    tbl1[str1] = UserModel.fromDataTable({ id = value.id, name = value.name, displayName = value.displayName, isFriend = true })
                else
                    arg1:dispatch(SetUserIsFriend(str1, true))
                end
            end
            local var3 = llama.Dictionary.keys(tbl1)

            arg1:dispatch(AddUsers(tbl1))

            if not FFlagAppChatPresenceStoreMigration then
                if bool1 then
                    arg1:dispatch(NetworkingPresence.GetPresencesFromUserIds.API(var2)):andThen(function(arg3)
                        local userPresences = arg3.responseBody.userPresences
                        receiveUsersPresence(userPresences, arg1)
                        return arg3
                    end):catch(function(arg3)
                        warn("NetworkingPresence failure in getAllFriendsAsync, Status: " .. tostring(arg3))
                    end)

                    return arg2
                end

                arg1:dispatch(NetworkingPresence.GetPresencesFromUserIds.API(var3)):catch(function(arg3)
                    warn("NetworkingPresence failure in getAllFriendsAsync, Status: " .. tostring(arg3))
                end)
            end

            return arg2
        end):catch(function(arg2)
            warn("NetworkingFriends failure in getAllFriendsAsync, Status: " .. tostring(arg2))
        end)
    end
end
