-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T02:21:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CurrencyTransfers = script:FindFirstAncestor("CurrencyTransfers")
local CurrencyTransfersParent = CurrencyTransfers.Parent

local UserInputService = game:GetService("UserInputService")
local React = require(CurrencyTransfersParent.React)

local Foundation = require(CurrencyTransfersParent.Foundation)
local View = Foundation.View
local FoundationText = Foundation.Text
local getIconRichText = Foundation.Utility.getIconRichText
local Enums = Foundation.Enums

local LocalizationService = game:GetService("LocalizationService")

local formatNumber = require(CurrencyTransfers.Utils.formatNumber)

local GetFFlagCurrencyTransferFixHeaderTouchPadding = require(CurrencyTransfers.Flags.GetFFlagCurrencyTransferFixHeaderTouchPadding)

local function TransferRobuxHeader(tbl1)
    local var1 = React.useMemo(function(): string
        local var1 = formatNumber(LocalizationService.RobloxLocaleId, tbl1.robuxBalanceAmount or 0)
        return `{getIconRichText(Enums.IconName.Robux)} {var1}`
    end, { tbl1.robuxBalanceAmount, LocalizationService.RobloxLocaleId })

    local tag = if GetFFlagCurrencyTransferFixHeaderTouchPadding() and UserInputService.TouchEnabled then "row align-y-center align-x-right gap-large padding-right-large" else "row align-y-center align-x-right gap-large"

    return React.createElement(View, { tag = "auto-xy align-y-center align-x-start row" }, {
        LeftSide = React.createElement(
            View,
            {
                LayoutOrder = 1,
                tag = "row gap-small align-y-center align-x-start",
                Size = UDim2.new(0.5, 0, 1, 0)
            },
            {
                Title = React.createElement(FoundationText, {
                    LayoutOrder = 1,
                    Text = `{getIconRichText(Enums.IconName.RobloxPlus)} {tbl1.titleText}`,
                    tag = "auto-xy text-heading-small content-default text-align-x-left",
                    RichText = true
                })
            }
        ),
        RightSide = React.createElement(View, {
            LayoutOrder = 2,
            tag = tag,
            Size = UDim2.new(0.5, 0, 1, 0)
        }, {
            RobuxPrice = React.createElement(
                FoundationText,
                {
                    LayoutOrder = 2,
                    Text = var1,
                    tag = "auto-xy text-label-large content-emphasis text-align-x-right",
                    RichText = true
                }
            )
        })
    })
end

return TransferRobuxHeader
