-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T02:21:29Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CurrencyTransfers = script:FindFirstAncestor("CurrencyTransfers")
local CurrencyTransfersParent = CurrencyTransfers.Parent

local React = require(CurrencyTransfersParent.React)
local TransferLocalizationKeys = require(CurrencyTransfers.Localization.TransferLocalizationKeys)
local transferLocaleFormat = require(CurrencyTransfers.Localization.transferLocaleFormat)
local SignalsReact = require(CurrencyTransfersParent.SignalsReact)
local LocalizationService = game:GetService("LocalizationService")

local Foundation = require(CurrencyTransfersParent.Foundation)
local Snackbar = Foundation.Snackbar
local Enums = Foundation.Enums

local useLocalization = require(CurrencyTransfersParent.Localization).Hooks.useLocalization

local handleReceiveComplete = require(CurrencyTransfers.Actions.Receive.handleReceiveComplete)

local useTransferStore = require(CurrencyTransfers.Hooks.useTransferStore)

local formatNumber = require(CurrencyTransfers.Utils.formatNumber)

local function ReceiveRobuxSuccessToast(_)
    local var1 = useLocalization(TransferLocalizationKeys.Presets.ReceiveRobuxSuccessToast)

    local var2 = useTransferStore()
    local var3 = SignalsReact.useSignalState(var2.getRobuxTransfer)
    local var4 = SignalsReact.useSignalState(var2.getIsAlreadyAccepted)

    local var5 = if var3 then var3.receivingAmount or var3.transferAmount else 0
    local var6 = formatNumber(LocalizationService.RobloxLocaleId, var5)
    local title = React.useMemo(function()
        if var4 then
            return var1.AlreadyAcceptedNotification
        end
        return transferLocaleFormat.substituteAmount(var1.SuccessNotification, tostring(var6))
    end, {
        var4,
        var6,
        var1.SuccessNotification,
        var1.AlreadyAcceptedNotification
    })

    local var8 = React.useRef(nil)
    React.useEffect(function()
        if var8.current then
            task.cancel(var8.current)
        end

        var8.current = task.delay(5, function()
            handleReceiveComplete(var2)
        end)

        return function()
            if var8.current then
                task.cancel(var8.current)
                var8.current = nil
            end
        end
    end, {})

    return React.createElement(Snackbar, {
        title = title,
        icon = not var4 and {
            name = Enums.IconName.CircleCheck,
            variant = Enums.IconVariant.Filled
        } or nil,
        Position = UDim2.new(0.5, 0, 0, 50),
        AnchorPoint = Vector2.new(0.5, 0),
        Size = UDim2.new(1, 0, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        ZIndex = 100,
        onClose = function()
            handleReceiveComplete(var2)
        end
    })
end

return ReceiveRobuxSuccessToast
