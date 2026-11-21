-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T08:19:32Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local EventNames = require(script.Parent.Enums.EventNames)

return {
    [EventNames.ContactImportModalPageLoad] = {
        name = game:DefineFastString("ContactImportModalPageLoadCounter", "ContactImportModalPageLoad")
    },
    [EventNames.ContactImportModalClose] = {
        name = game:DefineFastString("ContactImportModalCloseCounter", "ContactImportModalClose")
    },
    [EventNames.ContactImportModalContinue] = {
        name = game:DefineFastString("ContactImportModalContinueCounter", "ContactImportModalContinue")
    },
    [EventNames.ContactImportModalAddFriends] = {
        name = game:DefineFastString("ContactImportModalAddFriendsCounter", "ContactImportModalAddFriends")
    },
    [EventNames.ContactsListLoaded] = {
        name = game:DefineFastString("ContactsListLoadedCounter", "ContactsListLoaded")
    },
    [EventNames.RequestFriendship] = {
        name = game:DefineFastString("ContactImporterRequestFriendshipCounter", "ContactImporterFriendshipRequest")
    },
    [EventNames.InviteContact] = {
        name = game:DefineFastString("ContactImporterInviteContactCounter", "ContactImporterInviteContact")
    },
    [EventNames.ContactImportingTime] = {
        name = game:DefineFastString("ContactImportingTimeStat", "ContactImportingTime")
    },
    [EventNames.CloseContactListButton] = {
        name = game:DefineFastString("CloseContactListButtonCounter", "CloseContactListButton")
    },
    [EventNames.CloseContactListCross] = {
        name = game:DefineFastString("CloseContactListCrossCounter", "CloseContactListCross")
    },
    [EventNames.PhoneVerificationWebview] = {
        name = game:DefineFastString("PhoneVerificationWebviewCounter", "PhoneVerificationWebview")
    },
    [EventNames.PhoneVerificationClose] = {
        name = game:DefineFastString("PhoneVerificationCloseCounter", "PhoneVerificationCloseWebview")
    },
    [EventNames.FailedGetContactsFromDevice] = {
        name = game:DefineFastString("FailedGetContactsFromDeviceCounter", "FailedGetContactsFromDevice")
    },
    [EventNames.FailedFormatContactsFromDevice] = {
        name = game:DefineFastString("FailedFormatContactsFromDeviceCounter", "FailedFormatContactsFromDevice")
    },
    [EventNames.FailedUploadContactsFromDevice] = {
        name = game:DefineFastString("FailedUploadContactsFromDeviceCounter", "FailedUploadContactsFromDevice")
    },
    [EventNames.FailedFindContacts] = {
        name = game:DefineFastString("FailedFindContactsCounter", "FailedFindContacts")
    },
    [EventNames.FailedGetContactEntities] = {
        name = game:DefineFastString("FailedGetContactEntitiesCounter", "FailedGetContactEntities")
    },
    [EventNames.FindFriendsButtonClicked] = {
        name = game:DefineFastString("FindFriendsButtonClickedCounter", "FindFriendsButtonClicked")
    }
}
