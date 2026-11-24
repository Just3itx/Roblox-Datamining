-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T02:30:44Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CurrencyTransfers = script:FindFirstAncestor("CurrencyTransfers")
local CurrencyTransfersParent = CurrencyTransfers.Parent

local React = require(CurrencyTransfersParent.React)
local SignalsReact = require(CurrencyTransfersParent.SignalsReact)
local LocalizationService = game:GetService("LocalizationService")

local TransferLocalizationKeys = require(CurrencyTransfers.Localization.TransferLocalizationKeys)
local transferLocaleFormat = require(CurrencyTransfers.Localization.transferLocaleFormat)

local Foundation = require(CurrencyTransfersParent.Foundation)
local Sheet = Foundation.Sheet
local View = Foundation.View
local FoundationText = Foundation.Text
local Icon = Foundation.Icon
local Button = Foundation.Button
local ButtonVariant = Foundation.Enums.ButtonVariant
local FillBehavior = Foundation.Enums.FillBehavior
local useScaledValue = Foundation.Hooks.useScaledValue
local useTokens = Foundation.Hooks.useTokens
local Enums = Foundation.Enums

local useLocalization = require(CurrencyTransfersParent.Localization).Hooks.useLocalization

local handleTransferComplete = require(CurrencyTransfers.Actions.Send.handleTransferComplete)

local TransferRobuxHeader = require(CurrencyTransfers.Components.Generic.TransferRobuxHeader)

local useTransferStore = require(CurrencyTransfers.Hooks.useTransferStore)
local useUpdatedRobuxBalance = require(CurrencyTransfers.Hooks.useUpdatedRobuxBalance)

local formatNumber = require(CurrencyTransfers.Utils.formatNumber)

local GetFFlagCurrencyTransferFocusNavigation = require(CurrencyTransfers.Flags.GetFFlagCurrencyTransferFocusNavigation)
local useTransferSheetFocus = require(CurrencyTransfers.Hooks.useTransferSheetFocus)

local function TransferRobuxSuccessModal(_)
    local var1 = useTransferStore()
    local var2 = useTokens()

    local robuxBalanceAmount = useUpdatedRobuxBalance(var1)
    local var4 = SignalsReact.useSignalState(var1.getSelectedAmount)
    local var5 = useScaledValue(300)

    local var6 = useLocalization(TransferLocalizationKeys.Presets.TransferRobuxSuccessModal)

    local var7 = if var4 then formatNumber(LocalizationService.RobloxLocaleId, var4) else "0"

    local var8 = React.useMemo(function()
        return transferLocaleFormat.substituteAmount(var6.SuccessNotification, tostring(var7))
    end, { var7, var6.SuccessNotification })

    local function onComplete()
        handleTransferComplete(var1)
    end

    local var9, var10

    if GetFFlagCurrencyTransferFocusNavigation() then
        var9, var10 = useTransferSheetFocus(onComplete)
    else
        var9 = nil
        var10 = nil
    end

    return React.createElement(
        Sheet.Root,
        {
            preferCenterSheet = true,
            snapPoints = { var5, 0.5 },
            onClose = onComplete,
            ref = var9
        },
        {
            Header = React.createElement(Sheet.Header, {}, {
                TransferRobuxHeader = React.createElement(TransferRobuxHeader, { titleText = var6.SendRobux or "", robuxBalanceAmount = robuxBalanceAmount })
            }),
            Content = React.createElement(Sheet.Content, { LayoutOrder = 2 }, {
                SheetContentContainer = React.createElement(
                    View,
                    {
                        tag = "col align-x-center align-y-center gap-xlarge size-full-0 auto-y padding-top-xlarge"
                    },
                    {
                        SuccessIcon = React.createElement(
                            Icon,
                            {
                                name = Enums.IconName.CircleCheck,
                                size = var2.Size.Size_1200,
                                tag = "auto-xy",
                                LayoutOrder = 1
                            }
                        ),
                        SuccessMessage = React.createElement(FoundationText, {
                            Text = var8,
                            tag = "auto-y text-body-large text-wrap text-align-x-center content-emphasis",
                            Size = UDim2.new(1, 0, 0, 0),
                            LayoutOrder = 2
                        })
                    }
                )
            }),
            Actions = React.createElement(Sheet.Actions, { LayoutOrder = 3 }, { React.createElement(
                    View,
                    { tag = "col align-x-center align-y-center gap-small size-full-0 auto-y" },
                    { React.createElement(View, { tag = "row gap-small size-full-0 auto-y" }, { React.createElement(Button, {
                                ref = var10,
                                text = var6.OK,
                                onActivated = onComplete,
                                variant = ButtonVariant.Emphasis,
                                fillBehavior = FillBehavior.Fill
                            }) }) }
                ) })
        }
    )
end

return TransferRobuxSuccessModal
