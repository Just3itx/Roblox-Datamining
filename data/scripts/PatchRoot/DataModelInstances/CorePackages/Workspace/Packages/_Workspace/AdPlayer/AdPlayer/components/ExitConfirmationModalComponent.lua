-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T05:30:50Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AdPlayerParent = script:FindFirstAncestor("AdPlayer").Parent
local AdsDisplayOrder = require(AdPlayerParent.AdGuiInteractivity).AdsDisplayOrder
local useLocalization = require(AdPlayerParent.Localization).Hooks.useLocalization
local React = require(AdPlayerParent.React)
local Foundation = require(AdPlayerParent.Foundation)
local View = Foundation.View
local FoundationText = Foundation.Text
local Button = Foundation.Button
local ButtonVariant = Foundation.Enums.ButtonVariant
local FillBehavior = Foundation.Enums.FillBehavior
local StateLayerAffordance = Foundation.Enums.StateLayerAffordance

local tbl1 = { confirmationText = "CoreScripts.Ads.Label.RewardedVideoExitConfirmation" }

local function ExitConfirmationModalComponent(tbl2)
    local var1 = useLocalization(tbl1)

    return React.createElement(
        "ScreenGui",
        {
            DisplayOrder = AdsDisplayOrder.Modal,
            IgnoreGuiInset = true,
            Enabled = tbl2.Enabled
        },
        {
            modal = React.createElement(View, {
                tag = "anchor-center-center position-center-center bg-over-media-0 radius-medium padding-x-xxlarge padding-y-xxlarge",
                Size = UDim2.fromOffset(440, 164),
                onActivated = function() end,
                stateLayer = {
                    affordance = StateLayerAffordance.None
                }
            }, {
                React.createElement(FoundationText, {
                    tag = "size-full-1100 position-top-center anchor-top-center text-align-x-left",
                    Text = var1.confirmationText,
                    TextScaled = true
                }),
                buttonContainer = React.createElement(
                    View,
                    {
                        tag = "size-full-1200 anchor-bottom-center position-bottom-center row gap-medium flex-fill"
                    },
                    {
                        cancelExitButton = React.createElement(Button, {
                            text = "Continue",
                            fillBehavior = FillBehavior.Fill,
                            width = UDim.new(1, 0),
                            variant = ButtonVariant.Emphasis,
                            onActivated = tbl2.onCancel
                        }),
                        confirmExitButton = React.createElement(Button, {
                            text = "Exit",
                            fillBehavior = FillBehavior.Fill,
                            width = UDim.new(1, 0),
                            variant = ButtonVariant.Standard,
                            onActivated = tbl2.onConfirm,
                            LayoutOrder = 2
                        })
                    }
                )
            })
        }
    )
end
return ExitConfirmationModalComponent
