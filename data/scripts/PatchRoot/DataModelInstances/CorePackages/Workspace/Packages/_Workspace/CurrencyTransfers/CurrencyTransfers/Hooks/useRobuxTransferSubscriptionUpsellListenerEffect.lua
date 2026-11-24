-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T02:40:46Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MarketplaceService = game:GetService("MarketplaceService")

local CurrencyTransfers = script:FindFirstAncestor("CurrencyTransfers")
local CurrencyTransfersParent = CurrencyTransfers.Parent
local React = require(CurrencyTransfersParent.React)
local LoggingProtocol = require(CurrencyTransfersParent.LoggingProtocol)
local SharedFlags = require(CurrencyTransfersParent.SharedFlags)

local CurrencyTransferTelemetry = require(CurrencyTransfers.Events.CurrencyTransferTelemetry)
local TransferOrigination = require(CurrencyTransfers.Enums.TransferOrigination)

local function useRobuxTransferSubscriptionUpsellListenerEffect(callback: (...any) -> (...any))
    React.useEffect(function()
        if not SharedFlags.GetEngineFeatureEnablePromptRobuxTransferDedicatedUpsellEvent() then
            return function() end
        end

        local connection = MarketplaceService.PromptRobuxTransferSubscriptionUpsellRequested:Connect(function()
            LoggingProtocol.default:logRobloxTelemetryCounter(
                CurrencyTransferTelemetry.CurrencyTransferEngineUpsellSignalReceivedCounter,
                1,
                {
                    transferOrigination = tostring(TransferOrigination.InExperience)
                }
            )
            callback()
        end)

        return function()
            if connection then
                connection:Disconnect()
                connection = nil
            end
        end
    end, { callback })
end

return useRobuxTransferSubscriptionUpsellListenerEffect
