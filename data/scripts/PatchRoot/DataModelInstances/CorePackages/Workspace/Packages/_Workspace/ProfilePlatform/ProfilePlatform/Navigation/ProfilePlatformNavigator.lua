-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T06:01:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfilePlatform = script:FindFirstAncestor("ProfilePlatform")
local ProfilePlatformParent = ProfilePlatform.Parent
local Enums = require(ProfilePlatform.Common.Enums)
local SetAlias = require(ProfilePlatformParent.SetAlias)
local ProfileContextualMenu = require(ProfilePlatform.Components.ProfileContextualMenu)
local EditProfileLanding = require(ProfilePlatformParent.EditProfile.EditProfileLanding)
local EditDisplayNameErrorModal = require(ProfilePlatformParent.EditProfile.EditDisplayNameErrorModal)
local UsernameInsufficientFundsModal = require(ProfilePlatformParent.EditProfile.UsernameInsufficientFundsModal)
local Enums2 = require(ProfilePlatformParent.EditProfile.Enums)
local ProfilePlatformViewAdaptor = require(ProfilePlatform.Components.ProfilePlatformViewAdaptor)
local SetAliasModal = SetAlias.SetAliasModal
local EditProfileScreenViewAdapter = require(ProfilePlatformParent.EditProfile.EditProfileScreenViewAdapter)
local EditProfileToastScreen = require(ProfilePlatformParent.EditProfile.EditProfileToastScreen)
local EditProfileBackgroundContainer = require(ProfilePlatform.Components.EditProfileBackgroundContainer)
local CommunityVerificationModal = require(ProfilePlatform.Components.CommunityVerificationModal)
local InspectAvatarSheetContainer = require(ProfilePlatform.Components.InspectAvatar.InspectAvatarSheetContainer)
local PurchaseConfirmationModal = require(ProfilePlatform.Components.InspectAvatar.PurchaseConfirmationModal)
local InsufficientRobuxDialog = require(ProfilePlatform.Components.InspectAvatar.InsufficientRobuxDialog)
local MomentsGridPage = require(ProfilePlatform.Components.Moments.MomentsGridPage)
local MomentsFeedPage = require(ProfilePlatform.Components.Moments.MomentsFeedPage)
local FFlagSocialEnableProfileInspectAndBuy = require(ProfilePlatformParent.SharedFlags).FFlagSocialEnableProfileInspectAndBuy
local FFlagProfilePlatformEnableMoments = require(ProfilePlatform.Flags.FFlagProfilePlatformEnableMoments)

local React = require(ProfilePlatformParent.React)
local RoactNavigation = require(ProfilePlatformParent.RoactNavigation)

local FFlagEditProfileBackgroundEnabled = require(ProfilePlatformParent.SharedFlags).FFlagEditProfileBackgroundEnabled
local FFlagEnableCommunityVerificationModal = require(ProfilePlatform.Flags.FFlagEnableCommunityVerificationModal)
local FFlagEditProfileImageV2Enabled = require(ProfilePlatformParent.SharedFlags).FFlagEditProfileImageV2Enabled
local FFlagAXEnableProfileTab = require(ProfilePlatformParent.SharedFlags).FFlagAXEnableProfileTab
local FFlagAXHideBottomNavForEditProfileImage = require(ProfilePlatformParent.SharedFlags).FFlagAXHideBottomNavForEditProfileImage
local FFlagEnableBottomNavOnMarketplace = require(ProfilePlatformParent.SharedFlags).FFlagEnableBottomNavOnMarketplace
local FFlagAXSaveManagerOutsideAX = require(ProfilePlatformParent.SharedFlags).FFlagAXSaveManagerOutsideAX

local navigationOptions = { overlayEnabled = true, overlayTransparency = 0.5, absorbInput = true }

local tbl2 = { overlayEnabled = false, absorbInput = true, renderUnderlyingPage = true }

local function makeFullBleedNavigationOptions(tbl3, tbl4) -- Luacid: Inlined by compiler; 3 call sites recovered
    local var1 = tbl4 or tbl2
    return function(arg1): {[any]: any} | {absorbInput: boolean, overlayEnabled: boolean, renderUnderlyingPage: boolean}
        return if arg1.navigation.getParam("fullBleed") then var1 else tbl3
    end
end

local function LazyEditProfileImageContainer(arg1)
    local editProfileImageContainer = require(ProfilePlatform.Components.EditProfileImage.EditProfileImageContainer)
    return React.createElement(editProfileImageContainer, arg1)
end

local tbl3 = {
    {
        [Enums.Screens.ProfileMain] = ProfilePlatformViewAdaptor
    },
    {
        [Enums.Screens.EditProfilePage] = {
            screen = EditProfileLanding,
            navigationOptions = if FFlagAXEnableProfileTab then makeFullBleedNavigationOptions(navigationOptions, false) else navigationOptions
        }
    },
    {
        [Enums.Screens.EditDisplayNameErrorModal] = {
            screen = EditDisplayNameErrorModal,
            navigationOptions = navigationOptions
        }
    },
    {
        [Enums.Screens.UsernameInsufficientFundsModal] = {
            screen = UsernameInsufficientFundsModal,
            navigationOptions = navigationOptions
        }
    },
    {
        [Enums.Screens.SetAliasModal] = {
            screen = SetAliasModal,
            navigationOptions = navigationOptions
        }
    },
    {
        [Enums.Screens.ContextualMenu] = {
            screen = ProfileContextualMenu,
            navigationOptions = {
                overlayEnabled = true,
                overlayTransparency = 1,
                absorbInput = false
            }
        }
    }
}

if FFlagEnableCommunityVerificationModal then
    table.insert(tbl3, {
        [Enums.Screens.CommunityVerificationModal] = {
            screen = CommunityVerificationModal,
            navigationOptions = navigationOptions
        }
    })
end

if FFlagEditProfileBackgroundEnabled then
    table.insert(tbl3, {
        [Enums.Screens.EditProfileBackground] = {
            screen = EditProfileBackgroundContainer,
            navigationOptions = {
                overlayEnabled = false,
                absorbInput = true,
                renderUnderlyingPage = true
            }
        }
    })
end

table.insert(tbl3, {
    [Enums2.Screens.EditProfileSubScreen] = {
        screen = EditProfileScreenViewAdapter,
        navigationOptions = not FFlagAXEnableProfileTab and {
            overlayEnabled = true,
            overlayTransparency = 0.5,
            absorbInput = false
        }
            or makeFullBleedNavigationOptions({ overlayEnabled = true, overlayTransparency = 0.5, absorbInput = false }, false)
    }
})

table.insert(tbl3, {
    [Enums2.Screens.EditProfileToast] = {
        screen = EditProfileToastScreen,
        navigationOptions = { overlayEnabled = true, overlayTransparency = 1, absorbInput = false }
    }
})

if FFlagEditProfileImageV2Enabled then
    local tabBarVisible = if FFlagAXHideBottomNavForEditProfileImage then not FFlagEnableBottomNavOnMarketplace and nil else nil
    local tbl4 = {
        overlayEnabled = true,
        overlayTransparency = 1,
        absorbInput = true,
        tabBarVisible = tabBarVisible
    }
    local tbl5 = {
        overlayEnabled = false,
        absorbInput = true,
        renderUnderlyingPage = true,
        tabBarVisible = tabBarVisible
    }
    local tbl6 = {}
    local editProfileImageProfilePlatform = Enums2.Screens.EditProfileImageProfilePlatform
    local tbl7 = {
        screen = LazyEditProfileImageContainer,
        params = FFlagAXSaveManagerOutsideAX and { runAvatarSaveManager = true } or nil,
        navigationOptions = 0
    }

    if FFlagAXEnableProfileTab then
        tbl4 = makeFullBleedNavigationOptions(tbl4, tbl5)
    end

    tbl7.navigationOptions = tbl4
    tbl6[editProfileImageProfilePlatform] = tbl7
    table.insert(tbl3, tbl6)
end

if FFlagSocialEnableProfileInspectAndBuy then
    table.insert(tbl3, {
        [Enums.Screens.InspectAvatarSheet] = {
            screen = InspectAvatarSheetContainer,
            navigationOptions = {
                overlayEnabled = true,
                overlayTransparency = 1,
                absorbInput = true
            }
        }
    })

    table.insert(tbl3, {
        [Enums.Screens.PurchaseConfirmationModal] = {
            screen = PurchaseConfirmationModal,
            navigationOptions = navigationOptions
        }
    })
    table.insert(tbl3, {
        [Enums.Screens.InsufficientRobuxDialog] = {
            screen = InsufficientRobuxDialog,
            navigationOptions = navigationOptions
        }
    })
end

if FFlagProfilePlatformEnableMoments then
    table.insert(tbl3, {
        [Enums.Screens.MomentsAll] = {
            screen = MomentsGridPage,
            navigationOptions = {
                overlayEnabled = false,
                absorbInput = true,
                renderUnderlyingPage = true
            }
        }
    })

    table.insert(tbl3, {
        [Enums.Screens.MomentsFeed] = {
            screen = MomentsFeedPage,
            navigationOptions = { overlayEnabled = false, absorbInput = true }
        }
    })
end

return (RoactNavigation.createRobloxStackNavigator(tbl3, {
    defaultNavigationOptions = {
        overlayEnabled = true,
        absorbInput = true,
        overlayTransparency = 1,
        disableBackButton = true
    },
    mode = RoactNavigation.StackPresentationStyle.Overlay
}))
