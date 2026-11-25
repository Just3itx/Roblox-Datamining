-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T12:10:47Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local React = require(script.Parent.Parent.React)
local Localization = require(script.Parent.Parent.Localization)
local Foundation = require(script.Parent.Parent.Foundation)
local LegallySensitiveContent = require(script.Parent.Parent.LegallySensitiveContent)

local Button = Foundation.Button
local Dialog = Foundation.Dialog
local View = Foundation.View
local ButtonVariant = Foundation.Enums.ButtonVariant
local DialogSize = Foundation.Enums.DialogSize
local useLocalization = Localization.Hooks.useLocalization
local ConsentName = LegallySensitiveContent.ConsentName
local useLegallySensitiveContentAndActions = LegallySensitiveContent.useLegallySensitiveContentAndActions

local LinkingProtocol = require(script.Parent.Parent.LinkingProtocol).LinkingProtocol

local AvatarCreationService = game:GetService("AvatarCreationService")
local BrowserService = game:GetService("BrowserService")
local UserInputService = game:GetService("UserInputService")

return function(tbl1)
    local var1 = useLocalization({
        title = "AvatarGeneration.SelfieConsent.Title",
        bodyText = "AvatarGeneration.SelfieConsent.BodyTextLink",
        privacyLinkText = "AvatarGeneration.SelfieConsent.PrivacyLinkText",
        agreeButton = "AvatarGeneration.SelfieConsent.AgreeButton",
        cancelButton = "AvatarGeneration.SelfieConsent.CancelButton"
    })

    local _, var2 = useLegallySensitiveContentAndActions(ConsentName.PhotoToAvatar, "in-experience-photo-to-avatar-selfie-consent")

    return React.createElement(Dialog.Root, {
        size = DialogSize.Large
    }, {
        DialogTitle = React.createElement(Dialog.Title, { text = var1.title }),
        DialogContent = React.createElement(Dialog.Content, nil, {
            DialogView = React.createElement(View, {
                tag = "col fill auto-xy items-start gap-medium"
            }, {
                DialogContentText = React.createElement(Dialog.Text, { Text = var1.bodyText }),
                DialogFooter = React.createElement(Button, {
                    text = var1.privacyLinkText,
                    variant = ButtonVariant.Link,
                    onActivated = function()
                        if UserInputService:GetPlatform() == Enum.Platform.Android then
                            BrowserService:OpenBrowserWindow(
                                "https://en.help.roblox.com/hc/en-us/articles/115004630823-Roblox-Privacy-and-Cookie-Policy"
                            )
                            return
                        end
                        LinkingProtocol.default:openURL(
                            "https://en.help.roblox.com/hc/en-us/articles/115004630823-Roblox-Privacy-and-Cookie-Policy"
                        )
                    end
                })
            })
        }),
        DialogActions = React.createElement(Dialog.Actions, {
            LayoutOrder = 3,
            actions = {
                {
                    text = var1.agreeButton,
                    variant = ButtonVariant.Emphasis,
                    onActivated = function()
                        AvatarCreationService:HandleSelfieConsentResult(true)
                        tbl1.displaySelfieConsent(false)
                        var2.grantOneTimeUserConsentWithAuditing(
                            nil,
                            {
                                privacyPolicyLink = "https://en.help.roblox.com/hc/en-us/articles/115004630823-Roblox-Privacy-and-Cookie-Policy"
                            }
                        )
                    end
                },
                {
                    text = var1.cancelButton,
                    variant = ButtonVariant.Standard,
                    onActivated = function()
                        AvatarCreationService:HandleSelfieConsentResult(false)
                        tbl1.displaySelfieConsent(false)
                    end
                }
            }
        })
    })
end
