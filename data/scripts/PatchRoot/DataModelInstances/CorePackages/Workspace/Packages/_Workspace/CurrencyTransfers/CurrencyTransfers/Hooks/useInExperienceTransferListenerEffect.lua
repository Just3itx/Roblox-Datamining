-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T02:40:44Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")
local MarketplaceService = game:GetService("MarketplaceService")
local Players = game:GetService("Players")

local CurrencyTransfers = script:FindFirstAncestor("CurrencyTransfers")
local CurrencyTransfersParent = CurrencyTransfers.Parent
local React = require(CurrencyTransfersParent.React)
local LoggingProtocol = require(CurrencyTransfersParent.LoggingProtocol)

local CurrencyTransferTelemetry = require(CurrencyTransfers.Events.CurrencyTransferTelemetry)
local TransferDirection = require(CurrencyTransfers.Enums.TransferDirection)
local TransferOrigination = require(CurrencyTransfers.Enums.TransferOrigination)

local _InExperienceTransferFlow = require(CurrencyTransfers.Flows.InExperienceTransferFlow)

local function useInExperienceTransferListenerEffect(callback: (...any) -> (...any))
    React.useEffect(function()
        local connection = MarketplaceService.PromptRobuxTransferRequested:Connect(function(player: Instance, jsonResponse: string)
            if player ~= Players.LocalPlayer then
                return
            end

            local success, result = pcall(function()
                return HttpService:JSONDecode(jsonResponse)
            end)
            if not success then
                warn("[InExperienceTransfer] Failed to decode transfer response")
            end
            if not success or not result then
                return
            end

            LoggingProtocol.default:logRobloxTelemetryCounter(
                CurrencyTransferTelemetry.CurrencyTransferEngineSignalReceivedCounter,
                1,
                {
                    direction = tostring(TransferDirection.Send),
                    transferOrigination = tostring(TransferOrigination.InExperience)
                }
            )
            callback(result)
        end)

        return function()
            if connection then
                connection:Disconnect()
                connection = nil
            end
        end
    end, { callback })
end

return useInExperienceTransferListenerEffect
