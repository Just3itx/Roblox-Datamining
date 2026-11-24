-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T02:21:04Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CurrencyTransfers = script:FindFirstAncestor("CurrencyTransfers")
local MarketplaceService = game:GetService("MarketplaceService")
local Players = game:GetService("Players")

local _createTransferStore = require(CurrencyTransfers.Stores.createTransferStore)
local PromptState = require(CurrencyTransfers.Enums.PromptState)
local TransferOrigination = require(CurrencyTransfers.Enums.TransferOrigination)

local GetFFlagCurrencyTransferSignalRecipientOnComplete = require(CurrencyTransfers.Flags.GetFFlagCurrencyTransferSignalRecipientOnComplete)

local function handleTransferComplete(arg1)
    local transferOrigination = arg1.getTransferOrigination(false)
    local setPromptState = arg1.setPromptState
    local triggerOnClose = arg1.triggerOnClose

    if transferOrigination == TransferOrigination.InExperience then
        local localPlayer = Players.LocalPlayer
        if localPlayer then
            pcall(function()
                MarketplaceService:SignalRobuxTransferCompleted(localPlayer.UserId)
            end)
        end

        if GetFFlagCurrencyTransferSignalRecipientOnComplete() then
            local recipient = arg1.getRecipient(false)
            if recipient then
                pcall(function()
                    MarketplaceService:SignalRobuxTransferCompleted(recipient.targetId)
                end)
            end
        end
    end

    setPromptState(PromptState.TransferComplete)
    triggerOnClose()
end

return handleTransferComplete
