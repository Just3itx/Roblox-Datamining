-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T07:41:09Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PurchasePrompt = script:FindFirstAncestor("PurchasePrompt")
local PurchasePromptParent = PurchasePrompt.Parent
local ErrorOccurred = require(PurchasePrompt.Actions.ErrorOccurred)
local SetEconomicRestrictionError = require(PurchasePrompt.Actions.SetEconomicRestrictionError)
local PurchaseCompleteRecieved = require(PurchasePrompt.Actions.PurchaseCompleteRecieved)
local SetPromptState = require(PurchasePrompt.Actions.SetPromptState)
local PromptState = require(PurchasePrompt.Enums.PromptState)
local performSubscriptionPurchase = require(PurchasePrompt.Network.performSubscriptionPurchase)
local ExternalSettings = require(PurchasePrompt.Services.ExternalSettings)
local Network = require(PurchasePrompt.Services.Network)
local Thunk = require(PurchasePrompt.Thunk)
local hideWindow = require(PurchasePrompt.Thunks.hideWindow)
local PurchaseError = require(PurchasePrompt.Enums.PurchaseError)
local IAPExperience = require(PurchasePromptParent.IAPExperience)
local isErrorReasonPrefixWithEconomicRestrictions = IAPExperience.Utility.isErrorReasonPrefixWithEconomicRestrictions
local parseErrorReasonToEconomicRestriction = IAPExperience.Utility.parseErrorReasonToEconomicRestriction

local tbl1 = { ExternalSettings, Network }

local function launchSubscriptionPurchase(arg1)
    return Thunk.new(script.Name, tbl1, function(arg2, arg3)
        local var1 = arg3[ExternalSettings]
        local var2 = arg3[Network]

        if var1.isStudio() then
            arg2:dispatch(PurchaseCompleteRecieved())
            arg2:dispatch(hideWindow())
            return nil
        end

        performSubscriptionPurchase(var2, arg2:getState().promptRequest.id, arg1):catch(function(arg4)
            if isErrorReasonPrefixWithEconomicRestrictions(arg4) then
                local var3 = parseErrorReasonToEconomicRestriction(arg4)
                arg2:dispatch(SetEconomicRestrictionError(var3.violationType, var3.timeoutMinutes))

                arg2:dispatch(ErrorOccurred(PurchaseError.EconomicRestriction))
                return
            end
            arg2:dispatch(ErrorOccurred(arg4))
        end)

        arg2:dispatch(SetPromptState(PromptState.UpsellInProgress))
        arg2:dispatch(hideWindow())
        return nil
    end)
end

return launchSubscriptionPurchase
