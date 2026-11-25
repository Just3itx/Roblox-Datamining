-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T05:50:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfilePlatform = script:FindFirstAncestor("ProfilePlatform")
local ProfilePlatformParent = ProfilePlatform.Parent
local React = require(ProfilePlatformParent.React)
local _SocialCommon = require(ProfilePlatformParent.SocialCommon)

local _Component = require(ProfilePlatform.Types.Component)
local Enums = require(ProfilePlatform.Common.Enums)
local getAvailableUserComponents = require(ProfilePlatform.Hooks.getAvailableUserComponents)
local getAvailableCommunityComponents = require(ProfilePlatform.Hooks.getAvailableCommunityComponents)
local getAvailableContactComponents = require(ProfilePlatform.Hooks.getAvailableContactComponents)
local getDeepValue = require(ProfilePlatform.Utils.getDeepValue)
local useProfileWrapperContext = require(ProfilePlatform.Contexts.useProfileWrapperContext)
local useAreWebViewsSupported = require(ProfilePlatform.Hooks.useAreWebViewsSupported)
local useIsProfileQrCodeEnabled = require(ProfilePlatform.Hooks.useIsProfileQrCodeEnabled)
local useCanRenderTransferOnProfile = require(ProfilePlatform.Hooks.useCanRenderTransferOnProfile)
local useCanSeeChatTab = require(ProfilePlatform.Hooks.useCanSeeChatTab)
local useLocalUserId = require(ProfilePlatformParent.RobloxAppHooks).useLocalUserId
local FFlagProfilePlatformEnableVR = require(ProfilePlatform.Flags.FFlagProfilePlatformEnableVR)

local FFlagProfilePlatformEnableCurrencyTransfer = require(ProfilePlatformParent.SharedFlags).FFlagProfilePlatformEnableCurrencyTransfer

return function()
    local var1 = useProfileWrapperContext()
    local profileType = var1.profileType

    local deepValue = getDeepValue(var1, "sourceInfo.contextualInfoType")
    local areWebViewsSupported = useAreWebViewsSupported()
    local isProfileQrCodeEnabled = useIsProfileQrCodeEnabled()
    local var4 = useCanRenderTransferOnProfile()
    local canSeeChatTab = useCanSeeChatTab()
    local var6 = useLocalUserId()
    local isSelfView = tostring(var1.profileId) == tostring(var6)

    local useMemo = React.useMemo
    local function func1()
        if profileType == Enums.ProfileTypes.User then
            local var7 = getAvailableUserComponents
            local var8 = deepValue
            local tbl1 = if FFlagProfilePlatformEnableVR then {
                areWebViewsSupported = areWebViewsSupported,
                isProfileQrCodeEnabled = isProfileQrCodeEnabled,
                canRenderTransferInProfile = if FFlagProfilePlatformEnableCurrencyTransfer then var4 else false,
                canSeeChatTab = canSeeChatTab,
                isSelfView = isSelfView
            } else {
                canRenderTransferInProfile = if FFlagProfilePlatformEnableCurrencyTransfer then var4 else false,
                canSeeChatTab = canSeeChatTab,
                isSelfView = isSelfView
            }
            return var7(var8, tbl1)
        elseif profileType == Enums.ProfileTypes.Community then
            return getAvailableCommunityComponents()
        elseif profileType == Enums.ProfileTypes.Contact then
            return getAvailableContactComponents()
        else
            return {}
        end
    end

    local tbl1

    if FFlagProfilePlatformEnableVR then
        local var7 = if FFlagProfilePlatformEnableCurrencyTransfer then var4 else nil
        tbl1 = {
            profileType,
            deepValue,
            isSelfView,
            var7,
            canSeeChatTab
        }
    else
        local var7 = if FFlagProfilePlatformEnableCurrencyTransfer then var4 else nil
        tbl1 = {
            profileType,
            deepValue,
            areWebViewsSupported,
            isProfileQrCodeEnabled,
            isSelfView,
            var7,
            canSeeChatTab
        }
    end

    return (useMemo(func1, tbl1))
end
