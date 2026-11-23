-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T05:11:28Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AdGuiInteractivity = script:FindFirstAncestor("AdGuiInteractivity")
local AdGuiInteractivityParent = AdGuiInteractivity.Parent
local React = require(AdGuiInteractivityParent.React)
local LinkingProtocol = require(AdGuiInteractivityParent.LinkingProtocol)
local Foundation = require(AdGuiInteractivityParent.Foundation)
local Localization = require(AdGuiInteractivityParent.Localization)

local AdsInteractivityTelemetry = require(AdGuiInteractivity.AdsInteractivityTelemetry)

local default = LinkingProtocol.LinkingProtocol.default
local Dialog = Foundation.Dialog
local View = Foundation.View
local Button = Foundation.Button
local DialogSize = Foundation.Enums.DialogSize
local ButtonVariant = Foundation.Enums.ButtonVariant
local InputSize = Foundation.Enums.InputSize
local useLocalization = Localization.Hooks.useLocalization

local str1 = game:DefineFastString("ImmersiveBrandedAdsLearnMoreUrl", "www.roblox.com")

return function(tbl1)
    local advertiserName = tbl1.advertiserName or ""

    local var1 = useLocalization({
        WhyThisAdText = "CoreScripts.Ads.Label.WhyThisAd",
        CloseButtonText = "CoreScripts.Ads.Action.Close",
        DynamicAdvertiserBodyText = {
            "CoreScripts.Ads.ImmersiveBrandedAds.WhyThisAd",
            AdvertiserName = advertiserName
        },
        StaticBodyText = "CoreScripts.Ads.Label.InExperienceDisclosureStatic",
        LearnMoreLinkText = "InGame.CommonUI.Badge.Popup.LearnMoreLink"
    })

    local staticBodyText = var1.StaticBodyText
    if advertiserName ~= "" then
        staticBodyText = var1.DynamicAdvertiserBodyText
    end

    local onActivated = React.useCallback(function()
        default:openURL(str1):catch(function(_)
            AdsInteractivityTelemetry.logImmersiveBrandedAdLinkingFailedCounter("whyThisAd.learnMore")
            tbl1.onDismiss()
        end)
    end, { tbl1.onDismiss })

    local onClose = React.useCallback(function(_)
        tbl1.onDismiss()
    end, { tbl1.onDismiss })

    return React.createElement(React.Fragment, nil, {
        dialog = React.createElement(Dialog.Root, {
            size = DialogSize.Small,
            onClose = onClose
        }, {
            dialogTitle = React.createElement(Dialog.Title, { text = var1.WhyThisAdText }),
            dialogContent = React.createElement(Dialog.Content, nil, {
                content = React.createElement(View, { tag = "col size-full-0 auto-y gap-small" }, {
                    dialogText = React.createElement(Dialog.Text, { LayoutOrder = 1, Text = staticBodyText }),
                    link = React.createElement(Button, {
                        LayoutOrder = 2,
                        text = var1.LearnMoreLinkText,
                        variant = ButtonVariant.Link,
                        onActivated = onActivated,
                        icon = "icons/navigation/externallink",
                        size = InputSize.Small
                    })
                })
            }),
            dialogActions = React.createElement(
                Dialog.Actions,
                {
                    actions = {{
                        text = var1.CloseButtonText,
                        variant = ButtonVariant.Standard,
                        onActivated = tbl1.onDismiss
                    }}
                }
            )
        }),
        modal = React.createElement("TextButton", { Text = "", BackgroundTransparency = 1, Size = UDim2.new(0, 0, 0, 0), Modal = true })
    })
end
