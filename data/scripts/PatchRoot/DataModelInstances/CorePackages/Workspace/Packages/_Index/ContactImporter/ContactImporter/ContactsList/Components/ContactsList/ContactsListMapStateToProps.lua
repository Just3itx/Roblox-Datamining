-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T08:21:09Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ContactImporter = script:FindFirstAncestor("ContactImporter")
local dependencies = require(ContactImporter.dependencies)
local RODUX_KEY = require(ContactImporter.Common.Constants).RODUX_KEY
local NetworkStatus = dependencies.RoduxNetworking.Enum.NetworkStatus
local NetworkingFriends = dependencies.NetworkingFriends
local NetworkingContacts = dependencies.NetworkingContacts
local Selectors = dependencies.RoduxContacts.Selectors
local memoize = dependencies.memoize
local getDeepValue = dependencies.SocialLibraries.Dictionary.getDeepValue

local getDeviceContacts = require(script.Parent.getDeviceContacts)
local decorateMatchedContact = require(script.Parent.decorateMatchedContact)

return function(arg1)
    local localUserId = arg1.LocalUserId

    local deepValue = getDeepValue(arg1, RODUX_KEY .. ".Contacts")
    local deviceContacts = memoize(getDeviceContacts)(deepValue)
    local matchedContacts = decorateMatchedContact(Selectors.sortContacts(arg1), deepValue)

    local isFetching = NetworkingFriends.RequestFriendshipFromContactId.getStatus(arg1, localUserId) == NetworkStatus.Fetching
        or NetworkingContacts.FindContactFriends.getStatus(arg1, localUserId) == NetworkStatus.Fetching
        or NetworkingContacts.GetContactEntitiesByContactId.getStatus(arg1, localUserId) == NetworkStatus.Fetching
        or NetworkingContacts.UploadContactsByUser.getStatus(arg1, localUserId) == NetworkStatus.Fetching

    return {
        localUserId = arg1.LocalUserId,
        matchedContacts = matchedContacts,
        deviceContacts = deviceContacts,
        screenSize = arg1.ScreenSize,
        isFetching = isFetching
    }
end
