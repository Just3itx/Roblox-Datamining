-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T02:21:28Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CurrencyTransfers = script:FindFirstAncestor("CurrencyTransfers")
local CurrencyTransfersParent = CurrencyTransfers.Parent

local React = require(CurrencyTransfersParent.React)
local SignalsReact = require(CurrencyTransfersParent.SignalsReact)

local getTransferRequestByIdRequest = require(CurrencyTransfers.NetworkRequests.getTransferRequestByIdRequest)
local useUserNameFromUserId = require(CurrencyTransfers.Hooks.useUserNameFromUserId)
local TransferLocalizationKeys = require(CurrencyTransfers.Localization.TransferLocalizationKeys)
local transferLocaleFormat = require(CurrencyTransfers.Localization.transferLocaleFormat)

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

local useTransferStore = require(CurrencyTransfers.Hooks.useTransferStore)

local function getErrorMessageAndButton(arg1, tbl1, str1: string?) -- Luacid: Inlined by compiler; 1 call site recovered
    if not arg1 then
        return tbl1.GenericError, tbl1.TryAgain
    end

    local ok = tbl1.OK
    local var1

    if arg1 == FailureReason.TransferDisabledForUser then
        var1 = tbl1.AccountDisabled
    elseif arg1 == FailureReason.TransferExpired then
        var1 = transferLocaleFormat.substituteUsername(tbl1.TransferExpired, tostring(str1))
    else
        var1 = tbl1.GenericError
        ok = tbl1.TryAgain
    end

    return var1, ok
end

local GetFFlagCurrencyTransferFocusNavigation = require(CurrencyTransfers.Flags.GetFFlagCurrencyTransferFocusNavigation)
local useTransferSheetFocus = require(CurrencyTransfers.Hooks.useTransferSheetFocus)

local function ReceiveErrorSheet(_)
    local var1 = useTransferStore()
    local var2 = useTokens()
    local var3 = SignalsReact.useSignalState(var1.getErrorTransferModel)
    local var4 = SignalsReact.useSignalState(var1.getSender)
    local var5 = SignalsReact.useSignalState(var1.getRobuxTransfer)
    local transferRequestId = SignalsReact.useSignalState(var1.getTransferRequestId)
    local triggerOnClose = var1.triggerOnClose
    local failureReason = if var3 then var3.failureReason else nil
    local bool1 = failureReason == FailureReason.TransferExpired

    React.useEffect(function()
        if not bool1 or var4 or var5 and var5.sender or not transferRequestId then
            return
        end
        getTransferRequestByIdRequest({ transferRequestId = transferRequestId }, nil, var1.getNetworkImpl()):andThen(function(arg1)
            if arg1 and arg1.transfer and arg1.transfer.sender then
                var1.setSender(arg1.transfer.sender)
            end
        end):catch(
            function() end
        )
    end, {
        bool1,
        transferRequestId,
        var4,
        var5
    })

    local var7 = var4 or (if var5 then var5.sender or nil else nil)
    local targetId = if var7 then var7.targetId else nil
    local var8 = useUserNameFromUserId

    if not (bool1 and targetId) or targetId == 0 then
        targetId = nil
    end

    local var9 = var8(targetId)
    if var7 and (var7.targetName or var7.targetDisplayName) then
        var9 = var7.targetName or var7.targetDisplayName
    elseif not (bool1 and var9) or var9 == "" then
        var9 = nil
    end

    local var10, text = getErrorMessageAndButton(failureReason, useLocalization(TransferLocalizationKeys.Presets.ReceiveErrorSheet), var9)
    local var12, var13

    if GetFFlagCurrencyTransferFocusNavigation() then
        var12, var13 = useTransferSheetFocus(triggerOnClose)
    else
        var12 = nil
        var13 = nil
    end

    return React.createElement(
        Sheet.Root,
        {
            preferCenterSheet = true,
            snapPoints = { useScaledValue(300), 0.5 },
            onClose = triggerOnClose,
            ref = var12
        },
        {
            Content = React.createElement(Sheet.Content, { LayoutOrder = 1 }, {
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
                            Text = var10,
                            tag = "text-body-large content-emphasis text-align-x-center auto-y text-wrap",
                            Size = UDim2.new(1, 0, 0, 0),
                            LayoutOrder = 2
                        })
                    }
                )
            }),
            Actions = React.createElement(Sheet.Actions, { LayoutOrder = 2 }, { React.createElement(
                    View,
                    { tag = "col auto-y align-y-center align-x-center size-full-0 gap-small" },
                    { React.createElement(View, { tag = "row auto-y size-full-0 gap-small" }, { React.createElement(Button, {
                                ref = var13,
                                text = text,
                                onActivated = triggerOnClose,
                                variant = ButtonVariant.Emphasis,
                                fillBehavior = FillBehavior.Fill
                            }) }) }
                ) })
        }
    )
end

return ReceiveErrorSheet
