-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T04:51:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfilePlatform = script:FindFirstAncestor("ProfilePlatform")
local ProfilePlatformParent = ProfilePlatform.Parent

local Foundation = require(ProfilePlatformParent.Foundation)
local SharedFlags = require(ProfilePlatformParent.SharedFlags)

local ButtonVariant = Foundation.Enums.ButtonVariant

local refreshProfilePlatformUserInfo = require(ProfilePlatform.Networking.refreshProfilePlatformUserInfo)
local Enums = require(ProfilePlatform.Common.Enums)
local _Types = require(ProfilePlatform.Components.CTARow.Types)
local EventNames = require(ProfilePlatform.Analytics.EventNames)
local ProfileTypes = Enums.ProfileTypes

local FFlagMoveInExperienceModeToEditProfile = SharedFlags.FFlagMoveInExperienceModeToEditProfile
local FFlagAXEnableProfileTab = SharedFlags.FFlagAXEnableProfileTab

local module = {}
module[Enums.ProfileActions.EditProfile] = function(arg1)
    local tbl1 = {
        variant = ButtonVariant.Standard,
        text = arg1.localized[Enums.ProfileActions.EditProfile],
        onActivated = 0
    }
    local onActivated = {}
    onActivated[ProfileTypes.User] = function()
        arg1.analytics.fireAnalyticsEvent(EventNames.CTAButtonOpenEditProfilePage, { buttonSurface = arg1.buttonSurface })

        local navigate = arg1.navigation.navigate
        local editProfilePage = Enums.Screens.EditProfilePage
        local tbl3 = {
            fullBleed = if FFlagAXEnableProfileTab then arg1.profileWrapperContext.forceFullView == true else nil,
            navigateToEditUsername = 0,
            onIdentityChange = 0,
            onToggleInExperienceMode = 0
        }

        function tbl3.navigateToEditUsername(showToast)
            arg1.navigateTo.editUsername({
                showToast = showToast,
                onUsernameChanged = function()
                    arg1.dispatch(refreshProfilePlatformUserInfo(arg1.profileId))
                end
            })
        end
        function tbl3.onIdentityChange()
            arg1.dispatch(refreshProfilePlatformUserInfo(arg1.profileId))
        end
        tbl3.onToggleInExperienceMode = FFlagMoveInExperienceModeToEditProfile and function()
            arg1.dispatch(refreshProfilePlatformUserInfo(arg1.profileId))
            arg1.analytics.fireAnalyticsEvent(EventNames.ToggleInExperienceModeButton, {})
        end or nil

        navigate(editProfilePage, tbl3)
    end

    tbl1.onActivated = onActivated
    return tbl1
end

return module
