-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T08:00:47Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function createCloudClientExperiment(ixpService, str1: string)
    return {
        isTreatment = function()
            if str1 == "" then
                return true
            end
            local success, result = pcall(function()
                return ixpService:GetUserLayerVariables(str1)
            end)

            return success and type(result) == "table" and result.EnableCloudClientOffer == true
        end,
        logExposure = function()
            if str1 == "" then
                return
            end
            pcall(function()
                ixpService:LogUserLayerExposure(str1)
            end)
        end
    }
end

return createCloudClientExperiment
