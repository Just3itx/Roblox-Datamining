-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T12:01:08Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local EditProfile = script:FindFirstAncestor("EditProfile")
local EditProfileParent = EditProfile.Parent
local React = require(EditProfileParent.React)
local UIBlox = require(EditProfileParent.UIBlox)
local InteractiveAlert = UIBlox.App.Dialog.Alert.InteractiveAlert
local useScreenSize = require(EditProfileParent.RobloxAppHooks).useScreenSize
local TextKeys = require(EditProfile.Common.TextKeys)
local useLocalization = require(EditProfileParent.Localization).Hooks.useLocalization
local ButtonType = UIBlox.App.Button.Enum.ButtonType
local FFlagEditProfileFixFocusNavigation = require(EditProfile.Flags.FFlagEditProfileFixFocusNavigation)
local useDisplayNameText = require(EditProfile.Hooks.useDisplayNameText)
local FocusNavigatorWrapper = require(EditProfile.Utils.FocusNavigatorWrapper)

local function EditDisplayNameErrorModal(tbl1)
    local screenSize = useScreenSize()
    local var2 = useDisplayNameText()
    local var3 = useLocalization({ OK = TextKeys.OK })

    local function onClose()
        tbl1.navigation.goBack()
    end

    if not FFlagEditProfileFixFocusNavigation then
        return React.createElement(InteractiveAlert, {
            screenSize = screenSize,
            title = var2.displayNameEditMessage,
            bodyText = var2.displayNameCoolDownMessage,
            buttonStackInfo = {
                buttons = {{
                    buttonType = ButtonType.PrimarySystem,
                    props = {
                        onActivated = onClose,
                        text = var3.OK
                    }
                }}
            }
        })
    end

    return FocusNavigatorWrapper({ onClose = onClose }, { React.createElement(InteractiveAlert, {
            screenSize = screenSize,
            title = var2.displayNameEditMessage,
            bodyText = var2.displayNameCoolDownMessage,
            buttonStackInfo = {
                buttons = {{
                    buttonType = ButtonType.PrimarySystem,
                    props = {
                        onActivated = onClose,
                        text = var3.OK
                    }
                }}
            }
        }) })
end

return EditDisplayNameErrorModal
