-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T02:21:00Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CurrencyTransfers = script:FindFirstAncestor("CurrencyTransfers")
local CurrencyTransfersParent = CurrencyTransfers.Parent

local FFlagSduiOpenIncomingTransferUpsellAction = require(CurrencyTransfersParent.SharedFlags).FFlagSduiOpenIncomingTransferUpsellAction

local SduiCoreSystem = require(CurrencyTransfersParent.SduiCoreSystem)
local SduiActionType = SduiCoreSystem.SduiActionType
local getSduiActionHandlerRegistry = SduiCoreSystem.getSduiActionHandlerRegistry

local function registerCurrencyTransferSduiActions()
    if not FFlagSduiOpenIncomingTransferUpsellAction then
        return
    end

    local tbl1 = {
        [SduiActionType.OpenIncomingTransferUpsell] = {
            lazyHandler = function()
                return require(CurrencyTransfers.Actions.SduiOpenIncomingTransferUpsellAction)
            end,
            skipUnifiedLogging = false
        }
    }

    getSduiActionHandlerRegistry().registerActionHandlerConfigs(tbl1)
end

return registerCurrencyTransferSduiActions
