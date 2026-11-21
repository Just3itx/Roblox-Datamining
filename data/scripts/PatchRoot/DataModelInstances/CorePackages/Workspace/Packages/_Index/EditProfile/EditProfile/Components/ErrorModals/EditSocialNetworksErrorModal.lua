-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T12:01:09Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local EditProfile = script:FindFirstAncestor("EditProfile")
local EditProfileParent = EditProfile.Parent
local React = require(EditProfileParent.React)
local UIBlox = require(EditProfileParent.UIBlox)
local InteractiveAlert = UIBlox.App.Dialog.Alert.InteractiveAlert
local useScreenSize = require(EditProfileParent.RobloxAppHooks).useScreenSize
local TextKeys = require(EditProfile.Common.TextKeys)
local Constants = require(EditProfile.Common.Constants)
local useLocalization = require(EditProfileParent.Localization).Hooks.useLocalization
local ButtonType = UIBlox.App.Button.Enum.ButtonType
local useNavigationProps = require(EditProfileParent.RobloxAppNavigation).useNavigationProps
local useNavigation = require(EditProfileParent.Navigation).useNavigation
local FocusNavigatorWrapper = require(EditProfile.Utils.FocusNavigatorWrapper)
local FFlagEditProfileFixFocusNavigation = require(EditProfile.Flags.FFlagEditProfileFixFocusNavigation)

local function EditSocialNetworksErrorModal()
    local var1 = useNavigationProps(function(_, arg1)
        return {
            errorCode = arg1.errorCode
        }
    end)

    local var2 = useNavigation()
    local screenSize = useScreenSize()
    local var4 = useLocalization({
        title = TextKeys.SocialNetworksError,
        InvalidFacebook = TextKeys.InvalidFacebook,
        InvalidX = TextKeys.InvalidX,
        InvalidYouTube = TextKeys.InvalidYouTube,
        InvalidTwitch = TextKeys.InvalidTwitch,
        InvalidGuilded = TextKeys.InvalidGuilded,
        OK = TextKeys.OK
    })
    local bodyText = ({
        [Constants.SocialNetworksErrorCodes.Facebook] = var4.InvalidFacebook,
        [Constants.SocialNetworksErrorCodes.Twitter] = var4.InvalidX,
        [Constants.SocialNetworksErrorCodes.YouTube] = var4.InvalidYouTube,
        [Constants.SocialNetworksErrorCodes.Twitch] = var4.InvalidTwitch,
        [Constants.SocialNetworksErrorCodes.Guilded] = var4.InvalidGuilded
    })[var1.errorCode]

    local function onClose()
        var2.goBack()
    end

    if not FFlagEditProfileFixFocusNavigation then
        return React.createElement(InteractiveAlert, {
            screenSize = screenSize,
            title = var4.title,
            bodyText = bodyText,
            buttonStackInfo = {
                buttons = {{
                    buttonType = ButtonType.PrimarySystem,
                    props = {
                        onActivated = onClose,
                        text = var4.OK
                    }
                }}
            }
        })
    end

    return FocusNavigatorWrapper({ onClose = onClose }, { React.createElement(InteractiveAlert, {
            screenSize = screenSize,
            title = var4.title,
            bodyText = bodyText,
            buttonStackInfo = {
                buttons = {{
                    buttonType = ButtonType.PrimarySystem,
                    props = {
                        onActivated = onClose,
                        text = var4.OK
                    }
                }}
            }
        }) })
end

return EditSocialNetworksErrorModal
