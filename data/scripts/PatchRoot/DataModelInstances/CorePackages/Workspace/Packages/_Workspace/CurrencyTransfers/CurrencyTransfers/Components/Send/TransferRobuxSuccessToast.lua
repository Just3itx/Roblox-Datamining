-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T02:30:45Z
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

local handleTransferComplete = require(CurrencyTransfers.Actions.Send.handleTransferComplete)

local useTransferStore = require(CurrencyTransfers.Hooks.useTransferStore)

local formatNumber = require(CurrencyTransfers.Utils.formatNumber)

local function TransferRobuxSuccessToast(_)
    local var1 = useLocalization(TransferLocalizationKeys.Presets.TransferRobuxSuccessToast)

    local var2 = useTransferStore()
    local var3 = SignalsReact.useSignalState(var2.getSelectedAmount)

    local var4 = if var3 then formatNumber(LocalizationService.RobloxLocaleId, var3) else "0"

    local title = React.useMemo(function()
        return transferLocaleFormat.substituteAmount(var1.SuccessNotification, tostring(var4))
    end, { var4, var1.SuccessNotification })

    local var6 = React.useRef(nil)
    React.useEffect(function()
        if var6.current then
            task.cancel(var6.current)
        end

        var6.current = task.delay(5, function()
            handleTransferComplete(var2)
        end)

        return function()
            if var6.current then
                task.cancel(var6.current)
                var6.current = nil
            end
        end
    end, {})

    return React.createElement(Snackbar, {
        title = title,
        icon = {
            name = Enums.IconName.CircleCheck,
            variant = Enums.IconVariant.Filled
        },
        Position = UDim2.new(0.5, 0, 0, 50),
        AnchorPoint = Vector2.new(0.5, 0),
        Size = UDim2.new(1, 0, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        ZIndex = 100,
        onClose = function()
            handleTransferComplete(var2)
        end
    })
end

return TransferRobuxSuccessToast
