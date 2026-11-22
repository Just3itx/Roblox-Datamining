-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T11:41:08Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfileQRCode = script:FindFirstAncestor("ProfileQRCode")
local ProfileQRCodeParent = ProfileQRCode.Parent
local getDeepValue = require(ProfileQRCodeParent.LuaSocialLibrariesDeps).SocialLibraries.config({}).Dictionary.getDeepValue
local useSelector = require(ProfileQRCodeParent.RoactUtils).Hooks.RoactRodux.useSelector
local Constants = require(ProfileQRCode.Common.Constants)
local UserProfiles = require(ProfileQRCodeParent.UserProfiles)

local FFlagProfileQrCodeDeprecateUserRedux = require(ProfileQRCode.Flags.FFlagProfileQrCodeDeprecateUserRedux)

return function(str1: string)
    if not FFlagProfileQrCodeDeprecateUserRedux then
        return useSelector(function(arg1)
            return getDeepValue(arg1, Constants.RODUX_KEY .. ".Users.byUserId." .. str1)
        end)
    end

    local var1 = UserProfiles.Hooks.useUserProfilesFetch(
        {
            userIds = { str1 },
            query = UserProfiles.Queries.userProfilesDisplayNameAndUsernameByUserIds
        }
    )

    if var1.data then
        return {
            displayName = UserProfiles.Selectors.getDisplayNameFromId(var1.data, str1) or "",
            username = UserProfiles.Selectors.getUsernameFromId(var1.data, str1) or ""
        }
    end

    return { displayName = "", username = "" }
end
