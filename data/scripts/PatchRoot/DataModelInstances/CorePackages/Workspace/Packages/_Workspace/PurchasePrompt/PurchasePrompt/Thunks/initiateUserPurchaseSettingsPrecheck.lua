-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T07:41:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PurchasePrompt = script:FindFirstAncestor("PurchasePrompt")
local PurchasePromptParent = PurchasePrompt.Parent

local UpsellFlow = require(PurchasePrompt.Enums.UpsellFlow)
local Network = require(PurchasePrompt.Services.Network)
local checkUserPurchaseSettings = require(PurchasePrompt.Network.checkUserPurchaseSettings)
local getUpsellFlow = require(PurchasePrompt.NativeUpsell.getUpsellFlow)
local Analytics = require(PurchasePrompt.Services.Analytics)
local ExternalSettings = require(PurchasePrompt.Services.ExternalSettings)
local ErrorOccurred = require(PurchasePrompt.Actions.ErrorOccurred)
local SetEconomicRestrictionError = require(PurchasePrompt.Actions.SetEconomicRestrictionError)
local PurchaseError = require(PurchasePrompt.Enums.PurchaseError)
local Thunk = require(PurchasePrompt.Thunk)
local initiatePurchasePrecheck = require(PurchasePrompt.Thunks.initiatePurchasePrecheck)

local SetPromptState = require(PurchasePrompt.Actions.SetPromptState)
local PromptState = require(PurchasePrompt.Enums.PromptState)

local IAPExperience = require(PurchasePromptParent.IAPExperience)
local CheckUserPurchaseSettingsFailureReason = IAPExperience.Enums.CheckUserPurchaseSettingsFailureReason

local mapCheckUserPurchaseSettingsFailureReasonToViolationType = IAPExperience.Utility.mapCheckUserPurchaseSettingsFailureReasonToViolationType
local EconomicRestrictionsViolationType = IAPExperience.Enums.EconomicRestrictionsViolationType

local tbl1 = { Analytics, Network, ExternalSettings }

local function validateResult(arg1): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    if arg1 == nil then
        return false
    end

    local bool1 = arg1.isEligible == nil or arg1.failureReason == nil
    local bool2 = not (mapCheckUserPurchaseSettingsFailureReasonToViolationType(arg1.failureReason) == EconomicRestrictionsViolationType.None)
        and arg1.expirationTimeInMinutes ~= nil
    return not not (not bool1 or bool2)
end

local function initiateUserPurchaseSettingsPrecheck()
    return Thunk.new(script.Name, tbl1, function(arg1, arg2)
        local var1 = arg2[Network]
        local var2 = arg2[Analytics]
        local var3 = arg2[ExternalSettings]

        if var3.isStudio() or getUpsellFlow(var3.getPlatform()) == UpsellFlow.Web then
            return arg1:dispatch(initiatePurchasePrecheck())
        end

        return checkUserPurchaseSettings(var1):andThen(function(arg3)
            if validateResult(arg3) == false then
                return arg1:dispatch(ErrorOccurred(PurchaseError.UnknownFailure))
            end

            if arg3.isEligible == true then
                return arg1:dispatch(initiatePurchasePrecheck())
            end

            local var4 = mapCheckUserPurchaseSettingsFailureReasonToViolationType(arg3.failureReason)

            local bool1 = var4 ~= EconomicRestrictionsViolationType.None

            if arg3.failureReason == CheckUserPurchaseSettingsFailureReason.PurchaseNotEnabled then
                var2.signalUserSettingEligibilityModal("PurchaseNotEnabled")
                return arg1:dispatch(SetPromptState(PromptState.EnablePurchaseVPCModal))
            end

            if arg3.failureReason == CheckUserPurchaseSettingsFailureReason.SpendLimitExceeded then
                return arg1:dispatch(initiatePurchasePrecheck())
            end

            if not bool1 or arg3.expirationTimeInMinutes == nil then
                return arg1:dispatch(ErrorOccurred(PurchaseError.UnknownFailure))
            end

            var2.signalEconomicRestrictionError(var4, arg3.expirationTimeInMinutes)

            arg1:dispatch(SetEconomicRestrictionError(var4, arg3.expirationTimeInMinutes))

            return arg1:dispatch(ErrorOccurred(PurchaseError.EconomicRestriction))
        end):catch(function(_)
            return arg1:dispatch(ErrorOccurred(PurchaseError.UnknownFailure))
        end)
    end)
end

return initiateUserPurchaseSettingsPrecheck
