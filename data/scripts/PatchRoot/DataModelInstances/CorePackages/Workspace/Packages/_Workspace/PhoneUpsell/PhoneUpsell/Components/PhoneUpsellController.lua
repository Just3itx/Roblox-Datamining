-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T02:11:04Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PhoneUpsell = script:FindFirstAncestor("PhoneUpsell")
local PhoneUpsellParent = PhoneUpsell.Parent

local LocalizationService = game:GetService("LocalizationService")

local Cryo = require(PhoneUpsellParent.Cryo)
local React = require(PhoneUpsellParent.React)
local ReactRoblox = require(PhoneUpsellParent.ReactRoblox)

local StyleProviderWithDefaultTheme = require(PhoneUpsellParent.Style).StyleProviderWithDefaultTheme
local Localization = require(PhoneUpsellParent.RobloxAppLocales).Localization
local LocalizationProvider = require(PhoneUpsellParent.Localization).LocalizationProvider
local useLocalization = require(PhoneUpsellParent.Localization).Hooks.useLocalization
local UIBlox = require(PhoneUpsellParent.UIBlox)
local useStyle = UIBlox.Core.Style.useStyle
local Images = UIBlox.App.ImageSet.Images
local Toast = UIBlox.App.Dialog.Toast
local GetFFlagNotificationModalSetMenuIsOpen = require(PhoneUpsellParent.SharedFlags).GetFFlagNotificationModalSetMenuIsOpen

local OpenModal = require(PhoneUpsellParent.NotificationModalsManager).OpenModal
local CloseModal = require(PhoneUpsellParent.NotificationModalsManager).CloseModal
local InExperienceProviderContainer = require(PhoneUpsellParent.InExperienceContainer).InExperienceProviderContainer
local InGameUpsellContainer = require(PhoneUpsell.Components.InGame.InGameUpsellContainer)

local root = nil

local function func1(arg1)
    local var1 = useLocalization({ titleKey = "Feature.VerificationUpsell.Heading.PhoneNumberVerified" })

    local var2 = useStyle()
    return React.createElement(React.Fragment, {}, {
        PhoneToast = React.createElement(Toast, {
            toastContent = {
                iconColorStyle = {
                    Color = var2.Tokens.Color.System.Success.Color3,
                    Transparency = 0
                },
                iconImage = Images["icons/status/success_large"],
                toastTitle = var1.titleKey,
                onDismissed = arg1.onDismissed
            },
            duration = 3
        })
    })
end

return {
    openPhoneUpsell = function(arg1)
        if root == nil then
            local phoneUpsellToasts = Instance.new("Folder")
            phoneUpsellToasts.Name = "PhoneUpsellToasts"
            phoneUpsellToasts.Parent = game:GetService("CoreGui")
            root = ReactRoblox.createRoot(phoneUpsellToasts)
        end
        OpenModal("PHONE_UPSELL_KEY", InExperienceProviderContainer, {
            Props = {
                children = React.createElement(InGameUpsellContainer, Cryo.Dictionary.join(arg1, {
                    closeUpsell = function()
                        CloseModal("PHONE_UPSELL_KEY")
                        if arg1.closeUpsell then
                            arg1.closeUpsell()
                        end
                    end,
                    onSuccess = function()
                        CloseModal("PHONE_UPSELL_KEY")
                        if arg1.onSuccessBeforeToast then
                            arg1.onSuccessBeforeToast()
                        end
                        root:render(
                            React.createElement("ScreenGui", {
                                IgnoreGuiInset = true,
                                ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
                                ResetOnSpawn = false,
                                DisplayOrder = 0,
                                Enabled = true
                            }, {
                                ContainerFrame = React.createElement("Frame", {
                                    BackgroundTransparency = 1,
                                    Size = UDim2.new(1, 0, 1, 0)
                                }, {
                                    LocalizationProvider = React.createElement(
                                        LocalizationProvider,
                                        {
                                            localization = Localization.new(LocalizationService.RobloxLocaleId)
                                        },
                                        {
                                            StyleProvider = React.createElement(StyleProviderWithDefaultTheme, {}, {
                                                Frame = React.createElement("Frame", {
                                                    BackgroundTransparency = 1,
                                                    Size = UDim2.new(1, 0, 1, 0)
                                                }, {
                                                    Toast = React.createElement(func1, {
                                                        onDismissed = function()
                                                            if arg1.onSuccess then
                                                                arg1.onSuccess()
                                                            end

                                                            root:unmount()
                                                        end
                                                    }, {})
                                                })
                                            })
                                        }
                                    )
                                })
                            })
                        )
                    end
                }))
            },
            DisableBackgroundDismiss = true,
            BlockNonCoreUserInput = GetFFlagNotificationModalSetMenuIsOpen()
        })
    end
}
