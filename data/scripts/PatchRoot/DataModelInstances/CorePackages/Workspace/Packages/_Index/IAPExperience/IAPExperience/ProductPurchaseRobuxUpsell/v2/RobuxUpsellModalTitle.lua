-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T01:20:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent

local React = require(scriptParentParentParentParent.React)

local Foundation = require(scriptParentParentParentParent.Foundation)
local FoundationText = Foundation.Text
local IconButton = Foundation.IconButton
local IconSize = Foundation.Enums.IconSize
local View = Foundation.View

local LocalizationService = game:GetService("LocalizationService")
local useLocalization = require(scriptParentParentParentParent.Localization).Hooks.useLocalization

local formatNumber = require(scriptParentParentParent.Utility.formatNumber)

local function RobuxUpsellModalTitle(tbl1)
    local var1 = useLocalization({
        NeedMoreRobux = "IAPExperience.RobuxUpsell.Text.NeedMoreRobux",
        CurrentBalance = "IAPExperience.InsufficientRobux.Text.CurrentBalance"
    })

    return React.createElement(
        View,
        {
            padding = {
                right = UDim.new(0, -12),
                left = UDim.new(0, -12)
            },
            tag = "size-full-300"
        },
        {
            TitleArea = React.createElement(View, {
                tag = "col gap-xsmall size-full align-x-center"
            }, {
                Title = React.createElement(FoundationText, {
                    LayoutOrder = 1,
                    Size = UDim2.new(1, 0, 0, 0),
                    Text = var1.NeedMoreRobux,
                    tag = "auto-xy text-heading-small content-emphasis"
                }),
                SubTitle = React.createElement(FoundationText, {
                    LayoutOrder = 2,
                    Size = UDim2.new(1, 0, 0, 0),
                    Text = var1.CurrentBalance .. " " .. utf8.char(57346) .. formatNumber(LocalizationService.RobloxLocaleId, tbl1.balanceAmount),
                    tag = "auto-xy text-body-medium content-default"
                })
            }),
            CloseButton = React.createElement(
                IconButton,
                {
                    size = IconSize.Medium,
                    icon = "icons/navigation/close",
                    onActivated = tbl1.cancelPurchaseActivated
                }
            )
        }
    )
end

return RobuxUpsellModalTitle
