-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T08:21:08Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParentParent = script.Parent.Parent.Parent.Parent
local scriptParentParentParentParentParent = scriptParentParentParentParent.Parent

local dependencies = require(scriptParentParentParentParent.dependencies)
local NetworkingFriends = dependencies.NetworkingFriends
local _LocalTypes = require(scriptParentParentParentParent.Common.LocalTypes)
local NetworkingContacts = dependencies.NetworkingContacts
local RoduxContacts = dependencies.RoduxContacts
local Promise = dependencies.Promise
local llama = dependencies.llama

local FFlagMigrateFriendshipStatusesRemainingActions = require(scriptParentParentParentParentParent.SharedFlags).FFlagMigrateFriendshipStatusesRemainingActions
local friendsStoreChallengeNetwork = require(scriptParentParentParentParent.Networking.friendsStoreChallengeNetwork)

local FFlagEnableFriendsStoreChallengeInterceptor = require(scriptParentParentParentParentParent.SharedFlags).FFlagEnableFriendsStoreChallengeInterceptor
local var1 = require(scriptParentParentParentParentParent.DataHydration).Friends.FriendsStore.get()

return function(arg1)
    return {
        requestFriendship = function(arg2)
            if not FFlagMigrateFriendshipStatusesRemainingActions then
                return arg1(NetworkingFriends.RequestFriendshipFromContactId.API(arg2))
            end

            return var1.RequestFriendship(
                arg2.contactId,
                nil,
                { isContact = true },
                if FFlagEnableFriendsStoreChallengeInterceptor then friendsStoreChallengeNetwork else nil
            )
        end,
        findContacts = function()
            return arg1(NetworkingContacts.FindContactFriends.API()):andThen(function(arg2)
                return arg2.responseBody.userContactIds
            end)
        end,
        getContactEntities = function(arg2)
            if llama.isEmpty(arg2) or not arg2 then
                return Promise.resolve()
            end
            return arg1(NetworkingContacts.GetContactEntitiesByContactId.API(arg2))
        end,
        uploadContacts = function(arg2)
            return arg1(NetworkingContacts.UploadContactsByUser.API(arg2))
        end,
        deviceContactsReceived = function(arg2)
            return arg1(RoduxContacts.Actions.DeviceContactsReceived(arg2))
        end,
        requestSent = function(id)
            return arg1(RoduxContacts.Actions.RequestSent({ id = id }))
        end
    }
end
