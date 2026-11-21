-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T12:01:10Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local EditProfile = script:FindFirstAncestor("EditProfile")
local EditProfileParent = EditProfile.Parent
local React = require(EditProfileParent.React)
local UIBlox = require(EditProfileParent.UIBlox)
local AppPage = require(EditProfileParent.RobloxAppEnums).AppPage
local useScreenSize = require(EditProfileParent.RobloxAppHooks).useScreenSize
local Localization = require(EditProfileParent.Localization)
local TextKeys = require(EditProfile.Common.TextKeys)
local FFlagEditProfileFixFocusNavigation = require(EditProfile.Flags.FFlagEditProfileFixFocusNavigation)
local FocusNavigatorWrapper = require(EditProfile.Utils.FocusNavigatorWrapper)

local InteractiveAlert = UIBlox.App.Dialog.Alert.InteractiveAlert
local useLocalization = Localization.Hooks.useLocalization
local ButtonType = UIBlox.App.Button.Enum.ButtonType

local icon = utf8.char(57346)

local function EditDisplayNameErrorModal(tbl1)
    local screenSize = useScreenSize()
    local rbx = tbl1.navigation.getParam("robux")
    local var2 = useLocalization({
        cancelButtonText = TextKeys.CancelButtonText,
        buy = TextKeys.Buy,
        insufficientFunds = TextKeys.InsufficientFunds,
        message = {
            TextKeys.InsufficientFundsMessage,
            icon = icon,
            rbx = rbx
        }
    })
    local function onClose()
        tbl1.navigation.goBack()
    end

    local function onActivated()
        tbl1.navigation.navigate(AppPage.PurchaseRobux)
    end

    if not FFlagEditProfileFixFocusNavigation then
        return React.createElement(InteractiveAlert, {
            screenSize = screenSize,
            title = var2.insufficientFunds,
            bodyText = var2.message,
            buttonStackInfo = {
                buttons = {
                    {
                        buttonType = ButtonType.Secondary,
                        props = {
                            onActivated = onClose,
                            text = var2.cancelButtonText
                        }
                    },
                    {
                        buttonType = ButtonType.PrimarySystem,
                        props = {
                            onActivated = onActivated,
                            text = var2.buy
                        }
                    }
                }
            }
        })
    end

    return FocusNavigatorWrapper({ onClose = onClose }, { React.createElement(InteractiveAlert, {
            screenSize = screenSize,
            title = var2.insufficientFunds,
            bodyText = var2.message,
            buttonStackInfo = {
                buttons = {
                    {
                        buttonType = ButtonType.Secondary,
                        props = {
                            onActivated = onClose,
                            text = var2.cancelButtonText
                        }
                    },
                    {
                        buttonType = ButtonType.PrimarySystem,
                        props = {
                            onActivated = onActivated,
                            text = var2.buy
                        }
                    }
                }
            }
        }) })
end

return EditDisplayNameErrorModal
