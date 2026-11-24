-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T02:30:40Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ContentProvider = game:GetService("ContentProvider")

local CurrencyTransfers = script:FindFirstAncestor("CurrencyTransfers")
local CurrencyTransfersParent = CurrencyTransfers.Parent

local React = require(CurrencyTransfersParent.React)
local SignalsReact = require(CurrencyTransfersParent.SignalsReact)

local getBalanceRequest = require(CurrencyTransfers.NetworkRequests.getBalanceRequest)
local useUserNameFromUserId = require(CurrencyTransfers.Hooks.useUserNameFromUserId)
local TransferLocalizationKeys = require(CurrencyTransfers.Localization.TransferLocalizationKeys)
local transferLocaleFormat = require(CurrencyTransfers.Localization.transferLocaleFormat)

local useDispatch = require(CurrencyTransfersParent.RoactUtils).Hooks.RoactRodux.useDispatch
local NavigateDown = require(CurrencyTransfersParent.NavigationRodux).Thunks.NavigateDown
local AppPage = require(CurrencyTransfersParent.RobloxAppEnums).AppPage
local UrlBuilder = require(CurrencyTransfersParent.UrlBuilder).UrlBuilder
local TransferOrigination = require(CurrencyTransfers.Enums.TransferOrigination)
local WebViewServiceWrapper = require(CurrencyTransfers.Utils.WebViewServiceWrapper)

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
local FailureReason = require(CurrencyTransfers.Enums.FailureReason)

local GetFIntCurrencyTransferMinAmount = require(CurrencyTransfers.Flags.GetFIntCurrencyTransferMinAmount)
local GetFIntCurrencyTransferMaxAmount = require(CurrencyTransfers.Flags.GetFIntCurrencyTransferMaxAmount)

local GetFFlagCurrencyTransferUseBackendTransferLimits = require(CurrencyTransfers.Flags.GetFFlagCurrencyTransferUseBackendTransferLimits)

local GetFFlagCurrencyTransferReceiveLimitExceededError = require(CurrencyTransfers.Flags.GetFFlagCurrencyTransferReceiveLimitExceededError)
local GetFFlagEnableLimitHit2SVUpsell = require(CurrencyTransfers.Flags.GetFFlagEnableLimitHit2SVUpsell)

local TransferRobuxHeader = require(CurrencyTransfers.Components.Generic.TransferRobuxHeader)
local useTransferStore = require(CurrencyTransfers.Hooks.useTransferStore)

local function getErrorMessageAndButton(arg1, arg2, arg3, arg4, arg5, arg6)
    if not arg1 then
        return arg2.GenericError, arg2.TryAgain
    end

    local ok = arg2.OK
    local var1

    if GetFFlagEnableLimitHit2SVUpsell() then
        if arg1 == FailureReason.TransferDailyLimitExceeded then
            if arg6 then
                var1 = arg2.DailyLimitTwoStepVerificationUpsell
                ok = arg2.TurnOnTwoStepVerification
            else
                var1 = arg2.DailyLimitExceeded
            end
        elseif arg1 == FailureReason.TransferMonthlyLimitExceeded then
            if arg6 then
                var1 = arg2.MonthlyLimitTwoStepVerificationUpsell
                ok = arg2.TurnOnTwoStepVerification
            else
                var1 = arg2.MonthlyLimitExceeded
            end
        elseif arg1 == FailureReason.TransferDisabledForUser then
            var1 = arg2.AccountDisabled
        elseif GetFFlagCurrencyTransferReceiveLimitExceededError() and arg1 == FailureReason.ReceiveLimitExceeded then
            var1 = arg2.ReceiveLimitExceeded
        elseif arg1 == FailureReason.ReceiverNotAllowed then
            var1 = transferLocaleFormat.substituteUsername(arg2.ReceiverNotAllowed, arg3 or "")
        elseif arg1 == FailureReason.TransferAmountBelowMinimum then
            var1 = transferLocaleFormat.substituteMinAmount(arg2.TransferAmountBelowMinimum, tostring(arg4))

            ok = arg2.TryAgain
        elseif arg1 == FailureReason.TransferAmountExceedsMaximum or arg1 == FailureReason.TransferAmountExceedsNonSecuredMaximum then
            var1 = transferLocaleFormat.substituteMaxAmount(arg2.TransferAmountExceedsMaximum, tostring(arg5))

            ok = arg2.TryAgain
        else
            var1 = arg2.GenericError
            ok = arg2.TryAgain
        end
    elseif arg1 == FailureReason.TransferDailyLimitExceeded then
        var1 = arg2.DailyLimitExceeded
    elseif arg1 == FailureReason.TransferMonthlyLimitExceeded then
        var1 = arg2.MonthlyLimitExceeded
    elseif arg1 == FailureReason.TransferDisabledForUser then
        var1 = arg2.AccountDisabled
    elseif GetFFlagCurrencyTransferReceiveLimitExceededError() and arg1 == FailureReason.ReceiveLimitExceeded then
        var1 = arg2.ReceiveLimitExceeded
    elseif arg1 == FailureReason.ReceiverNotAllowed then
        var1 = transferLocaleFormat.substituteUsername(arg2.ReceiverNotAllowed, arg3 or "")
    elseif arg1 == FailureReason.TransferAmountBelowMinimum then
        var1 = transferLocaleFormat.substituteMinAmount(arg2.TransferAmountBelowMinimum, tostring(arg4))

        ok = arg2.TryAgain
    elseif arg1 == FailureReason.TransferAmountExceedsMaximum or arg1 == FailureReason.TransferAmountExceedsNonSecuredMaximum then
        var1 = transferLocaleFormat.substituteMaxAmount(arg2.TransferAmountExceedsMaximum, tostring(arg5))

        ok = arg2.TryAgain
    else
        var1 = arg2.GenericError
        ok = arg2.TryAgain
    end

    return var1, ok
end

local GetFFlagCurrencyTransferFocusNavigation = require(CurrencyTransfers.Flags.GetFFlagCurrencyTransferFocusNavigation)
local useTransferSheetFocus = require(CurrencyTransfers.Hooks.useTransferSheetFocus)

local function TransferRobuxErrorSheet(_)
    local var1 = useTransferStore()
    local var2 = useTokens()
    local robuxBalanceAmount = SignalsReact.useSignalState(var1.getRobuxBalanceAmount) or 0
    local balanceReceivedFromApi = var1.getBalanceReceivedFromApi(false)
    local errorTransferModel = var1.getErrorTransferModel(false)
    local recipient = var1.getRecipient(false)
    local recipientUserId = var1.getRecipientUserId(false)
    local triggerOnClose = var1.triggerOnClose
    local var4, var5

    if GetFFlagCurrencyTransferFocusNavigation() then
        var4, var5 = useTransferSheetFocus(triggerOnClose)
    else
        var4 = nil
        var5 = nil
    end

    if not GetFFlagEnableLimitHit2SVUpsell() then
        local failureReason = if errorTransferModel then errorTransferModel.failureReason else nil
        local var6 = failureReason == FailureReason.ReceiverNotAllowed and not recipient and recipientUserId and recipientUserId ~= 0
        local var7 = useUserNameFromUserId(var6 and recipientUserId and recipientUserId ~= 0 and recipientUserId or nil)

        React.useEffect(function()
            if balanceReceivedFromApi then
                return
            end
            getBalanceRequest(nil, var1.getNetworkImpl()):andThen(function(arg1)
                var1.setRobuxBalanceAmount(arg1)
                var1.setBalanceReceivedFromApi(true)
            end):catch(function() end)
        end, { balanceReceivedFromApi })

        local var8 = useLocalization(TransferLocalizationKeys.Presets.TransferRobuxErrorSheet)

        local var9 = SignalsReact.useSignalState(var1.getMinimumTransferAmount)
        local var10 = SignalsReact.useSignalState(var1.getMaximumTransferAmount)
        local var11 = GetFFlagCurrencyTransferUseBackendTransferLimits() and var9 or GetFIntCurrencyTransferMinAmount()
        local var12 = GetFFlagCurrencyTransferUseBackendTransferLimits() and var10 or GetFIntCurrencyTransferMaxAmount()
        local var13 = if recipient and (recipient.targetName or recipient.targetDisplayName) then recipient.targetName or recipient.targetDisplayName else var6 and var7 and var7 ~= "" and var7 or nil
        local var14, text = getErrorMessageAndButton(failureReason, var8, var13 or "", var11, var12, false)

        return React.createElement(
            Sheet.Root,
            {
                preferCenterSheet = true,
                snapPoints = { useScaledValue(300), 0.5 },
                onClose = triggerOnClose,
                ref = var4
            },
            {
                Header = React.createElement(Sheet.Header, {}, {
                    TransferRobuxHeader = React.createElement(TransferRobuxHeader, { titleText = var8.SendRobux or "", robuxBalanceAmount = robuxBalanceAmount })
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
                                Text = var14,
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
                                    ref = var5,
                                    text = text,
                                    onActivated = triggerOnClose,
                                    variant = ButtonVariant.Emphasis,
                                    fillBehavior = FillBehavior.Fill
                                }) }) }
                    ) })
            }
        )
    end

    local var6 = useDispatch()
    local failureReason = if errorTransferModel then errorTransferModel.failureReason else nil
    local var7 = failureReason == FailureReason.ReceiverNotAllowed and not recipient and recipientUserId and recipientUserId ~= 0
    local var8 = useUserNameFromUserId(var7 and recipientUserId and recipientUserId ~= 0 and recipientUserId or nil)
    local isEligibleForElevatedLimitUpsell = if errorTransferModel then errorTransferModel.isEligibleForElevatedLimitUpsell else false
    local var9 = (failureReason == FailureReason.TransferDailyLimitExceeded
        or failureReason == FailureReason.TransferMonthlyLimitExceeded)
        and isEligibleForElevatedLimitUpsell
    local name = if var9 then Enums.IconName.CircleArrowUp else Enums.IconName.TriangleExclamation

    local function handleButtonActivated()
        triggerOnClose()
        if not var9 then
            return
        end

        if var1.getTransferOrigination(false) == TransferOrigination.InExperience then
            local var11 = string.gsub(ContentProvider.BaseUrl:lower(), "/m.", "/www.")
            local url = string.gsub(var11, "http:", "https:") .. "my/account#!/robux"
            WebViewServiceWrapper.new({ url = url, title = "Robux" }):open()
            return
        end
        var6(
            NavigateDown({
                name = AppPage.SettingsSubPage,
                detail = UrlBuilder.static.settings.robux(),
                extraProps = { titleKey = "Feature.AccountSettings.Heading.Tab.Robux" }
            })
        )
    end

    React.useEffect(function()
        if balanceReceivedFromApi then
            return
        end
        getBalanceRequest(nil, var1.getNetworkImpl()):andThen(function(arg1)
            var1.setRobuxBalanceAmount(arg1)
            var1.setBalanceReceivedFromApi(true)
        end):catch(function() end)
    end, { balanceReceivedFromApi })

    local var11 = useLocalization(TransferLocalizationKeys.Presets.TransferRobuxErrorSheet)

    local var12 = SignalsReact.useSignalState(var1.getMinimumTransferAmount)
    local var13 = SignalsReact.useSignalState(var1.getMaximumTransferAmount)
    local var14 = GetFFlagCurrencyTransferUseBackendTransferLimits() and var12 or GetFIntCurrencyTransferMinAmount()
    local var15 = GetFFlagCurrencyTransferUseBackendTransferLimits() and var13 or GetFIntCurrencyTransferMaxAmount()
    local var16 = if recipient and (recipient.targetName or recipient.targetDisplayName) then recipient.targetName or recipient.targetDisplayName else var7 and var8 and var8 ~= "" and var8 or nil
    local var17, text = getErrorMessageAndButton(failureReason, var11, var16 or "", var14, var15, isEligibleForElevatedLimitUpsell)

    return React.createElement(
        Sheet.Root,
        {
            preferCenterSheet = true,
            snapPoints = { useScaledValue(300), 0.5 },
            onClose = triggerOnClose,
            ref = var4
        },
        {
            Header = React.createElement(Sheet.Header, {}, {
                TransferRobuxHeader = React.createElement(TransferRobuxHeader, { titleText = var11.SendRobux or "", robuxBalanceAmount = robuxBalanceAmount })
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
                                ErrorIcon = React.createElement(Icon, { name = name, size = var2.Size.Size_1200, tag = "content-inverse-emphasis" })
                            }
                        ),
                        ErrorMessage = React.createElement(FoundationText, {
                            Text = var17,
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
                                ref = var5,
                                text = text,
                                onActivated = handleButtonActivated,
                                variant = ButtonVariant.Emphasis,
                                fillBehavior = FillBehavior.Fill
                            }) }) }
                ) })
        }
    )
end

return TransferRobuxErrorSheet
