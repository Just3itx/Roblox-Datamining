-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T01:21:01Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent

local React = require(scriptParentParentParentParent.React)

local Foundation = require(scriptParentParentParentParent.Foundation)
local View = Foundation.View
local FoundationText = Foundation.Text

local LocalizationService = game:GetService("LocalizationService")
local useLocalization = require(scriptParentParentParentParent.Localization).Hooks.useLocalization

local formatNumber = require(scriptParentParentParent.Utility.formatNumber)

local _GetUpsellSuggestionsTypes = require(scriptParentParentParent.Api.PaymentsGateway.GetUpsellSuggestionsTypes)
local _BadgeType = require(scriptParentParentParent.Enums.BadgeType)
local _VirtualItemBadgeType = require(scriptParentParentParent.Enums.VirtualItemBadgeType)

local function RobuxUpsellModalUpsellDetailsWithBonus(tbl1)
    local var1 = useLocalization(
        {
            MoreRobux = "IAPExperience.RobuxUpsell.Text.MoreRobux",
            Bonus = "IAPExperience.RobuxUpsell.Text.Bonus"
        }
    )

    return React.createElement(View, {
        LayoutOrder = tbl1.layoutOrder,
        tag = "flex-x-between\tflex-y-fill size-full-1700 radius-medium padding-x-large padding-y-medium row bg-surface-300 stroke-emphasis stroke-standard"
    }, {
        LeftSide = React.createElement(View, {
            LayoutOrder = 1,
            tag = "auto-xy col align-y-top align-x-left gap-small"
        }, {
            BonusLabel = React.createElement(
                FoundationText,
                {
                    LayoutOrder = 1,
                    Text = var1.MoreRobux,
                    tag = "auto-xy text-label-small content-default"
                }
            ),
            RobuxAmount = React.createElement(FoundationText, {
                LayoutOrder = 2,
                Text = utf8.char(57346) .. " " .. formatNumber(LocalizationService.RobloxLocaleId, tbl1.robuxAmount) .. " + " .. formatNumber(LocalizationService.RobloxLocaleId, tbl1.bonusAmount) .. " " .. var1.Bonus,
                tag = "auto-xy text-title-large content-emphasis text-align-x-left"
            })
        }),
        RightSide = React.createElement(View, {
            LayoutOrder = 2,
            tag = "auto-xy row align-y-center align-x-right"
        }, {
            RobuxPrice = React.createElement(
                FoundationText,
                {
                    Text = tbl1.priceString or "",
                    tag = "auto-xy text-title-large content-emphasis text-align-x-right"
                }
            )
        })
    })
end

return RobuxUpsellModalUpsellDetailsWithBonus
