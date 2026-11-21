-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T12:10:35Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local EditProfile = script:FindFirstAncestor("EditProfile")
local EditProfileParent = EditProfile.Parent
local TextKeys = require(EditProfile.Common.TextKeys)
local RealNamesInDisplayNamesIXP = require(EditProfile.Flags.RealNamesInDisplayNamesIXP)

local FFlagEditProfileDisplayNameUseUnder17Description = require(EditProfile.Flags.FFlagEditProfileDisplayNameUseUnder17Description)
local useRealNamesInDisplayNamesEnabled = require(script.Parent.useRealNamesInDisplayNamesEnabled)
local useLocalization = require(EditProfileParent.Localization).Hooks.useLocalization

local tbl1 = {
    displayNameCaption = TextKeys.DisplayNameCaption,
    displayNameChangeError = TextKeys.DisplayNameError,
    displayNameChangeMixedCharactersError = TextKeys.DisplayNameError,
    displayNameModalCaption = TextKeys.DisplayNameModalCaption,
    displayNameCoolDownMessage = TextKeys.DisplayNameRecently,
    displayNameTooShortError = TextKeys.DisplayNameTooShort,
    displayNameUpdatedMessage = TextKeys.DisplayNameUpdated,
    displayNameEditMessage = TextKeys.EditDisplayName,
    displayNameTitle = TextKeys.DisplayName,
    nameTooShortError = TextKeys.NameTooShortError,
    nameTooLongError = TextKeys.NameTooLongError,
    nameUnsupportedCharsError = TextKeys.NameUnsupportedCharsError,
    nameInappropriateError = TextKeys.NameInappropriateError,
    nameHasChangedError = TextKeys.NameHasChangedError,
    nameNotAvailableError = TextKeys.NameNotAvailableError,
    searchForFriendsPrompt = TextKeys.SearchForFriendPrompt
}

local tbl2 = {
    displayNameCaption = TextKeys.AgedUpDisplayNameConnectionsCaption,
    displayNameChangeError = TextKeys.AgedUpDisplayNameError,
    displayNameChangeMixedCharactersError = TextKeys.AgedUpDisplayNameMixedCharactersError,
    displayNameModalCaption = TextKeys.AgedUpDisplayNameModalCaption,
    displayNameCoolDownMessage = TextKeys.AgedUpDisplayNameRecently,
    displayNameTooShortError = TextKeys.AgedUpDisplayNameTooShort,
    displayNameUpdatedMessage = TextKeys.AgedUpDisplayNameUpdated,
    displayNameEditMessage = TextKeys.EditAgedUpDisplayName,
    displayNameTitle = TextKeys.AgedUpDisplayName,
    nameTooShortError = TextKeys.AgedUpNameTooShortError,
    nameTooLongError = TextKeys.AgedUpNameTooLongError,
    nameUnsupportedCharsError = TextKeys.AgedUpNameUnsupportedCharsError,
    nameInappropriateError = TextKeys.AgedUpNameInappropriateError,
    nameHasChangedError = TextKeys.AgedUpNameHasChangedError,
    nameNotAvailableError = TextKeys.AgedUpNameNotAvailableError,
    searchForFriendsPrompt = TextKeys.AgedUpSearchForFriendsPrompt
}

return function()
    local var1 = useRealNamesInDisplayNamesEnabled()
    local tbl3 = if RealNamesInDisplayNamesIXP.useIsExperimentEnabled({ isExposureEnabled = true }) and var1 then tbl2 else tbl1

    if FFlagEditProfileDisplayNameUseUnder17Description then
        tbl3 = table.clone(tbl3)
        tbl3.displayNameCaption = tbl1.displayNameCaption
        tbl3.displayNameModalCaption = tbl1.displayNameModalCaption
    end

    return useLocalization(tbl3)
end
