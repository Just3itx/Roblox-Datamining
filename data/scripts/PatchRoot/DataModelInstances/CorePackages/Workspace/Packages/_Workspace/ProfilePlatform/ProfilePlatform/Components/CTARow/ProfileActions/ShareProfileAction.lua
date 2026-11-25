-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T04:51:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfilePlatform = script:FindFirstAncestor("ProfilePlatform")
local ProfilePlatformParent = ProfilePlatform.Parent

local ButtonVariant = require(ProfilePlatformParent.Foundation).Enums.ButtonVariant

local default = require(ProfilePlatformParent.ExternalContentSharingProtocol).ExternalContentSharingProtocol.default
local SetCurrentToastMessage = require(ProfilePlatformParent.ToastRodux).Actions.SetCurrentToastMessage
local Contexts = require(ProfilePlatformParent.SocialLuaAnalytics).Analytics.Enums.Contexts

local ProfileSharePolicyEnum = require(ProfilePlatformParent.ProfileShareLinks).Enums.ProfileSharePolicyEnum

local TextKeys = require(ProfilePlatform.Common.TextKeys)
local Enums = require(ProfilePlatform.Common.Enums)
local _Types = require(ProfilePlatform.Components.CTARow.Types)
local EventNames = require(ProfilePlatform.Analytics.EventNames)
local ProfileTypes = Enums.ProfileTypes

local module = {}
module[Enums.ProfileActions.ShareProfile] = function(arg1)
    local tbl1 = {
        variant = ButtonVariant.Standard,
        text = arg1.localized[Enums.ProfileActions.ShareProfile],
        onActivated = 0
    }
    local onActivated = {}
    onActivated[ProfileTypes.User] = function()
        arg1.analytics.fireAnalyticsEvent(EventNames.CTAButtonShareProfile, { buttonSurface = arg1.buttonSurface })

        if arg1.profileShareLink.policy ~= ProfileSharePolicyEnum.Disabled then
            arg1.profileShareLink.onActivated()

            return
        end

        default:setClipboardText(
            {
                context = Contexts.ProfileCard,
                text = string.format("%s/%s", arg1.PROFILE_SHARE_LINK_URL, arg1.profileId)
            }
        )
        arg1.dispatch(SetCurrentToastMessage({ toastMessage = TextKeys.LinkCopied }))
    end

    tbl1.onActivated = onActivated
    return tbl1
end

return module
