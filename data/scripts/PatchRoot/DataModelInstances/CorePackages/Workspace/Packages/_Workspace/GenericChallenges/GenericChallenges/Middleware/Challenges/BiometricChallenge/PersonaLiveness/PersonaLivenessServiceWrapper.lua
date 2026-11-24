-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T16:30:49Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GenericChallengesParent = script:FindFirstAncestor("GenericChallenges").Parent

local Promise = require(GenericChallengesParent.Promise)

local engineFeature = game:GetEngineFeature("FacialAgeEstimationServiceAvailable")
local FacialAgeEstimationService = if engineFeature then game:GetService("FacialAgeEstimationService") else nil

return {
    isAvailable = function()
        return engineFeature and FacialAgeEstimationService:IsAvailable()
    end,
    startFlow = function(inquiryId: string, sessionToken: string?)
        return Promise.new(function(callback, callback2)
            local success, result = pcall(function()
                return FacialAgeEstimationService:InquiryAsync({ inquiryId = inquiryId, sessionToken = sessionToken })
            end)

            if not success then
                callback2(result)
                return
            end

            local resultType = result.resultType

            if resultType == Enum.FacialAgeEstimationResultType.Complete then
                callback(inquiryId)
            elseif resultType == Enum.FacialAgeEstimationResultType.Cancel or resultType == Enum.FacialAgeEstimationResultType.Error then
                callback2({ resultType = resultType })
            end
        end)
    end
}
