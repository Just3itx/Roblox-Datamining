-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T07:40:57Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PurchasePrompt = script:FindFirstAncestor("PurchasePrompt")
local ErrorOccurred = require(PurchasePrompt.Actions.ErrorOccurred)

local PurchaseError = require(PurchasePrompt.Enums.PurchaseError)

local Counter = require(PurchasePrompt.Enums.Counter)
local sendCounter = require(PurchasePrompt.Thunks.sendCounter)

local Network = require(PurchasePrompt.Services.Network)
local Analytics = require(PurchasePrompt.Services.Analytics)
local ExternalSettings = require(PurchasePrompt.Services.ExternalSettings)
local Thunk = require(PurchasePrompt.Thunk)
local PromptState = require(PurchasePrompt.Enums.PromptState)

local tbl1 = { Analytics, Network, ExternalSettings }

local function handleNativePurchaseFailureOrCancel()
    return Thunk.new(script.Name, tbl1, function(arg1, _)
        if arg1:getState().promptState == PromptState.BlackbirdUpsellInProgress then
            return
        end

        arg1:dispatch(ErrorOccurred(PurchaseError.InvalidFundsUnknown))
        arg1:dispatch(sendCounter(Counter.UpsellFailedNativePurchase))
    end)
end

return handleNativePurchaseFailureOrCancel
