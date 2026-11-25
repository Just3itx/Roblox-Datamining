-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T05:20:51Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfilePlatform = script:FindFirstAncestor("ProfilePlatform")
local ProfilePlatformParent = ProfilePlatform.Parent

local LocalizationService = game:GetService("LocalizationService")

local React = require(ProfilePlatformParent.React)
local Foundation = require(ProfilePlatformParent.Foundation)

local useLocalization = require(ProfilePlatformParent.Localization).Hooks.useLocalization
local NumberLocalization = require(ProfilePlatformParent.Localization).NumberLocalization

local useOpenRobuxUpsell = require(ProfilePlatform.Components.InspectAvatar.useOpenRobuxUpsell)

local View = Foundation.View
local FoundationText = Foundation.Text
local Dialog = Foundation.Dialog
local DialogSize = Foundation.Enums.DialogSize
local ButtonVariant = Foundation.Enums.ButtonVariant
local EnumsOrientation = Foundation.Enums.Orientation
local IconName = Foundation.Enums.IconName
local getIconRichText = Foundation.Utility.getIconRichText

local function AmountLine(tbl1)
    local var1 = NumberLocalization.localize(tbl1.amount, LocalizationService.RobloxLocaleId)
    local str1 = if tbl1.isAlert then "text-title-medium content-alert" else "text-body-medium content-default"

    return React.createElement(
        View,
        {
            LayoutOrder = tbl1.layoutOrder,
            tag = "row align-y-center gap-large size-full-0 auto-y"
        },
        {
            Label = React.createElement(View, { LayoutOrder = 1, tag = "fill auto-y" }, {
                Text = React.createElement(FoundationText, { Text = tbl1.label, tag = `auto-xy text-align-x-left {str1}` })
            }),
            Amount = React.createElement(View, { LayoutOrder = 2, tag = "auto-xy" }, {
                Text = React.createElement(FoundationText, {
                    Text = `{getIconRichText(IconName.Robux)} {var1}`,
                    RichText = true,
                    tag = `auto-xy text-align-x-right {str1}`
                })
            })
        }
    )
end

local function RecentActivityInsufficientRobuxDialog(tbl1)
    local totalPrice = tbl1.totalPrice
    local robuxBalance = tbl1.robuxBalance
    local amount = math.max(totalPrice - robuxBalance, 0)

    local var1 = useLocalization({
        title = "IAPExperience.InsufficientRobux.Title.InsufficientRobux",
        currentBalance = "IAPExperience.InsufficientRobux.Text.CurrentBalance",
        missingRobux = "IAPExperience.InsufficientRobux.Text.MissingRobux",
        orderTotal = "IAPExperience.PurchasePrompt.Label.TotalPriceV2",
        buyRobux = "IAPExperience.InsufficientRobux.Action.BuyRobux"
    })

    local onActivated = useOpenRobuxUpsell(totalPrice, tbl1.onClose)

    return React.createElement(
        Dialog.Root,
        {
            size = DialogSize.Small,
            onClose = tbl1.onClose,
            hasBackdrop = true,
            disablePortal = false
        },
        {
            Title = React.createElement(Dialog.Title, { LayoutOrder = 1, text = var1.title }),
            Content = React.createElement(Dialog.Content, { LayoutOrder = 2 }, {
                PriceBoxPadding = React.createElement(View, {
                    tag = "size-full-0 auto-y padding-xxsmall"
                }, {
                    PriceBox = React.createElement(
                        View,
                        {
                            tag = "col gap-large size-full-0 auto-y padding-medium stroke-standard stroke-default radius-medium"
                        },
                        {
                            BalanceLines = React.createElement(View, {
                                LayoutOrder = 1,
                                tag = "col gap-xsmall size-full-0 auto-y"
                            }, {
                                CurrentBalance = React.createElement(AmountLine, { layoutOrder = 1, label = var1.currentBalance, amount = robuxBalance }),
                                MissingRobux = React.createElement(AmountLine, { layoutOrder = 2, label = var1.missingRobux, amount = amount, isAlert = true })
                            }),
                            OrderTotal = React.createElement(AmountLine, { layoutOrder = 2, label = var1.orderTotal, amount = totalPrice })
                        }
                    )
                })
            }),
            Actions = React.createElement(Dialog.Actions, {
                LayoutOrder = 3,
                orientation = EnumsOrientation.Horizontal,
                actions = {{
                    text = var1.buyRobux,
                    variant = ButtonVariant.Emphasis,
                    onActivated = onActivated
                }}
            })
        }
    )
end

return RecentActivityInsufficientRobuxDialog
