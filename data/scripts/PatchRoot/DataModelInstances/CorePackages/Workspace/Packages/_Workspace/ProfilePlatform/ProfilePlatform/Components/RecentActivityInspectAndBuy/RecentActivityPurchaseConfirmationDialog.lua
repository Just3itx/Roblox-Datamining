-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T05:20:52Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfilePlatformParent = script:FindFirstAncestor("ProfilePlatform").Parent

local LocalizationService = game:GetService("LocalizationService")

local React = require(ProfilePlatformParent.React)
local Foundation = require(ProfilePlatformParent.Foundation)

local useLocalization = require(ProfilePlatformParent.Localization).Hooks.useLocalization
local NumberLocalization = require(ProfilePlatformParent.Localization).NumberLocalization

local View = Foundation.View
local FoundationText = Foundation.Text
local Dialog = Foundation.Dialog
local DialogSize = Foundation.Enums.DialogSize
local ButtonVariant = Foundation.Enums.ButtonVariant
local EnumsOrientation = Foundation.Enums.Orientation
local IconName = Foundation.Enums.IconName
local getIconRichText = Foundation.Utility.getIconRichText

local function RecentActivityPurchaseConfirmationDialog(tbl1)
    local var1 = useLocalization({
        buyTitle = "IAPExperience.PurchasePrompt.Header.BuyAvatar",
        buyAction = "IAPExperience.PurchasePrompt.Action.Buy",
        totalPrice = "IAPExperience.PurchasePrompt.Label.TotalPriceV2"
    })

    local var2 = React.useMemo(function(): string
        local var2 = NumberLocalization.localize(tbl1.totalPrice, LocalizationService.RobloxLocaleId)
        return `{getIconRichText(IconName.Robux)} {var2}`
    end, { tbl1.totalPrice, LocalizationService.RobloxLocaleId })

    local onClose = React.useCallback(function()
        if tbl1.isPurchasing then
            return
        end
        tbl1.onCancel()
    end, { tbl1.isPurchasing, tbl1.onCancel })

    return React.createElement(
        Dialog.Root,
        {
            size = DialogSize.Small,
            onClose = onClose,
            hasBackdrop = true,
            disablePortal = false
        },
        {
            DialogTitle = React.createElement(Dialog.Title, { LayoutOrder = 1, text = var1.buyTitle }),
            DialogContent = React.createElement(Dialog.Content, { LayoutOrder = 2 }, {
                PriceTotal = React.createElement(
                    View,
                    {
                        tag = "size-full-1300 padding-bottom-large padding-left-xxsmall padding-right-xxsmall padding-top-small"
                    },
                    {
                        BorderContainer = React.createElement(
                            View,
                            {
                                tag = "row align-x-center align-y-center auto-xy padding-x-large padding-y-xsmall stroke-default radius-medium"
                            },
                            {
                                LeftSide = React.createElement(
                                    View,
                                    {
                                        LayoutOrder = 1,
                                        tag = "row align-y-center gap-small padding-y-xsmall",
                                        Size = UDim2.new(0.5, 0, 1, 0)
                                    },
                                    {
                                        Label = React.createElement(FoundationText, {
                                            LayoutOrder = 1,
                                            Text = var1.totalPrice,
                                            tag = "auto-xy padding-y-xsmall text-title-medium text-align-x-left content-default"
                                        })
                                    }
                                ),
                                RightSide = React.createElement(
                                    View,
                                    {
                                        LayoutOrder = 2,
                                        tag = "row align-x-right align-y-center gap-large padding-y-xsmall",
                                        Size = UDim2.new(0.5, 0, 1, 0)
                                    },
                                    {
                                        Price = React.createElement(FoundationText, {
                                            LayoutOrder = 1,
                                            Text = var2,
                                            tag = "auto-xy padding-y-xsmall text-title-medium text-align-x-right content-emphasis",
                                            RichText = true
                                        })
                                    }
                                )
                            }
                        )
                    }
                )
            }),
            DialogActions = React.createElement(Dialog.Actions, {
                LayoutOrder = 3,
                orientation = EnumsOrientation.Horizontal,
                actions = {{
                    text = var1.buyAction,
                    variant = ButtonVariant.Emphasis,
                    onActivated = tbl1.onConfirm
                }}
            })
        }
    )
end

return RecentActivityPurchaseConfirmationDialog
