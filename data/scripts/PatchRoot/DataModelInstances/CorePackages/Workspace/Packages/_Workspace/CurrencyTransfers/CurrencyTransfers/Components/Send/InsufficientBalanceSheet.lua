-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T02:21:31Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CurrencyTransfers = script:FindFirstAncestor("CurrencyTransfers")
local CurrencyTransfersParent = CurrencyTransfers.Parent

local React = require(CurrencyTransfersParent.React)
local SignalsReact = require(CurrencyTransfersParent.SignalsReact)
local TransferLocalizationKeys = require(CurrencyTransfers.Localization.TransferLocalizationKeys)
local transferLocaleFormat = require(CurrencyTransfers.Localization.transferLocaleFormat)
local LocalizationService = game:GetService("LocalizationService")
local WebViewServiceWrapper = require(CurrencyTransfers.Utils.WebViewServiceWrapper)
local PurchaseRobuxConstants = require(CurrencyTransfers.Constants.PurchaseRobuxConstants)
local TransferOrigination = require(CurrencyTransfers.Enums.TransferOrigination)
local getBalanceAfterPurchaseWebview = require(CurrencyTransfers.NetworkRequests.getBalanceAfterPurchaseWebview)
local PromptState = require(CurrencyTransfers.Enums.PromptState)
local setTransferPromptState = require(CurrencyTransfers.Actions.Send.setTransferPromptState)

local Foundation = require(CurrencyTransfersParent.Foundation)
local Sheet = Foundation.Sheet
local View = Foundation.View
local FoundationText = Foundation.Text
local Button = Foundation.Button
local Icon = Foundation.Icon
local ButtonVariant = Foundation.Enums.ButtonVariant
local FillBehavior = Foundation.Enums.FillBehavior
local useScaledValue = Foundation.Hooks.useScaledValue
local useTokens = Foundation.Hooks.useTokens
local Enums = Foundation.Enums

local useLocalization = require(CurrencyTransfersParent.Localization).Hooks.useLocalization

local TransferRobuxHeader = require(CurrencyTransfers.Components.Generic.TransferRobuxHeader)
local useTransferStore = require(CurrencyTransfers.Hooks.useTransferStore)
local formatNumber = require(CurrencyTransfers.Utils.formatNumber)

local GetFFlagCurrencyTransferFocusNavigation = require(CurrencyTransfers.Flags.GetFFlagCurrencyTransferFocusNavigation)
local useTransferSheetFocus = require(CurrencyTransfers.Hooks.useTransferSheetFocus)

local function InsufficientBalanceSheet(_)
    local var1 = useTransferStore()
    local var2 = useTokens()
    local var3 = useLocalization(TransferLocalizationKeys.Presets.InsufficientBalanceSheet)
    local robuxBalanceAmount = SignalsReact.useSignalState(var1.getRobuxBalanceAmount) or 0
    local var5 = React.useRef(0)
    local num1 = math.max(0, (SignalsReact.useSignalState(var1.getSelectedAmount) or 0) - robuxBalanceAmount)
    local var6 = formatNumber(LocalizationService.RobloxLocaleId, num1)
    local var7 = React.useMemo(function()
        return transferLocaleFormat.substituteAmount(var3.InsufficientBalance or "", tostring(var6))
    end, { var6, var3.InsufficientBalance })

    local function goBackToInputAndOpenBuyRobux()
        local transferOrigination = var1.getTransferOrigination(false)
        local url = PurchaseRobuxConstants.getPurchaseRobuxUrl()
        local purchaseRobuxWebviewTitle = PurchaseRobuxConstants.PURCHASE_ROBUX_WEBVIEW_TITLE
        WebViewServiceWrapper.new({
            url = url,
            title = purchaseRobuxWebviewTitle,
            closeCallback = function()
                local function applyPromptAfterBalance() -- Luacid: Inlined by compiler; 2 call sites recovered
                    if transferOrigination == TransferOrigination.InExperience then
                        setTransferPromptState(var1, PromptState.TransferConfirm)
                        return
                    end
                    setTransferPromptState(var1, PromptState.TransferInput)
                end

                var5.current += 1
                local current = var5.current
                getBalanceAfterPurchaseWebview(nil, var1.getNetworkImpl()):andThen(function(arg1)
                    if var5.current ~= current then
                        return
                    end
                    var1.setRobuxBalanceAmount(arg1)
                    var1.setBalanceReceivedFromApi(true)
                    applyPromptAfterBalance()
                end):catch(function(_)
                    if var5.current ~= current then
                        return
                    end

                    applyPromptAfterBalance()
                end)
            end
        }):open()
    end

    local function handleClose()
        if var1.getTransferOrigination(false) == TransferOrigination.InExperience then
            var1.triggerOnClose()
            return
        end
        setTransferPromptState(var1, PromptState.TransferInput)
    end

    local var8, var9

    if GetFFlagCurrencyTransferFocusNavigation() then
        var8, var9 = useTransferSheetFocus(handleClose)
    else
        var8 = nil
        var9 = nil
    end

    return React.createElement(
        Sheet.Root,
        {
            preferCenterSheet = true,
            snapPoints = { useScaledValue(300), 0.5 },
            onClose = handleClose,
            ref = var8
        },
        {
            Header = React.createElement(Sheet.Header, {}, {
                TransferRobuxHeader = React.createElement(TransferRobuxHeader, { titleText = var3.SendRobux, robuxBalanceAmount = robuxBalanceAmount })
            }),
            Content = React.createElement(Sheet.Content, { LayoutOrder = 2 }, {
                SheetContentContainer = React.createElement(
                    View,
                    {
                        tag = "col gap-xlarge auto-y size-full-0 align-x-center align-y-center padding-top-xlarge"
                    },
                    {
                        ErrorIconContainer = React.createElement(
                            View,
                            {
                                tag = "size-1200-1200 radius-circle align-x-center align-y-center bg-inverse-emphasis",
                                LayoutOrder = 1
                            },
                            {
                                ErrorIcon = React.createElement(
                                    Icon,
                                    {
                                        name = Enums.IconName.TriangleExclamation,
                                        size = var2.Size.Size_1200,
                                        tag = "content-inverse-emphasis"
                                    }
                                )
                            }
                        ),
                        ErrorMessage = React.createElement(FoundationText, {
                            Text = var7,
                            tag = "text-body-large content-emphasis text-align-x-center auto-y text-wrap",
                            Size = UDim2.new(1, 0, 0, 0),
                            LayoutOrder = 2
                        })
                    }
                )
            }),
            Actions = React.createElement(Sheet.Actions, { LayoutOrder = 3 }, { React.createElement(
                    View,
                    { tag = "col auto-y align-y-center align-x-center size-full-0 gap-small" },
                    { React.createElement(View, { tag = "row auto-y size-full-0 gap-small" }, { React.createElement(Button, {
                                ref = var9,
                                text = var3.BuyRobux or "Buy",
                                onActivated = goBackToInputAndOpenBuyRobux,
                                variant = ButtonVariant.Emphasis,
                                fillBehavior = FillBehavior.Fill
                            }) }) }
                ) })
        }
    )
end

return InsufficientBalanceSheet
