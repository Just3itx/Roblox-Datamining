-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T07:01:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UserService = game:GetService("UserService")
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local AppChatNetworking = require(AppChatParent.AppChatNetworking)
local Promise = require(AppChatParent.Promise)
local UserLib = require(AppChatParent.UserLib)

local USER_CAROUSEL_HEAD_SHOT = UserLib.Utils.AvatarThumbnailRequests.USER_CAROUSEL_HEAD_SHOT

local GetConversationMetadata = AppChatNetworking.rodux.GetConversationMetadata
local PreloadUsersThumbnail = UserLib.Thunks.PreloadUsersThumbnail
local UpdateUsers = UserLib.Thunks.UpdateUsers
local UserModel = UserLib.Models.UserModel
local receiveUsersPresence = UserLib.Utils.receiveUsersPresence

local NetworkingPresence = require(AppChat.Http.NetworkingPresence)
local FFlagAppChatPresenceStoreMigration = require(AppChat.Flags.FFlagAppChatPresenceStoreMigration)

local function AddNewFriend(arg1, id: string, arg2)
    local var1 = arg2 and arg2.UserService or UserService

    local success, result = pcall(function()
        return var1:GetUserInfosByUserIdsAsync({ tonumber(id) })[1]
    end)

    if not success or not result or not result.Username or not result.DisplayName then
        return
    end

    local dataTable = UserModel.fromDataTable({
        id = id,
        isFriend = true,
        friendRank = 0,
        name = result.Username,
        displayName = result.DisplayName,
        hasVerifiedBadge = result.HasVerifiedBadge
    })

    arg1:dispatch(UpdateUsers({ dataTable }))

    local tbl1 = { id }

    local tbl2 = { (arg1:dispatch(PreloadUsersThumbnail(tbl1, USER_CAROUSEL_HEAD_SHOT, nil))) }

    if not FFlagAppChatPresenceStoreMigration then
        local var2 = arg1:dispatch(NetworkingPresence.GetPresencesFromUserIds.API(tbl1)):andThen(function(arg3)
            local userPresences = arg3.responseBody.userPresences
            receiveUsersPresence(userPresences, arg1)
            return arg3
        end)

        table.insert(tbl2, var2:catch(function(arg3)
            warn("NetworkingPresence failure in ChatFriendshipCreated, Status: " .. tostring(arg3))
        end))
    end

    arg1:dispatch(GetConversationMetadata.API())

    Promise.all(tbl2)
end

return function(str1: string)
    return function(arg1, arg2)
        AddNewFriend(arg1, str1, arg2)
    end
end
