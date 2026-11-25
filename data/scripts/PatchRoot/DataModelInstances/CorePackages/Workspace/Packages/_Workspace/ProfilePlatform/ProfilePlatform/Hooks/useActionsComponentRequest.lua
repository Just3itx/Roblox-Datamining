-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T05:50:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfilePlatform = script:FindFirstAncestor("ProfilePlatform")
local ProfilePlatformParent = ProfilePlatform.Parent
local React = require(ProfilePlatformParent.React)
local _SocialCommon = require(ProfilePlatformParent.SocialCommon)

local _Component = require(ProfilePlatform.Types.Component)
local buildUserActionsComponent = require(ProfilePlatform.Hooks.buildUserActionsComponent)
local getDeepValue = require(ProfilePlatform.Utils.getDeepValue)
local useProfileWrapperContext = require(ProfilePlatform.Contexts.useProfileWrapperContext)
local useAreWebViewsSupported = require(ProfilePlatform.Hooks.useAreWebViewsSupported)
local useIsProfileQrCodeEnabled = require(ProfilePlatform.Hooks.useIsProfileQrCodeEnabled)
local useCanRenderTransferOnProfile = require(ProfilePlatform.Hooks.useCanRenderTransferOnProfile)
local useCanSeeChatTab = require(ProfilePlatform.Hooks.useCanSeeChatTab)
local useLocalUserId = require(ProfilePlatformParent.RobloxAppHooks).useLocalUserId

local FFlagProfilePlatformEnableCurrencyTransfer = require(ProfilePlatformParent.SharedFlags).FFlagProfilePlatformEnableCurrencyTransfer

return function()
    local var1 = useProfileWrapperContext()

    local deepValue = getDeepValue(var1, "sourceInfo.contextualInfoType")
    local areWebViewsSupported = useAreWebViewsSupported()
    local isProfileQrCodeEnabled = useIsProfileQrCodeEnabled()
    local var4 = useCanRenderTransferOnProfile()
    local canSeeChatTab = useCanSeeChatTab()
    local var6 = useLocalUserId()
    local isSelfView = tostring(var1.profileId) == tostring(var6)

    local useMemo = React.useMemo

    local function func1()
        return buildUserActionsComponent(deepValue, {
            areWebViewsSupported = areWebViewsSupported,
            isProfileQrCodeEnabled = isProfileQrCodeEnabled,
            canRenderTransferInProfile = if FFlagProfilePlatformEnableCurrencyTransfer then var4 else false,
            canSeeChatTab = canSeeChatTab,
            isSelfView = isSelfView
        })
    end

    local var7 = if FFlagProfilePlatformEnableCurrencyTransfer then var4 else nil
    return useMemo(func1, { deepValue, areWebViewsSupported, isProfileQrCodeEnabled, var7, canSeeChatTab, isSelfView })
end
