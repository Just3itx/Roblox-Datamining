-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T21:41:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local engineFeature = game:GetEngineFeature("FacialAgeEstimationServiceAvailable")
local FacialAgeEstimationService = if engineFeature then game:GetService("FacialAgeEstimationService") else nil
local AmpV2Wizard = script:FindFirstAncestor("AmpV2Wizard")
local AmpV2WizardParent = AmpV2Wizard.Parent

local Promise = require(AmpV2WizardParent.Promise)
local FFlagAmpV2WizardVerificationDiagnostics = require(AmpV2Wizard.FFlagAmpV2WizardVerificationDiagnostics)

return {
    isAvailable = function()
        return engineFeature and FacialAgeEstimationService:IsAvailable()
    end,
    startInquiry = function(inquiryId: string)
        return Promise.new(function(callback, callback2)
            local success, result = pcall(function()
                return FacialAgeEstimationService:InquiryAsync({ inquiryId = inquiryId })
            end)

            if not success then
                callback2(result)
                return
            end

            if FFlagAmpV2WizardVerificationDiagnostics then
                callback({ resultType = result.resultType, debugMessage = result.debugMessage })
            else
                callback(result.resultType)
            end
        end)
    end
}
